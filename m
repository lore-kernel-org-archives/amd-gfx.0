Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB43FC47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C32A10E466;
	Thu,  4 Jan 2024 15:00:50 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17F610E466
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:00:49 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6dc1fdc19b6so363875a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 07:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704380449; x=1704985249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfmfr/iT1Uc4MWF+lPXyUAh4eFAvoReLU6oLe3/AS+s=;
 b=atsrAa7066Emg/IjAq2qsqzSevVlYlhifKHe5FbLevrI0hqxjLeDOvvWVTHIKvmqTd
 8q3Xa5Jid5T2V1bWWo4RDrBwokiANTIlbt6uskTaI+uWiKCpCZT8blhwKAbFSKtIO3Py
 aB8MohTlE4wneb+yE2QvsVeqp3J7EJ49M2kEvI/Abc1UsXLJFbM9JnCLhqjozzDmrAKM
 k4AkFBOk+iqVqmcCFlnmwXtf7LjeECPKxbmXbbAIIFNetpVNC7RJH8ICxSOn17epXNcr
 mr2xlfApcFz/Of2+5ns7AYZYwUYWZ+Emzn/Aog8KLHMPuOzWFkLJO4crL73uwZRM12cE
 Fv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704380449; x=1704985249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfmfr/iT1Uc4MWF+lPXyUAh4eFAvoReLU6oLe3/AS+s=;
 b=VwO9w8BxsNl2z6Xwhro7TdVbwpxhbY2g2wtsX5rgaoWfGtEUVporfwGXEJPG/c6Y4L
 7ecWduWS4VmfxR5hADzhdRDLFOo2z6+Hmcox6wZU4uT9Lv6Na+8yYjp80wO3pLDcNb08
 RUWX93y0hfnc9NeW7yOFqirgeboqcfzC+12YPXr9ZYLg9X62cdBmxo1Mzy10/tqG5X1R
 ENg0PJoZEhlkR+lZXlrCsEFXduLCkJyF0A8+e1J4gYOfmVnkcVHGvshIu0ApvvrgQZ1N
 ceMuTOiD26ZZOt3NQMPIGbBHUi+B3cO+5d4jSuqaSvAE7rkguXhBvQpGoo34EEcKWUUm
 kaQw==
X-Gm-Message-State: AOJu0YxLRKCcqaHWrYvtY7oxyUbFlHQCMYrl9L3hYwBt+tMYLH/WyfND
 jDcgpwPzm29hRrwk6n9RkxBWE5nTkmEzcRUd6FwGyZKm0NE=
X-Google-Smtp-Source: AGHT+IFBO+EqtVRG6fmraylq2qEyopSL+60oP7XpHC2+g9E/qSMSa2uEQDKLr5jKjmq2aHjp1IGJk5u93xcW+5Z8l6E=
X-Received: by 2002:a05:6870:898b:b0:203:e3ec:9041 with SMTP id
 f11-20020a056870898b00b00203e3ec9041mr797385oaq.41.1704380448754; Thu, 04 Jan
 2024 07:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20240104053902.546605-1-Jun.Ma2@amd.com>
In-Reply-To: <20240104053902.546605-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jan 2024 10:00:37 -0500
Message-ID: <CADnq5_McS5k_F8BonQ-F1nUhAaDd3teoMgxYv3O3kYgbZbDi=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
To: Ma Jun <Jun.Ma2@amd.com>
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 4, 2024 at 12:55=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Fix the warning info below during mode1 reset.
> [  +0.000004] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  ? show_regs+0x6e/0x80
> [  +0.000011]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000005]  ? __warn+0x91/0x150
> [  +0.000009]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000006]  ? report_bug+0x19d/0x1b0
> [  +0.000013]  ? handle_bug+0x46/0x80
> [  +0.000012]  ? exc_invalid_op+0x1d/0x80
> [  +0.000011]  ? asm_exc_invalid_op+0x1f/0x30
> [  +0.000014]  ? __flush_work.isra.0+0x2e8/0x390
> [  +0.000007]  ? __flush_work.isra.0+0x208/0x390
> [  +0.000007]  ? _prb_read_valid+0x216/0x290
> [  +0.000008]  __cancel_work_timer+0x11d/0x1a0
> [  +0.000007]  ? try_to_grab_pending+0xe8/0x190
> [  +0.000012]  cancel_work_sync+0x14/0x20
> [  +0.000008]  amddrm_sched_stop+0x3c/0x1d0 [amd_sched]
> [  +0.000032]  amdgpu_device_gpu_recover+0x29a/0xe90 [amdgpu]
>
> This warning info was printed after applying the patch
> "drm/sched: Convert drm scheduler to use a work queue rather than kthread=
".
> The root cause is that amdgpu driver tries to use the uninitialized
> work_struct in the struct drm_gpu_scheduler
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  3 ++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 4b1d5f42249f..7bac3019aa0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5575,6 +5575,16 @@ static inline void amdgpu_device_stop_pending_rese=
ts(struct amdgpu_device *adev)
>
>  }
>
> +static bool amdgpu_is_ring_sched_ready(struct amdgpu_ring *ring)

I would either rename this amdgpu_device_is_ring_sched_ready() for
consistency, or move it to amdgpu_ring.c and rename it to
amdgpu_ring_sched_ready().

Alex

> +{
> +       if (!ring)
> +               return false;
> +
> +       if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
> +               return false;
> +
> +       return true;
> +}
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> @@ -5700,7 +5710,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> -                       if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> +                       if (!amdgpu_is_ring_sched_ready(ring))
>                                 continue;
>
>                         drm_sched_stop(&ring->sched, job ? &job->base : N=
ULL);
> @@ -5776,7 +5786,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> -                       if (!ring || !drm_sched_wqueue_ready(&ring->sched=
))
> +                       if (!amdgpu_is_ring_sched_ready(ring))
>                                 continue;
>
>                         drm_sched_start(&ring->sched, true);
> @@ -6265,7 +6275,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                 struct amdgpu_ring *ring =3D adev->rings[i];
>
> -               if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +               if (!amdgpu_is_ring_sched_ready(ring))
>                         continue;
>
>                 drm_sched_start(&ring->sched, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 41266bc99345..3650e4d06e53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -636,7 +636,8 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>                 DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
>                               ring->name);
>
> -       ring->sched.ready =3D !r;
> +       if (!ring->no_scheduler)
> +               ring->sched.ready =3D !r;
>         return r;
>  }
>
> --
> 2.34.1
>
