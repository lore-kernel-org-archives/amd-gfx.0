Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B34CCF2E5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 14:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A42310ED95;
	Mon, 19 Oct 2026 14:28:03 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B7810ED95
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU0M16UKIQWkxnKaKxg3jgrJieMk8dgHPF2KS4J65ltblJWzDRRb6hisZ8OLcpgq9Tms2B3+sdjaLLcbnPjGY7wbq9GBLohc7sd8HA4Y2oxbqMWowTf1lcMWYZSmf20v/yywC9tmWmNPHiNlKmNQyZfIN2ON5c2dnc7mJk9kFHbwGz8VPnQKoP3tPRA8jJAhUYCT+G8sI7FDQ05IVdfW4Uwb+s0IaS4RgylJHLOO5wGRLphk8uCzAdNpuZrTmM7pQY27q/jq5Q4+ium3GOUOemUhv6ZL6iW+G6LOAo9gMY/3tdj6rBOArK2vmueGgjmBxlQ+nVJGlDNMyFicB75omQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf4MAkmN7/II1YyvxfAFR6TY04j1I6Nm6AMX+j9QqNM=;
 b=VaP0y22ZXlCxKnSnllCuRpWYjcYxPWW8YT1FkcMwkGGNFP07v97DRc56fyuAaO/BwW0UPpn3g3b8hYmJuBsByZUetsG3cw4qUM57oX71NrkF9e+xFeW/SRjmQa07Fnq5LSRuHa+8wrhymqoHK+wlWphSflFHJXQ0JkH/wDSPGA6f4DR9toqlyKBriiyhVvL233wneL3jsHUQotsrDWSLb8KJa/5oNSRyBdxCZGSrL5jzd+FgHvyIIX9FJHkdhWNhMXcNyAf1aSazKnOBjusavZmKC33JjHqr8LCp8334917DBR2grssDwg3AjgRzsa9/IX160GSKUwaRMlSH7KP/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf4MAkmN7/II1YyvxfAFR6TY04j1I6Nm6AMX+j9QqNM=;
 b=BxHDcR8eNaJjLPn7CUkNhoIm7pScfGaAAruCWCuK/tpv4i7d/3akusVBjIsAZBcIMoWtNd4fnaAS04V7r8mxIm3bMWCt0XdNeGVVhVMhePA2iEB2z0VTUjINhCZJf7cR5XwR1oI4lbcdc8LnlQh8gN6PtDN7I1j226QxIegp3No=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:27:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:27:42 +0000
Message-ID: <d5890df6-0f94-4388-9673-af94b825a1c7@amd.com>
Date: Mon, 19 Oct 2026 16:27:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: drop the gang leader reference when
 freeing gang jobs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261019014938.1487609-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019014938.1487609-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0406.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: a4010779-f5ef-40b2-aa30-08df2ded22dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: QIbA3M9KMNkPpxMaju2VTyTbWh8gQOLbB/KBQDIuGtKcR5mVzGTBsvnLojNJn6LtXPfcacH2miBbiwtJMP38Oyf6q2hNhOYX/D0wJCbnmABKl7Mmpu9FXI/tybP6YiX3XBnBHFuxhzkfDa/VY8ZMgVoiq1LomiNNAAys90e+UyISoj4j29go6748shZqDDCOUPkkXJ+9IWWI0EmfYZWq1Wzd3fDfM8iJy/1pl3ROpKMvj5rHHI49Ka45xPfRYD0FuJFoRz/Tpdg4wcGVzqs65RCfh54PXYqm9fRzJlms3xCsR1Pfb8eLWJU0G0zer7TaRY5xoR5kFbBdjpr7vQVZM5IlO1AJtB/RMmblYuXAaC1b2xcFyafUtfz5sKTqbLc8eSuWjU67JllXCIlJALjGSh/to4BBlr7wfCzXR6/p6ShyGWsHHTRFaCrKnUdp1uhGGLAyfqFcjWLfBXP6AcITlrxK2yOUowug3h6ww23uSmWlJWS6FnWZJGDvqBQ/uZF0xS5hnpF/jeRvaFSAdOZOdh+p/PZMou1dVpPj64kyebIWyQt2IhAcfomoc4/TEu1Eiv55M/0IQmPUuAGWMe7+kPuIOl2biZk68qnpclsPlQE4N9EOL6eK0F+ldf5ChPCdmJsgnVLUivHYUh9lV5if+w0uTPqXImjksqcmIuwGbVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dVM0VlZVNhTGY5WlBvSE0zcDFDalA2ZTJXV2pFYVlHajhGZC9MR21scVo5?=
 =?utf-8?B?cU9kLzkvb1h4RkZINkJ4aUdVYkFJZ0FKVHc2UFRjdDYxRmVZQVY2VzZ2d0RR?=
 =?utf-8?B?bGp6NDJDUmtERHAzZ2FuWG9EVmgwaHJqTzlTc1BUemtLcUR2SW5ST3k4ZlJx?=
 =?utf-8?B?VERKR2x4cXZCemExZDVwMmxqOFYwWFFCNktQUldYNFlrVTh2MVcyTXAvRm1J?=
 =?utf-8?B?RkdiU2lyUXFoZDk5dWlPK1N6UWJFbFVmdzAzZEZOVmVSYXlOYm1MalNIN0Ri?=
 =?utf-8?B?TUxkencvc2ZhR1lTYm9vSVlkWmc1S0drc3RVMUZxeGlDOFFCaS85bFl3OG1x?=
 =?utf-8?B?UVNYNVhWaldEbGp4enpta2pFdVNNWXNCN3Iwd1JuTThmY3NJeGlxcnVhVkk2?=
 =?utf-8?B?c01uQUJCYXBpUlUyaHdJZ2tPUWNidHdlT0tZWEE2SU91WEQrR1FKVnlrbTRr?=
 =?utf-8?B?b3IzdW1hTkdUUTZVM0JGV2pSOE5LZ1hCazRXOXVjY3dPcWxuTTFHdjllaWpa?=
 =?utf-8?B?bjhVSjVtQnFPL3plVUoweEhBQzltdmxGdk5ubnZITkRQMWlKNXoyNUhTYW1N?=
 =?utf-8?B?YVp0RkwwRmx6c0xwTWlYMWhrcE1LT1QvOVVNWHBnV2NwSHQvcTJuRHN3VlRX?=
 =?utf-8?B?cUVTYk9Gc2ZPcFF4T01HWTRBZW4zQTA2OWF3MDBzME1kS0xRSS9Wdy8vczhn?=
 =?utf-8?B?UzUvMUMzSXI0UWRlaGdLTURXTjN5aU4ramVMUSt2WWNodTBGTG5RWFZSbkt0?=
 =?utf-8?B?Unk4VTRLbEt6cVh5WWtkeUJZOG9IcWF4d0RlNWF5VTBrSmJxNTlHNUFRdDVB?=
 =?utf-8?B?Rkl4blVaa0xkYVBOZ1lvZXhwbVo5Q0w4em4rRHFLRnBCYk9sV1FJcXhNLytB?=
 =?utf-8?B?WU5nM1UrYTZualROcTAyaG5nVnNMazZUb2FRR2djU1JBUVU4eEMyNjQ5aERa?=
 =?utf-8?B?QmM5YmtONGJINmZYbERsMDFHTVlHM01UN3FsLzg3d2pjUjhpbk9GcWxrNld2?=
 =?utf-8?B?TW5HTllkZ2lOdERGYVBnZkd0YjZyVm1jVTVNcVA5SGhBYW8vTVdSMFlxY2xL?=
 =?utf-8?B?ajMvTGtOdDRzeXR2SnpPUDBuM2pPMTJBUUt4Z1kyZnVyNFdxUUszRmx3M0s1?=
 =?utf-8?B?dzlWY1ZvRVRWTkcybFRZS0o4eG1Bellsbm16cll2TEtiTnVoSFh4RDRSR1l5?=
 =?utf-8?B?WlpncXBrNDJkYUMweXR3UVEyV0F5Vmg0T2tVOU9odWl4U1k0TWJtMDBVd3Bw?=
 =?utf-8?B?eXRXUlR2cUFHVHZMZ0xUYUJqMUthazRwTElJY3NCTHFhY2xiV0V0ZlNqUllM?=
 =?utf-8?B?c1RXVVdQSWhvaHl1MlI2cys3MFdTR01yc1NWUEJyUnhJTDRBbDVmLzFUUU1J?=
 =?utf-8?B?Q3Q3bGczZm1VWEJhTnFlWUgvcEFYbExrTlQrN21uTVhWVnY0S0xRZk5RSWxp?=
 =?utf-8?B?czdzRGVZcTNQY1N2OHMvMVNBK01UT3ZDMnBSRUJDekNDcTMyc3VoNndrS2VO?=
 =?utf-8?B?Y0s4WHlialhzaVVrMklmSGM3elMxL3JWeVpYZk54TlRGbkFwVndzRzJrbHBj?=
 =?utf-8?B?dmM4VE1BUk0xT3RyNWUzN1RVbjExSDRNSWhhaHJVM0pjZDRJZDM5OC9OOTZx?=
 =?utf-8?B?Z1YvVTJPaTBNSitJRjl2N2RHbS9JU01wZ2k1ZXBpcmxBU3hHNkdtakRjbHJH?=
 =?utf-8?B?dnZ0c1dBSXZ5aXFrakttSkFod00vTmVRek1XdnJqWHFpa2llL1JDUnU3R2x3?=
 =?utf-8?B?cHluc2FiNk1sNnRJclRjNEh3OEhhcVFZV3VnU0ZlLzVlVVQzWEVqT1lFYUhh?=
 =?utf-8?B?YkhLRldPQnkreUpHRFdwRjZ0WVZNVVRGYmx5WmFKeTEwUnZ4a2ZEZUhPWHJv?=
 =?utf-8?B?bms3WE5ZSzMvS3k2NWtER09xcGhOVzREakFSaUJnOGR2RkFyTm1haVI3WnpL?=
 =?utf-8?B?OGozOGFKZjV4T2pnRDVCcTVTSWlna0xET3ljVnE4emc4N2YxZWxWVVlHcyti?=
 =?utf-8?B?a2YvK0xISFExYUZBd0tFVFR4dDBpaEVGa2E3Z0pNWDFYOHJlT2xuQUxEdXRh?=
 =?utf-8?B?bmN5WUtsY1dBb1preHFpMGllMzZHcnpkTHhta0tncHRaWnA4Z2t6dGp5aVdt?=
 =?utf-8?B?M0pMVkg2WDFxSW9FWldHT3poZzczUnFKYjRZc2szckVRUDVXaCtJbkZIVTll?=
 =?utf-8?B?UmdhaVNlZmsydjhRZkVtTU1EMHh3WnNzZndFbmVYdEZFNXlMaXVXSng3aWlX?=
 =?utf-8?B?M3U5QzduNDhEQ0tyM1BMMk04UzBhOHkyZjhOd0gySVVtNlFCckVkWTVDN1lH?=
 =?utf-8?Q?lFO6ZkqO9kJ9h3RFP1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4010779-f5ef-40b2-aa30-08df2ded22dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:27:42.6716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSRD6gs/mQN9PotcuNJYBRYquBaQJlkLM3JEUx8jlrmVbeASev4Ii4u3J5uoCqhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

On 10/19/26 03:48, Jesse Zhang wrote:
> Every job of a gang except the leader holds a reference to the
> scheduled fence of the leader in job->gang_submit. Only
> amdgpu_job_free(), used for jobs which never ran, drops it, so for every
> gang submission which completes the scheduler fence of the leader, and
> with it its hardware fence, is leaked. amdgpu_job_free() in turn checks
> for the leader only after drm_sched_job_cleanup() cleared the scheduler
> fence, so a leader freed there drops a reference it never took.
> 
> On navi31, 100 submissions of a GFX + COMPUTE gang grow the slab cache
> drm_sched_fence is merged into by 60 to 180 objects each time, while
> 100 GFX only submissions don't.
> 
> Use amdgpu_job_free() for the jobs the scheduler frees too, and check
> for the gang leader there before drm_sched_job_cleanup() clears the
> scheduler fence. As the scheduler clears the entity of the jobs it
> picked up, check for the scheduler fence instead to tell whether the job
> needs cleaning up.
> 
> The IBs of jobs pushed to the scheduler are freed before that, so the
> IBs left to amdgpu_job_free() only ever ran when the job was submitted
> directly. Free them with the hardware fence or right away, never with
> the scheduler fence, which nobody signals for jobs aborted after
> drm_sched_job_arm(), like a CS returning -EAGAIN.
> 
> v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian)
> 
> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
> Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 47 ++++++++++++++-----------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0056a93c400a..c5c8cb7d6669 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -313,22 +313,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  
>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
> -	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -
> -	drm_sched_job_cleanup(s_job);
> -
> -	amdgpu_sync_free(&job->explicit_sync);
> -
> -	if (dma_fence_was_initialized(&job->hw_fence->base))
> -		dma_fence_put(&job->hw_fence->base);
> -	else
> -		kfree(job->hw_fence);
> -	if (dma_fence_was_initialized(&job->hw_vm_fence->base))
> -		dma_fence_put(&job->hw_vm_fence->base);
> -	else
> -		kfree(job->hw_vm_fence);
> -
> -	kfree(job);
> +	amdgpu_job_free(to_amdgpu_job(s_job));
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -349,14 +334,36 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>  
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
> -	if (job->base.entity)
> -		drm_sched_job_cleanup(&job->base);
> +	struct dma_fence *f = NULL;
> +	unsigned int i;
>  
> -	amdgpu_job_free_resources(job);
> -	amdgpu_sync_free(&job->explicit_sync);
> +	/*
> +	 * The IBs of jobs pushed to the scheduler were already freed with the
> +	 * scheduler fence before that. The remaining ones only got to the
> +	 * hardware when submitted directly. Don't use the scheduler fence
> +	 * here, it never signals for jobs aborted after drm_sched_job_arm().
> +	 */

Drop that comment, it is more misleading than anything else.

> +	if (dma_fence_was_initialized(&job->hw_fence->base))
> +		f = &job->hw_fence->base;
> +	for (i = 0; i < job->num_ibs; ++i)
> +		amdgpu_ib_free(&job->ibs[i], f);
> +
> +	/*
> +	 * The gang leader doesn't hold a reference to itself. Check before
> +	 * drm_sched_job_cleanup() clears the scheduler fence.
> +	 */

Same here. That should be documented on job->gang_submit if necessary.

>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> +	/*
> +	 * Not job->base.entity, the scheduler clears that for the jobs it
> +	 * picked up.
> +	 */

Hui? What do you mean here?

Regards,
Christian.

> +	if (job->base.s_fence)
> +		drm_sched_job_cleanup(&job->base);
> +
> +	amdgpu_sync_free(&job->explicit_sync);
> +
>  	if (dma_fence_was_initialized(&job->hw_fence->base))
>  		dma_fence_put(&job->hw_fence->base);
>  	else

