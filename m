Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADF5F8E4B4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 07:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4926110E222;
	Fri, 17 Apr 2026 07:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCJXs4HS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19E110E222
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy+3noac0n6nhquV5sYCKrCZjZnpitvBa/apUjNHzWoKmf+b2B5UGtPtSSOWmDf7e0WGNi0mbmeF6OYaqQmS7mHGhJjLbpT+CjLVQ341R+d+Nn29ifd3EKSqH7e0nYH87oHfFx9aUCqi+JK37l4yAz2Aad6FL5j3+4gPohhKXHp93aQkf2MW8VquPb2a0HTbFzIjyizBeWP8EZru5+oU/SrOin2fRQZ3oVM6jvYEMsj68hFFWHbtOAuK9pnzQzJJTtvtr1OCBl/TW+lcA8z36AR2PEVVGdsFGvSPNUSg7lBzhN852/JkH1VDI2bXZ5d2tnwKOTe9vLlalCosM1f9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo2TjCpUHJO/KwyjJrT2dog7IHfTdYGM5nrKIzYbWv0=;
 b=vtDybd6Gj2t0aLBIeycXQHL6jax5Fe9iGD+ei6Hf05XcJxsjwChpdjJ1Kw3MefUdLQway8LpU7tb56gZhaljsG/++AVb2GrqN4dL2+xaO6p6IqtHSZbHBe6FWqthcRBIq2Lbj+2GbSu8AE+5jI7UUZ69JCtLOgpNesUnTLrzx6Htt9XrCzSl2lhCx8pc2Zm9i2xM7j1xZYfKr5zaTseIUf72oUTRLptcLAhtq8W67e15qaOm2L499X5I1rzsqP79W+b+OUpquot8rRPYAkUNt4gv52ogxeL/0hJRzhf0RtCzId753A7siPHMGvJZc8aYZuwI5yu9MDM5YHAoSRpJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo2TjCpUHJO/KwyjJrT2dog7IHfTdYGM5nrKIzYbWv0=;
 b=wCJXs4HSP255zcq4s+G8pTUwKGpeIK/nLq/KvLHH7kFStqFjl9dXBsoiRMuqxzarEPDPaYDaz/j0HR1nnLBQPol9UPTc7fs1j/zlREOQiitSwe58Yz5rAT1+Ea4j9TAeTiI/CF3RtWypCwsRYf5UfVav5GKFa2sBM7lZNENIfWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:21:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 07:21:56 +0000
Message-ID: <a34555e8-8a92-4994-a8e0-863a3e09a8d1@amd.com>
Date: Fri, 17 Apr 2026 09:21:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu/vce1: Fix workaround to ensure low 32-bit
 VCPU address
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260416202643.25350-1-timur.kristof@gmail.com>
 <20260416202643.25350-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260416202643.25350-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9c94c5-8341-48fd-e91b-08de9c5201ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wzLGbYznJ4nmX9lUILXP4iYWP5xJdlPtfEEALRybShvYHkp9caaHRyvOen8gWWUMCYaaoBMcpkaAvatOiLo4+b4UaakJuyS4RmfDGN68+UEQyLDW6XpWXdyeAp/jYV+7Rg1/qoqKdizkn3p0nfFxUpBy4IhMY/62p3wxvUuBMiTU/20ZpphUF/rtcRklkLHmvVnZVQd80WITCAhg+hiuTSTroYHfVxNCBW2V/mzmWMUIM5o4wGRBAVj+1vli0yqRVTlnebRQa+KBjja89PNZknKawDK9kQB1qlfTWkwc5BWzPXRXrj5H/LJBl5UhX/1t+JzN+e0cys3PVEuQmBawmpTA2LyEsOCf7Q5vLlwslk9Nu9hf+PwTZVach0/YE5+0gNKcgxwNFrhD4lZM7fszUMT8Rp1D4Bt+pm8QZKb+71zrxueFEtq3AY72wRv1qunM3okCWKnzqVx1Fe2nDCkrBRKYmN/nWiRr2OInA2s75hqSSfImJ/cZNQAQqQcaqHFoIitZE7yg5n5lXDpjNnYR5EMyqaNGc6keOadlZwv5CbvJUHL9TsXrSWpWeMlweLiVjy9+UuaO6dtAMVuQnNqmzhXIquHHWuclQ4LvzS8SBfpCReKS709qrBtwmgQTHU3emTRGCzMNTOhugGI7/ux4twbnXJw1518X0GOuLLU9wRCyN2LloVhDwZH/4QQ2DCAz9rLnzl+f6kowjnInzVqxXqd81hcCSs1QE0pQEM4ar0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9FQWpOWkZSb2hJelY5VDJDSWpVZWRBMytjRUFuZldFRC9paTkwU2IvNzAx?=
 =?utf-8?B?aEpHek5MYVIveUhzVmFGNlpTNU5aaUwzaUZkUjZyZ0ZHRy9uVWNaN3RpRmxh?=
 =?utf-8?B?aGtTTlpKbFZncTZsVVorR013WTlmb1VYY3ZHMzZ0NWFJbk5mRlhGNXlUWXhY?=
 =?utf-8?B?VDcwTytPVHdRUlNFOEdOWHoyeFF0VlVMenZDQmxQdjk3b25keitEUk9PanFE?=
 =?utf-8?B?NUFGbXZuSkN4RnpKUmVlSUhrWHVRa3ViSGcwYy9rVTNyODRuQTdoenRLWEJ1?=
 =?utf-8?B?T2VtUW5wTThmQVZpcGNpVlNpZGlxK3pxNEYxTUF0T3lQR2hPRG83S202d0tY?=
 =?utf-8?B?Zjc3OHBQOXplbDhHaWVBUnFPWTdaNlF2OGFIdWxOdjg0NDcxSXlPZHYwKzNV?=
 =?utf-8?B?SmJJQWtMSlFSOFJwc1ZGSnd3L3RPNmR2QzZOTCs4MTMzTGk1N0VlSjd0bmRG?=
 =?utf-8?B?QVFvTEY4K1YyRTZzSCtxd2hiZDFxTTc2SU5LeUZGam1pVHRiOXpBeTBVUWhi?=
 =?utf-8?B?NU1TNjRqTkFqMUc4WFpnZWFWalJlMkUrWURpQWF6SHhpUkprOEZ1UWNGaFJK?=
 =?utf-8?B?SkFlaFFrVHBCdmI4cmROOGFTeXdCTEdnYzFoWGR4LzRiSXJBWFljelEzaXNp?=
 =?utf-8?B?dnhBTDc1TVdnZW1wS0RROWF2ZnpadU9aUjlHYk4ycGVrTEgrLzdCY3hZNHRN?=
 =?utf-8?B?MG5IelRNNytieU81UktxdHYrYmxYc3ZWRUtZekF3dVI5RzB0MDJsZysraDlO?=
 =?utf-8?B?T3JmUmFMY0NlOGM2Q0tHYitQMW9nbUtjd1lWZ1hObFJqWEJlbTN4cCtSbHJM?=
 =?utf-8?B?SEYyNVVqdEd1cWNHVDhmNHhSTFc1YjgvMkEyYUxNL01kWEJFUEJzYWJSUWpY?=
 =?utf-8?B?eW9qNTAwVE1ZSTFUSVlTazc0bGg5blExTC9ob2VlS0F5VmU0SHN6OVJRK0J2?=
 =?utf-8?B?ZTB2Tm44YjBDbVIrcGxMVUliQlRIR2hrK3pFM3NvOTFmU2syUGhCZjU3ZFda?=
 =?utf-8?B?dVkyTWhvUGs3OW1ubVVXSDZQZzN6eWlRYjNrUUMyYlBDZ1hDbmxrcmswVmY4?=
 =?utf-8?B?bG9Bd3VEd2FIS1BwYWpmd0FJMzhKQllQR0hoTHIrSkxEMUdhM0JEaG5TZmla?=
 =?utf-8?B?cmxhZG0yTUhTR01LTkI5RFZlTk5aemp5RlJvNnhoK2FYVFhmRmZKeE9uWHhG?=
 =?utf-8?B?MWk0T29DTFdsWVZUSGFWVHVqMlFUem0yam5qU2g3ZmZVNnM1K0RMd0dzUU4z?=
 =?utf-8?B?TGFoazF4RkRaTmg2dG96R0RkRkk1dVZzei9XRjhwaFg0eWlTUVBubEhMZzZT?=
 =?utf-8?B?cExOOG1uRlhtSThoQm1rNExLSlRValRpU1ZNdHRxNGw0ZlhoU2JSQXN6SkZn?=
 =?utf-8?B?QzAzQ0RQa3p2QlVyTUh1YnZvR1M0djRoVS9HQ0MwQTF0VW92ZEMrVkdyUWM1?=
 =?utf-8?B?blZvKzNvaU15VVphVjhpMjFxSVdMLzV5a0RrRnMyWXU4UU1NenM1WFBRZjMr?=
 =?utf-8?B?a3hZOWtmUXpMQlBIK3FIMzZuTjBnSmlWSXAraTBzdWhvNC9HVFBXbUJvc1Jm?=
 =?utf-8?B?cDErTWlPdkFrQzRUNThNdnRSVEFRTEFYdlJWOWRCNldSQzBGM0RobU1tOERF?=
 =?utf-8?B?NzN2Wk1JYW02ZGc0ZnFhUFpVZ1Z2cTRxWDBLb1JoN2l4bDNRS09tRUZ4N2Vh?=
 =?utf-8?B?UFcvUHN3OXJscHFPZlY0cjBWWThMRzhEVjh5NUlvNDJ2c0g1a0VjUStHN1V6?=
 =?utf-8?B?WHRmOHB5K2pnOUVZYnloaEhHMHBRemtubkNVMFRVdWNlTkhjeU4vOFRCT2Yy?=
 =?utf-8?B?c214bUltSVNzanluRjhnTmVtS2lCM2N2ZnNKUzRCMU82SnJFSDlJa3lGZStX?=
 =?utf-8?B?NmttcHJFamhzL1ZMWG9hYk52L1kveTUyRGVnbTdHbXlzdko2cUVFY1FjWDN6?=
 =?utf-8?B?ZFJ5aU9JQmREZ0hkQ0lEM3dmNFNTeUM4YllkZEI4c2hkbktuVks3a092aUFi?=
 =?utf-8?B?dllzNFErZVpkMG8zb1dWampYY3lhekZwbVVBY29sZ2ZubExLNllXTTFNQlpx?=
 =?utf-8?B?OEk0NGRBYmdCQ2dEc3N2cVU1RVJ0a1JSaUZXMXg5TnZ3TXRqajRpTTROM1pH?=
 =?utf-8?B?RlFtZWVSMUtCa25rdzU2NmJCUG1PS2E4NU5GUUJDM0k5U0d4N3Q1bTk1VGgx?=
 =?utf-8?B?TkRITnE1WXRmUWdoVWxaVjlaQ3ErWWVLSzNzTnNYN1NUOFV3Y3RyWksxcUpw?=
 =?utf-8?B?eVJLS25MNCtKSndnbXlqQ1kraWNFdzlmdzNWMktORXh1OGZoR2xPYjBJVjVw?=
 =?utf-8?B?ajIwYXlXbGlKUEEyakdnSDdLTktodXhkeEFZN1FKQzl2WEp0UmFiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9c94c5-8341-48fd-e91b-08de9c5201ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:21:56.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc0dIGkxKxW10FJZE2QF/G72a/AyCuPAdqb3sDRd4+bxONBhe9VTJlKEhimS5HZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

On 4/16/26 22:26, Timur Kristóf wrote:
> Fix a few issues, some of which were inadvertently
> exposed by starting to use amdgpu_gtt_mgr_alloc_entries()
> for the VCE1 workaround:
> 
> 1. When the VCPU BO is already located in a low 32-bit address
> in VRAM (eg. when VRAM is mapped to the low address space),
> don't do the workaround.
> Previously, I had assumed this was not possible
> so it was OK to not handle it, but now we got a report
> from a user who has a board that is configured this way.
> 
> 2. Only allocate entries from the GTT manager when the
> VCE GTT node is not allocated yet. This prevents the
> possibility of allocating them multiple times, which
> causes issues during GPU reset and suspend/resume.
> 
> 3. Align the GTT address of the VCPU BO to a power-of-two,
> ensuring that it doesn't cross a 256 MiB boundary.

Mhm, where do you got that requirement for the 256MiB boundary from?

That is an UVE thing, but for VCE it should be irrelevant.

Regards,
Christian.

> 
> 4. Remove a useless check at the end of the function,
> which is superfluous because the same thing is already
> checked above.
> 
> 5. Change maximum address limit to 0x7fffffff in order to
> reflect how vce_v1_0_mc_resume() works.
> 
> Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 2fe931366985a..55ea6765c03b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -531,18 +531,29 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>  static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  {
>  	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
> +	u64 vcpu_gart_alignment = roundup_pow_of_two(ALIGN(bo_size, PAGE_SIZE));
> +	u64 max_vcpu_bo_addr = 0x7fffffff - vcpu_gart_alignment;
>  	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
>  	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
>  	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
>  	u64 vce_gart_start_offs;
>  	int r;
>  
> -	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> -					 &adev->vce.gart_node, num_pages, 0,
> -					 DRM_MM_INSERT_LOW);
> -	if (r)
> -		return r;
> +	/*
> +	 * Check if the VCPU BO already has a 32-bit address in VRAM.
> +	 * Eg. if MC is configured to put VRAM in the low address range.
> +	 */
> +	if (amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr)
> +		return 0;
> +
> +	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
> +		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> +						 &adev->vce.gart_node, num_pages,
> +						 vcpu_gart_alignment / PAGE_SIZE,
> +						 DRM_MM_INSERT_LOW);
> +		if (r)
> +			return r;
> +	}
>  
>  	vce_gart_start_offs = amdgpu_gtt_node_to_byte_offset(&adev->vce.gart_node);
>  
> @@ -553,8 +564,6 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  	amdgpu_gart_map_vram_range(adev, pa, adev->vce.gart_node.start,
>  				   num_pages, flags, adev->gart.ptr);
>  	adev->vce.gpu_addr = adev->gmc.gart_start + vce_gart_start_offs;
> -	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
> -		return -EINVAL;
>  
>  	return 0;
>  }

