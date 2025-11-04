Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD37BCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E60C10E26F;
	Tue,  4 Nov 2025 13:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hyu2oT41";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B3310E26F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:36:34 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b9da0ae5763so189832a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762263394; x=1762868194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcXSG+pcTtIW2KYkiK8m+U6Unh+mlK+T/VjSK7JWrmo=;
 b=hyu2oT41XV46FYsFjXn7Bo4md8tkVL/0wloZOkpSqJm1nxYjpvlbWOubWI/vbbP6jE
 N7P+RxglGX/dR2Sp6PKFQOuYjVxpcU4Wu+TaoBy73bSyAvqPYc52PsYBAPRoQvz/KWWw
 JdoauTMI07vZSGoh1Ncb+BjzwnUUJioQkZl12vD1HvIdao1R7YeUDCAYQ5V70UsxIHvY
 g9CH6uJWAFGhPH8CDSF7UoYpLE5sLH3F1l+JXeBMS5+74jY21L43HuDErDmcAX65K2xf
 5hTwotaoDLm77+H1ecPIamQ49eFHv1kGZAEkv1Yf0PXwqVwFP1wgD9Wzf/2svrDbvsju
 FzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762263394; x=1762868194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcXSG+pcTtIW2KYkiK8m+U6Unh+mlK+T/VjSK7JWrmo=;
 b=RZVA9wX3ffHT58YOjbCvJatnP/iUZ0Xrl3OsJEJuHFvUsCj5c/vOP4cGe3nOTpyk6S
 EqjjdOSWSnomtn1ow8pCT/0WiF1tRmVWmd8EuS/WG/yGyWJeBqpjAiB4uhbILvsW0v5p
 CrBe76QujiQtyk331GRaBu+1jXfmTOfOSg4Qq+1ewF7ejDncwApK65Tw/PFpcha9SXJu
 p966N6K7wrLLRu+sPIkVb49/zb9C2QQHA0gck1P7qN5qfyZaTGDDyW7xA+Mo9TrKeqo7
 NyTEeS/l3kGGtUn0nWozYbYiQ/bxDIJcgF9kOjQGQLdcYdaQLaGbr6QRFZwRHBOpBTLS
 WjOQ==
X-Gm-Message-State: AOJu0Yx3KL3+WtzkX1xxCCV9HPjbx4xMX62qZStmRyYSL9nZl0nREM92
 GiJshpulbrV4yBObQb6Rp9BEqDf6/VWsb9oP4Uz4Bp0l/Mf09nTLVRdQEBzU72pYu30DGbi+MnJ
 jxtlpIao9/KJXWW8voZEnAo4SN60FVMA=
X-Gm-Gg: ASbGnctN6mMX62OJk3p3vZxQLsaTn8v2SHso9AAPjy5eZy3dUYdT3TQciuEvzYe+5z9
 kWYVTPJFdNpRYd/HeK+7S5QvK2pLrPT23hr2RkeiDxAxH/5O68N1Y09JHodk4hD+IErVVn1PHzZ
 MbS7zu7c4gQvYHS+fipR82Df7c0qDmvJhgw+pbgCII1rfzd2l/ozMPkrX8sHjhKjnQ4sklYcP5v
 5/Fkm0xV9Ic+dC6O/1qyj8SD/LgmNcaVBkHPpaCIG8aXMAGcaCa0K/quPY5
X-Google-Smtp-Source: AGHT+IGNkaDGmnoZP0lkFAJkd13e1KKi239c429SvFLJkSSd3HxhAKjEbZtrWdyE2CyKLE/Quwb1TSzskPSzB3N9pJg=
X-Received: by 2002:a05:6a20:3d8e:b0:341:10b:da0f with SMTP id
 adf61e73a8af0-348c9f614demr11294788637.2.1762263393500; Tue, 04 Nov 2025
 05:36:33 -0800 (PST)
MIME-Version: 1.0
References: <20251031174308.5234-1-alexander.deucher@amd.com>
In-Reply-To: <20251031174308.5234-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 08:36:21 -0500
X-Gm-Features: AWmQ_bnQbzpdEefSEUM_NDTVLkiPA_hqwag_p-yLUl5l-SPTKekxR2L_xzmZzCw
Message-ID: <CADnq5_PZjoMqpHA785Y0namOGqu8pS9dqivuthq5pqtu5vdDMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Jesse Zhang <Jesse.Zhang@amd.com>
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

Ping?

On Fri, Oct 31, 2025 at 3:01=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> If we don't end up initializing the fences, free them when
> we free the job.  We can't set the hw_fence to NULL after
> emitting it because we need it in the cleanup path for the
> submit direct case.
>
> v2: take a reference to the fences if we emit them
> v3: handle non-job fence in error paths
>
> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 19 +++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 39229ece83f83..586a58facca10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -176,18 +176,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
>
>         if (!ring->sched.ready) {
>                 dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n",=
 ring->name);
> -               return -EINVAL;
> +               r =3D -EINVAL;
> +               goto free_fence;
>         }
>
>         if (vm && !job->vmid) {
>                 dev_err(adev->dev, "VM IB without ID\n");
> -               return -EINVAL;
> +               r =3D -EINVAL;
> +               goto free_fence;
>         }
>
>         if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
>             (!ring->funcs->secure_submission_supported)) {
>                 dev_err(adev->dev, "secure submissions not supported on r=
ing <%s>\n", ring->name);
> -               return -EINVAL;
> +               r =3D -EINVAL;
> +               goto free_fence;
>         }
>
>         alloc_size =3D ring->funcs->emit_frame_size + num_ibs *
> @@ -196,7 +199,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>         r =3D amdgpu_ring_alloc(ring, alloc_size);
>         if (r) {
>                 dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
> -               return r;
> +               goto free_fence;
>         }
>
>         need_ctx_switch =3D ring->current_ctx !=3D fence_ctx;
> @@ -302,6 +305,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 return r;
>         }
>         *f =3D &af->base;
> +       /* get a ref for the job */
> +       if (job)
> +               dma_fence_get(*f);
>
>         if (ring->funcs->insert_end)
>                 ring->funcs->insert_end(ring);
> @@ -328,6 +334,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned int num_ibs,
>         amdgpu_ring_commit(ring);
>
>         return 0;
> +
> +free_fence:
> +       if (!job)
> +               kfree(af);
> +       return r;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index fd6aade7ee9e3..efa3281145f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -293,6 +293,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job =
*s_job)
>
>         amdgpu_sync_free(&job->explicit_sync);
>
> +       if (job->hw_fence->base.ops)
> +               dma_fence_put(&job->hw_fence->base);
> +       else
> +               kfree(job->hw_fence);
> +       if (job->hw_vm_fence->base.ops)
> +               dma_fence_put(&job->hw_vm_fence->base);
> +       else
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> @@ -322,6 +331,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>         if (job->gang_submit !=3D &job->base.s_fence->scheduled)
>                 dma_fence_put(job->gang_submit);
>
> +       if (job->hw_fence->base.ops)
> +               dma_fence_put(&job->hw_fence->base);
> +       else
> +               kfree(job->hw_fence);
> +       if (job->hw_vm_fence->base.ops)
> +               dma_fence_put(&job->hw_vm_fence->base);
> +       else
> +               kfree(job->hw_vm_fence);
> +
>         kfree(job);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index c3dfb949a9b87..82e897cd5feac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -849,6 +849,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct =
amdgpu_job *job,
>                 if (r)
>                         return r;
>                 fence =3D &job->hw_vm_fence->base;
> +               /* get a ref for the job */
> +               dma_fence_get(fence);
>         }
>
>         if (vm_flush_needed) {
> --
> 2.51.1
>
