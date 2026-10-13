Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F83CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCE010F51D;
	Tue, 13 Oct 2026 07:31:56 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47AD10F51D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf47H5XFd8xJrisRHitumIFYBoASahusY9D2XPxOh/w2QcGC/o6/e2HO3JnZzLHM8bXaq/t5hwYw2v9qAhxVGxhaTbq9A59eQDMNsfeICE/Ttbwsd15mcDmLOxVv2Y9hhrm8r/I4kp/enD3J0mxXoAf/scTgvd4tT9eMOdPHFx3HrSR6jlnEsOkRPzDeBrolU5w6kn8R4KEHpi8KkyDzkGPhIJ8uzOQqWUlKGvRQ/FceIhJXzKOB/E2S+REBYTG1mVUp985LZv9F4BN2dK2Vq/FjGNEPc9p4iuRezgDaHawQATA1R/imKhiRno5Gaz79q57cBDsz/d/1byV5lS3g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tt+hk11K1DquUBcn0MaM4B/0lfVTWUaQBtLIJGSxrU=;
 b=uvLZ5hNw8FOCfSeJ+kgYI58eymSxbc4xAMpKgmyjQQPXBV9ZguDhj29JQtoPkiO5ULRCcor9BxXhjSPIswyCk+9fup+emVEj3CdC4GtBjBkDM265Z+9wlY4QFvAFMJQjD4nwT8YuYBy4IIxWXN52U3ZR0hx1+Hd4Jlj0+AUzDCSRDj7ySyjRM6U3bU7MC78ghTbJPauqUixRCsCR10w7cyvbuxwcwqOH2th81ipISDolfZAf4jL6spAEbRPAdfGUFHe+CdrR0nVXL0bcNk4vEBbsQWLxt9+AWrZ3hOWCs6jC0vILCyVLLxwxQCECvkjAwagBGnURK5alcDajHCDk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tt+hk11K1DquUBcn0MaM4B/0lfVTWUaQBtLIJGSxrU=;
 b=DlzuVwFTOwMV5cz1LBzqZPyqwSHPV5zqZRwW2WKpQH2GteBUQFtEMKslDji2rihJUXu5erZR/Huo+Thzb3dpQTxQzej0g4EhjbVODZzDrNmYosCu5ukc2Z9B5VwyR9NnVtAeKbDqr9TaE7DFjqCRXJ3AJu/yb//WagFAVLXs+Ws=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:31:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 07:31:43 +0000
Message-ID: <5bb454e9-65ae-4c7b-89ec-468d0b202538@amd.com>
Date: Tue, 13 Oct 2026 09:31:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] drm/amdgpu: remove the now-redundant runtime SPM
 VMID update
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-11-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-11-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0229be-8d14-4998-3855-08df28fc0683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XNMX3/kaTsN6MAtQCSrl6+J/elcrf1H+44V3jkfhQG5EoC7MhruEG1kIflL/CP4lJNqPw/Qrax7sREW4p+BrCzsuDXReb+BtKkEsFYuQdUn6ga4pw5UigYD27faN8V/WQ7SBUP7SfGxJ1Fz8RMhdt5+R+Kkl626jA454kiWMg9xuuV7ZVrRVcDDchEZnKub1i6P5c5Mv5EKTYVR3Fy3h7qRxKm2I7aAw6+3sEDq/Demc5AKaMUNuPABdD6KLMjpXfEhn24ErOH49BgUYA+e+h5x2/RjJ7tmR5R4slQ02tUFnPdnSGEJN5lA+I1XiT89VjzZbLmQOy47VsRxpXZMH7hHD+iEIHSee1c/Rk2kPYhKY7aFcax+tLALe8TUxL2vYkyaJMnbg+5Oxp9IxudHaryTfxiARnSGiT8UoN3F1v8JMmWSZ+E3FLMt+AM95exqjtixc1m0tdweqWg74b777K9hyT8pGsARMkPBippr2PVSINlebW1OmDAzF1nA/ZnmDGYuf3f7HG3GvozekeY+itcnqzw7o6BQMJXjTfLE9yekQed5vARRYCd3gNF+EKa1beNNlcLzejxQU9icwkNtecQxjDJDLrjtrrh66eA9UUIxlD69AU+/vqLOq5fxkkhKD57UpZgDAKVqjbXRXv7Q98tQWjoVWaQEr93jirwBDDAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1YwZkFZdnp1R2U3WnZMdzZ3OEVaS0hHMmZrc2tCUkE4VkRYeVFiWnFGV2Jl?=
 =?utf-8?B?TVUzdVlMSkFzQ2tJTUxOa1ZGdldpejlNK0w3bXZhNWpUSm5tZFJvQUZRaWlT?=
 =?utf-8?B?aWszS0V3c3dZeHNOeW9rekVSMUZsVGxYR3NCbUs3ZEk3SGVLYnZudlZkclp2?=
 =?utf-8?B?RE12Wm9ib0ZPN0dUYlRvRitpUFJpdGZKYXBIbjlreVM3eWN2c1c0dTBRL1B1?=
 =?utf-8?B?SkZ4ck15K1hlR3ZRdm05RmMrR0hKVjhyc1k2VGVZT2xxQy9VTnRneC9BdGtY?=
 =?utf-8?B?SVZGN3NFWXB1OUpmTE5vYkRkVGZDZzcraUxmNVVHUmdkTmU4a2ZseE1tQUFV?=
 =?utf-8?B?Ym1zd0pJcWZQbyt1VHNwUDRYSHlKc1BPcElFWmRCR0hPTW5XNVFPRWN6MzM5?=
 =?utf-8?B?anJ1MjZIb2N3ZXEvdUpvcVNBRHB6VkxuL3Bzb1p4TnNUVHRaYldqRmI0MHdV?=
 =?utf-8?B?L1ROOE15UkI4NWc5Ymg0aitxaDhGRHFCTG1Kdm9TbGg5Q0RMWlVjZWgyOFR4?=
 =?utf-8?B?UE1UdDc4KzRXYURvTFhiai9kVGZOcGw1YlYrYk90OFRSTkxNbkhvUlBGcVNv?=
 =?utf-8?B?dm15aEpQN0hJTUhTZGdMR1BUanVTK3pqMUZRVHNsTTdjWWdTYzFCTjBSVm5I?=
 =?utf-8?B?eThOanhpekFQcVkrR0VTTnlVTVdTWmZGKzFKWHRKYTN6b0tCZmsvd2JCSGMw?=
 =?utf-8?B?UWFlclpzTzV0VjBFcU1sQy93YWFzb0hUUjk1TVBMMUM4cTZCYmlRQ1dYbmFy?=
 =?utf-8?B?a2JXbENFWnNrSWloTFJVTGpIaThhdkxEbHM5MDhEVSs2QndlWE9MN0prR0o0?=
 =?utf-8?B?V2M4NGswbVljS0JHeW5HY2JSRWx5YlY3MiszVDVmV0hzN2Z0eWZxcDkzd1ZR?=
 =?utf-8?B?Y2xSckVPd2czVEhkazZETk9Va0NNd0NLRFhpcVpJT1dJS0RacVJXWmxzeDNn?=
 =?utf-8?B?NXc3dXVWN3pLaFpRelVHS2EwK0JiU0ZnMEpVTFhBaU9hT0dQeVk3ZEdRSUhF?=
 =?utf-8?B?Q29xQ20zWTJWMDVYUlZTb1lwUDFEYXhkcE5BREhLRXJlMmNkemVuQVVDeXh1?=
 =?utf-8?B?YklRVUJiKzJ4UktxZDQ5eTJwUlBpZnd5S1R3bDQ4WlJBbUdyb2UvLyt6Qy9v?=
 =?utf-8?B?N1oydzkvTWdnc2U2dHRzc2h2SExiK0FERXV6djI4bmdBTkpRQmFDcXJZSXRh?=
 =?utf-8?B?bTl5SGpSWWhmYmpzMEw2eUdHZXpERjN4Q2Q5VTFoZ1I4aXFNRlluSmtLN0VV?=
 =?utf-8?B?L1ZSN0xoMXkzcGxPN0R0aXBCNEVSelg0QkIvUVhBQXB0andObHZEc2hPY0hs?=
 =?utf-8?B?NnBIUmtTRDF3bXFyZ280dTFjS3J2TGZsZHBVcDYvV21uYmdiTVVqNWV6c202?=
 =?utf-8?B?aGxjc0ViYmxnVlZFcUhpYVpYVy9Fa2ZNOHd6N2hoeEprM204bWQzdHRqd1pE?=
 =?utf-8?B?S1hEU0x6U2FrNlZLN1U1QWp1WnNwVXVwMXRyRHd2T3drcU82U0dFR0c1Z1N3?=
 =?utf-8?B?ZHExaHJNVkk0RThZU0FlYmthQTBvWEdrZm80VExOZVJLYStmZzlqbnE2eVAr?=
 =?utf-8?B?MzNzYnpYMWZLSzhjcDBuamd2UzJoRkZKVUdIODIyTmxwQmkxNi9kN2lUNFlF?=
 =?utf-8?B?VnRCcThBRnY3YjlaYnhwNFB1MFRIakJxbmJjaWIzdE1pT2liSDZsRHBDMHd6?=
 =?utf-8?B?UmlWeGJUOUtaSDZwS3NZbDRDTC9uZ1VxcXovNnFhT1FIMEhSYlBSYmRQMFVo?=
 =?utf-8?B?WDBGL3d4ZXpaV0VaaGFCR0lFV3JQWjNtbnlzVk02U1g3cEE2RmNrUXUwZjUw?=
 =?utf-8?B?Z0hZQUc0dWloT0tLbmVQcE5tZnJ6UXNHZFBCQWpqaHRFcG9LY3NuTW5oMG5x?=
 =?utf-8?B?Vm1CMSsrZkh4Q2VneHlBcVQ3WjJra3UyN3haV2dMeGtLVnVTSlhXaTdNaFBU?=
 =?utf-8?B?YVh1aVM4QktReVZpdnYzKzdYaERWMzNoWXRaZmg0RHJCM1BxSWRvc2phSDJk?=
 =?utf-8?B?alowMmZHOEJhWDhNQTUrT1pMK2xtUkdYUHFIai94bU5ZNnkyRXlJd1JVbWlF?=
 =?utf-8?B?eTFzTFN1S2x2TndjMFFkVEV4NThsRi9UTTZRaStnOFZpc2RBZm1lMUVXSHhW?=
 =?utf-8?B?MzErRWNLYS9sa0d4d2F1VjlYTjNNYUg1aXBJeTI2aXhoRFNXeTN3RHRWbGd4?=
 =?utf-8?B?Sit5M3EvNlN4WDBPRGJyaHo1d2sxS1J4TU9HbjZEVkVYUi9BOWFZUmgwOGVV?=
 =?utf-8?B?eStmTzRaZnpITVZERGVpaC9id2F1azRVb0cxbGlmbElmZ3UrYlU0TWpvQS84?=
 =?utf-8?Q?JxkHEQ15REToDwqq7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0229be-8d14-4998-3855-08df28fc0683
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:31:42.3820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JJYpiD2tKVM5W4s6aHOpGrmzL1H9FGfwjZoQRqIUb6DoBtY2pRMPLJr9lGQPUBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
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

On 10/12/26 11:24, Sunil Khatri wrote:
> The SPM reserved VMID is fixed now, so retargeting RLC_SPM_VMID to
> job->vmid on every submission is dead code. Remove
> job->spm_update_needed and the update_spm_vmid() calls in
> amdgpu_vm_flush() and amdgpu_ib_schedule().
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

We should also have another patch which removes the ring parameter from adev->gfx.rlc.funcs->update_spm_vmid().

What's left is comming up with an SPM test case and eventually getting it to work with user queues (shouldn't be to hard).

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  7 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 +--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
>  5 files changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 0f8b097001e3c..f98a7c6797b3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -126,7 +126,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	struct amdgpu_fence *af;
>  	struct amdgpu_fence *vm_af;
>  	bool need_ctx_switch;
> -	bool emit_spm_needed = false;
>  	bool emit_gds_needed = false;
>  	uint64_t fence_ctx;
>  	uint32_t status = 0, alloc_size;
> @@ -195,8 +194,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  
>  	/* VM sequence */
>  	vm_af->ib_wptr = ring->wptr;
> -	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
> -			&emit_gds_needed);
> +	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
>  	vm_af->ib_dw_size =
>  		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
>  
> @@ -211,9 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (need_pipe_sync)
>  		amdgpu_ring_emit_pipeline_sync(ring);
>  
> -	if (emit_spm_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> -
>  	if (emit_gds_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  					    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 3617de2368d5a..85ffa2d28c3fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -372,7 +372,6 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  		return r;
>  
>  	job->vm_needs_flush = needs_flush;
> -	job->spm_update_needed = true;
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index ae569b4497f6a..f6577f82e6b93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -75,7 +75,6 @@ struct amdgpu_job {
>  	uint32_t                preemption_status;
>  	bool                    vm_needs_flush;
>  	bool			gds_switch_needed;
> -	bool			spm_update_needed;
>  	uint64_t		vm_pd_addr;
>  	unsigned		vmid;
>  	unsigned		pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7d3659ef11e53..de992405ed718 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -766,14 +766,12 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>   * @ring: ring to use for flush
>   * @job:  related job
>   * @need_pipe_sync: is pipe sync needed
> - * @emit_spm_needed: does the caller need to emit spm
>   * @emit_gds_needed: does the caller need to emit gds
>   *
>   * Emit a VM flush when it is necessary.
>   */
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_spm_needed,
> -		     bool *emit_gds_needed)
> +		     bool *need_pipe_sync, bool *emit_gds_needed)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_isolation *isolation =
> @@ -782,8 +780,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>  	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
> -		job->spm_update_needed;
>  	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>  		job->gds_switch_needed;
>  	bool vm_flush_needed = job->vm_needs_flush;
> @@ -797,7 +793,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		gds_switch_needed = true;
>  		vm_flush_needed = true;
>  		pasid_mapping_needed = true;
> -		spm_update_needed = true;
>  	}
>  
>  	mutex_lock(&id_mgr->lock);
> @@ -807,7 +802,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	mutex_unlock(&id_mgr->lock);
>  
>  	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> -	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>  	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>  			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>  	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
> @@ -821,10 +815,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	emit_fence = vm_flush_needed || pasid_mapping_needed ||
>  		cleaner_shader_needed;
>  
> -	*emit_spm_needed = spm_update_needed;
> -	if (spm_update_needed && emit_fence)
> -		*emit_spm_needed = false;
> -
>  	*emit_gds_needed = gds_switch_needed;
>  	if (gds_switch_needed && emit_fence)
>  		*emit_gds_needed = false;
> @@ -864,9 +854,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	if (pasid_mapping_needed)
>  		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>  
> -	if (spm_update_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
> -
>  	if (gds_switch_needed)
>  		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>  						    job->gds_size, job->gws_base,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddcdc7256ef07..b8aa45db1d844 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -448,8 +448,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		       int (*callback)(void *p, struct amdgpu_bo *bo),
>  		       void *param);
>  void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -		     bool *need_pipe_sync, bool *emit_spm_needed,
> -		     bool *emit_gds_needed);
> +		     bool *need_pipe_sync, bool *emit_gds_needed);
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  			  struct amdgpu_vm *vm, bool immediate);
>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,

