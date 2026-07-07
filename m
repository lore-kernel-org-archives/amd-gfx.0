Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529DC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7658110EBF3;
	Tue,  7 Jul 2026 08:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c712ADuF";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006E710EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Xlmj7cm2H4d+/ZCuz2g1SQElQyeaGd/PdqLYFa0yiAa0eKaTEOxt3EQgm6g3yfYjupAQkg66IC5nEgJVOya3Uu9GXjBuzYFzCkV4v8rj8ditxQc5oXcH5f9GMkZuxzhqomGTqpJAludU+RBZasbPuE7PM7V3JJdLjwmo/kjAu7eOkPbxbKFWX5Adoz4CVzYkfPEBREDjKKZipejQbv3UVlV0Ih/wZo6zMvyx43AB3HgJWhmynCQvBKJ42een+IWkyN2HHSqc9shI7IR+DtdlauKP6f2BDX5DSmbvDPAOgryxm0YDDXat7eBv+31wGMInrJol7mNTf42bEgkuJnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0SmTmvJ21aCOlXSaGA4+D0cVmwKKWEb/p9/Mfq5umU=;
 b=WT5LQ2ulv+dud6vjFHBCcQ7bWVclZhOVwdX6k5QKZcBY/nc6zNJ2b5SRWFEUTsNVfQkuzMDLGJYLAUeKpLuKJw5VqgHBt8H773p6ShgjNwZMhWHa4nfJAkA9Y0XL3Vs4TQESsKqmC+P5SzA6UhQkLwk629JHBqZeX6ZmoBxZ2+VWpIeoq+DcgqZ8BjLYOs1JtJQbLUB5zaobWzoBK3kWR8jC8Rlhk5lEa8Jjvgj1eSALSH6GAoGcVScJ9KOlVomGkqQggN+7Ttr5QfPAgf000FQahc+MVnVo45kNljktelG/W8NGaFyNlH6K+tuuHy3y81ecZh7H5URPuutrkmg5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0SmTmvJ21aCOlXSaGA4+D0cVmwKKWEb/p9/Mfq5umU=;
 b=c712ADuFkg9cVKUS/A+DXOxCb0h0d8B0MOUKwXK6u16Z7vhfpPmf7ObcE/ToXreYKRr41jPjKnnxjIIMK/dxBoY0frGq7u7xAcC1CR7kyXYwcdfNgNqX1Xz3cdXL0xvmDpofvviPcum1lcaOvoovCwllSFKLmNxdceqW1wwPqLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB999086.namprd12.prod.outlook.com (2603:10b6:806:49f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 7 Jul
 2026 08:32:35 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:32:35 +0000
Message-ID: <e8f08938-f230-40e7-9e97-6403d26461f1@amd.com>
Date: Tue, 7 Jul 2026 16:32:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, natalie.vock@gmx.de,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 timur.kristof@gmail.com, Huang Rui <Ray.Huang@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20260529114031.3714-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB999086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3465e412-e23f-4e4b-a6d8-08dedc024b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 1GSnn2vu4OOxmcilmAEcYgGjf87gg0T9MASGCuSs3T3OvlvdI6S+LlT3B+PbBLg4mSGt8yI/JBb+v6nmpG+W9ghEqiIwryFoHabPDrJGfWvtoIeHrz0Mg5GaBfGTuzFfpd2BShgu0Rrt5tLYOfqMxUoCGlzNWrxFj8rmRszoV3cw6bOyxMWNb7Tp/28vZsv59FNAoxf9CVL9bfiJKc+FdIfOahF203mm0NnsYNtgQTCUqevvTeLkXxYpKHMe4MbKpJeAq5LoiOHW48Np6G0HGQGHd0PvHo54+hrFT8cjI5//rAnNQvDblauYF+T+BoCZ+yy5VjUuBX9t4FoHRNq3HSRS7I2mYxMyQTuOToM5K7nKmWqxBCqxUEHXHqhnBQsK3rZyEG8QnTdDD2RWXUTlesBOxW5tMwhyiJSH8yZOa52JCcMjX1To0cAaOKf6MTQJAzLDyggkh9wa42aj4XYIg1hjNMYLYAk/hpOPYGMYekMMRXTOpzubJBMa0JExwd/ANoIy7arCtCxhHGh9EoTK6bAMWZBgEFSTWwMUHFpIJ6gkVjdBsfAoJIxbhQl0RFc4rZXrQ+kgIBNFxZTDia0Tu1ffG9ELP7IE2kdCVv3g7D5S9Bg5LM0VZpMttCnytoYzEfW/2leDoFnu5KSlDyY+s0fy1y2q/ajjjy0sAx8LZQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElmcjI0ZUh4SEpLdmhISmRYTVlDenM2Z0pzaldvRDRPQThLNWlsV1pGWDZr?=
 =?utf-8?B?Q2hFRnNiS1MxTUk2WnhLdWhuT0h2MWdEeE1DbXFNblI1NDlTckdmZU5RWjY5?=
 =?utf-8?B?cEtFVGN2QS9XYm5UeUpISkd6d3JxdGNOOXFjd2dCYkxNdG5aQXN3emtYUHFO?=
 =?utf-8?B?WmZEcERBUDAzaDdmUkhnUDkzd0FRUHZYbGp4TU5TeHNaRlMyR2R2bkdSQXBs?=
 =?utf-8?B?OWc0Q1gyMStpVWhSL2FrSjBtWkJHOWt0L3BqMlE0TGZwN0dqamNxeFQyRXVz?=
 =?utf-8?B?N1dsWmxVcG9iemtsZG1yUkQ4N3hFSXBZaURUUUhjYlMzZUdtb3JRTjR5YjQ4?=
 =?utf-8?B?UzIySzJmRTJaeit5Y2xSOC9HSXp6QlFxWXhubVV4VzJWOXd4YVcyeWFRTno3?=
 =?utf-8?B?YloyNDl1OTFBaURqTENHUkNMaXVwbGdRZHFWZnpiTUkxbERMZmhHampWQ3Ji?=
 =?utf-8?B?Y3VqQy96OW5ReTFydXM3ZVlEVVRkNEdOa3hQUU93QUpXeHBRbEhVbWxvM1RV?=
 =?utf-8?B?bGpoZ29jVzhXRVhzcmdwVkJkUkIrUDYvRlRFYW16YlZwWTFCTUxaUzdGVlpZ?=
 =?utf-8?B?eE8zYnRJQlR4bElNVEVvM3k2VitkR3FCaVhaN29QWkJsa3ZZd1ptQ24zcitL?=
 =?utf-8?B?bm5aVzkzRUdTWUo1NjUxYWVJVkd1cmpMb3pZTDg0VDY4d0hhRmpUZmhwRkpI?=
 =?utf-8?B?ZTNNbUJUdjJqb0xMT0d2VVJkYVVxTXorWHZtVzh6RTJLNDZOZXQ2RFlzaE50?=
 =?utf-8?B?TFVOU1M5ZE1mMjFjNUdoUG9YaGQvZ3MrUS9xUTJYYjdlUnI0L1BtNzVqZGQr?=
 =?utf-8?B?WjJzY2lkWi9US01IOFlVRkxqM1dLVmVGQk1xSEhaMG9mbEFRd0ZPMjE1YTdj?=
 =?utf-8?B?SUdhYWVoMkJjVHViVWlmSW1vbHErTEtSeDl0QXBYZUpmNzZjMExQTm9LQk9N?=
 =?utf-8?B?U1RIWkRtTTdwNWhkU0lmYVNFVEoyY0JCaGUvK2UxY2h2czdNK1pkRFhnRE9E?=
 =?utf-8?B?OTlnQWd2dDJ6eW5nNkg2RVpyTUpFUU1hRytHMGEvaU5VOWtJT2VEYjRwVUNX?=
 =?utf-8?B?VGd2bjNCdXF2LzZZZWpad3BJOFJZelBpVjZOVmh3VlJZRWh5dm0vV0VESWZO?=
 =?utf-8?B?bnhiUXFoSm9oeEpzY2NibXNOUW1RWVl5TWI5aENnM3FwdXllRW1DTWhCbFMw?=
 =?utf-8?B?RjQ1YmFsNlhkdGdzZlZJQzBPNGx6TzVpZVlrcXFscDB4UjJzMDlURnp0aGlL?=
 =?utf-8?B?SmwwR0hsS0xGNlBXdENPNEgxTkZxMUJvbDV5WnoyaGo1TWZUb0VPWFFUbHor?=
 =?utf-8?B?MzIzZUI4cnhCZHV0dlcwMWlHakRpTTZNRjQzWXhGcjVJSTZhQ0xzUjl0d3lM?=
 =?utf-8?B?SW01TjF6d2t5Q0hyWGpBTnlPdXNtaUhBMXRtUlNvMlduR0gyWWRoRjhUVmd2?=
 =?utf-8?B?WnY5YlJFY2tIR1dCQlZ6d2IrN0cxUGVSZTJMT0thUjJxQjB6MTU3SUc2VWpn?=
 =?utf-8?B?Z1FuMm1ZSzhOblcvK2ZkVGIzNWI0UTIzTXNWUkJXZTIvM3dSUTNsZmtlaWIw?=
 =?utf-8?B?K3JneFNZelVDZFFxZ2RIeUFlOGtORkVoN2RZTTdTV2RINWpTNXUyU2RBdGlB?=
 =?utf-8?B?aEQwY2oxZk1BRzE1N2xWYUJjZy9RVXFyNkdNSmdnbStDTnRaZG9xZlVHWXNy?=
 =?utf-8?B?MVVYeHBQU25uWVNFZ3gwRXVSNjJOUW5NcDl0N1VVa3FZS0thYTg1UzVzOTBy?=
 =?utf-8?B?MDJIMktDZC82TE1JRUliNkM4bklZK0wreDhxSWJUZVhFaDlyM2hhUGlxQzhL?=
 =?utf-8?B?ZG1hUnd4dk5ZVksxWVp0NVlUeFh4bTVhTnJyaUVRU2k5WHlFV0JDOTRTSFFk?=
 =?utf-8?B?dXNWbDVSZWdHZzhZaHh4aFlwVE5oWWFWcVlraWtKME81MWF4LytQYzRGWVd2?=
 =?utf-8?B?Q1JldGJINUhCVng1TDN3Y2RvMXpFMlBRU1pUTVhOY3JUSitwWjRuYU01WlBC?=
 =?utf-8?B?SWwyZzRWdXR0VGhFcnhxU05TcmEyc1VDUDcvOTdXMTl5NzVETUxiRVhQa1pD?=
 =?utf-8?B?NUhXb0pwS1VmNk5NSUdtdW82Y3VjWFpKVklVa2JZbm9TTWhvL21EVEh2UFM5?=
 =?utf-8?B?MFArL2ZBU29jY1JoOFVuVFV3WEY2Y0daR1M3NkpHZkhXUXR4SmlFejZIUHYz?=
 =?utf-8?B?bk5JV0d3ZTNsaHBjS3hZbWZqNDhsSVJDREg4NUFocnpkSEpNUENYd25BcDd6?=
 =?utf-8?B?OGwrR0pkU0N4Q2ZtSVBMQnlHbjVyWFY0ZmNaejY3ZG9RMGgwblBqQkk1amFv?=
 =?utf-8?Q?FQQVFAbcBkYlUBQWOP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3465e412-e23f-4e4b-a6d8-08dedc024b5a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:32:34.9820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpqFAgDbK52XuLYqaEkxm1CA270XpUjuPcZ2gfVoaDJanejEGfWIdSgxYaFofVzVYQ3iyx9sr1nHnivbGmbE1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999086
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



On 5/29/2026 7:24 PM, Christian König wrote:
> Split amdgpu_vm_update_range into two functions.
> 
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
> 
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
>   5 files changed, 120 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 44fe40f9e8df..653ffa9ca0f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index edc8b1ca2d3e..b5adfcacc55a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   }
>   
>   /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>    *
>    * @adev: amdgpu_device pointer to use for commands
>    * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
>    * @sync: fences we need to sync to
> @@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
>    *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and free
> + * new page tables as needed. Can only be called while holding the VM lock.
>    *
>    * Returns:
>    * 0 for success, negative erro code for failure.
>    */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
>   	int r, idx;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> -	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_free;
>   	}
>   
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
>   		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>   	if (r)
>   		goto error_free;
>   
> @@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @flags: flags for the entries
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed flags
> + * value without allocating or freeing page tables. Can be used without locking
> + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			   struct amdgpu_sync *sync, uint64_t start,
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.needs_flush = true;
> +	params.unlocked = true;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r = -EBUSY;
> +		goto error_free;
> +	}
> +
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_update_leaves(&params, start, last, 0, flags);

Maybe need last + 1

> +
> +	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb = NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +	amdgpu_vm_eviction_unlock(vm);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> -					   mapping->offset, vram_base, mem,
> -					   pages_addr, last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
> +					mapping->start, mapping->last,
> +					update_flags, mapping->offset,
> +					vram_base, mem, pages_addr,
> +					last_update);
>   		if (r)
>   			goto error_free;
>   	}
> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false,
> -					   &sync, mapping->start, mapping->last,
> -					   0, 0, 0, NULL, NULL, &f);
> +		r = amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start, mapping->last,
> +					0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3e86a2a470f0..561f2873d2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				uint32_t xcc_mask);
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence);
> +			   uint64_t last, uint64_t flags,
> +			   struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 6f5415d5a1bc..ac3f3e31e2e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   	/*
>   	 * unlocked unmap clear page table leaves, warning to free the page entry.
>   	 */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		uint64_t incr, entry_end, pe_start;
>   		struct amdgpu_bo *pt;
>   
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering the
> -			 * address range are actually allocated
> -			 */
> -			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
> -					       &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
> +		if (r)
> +			return r;
>   
>   		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>   		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);

it always writes at the parent level and ignores a PTB that's already 
there, so an unmap ends up putting a wrong huge PDE on top of live 4K 
leaf entries instead of clearing them, will unmap extra area.
use a WA by just updating the 4K leaves directly when a PTB is present, 
and only falling back to the parent-level dummy huge page when there's 
no PTB, passing the right level to amdgpu_vm_pte_update_flags(). see 
below diff.

After apply the blow diff, tested in gfx1100, xnack off mode,
the kfd svm test all passed, rocr svm passed,
HIP test are same with the drm next branch 99% passed:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 50bf4ff43..657c7dfc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1289,7 +1289,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device 
*adev, struct amdgpu_vm *vm,
         if (r)
                 goto error_free;

-       amdgpu_vm_update_leaves(&params, start, last, 0, flags);
+       amdgpu_vm_update_leaves(&params, start, last + 1, 0, flags);

         r = vm->update_funcs->commit(&params, fence);
         if (r)
@@ -3133,7 +3133,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device 
*adev, u32 pasid,
                 goto error_eviction_lock;
         }

-       amdgpu_vm_update_leaves(&params, addr, addr, value, flags);
+       /* update_leaves uses exclusive end; we want a single PTE at 
@addr */
+       amdgpu_vm_update_leaves(&params, addr, addr + 1, value, flags);

  error_eviction_lock:
         amdgpu_vm_eviction_unlock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index ac3f3e31e..1a34c519f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -951,9 +951,18 @@ void amdgpu_vm_update_leaves(struct 
amdgpu_vm_update_params *params,
                 if (amdgpu_vm_pt_descendant(adev, &cursor))
                         continue;

-               pt = cursor.parent->bo;
-               shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
-               mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
+               if (cursor.level == AMDGPU_VM_PTB && cursor.entry &&
+                   cursor.entry->bo) {
+                       /* WA: PTB present, update 4K leaf PTEs directly */
+                       pt = cursor.entry->bo;
+                       shift = amdgpu_vm_pt_level_shift(adev, 
cursor.level);
+                       mask = amdgpu_vm_pt_entries_mask(adev, 
cursor.level);
+               } else {
+                       /* WA: no PTB, install a dummy huge page at 
parent level */
+                       pt = cursor.parent->bo;
+                       shift = amdgpu_vm_pt_level_shift(adev, 
cursor.level - 1);
+                       mask = amdgpu_vm_pt_entries_mask(adev, 
cursor.level - 1);
+               }

                 /* Looks good so far, calculate parameters for the 
update */
                 pe_start = ((cursor.pfn >> shift) & mask) * 8;
@@ -974,8 +983,10 @@ void amdgpu_vm_update_leaves(struct 
amdgpu_vm_update_params *params,
                                             tgid,
                                             vm->immediate.fence_context);
                 amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
-                                          cursor.level - 1, pe_start, dst,
-                                          nptes, 0, flags);
+                                          pt == cursor.parent->bo ?
+                                                  cursor.level - 1 :
+                                                  cursor.level,
+                                          pe_start, dst, nptes, 0, flags);

                 amdgpu_vm_pt_next(adev, &cursor);
         }



> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>   			/* No huge page support before GMC v9 */
>   			if (cursor.level != AMDGPU_VM_PTB) {
>   				if (!amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
>   
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> -			 * only clear one entry. Next entry search again for PDE or PTE leave.
> -			 */
> -			entry_end = 1ULL << shift;
> -		else
> -			entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 37b5166e9a14..d0ea20dea3e1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
> -				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
> +				     init_pte_value, fence);
>   }
>   
>   static int
> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
> -					   NULL, gpu_start, gpu_end,
> -					   pte_flags,
> -					   (last_start - prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end, pte_flags,
> +					(last_start - prange->start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;

