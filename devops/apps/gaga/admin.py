from django.contrib import admin
from models import User, FileServer, NamePassword, LinuxServer, Resource


class AuthorAdmin(admin.ModelAdmin):
    list_display = ('username', 'password', 'email')
    search_fields = ('username', 'email')


class userageAdmin(admin.ModelAdmin):
    list_display = ('disk_useage', 'smb_status', 'raid_status')


class serverAdmin(admin.ModelAdmin):
    list_display = ('IP', 'username', 'password')


class linux_ssh(admin.ModelAdmin):
    list_display = ('serverip', 'mingcheng', 'leixing', 'version')


class execl_to_db(admin.ModelAdmin):
    list_display = ('leixin', 'banben', 'ip', 'username', 'password', 'beizhu', 'tester', 'rd')


# Register your models here.
admin.site.register(User, AuthorAdmin)
admin.site.register(FileServer, userageAdmin)
admin.site.register(NamePassword, serverAdmin)
admin.site.register(LinuxServer, linux_ssh)
admin.site.register(Resource, execl_to_db)
