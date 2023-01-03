Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C83C46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA9D10E05E;
	Tue,  3 Jan 2023 14:48:58 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C63510E05E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:48:57 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id r11so27210646oie.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 06:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sAXr0pb5xSe8vgYKZkM61RaZ4683klKLCcufnSpzAW4=;
 b=nt5Z/AyydaZe2KL/Q+cvXv2gUpx9fQDeBJtaEIPvYj9PPqzmqit0ZYzt7fbWCfH5B8
 +BmvDAQil8x/8hNOJ/hzjR8yMxSxg9Dk7gMNwh3aOfflj2Ltyomq8M7W0bdOoWS8fyCH
 3+RtJJ0RnhZRj3dS1706q2qhfQPYqLiLNq3SE55u4JxpX5X/G6eyeBVYc3d53wpB1P+q
 7SZLkdQxkQW4P08jWrGAXbqD0GLpv6FEkAVGbIVq1Gw1m0GsKNMlolhG/89WfQ1PyIrf
 qiWV2aAE1Pp8W1qGZGwCG1p75MXVqB/rz3ot4b4AGfytys5aSc7TTBXkh8tOIrT4eu30
 bJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sAXr0pb5xSe8vgYKZkM61RaZ4683klKLCcufnSpzAW4=;
 b=z3DuyHicjYqCy1teWEhQj6jiyrF0pgEL42VUYUy2EQk9C9Saq2BkUHIWHiW80EgQnO
 hTlgCLIBhMbHQrxI5wp8CwOgdK+Si4xFewjvjh7B2fw7KKbLrM2Y0KWalGw83nMDTTHy
 atpBJ8cF4ew7/EjEQ1STwwkxHw8ct3tDPpTfNLAPo75rl0VZQgTrIoS4rN/HSRg2nDBU
 7JAvaCOdGAaVRbCTb9by7i+bdxQ3rusGwwOi9Ct0Lv2tYBLaDgt6HYBEAjyEi+Y1yPRo
 B4X0fNh598Q22mGl7q2fZr35tDryoWWljyK2N4EAkcLYbwljdkdkJLUblsbxEZibN6hB
 gWBw==
X-Gm-Message-State: AFqh2krCUyBL4LjDGBxKKVp//pyTVGYDTzxLjhjPWRhJtqdZ8J2QdMe/
 F5dOC8Rhq8Eb7I1j8lq/OIlD30Y6NZ9olIPwP6c1D7Vb
X-Google-Smtp-Source: AMrXdXvprlB3yJGOiCwPxUFtylXboucl67K+FiOCkvX9cQDeD6tDm+3/BVoEV9wAI9lZr+oQJkOrx2TJ84rRp9u7/6I=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr2896525oib.46.1672757336385; Tue, 03
 Jan 2023 06:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-6-shashank.sharma@amd.com>
 <CADnq5_Nz6Q-RrO47G_fMYFUSLC-J9DpZhR_5Lbs=heMcXfSG1A@mail.gmail.com>
 <091e247d-9416-6f03-87f6-470adf798eeb@amd.com>
In-Reply-To: <091e247d-9416-6f03-87f6-470adf798eeb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 09:48:45 -0500
Message-ID: <CADnq5_PzgiWxR2r3F2grkRGW_qjVD5C2iyy4c97Gjr8DjYJh4g@mail.gmail.com>
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

On Tue, Jan 3, 2023 at 4:40 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
>
> On 29/12/2022 18:54, Alex Deucher wrote:
> > On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >> The FW expects us to allocate atleast one page as process
> >> context space, and one for gang context space. This patch adds some
> >> object for the same.
> > This should be handled in the IP specific code for the MQD creation.
> > Each IP may have different requirements for MQD related metadata.
> >
> > Alex
>
> Noted, so 3 IP specific functions so far,
>
> .init_mqd(), .map() and .create_ctx_space().
>

I think this can be handled in init_mqd().  No need for a separate callback.

Alex

> - Shashank
>
> >
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 57 +++++++++++++++++++
> >>   .../drm/amd/include/amdgpu_usermode_queue.h   |  8 +++
> >>   2 files changed, 65 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> index b566ce4cb7f0..2a854a5e2f70 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> @@ -69,6 +69,56 @@ amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
> >>       return 0;
> >>   }
> >>
> >> +static int
> >> +amdgpu_userqueue_create_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> >> +{
> >> +    int r;
> >> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> >> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> >> +    /*
> >> +     * The FW expects atleast one page space allocated for
> >> +     * process context related work, and one for gang context.
> >> +     */
> >> +    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> >> +                                AMDGPU_GEM_DOMAIN_VRAM,
> >> +                                &pctx->obj,
> >> +                                &pctx->gpu_addr,
> >> +                                &pctx->cpu_ptr);
> >> +    if (r) {
> >> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> >> +        return r;
> >> +    }
> >> +
> >> +    r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> >> +                                AMDGPU_GEM_DOMAIN_VRAM,
> >> +                                &gctx->obj,
> >> +                                &gctx->gpu_addr,
> >> +                                &gctx->cpu_ptr);
> >> +    if (r) {
> >> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> >> +        amdgpu_bo_free_kernel(&pctx->obj,
> >> +                              &pctx->gpu_addr,
> >> +                              &pctx->cpu_ptr);
> >> +        return r;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void
> >> +amdgpu_userqueue_free_context(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> >> +{
> >> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> >> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> >> +
> >> +    amdgpu_bo_free_kernel(&pctx->obj,
> >> +                          &pctx->gpu_addr,
> >> +                          &pctx->cpu_ptr);
> >> +    amdgpu_bo_free_kernel(&pctx->obj,
> >> +                          &gctx->gpu_addr,
> >> +                          &gctx->cpu_ptr);
> >> +}
> >> +
> >>   static void
> >>   amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> >>   {
> >> @@ -282,6 +332,12 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
> >>           goto free_mqd;
> >>       }
> >>
> >> +    r = amdgpu_userqueue_create_context(adev, queue);
> >> +    if (r < 0) {
> >> +        DRM_ERROR("Failed to create context for queue\n");
> >> +        goto free_mqd;
> >> +    }
> >> +
> >>       ctx->userq = queue;
> >>       args->out.q_id = queue->queue_id;
> >>       args->out.flags = 0;
> >> @@ -306,6 +362,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
> >>       struct amdgpu_usermode_queue *queue = ctx->userq;
> >>
> >>       mutex_lock(&adev->userq.userq_mutex);
> >> +    amdgpu_userqueue_free_context(adev, queue);
> >>       amdgpu_userqueue_destroy_mqd(queue);
> >>       amdgpu_userqueue_remove_index(adev, queue);
> >>       ctx->userq = NULL;
> >> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >> index c1fe39ffaf72..8bf3c0be6937 100644
> >> --- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> >> @@ -26,6 +26,12 @@
> >>
> >>   #define AMDGPU_MAX_USERQ 512
> >>
> >> +struct amdgpu_userq_ctx {
> >> +       struct amdgpu_bo *obj;
> >> +       uint64_t gpu_addr;
> >> +       void    *cpu_ptr;
> >> +};
> >> +
> >>   struct amdgpu_usermode_queue {
> >>          int             queue_id;
> >>          int             queue_type;
> >> @@ -44,6 +50,8 @@ struct amdgpu_usermode_queue {
> >>
> >>          struct amdgpu_bo        *mqd_obj;
> >>          struct amdgpu_vm        *vm;
> >> +       struct amdgpu_userq_ctx proc_ctx;
> >> +       struct amdgpu_userq_ctx gang_ctx;
> >>          struct list_head        list;
> >>   };
> >>
> >> --
> >> 2.34.1
> >>
