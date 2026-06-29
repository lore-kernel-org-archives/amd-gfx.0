Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D1C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 19:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23FD10EA2B;
	Mon, 29 Jun 2026 19:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mLJinxM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B663E10EA25
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 19:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqUr6PJ0uxW/j3a3G2OJJIbXHWLxsD73hEIaToSrKeULUZp58kj+h5wXHfxxtcV5a4T6r3my27dbXx1JptWRIxtCYrJ/GARBe65QZ4+hr514i/tBnoKyUIEGGlXFZTWb+FGT7qmMPYce+0kYsX1TSBi5GWI8MBZh45S6aS3lt4w8jr+x52BcQJ/2Gzn9/+oE7BBHIc6usgZ057WkL9z1vK/fuL7dYfGQ8FDP9Xcvm2uDt+RoDexzZBs6IKSgXUk+ETeELIKG4T2tvg2OeZIoGeJOBpao65lkjF6ZzwAh9VWicl6CHhBEpvCoAc4BwxG+yrY5oaRWfPf8J0k9VUCEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8By2m1TIZWAgBuZpF/t+DNlCiodt6q7ynhMEHtojZM=;
 b=R8ccjkutznnPx4GzyysNzd2F+wHvyj/UUWnteDDaVDcXbjE57g8yHfnzLe8xc83e+CGt+/gC4tuUPevi8zS2xSmrWQE0RODBE6NWrIk24VtmzYq0/raux+m2BOtucUKPXsv60shCqvmUus3FyeKPSVdqe/RXHIyJ3CxkxnS9dh2GzLIHnlxKDg0jTlOq4DvOzOhzNel5ShFFeD2ZJPrzvl3W2l+ASMcVTK8T8Ajfl+hn66mikz7iVlh6BQp3mH18xOXoFC5MCEVT76QMGiGEUqaxz+N0E08NriRwVuPXGwU1QZ+D1JA/c4abIZQupjNj3R2R76kujge1N0zDxc+1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8By2m1TIZWAgBuZpF/t+DNlCiodt6q7ynhMEHtojZM=;
 b=3mLJinxMvTYVObz9G0Y4yF3P5bGeqKA8R/8gdT94qZRgSmNsX8ku0Te/WaaHit4JdiwIUgBtTTnywILsFIS84Y36EmS7oWHfmepZPQdr7yomRzwwsNkl6K4kiYi09B4//vJ3uKR9EhO4cloYLGmak5KWUkLfT9HELgYPY2rEdiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 19:43:28 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 19:43:28 +0000
Message-ID: <4ea34942-f1ff-4c65-a634-1f8786308fb1@amd.com>
Date: Mon, 29 Jun 2026 15:43:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: use iosys_map for CWSR buffer access
To: Mario Limonciello <mario.limonciello@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Felix.kuehling@amd.com, Yifan1.Zhang@amd.com,
 philip.yang@amd.com, Harish.Kasiviswanathan@amd.com, Bob.Zhou@amd.com,
 "Claude Opus 4 . 6" <noreply@anthropic.com>
References: <20260629005028.2907470-1-James.Zhu@amd.com>
 <f0719bbf-55fb-4d26-b717-b161ebde51fa@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <f0719bbf-55fb-4d26-b717-b161ebde51fa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::24) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: e4029d6b-7c7b-421c-6a76-08ded616b12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006|6123799006|4143699003;
X-Microsoft-Antispam-Message-Info: zJ2i1lwKvPMgfss9+hN2hHdkV7lxe96IRzU5lIJu8Z8or5G1jip290ZQfWSwZWPBrVzUW55e9nSfKjCD6D1xDDRny6L1BuDEpNJ6YYInn5lcMKKUpnwECJtQkOFE7wFhtTMHcCk9hBLnsUQZcVkI8JemTMrvTJUh/CTaHG/3PqK+oA6U+jWJuphp4I9w+s1rTF2YwjmMRMmleFI6cWgKxWEg4sanVBhFepgYTlLsQjHLRY6pYUeVWB/tYUHxtzlTAalmlzTyOypFx/Idn8DPZdxrR9ou54nIpAaZfguKpjThXNlduqIYLX8ivjaw6vWTxMKzBxMe+6izGubB16/XJN1RGxBEZM9Pz2Qe87BeUyUHrOinLW2b8j4Qyw3+LQwt59sRJ4aGz0Pgoojt/qJHxos4M8Yy2G8lpE7DXBr3WFilVyqWbbt33Hd8E0zWg6NeB6zkbN9AOPEDZqG4FEphz9tXW2x1beJV1Gmg57kFYOnHI0tKmreeiDPv+r7wTO9zjwOPTwyutue80czGLhrh/RlXmCWWn9imDWLIc715wDj6xbTZGOwmAIHlJRWourbpwzE4GxUaoHlxzV6Ux3qWoCTc0AEV6kR5wq8iC21t8gHoYICejkw8Ij66KQb3RdBdJ+ge74EJniqompmifMdM0TkS7onWuqRsxs9iuqIc7uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(6123799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmR6NXQvT2FPbmtQNmJ4d0RwNFZzclNETHZCRGVONVl1bzJtUFJ2cldBYVhI?=
 =?utf-8?B?bGpzVGl2b2lGZklUSytGS2g4L1NTbWNPK2R0am9ObVJVR3Zsa3lvaEdGOTR3?=
 =?utf-8?B?UmJKM1F5NHAydnovMEtkd0NVTExBU2VVRGRram9nMXMzMzZWTVdqbzBXTVNy?=
 =?utf-8?B?TS9zYUkyUS84cU1QMklWN0VrMFE1ZmZFTUhGUmpVLzRhL2M4VHJKTUFpT3RX?=
 =?utf-8?B?Z2Y3SFp4bi9VODljSlMyT3ZHYU1uQXB6RWNNVnR3alhpYkJFWkg0MEVMc210?=
 =?utf-8?B?SHpycFlHZklLSTVCczc1SDFDeE9jcHpYeUlud21OdmFwWUVTdW95MmlrUEpG?=
 =?utf-8?B?TzZnVTZTT3JNSHRBZXRoL3BuSVVtNjIxYTFtS3Vjb1paL0s2Q09tV3RXTEpC?=
 =?utf-8?B?YzNvQWpyaFlWUSsxRldqN3FBV1dMMmQ2ZFd6RE84N1lWSzFCb3k0c2VDMFd0?=
 =?utf-8?B?QUJOMWV6Sms1YVp1cGhBVDErb29kK2FnT2hYT2pjdXdQc25sTmRwRjZPYkF4?=
 =?utf-8?B?d1VQTXdSTURleThZeWQwYlgwL3VHWjBCaGZrSWFnc01CT1N1RWtvaDVNTXg0?=
 =?utf-8?B?ZXkyZmpnbTJhcDJoRjVNc2N3MUZ5QVNpZDNRNkZCTytuL3hKaDBySzFVVzNa?=
 =?utf-8?B?UXNlckZraHcwRTVES1dJRTJRaEdDbW8zSldaKzdCRFlQaG5NVkUvOElHREkx?=
 =?utf-8?B?OWFBWjViWWN2ZkpMK08vcEdidVRpbXhBT3BuTDZ0REp3NFpSSWxkdmUxNnNQ?=
 =?utf-8?B?d255bmxKWGNGem5TQW5SUkdwTHdQaHkyTWtaK3ZlWmpFL2pVYnEzcEtQVElw?=
 =?utf-8?B?bitkc0EvSjdwazZRSEo0TFlNTHljemJMVEhMbGIyN1NjOGFjdDdjVzhZOGpO?=
 =?utf-8?B?SnU1RytneGVsaUtjTEg4eGduV3orbnZJdmF5eE5nNUEzZ2xKUlhjNU1UMEJJ?=
 =?utf-8?B?T2xEblk2UVBsellVM1dyb1dOcGNjejliUzY5L1hUZEQzMVBVSjl4NVJDRjE3?=
 =?utf-8?B?bk0rRlNrUXNXNEFPOENoTDAxTnhPWk12enRDalBpU3ZnWUtUWkwrSS9DTVlz?=
 =?utf-8?B?UTgyRnVkWUVNYmVDSGh3QnpzU2x1dU5naDliOFg2a1BnZ3REWGRJUXUvNGdE?=
 =?utf-8?B?b3dPWHh4U2FqbFVrREw3K0ZWckMvdmNoN1JnL21kbXVlUko4dHQvcWtMeGxM?=
 =?utf-8?B?TFZXY2NBQ1V0Yy91TjVOcTZyNUNZVlI4L2R2anRZWW9nWjlTRGY4b25qYnVk?=
 =?utf-8?B?TDdnMkNncUw1aFdvVUE1MXlDMXNtQ0lkcHhVa0NwSkNmSlZvVmM4aEEzcDdQ?=
 =?utf-8?B?S1FrVjd6dlJHb0lYVnVUYnhZeGJzRzUxMVdpUE5idUpLeU42eWkrcmFPV2J0?=
 =?utf-8?B?cE1RZEp4anJBcnJxbVV1RjVOblU5Tnl2MGZQaVJ1ZHFid3Zwd0F5bWtCRmJO?=
 =?utf-8?B?Ymo0dVV4R0RPRzB1Y2JmbktxalpZTEJQV05TTmtQR1hadzFxRkZFZG53Yi80?=
 =?utf-8?B?ZC9Lb3N3dXpUcUtpY2pPTlZ6YVIxM1RxZ05VUnRSeW1zczVCQ0pZZTBsSEtI?=
 =?utf-8?B?dlFQdTM2Qnh5em96YzFBOUg5MWFVVVhrc3FiZHM3TnA5eFQ0dnZ1WFo2K09J?=
 =?utf-8?B?S29ZRTZMWWFjUjNmU1pSTmo1TGV4aU5rZlhOOGRVNzBvTEFsYmdMc2R2SzJL?=
 =?utf-8?B?WXQ0VlFWSnJmU2FnVG5XNzRVWmNtUmgxRWd6bXZIMmlac2JRS0VIMVpvanhL?=
 =?utf-8?B?SFZrUEZmTUtDd3ZZdnV0VXE3WUVTL1pHeG1QdkF6U1ZGYUJmdXRGZEVESUtS?=
 =?utf-8?B?cEMrV29IMUdQTmxSTTh6Z0NjTTdFYlpIbGx2L0RET2NOTWdIOTlPZk1wZTBj?=
 =?utf-8?B?YWphZHhJMk5kMHpsQTNaOXNsWitzY3ZrL0JvaWhSK1ZLVmF4MUNWYlVRV21z?=
 =?utf-8?B?N1NBMTBab0RqRFE3VlhsbFJwT05EZTJSeUlucGtJU28vMXpPSHNJeUZEZHhD?=
 =?utf-8?B?QXNMNHBteG9ndHU1U0pBUVZabm1TYXdOeTQ1dlVyMFVkWmRSSXRjV1hqOG1i?=
 =?utf-8?B?aEE2TjRzRW1IakFwcTNlZkR6WTE2OUFDbmIwakxQc0FML3U5dFJPVVlmOEdS?=
 =?utf-8?B?Z1FtZStJbWpCUlUybkp3cTlHNEFZdEM2UmdiT0tud0ZOTjJDbXl0NjZUbGdv?=
 =?utf-8?B?MXMzcWxUU0phMUV5QU9XNm5wMDRzMkZDWmxUTUxXZEVuZENJYm56U0w3a0RH?=
 =?utf-8?B?NEIvT3JSYTkzK3hHcnBNcHlnMUd6WmxYOE9DYkZlQm1URGxYbFNac3d0Wlk2?=
 =?utf-8?Q?4tf67RtcUU47nFlgkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4029d6b-7c7b-421c-6a76-08ded616b12a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 19:43:28.5679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMLxKE/ROXCH7xdFrzwTMBnRhAXBVBL1ExFwb18turPLk3/Wv/nte4Pa3BMLu37h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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


On 2026-06-29 14:37, Mario Limonciello wrote:
>
>
> On 6/28/26 19:50, James Zhu wrote:
>> After moving TBA/TMA from GTT to VRAM for GFX9.4.2+ in commit
>> 5088a1ba6d6d, direct pointer dereferences to CWSR buffers became
>> unsafe because VRAM is accessed via MMIO (PCI BAR mappings).
>>
>> Direct writes like 'tma[2] = enabled' and memcpy() can fail or
>> produce incorrect results on non-x86 architectures because:
>> - MMIO requires specific accessor functions (writeq/readq)
>> - Compiler optimizations may generate invalid instruction sequences
>> - No guarantee of proper memory barriers or atomic access
>>
>> This patch converts CWSR buffer access to use struct iosys_map,
>> which automatically handles both system memory (GTT) and MMIO
>> (VRAM) correctly by:
>> - Using writeq/writel/memcpy_toio for MMIO regions
>> - Using WRITE_ONCE/memcpy for system memory
>> - Providing proper memory barriers and access guarantees
>>
>> Changes:
>> - Replace void *cwsr_kaddr with struct iosys_map cwsr_map
>> - Detect MMIO vs system memory using TTM_BO_MAP_IOMEM_MASK
>> - Use iosys_map_wr() for writing trap handler addresses and flags
>> - Use iosys_map_memcpy_to() for copying CWSR ISA code
>>
>> This ensures correct operation on all architectures while maintaining
>> backward compatibility with older GPUs and APUs that use GTT.
>>
>> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
>> Co-Authored-By: Yifan Zhang <yifan1.zhang@amd.com>
> The correct tags would be Co-developed-by and Assisted-by.
JZ] Thanks! I will correct it.
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 63 +++++++++++++++++-------
>>   2 files changed, 47 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index ad4897f094a2..6e559aab4009 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -32,6 +32,7 @@
>>   #include <linux/atomic.h>
>>   #include <linux/workqueue.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/iosys-map.h>
>>   #include <uapi/linux/kfd_ioctl.h>
>>   #include <linux/idr.h>
>>   #include <linux/kfifo.h>
>> @@ -710,7 +711,7 @@ struct qcm_process_device {
>>         /* CWSR memory */
>>       struct kgd_mem *cwsr_mem;
>> -    void *cwsr_kaddr;
>> +    struct iosys_map cwsr_map;
>>       uint64_t cwsr_base;
>>       uint64_t tba_addr;
>>       uint64_t tma_addr;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 8e701dcda8ec..7fd65c31afa2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -33,6 +33,7 @@
>>   #include <linux/mman.h>
>>   #include <linux/file.h>
>>   #include <linux/pm_runtime.h>
>> +#include <drm/ttm/ttm_bo.h>
>>   #include "amdgpu_amdkfd.h"
>>   #include "amdgpu.h"
>>   #include "amdgpu_reset.h"
>> @@ -745,6 +746,21 @@ static void kfd_process_free_gpuvm(struct 
>> kgd_mem *mem,
>>                              NULL);
>>   }
>>   +static void kfd_process_free_gpuvm_map(struct kgd_mem *mem,
>> +            struct kfd_process_device *pdd, struct iosys_map *map)
>> +{
>> +    struct kfd_node *dev = pdd->dev;
>> +
>> +    if (map && !iosys_map_is_null(map)) {
>> +        amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
>> +        iosys_map_clear(map);
>> +    }
>> +
>> +    amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, 
>> pdd->drm_priv);
>> +    amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, 
>> pdd->drm_priv,
>> +                           NULL);
>> +}
>> +
>>   /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
>>    *    This function should be only called right after the process
>>    *    is created and when kfd_processes_mutex is still being held
>> @@ -1192,8 +1208,8 @@ static void kfd_process_destroy_pdds(struct 
>> kfd_process *p)
>>           if (pdd->drm_file)
>>               fput(pdd->drm_file);
>>   -        if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>> -            free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>> +        if (!iosys_map_is_null(&pdd->qpd.cwsr_map) && 
>> !pdd->qpd.cwsr_base)
>> +            free_pages((unsigned long)pdd->qpd.cwsr_map.vaddr,
>>                   get_order(KFD_CWSR_TBA_TMA_SIZE));
>>             idr_destroy(&pdd->alloc_idr);
>> @@ -1501,7 +1517,7 @@ static int 
>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>       void *kaddr;
>>       int ret;
>>   -    if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || 
>> !qpd->cwsr_base)
>> +    if (!dev->kfd->cwsr_enabled || 
>> !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
>>           return 0;
>>         if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && 
>> !dev->adev->apu_prefer_gtt)
>> @@ -1516,17 +1532,28 @@ static int 
>> kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
>>           return ret;
>>         qpd->cwsr_mem = mem;
>> -    qpd->cwsr_kaddr = kaddr;
>> +
>> +    /* Set up iosys_map based on whether memory is MMIO or system 
>> memory */
>> +    if (mem->bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +        iosys_map_set_vaddr_iomem(&qpd->cwsr_map, kaddr);
>> +    else
>> +        iosys_map_set_vaddr(&qpd->cwsr_map, kaddr);
>> +
>>       qpd->tba_addr = qpd->cwsr_base;
>>   -    memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, 
>> dev->kfd->cwsr_isa_size);
>> +    /* Copy CWSR ISA to buffer using appropriate accessor */
>> +    iosys_map_memcpy_to(&qpd->cwsr_map, 0, dev->kfd->cwsr_isa,
>> +                dev->kfd->cwsr_isa_size);
>>         kfd_process_set_trap_debug_flag(&pdd->qpd,
>>                       pdd->process->debug_trap_enabled);
>>         qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
>> -    pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
>> -         qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
>> +    pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_map:%s at %p for 
>> pqm.\n",
>> +         qpd->tba_addr, qpd->tma_addr,
>> +         qpd->cwsr_map.is_iomem ? "iomem" : "system",
>> +         qpd->cwsr_map.is_iomem ? (void *)qpd->cwsr_map.vaddr_iomem :
>> +                      qpd->cwsr_map.vaddr);
>>         return 0;
>>   }
>> @@ -1536,24 +1563,24 @@ static void 
>> kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
>>       struct kfd_node *dev = pdd->dev;
>>       struct qcm_process_device *qpd = &pdd->qpd;
>>   -    if (!dev->kfd->cwsr_enabled || !qpd->cwsr_kaddr || 
>> !qpd->cwsr_base)
>> +    if (!dev->kfd->cwsr_enabled || iosys_map_is_null(&qpd->cwsr_map) 
>> || !qpd->cwsr_base)
>>           return;
>>   -    kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, &qpd->cwsr_kaddr);
>> +    kfd_process_free_gpuvm_map(qpd->cwsr_mem, pdd, &qpd->cwsr_map);
>>   }
>>     void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
>>                     uint64_t tba_addr,
>>                     uint64_t tma_addr)
>>   {
>> -    if (qpd->cwsr_kaddr) {
>> +    if (!iosys_map_is_null(&qpd->cwsr_map)) {
>>           /* KFD trap handler is bound, record as second-level TBA/TMA
>>            * in first-level TMA. First-level trap will jump to second.
>>            */
>> -        uint64_t *tma =
>> -            (uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
>> -        tma[0] = tba_addr;
>> -        tma[1] = tma_addr;
>> +        iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
>> +                 uint64_t, tba_addr);
>> +        iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + 
>> sizeof(uint64_t),
>> +                 uint64_t, tma_addr);
>>       } else {
>>           /* No trap handler bound, bind as first-level TBA/TMA. */
>>           qpd->tba_addr = tba_addr;
>> @@ -1619,10 +1646,10 @@ bool kfd_process_xnack_mode(struct 
>> kfd_process *p, bool supported)
>>   void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
>>                        bool enabled)
>>   {
>> -    if (qpd->cwsr_kaddr) {
>> -        uint64_t *tma =
>> -            (uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
>> -        tma[2] = enabled;
>> +    if (!iosys_map_is_null(&qpd->cwsr_map)) {
>> +        iosys_map_wr(&qpd->cwsr_map,
>> +                 KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
>> +                 uint64_t, enabled);
>>       }
>>   }
>
