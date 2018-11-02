From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: fix interrupt spin lock
Date: Fri, 2 Nov 2018 15:06:55 +0000
Message-ID: <BN6PR12MB1809386BB7F6F84A9AB66E1DF7CF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181102134807.1978-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0455930022=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181102134807.1978-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0455930022==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809386BB7F6F84A9AB66E1DF7CF0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809386BB7F6F84A9AB66E1DF7CF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, November 2, 2018 9:48:07 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdkfd: fix interrupt spin lock

Vega10 has multiple interrupt rings, so this can be called from multiple
calles at the same time resulting in:

[   71.779334] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   71.779406] WARNING: inconsistent lock state
[   71.779478] 4.19.0-rc1+ #44 Tainted: G        W
[   71.779565] --------------------------------
[   71.779637] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   71.779740] kworker/6:1/120 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   71.779832] 00000000ad761971 (&(&kfd->interrupt_lock)->rlock){?...},
at: kgd2kfd_interrupt+0x75/0x100 [amdgpu]
[   71.780058] {IN-HARDIRQ-W} state was registered at:
[   71.780115]   _raw_spin_lock+0x2c/0x40
[   71.780180]   kgd2kfd_interrupt+0x75/0x100 [amdgpu]
[   71.780248]   amdgpu_irq_callback+0x6c/0x150 [amdgpu]
[   71.780315]   amdgpu_ih_process+0x88/0x100 [amdgpu]
[   71.780380]   amdgpu_irq_handler+0x20/0x40 [amdgpu]
[   71.780409]   __handle_irq_event_percpu+0x49/0x2a0
[   71.780436]   handle_irq_event_percpu+0x30/0x70
[   71.780461]   handle_irq_event+0x37/0x60
[   71.780484]   handle_edge_irq+0x83/0x1b0
[   71.780506]   handle_irq+0x1f/0x30
[   71.780526]   do_IRQ+0x53/0x110
[   71.780544]   ret_from_intr+0x0/0x22
[   71.780566]   cpuidle_enter_state+0xaa/0x330
[   71.780591]   do_idle+0x203/0x280
[   71.780610]   cpu_startup_entry+0x6f/0x80
[   71.780634]   start_secondary+0x1b0/0x200
[   71.780657]   secondary_startup_64+0xa4/0xb0

Fix this by always using irq save spin locks.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index d7e0f41f8edc..c004647c8cb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -682,6 +682,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void =
*ih_ring_entry)
 {
         uint32_t patched_ihre[KFD_MAX_RING_ENTRY_SIZE];
         bool is_patched =3D false;
+       unsigned long flags;

         if (!kfd->init_complete)
                 return;
@@ -691,7 +692,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void =
*ih_ring_entry)
                 return;
         }

-       spin_lock(&kfd->interrupt_lock);
+       spin_lock_irqsave(&kfd->interrupt_lock, flags);

         if (kfd->interrupts_active
             && interrupt_is_wanted(kfd, ih_ring_entry,
@@ -700,7 +701,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void =
*ih_ring_entry)
                                      is_patched ? patched_ihre : ih_ring_e=
ntry))
                 queue_work(kfd->ih_wq, &kfd->interrupt_work);

-       spin_unlock(&kfd->interrupt_lock);
+       spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }

 int kgd2kfd_quiesce_mm(struct mm_struct *mm)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809386BB7F6F84A9AB66E1DF7CF0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 2, 2018 9:48:07 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdkfd: fix interrupt spin lock</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Vega10 has multiple interrupt rings, so this can b=
e called from multiple<br>
calles at the same time resulting in:<br>
<br>
[&nbsp;&nbsp; 71.779334] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
[&nbsp;&nbsp; 71.779406] WARNING: inconsistent lock state<br>
[&nbsp;&nbsp; 71.779478] 4.19.0-rc1&#43; #44 Tainted: G&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; W<br>
[&nbsp;&nbsp; 71.779565] --------------------------------<br>
[&nbsp;&nbsp; 71.779637] inconsistent {IN-HARDIRQ-W} -&gt; {HARDIRQ-ON-W} u=
sage.<br>
[&nbsp;&nbsp; 71.779740] kworker/6:1/120 [HC0[0]:SC0[0]:HE1:SE1] takes:<br>
[&nbsp;&nbsp; 71.779832] 00000000ad761971 (&amp;(&amp;kfd-&gt;interrupt_loc=
k)-&gt;rlock){?...},<br>
at: kgd2kfd_interrupt&#43;0x75/0x100 [amdgpu]<br>
[&nbsp;&nbsp; 71.780058] {IN-HARDIRQ-W} state was registered at:<br>
[&nbsp;&nbsp; 71.780115]&nbsp;&nbsp; _raw_spin_lock&#43;0x2c/0x40<br>
[&nbsp;&nbsp; 71.780180]&nbsp;&nbsp; kgd2kfd_interrupt&#43;0x75/0x100 [amdg=
pu]<br>
[&nbsp;&nbsp; 71.780248]&nbsp;&nbsp; amdgpu_irq_callback&#43;0x6c/0x150 [am=
dgpu]<br>
[&nbsp;&nbsp; 71.780315]&nbsp;&nbsp; amdgpu_ih_process&#43;0x88/0x100 [amdg=
pu]<br>
[&nbsp;&nbsp; 71.780380]&nbsp;&nbsp; amdgpu_irq_handler&#43;0x20/0x40 [amdg=
pu]<br>
[&nbsp;&nbsp; 71.780409]&nbsp;&nbsp; __handle_irq_event_percpu&#43;0x49/0x2=
a0<br>
[&nbsp;&nbsp; 71.780436]&nbsp;&nbsp; handle_irq_event_percpu&#43;0x30/0x70<=
br>
[&nbsp;&nbsp; 71.780461]&nbsp;&nbsp; handle_irq_event&#43;0x37/0x60<br>
[&nbsp;&nbsp; 71.780484]&nbsp;&nbsp; handle_edge_irq&#43;0x83/0x1b0<br>
[&nbsp;&nbsp; 71.780506]&nbsp;&nbsp; handle_irq&#43;0x1f/0x30<br>
[&nbsp;&nbsp; 71.780526]&nbsp;&nbsp; do_IRQ&#43;0x53/0x110<br>
[&nbsp;&nbsp; 71.780544]&nbsp;&nbsp; ret_from_intr&#43;0x0/0x22<br>
[&nbsp;&nbsp; 71.780566]&nbsp;&nbsp; cpuidle_enter_state&#43;0xaa/0x330<br>
[&nbsp;&nbsp; 71.780591]&nbsp;&nbsp; do_idle&#43;0x203/0x280<br>
[&nbsp;&nbsp; 71.780610]&nbsp;&nbsp; cpu_startup_entry&#43;0x6f/0x80<br>
[&nbsp;&nbsp; 71.780634]&nbsp;&nbsp; start_secondary&#43;0x1b0/0x200<br>
[&nbsp;&nbsp; 71.780657]&nbsp;&nbsp; secondary_startup_64&#43;0xa4/0xb0<br>
<br>
Fix this by always using irq save spin locks.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 &#43;&#43;&#43;--<br>
&nbsp;1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index d7e0f41f8edc..c004647c8cb4 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -682,6 &#43;682,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const v=
oid *ih_ring_entry)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t patched_ihre[KFD_=
MAX_RING_ENTRY_SIZE];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_patched =3D false;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;init_complete=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
@@ -691,7 &#43;692,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const v=
oid *ih_ring_entry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;kfd-&gt;interrupt_lock=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;kfd-&gt;in=
terrupt_lock, flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt;interrupts_act=
ive<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;&amp; interrupt_is_wanted(kfd, ih_ring_entry,<br>
@@ -700,7 &#43;701,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const v=
oid *ih_ring_entry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is=
_patched ? patched_ihre : ih_ring_entry))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_work(kfd-&gt;ih_wq, &amp;kfd-&gt;interrupt_work=
);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;kfd-&gt;interrupt_lo=
ck);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;kfd-&=
gt;interrupt_lock, flags);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int kgd2kfd_quiesce_mm(struct mm_struct *mm)<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809386BB7F6F84A9AB66E1DF7CF0BN6PR12MB1809namp_--

--===============0455930022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0455930022==--
