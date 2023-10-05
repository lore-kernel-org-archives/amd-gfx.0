Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FA9E92705
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 14:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DAF10E40A;
	Thu,  5 Oct 2023 14:31:15 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095F010E40A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 14:31:13 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c4fc2ce697so707242a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Oct 2023 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696516273; x=1697121073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5bClF36fx11x/Hsn7PnhYN1sucWEKXZElZiqOSE37w=;
 b=VFMqa9NV2OpsLq296ETRISbhabMaT5mMk9dK8N0PBFtinLpLCP1hFAmXU0tHBgd8sh
 xu9x2WIA8mEklXp0Meh0pFZirteUivfdoydH7naJKsg9hc2DCdCgcKlETcOrsAFUYxQE
 l8EvmaIJ1QC+xG/cIaA3Rlei/8gAH7fB/lNkLa5sBgTuzI4LmSgWJRC7dHHe6buWw9oR
 fSDHhOgvMYFZEHrJlF/+UDJfzcmJcSddGEP8K8j2sejWqq6q+4vmmRawEgMo1+DDTJJG
 /SQk9NFKSi2GCHTZmxslqd/TFcVcYtbHzxyhvdixN4l7W5g2CKiOnZgv7WB3HsOtt0LF
 FaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696516273; x=1697121073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5bClF36fx11x/Hsn7PnhYN1sucWEKXZElZiqOSE37w=;
 b=KR89joGc3naOR3yq9NpVMdk5HrwCaRdbUSI4jId06FdziUtSHdFjkjgobGtRWkZa7a
 ZbNJyBKLFFGA+cVAfn9EM1PqpkKWfTCMLuSBJnej6zjTJS6w3fjRgqUwPEwrmlaM4PzP
 tz1/HDs9Y7c02XoAz/IuyjXEwzo3kfzn8Uqr2NE/kPGiAFAP2f8UCThcV0r7JLmVeAqv
 wdBB0nDjH2Q1GZa2ok4NO6AOsN1btorIDqkuWfVm38fugA8+QULvJ44VcoeOQ/rnrw88
 oGcx2Jxz+1grJH0IRo4UcS5ty2cmS/L3f2cdQOGNEHIII7tXEp6bou5Zbj6ZjaL5ZI3k
 GL7w==
X-Gm-Message-State: AOJu0YzWGTcJSAP9nAdFdoxUrCcXRLGw7om4kRCkBnXBALE4rSTBpnPV
 0d/iAE1674m3YUd3i6VE4k8OPsSss28MUk7AmaNLbUZ0
X-Google-Smtp-Source: AGHT+IGIYeNs42fqUkGnd8uGemCuNJ6Dc5jbgNO+JZPwH53lUjVl79eDhQEsvV0NsCUcLvpY/XZh7PC4URcy+pI87Xg=
X-Received: by 2002:a05:6870:f720:b0:1d6:2476:be2e with SMTP id
 ej32-20020a056870f72000b001d62476be2emr5366717oab.35.1696516273019; Thu, 05
 Oct 2023 07:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231005134906.58141-1-boyuan.zhang@amd.com>
In-Reply-To: <20231005134906.58141-1-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Oct 2023 10:31:02 -0400
Message-ID: <CADnq5_Myn=yi+YDPO82J=r6ddN_AjTRx9uinuw-6pNFSLuuWbg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update ib start and size alignment
To: boyuan.zhang@amd.com
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 5, 2023 at 10:17=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Update IB starting address alignment and size alignment with correct valu=
es
> for decode and encode IPs.
>
> Decode IB starting address alignment: 256 bytes
> Decode IB size alignment: 64 bytes
> Encode IB starting address alignment: 256 bytes
> Encode IB size alignment: 4 bytes
>
> Also bump amdgpu driver version for this update.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 22 +++++++++++-----------
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index e3471293846f..9e345d503a47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -113,9 +113,10 @@
>   *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pi=
pes_mask_hi
>   *   3.53.0 - Support for GFX11 CP GFX shadowing
>   *   3.54.0 - Add AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS support
> + *   3.55.0 - Update IB start address and size alignment for decode and =
encode
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       54
> +#define KMS_DRIVER_MINOR       55
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 081bd28e2443..96db51765a6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -447,7 +447,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                         if (adev->uvd.inst[i].ring.sched.ready)
>                                 ++num_rings;
>                 }
> -               ib_start_alignment =3D 64;
> +               ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 64;
>                 break;
>         case AMDGPU_HW_IP_VCE:
> @@ -455,8 +455,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 for (i =3D 0; i < adev->vce.num_rings; i++)
>                         if (adev->vce.ring[i].sched.ready)
>                                 ++num_rings;
> -               ib_start_alignment =3D 4;
> -               ib_size_alignment =3D 1;
> +               ib_start_alignment =3D 256;
> +               ib_size_alignment =3D 4;
>                 break;
>         case AMDGPU_HW_IP_UVD_ENC:
>                 type =3D AMD_IP_BLOCK_TYPE_UVD;
> @@ -468,8 +468,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                                 if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady)
>                                         ++num_rings;
>                 }
> -               ib_start_alignment =3D 64;
> -               ib_size_alignment =3D 64;
> +               ib_start_alignment =3D 256;
> +               ib_size_alignment =3D 4;
>                 break;
>         case AMDGPU_HW_IP_VCN_DEC:
>                 type =3D AMD_IP_BLOCK_TYPE_VCN;
> @@ -480,8 +480,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                         if (adev->vcn.inst[i].ring_dec.sched.ready)
>                                 ++num_rings;
>                 }
> -               ib_start_alignment =3D 16;
> -               ib_size_alignment =3D 16;
> +               ib_start_alignment =3D 256;
> +               ib_size_alignment =3D 64;
>                 break;
>         case AMDGPU_HW_IP_VCN_ENC:
>                 type =3D AMD_IP_BLOCK_TYPE_VCN;
> @@ -493,8 +493,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                                 if (adev->vcn.inst[i].ring_enc[j].sched.r=
eady)
>                                         ++num_rings;
>                 }
> -               ib_start_alignment =3D 64;
> -               ib_size_alignment =3D 1;
> +               ib_start_alignment =3D 256;
> +               ib_size_alignment =3D 4;
>                 break;
>         case AMDGPU_HW_IP_VCN_JPEG:
>                 type =3D (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOC=
K_TYPE_JPEG)) ?
> @@ -508,8 +508,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                                 if (adev->jpeg.inst[i].ring_dec[j].sched.=
ready)
>                                         ++num_rings;
>                 }
> -               ib_start_alignment =3D 16;
> -               ib_size_alignment =3D 16;
> +               ib_start_alignment =3D 256;
> +               ib_size_alignment =3D 64;
>                 break;
>         case AMDGPU_HW_IP_VPE:
>                 type =3D AMD_IP_BLOCK_TYPE_VPE;
> --
> 2.34.1
>
