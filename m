Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B763DC54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 14:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA4110E01F;
	Wed, 29 Jul 2026 14:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TW5ztPdX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCD910E01F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niRgdkOKuMGYPzUKlmnWc9bbuaaRTVMdui5OoNayMhgW0n33dH/WK5TmZ1/8HLRzb2jzMnsoAf3WPOv5uny61LKp/vrmLYoMDUHg13+K19GDd3y+r9jaig8yCs21gT1lUsCXH8Sx+xeMj5gbiUM5/0W0+8jtPs/zTkgm/Pq7EfI1zy5Ts2d/qst7umJooHVAGOarD0gZyxWieZhc0n/9py3g+HMR5IEL6l/oqllqBD2crsqZFv+pd+YMwvHoHQvj7H1GAfmuf9Cu+WtCz7rgq+7VVLKeuuTZmDpDZjKbcJMlXE0j3b/36HaYhneGnkEhqvIDexplkV0e5pQ2yT5bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xaFMFxwo7vT8tViX0uPxZTySKL7IV66vNvxsrV00Ag=;
 b=K0ZJ2OArvnpFqx9wrkwabJUMrAB4Hfr5y322rZS7KGg3CdVOXsWkka+Wfkhmwt1zufpW8oSbdVIiSkgCM0jQqfLVjuH86q2MIy6BF5X9rIHcPqKIT8Z4Thh/2+u3SrRqy4iND/O32qsW+EFQGcIcsfKt4rk780ClxXdnbvnYJNnsEPJmigAFFTHqWTVn3t9jY4z2A5CK0+qVBge7QpFLSQDZcCxvumyJLvzs0YAT+ukXlqm1oH99OzcbwcKjzXV/eVUVFgX1l3tQlD4kP7rxJ6vs5X7ONGprECQl6rLNhy2alEsJTeOc2AEv1eYFGMtWTnL2SSvwf/EXTLyoFMfRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xaFMFxwo7vT8tViX0uPxZTySKL7IV66vNvxsrV00Ag=;
 b=TW5ztPdXzHFLxV0k4ScRG1pvRCx9wFkvKrRXl5Q/YBbVfdR9EgFmwwhAtk6aJBm8Hnqsv0hGPW/W3Pe4LttHqyH2h/ckrt939z52ElgG80sMOvirsTCe5jyRDwbqu6B/N63FzDrHRTFniTwCKnVikXw7hFl3Cf2dVyERS1zHqUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MN0PR12MB5860.namprd12.prod.outlook.com
 (2603:10b6:208:37b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 14:53:13 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Wed, 29 Jul 2026
 14:53:13 +0000
Message-ID: <794cf61e-b77b-4cd5-b547-a1ffea6201e2@amd.com>
Date: Wed, 29 Jul 2026 10:53:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: preserve VRAM MQD across hibernation via
 GTT eviction
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: Christian.Koenig@amd.com, Philip.Yang@amd.com, Mario.Limonciello@amd.com, 
 Srinivasan.Shanmugam@amd.com, Tiantian.Zhang@amd.com, Victor.Zhao@amd.com
References: <20260729110001.46186-1-shikang.fan@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260729110001.46186-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de89cbb-ce0f-4b01-c57d-08deed811d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TVnDLM8YqUobUqBzJ3N3j7I9no3gjDG4btHaJbs+2W52poyA+IOKTzWYWotJkZugjXafElxlQAidjj3eUb1Z5n4Yg8otJHX2EdUmlzfL9V9WECXBGMtu0TGnfq53rX+qTnns+wJLgdWxbtgGg/WDzZ9tnjfCFr/T1hA2TNvzVhXDZjCpxgzWpBQ68+oMnMVK+B6fQs+A9FAcdZzkv/hRzt4GgwLVlzJO0Ft4EivxkKUQXvuBNokd6dCDiXpzI/uxzvpsuqhvwist5kZv2860EsdDu36p7WwRa1IEKPDS/noERofBjRkWbF/mrlGbOI17Ra9ZYSgK1fwVY6nCe51Lr6yKQqBmug8bIJtRaNUgkr8+cvE+I6fdZystnyrL/3Cjt9Q+OMWJ/dZ9u6tkTqIxZX2iYg+2kqV+np/yTEeds7AVcikfivWRMpwRiRme9Vc7XPNfcPExKExXPBc3rMb0CzjsIVWLXo/8t7e5PoBo5Y0O4BEzcv1due9I/hQX+WAjBezWlekmjxUeTNXRHDm2kcgNr/lXNufvMg5Uvd9ayZTXIjb22NCx22K00StNxTniOKrxp0r6B/epntLNmTA1twBnLxhGK98a4b+bEztB59ygQsUznM+yf8V/hs/dOnR03Fl1zBPlvB9l1BGSBXiBlSybe89fwcA5JuLSYrZln/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFtcmVRYWR6NzN5UTVMWEJrRmprRHp1VERBZ21Ocld1Y24wektIMjZwRy9Q?=
 =?utf-8?B?TDhHSkFLNE5QU3ZlTDZJT3pjK1FEL1MvcmJ1V0xIc2ZEYXNnY1JaRGlZYkp6?=
 =?utf-8?B?SndoWWdLMWNCL1BJZmV5dmlvM0tmZi93cVBQd1JjdjhqMGlBd2ZpZk5BRzVy?=
 =?utf-8?B?RHFXNEJKamRuZDJBTS9uTDJUeDhCQWtqWDNsbDg5L3RSeEFxbU9jVmI4TUQz?=
 =?utf-8?B?WTcwbndRUlMwV0t5dmdBVHNzdGNmUzJjR2RTK1BGbkNoMnVCd1pCMWpGUTBQ?=
 =?utf-8?B?a05YUTVMc3R6ejVSM2JjeUp1ejkyRXoyUE5tY1lyeTlKQW1QUHh0V2pOQWwr?=
 =?utf-8?B?WS9SSXBONE5KNW5zMkkzcUUzcU5KajBBSGlKNVpWTWt1Vlo4bDhHWktsNUZi?=
 =?utf-8?B?eU1PUG40REIrbTdaNFBiRHhlK0tnY2htdy9wbk5rbWd4S0hqaHNBZDF6YUh2?=
 =?utf-8?B?YTV4VmpWUGR0b0NwNDBoL3VoU3A1bm9PZmN3ci9TY2szN3R2NEhRUDRzWGNX?=
 =?utf-8?B?bXA1bXM4UW90MkxPTmE2R1ZjMXNDMGlOeURKeWlUUDB4RlVaUkFsN1Y2Qjhp?=
 =?utf-8?B?RVIvM0lTc0FLSS9tNFVZQ3JhcEcyK0tEM2h6d0hNVjRrc1FkcUJjS1JmajZh?=
 =?utf-8?B?cDYwMnVHZzh0WWtDWUlDOGhwYmpPZUZLa0Y1K3ptbE9oMTFEQXN1ZlQxa1Bl?=
 =?utf-8?B?VnhqM1QwUU1vZkY1WVJ4VmZPZU5wWlBNaHhKeHREUWd5cUdBaVBzWjE0cUhp?=
 =?utf-8?B?aDVMVlFoek9uREpEMXFEK01PQ2tlWHJSKytGalNhcGkrUTk0Z0htV3FrUG9r?=
 =?utf-8?B?dTVxbFZMeXJCVzZzMWRPNHdIUExnZk9NTEJ2Nkp6VXZoejNnQ3FRUnRPYkJC?=
 =?utf-8?B?anF3UTZnVFRFRFFWYjdKa2xKaTQ5bmNjbkwvS3dPRDZHTTQ1L1FId0t2MVQ0?=
 =?utf-8?B?bGdmYk9uanpqMjJZc201MkJzSzhlWVNBRXJNTEJacTRvandEZVNzMElrcEE3?=
 =?utf-8?B?NzRpaEZuRmhKUUhNYVpLQXlMRGVrRktxRzFac1hrcTQ2ZlR4YVByd3V1SDJi?=
 =?utf-8?B?SkcydlNLZWxyZXhqN0lUYy9SY3RpcW9vL0FwMTVhaVVCQUFuWVIwN29rQjJV?=
 =?utf-8?B?Smw5eTVLTnVnalZGU3BEQlpNc21yTzlhaE0wcGJQR0RrR0hxMEZNQjZJYXhF?=
 =?utf-8?B?WFlndkwvbkxKZU5oZzBDUUg4VUdhYW5pTzRvZnNmUmJtUi9NR29UeGU4RFA2?=
 =?utf-8?B?MnpHMTdZYmpvYUNNUFN1ZkJxQ1VzU3kza2VjRWs4V1NDL1djMVNxNytsWHdP?=
 =?utf-8?B?bGxPWTdDbElFdjZxWlhlLy9SZkU1cDRHYVdwVk84YWZZTEVvdWhzYzd1czNl?=
 =?utf-8?B?aWtwaDlqSzJpUEI4WStqSEhCeFJVMi9BOFowT3QyWXcwbDZzL3JmazE3MGw5?=
 =?utf-8?B?MzhmN0tXN0dJdURTanhZRzkxaEJ3K3hOd1RZc0JBWWhLeC9lSFNJMDFKRnZX?=
 =?utf-8?B?cytuUkNYbVVOczc1SWEzMWYyQW53WnFWdzRDaHJHUUk5Ky8zMDhWclAxdmtF?=
 =?utf-8?B?Zm9tdmd4SENjTHpReHVxMlNDZmwybS9ibmJTTDdTelFCd3N5RDVOZVlMS1Bo?=
 =?utf-8?B?ekZENklvbGVBRkhUUDAyWGVYUmo5MkwyR0J1c1ZTM3RIMXk3aURpTlJLN1hr?=
 =?utf-8?B?UEdsNUliMDl6UFR2U216UWNsd0NjZzhLa29Za1RvM3I1MmNoVnFNZHZ3eXNq?=
 =?utf-8?B?QnA2UnhMRVIrTmdDczgvUnhiTmZKck1XU3dZaXYwb20xKzJFVnlyMFV6OUxz?=
 =?utf-8?B?UGRoR0JjOXJzTTdGT1V6S1JVbXpkOUJlcVFLL3Nnc2tETXkvdjc5VXZLc3lw?=
 =?utf-8?B?ck9rZ2E3OEhnOFQyaFp3Zk5Gei80WEhLQzg1MFpnbTk3NkkrUm9PVzJmSzMr?=
 =?utf-8?B?TEhtandXNVI4cjBXNTE0Y2R5NVpnaWFzaWFaaEpJazI1TEs3V2wvdXgrUm92?=
 =?utf-8?B?VUZuanJtU00weG9zZDVSYUtBZ3pzc0dYNTNwWU80dU5vdjRqY2RjZU9jYXM5?=
 =?utf-8?B?M011WWlHU043MUIrbjN1VEJlRG0vTjg2TFBPY1UxZ0lMeVduL3BZQmJVanBP?=
 =?utf-8?B?Nzl3ZUhUMUkvT0pkSjZTZVg0RG5GUGZ0UjY2UElGTklscm1XOEtQR2FDNVlT?=
 =?utf-8?B?Yks0MXIxZklNRWNUaGhzdUs0bC9rU1FFc3NHWmpBLzRHNlNLTnZCQXRQanVB?=
 =?utf-8?B?L3ZGNVcyLzIrNmJNOTFmSlR1QTYxR0ZFMGJWQWpKd2xRZG5KUlQxc2Znenht?=
 =?utf-8?B?T0ozK0RXcm1OV3lYRzRFQVhPdnNQZ1F0ZXl3VlhTMU1oS0JTT0RXUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de89cbb-ce0f-4b01-c57d-08deed811d23
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:53:13.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDjKKAJbk7IIWxl226sDv+wOJzMif6SmVKSh/grtrAsIyAP1Zdy/lbyYr4+YBSEHxZJ+e+n6O/91UHw+GwgfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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


On 2026-07-29 07:00, Shikang Fan wrote:
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
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 115 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>   4 files changed, 169 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..f4da27da0af7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1254,6 +1254,106 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>   	return 0;
>   }
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

We should add some kind of warning or even prevent evicting MQDs in the 
first place (with a warning) if mqd_mgr->update_mqd_gpu_addr is not set. 
E.g. I expect that we'll move MQDs to VRAM on GFX12 as well, so we'll 
need an update_mqd_ gpu_addr function there, too. If we forget this, 
we'll likely get unexpected crashes.

Other than that, this patch looks good to me.

Regards,
   Felix


> +
> +	q->needs_mqd_repin = false;
> +	return 0;
> +}
> +
>   static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> @@ -1297,6 +1397,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   			 * maintain a consistent eviction state
>   			 */
>   			ret = retval;
> +
> +		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
>   out:
> @@ -1350,6 +1452,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   				goto out;
>   			}
>   		}
> +
> +		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1429,6 +1533,10 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
>   			continue;
>   
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval && !ret)
> +			ret = retval;
> +
>   		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
>   				       q->queue, &q->properties, mm);
>   		if (retval && !ret)
> @@ -1489,6 +1597,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   		q->properties.is_active = true;
>   		increment_queue_count(dqm, &pdd->qpd, q);
>   
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval) {
> +			dev_err(dev, "Failed to repin MQD for queue %d\n",
> +				q->properties.queue_id);
> +			goto out;
> +		}
> +
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = add_queue_mes(dqm, q, qpd);
>   			if (retval) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 59eff3389d39..38b46b696243 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -117,6 +117,14 @@ struct mqd_manager {
>   				const void *ctl_stack_src,
>   				const u32 ctl_stack_size);
>   
> +	/* Patch the MQD's cached self GPU address after the MQD BO has moved
> +	 * (e.g. repinned to a new VRAM location on hibernation resume). The MQD
> +	 * contents are otherwise preserved.
> +	 */
> +	void	(*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *p);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>   	qp->is_active = 0;
>   }
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
>   static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>   			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>   			struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   	if (mqd_on_vram(mm->dev->adev))
>   		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
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
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   enum kfd_preempt_type type, unsigned int timeout,
>   		   uint32_t pipe_id, uint32_t queue_id)
> @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state_v9_4_3;
>   			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
>   			mqd->restore_mqd = restore_mqd_v9_4_3;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr_v9_4_3;
>   		} else {
>   			mqd->init_mqd = init_mqd;
>   			mqd->load_mqd = load_mqd;
> @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state;
>   			mqd->checkpoint_mqd = checkpoint_mqd;
>   			mqd->restore_mqd = restore_mqd;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c1657..3d0ffcc91e3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,12 @@ struct queue {
>   	void *gang_ctx_cpu_ptr;
>   
>   	struct amdgpu_bo *wptr_bo_gart;
> +
> +	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
> +	 * TTM evicts it into the hibernation image, and repinned on resume. Set
> +	 * while the BO is unpinned so the resume path knows to repin it.
> +	 */
> +	bool needs_mqd_repin;
>   };
>   
>   enum KFD_MQD_TYPE {
