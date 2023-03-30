Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22377C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5C410EE8C;
	Thu, 30 Mar 2023 14:29:02 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E9F10EE8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:29:00 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-17aceccdcf6so19885036fac.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680186539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=as4VBnejmHV6BgRCQrBznuVUs5VkFCOboQR4low66xg=;
 b=RBGXcH0Ps6CXGGNHnNcCa4WWxBCk6xQ+sgAii4FaUAuqecuvOjV/o2/h2x6cyq8va1
 imsov92UFl9XqlGgKq9SUJ+eiEFQfjtRhDC/OSOOGOksQZK606em1Zx0ItDOsBaKxzA0
 Wn0AnA/pzqgR4D8XuikJPjAr/XkMPwXIB6MXwc0GrvvfuPRxOvmgSt8gmMF5cRsEkpDq
 gMWKiuqx8y0eulf//tGBiBkldcRwhKdq43sJtcItgzgJYaYsrfTDz90FX1Ypy8dzEWF6
 yotcu+wqa1Lu18PJ1Pq+pbzroVr30t8pffYCXyY/12qdpPfPcNsjnvbwMCOimwi/AJaa
 H08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680186539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=as4VBnejmHV6BgRCQrBznuVUs5VkFCOboQR4low66xg=;
 b=4S5orSye/6fUDI18sMGwETGP3out1x+Er0PoY57kLOcaPRUA38hvH/CtijVuDCMU31
 amYhV2s3pDC0Wb3nCEkMj7mQo7iNb61VlVQf6XMLcdUv5AJIzF+uIci4NRPS/lvwRjm9
 mfkQ8/fbPtDzdYA1atedYRAKNwL1SFf8T53ty0oTtvBeogWvAk4x6FzB6pnG+aXn7NVi
 v5ahXTIyclx5AzOlUDdAMivy8NmI8a1pqkCH1WVpJKxs4JxWG2SCS3wprZGv/Ay8kPjb
 xovT0jKjHIuxwnvY2XFRk2ybpAZW+Dd2VEmj4VkOKOw2fepfybJs6Eq53Pcb8PcLBrIQ
 BzIw==
X-Gm-Message-State: AAQBX9flNREylezWgYwvsxCKCal8Ztvft9xGXyL6iUCyowqmdl5P8k6V
 DUT9sJ6ebaXyoGCyXyQEhpMFo4WeYoBTkn/rcNvymarA
X-Google-Smtp-Source: AKy350ZLRbSaEzAM4uiZawzos+tSkLudSW4pYSHT9sPMxfCP3tRjZU2AeibOnO5xCuo14NFsCZYIeKK5KKt3J0tyUUo=
X-Received: by 2002:a05:6870:58:b0:17e:1970:e5d9 with SMTP id
 24-20020a056870005800b0017e1970e5d9mr2377691oaz.4.1680186539482; Thu, 30 Mar
 2023 07:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
In-Reply-To: <20230329154753.1261-8-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 10:28:48 -0400
Message-ID: <CADnq5_OQzuYWPP3Mr7g349+tBa6-HT25xn_o9N_MyEgG5gewLA@mail.gmail.com>
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
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 11:48=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds helper functions to create and free doorbell
> pages for kernel objects.

I think we can probably drop this patch.  I think it would be simpler
to just use standard amdgpu_bos to represent them and then maybe a
helper function to calculate the BAR offset from a doorbell bo object.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>  2 files changed, 90 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index f9c3b77bf65d..6581b78fe438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -27,6 +27,24 @@
>  /*
>   * GPU doorbell structures, functions & helpers
>   */
> +
> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> +struct amdgpu_doorbell_obj {
> +       struct amdgpu_bo *bo;
> +       uint64_t gpu_addr;
> +       uint32_t *cpu_addr;
> +       uint32_t size;
> +
> +       /* First index in this object */
> +       uint32_t start;
> +
> +       /* Last index in this object */
> +       uint32_t end;
> +
> +       /* bitmap for dynamic doorbell allocation from this object */
> +       unsigned long *doorbell_bitmap;
> +};
> +
>  struct amdgpu_doorbell {
>         /* doorbell mmio */
>         resource_size_t         base;
> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device=
 *adev);
>   */
>  void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>
> +/**
> + * amdgpu_doorbell_free_page - Free a doorbell page
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: previously allocated doobell page details
> + *
> + */
> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> +                               struct amdgpu_doorbell_obj *db_obj);
> +
> +/**
> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: doobell page structure to fill details with
> + *
> + * returns 0 on success, else error number
> + */
> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> +                               struct amdgpu_doorbell_obj *db_obj);
> +
>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 1aea92363fd3..8be15b82b545 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *ade=
v, u32 index, u64 v)
>         }
>  }
>
> +/**
> + * amdgpu_doorbell_free_page - Free a doorbell page
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: previously allocated doobell page details
> + *
> + */
> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> +                                       struct amdgpu_doorbell_obj *db_ob=
j)
> +{
> +       amdgpu_bo_free_kernel(&db_obj->bo,
> +                             &db_obj->gpu_addr,
> +                             (void **)&db_obj->cpu_addr);
> +
> +}
> +
> +/**
> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: doobell page structure to fill details with
> + *
> + * returns 0 on success, else error number
> + */
> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> +                               struct amdgpu_doorbell_obj *db_obj)
> +{
> +       int r;
> +
> +       db_obj->size =3D ALIGN(db_obj->size, PAGE_SIZE);
> +
> +       r =3D amdgpu_bo_create_kernel(adev,
> +                                   db_obj->size,
> +                                   PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_DOORBELL,
> +                                   &db_obj->bo,
> +                                   &db_obj->gpu_addr,
> +                                   (void **)&db_obj->cpu_addr);
> +
> +       if (r) {
> +               DRM_ERROR("Failed to create doorbell BO, err=3D%d\n", r);
> +               return r;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * GPU doorbell aperture helpers function.
>   */
> --
> 2.40.0
>
