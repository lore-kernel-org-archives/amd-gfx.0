Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCF3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDC964F4A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDC964F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FE36EA46;
	Wed, 10 Mar 2021 16:19:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34A86EA45
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwnUz+YClgzC476mHtNLkJ2Dt2nlS71x3NhUGPI152Gge7PJElThFXI0CzVJJ3q9wXBLN2gjqR2Qk0YksPNvZFb4ibc5QYsL9H07tB10dZkrGb27dGq2qtCeXXwYtd5SmQo9FsgukIJx6jQBtkvEZTpH5r+VWUCVZ7Gdu8sgUM8rP/KwMM7q3A03SrZyUHj8EPNNjisKaGB+XCiYlNVh7P9qdlE4IN1mmO7ddIJowBfW73QYQEpFq3AA3WNojzer2e4jTI4mod6PBEKBXD5HVqMNrwQrGPU5Ntjmde1aHaEpSgi7INwq66NX5du6UpVEKq9Kwv38504YnEtYymp6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOSyRiXlmgW4S37UhCK58EClHbO1rDkGxtI8IBd/N4k=;
 b=EyQStq9RPfKyemyD9+lXLiFEqIHvcWpfHH4k6nsTKb8z5agLLzRiOt/W6x5zIE5RObOIQQnWyUgnR2adMaRNN7fmrysW7bHc2awjUeVaXwmWyzUHzAlc62/B1+sMm5MeZ2b7IU9Fqt8OwYngKcWSwJWd3K+9esomCQqFN9rrslBXzeAkhr+kYSYXjnOs3ecP0qseumT6KiHdel8bvAsVF85czyyUCA1aPnufOXDD/X494h4X4feV0AEiontuShiMwybqKzqtw3PNRboqCqfw9j6NGg2Z6DxRwWopo6WNT8ggZILQ1MTFYZe2afNFIkuBlPTayEamGgfmvHYkpkSHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOSyRiXlmgW4S37UhCK58EClHbO1rDkGxtI8IBd/N4k=;
 b=E1hw2VvOjKmwDpRTmjK2iHWV2NipQiMlTwlYqoK1EBOwLag1ikgFelx5hqcmnvqPgMvVYcqUujpMo3dgGZuGQxeZDVxqhcdc/t9XCdmM9vefOguiAzD7Uu+4BacIt62QcydcEmoHmyoKshpDBLKCctayaKxVPvEIj/qRUQVYTbM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Wed, 10 Mar
 2021 16:19:20 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 16:19:20 +0000
Subject: Re: [PATCH v6] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210310133302.933854-1-Jack.Zhang1@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <8c1b4379-6068-e2f4-5994-531d731548de@amd.com>
Date: Wed, 10 Mar 2021 11:19:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210310133302.933854-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:3be2:526f:398d:9ce8]
X-ClientProxiedBy: YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::29) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:3be2:526f:398d:9ce8]
 (2607:fea8:3edf:49b0:3be2:526f:398d:9ce8) by
 YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend
 Transport; Wed, 10 Mar 2021 16:19:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffc07091-023b-4ae4-4a8e-08d8e3e04293
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB444884CA157D49EBC95D60F9EA919@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OrzIdBqrHtGN/Cl7XqmhOx3baj4TQVhqO8PUoJznqTMydLUU6E5qmtt9hOvcONsoJIuG9ylfzKyDQnPKh/e/obWxW8wedD/i2V+DIDPi3fkDbPGBvePgof5/38NTZ4HLquMUEgzUr1GuKSjm8ksGm6NSWTgxCOQEP8QYpvHvta4uh/NWhzW6THYiz4FBF9ibWZWG2Baiq9CCujVXWLcvDmZu9cC3by7rZTgz26/YPlv8was9JkkeCrxCxd9w4I31nlbFGomKjQ3+kyZJjQeyPnzEJK0jHBEmBGgeR0ZkH/fC4M5BUs7rJTVGmPIDnE78KaZP1hytkiIUfY/IaM2AdJ6csbcyTtHy1ozb5OJqBOWuV43RkbQzNTKUPFv7Vs8WTsqzGprG1+wPZAU6cfXR9TMZneBwFADGYUHMO40f7kUeoVL5wcurj2cJMmUmxRzJak0LqwZgHpllJlO3qvgkjRBJj5f6tKM6f3JwepAFg0UuT/ag0K5kErOiSmXQrVIPX3juEfZKwjwFFVqIKi5qYeTQzsJ4BEnbibWbQRrANI78BlYEP/BauWros1qAu/K4qiQUJu+Nj3tloLiEDchd3oOi/D3STFaobhVhED7cpH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(6636002)(6486002)(8936002)(5660300002)(31696002)(66946007)(8676002)(53546011)(66556008)(86362001)(30864003)(66476007)(16526019)(2616005)(478600001)(36756003)(83380400001)(52116002)(31686004)(2906002)(44832011)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RCsvRjd4V2t4WTAyNVNHUFRzVEdNMWUwRjJlcGg3N0JSSU92MXRhNlB6WmI3?=
 =?utf-8?B?MmF6S3FLSFNJdlBudmRvTkJNZ0FKaVhuQzFObWVZNFhYd1lXN0d4QVIySkxo?=
 =?utf-8?B?R096bzZieU1pbktTa2o5NWl6YWhEdzhXUHF5OFhrQ2VuWFJKYnFxRGd2QnFP?=
 =?utf-8?B?Y1g3bWRET3lrVGlqcEoyeXNpWHNnRTJmN3hXeHBWcTUyMmx3eGhzbng2dlhE?=
 =?utf-8?B?SFp6Y2Z5MVRqOGNaZEs4Z2VoWGNxZS80b1RVaUxIa0pqMFM4Q3JLREloeHlG?=
 =?utf-8?B?cTR4M0swS1ZweEFyM0xkTStDWjNtcysrZFFEa1BKWUZQcEN1K3I3aXlKekZF?=
 =?utf-8?B?M3dyRFI3SXhGMG1ic1dWSC9OVjFXVEJ5cUM3TEphMW1GM1huK2VORnhrREk5?=
 =?utf-8?B?K2dlbmhUdHF3SDd5bk1ZN09ZVE5zbzBSaHAwNDMyMUFzZXZ6UGsxUHd0aWNO?=
 =?utf-8?B?WTg3c0RLOGxzek9wQTFkeXdpUDgvQlZCVTVnUWFpVGpRdGRLWS9uUDhIanZK?=
 =?utf-8?B?RmUyODRZbHREeTN4dU5aY25MRWMxSzRyWWNzRVVzVVcvd3dxNlRpbkVxcU8r?=
 =?utf-8?B?Q3A0dklpSS85SjlxcWhuZTB3cWREUElkYWF6V2ZTQUNqRVY4RU9ZOVdjbzZV?=
 =?utf-8?B?Y0hzNkNPNVFwbzk1c3lqOTdvWWF3T3dtbTZORmJzU21mZGU4MnFSaVg4cXlY?=
 =?utf-8?B?NzlRMHFYVGFTYU91aGZuck9hWWFSNmF5VFpab0lnSmJkWkZUT20vYVo2RW9N?=
 =?utf-8?B?dmZnaGJES3I3Unk4RGo2Skp2UDNGekM4RjFTUjJoUXlUUTVxdEJNVDNsd2Rt?=
 =?utf-8?B?cVpyYzc5UUlLdGRJQlhFcnR3dDZMME01Mnpnd1ZtRnlhSjQ0dEh5RlhrUFFU?=
 =?utf-8?B?OXBLWGJQOG5JQXl2N0NDc0NBUFV1SVdvZStWU3habmNlNi8vazNxWURla1J3?=
 =?utf-8?B?bUdDK3hDWWxPdGdNd0xuKzUrUzRjemtLS1MvajVYd3VCZjZraFU1aThwNEZB?=
 =?utf-8?B?RFduL2FqWjV3N3dmTGc4cHNnMmhRN09GMlZMejl4M3VjNURkUWEzVzhIenBQ?=
 =?utf-8?B?V1dWUUxkRkdoNHlIb2hlaitNTEIrd3ZvTGkzcFpYNmZYNG1UM2M5WDBwZTR4?=
 =?utf-8?B?emd1OFY1SDFQSTF3TDlCbFR1U0NGazlPNyt1djdNVEVOUVRzWGJicU5sSm9v?=
 =?utf-8?B?SVNVOHMxcE5scnNETnplbTNMajF0RVdrSkRTTVVFcUhzUnpMM2Q3TXBwb281?=
 =?utf-8?B?SGRrSEkyK2hHOUxOT0h6clJQVzQ1RVg2ZXJvcEQ1NnVkT25XckxwWmRweTl2?=
 =?utf-8?B?a09SNDM5UWVkRUFBdVZYVGVGTXk3YWV0dEF3R1FDSkpVWTQ0cHNsbTF3MDhG?=
 =?utf-8?B?MzFFUVJ0T3dhc0VybVIzamtqVmhlUkUyUEZaVm1iOHZIbllOaituekYwMkNp?=
 =?utf-8?B?eVNzMkhIbHNNNHQrNGdyd2JTYVU5NUJYM0JqQWJEem42UkIrM3VaNWlqbm9z?=
 =?utf-8?B?S2NXcGU4ZUR3Z0NIS3Uxcmk5bmxhaVJ4Z24za3p4WmFnM1lXRkRmc2hFbEY2?=
 =?utf-8?B?UDNnVGlWZTB4WThXcFZ1WENqc0RlSzE0dE5URXM2bng2NFdEc0wxU28zR1E3?=
 =?utf-8?B?V2VQQzY2L3d1V1JLa3l4TmFlYSs3SEVENnBrMnpwZkZtVktrSmc4YmVVWHJo?=
 =?utf-8?B?WVgyYm13bml3KzZqV3FFM1VhV1pNcTY1YWNYdXZSVUNUcjQ0RUJIQTZKOHBU?=
 =?utf-8?B?cldYOUpEMzRJU1V4QUhvczFrVnNUL2RrRFVLbUxGSGRyaUYyOWNKakM5dVdt?=
 =?utf-8?B?QjRzT0F4TkdWaDV6cmJBRUlLSUVRbnc1NjZ3YmhKNG9oNXh2ayswNDBIQnBk?=
 =?utf-8?Q?p8+xwO6WfKp0x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc07091-023b-4ae4-4a8e-08d8e3e04293
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 16:19:20.4442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WXkgbUJqNeUUnULHX7NDzayrUxgQZXWd+9kwn7U27tyrC0Pl6WY77+FfVZNVTik40ubOq+Hz1AUQO6Cm1mYKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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



On 2021-03-10 8:33 a.m., Jack Zhang wrote:
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
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
>   include/drm/gpu_scheduler.h                |  2 +
>   4 files changed, 148 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..dac0a242e5f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> +	int tmp_vram_lost_counter;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -4689,9 +4690,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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

I think this piece should be in a standalone
patch as it comes to fix a bug of leaking
jobs and not directly related to find actual
guilty job. Also, this is not the only place
where the problem arises - it also arises
in other drivers where they check that guilty
job's fence already signaled and bail out before
reinsertion of bad job to mirror list. Seems to me
better fix would be to handle this within scheduler
code by adding specific return value to
drm_sched_backend_ops.timedout_job marking that the code
terminated early - before calling drm_sched_stop and so 
drm_sched_job_timedout
would know this and then reinsert the job back to mirror_list
itself.

>   		goto skip_recovery;
>   	}
>   
> @@ -4788,6 +4794,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4812,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
> index d82a7ebf6099..340a193b4fb9 100644
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
> +		if (i >= max)
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

This is identical to drm_sched_resubmit_jobs in all but the
'int max' handling, can't you reuse drm_sched_resubmit_jobs
by passing max argument==1 for the find guilty run and then, for the
later normal run passing max==MAX_INT to avoid break the iteration
to early ?

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
> +					entity->fence_context) {
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

Same as above, very similar drm_sched_increase_karma, I would
add a flag and just reuse code instead of duplucation.

Andrey

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
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
