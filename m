From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: =?GB18030?B?UmU6ILvYuLSjuiC72Li0o7ogu9i4tKO6IEJ1ZzogYW1kZ3B1IGRybSBkcml2?=
 =?GB18030?B?ZXIgY2F1c2UgcHJvY2VzcyBpbnRvIERpc2sgc2xlZXAgc3RhdGU=?=
Date: Fri, 6 Sep 2019 11:23:20 +0000
Message-ID: <badd9ea1-6f78-abbc-bdbe-e11271188524@amd.com>
References: <tencent_4DEABBEB3BB4C6A6D84CA9F0DB225FBF5809@qq.com>
 <f761fec0-c0cc-426c-6bcb-c3fd23808888@amd.com>
 <tencent_7DC9F5195A4D538FA626F85991875FC5F508@qq.com>
 <2162676e-dbfa-a67d-248c-98e9eb2099c2@amd.com>
 <tencent_DFCD5A0853FDA639F81F91375F8DF55AF508@qq.com>
 <88a08dcc-2e95-9379-693f-2d3fd928aa11@amd.com>
 <tencent_20683D4D4999B2E0A746EA7D01D677D6070A@qq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0792055804=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <tencent_20683D4D4999B2E0A746EA7D01D677D6070A-9uewiaClKEY@public.gmane.org>
Content-Language: en-US
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
To: yanhua <78666679-9uewiaClKEY@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0792055804==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_badd9ea16f78abbcbdbee11271188524amdcom_"

--_000_badd9ea16f78abbcbdbee11271188524amdcom_
Content-Type: text/plain; charset="GB18030"
Content-Transfer-Encoding: quoted-printable

Are there anything I have missed ?

Yeah, unfortunately quite a bunch of things. The fact that arm64 doesn't su=
pport the PCIe NoSnoop TLP attribute is only the tip of the iceberg.

You need a full "recent" driver stack, e.g. not older than a few month till=
 a year, for this to work. And not only the kernel, but also recent userspa=
ce components.

Maybe that's something you could first, e.g. install a recent version of Me=
sa and/or tell Mesa to not use the SDMA at all. But since you are running i=
nto an SDMA lockup with a kernel triggered page table update I see little c=
hance that this work.

The only other alternative I can see is the DKMS package of the pro-driver.=
 With that one you might be able to compile the recent driver for an older =
kernel version.

But I can't guarantee at all that this actually works on ARM64.

Sorry that I don't have better news for you,
Christian.

Am 05.09.19 um 03:36 schrieb yanhua:
Hi, Christian,
        I noticed that you said  'amdgpu is known to not work on arm64 unti=
l very recently'.    I found the CPU related commit with drm is "drm: disab=
le uncached DMA optimization for ARM and arm64".
@@ -47,6 +47,24 @@ static inline bool drm_arch_can_wc_memory(void)
        return false;
 #elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
        return false;
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+       /*
+        * The DRM driver stack is designed to work with cache coherent dev=
ices
+        * only, but permits an optimization to be enabled in some cases, w=
here
+        * for some buffers, both the CPU and the GPU use uncached mappings=
,
+        * removing the need for DMA snooping and allocation in the CPU cac=
hes.
+        *
+        * The use of uncached GPU mappings relies on the correct implement=
ation
+        * of the PCIe NoSnoop TLP attribute by the platform, otherwise the=
 GPU
+        * will use cached mappings nonetheless. On x86 platforms, this doe=
s not
+        * seem to matter, as uncached CPU mappings will snoop the caches i=
n any
+        * case. However, on ARM and arm64, enabling this optimization on a
+        * platform where NoSnoop is ignored results in loss of coherency, =
which
+        * breaks correct operation of the device. Since we have no way of
+        * detecting whether NoSnoop works or not, just disable this
+        * optimization entirely for ARM and arm64.
+        */
+       return false;
 #else
        return true;
 #endif

The real effect is to  in amdgpu_object.c

   if (!drm_arch_can_wc_memory())
                bo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;

And we have AMDGPU_GEM_CREATE_CPU_GTT_USWC turned off in our 4.19.36 kernel=
, So I think this is not  the cause of my bug.  Are there anything I have m=
issed ?

I had suggest the machine supplier to use a more newer kernel such as 5.2.2=
, But they failed to do so after some try.  We also backport a series patch=
es from newer kernel. But still we get the bad ring timeout.

We have dived into the amdgpu drm driver a long time, bu it is really diffi=
cult for me, especially the hardware related ring timeout.

------------------
Yanhua

------------------ =D4=AD=CA=BC=D3=CA=BC=FE ------------------
=B7=A2=BC=FE=C8=CB: "Koenig, Christian"<Christian.Koenig-5C7GfCeVMHo@public.gmane.org><mailto:Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org>;
=B7=A2=CB=CD=CA=B1=BC=E4: 2019=C4=EA9=D4=C23=C8=D5(=D0=C7=C6=DA=B6=FE) =CD=
=ED=C9=CF9:19
=CA=D5=BC=FE=C8=CB: "yanhua"<78666679-9uewiaClKEY@public.gmane.org><mailto:78666679-9uewiaClKEY@public.gmane.org>;"amd-=
gfx"<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>;
=B3=AD=CB=CD: "Deucher, Alexander"<Alexander.Deucher-5C7GfCeVMHo@public.gmane.org><mailto:Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org>;
=D6=F7=CC=E2: Re: =BB=D8=B8=B4=A3=BA =BB=D8=B8=B4=A3=BA Bug: amdgpu drm dri=
ver cause process into Disk sleep state

This is just a GPU lock, please open up a bug report on freedesktop.org and=
 attach the full dmesg and which version of Mesa you are using.

Regards,
Christian.

Am 03.09.19 um 15:16 schrieb 78666679:
Yes, with dmesg|grep drm ,  I get following.

348571.880718] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 timeou=
t, signaled seq=3D24423862, emitted seq=3D24423865


------------------ =D4=AD=CA=BC=D3=CA=BC=FE ------------------
=B7=A2=BC=FE=C8=CB: "Koenig, Christian"<Christian.Koenig-5C7GfCeVMHo@public.gmane.org><mailto:Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org>;
=B7=A2=CB=CD=CA=B1=BC=E4: 2019=C4=EA9=D4=C23=C8=D5(=D0=C7=C6=DA=B6=FE) =CD=
=ED=C9=CF9:07
=CA=D5=BC=FE=C8=CB: ""<78666679-9uewiaClKEY@public.gmane.org><mailto:78666679-9uewiaClKEY@public.gmane.org>;"amd-gfx"<a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>;
=B3=AD=CB=CD: "Deucher, Alexander"<Alexander.Deucher-5C7GfCeVMHo@public.gmane.org><mailto:Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org>;
=D6=F7=CC=E2: Re: =BB=D8=B8=B4=A3=BA Bug: amdgpu drm driver cause process i=
nto Disk sleep state

Well that looks like the hardware got stuck.

Do you get something in the locks about a timeout on the SDMA ring?

Regards,
Christian.

Am 03.09.19 um 14:50 schrieb 78666679:
Hi Christian,
       Sometimes the thread blocked  disk sleeping in call to amdgpu_sa_bo_=
new. following is the stack trace.  it seems the sa bo is used up ,  so  th=
e caller blocked waiting someone to free sa resources.

D 206833 227656 [surfaceflinger] <defunct> Binder:45_5
cat /proc/206833/task/227656/stack

[<0>] __switch_to+0x94/0xe8
[<0>] dma_fence_wait_any_timeout+0x234/0x2d0
[<0>] amdgpu_sa_bo_new+0x468/0x540 [amdgpu]
[<0>] amdgpu_ib_get+0x60/0xc8 [amdgpu]
[<0>] amdgpu_job_alloc_with_ib+0x70/0xb0 [amdgpu]
[<0>] amdgpu_vm_bo_update_mapping+0x2e0/0x3d8 [amdgpu]
[<0>] amdgpu_vm_bo_update+0x2a0/0x710 [amdgpu]
[<0>] amdgpu_gem_va_ioctl+0x46c/0x4c8 [amdgpu]
[<0>] drm_ioctl_kernel+0x94/0x118 [drm]
[<0>] drm_ioctl+0x1f0/0x438 [drm]
[<0>] amdgpu_drm_ioctl+0x58/0x90 [amdgpu]
[<0>] do_vfs_ioctl+0xc4/0x8c0
[<0>] ksys_ioctl+0x8c/0xa0
[<0>] __arm64_sys_ioctl+0x28/0x38
[<0>] el0_svc_common+0xa0/0x180
[<0>] el0_svc_handler+0x38/0x78
[<0>] el0_svc+0x8/0xc
[<0>] 0xffffffffffffffff


--------------------
YanHua

------------------ =D4=AD=CA=BC=D3=CA=BC=FE ------------------
=B7=A2=BC=FE=C8=CB: "Koenig, Christian"<Christian.Koenig-5C7GfCeVMHo@public.gmane.org><mailto:Ch=
ristian.Koenig-5C7GfCeVMHo@public.gmane.org>;
=B7=A2=CB=CD=CA=B1=BC=E4: 2019=C4=EA9=D4=C23=C8=D5(=D0=C7=C6=DA=B6=FE) =CF=
=C2=CE=E74:21
=CA=D5=BC=FE=C8=CB: ""<78666679-9uewiaClKEY@public.gmane.org><mailto:78666679-9uewiaClKEY@public.gmane.org>;"amd-gfx"<a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>;
=B3=AD=CB=CD: "Deucher, Alexander"<Alexander.Deucher-5C7GfCeVMHo@public.gmane.org><mailto:Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org>;
=D6=F7=CC=E2: Re: Bug: amdgpu drm driver cause process into Disk sleep stat=
e

Hi Yanhua,

please update your kernel first, cause that looks like a known issue
which was recently fixed by patch "drm/scheduler: use job count instead
of peek".

Probably best to try the latest bleeding edge kernel and if that doesn't
help please open up a bug report on https://bugs.freedesktop.org/.

Regards,
Christian.

Am 03.09.19 um 09:35 schrieb 78666679:
> Hi, Sirs:
>         I have a wx5100 amdgpu card, It randomly come into failure.  some=
times, it will cause processes into uninterruptible wait state.
>
>
> cps-new-ondemand-0587:~ # ps aux|grep -w D
> root      11268  0.0  0.0 260628  3516 ?        Ssl  8=D4=C226   0:00 /us=
r/sbin/gssproxy -D
> root     136482  0.0  0.0 212500   572 pts/0    S+   15:25   0:00 grep --=
color=3Dauto -w D
> root     370684  0.0  0.0  17972  7428 ?        Ss   9=D4=C202   0:04 /us=
r/sbin/sshd -D
> 10066    432951  0.0  0.0      0     0 ?        D    9=D4=C202   0:00 [Fa=
keFinalizerDa]
> root     496774  0.0  0.0      0     0 ?        D    9=D4=C202   0:17 [kw=
orker/8:1+eve]
> cps-new-ondemand-0587:~ # cat /proc/496774/stack
> [<0>] __switch_to+0x94/0xe8
> [<0>] drm_sched_entity_flush+0xf8/0x248 [gpu_sched]
> [<0>] amdgpu_ctx_mgr_entity_flush+0xac/0x148 [amdgpu]
> [<0>] amdgpu_flush+0x2c/0x50 [amdgpu]
> [<0>] filp_close+0x40/0xa0
> [<0>] put_files_struct+0x118/0x120
> [<0>] put_files_struct+0x30/0x68 [binder_linux]
> [<0>] binder_deferred_func+0x4d4/0x658 [binder_linux]
> [<0>] process_one_work+0x1b4/0x3f8
> [<0>] worker_thread+0x54/0x470
> [<0>] kthread+0x134/0x138
> [<0>] ret_from_fork+0x10/0x18
> [<0>] 0xffffffffffffffff
>
>
>
> This issue troubled me a long time.  looking eagerly to get help from you=
!
>
>
> -----
> Yanhua





--_000_badd9ea16f78abbcbdbee11271188524amdcom_
Content-Type: text/html; charset="GB18030"
Content-ID: <785C48D37DB0584AB60F9C220A74364E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DGB18030">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<div class=3D"moz-cite-prefix">
<blockquote type=3D"cite">Are there anything I have missed ?</blockquote>
<br>
Yeah, unfortunately quite a bunch of things. The fact that arm64 doesn't su=
pport the PCIe NoSnoop TLP attribute is only the tip of the iceberg.<br>
<br>
You need a full &quot;recent&quot; driver stack, e.g. not older than a few =
month till a year, for this to work. And not only the kernel, but also rece=
nt userspace components.<br>
<br>
Maybe that's something you could first, e.g. install a recent version of Me=
sa and/or tell Mesa to not use the SDMA at all. But since you are running i=
nto an SDMA lockup with a kernel triggered page table update I see little c=
hance that this work.<br>
<br>
The only other alternative I can see is the DKMS package of the pro-driver.=
 With that one you might be able to compile the recent driver for an older =
kernel version.<br>
<br>
But I can't guarantee at all that this actually works on ARM64.<br>
<br>
Sorry that I don't have better news for you,<br>
Christian.<br>
<br>
Am 05.09.19 um 03:36 schrieb yanhua:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:tencent_20683D4D4999B2E0A746EA7D01D67=
7D6070A-9uewiaClKEY@public.gmane.org">
<div>Hi, Christian,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I noticed that you said&nbs=
p; 'amdgpu is known to not work on arm64 until very recently'. &nbsp;&nbsp;=
 I found the CPU related commit with drm is &quot;drm: disable uncached DMA=
 optimization for ARM and arm64&quot;.&nbsp;
<br>
</div>
<div>@@ -47,6 &#43;47,24 @@ static inline bool drm_arch_can_wc_memory(void)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;#elif defined(CONFIG_MIPS) &amp;&amp; defined(CONFIG_CPU_LOONGSON3)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The DRM driver stack is d=
esigned to work with cache coherent devices<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only, but permits an opti=
mization to be enabled in some cases, where<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for some buffers, both th=
e CPU and the GPU use uncached mappings,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * removing the need for DMA=
 snooping and allocation in the CPU caches.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The use of uncached GPU m=
appings relies on the correct implementation<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of the PCIe NoSnoop TLP a=
ttribute by the platform, otherwise the GPU<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will use cached mappings =
nonetheless. On x86 platforms, this does not<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * seem to matter, as uncach=
ed CPU mappings will snoop the caches in any<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * case. However, on ARM and=
 arm64, enabling this optimization on a<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * platform where NoSnoop is=
 ignored results in loss of coherency, which<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * breaks correct operation =
of the device. Since we have no way of<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * detecting whether NoSnoop=
 works or not, just disable this<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * optimization entirely for=
 ARM and arm64.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;#endif<br>
<br>
</div>
<div>The real effect is to&nbsp; in amdgpu_object.c<br>
</div>
<div><br>
</div>
<div>&nbsp;&nbsp; if (!drm_arch_can_wc_memory())<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; bo-&gt;flags &amp;=3D ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;<br>
</div>
<div><br>
</div>
<div><span style=3D"font-family: monospace;">And we have </span>AMDGPU_GEM_=
CREATE_CPU_GTT_USWC turned off in our 4.19.36 kernel, So I think this is no=
t&nbsp; the cause of my bug.&nbsp; Are there anything I have missed ?</div>
<div><br>
</div>
<div>I had suggest the machine supplier to use a more newer kernel such as =
5.2.2, But they failed to do so after some try.&nbsp; We also backport a se=
ries patches from newer kernel. But still we get the bad ring timeout.</div=
>
<div><br>
</div>
<div>We have dived into the amdgpu drm driver a long time, bu it is really =
difficult for me, especially the hardware related ring timeout.</div>
<div><br>
</div>
<div>------------------</div>
<div>Yanhua<br>
</div>
<div>
<div><br>
</div>
<div style=3D"font-size: 12px;font-family: Arial
          Narrow;padding:2px 0 2px 0;">
------------------&nbsp;=D4=AD=CA=BC=D3=CA=BC=FE&nbsp;------------------</d=
iv>
<div style=3D"font-size: 12px;background:#efefef;padding:8px;">
<div><b>=B7=A2=BC=FE=C8=CB:</b>&nbsp;&quot;Koenig, Christian&quot;<a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Chr=
istian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;</div>
<div><b>=B7=A2=CB=CD=CA=B1=BC=E4:</b>&nbsp;2019=C4=EA9=D4=C23=C8=D5(=D0=C7=
=C6=DA=B6=FE) =CD=ED=C9=CF9:19</div>
<div><b>=CA=D5=BC=FE=C8=CB:</b>&nbsp;&quot;yanhua&quot;<a class=3D"moz-txt-=
link-rfc2396E" href=3D"mailto:78666679-9uewiaClKEY@public.gmane.org">&lt;78666679-9uewiaClKEY@public.gmane.org&gt;</a>;=
&quot;amd-gfx&quot;<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gf=
x@lists.freedesktop.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>;<wbr></d=
iv>
<div><b>=B3=AD=CB=CD:</b>&nbsp;&quot;Deucher, Alexander&quot;<a class=3D"mo=
z-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexande=
r.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>;<wbr></div>
<div><b>=D6=F7=CC=E2:</b>&nbsp;Re: =BB=D8=B8=B4=A3=BA =BB=D8=B8=B4=A3=BA Bu=
g: amdgpu drm driver cause process into Disk sleep state</div>
</div>
<div><br>
</div>
<div class=3D"moz-cite-prefix">This is just a GPU lock, please open up a bu=
g report on freedesktop.org and attach the full dmesg and which version of =
Mesa you are using.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 03.09.19 um 15:16 schrieb 78666679:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:tencent_DFCD5A0853FDA639F81F91375F8DF=
55AF508-9uewiaClKEY@public.gmane.org">
<div>Yes, with dmesg|grep drm ,&nbsp; I get following.</div>
<div><br>
</div>
<div>348571.880718] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 t=
imeout, signaled seq=3D24423862, emitted seq=3D24423865</div>
<div>
<div><br>
</div>
<div><br>
</div>
<div style=3D"font-size: 12px;font-family: Arial
              Narrow;padding:2px 0 2px 0;">
------------------ =D4=AD=CA=BC=D3=CA=BC=FE ------------------</div>
<div style=3D"font-size: 12px;background:#efefef;padding:8px;">
<div><b>=B7=A2=BC=FE=C8=CB:</b>&nbsp;&quot;Koenig, Christian&quot;<a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" moz-do-=
not-send=3D"true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;</div>
<div><b>=B7=A2=CB=CD=CA=B1=BC=E4:</b>&nbsp;2019=C4=EA9=D4=C23=C8=D5(=D0=C7=
=C6=DA=B6=FE) =CD=ED=C9=CF9:07</div>
<div><b>=CA=D5=BC=FE=C8=CB:</b>&nbsp;&quot;&quot;<a class=3D"moz-txt-link-r=
fc2396E" href=3D"mailto:78666679-9uewiaClKEY@public.gmane.org" moz-do-not-send=3D"true">&lt;78666=
679-9uewiaClKEY@public.gmane.org&gt;</a>;&quot;amd-gfx&quot;<a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send=3D"true">&lt;am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>;<wbr></div>
<div><b>=B3=AD=CB=CD:</b>&nbsp;&quot;Deucher, Alexander&quot;<a class=3D"mo=
z-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" moz-do-not-s=
end=3D"true">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>;<wbr></div>
<div><b>=D6=F7=CC=E2:</b>&nbsp;Re: =BB=D8=B8=B4=A3=BA Bug: amdgpu drm drive=
r cause process into Disk sleep state</div>
</div>
<div><br>
</div>
<div class=3D"moz-cite-prefix">Well that looks like the hardware got stuck.=
<br>
<br>
Do you get something in the locks about a timeout on the SDMA ring?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 03.09.19 um 14:50 schrieb 78666679:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:tencent_7DC9F5195A4D538FA626F85991875=
FC5F508-9uewiaClKEY@public.gmane.org">
<div>Hi Christian,</div>
<div>&nbsp;&nbsp; &nbsp; &nbsp; Sometimes the thread blocked&nbsp; disk sle=
eping in call to amdgpu_sa_bo_new. following is the stack trace.&nbsp; it s=
eems the sa bo is used up ,&nbsp; so&nbsp; the caller blocked waiting someo=
ne to free sa resources.
<br>
</div>
<div><br>
</div>
<div>D 206833 227656 [surfaceflinger] &lt;defunct&gt; Binder:45_5</div>
<div>cat /proc/206833/task/227656/stack</div>
<div><br>
</div>
<div>[&lt;0&gt;] __switch_to&#43;0x94/0xe8<br>
[&lt;0&gt;] dma_fence_wait_any_timeout&#43;0x234/0x2d0<br>
[&lt;0&gt;] amdgpu_sa_bo_new&#43;0x468/0x540 [amdgpu]<br>
[&lt;0&gt;] amdgpu_ib_get&#43;0x60/0xc8 [amdgpu]<br>
[&lt;0&gt;] amdgpu_job_alloc_with_ib&#43;0x70/0xb0 [amdgpu]<br>
[&lt;0&gt;] amdgpu_vm_bo_update_mapping&#43;0x2e0/0x3d8 [amdgpu]<br>
[&lt;0&gt;] amdgpu_vm_bo_update&#43;0x2a0/0x710 [amdgpu]<br>
[&lt;0&gt;] amdgpu_gem_va_ioctl&#43;0x46c/0x4c8 [amdgpu]<br>
[&lt;0&gt;] drm_ioctl_kernel&#43;0x94/0x118 [drm]<br>
[&lt;0&gt;] drm_ioctl&#43;0x1f0/0x438 [drm]<br>
[&lt;0&gt;] amdgpu_drm_ioctl&#43;0x58/0x90 [amdgpu]<br>
[&lt;0&gt;] do_vfs_ioctl&#43;0xc4/0x8c0<br>
[&lt;0&gt;] ksys_ioctl&#43;0x8c/0xa0<br>
[&lt;0&gt;] __arm64_sys_ioctl&#43;0x28/0x38<br>
[&lt;0&gt;] el0_svc_common&#43;0xa0/0x180<br>
[&lt;0&gt;] el0_svc_handler&#43;0x38/0x78<br>
[&lt;0&gt;] el0_svc&#43;0x8/0xc<br>
[&lt;0&gt;] 0xffffffffffffffff<br>
<br>
</div>
<div><br>
</div>
<div>
<div>--------------------</div>
<div>YanHua<br>
</div>
<div><br>
</div>
<div style=3D"font-size: 12px;font-family: Arial
                  Narrow;padding:2px 0 2px 0;">
------------------ =D4=AD=CA=BC=D3=CA=BC=FE ------------------</div>
<div style=3D"font-size:
                  12px;background:#efefef;padding:8px;">
<div><b>=B7=A2=BC=FE=C8=CB:</b>&nbsp;&quot;Koenig, Christian&quot;<a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org" moz-do-=
not-send=3D"true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;</div>
<div><b>=B7=A2=CB=CD=CA=B1=BC=E4:</b>&nbsp;2019=C4=EA9=D4=C23=C8=D5(=D0=C7=
=C6=DA=B6=FE) =CF=C2=CE=E74:21</div>
<div><b>=CA=D5=BC=FE=C8=CB:</b>&nbsp;&quot;&quot;<a class=3D"moz-txt-link-r=
fc2396E" href=3D"mailto:78666679-9uewiaClKEY@public.gmane.org" moz-do-not-send=3D"true">&lt;78666=
679-9uewiaClKEY@public.gmane.org&gt;</a>;&quot;amd-gfx&quot;<a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send=3D"true">&lt;am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>;<wbr></div>
<div><b>=B3=AD=CB=CD:</b>&nbsp;&quot;Deucher, Alexander&quot;<a class=3D"mo=
z-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" moz-do-not-s=
end=3D"true">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>;<wbr></div>
<div><b>=D6=F7=CC=E2:</b>&nbsp;Re: Bug: amdgpu drm driver cause process int=
o Disk sleep state</div>
</div>
<div><br>
</div>
Hi Yanhua,<br>
<br>
please update your kernel first, cause that looks like a known issue <br>
which was recently fixed by patch &quot;drm/scheduler: use job count instea=
d <br>
of peek&quot;.<br>
<br>
Probably best to try the latest bleeding edge kernel and if that doesn't <b=
r>
help please open up a bug report on <a class=3D"moz-txt-link-freetext" href=
=3D"https://bugs.freedesktop.org/" moz-do-not-send=3D"true">
https://bugs.freedesktop.org/</a>.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 03.09.19 um 09:35 schrieb 78666679:<br>
&gt; Hi, Sirs:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; I have a wx5100 amdgpu card, It =
randomly come into failure.&nbsp; sometimes, it will cause processes into u=
ninterruptible wait state.<br>
&gt;<br>
&gt;<br>
&gt; cps-new-ondemand-0587:~ # ps aux|grep -w D<br>
&gt; root&nbsp; &nbsp; &nbsp; 11268&nbsp; 0.0&nbsp; 0.0 260628&nbsp; 3516 ?=
&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; Ssl&nbsp; 8=D4=C226 &nbsp; 0:00 /usr/sbin/=
gssproxy -D<br>
&gt; root &nbsp; &nbsp; 136482&nbsp; 0.0&nbsp; 0.0 212500 &nbsp; 572 pts/0&=
nbsp; &nbsp; S&#43; &nbsp; 15:25 &nbsp; 0:00 grep --color=3Dauto -w D<br>
&gt; root &nbsp; &nbsp; 370684&nbsp; 0.0&nbsp; 0.0&nbsp; 17972&nbsp; 7428 ?=
&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; Ss &nbsp; 9=D4=C202 &nbsp; 0:04 /usr/sbin/=
sshd -D<br>
&gt; 10066&nbsp; &nbsp; 432951&nbsp; 0.0&nbsp; 0.0&nbsp; &nbsp; &nbsp; 0 &n=
bsp; &nbsp; 0 ?&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; D&nbsp; &nbsp; 9=D4=C202 &n=
bsp; 0:00 [FakeFinalizerDa]<br>
&gt; root &nbsp; &nbsp; 496774&nbsp; 0.0&nbsp; 0.0&nbsp; &nbsp; &nbsp; 0 &n=
bsp; &nbsp; 0 ?&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; D&nbsp; &nbsp; 9=D4=C202 &n=
bsp; 0:17 [kworker/8:1&#43;eve]<br>
&gt; cps-new-ondemand-0587:~ # cat /proc/496774/stack<br>
&gt; [&lt;0&gt;] __switch_to&#43;0x94/0xe8<br>
&gt; [&lt;0&gt;] drm_sched_entity_flush&#43;0xf8/0x248 [gpu_sched]<br>
&gt; [&lt;0&gt;] amdgpu_ctx_mgr_entity_flush&#43;0xac/0x148 [amdgpu]<br>
&gt; [&lt;0&gt;] amdgpu_flush&#43;0x2c/0x50 [amdgpu]<br>
&gt; [&lt;0&gt;] filp_close&#43;0x40/0xa0<br>
&gt; [&lt;0&gt;] put_files_struct&#43;0x118/0x120<br>
&gt; [&lt;0&gt;] put_files_struct&#43;0x30/0x68 [binder_linux]<br>
&gt; [&lt;0&gt;] binder_deferred_func&#43;0x4d4/0x658 [binder_linux]<br>
&gt; [&lt;0&gt;] process_one_work&#43;0x1b4/0x3f8<br>
&gt; [&lt;0&gt;] worker_thread&#43;0x54/0x470<br>
&gt; [&lt;0&gt;] kthread&#43;0x134/0x138<br>
&gt; [&lt;0&gt;] ret_from_fork&#43;0x10/0x18<br>
&gt; [&lt;0&gt;] 0xffffffffffffffff<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; This issue troubled me a long time.&nbsp; looking eagerly to get help =
from you!<br>
&gt;<br>
&gt;<br>
&gt; -----<br>
&gt; Yanhua<br>
<br>
</div>
</blockquote>
<br>
</div>
</blockquote>
<br>
</div>
</blockquote>
<br>
</body>
</html>

--_000_badd9ea16f78abbcbdbee11271188524amdcom_--

--===============0792055804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0792055804==--
