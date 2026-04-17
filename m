Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75059F436AB
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 14:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE1610E2B7;
	Fri, 17 Apr 2026 14:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uTmj+q/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DED10E2B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFlxLAh+7O0kTADw0QTAcdKHx+aTjhzDqPotAgsK+yuIkL2AKDMzQg0S55IKIf4EIB05LsLc894QX8ruTWgtLEVOXRi3BGDcLQ5TqSSDf7nLO8FQs5DY39VMFARY4eMBqfdWGmFPZEu3qH4NwOIHNpfAobQDPg7hhcOmDLWDDgG69RFZpX4gx71zggd4uzhl79XFGWh+X/RsOYM0q3aDcZU9CXkLzW/Mg4uSKfu+Bi8ds9XaJWhtQyM8/gNf6Hl06kkAd2E3FkvEomo9O+V1QN08lzAOLzRI8Waiu5VAhTMf2rP56dzqwm0YGZPKUrVdZfwb5ETKhg6CcQUFC6MfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4iFrZuFN4yHYdQh9r5W7dFj0GeiPWXydfL6wdiheFI=;
 b=sRNOkjoYbNTn6vIBaJbTJ/TNw05gDK/sCrvd1Dtw/TGz2Kazj7ZjD5+aXNW6Nun2b8e3UnwWYBoE4N2KIAAx+J/aRUFOKgvsYMbjEx1ayZIodGTuov04F9y6FCQmLXW5ExMewX2ljAaXR6HXsJ8U8wTe0lvZsVrr08Foh+RunTG7W6BfDIsm/zB9fQPFXBE7CiLbh/EaaToSKJ4ZuxW62J7xWPs2DXZH+iHvWJYVpU9k6LMIQbt0UOLnMWpMjWc5MciFTN6QgFYpjHBhq/EQ2/q1+zO3aAkvvpusCsYkc0q0sUGe53ezsuZHwuCqWI+Ia/Q61qWbzScoJ779gicBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4iFrZuFN4yHYdQh9r5W7dFj0GeiPWXydfL6wdiheFI=;
 b=0uTmj+q/5inmqYb4NiBqJRM89sDz3uqPBtF7MuweI4PVm6j3OmH7NRS63q8V1sPMOb3yEnvO5BiMS/RSnZv/QzV8UWFcMkhR/qZQTUy7/Wpr4tqvcl6qlliunKfsprsJux8K7GFRHKEs1dG/h1FaD0uX4GZ0LLk+1mdLybzQjio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:04:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 14:04:11 +0000
Message-ID: <b48fb991-9d12-4299-83e4-936a60267bd7@amd.com>
Date: Fri, 17 Apr 2026 16:04:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move VM PTE MTYPE override to per-PTE
 granularity
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Kent.Russell@amd.com, Andrew.Martin@amd.com
References: <20260417135025.3434482-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260417135025.3434482-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e14088-c963-46a1-f1ba-08de9c8a334c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ew/MOsjce3ZeA51tjdwcdbX5f/2h9FQUoaowub6iFfYkVrlusNZuETwa04Q8zEkt2aFA/PzHddubx4cLWhLASeJQNXiHCDhbaEGVmCayMRPUdTEeIoEt76JuLtFKQhkzKYHvi9s5bspDGmlqC58pJKWHtT4vDOjojzPHwJbG+GKJbs26xPWJmk/4MobHaRtPkpr46vG30jsP8b0/LAmiJFv+wnnLiwC5R5SbSJ7mQl0SZtsS9rOyQ20TJTwNBVDgkSlT2bGJV6+/mBFThhLQfICBJ9r+QrxsqfO8nnluDyxuf2PduSxgePn5ndzFPxXI7IxAwCk/xpwLHa8tLiSm1r9cyHM7Jvh5Y8O/DNtZfWGO2dHuIFYdFt2YD4iXyYatCfgj0avyHlveHd0t91251OeZiY0TOEZfOD5AbNvQUn0KHV9+nbk7R15gzEePughxQ3s1MgZyi0jivienEr+MYLHmtr8urT+LEvsdjVVW78OAVlWtbsXP1I1oUTKqpvkT4nGyvhJSk2/klZfCFuDka6FwFYOKO6AD9KJ7yxQyITpo6VymbP6CIZOuZJvP4c1fF1CqPBYSh35vjlRdHwEzBxljc0vVQchR2F4TaEHe9CzhW/lGmmFSxfdJiFVMB/7RP31v8Z4Ifq5AxpPMrAhvsok9vbtwASVQl7bw3s/7LtV6MgxEXhT1CVBls4BIctphJrhWUe5XB+5xmkCLSHXfjiHKdM/HbTA+LK4HnKyoabw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZDVHZLNUVhYUJnZ3RENUNXb1l6akpUNWdGcUtpRGV5TFBaUllLN2p2RURU?=
 =?utf-8?B?RS9Cd3NNT2lxOXRLdS85eGNRV0F4SHpOL0cvcnBXY1djdCtwYkJ2T1VNTDlP?=
 =?utf-8?B?RFRZS0tIbzk1NkxHV3AvMDJXVmpzSWlRdHphSkd2MHpnZVBZZDdlWUpELzRu?=
 =?utf-8?B?TStNenJ0c1JPdFYxcFFEbG0rU0pGa1ZjM1puTklvZllBdkFtRStMNGNZS3R3?=
 =?utf-8?B?eit3cVQvbVQ2UzNwekZTRnRWUDk5UXl1djZLZ0c2bU10V3F3ME5GUy9rbFRE?=
 =?utf-8?B?elFTUjhzNCtKTHVLaXRlUkZLMU1xcDhZOEM5eVpOUXBQdzFMQWRIeHBMeUky?=
 =?utf-8?B?aEpaNW9MMUs0OGZjUU5kQTdTWnV5ejZhTDczTjRhQTJncEJUQ3UxNjByWnNp?=
 =?utf-8?B?cHFzOGRTYkw5RnVZeDdkNkloWXZTTDBWcWtIeUtKa3c4THgrRWVTUVozbVhY?=
 =?utf-8?B?OVlZcndHYmY5WktDdUdlVzQwejJidTlBTFRTbDRLNEViQWZ1NkJSY2Npb2hv?=
 =?utf-8?B?OEQvNlQrQmdyV0VlL0JNbnYzMDNyQ3RMOGhuNUxvd2YycDhkcGhiNUdJaFli?=
 =?utf-8?B?MGxVNmdsbFBTRkhKNEVlRVdxVWoyWDI3WmxLQWo1MmVYd21RU0huNnMxeW00?=
 =?utf-8?B?bDhVZlV0MDJqc1JMdXhGR05aTXExemk2Y0VkVHVrZ2JhU0hodFhIc25hYU9j?=
 =?utf-8?B?Y1B6TUdYTEpqTXBETjU4MVkyNktYUTJuWk16NkVlUWRtTHNVQ3VrNWJCRER0?=
 =?utf-8?B?cEYzWllFUjVsYTBMYlVHRW9oSEhNOEJiajJkTFY5RHlDWGpydzN1UXV1dTh0?=
 =?utf-8?B?WUYwVlByUHNqMTlqZ3lTdGZJODFJR21xblA4SE5RV2JGb2RzZmNYRjhjd00z?=
 =?utf-8?B?TjY2aDNXQmYwNm9sSjc4Q21RTW5SRkY1a0F4LzhGeVdGRFBGZC9vVUxSNUJr?=
 =?utf-8?B?OGlrTTlCMkhIV2N1VGxUMDlqVDA0bUVnL1ptNGw2UnpTZHMwSG9vc1RqZ01o?=
 =?utf-8?B?Y1BLWE94Z2d4RjdWZ0J0SWRoc21HalpYMk4wUkRXbDBjQ3BwU3p0U3hReUVr?=
 =?utf-8?B?SG0rOFJ0SmJuSjFvWWpobjNmTHFYdVA3em9qU2pzeXJtdGJWWkpjdHZwTnR3?=
 =?utf-8?B?dWIyam1PSFR1dXhGZHd0WGRIejg5anZBdVIvbDk4R2pmK2M4MFpkaXozTGhz?=
 =?utf-8?B?THA0cEcrak1GYy9kc2k1ZjJwK0FCQkRFT2JUVGx2aG90clJOeUtmWDNtZTBx?=
 =?utf-8?B?Mk4rc3Zva2srRmtmSWkzQTZ2dzZXNS9VaktxNEQrL21xR3crV0NxZDRsaEpF?=
 =?utf-8?B?K3VMTmViZUNvSmkvSm5vdkF1My9GVTlNa1lvOHM1Mkg3MXR0VTl5ajdxT0kz?=
 =?utf-8?B?cDNReXdiMmJqOUxSWDhyMXdGTzZlQ01NN2xDWnU5czRpUXFLTmVUVXNqNnZL?=
 =?utf-8?B?UklyejdXclBDUGhzWnJhaGlYQ1hRVGNNK3BXMmJQNmhFTi94cTJIZ2YzbS9a?=
 =?utf-8?B?d1NFK3hiSmhOYjRadGJZRjMveU5abUNKVXpGRlliRmJlZDZiTWtzcm1hWnhB?=
 =?utf-8?B?OVBmWHE1cjlwTzlWMDUvRVBUeUQwc2FUUWdTeHYzMGVUcDkzZnRYeitZclB1?=
 =?utf-8?B?b1ZEUlBqdGZXZjFzTGkrOFpwSkIyT3NJTkxnTU5EVkZKdzVna3FkRFhrZ3d4?=
 =?utf-8?B?Rk1YQmFBemJhRU9uT3BxY0lCQ3p1em1Xemg2Wlc1VmRBVGllQ21sQXBkdzVN?=
 =?utf-8?B?TVBCTzkvMWlZRjRPR1cvNTJ2WkordGZ1L3F3SWVjYVlueFBtcTd6MW9zc2dy?=
 =?utf-8?B?a2FFWE45MnpDZ2E1bUIvbmlCaStMemhDUjFjaHpmb1BlWE1GYk1UOUhHdGpO?=
 =?utf-8?B?elUwWk5PT3NCVFlmSEo0d0hlMEFLdmZRa2RTSmNnUmNRSENlSUI1R3FHc1VJ?=
 =?utf-8?B?Q1FXOEtNejZEcTdYeFM3YmtSUWNxc3VrOEUrQ0ptYWx0c2FUS1Q0cnBiWUVP?=
 =?utf-8?B?SFMzTmZ3ZHFJQWtqcWJKc0Fibi92ZnZCY09RZ0E5dGZsZVVSWFhMSUpqWjlS?=
 =?utf-8?B?OUYrZlh3bUlTcWNOTS94SVdwUUd6ZERlWWQyUXAzZHFESnptVnRETVJmaTdV?=
 =?utf-8?B?QmlMNHpDVnNZNVE3VlRzeHRPamV2MEFQdHhjbWk5SjAvUFVjOWtxSWVDOU5z?=
 =?utf-8?B?YkJhcGp6RlV4aGlndHVyWnBQcE84bUFzRkQwZ0pIZHBBNWF0bmhGMk9kOVF2?=
 =?utf-8?B?WHBLNUgzcDZPREg5TmFpcFRFZTZjc0FUMkdrSW5wVlBleTBQd1A5bFgydkU2?=
 =?utf-8?Q?noukU1sasJd3j3R93U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e14088-c963-46a1-f1ba-08de9c8a334c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:04:11.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/sHDI7dnMw6Obypgp/AyG5eRmmCZ0IX5lSinIyfUrQB1Ma7HD4WJqk5ZOSU+nBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
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

On 4/17/26 15:50, Philip Yang wrote:
> Refactor the NUMA-aware MTYPE override for VM page table entries:
> 
> - Move the override_vm_pte_flags call from the centralized
>   amdgpu_vm_pte_update_flags() into the individual CPU and SDMA update
>   backends, enabling per-PTE MTYPE override including for scattered
>   pages (pages_addr path).
> 
> - Move APU, IP version, and direct-mapped eligibility checks from
>   runtime (gmc_v9_0_override_vm_pte_flags) to init time
>   (gmc_v9_0_set_gmc_funcs), selecting between gmc_funcs structs with
>   and without the override function pointer to avoid repeated runtime
>   checks on every PTE update.
> 
> - Guard allow_override on whether gmc_funcs->override_vm_pte_flags is
>   actually implemented.
> 
> - Move amdgpu_device_check_iommu_direct_map() earlier in device init
>   so ram_is_direct_mapped is available when gmc_funcs are selected
>   during IP early init.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 50 ++++++++++++---------
>  7 files changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bc7e96b58d3f..b139475f65cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3860,6 +3860,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	 * completed before the need for a different level is detected.
>  	 */
>  	amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_DEFAULT);

> +
> +	amdgpu_device_check_iommu_direct_map(adev);
> +
>  	/* early init functions */
>  	r = amdgpu_device_ip_early_init(adev);
>  	if (r)
> @@ -4117,8 +4120,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (px)
>  		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
>  
> -	amdgpu_device_check_iommu_direct_map(adev);
> -

That should probably be a separate patch.

>  	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>  	r = register_pm_notifier(&adev->pm_nb);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63156289ae7f..853204b5bd73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1163,7 +1163,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	params.pages_addr = pages_addr;
>  	params.unlocked = unlocked;
>  	params.needs_flush = flush_tlb;
> -	params.allow_override = allow_override;
> +	params.allow_override = allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags;

Prerequisite check first please!

And we should probably rename params.allow_override as well. Maybe something like override_pte_flags similar to the name of the callback?

>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>  
>  	amdgpu_vm_eviction_lock(vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f33ea7f8509b..326522917131 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -296,8 +296,8 @@ struct amdgpu_vm_update_params {
>  	bool needs_flush;
>  
>  	/**
> -	 * @allow_override: true for memory that is not uncached: allows MTYPE
> -	 * to be overridden for NUMA local memory.
> +	 * @allow_override: true for memory that is not uncached and gmc override function is
> +	 * implemented to allow MTYPE to be overridden for NUMA local memory.
>  	 */
>  	bool allow_override;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index f078db3fef79..fa5d4ac2ef39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -88,12 +88,21 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  
>  	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);
>  
> +	if (!p->pages_addr && p->allow_override)
> +		amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
> +
>  	for (i = 0; i < count; i++) {
> +		u64 oflags = flags;
> +
>  		value = p->pages_addr ?
>  			amdgpu_vm_map_gart(p->pages_addr, addr) :
>  			addr;
> +
> +		if (p->pages_addr && p->allow_override)
> +			amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, value, &oflags);
> +
>  		amdgpu_gmc_set_pte_pde(p->adev, (void *)(uintptr_t)pe,
> -				       i, value, flags);
> +				       i, value, oflags);
>  		addr += incr;
>  	}
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..883cc275f354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -707,15 +707,6 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>  	if (level == AMDGPU_VM_PTB)
>  		amdgpu_vm_pte_update_noretry_flags(adev, &flags);
>  
> -	/* APUs mapping system memory may need different MTYPEs on different
> -	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
> -	 * to be on the same NUMA node.
> -	 */
> -	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> -	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
> -		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
> -
>  	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
>  					 flags);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 36805dcfa159..37f0c0027075 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -257,6 +257,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  		}
>  
>  		if (!p->pages_addr) {
> +			if (p->allow_override)
> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, addr, &flags);
> +
>  			/* set page commands needed */
>  			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>  						incr, flags);
> @@ -275,8 +278,14 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  		p->num_dw_left -= nptes * 2;
>  		pte = (uint64_t *)&(p->job->ibs->ptr[p->num_dw_left]);
>  		for (i = 0; i < nptes; ++i, addr += incr) {
> +			u64 oflags = flags;
> +
>  			pte[i] = amdgpu_vm_map_gart(p->pages_addr, addr);
> -			pte[i] |= flags;
> +
> +			if (p->allow_override)
> +				amdgpu_gmc_override_vm_pte_flags(p->adev, p->vm, pte[i], &oflags);
> +
> +			pte[i] |= oflags;
>  		}
>  
>  		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e7b78027002b..479611e269b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1204,21 +1204,6 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>  {
>  	int local_node, nid;
>  
> -	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local system
> -	 * memory can use more efficient MTYPEs.
> -	 */
> -	if (!(adev->flags & AMD_IS_APU) ||
> -	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3))
> -		return;
> -
> -	/* Only direct-mapped memory allows us to determine the NUMA node from
> -	 * the DMA address.
> -	 */
> -	if (!adev->ram_is_direct_mapped) {
> -		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
> -		return;
> -	}
> -
>  	/* MTYPE_NC is the same default and can be overridden.
>  	 * MTYPE_UC will be present if the memory is extended-coherent
>  	 * and can also be overridden.
> @@ -1231,11 +1216,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>  		return;
>  	}
>  
> -	/* FIXME: Only supported on native mode for now. For carve-out, the
> -	 * NUMA affinity of the GPU/VM needs to come from the PCI info because
> -	 * memory partitions are not associated with different NUMA nodes.
> -	 */
> -	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
> +	if (vm->mem_id >= 0) {
>  		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
>  	} else {
>  		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
> @@ -1328,6 +1309,19 @@ static bool gmc_v9_0_need_reset_on_init(struct amdgpu_device *adev)
>  }
>  
>  static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
> +	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
> +	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
> +	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
> +	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
> +	.get_vm_pde = gmc_v9_0_get_vm_pde,
> +	.get_vm_pte = gmc_v9_0_get_vm_pte,
> +	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
> +	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
> +	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
> +	.need_reset_on_init = &gmc_v9_0_need_reset_on_init,
> +};
> +
> +static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_override_funcs = {
>  	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
>  	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
>  	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
> @@ -1343,7 +1337,21 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>  
>  static void gmc_v9_0_set_gmc_funcs(struct amdgpu_device *adev)
>  {
> -	adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;
> +	/* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes, local system
> +	 * memory can use more efficient MTYPEs.
> +	 *
> +	 * APUs mapping system memory may need different MTYPEs on different
> +	 * NUMA nodes.
> +	 *
> +	 * Only direct-mapped memory allows us to determine the NUMA node from
> +	 * the DMA address.
> +	 */
> +	if ((adev->gmc.is_app_apu && num_possible_nodes() > 1) &&
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +	    adev->ram_is_direct_mapped)
> +		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_override_funcs;
> +	else
> +		adev->gmc.gmc_funcs = &gmc_v9_0_gmc_funcs;

I think a flag in adev->gmc would probably do as well, no need to duplicate the call table.

Regards,
Christian.

>  }
>  
>  static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)

