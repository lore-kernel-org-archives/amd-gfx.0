Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E38606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LZv6tdz7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405D510E1C9;
	Wed, 21 Oct 2026 12:43:21 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156F310E1C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 12:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKqMaL7/seu1Ak1o7fPG20LBoTP1j+FIcr24ks/S9Jcla9++tKvyF5nMYtN7qY5aILswnOJHzwbgc5czO+8gEX9nEMEATPeqiPhPCAnxIymlDMIYjHr5HcjXuKxozLWOtqPH8pJt2zOnhHZmVQ+6hkCNK7IMboWOtRtaNhwtmEli08HgLraTWhaDaQ01oOU6H7WESZ6LaWKY1QGFLfPGC0FCOWqS20NYblzsDSdC4XpIYhaLf/czAd8bsWGKGZ8mDZC4s47P2T3Rd7efYQoFTW4LO0kLiElG2Y0UJMDgA0I79hdJTQVv+dXvBZHPDHp679QJDJIfEtMFtSmIlyqWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDWb5SnirRWe8XO1qAx1lal/qgbAXiXMJZXhbEOcOAg=;
 b=X8GiOERclkgcm2mOTxTc0aXwFXgsqbnN00v9xtENMt1EzxuIeTa38NTNZJNjuC1Wm3Dw4EFX48FOUKtdT1KYGCmVCR0knKUSya0yast8dkc17MG8f0dhV7V5SNi+q9cAWMBgwjXW9LykZNGimHeazVpoD8K8PIi/gYX3KQnrCJC1aG/+m6JZVQODOXMTakcppNix4C8Pys2IPujvD8fYfy18lCSi+pZidyx8XjA5yvqKhzr9Vnj1SdDyaKfue7wza6+iXgX7+4a75vyNZjwCmTTvYd4vyToOLWnJJzSE8eLedkf/izmLbesQxVbMJ3PCVURxKgVZ77wvXXPC8MUdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDWb5SnirRWe8XO1qAx1lal/qgbAXiXMJZXhbEOcOAg=;
 b=LZv6tdz7t6XtXnVwm38mQLMLv9qdw5FvuINZS4ZTLEA2rsW4cD3mx3aKxrEHTb7+A6CpkIK/eKRheTEw4Yo34yk6UqeSmvIN2YSp+QlnUzuyaFCdi7GFrqc8ur+l/TszVjUrzvuqmXbWwOuy3vc+sOlZsc9WMffCaIyerLEHztw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 12:43:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:43:12 +0000
Message-ID: <d9040072-aece-423d-9bdd-df077ee5292c@amd.com>
Date: Wed, 21 Oct 2026 14:43:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: drop the gang leader reference when
 freeing gang jobs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261021023209.3241785-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021023209.3241785-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e39ec3-3bc2-4900-3920-08df2f70de32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|261009221227099003|261009223027099003|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6Of684d+4PAYEvgxRtt/0NutUduq+ClgIeU33IWjNU2YIYLyxlY0F7c6ZjKcx2JjzKxA4z3GR0rLKhs2NLThup3AFuNKcS+qKlLLUBTXwmxqFBJ/n2is22EqFnglE3DaWbqwsPFOGt+0Inanh29FEi1cvmwsoajY7dqvDtoy/PQtJzMTpPzew+TyEzaBVEK3G2jrdastev7hEgYLtfXi8FHssWQZNtQMQrApmCryUzVhkNrT+uBMxiGmTM2BYu878lBX1O51uP24H67aXKXFIZby7GchPu1gbzIejB1fb1TymZjAxWNLi6L5w7gLIVjaXX4z5xX5kC2E0gqdSl0iVgt8ue8hPK5pgKgviysnzebC04Ygtz6gwFH8kuzJnMO5IJeFGE4i0TPKfN2n93qikNh6dCJxlQW+xydQD4OrcjSZQXYOxwK3XQCNUHZc9OqHdNuh/Hb/NwamN2+WT4D8Hxn5GWZ07I41CBWa3SfilbcA7vDMQZ7VhY0OYYzZU3zY6Vlrn9gpeWoMVGkM4PE4YNAOx5D8SXsQiTuBdh25BjFDdeUoFZUFf08q0Swy1pcztFGeQI45GXH6B03fae9w7WBCzyLZtJKmj9hbtObzwhz27Ct6jx/yJhp94AZWXtmS8J+s7bv98NilxuXyPoSgzb21yVQEsBYrlhGmBsd9uqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Y4ZUtaeGhZeThEVnR4WVluVGlRdVB4cllxNCszcGRtSlNsNmJEQzdxU3ly?=
 =?utf-8?B?dzNVdW1mckJkSWdqb1lER3FzbDNPRXZDblRkOWJIM3hQOG43ZVQxb0IwRVVo?=
 =?utf-8?B?WDhHQU84dVhpRWlEV1pLNHJwcUlUYmJRVU1NbDJMeUdKbndTWGF3T1BpQTVz?=
 =?utf-8?B?d0pEYzczU3BkZ2ROaEg2ZS8wYnJoVWh5cXBkZkRVRW5hdmJoQjNEWi9jOWFt?=
 =?utf-8?B?cXB4SFVzM0xvWnNHc0JmN05xT1lOc3JjZFFoNkVoaSthVzI1cGpwMEhYNlJz?=
 =?utf-8?B?Tm1QcVBaQjZkSzh4NHFtS1d1cXlWUFdjbnVZN1EvUWlZVWZlYmFOa0RjNk9t?=
 =?utf-8?B?eUowUjFpRFMxeVZXc1JvOVRKdm02NGJuSExLMjFSajhkVGRncHh2MFVIeDRC?=
 =?utf-8?B?M0R4Snp5dDlxRTlqOWY5Uk0rU2l3NXkveGdtSlJVdVZ4bitVeEVibjJ3aEpz?=
 =?utf-8?B?T0xwNUJGcDhlYTcrak5JTjVPOWN6STdZR280OTVSK2N3dlJHMmVTazYvZXNi?=
 =?utf-8?B?QzJVMlpwZTRDZzBtQlZmaFRHTkJkcGloeGRrZFY2dXVkY3J3NWdjYnRhbng2?=
 =?utf-8?B?WVdnTGQrbDQzTHRERGN0MU5TWGRnUktmMFhVUDlVZ0NxMFQvZkdVUW8xQ1h3?=
 =?utf-8?B?VkpPL00rcXpUcHp6QVdOcHRWSkoxeksxdHZXVU13R3l4NXNnSnhxMmt5TkQ4?=
 =?utf-8?B?UEpRZlJROEIzUUxscTd2cHU4NjhuQTR4MlJzQk9uOUhPVFNLalN0SW1aUEw1?=
 =?utf-8?B?UUxJbDdVcTVSdzA5WVV3MG9OZmFRZng1VFJ6aFhtK085bzZFNnI0UnJmZFZX?=
 =?utf-8?B?WGdvUjRKdEZNM0dwY1J0Ky9rbUdLZnYzVEh1bTJJZHo3TXp4RG1ZRFQwdlpX?=
 =?utf-8?B?UVppR1BZWGo2NTJXVENxRjBmRm1TMCtvYU5TRjUvOHMya2VBd1dUekNVbHZO?=
 =?utf-8?B?eDVVd2NFek9YaXBCY01nK1gwR0pRUENCc0hNSUR4WVN4UGhFaENBYmJ2UlI0?=
 =?utf-8?B?YnhaUmN3VlpLNDMwTmtodndlZ21WNzlRQ05wQVc3WTg2ZjJzRlZSeUxDbHQ3?=
 =?utf-8?B?dnRkQ0F4VmNLb0V5bmo5dUxqWm10di9UU3dRVFBmTVhlbzMyZERoUU8ySWx0?=
 =?utf-8?B?VXJjWUlrbzNCdnNtbU9hbFN1bjh6RXhOU0hyUThZYUtoZzZHc2pETStzRlFK?=
 =?utf-8?B?WVFZdVpiU09TdlV4bmhYVXRXbHFTVG81bWIyVjhDZFJZM1JTbkpRa09oYmtN?=
 =?utf-8?B?NlFWeitLK1h3ZGp3WXFkTjc0Z0pKcVRUeUR3MFVxYmYyV3VYMnYzSkYwSC9p?=
 =?utf-8?B?YlVuREdtc2I5ZlAzZUtTbmdUTHIwUERueFZFL24wYzgvWmhjMkwyZjVFVVYr?=
 =?utf-8?B?QkhOY2hWRVZBc2FsdjlvemlONFVzYmhCTnAxRjUxV0FMMHZhTmZHeW1EbG13?=
 =?utf-8?B?dURlZGJXVWljemRvejVhUUp3K3ByMGZyQ2hzV0U0TS9QRTROSUdTSEUrdEUy?=
 =?utf-8?B?YlJyVjVycVgzZ0ZqSXYvWkJIYlQrMUtqcDdmcXNNWnI3L1J2WmNPeG9nb2J0?=
 =?utf-8?B?dDc0RDNyMFhkODRRVXpmbVAvaWpBMjk4NFdSZUN1cUNoeWFZUlQ0Z091VEdy?=
 =?utf-8?B?bVRyUjkxUzFJTjlVcWYzeDAySTRWamtid3EyemFoUjNwZUtmQmo4TUtGVndN?=
 =?utf-8?B?UU0zL240ZDRucEg4aWltQjNZQWFNaHlxeXFtWVpaZFFLNm9RMTVwTmJGVFJE?=
 =?utf-8?B?VUs2SkVGUC95SlJYVDRyUnUwNXIwaTZDNElJRklQaUJOL0lzempXdUhHR1hq?=
 =?utf-8?B?ODUzek5JNzExRUVNeVdYK0pOOU5NeFJKOWdnbjd4M1pvMDBoU21jb1owcmxP?=
 =?utf-8?B?YXN6VTAwL0p2N1J0K01ibFkxaTdSN3h3WU5aSlJtMnRLWUg2T0ZYSHZPTk4v?=
 =?utf-8?B?R1lFWTNEQjgzOGIwMTZkZDg2eGY5TFZVZG0xYURCVU5jcTkyYXVGMzkwSzQr?=
 =?utf-8?B?b1pXWjdVTkxtQ0ZRWjZUYm11MW0relFHVGRFbVZyOWpUTmttUUZXblh1N2c3?=
 =?utf-8?B?dWlFUTV1N2poZWxZSnp3djRlQm1TQ3p6VGZYYjI1YSsydkhHWDZ1TWZ4djdB?=
 =?utf-8?B?RFkvY1JHOUM5YmZ6L21EYU42enlkWWdXclJhNUpwNjE3R0pIYXZkZ2N2eG52?=
 =?utf-8?B?ZVBuRkpoRStaY1BLYTlZYkhKRlFCVisyZ3dtK2s5eXZsdWdGZUhxZ3orN2d1?=
 =?utf-8?B?K3Fya09LOUgwYzRoWmUrb1Y0Y1hUVEtXQkl1eS9pdnM1TFFPNW44ZEI0RDRF?=
 =?utf-8?Q?7MJZAks5xcAO8k4NlK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e39ec3-3bc2-4900-3920-08df2f70de32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:43:12.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3ELEyuA+JUaMmo0qUhbeQSY7foV28N0GZiXvXEVhNGpDbmT1w7xtMfmHRuqqI/r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 04:31, Jesse Zhang wrote:
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
> Keep freeing the remaining IBs with amdgpu_job_free_resources() after
> drm_sched_job_cleanup(), so that it frees them with the hardware fence or
> right away and not with the scheduler fence, which nobody signals for
> jobs aborted after drm_sched_job_arm(), like a CS returning -EAGAIN.
> 
> v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian), don't
>     free the remaining IBs with the scheduler fence
> v3: drop the comments (Christian)
> v4: free the IBs with amdgpu_job_free_resources() again (Christian)
> 
> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
> Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0056a93c400a..4d363bcfb6a5 100644
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
> @@ -349,13 +334,14 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>  
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
> -	if (job->base.entity)
> +	if (job->gang_submit != &job->base.s_fence->scheduled)
> +		dma_fence_put(job->gang_submit);
> +
> +	if (job->base.s_fence)
>  		drm_sched_job_cleanup(&job->base);
>  
>  	amdgpu_job_free_resources(job);
>  	amdgpu_sync_free(&job->explicit_sync);
> -	if (job->gang_submit != &job->base.s_fence->scheduled)
> -		dma_fence_put(job->gang_submit);
>  
>  	if (dma_fence_was_initialized(&job->hw_fence->base))
>  		dma_fence_put(&job->hw_fence->base);

