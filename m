Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD50C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 00:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F9F10E1E2;
	Wed, 19 Jun 2024 00:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6KUhYNP";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F8910E1E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 00:34:44 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-57cce3bc8c6so4569850a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718757282; x=1719362082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kF3IlIrRtzmnDWLxmfhaUxd1WNjIZ9FqYdREOSYU7ns=;
 b=l6KUhYNPDxfqWvsR1Bev4LjyUQzMyn9WuFZHtKp8hkgEUewrKp2zUzQX9Eyo48owHw
 25fYYpTToY+iGCUsnUdE3Q/ChCuPwR1Q44DhXZcLjgQ1A24byddEreSikOApEjN1gj3e
 qwP1DVX/lRIQpazOsco3nQAjppqUlzLAGJdaX5kRDwpfpxXVh1o8BebHcGxTF3DjxICs
 /rt2TB2/a8U4Y2P7B4cCNGn/ByKSb4jhnOAuXWsZJoyPW5d6BM5Q3aQn64liS575FUKH
 bszL+q2Wk3qxBcp+hkUQuyLr2s0AX/fyeR3hUw6+PLfFFXR++Y9n2qZ/CZfAzLvEFIAv
 XQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718757282; x=1719362082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kF3IlIrRtzmnDWLxmfhaUxd1WNjIZ9FqYdREOSYU7ns=;
 b=qgDFh8398fvtMllgeAZrm2smFOadYEhLZbIKFezbjohpwC9n/eqN+HN8kvsXl+qpfz
 cmAj1lTYY7e+qzc+NLGzyj7V/HOG2U/kyvzzObOurWnA/GgZ1UF1JZ2riRa8aYacmX9r
 DtwesYDq5oYmcl/6Nhql2bnVuCEc7kmfF+ROzqn8cNHiSTV8/SEBHtJ7Dw4Mgrgq4uLC
 1Ry5epeVdKt3XlkMW48lq44r/ssFPXyfYN6DCuy1gW4a1Zc9fAhMsjsLhfMD7pAPbkvk
 g5jVusFUOhRxA8CljvRAddAuRbdSH1iKqHp5zC+rANcxmQhFGkqRRvDck4k5e1RDDyNo
 8eOQ==
X-Gm-Message-State: AOJu0Yw5SeYK/iaEv8TbCPB3X9gHu9PbOqeR1iP6vtdWC+wchFgQX9gW
 nREw/bVOhvWtGNZ2J04QFG2fCobWyb3JKOhgR46dWEb94iTzP+llyAPKuqIAldVClAcnGYVsmeZ
 xNkcSM1CcuP/KpbnHNCs8PwerNk0=
X-Google-Smtp-Source: AGHT+IF8HlJ3VU8AAz6Y4cCEfUWtwUrRJXoIUGNud2d07B72wlyKEafREpqsblY+LzRWM64QV47wXuI3w519teODV74=
X-Received: by 2002:a50:951b:0:b0:572:9962:7f0 with SMTP id
 4fb4d7f45d1cf-57d07ed94acmr350040a12.34.1718757281906; Tue, 18 Jun 2024
 17:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
 <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20240618153003.146168-5-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 18 Jun 2024 20:34:05 -0400
Message-ID: <CAAxE2A6sQrU94uisM00kZs=P2pguTcQJjEtUX_Gum_vPjZ2J+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

I would put this into drm_amdgpu_info_device. That structure can grow in si=
ze.

Marek

On Tue, Jun 18, 2024 at 11:30=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> libdrm_amdgpu uses AMDGPU_INFO_READ_MMR_REG to fill the dev->info.gb_addr=
_cfg
> value.
> Since this value is already known by the kernel, this commit implements a=
 new
> query to return it.
>
> The libdrm MR to use this query is:
>    https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/368
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index f51f121d804e..403add7f05af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -117,9 +117,10 @@
>   * - 3.56.0 - Update IB start address and size alignment for decode and =
encode
>   * - 3.57.0 - Compute tunneling on GFX10+
>   * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & A=
MDGPU_IDS_FLAGS_MODE_PT
> + * - 3.59.0 - Add AMDGPU_INFO_GB_ADDR_CONFIG support
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       58
> +#define KMS_DRIVER_MINOR       59
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index b32ff6e1baaf..dbb05d51682b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1256,6 +1256,10 @@ static int amdgpu_info(struct drm_device *dev, voi=
d *data, struct drm_file *filp
>                 return copy_to_user(out, &gpuvm_fault,
>                                     min((size_t)size, sizeof(gpuvm_fault)=
)) ? -EFAULT : 0;
>         }
> +       case AMDGPU_INFO_GB_ADDR_CONFIG: {
> +               ui32 =3D adev->gfx.config.gb_addr_config;
> +               return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT =
: 0;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> @@ -1310,6 +1314,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>         case AMDGPU_INFO_VIDEO_CAPS:
>         case AMDGPU_INFO_MAX_IBS:
>         case AMDGPU_INFO_GPUVM_FAULT:
> +       case AMDGPU_INFO_GB_ADDR_CONFIG:
>                 need_runtime_pm =3D false;
>                 break;
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 3e488b0119eb..680492cd73d8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -933,6 +933,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_MAX_IBS                    0x22
>  /* query last page fault info */
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
> +/* Query GB_ADDR_CONFIG */
> +#define AMDGPU_INFO_GB_ADDR_CONFIG             0x24
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> --
> 2.40.1
>
