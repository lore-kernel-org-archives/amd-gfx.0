Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC8CCD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 15:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C48310EF21;
	Wed, 13 May 2026 15:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wHZ8kMCF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584B510EF1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzynjyQpgxk8Lxy1uWHCUBVXCL9ztthiMhf3rPOm5Y1Sqw4503tChDMbn/4wmX9F7pbXxQ79LWTEuaeCjx+paBV7gEbt62M2lLFHhBa3/pGfCNrTjVMo1ng7/YSCoClJ6aj8959HtAt7ZQEPVa9fOWnTfKdAC2sPUTzQrinSYSGCkQQa25fa8BmjFBhIIFEZ3sT0k8Sy6c2dYOVtbhQWSWCbDvVJgBMWss3q5a/M2jxW/oUStwVdJ2Mow47n6/i/MfCiP/yOhVtCDP/eOaP0NAvE8ezT9jTdEp8D0SBuwOvtM+jtKaJaxC/VQTKvrmztUiIUt99I33HX3/oCgVZ/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDlgSFm178OUllltTpA+ypcotfWcUwlAEQZmm/S8MAs=;
 b=p6gQgwyJJcb3k6lIOvymNlOmwi1mM2y5X7lhN0p8MpzgddC7hHZPylJ/asHprujN5lZ/Dr/zcE+BAdXFZWKX+cVE4WOt+1WpV/NzEj87aBC2BCKcE9hOLpCXJGtclwLPPDEyqyT2OFcdUjnoFcqsCBqkyiGS0GC+zyPaJjqk/UZ1FjYR9DqSWqcXCM3lZykXIvR+nCDj8+D7Zd/YMyYxQ3LiZsmchUXCp6qZ1qIZHNLPNEGTEMBmWYLkTEVFDvYpOYsKxu0AtFrmsGBm9esrelYXkmCzscHUFssLajyo8f64s3tqkEGyJkKM5ZLXRILuqzd5hKVVDMCoECv/I32orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDlgSFm178OUllltTpA+ypcotfWcUwlAEQZmm/S8MAs=;
 b=wHZ8kMCFL92uFyBTSqVIHramoydlcDRvTpn9JXPvQ1cmuZbkiWGsQuKjO1wEWtch0LWS8r+2cZOsc+9rmFGBhhOnLD1iWPMBndIqfhcICPljQBOsltT4TJpphVo0h1LLZvBU6f4kALkTJJZq+nOmDufBc94hInqu/QShzzRtFHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:02:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 15:02:01 +0000
Message-ID: <87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com>
Date: Wed, 13 May 2026 17:01:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260511142259.1424915-1-yifan1.zhang@amd.com>
 <f40f3088-073f-40cb-9e3c-38da7b101f27@amd.com>
 <b97010c2-75e5-43cc-b844-ce61906eafaa@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b97010c2-75e5-43cc-b844-ce61906eafaa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f62351-0b0c-4263-f91e-08deb100960d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IqY/06yUmOJ6X+YGbQ0t+YVelsSUqiThi9T6teHGu1Vcfuj7LWpu+t5+upnf/SKyR3gJ87k2YgiBP7zFly5ZZq0WlNV3i+uFKUDIaCMF5iNfowFYA9HfwCwZydsRJPhBs3+L/QolgN99QYSV8z0yEyiPicCUhyPC1nmn7kLbFb4OPvlwXoCDt6512djOR3f+/WRRzwMGyUqqH3DrAhXtw/AcWutosSCNLWa67T6gYE5tIY+Yx/6BG1jKY73YrrrEmBkocWyik1881cgq8SohcQ26j6vTSkuYpSBJgO7ac8JbSY9jspTfPY3s+o4nNso9EYNVVJmBo26DKUcy1utMF1NDhk7Ap+jorpds8drkqu4YkXTi4cwqrn3KVVVFU6XJH1sDjvYw79o51qcB0EM7+MSHL86tJWtlxSkuGS6mEhqs5sUKMwY0UwjWCjEvZdrx+QFIF8wykvHe7ak5vjiApGpo4qPU6jSkP0epG1iZCqD4dl/JKVvBrGAXG6LMax4pOotF2HByvHWCKZoRqOTSoSsjtLn5QklivBtdNeaitdml5hsVN3jvPDxvLtmXER1RzLnlEaeNCW2TUBWyWGoWffIdc9QjIyAkFlW+5zcWjQbgwt7RdIUb5APCwYSy0zCM6xNBmQ68hwf2ZbHSgMSE6P88KOjD0g2BIUWqWMy2JC6TB8gymHQhBCtYQefJB2Hr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25oWkZXd3dNdnozUFZDUTFSNG1IcENicWo4Ti9rampQNW5DcGlGekQ2Z0Jt?=
 =?utf-8?B?K1h6b1JYS3hFakdISDhYU2hNWGl3aWhVVnVqNWY4dnVKZVl1RUJScUV2TGhr?=
 =?utf-8?B?ZXhIaUZHbVJ2STFkNHRvby9jU3NMcHdZUDdKOTFna21zakw2V3R4VFRuVi9m?=
 =?utf-8?B?Y21SKzdFNDVLR1lpWktEZXlWV0pUYURnZ1FoTGROZGJ1YmhiY3pOTk9qMUkr?=
 =?utf-8?B?MHNsakNteCtJSmtqZ0I1VDFjbFYyczdEdUFudnVTL1B4Smd0cXVYUU5uNnZl?=
 =?utf-8?B?R2ZrblR0UlJoc3ZvN0hrUkZDTzErV0ZoaU1UcEh1akh1Zm8yZEZ0bHh6Wkx5?=
 =?utf-8?B?ZUNwaENUNzlIWVVWcmdZUVpVTEF2NHE3NkNSQTVHazZlU3NFS0Y0MndhUzE0?=
 =?utf-8?B?c0FhSmJvKzZVamlnYWRMOUpCQTF5b043N3czM2k0MEkxekFBMDRHN1EwSm5J?=
 =?utf-8?B?RmYybENEOVZzMjE2MVdWWURodHUwQTZQYWdybjRNQ2JWYk02Qm1QczBvRUVG?=
 =?utf-8?B?V2psSEpkVjM2SFZtZy9ETjlCQ1hMMGZaMXpIMUFDT0thVVg5NE11N3duWFky?=
 =?utf-8?B?OHFra2JRci9mYy9TSXY3MDdsWW9WSVhRMUlJMnRnc1ZpZ3pTNFZsVlUzWEps?=
 =?utf-8?B?ejhXS0NuVmdYMWZiVWl3enNMUzZ0OWk5ZElOcXhuVXRISjFjcGNXL2ZDY0VY?=
 =?utf-8?B?aDEyclJlT3ZSM3g1aUZFSVE3NlFTQm1qQ0kxQjNDanc5aFk3Z0lXMXNkeVpz?=
 =?utf-8?B?SDNQRFBkRVpSbFBvVkZ0dTZnSmZnTXpCeGIwcDdUa2NUMFpJKzV6NTBxWU9X?=
 =?utf-8?B?Ymd3VzhaUVV5bGl5Q1Y1S0kzTFE5cFhDL054NERZREU5cHRrSTZydGlsNlkz?=
 =?utf-8?B?K09tcDhTSkNQckpyNVp0NHNCNkFtZ2dLaDRQOHdZNE9kUG5ZazRmbFZFeUVU?=
 =?utf-8?B?YlFyU3JIR2dadVRRZmtaeGl6RGxZY0s3OGtjaEVVWmR0MjN5cUtwT0FxZWFj?=
 =?utf-8?B?Nk84YjYxalNNdHFYcW1MNUUvZ3d0RzJhcUdmQlEwL0orTjZRa1A5ZVJnUVQ4?=
 =?utf-8?B?U3lReHBkUkNrQ2dlc0RoN0tXcFlPMVgxamFTdjZjNTlPUExNUWRwcEg4QTR4?=
 =?utf-8?B?bHpMMnAwM2hmektKa1RnWFk3WUJXVGpiNkpHK0Y3Tmg2YnN5VVEvWU5oSVA4?=
 =?utf-8?B?ZjUzbEhBSktwWWNzRjNMWGNVZ2VaNzdTdGdSU1dHMytPakRMTm94THc2T3lw?=
 =?utf-8?B?OUdjM2xNYlF4VlZOZkNWcUp1YXNZUTVIRDhYbWxsajJsZytHSHRSS3pVWm1h?=
 =?utf-8?B?VENiS3d5WWcxT2hucnBqNDNMb2c1TXhLWEtBSWo5Y0pBL1lqWWxXQUxrZVc3?=
 =?utf-8?B?U3dNbEN5UXpnQlU2aTliaUpEM05JQ2pra0ZzYjByTGdOUmFOb1FjdFdqSmJs?=
 =?utf-8?B?SVhIT0prSStZWTdETEdRdzAyME1wOE5UUlpWdmY0bDBqNGlzWFlFY0dRMG0w?=
 =?utf-8?B?eXVjZkFoS1JRalFGU1EyR1RDamFzTm95d090bUlIdUVyTlpWZTBmaWJzbDE1?=
 =?utf-8?B?MEZZbVBVTkhFNjNjQ1lDRVVZaTZmTFd2TUVHSHR4R2hjaHlpNk5ldVdKNTIw?=
 =?utf-8?B?bU4rVSt5b0p4UWNNY1hUeUNNZ3hSR0M1aFZSOGpjOU1tL1ZtUjAvTlZQSEg5?=
 =?utf-8?B?bmwyTS83ZlFjMkgycklxTUhYVjlic1h5YkxCdDh3akwyVUozNWVLTXZiVWF3?=
 =?utf-8?B?WWlyeFhZc0RFNWo4UHAvVzlqbVFwWFRzUlV0VTV1TERRUC9QdGVueTh4dWdG?=
 =?utf-8?B?TlR3QUo1Q2kwVGtVNTU0aU1WWW81cFYraDFONk5xZzJzODQ1RjVINkVWYi9v?=
 =?utf-8?B?QnY5M2xvb0QzZmxzZ2ZLc3BhZGUvdDlCVXNVcmhPYTFYdGZrVkZkTE83TjE3?=
 =?utf-8?B?eUIvRUxVZ1FaaTFFMWFRWDBzUk9kOTh3bWg2ckl3RWt6NWJpbWRwUXFGZVE4?=
 =?utf-8?B?bFBlakFFWkN3VWlUdUhPL2hxM0oyS21hSmwxV3hPUTJoUGx6VmZHZllTSEtV?=
 =?utf-8?B?RFJrZ1NycEx3NkRuWFZwR2xrTUc0M2xoay9STkNZNFZGSi9VMnJ6YkFOaXhz?=
 =?utf-8?B?Sk1mWG5qM01Yb1F4UXhiYXpqbTFDRjExcEQ3c1BxK2dSRzV5OGpGWlNvUzRa?=
 =?utf-8?B?QXkyTlJZN1MyZDNBSkZmS0tZcURGYm1BdHQzK3BBd1d3NkhRT2h4RVluSW4z?=
 =?utf-8?B?Q3F4WkhzQXVTWWFXM0VFVExkTW9ucnZlM25pZXZIRURWNk9xMVdnTXAzUWpn?=
 =?utf-8?Q?IJjYohxfZR0cGYZXo0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f62351-0b0c-4263-f91e-08deb100960d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:02:01.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld2opXZQhUNsi2CcsO0w5bqkkO8ULGsnD0QtgqqfBCACYvIvaQ6Pr+CulPpquXxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

On 5/13/26 16:21, Kuehling, Felix wrote:
> 
> On 2026-05-13 01:58, Christian König wrote:
>>
>> On 5/11/26 16:22, Yifan Zhang wrote:
>>> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
>>> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
>>> this window can result in uncompleted PCIe transactions, leading to NMI panics or
>>> system hangs.
>>>
>>> To prevent this, Unmap all of the applications mappings of the framebuffer
>>> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
>>> during the reset process.
>>>
>>> v2: remove inode in kfd_dev (Christian)
>>> v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)
>>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>>>   5 files changed, 52 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 7b10bbe28caf..d1dac3412a66 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -36,6 +36,7 @@
>>>   #include "amdgpu_ras.h"
>>>   #include "amdgpu_umc.h"
>>>   #include "amdgpu_reset.h"
>>> +#include "kfd_priv.h"
>>>     /* Total memory size in system memory and all GPU VRAM. Used to
>>>    * estimate worst case amount of memory to reserve for page tables
>>> @@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>>           (void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>>>   }
>>>   +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
>>> +{
>>> +    struct kfd_dev *kfd = adev->kfd.dev;
>>> +    unsigned int i;
>>> +
>>> +    if (!kfd)
>>> +        return;
>>> +
>>> +    for (i = 0; i < kfd->num_nodes; i++) {
>>> +        struct kfd_node *node = kfd->nodes[i];
>>> +
>>> +        kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
>>> +                        KFD_MMAP_GPU_ID(node->id),
>>> +                        kfd_doorbell_process_slice(kfd));
>>> +        kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
>>> +                        KFD_MMAP_GPU_ID(node->id),
>>> +                        PAGE_SIZE);
>>> +    }
>>> +}
>>> +
>>> +
>>>   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>>>                   u32 domain, void **mem_obj, uint64_t *gpu_addr,
>>>                   void **cpu_ptr, bool cp_mqd_gfx9)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 2bf6a31c194d..5333e052d56d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>           uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>   void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>           uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>>>     u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1202a72ff063..6760c9331f46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>       /* We need to lock reset domain only once both for XGMI and single device */
>>>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>   +    /* unmap all the mappings of doorbell and framebuffer to prevent user space from
>>> +     * accessing them
>>> +     */
>>> +    unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>>> +    amdgpu_amdkfd_clear_kfd_mapping(adev);
>>> +
>>>       amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>>>                         hive, need_emergency_restart);
>>>       if (need_emergency_restart)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 84b9bde7f371..1be1b1dd2341 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>>>       .name = kfd_dev_name,
>>>   };
>>>   +/*
>>> + * Cache the address space of the chardev on first open so that the reset
>>> + * path can drop all userspace mappings of doorbell and MMIO ranges via
>>> + * unmap_mapping_range().
>>> + */
>>> +static struct address_space *kfd_dev_mapping;
>>> +
>>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
>>> +{
>>> +    struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
>>> +
>>> +    if (mapping)
>>> +        unmap_mapping_range(mapping, holebegin, holelen, 1);
>>> +}
>>> +
>>>   static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>>>   {
>>>       struct kfd_process_device *pdd;
>>> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>>>       if (iminor(inode) != 0)
>>>           return -ENODEV;
>>>   +    /*
>>> +     * /dev/kfd is a single chardev so all opens share one inode. Cache
>>> +     * its address_space on the first open for use by the reset path.
>>> +     */
>>> +    if (!READ_ONCE(kfd_dev_mapping))
>>> +        cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
>> That stuff looks really odd. Mostly @Felix why is that necessary?
>>
>> Apart from that the patch looks good to me.
> 
> My understanding is, that kfd_dev_mapping caches the mapping in a global variable, which is OK because there is only one KFD device node. Using cmpxchg is a reliable way to update it without holding a lock the first time kfd_open is called.
> 
> It's not pretty, but I can't think of a better way of doing this.

Well you somewhere allocates the device node and that should have an inode field which in turn has an i_mapping field which contains that value.

I don't know the kfd code well enough to judge where that is but in theory it should be much simpler.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.
>>
>>
>>> +
>>>       is_32bit_user_mode = in_compat_syscall();
>>>         if (is_32bit_user_mode) {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index a6ff1db477f9..f037062c33ea 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -399,6 +399,7 @@ enum kfd_mempool {
>>>   /* Character device interface */
>>>   int kfd_chardev_init(void);
>>>   void kfd_chardev_exit(void);
>>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>>>     /**
>>>    * enum kfd_unmap_queues_filter - Enum for queue filters.

