Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D8C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 12:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DB564F25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DB564F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D85589F6D;
	Wed, 10 Mar 2021 12:55:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D91589F6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 12:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhF+QVziQ6wi3b06o1TZVxKGUfZAFCXAEWvve/VA533M9tW6J8aVvyfFm/LKq/VRP/M22rWOYDLBwEuXxz7ZUofm5x3mOxEHuT9TxTgek187cm1KrvxS5+AHd1FvdfjiUzBA91cadmEqnK74xZj1kdlIiBPZjvaCD7S5TYz0bYWg4TzRYakOKRiO10ZTcJHFNhYoSyJA553HF1DYYR1CjfVDs24xZc0goqcbtG9GflgM85PNP5ep8svlgSBgy1AaONEMyhV4doFwX51iD0wor4SR2sr1qa0cVXlzgkoFl6rsqYeMrGh7qMI+pISXx6XupvnKuyfw/DOBtJ2IFeQttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAJ8yPUMqi4xhf2CDSy91OgqdNC8u+Kq+ajbH4o5AOI=;
 b=IGqk8LrHm86d4NR1Bq2GmNlcn79ib6b3Zlbwew8GL0lAGtTDJd6THHluxaYZTqCtl45k4pNuPtyxoru/V5FhLga3AGNvRaZ6X8/e3w9yTVKmEt5Ik4Np8kIfnqTXIyguybbaBtkFXs9B7q9dQVjcPoqMXRWPZgK5AzyZBi6vPNlcfNE3A/OibkKe18BKTI8RJiuCPEGT2eDKhPFyQJP5SXWj6WqGcjgDAveLMqWv3mD5B66KW7EA7Z8R4XAbFnceiCGjuAkAcr23vjNOyKBo+74ZYgNE/WlKXX2o9Y1je88EGkFXw4FkYaKrEqNRCsAQ/kGP9d0866i+YRtGQXh9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAJ8yPUMqi4xhf2CDSy91OgqdNC8u+Kq+ajbH4o5AOI=;
 b=rKNxQxcpQAGX9QZIvKx4DgpmfMaNvuWvgOW/gjSaeoSw//9cG4sN6WKeQweRqAr5se6svogAEIicPoXiUX3TUiNmRTk4ECoWOYHrP/WU0KtF9ctZ44Kz0cR7bAKndkvvHuCBGgTYe8wzGL/1SGVKc4itZU/E2vJKKH8InoE0Oek=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 12:54:58 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 12:54:58 +0000
Subject: Re: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210310111921.928619-1-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <70e3aabc-6bb0-b88c-0e97-de42e1e8b8e6@amd.com>
Date: Wed, 10 Mar 2021 13:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210310111921.928619-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ab69:e3f0:8e97:e79b]
 (2a02:908:1252:fb60:ab69:e3f0:8e97:e79b) by
 AM0PR01CA0136.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 12:54:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ff84b95-7781-4f0d-7772-08d8e3c3b581
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25456AEF634ADA614DC8A0B983919@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ+HMxDmtaDOF+FZQR+LOn7ZlnmxIk43KBRjx6pAZuW+stR4EzFz4Cy+b5nwwPA4HAABAImP9RHhleZp6fKD2v8Degm/D2LyCSJ/oSZjpEPV2K2DcHJVln8CTGjJPOMpCEYpPXVhR0a6LLj0ir9fPvMMInaEMaAkUzhSZN5PnUxE08pmyTdtRctChjtRl/Y9j44gcpCGkssBIcN7oYfDTrV4PO+BC6HsK7u0uF368j2yl0D6vCDNY4BZn6Vthe/wWC1oU9a9+IWt0fXr/EDFUvszdqh6iBek+L2uIGegmR8W6we1LNL+ObOh4YR3CiGSXgEf64Imn/0N4hlFp/bOseHk6Usr0W9ZfS0KLL0jf44cWtKf81auqphIkacyeaj121boY4UAXc79/JzdTGPaSkgy7nCHViz5Etmnaq3/A+w5b4lWXWA/7NMQE0UCMooKJkW48Y+o670n+/DPdxUr8EkwfB1ae+6w3LSXMzRHNEQadmz3rGGpsfyN3K5ffXz7wW3poU3PKVGjXKsQvxXCsnBlhvcEB/6YRyphNkBy70TUctVWpZwdYa+04WEgmbp7LRXrLpNM5RSEj6qJRRWFbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(8936002)(31696002)(66556008)(6486002)(478600001)(6636002)(86362001)(5660300002)(36756003)(2616005)(8676002)(6666004)(31686004)(186003)(52116002)(16526019)(2906002)(316002)(83380400001)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cy9RdnEzNVRVQ2V0Z3lOV1VtbnBYVmY5TFZnTCtVV2M0YlpyVWpuK2RIZUdt?=
 =?utf-8?B?ejFsMDVuVitrTlk5aVZBY29TNEZtTVlkd0U4b09QcFB3MTRQWkFVUE9LTEE3?=
 =?utf-8?B?OWtUZVFlZlRQOWFPV0h1VTJ6S3lSaFhTZGRadVRSaGU3azhkc3k0NzRMYzky?=
 =?utf-8?B?OVc5TS93TFNGYjRWdjBnb0dqWWltSTIvUlkvd24rb0lJUUJjWTRHeVduRm5m?=
 =?utf-8?B?UExQbk9OTndUWWg5SmxQSDh0R1RkNi82bmRmWU9ydjRZMnRJb2Y3N2prcE5a?=
 =?utf-8?B?eXYrSmx0Nkt3QlpKUFdiNjRUNlhYc09NUG5tc0xJclhUdDYrKzNFNnhLZTJm?=
 =?utf-8?B?TEhCL1diQVl3QjN1aGN3SDBKVTJtaDdsbkJGUTlRMWMrNXkybHRaMnplRU5Y?=
 =?utf-8?B?NElBTjJ4TGN5VWRTQ2NESDJrancvc0Z3UlA1dkRMcXpFamN4Rnk3Z0E2TXlM?=
 =?utf-8?B?RHVXN1kzTTllcnFLbk5vS1dSYzhmcVVnWkhrdUVjaE1qSzJYc1dNNlI3cGJW?=
 =?utf-8?B?eGtFVXplUkliRjNPU2hJbWZLcUZYeDBkYjdPK1ptVWpLVkJKUTdRcHY1NTVD?=
 =?utf-8?B?ZDdWVm5laThtWVZWSHhCWi9Hd2lueVlEKzFCRUZnMGNyNWFwU3ZrS1BhejBz?=
 =?utf-8?B?S09OTTB4REJhSDRjQ3F2aTJSTmlQUVpQTkpweHoxbzBlZlJ0eHNMUkgyR0NW?=
 =?utf-8?B?YVdJYzVuRWpTWVBrTmprNmp2d3JWMm5ueC9OS21tT21JV2JtVnRGZ1ZXdlk2?=
 =?utf-8?B?YWhnZURQTEpIcjZlSlorVDhOaTZoZ20xemFnTnl3MkVybHd2NzNVVmVFZFJO?=
 =?utf-8?B?aGJZb0MwSkJWNk5ObU1RSzFSUDlFK0Z4ZGIrNWNPNGFOYnFyTUsrdlNhWEwr?=
 =?utf-8?B?dnRENVlmZ0R5cXlYendZR3Y1WmZtdllvbVp5cTMrUnVwRlFvMVVuQ0tPbTNp?=
 =?utf-8?B?SkgrMDFSQXUrQTZVRHFvSnZwS2hGMUV1dnByZEdKdDNoWmhyaDlRL2tBcjNG?=
 =?utf-8?B?dGN0SFpocERWME1XR1A1NFRqazJrNzhMZzZjcjhzRVF2R043aVVWOG1KNW9P?=
 =?utf-8?B?ei9RNk1hN1JNeGozQU8yU1hXSEVYTGp2cnZyckw5bTJKQWNGZng2aDVmalY0?=
 =?utf-8?B?eGdLMm1qNmEzNmRPeVVibFJBMVc3WUppb1hwLy9RTnV2ekVYblFIc3hzVXRj?=
 =?utf-8?B?YzBQdGtxb0NNU1JKTUFxeGNQdTV4RTNXR2wvVnhRRXYweWlzZDVjZi9tcUtF?=
 =?utf-8?B?RDZpWHordE9COXpRVGs2ZnZYRXVFcDFmSno4WG5ITkhNMm1sZmlYdHdBZ3hh?=
 =?utf-8?B?b1YzZzl3OG5PSWM2YXBCWmFsb1ZLbURHYVV0NG1RRjcrTHhXbnFMZkE1VGxP?=
 =?utf-8?B?S1YrVDhQaXN6dmdkOGZvbVhxUjNGc0x6R2d2ZS9uRkJDeG82dktUV3hkRmxP?=
 =?utf-8?B?VlNhMFNxWUZiUit0V041U3FyWk40dElEQkIxVWEraExwYmY5OGV0RzBDa3Jt?=
 =?utf-8?B?OWEwVjJVcDBQWGdJejZPa0cwam40b2NVRHAxWjEvMlhvUXp2amMvRTVZczdV?=
 =?utf-8?B?VUhlVzgrWlBoZU4ySDFCS0dubVVTNWpzQjdIbnp2TFRjUm93SVdYb0dyV0tK?=
 =?utf-8?B?dzBGMi9uSTE5cHpoV1lDQWFyL1owSmt2Wk9KRE1Zcm1ialNGZ2lpNDRFZFFB?=
 =?utf-8?B?RDBhL1FzTzVVT2c4QVZ5QktFUTJHVm8rUzcwOFhOaGZodEFEbjJvSFBkc3RI?=
 =?utf-8?B?YjlDeTZxbThadFRiaDVWS3JxNmpUMWd1RSs4M3JkWncvZ3lENnB2SjM2WDlv?=
 =?utf-8?B?b3laMGszUHdFbDZ4RExEYmZ0MEJKRXVjMEphVFdpRURkZDlnRFIxbEZZTUJz?=
 =?utf-8?Q?hJbUu1eYnQlqV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff84b95-7781-4f0d-7772-08d8e3c3b581
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 12:54:58.0311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTChNuIg9ms2fraX+TLXevIFqiAmisk6DUV74MGfDqMEFaE2EohtvdZ5yITX2LRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.21 um 12:19 schrieb Jack Zhang:
> [Why]
> Previous tdr design treats the first job in job_timeout as the bad job.
> But sometimes a later bad compute job can block a good gfx job and
> cause an unexpected gfx job timeout because gfx and compute ring share
> internal GC HW mutually.
>
> [How]
> This patch implements an advanced tdr mode.It involves an additinal
> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
> step in order to find the real bad job.
>
> 1. At Step0 Resubmit stage, it synchronously submits and pends for the
> first job being signaled. If it gets timeout, we identify it as guilty
> and do hw reset. After that, we would do the normal resubmit step to
> resubmit left jobs.
>
> 2. Re-insert Bailing job to mirror_list, and leave it to be handled by
> the main reset thread.
>
> 3. For whole gpu reset(vram lost), do resubmit as the old way.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
>   include/drm/gpu_scheduler.h                |  2 +
>   4 files changed, 148 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..02056355a055 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> -
> +	int	tmp_vram_lost_counter;

Please keep the empoty line between declaration and code.

In general give that patch a pass with checkpath.pl since there are a 
couple of other place which needs fixing at first glance.

Christian.


>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
>   	 */
> @@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
>   					job ? job->base.id : -1);
>   
> -		/* even we skipped this reset, still need to set the job to guilty */
> -		if (job)
> +		if (job) {
> +			/* re-insert node to avoid memory leak */
> +			spin_lock(&job->base.sched->job_list_lock);
> +			list_add(&job->base.node, &job->base.sched->pending_list);
> +			spin_unlock(&job->base.sched->job_list_lock);
> +			/* even we skipped this reset, still need to set the job to guilty */
>   			drm_sched_increase_karma(&job->base);
> +		}
>   		goto skip_recovery;
>   	}
>   
> @@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>   
> +		if (amdgpu_gpu_recovery == 2 &&
> +			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter))) {
> +
> +			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +				struct amdgpu_ring *ring = tmp_adev->rings[i];
> +				int ret = 0;
> +				struct drm_sched_job *s_job;
> +
> +				if (!ring || !ring->sched.thread)
> +					continue;
> +
> +				/* No point to resubmit jobs if we didn't HW reset*/
> +				if (!tmp_adev->asic_reset_res && !job_signaled) {
> +
> +					s_job = list_first_entry_or_null(&ring->sched.pending_list, struct drm_sched_job, list);
> +					if (s_job == NULL)
> +						continue;
> +
> +					/* clear job's guilty and depend the folowing step to decide the real one */
> +					drm_sched_reset_karma(s_job);
> +					drm_sched_resubmit_jobs2(&ring->sched, 1);
> +					ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> +
> +					if (ret == 0) { /* timeout */
> +						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_job->id);
> +						/* set guilty */
> +						drm_sched_increase_karma(s_job);
> +
> +						/* do hw reset */
> +						if (amdgpu_sriov_vf(adev)) {
> +							amdgpu_virt_fini_data_exchange(adev);
> +							r = amdgpu_device_reset_sriov(adev, false);
> +							if (r)
> +								adev->asic_reset_res = r;
> +						} else {
> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
> +							if (r && r == -EAGAIN)
> +								goto retry;
> +						}
> +
> +						/* add reset counter so that the following resubmitted job could flush vmid */
> +						atomic_inc(&tmp_adev->gpu_reset_counter);
> +						continue;
> +					}
> +
> +					/* got the hw fence, signal finished fence */
> +					atomic_dec(&ring->sched.num_jobs);
> +					dma_fence_get(&s_job->s_fence->finished);
> +					dma_fence_signal(&s_job->s_fence->finished);
> +					dma_fence_put(&s_job->s_fence->finished);
> +
> +
> +					/* remove node from list and free the job */
> +					spin_lock(&ring->sched.job_list_lock);
> +					list_del_init(&s_job->node);
> +					spin_unlock(&ring->sched.job_list_lock);
> +					ring->sched.ops->free_job(s_job);
> +				}
> +			}
> +		}
> +
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 865f924772b0..9c3f4edb7532 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>    * DOC: gpu_recovery (int)
>    * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>    */
> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>   
>   /**
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index d82a7ebf6099..99a6a8bddd6f 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>   
> +
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
> +{
> +	struct drm_sched_job *s_job, *tmp;
> +	uint64_t guilty_context;
> +	bool found_guilty = false;
> +	struct dma_fence *fence;
> +	int i = 0;
> +
> +	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
> +		struct drm_sched_fence *s_fence = s_job->s_fence;
> +
> +		if (i>=max)
> +			break;
> +
> +		if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
> +			found_guilty = true;
> +			guilty_context = s_job->s_fence->scheduled.context;
> +		}
> +
> +		if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
> +			dma_fence_set_error(&s_fence->finished, -ECANCELED);
> +
> +		dma_fence_put(s_job->s_fence->parent);
> +		fence = sched->ops->run_job(s_job);
> +		i++;
> +
> +		if (IS_ERR_OR_NULL(fence)) {
> +			if (IS_ERR(fence))
> +				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> +
> +			s_job->s_fence->parent = NULL;
> +		} else {
> +			s_job->s_fence->parent = fence;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs2);
> +
> +
> +
> +void drm_sched_reset_karma(struct drm_sched_job *bad)
> +{
> +	int i;
> +	struct drm_sched_entity *tmp;
> +	struct drm_sched_entity *entity;
> +	struct drm_gpu_scheduler *sched = bad->sched;
> +
> +	/* don't reset @bad's karma if it's from KERNEL RQ,
> +	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> +	 * corrupt but keep in mind that kernel jobs always considered good.
> +	 */
> +	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> +		atomic_set(&bad->karma, 0);
> +		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +		     i++) {
> +			struct drm_sched_rq *rq = &sched->sched_rq[i];
> +
> +			spin_lock(&rq->lock);
> +			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> +				if (bad->s_fence->scheduled.context ==
> +				    entity->fence_context) {
> +						if (entity->guilty)
> +							atomic_set(entity->guilty, 0);
> +					break;
> +				}
> +			}
> +			spin_unlock(&rq->lock);
> +			if (&entity->list != &rq->entities)
> +				break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);
> +
>   /**
>    * drm_sched_stop - stop the scheduler
>    *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..01c609149731 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> +void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>   				    struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
