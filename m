Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1C2C61DC4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 15:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB8210E16A;
	Thu, 27 Aug 2026 15:26:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GvV+v7YR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3C610E16A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 15:26:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E9B542B65;
 Thu, 27 Aug 2026 15:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D641F000E9;
 Thu, 27 Aug 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787844417;
 bh=4H7wGG5QgIZdGltkiS9ApGE59L0WR1V9CaOllKeLJ7Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GvV+v7YRphCSTSgj11TX3IQ9UDcBX+7vVHb9GTmRX/+ig+bRXqK/YW+Xc2v5/hnJ0
 7N3BW/gv660kEuBfYTmoOCecPrALiwHGBiVOpddDDeS7/Lgxo2efX5Xarum3z4avvu
 aAcK3ILi89geeHt1A5fGcG7NL8XGJJLwIKHOuL3EMTGaWNDiVbcRZoRk4xXsV88XuV
 +4DBGBzDpVD4y/HX5RABWdrhpf8P1k6NcQ/es/BL/gKcGrGIX6VZ8y4t9McHfYcpvO
 XJOqR+uvlXJplqZaSGYrZDrGeBH4zlIm7M8BsjLMZM7mLRAJ4PWY3u6PeK6TO4CHH6
 hztZk8YxwYxCg==
Message-ID: <acda7232-5174-4c16-b165-8dd7e4a8d693@kernel.org>
Date: Thu, 27 Aug 2026 10:26:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix oversubscription timer for sr-iov
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tishko.Araz@amd.com
References: <20260827151345.83133-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260827151345.83133-1-jinhuieric.huang@amd.com>
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

On 8/27/26 10:13 AM, Eric Huang wrote:
> The KFD/userq software oversubscription-notify timers added to
> replace GFX11 MES firmware's oversubscription_timer call
> amdgpu_mes_notify_unmap_queue(), which takes mes->mutex_hidden,
> the same lock add/remove_hw_queue() use. Under SR-IOV this call
> can block up to 9s (vs 2.1s bare metal), so MES round-trip latency
> goes up (world-switch contention) it stalls re-mapping queues
> and times out KFDQMTest.AllCpQueues.
> 
> Keep the firmware timer enabled for SR-IOV VFs and skip the
> software timers there; the issue this works around is bare-metal
> only.
> 
> fixes: "drm/amdkfd: workaround 100% gpu usage issue for gfx11"
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                |  9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++++++--
>   3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5cf1bb1c2085..e5f8a81c3a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1208,6 +1208,9 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>    */
>   void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
>   {
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
>   	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
>   		return;
> @@ -1224,6 +1227,9 @@ void amdgpu_mes_userq_queue_mapped(struct amdgpu_device *adev)
>    */
>   void amdgpu_mes_userq_queue_unmapped(struct amdgpu_device *adev)
>   {
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
>   	if (!(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
>   	      amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0)))
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 33ff1afd7c4c..c81e4b8616d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1024,6 +1024,15 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
>   	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>   	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
> +	/*
> +	 * Bare metal: disabled here, KFD arms a software replacement only
> +	 * while oversubscribed (see kfd_device_queue_manager.c). SR-IOV
> +	 * guests keep the firmware timer instead of the KFD-side one, since
> +	 * the notify round-trip is much slower under SR-IOV and would
> +	 * otherwise stall remapping queues.
> +	 */
> +	if (amdgpu_sriov_vf(adev))
> +		mes_set_hw_res_pkt.oversubscription_timer = 50;
>   	if (adev->mes.use_rs64mem)
>   		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b37aed34a72c..f37bfeeb4bf4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -282,8 +282,15 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   		return r;
>   	}
>   
> -	/* GFX11: start notify timer only once when oversubscription begins */
> -	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
> +	/*
> +	 * GFX11: start notify timer only once when oversubscription begins.
> +	 * Skip under SR-IOV: MES round-trips are far slower there, and this
> +	 * notify call shares mes->mutex_hidden with add/remove_hw_queue, so
> +	 * a slow notify can stall remapping queues. SR-IOV guests keep MES's
> +	 * own firmware oversubscription timer instead.
> +	 */
> +	if (!amdgpu_sriov_vf(adev) &&
> +	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
>   	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
>   	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
>   		queue_delayed_work(system_wq, &dqm->notify_unmap_work,

