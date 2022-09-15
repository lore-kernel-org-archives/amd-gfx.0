Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 18:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5085D10EBC0;
	Thu, 15 Sep 2022 18:31:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD7F10EBC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 18:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1EHrcBC/5UbcSizq6zKPQOOrNBKzLb1AOl6TpaJY+kRt8aD4EWF8FYJcnx3IUF6mieLQPWp4EQjLL/ECG0H5TqG+c2fzxD2oMhdc0R57DewYVa50nFkytnd/o73nVkd0fwMSghJJDQ5HnkeVgeMyICqs8Cf8WAJjFqsxC1mZD7233zuIaXsJJ4BwqSuCMJrdGCWBzV9eA5LJStHAOcbZCNCq8qhyb+Oe8kDJm77fFblxbAiBvwZKp+fyRP0B43iFQxb9sjTGyekuBOM7/ko5rBZlFSZLIC0CpUFO73Zb82LMOed+B+slOVNj/Om4JeXE4JSflPm6W0IOy213QPTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4JrQuOBPgKZVRqTFLt6cRF0z7j3WJatZBd5DWPVYQ8=;
 b=knS04fpngEznRdDXbV2rd7X0tSmOUNXxnS3IiJElRCT+hpgmj3qo/nZ26atmSB3wcWtPq25fCrGgWWEUi0Y+DE3O3NWFxeNKwUqVoQAttIGNn/q8pLpawxbuvRNxwOIAi/lHz5wpfwWUEmKXUQwVaZkXj2Ofeq2/I4fLhi4IQ4zRBqC3MZykl6F3FrRtIwFtFzBHBs1ZMsTS7uk1Xy6QAvKFsYDZ0WGX87Cbfl02QPVMbJvszKFtq9pqwtQ/EQVINQaExKek54TpCzHfxEdDCreSugNy2XhYs4NcwdJhjWUt2vmWPHngvVUrv6OuBirhCsevzJ2ULrvq1ClP8FY23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4JrQuOBPgKZVRqTFLt6cRF0z7j3WJatZBd5DWPVYQ8=;
 b=IN2bx+mtWvxjO3YNKg75kjnFwxMH3XEDiqJV5ZSWCi49C0ok3kkJmqohIUwFu1CI7qp2ntQ3hlsGG4ph1FNe428NBGe92E+d48leosJ8Lfo6colj2DZvSzRBoNZTvosWl+J6hcT5gUjS9cmGg3hZCwRXQ0uvaznv0oUSwQVtOFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 18:31:10 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::a527:1309:e629:789e%6]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:31:10 +0000
Message-ID: <ba3c4f2b-58f0-564e-c2ae-9fb30eda1b32@amd.com>
Date: Thu, 15 Sep 2022 14:31:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
In-Reply-To: <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: a75fff90-c169-47e1-1973-08da9748765d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JHGBsu/4yZnJRakRK8VK1c25qOgPOYk5Eia/uiAxklXXehgCJ8qNGrHs7282dxVIiqA74Z3xtnUc6Lj98qAk0FWl6j/TvvYT6LCxv+HRto/sGePlOCrlZ2tET0RmdT4Zz/4lmaXpprczeT9wk0toMJ7ReWVwv1HTPpe4aV5cpzVDLwRfMxdwCLsU9WoclpZvmy/FrxQXuNGFTdRcv0CewJgGmwD1wSTdTTqjMpum51KyTYdiHjaIR0eOZakp+XGBINU1AysbMtgXByYdff7eu13al37d3vr7aPs2UmdsAO7cW9tDmcVi4+VyrUa39lusepXKFX4xmZdLWOla7CWmwuiLjQdLPkROrZi6O0/X1hral+4qJHYTuLgiMEGIGSw4ODdMZ3lgYodZhXcfVFZ78CDlzgjJ882xFQ8+dn88aplikAATbzjopv3yc96ana2xTLgpJ/JXNKT8kFEdAtA1KzjWnk6dZxB4HEHspnlGcWqXcPkrgyjms+fbo3dCd55IXttiAdzfD3L5461D2tI1NZzDJsIXEgaAcl22pyEUK4klf3NTlTthkMWsGDMinqdAJP1r0gF6sGFGEAsBTEb2ug37roB5E2pMXSH88BXz2myWXbTv52s/+ufweH72SVwXBkQ9hT3zHjsHW3T0r1d8hkDvCuU0hY4GF6M5ll8IM5SOpnd3zAyjyDwUEz2EH5fcJgtFYTxJgP6opztKMc2Ke+LI/fSvyJjAlIq0QaQ0/ES6K+9n2y5EAb18AaigTwQ6CxCPzTXILzKtm6rzwoJzDVPkb/qPSyNW1OzW1vQppg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199015)(31686004)(110136005)(316002)(4326008)(478600001)(31696002)(38100700002)(83380400001)(8676002)(66946007)(66476007)(66556008)(6486002)(41300700001)(8936002)(2906002)(44832011)(5660300002)(6512007)(36756003)(53546011)(186003)(2616005)(86362001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJPM0JuR2NFNGlnbmpBTkx2RndxU05XYXlPK2ZDRDhuR2pjMEJIKzlWSlVn?=
 =?utf-8?B?SGsvVU5xeHNaTmsvZCt6bWhRQXBJVWhQMzFRbzJaZ1pGV0Y1Y2JaYnBlYk93?=
 =?utf-8?B?bXJsNWhqK1lHVDV6d0JmV1VkSzVVMXJ2SG1CdEd1SFlBRlFoSE4xeXY2MWg5?=
 =?utf-8?B?ckltMWY5S1RIMUZQM00vREl6N0h0YUNGV2QzWEJ5QlFtNEZiN2pjaTNQRFdU?=
 =?utf-8?B?WDhXZXArc0Y5clZxYWRnQU9VZStCdVJuOWZtUStDVXlESFdNVW0wTWF2T3Ex?=
 =?utf-8?B?QnFZRStCMjBnYkVIeTFZcmlaTnZwRnM0eVdIVURBZWYybUxyWDIwVUdOdGFz?=
 =?utf-8?B?MFAwMTQ3ODdYMEdxTlNTR2V3bmZSNTBwSUt4Ylk0VGdRaFJ5R3NZeTF2eHhh?=
 =?utf-8?B?Tko5aTNSck9nY29RLzNpbWFzZW5OMTdEd2hlWkdGVHJRQXVjcGVPeW44a0pF?=
 =?utf-8?B?QzJzcndPMWFSTG90enVlMEpsVjNqMGIzWWZXd2ZqdzFrYmFveE56VGVueWZv?=
 =?utf-8?B?cC9nYzBVa1ZydGlkTk5Kc0tySmU0R1lFMVdrc24yemJLN2l5U1Y2bnFVUWFI?=
 =?utf-8?B?SHBSRHdnR2UwMmdZV2lPUHV0T3E0Z0JrTEEydWN4SkJ0QnVWTWFHUzArMXpZ?=
 =?utf-8?B?WENKWXAvclpFUXFkbzdwK1NoeFNScmJtSHpxeWlPUWR4R0xBUjJLVjBrT0Ex?=
 =?utf-8?B?OFVYUEEzQlQwRUFpbkx0T1kwNFdVa1BpTXVKNk9ySVh0UmdRb0pKaHJVaGZG?=
 =?utf-8?B?T2l3c2N1ZW5hcVFkNVFRZUlhSDdPVnhySHpNKy9aeHVKNzZkckp3MDl0QkFK?=
 =?utf-8?B?bFVFZ2FXSGQ4YktodUd6L3RqM3RISlY1NGlUZDBWY2crcS9BTWl4amZBcDht?=
 =?utf-8?B?ZEUyZ0h6VWRkL29tdkc5cmR0QjQxRlB0TjFWazh5dHJ6d2RETjZjLzc4TXFn?=
 =?utf-8?B?dVZIZHZuL1c2MEJEK3lnMXlIdDZxUTdlSGlJNEk0QThUZkJGb1NOUmZVd0ND?=
 =?utf-8?B?dlljNFJRUm0zdFJObldiTWFUL3FCdys1QUpQVk9ya2RkSE02YWp4VVRkZFZF?=
 =?utf-8?B?NFNXdlZpZENVODJTdVpTR3FXc2JmcnA3TGVXZEhOaFFHaWtBSWkrQ21uMmR2?=
 =?utf-8?B?VDU1aFZ5Rnlsb2tFTk1rT2UyZThNQTNvQW5uRlJDM21NcDFVWWs0dFRkUE5q?=
 =?utf-8?B?bnMvSGVmdlBNVGZreGdMdjVJeTkvdllTSEtIUmRoaXJsZGdaWHZRYzM5UmlE?=
 =?utf-8?B?ZkJsWjJTNnlDZWV2ck1oU1dJZy94TUMrU09yNVo3NDQ3KzFnbHVhT1RVVjZY?=
 =?utf-8?B?T1EyVkpFM0E5YjArSHJ6Q1ZHc0NQdS9FWm5oNEZWV1d2MEt4eXQrSVpvbTZO?=
 =?utf-8?B?TnBCcTBhMGo5Qk1mbDBpOVBMZWRONVhvMUhtTGM3WkdSdUVUR1RGUCtEMHZz?=
 =?utf-8?B?R2RKc21tS3ptdndlYzFZVy9QeGNNOGJrYWkyeDUvNGVoenNObTVna0d1K0JB?=
 =?utf-8?B?K1U2VVJKVlNOcitYSlhCSm0vdVRpcVhvdkpNbVhTVEpLM2UzU1hxZHVXRWNm?=
 =?utf-8?B?WnE0WEdhdTFHS2RMckpPcVdoR21rQmFUVG40VllMWllkbU1kb3lBU1FwU29h?=
 =?utf-8?B?a2l4d0xuY2t3aVFCNmFEeVRURVZYcUtCRG1JM3BOVnlyWnpXeHFneUFHTllq?=
 =?utf-8?B?UlVjMUtPK0U2ZG5pak1GYlVaRURZNENTbEVoWjlQdFpicVVpZEZTT1I4UHJB?=
 =?utf-8?B?SVYrcDVDdzQ2TDRVekJFRUhWaFhsTzZacWZaR214SlFqSUwrbUdFTThBZlZI?=
 =?utf-8?B?eFd2K1VBcVNSN1RjdmVPWm92bVhmdUoxWmtLTzYydjJicjB6U2hVbWJaN21x?=
 =?utf-8?B?eVNZS2dRYnY2d3NndlNsbEhndWQ2V3NoOUcxa0dxOFR0ZmlvS0EzM0ZaaVBJ?=
 =?utf-8?B?UVgxMEZsNVpOcko3R1hvUUVJWGVPbnVoZnB6Wm4xRno3cm1XTkFyUnF3VC9j?=
 =?utf-8?B?UWVKKzJ3OTVKaXhUSjdiS29OZjdhZjlWWnRGVytZWnZGd3pIc0VhSU9vQm1w?=
 =?utf-8?B?cS92Y2tzYVdNK093RVd3ZDB5Vzg5OU9rS0hvODNzOVU0YXI1Qm81UVluWW5U?=
 =?utf-8?B?V2o3TzRpbDVCWnFlK2FLZ3ptYXNLVlFUaEFoY3BrUDk3by9Ca0R4OGQ3c3Vy?=
 =?utf-8?Q?PCETtzcWETjpeqUmBgmX8DpF8yh25Pzz0f2ijeXuTkcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75fff90-c169-47e1-1973-08da9748765d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:31:10.7161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PEmVVkvI2f87obr5IxyMLhPEFJlSOD8z7q18PNPI6PVMlC74tzgcBYTWYJX1Lsh4PElqr9j5AtMDuDzVXGybA==
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

Had a typo - see bellow

On 2022-09-15 14:29, Andrey Grodzovsky wrote:
>
> On 2022-09-15 06:09, Zhao, Victor wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Christian,
>>
>> The test sequence is executing a compute engine hang while running a 
>> lot of containers submitting gfx jobs. We have advanced tdr mode and 
>> mode2 reset enabled on driver.
>> When a compute hang job timeout happens, the 2 jobs on the gfx 
>> pending list maybe signaled after drm_sched_stop. So they will not be 
>> removed from pending list but have the DMA_FENCE_FLAG_SIGNALED_BIT set.
>> At the amdgpu_device_recheck_guilty_jobs step, the first job will be 
>> rerun and removed from pending list.
>> At the resubmit setp, the second job (with signaled bit) will be 
>> resubmitted. Since it still has signaled bit, drm_sched_job_done will 
>> be called directly. This decrease the hw_rq_count which allows more 
>> jobs emitted but did not clean fence_drv rcu ptr.
>> This results in an overflow in the fence_drv. Since we will use 
>> num_fences_mask in amdgpu_fence_process, when overflow happens, the 
>> signal of some job will be skipped which result in an infinite wait 
>> for the fence_drv rcu ptr.
>>
>> So close irq before sched_stop could avoid signal jobs after 
>> drm_sched_stop. And signal job one by one in fence_process instead of 
>> using a mask will handle the overflow situation.
>>
>> Another fix could be skip submitting jobs which already signaled 
>> during resubmit stage, which may look cleaner.
>>
>> Please help give some advice.
>
>
> How about the code bellow  instead ? The real problem is that we reuse 
> a dma fence twice which is not according to fma fence design, so maybe 
> this can help ?
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 8adeb7469f1e..033f0ae16784 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, 
> struct dma_fence **f, struct amd
>         if (job && job->job_run_counter) {
>                 /* reinit seq for resubmitted jobs */
>                 fence->seqno = seq;
> +
> +               /* For resubmitted job clear the singled bit */
> +               celar_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +
>                 /* TO be inline with external fence creation and other 
> drivers */
>                 dma_fence_get(fence);
>         } else {
>
>
> Andrey
>
>
>>
>>
>> Thanks,
>> Victor
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, September 15, 2022 2:32 PM
>> To: Zhao, Victor <Victor.Zhao@amd.com>; 
>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey 
>> <Andrey.Grodzovsky@amd.com>
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>
>>
>>
>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>> [AMD Official Use Only - General]
>>>
>>> Ping.
>>>
>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>
>>> We found some reset related issues during stress test on the 
>>> sequence. Please help give some comments.
>>>
>>>
>>> Thanks,
>>> Victor
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>
>>> [background]
>>> For a gpu recovery caused by a hang on one ring (e.g. compute), jobs 
>>> from another ring (e.g. gfx) may continue signaling during 
>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>
>>> At the resubmit stage after recovery, the job with hw fence signaled 
>>> bit set will call job done directly instead go through fence process.
>>> This makes the hw_rq_count decrease but rcu fence pointer not 
>>> cleared yet.
>>>
>>> Then overflow happens in the fence driver slots and some jobs may be 
>>> skipped and leave the rcu pointer not cleared which makes an 
>>> infinite wait for the slot on the next fence emitted.
>>>
>>> This infinite wait cause a job timeout on the emitting job. And 
>>> driver will stuck at the its sched stop step because kthread_park 
>>> cannot be done.
>>>
>>> [how]
>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>> before drm sched stop 2. handle all fences in fence process to aviod
>>> skip when overflow happens
>>>
>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---  
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6 +-----
>>>    2 files changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 943c9e750575..c0cfae52f12b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct 
>>> amdgpu_device *adev,
>>>            amdgpu_virt_fini_data_exchange(adev);
>>>        }
>>>    -    amdgpu_fence_driver_isr_toggle(adev, true);
>>> -
>>>        /* block all schedulers and reset given job's ring */
>>>        for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>            struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6 
>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>                  amdgpu_device_ip_need_full_reset(tmp_adev))
>>>                amdgpu_ras_suspend(tmp_adev);
>>>    +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>> +
>>>            for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>                struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>    @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct 
>>> amdgpu_device *adev,
>>>            atomic_inc(&tmp_adev->gpu_reset_counter);
>>>        }
>>>    -    if (need_emergency_restart)
>>> +    if (need_emergency_restart) {
>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>> reset_list) {
>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>> +        }
>>>            goto skip_sched_resume;
>>> +    }
>>>           /*
>>>         * Must check guilty signal here since after this point all 
>>> old @@ -5240,6 +5244,9 @@ int amdgpu_device_gpu_recover(struct 
>>> amdgpu_device *adev,
>>>        if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>            job_signaled = true;
>>>            dev_info(adev->dev, "Guilty job already signaled, 
>>> skipping HW
>>> reset");
>>> +        list_for_each_entry (tmp_adev, device_list_handle, 
>>> reset_list) {
>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>> +        }
>>>            goto skip_hw_reset;
>>>        }
>>>    @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct 
>>> amdgpu_device *adev,
>>>            if (r && r == -EAGAIN) {
>>>                set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
>>>                adev->asic_reset_res = 0;
>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>                goto retry;
>>>            }
>>>        }
>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct 
>>> pci_dev *pdev)
>>>        set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>        set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>    +    amdgpu_fence_driver_isr_toggle(adev, true);
>>> +
>>>        adev->no_hw_access = true;
>>>        r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>        adev->no_hw_access = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct amdgpu_ring 
>>> *ring)
>>>        if (unlikely(seq == last_seq))
>>>            return false;
>>>    -    last_seq &= drv->num_fences_mask;
>>> -    seq &= drv->num_fences_mask;
>>> -
>>>        do {
>>>            struct dma_fence *fence, **ptr;
>>>               ++last_seq;
>>> -        last_seq &= drv->num_fences_mask;
>>> -        ptr = &drv->fences[last_seq];
>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>               /* There is always exactly one thread signaling this 
>>> fence slot */
>>>            fence = rcu_dereference_protected(*ptr, 1);
>> Those changes here doesn't seem to make sense. Please explain further 
>> why that is necessary.
>>
>> Christian.
>>
>>> -- 
>>> 2.25.1
