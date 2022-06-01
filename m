Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341ABC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 06:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94D0113294;
	Wed,  1 Jun 2022 06:04:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D035C113294
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 06:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbZJZuJNqPoI1H9hotdUbQ6t2T0hDunSaf/NigsCvro3tCwzRCqcmgRzWsn9+dgrWlUh2VI59uyDkHY5fT1fnI0gjs3kmUbneufk4O7qpKGsaXIXyu1QozsMynt0Z2PHWDGsVakT5p8rFWxctcCXsKcPnFmsqZmZhU+p3I2jp//+4DmCwjDawZKiDEP8zAUy9LP57JkKcaTP5FwSNVNSlz5VPLStuqi2DUeYeQ/NH/zHB1WT72ni/wEWH1Ue9rbxRARCWJsUtcnd80c+aJ06Li9XBTpOoYbf3Vj0F4d2bvSNDk/p4o7J3AvzTgBXwwutQ4cPdbCi1cZQqQpTT0ZCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hzkwTrrohjuCI208x5m/AyipZ5Vk0FvFsSTV7AzK7U=;
 b=OHsLe8bWhSv5Y8JV7TsP46TdP7HiRDX9xKG25I10RQtWzuF2f9YoI/0IWT4m1zcJcCsaaLdCoVHTpS8mozqAzVvrRH3h588vzkApWXu5hQgiwSBY5877IRrBb2AygOjI9trO5OsIFCROKi7P8sxz0XE36HsQY09UNXnaHGb/C0Wbpx+mGi7tjQkzKPIK5QKDuC5xZwQzfr8EdbE2l1mNiSNgoBGtSOMIXQriL8f7vJo3Pz7JG5pvkVXg1lDtwqTDL4YIXVgVqx+l8teO3o1c9OOj33gPIk4ts74Ky/GXz8Nvj4ZRHpS80BIKsFLNXiPknNIHRtuJL5pZXZCwqBpjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hzkwTrrohjuCI208x5m/AyipZ5Vk0FvFsSTV7AzK7U=;
 b=TRjHJRFI52j5kWC4BvQgbqJxG/8xREHluP9XX+7C/T07yyj+D7pUC0PeRA6q6Q0aV5dGXoiIBR1aP4+CdhrTvQb0vE1UMpEA/gDDBnSMOWj9E0UMqcGydr8Eid5MgDtzm15iw/21a+kBpfOxHqW1YrLh8kURcQGe5R9EBSeh1Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:04:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:04:22 +0000
Message-ID: <e2bb1d43-44cb-603a-35be-ab9c56052355@amd.com>
Date: Wed, 1 Jun 2022 02:04:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: add pinned BOs to kfd_bo_list
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220601013948.1689628-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220601013948.1689628-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b965e51f-12a8-4bb0-81ee-08da4394924c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40936344390FDC21F5C39F8092DF9@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRHdShwIsxLb6ZPAUOD4LqZS70FQecFNEsW0CVVrFXL4v9aUw3Y6VSsrq2TS/KXzQDZVMLbMbPuWJ8axhZaAcK7bOyQZlupyKYQIz2pSF8HWC8XiI9t/E/wIVZKSyDfaogHRudl00WIP0fMogqMVfZy2t0Fm3NvpSC7C5rIp1Alyvl66q20Pgc7jEL/ybHfdI7xw8S9UDWinbMAO2FcdQ1FlrDscfe8EsVxbJ5QpoM69taLNEdYL7nYwmA8kg6cJRyfGihjnw/O8yTEhfpBS640MCQ8pEXkW4tHnkWAJYWFd2awx4Qz2yakPX55kNXb0CpJDhHrD4ckRbtp6dq0cdIZ44VUNPinfBMHK0hT3eYmRhhhiDXZXtqrGWrYJvPfoZNpGA8TDI4c/LENakHI341rqmNJEF6jJpa1D9e9MJJo2BLReZAhHXqKOO5at5Dy9UUUoM3ax5HVEO3VwBAARHr+fTPHX7W0ylv1dFcT2vVQiRVLJCeIUFl4QoWsGviOtDOuk/UMBx+tJ+0HPTLYc38ANViGCj0QQ8U/ysUiFnsZh8g2RfwHGInmX5fu+Be++Ywb6ej61BaXQqY6K2eUfo0jBqb2XjSxct00B1GwnZMHVELvN+dTB+dfujCc+vpMsvBiU6ntySsWTWwQeLObHPrRFvdPftlmqMZlS4kLA+FedlbkooTsumHCXhQ13cv3Jm+ToXLa/uBQa/PDNuraAHENRFVXH3XDrMQeEXKGckd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(31686004)(2906002)(8936002)(44832011)(54906003)(26005)(6506007)(6512007)(2616005)(508600001)(38100700002)(6486002)(6666004)(4326008)(66476007)(8676002)(66946007)(66556008)(83380400001)(186003)(86362001)(31696002)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnlmenFsV0dsZjg2dmhkUGJham9Bd1ZPeFVQV29yV2N1ZWppZjdDUElxaGRj?=
 =?utf-8?B?eGVZZkQrQiszakRBVy8wbGQzZ3c1cUVaKzQ0L0NmSDZtcnhyVjNiYUk4ZnUw?=
 =?utf-8?B?eisvelk2MXNIckxJV21CR3hibXMzOVgxSjgrWDdGc1pockRDMGV4WEU4T3pK?=
 =?utf-8?B?ZTUxUit3eTN1VmlIcW8xN25JeS9mbXV6WmJzOFB5cnpzdHczczVDOERsTE9R?=
 =?utf-8?B?QXRIUzM0bXNxa0k2VVFqUnc3eFhOUVdHRUJmNTNPRWxydjNGeVoycVlGZlU1?=
 =?utf-8?B?Y2VMemd1L245RUJtQUVMeGFmc3AzdEVGWVpPck9nRC82T0RLcEFBWWZNUjVm?=
 =?utf-8?B?S3ZnMmRNVXlIWEJDemdlWWlocnFMSG41K1lYRmxDZWFrUWtzaVVjQmRvTnY5?=
 =?utf-8?B?alBXSnlkSVhpb3Jid09PQkpwMjdSTzZEeUIxRTZaUEdrUC9yTDdaOVZnTFZ0?=
 =?utf-8?B?djJzMXVtZDRXQUk2SHFnZk5oL3hWWUFQamdURFlnZXorMHRqQ1lVTG83ejNZ?=
 =?utf-8?B?NjdCYTFxU2Z5Wm56NVA5b3JLK1NaUVN3elc3c0lkZnd0U0JjbElkeUd5OTR6?=
 =?utf-8?B?VnRiZXliSGFvMGxCUVZWTWM3R0RscTZYaDB2RmlPYVJkSHA0akxZeUI3b3h0?=
 =?utf-8?B?NlIvaHB2Yk9zRmdzMklNeG4wMzMxNHJMTUszZHlpZ041R1NGR1p2NTIveHRU?=
 =?utf-8?B?Q2s0bHhKcHFVU2hCNXJPTlV6WFZ2T3lXRGUyQVFJU0FINXgxWDJ4amU2NE5r?=
 =?utf-8?B?aEUwR3NiTUtmUjJsNElLQzRNbVdwSjlxQ25IWTNXSS9VdFZUSWRINUQvaVRX?=
 =?utf-8?B?RGNXd2ZvdHFQUTNDKzQ4RE15Ykl0QWkzNUtwL2laczdoV2p4NWZaempJVFRN?=
 =?utf-8?B?dDgxTS8zdG5PVHpnOGpQRk1ObGtNYjBZd1pFNWpwMnFnQktNTEFvQ01HRlVX?=
 =?utf-8?B?aVdHQUMxNEh4YndMdlpUK0ttOThtQjM3R21mNUMycWhLWnRZdHpEeGtWUGZQ?=
 =?utf-8?B?czBpVGZJNUlJaEhjUFNGV1h5aU9Ec3VscDUrbzBoL3FKR0NEdmFTeWs3Vlla?=
 =?utf-8?B?R0RORHdrcCtBcHlsWG5acS84ckx0cGowNVVTbC9sejRsY0xGR0hNTklYRXRF?=
 =?utf-8?B?UER1T01sUU1Jc2FBaWxyU25zR2xSaFhzVXE3ZEJIckhqRW1NS3pkZm9iVnIx?=
 =?utf-8?B?eEdzbmcvYWpaZ1dXd1M5U0xJWmJpU1kwNm5wV00rRVJGUXhUUTRock9iTEQ1?=
 =?utf-8?B?YU0xeS9LNldad1ExK0dhcmNxZkROOUQ2NkhXQTU2dWgzak1BZVkvY2lheE9v?=
 =?utf-8?B?aldtOFB5NWtYUVhNa0Y0WFdNN05WbnViMTh6YlJYRlZBdU1NdzNTRXhnSEIw?=
 =?utf-8?B?eUFOZzZPTVdlTEdTNWtFcHM4SzhXUEhRQzdjVTRVRUFDY1BNY3l5KzVmQzhI?=
 =?utf-8?B?UjNNTnA3dHdsbllKdm5pUFJxZlhQUHV2Y0pnSE0vcHpkRkQwVTlUZFJ2azZh?=
 =?utf-8?B?VW1lOGYzOFZ3bWozVW9LQ2VzZ3ZyNXJGQVVxMnhnZjRVYVd5NVdVeEpVbVJn?=
 =?utf-8?B?bW1BTVRsT0tsTWtSbGwzWFhzcUN2RHNjKzIyUlBuQm51Z25CcUh4U2dseU9G?=
 =?utf-8?B?ZEdocFRBVDRmeW5IenZwVFF3aVNFL2Nic1huS214Q0M4QXJWZERuQjZKSU9k?=
 =?utf-8?B?eXdHL2x0eVFLS1pkQWJKWVBrdHQvUjMyUWEwV2cvRjIxVUhxUElIM0EvcFM5?=
 =?utf-8?B?dUt2ZVhpSURHYXB0MFlXaVhJTGlVRk9ublhLWVBjWVdKZFNqWmVhRVVjWm5H?=
 =?utf-8?B?Wk5lWUhIUVJsak4zZm5qSFhjeEsva0FhUGpFMjJVWWdHbk1aVFVzMStqbzVx?=
 =?utf-8?B?K3B0dnpSMlhsUGN3L2lURjlqYWlUckl0LzNMS1V0aWR5NHppV0FJVjhpalBB?=
 =?utf-8?B?TVJzak9PUWRlZ2JDK3A2REREZk5rbEpteG9teWNxRWRKSFN4Yit0RldrUjB2?=
 =?utf-8?B?V2NnY3BObVhTc2djWUMvdldkUkp5RXdtQnRlZGE0TktWNE1GZlVveW1KNXRM?=
 =?utf-8?B?TUgzKzFYdnBLR0p6OWY2RHJJaDZKMG9jOUM1dTJOT3hoK2tUcFdCaWZ3elRo?=
 =?utf-8?B?VkVGSDNWMzBERTcxRzVieWtET1VtbElZUVFoZHRUZmRDRWwzMXJQUHZYSU5P?=
 =?utf-8?B?elhMTFdlZk1RQ1JDZjVTd3JNaTBZaUJOV1JpK2NGbXYvQVBaMmkrODNKNWQw?=
 =?utf-8?B?b09wejN6dFFRWVZyNkhrUE1iSGx2Vm9Da3pacWlUc2gwY2ZPdnk0RWQ0TWJ4?=
 =?utf-8?B?STIrOCszbDdvUHNxeFVCUzJmUHhsVGJ2L3poeE4xSXFuQ2haZHN0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b965e51f-12a8-4bb0-81ee-08da4394924c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:04:22.0991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnqoZiZlLXlT+MLENI+LodKLSkiHY60kiaNrbfF1eOCEJLwcVqIa7SXo0CMpu1PkFHvTmofuYFCjUiMLmwra/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-05-31 um 21:39 schrieb Lang Yu:
> The kfd_bo_list is used to restore process BOs after
> evictions. As page tables could be destroyed during
> evictions, we should also update pinned BOs' page tables
> during restoring to make sure they are valid.
>
> So for pinned BOs,
> 1, Validating them and update their page tables.
> 2, Don't add eviction fence for them.
>
> v2:
>   - Don't handle pinned ones specially in BO validation.(Felix)
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 34ba9e776521..054e4a76ae2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1953,9 +1953,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   		return -EINVAL;
>   	}
>   
> -	/* delete kgd_mem from kfd_bo_list to avoid re-validating
> -	 * this BO in BO's restoring after eviction.
> -	 */
>   	mutex_lock(&mem->process_info->lock);
>   
>   	ret = amdgpu_bo_reserve(bo, true);
> @@ -1978,7 +1975,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
>   
>   	amdgpu_amdkfd_remove_eviction_fence(
>   		bo, mem->process_info->eviction_fence);
> -	list_del_init(&mem->validate_list.head);
>   
>   	if (size)
>   		*size = amdgpu_bo_size(bo);
> @@ -2542,12 +2538,15 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   	process_info->eviction_fence = new_fence;
>   	*ef = dma_fence_get(&new_fence->base);
>   
> -	/* Attach new eviction fence to all BOs */
> +	/* Attach new eviction fence to all BOs except pinned ones */
>   	list_for_each_entry(mem, &process_info->kfd_bo_list,
> -		validate_list.head)
> +		validate_list.head) {
> +		if (mem->bo->tbo.pin_count)
> +			continue;
> +
>   		amdgpu_bo_fence(mem->bo,
>   			&process_info->eviction_fence->base, true);
> -
> +	}
>   	/* Attach eviction fence to PD / PT BOs */
>   	list_for_each_entry(peer_vm, &process_info->vm_list_head,
>   			    vm_list_node) {
