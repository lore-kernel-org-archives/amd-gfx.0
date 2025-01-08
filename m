Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CE1E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 10:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C5910E28B;
	Wed,  8 Jan 2025 10:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K1DPn2KR";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDA710E28B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736330741; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=z6CduTLpGZb1uClG5eDxFOtMKT6Pvt7yVjIZT9S/W8M=;
 b=K1DPn2KRh1t7isgiQVfm/uK8JDPDX/xuQPrrZVqAiTX5oiXvoZN/wKY90uuCrTSGGYAINMtNQCwgq0oJzVKrM4b0GUoCKkEyvmj5ivf0YP5oMIZkilJXRjpGGioBgeeEm80vIQD+Hb2HDV2cs1AEylCw5m/ddKeqChRFrec6adE=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNDiuRz_1736330739 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 18:05:40 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <D69A1867-42CE-48DB-A93D-425C83070A0D@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_AF20CCA0-3AFC-4760-96C0-D6A05048FBDB"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v3 6/6] drm/amdgpu: get rid of false warnings caused by
 amdgpu_irq_put()
Date: Wed, 8 Jan 2025 18:05:39 +0800
In-Reply-To: <eb90ea93-972d-460f-8ad8-3c60a656207a@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
To: "Lazar, Lijo" <lijo.lazar@amd.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
 <eb90ea93-972d-460f-8ad8-3c60a656207a@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--Apple-Mail=_AF20CCA0-3AFC-4760-96C0-D6A05048FBDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=888=E6=97=A5 18:02=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/8/2025 2:26 PM, Jiang Liu wrote:
>> If error happens before amdgpu_fence_driver_hw_init() gets called =
during
>> device probe, it will trigger a false warning in amdgpu_irq_put() as
>> below:
>> [ 1209.300996] ------------[ cut here ]------------
>> [ 1209.301061] WARNING: CPU: 48 PID: 293 at =
/tmp/amd.Rc9jFrl7/amd/amdgpu/amdgpu_irq.c:633 amdgpu_irq_put+0x45/0x70 =
[amdgpu]
>> [ 1209.301062] Modules linked in: ...
>> [ 1209.301093] CPU: 48 PID: 293 Comm: kworker/48:1 Kdump: loaded =
Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
>> [ 1209.301094] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud =
ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>> [ 1209.301095] Workqueue: events work_for_cpu_fn
>> [ 1209.301159] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
>> [ 1209.301160] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 =
8b 08 85 c9 74 14 f0 ff 08 b8 00 00 00 00 74 05 c3 cc cc cc cc e9 8b fd =
ff ff <0f> 0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc =
cc
>> [ 1209.301162] RSP: 0018:ffffb08a99c8fd88 EFLAGS: 00010246
>> [ 1209.301162] RAX: ffff9efe1bcbf500 RBX: ffff9efe1cc3e400 RCX: =
0000000000000000
>> [ 1209.301163] RDX: 0000000000000000 RSI: ffff9efe1cc3b108 RDI: =
ffff9efe1cc00000
>> [ 1209.301163] RBP: ffff9efe1cc10818 R08: 0000000000000001 R09: =
000000000000000d
>> [ 1209.301164] R10: ffffb08a99c8fb48 R11: ffffffffa2068018 R12: =
ffff9efe1cc109d0
>> [ 1209.301164] R13: ffff9efe1cc00010 R14: ffff9efe1cc00000 R15: =
ffff9efe1cc3b108
>> [ 1209.301165] FS:  0000000000000000(0000) GS:ffff9ff9fce00000(0000) =
knlGS:0000000000000000
>> [ 1209.301165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1209.301165] CR2: 00007fd0f6e860d0 CR3: 0000010092baa003 CR4: =
0000000002770ee0
>> [ 1209.301166] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> [ 1209.301166] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: =
0000000000000400
>> [ 1209.301167] PKRU: 55555554
>> [ 1209.301167] Call Trace:
>> [ 1209.301225]  amdgpu_fence_driver_hw_fini+0xda/0x110 [amdgpu]
>> [ 1209.301284]  amdgpu_device_fini_hw+0xaf/0x200 [amdgpu]
>> [ 1209.301342]  amdgpu_driver_load_kms+0x7f/0xc0 [amdgpu]
>> [ 1209.301400]  amdgpu_pci_probe+0x1cd/0x4a0 [amdgpu]
>> [ 1209.301401]  local_pci_probe+0x40/0xa0
>> [ 1209.301402]  work_for_cpu_fn+0x13/0x20
>> [ 1209.301403]  process_one_work+0x1ad/0x380
>> [ 1209.301404]  worker_thread+0x1c8/0x310
>> [ 1209.301405]  ? process_one_work+0x380/0x380
>> [ 1209.301406]  kthread+0x118/0x140
>> [ 1209.301407]  ? __kthread_bind_mask+0x60/0x60
>> [ 1209.301408]  ret_from_fork+0x1f/0x30
>> [ 1209.301410] ---[ end trace 733f120fe2ab13e5 ]---
>> [ 1209.301418] ------------[ cut here ]------------
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 1 +
>> 2 files changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index b5e87b515139..0e41a535e05f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -614,9 +614,11 @@ void amdgpu_fence_driver_hw_fini(struct =
amdgpu_device *adev)
>>=20
>> 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
>> 		    ring->fence_drv.irq_src &&
>> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
>> +		    ring->fence_drv.irq_enabled) {
>> 			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>> 				       ring->fence_drv.irq_type);
>> +		        ring->fence_drv.irq_enabled =3D false;
>> +		}
>>=20
>> 		del_timer_sync(&ring->fence_drv.fallback_timer);
>> 	}
>> @@ -693,9 +695,12 @@ void amdgpu_fence_driver_hw_init(struct =
amdgpu_device *adev)
>>=20
>> 		/* enable the interrupt */
>> 		if (ring->fence_drv.irq_src &&
>> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
>> +		    !ring->fence_drv.irq_enabled &&
>> +		    amdgpu_fence_need_ring_interrupt_restore(ring)) {
>> 			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
>> 				       ring->fence_drv.irq_type);
>> +		        ring->fence_drv.irq_enabled =3D true;
>> +		}
>=20
> I guess the problem is more generic like calling fence driver =
hw_fini()
> when hw_init is not called.
>=20
You are so smart:)
I=E2=80=99m working on another patch set to fix these generic issues by =
tweaking the ip block and ras block state machine.
Thanks,
Gerry

> Thanks,
> Lijo
>=20
>> 	}
>> }
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index dee5a1b4e572..959d474a0516 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>> 	uint32_t			sync_seq;
>> 	atomic_t			last_seq;
>> 	bool				initialized;
>> +	bool				irq_enabled;
>> 	struct amdgpu_irq_src		*irq_src;
>> 	unsigned			irq_type;
>> 	struct timer_list		fallback_timer;


--Apple-Mail=_AF20CCA0-3AFC-4760-96C0-D6A05048FBDB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=888=E6=97=A5 18:02=EF=BC=8CLazar, Lijo =
&lt;<a href=3D"mailto:lijo.lazar@amd.com" =
class=3D"">lijo.lazar@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br=
 class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On 1/8/2025 2:26 PM, Jiang Liu wrote:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">If =
error happens before amdgpu_fence_driver_hw_init() gets called during<br =
class=3D"">device probe, it will trigger a false warning in =
amdgpu_irq_put() as<br class=3D"">below:<br class=3D"">[ 1209.300996] =
------------[ cut here ]------------<br class=3D"">[ 1209.301061] =
WARNING: CPU: 48 PID: 293 at =
/tmp/amd.Rc9jFrl7/amd/amdgpu/amdgpu_irq.c:633 amdgpu_irq_put+0x45/0x70 =
[amdgpu]<br class=3D"">[ 1209.301062] Modules linked in: ...<br =
class=3D"">[ 1209.301093] CPU: 48 PID: 293 Comm: kworker/48:1 Kdump: =
loaded Tainted: G &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;W &nbsp;OE =
&nbsp;&nbsp;&nbsp;&nbsp;5.10.134-17.2.al8.x86_64 #1<br class=3D"">[ =
1209.301094] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, =
BIOS 3.0.ES.AL.P.087.05 04/07/2024<br class=3D"">[ 1209.301095] =
Workqueue: events work_for_cpu_fn<br class=3D"">[ 1209.301159] RIP: =
0010:amdgpu_irq_put+0x45/0x70 [amdgpu]<br class=3D"">[ 1209.301160] =
Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 =
f0 ff 08 b8 00 00 00 00 74 05 c3 cc cc cc cc e9 8b fd ff ff &lt;0f&gt; =
0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc cc<br =
class=3D"">[ 1209.301162] RSP: 0018:ffffb08a99c8fd88 EFLAGS: 00010246<br =
class=3D"">[ 1209.301162] RAX: ffff9efe1bcbf500 RBX: ffff9efe1cc3e400 =
RCX: 0000000000000000<br class=3D"">[ 1209.301163] RDX: 0000000000000000 =
RSI: ffff9efe1cc3b108 RDI: ffff9efe1cc00000<br class=3D"">[ 1209.301163] =
RBP: ffff9efe1cc10818 R08: 0000000000000001 R09: 000000000000000d<br =
class=3D"">[ 1209.301164] R10: ffffb08a99c8fb48 R11: ffffffffa2068018 =
R12: ffff9efe1cc109d0<br class=3D"">[ 1209.301164] R13: ffff9efe1cc00010 =
R14: ffff9efe1cc00000 R15: ffff9efe1cc3b108<br class=3D"">[ 1209.301165] =
FS: &nbsp;0000000000000000(0000) GS:ffff9ff9fce00000(0000) =
knlGS:0000000000000000<br class=3D"">[ 1209.301165] CS: &nbsp;0010 DS: =
0000 ES: 0000 CR0: 0000000080050033<br class=3D"">[ 1209.301165] CR2: =
00007fd0f6e860d0 CR3: 0000010092baa003 CR4: 0000000002770ee0<br =
class=3D"">[ 1209.301166] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000<br class=3D"">[ 1209.301166] DR3: 0000000000000000 =
DR6: 00000000fffe07f0 DR7: 0000000000000400<br class=3D"">[ 1209.301167] =
PKRU: 55555554<br class=3D"">[ 1209.301167] Call Trace:<br class=3D"">[ =
1209.301225] &nbsp;amdgpu_fence_driver_hw_fini+0xda/0x110 [amdgpu]<br =
class=3D"">[ 1209.301284] &nbsp;amdgpu_device_fini_hw+0xaf/0x200 =
[amdgpu]<br class=3D"">[ 1209.301342] =
&nbsp;amdgpu_driver_load_kms+0x7f/0xc0 [amdgpu]<br class=3D"">[ =
1209.301400] &nbsp;amdgpu_pci_probe+0x1cd/0x4a0 [amdgpu]<br class=3D"">[ =
1209.301401] &nbsp;local_pci_probe+0x40/0xa0<br class=3D"">[ =
1209.301402] &nbsp;work_for_cpu_fn+0x13/0x20<br class=3D"">[ =
1209.301403] &nbsp;process_one_work+0x1ad/0x380<br class=3D"">[ =
1209.301404] &nbsp;worker_thread+0x1c8/0x310<br class=3D"">[ =
1209.301405] &nbsp;? process_one_work+0x380/0x380<br class=3D"">[ =
1209.301406] &nbsp;kthread+0x118/0x140<br class=3D"">[ 1209.301407] =
&nbsp;? __kthread_bind_mask+0x60/0x60<br class=3D"">[ 1209.301408] =
&nbsp;ret_from_fork+0x1f/0x30<br class=3D"">[ 1209.301410] ---[ end =
trace 733f120fe2ab13e5 ]---<br class=3D"">[ 1209.301418] ------------[ =
cut here ]------------<br class=3D""><br class=3D"">Signed-off-by: Jiang =
Liu &lt;<a href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">---<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h &nbsp;| 1 +<br =
class=3D"">2 files changed, 8 insertions(+), 2 deletions(-)<br =
class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br class=3D"">index =
b5e87b515139..0e41a535e05f 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br class=3D"">@@ -614,9 =
+614,11 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device =
*adev)<br class=3D""><br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if =
(!drm_dev_is_unplugged(adev_to_drm(adev)) &amp;&amp;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;ring-&gt;fe=
nce_drv.irq_src &amp;&amp;<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;amdgpu_fenc=
e_need_ring_interrupt_restore(ring))<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;ring-&gt;fe=
nce_drv.irq_enabled) {<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_irq_put(adev, =
ring-&gt;fence_drv.irq_src,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;ring-&gt;fence_drv.irq_type);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;ring-&gt;fence_drv.irq_enabled =3D false;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D""><br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>del_timer_sync(&amp;ring-&gt;fence_drv.fallback_timer);<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D"">@@ -693,9 +695,12 @@ void =
amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)<br class=3D""><br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>/* enable the interrupt */<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ring-&gt;fence_drv.irq_src &amp;&amp;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;amdgpu_fenc=
e_need_ring_interrupt_restore(ring))<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;!ring-&gt;f=
ence_drv.irq_enabled &amp;&amp;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;amdgpu_fenc=
e_need_ring_interrupt_restore(ring)) {<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_irq_get(adev, ring-&gt;fence_drv.irq_src,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;ring-&gt;fence_drv.irq_type);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;ring-&gt;fence_drv.irq_enabled =3D true;<br class=3D"">+<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">I guess the problem is more generic like calling fence driver =
hw_fini()</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">when hw_init =
is not called.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote>You are so =
smart:)<br class=3D""><div>I=E2=80=99m working on another patch set to =
fix these generic issues by tweaking the ip block and ras block state =
machine.</div><div>Thanks,</div><div>Gerry</div><br class=3D""><blockquote=
 type=3D"cite" class=3D""><div class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Thanks,</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Lijo</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br class=3D"">}<br class=3D""><br=
 class=3D"">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br class=3D"">index =
dee5a1b4e572..959d474a0516 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br class=3D"">@@ -118,6 =
+118,7 @@ struct amdgpu_fence_driver {<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>uint32_t<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>sync_seq;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>atomic_t<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>last_seq;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>bool<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>initialized;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>bool<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>irq_enabled;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct amdgpu_irq_src<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>*irq_src;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>unsigned<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>irq_type;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct timer_list<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fallback_timer;</blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_AF20CCA0-3AFC-4760-96C0-D6A05048FBDB--
