Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED44D5E15A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 14:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D38E010E08B;
	Tue, 16 Dec 2025 14:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rbsGbX9+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D85210E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 14:01:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CE516001D;
 Tue, 16 Dec 2025 14:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2D3C4CEF1;
 Tue, 16 Dec 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765893708;
 bh=SAiEKQh5M+gIj663qxXoAI/67pgPrbsleZ7Tv7B7afw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rbsGbX9+j6qM0HXxCJQAeUCH2NrJbLI9PI4laHLv4s0jAZXF9cL8mOfImwyfPIXPc
 VkYxqqSkP2/To3OXFZUdpQrqo5I+bokCaCQFnULfxxFhs4B1aOIwTsqSuTIdyHIb5O
 cATQIF0l1JCuM/U0qgn5UdQLF1yN0e021tA0O8Y49xr45QN241C5JD9z50j+sia+Xc
 P3hllqbH589LDAFN1V6XWvXSKPvjNuKs4V5Xd5mA0eKvQejqYbJFPEvnmTktQOY2+T
 zbzJ0B7VpowpFr8/MG8NI5jRXJVT5WBLNINGuN94TWlCgCQTEpV4ER7FRAdJXodADA
 beAJQ2iMBtSdg==
Message-ID: <c5936dfc-216d-48c4-863e-dd2b446cbd34@kernel.org>
Date: Tue, 16 Dec 2025 08:01:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] amdkfd: Add device links between kfd device and
 amdgpu device
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20251216060046.3131-1-superm1@kernel.org>
 <20251216060046.3131-3-superm1@kernel.org>
 <3dc170db-c7d3-4818-9fe3-5981aa03cf42@amd.com>
 <173943ab-3c7a-4e32-9d7d-a7d0973aa6be@kernel.org>
 <b75ee437-7ad3-4dd3-85da-bff838d9c175@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <b75ee437-7ad3-4dd3-85da-bff838d9c175@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/16/25 6:40 AM, Lazar, Lijo wrote:
> 
> 
> On 16-Dec-25 5:49 PM, Mario Limonciello wrote:
>>
>>
>> On 12/16/25 12:22 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 16-Dec-25 11:30 AM, Mario Limonciello (AMD) wrote:
>>>> Mapping out a KFD device to a GPU can be done manually by looking at 
>>>> the
>>>> domain and location properties.  To make it easier to discover which
>>>> KFD device goes with what GPU add a link to the GPU node.
>>>>
>>>
>>> Access to the full device is not desirable in container environments 
>>> where it is restricted to the particular partition's properties.
>>>
>>
>> Container environments don't typically bind mount the whole sysfs tree 
>> do they?
>>
> 
> AFAIK, only selected ones and access restricted through cgroups.

The information needed to discover is definitely already exposed.

❯ cat /sys/class/kfd/kfd/topology/nodes/1/properties | grep 
"domain\|location_id\|vendor_id\|device_id"
vendor_id 4098
device_id 5510
location_id 49664
domain 0

But so what's going to happen with the new symlink then?  Would cgroups 
export it if the device it points to wasn't exported?

I'm not sure how to try this myself.
> 
> Thanks,
> Lijo
> 
>> Nonetheless; even if they did this information is already 
>> discoverable, it's just a PIA to get to.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>> Cc: Harish.Kasiviswanathan@amd.com>
>>>> v3:
>>>>   * Create link when topology created
>>>>   * Only call update topology when amdgpu is called
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |  8 ++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c       | 17 +++++++++++++ 
>>>> +++-
>>>>   drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
>>>>   5 files changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/ 
>>>> gpu/ drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index 67a01c4f38855..870a727d6e938 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct 
>>>> amdgpu_device *adev, uint32_t xcp_id,
>>>>       return r;
>>>>   }
>>>> +
>>>> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
>>>> +{
>>>> +    if (!adev->kfd.init_complete || !adev->kfd.dev)
>>>> +        return 0;
>>>> +
>>>> +    return kfd_topology_update_sysfs();
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/ 
>>>> gpu/ drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index 8bdfcde2029b5..07aa519b28d45 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -268,6 +268,7 @@ int amdgpu_amdkfd_stop_sched(struct 
>>>> amdgpu_device *adev, uint32_t node_id);
>>>>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, 
>>>> uint32_t xcp_id,
>>>>       bool core_override_enable, bool reg_override_enable, bool 
>>>> perfmon_override_enable);
>>>>   bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, 
>>>> uint32_t node_id);
>>>> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
>>>>   /* Read user wptr from a specified user address space with page fault
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/ 
>>>> gpu/ drm/amd/amdgpu/amdgpu_device.c
>>>> index 467326871a81e..d4c8b03b6bf57 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5123,6 +5123,10 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>        */
>>>>       r = amdgpu_device_sys_interface_init(adev);
>>>> +    r = amdgpu_amdkfd_create_sysfs_links(adev);
>>>> +    if (r)
>>>> +        dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n", 
>>>> r);
>>>> +
>>>>       if (IS_ENABLED(CONFIG_PERF_EVENTS))
>>>>           r = amdgpu_pmu_init(adev);
>>>>       if (r)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/ 
>>>> gpu/ drm/amd/amdkfd/kfd_topology.c
>>>> index a95be23fd0397..5f14c66902f9d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>>> @@ -571,6 +571,9 @@ static void kfd_remove_sysfs_node_entry(struct 
>>>> kfd_topology_device *dev)
>>>>       struct kfd_mem_properties *mem;
>>>>       struct kfd_perf_properties *perf;
>>>> +    if (dev->gpu)
>>>> +        sysfs_remove_link(dev->kobj_node, "device");
>>>> +
>>>>       if (dev->kobj_iolink) {
>>>>           list_for_each_entry(iolink, &dev->io_link_props, list)
>>>>               if (iolink->kobj) {
>>>> @@ -819,6 +822,18 @@ static int kfd_build_sysfs_node_entry(struct 
>>>> kfd_topology_device *dev,
>>>>               return ret;
>>>>       }
>>>> +    /*
>>>> +     * create a link to the GPU node, but don't do a reverse one 
>>>> since it might
>>>> +     * not match after spatial partitioning
>>>> +     */
>>>> +    if (dev->gpu) {
>>>> +        struct kobject *amdgpu_kobj = &dev->gpu->adev->dev->kobj;
>>>> +
>>>> +        ret = sysfs_create_link(dev->kobj_node, amdgpu_kobj, 
>>>> "device");
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>>       return 0;
>>>>   }
>>>> @@ -848,7 +863,7 @@ static void kfd_remove_sysfs_node_tree(void)
>>>>           kfd_remove_sysfs_node_entry(dev);
>>>>   }
>>>> -static int kfd_topology_update_sysfs(void)
>>>> +int kfd_topology_update_sysfs(void)
>>>>   {
>>>>       int ret;
>>>> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/ 
>>>> drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>>> index 9aba8596faa7e..0ee1a7d3a73f5 100644
>>>> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>>> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>>>> @@ -335,4 +335,6 @@ struct kfd2kgd_calls {
>>>>                         int engine, int queue);
>>>>   };
>>>> +int kfd_topology_update_sysfs(void);
>>>> +
>>>>   #endif    /* KGD_KFD_INTERFACE_H_INCLUDED */
>>>
>>
> 

