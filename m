Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C598C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 10:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C265410E637;
	Thu, 21 Mar 2024 10:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kr+J/7qk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3813E10E644
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 10:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOr7A6i+kxZpe9xBHCXEHj1Ya3S0Zm50rc1frKJXYfjQ15N8FNsTu/MXun4mt8dp9javP8GIAQaxDyr0ds5ioCfnWqNCJ2jU/y6AkUCJ0ZnAIxu5VifGYbCk19+yOXt5BbUQV8uvJcZKdqlbs0RzZXi3a7cQLHRrK41olJr2pL7u6DitDCl1Zn30TRA7zU7dM8+lkUqFbVfPDsdiufwsxYSgnTrcbcg7TrW2oEqY/wKYgmtBxHm0Z1xJCdaE2j6GRBgw0gKo91qzxDJs7zTQ9O+BmVxFs8/rzPGw7yURiN5VnxFgOYMAVhuuN6/5ezluSJ61OY2vJ5gx+YpR5ZrzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nztAJ2nG5W8AEegWRAf4orXZkdBaSa6re/RAO2ua+LI=;
 b=MoXcoq1jfRMaxOEKf6WKdoCWCeLHgRx7emOKMvwKKBSJPmDCOJhtQzUtWFSe1UTR160FcDaoegkA+6IUKPnxyW4dtfW+qnAokCinvhONRs5XhhQr2nUfvAGFfkMcNvZv88TgE6rcxWrcIIwHCBJ1QvJ0MQkULPjiJUGvm+5dXCoa0jaNWcrz4I22Xfwn59ZmWnKeLvyH6JBCi3RRwqBu5cLP2XHfX6vSzA8HBnPDnVQX/QL/OuaxtqgJuA3cD6SnIn36ipjgM7NRS4GCTx225jsIuLEEQBXDw65IJKp6JO41iUJLwt/rXMUslc3TO+LugSPf5lZKBjNPjsm2sOFOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nztAJ2nG5W8AEegWRAf4orXZkdBaSa6re/RAO2ua+LI=;
 b=Kr+J/7qk6duQa1t7PU/6iuJqpKniIw3M6gcWMKKZ6zWBsbsO9S99z7fCKE0l5UnpIdXtCyoffzeFmZK+hB1aNHnWsIapFrQPzsXIFf0rnAofCs7WmCWaNwbEgWRbLpEnOYGZ6grpEncfFEgGGXz3/euWm0u6y/wayugwcE8USzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 10:25:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 10:25:57 +0000
Message-ID: <9520bc6f-669e-4724-8fd3-3bf8c36bdcb0@amd.com>
Date: Thu, 21 Mar 2024 11:25:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix use after free in trace_amdgpu_bo_move
Content-Language: en-US
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Beyond Wang <Wang.Beyond@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
References: <20240320144038.46706-1-tursulin@igalia.com>
 <20240320171216.48248-1-tursulin@igalia.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240320171216.48248-1-tursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b34fb7-bdc3-434e-5c0d-08dc49914c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPdW8CdW+X5q3z5FEQzpXLE37aav06hPj4SfJfdzIopc9ZMT+arHDS9UHl8R3A0Hqlz8Ws7PflIJgD77wjoVKkATI6i26GL6DQmC41WPj5fTE0Gss5w0dX95Vns2Kv66B5CECPIleKeyUQZ2SuVcnDCNHNcrFVq55/aEzYGo3Ba9oM80uqBBXEuS+iqIWKC3Eh+AreiJYd8cMR/hkgMdQ73ri9QoY+wn711RZlRMmOMjBDOxLZlftWWvBwE1jM2s53l6ZEjYY753fg1pcBbx0CSDSb7IJF+R5AzGK8+bVj6mvgqFlOfWSBi9XfYZn+VfpPyTckaRamMLEYOhPi2iHxvdXxx3/CI7mZlr+57vSupWDOpbshwPSEpWFTbMOEV2UAs8V7UVgqUeOYIfB8IhRLbTZsZaDZHSDv0oznBt5/GY3zFjAhfhYJ9TUeFdtY5eItDs6XgSxGPm2C8WmVdMG1IYj7gyLSixgdypdi1+Q2xznF5NhTqmSLhfhdppR+8PPe4dkaD4rqc7beUM6g8rU9yXiqfw7cQHAFKmPwrYQjpzGUVuBqqZZGNYjY8oQs65d7oTzZfEErT4PhPLzC4J3taYa9IiPLFHwELbpV+N1ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBueERjNEhEV0tZNXF0dnI0ait4SFVFQWNhM3NsL3VlOHhDWGZ3MG1JNDgx?=
 =?utf-8?B?c0lIYWlDekFDdEVCeUIvRmZlMU90VStlYk12Z3lnS0h1WWUwT21Da1VmRmtp?=
 =?utf-8?B?VDRMdUhGcGQzSXhPbDgyWlZnQ3Z5dUM3cnhub3FjR2c4M3lEVGxhS1ROYytF?=
 =?utf-8?B?OVplN3NGQ0pJMWhIWDYzNVBIQVQ1b050eGR3TGRxSkgvK0NaZlk5b1M0d0gw?=
 =?utf-8?B?WWhxOGJ0YVY0MWR6a3ZkdUg3YnY0dE51UTlYNE8rb2hOU0lZM1Z3KzFxMU11?=
 =?utf-8?B?cGNtalMySG5WZC9mWWtzb1lkMGE0QjExVERacWFlcWovcGVGeFNaTUdFcGw5?=
 =?utf-8?B?cWRDYnN2Q0xaTEFhMVdUbUV3NTQ2MFBBamRLOGNMVnZvc2FlNVpyNlZoTjlS?=
 =?utf-8?B?dnVNMXBucjV4K0pvclhKTmw3Vld5b0lIUUhXQS9WVlpqUFRtckhEdnd1RVdO?=
 =?utf-8?B?WWVhOG9LMmU5bUFQdEFrSFBrTU1UUW9TVjZZZTB0WGhYQTBjakNmd0Y1SFh0?=
 =?utf-8?B?c1lSTEtadWxPQ3hLZWVqdXN5L2NRcEZZQVQ2UEFyY2VWKzhmNmZvcnYrc25I?=
 =?utf-8?B?RUlmV1FEMTUvbEsxUVBPdmdkdWZCSmgzMTNDdFpDK0FQZElaaWlycFlqSUcv?=
 =?utf-8?B?VGx6dUlxdzNHR1pCaHVBSDJyRktCYWpyS0UzSk0yYWc4dk5oZ2cwK1dzR1N0?=
 =?utf-8?B?WVgreGRWVHNuRWNudXQxMGFMeHZSMk4wQlV1djR3Q0gyMXNVMVdOY0g2T2hu?=
 =?utf-8?B?dUNEQWh4TVh1UXphS0FWdkFmTkhCTlVwZVdlWE1ZdnZCVjlTZ0JUT2hYSFhR?=
 =?utf-8?B?TDl2ZTdmYUwxWlo0MXhYMEtiVWJZR1FUa3NoVndPVUJuMjRzbFQ5RzRlT01Y?=
 =?utf-8?B?TDRpdGtSOE02Qnp1RktCTnE3SGxveG04ZGhvYlYralU2cTF6MGRMYlN4YXJu?=
 =?utf-8?B?T0wyMXNobWpQZVAreS9tSk9oVjlFVzdxdWsvcmUydlRnMCt5bXcweGtKSlRr?=
 =?utf-8?B?RGVvRFA3SXFTTEN1VXBBZVJNUVZ5VjMrL09EeVV0V1VNb0NwTWtiMnk0dmJv?=
 =?utf-8?B?aE5HSTc0d1Y2THVtL01sYTkzbHF0ZmVwY3ZNa2tYSC90SU9EYXdsYlJUSkxv?=
 =?utf-8?B?QmtWS2RhY01waHZ2NmQxSWRidTBub0Y0WnF3SlFaSGhSMG00RTVOWmVhclpm?=
 =?utf-8?B?Wjk1YlVXWkROV2Z0UVlERmNicVB1b3dWNGpqSUV4dDhyUFJDSy94K3plZ3o1?=
 =?utf-8?B?R1FKOGVRL2FHNVpZQ3JrTEZSQzFXdktDNDZYaFpMaTdGRHg0dGhENWgweEVm?=
 =?utf-8?B?cmp3SndnK2hrVlRTZXRhNmRCTUJDeUF6WmxWaDJ5a1JJSG15UWZjKzlJTWll?=
 =?utf-8?B?eGNSRG1OckJ3Rmt1eHNIRjlnSVYyTEVkZnFxQnpvY2dpUDRvVzFsVTBWZlMr?=
 =?utf-8?B?UXhKK3N4N1BNaXduQ1NwdGYzNW9pQSt2aDNxNzh6MExWdkVQdjg4eWZSZXBJ?=
 =?utf-8?B?YXZOaDltaTBXUm13U2pDNkhMVk9qRkE4dnRwTzdhUVc1L0RsUzNvSzg0SmtQ?=
 =?utf-8?B?TVFqMWFucGszWFJ0MnVFY085YTdIanEvS1NOd09ldUloT1JsL2ZUMWdJN3hq?=
 =?utf-8?B?MW5abDhIOFowdUpIQkRYQzVPamcwUlhqRW1PMWR3VytkQm9HY0I0T0phVmY1?=
 =?utf-8?B?QkVJK00xcmFIZTN1eWtid0Nsb1pYcTQzQkg3TzN1bSs0NkxzdXhNaVYwMnI5?=
 =?utf-8?B?UWJQLzRkYnBFNW45Z2l2ckVDMkVCMm0yN2ozbjhGZnR1YnMzaVFRejQyLzlT?=
 =?utf-8?B?cGVzT0o0R3pMUCtuWERLVUZWRlFnOGt5ZXRHdXhQbk83L0N5MVAwM1NxUkp2?=
 =?utf-8?B?eEw5QUJLS05Dc0RFTExJK3B0aU9LV3RXdlpGeXl6TGVIRDh4cVMxcnQvN1lD?=
 =?utf-8?B?VXJJMGxZY3VHSFlSdTQ4Q0M2NmtISXZpd3N2SlRyajV0VnVXU1pzQ05QdnFG?=
 =?utf-8?B?QWFWeGJlcXBUVU11eXJ4R3NTeUVNV3hpMkJTVUNRdDJoSzgzTlFXVFl6c3pU?=
 =?utf-8?B?Z2EzOGw3QkpKTGJUemJMc1dRb2QyVmlLWWp1N0Zlem16a3VIUU5yeXZRNFR3?=
 =?utf-8?Q?hIVonyY87Q4tiQhccVH6DbP+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b34fb7-bdc3-434e-5c0d-08dc49914c31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 10:25:57.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y6c9mVwp8VSijOZuzqXYg6ANaJLO/l3DKDJnc2cxSHSsJRy/7Xh8yQhjJ8ki4hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

Am 20.03.24 um 18:12 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tursulin@ursulin.net>
>
> Pipelined object migration will free up the old bo->resource, meaning
> the tracepoint added in 94aeb4117343 ("drm/amdgpu: fix ftrace event
> amdgpu_bo_move always move on same heap") will trigger an use after free
> when it dereferences the cached old_mem.
>
> Fix it by caching the memory type locally, which is the only thing
> tracepoint wants to know about.
>
> While at it convert the whole function to use the cached memory types for
> consistency.
>
> v2:
>   * Fix compilation.

I do remember that we have fixed this before. Question is really why it 
shows up again.

Going to investigate.

Thanks,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Fixes: 94aeb4117343 ("drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3171
> Cc: Beyond Wang <Wang.Beyond@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
> Beware this is a speculative fix for now based only on source code
> analysis and backtraces from 3171. It is also a bit on the churny side so
> I am happy to minimize it. But most importantly, given how I don't have
> any experience in amdgpu, I am looking for domain experts to either
> confirm or disprove my analysis.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 47 ++++++++++++-------------
>   1 file changed, 22 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8722beba494e..81189aab5a04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -452,10 +452,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	struct amdgpu_device *adev;
>   	struct amdgpu_bo *abo;
>   	struct ttm_resource *old_mem = bo->resource;
> +	uint32_t new_mem_type = new_mem->mem_type;
> +	uint32_t old_mem_type;
>   	int r;
>   
> -	if (new_mem->mem_type == TTM_PL_TT ||
> -	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
> +	if (new_mem_type == TTM_PL_TT || new_mem_type == AMDGPU_PL_PREEMPT) {
>   		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
>   		if (r)
>   			return r;
> @@ -464,20 +465,18 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	abo = ttm_to_amdgpu_bo(bo);
>   	adev = amdgpu_ttm_adev(bo->bdev);
>   
> -	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
> -			 bo->ttm == NULL)) {
> +	if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == NULL)) {
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
>   	}
> -	if (old_mem->mem_type == TTM_PL_SYSTEM &&
> -	    (new_mem->mem_type == TTM_PL_TT ||
> -	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +	old_mem_type = old_mem->mem_type;
> +	if (old_mem_type == TTM_PL_SYSTEM &&
> +	    (new_mem_type == TTM_PL_TT || new_mem_type == AMDGPU_PL_PREEMPT)) {
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
>   	}
> -	if ((old_mem->mem_type == TTM_PL_TT ||
> -	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
> -	    new_mem->mem_type == TTM_PL_SYSTEM) {
> +	if ((old_mem_type == TTM_PL_TT || old_mem_type == AMDGPU_PL_PREEMPT) &&
> +	    new_mem_type == TTM_PL_SYSTEM) {
>   		r = ttm_bo_wait_ctx(bo, ctx);
>   		if (r)
>   			return r;
> @@ -488,22 +487,22 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   		goto out;
>   	}
>   
> -	if (old_mem->mem_type == AMDGPU_PL_GDS ||
> -	    old_mem->mem_type == AMDGPU_PL_GWS ||
> -	    old_mem->mem_type == AMDGPU_PL_OA ||
> -	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
> -	    new_mem->mem_type == AMDGPU_PL_GDS ||
> -	    new_mem->mem_type == AMDGPU_PL_GWS ||
> -	    new_mem->mem_type == AMDGPU_PL_OA ||
> -	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
> +	if (old_mem_type == AMDGPU_PL_GDS ||
> +	    old_mem_type == AMDGPU_PL_GWS ||
> +	    old_mem_type == AMDGPU_PL_OA ||
> +	    old_mem_type == AMDGPU_PL_DOORBELL ||
> +	    new_mem_type == AMDGPU_PL_GDS ||
> +	    new_mem_type == AMDGPU_PL_GWS ||
> +	    new_mem_type == AMDGPU_PL_OA ||
> +	    new_mem_type == AMDGPU_PL_DOORBELL) {
>   		/* Nothing to save here */
>   		ttm_bo_move_null(bo, new_mem);
>   		goto out;
>   	}
>   
>   	if (bo->type == ttm_bo_type_device &&
> -	    new_mem->mem_type == TTM_PL_VRAM &&
> -	    old_mem->mem_type != TTM_PL_VRAM) {
> +	    new_mem_type == TTM_PL_VRAM &&
> +	    old_mem_type != TTM_PL_VRAM) {
>   		/* amdgpu_bo_fault_reserve_notify will re-set this if the CPU
>   		 * accesses the BO after it's moved.
>   		 */
> @@ -511,10 +510,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   	}
>   
>   	if (adev->mman.buffer_funcs_enabled) {
> -		if (((old_mem->mem_type == TTM_PL_SYSTEM &&
> -		      new_mem->mem_type == TTM_PL_VRAM) ||
> -		     (old_mem->mem_type == TTM_PL_VRAM &&
> -		      new_mem->mem_type == TTM_PL_SYSTEM))) {
> +		if (((old_mem_type == TTM_PL_SYSTEM && new_mem_type == TTM_PL_VRAM) ||
> +		     (old_mem_type == TTM_PL_VRAM && new_mem_type == TTM_PL_SYSTEM))) {
>   			hop->fpfn = 0;
>   			hop->lpfn = 0;
>   			hop->mem_type = TTM_PL_TT;
> @@ -540,7 +537,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>   			return r;
>   	}
>   
> -	trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
> +	trace_amdgpu_bo_move(abo, new_mem_type, old_mem_type);
>   out:
>   	/* update statistics */
>   	atomic64_add(bo->base.size, &adev->num_bytes_moved);

