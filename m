Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F3C5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 15:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F059D10E55B;
	Wed, 19 Aug 2026 15:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r9aS3KqW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA54E89EAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 15:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2xtFz/fXmZNmykshZwn9x2cDhNPjXQ7fuJONxSj0Fm9fZ2wFlGu2OFoTPXJ+Tv/8Y9B/MtRERWx8cMD6hbu9owWPlyckbbqx2yy2vGeGfzSPijf9nqxiVPMJ0Po0yQFGPTmi+xii8qlxLIjXEzZccCpsYXg+0kAbmTYXmOClitmDTUtaCAKH9mTd5RamSYPwjGUOejjhJqZx8VaH22meNl/aKYw9vpDGaoV5O7OdmS0g0i/myjU0F1hoZy4VR1DE5QLMN5UEDgDNjxXyjSucLeqRr6EqLv9Iofk7oyk+dx4Tq1I/GGHnX/OosyCa9jaH7ieCO2OkCSh6nvQnyCtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYNlRak6zLFtWejdw4WZEX5b3Mqf8dsZ2yifGzRkS88=;
 b=k3WFyoZiZh1bAKgSrEjE1UaR/01KhoypK8lMA1ePK3ucpQPo6gf9745mCaq0Icwsz96KZ01OZH4xiM9/31ujuCHMr268axUE8YvztzVURsgbFIIF4KJFNkqRNgsKBuhEHXAxszQR+BARBCk7khtXjqWeSl05i8R6rxxBwd45Wq64ToMmS9qf0PU5guK2zwaRH8Opl7UTb93t06YMgPaAlMs1vVlVMi/flSlKKRsCBexFWK8of+kMnfX4DFDQBk5hc/AWnd23VVwA9xEEUaaX1vZUMLzXbzWWAZSPE9gW/YpXIB/y9iAM1WkrTECtWfT4cyf2wVlI1LvVGmH6p22bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYNlRak6zLFtWejdw4WZEX5b3Mqf8dsZ2yifGzRkS88=;
 b=r9aS3KqWEzZaOTSd1HtwUvjbqu6ltlk13QbzSMdogAhy/C3s9/MaosCGvfCxkMQMxxoTQGuRdex1lr3agAhgLx/U6dfCQ4hwC3Vr4zDoM1sSybMeGN7DuyNwaLq/C0KvT4yqyt4n/dCo610G41Ecn97mUhDUuLpXmWngAucJI7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:16:58 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:16:57 +0000
Message-ID: <5192fdec-ea47-4d04-b879-47b38d857fea@amd.com>
Date: Wed, 19 Aug 2026 10:16:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Check cpu page faulted vmf->page got
 migrated to system RAM
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260817135918.228397-1-xiaogang.chen@amd.com>
 <20260817135918.228397-3-xiaogang.chen@amd.com>
 <ce510a57-f99d-4a2f-9af2-132e388260aa@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <ce510a57-f99d-4a2f-9af2-132e388260aa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:806:d0::20) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 57069327-63f9-4902-70ce-08defe04e8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z45URQzTTCSHBotFl/9gUKuPYeADlObDumA0jg4Sc2ytpxdK/Izx9DARW6ONX8c9/QNys4emORWXkG8lJN9N8pw6tYe/cCzrMp2YEE91nA4mhK1g2mMENupMg8EydpEgDngM74IIZM2uvs/iMVfsn24r65sZGzT5v6H4rBU7vvse9L84JDzyoyKXF+l6SmnLH5VbD5EvEoi+azUcExCut575oQVmg6RdmZQeTikZnHUQjydx2rXm2Z0KVEbcMRmWCBfYbwThwFdtX2I6H25os5bRmiguc0Tne0wSVRAVZV/O/O7ndpm3miG2NHeicljqKmBeULGEpcTVD20t5+yriDdGon8vYATQwdYOxw8YNV/N0PaKqgdX2ZqZx1IEGy8RHjp0k7MdCfmK9C76z5uKvs6cIVQZCJxPt7BtnwbAGPM0TiSmPjbnBvttGso4Pnna1nm9DERjJW6pPDWikJxBEHBFBKtd4FjBJztkrxOARBQGPQPnJDzGQVuq2PXsf1/7dhAR4lun37YTTb3QGKCiNeMjTh2l5Z5HIDD9XbvNT6Jxj9FPOePTx8e+aflNuB69vKB/RMhLoa+FC5eXB586vQTTJFeNsqlfmPD6l1ZA/aT1NjbAROzCLK5+zUuVEDKzLjh7lRprdCNvZO4xHpfNQhqJfCl20lVvN4E9Q+tJ58A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNxSDdNa3F0NFRJcUNzTXpWQzUzZEFDNWMxL0FETDFseC81OEFKbEp2Si9o?=
 =?utf-8?B?VU1EOWRaWWlkVzR3RGpML2Joc0l2RXBvZkl5Mm9hYkVtOVQyQnVGR2oxZWhJ?=
 =?utf-8?B?UFJReWVCK2JMMHh1cEFPMlBtaFpzU2dLcjR5azVtb2VydHZVOXVpRjhTbjF0?=
 =?utf-8?B?K3B2RCs2Tm1NcTd1S05MWXYvaW9yRzlGTlkwRVdlcG56S09VTW9tZW51MWNB?=
 =?utf-8?B?Qm4xYUp0dS8vOUNrczJ3SkRSd2Y2dUVUZWJqcjdESmpuSDQxWndaSjI1SktQ?=
 =?utf-8?B?UTBLMnY1KzBxYjhCbjhRcVdBaHFXY1dSZnNBUEpVZVpHVTFPdlVPM1plY2RJ?=
 =?utf-8?B?YnB1UDRza1VUNllYb0N4MXJQUEFsWjg3S1Z5RzdZS3UzMHl3Z1ZZckt4c29v?=
 =?utf-8?B?MUVHNTFHM29kcm52Z0U0dTh0SldCWkZmRnI5NDc5UVEzQTNMQmhzYVIyKzRo?=
 =?utf-8?B?UTRQUkF0ZXR0ZGV5SERwWGd1dVE4ZmQ2a1UwQ0s4TFFBTGNCMnZYRGcxOHk5?=
 =?utf-8?B?MU1sWGp0ZHdJaEpDWEhVSVFBU2dvckROWnhtcUNqZCttNERkYWQ4bnk1cVIv?=
 =?utf-8?B?d29zYjJuKy9tcmI0NWJuK25oRk8wbDhlbFFrWGUxa3FqcGlTUGRKajkyS0JG?=
 =?utf-8?B?cUNScHB2S2xiVzd2N2MxclZ3M2hJTE9aOHFaL1p0K2dvdkQzTWVnZnFlajRL?=
 =?utf-8?B?NmxCUzk0OHBONlB1NjQveldySktldVc1WXJZcHp1MWdrdk5yMURLNlo0N083?=
 =?utf-8?B?ZkVNOTdyUkZ6Tm5CVVRVM3NGbmN4YjR0c1Z0NWo5RFhlbWJNeHVVOTFTbnJO?=
 =?utf-8?B?SzhUZElDMGZGblhOb1lIREk4T1R5aVd1aXJsc0hBNGMzbWRHaWd4WjdqVEVX?=
 =?utf-8?B?S0d4cm9JdXhxWTlCRHdORlZyZHVnaTBMaUQzU1dmbzh2N2FwYks3MkhTRHVn?=
 =?utf-8?B?RjNVRng3M1V0S3o5ZnEvdGU0L1pEQTE1WDNCWVdXSVBSa2J3aFMrM3ZwWjFR?=
 =?utf-8?B?ellvZ3pJZVpudXRSRFg5aCszMEIvRzF5NHhmVnZqdVJSblJYVExTa0dSU2xt?=
 =?utf-8?B?SzBRTVAvcWRvYkt6eUZYSUJ0c2l3SUNnV0xpWDA2VUY0bzJPV1JHWjA1SThx?=
 =?utf-8?B?MW1HejFFYXNUbXJxMW5uWjhkYmNWU3hxb0pPT1RlVTBkZHJrVFI5QlRJcjkv?=
 =?utf-8?B?WTFKNkhhaExrWE1iWFoyZ21zaGx2WUVSQjZIeHE5MGNoa1p2TXJVZUdvbVln?=
 =?utf-8?B?ZVdEbWNLTmpOWFFxMjB1KzkxRHZJeS9GZlB6VFZ2Uk9BeUlwZm9uZERxbTJw?=
 =?utf-8?B?WTZkdmJGNWNmTld1MnhGZEVqUHVCWVZOSGZqemJVaUZUQ0NxVm5SR1FhYVYr?=
 =?utf-8?B?K3FKSVczdFlaOFduWkJXT2NPRmtwOVp4ZXRpZEQ0WWtxbi9FQzM4eGtKYXA5?=
 =?utf-8?B?cHh4TmFtR2txY0pNdkQvYm1xS0Jlb05QYlRRK241RzV2U0QwUnJmd2dzT0tu?=
 =?utf-8?B?TjBTeTM2WVIwd2xKUEJyc2V3ZTBmV3Q1ZEtETUNSMlAzemM0Z1orUDhmMkxJ?=
 =?utf-8?B?YjBBTkNSSHdWeW1OZXJ1SUpTNVRGWUltZ3BpWEREbkVsMmlCdjJpazFQcG5Q?=
 =?utf-8?B?UVRtZHc2RS9YcEZjb3hWakQ2bWR0ZlBacy9PRWJ3UU1zK1VGYTQyTnp5TWM4?=
 =?utf-8?B?TGdUWVFtYWNCSjJERTkvSFUrZEx6UURzYzZYTElYS1V3UTlWY2ZqSy9VR1Ar?=
 =?utf-8?B?UkVQMGFvcFFxVFhKbzgwYUd0M2hyUThaaC9uRWxGeExEVjR6SDNMaTJ2RDRH?=
 =?utf-8?B?d0hRVVhGMTVJMFBCckI3L2FpRmYyd2thT0VkVzVsaUoyeUN6UTNkOVZ0ZlhX?=
 =?utf-8?B?a1d0T1I5amhLYWRXbkg5Zi8rYmswdkZYQXAwaHFGcWNqT2NpaDVxOVFCdnZ6?=
 =?utf-8?B?bDlYV2kwN3NmODhIVFBORmhaUXpHNDRiN1RwUWswVlNvU3BaQXErekZkVmsr?=
 =?utf-8?B?V2hjWkRGdk01M1NHaVFxa0xXQVVUUVdCMDREcVFGNXpFeDZjT3pISnZBNEVQ?=
 =?utf-8?B?U1g3UmM2M2FVSFNydFhqMzB1SXJFNmpIYzNwZUdMWHJBUlR2MEU5UHVodVNQ?=
 =?utf-8?B?R1B4eWhGYVl5VHB5S2lvVnhwb1d4VGJ0cjR4NDF5eHVueGlMRkp3MFExTFVj?=
 =?utf-8?B?aUFnZlVUcTl6YjR0TUROcXRBeHZmeXZRSkRnV29PUW5JSjJpeFhjUE44VVF3?=
 =?utf-8?B?aGV6SmhCZVZVL25iNzRFa3VrKzlJd1dvQjRyOFoxY1Q2c243aGJ3eWNjNVpW?=
 =?utf-8?Q?IlmnxoZF4aXv9Y8gPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57069327-63f9-4902-70ce-08defe04e8f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:16:57.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +05dSSUGucmpRmqskgzTJv2OKDaXvbhCVZCMtGU1cj/TKZZNTyz27yOBNh3fHX0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
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


On 8/18/2026 4:36 PM, Felix Kuehling wrote:
> On 2026-08-17 09:59, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Cpu page fault hander __handle_mm_fault calls 
>> dev_pagemap_ops->migrate_to_ram
>> when faulted page is device private memory. This callback needs 
>> return either
>> success or vm_fault_t to let handler know what happened when handling 
>> the fault.
>>
>> Current driver returns success if it did not hit a hard error. That 
>> does not
>> means the device page is now in RAM. Some cases like fault page pinned,
>> lock fail or other mapping prevent faulted device page got migrated.
>>
>> Then the CPU instruction will fault again(retry loop), unless 
>> something else
>> changed the PTE.
>>
>> The patch explicitly checks if the faulted page vmf->page got 
>> migrated to
>> system RAM. If not, returns error to let cpu page fault core handler 
>> handle
>> the page fault in error path.
>
> Are you sure this is the right thing to do? If the errors are 
> transient in nature, then maybe retrying is the better option. What 
> happens if you return an error? Does the application die with a SIGBUS?
>
> Should we consult with an HMM maintainer here? Did you check how other 
> drivers with HMM support deal with this situation?

I notice this issue by reading code, not from real case. pinned 
/not-migratable vmf->page -> no copy from this page to sys-ram. It will 
trigger infinite retry,

I checked drm_pagemap_migrate_to_ram()(xe driver) and 
nouveau_dmem_migrate_to_ram(nouveau driver) that handle cpu page fault 
from device private memory access. They do same as amdgpu driver: skip 
pinned page or populate skips the slot that is (!(src[i] & 
MIGRATE_PFN_MIGRATE)), so those bytes are not copied, and the function 
returns 0.

For NVIDIA Linux open GPU kernel modules at 
https://github.com/NVIDIA/open-gpu-kernel-modules: It is more 
complicated. I asked Cursor analysis: NVIDIA UVM has the same 
CPU-visible outcome for a pinned vmf->page, but it does not return 
VM_FAULT_SIGBUS, return NV_WARN_MORE_PROCESSING_REQUIRED instead, then 
retry inside kernel.

This patch returns VM_FAULT_SIGBUS for that case, then fault handler 
sends SIGBUS signal, the default handler of this signal is killing the 
process. This may not be people want.

It is a blur area. kernel-doc for migrate_vma_setup():

  * If the caller cannot migrate a device page
  * back to system memory, then it must return VM_FAULT_SIGBUS, which 
has severe
  * consequences for the userspace process, so it must be avoided if at all
  * possible.

Summary:

Current xe/nouveau/amdgpu driver do not return VM_FAULT_SIGBUS, just 
think it is success. That may cause #PF handler retry loop between user 
and kernel space.

Nivida driver does retry inside kernel.

This patch detects the case then return  VM_FAULT_SIGBUS.


Maybe you said retry fault handler inside kernel is a better way: we let 
driver return VM_FAULT_RETRY for pinned vmf->page, let kernel retry 
handle_mm_fault, then hope the pin will be drop soon?


Regards

Xiaogang


>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 28 +++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 263dae49bb3e..656197dee9b1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -582,8 +582,9 @@ static void svm_migrate_folio_free(struct folio 
>> *folio)
>>   static int
>>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct 
>> svm_range *prange,
>>               struct migrate_vma *migrate, struct dma_fence **mfence,
>> -            dma_addr_t *scratch, u64 npages)
>> +            dma_addr_t *scratch, u64 npages, bool *fault_handled)
>>   {
>> +    struct page *fault_page = migrate->fault_page;
>>       struct device *dev = adev->dev;
>>       struct page *dpage = NULL;
>>       dma_addr_t *dst;
>> @@ -646,6 +647,13 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>               goto out_oom;
>>           }
>>   +        /* if this spage is not migrated the function returns error
>> +         * final decide whether the fault got handled is decided by
>> +         * fault_handled and this function returned value
>> +         */
>> +        if (fault_handled && fault_page && fault_page == spage)
>> +            *fault_handled = true;
>> +
>>           pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
>>                        dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>>   @@ -701,6 +709,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>    * @node: kfd node device to migrate from
>>    * @trigger: reason of migration
>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is 
>> CPU page fault callback
>> + * @fault_handled: whether CPU page fault got handled
>>    *
>>    * Context: Process context, caller hold mmap read lock, 
>> prange->migrate_mutex
>>    *
>> @@ -711,7 +720,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device 
>> *adev, struct svm_range *prange,
>>   static long
>>   svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range 
>> *prange,
>>                  struct vm_area_struct *vma, u64 start, u64 end,
>> -               uint32_t trigger, struct page *fault_page)
>> +               uint32_t trigger, struct page *fault_page, bool 
>> *fault_handled)
>>   {
>>       struct kfd_process *p = container_of(prange->svms, struct 
>> kfd_process, svms);
>>       u64 npages = (end - start) >> PAGE_SHIFT;
>> @@ -771,7 +780,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>           pr_debug("0x%lx pages collected\n", cpages);
>>         r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>> -                    scratch, npages);
>> +                    scratch, npages, fault_handled);
>>       migrate_vma_pages(&migrate);
>>         mpages = svm_migrate_successful_pages(&migrate);
>> @@ -816,8 +825,9 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>                   unsigned long start_mgr, unsigned long last_mgr,
>>                   uint32_t trigger, struct page *fault_page)
>>   {
>> -    struct kfd_node *node;
>> +    bool fault_handled = false;
>>       struct vm_area_struct *vma;
>> +    struct kfd_node *node;
>>       unsigned long addr;
>>       unsigned long start;
>>       unsigned long end;
>> @@ -861,7 +871,7 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>             next = min(vma->vm_end, end);
>>           r = svm_migrate_vma_to_ram(node, prange, vma, addr, next, 
>> trigger,
>> -            fault_page);
>> +            fault_page, &fault_handled);
>>           if (r < 0) {
>>               pr_debug("failed %ld to migrate prange %p\n", r, prange);
>>               break;
>> @@ -886,6 +896,10 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>           }
>>       }
>>   +    /* need handle cpu page fault, but not handled */
>> +    if (fault_page && !fault_handled)
>> +        return -1;
>> +
>>       return r < 0 ? r : 0;
>>   }
>>   @@ -1027,7 +1041,9 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>   out_unlock_svms:
>>       mutex_unlock(&p->svms.lock);
>>   out_unref_process:
>> -    pr_debug("CPU fault svms 0x%p address 0x%lx done\n", &p->svms, 
>> addr);
>> +    pr_debug("CPU fault svms 0x%p address 0x%lx done with erro=%d\n",
>> +         &p->svms, addr, r);
>> +
>>       kfd_unref_process(p);
>>   out_mmput:
>>       mmput(mm);
