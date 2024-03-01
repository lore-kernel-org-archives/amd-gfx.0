Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA787C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 21:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5A810E35D;
	Fri,  1 Mar 2024 21:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ob6fqL4h";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5159B10E35D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 21:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+UyH2C/gGT9qq/a5pK5lijDrsk6mCjlVzvujssLs9LqzvBtyWiSIpac0gRfQrbRMzzxxyrSXfp5CZYBeMiofNTVJeJDds6WSmn26+eQ3NBfA9KJndjPStDmYQKuPYFuZXbdDwd4nQGRatbKpzBZI/cOug71WlG/yfW2j++xi8oIk+60pPYxIAIKNhvB9gpMkSV6QI8kjVZ7wnYD4pzr2BA+XO7oip27p0AB8g1d2lLPn7niu+wLY04GROdBQWBLo8ZCFdVrv9YVS8Zta4QrfXGAqiDtatdZRLudfQlJiy5pzehfNcO3x4Bcpm2HzTmMTTHjuCPZcSYM2zFI2Enl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4si/G2/8Ergrbv93m/+3kCIAjEdUiXm+GkSS+EoFfpg=;
 b=EhmvcJJzrWYlhWUGWhBEwp47SUdIsIA3fZVrG3tbcrXROcsV/qltjzGwHvL4VmCW/7+Fr9ShkWC6UJtirO2agd/+5X4szbybuohIufUbj9YabGHC0bgvUp6UROjqdusY80RkqLwF34CBkE5LPaG1ZHoiaXBAyPAlCtvvl4Z5pvQk90TWAqccXU8Fg35/kbMD3aXvWV3wrDQ6Ln845kp9WosNPX/+msAOlJSRdg7QT48yiGAwV8iJHAkORzxp8nAk+o4OY0VS/ZPM7POHEdpEQtUwPvcGh75ei60/CkowaEyEebuGwE4kRwqtqJoXjtxNQ2t1dS6Ohz/YqMFO+dZo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4si/G2/8Ergrbv93m/+3kCIAjEdUiXm+GkSS+EoFfpg=;
 b=Ob6fqL4ha5Z/QHO2feTZpFKF44HPk0Y99TSvsMZSF23JRZBdd6kkOk8tRl7wpiT/yveqJ8ZJ007MZYQLE8Yd/6/S92SQSwZq2Dp7u/fKyfxnHVFLgQo41eIY/dNdoKwcm0BM7Wd5nc/0sKLhHK86iATYeo//CCd/dNO0EHwUd8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 21:11:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 21:11:50 +0000
Message-ID: <4e63bbfc-2827-4527-ae7c-a4e4fc636182@amd.com>
Date: Fri, 1 Mar 2024 16:11:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute" for Raven
Content-Language: en-US
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Yifan1.Zhang@amd.com
References: <20240229060413.2521976-1-Jesse.Zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240229060413.2521976-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::46) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: c1099f7b-7fb1-4e1d-6220-08dc3a343626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hq7DE+7Vke54uno5Niaind0I2ZBn6hmvqegGwcx6al1MJFg+ejpXyAznwizPnGyDy0P2Oa/7iB/w3WNvCzIFC+PYjh+KT+tHp4o1b6oGTddli4pwPDYPEP0FsfePzJHmtM4XlrKfoM/cKiJIMLpwRzFIndBQAYBEUFrD3W4IKXiLXqnr7mIDrPTLMxb037DV/Q9sTb2/S3Lpd//t8EGrxjdR58H2OZlNbLZIfyfCB5Rf2rItVOyUjyIv3MKwLlHqlGZNLJZGcjfY+T7lzsegYRe978neu1fPPWIOZ0/2AkurSIQlPM5iAOO+8jGmWT7k17nH2bNIolu6044BtO/163/n5V0Z+4v8h7pb5rZPdkn4fMbr2lzU5dXsY+EK+Tyd9GrZg52zVdyYIvP20xp1W0ZHomzoeS2Zl8pPGriJk+rLQaCZ7VRzsvezd8O5fdujWsGHr75EL6Ny73Zu7hf61izAuQkdCGkP3krR07qS6Iz9GDG0bf+nJ8zkQ7PvchG2EUMvdlCrkR/BIxMXU283809+e4MT4KzP3yWbpv76Wygwm++0pkq8P6i2UtpuL/AGIkFKQgXxQZVtb7j1KsQ+6cwgG3J1JNWqQyWWr60+CrP0nNGjMr4tJqEzLPCX3oOp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVESVV6YmFta25EQXFxLytwQVBhaFQ3d0FZSkE1b0VoazN2dU9SU3N3eUc3?=
 =?utf-8?B?U0F2aDdKTUd4R21HTTlDYzNuWFhBRCtKempqbFA1QWJRT2VxalFOSHplU2cx?=
 =?utf-8?B?c0oycnJYekhLeUJyb20yZzRWbE9zblBFZXlwWUxVVExrZjhwK0VERmM3bVE1?=
 =?utf-8?B?MXpVelJwbitCVktUbkozaVBLNVJmSEdpUkM5Z2VqZVlZdDF1RkhuRnNnSE8x?=
 =?utf-8?B?bjFUc2xYNkRlK0R0bnhoZzZWTnNjZGZZeXYwUElVK3NWYjlFd1pLYklTR244?=
 =?utf-8?B?WTBmVGErVitNMllTTGZsL202d2NZc2huNGpDT2JVLzcxeE9NU2xqNmFySzlH?=
 =?utf-8?B?bW4zdDM4eE5JMEl3YkdhcEc3K2FJMDRrc2ZjVjhzZ29rWGF0NUY4YS9TamQ0?=
 =?utf-8?B?a3RtMGJ1NldJMHNzTjFIeUZBa3NCSEhPb0RLaWw1L25kL1VZOVdLNkJZSWJy?=
 =?utf-8?B?SktxMWlVYk1jV09xV0RUWkN1WmlqOFNtSjNLQVFuNThOSWx3T2dGTDY3MDhH?=
 =?utf-8?B?VWpHYjNWT2VPNUFaN2M4eGtHNWtXQUdYWnlqRGJnVnpVMHBjUExjVkJMUytU?=
 =?utf-8?B?MXN0czQ5L2xXKzJ3WmhpVGZVYStQQkYxTnRSaENIMEorWFNQWTRiYXpJdHg2?=
 =?utf-8?B?U0NFYWJZdkVDMFZoV3RxR3piTGpuYkdIdDZ6RUJIWEE3MkdsN0ZnMVoxazJ3?=
 =?utf-8?B?V05BK2U5bHVkNkxoampTVXNWT2N6ZjdkbExyWVpXclB4RWpueEwzbXNIb3Rz?=
 =?utf-8?B?d2lnOXJoNEhCVXlKZU1CdkU2U1U4ZkpmamFFTXFqTnBoN0NnUlhicjFFUlhT?=
 =?utf-8?B?ZU00ZlZ0UmhOY0tiZXNHVjN4RDl4eE8rUjVUdFovQkUvRWtIdlFqeVg1dTBr?=
 =?utf-8?B?OXdsTlJhSnhQUlRvdlZ2Y09WUFpqV3dJc1BRR0Ivb2lnZEppL3A3RFI2RDFU?=
 =?utf-8?B?ZnV6TWZSOTcxdjBBZ3RyVGE2M2RiV2FzS3p3SXgxVHhXNDRFWHNrT1dReURj?=
 =?utf-8?B?Q3MzK3k5OUlnL3BHOEhURVk3aXZrZ0dUcmtqTHNrUWU2bzF2NHQrUWJkSjRX?=
 =?utf-8?B?WkFRMk4yY1dxd1I1dVBoRDdYeEE2WUx6aFJlaGcvNEZ6anpHZGl4Q00vK1pa?=
 =?utf-8?B?ZDU1WFVPeTZvR0JZb1lYYkhWSlcxaHpNcjVkZVN6RnZJR0NQNUtIcTk1THZJ?=
 =?utf-8?B?cXMzVG1UQmZpM2hiMnV3T1Z2K0Z5KzVhMU9xcDRGNUZYaXprSTNaVFE1SVlO?=
 =?utf-8?B?aFRPbldYV2p2dzFrblVPaFU2eW4rUWoxV1VISC9YemEvL251ZW94YkROWThw?=
 =?utf-8?B?c3g4NnpxTDhmUERZaHFwTjBxMWZrQVg1blNWazNLSGtsd2NkNFFlWjh5aXEv?=
 =?utf-8?B?bFZDdjJGYW5ZOFJOa0hhWDJsNWRaSmFnekhDMGs0ZlZLNi9tZitUNWliREc0?=
 =?utf-8?B?UExPejZpdzEwTDlpS2ZQYU83dmpJR0l1V3BxanZCVDVwNkJSR0FYUy9ZWUEx?=
 =?utf-8?B?MVlWejlJNmNMTmQyMGsrZ2cyY25oUUttKzZnN0krUGMxc0toQUEvTlVWQTNG?=
 =?utf-8?B?QklOSWlqSXFRVmtPYmFxTW5XRFZVd2ZZZXFWSFY2dUJNUmVTYnBuWmpYcHQy?=
 =?utf-8?B?RlNPV2tUaDBxYUtmcWNjaEtmZEJiTjdZanpQbFYzZTJQdi9QL2JMaklHSzJo?=
 =?utf-8?B?MHZUZVllRDZpMWZ1d2d4cDA0Wjc0L2JjUlVRRVBYZ3diZXl1SWJtbzJseDE4?=
 =?utf-8?B?Mjc5YnNWc0J3TnRiRVF2d2RmWmpFS21CRmZFWmR5RDRaM1Q5MUltVDlQTVlS?=
 =?utf-8?B?VTFvRnVmOGVSYWZ6eVc3WkFmZGRYU2dobDZBTXB0aWJORlhkeU8zdTFOQ3Rt?=
 =?utf-8?B?WGMrLzNxUFRLOGhQRjhMOGVickVEdGxlVTFLQzhtR25iU2tKeFFBOXFWV0tH?=
 =?utf-8?B?MWx3NlptVUpIdW9pZzZQVnpLQlhmY2k4dG4yZ0lHbFVRa2Z3MnNhTGdBcGox?=
 =?utf-8?B?d0NQQTBpUmVQK3dSR3RaN1N4bHNwcVhOSWp4a1IvMCszeUQwa0Z1RzV1RGl3?=
 =?utf-8?B?Nnl6T1M4Z1o1Y3lCdjRUSWJFS1NTY1BaWWN6N0lvMzF1NUcvd3J4QjdNck1n?=
 =?utf-8?Q?TyvtO2dwy4TYV1LrQ92BoBwhG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1099f7b-7fb1-4e1d-6220-08dc3a343626
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:11:50.2158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeP+0KBNwxgKvtX5ODx0GnGNI7AzJce7ACaxvhTWdFGEP0v+fQ6ddoONxKZaNicwjtMdpnqi0ntyiMRbT0AVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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

On 2024-02-29 01:04, Jesse.Zhang wrote:
> fix the issue:
> "amdgpu: Failed to create process VM object".
>
> [Why]when amdgpu initialized, seq64 do mampping and update bo mapping in vm page table.
> But when clifo run. It also initializes a vm for a process device through the function kfd_process_device_init_vm and ensure the root PD is clean through the function amdgpu_vm_pt_is_root_clean.
> So they have a conflict, and clinfo  always failed.
>
> v1:
>    - remove all the pte_supports_ats stuff from the amdgpu_vm code (Felix)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
The headline should be updated. This is no longer a revert of the quoted 
patch. Other than that, this patch looks reasonable to me. One more 
comment inline.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 23 ----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 56 +----------------------
>   3 files changed, 1 insertion(+), 81 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ed4a8c5d26d7..d004ace79536 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1385,10 +1385,6 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		if (vm->pte_support_ats &&
> -		    mapping->start < AMDGPU_GMC_HOLE_START)
> -			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
> -
>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>   					   resv, mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
> @@ -2264,7 +2260,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		return r;
>   
> -	vm->pte_support_ats = false;
>   	vm->is_compute_context = false;
>   
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> @@ -2350,30 +2345,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
>   	int r;
>   
>   	r = amdgpu_bo_reserve(vm->root.bo, true);
>   	if (r)
>   		return r;
>   
> -	/* Check if PD needs to be reinitialized and do it before
> -	 * changing any other state, in case it fails.
> -	 */
> -	if (pte_support_ats != vm->pte_support_ats) {
> -		/* Sanity checks */
> -		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> -			r = -EINVAL;
> -			goto unreserve_bo;
> -		}
> -
> -		vm->pte_support_ats = pte_support_ats;
> -		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
> -				       false);
> -		if (r)
> -			goto unreserve_bo;
> -	}
> -
>   	/* Update VM state */
>   	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>   				    AMDGPU_VM_USE_CPU_FOR_COMPUTE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 42f6ddec50c1..9f6b5e1ccf34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -357,9 +357,6 @@ struct amdgpu_vm {
>   	/* Functions to use for VM table updates */
>   	const struct amdgpu_vm_update_funcs	*update_funcs;
>   
> -	/* Flag to indicate ATS support from PTE for GFX9 */
> -	bool			pte_support_ats;
> -
>   	/* Up to 128 pending retry page faults */
>   	DECLARE_KFIFO(faults, u64, 128);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index a160265ddc07..2835cb3f76eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -89,22 +89,6 @@ static unsigned int amdgpu_vm_pt_num_entries(struct amdgpu_device *adev,
>   	return AMDGPU_VM_PTE_COUNT(adev);
>   }
>   
> -/**
> - * amdgpu_vm_pt_num_ats_entries - return the number of ATS entries in the root PD
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Returns:
> - * The number of entries in the root page directory which needs the ATS setting.
> - */
> -static unsigned int amdgpu_vm_pt_num_ats_entries(struct amdgpu_device *adev)
> -{
> -	unsigned int shift;
> -
> -	shift = amdgpu_vm_pt_level_shift(adev, adev->vm_manager.root_level);
> -	return AMDGPU_GMC_HOLE_START >> (shift + AMDGPU_GPU_PAGE_SHIFT);
> -}
> -
>   /**
>    * amdgpu_vm_pt_entries_mask - the mask to get the entry number of a PD/PT
>    *
> @@ -379,7 +363,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	struct ttm_operation_ctx ctx = { true, false };
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_bo *ancestor = &vmbo->bo;
> -	unsigned int entries, ats_entries;
> +	unsigned int entries;
>   	struct amdgpu_bo *bo = &vmbo->bo;
>   	uint64_t addr;
>   	int r, idx;
> @@ -394,27 +378,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	entries = amdgpu_bo_size(bo) / 8;
> -	if (!vm->pte_support_ats) {
> -		ats_entries = 0;
> -
> -	} else if (!bo->parent) {
> -		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
> -		ats_entries = min(ats_entries, entries);
> -		entries -= ats_entries;
> -
> -	} else {
> -		struct amdgpu_vm_bo_base *pt;
> -
> -		pt = ancestor->vm_bo;
> -		ats_entries = amdgpu_vm_pt_num_ats_entries(adev);
> -		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >=
> -		    ats_entries) {
> -			ats_entries = 0;
> -		} else {
> -			ats_entries = entries;
> -			entries = 0;
> -		}
> -	}
>   
>   	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (r)
> @@ -445,23 +408,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto exit;
>   
>   	addr = 0;
> -	if (ats_entries) {
> -		uint64_t value = 0, flags;
> -
> -		flags = AMDGPU_PTE_DEFAULT_ATC;
> -		if (level != AMDGPU_VM_PTB) {
> -			/* Handle leaf PDEs as PTEs */
> -			flags |= AMDGPU_PDE_PTE;
> -			amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
> -		}
> -
> -		r = vm->update_funcs->update(&params, vmbo, addr, 0,
> -					     ats_entries, value, flags);
> -		if (r)
> -			goto exit;
> -
> -		addr += ats_entries * 8;
> -	}
>   
>   	if (entries) {

I believe entries == 0 is not possible any more, so this condition could 
probably be removed.

Regards,
   Felix


>   		uint64_t value = 0, flags = 0;
