Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB30CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96EA10EBC3;
	Fri, 31 Oct 2025 14:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Blj9/Jj1";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9540D10EBC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:06:11 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b62e55af64aso119475a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761919571; x=1762524371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2/MtLyrw+5H7uhJKoTPpmPUsyiesXdaFoT/UPgBNps=;
 b=Blj9/Jj1eY7kdly77Kgx2yl82bws8gCNIDbLNhA+SIbNxn3iInWXQ5ieVC1nkFYRi9
 BSgD/sUpT3B8AeD+Peie6bZcqatTl6Z+RqAOXBGCtyUVS0zvidFnTFPgCAjVCjH1TDuY
 hm0f/4p4rXes2M+vICRtiyLGYNWXkXNdT5fws9adf16mxtnCHMPARQSp5hBUXPYgMY1N
 BUoyQ1YJgxsdufTnNU3C/i8yIUQhMps48sHrbJbfG6RZfCCKBlhoo1FP+twjEiJwTtFs
 L8PWpxNQgFl8gWnivbLLl4KQxw0DFApg6KdLXy2lW4DMO6gR2z9WKDW06DElaTbsaMXa
 pLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919571; x=1762524371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2/MtLyrw+5H7uhJKoTPpmPUsyiesXdaFoT/UPgBNps=;
 b=R1yHRF0bx5cWq+I7KPq8ZVogSuLPYUF+kPbaiUDtYhUnYtt5Pwh/rFhE6oMXnfSZ4k
 FdBufxKyKB5+eUq1Y44vvKmH2nhLcgKhF6eQzUNn43hwgGgON/4VhLHjbb9XsEU2McVi
 UwTtZ8PsmPpIb5Xmxk7eeW5ppNirZlXgID3EBRe8b2QbOzoy6hS/Xvh0y5gX2SYo70Wm
 kf2YiLDx3dZDDh7JNnwuwlD7QtE6clPbBTrujSRs8HgMKNjbYPV/hKNjTG65H056XKL+
 VZ1taBvDBk9lJzOWsU/8ap6ZoNk4h8+2lKGLi0xMqScTUm7iFzV9xpqf/GvinTCoaOgY
 Qv/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV530IlBw3WFaDCzKAHXVpM0nM4jNWVKOGw0puCoRzCdpyKhAOeWXUeIJVo4KT86TQkmpykz1qW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymQAiMMvrz5CoIGUeXmqWDR5yGbhi/M4cYd2fT5DLcY1GkrGPP
 85uh0MmYozam2PgLPzjTcaNJCDeDDqoqo3aXmjAfY/4y4q/vg5/3ZflvzHus/Y7VMQLx173fsfB
 GN0cX0Weob3E5T0n9xbLzg9940+OOjwU=
X-Gm-Gg: ASbGncsj05EsfuOLbElRJzqSGe3tlkxI7h3BKiOlbBN/V4iufEmMkQ5+zTXxzkEgcIW
 eMI9vu6ho13yLKFGD1kYV6xYpifQ6tAxHpt63loe02YIZixSGEB0yDFeR7ClVFBA6FQiDN8VJ16
 +gDROjPckt4lwq+lUyiP1CY8ktiv57FTzIS7H65krY5z2uf7WlW32b+0Fr5Hw1zaOxSbHgGjyZr
 NIGB8XK8DFJtdhIvXwfcdgg8dt4bddydzFlnwCNtnO3JaLsIlQsbf7qfhkD
X-Google-Smtp-Source: AGHT+IHvJK9SIkV9dl9Eji3RiRlWH1uWPAux5bcNYl1sPfAjnWLh7D0YH534o6gcdB39DgycnxXf1dlOIo1GTgRNSBY=
X-Received: by 2002:a17:903:1ca:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-2951a3a58cbmr26325815ad.4.1761919570365; Fri, 31 Oct 2025
 07:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
 <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
 <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
In-Reply-To: <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Oct 2025 10:05:58 -0400
X-Gm-Features: AWmQ_bkK8jenNWNTBZoUR6e92pYSMrvq8BIwzOe0AtZAK-c71dtRSYpuTU69uqY
Message-ID: <CADnq5_N3Wn4ev-FiR4PqSEZjpk=HNYZRRQLNSp-8KFsvKPHqYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
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

On Fri, Oct 31, 2025 at 10:01=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/31/25 14:53, Alex Deucher wrote:
> > On Fri, Oct 31, 2025 at 4:40=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 10/27/25 23:02, Alex Deucher wrote:
> >>> If we don't end up initializing the fences, free them when
> >>> we free the job.
> >>>
> >>> v2: take a reference to the fences if we emit them
> >>>
> >>> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handlin=
g")
> >>> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
> >>>  3 files changed, 22 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ib.c
> >>> index 39229ece83f83..0596114377600 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned int num_ibs,
> >>>               return r;
> >>>       }
> >>>       *f =3D &af->base;
> >>> +     /* get a ref for the job */
> >>> +     dma_fence_get(*f);
> >>
> >> I think it would be better to set the fence inside the job to NULL as =
soon as it is consumed/initialized.
> >
> > We need the pointer for the job timed out handling.
>
> I don't think that is true. During a timeout we should have job->s_fence-=
>parent for the HW fence.
>
> But even when we go down that route here, you only grab a reference to th=
e hw_fence but not the hw_vm_fence.
>
> That looks broken to me.

I also grab a reference to the vm fence.  See the last hunk of the patch be=
low.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >>
> >>>
> >>>       if (ring->funcs->insert_end)
> >>>               ring->funcs->insert_end(ring);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.c
> >>> index 55c7e104d5ca0..dc970f5fe601b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_=
job *s_job)
> >>>
> >>>       amdgpu_sync_free(&job->explicit_sync);
> >>>
> >>> +     if (job->hw_fence->base.ops)
> >>> +             dma_fence_put(&job->hw_fence->base);
> >>> +     else
> >>> +             kfree(job->hw_fence);
> >>> +     if (job->hw_vm_fence->base.ops)
> >>> +             dma_fence_put(&job->hw_vm_fence->base);
> >>> +     else
> >>> +             kfree(job->hw_vm_fence);
> >>> +
> >>
> >> This way that here can just be a kfree(..).
> >>
> >> Regards,
> >> Christian.
> >>
> >>>       kfree(job);
> >>>  }
> >>>
> >>> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >>>       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >>>               dma_fence_put(job->gang_submit);
> >>>
> >>> +     if (job->hw_fence->base.ops)
> >>> +             dma_fence_put(&job->hw_fence->base);
> >>> +     else
> >>> +             kfree(job->hw_fence);
> >>> +     if (job->hw_vm_fence->base.ops)
> >>> +             dma_fence_put(&job->hw_vm_fence->base);
> >>> +     else
> >>> +             kfree(job->hw_vm_fence);
> >>> +
> >>>       kfree(job);
> >>>  }
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> >>> index db66b4232de02..f8c67840f446f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >>>               if (r)
> >>>                       return r;
> >>>               fence =3D &job->hw_vm_fence->base;
> >>> +             /* get a ref for the job */
> >>> +             dma_fence_get(fence);
> >>>       }
> >>>
> >>>       if (vm_flush_needed) {
> >>
>
