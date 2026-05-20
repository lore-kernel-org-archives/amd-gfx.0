Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77920CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 12:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D271910E40A;
	Wed, 20 May 2026 12:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJi0XTwg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B1D10E40A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 12:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2ihb42QaFAuHq/25EcQMuH10BgF9bk68qp7ZNlchovJTEECaMuA+3UaX/GlWJrxwK1S7ONKGvG+Sjo49DSvXqH3Pq4hxmA1OOa2ZnDeJKJejxjqJkKVpiYJCi+Hd6Pg1MMidGoAnzspKOcAZZ1Ep8PAH0dmcD6oqtiimnQ11iB/P1O7gMWJ1eO1cX9jwj45m8NqDi3cbTqpB9TLbF0OgmSvEQB9t84zsU2jreVUb2r+G7eZbfLyYJIuXzA5Qp+cxwrrXV1bgpEuaYjyk7/3bnlVDMM2YIk7h40DH9nFaa9xDbalL3+0pCOC5OiHUUZ+wt5HRO3WYiPYJnwyoj2Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5VhsKraXl/yZ42swpnP35E1QXM30CG2G4ByQlm+Kuc=;
 b=LJzDHnCdoA+nVv0+ruXkMkrqv1Cx5V8CTVujuWnRNiaK9PSDWYXwUYK3Uc5JAy0JthV+VVyY2L6vvNINYAgQUpTaYR7NjWAqGVjPNkMF/lRq0HM2rccJ12Fn7+Pb8mgg+QuwCFa3vWmdNC/+c1CxEOjWWdCnX3aqECXm7QLD8MoUd3sFZMBugwiSOatKJiH9lzaIwDKQWaa6K1lQT8Mu03MKY5zhKu/XCNfkWCc8D1JwaLQZOyVgCNEr14frNiWKSMhgGoKJYXfyFDEtWeOkIV1C5491UV7T5AAhIkUxJGcE0nKEuDer9JE7g3CJMQuUOxcynm8C8BYlQg2Qvox3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5VhsKraXl/yZ42swpnP35E1QXM30CG2G4ByQlm+Kuc=;
 b=xJi0XTwgw+pwAfTyvvjzg26lLBjAIGYfVNev/A6Ycb9WKGW+id6XcXP76O9lioGa162ynLoeIjXe0JDufUtkHf6mOHFuw7saEM7tdPLcsWhH8hy569n9ZkLhTfTLrPG4fj4HxdGncs2NQVfWkh2drO9FYOBkebZ95A9vP3jsGgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 12:21:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 12:21:31 +0000
Message-ID: <45dfc2ce-5e75-420f-b96d-a07ac9e0f223@amd.com>
Date: Wed, 20 May 2026 14:21:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/userq: remove
 amdgpu_userq_create/destroy_object wrapper
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520121019.2581398-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520121019.2581398-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca64286-3b1e-4f2d-ea66-08deb66a52f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: NmtrmgG3LaFTkzOLL8TMoeh3RUyPpJnOdd8J57Nl/goI5HH4n8dSSSYWTN4WvrCR/F4KDKjLtmsvGfAzjKR5PvOSPSTEeoMs9znQ6xI/FauzbD0kQojNmVLdmchKY+hJPjNryS5Alw1agLvtf1kvGjWjGI6oZkmSgqXPXyrJVPwmv932Gvu1qjqg42rtB79H093hNtWtQ2usjlz3KduxDqaoady20puOlc8Np4tMxIuX/ti6Fl8j8JQdOPUiC8IgoiQG4nArKCxAWig9vdOgVFaICwO7ilg7g9qXmcEcMCeyr2XUBHBv5yYkfZNUzKYgKy2hrQwucPXjs58Z4xTbSUeFlBpd46VYP8ifrvWeKhX3QMY1kBHmTJvJprzmcF+svaIrX2WLuYAgM8F0AyU0FkbV0ls24DRr+e5ZYjZwulBGLLrwMbCFR6qoVdyYpHXScryCKFb5RqbEdZTikXBIUWiHf03s+o0t6Hl31Ri8UIOQSgLbAdi3fzb2NpFvTWTTSf2qdlJkQzA9ACbiOo41IdO+2e1l2dTHoj/+OicIJxVHA61VWs5KkPjIdV2aUS7VOGMmIOyX6muO8oB6l72An/DcQH5RlWAovq7cdeqyQBSBNhN2dCM2QJvpVmN+8Gz6YSrA+nBYmJk16aY387l3+K8V5WrP+kJybJScellzbI4L5IKBTdn1xCwzk/0xbRXw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmIvWFlmZEZYM1lqZDhFcTNWOUVYR01jL0g0T0hkdDF5OEg4cUNjdFVsYi9r?=
 =?utf-8?B?OUxZS0RjSXJ6UlpoWGpmT3owKzU3Zlc5VDJ5WEVQTUpIMHJXcWQ0ditFR2pO?=
 =?utf-8?B?L0tRQXc4WWNxMTZSWWRnSEIvV1FESldQaWpsK1dzTTRBMHZzZ0ZYakdsTHhN?=
 =?utf-8?B?V2VsVm10SzZrcWx0cDh4aUxDZnUrUTkyRy82Q1M1MzVCMUtDOXovWmNVNDdJ?=
 =?utf-8?B?Z0kwRFBwVi9TbVFWSlNlTnY2V3RxbklRYS9IWWlTMXhNN29zNmJXNVNZRCs3?=
 =?utf-8?B?V2xxWWh4SVB6bGUxK1A5RUhyTkhNVHptdjU4Y0g2dnVDRWNvckxtV1FQMWNr?=
 =?utf-8?B?WUxnWTZGVUlnS1NQY3RGSDRxaUVOK09hQWJhU2Nmb055M3V4SzBWZ3AvVzZw?=
 =?utf-8?B?dC8yU1RxVjFrd2tobzZVcE8vaE55Mm8xUTJVdlkyNTQvZDVCcDFVRS93U1k5?=
 =?utf-8?B?K3U2TGU0Q3hxSkdScWwvUktDOWFsdmxXVzNrYnJCczBjV2FyWU1SZFF1eVZM?=
 =?utf-8?B?OUlaSm01RktxbVZkK0QwdjVkSTg3bmdjVmsrUGw5cGxHZkMrWkxxNlplbE9T?=
 =?utf-8?B?dHUyd1NjNlgrU0NHdWk4NnMzYVU5Q1llS3M1S2pScmFGWCtLaU9tWll5eVov?=
 =?utf-8?B?MVM2V3A4NWoyTTY0NCtxcThiNGp1KzgyS05QeGYxTWJCbld6SVNMU09WYWJG?=
 =?utf-8?B?eTBZdEUyRmE4ZnZ0Q2RjU1dqSWJGVVRPVG5FVWJGTU4xUlRYcHRVMU5pR29B?=
 =?utf-8?B?REtGWFdKSEpUdko1dzA2bHBERmxLUm5xNHpQb0JsdmM5NnF4ZFZsTGtUT2V1?=
 =?utf-8?B?eW15WVlBNDc4RnR1WFloZm5PRHNtaWIxL3hTdGlOb2c2T2RxSXo3YXBhaDZU?=
 =?utf-8?B?RmRNbHpjM0dlaHByRFJuRU5HVldDRTFOdHh0Sk5RUWFhSk1RS2tMM0xWWEE0?=
 =?utf-8?B?eW5pYXgyK0RjeUxIdHl6UTc5bFZLRGVPTm96U3hMVUVOUEFEWHZxU2dyZXdk?=
 =?utf-8?B?blFGVmVQUURvR2EvV1hLRVlZRW9jbjBBUGZZZnRXOUoxTy8yaTM5U3N3VXV1?=
 =?utf-8?B?MU8zSENKc2tTZjd0QXR5Zk50NEpieGdKRXhYZUxTTTFCTkF0REp4dDJkd1lD?=
 =?utf-8?B?bzZkdFFmU01QbDRFazExbEdya0tncFB4WlVhNGpXOW9tcHVsU3FoZmZmM292?=
 =?utf-8?B?TXRGTkx2elhOUHB6Ym5tZ1lBMFNBYjRrTklKYVBEVjdRMVcyQTVhemlpMmQ3?=
 =?utf-8?B?MGxRUFd4SWxNLzAxUDR0ZDNDMUpXdzNzUGJ5VjArd2NyOEY3V09uZkdqWkgy?=
 =?utf-8?B?ajFXWk9mV2NnNDFMVFlPK25LSXpoYlhCL25ob0J4dnNPMXFCTjdLenExcys4?=
 =?utf-8?B?bzFRbUlCdG1ySStHbFloTko3RStqT2xlVTg3MXhjUmRBbTczeXhzaytLSmgw?=
 =?utf-8?B?YzdRWWRqbTJNWW41aG5MaWNwQzIzQU9RY2R5WHptbXZMcXdxLzhxTU5EQkM3?=
 =?utf-8?B?aHhZRkxjYW5IdXI2bEZiODdHWXJldThlbzNUTTVibFlkK1hVTnZCWnU0eExM?=
 =?utf-8?B?c3V2UFZQdFFXVFRlWGxDbXZ5VmduME82TVBGUjAxRk5yOGdRSENRaVhSR3lU?=
 =?utf-8?B?ZGd2QU80V29nWTFBM1NubWRTaW9IVkhCTjZIUVo4Zy9uTjhDUXN0MFpTakM2?=
 =?utf-8?B?L1Q0TFdOOUNEaXVXT2UrT1U1Q2tXR3Y5VTlOSTNZZ1ZqWnZsU2kzMW11a2VB?=
 =?utf-8?B?bS9YQkFLdUs5dnAzUVVnYnhSRTRhOFVORzFiWG1NRWwvNUdGUHVuZFc0Y0RV?=
 =?utf-8?B?R1ZmYmhteTVBb3JXMVUwbnBjZ3lxVk8ybTdTU0ZDMFRpY0RPeVVsMlVwaXNt?=
 =?utf-8?B?NzVMQzY5THhOMzFFK2pmbi9iaTk0Y0hQS09Gd216T00xOTgxSEt4U3BhS1l2?=
 =?utf-8?B?MmgzRVhCK1FNbnFHeHRrQ1FGbmMxWVJ4YW1iY0MvblZnZXFzaFE5V0hMcy9j?=
 =?utf-8?B?Y3Zkb3N1cm1HZmZQTFNOaUM1UlFmWlhCYjAyTjF0ODdoS2hpYStuSjBQc1Nj?=
 =?utf-8?B?eUdqVERiYXp1TER6ckZsTFMrbjJab3FRRFJWUzk1S3k0eGwwZlpETlZ4RkdL?=
 =?utf-8?B?ZDlkNkZuZldXMEExV3FwUm8ySVIyb2gzRWJIVXlqRDVMcHoyTFd1ZFhqVXk4?=
 =?utf-8?B?blhUU1hxUlZVUCtaclF1REhrbFQzK1NwczRGUlFoUEkrQ1FzWFRxaGNpQjdD?=
 =?utf-8?B?UEZPYTQ3eHVQMVRvVFVGU1JleDlSZjNzcHlRQitCRS9sdzVZK1NuZXc0WGJo?=
 =?utf-8?Q?gMGFZ4GJ2RrzSZ1IVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca64286-3b1e-4f2d-ea66-08deb66a52f6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:21:30.9387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97kA8Wf8XQ6d/bBidapXjqxV/Iesy+DnJDmIXL3i6+0ulKXagL7QxDyJW4CX/jHe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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

On 5/20/26 14:10, Sunil Khatri wrote:
> Remove the amdgpu_userq_create/destroy_object wrapper functions and
> use directly the kernel bo allocation function which does all the
> things which are done in wrapper.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

You may want to remove all the PAGE_SIZE alignment and just replace it with 0.

The alignment here should reflect the requirement of the GPU HW, but I think we unfortunately doesn't know that at the moment.

Aligning it to a PAGE_SIZE so that it is CPU mapable is the job of the underlying allocator.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 67 ----------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  7 ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 29 +++++++---
>  3 files changed, 21 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 798998d65e17..eaaffcdd6960 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -465,74 +465,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  	dma_fence_put(ev_fence);
>  }
>  
> -int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> -			       struct amdgpu_userq_obj *userq_obj,
> -			       int size)
> -{
> -	struct amdgpu_device *adev = uq_mgr->adev;
> -	struct amdgpu_bo_param bp;
> -	int r;
> -
> -	memset(&bp, 0, sizeof(bp));
> -	bp.byte_align = PAGE_SIZE;
> -	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> -		   AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -	bp.type = ttm_bo_type_kernel;
> -	bp.size = size;
> -	bp.resv = NULL;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
> -	r = amdgpu_bo_create(adev, &bp, &userq_obj->obj);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to allocate BO for userqueue (%d)", r);
> -		return r;
> -	}
>  
> -	r = amdgpu_bo_reserve(userq_obj->obj, true);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to reserve BO to map (%d)", r);
> -		goto free_obj;
> -	}
> -
> -	r = amdgpu_bo_pin(userq_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> -	if (r)
> -		goto unresv;
> -
> -	r = amdgpu_ttm_alloc_gart(&(userq_obj->obj)->tbo);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to alloc GART for userqueue object (%d)", r);
> -		goto unpin_bo;
> -	}
> -
> -	r = amdgpu_bo_kmap(userq_obj->obj, &userq_obj->cpu_ptr);
> -	if (r) {
> -		drm_file_err(uq_mgr->file, "Failed to map BO for userqueue (%d)", r);
> -		goto unpin_bo;
> -	}
> -
> -	userq_obj->gpu_addr = amdgpu_bo_gpu_offset(userq_obj->obj);
> -	amdgpu_bo_unreserve(userq_obj->obj);
> -	memset(userq_obj->cpu_ptr, 0, size);
> -	return 0;
> -
> -unpin_bo:
> -	amdgpu_bo_unpin(userq_obj->obj);
> -unresv:
> -	amdgpu_bo_unreserve(userq_obj->obj);
> -free_obj:
> -	amdgpu_bo_unref(&userq_obj->obj);
> -
> -	return r;
> -}
> -
> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -				 struct amdgpu_userq_obj *userq_obj)
> -{
> -	amdgpu_bo_kunmap(userq_obj->obj);
> -	amdgpu_bo_unpin(userq_obj->obj);
> -	amdgpu_bo_unref(&userq_obj->obj);
> -}
>  
>  static int
>  amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 033b8a0de6b1..76ef5cfab52e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -151,13 +151,6 @@ void amdgpu_userq_mgr_cancel_reset_work(struct amdgpu_device *adev);
>  void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>  
> -int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> -			       struct amdgpu_userq_obj *userq_obj,
> -			       int size);
> -
> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
> -				 struct amdgpu_userq_obj *userq_obj);
> -
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2d95203ec58e..ebd4e90cce63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -192,12 +192,16 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>  	 * for the same.
>  	 */
>  	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
> -	r = amdgpu_userq_create_object(uq_mgr, ctx, size);
> +	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, PAGE_SIZE,
> +				   AMDGPU_GEM_DOMAIN_GTT,
> +				   &ctx->obj, &ctx->gpu_addr,
> +				   &ctx->cpu_ptr);
>  	if (r) {
>  		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
>  		return r;
>  	}
>  
> +	memset(ctx->cpu_ptr, 0, size);
>  	return 0;
>  }
>  
> @@ -270,13 +274,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		return -ENOMEM;
>  	}
>  
> -	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd,
> -			AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
> +	r = amdgpu_bo_create_kernel(adev,
> +				   AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size),
> +				   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> +				   &queue->mqd.obj, &queue->mqd.gpu_addr,
> +				   &queue->mqd.cpu_ptr);
>  	if (r) {
>  		DRM_ERROR("Failed to create MQD object for userqueue\n");
>  		goto free_props;
>  	}
>  
> +	memset(queue->mqd.cpu_ptr, 0,
> +	       AMDGPU_MQD_SIZE_ALIGN(mqd_hw_default->mqd_size));
> +
>  	/* Initialize the MQD BO with user given values */
>  	userq_props->wptr_gpu_addr = mqd_user->wptr_va;
>  	userq_props->rptr_gpu_addr = mqd_user->rptr_va;
> @@ -432,10 +442,12 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	return 0;
>  
>  free_ctx:
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	amdgpu_bo_free_kernel(&queue->fw_obj.obj, &queue->fw_obj.gpu_addr,
> +			      &queue->fw_obj.cpu_ptr);
>  
>  free_mqd:
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
> +	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
> +			      &queue->mqd.cpu_ptr);
>  
>  free_props:
>  	kfree(userq_props);
> @@ -445,11 +457,12 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	amdgpu_bo_free_kernel(&queue->fw_obj.obj, &queue->fw_obj.gpu_addr,
> +			      &queue->fw_obj.cpu_ptr);
>  	kfree(queue->userq_prop);
> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
> +	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
> +			      &queue->mqd.cpu_ptr);
>  }
>  
>  static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)

