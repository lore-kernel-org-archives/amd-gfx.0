Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B81CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8041F10E5CA;
	Tue, 26 May 2026 08:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rs8Y1sVq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5809910E5CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR4nv8wwS8q56HkFwf5MuSg2TeZL2r4kvtBb8b84dP3p3G+pzgq3qFHRytIIjfB5y9oulrsgFJ1DxfRLBsR2eg4nyxr3D6FFY3GRYiwB8eNa2zelR55E5re8vwRIo6Crt8W1ZI08SCO5TndFYU1DbdYp7ClCF7q9ADFFrTrFir7mc/xxN56yuo/ZlvEOqfktg4WlguCrR6AnA1OomEE1kpN3cTOBBDC8eCM1RSlNJKoAaB1DNrWOpo55JUM/sXMl6aWy+QgjjLrO+BfayLxoZw8k3id23Ljfd+v6xk5CLNQBj7CV2K8Q7vadDWHUkEpBdwfZsjEDjYdlVM7xZAzGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkyMDlqQmSYU7ReMLyJ4749xCtE6nbkSg1Rs3/FVOq0=;
 b=ip2UIrhwBOTTheye2cR1MYhd+LMbwrtH3vUAOj457JIeWfVUmSq/vQ1iOlxcvLCFRcLUknh/3TJnCAYoJ9o1gcLa95dJS/sqgEcaW6UniCNpz3UOPLk9eofPIoBHHVVHhQCEJ9+pTtdSulOfukx6+g35GHItytPc9t90EmKQ4r30tfZuZQqR9lorQz27XyEjMnpGOAtkLGG8UvyGs5jPaDYgK4h4ey2NVvbXgm6zENPbSxhGJkqQ/aafTRamlkXcNCBFGVpZaUU4mEelqtDtlenAUpzEUePEqh64t8xl48IguJe9+OUHNcsUrAJcBSTK/az5v3bHEAADtCE/q2IT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkyMDlqQmSYU7ReMLyJ4749xCtE6nbkSg1Rs3/FVOq0=;
 b=rs8Y1sVqdFVpYGxGEX4NEtu3jX0mCe8lZnhJtl1lNRtlRZG9VimwIFFE2Y083xYpQohotAIIpZSz82Vy1SBv+ETqdemD2CuqX+BK7WFvpvK49k4javHtEfLAAEOU3wp3Pd6A2m/6gUK7BvC9VBWlmy4CCKI+TyBglIuZt0wzLts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 08:10:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:10:38 +0000
Message-ID: <eed791bd-ef86-4d0a-baf4-f779ed70326a@amd.com>
Date: Tue, 26 May 2026 10:10:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU
 segment when it isn't at 0 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
 <20260525113321.17953-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525113321.17953-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0799.namprd03.prod.outlook.com
 (2603:10b6:408:13f::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f392c6e-9711-4853-735f-08debafe4531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kWYkI3d4AlU9yYjajN6vpVtZi/T3dzmmGewEiV17i/fmgWmsZItzbEzNHrGjdpeSJKDd63UFvRYeoAfVQTUXMLJGBh0lA/7iIkZmAX8JKzYgXV+YwWQ6MaxqGaGX5pdLHLcdau+IvU/ojVlOIjaN+2qAKMwyudyhJalGFH00JNbnh4mZ/KfmJGB33do3QEixy0Nri9qbMiafJ6VVMMNPyJB67y4K3OHTJVsPIic7cDljc7Bj0UytMictmP81Re5udwtkQ3eeSzy1nCyiw16CmHvRrrZ59NXffH4OmV0pfCUUp4FEprPPoOnTX1zMw1lUvcQHCaEVUSSmXOrga5gk6jU8faAkc3RrTvSe+bQ0o7h4tNAKTKb3FHKCnWuBq3PlD2cF4zRvX3WjIGpI3ELjmuLHciZh578s3WAOduf15azEq5m9V2koJ4QAqsJQV05prQps3tmwdwZysYbimzm+Ibf5jzqgWWxH7qMNwQ6cbKWpbW+7MHg2zRoUYS6To3OqYoeMvjRiBKquI3MemmANWLpVf7UCyoa7cTTxgFWrRmbxoTKU3KWDrObN+7LCV8fZlpY42HgQWVzdm7VyrLU2wdVRp5gxAuxSXzxTR4r4AZLAwi8NDmq+P/XQHGKkkdrmghrAb3RGcoEUlh+VoxBhrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZYem9BeTkyNUVrbEV0OFFmVUpKQi93V3dvTDV1M1pLUmh1L0kzWVh3akFX?=
 =?utf-8?B?VmV2OWw5WWhhRGpFTXFEcnE3ZjVSLzJvWVJkOUxOUEYzZHdtSkQ2YmNBbTZk?=
 =?utf-8?B?OWc1MURLY3pLdGcybFRheVRNYkhHb0VNckgwWlVYRDhYVWlVaWpBSGdzTndP?=
 =?utf-8?B?Q2FVU3g1UmlsUWNndWN3bzdOMVRtRzkzY1VwSW02bCtSTGlQU3JyUFNqdEJK?=
 =?utf-8?B?SmJMMHJiYnJPYUJJdXUrSTdWc0JNTzJ3N1ZWdTB2SFk3eXdteEdSc2FBU1lv?=
 =?utf-8?B?NXdSRU9HS0VhbUVyZWJvS0V5NnBkQUhxVzRic0h3dk9iVGRZT1NQQ0dBZnFC?=
 =?utf-8?B?OE95RWR4WVliZjJuQmxqekE5d0Vibzc0ZkxEalg3bjc1djJGZk9pd1BrVWdV?=
 =?utf-8?B?Vjg0MVZYcVZ1Y0Y2YTRNL0tTN2hYS0E2R1JJWHJpUEg0ZUxQcEtyb242cnha?=
 =?utf-8?B?NUJBenl2amxOdnI5dm9ucHFROWJFTUV1WE5vb0NMQWo0Rk5aWnAvQXVGQ2ZQ?=
 =?utf-8?B?QlVNQVVIQlo3YWJ4ZU55d01IYXMvbFh1YUp5MmNXcWtNdDV6MTJkeXpTVFh1?=
 =?utf-8?B?OWF3eUNkYnFLUXJpc1FKUXBtTlQrckxQdnFma2hBRWErbThoZU1pN1g1NmVa?=
 =?utf-8?B?Q2h2NFNES0FJYXFtZzJMcnlRTjR1VzhkUStVUEhPeTY1VHRsOW5RYmFKUVY1?=
 =?utf-8?B?SXZOVi9mZzY5eHNtclFSbTJtSE1sVlFMRW9vTmRiVEV5LzJ0VjNBUEhkbFNa?=
 =?utf-8?B?eXlsY3VFb2p5cjd5NjZXcUxxa1pFOHJFZ1UxQzErbFdlSTdjOXlwRkVVRlRi?=
 =?utf-8?B?VHZrZ09SQThjVEMrSGllT081cW9obWVUNmdPdGJiWDBSQlRYUlFMOVNIUCtY?=
 =?utf-8?B?R3c5VmFRQXNlUWdyeGNjcHVUcVJrSDEwYVc3aUlUb0JwRmdiWWlqV3Fjaytj?=
 =?utf-8?B?VkFFWm5wc1I3dlBxa0o3NmJSQytKaTdncnNkb0psRW1ORDNQYWdQZEgzTHQ0?=
 =?utf-8?B?c3oxamc0dGIyTHEyY1FnUVFDa2hKSDJuOXBXdHNVWnZBaWhBNUUvWDNFVld0?=
 =?utf-8?B?eitjTXliWFA1SnpNNFVXd2JvbmdtSnNtVDNBZEp6Y2lyczB2T3dDUnVaSnBs?=
 =?utf-8?B?Y05acENDYzkxQUJzQUVWbHNMOFR2blRaVnJzSmhRRE15TjZTaDhGYU9PdWxQ?=
 =?utf-8?B?M2JJaGo2TUZ4UjdJdWkzSGFJQllkaTlMcFVVQUwyMjFGTU5KbGZlS2xVbHQw?=
 =?utf-8?B?NTV1bnd0NzA5QmhxTG51bllreUZGV0s5RUhWTmNibHpHZXB5M3RVVkNRMWpi?=
 =?utf-8?B?TmRtaVFCQWtlMlhUcmo3UjVZRlpHWDkzSWtyYlJVRDlnU2VFei9CWkdqaEht?=
 =?utf-8?B?MFdJQWNBZzI5U09naDB5by9HVzk0VFp6OGQ4UFpxRU5hb0xjRUwrZ2hjUUlP?=
 =?utf-8?B?TTNWY0Q4eFIxMEtrNm8zZE5qMzNzMWVmeFFleERkN3Y4dUFMVmdKQnVpamRr?=
 =?utf-8?B?RTNrVWtFV3ZYYTFyWURWQ0x4cmd4clR4Zk9YY0MzK25lcGNlUWRiMXZzRGNr?=
 =?utf-8?B?Uk8rKzlIZm5IdjFtcWhsS0R1Mm9hY1pZaU55SDZpL1Q2a1JzcXhCWitIVHFv?=
 =?utf-8?B?cDZOMlBQYVVmVE5iOW00SDFPV1JWSzlNVnlJT0dJVU5hVHpYOFlpR0VTTmVS?=
 =?utf-8?B?MmJpaHgyZGdqVlZNSmdnR09icUV3UTlHUld6NGpJQjVIbFBiVTlyR1ZjWWk5?=
 =?utf-8?B?dXlaL2g0bFpNRjdPS1ZUb3V3VjZsNDdzWGVsdFg4MUFMWTRtNkFyMXpMZ0VQ?=
 =?utf-8?B?dE16ZlpOVGFmK3czWUVzNmEvV3E1S0V2alpONXVERGlGcGRHaUdUS0dpMXlI?=
 =?utf-8?B?ZDJNcjVmZzBud014OEd6cDVaQXlKM1pGdFhQYTEzdW4xT1V2NCtLb2pVSFBn?=
 =?utf-8?B?d3FmOW1SZi92dnFCN2RuSHJqT3BDdWljKy85SllvdDFZTmlLRktUU0NONUQy?=
 =?utf-8?B?YXhhKzlQMmxwWDM0a2dMM3I1citzSE5xUVZEMWlnNmlLM1RkVk1xY1FYM1FM?=
 =?utf-8?B?QVFidjF1ajUrMk9LaC9lbE9EQy95S1pQaGhOT1Q4R0RpOEY0N0NVZDJqSENI?=
 =?utf-8?B?MGViVnlubmVzZ2RpS3I2RXBZUEdzY3pxTTJ0dEk1akovSk56bklLRWVQUFNU?=
 =?utf-8?B?WVBuMFZvY2RTU1ZDMVArSWIwU2lkcWg1ckRUWFh6SlBPUzhGRWM1TzRSb25S?=
 =?utf-8?B?K2d1Q3N1TzFSSzdkRk5PTlFLakQ2RU5hRVpjUEU4b3RjdXQwN24yczhaZlZS?=
 =?utf-8?Q?DAQgvF/49LqcAeL+aw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f392c6e-9711-4853-735f-08debafe4531
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:10:38.0715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X8WWLS+EVAhzpmwgIu962K08HiJ5U3IjFegb2IkJTsPK0B1FXwokjy2eDY1Knbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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



On 5/25/26 13:33, Timur Kristóf wrote:
> UVD 4.x and older can only access MSG, FEEDBACK buffers from a
> specific 256M VRAM segment that the VCPU BO is also located in.
> We already modify all placements of the given BO to ensure
> the BO is placed within this segment.
> 
> Previously, it always assumed that the VCPU segment is
> the first 256M of VRAM, even though under some conditions
> the VCPU BO could be allocated outside this segment,
> which made UVD non-functional as the BOs were
> not inside the same segment as the UVD VCPU BO.
> 
> Solve that by using the segment where the VCPU BO actually is.
> 
> This fixes an issue with UVD failing to initialize on SI/CIK
> when resizable BAR is enabled and the VCPU BO is allocated
> in a different segment.
> 
> v2:
> - For other BOs, keep using the same UVD segment as before.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 33 ++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 1e59ca924abe..480bf88def46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -135,7 +135,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
>  MODULE_FIRMWARE(FIRMWARE_VEGA20);
>  
>  static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
> -static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
> +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *abo);
>  
>  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>  					   uint32_t size,
> @@ -158,7 +158,7 @@ static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>  	amdgpu_bo_kunmap(bo);
>  	amdgpu_bo_unpin(bo);
>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -	amdgpu_uvd_force_into_uvd_segment(bo);
> +	amdgpu_uvd_force_into_vcpu_segment(bo);
>  	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  	if (r)
>  		goto err;
> @@ -550,6 +550,24 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>  	}
>  }
>  
> +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_bo *vcpu_bo = adev->uvd.inst[0].vcpu_bo;
> +	struct amdgpu_res_cursor vcpu_cur;
> +
> +	amdgpu_res_first(vcpu_bo->tbo.resource, 0,
> +			 amdgpu_bo_size(vcpu_bo), &vcpu_cur);
> +
> +	bo->placement.num_placement = 1;
> +	bo->placement.placement = &bo->placements[0];
> +	bo->placements[0].fpfn = ALIGN_DOWN(vcpu_cur.start, SZ_256M) >> PAGE_SHIFT;
> +	bo->placements[0].lpfn = bo->placements[0].fpfn + (SZ_256M >> PAGE_SHIFT);
> +	bo->placements[0].mem_type = vcpu_bo->tbo.resource->mem_type;
> +	if (bo->placements[0].mem_type == TTM_PL_VRAM)
> +		bo->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;

You need to call ttm_bo_validate() here.

Apart from that looks good to me.

Regards,
Christian


> +}
> +
>  static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
>  {
>  	int i;
> @@ -600,13 +618,10 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
>  	if (!ctx->parser->adev->uvd.address_64_bit) {
>  		/* check if it's a message or feedback command */
>  		cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
> -		if (cmd == 0x0 || cmd == 0x3) {
> -			/* yes, force it into VRAM */
> -			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
> -
> -			amdgpu_bo_placement_from_domain(bo, domain);
> -		}
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> +		if (cmd == 0x0 || cmd == 0x3)
> +			amdgpu_uvd_force_into_vcpu_segment(bo);
> +		else
> +			amdgpu_uvd_force_into_uvd_segment(bo);
>  
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
>  	}

