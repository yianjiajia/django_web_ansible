# coding=utf-8
from django import forms
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.core import serializers
from django.core.paginator import Paginator, InvalidPage, EmptyPage
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render, render_to_response
from django.template import RequestContext
from django.views.decorators.csrf import csrf_exempt

from devops.apps.gaga.models import FileServer, LinuxServer, NamePassword, Resource, ServerIp
from devops.lib.django_util import login_not_required
from devops.util.handle_uploaded_file import handle_uploaded_file
from models import User


# django表单系统
class UserForm(forms.Form):
    username = forms.CharField(max_length=100, label='用户名')
    password = forms.CharField(widget=forms.PasswordInput(), label='密码')


'''    def clean_password(self):
        password = self.cleaned_data['password']
        num_words = len(password.split())
        if num_words < 4:
            raise forms.ValidationError("Not enough words!")
        return message'''


class XuqiuForm(forms.Form):
    user = forms.CharField(max_length=20, label='您是')
    xuqiu = forms.Textarea()


class User_Password(forms.Form):
    ip = forms.CharField(max_length=20, label='IP地址')
    user = forms.CharField(max_length=20, label='用户名')
    password = forms.CharField(max_length=20, label='密码')


class UploadFileForm(forms.Form):
    file = forms.FileField()


# 注册
@login_not_required
def regist(req):
    if req.method == 'POST':
        uf = UserForm(req.POST)
        if uf.is_valid():
            # 获得表单数据
            username = uf.cleaned_data['username']
            password = uf.cleaned_data['password']
            # 添加到数据库
            User.objects.create(username=username, password=password)
            return HttpResponse('regist success!!')
    else:
        uf = UserForm()
    return render_to_response('newtem/reset-password.html', {'uf': uf}, context_instance=RequestContext(req))


# 提交需求
def postxuqiu(request):
    pass


# 登陆
@login_required
@csrf_exempt
def my_login(request):
    error = False
    if request.method == 'POST':  # 我们使用POST的方法来获取从HTML传递过来的表单内容
        username = request.POST['username']  # 获取账号和密码
        password = request.POST['password']
        #        uf = UserForm(request.POST)
        #        if uf.is_valid():
        # 获取表单用户密码
        #            username = uf.cleaned_data['username']
        #            password = uf.cleaned_data['password']
        # 获取的表单数据与数据库进行比较
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                # 比较成功，跳转到index
                response = HttpResponseRedirect('/index/')
                # 将username写入浏览器cookie,失效时间为3600
                response.set_cookie('username', username, 3600)
                return response
        else:
            # 比较失败，还在login
            error = True

            #    else:
            #       uf = UserForm()
    return render(request, 'newtem/sign-in.html', {'error': error})


# 首页
@login_required  # 验证是否登陆的装饰器
def index(request):
    #   localtime = time.strftime('%Y-%m-%d %H:%M', time.localtime(time.time()))
    username = request.COOKIES.get('username', '')
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            handle_uploaded_file(request.FILES['file'])
            return HttpResponseRedirect('/upload/')
    else:
        form = UploadFileForm()
    return render(request, 'newtem/index.html', {'username': username, 'form': form})


# 退出
def logout(req):
    response = HttpResponseRedirect('/')
    # 清理cookie里保存username
    response.delete_cookie('username')
    return response


# samba服务器管理
@login_required
def samba(request):
    username = request.COOKIES.get('username', '')
    #    if username:
    #        return HttpResponseRedirect('/')
    username = request.COOKIES.get('username', '')
    obj = LinuxServer.objects.all().order_by('id')
    return render_to_response('newtem/samba.html', {'username': username, 'obj': obj})


# 获取测试资源
@login_required
def testresource(request):
    #    fname = "c:\APP.xls"
    #    sheet = "Sheet1"
    #    a = execl.get_execl(fname, sheet)
    res = Resource.objects.all()
    #####ADD
    page_size = 8
    paginator = Paginator(res, page_size)
    try:
        page = int(request.GET.get('page', '1'))
    except ValueError:
        page = 1
        print page
    try:
        posts = paginator.page(page)
    except (EmptyPage, InvalidPage):
        posts = paginator.page(paginator.num_pages)
    username = request.COOKIES.get('username', '')
    return render_to_response('newtem/resource.html', {'list': posts, 'username': username, 'posts': posts})


# 修改表格数据
@login_required
def changetab(request, tab):
    if int(tab) == 2:
        #        fname = "c:\ip2.xls"
        #        sheet = "Sheet1"
        #        a = execl.get_execl(fname,sheet)
        server = ServerIp.objects.all()
        page_size = 24
        paginator = Paginator(server, page_size)
        try:
            page = int(request.GET.get('page', '1'))
        except ValueError:
            page = 1
            print page
        try:
            posts = paginator.page(page)
        except (EmptyPage, InvalidPage):
            posts = paginator.page(paginator.num_pages)
        return render_to_response('newtem/tab2.html', {'list': posts, 'posts': posts})
    else:
        a = NamePassword.objects.all()
        page_size = 8
        paginator = Paginator(a, page_size)
        try:
            page = int(request.GET.get('page', '1'))
        except ValueError:
            page = 1
            print page
        try:
            posts = paginator.page(page)
        except (EmptyPage, InvalidPage):
            posts = paginator.page(paginator.num_pages)
        return render_to_response('newtem/tab3.html', {'list': posts, 'posts': posts})


# ajax调用
@csrf_exempt
@login_required
def json_data(request):
    ob = FileServer.objects.all()
    data = serializers.serialize("json", ob)
    # ob = [{'disk_useage':1,'smb_status': 2,'raid_status':3,'test':4}, {'disk_useage':1,'smb_status': 2,'raid_status':3,'test':4}]
    #    jsondata = json.dumps(data)
    #    jsondata = ob.toJSON()
    return HttpResponse(data, content_type='application/json')


@csrf_exempt
@login_required
def upload(request):
    return render_to_response('newtem/upload.html')


# webSSH
@login_required
def term(request):
    return render_to_response('newtem/term.html')


# 知识库
@login_required
def wiki(request):
    username = request.COOKIES.get('username', '')
    return render_to_response('newtem/wiki.html', {'username': username})


# 未实现功能返回页
def noreal(request):
    html = '<html><head><title>某科技公司</title></head><body><center><h1>敬请期待!</h1></center></div></body></html>'
    return HttpResponse(html)


# web控制台
def webcontrol(request):
    username = request.COOKIES.get('username', '')
    return render_to_response('newtem/webcontrol.html', {'username': username})
