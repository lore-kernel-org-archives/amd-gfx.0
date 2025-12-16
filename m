Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111C6D5E133
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 12:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A681F10E72C;
	Tue, 16 Dec 2025 12:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ExxmB4Oo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD26210E72C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 12:20:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A279543E45;
 Tue, 16 Dec 2025 12:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF3BC4CEF1;
 Tue, 16 Dec 2025 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765887605;
 bh=BPEkTR/2qZ6HE2o0YSYM2nCsxRQptBfF0jFK9gsVpXc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=ExxmB4OoMlVb0VZH0x2aUnHBpb3MdrelIGbo2efXOWFeT8nBP67He2WtJIK3rjgnT
 aS+JQyW6EJ66wrQRtnJ4sZIA/civ1ELv+hO+TxzTUZPCBewqkKjJXA8Swx607EidZL
 WkSNH+mRvglqgKORx3/139EX6RflQFsgp+EREdIS3SsVoUISOO4JHMfUUnLKmhmI6g
 xwCD0vt+YIElX0Dh622Mcv5N5WzC8Wt0wJBCPvsK/tZaE236pDs0yPxbjgt3DTszsi
 FOdp3BnewmaH6135LZ6/TRQumzCxU5iyJ8exKzp5VmIppG+30mpBBkesT+1kN29Te3
 /Z5+W7J/iGNyQ==
Message-ID: <0845e5b3-eeba-4a32-8fd6-854e6f214c95@kernel.org>
Date: Tue, 16 Dec 2025 06:20:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] amdkfd: Add device links between kfd device and
 amdgpu device
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251210201510.3000-1-superm1@kernel.org>
 <20251210201510.3000-4-superm1@kernel.org>
 <IA0PR12MB76756BAC95FE0BA91AB291AC8CAAA@IA0PR12MB7675.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <IA0PR12MB76756BAC95FE0BA91AB291AC8CAAA@IA0PR12MB7675.namprd12.prod.outlook.com>
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

Thanks.  I've posted a v3 that hopefully addresses this.

On 12/15/25 8:45 PM, Kasiviswanathan, Harish wrote:
> Similar comment to previous patch. Once you do spatial partitioning (like QPX or CPX), there is no one-to-one correspondence between drm node and kfd node. Partitions don't change device node however, you could have multiple (4 or 8) kfd nodes.
> 
> Best Regards,
> Harish
> 
> 
> ________________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Limonciello (AMD) <superm1@kernel.org>
> Sent: Wednesday, December 10, 2025 3:15 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Subject: [PATCH v2 3/3] amdkfd: Add device links between kfd device and amdgpu device
> 
> 
> Mapping out a KFD device to a GPU can be done manually by looking at the
> 
> domain and location properties.  To make it easier to discover which
> 
> KFD device goes with what GPU add bidirectional links.
> 
> 
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> ---
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  8 +++++
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +++
> 
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++++
> 
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 ++
> 
>   5 files changed, 51 insertions(+)
> 
> 
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> 
> index a2879d2b7c8ec..5d6cf3adfa7b8 100644
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> 
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> 
> @@ -910,3 +910,11 @@ int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
> 
>   
> 
>           return r;
> 
>   }
> 
> +
> 
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev)
> 
> +{
> 
> +       if (!adev->kfd.init_complete || !adev->kfd.dev)
> 
> +               return 0;
> 
> +
> 
> +       return kgd2kfd_create_sysfs_links(adev->kfd.dev);
> 
> +}
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> 
> index da4575676335f..fd92b227a674b 100644
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> 
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> 
> @@ -272,6 +272,7 @@ int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_id);
> 
>   int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t xcp_id,
> 
>           bool core_override_enable, bool reg_override_enable, bool perfmon_override_enable);
> 
>   bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
> 
> +int amdgpu_amdkfd_create_sysfs_links(struct amdgpu_device *adev);
> 
>   
> 
>   
> 
>   /* Read user wptr from a specified user address space with page fault
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> 
> index 7a0213a07023d..44c9320d72a56 100644
> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> 
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> 
> @@ -4947,6 +4947,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> 
>            */
> 
>           r = amdgpu_device_sys_interface_init(adev);
> 
>   
> 
> +       r = amdgpu_amdkfd_create_sysfs_links(adev);
> 
> +       if (r)
> 
> +               dev_err(adev->dev, "Failed to create KFD sysfs link: %d\n", r);
> 
> +
> 
>           if (IS_ENABLED(CONFIG_PERF_EVENTS))
> 
>                   r = amdgpu_pmu_init(adev);
> 
>           if (r)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> 
> index b65f29294e2d6..796fd411a7dcc 100644
> 
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> 
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> 
> @@ -79,6 +79,37 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
> 
>           return device;
> 
>   }
> 
>   
> 
> +int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd)
> 
> +{
> 
> +       struct kfd_topology_device *top_dev;
> 
> +       int ret = -ENODEV;
> 
> +
> 
> +       if (!kfd)
> 
> +               return -EINVAL;
> 
> +
> 
> +       down_read(&topology_lock);
> 
> +
> 
> +       list_for_each_entry(top_dev, &topology_device_list, list) {
> 
> +               struct kobject *amdgpu_kobj;
> 
> +
> 
> +               if (!top_dev->gpu || top_dev->gpu->kfd != kfd || !top_dev->kobj_node)
> 
> +                       continue;
> 
> +
> 
> +               amdgpu_kobj = &top_dev->gpu->adev->dev->kobj;
> 
> +               ret = sysfs_create_link(top_dev->kobj_node, amdgpu_kobj, "device");
> 
> +               if (ret)
> 
> +                       break;
> 
> +
> 
> +               ret = sysfs_create_link(amdgpu_kobj, top_dev->kobj_node, "kfd");
> 
> +               if (ret)
> 
> +                       sysfs_remove_link(top_dev->kobj_node, "device");
> 
> +               break;
> 
> +       }
> 
> +
> 
> +       up_read(&topology_lock);
> 
> +       return ret;
> 
> +}
> 
> +
> 
>   struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
> 
>   {
> 
>           struct kfd_topology_device *top_dev = NULL;
> 
> @@ -571,6 +602,11 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
> 
>           struct kfd_mem_properties *mem;
> 
>           struct kfd_perf_properties *perf;
> 
>   
> 
> +       if (dev->gpu) {
> 
> +               sysfs_remove_link(dev->kobj_node, "device");
> 
> +               sysfs_remove_link(&dev->gpu->adev->dev->kobj, "kfd");
> 
> +       }
> 
> +
> 
>           if (dev->kobj_iolink) {
> 
>                   list_for_each_entry(iolink, &dev->io_link_props, list)
> 
>                           if (iolink->kobj) {
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> 
> index 9aba8596faa7e..f6db1dc634399 100644
> 
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> 
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> 
> @@ -335,4 +335,6 @@ struct kfd2kgd_calls {
> 
>                                             int engine, int queue);
> 
>   };
> 
>   
> 
> +int kgd2kfd_create_sysfs_links(struct kfd_dev *kfd);
> 
> +
> 
>   #endif  /* KGD_KFD_INTERFACE_H_INCLUDED */
> 
> --
> 
> 2.43.0
> 
> 
> 

