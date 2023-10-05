Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36FEE92709
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 15:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AA010E150;
	Thu,  5 Oct 2023 15:11:51 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45A510E150
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 15:11:49 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dceb2b8823so557319fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696518709; x=1697123509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZ8HsXgy8+vl8TJGCcf+hnBNndejrxw4pfmGogq0KzM=;
 b=ErHs0IYDEaY/HgmDTQ1p66xqFTSE/Qnbx0gbYPi9jJXo5dqyBiCIkhJz5Q2TybWEVW
 bHW8XLjRVemGgS2a3BOkKzw8zou2YJIAZkByEg4b9aBEN8twngE6mYT60QTOXwohNPh5
 ApnhE0S2RlfAdRnCZcGjpMzNev2H0z5p1yhG7BfbcGcVHGSQZsM7MSWTCKo9O+SJr0qD
 gpVvn9mKC9wUlOBadR+T6z0QRBFd+64AFjGYfT1LZScclti0vrFMvvQCdSyo0U8gtlgX
 xRbPqiT/7EG2dAuZ22t9CkfEBAd4euKjyUp1qz0Udeinixv3cWY4+GBk4YbS0JM6NXpA
 r99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696518709; x=1697123509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZ8HsXgy8+vl8TJGCcf+hnBNndejrxw4pfmGogq0KzM=;
 b=j0Pi8GUyXMkfdWtLzUsJ7fYcUyBYIaPtk8NOt04HCrBsvjFrFLMfYXAmvb05FlxVTg
 wugkqOKcOt8lcPGtoW1YopY6qRia+yscKcmnv4bSr5mt8/jN3Npee99Cir8AwPMjn3Cz
 zIPQ/3IBCxLAr03tZMsqKoN81PP0Oeh4JXCgAFBUUWRniCOZFpId4RT+9FnCKuKM6yzG
 Apf3d9Ph1m6rrfVVDiRVoi592K3PGk5aO8Fyj+DW7MYwt4TN6KQAZx0DwioTJ4h74AP9
 DNI9T1MAjCAfO+xAQMJUbCbFUAfqd/jaPtjaQlzaaI4n1bfRvhsiL3uEi1HSUoKQAeej
 7n4Q==
X-Gm-Message-State: AOJu0YwpC2DBCYoPpkK8pCX6LYU9YX6LqPlhaDe8smMNPaQ3vrh2su2K
 1rDYoT2wMYvG3gKu/gKZ6CK8pVUIqjx3naLg4rLkQnWq
X-Google-Smtp-Source: AGHT+IHOEaf6z7gNIDHBiIy3PcVubfw0XielmOm2BK1n3AYGDFS+r/x2Rm2bPemWbfxmTlkLFwGpFkB3amxCMqyfUlA=
X-Received: by 2002:a05:6870:3925:b0:1e1:fd34:3574 with SMTP id
 b37-20020a056870392500b001e1fd343574mr875794oap.9.1696518708824; Thu, 05 Oct
 2023 08:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004153410.895387-1-alexander.deucher@amd.com>
 <BN9PR12MB52571DA4201DF6772AE601C8FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB52576BB64B4AB77BBA32D6A5FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52576BB64B4AB77BBA32D6A5FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 11:11:37 -0400
Message-ID: <CADnq5_OTOuvKFjreAmFxK5rrYGjhVrLqz5va-uNR_Yrokws3SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 4, 2023 at 11:47=E2=80=AFPM Zhang, Hawking <Hawking.Zhang@amd.c=
om> wrote:
>
> [AMD Official Use Only - General]
>
> Hmm... thinking about it more, will it override the profile mode/workload=
 for 0xC8 or 0xCC SKU as well. In another words, does it mean the pmfw fix =
is general to all the 13_0_0 SKUs.

Yes, my understanding is that this should apply to all skus.

Alex

>
> Other than that, the patch looks good to me.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,=
 Hawking
> Sent: Thursday, October 5, 2023 11:32
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@am=
d.com>
> Subject: RE: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROC=
m is active (v2)
>
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Wednesday, October 4, 2023 23:34
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@am=
d.com>
> Subject: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is=
 active (v2)
>
> From: Kun Liu <Kun.Liu2@amd.com>
>
> When ROCm is active enable additional SMU 13.0.0 optimizations.
> This reuses the unused powersave profile on PMFW.
>
> v2: move to the swsmu code since we need both bits active in
>     the workload mask.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 684b4e01fac2..83035fb1839a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2447,6 +2447,7 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
>         DpmActivityMonitorCoeffInt_t *activity_monitor =3D
>                 &(activity_monitor_external.DpmActivityMonitorCoeffInt);
>         int workload_type, ret =3D 0;
> +       u32 workload_mask;
>
>         smu->power_profile_mode =3D input[size];
>
> @@ -2536,9 +2537,23 @@ static int smu_v13_0_0_set_power_profile_mode(stru=
ct smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> +       workload_mask =3D 1 << workload_type;
> +
> +       /* Add optimizations for SMU13.0.0.  Reuse the power saving profi=
le */
> +       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &=
&
> +           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(=
13, 0, 0)) &&
> +           ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
> +            (smu->adev->pm.fw_version >=3D 0x004e7300))) {
> +               workload_type =3D smu_cmn_to_asic_specific_index(smu,
> +                                                              CMN2ASIC_M=
APPING_WORKLOAD,
> +                                                              PP_SMC_POW=
ER_PROFILE_POWERSAVING);
> +               if (workload_type >=3D 0)
> +                       workload_mask |=3D 1 << workload_type;
> +       }
> +
>         return smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
> -                                              1 << workload_type,
> +                                              workload_mask,
>                                                NULL);  }
>
> --
> 2.41.0
>
