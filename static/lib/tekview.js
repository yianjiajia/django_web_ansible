//上传execl弹出提示框 
function f1(){
 var tab1=document.getElementById("tab1");
 var tab2=document.getElementById("tab2");type="text/javascript"

 tab1.style.display=(tab1.style.display=="none"?"":"none");
 tab2.style.display=(tab2.style.display=="none"?"":"none");
}
$(document).ready(function(){
    $("#anniu").click(function(){
	alert("请上传Execl文件");
    });
	});
 
//文件服务器监控数据图表 
var samba=function () {
    var i = 1,chart;

    $('#container-test').highcharts({
        subtitle: {
            text: 'Subtitle'
        },

        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },

        series: [{
            data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
        }

        ]

    });
    chart = $('#container-test').highcharts();

    $("button.change").click(function(){
    	var index = $(this).attr("index");

      if(index == "title") {
      	chart.setTitle( {text: 'New title '+ i++ });// 更新标题的文字
      }

      else if(index == "title2") {
          chart.setTitle(
          	{ style: { color: 'red' }},	// 更新标题的颜色
          	{ style: { color: '#760000' }}	// 更新副标题的颜色
      		);

      }else if(index == "subtitle") {
          chart.setTitle(null, { text: 'New title '+ i++ });

      } else {
      	// 标题包含HTML标签
        chart.setTitle({ text: "<a href='http://www.hcharts.cn'>Highcharts中文网</a>",useHTML:true });
      }
    });

};

//首页显示北京时间
function startTime()
    {
    var today=new Date()
    document.getElementById('txt').innerHTML=today.toLocaleString( )
    setTimeout('startTime()',500)
    };

 

//首页显示文件服务器监控数据图表，实现ajax异步请求
var get_data=function(){
    var options;
       options={
        title: {
            text: '文件服务器监控数据',
            x: -20 //center
        },
        subtitle: {
            text: '某公司',
            x: -20
        },
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        yAxis: {
            title: {
                text: '百分比(%)',

            },min: 0,
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '%'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: '磁盘使用率',
            //data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6] 测试数据
        }, {
            name: '内存使用率',
            //data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5] 测试数据
        }, {
            name: 'CPU使用率',
            //data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0] 测试数据
        }, {
            name: '带宽使用率',
            //data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8] 测试数据
        }]
    };
 $.ajax({
            url: "json/",
            dataType: "json",
            type:"post",
            success: function(data) {
                //init series arays
                disk_arr = [];
                cpu_arr = [];
                mem_arr = [];
                //net_arr = [];

                for (i in data) {
                    //build
                    var t =0;
                    var r = data[i];
                    disk_arr.push([Number(r.fields.smb_status)]);
                    cpu_arr.push([Number(r.fields.disk_useage)]);
                    mem_arr.push([Number(r.fields.raid_status)]);
                    //net_arr.push([r.fields.test]);
                  
                }
                //save series
                options.series[0].data = disk_arr;
                options.series[1].data = cpu_arr;
                options.series[2].data = mem_arr;
                //options.series[3].data = net_arr;



                var chart = $('#container-test').highcharts(options);
            },
            cache: false
        });
};
function webSSH() {
        // Initialize Gate One:
		var tds=$("table td:eq(1)");
		var trs=$("table tr");
		var indexip=trs.index(this);
        var ip=tds.eq(indexip).text();
    	GateOne.init({url:'https://192.168.6.63', autoConnectURL:'ssh://root@'+ip
            //embedded: True,
            // Let's apply some custom styles while we're at it...
            //style: {'background-color': 'yellowgreen', 'box-shadow': '0 0 40px blueViolet'}
            // Oh yeah, that's the way to style a terminal!
        });
    }
