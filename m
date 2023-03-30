Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C45BC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA9210EE91;
	Thu, 30 Mar 2023 14:39:34 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E364410EE91
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:39:31 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 n3-20020a4ad403000000b0053351dadc20so2991065oos.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680187171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uyd0y8EvjFNEEqvBQpiMYnrK4yD7t9AKYtKadFZWIp8=;
 b=QJqxzLENdKHTAvxMPFcnGnB0CESVuB7DTzatj8xUBE+WHEWGtpH41+KSZpuMHzlOBQ
 I2W9XGcqXlqg+v2wr2bZHUhgUEDAOeYRLalyOnNLGJgl6YfF1wUFibvW4L2VtMMYNg78
 b2/qnre+ZBvOHVvro6cKEeysyjmmQpqJ6rErBv3DQdAJiAIJV6nmiany25yvsN8UpTn5
 EYybwupYG8d+KoTJowGZZ1Buex5ia9t9yWbVDAXIzYpPlcsc5Ll1EP5+cpq79ODSCYPC
 y7j8yRhlku5FsUvEG+qCWvxpN+w4z7M9iabtMj707q4UFbkacZCRnN/O9iEVBHMFABHZ
 41pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680187171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uyd0y8EvjFNEEqvBQpiMYnrK4yD7t9AKYtKadFZWIp8=;
 b=Ghq/A8XUlqGJF3PslUJfrz2MhCxaHyZnIdXAQ64hzceDfHNOF1c/rP6HCYKJq7IJzr
 VaVGvlBQMqlwP4V5zS06vFjrEdAyQ2efGKmNzlH+mKkku6vbl6ceBpePSgcxaMt941he
 7RZUc4bO6Zl8zKsERWOqIrOjAQ8KpN9KkLiqvo1NX0aQifM0QwDjJs99dFUsizgkb4TL
 J7fHhO2FkGXje93Uyy1y1Kj0ptWH5DUX6B4Nr9xGmsM3YmQ8E3R44Y2COqn8arEaaCWU
 UC6DPwunNC6Do4zUF2dmcWJ+nfGsGuDp41rrjjI4QwwvjByJyvJ9kEIS2jVlLTUHR/cA
 BP8Q==
X-Gm-Message-State: AO0yUKW+7cMVvL5kuGy1/wX6su1b2yFLB/HXxHebw2/e4/bYeZo0tuv+
 ZfaJaR3w2scLKTZI/1rOsZxVXEsNbG6PUP1Qtko=
X-Google-Smtp-Source: AK7set/bgDLHd+aczb5UctzPv0EeYeDM0JJCH7ky7pN/3Rum8ml6D7YFy1RfxiDsRFxTy+zy/SAhwKA8D/hkNUz21pM=
X-Received: by 2002:a4a:a687:0:b0:539:7cb5:7a0e with SMTP id
 f7-20020a4aa687000000b005397cb57a0emr8390552oom.0.1680187171096; Thu, 30 Mar
 2023 07:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
In-Reply-To: <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:39:20 -0400
Message-ID: <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 7:49=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
>
> On 30/03/2023 13:30, Christian K=C3=B6nig wrote:
> >
> >
> > Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> >> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>
> >> This patch:
> >> - creates a doorbell page for graphics driver usages.
> >> - removes the adev->doorbell.ptr variable, replaces it with
> >>    kernel-doorbell-bo's cpu address.
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
> >>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++--=
--
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
> >>   3 files changed, 57 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >> index 6581b78fe438..10a9bb10e974 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
> >>       /* doorbell mmio */
> >>       resource_size_t        base;
> >>       resource_size_t        size;
> >> -    u32 __iomem        *ptr;
> >> +    u32    __iomem        *ptr;
> >
> > This one can probably go away if we use the pointer from
> > amdgpu_bo_create_kernel().
>
> We started like that, but later realized that the cpu_addr from
> create_kernel() will just limit us
>
> to that object only, whereas we are keeping this ptr to ioremap the
> whole doorbell space in one shot.

Why do we need that?  For the kernel driver, we'd only need to mmap
the page used for kernel doorbells.  Then each user app would mmap its
doorbell page.

Alex

>
> - Shashank
>
> >
> >>         /* Number of doorbells reserved for amdgpu kernel driver */
> >>       u32 num_kernel_doorbells;
> >> +
> >> +    /* For kernel doorbell pages */
> >> +    struct amdgpu_doorbell_obj kernel_doorbells;
> >>   };
> >>     /* Reserved doorbells for amdgpu (including multimedia).
> >> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
> >> amdgpu_device *adev,
> >>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>                   struct amdgpu_doorbell_obj *db_obj);
> >>   +/**
> >> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
> >> for graphics
> >> + *
> >> + * @adev: amdgpu_device pointer
> >> + *
> >> + * Creates doorbells for graphics driver
> >> + *
> >> + * returns 0 on success, error otherwise.
> >> + */
> >> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
> >> *adev);
> >> +
> >>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
> >>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v)=
)
> >>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >> index 8be15b82b545..b46fe8b1378d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
> >> amdgpu_device *adev,
> >>       return 0;
> >>   }
> >>   +/**
> >> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
> >> for graphics
> >> + *
> >> + * @adev: amdgpu_device pointer
> >> + *
> >> + * Creates doorbells for graphics driver
> >> + *
> >> + * returns 0 on success, error otherwise.
> >> + */
> >> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *ade=
v)
> >> +{
> >> +    int r;
> >> +    struct amdgpu_doorbell_obj *kernel_doorbells =3D
> >> &adev->doorbell.kernel_doorbells;
> >> +
> >> +    kernel_doorbells->doorbell_bitmap =3D
> >> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
> >> +                              GFP_KERNEL);
> >> +    if (!kernel_doorbells->doorbell_bitmap) {
> >> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
> >> +        return -ENOMEM;
> >> +    }
> >> +
> >> +    kernel_doorbells->size =3D adev->doorbell.num_kernel_doorbells *
> >> sizeof(u32);
> >> +    r =3D amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
> >> +    if (r) {
> >> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
> >> +        DRM_ERROR("Failed to allocate kernel doorbells, err=3D%d\n", =
r);
> >> +        return r;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   /*
> >>    * GPU doorbell aperture helpers function.
> >>    */
> >> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
> >> amdgpu_device *adev)
> >>           adev->doorbell.base =3D 0;
> >>           adev->doorbell.size =3D 0;
> >>           adev->doorbell.num_kernel_doorbells =3D 0;
> >> -        adev->doorbell.ptr =3D NULL;
> >>           return 0;
> >>       }
> >>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
> >> amdgpu_device *adev)
> >>       if (adev->asic_type >=3D CHIP_VEGA10)
> >>           adev->doorbell.num_kernel_doorbells +=3D 0x400;
> >>   -    adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> >> -                     adev->doorbell.num_kernel_doorbells *
> >> -                     sizeof(u32));
> >> -    if (adev->doorbell.ptr =3D=3D NULL)
> >> -        return -ENOMEM;
> >> -
> >> +    adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> >> adev->doorbell.size);
> >>       return 0;
> >>   }
> >>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
> >> amdgpu_device *adev)
> >>    */
> >>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> >>   {
> >> -    iounmap(adev->doorbell.ptr);
> >> -    adev->doorbell.ptr =3D NULL;
> >> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
> >> +    amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells)=
;
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> index 203d77a20507..75c6852845c4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >>           return r;
> >>       }
> >>   +    /* Create a boorbell page for kernel usages */
> >> +    r =3D amdgpu_doorbell_create_kernel_doorbells(adev);
> >> +    if (r) {
> >> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
> >> +        return r;
> >> +    }
> >> +
> >>       /* Initialize preemptible memory pool */
> >>       r =3D amdgpu_preempt_mgr_init(adev);
> >>       if (r) {
> >
