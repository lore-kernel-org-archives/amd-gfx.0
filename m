Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398A606A33C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TyzgI+Bd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0652D10E139;
	Tue, 20 Oct 2026 11:11:57 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FD110EBC8
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 11:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5BgS4unLS3JaMnKCowN3KhoqRTxXWbGp5vo3Zxs5Y5vtl3TOGAF2sikybuMahztGdB+M/3YDLT2CaawbvsRxFpcCADYuYY+ozBbpNLy5HnXEmIIGMpZHEJQdALx39X4odBnmR7PYn+1+f4nXyaYSosaG5rzEJAu6vFgKvogSVuv9iyueo8kkaSi215H+0inyQtdCv5N0l0fHknRjTjLpUfYtqsgFuM9h26xQzomVvlQPnvr5OD9RCpdDEoRlNC8Yj2eQ8Am8r8QffWKZhRot7xNWotQbFu3SrfZodip1pOG1/JPEp4d3EXld01vbn1NT6mut2fjEC98TKIhRowqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYxswP195uC4s4cAdZsM1E7GwINkHC9E9C3nCrYTUEw=;
 b=DpmwydUZDA5hNlzJJPOdi6gddC6DCjocZHPQhw3JtZLX4lkeD+ZWSItY8kSj9iyfCiBg5lpo6BY4FLJfI5X1wSRtiii4Gasyz8ngeb1REI2pdq8Ay+P7OLWNgWD8dRMepygkiPhNZlTg+wTM6TrUVCQNExEhfVDP2JlYKafZi1l4SWi/KlZyyppY93qZLSdhskv4jphAdzB+h+t0MzvebtcLK2+s2JS/I8cMh4mT+oc2/KChA04y7UeVgOX/Pxw55qnOULFDWNShT5fVMUVshyAod/0yzDpknLhVqqg5AB8fm9uwlUQe9BilwPf52+Vq66XZ2ipeSE1v8PFZcse6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYxswP195uC4s4cAdZsM1E7GwINkHC9E9C3nCrYTUEw=;
 b=TyzgI+BdYrY1xC9d0Q96a/rZlGNLCUvF8sTkXBylLdZ3umWZXv5xkPmLaKbLaX5CTmD+BdgvL28Yti4zyjHQSuacMmP2o77i7+d2M76B/F1Bg1w1cS8zTXXcnz7uugXTF9cFXNLa6siMh7KrY0CuM4NCKv+OBr1Uo31F/078Hp0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 11:11:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:11:48 +0000
Message-ID: <9226a303-31a6-4e34-8c0d-6ceb15993693@amd.com>
Date: Tue, 20 Oct 2026 13:11:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: drop the gang leader reference when
 freeing gang jobs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261020014336.2319937-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020014336.2319937-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: b1219d73-08d1-4f85-f580-08df2e9aef15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: nYnj1NNCXi5+u71WCixeMi1qHPPw1Q5PLj7g6AaHQvOflvfdWmEDgTRyhBFSsPc6JsRZSLs1n3/+ifFif8kmW/JiQKDiY8qpVKvmNf8Dbq1z/zajnTl3IlCz+IruhCWezHtEPJu06s5mp1kNG8b/Il2jzZSKvt282f0EV98OHcVPX5y57jpz41k1cH12MyihxnaORUasqs4CAXhY6h/6NuzijFc39F5uXovDY+C+bZfr3p2a7AcLSXinghcWzkWmifL8HhFETSEc51+A8ee15oeq/Zfhaiiqts9xT+EPqzLT/dQLQC5vaAcVTitvXMM+RKWA3O7RNv2D4zV0oXqM6IM9R+ESC3dcK+R/FZxpf9z3xzb7FlAkuiPA7oR9cB/aYLir5JA1sAhxxSJNkw/KD1lbSyMSMyHCIbYIW0TYrxjURWnY2OD04RsFTT1ND8xANHhq/R+zqIKVzSbaVXfnQrKHvgyV8dlKJ1hsuyKBIyyAEvVVeDsUZORVHCcZEqgctZe8j3wXtuMODuGskqL8T11Q0UMJKyk6GgL7wvZe8s/H7Y8yE8Emi0YmQmOyLLbUQGJAoCNCRbm0hsiD4gXQo34u/xNq2kLHVXnBXa6YzAS2PBTIjMd+w5jZ8G/fzkHZGroXM5nw4DQX1ottndFLyTs0jn5lynxMoyhWNPfcVHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlwdWdOM3pqZ1djREdkcVNXa0Qya2VQSVlqVHBUU05wWlZkVlIzeXEvVTQw?=
 =?utf-8?B?dE9wTEhwdzhlVVcwWEVaRkRFdnI3UE1TMXR3K01KSm9vZmZUT2ZxSGNiM3dx?=
 =?utf-8?B?YUxaTHUvd1ZxSytiVlBFL2dTWHR3cnNhVnN6d3hGOGVMOWdkTVUrK0NaM1I2?=
 =?utf-8?B?NmJ2S3VxZUxlQVIrRXdhMFNYMURRV3k5Z1Y0aHU3TUJwcjdiM1ErdTloN0Fx?=
 =?utf-8?B?UUF1bm0zZ0c5RXB4Tk1nVmk3WG9aanZDNHR4Z2xZcjJ0aTFpRkNKdGV2WGo3?=
 =?utf-8?B?K0pFTXA5NitMOU5LMzFCaU5aTzRoWFBNdTNxWUdqQ1NKWjhvVzRNRjRCalRC?=
 =?utf-8?B?clJJWHBqOEZaUHc2RS9pSlNCeG5DQ003QWxxdk9LVStnOThoVHhrR1FaV3pt?=
 =?utf-8?B?SGNIZTdRMGhpWE8rVm5aeVp4cHlwdi8vK2hpaXM3L3RmdFZSbEJ5YUdQdlBC?=
 =?utf-8?B?U1JqcnRsaWtuTDZ5TSt2QkYyVnd5eVV6Vk9BaGpUa1lSUGhOUlRDbzVyNGds?=
 =?utf-8?B?Vi9EWS9tdTdNZUdxanplQStPaG1Ec0w2WDhwdkJ3ZHE0OHZsSmEwN0w0Y0t3?=
 =?utf-8?B?UWw1MExmNWxnV3hlYmkva3YxelRIMFlNei82RVljY21RaFNiekZ6eEFwSzhn?=
 =?utf-8?B?amlmY2Y4R25uZFZ0YUNya29nMThCTUlsTS9HSGNWeThWeW90cFJqNHNCTGJp?=
 =?utf-8?B?Y2UrcHZXWHZieVpzQXlqb2trN2RVdG0xWE41dDJpcXI1WFdxUU9hSkFocnV3?=
 =?utf-8?B?d2xnaTl5UTFlSHBxRFovbEd4bVpiODFYZ2E5anVjYmJ4eWpsUzBRYml1c2JS?=
 =?utf-8?B?TFBYaW1GV3YyTUh4ZUhqSDNFVDZCK01sZzdwYXAyaC9yRjlhdnVvV0d0d1B1?=
 =?utf-8?B?djdleDlCK3BwN2tyOGlBRm1lak5pMnNMU0VBVzNLNWtDOXpEd3FUQU1XWUVC?=
 =?utf-8?B?NEFGUXNmZHQ3dlZrNlBZd0tDczAxZG9YNnhlalExU2lzM1cwWEJ6K2lVWGVm?=
 =?utf-8?B?cjdwOUU2T0dLMGN0eHUzVWF1QmtldGpjcWpxS3IwWlZzNlJtWGtFdjFUc1VE?=
 =?utf-8?B?aW5VbFZZa2FIdEZQUVA5TXh4TXlhdmRPSUt6aC90b0plTmpCT0FTTGxKVFBa?=
 =?utf-8?B?NGZzZ0pYaXJnd1Fwb0NCbkgzVmFKZHdGT2dVKzkxU3BhOEZXUWpVNHpudmE4?=
 =?utf-8?B?Q21sUTN3Y2tRWXMxRWdEWWhHWFpPc3NrbTBNY1dxaXQ0REFBOGdFc2I1dDVj?=
 =?utf-8?B?RU1HK0NFS0tmRTJKTE1KMGM2RU1EU2tIbFRYTTZxZEFKWWFFZ2Y5VlBJbU9L?=
 =?utf-8?B?TkdCcDhUWGNSVVd1SjhkdEYyWkJHYmM0NEdQdENRdGh4VW52bUtUQ1UvMzZ0?=
 =?utf-8?B?QWgxdEZjQ2NyaFRualYrcUpJekVaUzVnSFZzaUxSKy8zVE1OSlY5NmU0T0xX?=
 =?utf-8?B?dXc3em1aZ0hDRGN3c2FsMWYrbW5Jd3VqaTVDVWp5Y3JtblVtcWtDbGpwTzBF?=
 =?utf-8?B?RVlFdXdJUExyRGloUXNNTGZBajE2VWlwc1F0eGQxUzhyOFdKaHRLVXRrZUxJ?=
 =?utf-8?B?bnc1Tmlaa1ZQU0ZTeHJRTlBMSXlHSXdwYnQ0VmpIZU5CSEpEcjlualY4ZWkv?=
 =?utf-8?B?clEvaVhmZTZMVi9VSkM5dVUxRXZBMnZnZ1NQSkpRWUhLdnAyKzdKQlovQnhF?=
 =?utf-8?B?aEpTSW5VaW1LSzljZmdmd09KNHRkSmFiWkJFK2JYODhBNG11NXFQaHRIaW9X?=
 =?utf-8?B?SG0xeldQdkhjdVJqQzFGWGdUaDJ6Qm4zbGY5RXd6WXcwQzZzWjd2Q2xuMC9H?=
 =?utf-8?B?NC9uRjdoWTRMV0lXSnhaSjRGNlcrbkpra3F6R0JxZVQ4K0RJdy9Pc2pDaUJP?=
 =?utf-8?B?MGFab2lWeU9YNlJEenJjQVJGRzA1bitmWk85ckpQV2lkbmkvM05hWW1XaWNY?=
 =?utf-8?B?NFpVZThKOUQ5elBnSDg3Umx3RlpVY2pYeUl0bCt5eHVwalZJZXcrdHJaZGFN?=
 =?utf-8?B?T0pqK0FKbkRQQ1NwVGdtcnJNUkVJaTAzcytSbHpSeFFBUTBaWTVJQkhjdjgy?=
 =?utf-8?B?UXhMeHdlcnhXcXoxZkdVZkVERkZLeVFaQ0lQSk1uZzJHejVvVDlVV0NOOXY3?=
 =?utf-8?B?ZnpQVUE1N2poWGE0Y3h3eGIxcWh0eGZnWWtyU0J6K01zUllXTmE4ODdJcitC?=
 =?utf-8?B?ZFhubEk5blFPbWx3dG9vc0ptdGVlVW1FS0VPMVU5bTdxWDV4a0JLOUhDNWhS?=
 =?utf-8?B?dU0vMEs0OUtFUkRic3djTTl6ZXp5VWZIQ21XZVhHZXRHR1dtS3ZCL3B6ZkJx?=
 =?utf-8?Q?Jvs+KEvRnY0Y/qsoRV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1219d73-08d1-4f85-f580-08df2e9aef15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:11:48.2354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTBb/3hcAfKPCCmzIbukSFRCIUxYVcf8uFVVanuD8wL6fwBa+qtZGlTyVC28yox+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

On 10/20/26 03:42, Jesse Zhang wrote:
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
> v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian), don't
>     free the remaining IBs with the scheduler fence
> v3: drop the comments (Christian)
> 
> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
> Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 33 ++++++++++---------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0056a93c400a..f8a81f0a607b 100644
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
> @@ -349,14 +334,22 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>  
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
> -	if (job->base.entity)
> -		drm_sched_job_cleanup(&job->base);
> +	struct dma_fence *f = NULL;
> +	unsigned int i;
> +
> +	if (dma_fence_was_initialized(&job->hw_fence->base))
> +		f = &job->hw_fence->base;
> +	for (i = 0; i < job->num_ibs; ++i)
> +		amdgpu_ib_free(&job->ibs[i], f);

That should be handled by amdgpu_job_free_resources().

Apart from that looks good to me.

Regards,
Christian.

>  
> -	amdgpu_job_free_resources(job);
> -	amdgpu_sync_free(&job->explicit_sync);
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> +	if (job->base.s_fence)
> +		drm_sched_job_cleanup(&job->base);
> +
> +	amdgpu_sync_free(&job->explicit_sync);
> +
>  	if (dma_fence_was_initialized(&job->hw_fence->base))
>  		dma_fence_put(&job->hw_fence->base);
>  	else

