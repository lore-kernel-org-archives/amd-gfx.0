Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3487C5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 12:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB13E10EB68;
	Tue, 11 Aug 2026 12:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="aXcsY8Kr";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDC910E92F
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786379082; x=1786983882; i=spasswolf@web.de;
 bh=tgLw8p75hGr9pWm+3EdGInGyS6PcPItULfSBrDtimMQ=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aXcsY8Kr6nVSYUcqo2kI3ypQX0nuD3gOknsOL7GChWJU1laSspRIoIRb3/27HVUj
 UJRQLyQEAVH3PhBl8vDtScTcScB+PIGy0T13nsJVGEYokO+7Dmw/1wKIsF/0zfFk2
 q0CAhJrykA6WtHYYxiO66K+0o4LVcLbDLyj+l3HsVY8px66wDn03kgOFbPBWGGxjX
 V12dnCQViLEAKoHUYdZ/ZlYlauyuoxVZWEQOcT7JzP9HopaNat7cF3qPGG/HyKr7K
 +gWYo9cG60jubnznajNPuFprSwolJiXe9egOXY44gDkGOYgrPPHGWes/cvuR72jz4
 /OuJI0bxIIlRSLthyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1wxsTp1EaB-00uE2t; Mon, 10
 Aug 2026 18:24:42 +0200
Message-ID: <5b571b7ce1c81d3757061a4378db0ced65a86b58.camel@web.de>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org, Amber Lin
 <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 spasswolf@web.de
Date: Mon, 10 Aug 2026 18:24:41 +0200
In-Reply-To: <CADnq5_Onn1+x_amugN5nBGNHdjM0bKBYr8LLQ_fRWxTNPbaJWQ@mail.gmail.com>
References: <20260705003504.31425-1-spasswolf@web.de>
 <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
 <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
 <CADnq5_Onn1+x_amugN5nBGNHdjM0bKBYr8LLQ_fRWxTNPbaJWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YvYgDu5TzYe6rzBd4MWwHj3dppIl5jWDB1vIu7MZVMeByJo0o+5
 +BtyeD8uF9xPjgVD4bg5kI9paHeMkb1ogtdFLBe5G9UFw9ZrA1cBJ07zdfTuBFyzVOeWaQ8
 VyXMoOY3TS0dum/sNlYU2tPGK8O79jTBlgBH6pXAazNCZ6/0kkb8gRJnGJpYKXE6FldxG1I
 HtWDni979BwQ7TubJu9UQ==
UI-OutboundReport: notjunk:1;M01:P0:1dc7AbcoiPw=;otvnDR08MspGGMhOPvlS1zAd8T3
 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
X-Mailman-Approved-At: Tue, 11 Aug 2026 12:05:18 +0000
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

Am Montag, dem 10.08.2026 um 10:15 -0400 schrieb Alex Deucher:
> @Amber Lin
> , @Zhang, Jesse(Jie), @Shaoyun Liu  Can you take a look at the firmware =
version?
>=20
> Alex
>=20
> On Mon, Jul 6, 2026 at 9:34=E2=80=AFAM Bert Karwatzki <spasswolf@web.de>=
 wrote:
> >=20
> > I found the real cause of my problems:
> >=20
> >=20
> > bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *ade=
v)
> > {
> >  u32 ip_maj =3D IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0));
> >  u32 ip_min =3D IP_VERSION_MIN(amdgpu_ip_version(adev, GC_HWIP, 0));
> >  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
> >  printk(KERN_INFO "%s: ip_maj =3D %u ip_min =3D %u mes_sched =3D 0x%x"=
, __func__, ip_maj, ip_min, mes_sched);
> >=20
> >  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
> >  ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
> >  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
> > }
> >=20
> > returns false on my machine (because mes_sched is not large enough)
> >=20
> > [ T8549] amdgpu_mes_queue_reset_by_mes_supported: ip_maj =3D 12 ip_min=
 =3D 0 mes_sched =3D 0x76
> >=20
> > So I skipped the call to amdgpu_mes_queue_reset_by_mes_supported()
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 5c9dfb0c424f..462f20aeb681 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -448,17 +448,22 @@ static int reset_queues_mes(struct device_queue_=
manager *dqm, struct queue *q)
> >         unsigned int num_hung =3D 0;
> >         int r =3D 0;
> >         struct mes_remove_queue_input queue_input;
> > +       printk(KERN_INFO "entering %s", __func__);
> >=20
> > +       /*
> >         if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
> >                 r =3D -ENOTRECOVERABLE;
> > +               printk(KERN_INFO "%s: reset by mes not supported", __f=
unc__);
> >                 goto fail;
> > -       }
> > +       }*/
> > +       printk(KERN_INFO "%s: skip calling amdgpu_mes_queue_reset_by_m=
es_supported()", __func__);
> >=20
> >         /* reset should be used only in dqm locked queue reset */
> >         if (WARN_ON(dqm->detect_hang_count > 0))
> >                 return 0;
> >=20
> >         if (!amdgpu_gpu_recovery) {
> > +               printk(KERN_INFO "%s: gpu recovery not enabled", __fun=
c__);
> >                 r =3D -ENOTRECOVERABLE;
> >                 goto fail;
> >         }
> > @@ -470,6 +475,7 @@ static int reset_queues_mes(struct device_queue_ma=
nager *dqm, struct queue *q)
> >         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
> >         /* pass the known bad queue info to the reset function */
> >         r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &nu=
m_hung, &queue_input);
> > +       printk(KERN_INFO "%s: amdgpu_gfx_reset_mes_compute() returned =
%d", __func__, r);
> >         if (r)
> >                 goto fail;
> >=20
> > @@ -3231,6 +3237,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_nod=
e *knode, u32 pasid, u32 doorbel
> >         struct qcm_process_device *qpd;
> >         struct queue *q =3D NULL;
> >         int ret =3D 0;
> > +       printk(KERN_INFO "entering %s", __func__);
> >=20
> >         if (!pdd)
> >                 return -EINVAL;
> > @@ -3242,6 +3249,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_nod=
e *knode, u32 pasid, u32 doorbel
> >=20
> >                 list_for_each_entry(q, &qpd->queues_list, list) {
> >                         if (q->doorbell_id =3D=3D doorbell_id && q->pr=
operties.is_active) {
> > +                               printk(KERN_INFO "%s: calling recover_=
bad_queue_mes() for queue %px", __func__, q);
> >=20
> > and got this output when running the hsaruntime (which inject illegal =
opcodes into the
> > command stream) test:
> >=20
> > [  113.811612] [    T645] [drm:gfx_v12_0_bad_op_irq [amdgpu]] *ERROR* =
Illegal opcode in command stream
> > [  113.811675] [   T2558] entering kfd_dqm_suspend_bad_queue_mes
> > [  113.811676] [   T2558] kfd_dqm_suspend_bad_queue_mes: calling recov=
er_bad_queue_mes() for queue ffffa03160950400
> > [  113.811676] [   T2558] entering reset_queues_mes
> > [  113.811677] [   T2558] reset_queues_mes: skip calling amdgpu_mes_qu=
eue_reset_by_mes_supported()
> > [  113.811887] [   T2558] reset_queues_mes: amdgpu_gfx_reset_mes_compu=
te() returned 0
> >=20
> > So even though  amdgpu_mes_queue_reset_by_mes_supported() reported fal=
se,
> > amdgpu_gfx_reset_mes_compute() returns 0, suggesting that resetting ac=
tually works here!
> >=20
> > Perhaps the minimum required mes_sched version for 12.0 can be relaxed=
 to 0x76 to solve this:
> >=20
> > From 6d7af652177063963012eb4df228e99caeb03b31 Mon Sep 17 00:00:00 2001
> > From: Bert Karwatzki <spasswolf@web.de>
> > Date: Mon, 6 Jul 2026 14:36:22 +0200
> > Subject: [PATCH] amdgpu: relax required mes_sched version
> >=20
> > This mes_sched version is actually enough on this hardware:
> > 03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.=
 [AMD/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)
> >=20
> > [    3.200538] [    T537] amdgpu 0000:03:00.0: initializing kernel mod=
esetting (IP DISCOVERY 0x1002:0x7590 0x148C:0x2437 0xC0).
> > [    3.200546] [    T537] amdgpu 0000:03:00.0: register mmio base: 0xD=
FC00000
> > [    3.200547] [    T537] amdgpu 0000:03:00.0: register mmio size: 524=
288
> > [    3.203739] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 0 <common_v1_0_0> (soc24_common)
> > [    3.203740] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 1 <gmc_v12_0_0> (gmc_v12_0)
> > [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 2 <ih_v7_0_0> (ih_v7_0)
> > [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 3 <psp_v14_0_0> (psp)
> > [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 4 <smu_v14_0_0> (smu)
> > [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 5 <dce_v1_0_0> (dm)
> > [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 6 <gfx_v12_0_0> (gfx_v12_0)
> > [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 7 <sdma_v7_0_0> (sdma_v7_0)
> > [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 8 <vcn_v5_0_0> (vcn_v5_0_0)
> > [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 9 <jpeg_v5_0_0> (jpeg_v5_0_0)
> > [    3.203745] [    T537] amdgpu 0000:03:00.0: detected ip block numbe=
r 10 <mes_v12_0_0> (mes_v12_0)
> >=20
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_mes.c
> > index 6c0dde3786e3..c88fdc8a187d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -869,7 +869,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struc=
t amdgpu_device *adev)
> >  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
> >=20
> >  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
> > - ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
> > + ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x76) ||
> >  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
> >  }
> >=20
> > --
> > 2.53.0
> >=20
> >=20
> > Bert Karwatzki

These are the firmware version reported in sysfs:

# find /sys/class/drm/card0/device/fw_version/ -print -type f -exec cat {}=
 \;
/sys/class/drm/card0/device/fw_version/
/sys/class/drm/card0/device/fw_version/pfp_fw_version
0x00000c12
/sys/class/drm/card0/device/fw_version/vcn_fw_version
0x0910c01a
/sys/class/drm/card0/device/fw_version/mec_fw_version
0x00000d0c
/sys/class/drm/card0/device/fw_version/mes_fw_version
0x0000008b
/sys/class/drm/card0/device/fw_version/dmcub_fw_version
0x0a000c00
/sys/class/drm/card0/device/fw_version/me_fw_version
0x00000bc2
/sys/class/drm/card0/device/fw_version/asd_fw_version
0x21000110
/sys/class/drm/card0/device/fw_version/sdma2_fw_version
0x00798e96
/sys/class/drm/card0/device/fw_version/sdma_fw_version
0x00798e96
/sys/class/drm/card0/device/fw_version/smc_fw_version
0x00664600
/sys/class/drm/card0/device/fw_version/sos_fw_version
0x003b0f0d
/sys/class/drm/card0/device/fw_version/imu_fw_version
0x0c2c2500
/sys/class/drm/card0/device/fw_version/rlc_fw_version
0x00bde160
/sys/class/drm/card0/device/fw_version/mes_kiq_fw_version
0x0000008b

In addition dmesg reports a problem with the mes version:

[    4.353074] [    T489] amdgpu 0000:03:00.0: MES firmware reports incorr=
ect version in ucode binary (0x1 vs 0x8b)

Both these result use the firmware package shipped by debian sid:
ii  firmware-amd-graphics         20260622-1      all     Binary firmware =
for AMD/ATI graphics and NPU chips

The earlier result of mes_sched =3D 0x76 is probably from the old firmware=
 (debian stable version 20250410), but
the gpu resets also occur with the new firmware from debian sid.

Bert Karwatzki
