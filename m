Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4401CC77B62
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5140E10F126;
	Fri, 31 Mar 2023 08:25:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51F710F11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bICXrMvIMSn2OZk5LTaLs30rFYGXLN5FZTXDbZO+3Hf8AYzwfxBVld7Q/NHwM7pjKEPJzYbeNDhb3dgg5/dr1M8TBGmS9EonuioFgJ8NZLTeNejLNuzcMsPRjbcKkMI3ZabuMYQ4UkenMDIr8tQz0qxL0mzNAjXV4bZjS7Fj/uqUuRuuWS1hFMmG1zmfC+kqqyzQqvKH7ncCo/RBOmxMiHzYFVqFyPorY8layHNTAIhXnzMz/ZMObZpIJ62le/qC4rdOsH47q9wbFof5Qb7VDkscZas9jV2nwKpwmPjfxSNdGtJNsaww66I7JlH76sA+OiB4w9iVfE0btwUeCc2Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxq9tedygcHF3Has3w3KRdg2H5DMs97l302qhkKnLng=;
 b=gkVz2rWj57vz7ggxK+vOKVRAlZoO1zKsfscBKlb6bS4aeiT5OSOKBTFDAYr+a7FTdUrw6fgglpEpQULc+WTD7w6GzTMddrF05t0GVnUmsLqncW4OaYeZAtodZfDiqXYFGyraN1+hfAXkRtFOY3dpZgdaFPwl45r1+V5lkzUXcEeqNvEPlFHqzYCHAgkVjFXWJ5jdzA9cqzlr7U3eQEB11YK2+28kzzUUlMPX2JBqiRHcK6Y7XzPBDQnj9iTsxDyWLhkIxgmk9iEEVvDZCCVoLh84D+SUHTZBv5HQI85cOe1j2CWMl8aMUN2Q12CmGTnqLJlacM57tWkBM7IJ54T0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxq9tedygcHF3Has3w3KRdg2H5DMs97l302qhkKnLng=;
 b=rSw5QTPYCvTILjEAdzyRPW+DocVclv3rup7l97n4DHow5ew0MC7k7pAgBzpn9F8CkZ54i6CBgQTGjTEqtfRubcxvBWZuRCpEVEbERREK6vu/3L5c5aNFS6A1Pm+eWCi5N6S6fhFSo4W1ofl4NhPEDWVOMLNmbW9ULezcATywvKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 08:25:23 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:25:23 +0000
Message-ID: <34d9409e-9c96-1788-5cb6-1e88e8e598c0@amd.com>
Date: Fri, 31 Mar 2023 10:25:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <4c4776ea-c53c-a37a-ba4b-3a0be4e7645c@amd.com>
 <0ceb747c-d71f-a6ae-67e4-a53f136ca0bd@amd.com>
 <CADnq5_OZkNwPhwAmvmzVN+w6B4oBmMWdBGsuTBJP0y9ct9eUMA@mail.gmail.com>
 <1b468b00-6435-425c-ae0a-5ed4c1727d96@amd.com>
 <adab1273-a3a1-5618-fd00-9e1d846f032f@amd.com>
 <CADnq5_MQzdeoNb+-DF=m=c-ZxNH+Zy79DATprWb32odN12anfQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MQzdeoNb+-DF=m=c-ZxNH+Zy79DATprWb32odN12anfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 9703b1b0-2027-4335-494b-08db31c178ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTbvAn1Y/KMP3Gt58DFcKtI1Za/5uN4gCZmCm7QmvW98/uZWVPWFJJKVocqf2yq3iwPUOnkBDp5LyKr6wt1Si1Yz35tSclLu4rkFNz06rSU6rdJeNiWag3DwiaOtzc1dhhkLDgQFnJHYdK1RaJpO/JXFDQnz5tUSR6ZFMnuHm2pp1jccPSApfE9aRWK2oGs3zu7hY503Y8QiwbiPlwmXcw7VuEBEHZRUXMwE+vUOoZxB8SnN5cONbVrz3Bd3n4attptQl/b6Casi0YvTCOwTznKRaZqWb9TgS5DyjqutxU2k9cwJ7aPv84XX7Gt79wB7o6KatRTJC1bKBsJizR5+/BU1GKhM3PtUQndBlCMJFW9U6LmNJbgOLak0533X/ODOALZBqTGjHMzFZHIKHQrK9hRHmhd+gXV/l5lDnq1xmEGXj8dzHEriOPkf2DHUF9Ye77nqDxxw6obdJ5NpTq9gtg5hihOw1ohyMi3GL3jrj4R1vC3wUZEKCuHy9Su/LSADo0FFsPoNQBVyPU/kwCPHO/GfsbJSfrId3faj0Qg7JxcYiu9KIKgKBv+RJ1m9aOqTXd+NU+qd7y/fA9zOe/kdZsinvSCqNnOjr3zvStsq5FlldtNlWMUgfzDr3N6muSE2Pd68vFy//HbGafdFN3DKCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(66476007)(186003)(4326008)(6916009)(66556008)(66946007)(8676002)(2906002)(44832011)(36756003)(8936002)(66574015)(5660300002)(83380400001)(41300700001)(2616005)(26005)(54906003)(478600001)(86362001)(31696002)(66899021)(6666004)(38100700002)(6486002)(6512007)(6506007)(31686004)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHp2QjdQbE5yZkttbnE3bll3WW9JNVhRT2NabUNJVnp3K29ubHYzMXhEZDMz?=
 =?utf-8?B?UEdLL2l6TXIxOVh2ZmRNVHBhMVZRWEhWcnZ1djZiYUx0V1ZxYTBZck5Ob1lX?=
 =?utf-8?B?SDJFR2RFMU0zRUF2T3duQnptczJNNis0WVB0ZHlNMDBPTFk2bE9vMFovVWs0?=
 =?utf-8?B?NzlzZzIxWjdnQkZQWTVDc0Q4QlRhaW04UThWVmE4RitFbG5sN0s0VEVPQlVE?=
 =?utf-8?B?U0NTdUNVWVhyLzFtc21KTlNqMTBaR2tnZFMxVk4rOG1NSS9wekJZTDdIdFVK?=
 =?utf-8?B?RE9LTDdHNW9kQ2hpQmhWdHZITWZ5Zi9lemxhWjRhZHlHTU5XSWl4dldtQUR1?=
 =?utf-8?B?cSs0RUJOK3BnT2NhWUFCV3pWTytPWjNsWVF2bXczNitnblRlYS93NmcwdnhZ?=
 =?utf-8?B?UWlTa2xtZWFQSWVXbUpUVkQ5V3o4alhHdUxoeDFyaDIvbkZ3UmUzZjI1SEs4?=
 =?utf-8?B?OHBUeFZkcFpmeDZUcVBETzlGUnh4V2VNQWphQUd4TXNEbkpjRFVKVVBrclFC?=
 =?utf-8?B?elZLK1RpUjRVVU9iQU10S2dyK2xHVlVZeExnZVRBeVhleHJ5L0kzZWZNakNu?=
 =?utf-8?B?T0t4TkdSbHI1ZFFvUGx2T1haWWYrbVltMzRLZzRMQWE5dFNMUEhaazZQU2RT?=
 =?utf-8?B?eWdjNUx6R0l4SDRNWDFybEFLZm9kcjRCWVNNN2JubVZOb2tTSXpyMkY1RHhM?=
 =?utf-8?B?QmtsRFlvYkdrdXNFUVVrQlNrMWRKdk5KcFBPQmU3b3NSVWN0Zy9kdm1xQTZS?=
 =?utf-8?B?bmtnOUkxa2g3UWFBdHFSUkxRakF0bkFyaTNyQlBtSEFPVmRJS01RbzlaQzBy?=
 =?utf-8?B?V2Z5UWNORjR0SzVobzhQTng0NFNON3B5ekE4TG9QZkhDNjJ5Um0zc1NJcG1i?=
 =?utf-8?B?YjRqQktjWXV5SHNnYVdXMGhIdVQyNHRHMWxnTE9PTmdMbm9QemkvcGFNemsx?=
 =?utf-8?B?OHUwYk9wUkRWQ0tWRDR0QmZ2TjBQMVRhQXZucXY5ZWF5b1lhU0ViN3JUeUhV?=
 =?utf-8?B?V3hZbFFldk1lTy9NMnRhTlMrVHNiOXlSazRJMkxlZlNBeUJTdFY3TzhueUx5?=
 =?utf-8?B?aWVVSnNPNjhxdVZET0VmQ2xpekxKMXRjS0R3THJuM0U3TTdPQ3phMkxMeG9F?=
 =?utf-8?B?RTJsdzRsVldFcGFVdm51WVBWUm1ad2xEM29zUjhFWWlqOW1BelZ4emlLRTF6?=
 =?utf-8?B?T3ZVTWFLN01wOEJIVUR6eURTR3VnMlJFOXQ2ZUNYUENnUHp3WDY4TVVHUk1L?=
 =?utf-8?B?Q3RBaVY4cE5menVjUDhFbzZqV3RiMEJSYVJvcnp3Y2RxNGIwMVZ6WnRpd0Nj?=
 =?utf-8?B?T0ZJWHF3QlZPR1VxcldxVzFseUg0aWZWeDRqMzltV2ZOQlN3WnZMd3QxbytX?=
 =?utf-8?B?b1I1NHB0WGxGbGMvUTl3NmkzQW9oR2NsNUVaamxJMkRxYVJnTlhYaFdoeGx4?=
 =?utf-8?B?eWVIZXI0cTN6aXNnWmNHRjJZQklaR1JaTURhSUNuemRERms1a1AxemhaQURT?=
 =?utf-8?B?ZkZwL0lqM0IrZm9xNGlXb1NhUzdFUklxYXNXZ1pIQTA3WXFVcnV3aDRRdDFR?=
 =?utf-8?B?clE0N2JZbmdrS2VERDdqTVRUQmwzVGM5U3ZLd0FMeUZFMjkzVmxUenVUQ0F4?=
 =?utf-8?B?WUhKM2pJSlBMSDBrbUN2QlQwR1VScjRtSVdsQWt6TVM3WEFWM0hkOGo4SXh2?=
 =?utf-8?B?ZlFnV1MyMzNYQUQwU0tzanBXdjgxZ0duRURxb3BBTHErSjk4T2V0QTZLUEE3?=
 =?utf-8?B?N1ZOTkZ2dngzRHVIbmdjMnhUaDhHbWFKOHNhbW9WclBwdTlkNG04cTNXNnBE?=
 =?utf-8?B?aXNNdTZtRy82UjhkMWdHVVNTTXM2K3I1ak5CKzF2ZG0rS2lMSG83VE0ySDVG?=
 =?utf-8?B?VjhaOHEzbVU3a0RZTlFkN2FueXBrWXMzOGZ0WTlNS1RpMlNQVEh3ZkVKTmx3?=
 =?utf-8?B?WHRMYnlTd0hZV3hxbHpyRExTdmd6QW51dm81c3ZXU0l0bEFnRk1KVjRMRU9D?=
 =?utf-8?B?bmJORTZ5L0pobDR5SFdxY0tDTXg0c2pyemZQVVc2RUZIKy8zbUZjWUR1YmJs?=
 =?utf-8?B?aThlN0VLdUZFcGUyeUZrc2dyRzhvNHZsNk0rT0JuUmgvMTFlK2Fod0NzVVkz?=
 =?utf-8?Q?eypwxcAHWnhX9H2lNSsR9phi7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9703b1b0-2027-4335-494b-08db31c178ed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:25:23.4027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/naKX8zUNNcu211vUWGi6+6Nn3chAFMfbuIEVjMOuU2f/B+9katOk1uac1oKaFQ7PDPV3A+Z0uKVE1hwD1kGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 17:04, Alex Deucher wrote:
> On Thu, Mar 30, 2023 at 10:48 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>>
>> On 30/03/2023 16:42, Christian König wrote:
>>> Am 30.03.23 um 16:39 schrieb Alex Deucher:
>>>> On Thu, Mar 30, 2023 at 7:49 AM Shashank Sharma
>>>> <shashank.sharma@amd.com> wrote:
>>>>> On 30/03/2023 13:30, Christian König wrote:
>>>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>>
>>>>>>> This patch:
>>>>>>> - creates a doorbell page for graphics driver usages.
>>>>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>>>>      kernel-doorbell-bo's cpu address.
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>>>>     .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44
>>>>>>> +++++++++++++++----
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>>>>     3 files changed, 57 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>> index 6581b78fe438..10a9bb10e974 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>>>>         /* doorbell mmio */
>>>>>>>         resource_size_t        base;
>>>>>>>         resource_size_t        size;
>>>>>>> -    u32 __iomem        *ptr;
>>>>>>> +    u32    __iomem        *ptr;
>>>>>> This one can probably go away if we use the pointer from
>>>>>> amdgpu_bo_create_kernel().
>>>>> We started like that, but later realized that the cpu_addr from
>>>>> create_kernel() will just limit us
>>>>>
>>>>> to that object only, whereas we are keeping this ptr to ioremap the
>>>>> whole doorbell space in one shot.
>>>> Why do we need that?  For the kernel driver, we'd only need to mmap
>>>> the page used for kernel doorbells.  Then each user app would mmap its
>>>> doorbell page.
>>> Yes, that is exactly my concern as well.
>>>
>>> The kernel needs a fixed number of doorbells allocated for its
>>> internal use. Everything else should probably use the normal BO API.
>>>
>>> For KFD we can use the BO API internal in the kernel, but that is
>>> certainly completely different to the kernel allocations.
>>>
>> There are 3 different kernel doorbell clients here:
>>
>> - graphics driver
>>
>> - mes (for aggregated doorbells and kernel ring test)
>>
>> - kfd (for kernel ring test and KIQ)
>>
>>
>> The fix num_doorbells are just for kernel graphics driver, but We are
>> allocating doorbell pages for each of those, and they all need to be
>> mapped.
>>
>> Please see patch 12-16 for these details.
> To me, it's clearer that resources managed by ttm are consistently
> dealt with.  Regardless of whether we are talking about VRAM or OA or
> GDS or GTT or doorbells.  When the kernel driver needs a page of vram
> resources, it calls amdgpu_bo_create_kernel(), then if it needs a CPU
> mmap, it calls amdgpu_bo_kmp().  Doorbells should be the same.  In
> this case, the KGD would call amdgpu_bo_create_kernel(...DOORBELL..),
> then create a mmap with amdgpu_bo_kmap() and then use that pointer for
> its use.  KFD would do the same.  User mode doorbell allocations would
> be consistent as well.

Noted,

I will remove the wrapper APIs and make direct calls to amdgpu_bo_create_*

- Shashank

> Alex
>
>
>> - Shashank
>>
>>> Christian.
>>>
>>>> Alex
>>>>
>>>>> - Shashank
>>>>>
>>>>>>>           /* Number of doorbells reserved for amdgpu kernel driver */
>>>>>>>         u32 num_kernel_doorbells;
>>>>>>> +
>>>>>>> +    /* For kernel doorbell pages */
>>>>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>>>>     };
>>>>>>>       /* Reserved doorbells for amdgpu (including multimedia).
>>>>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>     int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>>>                     struct amdgpu_doorbell_obj *db_obj);
>>>>>>>     +/**
>>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>>>>> for graphics
>>>>>>> + *
>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>> + *
>>>>>>> + * Creates doorbells for graphics driver
>>>>>>> + *
>>>>>>> + * returns 0 on success, error otherwise.
>>>>>>> + */
>>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>>>> *adev);
>>>>>>> +
>>>>>>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>>>     #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev,
>>>>>>> (index), (v))
>>>>>>>     #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>>     +/**
>>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells
>>>>>>> for graphics
>>>>>>> + *
>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>> + *
>>>>>>> + * Creates doorbells for graphics driver
>>>>>>> + *
>>>>>>> + * returns 0 on success, error otherwise.
>>>>>>> + */
>>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>>>> *adev)
>>>>>>> +{
>>>>>>> +    int r;
>>>>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =
>>>>>>> &adev->doorbell.kernel_doorbells;
>>>>>>> +
>>>>>>> +    kernel_doorbells->doorbell_bitmap =
>>>>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>>>>> +                              GFP_KERNEL);
>>>>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>>>>> +        return -ENOMEM;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells *
>>>>>>> sizeof(u32);
>>>>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>>>>> +    if (r) {
>>>>>>> + bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>>>>> +        DRM_ERROR("Failed to allocate kernel doorbells,
>>>>>>> err=%d\n", r);
>>>>>>> +        return r;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>     /*
>>>>>>>      * GPU doorbell aperture helpers function.
>>>>>>>      */
>>>>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>>> amdgpu_device *adev)
>>>>>>>             adev->doorbell.base = 0;
>>>>>>>             adev->doorbell.size = 0;
>>>>>>>             adev->doorbell.num_kernel_doorbells = 0;
>>>>>>> -        adev->doorbell.ptr = NULL;
>>>>>>>             return 0;
>>>>>>>         }
>>>>>>>     @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
>>>>>>> amdgpu_device *adev)
>>>>>>>         if (adev->asic_type >= CHIP_VEGA10)
>>>>>>>             adev->doorbell.num_kernel_doorbells += 0x400;
>>>>>>>     -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>>> - adev->doorbell.num_kernel_doorbells *
>>>>>>> -                     sizeof(u32));
>>>>>>> -    if (adev->doorbell.ptr == NULL)
>>>>>>> -        return -ENOMEM;
>>>>>>> -
>>>>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>>> adev->doorbell.size);
>>>>>>>         return 0;
>>>>>>>     }
>>>>>>>     @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>>> amdgpu_device *adev)
>>>>>>>      */
>>>>>>>     void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>>>>     {
>>>>>>> -    iounmap(adev->doorbell.ptr);
>>>>>>> -    adev->doorbell.ptr = NULL;
>>>>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>>>>> +    amdgpu_doorbell_free_page(adev,
>>>>>>> &adev->doorbell.kernel_doorbells);
>>>>>>>     }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> index 203d77a20507..75c6852845c4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device
>>>>>>> *adev)
>>>>>>>             return r;
>>>>>>>         }
>>>>>>>     +    /* Create a boorbell page for kernel usages */
>>>>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>>>>> +        return r;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         /* Initialize preemptible memory pool */
>>>>>>>         r = amdgpu_preempt_mgr_init(adev);
>>>>>>>         if (r) {
