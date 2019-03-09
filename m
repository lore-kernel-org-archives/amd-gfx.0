From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Sat, 9 Mar 2019 08:54:12 +0200
Message-ID: <CAGyaPbCxMxG5kbu9RhrB0vSCDQL4zaNzsUqsoWVWmRVw8Mp7Pg@mail.gmail.com>
References: <CAGyaPbDo4-mJhCbL1gfjgek_Z54dyREydqZc-SF=cFVQ0URyYA@mail.gmail.com>
 <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000417c3b0583a3cf68"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--000000000000417c3b0583a3cf68
Content-Type: multipart/alternative; boundary="000000000000417c380583a3cf66"

--000000000000417c380583a3cf66
Content-Type: text/plain; charset="UTF-8"

Even if it's using CPU for OCL (I know it's not doing this), why does
memcpy on CPU slow down permanently, if I'm not doing anything with OpenCL
after clCreateContext?

As you see from test program it just does clCreateContext and then a loop
of memcpy-s on CPU.

Also I found out that writing different values to
/sys/class/drm/card0/device/power_dpm_force_performance_level changes my
max memcpy speed on CPU:

echo "low" > /sys/class/drm/card0/device/power_dpm_force_performance_level
./cl_slow_test 1 5
got 1 platforms 1 devices
speed 731.810425 avg 731.810425 mbytes/s
speed 163.425583 avg 447.618011 mbytes/s
speed 123.441612 avg 339.559235 mbytes/s
speed 121.655266 avg 285.083252 mbytes/s
speed 123.806801 avg 252.827972 mbytes/s

echo "high" > /sys/class/drm/card0/device/power_dpm_force_performance_level
./cl_slow_test 1 5
got 1 platforms 1 devices
speed 3742.063721 avg 3742.063721 mbytes/s
speed 836.148987 avg 2289.106445 mbytes/s
speed 189.379166 avg 1589.197266 mbytes/s
speed 189.271393 avg 1239.215820 mbytes/s
speed 188.290451 avg 1029.030762 mbytes/s

echo "profile_standard" >
/sys/class/drm/card0/device/power_dpm_force_performance_level
./cl_slow_test 1 5
got 1 platforms 1 devices
speed 2303.955566 avg 2303.955566 mbytes/s
speed 2298.224121 avg 2301.089844 mbytes/s
speed 2295.585205 avg 2299.254883 mbytes/s
speed 2295.762939 avg 2298.381836 mbytes/s
speed 2288.766602 avg 2296.458740 mbytes/s

 echo "profile_peak" >
/sys/class/drm/card0/device/power_dpm_force_performance_level
./cl_slow_test 1 5
got 1 platforms 1 devices
speed 3710.360352 avg 3710.360352 mbytes/s
speed 3713.660400 avg 3712.010254 mbytes/s
speed 3797.630859 avg 3740.550537 mbytes/s
speed 3708.004883 avg 3732.414062 mbytes/s
speed 3796.403076 avg 3745.211914 mbytes/s

However none of those is close to the memcpy speed I get when I don't do
clCreateContext (my test prog has first arg 0):
./cl_slow_test 0 5
speed 7299.201660 avg 7299.201660 mbytes/s
speed 9298.841797 avg 8299.021484 mbytes/s
speed 9360.181641 avg 8652.742188 mbytes/s
speed 9004.759766 avg 8740.746094 mbytes/s
speed 9414.607422 avg 8875.518555 mbytes/s

Also attached clinfo.txt. It shows that opencl is using GPU so device node
permissions are probably not the issue.

--
Lauri

On Fri, Mar 8, 2019 at 10:35 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I think you are probably using the CPU for OCL in the remote login
> case.  When you log into the desktop, the permissions on the device
> nodes get changed dynamically to support accelerated rendering.  You
> probably need to change the permissions on the device nodes manually
> if you are not logging into the desktop.
>
> Alex
>
> On Fri, Mar 8, 2019 at 2:43 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > Hi!
> >
> > I am using Ryzen 2400G with Gigabyte AMD B450 AORUS board. I have latest
> bios, ubuntu 18.04 and latest mainline kernel (5.0.0-050000-generic)
> installed. Also I have rocm-dev 2.1.96 but no rock-dkms installed.
> >
> > I found that when I log in over ssh and try to use OpenCL (doing
> clCreateContext is enough) then cpu memory accesses after that will slow
> down by 100x.
> > If I connect HDMI cable and log in to desktop mode then this does not
> happen. Also if I don't call clCreateContext then everything works properly.
> >
> > Attached the test program and kernel log also. Test works like that :
> > g++ cl_slow_test.cpp -o cl_slow_test -I /opt/rocm/opencl/include/ -L
> /opt/rocm/opencl/lib/x86_64/  -lOpenCL
> > lauri@rv:~$ ./cl_slow_test 0 5
> > speed 7003.145508 avg 7003.145508 mbytes/s
> > speed 8427.357422 avg 7715.251465 mbytes/s
> > speed 9203.049805 avg 8211.184570 mbytes/s
> > speed 9845.956055 avg 8619.877930 mbytes/s
> > speed 9882.748047 avg 8872.452148 mbytes/s
> > lauri@rv:~$ ./cl_slow_test 1 5
> > got 1 platforms 1 devices
> > speed 1599.803589 avg 1599.803589 mbytes/s
> > speed 1665.426392 avg 1632.614990 mbytes/s
> > speed 146.137253 avg 1137.122437 mbytes/s
> > speed 121.056877 avg 883.106018 mbytes/s
> > speed 122.428970 avg 730.970581 mbytes/s
> >
> > I also tried latest amd-staging kernel
> https://github.com/M-Bab/linux-kernel-amdgpu-binaries and it had the same
> issue.
> >
> > Can anyone point me into right direction?
> >
> > Br,
> > Lauri
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000417c380583a3cf66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Even if it&#39;s using CPU for OCL (I know it&#39;s not do=
ing this), why does memcpy on CPU slow down permanently, if I&#39;m not doi=
ng anything with OpenCL after clCreateContext?<div><br></div><div>As you se=
e from test program it just does clCreateContext and then a loop of memcpy-=
s on CPU.</div><div><br></div><div><div dir=3D"ltr">Also I found out that w=
riting different values to /sys/class/drm/card0/device/power_dpm_force_perf=
ormance_level changes my max memcpy speed on CPU:</div><div dir=3D"ltr"><br=
></div><div dir=3D"ltr">echo &quot;low&quot; &gt; /sys/class/drm/card0/devi=
ce/power_dpm_force_performance_level</div><span class=3D"gmail-im" style=3D=
"color:rgb(80,0,80)"><div dir=3D"ltr">./cl_slow_test 1 5</div><div dir=3D"l=
tr">got 1 platforms 1 devices</div></span><div dir=3D"ltr">speed 731.810425=
 avg 731.810425 mbytes/s</div><div dir=3D"ltr">speed 163.425583 avg 447.618=
011 mbytes/s</div><div dir=3D"ltr">speed 123.441612 avg 339.559235 mbytes/s=
</div><div dir=3D"ltr">speed 121.655266 avg 285.083252 mbytes/s</div><div d=
ir=3D"ltr">speed 123.806801 avg 252.827972 mbytes/s</div><div dir=3D"ltr"><=
br></div><div dir=3D"ltr"><div dir=3D"ltr">echo &quot;high&quot; &gt; /sys/=
class/drm/card0/device/power_dpm_force_performance_level</div></div><span c=
lass=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div dir=3D"ltr">./cl_slow_t=
est 1 5</div><div dir=3D"ltr">got 1 platforms 1 devices</div></span><div di=
r=3D"ltr">speed 3742.063721 avg 3742.063721 mbytes/s</div><div dir=3D"ltr">=
speed 836.148987 avg 2289.106445 mbytes/s</div><div dir=3D"ltr">speed 189.3=
79166 avg 1589.197266 mbytes/s</div><div dir=3D"ltr">speed 189.271393 avg 1=
239.215820 mbytes/s</div><div dir=3D"ltr">speed 188.290451 avg 1029.030762 =
mbytes/s</div><div><br></div><div>echo &quot;profile_standard&quot; &gt; /s=
ys/class/drm/card0/device/power_dpm_force_performance_level<br></div><div><=
span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>./cl_slow_test 1 =
5</div><div>got 1 platforms 1 devices</div></span><div>speed 2303.955566 av=
g 2303.955566 mbytes/s</div><div>speed 2298.224121 avg 2301.089844 mbytes/s=
</div><div>speed 2295.585205 avg 2299.254883 mbytes/s</div><div>speed 2295.=
762939 avg 2298.381836 mbytes/s</div><div>speed 2288.766602 avg 2296.458740=
 mbytes/s</div></div><div><br></div><div>=C2=A0echo &quot;profile_peak&quot=
; &gt; /sys/class/drm/card0/device/power_dpm_force_performance_level<br></d=
iv><div><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>./cl_slo=
w_test 1 5</div><div>got 1 platforms 1 devices</div></span><div>speed 3710.=
360352 avg 3710.360352 mbytes/s</div><div>speed 3713.660400 avg 3712.010254=
 mbytes/s</div><div>speed 3797.630859 avg 3740.550537 mbytes/s</div><div>sp=
eed 3708.004883 avg 3732.414062 mbytes/s</div><div>speed 3796.403076 avg 37=
45.211914 mbytes/s</div></div><div><br></div><div>However none of those is =
close to the memcpy speed I get when I don&#39;t do clCreateContext (my tes=
t prog has first arg 0):</div><div><div>./cl_slow_test 0 5</div><div>speed =
7299.201660 avg 7299.201660 mbytes/s</div><div>speed 9298.841797 avg 8299.0=
21484 mbytes/s</div><div>speed 9360.181641 avg 8652.742188 mbytes/s</div><d=
iv>speed 9004.759766 avg 8740.746094 mbytes/s</div><div>speed 9414.607422 a=
vg 8875.518555 mbytes/s</div></div></div><div><br></div><div>Also attached =
clinfo.txt. It shows that opencl is using GPU so device node permissions ar=
e probably not the issue.=C2=A0</div><div><br></div><div>--</div><div>Lauri=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Fri, Mar 8, 2019 at 10:35 PM Alex Deucher &lt;<a href=3D"mailto:al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">I think you are probably using th=
e CPU for OCL in the remote login<br>
case.=C2=A0 When you log into the desktop, the permissions on the device<br=
>
nodes get changed dynamically to support accelerated rendering.=C2=A0 You<b=
r>
probably need to change the permissions on the device nodes manually<br>
if you are not logging into the desktop.<br>
<br>
Alex<br>
<br>
On Fri, Mar 8, 2019 at 2:43 PM Lauri Ehrenpreis &lt;<a href=3D"mailto:lauri=
oma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi!<br>
&gt;<br>
&gt; I am using Ryzen 2400G with Gigabyte AMD B450 AORUS board. I have late=
st bios, ubuntu 18.04 and latest mainline kernel (5.0.0-050000-generic) ins=
talled. Also I have rocm-dev 2.1.96 but no rock-dkms installed.<br>
&gt;<br>
&gt; I found that when I log in over ssh and try to use OpenCL (doing clCre=
ateContext is enough) then cpu memory accesses after that will slow down by=
 100x.<br>
&gt; If I connect HDMI cable and log in to desktop mode then this does not =
happen. Also if I don&#39;t call clCreateContext then everything works prop=
erly.<br>
&gt;<br>
&gt; Attached the test program and kernel log also. Test works like that :<=
br>
&gt; g++ cl_slow_test.cpp -o cl_slow_test -I /opt/rocm/opencl/include/ -L /=
opt/rocm/opencl/lib/x86_64/=C2=A0 -lOpenCL<br>
&gt; lauri@rv:~$ ./cl_slow_test 0 5<br>
&gt; speed 7003.145508 avg 7003.145508 mbytes/s<br>
&gt; speed 8427.357422 avg 7715.251465 mbytes/s<br>
&gt; speed 9203.049805 avg 8211.184570 mbytes/s<br>
&gt; speed 9845.956055 avg 8619.877930 mbytes/s<br>
&gt; speed 9882.748047 avg 8872.452148 mbytes/s<br>
&gt; lauri@rv:~$ ./cl_slow_test 1 5<br>
&gt; got 1 platforms 1 devices<br>
&gt; speed 1599.803589 avg 1599.803589 mbytes/s<br>
&gt; speed 1665.426392 avg 1632.614990 mbytes/s<br>
&gt; speed 146.137253 avg 1137.122437 mbytes/s<br>
&gt; speed 121.056877 avg 883.106018 mbytes/s<br>
&gt; speed 122.428970 avg 730.970581 mbytes/s<br>
&gt;<br>
&gt; I also tried latest amd-staging kernel <a href=3D"https://github.com/M=
-Bab/linux-kernel-amdgpu-binaries" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/M-Bab/linux-kernel-amdgpu-binaries</a> and it had the same =
issue.<br>
&gt;<br>
&gt; Can anyone point me into right direction?<br>
&gt;<br>
&gt; Br,<br>
&gt; Lauri<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000417c380583a3cf66--

--000000000000417c3b0583a3cf68
Content-Type: text/plain; charset="US-ASCII"; name="clinfo.txt"
Content-Disposition: attachment; filename="clinfo.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_jt14s8jn0>
X-Attachment-Id: f_jt14s8jn0

TnVtYmVyIG9mIHBsYXRmb3JtcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxCiAgUGxh
dGZvcm0gTmFtZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1EIEFjY2VsZXJh
dGVkIFBhcmFsbGVsIFByb2Nlc3NpbmcKICBQbGF0Zm9ybSBWZW5kb3IgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuCiAgUGxhdGZvcm0g
VmVyc2lvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT3BlbkNMIDIuMSBBTUQtQVBQ
ICgyODE0LjApCiAgUGxhdGZvcm0gUHJvZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRlVMTF9QUk9GSUxFCiAgUGxhdGZvcm0gRXh0ZW5zaW9ucyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY2xfa2hyX2ljZCBjbF9hbWRfZXZlbnRfY2FsbGJhY2sgY2xfYW1kX29mZmxpbmVf
ZGV2aWNlcyAKICBQbGF0Zm9ybSBIb3N0IHRpbWVyIHJlc29sdXRpb24gICAgICAgICAgICAgICAg
ICAxbnMKICBQbGF0Zm9ybSBFeHRlbnNpb25zIGZ1bmN0aW9uIHN1ZmZpeCAgICAgICAgICAgICBB
TUQKCiAgUGxhdGZvcm0gTmFtZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1E
IEFjY2VsZXJhdGVkIFBhcmFsbGVsIFByb2Nlc3NpbmcKTnVtYmVyIG9mIGRldmljZXMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAxCiAgRGV2aWNlIE5hbWUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ2Z4OTAyLXhuYWNrCiAgRGV2aWNlIFZlbmRvciAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgog
IERldmljZSBWZW5kb3IgSUQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MTAwMgog
IERldmljZSBWZXJzaW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9wZW5DTCAx
LjIgCiAgRHJpdmVyIFZlcnNpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjgx
NC4wIChIU0ExLjEsTEMpCiAgRGV2aWNlIE9wZW5DTCBDIFZlcnNpb24gICAgICAgICAgICAgICAg
ICAgICAgICAgT3BlbkNMIEMgMi4wIAogIERldmljZSBUeXBlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdQVQogIERldmljZSBCb2FyZCBOYW1lIChBTUQpICAgICAgICAgICAg
ICAgICAgICAgICAgIEFNRCBSeXplbiA1IDI0MDBHIHdpdGggUmFkZW9uIFZlZ2EgR3JhcGhpY3MK
ICBEZXZpY2UgVG9wb2xvZ3kgKEFNRCkgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0ktRSwg
MGI6MDAuMAogIERldmljZSBQcm9maWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEZVTExfUFJPRklMRQogIERldmljZSBBdmFpbGFibGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFllcwogIENvbXBpbGVyIEF2YWlsYWJsZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFllcwogIExpbmtlciBBdmFpbGFibGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFllcwogIE1heCBjb21wdXRlIHVuaXRzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEx
CiAgU0lNRCBwZXIgY29tcHV0ZSB1bml0IChBTUQpICAgICAgICAgICAgICAgICAgICAgNAogIFNJ
TUQgd2lkdGggKEFNRCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE2CiAgU0lNRCBp
bnN0cnVjdGlvbiB3aWR0aCAoQU1EKSAgICAgICAgICAgICAgICAgICAgMQogIE1heCBjbG9jayBm
cmVxdWVuY3kgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyNTBNSHoKICBHcmFwaGljcyBJ
UCAoQU1EKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjIKICBEZXZpY2UgUGFydGl0
aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY29yZSkKICAgIE1heCBudW1iZXIg
b2Ygc3ViLWRldmljZXMgICAgICAgICAgICAgICAgICAgICAxMQogICAgU3VwcG9ydGVkIHBhcnRp
dGlvbiB0eXBlcyAgICAgICAgICAgICAgICAgICAgIE5vbmUKICBNYXggd29yayBpdGVtIGRpbWVu
c2lvbnMgICAgICAgICAgICAgICAgICAgICAgICAzCiAgTWF4IHdvcmsgaXRlbSBzaXplcyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMTAyNHgxMDI0eDEwMjQKICBNYXggd29yayBncm91cCBz
aXplICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyNTYKICBQcmVmZXJyZWQgd29yayBncm91
cCBzaXplIChBTUQpICAgICAgICAgICAgICAgICAyNTYKICBNYXggd29yayBncm91cCBzaXplIChB
TUQpICAgICAgICAgICAgICAgICAgICAgICAxMDI0CiAgUHJlZmVycmVkIHdvcmsgZ3JvdXAgc2l6
ZSBtdWx0aXBsZSAgICAgICAgICAgICAgNjQKICBXYXZlZnJvbnQgd2lkdGggKEFNRCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICA2NAogIFByZWZlcnJlZCAvIG5hdGl2ZSB2ZWN0b3Igc2l6ZXMg
ICAgICAgICAgICAgICAgIAogICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA0IC8gNCAgICAgICAKICAgIHNob3J0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAvIDIgICAgICAgCiAgICBpbnQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgLyAxICAgICAgIAog
ICAgbG9uZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAx
IC8gMSAgICAgICAKICAgIGhhbGYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMSAvIDEgICAgICAgIChjbF9raHJfZnAxNikKICAgIGZsb2F0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAvIDEgICAgICAgCiAgICBk
b3VibGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgLyAx
ICAgICAgICAoY2xfa2hyX2ZwNjQpCiAgSGFsZi1wcmVjaXNpb24gRmxvYXRpbmctcG9pbnQgc3Vw
cG9ydCAgICAgICAgICAgKGNsX2tocl9mcDE2KQogICAgRGVub3JtYWxzICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5vCiAgICBJbmZpbml0eSBhbmQgTkFOcyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KICAgIFJvdW5kIHRvIG5lYXJlc3QgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBObwogICAgUm91bmQgdG8gemVybyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE5vCiAgICBSb3VuZCB0byBpbmZpbml0eSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTm8KICAgIElFRUU3NTQtMjAwOCBmdXNlZCBtdWx0aXBseS1hZGQgICAgICAgICAgICAg
ICBObwogICAgU3VwcG9ydCBpcyBlbXVsYXRlZCBpbiBzb2Z0d2FyZSAgICAgICAgICAgICAgIE5v
CiAgU2luZ2xlLXByZWNpc2lvbiBGbG9hdGluZy1wb2ludCBzdXBwb3J0ICAgICAgICAgKGNvcmUp
CiAgICBEZW5vcm1hbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAg
ICBJbmZpbml0eSBhbmQgTkFOcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBS
b3VuZCB0byBuZWFyZXN0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBSb3Vu
ZCB0byB6ZXJvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBSb3VuZCB0
byBpbmZpbml0eSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBJRUVFNzU0LTIw
MDggZnVzZWQgbXVsdGlwbHktYWRkICAgICAgICAgICAgICAgWWVzCiAgICBTdXBwb3J0IGlzIGVt
dWxhdGVkIGluIHNvZnR3YXJlICAgICAgICAgICAgICAgTm8KICAgIENvcnJlY3RseS1yb3VuZGVk
IGRpdmlkZSBhbmQgc3FydCBvcGVyYXRpb25zICBZZXMKICBEb3VibGUtcHJlY2lzaW9uIEZsb2F0
aW5nLXBvaW50IHN1cHBvcnQgICAgICAgICAoY2xfa2hyX2ZwNjQpCiAgICBEZW5vcm1hbHMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBJbmZpbml0eSBhbmQgTkFO
cyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBSb3VuZCB0byBuZWFyZXN0ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBSb3VuZCB0byB6ZXJvICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBSb3VuZCB0byBpbmZpbml0eSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBJRUVFNzU0LTIwMDggZnVzZWQgbXVsdGlwbHkt
YWRkICAgICAgICAgICAgICAgWWVzCiAgICBTdXBwb3J0IGlzIGVtdWxhdGVkIGluIHNvZnR3YXJl
ICAgICAgICAgICAgICAgTm8KICBBZGRyZXNzIGJpdHMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA2NCwgTGl0dGxlLUVuZGlhbgogIEdsb2JhbCBtZW1vcnkgc2l6ZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDMxMjkwNDcwNDAgKDIuOTE0R2lCKQogIEdsb2JhbCBmcmVl
IG1lbW9yeSAoQU1EKSAgICAgICAgICAgICAgICAgICAgICAgIDMwNTU3MTAgKDIuOTE0R2lCKQog
IEdsb2JhbCBtZW1vcnkgY2hhbm5lbHMgKEFNRCkgICAgICAgICAgICAgICAgICAgIDIKICBHbG9i
YWwgbWVtb3J5IGJhbmtzIHBlciBjaGFubmVsIChBTUQpICAgICAgICAgICA0CiAgR2xvYmFsIG1l
bW9yeSBiYW5rIHdpZHRoIChBTUQpICAgICAgICAgICAgICAgICAgMjU2IGJ5dGVzCiAgRXJyb3Ig
Q29ycmVjdGlvbiBzdXBwb3J0ICAgICAgICAgICAgICAgICAgICAgICAgTm8KICBNYXggbWVtb3J5
IGFsbG9jYXRpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAyNjU5Njg5OTg0ICgyLjQ3N0dp
QikKICBVbmlmaWVkIG1lbW9yeSBmb3IgSG9zdCBhbmQgRGV2aWNlICAgICAgICAgICAgICBZZXMK
ICBNaW5pbXVtIGFsaWdubWVudCBmb3IgYW55IGRhdGEgdHlwZSAgICAgICAgICAgICAxMjggYnl0
ZXMKICBBbGlnbm1lbnQgb2YgYmFzZSBhZGRyZXNzICAgICAgICAgICAgICAgICAgICAgICAxMDI0
IGJpdHMgKDEyOCBieXRlcykKICBHbG9iYWwgTWVtb3J5IGNhY2hlIHR5cGUgICAgICAgICAgICAg
ICAgICAgICAgICBSZWFkL1dyaXRlCiAgR2xvYmFsIE1lbW9yeSBjYWNoZSBzaXplICAgICAgICAg
ICAgICAgICAgICAgICAgMTYzODQgKDE2S2lCKQogIEdsb2JhbCBNZW1vcnkgY2FjaGUgbGluZSBz
aXplICAgICAgICAgICAgICAgICAgIDY0IGJ5dGVzCiAgSW1hZ2Ugc3VwcG9ydCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgWWVzCiAgICBNYXggbnVtYmVyIG9mIHNhbXBsZXJzIHBl
ciBrZXJuZWwgICAgICAgICAgICAgNTU5NwogICAgTWF4IHNpemUgZm9yIDFEIGltYWdlcyBmcm9t
IGJ1ZmZlciAgICAgICAgICAgIDY1NTM2IHBpeGVscwogICAgTWF4IDFEIG9yIDJEIGltYWdlIGFy
cmF5IHNpemUgICAgICAgICAgICAgICAgIDIwNDggaW1hZ2VzCiAgICBNYXggMkQgaW1hZ2Ugc2l6
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTYzODR4MTYzODQgcGl4ZWxzCiAgICBNYXgg
M0QgaW1hZ2Ugc2l6ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMjA0OHgyMDQ4eDIwNDgg
cGl4ZWxzCiAgICBNYXggbnVtYmVyIG9mIHJlYWQgaW1hZ2UgYXJncyAgICAgICAgICAgICAgICAg
MTI4CiAgICBNYXggbnVtYmVyIG9mIHdyaXRlIGltYWdlIGFyZ3MgICAgICAgICAgICAgICAgOAog
IExvY2FsIG1lbW9yeSB0eXBlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIExvY2FsCiAg
TG9jYWwgbWVtb3J5IHNpemUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNjU1MzYgKDY0
S2lCKQogIExvY2FsIG1lbW9yeSBzeXplIHBlciBDVSAoQU1EKSAgICAgICAgICAgICAgICAgIDY1
NTM2ICg2NEtpQikKICBMb2NhbCBtZW1vcnkgYmFua3MgKEFNRCkgICAgICAgICAgICAgICAgICAg
ICAgICAzMgogIE1heCBudW1iZXIgb2YgY29uc3RhbnQgYXJncyAgICAgICAgICAgICAgICAgICAg
IDgKICBNYXggY29uc3RhbnQgYnVmZmVyIHNpemUgICAgICAgICAgICAgICAgICAgICAgICAyNjU5
Njg5OTg0ICgyLjQ3N0dpQikKICBQcmVmZXJyZWQgY29uc3RhbnQgYnVmZmVyIHNpemUgKEFNRCkg
ICAgICAgICAgICAxNjM4NCAoMTZLaUIpCiAgTWF4IHNpemUgb2Yga2VybmVsIGFyZ3VtZW50ICAg
ICAgICAgICAgICAgICAgICAgMTAyNAogIFF1ZXVlIHByb3BlcnRpZXMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgT3V0LW9mLW9yZGVyIGV4ZWN1dGlvbiAgICAgICAgICAgICAg
ICAgICAgICAgIE5vCiAgICBQcm9maWxpbmcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgWWVzCiAgUHJlZmVyIHVzZXIgc3luYyBmb3IgaW50ZXJvcCAgICAgICAgICAgICAgICAg
ICAgWWVzCiAgTnVtYmVyIG9mIFAyUCBkZXZpY2VzIChBTUQpICAgICAgICAgICAgICAgICAgICAg
MAogIFAyUCBkZXZpY2VzIChBTUQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogIFBy
b2ZpbGluZyB0aW1lciByZXNvbHV0aW9uICAgICAgICAgICAgICAgICAgICAgIDFucwogIFByb2Zp
bGluZyB0aW1lciBvZmZzZXQgc2luY2UgRXBvY2ggKEFNRCkgICAgICAgIDBucyAoVGh1IEphbiAg
MSAwMzowMDowMCAxOTcwKQogIEV4ZWN1dGlvbiBjYXBhYmlsaXRpZXMgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgUnVuIE9wZW5DTCBrZXJuZWxzICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFllcwogICAgUnVuIG5hdGl2ZSBrZXJuZWxzICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE5vCiAgICBUaHJlYWQgdHJhY2Ugc3VwcG9ydGVkIChBTUQpICAgICAgICAgICAgICAgICAgTm8K
ICAgIE51bWJlciBvZiBhc3luYyBxdWV1ZXMgKEFNRCkgICAgICAgICAgICAgICAgICA4CiAgICBN
YXggcmVhbC10aW1lIGNvbXB1dGUgcXVldWVzIChBTUQpICAgICAgICAgICAgOAogICAgTWF4IHJl
YWwtdGltZSBjb21wdXRlIHVuaXRzIChBTUQpICAgICAgICAgICAgIDExCiAgcHJpbnRmKCkgYnVm
ZmVyIHNpemUgICAgICAgICAgICAgICAgICAgICAgICAgICAgNDE5NDMwNCAoNE1pQikKICBCdWls
dC1pbiBrZXJuZWxzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICBEZXZpY2UgRXh0
ZW5zaW9ucyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbF9raHJfZnA2NCBjbF9raHJf
Z2xvYmFsX2ludDMyX2Jhc2VfYXRvbWljcyBjbF9raHJfZ2xvYmFsX2ludDMyX2V4dGVuZGVkX2F0
b21pY3MgY2xfa2hyX2xvY2FsX2ludDMyX2Jhc2VfYXRvbWljcyBjbF9raHJfbG9jYWxfaW50MzJf
ZXh0ZW5kZWRfYXRvbWljcyBjbF9raHJfaW50NjRfYmFzZV9hdG9taWNzIGNsX2tocl9pbnQ2NF9l
eHRlbmRlZF9hdG9taWNzIGNsX2tocl8zZF9pbWFnZV93cml0ZXMgY2xfa2hyX2J5dGVfYWRkcmVz
c2FibGVfc3RvcmUgY2xfa2hyX2ZwMTYgY2xfa2hyX2dsX3NoYXJpbmcgY2xfYW1kX2RldmljZV9h
dHRyaWJ1dGVfcXVlcnkgY2xfYW1kX21lZGlhX29wcyBjbF9hbWRfbWVkaWFfb3BzMiBjbF9raHJf
c3ViZ3JvdXBzIGNsX2tocl9kZXB0aF9pbWFnZXMgY2xfYW1kX2NvcHlfYnVmZmVyX3AycCBjbF9h
bWRfYXNzZW1ibHlfcHJvZ3JhbSAKCk5VTEwgcGxhdGZvcm0gYmVoYXZpb3IKICBjbEdldFBsYXRm
b3JtSW5mbyhOVUxMLCBDTF9QTEFURk9STV9OQU1FLCAuLi4pICBObyBwbGF0Zm9ybQogIGNsR2V0
RGV2aWNlSURzKE5VTEwsIENMX0RFVklDRV9UWVBFX0FMTCwgLi4uKSAgIE5vIHBsYXRmb3JtCiAg
Y2xDcmVhdGVDb250ZXh0KE5VTEwsIC4uLikgW2RlZmF1bHRdICAgICAgICAgICAgTm8gcGxhdGZv
cm0KICBjbENyZWF0ZUNvbnRleHQoTlVMTCwgLi4uKSBbb3RoZXJdICAgICAgICAgICAgICBTdWNj
ZXNzIFtBTURdCiAgY2xDcmVhdGVDb250ZXh0RnJvbVR5cGUoTlVMTCwgQ0xfREVWSUNFX1RZUEVf
REVGQVVMVCkgIFN1Y2Nlc3MgKDEpCiAgICBQbGF0Zm9ybSBOYW1lICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQU1EIEFjY2VsZXJhdGVkIFBhcmFsbGVsIFByb2Nlc3NpbmcKICAgIERl
dmljZSBOYW1lICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZng5MDIteG5hY2sK
ICBjbENyZWF0ZUNvbnRleHRGcm9tVHlwZShOVUxMLCBDTF9ERVZJQ0VfVFlQRV9DUFUpICBObyBk
ZXZpY2VzIGZvdW5kIGluIHBsYXRmb3JtCiAgY2xDcmVhdGVDb250ZXh0RnJvbVR5cGUoTlVMTCwg
Q0xfREVWSUNFX1RZUEVfR1BVKSAgU3VjY2VzcyAoMSkKICAgIFBsYXRmb3JtIE5hbWUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBBTUQgQWNjZWxlcmF0ZWQgUGFyYWxsZWwgUHJvY2Vz
c2luZwogICAgRGV2aWNlIE5hbWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdm
eDkwMi14bmFjawogIGNsQ3JlYXRlQ29udGV4dEZyb21UeXBlKE5VTEwsIENMX0RFVklDRV9UWVBF
X0FDQ0VMRVJBVE9SKSAgTm8gZGV2aWNlcyBmb3VuZCBpbiBwbGF0Zm9ybQogIGNsQ3JlYXRlQ29u
dGV4dEZyb21UeXBlKE5VTEwsIENMX0RFVklDRV9UWVBFX0NVU1RPTSkgIE5vIGRldmljZXMgZm91
bmQgaW4gcGxhdGZvcm0KICBjbENyZWF0ZUNvbnRleHRGcm9tVHlwZShOVUxMLCBDTF9ERVZJQ0Vf
VFlQRV9BTEwpICBTdWNjZXNzICgxKQogICAgUGxhdGZvcm0gTmFtZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFNRCBBY2NlbGVyYXRlZCBQYXJhbGxlbCBQcm9jZXNzaW5nCiAgICBE
ZXZpY2UgTmFtZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2Z4OTAyLXhuYWNr
Cg==
--000000000000417c3b0583a3cf68
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--000000000000417c3b0583a3cf68--
