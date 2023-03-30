Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8AEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 20:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B814A10F035;
	Thu, 30 Mar 2023 20:35:14 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087610F035
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 20:35:13 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 k14-20020a9d700e000000b0069faa923e7eso10719332otj.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680208512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2C1ZnAlPlo34jg9l0tfW7skzlR1UTZP8nwuzsQP38S4=;
 b=bSqbNUrAmjMM2s84KXSOuQaxgJ2mWjZr5drWG/4Z4B0LKN+NQMiy/spKpZQCoZcUle
 GHKb70UU1A49pwIDvRXd+byuEuvlZ5hf76q/mFQx86FHWTeaCZ5DYmgpuoqmNLYLn/Vb
 nr/RJx2J5Zj2p+U6/+Fb+r8eNBK05oPiK3W12k4Z1XziCVgcNJz/WB8oCbEe6tGZdunw
 2C7TKhf5HxiO1ZyNtCouUI9zZjtGehj/BXTROY4eIRABd9GWtAtMTPHgM1tuFxB7N8FJ
 bdOTkppYEotOVbZ+2FA1YUVOkGLSFmN6sCYXG+f9sWsFPaXNdNbZCTpte6EowzxoMpQx
 hU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680208512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2C1ZnAlPlo34jg9l0tfW7skzlR1UTZP8nwuzsQP38S4=;
 b=bvAxfbxr+mf69eJyRkxKMWmC9+72ZNkhxRGerRB51VZzgYKeFTU6q6QQby1rwz35gY
 F9xipUfJzLEdWN9VsLBfuk4ax/r68vDPQkejATXeG0R20JOsc+GM3Fsxr6irGR4ScD2E
 jEKHiGewiHIwLvqsMf6fjtNS4yli2sX/kduXUs3+tA8nt+w0fsgmCfwfXSUybM/HJX7V
 CQzysNfy+kY7FZwae53en59G8jRIfmqZl8mSDzCWpY8/uTuOR4P9tJuWfZhUdSYdB8cW
 y9E1OEMuKHa+GM7cZXmNxby8a6k4Ogk0AkjTP6fGXnryvghQGzeHFz0sbATMpq6QZ5P9
 ro2g==
X-Gm-Message-State: AO0yUKUCsKDOjmQK2qvv+g6F3pLS/IGBm/nRCh0Ylj8Y4l3zH/2loE/D
 eFuzr/o7NWTG82+/FzcIaWVjdufy2QS1IHLw6aG+w1L+cRE=
X-Google-Smtp-Source: AKy350buExz1MKgBzuxyw6C9Jk0TnIvsGyk75AtK/HuFsFHVQvBQ/YjmSp/3OAG89NbG0nl704M05CzSKSYpv1yr+D4=
X-Received: by 2002:a9d:65d1:0:b0:69f:1418:7a8f with SMTP id
 z17-20020a9d65d1000000b0069f14187a8fmr8179145oth.3.1680208512587; Thu, 30 Mar
 2023 13:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
 <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
 <CADnq5_O_rJYcUXhf+tDaeog2cEZLvDnzz5d=AJ5pTHcWvyrdCA@mail.gmail.com>
 <8dca209b-e508-5e4a-d72f-7090fa99519e@amd.com>
In-Reply-To: <8dca209b-e508-5e4a-d72f-7090fa99519e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 16:35:01 -0400
Message-ID: <CADnq5_OeDEvSwm+oJB-hAWdxpj_mNK9dRrtf1hE6DMaiPMd-rg@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 11:21=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
>
> On 30/03/2023 16:55, Alex Deucher wrote:
> > On Thu, Mar 30, 2023 at 10:34=E2=80=AFAM Shashank Sharma
> > <shashank.sharma@amd.com> wrote:
> >>
> >> On 30/03/2023 16:15, Luben Tuikov wrote:
> >>> On 2023-03-30 10:04, Shashank Sharma wrote:
> >>>> On 30/03/2023 15:42, Luben Tuikov wrote:
> >>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
> >>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
> >>>>>>
> >>>>>> This patch adds helper functions to create and free doorbell
> >>>>>> pages for kernel objects.
> >>>>>>
> >>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 +++++++++++=
+++++
> >>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++=
++++++++
> >>>>>>     2 files changed, 90 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>>> index f9c3b77bf65d..6581b78fe438 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> >>>>>> @@ -27,6 +27,24 @@
> >>>>>>     /*
> >>>>>>      * GPU doorbell structures, functions & helpers
> >>>>>>      */
> >>>>>> +
> >>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> >>>>>> +struct amdgpu_doorbell_obj {
> >>>>> In the comment you say "Structure to hold ...";
> >>>>> it is a C structure, but then in the name of a function we see "obj=
".
> >>>>> (Object is something which is defined like in memory, i.e. it exist=
s, not
> >>>>> something which is only declared.)
> >>>>> This is just a declaration of a structure, not an object per se.
> >>>>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_=
doorbell".
> >>>> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
> >>>> many more existing structure.
> >>> The amdpgu_bo is very different than a structure describing a doorbel=
l.
> >>> The doorbell description isn't really "an object". I understand
> >>> the enthusiasm, but it is really not "an object". It's just a doorbel=
l
> >>> description. :-)
> >> amdgpu_bo is page of ttm_memory with additional information,
> >>
> >> amdgpu_doorbell_obj is a page of ttm_doorbells with additional informa=
tion
> >>
> >> (it is not just one doorbell description)
> >>
> >> I don't see a problem here.
> > I find the new API confusing.  I would expect to see
> > amdgpu_bo_create_kernel(...DOORBELL...), amdgpu_bo_reserve(),
> > amdgpu_bo_kmap(), etc.  That makes it consistent with the other
> > resource pools that we manage in ttm.
>
> I am assuming here you are talking about why do we need
> amdgpu_doorbell_page_create()/free() API here.
>
> The wrappers here allow us to do additional book keeping work.
>
> For example:
>
> - We need to validate kernel doorbell writes, which means we need the
> range of kernel doorbells.
>
> - There are 3 kernel doorbell pages, for KGD, KFD and MES. These are non
> consecutive pages.
>
> - While we do doorbell_write in kernel, we need to check if this index
> is correct, which means:
>
> kgd_doobrell_min < index < kgd_doorbell_max
>
> kfd_doobrell_min < index < kgd_doorbell_max
>
> mes_doobrell_min < index < kgd_doorbell_max
>
> - which means we need start/end limits set at every object.
>
> - we have to either do this work at each place where we want to call
> amdgpu_bo_create(DOORBELL)
>
>    which means KFD, KGD and MES all places (which will look irrelevant
> in the context)
>
>   or we can do this in one place, which is the doorbell wrapper API.
>
>
> Please see patch 10 for this range check.

I don't think we need the range checks for anything other than the
KGD.  The MES stuff should just use the same allocation as KGD.  KFD
has their own mapping in kfd_doorbell.c and they don't use the
WDOORBELL[64] macros.

Alex

>
>
> - Shashank
>
>
> now kfd is setting start/end limits by calling
> amdgpu_get_doorbell_index() function.
>
> >
> > Alex
> >
> >> - Shashank
> >>
> >>> Regards,
> >>> Luben
> >>>
> >>>> - Shashank
> >>>>
> >>>>> Then in the definition, you can call it an object/objects, if you'd=
 like,
> >>>>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
> >>>>> "db =3D doorb_object[i]";
> >>>>>
> >>>>> Regards,
> >>>>> Luben
> >>>>>
> >>>>>> +  struct amdgpu_bo *bo;
> >>>>>> +  uint64_t gpu_addr;
> >>>>>> +  uint32_t *cpu_addr;
> >>>>>> +  uint32_t size;
> >>>>>> +
> >>>>>> +  /* First index in this object */
> >>>>>> +  uint32_t start;
> >>>>>> +
> >>>>>> +  /* Last index in this object */
> >>>>>> +  uint32_t end;
> >>>>>> +
> >>>>>> +  /* bitmap for dynamic doorbell allocation from this object */
> >>>>>> +  unsigned long *doorbell_bitmap;
> >>>>>> +};
> >>>>>> +
> >>>>>>     struct amdgpu_doorbell {
> >>>>>>             /* doorbell mmio */
> >>>>>>             resource_size_t         base;
> >>>>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu=
_device *adev);
> >>>>>>      */
> >>>>>>     void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
> >>>>>>
> >>>>>> +/**
> >>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
> >>>>>> + *
> >>>>>> + * @adev: amdgpu_device pointer
> >>>>>> + *
> >>>>>> + * @db_age: previously allocated doobell page details
> >>>>>> + *
> >>>>>> + */
> >>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> >>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> >>>>>> + *
> >>>>>> + * @adev: amdgpu_device pointer
> >>>>>> + *
> >>>>>> + * @db_age: doobell page structure to fill details with
> >>>>>> + *
> >>>>>> + * returns 0 on success, else error number
> >>>>>> + */
> >>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
> >>>>>> +
> >>>>>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
> >>>>>>     #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index=
), (v))
> >>>>>>     #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index)=
)
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>>> index 1aea92363fd3..8be15b82b545 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> >>>>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_devi=
ce *adev, u32 index, u64 v)
> >>>>>>             }
> >>>>>>     }
> >>>>>>
> >>>>>> +/**
> >>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
> >>>>>> + *
> >>>>>> + * @adev: amdgpu_device pointer
> >>>>>> + *
> >>>>>> + * @db_age: previously allocated doobell page details
> >>>>>> + *
> >>>>>> + */
> >>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> >>>>>> +                                  struct amdgpu_doorbell_obj *db_=
obj)
> >>>>>> +{
> >>>>>> +  amdgpu_bo_free_kernel(&db_obj->bo,
> >>>>>> +                        &db_obj->gpu_addr,
> >>>>>> +                        (void **)&db_obj->cpu_addr);
> >>>>>> +
> >>>>>> +}
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> >>>>>> + *
> >>>>>> + * @adev: amdgpu_device pointer
> >>>>>> + *
> >>>>>> + * @db_age: doobell page structure to fill details with
> >>>>>> + *
> >>>>>> + * returns 0 on success, else error number
> >>>>>> + */
> >>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> >>>>>> +                          struct amdgpu_doorbell_obj *db_obj)
> >>>>>> +{
> >>>>>> +  int r;
> >>>>>> +
> >>>>>> +  db_obj->size =3D ALIGN(db_obj->size, PAGE_SIZE);
> >>>>>> +
> >>>>>> +  r =3D amdgpu_bo_create_kernel(adev,
> >>>>>> +                              db_obj->size,
> >>>>>> +                              PAGE_SIZE,
> >>>>>> +                              AMDGPU_GEM_DOMAIN_DOORBELL,
> >>>>>> +                              &db_obj->bo,
> >>>>>> +                              &db_obj->gpu_addr,
> >>>>>> +                              (void **)&db_obj->cpu_addr);
> >>>>>> +
> >>>>>> +  if (r) {
> >>>>>> +          DRM_ERROR("Failed to create doorbell BO, err=3D%d\n", r=
);
> >>>>>> +          return r;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * GPU doorbell aperture helpers function.
> >>>>>>      */
