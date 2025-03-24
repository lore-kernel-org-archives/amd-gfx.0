Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2F2C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAA710E25C;
	Mon, 24 Mar 2025 19:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VSvCLMbx";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1905110E4D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:58:00 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2241c95619eso11433435ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742846279; x=1743451079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RJJaTNPfF1rXhi+5fSFurhOvndOYqWKu5afAKRxbXY=;
 b=VSvCLMbxRWhZMg3cfizi6dMy/8BtPus6Kx5hxblrf+pr7/qNDjnfnY82vcYkoK8yq1
 ESAH9br9/o8/R20T/vXBM5BMSu4nL4s1gTw4BKzJyZF1k+/RBWI5OaLjqb8hFuAuKpAg
 j01EgsqBhlUazWmfs6CqM5C8IEw5G8qeeZHqYk7pc7psWjPgsIqijCkXGsTHwEkGURlz
 ziEHC1XutQ/srx7zhib8zXiKSSFRY2tlR5QOLTJzaxYF8TmwQQI68rCMzjGkULJPJfmN
 nHAPS880KlQ7EVRi43jCCPehcStXH5ona088XfRnacxI+GEtaNuf/M3AS/x/Mvu58Qna
 u6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846279; x=1743451079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RJJaTNPfF1rXhi+5fSFurhOvndOYqWKu5afAKRxbXY=;
 b=Qtgp7trkzZCtIB+P6Ex7CilqzDBB9R3+kw/DJRausWJ7NG/K931HXaetdVA6TohUwR
 1qdLfaDiRCQv2UcJwKv2almJToLkBIe2dtRW/9JeGGI8lAblJD2Gafwaw4Xk+mmF0j8Z
 Uv8tdwoMrRAsb7vMRa8f4zxvtjxQD2Ph63WrGcIVMFBfUu58+ftS4QjUGi+VLC9q1P9E
 l6SMPS9UIS+yElPAeqNtOYHcsF89LfzjZb9El6ZWMUcju1brxZ4i8UvVcQm0Bf7tfq8s
 AJzItqOUIjTtcz+TsrY2/acvxzfun+yB4Yji9R0tid9I4msAOIW4QrtFtGRfFcHqE68H
 lrLA==
X-Gm-Message-State: AOJu0YykwhMRu3xYGBIRDIhoCT2nN/Pt3zxGPlj23JRpKHMjJQnVYL0r
 +zqQl9h55SR6Sf2krhYFE0h1EblFMbeI6xan72ydKz0sRnZjpSZK1yli/ZMxeJYaMNduo3Z0KFJ
 sDJjDpS8jPwur177s5xpsrJQVORGC4g==
X-Gm-Gg: ASbGncvFyTUOCXZD3s0VSFH9KlrkJYLgTfRb7bbRZntmXE4c+e/CORvleJjoINkGguC
 CK9LNKqfyXvF/lVZUeKO3IjTG2CbXY4/Q9Ba2Hv3iew7CE145hehlut84Kmc8KXk1E8lH38eCQ7
 smlufLLNYdPSqnB+X+9MjL36pWHQ==
X-Google-Smtp-Source: AGHT+IEnQC4hqeHHux+yFrw1dX2ydJ6iOEM89yIIBB6k0dDsktsvLsgSVaog8KO7p+t7+ndRmu7lu4JJGI5M3Utdn7U=
X-Received: by 2002:a17:903:234e:b0:221:751f:dab9 with SMTP id
 d9443c01a7336-22780e176c0mr83382255ad.14.1742846279406; Mon, 24 Mar 2025
 12:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250228202851.2550575-1-alexander.deucher@amd.com>
In-Reply-To: <20250228202851.2550575-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:57:47 -0400
X-Gm-Features: AQ5f1JprkGSaOp6eyyf_kp98B1TWZ1LT_yTGjsTUMzKjmMm0jJMz19YDcXyDgVk
Message-ID: <CADnq5_NGXuKR1_gutwf+NjKhsoDfU2R2J0_hKmpuOq9C6KGjRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add rebar parameter
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Fri, Feb 28, 2025 at 3:39=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Add a new parameter to disable BAR resizing.  Note that this
> only disables the driver from attempting to resize the BAR,
> The BIOS may have resized the BAR at boot.
>
> Some teams have found this useful in debugging P2P DMA
> issues on systems where the available MMIO space did not allow
> for all of the GPUs present to resize their BARs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 87062c1adcdf7..948f832f469ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -268,6 +268,7 @@ extern int amdgpu_umsch_mm_fwlog;
>
>  extern int amdgpu_user_partt_mode;
>  extern int amdgpu_agp;
> +extern int amdgpu_rebar;
>
>  extern int amdgpu_wbrf;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0a1a1f3ee5fc0..cc1a991ad4719 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1662,6 +1662,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_devic=
e *adev)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> +       if (!amdgpu_rebar)
> +               return 0;
> +
>         /* resizing on Dell G5 SE platforms causes problems with runtime =
pm */
>         if ((amdgpu_runtime_pm !=3D 0) &&
>             adev->pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b161daa900198..333c78ac000e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -237,6 +237,7 @@ int amdgpu_agp =3D -1; /* auto */
>  int amdgpu_wbrf =3D -1;
>  int amdgpu_damage_clips =3D -1; /* auto */
>  int amdgpu_umsch_mm_fwlog;
> +int amdgpu_rebar =3D -1; /* auto */
>
>  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, =
0,
>                         "DRM_UT_CORE",
> @@ -1083,6 +1084,16 @@ MODULE_PARM_DESC(wbrf,
>         "Enable Wifi RFI interference mitigation (0 =3D disabled, 1 =3D e=
nabled, -1 =3D auto(default)");
>  module_param_named(wbrf, amdgpu_wbrf, int, 0444);
>
> +/**
> + * DOC: rebar (int)
> + * Allow BAR resizing.  Disable this to prevent the driver from attempti=
ng
> + * to resize the BAR if the GPU supports it and there is available MMIO =
space.
> + * Note that this just prevents the driver from resizing the BAR.  The B=
IOS
> + * may have already resized the BAR at boot time.
> + */
> +MODULE_PARM_DESC(rebar, "Resizable BAR (-1 =3D auto (default), 0 =3D dis=
able, 1 =3D enable)");
> +module_param_named(rebar, amdgpu_rebar, int, 0444);
> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> --
> 2.48.1
>
