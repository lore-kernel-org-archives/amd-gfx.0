From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Sun, 10 Mar 2019 21:13:21 +0200
Message-ID: <CAGyaPbDGq5Z+J+c_s99vBjSUttKwsBNv+EMvdjg0aXjY52qT-g@mail.gmail.com>
References: <CAGyaPbDo4-mJhCbL1gfjgek_Z54dyREydqZc-SF=cFVQ0URyYA@mail.gmail.com>
 <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw@mail.gmail.com>
 <CAGyaPbCxMxG5kbu9RhrB0vSCDQL4zaNzsUqsoWVWmRVw8Mp7Pg@mail.gmail.com>
 <CABE_ZV0MV+=9=sE2ddK6hGzrSqZXayGdGUjnMWqYFp1t1k-O=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0771849693=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABE_ZV0MV+=9=sE2ddK6hGzrSqZXayGdGUjnMWqYFp1t1k-O=Q@mail.gmail.com>
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
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0771849693==
Content-Type: multipart/alternative; boundary="00000000000074ff7b0583c24097"

--00000000000074ff7b0583c24097
Content-Type: text/plain; charset="UTF-8"

Seems sysbench cpu test does not slow down:
1) run sysbench cpu on idle machine:
 sysbench cpu run
...
General statistics:
    total time:                          10.0033s
    total number of events:              19052
2) start ./cl_slow_test 1 10000 in background
3) run sysbench again
sysbench cpu run
..
General statistics:
    total time:                          10.0036s
    total number of events:              18979

So if did not slow down considerably.

If I do similar test with sysbench memory test I get following results:
1)  run sysbench memory on idle machine:
sysbench memory --memory-block-size=32M --memory-total-size=100G run
...
66432.00 MiB transferred (6638.95 MiB/sec)
2) start ./cl_slow_test 1 10000 in background
3) sysbench memory --memory-block-size=32M --memory-total-size=100G run
...
672.00 MiB transferred (66.40 MiB/sec)

It confirms that memory speed is reduced 100x :(

--
Lauri


On Sat, Mar 9, 2019 at 9:22 PM Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org> wrote:

> On Sat, Mar 9, 2019 at 1:54 AM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >
> > Even if it's using CPU for OCL (I know it's not doing this), why does
> memcpy on CPU slow down permanently, if I'm not doing anything with OpenCL
> after clCreateContext?
> >
> > As you see from test program it just does clCreateContext and then a
> loop of memcpy-s on CPU.
> >
> > Also I found out that writing different values to
> /sys/class/drm/card0/device/power_dpm_force_performance_level changes my
> max memcpy speed on CPU:
> >
> > echo "low" >
> /sys/class/drm/card0/device/power_dpm_force_performance_level
> > ./cl_slow_test 1 5
> > got 1 platforms 1 devices
> > speed 731.810425 avg 731.810425 mbytes/s
> > speed 163.425583 avg 447.618011 mbytes/s
> > speed 123.441612 avg 339.559235 mbytes/s
> > speed 121.655266 avg 285.083252 mbytes/s
> > speed 123.806801 avg 252.827972 mbytes/s
> >
> > echo "high" >
> /sys/class/drm/card0/device/power_dpm_force_performance_level
> > ./cl_slow_test 1 5
> > got 1 platforms 1 devices
> > speed 3742.063721 avg 3742.063721 mbytes/s
> > speed 836.148987 avg 2289.106445 mbytes/s
> > speed 189.379166 avg 1589.197266 mbytes/s
> > speed 189.271393 avg 1239.215820 mbytes/s
> > speed 188.290451 avg 1029.030762 mbytes/s
> >
> > echo "profile_standard" >
> /sys/class/drm/card0/device/power_dpm_force_performance_level
> > ./cl_slow_test 1 5
> > got 1 platforms 1 devices
> > speed 2303.955566 avg 2303.955566 mbytes/s
> > speed 2298.224121 avg 2301.089844 mbytes/s
> > speed 2295.585205 avg 2299.254883 mbytes/s
> > speed 2295.762939 avg 2298.381836 mbytes/s
> > speed 2288.766602 avg 2296.458740 mbytes/s
> >
> >  echo "profile_peak" >
> /sys/class/drm/card0/device/power_dpm_force_performance_level
> > ./cl_slow_test 1 5
> > got 1 platforms 1 devices
> > speed 3710.360352 avg 3710.360352 mbytes/s
> > speed 3713.660400 avg 3712.010254 mbytes/s
> > speed 3797.630859 avg 3740.550537 mbytes/s
> > speed 3708.004883 avg 3732.414062 mbytes/s
> > speed 3796.403076 avg 3745.211914 mbytes/s
> >
> > However none of those is close to the memcpy speed I get when I don't do
> clCreateContext (my test prog has first arg 0):
> > ./cl_slow_test 0 5
> > speed 7299.201660 avg 7299.201660 mbytes/s
> > speed 9298.841797 avg 8299.021484 mbytes/s
> > speed 9360.181641 avg 8652.742188 mbytes/s
> > speed 9004.759766 avg 8740.746094 mbytes/s
> > speed 9414.607422 avg 8875.518555 mbytes/s
> >
> > Also attached clinfo.txt. It shows that opencl is using GPU so device
> node permissions are probably not the issue.
>
> Is it only memory accesses or does overall CPU performance degrade
> (including compute - say sysbench) as well?
>
> Jan
>
> > --
> > Lauri
> >
> > On Fri, Mar 8, 2019 at 10:35 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> I think you are probably using the CPU for OCL in the remote login
> >> case.  When you log into the desktop, the permissions on the device
> >> nodes get changed dynamically to support accelerated rendering.  You
> >> probably need to change the permissions on the device nodes manually
> >> if you are not logging into the desktop.
> >>
> >> Alex
> >>
> >> On Fri, Mar 8, 2019 at 2:43 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >> >
> >> > Hi!
> >> >
> >> > I am using Ryzen 2400G with Gigabyte AMD B450 AORUS board. I have
> latest bios, ubuntu 18.04 and latest mainline kernel (5.0.0-050000-generic)
> installed. Also I have rocm-dev 2.1.96 but no rock-dkms installed.
> >> >
> >> > I found that when I log in over ssh and try to use OpenCL (doing
> clCreateContext is enough) then cpu memory accesses after that will slow
> down by 100x.
> >> > If I connect HDMI cable and log in to desktop mode then this does not
> happen. Also if I don't call clCreateContext then everything works properly.
> >> >
> >> > Attached the test program and kernel log also. Test works like that :
> >> > g++ cl_slow_test.cpp -o cl_slow_test -I /opt/rocm/opencl/include/ -L
> /opt/rocm/opencl/lib/x86_64/  -lOpenCL
> >> > lauri@rv:~$ ./cl_slow_test 0 5
> >> > speed 7003.145508 avg 7003.145508 mbytes/s
> >> > speed 8427.357422 avg 7715.251465 mbytes/s
> >> > speed 9203.049805 avg 8211.184570 mbytes/s
> >> > speed 9845.956055 avg 8619.877930 mbytes/s
> >> > speed 9882.748047 avg 8872.452148 mbytes/s
> >> > lauri@rv:~$ ./cl_slow_test 1 5
> >> > got 1 platforms 1 devices
> >> > speed 1599.803589 avg 1599.803589 mbytes/s
> >> > speed 1665.426392 avg 1632.614990 mbytes/s
> >> > speed 146.137253 avg 1137.122437 mbytes/s
> >> > speed 121.056877 avg 883.106018 mbytes/s
> >> > speed 122.428970 avg 730.970581 mbytes/s
> >> >
> >> > I also tried latest amd-staging kernel
> https://github.com/M-Bab/linux-kernel-amdgpu-binaries and it had the same
> issue.
> >> >
> >> > Can anyone point me into right direction?
> >> >
> >> > Br,
> >> > Lauri
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000074ff7b0583c24097
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr">Seems sysbench cpu test does not slow down:<div>1) run =
sysbench cpu on idle machine:</div><div>=C2=A0sysbench cpu run<br></div><di=
v>...</div><div><div>General statistics:</div><div>=C2=A0 =C2=A0 total time=
:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 10.0033s</div><div>=C2=A0 =C2=A0 total number of events:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 19052</div></div><div>2) s=
tart ./cl_slow_test 1 10000 in background</div><div>3) run sysbench again</=
div><div>sysbench cpu run<br></div><div>..</div><div><div>General statistic=
s:</div><div>=C2=A0 =C2=A0 total time:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10.0036s</div><div>=
=C2=A0 =C2=A0 total number of events:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 18979</div></div><div><br></div><div>So if did not slow down con=
siderably.</div><div><br></div><div>If I do similar test with sysbench memo=
ry test I get following results:</div><div>1)=C2=A0 run sysbench memory on =
idle machine:</div><div>sysbench memory --memory-block-size=3D32M --memory-=
total-size=3D100G run<br></div><div>...</div><div><div>66432.00 MiB transfe=
rred (6638.95 MiB/sec)</div></div><div>2) start ./cl_slow_test 1 10000 in b=
ackground<br></div><div>3)=C2=A0sysbench memory --memory-block-size=3D32M -=
-memory-total-size=3D100G run</div><div>...</div><div><div>672.00 MiB trans=
ferred (66.40 MiB/sec)</div></div><div><br></div><div>It confirms that memo=
ry speed is reduced 100x :(</div><div><br></div><div>--</div><div>Lauri</di=
v><div><br></div></div></div></div></div></div></div></div></div></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
at, Mar 9, 2019 at 9:22 PM Jan Vesely &lt;<a href=3D"mailto:jan.vesely@rutg=
ers.edu">jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Sat, Mar 9, 2019 at 1:54 AM Lauri Ehren=
preis &lt;<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Even if it&#39;s using CPU for OCL (I know it&#39;s not doing this), w=
hy does memcpy on CPU slow down permanently, if I&#39;m not doing anything =
with OpenCL after clCreateContext?<br>
&gt;<br>
&gt; As you see from test program it just does clCreateContext and then a l=
oop of memcpy-s on CPU.<br>
&gt;<br>
&gt; Also I found out that writing different values to /sys/class/drm/card0=
/device/power_dpm_force_performance_level changes my max memcpy speed on CP=
U:<br>
&gt;<br>
&gt; echo &quot;low&quot; &gt; /sys/class/drm/card0/device/power_dpm_force_=
performance_level<br>
&gt; ./cl_slow_test 1 5<br>
&gt; got 1 platforms 1 devices<br>
&gt; speed 731.810425 avg 731.810425 mbytes/s<br>
&gt; speed 163.425583 avg 447.618011 mbytes/s<br>
&gt; speed 123.441612 avg 339.559235 mbytes/s<br>
&gt; speed 121.655266 avg 285.083252 mbytes/s<br>
&gt; speed 123.806801 avg 252.827972 mbytes/s<br>
&gt;<br>
&gt; echo &quot;high&quot; &gt; /sys/class/drm/card0/device/power_dpm_force=
_performance_level<br>
&gt; ./cl_slow_test 1 5<br>
&gt; got 1 platforms 1 devices<br>
&gt; speed 3742.063721 avg 3742.063721 mbytes/s<br>
&gt; speed 836.148987 avg 2289.106445 mbytes/s<br>
&gt; speed 189.379166 avg 1589.197266 mbytes/s<br>
&gt; speed 189.271393 avg 1239.215820 mbytes/s<br>
&gt; speed 188.290451 avg 1029.030762 mbytes/s<br>
&gt;<br>
&gt; echo &quot;profile_standard&quot; &gt; /sys/class/drm/card0/device/pow=
er_dpm_force_performance_level<br>
&gt; ./cl_slow_test 1 5<br>
&gt; got 1 platforms 1 devices<br>
&gt; speed 2303.955566 avg 2303.955566 mbytes/s<br>
&gt; speed 2298.224121 avg 2301.089844 mbytes/s<br>
&gt; speed 2295.585205 avg 2299.254883 mbytes/s<br>
&gt; speed 2295.762939 avg 2298.381836 mbytes/s<br>
&gt; speed 2288.766602 avg 2296.458740 mbytes/s<br>
&gt;<br>
&gt;=C2=A0 echo &quot;profile_peak&quot; &gt; /sys/class/drm/card0/device/p=
ower_dpm_force_performance_level<br>
&gt; ./cl_slow_test 1 5<br>
&gt; got 1 platforms 1 devices<br>
&gt; speed 3710.360352 avg 3710.360352 mbytes/s<br>
&gt; speed 3713.660400 avg 3712.010254 mbytes/s<br>
&gt; speed 3797.630859 avg 3740.550537 mbytes/s<br>
&gt; speed 3708.004883 avg 3732.414062 mbytes/s<br>
&gt; speed 3796.403076 avg 3745.211914 mbytes/s<br>
&gt;<br>
&gt; However none of those is close to the memcpy speed I get when I don&#3=
9;t do clCreateContext (my test prog has first arg 0):<br>
&gt; ./cl_slow_test 0 5<br>
&gt; speed 7299.201660 avg 7299.201660 mbytes/s<br>
&gt; speed 9298.841797 avg 8299.021484 mbytes/s<br>
&gt; speed 9360.181641 avg 8652.742188 mbytes/s<br>
&gt; speed 9004.759766 avg 8740.746094 mbytes/s<br>
&gt; speed 9414.607422 avg 8875.518555 mbytes/s<br>
&gt;<br>
&gt; Also attached clinfo.txt. It shows that opencl is using GPU so device =
node permissions are probably not the issue.<br>
<br>
Is it only memory accesses or does overall CPU performance degrade<br>
(including compute - say sysbench) as well?<br>
<br>
Jan<br>
<br>
&gt; --<br>
&gt; Lauri<br>
&gt;<br>
&gt; On Fri, Mar 8, 2019 at 10:35 PM Alex Deucher &lt;<a href=3D"mailto:ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<=
br>
&gt;&gt;<br>
&gt;&gt; I think you are probably using the CPU for OCL in the remote login=
<br>
&gt;&gt; case.=C2=A0 When you log into the desktop, the permissions on the =
device<br>
&gt;&gt; nodes get changed dynamically to support accelerated rendering.=C2=
=A0 You<br>
&gt;&gt; probably need to change the permissions on the device nodes manual=
ly<br>
&gt;&gt; if you are not logging into the desktop.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Mar 8, 2019 at 2:43 PM Lauri Ehrenpreis &lt;<a href=3D"mai=
lto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi!<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I am using Ryzen 2400G with Gigabyte AMD B450 AORUS board. I =
have latest bios, ubuntu 18.04 and latest mainline kernel (5.0.0-050000-gen=
eric) installed. Also I have rocm-dev 2.1.96 but no rock-dkms installed.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I found that when I log in over ssh and try to use OpenCL (do=
ing clCreateContext is enough) then cpu memory accesses after that will slo=
w down by 100x.<br>
&gt;&gt; &gt; If I connect HDMI cable and log in to desktop mode then this =
does not happen. Also if I don&#39;t call clCreateContext then everything w=
orks properly.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Attached the test program and kernel log also. Test works lik=
e that :<br>
&gt;&gt; &gt; g++ cl_slow_test.cpp -o cl_slow_test -I /opt/rocm/opencl/incl=
ude/ -L /opt/rocm/opencl/lib/x86_64/=C2=A0 -lOpenCL<br>
&gt;&gt; &gt; lauri@rv:~$ ./cl_slow_test 0 5<br>
&gt;&gt; &gt; speed 7003.145508 avg 7003.145508 mbytes/s<br>
&gt;&gt; &gt; speed 8427.357422 avg 7715.251465 mbytes/s<br>
&gt;&gt; &gt; speed 9203.049805 avg 8211.184570 mbytes/s<br>
&gt;&gt; &gt; speed 9845.956055 avg 8619.877930 mbytes/s<br>
&gt;&gt; &gt; speed 9882.748047 avg 8872.452148 mbytes/s<br>
&gt;&gt; &gt; lauri@rv:~$ ./cl_slow_test 1 5<br>
&gt;&gt; &gt; got 1 platforms 1 devices<br>
&gt;&gt; &gt; speed 1599.803589 avg 1599.803589 mbytes/s<br>
&gt;&gt; &gt; speed 1665.426392 avg 1632.614990 mbytes/s<br>
&gt;&gt; &gt; speed 146.137253 avg 1137.122437 mbytes/s<br>
&gt;&gt; &gt; speed 121.056877 avg 883.106018 mbytes/s<br>
&gt;&gt; &gt; speed 122.428970 avg 730.970581 mbytes/s<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I also tried latest amd-staging kernel <a href=3D"https://git=
hub.com/M-Bab/linux-kernel-amdgpu-binaries" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/M-Bab/linux-kernel-amdgpu-binaries</a> and it had =
the same issue.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Can anyone point me into right direction?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Br,<br>
&gt;&gt; &gt; Lauri<br>
&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt; &gt; amd-gfx mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_b=
lank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--00000000000074ff7b0583c24097--

--===============0771849693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0771849693==--
