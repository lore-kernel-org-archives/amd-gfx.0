Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E15C44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 08:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756DB10F49B;
	Fri, 17 Jul 2026 08:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ieXsP1Bx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A361510F49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 08:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIb17hErsrypAewt5B54+pTk7TntyOZ835jL6kTR1RrbP+VgrGNC5a2/ZEtTm2t5xib2bNndCCna9VrPSgL6LbW1Zac8qct2xLpRKxLUmsmzj4e2MX22slflxASPiiJl267QcSJ4nbjsLS1SBK45gIU48Z/rQDD58woCovmDXhalTRYdD2PViemVeDkgO18W44GcYqMHvFaRbRVd2K+wOWa7nD2/JfwRw+GV68nme2760JGmNuoRwy1wftXV6jtHuJdPNUPICdkmpj83Z88Zi3q29lOrmeKEVftury4JXy/A8RLiUBw2GW6vQka3RLdIOqeoFnx9JWjgP3QObcioog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kt/m4oH8g6l9tJJ3tExo4YEuPK0DsQqZbMnC9FbkEA=;
 b=DfRpiFgLNc6UI+sJqL/fDe2KuIAynvzOJ0LTjwwbwSWcLc+1EOLe09aQ02WfR1n93GrkvAtlm43DwXTZE44qKhs5CBcFZajhwUKRHXcsqeEj4Z0kg3vXb/OLWrRm17VwzQdyg67gbGoqZlGR7VnnbvBHVXiIUxFeKXqcMEBnWXNNR+k48+edvo3it0Ldr5Z0bRxSzhTuZV6pUw1lAumhjuEdq5KmE73sHgOY+GeW03UbhSWp1sCxSDTZXlE4RBfDasPvwWBm1pOfwSqpEJNH95cNRIiE3jF+pnqEkzja5wdqyqtOH7YWM3BjX7FoPLUabXDFGRpEMgHa9WGJZnhw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kt/m4oH8g6l9tJJ3tExo4YEuPK0DsQqZbMnC9FbkEA=;
 b=ieXsP1Bxp8wxbYsVWj9i+BR0BxOWapApah/i4hzIKDca4QkUP1W0wu2ySvQ38T82w8gp7/0K304hEV6VD7tS216AdBpWBdKaA/hthmM6DtYO6YAoXSjDlrav+juYlIWoCPOvXWo0/XfXTUJla00aflQWGTrKKJVQeRlVyGhWm6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:06:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:06:51 +0000
Message-ID: <fb70da66-351b-4e12-ad2a-6835f8360202@amd.com>
Date: Fri, 17 Jul 2026 10:06:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix userq page count in input_validate
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260717022550.6549-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260717022550.6549-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 885af3b8-d238-4dac-f8a4-08dee3da5b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4IDLN4JjUOSY4MCifvoAXCCUIK4aiTAXMkUprznxpnW6+K/3iQdIUQXQ4m2ulUcxY2cjnWuI0yo8r9uPGXGoA3IgGLQIs2bAWOKijNBr6SSo/maOvax/kPehgbgPhn3bw16aA7GOxtHI0Nm9DjSBz146ynh3wBwoedzttBYix1oRA2HwVp5F1dOC0tMEynQeVk0aNwbNcERQ/zugn4Cp7fgcTjVXSzRaUILRth5/sjVFaxa9jvw7HJFMv1SG6i1xPrc/jFlBP3eZDosKGqVyX8VaFQaQz1+JEEVMtkWOl9VNk2kJD9tnlcXgj/ZKA6foZmy0Nq5W7nqe/FP2WRgG0+0f8PQn72GWaTE8Uq/TlzeEORj3++J4xxaHF26Bv+WTT9J8TRYqb2YmYeBjCP8DUSqM/CTQbKmffV6dLZ6NT7Aj9xDWZugSspbFmh5zwzzeIpKMZV56d56/Da4KrfQuzYi41q+Olhsv+iosDRcbplfuXFYmpYl1slURF7nbC8Ue/53AolQYdDm6y8ZweIvorbXc3hbbqI/Az1Dg7x+RK6KgXpO0MMMKkTHB9kIz/vH7BDfEa1NH2NypaSZPSkDKtCgXNxW0NMnMu8XOQnuv/w0qhAeFGz4uOeQ3VXp4bkzryCkv45hIl8bquVIPZZAn9/CN/BXlo1uigIHyc/xCCto=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1BVDZrU0RxT1JKTVZUQ0t4Sm1PK2ZQcjExTExPTUhycVlWV2E3ZTB0eGFY?=
 =?utf-8?B?YjNuMzR4NmtTTzFSY2RlM0JLRlpqWlZZa0N5d09ON253aHlvYklxa0xhQ28y?=
 =?utf-8?B?THJWMTExby9qREp5d1JQRjNhUHc4ZVZydWJhZjdPZGhkNTFLNmNJekJHc0tQ?=
 =?utf-8?B?aFdncSt2d1Z1cUk0cnpGWFlTdlR3YWp3Q1hUM0hFWUd1djl6M0lqcWxJT3Va?=
 =?utf-8?B?NzQ3dnd1VjViRmp5amFVNTFQaldGc3Y0emhNQzZvYmU1Rk5FaXNUNE5UQ3dq?=
 =?utf-8?B?WWVWQkt1N1RMNDhUTElRTS8ybFFkM1lVMjZnMEVzaEwrK1VtdmlHemFXL2Fi?=
 =?utf-8?B?YnUwV2E2Z3FPSEgrK0IyVEhSYlFaTVptN3A2TUZxWGpVNXNMc1B6Qi9xMFh6?=
 =?utf-8?B?TEF2M1hiTWJtcEJ0M2FBakt1TktiZEt3R3IxaVE1a2Nxcm52dzNLZm9zSmdw?=
 =?utf-8?B?QmtzTGFGdHpDenRJeUNoWjNnaFFDNDlkR3kwNXB4Y3A5anA0TUVQMEdoc25O?=
 =?utf-8?B?cEhDbW1qV3UyN1FBZ2pXUE5lNStKamlCYlpiNHRWeW54WktldmQ0bVdmN3hz?=
 =?utf-8?B?SUQ2akFuVHlGZjdCNmY2UzdHd09SRE5ETGI4cjlJNzhrWXdkY0ozUm1VTG4y?=
 =?utf-8?B?R1RLekxnNWRkWDFjUytoa3orNzJGOEU1QlByQVFmSGMwVTU3MUdxUzZzZjJW?=
 =?utf-8?B?Um1XVmluTWtMeG8vbFNpQmprQTdKUEQ4eWRma2oySFBUVTNVUFRPWVI2Ymk1?=
 =?utf-8?B?bERCTUVha1BLVHVvZFE0RkphQVpqZHVWbW9rSnpoUXFTOUFFV0dwTUFLMklV?=
 =?utf-8?B?eTdibFdxZ2NTODZ4czQrV2t1dTNRbGxTQ0RoaEZwRjdiWnpidXU2bmxBZm5G?=
 =?utf-8?B?a2pqTE9zazdVTHZvWmdFMWJSTDBwaU0venBQaGgxelBNTlZvdkc0bm9aSzY4?=
 =?utf-8?B?SVhVMk15MFVoYTBHb3FpSEp2WG82WTYrMlFVZ2hEMWxJUkxYVktzL0taMTFR?=
 =?utf-8?B?MGtneXlPZ3lnQjVoQldlOUdtdkQ5YVVLSGMwYW5xM1BYOTg0WXFQQyt6bUJW?=
 =?utf-8?B?dDNFYUVTdVBNZ2VZc1FWbFZ4RDl5LzY5Wmpybm5OMEVkQ2t3OHFINnhydTJw?=
 =?utf-8?B?ZVdMMVh4S2FkMlAvaDJMeTEwSHRRZUFXcmxOSnoxVitpYXhCTmd6SFhWS0U3?=
 =?utf-8?B?bzAvYmdVTHh2ZDMreGVpam81T1k2cDBTbWRGUDYvaGJRQnVoY29pMEpFUzVi?=
 =?utf-8?B?Q3d1SEJPUzM2N01INUhVZ3ZmR3NocFFXcEZVclk3Y1kvRVhFUGFmQWpNaCsr?=
 =?utf-8?B?UXIwa2tYNXZqWnBMRGRDc2JQV2ZtSGYwcDFJQUZGaUlXSDZqeXB0OVVBUDVJ?=
 =?utf-8?B?NkFHclFwOEVNbnpwQ0YrWmQxa1B2ZmE1WHN6c3B5b1lWUGt3V3Y2MzVIRkZq?=
 =?utf-8?B?MWJVVjdmNGtLNlpqWlpkWVg2aENsUmpHNWVuZ3BIL3ZSN2RlenhBaU1UR0Uw?=
 =?utf-8?B?RjFXYUNVdXFLMHJ4TVI0THEvc3QzdXQ3Q1l2dGlDZldMbmxjTnQxZ2YzU2VF?=
 =?utf-8?B?R0pJYWRqZE40SVlXWFZ5U2hIdm83WXQ2VUx2elhzS1pXeXpOVFN6MGlKVnpV?=
 =?utf-8?B?M3FHc2p6YlZxa3RUZG94ZzNLSkMrV01DSkhKSXJlMFd5WHROQ1pOd3pmeHF3?=
 =?utf-8?B?ZDAyNWtFWmNJd09LKzFoKzd4MmxDUXZGUTRRU0s5ZzZMdGJBa05lT0hpZG5K?=
 =?utf-8?B?aWk3MFhMcmRBUk16dEtzeE51aTk3bEhoY0dWUU41WldPNU1SbzdsTU9zY0hq?=
 =?utf-8?B?ZXp6bzhYcWdwVm1oTXRsTk5iQTBRdzNBWW5IZk1oMEZxbXN4VmJSS3NLRWxJ?=
 =?utf-8?B?V2J6MDB0TTFvL0FISWlUcDJFL2JpalJTM0xFbU9FZ1NqZWxnOWlEVXJRRlRu?=
 =?utf-8?B?WkROd1NyMkxPOTcvaGZBNkc3TDhLcjRQUXYyRG5vM2pRL2t3cVdoRlZ3b2lM?=
 =?utf-8?B?dDVQL1IrSXl5U1ZicTBMdzg5T3RBdlRWd0tkRUN6VkNvQlQvemRuNjdxNWVW?=
 =?utf-8?B?U2ovdVNRNHpxVythUE5CdStRc3VqNU1UeDlNRGxReTN5Y3BxV1lQNkN0Tlcr?=
 =?utf-8?B?cmlIUCtlc1pCTXhCMFh4NkE3RW1pT2JBZlJXeVNxRGIxbU5mSU9jeEVsQkpn?=
 =?utf-8?B?MGJlcGpUaTl6REhOc3gwQjd4RmZ0ZEFSU21SK1NkUEhCYTFWL1lJdURxeGg1?=
 =?utf-8?B?cXltaHI3VS8xODZXTlBrRXFOYjVTWlpncUwzYndKMDh3Zk4zTTFBV045R1pk?=
 =?utf-8?Q?Xq6e9rGuAqT6CmyL6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885af3b8-d238-4dac-f8a4-08dee3da5b9e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 08:06:51.5840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55d0SaFmz0dpXn+cC+v4i7LTJ1T64UpuWbzI+LMG7TypPhFGgfaJOnKbjNcUxdTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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



On 7/17/26 04:25, Zhu Lingshan wrote:
> amdgpu_userq_input_va_validate() converts userq
> expected_size to page count by right shift.
> 
> This undercounts va buffers that less than a page.
> For example, in the AMDGPU_HW_IP_COMPUTE userq
> creation case, the expected_size 2048,
> so size(page count) becomes zero page and the
> "va_map->last - user_addr + 1 >= size" is always true
> once the start addr locates in the va_map mapping.
> 
> A similar case is AMDGPU_HW_IP_DMA, where expected_size is 32.
> 
> This commit calculates a proper page count by subtracting
> the start_addr and end_addr in pages.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 969f49592450..f9f11bdf2cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/overflow.h>
>  #include <drm/drm_drv.h>
>  
>  #include "amdgpu.h"
> @@ -238,14 +239,21 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_bo_va_mapping *va_map;
>  	struct amdgpu_vm *vm = queue->vm;
> -	u64 user_addr;
> +	u64 user_addr, end;
>  	u64 size;
>  
>  	/* Caller must hold vm->root.bo reservation */
>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>  
> -	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
> -	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;

Good catch, but I would just use ALIGN(expected_size, AMDGPU_GPU_PAGE_SIZE) here.

Regards,
Christian.

> +	if (!expected_size)
> +		return -EINVAL;
> +
> +	user_addr = addr & AMDGPU_GMC_HOLE_MASK;
> +	if (check_add_overflow(user_addr, expected_size - 1, &end))
> +		return -EINVAL;
> +
> +	user_addr >>= AMDGPU_GPU_PAGE_SHIFT;
> +	size = (end >> AMDGPU_GPU_PAGE_SHIFT) - user_addr + 1;
>  
>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>  	if (!va_map)

