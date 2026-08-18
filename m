Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A36C5DF67
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 06:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1EF10E1CC;
	Tue, 18 Aug 2026 06:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wDMX9RoK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013033.outbound.protection.outlook.com
 [40.93.196.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA8710E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 06:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUYfAYNOyhfOWXZRq0yaSIWs1SXBpNRV/uLcvJp+/cPljki51a08nJmrfKmCmcDnjxbyfhgckMQql9WJkpLnfT9xppkj1mSakToG+yfH3hTiDdr9zv4mIcv4RXshdcU2ie8Zv1aPqnWJ63mu0ZI1QTzl9/u/B8zPOWw8A7Yij1LTuRIIXiFN8CsvU0xlvB6Yo/BPmiN/q6vPnFNGhlR12F80jWlZcniHxYomKzvcbPABWo+Vkgxp/lPEjhydYfeggz9tHD8Capz12S+qKAkkqbHVPPgro0i2lKpZtoaHNcFDX1oanlmu9SpQVB6Ud2AcBp40d2diTqK0FX+DS901gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xxsdxURZ7ChlFSG/jigTJBxraFbeSspbK7itv93B3g=;
 b=oBaM3hVH0qWZXanhBDUtoFa07wpBBaS59+P1JxzmqOTZFwEf+tjZKF7YR/R9Qf7PM0P4kZnsoGJeKekc1XDCQ4A5x4x/rDSOsgS/Tk1g7FxG2BV+xHWYY92pVVwXiF8Qv1rOzFbpAHCdSMHjq/m3U95DxbymJKXS/zwIS5zAHyj6AY5nLF8enjtp7hTkKvbNyyqLo0bxltQe9WtKsQXPtSI8uegpyhI3+gnd1f7dgtP/R5Odd+5V10t3IA51B87Sd5K/I2UK7WlUyZYabcXAgdNEkQyPb8yq6Sa0Q3YwBlFihPFxA7klXKPlFDDIBVrwZrYkj40/VvyyQPnT9Z+e6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xxsdxURZ7ChlFSG/jigTJBxraFbeSspbK7itv93B3g=;
 b=wDMX9RoKIdCBU5aKg4KVTLx7bVRmFKm0q6nURBpB8OZ3vfcimBWmyoAuN+LE0LYx3j16RfpOniZp42Yg3XvkixJukQbZEEKyn6IUoIPf5HSHvPSS0iUIQnKTJkyCjR2STrii4/3HGN2Vt8BxdLYUCr3JHjTjSjOuvsZsvWIUvdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:00:48 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0292.024; Tue, 18 Aug 2026
 06:00:48 +0000
Message-ID: <dd2588cf-e39a-4089-bf90-5c594fad624c@amd.com>
Date: Tue, 18 Aug 2026 08:00:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260818032436.1047825-1-alexander.deucher@amd.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20260818032436.1047825-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ec47a-e7c4-4f86-00ca-08defcee0cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qdkc9PUtUQ4QWP0nerVKOW4WseretqSJBJOm3KTRHz1Tmt9NKE0PVHlIekX1YoH2xiV7z5eRDdoLhZJoXTS1hkTSugDAg52C9tUPhwXbokbxwv2jm3eBPpY6posJ/D9M/IQU8hZyY4OLE8U9d8wA3+YKlUGfKtPmximrH2PjfjtwymsEAPJ62raQOI8jj/K0Vk1N3J+vF0m5dHVHu3Ap0PRpIhxVwjfoDezcdQfxOeNFbn/xsLZ2UqacatB8fvCQqFs/d2F3YCDQrm2Dxm/FnP5zCsGqNw0Xrq9ADB82H9Ss7YtdrdlJPnocvKzYR584TGRMq9YWZG0aaMJGE2TEPQS24ahSKovyUTH6MgoG1ioOZa+Oku9wX02XE1EgBVU4Q4V5pfoK9AxMsn1GGgmkvKRqecs1/8wDpnY4BPOdCloZULfMON2ThAP9AK0uUSVmbmbqejFqwR7UF7lBnfQUBaiW0G/R7/Pz67M5zz/qk6oERDZc2vIL1rM3f0KQC5GsfBJeLdIbd4St/FULqi9EJml2nuqbqM3QdPj1WS9cHX+jTdXTLQb8tndMQDt3J6+7fb2SjkwQjNpaxXFTA0UHuzyRa9AoRofKhbDG+0ZVbg16H9kFlOnAv7SfYuU05QjEelf5Hoh5afcrybKcUU9Bw1NA89Xwv1gZd5h3dn6Ood4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFUSDBoTkt5VWdjL2E2T2Z0ZFhiQVR4UVpLWnRMQzFueWtwajdGZVgzRGlT?=
 =?utf-8?B?WFo1U1ZwN3lBaFhmZWhKZmtmSVNVSHM3Q2FhRHlMQmNJOEFIV1lHV3VDYS96?=
 =?utf-8?B?VzYxcEtmWmRXWHFxTjJybDEvWDdpejg2YnNZcm1ta205NUtnTURoWWloRmRr?=
 =?utf-8?B?SXRORjhCTTZ0TUdteTI0MVpmZFJIZC8xVmJoZWtqNHlXdzBLUmRYV1NuUlpU?=
 =?utf-8?B?OERYQk1RQXRwa0dqT0RvSGVNS2VKa0F3Nm9NNTlwUDBKZUxxMnQxUHRsRUht?=
 =?utf-8?B?b0U3blRzbXVERlk0am5acWJPVjJPNTFjaGlvQ1ZxNTRDSkF4REM5bTdSamtI?=
 =?utf-8?B?ekgrYzI5RDd3cHdwbnN1QnBLem9sQUJPb3VFR1p6MzQ5QUxLaVlkY3FaTkZW?=
 =?utf-8?B?TFV1bkhvQ20wTnVCY1dCV09ocHpmdmNBNmEvdVdsTXdSZ09uREs2NXIrMita?=
 =?utf-8?B?SjlFMEZYcWpLWU5VUTA0ajdJcno3RDgxRFB0TE53Y29xcGVUK21nQzZHVkJH?=
 =?utf-8?B?KzM3eStiOGs2bEI3OEtTdC8wUTVEZ1RCYmxDcGg0dDdPTktHd3hpOE83NjR0?=
 =?utf-8?B?Q0phUFBKclVDL0g4ZUNNSUd1aWMvV2N3c2JUTXBxMjMzSERyVlArbVNIMksz?=
 =?utf-8?B?ck1nKzVVSFhyZ2RGY290L1BwZktqU1R1UHBNcXYvcHkxL2FDUjVpKzFDazg1?=
 =?utf-8?B?MTZkUmFHRmYwYmNGUFlRenBYQjh2eTJkb3RYR3NrWVE3SFEyWTEwVFVHbG9k?=
 =?utf-8?B?Sjh3TnBHUjFzQU5tSXdSM2dMcm9IWktEL2piS3Z4TEJ5ZERrSXd1dXFIcGts?=
 =?utf-8?B?UCt0Q0pGSUJ5VVgwdU9rdGlGS2RSVm5MOW14cG04Rzg5WnZHWmlKYTdJdHIw?=
 =?utf-8?B?eHJJZkVqSG1sMmcyaHhwdlh5bDhGN3k3VEt6dE5hNjJFc0xtaHpuMTlMRWdv?=
 =?utf-8?B?RUlQZ2FDSFdkWTFyWmorR0JyaUt5WTE2WDlTa2pWUHhDYTZLMDJJbjV6Ukox?=
 =?utf-8?B?YVdzUHVQN0JlZHN3OUpuTUN5bzhITWZjamtneFg0ZlR2c0hRT2xNVXVocXp3?=
 =?utf-8?B?ajdjdEpWdXhhRTROcG9QazMwS3I5Q2ozVVhnejkzalAyUUh6Q3VpbFg0WENu?=
 =?utf-8?B?VmVDSzFOK1orTkdabDF1MEY5S0cxQ2xGYjdwM3IzRG0rWHY5ODFjYUQxYVYv?=
 =?utf-8?B?N3Bvc1hYd3E2a2pzUGNtWk1JQkE0eDd6K1o2b25qZEdscVcwWlRJSjltTGsr?=
 =?utf-8?B?RE5GN3hNVmRNeENzblRza2FLcnM2aGpvSUl5Wm1JK1hzUUYxb3pkRHBudW5q?=
 =?utf-8?B?UFl6RVFZcXErYlJmSmxCeXdVU2FkNktMdE1hUCtQSDBNbGwzZWhiWmExNXoy?=
 =?utf-8?B?eUE1M3Z1b3lZTmV1ZTQvVytmNjZRK1hwMDVEZnRYeUJSUmhKVnBiOXdQbGhE?=
 =?utf-8?B?K0lIQk1ucEZSZ3dycXdITmhWSk5wTitSMkVVQkFNNGhvMHJtcGNkSzRWSEdY?=
 =?utf-8?B?TmZ6bExXengzdTJjS2E5M0RnOXdxWkpYVWRvU3hVYUNCUmswM3Y3TVoyUGxn?=
 =?utf-8?B?S0FNZ1N2QlNpMGRtZ1dQN3RGQTNOb3Y4cjJKcmdzbmNGdUhYcUtJK2VxdUdW?=
 =?utf-8?B?N05lZ0JLdUIwUXhSelh0UUtlWXZiRUpWa1N4Yi8reUxuSmF5Q0FtalNiNEt4?=
 =?utf-8?B?UHU3NDgranJLVlJESHNWOWxMd1ExNWZ1bGp0MW5FSzlhdXRNTkY5UTRtcVpw?=
 =?utf-8?B?WVVPNkVBSEtqWGc1WVQ4VWhoWHpTNENtNjBQdUljTi9WYmwyMmRJMWZ6L0hY?=
 =?utf-8?B?bkZMYW5TNU5Db2ZqZkR5aTJKeXBCN0tJdmE5d0F5UzFOY3FveUphb1c0K09H?=
 =?utf-8?B?bzNCb0JmRnlpTEZjbzMwL3dGeW8xUVpvWlJMY0hGY09jWGh2UW5QcmtMdzRm?=
 =?utf-8?B?SlZ0Vm90VW9SRjNDS3d1KzdOcW5ibTJZaFFaZ0ZVVTVYRDJaZmkrVHA2K3Rp?=
 =?utf-8?B?TitOZGNBck03b0p1OXJYR0ZmWnV0SGRKYjltS2hqb3YxWm1xY0MyS2t0L1pS?=
 =?utf-8?B?WFN0WXRaK3c4L014TFB6RkFWSHgwY0hjNGRvTXZrVVhIWFU2dGp5Um5Dd0Jo?=
 =?utf-8?B?UFRoQ0F6Q2ZpT3VvSjNmUE1qS1RKb3RCWnkrT082WklERXdGdkk2cW1LMk5T?=
 =?utf-8?B?TitzWUIwc2kzanZMSXk5dmhGMnB5WThGUkF5OElaaGwyakZrQUFRK2p2cUhL?=
 =?utf-8?B?QkdnaUNjdHowUDU1bTQ5ak9zRW9IMmYzeUNBUjFJTkVLUTgwK1N4UUxET2Zx?=
 =?utf-8?B?SmFyY1NiVGpWQXU5NjhFMTJtMTFjOUtEbWlLd1I5UFM4MTQ1M0FIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ec47a-e7c4-4f86-00ca-08defcee0cf7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:00:48.4950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMghF4ZGszR5F+q3bLbJ/O+KyivB6jAg6LdobLoQgeN2kdRTL4f4ihOQ+xR+5hELItfCSg21G5Y2BbHIHxzDvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224
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


On 8/18/26 05:24, Alex Deucher wrote:
> If we end up emitting a VM fence keep pipeline sync
> associated with that fence.  If not, emit them as
> part of the IB fence.
>
> v2: fix need_pipe_sync handling
> v3: simplify the function
>
> Cc: David Rosca <david.rosca@amd.com>
> Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: David Rosca <david.rosca@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
>   3 files changed, 19 insertions(+), 16 deletions(-)
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
> index 71050a86bcc3a..f6c5de63eae61 100644
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
> @@ -827,8 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (gds_switch_needed && emit_fence)
>   		*emit_gds_needed = false;
>   
> -	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !cleaner_shader_needed && !spm_update_needed)
> +	if (!emit_fence)
>   		return;
>   
>   	amdgpu_ring_ib_begin(ring);
> @@ -847,8 +846,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		patch = amdgpu_ring_init_cond_exec(ring,
>   						   ring->cond_exe_gpu_addr);
>   
> -	if (need_pipe_sync)
> +	if (*need_pipe_sync) {
>   		amdgpu_ring_emit_pipeline_sync(ring);
> +		*need_pipe_sync = false;
> +	}
>   
>   	if (cleaner_shader_needed)
>   		ring->funcs->emit_cleaner_shader(ring);
> @@ -861,21 +862,19 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (pasid_mapping_needed)
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
> -	if (emit_fence) {
> -		if (spm_update_needed)
> -			adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> +	if (spm_update_needed)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>   
> -		if (gds_switch_needed)
> -			amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
> +	if (gds_switch_needed)
> +		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   						    job->gds_size, job->gws_base,
>   						    job->gws_size, job->oa_base,
>   						    job->oa_size);
>   
> -		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> -		fence = &job->hw_vm_fence->base;
> -		/* get a ref for the job */
> -		dma_fence_get(fence);
> -	}
> +	amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
> +	fence = &job->hw_vm_fence->base;
> +	/* get a ref for the job */
> +	dma_fence_get(fence);
>   
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
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
