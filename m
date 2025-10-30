Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCFCCCF9FC
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 12:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B8B10E03E;
	Thu, 30 Oct 2025 12:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G+Swy1dn";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8689B10E03E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 12:41:52 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-290a38a2fe4so1188235ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761828112; x=1762432912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnD2hPut2RxWkT56ObbUqEiUjmkTq+1r3lzPWgfvr2g=;
 b=G+Swy1dnXMLwC1y/tEBQsZA1WFzVZPrG5RXonjLlBR6xyg78TItN4bRG0tMaJpNTKK
 PLcHe17Ufa3gmlsT7MjJpaxhXEKHmnTpBhPOOHw1hpCiaOwBYKPKVmhSM78rtyS9CLBH
 kCbzNcoMoxpSaGSgny/vRnlGbh/k3wpOZzOVGK9rshaDa6/jnIRmzlnz1F/hRuMKWasw
 RW63Nps4/gYW4gZSa+ElANEDVNsntcEtonworMru6DvqeQLcu+GSjq7UBArYsbdZLXHX
 FnOKVCqr3glrrZp6W8kemE9h3/bJkUhhkvh2kfkkdjvSZY2lfrbzMN9qJWrCnwXVKk0+
 RhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761828112; x=1762432912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnD2hPut2RxWkT56ObbUqEiUjmkTq+1r3lzPWgfvr2g=;
 b=WvHLN2ti6xgn6a/YeDI3ilZ3N8zkxvlsiipQZoaOY6Xj90xrk/YaklEur+WEBVXtEF
 XCQy4cwPz+dqdjs20LI7lXZx/y6tZEre2PLBk75l3Fyv035Rac3VBECUFhELbVtnjUY+
 W8srzrqsl7d9D9uJttX2zzsgd3WNYbptl8vfXA2Jfq/cqI61x042hNSmgr63bVy4sdIs
 tkYRLluJiUH5EyDpSyAVSYJXBaF+Y7l7str6E6n792rcgvJmefoos5bO9p91Ynz2WyHT
 R/t5nwYNU6Qijj56E8x+0e9I801qqJ10m6oc0PgYKQx4UIFqShlOd8bcMO3RCaDgDKeh
 fhDA==
X-Gm-Message-State: AOJu0YykyrFuXf96yOUelfxjcwupDtrHxHZXLTnFfgHC4oaUfDuS0mSb
 UKmhYcucOP2gmi/PixFIHL+ATbTPuWPaykIRm4uvz0vnrcI9ZMx1gA2m90SmrHvY76QwU+UtXqw
 XanQ8Y66z/h39qwHBT4rgFpDQSvanZWVA3w==
X-Gm-Gg: ASbGnct2SBgMcP91+ID9/fQDTWLk/YSuTb4pNrmUayMVj6NQRvJgU1Oghu549D0RJ1G
 q+f+DKOn2/GDXgWBUKNnGiELW5M4czIBXTdyMht9qbU6q8Wmu9LrVSSiVVVwYd54KVQ+Qso4zhU
 xeox5KzJazRoEQQi9cHfheiZ7+hvvkX3CCUl8G8Jv9ydEkqvvAQg2k9w3UStAncDxD18XTJC5af
 RdY7D/ozqW5NKgYg5cZHiFJcX2wSbzczKGv7cjU66TNLRJpPsZUj9HOq6BS
X-Google-Smtp-Source: AGHT+IGIU+0Nx7XQrhbQeR/sc6puSP9MsOXCA7zX7Dzb1NGtpLuDbJDTKbCasbo/EYa3Dbsmgdi/QBlWF3ZSl/b4c6g=
X-Received: by 2002:a17:903:38c8:b0:294:fc63:58da with SMTP id
 d9443c01a7336-294fc635be3mr13750085ad.11.1761828111831; Thu, 30 Oct 2025
 05:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
 <20251024094445.3090110-2-Jesse.Zhang@amd.com>
 <CADnq5_PMvfkcTcK9EKTc5PwLO3GEJKxOU2rL02CC6LiPKM51OQ@mail.gmail.com>
 <DM4PR12MB515221D2A7B556DE97EDC6E5E3FBA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515221D2A7B556DE97EDC6E5E3FBA@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 08:41:39 -0400
X-Gm-Features: AWmQ_blacZeqxpwKkY1vaQYGRUBYWgNCNe3mVMhN6OmB8YRk7IkISAtwsh1vrTU
Message-ID: <CADnq5_Mb+Fi7vB14QEym66sEKGCckZtbHahWb64eOTKcFoyFug@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Add user queue reset mask support
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
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

On Wed, Oct 29, 2025 at 10:08=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, October 30, 2025 2:14 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
> > Subject: Re: [PATCH 2/3] drm/amdgpu: Add user queue reset mask support
> >
> > On Fri, Oct 24, 2025 at 5:45=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.co=
m> wrote:
> > >
> > > This commit adds support for tracking and exposing the reset
> > > capabilities of user mode queues across different IP blocks (GFX, Com=
pute,
> > SDMA).
> > >
> > > These changes allow userspace to query the reset capabilities of user
> > > mode queues and ensure reset operations are only attempted when
> > > supported by the hardware and driver.
> > >
> > > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 44
> > ++++++++++++++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 +++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 13 +++++++
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 17 +++++++++
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 12 ++++++
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 34 ++++++++++-------
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     | 24 ++++++++----
> > >  9 files changed, 163 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index d0fb4eb1d7c4..48b21863065e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -1182,6 +1182,7 @@ struct amdgpu_device {
> > >          * Value: struct amdgpu_usermode_queue
> > >          */
> > >         struct xarray userq_doorbell_xa;
> > > +       u32 userq_supported_reset[AMDGPU_RING_TYPE_MAX];
> >
> > I don't think we need a separate userq_supported_reset array.  Just use=
 the existing
> > reset masks.  We use the same functionality in both kernel and userq ca=
ses so I
> > don't see a reason to have a separate tracker.
> [Zhang, Jesse(Jie)] Thanks Alex for reviewing.
> I have another question regarding the user queue reset mask sysfs.
> Should we also share the sysfs with the kernel reset mask, right? Or  set=
 a separate mask for userq_mask_reset?
> For example:
> /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00=
.0/sdma_reset_mask
> /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00=
.0/sdma_userq_reset_mask

I think a single one is fine unless you can think of a case where they
would be different.

Alex

>
> Thanks
> Jesse
>
> >
> > Alex
> >
> > >
> > >         /* df */
> > >         struct amdgpu_df                df;
> > > @@ -1612,6 +1613,8 @@ struct dma_fence
> > *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
> > >                                                   struct amdgpu_ring =
*ring,
> > >                                                   struct amdgpu_job
> > > *job);  bool amdgpu_device_has_display_hardware(struct amdgpu_device
> > > *adev);
> > > +ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev,
> > > +                                   int ring_type);
> > >  ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> > > ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 8480b72258f2..a0064c5314df 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -7649,7 +7649,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct
> > amdgpu_ring *ring)
> > >         if (!ring || !ring->adev)
> > >                 return size;
> > >
> > > -       if (amdgpu_device_should_recover_gpu(ring->adev))
> > > +       if (amdgpu_device_should_recover_gpu(ring->adev) &&
> > > +           unlikely(!ring->adev->debug_disable_gpu_ring_reset))
> > >                 size |=3D AMDGPU_RESET_TYPE_FULL;
> > >
> > >         if (unlikely(!ring->adev->debug_disable_soft_recovery) && @@
> > > -7659,6 +7660,20 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct
> > amdgpu_ring *ring)
> > >         return size;
> > >  }
> > >
> > > +ssize_t amdgpu_userq_get_full_reset_mask(struct amdgpu_device *adev,
> > > +int ring_type) {
> > > +       ssize_t size =3D 0;
> > > +
> > > +       if (!adev || !adev->userq_funcs[ring_type])
> > > +               return size;
> > > +
> > > +       if (amdgpu_device_should_recover_gpu(adev) &&
> > > +           unlikely(!adev->debug_disable_gpu_ring_reset))
> > > +               size |=3D AMDGPU_RESET_TYPE_FULL;
> > > +
> > > +       return size;
> > > +}
> > > +
> > >  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
> > > {
> > >         ssize_t size =3D 0;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > index 3d24f9cd750a..5597753ec61a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > @@ -1826,6 +1826,32 @@ static ssize_t
> > amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> > >         return amdgpu_show_reset_mask(buf,
> > > adev->gfx.compute_supported_reset);
> > >  }
> > >
> > > +static ssize_t amdgpu_userq_get_gfx_reset_mask(struct device *dev,
> > > +                                               struct device_attribu=
te *attr,
> > > +                                               char *buf) {
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > > +
> > > +       if (!adev)
> > > +               return -ENODEV;
> > > +
> > > +       return amdgpu_show_reset_mask(buf,
> > > +adev->userq_supported_reset[AMDGPU_HW_IP_GFX]);
> > > +}
> > > +
> > > +static ssize_t amdgpu_userq_get_compute_reset_mask(struct device *de=
v,
> > > +                                               struct device_attribu=
te *attr,
> > > +                                               char *buf) {
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > > +
> > > +       if (!adev)
> > > +               return -ENODEV;
> > > +
> > > +       return amdgpu_show_reset_mask(buf,
> > > +adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE]);
> > > +}
> > > +
> > >  static DEVICE_ATTR(run_cleaner_shader, 0200,
> > >                    NULL, amdgpu_gfx_set_run_cleaner_shader);
> > >
> > > @@ -1845,6 +1871,12 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
> > > static DEVICE_ATTR(compute_reset_mask, 0444,
> > >                    amdgpu_gfx_get_compute_reset_mask, NULL);
> > >
> > > +static DEVICE_ATTR(gfx_userq_reset_mask, 0444,
> > > +                  amdgpu_userq_get_gfx_reset_mask, NULL);
> > > +
> > > +static DEVICE_ATTR(compute_userq_reset_mask, 0444,
> > > +                  amdgpu_userq_get_compute_reset_mask, NULL);
> > > +
> > >  static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)  {
> > >         struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr; @@ -1928,6
> > > +1960,18 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct
> > amdgpu_device *adev)
> > >                         return r;
> > >         }
> > >
> > > +       if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
> > > +               r =3D device_create_file(adev->dev, &dev_attr_gfx_use=
rq_reset_mask);
> > > +               if (r)
> > > +                       return r;
> > > +       }
> > > +
> > > +       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
> > > +               r =3D device_create_file(adev->dev,
> > &dev_attr_compute_userq_reset_mask);
> > > +               if (r)
> > > +                       return r;
> > > +       }
> > > +
> > >         return r;
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > index 8b8a04138711..2fb288b2bfc4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > @@ -471,6 +471,21 @@ static ssize_t amdgpu_get_sdma_reset_mask(struct
> > > device *dev,  static DEVICE_ATTR(sdma_reset_mask, 0444,
> > >                    amdgpu_get_sdma_reset_mask, NULL);
> > >
> > > +static ssize_t amdgpu_get_sdma_userq_reset_mask(struct device *dev,
> > > +                                               struct device_attribu=
te *attr,
> > > +                                               char *buf) {
> > > +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> > > +       struct amdgpu_device *adev =3D drm_to_adev(ddev);
> > > +
> > > +       if (!adev)
> > > +               return -ENODEV;
> > > +
> > > +       return amdgpu_show_reset_mask(buf,
> > > +adev->userq_supported_reset[AMDGPU_HW_IP_DMA]);
> > > +}
> > > +static DEVICE_ATTR(sdma_userq_reset_mask, 0444,
> > > +                  amdgpu_get_sdma_userq_reset_mask, NULL);
> > > +
> > >  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)  {
> > >         int r =3D 0;
> > > @@ -484,6 +499,12 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct
> > amdgpu_device *adev)
> > >                         return r;
> > >         }
> > >
> > > +       if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
> > > +               r =3D device_create_file(adev->dev,
> > &dev_attr_sdma_userq_reset_mask);
> > > +               if (r)
> > > +                       return r;
> > > +       }
> > > +
> > >         return r;
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > index 188de848c229..15ae72e2d679 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > > @@ -47,6 +47,16 @@ u32 amdgpu_userq_get_supported_ip_mask(struct
> > amdgpu_device *adev)
> > >         return userq_ip_mask;
> > >  }
> > >
> > > +bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev=
,
> > > +                                         int ring_type,
> > > +                                         int reset_type) {
> > > +    if (ring_type < 0 || ring_type >=3D AMDGPU_RING_TYPE_MAX)
> > > +        return false;
> > > +
> > > +    return (adev->userq_supported_reset[ring_type] & reset_type) !=
=3D
> > > +0; }
> > > +
> > >  static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)  {
> > >         if (amdgpu_device_should_recover_gpu(adev)) { @@ -94,6 +104,9
> > > @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr
> > *uq_mgr)
> > >                 int ring_type =3D queue_types[i];
> > >                 const struct amdgpu_userq_funcs *funcs =3D
> > > adev->userq_funcs[ring_type];
> > >
> > > +               if (!amdgpu_userq_is_reset_type_supported(adev, ring_=
type,
> > AMDGPU_RESET_TYPE_PER_QUEUE))
> > > +                               continue;
> > > +
> > >                 if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 =
&&
> > >                     funcs && funcs->detect_and_reset) {
> > >                         r =3D funcs->detect_and_reset(adev, ring_type=
);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > index 252517ce5d5a..82b7c365d720 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > @@ -1815,6 +1815,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_=
block
> > *ip_block)
> > >                 amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0=
]);
> > >         adev->gfx.compute_supported_reset =3D
> > >
> > > amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =3D
> > > +                       amdgpu_userq_get_full_reset_mask(adev,
> > AMDGPU_HW_IP_GFX);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =3D
> > > +
> > > + amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_IP_COMPUTE);
> > > +
> > >         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > >         case IP_VERSION(11, 0, 0):
> > >         case IP_VERSION(11, 0, 2):
> > > @@ -1824,12 +1829,24 @@ static int gfx_v11_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> > >                     !amdgpu_sriov_vf(adev)) {
> > >                         adev->gfx.compute_supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > >                         adev->gfx.gfx_supported_reset |=3D
> > > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]-
> > >detect_and_reset)
> > > +                               adev->userq_supported_reset[AMDGPU_HW=
_IP_GFX] |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &=
&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]-
> > >detect_and_reset)
> > > +
> > > + adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |=3D
> > > + AMDGPU_RESET_TYPE_PER_QUEUE;
> > >                 }
> > >                 break;
> > >         default:
> > >                 if (!amdgpu_sriov_vf(adev)) {
> > >                         adev->gfx.compute_supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > >                         adev->gfx.gfx_supported_reset |=3D
> > > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]-
> > >detect_and_reset)
> > > +                               adev->userq_supported_reset[AMDGPU_HW=
_IP_GFX] |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &=
&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]-
> > >detect_and_reset)
> > > +
> > > + adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |=3D
> > > + AMDGPU_RESET_TYPE_PER_QUEUE;
> > >                 }
> > >                 break;
> > >         }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > index 35d5a7e99a7c..c5ac42a30789 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > @@ -1543,6 +1543,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_=
block
> > *ip_block)
> > >                 amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0=
]);
> > >         adev->gfx.compute_supported_reset =3D
> > >
> > > amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_GFX] =3D
> > > +               amdgpu_userq_get_full_reset_mask(adev, AMDGPU_HW_IP_G=
FX);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] =3D
> > > +
> > > + amdgpu_userq_get_full_reset_mask(adev,AMDGPU_HW_IP_COMPUTE);
> > > +
> > >         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> > >         case IP_VERSION(12, 0, 0):
> > >         case IP_VERSION(12, 0, 1):
> > > @@ -1551,6 +1556,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_=
block
> > *ip_block)
> > >                     !amdgpu_sriov_vf(adev)) {
> > >                         adev->gfx.compute_supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > >                         adev->gfx.gfx_supported_reset |=3D
> > > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_GFX] &&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_GFX]-
> > >detect_and_reset)
> > > +                               adev->userq_supported_reset[AMDGPU_HW=
_IP_GFX] |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] &=
&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]-
> > >detect_and_reset)
> > > +
> > > + adev->userq_supported_reset[AMDGPU_HW_IP_COMPUTE] |=3D
> > > + AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +
> > >                 }
> > >                 break;
> > >         default:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > index db6e41967f12..8850eaf8d2c4 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > > @@ -1349,19 +1349,6 @@ static int sdma_v6_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> > >                         return r;
> > >         }
> > >
> > > -       adev->sdma.supported_reset =3D
> > > -               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[=
0].ring);
> > > -       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> > > -       case IP_VERSION(6, 0, 0):
> > > -       case IP_VERSION(6, 0, 2):
> > > -       case IP_VERSION(6, 0, 3):
> > > -               if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> > > -                   !amdgpu_sriov_vf(adev))
> > > -                       adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > -               break;
> > > -       default:
> > > -               break;
> > > -       }
> > >
> > >         if (amdgpu_sdma_ras_sw_init(adev)) {
> > >                 dev_err(adev->dev, "Failed to initialize sdma ras
> > > block!\n"); @@ -1412,6 +1399,27 @@ static int sdma_v6_0_sw_init(struc=
t
> > amdgpu_ip_block *ip_block)
> > >                 break;
> > >         }
> > >
> > > +       adev->sdma.supported_reset =3D
> > > +               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[=
0].ring);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =3D
> > > +               amdgpu_userq_get_full_reset_mask(adev,
> > > + AMDGPU_HW_IP_DMA);
> > > +
> > > +       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> > > +       case IP_VERSION(6, 0, 0):
> > > +       case IP_VERSION(6, 0, 2):
> > > +       case IP_VERSION(6, 0, 3):
> > > +               if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> > > +                   !amdgpu_sriov_vf(adev)) {
> > > +                       adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +                       if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
> > > +                           adev->userq_funcs[AMDGPU_HW_IP_DMA]-
> > >detect_and_reset)
> > > +
> > > + adev->userq_supported_reset[AMDGPU_HW_IP_DMA] |=3D
> > > + AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +
> > > +               }
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > >         r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> > >         if (r)
> > >                 return r;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > > index 326ecc8d37d2..9de46ac8b1db 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > > @@ -1335,14 +1335,6 @@ static int sdma_v7_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> > >                         return r;
> > >         }
> > >
> > > -       adev->sdma.supported_reset =3D
> > > -               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[=
0].ring);
> > > -       if (!amdgpu_sriov_vf(adev))
> > > -               adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > -
> > > -       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> > > -       if (r)
> > > -               return r;
> > >         /* Allocate memory for SDMA IP Dump buffer */
> > >         ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(=
uint32_t),
> > GFP_KERNEL);
> > >         if (ptr)
> > > @@ -1360,6 +1352,22 @@ static int sdma_v7_0_sw_init(struct
> > amdgpu_ip_block *ip_block)
> > >                 break;
> > >         }
> > >
> > > +       adev->sdma.supported_reset =3D
> > > +               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[=
0].ring);
> > > +       adev->userq_supported_reset[AMDGPU_HW_IP_DMA] =3D
> > > +               amdgpu_userq_get_full_reset_mask(adev,
> > > + AMDGPU_HW_IP_DMA);
> > > +
> > > +       if (!amdgpu_sriov_vf(adev)) {
> > > +               adev->sdma.supported_reset |=3D
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA] &&
> > > +                   adev->userq_funcs[AMDGPU_HW_IP_DMA]->detect_and_r=
eset)
> > > +                       adev->userq_supported_reset[AMDGPU_HW_IP_DMA]
> > > + |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> > > +
> > > +       }
> > > +       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> > > +       if (r)
> > > +               return r;
> > > +
> > >         return r;
> > >  }
> > >
> > > --
> > > 2.49.0
> > >
