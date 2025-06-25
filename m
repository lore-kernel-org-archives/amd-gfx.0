Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09544C7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 14:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F19A10E73B;
	Wed, 25 Jun 2025 14:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLEc0opF";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DB610E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 14:16:12 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b31c9d96bcbso939808a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750860972; x=1751465772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJMSg6J4AdQuhY9+KBs8u2+3wacTS0EZTtORYwDOKqo=;
 b=iLEc0opFeo12sRjI57Y/F39nqNkJx1S/nW7d5aFmq7yYQT7IAl0fV1J/IVMCdKwyel
 7A5yrXj1xSLsAaSoy0QI9mTAAsEBFqs0FJfO86+MZ6ZZb5Mr/j2tBnEhCf8Qdf+KQ3Gu
 NI+fGPwiUPpbvDZCZMDXPxPtG0wtJ2qLgvsWdGheDbZ7MamMFzK3QDd+lTfFeO5GGdYS
 /r9ft5LRqfQ4wLIqmDfNM2XweWvtvefXBTM7sXj2ABe0JrECS0ydJAbNB9qGQM2tOs3i
 /VFd3JouzTtGHjj4tZXTO/5Lmq1heQ+0y1hwH03F/2yJSSoRPDwq8WKvEFYHTBw5DNdj
 Qcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750860972; x=1751465772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJMSg6J4AdQuhY9+KBs8u2+3wacTS0EZTtORYwDOKqo=;
 b=mBN7WJPybK6+pZDul/TF+t2DTnYUz89H1TMJkyZJslc8Pc8+ZYKZzko85appxj0YwS
 d1gmFZ3/TwxEedlHw8SMngJnmxKb9LBqdFLvh8U0WidZukVVVUIDeFU1Y6dkXTfcWCdE
 LwQzh7YJiqeDzkVCi6dM1nIJZYl289Q+As23cliXN/zg9FYJna3cCAE93fEtB+ifFmQY
 7Fb4f+WQCFqZ9Vvmfczv5+fXFSFMhiemdVjxERGppRLRKc84gQ+pVYU6zDSJtRlQXeSm
 KVRwEe3NmClE4ev66saAtN0UD4JIyzNl6eAwd3GEHseDZ1XrGNt1Eo9S8Jd8P0Een52y
 UvSQ==
X-Gm-Message-State: AOJu0YxSoSXDLNnJ+xGQAOsYXHWx9QlQcExlEjxI64Z8mjETDZFFw5Ht
 QTUrqCFdafDyDzpjQww0XxgdUmq9VRuknKMlXUUs1E6Oj1dvF02xatNCHDBwKlVMl7k+JORI7H4
 whLnIyW4p8TyAwAc6AQZUPyVWC6AX++NZBQ==
X-Gm-Gg: ASbGncvmAfeoBOnLeCUceTBWiFYuKgQZqwy9A2U6j+vpuFsdILKziPyThAg1goPgcBY
 EsJEPfJNqTcWRLMwn+zsnXwjok5rV4Uv/hYHUEcIw19WeKaIDdP/KlaUdVBStO0wn4extMuKpk+
 kRBywpVO3SPPWqZNHa8/nP172R683KNBmo2z3gPImh74Vc
X-Google-Smtp-Source: AGHT+IErsha/Yfa2eq1eDPvKQXu9oO5mklS3sDRhxhLcTmCBIINYWh4lra+5YwmpIVKRmJ6OH/0Aw4JALq680rrdqkQ=
X-Received: by 2002:a17:90b:1645:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-315f2680018mr1668681a91.3.1750860971842; Wed, 25 Jun 2025
 07:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250625075314.4016532-1-jesse.zhang@amd.com>
In-Reply-To: <20250625075314.4016532-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Jun 2025 10:16:00 -0400
X-Gm-Features: AX0GCFtTo0DF1p6J9PKB1oI-TOjkqQCIMF86mVArdAh0h8TngUShBKvb-oUdxP0
Message-ID: <CADnq5_PwOmaHnGzm7NaKQMpy6dWFsiFi4JTn3Ppn_UFjH2xQ0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add user queue instance count in HW IP info
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

On Wed, Jun 25, 2025 at 4:03=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
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
> v2: using the adev->mes.gfx_hqd_mask[]/compute_hqd_mask[]/sdma_hqd_mask[]=
 masks
>   to determine the number of queue slots available for each engine type (=
Alex)
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
> index 195ed81d39ff..d682a92f086b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -399,6 +399,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>         uint32_t ib_size_alignment =3D 0;
>         enum amd_ip_block_type type;
>         unsigned int num_rings =3D 0;
> +       uint32_t num_instance =3D 0;
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
> +                               num_instance +=3D hweight32(adev->mes.gfx=
_hqd_mask[i]);
> +
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
> +                               num_instance +=3D hweight32(adev->mes.com=
pute_hqd_mask[i]);
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
> +                               num_instance +=3D hweight32(adev->mes.sdm=
a_hqd_mask[i]);
> +
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
>                 break;
> @@ -570,6 +586,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>         }
>         result->capabilities_flags =3D 0;
>         result->available_rings =3D (1 << num_rings) - 1;
> +       result->userq_num_instance =3D num_instance;
>         result->ib_start_alignment =3D ib_start_alignment;
>         result->ib_size_alignment =3D ib_size_alignment;
>         return 0;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 45c4fa13499c..8082270a7ceb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>         __u32  available_rings;
>         /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>         __u32  ip_discovery_version;
> +       /* Userq available instance */
> +       __u32  userq_num_instance;

I would call this something like userq_num_slots or userq_num_hqds.
Other than that, it looks good to me.

Alex

>  };
>
>  /* GFX metadata BO sizes and alignment info (in bytes) */
> --
> 2.34.1
>
