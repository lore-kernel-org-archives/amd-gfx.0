Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1D5C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E5310E2BA;
	Wed, 28 May 2025 13:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gOdehRT2";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE6F10E1DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:10:58 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3108652400cso588063a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748437858; x=1749042658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tn3cqn6Ejdp3PPy1HyfP5x0ZWLjrtcRqoG0l2En86wU=;
 b=gOdehRT2JsptmoifEjoVGFrqkwr6kGX0rB5nP7+hXinNxMvuOfAkOzy/X/12MAys26
 8aKRyh8KrfyJZzWPnjXgL0XN/DVWqOHMBi0O0VSTpX+t+D3wiwjFUYnsEhl48XUq/K7v
 JzezBUVjgzGO5v45vI+mBXBfCxbEXV6nCCLvTR9FgX00/pWzeFC79grwN+4vjjE4PNrz
 R4hpSBmQCU6/YH0bvvNawUiFMYs84+1l9YpHjT+7Hdpx+GZhWsStXIzi15O3JRXhrtZS
 1RsF0HhDvrvSh/qqi0XUyU6YtHEV/3enAG+/5R9WTC0pqfrXWUyaxl+lxsIIFwpY/RbC
 v5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748437858; x=1749042658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tn3cqn6Ejdp3PPy1HyfP5x0ZWLjrtcRqoG0l2En86wU=;
 b=AG33ULXMTenG1hgN/Mn9h8ipSzLH/EmFnTbg8/hxjkfiD44965op7RpQmX76/RplIF
 kI0hWcIrCVCGLCFvhwez3Emaly9zQlo9GNAyUSkJcJkruRD2jyvemLbUcYYvfHHF/R0g
 4YetKmx9CwLTbkjsWsMOM8zafnP3BrEjy/aEAzvb3yM0EXygyr/SqEajOXOVXvFZ7PED
 wVHWMvQT1GbgI/vt5kGDWx+IpReQQMJH6h8raMPGlKH00tUR0xsFS/AfVcxBrhL8hFqt
 C546kS3nFRuzDw2ODKFvqsDnZcn4Z9+cw725bfHFIpZVdrZndhaQJbTRie6eXLELHdIC
 Lu/w==
X-Gm-Message-State: AOJu0YxP6QH5OyuPuXml+Rt15WCrXys6O7p8OhSwXmF+5mqD/e3poXQE
 HTTrMFJERSkffc3EEGiYUiRCFsvX/XzX9ujNGIRNr29KlGEAAQjdLHcxCsiHZT5mZF3bDIevZP+
 fDNoQCjunlB3G9Hd81rCeLrw1FuBBb6UmVg==
X-Gm-Gg: ASbGncs5m/0HXJ4R+gAn0oA29ySJW7Np1yhPaHypnIRI9CrswBy1/gTBdEHmJvYVTZa
 dfZ2S9mOd91ZuqlWPc326PxDEBmkkW2KXy/YdOYX4XrIt7RtTMO93lvipd6B2YzRJmqldqDMwdo
 SK4Mo4boIp8CbKJeJJ8L/7v2Fjrf0PsETgXg==
X-Google-Smtp-Source: AGHT+IGQfALZ3bTUGOGdgk9doGPdJwPyfRjVS8WLDa6igR9D9pIheoINR3xBDq/w4DZ6Xr/vPlvW1uwtmL4lpJI7RqI=
X-Received: by 2002:a17:90b:4d12:b0:311:b0ec:135e with SMTP id
 98e67ed59e1d1-311b0ec14a2mr3434629a91.2.1748437857819; Wed, 28 May 2025
 06:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250528083756.847677-1-Prike.Liang@amd.com>
In-Reply-To: <20250528083756.847677-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:10:45 -0400
X-Gm-Features: AX0GCFvU05nY_qm9CtCFRzu1iSADzRJDD-1NXUgqY-zJ0oFy3v_TtPAqHgbkIjA
Message-ID: <CADnq5_MRsoGeKDhNHuKZbAbjRM9WNAc20q_T60y8kN1biBL0Lg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: only export available rings to mesa for
 enabling kq|uq
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Wed, May 28, 2025 at 4:38=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The kernel driver only requires exporting available rings to the mesa
> when the userq is disabled; otherwise, the userq IP mask will be cleaned
> up in the mesa.

The logic should work correctly as is.  There are three possible states:
1. KQ only
2. Both KQ and UQ
3. UQ only

Alex

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index d2ce7d86dbc8..43d86c09d8bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -409,7 +409,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 type =3D AMD_IP_BLOCK_TYPE_GFX;
>                 for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>                         if (adev->gfx.gfx_ring[i].sched.ready &&
> -                           !adev->gfx.gfx_ring[i].no_user_submission)
> +                           adev->gfx.disable_uq)
>                                 ++num_rings;
>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
> @@ -418,7 +418,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 type =3D AMD_IP_BLOCK_TYPE_GFX;
>                 for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>                         if (adev->gfx.compute_ring[i].sched.ready &&
> -                           !adev->gfx.compute_ring[i].no_user_submission=
)
> +                           adev->gfx.disable_uq)
>                                 ++num_rings;
>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
> @@ -427,7 +427,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 type =3D AMD_IP_BLOCK_TYPE_SDMA;
>                 for (i =3D 0; i < adev->sdma.num_instances; i++)
>                         if (adev->sdma.instance[i].ring.sched.ready &&
> -                           !adev->sdma.instance[i].ring.no_user_submissi=
on)
> +                               adev->gfx.disable_uq)
>                                 ++num_rings;
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
> @@ -439,7 +439,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                                 continue;
>
>                         if (adev->uvd.inst[i].ring.sched.ready &&
> -                           !adev->uvd.inst[i].ring.no_user_submission)
> +                           adev->gfx.disable_uq)
>                                 ++num_rings;
>                 }
>                 ib_start_alignment =3D 256;
> @@ -449,7 +449,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                 type =3D AMD_IP_BLOCK_TYPE_VCE;
>                 for (i =3D 0; i < adev->vce.num_rings; i++)
>                         if (adev->vce.ring[i].sched.ready &&
> -                           !adev->vce.ring[i].no_user_submission)
> +                           adev->gfx.disable_uq)
>                                 ++num_rings;
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
> @@ -462,7 +462,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>
>                         for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
>                                 if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady &&
> -                                   !adev->uvd.inst[i].ring_enc[j].no_use=
r_submission)
> +                                   adev->gfx.disable_uq)
>                                         ++num_rings;
>                 }
>                 ib_start_alignment =3D 256;
> @@ -475,7 +475,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                                 continue;
>
>                         if (adev->vcn.inst[i].ring_dec.sched.ready &&
> -                           !adev->vcn.inst[i].ring_dec.no_user_submissio=
n)
> +                           adev->gfx.disable_uq)
>                                 ++num_rings;
>                 }
>                 ib_start_alignment =3D 256;
> @@ -489,7 +489,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>
>                         for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; j++)
>                                 if (adev->vcn.inst[i].ring_enc[j].sched.r=
eady &&
> -                                   !adev->vcn.inst[i].ring_enc[j].no_use=
r_submission)
> +                                   adev->gfx.disable_uq)
>                                         ++num_rings;
>                 }
>                 ib_start_alignment =3D 256;
> @@ -505,7 +505,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>
>                         for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++)
>                                 if (adev->jpeg.inst[i].ring_dec[j].sched.=
ready &&
> -                                   !adev->jpeg.inst[i].ring_dec[j].no_us=
er_submission)
> +                                   adev->gfx.disable_uq)
>                                         ++num_rings;
>                 }
>                 ib_start_alignment =3D 256;
> @@ -514,7 +514,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>         case AMDGPU_HW_IP_VPE:
>                 type =3D AMD_IP_BLOCK_TYPE_VPE;
>                 if (adev->vpe.ring.sched.ready &&
> -                   !adev->vpe.ring.no_user_submission)
> +                   adev->gfx.disable_uq)
>                         ++num_rings;
>                 ib_start_alignment =3D 256;
>                 ib_size_alignment =3D 4;
> --
> 2.34.1
>
