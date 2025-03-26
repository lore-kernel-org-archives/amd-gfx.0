Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7F4C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9E310E6D4;
	Wed, 26 Mar 2025 13:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mfUxdxM5";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F9D710E6D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 13:56:11 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2240ff0bd6eso19063745ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742997371; x=1743602171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3/84ZrmkUWxuI3zdsOV3cN5KS1Q2VyasxFS4lQOG3k=;
 b=mfUxdxM5krnRcEERwYvnQNx2HX9bnMSUvmvLDVlFnr9lbJ1GJKPxcODO/kXU/BJAP0
 +KPE8vs/zuioIUGliAK9RhmnS4LB+q9tdVf271qmsekJaIdHx9j0h5sMafFQsoPTgp1v
 io8dywCH7MERACcS8otSbt0ggJwYi9KKcn/28J0ybDN7T1yQHJeG4Te4KSUNQ/wvPl49
 21FG+IwA1dbORtITa5poDZIzA+G+kcPgVXNc3V0GF4Lii/9HKh3m/amWoNGFp4cG5zK+
 RF09ShIQMfX1y9Vz8o6y5tWA4CZqfAT5N9yi+HGoWvQm1FAoVwyy85DzPUn6MQCMsttw
 I3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742997371; x=1743602171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3/84ZrmkUWxuI3zdsOV3cN5KS1Q2VyasxFS4lQOG3k=;
 b=wnoXZb3UPSRqEYWsecKFHTsVc0lImrdFYVApyYZQ49R6fELe3dVTidPJTMP3oFjOhi
 BAQQ5Buo1Ff2g4ilpJ3/GIL/dY7hocqX9uz6qEtxPlbJxw9Z5TVvkyBxE9lg2n5Omwt+
 bmuoEfRruhun5IyIdQaXJmpb5q1nYoZnDFBWOZ/vCXBgBqKQN12EpsSsewNUAbgj1PxC
 7On0nBayekI3KT+BS9hKWM/Lpxx5j6Idb0InjfL6yX0cL8nJJImlI7X5/nfjWNDwVNvL
 PbnROKUopnoIvH/0rX7/wgDxJwq4cLUqjOauD1844NzLdeIj4Spm6ZZhvQ11CIpqq6D8
 ls7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgT63GtF7u9ZuIbO6abD+QaMvuLQ+MQMIibVSZ7NOiXKDh9D8oP1xGSmqqcRhmm6wRpQmLJfGm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlNSUtvANeESCPFjaEi58SnSMejD1C6alEVmn942/Ay8x514CB
 gYCAqeHiARtDB1GPw9tWIIhiRwnxIP7pmmVDLQlmg9gfyXJ5t6TabdvZvwHArWRTz7P8119wG+h
 /Ov4Q1lPxU5aIJL+WCtj9pke10LE=
X-Gm-Gg: ASbGnctRNAtVP1DyzDER2yWWz9p3+0OVmC39v/J7KiaXAQJKzeWAcnPu6Kv5TfbMeLh
 7h6pel1i2FXmk3kqAnjGaqDpdd3vIWfZtMXUzziq2XJdH9HtzMCnVxi6yPai29oaFyEmOGfUofH
 Tofm54ejo71ifxr4uIs9jErdSOxzJh5khhmKP5
X-Google-Smtp-Source: AGHT+IGL+bpuOyv4+6S5DdOZGbajw9eVFIQyqeTfQkjetYNtPNndokVkBL0drxoLSLu0Ei8NNmRt2fIAw8BmwHIBiao=
X-Received: by 2002:a17:902:e74d:b0:224:13a2:ab9a with SMTP id
 d9443c01a7336-22780d7ffa2mr111844865ad.7.1742997370780; Wed, 26 Mar 2025
 06:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
In-Reply-To: <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Mar 2025 09:55:59 -0400
X-Gm-Features: AQ5f1JoZDrz76tBPcioKCYqy7BrW9o_LKpjR2Xg_sB9VKKwbY3Gx-qJMrWE_d3M
Message-ID: <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Mar 26, 2025 at 4:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.03.25 um 16:24 schrieb Srinivasan Shanmugam:
> > This commit addresses the issue where the cleaner shader was not
> > correctly executed during gang submissions due to improper handling of
> > the isolation spearhead.
> >
> > - Enhanced the `amdgpu_gfx_run_cleaner_shader_job` function to
> >   initialize `isolation->spearhead` with the job's scheduled fence for
> >   cleaner shader calls.
> > - Updated the `amdgpu_vm_flush` function to properly initialize
> >   `isolation->spearhead` to the job's scheduled fence when the cleaner
> >   shader is required.
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 +++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 72af5e5a894a..807f17093006 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1436,6 +1436,7 @@ static ssize_t amdgpu_gfx_get_available_compute_p=
artition(struct device *dev,
> >  static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_isolation *isolation =3D &adev->isolation[ring->xcp=
_id];
> >       struct drm_gpu_scheduler *sched =3D &ring->sched;
> >       struct drm_sched_entity entity;
> >       struct dma_fence *f;
> > @@ -1464,6 +1465,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(stru=
ct amdgpu_ring *ring)
> >               ib->ptr[i] =3D ring->funcs->nop;
> >       ib->length_dw =3D ring->funcs->align_mask + 1;
> >
> > +     if (job->base.s_fence)
> > +             isolation->spearhead =3D dma_fence_get(&job->base.s_fence=
->scheduled);
> > +
>
> Apart from being very risky because of not grabbing locks that will leak =
the previous isolation->spearhead fence.
>
> >       f =3D amdgpu_job_submit(job);
> >
> >       r =3D dma_fence_wait(f, false);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index b5ddfcbbc9fc..e23400b53489 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -692,8 +692,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >       if (need_pipe_sync)
> >               amdgpu_ring_emit_pipeline_sync(ring);
> >
> > -     if (cleaner_shader_needed)
> > +     if (cleaner_shader_needed) {
> > +             isolation->spearhead =3D dma_fence_get(&job->base.s_fence=
->scheduled);
>
> Same here.
>
> Over all this change doesn't seem to make much sense to me.
>
> Why exactly is isolation->spearhead not pointing to the dummy kernel job =
we submit?

Does the owner check or gang_submit check in
amdgpu_device_enforce_isolation() fail to set up the spearhead?

 if (isolation->owner !=3D owner) {
                if (!job->gang_submit) {
                        dep =3D amdgpu_device_get_gang(adev);
                        if (!dma_fence_is_signaled(dep))
                                goto out_return_dep;
            dma_fence_put(dep);
                }


Alex

>
> Regards,
> Christian.
>
> >               ring->funcs->emit_cleaner_shader(ring);
> > +     }
> >
> >       if (vm_flush_needed) {
> >               trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
>
