Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 18:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0820112D3C;
	Thu, 14 Jul 2022 18:32:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F939112E0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 18:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyZKFOFqpXNABSykX6SWhw5n/EMKi9YPst4kNaPHZArIw6ylFzqCP5IqtcMtXoDI7oavFdgdzUqNnWyueRmx8O8SyBXXq22dorn7TWHZ5QLldO93MyBtB68MbA3T7goXFznjPBi6J8sRmz1KADyZh2o3eEj/3MrvtXwYeB8pWjzcl32TVPG4DqkQuPfAaNl8D0Lu4I2OmNVPRB0xvO0GTTeEqLekIw2YaXAcsprsNg8+p7cdlqT+epnedrbNnRQYfYskiidbMZhDCoLomnFnf9dYoYlLWhU0C2LD48A8mxMEm//Wz0Magxau/8dTvJsGmqP4qnmM8DRyAoErUZxAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISjeeH3+9NJYNBx7KqBo8WZenq8ABIKf1mqY8n1XKXY=;
 b=G0NmIBScE2J6Wd3fmYYykUiS6RT9ubJMaLOCET1c/plJKtMMyJpOA+t3/J4lPuT0JvYd1GSoKeP/W9qLM7y5v8deOBzXy5fGoBU1/ns6CytET8w0+Nltsj1X14LbOEO/lu7e+coV6zxG++m4KeCxSVjj4gzo9/dYmlUQvOx+rVvfuujoBe1weLobhTGUiLzz3+265WR+mMeAVN1DM8ZQQAPArWLUX6nmpkVHN3fD5Tnh62BOwLm50jqhryhzHGZCPEGhfp89JUD+FUZmhH8nDwZqH2G0jLHkJOf6Da7+7S2Zfhy26kjENFMZ94msmRYJUdMkwjyD/O3QFNm0oufAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISjeeH3+9NJYNBx7KqBo8WZenq8ABIKf1mqY8n1XKXY=;
 b=q6SuKG0UFLk8glkWg4OM0YClRZyIfR7s+AFa4ci8rYRH8GyhwHq5y2ijVGv+VQsNyoWP9k1+vtV/c4aZpbOpBLBPDa0A5P/SnNGSQ/ZIORpgwPemZcGz4GxEG9aHb06MPmlpt5P3HaETzxi1hrTXXSNWGTDO4v697/YyZiYgPFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 18:32:19 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 18:32:19 +0000
Message-ID: <e4146d79-7532-1fdd-752f-0213d133fd99@amd.com>
Date: Thu, 14 Jul 2022 14:32:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/10] drm/amdgpu: move setting the job resources
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-8-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220714103902.7084-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35b67f1-d341-4332-1287-08da65c72f48
X-MS-TrafficTypeDiagnostic: MWHPR12MB1951:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+CoQ/hcs91aDpDNDOyE5mTJgFYtb98NLLX6rk6GEQlWoYuy7xcxZGAIyIPQvMtIiWVEV7db87QGUildHi/s1aQ2jq2rrBNvt+iMxOmdHeS91Mj2EGIb/wQKeMzI5l3rC6UnVIStUk/DtHGbDfc5YKBSY3oE7gEvcE3YFnX3th3GIQT404DM3pz9Xp1U94L7Yj6MOFAl9eM+EaGglZIA5OPMxB3Hr2Mm7Sk7dDet2y2X2ultDEVhj3opn0kZbOE6EFJTDVIUk9+AVmQctleczMh2IFZOr6pEnecicI5JJmiXUcCiHbja+KUJ+LcEaKmKL/PD2O27RGSz+iekuitREn3NwWa0OMDsgo1WJGQgl3ECohRjrejTSu8kelk5AtrYwMcPx5IqO8bIFCj2CuDeDXYqK9gptLpsQMx+xampcHcvEpu8nx2MnAT/OYRuRAn1RKPOqHUoO/t+kQdEYk2vq5z32IJuLNyUgWQUqk2NZ86RJXqGUw4mfyiyc4ROSKrJkyBYr8zW4DQPACQc3h4Z3hnHK2PO0zulinq1vryk9aecxIWSx2Dh3B50z5HdNTgnQ1iCACaEE/3W95CP6AuIeY4lClp3hzQ7uHiwYNH8f11+WdkEFPIctlkIrSUhQBoSOa9Hj48Hm1GElAOgKvldWEapQwEJJi29KQsH0aDTu5u6wNmL4AqAclznwIXnHek0RtPTPCZBMBSA0AncBetylp1SvxVp3XtPgsBTOtgIZ7a6rVysW5MMLSeCgqOzANPd1FwlyV/IA2aOJAOqHUfh1oCb8Q0qcqOj37MlpK9/chu89ZiFabEMG5i4LgmQpBNLbGmGcgri0zlEmpou2f/WyWyPd+0yue5X9c/x9uMOEeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(83380400001)(6506007)(8676002)(66476007)(4326008)(6512007)(53546011)(31686004)(66574015)(66556008)(66946007)(41300700001)(6666004)(2906002)(2616005)(44832011)(8936002)(86362001)(38100700002)(31696002)(5660300002)(478600001)(6486002)(36756003)(6636002)(186003)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME0yVkxrWWZBNk90Y1lKRnZjZWJWTm9TVjZHbWpoSkFoOUVQQk85SUZ5Z3hx?=
 =?utf-8?B?MU5MdGwxZTFFNWtRc1ZsclUvcWliRjRNdVoyU2NLYlBLNzk4NnYyWWxzVlJr?=
 =?utf-8?B?VlFRZkpTaUlCak1LV3B4WFpkM2p5NWJxVjBZNkZKQjB3WjkrRFlQRkNHYVRs?=
 =?utf-8?B?ak5YZmpxdHo0ZEpOS0tjaEg5bnF5NjNUbHBIbDdtUHFXeWd2cVlYY2d2WGUy?=
 =?utf-8?B?ODBSRW9ad1lSVW4yZm5FQ0N4dnBrdUJ5OCtpbUh2Z3RJdDVNd0tSWWoveUZF?=
 =?utf-8?B?TkRyb2xqT1VhMDlzSDZ0eXloa01pVklWUWFYR3JndGtsMnRuSEU1TENDYzA5?=
 =?utf-8?B?MUhwMHBZL25HVlhiRmQwUGUzMUhNSG9JOXpPZnRlczRFdXoxeGJmMHNUblFE?=
 =?utf-8?B?YU9OV0NDdjhuR2F3NzNLS3ZtKy9YUkoveEE4VVJMYkhNWGFzWGp0Zy9CYkVm?=
 =?utf-8?B?aXVJYWRWL3hwTEVWZzdKN21ndUxnSS9MUndrNGlqVXBaTnhEVWdYbU14RlJm?=
 =?utf-8?B?Rmo0SXAwYnVpMFhrZUFMTmhxUHZyVWx3bndTcDZpQnk4RDJNVEMrZnFFM216?=
 =?utf-8?B?Tk44Z25KTzg1blZPUWJSL015SjNMOG9EQnVZV0t0YnpyNmp3WDJRcXZNQmZO?=
 =?utf-8?B?SFNVeVZ5WmRuWGhUTjM0eFZ0NktEcEtMeHljZTU0QkZUWjlQaVp2THdmUyty?=
 =?utf-8?B?YXgzOC9ZNTE1NnREYWoyd1c1RC93THBCZXQ2aVdmazRsd2lNOW1QZ0Y2MGt2?=
 =?utf-8?B?MElpMHROV056Uis4UllGVWpTSlhhYjY1eE1YSVBwcHpuMDh1THFtWWRCemd3?=
 =?utf-8?B?TUwyb2RZU1FZK01VMlRkcVR1MEw0MU5Cc3NKd2NQc09OU1puNXMvK2lDZ2lK?=
 =?utf-8?B?RGxwV1VWNjJEd3RVcUt2SER2YnpuMFh3bXhQWFh4T29UMVgzS2tVT2V0V3hT?=
 =?utf-8?B?OVh2OHRKVWZyM1dMOFBrbTUwcitYQWc0SVBuczdLcG9EZmoyci9xS2NVVXFl?=
 =?utf-8?B?NjBnQklKYm81VVV4RWhweks1SEt5eitreTViVzdvZHhVejdJWEhvNnZKbzBS?=
 =?utf-8?B?VzZFbitBS0YwSU4vQkhvVmsyZytYbUp1eW02MVVnNUFqdk5jU3ZjdVdCdGd5?=
 =?utf-8?B?NkN4ZnRYaTlFT0c2Vm5KTVkwaFdkaEtndlIweTRWbHJnSVlSR1l5VXdRN0U3?=
 =?utf-8?B?TGNlT2xDWk10amczT0liUFdVT2dKangwNnRMWnZVRXYyYWhlbDN1Ky9KZmtD?=
 =?utf-8?B?cFkycE9mY2tEbFNXMFhNdnE4MitFTkxNdVo4MG4yMExwQ2FqenhOVUlnbllk?=
 =?utf-8?B?MjFENHNzUzRoQ3lqSXFLalQyYnpteVhqTU9tZUhWOUVURmpHRTBCclFpSG9P?=
 =?utf-8?B?UFk3UDhaQU9QQlQ0VStXS094cFUycnVZcnVWYVpDMVdBd3hNWGllNDUyN29G?=
 =?utf-8?B?OTdkcWJEWEpVM2QwWUpUUStwWnNENXlJZzA2SGVFNmtnclVSa1YvNmkwcFov?=
 =?utf-8?B?clVmd1N4ZlpQT3VYcUU2b2JVN1VSVThBVE40bXoyeGxyeEw1eW9WSHdkWUJx?=
 =?utf-8?B?Sk90bE4zUG5uL2dwRXcvY0ZPaHArUmRDK3JQcDVTdnRiUDlYK2dnUklWYndw?=
 =?utf-8?B?b1hRanV5bFdKMVhtR1N2c1JwRDN0ci9TU1k0MUJCTXlySE1MNEc3ZXNhT3U1?=
 =?utf-8?B?eWVoM2ZOVm43dDJQK2xiOUMwR015eWZZTStyNEg5eTEwdnRpRGNpaTJZR3l0?=
 =?utf-8?B?WXpWYWJoQ2EyUmJHaVcxN2hRQmJnU1JhQktWWDNaVGF0VUczOHoraDRTWGxJ?=
 =?utf-8?B?TC9UOTNuUkJUNVVVQ3J0YmxSbGxoeEt5OUNLbXFtYjhyd2NVYzY3dDhOWWNH?=
 =?utf-8?B?S1cyK3R1VHV4ajZXcE01YzhEN3JicjZ3V0p2SFlkVU5Wd3hQK3EzZEt5VkVy?=
 =?utf-8?B?MzlmQ25FY1VyOEZEWk5nZ05qMERiVVVLbmwzNUlqNzRhdFVqUmdLVjluUmtE?=
 =?utf-8?B?TDJUc1pKNC9UcFh1dE9pVHNWVW5ZQ0JyK3p5KytidkFHS3lKdGkxd2xYdWdH?=
 =?utf-8?B?RHo1aXhaSnpvekViN21nMXZGNkhacDFrN0c3OG1xcCtSSFpTbzBxWW55SllW?=
 =?utf-8?B?OTRBVUs0ZGJqQVZpUjlaYUNKb3lzS0FveC9HeHNlSEh4dWNQYjZhRHUxWERG?=
 =?utf-8?Q?TxGwF17fAOU4F5OBW28lVeG9ryv/QsAjvNsPRZXt5d/J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35b67f1-d341-4332-1287-08da65c72f48
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 18:32:19.3902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uV39GIUYxLmrwZYyIf8NXlHhPm4oUNi2zy9YzZJm+wjiXTjpdyJUEVXC8biLN0m4jJNeEWHX4mq0nAjBEsNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-07-14 06:38, Christian König wrote:
> Move setting the job resources into amdgpu_job.c
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++-------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
>   3 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index dfb7b4f46bc3..88f491dc7ca2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -828,9 +828,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct list_head duplicates;
> -	struct amdgpu_bo *gds;
> -	struct amdgpu_bo *gws;
> -	struct amdgpu_bo *oa;
>   	int r;
>   
>   	INIT_LIST_HEAD(&p->validated);
> @@ -947,22 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>   				     p->bytes_moved_vis);
>   
> -	gds = p->bo_list->gds_obj;
> -	gws = p->bo_list->gws_obj;
> -	oa = p->bo_list->oa_obj;
> -
> -	if (gds) {
> -		p->job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
> -		p->job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
> -	}
> -	if (gws) {
> -		p->job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
> -		p->job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
> -	}
> -	if (oa) {
> -		p->job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
> -		p->job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
> -	}
> +	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> +				 p->bo_list->gws_obj, p->bo_list->oa_obj);
>   
>   	if (p->uf_entry.tv.bo) {
>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 36c1be77bf8f..3255b2fca611 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -129,6 +129,23 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   	return r;
>   }
>   
> +void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
> +			      struct amdgpu_bo *gws, struct amdgpu_bo *oa)
> +{
> +	if (gds) {
> +		job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
> +		job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
> +	}
> +	if (gws) {
> +		job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
> +		job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
> +	}
> +	if (oa) {
> +		job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
> +		job->oa_size = amdgpu_bo_size(oa) >> PAGE_SHIFT;
> +	}
> +}
> +
>   void amdgpu_job_free_resources(struct amdgpu_job *job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index d599c0540b46..0bab8fe0d419 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -77,6 +77,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>   		     struct amdgpu_job **job, struct amdgpu_vm *vm);
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   		enum amdgpu_ib_pool_type pool, struct amdgpu_job **job);
> +void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
> +			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>   void amdgpu_job_free_resources(struct amdgpu_job *job);
>   void amdgpu_job_free(struct amdgpu_job *job);
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
