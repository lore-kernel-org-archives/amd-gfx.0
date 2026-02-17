Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98BE909CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0A010E510;
	Tue, 17 Feb 2026 16:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNB/3NJL";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E2510E511
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:21:57 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1270fde1739so152433c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771345317; cv=none;
 d=google.com; s=arc-20240605;
 b=FLt6o2+Ctcub66xpMXsvURhysEAOUTc5c1MrGNz0/1iOStgaVXll3SqXy2SCWW7vW5
 RRJkXv+veWqD4LyxdDAwL6h3zDqftZ3j2MT1rWEPkRCbIRZsVn4ifxm7XoQ0rek6dEEZ
 VNwj7SNulnoXShV6yFkn/QuXn3cIXCSGsSSe4xoIjknshpq8OGNknEOLC0++oE//iEO3
 pzRn+bt5HxHpgG4H4xjJJq2Q1lWfSBFcEEntXgGtUcgnweLeG+tFo2PSDZQvZ2P3QdmC
 tz9qBjBsZyZE4iL+UZhUxfmnvuumbuGd0KgzwZ1fgUFdKajsbtpIB0F8q1rg+mY+5cjc
 VHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
 fh=14wHR9hsLtn9pMYcaKcUx2hIgarh68MNNa1StWj/Z2Q=;
 b=cnB9XyA1MDgQtTOSntRt5soYLzXpHlYBOfCPEdwFQRal8cwXE7TQ5BZ7GNfZVAR+vS
 BCQPdqMx5zIoIW6NPDJqGn8gZnv5fPXjDA/EH3Ld08byFDpRoucJpE17w2lxPG1QB0ge
 WvzO+ds+vm2toyC5MqweETkZQ+R8YeJPGIeto8frb+f3iwiSpxr5GW0scjhFblmONLis
 XM9v/cUTXTCesojIsiAu/k079W/iRD+x41aLRWIEcm2jZNjXBxEyR8ZiE/YtZO2qEo5Z
 ievZ4ziQrnuQTRnafGS2q6ScKgZwmlkSu/UN/7I9YGQMR6K5c97yr9TjkFsKEt9BAKjT
 0ZSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771345317; x=1771950117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
 b=NNB/3NJLxNQO/igWXH4r9z0UcuqfrKfZvzVXSFQ29h+DXbuT+/8FPaYybhyC1OYWUR
 UQ9QEf6UscoCs8jv/VCgJuYrOK2wN9Voodwmk5dFCsHDdYNlsdw0IfTjZbQfZlR2Sctp
 73FIxXZG5KmNzzRjo3YTg42l954+GA8PtWVLRzIOr4qXk6wZQfofpKyrSZme7O1u0CYb
 HL0tC7ODp/ku7c29Gz9zoJ+BpPqtEa7nJQ8DVs/4zq3331JzNLrN+J9mR7quQWdhCf7R
 ubwjwhvPLO340A4I2p1fXMpIuqlqTecKD0tqBIsl5mKN6PMh5pvJMjKw7BlMGvpEJBGh
 wtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771345317; x=1771950117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
 b=RxbXqafQFYG0MrwkNmACByFEZWMKf1nxNKho7CqhZgSGvzJOTGa0doAcn2kkeVNNaS
 M5PHLpmwp49fVSEqrlRhgVqH91XRyBpZ8EMQkj2i0qJd+FUXraA70E+BZYgiIUiuQSb6
 N7V3nLKx6EB+LuDSdI783JUlDiGbhSFaQHvWr5uQClufC/KyP/+/ILQ/IF/58LZY8rk3
 c5XnfSgyPoE7WAsyoamCA8JFFzf2EYKMvqdJlpazuJPkDcKe9uEfcaExJXaf8TTCXstw
 01NLdq46ldJkOetPMQgpxGXOJnX9fO3ej12HxW73Sv5uvdKC6ytGS/60N2YG+ZCmP8b7
 aYVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfsQBb1EK0Aqzf3hbnwjsoFHdxYZ5gldliSEcbLkyK32Zp3bvF2E5MMcAl/7gyaw+Cb22kMjen@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxffyinwE59V8efXaF1yKUrrdOMJmWDFCodl5iuFPTyk+d581q9
 vzQluW9WjxkRiqQKZRXemur6g5u+rBbPqZGYeCPjeNaaT76omal0zp3ppfvZjiFeFmusP5QvL5F
 HiY32J+fT5nkUAS+SXsRmtj828ZlOgEE=
X-Gm-Gg: AZuq6aIssycdV04wtGURoXik0c9WPFO8QUH7mmNY9P6lmwbxZM/7RePEr0Zg6g+4Y2d
 ZH1UAskPEMhGoOuTdsRTHV3/l7ByzkmeIN0NyTBXuPGkicVpg7tC8S8KpBN0jighD6JWDRPOm+V
 YaMzlv733F6kKg9vDP1rupAiJw6zP0gf1EKHf33BrwqU2ZqpJ7qtyvzrQNBQWeKbpmKQ6srVCvj
 HYiDB7EolKD+8DGUVdkvUYUKB4rJs54ug4a4srYa0GaN595q+UNAwGqCO+mHV4qXHSfXo6fIz74
 YHkzwrEm9MVogZxu9XexlWctEJLkKV7KgtCVMPZ/drh/jG3zYiUTY3tfMvL3ikD0XRO7Iw==
X-Received: by 2002:a05:7022:ead2:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1273979e682mr3080179c88.1.1771345316437; Tue, 17 Feb 2026
 08:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-5-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-5-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:21:44 -0500
X-Gm-Features: AaiRm51vZKMiP2LZQsl7_es59ocK_810Bdu0_NdUsWKUDv9OGdKsU4jiGzIh6Go
Message-ID: <CADnq5_P02Fx6-VG8Nei4QZozZ9hK1vY=1sYm4DOh71nXtmVehA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] drm/amdgpu: store ib info for devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
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

On Wed, Feb 11, 2026 at 5:29=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Store the basic state of IBs so we can read it back in the
> amdgpu_devcoredump_format function.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 13 ++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 0bf85ab43204..d0af8a294abf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -387,6 +387,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>  {
>         struct drm_device *dev =3D adev_to_drm(adev);
>         struct amdgpu_coredump_info *coredump;
> +       size_t size =3D sizeof(*coredump);
>         struct drm_sched_job *s_job;
>         u64 total_ring_size, ring_count;
>         struct amdgpu_ring *ring;
> @@ -395,10 +396,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol skip_vram_check,
>         if (adev->coredump_in_progress)
>                 return;
>
> -       if (adev->coredump_in_progress)
> -               return;
> +       if (job && job->pasid)
> +               size +=3D sizeof(struct amdgpu_coredump_ib_info) * job->n=
um_ibs;
>
> -       coredump =3D kzalloc(sizeof(*coredump), GFP_NOWAIT);
> +       coredump =3D kzalloc(size, GFP_NOWAIT);
>         if (!coredump)
>                 return;
>
> @@ -406,6 +407,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>
>         coredump->skip_vram_check =3D skip_vram_check;
>         coredump->reset_vram_lost =3D vram_lost;
> +       coredump->pasid =3D job->pasid;
>
>         if (job && job->pasid) {
>                 struct amdgpu_task_info *ti;
> @@ -415,6 +417,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, boo=
l skip_vram_check,
>                         coredump->reset_task_info =3D *ti;
>                         amdgpu_vm_put_task_info(ti);
>                 }
> +               coredump->num_ibs =3D job->num_ibs;
> +               for (i =3D 0; i < job->num_ibs; ++i) {
> +                       coredump->ibs[i].gpu_addr =3D job->ibs[i].gpu_add=
r;
> +                       coredump->ibs[i].ib_size_dw =3D job->ibs[i].lengt=
h_dw;
> +               }
>         }
>
>         if (job) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 1c3d22356cc7..49486d1f6a5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -38,6 +38,11 @@ struct amdgpu_coredump_ring {
>         u32                             offset;
>  };
>
> +struct amdgpu_coredump_ib_info {
> +       uint64_t                        gpu_addr;
> +       u32                             ib_size_dw;
> +};
> +
>  struct amdgpu_coredump_info {
>         struct amdgpu_device            *adev;
>         struct amdgpu_task_info         reset_task_info;
> @@ -58,6 +63,10 @@ struct amdgpu_coredump_info {
>          */
>         ssize_t                         formatted_size;
>         char                            *formatted;
> +
> +       unsigned int                    pasid;
> +       int                             num_ibs;
> +       struct amdgpu_coredump_ib_info  ibs[] __counted_by(num_ibs);
>  };
>  #endif
>
> --
> 2.43.0
>
