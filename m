Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340FC5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 20:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D593010E459;
	Mon, 17 Aug 2026 20:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6r2kjdX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7018110E076
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 20:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2AByTe9YtCfikmKsWbb5Ph5LAV21KyYhjjdgY8hW18DV77NBj4N3t96SLgCKGx66neZihC5nvD94t/GbG0Y7wYS7sBNW7TiSwvo+seUaMeoSBfnHMa9C3te35Ls+ItkUZyrnsxvijNIHl40k/tdJYLnoR8YaKlZAwZFctyWUcsTmce7s/uRtSt52BlthEWpVjxOMVbw2ko16FCRxCwL7V1oBczsr5BiLjUWinBHUCHgUi1zary07dVx2oZUTlLYGbRTAMNp+lTzCbEfbxC7hPm5KSwAL61oUdvoVvec5t03rx0tM2rUK0cM58aefR9Mb2MoZIAwgcAWXakhdb7IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuixcqqkgvTckbFjWPFkKMmYxd6JGb1s9SgE8VZdNn8=;
 b=XgVgFlb1jJEju6KG/ioM0XPJwJqOHWJ/R42thN4O+o1JWqPv0kXlqb8WZSotY5MMAZMZTIhmIxp0Y9xYnHJLCb81k9vyg2xo0MwmVTsCZmBR6ZqKBEkwhxw6JGeDybVHpzfdCgNYSum1zzc5+gR26sgbXha+pFainO69TwCcLVduM3mUOibHxC2KdDROOAZWcP5D0sEgDVoG027h1UroXsxbkxdvogENbnzWB0pC3SCQ26zOz1a02UTKp3XijQe7olBC+5PxaWbSUOfN9D6XBzJYc9iCpb5wdEqb08q9mXvgJwH2SEMKmKKEIxLI69mzn1BOerb53AE28rDn+5GSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuixcqqkgvTckbFjWPFkKMmYxd6JGb1s9SgE8VZdNn8=;
 b=R6r2kjdX74FSBUNHxTteMlUabjWwM3hohP4uOX53t3PD9tA12z1W75KpcfCUb7ooH/vLxYOQwWJXiQxqFMypMEn0uh0rU9zVDhkxMXPkokW5VsmpVee3wLyeWE78Lkc/hUPeXIsD6kgxIm1ipp509mcyhaKcyDcrdYmd+mHWiRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:46:00 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Mon, 17 Aug 2026
 20:46:00 +0000
Message-ID: <0439317f-61e5-4595-9bb6-c99c506194f6@amd.com>
Date: Mon, 17 Aug 2026 22:45:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260814172914.2691513-1-alexander.deucher@amd.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20260814172914.2691513-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::28) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c578748-c24c-42c4-3610-08defca08bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hvWB8VBTylz7Sw0Iw0waj0OLoG1Oqz6IbryuUNJF1JT/t4R32tuJ0bHuc2uj14KqNLig5hd8J05/is5x7SF172DJdNvauYwVk9PTNatfgL2b4uj5wCifxJvicblCH/RgWfJoPYzRpDjmocDj1gDtL/+doTHC39sxtetJ5QFThjKBLFJ6cPrCEiUDBAUnhG2fyRAdGs1i8r/Y4VYksidEXBWnbpeMcmX6p8a/JKXvAsCfdnDKbc1cHVVhO3ejmF0Uo/+vZ0VMCODCqje4eV3sFSy7lgpMEKVoTB7AGvzO1yREg2QinbWR6zSoKVXLJepXsPfiCym4UmC5nowHdeECZUFSaAPD4cnxHy20wp12i9J4Gg84dmTybPKtiNw4Ozg8pWqgnt6RgnrYhsfNiXKD4w+GSZHz69rrPwfYNY11fBQ4ru71+cIioU4qQz+mfB3u8IhIFZkwDWqH5n7t0gEi+rvBYXSW0pYZc4h+Ypw262u5enefgUnXQViqhxQt1dwimQnPN5Idxnim6pPLunW++MgWkcJzuKzVOqFwLUJyhqhSPKYpMEjcBa3zrg7fu9BhF8fVgc/Uj6KpSt9SzB36KAwWGmwqoqOf/52LEpuEkSw0jYqae2MtbTfgR40yWk48YM8ybRoIRbEVNgPe0g0PIxyUaNj03BAYkfu5L9iVWuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1WNU11OWlSVXYwVmcxME12cndaZnlwOWlWOE1kdlNkRHp5WnVwelZLVEZ4?=
 =?utf-8?B?S0hzckREYThscWYrbG1vRkoyZW0ydm8zSm9jTWhUdmxVOUxycGRrQ2ZKUG84?=
 =?utf-8?B?blZKNDlnNmVtRUpsWExFaFBTKzNuVUlRcmtCcHBSaGtrcUhybGJFNCtxT1dM?=
 =?utf-8?B?RFNUQ0Z5ckdXWmJxMGQzWnBCMmVEbzdrRGUrQjdMRXpnOXBNaDdRNUVoTEdF?=
 =?utf-8?B?RjAxT0s0Q3VPWXA4YUhVeTE2L3h6ZFhRR2UrUW5FSEFWT0Y2bXJwOU5nZm5E?=
 =?utf-8?B?NHRnQkFsMTZMM2dqWmpXQjI3QjNiM0ZmSE01YmExSUxpZll3MjBwSTc3N0ln?=
 =?utf-8?B?Nms1SldqL3BxTFYyTkJNWjk1VjZkLzNyN2xCeTBoWWJPelg2WGxGUWl2SU4r?=
 =?utf-8?B?RHFMWDVXYTJiUTVjR0pzZnMvNUVNL1IzMkh4Q1dDcDc4b2NFZTNaNXg5bDNC?=
 =?utf-8?B?bW0yWGpMbmNGUGJLL1JVaTJlSjA2R2dlZ1VWaFF2SFVpWUh6OXpYeGI4Smc3?=
 =?utf-8?B?djNHZkV6WjlnZXcwK1p6Y25LbXlXMUoyWXN6aUZiSlFvQkkvNW96SmtndUpD?=
 =?utf-8?B?c0FGSG5wODBvaG8veUR0VUhIbmxuUHoyM2lWK2FYNHNQV0pHSXdlWkdHRjUx?=
 =?utf-8?B?bHZOMjEvb040bGJzcmUwbHUwUURmZVdaKzNJZ2xtcklJZmo1QUQzZUl1Uk9h?=
 =?utf-8?B?UnJpWE5UNnAxaWkzUk8vajhkdU1COHY0VHNtWEEzWGt2YmFzQ1VoZVhrenRo?=
 =?utf-8?B?R3YyZS9DK2MvL3Jzb2tveS9FUkRSeEJXQnpldHVqMVJJTmdUS1ZXSnNwVjdC?=
 =?utf-8?B?cmZ6ZHpTeG5oblhwUGoyeXZ6QTN1NS9mUmUzNzJXWEN3NmdlbVNlVlhqRXVy?=
 =?utf-8?B?dzIrWTZVTytYTk1aK3pHcTA4RU8xUlcyc1VyRDNpVEkvR1cvbnhBQkVGeUNC?=
 =?utf-8?B?OXZ4ZXBUTXB0OENTUXFrYVRIWE5qYy9YS2JUc2FsUS9VVWVNdTdxRmZPdElS?=
 =?utf-8?B?WUd1cTZnVExaZE1CVlJTb0VtYURhdUV0SFpIL2F4R3I4dVVhZUtXaEpEQ0lN?=
 =?utf-8?B?QjZHcWYzWlZvZFowcTBpWlNXdkhkeExEQ2pFMUlCTW9QRDlLTyt1aHc5Rlhv?=
 =?utf-8?B?cFV6NWNzZTRPLzhrK1RuZTEwZ2wyc2toeGlPUjREd0pvWTdsSFIxaWMwS2gy?=
 =?utf-8?B?d3czVEpIb1VCQ2ZXTy83by9LcmZJSEdTV2lzVEN1UjF6OVdMSitWZTlGWGlO?=
 =?utf-8?B?bTZWQ1dVOExLOTNna0xMcGFYTFdib3Rld0pVUXZyMlE5dktMOTl3cC9FVGw1?=
 =?utf-8?B?aU9LbHhEV0Q2ajBYMTEvenRmcUhBU05qb0RoNW95Q0dHMTJ4N28xblQrVVhT?=
 =?utf-8?B?NlJIdlgyWDkvYmtLZWJvMkh3NUlxTnBNcmhFNS9Jd2ZBbmpKOVI4VTluaWM5?=
 =?utf-8?B?cmhYMmc0a011VVZNTEppLytDOWZLZ3M5Sm5XVHh5aS90K2NHb2xWbVdpMldi?=
 =?utf-8?B?L0xIVzdiRFprT1Z0b2c3bDhIcGNKL1N5Q1JSS2ZJRHpnQnlkdUVJdnh1eUcz?=
 =?utf-8?B?bWpjUHg5RXNQY0djRFdMZ01DU1dtV3l6TUQzL2UwMnlvbkJEMTQreFUvdFph?=
 =?utf-8?B?eU5CMzlzNDJQaVBzUmZDdGRueDl1c252dU01U3BvK0k0Zk1qc2dnbndYZzgz?=
 =?utf-8?B?S1FYY0IyWmhuTzJwU3pLQ1JlbGZEbGFwQUdiWUJ3YU9wTDBMWG84TU9mMDFv?=
 =?utf-8?B?d1NsNG43ejlpYlFMZUVSMFBVcGgvMHU4SnJTcmc4TnRyVWx3YmtXdFRFaHZs?=
 =?utf-8?B?WjhGSlZZY1JvRVh3OEJDQU5xd1FUUnRjT2tFdFVGOHRKeFVSbkhSUUUwYUlE?=
 =?utf-8?B?TE11MUpRaWV6LzBRVG1Ta1A2YmRYOXIwWlhJZ0RYcTQ2SWNuWUYwdm1pVWxV?=
 =?utf-8?B?S0hhWmt0SVplVDRZZE1MaUpmbUc0eGNwU3B6Y21jRWIwSWQ2cFlZeU5MbVRN?=
 =?utf-8?B?TkFlNTJSWDZOTVhQUkg1alc2ZFlvc2J1Wm0wL3ZWR1NodGx3SllBeFdSRFJR?=
 =?utf-8?B?S2RZcDFHOTYwNXVkOGt1YmsyNlVHbFc0MFZuR0RSN3MwZjVVUG5zTE5ycnRn?=
 =?utf-8?B?cElQM3JwY2dYQU9JbjlxMDJSc2xWNUtHbkk5NTZ4SzR3Q05Jd1BFckVYeGl4?=
 =?utf-8?B?dXhVV2F1b1ZlT3NsZWJHdXpGRWE4QU9hUWM2SmxlWGRxYU1zaFpubWl6Skxr?=
 =?utf-8?B?NGNzTVBmb082aEVFeFRsaHVJT0RTc21hQVcwQnpoQno3VVlxQU95OEZ2OWNV?=
 =?utf-8?B?c0VuMWZITzhVc2hQUDJHMWswYUZYQTBKRnpBejQ4QmNTcXhic1Ivdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c578748-c24c-42c4-3610-08defca08bc7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:46:00.5528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQhpSikgLWA1r4PPmSgpCT7h+y6xHPTtvm8j/7gCzYb5sYsMQiR6qHjo2dg72CrOPVJXO703aAynY4MB7ZHf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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


On 8/14/26 19:29, Alex Deucher wrote:
> If we end up emitting a VM fence keep pipeline sync
> associated with that fence.  If not, emit them as
> part of the IB fence.
>
> v2: fix need_pipe_sync handling
>
> Cc: David Rosca <david.rosca@amd.com>
> Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>   3 files changed, 11 insertions(+), 5 deletions(-)
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
> index 71050a86bcc3a..b7d0461184d62 100644
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
> @@ -827,7 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (gds_switch_needed && emit_fence)
>   		*emit_gds_needed = false;
>   
> -	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> +	if (!vm_flush_needed && !gds_switch_needed && !(*need_pipe_sync) &&

The only time need_pipe_sync in this check makes a difference is when 
only pasid_mapping_needed (which is missing from this condition, is that 
intended?) is true and the rest *_needed are false. Then emit_fence is 
true and pipeline_sync is emitted in this function which looks fine.

If pasid_mapping_needed and all other *_needed are false, then 
emit_fence is false and the rest of the function effectively does 
nothing. emit_pipeline_sync will be called from amdgpu_ib_schedule. 
While this works, I think it would be better to return early here?

David

>   	    !cleaner_shader_needed && !spm_update_needed)
>   		return;
>   
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
