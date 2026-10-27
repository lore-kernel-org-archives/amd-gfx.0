Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF1606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fqitR3k7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3609810F52B;
	Tue, 27 Oct 2026 13:31:04 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645EB10F52B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjtZNWxKlYH+RDDEL5WsJ7c+Di9Yu6bj+z0KSWvZ/eFYbJ1nKoe9NEX1iYk3xU14mYNaVVF/qHKdvXZGAMuPUevvRSJrmwdVnQttifBIQL35kD5c5/Odt56x4dzq2zV0z92MYCM54RANET/glPWoujBIswnWAMPQAsqpsC4O9ceIYv+rYYC8C+fQQ+dtZX/xy2lzTAVWZ66nrgTtV0edOj2DykhlKRCEiX8tH7AeI2KEXQwxa+R9zLbpp8s9T1guDjfr37fry8bImG4K6YlufUcZ2TiWGZBRjyhpsLkPmT+U3aqsbMpJ527VZ73BpeosqsRznyDovjRB8XG8yrO1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHLa3yEiY5YroW6+I/SgM4HgevGdeNekWZvs1uWiCvY=;
 b=ELuifW3Cc7tMgSivBydtUF3q8vrR03GnkinX0ixD6hSYXoYLwUrJMSNk7dOymorPBgYdjfnC1nBBY5BH7zylEFabXHCK5eZi8ADDzPA3ywpQJRdmmGzRxvKZTQe0mbs8aP3YRxMaRCgiT3DMKMX2mVkwVEmRtEJKlTGrw3+wgE6xHgky5XPsw6xxPsRQZ4Sln2f0b8UJekkUVazXcnt9Pu8fKfM958rTd0U2yIeX66fZcRZQydLNg7/Cqs3UBYXxcqZnvzA4QzJPFaDjlWh9qmMDykxeliS5Kcr5EaB+YhkGH1hhc7M9G++oI/p+qTWO/vG3ccjSg8S9leE64xWeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHLa3yEiY5YroW6+I/SgM4HgevGdeNekWZvs1uWiCvY=;
 b=fqitR3k7O3eLtbu2XtR3OQhEUJMeWnbCc7PLaCxCcdCEzosfThMKE2GbMXAdjlEKy4lkNg/oUa1Lvl+NRPJbrrAUHgfAwkOH6rZLNp729hOKrp9a5IW0eYMnCEiB8yZKZAHpLOcLKHS8GnUWxRedVCpx2scMUKg31bgPFkleySw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:30:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:30:52 +0000
Message-ID: <9222106f-576f-4921-bf2f-ee59105a7d4f@amd.com>
Date: Tue, 27 Oct 2026 14:30:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Implement disabling implicit sync per
 submission.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
Cc: samuel.pitoiset@gmail.com, natalie.vock@gmx.de
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-5-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022003058.1723817-5-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:408:ff::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf1f54a-5424-4f85-3b78-08df342e8567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|4143699003|11063799006|10067099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kP1b9CzqE3PcdU04gAhG9y5BxYAbdL2E0TCr29tjsP0CbyeSo+sXUZWFeRkuvtXLjarTmQcyFDg5kldSh6f3iNh5NCbWw9hgzIJPYV3mx77cYMl0I40fiHqVOS3VNgAxJFXqdWVYqAWF9KYwdxeNppJDj8Kb43vi+fCtF2k1D0+KsrOXAGeAk3vwu30chWWRx9OtHP+11ch/vq6kd/5MCRSm9A4bhx4qaN00oGv+Fz+rQZpW+zJwEXOtoyuirPCIeZdNSTv+Wce9/h/Q730xYJMg2ZkLQUh/yLGR+8fcD8GEAvbXgm8y7aXic5hl8g2jNjO6kUnrdvPK0AvHI1vsUiou2gLZRp8WubD42gilKMg/N4hUvZhBMEbrkyzHVcYYlJxBASgEaf4jaH77x4Rua3JJPYKLzrnYdiolNk/l2pDtw7SDUJflnNZaCOdSMkcJZ/gCNsxjc61ewkCCfEV0dJLYkaAvb/sxQTPLNwL2q6f9YAxPtzlGw66GeSeaOMPTU+PW9APvbfcC2Y94iA0mYMD4krMF1JdxPigKS1ADKuxLI8yj3zhb2dLz9GUcxPjNcCdIcm1YU4yfae5y7sf4LQGln4qOwNhWunxE3Y5xEdApLT7UANt9hj+SE+nhVPe2/G3/yB1/ObzLmRpmYGAfmRRXXvbM2oxJfiCaYdfEN60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(4143699003)(11063799006)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG5CS1lHU1R2c21DVy9rRDZ3UTNib1RsbHhZZFlvOTdOaUJKRFI2dkd0K1BP?=
 =?utf-8?B?K2pKMWk1WnZhQXhFdkxBaFVvOUYyM1dzb0VLV1dXTVlDMGJLdkhiY3ZJT0Nw?=
 =?utf-8?B?MG9yL0N2YkZWRytPcE5sZ253WUJUUWJTbHF5RGRTQjVkNkNWanhIbEFpM0Fx?=
 =?utf-8?B?b2pqNFBCaXg1N0JYSmxEN0FsL2dmMWUySDZRUVFmUTJZMDVHUDNvZzFIZXN6?=
 =?utf-8?B?ZVZyRG5WUUlTMldxSnAyQmxOeG9YMnpjdFg3VnVKNzZ5eVV1dnJpVkNjay94?=
 =?utf-8?B?c2NYV0JIMW85ZUlURUZiVC8xbllqbXFCd2NjY0MyMzJzM2FNcVY3aU5yMTVL?=
 =?utf-8?B?ZEFpMGhROTZIbXBDYnBNTkMwVFIweThGcDEzN3k5Snc0cU8zaDRSNGZJZUZV?=
 =?utf-8?B?U3dMRXRWMDJUYVgvUk1rSGdZZGxBNmpBb09jVlBqZXdac0xaa1BldEl2dUli?=
 =?utf-8?B?bEVWb3hka256eHNOQTNRRUdQZ3o3N2p3R0RLT2hJbjlIOVVsL0Y1OTVwZmdw?=
 =?utf-8?B?TWU0S1V2byt3V25LeW5JNTl4R1BWTXd2aUtVNGlab0VkK1QrYzFPdXVXYnhw?=
 =?utf-8?B?ME10Q092b2V3WS9ZNVBmTE8wNnRIcGg3eGlhRlYxdGZxSWNkS3JFbmoyL1lD?=
 =?utf-8?B?Y2xaTktWL0l0UHVEckxmcFo1em1XWWgwRE9KeFpCblJpNnBXL3N4SGEvaGpT?=
 =?utf-8?B?bGJKbER3NHZCZ2JFRGJHd3VPaWJDdjFHVjVEQ0JKbU41K1ZQcVErRFYwQndS?=
 =?utf-8?B?NXcxY2tEM2QwNFNlNjNyZWR4RU5XN1JadlJGTGlZeEg2dkVYS1BxclpTTkow?=
 =?utf-8?B?a1VHZWNPQjlyeVRNcGVpN1pUMEhSb0RIZDFDNS9rdUR6dnE3WURJdlN5K3Iz?=
 =?utf-8?B?NDRNNVhsWEVGbXNTam9ucFZjZkZIQXFwYml6cTYycC94b0VJa3QvYUZrK09M?=
 =?utf-8?B?R1pPbXJHQ05YMzNlbEdjdTZRd2Z4YmhYUnIyeTlNdlRTSSthRmpIZTNwRUtN?=
 =?utf-8?B?VTA5dG5TUzh5UUxyOU9ZTzFsbnJVekNKc3ZlRCthTWU1c1AzaDJHL1NHQUQw?=
 =?utf-8?B?TmhtdEVmbkxZeEdFclhYTHJsaE5kUlpGVXFFaEovTzVnaDIrM1g2V1pHQ3FV?=
 =?utf-8?B?K21pckMwTjhWVmRJdEUzU2MxUkN2WjNyU2J1Q1Z1cGpERXhtR3dvd3hnUThN?=
 =?utf-8?B?dzFlaG1MazljS0FGWEM2MlY1MmRmbUlYN2F0QjdLZGZXOFE1d3lJOS8vTlBG?=
 =?utf-8?B?VG9HK3FhZDB0MElDbnZ0SEQ2dG9BdW04UWJvR3VVVlZhM0F5RU5rZS9IOWQ0?=
 =?utf-8?B?cllKbDRTKzNpWEJOdVVOQ2dmcVFDajQxWmZKTHBJYURVMmZDSlMvVHZXUmZs?=
 =?utf-8?B?MEN6RENIdEhJc3cyQURHeTBlNCtKcjdGTGUwdHVxM2dlRjQxcnVnczV2K0Nl?=
 =?utf-8?B?ZVNaeGhmVm4yZno5Ykl1SnJnMmJMeVpTa0pqYmVjOUlFMFlwZzdnM2pUd3pZ?=
 =?utf-8?B?NDRJcmtsYnI5TEJOMGx0dW9jSkp3WVJ1S2hOUFhOVXJiUW44SjlweDhIcThI?=
 =?utf-8?B?WFVXbUdVN0xhMGhCNkRXTy9YODNabXhIK0JjcXgxM0hCeU1DOHRpTGdnV0JB?=
 =?utf-8?B?dkY3bnZKbUQwejlFUDExV2NpOW16L1BjZEsvQ3lxNUxhZU0vOEZlYjNsWTM0?=
 =?utf-8?B?YlVXQVJPMDBndWlTUDBTdHIrRi9iYm5icDZkZTY5cllweUpWdU5ZN0pVNlVN?=
 =?utf-8?B?eGtnVzJxV3F5ckhxZXRuV2VhMmtmWUlvNFpSbE80SHBnY0kyVVZ5Zmx0bkd0?=
 =?utf-8?B?S2w4RTBmdHFVVk5QMnU0cGpTK3pnaXpHcjMyZUVlNUZ5cnF0WVVndG9CVnhK?=
 =?utf-8?B?dURVT0p1eVNxMFdsaSs1d1dhVkZjemhQYlROZ2NuSEd6MG5MNXRNeVBabWNS?=
 =?utf-8?B?TjBUbm1JVWFtUHZ1TWRhRjRlNDhpMG8yTDB4ZEJsSll1TzZrcHVVRk5PNlFH?=
 =?utf-8?B?ZWVBeVBOODlUK01FbUFpNHhkcWhKRVRFYkFpVXBrdlhyZU04czdqeEVJSG5T?=
 =?utf-8?B?V3o1SzI4REwvRE5uK2w2anVzQWFSZTZmQTl3cmdhM3d3Sk0rZ1BwZE1GMHZB?=
 =?utf-8?B?by9mTU1uamJ4WlhNMFl6R1U0d1lNcm5xbkQ2TGVNWEY2ZlJkNVg0QjlWT0tn?=
 =?utf-8?B?NXlabHFvUkJkTmRiTForMmhNaFRSQnlNOVJzYnQzajNheUloU1BZZFBKWjFn?=
 =?utf-8?B?L1JEelAreFlGU1plWFh4MHhlMERVbC96ZGlxVzA2Qmw4bTl6NVBUbWRWQjB4?=
 =?utf-8?Q?4Gm1OP2lsntziBcsHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf1f54a-5424-4f85-3b78-08df342e8567
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:30:52.3082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UohwhhLELbIIrTZDvY+KwtNgmHrvzJGHYY71Ukari0aWDLoeefsBXaLsHFQqsLhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
> Implements the UAPI flag to give apps an options to disable
> implicit sync per submission.
> 
> v2:
>  - signal READ fences for the VM root PD, as some unmapping
>    operations only wait for READ and up.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 34 +++++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index afcd254c9884..f0fe9d0f1398 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -49,6 +49,9 @@
>  #define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW	0xFFFFF
>  #define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW	0x7FFFF0
>  
> +/* All flags accepted in drm_amdgpu_cs_in.flags */
> +#define AMDGPU_CS_FLAGS_MASK	AMDGPU_CS_NO_IMPLICIT_SYNC
> +
>  static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
>  {
>  	switch (type) {
> @@ -188,9 +191,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>  	int ret;
>  	int i;
>  
> -	if (cs->in.flags)
> +	if (cs->in.flags & ~AMDGPU_CS_FLAGS_MASK)
>  		return -EINVAL;
>  
> +	p->flags = cs->in.flags;
> +
>  	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
>  					cs->in.num_chunks,
>  					sizeof(uint64_t));
> @@ -1220,16 +1225,19 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>  	}
>  
>  	drm_exec_for_each_locked_object(&p->exec, obj) {
> +		/* Implicitly sync only to KERNEL, WRITE and READ */
> +		enum dma_resv_usage usage = DMA_RESV_USAGE_READ;
>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>  
>  		struct dma_resv *resv = bo->tbo.base.resv;
>  		enum amdgpu_sync_mode sync_mode;
>  
> +		if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC)
> +			usage = DMA_RESV_USAGE_KERNEL;

Use DMA_RESV_USAGE_WRITE here.

> +
>  		sync_mode = amdgpu_bo_explicit_sync(bo) ?
>  			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -		/* Implicitly sync only to KERNEL, WRITE and READ */
> -		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
> -				     DMA_RESV_USAGE_READ, sync_mode,
> +		r = amdgpu_sync_resv(p->adev, &p->sync, resv, usage, sync_mode,
>  				     &fpriv->vm);
>  		if (r)
>  			return r;
> @@ -1341,9 +1349,23 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  
>  	p->fence = dma_fence_get(&leader->base.s_fence->finished);
>  	drm_exec_for_each_locked_object(&p->exec, gobj) {
> +		enum dma_resv_usage read_usage = DMA_RESV_USAGE_READ;
> +		enum dma_resv_usage write_usage = DMA_RESV_USAGE_WRITE;
>  
>  		ttm_bo_move_to_lru_tail_unlocked(&gem_to_amdgpu_bo(gobj)->tbo);
>  
> +		/*
> +		 * Keep READ/WRITE on the root PD resv:
> +		 * amdgpu_vm_bo_update(clear=true) only waits on the VM root PD
> +		 * resv with read and should still sync to avoid unmapping
> +		 * before the job finishes.
> +		 */
> +		if ((p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC) &&
> +		    gobj->resv != vm->root.bo->tbo.base.resv) {
> +			read_usage = DMA_RESV_USAGE_BOOKKEEP;
> +			write_usage = DMA_RESV_USAGE_BOOKKEEP;
> +		}
> +

Completely drop that.

>  		/* Everybody except for the gang leader uses READ */
>  		for (i = 0; i < p->gang_size; ++i) {
>  			if (p->jobs[i] == leader)
> @@ -1351,11 +1373,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  
>  			dma_resv_add_fence(gobj->resv,
>  					   &p->jobs[i]->base.s_fence->finished,
> -					   DMA_RESV_USAGE_READ);
> +					   read_usage);
>  		}
>  
>  		/* The gang leader as remembered as writer */
> -		dma_resv_add_fence(gobj->resv, p->fence, DMA_RESV_USAGE_WRITE);
> +		dma_resv_add_fence(gobj->resv, p->fence, write_usage);

Instead just set that here to DMA_RESV_USAGE_READ when the CS is explicitely synced.

This way we get amdgpu nearly back to the usage model all other DRM drivers uses.

Regards,
Christian.

>  	}
>  
>  	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index 39c33ad100cb..5c2a5f6b1d55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -50,6 +50,7 @@ struct amdgpu_cs_parser {
>  	struct amdgpu_device	*adev;
>  	struct drm_file		*filp;
>  	struct amdgpu_ctx	*ctx;
> +	u32			flags;
>  
>  	/* chunks */
>  	unsigned		nchunks;

