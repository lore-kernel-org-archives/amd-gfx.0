Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8770EC5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1232C10E360;
	Fri, 21 Aug 2026 21:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FR2BxfOH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7206C10E360
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A3D54043F;
 Fri, 21 Aug 2026 21:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51BA1F000E9;
 Fri, 21 Aug 2026 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787347863;
 bh=XJSikWnYeMz65Yz2KAou5c+gz8kaYArZ/FW1jEjAsCw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FR2BxfOHO51/YHCtLjCkXCxwFuX1RBJYJPaVSQyVLKCl3w/HZDCfMl8CPUPWHChGl
 RwTZXz48RHEfQxXGndEdm3B+Py+suoOvYEEnHcGlAWPr6UsCp8PQHakIFI+nx8sWxM
 REdEX/vjVlXfvpVHpamRm+mVC1HT9qHluslk4vnywJ8X8bGFMXS1UT4EQ854XCAygA
 Yu7ubayvAnYA8eTH5IvcCEdu9uzTjSKLHJSLuipsCYteLG+ec81gWOy3rki1HExTAf
 3Sxg6u3nby3Uhf6yX0pbWTzeeAQB4IxMA7W+5TDoyIex+dvCDG5Ei4O0j3XIniGF4H
 2+lf+J5GqTkJg==
Message-ID: <478cee51-9b47-406e-9993-a116584afca5@kernel.org>
Date: Fri, 21 Aug 2026 16:31:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: workaround 100% gpu usage issue for gfx11
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tishko.Araz@amd.com, Alexander.Deucher@amd.com
References: <20260819201443.282689-1-jinhuieric.huang@amd.com>
 <20260819201443.282689-2-jinhuieric.huang@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260819201443.282689-2-jinhuieric.huang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/19/26 15:14, Eric Huang wrote:
> the issue only happens with oversubscription when gpu has no
> workload, the root cause is mes oversubscription timer, so
> disable mes timer and make a similar timer in kfd to resolve
> the issue.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 -
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 ++++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
>   3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index df71e9447b35..33ff1afd7c4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1024,7 +1024,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
>   	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>   	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
> -	mes_set_hw_res_pkt.oversubscription_timer = 50;
>   	if (adev->mes.use_rs64mem)
>   		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..45e039c9f31b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -47,6 +47,9 @@
>   /* See unmap_queues_cpsch() */
>   #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>   
> +/* Interval for notifying MES of work on unmapped queues during oversubscription */
> +#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
> +
>   static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>   				  u32 pasid, unsigned int vmid);
>   
> @@ -276,8 +279,16 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			q->properties.doorbell_off);
>   		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
> +		return r;
>   	}
>   
> +	/* GFX11: start notify timer only once when oversubscription begins */
> +	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
> +	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
> +		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +
>   	return r;
>   }
>   
> @@ -354,7 +365,16 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
>   static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd)
>   {
> -	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
> +	int r = remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
> +
> +	/* GFX11: stop notify timer when oversubscription clears */
> +	if (!r &&
> +	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
> +	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +	    dqm->active_cp_queue_count <= get_cp_queues_num(dqm))
> +		cancel_delayed_work(&dqm->notify_unmap_work);
> +
> +	return r;
>   }
>   
>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
> @@ -3194,6 +3214,20 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
>   	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
>   }
>   
> +static void mes_notify_unmap_work_handler(struct work_struct *work)
> +{
> +	struct device_queue_manager *dqm =
> +		container_of(work, struct device_queue_manager,
> +			     notify_unmap_work.work);
> +
> +	amdgpu_mes_notify_unmap_queue((struct amdgpu_device *)dqm->dev->adev);
> +
> +	/* Re-arm if still oversubscribed */
> +	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
> +		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +}
> +
>   struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   {
>   	struct device_queue_manager *dqm;
> @@ -3319,6 +3353,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   
>   	if (!dqm->ops.initialize(dqm)) {
>   		init_waitqueue_head(&dqm->destroy_wait);
> +		INIT_DELAYED_WORK(&dqm->notify_unmap_work,
> +				  mes_notify_unmap_work_handler);
>   		return dqm;
>   	}
>   
> @@ -3335,6 +3371,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   
>   void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   {
> +	cancel_delayed_work_sync(&dqm->notify_unmap_work);
>   	dqm->ops.stop(dqm);
>   	dqm->ops.uninitialize(dqm);
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c9f9f7a87111..21cf3c16f3f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -281,6 +281,7 @@ struct device_queue_manager {
>   	uint32_t		wait_times;
>   
>   	wait_queue_head_t	destroy_wait;
> +	struct delayed_work	notify_unmap_work;
>   
>   	/* for per-queue reset support */
>   	struct dqm_detect_hang_info *detect_hang_info;

