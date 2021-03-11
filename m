Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5CC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 16:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E6A64FA3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 16:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6A64FA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF0A6E520;
	Thu, 11 Mar 2021 16:12:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348026E520
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 16:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Msk3LlOR+GUt6HaJwuDzfvgrVsdJz2Pl90bKfUN8oGHHKeON3qheX8wJBMO5yAGfm23FHCiyeyOxflS9ZIhT5OSP6K0JVWA46HadDTbA6tx2pj9hRFi9nxrbWl0N37yBwInRJl+hARiGqepeOBKQ+V2aKj7neDoY4cEyRr0/F4VvGMo4dbvR7CUxhfJuyGlin9xRIXLbK/5JJp1SnjVfvwEA2j7vTnzxn0GSzrV+AZzhAoqqlh8ItOE/m0KErKitl8S/fVBS1i0L4m8KcDsSRL8wZ5hp9PG9zvQVzL41wcBGYd0N+p5Ej8A+sUvSKfqo0nQyDflTevww0lPz2QQ3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIEGnsP9rfmQu18jTGy8p5r3Usdb1C9IScv96rjrgU=;
 b=edqIey5h3XH7jBFCKny3nOckqmqO13tmfAMSBcAsNQBK36mUB+B/10zG+nGb/aQtgFLo5EoUVemq1IazoJy43RZnJr7v2WCqwoAf60viG9uz1wklbX2t8ZBsPX02DUOQXJXa1eh4nPzlccdaNzAPQcsse9LBv8Ak5CNbHTt1fbeb595tr6nykFZm7TceDM2bni8Yu0+TxZbwB0OOUhs9rAaetxLxvwbiqHkllAzdtMZOSeeBHMTANNK2yhf4j8EhvcVrxRbjGR5muieGI9oVMFzWFVKI8/86Cm8dehcVpb35G55Npk8JxqZ0JYynkYOGiE7mxuL3J1NvtaE9j0ZRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIEGnsP9rfmQu18jTGy8p5r3Usdb1C9IScv96rjrgU=;
 b=C9/JBz7gSFghqHHgyAyfdebEadOO4x3gExuQQI4rly7RFBxCpPX3ahwOMFCwyuwdgoKcn8AlVAIkeUEtCm/kZctvk36c7s2nlsud9ofTLujH+5auipJzu/WirYKj75zPhTrIk1oqAGBw1HnON7wJf4M7YZw5Lk1rZTrQvqrPAoM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Thu, 11 Mar
 2021 16:12:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 16:12:35 +0000
Subject: Re: [PATCH v8] drm/amd/amdgpu implement tdr advanced mode
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com, Monk.Liu@amd.com, Emily.Deng@amd.com
References: <20210311153751.1065528-1-Jack.Zhang1@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <132f99c7-7a64-5ef9-5b7f-88e7baba4b6e@amd.com>
Date: Thu, 11 Mar 2021 11:12:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210311153751.1065528-1-Jack.Zhang1@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa]
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa]
 (2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Thu, 11 Mar 2021 16:12:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2243bd43-54e5-45d5-bd20-08d8e4a87bc5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2352D700636B792F81BDF0F6EA909@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xuLzIrAWpaL/dh2W4UjFnOG7V8cfFEq6rqDMVtn7a/cNWfB1WT+b490YObq6hbgzW2ndLWvxBmH1V/Id5rZJ4Hrb6qQbOo5bJPcpY1g6V1H5FrgznK6fP+P3962jyr5nKQofOKTcuE3OzRkvhVYhzfSwT0B4aDxDkhEHB/wIZQDuzKvMgFkIfDll4Z/EXiuq7n3f0fQaOECIn+egICYmbNrPFPHnnhldTH7P74G+cRupgZ2Zf37O9LsOk15iqznvtAvwWCechQ8jY272JXxj+Ugyc9ISt6H7qIl8ld+RWlcpZLoJal6VNZlOV/+w2S3VXj7SALnRpCPRId0zh55NMtJLKdF9MBhav91fx6u8VcYZM5eNbybKUpu+8csHo9H1nVzJJm03ONK693BWf39p1H+A9yTyrpc4WiUJ4DHdH7jXHUEv+PnemOKYMHRm9N1swMgW2AOo+tXsp/hv1uv4D23YpKv1WhueExx1bUfhFwZFqws0TWBSmU3hvf74/yOEakxsW3O6vEJa6hRnE288VDvGQC8EBFKOPMnsHIbRgg+q+S0j2NqxebEF/REugMTKh2U0k72CpoUkpqPUZCvYauIz4ugnca0QL78KJ7SOJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(2906002)(8676002)(478600001)(83380400001)(8936002)(53546011)(31696002)(5660300002)(36756003)(86362001)(66946007)(30864003)(66476007)(186003)(316002)(66556008)(31686004)(6636002)(52116002)(6486002)(44832011)(2616005)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TW5nM1pwRFFpYUZXbTVUeW1KNVgrcHlDYkdoZGpzRlRCMHlxNjg3QVBxaVNW?=
 =?utf-8?B?YWxqMjZlc1VDbnNBeUpNTXdzY0pLM3owMWt2WDZhSVFHUHA3cUdlYk1XTDMx?=
 =?utf-8?B?eThzSUpjL3loVkxzblV1R25hREw4ZWZRdndsT1NnUURaTUZWV2dBNytXTy9j?=
 =?utf-8?B?aXh2UnRBTHVaV1lIZjhvRHBHTnhQVGVVWmZNRGpubllFZ2JPUFFWRXFhLzE3?=
 =?utf-8?B?SXoydm43aENTd21hS1dzWGl4SXFQSE41b2djUWM5YlQ0YVlkMHBpZVFieGVV?=
 =?utf-8?B?YVRML3dtbkdwNHVZK0MyTENyMk5nK2M5NERZeXVrL3RsQVlBd2p0OE1rNmxX?=
 =?utf-8?B?elk2U09RTjhqSHk2LytGTHNOY2lpcGQ2K0dkdFdjdk1hQnNXU1gwN2tKWWZa?=
 =?utf-8?B?OEp3NUhKUE5YRmFVUWZBekRoaGtaTkdHY0JqVDJFTDlYNkNSZUc1RHVmS1Fx?=
 =?utf-8?B?U3E1Qm9oUmFJdXdRb1JrQUtGQkF4VmN4anlZWkNoM2tDNk8wN2ZRazF2bUJl?=
 =?utf-8?B?MzhnOTdXczFzM3ZZR1lFYnNmRHY3TkM5RnFvMzdybWdaY282aXYxZTJGMzlV?=
 =?utf-8?B?VHRlSVBKemlxS2FqNUFIMDZoQ21YVG1nZkE4dFlXZzYwaTk5NWtad3ZOMGNJ?=
 =?utf-8?B?NU1YV0R4LzZvNEtBQnYvRExRNmQyeU1BL2kwTHJWVXJISnVRWGl5ZkR0cHdj?=
 =?utf-8?B?VUlwVTlhWWJKQjFQdzhJN2VDMjdEdTdwcXpvRElEMXhnYkVYMW1tMzFzQWxx?=
 =?utf-8?B?bHdnTk4rc2QxTDV1SUttSXlLTkxRTlo1SklIOXMrSnpETHF6OUVWdEk4a0tQ?=
 =?utf-8?B?ZXo5V2xzNXZaY01TbjNVeUJnc0txRGRPQ3paSENnUTdIY3JES1NIcmpkME1P?=
 =?utf-8?B?US85K2ZhSDJ0b2ltNzNPY21CQ0xvS2xmVTBWRGl3WGNmRDY0UnNvYmFpM3E2?=
 =?utf-8?B?OUZSaHkvQ0tWQnNOb0RwdDVOODdEcHk5MWdsQlVJS2k0QVZxSS9ybXJQT01L?=
 =?utf-8?B?YmVUVDdLMmxqWVZ6NTNXQUtVZjlmVExuOWNVUVVWUXlFSzg4SEp1Mm5hb2w4?=
 =?utf-8?B?ME9JTnJFRjhsQnJtdWwwbVB0MW5uR1ZKQmU0ajkwSm9STkdNSEZlTXI5L1pI?=
 =?utf-8?B?UWpJNmFzQWdmS2pzRkRyR3JuaEs1dDdaRmJsVzhvaVZVK0V5NFBnRW1rL2Zi?=
 =?utf-8?B?cG8vZXFwTjJETHQxL1BzdDRwN0xNUjQ1VzJJb0d6TFNSVWREVUpVTUhRSjEz?=
 =?utf-8?B?MlI0ODZWaVp2WmVIekQ4amp0OHFQd2hlL3VHL0ovQ0FZL0N5NnBWTi82UVZ5?=
 =?utf-8?B?WklDVHFtMWFyVHFjS3FKQnpjay9yRGVEZElXTStDdkxxMmlQcFFCREYwZ09P?=
 =?utf-8?B?RDBzSzNlL00vcnFrOEs2Z2hPSDZybjVGOW5KamdCMHdmcjZkOVZrcXhnU3Zk?=
 =?utf-8?B?WmU2VklyVXBXcTlTaWRLWTZaRWlkS1MveUlLZnI2S2xqVEFXQjlrZzJCQzZ3?=
 =?utf-8?B?bGt4eGk2V0Z5a0oyT3NEa0ZEMnFCSWN5R2pqSGNCVWEya0wxeGhGTDE1bGNW?=
 =?utf-8?B?cVZRT2RzUUdlcTU1amJkeXNZYml6bWtlMEJkVmk4aGJ6ME50K3czSGRpZWdG?=
 =?utf-8?B?bnFnTFlEMklpcXhoNUNpLzFWSVU3ZWkrTjVpcEJpcVZaeUZQTEFsdDhRTG54?=
 =?utf-8?B?enR6bEhnN2VyOHRYSDV1MmxKN2VkZC9vdWpxS3pNN1g0VWladytjSTBCOVlv?=
 =?utf-8?B?M2VUaVhtSXpHdGpOdFNqRFZycnhaNVF5NDRhZGg2TXY2QkllNW84TUNQTCtI?=
 =?utf-8?B?T0dTYTRYL0FualBCT25UWTBWOHlvWWdmR1ozYlRyeHlzaTVxNzdoUzZiRStK?=
 =?utf-8?Q?9CXYTOBYQmQ+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2243bd43-54e5-45d5-bd20-08d8e4a87bc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 16:12:35.6909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6JFUOWK47z6cL1ugEiP/KAIFaMGckJ6NqWd6Y0PgFN5tDsTmipNYUFnyBNKdW65d88Lu1glDYgcfHGKP/lDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
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

I would use a more meaningful name then
amdgpu_device_correct_karma and also put some comment
above describing the algorithm (just as in the patch description).
Other then that looks good to me -
Reviewed-by: Andrey Grodzovsky andrey.grodzovsky@amd.com

Andrey

On 2021-03-11 10:37 a.m., Jack Zhang wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  74 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>   drivers/gpu/drm/scheduler/sched_main.c     | 103 ++++++++++++++-------
>   include/drm/gpu_scheduler.h                |   3 +
>   4 files changed, 149 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e247c3a2ec08..01352ed725d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4617,6 +4617,73 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +void amdgpu_device_correct_karma(struct amdgpu_device *adev,
> +			       struct amdgpu_hive_info *hive,
> +			       struct list_head *device_list_handle,
> +			       bool *need_full_reset)
> +{
> +	int i, r = 0;
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		int ret = 0;
> +		struct drm_sched_job *s_job;
> +
> +		if (!ring || !ring->sched.thread)
> +			continue;
> +
> +		s_job = list_first_entry_or_null(&ring->sched.pending_list,
> +				struct drm_sched_job, list);
> +		if (s_job == NULL)
> +			continue;
> +
> +		/* clear job's guilty and depend the folowing step to decide the real one */
> +		drm_sched_reset_karma(s_job);
> +		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
> +
> +		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> +		if (ret == 0) { /* timeout */
> +			DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
> +						ring->sched.name, s_job->id);
> +
> +			/* set guilty */
> +			drm_sched_increase_karma(s_job);
> +retry:
> +			/* do hw reset */
> +			if (amdgpu_sriov_vf(adev)) {
> +				amdgpu_virt_fini_data_exchange(adev);
> +				r = amdgpu_device_reset_sriov(adev, false);
> +				if (r)
> +					adev->asic_reset_res = r;
> +			} else {
> +				r  = amdgpu_do_asic_reset(hive, device_list_handle,
> +						need_full_reset, false);
> +				if (r && r == -EAGAIN)
> +					goto retry;
> +			}
> +
> +			/*
> +			 * add reset counter so that the following
> +			 * resubmitted job could flush vmid
> +			 */
> +			atomic_inc(&adev->gpu_reset_counter);
> +			continue;
> +		}
> +
> +		/* got the hw fence, signal finished fence */
> +		atomic_dec(&ring->sched.num_jobs);
> +		dma_fence_get(&s_job->s_fence->finished);
> +		dma_fence_signal(&s_job->s_fence->finished);
> +		dma_fence_put(&s_job->s_fence->finished);
> +
> +		/* remove node from list and free the job */
> +		spin_lock(&ring->sched.job_list_lock);
> +		list_del_init(&s_job->node);
> +		spin_unlock(&ring->sched.job_list_lock);
> +		ring->sched.ops->free_job(s_job);
> +	}
> +}
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -4639,6 +4706,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> +	int tmp_vram_lost_counter;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -4788,6 +4856,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4805,6 +4874,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Post ASIC reset for all devs .*/
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>   
> +		if (amdgpu_gpu_recovery == 2 &&
> +			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)))
> +			amdgpu_device_correct_karma(tmp_adev, hive,
> +					device_list_handle, &need_full_reset);
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
> index d82a7ebf6099..92d8de24d0a1 100644
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
> @@ -903,3 +897,48 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
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
> +					if (entity->guilty)
> +						atomic_set(entity->guilty, type);
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
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
