Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599A1C7EE30
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011C110E0CD;
	Fri, 27 Jun 2025 03:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SU8MrqQa";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F10A10E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:19:19 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b34b770868dso216103a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 20:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750994359; x=1751599159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5x4tLFeY1t1LZrD8ap8HbewBlQWRewxwXMFgKmZ4sHw=;
 b=SU8MrqQa/IvlnRJdVRawnMxdghA/3lrUE1DyIFgmQQ1lJSb7Vbg4igHkXeOViFs8N5
 KKb7CrCl2uOLXYTFlffbtNDKvWWG/JY+5VqDtDBmjksAAvLYE0Bmo8LGF9SX6bKtEWlr
 JnfIOUWWz4jitB2ieYdSk9MXjK80Y7M9eAqSlVPlD1hnzELfmNJOzXA+TxrVyNxkKnNb
 EM8GXG/dDQzYLfuOeE06CSKmMxYUtg1umABUQESIYAp1NyCml5nGDGrS/FncPsjJo6y5
 En3RgnTbUx6t/eG6Dr9j5oXQoZon5ckZJVjIQ5X3xT8RflmUOGMXebgkJVipr1NZ3i8o
 L5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750994359; x=1751599159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x4tLFeY1t1LZrD8ap8HbewBlQWRewxwXMFgKmZ4sHw=;
 b=KStdhcVQKBIldjHiiSzrYSkQkEuzHY/ucmzwrua56OqT3kySoc8H2mPyZxrDBdZOV0
 Yt67T6SqEDbPKcXWiizNA0OUz9TB62yKTWO35z2a4K946r/tnNMxHGj2e8fVM4aR4gOB
 HYz+SfD3fmajwRvTi5FlVmrwZGgvCe1+Bgm2RKajJu/9HoHwTiPO6HTy86KVXSGuiBhe
 RTdvrDk6JnTTzFCG6d8CEM1z8gr9OXl6SvuVEQcaG+u812R5q9Uw7x8gUPCzByRXuUL1
 iVKbXFB1D6Xt4MqXPamXySGQ9PnzDcpmNNbtuVZ/d40iQLejfXSM+p9O0XoJylDnuMX1
 +Usw==
X-Gm-Message-State: AOJu0YznTRHU1LcZNb9GXPqb0MpYNzH7SH6kafdTz35f4E7uaAdQZ6xl
 /CqHHj2WIk/vhHGc7IiKlEgIaEp/NfaoVEN6/JRDOCg+3jSnv+qrharHg4tfnsRML920PO6AiOW
 7vYDB2VKZKSTM3XGLuIzXFKHs48r5G37so64g
X-Gm-Gg: ASbGnctpsGA2rZbjwQ/mpIr8NIel490yYh5ycTnUK0csC/1FnFlwYlwKmjMxI0dJH67
 3gaA+jk/FfG1vONpW7qCOD09uBE5b1ueNOX8taHPfIiQXyEm4+hh8RkSrUM/cdJKTlqBacJe2+c
 OtevXuOL4WUmyVojON7vl6ze3CM+Pzcy+yvSl/IQHZoyhQ
X-Google-Smtp-Source: AGHT+IFWBJp47MhkHxGVbRFOfGfrHsSohJ7o4VrvovtlL1qVhPtKsGUg5gE0JB3v8JUe5R3zP7auNO4rVVrUtHVDHS8=
X-Received: by 2002:a17:903:11c6:b0:234:c8f6:1b09 with SMTP id
 d9443c01a7336-23ac45eeb3cmr10522215ad.9.1750994358527; Thu, 26 Jun 2025
 20:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250626015709.251938-1-jesse.zhang@amd.com>
In-Reply-To: <20250626015709.251938-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Jun 2025 23:19:07 -0400
X-Gm-Features: Ac12FXxoDAa3zY6EsbK7NxE23VzsfBfU2VSVSlanjv47StLQtMQO-3Og7fVK80c
Message-ID: <CADnq5_MbziLrZ0WWwK4p=YqwKsnWVgUNivCpP2zGjYLT328tBA@mail.gmail.com>
Subject: Re: [PATCH V3] drm/amdgpu: Add user queue instance count in HW IP info
To: Jesse Zhang <jesse.zhang@amd.com>
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

On Wed, Jun 25, 2025 at 10:13=E2=80=AFPM Jesse Zhang <jesse.zhang@amd.com> =
wrote:
>
> This change exposes the number of available user queue instances
> for each hardware IP type (GFX, COMPUTE, SDMA) through the
> drm_amdgpu_info_hw_ip interface.
>
> Key changes:
> 1. Added userq_num_instance field to drm_amdgpu_info_hw_ip structure
> 2. Implemented counting of available HQD slots using:
>    - mes.gfx_hqd_mask for GFX queues
>    - mes.compute_hqd_mask for COMPUTE queues
>    - mes.sdma_hqd_mask for SDMA queues
> 3. Only counts available instances when user queues are enabled
>    (!disable_uq)
>
> V2: using the adev->mes.gfx_hqd_mask[]/compute_hqd_mask[]/sdma_hqd_mask[]=
 masks
>   to determine the number of queue slots available for each engine type (=
Alex)
>
> V3: rename userq_num_instance to userq_num_hqds (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  2 ++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 195ed81d39ff..31ba4efabb9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -399,6 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>         uint32_t ib_size_alignment =3D 0;
>         enum amd_ip_block_type type;
>         unsigned int num_rings =3D 0;
> +       uint32_t num_hqds =3D 0;
>         unsigned int i, j;
>
>         if (info->query_hw_ip.ip_instance >=3D AMDGPU_HW_IP_INSTANCE_MAX_=
COUNT)
> @@ -411,6 +412,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *a=
dev,
>                         if (adev->gfx.gfx_ring[i].sched.ready &&
>                             !adev->gfx.gfx_ring[i].no_user_submission)
>                                 ++num_rings;
> +
> +               if (!adev->gfx.disable_uq)
> +                       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +                               num_hqds +=3D hweight32(adev->mes.gfx_hqd=
_mask[i]);
> +

I think kernel coding style recommends putting parens around this.  E.g.,

if (!adev->gfx.disable_uq) {
    for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
        num_hqds +=3D hweight32(adev->mes.gfx_hqd_mask[i]);
}
Same for the others below.  WIth these fixed:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
>                 break;
> @@ -420,6 +426,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *a=
dev,
>                         if (adev->gfx.compute_ring[i].sched.ready &&
>                             !adev->gfx.compute_ring[i].no_user_submission=
)
>                                 ++num_rings;
> +
> +               if (!adev->sdma.disable_uq)
> +                       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i=
++)
> +                               num_hqds +=3D hweight32(adev->mes.compute=
_hqd_mask[i]);
> +
>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
>                 break;
> @@ -429,6 +440,11 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *a=
dev,
>                         if (adev->sdma.instance[i].ring.sched.ready &&
>                             !adev->sdma.instance[i].ring.no_user_submissi=
on)
>                                 ++num_rings;
> +
> +               if (!adev->gfx.disable_uq)
> +                       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +                               num_hqds +=3D hweight32(adev->mes.sdma_hq=
d_mask[i]);
> +
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
>                 break;
> @@ -570,6 +586,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>         }
>         result->capabilities_flags =3D 0;
>         result->available_rings =3D (1 << num_rings) - 1;
> +       result->userq_num_hqds =3D num_hqds;
>         result->ib_start_alignment =3D ib_start_alignment;
>         result->ib_size_alignment =3D ib_size_alignment;
>         return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 45c4fa13499c..66c4a03ac9f9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>         __u32  available_rings;
>         /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>         __u32  ip_discovery_version;
> +       /* Userq available hqds */
> +       __u32  userq_num_hqds;
>  };
>
>  /* GFX metadata BO sizes and alignment info (in bytes) */
> --
> 2.34.1
>
