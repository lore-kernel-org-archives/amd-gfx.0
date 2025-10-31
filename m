Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8087CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 15:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E3810E2DD;
	Fri, 31 Oct 2025 15:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFRlt3GA";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B30E10EBE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 15:29:04 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b8b33cdf470so214723a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761924544; x=1762529344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz/E+ymWcW5OY6Stb3GOlyG1xf0N/ngOi/4oul2t/ts=;
 b=UFRlt3GAf6I8/j8+6d9OUFZRgwXTByknCoZp8jMR4x5fycd7Rqo+pFsOJZ+lP9G78X
 pNIq6sD3e/1IP0WHSr4gE6FKIHq96ct0fVG33TEnJAOVn4T2ZuF+mRptWhAOF+KAwLaM
 Sdc7CnHTzl5C4uQIXC65buelup6MuXm5yHnC7vgar+J/ZxU3E36TdQuOrAmomeluFQfK
 byLj+u097gCwYp0ik5LofEt4SosEQ1+67l3EM8v6kUqgFfcbIE1yk1p4qlurR74DANb+
 BAr19zMim1hIZWWF/VdUBDAMOZ8O+MbB/Mx1qjzrw9wu5dH+o232sLVd2yY5CgPvbHGL
 VBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924544; x=1762529344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz/E+ymWcW5OY6Stb3GOlyG1xf0N/ngOi/4oul2t/ts=;
 b=KCJ18ATk510enJfvTHJ1wKmk19xsrwuqGW6nbB5xcEz1nzWUYWLE3+SpJLz0hfhXCS
 ckuZNyvJdEJeab2XJBDp4KgFLH/k6ga/zO4apiu7ETN7L2sZ0D7fc14UrwDW9FAkkA3E
 dSKBTJA+O29L9jWDDJrzNfMhudrcyUDYavKYaoZubv6OwVCgbKYhmIELYOf3WXP3Od92
 CMQb7wFbDjE+iD3Emd9XW/RCY+49bu3A5XrkvwIPKD5XAFf8SCcGK8P18ryDW1kdO/Ya
 Ud7uJi5Nfsj9nw0Z1UR1lP9T13ZnsCH4+VLExkp83f9u0p4mz1JL84o8R95dnd0F6mUM
 cX1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAsXD+14IUM3RHt39wPySxUn1VGUeULm3N6oMm8rwA9XzbLlxpw3bBBr5CzSDS5ZvWi51/hh51@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLkAN6+mxyAMdIz1t0f+Uxf5hu4RgLYQJd+Npp4gHVxCnKBUbM
 AEWHazvFuhvW7j18kyNnnjdz5YLVjhMH4yvZsJwDIaRkOCENUqGStDvYfuypL+BxLW2KBEYkTBq
 7s5h7db5pvAXxMWU+PvX/ZdaceWBpDxGZPA==
X-Gm-Gg: ASbGncvqWlgJzrvQ5Nwm90RpMhC1UbFvQLKqiWMINrzXntT8XtVY1BEnj8+Tf/Ggfmm
 tv45rQlaCRZ+7wjDuZ3Blt98JiO1QfzCMQQ2iwI00c4gl5JYNMQq1wLUerOolxD5gjeIp8dWf9q
 i+GiHsIeKIDrQa4IZrta6iqxB7xnd2fEtJHrIjitvMRi3dWdhd+mOstF3To7ek9BE3WlLh4SKoT
 fOePSpVBZtEsbAXNyGIK6LHkNxcPe0xBHMQjrLV2tuTZiDqXwWzeDu8dlW6t6TOcZ/g9tU=
X-Google-Smtp-Source: AGHT+IFLpE/QB3n9e0DdWIb4ZiCHdTHwJ4K/JkKXnzY5SYjJC1606b4RS7d3AUi62/HdQo1hujx/pqTkQvW1o2KNzM8=
X-Received: by 2002:a17:902:c651:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-2951a491ecamr20281535ad.6.1761924543849; Fri, 31 Oct 2025
 08:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
 <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
 <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
In-Reply-To: <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Oct 2025 11:28:52 -0400
X-Gm-Features: AWmQ_blnV35ppzkgc52AmlDcM703Sh68rd8uxVEzZxjNTLOY7OqmLezl24i5WGo
Message-ID: <CADnq5_NT-P-izFo-hWi7dpfDtU8WZitEw4xaKOjczRmgzwH5SQ@mail.gmail.com>
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

We also need to keep it around for job_submit_direct() so we can free
the IBs used for that.

Alex

>
> But even when we go down that route here, you only grab a reference to th=
e hw_fence but not the hw_vm_fence.
>
> That looks broken to me.
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
