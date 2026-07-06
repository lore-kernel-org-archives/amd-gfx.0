Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D749CC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 13:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6134010E97A;
	Mon,  6 Jul 2026 13:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="NJmd0NH3";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C29310E970
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783342335; x=1783947135; i=spasswolf@web.de;
 bh=qSQIkj6dO39Yjk3sHi29N3d7bi12JxChcPNUH5flV8s=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NJmd0NH3+HSCMfPhPP/X7nj2BH2fvlz8QMw1MozhKE0o8+OvxIupAgzSnmDTBlie
 TZfC+AoPY31xu7IpmrwpMgMlHrzylS/6q5RdbIl09qJAQ0eoDDCzArtOTLakQqKGd
 Fa3jRrzlQR0rQY9JBVCA5ECBsqZXIoqlpHH33S0JAPr+BuoxIuZC3NRr5+mjpikba
 D9iU2pQ26gjj6Fz5PiJ9MxQoD8vRREXzvXDBOwkgCjvHP3pTk9u38IN4D5Avqs97P
 N6KWXQtn65d8wNUtshYo+pMp+vuTOcdWB1rntGjNRPpBdkXXVaG6fHeUKU99pFXUw
 CSbJdo0qQer8og5quQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1x6jsq47Bx-010rTr; Mon, 06
 Jul 2026 14:46:54 +0200
Message-ID: <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-next@vger.kernel.org, Jesse Zhang <jesse.zhang@amd.com>, Amber Lin
 <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 spasswolf@web.de
Date: Mon, 06 Jul 2026 14:46:53 +0200
In-Reply-To: <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
References: <20260705003504.31425-1-spasswolf@web.de>
 <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZA8JEdp8F6Oj+geMQVHSLVa5F8g2ErHdSqAem60FVyUgMl3QQL
 KKQBfg7FCautuCJSH/gUEsAB+iUu35F+aTOBS0ljfX1mrA8Z0C6qQZ0um5chxf0ddlBVe8R
 ug+3PGjYlgKTJf5h4vUGi895tqfCnPkUDcUCHRf18zosBg5rK2pXj4DAroe7PAnR/E2W7sQ
 9jIewv6F7HtWdRvQbdi2Q==
UI-OutboundReport: notjunk:1;M01:P0:FHcrv543BPg=;e7kwthYjli/tKHybpNHc8GeQdAl
 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
 Eo3xPBJBkA7bAjYj15e3RAtAvcQ=
X-Mailman-Approved-At: Mon, 06 Jul 2026 13:09:56 +0000
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

I found the real cause of my problems:


bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
{
 u32 ip_maj =3D IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0));
 u32 ip_min =3D IP_VERSION_MIN(amdgpu_ip_version(adev, GC_HWIP, 0));
 u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
 printk(KERN_INFO "%s: ip_maj =3D %u ip_min =3D %u mes_sched =3D 0x%x", __=
func__, ip_maj, ip_min, mes_sched);

 return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
 ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
 ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
}

returns false on my machine (because mes_sched is not large enough)

[ T8549] amdgpu_mes_queue_reset_by_mes_supported: ip_maj =3D 12 ip_min =3D=
 0 mes_sched =3D 0x76

So I skipped the call to amdgpu_mes_queue_reset_by_mes_supported()

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 5c9dfb0c424f..462f20aeb681 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -448,17 +448,22 @@ static int reset_queues_mes(struct device_queue_mana=
ger *dqm, struct queue *q)
        unsigned int num_hung =3D 0;
        int r =3D 0;
        struct mes_remove_queue_input queue_input;
+       printk(KERN_INFO "entering %s", __func__);
=20
+       /*
        if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
                r =3D -ENOTRECOVERABLE;
+               printk(KERN_INFO "%s: reset by mes not supported", __func_=
_);
                goto fail;
-       }
+       }*/
+       printk(KERN_INFO "%s: skip calling amdgpu_mes_queue_reset_by_mes_s=
upported()", __func__);
=20
        /* reset should be used only in dqm locked queue reset */
        if (WARN_ON(dqm->detect_hang_count > 0))
                return 0;
=20
        if (!amdgpu_gpu_recovery) {
+               printk(KERN_INFO "%s: gpu recovery not enabled", __func__)=
;
                r =3D -ENOTRECOVERABLE;
                goto fail;
        }
@@ -470,6 +475,7 @@ static int reset_queues_mes(struct device_queue_manage=
r *dqm, struct queue *q)
        queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
        /* pass the known bad queue info to the reset function */
        r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hu=
ng, &queue_input);
+       printk(KERN_INFO "%s: amdgpu_gfx_reset_mes_compute() returned %d",=
 __func__, r);
        if (r)
                goto fail;
=20
@@ -3231,6 +3237,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *k=
node, u32 pasid, u32 doorbel
        struct qcm_process_device *qpd;
        struct queue *q =3D NULL;
        int ret =3D 0;
+       printk(KERN_INFO "entering %s", __func__);
=20
        if (!pdd)
                return -EINVAL;
@@ -3242,6 +3249,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *k=
node, u32 pasid, u32 doorbel
=20
                list_for_each_entry(q, &qpd->queues_list, list) {
                        if (q->doorbell_id =3D=3D doorbell_id && q->proper=
ties.is_active) {
+                               printk(KERN_INFO "%s: calling recover_bad_=
queue_mes() for queue %px", __func__, q);

and got this output when running the hsaruntime (which inject illegal opco=
des into the
command stream) test:

[  113.811612] [    T645] [drm:gfx_v12_0_bad_op_irq [amdgpu]] *ERROR* Ille=
gal opcode in command stream
[  113.811675] [   T2558] entering kfd_dqm_suspend_bad_queue_mes
[  113.811676] [   T2558] kfd_dqm_suspend_bad_queue_mes: calling recover_b=
ad_queue_mes() for queue ffffa03160950400
[  113.811676] [   T2558] entering reset_queues_mes
[  113.811677] [   T2558] reset_queues_mes: skip calling amdgpu_mes_queue_=
reset_by_mes_supported()
[  113.811887] [   T2558] reset_queues_mes: amdgpu_gfx_reset_mes_compute()=
 returned 0

So even though  amdgpu_mes_queue_reset_by_mes_supported() reported false,
amdgpu_gfx_reset_mes_compute() returns 0, suggesting that resetting actual=
ly works here!

Perhaps the minimum required mes_sched version for 12.0 can be relaxed to =
0x76 to solve this:

=46rom 6d7af652177063963012eb4df228e99caeb03b31 Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Mon, 6 Jul 2026 14:36:22 +0200
Subject: [PATCH] amdgpu: relax required mes_sched version

This mes_sched version is actually enough on this hardware:
03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AM=
D/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)

[    3.200538] [    T537] amdgpu 0000:03:00.0: initializing kernel modeset=
ting (IP DISCOVERY 0x1002:0x7590 0x148C:0x2437 0xC0).
[    3.200546] [    T537] amdgpu 0000:03:00.0: register mmio base: 0xDFC00=
000
[    3.200547] [    T537] amdgpu 0000:03:00.0: register mmio size: 524288
[    3.203739] [    T537] amdgpu 0000:03:00.0: detected ip block number 0 =
<common_v1_0_0> (soc24_common)
[    3.203740] [    T537] amdgpu 0000:03:00.0: detected ip block number 1 =
<gmc_v12_0_0> (gmc_v12_0)
[    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number 2 =
<ih_v7_0_0> (ih_v7_0)
[    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number 3 =
<psp_v14_0_0> (psp)
[    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number 4 =
<smu_v14_0_0> (smu)
[    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number 5 =
<dce_v1_0_0> (dm)
[    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number 6 =
<gfx_v12_0_0> (gfx_v12_0)
[    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number 7 =
<sdma_v7_0_0> (sdma_v7_0)
[    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number 8 =
<vcn_v5_0_0> (vcn_v5_0_0)
[    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number 9 =
<jpeg_v5_0_0> (jpeg_v5_0_0)
[    3.203745] [    T537] amdgpu 0000:03:00.0: detected ip block number 10=
 <mes_v12_0_0> (mes_v12_0)

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mes.c
index 6c0dde3786e3..c88fdc8a187d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -869,7 +869,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct am=
dgpu_device *adev)
 u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
=20
 return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
- ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
+ ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x76) ||
 ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
 }
=20
=2D-=20
2.53.0


Bert Karwatzki
