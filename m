Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789AAC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 16:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B2710E938;
	Thu,  8 May 2025 16:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USm5qhvL";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA66610E204
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 16:45:52 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-30ab2041731so130949a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746722752; x=1747327552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZmOz3HUVlEdaMoieVI7kqcFT+Dh5grwSeEQoWrGZ1g=;
 b=USm5qhvLeU9Cj2DHurOC1W5FoJcFqflGlK6hCHIIEHOAIxIV7oKCnqz0+OZ4d1VmbQ
 NJrkXw+2n9R8GkvrDdfkAAcd1Ff8S7pH9FsbhSjKX9rHnoz1JUR2i/DSw6oAi2e7E5nj
 a1ALNTQ76BihKSIWhr3eMR6mvjcy27e6SF1moqnYQoW3LDfSowwrlWx1wwGvBnf2q4Zm
 rd7SORDWuuxaxMKskpSWU5y3N/La+pLw2CAlRRiG1kKMLBUaA3HntKsyOaZhk75jsp2l
 FMzgk7zMDMCb1iAzsMd3HX3OLNgkcIt4/4YqtjAyGuBV2LQ9V8YaRv19BjTzhD6Ps5bX
 t9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746722752; x=1747327552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZmOz3HUVlEdaMoieVI7kqcFT+Dh5grwSeEQoWrGZ1g=;
 b=W6639d/Kg02Wi86U/wKX0wkR+HVId0xdGhqJWOEaMstDVEgVpx0k2P7ptzJ1VaxKBu
 WJoibPe1wa9tZoEY/uPM46IoyHGDhg7NgD2l/+farNGAC1huL7M+zXX1oLn5ah/6tyeY
 fQ+a+iB41KA9MrurhgPg7rEi2TFGr38vTAKoSnFdRql6g3/GWdvj/ZMsi9DTt3LmYKyS
 2pyNfjpRrM9GKkNP1J/yvjmbcO4bJqi/gpeI7htbQ5e9JYJTP92OKmvRmoQ080/fDQrf
 23MGYiaJKIkwDo4RpUl+2Lep+Cz+aXlegkc9vr+3Gx0m5qMh8gUO4Jh4D35lfNPsnPWf
 6cHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVARhiDwGhLAMhmIPSL5NwTWz9wzTSsLDYavH0M6CZ0zP2LrKejcpZtdCNM0G2X2fPXDnTMbIVs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ46Owrr9O1CgwVmbFZXklhO6a0qiENqZhpoQPjbxmhN0VV/JC
 Ck+r2zgU3m7a4E4yQFB6Co0pDlWDAW6/NlCqSG0xwWPMIxLSVmm1xxKUxkUbJUrd567NS45z+dY
 q9bqKx4zAs4K92/g27glpCIzZUkrqY22W
X-Gm-Gg: ASbGnctN4RRdD9kiKLyv+Q2xIuYnit5OA98aAIZNhGcQFKv6tUb1N0H9+lz1nUNdhQn
 DUcgn0Izmuqu3EHjWxU1tA6AyoBBlSMoVGQOrtBBDlEiibSWIZnEqC/QGwvRvqd1kwK1n292orE
 GybMafZnxPLXZ7gjy98zHARw==
X-Google-Smtp-Source: AGHT+IF/mPuWdyyi2CwlWiw+JUleZjtYBYjOxDo6aOhOlF0XtoS5LVI7UaFuv1FBNv+6Lvlo51NH1SBRn9RlZVPNjHs=
X-Received: by 2002:a17:90b:1d01:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-30c3caf9708mr129302a91.2.1746722752114; Thu, 08 May 2025
 09:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
 <20250506155900.3866874-4-alexander.deucher@amd.com>
 <DS7PR12MB60056C245299450DC5CFE66BFB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60056C245299450DC5CFE66BFB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 12:45:40 -0400
X-Gm-Features: ATxdqUFJoz0CCoxohEvGwWh-x1IVu3PbDfVbtRpvOovqRiKsReo7zH90ilfTmMo
Message-ID: <CADnq5_Nae5=POjyh0M55zbkvtq3vgMDhF+UT6KAOA6FzjjPH1Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Wed, May 7, 2025 at 2:02=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> w=
rote:
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, May 6, 2025 11:59 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
> >
> > Add support for forcing completion of userq fences.
> > This is needed for userq resets and asic resets so that we can set the =
error on the
> > fence and force completion.
> >
> > v2: drop rcu_dereference_protected (Christian)
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++++++++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index 029cb24c28b38..ce0d06a8c4997 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct
> > amdgpu_userq_fence_driver *fence_drv)
> >       return le64_to_cpu(*fence_drv->cpu_addr);
> >  }
> >
> > +static void
> > +amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
> > +                      u64 seq)
> > +{
> > +     if (fence_drv->cpu_addr)
> > +             *fence_drv->cpu_addr =3D cpu_to_le64(seq); }
> > +
> >  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> >                                   struct amdgpu_usermode_queue *userq) =
 { @@ -
> > 409,6 +417,38 @@ static void amdgpu_userq_fence_cleanup(struct dma_fenc=
e
> > *fence)
> >       dma_fence_put(fence);
> >  }
> >
> > +static void
> > +amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
> > +                                 int error)
> > +{
> > +     struct amdgpu_userq_fence_driver *fence_drv =3D fence->fence_drv;
> > +     unsigned long flags;
> > +     struct dma_fence *f;
> > +
> > +     spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> > +     f =3D &fence->base;
> > +     if (f && !dma_fence_is_signaled_locked(f))
> > +             dma_fence_set_error(f, error);
> > +     spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags); }
> > +
> > +void
> > +amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queu=
e
> > +*userq) {
> > +     struct dma_fence *f =3D userq->last_fence;
> > +
> > +     if (f) {
> > +             struct amdgpu_userq_fence *fence =3D to_amdgpu_userq_fenc=
e(f);
> > +             struct amdgpu_userq_fence_driver *fence_drv =3D fence->fe=
nce_drv;
> > +             u64 wptr =3D fence->base.seqno;
> > +
> > +             amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
> As the user queue fence time out in this case, so the fence error here sh=
ould set as -ETIMEDOUT?

I chose -ECANCELED to align with what we do for kernel queues and
because it was the driver that canceled the fence due to a hang.

Alex

>
> Thanks,
> Prike
> > +             amdgpu_userq_fence_write(fence_drv, wptr);
> > +             amdgpu_userq_fence_driver_process(fence_drv);
> > +
> > +     }
> > +}
> > +
> >  int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> >                             struct drm_file *filp)
> >  {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > index 97a125ab8a786..d76add2afc774 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> > @@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct
> > amdgpu_device *adev,
> >                                   struct amdgpu_usermode_queue *userq);=
  void
> > amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);  v=
oid
> > amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver
> > *fence_drv);
> > +void amdgpu_userq_fence_driver_force_completion(struct
> > +amdgpu_usermode_queue *userq);
> >  void amdgpu_userq_fence_driver_destroy(struct kref *ref);  int
> > amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> >                             struct drm_file *filp);
> > --
> > 2.49.0
>
