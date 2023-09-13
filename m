Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0E5EE3F39
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 00:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FF610E0AA;
	Wed, 13 Sep 2023 00:32:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1485A10E0AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 00:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok1GXd5KXXYPWTTMaxZ9qyXTOP4m0GjnClAgAq/Y/xeutOW8Yol2eVd2+Nhjdxigpb/4fMqB4Agxi0n3dOxg0722x6MkumB8ZloSEBI15UGCwx7Lp1jhuIMBwN9LCsdiZyEsjgJpXXxtze/9u+4kYlgRCzzzcc8E3+V1S+KO02NPcY6dnlT97McI4uPtsUOBxBUiSnv68vgHBibLj3AuYTbXNrrRpAMTXHVQ16Wz84xnafr7t+k5tB5PSB4TwRUeYEPswBqKAjG9QBCP4FEVJ0dD74ILtQcQSDXrRGqE/Bpsm4B46Niq2aph0o97OwRGBcp7soW+BEwx+uY4OUrzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9OHELFh7YX/ccb5AhWIw6Ecm4N9H9kPMNghILWHS5o=;
 b=ixJyydIwcUwYHO8ai2Dcv5j3vpCq8S7SseOayJG7agjgol93nBXcJmiitpLQZJ2xbW6P6C05AVu4LIlj8MK3i8ZtS+qOthPewgJLAgselttmDvZBzhtNAsSzwSChu5d8zIkEcz59vmTJiVlh+zptlUyOW02QNeEsLE49JvWfSQn/HA8hK1frXji/iFnXOPyumWKnlz9gjQC5FUQ9QC5/OscXjKuXEonXV7Phn4vKLBXbILFOvk8Im6ZVtxtjJ8aA0iN87kzSEwQQCA7cuuJ5sR0BZF+tvjFDEBiCFduRRJ4Dsf0RiLp4PLLsk/AaNw/XFAHhOCDZkSXN/ZsXWyA2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9OHELFh7YX/ccb5AhWIw6Ecm4N9H9kPMNghILWHS5o=;
 b=IS3o3B1PWzlVXwfYrhpp6qqZbKTgsXyTCxY2p1Vnv2fUvFtnw4f/BigfK2heEj63GclZvfLrNObrkHLzMKcuzwerUe6E0j13r2Lnb4mktOZM20Er3Y2oacLkP5D1r6HXe3dr7J5C6RPDuxL9neJvLbpDVteO/nTNFZUjqC0V5BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 00:32:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:32:54 +0000
Message-ID: <b8c0f15a-fff2-d95c-6516-f3a8a94fca0e@amd.com>
Date: Tue, 12 Sep 2023 20:32:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] drm/amdkfd: Move dma unmapping after TLB flush
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230911195517.8548-1-Philip.Yang@amd.com>
 <20230912152917.28928-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230912152917.28928-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e00949-57eb-4008-034d-08dbb3f0f88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mL6+FBd+gFX4TwrdOSDaChQkGX/7HmmxJSOuDA40pJphurEqTngVPlukQ6bdA0deilJ2zC/3L7DBd3+uGkRfQ2SslWug7vXD31lJ2qMo/a9VIScUEoSy9Lmkt+TLjjnnIWHCQKosLr8+4nkEKHAATYf1unePFhUZ27m5mTbJTD08xesrNN+c8z0T4okCmTJBUZ48mClMF58VlkI6t47ieocJqmtsspqKQrHsaqjJgbpq1E3wJdmbc8f3mtVWMeB4qIztxiOIpN386SqhO02BEFGLd5Imyi/zN2pFDeH4kae2X5sSTXP7pgaye8vnr7nqzs36ApGgjgfXhRBDtrDTLCOLLcS4P/H3PPnUuvS3QrJDELT1tV632GfoqT8Ov16a0l7tYxB3Rx16kaBNwjCyGDn8ipp11B3a879dvqhLyMSUiEtXmOsY+il85ozQ8UIW9J3ZXFWOEf7XXLTy6RrWOhYwSsqGLaXFhA/yYv4JYg1hNeU4ImFCH1TcV3DgEfQrePPlbnXGf8kvXqJyQ1/kK/2xn4bNUaKazfNU+02gUIVkxJjBRe710hdUrxQL3AlcWvH72ezvn0VBX8IYCvu6iUmQZlYBIYanr7nRdSetpZlpO+eQTAwytw+JRKgkGeZNBelhRiLoXMEkWzI20q/+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(478600001)(41300700001)(66946007)(66556008)(6512007)(53546011)(2906002)(36756003)(66476007)(38100700002)(6506007)(6486002)(31696002)(86362001)(6666004)(316002)(8936002)(8676002)(26005)(5660300002)(44832011)(31686004)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3EvU0hweGlCZWo4R1Z4TUd5SmxuVTBqVkt6NWtFUEhoN2dJWGNQZFF2Uy9U?=
 =?utf-8?B?VVEzSmNhOGdiK0pRb0VFWG1ML2grdVVBd3VWNU1sQ3FPVWF5RzNvMkpMTHZ2?=
 =?utf-8?B?MU91d0NBeFMwalNZTlhvOHNyYlBXU0VsNGhTKzlpcnlaSU9EdFJWdldJMmxQ?=
 =?utf-8?B?bDEwN2xtbkd2UlU5SzA2OWtaQ3Mza3RJdXlRSHEvV21SRmRPYW14K3NwbXcr?=
 =?utf-8?B?bi9IZ0xMeVVGc0xRcGx1Y0wxMVlIaGs1UlByT2l4K3JySXZUVjVIZTZLSWJ6?=
 =?utf-8?B?TG0zemRhbmRiR2E5K0JlWXBrQ3Q5YTRxa0I4TE5tNUtLUlYwUWF1STZCZHpS?=
 =?utf-8?B?dmZCZW0wNEw3SGJjNzBVd1pKaDdHaWxTUHNKaklRUkRWZVVCU1AwdTJTbmJO?=
 =?utf-8?B?ZitmZG1YWGNkV3RkNCtDdWg4NUI3SjhnNUhIUi8yQjBvbkFxTERkOU9qU2Fs?=
 =?utf-8?B?UkNyTUhlUjFXajg3b2xlY2loNTM1WlQ4SG9vUDc1RFVibDc2b1REVnMyUGFk?=
 =?utf-8?B?c29OVE1ybVV1SW1RbFM2aEZsYTVtbmZLT0dEcTd3elhBZXZOeDFweTFiZmlp?=
 =?utf-8?B?UlpZZWJZa1E3OEhQVFRKa3NNYVNENlY3d0V5UzF2VC9FZi9UVlFvZmZiRUsr?=
 =?utf-8?B?V3JYWHRlZTZTaytwbFJ0TURLanZnWnozWEl2NWVJbFhmVEg1T1dNV1UyYzhT?=
 =?utf-8?B?eFlKU3ZWQTNkY2JnTlFHcHc1SVVYcVRwOHdzOXE2QkgwTEV5b1RnL0svUXRn?=
 =?utf-8?B?SGl4L2l5czNNWENvV00rTFVPZ1pnZnI1bTVzV1VyaTdheVpEUlgrUUZXcXFr?=
 =?utf-8?B?amVrVWE3K2pEYThsNFhtUmFEU0NqdWFBSUluN0hETXAwNHUvOGFHOGZnKzEr?=
 =?utf-8?B?eXhCNkk4NkRINGw4NCtnWk5qWVhhTUdVbXN1UXRGamVPVmdHaXRXN0RPU0Q2?=
 =?utf-8?B?VUIzS1V2RWRXUFc4MGlTSk5JaEs1MHRnTXp0Y2JaVDdOdFNkb042aXprVndw?=
 =?utf-8?B?R2tUcjVEeXdyTUQzdjZkSlFZeWVJT0d5cjdZcUIyOXYwNG42bEwxcTdwOVpa?=
 =?utf-8?B?dHBwNVVQUHd2WFV4VlhINFNPNURFZHU1bDFTMUF3bWZIUTVNeHNGOGdlY0dI?=
 =?utf-8?B?L09Za0kwVGN3Q0Y1SURlQ05hNE40L3BZVGZRR2ZKUXdzSEh5ZjRhYmJ1QXR5?=
 =?utf-8?B?K1ZWMUJvSjR4NWUzUTJ0cGJLNENqMm9rUXk2NS9wcFlOR2kzMUpZOFJaR0dZ?=
 =?utf-8?B?UWdDQk56RUZsUENHK0Z0TUJWQ3dCeXpwaUFodkdBdGtocnBZc2lMQnZEOHdB?=
 =?utf-8?B?N0lFSzJZblZxazFlS1BpeTI1ODYvNEdHaXdSYytoMUdZbnY3WTd1N3U2aWlL?=
 =?utf-8?B?ZHdEKzBXMkFRZVVENDFweEpSLzBrOW9MTVN6ZlRtSU5nSDZ4TEdKSVBQQy9P?=
 =?utf-8?B?TEhzVU1ZeE9kckUycFlNb0xSL3laNXR0T2ora3NFUkNLZmtKK3VoS2huTFNQ?=
 =?utf-8?B?SWJEWXljUWpNQ1pEZVVMRXgwNGk4YjJBbzFvZEM4UjZsN0xPbUwvYzlkcTE1?=
 =?utf-8?B?NVpTeUpicENpb3FxR3RUS25RUjZiOGdVSDZldk94M0ROVStWT0Z5czY3Q1lN?=
 =?utf-8?B?MzRtYUs4dnRDa0ZmMWVndnduN1RndVExaFkyQnJHbW5uakNvdHIzdVhTZlJQ?=
 =?utf-8?B?cVRYRlc5aVFFbFFUYlFpQS9SVHc4Z0RoQ2RjVG83TVBIVldnRHpoTkF6WWRh?=
 =?utf-8?B?MzBZemg1Tmc5S29oSUNyVm1jVEtUakFYUHZRem1kcnNYbytnaTJwYm1qRHpk?=
 =?utf-8?B?R1dmV2xOZ2FyT0dQS0lta3NoNFIvaHhweHFmNlcrWVFGN09DU1BFU2M3dTNu?=
 =?utf-8?B?TTdUQlJiZ2dSN3J5SEY4TGpzWTNzR3dydnhmTEJvMnR4U01PSVNxUllZV25Z?=
 =?utf-8?B?QzdRZVoycTFWaXZqRHo0bk9MZDVYb0xHZGZVME9vOVR1cGI1NW1aSi85NEs5?=
 =?utf-8?B?YmMxT2hJeUl1M2o2MU5wcFd5alNjTnhoZTFheUw3LzMyWmVaR2hrSzRseWxG?=
 =?utf-8?B?RFhVUHhUdXVYQUd4dDRyK3pBSmhDRGU5K2Zaeld0eFQ2NXlLQVRDSlFlK0xX?=
 =?utf-8?Q?hANPcnYqfLXnxzf7aGV016+e4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e00949-57eb-4008-034d-08dbb3f0f88d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:32:54.7886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBMqCDd3C/rHcn0FM1KevxDT7hgIpGXihmXHeYlbQBLbbALq+bdZA2YHPlMReTiivFPPaqp9YJxcc4IhgoyV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

On 2023-09-12 11:29, Philip Yang wrote:
> Otherwise GPU may access the stale mapping and generate IOMMU
> IO_PAGE_FAULT.
>
> Move this to inside p->mutex to prevent multiple threads mapping and
> unmapping concurrently race condition.
>
> After kfd_mem_dmaunmap_attachment is removed from unmap_bo_from_gpuvm,
> kfd_mem_dmaunmap_attachment is called if failed to map to GPUs, and
> before free the mem attachment in case failed to unmap from GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 26 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 20 ++++++++------
>   3 files changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 559f14cc0a99..609a6fefd85f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -304,6 +304,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
>   					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
>   int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b5b940485059..7177cd884fe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -731,7 +731,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
>   	enum dma_data_direction dir;
>   
>   	if (unlikely(!ttm->sg)) {
> -		pr_err("SG Table of BO is UNEXPECTEDLY NULL");
> +		pr_debug("SG Table of BO is NULL");
>   		return;
>   	}
>   
> @@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>   
>   	amdgpu_sync_fence(sync, bo_va->last_pt_update);
> -
> -	kfd_mem_dmaunmap_attachment(mem, entry);
>   }
>   
>   static int update_gpuvm_pte(struct kgd_mem *mem,
> @@ -1305,6 +1303,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   
>   update_gpuvm_pte_failed:
>   	unmap_bo_from_gpuvm(mem, entry, sync);
> +	kfd_mem_dmaunmap_attachment(mem, entry);
>   	return ret;
>   }
>   
> @@ -1910,8 +1909,10 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		mem->va + bo_size * (1 + mem->aql_queue));
>   
>   	/* Remove from VM internal data structures */
> -	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
> +	list_for_each_entry_safe(entry, tmp, &mem->attachments, list) {
> +		kfd_mem_dmaunmap_attachment(mem, entry);
>   		kfd_mem_detach(entry);
> +	}
>   
>   	ret = unreserve_bo_and_vms(&ctx, false, false);
>   
> @@ -2085,6 +2086,23 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	return ret;
>   }
>   
> +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
> +{
> +	struct kfd_mem_attachment *entry;
> +	struct amdgpu_vm *vm;
> +
> +	vm = drm_priv_to_vm(drm_priv);
> +
> +	mutex_lock(&mem->lock);
> +
> +	list_for_each_entry(entry, &mem->attachments, list) {
> +		if (entry->bo_va->base.vm == vm)
> +			kfd_mem_dmaunmap_attachment(mem, entry);
> +	}
> +
> +	mutex_unlock(&mem->lock);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 65d2b9ae16bb..06988cf1db51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1432,17 +1432,21 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   			goto sync_memory_failed;
>   		}
>   	}
> -	mutex_unlock(&p->mutex);
>   
> -	if (flush_tlb) {
> -		/* Flush TLBs after waiting for the page table updates to complete */
> -		for (i = 0; i < args->n_devices; i++) {
> -			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> -			if (WARN_ON_ONCE(!peer_pdd))
> -				continue;
> +	/* Flush TLBs after waiting for the page table updates to complete */
> +	for (i = 0; i < args->n_devices; i++) {
> +		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		if (flush_tlb)
>   			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> -		}
> +
> +		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
> +		amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
>   	}
> +
> +	mutex_unlock(&p->mutex);
> +
>   	kfree(devices_arr);
>   
>   	return 0;
