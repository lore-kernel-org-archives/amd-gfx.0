Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71BFF588C1
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EBA10E57E;
	Mon, 20 Apr 2026 12:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vlScVNbb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF99910E57E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOD6nIB5aMWdmXpFUW02zP8zXIxde62oDTeGG+vIa5BU5Ih2LBYDDBj+kFKx6W39u/KSKfw3rfyGSyxfjOhBRitLqn0382SpFQC4hGJmqNXsE0+u11m6uM0RUVs/VEQkBSsKsX7EW8J43dS3XEMtZsaXDDSvcYadtf/u4K/JlP7qnSBU4CYDaklW8kw2ZblUifQX+FDjbLTUTIbxWCL2ukQlqmxW+FySNXA9QytNNfWS0r5QIAJHiJ7e3rDvguoX7h3wM4H6HN5sfZl9CesNTePeIRf1tKLzJ0qWlLYALlE9M9adMCCkwEEMhf4v21aaRpAjkIU9JH6pdT0ug7yVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJT1Kb+RsAJmDKDM/xKhWJTOA4U4fjtuxUcDR9sSdm8=;
 b=LpGMMWkVga1K7hy0r/lVyqbhkg75Wn0lU3Kcj40Rt5hLPPM+zJ4LVzfU+4wcOu9fBnYD9j9UdqrrXOiYdgi9SO+HjuXtcUnV8bhmIWY9QhaFeNhDIB9KWTvgGWmLL0LsTmDd54FH0n0IZ/psqKtYuZ11q2deVUZX5xrZ1zspkrlks4M3ZndRnZHkI1v8Nez680B7B9D8xlQXCFOAYbqK0xxwlTv80t4vJaLEwspH/McF0n/ukqrcmZqon8E5yK/NAFmgxv/z1atdMsHv6yCYAbUCKYA1k+ZzOUET8cAPOr0ZVUPq0Zm2RBi+WGPHZ7MpNR9BpElkOkL3Pu0QJS8n9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJT1Kb+RsAJmDKDM/xKhWJTOA4U4fjtuxUcDR9sSdm8=;
 b=vlScVNbbMt6qKivcArtyNpHBtV7UwZIek28T7kCkAWQuT6VNQYNlHoBK47fOqoL3J8P9r8KhLKqNi6n8QJB6TwtfV+OBlip/ZjmSqVHng1CG/D8UPdMz5qwV4QFG3x/iJ6sIJISz7M0Fp7cVrivyFDFdy+PPdclX6Xlna/xt90o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:27:37 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:27:37 +0000
Message-ID: <06ef40f1-e019-44cc-965b-16c20d76b46e@amd.com>
Date: Mon, 20 Apr 2026 14:27:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu/vce1: Align VCPU BO GART address to
 nearest power of two
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-8-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cdefe6-0a30-43cb-6190-08de9ed834c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: TNTptClo+/9eA/oMXmnsvndhRZ10xIJ0/txq4mxl51YvsrfRJjygbq4yKJpxH8OXcYjY59ljh0RwPCYlOtuW3JPR1ZCVLjQfJq/63D//0DjspKFgm0otY8l4HdzWwKblnGNaCIJOF2Ryblt+sWH+2THEi4+Nkqbf0lE+ByEou1oiYrkVWxskmxTeLZb51ITVRTEQ5Lx14+hphj469CypUjIY95Sl7Jc75T8Ne4fdZNGgIvMUf76lMdV6GudDh7dw+bCkPq3EXFMml9PR6y/jGmBSLUAn3/Z+7bB7jhLiRM5bqLEihuaMTVLosRvJuHYxs4HnU+b6VEDpHdzXGe8Dl4zjJ+N+sGAWvZNCg5cAu390oLGQrDlqaAoo5eX0Jo1MWClcd3sFkl4vSjKe8zK2Oj8f/pT/XCYnbhIaSI2dNJMBP2laLd3XrEn+sVxgSotaH1QCH6bKgxXxlR5b8JuwqlckpLom7wihNn6sBM2nw4tgpfArCcraNPh5xTcV8aLV+HDIUicNp2ZWRNywXhqvOgxOPeAE41PlYwK/dMZaw4moBCKWPFTNRAOnN5gf6wajBjlKqEGoUpBrhT6ViY0KNqtK9209a/WnUOIlW+uuEGx/+4imGAjSyEbSIKdtNFMo48qDUuMVhqJNkvgN0DvBTvsIlklXPOm0uCE06O3sGOwf/bolfgkJd1BhUM8Imjp0mAQWcvtYoB2DdyNs3tBtuRPhU0qb7SPz0I+9INq8rrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUphcTlQN1RTbWIxUWpPSzA1L29IcURVdnpxTlZWUkgxaFcyWkJKTzFNZE45?=
 =?utf-8?B?bGVQOE45U0hsMm1sV1JseCs3ZzN0Y0RLSkNrZVJESnoxenExS2dyRzRnR24r?=
 =?utf-8?B?SGRySGVGYUZEdVhQQkFjckJLRVM0QnF3RFBjSTVXT3hQYkYxUTAzTS94Q3k2?=
 =?utf-8?B?SUE3d2RvYWtnYU1lODJnVTV0QTNFMnRJWUdYS2xIeVZ1YkpHVUJ5V1I3NkNF?=
 =?utf-8?B?WGRVK1dPK1NDMVgrRWhFNEkxb3VNcFhpejBGYXBZUDRuSmRhaHNweFQrN0ZC?=
 =?utf-8?B?WjJXT25GS0t0QXBwT1o1QnNjVXBhMWNRZU5GN3ljdlZXc09ZVU5hU293ZE5j?=
 =?utf-8?B?Q0FnSmNJeXhuakgzdVV2ZW9YUHpaeDAxd2VrU2p2dHJZTjd6aWZJQmVNdHN3?=
 =?utf-8?B?ZGpwUEM3WUtzRkxyZTBNNjdLOCt5cUNlU3AxcDVxTGwyd0V5Z3lmSExhT3M5?=
 =?utf-8?B?dTJ1YUpBSVczZUtUeFMwcmQ2ZjBTOXR2QTVkNGxWcGJTd1YvRVE2N2MrMWVj?=
 =?utf-8?B?NzB0YjRYdjVYem9ibVduVVhycEFXTWYvMENtTkxOZW9tWGFQUjE5VkdGR2JL?=
 =?utf-8?B?bktJdHByZjk3eE9hSGpQU0J5SzAyc3U5c2dMQTZ0ZjE1clZHZFNZd0pIVGVM?=
 =?utf-8?B?bUZ5K3h0YmdqbWFLRWRraWhtYnBJMWsvNDQyRTVkZGNTQjA1cXhlSDZHVDVz?=
 =?utf-8?B?RXMzcTFzM0YvUVFEQWZjT3hZOTVFSFFocEFjYTN3ZEVhRkczQWlUdktMV09H?=
 =?utf-8?B?VE1XU2lHeFY1cmlBTFA5dFRnY3Y3VGdHVmpqR2p2em5LSUVvSERZYXJGZ3or?=
 =?utf-8?B?N0JqQS8xQVJhZmhjNkYwOG5OUTJ4RDAya0RPekFqejYvc3BxTVpqYUI1U2Fw?=
 =?utf-8?B?dTVzeHoxbkVuL0NHOWZQWVE4UFFoemNWL3dDd2d4RGhlZDVlSUpRYWFJRUlM?=
 =?utf-8?B?VjNobnRnOG5XU3p3ZEpmL1Z6WFp4M25vTEJ2TU1uY0ozWkVzQmZwUXpGdHBC?=
 =?utf-8?B?MFdheTBwWjFQMXUzYkhnMk41T0ptZjZRT0NmWlBsQlBLcTJFeVNYdjJrNUxs?=
 =?utf-8?B?SVBCY3JIL09mOTZRUE5EOTd3bnU3RWh4R1piWitpWlovYmRTYU1XMU16UVFI?=
 =?utf-8?B?WUhHZkx5TGhQbUxIOFRJR0FONlFKc2JYWS9PTVpTN0w3MXJFL0hFSkNrTm13?=
 =?utf-8?B?WGU5R3lDUFNCMmhwVnVsTG1XRUQ0NVBYMExQcElNakZHVlRHNEJQbEdXempr?=
 =?utf-8?B?MG9xWkt5dXBPeENSeFdkaFZhS0Vmem1Mbk9oTnV5dXVCT1REcFRJbUNFUnQr?=
 =?utf-8?B?d1Y4MnVuUnJHdTlLcDlnQlYwSlBickRGQVlLZEp3aXY1UlE0M0FmRkRrb2dN?=
 =?utf-8?B?NWlOc1ZQSTQxbWo5eFpHS2FoaWdHS0J6am9ra0xPaVZGSGFUcEo4ekZaTmc3?=
 =?utf-8?B?NE9iUVdQVG1kOXdNZ25lWnNNSitnSUNEYUxoOTF0ZE91NVJEQ3FYaU00aFha?=
 =?utf-8?B?TkdwV3JlU1k1ZDlLZSt5OFRuOU5WNUdWNGZtdWFQMmZYS3U0Sk52Nkh4NHU3?=
 =?utf-8?B?UVRHV3RFeHRxKzlDd3QxYkdnS0w5ODlROXB6SUVZSmxLODF1RGRrektLL05V?=
 =?utf-8?B?bWhKN2FOTUNEM01VZWF3YXM1OGFtYkRVRGwxTHBSQnVFTnN1S1dwdUpHTTVh?=
 =?utf-8?B?Syt0UVhIYkMzSHhyL2F0YnplaVpXRngvRVpDSkVtYUd6UmpQUTJDMlk5UG1k?=
 =?utf-8?B?UFYzTi9leDRLa0xiVXV4L0pHeHI1V2czaXdJNEFEOHlLVGZmbjJLais0VTZK?=
 =?utf-8?B?L2w4dlJMUnBDbHdGUWx0eU9rSFNSN2pUUVlLNWlzVnVpLzJJeUNTV0NLUmda?=
 =?utf-8?B?dytrdGRZSHNna2xXclhoeHJ2UzVxTmdNY3ZPL1g0SVl0UEtkQnhxMkUzUlBH?=
 =?utf-8?B?WURQWjhpd1FrRDRBWTVGSUhDWVNCY1RxOEQwSjBNUUtydFRuZ0VHVkN3SEgr?=
 =?utf-8?B?Z2ZWNEw3cTZ2VFIwZE91MUQxZnkwOXFFU1hzbmxvbWlySFUrOWRDTmFXVmQz?=
 =?utf-8?B?VnJRZHZab01WY1NIbEVQK0l1TVROZjdnSjZ3Sm1ia2o4Q3EwNTExTUkvbmRq?=
 =?utf-8?B?YWExNW5MUjVQK0dZSWI1Y1hjMzl1WkowN0NDV3M3RUZsWE9vblN0dThPT0hr?=
 =?utf-8?B?aVdpNFExTURYdkNZcWNHcVJ4WitYRWZnQzF5OFloSFpxby8wZ0QzUUdXQXFF?=
 =?utf-8?B?RnFiMk40bUxEYWl2NXZrOU1BeUxFYWdTbGxmcWRhM3JUNi85QzkzeVp2TCtF?=
 =?utf-8?Q?NvauJnauadGsDghakJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cdefe6-0a30-43cb-6190-08de9ed834c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:27:37.0056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I2xcy/kUuZ48qvdvN7TJDjfuMUMmunKyVNfKLIIx3SdXa/4DWBvFNeRoP+haIDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528
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

On 4/20/26 14:10, Timur Kristóf wrote:
> VCE accesses memory, including its firmware, through a BAR.
> It works slightly differently on each generation.
> In case of VCE1, the start address of this BAR is zero
> and we can't change it due to the firmware validation mechanism.
> 
> Align the GART address of the VCPU BO like the VRAM address,
> in order to prevent it from crossing the boundaries of its BAR.
> 
> This fixes VCE1 initialization failure after suspend/resume.
> 
> Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 100aa48204c77..9ddd635449873 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -527,11 +527,17 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   * To accomodate that, we put GART to the LOW address range
>   * and reserve some GART pages where we map the VCPU BO,
>   * so that it gets a 32-bit address.
> + *
> + * VCE accesses memory, including its firmware, through a BAR.
> + * It works slightly differently on each generation.
> + * In case of VCE1, the start address of this BAR is zero
> + * and we can't change it due to the firmware validation mechanism.
>   */
>  static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  {
>  	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -	u64 max_vcpu_bo_addr = 0x0fffffff - bo_size;
> +	u64 aligned_size = roundup_pow_of_two(bo_size);
> +	u64 max_vcpu_bo_addr = 0x0fffffff - aligned_size;
>  	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
>  	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
>  	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
> @@ -543,7 +549,8 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  
>  	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
>  		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
> -						 &adev->vce.gart_node, num_pages, 0,
> +						 &adev->vce.gart_node, num_pages,
> +						 aligned_size >> AMDGPU_GPU_PAGE_SHIFT,
>  						 DRM_MM_INSERT_LOW);
>  		if (r)
>  			return r;

