Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90197C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 10:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268EC64FC3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 10:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268EC64FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695D46EB7E;
	Thu, 11 Mar 2021 10:41:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3F56EB7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 10:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVTn25HaV1JouOgcb/h0ocdqeT8Sb+CwsR2Id9MJMG0ymqo3HfgDDcJ16Fbzy8KQzeJaTckaa+14qIOjQSzmZDeA5o05SUSjj4q5QSDP8wGkBhb+NTKZ6qHulrQxQEvwieuUxbXMP+TWfR07o9iUL4cmSioxiZA2kdLcpWqL00f2sA2ifIMeyn4SaN2exAVlqM++AITbBtSFeoqvlcjKDwbd1Pr/29eT2rSOIM0QtrBhJweJd53R27ZkwwqduHl5ny1RmmeCZnW+lUpTz6EeRUT0bf94dPfeFwr4wSIlpGI1k7P98yoEQBh8GuA74+RpHmzTlHmix/pNyq6nElSicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZTVzfGSFMBCPcyemoxuauSQqTQasu1rvroUKOEnWSk=;
 b=hfRVbcJ7iMEpO9nAUpbFJ9mtV4HvpiZi6CORDZqR2GwQHQhGhUc4nyfIIu2esGQmGJ2ry6lXGeF6qCOsV1fj0RWQAfVdK0lZqZOgWzs9frMxbheV+H9RZRIRchKNEFg8MgEGXhCBLVl5PV3LANBmPZkgeTOvk5ANRhWuyrhb7exJ3OaXJc7EUtKazGcKrcGqmrC0rBYvcs9PGmwI4X6ESbsW3yoC1y6os/HOTXGCju7NAvUfAZlsZkDnPUS77w0L800gjIy65GZQcCChf+isS/JQ7oWyhodXaiG9ggi5HGAK2t38eBrWAAbl8Atv/GIReK33wSPm846OkUcyyP+cjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZTVzfGSFMBCPcyemoxuauSQqTQasu1rvroUKOEnWSk=;
 b=WYga5XN5onQzpJ3/6eP3Ov35Upqi+dpGXkgUp4kO93Vz0On/FEhT9y7I19p4p2BlSt4/boJy10fNVz5wUj2ZiUbJQUfpTGVV1eD7OTUkCgk0qRmYm26CSomh1VjeNOEPdD+T0YQoZdX3jfAgPR78OaC8wpD9Om20KYU/r8tUv94=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 10:41:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 10:41:11 +0000
Subject: Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Andrey.Grodzovsky@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210311055838.980188-1-Jack.Zhang1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a7108500-6d23-f674-959b-94fc988ba3af@amd.com>
Date: Thu, 11 Mar 2021 11:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210311055838.980188-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e21c:b1e1:cff0:2c70]
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e21c:b1e1:cff0:2c70]
 (2a02:908:1252:fb60:e21c:b1e1:cff0:2c70) by
 AM0PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:208:d2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 10:41:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbf41425-fdc2-4fb2-9083-08d8e47a2f86
X-MS-TrafficTypeDiagnostic: BL0PR12MB4900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49002E754327BE09B866496683909@BL0PR12MB4900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTnOFRZQRDqGpEABfkLE80E7ypCKCVLKXkwU4jy820jSSDKRPIuXLSFZ3uokTobNUTtpsbhs425XlxHDneE4wAOcwXMYD6toFGT0TiS4qi4xS8qipDQQH1/sOW957pu2+zm4u0l6hxwkcb1lbhyRJ/ENxv5hoF2cuERWIFhzgNWzwC3/tJGxWAf/RAXujg8pJT4Rbgq8op82bQ9mrqLJkO0D7nx+UJgft/Xb35MeIAsojkwuZEIh4EPQfYmH516S7vCbf8soDbaX7+GA3ial0Snvbqgb+kLD2t1nqIdeOCBN4QCLCYBYgUgXJb9U8kTKZ+CbzjUcn8bZcPI6DOx66snNRtv6bCzaKFaztOXFdyjnJHaIJFaw7HqXk32G4n9KkuSvmNPai6rHpKO8eMI4P+P8+u0pHe6iGU9Mne9xkZaFy9WJ28m50KW0u39QA3f8qZYUTwb6ByhvZLITqW8NfL+A3U5/xfCKDErCtlxbK9ezZ6WQ5RXVMTh4z1gem6klIWaPBqOgOQO+aI+2sr7CLYsWY9DOGGauDEuNZdk2No3ID+oxE0eO0d740YH9DrtfIZwFajVrpiSUhGVVo741TJCQoJZtcMsMdihYVoVIN+aQg6TLjygNA+bfrLRVr6lwUzWHNuvZou+vKlelLOS4Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(31686004)(2906002)(6666004)(16526019)(186003)(6636002)(66946007)(66556008)(316002)(478600001)(66476007)(8936002)(30864003)(83380400001)(5660300002)(52116002)(86362001)(31696002)(36756003)(2616005)(8676002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eUtCRFljVGlIYkFhd2ZKTFZ3UFlERVp1MUFTV1pYcE9lQzNDKzZBN0dzZ3o3?=
 =?utf-8?B?L2Q1MTQrODgxTnFhbzVpVEEzdHgvMEpsUG01dTNQdkY2RGJSQXFkSzk5cnZy?=
 =?utf-8?B?ZXJ1RytIYTJIMmc1YmJ0QnBDZFA1YzlhU09paTNQRHBLWkJDWDZBRUhiRkFP?=
 =?utf-8?B?OWF6Ukd5YmFGUFI2a2dLb3lwOHpINncxb3A0WGlvdFJyaFZNaWg3Wm1MbnVX?=
 =?utf-8?B?RGFpVWpxbzlOL1VOUEV3ODFFMGovUUg2VjdxWTJWM0VFd0p5aDhMR2JOZTVH?=
 =?utf-8?B?VG9DT01uS0tmYnplVndua1VkdnUwQmtiK1RId3ppQ1J1S3dZQy84UnRYdkZO?=
 =?utf-8?B?WHZyVUVVOUp2WmNqOCtDNlA1YTViNHZlbzFxTWRjSGVRY1ZqTXNIUWs0TEJl?=
 =?utf-8?B?Ly9JdURaVjZFbTFoZDNNQVdXd2xEMzV4akJYdU5ybnU3Wng1L1NHbzYvbGVX?=
 =?utf-8?B?NnMzVmRTYzlqcU5hWnVpSHFGNWJqZWNiSS9jRDVVM25MRDhtT3daa251UlFu?=
 =?utf-8?B?amJuakx5TFhvUHFuL2VrUU5JbnhrYm1PZ2c1WWIzM21uakhuRERJUTNYU1Z1?=
 =?utf-8?B?cUVvQ002RDZwbkIzdWY0c0YvNktwZ2c3MFJ6STc5Qndlb3lUWnpmbjRMNDZy?=
 =?utf-8?B?NmlBQ0s5VEdpZGpwZ2pPM3hHemFLVE1zNnEyV1Bad1dOWFExUDdWTS9PeTRn?=
 =?utf-8?B?MWlHV3BpaGhFZTlER3UxNWdqS1dtRW5qbUw3MGZUdUdIaGNiY2szR2g5R1Mw?=
 =?utf-8?B?dEJGOEdRL0RVMHJ2TzhXSjdXSHFlYnF3WVJDRXJwQlhQTjdycXpXQW0zTU8z?=
 =?utf-8?B?WjVycSthWTh3S0x2bTY1RTZiYmJBUjVSVlZ1UFpDYkZlcXdKOTFSdzJQOEoy?=
 =?utf-8?B?Rjd0eG5iSHVIdG9hcUVvRVM3d09VNmpQK1p0ZVpUTnVobm5qUUZDQk9GcFV4?=
 =?utf-8?B?aW9jQmlKWXZDdG5IVEI5SGtyd2JpZzFKSldPUjl4TngwUHNVM0FBMnZLQzJl?=
 =?utf-8?B?Ri9lUk41Q2p5SmdkRGZrd3dwbDhsTWxMKzg0OHlWeE5VUEdiUUcraTkvN3l1?=
 =?utf-8?B?elptVTlrZENydEQzMEhUT3c0YS9jTjkrWDJYQmRDbWRPakhlK3U1Y29XT20y?=
 =?utf-8?B?TUdXcjdCdWtqWERwRVl6UExZSGdhR2JuWWZwMjdHNW9CTGgydE1Ec2E4ZzdF?=
 =?utf-8?B?VzlnRVpxbitHRG51VHZ4MVpEclcrVFZmZytoVHVmdnM2VTFFbDBrdnRLL2sv?=
 =?utf-8?B?N1RFUkZGMjc3aVpIcWtlaUZrNUowZHl4STdHR2pqQU5HbGQrODUvYVVMUTNq?=
 =?utf-8?B?b0U5Q0oxeGNSRW5mUWFLOHozRTNEWkJLaG4yZ3pLTThZUThLaTVTZG1EUzF6?=
 =?utf-8?B?U0UvTVlTZDN4Q1hjZ2hkQU9CZmxZdEF3K1l3dmdpZmgzZnBoRVVDb2NGcENO?=
 =?utf-8?B?YlY5QkNXM3BoRlZ1bDhOQ1p5dk5oWmc5TjBYZktURm9MeExsa2JoYzAxa1BV?=
 =?utf-8?B?akRWY2tHQXJGYTRJL1FxN2hoNjVTb1NjWlpoVUpkUzdVa0dUVW5qRWdRdXlm?=
 =?utf-8?B?NGVYWnE3aWdSdzllb3Z2dFFYaGpUOXowS2RaTzhtQy9ZYnpjejBRd3NIaHl0?=
 =?utf-8?B?RmdBa3BLZG9ucXExZDlHdzhQTkI2ZlBXbGkraVZQaFlHWmZ2eEJHZWxtMHpi?=
 =?utf-8?B?V2pmdk93VnUvRFRkSEpYUjJBMkdUOS9ZWUVTY0F6eE9WTlpZNkcrbGlha2I0?=
 =?utf-8?B?QWZEbk1DbTdVZXEyMVR6c2gxc2VvWEJJY0xzWnlsZ0tRVFVRY25kUnlUQnh3?=
 =?utf-8?B?Z3BDUEtVSzlESEFOeEJQblpBRVY1dUd2aFRkdnZlbG5JUDU0eExnNFFCU25s?=
 =?utf-8?Q?EMZphfYe9cK07?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf41425-fdc2-4fb2-9083-08d8e47a2f86
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 10:41:10.9065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqVY+UUfl5LR9dZ3+EStffxYNhURjjOXKsLOQEUGOYxPCQvw8HORtUUg2W358US9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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



Am 11.03.21 um 06:58 schrieb Jack Zhang:
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
> 2. For whole gpu reset(vram lost), do resubmit as the old way.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  63 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 107 +++++++++++++++------
>   include/drm/gpu_scheduler.h                |   3 +
>   4 files changed, 142 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..5b182ade26ad 100644
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
> @@ -4788,6 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4807,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>   
> +		if (amdgpu_gpu_recovery == 2 &&
> +			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter))) {
> +
> +			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {

Starting from here I would put this into a separate helper function in 
amdgpu_ring.c.

You should also probably use checkpatch.pl once more since a couple of 
lines below might result in warnings.

Christian.

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
> +					drm_sched_resubmit_jobs_ext(&ring->sched, 1);
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
> index d82a7ebf6099..bb0a129d1f40 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_struct *work)
>     */
>   void drm_sched_increase_karma(struct drm_sched_job *bad)
>   {
> -	int i;
> -	struct drm_sched_entity *tmp;
> -	struct drm_sched_entity *entity;
> -	struct drm_gpu_scheduler *sched = bad->sched;
> -
> -	/* don't increase @bad's karma if it's from KERNEL RQ,
> -	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> -	 * corrupt but keep in mind that kernel jobs always considered good.
> -	 */
> -	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> -		atomic_inc(&bad->karma);
> -		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> -		     i++) {
> -			struct drm_sched_rq *rq = &sched->sched_rq[i];
> -
> -			spin_lock(&rq->lock);
> -			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> -				if (bad->s_fence->scheduled.context ==
> -				    entity->fence_context) {
> -					if (atomic_read(&bad->karma) >
> -					    bad->sched->hang_limit)
> -						if (entity->guilty)
> -							atomic_set(entity->guilty, 1);
> -					break;
> -				}
> -			}
> -			spin_unlock(&rq->lock);
> -			if (&entity->list != &rq->entities)
> -				break;
> -		}
> -	}
> +	drm_sched_increase_karma_ext(bad, 1);
>   }
>   EXPORT_SYMBOL(drm_sched_increase_karma);
>   
> +void drm_sched_reset_karma(struct drm_sched_job *bad)
> +{
> +	drm_sched_increase_karma_ext(bad, 0);
> +}
> +EXPORT_SYMBOL(drm_sched_reset_karma);
> +
>   /**
>    * drm_sched_stop - stop the scheduler
>    *
> @@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);
>    *
>    */
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
> +{
> +	drm_sched_resubmit_jobs_ext(sched, INT_MAX);
> +}
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +
> +/**
> + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
> + *
> + * @sched: scheduler instance
> + * @max: job numbers to relaunch
> + *
> + */
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
>   {
>   	struct drm_sched_job *s_job, *tmp;
>   	uint64_t guilty_context;
>   	bool found_guilty = false;
>   	struct dma_fence *fence;
> +	int i = 0;
>   
>   	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
>   		struct drm_sched_fence *s_fence = s_job->s_fence;
>   
> +		if (i >= max)
> +			break;
> +
>   		if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
>   			found_guilty = true;
>   			guilty_context = s_job->s_fence->scheduled.context;
> @@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   
>   		dma_fence_put(s_job->s_fence->parent);
>   		fence = sched->ops->run_job(s_job);
> +		i++;
>   
>   		if (IS_ERR_OR_NULL(fence)) {
>   			if (IS_ERR(fence))
> @@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   		}
>   	}
>   }
> -EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> +EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);
>   
>   /**
>    * drm_sched_job_init - init a scheduler job
> @@ -903,3 +897,52 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   	sched->ready = false;
>   }
>   EXPORT_SYMBOL(drm_sched_fini);
> +
> +/**
> + * drm_sched_increase_karma_ext - Update sched_entity guilty flag
> + *
> + * @bad: The job guilty of time out
> + * @type: type for increase/reset karma
> + *
> + */
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type)
> +{
> +	int i;
> +	struct drm_sched_entity *tmp;
> +	struct drm_sched_entity *entity;
> +	struct drm_gpu_scheduler *sched = bad->sched;
> +
> +	/* don't change @bad's karma if it's from KERNEL RQ,
> +	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
> +	 * corrupt but keep in mind that kernel jobs always considered good.
> +	 */
> +	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
> +		if (type == 0)
> +			atomic_set(&bad->karma, 0);
> +		else if (type == 1)
> +			atomic_inc(&bad->karma);
> +
> +		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
> +		     i++) {
> +			struct drm_sched_rq *rq = &sched->sched_rq[i];
> +
> +			spin_lock(&rq->lock);
> +			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
> +				if (bad->s_fence->scheduled.context ==
> +				    entity->fence_context) {
> +					if (entity->guilty) {
> +						if (type == 0)
> +							atomic_set(entity->guilty, 0);
> +						else if (type == 1)
> +							atomic_set(entity->guilty, 1);
> +						}
> +					break;
> +				}
> +			}
> +			spin_unlock(&rq->lock);
> +			if (&entity->list != &rq->entities)
> +				break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(drm_sched_increase_karma_ext);
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 1c815e0a14ed..4ea8606d91fe 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
> +void drm_sched_reset_karma(struct drm_sched_job *bad);
> +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type);
>   bool drm_sched_dependency_optimized(struct dma_fence* fence,
>   				    struct drm_sched_entity *entity);
>   void drm_sched_fault(struct drm_gpu_scheduler *sched);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
