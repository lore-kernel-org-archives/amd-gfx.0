Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F914C7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 23:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D2810E210;
	Mon, 27 Feb 2023 23:39:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0D110E210
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 23:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSOV4L5J/u95zsIcSiSI8YjpCnjYIVH1/tBq2UebXjy80Jfo0+cMcAcX01ILThahu2vm9Ii4SDdaWbvmytCyKQGvDikUlUFTYJRm+ZtL28ra3CA0zjzVB4cCewdNMy2PcxC8KgLjE0h4oxEbuXic7joXskti/SX9XzF/9zpxE3ROPvVZZzVkRCuzFcjNTr0PVREOc6JN3DZ26NoAOipbKYDjZ+bDXRZ7rQLdbcimYnietCHRXtKr4RQ4WirAIxmM6Iyve3czB9A5zodQTc8uzPZg8OCaB0fbUpXwf9yBf6kHUosjDy2WbSDYLaITmVMwXC73yDCeW0pcV095AyEpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY1ktVo7D4izjqCSOdY5wkgRIsvazA7AXoB9mdyOeJ8=;
 b=eyukxQTusq8aPyi/mvrKGFnYLynpw0/CuLE+DSIOCxdTTM7NNiIliwm0WPSTAKSvPg4qDNQ10F5BA8sFxmD0APgeuLiN22hGvuSV43wMPydESPeEss3EI/QWBnwZTNDQGtFuFwsx+wrt1fBt9cpHuODlSj9HHfIcqjo4FDQ1UZL/d6fhnYSgCZiojL8WdRtVvwt3PXqLU0geI4+34DpV5Xeuy082nruPK2VEWl1HQsMPqPWEGGRlNeOJzTFHHaCsCtaBZhQmzYflKIGarWcgwN+okv3Uh2o6XrKR7LB1zXUSvov9untX7wlo9pVPXnu0CnzzGIjGPnZxnjvAYdKUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY1ktVo7D4izjqCSOdY5wkgRIsvazA7AXoB9mdyOeJ8=;
 b=3moPotoHR1Q+L83OWRiadOry3h9X6uqnRlBnEJK1z7J99ftt2i91EjCGuCV4ov8MHsrwVxSrkhPRxi71wUaxDzA9s6AOQ/os1YuJ7eKf/I7YkA6jxirnW51BGYbtYWXWyUnGoBE3YrPvEBStKcVJbbcaNaKOf+t8IQ4qkJ78Tdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 23:39:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6134.028; Mon, 27 Feb 2023
 23:39:25 +0000
Message-ID: <5071783a-f219-849e-9f88-155432d2f1db@amd.com>
Date: Mon, 27 Feb 2023 18:39:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Cal vram offset in page for each
 svm_migrate_copy_to_vram
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230227230712.1145501-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230227230712.1145501-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4451cb17-5a51-47d4-2191-08db191bdbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfRImTcTYTwVBcNxAd7tNeHrgPixY8d1kec9hTwhU7eOnGsTtUVUwJFTmeonzb8zdmRGPwXVkhrIo77Eg9qRSYZAl8UloFq+CazQhZbENfkfVuBwaLZ3J94AgjTGUF+YaYiWmrnbCdljbeT56yDytXAsCPRZ+S8YpUiXNqgK2lytbRlliJ5BYk3iYFdPmoioHCaydWk+wklX4DtjlWj9ILCcudu2ZSQBVPLXTArs5tr36wWzJYIUYSsDx7/AAu4o4YWpL0dqEtyVMKvRdyDzz3hKBBYDfiO5oKekYyDJBE6aqTovDN/zfX9gEUjqE04QEhtZtW3nTAMZPzZUCeTEMALx8+gNB13XhH+cNjdlxsDMpztHvzyQggKJSPm3b9b5g3p62b3MUI4BN5Bdqsb9nA6vegTvGpEeEK2vgYXkxRahsEth2tgzJJQVSlOiF4vhv1//O4zslzT0ei9/UHMWQlD3v1qahf7e0AmVrY2fKLtMoL1O7g9ihD9ZM8I6Haju/qDGl1tYy7Dr9hDC6f5zc2WlpwyXXz4tWfpulBOQtKCke226Ip/2ujudXcWPcQ1KbHjVL+8sx29t4lDnRtZhAj0R162RhhU5lAxUMJYG1TvMcDmD3nsgYrpoiufoTvNrxFj+8BID3xfnxZCbY4++DaFGDTDiym4Oz3g8YgJ8IxJ6Iz8Bc0Ra9iT4Ndp0nOZWarO6WFz5MmRWzohSUh4arFsWLWT3AMxdCfcpnk519kI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(41300700001)(66556008)(4326008)(8676002)(83380400001)(66476007)(38100700002)(36756003)(66946007)(86362001)(2906002)(31696002)(5660300002)(44832011)(8936002)(2616005)(36916002)(6486002)(478600001)(6506007)(31686004)(6512007)(316002)(26005)(186003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ZDK1BKeEhJeVN6TXBzczJOczc1MUdDRHlWRDZJRzJLKzhtaFk2QjRLVkti?=
 =?utf-8?B?Lzk3cjc5blNzWDdmcG1nZW1GcVVSTVdhNFhldnhLd1g4Y0tvaXlqMlJxZ2V6?=
 =?utf-8?B?WkJqcUptM1VTMTZpMEl5akY5TG1HeTQzdXlwak9pMzVRMllQOXYrRk96empX?=
 =?utf-8?B?Mjc3TnNzcDZIRTJhQ0s5ZDJJcy9oNFBVMTAyTzlaVGIxemozOGdJMDU1dk9h?=
 =?utf-8?B?R1NMRzFCRGVwblE4dndXbFJBYjNYNEdvUGcvNkUyNDBLQW16QUNvWnpQTzhN?=
 =?utf-8?B?NnJscWZ3Nkk1VW1zM1RhOTdJWS9QRmxwNER0bWlZV2F4V3BZOE9DZG80WVIw?=
 =?utf-8?B?Q3d5QXFaYmNGU3drV2pPUm42T096Q0M4SmZTa0l3TWxtbTJCVzZGWHpvZHRV?=
 =?utf-8?B?TUZRUGhlSE9sMlRLWTJUeElwNm1yajJKOTA0azMrUytoUG8wM08wODJEQU9S?=
 =?utf-8?B?eC9qQ0JUcTQvd0N3VmFNc25Fa0I4SW9OVlA2c1ovWWo2VVRudWRNUzN3RTk1?=
 =?utf-8?B?MjhUYm1idUdtdTRwUTg4RmpQQUYvS1FjcTNDVS8xWEl6b1AzMFZPRDdxdzA2?=
 =?utf-8?B?cmkxUS8xV1o5cGVYRW5vUjhVMnBUMExEcHVKUDBGdXVWMDhDdDVwT2pQaGdW?=
 =?utf-8?B?TDEyMTlxN1gwOTErZW9wVzNaelVRS2Q4VUZUQmhqNkxnMENWTVdXcFhlVTJT?=
 =?utf-8?B?aEpMMmtVV1VRWXQwS0pFUWtLejZoenBZRS9vbkR5VlhCUTNvbE10NDd3WW00?=
 =?utf-8?B?N1pyajZJZTVmWVFOWnh1TXI3UmxMZWN2VlpkOURmaXNLVXFDN0VKcWxRL2lm?=
 =?utf-8?B?bGFrRTBWWk9jaGV4VU9lbzNvYXZkYUF6TUxFUFQ5NEtnd2NZNnFLZCtpWjdK?=
 =?utf-8?B?RTNQRXhZN245Qkxhdjg2cUxCazRYOUlUaXllRDVLOWo2YWpqUzZHQ09jOW1Q?=
 =?utf-8?B?cWNnOVI3SklMMFEyRnRITW43Mk5aUXJhNDNNVTQweU00NEZyY2ZzMXl0M2Er?=
 =?utf-8?B?eG85YnZHMnc1VTZPMnM0MWo5dzVKRGNtSUZyTklJVVRWeStKWkJVZU01Z0tM?=
 =?utf-8?B?U1p5NXdIZnFBSk5UWlhVUkhvc1RIbTBENDh0K204U3RySWd2T29CNjQ0b1NB?=
 =?utf-8?B?ZjB6TFBLU0VjcmNPYURRaVRUUzB0SGc4MnVJaTNlRkFseDVzaE9iaitjSWhh?=
 =?utf-8?B?YVhjNWFZMCtQZmw0bGM0aFJsa0R3OWJ6OUFNSDFSUGJhbmtwQlRneXJ3Q0NF?=
 =?utf-8?B?dkszazVlUTNkUFpTNTRaczJBSi9GVm5NZ1Rzc2ZPM2Z2MXl6YU5jcXpzMnZK?=
 =?utf-8?B?eUJjeUFjVlRZY3NzV2FwS2lISGRYd0Z2WXMyM2xKUTc3Z1I4eTVpRExrNVhT?=
 =?utf-8?B?YXlEcU5la1RmekVUcVVUaWdzbW50NjJaWDBGRE1RWHVOUGFHbVhZVVR0dEd4?=
 =?utf-8?B?SDlYYlBLRFVTSys2Q2xLOHNSNGlTOUVPMVl0MXNYNC9hRVN4ZVp2ZUh3a2kw?=
 =?utf-8?B?dlNrMWtRTUdrdjM2cTFtTnRhR2lRZmNtczhyRkRieXk2YjNzbVk5RW4wMWdY?=
 =?utf-8?B?N2lOd2ZFQjJiUW9COXZVWGUxOGZOQXQ1K0c2bHdYMlMyS3VkTUpCbmRCZkox?=
 =?utf-8?B?OUZJYlVTMktSMTJJaUJJZW93cDRGcGxoZW83TkxPSmh0M1lYVjNnWGZzZld6?=
 =?utf-8?B?VnQxWVhWYWQ0NE1ndkVIZFZqQ25EZ2Y5RmVOL2JOUXhCNzhUemMvSml6WEV1?=
 =?utf-8?B?ZUFUUWREdS9pYXprM0FFQ0pFOXNRRmZ6RFRYMTcrdEtpOE1iMzN6c1ZTMzJ2?=
 =?utf-8?B?Q2grbmo0Z2ZvSkVyeEpDQ1VDS3EyTnNadmhPNXkwOUF2Q2xhWi9Ed3FJVGZk?=
 =?utf-8?B?QzBTV21KeHg3UUJ1R0lqbmFMSTNvY3dvZ2dUNnhMZEN2a1ZwbXZ1dnlHRFpx?=
 =?utf-8?B?bkJrMTZoTEFKalRGc3lJWUdaNytrU1VaUWkwRUZrcTY3T0ZSMGVUbzJEalls?=
 =?utf-8?B?VlZDOE8xaE0yNzZlVStNUi9sUlhZb0pPTW5RWXQxRXFoNnd6cGZhdDE0TURl?=
 =?utf-8?B?R1V1dHl0ZEhZWkZZT1BjaE5iMUUyZ3J3NE5JYmNkdXRUVDFFcDZjbnUwK2ZT?=
 =?utf-8?Q?kKqByEnBnKZpV5DONOH7YfIMK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451cb17-5a51-47d4-2191-08db191bdbe8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 23:39:24.9023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqGm9uA+xwV1od+nV9YpHB5NF5lQXHfG+liAtyHImP/qzdeEo98eGSwp9sEgsx6xY+6b+MVBfGPRZuKvXJnciw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-02-27 18:07, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> svm_migrate_ram_to_vram migrate a prange from sys ram to vram. The prange may
> cross multiple vma. Need remember current dst vram offset in page for each migration.

Good catch. It's not the offset in the page, but the offset in the TTM 
resource, I think. See more nit-picks inline.


> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 1c625433ff30..60664e0cbc1c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -294,7 +294,7 @@ static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
>   static int
>   svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
> -			 dma_addr_t *scratch)
> +			 dma_addr_t *scratch, uint64_t *cur_dst)

The name cur_dst is a bit confusing. There is a local variable "dst" in 
this function, which has a very different meaning. It's the pointer to 
an array of VRAM physical addresses. A better name for cur_dst would be 
ttm_res_offset, as it is the offset from the start of the TTM resource.

I'd prefer if it was not a pointer. The calculations to increment the 
offset should be done at the top level, where it iterates through the 
VMAs. This low level code doesn't need to make any assumptions about how 
that iteration works.


>   {
>   	uint64_t npages = migrate->npages;
>   	struct device *dev = adev->dev;
> @@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t i, j;
>   	int r;
>   
> -	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
> -		 prange->last);
> +	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
> +		 prange->last, *cur_dst);
>   
>   	src = scratch;
>   	dst = (uint64_t *)(scratch + npages);
> @@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   		goto out;
>   	}
>   
> -	amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
> +	amdgpu_res_first(prange->ttm_res, *cur_dst << PAGE_SHIFT,

Maybe do the PAGE_SHIFT in the caller, where ttm_res_offset is 
calculated and updated.


>   			 npages << PAGE_SHIFT, &cursor);
>   	for (i = j = 0; i < npages; i++) {
>   		struct page *spage;
> @@ -381,6 +381,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			migrate->dst[i] = 0;
>   		}
>   	}
> +	*cur_dst = *cur_dst + i;
>   
>   #ifdef DEBUG_FORCE_MIXED_DOMAINS
>   	for (i = 0, j = 0; i < npages; i += 4, j++) {
> @@ -403,7 +404,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   static long
>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct vm_area_struct *vma, uint64_t start,
> -			uint64_t end, uint32_t trigger)
> +			uint64_t end, uint32_t trigger, uint64_t *cur_dst)

Same as above.


>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> @@ -456,7 +457,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages migrated\n", cpages);
>   
> -	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
> +	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch, cur_dst);
>   	migrate_vma_pages(&migrate);
>   
>   	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> @@ -504,6 +505,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	unsigned long addr, start, end;
>   	struct vm_area_struct *vma;
>   	struct amdgpu_device *adev;
> +	uint64_t cur_dst;
>   	unsigned long cpages = 0;
>   	long r = 0;
>   
> @@ -524,6 +526,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> +	cur_dst = prange->offset;

You could do the PAGE_SHIFT here.


>   
>   	for (addr = start; addr < end;) {
>   		unsigned long next;
> @@ -533,7 +536,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			break;
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
> +		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger, &cur_dst);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate\n", r);
>   			break;

Do the increment somewhere here, before next is assigned to addr.

     ttm_res_offset += next - addr;

Regards,
   Felix


