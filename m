Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251BCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 17:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23801112EFA;
	Wed, 13 Jul 2022 17:33:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E28112DF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 17:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiNId/bxi2eg7gYmHZVPhE+XUry9NcNrkz5ocidSR/o3f3y6KGTAoQ1tK0Qnue+xtPyslbVuTz8TbqkLd98vdVX2LVuOd4HeYWotnLf0hPTQtb+gahO+5gerX7gCeR1QjV7oIk6Uo/V88sfqHSEICHPbg78uK3q9bY9r70L6rr83WOW2XLddSOfGe2/5tfDA8WtP2aCNHmMQ6T8RRMswlXWA6M5Uc/U4LxnCW5k9wY6zZsY6IAwh0oSLSR5ZqP0C3H4YNpmGLilk7AqhjgjAW70AEMw+XtM6bPM/gX0F9a0KLI3nKBnM4PnWrxnqBDh0WnRkp7p+SGAdSObfPOrGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQy600YdYcGoFxmHYk3x9PbhkUsRuOOihvPoeJNimQU=;
 b=LfVCKJ//KC5EQraSd+uINbM6agD65k7scH4xaiQGLbKWeT2zTjwP1iBerSp2u/uEoduOqD8G4cfTt5/ErJK7t2nkQYJoUohKo+ZNzq2TApEyBokcMrLHfW9fQ8Uby2bSCrZz81ygeCKnMwFKOwK4OIA412XfbmkpD/fd5YI9UpgkDVY7pdgTpBYWy+nsSp3n1kRAQfthQkM15RgEBXse266iq0v1UdWfAvqxTq3qqPZeTeV9c5OyQyBUowl5jxQOFKYL0ik0fz/HKc8FoJ9Q5KNZtGyrfghBJolB33dFuR2ceTL8A7l24FEB46m66gvi0C51RWMdMeh68mKbO7ClTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQy600YdYcGoFxmHYk3x9PbhkUsRuOOihvPoeJNimQU=;
 b=FSDG2RT7uYfNJcmaYycIzrSWkiiqePBAqDZCx6zRduetfJambWI7iOVCoV25uzpNXV7/V4m4lzktaWsk14As+RC4N7oyArCcqlAO7k9++cVU5mAsfObR/7HiJfVmgLwtc1tRAvMxIhZrGXnntj0X/OCloe1SRGvjPHEhBTumNhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB3909.namprd12.prod.outlook.com (2603:10b6:610:21::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 17:33:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Wed, 13 Jul 2022
 17:33:12 +0000
Message-ID: <48441a62-7557-a96d-77f6-e564e2ed8717@amd.com>
Date: Wed, 13 Jul 2022 19:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Get rid of amdgpu_job->external_hw_fence
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220713171340.495314-1-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220713171340.495314-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0025.eurprd05.prod.outlook.com
 (2603:10a6:20b:488::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d4123b-c382-4f9f-cb59-08da64f5c2a6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3909:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcH9lTIaBa+9o5hq+j/iumsNWPk7ac0Rk2Tb6IakZEDkIKOKwCk9sQmDo7/YPDgeSgu6jh/D1j/LZM+5bxSWmSlZEQKt+ekBvgx4T0YlvvmO+S6uOvrUK+J9z5zbSR4bh8i97OzaTjZhvOvByDx0HvNJUUq2PzPs9MHm9KcSY2WXu72dUiexi2fTpAYbfE85NNz2z9ctZfiUpPSmlqjh6iSXVsePn0Lbdlg87QVg9zV1EpTDf5//1endcMWLpJrS1AA1NHBCoSdbhc12vErj2XwB4YZ99Rx85DQ5D4ZwDWT+QOma7lni3BxK9d+OwQrWmuNb/bo/EEfofaxlhHJfhjEUF6XWfdYs1hMZeLYEGj5NHuqarA0mvbNiTQUacOI2NQfGocmaKuPCzcLbVr4ZlTogioL/rbAYYkXTtU1I4Qqye8qzcbf+QGw7CmC+9g/+jWWPRLU2k4Q/bVARE1Bbc/W8+HgpjhzqTQWSmncCg3alrE6u6/kBqzNiYk19/7VpQxPs/xCkjfxeEOKGy2QgoCmR7Bb61goCt3RJeQ/JlxgoWOZAYGuoiWud7q8Lmte0PZh8BzCcHjRODhHYPkuHRVHhYAiUCq8xXYhcePf16A+iqxroimlJ+QLiuP6ksV955+Ogw9IbVQoGotlQnKTvV6rS1zYAtcjagei9FmiOCqA5DdmvAcwpJ0vyCenkwTEZLGlf8XREZ+JebmnolopiigVmMoKp7jX1t1fXEf/8VAJSaJYIdKxCxxYv2XLIj7mZBG4yPOYDWMGgtLpf4EXlFj9fw8bi+PXPtpTk4MsAfw65j0+4RU9LvkzzhMklttrPofzxkO1UWONAstghxVA2bmdlmRFdNyIgrfGnrXdzCzKbtTQL+VR5KW4Gog413I3jIdiWs6SpYjPLen/HtaxBpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(83380400001)(66574015)(36756003)(31696002)(66556008)(31686004)(66476007)(186003)(66946007)(316002)(4326008)(86362001)(6506007)(8676002)(478600001)(8936002)(966005)(6512007)(41300700001)(2906002)(6666004)(6486002)(5660300002)(2616005)(38100700002)(26583001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBaNG80N1F2d2RyMjBiVTQwcFlkd0N3dU9nRTZ3SjVqQlNhN1NVVys1K1lv?=
 =?utf-8?B?V2hYSHFUbHdyMTNXQTJsZ2tpUko3c0JFbGdpeVgrY0NiUWhZVzAvNkdmcTJs?=
 =?utf-8?B?Umhsd2FoS2EzZi9zcWFoNWFaZSs1WnRWbjV4cUd0L0tIbi94WWgxaDNpNSsz?=
 =?utf-8?B?M3NnYTcyOThiUFZUQ0lsTzg0K3VIUWdodC9oSmtZNTVNZUN6cGJQaEVDd2hS?=
 =?utf-8?B?WDZmMGlKTTRQaFhIaGlSNStTenVZUVJ0VStmNWhRcnlVMWxtWUl2bkFvNVFV?=
 =?utf-8?B?Mm9EdStEUmVSaENOQWN0a2tKK3dpZWFPbzlIRmFZS05rLzJVb1lRWFBKY1hw?=
 =?utf-8?B?alRObzBGeXVZempQSUJYeG1ubHpMbTdVaG9HMzNTVHJtYU9DYTA0TFdod3Ja?=
 =?utf-8?B?a1JEcE0xN3FMZTNkdDdSWWFETFF4elZGWHpDVzM0T2tFQncvZHRVb0UxWHVU?=
 =?utf-8?B?R0U5RWFodEw3VUJvNGw1L0tXWlh2dDdJM2d0bDFuL3lPYVRRQStpQXVseWhj?=
 =?utf-8?B?RXUrazNJSzByUFFYdlluL3FiMG1TMzZoeTcrZzVsbEZoR24wL20rczVndjNl?=
 =?utf-8?B?SUZFUjNObEp2MmxwZWdkZkFHSkRjNG9CalRvTGlGQytPK0VPWXZOZGQydVhS?=
 =?utf-8?B?eGMyY2RUSzNSdWpnTkwwekRva2N2RllHR0gzRnBlUk1mMytWSGlDZzE3MzFn?=
 =?utf-8?B?ZkhadUpmZVFSdXpzQ0JudE1oMkk3Z1NScFhMNEJUTDV6R3Rvbi9rdzNvdUcz?=
 =?utf-8?B?SjlYVHRwZ05GVDAzRVhKUmphQXVBdXFQUkZwV1B5QlZkYUV5MWxZRzBqeS9Y?=
 =?utf-8?B?M3U2UE1lWXlIdTJXQVBid01uQ1NJMjJtQWVCQzkrYUV3QlprdS92TmlqVWxY?=
 =?utf-8?B?eVowdUhQL05KMHNHUjl0VWNzdlI0N0hBRG80ZnRWOGs0dkduTElCSExYcTk1?=
 =?utf-8?B?S2xBM1pNUmVtUmJjYnk4dzM0S05HUy9xbCszdFU3ZEJNTEpGY0paK2JteTRK?=
 =?utf-8?B?WWtDODUwMVg2VEFLK3MwNC9oNS8rUXZxU0N0MDJSempsOWdqS3d2NzkxVmRP?=
 =?utf-8?B?dFBGUi9mNE1ybW9mVFZWc3BndS9JOXgxSTJyZEhxYUphSk9oVFpsbUtCak52?=
 =?utf-8?B?QjdTV0NBbEZWRms5TVhNdVFUd1VwNktTL3pqbGVUS1UwRTBDdWF4cUNWME1n?=
 =?utf-8?B?OXpGdVUvcjdnOEpJQmsyQ1k5OVViQTh0dzFnSFdSWHZVWnRtd2ZzOVYwVHdS?=
 =?utf-8?B?THVqUlNWZDFmUDcrMTRTTCtobHNtTzQxMXRCVnRYVjFWMDhSK2pVM24yb1Q5?=
 =?utf-8?B?aVA4S1BSNnl2Mk8ydWR2SGRLSGFQb1pycUtWSTJabWNROW12YTlOVm9KWUE3?=
 =?utf-8?B?ekJ4WGZvbHQrZm13U2tlWmdPdFVQRGJYSEdnd0hNcmRMTDJDRVgydzYvS0hm?=
 =?utf-8?B?UnFzUnRpUkVDcDBKOExhV3laUzZ2UUxsdnd4emhTTGxtQTQ2N3UwYVgzQnE4?=
 =?utf-8?B?MWswSCt1NHl5ejlCWC84eVhtdHJ4bzQvekViS0RkNG4zVkxDZVo3eHE0d2xH?=
 =?utf-8?B?L3FYTXJGRDY4WTlQeUdoL2Zva01NaVlkNisxeGdXT3NWMTJjME1nT01tQ3FR?=
 =?utf-8?B?Ym90MUJkNE1jZDk2UFdzVnZnU2JFZUl0Rk53SWM2L05RalZoa1Y5MS81NXgz?=
 =?utf-8?B?c2x5RU5lN1J0RThKZE1Nb0diWTQrRkpDVFJoNzRuR0tmdzRHNEtxd1d6MW5O?=
 =?utf-8?B?UE4xUFFUd2N1TGhjcjRMZTBSZGl6cnZTdFFLUUQ2RzJMU3QxcHN1ekRHVXky?=
 =?utf-8?B?TUpWd05vOVl5amRrNDZqUFdPak9WcndjTEVIQWt5UGN5MmpPVFJrZ2FmTUdO?=
 =?utf-8?B?c1JMVEtZdHFXdnR6ajdVZ3pGOXFPekc1dmJSWmtVYThTZTBUNXdIay9SWjFG?=
 =?utf-8?B?TGdHOFY1dWNPWVp4SkZTb2ViMFJjaHhobTQwWk1MU2dvalAvUmhlYStnQ3Fr?=
 =?utf-8?B?bDBQd3d4TUpIa3d6OWxLMFZydC96K1ZTS3Bjb056OTdrbEtxckhjSzZWK090?=
 =?utf-8?B?cWZUYXhjRjVER1FhWDhVQWVBekhMQXhYWUg2WllzUHhPcUtHL1ZHTDhLN0VT?=
 =?utf-8?B?M09xU3Z6UEF4c0NrV2p1UjF5QVRSWE5nR1Q5emhPREZBbUdKbkRVNUN0UDVu?=
 =?utf-8?Q?eSKrFfu54JUd8Pm4SPe7AOjkdFm0GIL+V2IU5V1wWQ2K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d4123b-c382-4f9f-cb59-08da64f5c2a6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 17:33:12.3072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJNJgDad2N6OtrT6Mp/TxeRzZPzLtpQxtj3v5rMhHRItNowCnfitTq3F1s+bYr31
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3909
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
Cc: jingwen.chen2@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.07.22 um 19:13 schrieb Andrey Grodzovsky:
> This is a follow-up cleanup to [1]. See bellow refcount balancing
> for calling amdgpu_job_submit_direct after this cleanup as far
> as I calculated.
>
> amdgpu_fence_emit
> 	dma_fence_init 1
> 	dma_fence_get(fence) 2
> 	rcu_assign_pointer(*ptr, dma_fence_get(fence) 3
>
> ---> amdgpu_job_submit_direct completes before fence signaled
> 			amdgpu_sa_bo_free
> 				(*sa_bo)->fence = dma_fence_get(fence) 4
>
> 			amdgpu_job_free
> 				dma_fence_put 3
>
> 			amdgpu_vcn_enc_get_destroy_msg
> 				*fence = dma_fence_get(f) 4
> 				dma_fence_put(f); 3
>
> 			amdgpu_vcn_enc_ring_test_ib
> 				dma_fence_put(fence) 2
>
> 			amdgpu_fence_process
> 				dma_fence_put 1
>
> 			amdgpu_sa_bo_remove_locked
> 				dma_fence_put 0
>
> ---> amdgpu_job_submit_direct completes after fence signaled
> 			amdgpu_fence_process
> 				dma_fence_put 2
>
> 			amdgpu_job_free
> 				dma_fence_put 1
>
> 			amdgpu_vcn_enc_get_destroy_msg
> 				*fence = dma_fence_get(f) 2
> 				dma_fence_put(f); 1
>
> 			amdgpu_vcn_enc_ring_test_ib
> 				dma_fence_put(fence) 0
>
> [1] - https://patchwork.kernel.org/project/dri-devel/cover/20220624180955.485440-1-andrey.grodzovsky@amd.com/
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Of hand that looks correct to me, but could be that I'm missing 
something as well.

Anyway I think I can give an Reviewed-by: Christian König 
<christian.koenig@amd.com> for this.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 27 ++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  1 -
>   3 files changed, 6 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 16faea7ed1cd..b79ee4ffb879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5229,8 +5229,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 *
>   	 * job->base holds a reference to parent fence
>   	 */
> -	if (job && (job->hw_fence.ops != NULL) &&
> -	    dma_fence_is_signaled(&job->hw_fence)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence)) {
>   		job_signaled = true;
>   		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>   		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 6fa381ee5fa0..10fdd12cf853 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -134,16 +134,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct dma_fence *f;
> -	struct dma_fence *hw_fence;
>   	unsigned i;
>   
> -	if (job->hw_fence.ops == NULL)
> -		hw_fence = job->external_hw_fence;
> -	else
> -		hw_fence = &job->hw_fence;
> -
>   	/* use sched fence if available */
> -	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
> +	f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
>   	for (i = 0; i < job->num_ibs; ++i)
>   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>   }
> @@ -157,11 +151,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
>   
> -    /* only put the hw fence if has embedded fence */
> -	if (job->hw_fence.ops != NULL)
> -		dma_fence_put(&job->hw_fence);
> -	else
> -		kfree(job);
> +	dma_fence_put(&job->hw_fence);
>   }
>   
>   void amdgpu_job_free(struct amdgpu_job *job)
> @@ -170,11 +160,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
>   
> -	/* only put the hw fence if has embedded fence */
> -	if (job->hw_fence.ops != NULL)
> -		dma_fence_put(&job->hw_fence);
> -	else
> -		kfree(job);
> +	dma_fence_put(&job->hw_fence);
>   }
>   
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> @@ -204,15 +190,12 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   	int r;
>   
>   	job->base.sched = &ring->sched;
> -	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
> -	/* record external_hw_fence for direct submit */
> -	job->external_hw_fence = dma_fence_get(*fence);
> +	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
> +
>   	if (r)
>   		return r;
>   
>   	amdgpu_job_free(job);
> -	dma_fence_put(*fence);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index d599c0540b46..babc0af751c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -50,7 +50,6 @@ struct amdgpu_job {
>   	struct amdgpu_sync	sync;
>   	struct amdgpu_sync	sched_sync;
>   	struct dma_fence	hw_fence;
> -	struct dma_fence	*external_hw_fence;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	bool                    vm_needs_flush;

