Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D50DD778AF
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 21:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75E310E2EC;
	Fri, 23 Jan 2026 21:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gAUZNGr8";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C55210E2EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 21:02:39 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12335a3e1edso80668c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 13:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769202159; cv=none;
 d=google.com; s=arc-20240605;
 b=XZxvJL1AF5i58KQn6fy9dUWoYa8dUoOAzgvhTq4C8aYLd4cSxBMXDOqHbVK5hV8vdy
 e8D8sziA5NPIc2QaUls+hhrTDhaXB2TGjvfgsBZatogkB8ylJyIVo12YPxLCBcfb3Blx
 Dx2P9A3+RlDjmvO6W3CoqAqBTljb1s4uuAj2YrMeInSVMxWcBCQmVND1bETJ7JwlS9Kl
 nGAMKcfhGo3pd9dWmSv03hI6pAQGHEB4OhgEyA5HUq1zB3EmG5jHDLYr4g4MhT/XacQY
 ZOBi4SO64JBDlTkRXRPmkRNtcxUFBXFGHZwRy+JIFW6neLaA9+bbBa5Ncm7Tgl1z/I92
 o23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vbB/Y/ycMyJ7mEeBbo1n9ItS+IAqciWzPVcd9uOPfTQ=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=Ei7to24Pit7KRNRp5rg7XiLHYYjwsSsMamCcdzecDlbWA4skhgwKgmH7Pfqo75EeSe
 GYrw9fwWBEfBPwTEC4aS0Y/jBb7FNqfaYy4BNJw4l4cqXapbYq+6iCz21npiunPbW8XZ
 bN4HQvbe5HxL/w8oz9at8fr3t8VhdVAq7PX5B5ioGockuIZUtSnr/S1iY16Y4UJRR56T
 hVhwbq/pfQ4vpjvhOwQZmyzwByATTg8iD7YmF567Nx/Dv8wmehjKDa3CuksglG4R6lch
 koYpbgxewiw2iWL56PuNaDk71+53UfX0zn6Eh+LOSZrNmeAuWrVD45xiuDvZgc4LssYC
 q/cA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769202159; x=1769806959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbB/Y/ycMyJ7mEeBbo1n9ItS+IAqciWzPVcd9uOPfTQ=;
 b=gAUZNGr8kTxeEYkJzKteAf8bn0TJu5lLiCpNLT+zlv4+K6RmZIxPMNyZNi8cDab+UU
 3qKLg9tiys39DiSP8BgWiyV3atG7RSCqfpJiH5QjGzDPIbZ1JGoSB3hBTu5YFLgtBLlO
 og7rSamp9yVKTqNdmILJ+CkN/GN6r3be6zb1xbIz2bGugb+tT+joZXS2b3RZ6ygwipqA
 MmqBOX0RO8CKKMRB7fwnwN7a+MfbG2MImMm9ptIDpQ4JMEjxK1DXiPCfX9xxmTUhA+zW
 RKBvd3uhU+gzF60lLNzmBGknhoFx2QzZ/OQxwtqnR2oUv5MxfQfwjrQ0ULa9CoTQRcdI
 FPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769202159; x=1769806959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vbB/Y/ycMyJ7mEeBbo1n9ItS+IAqciWzPVcd9uOPfTQ=;
 b=kiZ2iSdsLqOfcxU/HrHFYAmhVRIElja2K6pIOLgf1evIWwKYTkPkt1m/B5xZvfn6nf
 3Xr+MDu+lcsq1WeIlOUUJBQJiyRMreqLnTVz+QaRyZwldXvZpHV2PepwaNTrTN2a4oHU
 cUHYphhG3ZGGtpG+EP8tH9HatEVHjkWzrD/S+qWUbx67kVbcRuFck3hNgJtSvEvCKwUU
 kovAXKC+8gxJDj31R27fpIWOlFlE5xp7qIwSXi1Md7myYsRACtQ7OKU4hzisBD6C0svR
 pfaK/6vPASy55OLaJXtDua6xbmeif7MrtIW+UQ9YQ5KM1dOf7f5UlfQRjDDaDhZ3dwmz
 jPmA==
X-Gm-Message-State: AOJu0Yz6TbsEttJJ//3IGhOK4U61714GGbeBBZSuBJeAMV45TJ25b8Fs
 owtHk7qXX/EGEL1lzSZh7XAJ7UabcsZWh0diRsTPRKOOQ0X+TOxuF0pprvTRfEm59U6LUrHM2KA
 ZDjzH8TJqlKN/xkuNsgtHDpkOPICYJFs=
X-Gm-Gg: AZuq6aJXXnkuRVmVPaLGYKeNMYHMXQfKN32YUYmb6V81T3/amfZj0Be/PeNL25KHTRO
 EDu98kt9XlVwVeDPZn0K9QHnNtwo/Z3NB51sqAHLd2ofM2DkvatdMnDeg/YeC3msbtFV+efdSR/
 6c3/JbECIyuNbpQMIlydqekBz5v8myets07+BJ19iTMGwLvJnW+GeSMSlaIgWWblUiATOdtPg9E
 1H5qHS+DxNJThJDDmlWrXUe5XV2CMho9utONAREp8yhiMWZhFZik3BEJpLRzC5NifpcfJpm
X-Received: by 2002:a05:7022:2486:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-124855955bfmr230123c88.0.1769202158710; Fri, 23 Jan 2026
 13:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
 <20260123100219.1693990-4-Jesse.Zhang@amd.com>
In-Reply-To: <20260123100219.1693990-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 16:02:27 -0500
X-Gm-Features: AZwV_QgIuyIb1TasthKjhZkNBuAxzazg6KTSaSVyaMtPmRokJA4FZFqx63mL3WA
Message-ID: <CADnq5_OZ5TCbwvCN6Due-LNvX4s6gcG4r7PMvdP1FueTGi7A6g@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amdgpu/gfx12: add CU mask support for compute MQD
 initialization
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Jan 23, 2026 at 5:17=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Extend the GFX12 compute MQD initialization to support
> Compute Unit (CU) masking for fine-grained resource allocation.
> This allows compute queues to be limited to specific CUs for
> performance isolation and debugging purposes.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Patches 1-4:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 ++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 6cd16f016c37..73478dd0f6ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3110,6 +3110,37 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(stru=
ct amdgpu_device *adev)
>         return gfx_v12_0_cp_gfx_start(adev);
>  }
>
> +static void gfx_v12_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev=
,
> +                                             struct v12_compute_mqd *mqd=
,
> +                                             struct amdgpu_mqd_prop *pro=
p)
> +{
> +       uint32_t se_mask[8] =3D {0};
> +       uint32_t wa_mask;
> +       bool has_wa_flag =3D prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_=
ENABLE |
> +                                         AMDGPU_UPDATE_FLAG_DBG_WA_DISAB=
LE);
> +
> +       if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
> +               return;
> +
> +       if (has_wa_flag) {
> +               wa_mask =3D (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_E=
NABLE) ?
> +                         0xffff : 0xffffffff;
> +               mqd->compute_static_thread_mgmt_se0 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se1 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se2 =3D wa_mask;
> +               mqd->compute_static_thread_mgmt_se3 =3D wa_mask;
> +               return;
> +       }
> +
> +       amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
> +                                               prop->cu_mask_count, se_m=
ask);
> +
> +       mqd->compute_static_thread_mgmt_se0 =3D se_mask[0];
> +       mqd->compute_static_thread_mgmt_se1 =3D se_mask[1];
> +       mqd->compute_static_thread_mgmt_se2 =3D se_mask[2];
> +       mqd->compute_static_thread_mgmt_se3 =3D se_mask[3];
> +}
> +
>  static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *=
m,
>                                       struct amdgpu_mqd_prop *prop)
>  {
> @@ -3243,6 +3274,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         /* set UQ fenceaddress */
>         mqd->fence_address_lo =3D lower_32_bits(prop->fence_address);
>         mqd->fence_address_hi =3D upper_32_bits(prop->fence_address);
> +       /* set CU mask */
> +       gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
>
>         return 0;
>  }
> --
> 2.49.0
>
