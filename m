Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47639C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ADD10E58F;
	Fri, 14 Aug 2026 17:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMXF7V6F";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF2810E58F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v51YBF+2ptqi60WlCckCqDKjTJA39//OOQvLH3ut4FzuLw3QA6tMTduBQJpX4P2Qwk2qmSTdEtIR50CJJlIThqfp5S9s5mH9Pb+K1933xuRZ8TO2H5XWUB6xgtNQlaNN6gNUxWBv/QRYDgN8634B/8vCXEUqEQFkDTI2Khr23F4YMD51aKA++WRYWE3bEX1WQC1/pkfCgl/LbPf+oT08idmx0mvcAlIxLlu8tPrmL1+Z4052cBLwQn9e4N/uXpb0twFo+6cZ147IEGWT11NEzdqSWBoKP3s2wb1sWAuEonJmWV+gLRbM4ji51drvP6pDOUqrk9XstZ6s5932q9yy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnHC5BD86Of85PQEAVyuneGacGRjYkqY/0bHwtHz86U=;
 b=RYj1/rRo2HyplDMaTxTV72NoEYu8mXSYvNw6NDVEnmv4Jq+1/t2VwmxQVX1Q1LRlg02rx0QRc1f+6LTY7XPDIXPOjlikDZv9lpBy74ELUYI/KA+woU+9V8NoPXBrbeSv6BX+ritSESHvyHSNhMfNfIrgmOZ0c4pvFwrLQ0Ynn6YuKtYDCy0JT+ePCBG5qSZJWMy0O6Bew5b1FMK2p+VDESdEkT2xV9ZnbK1WF/CPlmr6c+nQOtIkkzuofLuTLbZDPsJaolW0RancHYCuA+tw13FtVnOS5tHxpQjD/IIX9RZ6lBO+jbjwCYdaFfOS/dFKkZgDZ8ZXRF1/MxZG/P0/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnHC5BD86Of85PQEAVyuneGacGRjYkqY/0bHwtHz86U=;
 b=AMXF7V6FmdjXXVl1KMrFR7RMPgU6N5KQ+plBLm34o3QUiDUXGOQYbYNAafeUr+Jvunq/mIvVK9LDrznLgJI9qk/n2XUMCkGS7OrCGIgq2+x9FVA9ZHmCH9iz1ORoCu3JuD0cRxbJby6G7/gJUWjqG9ONeGqhtvhha2gYAGhLp4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:14:29 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 17:14:29 +0000
Message-ID: <3af940dd-adcf-43d2-a825-241ca54062b2@amd.com>
Date: Fri, 14 Aug 2026 19:14:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260814154212.2688253-1-alexander.deucher@amd.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20260814154212.2688253-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::9) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 381cc1b9-21e7-4596-902c-08defa277fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: THHgMoST003j3qT81bz20Cu3T4mde3R9VgyurOM1iiTfn8Cabmc+F+m4tawvuRwjAg4/slvnlFqP4ONbso/k2VCpf+fJb4Kyt+GkyYv4zl+O6/nn+aAKqWv/HoV0UKo30wdCF2aq22wPDTQ5Abtmhj05I5UPSyrBvwZaeH3A5C5G1vU4z7w80W8eZDu+tWGPWay1oaIIfOutTf/+SRb2jumNQyWswIKbd3XE7V3HcXWnUfP9Lx7uiXwag43ruPAR/ZxOpYkUYEvF9aa2ogfyftqv2uf0vWeSb9hQDni00XMHdSOiwikRhoTQXAfGgaQubjXRMx+6KZlYhF8sJzWfPzv66NZxmljeQ7y+OIf2asCS1UMBTuv0hAvRysMDdfmx40UxJ0qUwti37x1VJDQZQQcsU+XV3wowvfLiLyZO2Hh3yWd/niJHywZynfyUv+QknDXKpkj0OLb8ctZcMd6ABQfanGulzPZiYtrRnq/opRDIzuFqQmLNSWPOicT36zPuey8PYZGq/Hn7OEicJLd+bRoASrqbPeIGZ1imAdRd1ADn3G+/NXPjOqg8cOUYhF5T+5paTRH5+IZgcQZDnrM3Pb8lFLzXnYr8Na9xg9z1dURTfDmhykkOvsscOGgEtTUrccb20hBaRIZdGY0BEJ9In5JSnhwRvbKXUP0Un7bcMRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFh2QXpuLzdBcGJpSXdIOU44ay96V3JpUWFpdkpJeFA4Wk9WclBkYml2QVVx?=
 =?utf-8?B?aHZ0NGczSW5VMjdTcm5KVjdrUzVETzFzclRWeE05Zkd0WXlKSUM0KzZLYlFE?=
 =?utf-8?B?MDB6ZWtCTXZHbEJ4U2RIbEc1MWVsS0w0V0Q0WGFoREVTbEVmdkdRekJGZjVk?=
 =?utf-8?B?MzJDeFJGWDFyeHZOT0E5a0NMWUtGNUM0VlBSUmVETmtDdDkxRkIybkVFVUJ5?=
 =?utf-8?B?cUxwTkJFSU1zYXlOajJPTzk2NnkzcTMwKzdUSWwyblNZNjRiK1dnQkthdXNX?=
 =?utf-8?B?S0dEZUNOOFI0bmlNYU0wM3drSG5uQ2V5QmZyL1Q2ejJKZUxWSWF3RThQWmY5?=
 =?utf-8?B?N1ZERGRrNkN1K1Rsd0UwbWJZbk5xYVR3bVlrTzRjaVc4RXl4aTZSbUtYbXlI?=
 =?utf-8?B?Y2Q3dGp3TktGOVhvNFEyRXhQbklJN1ZGY3F1VU96NHpLdlF4TEJyeGdyVU9s?=
 =?utf-8?B?U2xZT3dmaFBBV3dBWjBvcytCQ294UmlKTjdJTmdtVWVPMmZYSW1CRVJtSUtZ?=
 =?utf-8?B?ZU5DTjViMURhZHl5dTRVNkw2ek1ha3YxSDZ3SFdOcmJzK3BleGVLajVMbXVI?=
 =?utf-8?B?Z2ptM2hGTThFN3J5b0tPNE00amg4MGFGNXlHZmVtRXEzb0phNjRaZzJqRHRE?=
 =?utf-8?B?ckxqckJqSDdSUytobnBrSVhmVnJEbkhWbTEyMmo1MUdHQWNQQjFZMDA4RlFs?=
 =?utf-8?B?NlFwZktmVWZ0MDR5ekFTOStwOEU5YWZHMzBnYUJLRDVjNUFNS0xEc3M1UzMv?=
 =?utf-8?B?QVNVWlliT25qOFRWeXRVS3hIK3hGYmovNldUZkJGM3FLMjlkZWtlM0tySzRk?=
 =?utf-8?B?MWh3MnV3YmYwVm9SYm0yc3ZvcWRLdkFBWDhRV2ZaTkY5Zkk3b3NnQS9kNldP?=
 =?utf-8?B?Q1VUQVJhTmM4ZDVyZWRCa0VTb1FJV0VueklCRGFsazZnQmNIVHhGTmxuMnAv?=
 =?utf-8?B?QmpWcTZ1b0lkVjJmME5ZbUlETnpXVkJVZ2ZZeXhrVmduTDYrT253MVA2S09H?=
 =?utf-8?B?UDMxWWpRS1lmVllvdFMyVGF1RG0yL0NFVzMzYWozKzB4cWU0eHNiZHppTmdx?=
 =?utf-8?B?NGF5K2NOelJkQmRaRkh4M09aYUZCcU1TeUYxY1dreXlyL2Z1TzErb1BjL2lr?=
 =?utf-8?B?Nlh5dk5MZHJFWVVMTFdRR01LSzQ5bXQ5eVZTeEUyK2pScE1DbkRyTGFnVnBz?=
 =?utf-8?B?R2FJcDMzK255eFVHRkxsa3BtZlNqQlZIcE8xRWpnVGEybmMyWXFWU2xKZU1V?=
 =?utf-8?B?bGVRMmtHU2VRVVpIQk9BUkpNSWJWU2UrNk9hYUFBdVhYLzBrZi9SZElldFF6?=
 =?utf-8?B?R3lhQ25nMytOSDNqMzdyK1ZwUFV4R0orMDdXODRPcUJXNEVIVzNJWWlIeGZn?=
 =?utf-8?B?UWVqSzJvOFpwWG1GSTBqR05hYmdOeGJGM1FCUm1VZ1VldGgxQUFLNkJiQlla?=
 =?utf-8?B?VHFMZXpSZ3hNb1RCQmtXaFpGL3ROem5aczFCSUVaTkc2QXFmZjF4bW9DbWEy?=
 =?utf-8?B?dWl2Y2JCRWpNUVVZMHNUdk1DdlBsY0ZyYVFaU2ZOSjlIVFdGYzkzZlJCb0lx?=
 =?utf-8?B?bjFFQit6bVpFSTJ6QzZNejFyemtEREFFUTBTUm1CMGVNSkRFT2dpTGRDS2N6?=
 =?utf-8?B?N2VBK2NFREpnVzY3ZzFxdnl3eEJ3eGJ6UXpyek56QkxCSHFPWXdjNlNRTm5s?=
 =?utf-8?B?dDE2T3RtUTNVb2RIK0w4dllBUXRNVUdIbUF3dmYxN3lDYmY2WW5GTmVYUWQv?=
 =?utf-8?B?eXM5VHZqLzk2NkV0amtJSUY1am9ZTHBONWR3alBjUHNLOEFvN0Q1N3QzVmdJ?=
 =?utf-8?B?NjRlemJmRjdBeGErQXVrZkROeEFuNS9wS3dYWEYzOFJzN3lBVHg0emYyY2NJ?=
 =?utf-8?B?WEZ0b002TzNYUlU3SHh6U0JESnJUamhkQmRwb0JKVkxFcFJPVTRhaUg5c3hD?=
 =?utf-8?B?M1NIR3l0aTFMWDdFRXBKdWlJcFYrKzgrUFpwYXRZTUpEVW9FVHBpenhrMlRE?=
 =?utf-8?B?ZVQ2eGxGQjB3dFdmbE5OYUhDWmY2M2NqSFRpR2l6SkIzY0ZobXpOUDNhbDY3?=
 =?utf-8?B?MEMwTkg2b2NvRjV6SE5JRGdLSytQOHJWdjBpTURFTFpYY3F1eVM0OHRCTlBP?=
 =?utf-8?B?c3FId3RuS0lEZ1ptYkR1WXVyQm4rQkphcHErVWUxaHR5eU1IdENPdFZIWFNq?=
 =?utf-8?B?ZW5vaDhEZy9wMXRSOUF1ckJ3ZmlsTzhFM2NEaDM2NEZGQ3pnVHZmellYNWRj?=
 =?utf-8?B?RWpza2lUbXQvMndQVXMyRHJkVDRvNVZDbXRyR2FVZVJwWjlEYnpjR0tHdHd2?=
 =?utf-8?B?cWsrS0xBa3krUHBVWmdwUzl4c1E3cjBtMHVOMG1FaW5XUitjbEEydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381cc1b9-21e7-4596-902c-08defa277fdb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:14:29.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FHhkXFgSG6yhoEI17YdYWmA8hLH7lDXBgk51NH+wvQHIBKerzHoqsOptmExR6VkNTy7Tuoz8Hx1paIzVKkoRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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


On 8/14/26 17:42, Alex Deucher wrote:
> If we end up emitting a VM fence keep pipeline sync
> associated with that fence.  If not, emit them as
> part of the IB fence.
>
> Cc: David Rosca <david.rosca@amd.com>
> Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>   3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index da4dc489e80bd..360e6f00cb7c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   		vm_af = job->hw_vm_fence;
>   		/* VM sequence */
>   		vm_af->ib_wptr = ring->wptr;
> -		amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
> +		amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
>   				&emit_gds_needed);
>   		vm_af->ib_dw_size =
>   			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
> @@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	if (ring->funcs->insert_start)
>   		ring->funcs->insert_start(ring);
>   
> +	/* this may have been handled by amdgpu_vm_flush */
> +	if (need_pipe_sync)
> +		amdgpu_ring_emit_pipeline_sync(ring);
> +
>   	if (emit_spm_needed)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 71050a86bcc3a..4bd9368b13d97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>    * Emit a VM flush when it is necessary.
>    */
>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool need_pipe_sync, bool *emit_spm_needed,
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
>   		     bool *emit_gds_needed)
>   {
>   	struct amdgpu_device *adev = ring->adev;
need_pipe_sync should also be removed from this condition below:

     if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
         !cleaner_shader_needed && !spm_update_needed)
         return;

With that, Reviewed-by: David Rosca <david.rosca@amd.com>

> @@ -847,8 +847,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
>   
> -	if (need_pipe_sync)
> +	if (emit_fence && *need_pipe_sync) {
>   		amdgpu_ring_emit_pipeline_sync(ring);
> +		*need_pipe_sync = false;
> +	}
>   
>   	if (cleaner_shader_needed)
>   		ring->funcs->emit_cleaner_shader(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7f2ba728e3ed3..d32183cd9e0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
>   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool need_pipe_sync, bool *emit_spm_needed,
> +		     bool *need_pipe_sync, bool *emit_spm_needed,
>   		     bool *emit_gds_needed);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
