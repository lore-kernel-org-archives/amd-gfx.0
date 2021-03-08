Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABD1C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBCA6518F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 07:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBCA6518F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD246E81D;
	Mon,  8 Mar 2021 07:53:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A21B6E81D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 07:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUrG2rOT5hQjFttVbUidOB5e4oI4fimwvsBzCG7Tfix9rLsVIHVKuMsCWd2Op7nMVC9J/oiXEz0+tgxQPEtrRtZc+huBc6by0D/6MS+vGbwdhGbtLXvnkd/8y8s4s2uba0v/v4P8Ral0Ii+/kjcnRBA1lPF56t+h9H1OKR6Xo1IUvXpe9aDaN7nesjo6alOl9+/yxG5S2E+ZuiT7SKmLvKGUTq6KEhdNzxDzHrgs+ePp2Bc0ZAlcsKqL5vtRvomSBjNBo2xsGACJ1i9lbU0tX10buKhxhvzOY0lVqXcrdYQiEAU98mRK0wXQyI8wfVye73QBsII5rl8uBIwG43/dZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZopM/KRMM+A+01oJccSgD1j7isRPAPHegyeNmnH+3c=;
 b=WdMhuKmrF5CqK77LrgcyuAdxNkXmiWyQOuEaPhdAZKnP7qFd+k2fltL+MNg2UTHn/mV1LQ/QnIijd/03gKdv3cAwUKvWWl8olTm+dDMNFu9xHdA8nVlv1Zpe752aG9DMkP/nsA/Tl7LLqxmEL/GuZQQh2Qwougl/9iLy4SXX0M1HErnY3FABAa9W9SpngCJquc2U4g2+MxxOmQbvvlVdHF+OY3XyelWTql14HMLQ/Ekn1tXSxa2wucOQ9X6zarqZ9Ua8ht7wFt37EIlCdeww48Ic6d6bHw4tr3FLRrm5/WhD59x9d18REKzlwTPN9vydSdvFotmWUyyeHrUnomlYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZopM/KRMM+A+01oJccSgD1j7isRPAPHegyeNmnH+3c=;
 b=jrl5juPbfvYshX68xPLnmRkknbwlUVdE8d5YWhxNUD0QM6r5Vpe1RYeZ7VrCjAwGcBdBLxH8d+swp+9meewjyuoI7s9VfRLKoPuSKV+izkjiBZw2rXD8mHb+hTPNY9Z5+JbUUVhtu+n2JaYnVi7IKXbEkDmclLUrCFMCHnnmlGM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 07:53:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 07:53:21 +0000
Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
To: "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>
References: <20210306172507.202243-1-Jack.Zhang1@amd.com>
 <9cea258e-1220-635e-1133-7dc1eae397b0@amd.com>
 <DM5PR12MB1708DCEC60FE2059CEE1DE5684939@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ffd292c3-3101-76dd-2ea6-4373caf9171a@amd.com>
Date: Mon, 8 Mar 2021 08:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM5PR12MB1708DCEC60FE2059CEE1DE5684939@DM5PR12MB1708.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4794:2f8d:7bcd:36a5]
X-ClientProxiedBy: AM0PR04CA0141.eurprd04.prod.outlook.com
 (2603:10a6:208:55::46) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4794:2f8d:7bcd:36a5]
 (2a02:908:1252:fb60:4794:2f8d:7bcd:36a5) by
 AM0PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:208:55::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 07:53:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1325326-e669-4b34-467e-08d8e2073dd6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB475480F9546BD748B1380D0E83939@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhpIgXNtCaGKh4x+Jfx/ggHL2uSYi7rFN4gSfHVkPONWEwm/g3w8LGW+RILXf2wSq+9rqCPH6GHdRqvV/bWzMhll/q/TLqCHye8eC5lWXNqMqzX15nI8S33yu+aQ9QV1jnYStwrArXg8YGLznNvG/1IUCNbs600R6oJ/hoX5tnrr/Pafmv+Aihi/1wDwxVF/RZsV/uTXchbALWwlhGzNiRscij8V+XpiNCXUd7maG7pJ6UNWPKz41QIoTbjNgRXDc9Pyq3EMynVz4QQzpxbIegPBQdQP6DUjcWKkemU9Qx/wm2fChCTMVb1LoHIo5l7SOs9fc32ZG27qcBfpQGIcdUvZUZZg0fI7EU3dP3PETwKlrxfzna6bvfQyA1XmLPgMitcvrdvpBmYF44NSZMUq60x3WJYX6ugNruiq/A66rvnTTvnv2SU+JUWRD1H6qprO4Z4tjSxKmMi4Kbg6ysRLEuV4QUfFPN79d/qoKa9w39DZloYbPJ64azCJZGoiE68QGzFxh8FRNt+noYPkhV4wxB2tK126MP8lShIW+X+5le9eIPFOhee4SJVAuP9GMxOGLbb7xdqCgnMTK9SZrNwmCr0LtmVewtkcELDrga0plws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(6636002)(2906002)(110136005)(2616005)(6666004)(316002)(478600001)(5660300002)(66946007)(53546011)(66556008)(66476007)(31686004)(6486002)(86362001)(8936002)(31696002)(83380400001)(8676002)(186003)(36756003)(30864003)(52116002)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEpsK2tXQU1DVE8yQjA5UmtreDR2V011WG4yMmNaRmlkL2JXK3VhUkQ2cnlQ?=
 =?utf-8?B?WW9RZy9YZ1RhWDdTVVl0eWFpaFRjdHFjbGRiYzAzOGE4NlljTXVuaGRKRjZX?=
 =?utf-8?B?WktOSEw1aWpmYzIvWVNYOEZqeElnWHdQdkQreGNjQUpFUUdaQ2JnRWVYS3Nz?=
 =?utf-8?B?V2V1cU5KWFAxS0tVZEhqYUJFQ3BKVGNVVEYzVmZzYmhzNHRjNS83a1hCYWQ1?=
 =?utf-8?B?OWNkNTV3RDIxQmVaaGthZExub29zZFNSdGw0d2MvNExiOWFIdkdSL1JOcWxo?=
 =?utf-8?B?SGQ5Wm9lUmNjdWRhT1FFcW5aT3Q0M2JiMWhzYnprNUJPVzNuTm15c05xZERm?=
 =?utf-8?B?aGVnU3czSURaOFUxWEcrc2prS250QnhDQWFRK21NbmU3bUp5ZCsvUXdUMENa?=
 =?utf-8?B?WHdFYWJKMTdYNTVGOGs1elA0dTlaeFgzNmdTa0FmSXE1bi8wTFQ2VmgyMTNF?=
 =?utf-8?B?K3RudkF3bEtDeG9NemU4K2lqWVRXZlVMMHVXMEhKTVdnTDJsSldNTXBxRit1?=
 =?utf-8?B?clpVM1NTZ3VEeEFLV1EvS3E5UEdCSldoSFVOWGlpMkRNU0tGdHFhMWJ4NUpt?=
 =?utf-8?B?b1RpZU8rTVZWaFkzTUtQOWpKTUtGdFRRYXQ0VHhzVWg1dVU2bXFMeVhTd1JL?=
 =?utf-8?B?TFRINEowQXJqdVlPTDVjY1RTbU5FVEFWcWVBbEc4S056d09zYzBURTRwMDNQ?=
 =?utf-8?B?cUFSYm5oamZKYWJvNWNuTDFDcFdudDMrTlJYVmQzZzUzOEljSXVIYkR3Njhw?=
 =?utf-8?B?SXVleFkyR0w1ZDY3LzZPck1SMEx0WFQ5QTg4dTVTbmY4L3JnNDFRSlhVZkVL?=
 =?utf-8?B?cjdQQVBZMGdiY1h6UTB1dkt2SUhEUVArMURKNXk4NnRGL3lIMjlrRUhvQmVU?=
 =?utf-8?B?Sll3VW9PTjdvQmh3K3lweW52Zk40RGE5cVlCMTBkMFhzQWpjcjlkalFHeFE5?=
 =?utf-8?B?WC8wWDZuWEE1M1JmY21tV1RIWHFMOHFCVlRtVFpSMzVQUEFLclQxU2RiU2xV?=
 =?utf-8?B?MnBSbUU1aUlPUWdYc3JJdUFGcktBOUtFK0JleHduRTh0QUw3bjd4NWJ6VHJt?=
 =?utf-8?B?cXB5S3pHN0trU3czWFh1dm1SYnIvdlU2eWhTMU1WYndZY2E2NEFHVUNOMXZX?=
 =?utf-8?B?T3N0YWhwaWlZZW9tWXNZMHFBWUdCYVlkeENyN1N5Vmh3R2p6VGtmWW9yd1U1?=
 =?utf-8?B?dFkrUG1ZM3hEdk13WnE1bUV3aFNyaERTU0hJT296U0NRM1NKYlNrSnJPZW5j?=
 =?utf-8?B?Si9rTkpPZi84Y0VzbFIyV0lrSlNCUTBCbTBHMDd4YTNMVjMxdnMxcDc3NEw1?=
 =?utf-8?B?ZjdxSFo3Z2V4bmJ0TDdFRXNJSWdEWHFieGRqYkRZbWlzVHppSkxQa2Q5K3A3?=
 =?utf-8?B?WXNpZy9mWmdIRktMWmNDNkl2QTRXenlkMWdQWjQrTTV6Q2MwQ3RKKzVIM2lG?=
 =?utf-8?B?d1RaWVR3RHBqMkpCZ0NmSlZSL3AyUldzSEtuS1UzelBGblVtSG1pUmtrRi9I?=
 =?utf-8?B?UExuek9wZExhMEN6Z3FUZUZaVEpmMXQ2Lzl0dnZZWmFOdmZMM2NvTWFzaVdW?=
 =?utf-8?B?ZWxyWkRtREliS3VoZkdGd1BlNC9VUnpsbnkvUGZoT2diNEZ6Q1ZjaDBqK2dx?=
 =?utf-8?B?Umc5RFNmK0RGQk1uMU1wZGVsSzFxN1Awa1IydUtrNGtGQW8rcXptR3JuNU9a?=
 =?utf-8?B?WTljaGhBcWRyemhMNGlKMEUxRkFpcXVNR042NDB0c3RNVjgrbjlKVFV3aFdC?=
 =?utf-8?B?cy9NVlZqaGdsdGJBVFV2RW9pYVZSQWlvNytaYXhhUkQrUzA0Q2VkQlZRbGZu?=
 =?utf-8?B?N3JWWktLd3FybjlZdmF6aFVsUS82RmdLZi9YbGtMQ0M3VVRCMFN3YWxWZ3da?=
 =?utf-8?Q?a4xuA9Vi3UZ1J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1325326-e669-4b34-467e-08d8e2073dd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 07:53:20.6524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7gdl1YCvsuD+iCNe3f+kf/Jqx6mcMsIPYKgL58XhM5pYp8AsohoGS0m9SzLkOT0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
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



Am 08.03.21 um 05:06 schrieb Liu, Monk:
> [AMD Official Use Only - Internal Distribution Only]
>
>>> well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.
> We need it to expedite the process, we can introduce this change in another patch
>
>
>>> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
> No that's not true, during the " drm_sched_resubmit_jobs" it will put all jobs in mirror list into the hw ring, but we can only allow the first job to the ring
> To catch the real guilty one (otherwise it is possible that the later job in the ring also has bug and affect our judgement)
> So we need to implement a new " drm_sched_resubmit_jobs2()", like this way:

Something like this. But since waiting for the guilty job is AMD 
specific we should rather rework the stuff from the beginning.

What I have in mind is the following:
1. Add a reference from the scheduler fence back to the job which is 
cleared only when the scheduler fence finishes.
2. Completely drop the ring_mirror_list and replace it with a kfifo of 
pointers to the active scheduler fences.
3. Replace drm_sched_resubmit_jobs with a drm_sched_for_each_active() 
macro which allows drivers to iterate over all the active jobs and 
resubmit/wait/mark them as guilty etc etc..
4. Remove the guilty/karma handling from the scheduler. This is 
something AMD specific and shouldn't leak into common code.

Regards,
Christian.

>
> drm_sched_resubmit_jobs2()
> ~ 499 void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
>    500 {
>    501     struct drm_sched_job *s_job, *tmp;
>    502     uint64_t guilty_context;
>    503     bool found_guilty = false;
>    504     struct dma_fence *fence;
> + 505     int i = 0;
>    506
>    507     list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
>    508         struct drm_sched_fence *s_fence = s_job->s_fence;
>    509
> + 510         if (i >= max)
> + 511             break;
> + 512
>    513         if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
>    514             found_guilty = true;
>    515             guilty_context = s_job->s_fence->scheduled.context;
>    516         }
>    517
>    518         if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
>    519             dma_fence_set_error(&s_fence->finished, -ECANCELED);
>    520
>    521         dma_fence_put(s_job->s_fence->parent);
>    522         fence = sched->ops->run_job(s_job);
> + 523         i++;
>    524
>    525         if (IS_ERR_OR_NULL(fence)) {
>    526             if (IS_ERR(fence))
>    527                 dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
>    528
>    529             s_job->s_fence->parent = NULL;
>    530         } else {
>    531             s_job->s_fence->parent = fence;
>    532         }
>    533
>    534
>    535     }
>    536 }
>    537 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>    538
>
>
>
> Thanks
>
> ------------------------------------------
> Monk Liu | Cloud-GPU Core team
> ------------------------------------------
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Sunday, March 7, 2021 3:03 AM
> To: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
>
> Hi Jack,
>
> well first of all please completely drop the affinity group stuff from this patch. We should concentrate on one feature at at time.
>
> Then the implementation is way to complicate. All you need to do is insert a dma_fence_wait after re-scheduling each job after a reset.
>
> Additional to that this feature is completely AMD specific and shouldn't affect the common scheduler in any way.
>
> Regards,
> Christian.
>
> Am 06.03.21 um 18:25 schrieb Jack Zhang:
>> [Why]
>> Previous tdr design treats the first job in job_timeout as the bad job.
>> But sometimes a later bad compute job can block a good gfx job and
>> cause an unexpected gfx job timeout because gfx and compute ring share
>> internal GC HW mutually.
>>
>> [How]
>> This patch implements an advanced tdr mode.It involves an additinal
>> synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
>> step in order to find the real bad job.
>>
>> 1. For Bailing TDR job, re-insert it to mirror_list, don't set it to
>> guilty and leave it to be handled by the main reset thread.
>>
>> 2. Don't set the job to guilty in pre_asic_reset, and leave it to be
>> handled by Step0 Resubmit Stage.
>>
>> 3. At Step0 Resubmit stage, it first resubmit jobs asynchronously,
>> then it iterate each ring mirror_list, synchronously pend for each hw
>> fence being signaled. If the a job's hw fence get timeout, we identify
>> it as guilty and do hw reset to recover hw. After that, we would do
>> the normal resubmit step to resubmit left jobs.
>>
>> 4. For whole gpu reset(vram lost), skip Step0 Resubmit as each job
>> after vram lost was considered as bad job.
>>
>> 5. Involve the concept "Affinity Group".
>> Doing two hw resets is not necessary when there's only one ring that
>> has jobs among some hw-related rings.Thus, we involve "affinity group".
>> Hw-related rings could be added into a common affinity group, such as
>> gfx and compute ring. When tdr happens, we iterate all rings in
>> affinity group, skip Step0 Resubmit stage if there's only one ring's
>> mirror_list that has valid sched jobs.
>>
>> V2:
>>       -fix a cherry-pick mistake for bailing TDR handling.
>>
>>       -do affinity_group check according to the bad job's sched rather
>>        than the default "1" so that there could be multiple affinity
>>        groups being pre-defined in future.
>>
>> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  47 ++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |   2 +-
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  27 ++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
>>    include/drm/gpu_scheduler.h                |   1 +
>>    7 files changed, 173 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e247c3a2ec08..8632d7071292 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4188,6 +4188,37 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>>    	return false;
>>    }
>>    
>> +bool amdgpu_affinity_group_has_only_or_null_working_ring(struct
>> +amdgpu_device *adev, struct drm_sched_job *s_job) {
>> +       int i;
>> +       int working_ring_num = 0;
>> +
>> +	/*
>> +	 * The job is considered as the real bad one
>> +	 * if job's sched is not in affinity group
>> +	 */
>> +	if (s_job->sched.affinity_group == 0)
>> +			return true;
>> +
>> +       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>> +               struct amdgpu_ring *ring = adev->rings[i];
>> +
>> +               if (!ring || !ring->sched.thread)
>> +                       continue;
>> +
>> +               /* for non-empty affinity ring, increase working_ring_num */
>> +               if (ring->sched.affinity_group == s_job->sched.affinity_group) {
>> +                       if (!list_empty(&ring->sched.ring_mirror_list))
>> +                               working_ring_num++;
>> +               }
>> +       }
>> +
>> +       if (working_ring_num > 1) {
>> +               return false;
>> +       }
>> +       return true;
>> +}
>> +
>>    /**
>>     * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>>     *
>> @@ -4310,8 +4341,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    		amdgpu_fence_driver_force_completion(ring);
>>    	}
>>    
>> -	if(job)
>> -		drm_sched_increase_karma(&job->base);
>> +	if (amdgpu_gpu_recovery != 2) {
>> +		if (job)
>> +			drm_sched_increase_karma(&job->base);
>> +	}
>>    
>>    	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
>>    	if (!amdgpu_sriov_vf(adev)) {
>> @@ -4639,7 +4672,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    	int i, r = 0;
>>    	bool need_emergency_restart = false;
>>    	bool audio_suspended = false;
>> -
>> +	int	tmp_vram_lost_counter;
>>    	/*
>>    	 * Special case: RAS triggered and full reset isn't supported
>>    	 */
>> @@ -4690,8 +4723,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    					job ? job->base.id : -1);
>>    
>>    		/* even we skipped this reset, still need to set the job to guilty */
>> -		if (job)
>> -			drm_sched_increase_karma(&job->base);
>> +		if (job) {
>> +			if (amdgpu_gpu_recovery == 2) {
>> +				if (&job->base) {
>> +					spin_lock(&job->base.sched->job_list_lock);
>> +					list_add(&job->base.node, &job->base.sched->ring_mirror_list);
>> +					spin_unlock(&job->base.sched->job_list_lock);
>> +				}
>> +			} else
>> +				drm_sched_increase_karma(&job->base);
>> +		}
>>    		goto skip_recovery;
>>    	}
>>    
>> @@ -4788,6 +4829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		}
>>    	}
>>    
>> +	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>>    	/* Actual ASIC resets if needed.*/
>>    	/* TODO Implement XGMI hive reset logic for SRIOV */
>>    	if (amdgpu_sriov_vf(adev)) {
>> @@ -4804,18 +4846,64 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>    
>>    	/* Post ASIC reset for all devs .*/
>>    	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>> +		int step = 1;
>>    
>> +		if (amdgpu_gpu_recovery == 2) {
>> +			if (amdgpu_affinity_group_has_only_or_null_working_ring(adev,&job->base)
>> +				|| tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)) {
>> +				DRM_INFO("Skip Stage0 Resubmit Stage\n");
>> +				/* set guilty */
>> +				drm_sched_increase_karma(&job->base);
>> +				step = 1;
>> +			} else {
>> +				DRM_INFO("Do Stage0 Resubmit Stage\n");
>> +				step = 0;
>> +			}
>> +		}
>> +
>> +retry_resubmit:
>>    		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    			struct amdgpu_ring *ring = tmp_adev->rings[i];
>> +			int ret = 0;
>> +			struct drm_sched_job *s_bad_job = NULL;
>>    
>>    			if (!ring || !ring->sched.thread)
>>    				continue;
>>    
>>    			/* No point to resubmit jobs if we didn't HW reset*/
>> -			if (!tmp_adev->asic_reset_res && !job_signaled)
>> +			if (!tmp_adev->asic_reset_res && !job_signaled) {
>> +
>>    				drm_sched_resubmit_jobs(&ring->sched);
>>    
>> -			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>> +				if (amdgpu_gpu_recovery == 2 && step == 0) {
>> +					ret = amdgpu_wait_resubmitted_jobs_completion(&ring->sched, ring->sched.timeout, &s_bad_job);
>> +					if (ret == -1) {
>> +						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_bad_job->id);
>> +						/* set guilty */
>> +						drm_sched_increase_karma(s_bad_job);
>> +
>> +						/* do hw reset */
>> +						if (amdgpu_sriov_vf(adev)) {
>> +							amdgpu_virt_fini_data_exchange(adev);
>> +							r = amdgpu_device_reset_sriov(adev, false);
>> +							if (r)
>> +								adev->asic_reset_res = r;
>> +						} else {
>> +							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
>> +							if (r && r == -EAGAIN)
>> +								goto retry;
>> +						}
>> +
>> +						/* add reset counter so that the following resubmitted job could flush vmid */
>> +						atomic_inc(&tmp_adev->gpu_reset_counter);
>> +						step = 1;
>> +						goto retry_resubmit;
>> +					}
>> +				}
>> +			}
>> +
>> +			if (step == 1)
>> +				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
>>    		}
>>    
>>    		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 865f924772b0..9c3f4edb7532 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>>     * DOC: gpu_recovery (int)
>>     * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>>     */
>> -MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 =
>> enable, 0 = disable, -1 = auto)");
>> +MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 =
>> +advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
>>    module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>>    
>>    /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 759b34799221..28cda321157a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -281,6 +281,53 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
>>    	}
>>    }
>>    
>> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler
>> +*sched, long timeout, struct drm_sched_job **s_bad_job) {
>> +	struct drm_sched_job *s_job, *tmp;
>> +	int ret = 0;
>> +
>> +	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
>> +		struct drm_sched_fence *s_fence = s_job->s_fence;
>> +
>> +			if (s_fence->parent == NULL) { /* fail to get a hw fence */
>> +				/* process a job */
>> +				atomic_dec(&sched->num_jobs);
>> +				dma_fence_get(&s_fence->finished);
>> +				dma_fence_signal(&s_fence->finished);
>> +				dma_fence_put(&s_fence->finished);
>> +
>> +				/* remove node from mirror_list and free the job */
>> +				spin_lock(&sched->job_list_lock);
>> +				list_del_init(&s_job->node);
>> +				spin_unlock(&sched->job_list_lock);
>> +				sched->ops->free_job(s_job);
>> +				continue;
>> +			}
>> +
>> +			ret = dma_fence_wait_timeout(s_fence->parent, false, timeout);
>> +
>> +			if (ret > 0) { /* succeed */
>> +				/* process a job */
>> +				atomic_dec(&sched->num_jobs);
>> +				dma_fence_get(&s_fence->finished);
>> +				dma_fence_signal(&s_fence->finished);
>> +				dma_fence_put(&s_fence->finished);
>> +
>> +				/* remove node from mirror_list and free the job */
>> +				spin_lock(&sched->job_list_lock);
>> +				list_del_init(&s_job->node);
>> +				spin_unlock(&sched->job_list_lock);
>> +				sched->ops->free_job(s_job);
>> +				continue;
>> +			} else if (ret == 0) {
>> +				*s_bad_job = s_job;
>> +				return -1; /* timeout */
>> +			}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>    const struct drm_sched_backend_ops amdgpu_sched_ops = {
>>    	.dependency = amdgpu_job_dependency,
>>    	.run_job = amdgpu_job_run,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> index 81caac9b958a..25292f4699fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>> @@ -76,5 +76,5 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>>    			     struct dma_fence **fence);
>>    
>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>> *sched);
>> -
>> +int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler
>> +*sched, long timeout, struct drm_sched_job **s_bad_job);
>>    #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index b644c78475fd..cb50bfc80bc9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -35,6 +35,11 @@
>>    #include "amdgpu.h"
>>    #include "atom.h"
>>    
>> +static char *amdgpu_affinity_group[] = { "gfx", "comp"
>> +};
>> +
>>    /*
>>     * Rings
>>     * Most engines on the GPU are fed via ring buffers.  Ring @@ -189,6
>> +194,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>    		ring->adev = adev;
>>    		ring->idx = adev->num_rings++;
>>    		adev->rings[ring->idx] = ring;
>> +		amdgpu_ring_set_affinity_group(ring);
>>    		r = amdgpu_fence_driver_init_ring(ring, sched_hw_submission);
>>    		if (r)
>>    			return r;
>> @@ -459,3 +465,24 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>>    	ring->sched.ready = !r;
>>    	return r;
>>    }
>> +
>> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring) {
>> +       struct amdgpu_device *adev = ring->adev;
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(amdgpu_affinity_group); i++) {
>> +               char *temp_name = amdgpu_affinity_group[i];
>> +
>> +               /* set ring's affinity_group bit if find it in affinity_group list */
>> +               if (strncmp(ring->name, temp_name, strlen(temp_name)) == 0) {
>> +                       DRM_DEV_INFO(adev->dev, "set ring:%s in affinity_group\n",
>> +                             ring->name);
>> +                       ring->sched.affinity_group = 1;
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       ring->sched.affinity_group = 0;
>> +       return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 56acec1075ac..6b0d217e6f5a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -350,4 +350,5 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>    			     struct amdgpu_ring *ring);
>>    void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>    
>> +int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring);
>>    #endif
>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>> index 1c815e0a14ed..589cbaea35dc 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -301,6 +301,7 @@ struct drm_gpu_scheduler {
>>    	atomic_t                        _score;
>>    	bool				ready;
>>    	bool				free_guilty;
>> +	int				affinity_group;
>>    };
>>    
>>    int drm_sched_init(struct drm_gpu_scheduler *sched,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
