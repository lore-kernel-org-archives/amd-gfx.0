Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A423BE77180
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE3910EBC8;
	Wed, 11 Dec 2024 17:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KfnYihGM";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C0110EBC8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:27:47 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2166db59927so4220755ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 09:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733938067; x=1734542867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etr8wccynS2p6xLXd33jXyDMSvNJ/QEzlVc7uzuo5TE=;
 b=KfnYihGMgFK0l/2UG5eT8HUXtCTM1JQ+7u5yBcEJl/xY1+JdXf+RCk9XfzgkU2nQpw
 oBIxxRXn0rU0UEVNmn5gRr850TXQgIsSRsOH7rtQ51TSljj+ttVK0lJVYSqko5w3LOSJ
 YXDYhy2zXYfA0GGZ5TP1vzk/VFHAhY93TgABJOzbP7hP4v/dnYxavMRZTR2Ki9mGw86Q
 dh9wfUPzsuFh3YI8WGSxA0JJ9VbHGIG+loP9r5VWGFCoOib85TFQ/xhft8BXEIA1d6ap
 rY8DKFOO6aGyYkHm1llVZhB6MzYKNb+O8dgDkOiLhItpiNrBuIMTRdjqCXyZUu/i2Q1r
 UMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733938067; x=1734542867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etr8wccynS2p6xLXd33jXyDMSvNJ/QEzlVc7uzuo5TE=;
 b=RDYifQEXz4swhIeScgAfdX1+wUEKVuLOtK0TxWKoOVJhY0rQrlVrAZZvvBUllhsMiH
 cV1t/R/GlxJV3SU3QlvjMWeYPatlfGlNxhbMlEz8HppjdJiZaWi8LA2hrFzkQOAfAW2K
 bDSCHB0XHgUB0FXyA4WGLs4KfM/H4AhFiqZK9fbvWvEUol430wlt0c3kAFtOC3hiREDZ
 AuNBfG5gIUg01nK+XhI6e4H5BWiXJUWG4sIUiKas2RlOukU46v6STjC4Mh5TkDckTFLE
 WkfYL/FkWTxTpSC5nI1pF0/t+ztZag8e//DU8q40uxHOdvfPDmqtUBj0+iV7VjiNbX1M
 pPAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX/Cw0Vkv8q1dbPUQ5c53Zfno5u/1WAKj04TdyFLLnePzzWimVK8KusfaREMn1HQTU6dRZ8YRu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhcrPkU2CFyiqdKftVXVztkzuyI492xvmDRHdxyHuuwEZhRm8w
 xwQTEfyvjJzTcHdVxhMaV6O5j8Qzjan6yp2bSGCyCkRR2Pzyu3KBvqbJsj4dRb0bhV7YeMmlCAQ
 7B5LcMKxlhrgRRsJATHrg1E5+oGtBLsfT
X-Gm-Gg: ASbGncss5iknNpDcJP48GXiYLcNPiM/8Zayi/o0XY8l0BDiOhgq75t8C/TyRcSpmcKa
 gP6Ldd+Io40c7N9ZJlZPNmyWPR2f9x7lkuYQ=
X-Google-Smtp-Source: AGHT+IFX+eOD6Cby6PBTc1FpP63FAl7eXf0/iu2KYjlQhyX7xxPlIQRjVOQHv+p9OxdSImapqUFkKjK0Hvg//o/k6mw=
X-Received: by 2002:a17:90b:3b8d:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f12802ce34mr2161577a91.4.1733938066963; Wed, 11 Dec 2024
 09:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2024 12:27:34 -0500
Message-ID: <CADnq5_O8LQ6_vj3hG9JG8EraWHmur4CTzwqP3oYYUPyt69RD2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: don't access invalid sched
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Dec 11, 2024 at 12:13=E2=80=AFPM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Since 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")
> accessing job->base.sched can produce unexpected results as the initialis=
ation
> of (*job)->base.sched done in amdgpu_job_alloc is overwritten by the
> memset.
>
> This commit fixes an issue when a CS would fail validation and would
> be rejected after job->num_ibs is incremented. In this case,
> amdgpu_ib_free(ring->adev, ...) will be called, which would crash the
> machine because the ring value is bogus.
>
> To fix this, pass a NULL pointer to amdgpu_ib_free(): we can do this
> because the device is actually not used in this function.
>
> The next commit will remove the ring argument completely.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Please add:
Fixes: 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")

With that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 9b322569255e..9ec8d5a8e48c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -256,7 +256,6 @@ void amdgpu_job_set_resources(struct amdgpu_job *job,=
 struct amdgpu_bo *gds,
>
>  void amdgpu_job_free_resources(struct amdgpu_job *job)
>  {
> -       struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
>         struct dma_fence *f;
>         unsigned i;
>
> @@ -269,7 +268,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job=
)
>                 f =3D NULL;
>
>         for (i =3D 0; i < job->num_ibs; ++i)
> -               amdgpu_ib_free(ring->adev, &job->ibs[i], f);
> +               amdgpu_ib_free(NULL, &job->ibs[i], f);
>  }
>
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
> --
> 2.43.0
>
