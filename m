Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FEFC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9860610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9860610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEE36E5A4;
	Thu, 26 Aug 2021 09:54:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D376E5A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzBT7aPYFSDJTnsX6ByGmA3JghboDsngyIHLEyl949hTx/nSjZre2gv1u7exbtaZDUxxDy5xZGJoKQbWryfV11K56JbYsl00VV/+ioeia+jFOPYPET/SToxOUnAfI+moC4gbPORQVCbxiIgIZLJpqayEwZDIOvB8BW+qN9kBLskvAJhHyQwzbc3mkuYUjWP6wtZMrOF+EQ842OmT33GWR4UoGi4foWyDaS+D9MjnRy8UFnb3JDZ1iQmUGHInoUkCvRQYU+4TDjmyTRSGnaNugYLWharxkRxftYucyDrvJE7ZyDK6IQh+ezXsWfW+/njUiyJ21fzTiZg8G6sVPIji7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gmsc9W3+P5S1ktmqiBN2IDGxi3y6m4d4IGxcM9DtoQ=;
 b=Maea9AQPQ88zE2iaibnTcbDxc5dpjRPyqfb746nn9sGLUOQYmDGd/YDQ4nsul6YYu3771cfjad3jfRWwogDNSZ+ty9tTyfcsnmPRbspcEe6/euruRB2cVKZear2ttz2I8tkHznIgeucViwJOzwM8m3TeyAcEzHmA/hWSPnKtrr3XDRLq/4+gWfRVak46AKMLUgUoy3WvbUlNtXiSLAXlXtQ5PMCzDVoEqhacfJx0p8DMQM+WGXwXppIlxEQZiViL8PWYIdUOKTBcyOYDsyY12NROgJBhZABj9oSLCJ/XWIbG5FTlBPuGB0Vp+TKdupgNDDvf2zPn4/30BDPjgwMDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gmsc9W3+P5S1ktmqiBN2IDGxi3y6m4d4IGxcM9DtoQ=;
 b=Z7bH8RnQPJiYZ0EqbVIXEGcvZCsR1C3BPUuR1qR/wZTUpcQgmr2HB/xH2mxogF+bsTbWsd8aldhIMCmhF6mlJ1qiwjEu9LcFZzsvZAB6Ns/Yej/4aaK8x/XTKdQccInnsRVYCZPjlv7DFj4qlRxzxGxaR5La6RTmK3cJF/PacUY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Thu, 26 Aug
 2021 09:54:10 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 09:54:10 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: detach ring priority from gfx priority
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825154233.4882-1-nirmoy.das@amd.com>
 <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dca37b0b-3520-6e6a-706c-bfec244182c5@amd.com>
Date: Thu, 26 Aug 2021 11:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f034:47d2:6ee4:c70f]
 (2a02:908:1252:fb60:f034:47d2:6ee4:c70f) by
 AM9P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 09:54:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9202f709-0a76-40f7-ea80-08d9687773b0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4390252DF4A487674B89277A83C79@MN2PR12MB4390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ4L5AXE+Y19WpJdRXv0I/vn45FWg3Xiq2Y+SenpvK9twRQD6IKt8Jz+V0M+FRmzHb6Sl7JdXfBHAZl1N+1KHdj6kQjZKcBUmd/8D/ot6tuI4n4T5qQF9ULLqQnk+4ymVGwyxM51yWFOYI+fKakGeCpStTFXHuefMTlwFNW/i+FAoFvMxJWx71WZuySTbAmT2GvKI+1E19TzlRVUNzaHMGK4/ec0b3sQLBdioDfmywKs/eXcpx87NzXoChHXG92+4s5VARdfMsUcfw22NTBvc3z+jAwG0r7oFC7gysWVxuOBp3RziTEh14oRm2PSKY7ABhWyVw/z3Gc+tdh64plI4nmeNfkg/UiryeaMNICMB2v/r6BoiZAhs176tOYfUfW3dKnZ4TMNt32LlYAGgwuLB6N4+GXhl10BWz1dvh+NcyuCZf8kVqkrMMhzxrJmiWt2iC3KUbu+I4mwEGHZLmiZ6eCVfl3FfVt4qQ8f6OoCuMruOyWYHDTBXbHem3tDqfwA8wgQVWan78GcW8CYJI6ff62UQbS9gb1n6lN+Wnjy9f1ZGnN0tUDxlNpmPC45U8wrP0p9RHtHYSmvuao0u9V4yKiPJEZhaLHBUJoyRrrpMw/PAfOtaRpKXZgiu5GtRUCnQ88YPdXiO/7+KBIQF8UXOY50QV825FJmPuxs+SiU2SkmsZ1G7NHggnoGi1yonX5Pt5+IKztc2m1KiumQQgJdKXGxOwcHJK6LbaQBFBaieGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(4326008)(66556008)(66946007)(186003)(53546011)(478600001)(5660300002)(86362001)(8936002)(6486002)(2906002)(31686004)(36756003)(8676002)(83380400001)(66476007)(38100700002)(6666004)(31696002)(2616005)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUc2U3RQL0h2VUhMNzhtdGlSQ1NWRDZKRE4xOWlyMTRvdXVnRlBwaGttMDVl?=
 =?utf-8?B?OTFieXBKeUZuVldYM095anh3b1BkOURCaXgwU2h3MVp2Wkp0UXo4dDJGL0tY?=
 =?utf-8?B?dytIVnJldnVRZ0h1S0RXak5BaFRGNmJxTStMWThEWklST05wQ0ZMOGsrM2c5?=
 =?utf-8?B?cEVLUTdNemY4MWxrWTN6bkI3emE2ai93L2dUTEtrRHkzMUZuNDFTTHFGa3Jv?=
 =?utf-8?B?clZKM2FseWtMVzZBZUlqcWFYS3kwUUpnVEtKRHFmaHNBdDMrSGtmd2E1Nmwz?=
 =?utf-8?B?bFVOQkFQRWduRjBvYUd4eDBQbm9WMjcxd25tR3VLYzY5UnpOekZoM3lReGFt?=
 =?utf-8?B?UzdsMEh1RjdGWERJTUN5ekR2dVBkV2xOSzIzZlNFNTU4d3lpMk5vRkNKb0J1?=
 =?utf-8?B?UDZycmdxb1d4YVpwb2hoRFB1QldTSVRBVkowc29yTDR1NFBlRzRrNm1wKytP?=
 =?utf-8?B?bWxHRXIzdmovNUdGWFltVXpvV0lSUXNEdHg4MXA0djVYZ1RMU3hKWEtWS3hK?=
 =?utf-8?B?Rks3T3BqRU9BdHBnN1VsOGpPRXUzRVp2YzhQczQ3MUlrTEx1MmUvRG9vOW9Q?=
 =?utf-8?B?RXZSWjlMMFJ2aG5CVDdPdmtvNlVqOEhMNGdOdnVIWGtuTGNDZ0ZmdzZQQ1Y5?=
 =?utf-8?B?ZVEycmJmVjRxYklsR1ZkTForSitzUERJbG9mYWNXWEdUZ2NRbm9hTDE2VzdR?=
 =?utf-8?B?UzZ3dmhXaFc0Y1pmckE3citTL0pTTlJJNC9PbStmMjAxQVJBYllUeDZkRm10?=
 =?utf-8?B?RVJOMmxXbkJ4TndlV3U1UUxJZ0JScnBuV1Z4VWNlQXAzM2o0bzExZmdzY3Yy?=
 =?utf-8?B?VFRHYTVuSHE1eHBrYWdPY1U0UThaalVOYndjaExrUlpLclRjWXY1RWhuKzQy?=
 =?utf-8?B?MTlwdUJseXJHU1poZVVtOUJjYVdwQ3haaGZsL21aVUtKRVc0S1ZRTTcrT1hE?=
 =?utf-8?B?dHo0NnFYaFRqemRrZzQ2Ni94RzRwdGZKL25Dc3c4MnJ6V3dDeTVSRjhIdnBD?=
 =?utf-8?B?WFlZazE3OFJlTVQreHh2Q0k0RVd6TEtIZFBwWUszYUc5YUFTT0tRc0l3bm5l?=
 =?utf-8?B?QlZnV2pIM2VxYU1lcVJrUEhTTXhtMk5vRVBYdkIzZlhaT05IdGFNL2wvN2d6?=
 =?utf-8?B?VTk1c3RtQjhaZjNvZ1dMQlJEaEIzcjk3TE5jMnpxaUtQTnJ1blZOMFpiYW8w?=
 =?utf-8?B?ZGE1ZCs5OFBSdDFaQ3JxR1hEejlGUlJJMFg3UVJmM1NwZGFSdHJ4V0dPd2da?=
 =?utf-8?B?a0NZTHRnSjU3OFd1QVJYdDZXRDE0aExQMDY5ZDFZMldMWUFTVFViaEU3ZWlF?=
 =?utf-8?B?bU14RkFzMnpSd0lGM2MwNG1zRzEyNGkwNUNaRW9lYWFnQUZxdTI0b1hYRFB6?=
 =?utf-8?B?TW5oa1Jpa1JJL2NWUEcyTmxSVzBTQWtlNjVDbFMyam9aWmJZME5acE1UMHdD?=
 =?utf-8?B?YzliaGRTYnpSdEJlYUo4ZVJmVGdIRVJnQmJwT0d1eGtOc0dveWpJRWVOT084?=
 =?utf-8?B?c2lRNUxjalBlQjVic2pmblhiQjlLTnJFSDdVMkJEbFFNOFdDNDg4Z21tMU1u?=
 =?utf-8?B?SDNlc1BUbGJacUFLLzJ0L0xpbngzZzd6V3BNZWxENENqb2EyWmVDWlA1bFBq?=
 =?utf-8?B?eHBTTVdXMWRrVlJSblNMeHZlb2o3V3VORTdXNFRNSTI4QTdaWFVjekN5blhy?=
 =?utf-8?B?eEVuSGFHSXI3VHVJenppT1lHeVZLNTBjcjF0Q2o1RzVJeFlJaVFrbHhMUnFa?=
 =?utf-8?B?eTRsSFhOdkxvVWJpeXBtM2NHVkdPTTBTcVVoSGZnQ081cVM2SFNVaGlDR0l0?=
 =?utf-8?B?VjFWcS95bUtpaGhQZUZrQ3JzMDFPcDBnMStta2wxU2c4WjJuK0dVdFJaRmVZ?=
 =?utf-8?Q?xIR4uoQ3pkUWW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9202f709-0a76-40f7-ea80-08d9687773b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:54:10.6603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN6CW9n8wJLp3y+Vl27Y0BXa1tlJZe97B3layNYHa9rl0zJ4qJ0gMJzQ30doBDjG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Am 26.08.21 um 11:27 schrieb Lazar, Lijo:
> On 8/25/2021 9:12 PM, Nirmoy Das wrote:
>> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
>> max gfx hwip priority, this won't work well when we will
>> have a hwip with different set of priorities than gfx.
>> Also, HW ring priorities are different from ring priorities.
>>
>> Create a global enum for ring priority levels which each
>> HWIP can use to define its own priority levels.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 10 ++++++++--
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index d43fe2ed8116..937320293029 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -43,9 +43,9 @@
>>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>>     enum gfx_pipe_priority {
>> -    AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
>> -    AMDGPU_GFX_PIPE_PRIO_HIGH,
>> -    AMDGPU_GFX_PIPE_PRIO_MAX
>> +    AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
>> +    AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
>> +    AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
>
> Is this a valid priority level? If not, better avoid it.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Is the _MAX define even used here any more? As far as I can see you 
removed the only use case for that below.

If it's unused just drop it completely.

Christian.

>
>>   };
>>     /* Argument for PPSMC_MSG_GpuChangeState */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index e713d31619fe..85541005c1ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -36,8 +36,14 @@
>>   #define AMDGPU_MAX_VCE_RINGS        3
>>   #define AMDGPU_MAX_UVD_ENC_RINGS    2
>>   -#define AMDGPU_RING_PRIO_DEFAULT    1
>> -#define AMDGPU_RING_PRIO_MAX        AMDGPU_GFX_PIPE_PRIO_MAX
>> +enum amdgpu_ring_priority_level {
>> +    AMDGPU_RING_PRIO_0,
>> +    AMDGPU_RING_PRIO_1,
>> +    AMDGPU_RING_PRIO_DEFAULT = 1,
>> +    AMDGPU_RING_PRIO_2,
>> +    AMDGPU_RING_PRIO_3,
>> +    AMDGPU_RING_PRIO_MAX
>> +};
>>     /* some special values for the owner field */
>>   #define AMDGPU_FENCE_OWNER_UNDEFINED    ((void *)0ul)
>>

