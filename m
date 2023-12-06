Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B9C10F05
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 14:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35C610E734;
	Wed,  6 Dec 2023 14:10:39 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058D910E733
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 14:10:38 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1fb38f3cb57so2067637fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Dec 2023 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701871837; x=1702476637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyRBh6Qeo930FS3kvvg6eGhhYHlc7LiHhyaOPpvFgVQ=;
 b=EX/qU03vuMWBpP2gwdLFlHZX6w6xAL2Ev+8/LFc2zqv19qIINq05IdJpaSXWurJ+bF
 DtSizhNXXF/BQTwSsKDbEgbOQaD/iHpJssTyIMakIbsLpBJLQtvjAXY0LmfODnRpBeOQ
 UR4e/Du0VxXsrld7EbDhmXJ8VFgP295tBOj7b+ChxJs69XxaPQt6xjHvvRXc9peqBhmV
 bBGPQ7rPrvaUWSp2s7qaCWrOl0LDmPmVbVv1DD04NDYPOULHcd+Ga2FwIhVq+7//D8xt
 JGSvLKuBmi8QvUSZrsB5obQvoINaxRNnOyJpqCbAN+7gLsKW5b5qCYxKDf8U181b5tON
 oMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701871837; x=1702476637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyRBh6Qeo930FS3kvvg6eGhhYHlc7LiHhyaOPpvFgVQ=;
 b=m372yRUVEAe9bk744HRRsdP/xLY3vuB47awVSVyxCY43vslgEWf4Z3CmfqDC4j5t/U
 lPhkgphdT2iN3YhLDD+m4IfnEoIFASt5T6bNFHCpv5NDgQmQi3LEwzUamwSxxx6yrvzV
 znldDDjUfoFzH9XsBEtD0u2vfwbgOG6BMl+y/fjQ6varraODbVQ1NP1u3IUda8CGjXiw
 EJPm8bySoC0/GGUj5nWRn9KveDRVGvAxyQQafy0bM1xqD/OjK28aecTfqxveqY2LeDJ9
 r5uUK425EfhQ0DtcPTGa9qDabAe4aM2Fb3eVHvTKyG3/nsortjnBrUI9/Av9Q45/ShBI
 c6Jw==
X-Gm-Message-State: AOJu0Yzl3XJtHuJk4tI/cGeFpFOEKUUi32NP/dTm+eNKE3CaP5qBIkOo
 U+efSQPNwWEY3VaT/aURZ1vfNwbytNNVAW9Ic4HyEe8V
X-Google-Smtp-Source: AGHT+IHq38Pjzh0lOSl9qm/g9KDxmhwcsLTF7iStNJH65OnLb3QfVrEQvSz8+a7twvUKcZPl9SLrV8oQSwtFXoHltZ8=
X-Received: by 2002:a05:6870:eca2:b0:1fb:14a3:c663 with SMTP id
 eo34-20020a056870eca200b001fb14a3c663mr913552oab.3.1701871837194; Wed, 06 Dec
 2023 06:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20231206124107.1462461-1-lijo.lazar@amd.com>
In-Reply-To: <20231206124107.1462461-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Dec 2023 09:10:25 -0500
Message-ID: <CADnq5_PDN8_Bo1pBTQeMmCGqA+2uxGsiqArHJkKQaHmz++0yTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use the right method to get IP version
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 6, 2023 at 7:57=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Replace direct usage of adev->ip_versions with amdgpu_ip_version.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
>  5 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 1b73f519cfb8..f9e8341d9449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1599,7 +1599,7 @@ bool amdgpu_device_seamless_boot_supported(struct a=
mdgpu_device *adev)
>         if (adev->mman.keep_stolen_vga_memory)
>                 return false;
>
> -       return adev->ip_versions[DCE_HWIP][0] >=3D IP_VERSION(3, 0, 0);
> +       return amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(3, 0,=
 0);
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 3a632c3b1a2c..0dcff2889e25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1099,7 +1099,8 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_devic=
e *adev)
>  {
>         bool xnack_mode =3D true;
>
> -       if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] =3D=3D=
 IP_VERSION(9, 4, 2))
> +       if (amdgpu_sriov_vf(adev) &&
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
))
>                 xnack_mode =3D false;
>
>         return xnack_mode;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 2ac5820e9c92..473a774294ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -883,7 +883,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>          * GRBM interface.
>          */
>         if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
> -           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
> +           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
>                 RREG32_NO_KIQ(req);
>
>         for (j =3D 0; j < adev->usec_timeout; j++) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c146dc9cba92..394142cf72bc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9860,7 +9860,8 @@ static bool should_reset_plane(struct drm_atomic_st=
ate *state,
>          * TODO: Remove this hack for all asics once it proves that the
>          * fast updates works fine on DCN3.2+.
>          */
> -       if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state=
->allow_modeset)
> +       if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 2, 0) &&
> +           state->allow_modeset)
>                 return true;
>
>         /* Exit early if we know that we're adding or removing the plane.=
 */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index d8f8ad0e7137..4894f7ee737b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -224,7 +224,7 @@ int smu_v14_0_check_fw_version(struct smu_context *sm=
u)
>         if (smu->is_apu)
>                 adev->pm.fw_version =3D smu_version;
>
> -       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>         case IP_VERSION(14, 0, 2):
>                 smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SM=
U_V14_0_2;
>                 break;
> @@ -235,7 +235,7 @@ int smu_v14_0_check_fw_version(struct smu_context *sm=
u)
>                 break;
>         default:
>                 dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
> -                       adev->ip_versions[MP1_HWIP][0]);
> +                       amdgpu_ip_version(adev, MP1_HWIP, 0));
>                 smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_IN=
V;
>                 break;
>         }
> @@ -733,7 +733,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu=
, bool enable)
>         int ret =3D 0;
>         struct amdgpu_device *adev =3D smu->adev;
>
> -       switch (adev->ip_versions[MP1_HWIP][0]) {
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>         case IP_VERSION(14, 0, 2):
>         case IP_VERSION(14, 0, 0):
>                 if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
> --
> 2.25.1
>
