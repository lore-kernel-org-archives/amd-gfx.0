Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3519CC5CFCF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 12:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD7910E4CE;
	Thu, 13 Aug 2026 12:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jl1ot9F4";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D987C10E4CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 12:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOapeLar4w/NquHyQaW/rzv4o3ACQUqcoyOKtxNF5p1cDV0q39ELLxwgjZjuHhKvhR3EDCqIYtJ63yiwxMUEuRdJ7kDQWUfdu/SCGUjbyKATXd2KDrYeKX/MK0omxXjoAok+QRNpy4+zesnSxNlukFpiGRyPdeoQ654tm3OWZ0l+cUiqliaM+oWaoqimbgpS7VErurM5HttOKKlW5lwl44rU3uwOm0TVjBddJt2doLgD9XDabOINMRVXMgItVckKsKfUZo+wtZHjkQTHtzIKRs3/P1n09x/Ymn4ZsaeKddrb8SgnZRnUOVnbmfKuWfmrR94LVVU4eMBRQlMjGud9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEKRD/5PujlZmNYncqgvIfQ/tUVZI6SbXgNGGx4Xfng=;
 b=YucpGPK1CBsqMcwcfEA8tFo8cFx+nTs7SslJqJEKY0/8v+8zd/DhjHQLN9WJ/ywzHbzoMSXidj/c7KLDzZ/gbpuDr7RP6fTqMALcXW6gL5UWBu/zKUEAjPIQrqXGjKiIqH1IBbOX6OVxz3wg8Cx6L7sev9NP102nOoi/e7kMqnOCMPT4u1+/4raZoQT5mTcpB2xP8XX6twsR8VHGsVfKLxRFMaHscLWTtepH2ouo9TssHyRiaCThgro1sFI/gS7dUlMxBSDsVfj0TFxhC/rPYcYLMZ8EoMbaUINs/n+5dJYrboGfAg0wzYqffv04jOYYwDXw8STCpSOATmFT+V1Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEKRD/5PujlZmNYncqgvIfQ/tUVZI6SbXgNGGx4Xfng=;
 b=jl1ot9F4QjKGFzqJvTenT1OI24Zn+hmHAGYwi5W6EspZngf+TY2ZPBxKyan3VZr4o44spjvP4ZW72i4gKlwEEkrOjhVzyB12Ten1jrr2pwSmN+aJ1ihhoS1u6AP/fcBXcndEXTpVwsxoxYXi3g9VUjNUIdTCuI9/lfI2CbnOiOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 12:22:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 12:22:57 +0000
Message-ID: <1d9cbc80-c227-4b5b-8305-d2038875b559@amd.com>
Date: Thu, 13 Aug 2026 14:22:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: handle GDS and SPM without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182414.630372-1-alexander.deucher@amd.com>
 <20260713182414.630372-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260713182414.630372-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: da1e749d-256a-4fa9-5b9c-08def9359b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 823ROzmcW2oFLybaVM4YHw4uiDl4cwNEEwbeXzmfChjLFGp6X5VuTouFZF+UxK2kVhWXxBJFulCUwCG323sy5h6sg06G8PFgn/tlMFs1VUag0FnxpwlvC+iRMSMEaW9Cb2YJUZFsO20gffx4dzr7yns7MxrrzYrjYjwr6sPD+CKvtAAipu+0zdjq3oydG8/tfzkem3c6qgMLJfM6lxfTJGALFNZsb8anWz/PJSpXKVCAGYujy/S/S8r6G2xBOiLB2ooUyf+DMfYYldojHnTUhiA0LuYlqmgk7coZTHoWb/N2NsY/RY5/biHW8D0baOYg301M3M+1IFPQ9Id4SgnxrkVpTjfbGSbvJ4J6fF3VfFx2Lh2gQMOm1X+7juUFJpkbJ0cgdLp88/Smg7vszn9Pl6XxsZKhU0v5vSkZEZeer4Rj/CJs1VM5EzFkNLH5xtVu/JnQ3VcnFnFy9g3Y24LijPbHXlSFwvkRzM2wgM86/eQbNSRedHZ3xnzVqqasoqq/+OGf5dnj6I9aMrqLMX82Hw/zFEXll0EMq1/NRpfhf2ikWC80w3dPWiSsh5YqX2EgN66SWXWobn8qWh6qgiPL6obh8X1WpXRX/emSOIlfubLIGgWyegj5T2qXSdNhDV6JmRJqERUCL3CFAVfSPQLBxNaYZQKJfHaeE1cL6TMD/d0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNMbDlwS0JmcG1abGZVWkJ0NW5VdlFDYnZsN2x3RU5GRWRWRFpCbEk3R1lU?=
 =?utf-8?B?eGtnWE9VY1RJZFpuZm9ZMlFSV1IzU3hSYlZTMHlIOGxFaGZMUGFWTlhGOFBC?=
 =?utf-8?B?MHpPcFRlbXhBMENlc1JVWmdVTWNjcHNEMy85aWxQZkxkRzFBN0R2Mnh3bFY2?=
 =?utf-8?B?RkhzUndITkxpbk5QSHJFb3N5czBXSUJMT0M3S2x1ZCtYZnEyRGc1WStZZ1Mv?=
 =?utf-8?B?SGk2bWtCbnZFVTBIdE5lVEVCb3E4T0cveWdrMGRSM1E3bkUxVmFNQXhVYmJs?=
 =?utf-8?B?OWdIbEZ0ZEpyQ1BHelBIVjd0K1ptZEdxSWgzRXYzKzVtUktXU3RialFnZDVt?=
 =?utf-8?B?UXQvdlBqTTgxV2x1a29sYU40RUVZREI2WTZJd2VVVG9qYjN0OXpPQWlCNXJ4?=
 =?utf-8?B?NllQRm5ZMThqTmZiU3pld2dpVzhBaFV5UzZaL0FrQjhLSmVrak1FMFhuSjZZ?=
 =?utf-8?B?SkZpSmtuVDVSVlhmNXdGYnFseHFadGhzeVBQVmZSdFlSSUJCb05rNm9aVkNx?=
 =?utf-8?B?M1FMVEZVZHZkaHVyYTNEVkV1NVpEamRCaDZBZHdNbkNwRTNtc3NCOGVmODVs?=
 =?utf-8?B?UzQ2eHRWQ3A2WmVib1hiTWN5Sm1GQVJHaytxODFCdXFvUVd3N21yMkVVc081?=
 =?utf-8?B?Nk1naUZ1RkZkWVdiaW56UnpPM3g5YkwxeUk4MUYrRzlyVENKVmpHN25uYTcw?=
 =?utf-8?B?cG10TThDL2NBQlM2Tmc4OHJVNWhKa2JXcU5yT2tQaGFZMGpkWG1SRE1relpo?=
 =?utf-8?B?ajg5RE9xTUUyMXg2UjFiQzBMdDIvZmVPR2xPUGhpSW94eUtsUzJCM2hwbkJa?=
 =?utf-8?B?V2xwaVh4emYzeE5FL2l3RnVoY2Z2cFVjaGpTNTJoRG1CcUk5YTNkMzMxMFly?=
 =?utf-8?B?K28zcnFqMEllZW9ydTBJdm14aFAxMTN1SFh3YnlaakVRSXo4TlpzNmZySzVS?=
 =?utf-8?B?ZG1Jcm1PQXpnd0RKU2RPYVlIajIxRnVkbXlwaE5xQWpyWnVveUZBcGQvbWpt?=
 =?utf-8?B?U3B1NkczNldrYmhyeDJmeFpCdnVzczlUUld5d3g2bGNDY1R4OU04Ri80UU82?=
 =?utf-8?B?MTZzZHlRRzF2c1JMQXZRbzJ2K2pIc0d5ZEUreDE1THNlcDJLSW02TFZURnFq?=
 =?utf-8?B?MlVHV1RNV2FWMDR3b05vM1c2OVdzazVzVGxybXZ6VzBjemNwUzBmaUFxMjZw?=
 =?utf-8?B?RWJVLzZHMGx5SzV5Y3pGemN3Slg2R1FEQ2c3eldhcGlqYVQ5YnRmeXVPSUpt?=
 =?utf-8?B?dERZcS84MTNTR0lwMU84UkdHZWo2R1pjS3NHQ2hUODB4YzNQdnpzYVB2RVo4?=
 =?utf-8?B?R0FYOWRSTjhtN2JSQzhvMmRxNGZ1NXI1WWVmMEtlVnh5dDhndjZoU2FXbmJp?=
 =?utf-8?B?em92VzFsaUVGelNNSmhLUXBaYTcyZzkyYUtCWHIvKy9yK0FsSUw5bG9uVHox?=
 =?utf-8?B?V3RyRnNVWExubnkxcU9kSHdtbWVZb1ZmdUh2SDhHWlM5cWM0M0VXOG16Skp3?=
 =?utf-8?B?WGs1Y3NlY1hMMnRzN0NpMmp2aUhWVGsxUERDYWZCNWJLVDdwRHArUGhLUmU5?=
 =?utf-8?B?MUw2S0lTOVZQZHpvMzF5N2lRQzQyOU02em53eklqM0twaEV3VksyR0FQQnBk?=
 =?utf-8?B?QWRTcmwvN00vdUUxcTZ1dzIvL2tmd0lQUmZyZkJuSjdpeng3eVNJK0hmVUNV?=
 =?utf-8?B?K1k4Y24za2VGdUdKYXJUcWdQdnpneUtTeUZwNGpmeGkxQlM1WVlGZFU1UjhS?=
 =?utf-8?B?T08zd0tZUjRQaFd0cG9EQXVaMGxCZlBGZjAvSWVjNzZiajlVSnk4UmRnQnJm?=
 =?utf-8?B?WlV3aURDalFyK0R5dmxqdGRpVlFTZEZzOE9EaVplcDBNR09IZk1HbnVWZExP?=
 =?utf-8?B?STFTL2pEQTJyTWIycGF4QmgzenVCRDJPaHRqNUg5dE9udGxrdnlkZFdKdCtI?=
 =?utf-8?B?Ti8xbFdxZ0tLU0tOL2p0Q1Bic0pGS3hydHpLaVB3Vnh1Nm1aSUdBbjVuUVRR?=
 =?utf-8?B?cnNBbHBzN2p4cTFkdVREQWFiZ3NjUmEyMjZxQUVnRjFDRmkzMGxyN0RJV2FL?=
 =?utf-8?B?eVk5czFvVUJNUFF5TkVWZVoxbENjODlYWWFaU0FoVi9OQzN6M1VUL0R1dGlh?=
 =?utf-8?B?aitVQXJ5bDc4SkVVUXk1YW1WTnhCWk84VGFaTmZQU1JmaFovYVI1T3dBZjEz?=
 =?utf-8?B?a3o5NDhrVnR3cmhzUFVUbDJNaGxxSkQ4NE1KcTVvbmVlSENmQ3dlV1JzMWxw?=
 =?utf-8?B?N0JSY1FiZ2pOaWxqcmpxallPdTJRQlJ6dW9tSkFLRU9tQWJOOE9EMUNpREk0?=
 =?utf-8?Q?Y9SY/R3bIxAiAVwBMP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1e749d-256a-4fa9-5b9c-08def9359b90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:22:57.4418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct+qX8EBiT2VYey1KjezOPnZqjX03FoVD/rk1XFBJYNwMX0CgZTOvbUosgqIP9gH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

On 7/13/26 20:24, Alex Deucher wrote:
> If we end up emitting a VM fence keep GDS and SPM
> associated with that fence.  If not, emit them as
> part of the IB fence.

I've just stumbled over that this was pushed into amd-staging-drm-next.

As far as I can see the patch doesn't make any sense at all. Why should we do that?

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 14 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 47 ++++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++-
>  3 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index f1ed4a436f5b4..d439c68eed9de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -131,6 +131,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	struct amdgpu_fence *af;
>  	struct amdgpu_fence *vm_af;
>  	bool need_ctx_switch;
> +	bool emit_spm_needed = false;
> +	bool emit_gds_needed = false;
>  	struct amdgpu_vm *vm;
>  	uint64_t fence_ctx;
>  	uint32_t status = 0, alloc_size;
> @@ -220,7 +222,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		vm_af = job->hw_vm_fence;
>  		/* VM sequence */
>  		vm_af->ib_wptr = ring->wptr;
> -		amdgpu_vm_flush(ring, job, need_pipe_sync);
> +		amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
> +				&emit_gds_needed);
>  		vm_af->ib_dw_size =
>  			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>  	}
> @@ -232,6 +235,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	if (ring->funcs->insert_start)
>  		ring->funcs->insert_start(ring);
>  
> +	if (emit_spm_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +
> +	if (emit_gds_needed)
> +		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> +					    job->gds_size, job->gws_base,
> +					    job->gws_size, job->oa_base,
> +					    job->oa_size);
> +
>  	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
>  		ring->funcs->emit_mem_sync(ring);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aec8468634535..756810c606d80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -766,18 +766,22 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   * @ring: ring to use for flush
>   * @job:  related job
>   * @need_pipe_sync: is pipe sync needed
> + * @emit_spm_needed: does the caller need to emit spm
> + * @emit_gds_needed: does the caller need to emit gds
>   *
>   * Emit a VM flush when it is necessary.
>   */
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool need_pipe_sync)
> +		     bool need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>  	unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>  	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> +	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
> +		job->spm_update_needed;
>  	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>  		job->gds_switch_needed;
>  	bool vm_flush_needed = job->vm_needs_flush;
> @@ -785,6 +789,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	bool pasid_mapping_needed = false;
>  	struct dma_fence *fence = NULL;
>  	unsigned int patch = 0;
> +	bool emit_fence;
>  
>  	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>  		gds_switch_needed = true;
> @@ -800,6 +805,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	mutex_unlock(&id_mgr->lock);
>  
>  	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>  	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>  			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>  	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
> @@ -810,6 +816,17 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>  		&job->base.s_fence->scheduled == isolation->spearhead;
>  
> +	emit_fence = !!(vm_flush_needed || pasid_mapping_needed ||
> +			cleaner_shader_needed);
> +
> +	*emit_spm_needed = spm_update_needed;
> +	if (spm_update_needed && emit_fence)
> +		*emit_spm_needed = false;
> +
> +	*emit_gds_needed = gds_switch_needed;
> +	if (gds_switch_needed && emit_fence)
> +		*emit_gds_needed = false;
> +
>  	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>  	    !cleaner_shader_needed && !spm_update_needed)
>  		return;
> @@ -844,21 +861,21 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (pasid_mapping_needed)
>  		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>  
> -	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +	if (emit_fence) {
> +		if (spm_update_needed)
> +			adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>  
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> -		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> -					    job->gds_size, job->gws_base,
> -					    job->gws_size, job->oa_base,
> -					    job->oa_size);
> -	}
> +		if (gds_switch_needed)
> +			amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> +						    job->gds_size, job->gws_base,
> +						    job->gws_size, job->oa_base,
> +						    job->oa_size);
>  
> -	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> -	fence = &job->hw_vm_fence->base;
> -	/* get a ref for the job */
> -	dma_fence_get(fence);
> +		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> +		fence = &job->hw_vm_fence->base;
> +		/* get a ref for the job */
> +		dma_fence_get(fence);
> +	}
>  
>  	if (vm_flush_needed) {
>  		mutex_lock(&id_mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 939f639cd8bfd..f82572b71c5ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -515,7 +515,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       struct ww_acquire_ctx *ticket,
>  		       int (*callback)(void *p, struct amdgpu_bo *bo),
>  		       void *param);
> -void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		     bool need_pipe_sync, bool *emit_spm_needed,
> +		     bool *emit_gds_needed);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,

