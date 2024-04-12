Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F825C04FF6
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 07:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5837E10EEDC;
	Fri, 12 Apr 2024 07:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUx6iF75";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26DB10EEDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 07:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki4LSd3hMO14SnRF4wjr8CEmW84tQpvi94amyws8GixeQb+m3FjBaEqNHoqxp2I0uD4YrikW7dxk3Zp67V5wq4/X1FM5omlvCWnVaQE6I8GTjPEzhWTDW2XoFz6gcxm9gc7aTUuvTEIOm8bSURszO7INsRgwy/d55DwQ4rnbU8tScl/WhnPoNDWenvgSey/KpnCRloF61C2C1MPLq5EGzbc09CfriCFlsPp6yElE/PxFKEUdc8jtQlhTthjVylmDliafOfpiOKKg6gfsPbObMSU/PSsy6bKys1NkCcRf+KckkbfJzrF5BDdLWnKGzdZ+FVOtCJs4wG1RLAkxO+zirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlKxI04aCDlcJkt1+t1oPyyEXom0rLiMeotnmV74Pps=;
 b=IgSDhIvzkp8zDEyv4R7FPScKNkK2QCrk26n6qLPXaDEukyT/nnugUu+6+br+dK7wuAttd+L9Yo9CCf4BcraHL7xoTAj07PxwcTXSldS3n8d3+MKWdMCNVG7Lj73l5zGNFAMSg7laMPWWPEXTa5qD5cjRPFQtNqSXKBIwLr2Nw42f7uMi77Gs15o3kZNzhR8q6+46ejx/6/KCmZDZAXF+CpZqoLhmdwRHqaSSAZe03F0OEGdkBemm3bAnAmBXbrtgYcuI39IO8MjAsg6zxTyjBzXz9VF9Ol02w1UCCbKKw++gDSKKTaOOdMccb9rhe3KlGXN419BH1Fvm0jyYQwzWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlKxI04aCDlcJkt1+t1oPyyEXom0rLiMeotnmV74Pps=;
 b=hUx6iF75kAOP7U+mFfUJw2gjxK5vznFUtsH9KAKP8wJZecSVRIbTvl02KJWGy1w1o5w4EMlOJfq5NTQr8/FWwBjIK2lTq2W1WpehLv9BJfiZncPBHVw+2XuZuLeVZQch6BXPJrW5jtOq5GA+ZKqdsnkE9ECnSnWUXk+CEHhhAQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:38:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 07:38:10 +0000
Message-ID: <8c226efc-18cb-44bd-9929-3680297e43d8@amd.com>
Date: Fri, 12 Apr 2024 09:38:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of bo mapping
 operations more clearly
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, jannh@google.com,
 Vlad Stolyarov <hexed@google.com>
References: <20240412073544.10008-1-xinhui.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240412073544.10008-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:118::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c91690b-4baf-4146-6222-08dc5ac38083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvlqttXk174HwMjfuuGL+MSQcV2QuG0fMaIobGwkSJMHrapnGckJOqF73GiqJ3HqGLNVC+zBJwQXZkUPk/xSdZGbBEqadYvxVTYAOaTJbzZziGgGdgx1MGHnzfJdh5rUzqDz5hlQzF3pwR0gmOIxNd2zKFE9vSUdaNe2/9PZfLXneS4DTExnu+3epoA79H7/IyrcuaQ90bEIId5MCZmqCU1UQxXi+GW4p08HtsBBbjeNw+jjN0Sc2TR3IdYhIssnqmdSAkuJnnGb+63ftuGgH+Ax7Iz+3dDifo/kQoqcVYVX+2b6tsWbF2g4eT1ELrNj6xIb8NKntZ4yh5AJvYpiY/bH5jVCS0viHbcMxmflIwX8S2bg8m93+q2jTFg+ejriAF471/9z+dEPYsa+ODpYNLRHRh9Mbj8ogaVO/Yn1RJChBDgCOiytXpDhjEBsOgjmew7/shzNSVz900yxisaYt92vYfq+Nw6ZvToxr5p5E3CXTzQP1iIC/jGKG18VQZvfp8qBz40wZwuyLKmdElwuOV8P98xvB9uz9bXGro87LkzdznAmWTPDfpahrheHsHjHwQGvKc+49VdMIvx48Yi9ah1fdrHF+NoKqHVjrMEEBmEXRBDmM1NgDwaqUc7z5XpM0V6NMctPgFQtsiDSJ1A/u4fz0gD8uFOaBZLsXUnvAVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndGN2VwSTlBUEZTaHBGYVRweENzbjBPMklsRHBSTENBZU5DenJrdnZDSk42?=
 =?utf-8?B?ZzZpbGxxQk8vTDBNaVc4cVMwTXZYbWF2L2Jwam1Tbit4U2t4bDdiQnVuSmln?=
 =?utf-8?B?RFdub3M0Rmdjc1I2N0lnRkdRZU0wYS9HcFZXMEdmZTZmOEZ3RzlONS8xMWFF?=
 =?utf-8?B?VTdXdmdHa0hqcU9kTk9tWjdhZllPWUFBYjVUTk9DVlVDbWJlWW1nQUthTHJG?=
 =?utf-8?B?RDFHK1REeGN4N1ZxNmxPMWFmc3UzbGluYVBYQkRLN0JHZ3ZPcjRUNUNXYXRn?=
 =?utf-8?B?WmVGSkRVUW9QZ1JHN1R2SHNwNDZHaHFuZWgvb1JYYndPVGdhYWJoNWVUanRx?=
 =?utf-8?B?UzR4ZEtKaUYrbGJxNDdWU2lKWlNPQ21ORUpSRmlXd2tLUmhyaGlFSFVJWkYv?=
 =?utf-8?B?NWdqK1JlaldaWWNUaW91V1U0OXY4T0RDVXNSdXRQd3dVc3IwcUlzSlJ6NDRS?=
 =?utf-8?B?MWZ3V3ZUMXRKNFZsbmdMZUlQcU15Y245YTZrWDg3d2NpcGFvcCtOTVNaKytl?=
 =?utf-8?B?bVBEdW1DaTEzNkJocUdWTUpRSmUrL0JOamZST09CWjhBRTVKdkx0UE9naDJm?=
 =?utf-8?B?a2Vtc2p2a3BqTjBycGs1azZIN2JuVW9ZYWxRSVk3VjhDQXNydHgxNXZSdklJ?=
 =?utf-8?B?cVVjUWtKN1Q3OHZYU3U4NTVaUmhFcFB1SWdPTzhhZnFSWVNLQ0k3cXVCRHJY?=
 =?utf-8?B?M0FkUkJNVVJiR3ZReWM2TlZuRnpZY0hDV3crKzQ2RVl2NVB6ejRVTVNEQmFU?=
 =?utf-8?B?NWVkMlFWT0l0YW9xWkhwY1lmTGFSSURZckxFWW9QNGc1YkVGL05adExhR1Nr?=
 =?utf-8?B?VmNETjlvdWlrK01Uak5nRkhBNm5NbGJCSDFaZDJqM0pmQVliZE9NMVV1RVJ4?=
 =?utf-8?B?V0tQcUZUN0pBVHNyRGJ0UVNtNmExSzc5aWxIeFBJOGdjdjZyenpnTGlCbGNB?=
 =?utf-8?B?aGNCYThxaVAzVGpzeUd6dmdpYUwzMDQrcC82ZnU3cGdNOW5TcWgycDFIbEY2?=
 =?utf-8?B?V3d1eEMxM3NqdG85czBKdzBTeUErVVlkNXVma1JQUFE4U2FlTFdEMEUvL29I?=
 =?utf-8?B?QXE3dUlyd3VKUU1NM3o3a0c4UXlOZW8wMGt3Nm9qb04yb2ZCZDhYSG0vLzJk?=
 =?utf-8?B?VU1yblBONkZ2em5ZeXZGcDJyS3RrbkwwSmpZdU54amxCb0ZhWjEvQlFNYTJo?=
 =?utf-8?B?Q2c0SC9HWEI2UlkrQ2VabzN3OHNWbStPVjN0M0VjYVBGSXN4NHY4bnErUWVD?=
 =?utf-8?B?Tkd2WU9aaU5BVFIvZkxWUVduME9BY2ZhWTVFT1RQanpxdnVqRFJPZ1krWGQw?=
 =?utf-8?B?aDNEL0NEMHJJVkZxbThLemVxMmdibnY5alhWWGUzc3NGcW0rcElldFdBWis4?=
 =?utf-8?B?ZS92d3lCTTZwbXRGYkRzOW5wWUo5TU02eVBiVnhlVHNnMjNOdTNHaHlYclpl?=
 =?utf-8?B?RTNpT3Q0K1FJc3d4Z3RCYyt6TDhWeldzcXZVekhPR2hSdUJabDR2akpqbnJI?=
 =?utf-8?B?MFVvbTNTZFlBQmpmNFdZTEk4QVpuUWhOcEtMdDZEWVVKc3lEREpjaVZlVUh6?=
 =?utf-8?B?TDB2ZEoxMnQ4a2gxeVBIZHRpMUEzYzRtejQxUFV6SFpncGtzWXUzL0ppd3lw?=
 =?utf-8?B?MEl2YTBiUThVNFhRY2p0eUxPbHpjMzRWMDZmZWxEcitJZk1WMSs0eVBNMENi?=
 =?utf-8?B?aDNCUy9zbU1WSUlEMjloL0diY0xzN2tDOCtBVlFDeEE0T2tNZnFOSFRPUFU5?=
 =?utf-8?B?Rk9WUXdFYThhMFF4djNrNXB1dnhLeU5sR2V0ZFpUeW5vK2l5ZS96WWRCSnBG?=
 =?utf-8?B?MDcyckNlOTNKYnV2ZzZVdlJHc2Z2cWpMaEFRTU1OTTBMcXQ1blk3UFo1T1RV?=
 =?utf-8?B?TjZkZDQrdU9rc01NWXpwVU5ybXZuZS9VZGJaQ3R0Y2E1b0ZDOTZ5MCtpMmpU?=
 =?utf-8?B?Q2FqVXJBYlpRdXFEMmFCc29DMzZSc2pqVklCNkNKaGhpSTlBTms2aFZ2SFRp?=
 =?utf-8?B?MDJLSVJDdldRSDZWZEhRbVpqZG02MUpkVDg3dWNtK1phRld1N3lCcnNXeWRj?=
 =?utf-8?B?OWQxeC9Ram85b3hvckZFYW9lV1NVa2FNRjB1emh6YVovaUZyMnJTaHhONjNG?=
 =?utf-8?Q?Ut21bjvDduoaDAfEhz1uvq/KZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c91690b-4baf-4146-6222-08dc5ac38083
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:38:10.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARtc6uM6jUsO/dd61ixaaT/jPEphBtYxvalV+2/Vrye2L5u6ZicgUfiULHXE7Ccd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

Am 12.04.24 um 09:35 schrieb xinhui pan:
> Verify the parameters of
> amdgpu_vm_bo_(map/replace_map/clearing_mappings) in one common place.
>
> Reported-by: Vlad Stolyarov <hexed@google.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 72 ++++++++++++++++----------
>   1 file changed, 46 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..4e2391c83d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1647,6 +1647,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>   }
>   
> +/* Validate operation parameters to prevent potential abuse */
> +static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
> +					  struct amdgpu_bo *bo,
> +					  uint64_t saddr,
> +					  uint64_t offset,
> +					  uint64_t size)
> +{
> +	uint64_t tmp, lpfn;
> +
> +	if (saddr & AMDGPU_GPU_PAGE_MASK
> +	    || offset & AMDGPU_GPU_PAGE_MASK
> +	    || size & AMDGPU_GPU_PAGE_MASK)
> +		return -EINVAL;
> +
> +	if (check_add_overflow(saddr, size, &tmp)
> +	    || check_add_overflow(offset, size, &tmp)
> +	    || size == 0 /* which also leads to end < begin */)
> +		return -EINVAL;
> +
> +	/* make sure object fit at this offset */
> +	if (bo && offset + size > amdgpu_bo_size(bo))
> +		return -EINVAL;
> +
> +	/* Ensure last pfn not exceed max_pfn */
> +	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
> +	if (lpfn >= adev->vm_manager.max_pfn)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_bo_map - map bo inside a vm
>    *
> @@ -1673,21 +1704,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   	struct amdgpu_bo *bo = bo_va->base.bo;
>   	struct amdgpu_vm *vm = bo_va->base.vm;
>   	uint64_t eaddr;
> +	int r;
>   
> -	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
> -		return -EINVAL;
> -	if (saddr + size <= saddr || offset + size <= offset)
> -		return -EINVAL;
> -
> -	/* make sure object fit at this offset */
> -	eaddr = saddr + size - 1;
> -	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
> -		return -EINVAL;
> +	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
> +	if (r)
> +		return r;
>   
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;
> +	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   
>   	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
>   	if (tmp) {
> @@ -1740,17 +1764,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   	uint64_t eaddr;
>   	int r;
>   
> -	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
> -		return -EINVAL;
> -	if (saddr + size <= saddr || offset + size <= offset)
> -		return -EINVAL;
> -
> -	/* make sure object fit at this offset */
> -	eaddr = saddr + size - 1;
> -	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
> -		return -EINVAL;
> +	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
> +	if (r)
> +		return r;
>   
>   	/* Allocate all the needed memory */
>   	mapping = kmalloc(sizeof(*mapping), GFP_KERNEL);
> @@ -1764,7 +1780,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   	}
>   
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;
> +	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   
>   	mapping->start = saddr;
>   	mapping->last = eaddr;
> @@ -1851,10 +1867,14 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
>   	LIST_HEAD(removed);
>   	uint64_t eaddr;
> +	int r;
> +
> +	r = amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
> +	if (r)
> +		return r;
>   
> -	eaddr = saddr + size - 1;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
> -	eaddr /= AMDGPU_GPU_PAGE_SIZE;
> +	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
>   
>   	/* Allocate all the needed memory */
>   	before = kzalloc(sizeof(*before), GFP_KERNEL);

