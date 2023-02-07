Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EF4C636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E451610E538;
	Tue,  7 Feb 2023 14:59:16 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9B510E538
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:59:15 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1442977d77dso19308483fac.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YdhowLtgJNOqZjuSrNVYGT9lECyiHvYXtvzLBm9GF4Y=;
 b=ldST2HN/q2UQtfyX3tZtHOZGDV3mf8+L4VgSOMfhTHuH8SvFs6KFmWkDfwjW5f5mo2
 SDvXXNo6HXBF+v4wKMJrns4SSgQp7lFVVays5X+vtvItkZK+FlnOC8BwdxE1bsmsv30H
 MnAdXsa8S/pbTDuiXGyBwIad4ucszlMEAFwPUgQgg9Q+tdqeSnGfWlIFs/42xWkjN5ZQ
 JmpUEg15f1M9euRuDUi+Mrpe3KIM9bRcJNP/ZRJFovGN5EIMJGZjdtNDHzohR7/56px3
 hvkja1CMPUjS+nV+gLrTVDjHgu0AgURagsx33MGV8w8XNK+gQUZ+0VYhUpRtZ+S9XjtD
 gU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdhowLtgJNOqZjuSrNVYGT9lECyiHvYXtvzLBm9GF4Y=;
 b=ZLxi37VUljA7m+etJlrOogVWgkIW5c/UU4jjMrCE7K1RycmGNbDYR3LzDJIWP3vboy
 Ounq2MR9cDHaGMmFKmtO+xQ2xgDNyQ5oI+tjUv4Ut5xRSLN10r58VASoLC4H1kiOwE0p
 WzwC7kIfU450X9INu9aAuVacxTGw5CiAvMRg6kTNaTM/+z4mFMveTYtgNc5AvXFfmXHm
 eDsWdolnUWeqsrFbD651WoWV9S0kYlj+ZU7n+ZzSU74WZqZCkrcDfLWIKZjOxUbvdS81
 YcFt1V2Slrq16t+Ox32B3obdrx739S+eMdWMaQlat0mtY1ylV+TEkZN1Vvwv+/JZqFBu
 z2qw==
X-Gm-Message-State: AO0yUKVLoSIHTNf51j+1xfJVh9DORBZjTTyhn1Hg1CDnz+6+XA9uzec8
 T+G1319f+WimMQ5eKPSVf3kmPg2Luj6qH/IUni07CNTmrKY=
X-Google-Smtp-Source: AK7set8ylCMpqZhAYak7ILUj8vS6TqCzNy1k+ZBGQyuj4Pk660ZvsXf8SXEEvuAcbqUTDLB39Y10RYPZd2/AHwa29ZM=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr488172oab.96.1675781954299; Tue, 07
 Feb 2023 06:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-4-shashank.sharma@amd.com>
In-Reply-To: <20230203215409.2021-4-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:59:02 -0500
Message-ID: <CADnq5_Oy4Z5MTSmD7DFGh1bSqVqo3ut-XWLUxVo84e+A0Q2L4Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: introduce userqueue MQD handlers
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
> context. As the method of formation of a MQD, and its format can vary between
> different graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD hander functions for the usermode queues
> - A general function to create and destroy MQD for a userqueue.
>
> V1: Worked on review comments from Alex on RFC patches:
>     MQD creation should be gen and IP specific.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 64 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  9 +++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index d5bc7fe81750..625c2fe1e84a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -42,6 +42,60 @@ static struct amdgpu_usermode_queue
>      return idr_find(&uq_mgr->userq_idr, qid);
>  }
>
> +static int
> +amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    int size;
> +    struct amdgpu_device *adev = uq_mgr->adev;
> +
> +    if (!uq_mgr->userq_mqd_funcs) {
> +        DRM_ERROR("Userqueue not initialized\n");
> +        return -EINVAL;
> +    }
> +
> +    size = uq_mgr->userq_mqd_funcs->mqd_size(uq_mgr);
> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +                                AMDGPU_GEM_DOMAIN_VRAM,
> +                                &queue->mqd_obj,
> +                                &queue->mqd_gpu_addr,
> +                                &queue->mqd_cpu_ptr);
> +    if (r) {
> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
> +        return r;
> +    }
> +
> +    memset(queue->mqd_cpu_ptr, 0, size);
> +    r = amdgpu_bo_reserve(queue->mqd_obj, false);
> +    if (unlikely(r != 0)) {
> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
> +        goto free_mqd;
> +    }
> +
> +    r = uq_mgr->userq_mqd_funcs->mqd_create(uq_mgr, queue);
> +    amdgpu_bo_unreserve(queue->mqd_obj);
> +    if (r) {
> +        DRM_ERROR("Failed to create MQD for queue\n");
> +        goto free_mqd;
> +    }
> +    return 0;
> +
> +free_mqd:
> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
> +                          &queue->mqd_gpu_addr,
> +                          &queue->mqd_cpu_ptr);
> +   return r;
> +}
> +
> +static void
> +amdgpu_userqueue_destroy_mqd(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    uq_mgr->userq_mqd_funcs->mqd_destroy(uq_mgr, queue);
> +    amdgpu_bo_free_kernel(&queue->mqd_obj,
> +                          &queue->mqd_gpu_addr,
> +                          &queue->mqd_cpu_ptr);
> +}
> +
>  static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  {
>      int r, pasid;
> @@ -82,12 +136,21 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>          goto free_queue;
>      }
>
> +    r = amdgpu_userqueue_create_mqd(uq_mgr, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create MQD\n");
> +        goto free_qid;
> +    }
> +
>      list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>      args->out.q_id = queue->queue_id;
>      args->out.flags = 0;
>      mutex_unlock(&uq_mgr->userq_mutex);
>      return 0;
>
> +free_qid:
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +
>  free_queue:
>      mutex_unlock(&uq_mgr->userq_mutex);
>      kfree(queue);
> @@ -107,6 +170,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>      }
>
>      mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>      amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>      list_del(&queue->userq_node);
>      mutex_unlock(&uq_mgr->userq_mutex);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 9557588fe34f..a6abdfd5cb74 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -26,10 +26,13 @@
>
>  #define AMDGPU_MAX_USERQ 512
>
> +struct amdgpu_userq_mqd_funcs;
> +
>  struct amdgpu_userq_mgr {
>         struct idr userq_idr;
>         struct mutex userq_mutex;
>         struct list_head userq_list;
> +       const struct amdgpu_userq_mqd_funcs *userq_mqd_funcs;
>         struct amdgpu_device *adev;
>  };
>
> @@ -57,6 +60,12 @@ struct amdgpu_usermode_queue {
>
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>
> +struct amdgpu_userq_mqd_funcs {
> +       int (*mqd_size)(struct amdgpu_userq_mgr *);
> +       int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);
> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_usermode_queue *);

I think all we need is create and destroy callbacks.  All memory
allocations and metadata required for a specific engine's queue
management should be handled internally in the engine specific code.

Alex

> +};
> +
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> --
> 2.34.1
>
