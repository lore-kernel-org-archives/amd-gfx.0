Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633C1CAC59F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 23:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CA810E08F;
	Wed, 17 Sep 2025 23:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WIvcyFGQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A039510E08F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 23:23:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BC82B60055;
 Wed, 17 Sep 2025 23:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A6FC4CEF9;
 Wed, 17 Sep 2025 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758151404;
 bh=xOdC6MgoshnIDaIwELa8aY2fMHJCvJWbMaDqVUIkRvk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=WIvcyFGQaKNjXCCGXRB+NUlO7oP7r01gBqdamvNzMPJ/G8uaORiLR3N1WZPzuyl5j
 VcJHf5pK42rGz2kZqrq4+XtAqkQPIwdT2ioCsUKwiqwJ3Spo8l9qXkS9POk0WP7AXH
 NTN+PcltdL2UgrhBUTxpbyiJJ6i1hjS7AoEgaCFjhJUGrM5OKX/N3DqTa6zRQVYJkg
 M4ir0dfhPx7Uydhv7/oRE4RuyyEiBzUTL+gjH15j5Epo+v3F8T/gXy+L8d1HJTv8D5
 ENqdya/CfJOKyX6gotx2DDDGPoz9O8+FJD3JGCfj6PKlp8I1BfeEuQ8qSd1FuOv2a0
 eqXFEpKRFeNFA==
Message-ID: <839f762a-b345-456f-a438-37bef80142ab@kernel.org>
Date: Wed, 17 Sep 2025 18:23:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: add proper handling for S0ix
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917164211.1761304-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250917164211.1761304-1-alexander.deucher@amd.com>
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



On 9/17/25 11:42 AM, Alex Deucher wrote:
> When in S0i3, the GFX state is retained, so all we need to do
> is stop the runlist so GFX can enter gfxoff.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Confirmed this doesn't run into the problem we hit with GFX10 on my 
attempt.  Also it fixes the problem properly on GFX11.

For all 3 patches:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-By: David Perry <david.perry@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 36 ++++++++++++++++++++++
>   3 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index fbe7616555c83..a2879d2b7c8ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -250,16 +250,24 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc)
>   {
> -	if (adev->kfd.dev)
> -		kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
> +	if (adev->kfd.dev) {
> +		if (adev->in_s0ix)
> +			kgd2kfd_stop_sched_all_nodes(adev->kfd.dev);
> +		else
> +			kgd2kfd_suspend(adev->kfd.dev, suspend_proc);
> +	}
>   }
>   
>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc)
>   {
>   	int r = 0;
>   
> -	if (adev->kfd.dev)
> -		r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
> +	if (adev->kfd.dev) {
> +		if (adev->in_s0ix)
> +			r = kgd2kfd_start_sched_all_nodes(adev->kfd.dev);
> +		else
> +			r = kgd2kfd_resume(adev->kfd.dev, resume_proc);
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 127927b16ee29..9e120c934cc17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -428,7 +428,9 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
>   int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd);
>   void kgd2kfd_unlock_kfd(struct kfd_dev *kfd);
>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
> +int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd);
>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
> +int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd);
>   bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
>   bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entry *entry,
>   			       bool retry_fault);
> @@ -518,11 +520,21 @@ static inline int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return 0;
>   }
>   
> +static inline int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd)
> +{
> +	return 0;
> +}
> +
>   static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	return 0;
>   }
>   
> +static inline int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd)
> +{
> +	return 0;
> +}
> +
>   static inline bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	return false;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7e749f9b6d69d..349c351e242b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1550,6 +1550,25 @@ int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return ret;
>   }
>   
> +int kgd2kfd_start_sched_all_nodes(struct kfd_dev *kfd)
> +{
> +	struct kfd_node *node;
> +	int i, r;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
> +	for (i = 0; i < kfd->num_nodes; i++) {
> +		node = kfd->nodes[i];
> +		r = node->dqm->ops.unhalt(node->dqm);
> +		if (r) {
> +			dev_err(kfd_device, "Error in starting scheduler\n");
> +			return r;
> +		}
> +	}
> +	return 0;
> +}
> +
>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	struct kfd_node *node;
> @@ -1567,6 +1586,23 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return node->dqm->ops.halt(node->dqm);
>   }
>   
> +int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd)
> +{
> +	struct kfd_node *node;
> +	int i, r;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
> +	for (i = 0; i < kfd->num_nodes; i++) {
> +		node = kfd->nodes[i];
> +		r = node->dqm->ops.halt(node->dqm);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}
> +
>   bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	struct kfd_node *node;

