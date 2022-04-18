Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757C3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 20:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B830810E1C4;
	Mon, 18 Apr 2022 20:23:18 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C3510E1C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 20:23:17 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae91b.dynamic.kabel-deutschland.de
 [95.90.233.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C70A61CCD785;
 Mon, 18 Apr 2022 22:23:15 +0200 (CEST)
Message-ID: <568532d5-e127-2d39-a455-e4102ab240b2@molgen.mpg.de>
Date: Mon, 18 Apr 2022 22:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/2] drm/amdkfd: CRIU add support for GWS queues
Content-Language: en-US
To: David Yat Sin <david.yatsin@amd.com>
References: <20220418164437.1875319-1-david.yatsin@amd.com>
 <20220418164437.1875319-2-david.yatsin@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220418164437.1875319-2-david.yatsin@amd.com>
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
Cc: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear David,


Thank you for your patch.

Am 18.04.22 um 18:44 schrieb David Yat Sin:

In the commit message summary, you could reorder some words:

Add CRIU support for GWS queues

> Adding support to checkpoint/restore GWS(Global Wave Sync) queues.

s/Adding/Add/

Please add a space before the (.

How can this be tested?

> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10 +++++++---
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f36062be9ca8..192dbef04c43 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1102,7 +1102,7 @@ struct kfd_criu_queue_priv_data {
>   	uint32_t priority;
>   	uint32_t q_percent;
>   	uint32_t doorbell_id;
> -	uint32_t is_gws;
> +	uint32_t gws;

Why is the new name better?

>   	uint32_t sdma_id;
>   	uint32_t eop_ring_buffer_size;
>   	uint32_t ctx_save_restore_area_size;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6eca9509f2e3..4f58e671d39b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -636,6 +636,8 @@ static int criu_checkpoint_queue(struct kfd_process_device *pdd,
>   	q_data->ctx_save_restore_area_size =
>   		q->properties.ctx_save_restore_area_size;
>   
> +	q_data->gws = !!q->gws;
> +
>   	ret = pqm_checkpoint_mqd(&pdd->process->pqm, q->properties.queue_id, mqd, ctl_stack);
>   	if (ret) {
>   		pr_err("Failed checkpoint queue_mqd (%d)\n", ret);
> @@ -743,7 +745,6 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>   					  struct kfd_criu_queue_priv_data *q_data)
>   {
>   	qp->is_interop = false;
> -	qp->is_gws = q_data->is_gws;
>   	qp->queue_percent = q_data->q_percent;
>   	qp->priority = q_data->priority;
>   	qp->queue_address = q_data->q_address;
> @@ -826,12 +827,15 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
> -		ret = -EINVAL;
> +		goto exit;
>   	}
>   
> +	if (q_data->gws)
> +		ret = pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
> +
>   exit:
>   	if (ret)
> -		pr_err("Failed to create queue (%d)\n", ret);
> +		pr_err("Failed to restore queue (%d)\n", ret);

Maybe separate this out, so it can be applied to stable series.

>   	else
>   		pr_debug("Queue id %d was restored successfully\n", queue_id);
>   


Kind regards,

Paul
