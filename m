Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE47C77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE55D10EDCC;
	Thu, 30 Mar 2023 11:29:11 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF7510EDCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:29:10 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id t10so74959102edd.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680175749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bWyoCKjb9UTDLISpPg1jWo0DKrt4PohcvDsTSp77Tg=;
 b=AWAb2hlRvjvtiN2r1JsXrs9lMH8MLlNHo6ptDKB1EvCBOhucN815Pc4/CKP4XzrJAK
 ottYxdvvZxYYyKuYn5IncHFiaehNzJx71PH2Ez2532JJMelPMFH9C6h/s57sbHquui6h
 UecdUq/Wpndv9g++/uY6YrSfg13MKpd4yg6BIPLAtyjHXKf8pItBdmajTGHcZrQWNbhj
 eZMkKqJTHwKsOuOnb3yfnJH/5t9rzC8Yn6qtJ5SRcoL/gpwI5kLhZiDjACWtmqNcWQPo
 SRQk/uXevlC3sDy9JgzteJPxp4fL96MAFhwYZveRgPyNDdgz1x/YR0zjeSSUwzGcQNG2
 xO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680175749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bWyoCKjb9UTDLISpPg1jWo0DKrt4PohcvDsTSp77Tg=;
 b=OsedITO4o0sEicXdfSA2CIFJNM1ttDeLr68Tf3MkQRkzjBLLv6HRM4jAUiCfuJ0S6n
 ILBQjBCvZsGS0GKx7xCbHBsbwYnDxRvi6DB8SHxZvdubfFwr9PtSuk6KhpWKj+AMXpnp
 aP06FnWY2Pj3/gRjxhJvIY18wfioI7Av1UvJcyZv6Nya/gv8xMeUPK2JDl7cMUZMhBtz
 O1flj7F1c/gezj3r9rNqk92hP+onPbdb7QXdf+hucyH2d+eAtT+Emw5Vg3mvS0dj7oSK
 9bdVG6XMMh0nVsAXxtZbmNPylJ4K71vfuRr9ynnl9KkplzAT7+jgAWrcNhkRcTo59nQr
 NZcQ==
X-Gm-Message-State: AAQBX9fded7H4dE/tzmOKWmU8/+d0ymSdRQsbfwHlx4KlVbBgaovSM5R
 FgD2M3aPLfBqLJnvpw48afg=
X-Google-Smtp-Source: AKy350aKfXDxNiW33UjO1zeKhbt9fTjU736WODT2ar6bafIJMds8n1nHKfCze302EjP+blCYoW6vpQ==
X-Received: by 2002:a17:907:3f82:b0:92e:c4c9:7a43 with SMTP id
 hr2-20020a1709073f8200b0092ec4c97a43mr28124600ejc.25.1680175748789; 
 Thu, 30 Mar 2023 04:29:08 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a50c054000000b004aeeb476c5bsm17900514edd.24.2023.03.30.04.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 04:29:08 -0700 (PDT)
Message-ID: <220faa77-f51d-0551-e390-437e2accbced@gmail.com>
Date: Thu, 30 Mar 2023 13:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329154753.1261-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds helper functions to create and free doorbell
> pages for kernel objects.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>   2 files changed, 90 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index f9c3b77bf65d..6581b78fe438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -27,6 +27,24 @@
>   /*
>    * GPU doorbell structures, functions & helpers
>    */
> +
> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> +struct amdgpu_doorbell_obj {
> +	struct amdgpu_bo *bo;
> +	uint64_t gpu_addr;

Do we need to map the doorbells into the GART for something?

On the other hand we probably don't have the check to not do it in 
amdgpu_bo_create_reserved yet.

> +	uint32_t *cpu_addr;
> +	uint32_t size;
> +
> +	/* First index in this object */
> +	uint32_t start;
> +
> +	/* Last index in this object */
> +	uint32_t end;
> +
> +	/* bitmap for dynamic doorbell allocation from this object */
> +	unsigned long *doorbell_bitmap;
> +};
> +

Do we really need a separate structure for all this? As far as I can see 
this is just part of the doorbell handling.

>   struct amdgpu_doorbell {
>   	/* doorbell mmio */
>   	resource_size_t		base;
> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>    */
>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
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
> +				struct amdgpu_doorbell_obj *db_obj);
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
> +				struct amdgpu_doorbell_obj *db_obj);
> +
>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 1aea92363fd3..8be15b82b545 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   	}
>   }
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
> +					struct amdgpu_doorbell_obj *db_obj)
> +{
> +	amdgpu_bo_free_kernel(&db_obj->bo,
> +			      &db_obj->gpu_addr,
> +			      (void **)&db_obj->cpu_addr);
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
> +				struct amdgpu_doorbell_obj *db_obj)
> +{
> +	int r;
> +
> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
> +
> +	r = amdgpu_bo_create_kernel(adev,
> +				    db_obj->size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &db_obj->bo,
> +				    &db_obj->gpu_addr,
> +				    (void **)&db_obj->cpu_addr);
> +
> +	if (r) {
> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * GPU doorbell aperture helpers function.
>    */

