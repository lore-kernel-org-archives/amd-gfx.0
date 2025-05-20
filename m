Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D9EC3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 13:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D259410E589;
	Tue, 20 May 2025 13:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4mjXTN4";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7857E10E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 13:10:02 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b07698318ebso779223a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747746602; x=1748351402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DB9S7leQ27BaDZE8TteQUQl42Chb+q71MuiDFMFTAE=;
 b=f4mjXTN40mOqLW4O8rvC6EN4lZIwDXrQBu5bgkxZAKQ2ni/yH8xyHOW33ZR4hKimnZ
 M6OIveDKHUUgHDYBLcTCOFGkuu/e0HWTpU+UiQ839D31r7sfSxJuIOGVXVzZEGuQrcAk
 lAAm/W7b19yaCD7ANeHpzzD8sSZobEg7PeEMzaueRnfmLiuwtcxjGqIBJfJlTpOlhlFM
 wjl3Jrzb94opRqb1kmbqK4+cM1eKYtSIE9ZZhc5oXA58mCUjk3XwitFNdGSsnzu75Rnb
 ERjHF7jwwPKzBnS4n840BWgsE5z2VFIjlASeoyn7PL9ox11Gq5qNO9xxj7xkyJOIvP4S
 Jvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747746602; x=1748351402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DB9S7leQ27BaDZE8TteQUQl42Chb+q71MuiDFMFTAE=;
 b=I6uzJfRNzsczqh2Ep7LzeB0DJrJLqlAY3uMcmSwxxSBKtR1TWZdqg2k9SXlU2Ify4u
 Zyzp6zyjDUINuuRApaU92k49tRMu1gsvMJWSLhAZUyXDbTptDLgCmC9AV8rypZx8NGXQ
 pl1lVXz+czYUnqIo6hyGqtRMpTsdnKrz7k2uRR3D8hGzh9dgb0jTO3ZR3lJ1fNeg8GMi
 2PU9wCNuxyT3NajJkeQK4IQul2P/lueaB89Sjb8hYEwbvTTUrIZgK7KroTDHnVJy5GSU
 8zqa3Zmf3xS/BlQpwdgSrK99o+n8pPc50cXp6k8n1enKyQ54ekwZrauKyIYFkMBHGWCF
 ltyw==
X-Gm-Message-State: AOJu0YyDwEaNZpwywSuMHxG1igR1FCKQSFdis/9RPdx6BEy/rf3EVnaa
 Wkcx6SRwDcVy4uXMDcA3AOaPQ/mQ21V15EtzoTdVsFXKGL9p1ULUiuAofMakfq9EYbLKEtUmxSv
 qL+9O8QS3OU9hlSRM6bDUi63e25BxouFcgg==
X-Gm-Gg: ASbGncv4ZUlL4hjMHA2MOUROyjboQWtm0g0AAj4jarh9WOhDkBOIiuMZiDHpXantNYF
 jiP1srK6nR7AfBUZyAWbT6s2HJnD/JhBO5gPCcPkpFI3xNO0MD/1klkqG3Hip5UQ6EoPCbqikSF
 AXKiMutFvDx8ukLRbNbSL/PYQQJiOwti4BDg==
X-Google-Smtp-Source: AGHT+IFl978ftC7RAVV2hKrmIraaNE7KXLSjRYuQaItXr0q2Qhq9smoNoS4UOR9PdHDo05Oa2z+1YNUdNashVN9K+nE=
X-Received: by 2002:a17:902:ef4d:b0:22e:62c3:8c5d with SMTP id
 d9443c01a7336-231d43c5c52mr95249415ad.8.1747746601794; Tue, 20 May 2025
 06:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
In-Reply-To: <20250519182209.18273-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 May 2025 09:09:49 -0400
X-Gm-Features: AX0GCFtwd4ulu10oM8O-5hX3d09gOu5ICHckyAVAUdh_KIKT9aKF2iy1R77GuYA
Message-ID: <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, May 19, 2025 at 2:30=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>
> Stopping the scheduler for queue reset is generally a good idea because
> it prevents any worker from touching the ring buffer.
>
> But using amdgpu_fence_driver_force_completion() before restarting it was
> a really bad idea because it marked fences as failed while the work was
> potentially still running.
>
> Stop doing that and cleanup the comment a bit.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index acb21fc8b3ce5..a0fab947143b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>                 bool is_guilty;
>
> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sch=
ed->name);
> -               /* stop the scheduler, but don't mess with the
> -                * bad job yet because if ring reset fails
> -                * we'll fall back to full GPU reset.
> +               dev_err(adev->dev, "Starting %s ring reset\n",
> +                       s_job->sched->name);
> +
> +               /*
> +                * Stop the scheduler to prevent anybody else from touchi=
ng the
> +                * ring buffer.
>                  */
>                 drm_sched_wqueue_stop(&ring->sched);
>
> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
>
>                 r =3D amdgpu_ring_reset(ring, job->vmid);
>                 if (!r) {
> -                       if (amdgpu_ring_sched_ready(ring))
> -                               drm_sched_stop(&ring->sched, s_job);
> -                       if (is_guilty) {
> +                       if (is_guilty)
>                                 atomic_inc(&ring->adev->gpu_reset_counter=
);
> -                               amdgpu_fence_driver_force_completion(ring=
);

Do we still need this in the case of rings where we reset the entire
queue?  E.g., compute or VCN?  In which case we should move this to
the ring->reset callback.

Alex

> -                       }
> -                       if (amdgpu_ring_sched_ready(ring))
> -                               drm_sched_start(&ring->sched, 0);
> -                       dev_err(adev->dev, "Ring %s reset succeeded\n", r=
ing->sched.name);
> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE=
_RECOVERY_NONE);
> +                       drm_sched_wqueue_start(&ring->sched);
> +                       dev_err(adev->dev, "Ring %s reset succeeded\n",
> +                               ring->sched.name);
> +                       drm_dev_wedged_event(adev_to_drm(adev),
> +                                            DRM_WEDGE_RECOVERY_NONE);
>                         goto exit;
>                 }
> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched=
.name);
> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.=
name);
>         }
>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>
> --
> 2.49.0
>
