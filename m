Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCE9C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 22:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D1689870;
	Thu,  1 Jun 2023 22:09:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F267789870
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 22:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4TQR0PNRTybXszW9ytYpEqKErskVF8A53gDZ4zxoN95SU3OoCkUAh3vJL2dFcuVhfwRklfgtDWfM60BqkQpuoF1fAP5ZX+P3K41USJanIvo3mpnKMX852xTs41DP5ApIhamhalgIZl10AOn3zzgRvv08pJPk507HVwkYCDa0WodBStmDdBmpEDn3Uhw2kYt3XaFAuM1O6H/QDvlm6DOQpIFakHLLYUXlux4JyDbH0JYijtCStsy+xKzZXEArrvNeAPxhEGpJF6keSYUnrdxUzo/QIe3UJdbeU12eLiTqRTG61GYjYOzJwAOZKv+hWK8wMkixBf0v9r1VNsAJ6w4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEr8jhqAzhMs/YpkJ4PrGavYEbjgporuh7s+L49GbW4=;
 b=X0xCGSfaFt4PRlF4qMoDLKpbFH4UXNqTJ5h1XwOU0Yv4LAiFbPxQT1temYxGW581De3sJDmC8mQWgVCHthEzBuBDJM3856FoyxSJ/EBMDjVg3iMn8Ca8+/IOhQeQNZ4bXxfwf6qLWb0TBBs/lcqWJYCvQ7wEe2MVzqKk1w2aA5Uv8vY73S+05NyFWlfvcEemOZF7YWXW0fC4so2fC5jrtJHcMdNlxoc0G9XmOyPViH9uhcEOn5SbgG44z9v+zlSrbPRFvrWwOWf/M7Ar0afrPgr5ov7g0NuN82R1ZeynPQ66bpM8QLZwMqqlv+1Epi3DpQwR1Qt2RHBIqEHivHbyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEr8jhqAzhMs/YpkJ4PrGavYEbjgporuh7s+L49GbW4=;
 b=sFIBqDqMVJAtXRlbZkP7oAqhk81rcRzzAmXY08O64tH5iZXU9SCSsCbPZLh2TN1oy7M3SLNnPQJzvsDpj6zvjhPBzHuvUpqB/l4nAhBml5nT2mNH/GVWrNnBSn6lxoGMZ1ws5AMAKrUopl0rM3b3hcmZzeHjhYxkaGHPYsTX7TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 22:08:59 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 22:08:59 +0000
Message-ID: <610814ae-2549-e84c-94ff-29496508ec0c@amd.com>
Date: Thu, 1 Jun 2023 18:08:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: don't sleep when event age unmatch
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
 <20230601204740.1501616-3-James.Zhu@amd.com>
 <04b12a87-6672-3241-456e-f6947f09de27@amd.com>
 <d07bcd38-797e-6471-d5ed-18251c015d35@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <d07bcd38-797e-6471-d5ed-18251c015d35@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::23) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 103af8f4-8263-4b58-a005-08db62ecccb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsUcCG0zdtnEG3mIdPeY2725JVInBycaDDnMYYre7j4Qa0YadHLvWsvrYXuCDDDRRy0fyjffbZ3E9TjjxC/4JDjZyVNrNup5zDCBEqDa/bI+bMGkNoko0OjqlGofuOhiClmbLfW+De1O+62ZaZv55enWOS1sblnyKsbb4Y2G4Bm8bSagbNus1B0ApWFnDCDO6/Fb263zBqVpYKzyW3HWmY6jsVqQ/it+JHc3T9RYJTSBvnQrzjaLWASssPs3jJyNDFWqAwvF+n8y8l3bqvLLlXlnxcCXMtbw9YizUYyd3x/dytYd0KUQ+pudVBKUjwRzUuan7fthWecwCg+Ad4D+wlIa3FspltpMpX+bzlhRMjq4NdiE2cIqoMLtxIcL82QEUpR6EMkyvAsu+1SYVidMaNtACYAE9fT/ZojTfVq5bFnymN/SDr8VszDtAHRcmjRbvgC3k3AQ5Ob8wCGetwyj3qUDjmmRQGXN36IWCr659cAqZKBpgliATYPmU+OzeXFxmpwfbT70T7YT1sBnhO/7O3F1ZahQ2HbcQNUyZARPUyiV0sVnUA90ED24N0A1MH/Bqr2JaKCCkcfDfGrfiV86pNgAcOtnHfcEWV1JwpNOPWysF9oEQc3WPQ5mvEfe5mz2YSiGP5wtTt9uZjzdyjqccw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(83380400001)(2616005)(2906002)(36756003)(38100700002)(6486002)(41300700001)(6666004)(316002)(36916002)(86362001)(8676002)(8936002)(5660300002)(110136005)(478600001)(4326008)(66946007)(66476007)(66556008)(31686004)(186003)(31696002)(53546011)(6506007)(6512007)(26005)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NDRndaOGFMTUNkWC9admx0NkEvWitFNHAza1BFOTROQk9HNHVibkVQUWRo?=
 =?utf-8?B?SzZkZ2pXOWdTN1BmQzV2Ri9yNmxmQXdNTkdWWXQ0Z3NNWVlCR09WSWlBOWhY?=
 =?utf-8?B?Rk1BYkpub1dramlERFd3YWlLRHVCaEFGVmUrMTh2bHk1d0tzNUNaS2YvTWFW?=
 =?utf-8?B?UUxuZzhYNzY3U2lvMVk5N1kzMjR2dDZUaWE1RS9YN0I1Q1BmN0FVeVJ2U0Q0?=
 =?utf-8?B?N1pSMTAxUEVLWGV4ZnVobEg3bUhaZ1JwdEFWZmVzWXBqc2JyMHJvZDV2Qld6?=
 =?utf-8?B?cE1DYk9LaVV3Wm04VitKUG5CTEgxbTNmeWcyR0x4R1ltd3UzMmZrd3dpMU1P?=
 =?utf-8?B?WWVtKzF2NG9YWXZMMmljbzhUbWR1OE85Z0E4Z1U1bEo3M2pwWXBUSFZuUEh4?=
 =?utf-8?B?RDg1Z2VHUWg3MjNETnpDN3RZdFRiUkZiSjNrZDBSWksxWm9LNUczdnJ2SVFQ?=
 =?utf-8?B?UmxxZm96UWhyVmI4MStNRVFKMnQ0UTRYS213RFhnMUdyWlcweUZnWUFUVmx6?=
 =?utf-8?B?cm0vVS9yWU44Ly9KejcvM3VSV01HelZjcThjRytXR1U1bFc5U2ZIMnNVei9Y?=
 =?utf-8?B?aks3ZkNRVURMejYvSGNhdlJKTnBPTlNHakVVOW1IVytRU3VQZ2lTR0pwdGNJ?=
 =?utf-8?B?VXZXM0pIazBVTThqeG9EZlNTWDRnem0wRGd2dUhaSGtHc2plYlNqYnVIL2Vp?=
 =?utf-8?B?dEphMVd0dlU1NzlROFplRnhTUkxwU0MzU0xSY1hDekdvZDJpeTJ4MG5EczRB?=
 =?utf-8?B?L1F6UWJ2R3ZVTXVQNWRYazRDajdzU1ptRkVvQjJTeHRSNVhWWVFybmR5R3do?=
 =?utf-8?B?MmlnNkZnczRyY1pRM2o2bW5DY0tBNDFOVHhyVG5NaVRjVzNwbnQ0Q2lzSXVG?=
 =?utf-8?B?R3VJdmJXVWttb0VudjBFeTBraVRJWk9PdFZXdWg4UG9KNktCTUpHTXAxbjF4?=
 =?utf-8?B?R3V4aEtnL2VGY0NBMVlQOFJZa3NTaHFCSWZBK3ZMSDN6TVdhYnIydnNsY0FX?=
 =?utf-8?B?b2l0KzJ3OHZCckNHKzFHRnVaREliSS9Nc2oxcDFzRHVIWlBHY2VmTHUya0Rl?=
 =?utf-8?B?WHJQR3c2N2NEQzhLSjFEblRHeFZkaDkwbEhjcWQxNjRMY1dmYi9WSjM2NWdL?=
 =?utf-8?B?ZVRmc25GWVc2a3VYc1R2QWlpanNROUFIc01helJKbnkwYWRqWUlkUHJuTy8w?=
 =?utf-8?B?VnZFS1Q5NFpVeTNCR1RPc09Yak4zV2FGbWVHTkpncTQ1bW9vb2hSSGhvbUZO?=
 =?utf-8?B?VkVFS01SK1pURjdsZ2tDYkRkV095QXZ3ZW5wRWZhbzRjN2Z4OTJpclF2SHpq?=
 =?utf-8?B?Z3BQSGJkZ3pDaTZidHpmWmlvY3dQcHRPTTZleUhGSzk0MmRVSTNmNUg4VTZH?=
 =?utf-8?B?Z2x0RzFLUENBSms3N2gvM1JvaDVxVVRPMUtpZE9obnF1enlVZUVpR3pSNDli?=
 =?utf-8?B?cXdlWUd1emJ4M0VHd25renFkbWNCelpvNlR6TjRyR2RIMXVtdTlIeGpUNXZr?=
 =?utf-8?B?dzF5d1NvbkxsZ0ppR1psa25Sd0hkRkRLeDJheDdLU202YzQzcUVLQ1pxTFRD?=
 =?utf-8?B?bkdjeFRLQm5uTERVbmtuK2labkRXZXFGbWlCdFA3TFFiSjY0d0h0aFRQano0?=
 =?utf-8?B?SlUraFZBNjdVQUg4ZjJrVzZxYXB0QUd0ajJEMStSUDVsV3BVSjE5STc2MUZz?=
 =?utf-8?B?QVlSTkI1VS9jN3FZMW9IUThNdVVnN3lOM3hNamdwMVBBOFp3SVUzajk2NU1o?=
 =?utf-8?B?YTZqZ3hBbGVOVzhjZzB0dTN0T0JBQkJwWjFoU2EwMExIbklvSU53RHAwZzRB?=
 =?utf-8?B?ckdIS3hJOWRTOEhMZS83U0ZtR3pMeUtDUGFJYUZQZ2NoS2F1czFHaUxJSXQ5?=
 =?utf-8?B?aUtQQTliWFd1NCs4M3gyVmI2Z09oSk5NVWdLS2luZENuTEd4YXJMQkM0d2lo?=
 =?utf-8?B?bUdCOE51VDNDa3BrUDYrS2Jjam5MRnpsNjA4bDBYT1B3MnByNkZRdlFmSTdt?=
 =?utf-8?B?Q3l6bnBEWUl1Rzg4bWNJeWU2KzAzRjZseThKV1NoM2dXUDVrN1U4bzRHYW5q?=
 =?utf-8?B?WW5tUVBwNVdJMjhPT1JFb1pEa0dIcGNDZVltVG5EaGpoa3h1aEZtRXExU0k3?=
 =?utf-8?Q?MAfA8B+uf/WxOZF18tKyKrIkk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103af8f4-8263-4b58-a005-08db62ecccb1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:08:59.0932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hURByz1pQ2dkij6u2d803KeIOUwJohVEaPquIs5yZv6E+vTUE/0JF4mcQjxLYrwwQjo/lOCoMxlP8E80LxrMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

On 2023-06-01 18:06, James Zhu wrote:
>
>
> On 2023-06-01 17:17, Felix Kuehling wrote:
>> On 2023-06-01 16:47, James Zhu wrote:
>>> Don't sleep when event age unmatch, and update last_event_age.
>>> It is only for KFD_EVENT_TYPE_SIGNAL which is checked by user space.
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index b27a79c5f826..23e154811471 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -964,6 +964,19 @@ int kfd_wait_on_events(struct kfd_process *p,
>>>                       event_data.event_id);
>>>           if (ret)
>>>               goto out_unlock;
>>> +
>>> +        /* last_event_age = 0 reserved for backward compatible */
>>> +        if (event_data.last_event_age &&
>>> +            event_waiters[i].event->event_age != 
>>> event_data.last_event_age) {
>>> +            event_data.last_event_age = 
>>> event_waiters[i].event->event_age;
>>> +            WRITE_ONCE(event_waiters[i].activated, true);
>>
>> I think this is probably not necessary if you're returning before the 
>> first call to test_event_condition.
>
> [JZ] Currently, the returning is with test_event_condition. Since some 
> conditions needs return with all events signaled.
>
> so all waiters need check and update if any event interrupts are 
> missing here(unmatched event age).
>
>>
>>
>>> +
>>> +            if (copy_to_user(&events[i], &event_data,
>>> +                sizeof(struct kfd_event_data))) {
>>> +                ret = -EFAULT;
>>> +                goto out_unlock;
>>> +            }
>>> +        }
>>
>> When waiting on multiple events, it would be more efficient to catch 
>> all events with outdated age in a single system call, instead of 
>> returning after finding the first one. Then return after the loop if 
>> it found one or more outdated events.
> [JZ] Yes, the code is working in this way, when all events' waiters 
> are activated, the following test_event_condition == 
> KFD_IOC_WAIT_RESULT_COMPLETE, then return to user mode without sleep.
>>
>>
>> Also EFAULT is the wrong error code. It means "bad address". I think 
>> we could return 0 here because there is really no error. It's just a 
>> normal condition to allow user mode to update its event information 
>> before going to sleep. If you want a non-0 return code, I'd recommend 
>> -EDEADLK, because sleeping without outdated event information can 
>> lead to deadlocks. We'd also need to translate that into a meaningful 
>> status code in the Thunk to let ROCr know what's going on. I don't 
>> see a suitable status code in the current Thunk API for this.
> [JZ] Basically, this failure is for copy_to_user. It will lead to busy 
> wait instead of deadlock.

Oh, right, I missed that this is only for the case that copy_to_user 
fails. EFAULT is the correct error code for this. Then this patch looks 
good as is.

Regards,
   Felix


>> **
>> Regards,
>>   Felix
>>
>>
>>>       }
>>>         /* Check condition once. */
