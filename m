Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F4C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 20:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FF310E756;
	Tue,  8 Apr 2025 20:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gD8Xdr7B";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450A010E756
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 20:50:41 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so843388a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744145441; x=1744750241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUCnJmrjuunZkChhlgfDbZvajHsqtAE7K9EsEzMEvG4=;
 b=gD8Xdr7BgRsSo7ZZeW21A2uq0sYLJiEm0umIExZXElHP9JInBhC8Z9eknG6GXWvfZu
 FIUPsJcReFzo4H06fBlwEHzm5cqUqcv2QnGVvi48y/ze4j8efAQDGT2FzMgbHNZTOIyP
 WiyrWNhLTRyg1qEFODadQXdSJ2FcZ9fMkFAldWsJzBA9kfEsj8cGa8A6O88ZOgB0FYCk
 dfm26yRXzIAxLkvtePRIMTG1TR89dr/3bWsD9caN5yYwizEE0gTGZyDHeKEghWbBqQ5q
 QuOZn/xJtwPrjEtJiylwVbZ1z1NMXitZOIGhX7qsqKS739yul3INQYs/UtQcZmj11DW6
 M+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744145441; x=1744750241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUCnJmrjuunZkChhlgfDbZvajHsqtAE7K9EsEzMEvG4=;
 b=cAg+Ujx9wO7LnOrwXwNX29Pxh/sKZx8aqF+O+Lo2t/gLMqVn1FtW+gTFy2NL8dtl6g
 hYnxnWaprt7RGL2wXgKp2z7n4w3v8ketvGJiVcs8uGhYlS9/zbNbAfHYuKvlVlsHXEf6
 QEz5UhmU7rIUY1nDP3NSjKncUIDPX1FMzMFp8FBh2Fr35HzJZKtlqJ16/VD7SLYA8nlt
 djDmYONGvffr5oIDRYcsuzytbWpTBU6VSWXoiBjBuwac2jK/bxqYfneWpdWuBLOWrlnq
 2A8EU1z87Hd3aiKvp04LCFqG/dLxGX3sGIvE8VUwXeFt2A+7hKjGntW6kaMNfgQpFGMl
 RLkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2oq3jcw2l9S7Cl1pFYj5zbEVMIpvB/J+Qw4vZ6gQ2D8PXYzI+esR3u8s1UV7RqwCDM5Y/SNWl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyHTiIg+CJ6A3MqCrNFgXMmDagL2FgXKTiTCsnTa8umGO7V4QU
 Pn0rNmLmYqVeOMudXwoh8ibCz8qKBCdZrY8lMimOneWtj8rddOEe1eeX6WMcBkFfnYWwGX0ioZL
 SMoFLQVT6clgyZXLeRHyPxKz9m3o=
X-Gm-Gg: ASbGncuUBUy7Sd+GnJhmad276vKz8cP+ZHn5d4RA5Sl1izBsCPybFRvFCMUxb+ZupUy
 hr2W5fxfKKM4GFbirtb5kHd6cSaA+Mi7p+sS10bgFqGw+5rdGdcQ8Rc1j8ccK68KVxCT2d5L/yZ
 YNSeErhx3GdTjTDNeXYs8qBcxOwQ==
X-Google-Smtp-Source: AGHT+IH55/qT6/x/KoaJCz8i9hwbfRBliMvCfkd7+fWOXu9eUNRugRPUbDDwNCF/yGrQFcC839bJ0AqN68TdIpVJ83M=
X-Received: by 2002:a17:90b:1b42:b0:305:5f20:b28c with SMTP id
 98e67ed59e1d1-306dbc30564mr312271a91.5.1744145441009; Tue, 08 Apr 2025
 13:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250408153018.1770-1-christian.koenig@amd.com>
In-Reply-To: <20250408153018.1770-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Apr 2025 16:50:29 -0400
X-Gm-Features: ATxdqUE4BFisDtfecETTArMmEQ0jNAJqUU3ubEZgPGviXm6mi-a1OQ3f144vApk
Message-ID: <CADnq5_Ohx_9gvBQchLJDDhX+GddUMX+o6A79cLO7+CBfbFGB-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: use a dummy owner for sysfs triggered
 cleaner shaders v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Apr 8, 2025 at 11:30=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Otherwise triggering sysfs multiple times without other submissions in
> between only runs the shader once.
>
> v2: add some comment
> v3: re-add missing cast
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index f64675b2ab75..76237961a08f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1439,9 +1439,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>         struct amdgpu_device *adev =3D ring->adev;
>         struct drm_gpu_scheduler *sched =3D &ring->sched;
>         struct drm_sched_entity entity;
> +       static atomic_t counter;
>         struct dma_fence *f;
>         struct amdgpu_job *job;
>         struct amdgpu_ib *ib;
> +       void * owner;
>         int i, r;
>
>         /* Initialize the scheduler entity */
> @@ -1452,9 +1454,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>                 goto err;
>         }
>
> -       r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
> -                                    64, 0,
> -                                    &job);
> +       /*
> +        * Use some unique dummy value as the owner to make sure we execu=
te
> +        * the cleaner shader on each submission. The value just need to =
change
> +        * for each submission and is otherwise meaningless.
> +        */
> +       owner =3D (void *)(unsigned long)atomic_inc_return(&counter),

missing semicolon at the end.

Alex

> +
> +       r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> +                                    64, 0, &job);
>         if (r)
>                 goto err;
>
> --
> 2.34.1
>
