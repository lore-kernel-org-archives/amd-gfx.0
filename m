Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694FDC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 09:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7B310E33F;
	Wed,  1 Jul 2026 09:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5imb2Ub";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010020.outbound.protection.outlook.com
 [52.101.193.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465B810E33F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 09:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDb3meUCiKxOvDrIi0beIEGp3yzeSZMBs8l3bhasQUJp1bjPJsvGFRax5o1+w+UoSgPCKHGAt0VZS7rib9H5s+r5KhXe1c3uheSJCPlokZSdYiZk62zna7yaM0gpECSr12CbHEgb56odomqfG6AmfRQyG1nMe8xed16mchpbvWF8VWrl8t/jc//EYuAZjx4SLe+8uBv/nJmrsOufMRbnU03vbHEWcifApYnS/vlfkvVRqHMk1uUzFMzJtgrb1mBd0TyJssepip1c03FU97eJF7xCbn1nATPO7ebgklC41d/FosMohYyxApdTlwv2d9AR9zW7FOTNjp6ddUTqWcvJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn2SOyVGNnSxDUQihmo2RcWtVShM/YUm6+ZstjPuq4A=;
 b=B0jCj3IV6K2/8qyQEKaiVd2w/SjD3RSiSGx9CuzLfBS69LyvyUwJJI7P+vnPu6kjeck7B8iowTM/Sa1QjS6uGFsOmXF0D+Oy9+uu9M9BeM8+Ys5YSERG6E0XzlzAMrSk6jN0PG8DjInKGPcvgyjh1FzUwdX4ai2/5rc2nwUMVtQzuW7T3DOm8N51PEtKdPP5pvx2VzrEQ11mYnRLnvOpT7cxx4YvENgugO8Gists6bkwi0D4MsgZkzxo/ekbtF3i3/QrDhamSRTBZavOOGp3yOoP1Wk7BqN6Xa73+57FnMdppKvhjJAH4Qonlx0LaJy7IbZoRk3YchC3fGHZtzgQzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn2SOyVGNnSxDUQihmo2RcWtVShM/YUm6+ZstjPuq4A=;
 b=X5imb2Ub31Rdaj7i0N4+pHhoyipLdxlNq44N0EXB702ex9DBmhyFxYHNooJW0G+L9VAGCDt+5SmFF93mZtcXr1FpgrK1JLLMpzlMUV7uZd3KQID96ORMgXFMfP9XI6IH5eZ0oexV2NNTcAPbbJyyywy/5eaf7A2o2jYFyZsrocM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 09:14:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 09:14:01 +0000
Message-ID: <c76044ce-6466-4909-b3d5-6ef13df192a9@amd.com>
Date: Wed, 1 Jul 2026 11:13:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create
 and map helpers
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260617065442.16432-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617065442.16432-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8fa354-adfb-4419-188e-08ded75116e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pgUrZPHnz4oqeqhLSaVuo2ZMvtYtHjGlsegbm7Jp3azqzbr8GDjGI8lK6KTcBWc/6Jq63Y+DeDMb80vYk7CXI/04cY1XEhgMvpwHIZCkTBgajtIXoqYlViH/Q1WUX1rMCCUbWpp3RpWRSIMpNHGeY8mcJO5DTKikXEZ6SzQdLB0WbcDk0YbQBuAobiOBfdT6l7a4T3K7yqJd2edMBFsKcUR9wCvgP8ztYZsPHGl/QU+8gPNegh74cVEgYPPiK1wCcQKjvlL4kFHp2Dprcw4CqdixosxmJxPAMQr5gS/3z1lXzpJrlR79mZ3MLNqFA3xPJj/0NYLl3xSU5poYqsOGFjzTyefDr4ruK+jmupKSD1dipV4Y/S88MJUB2ds2vbunUTg1nuFE0GF1j5fnU6P0acYZbfaZYx3fgaFh/sarJ18Vk8FzI5rNFqv/6+cNDCQi6rgZwbqvDMU+535ee5xBgbdhVgrurXu1MFqtR91IfcyKvJPAsktQ9ZX7MJS2KgOEcWanD+5vIWoGcigoo3St/wDz8Ycb97VzgNBiXeRxVT8xFGtnotZi6IpRsrIKiyTWM8v5srEDGt86/EWghTD73SL+ulGN4v8tk3Cv6ArSI1tUMRUQiPPtHvBY/GEYeqtoTor1At69wPPI6e0W5VYdwbq35iE+h3fwVEhJBLCCofM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lBNjNObGZQWnlCTWRGRERyU2tPUGo5WEEzQmVpeXBCN05IMkdveUw4Tkc3?=
 =?utf-8?B?Wk9pOWxBNW9aSTVIZHl5dHN6aUxZSE82Z2FTbHA1NU0ySVQyTnpsRjZPdU9h?=
 =?utf-8?B?UVpkZXN2ZlBFTjM1VUwwRUt3SUVBT2N6VTZka21SRDk3UHdQUnQ4a0FNQU9s?=
 =?utf-8?B?MWVTVzJlSjdMZFNhN0hNSEFmSm0xQXE4YVU1dXdDV1YxazdpMGJ0VG00MnBw?=
 =?utf-8?B?dnFwYVlKSHZzajVhOTZqMUg0S1ZmLy9oNWVYemJyZzJadGZMSE9XUExBcXFy?=
 =?utf-8?B?dXEzYTFKSkd6WUlWL0N0RzI3K0k1eis2VXg5NEVVY25aaDlQQ2hkQXN2cTk5?=
 =?utf-8?B?ak1vdlFHdHJCZWdEYTQya25xVlN2MEU4VEM4UDBhWGN6ZGYrQm8vVjJpRVFM?=
 =?utf-8?B?T3ZEKzJlSlp4TTBKdjVCVXd1TTdVc3JFTVA4dk91Z3F2S09FSG1CNEtKR2k4?=
 =?utf-8?B?K0ZCcEp2WjJUbWFUUEN4NmhyNlpjMzVCVEsvb3Juc0xJTm5kandVdUZoWVRo?=
 =?utf-8?B?L1g3cGFtWTdwc2pBRkdkTHA0WHN5UGtES1ltY2ZLaWhUajBUbU1YdmVOenR4?=
 =?utf-8?B?ZnJ5MVVOWFZOYzY4Z2hRR3JyTG1yOWEzYjV4WG8zQ0piYWkxMGx5bzFsWnAy?=
 =?utf-8?B?YlRHSGhnZXBGUjFlNmtBWmFkZlloRnAzcFlDU0pjb2FYVWZNdlVTb0kvVEgx?=
 =?utf-8?B?MjFtWjgyWlJNOGFUejllWDA1c0NNd3RjOW5ERFJEWlJLcVFFUEhRR1JOM3l0?=
 =?utf-8?B?U01JeE5kWTUxajhhR251dXBPa3BkbENLVS9jNzREKzFDVFdXcC8zN0ZlZTZO?=
 =?utf-8?B?SVR3bkJ1eFU4SUd5OFpEQ2dnVUYyTFN0UzJJdS9SZGNUcnJERXhYQVNzWGF5?=
 =?utf-8?B?WEVSSFc3ZlVacFpXRHlLSm5xNG9jZkVsQkc4UmxUQkYzSExaVnVpSk9iU3VN?=
 =?utf-8?B?Zk1oYWFuc1c1Nm14aktzYmEzbnhqOUZLMGdzUXhKcFNoVFZrZ1lxS0VJQ3RL?=
 =?utf-8?B?MXlNQ3VsdjB3RWltVUV3cm5vK255SUY3KzlnQWtHa0tRZzFMVWtWSWFPV0ZI?=
 =?utf-8?B?S1BlRzY5RU1ibW1xVGtPckd5b3BQaUN1TzgyTTM5OUp6S25pZHduRW9Ic0g4?=
 =?utf-8?B?VTBXVC9rWmlmNzNLUHFHbm1XNVRwMzI1YmtMQmg4R1JuOW1CdXMxME5sMXJW?=
 =?utf-8?B?YXFMWjFSa29kZlNFTU5RWXBsT0xxbTlJb3ZicjBsWVRVbVZ5TGRYdlkxdkRB?=
 =?utf-8?B?QzV1OWVtaVJ5VFBJcmlPcDJPbGtwM1lIaFVTT1dJeTJJM2Y1R2drTUJSSFVN?=
 =?utf-8?B?Und6cjcyc25qR1pVSUtXaElhZEhJNWFjQlQ5R2tVSmFUanN3MUpQcnJycTZO?=
 =?utf-8?B?cTd5OGlHbzFOSWFUVENNR2NiZjFPeEs4YmtMb29WRXEyUUlWT0lvVTYwSmtw?=
 =?utf-8?B?dzRIZ3pycm9hMjRnQytwM21VeURJOWp1bTcvcGNYdVJxSTdZQXYvRUd5WkhO?=
 =?utf-8?B?YldoUEJaZXJYUy9LVUJPRHBVWUVWTEEzYnN3Zk9JQTRrYzA1UllSYnRrdDh2?=
 =?utf-8?B?NFJ6aHpEOEtjL0JrWEZYRE5jVnI5SzVMM0o0YVM2a2pObXh0UFZObk9lL24v?=
 =?utf-8?B?WjdUL2VoOGxFVHZRdGxYcnU0QzRqQ0ZZVWgxdkJMRFo4Qm9QSHo5TmU1UDVL?=
 =?utf-8?B?MDNHUldheThTeTB3dzFjMjNjOVlRRVB1QnROdFNNaW1wbktOSVVCUllxdXMy?=
 =?utf-8?B?Z0VtUEkxU1ByRlpvSzlobDFXTktKMFpGcTFHRHJISHB2dDJEd2FEQ1AwcHlQ?=
 =?utf-8?B?Y1ZYTm1ZZGZ4eFU0dFpnS2tvaHRoQkNFbTUrRndJZGJpYUxyQnNHbkNkaERN?=
 =?utf-8?B?QWtNaU5DRnQzeERudzVjanFBa3R2OERCakdJZ0ovSDRJK2hGRXIwS0ErVXFs?=
 =?utf-8?B?WTNCQllNMzZMMDhtSkVmWVZJZGdHYzQ1RWY1aEFWczM0U0M0SldGTlh6elM2?=
 =?utf-8?B?VldvVk1raDNBVHRTSENEb2VNbTNVbXRaME45VTNudHdjODE2SngzSk9CUFRq?=
 =?utf-8?B?S2dEZVJ5dUEySTZWSkdoNTVBSkNweXpockZ4WGwyR2h2NXJmbzZTcktPMi9W?=
 =?utf-8?B?OGg1TDNkY1RiUkpwVHNaZk1MN3Q3eE1TV2ZWMDlsWHBRSGE1NHQzZkw5TVRv?=
 =?utf-8?B?NmNwN0VKNGd3R0pYWVlpdWlxVHB2MENoaXlUZWdmb3NqWTQySWZrVC84S2o4?=
 =?utf-8?B?emdMNWZKcDhvZUtiUlcwcTZuL00xVDU4U2w5Mkh4RW4wSERwc2J2dnZmekVC?=
 =?utf-8?Q?vojygFe+bWRNM4J0b/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8fa354-adfb-4419-188e-08ded75116e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:14:01.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ytMYhGjNY4BRbg8zYD+M+sHIsMdtJM5+kBdb5+7DiDhf64McbIm3zqLg2WyOrwf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
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

On 6/17/26 08:54, Zhu Lingshan wrote:
> amdgpu_bo_create_reserved() only allocates a new BO when
> *bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
> NULL, it simply skips creation when *bo_ptr is non-NULL.
> But it unconditionally reserves, pins, gart allocates
> and maps the BO afterwards.
> 
> When the same non-NULL BO pointer is passed in again,
> for example firmware buffers that live in adev and are
> re-loaded on every resume / cp_resume / start
> under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
> pin_count unconditionally, however the matching teardown only unpins
> once, so pin_count never drops to zero, so TTM is not able
> to move, swap or evict a BO, causing BO leaks.

That's a good catch.

> 
> Ideally the BO should only be pinned once at creation. So this commit
> splits current amdgpu_bo_create_reserved() into two helpers:
> 
>  - amdgpu_bo_create_pinned(): create + reserve + pin + alloc_gart and
>    return the BO unreserved. It requires *bo_ptr == NULL on entry,
>    so only pins the BO once.

That sounds like a bad idea to me, just move the pinning under the if as well.

This just creates a wrapper function for a wrapper function.

Regards,
Christian.

> 
>  - amdgpu_bo_get_access(): reserve + map gpu/cpu addr + unreserve.
>    This function is idempotent and is safe to call multiple times
>    on an existing pinned BO, for example, on every resume path.
> 
> amdgpu_bo_create_reserved() now calls amdgpu_bo_create_pinned()
> only when *bo_ptr is NULL, then calls amdgpu_bo_get_access() for
> CPU/GPU address mapping, and reserves the BO before returning.
> Repeated calls no longer take additional pin references.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 175 +++++++++++++++++----
>  1 file changed, 143 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4dd7c712b8c3..dd0a59137028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -217,57 +217,53 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>  }
>  
>  /**
> - * amdgpu_bo_create_reserved - create reserved BO for kernel use
> + * amdgpu_bo_create_pinned - create and pin a BO for kernel use
>   *
>   * @adev: amdgpu device object
>   * @size: size for the new BO
>   * @align: alignment for the new BO
>   * @domain: where to place it
> - * @bo_ptr: used to initialize BOs in structures
> - * @gpu_addr: GPU addr of the pinned BO
> - * @cpu_addr: optional CPU address mapping
> + * @bo_ptr: used to return the newly created BO, must point to NULL on entry
> + * @cpu_access: true if the BO needs to be CPU accessible
>   *
> - * Allocates and pins a BO for kernel internal use, and returns it still
> - * reserved.
> + * Allocates and pins a BO for kernel internal use, and returns it unreserved
>   *
> - * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
> + * Note: *bo_ptr must be NULL on entry, this helper always creates
> + * a new BO and never reuses an existing one,
> + * so it never pins the same BO twice.
>   *
>   * Returns:
>   * 0 on success, negative error code otherwise.
>   */
> -int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
> -			      unsigned long size, int align,
> -			      u32 domain, struct amdgpu_bo **bo_ptr,
> -			      u64 *gpu_addr, void **cpu_addr)
> +static int amdgpu_bo_create_pinned(struct amdgpu_device *adev,
> +				   unsigned long size, int align,
> +				   u32 domain, struct amdgpu_bo **bo_ptr,
> +				   bool cpu_access)
>  {
>  	struct amdgpu_bo_param bp;
> -	bool free = false;
>  	int r;
>  
> -	if (!size) {
> -		amdgpu_bo_unref(bo_ptr);
> -		return 0;
> -	}
> +	if (WARN_ON(!bo_ptr || *bo_ptr))
> +		return -EINVAL;
> +
> +	if (WARN_ON(!size))
> +		return -EINVAL;
>  
>  	memset(&bp, 0, sizeof(bp));
>  	bp.size = size;
>  	bp.byte_align = align;
>  	bp.domain = domain;
> -	bp.flags = cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> +	bp.flags = cpu_access ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
>  		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>  	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>  	bp.type = ttm_bo_type_kernel;
>  	bp.resv = NULL;
>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>  
> -	if (!*bo_ptr) {
> -		r = amdgpu_bo_create(adev, &bp, bo_ptr);
> -		if (r) {
> -			dev_err(adev->dev, "(%d) failed to allocate kernel bo\n",
> -				r);
> -			return r;
> -		}
> -		free = true;
> +	r = amdgpu_bo_create(adev, &bp, bo_ptr);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r);
> +		return r;
>  	}
>  
>  	r = amdgpu_bo_reserve(*bo_ptr, false);
> @@ -288,27 +284,142 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>  		goto error_unpin;
>  	}
>  
> +	amdgpu_bo_unreserve(*bo_ptr);
> +	return 0;
> +
> +error_unpin:
> +	amdgpu_bo_unpin(*bo_ptr);
> +error_unreserve:
> +	amdgpu_bo_unreserve(*bo_ptr);
> +error_free:
> +	amdgpu_bo_unref(bo_ptr);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_bo_get_access - get CPU/GPU access to a BO
> + *
> + * @bo: the input BO, must be pinned
> + * @gpu_addr: optional, returns the GPU address of the BO
> + * @cpu_addr: optional, returns the CPU address of the BO
> + *
> + * Note: *bo must be already pinned!
> + *
> + * Returns:
> + * 0 on success, negative error code otherwise.
> + */
> +static int amdgpu_bo_get_access(struct amdgpu_bo *bo, u64 *gpu_addr,
> +				void **cpu_addr)
> +{
> +	struct amdgpu_device *adev;
> +	int r;
> +
> +	if (WARN_ON(!bo))
> +		return -EINVAL;
> +
> +	adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +
> +	r = amdgpu_bo_reserve(bo, false);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
> +		return r;
> +	}
> +
> +	/*
> +	 * The BO must already be pinned. A GPU or CPU address of an
> +	 * unpinned BO would become meaningless because TTM
> +	 * may then move or evict it at any time.
> +	 */
> +	if (WARN_ON_ONCE(!bo->tbo.pin_count)) {
> +		r = -EINVAL;
> +		goto error_unreserve;
> +	}
> +
>  	if (gpu_addr)
> -		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
> +		*gpu_addr = amdgpu_bo_gpu_offset(bo);
>  
>  	if (cpu_addr) {
> -		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> +		r = amdgpu_bo_kmap(bo, cpu_addr);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) kernel bo map failed\n", r);
> -			goto error_unpin;
> +			goto error_unreserve;
>  		}
>  	}
>  
> +	amdgpu_bo_unreserve(bo);
>  	return 0;
>  
> -error_unpin:
> -	amdgpu_bo_unpin(*bo_ptr);
>  error_unreserve:
> -	amdgpu_bo_unreserve(*bo_ptr);
> +	amdgpu_bo_unreserve(bo);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_bo_create_reserved - create reserved BO for kernel use
> + *
> + * @adev: amdgpu device object
> + * @size: size for the new BO
> + * @align: alignment for the new BO
> + * @domain: where to place it
> + * @bo_ptr: used to initialize BOs in structures
> + * @gpu_addr: GPU addr of the pinned BO
> + * @cpu_addr: optional CPU address mapping
> + *
> + * Allocates and pins a BO for kernel internal use, and returns it still
> + * reserved.
> + *
> + * Note: For bo_ptr new BO is only created if bo_ptr points to NULL. An
> + * existing BO is only re-accessed (get CPU/GPU mapping) and not pinned again,
> + * so repeated calls with the same BO do not leak pin references.
> + *
> + * Returns:
> + * 0 on success, negative error code otherwise.
> + */
> +int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
> +			      unsigned long size, int align,
> +			      u32 domain, struct amdgpu_bo **bo_ptr,
> +			      u64 *gpu_addr, void **cpu_addr)
> +{
> +	bool created = false;
> +	int r;
> +
> +	if (WARN_ON(!bo_ptr))
> +		return -EINVAL;
> +
> +	if (!size) {
> +		amdgpu_bo_unref(bo_ptr);
> +		return 0;
> +	}
> +
> +	if (!*bo_ptr) {
> +		r = amdgpu_bo_create_pinned(adev, size, align, domain, bo_ptr,
> +					    !!cpu_addr);
> +		if (r)
> +			return r;
> +		created = true;
> +	}
> +
> +	r = amdgpu_bo_get_access(*bo_ptr, gpu_addr, cpu_addr);
> +	if (r)
> +		goto error_free;
> +
> +	r = amdgpu_bo_reserve(*bo_ptr, false);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
> +		goto error_free;
> +	}
> +
> +	return 0;
>  
>  error_free:
> -	if (free)
> +	if (created) {
> +		if (amdgpu_bo_reserve(*bo_ptr, true) == 0) {
> +			amdgpu_bo_kunmap(*bo_ptr);
> +			amdgpu_bo_unpin(*bo_ptr);
> +			amdgpu_bo_unreserve(*bo_ptr);
> +		}
>  		amdgpu_bo_unref(bo_ptr);
> +	}
>  
>  	return r;
>  }

