Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BECC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AC310E1E9;
	Wed,  5 Aug 2026 08:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LhupPFi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D958110E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEJFtR4jBTtIhD6l8m0yHeCaUAbM1uecgzMCIIRVdPkErkc39nfTZ+RwURwupVBxlNfADuAkla6W9PBIXX2G+Wv5h52GxAV/ckp9tR0ImG1zTDf4DOylNW5Io1rMIxs0yUIpUnXvHfdjj3PmboLSK8o7cFjtbRPeC4Sx++aHGaNObhBMs6sb1VQ6jhkoGtETaOKFoQulRnMjIb0gkyRaceMpa9eSuOItxJT8kVFWeOdmx5MNUEL2tbaHAHjWhlrAU5y0lS1AqDizYS9cpuCSWs9RUjkdAp7tDueiXA8jIUjXr1PLK3WCWqOZgAcOPHYAUmmmF7bkKF1eUbCkSxVFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plABUQFv+W5I3Be4Y2NJftua9fExTJ4TvhiktQXgEy4=;
 b=E+8rJ473FyGllVgfVTLEzZY1LeFCZZx7GdIdOy+Wr0YmoBOrpc0TqLrmqzvX8pDByREHxfiF5Id5vsWTTrJpKuQ4m9qKc4nPmvqcJ+DbJV1t+i5wH5KEH16r2QUE7CU+B+e7itbZEh8fSl1cxuSnAkcjrVXAte1BifQ3USuC1rlINPSdWL34c8NWbemlpBsqDqu3wjZTjRvvPvAuZN5uFeCoA8pMHhytzs7OgxFlJsP2yzvnb6B1M3M1vTU4Cz7Lmm75YIQJSUoCHrFLoTpMQ+lLvGuY/pqmmpTnoiB1eTiwT3/C9+LaEUc1MrPG9BW6aIoLcZ8hG6enJs/Q6odgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plABUQFv+W5I3Be4Y2NJftua9fExTJ4TvhiktQXgEy4=;
 b=0LhupPFiBDAo8qdSvSS4rn+17qHbk9B+zXC5aMpFhEiyF21kBqDyssuORlMyY90+jqHYz1syvaYGmItfSU/Mjd/0cvDZ0uRM88lGkiw4ZyEEW5v5B/FeQY2ME1QL5SMt2FgXLEUC2CUkgl5GrKN7fNOZ8QFhsfmvLL50BeG8GvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 08:40:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:40:19 +0000
Message-ID: <23478c1c-3a1d-4438-aa66-2360c8365482@amd.com>
Date: Wed, 5 Aug 2026 10:40:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation via
 GTT eviction
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com
Cc: Philip.Yang@amd.com, Mario.Limonciello@amd.com,
 Srinivasan.Shanmugam@amd.com, Tiantian.Zhang@amd.com, Victor.Zhao@amd.com
References: <20260729110001.46186-1-shikang.fan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260729110001.46186-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d16bef-8a62-49bf-ead0-08def2cd2e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Nv1nHWPRLmhsoNyUFbgqiUnmouzvWsA6H6wPR+wmYtn1GsgrXwaFtwxfDs3HKm8PtYEL4bgRrbL0jl2eVN04162iEuy7QAQqwWyfpVojkIJTKTf9vxie1fWmFR6v2jiUj79uB1op2w6a3Ftx7KcY1X+TpHck4e+pnKOwKZhkdfn6jFmbPafZUKMm7qj3b9M5W1jEe5LDRpns+P0xHGwJs034V9MBpStdAQFxlAMkpNfJB8+E97qzdqunKP43OEPNKG4sOQS5z+rMMP8mOHGnhcLYoa7GDCK9zHt9i/J6QrN1GpRD4hsBEaMs+35sQVxE9cj0s1ylZNIGTNBRWLuNOmlOQXVfaep3UR9Z3prYfE+tquDs051aVPREAWawcA+BlxmKDzsUE4kF+Dby6eAPhGvkXxi3TJW7DZ8v8oo5f5xMqP5WzYuBKRl6jJM2N/cCyfDRZ2vV2j4Z7qTlJfDcTndex4rdjAPeKKUgBLvJUjl5muPB3olezBABJvBugdxNldXFoFKbfSBWw6BOFDxUmzlSj7lYFeoJ1Kfb9AUfonOcE9j0uc3D4e0uwvQLM7ozgRwefeVUaLNjCFzVCIoy63ELe7joGnM6PV2G5U5nUcM8dcyviE5vzsD6my7JOgoLcKX7b9JwwHPEeuFl+MMuvFwwkI5F5JgSs6ZjnNtWKcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVUvZ0hwZzFjYS9rOUZVMzk2S0xvRFdxQmNwd3BHSnliMHN4VlhMTWJ2ZVFL?=
 =?utf-8?B?M0ZOeG5TU09HUzdCM3M3blFQeFIwekxWRTdiYnlpeWxuUGtzNnJnWXhTS2J2?=
 =?utf-8?B?N3I3dThQTDZNOEVMWEZSOCtuWTd4L3hDVnF4ZmhMSVoxQ3hhR0tRWk1JNnJu?=
 =?utf-8?B?bElWc2NJa3BTVVZZTU9HMWpFN3FOeFNWYVMxdi9aK3RkUlptVm5vOHBsb1ZF?=
 =?utf-8?B?WW1KRWVaV1lXQ3VVRGFhL1lxMzlOaTJmZjZrWTl1MkFNT0tBTWlBZHZyM2Fn?=
 =?utf-8?B?Y0ZPSlVVcmd5RWNxaU1RV1hRYUV5dzhGUW5qbFFOOXhmS21YYVpsM3pncEhT?=
 =?utf-8?B?N1RHWUZiWWlodnNpYm5vOHRnZlQrck1yK3pYQnRVU1orWVRZMkM1MkRQZ2dt?=
 =?utf-8?B?SWU5WEU0ckk5OXlHT0dqRm1VYmo4RTRqcFJ0OGFmcXlOTGJrL0pZRnhEN1Ft?=
 =?utf-8?B?YTZDc01iNUltRVZuNzNUMGN1WHNaUXh0MHdHQ283QUpYK3dZZlZIUTRFUmJ1?=
 =?utf-8?B?VVFGWXNTSkM3c3BSdEx6Umh1TFR1OVAzV1NxVDQwR2VmZGE2dXUxQmlqREtF?=
 =?utf-8?B?MEJXUWIwY0hkelRCekFjSFROV0RKWERlaXRCUXVVc3lqT0hiSmF0Zzdlc1Nm?=
 =?utf-8?B?dzdVWHF3K20rck9waHFWTGRPRHZYdkYrZUxFOEVBQjVmMlpkc2svZ214eEN2?=
 =?utf-8?B?TFhzbXJ6UTNqNTZMd3RqNlVwQytCK1cxc3dYemNjQzRIQ3BiOTRTbTB1bjYz?=
 =?utf-8?B?RDFiUUNFRW1sbDlIczhSVU5wUTJ3Rk5iN01lYmJhWStPdUcwdDNhNTI5cUs5?=
 =?utf-8?B?eG1QUGcrS3VYNXpXT2I5YlBlUjBDYmhOa05QcmFLdklkQTFzWUVFNit1Mm9Z?=
 =?utf-8?B?VFU1a05kZFluWmNzdU9tbi9UakRIZ3NRZmV1WkhNUjVPSHhPaHUwN0VIOGhq?=
 =?utf-8?B?WDFZZFVRR1FHd0dtSGVza0tINTBNbGszMVVaNVQwSmVtczZERHNxWmpQVkFS?=
 =?utf-8?B?QzdIa3FFTy9BaGgvb1dENXhTRUh0UVBjcWtvTUZNSytrRlRPa3dUQld1Y3hT?=
 =?utf-8?B?c0FFR3EzMWtDWk9vcjRna3p4RGc1cUpQR1ZSUUd2alVlNklYVERhaUpkbklw?=
 =?utf-8?B?MHZuTWNWS2ZUa2o2SElTRlJScDFGeWFpVEFiTHk2ZlpnZmNpbGlOTXVEbnY2?=
 =?utf-8?B?UUNxWG9jUzhlcUJxWWh2OWlEdEFHOXN6OW1YS1dtMGR3ckRCRi9RWGlnL2di?=
 =?utf-8?B?V1I1d0tydS9GYW13dVJTVnFwUllYbnFMdWpPUWJCRHFCclE0TnB3Kzdwa3Jj?=
 =?utf-8?B?U1QyaGFDMmZJVkd5MDJjWTMvc3h6cFZBZlN0ajdKOUtUcHVHdkhESEYxYUZ1?=
 =?utf-8?B?SWtvbzZNTXBUelRJUjhYd3cvYnBaazNwY1VjcGRIUDVUMUlORE02MHVqODFQ?=
 =?utf-8?B?NzVUUXpFL1RqVjJMbm14RzN5cjM5ZjZhdzRhNEYrODNuemI5WmNBcXY3N2VT?=
 =?utf-8?B?UDR6OEhjRFNITFdySkRCeGFSamlXVVNieFpMSG1rZTloQ0NKWGFoVWlrRkpz?=
 =?utf-8?B?ekdmbWtCaGgzUUZxWndMcXBzdE1wRFFUeC9la1F1bzBnY1E3OXBCZWpyT1lP?=
 =?utf-8?B?MTZWNXdKRnVaNTlwTVNCd2xLeFFDc2FqZjJpekNTTWlZL2tBZmprUmVscFdD?=
 =?utf-8?B?Yy9aVVZ2SkIrMDFSL0ZTcmVvTEFJbmZXQy9sanB5QXUzOHljbWJlS2YwbDhu?=
 =?utf-8?B?bzZxckhubEZqSEllNngxOU1UYjRJZFd0dkFtL1kwVHNlMi9WcUdLaEt6RTJY?=
 =?utf-8?B?NDdhZlVBY3htVmk1dDQ0Tlp1SENhU3l5ekkzQ29CTC9UdHEwQUtqTE1JNnpt?=
 =?utf-8?B?TE1VNEJkQVM3S01vR2RScjZFY2Mvc1E2OWFWMjliZjdwYy9MYVRxc0MvU0kv?=
 =?utf-8?B?Y3NFZStxTklGNjJ3UGh2eWZwY0o2Vm1kTE80cGM4UVU3eVk1ZjEzT1YzR2t0?=
 =?utf-8?B?WnliN0N4ckVlS1Z0NE11NXk2Wnc0MTNPcXJZaG41ZzRSWHpzSzkwT3lkTXZh?=
 =?utf-8?B?aldmaTdsV282UkJkcDNITTZwbCs2SFBIQTB2elVRWW5BWjd6SVJPMHFrT0cr?=
 =?utf-8?B?RTNNWFVVd2o0K1hNOU9TWWxjZ3BpSFZZZXNyempQOGd6RlFIODVmOFZRU2Mx?=
 =?utf-8?B?U1k1eGREMzNveWh0Vkh1UThucFJMcjYwc09iREk1aWtJODRPVlR6OHBKQk5D?=
 =?utf-8?B?eUdmZ29KYWphd0dXNGlrUjJ2c202VjJjekV6ZDBuWGRsdmoxMlI2UDAwQ016?=
 =?utf-8?Q?XR1n0SEBxZG6RbPR7r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d16bef-8a62-49bf-ead0-08def2cd2e1d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:40:19.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4jb9eY0BcyTC6ufUtLHIhB6HNuUvmPuWphKiIfA8p9ylLWQB7EULDQfV8klXeQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

On 7/29/26 13:00, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> buffer object (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and
> is not saved across S4 hibernation, so the MQD is garbage on resume and
> the first submission faults (no-retry page fault, UTCL2/gfxhub0).
> 
> A bare unpin is not enough: amdgpu's eviction policy relocates the BO
> within VRAM rather than to system memory, so its contents are still lost
> when VRAM powers off. Instead, at suspend, unpin the MQD BO and move it to
> GTT (ttm_bo_validate to GTT) while it is unpinned, so ttm_device_swapout()
> captures it in the hibernation image. On resume, repin it to VRAM and
> refresh the cached MQD GPU address (and kernel mapping) since the BO may
> come back at a new location.

That is clearly not correct. Unpinned BOs in VRAM are moved to GTT during suspend.

What can be is that you unpin the BO to late! In which case moving it to GTT using ttm_bo_validate would be illegal or at leats very quzestionable as well.

So that patch here is clearly incorrect.

Regards,
Christian.


> 
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 115 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>  4 files changed, 169 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..f4da27da0af7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1254,6 +1254,106 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>  	return 0;
>  }
>  
> +/* The MQD of a gfx9 compute queue lives in a pinned VRAM buffer object when
> + * mqd_on_vram(). Pinned VRAM is skipped by TTM eviction, and a bare unpin only
> + * lets amdgpu relocate the BO within VRAM - whose contents are lost across S4
> + * hibernation. To have the MQD captured in the hibernation image, move the BO to
> + * GTT (system memory) while it is unpinned so ttm_device_swapout() snapshots it,
> + * then pin it back to VRAM on resume.
> + *
> + * dqm_evict_mqd_bo() runs at suspend, gated on adev->in_s4 so runtime eviction
> + * (where the pinned VRAM MQD stays intact) is untouched.
> + */
> +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_bo *bo;
> +	int r;
> +
> +	if (!dqm->dev->adev->in_s4)
> +		return;
> +	if (!mqd_on_vram(dqm->dev->adev))
> +		return;
> +	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> +		return;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return;
> +
> +	bo = q->mqd_mem_obj->mem;
> +	if (amdgpu_bo_reserve(bo, false))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	amdgpu_bo_unreserve(bo);
> +	if (r) {
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to evict MQD of queue %d to GTT: %d\n",
> +			q->properties.queue_id, r);
> +		return;
> +	}
> +	q->needs_mqd_repin = true;
> +}
> +
> +/* Repin the MQD BO to VRAM on resume. Gated on the per-queue needs_mqd_repin flag
> + * rather than adev->in_s4, because in_s4 is cleared (PM_POST_HIBERNATION) partway
> + * through the KFD resume sequence and is unreliable here. The BO may come back at a
> + * new VRAM address, so refresh the cached copies (mqd_mem_obj->gpu_addr,
> + * q->gart_mqd_addr, the kernel mapping, and the self-address inside the MQD) before
> + * the queue is handed back to HW.
> + */
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	struct amdgpu_bo *bo;
> +	void *cpu_ptr;
> +	int r;
> +
> +	if (!q->needs_mqd_repin)
> +		return 0;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return 0;
> +
> +	bo = q->mqd_mem_obj->mem;
> +	r = amdgpu_bo_reserve(bo, false);
> +	if (r)
> +		return r;
> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (r) {
> +		amdgpu_bo_unreserve(bo);
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to repin MQD of queue %d to VRAM: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +	/* The BO may have moved; refresh the kernel mapping and gpu address. */
> +	amdgpu_bo_kunmap(bo);
> +	r = amdgpu_bo_kmap(bo, &cpu_ptr);
> +	amdgpu_bo_unreserve(bo);
> +	if (r) {
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to remap MQD of queue %d: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +
> +	q->mqd_mem_obj->cpu_ptr = cpu_ptr;
> +	q->mqd_mem_obj->gpu_addr = amdgpu_bo_gpu_offset(bo);
> +	q->gart_mqd_addr = q->mqd_mem_obj->gpu_addr;
> +	q->mqd = cpu_ptr;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> +			q->properties.type)];
> +	if (mqd_mgr->update_mqd_gpu_addr)
> +		mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
> +					     q->mqd_mem_obj,
> +					     &q->properties);
> +
> +	q->needs_mqd_repin = false;
> +	return 0;
> +}
> +
>  static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  					struct qcm_process_device *qpd)
>  {
> @@ -1297,6 +1397,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  			 * maintain a consistent eviction state
>  			 */
>  			ret = retval;
> +
> +		dqm_evict_mqd_bo(dqm, q);
>  	}
>  
>  out:
> @@ -1350,6 +1452,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  				goto out;
>  			}
>  		}
> +
> +		dqm_evict_mqd_bo(dqm, q);
>  	}
>  
>  	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1429,6 +1533,10 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
>  			continue;
>  
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval && !ret)
> +			ret = retval;
> +
>  		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
>  				       q->queue, &q->properties, mm);
>  		if (retval && !ret)
> @@ -1489,6 +1597,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>  		q->properties.is_active = true;
>  		increment_queue_count(dqm, &pdd->qpd, q);
>  
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval) {
> +			dev_err(dev, "Failed to repin MQD for queue %d\n",
> +				q->properties.queue_id);
> +			goto out;
> +		}
> +
>  		if (dqm->dev->kfd->shared_resources.enable_mes) {
>  			retval = add_queue_mes(dqm, q, qpd);
>  			if (retval) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 59eff3389d39..38b46b696243 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -117,6 +117,14 @@ struct mqd_manager {
>  				const void *ctl_stack_src,
>  				const u32 ctl_stack_size);
>  
> +	/* Patch the MQD's cached self GPU address after the MQD BO has moved
> +	 * (e.g. repinned to a new VRAM location on hibernation resume). The MQD
> +	 * contents are otherwise preserved.
> +	 */
> +	void	(*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *p);
> +
>  #if defined(CONFIG_DEBUG_FS)
>  	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>  	qp->is_active = 0;
>  }
>  
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +				struct kfd_mem_obj *mqd_mem_obj,
> +				struct queue_properties *qp)
> +{
> +	struct v9_mqd *m = get_mqd(mqd);
> +	uint64_t addr = mqd_mem_obj->gpu_addr;
> +
> +	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
> +	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>  static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>  			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>  			struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>  	if (mqd_on_vram(mm->dev->adev))
>  		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>  }
> +
> +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *qp)
> +{
> +	struct kfd_mem_obj xcc_mqd_mem_obj;
> +	uint64_t offset = mm->mqd_stride(mm, qp);
> +	u32 num_xcc = NUM_XCC(mm->dev->xcc_mask);
> +	struct v9_mqd *m;
> +	int xcc;
> +
> +	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> +
> +	for (xcc = 0; xcc < num_xcc; xcc++) {
> +		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> +		m = get_mqd(mqd + offset * xcc);
> +		m->cp_mqd_base_addr_lo = lower_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +		m->cp_mqd_base_addr_hi = upper_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>  static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		   enum kfd_preempt_type type, unsigned int timeout,
>  		   uint32_t pipe_id, uint32_t queue_id)
> @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  			mqd->get_wave_state = get_wave_state_v9_4_3;
>  			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
>  			mqd->restore_mqd = restore_mqd_v9_4_3;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr_v9_4_3;
>  		} else {
>  			mqd->init_mqd = init_mqd;
>  			mqd->load_mqd = load_mqd;
> @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  			mqd->get_wave_state = get_wave_state;
>  			mqd->checkpoint_mqd = checkpoint_mqd;
>  			mqd->restore_mqd = restore_mqd;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>  		}
>  		break;
>  	case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c1657..3d0ffcc91e3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,12 @@ struct queue {
>  	void *gang_ctx_cpu_ptr;
>  
>  	struct amdgpu_bo *wptr_bo_gart;
> +
> +	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
> +	 * TTM evicts it into the hibernation image, and repinned on resume. Set
> +	 * while the BO is unpinned so the resume path knows to repin it.
> +	 */
> +	bool needs_mqd_repin;
>  };
>  
>  enum KFD_MQD_TYPE {

