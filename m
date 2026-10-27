Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0E606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NMDoNHRg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9179810F498;
	Tue, 27 Oct 2026 13:08:43 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5228D10F4C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2qN3PPrN62BC3pfU1OQ1LJLZmI5lK095BEkHZocJpQPKAcrPSF/nH8MlUOKLWycUw05gOz+LEFirYzTTsaTPmn2Vxewl8EiIi6XwK+EuhA5oTHTa23li8+ufr+HMeD5cB4OjL5rhmvKg3FVQufiPJksN6sZSBeLcfb9s/rIYQIwwlpqvvxRcJFUL110LBwh1d9wohsucoh+0/w5gxaxz+MMUWo+Ikzr/yeepDLY6c9WXknQO0+g+PYyNBXeuPFUO6E5ottk8DZVsLqaa0fum4VHRRLSLEFJ8QN5J402iRtA9c155No3/K2qww2+RIS15X9UVwp4bjkMqOm0cza6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+5Fzei9yz1StqaePnz1wboVglLqH2XTYSpwUxgLK2k=;
 b=W/JYigzfj82MedCuaJwsYtxdLfy4LwD80k5s/MW+9KhdCqA7Ktbgi/NMadneaQzQt3u9vsYneCQOgoCl1R0eCEDSwfBUh9x3QSFCngSaLQQqZJqDSAQVzAy8Xe2utcTGFqrlWywuDM/FQzGY1suG8Npa03UkZOd1+PQ4lEAuDEx5PdC8aIDyDHZFM62R3PnJDt5wfZlEE7MKiCw0if+tNdEY1hk0uI/huczJ7yy7nfrPgx455tzIrdEnqEdzm0ISNNdevAsstQq9cl0i1vS2iLj2mz0CniH9mJo28ukoLvv8SwxRsdOR1bsKliox+cfEJLWI0bHKtnIxx24nDHIfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+5Fzei9yz1StqaePnz1wboVglLqH2XTYSpwUxgLK2k=;
 b=NMDoNHRgJSwFsuoRKJiuXlPPnZ8h8gvUswgEQrR/brIK5l7JdmHEw5PSvPmGasuRvBBWTTBDLUnZtAIVZMYM6wTTuYQuoiYKrSoYHLLxaAyqKp3hhV154QudDTdQJjl0/eJH8/MoQwqIRWZDwTS38iSupdlPoh3ozpIVrpoaQAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:08:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:08:32 +0000
Message-ID: <82f3a6d2-23d1-4ab9-bc79-cbb4033716ee@amd.com>
Date: Tue, 27 Oct 2026 14:08:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu/userq: validate the moved individual BOs
 on restore
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261027083027.2776591-1-Jesse.Zhang@amd.com>
 <20261027083027.2776591-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261027083027.2776591-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:208:23b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a18b50-91f1-4a11-01d3-08df342b66f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|56012099006|261026140227099003|18002099003|22082099003|261026121527099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: z7b0pmU7BmN5594aFQ8uIX80HyfZIL5PcHlmciSChRbkHlYVQTD/0Av6mN/Oma+0RSjjuoEpzGa4548i8qXAKyhcwgYDyBrOhujEWtCPdJUSzk9rn62aKMM+cc6aZ4xGXMZWmi1wk9gx9m6fMawj+3A1aAjZZ4oR2hv5icgAsLhNNpnbyvN/5khtMQCLS74PF7GK5Tl3ukbbct+2QJZEI0sKhRPq+YyaO8H7wntDXoyBwujYRRKsWmM+asqUezx1vcVgUJGLlMoqgi3S0FYeo4WzyTwBC8lDYutQh0zFcLmQHs1O43L1YJxGmO3bTL99xg634HRYdsE6s86mGXNxxbzdoc2PKmschSVD5WwzyWCYKhNjQDMakLUK4/DP9rydc1SmumqtJhQzSkgKIsFugSvO230Cc4TQZg0TOGL17sM2ZFOoSJ6+vegeZMPUuuXkyAvtOmk/Xn9rNhrF+i9bGi6ozq/uPmCxPL6zY/BzX7gUkluQpi9TMipgMCi8Hpc28u8DLkJLLD1SyZSgqBsVWuLlUPOFMX5bfknD+2DMDbcg2cV+8KtuvH5GKqPj2KmctVfkezqmcyev7iqmukfYy7vwcG2+AtJYFm02rsQwTc++fOmiSdSDwjjYigDYfJks2mpxNcqvEbBvqmovgFLiJ7jD9V6kccxG08oaY5Nq1Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(56012099006)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHB6cllxMHd5OXBBQkIxZmJDdUxCUlY0endYWEFwdnB6cjdKaXZzVlVsQWt4?=
 =?utf-8?B?Q09xRVBNVkd3SG5VanJrakpxc1RBQmt6djMyZHZveFdhT3lBU3JoM25OWFlX?=
 =?utf-8?B?TWFlSS9UTUxsOWVGVDA0VXhZOVd6SWZ2VTYyeExGZU1qMkI2VE05emUwU1Jh?=
 =?utf-8?B?Z29qTGFXSHU5Tm9rcCsyemhrdVVKRXp2Rjhtb2g5aW10SmRtWm1JN3hacFUr?=
 =?utf-8?B?MnRqcXdlcTh4amJ0cXpMRXFOcmJ6ZFFuY05NTEpFYmRCSUFIcEhQcXpLaXFy?=
 =?utf-8?B?QklCanQrZFk5WWdFQ0NDNmVsd1RTVHBGTnhML1JER3h5eUkyREhESDlSbk1u?=
 =?utf-8?B?VTNkRFlvL1p2NUNlOFFBSkoyZy9RQjBQVGJndTUzeWpiVXpjZlRkbU9IVlVY?=
 =?utf-8?B?VEttM0p4bGVHeHFSTElvVkNzOUhoUWt3NW02WWJ4b0hSS2lSa0Q0WEZHdjky?=
 =?utf-8?B?dEh0Y3VaNTRNT3Q2TEx1M3hiM0JyYm5KREllenFqYkhTdWdNK3pTYUcxTUZl?=
 =?utf-8?B?VXR1SXNmaGxqcTlzNGVwNUE3bGVTTk0rQmdGaFhubjFtVlJzK1lmRW11YjRN?=
 =?utf-8?B?VTB5M2pIOGU1NHB6b052NUpPQmhvMzAvbGhMTGVsd0h0WXl3aHdHdkdLeUZj?=
 =?utf-8?B?QWVzbmRCbGU3QTZ2YVpzK0paa2lWVFhxNk81MDhzMmRpZnVzc0E1M05NaHAr?=
 =?utf-8?B?OWY2MVUrSHE4RE9tMFk2NC9kUHJIUG1ZQzhJTmVaTlV2aHhMeFFCQzZiYWE2?=
 =?utf-8?B?ZVdhaFlwQzB2ZXVQQnIrM0lQdUp3WDF5ajJvN2pudUptRllDd3hhQ21qejRh?=
 =?utf-8?B?VXJxYmpBK1pBNHRwOEJ0NXEwdGNaRk95QTNkamhvdWx6OFN5d0FNaE9SYXd0?=
 =?utf-8?B?K2J2czJQY1dqRjhOdzhYejVUbTVYdlpuVXdGMXZ1ZXh6UzlOY2pQNm1EamVu?=
 =?utf-8?B?YjhodlZuWkZjdnVnUFAvZ3BLWnNGS2xkMUdrRGFoV3JDRWlCL3F2R3dQNVRp?=
 =?utf-8?B?SzNacFlsVGxVYkFFL3VxN2ZqQ1p4alhvcDErZllpQWVvNUpYaHVQOWhRRHVH?=
 =?utf-8?B?RUNPZXoyNXBSdDIwY0lrRWt4REphUGxCQkJqRGhScXhobkNSRktlbzBrWUV6?=
 =?utf-8?B?RW4vNnQ3azQ1djYrWHFvSHlWYTlIaE0wYU1BQzAvUldVNmFYTEQwbUZVSjU0?=
 =?utf-8?B?RmtpSDY5dnRLQnZGME9aWEdaekpjU1BCeGIxNHZHR2k4K1dWdldNWWlGTmsv?=
 =?utf-8?B?UlRiVGE5MmNxSjdFa2g5Uk9qRlNpNnkzKzhqL0J4Y3J5VGVJcjZJMjVHWmZp?=
 =?utf-8?B?MkJTbWVGK29uR1hlc1VWbFJ6VVptOEs3THdTYlVnSHRRZE03WGJZcDJkZjMv?=
 =?utf-8?B?QnFQN2kzQit3SFdFWGM2QmlndHhRVEo0Q1NSWUovOGI1ZlBPKzRzUytYK0FD?=
 =?utf-8?B?M0lscVhKRG44THlqZHhrK2V5QlNhQWdRQ1hlQXR1dEx3bnpHY0VSL2IvMVlV?=
 =?utf-8?B?dlhUdEJTcktmZWU5emdkdGUvRlBoTDY3cUkyNlBENjZJcnEvY3FOT1Q4QWs0?=
 =?utf-8?B?Z05wZEpUaVlMbmxSSnBpVEVMUllJUUI1Qi9ZTWhBSXhxL0djTENjQU1RNWpT?=
 =?utf-8?B?NTl2cE1JUjZnUFg5emVUcy96Zmd5MXlNLzB1cDVHQlZhYi9hVWo1MHFjRHRo?=
 =?utf-8?B?K09TYXdQRG8xSnJzSHYwZE1MRXRjdHIwMDBnUjJUeTFjV0RVaFdqVUV5RG5P?=
 =?utf-8?B?T3dzeGhCOEJ4bUtMYjVEY3Y3dHQ0RE1nUnpmcG44VkZkTzYxbG9zWm9MNUVS?=
 =?utf-8?B?ZW16YmxaOG9sZVBJMk1LOCs4L25XU052bllNTWc1RTNNMHBoSTF5Z1lwL0RO?=
 =?utf-8?B?LzdoOXVGaHR2NGFNVXRuMnZhZW15SDJLQVZEWEY1eVNNbkQydXhFbVNzQTl6?=
 =?utf-8?B?eUpjTTRYSzd4dUMrdExDQXFqSTRDaGtCMmJ2TitmQ2JsQ2RrSmNQRVE2dzVO?=
 =?utf-8?B?Q2pNR1BmMW94VGRkQ1oxcHVjczNVWWl3UDJMUzB1SjUyRnorZE5ZUVFWQzR2?=
 =?utf-8?B?ays2bmZwM3VGcFNTclA0MXJDZGw2Ylc5Mk1FMjU1MHVSKzV5L0w1eDgxZlNQ?=
 =?utf-8?B?WHg2M24xeWtLYVg2SWY1SlJ6d2E0eGFTc2hONzJsMjlzMEdRU2lBWkxjWGVY?=
 =?utf-8?B?T1VOc05ITWNBZDN4QTV1ODI1aG10RnRPRnh5WDN5U2RRM1A5S1MvbThjKzdG?=
 =?utf-8?B?M0RtaVpzRTFxa2QwQVAybG9NekhrSmJDbWlTWHFWNGsvbVJaRHFRT2xQY1Rl?=
 =?utf-8?Q?zi9aOJJPmcdSi8TNlD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a18b50-91f1-4a11-01d3-08df342b66f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:08:32.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rEkF/hNDSvI4YiqAblIi11w6xs0jXuCtxRg+XMISfqiAfEHl2fLPymdr9G8jIOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 09:28, Jesse Zhang wrote:
> An individual BO of a user queue VM, i.e. one which doesn't share the
> root reservation, goes to the individual needs_update list when it is
> evicted. The user queue restore looked at vm->invalidated for them, which
> the VM state machine rework turned into the always_valid evicted list and
> commit ea9be90a5558 ("drm/amdgpu/userq: actually validate userq BOs")
> into the individual evicted one. That list only holds imported DMA-bufs of
> compute VMs though, so for a user queue VM nothing is validated.
> 
> The restore then neither locks such a BO nor moves it back. Its PTEs are
> updated to wherever it is now, cleared if it went to system memory, and
> it doesn't get the new eviction fence, so it can move again under the
> running queue.
> 
> On navi48, once the BOs of an SDMA user queue are evicted from GTT.
> the queue faults on its ring and rptr:
> 
>   amdgpu 0000:03:00.0:   in page starting at address 0x0000000100000000 from client 10
>   amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA0 (0xd)
>   amdgpu 0000:03:00.0:   in page starting at address 0x0000000100101000 from client 10
> 
> Validate the BOs on the individual needs_update list like before.
> 
> Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> Fixes: ea9be90a5558 ("drm/amdgpu/userq: actually validate userq BOs")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

We should probably fix that at some point by moving all BOs to their evicted lists.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..15efe71594cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -991,7 +991,11 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
>  	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  }
>  
> -/* Handle all BOs on the invalidated list, validate them and update the PTs */
> +/*
> + * Handle all individual BOs which were moved, lock and validate them and
> + * update the PTs. An evicted individual BO lands on the needs_update list,
> + * the evicted one only holds imported DMA-bufs of compute VMs.
> + */
>  static int
>  amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>  			 struct amdgpu_vm *vm)
> @@ -1002,8 +1006,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>  	int ret;
>  
>  	spin_lock(&vm->individual_lock);
> -	while (!list_empty(&vm->individual.evicted)) {
> -		bo_va = list_first_entry(&vm->individual.evicted,
> +	while (!list_empty(&vm->individual.needs_update)) {
> +		bo_va = list_first_entry(&vm->individual.needs_update,
>  					 struct amdgpu_bo_va,
>  					 base.vm_status);
>  		bo = bo_va->base.bo;

