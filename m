Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E865CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 17:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A7B10E308;
	Tue, 17 Oct 2023 17:58:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679610E307
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 17:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOd65oD/Iqy8xqPLJUzbfKeIWe4LrwxZP3qQOH6vig9278zGGQ9vrFXoaKwY1TbUppqNl6fU4pp+2ZSTQhfgrqnqIiD1/zzya0M+fDq++lM5yruKFNzevL4uqHnXIUHeQto3SUChLXOcM254+l4imsm9D41UWejI+zXmjOo/wFGmDEbk8CqupAvV65UBNNLjMKd0VA9VTuZ2bam2abCQJrkKSGnBzITo0lub7GA6zNa8sm1SYYReoaVK1+vgE+xMcBYzlGpE9LJgs/mGrDgAzFnljALQXx7BonSlmBNlDZFjrw6JDZ9VXR9femgu/SLsq0ZIoR9ZZd/6duO3O97xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96s0OlVIMjaAu3r6RkuK5jf58l5/5zSxE4vK9MH+21Q=;
 b=jflbXfbMK7a+MblJsc/NpggIPt1xy6yzHoWH3Hr/qI2PCbkKKHbDA8muLoopNV7c+IvwtO1jE+hvXIX3uSOFXeBMTSQ+71Pll11JHKsuiNLtgGk1jQ/zCfBGIdzND2MQNs6Magy79gKwYx2uvzNhzWE8PUVzv7Ofe1Z+AKmaYTUoYU/r2O759FWUTS/vu0V4XRC2uEg0zUj2xvQqpc4aZVXVPEMJlTu22M6K/mj1GGM9alGOwuvp8kRFIqDNEH7CEQ3g6r4Bg4uolN9HRLyPqlEUzEHSPum/dyhmPtvbo3j2PISMeXq4FvHQVU18H6KsTEiFT0tj5RQLm8RLSPjrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96s0OlVIMjaAu3r6RkuK5jf58l5/5zSxE4vK9MH+21Q=;
 b=vbphUjaVTzBfMAy/Uxp6PAQbQZ+kNr1BAmkrBkg8swdg++mo+itF5VJWsZS5kDQ1X8RUQdeQg/DAOykYQrQYTNeIbpnNjhi4i8wFd+ljL+ZrVk0Zrs96RnelhOX+oOzw5qnR1MoPaFQ3uGBB1hGljWL0WA4xYW0QR9evUshf6z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 17:58:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:58:22 +0000
Message-ID: <0f8269a7-aacc-4535-a26c-48783653365f@amd.com>
Date: Tue, 17 Oct 2023 13:58:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231010144024.3016-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cec7bd-fe97-49e5-0ffe-08dbcf3aa77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgQ1vK1hYT+2s8QTaFQ2CVIR+dtZgfxbIKSBGqmWS0Gozi3rR3E5/rYZdsq2PvoJvoNPVc9s3pSGpmAPx2tvROPm/8wkcpYlYoRYQiOPH5G3aXXrGtt0PJ5Q+6FhdISx63DzUY0CyDMQ5hKRMsCqZmyZraEu7d6dw1m5voWpWDdAKxN/1EwJhmNXelHhPS1ynWWjNTDfQJT5XYrlGWHfgUdYdJCkiWNkCI1tPQGMBhpr90NXvIa30094QVjzwUMyt9vN70uSlO8g80X0tiM1xyCS3IlqUa7wPiF9/aBlPO7dvQsclEcNUih4lJJfCkCoDUAXmffJMlnu0Sj4rem+cDOp6no/Fl7UAuPQKrXbR2qnAuLwtqaNl0JGya8ZuNe0IWWp6/72fn2GeD2FW6LeY/QH4EU3ZqAaNP755dQx6avfjF6El30BqtedoPCE5nhdIHQiZQ5XrqfEhGnuNNovjXRC6gNl1aWmQ6kU8cGJss+HamoJQ0Bbrlq/PxaGnZ0lAsPdt6rXsutsutSkOJA3cK2V21hM/idmBxleYF6WYUnAa9zutBZM0jel3v8oqfLhwGXvCgNPpshGTpL09VfkBCdoGUWlTlk9dKxYQAxcytARZxDVD0Fx2l+JrF5aS4vvm1F+9z1cNCmthrNeeo6Rrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(316002)(31686004)(478600001)(66476007)(6486002)(66946007)(66556008)(83380400001)(31696002)(38100700002)(86362001)(41300700001)(6512007)(2616005)(26005)(36916002)(6506007)(53546011)(36756003)(4001150100001)(44832011)(8936002)(2906002)(5660300002)(15650500001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVkzaTlUOFJ5eEZFYnRhbDYrbUpvY1g3anZqekNrOU9vMGc1aVhJb1QvRFJm?=
 =?utf-8?B?TmZha2lOUGxNTWJydUtpVTZUKy95TEppdlZubVdWdS9Kd0RiZno2QjJvcVJl?=
 =?utf-8?B?OURDQjNMTzVzaEZacDg1bzVyRlZRVUlhM1NuajQzRjl2ZUtCd2xoV1ZUSUVq?=
 =?utf-8?B?c1R4eDRUQml5eXlDei9YRHp4RFRUbnJJcGovZDdQTjF6Slg4Z3h3SHQ5ME5K?=
 =?utf-8?B?Q0ZiUG44bmt0SVpNZ3hKdDdkSndJK21jTVlCbHRoaW5YRlUxSXRBRTJaM2lK?=
 =?utf-8?B?Nm5nVVFyUEVlSGNQSUVZVzJJR1FJcEZlUFVxRVRvWWdYVHllNFl2VVphaE9j?=
 =?utf-8?B?NmRYY2ptSElTSHlkbGlVc3B0NGtWZk5Edkg2MkVFaVpwMG50WWZHUUk4bWpv?=
 =?utf-8?B?RGltcXhScFRUVUtNbjNMMmJ3a0MrMVlBRVpqd3IwN2dSL3Q3L3haeENZdE4x?=
 =?utf-8?B?dXAwYTVwdlVtY0lNazNaREc2ZlhuMGVsNG9UZjJTa2NKZE53V1ZVck16L2dB?=
 =?utf-8?B?TnE5cC8wMmFLanc3ZzVpMGJNS09vMDJoNkt1VWFNWU5RU3Fjc0VHN2t1Nm9p?=
 =?utf-8?B?YklYV1J6SmZmcXcrd1UrMmgyeW05WUhCWURWa1Zad0ZnajdtTVMzV0NnZWcr?=
 =?utf-8?B?ZzJtWFJxWVkycE1lQjIwaUo2ZkpTTDB1L1ZGSWJTUWN3c2JuNHRCMk9qU2Rw?=
 =?utf-8?B?WW5XQUN0NUFIbk4wMnRpMVN0NFRYY2I5VkZobVd0by9OeXpjWFAySS9SSzE3?=
 =?utf-8?B?bmp1cDNNZWgwYXlIRW9GTy9nWFdkUTR2UC9hUFB3VU5OOVljbzlrMDRESHp0?=
 =?utf-8?B?L3B6RXJoNXp6Vyt2RXNpRkpaeG10M041elJuOG5pQlVEZXdITkkxV0V4Nm02?=
 =?utf-8?B?SEJCdW9IUUFCREh1LytRd0RCZ0FOUDJBZ05CcGxRY3dEWm1mY2JTd2l0YU9u?=
 =?utf-8?B?VGZHVGVncUNNRFJ1Qi9MaGN5UHRHeHZZZksrMzBjLzZrdEE2eWNTdkhyQjhC?=
 =?utf-8?B?Q0ovamo5a0pYRUNKQmpiSGN3VXA2cWhmR3hDT21FVzM3OFlYL1k1ODgydll5?=
 =?utf-8?B?N0dad21lSHFKM2h6eHZZaUtXeGRZcE5kMHVSa2c1RVozK0hWMStMd0VqeGxL?=
 =?utf-8?B?aGtLZlRRdHp4WTV1NjJTZ1dEZU9lNDBSNlVxdFpQanVFZGgzWlU0QmQwUlVN?=
 =?utf-8?B?ejlYRVdibTFkUDYyNlVpR25yMlNEdVIvTGxvNm9GSXNYd1lIQ0p0UXJBT2ha?=
 =?utf-8?B?UVlhNlJWVjVYRm1Tc1ZlNk5wcTV1KzNMeDg4emU5eUZ0UCtiQnorcUNkWWdw?=
 =?utf-8?B?Z0VScGx6cDRqMEd2d2ZrK2hNclBGQmNvdXZrNjZpa1lCczJadFNXcWkwdURl?=
 =?utf-8?B?U3RsVDRpWUxBNjdSdFVKMUsxa0w1NWZOemU1WDhxUzFwbUVPVkYzYm4rRzJ4?=
 =?utf-8?B?a1ZyL2o0M095eEs5WExkaU9BRzFVN01xc3VsTUJEQ3NMZUNkbFVmUVAwVU1K?=
 =?utf-8?B?Und6WUQ5QzI5Y3BNWi9sTWFjTytUa0NDQk55TWVUc0R4aXpOa2dnU1ZmTTlY?=
 =?utf-8?B?R2IwdTZiN2EraDRtZDFSTXRWdVZvVHoxcmdndGlTWmljL243MG9lNjZtQjk4?=
 =?utf-8?B?bFZOcEJ2bFgwSytxVFNvaEY0aWRQY29STlA0aVFzd3RIWVZlaVorMXgvZVpQ?=
 =?utf-8?B?cTRiUGV2MUdzRHQrOGVubHZKbys5NXV4YlluS3NJVjFHOFFiUVJJY0xKOTln?=
 =?utf-8?B?WFJzQmNDa01DMDkyRitXYUZGS3B3Rm9mdTZVUjZiUVlLUi93ZE1XMjUxSSt2?=
 =?utf-8?B?eVNmZm9yK1JsRWFleWYvUElnS1V0dDVJbWlDK1hPY1VGUkx2UStVTmF5OEc4?=
 =?utf-8?B?VkVidHhkMWJPU2p2czFQNGY1a21lajRHVjE4T3Q1QWt4bE5EUE1kUGZwNVgy?=
 =?utf-8?B?QjltaHZLcVhuNjdON2VWUlZiZG45b1hSMnhEaUMwZ1BkR2FJYXdZclR4TDl5?=
 =?utf-8?B?NkZYZlBHZU1DYm5lNGFZNEdHRXZ1OTB3RFpkeTlQWFZwb2hHbURBOW1KcVQ2?=
 =?utf-8?B?cktubm5sYkdCNjlHRVA0UE5tZHV1RzVPQVVrVXcxQ1ZPaDBhUEdkbXF5QjZp?=
 =?utf-8?Q?INNmAA4/LtXNp6nK0m6f6USX1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cec7bd-fe97-49e5-0ffe-08dbcf3aa77d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:58:22.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBAwAwDB0tJhH9L978qO6Al58yGLpqPYS8KWY2HbicLGsJnPuetF3SpVX35JWhaRZjOQkFiMIRL1JnSr4DFlkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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

On 2023-10-10 10:40, Philip Yang wrote:
> If using sdma update GPU page table, kfd flush tlb does nothing if vm
> update fence callback doesn't update vm->tlb_seq. This works now because
> retry fault keep coming and will be handled to update page table again
> after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout and flush tlb.
>
> With the following patch to add bitmap_mapped flag, the retry fault
> recover will only update GPU page table once, need wait vm udate fence
> and then flush tlb.
>
> No change if using CPU update GPU page table because no vm update fence.
>
> Remove wait parameter in svm_range_validate_and_map because it is
> always called with true now.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2b4ccc0531e8..e195106a77cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1454,7 +1454,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   static int
>   svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   		      unsigned long npages, bool readonly,
> -		      unsigned long *bitmap, bool wait, bool flush_tlb)
> +		      unsigned long *bitmap, bool flush_tlb)
>   {
>   	struct kfd_process_device *pdd;
>   	struct amdgpu_device *bo_adev = NULL;
> @@ -1487,8 +1487,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>   					 prange->dma_addr[gpuidx],
> -					 bo_adev, wait ? &fence : NULL,
> -					 flush_tlb);
> +					 bo_adev, &fence, flush_tlb);
>   		if (r)
>   			break;
>   
> @@ -1612,7 +1611,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
>    */
>   static int svm_range_validate_and_map(struct mm_struct *mm,
>   				      struct svm_range *prange, int32_t gpuidx,
> -				      bool intr, bool wait, bool flush_tlb)
> +				      bool intr, bool flush_tlb)
>   {
>   	struct svm_validate_context *ctx;
>   	unsigned long start, end, addr;
> @@ -1741,7 +1740,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   		if (!r)
>   			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -						  ctx->bitmap, wait, flush_tlb);
> +						  ctx->bitmap, flush_tlb);
>   
>   		if (!r && next == end)
>   			prange->mapped_to_gpu = true;
> @@ -1848,7 +1847,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       false, true, false);
> +					       false, false);
>   		if (r)
>   			pr_debug("failed %d to map 0x%lx to gpus\n", r,
>   				 prange->start);
> @@ -3094,7 +3093,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> -	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
> +	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
>   	if (r)
>   		pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
>   			 r, svms, prange->start, prange->last);
> @@ -3643,7 +3642,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>   
>   		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
> -					       true, true, flush_tlb);
> +					       true, flush_tlb);
>   		if (r)
>   			pr_debug("failed %d to map svm range\n", r);
>   
