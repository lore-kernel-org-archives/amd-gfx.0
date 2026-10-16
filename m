Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC7CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024EF10E209;
	Fri, 16 Oct 2026 08:16:16 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700B410E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 08:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+hZg3Qeqg9nded4gAqxGcvs6r+ImuRED8v2lSD/SCeShMorddzawV/+uQV2Bp1iHo73n5wQ4VbKimeIaI40fy9gyUr4JWY4/UMQJ6YVnbiaFz0ZzBohPDqSe6dCvlt4EcDIYmvWeD5ni6YlSIT/LFzOMPQWLVnCYBzGU5Z2JClWp7AGGN9Vk00BStrOYBBBmeLxmmJ4HsbIPfqH3GDByGr2X6IAX3CuA19mKKe7fH7KEXepJIiwRUixrfnp42C9tJ5q2nLFMD5xGEplQNTkbV3w1D6WSJoO+pczAFYoNJapG7U0ey1yekuFbBagkh8BHuSbvuWwblJznYDG2OKGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hevk0tlT/Vf/fcOPtvTzag1438TtUNmzqqEKPcBRjqM=;
 b=QRkokzEEaL74ghsKr7Y4f0L2zqhn3Vg0bloNq0396yp4qdZJGHnbt3hfa9050uNGhOCGjPOwZTfX/dDjaRbsLPD8MGo+VElqVelQv13dOi8/2c3vJ/iQpv8LON+hTLdKZDAeXSgfgfC9fWMfIwWz5ZxZYH1d7gLyMKXZcG1bnznw1Ujsipf7MC5KQOs2wB7rj7YFF8YkQ4HvbvXda3WZyB+rnwyj3bMA8HaGlKn+y/9WAv0PXihBsEdt6O2DSVvWyx2zy+DgOUwo5Lk8IY7J9/Q2p/mWaRccAw+NPyUXfWtM98+90yY78A7+V+mMC0B3EjNnb+p+ARQI9/VVIhQ0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hevk0tlT/Vf/fcOPtvTzag1438TtUNmzqqEKPcBRjqM=;
 b=iXhPTuCvnhvQSRgF90AeQyDZpZRH1YWY8Xipv8jME5JYrYBSXP6jzgXtUFDkI0feFUaWZuqPiuUQbHX8u5Mre2rnsmU3gSfeyNGv5ZvxOwjtpxMArU+UKgFLt4KqoWBaYp71MdxOMcnp8MQXnrufV2q0ZJBUBmg78T7hqch8Ads=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 16 Oct
 2026 08:16:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 08:16:06 +0000
Message-ID: <20ce5d0e-08d0-45f3-b6b7-735bf2b3a497@amd.com>
Date: Fri, 16 Oct 2026 10:16:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop the gang leader reference when freeing
 gang jobs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261016074507.3973248-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261016074507.3973248-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: a96bb107-7c8b-46e5-ba8d-08df2b5dba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|56012099006|261009221227099003|11063799006|18002099003|6133799003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 5FRgON29nb0x6X/uzDK/VG2sClo/LXPSKTyZr7sTeM7uXzYFQM9hHbYD6Jl3pKBaHRbeWX9zTQ5rNTDFE+2E4NU5yiXzbLS4lfIAXi54v/DtnpxFqYuUq5Jnj2VLehViyFwKPpxrTlW0hYqxiRgXsZMjHpLxFQA1srnYLOjY+0ajK607v0f/2DdVae1hWGn9gNf+EOhh01Fs0d7QZ21Fi+ezwlhCqhWOavT0qTyWCloPr++JAgIcP71xyjjDC9EfT7IWMt0xiIYiWPDdW/a1uV5lMMOHEP+sYGTvGxDZm9so1ow/vg3BTwoFFiQkt9xXiV8nD5kBYIusQk0eyskC0ZxqNVVJ7HghZFQ6Tb65rCp27LbLw2vZ+4G5dspRHDuR5jL+rwpBvCyv7ERyJMiDQrV8WCCd7ffOFlyDywk5XbFOqgfJgbLANLgV2ycyxhcR6ouw9hFNAj+NfiPbJBptc9kCZpkzic2wiLF1DlYXk2Ly/SCXojt8bcrG/MowKwDTUBJl2QLqfyledxJGqlopibUDj+d8OpVd6GFx4tvy86GM5YFwhrGfyZNA828LwafmXaY1jW6fZ2Iu+p8/JqV4aA3Wn2W49vU8zeEeeAnRMKCoFtalyqFcDHtBWoyo2nB40kU6pDDNMYGoNZVQoUeD6ha0j1v8GZlYMat4WbScA9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(56012099006)(261009221227099003)(11063799006)(18002099003)(6133799003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVXVzczSkhTUC9zQ1RHa3B2bDhmSjJzSkV5S2ZXc3NtbGVOZWV5Ynk5YnZx?=
 =?utf-8?B?M1lpSktoV1puelFadHdQV0RSTVRZaFJsMFV3bGhjZ2lSL3dJWUt1YllCWEJ0?=
 =?utf-8?B?d00wSUdoZ0dSam5uVFZGdkF0QldrdWhDaC9qaGxZQWYyenVIQk9vVVJrQ1Rn?=
 =?utf-8?B?TmxDcXNGMnRsNnJCczZqaVZpQ1kxcVpvUXQxci8vbTB1bDFrN21SMHVxalNP?=
 =?utf-8?B?Z2d5c1ZjaTRobXlSQzdQajZ5bUtEdzlWb0Mvck5kb3BNWjN1WS9wNTZFN0lS?=
 =?utf-8?B?TStySElxTWxnL1liWHZPYlN6SXhYWU9wZmJUemQxZmQvMmF6aEIycHAvM1F0?=
 =?utf-8?B?Q0Rtd202KzlLb1NwS05LekpTcWNDci9xUDRVZDE5UmE0NFZEZmZnSzZnbFh2?=
 =?utf-8?B?SDgySU42eDZYWjdLSGtqaWliSk5pNW9GQVFPc3kyU0loU2czOFZHL3VKUmZ0?=
 =?utf-8?B?bklSLyt3eFpnc3VFRDdwM0ZvQVJtSTVqcHNxck5FQkFJRzFaZlBnYUpCVFN0?=
 =?utf-8?B?QmpsbWoxRzIwNHphOWFKeWt4RFFzU0FOdlpnak5kUVgvRG5WNkwyaGM5WVJw?=
 =?utf-8?B?eDdqVVRCZGhUQzV6bS9QWmU0ZmwrR0c1cXV2WmlJTVZmWFdGNVg4UzlUYVhu?=
 =?utf-8?B?cHFVODQ2Q3dQcXNxb3pCbWVkYk9JNktHL3RIMmFjZGZVYXcrQUZxbklVTmNa?=
 =?utf-8?B?Zm5Ec1dLNnZLK3B5YnZNRUNCVVRZMkkzZ1RFVW1nUVZVVzVuaFpNWkxUQjh3?=
 =?utf-8?B?NzJFNkczK1ZOZk96N3IyQ2IrazlLRlJNV2lJcHNLLzJEWEtxektiZGJxMS83?=
 =?utf-8?B?cTlPMzl5TkJIWFRNRlh5eTBYVG52ME5oRXJmSDRYNW03emRzRnViWG4zUXpR?=
 =?utf-8?B?VWkzb2dzYmVPUEhkaU00TTFzdmZWeGt0eUR3ZHZJUzFNaUQxamRoZ0JVWFB6?=
 =?utf-8?B?citLdEcxTitTMWZHc1pubjJtQmpkN1R0aXF1K2ZIcm45ako2eWlJMFV2aXdG?=
 =?utf-8?B?NDZkc1hsdndNcVgzZEFkMGtTamxnSzQ1T0ZmQzBvL3B6a1pUMUIwTW1SNjh6?=
 =?utf-8?B?WDRHRkFrK080RDZoUTdIZ2x0dkxrbG9yY0l3UTFyNm1RVEdCN1NldFg4dGtZ?=
 =?utf-8?B?bG0wSWZWWEgvV3ZDd0UwU2wrNGtXYTBwUHFLWnNlNmRRZFNYeWpHUHFwZjhr?=
 =?utf-8?B?bUs0MUxnQ3NiMCtpRWlOejdJTW5tbFpYNkZXSzUwVkpzTG9XMnQ2L1N6VmdT?=
 =?utf-8?B?K0FWaEFLc0hVM2VFM0ppaTNkNG1iVlBMSkZaaUQzUGN6VXdyVmltYW5RZ0RO?=
 =?utf-8?B?RUo3UGRweklWSmtIdmxFYUJSQ1puMTk5RmhyTU02L25XcHVWM3RTRlBWQ1Y2?=
 =?utf-8?B?d2pBaFVkajZMS3hISkRFSlBtc3R5M25ObGs0WEtybzlKTVc4eGdKMUQyTWJj?=
 =?utf-8?B?K2FKRTdpSEFDczJXSEFvS0M5U05YVW0vNUJ4UmtlOHdnOGMzdk83cXRINUZQ?=
 =?utf-8?B?ZUIxUmhzNGRwQjNpeHptM1JqUzlKT0QyVEJtaEdjOEVkOE84VExIUWVUWnFN?=
 =?utf-8?B?a3NldHY1Q2hmN1EvQXBLbDZsVjhmT240NUg5MmpQcEowejJselFBWHVaUWM4?=
 =?utf-8?B?MW5FcFcza25KQlFQaWlOK2EybVpYWmlESkUyRXEvbVpBT0VKaVQ4eHVRalFn?=
 =?utf-8?B?NDAwU0tHRXQxUTF3T3FReGVEcW1ZdUNLbmFXRkpwam03bFFkb0d6ZCtldmow?=
 =?utf-8?B?UC9laWJmUzNocFc3L0U2SEFBUmdsZDdjVCtnZ0ZadzNGMTlEUzNXcU5zcnJv?=
 =?utf-8?B?RmdGWVE2NGhzQjZYWXF6eUlhTEZHVnU3N0p0VnNRU3dBT0VtUlAxQmtZSU93?=
 =?utf-8?B?aEVLNGtLRnBTVDNsYWJvOC9aemU4Q0c3SUlWR3p5dnFQM3Y1UndMQTZ0ZHJ0?=
 =?utf-8?B?bUxaQmNjUENTUkE2S2N5aEVIK0d1anYrdWI0dkcwNVJBLzh5NlZ5Mko4dlRB?=
 =?utf-8?B?RVFNNTZ5ak5tQnRMdFYyd2t0VGtVY0tOa0xkOTFFY1RXTWZqeTM2b3ZNQzdW?=
 =?utf-8?B?ZUlqU012QjBzQ2drREMwMDFwcUp5Zk9OLzVtTDRreUIvdHBTL2lFdG9PMVJD?=
 =?utf-8?B?TG03elRGNDRMZ3dSU2lZL0M3U0JFOTAwSzY2QVdmTVBlUFBLQWVXQVhqcVhU?=
 =?utf-8?B?Wk1qdDNjZWZjeEVka0V3VlBNNStDK2hhaWV5UVl4TjNOUHFaTkxSdXpEYlJQ?=
 =?utf-8?B?cDVtczNWRmRvZTlSUmJyS3VNbE8rWUo3bEFuS3U2c2ZqNWhIRzdGS1d2ai95?=
 =?utf-8?Q?PesWo9Kyx3QZ/rt/sb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96bb107-7c8b-46e5-ba8d-08df2b5dba20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:16:06.7459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7Q+z1vHa2ZbLFGNswcSbeglYDr3oFOaeNMMmLP1VSrWNikf11ahG/h/9jD3TVzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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

On 10/16/26 09:44, Jesse Zhang wrote:
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
> Drop the reference when the scheduler frees the job as well, and check
> for the leader before the scheduler fence is cleared in both places.
> 
> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
> Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0056a93c400a..f8e67c1b5a4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -311,10 +311,19 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  		amdgpu_ib_free(&job->ibs[i], f);
>  }
>  
> +/* Must be called before drm_sched_job_cleanup() clears the scheduler fence */
> +static void amdgpu_job_put_gang(struct amdgpu_job *job)
> +{
> +	/* The gang leader doesn't hold a reference to itself */
> +	if (job->gang_submit != &job->base.s_fence->scheduled)
> +		dma_fence_put(job->gang_submit);
> +}
> +

Good catch, but I think we should just unify amdgpu_job_free(), amdgpu_job_free_cb().

As far as I can see the call to amdgpu_job_free_resources() is incorrectly placed after drm_sched_job_cleanup() as well.

Regards,
Christian.

>  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
>  
> +	amdgpu_job_put_gang(job);
>  	drm_sched_job_cleanup(s_job);
>  
>  	amdgpu_sync_free(&job->explicit_sync);
> @@ -349,13 +358,12 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>  
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
> +	amdgpu_job_put_gang(job);
>  	if (job->base.entity)
>  		drm_sched_job_cleanup(&job->base);
>  
>  	amdgpu_job_free_resources(job);
>  	amdgpu_sync_free(&job->explicit_sync);
> -	if (job->gang_submit != &job->base.s_fence->scheduled)
> -		dma_fence_put(job->gang_submit);
>  
>  	if (dma_fence_was_initialized(&job->hw_fence->base))
>  		dma_fence_put(&job->hw_fence->base);

