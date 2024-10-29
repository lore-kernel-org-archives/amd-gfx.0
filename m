Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE5FD2AB3F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 13:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B4310E654;
	Tue, 29 Oct 2024 13:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVnM5RqO";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210C510E654
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 13:32:41 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-71e5417f8d4so257372b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730208761; x=1730813561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeXe+rXFNKMW0os/WLqYAclOjFXLlwR2Jocg04Lau10=;
 b=QVnM5RqO5OMZ3wWuXDDQAL7Ux9Y+qn4Mmey18psqUuutNWXX9l6Id+/8ti8CmhInQB
 4M2ImD+6I3LQ/i2a8uy/Qh3kA6Z323iuRJzTGN7OS3CBxHOENLziJu8kRl0wgRutTBww
 NAPuf1cAMDmk0I/iezUaX626oH+mOXJtRLeiECCf6fZAiB5fZcXsd3W3qFgl0Gc9Q/Hz
 JX7j9SLp5nuWW/tSekn943XTjtTj4ziOTJcWozpCn7lqJ9way9BozPdniEpHj8EUVeUN
 4ZQwJ2ciFjClNw1UeWqRexQ1lz3aAsdhwieHj4ZcwxlyaKaKZzzqMwERvQLe1Qg3hNnY
 YczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730208761; x=1730813561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeXe+rXFNKMW0os/WLqYAclOjFXLlwR2Jocg04Lau10=;
 b=in383cnJ/l3nwOj4JEGyRzVAlf8unKxuGSRsV1qEwne35lEWl6wtSdlaEhAnfFDLjZ
 uhdKxTSQUxqlymekPOtIUNRPd2g9X5yX/LdIqFqkSgtqbJhtfArnqnwSOdAMDD4duhoE
 qYl2/gRh1IBx8uzBax1bx8x1ti6A3vFsHg7b4vmhBy0sOrD3HHYB+vGjlJvClD7guPg9
 XQz2HaqFssMH3gHbqwXDYCMqJB1KGb7YTbCQpTdd8R0OwQ2JDVESpbQqE70/QJkXNRF/
 68AZU6N/fBXAAIiTLAHAzMdx+0f/7mCdsPuyej9rx4LN0ITWXbJMuma5WiLv5R+WCnK6
 JO6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnRpvnRsnppFl/KLpDPnSPBx7i9EptrvPxQRSRLJSnbkZGhzRZnIfcLccv/EI+NBro/epq2oxF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA3MR5cZm00ttSh+JxWu0juvRerBXn2Y47r+SdD/t/n3Z5vPcX
 2AqfFnml+VuNjLTI/z1E8+AoOevVL0Cg4RzKcbnvhPk1q3SKgNiD9Yris4QWeeE4HPvIp/Fn7T8
 mO8vB2RUc+G0GKUkJJOJtv+FaD9M=
X-Google-Smtp-Source: AGHT+IF3gGAMaUybrgAQGM/OmRqGpSKCnsfBrldghjz/nsa0f3fqW2GFAwfV/Nx2R0xTwAUlt2Ai9sKNRw9jWcaCrgc=
X-Received: by 2002:a05:6a00:1798:b0:71e:eaf5:2e with SMTP id
 d2e1a72fcca58-72063020dfamr7320753b3a.3.1730208760542; Tue, 29 Oct 2024
 06:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
 <9ba915e5-2266-468f-a978-f89a33bb9fc8@amd.com>
In-Reply-To: <9ba915e5-2266-468f-a978-f89a33bb9fc8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 09:32:28 -0400
Message-ID: <CADnq5_OduwSsD+ZCRwSF1+2HwDRGjgZ_V0R8QYuK6LxrQ7Zz4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add userq specific kernel config for
 fence ioctls
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Tue, Oct 29, 2024 at 5:38=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.10.24 um 14:10 schrieb Arunpravin Paneer Selvam:
> > Keep the user queue fence signal and wait IOCTLs in the
> > kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
> >
> > Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.co=
m>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  4 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++++
> >   2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 70cb3b794a8a..04eb6611d19b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2971,9 +2971,11 @@ static int __init amdgpu_init(void)
> >       if (r)
> >               goto error_sync;
> >
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >       r =3D amdgpu_fence_slab_init();
> >       if (r)
> >               goto error_fence;
> > +#endif
>
> That here makes no sense. This is for the kernel queues and not for the
> user queues.
>
> >
> >       r =3D amdgpu_userq_fence_slab_init();
> >       if (r)
> > @@ -3003,7 +3005,9 @@ static void __exit amdgpu_exit(void)
> >       amdgpu_unregister_atpx_handler();
> >       amdgpu_acpi_release();
> >       amdgpu_sync_fini();
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >       amdgpu_fence_slab_fini();
> > +#endif
> >       amdgpu_userq_fence_slab_fini();
> >       mmu_notifier_synchronize();
> >       amdgpu_xcp_drv_release();
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index 279dece6f6d7..bec53776fe5f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -318,6 +318,7 @@ static const struct dma_fence_ops amdgpu_userq_fenc=
e_ops =3D {
> >       .release =3D amdgpu_userq_fence_release,
> >   };
> >
>
>
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   /**
> >    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
> >    *
> > @@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *d=
ev, void *data,
> >
> >       return r;
> >   }
> > +#else
> > +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> > +                           struct drm_file *filp)
> > +{
> > +     return 0;
> > +}
> > +#endif
> >
> > +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> >                           struct drm_file *filp)
> >   {
> > @@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev=
, void *data,
> >
> >       return r;
> >   }
> > +#else
> > +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> > +                         struct drm_file *filp)
> > +{
> > +     return 0;
> > +}
> > +#endif
>
> Not nice, but since CONFIG_DRM_AMDGPU_NAVI3X_USERQ depends on
> CONFIG_BROKEN at the moment probably ok as intermediate step.

Wouldn't it be better to return an error in these cases?

Alex

>
> Regards,
> Christian.
>
