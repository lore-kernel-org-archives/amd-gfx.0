Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF588C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 17:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0A38994A;
	Thu, 29 Dec 2022 17:54:20 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1A88994A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 17:54:17 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1447c7aa004so22408143fac.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHlzEXJhyZZ0tI9HRD0UitTdBrnY+Dw0ik7xx37s3+c=;
 b=GcWMMAeee98cncsf1TfRm1/AsppHiZ+lGrf43k0JvmB3hAj50CUtGAghi5k8KAwhcq
 NxDbxxyJ6vhQnCok0hccS5H5kuWiiDltPsa1F/YirJLobzSma0j8NUGjjgxA4JBFcW7t
 mRxe/N0JoeSoFhEVzcyEvz6YNLmkx6wKndWCY1Af+j3wG5PmvxkxMhZdPjk4fvzKnhx7
 Mu+hhkmCJKqaLmtBkovpW6u+Xyr4UgeBax+OcpIFGOh8FI4rVLDblDqdr+hbm7FZWDpT
 kI8+PfsxoaDNnby0U/CduuhLhCMoNrcd725chnOMuglLFK8xOG2IMmM42Wr1ip4t4lIQ
 vWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHlzEXJhyZZ0tI9HRD0UitTdBrnY+Dw0ik7xx37s3+c=;
 b=qsmFIhTbasJ3dg1ecM617SpXZpDT+PsVg0cPAWG0mQU3JcvQqa0RiIsQEPT2SbOPhx
 8olyxc8usabISs9R/9q0HHIItdXgX3Xf9oyRA4zRF3f0juxDLMhtZljEyfyWLHjmEw1Q
 SPfHdUcIddJqXLHBQ6fN0wfOa54zREpSKyzV6BFDs5mmLkiyZgFqJN1TfjZFt5TEAaYB
 ZsoCW04ZmDpyrFFS1ogLqsTJJJJMN76mbCfEFKiCtRFH8oARsv6phUxwHX/VRm6NOG2W
 0V2HpiTj63+ILpQdijM+66yTRQtlBsSJ3ptho8MDaDNZ+91sfTZTm2EyhFV+FFbs58Ne
 aeYA==
X-Gm-Message-State: AFqh2krAUU9QqcPByNnHduwYP5tHppg93X+rPgTnC8EOwElP/43uDWFr
 faT98/As85eB+ozfEZRe5WcMZiC7QKCeZkXTXZU5Z2Dz
X-Google-Smtp-Source: AMrXdXsQnDzFywV7bs31bYkO5ySSC5BD1ctDRANJkJfn5i3nKiZs5WapajHnnU9QDCYr8ZABIwL2mGPZY4NRTKMR3/M=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr2463576oaq.46.1672336456884; Thu, 29
 Dec 2022 09:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-6-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Dec 2022 12:54:04 -0500
Message-ID: <CADnq5_Nz6Q-RrO47G_fMYFUSLC-J9DpZhR_5Lbs=heMcXfSG1A@mail.gmail.com>
Subject: Re: [RFC 5/7] drm/amdgpu: Create context for usermode queue
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> The FW expects us to allocate atleast one page as process
> context space, and one for gang context space. This patch adds some
> object for the same.

This should be handled in the IP specific code for the MQD creation.
Each IP may have different requirements for MQD related metadata.

Alex


>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
>  .../drm/amd/include/amdgpu_usermode_queue.h   |  8 +++
>  2 files changed, 65 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index b566ce4cb7f0..2a854a5e2f70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -69,6 +69,56 @@ amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
>      return 0;
>  }
>
> +static int
> +amdgpu_userqueue_create_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> +    /*
> +     * The FW expects atleast one page space allocated for
> +     * process context related work, and one for gang context.
> +     */
> +    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &pctx->obj,
> +                                &pctx->gpu_addr,
> +                                &pctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &gctx->obj,
> +                                &gctx->gpu_addr,
> +                                &gctx->cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> +        amdgpu_bo_free_kernel(&pctx->obj,
> +                              &pctx->gpu_addr,
> +                              &pctx->cpu_ptr);
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
> +static void
> +amdgpu_userqueue_free_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> +
> +    amdgpu_bo_free_kernel(&pctx->obj,
> +                          &pctx->gpu_addr,
> +                          &pctx->cpu_ptr);
> +    amdgpu_bo_free_kernel(&pctx->obj,
> +                          &gctx->gpu_addr,
> +                          &gctx->cpu_ptr);
> +}
> +
>  static void
>  amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
>  {
> @@ -282,6 +332,12 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>          goto free_mqd;
>      }
>
> +    r = amdgpu_userqueue_create_context(adev, queue);
> +    if (r < 0) {
> +        DRM_ERROR("Failed to create context for queue\n");
> +        goto free_mqd;
> +    }
> +
>      ctx->userq = queue;
>      args->out.q_id = queue->queue_id;
>      args->out.flags = 0;
> @@ -306,6 +362,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
>      struct amdgpu_usermode_queue *queue = ctx->userq;
>
>      mutex_lock(&adev->userq.userq_mutex);
> +    amdgpu_userqueue_free_context(adev, queue);
>      amdgpu_userqueue_destroy_mqd(queue);
>      amdgpu_userqueue_remove_index(adev, queue);
>      ctx->userq = NULL;
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> index c1fe39ffaf72..8bf3c0be6937 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> @@ -26,6 +26,12 @@
>
>  #define AMDGPU_MAX_USERQ 512
>
> +struct amdgpu_userq_ctx {
> +       struct amdgpu_bo *obj;
> +       uint64_t gpu_addr;
> +       void    *cpu_ptr;
> +};
> +
>  struct amdgpu_usermode_queue {
>         int             queue_id;
>         int             queue_type;
> @@ -44,6 +50,8 @@ struct amdgpu_usermode_queue {
>
>         struct amdgpu_bo        *mqd_obj;
>         struct amdgpu_vm        *vm;
> +       struct amdgpu_userq_ctx proc_ctx;
> +       struct amdgpu_userq_ctx gang_ctx;
>         struct list_head        list;
>  };
>
> --
> 2.34.1
>
