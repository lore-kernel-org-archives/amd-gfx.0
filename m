Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A07D58D64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 16:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852AB10E16C;
	Mon, 25 Nov 2024 16:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ga2dwVQf";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC15710E16C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 16:16:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D9697A4182D;
 Mon, 25 Nov 2024 16:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC6DC4CECE;
 Mon, 25 Nov 2024 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732551393;
 bh=8/5pSb/RkwbqTCCenytnJsvN570KrEkV/xZR5/E9bxw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ga2dwVQfmDIeHZo6gF4hC+uXKxxvMTDiZYork4t+NcLHx9DqzcBypqJTj6lXYrdkj
 Hy4A3/uAy+qYoBncKyUX8ysc4swXMo3n4SZ9ICY38gh7VhZHxEwGFV1dRQv52q6pAg
 90lqRC0RY1x7YybJQdTyeANISYA0AspSM6feL03dQrO6qLaYImKRbf67zGGB8uQTpU
 t5pYlgbsEVRL9/5OXcj2dcXwV8rc/zqGy7GUsxpglmeANz1fHM2gOGEbcVc1G+4QQr
 XCdrvZvgZaOZtamCiFEciacYxZPRLkwMpaI5rSha2YCrSagFwGFnR1YqxPXUQ76c+L
 vRmUXpeKqTr1w==
Message-ID: <4c939f50-a1c0-4476-9a16-ced6e6102aa2@kernel.org>
Date: Mon, 25 Nov 2024 10:16:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241124190001.2633591-1-superm1@kernel.org>
 <20241124190001.2633591-2-superm1@kernel.org>
 <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
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



On 11/25/24 08:59, Lazar, Lijo wrote:
> 
> 
> On 11/25/2024 12:30 AM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
>> In order to make suspend/resume more reliable we moved this into
>> the pmops prepare() callback so that the suspend sequence would fail
>> but the system could remain operational under high memory usage suspend.
>>
>> Another class of issues exist though where due to memory fragementation
>> there isn't a large enough contiguous space and swap isn't accessible.
>>
>> Add support for a suspend/hibernate notification callback that could
>> evict VRAM before tasks are frozen. This should allow paging out to swap
>> if necessary.
>>
>> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4:
>>   * Make non fatal, drop patch 3
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d8bc6da500161..79ec4ab8ecfc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -879,6 +879,7 @@ struct amdgpu_device {
>>   	bool				need_swiotlb;
>>   	bool				accel_working;
>>   	struct notifier_block		acpi_nb;
>> +	struct notifier_block		pm_nb;
>>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>>   	struct debugfs_blob_wrapper     debugfs_discovery_blob;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 996e9c78384dd..56510ab4b6650 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -191,6 +191,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>>   }
>>   
>>   static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>> +				     void *data);
>>   
>>   /**
>>    * DOC: pcie_replay_count
>> @@ -4553,6 +4555,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   
>>   	amdgpu_device_check_iommu_direct_map(adev);
>>   
>> +	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>> +	r = register_pm_notifier(&adev->pm_nb);
>> +	if (r)
>> +		goto failed;
>> +
>>   	return 0;
>>   
>>   release_ras_con:
>> @@ -4617,6 +4624,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>   		drain_workqueue(adev->mman.bdev.wq);
>>   	adev->shutdown = true;
>>   
>> +	unregister_pm_notifier(&adev->pm_nb);
>> +
>>   	/* make sure IB test finished before entering exclusive mode
>>   	 * to avoid preemption on IB test
>>   	 */
>> @@ -4748,6 +4757,42 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>   /*
>>    * Suspend & resume.
>>    */
>> +/**
>> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
>> + * @nb: notifier block
>> + * @mode: suspend mode
>> + * @data: data
>> + *
>> + * This function is called when the system is about to suspend or hibernate.
>> + * It is used to evict resources from the device before the system goes to
>> + * sleep while there is still access to swap.
>> + */
>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>> +				     void *data)
>> +{
>> +	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
>> +	int r;
>> +
>> +	switch (mode) {
>> +	case PM_HIBERNATION_PREPARE:
>> +		adev->in_s4 = true;
>> +		fallthrough;
> 
> Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> 
> What if this callback takes care only of suspend case and leaves the
> hibernate case to dpm_prepare callback?

Then hibernate would fail under memory pressure.

My take is this failure with hibernate is a userspace problem (whether 
userspace decides to freeze the tasks or not).  I think it's better that 
we /try/ to do the eviction and notify them if userspace should be changed.

> 
> Thanks,
> Lijo
>> +	case PM_SUSPEND_PREPARE:
>> +		r = amdgpu_device_evict_resources(adev);
>> +		adev->in_s4 = false;
>> +		/*
>> +		 * This is considered non-fatal at thie time because
>> +		 * amdgpu_device_prepare() will also evict resources.
>> +		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>> +		 */
>> +		if (r)
>> +			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur\n");
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
>> +
>>   /**
>>    * amdgpu_device_prepare - prepare for device suspend
>>    *
> 

