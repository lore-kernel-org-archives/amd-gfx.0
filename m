Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEDCD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 15:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3143910E2B5;
	Fri,  8 May 2026 15:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E6MXunOl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5220610E2B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 15:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ0Fle6uuoDtmiXL+6w3bYXGfl+vLtI9asP0FCTYwY1UDfWdTlzEYPwIXVECowUKehQ0MhcwJJ9OH7FGbcczkYUgTJl7Zw7D+eVREpESd95lEklR6uj1veXFwd7bBNgE0CTisYlQhF/dQg7hcCODTVMnOKdTCrsFSqrGSguTc4clIOcMryslT2IkUvjRiyScXxOhaqxyfD0DM9HzbMMSnoTWFkWHycWUN7LrZreZRgcQ61JBKsNYW/VKQBTRBamwEb7xoaYgumlsHXBSZB0B29FHDxBMpVQZ/xqXa1MqwqOw7XgtTk74A+Lbm9p6Cw94X9KvQaMynbOMc4tTzkOghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm/Txnd1nC9YNAzKxthjexgV6yZ6uCo18J7w+ote/0o=;
 b=VN3yG060xJyd5SbKg6iJwufwC5BdT8KoZYFnwpMaqJwi+QISAhKQ3dCuntE9+s0FB2ZHs8G06N62F4AI2ZZIdmGFrpgdPaL6TOwwa1FEEPf+oxx8nFzGASOTULZJLOxGdeF6ojm0FJuRbR96u9iAAww/QgT8KIyVUlC6/1C3wDhhKAhPMzY18cluQmeEpu3gwem8vE2Dz4NKz62obWN6q+6pVCAhTB/kLZ2A8wuA4Eagg+gBef10DRxidUCEUWYLsthULYjCWoUXJXiv3GaopIDNY32N0B3eVzCjwL4KejHOfYyjB/C9Oqrob6Vc3U1o6pvfgs5od83f1EWe3WGhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm/Txnd1nC9YNAzKxthjexgV6yZ6uCo18J7w+ote/0o=;
 b=E6MXunOlMSH2AZ42iy0Fsv/PBnAukIYouTEYjPV27HVaaAnvVO89UxPNC56ft9P1yiOlN10C42kxAfbrweKa/KaR3Jjq+Xi+u+YybH+f3RJKB4lIDyZ8jvEh5OKkneaimB8XsDoeYv+OCbcNrCmbO5MBe+zgxZdt5qWnYFBCEVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 15:52:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 15:52:22 +0000
Content-Type: multipart/alternative;
 boundary="------------LOyASeo4GFPSwurLw5FaXhgu"
Message-ID: <7de07ccc-498e-4b4a-8979-a1ae64540594@amd.com>
Date: Fri, 8 May 2026 11:52:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, phasta@kernel.org,
 Honglei1.Huang@amd.com, Perry.Yuan@amd.com
References: <20260508061738.1039917-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260508061738.1039917-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8238286f-587d-4b84-b844-08dead19ca9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: zh0Q2qvDCYyTuaV/um4ZaoxmjCW1IFN18SoFFDNf40UxhvQzHs5/OtubNkRTsrisLoWkXTfulYooA0KoqOG8Ndo33NxgI++Vg8zeDAPmfMUCaaqH1hf77fI4w72cuT/n++14K51sRQodubfN/DEM1EZLaj3zHAxbMPiucg8pcNkpiDnL+zfSGiHXrTfCeK6s8uVbaSQHNM0ImBMQooil9yS9plaZviTD/DclO33B2wlGhO8/W2crbvQbnaU1xiPCUlYGtp/IX4eSlAifZaScvnhvnrzkoVa1VgcqIubHFABx1jsMsaARuJ+wLP5NBfP36ZjWIPCWLRfmZikc1111QrputKsdoioxx9yZjCWEMh4OFmnX0ppy/lOvCHF2d5X/G6l0YgipEBvgK7ipYZcDmhkeTewwP1lSd06npXz5pG6MHJCyaVk4Un59qBpl3roIWzJw4wyZRI6BsqaCAw5xcqYAb3H/XKV9i7bcebNT6WhoGCF4ONJ4kXuf7/cW9iuMV9GblHrRKcVvrHTnlou2Ww+moB1IXXj8s2wiTRsKbrTGlZNDSjcTzKxVzyg9kG79aAI1bkrEwVKU/ooq+PBFTM6xMTdtWuqbZMrc2a1sMDyl+kODkbAFgAdYEhaWv5HkXIVr45cxAGPYlXQdahH1I0fhR2AtaWy2PafuWHj67U6LFQXkb+17vkw24UjFFQjB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2U2U2tNTFlRbUtFYmIvdUVGTU1QUGZ2WGJnRk1VNzllbWQ5THFibS80Yits?=
 =?utf-8?B?UnA2Zi9XYWhSTjlzZzR3RXN4MVNjNk9ER29aeTRtTnE3d0VrSnFYWXRLYXlV?=
 =?utf-8?B?OWhESCtqWWRsS0ZhTzlRMWUwa3R0eGIxWjE5YUNJQ2Ric091MXJic1VoWTZh?=
 =?utf-8?B?dWo2ZjEyOXoxN0p4OHZvSzRFaVM5UDdnYmNyTjhXUjk4dnZMT1h1VlZOUzV6?=
 =?utf-8?B?NlpDUVByRW1KS0Job1RYVWFrRmtka2tlS3F4TjJFQk1rMGRDa2xTb0JpcUds?=
 =?utf-8?B?ZEhYbGI1Z0NyeTUvTlNpOU5LeHNIMFlZVFlPTFNITkdtNnVZc1UxYkc0QU5W?=
 =?utf-8?B?dDRTRUlyMnMrOUprR1BZKzBqb0VKZ3d1cmt3dklwKzJtRmkxM05LWklxdFBN?=
 =?utf-8?B?RlNRdCtkOUhCQ2gyNHRBUHRRbUwrVGZOcFU3bVc4cy9kcVlzNWlCK244QlQ1?=
 =?utf-8?B?Z3RyMUZ2VXIzZW90UjJkdy80aExPWDJ3QXBldVkrVFRGOCtGaWxtL3I0c2dS?=
 =?utf-8?B?c0xON1lhRFc2U29oMUQ0QXlVMUVJdHJYMEwxRHlvbllLNVZqQ0R4TzhuczZL?=
 =?utf-8?B?a0RDMUkxa0lVejJES2lNdm5jL0tDVE4vaDAvRDJoZHlrV0VKckFoK05kOHZB?=
 =?utf-8?B?VlQ2T3Q0bzB0V2ZoOFo5Sk5nMlg2MmVJRGdqQzZQeDdFazk0VEpkZHh2Rkx5?=
 =?utf-8?B?Sm1RbEw1alhaTXVFbFVPZFpyeGY2djFpUzJCL1c3TFF6bUdKZ3dlaVB3SHNj?=
 =?utf-8?B?WDBFM29zc2x5S3RUdU9xSkZLa2I1bTRFV1RzU1kvWXV1WFlnbHlqc0NOK2RQ?=
 =?utf-8?B?U0Q2Mm16K3JjUXB6N0tpTjhJTnFhOUdXeG81Y3dnZno0RHBWQWRQVUpnQ1Q5?=
 =?utf-8?B?K3dPM2ozTmdkMDJEZlRFK0xFUHdSTWlsM21aRE9sekMrelZZYmNodktma2tj?=
 =?utf-8?B?OTJUcEpESk1MOGo0c2MvNG1MTXU2VUp2ek5Hb2c2U2tyQTRqWm1JNGMrTFFB?=
 =?utf-8?B?aVRMMStwLzhmNUNLZG1UMlZDUDRIRlpQY2pxVFRaOXkxQ1dpdWJnUitRUkFY?=
 =?utf-8?B?ODI3WGx1aDYrZzc5LzV6VDZKUDk3VUtiYnVnQ0paZ0RIdWtsaDc4RFZldGhN?=
 =?utf-8?B?S0tMajkvUEk3N1ZCWGNnMDIzZDlJdDZITjZVOWJ3d3l5b1orRERnOFNVNGNQ?=
 =?utf-8?B?b0RieE9URlQxNUdtS29EeVdMdWN6S1ovN3QxNUVrdFJidm9hVlk3aEVGYW85?=
 =?utf-8?B?c2xtSzhZV2N5SzlZanJhZzVOMGNUaWZzOXFZUDQyenA1VTJKSEFOM2VtdWdZ?=
 =?utf-8?B?YjBLa1crcnhaR3N5WjBPek81YUZvT1Y0S1F0am9rK3N2RjBzemV3R2gyaXNE?=
 =?utf-8?B?VTVTeG9QMHhqcUNTYk02aHNvZmdCeDVoK1BpcVNqZG5qdFNQNThPQmR3Nmww?=
 =?utf-8?B?MkovQXhxVFR2QnovMzRUT05LSnBHQVJPRnRUMjd1c3NlMm9mcFZFdzBoQzM3?=
 =?utf-8?B?NkRyOVB0OVBCYXdnOGljRTN5L2EvaEZCdFlsNEEvQ0dWTW54NzV1VjVuZWRZ?=
 =?utf-8?B?ZVhDci9CcDc4aURKYmlmTTdKSkZlM3YzZ0RRY25rTXB2SVJ0WW0vS3F6cjlM?=
 =?utf-8?B?aWl6S3lyWmMzWU0xelVZSTl3aVZ4Ui82eUJvUldqM3ZmZ0FjUXBNWHgvRVFq?=
 =?utf-8?B?TjZJMUh6TGpvd0hxRnh3RjF1NU5uYU9mdEhzOU9pQkw1NEJrdzN5czBMRG9Q?=
 =?utf-8?B?ekk0T0FieDRmMnUrUEtlY1NJRSswY0NGZzRuSUIxQ1RiSE9EVXlVcWM0QkNu?=
 =?utf-8?B?ZmlzdGxrYS9Dc1FUZ1Y1bnhRYUM1bW92aUF2R00zRjFzM0dCZTlpRVBxeUpY?=
 =?utf-8?B?UFRTcTlRL2FLU3lCeTlmQnBqOUdxSFg2TTJBYTFDSHd5Wm5mWVF1N1BFellh?=
 =?utf-8?B?akI1b2xsb2ZYQ3B0eGxReXFqb0twdDNkTmNtU0N6YkpLZWo4NnU3aWJnOFJx?=
 =?utf-8?B?cmlmeW9sY1lWS29aSFVaUmpRM2JPMVdPa092T3NYdXF1ZlpsMkNNOVJrVTlO?=
 =?utf-8?B?RVpreS85ZUhXZER0dUxjUVVpcGljcXM1VXVCQTZWQ0tXOVhRVlE3Y2RtQjdD?=
 =?utf-8?B?WVZKQ3hJKzNvcnpISXBBTGcyS1Y5TElOMkVnNlFFZlhDOVVXcXk4ak1FV2Fu?=
 =?utf-8?B?d3FyMzVxNGRzbC96R0dBU29ubDNzTis1cVZsTDlDZmg0Y3MwVVVGYTZXK2JL?=
 =?utf-8?B?ZmY3QTJ3Yythend1N3pYRmFXM2VDNmZIWEFnWXRPWnpENkxLTWM0NTlURld1?=
 =?utf-8?B?NnR2TStJUTJFRW9TbFVxeU1nYjFFK2RHWlZqVmxJNVRlZC9FK1doQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8238286f-587d-4b84-b844-08dead19ca9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:52:22.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltLbTqLywz+DBvs4t1wHs0gTFymo/izUpMTOddOt/YED4/QTUiGR6lWVFmJdL/rZkv+ZCq3ktkIxPvPGjqXYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807
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

--------------LOyASeo4GFPSwurLw5FaXhgu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-05-08 02:17, Yifan Zhang wrote:
> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
> this window can result in uncompleted PCIe transactions, leading to NMI panics or
> system hangs.
>
> To prevent this, Unmap all of the applications mappings of the framebuffer
> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
> during the reset process.
>
> v2: remove inode in kfd_dev (Christian)
>
> Signed-off-by: Yifan Zhang<yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 17 ++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   6 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2bf6a31c194d..5333e052d56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>   void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag, int8_t xcp_id);
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>   
>   u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c01492e69dd..2b06a2dae3da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -139,6 +139,17 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>   	kfd_mem_limit.system_mem_used += size;
>   }
>   
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)

This function isn't really related to the KFD GPUVM code. Please move 
this into amdgpu_amdkfd.c instead.


> +{
> +	if (!adev->kfd.dev)
> +		return;
> +
> +	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL,

This doesn't work correctly. The mapping address also includes the 
GPUID. See this code in kfd_ioctl_create_queue:

>         /* Return gpu_id as doorbell offset for mmap usage */
>         args->doorbell_offset = KFD_MMAP_TYPE_DOORBELL;
>         args->doorbell_offset |= KFD_MMAP_GPU_ID(args->gpu_id);
I think you'll need to include the GPUID in the address you're unmapping.


> +				    kfd_doorbell_process_slice(adev->kfd.dev));
> +	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO, PAGE_SIZE);

Same here. You need to include the GPUID.

>         /* MMIO is mapped through kfd device
>          * Generate a kfd mmap offset
>          */
>         if (flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
>                 args->mmap_offset = KFD_MMAP_TYPE_MMIO
>                                         | KFD_MMAP_GPU_ID(args->gpu_id);

Regards,
   Felix


> +}
> +
> +
>   /* Estimate page table size needed to represent a given memory size
>    *
>    * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 073f632f295a..c741a1a2a8cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5840,6 +5840,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* We need to lock reset domain only once both for XGMI and single device */
>   	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>   
> +	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
> +	 * accessing them
> +	 */
> +	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> +	amdgpu_amdkfd_clear_kfd_mapping(adev);
> +
>   	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>   				      hive, need_emergency_restart);
>   	if (need_emergency_restart)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0071d6957828..1dd343f0219f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -46,6 +46,7 @@
>   #include "amdgpu_hmm.h"
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_vm.h"
> +#include "amdgpu_reset.h"
>   
>   static int
>   amdgpu_gem_add_input_fence(struct drm_file *filp,
> @@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>   static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>   {
>   	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct drm_device *ddev = bo->base.dev;
>   	vm_fault_t ret;
>   	int idx;
>   
> +	/* Prevent new mappings from coming in during reset */
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return VM_FAULT_SIGSEGV;
> +
>   	ret = ttm_bo_vm_reserve(bo, vmf);
> -	if (ret)
> +	if (ret) {
> +		up_read(&adev->reset_domain->sem);
>   		return ret;
> +	}
>   
>   	if (drm_dev_enter(ddev, &idx)) {
>   		ret = amdgpu_bo_fault_reserve_notify(bo);
> @@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>   	} else {
>   		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
>   	}
> -	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
> +		up_read(&adev->reset_domain->sem);
>   		return ret;
> +	}
>   
>   unlock:
>   	dma_resv_unlock(bo->base.resv);
> +	up_read(&adev->reset_domain->sem);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84b9bde7f371..1be1b1dd2341 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>   	.name = kfd_dev_name,
>   };
>   
> +/*
> + * Cache the address space of the chardev on first open so that the reset
> + * path can drop all userspace mappings of doorbell and MMIO ranges via
> + * unmap_mapping_range().
> + */
> +static struct address_space *kfd_dev_mapping;
> +
> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
> +{
> +	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
> +
> +	if (mapping)
> +		unmap_mapping_range(mapping, holebegin, holelen, 1);
> +}
> +
>   static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>   {
>   	struct kfd_process_device *pdd;
> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>   	if (iminor(inode) != 0)
>   		return -ENODEV;
>   
> +	/*
> +	 * /dev/kfd is a single chardev so all opens share one inode. Cache
> +	 * its address_space on the first open for use by the reset path.
> +	 */
> +	if (!READ_ONCE(kfd_dev_mapping))
> +		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
> +
>   	is_32bit_user_mode = in_compat_syscall();
>   
>   	if (is_32bit_user_mode) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6ff1db477f9..f037062c33ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -399,6 +399,7 @@ enum kfd_mempool {
>   /* Character device interface */
>   int kfd_chardev_init(void);
>   void kfd_chardev_exit(void);
> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>   
>   /**
>    * enum kfd_unmap_queues_filter - Enum for queue filters.
--------------LOyASeo4GFPSwurLw5FaXhgu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-05-08 02:17, Yifan Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260508061738.1039917-1-yifan1.zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
this window can result in uncompleted PCIe transactions, leading to NMI panics or
system hangs.

To prevent this, Unmap all of the applications mappings of the framebuffer
and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
during the reset process.

v2: remove inode in kfd_dev (Christian)

Signed-off-by: Yifan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:yifan1.zhang@amd.com">&lt;yifan1.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 17 ++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 6 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2bf6a31c194d..5333e052d56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69dd..2b06a2dae3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -139,6 +139,17 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 	kfd_mem_limit.system_mem_used += size;
 }
 
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)</pre>
    </blockquote>
    <p wrap="" class="moz-quote-pre" style="white-space: pre-wrap;"><span style="white-space: normal">This function isn't really related to the KFD GPUVM code. Please move this into amdgpu_amdkfd.c instead.</span></p>
    <br>
    <blockquote type="cite" cite="mid:20260508061738.1039917-1-yifan1.zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">+{
+	if (!adev-&gt;kfd.dev)
+		return;
+
+	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL,</pre>
    </blockquote>
    <p>This doesn't work correctly. The mapping address also includes
      the GPUID. See this code in kfd_ioctl_create_queue:<br>
      <blockquote type="cite">&nbsp; &nbsp; &nbsp; &nbsp; /* Return gpu_id as doorbell
        offset for mmap usage */<br>
        &nbsp; &nbsp; &nbsp; &nbsp; args-&gt;doorbell_offset = KFD_MMAP_TYPE_DOORBELL;<br>
        &nbsp; &nbsp; &nbsp; &nbsp; args-&gt;doorbell_offset |=
        KFD_MMAP_GPU_ID(args-&gt;gpu_id);</blockquote>
      I think you'll need to include the GPUID in the address you're
      unmapping.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260508061738.1039917-1-yifan1.zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+				    kfd_doorbell_process_slice(adev-&gt;kfd.dev));
+	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO, PAGE_SIZE);</pre>
    </blockquote>
    <p>Same here. You need to include the GPUID.</p>
    <p>
      <blockquote type="cite">&nbsp; &nbsp; &nbsp; &nbsp; /* MMIO is mapped through kfd
        device<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Generate a kfd mmap offset<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
        &nbsp; &nbsp; &nbsp; &nbsp; if (flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; args-&gt;mmap_offset = KFD_MMAP_TYPE_MMIO<br>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
        KFD_MMAP_GPU_ID(args-&gt;gpu_id);</blockquote>
      <br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260508061738.1039917-1-yifan1.zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+}
+
+
 /* Estimate page table size needed to represent a given memory size
  *
  * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..c741a1a2a8cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5840,6 +5840,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &amp;device_list);
 
+	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
+	 * accessing them
+	 */
+	unmap_mapping_range(adev-&gt;ddev.anon_inode-&gt;i_mapping, 0, 0, 1);
+	amdgpu_amdkfd_clear_kfd_mapping(adev);
+
 	amdgpu_device_halt_activities(adev, job, reset_context, &amp;device_list,
 				      hive, need_emergency_restart);
 	if (need_emergency_restart)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0071d6957828..1dd343f0219f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -46,6 +46,7 @@
 #include &quot;amdgpu_hmm.h&quot;
 #include &quot;amdgpu_xgmi.h&quot;
 #include &quot;amdgpu_vm.h&quot;
+#include &quot;amdgpu_reset.h&quot;
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf-&gt;vma-&gt;vm_private_data;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo-&gt;bdev);
 	struct drm_device *ddev = bo-&gt;base.dev;
 	vm_fault_t ret;
 	int idx;
 
+	/* Prevent new mappings from coming in during reset */
+
+	if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
+		return VM_FAULT_SIGSEGV;
+
 	ret = ttm_bo_vm_reserve(bo, vmf);
-	if (ret)
+	if (ret) {
+		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 		return ret;
+	}
 
 	if (drm_dev_enter(ddev, &amp;idx)) {
 		ret = amdgpu_bo_fault_reserve_notify(bo);
@@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf-&gt;vma-&gt;vm_page_prot);
 	}
-	if (ret == VM_FAULT_RETRY &amp;&amp; !(vmf-&gt;flags &amp; FAULT_FLAG_RETRY_NOWAIT))
+	if (ret == VM_FAULT_RETRY &amp;&amp; !(vmf-&gt;flags &amp; FAULT_FLAG_RETRY_NOWAIT)) {
+		up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 		return ret;
+	}
 
 unlock:
 	dma_resv_unlock(bo-&gt;base.resv);
+	up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84b9bde7f371..1be1b1dd2341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -69,6 +69,21 @@ static const struct class kfd_class = {
 	.name = kfd_dev_name,
 };
 
+/*
+ * Cache the address space of the chardev on first open so that the reset
+ * path can drop all userspace mappings of doorbell and MMIO ranges via
+ * unmap_mapping_range().
+ */
+static struct address_space *kfd_dev_mapping;
+
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+{
+	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
+
+	if (mapping)
+		unmap_mapping_range(mapping, holebegin, holelen, 1);
+}
+
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
 {
 	struct kfd_process_device *pdd;
@@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
+	/*
+	 * /dev/kfd is a single chardev so all opens share one inode. Cache
+	 * its address_space on the first open for use by the reset path.
+	 */
+	if (!READ_ONCE(kfd_dev_mapping))
+		cmpxchg(&amp;kfd_dev_mapping, NULL, inode-&gt;i_mapping);
+
 	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6ff1db477f9..f037062c33ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -399,6 +399,7 @@ enum kfd_mempool {
 /* Character device interface */
 int kfd_chardev_init(void);
 void kfd_chardev_exit(void);
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
 
 /**
  * enum kfd_unmap_queues_filter - Enum for queue filters.
</pre>
    </blockquote>
  </body>
</html>

--------------LOyASeo4GFPSwurLw5FaXhgu--
