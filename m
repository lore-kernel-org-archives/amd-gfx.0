Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B370C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9504610F613;
	Mon, 15 Apr 2024 12:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFwDYsI4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BBE10E4CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 12:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5PZ0dOUlfl/m4oJtbJPzsGlZLx3hU2ZFTrAFCNtcLsurdCEXpCTlQfyCKhsCLO3dgl6QYDQbwB7JXh5LaxrtTzajeCy8bbNUHzO69Z/nQWYe7BIaeUKT+TbT+tHmwpXeVvd4GRgI9IjIRMz7SzC+ZsOkshWGi9bC5KdOzUiJLC38qI2R8+fpXyARffUdq7u2ozxPnJ2ENUlvmzGLVlcyPjSH2YrMBHaQ8oDNkjKK4f9B0hPV0mWPzKqHdgdScOCwy9mE3roPqyepxWtJthQSFveZ+klDrDVS2+53yK6sYDa26jveTnpfa/e6+JVftmdjDkMOq76flktL8dH1iFLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PVc5nVk+PDRLyL9oBTyewdlDt2jRy939lbIR6wugoM=;
 b=L46VvSXfR2CLfyviOQgwV5UrlEZChfaRFA8yMxSKA65SLc5SiVQ72DPyyDyH7KP6xaFG0yRvcCd+xTvT1gow2oYlcQ+uKkzZmYfNJXApNyXtj9N2rt5CedBLc/3wIieIrQM23IzVVByV5b6sLV/gq7dCv2I05KzhXKyt1fm2vyAtERvaTfPHumCdie/vDfhdDMcftetU+pCyHG8UEPPOn6cmIgqE0zwYcnhOl/V+ckx4n4MUcBGe6uLpPIL3H7utPEh2vk3r2qkymxSwEyQYFg9dBrvx99olsGNcABhrxmZQbGm3Di/tN7+6YhmMJJiGiCHFmWqOiTwgvfX/HNxmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PVc5nVk+PDRLyL9oBTyewdlDt2jRy939lbIR6wugoM=;
 b=HFwDYsI4lO9+t5kqGk65Kscf9pJF8yG3yoBSy659G4rNFdX10VCB0GchuNIbd7Pp9nveEoZ/nXRDIKxdK59pDCmfsNrahLnFDOaBuBJZZmbe0T64W73zt0SpC2CBp2Quzfap/l41snIot4IMZHl/R+wTTFEZse+ZjyPl9k8mjKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:02:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 12:02:27 +0000
Message-ID: <05f277d3-f1b1-4a3e-b364-37f18cffcb2d@amd.com>
Date: Mon, 15 Apr 2024 14:02:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Support contiguous VRAM allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240412201301.14154-1-Philip.Yang@amd.com>
 <20240412201301.14154-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240412201301.14154-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 10005d06-577e-4fdc-35f4-08dc5d43eb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SBmPrpf07moc466/vEuxaZtYwg4q7m5YvtHlLvAw2Wxhi3oDjStJXqSwEcAik1OwpBuLGhPWVfWfSPy4FpPtQfBOxZbmyQGQHli/heyUq/ku+EffqPyiVTsN2GM++QsWq1F3dgqIQE8JK8uXf/Hzens5NZh6iTwUYNAdtErbSzMFc3n0vFS3o9FCHuOL/+lYTsfRZNgCymS3A8co8aTv8ntcXnBBvqX0ppu3H8MTFJ1EWpsnSTYaiKpon1pHeL0kS0T3VmcVGX6w1iKtRLFTVdf207LFREH/Fx0gnHG5Q0krqJ/XBaaPzYnlG/AZHW5dJPix3EDIwFCOTQyZumhh/6hVNFuHUjd5Fzhor920iG35kfW1/jT9eGzqzVP9xuGmaed8yEHzBRmWUHJXoB1M0dkC/4uW+z+EB8GTK1HTsJntpuVYco0vhdZuOc/nxZmf9Z/Fszan+ri7XLE/KgbWh7mJ+6dRTjHRu7yntC5s1pSFUQthcTlTaYJaEddOP1SW8fgoS/5ltZhVbL3/TTOElWMaPaR/ZEiCXzLQoMatVAHKc49zVoKpD3X1fqmctwLdvNHWruo+lonAiXbTq4PUYbr1endAvVHXnKv304WMjIcj6FJox0jonuc6i8LZx90WLpCyk3elYX7w6k4hB4XxGhMW/R+ovVj6yRMyqrquSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVExb3pEY1p4aEJSdlBPcndFMUg2UUhTVlJVbEtmdUhJQVlrcml6dWF6THVH?=
 =?utf-8?B?dHJldGkramd4OTVCYVVBTDdxSUhibW1XeC81NWJ5SGFaUGNNd2xUUTZhc2Js?=
 =?utf-8?B?dHBlQUV5eDMwS2ZzN20xQkdydHpoZ29Ib1BHK1VrVUZtSVRBVzJqTUdRdm85?=
 =?utf-8?B?ajdoQkcwYjZUUmp3clhpYTJ5b1hXTXJrakgvSWhmUFlBNEU4RjUrcDZVZG5H?=
 =?utf-8?B?a3QvZ2FkYWhJL1JKWTNwSUlKWkdWSG1PRTVpckJhVjlYcXYrWW1wRzFCZldH?=
 =?utf-8?B?czdQa3NsQWU2NVZsNjY2dTZNdERDZ0owTVovY2szVlJKTEVUV1V4TlU4NGxa?=
 =?utf-8?B?Zi80VnVjQTllaFcwU0U1aE1CWDBscitMRFpTaWcwNUVtOElnNFhDRGREcTdP?=
 =?utf-8?B?U1BHQldEa2M3Y3M4bFRheFkyRk9VS3kyL0NYa0lCK1dlMHU4ZjFqem1hQS9Y?=
 =?utf-8?B?d2s5aGg2c3Z0eUJFZjQwdjBaaVV3elE1dUxxbU9rT3JJOEQ0Y2xieWN4Vitj?=
 =?utf-8?B?SEdBd3kyVVFrZDJyRitSa2VoRXV4dFY0TDJnTXdDVmR1VUVWQ0RLWHZLR3VY?=
 =?utf-8?B?dFRpZy9QQmFCV3dkTnFnbFhYbjU5bkswQTVLK3BjaGpOanlEeXE2RHZvRTUw?=
 =?utf-8?B?T1o3Z3dvbGYxZjd0dy84UDhoTHdWWFkwSklNL0FPVG04cCtTbUtKS3lHbTF1?=
 =?utf-8?B?Ykk5VENzWXRmczJkVHlmdzBmdVFVQzlSVXJqK29RSUpITVdKTUpVVUtQb0JP?=
 =?utf-8?B?WG4yQ0NmNXU5ekhTSVg5UnpncStXOGFqcURKS090MjkzMlhZK01iYWlVY3pR?=
 =?utf-8?B?ZC9tbTREdTRENndXcjQwdHRaSmQrTjJwRHRQNEZBRjhieDFLY1lnTDhaaEJm?=
 =?utf-8?B?RlIvelNyNDFXRmlBUDJzeTVRaFUrdWZDdkk2d2pwOEtuZ0lEM243aDBENG84?=
 =?utf-8?B?OVhvNnFVNUZJRElHUHFyVW0xTGkvNkJJc1hHVEFMcG5rV0dOdFJIR3ZQcXJ2?=
 =?utf-8?B?Q2d5VmRtR1NXZDhoU1BISHR2TzFJTmE5RG1GK0paV2pESHBaVHFGd1VFYjZl?=
 =?utf-8?B?eUxhcFpaY01sUDZhTW5vRXFhc3NJbURhelpVcWJlZXdnZjE3a2NETERoVFNs?=
 =?utf-8?B?aVFLWjFzQ0dTZTUwa0J4cW9BSFIvdW0zV25rKzk5S2laS3F4aFp1VFA5RklR?=
 =?utf-8?B?dVk5RmVWVVZuZnV3MlJXMXVXK3lJRVk2Qnc3RldGMXlZNGlkZUxhSHNLU2dw?=
 =?utf-8?B?THNDcVplWSsxNmhWS2lzM1pwOWhPNEdEZEJzUkZJVjZEZkF0U2RiSERLbHFr?=
 =?utf-8?B?VlpwdFh3RlYvSlNuSEZxdnRjRVVZR1U0UDFESUJmQWxMVDN3TGpWSm1xZkgz?=
 =?utf-8?B?aUZpeVZWdVhxQXZyb1hoUmZScHl6SHpXcmJjK0Z0ekNpeDRYYUVQNml3b3NM?=
 =?utf-8?B?TWdIV0h1K0M3cTJlTjlaMDRHRGNWQm1ucXFCNUhHWmNsM3daS1VnVUtPL050?=
 =?utf-8?B?ckFWeFdxVHNTVmtjWFpVZUhYbXV5Z25sS2RsSTFsS1VBWXBMQkROdjR2bjY4?=
 =?utf-8?B?cC9CNVJYdW9aTmpTdU5BWE5DeXlESi9nUUNhaVdkQnU4Z0ROa1ZrK0k3YVl3?=
 =?utf-8?B?MnJ5WXluY2NwTVlKSC9wbHpjWGJEL0ZQV1lBclR2TXpJb3AvTU5DMFBzRWFT?=
 =?utf-8?B?KzB6Z2c3d3BZSk9IcGRiVXBvdmhiWnFBUnNoMDlUL0haOUh2OWdWeE1la2ZY?=
 =?utf-8?B?dThROEkvaHk3QmtxQk1LOXBNeTJoZzF1S2E0R1B3eTM4Q3JKL2J2dVJJekpq?=
 =?utf-8?B?eS9CeVJuTXFVZW1PeUFNVExVQzRZMVhSQ3ZSRW8vQkxWVjFzTk5QY0RyaURN?=
 =?utf-8?B?bEQvQ3UrVHNNK1l1aEc3ajM5L2sySlpHN01WbGRkdFFWa3NxZVptVi9Qbk5U?=
 =?utf-8?B?WGZoQzExTk11Qll0aUMrcmJlVjJGSks4K2RMWnhxdDkrUnhJM2pxYzJTaWpJ?=
 =?utf-8?B?SnIyZ2M3NUFRSmhYdTlJK1JvSG5XbnFKN3NSN2kyYU5kdDhxKzFENHFKQTlh?=
 =?utf-8?B?ajlsY01GVXpmdzJER1Rmd3FGM0ZRa1ZRQnUrNXZBeTBHY29ObnhUSmdwS2sz?=
 =?utf-8?Q?wmVRWbkmNCnEUiFmWKgc2V8G7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10005d06-577e-4fdc-35f4-08dc5d43eb6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:02:27.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3C8m6vZQhG03u+kqEVk4JouxbabnhnQor4uw6a8iPEnKSoU/NSt58ki9iEe9JHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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

Am 12.04.24 um 22:12 schrieb Philip Yang:
> RDMA device with limited scatter-gather capability requires physical
> address contiguous VRAM buffer for RDMA peer direct access.
>
> Add a new KFD alloc memory flag and store as new GEM bo alloc flag. When
> pin this buffer object to export for RDMA peerdirect access, set
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, and then vram_mgr will set
> TTM_PL_FLAG_CONTIFUOUS flag to ask VRAM buddy allocator to get
> contiguous VRAM.
>
> Remove the 2GB max memory block size limit for contiguous allocation.

I'm going to sync up with Arun on this once more, but I think we won't 
even need the new flag.

We will just downgrade the existing flag to be a best effort allocation 
for contiguous buffers and only use the TTM flag internally to signal 
that we need to alter it while pinning.

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c     | 9 +++++++--
>   include/uapi/drm/amdgpu_drm.h                    | 5 +++++
>   include/uapi/linux/kfd_ioctl.h                   | 1 +
>   4 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..3523b91f8add 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1470,6 +1470,9 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
>   	if (unlikely(ret))
>   		return ret;
>   
> +	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT)
> +		bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +
>   	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
>   	if (ret)
>   		pr_err("Error in Pinning BO to domain: %d\n", domain);
> @@ -1712,6 +1715,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
> +
> +			/* For contiguous VRAM allocation */
> +			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
> +				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT;
>   		}
>   		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
>   					0 : fpriv->xcp_id;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 8db880244324..1d6e45e238e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -516,8 +516,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   
>   		BUG_ON(min_block_size < mm->chunk_size);
>   
> -		/* Limit maximum size to 2GiB due to SG table limitations */
> -		size = min(remaining_size, 2ULL << 30);
> +		if (place->flags & TTM_PL_FLAG_CONTIGUOUS)
> +			size = remaining_size;
> +		else
> +			/* Limit maximum size to 2GiB due to SG table limitations
> +			 * for no contiguous allocation.
> +			 */
> +			size = min(remaining_size, 2ULL << 30);
>   
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>   				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index ad21c613fec8..13645abb8e46 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -171,6 +171,11 @@ extern "C" {
>    * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>    */
>   #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
> +/* Flag that allocating the BO with best effort for contiguous VRAM.
> + * If no contiguous VRAM, fallback to scattered allocation.
> + * Pin the BO for peerdirect RDMA trigger VRAM defragmentation.
> + */
> +#define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT	(1 << 16)
>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 2040a470ddb4..c1394c162d4e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)
>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *

