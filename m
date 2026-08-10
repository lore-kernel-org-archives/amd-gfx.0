Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745D6C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 14:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0730110E8A6;
	Mon, 10 Aug 2026 14:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOJ2FVRo";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C90A10E8A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 14:15:42 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso147249a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 07:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371342; cv=none;
 d=google.com; s=arc-20260327;
 b=Hq5S0/IVLnzKI5QMgrsCIxQYOAlvJXlajTWTXR/J/QFhyWSn5FZw2Wb4gzom8zlKLQ
 p2+J0mYXlAkHJ5z5jzJsVKt2ZNnhEMEHfA12rKWyS9iSstFNlU2DGDHwP9Rlj0hiyBL2
 oABbi+rQedItQylEI2FGGizzL2v/0H0YWUWuVNTXKJJ0WRD/CVSA2nyoLboJJXHNtFtL
 bHQU9PKaSl39iiczX1tB79a31YssH7GKE3uSK6sr3YPTSsryWlCtxn5yOPSpy86HES88
 XgvpinjyR1i6TcSDuFmTwX9+5LUuW26e/y4Kh0NdueOimnsaVWn+mQANFIRUxyVLDmEu
 mvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3wmKivrj/rqFtC9iMGpuDry6I3yLLumvfwoXy2NUyKA=;
 fh=7r9xVXlHfXiBP77+Dl6vdzjgJoFSNdyIXs8+uMIegqQ=;
 b=Do204vum7BDN1A059kizPEYX4JPda4y/cqDZ4kd5iOvHua+VjR4zc8ilINgZm00Voo
 gP6RPXa2ZbTDidMpQR+5lqRFfukrCgvVFBFbgrQOnZwE3+WNjd2Oli2lr2jJvoB8dhHs
 JwXKohm3gS4BL0Vi2lnf30XGUOM589cHdb4/OxAaYtFt+rAVEtseKlFCcsiCPjpPuTTW
 FOUSBS7AmseOyaUhexIiIO13QmjycaFsz35Tj4L+0Zlpb7Skg4bU4MaMMyvjnpFiAcwf
 V1L+x5/RyRqwDO8YCgB72IRaM1wWh16tWjBZsnwCnl7UE9G86F375NGpq098YZTI7KPR
 XJpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786371342; x=1786976142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3wmKivrj/rqFtC9iMGpuDry6I3yLLumvfwoXy2NUyKA=;
 b=VOJ2FVRo3Qwdz1c5pQULdU+WvtQbjNCwb0KjUCEoIlE1ceN1m4mZTktXhT0fllLEpv
 eJkQCTzhYT2MEOhVD4jFPPWIUqdgPaa5797rp46Zp5r6h90xX8PBCHs85CZycizfo38G
 +rwA778iObfQCCGjUZVKfu0KZYJRX1nAuVoadfVXEzSgVgPoA2b7NvPNQo11vJwYTuTP
 GEWyDh8r/6i9NOBIyi2CabiV4oGnAcdNtfu0AsTtWJljZEu43dyj/vmKacKOns6JoVkK
 5BbkJRw52lXheI0Vp0KolhsGhrAtUZhyFB1lnLlpUBIQcfPmxGGTMh818fi3B81lzzan
 0ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371342; x=1786976142;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wmKivrj/rqFtC9iMGpuDry6I3yLLumvfwoXy2NUyKA=;
 b=Lj/t4A446VgDvsmcVITLEO/WPZ3l7DAyAligoaGmo5URJUiyZ+/UTKlxb8vgDP2iw+
 UO1+ceaGX8k/214zpbLYk7QG7Y/M6DFwucB/s4VPcJXJLuc/4KLyw895Aye0dBvmGoKt
 tC1yomGU55egtFTtRXHmuZJGyvjqsf+19ZGTf3NfYDA1MCxFPpYyP8Zn8v8utz2lGWlv
 7UcTkr1L8YJ7n68+7FgZMdUc/3imxin5o7lKdi99gvuoReXv/4dwdvT0DgIasluD4tH6
 NP4udtM6CgoIGEBOzyf5vos01IoJtqG1c4ufWL0gcsY40sqKZag/upLhfVG0zyGUvFaJ
 t2xw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1xA5Wt7b/PYldh5IIRXOv+fj33RGHepDGdWnH1e/c3v8CphmTXX+jDbrYJ7mvVdd3merVb28M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY+3VMCq5m96kiXQnKgRzcDMnUX3xwuiCWrEzogNZER8V5loj7
 oVImPBNXS/g0CsTYNEEDO1r5PupqFaWkUJo8v9sawBmAQMefsF+tHFXeqyb3rwh9Mpmetsugyck
 GXQNyy7tlE8aBjgEIPvFUFEsXbnu8ODg=
X-Gm-Gg: AR+sD13wrpaW7YmyBRnycnWzSfvQpV5XrX/6PfbhMVaMdp6sbEp9ZMR4Jg8mRoAWSvG
 3XHwDhYQ0qB7uMQNUwwYioxhCapFholS4dmWywQRWiXLcbcRUMNWx0ItUJgzknxiAqXv69o4vb/
 WVwBPdM2dDbdsoBTOWu4kUqWeW0Q0N5QlWFSmUc6cA4uLSZdd8pMF4u8oM4/HJ7y0G9FdMgwUvV
 F1njsPacaYLP+XZiK25oqQNFtoJBBPMhBJxXnq+gKNJ7cqGC1a3G7OlHoz5R/4OmNOZf6HQfEKO
 Y8hwV+0EIhXWbrLER5hP880lRFdIDBJZnnKb0RWd2AJnHT9FCdN8v7UcpKD/4RlqfE34zbacXmT
 H+ABz3iFZYOUTpuCWUJBmGcb5+Z/UxEo=
X-Received: by 2002:a17:90b:3a81:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-3903c6e93e6mr29667613a91.2.1786371341337; Mon, 10 Aug 2026
 07:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260705003504.31425-1-spasswolf@web.de>
 <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
 <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
In-Reply-To: <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 10:15:29 -0400
X-Gm-Features: AUfX_mwROryHi7d7AdMoij38boT3bzzR7WqjIiWSi4Ic1xbDYn4wwGnJPyFKJS0
Message-ID: <CADnq5_Onn1+x_amugN5nBGNHdjM0bKBYr8LLQ_fRWxTNPbaJWQ@mail.gmail.com>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
To: Bert Karwatzki <spasswolf@web.de>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, Shaoyun Liu <Shaoyun.Liu@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org, 
 Amber Lin <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

@Amber Lin
, @Zhang, Jesse(Jie), @Shaoyun Liu  Can you take a look at the firmware ver=
sion?

Alex

On Mon, Jul 6, 2026 at 9:34=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> wr=
ote:
>
> I found the real cause of my problems:
>
>
> bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
> {
>  u32 ip_maj =3D IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0));
>  u32 ip_min =3D IP_VERSION_MIN(amdgpu_ip_version(adev, GC_HWIP, 0));
>  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
>  printk(KERN_INFO "%s: ip_maj =3D %u ip_min =3D %u mes_sched =3D 0x%x", _=
_func__, ip_maj, ip_min, mes_sched);
>
>  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
> }
>
> returns false on my machine (because mes_sched is not large enough)
>
> [ T8549] amdgpu_mes_queue_reset_by_mes_supported: ip_maj =3D 12 ip_min =
=3D 0 mes_sched =3D 0x76
>
> So I skipped the call to amdgpu_mes_queue_reset_by_mes_supported()
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5c9dfb0c424f..462f20aeb681 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -448,17 +448,22 @@ static int reset_queues_mes(struct device_queue_man=
ager *dqm, struct queue *q)
>         unsigned int num_hung =3D 0;
>         int r =3D 0;
>         struct mes_remove_queue_input queue_input;
> +       printk(KERN_INFO "entering %s", __func__);
>
> +       /*
>         if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
>                 r =3D -ENOTRECOVERABLE;
> +               printk(KERN_INFO "%s: reset by mes not supported", __func=
__);
>                 goto fail;
> -       }
> +       }*/
> +       printk(KERN_INFO "%s: skip calling amdgpu_mes_queue_reset_by_mes_=
supported()", __func__);
>
>         /* reset should be used only in dqm locked queue reset */
>         if (WARN_ON(dqm->detect_hang_count > 0))
>                 return 0;
>
>         if (!amdgpu_gpu_recovery) {
> +               printk(KERN_INFO "%s: gpu recovery not enabled", __func__=
);
>                 r =3D -ENOTRECOVERABLE;
>                 goto fail;
>         }
> @@ -470,6 +475,7 @@ static int reset_queues_mes(struct device_queue_manag=
er *dqm, struct queue *q)
>         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>         /* pass the known bad queue info to the reset function */
>         r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_h=
ung, &queue_input);
> +       printk(KERN_INFO "%s: amdgpu_gfx_reset_mes_compute() returned %d"=
, __func__, r);
>         if (r)
>                 goto fail;
>
> @@ -3231,6 +3237,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *=
knode, u32 pasid, u32 doorbel
>         struct qcm_process_device *qpd;
>         struct queue *q =3D NULL;
>         int ret =3D 0;
> +       printk(KERN_INFO "entering %s", __func__);
>
>         if (!pdd)
>                 return -EINVAL;
> @@ -3242,6 +3249,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *=
knode, u32 pasid, u32 doorbel
>
>                 list_for_each_entry(q, &qpd->queues_list, list) {
>                         if (q->doorbell_id =3D=3D doorbell_id && q->prope=
rties.is_active) {
> +                               printk(KERN_INFO "%s: calling recover_bad=
_queue_mes() for queue %px", __func__, q);
>
> and got this output when running the hsaruntime (which inject illegal opc=
odes into the
> command stream) test:
>
> [  113.811612] [    T645] [drm:gfx_v12_0_bad_op_irq [amdgpu]] *ERROR* Ill=
egal opcode in command stream
> [  113.811675] [   T2558] entering kfd_dqm_suspend_bad_queue_mes
> [  113.811676] [   T2558] kfd_dqm_suspend_bad_queue_mes: calling recover_=
bad_queue_mes() for queue ffffa03160950400
> [  113.811676] [   T2558] entering reset_queues_mes
> [  113.811677] [   T2558] reset_queues_mes: skip calling amdgpu_mes_queue=
_reset_by_mes_supported()
> [  113.811887] [   T2558] reset_queues_mes: amdgpu_gfx_reset_mes_compute(=
) returned 0
>
> So even though  amdgpu_mes_queue_reset_by_mes_supported() reported false,
> amdgpu_gfx_reset_mes_compute() returns 0, suggesting that resetting actua=
lly works here!
>
> Perhaps the minimum required mes_sched version for 12.0 can be relaxed to=
 0x76 to solve this:
>
> From 6d7af652177063963012eb4df228e99caeb03b31 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Mon, 6 Jul 2026 14:36:22 +0200
> Subject: [PATCH] amdgpu: relax required mes_sched version
>
> This mes_sched version is actually enough on this hardware:
> 03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)
>
> [    3.200538] [    T537] amdgpu 0000:03:00.0: initializing kernel modese=
tting (IP DISCOVERY 0x1002:0x7590 0x148C:0x2437 0xC0).
> [    3.200546] [    T537] amdgpu 0000:03:00.0: register mmio base: 0xDFC0=
0000
> [    3.200547] [    T537] amdgpu 0000:03:00.0: register mmio size: 524288
> [    3.203739] [    T537] amdgpu 0000:03:00.0: detected ip block number 0=
 <common_v1_0_0> (soc24_common)
> [    3.203740] [    T537] amdgpu 0000:03:00.0: detected ip block number 1=
 <gmc_v12_0_0> (gmc_v12_0)
> [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number 2=
 <ih_v7_0_0> (ih_v7_0)
> [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number 3=
 <psp_v14_0_0> (psp)
> [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number 4=
 <smu_v14_0_0> (smu)
> [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number 5=
 <dce_v1_0_0> (dm)
> [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number 6=
 <gfx_v12_0_0> (gfx_v12_0)
> [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number 7=
 <sdma_v7_0_0> (sdma_v7_0)
> [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number 8=
 <vcn_v5_0_0> (vcn_v5_0_0)
> [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number 9=
 <jpeg_v5_0_0> (jpeg_v5_0_0)
> [    3.203745] [    T537] amdgpu 0000:03:00.0: detected ip block number 1=
0 <mes_v12_0_0> (mes_v12_0)
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 6c0dde3786e3..c88fdc8a187d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -869,7 +869,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct a=
mdgpu_device *adev)
>  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
>
>  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
> - ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
> + ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x76) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
>  }
>
> --
> 2.53.0
>
>
> Bert Karwatzki
