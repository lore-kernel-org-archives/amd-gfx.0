Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C429FC48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 20:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCB661246
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 20:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCB661246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5168089CAD;
	Mon, 14 Jun 2021 20:01:06 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFA989CD9
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 20:01:05 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id x196so15651960oif.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V7TFbrkwRXbvZszfgSKyTerdC8b3H3hqRYt/we/H/9I=;
 b=o+gHYJ23mBt0QaGuN3YZGflqG6CC4Vc3yqTgNYfwtpOf498J775Wy8soS9Qfcd0TXU
 H+OepOXWUEcRMpG8JYirCaPliCOJblgMk2xYoQBAQGRB3j7z/X9C6ZhJoVghZ3hK5Qzs
 f1dhSyZ5lYCLAZK3a+cHdQGHN1GS50YsJNTl9xr+MPQ/SlE1VjCqpT04Gakt3ZoEd+Ss
 Gw+6zCe9/xAzNS8PKUbfY9btKwTnn8jewEda2GhQniiP2+YZv1D2W/POnTUbsKHHKLRx
 A4q2tjG4JHbYU451xMXGrG7DZ9FYBZestx+kaG+8c9lkE8RRNdUH9X16FACDLuukD/+q
 jlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V7TFbrkwRXbvZszfgSKyTerdC8b3H3hqRYt/we/H/9I=;
 b=VqmkC92w5hvy9neNKkaz+fm2bgKvc6X0DpGMhc05zNvgT+aBeesTX+/qRNn9n+OdrV
 F4FZh+sbjmYzBTuX4/5+ZvV/wIKrZub2L+s8oq45sFHELqUyLbNOqa2aWtCaH6gySySY
 KV66/8WFZUGG8pjj0IzlDTi3ajVBuBHr0kwdnW6HBsQNows+MqPbHt2RA9fcUivmp+HS
 66HGvITyVmFm46cqrushFhkLs9nf3KAcvVcdYKvlT+ZUeA+AXeDOrAYbbSW5z9e0mXft
 ozyf/SQlsaU8vHrz0IUx8UxNJWrKiZK44XD6pOlZkrXN0TqT3R2X8FrE0dhdW3VWJfdE
 dEug==
X-Gm-Message-State: AOAM530u63JuI9JbVkrdIdyaRB7O/altCgowEh5cA03WnFae/ZwL4wA5
 ov+8EGx0KI5WTYhaHNkvLl6MjqRoiHBLHujev9U=
X-Google-Smtp-Source: ABdhPJy/ouKaFZi1u5pRE7+JrHHUFedN/SctyieswQyXH2ktYFGlVcsVCtlTucxx1CcHP7kfRWMFCcpdswH2jfqS93g=
X-Received: by 2002:a05:6808:999:: with SMTP id
 a25mr11571483oic.123.1623700864672; 
 Mon, 14 Jun 2021 13:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210614192653.18239-1-nirmoy.das@amd.com>
In-Reply-To: <20210614192653.18239-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Jun 2021 16:00:53 -0400
Message-ID: <CADnq5_PZtBA-iXC1LcpGvi-xeMtx8QkUxY5_m_zarWsoeuufBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
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
Cc: Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 14, 2021 at 3:27 PM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Make provision to pass different ttm BO destroy callback
> while creating a amdgpu_bo.
>
> v2: pass destroy callback using amdgpu_bo_param.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 52 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
>  2 files changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9092ac12a270..f4f57a73d095 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -12,7 +12,7 @@
>   *
>   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * FITNEsS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>   * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
>   * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>   * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE

Unrelated whitespace change.  Please drop.

Alex

> @@ -73,11 +73,9 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
>         }
>  }
>
> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +static void amdgpu_bo_destroy_base(struct ttm_buffer_object *tbo)
>  {
> -       struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>         struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> -       struct amdgpu_bo_user *ubo;
>
>         if (bo->tbo.pin_count > 0)
>                 amdgpu_bo_subtract_pin_size(bo);
> @@ -87,18 +85,40 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>         if (bo->tbo.base.import_attach)
>                 drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
>         drm_gem_object_release(&bo->tbo.base);
> +       amdgpu_bo_unref(&bo->parent);
> +}
> +
> +static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +
> +       amdgpu_bo_destroy_base(tbo);
> +       kvfree(bo);
> +}
> +
> +static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
> +{
> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +       struct amdgpu_bo_user *ubo;
> +
> +       amdgpu_bo_destroy_base(tbo);
> +       ubo = to_amdgpu_bo_user(bo);
> +       kfree(ubo->metadata);
> +       kvfree(bo);
> +}
> +
> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> +{
> +       struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +       struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +
> +       amdgpu_bo_destroy_base(tbo);
>         /* in case amdgpu_device_recover_vram got NULL of bo->parent */
>         if (!list_empty(&bo->shadow_list)) {
>                 mutex_lock(&adev->shadow_list_lock);
>                 list_del_init(&bo->shadow_list);
>                 mutex_unlock(&adev->shadow_list_lock);
>         }
> -       amdgpu_bo_unref(&bo->parent);
> -
> -       if (bo->tbo.type != ttm_bo_type_kernel) {
> -               ubo = to_amdgpu_bo_user(bo);
> -               kfree(ubo->metadata);
> -       }
>
>         kvfree(bo);
>  }
> @@ -115,8 +135,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   */
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>  {
> -       if (bo->destroy == &amdgpu_bo_destroy)
> +       if (bo->destroy == &amdgpu_bo_destroy ||
> +           bo->destroy == &amdgpu_bo_user_destroy ||
> +           bo->destroy == &amdgpu_bo_vm_destroy)
>                 return true;
> +
>         return false;
>  }
>
> @@ -592,9 +615,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>         if (bp->type == ttm_bo_type_kernel)
>                 bo->tbo.priority = 1;
>
> +       if (!bp->destroy)
> +               bp->destroy = &amdgpu_bo_destroy;
> +
>         r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
>                                  &bo->placement, page_align, &ctx,  NULL,
> -                                bp->resv, &amdgpu_bo_destroy);
> +                                bp->resv, bp->destroy);
>         if (unlikely(r != 0))
>                 return r;
>
> @@ -658,6 +684,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>         int r;
>
>         bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
> +       bp->destroy = &amdgpu_bo_user_destroy;
>         r = amdgpu_bo_create(adev, bp, &bo_ptr);
>         if (r)
>                 return r;
> @@ -689,6 +716,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>          * num of amdgpu_vm_pt entries.
>          */
>         BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +       bp->destroy = &amdgpu_bo_vm_destroy;
>         r = amdgpu_bo_create(adev, bp, &bo_ptr);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index e36b84516b4e..a8c702634e1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -55,7 +55,8 @@ struct amdgpu_bo_param {
>         u64                             flags;
>         enum ttm_bo_type                type;
>         bool                            no_wait_gpu;
> -       struct dma_resv *resv;
> +       struct dma_resv                 *resv;
> +       void                            (*destroy)(struct ttm_buffer_object *bo);
>  };
>
>  /* bo virtual addresses in a vm */
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
