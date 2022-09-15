Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8187C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 18:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC74410EBBD;
	Thu, 15 Sep 2022 18:29:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D0910EBBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 18:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVTsan0wMDNtx1Z0D6onL3IHSsdJofh0DYs8M9CmC0UJ3PSA4degKnx2tGX3RJs1gXZ4QPnmGtwG6oBmPlWLpazanT1OKaJk/eG9gsw97ydi3SPVyqYSKNOND9N9daTUXjOlmwIg6gAAg7PCOoa1R1qoF+e/Vx34exgk0XRUSPf9TY8AgFzqRgfUfU8XdLHje0O2n+8EpCFr8QNU63JpDA9SNAZobVvB7TOR9py81bRu/657139kpN4uzQU38jb4Dazo8tL5WnhyQYkPZ2kGPLQPYrYSuxZti+NPBqVfLOYwV+9RuHJxsZn8DUq1jch6F+LhwnCSNv3hqgmh1KgwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opljUFdoLWdCsSQpENEivp8vbVUgDESof3OPcIj35c4=;
 b=NOlJOwzgkx3hem+NYj46jAG7dAA5yY/3HNTJqxLgSLD13KcyCEkCGoAzybUhKEUSZVxUXFAo4bGyaJYdCj7J0QBCJarHIIENMKgM03DrmmnK1ltvDAY66PmIC+RCVgfzd+SOSIioWynmp+Lv41KKQm1dyi3mDcWm5HdVYiWl5hQQSkVKFxeHRdV2LHnw1YVxoCRjQeYMSf2M+Exv8GOEWVybays8vknvegSrcD67J6x6H/pAj6Y+poK36WDPXLCf738LsT7jCrfNdx8Tl72uRd1pDUmspwL4RUJ/BrpX00bsTWsKxI1ocK68FOT+j00MSEuJLHj+W3aEXGlX74RSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opljUFdoLWdCsSQpENEivp8vbVUgDESof3OPcIj35c4=;
 b=c5SoPTUt2ZRn8qdXLGMxLPXk/clM9W7L4P6iWHjoRTeOitNfrKxsVlbQr/6EbgqFHeZ/+2XAywZ5CddnYy3kIWdk0gAXXtbEFsOhTAD8G2aAlF5pYoeJ+MNmCXfXjag31rX39OZTgykf478Si2BsZeJJbeoLNELChgWranLp9SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 18:29:50 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:29:47 +0000
Message-ID: <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
Date: Thu, 15 Sep 2022 14:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::13) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a0491b-2d22-4a75-c612-08da974844ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nu/o7d85qZMZ7fZ4liK+C4SRABoZIn2pCRMzqV3tC6Rl1nyzo147IS1YyMAe3HKynZg0q6ATgw4P1+wYRQ8J7cZqBUj9+wpu4I7YqVjpWUVYjLHbztrAVnjt6xPXVAs/0QiNxgf4hvAiiDq62YKVv98fsi8DbSOuDEfLK5REsOfgA41k7UDFkThikw6FbIFmVMd/yhVrxt1CMUXweVSA/sMdFQ1RHMHC3rQkMfj28RFSHs9rTOv6RPT3RFkW2OCV9zqns5cBTjwOjHVJEy90m11IIG09AHCcKAu8vxiHMNW5b5B2wOAF0XlaNErtqN2qTGOI3Gc+EgT7UczJ1LON7VJ9Y2S5/zGs/6tvG8Ywr784u6vKtklCDxVcXfJ4gsdajsPzvmClOq4njWXTwFotHm2tgXVwJyajjQmFMu1IlTG08enH/CghpACtM7keoxnHhHxfr1tfR3PnqN5FFQPuiKNyGEFJYBIz7d5UlxZ0qLwMq3NBIv2avVmsLmgrekE9iI09zwgoDGJ08Ddof7maqPYqZzsg/78glbO9DSqTaIuqApRHVReAPGOaJVtgH+SMlbakTNqsGReFJV4xth2mxb2qRgScbr56LicwZ4lnhxtRXiZzP8jnST5neRZZiYMAdB4lbDuD4S3w8o5lxaQz5D7Sr24SRilMkE01U5VlNPRT8jWO2quzvNjC/hpCtRgm9moma5hFUf1MEkVVIGATzcHzXMP3uiqJeQV2w5zsT4jx+qTLpTh8Tt1UfiPfkh9FG+xTGUKWmouHJ5pnwKPpRlfkdyuZqUISdcUkWSDYTx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(31686004)(110136005)(316002)(4326008)(478600001)(31696002)(38100700002)(83380400001)(8676002)(66946007)(66476007)(66556008)(6486002)(41300700001)(8936002)(2906002)(44832011)(5660300002)(6512007)(36756003)(53546011)(186003)(2616005)(86362001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhjREZvdjRPZWFsNXh5OFNiQUl2M3NJZG41T2J4ZDZYV3RhZzRROElqVVlm?=
 =?utf-8?B?dWN4WUdTd0tmd3N4SWFIc0pxR0dLakc1M0xNbXQwZ2xkV2tVK3VzSWdwWlY2?=
 =?utf-8?B?WHpoM1lFVjZ6eTlIQWhYckxjcSticGRnb3hYaFkySnVWRERRcHdHdWs0RC9K?=
 =?utf-8?B?U1VTRDBmQ2ZaeU1nNFRyWlZ1UVB4d3NuZUxTSGR4eUxXWjBoMUZaYk9EdzQ2?=
 =?utf-8?B?Vm1aT3BwcWF2dnowL3pSZGVLNis5QTdBTGRaWDdpeWNPcWtOTk5Bdmd0Wndv?=
 =?utf-8?B?eUgvOFhVSHhTbkcvS1NETzZaZWtRMW94bFpyY0tZeUQ4RC91bHZtRlNVS0VG?=
 =?utf-8?B?VkYvaWlOREpjNk9SeW1oYlNGWE5uRXVMWVp2cDFYeU1FcGRhN1lSYlNrUlVD?=
 =?utf-8?B?ZGxmM0x5dXlPMHNwQi9zR2RPSHc1NzhnNnJUSXQ3bDBZT1dhUmxlamtUc1Mr?=
 =?utf-8?B?NHQ4SmcxVFBaSUR5RWE2UUdmZEFpWTduM0Rsb2o0RzA2a0VSTjhqaGRCeGNR?=
 =?utf-8?B?aUwzdUYwQmhDc3pia3hGb1gwU2RyMTN6Q3M0NzI3c2tJSlgwVVZldFFMNHlF?=
 =?utf-8?B?bnBack9VTU9kcE44dktNTWlBTDhlZXZ1Snp5NkJkTDVzamJLcEg4ZGRyLzJm?=
 =?utf-8?B?OXd0LzBRRXZrVlM4M09Ka1FsQVFhUzR3WElWTTZRc1hyM0JGSmNocUpRckZ3?=
 =?utf-8?B?SU4yNE9NNVAwV3BvRWJPd0RKT3dsMVBWL2EvTmVYMnQzMmhXeEl6TVMvaXhU?=
 =?utf-8?B?SVNuSTVhelFKTGxJZ1lMVVRZOWJ3eEVEekxaeng2YzVqdHpUajBiaXM0ZStR?=
 =?utf-8?B?VHhHaFZFMVZ6K01kSm5NWUkxU3gwNEdlVUxrOEx5K0QxZVNhNVFOZHhtNVRm?=
 =?utf-8?B?dzJLODlCYkF3cWJWMG9IeFBQYVlSQjZrSmxhYnd5SHAxck9GcnJTZWl2b1dE?=
 =?utf-8?B?NndiZ0dKMjdWRi9WMVRpdDhKZStwcWxBdlVGckkrUFJJS2FrTEs3dmFrU0lQ?=
 =?utf-8?B?YjZhc3dJQmpWSngyZWwwUkJjNUorNlQ5VXZPNkZyOTdpcmtVQmJ4YUpWZzNM?=
 =?utf-8?B?TndCRXMxbEdTSHpIdy9hYXQ5cmNhano2Sjh5VDRqdFFpV3dWMG1XeFE5NUlS?=
 =?utf-8?B?QkhxVFAzMllqUnd1WGxNWnNKdWE1aDV1Y2g5VXc4OE5vV1h6ekxZVGNucGFT?=
 =?utf-8?B?WG52Y01HQ0FocVBKelJPTWJVVXR0ODU4M1ZOR3N6R1BvU3lMMEhzVEpMUGRk?=
 =?utf-8?B?YS9nWlNzdXg4eTh6bUpEemtvL1lUTWhTTFdJd2p2b21TdTUyelB6R3YydmxM?=
 =?utf-8?B?Y20zNWZHK0YxcXFVbEx5T0VlN0g1SHlybUVZK1pRMmNqWCtEVHJhMm13Y2da?=
 =?utf-8?B?Qnl4dkYwTnBFZ3h6MzdDWm9FWG9TS3NvOWZpbWJtekxxWnlpVldRMGxKNCt4?=
 =?utf-8?B?S0NoRzBYYy9sRWZGNWYxMTJHUnpQejViSVJuWEZxREVBRVRRc2F2TDRXZ216?=
 =?utf-8?B?blJUNFpuSjkxQkpoN21tOEU4bXZCbFUrL3l6U1lyY1FXOXI4Z1FKeXVUNlpQ?=
 =?utf-8?B?SlFDcTlmVnJRbnRObk1mcVlvMnB0RUx5SDU4Q1pFNy9QMjE3SXRzTG0rdUcw?=
 =?utf-8?B?T3BpUXFETS90OTZKc1NFMDJXNGg4aituYnppUGNFdnFkZHZNU2Fhb2RQVWFo?=
 =?utf-8?B?UTNla2EzTW1mK1NwdlRtZnpnTkdTME0rM1VOSVF6NngvQVpKa0lZbklRaTRY?=
 =?utf-8?B?UmJRK1Z6ekI0bFlRRmFHSjVnemViYkU3VzdvZXJHNkFDNWNWQ2x3dTVMNUFj?=
 =?utf-8?B?OGdEMTYvdVNzQUFLYnVSbnVoSUhDOXJLYU9rb1pxVmtSMzNzYTZtZjdNOVhi?=
 =?utf-8?B?QUxwaFJZOE11YzAyN25mbklLaXg4VVFvaWUzYnE4bjZNM3hIa2ozVytrR0NE?=
 =?utf-8?B?SUE3QWI3alpJcHN6dDU0RTEyYXV0SktCa2E5RFdlMW5rWVo4bWVPNTRaQ3p0?=
 =?utf-8?B?NDh6V09DV29GUTg0QTZ1WCtkUXpYYmd2V0d5YVNNcFF1TEhqNnp5RlBBNExD?=
 =?utf-8?B?OXVUVTJyRitJUlVWdU5IZFlIYW5vajR1UEhlSlFJekJmNGl6VkNTTlVXd1FI?=
 =?utf-8?B?N2JRVlpVQzFUN0NxNFpUOGVUYWlwcjFwU1RERkFkTitYTXp3NDlVdE1uMnIy?=
 =?utf-8?Q?APiFUtp1TMoETgqhmzy/QEql1h5MNafhf+0PxGXUwrXq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a0491b-2d22-4a75-c612-08da974844ba
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:29:47.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms/osXeWchh7m5VJOpn9SMzpBdB9BHdGUPoDJHkYbrI8Hhpf7cmegkf7y6CAYp8Y77WZZyl9+4xfVz5E7HpH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-15 06:09, Zhao, Victor wrote:
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> The test sequence is executing a compute engine hang while running a lot of containers submitting gfx jobs. We have advanced tdr mode and mode2 reset enabled on driver.
> When a compute hang job timeout happens, the 2 jobs on the gfx pending list maybe signaled after drm_sched_stop. So they will not be removed from pending list but have the DMA_FENCE_FLAG_SIGNALED_BIT set.
> At the amdgpu_device_recheck_guilty_jobs step, the first job will be rerun and removed from pending list.
> At the resubmit setp, the second job (with signaled bit) will be resubmitted. Since it still has signaled bit, drm_sched_job_done will be called directly. This decrease the hw_rq_count which allows more jobs emitted but did not clean fence_drv rcu ptr.
> This results in an overflow in the fence_drv. Since we will use num_fences_mask in amdgpu_fence_process, when overflow happens, the signal of some job will be skipped which result in an infinite wait for the fence_drv rcu ptr.
>
> So close irq before sched_stop could avoid signal jobs after drm_sched_stop. And signal job one by one in fence_process instead of using a mask will handle the overflow situation.
>
> Another fix could be skip submitting jobs which already signaled during resubmit stage, which may look cleaner.
>
> Please help give some advice.


How about the code bellow  instead ? The real problem is that we reuse a 
dma fence twice which is not according to fma fence design, so maybe 
this can help ?


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8adeb7469f1e..033f0ae16784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, 
struct dma_fence **f, struct amd
         if (job && job->job_run_counter) {
                 /* reinit seq for resubmitted jobs */
                 fence->seqno = seq;
+
+               /* For resubmitted job clear the singled bit */
+               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
+
                 /* TO be inline with external fence creation and other 
drivers */
                 dma_fence_get(fence);
         } else {


Andrey


>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, September 15, 2022 2:32 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>
>
>
> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>> [AMD Official Use Only - General]
>>
>> Ping.
>>
>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>
>> We found some reset related issues during stress test on the sequence. Please help give some comments.
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Victor Zhao <Victor.Zhao@amd.com>
>> Sent: Wednesday, September 14, 2022 6:10 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>
>> [background]
>> For a gpu recovery caused by a hang on one ring (e.g. compute), jobs from another ring (e.g. gfx) may continue signaling during drm_sched_stop stage. The signal bit will not be cleared.
>>
>> At the resubmit stage after recovery, the job with hw fence signaled bit set will call job done directly instead go through fence process.
>> This makes the hw_rq_count decrease but rcu fence pointer not cleared yet.
>>
>> Then overflow happens in the fence driver slots and some jobs may be skipped and leave the rcu pointer not cleared which makes an infinite wait for the slot on the next fence emitted.
>>
>> This infinite wait cause a job timeout on the emitting job. And driver will stuck at the its sched stop step because kthread_park cannot be done.
>>
>> [how]
>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>> before drm sched stop 2. handle all fences in fence process to aviod
>> skip when overflow happens
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  |  6 +-----
>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 943c9e750575..c0cfae52f12b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>    		amdgpu_virt_fini_data_exchange(adev);
>>    	}
>>    
>> -	amdgpu_fence_driver_isr_toggle(adev, true);
>> -
>>    	/* block all schedulers and reset given job's ring */
>>    	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    		struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		      amdgpu_device_ip_need_full_reset(tmp_adev))
>>    			amdgpu_ras_suspend(tmp_adev);
>>    
>> +		amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>> +
>>    		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>    			struct amdgpu_ring *ring = tmp_adev->rings[i];
>>    
>> @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		atomic_inc(&tmp_adev->gpu_reset_counter);
>>    	}
>>    
>> -	if (need_emergency_restart)
>> +	if (need_emergency_restart) {
>> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
>> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>> +		}
>>    		goto skip_sched_resume;
>> +	}
>>    
>>    	/*
>>    	 * Must check guilty signal here since after this point all old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    	if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>    		job_signaled = true;
>>    		dev_info(adev->dev, "Guilty job already signaled, skipping HW
>> reset");
>> +		list_for_each_entry (tmp_adev, device_list_handle, reset_list) {
>> +			amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>> +		}
>>    		goto skip_hw_reset;
>>    	}
>>    
>> @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>    		if (r && r == -EAGAIN) {
>>    			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
>>    			adev->asic_reset_res = 0;
>> +			amdgpu_fence_driver_isr_toggle(adev, true);
>>    			goto retry;
>>    		}
>>    	}
>> @@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>    	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>    	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>    
>> +	amdgpu_fence_driver_isr_toggle(adev, true);
>> +
>>    	adev->no_hw_access = true;
>>    	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>    	adev->no_hw_access = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 8adeb7469f1e..65a877e1a7fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>>    	if (unlikely(seq == last_seq))
>>    		return false;
>>    
>> -	last_seq &= drv->num_fences_mask;
>> -	seq &= drv->num_fences_mask;
>> -
>>    	do {
>>    		struct dma_fence *fence, **ptr;
>>    
>>    		++last_seq;
>> -		last_seq &= drv->num_fences_mask;
>> -		ptr = &drv->fences[last_seq];
>> +		ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>    
>>    		/* There is always exactly one thread signaling this fence slot */
>>    		fence = rcu_dereference_protected(*ptr, 1);
> Those changes here doesn't seem to make sense. Please explain further why that is necessary.
>
> Christian.
>
>> --
>> 2.25.1
