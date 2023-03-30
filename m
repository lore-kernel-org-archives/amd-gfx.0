Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EC9C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE2F10EEBB;
	Thu, 30 Mar 2023 15:05:08 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6C110EEBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:05:07 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-177ca271cb8so20037747fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680188707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX//AT2YBUNFSajYFSRo4fBlSbAQyodnsp0K1s0YLls=;
 b=cMMTM3PIXdUXU88cxEAWeH5j08iBZRBn6690cxH6on8PxMrHhqz6j1gr9aE4S7WetW
 7n+NjqJTaONKKFSqF9AsnNQN2woXSC+lNkw9QtP4mKUjo2A8lr9gks3V0+WrcL92oO/D
 5rzhulco0giWkScYtmfKxsE92Uu2yWXgrvKaw5BZzMaM6X5PK+3iax6erhkfYrzndBcf
 26Vdre4/iQ62debrcvjKIAGo4O4gvuaws5aND+3PouwK3bauqX3x6jiZzn2HMf0QG7xL
 guDwC4155hpN4X1fVXCkx8JpHNyVP1Tu3BvlXiDZ1oq5+F9IFtnSbC5qNQlMG7/D85+l
 OWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680188707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX//AT2YBUNFSajYFSRo4fBlSbAQyodnsp0K1s0YLls=;
 b=xkLhu3y0BRiQXr/pFI/n6eV5whRH1yzyn0HFdx+FyAjwqUYGejE2TTzWxCFvr03XW1
 VIocOX5ak++L/LHBJggI6iDgkQvNDiIlmfoZ+GpfLD7XFDAAUpqWXjuulAniNRYkfDDm
 1XZO+4V3O7ZrAHusGYKqMyrFK+gdiluKbYUdWWDq3eu3VAzY8vOJM6lwXk5+NLmMr9vT
 eh4oxJe1w38uTUwNA6P4gLKkt7cY0/DZYJrFVlXI56UvuDbVqValDaj0J/p2BX8+5jAA
 wMwodQSFGaHJKLA/HOTKA20oupBqgtiz1VHR0zSDHWq682ZByXEPaoECEAsKkKRAc8ro
 ueSA==
X-Gm-Message-State: AAQBX9c/PybL/3iGAOH+XUSi9F+6s51SEFnCEJRW4wtu20dO0mCbdc2Y
 2faaROz9qALWRhNTZgyqXSIL3D/BZ+vOXg0eow4IN6M6Ado=
X-Google-Smtp-Source: AK7set9Lc1hIAhxWNrwEgRXWNhHqKSpIzOqXbC5WVtpR9mr7ZgFx0QtQGLXhgBQC80+bXeoCIEiRTIkFFEUKFc804ps=
X-Received: by 2002:a05:6870:1151:b0:17e:d308:776d with SMTP id
 17-20020a056870115100b0017ed308776dmr8028405oag.3.1680188706649; Thu, 30 Mar
 2023 08:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
 <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
 <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
 <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
In-Reply-To: <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 11:04:55 -0400
Message-ID: <CADnq5_MQzdeoNb+-DF=m=c-ZxNH+Zy79DATprWb32odN12anfQ@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 10:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
>
> On 30/03/2023 16:42, Christian K=C3=B6nig wrote:
> > Am 30.03.23 um 16:39 schrieb Alex Deucher:
> >> On Thu, Mar 30, 2023 at 7:49=E2=80=AFAM Shashank Sharma
> >> <shashank.sharma@amd.com> wrote:
> >>>
> >>> On 30/03/2023 13:30, Christian K=C3=B6nig wrote:
> >>>>
> >>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> >>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>>>>
> >>>>> This patch:
> >>>>> - creates a doorbell page for graphics driver usages.
> >>>>> - removes the adev->doorbell.ptr variable, replaces it with
> >>>>>     kernel-doorbell-bo's cpu address.
> >>>>>
> >>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
> >>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44
> >>>>> +++++++++++++++----
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
> >>>>>    3 files changed, 57 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>> index 6581b78fe438..10a9bb10e974 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
> >>>>>        /* doorbell mmio */
> >>>>>        resource_size_t        base;
> >>>>>        resource_size_t        size;
> >>>>> -    u32 __iomem        *ptr;
> >>>>> +    u32    __iomem        *ptr;
> >>>> This one can probably go away if we use the pointer from
> >>>> amdgpu_bo_create_kernel().
> >>> We started like that, but later realized that the cpu_addr from
> >>> create_kernel() will just limit us
> >>>
> >>> to that object only, whereas we are keeping this ptr to ioremap the
> >>> whole doorbell space in one shot.
> >> Why do we need that?  For the kernel driver, we'd only need to mmap
> >> the page used for kernel doorbells.  Then each user app would mmap its
> >> doorbell page.
> >
> > Yes, that is exactly my concern as well.
> >
> > The kernel needs a fixed number of doorbells allocated for its
> > internal use. Everything else should probably use the normal BO API.
> >
> > For KFD we can use the BO API internal in the kernel, but that is
> > certainly completely different to the kernel allocations.
> >
> There are 3 different kernel doorbell clients here:
>
> - graphics driver
>
> - mes (for aggregated doorbells and kernel ring test)
>
> - kfd (for kernel ring test and KIQ)
>
>
> The fix num_doorbells are just for kernel graphics driver, but We are
> allocating doorbell pages for each of those, and they all need to be
> mapped.
>
> Please see patch 12-16 for these details.

To me, it's clearer that resources managed by ttm are consistently
dealt with.  Regardless of whether we are talking about VRAM or OA or
GDS or GTT or doorbells.  When the kernel driver needs a page of vram
resources, it calls amdgpu_bo_create_kernel(), then if it needs a CPU
mmap, it calls amdgpu_bo_kmp().  Doorbells should be the same.  In
this case, the KGD would call amdgpu_bo_create_kernel(...DOORBELL..),
then create a mmap with amdgpu_bo_kmap() and then use that pointer for
its use.  KFD would do the same.  User mode doorbell allocations would
be consistent as well.

Alex


>
> - Shashank
>
> > Christian.
> >
> >>
> >> Alex
> >>
> >>> - Shashank
> >>>
> >>>>>          /* Number of doorbells reserved for amdgpu kernel driver *=
/
> >>>>>        u32 num_kernel_doorbells;
> >>>>> +
> >>>>> +    /* For kernel doorbell pages */
> >>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
> >>>>>    };
> >>>>>      /* Reserved doorbells for amdgpu (including multimedia).
> >>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
> >>>>> amdgpu_device *adev,
> >>>>>    int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>>>>                    struct amdgpu_doorbell_obj *db_obj);
> >>>>>    +/**
> >>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbel=
ls
> >>>>> for graphics
> >>>>> + *
> >>>>> + * @adev: amdgpu_device pointer
> >>>>> + *
> >>>>> + * Creates doorbells for graphics driver
> >>>>> + *
> >>>>> + * returns 0 on success, error otherwise.
> >>>>> + */
> >>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
> >>>>> *adev);
> >>>>> +
> >>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
> >>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev,
> >>>>> (index), (v))
> >>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>> index 8be15b82b545..b46fe8b1378d 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
> >>>>> amdgpu_device *adev,
> >>>>>        return 0;
> >>>>>    }
> >>>>>    +/**
> >>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbel=
ls
> >>>>> for graphics
> >>>>> + *
> >>>>> + * @adev: amdgpu_device pointer
> >>>>> + *
> >>>>> + * Creates doorbells for graphics driver
> >>>>> + *
> >>>>> + * returns 0 on success, error otherwise.
> >>>>> + */
> >>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
> >>>>> *adev)
> >>>>> +{
> >>>>> +    int r;
> >>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =3D
> >>>>> &adev->doorbell.kernel_doorbells;
> >>>>> +
> >>>>> +    kernel_doorbells->doorbell_bitmap =3D
> >>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
> >>>>> +                              GFP_KERNEL);
> >>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
> >>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
> >>>>> +        return -ENOMEM;
> >>>>> +    }
> >>>>> +
> >>>>> +    kernel_doorbells->size =3D adev->doorbell.num_kernel_doorbells=
 *
> >>>>> sizeof(u32);
> >>>>> +    r =3D amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
> >>>>> +    if (r) {
> >>>>> + bitmap_free(kernel_doorbells->doorbell_bitmap);
> >>>>> +        DRM_ERROR("Failed to allocate kernel doorbells,
> >>>>> err=3D%d\n", r);
> >>>>> +        return r;
> >>>>> +    }
> >>>>> +
> >>>>> +    return 0;
> >>>>> +}
> >>>>> +
> >>>>>    /*
> >>>>>     * GPU doorbell aperture helpers function.
> >>>>>     */
> >>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
> >>>>> amdgpu_device *adev)
> >>>>>            adev->doorbell.base =3D 0;
> >>>>>            adev->doorbell.size =3D 0;
> >>>>>            adev->doorbell.num_kernel_doorbells =3D 0;
> >>>>> -        adev->doorbell.ptr =3D NULL;
> >>>>>            return 0;
> >>>>>        }
> >>>>>    @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
> >>>>> amdgpu_device *adev)
> >>>>>        if (adev->asic_type >=3D CHIP_VEGA10)
> >>>>>            adev->doorbell.num_kernel_doorbells +=3D 0x400;
> >>>>>    -    adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> >>>>> - adev->doorbell.num_kernel_doorbells *
> >>>>> -                     sizeof(u32));
> >>>>> -    if (adev->doorbell.ptr =3D=3D NULL)
> >>>>> -        return -ENOMEM;
> >>>>> -
> >>>>> +    adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> >>>>> adev->doorbell.size);
> >>>>>        return 0;
> >>>>>    }
> >>>>>    @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
> >>>>> amdgpu_device *adev)
> >>>>>     */
> >>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
> >>>>>    {
> >>>>> -    iounmap(adev->doorbell.ptr);
> >>>>> -    adev->doorbell.ptr =3D NULL;
> >>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
> >>>>> +    amdgpu_doorbell_free_page(adev,
> >>>>> &adev->doorbell.kernel_doorbells);
> >>>>>    }
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> index 203d77a20507..75c6852845c4 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device
> >>>>> *adev)
> >>>>>            return r;
> >>>>>        }
> >>>>>    +    /* Create a boorbell page for kernel usages */
> >>>>> +    r =3D amdgpu_doorbell_create_kernel_doorbells(adev);
> >>>>> +    if (r) {
> >>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
> >>>>> +        return r;
> >>>>> +    }
> >>>>> +
> >>>>>        /* Initialize preemptible memory pool */
> >>>>>        r =3D amdgpu_preempt_mgr_init(adev);
> >>>>>        if (r) {
> >
