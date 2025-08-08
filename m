Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFC3C87FDA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1799410E0BC;
	Fri,  8 Aug 2025 19:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6PV49iW";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6ADD10E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:49:37 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-240358f4aa2so1404795ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754682577; x=1755287377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+qqt9WTkLQFiHptUqc5NzYzKZyivPlPXlnocvoFmIE=;
 b=C6PV49iWZbXqmCX3XSfQO/Glm8PChSBne0EKf2ajab75fKte4gsfKTk1Xv9pMv+gfB
 eXbc3h7RFaH7PpwffJU9AZFiqGry2uBWFm/W9PAR+1hU2KCH58ggxnIvTDq1utfCrwtT
 zMzhU0eKQE9sh24dDgmWtlcIcIXBCqI8g7wU3KuobEW+9Q5CE9dluBfMyKcuYKjjbx4t
 KV1ZRhbVChosM+IFI1AZTvRcujrbGt0UreSqM5L2UNBJupl+dIrc/0kmmYeaMKNkviO9
 +j74cKu72X06FmhSjCUJKPUt71RwWg/BF64NEcaF0NV/l1qAOfLj/e9SxBGcLza6BCve
 YJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754682577; x=1755287377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+qqt9WTkLQFiHptUqc5NzYzKZyivPlPXlnocvoFmIE=;
 b=eXmK+CxAA6nbpMOQf7GwJPpn+Hu2Z6pqUgYwjBI7xqVWRWl/b6yvjCX+lgkmFxnA3u
 K8ZDNeGXFWS+3as1/YsaHx5ihnNbD3WOKukPUnaZ3HUzubpwwYnkj6OYG+XHJLSIXB+K
 DjRGnaGhF1Ikp8K6EcGH8eNzIb6ZXJau12kjAEUplqwyu+lQPSrltZ+z2Vvl3lYpssJy
 0ISHkr4Eo94I2cjS9/cmXYLoywjReXqpFtBk1i943irooe/9sMnuZjzxPcukvmyJgFzh
 adfR1bJh8FUIduMInxT5XByrIttj0GKBmYwzLf9oQZjRjtxg5p3KUlkQUyhHPlWNwRoj
 aqkg==
X-Gm-Message-State: AOJu0YzB0m5r9sYIx9whBuJVskGrWIfrlGC30LPsDA8rX4MIMs4ARG/L
 QH+MOXtQzjgUVewJ043bNGBKkSelfdBoySFkH/VcNjfkS3RKRMVc+fTIXQ2HKgNmADUqE3UJE22
 ox18hcLL8ArZdblYWsPilqTL9MN1yKkM=
X-Gm-Gg: ASbGncsaJc5Aa4lNzsYgMk41N/G8lzQcNPBkE0SXc6wcPFgvU4T+JC/UAGckC/0/cE2
 aCt2jXYbv7BgDvuLHqeq04U6aInFD5bgaYYj41OiCFx25TeBoCJpcSUyArLuer+wpaCuGyvrglB
 IAjzTiZp5VNVTuHkjiaOr09Dejbs33mt4mH50iad7Lg5B+YaHM8fn2YDkVrnAgh5DYVh9kttmS8
 16XYuA=
X-Google-Smtp-Source: AGHT+IHEnsFC/KM6RsaTy6qKDrto7uDIBp3lDvN06n/hvEOEYHkt/Tkf0Jv4Z3dvLKxkJsiikrWVtGhaYWZ3rHKhsaY=
X-Received: by 2002:a17:903:1a67:b0:240:7c3c:dd7b with SMTP id
 d9443c01a7336-242d390092fmr1007115ad.7.1754682577260; Fri, 08 Aug 2025
 12:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
 <20250806022816.1050823-4-Jesse.Zhang@amd.com>
In-Reply-To: <20250806022816.1050823-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 15:49:25 -0400
X-Gm-Features: Ac12FXwLhmq0g64TmuJEgnFs1RxQf6r761nJE3hdj1DlNMysW_wKZuvzbjAI_Pk
Message-ID: <CADnq5_PDRnH_qd4Mz554oANctUgbDTLDEFecx2K9tPF9fGzG9A@mail.gmail.com>
Subject: Re: [v7 04/11] drm/amdgpu: Add helper functions for user queue
 preemption and restoration
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
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

On Tue, Aug 5, 2025 at 10:39=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This patch introduces two new helper functions to manage user queue
> preemption and restoration:
>
> 1. amdgpu_userqueue_preempt_helper() - Handles preempting a user queue
>    by calling the appropriate IP-specific preempt function and updating
>    the queue state. If preemption fails, it marks the queue as hung and
>    triggers queue detection/reset.
>
> 2. amdgpu_userqueue_restore_helper() - Handles restoring a preempted
>    user queue by calling the IP-specific restore function. On failure,
>    it marks the queue as hung and triggers a GPU reset.
>
> The helpers properly manage queue state transitions between MAPPED,
> PREEMPTED, and HUNG states, and handle error cases by initiating
> appropriate recovery actions.
>
> These functions will be used by subsequent patches to implement
> user queue preemption support in the driver.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 48 +++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index aac0de86f3e8..1496544cd1c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,6 +44,54 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +static int
> +amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       int r =3D 0;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +               r =3D userq_funcs->preempt(uq_mgr, queue);
> +               if (r) {
> +                       amdgpu_userq_detect_and_reset_queues(uq_mgr);

This function isn't available yet.  This should be part of a later patch.

> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +               } else {
> +                       queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> +               }
> +       }
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
> +       int r =3D 0;
> +
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D userq_funcs->restore(uq_mgr, queue);
> +               if (r) {
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       gpu_reset =3D true;
> +               } else {
> +                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +               }
> +       }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);

Same here.

Alex

> +
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> --
> 2.49.0
>
