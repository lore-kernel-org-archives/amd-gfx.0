From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Change queue/pipe split between amdkfd and amdgpu
Date: Thu, 9 Feb 2017 15:19:34 -0500
Message-ID: <CAFQ_0eFJ4-7zGBN6wdmEYZ-nOb9FsVgCNJkw8WzSW+y-0XE6vg@mail.gmail.com>
References: <20170204045142.5596-1-andresx7@gmail.com>
 <206b40fe-b958-8a78-623b-011712dc5ecc@amd.com>
 <852b8cfe-d886-e78e-de6c-1641b107ed8f@gmail.com>
 <CAFCwf10BboWSwU9HAMjryuLw2K2ANpjC8hGgGwkJh6z8K3pR4Q@mail.gmail.com>
 <50aecc56-f080-d343-9e49-e3955ba1212e@gmail.com>
 <CAFCwf10L8=mwxCup6-S5Yirxit8MJEZR=rhLPF3NVnotGCSYiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1606157385=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10L8=mwxCup6-S5Yirxit8MJEZR=rhLPF3NVnotGCSYiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, John Bridgman <John.Bridgman-5C7GfCeVMHo@public.gmane.org>

--===============1606157385==
Content-Type: multipart/alternative; boundary=001a1140471e18c80605481eb355

--001a1140471e18c80605481eb355
Content-Type: text/plain; charset=UTF-8

Thanks Oded for the test results.

I'll work on a fix.

Regards,
Andres

On Thu, Feb 9, 2017 at 3:11 PM, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>  Andres,
>
> I tried your patches on Kaveri with airlied's drm-next branch.
> I used radeon+amdkfd
>
> The following test failed: KFDQMTest.CreateMultipleCpQueues
> However, I can't debug it because I don't have the sources of kfdtest.
>
> In dmesg, I saw the following warning during boot:
> WARNING: CPU: 0 PID: 150 at
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:670
> start_cpsch+0xc5/0x220 [amdkfd]
> [    4.393796] Modules linked in: hid_logitech_hidpp hid_logitech_dj
> hid_generic usbhid hid uas usb_storage amdkfd amd_iommu_v2 radeon(+)
> i2c_algo_bit ttm drm_kms_helper syscopyarea ahci sysfillrect sysimgblt
> libahci fb_sys_fops drm r8169 mii fjes video
> [    4.393811] CPU: 0 PID: 150 Comm: systemd-udevd Not tainted 4.10.0-rc5+
> #1
> [    4.393811] Hardware name: Gigabyte Technology Co., Ltd. To be
> filled by O.E.M./F2A88XM-D3H, BIOS F5 01/09/2014
> [    4.393812] Call Trace:
> [    4.393818]  dump_stack+0x63/0x90
> [    4.393822]  __warn+0xcb/0xf0
> [    4.393823]  warn_slowpath_null+0x1d/0x20
> [    4.393830]  start_cpsch+0xc5/0x220 [amdkfd]
> [    4.393836]  ? initialize_cpsch+0xa0/0xb0 [amdkfd]
> [    4.393841]  kgd2kfd_device_init+0x375/0x490 [amdkfd]
> [    4.393883]  radeon_kfd_device_init+0xaf/0xd0 [radeon]
> [    4.393911]  radeon_driver_load_kms+0x11e/0x1f0 [radeon]
> [    4.393933]  drm_dev_register+0x14a/0x200 [drm]
> [    4.393946]  drm_get_pci_dev+0x9d/0x160 [drm]
> [    4.393974]  radeon_pci_probe+0xb8/0xe0 [radeon]
> [    4.393976]  local_pci_probe+0x45/0xa0
> [    4.393978]  pci_device_probe+0x103/0x150
> [    4.393981]  driver_probe_device+0x2bf/0x460
> [    4.393982]  __driver_attach+0xdf/0xf0
> [    4.393984]  ? driver_probe_device+0x460/0x460
> [    4.393985]  bus_for_each_dev+0x6c/0xc0
> [    4.393987]  driver_attach+0x1e/0x20
> [    4.393988]  bus_add_driver+0x1fd/0x270
> [    4.393989]  ? 0xffffffffc05c8000
> [    4.393991]  driver_register+0x60/0xe0
> [    4.393992]  ? 0xffffffffc05c8000
> [    4.393993]  __pci_register_driver+0x4c/0x50
> [    4.394007]  drm_pci_init+0xeb/0x100 [drm]
> [    4.394008]  ? 0xffffffffc05c8000
> [    4.394031]  radeon_init+0x98/0xb6 [radeon]
> [    4.394034]  do_one_initcall+0x53/0x1a0
> [    4.394037]  ? __vunmap+0x81/0xd0
> [    4.394039]  ? kmem_cache_alloc_trace+0x152/0x1c0
> [    4.394041]  ? vfree+0x2e/0x70
> [    4.394044]  do_init_module+0x5f/0x1ff
> [    4.394046]  load_module+0x24cc/0x29f0
> [    4.394047]  ? __symbol_put+0x60/0x60
> [    4.394050]  ? security_kernel_post_read_file+0x6b/0x80
> [    4.394052]  SYSC_finit_module+0xdf/0x110
> [    4.394054]  SyS_finit_module+0xe/0x10
> [    4.394056]  entry_SYSCALL_64_fastpath+0x1e/0xad
> [    4.394058] RIP: 0033:0x7f9cda77c8e9
> [    4.394059] RSP: 002b:00007ffe195d3378 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [    4.394060] RAX: ffffffffffffffda RBX: 00007f9cdb8dda7e RCX:
> 00007f9cda77c8e9
> [    4.394061] RDX: 0000000000000000 RSI: 00007f9cdac7ce2a RDI:
> 0000000000000013
> [    4.394062] RBP: 00007ffe195d2450 R08: 0000000000000000 R09:
> 0000000000000000
> [    4.394063] R10: 0000000000000013 R11: 0000000000000246 R12:
> 00007ffe195d245a
> [    4.394063] R13: 00007ffe195d1378 R14: 0000563f70cc93b0 R15:
> 0000563f70cba4d0
> [    4.394091] ---[ end trace 9c5af17304d998bb ]---
> [    4.394092] Invalid queue enabled by amdgpu: 9
>
> I suggest you get a Kaveri/Carrizo machine to debug these issues.
>
> Until that, I don't think we should merge this patch-set.
>
> Oded
>
> On Wed, Feb 8, 2017 at 9:47 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Thank you Oded.
> >
> > - Andres
> >
> >
> > On 2017-02-08 02:32 PM, Oded Gabbay wrote:
> >>
> >> On Wed, Feb 8, 2017 at 6:23 PM, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> wrote:
> >>>
> >>> Hey Felix,
> >>>
> >>> Thanks for the pointer to the ROCm mqd commit. I like that the
> >>> workarounds
> >>> are easy to spot. I'll add that to a new patch series I'm working on
> for
> >>> some bug-fixes for perf being lower on pipes other than pipe 0.
> >>>
> >>> I haven't tested this yet on kaveri/carrizo. I'm hoping someone with
> the
> >>> HW
> >>> will be able to give it a go. I put in a few small hacks to get KFD to
> >>> boot
> >>> but do nothing on polaris10.
> >>>
> >>> Regards,
> >>> Andres
> >>>
> >>>
> >>> On 2017-02-06 03:20 PM, Felix Kuehling wrote:
> >>>>
> >>>> Hi Andres,
> >>>>
> >>>> Thank you for tackling this task. It's more involved than I expected,
> >>>> mostly because I didn't have much awareness of the MQD management in
> >>>> amdgpu.
> >>>>
> >>>> I made one comment in a separate message about the unified MQD commit
> >>>> function, if you want to bring that more in line with our latest ROCm
> >>>> release on github.
> >>>>
> >>>> Also, were you able to test the upstream KFD with your changes on a
> >>>> Kaveri or Carrizo?
> >>>>
> >>>> Regards,
> >>>>    Felix
> >>>>
> >>>>
> >>>> On 17-02-03 11:51 PM, Andres Rodriguez wrote:
> >>>>>
> >>>>> The current queue/pipe split policy is for amdgpu to take the first
> >>>>> pipe
> >>>>> of
> >>>>> MEC0 and leave the rest for amdkfd to use. This policy is taken as an
> >>>>> assumption in a few areas of the implementation.
> >>>>>
> >>>>> This patch series aims to allow for flexible/tunable queue/pipe split
> >>>>> policies
> >>>>> between kgd and kfd. It also updates the queue/pipe split policy to
> one
> >>>>> that
> >>>>> allows better compute app concurrency for both drivers.
> >>>>>
> >>>>> In the process some duplicate code and hardcoded constants were
> >>>>> removed.
> >>>>>
> >>>>> Any suggestions or feedback on improvements welcome.
> >>>>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >> Hi Andres,
> >> I will try to find sometime to test it on my Kaveri machine.
> >>
> >> Oded
> >
> >
>

--001a1140471e18c80605481eb355
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Thanks Oded for the test results.<br><br></=
div>I&#39;ll work on a fix.<br><br></div>Regards,<br></div>Andres<br></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Feb 9, 20=
17 at 3:11 PM, Oded Gabbay <span dir=3D"ltr">&lt;<a href=3D"mailto:oded.gab=
bay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">=C2=A0Andres,<br>
<br>
I tried your patches on Kaveri with airlied&#39;s drm-next branch.<br>
I used radeon+amdkfd<br>
<br>
The following test failed: KFDQMTest.<wbr>CreateMultipleCpQueues<br>
However, I can&#39;t debug it because I don&#39;t have the sources of kfdte=
st.<br>
<br>
In dmesg, I saw the following warning during boot:<br>
WARNING: CPU: 0 PID: 150 at<br>
drivers/gpu/drm/amd/amdkfd/<wbr>kfd_device_queue_manager.c:670<br>
start_cpsch+0xc5/0x220 [amdkfd]<br>
[=C2=A0 =C2=A0 4.393796] Modules linked in: hid_logitech_hidpp hid_logitech=
_dj<br>
hid_generic usbhid hid uas usb_storage amdkfd amd_iommu_v2 radeon(+)<br>
i2c_algo_bit ttm drm_kms_helper syscopyarea ahci sysfillrect sysimgblt<br>
libahci fb_sys_fops drm r8169 mii fjes video<br>
[=C2=A0 =C2=A0 4.393811] CPU: 0 PID: 150 Comm: systemd-udevd Not tainted 4.=
10.0-rc5+ #1<br>
[=C2=A0 =C2=A0 4.393811] Hardware name: Gigabyte Technology Co., Ltd. To be=
<br>
filled by O.E.M./F2A88XM-D3H, BIOS F5 01/09/2014<br>
[=C2=A0 =C2=A0 4.393812] Call Trace:<br>
[=C2=A0 =C2=A0 4.393818]=C2=A0 dump_stack+0x63/0x90<br>
[=C2=A0 =C2=A0 4.393822]=C2=A0 __warn+0xcb/0xf0<br>
[=C2=A0 =C2=A0 4.393823]=C2=A0 warn_slowpath_null+0x1d/0x20<br>
[=C2=A0 =C2=A0 4.393830]=C2=A0 start_cpsch+0xc5/0x220 [amdkfd]<br>
[=C2=A0 =C2=A0 4.393836]=C2=A0 ? initialize_cpsch+0xa0/0xb0 [amdkfd]<br>
[=C2=A0 =C2=A0 4.393841]=C2=A0 kgd2kfd_device_init+0x375/<wbr>0x490 [amdkfd=
]<br>
[=C2=A0 =C2=A0 4.393883]=C2=A0 radeon_kfd_device_init+0xaf/<wbr>0xd0 [radeo=
n]<br>
[=C2=A0 =C2=A0 4.393911]=C2=A0 radeon_driver_load_kms+0x11e/<wbr>0x1f0 [rad=
eon]<br>
[=C2=A0 =C2=A0 4.393933]=C2=A0 drm_dev_register+0x14a/0x200 [drm]<br>
[=C2=A0 =C2=A0 4.393946]=C2=A0 drm_get_pci_dev+0x9d/0x160 [drm]<br>
[=C2=A0 =C2=A0 4.393974]=C2=A0 radeon_pci_probe+0xb8/0xe0 [radeon]<br>
[=C2=A0 =C2=A0 4.393976]=C2=A0 local_pci_probe+0x45/0xa0<br>
[=C2=A0 =C2=A0 4.393978]=C2=A0 pci_device_probe+0x103/0x150<br>
[=C2=A0 =C2=A0 4.393981]=C2=A0 driver_probe_device+0x2bf/<wbr>0x460<br>
[=C2=A0 =C2=A0 4.393982]=C2=A0 __driver_attach+0xdf/0xf0<br>
[=C2=A0 =C2=A0 4.393984]=C2=A0 ? driver_probe_device+0x460/<wbr>0x460<br>
[=C2=A0 =C2=A0 4.393985]=C2=A0 bus_for_each_dev+0x6c/0xc0<br>
[=C2=A0 =C2=A0 4.393987]=C2=A0 driver_attach+0x1e/0x20<br>
[=C2=A0 =C2=A0 4.393988]=C2=A0 bus_add_driver+0x1fd/0x270<br>
[=C2=A0 =C2=A0 4.393989]=C2=A0 ? 0xffffffffc05c8000<br>
[=C2=A0 =C2=A0 4.393991]=C2=A0 driver_register+0x60/0xe0<br>
[=C2=A0 =C2=A0 4.393992]=C2=A0 ? 0xffffffffc05c8000<br>
[=C2=A0 =C2=A0 4.393993]=C2=A0 __pci_register_driver+0x4c/<wbr>0x50<br>
[=C2=A0 =C2=A0 4.394007]=C2=A0 drm_pci_init+0xeb/0x100 [drm]<br>
[=C2=A0 =C2=A0 4.394008]=C2=A0 ? 0xffffffffc05c8000<br>
[=C2=A0 =C2=A0 4.394031]=C2=A0 radeon_init+0x98/0xb6 [radeon]<br>
[=C2=A0 =C2=A0 4.394034]=C2=A0 do_one_initcall+0x53/0x1a0<br>
[=C2=A0 =C2=A0 4.394037]=C2=A0 ? __vunmap+0x81/0xd0<br>
[=C2=A0 =C2=A0 4.394039]=C2=A0 ? kmem_cache_alloc_trace+0x152/<wbr>0x1c0<br=
>
[=C2=A0 =C2=A0 4.394041]=C2=A0 ? vfree+0x2e/0x70<br>
[=C2=A0 =C2=A0 4.394044]=C2=A0 do_init_module+0x5f/0x1ff<br>
[=C2=A0 =C2=A0 4.394046]=C2=A0 load_module+0x24cc/0x29f0<br>
[=C2=A0 =C2=A0 4.394047]=C2=A0 ? __symbol_put+0x60/0x60<br>
[=C2=A0 =C2=A0 4.394050]=C2=A0 ? security_kernel_post_read_<wbr>file+0x6b/0=
x80<br>
[=C2=A0 =C2=A0 4.394052]=C2=A0 SYSC_finit_module+0xdf/0x110<br>
[=C2=A0 =C2=A0 4.394054]=C2=A0 SyS_finit_module+0xe/0x10<br>
[=C2=A0 =C2=A0 4.394056]=C2=A0 entry_SYSCALL_64_fastpath+<wbr>0x1e/0xad<br>
[=C2=A0 =C2=A0 4.394058] RIP: 0033:0x7f9cda77c8e9<br>
[=C2=A0 =C2=A0 4.394059] RSP: 002b:00007ffe195d3378 EFLAGS: 00000246 ORIG_R=
AX:<br>
0000000000000139<br>
[=C2=A0 =C2=A0 4.394060] RAX: ffffffffffffffda RBX: 00007f9cdb8dda7e RCX: 0=
0007f9cda77c8e9<br>
[=C2=A0 =C2=A0 4.394061] RDX: 0000000000000000 RSI: 00007f9cdac7ce2a RDI: 0=
000000000000013<br>
[=C2=A0 =C2=A0 4.394062] RBP: 00007ffe195d2450 R08: 0000000000000000 R09: 0=
000000000000000<br>
[=C2=A0 =C2=A0 4.394063] R10: 0000000000000013 R11: 0000000000000246 R12: 0=
0007ffe195d245a<br>
[=C2=A0 =C2=A0 4.394063] R13: 00007ffe195d1378 R14: 0000563f70cc93b0 R15: 0=
000563f70cba4d0<br>
[=C2=A0 =C2=A0 4.394091] ---[ end trace 9c5af17304d998bb ]---<br>
[=C2=A0 =C2=A0 4.394092] Invalid queue enabled by amdgpu: 9<br>
<br>
I suggest you get a Kaveri/Carrizo machine to debug these issues.<br>
<br>
Until that, I don&#39;t think we should merge this patch-set.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Oded<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
On Wed, Feb 8, 2017 at 9:47 PM, Andres Rodriguez &lt;<a href=3D"mailto:andr=
esx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Thank you Oded.<br>
&gt;<br>
&gt; - Andres<br>
&gt;<br>
&gt;<br>
&gt; On 2017-02-08 02:32 PM, Oded Gabbay wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 8, 2017 at 6:23 PM, Andres Rodriguez &lt;<a href=3D"ma=
ilto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hey Felix,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks for the pointer to the ROCm mqd commit. I like that the=
<br>
&gt;&gt;&gt; workarounds<br>
&gt;&gt;&gt; are easy to spot. I&#39;ll add that to a new patch series I&#3=
9;m working on for<br>
&gt;&gt;&gt; some bug-fixes for perf being lower on pipes other than pipe 0=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I haven&#39;t tested this yet on kaveri/carrizo. I&#39;m hopin=
g someone with the<br>
&gt;&gt;&gt; HW<br>
&gt;&gt;&gt; will be able to give it a go. I put in a few small hacks to ge=
t KFD to<br>
&gt;&gt;&gt; boot<br>
&gt;&gt;&gt; but do nothing on polaris10.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Andres<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2017-02-06 03:20 PM, Felix Kuehling wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Andres,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thank you for tackling this task. It&#39;s more involved t=
han I expected,<br>
&gt;&gt;&gt;&gt; mostly because I didn&#39;t have much awareness of the MQD=
 management in<br>
&gt;&gt;&gt;&gt; amdgpu.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I made one comment in a separate message about the unified=
 MQD commit<br>
&gt;&gt;&gt;&gt; function, if you want to bring that more in line with our =
latest ROCm<br>
&gt;&gt;&gt;&gt; release on github.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Also, were you able to test the upstream KFD with your cha=
nges on a<br>
&gt;&gt;&gt;&gt; Kaveri or Carrizo?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Felix<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 17-02-03 11:51 PM, Andres Rodriguez wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; The current queue/pipe split policy is for amdgpu to t=
ake the first<br>
&gt;&gt;&gt;&gt;&gt; pipe<br>
&gt;&gt;&gt;&gt;&gt; of<br>
&gt;&gt;&gt;&gt;&gt; MEC0 and leave the rest for amdkfd to use. This policy=
 is taken as an<br>
&gt;&gt;&gt;&gt;&gt; assumption in a few areas of the implementation.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This patch series aims to allow for flexible/tunable q=
ueue/pipe split<br>
&gt;&gt;&gt;&gt;&gt; policies<br>
&gt;&gt;&gt;&gt;&gt; between kgd and kfd. It also updates the queue/pipe sp=
lit policy to one<br>
&gt;&gt;&gt;&gt;&gt; that<br>
&gt;&gt;&gt;&gt;&gt; allows better compute app concurrency for both drivers=
.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In the process some duplicate code and hardcoded const=
ants were<br>
&gt;&gt;&gt;&gt;&gt; removed.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Any suggestions or feedback on improvements welcome.<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists=
.freedesktop.org</a><br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wb=
r>mailman/listinfo/amd-gfx</a><br>
&gt;&gt;<br>
&gt;&gt; Hi Andres,<br>
&gt;&gt; I will try to find sometime to test it on my Kaveri machine.<br>
&gt;&gt;<br>
&gt;&gt; Oded<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a1140471e18c80605481eb355--

--===============1606157385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1606157385==--
