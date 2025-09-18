Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED2CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DB110E8F7;
	Thu, 18 Sep 2025 20:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJf0jp4b";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0907F10E8F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:30:38 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-267dbd4e189so2854945ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758227437; x=1758832237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=itlecr1AMbeQejBGwhaBOOreCrpUrTQwKi1eT+1tYJw=;
 b=dJf0jp4bOjjTg2aWR6Y1OVCP5EwQ0XA0XzRbHk17Nk3ct2sGMhThWfOzPN12/pld9a
 7kOaDIiXrgpm1zJf/1TxJKgm0Pben1SO6X1YYq/tH2cZh8Ck95938363ZmPTk6NF+G+V
 EBGDNsxyaZqd9+pDLtSLi8FtOrcfwBvc0OaG3nGuM6It02B05+rZfOHwcb89xsI7kBRF
 XyBbF1eapHZxH9BFbh7yn40fMZK6FWfjhnkjBaajDbbUD7F2niCGszzMSdnpCrNBg/Ws
 zgiMtG6dJM7NeNaDixlS8XmvpD0l3XFAtnO2WJHUiNdYgyCWvgLVf/TKTJ/NLE7tJnpr
 UJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227437; x=1758832237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itlecr1AMbeQejBGwhaBOOreCrpUrTQwKi1eT+1tYJw=;
 b=c0K1t+k8EEMCq4M7J1YkDVgUfHkyvgZzfP4Yre/ulpjRHjGZet1lNfhEtIqJ2Xb6LY
 /zJK9wrWma7jqhMt6nqDn+fab6iD0uQMbAG1rxRKDONaL+PFcfYSepTTwoXZPZN1gVOD
 zQi7INaNSi1JXpg6IH2g41YEcJpji1zaHnu5qMmTlNAUJdsceCkLrCPrj89dkz+TeTLT
 EMqWL5b8d02m5Me0cGYO+lTeGWGCHvEkJg/XvsisGyHkl/gsEMObwAP3iv0tTXOuD9te
 3C5qI5O5JRtgkEgVDQDJdCWSKz8yKxNaNEG+HRo57pckfM59eOBqUR+f7HL4h0h3zzhw
 mBkQ==
X-Gm-Message-State: AOJu0YwI9rcZmSnWJMneR4q38yJguhcArw7XA3ANF0oXhEtcQgw9AiiE
 YAucYYYBJQlN2gbJThAkw73ys1ZpcENYnakVz5/y+sQB6sa5VU598R3D2JeQWmYv74pxIBuNd+b
 axjd2XitobCU9fzZmi5shOsOFKaLcgTo=
X-Gm-Gg: ASbGnctsUTs7smeECEqATT7rVtU+ncet9vu7uOD0FXTjklLXeOoiUR82KG3bWMsR8Uk
 aKTOL4Joi6N2mzK9+eULVtBHf6c4811eHlZ7ukMR4bbcgX6NeYN2G++U3wDiD/AA2SP5j7B1qQB
 OQUOj8YuThhm/0AS8NJ/AWNO0j5rBc1DcnSXxXf69GB4aFZBqrNKPvWx7gnc3q8fsqlYhZWqtE0
 eS3MFaYL0xK+DWgNgeJFoO9sQ==
X-Google-Smtp-Source: AGHT+IE5XSN5aeSgP1gnSl0cy/5wrAyMU9aIN14IIl5DbsCxRwilKJWJCfSWRiKufJLOxKujQk+utYf+C4KUuvCAzuQ=
X-Received: by 2002:a17:903:1a68:b0:269:9ae5:26cf with SMTP id
 d9443c01a7336-269ba47beb2mr6326225ad.4.1758227437355; Thu, 18 Sep 2025
 13:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-9-Prike.Liang@amd.com>
 <CADnq5_O8AA=LvBwv518uwbW=YHBAuedg+WsoQodLwinTdL+hMg@mail.gmail.com>
 <DS7PR12MB6005162B656C4EF265B6E602FB16A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005162B656C4EF265B6E602FB16A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:30:25 -0400
X-Gm-Features: AS18NWAvM25IjO44zT9lArLZRzmw5eRk_hLJfXfD3rq151yMHLS-OYoJEVTmMFc
Message-ID: <CADnq5_PPax-tWwABAYTa2wReUNMiqWrKq9t=gBHx3OcT3W+_Hw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Wed, Sep 17, 2025 at 10:37=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, September 17, 2025 10:10 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
> >
> > On Fri, Sep 12, 2025 at 2:04=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > When an user unmaps a userq VA, the driver must ensure the queue has
> > > no in-flight jobs. If there is pending work, the kernel should wait
> > > for the attached eviction (bookkeeping) fence to signal before
> > > deleting the mapping.
> > >
> > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29
> > > +++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |
> > 3 +++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++++
> > >  3 files changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index a13f186f0a8a..e14dcdcfe36e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -1182,3 +1182,32 @@ int
> > amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *ad=
ev,
> > >         mutex_unlock(&adev->userq_mutex);
> > >         return ret;
> > >  }
> > > +
> > > +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> > > +                                      struct amdgpu_bo_va_mapping *m=
apping,
> > > +                                      uint64_t saddr) {
> > > +       u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
> > > +       struct amdgpu_bo_va *bo_va =3D mapping->bo_va;
> > > +       struct dma_resv *resv =3D bo_va->base.bo->tbo.base.resv;
> > > +       int ret;
> > > +
> > > +       if (!ip_mask)
> > > +               return 0;
> > > +
> > > +       dev_warn(adev->dev, "now unmapping a vital queue va:%llx\n",
> > > + saddr);
> >
> > dev_warn_once() so we don't spam the logs.
> It seems unlikely to run into this case, but I'm okay to change this to d=
ev_warn_once() or dev_warn_ratelimited().

Unlikely for a proper application, but you could write a bad
application which would cause the kernel log to get spammed.

Alex

> >
> > > +       /**
> > > +        * The userq VA mapping reservation should include the evicti=
on fence, if the
> > eviction fence
> > > +        * can't signal successfully during unmapping, then driver wi=
ll warn to flag
> > this improper unmap
> > > +        * of the userq VA.
> > > +        * Note: The eviction fence may be attached to different BOs,=
 and this unmap
> > is only for one kind
> > > +        * of userq VAs, so at this point suppose the eviction fence =
is always
> > unsignaled.
> > > +        */
> > > +       if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> > > +               ret =3D dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BO=
OKKEEP,
> > true, MAX_SCHEDULE_TIMEOUT);
> > > +               if (ret <=3D 0)
> > > +                       return -EBUSY;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > index 8cd307be7256..c9a41876f10e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > > @@ -157,4 +157,7 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_vm
> > > *vm, u64 addr);  int amdgpu_userq_buffer_vas_put(struct amdgpu_device=
 *adev,
> > >                                 struct amdgpu_usermode_queue *queue);
> > > bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue
> > > *queue);
> > > +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> > > +                                      struct amdgpu_bo_va_mapping *m=
apping,
> > > +                                      uint64_t saddr);
> > >  #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > index bd12d8ff15a4..ccde1f040cef 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > @@ -1941,6 +1941,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
> > *adev,
> > >         struct amdgpu_bo_va_mapping *mapping;
> > >         struct amdgpu_vm *vm =3D bo_va->base.vm;
> > >         bool valid =3D true;
> > > +       int r;
> > >
> > >         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> > >
> > > @@ -1961,6 +1962,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
> > *adev,
> > >                         return -ENOENT;
> > >         }
> > >
> > > +       /* It's unlikely to happen that the mapping userq hasn't been=
 idled
> > > +        * during user requests GEM unmap IOCTL except for forcing th=
e unmap
> > > +        * from user space.
> > > +        */
> > > +       if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
> > > +               r =3D amdgpu_userq_gem_va_unmap_validate(adev, mappin=
g, saddr);
> > > +               if (unlikely(r =3D=3D -EBUSY))
> > > +                       dev_warn(adev->dev, "Here should be an
> > > + improper unmap request from user space\n");
> >
> > dev_warn_once().
> >
> > This looks good to me, but it would be good to get Christian's input as=
 well.
> >
> > Alex
> >
> > > +       }
> > > +
> > >         list_del(&mapping->list);
> > >         amdgpu_vm_it_remove(mapping, &vm->va);
> > >         mapping->bo_va =3D NULL;
> > > --
> > > 2.34.1
> > >
