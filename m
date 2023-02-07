Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831CBC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 16:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237D110E56C;
	Tue,  7 Feb 2023 16:53:53 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B81710E56C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 16:53:52 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1685cf2003aso19703036fac.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z974s9mv/szGb+LOt2IWHCZtpEh+cAvaCqKdC5i9exM=;
 b=Rr2MGqBQfiLTL2z+2bOQ/tNxIUEeBPspXfJIDPJM+I6YHlmId9oXG4cVvjlV6Panqt
 k7hVcRVHyzRMwDSnVl9V8wPxMyXThmQ8oqu0axX4IYmPRk+znPjFoSe9Szy7nla6Sgok
 uOFT5QyKQGqPWN+0wn4e1Ysgy83VOKdnWsxdeenOnKz0vs4Z+wLtLUnI7duHxK+KMgdI
 gmh61HFstNIhIg06KlHiq6fWQ7j/YKxd21oLFe16z4TUGORwiW6eBIIL8TxrzvDehqyF
 TJt/sGkAXu3sEaG742xvmkT8XjFG4Um34tJhLoOqGOy9+sgN2yng5vcHG560khOUMz/9
 9mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z974s9mv/szGb+LOt2IWHCZtpEh+cAvaCqKdC5i9exM=;
 b=N0lXV9VCE3kXMBv0EZWhTuaQqvr0hr0bdATjyDM+qbn+BlnsZsQAIoLsIB2d2zHsh/
 V7cxindOWmDRrXFtPE4NYjtgf/yLBN6Y6S5WCFwB9GH1GnLvP3vmXwXBibPvyDWpEiLJ
 yCizwSy7aeRCfcE5HKrTQgd1OGCOU1ZsRfjXzkKC26Kgk5CqI5AE+fMAzNYyot4JzIyZ
 F/i2lTeOtwreRkY2ArYuxcC/sU0QnpiV9DpAGMQwRHfjtoAuPLUSyNfGHmdSKLei91Q/
 0pmGeb0ZJc9AdcFs85nM1Mr7u1ayosiAV1ue5rO/wW4s4yDQwaWXOk+yrWKwD0cz0N1w
 iRGw==
X-Gm-Message-State: AO0yUKU/7BMNve7XndD5Jxqu9sRyh/bN5F3BT3F7EGrbK6YBLyeODoh5
 neKwFFBrJyLn9UanSW3oc9lc52YxL1DT4HDo1IY=
X-Google-Smtp-Source: AK7set+A/QbiMsA2bfsxR7rZ3DC9lto5yw2U4f4VDBYqWdqwvjsVNvRNaL3fiafjtvD03Fx59yZbJ7wnoX7657QEO9Q=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr2799930oao.46.1675788831378; Tue, 07
 Feb 2023 08:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-6-shashank.sharma@amd.com>
 <CADnq5_NmyLz0iJ3JRW2Zc9+yiKxNgdAi26SjjvV-SZiVE=ucCQ@mail.gmail.com>
In-Reply-To: <CADnq5_NmyLz0iJ3JRW2Zc9+yiKxNgdAi26SjjvV-SZiVE=ucCQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 11:53:39 -0500
Message-ID: <CADnq5_NT1PLw__-4408779LEY4A2dpMpgFMo+iQkT-oEKg1=kw@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 7, 2023 at 11:51 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
> >
> > The FW expects us to allocate atleast one page as context space to
> > process gang, process, shadow, GDS and FW_space related work. This
> > patch creates some object for the same, and adds an IP specific
> > functions to do this.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
> >  .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 ++++++++++++++++++
> >  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
> >  3 files changed, 171 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > index 9f3490a91776..18281b3a51f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> > @@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
> >      return idr_find(&uq_mgr->userq_idr, qid);
> >  }
> >
> > +static void
> > +amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> > +                                   struct amdgpu_usermode_queue *queue)
> > +{
> > +    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
> > +}
> > +
> > +static int
> > +amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> > +                                  struct amdgpu_usermode_queue *queue)
> > +{
> > +    int r;
> > +
> > +    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
> > +    if (r) {
> > +        DRM_ERROR("Failed to create context space for queue\n");
> > +        return r;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int
> >  amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> >  {
> > @@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
> >          goto free_qid;
> >      }
> >
> > +    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
> > +    if (r) {
> > +        DRM_ERROR("Failed to create context space\n");
> > +        goto free_mqd;
> > +    }
> > +
> >      list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
> >      args->out.q_id = queue->queue_id;
> >      args->out.flags = 0;
> >      mutex_unlock(&uq_mgr->userq_mutex);
> >      return 0;
> >
> > +free_mqd:
> > +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
> > +
> >  free_qid:
> >      amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> >
> > @@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> >      }
> >
> >      mutex_lock(&uq_mgr->userq_mutex);
> > +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
> >      amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
> >      amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> >      list_del(&queue->userq_node);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> > index 57889729d635..687f90a587e3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> > @@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
> >
> >  }
> >
> > +static int amdgpu_userq_gfx_v11_ctx_create(struct amdgpu_userq_mgr *uq_mgr,
> > +                                           struct amdgpu_usermode_queue *queue)
> > +{
> > +    int r;
> > +    struct amdgpu_device *adev = uq_mgr->adev;
> > +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> > +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> > +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
> > +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
> > +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
> > +
> > +    /*
> > +     * The FW expects atleast one page space allocated for
> > +     * process context related work, and one for gang context.
> > +     */
> > +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, PAGE_SIZE,
> > +                                AMDGPU_GEM_DOMAIN_VRAM,
> > +                                &pctx->obj,
> > +                                &pctx->gpu_addr,
> > +                                &pctx->cpu_ptr);
> > +    if (r) {
> > +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
> > +        return r;
> > +    }
> > +
> > +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, PAGE_SIZE,
> > +                                AMDGPU_GEM_DOMAIN_VRAM,
> > +                                &gctx->obj,
> > +                                &gctx->gpu_addr,
> > +                                &gctx->cpu_ptr);
> > +    if (r) {
> > +        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", r);
> > +        goto err_gangctx;
> > +    }
> > +
> > +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, PAGE_SIZE,
> > +                                AMDGPU_GEM_DOMAIN_VRAM,
> > +                                &gdsctx->obj,
> > +                                &gdsctx->gpu_addr,
> > +                                &gdsctx->cpu_ptr);
> > +    if (r) {
> > +        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
> > +        goto err_gdsctx;
> > +    }
> > +
> > +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
> > +                                AMDGPU_GEM_DOMAIN_VRAM,
> > +                                &fwctx->obj,
> > +                                &fwctx->gpu_addr,
> > +                                &fwctx->cpu_ptr);
> > +    if (r) {
> > +        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
> > +        goto err_fwctx;
> > +    }
> > +
> > +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, PAGE_SIZE,
> > +                                AMDGPU_GEM_DOMAIN_VRAM,
> > +                                &sctx->obj,
> > +                                &sctx->gpu_addr,
> > +                                &sctx->cpu_ptr);
>
>
> Unless there is a specific need for VRAM, we should probably put these in GTT.
>
> Alex
>
> > +    if (r) {
> > +        DRM_ERROR("Failed to allocate shadow bo for userqueue (%d)", r);
> > +        goto err_sctx;
> > +    }
> > +
> > +    return 0;
> > +
> > +err_sctx:
> > +    amdgpu_bo_free_kernel(&fwctx->obj,
> > +                          &fwctx->gpu_addr,
> > +                          &fwctx->cpu_ptr);
> > +
> > +err_fwctx:
> > +    amdgpu_bo_free_kernel(&gdsctx->obj,
> > +                          &gdsctx->gpu_addr,
> > +                          &gdsctx->cpu_ptr);
> > +
> > +err_gdsctx:
> > +    amdgpu_bo_free_kernel(&gctx->obj,
> > +                          &gctx->gpu_addr,
> > +                          &gctx->cpu_ptr);
> > +
> > +err_gangctx:
> > +    amdgpu_bo_free_kernel(&pctx->obj,
> > +                          &pctx->gpu_addr,
> > +                          &pctx->cpu_ptr);
> > +    return r;
> > +}
> > +
> > +static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr *uq_mgr,
> > +                                            struct amdgpu_usermode_queue *queue)
> > +{
> > +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
> > +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
> > +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
> > +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
> > +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
> > +
> > +    amdgpu_bo_free_kernel(&sctx->obj,
> > +                          &sctx->gpu_addr,
> > +                          &sctx->cpu_ptr);
> > +
> > +    amdgpu_bo_free_kernel(&fwctx->obj,
> > +                          &fwctx->gpu_addr,
> > +                          &fwctx->cpu_ptr);
> > +
> > +    amdgpu_bo_free_kernel(&gdsctx->obj,
> > +                          &gdsctx->gpu_addr,
> > +                          &gdsctx->cpu_ptr);
> > +
> > +    amdgpu_bo_free_kernel(&gctx->obj,
> > +                          &gctx->gpu_addr,
> > +                          &gctx->cpu_ptr);
> > +
> > +    amdgpu_bo_free_kernel(&pctx->obj,
> > +                          &pctx->gpu_addr,
> > +                          &pctx->cpu_ptr);
> > +}
> > +
> >  static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
> >  {
> >      return sizeof(struct v11_gfx_mqd);
> > @@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
> >      .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
> >      .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
> >      .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
> > +    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
> > +    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
> >  };
> > diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> > index a6abdfd5cb74..3adcd31618f7 100644
> > --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> > +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> > @@ -25,9 +25,19 @@
> >  #define AMDGPU_USERQUEUE_H_
> >
> >  #define AMDGPU_MAX_USERQ 512
> > +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> > +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> > +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
> > +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
> >
> >  struct amdgpu_userq_mqd_funcs;
> >
> > +struct amdgpu_userq_ctx {
> > +       struct amdgpu_bo *obj;
> > +       uint64_t gpu_addr;
> > +       void    *cpu_ptr;
> > +};
> > +
> >  struct amdgpu_userq_mgr {
> >         struct idr userq_idr;
> >         struct mutex userq_mutex;
> > @@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
> >         uint64_t        mqd_gpu_addr;
> >         void            *mqd_cpu_ptr;
> >
> > +       struct amdgpu_userq_ctx proc_ctx;
> > +       struct amdgpu_userq_ctx gang_ctx;
> > +       struct amdgpu_userq_ctx gds_ctx;
> > +       struct amdgpu_userq_ctx fw_ctx;
> > +       struct amdgpu_userq_ctx shadow_ctx;

These should be an implementation detail for the specific IP.  There
is no need to have these at the userq level.  Different engines may
have different requirements.

Alex

> > +
> >         struct amdgpu_bo        *mqd_obj;
> >         struct amdgpu_vm        *vm;
> >         struct amdgpu_userq_mgr *userq_mgr;
> > @@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
> >         int (*mqd_size)(struct amdgpu_userq_mgr *);
> >         int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> >         void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> > +       int (*ctx_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> > +       void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> >  };
> >
> >  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> > --
> > 2.34.1
> >
