Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AB9CD5BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8055210ECEA;
	Thu, 28 May 2026 07:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NXs8cJH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6327510ECEA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 07:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/KhrBieNLBtC5OBNXpzzUY5vTHChJkUv2iODcv6MimLwaf3jKTd0ljvSbjsa3NypPhSA6IBhhtPMlm095RuEnFab2EQ/PPp0+CKj+QPTRbACKcCy4BqTceRDLzfoZfBMA43xWSCsTSPwYgdDIGiL2ToLO8MJgpIuBW35ta/NIFDsiXgbJ9XQi+RQz9YLrsHkgcFOJbDgZ9h1ka38Ak6+KUNU0gqKv3Ni/DKofp6pAgMdtOk0PN7/7E4e24apR1R2HQgH2V5MYyVknZwohmzH06wk9bg+WToXY8iSZnIX5zLoYnN31zFBNkbB/Mn1Mu52jG5OY2lp6rdzp1vPZ0GNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoyp0CIUd3OFUNet8NruyApCCB+Z5/UJlfxGRhjwc8k=;
 b=k/wD6bTrpbc/LPgk+W5dLI9Vaq/bobQevs3Wdj3ryFvki8GtZdGewTfa4A/TNAsSoVTSZqwXLq/J8Snpzi+5mXOds6F3AXj3LWr+3MSSiURt4gfaukYDVj5CxngYN3afaf9jmKd4O9k4XM1OOmFW6CeqXD5jsLCEh+cIAvwhR9KsDO1ztIrAJOh2RqK35VpVuy4kn1MgM42hPB97/Bd92CpDkns+58/SGPoyp/IcE15JvF6MvBgUsZC+NbOVBBldp1nN5ZO2nDjlQDzcv/ZVae3ZSYhGX3ZgxY2rOLOXnpSHvCHB45hy4hx1O+Q0aJmca+GvJ9hKh4ijkwtGOV8Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoyp0CIUd3OFUNet8NruyApCCB+Z5/UJlfxGRhjwc8k=;
 b=0NXs8cJHLlW4AQKcRUI40UMb1g1XiDcfRDeFkr8eajsPDy4bUuuYOF0tn3hLS4uSZk64VJ2TjvUmkilIYzDLX7VpkKSeTlZW/xJA3ZFhpj53AZQc0gxirLzwipjCDjuEBKldxW5y3cqq43CEA83yhJ/0CftsQK8IX5fXabMvUKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 07:13:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:13:58 +0000
Message-ID: <45bbf391-70fc-48d1-bfdc-8ffe18de738f@amd.com>
Date: Thu, 28 May 2026 09:13:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Rename moved state to needs_update
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260527162918.9585-1-natalie.vock@gmx.de>
 <20260527162918.9585-2-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527162918.9585-2-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe41a67-1927-49ef-09a0-08debc88afb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: A63FTQDpV3wBTx/7X4IJV6BczMimPy9hr2wQDK/8/Wunus/49YRQ78sNELF62GIQg7gjvy1MMKQUntaIZnrZfZV8Sb9+j1E3ztjLRDrJK2YDZ1IQCYGJdsxmeO61h/z1dj1s+l4yUVRMWBgeigL3FP/xuWxgyFH9KuqO9UQECE2xfvusPn2k9pwvi2RYaPpkudKJkYOpkV/H0QbhR0Oo3BTitFC8O4Chp5Ei/EtFQX8c/nn90mpPFRDPvkh576BRzNtOIcvS0kC9SS0ZGYLSS9Kfg5GjkSVrSQblhP1+9tn7j+2YwspHCSp4s9PdlIBuGT44P5rIlqYY59gcr8Q6tZVlnTpt9J2KEYobtasHYg9+FLOyc9I90YlrFLoS9VQfQVEgcMMZ5pmoSCeaFROSBQ5Ts0OV36IxNDOSRZo7UOmIRsH+aoqs14Zkp3pc96QO9YMpRGGrDrLs397Yl+54dd7pZwczPgdyX4i8qlHoUK2/E8uWCsZvibXqk4eRpfxKL2PuBLmiYZwwOW1KIlgVqdPbFf7YCVCz6ghr93EIJ50+o3uwU4+uDIjSHbFnFZBDzRHh2UpDuAQqjIXJ7Qr5A/IHm/EorrnPGt9VcSYBlQaeCz9gY+f/KLZ+UOkvGholG4gh1KjR99c/fDyA0RZwkXdC3wHCpDWoMVmftpfF9XH3LOgNN9lD+XmEK3KvRRYc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ditaalY3Y0d4bGF5V0NZNDAvOUw3WlFZV1lRZk51WU9FcTVHd2xicjFGSWxl?=
 =?utf-8?B?YU91Qkh3VlhzQWVyYUFkS3c1aHg0cXJ5RE9RcmhiY2hzSC8rR1Q3YnM3NXJE?=
 =?utf-8?B?Sk12Si9ZZThHcFRLSVlKS1Rnem9Id2RUR3ROSzN1OEhSOGtPeGtsQytaZjVX?=
 =?utf-8?B?ODdJczdJZ0xMUXJmUXVVNGhmblhPMVJSRDFEZjAzMFdWcVBkck9tTVhBWDB1?=
 =?utf-8?B?VjFRZnB4RkFRZnZ1Z21BU0J0Q3dQUzRzRGNrbFgxU0VyaFFYeitZczIwTUZY?=
 =?utf-8?B?ZDhyZm1xczdwMWpHeVkrRXhXU3FpYTBzTjdVUFdaMFNrbVNrV09aek9neEhU?=
 =?utf-8?B?OGoyMjdWak9LRXZiQ0pKYVR0Q2hlZUxpMCtuWEhiUHpxUGgvTk9KVmlOaTZi?=
 =?utf-8?B?YUp2YTBWcGFCa1U3cHZLV0Q3b3hPWVlwaytqY1pOVG03Um1YTUdxeEJuYTY4?=
 =?utf-8?B?ZnNINFlvZXlWY1NKRU83Ky82eU1CdUg3SDkxSytjeVk3dGtVOWFleVZiWEVi?=
 =?utf-8?B?dktsTjRuOUxBMUloNGJuMHFVQnpyTmRMOUE5TjFEYnJrS3hUOEVpR1BTMVcy?=
 =?utf-8?B?S1dCTkRPdHRzNDJ1eXJac2JOdmJ3Znd5WFZTQWpTMEpZTHM2Uk5HWTlZVTJT?=
 =?utf-8?B?THFvZXNSZUpRQlZJRDdzWUtVRjVQaVJHeGl1Mjk1Q2xMVklKR1NnWVJmQkEv?=
 =?utf-8?B?UzAvSzBFY2NnbkNpN1FvLyt1dE9RSENoQ0R2Z0toRXltVXV1b3RTSWpPOFpK?=
 =?utf-8?B?RzJwRnMwbzJVempnNVNjc0dWQVhyUElxczJuVEQyTFVQVmRtTGh1dGpzZ2tO?=
 =?utf-8?B?bi9QZlNXdjdsbDdNY2N5R2RTWFVZUGFGUEE0S1cvNUFJUUEvWTYzRnA5L3p2?=
 =?utf-8?B?bDBZSVVFdy92clpwNldqVFdSYmkyeGtZODF4VzJTazlGYkM3eFE5NmtxK0xN?=
 =?utf-8?B?SkNtSjFoWWxoYS9nRzRxY0crSmRjL0pxQ01QNXlVclhJRGdmSGFiekRiMzA1?=
 =?utf-8?B?NEY4WFR5QTEzbmZXTWpRL0JUUTlzWVNpTk80bE5wb05jdkJlcWx4S3V6elhX?=
 =?utf-8?B?b2xNeTl0djhOdWg5dFdGZHBldDVkTGw0RmlRY2JyYVBGU1ltNGJvRWZVblNv?=
 =?utf-8?B?cTdZR0RJcnNSalh2TU1aKzQ0bVdzbkVFLy9QcTJnRHpyWS9NM2hFeTl6T3A5?=
 =?utf-8?B?ZnNKL294TjkrTXJ6QnFTT3BiYXRtS0FXUXEweXZnUVpzbTdRd2plRmk4cEJG?=
 =?utf-8?B?UHhoUVFxODRTODFPS2dkWXFpY0RpczE3L21PcE5CUnJuT1I5L21DL3ZDaW04?=
 =?utf-8?B?ZWU4R2ZVcUdIMjhpY2UwYTRxVk9GakF2SXBmOHBpY25FeUtGczRZaGlzY1dP?=
 =?utf-8?B?Mk5mWFJSTEhtanA0L3paWUlub2d6TUMrNmwwOVp3QzdFNnIyS01jQ1YrTmNp?=
 =?utf-8?B?QjkvS1p1aG14Zi9TdDBneE9VSXR0TFlPM1cwSXJ5WTZCSVZLMWRpZVZ6SlBr?=
 =?utf-8?B?UTJRK2FTK0ZDcVRjT0pkc2RYNFhOVDA5cnNtY3ZlUm0rSnJYWnlqOHlZRTE3?=
 =?utf-8?B?YWRQU3J3MDljR1ZodXd3alhXUjF2QmFaOWNWMjVnbjBjcURvejI1aVRnOHlB?=
 =?utf-8?B?emtvR0RxTCtzNDB1L3RWaFFHNjR1ZjBhWWpLREVrdWNzbk5vSlFtaEh0OENP?=
 =?utf-8?B?ZU9ncFlCUHhZQkJMNHlOditLcFlWeTVGdEJNSkVYVW1XMFJXR2VVVnQ2L0lC?=
 =?utf-8?B?b1pIM20wYVdWVnhHd3BnVXVKV3U3bXphdVZ6dWQ1V2t5Nkh1S3ltQTRsZTRM?=
 =?utf-8?B?T1haYmdoWUNuRmJtMTlyczZVbkkxcXJQd3pSU2UzQUpFYW11NVJkQklLRVNC?=
 =?utf-8?B?a0FEdW54RmV1TjZTeFVQWU0rbTV4dC96dnJWbSt2YUlBSU9mQk5qcGRaaWNQ?=
 =?utf-8?B?aVJyRlFHbS9haHpTMGc1QmtmWGozRHVpWThIcEFGT3BuUEE3dFNZNXNqWlU0?=
 =?utf-8?B?Y3BvVTZPMk92aUFwVEd0bExjWElmU3puMGVzQzlVQnVjS3RVVkF5ZmZQSnpM?=
 =?utf-8?B?Wi95RFhHMmpjdkdhbStST0hBZmthdm9ESncvM3V3WUw0dFJaajVDT2twcjFk?=
 =?utf-8?B?TzZVc1hRdUlvU0RrSDJKdHBBVksyNzBTOUlKeG5mY3g5OVZDN1Z1WUF1MGdV?=
 =?utf-8?B?UFlQa3Q5Z1psbXBXTnUxdnluRUh3c2pkTGdLRDllTS9GNkhxREROSDZUTm5u?=
 =?utf-8?B?U1djZlArYmtsZUdkc3hRaFd6U0lubnpYZ0xqSTljUXpJR1IrL1doSTIwZGsv?=
 =?utf-8?Q?TlpfHr0UgbHEmjmD91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe41a67-1927-49ef-09a0-08debc88afb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:13:58.3717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMMalna8rhhodZ1BoZg48cY19V7geG/oxDyNP+Mg1NgMTLHXP0omhwNaevdzizAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

On 5/27/26 18:29, Natalie Vock wrote:
> This state can be reached via other means than physical moves, like PRT
> bindings. Make the name match the actual purpose of the state.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>

That's a really good idea, I was already wondering in the original patch how to improve the naming but couldn't come up with something better.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 55 ++++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  9 +++--
>  2 files changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 969716b3e67e4..36f6c0c36f5e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -142,7 +142,7 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>  static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
>  {
>  	INIT_LIST_HEAD(&lists->evicted);
> -	INIT_LIST_HEAD(&lists->moved);
> +	INIT_LIST_HEAD(&lists->needs_update);
>  	INIT_LIST_HEAD(&lists->idle);
>  }
>  
> @@ -211,16 +211,17 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>  /**
> - * amdgpu_vm_bo_moved - vm_bo is moved
> + * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
>   *
> - * @vm_bo: vm_bo which is moved
> + * @vm_bo: vm_bo which is out of date
>   * @moved: true if the BO physically changed locations, i.e. all previous
>   *         mappings are invalid
>   *
> - * State for vm_bo objects meaning the underlying BO was moved but the new
> - * location not yet reflected in the page tables.
> + * State for vm_bo objects meaning the underlying BO had mapping changes (move, PRT bind/unbind)
> + * but the new location is not yet reflected in the page tables.
>   */
> -static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool moved)
> +static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo,
> +				      bool moved)
>  {
>  	struct amdgpu_vm_bo_status *lists;
>  	struct amdgpu_bo *bo = vm_bo->bo;
> @@ -236,7 +237,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool moved)
>  	} else {
>  		if (moved)
>  			vm_bo->moved = true;
> -		list_move(&vm_bo->vm_status, &lists->moved);
> +		list_move(&vm_bo->vm_status, &lists->needs_update);
>  	}
>  	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
> @@ -270,11 +271,12 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  {
>  	amdgpu_vm_assert_locked(vm);
> -	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> -	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.needs_update);
> +	list_splice_init(&vm->always_valid.idle,
> +			 &vm->always_valid.needs_update);
>  
>  	spin_lock(&vm->individual_lock);
> -	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	list_splice_init(&vm->individual.idle, &vm->individual.needs_update);
>  	spin_unlock(&vm->individual_lock);
>  }
>  
> @@ -428,7 +430,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>  	 */
>  	if (bo->preferred_domains &
>  	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		amdgpu_vm_bo_moved(base, true);
> +		amdgpu_vm_bo_needs_update(base, true);
>  	else
>  		amdgpu_vm_bo_evicted(base);
>  }
> @@ -600,7 +602,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			return r;
>  
>  		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> -		amdgpu_vm_bo_moved(bo_base, false);
> +		amdgpu_vm_bo_needs_update(bo_base, false);
>  	}
>  
>  	/*
> @@ -617,7 +619,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		amdgpu_vm_bo_moved(bo_base, false);
> +		amdgpu_vm_bo_needs_update(bo_base, false);
>  	}
>  
>  	if (!ticket)
> @@ -637,7 +639,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		if (r)
>  			return r;
>  
> -		amdgpu_vm_bo_moved(bo_base, false);
> +		amdgpu_vm_bo_needs_update(bo_base, false);
>  
>  		/* It's a bit inefficient to always jump back to the start, but
>  		 * we would need to re-structure the KFD for properly fixing
> @@ -971,7 +973,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  
>  	amdgpu_vm_assert_locked(vm);
>  
> -	if (list_empty(&vm->kernel.moved))
> +	if (list_empty(&vm->kernel.needs_update))
>  		return 0;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -987,7 +989,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> -	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.needs_update, vm_status) {
>  		/* vm_flush_needed after updating moved PDEs */
>  		flush_tlb_needed |= entry->moved;
>  
> @@ -1003,7 +1005,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	if (flush_tlb_needed)
>  		atomic64_inc(&vm->tlb_seq);
>  
> -	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
> +				 vm_status)
>  		amdgpu_vm_bo_idle(entry);
>  
>  error:
> @@ -1616,7 +1619,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  	bool clear, unlock;
>  	int r;
>  
> -	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
> +	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.needs_update,
>  				 base.vm_status) {
>  		/* Per VM BOs never need to bo cleared in the page tables */
>  		r = amdgpu_vm_bo_update(adev, bo_va, NULL, false, false);
> @@ -1625,8 +1628,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  	}
>  
>  	spin_lock(&vm->individual_lock);
> -	while (!list_empty(&vm->individual.moved)) {
> -		bo_va = list_first_entry(&vm->individual.moved,
> +	while (!list_empty(&vm->individual.needs_update)) {
> +		bo_va = list_first_entry(&vm->individual.needs_update,
>  					 typeof(*bo_va), base.vm_status);
>  		resv = bo_va->base.bo->tbo.base.resv;
>  		spin_unlock(&vm->individual_lock);
> @@ -1785,7 +1788,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  		amdgpu_vm_prt_get(adev);
>  
>  	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> -		amdgpu_vm_bo_moved(&bo_va->base, false);
> +		amdgpu_vm_bo_needs_update(&bo_va->base, false);
>  
>  	trace_amdgpu_vm_bo_map(bo_va, mapping);
>  }
> @@ -2094,7 +2097,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>  		    !before->bo_va->base.moved)
> -			amdgpu_vm_bo_moved(&before->bo_va->base, false);
> +			amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
>  	} else {
>  		kfree(before);
>  	}
> @@ -2109,7 +2112,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>  
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>  		    !after->bo_va->base.moved)
> -			amdgpu_vm_bo_moved(&after->bo_va->base, false);
> +			amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
>  	} else {
>  		kfree(after);
>  	}
> @@ -2283,7 +2286,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>  
>  		if (bo_base->moved)
>  			continue;
> -		amdgpu_vm_bo_moved(bo_base, true);
> +		amdgpu_vm_bo_needs_update(bo_base, true);
>  	}
>  }
>  
> @@ -3077,7 +3080,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
>  
>  	id = 0;
>  	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry(base, &lists->moved, vm_status) {
> +	list_for_each_entry(base, &lists->needs_update, vm_status) {
>  		if (!base->bo)
>  			continue;
>  
> @@ -3086,7 +3089,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
>  
>  	id = 0;
>  	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry(base, &lists->moved, vm_status) {
> +	list_for_each_entry(base, &lists->needs_update, vm_status) {
>  		if (!base->bo)
>  			continue;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d3f3852f1ebae..e6ad79b09042f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -212,7 +212,8 @@ struct amdgpu_vm_bo_base {
>  	 * protected by vm BO being reserved */
>  	bool				shared;
>  
> -	/* protected by the BO being reserved */
> +	/* if the BO was moved and all mappings are invalid
> +	 * protected by the BO being reserved */
>  	bool				moved;
>  };
>  
> @@ -220,14 +221,14 @@ struct amdgpu_vm_bo_base {
>   * The following status lists contain amdgpu_vm_bo_base objects for
>   * either PD/PTs, per VM BOs or BOs with individual resv object.
>   *
> - * The state transits are: evicted -> moved -> idle
> + * The state transits are: evicted -> needs_update -> idle
>   */
>  struct amdgpu_vm_bo_status {
>  	/* BOs evicted which need to move into place again */
>  	struct list_head		evicted;
>  
> -	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
> -	struct list_head		moved;
> +	/* BOs whose mappings changed but PDs/PTs haven't been updated */
> +	struct list_head needs_update;
>  
>  	/* BOs done with the state machine and need no further action */
>  	struct list_head		idle;

