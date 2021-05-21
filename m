Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD27C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE0461132
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE0461132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5A86E85A;
	Fri, 21 May 2021 14:54:49 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2446E84F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:54:48 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 q17-20020a4a33110000b029020ebab0e615so2710351ooq.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SWUGkJE01HKnXix2Lc/oYz3Yey/oFrXolcrZu6BzNVs=;
 b=Xaqo7Jwc1EaX2vfcB2qgrFP4yVT/rJ6cek9L+IUy+wg1xZ+2689naQDVS/axpSO7O2
 MKDEDN+C6reCDAfYS/bOysWUHXbFnyDooc/tDDEimDdsT3tHzhHzeRFBihX6Xzg1CBKd
 4IqLG/DSZTXj58oa3qjWEeiz35+NRU1nm0ZmI3M78tsoN65LUDgnZ+tezMTRi9wdEgY9
 1CR9T6J7Ja6emzi6j5u0JgCCq/ZYOu5tZqip8+e/ZCMR/WwfkLMMYaV/Qfwn30olFpJU
 vPcGeYz7mHNk6cBI9HQxYmw74L545elnWd5nFXsL5i/DnCtSDuOOW5QVYxNiP6QJWMbW
 MORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SWUGkJE01HKnXix2Lc/oYz3Yey/oFrXolcrZu6BzNVs=;
 b=llntrM+HkEFg4l0qJeI9CrAJy4gH63wbL/Sa5vQAIx27ge1qFmJkTQjPC/und6JONL
 WudDRn+SwBNwxs2ZneThImDQ9V83T9E7ILEilnhPewZsIMc8kYWPInCHNPJG8xcSH9wj
 sOjR3x7Zz2uq26Ew3DScudin5QWBYqboikuARfKHMhX57srL7ArClzK3vTFZOfA0HZi9
 cktOid2KtsYyIgIq3gcfp5cWBDUw0bqQxotZiFG1zvRcLTLIN4j3FFG8Wq3Ka1K7vk3C
 IM7GcuNdw3TezXx3YRWpDqLDzdF2DrJItLFEorbaSqlCAzOPmnG2JEMuumLy4lcNMmLj
 hsQA==
X-Gm-Message-State: AOAM532iIQeqNxZHVIUitWNo9+Cfa3hwUeFP1EmDH1jXen5llb2IAm7N
 Moae5OE63+FnOyxbEK2kcP5GJ66EWo9bDcrI2Wc=
X-Google-Smtp-Source: ABdhPJwAxvzEdcOh/czOvm3qMHbtkbRyLCrQspChublklJvA35ffjTX7B2j/cIJXShIHoZcbldYOAVwHrInNZ7Gizus=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr8531572oos.72.1621608887432;
 Fri, 21 May 2021 07:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210521124533.4380-1-nirmoy.das@amd.com>
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 10:54:36 -0400
Message-ID: <CADnq5_O=eQqiaGdPNjh8Juc7L3D0_kDJW+BTWAp04nQpQVVSFg@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: add amdgpu_bo_vm bo type
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 8:46 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Add new BO subcalss that will be used by amdgpu vm code.

s/subcalss/subclass/

Alex

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 32 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 10 +++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 745fcf3ea450..61b1edcb490a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -692,6 +692,38 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>         *ubo_ptr = to_amdgpu_bo_user(bo_ptr);
>         return r;
>  }
> +
> +/**
> + * amdgpu_bo_create_vm - create an &amdgpu_bo_vm buffer object
> + * @adev: amdgpu device object
> + * @bp: parameters to be used for the buffer object
> + * @vmbo_ptr: pointer to the buffer object pointer
> + *
> + * Create a BO to be for GPUVM.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_bo_create_vm(struct amdgpu_device *adev,
> +                       struct amdgpu_bo_param *bp,
> +                       struct amdgpu_bo_vm **vmbo_ptr)
> +{
> +       struct amdgpu_bo *bo_ptr;
> +       int r;
> +
> +       /* bo_ptr_size will be determined by the caller and it depends on
> +        * num of amdgpu_vm_pt entries.
> +        */
> +       BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +       r = amdgpu_bo_create(adev, bp, &bo_ptr);
> +       if (r)
> +               return r;
> +
> +       *vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
> +       return r;
> +}
> +
>  /**
>   * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>   * @bo: pointer to the buffer object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 11480c5a2716..a7fbf5f7051e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -44,6 +44,7 @@
>  #define AMDGPU_AMDKFD_CREATE_SVM_BO    (1ULL << 62)
>
>  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
> +#define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
>
>  struct amdgpu_bo_param {
>         unsigned long                   size;
> @@ -125,6 +126,12 @@ struct amdgpu_bo_user {
>
>  };
>
> +struct amdgpu_bo_vm {
> +       struct amdgpu_bo                bo;
> +       struct amdgpu_bo                *shadow;
> +       struct amdgpu_vm_pt             entries[];
> +};
> +
>  static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>  {
>         return container_of(tbo, struct amdgpu_bo, tbo);
> @@ -272,6 +279,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>  int amdgpu_bo_create_user(struct amdgpu_device *adev,
>                           struct amdgpu_bo_param *bp,
>                           struct amdgpu_bo_user **ubo_ptr);
> +int amdgpu_bo_create_vm(struct amdgpu_device *adev,
> +                       struct amdgpu_bo_param *bp,
> +                       struct amdgpu_bo_vm **ubo_ptr);
>  void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>                            void **cpu_addr);
>  int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
