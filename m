Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7198FC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0BE10E332;
	Fri, 21 Aug 2026 21:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKQPQByz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FC410E332
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE21F43C27;
 Fri, 21 Aug 2026 21:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DC91F00A3D;
 Fri, 21 Aug 2026 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787347832;
 bh=BEpXL5t3aBjw1SU7dmM85+MqV9pOGUXVSFVK754QK9I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aKQPQByzud6jRcPscuGw88Jibr41a68mZsMefO9aao6ST3TNCGmCBsixVu10Y+lis
 PCCryOqLyw+qAdNjk3w69iVJiCydNDxdPFw8h6lvXqyNPQjjP45dyXJeiG7rfl2pta
 cIW+vIjq96iDMxbyawwR4yVm19Ib5TP600jQ4teqsmhBpiq0uEIcHFGYrQcXkd+p/K
 +fPpoT+iguC+O6qZLngP1b0qFokScvAcK87l3teCQcQg7yVdcR8ZogKq/g2j0gZ1gr
 Ld7uwY7oMkmSRcZ10DWxzMr1evTfQJPPLQLos7/CApYArPB8zpG9Hs0OX6vQ37VJ0e
 oNwWKGaNjIa3A==
Message-ID: <6a149891-1752-4d43-aa78-8573e1503837@kernel.org>
Date: Fri, 21 Aug 2026 16:30:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: add new mes misc api for gfx11
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tishko.Araz@amd.com, Alexander.Deucher@amd.com
References: <20260819201443.282689-1-jinhuieric.huang@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260819201443.282689-1-jinhuieric.huang@amd.com>
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
> new api will be used to workaround a HW scheduler issue
> for 100% usage when gpu has no workload.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 10 +++++++++-
>   3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index b96f94e5169f..421d937c1188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1140,6 +1140,29 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
>   	amdgpu_mes_unlock(mes);
>   }
>   
> +int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
> +{
> +	struct mes_misc_op_input op_input = {0};
> +	int r;
> +
> +	op_input.op = MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		dev_err(adev->dev, "mes notify unmap queue is not supported!\n");
> +		r = -EINVAL;
> +		goto error;
> +	}
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r)
> +		dev_err(adev->dev, "failed to notify unmap queue.\n");
> +
> +error:
> +	return r;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 977c057dcce8..0291ae14a1e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -366,6 +366,7 @@ enum mes_misc_opcode {
>   	MES_MISC_OP_WRM_REG_WR_WAIT,
>   	MES_MISC_OP_SET_SHADER_DEBUGGER,
>   	MES_MISC_OP_CHANGE_CONFIG,
> +	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
>   };
>   
>   struct mes_misc_op_input {
> @@ -643,4 +644,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
>   				    uint32_t *index);
>   void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
>   				    uint32_t index);
> +
> +int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
> +
>   #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c57bcb9a98b1..df71e9447b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -957,7 +957,15 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   		misc_pkt.change_config.option.bits.limit_single_process =
>   				input->change_config.option.limit_single_process;
>   		break;
> -
> +	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
> +		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x70) {
> +			dev_warn_once(mes->adev->dev,
> +				      "MES FW version must be larger than 0x70 to support notify work on unmapped queue.\n");
> +			return 0;
> +		}
> +		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
> +		misc_pkt.queue_sch_level = AMD_PRIORITY_LEVEL_NORMAL;
> +		break;
>   	default:
>   		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
>   		return -EINVAL;

