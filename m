Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D3C79F8C
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 09:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7F110F053;
	Wed,  9 Sep 2026 09:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIEcQhc0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4913B10F053
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 09:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYPcfty1y8nwA1SZF7cfsBjgvET5y7FvKTUf/VdgbqYAVsYlJTcLsYIl1iJRtjMKpbP9eVh8v9VcMzJ1E8c1XBZwr+tQRs869+pg/rZGxUMMnYxrxmRjEqjeSsOYX4J+HZ08mV+aFMp9Q+jEqoJVwVGVMdnkxfObnOrmgbumYtx5kIjWDM8nsYupDOQ//dm0NeiHa247wy8snI40X7PcDyaWZft/THqz/3aP3rSFQK+D6KlNYodohMHt0HwW4jl4mmLHSU3dUAgCEQeNAGeY3/QEDG0hP8cKxvjIZeqevvrWMPiJiKHPXo/SuoHDtG3bK4mPwAXL/GIhWCZS2+yqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYHGJ931YGuNn/VCWD41ClpAdMIzBmuRRVXnfgSihwg=;
 b=RCivxo2MmAhfMdXYfFolZno1CqjNPHmB53yNQhgNDZM/Cug7pZMWtQO3tSaiJH5SoKFyE/5yVxip/BnMq3UUnhbyRpIYtgGJpVrhEClwK3zC77gaDw/nMU6S5ummjh17fAH6WMz4FvKIH92Wku8Y91OG0dRqbBijTHJqS6G4bSp+OVY8tpGKrqDCEz6F86gE3ZsYcCGBVku0yaUW4OMU9IRwzaUS5tdGMSJDPiTsu8rsrcd6Y1TNqdoqUInO/CPm0HuPsG9jdQWtP4ruIcJ2NEkL2gSF3KbyaHnI5izYMeu+0WMY4M/7W4GmjqtrWMEokO7EJHQNj1Y6sv8uOdEg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYHGJ931YGuNn/VCWD41ClpAdMIzBmuRRVXnfgSihwg=;
 b=lIEcQhc0JHDRUFzGb/8nkjiiTyXQdrBgpDK3j1L3pkJmECz4S0tAts1yd2+pi1UTLGpbVr9/+x7+M6Nhel+H9VGeVL+FAm29etS5kaMCu9btv8ENWx1soGv4DVOJRYO/AJXJzYU1N5hw+XCc/LeIMWAef/8nEXTew0LvnQkO30Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 09:29:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 09:29:57 +0000
Message-ID: <3c0f1a05-f30c-4f97-96f9-0f7e96d400ee@amd.com>
Date: Wed, 9 Sep 2026 14:59:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: correct vram_available calculation
To: "Han, Zhen" <Zhen.Han@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Hou, Junhua (Richard)" <Junhua.Hou@amd.com>,
 "Liang, Lily" <Lily.Liang@amd.com>, "Zhu, Lejun" <Lejun.Zhu@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20260909024252.3205045-1-Zhen.Han@amd.com>
 <20260909090756.847617-1-Zhen.Han@amd.com>
 <BY5PR12MB43219A04F6D680E68F8AB8EE8DB02@BY5PR12MB4321.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BY5PR12MB43219A04F6D680E68F8AB8EE8DB02@BY5PR12MB4321.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0133.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c93f73-c3cc-4ba0-0e89-08df0e54ea07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1fWbW8ka6sOxGSPdCXSjEC+prhEf6CHju9YwkT6EvJny0rT2yqweXc6G/RMWOK9RU8h0W50HqkmnI0PNaMHCcdU1JW3CGlrsUdzZKifDRLZFWjUiwVxM26LkcvrI9XsIMqSrVrv/n6Sru0VuZ2+DrX3wewUF9QZPXH5IzlusdKO1UbLwBboUjBs2gwyrivhwi3qQlYe9pWB9Egmcg9Y9Jig/1uG/if3dkX/LVOjGgdF6WYbJlobewWIB09dW3vJsnbxzFP+nig/33kZADZoKSTN1DUs9odjop5hUZBplFygmt9LsXuNNEPC2vcUYJQvU2MWCo6zhyz55phFLOfonSN9UzrdDYWOuRoYabs1+Bi8rTU4dpKuDZo99WKk9o0zaPA8mYLo2gBJXmcqRZoF5ORmsu7D8jtxDn0lCMDZlF2M3C8YV4+7eJ5BB9WXMS3zkOIUpmHm5c4KmQWbG4ArwgKqph3c7nRDXj6tt2DqaWee/FjxatUvpsyHyWQUtIkkyjDsKp5LkFSJkcQZTFg1dTNQ8purOBcbTuMZEYnerr6a+ekJ+0Ny6mcFL/4WiJHaT3XYvmAajYLabzbEdN6++gM/O+VSZAe+j6bCwJlesEgePgLsLwCoHhXdYarnq+pgk1RSsrJ2WzXlOSMetyj50Avw+ixMjugJQhSy+MJWHna4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtBUUE0cmRlemVwNy80cExmZytrT0ZjUFplczNFTC9kd0h0emJxamxCdkJG?=
 =?utf-8?B?QXVvNFRkLzVYV0IzMGUyYStjQWJUQVdpNnc3QWN4YzU5MVIrZHBnYlFMdHF3?=
 =?utf-8?B?ZHNMRFVZRzIxMGFXTkdPdUt4alN5Q2hxZlZadDBFQ3BrN3FVaFphSXM3dmNa?=
 =?utf-8?B?Wm5xb24zUUNSNlBKa2NkTmxmODZsK1NqbjV2R0E3Z0xwMFJmYUNpcDFNdDRH?=
 =?utf-8?B?dXlyR2RwRFlPYXB3WW1IS3JFbVZpMW5LSTRZZm9tVXhobUZyV1dwOVJkbEpW?=
 =?utf-8?B?WXNiNGNzeUtmbHVRUWFGNmRzd0x6SVZzS1l5MGJKVXBrSE1Fb0wyTEMrWms3?=
 =?utf-8?B?MWk0cU1MbEhDSHh5TDRFMFpsc09nRWVUbnlua0tjS1Nza3VPMWZ0ZXZ0QS9v?=
 =?utf-8?B?K2N5MnVXRE9SUk1sL1BrS0oxWmFzeHJNZlJtdzlDOXVURXZXY1lCR0ljUHVz?=
 =?utf-8?B?MCtpdzdoY0JBN1IzbVhBanVUNjl5M2ZobjI5dUVNR3dCYnFFSUN2SGc1L2lq?=
 =?utf-8?B?WGdlSWllbG51TnJIbFF1UW9CUVBGaUZFWjBnZXl2S2x1VDRjbkVJYldmUXhH?=
 =?utf-8?B?OGJHY05kdlNGcGtBdDFaVGpnTW9CTFNsUVZyMSs4YWwwazN4c24rUG5sMk1O?=
 =?utf-8?B?Y3ZGeFlMZjM5Q2hvbUFvbGFFKzlpUWNnTDc0N2JrbjRjSlZsYlQxQVRjbnVm?=
 =?utf-8?B?RWdmclBXMmpRUEJzamhBYnlCUGVCN0dkNmk4MVMxWW9zeHFpbUw0TDlvSEdF?=
 =?utf-8?B?cEQxYkI4d2RQK1BhRi96S0dpOWdNN3I4QWdlVHBSNjZOajNYSHl3QWdnYlBk?=
 =?utf-8?B?NUtwdDZON3dlUU5VRXJHdjZTNlRGR0xxTmVQNm1UV3dlKy9jQXBWaGNzUDlt?=
 =?utf-8?B?UUtudmhQQnNuOEpRc2RqU05hVldKT0ZYTjJhdXNaT1psSHQyeC9xUWRkWGhv?=
 =?utf-8?B?amRBVll4aHd2Uk02NUR3SHVtT2d1ZWdUSjVmdGZOblJGaklqdXl5TXU5WC95?=
 =?utf-8?B?eXB5L25ONGxiVHFCQjFDUERINDRYenRPelN5bGxpN2F5ampZbXY4TDhWeFBw?=
 =?utf-8?B?a3I2bjFtMVZ0ZDlnUUJrL1lzNWxDNzczVEZkd3g1c3RHdkgyUkQrOTV4SmQy?=
 =?utf-8?B?TkFROFBISWFoVTM5N2lYUGxtd256Q1laUVV5QVc3SjJYUmxkenMraFdFSXI1?=
 =?utf-8?B?Qzdmd1BHbVYwdXNtTzFnMm0vYXhMYWNKbkNzRkFTbzQyYnp6VHpyQTZXUElS?=
 =?utf-8?B?UlNtU2ZBYW9BT2JMdHFjTkhZakpRaG9NRVU1bnE2V1hiRHRGcVpkUjQ4a2Ji?=
 =?utf-8?B?eVF5NGlMK0lqUTFGYkxpWTZVcXMvSXNSajZnd3RzTE1JWXd5TzVuakdXcFBH?=
 =?utf-8?B?Y2ZKSGJ6VnhRek53MXk2Z2lhWUNBcWQxUE4vQlU0NzYya2ZZY0tqK3VQOHFl?=
 =?utf-8?B?anRTRUpYOTgvWUtOS0UyQU8vVElwSjBoTXlDUmhHbzQ0L1Fha2N6VmU2Y1hy?=
 =?utf-8?B?Si9RSTIwTXhzREpvZmxrK1NuclB4QTJpdHloajhFc2t0Sjdmd3Vkc0dHK3ZG?=
 =?utf-8?B?WDVvamh4ek1TUE9wVnEvODJGY3NmS1RYcFdCZ0dzcDJyUHhraDk1bncxZG13?=
 =?utf-8?B?R1JlZ1YvRVlxQ3N5U2d0bWk0MEFXRzFIYUk3WUpxNWpxZ2FGZnhXOXkwRkgv?=
 =?utf-8?B?UHVBUXNDVEFQUUhTbnZQNHdRZ0ZlSlNSM0E0Wk40VGRVVDBGdGhRbW92RW1E?=
 =?utf-8?B?NllOVStDYUVoM3ppdExiZU9hWWRFWGkvandsV0hNYUdWQU9WWGtpWVNrbzZx?=
 =?utf-8?B?eXdxZ3YrY3RkN0pScGxCRHhaVkJYdXVjRTM5Vkh1K0JJa3E2eU5yYVhlNUQx?=
 =?utf-8?B?NHIrMkR1NFpSaHZ4alNLdTVhVXEzRDdUOXBjTEVhU0pUT3FZRVlZcG1JSXNE?=
 =?utf-8?B?aExSYnhMWEVtRERBOEhUcldkU2R6SkFGQmhkUjZiV3NBbEtNR3ByajVpV2FP?=
 =?utf-8?B?YWRIbEIyalF2alNITzcvZUtKRmRxSGtQNEE3eTVQTVdSOXhLY0VCeFpoWGgr?=
 =?utf-8?B?VTU3QUd1UDBZTmtEOERjenIrOGdTb2FQYlNpWXgxL21jZzkzTGpOVWg1V2pN?=
 =?utf-8?B?T3MxdWtacHZ5dGxZN0t2M0NZb0g3Vm1mZVJYQ01iZDFnMk1haTFKNkY0U1R3?=
 =?utf-8?B?UlV6SUMwQ0s0bHZjOXU3ejhxSDZSSXVYNFlLd0hIaWwxa01qemhqN290NENO?=
 =?utf-8?B?NlBTYThDeVVOeEJCR2p2ZjU1WE4vMDRTNkMxSGZCVUFEQzRlUVV6QWF3Vmsw?=
 =?utf-8?Q?n7Ajd/3QAFewEAhKkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c93f73-c3cc-4ba0-0e89-08df0e54ea07
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:29:57.7756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W5aVnKvmllqGj0XIcFd+qwQiiMMu1H2NqjMn8WIT2H2huWHJkfmxcfXl6tzglMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
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



On 09-Sep-26 2:44 PM, Han, Zhen wrote:
> AMD General
> 
> A new VRAM allocation needs to meet:
> 
>          adev->kfd.vram_used + vram_needed <= vram_available
> 
> kfd.vram_used already includes BOs that are later pinned.
> Pinning does not consume extra VRAM. Subtracting vram_pin_size without adding back kfd.vram_pinned counts those bytes twice and causes fake-OOM while VRAM is still free.
> 
> Add kfd.vram_pinned so reserve_mem_limit() matches get_available_memory().
> 
> kfd.vram_pinned is only updated in gpuvm_pin_bo(). dma-buf pin and vmap call amdgpu_bo_pin() only, so the counter stays zero and those BOs are still charged twice. Update the counter on first pin and last unpin in dma-buf pin/vmap and gpuvm_pin_bo.
> 
> Signed-off-by: Zhen Han <Zhen.Han@amd.com>
> ---
> v3:
> - update kfd.vram_pinned from dma-buf pin/vmap and gpuvm_pin_bo
>    on first pin / last unpin in amdgpu_dma_buf.c
> v2:
> - keep vram_pin_size; add kfd.vram_pinned in reserve_mem_limit (Mukul Joshi)
> - leave get_available_memory unchanged
> - drop former 2/2 pin/unpin changes in amdgpu_object.c (Christian König)
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 38 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   | 22 ++++++++++-
>   3 files changed, 53 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4541542a28df..9ebae5ffd2ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -378,6 +378,8 @@ void amdgpu_amdkfd_gpuvm_put_bo_ref(struct amdgpu_bo *bo);
>    * Return: ZERO if successful in pinning, Non-Zero in case of error.
>    */
>   int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> +void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo); void
> +amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo);
> 
>   /**
>    * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 89958d0f7e59..191985dbc569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -237,7 +237,8 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>          if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
>                  uint64_t vram_available =
>                          vram_size - reserved_for_pt - reserved_for_ras -
> -                       atomic64_read(&adev->vram_pin_size);
> +                       atomic64_read(&adev->vram_pin_size) +
> +                       atomic64_read(&adev->kfd.vram_pinned);
>                  if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
>                          ret = -ENOMEM;
>                          goto release;
> @@ -1584,6 +1585,28 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>          return ret;
>   }
> 
> +void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo) {
> +       if (!bo->kfd_bo || !bo->tbo.resource)
> +               return;
> +       if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
> +               return;
> +
> +       atomic64_add(amdgpu_bo_size(bo),
> +                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> +}
> +
> +void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo) {
> +       if (!bo->kfd_bo || !bo->tbo.resource)
> +               return;
> +       if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
> +               return;
> +
> +       atomic64_sub(amdgpu_bo_size(bo),
> +                    &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> +}
> +
>   /**
>    * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
>    * @bo: Handle of buffer object being pinned @@ -1598,11 +1621,14 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,  int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)  {
>          int ret = 0;
> +       bool first_pin;
> 
>          ret = amdgpu_bo_reserve(bo, false);
>          if (unlikely(ret))
>                  return ret;
> 
> +       first_pin = !bo->tbo.pin_count;
> +
>          if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>                  /*
>                   * If bo is not contiguous on VRAM, move to system memory first to ensure @@ -1626,9 +1652,8 @@ int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
> 
>          amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> 
> -       if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
> -                atomic64_add(amdgpu_bo_size(bo),
> -                        &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> +       if (!ret && first_pin)
> +               amdgpu_amdkfd_account_vram_pin(bo);
> 
>   out:
>          amdgpu_bo_unreserve(bo);
> @@ -1653,9 +1678,8 @@ void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> 
>          amdgpu_bo_unpin(bo);
> 
> -       if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
> -               atomic64_sub(amdgpu_bo_size(bo),
> -                       &amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
> +       if (!bo->tbo.pin_count)
> +               amdgpu_amdkfd_account_vram_unpin(bo);
> 
>          amdgpu_bo_unreserve(bo);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 79828c6f694b..e2674540761d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -303,6 +303,8 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>          struct dma_buf *dmabuf = attach->dmabuf;
>          struct amdgpu_bo *bo = gem_to_amdgpu_bo(dmabuf->priv);
>          u32 domains = bo->allowed_domains;
> +       bool first_pin;
> +       int r;
> 
>          dma_resv_assert_held(dmabuf->resv);
> 
> @@ -328,7 +330,12 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>          if (WARN_ON(!domains))
>                  return -EINVAL;
> 
> -       return amdgpu_bo_pin(bo, domains);
> +       first_pin = !bo->tbo.pin_count;
> +       r = amdgpu_bo_pin(bo, domains);
> +       if (!r && first_pin)
> +               amdgpu_amdkfd_account_vram_pin(bo);
> +

This looks incorrect. vram_pin_size already accounts for all the pinned 
ones. The original intent looks to be to avoid double counting only for 
KFD allocated BOs.

BTW, I don't see this patch in drm-next.

Thanks,
Lijo

> +       return r;
>   }
> 
>   /**
> @@ -344,6 +351,8 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>          struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> 
>          amdgpu_bo_unpin(bo);
> +       if (!bo->tbo.pin_count)
> +               amdgpu_amdkfd_account_vram_unpin(bo);
>   }
>   #endif
> 
> @@ -516,6 +525,7 @@ static int amdgpu_dma_buf_vmap(struct dma_buf *dma_buf, struct iosys_map *map)  {
>          struct drm_gem_object *obj = dma_buf->priv;
>          struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +       bool first_pin;
>          int ret;
> 
>          /*
> @@ -523,12 +533,18 @@ static int amdgpu_dma_buf_vmap(struct dma_buf *dma_buf, struct iosys_map *map)
>           * domain is not that important as long as it's mapable. Using
>           * GTT and VRAM should be compatible with most use cases.
>           */
> +       first_pin = !bo->tbo.pin_count;
>          ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM);
>          if (ret)
>                  return ret;
> +       if (first_pin)
> +               amdgpu_amdkfd_account_vram_pin(bo);
>          ret = drm_gem_dmabuf_vmap(dma_buf, map);
> -       if (ret)
> +       if (ret) {
>                  amdgpu_bo_unpin(bo);
> +               if (!bo->tbo.pin_count)
> +                       amdgpu_amdkfd_account_vram_unpin(bo);
> +       }
> 
>          return ret;
>   }
> @@ -540,6 +556,8 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
> 
>          drm_gem_dmabuf_vunmap(dma_buf, map);
>          amdgpu_bo_unpin(bo);
> +       if (!bo->tbo.pin_count)
> +               amdgpu_amdkfd_account_vram_unpin(bo);
>   }
>   #endif
> 
> --
> 2.43.7

