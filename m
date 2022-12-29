Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 17:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD8910E408;
	Thu, 29 Dec 2022 17:52:12 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA85210E408
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 17:52:09 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 p17-20020a9d6951000000b00678306ceb94so11848687oto.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8FknS0GoLe7nYqXJs7/j+fxLyrWPfRTTm5njnzYNztg=;
 b=QfB7AHrXnx9EsYol7kztC8KZajH1f/pYcYbq7N+k32eGaIjQW6D/PhK80Bubf09sQX
 AdCBY3F9efkJEUDUUXWM1XOS8aidxKqf1716WfQnFPf+q0fs/kzIRXkWzvXnl4h03sWN
 D6coVxfTESr2LMIykYVziEYRFkzfCOvnBuUsSWTcBv0aG/qTAtEk6tLu4sxxfGVE69pu
 u8ZDTL5t4kShEMju2tXzFw8g19YniI+sUqcqjhI6uIjgYyZoQKKP34Xf2eJma3p6fyTn
 WflWXlR2OpgPs5VnAeN7N3+zfOnhvwFXCqO5Ox3SxcvNtx3Ljg1/PndxYZCfqGmhYJc4
 iAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FknS0GoLe7nYqXJs7/j+fxLyrWPfRTTm5njnzYNztg=;
 b=XZ2T86SfluOaT7lOAf8wWsFGo73w+I6pdgYZxwLCMIyAmarlsbQ2aytxXMDbUt4+Jo
 DIxTtOmXqaq3pg1zJZKoJGve7hP2JwBb4qkF1LgqrB3UTkdBKVQe12NtyG3HRiWU6oWb
 kBlnrLy6PRQ+xUlXVOd67CTRPqrbncVtrJuv+gtbGJCuNbKso50s3nSaDu5+PMA/vYmJ
 MXnrSqVq9gSQsXpEs92GSsOpBuEUm3stx04eETtpzsFLDLZlCKkNi63vNp2h674zSiYq
 7eLNHQyPXdnMeGpsZoZ3Mn8PZ9/ArtHCDIczaX048ohCIt7InZR+mkJAQj7IBM1LKU3T
 Roxg==
X-Gm-Message-State: AFqh2koW+XKQaqbdpKYan3WYFU8o9kf0BtkQguF6/ohN4zOM8oM6oPoo
 WS7qQ+G1GLkRwjXVBxIFgfywxmWb5WJWOXarGOg=
X-Google-Smtp-Source: AMrXdXuLZHk1UW3ERQ3+rC+uUw/w17Md8+FTNuZlJ5+j7NYKWT5WEG2pw3yOtemMGSX4sXIGfVbHVzyLK2Y6UBs5bec=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr1950999otk.123.1672336329157; Thu, 29
 Dec 2022 09:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-7-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Dec 2022 12:51:58 -0500
Message-ID: <CADnq5_MSrURbaNCN9+cjPAqoFoOPtLBXZPcP7hM_UFWJKKDyFw@mail.gmail.com>
Subject: Re: [RFC 6/7] drm/amdgpu: Map userqueue into HW
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
> This patch add the function to map/unmap the usermode queue into the HW,
> using the prepared MQD and other objects. After this mapping, the queue
> will be ready to accept the workload.

This should also be a callback into IP specific code.  It will be
different for each IP type and version.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 2a854a5e2f70..b164e24247ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -50,6 +50,67 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
>      ida_simple_remove(&uqg->ida, queue->queue_id);
>  }
>
> +static int amdgpu_userqueue_map(struct amdgpu_device *adev,
> +                    struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct mes_add_queue_input queue_input;
> +
> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +    queue_input.process_va_start = 0;
> +    queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
> +    queue_input.process_quantum = 100000; /* 10ms */
> +    queue_input.gang_quantum = 10000; /* 1ms */
> +    queue_input.paging = false;
> +
> +    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
> +    queue_input.process_context_addr = queue->proc_ctx.gpu_addr;
> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +
> +    queue_input.process_id = queue->pasid;
> +    queue_input.queue_type = queue->queue_type;
> +    queue_input.mqd_addr = queue->mqd_gpu_addr;
> +    queue_input.wptr_addr = queue->wptr_gpu_addr;
> +    queue_input.queue_size = queue->queue_size >> 2;
> +    queue_input.doorbell_offset = queue->doorbell_index;
> +    queue_input.page_table_base_addr =  queue->vm->pd_phys_addr;
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +    amdgpu_mes_unlock(&adev->mes);
> +    if (r) {
> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +        return r;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
> +    return 0;
> +}
> +
> +static void amdgpu_userqueue_unmap(struct amdgpu_device *adev,
> +                    struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    struct mes_remove_queue_input queue_input;
> +
> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +    queue_input.doorbell_offset = queue->doorbell_index;
> +    queue_input.gang_context_addr = queue->gang_ctx.gpu_addr;
> +
> +    amdgpu_mes_lock(&adev->mes);
> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +    amdgpu_mes_unlock(&adev->mes);
> +
> +    if (r) {
> +        DRM_ERROR("Failed to unmap usermode queue %d\n", queue->queue_id);
> +        return;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Usermode queue %d unmapped\n", queue->queue_id);
> +}
> +
>  static int
>  amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
>                      struct amdgpu_usermode_queue *queue)
> @@ -338,12 +399,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>          goto free_mqd;
>      }
>
> +    r = amdgpu_userqueue_map(adev, queue);
> +    if (r < 0) {
> +        DRM_ERROR("Failed to map queue\n");
> +        goto free_ctx;
> +    }
> +
>      ctx->userq = queue;
>      args->out.q_id = queue->queue_id;
>      args->out.flags = 0;
>      mutex_unlock(&adev->userq.userq_mutex);
>      return 0;
>
> +free_ctx:
> +    amdgpu_userqueue_free_context(adev, queue);
> +
>  free_mqd:
>      amdgpu_userqueue_destroy_mqd(queue);
>
> @@ -362,6 +432,7 @@ void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
>      struct amdgpu_usermode_queue *queue = ctx->userq;
>
>      mutex_lock(&adev->userq.userq_mutex);
> +    amdgpu_userqueue_unmap(adev, queue);
>      amdgpu_userqueue_free_context(adev, queue);
>      amdgpu_userqueue_destroy_mqd(queue);
>      amdgpu_userqueue_remove_index(adev, queue);
> --
> 2.34.1
>
