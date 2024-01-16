Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F0C3DA79
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 00:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B3910E15F;
	Tue, 16 Jan 2024 00:15:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD40510E15F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 00:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnxz4xXZ+NSaoZ1kOsovoB8ZCLVR1fEdsCIcJ1B3yyorWULYFZgl1wBicNaih/rTl9sjS+XZkXA7UDPo4nPyeOau9ljNIiHyNMndLkv0jEiPdHW0dAS8I98Q2gQ7yeMRzdX3yiTvZUnITThAVWivxXCJBcAJj38IIgurb7ib8nGS8dYRwuVVgqUhQ8bm+ajHDy5RTJEz3Mot1EXFlaugJrJr6Lye2GsfswjPkIgjPw7etl92mmk27QbSm3iQk1Em9S+qZHaBw9GICfGifZu0s2q7ZNoxH9bKFIjcdI/d54mhDogAr0XaYeDWoINpLdxhrfBVUSJf+aG1rt2bGvpviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A24301U4IsdDQGrAtWzLiihqVGHN8ocbE+bDEBONgII=;
 b=XTiy+YgzDD6WdDBqRsjIEF9+jWlNr8XjClhPUTjQlA0Bar3LAVKIogrlKFIqCFiknHlqR88lomOYFB+bzTCzqdWESGLfLPUx1vC0ozxtWCZ5L++7adWq1+H3PaHyj9PaMSp4TeXqHY4Bv+iJQZVYunbQ7lo14I1IYWvDeqASjPkHAGbtWmyf/E1snxHUatkFY8lteGS9lZck+Y1t5SnLGJUJ8KPxSxANBc/JlkdIsXsj7tvo1+Vj5bytu3xcOMSUeh3ggNuE/mFFPKhk7kRaClStxNSkybwzBZ5RFHHh3R08aNzKX6sM3mWKA9jy51EX2xdAp1xQLKMQF74orupuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A24301U4IsdDQGrAtWzLiihqVGHN8ocbE+bDEBONgII=;
 b=oRR9VRrX0sWsR6uXWngMck6aKaIP9Ha6FThGS6SmXZalwmEgXelZy9QbuhnGHcBfVsso+Glt7KPOg6Hf+ll0s5qkMGsNQd66VdKScL8NPbS3gKmYzJuZnN3D/pzzdua2r94GSoTpzIyIzImyd9QnG77uAH4OP9CDPC57Yj96mrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 00:15:18 +0000
Received: from BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::8323:ac7:8a82:64e8]) by BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::8323:ac7:8a82:64e8%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 00:15:18 +0000
Message-ID: <dfab36c9-4c03-f8b2-821e-65e0c32c8694@amd.com>
Date: Mon, 15 Jan 2024 18:15:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] drm/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240115220228.12824-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240115220228.12824-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c5718c-0742-4424-1119-08dc16283860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/9Y51+2IZpOBWd5kFHnpNTyPpXIaZQzQnU2hxuH74xoW6C80Jd7Fl7Fb3+rjankedlp2djF3HZJNxSlalZ4B9cs6XZ8hkclqinIwA++l0zsK26pZfheMyiOhCKEChutBqE4NMhmREiqDIbMlpzSAOmPogb0/JGIUPNj+94ARu2cJKIm8AgV/Egu/EQ/3kq19cXtVMDE+wnN1dSZMNnYT+pplfSR1LGn30WfStTtRWOkxNwJiogIUod+rHiAMwpGTDI0g4kmvN+WuPHpbmhlaCmOmKuyNrqSdthF4caorp2APpSZDxqukiHUbZlWHkuJz0C7LQn45PwmJITEzOh4zCkUcorCnXwjYU8ncBodV6veJmwdghTDYaOShTD2YlBZDIQB8aL/pe3y4wWSJKotdo4HNmiNcYmpkWM9g3BcRF3YznxmnHw99v5ftsWsv5FFaUYKcU1usip44V8PPizRrvXc7BYZZv5KcDILqAM951iIMTuXSs5o8AHPFSxCSPTxCA4G2Ha7rJNukM4UKG05FD0cVrzQNeQY7zq3O5LtmOSzTAenzL82RMzs7bRet/nxLo5bS+gZd8AZEIIpl5nH5dvfcEiosbfrnmfGA68VmhfOsbDf27Kx6wZe225haqhLycSUtubpJR2IrJgyudXpWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(478600001)(53546011)(2616005)(6506007)(26005)(6512007)(66946007)(5660300002)(4326008)(83380400001)(6486002)(66476007)(66556008)(8936002)(316002)(2906002)(8676002)(86362001)(31696002)(41300700001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJjTE5iTENRZ1lnYjZNMzNNUDN1TGNwVnNIWE9OUk0yNUxIbmdXUzB6RHRZ?=
 =?utf-8?B?VUNtUk8yS1Q5dTMvSzVGYjd2TEV3ZGhZRzlJeStlNnUvcWVJZEZyK1MvY3Bz?=
 =?utf-8?B?UldiZy8yUVRSeU44VFJvamFINFhld25reXhvTFVWdEdUckFoNGM5MVNYZ0hZ?=
 =?utf-8?B?SGpUcG5qUERndzl0amE5K0llWXVDWkN4cmE4TWFTNm1mVVo1ZjU5QU5xZmRR?=
 =?utf-8?B?LzREbFZHU0psN3FUOThvak1IeTJtelBtdWhOUGhMRFFHNGRudzJvNDAwTkph?=
 =?utf-8?B?UGVERFNTVFhyb0k2YWdZaC9OeS9UNHhzVFNibHB0ZFdFVFptU1ZmOXl2UEZD?=
 =?utf-8?B?eDFzQzg5bXlnRXdLMS94M3hDSzRkeHRwRHA0RDJSamQyck8reXhXbnJrLzhN?=
 =?utf-8?B?bnhEQ1hZREpFNHJmZWR3RDVGek9iSGRocWM4eDdUTWJiYVVSRCtHeXlMRTJw?=
 =?utf-8?B?OHlhNFlHVXhFUnIvVk81S2kxOW5yUzQ3TWs3SWg3UlpKNnNYZUV2dW42ejBF?=
 =?utf-8?B?Y0c2cU02VzE4bC96amlhemhRSm9wdFpJUkx3NG1lWCt6aGJxdk9EcFZ0SW1n?=
 =?utf-8?B?UHJjRHRjZVB2NXI5bi9WVjErc3U1aUNkQU1oVXdBNm9jWFlnVHhQaS96c0Vw?=
 =?utf-8?B?c3Y0OXlHZFJyRE5vRHMxMHlvYTFBRVEyeXI3aC9xSEpucG9WU2VvR0ZwWDdF?=
 =?utf-8?B?dlNPMkNmRUIzNFBla2tsTjk1YzRtUEJvT3crQkg0Mkw4Y2VkTmpjNE14aUhl?=
 =?utf-8?B?SjQ2cW5ydVVpMlBJVE5VUnVoN05La3BrcVdkUW5zNDNBZklXZGFGYTlQdDg5?=
 =?utf-8?B?Z0hmSENjRzZEYzVucmkrNngxQlVHRUVTaWJNaXcreFNlQ1hEcFZ5L1dvMFVO?=
 =?utf-8?B?WFZabC9FdjJjNHNnWFdJcysybGFCQTg4ZW0yNklHTGQ1NWdlc3hQaEJNSTha?=
 =?utf-8?B?WVo5UXlLYXd6QVptWWdqOUIxQmM2MEkxaXdKODFJZ0J1QTE5cHJTVzdKSWg1?=
 =?utf-8?B?c2dldmZEb2h5OHJMU0c1eUYrYTZOSU5iNVhVaEtNK1ptOU9HRUdZYWhaN0Nv?=
 =?utf-8?B?ZnBQbjJna25MT1BnVWNxSzNaZDgzM1pDcGRzWjYwNWV0QnpocTZqcHJoSDJ0?=
 =?utf-8?B?MjQyK1E5WW0yTGRySVpra2s0d3FjTTk5WFBMQjFkaW5hNUNjTEdHa09OSURv?=
 =?utf-8?B?Q0x3RHFDT3lXeE9wbXB4dExJdU5Ca3hWeTBwZkhuZHpIOU9OK3NrMlhTc0pm?=
 =?utf-8?B?VzFpQ0RMRWp6KzdBOHBMR29wcGE5WWx2dFh1R0dPdUJmSG9nVnBzZisvMzBQ?=
 =?utf-8?B?dEV3dUl5TjVYM3dpSjVKbUZGSUlSbGZRMm9WSVFTbmZXVVFuRWlvWG1ORStQ?=
 =?utf-8?B?UW1zOEcrVzZkNDdSVU5jL3ZTWjgvNllrUEh1c1JSUDlzREI2bGd2SW9xOGl5?=
 =?utf-8?B?TDM1TDFzd3ZBRmR2cEJ2VGtndHB5dmxobDd0STQzSHJwUnl1UTg2NHA1NXhR?=
 =?utf-8?B?NmZXaEhtUUtJdVVTZnVZbTBTL0VpRy96VEFyK1J2T1EycVZuQ2ZYVlMrdTNm?=
 =?utf-8?B?U3FIb2lvZ3JNUTBhR3djV1NzODE2VmNXdVJkKzVpSW1PWmVZOUtGbURKTE5q?=
 =?utf-8?B?ZHo0eUllYjBXdHg3Q2l6SnQvaGZIbGVUak16dXdkaTMveTg5bEpmR0U3QU4w?=
 =?utf-8?B?ZnZwaWMySVQranh1T21hM1lrdXdFMWFoSzBpRGdKYmFoNHpVaVdYUm9sVnpX?=
 =?utf-8?B?UklVWFpGaXBqY0F3UEtTYU4yTEJtdkFMeHBoUVB3RDZoc05yeHdoRm5VYm5y?=
 =?utf-8?B?VVJQdTdRR0hPZEJ1VTRLYVVodmVXWXpHOGtBSXBEVUVlV3dJOFAycjVibEty?=
 =?utf-8?B?TGdEaTVTR2xwSXZyZkNZSnJWejhmTGV4cDREd1U1N3FDdGJEZHFwTUlYd1Fl?=
 =?utf-8?B?OUlmNG5xL3lzRDh0STMxWHFyNDNhY002ZXFoOGozOUFTajk2UXFXT2xiN3pE?=
 =?utf-8?B?d0N3M1Y2Y3NTdHk1VmRqOWZKUGl4RkRrY1BZWTYzNnVjZ0k4WlRTcFFXYTZw?=
 =?utf-8?B?TUtRM0Q5ZGVEN0tOTXNmdTFlSWlUM2J0a3NNUEM0ekdIV1pIK0Q1emRsejh4?=
 =?utf-8?Q?72cM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c5718c-0742-4424-1119-08dc16283860
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 00:15:18.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCB27Va3/sOAjmEUmHfBn0uvXIozLbJihWe4VmBgiS58JL0oU6PuvVAlNRi6gsPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


With a nitpick below, this patch is:

Reviewed-by:Xiaogang Chen<Xiaogang.Chen@amd.com>

On 1/15/2024 4:02 PM, Philip Yang wrote:
> While svm range partial migrating to system memory, clear dma_addr vram
> domain flag, otherwise the future split will get incorrect vram_pages
> and actual loc.
>
> After range spliting, set new range and old range actual_loc:
> new range actual_loc is 0 if new->vram_pages is 0.
> old range actual_loc is 0 if old->vram_pages - new->vram_pages == 0.
>
> new range takes svm_bo ref only if vram_pages not equal to 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  8 +++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 42 ++++++++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index bdc01ca9609a..79baa195ccac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -564,6 +564,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			dma_addr_t *scratch, uint64_t npages)
>   {
>   	struct device *dev = adev->dev;
> +	dma_addr_t *dma_addr;
>   	uint64_t *src;
>   	dma_addr_t *dst;
>   	struct page *dpage;
> @@ -575,6 +576,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		 prange->last);
>   
>   	addr = migrate->start;
> +	dma_addr = svm_get_dma_addr_for_page_count(prange, addr);
>   
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
> @@ -623,6 +625,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			goto out_oom;
>   		}
>   
> +		/* Clear VRAM flag when page is migrated to ram, to count vram
> +		 * pages correctly when spliting the range.
> +		 */
> +		if (dma_addr && (dma_addr[i] & SVM_RANGE_VRAM_DOMAIN))
> +			dma_addr[i] = 0;
>   		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f84547eccd28..78b4968e4c95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	INIT_LIST_HEAD(&prange->child_list);
>   	atomic_set(&prange->invalid, 0);
>   	prange->validate_timestamp = 0;
> -	prange->vram_pages = 0;
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> @@ -965,6 +964,24 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
>   	return 0;
>   }
>   
> +dma_addr_t *
> +svm_get_dma_addr_for_page_count(struct svm_range *prange, u64 addr)

I think this function name is better be: svm_get_dma_addr_for_page_addr. 
Here we do not count page number, but get correct place to save dma 
addres from specific gpu vm addr.

Regards

Xiaogang

> +{
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
> +	dma_addr_t *dma_addr;
> +	s32 gpuidx;
> +
> +	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
> +	if (gpuidx < 0) {
> +		pr_debug("no GPU id 0x%x found\n", prange->actual_loc);
> +		return NULL;
> +	}
> +
> +	dma_addr = prange->dma_addr[gpuidx];
> +	dma_addr += (addr >> PAGE_SHIFT) - prange->start;
> +	return dma_addr;
> +}
> +
>   static int
>   svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		      uint64_t start, uint64_t last)
> @@ -980,9 +997,14 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
>   		if (r)
>   			return r;
>   	}
> -	if (old->actual_loc)
> +	if (old->actual_loc && new->vram_pages) {
>   		old->vram_pages -= new->vram_pages;
> -
> +		new->actual_loc = old->actual_loc;
> +		if (!old->vram_pages)
> +			old->actual_loc = 0;
> +	}
> +	pr_debug("new->vram_pages 0x%llx loc 0x%x old->vram_pages 0x%llx loc 0x%x\n",
> +		 new->vram_pages, new->actual_loc, old->vram_pages, old->actual_loc);
>   	return 0;
>   }
>   
> @@ -1002,13 +1024,14 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>   		new->offset = old->offset + npages;
>   	}
>   
> -	new->svm_bo = svm_range_bo_ref(old->svm_bo);
> -	new->ttm_res = old->ttm_res;
> -
> -	spin_lock(&new->svm_bo->list_lock);
> -	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> -	spin_unlock(&new->svm_bo->list_lock);
> +	if (new->vram_pages) {
> +		new->svm_bo = svm_range_bo_ref(old->svm_bo);
> +		new->ttm_res = old->ttm_res;
>   
> +		spin_lock(&new->svm_bo->list_lock);
> +		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
> +		spin_unlock(&new->svm_bo->list_lock);
> +	}
>   	return 0;
>   }
>   
> @@ -1058,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> -	new->actual_loc = old->actual_loc;
>   	new->granularity = old->granularity;
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 026863a0abcd..c6df930366ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -185,6 +185,7 @@ void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t *dma_addr,
>   void svm_range_dma_unmap(struct svm_range *prange);
>   int svm_range_get_info(struct kfd_process *p, uint32_t *num_svm_ranges,
>   		       uint64_t *svm_priv_data_size);
> +dma_addr_t *svm_get_dma_addr_for_page_count(struct svm_range *prange, u64 addr);
>   int kfd_criu_checkpoint_svm(struct kfd_process *p,
>   			    uint8_t __user *user_priv_data,
>   			    uint64_t *priv_offset);
