Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FF0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 17:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34BF10E403;
	Thu, 29 Dec 2022 17:50:30 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA1010E403
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 17:50:28 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 k44-20020a9d19af000000b00683e176ab01so6924926otk.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aLoUsOM3ohrRMpBOHATn2o30HpEHHKp1jNzp/iXdgrk=;
 b=HD9A3lNHO/XK6dUmEj8czURrPcBJInzFMosF1cksHORS0j7JOhPJFP8j9zHwNL7bxD
 BzkvJZqc87wtXE1WqXS+6giZSdknUkemfTbNnZes45ovmfT8UUrtdUZ+uQ7CiEL/gBrv
 rfdf6OOswFZQNjW7HF11I4JqDSRpHPqLHCezIcDDD9XU9u0JqHZjkdGpv0bSNz5iCJdN
 mNQ5iVWRJqU6CsC7AWNOL3M0lsD8OzpQvNbllKOHYeUDQQLX70eZBrg9uDObnCjRiakt
 xPMLd2huUvnYS+omSURE3OcU8U2YPddUZUNPoAnAWCrrsv7t8Ie89Yne630ce7ngG4cJ
 GSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLoUsOM3ohrRMpBOHATn2o30HpEHHKp1jNzp/iXdgrk=;
 b=3INkClfdStg2jxQaWQ4jElP4GUG7WOZkdd4o0MXZkwbXwPkU5ICjqOyaNgGD40KgOD
 asxV+gUolY2lX/lXnrPdvdvAOxbjFmI09K5r8tR0eJPcHvbavwNN0kK3Imw9yGOV1On/
 QWoQnP39tpF+YV5Y8dKVqnxPkjjzLgM48LqznmuohFSdOzFPcvKpXZroja4Cx4OyCNB0
 f6DRwsM+8e9CKJ6ncMRwOFLrlC9WaEW4Z8d0UhFL0xQVgbJf3n7/+7WlBTNQSuIqk3ZK
 MTgCp1ql3zj1penNhsNfKXYJANgppdgIJxFYX2gZqx2kdViU3kGwYpifyQHkdhOW2iAS
 +cYg==
X-Gm-Message-State: AFqh2krTMi69GMl5IXgdYeg0Jju7mgZQ3viwnYiYd4ZmlkJpk00wD4zA
 9Ze9qb8DbJsjie+/4gv6JXtt7U4ZxbZ/fXeaUaQ=
X-Google-Smtp-Source: AMrXdXtOeWMPNfN0I0LWKn/rhYXM/tNzsOAW8A9QliRYtBFZsrZYO5buybogP9ZiIre6GMdRRtRi8ePA3A13TQetFmU=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr1950746otk.123.1672336228178; Thu, 29
 Dec 2022 09:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-5-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-5-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Dec 2022 12:50:15 -0500
Message-ID: <CADnq5_MLC5++t1GDsAXwKAXDuqTDk-RJHr5BCL0PKSfCOG4woQ@mail.gmail.com>
Subject: Re: [RFC 4/7] drm/amdgpu: Allocate doorbell slot for user queue
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
> This patch allocates a doorbell slot in the bar, for the usermode queue.
> We are using the unique queue-id to get this slot from MES.

We should manage the doorbell BAR just like VRAM.  I had a set of
patches to convert doorbell memory to GEM objects.  The user should be
able to allocate doorbell memory via the GEM IOCTL just like VRAM or
GTT.  Then when the user calls the USERQ IOCTL, we can just look up
the GEM object from the handle and then calculate the doorbell offset
based on the offset of the GEM object from the start of the BAR.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index a91cc304cb9e..b566ce4cb7f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -50,6 +50,25 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
>      ida_simple_remove(&uqg->ida, queue->queue_id);
>  }
>
> +static int
> +amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
> +                    struct amdgpu_usermode_queue *queue)
> +{
> +    int r;
> +    unsigned int doorbell_index;
> +
> +    r = amdgpu_mes_alloc_process_doorbells(adev, &doorbell_index);
> +       if (r < 0) {
> +        DRM_ERROR("Failed to allocate doorbell for user queue\n");
> +        return r;
> +    }
> +
> +    /* We are using qnique queue-id to get doorbell here */
> +    queue->doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
> +                           doorbell_index, queue->queue_id);
> +    return 0;
> +}
> +
>  static void
>  amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
>  {
> @@ -257,12 +276,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>          goto free_queue;
>      }
>
> +    r = amdgpu_userqueue_get_doorbell(adev, queue);
> +    if (r) {
> +        DRM_ERROR("Failed to create doorbell for queue\n");
> +        goto free_mqd;
> +    }
> +
>      ctx->userq = queue;
>      args->out.q_id = queue->queue_id;
>      args->out.flags = 0;
>      mutex_unlock(&adev->userq.userq_mutex);
>      return 0;
>
> +free_mqd:
> +    amdgpu_userqueue_destroy_mqd(queue);
> +
>  free_queue:
>      amdgpu_userqueue_remove_index(adev, queue);
>      mutex_unlock(&adev->userq.userq_mutex);
> --
> 2.34.1
>
