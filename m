Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7779FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACB710EBC1;
	Fri, 31 Oct 2025 13:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a7PeV1vR";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487EA10E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:53:19 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b6cf20d145bso136058a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918799; x=1762523599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDxRNGr6IMPule+vOYxVe81OBUGjCmbIWuRPZzLpYRw=;
 b=a7PeV1vRPmcW0I2uWXKZcJMk74CiKgSPnj0stGDBMAf3QgAA5Rqoc0XDTkG3/VK/xf
 o0bHxa0onWNhv+yUC1tp+I30GV6m7d+mOPTr37TVpvv9us9AJNLb4ciCAMAb+U3FeaBr
 z6LYDDyxC1xG2ErzRIipkdID3rFA/tt7+EMa/zKKkVzCFEST82UqsdC6p7xUF4n1iT0V
 kae+48jZuIzyCo1rkvEa4ag7tW4IvR+jbGbx6OUuWMl09CjhxChGLU1JYDBEk7GXQqNo
 jlq24XwdAW6Akyld+uKudrgw3A2ZbIkjnansGgnes8w6m5SoIBKJwPTw+Y5Ch0Jba9XK
 fv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918799; x=1762523599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDxRNGr6IMPule+vOYxVe81OBUGjCmbIWuRPZzLpYRw=;
 b=HzkEF5wQacjPMsc6eTMknPaj5f7gWHxj8LE1yAYVQjI2KeGUqpRhnltn0UZvXdOBQ7
 MB1B1w0U0BoYpyrz9yRpEZQf/tUrhnrmlyJ43wif/tN/pqq87C0VMj+R5K6US7hS6S1F
 9vRgFdVrPkSJImmEzjy6wzGjSCqk4c/x3HhveF1oyLD4Lv59d0gWU4aReQ7CSt6S+pwj
 qZYPK1Tjf9l2iIlyJF+J/fwW4m5qPDwG/XK51hqsGceU4RD6lfKwtYZ/z6KHRl18/zMS
 OoCtIJ7D7aF1wpi86qg3aGXngdBLUJwwnHXK4FKw26VHDIyVWYZef7n2NJAMZsXBrCLD
 jAmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3UCpGl0J8+YMlN6RSFgEiNz+u3v+M+c2JaAQ+Pu+U5UscqmPMRoPDiTnQDipcqbsw58CrZHm8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIESVr0tC4epXaMdeJrCMG7PIP9obTDvIncfwquXozvqZ112SH
 ocpg1GhTUJKjnGuzQjsO1M1rIyZCUI8UmMrptzAqb31Bc/X6bwSZHGGYv42kvU8TNqldKXG119Y
 Z8Ub1H+N/vDMNgg0iXeF645ZXH+ypra4=
X-Gm-Gg: ASbGncvcq/Rm7LvZm+r1/elzqcv/N/lLT1vhbVn+67N0d+qtUZQozg6mUErvW1Jzoc+
 WtZfHiShm6NxBHn3q/ELQzvFon/73tLyf5iMSfJoc+E1bZlFuXTbsoZW6sGi4aoBrVffqA7Lm75
 7xiMH5KJAs14JXjZkxX6d2o/mePgJab8aARjj51ODbeGWqs8MmZk4qIskRrmEtDjBNGlXAfv1ao
 k1GN0qDhqtC8cTeeUIqz688oOmmyokgui21qIC0P/Oq1WFGOXDrVzyHXYaTHITkTtfrTRs=
X-Google-Smtp-Source: AGHT+IEXpdbr3Y4gK1zAB7ghUD63bsKjWod2J8QNhSnXMHDNTdMj6AIpewf3Bo1gKLOG40Xj3PzvhXc3A3UAueJMqlk=
X-Received: by 2002:a17:902:c40a:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-2951a3bbbe7mr30872865ad.4.1761918798536; Fri, 31 Oct 2025
 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
In-Reply-To: <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Oct 2025 09:53:07 -0400
X-Gm-Features: AWmQ_bntxVbG1UkqlB2-MdUmQAIZ8EysbPUx6fKmhYaxghKjHtwDUQEIGTWfThs
Message-ID: <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
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

On Fri, Oct 31, 2025 at 4:40=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/27/25 23:02, Alex Deucher wrote:
> > If we don't end up initializing the fences, free them when
> > we free the job.
> >
> > v2: take a reference to the fences if we emit them
> >
> > Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling"=
)
> > Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 39229ece83f83..0596114377600 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               return r;
> >       }
> >       *f =3D &af->base;
> > +     /* get a ref for the job */
> > +     dma_fence_get(*f);
>
> I think it would be better to set the fence inside the job to NULL as soo=
n as it is consumed/initialized.

We need the pointer for the job timed out handling.

Alex

>
> >
> >       if (ring->funcs->insert_end)
> >               ring->funcs->insert_end(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index 55c7e104d5ca0..dc970f5fe601b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_jo=
b *s_job)
> >
> >       amdgpu_sync_free(&job->explicit_sync);
> >
> > +     if (job->hw_fence->base.ops)
> > +             dma_fence_put(&job->hw_fence->base);
> > +     else
> > +             kfree(job->hw_fence);
> > +     if (job->hw_vm_fence->base.ops)
> > +             dma_fence_put(&job->hw_vm_fence->base);
> > +     else
> > +             kfree(job->hw_vm_fence);
> > +
>
> This way that here can just be a kfree(..).
>
> Regards,
> Christian.
>
> >       kfree(job);
> >  }
> >
> > @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >               dma_fence_put(job->gang_submit);
> >
> > +     if (job->hw_fence->base.ops)
> > +             dma_fence_put(&job->hw_fence->base);
> > +     else
> > +             kfree(job->hw_fence);
> > +     if (job->hw_vm_fence->base.ops)
> > +             dma_fence_put(&job->hw_vm_fence->base);
> > +     else
> > +             kfree(job->hw_vm_fence);
> > +
> >       kfree(job);
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index db66b4232de02..f8c67840f446f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
> >               if (r)
> >                       return r;
> >               fence =3D &job->hw_vm_fence->base;
> > +             /* get a ref for the job */
> > +             dma_fence_get(fence);
> >       }
> >
> >       if (vm_flush_needed) {
>
