Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CC7E7490F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 18:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6F410E05E;
	Mon,  2 Oct 2023 18:35:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3440110E05E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 18:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTCjvTkDDp2VjUA5y5f/5+6I0WSgPWpgxQftCnQ7zV4mcLv+6dVk0uUdSfCsZZjXfxMzKGcIBk57U75AkjywwWtGhoT9jXqz4eOp0cZHI648Iqa6c/N5PnAzK+GOn5J26b/YHa/XW/0vlrRIOKWwx5q1aSe5DOnOdHdBqfRjkFSnhTNkOzZyxvelnzHAPHj2JwJaGJzTehs581BLGCiqP2IJGF4eOue5u8ksQfLuwE/SmM3w0G/O1n5UrfAdFwSOaujJ2n/eF8z8HkvGHM2ruY4bTOsJt6Pw3WtKFqNNtw91pWx1cfEkxZBAEEM/hPzkLE8MBvJ8Qyl9/vRKO3Hrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//g1oOJhl7A+GMHfwXMJ2XyIEWerh1jbOpm/mW9YqkU=;
 b=QKZXGpVKZHlk+dsREXLS2zKdBTmSMjGx3Vn5jj9N0wYGfmZCotD0+jXV3O/ZpQx0CbvUX3VdrFid9cw5c4QcW7P/cSygd7KGmO//FHr2q+i3FKcO9li5G9r1OILSl3bqDDYd6IJzWr6lSmRkE+tCdUg6MhrT7wX4rEkQn6LviL1c2tv38PdLYekC/C35lSFc1liEXpOrjinY2DxxOjBFIWYKLFGUsn6lr6+CclJ4n/nRBvp7h8EnuAK2g5Xpm2hDfKauFp+gmPixLqFMZ6N8eLZTw7GAKIZI6OYv2N0czVRCbR09oDDMWB43b19CeZS/tlvjhbdkAWYdhKirhN0jCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//g1oOJhl7A+GMHfwXMJ2XyIEWerh1jbOpm/mW9YqkU=;
 b=T96qdJMQrNcwY8cQDvSXKxRadZtUMX1zHmwY0+POISyLaC184fY+3+ONQHDyC/LD7BmHE/cNCfP15SL6XCKgeBkL1EZ5yHbbsiWN9c5J5z3Se83jwusjSFYC6wM7r324i+hXPNBQdPD4+tnDGoDpp+ObOkDngp1TDJzv7dg/pu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 18:35:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 18:35:20 +0000
Content-Type: multipart/alternative;
 boundary="------------OhWKN41U3zY0Z97bXWCaJX16"
Message-ID: <5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com>
Date: Mon, 2 Oct 2023 14:35:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230929141115.10016-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YQBPR0101CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7719ce68-0778-4cc0-530c-08dbc376552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0+sy6JDeFwuuxl40L1m1FFE/O+qyKn07YBR37+O7daIhZVClpYOmpJVwujLjduwZV2Ya/TJ/MVdGEQtQIUYiZOEofFNzp8iJ/nU8doQjDhrOwLSmgh0RAS6Z6gREGGun846xuc8NuydnCb15jM19wuYFp1XSECCkVxEAf3sRInc37Gdi1VpDvAAvTGQj7ZlWAT3gX1t8vfdX8OAx+7pGg7GjRwb8FKufQaBCnLGsumZSb9T1ptcsEMGTd0l3c3LSPblJeaRRNamh6Kdzk0WO+00dZKAKeF9LwzdLVkGxDtgJ4agZSC88HKi7lzbeJQpFmjY/OkvZws5iBenkQ4XFgRCxwSKi8XyT+Y6EqtXG2mxh8V3aylVZRA3uWwZ8vQd7fYb9aMc2HDiwIkxTJD3TtGo4DR2bOfAe9fz8pdeHZCe67GW/oMAqrtjRzo7BOvDsquN0VYHbYfOMNYpki4M+QxH5yRsMFY+0F8p1iQW+4LaxuiWWHS862ZrO1wLH7HDTuDtX+3N6IIj4pc7up7ibU10vERkjy8D/1Q+kFSznF/OIAMz5i3g1Rqq48VZDPcY5PTxPg87uOYW7dd7BuJAaoNml0CVCTGCd+gkEhPnrzOmWIoNOr9MR/bPYF0aFD8RNOXYFeJ/PVq6X7zxiDArAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(8936002)(53546011)(6512007)(6666004)(38100700002)(33964004)(86362001)(66476007)(31696002)(6506007)(2616005)(478600001)(6486002)(83380400001)(66946007)(26005)(5660300002)(30864003)(44832011)(36756003)(66556008)(41300700001)(8676002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU15VHRTM3RXc0ZRUGZEN2tydFBQN2tqSVVnTnRLZ242OFBNeEVXU2VjZ1Zr?=
 =?utf-8?B?SjBIdHEweGlVdVdSYVA5cUlmVzREWGhDc3hXdVd0ZERMdVZjTVJKcmwvWlhl?=
 =?utf-8?B?TWthRmV3ME10RVE3R01kSS9XbVpLTGR2eGJtUXBETzFiZVU0SU5LdFYxUkVt?=
 =?utf-8?B?d3lhNmN5L1JRYWkvOGJjb3g5S1BFVnZ5WE5haEMxMVlKR3NIMjd6dEU2Q3Er?=
 =?utf-8?B?ejFZZ0dPZHFGZktYUlc3cjZxWEIzSkFqV0VMZXNzblhORG8vZjczaFhMb3lp?=
 =?utf-8?B?ZzRnSXRwUjlRcUtiZ2FwODhRcU9zdkM3TFViRHRrem4yYURJZHA4QjF2VC9t?=
 =?utf-8?B?YUVkSzlpQVA5YkZaRnQwYWYwenlhVXp0Yjk0TS9KRHlWZElpa00xRm1RMkRY?=
 =?utf-8?B?WnBRU2xrL084RWVYU0dWR3JUU0x5Z1ppSmkvdm5QWTZ6bVBGZjVkdWxhd241?=
 =?utf-8?B?dldQU2JOVjJEMC8yM0U3MnFWajZTczZvdTQ5RCtsU0JMRy92c05Ndy9QeTRM?=
 =?utf-8?B?dDdqWEU2akN3YjNzR05wcm9aNTlMUDM4cXdJbUlsR095ZVc3bE42UU4ralhI?=
 =?utf-8?B?Q0FpZXQ2VVNzR1BKbzlHU2U4WXVEL3hLUHd6MlVnTDNad0k1ZEl1R3A5czBG?=
 =?utf-8?B?aUdsQnBFdVlWVm02ZkJIQi80Z2pqNmk3SFBkS09FNUtHc2IzeWdTN3pZbEp6?=
 =?utf-8?B?VDBsZVloQk1ydnZwTlBzck0vZ25XZ3VZMW1vMjlDQytNbWs1WHdUenBnR2pz?=
 =?utf-8?B?eUNmWC8yNWRNaUc2UzEyUWg5a21ITmZLZmwvMzV1Vk9pQnE5L284b3lKUjNO?=
 =?utf-8?B?akxBVmE5cDJLMVl5bTYvbFBBOStFWjZ0eWtLMC9paHdOeFVqSDFaazFORlFN?=
 =?utf-8?B?OGR1Q0xJMnhUYk9WdHg5cWgyUldyVm9UYTNyMi9tWUJ1TzRTTEMxbG0yV2Nz?=
 =?utf-8?B?V0d3b2tXdlFrV2hScG9sV0d4STZibk42bThxVUI1SEpzdThMcXE4cGgvZXZm?=
 =?utf-8?B?TXpwOW82RDQ2K1d6RWRnWWRiQVd4SG9mM2hEdU5sSFVCN0tDREc5aFZUdGxC?=
 =?utf-8?B?T0tMY1NDSVVUNGkvOEtJWjMyT0FRYWpUOGVyUHpzV2dnV3VGSWJrVUl3YTUz?=
 =?utf-8?B?b3luRnE1VmRjdTJMOUZaTXFqdWdRK0Q0QnVCKzlOSkNqeTUwM2JBb1d1UTIx?=
 =?utf-8?B?T20xOURRTHZaeWxMK2RGMjBEaGd6SHBjelNiWVBxblI5Q0JVYS9QR3J0SHFH?=
 =?utf-8?B?b20rQmgzSXp4VCtWdi93K0VxWXhjWVQwZnk2ZWRhS245cHl3MFd0RmkyWkJw?=
 =?utf-8?B?MGU0S3Qydkt1c0ZuTGlGRXpsd0trWDh6NktUUlFnTG1NdDZBbW1PRDJBQThW?=
 =?utf-8?B?RlRyUUQ1SG5GR2R6U0x6YTlnbWtLc2oreXJTZDNyZlFNeUIyVTZWdnAzVlpG?=
 =?utf-8?B?a0dSTTlMSkNuMjM5V0dDSTZwWjZqblV6Yis4VFBxQURnMnovTHpwMDMxWnhD?=
 =?utf-8?B?Tm1JTGIvbzFYS2dDMnJYQ2xqRVMyTFVrUDBIWnM2Q243TVhvQjhBU3RVZUdL?=
 =?utf-8?B?aGZvaGVxclFyejJZZzhoTlY1SVNTNmVLd2pKMEttU2ZKUTVjbXRVcGVCU3VR?=
 =?utf-8?B?MmZ1YlJmOWJCZmNiaGg3MHJpQWtLc2RtNkVicmRxdUJvM3ZPWGgrL3gzRzJL?=
 =?utf-8?B?TDN0YldBZk0xYk8rb1AyYjdIZlNrbXFIZ1BVdEw1aXhNQTFJc1VTTjFxUEFT?=
 =?utf-8?B?ZSsvdUJNc1R0aDAxOFp5dnd6SldJSVVKbUxUTFVvbW13SFdkN0VSaXpjR1N6?=
 =?utf-8?B?ei9ZaDZDdWhqT2RiRjFReEt3aWRuUGQxVFhkdVUvdWJwcmxVTXdETy94NEtX?=
 =?utf-8?B?cVJKNUpVdExiN3hFdzdNRkg0OFBNVWllMjZZSmVWQkp1Rm1FcDVhaXZyenlo?=
 =?utf-8?B?SlVHTEY0SERIclZiS2lqT0dVbzk0a0dTNmM3ZlRWVk0vMFdOcUt5eGFPSmlG?=
 =?utf-8?B?bzd3V2FqemFKazNrUjVXV1RnT2VSS0pOK2tzZmtCQnRPZGtoOWY4ZGFjU01M?=
 =?utf-8?B?TEdtSVVFK1kvUk1pam1zYXhkbWExalk2aCthSlRpWFdKYTdoaDJrNHVlNTgv?=
 =?utf-8?Q?dLQ8lk2HX8x+G3sI2xhAGIp8y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7719ce68-0778-4cc0-530c-08dbc376552d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:35:20.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnFYhhrnj8GiiweWU8aUUBBBr83D/1aV80AokGxd06Twxjw4AeUtd+o2lg2cVWpped5gKQMFuoQZjmI9ohrwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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

--------------OhWKN41U3zY0Z97bXWCaJX16
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-09-29 10:11, Philip Yang wrote:
> Replace prange->mapped_to_gpu with prange->bitmap_mapped[], which is
> based on prange granularity, updated when map to GPUS or unmap from
> GPUs, to optimize multiple GPU map, unmap and retry fault recover.
>
> svm_range_is_mapped is false only if no parital range mapping on any
> GPUs.
>
> Split the bitmap_mapped when unmap from cpu to split the prange.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218 ++++++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   4 +-
>   2 files changed, 184 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 040dc32ad475..626e0dd4ec79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -292,12 +292,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
>   	}
>   
> -	/* free dma_addr array for each gpu */
> +	/* free dma_addr array, bitmap_mapped for each gpu */
>   	for (gpuidx = 0; gpuidx < MAX_GPU_INSTANCE; gpuidx++) {
> -		if (prange->dma_addr[gpuidx]) {
> +		if (prange->dma_addr[gpuidx])
>   			kvfree(prange->dma_addr[gpuidx]);
> -				prange->dma_addr[gpuidx] = NULL;
> -		}
> +		if (prange->bitmap_mapped[gpuidx])
> +			bitmap_free(prange->bitmap_mapped[gpuidx]);
>   	}
>   
>   	mutex_destroy(&prange->lock);
> @@ -323,19 +323,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> -
> -	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> -	if (!prange)
> -		return NULL;
> +	unsigned int nbits;
> +	uint32_t gpuidx;
>   
>   	p = container_of(svms, struct kfd_process, svms);
>   	if (!p->xnack_enabled && update_mem_usage &&
>   	    amdgpu_amdkfd_reserve_mem_limit(NULL, size << PAGE_SHIFT,
>   				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
>   		pr_info("SVM mapping failed, exceeds resident system memory limit\n");
> -		kfree(prange);
>   		return NULL;
>   	}
> +
> +	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
> +	if (!prange)
> +		return NULL;
> +
> +	svm_range_set_default_attributes(&prange->preferred_loc,
> +					 &prange->prefetch_loc,
> +					 &prange->granularity, &prange->flags);
> +
> +	nbits = svm_range_mapped_nbits(size, prange->granularity);
> +	pr_debug("prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n", prange,
> +		 start, last, nbits);
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		prange->bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
> +		if (!prange->bitmap_mapped[gpuidx]) {
> +			while (gpuidx--)
> +				bitmap_free(prange->bitmap_mapped[gpuidx]);
> +			kfree(prange);
> +			return NULL;
> +		}
> +	}
> +
>   	prange->npages = size;
>   	prange->svms = svms;
>   	prange->start = start;
> @@ -354,10 +373,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
>   
> -	svm_range_set_default_attributes(&prange->preferred_loc,
> -					 &prange->prefetch_loc,
> -					 &prange->granularity, &prange->flags);
> -
>   	pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>   
>   	return prange;
> @@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   	return 0;
>   }
>   
> +static int
> +svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
> +			      uint64_t start, uint64_t last)
> +{
> +	struct kfd_process *p = container_of(new->svms, struct kfd_process, svms);
> +	unsigned int nbits, old_nbits, old_nbits2;
> +	unsigned long *bits;
> +	uint32_t gpuidx;
> +
> +	nbits = svm_range_mapped_nbits(new->npages, new->granularity);
> +	old_nbits = svm_range_mapped_nbits(old->npages, old->granularity);
> +	old_nbits2 = svm_range_mapped_nbits(last - start + 1, old->granularity);

This may be off by one if start and last are not aligned on granularity 
boundaries. I think you need to calculate the index for each of start 
and last and subtract the indices. E.g. granularity = 9, start = 511, 
last = 512. last - start + 1 is 2 and the division tells you you need 
one bit. But this range touches two different granules, so you need two 
bits.


> +
> +	pr_debug("old 0x%p [0x%lx 0x%lx] => [0x%llx 0x%llx] nbits %d => %d\n",
> +		 old, old->start, old->last, start, last, old_nbits, old_nbits2);
> +	pr_debug("new 0x%p [0x%lx 0x%lx] nbits %d\n", new, new->start, new->last,
> +		 nbits);
> +
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
> +		if (!bits)
> +			return -ENOMEM;
> +
> +		if (start == old->start) {
> +			bitmap_shift_right(new->bitmap_mapped[gpuidx],
> +					   old->bitmap_mapped[gpuidx],
> +					   old_nbits2, old_nbits);
> +			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx], 0,
> +					   old_nbits2);

Isn't this (shift = 0) the same as bitmap_copy?


> +		} else {
> +			bitmap_copy(new->bitmap_mapped[gpuidx],
> +				    old->bitmap_mapped[gpuidx], nbits);
> +			bitmap_shift_right(bits, old->bitmap_mapped[gpuidx],
> +					   nbits, old_nbits);
> +		}
> +		bitmap_free(old->bitmap_mapped[gpuidx]);
> +		old->bitmap_mapped[gpuidx] = bits;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * svm_range_split_adjust - split range and adjust
>    *
> @@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   			return r;
>   	}
>   
> +	r = svm_range_split_bitmap_mapped(new, old, start, last);
> +	if (r)
> +		return r;
> +
>   	old->npages = last - start + 1;
>   	old->start = start;
>   	old->last = last;
> @@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				      fence);
>   }
>   
> +/**
> + * svm_range_partial_mapped_dev - check if prange mapped on the specific gpu
> + *
> + * @gpuidx: the gpu to check
> + * @prange: prange to check
> + * @start: the start address in pages
> + * @last: the last address in pages
> + *
> + * Return:
> + * true: if any partial range mapped on gpu based on granularity boundary
> + * false: if the entire range not mapped
> + */
> +static bool
> +svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
> +			     unsigned long start, unsigned long last)
> +{
> +	unsigned long index, off;
> +	bool mapped = false;
> +
> +	start = max(start, prange->start);
> +	last = min(last, prange->last);
> +	if (last < start)
> +		goto out;
> +
> +	for (off = start; off <= last; off += (1UL << prange->granularity)) {

It would be easier to just iterate over indexes instead of offsets. And 
even more efficient to avoid testing individual bits by using a higher 
level bitmap function, e.g. bitmap_find_next_bit E.g.

	unsigned long start_index, last_index;

	start = max(start, prange->start);
	last = min(last, prange->last);
	if (last < start)
		goto out;

	start_index = (start - prange->start) >> prange->granularity;
	last_index = (last - prange->start) >> prange->granularity;
	return find_next_bit(prange->bitmap_mapped[gpuidx], last_index + 1, start_index) <= last_index;
  

> +		index = (off - prange->start) >> prange->granularity;
> +		if (test_bit(index, prange->bitmap_mapped[gpuidx])) {
> +			mapped = true;
> +			break;
> +		}
> +	}
> +out:
> +	pr_debug("prange 0x%p [0x%lx 0x%lx] mapped %d on gpu %d\n", prange,
> +		 start, last, mapped, gpuidx);
> +	return mapped;
> +}
> +
> +static bool
> +svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
> +			 unsigned long last)
> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	struct svm_range *pchild;
> +	uint32_t gpuidx;
> +
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		list_for_each_entry(pchild, &prange->child_list, child_list) {
> +			if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
> +				return true;
> +		}
> +
> +		if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static bool svm_range_is_mapped(struct svm_range *prange)
> +{
> +	return svm_range_partial_mapped(prange, prange->start, prange->last);
> +}
> +
> +static void
> +svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
> +			unsigned long start, unsigned long last, bool mapped)
> +{
> +	unsigned long index, nbits;
> +
> +	index = (start - prange->start) >> prange->granularity;
> +	nbits = svm_range_mapped_nbits(last - start + 1, prange->granularity);

This may be off by one if start and last are not aligned on granularity 
boundaries. I think you need to calculate the index for each of start 
and last and subtract the indices.


> +	if (mapped)
> +		bitmap_set(prange->bitmap_mapped[gpuidx], index, nbits);
> +	else
> +		bitmap_clear(prange->bitmap_mapped[gpuidx], index, nbits);
> +	pr_debug("prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n",
> +		 prange, start, last, mapped, nbits, gpuidx);
> +}
> +
>   static int
>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			  unsigned long last, uint32_t trigger)
> @@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   	uint32_t gpuidx;
>   	int r = 0;
>   
> -	if (!prange->mapped_to_gpu) {
> -		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
> -			 prange, prange->start, prange->last);
> -		return 0;
> -	}
> -
> -	if (prange->start == start && prange->last == last) {
> -		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
> -		prange->mapped_to_gpu = false;
> -	}
> -
>   	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
>   		  MAX_GPU_INSTANCE);
>   	p = container_of(prange->svms, struct kfd_process, svms);
>   
>   	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
> -		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>   		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>   		if (!pdd) {
>   			pr_debug("failed to find device idx %d\n", gpuidx);
> -			return -EINVAL;
> +			continue;
> +		}
> +
> +		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
> +			pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n",
> +				 prange->svms, prange, start, last, gpuidx);
> +			continue;
>   		}
>   
> +		svm_range_update_mapped(gpuidx, prange, start, last, false);
> +
> +		pr_debug("unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n",
> +			 prange->svms, prange, start, last, gpuidx);
> +
>   		kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
>   					     start, last, trigger);
>   
> @@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		if (r)
>   			break;
>   
> +		if (!r)
> +			svm_range_update_mapped(gpuidx, prange, prange->start + offset,
> +						prange->start + offset + npages - 1, true);
> +
>   		if (fence) {
>   			r = dma_fence_wait(fence, false);
>   			dma_fence_put(fence);
> @@ -1648,7 +1789,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> -		if (!prange->mapped_to_gpu ||
> +		if (!svm_range_is_mapped(prange) ||

I think this gives you the wrong answer. As I understand it, 
svm_range_is_mapped returns true, if any part of the range is currently 
mapped on any GPU. But you'd only want to skip validate_and_map is all 
of the range is currently mapped on the subset of GPUs you're interested in.


>   		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>   			r = 0;
>   			goto free_ctx;
> @@ -1729,9 +1870,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
>   						  ctx->bitmap, flush_tlb);
>   
> -		if (!r && next == end)
> -			prange->mapped_to_gpu = true;
> -
>   		svm_range_unlock(prange);
>   
>   		addr = next;
> @@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	if (!p->xnack_enabled ||
>   	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>   		int evicted_ranges;
> -		bool mapped = prange->mapped_to_gpu;
> +		bool mapped = svm_range_is_mapped(prange);
>   
>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
> -			if (!pchild->mapped_to_gpu)
> +			if (!svm_range_is_mapped(pchild))
>   				continue;
>   			mapped = true;
Doesn't svm_range_is_mapped already consider child ranges? So you don't 
need to set mapped here.


>   			mutex_lock_nested(&pchild->lock, 1);
> @@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   
>   static struct svm_range *svm_range_clone(struct svm_range *old)
>   {
> +	struct kfd_process *p = container_of(old->svms, struct kfd_process, svms);
>   	struct svm_range *new;
> +	uint32_t gpuidx;
>   
>   	new = svm_range_new(old->svms, old->start, old->last, false);
>   	if (!new)
> @@ -1988,7 +2128,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->prefetch_loc = old->prefetch_loc;
>   	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
> -	new->mapped_to_gpu = old->mapped_to_gpu;
> +	for_each_set_bit(gpuidx, p->svms.bitmap_supported, p->n_pdds) {
> +		bitmap_copy(new->bitmap_mapped[gpuidx], old->bitmap_mapped[gpuidx],
> +			    svm_range_mapped_nbits(new->last - new->start + 1,
> +						   new->granularity));
> +	};
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>   
> @@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next_start = min(node->last, last) + 1;
>   
>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> -		    prange->mapped_to_gpu) {
> +		    svm_range_is_mapped(prange)) {

This is probably wrong too. I think you need a check, whether a specific 
range is completely mapped on all GPUs that need access.

Regards,
   Felix


>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   		if (migrated && (!p->xnack_enabled ||
>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> -		    prange->mapped_to_gpu) {
> +		    svm_range_is_mapped(prange)) {
>   			pr_debug("restore_work will update mappings of GPUs\n");
>   			mutex_unlock(&prange->migrate_mutex);
>   			continue;
> @@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   			continue;
>   		}
>   
> -		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
> +		flush_tlb = !migrated && update_mapping && svm_range_is_mapped(prange);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
>   					       true, flush_tlb);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index d2e94d8fb4be..10c92c5e23a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -132,7 +132,7 @@ struct svm_range {
>   	struct list_head		child_list;
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
> -	bool				mapped_to_gpu;
> +	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
> @@ -163,6 +163,8 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
>   		return NULL;
>   }
>   
> +#define svm_range_mapped_nbits(size, granularity) DIV_ROUND_UP((size), 1UL << (granularity))
> +
>   int svm_range_list_init(struct kfd_process *p);
>   void svm_range_list_fini(struct kfd_process *p);
>   int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
--------------OhWKN41U3zY0Z97bXWCaJX16
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-29 10:11, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">Replace prange-&gt;mapped_to_gpu with prange-&gt;bitmap_mapped[], which is
based on prange granularity, updated when map to GPUS or unmap from
GPUs, to optimize multiple GPU map, unmap and retry fault recover.

svm_range_is_mapped is false only if no parital range mapping on any
GPUs.

Split the bitmap_mapped when unmap from cpu to split the prange.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218 ++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   4 +-
 2 files changed, 184 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 040dc32ad475..626e0dd4ec79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -292,12 +292,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
 
-	/* free dma_addr array for each gpu */
+	/* free dma_addr array, bitmap_mapped for each gpu */
 	for (gpuidx = 0; gpuidx &lt; MAX_GPU_INSTANCE; gpuidx++) {
-		if (prange-&gt;dma_addr[gpuidx]) {
+		if (prange-&gt;dma_addr[gpuidx])
 			kvfree(prange-&gt;dma_addr[gpuidx]);
-				prange-&gt;dma_addr[gpuidx] = NULL;
-		}
+		if (prange-&gt;bitmap_mapped[gpuidx])
+			bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
 	}
 
 	mutex_destroy(&amp;prange-&gt;lock);
@@ -323,19 +323,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
-
-	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
-	if (!prange)
-		return NULL;
+	unsigned int nbits;
+	uint32_t gpuidx;
 
 	p = container_of(svms, struct kfd_process, svms);
 	if (!p-&gt;xnack_enabled &amp;&amp; update_mem_usage &amp;&amp;
 	    amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt; PAGE_SHIFT,
 				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
 		pr_info(&quot;SVM mapping failed, exceeds resident system memory limit\n&quot;);
-		kfree(prange);
 		return NULL;
 	}
+
+	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
+	if (!prange)
+		return NULL;
+
+	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
+					 &amp;prange-&gt;prefetch_loc,
+					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+
+	nbits = svm_range_mapped_nbits(size, prange-&gt;granularity);
+	pr_debug(&quot;prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n&quot;, prange,
+		 start, last, nbits);
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		prange-&gt;bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
+		if (!prange-&gt;bitmap_mapped[gpuidx]) {
+			while (gpuidx--)
+				bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
+			kfree(prange);
+			return NULL;
+		}
+	}
+
 	prange-&gt;npages = size;
 	prange-&gt;svms = svms;
 	prange-&gt;start = start;
@@ -354,10 +373,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
-					 &amp;prange-&gt;prefetch_loc,
-					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
-
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);
 
 	return prange;
@@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
+			      uint64_t start, uint64_t last)
+{
+	struct kfd_process *p = container_of(new-&gt;svms, struct kfd_process, svms);
+	unsigned int nbits, old_nbits, old_nbits2;
+	unsigned long *bits;
+	uint32_t gpuidx;
+
+	nbits = svm_range_mapped_nbits(new-&gt;npages, new-&gt;granularity);
+	old_nbits = svm_range_mapped_nbits(old-&gt;npages, old-&gt;granularity);
+	old_nbits2 = svm_range_mapped_nbits(last - start + 1, old-&gt;granularity);</pre>
    </blockquote>
    <p>This may be off by one if start and last are not aligned on
      granularity boundaries. I think you need to calculate the index
      for each of start and last and subtract the indices. E.g.
      granularity = 9, start = 511, last = 512. last - start + 1 is 2
      and the division tells you you need one bit. But this range
      touches two different granules, so you need two bits.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	pr_debug(&quot;old 0x%p [0x%lx 0x%lx] =&gt; [0x%llx 0x%llx] nbits %d =&gt; %d\n&quot;,
+		 old, old-&gt;start, old-&gt;last, start, last, old_nbits, old_nbits2);
+	pr_debug(&quot;new 0x%p [0x%lx 0x%lx] nbits %d\n&quot;, new, new-&gt;start, new-&gt;last,
+		 nbits);
+
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
+		if (!bits)
+			return -ENOMEM;
+
+		if (start == old-&gt;start) {
+			bitmap_shift_right(new-&gt;bitmap_mapped[gpuidx],
+					   old-&gt;bitmap_mapped[gpuidx],
+					   old_nbits2, old_nbits);
+			bitmap_shift_right(bits, old-&gt;bitmap_mapped[gpuidx], 0,
+					   old_nbits2);</pre>
    </blockquote>
    <p>Isn't this (shift = 0) the same as bitmap_copy?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		} else {
+			bitmap_copy(new-&gt;bitmap_mapped[gpuidx],
+				    old-&gt;bitmap_mapped[gpuidx], nbits);
+			bitmap_shift_right(bits, old-&gt;bitmap_mapped[gpuidx],
+					   nbits, old_nbits);
+		}
+		bitmap_free(old-&gt;bitmap_mapped[gpuidx]);
+		old-&gt;bitmap_mapped[gpuidx] = bits;
+	}
+
+	return 0;
+}
+
 /**
  * svm_range_split_adjust - split range and adjust
  *
@@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	r = svm_range_split_bitmap_mapped(new, old, start, last);
+	if (r)
+		return r;
+
 	old-&gt;npages = last - start + 1;
 	old-&gt;start = start;
 	old-&gt;last = last;
@@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				      fence);
 }
 
+/**
+ * svm_range_partial_mapped_dev - check if prange mapped on the specific gpu
+ *
+ * @gpuidx: the gpu to check
+ * @prange: prange to check
+ * @start: the start address in pages
+ * @last: the last address in pages
+ *
+ * Return:
+ * true: if any partial range mapped on gpu based on granularity boundary
+ * false: if the entire range not mapped
+ */
+static bool
+svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
+			     unsigned long start, unsigned long last)
+{
+	unsigned long index, off;
+	bool mapped = false;
+
+	start = max(start, prange-&gt;start);
+	last = min(last, prange-&gt;last);
+	if (last &lt; start)
+		goto out;
+
+	for (off = start; off &lt;= last; off += (1UL &lt;&lt; prange-&gt;granularity)) {</pre>
    </blockquote>
    <p>It would be easier to just iterate over indexes instead of
      offsets. And even more efficient to avoid testing individual bits
      by using a higher level bitmap function, e.g. bitmap_find_next_bit
      E.g.</p>
    <pre>	unsigned long start_index, last_index;

	start = max(start, prange-&gt;start);
	last = min(last, prange-&gt;last);
	if (last &lt; start)
		goto out;

	start_index = (start - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
	last_index = (last - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
	return find_next_bit(prange-&gt;bitmap_mapped[gpuidx], last_index + 1, start_index) &lt;= last_index;
 
</pre>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">+		index = (off - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
+		if (test_bit(index, prange-&gt;bitmap_mapped[gpuidx])) {
+			mapped = true;
+			break;
+		}
+	}
+out:
+	pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] mapped %d on gpu %d\n&quot;, prange,
+		 start, last, mapped, gpuidx);
+	return mapped;
+}
+
+static bool
+svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
+			 unsigned long last)
+{
+	struct kfd_process *p = container_of(prange-&gt;svms, struct kfd_process, svms);
+	struct svm_range *pchild;
+	uint32_t gpuidx;
+
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
+			if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
+				return true;
+		}
+
+		if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
+			return true;
+	}
+	return false;
+}
+
+static bool svm_range_is_mapped(struct svm_range *prange)
+{
+	return svm_range_partial_mapped(prange, prange-&gt;start, prange-&gt;last);
+}
+
+static void
+svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
+			unsigned long start, unsigned long last, bool mapped)
+{
+	unsigned long index, nbits;
+
+	index = (start - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
+	nbits = svm_range_mapped_nbits(last - start + 1, prange-&gt;granularity);</pre>
    </blockquote>
    <p>This may be off by one if start and last are not aligned on
      granularity boundaries. I think you need to calculate the index
      for each of start and last and subtract the indices.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (mapped)
+		bitmap_set(prange-&gt;bitmap_mapped[gpuidx], index, nbits);
+	else
+		bitmap_clear(prange-&gt;bitmap_mapped[gpuidx], index, nbits);
+	pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n&quot;,
+		 prange, start, last, mapped, nbits, gpuidx);
+}
+
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			  unsigned long last, uint32_t trigger)
@@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange-&gt;mapped_to_gpu) {
-		pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last);
-		return 0;
-	}
-
-	if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
-		pr_debug(&quot;unmap svms 0x%p prange 0x%p\n&quot;, prange-&gt;svms, prange);
-		prange-&gt;mapped_to_gpu = false;
-	}
-
 	bitmap_or(bitmap, prange-&gt;bitmap_access, prange-&gt;bitmap_aip,
 		  MAX_GPU_INSTANCE);
 	p = container_of(prange-&gt;svms, struct kfd_process, svms);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
-		pr_debug(&quot;unmap from gpu idx 0x%x\n&quot;, gpuidx);
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug(&quot;failed to find device idx %d\n&quot;, gpuidx);
-			return -EINVAL;
+			continue;
+		}
+
+		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
+			pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n&quot;,
+				 prange-&gt;svms, prange, start, last, gpuidx);
+			continue;
 		}
 
+		svm_range_update_mapped(gpuidx, prange, start, last, false);
+
+		pr_debug(&quot;unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n&quot;,
+			 prange-&gt;svms, prange, start, last, gpuidx);
+
 		kfd_smi_event_unmap_from_gpu(pdd-&gt;dev, p-&gt;lead_thread-&gt;pid,
 					     start, last, trigger);
 
@@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		if (r)
 			break;
 
+		if (!r)
+			svm_range_update_mapped(gpuidx, prange, prange-&gt;start + offset,
+						prange-&gt;start + offset + npages - 1, true);
+
 		if (fence) {
 			r = dma_fence_wait(fence, false);
 			dma_fence_put(fence);
@@ -1648,7 +1789,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
 		bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange-&gt;mapped_to_gpu ||
+		if (!svm_range_is_mapped(prange) ||</pre>
    </blockquote>
    <p>I think this gives you the wrong answer. As I understand it,
      svm_range_is_mapped returns true, if any part of the range is
      currently mapped on any GPU. But you'd only want to skip
      validate_and_map is all of the range is currently mapped on the
      subset of GPUs you're interested in.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		    bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
 			r = 0;
 			goto free_ctx;
@@ -1729,9 +1870,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
 						  ctx-&gt;bitmap, flush_tlb);
 
-		if (!r &amp;&amp; next == end)
-			prange-&gt;mapped_to_gpu = true;
-
 		svm_range_unlock(prange);
 
 		addr = next;
@@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p-&gt;xnack_enabled ||
 	    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange-&gt;mapped_to_gpu;
+		bool mapped = svm_range_is_mapped(prange);
 
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
-			if (!pchild-&gt;mapped_to_gpu)
+			if (!svm_range_is_mapped(pchild))
 				continue;
 			mapped = true;</pre>
    </blockquote>
    Doesn't svm_range_is_mapped already consider child ranges? So you
    don't need to set mapped here.<br>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
@@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 static struct svm_range *svm_range_clone(struct svm_range *old)
 {
+	struct kfd_process *p = container_of(old-&gt;svms, struct kfd_process, svms);
 	struct svm_range *new;
+	uint32_t gpuidx;
 
 	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, false);
 	if (!new)
@@ -1988,7 +2128,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		bitmap_copy(new-&gt;bitmap_mapped[gpuidx], old-&gt;bitmap_mapped[gpuidx],
+			    svm_range_mapped_nbits(new-&gt;last - new-&gt;start + 1,
+						   new-&gt;granularity));
+	};
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node-&gt;last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {</pre>
    </blockquote>
    <p>This is probably wrong too. I think you need a check, whether a
      specific range is completely mapped on all GPUs that need access.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated &amp;&amp; (!p-&gt;xnack_enabled ||
 		    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {
 			pr_debug(&quot;restore_work will update mappings of GPUs\n&quot;);
 			mutex_unlock(&amp;prange-&gt;migrate_mutex);
 			continue;
@@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
+		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; svm_range_is_mapped(prange);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
 					       true, flush_tlb);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index d2e94d8fb4be..10c92c5e23a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -132,7 +132,7 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
@@ -163,6 +163,8 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 		return NULL;
 }
 
+#define svm_range_mapped_nbits(size, granularity) DIV_ROUND_UP((size), 1UL &lt;&lt; (granularity))
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
</pre>
    </blockquote>
  </body>
</html>

--------------OhWKN41U3zY0Z97bXWCaJX16--
