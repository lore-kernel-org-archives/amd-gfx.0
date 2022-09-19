Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D602ECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 15:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE7410E663;
	Mon, 19 Sep 2022 15:04:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395AE10E663
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 15:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUYHnjKywFbE6jRG3eXsfCFO2lboA89ssRJO2hfXik1B2Iy5iQnc5ZHo273b2xaQhD/pFALxS7qodkFhjbfJxHr9dBIxt0pBSYU9kVLcn10P2TUyGTWD1ix5/tWP/Px4/1YNh/8L7lBxiYBQbes72CJmU7xjSO5DZv/ITA8W+xkWrbdj2W8CrF3SQjQ2xj0IfrM82mauDn0t1rJiicqdX3vwqqRckkbP6byFX7PxrP16G0rJTZ6hKQcXGenWJM9QzL7n5Mius36cUBtUOLmOupLPw+Oxuxt65wnJJ+R4wQ3BSosbTSg0GhE+jU1gT2FKNzZ0+5+L+rI1ySA3LApNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tenFydU/Yqbqi+kMCUgkmRsxvqubqYK8XEfj9oAzAw=;
 b=FKpd5nuZ78/ROnMXIBqBXJ9K2F9aI9sjI3tEqCg4e6huRRu1ohuFiIDivUM+AGUgbcTT5Cg/h3XOl9DasiwOTC1ycjN1fDG1KVIZICQAFXlXUDlSbAxJoYvRMvpLQPZU77QYqE+9IHEt7TYJ2t+05nFU17qK0GCtELxPAN1dMR+knKZOUi1bVWdCppnsA81teszsBI55tdgNUQFCFmkkzyluVt0ErsJa1cMRBJxHErm6Fi1oKefoXhUpGFMIjqTcfR5iC5BjPa74+hR+Rii8XfFJCduq9qPF4m65ZhwXlO7JqNvulL5k10Zuov2+zjvxpeJVVMxQvkgkDhedRp7NkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tenFydU/Yqbqi+kMCUgkmRsxvqubqYK8XEfj9oAzAw=;
 b=RYP7MhwiHlpUerd7Z7857pWFx1cYaT9rN6R0JB/4tH8e8fex/e78UtdATPscywHrOUnAqFTLG4hoUe+J4aiCmXc0OSQP23hyYNIRbJhrTt5wQMP3Fo7cvjXKTFO8YYJQc9fjdqldH8R471KBPLU+PDfdYRXFbw/imfPuEWb+qWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 15:04:08 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 15:04:06 +0000
Message-ID: <69b2ffb7-b216-9f7a-a248-4e3d2ee4908f@amd.com>
Date: Mon, 19 Sep 2022 11:04:04 -0400
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
 <e7eadc0d-c9a6-8a12-bbd7-5dd3277a7754@amd.com>
 <fc7f7d5f-3d63-234f-1864-ab365d6e338d@amd.com>
 <378f971b-9ee6-5fb3-4143-f20b873d0b4b@amd.com>
 <3ee47f74-fca4-f78c-9235-972d4543d880@amd.com>
 <d4fff5a6-833a-161f-d86e-b17cb9d9382c@amd.com>
 <DM6PR12MB4340BA5F434240E73E5E5F8CFA4B9@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB4340BA5F434240E73E5E5F8CFA4B9@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc4ab0d-8c92-4814-d524-08da9a503272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AW5Cvuow1wVjiQeRgjMn7FQkncd51jC+I6YZa9atnXYN9nY2LoAEgi382Jchq08i2/3qM/li/CjZqUajuLD6V7Q0Di9DLI2qMXsea0bBxjAL1h5VlYucxvtzO2ibQpjMiR7UiRAUA4LuLSFyNwgy81gpbLDg/EWqISgR/hOueBxFk5mTGi5p8E5yx+AXpGft9R5vwlDHZp3lS+SktpRcWgfUwkISDQt4PHi/Mu2SGnXMKSaxJp2da4noEuocrJ6UgmookQGkgHLivsoDYV9RkfqcZSMx5h68ur/L/C3l1oGW7fROayY+Kz5EumHy+VmWH8IMoBHqM1ibM9983rK3xAFP1dsGUOuUAPM+eYdYCod316YMywog1UyqOf6yq5ntHBA7v7cygOxr7EV9MFc5NoVTGAXQsuzYIpBIWBv8W3ksCw7AIdwsZmW8umQWVUDurRztEh8NyUY1ZD/Qk968/4jFHCU19OTtddH3TmPwby0hAgHSD2wxFvKZqMwlfnxlK+Qfg5OFye1kxd4eSVqmfphFdg2dwE2VPOOKKc3kz1f9QL2+A+xgyGsFGuohRbbNtQzFS48Mu32+EeFfxmJY3o/Fa9yU0nwRgUW31sGg5wcctAaMahI/XXKngXvl8HsEUC3fggtWAVzCvwS9v+RMJt2+mu005p5NOQXoFdsB43wOw0TvYa/w5xrX5WkNbabn6tIRk/60tkKgAhlxZiexZpr4OHct19xdyHnoCg+OqTu+wHGq698J/cv6ZUhjN+wNhRzcwoABptvHt7mcZ5jzjO9ZT+0LhbQGG6qk0iMj9aG+XyR/nqF3FP7oqVWoIK3o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(478600001)(316002)(6486002)(186003)(6506007)(66476007)(4326008)(66556008)(8936002)(2906002)(6512007)(41300700001)(2616005)(83380400001)(53546011)(8676002)(66946007)(110136005)(5660300002)(44832011)(30864003)(38100700002)(66574015)(31696002)(86362001)(31686004)(36756003)(509564003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVTNVdidzFGNnBFa0xQaFNDMUZ6V2ZXaDNkZXBWMG9HYkZoMGxsdkw1V2pk?=
 =?utf-8?B?SldlQzlJZXc5Y0ZVOWxwN0J1a1ZSSDdNL2g5UVFLdkdIdGhMbk9ObzhxelZT?=
 =?utf-8?B?dklpYkd2L0xTRmRSYXFEY2NlcnVFSGc1NHJ4Rmw2VE0yQmJINE10cjhHeDJI?=
 =?utf-8?B?bnRTNjQ5M0lNWGVyRFpmT0lnclBraDZwTWdZWHpHWWZmRHVXSEZmZjFJTTZ0?=
 =?utf-8?B?dmJ0K1ZONXVVUVRmdVZadC9DL2FRMGZKNWRzZys4MWhKeU9BdEllZzkrYURp?=
 =?utf-8?B?R0Q4VUhvTTZTMEtXSWtDVFBTTDZGck5ITEl6aEg5UXN4R2tpeUlsNjdHTlpL?=
 =?utf-8?B?cUlvWlZmNE9odlI2aDJvSnB1aGpkeXNPc09TM01raDVKeFVaLzNDY0dML3RN?=
 =?utf-8?B?ZWF2QVk0TzcrK3o4cEU2Y01uMjB6TG1CZXVud210YmVWTm1IRHBma2dkOEFG?=
 =?utf-8?B?YnltZitMQU1XR3lHbk44U1FEd3hLRjk4elhoVHdxYzdWeXBSMGtLUXZZVWtt?=
 =?utf-8?B?OTNpU3JnSEJmYzE3cWlMWGp6clpITTRSYnlWQlVuQXlmVGhyanEzZzRMN3d5?=
 =?utf-8?B?WHgyR3MvN1hKK1RtYkJBcWF2K1FoR3B3K1V6b3UzMVJheU9RaUJ0T1lOU0Na?=
 =?utf-8?B?eTNBaVZIemh1YmlLcmwwNWMrWVdJWXAxM2lpV0dGbmhjelRBMzYvNG13cG5v?=
 =?utf-8?B?R3FOMGZtUlM2MmhRYzlFY0RMaHdac2pQb2I5TjN5Nk9oSWxZdmxXSFRQaEFN?=
 =?utf-8?B?a1F1UXBkZGZ2VjBYb212S1NhTTYrUTdMbm13alhDSU9hZUVoQkVhak1CZzdm?=
 =?utf-8?B?OW5wZG1McEF2akkyeVBHSzM5WEtVK1ZKU2xYbS9ZVWhjTnVpY3c2d0xwRFNr?=
 =?utf-8?B?VzlKb2lERmtaemxKTythdDkwV2kwOWdhOXdIVUxyYzlXRGtTdDRuMVp1cFFG?=
 =?utf-8?B?N2RxazBaOExEc2E2bGpEbjR1TEhpczF1NU01Mk9POEs3b1RPSnhRNTFodUwz?=
 =?utf-8?B?N3ZTWTRhdUR5eVlCSHFpbGJmMmtvSXU2bWlRYm9FcGd0RkhnWU4xR3BrZ2M5?=
 =?utf-8?B?NXU0TGlWREx1aGZqNHpxYnY2SmdwYlBlMHZQek1jNy9JaFBwTEZtR2c2WldI?=
 =?utf-8?B?eGlCRVArdDZJWm1od2hTUGVaY2lFaTZQV3p4RTA4eTc2eUpoaUlubEJ0NUJY?=
 =?utf-8?B?UlRkRGNhV2Flb0dHbDcwN2tNd1pnbDZ0Ym5LZlVEcWFDSHZTclp3MzNnbWEx?=
 =?utf-8?B?SG1uVHBSKysyWDdHcDhLTm5FeUdXU0FtR1U0T2ZaVFR0U2JZdEVyUWVtMHpR?=
 =?utf-8?B?TzluU2cvWE8xUTNxOHIyNENNai93QXRqOEcrc2pwTTJWRHlvMmNGaHRraVJu?=
 =?utf-8?B?TEhhTktVTlBlMkozQWxXRHR0UW1GSGYrZnRUR05teHN3bEpxNlVBcUVEYnZ6?=
 =?utf-8?B?WWpaWi8rS2F3ZjJKa0F6eEh1R2ZCSzlZZEQrWGRHd3hvaDBtTndSNCtZQzlX?=
 =?utf-8?B?TDZ2NHNXSjJQc2gvRkk3SW00U1dxQmlaOFpRcmQzTHhTV3FNMEkydmxoQTVh?=
 =?utf-8?B?ODdmZENaa0lGclo4NGxsYWZZQXN4dEJGbHpxeEFIcDFYYVRrZDBwdEc2Rm1y?=
 =?utf-8?B?eWpzTzNrWUcyUjJhNWsvVmxPakE1bnZkMUt1UENMODZxMm1Jb1o3VEFyV3hJ?=
 =?utf-8?B?NlJKQ3JqQkFXQWFSRStGZ2g4Um5XN2RjRERVb0ppQjFXMkRDeTBuMDhHakpR?=
 =?utf-8?B?NjZZK2s2YjlBRDNvOHk4YTUvK1AvOXhZT3RWazVERDlBQmM1am9MUE1BR2tI?=
 =?utf-8?B?WTRIYkcxSlFGb3pUZjRkQ3NPc2pBSFNZK2xJaGZJaUpodE1ZL2xxdlo3S0pV?=
 =?utf-8?B?akF4SDJla1lqQytTMjdnQ2hzeFJNT1pMV2RyRk5wWThFMkRSbDVOcWl6RnpY?=
 =?utf-8?B?Z1VLeFhRNmtMd2FoTTdFaVY1WVNhYzVLSjRqcEd0RVRlQ2dEb3g4UjREaklt?=
 =?utf-8?B?WndabElJSVE3Wm5xVk42SkZZQkVjdXJkeThjUDZtdU8xODhEWHNRTUlUdFla?=
 =?utf-8?B?QnhJaFBzTk02aVBZaUlmOERsNzlSYlBwL3EwVnRNUmZHZVVhOGFIVHBqcFJ0?=
 =?utf-8?B?bUlDVEJKM3RPQ09SbDN3bTVDTWVaZHhYaTMxakVsbyt4R0JTNVU3VTZCeFZj?=
 =?utf-8?Q?aUK0TIzlUhhUGu0j+BpkAZ/octJgv0SNmO9CYoW0O2I8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc4ab0d-8c92-4814-d524-08da9a503272
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 15:04:06.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAtaI3vyRQb7CJ7qxjbs3XZJfasA+2ZiaFCp41mCaNTNO01gAUgYqBW4jegv92wOx53Aqkf5ewKetv6Ilef0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
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

I don't know if issue still exist but it worth checking with Christian 
who wrote this patch.

Andrey


On 2022-09-16 23:31, Zhao, Victor wrote:
> [AMD Official Use Only - General]
>
> Hi Andrey,
>
> Yes, moving irq disable can fix the issue. Change in amdgpu_fence_process is just want to make sure driver can correct itself from an overflow situation. Didn’t know about the previous issue there.
>
> Do you know if the issue still exists? Or is it on VCE only?
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, September 16, 2022 9:50 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>
>
> On 2022-09-16 01:18, Christian König wrote:
>> Am 15.09.22 um 22:37 schrieb Andrey Grodzovsky:
>>> On 2022-09-15 15:26, Christian König wrote:
>>>> Am 15.09.22 um 20:29 schrieb Andrey Grodzovsky:
>>>>> On 2022-09-15 06:09, Zhao, Victor wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>> Hi Christian,
>>>>>>
>>>>>> The test sequence is executing a compute engine hang while running
>>>>>> a lot of containers submitting gfx jobs. We have advanced tdr mode
>>>>>> and mode2 reset enabled on driver.
>>>>>> When a compute hang job timeout happens, the 2 jobs on the gfx
>>>>>> pending list maybe signaled after drm_sched_stop. So they will not
>>>>>> be removed from pending list but have the
>>>>>> DMA_FENCE_FLAG_SIGNALED_BIT set.
>>>>>> At the amdgpu_device_recheck_guilty_jobs step, the first job will
>>>>>> be rerun and removed from pending list.
>>>>>> At the resubmit setp, the second job (with signaled bit) will be
>>>>>> resubmitted. Since it still has signaled bit, drm_sched_job_done
>>>>>> will be called directly. This decrease the hw_rq_count which
>>>>>> allows more jobs emitted but did not clean fence_drv rcu ptr.
>>>>>> This results in an overflow in the fence_drv. Since we will use
>>>>>> num_fences_mask in amdgpu_fence_process, when overflow happens,
>>>>>> the signal of some job will be skipped which result in an infinite
>>>>>> wait for the fence_drv rcu ptr.
>>>>>>
>>>>>> So close irq before sched_stop could avoid signal jobs after
>>>>>> drm_sched_stop. And signal job one by one in fence_process instead
>>>>>> of using a mask will handle the overflow situation.
>>>>>>
>>>>>> Another fix could be skip submitting jobs which already signaled
>>>>>> during resubmit stage, which may look cleaner.
>>>>>>
>>>>>> Please help give some advice.
>>>>>
>>>>> How about the code bellow  instead ? The real problem is that we
>>>>> reuse a dma fence twice which is not according to fma fence design,
>>>>> so maybe this can help ?
>>>>>
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index 8adeb7469f1e..033f0ae16784 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -164,6 +164,10 @@ int amdgpu_fence_emit(struct amdgpu_ring
>>>>> *ring, struct dma_fence **f, struct amd
>>>>>          if (job && job->job_run_counter) {
>>>>>                  /* reinit seq for resubmitted jobs */
>>>>>                  fence->seqno = seq;
>>>>> +
>>>>> +               /* For resubmitted job clear the singled bit */
>>>>> +               celar_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>>>>> &fence->flags);
>>>>> +
>>>> Upstream will pretty much kill you for that.
>>>>
>>>> Re-setting a fence from a signaled to an unsignaled state is a
>>>> massive no-go.
>>>>
>>>> Christian.
>>>
>>> Is it worse then doing fence->seqno = seq; ? This is already a huge
>>> hack , no ?
>> No, it's as equally bad. I don't think we can do either.
>>
>> Christian.
>
> And all those ugly hack are there because we reuse a dma_fence (hw_fence embedded into the job) and correct me if I am wrong but I don't think dma_fence is ever supposed to be reused.
>
> So maybe like Victor suggested we should move close and flush irq before sched_stop - this in my opinion should solve the issue, but Victor - why then you still need the change in amdgpu_fence_process ? You will not have the overflow situation because by moving irq_disable before stop any job that signaled will be removed from the scheduler pending list anyway. Also not that this change reverts 'drm/amdgpu: sanitize fence numbers' and could reintroduce that bug.
>
> Andrey
>
>
>>> Andrey
>>>
>>>
>>>>>                  /* TO be inline with external fence creation and
>>>>> other drivers */
>>>>>                  dma_fence_get(fence);
>>>>>          } else {
>>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Victor
>>>>>>
>>>>>>
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Thursday, September 15, 2022 2:32 PM
>>>>>> To: Zhao, Victor <Victor.Zhao@amd.com>;
>>>>>> amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
>>>>>> <Andrey.Grodzovsky@amd.com>
>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix deadlock caused by
>>>>>> overflow
>>>>>>
>>>>>>
>>>>>>
>>>>>> Am 15.09.22 um 06:02 schrieb Zhao, Victor:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>> Ping.
>>>>>>>
>>>>>>> Hi @Koenig, Christian and @Grodzovsky, Andrey,
>>>>>>>
>>>>>>> We found some reset related issues during stress test on the
>>>>>>> sequence. Please help give some comments.
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Victor
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>> Sent: Wednesday, September 14, 2022 6:10 PM
>>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Grodzovsky, Andrey
>>>>>>> <Andrey.Grodzovsky@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
>>>>>>> Subject: [PATCH 1/2] drm/amdgpu: fix deadlock caused by overflow
>>>>>>>
>>>>>>> [background]
>>>>>>> For a gpu recovery caused by a hang on one ring (e.g. compute),
>>>>>>> jobs from another ring (e.g. gfx) may continue signaling during
>>>>>>> drm_sched_stop stage. The signal bit will not be cleared.
>>>>>>>
>>>>>>> At the resubmit stage after recovery, the job with hw fence
>>>>>>> signaled bit set will call job done directly instead go through
>>>>>>> fence process.
>>>>>>> This makes the hw_rq_count decrease but rcu fence pointer not
>>>>>>> cleared yet.
>>>>>>>
>>>>>>> Then overflow happens in the fence driver slots and some jobs may
>>>>>>> be skipped and leave the rcu pointer not cleared which makes an
>>>>>>> infinite wait for the slot on the next fence emitted.
>>>>>>>
>>>>>>> This infinite wait cause a job timeout on the emitting job. And
>>>>>>> driver will stuck at the its sched stop step because kthread_park
>>>>>>> cannot be done.
>>>>>>>
>>>>>>> [how]
>>>>>>> 1. move amdgpu_fence_driver_isr_toggle earlier to close interrupt
>>>>>>> before drm sched stop 2. handle all fences in fence process to
>>>>>>> aviod skip when overflow happens
>>>>>>>
>>>>>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16
>>>>>>> +++++++++++++--- drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  6
>>>>>>> +-----
>>>>>>>     2 files changed, 14 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 943c9e750575..c0cfae52f12b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -4610,8 +4610,6 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>             amdgpu_virt_fini_data_exchange(adev);
>>>>>>>         }
>>>>>>>     -    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>> -
>>>>>>>         /* block all schedulers and reset given job's ring */
>>>>>>>         for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>             struct amdgpu_ring *ring = adev->rings[i]; @@ -5214,6
>>>>>>> +5212,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>>>>>>> +*adev,
>>>>>>> amdgpu_device_ip_need_full_reset(tmp_adev))
>>>>>>>                 amdgpu_ras_suspend(tmp_adev);
>>>>>>>     +        amdgpu_fence_driver_isr_toggle(tmp_adev, true);
>>>>>>> +
>>>>>>>             for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>                 struct amdgpu_ring *ring = tmp_adev->rings[i];
>>>>>>>     @@ -5228,8 +5228,12 @@ int amdgpu_device_gpu_recover(struct
>>>>>>> amdgpu_device *adev, atomic_inc(&tmp_adev->gpu_reset_counter);
>>>>>>>         }
>>>>>>>     -    if (need_emergency_restart)
>>>>>>> +    if (need_emergency_restart) {
>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle,
>>>>>>> reset_list) {
>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>> +        }
>>>>>>>             goto skip_sched_resume;
>>>>>>> +    }
>>>>>>>            /*
>>>>>>>          * Must check guilty signal here since after this point
>>>>>>> all old @@ -5240,6 +5244,9 @@ int
>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>>>>         if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>>>>>>             job_signaled = true;
>>>>>>>             dev_info(adev->dev, "Guilty job already signaled,
>>>>>>> skipping HW reset");
>>>>>>> +        list_for_each_entry (tmp_adev, device_list_handle,
>>>>>>> reset_list) {
>>>>>>> +            amdgpu_fence_driver_isr_toggle(tmp_adev, false);
>>>>>>> +        }
>>>>>>>             goto skip_hw_reset;
>>>>>>>         }
>>>>>>>     @@ -5276,6 +5283,7 @@ int amdgpu_device_gpu_recover(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>             if (r && r == -EAGAIN) {
>>>>>>>                 set_bit(AMDGPU_SKIP_MODE2_RESET,
>>>>>>> &reset_context->flags);
>>>>>>>                 adev->asic_reset_res = 0;
>>>>>>> +            amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>>                 goto retry;
>>>>>>>             }
>>>>>>>         }
>>>>>>> @@ -5711,6 +5719,8 @@ pci_ers_result_t
>>>>>>> amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>>>>         set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>>>>>>>         set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
>>>>>>>     +    amdgpu_fence_driver_isr_toggle(adev, true);
>>>>>>> +
>>>>>>>         adev->no_hw_access = true;
>>>>>>>         r = amdgpu_device_pre_asic_reset(adev, &reset_context);
>>>>>>>         adev->no_hw_access = false; diff --git
>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> index 8adeb7469f1e..65a877e1a7fc 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>> @@ -287,15 +287,11 @@ bool amdgpu_fence_process(struct
>>>>>>> amdgpu_ring *ring)
>>>>>>>         if (unlikely(seq == last_seq))
>>>>>>>             return false;
>>>>>>>     -    last_seq &= drv->num_fences_mask;
>>>>>>> -    seq &= drv->num_fences_mask;
>>>>>>> -
>>>>>>>         do {
>>>>>>>             struct dma_fence *fence, **ptr;
>>>>>>>                ++last_seq;
>>>>>>> -        last_seq &= drv->num_fences_mask;
>>>>>>> -        ptr = &drv->fences[last_seq];
>>>>>>> +        ptr = &drv->fences[last_seq & drv->num_fences_mask];
>>>>>>>                /* There is always exactly one thread signaling
>>>>>>> this fence slot */
>>>>>>>             fence = rcu_dereference_protected(*ptr, 1);
>>>>>> Those changes here doesn't seem to make sense. Please explain
>>>>>> further why that is necessary.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> --
>>>>>>> 2.25.1
