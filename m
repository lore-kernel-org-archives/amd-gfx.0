Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18463CE79A8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 21:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B040410E15D;
	Tue, 19 Sep 2023 21:15:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78B110E19C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 21:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evxDb4eOtO4rpdl04c9uwBSHvcE8+L4xQihi5JK9vscbQPOH72Dp2dslaFX+vEI7P+hKncXXbFxUXmMccjP/771PSXdiqxttRoxYLOrJTErYmlKecEY27tBvqo704nJvOapTgMGfF8CrnfPGoIcwcxJWMs8vVNI/dzn0woqco6Kc5Kuc69n6DOzAp2I1QDofw24mptftxiRNd9QwR4wsPt5nH2lw8cSLdixT8CYZQ71eQEQSiSZVo8T7oiIZhKOfVJDZVJ7KhizLT6gzJPqLqaYHD1HlZwOEla0D2U/L/27AXv+w7DyKgxc1l2rEsLnjBd75LRziAtxCo/WDIQm/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwotOYSrqmdr2fWmR1v8Rt2l4zgbmwgd9uWliH24alw=;
 b=Iv8fNMgqOoYj/HvUl9sQtpG2ZYEwUHgrVIcoxpN49QEYiAvpgzp7BNahEF0h83h0l8N8LzoFuyAMD1M/K+/uH/m7twvjCfUEeGHpMKRjFukaz+zZkv4jC2zcas+P54URRFySBqhkTT2d5CWKbB7MgOCHRG/A8nsdvVTuq2H+WPzoOA9Keie6c5DvdIv/XvqV33DFCAcyrPNmX/KlHLyQAnWI8awWeAyL70CyakaDB1u8JKJEZDZr55TWSfmFP9Y5ZzcPedJMPEULQGLnJmU1PNLI5hVRW0eP5DFfKehgaLH69w58JxCeNzoA9bEgD3AsxHHAPOfpjPTw/3SEyeuW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwotOYSrqmdr2fWmR1v8Rt2l4zgbmwgd9uWliH24alw=;
 b=Ajg0lx3I+xdw1IHHQs6HCN9TGdtk+v9v2h7+5ZCHGJzqQw9NxPDJOHFSc60f631PZ5+yFHO/KAu/48iauMVXCjfLsADSqttHvi0LyD/XFIArO9E6wWC4IFPsexpfzh3ey13hXl4q35rdAbA/1mMXZyMtf6gDMBRYO0Hnwd6zGzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 21:15:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 21:15:39 +0000
Message-ID: <cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com>
Date: Tue, 19 Sep 2023 17:15:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] drm/amdkfd: Handle errors from svm validate and map
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230919142124.15092-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230919142124.15092-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0419.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: d85c2ecb-6bf3-47a4-65b2-08dbb95592e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyHkZ74qqewocHMQWSrzB6be/IvLxc6Zzf45Wdq2TAe6a1dy41Me4EFxoi+5Pdo301Jt8NVShOq+kX9z/8ARiqW6UkMzkDgLSN3wU9xjna2DyjzAS8eYPM8x1soxrFMGXwvrbiglHdiplfDkz4m+xQl8e+yyHKuJbtIdIQkois7wjzQR+Xyk88EoRwgJoTHdvw7lF7PVLNkqsnRVHwTqfSo8V9acHKmMSyW/6hf1tyDAGoVOBNhjdOC9lQQp0IpJ8jBdRyO1luiH3zZDtNGxNdifxtmI6WgMKOmVN4C31LK+On5fx7k2S2o8VmXOQQ7/nbbJ2GsoAhcrbc6A9Xb3yS/hI63HCk8PbECrwuo6d7LaQE90nZcHF9hV2l2BK77x4tWeBDjnQm3eefqbFdxwbDh6HFHyxRzI2/12uBhcQ2kMXSuGZMx4FdFEZyZgFhJQhfc45FR/+FzAwNyvehXuHpcxcw7Z6TOVPhXnxg7mGl+9heaFRpM6eJsXSaW5bL4G3F1XGRUod5SNGY4fE7+276tWPPMqgfn82XbWm8GWBPJmpo3KUMM/O1RsUsfZSkvA+rBnHk7/vSs5WIjUfe25wNCuZ0SK/JGUjYWlgYaKgrnOSXs1hwmWMD4y5FcD4Vnp5rfp33ZoIo5b/sfZthsrVfvxql8jKsYiihLMZilViYI4VtszG8Jkbx6Zm2IREe+F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(186009)(451199024)(1800799009)(41300700001)(8676002)(8936002)(2616005)(4326008)(31686004)(38100700002)(66946007)(66556008)(66476007)(316002)(6512007)(83380400001)(478600001)(44832011)(5660300002)(26005)(53546011)(6486002)(6506007)(36916002)(15650500001)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGxzKytYdEJ2MlJQYXNyUVh0aVRtZGpPK2xjb0Rac3RoUi8zdW10M2tYcGht?=
 =?utf-8?B?TU5RVkZIV1lzSjdBeUxJM1NMdCtWK2ZORWpMeHJuUTdORUdXdDNuUFhnU3Nv?=
 =?utf-8?B?ZU90aUxFY2NwSU9GQTk3dlRaVUhSbWRIc2JrUHRXVG9OTklwT3NUUHVWRnUy?=
 =?utf-8?B?aDk4ZnhwL2xhdGNsZk16VEYrUURXV05zQkxJN0ZveHJyODBTdFkvZ0JmWTM4?=
 =?utf-8?B?NVdxbWliYVhsSTdUMW1yaXZZRmh4aXJXODZpcGtWaDFWSmtQQW5MZVhjZFhq?=
 =?utf-8?B?ZGRHZ1QxVitQNHE5MUR3OHljd3YvbHIwWG94WVBKZDlFd1RKL1FTc2ZtRSt0?=
 =?utf-8?B?WE4xallGVHhUaG5RaUhSZDdBR05pdEU0Ym1VcnN0N0k2MTFTU0M0dkRLMmNM?=
 =?utf-8?B?M1BxMU01Tml6blVoZ1psMWhQUkRrWGI4QkdqYXpiUFFtZUhOeU04TUxCYy85?=
 =?utf-8?B?bGgvcG0yeWYrUjZUN25hZFBkTk4xaHA4U2dVeFNVRCtwaEE4UzJxZUdKa0V5?=
 =?utf-8?B?a2U3SFQ4TWFTaVhyVDdqODVkSStnallXeGZSNlBDZ0w0OTMyOU13WDcvVUwr?=
 =?utf-8?B?R1ZkYVZUN2dTNXo4bDlCRUJnaHNuRGRhc09BdzVhanBtblJiM1lhWUh2WFV2?=
 =?utf-8?B?TXlRMEpKSEt1MVp2eE1hZWYvZ3lvVVNZTGhUR2JxamFxbUxEakNWL0ZVTTIx?=
 =?utf-8?B?OFlTZ1ljV280cmV4U3hhT042YlNIZlFiR2J6czNLRG0zVkJEZ2VKQnJSbEhm?=
 =?utf-8?B?TGROZkpFMzN0Y3NraTNjck1UOWlBR2Q3Tlg1ZmtQN0V0Wnd3Wk1uVmhkTjhE?=
 =?utf-8?B?dlZYSkFpdmFRZzdSY09nbUdlYndOVEpaTmR2YUpObDBsVFkyL0lkUGpMaHN3?=
 =?utf-8?B?NnhiUldxL2RDVUR3ZkpNRVQ5ZXZmU3ZOVTdhUFM5aUpLQzd4d1VzbjhRNTlI?=
 =?utf-8?B?UGZtSmZ5dzFKUVhhVVg4RCtGMk9QTi82YmpYMEVJN3NLQjhseDdLOTRBY3BZ?=
 =?utf-8?B?TGxMMDMyYm5wc3hmSWNML0hCc3Bxa2RKclIzemg0b3pndFJVbnVPYlU4aXR1?=
 =?utf-8?B?NERUN3NQR0VVeTZWN0lVWkRiNWZCdWRPRnp0MG5RVTdoTk9KOFRlaWtVM29I?=
 =?utf-8?B?dmFpMVVlc0c2ZHBXWnpjNndoT3VyUCtPdmNGaFVZRm9QWS96L3hveGIvVzdr?=
 =?utf-8?B?WTdlOGhIVnJlMUhMci9zWHMyaEdXZFlMbWlGVFMzeTZZTFp2UktlYTR4dFhT?=
 =?utf-8?B?YklvMUlBVENycERBZkhqdHVBMERuUU5KbUFMbkxkeTlYSlF5QVpTeXptai91?=
 =?utf-8?B?WkN3WUdKY25TSVNYWWh4aVFNVVpEK2c2MXlCd2NSNURYWElKZXJqVGYrLzBX?=
 =?utf-8?B?ODFpMWU3VDlFQlhlMnp0ams5SWRCT1N5c3V2S1Vqd1JBWE13TU1wSGNqNGdT?=
 =?utf-8?B?eEplSkdYdHdHRHF4KzJKbnFQRWxTQjZKaGhQdk1wdzBXbEFDSVlOY3Z3SGw5?=
 =?utf-8?B?K0JQSHp4YmFaMklPSnZySElwTG9wWUx5TjdkT3N2dHNCVGFFRURTY2lvS0RG?=
 =?utf-8?B?RVZzOWxCWlR4M2txYS9mcm4xRHdzSU90ZmsrdG5PMCtnZFJoeTFxRkoyNHJx?=
 =?utf-8?B?cEltTzZxaXhDQnh6TVRERVlXc09ZVmVSelpWY2JDOUxCV0JZTzB5TWtZOFZI?=
 =?utf-8?B?MngrTmtVMUptZ1ZhdUdURVhsaFhTbFVoWWhaNWF1TkFoSEhST2ovcTRiUTNZ?=
 =?utf-8?B?NjNCV2ZJUmNydG1IZnlMdFVnRGt3eTBMRjRaR0xmb1lzWE8yUkM2cWliUGUz?=
 =?utf-8?B?K2oyL3NMQXhCN0s1UUxlcGQzR1J5MEM2Q0picnl1UnQrd0N4TWY5K3dRVkVD?=
 =?utf-8?B?ZzBXaURBQ3VERXpOcEErOWZqUVNJSXl5RklTQldEZTVXZGM4QlJkTWg1N25D?=
 =?utf-8?B?endJWnlWRU1ReGdJbzkwaUV6djJkbDQvdGxDNmFMb2FTdWxYRHpZcTJuWXhV?=
 =?utf-8?B?N0R5NGdXczc1cm1oNEhKNnA5aGIzVVZIL1BUdm44VXNYWlhRb0R3M3BWSzZ0?=
 =?utf-8?B?OGRxcEJxUVZocUdGRXBISFV2RkE0RWtUMlFlZzF2YUMxa0xQMHEzbEV5dDhJ?=
 =?utf-8?Q?Ot59OPL5SABQ6sBAKkIHZv9hX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c2ecb-6bf3-47a4-65b2-08dbb95592e4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 21:15:39.4199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzFZSNlg/zpjEO9NaLs1DXt4D1RO1KwuNSkaOTOgvLwD17bBcopaFIyAMmTBsarW4209k7Vey3c/bfBYLIS5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-19 10:21, Philip Yang wrote:
> If new range is splited to multiple pranges with max_svm_range_pages
> alignment and added to update_list, svm validate and map should keep
> going after error to make sure prange->mapped_to_gpu flag is up to date
> for the whole range.
>
> svm validate and map update set prange->mapped_to_gpu after mapping to
> GPUs successfully, otherwise clear prange->mapped_to_gpu flag (for
> update mapping case) instead of setting error flag, we can remove
> the redundant error flag to simpliy code.
>
> Refactor to remove goto and update prange->mapped_to_gpu flag inside
> svm_range_lock, to guarant we always evict queues or unmap from GPUs if
> there are invalid ranges.
>
> After svm validate and map return error -EAGIN, the caller retry will
> update the mapping for the whole range again.
>
> Fixes: c22b04407097 ("drm/amdkfd: flag added to handle errors from svm validate and map")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 78 +++++++++++++---------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 36 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 50c29fd844fb..4812f4ac5579 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
>   		}
>   	}
>   
> -	return !prange->is_error_flag;
> +	return true;
>   }
>   
>   /**
> @@ -1671,7 +1671,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> -	for (addr = start; addr < end && !r; ) {
> +	for (addr = start; !r && addr < end; ) {
>   		struct hmm_range *hmm_range;
>   		struct vm_area_struct *vma;
>   		unsigned long next;
> @@ -1680,62 +1680,55 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		bool readonly;
>   
>   		vma = vma_lookup(mm, addr);
> -		if (!vma) {
> +		if (vma) {
> +			readonly = !(vma->vm_flags & VM_WRITE);
> +
> +			next = min(vma->vm_end, end);
> +			npages = (next - addr) >> PAGE_SHIFT;
> +			WRITE_ONCE(p->svms.faulting_task, current);
> +			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +						       readonly, owner, NULL,
> +						       &hmm_range);
> +			WRITE_ONCE(p->svms.faulting_task, NULL);
> +			if (r) {
> +				pr_debug("failed %d to get svm range pages\n", r);
> +				if (r == -EBUSY)
> +					r = -EAGAIN;
> +			}
> +		} else {
>   			r = -EFAULT;
> -			goto unreserve_out;
> -		}
> -		readonly = !(vma->vm_flags & VM_WRITE);
> -
> -		next = min(vma->vm_end, end);
> -		npages = (next - addr) >> PAGE_SHIFT;
> -		WRITE_ONCE(p->svms.faulting_task, current);
> -		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -					       readonly, owner, NULL,
> -					       &hmm_range);
> -		WRITE_ONCE(p->svms.faulting_task, NULL);
> -		if (r) {
> -			pr_debug("failed %d to get svm range pages\n", r);
> -			if (r == -EBUSY)
> -				r = -EAGAIN;
> -			goto unreserve_out;
>   		}
>   
> -		offset = (addr - start) >> PAGE_SHIFT;
> -		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> -				      hmm_range->hmm_pfns);
> -		if (r) {
> -			pr_debug("failed %d to dma map range\n", r);
> -			goto unreserve_out;
> +		if (!r) {
> +			offset = (addr - start) >> PAGE_SHIFT;
> +			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> +					      hmm_range->hmm_pfns);
> +			if (r)
> +				pr_debug("failed %d to dma map range\n", r);
>   		}
>   
>   		svm_range_lock(prange);
> -		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
> +		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
>   			pr_debug("hmm update the range, need validate again\n");
>   			r = -EAGAIN;
> -			goto unlock_out;
>   		}
> -		if (!list_empty(&prange->child_list)) {
> +
> +		if (!r && !list_empty(&prange->child_list)) {
>   			pr_debug("range split by unmap in parallel, validate again\n");
>   			r = -EAGAIN;
> -			goto unlock_out;
>   		}
>   
> -		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -					  ctx->bitmap, wait, flush_tlb);
> +		if (!r)
> +			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> +						  ctx->bitmap, wait, flush_tlb);
>   
> -unlock_out:
> +		prange->mapped_to_gpu = !r;

I'm still concerned that this can update prange->mapped_to_gpu to "true" 
before the entire range has been successfully mapped. This could cause 
race conditions if someone looks at this variable while a 
validate_and_map is in progress. This would avoid such race conditions:

		if (!r && next == end)
			prange->mapped_to_gpu = true;

Regards,
   Felix


>   		svm_range_unlock(prange);
>   
>   		addr = next;
>   	}
>   
> -	if (addr == end)
> -		prange->mapped_to_gpu = true;
> -
> -unreserve_out:
>   	svm_range_unreserve_bos(ctx);
> -
> -	prange->is_error_flag = !!r;
>   	if (!r)
>   		prange->validate_timestamp = ktime_get_boottime();
>   
> @@ -2104,7 +2097,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   		next = interval_tree_iter_next(node, start, last);
>   		next_start = min(node->last, last) + 1;
>   
> -		if (svm_range_is_same_attrs(p, prange, nattr, attrs)) {
> +		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
> +		    prange->mapped_to_gpu) {
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> @@ -3517,7 +3511,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct svm_range *next;
>   	bool update_mapping = false;
>   	bool flush_tlb;
> -	int r = 0;
> +	int r, ret = 0;
>   
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
>   		 p->pasid, &p->svms, start, start + size - 1, size);
> @@ -3605,7 +3599,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   out_unlock_range:
>   		mutex_unlock(&prange->migrate_mutex);
>   		if (r)
> -			break;
> +			ret = r;
>   	}
>   
>   	dynamic_svm_range_dump(svms);
> @@ -3618,7 +3612,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
>   		 &p->svms, start, start + size - 1, r);
>   
> -	return r;
> +	return ret ? ret : r;
>   }
>   
>   static int
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c216c8dd13c6..25f711905738 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -133,7 +133,6 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				mapped_to_gpu;
> -	bool				is_error_flag;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
