Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53ADC624DA
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 19:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A9310E177;
	Thu,  3 Sep 2026 19:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XBEsuH0k";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDFD10E177
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 19:25:18 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbe4592c193so31065a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Sep 2026 12:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463518; cv=none;
 d=google.com; s=arc-20260327;
 b=AuwjW0jWE6B+UD2ej53LUk6Ne2HKEFZunvrekF+WEVST7NEXBev/M9dgkVPGgw3BXp
 W5Enq/HHNipEKgKxTuySqUFurbRqw3OsgrmicIjo+LymX/oV6HhgMbSfNzwXfNW4hxUF
 pQt+GK3BwRWmScylUvS0CRfFvzL02y5bqWW1OM6nMv8AeIV58OWxLaygewwL67QwNsIP
 LCPq5EHBoa+ZGr6Ucv4EggN7+8J5l6jRbR2Pnveh/E1t5ziHzJ0A8Corv5yfckG2Bbxh
 6KWUV49u5PI/Obkl6l/KXWXXxHWmglknntzni5LJaPpxxJRZvrVTgdm1NEcMkx9++NPc
 gwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qnNNC8Nn7jkNz7FjqcWbXfWT+CEkgWrT8eUXY1uiiDs=;
 fh=nV7O7ZvrEXClH0+OVsSKlRbbPPwH9zMzJ13ak4xFzAw=;
 b=UpB9g5VUDaHBut/6HVin0qIuuOqa5S3gtz0ArgKWyWwTANi3PnGqYP35a9TezilFLb
 cJcVoXHQhkJo13Q+nk4f1fFyzZHfM8mqacw71KkF2SDSHWouFvzdiC9J1WL4DHE6Eut3
 TMZzKf37pN1eIllpdeh6JO0AoCgRxwf1jpKoH8nJW6Y22Aocn2X2OQw+Br6XgD0DNkv8
 dGYkKR7/6d7BC8TgmVFDxneNZ3PNdPmMAVIebDQfFXNTdAiAdwSodDANdQKHU8Q1ZKZw
 yt6moJj2ur92xsowKR3AFuVzGjzBcrkH3VU3HH/hF1fJj1NZsTkk+ZKklmVVq29/WQ+C
 W2Zw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788463518; x=1789068318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qnNNC8Nn7jkNz7FjqcWbXfWT+CEkgWrT8eUXY1uiiDs=;
 b=XBEsuH0k+0DLtHUYK6vTqgWp70C62ympJEZQ1DNjPy1ud1t0ru+lKRWiQIHUe46wYZ
 U1iB2hXlJ2PKSTpx1aknu4wr1TY0Z7r4YsErk4tB3wYzuO4KfrgLe41kXjM4HteWePpq
 oIaEdimQ8sQd+dzKQ/EgG1MMRpeAm+2dgw7oWNV+4r9oXn+Lxb2oCL6oIOhm0HDUmO74
 6sZF6G4IZvWSVVK7LmLSypyxOf4i9nxrz41fwD6zJmoosg9EwfP/sKFqRiOCc6C1/qLf
 OCXdeUqfduEEwASE+1sV/GO4xDL23IujGYlBsc2dDWAvSIbQmtKJUmB0qGmciSOqPjgs
 +P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463518; x=1789068318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnNNC8Nn7jkNz7FjqcWbXfWT+CEkgWrT8eUXY1uiiDs=;
 b=hQtEpWSvNLxIzuMFni5hwPGLUz9FqmnFGon21HhMTjJUXVKMVp8Vxh3NpkxTGAiGw0
 YnT7eTNk/IO6JOrIfw+Gamc/YILibOincznmOeJ1w3oiOn5ie5IeUdoYUzJ2tjIgNeK8
 wKfS0pgYV8d8nU/1Y8XmSlYvP7ikBuDhG6fPjTy+uh6Ie85wfEVAguCNMghaQXhlVLiK
 A89yD8JPf9bhPZOiPcLhxZ/xjTQgcJebIDtvN3oYxzENqxgGDDNs6a4GbM8VUCuhNlQw
 YLZTARGnFeAIaU/hdczHoDkhXXNiWIpsky53zSpJERe9gc5L3kzrJb46SZWfIj/wTC1o
 wqjA==
X-Gm-Message-State: AFuF++nvMXrmlMUkbaMhmL6b1uAditkqPXgVBITuMTfZk1P2HkXrF11Z
 JenC0OOmsh9hMFum66ZE5NP+ecpXKWTMZ7wnCjMW99T7zxu4K3ORifjMhPb+TOQ8Gk/pnCcu1Zw
 tXdGPfjRPqhVDX2CzXXWgZqUiFWuAtVaEIw==
X-Gm-Gg: AYBFou0rHfd7IWnT7HpKtd1ZB6qxYSZsZiRRtbweal9fwA6RVF7Nt/MY+/hP3381F7Q
 P9Llr8WeyAlE29PPM+NkO31HES+ZYYREn85w9Bye369+5tL/q56Fqhls4r8paVDrbzZr5siQlpW
 F+QQsDQSxdVjYAPFvQyC4sU2dR5IvrHxVPKOHnuwUedzF8MFUusDDqnvEKlc8nisCPOgIlDDeF3
 yEmsh+/IEsq+74jRrxWF5xHFqqk5iE8FYRqHu3iguishwb1CdMsvBxM/17qpWrJJw2fctHbjKXA
 K7jYq/nYQPjVviKApy80DSoMBf/WNqh4k8Y3ZoR5MjMeu6iY7u1mmZ/uj5ixbcOIy2Xhf/9LeZe
 /Qk0GApfF1miAdQRHlpGLU85i1aMr1zE=
X-Received: by 2002:a17:90b:35d2:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-39b2610091bmr637642a91.2.1788463517743; Thu, 03 Sep 2026
 12:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-14-Prike.Liang@amd.com>
In-Reply-To: <20260902125001.621629-14-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Sep 2026 15:25:05 -0400
X-Gm-Features: AcwNN1VihC822BA3Y_LBQ1nZpbl7qZt8HimwI_3TbcZSTWVZOyD7hafyXKkrUMI
Message-ID: <CADnq5_OhdxnBp8Z_mS0C0mAsPTKiXzfbYLOOXU4EL3bbyBp6nQ@mail.gmail.com>
Subject: Re: [PATCH 14/18] drm/amdgpu: skip gfx switch_power_profile during
 GPU reset
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Sep 2, 2026 at 8:50=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> During resume from GPU reset, the gfx idle work may invoke switch_power_p=
rofile
> before the reset completes. This causes the following assert error becaus=
e the
> register access occurs without first releasing the GPU reset semaphore:
>
> [ 1576.768935] CR2: 0000559ea133ead0 CR3: 00000002e6c42000 CR4: 000000000=
0350ef0
> [ 1576.768940] Call Trace:
> [ 1576.768944]  <TASK>
> [ 1576.768953]  amdgpu_device_rreg+0x21/0x50 [amdgpu]
> [ 1576.769158]  smu_msg_v1_send_msg+0x1a4/0x6e0 [amdgpu]
> [ 1576.769437]  smu_cmn_send_smc_msg_with_params_ext+0xba/0x120 [amdgpu]
> [ 1576.769721]  smu_cmn_send_smc_msg_with_param+0x33/0x40 [amdgpu]
> [ 1576.769993]  smu_v13_0_0_set_power_profile_mode+0x192/0x2b0 [amdgpu]
> [ 1576.770267]  smu_bump_power_profile_mode+0x5d/0x80 [amdgpu]
> [ 1576.770538]  smu_switch_power_profile+0xa4/0xf0 [amdgpu]
> [ 1576.770839]  amdgpu_dpm_switch_power_profile+0x6f/0x90 [amdgpu]
> [ 1576.771210]  amdgpu_gfx_profile_idle_work_handler+0xe9/0x130 [amdgpu]
> [ 1576.771460]  process_one_work+0x23e/0x6f0
> [ 1576.771491]  worker_thread+0x1c4/0x380
> [ 1576.771506]  kthread+0x10c/0x150
> [ 1576.771512]  ? __pfx_worker_thread+0x10/0x10
> [ 1576.771518]  ? __pfx_kthread+0x10/0x10
> [ 1576.771530]  ret_from_fork+0x314/0x390
> [ 1576.771537]  ? __pfx_kthread+0x10/0x10
> [ 1576.771546]  ret_from_fork_asm+0x1a/0x30
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index ce526db4d24a..808be6c425bf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -348,7 +348,8 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_dev=
ice *adev,
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>         int ret =3D 0;
>
> -       if (amdgpu_sriov_vf(adev))
> +       if (amdgpu_sriov_vf(adev) ||
> +               amdgpu_in_reset(adev))
>                 return 0;
>
>         if (pp_funcs && pp_funcs->switch_power_profile) {
> @@ -367,7 +368,8 @@ int amdgpu_dpm_pause_power_profile(struct amdgpu_devi=
ce *adev,
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>         int ret =3D 0;
>
> -       if (amdgpu_sriov_vf(adev))
> +       if (amdgpu_sriov_vf(adev) ||
> +               amdgpu_in_reset(adev))
>                 return 0;
>
>         if (pp_funcs && pp_funcs->pause_power_profile) {
> --
> 2.34.1
>
