Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB58C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D8A60F38
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8D8A60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA756E03A;
	Tue, 12 Oct 2021 22:49:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9041F6E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 22:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAJLQ9wwb6Tm4vZsNe9KnXNRgxdftmBzXyQP9Mz+iA6/ok9MhaQAw7rleRKd7Hz3xN6YIA9xHjpHOeuNVa+jPcbGP5CP5k+iz2xvb4LDJaUvRZ9oDWBIDnLJC3NzcsAcmhiS595MateBsu/d8DQgzExoP8SE23FsYf4hj5zL7Rx/jVroB/fsrdrGsggcssAy7tzg+agQhSYUyrq0KFIakwTAgBLYoR0ogY5jE5mLETlMM8XhwcMca0a4onT+lNo6qYGjbUx9/Dg8m54/N2Dr7gUcvnS7NPSb9p0egaL0UFORdebfgmZ5+7NXsd+RsvJPqhEmlY/wJCnjQQOnQf+82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqm2OLD5RzlnXfE02t8nIhXYMORIAs5gGhXP7OHINZc=;
 b=iGEEQWulkzII4dmBWg46gV40iruTd9jx8RbIjsXUfUf2gJZ67pOJ4fcbWB8DJiYHqZOw3CyIudBT4wUQAu215E8uPu2kWMpUDH85uugt8Hn0PRidWd2rFN/Veh2/9Dh2x0IprV8SBUX3TcE0AttM9id+g9t5h6cwgQFCGQatRYZP1JwG5IVwN7ABGwROKjY27VtiGg+DxctBIaSSZQW6yajX7PY/7zKmXyqfv0knK5/ltL3T9hLeu3UvRloJFLA0oS6flS8HttekzsemktdkZz9OwfZZRZ57QV52Tq4hWHbCPCnt8ownGuTEbZKOqPW5UYu1xiuyKdjtd6yf6zCJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqm2OLD5RzlnXfE02t8nIhXYMORIAs5gGhXP7OHINZc=;
 b=Q+KZiVOwPCNSiz8VIDcasFYhe2Xa2Mg2ZEHeL2dqDNHsIx/TJyTEGgMSxiClpyh1DIW68cnC86BfpIUj07y7vADm+6qH5/ZDExFwc53Z9A5TX+gQzdUKSjLx0I0Q+DFNnLvIALEfS/e8yaYFYR3YJJRR0tSLEGjiLM52RuC4fHc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 22:49:16 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 22:49:16 +0000
Subject: Re: [PATCH v4 2/3] drm/amdkfd: handle svm partial migration cpages 0
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <46fd7abe-bd7d-e2a3-1aed-b3028828d178@amd.com>
 <20211012223922.19832-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <19e2503e-a753-1ccf-531c-aca5391e86e5@amd.com>
Date: Tue, 12 Oct 2021 18:49:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211012223922.19832-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 22:49:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f37642-62a6-4eaa-19cd-08d98dd28516
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34035C831E95458824D4915C92B69@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UwwyIIAd89AA8LcJPhC5apzEEmbrRHDE/iHC403wG4u3a6b/SDZg7k583dHpGbhEXWlu5gtGNNRRrnqyij4gImCAnCvGIkSCE8mkDlhiNXAgOV9VegCemjf9AY57nMVG7Pmqr5qho2fY8SSPloXl4P1ExmeyWPy4ZEKsqivU7RAUR1S45fQIrbfF2HWgi5q62CaPxlOFBK5/4zXSyKycFTmSQRh72LflR5d0qm3+qY97gMGZDTDS/35Mdgsmv065pmvj+qMcjEm+XPjnUASUuQ30AzqTqufqKYuD4VH8cOWr0GasRCi1apH1fQMBhpcfYQ7KFTq6vhRT1S6iqMfXUm+/RWstnuYvo0J+qTbYF0JNFmItXczjKLJMaeaF0YmSiHAIXY5QOKgQNHcN3ygIPdzsYIzxXzYu/pDqbT2gp+MyciWCgYJuHN9e2nntoWv/7HrIj894wy2D5TGcj9Hyi2FDWeqjoJzPKb8dG7BtqmMZR/FbgX0lBi2tCLMGPYW0wZHCFnJDdLheYZ7ejw2aDN1frYM8tqfWHvHBf55s2sF0MOxjvuQkAi4MQGdN4PLHS4V57wgPRsf+lY7KW7N8H7WKEBGOxFOWCJo7XlKkhxo9m8GjzIY3NtEzWaBZtBAKVymDrzBQUs3YOIrktOeMG11dwPRpNtiN8Q49wlaFdBM8/GCzc9hsnrFuRPmcF3bMi5++NMxJadfBEqd3TtH2Jh7DpOoCC3fW5pHz3DrAL4nPIketmghyp9Y95CIzisW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2906002)(31696002)(956004)(6486002)(2616005)(5660300002)(44832011)(66946007)(508600001)(316002)(26005)(4001150100001)(8676002)(186003)(16576012)(66476007)(8936002)(31686004)(38100700002)(83380400001)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkh0Uzl6bmwxRkFXUEFPcnZzSFlsNEd6L3ZPOWNlTmxteEZibTZjU0dHbFBr?=
 =?utf-8?B?cUFreXRzNEtMVnF1YWp4UkRPMXFWN2pNQTZkdWVHY3FoTmJDdzd4bHdXZWs3?=
 =?utf-8?B?QzNoNTVxK3lqSk1rZ0ZsVjdHVTRUSTdYQTVidDQzY3ZYN1RGV2g5RFh4RmNL?=
 =?utf-8?B?Z0VaTVFBMEJZMjFOWmdiY1Izd3VVVlpjd2xNZzlvSEVHaUpMNW9ZZVBpT0FI?=
 =?utf-8?B?cUFVKzBVWDJSTEJGM00wdW90aDc1Y2NEeEVzRUlTTDJHR0ZNNlpOcmQ4MGYr?=
 =?utf-8?B?cGFaWXhyam1RZUdHdktjM2kvb1RjNHZJQXQyN2V5VmwzU2h1akpSSGRBY2Zt?=
 =?utf-8?B?WjVaUUpEbDJ1SUZPb0JpODFwS3VGb3YxT0o4MGkwdXhrK2pnN2VrTnUySTdF?=
 =?utf-8?B?TUVLYzFySEtGRU5qdDh3cXRLN2NaR0pxaE8ySVBiNWI5eTllYmY5R0hUOGtH?=
 =?utf-8?B?Ymh1MWlub1FackQ0ZmE5ZFcwUk1tcGZBUmU0aCszVUk0ZldFMCtlbEptR2pz?=
 =?utf-8?B?TWRkZDIzSlRabEVKRTRjV1dyd0hLZm1QcGZURG5WNUdqNGlyN1hxakdpR2tx?=
 =?utf-8?B?NHE2eCtNNEtCSG1Tc0JwTHF0RzBqa3hUMGhtckV4SHVHZkVQV08rTnRYSnpE?=
 =?utf-8?B?YlpkUG0ySmZ1UUNKMHI0NTZZZ3VITTRZV2tYUUpyc0VLRkZJUnQ5dm02NUZC?=
 =?utf-8?B?ZW9oLzdXMURkMjc1dEhJdUZIMkthWmVBbFp3NVg4WFdSTFlIRkt0TTI4azll?=
 =?utf-8?B?eG9OTkU1a2RwTVM2QzcvZTFnZ1AvbnRCUEhsUTFlTzFtd24rTmlBRHFnRFFv?=
 =?utf-8?B?eEppUGdRMHM1OHhLNVpvdnd1M09ROTFOdnM1YWFleHQ3VXdhbTdFZExsMkMw?=
 =?utf-8?B?MlpNV1FhQURpUjFWSUJFYjZKWHJqUTI4QitWMUl4UGRZOTFmUXR0akJnREtS?=
 =?utf-8?B?QTArczN5OURWcVJDZGJGUHFGdUNyWEhTT1pHUmQyZ1hwMnU0Y1dnM1NRc3Jn?=
 =?utf-8?B?VXZ4czZxOUJVaGMvMU52dmF3RTBPbzJraHd3RmFTd3doSDBoVnUzN1BWa2hu?=
 =?utf-8?B?NlBzd2dqcVZ4S2JIaDdUS3JwNmhGRk5uY3FtTTk2bnB0dUllUmRXbGVjYis0?=
 =?utf-8?B?SlFCaUJsejVFWXI4UUtWQTdja1dRMDI3cWpMRHhtVTZ6QWVObW5wTm1nWklH?=
 =?utf-8?B?eXIyV3diODgreWhMNjhOLzNEZXQ1Q29uUTRzNzVRYjRkSU8rTWoyOGxNeVZm?=
 =?utf-8?B?NzhuWFhPUnpVUGFlcWhkWG41anBOUThRRWg3SUZLRjVFMFVSOUVFZjRRQnNy?=
 =?utf-8?B?MDF5Rm5oQ3g0eXF4Y0JSOVFkbjVtZml3RVdiZHFndkRCL0diNEdmeXRXcjdj?=
 =?utf-8?B?NE1LK0o3dlhkYnNRRURpRUs1QWFUdlcwOFY4R0VMNEVxQ2diYWhZcCs2SGU3?=
 =?utf-8?B?cVExUXBybWRvVU9KdzRtVUNYVFRCL1hQS0lmV2VTR21OWXU1eHpoMUpsS01L?=
 =?utf-8?B?ZmVNTjZPVm4yVCsxNm5YMmpVTUNnYUNNUnplb3hWb1oxVklKTkZnR0hvbU95?=
 =?utf-8?B?NUhVc3cxc2R6RVR4RFFxY3BEb3NXNDdwOHRQQnQ0R0xQUmVrSjN6dTlPd3RW?=
 =?utf-8?B?WnpmNDFYMm9ZOUg1S3EvTnIxK3ovMHRGNFo2dmVCWGdiajBadnZmN0tjb1k1?=
 =?utf-8?B?eWJSSGFtbVlVYmJrbk13ZzJrVFRYVVEzYmlSSW5aN1pZTVZ1ak1rZDZ2SmJY?=
 =?utf-8?B?WVNtWG1XcmJ3ZHV6VVV4TmRwRzhHQ1lkNkRNT1VmK0I5emJJYW91eGZuKzl2?=
 =?utf-8?B?Mk85WEEzYm5GanBlY0NFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f37642-62a6-4eaa-19cd-08d98dd28516
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 22:49:16.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0iuOLdsqLzZlvQQZgzrILUaJVDcOdw28Ha0mD1OMGyO/mJeTlOA4wKNhLPzihayHbtjxZkDkWNPzCO5iXD83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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


Am 2021-10-12 um 6:39 p.m. schrieb Philip Yang:
> migrate_vma_setup may return cpages 0, means 0 page can be migrated,
> treat this as error case to skip the rest of vma migration steps.
>
> Change svm_migrate_vma_to_vram and svm_migrate_vma_to_ram to return the
> number of pages migrated successfully or error code. The caller add up
> all the successful migration pages and update prange->actual_loc only if
> the total migrated pages is not 0.
>
> This also removes the warning message "VRAM BO missing during
> validation" if migration cpages is 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 86 ++++++++++++++----------
>  1 file changed, 52 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index b05c0579d0b9..537e32f77eb5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -376,7 +376,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	return r;
>  }
>  
> -static int
> +static long
>  svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			struct vm_area_struct *vma, uint64_t start,
>  			uint64_t end)
> @@ -413,32 +413,37 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			prange->start, prange->last);
>  		goto out_free;
>  	}
> -	if (migrate.cpages != npages) {
> -		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
> -			 migrate.cpages,
> -			 npages);
> -	}
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
> -					     scratch);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
> +
> +	if (!migrate.cpages) {
> +		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
> +			 prange->start, prange->last);
> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
> +
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  	svm_range_free_dma_mappings(prange);
>  
>  out_free:
>  	kvfree(buf);
>  out:
> -	if (!r) {
> +	if (!r && migrate.cpages) {
>  		pdd = svm_range_get_pdd_by_adev(prange, adev);
>  		if (pdd)
>  			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
> -	}
>  
> +		return migrate.cpages;
> +	}
>  	return r;
>  }
>  
> @@ -460,7 +465,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	unsigned long addr, start, end;
>  	struct vm_area_struct *vma;
>  	struct amdgpu_device *adev;
> -	int r = 0;
> +	unsigned long cpages = 0;
> +	long r = 0;
>  
>  	if (prange->actual_loc == best_loc) {
>  		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
> @@ -492,17 +498,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  
>  		next = min(vma->vm_end, end);
>  		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
> -		if (r) {
> -			pr_debug("failed to migrate\n");
> +		if (r < 0) {
> +			pr_debug("failed %ld to migrate\n", r);
>  			break;
>  		}
> +		if (r > 0)

This should be "else if" or even just "else".


> +			cpages += r;
>  		addr = next;
>  	}
>  
> -	if (!r)
> +	if (cpages)
>  		prange->actual_loc = best_loc;
>  
> -	return r;
> +	return r < 0 ? r : 0;
>  }
>  
>  static void svm_migrate_page_free(struct page *page)
> @@ -603,7 +611,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	return r;
>  }
>  
> -static int
> +static long
>  svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
>  {
> @@ -640,29 +648,35 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		goto out_free;
>  	}
>  
> -	pr_debug("cpages %ld\n", migrate.cpages);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -					    scratch, npages);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> -	} else {
> +	if (!migrate.cpages) {
>  		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
>  			 prange->start, prange->last);
> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +				    scratch, npages);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  
>  out_free:
>  	kvfree(buf);
>  out:
> -	if (!r) {
> +	if (!r && migrate.cpages) {
>  		pdd = svm_range_get_pdd_by_adev(prange, adev);
>  		if (pdd)
>  			WRITE_ONCE(pdd->page_out,
>  				   pdd->page_out + migrate.cpages);
> +
> +		return migrate.cpages;
>  	}
>  	return r;
>  }
> @@ -684,7 +698,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>  	unsigned long addr;
>  	unsigned long start;
>  	unsigned long end;
> -	int r = 0;
> +	unsigned long cpages = 0;
> +	long r = 0;
>  
>  	if (!prange->actual_loc) {
>  		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
> @@ -715,18 +730,21 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>  
>  		next = min(vma->vm_end, end);
>  		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
> -		if (r) {
> -			pr_debug("failed %d to migrate\n", r);
> +		if (r < 0) {
> +			pr_debug("failed %ld to migrate\n", r);
>  			break;
>  		}
> +		if (r > 0)

Same as above.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +			cpages += r;
>  		addr = next;
>  	}
>  
> -	if (!r) {
> +	if (cpages) {
>  		svm_range_vram_node_free(prange);
>  		prange->actual_loc = 0;
>  	}
> -	return r;
> +
> +	return r < 0 ? r : 0;
>  }
>  
>  /**
