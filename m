Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB3ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 19:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850E510E221;
	Thu, 15 Sep 2022 19:26:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A850910E0C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 19:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH1i9cFYPs3w3tQAAn03GpYwsWdAKky+irhiyHq5ayeC39PdLzWy+SeFf6cyaYFiemE1MtAtOws9P+hFljL/xCh50gBnNu6+882zsWfQhqc0HCkNnyD6dtghnZ4NtGh7Ztw0qPM5brXBx64ZhhwgtywyMHgnz/Gwk+1CME49Cnt8JbtGXgg6d0nhdV4rCi4szs9PtS6uoaXhW9OVaAeFLtNrtG0BQ04W9C6/MWzs6Ao7vHb3xjxm1byKElbYod8KGJCl4CxqNRhRGAIZ0g7Of1Vadrz++a0NC6WO7C5WKFGhu0rkaqeF3/XJ0S6dcv1ZNY4rDRj++xMnvqNPgN138w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPDAwYyHVNsaoUWcARrqCduainMVuymo12lM1VP6Dfc=;
 b=d0Om1PqskDjtUWLLflxSdX7XaFuNl53raCjWBHM3l/imexdjdS4Lf0dzeOcJU4Sj06UntS5QaIisBWW/+6/7qBJ/NRSUZh9psS3jLFXl3XE4NAhcf2iE6nOa8vjPFN8gRu0kAo3gN8apyh4pyKNGE/96exoNcHE0gxrKcowQncEXtSw4GcKT242VfKmZojZOyVGAwbTg9fGUA6xvvcBZJd9piNySHlYQ4UJ9ky5MaX6mLIEmuAGa/Hkrldp4BldHBYVU2nLjfn/pUMfDZbpxwMo3eWiRI34CX1ee8bvNp9hUOp0mig0U4U9WdgkLzUzleN6w4kyqXTVXVUFCwXdOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPDAwYyHVNsaoUWcARrqCduainMVuymo12lM1VP6Dfc=;
 b=BXzimu2b9oSpNari1y99UIloBgYOM2ldLQf6OnQZwL0sUZsQnwlPHGtcbn+eMj7X48wVyJPg6+KYxGA9OEe7H8Q6d49SSO0bI1pS3gfi48JW2K7hhhiZxQb+7H3WIfh7ay/a5z4AcSufYnK/BU0jrNOCKtH/dVMwEO+D/XjRQsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 15 Sep
 2022 19:26:42 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 19:26:42 +0000
Message-ID: <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
Date: Thu, 15 Sep 2022 21:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220914101025.366954-1-Victor.Zhao@amd.com>
 <DM6PR12MB4340D28D9D23472D571727D7FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <1ea8528f-fb55-e8b1-73c8-bf8935f9870c@amd.com>
 <DM6PR12MB434047014434C43396BB2D31FA499@DM6PR12MB4340.namprd12.prod.outlook.com>
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ad4fe1-4c7b-43f4-3196-08da97503812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86E0hSxZjFmgRJ2Iic3muT5hKDRwXy7dh3rXOw8e2z7I5vdvFid7OSVtcAVWMeQ4nyzG9TbXihrCNqD65PSl2pHz0SMJNGQCRiiF1dmk1rQW28GrjWNlpVJbQaIEE+6znyfaRyu5Jj8pkgpIiMwIMcKRqHywU4DAXb7zGJH39MBb6RouFTRPJD3lTiAlAKq9V82Z16dEaNZaJ/JAfJ4m4f5kxt8Iw/cHt7d4Et1yMizX3/xShP7cMQw6hJ1UhXA/RR6e8uQMfBj87hZyDvBfdBGxto12KzzK3K4XSZr+nbbgc7jgiGnqAaI5zhk58o2eWFXSFexWIiF+95/DatwKgs/ezdvR6wTqi+ZEIZ0louFjZKgzI7mTUPouzJJ7lY04p6mMUQbBwYpp4nSV8LqDDBLQCInm+5PqKq4OBFUoiGbn8BuEz8hTp6GCy/A5JcmwDTycHdTzIn6bePfuhAu4V6Z9idxDHzexvGK7iqHdyYgQeHLHlvxh40uYT9Q3KSV4EKwIkCvdKB5P7p3lCNOir6wo398tA+Rs3ApqwmxEZ/wN7elzxOgYBxu0ET21K+69nipfjj7JAOZA2+DJrHHELOCEBO9k3Xc1rJZXZc9aNNy8fpIdGgY8JT2kNaAImUbabGhg62WNlOklX7l6H1DWsKMezYC7c/0KBn1BiHJn7s/AUMwivqlpel+3zvKARMnP4VzNxrQYATU3Lm82z0YI6k5+vL+IPwtiEGwLbvHFYfLX6sZJm7XKO433n4ezG1pCZ0qqOK52tNOJz7enaTcJU+3Urg22Kpm/3JNmBhDukiit7IlPiaV5X4SOsB6uTz8POrboQgRkzro7uvKley4x8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(66946007)(110136005)(6512007)(478600001)(8676002)(83380400001)(6486002)(41300700001)(38100700002)(2616005)(6506007)(53546011)(31696002)(31686004)(316002)(36756003)(186003)(86362001)(2906002)(5660300002)(4326008)(66556008)(6666004)(8936002)(66476007)(509564003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJVU3lIR24zOFN0RjBWMnhWclVVMWEvVEp6MWppbnNDRmIvR3VGbXJVQWxy?=
 =?utf-8?B?NE5CSzVnOXFMMnYrdlEyMzh3MVZJeGEyNVBkVExteEROVFVhbGZVNjRBalRQ?=
 =?utf-8?B?SU5ZVWpFV2dhZS9nNWRlZ01ZUTB4N0VzM05aM1ZnZlRDelMxajNST1ZUSTQy?=
 =?utf-8?B?WTdBWFpua0djREY4UFRLUnRobEcrTzkxZ1ZWSFZkMXdIa09zVmxhSVZjV3F1?=
 =?utf-8?B?My9icTBMNXh6TzNjM1JueHdPMGdrSFFxTDNVd2R3Q1RzQXZGOHN3TWpycktZ?=
 =?utf-8?B?eGFGTlJYVzdxdGxxQzR6Y1k1ODA5Q3Z4ekpiMGpRQzFKaEtTVVE1WDFHRWVE?=
 =?utf-8?B?WGlCVENSbnc3U0JDeTBrRno0ZzhEVW5oU2czWUh2ZTRUbGpkMVc0N2xiQjQ1?=
 =?utf-8?B?MEF4bzEySTNMcVlQK0wyZTkvTzF2Nk1lOWpDYjU3UU9MUW9GTnBNZjlCRU9V?=
 =?utf-8?B?Ty9USG44b3dYMUFuV0JmeExib3QyU1RhNUtxSm5ST2s3bFlManFQeUlDcTRr?=
 =?utf-8?B?aDlkQWFNbVJkMDdMQXhvN2srZndaUkZ3cmZBOHVNNVYyZnlzZnNNVUFRNTBU?=
 =?utf-8?B?MWtUUmJBWU9Fc1N1c2tUVlIvQklESGlIRjB3TEFpa1EyQ0JCNldUU1RpeStX?=
 =?utf-8?B?dVVNdVh6bXBWSStqR1JweDlHVEdEbzZtemxlcm1QQ1YwTWlIeXFZS2d4K0I5?=
 =?utf-8?B?QWhRc2pjZjJ0eW90Zko5QlhwaUt5bUhtTG04dzJEV09hOThPR0ozTUhNK1Ri?=
 =?utf-8?B?cUp2OEI3Z3JZV2pmTjlLYlVyZm5RdCtvQ0RNcUwxRFR5TXN5dnl2ZnZNalhz?=
 =?utf-8?B?amlqd0J2ZStuZ0pMYlcvL1EvMndTVEZMVmY2YXUrOG0rcVpyTWw1RG9weitu?=
 =?utf-8?B?STZiVTNIQnFpbDY4MHFBMjhiTGhUUDVFaUFWTDVZb2Y1NTNsSDFxYW1maFlP?=
 =?utf-8?B?dGxZQ0ZvLzgybFlZSE9KUVNRK1VNN0dGdmpZQ1g2QTFKanBCeDh6WGxGL3E0?=
 =?utf-8?B?OGpEMjQ2NU5vamtOajFEVTU4dEhoTXEwV2NZTGpaYi9CYUh3K3djWjBDbTdZ?=
 =?utf-8?B?VHJxb3V3NW9MWXVUZGRCVU50QzZwQ0ttWSs0UzdlTHoyUis5WXBmeTlqWkN1?=
 =?utf-8?B?UVA1Z2pRdFErcFhjR1Rvc3dqb25ZRkNLN1BYUWVRa21sNUxFdTdrK1pzeS9O?=
 =?utf-8?B?ZEQ0Y3lwRXptVDdlMVR1RC9MeE55Vk80YytneVZxb2NnZWloSDJER21ESk1h?=
 =?utf-8?B?WU1NODJhSTFNS1RFaGRMbHl2N2Nqd2c1NXdvVi9TVGlvd2NzSi8zeG03QVVP?=
 =?utf-8?B?V1g1bGljUEFrZ1JPQ2lmWjFGQ0Q5aVd6YjZuQzdhdEFGbUNqSWZSQjRxaXlp?=
 =?utf-8?B?OFE1UENLbkVKNlowc1JHS3pwVER1T3B5RTVrZlNCUVVnM0RrclZXa01rbmdt?=
 =?utf-8?B?YXF4RklhUTBNRnljNDVqOEhZRmVMTkRkTlF4YkZISXlNaTBnTHBSRm5MZG1R?=
 =?utf-8?B?NkdmYVpTbzRmRUx4U0VhWjExQm12WkNPbU52OUJSTi8rY1pndUhORHV3YUgx?=
 =?utf-8?B?cnp6OGxKaDFPNlRocExEbytsOHlPU2doOFMxR3lncTBZZUlMVVRieUp3ZnBr?=
 =?utf-8?B?OVdHSEdndUVVWjBESGRZZVZsdCtvM1NETWc1WXkvMUMzMWZhYlA2d0U5VU9x?=
 =?utf-8?B?ZkJMRnBlSnE0eWE1M0JZUStsY0tjSzhhLzdQeHdYSVE4eVlzb0JCWEl4ZVFV?=
 =?utf-8?B?aXI3YXVwNElLeW1lanNwejc3dFhwQVVJdCtZSUNyS1FCMTdLaXpzTEhydXQz?=
 =?utf-8?B?dDIzYzNiQnlOOGdkeFRHdTB3VTlvUkZ4aUhNOC9EVkR1NHJrd3N0d2xwZERu?=
 =?utf-8?B?Z3h6VkwxY2tsMzdhcUwrTUFCY2JCUlBaUC80Ykx3TTdpakw5eStqbXViWXdW?=
 =?utf-8?B?NWl2dUxhU2tjdm84NTdvNjJDQ1F6VEZUK21LekJqRkEzZ1lUaTdWa29tRDdU?=
 =?utf-8?B?aURHNVBnWC9PY0hpTkNSL011T09pUm1pMFgwR2tmR2F2SkplTGlZUHNrZXdw?=
 =?utf-8?B?K2loaVkxM0MvRk42QW1GMFBENVc1VDRaQ0cwQ1BTWVZ6Z3dZVFN4NjZCT1Np?=
 =?utf-8?B?amd6em13MC9SSWlldXQzNVk3SDhudlh6ZnNBTFlxVXg5NDlLU1RKUkVsWWhR?=
 =?utf-8?Q?Rmza4V0Zi9p+lh43VlbJH1yHbzKLCST1jJSrl0BaxFoB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ad4fe1-4c7b-43f4-3196-08da97503812
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 19:26:42.2584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Cz5WtRsmkjd/V84qKbAzDXnab5dt1mthEOvZLD9bHAMu0rBW9qFsLrIiE7DOFj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
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
> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
> +

Upstream will pretty much kill you for that.

Re-setting a fence from a signaled to an unsignaled state is a massive 
no-go.

Christian.

>
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

