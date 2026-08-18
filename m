Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33FC5DF74
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 03:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8549F10E179;
	Tue, 18 Aug 2026 03:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AVpAfBCv";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCFF10E179
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 03:12:50 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cb20b0a387bso294402a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 20:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787022770; cv=none;
 d=google.com; s=arc-20260327;
 b=UVT3ObsMlQ8C3gekSsBGEBhA+n//LK5cZCazgvv7T0femI6Fy8LvOyrX28oJA4eTgg
 8p/m6i13k1HYDAtjz6BJUFqPSZ1poWLvidlLYX0qO/onOuFYLuya5bG4Rq8BRD6su/wC
 0NCoZ4QqWsy6KJEfRVhGFbH6C4Yu8xvLKOgYDFdC2JYWxvctlKWmzDkMZMV4WL3LW+hC
 eZPAE/W0ndvdNRGnss/b8V6FkbLHzN9JUrblYyd0Zpm15kcmLm6gRLIr/1LHTsQsMmHR
 3z52rj8qB/FF7H9jEA4i/EJPSo1uky5UW8ojbb4ZlK6P1f0yu2pwA42QFqSMJqURJhc4
 +EDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4kjrISTzl+O1AQv8vINRkSYI51YsVrhFYP8YmyI1Yz8=;
 fh=QaVZRkNtXLI66jh2vYOetNzMUXkeNJRrhSQeo9LiWyI=;
 b=nDT48VGJWuUx2l6hM3o5SjP51f3EUUKKH9GCemD4n69x/j/XT0vIa7SAp8f0ZloY/z
 HjPpcgNj30Fq6gMD8Z0aJzgws5T6e/K8I/wCJ6G61yML2BqkAAY8WDQKyeopdP5+md5k
 b5vxifzLP/5IspgRzsUnv2cVZrH1t47QRo+7/H+fQxSYYpIBvfZWpjOK10aVU7Iy2qek
 Hnoz0RyIIWtS6M75cWhTFUYf5Cic3vofzNVTRb+tmuXsNHor+vSyxyg5SYKRkDjV2F8x
 mNGkJGLyixfiAXTsNb6WjHNqloQ0TjOSRGzF+PK0/awvm4H+vKVfARNGkOS9g3MT9Jrd
 ncuA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787022770; x=1787627570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4kjrISTzl+O1AQv8vINRkSYI51YsVrhFYP8YmyI1Yz8=;
 b=AVpAfBCvXGYalMmE0yns4IRF5pAN9XXxEfscCQVI6PWu/f5xvOW91e0GDMl+u2tXre
 L8MyEkU2gJjS7eK0mUR8dDhLw2n7hCNCHeYXjY5EcPnMgzca4isAyA666w94ATtvh3QL
 YseM2uZNwX9Wou57MC7j1nkefMBYux7QLuUyOKv37vZzt4ScZ3vKcI22tje/+WFPf228
 vX1qnElFutdWg7DEmG7+37dkwRDN2fVl+X+s+HRHA52UBpMt4+NJoQOJMyum7aJT91gX
 NTY+w03dpTsirYqy9miIdm9/BiW16GZsA9ea40bXBbQ/kUywYUqxBv4avoKB9ZgcChZq
 Qs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787022770; x=1787627570;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4kjrISTzl+O1AQv8vINRkSYI51YsVrhFYP8YmyI1Yz8=;
 b=e5vWYh63GF+eFTZ8Vofo/6CLnWVhjChQqJE5tFoRxD/DFdnbO/1hZ6vhFwPYSf6Dze
 tAEyFnzXfsBsrnqk1cLl1EfQLi/9TBSQwQV1L8sbRXeF/n8E8E3XVhwHlS14N2OtxwNg
 TdIywwBXVM53WrZpoHt51DoZeSg8DwIuiYu+cxKsHCtkuBqOKNAb0o5PqpySMZLXB1Eo
 /Ef7oYAk75ujmA+MNVZiwndNxCXhnoRW7m+tQbX4CqkdwEG3J5Vb4QgnOjF82wPE7oz3
 yapSF1ClT6EpX5WB+C5Hvxp6YOJlZLtIcHRTav4n9C4Cxn8oT99v3YV9jJfXDOO2OLQY
 5xcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxoktsPy4jphEav0awCgt6KZxkfwD/NczcdWLn/Kox5TJ7qL6EoFyN9Y7lGWIis61f1e5neoCN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAxRouMY0m7Hu7iXkWJDGQfieLCRCt94xpa/zHzZMxjMlepJsP
 ALgKqtS6Iz8LWJqqOrLe54817goPP+qobmKw5CA6O8zTVVrh5LdW3j6BkP9I98SN6Bx0uEX5vMP
 RNiIOe/aWADcssjPkpULWIqjGgQXj6Po=
X-Gm-Gg: AR+sD11dnMiruFuHwLkhBhR9Q51CXUCA0b2klvI6WVMnXSMsy2/gjZJPva6cFArATUX
 a4FHQ6W3ZzLqL8940KC40lH5xVyFmrfcbK+FpTxjSE+as8+TGuETpwKqQXsOhQJWMynFiL4y3KK
 RU/djDYTVtk2mlnMPhr73l6paH4hPIR9ZFcJKPx/rGNpcMbX9s0uAcMap9FcrfHIh7jPOMFQBIN
 oI2AzErdeSaGhXsaPmJ4hO4zcv/MWY/gF13AKJdy3jtOJiBDxS6VBotkFb9aUZYH3IP9AUz4Bsp
 nS3dDPw7KWRwV1acr+R9O/s3/5jdQRtmhdefWv4HsLgKZmwcJJjWcgeukmB16DBlPVQ6RJp773W
 dKAtggthr3xItC90NCxMX0mlUZcgKiyk=
X-Received: by 2002:a17:90a:d646:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-3933b6cbae5mr22594895a91.1.1787022770083; Mon, 17 Aug 2026
 20:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260814172914.2691513-1-alexander.deucher@amd.com>
 <0439317f-61e5-4595-9bb6-c99c506194f6@amd.com>
In-Reply-To: <0439317f-61e5-4595-9bb6-c99c506194f6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 23:12:38 -0400
X-Gm-Features: AcwNN1VYTPPy_DVIdVGouhec4V3yyWa5M4QE1YnXJi0WJ9yk_0UM1Vi8GxgTqHs
Message-ID: <CADnq5_PJOyo9_4vCVoFVvyJJRSLKauXxKSoVcvkPLZWeVnvjSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: David Rosca <david.rosca@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Aug 17, 2026 at 4:55=E2=80=AFPM David Rosca <david.rosca@amd.com> w=
rote:
>
>
> On 8/14/26 19:29, Alex Deucher wrote:
> > If we end up emitting a VM fence keep pipeline sync
> > associated with that fence.  If not, emit them as
> > part of the IB fence.
> >
> > v2: fix need_pipe_sync handling
> >
> > Cc: David Rosca <david.rosca@amd.com>
> > Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence=
")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 +++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
> >   3 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index da4dc489e80bd..360e6f00cb7c0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               vm_af =3D job->hw_vm_fence;
> >               /* VM sequence */
> >               vm_af->ib_wptr =3D ring->wptr;
> > -             amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_need=
ed,
> > +             amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_nee=
ded,
> >                               &emit_gds_needed);
> >               vm_af->ib_dw_size =3D
> >                       amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr,=
 ring->wptr);
> > @@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >       if (ring->funcs->insert_start)
> >               ring->funcs->insert_start(ring);
> >
> > +     /* this may have been handled by amdgpu_vm_flush */
> > +     if (need_pipe_sync)
> > +             amdgpu_ring_emit_pipeline_sync(ring);
> > +
> >       if (emit_spm_needed)
> >               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 71050a86bcc3a..b7d0461184d62 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_rin=
g *ring,
> >    * Emit a VM flush when it is necessary.
> >    */
> >   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job=
,
> > -                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *need_pipe_sync, bool *emit_spm_needed,
> >                    bool *emit_gds_needed)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > @@ -827,7 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >       if (gds_switch_needed && emit_fence)
> >               *emit_gds_needed =3D false;
> >
> > -     if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> > +     if (!vm_flush_needed && !gds_switch_needed && !(*need_pipe_sync) =
&&
>
> The only time need_pipe_sync in this check makes a difference is when
> only pasid_mapping_needed (which is missing from this condition, is that
> intended?) is true and the rest *_needed are false. Then emit_fence is
> true and pipeline_sync is emitted in this function which looks fine.
>
> If pasid_mapping_needed and all other *_needed are false, then
> emit_fence is false and the rest of the function effectively does
> nothing. emit_pipeline_sync will be called from amdgpu_ib_schedule.
> While this works, I think it would be better to return early here?

I see what you are saying.  I think this could be simplified to

if (!emit_fence)
    return;

If we are not emitting the fence, everything needs to be handled in
amdgpu_ib_schedule().

Alex

>
> David
>
> >           !cleaner_shader_needed && !spm_update_needed)
> >               return;
> >
> > @@ -847,8 +847,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >               patch =3D amdgpu_ring_init_cond_exec(ring,
> >                                                  ring->cond_exe_gpu_add=
r);
> >
> > -     if (need_pipe_sync)
> > +     if (emit_fence && *need_pipe_sync) {
> >               amdgpu_ring_emit_pipeline_sync(ring);
> > +             *need_pipe_sync =3D false;
> > +     }
> >
> >       if (cleaner_shader_needed)
> >               ring->funcs->emit_cleaner_shader(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index 7f2ba728e3ed3..d32183cd9e0fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >                      int (*callback)(void *p, struct amdgpu_bo *bo),
> >                      void *param);
> >   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job=
,
> > -                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *need_pipe_sync, bool *emit_spm_needed,
> >                    bool *emit_gds_needed);
> >   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> >                         struct amdgpu_vm *vm, bool immediate);
