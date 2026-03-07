Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A353FC9ED5
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Mar 2026 12:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB76010E056;
	Sat,  7 Mar 2026 12:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGgFYbyf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ED710E056
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Mar 2026 12:49:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C4E5160018;
 Sat,  7 Mar 2026 12:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A08C19422;
 Sat,  7 Mar 2026 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772887784;
 bh=k8xfCD9rVlJY94CGu8kgECgIl/xLpySWM6qrg2DeC5A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WGgFYbyfUP8GhCs8dYUsNgPdVRgS0Ir6iRzCGaKXgL0fOaItiYPaQOO9hwoLl+DF3
 IZ32OAnbEylAquD9F1lE8CeUYH27TmwZzuLrYd5PWpseVB9Tant7tTBGL3+eKMnt3U
 5eLl1OxOAXKqzrJqf7mEbPMXUwhLADlMyNHm8PUS+Da1XqPLC4frQDz6cfyN3XlsVm
 ajsjPDutjrzsy737b8GzkmxCzBzagrGh4SP0TAH2mimK/g2Rs73jsNnViMV/ihSvyu
 eiVoW1ZV9gp8cXvnSr9rKdhGDPDs7E5WLOrxWGmt8GrOiuGcc34nZxNGrRn3K00FzC
 03MxpUeDIdvNg==
Message-ID: <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
Date: Sat, 7 Mar 2026 06:49:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Kent Russell <kent.russell@amd.com>, Xiaogang.chen@amd.com
References: <20260112182925.347303-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260112182925.347303-1-mario.limonciello@amd.com>
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



On 1/12/26 12:29 PM, Mario Limonciello wrote:
> When a surprise unplug occurs while a process has active KFD queues,
> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
> properly clean them up. This leads to a WARN_ON in uninitialize()
> complaining about active_queue_count or processes_count being non-zero.
> 
> The issue is that during surprise unplug:
> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
> 2. It calls amdgpu_amdkfd_device_fini_sw()
> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>     dqm->processes_count > 0)
> 
> The warning triggers because the queues were never destroyed - userspace
> had no opportunity to clean them up before the device disappeared.
> 
> Fix this by checking for device unplug in kfd_cleanup_nodes() and
> calling process_termination for each affected process before
> uninitializing the DQM. This mirrors what happens during normal process
> shutdown (kfd_process_notifier_release_internal), ensuring queues are
> properly cleaned up even during surprise removal.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Xiaogang.chen@amd.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Ping?

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 ++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e9cfb80bd436..7727b66e6afb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
>   	flush_workqueue(kfd->ih_wq);
>   	destroy_workqueue(kfd->ih_wq);
>   
> +	/*
> +	 * For surprise unplugs with running processes, we need to clean up
> +	 * queues before uninitializing the DQM to avoid WARN in uninitialize.
> +	 * This handles the case where userspace can't destroy queues normally.
> +	 */
> +	if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
> +		struct kfd_process *p;
> +		unsigned int temp;
> +		int idx;
> +
> +		idx = srcu_read_lock(&kfd_processes_srcu);
> +		hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +			int j;
> +
> +			for (j = 0; j < p->n_pdds; j++) {
> +				struct kfd_process_device *pdd = p->pdds[j];
> +
> +				if (pdd->dev->kfd != kfd)
> +					continue;
> +
> +				dev_info(kfd_device,
> +					 "Terminating queues for process %d on unplugged device\n",
> +					 p->lead_thread->pid);
> +
> +				pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
> +								       &pdd->qpd);
> +				pdd->already_dequeued = true;
> +			}
> +		}
> +		srcu_read_unlock(&kfd_processes_srcu, idx);
> +	}
> +
>   	for (i = 0; i < num_nodes; i++) {
>   		knode = kfd->nodes[i];
>   		device_queue_manager_uninit(knode->dqm);

