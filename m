Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C43FC761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C44010EEB3;
	Thu, 30 Mar 2023 14:55:28 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6B410EEB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:55:26 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 n3-20020a4ad403000000b0053351dadc20so2999795oos.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680188125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7ZXQW6/lKv/iXDJwqD42xeCtVWKHmBf07IWqrZy0Y0=;
 b=mFWHLlhPR4GhRDUSqvOie58NXpIpe87BC73rwTAJ2qVg7e0qRlrXyL5W+ck0j15xSH
 5wpk1PNsYV5Ai5bHuPAYtLOPaUfJB1cvHv1juIGSK/PNyyIjHehhuWkIwqY+PMX+xSHD
 5rxO67dbU1SEzQaBUiNm/B+N1UC4cvSs2eh+/G8WqXD2N+Wy8LJKr1vb+2nYwXXf1Yup
 lktFiqTyULft0EcFQ29oxLWdQ4HrDeZt5iYkD+v9SFyuQHp7B3KxjgbQqQ23tJ8EwhEn
 HwdNUsEczbQHMcjGpv3GG5StAaZ5iPPAAT0hj0bcZPTh1OnUzUTv6fSa6U9VbBT3k1iR
 yc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680188125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7ZXQW6/lKv/iXDJwqD42xeCtVWKHmBf07IWqrZy0Y0=;
 b=63qHcqizuMDy9rFliyMwRofde04yXfihb1K3gM9QoEo/B/kZZkOLLU3ztI2ehqkGF4
 2eH3p+tHLekKZtYlM1n/mSaesYzlB9oE/CSAQMTkkCkAVmPY1O5wyOKpKMtQ2yichQJj
 bBLqbLsuymsIKxE3urOnHvI0+NUqwrvtw4tIfgIlr5L0ij0LYJU3GqUHTpicS/htRyE0
 R5DI7+aju154wuiHr51rmD4q1B6OXU6BYm8iZK4Bm8CHyIdis1k1DdaOdaXZfxvH8U4g
 LcdYwGYJ7kPy4JD/hN8J8p9JRcOgZw/3I41icQ12egb+1/p79oJUhwx2EOoM+n3+hZRq
 51EA==
X-Gm-Message-State: AO0yUKXWUh/wyt2mtvnCLtyGyI/AcaKcHwT7gbsp8PSeMqdl6O47T9+A
 UN6pIFnIWw5quplGFV1SxokqF7D9lBEmnUYJBtk=
X-Google-Smtp-Source: AK7set8bXdNfeQK/3kfmtCUQMrdVBnygwPxIeqkrv3GpL5AR2otWI1mJHXKkuT41tXQ5zX0rpn8C6e5WLsPMfO5PtlU=
X-Received: by 2002:a4a:cb08:0:b0:53b:4eb9:205a with SMTP id
 r8-20020a4acb08000000b0053b4eb9205amr8251205ooq.0.1680188125601; Thu, 30 Mar
 2023 07:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
 <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
In-Reply-To: <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:55:14 -0400
Message-ID: <CADnq5_O_rJYcUXhf+tDaeog2cEZLvDnzz5d=AJ5pTHcWvyrdCA@mail.gmail.com>
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
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
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 10:34=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
>
> On 30/03/2023 16:15, Luben Tuikov wrote:
> > On 2023-03-30 10:04, Shashank Sharma wrote:
> >> On 30/03/2023 15:42, Luben Tuikov wrote:
> >>> On 2023-03-29 11:47, Shashank Sharma wrote:
> >>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>>>
> >>>> This patch adds helper functions to create and free doorbell
> >>>> pages for kernel objects.
> >>>>
> >>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++=
++
> >>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 ++++++++++++++=
+++++
> >>>>    2 files changed, 90 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>> index f9c3b77bf65d..6581b78fe438 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>> @@ -27,6 +27,24 @@
> >>>>    /*
> >>>>     * GPU doorbell structures, functions & helpers
> >>>>     */
> >>>> +
> >>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> >>>> +struct amdgpu_doorbell_obj {
> >>> In the comment you say "Structure to hold ...";
> >>> it is a C structure, but then in the name of a function we see "obj".
> >>> (Object is something which is defined like in memory, i.e. it exists,=
 not
> >>> something which is only declared.)
> >>> This is just a declaration of a structure, not an object per se.
> >>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_do=
orbell".
> >> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
> >> many more existing structure.
> > The amdpgu_bo is very different than a structure describing a doorbell.
> > The doorbell description isn't really "an object". I understand
> > the enthusiasm, but it is really not "an object". It's just a doorbell
> > description. :-)
>
> amdgpu_bo is page of ttm_memory with additional information,
>
> amdgpu_doorbell_obj is a page of ttm_doorbells with additional informatio=
n
>
> (it is not just one doorbell description)
>
> I don't see a problem here.

I find the new API confusing.  I would expect to see
amdgpu_bo_create_kernel(...DOORBELL...), amdgpu_bo_reserve(),
amdgpu_bo_kmap(), etc.  That makes it consistent with the other
resource pools that we manage in ttm.

Alex

>
> - Shashank
>
> >
> > Regards,
> > Luben
> >
> >> - Shashank
> >>
> >>> Then in the definition, you can call it an object/objects, if you'd l=
ike,
> >>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
> >>> "db =3D doorb_object[i]";
> >>>
> >>> Regards,
> >>> Luben
> >>>
> >>>> +  struct amdgpu_bo *bo;
> >>>> +  uint64_t gpu_addr;
> >>>> +  uint32_t *cpu_addr;
> >>>> +  uint32_t size;
> >>>> +
> >>>> +  /* First index in this object */
> >>>> +  uint32_t start;
> >>>> +
> >>>> +  /* Last index in this object */
> >>>> +  uint32_t end;
> >>>> +
> >>>> +  /* bitmap for dynamic doorbell allocation from this object */
> >>>> +  unsigned long *doorbell_bitmap;
> >>>> +};
> >>>> +
> >>>>    struct amdgpu_doorbell {
> >>>>            /* doorbell mmio */
> >>>>            resource_size_t         base;
> >>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_d=
evice *adev);
> >>>>     */
> >>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
> >>>>
> >>>> +/**
> >>>> + * amdgpu_doorbell_free_page - Free a doorbell page
> >>>> + *
> >>>> + * @adev: amdgpu_device pointer
> >>>> + *
> >>>> + * @db_age: previously allocated doobell page details
> >>>> + *
> >>>> + */
> >>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> >>>> +                          struct amdgpu_doorbell_obj *db_obj);
> >>>> +
> >>>> +/**
> >>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> >>>> + *
> >>>> + * @adev: amdgpu_device pointer
> >>>> + *
> >>>> + * @db_age: doobell page structure to fill details with
> >>>> + *
> >>>> + * returns 0 on success, else error number
> >>>> + */
> >>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>>> +                          struct amdgpu_doorbell_obj *db_obj);
> >>>> +
> >>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
> >>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), =
(v))
> >>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>> index 1aea92363fd3..8be15b82b545 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device=
 *adev, u32 index, u64 v)
> >>>>            }
> >>>>    }
> >>>>
> >>>> +/**
> >>>> + * amdgpu_doorbell_free_page - Free a doorbell page
> >>>> + *
> >>>> + * @adev: amdgpu_device pointer
> >>>> + *
> >>>> + * @db_age: previously allocated doobell page details
> >>>> + *
> >>>> + */
> >>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> >>>> +                                  struct amdgpu_doorbell_obj *db_ob=
j)
> >>>> +{
> >>>> +  amdgpu_bo_free_kernel(&db_obj->bo,
> >>>> +                        &db_obj->gpu_addr,
> >>>> +                        (void **)&db_obj->cpu_addr);
> >>>> +
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> >>>> + *
> >>>> + * @adev: amdgpu_device pointer
> >>>> + *
> >>>> + * @db_age: doobell page structure to fill details with
> >>>> + *
> >>>> + * returns 0 on success, else error number
> >>>> + */
> >>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>>> +                          struct amdgpu_doorbell_obj *db_obj)
> >>>> +{
> >>>> +  int r;
> >>>> +
> >>>> +  db_obj->size =3D ALIGN(db_obj->size, PAGE_SIZE);
> >>>> +
> >>>> +  r =3D amdgpu_bo_create_kernel(adev,
> >>>> +                              db_obj->size,
> >>>> +                              PAGE_SIZE,
> >>>> +                              AMDGPU_GEM_DOMAIN_DOORBELL,
> >>>> +                              &db_obj->bo,
> >>>> +                              &db_obj->gpu_addr,
> >>>> +                              (void **)&db_obj->cpu_addr);
> >>>> +
> >>>> +  if (r) {
> >>>> +          DRM_ERROR("Failed to create doorbell BO, err=3D%d\n", r);
> >>>> +          return r;
> >>>> +  }
> >>>> +
> >>>> +  return 0;
> >>>> +}
> >>>> +
> >>>>    /*
> >>>>     * GPU doorbell aperture helpers function.
> >>>>     */
