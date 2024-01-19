Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E483C4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 19:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F3F10E1E1;
	Fri, 19 Jan 2024 19:19:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D509910E1E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 19:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ+JEC9A5T8PNPPM2DdCWKOlOZgtoN989G2D2avIQhjPH0/bm1BOCD+7h/zMrff1GJjeVSf9dCApc6xPB3fWNYCn556gLP9hVNXpIjvggLb5jxERXKpVkdQ/tt2qZygXL7y6TKtJfbpK3105afFLZvv2b08gxSBvwzEP3mNlLaQVD3hLLuvd0rLeMVIdPvDqpLD0joliURFpzcHhGDzEhukLMKFJiCRmQF7ntXJlf5L64iDyHqeH0sMkyVFuEMAQW09jK2AnLpLEiG7leGed4DH+PsRZRHisSTKOZbRI/fdk3E1QeY8VNrgk/uwQCK1YqC3fKY/ibDhimAz8zslUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znSnyLlMp1Cqg7n71nAt38y6zEmhmZbTY6f+ojIJS6E=;
 b=ABeJlobu6B6z6x8k/dPgaRP6Lm+LcvBfS1pZ9A6Ksd8jGTfz0j3kUpvRQ817hjsr0hhrrkjVdSbplurAGhxlHLfNoAeIyt+dhNWAIQLSUEzgm4eyA4u2z/2nO542JEdAEr5JlpT+Il9LsTT5zxw3APfOoGxkatUNBUsKfoifihRb6o7i+kr7NuicLTdss4CLHtqf4oGV3CuPqfhjjDh5MfKZddJIgXKomBsHPlF0k8RX53LXCv+9IJICZo5NmNdBPtl9G9vrFWgUix/0N3BlugsbfiMIOZ0+zHz+Zp1Pgo6kaVWKrURuKplURwHu8xZ2+XQEkgPp8pRIGrKip7EfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znSnyLlMp1Cqg7n71nAt38y6zEmhmZbTY6f+ojIJS6E=;
 b=VRnNrwU6NTFZ0zYt0qQceS9NCuG7WOBQuFA815jcqajXoE9bGb9ZmYiQM/GDJcH3a9e21FNYo6QGPunHKwEuY1rLeDXEFjMSWZzq6yr5uNlsgu603tbfWdJwhjluCc39hBSv7ALnB2IqFoSxFKkkV7NUs674+Yuli+t4TNKHqk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 19:18:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ed98:3dd5:fe85:ead7%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 19:18:59 +0000
Message-ID: <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
Date: Fri, 19 Jan 2024 14:18:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, Alex Deucher
 <alexdeucher@gmail.com>, Christian Koenig <christian.koenig@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d94366b-f9b8-4476-3e6a-08dc19237ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8GQywrI3fZaQvR2RHmemM9HZ1HBlotK/CBbXEMeRLA1WUK+mjt3kk7+5/CPuzLmKkeIwzVqZUx+LZ1PyG7uiE6sIGQXMs50chsOwC1d1FIrnOBclH0KFUia2d934dRGN+q/UYV7rUk/DU1T5XJD/ogzCDRkKVGkGQoZLNxVW2/FDrN8gp0WDliEo5zqy3jXBe3mIv/eKBw5bc1mhSZUxGg0feYwveEIcLyDlT+eiTQcNHxHJgS5R/e8kAXWxED35MLnVcnpOgpiW1dgWRtjZ9pRVC8lrrjsF+1m7Wr7F2kY4SQ9SdAE/WRFBXxL2GgEIPVZTweuWqw3XCdHnXBXr+Y2yKWEbH3P6AitZRQmlU7vGYVGxCh7HOfKAw4TWJJNlp35r3X1k5u4H4mdF2PIHIVfpoN5UXw51JDlJDL2mYjF0m+LNGFqzcYgKRsLoUk/iri0UDUaebbItyBqdk//fpK5w7ioMuZR3n1J14o8EhCqY7YiZgBaygC7asQnNVvmx7lXTIaNCX8Xpo2VoOnvdviGbM9UzayMk05kAc2DEbZ8F2RWLN8Zhdi5aV4ieFuloR/eSh+Wwgxmb+gTyjI7HeG6g3ipDb295udkSHZ3Tc9akv3+Zu1Ymo86ZARP9Qe6c1Z8RKj8iCb1yLgPK0u9JOrV4PTE2+GGHOniD3aCA4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(26005)(83380400001)(2616005)(38100700002)(41300700001)(8676002)(8936002)(6636002)(316002)(54906003)(5660300002)(66476007)(30864003)(66556008)(66946007)(4326008)(110136005)(44832011)(66574015)(6506007)(6512007)(36916002)(6486002)(53546011)(478600001)(36756003)(31696002)(86362001)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHB0Z1JJallGNGd1UWk5THZqRUVPWi9wcTQ3cjFnblZFdzlUaFJDUzJxSGg1?=
 =?utf-8?B?ZjgwdllWN2JTS3FwN0xYVmg4am5yRDFOQ1RNb3FMd3plQU9mb3RqbUpJV1h1?=
 =?utf-8?B?VTFOemxSTVZjRWkvVUZ5dWM2WkxwWlBuYTV4M0pRekNLMmJTWlNqRFNhRGdx?=
 =?utf-8?B?cjBXeXJNQk4wbHVYWjhwRTVQNzBxOTBiUW9XWVB3TWdXVlFvNXFHZmRjb0xW?=
 =?utf-8?B?RnprM2dOaElva3diZGdqa2J5aitqdUVhNzQ2ZksrVE1TcVliQUFCL1d4NHp2?=
 =?utf-8?B?MDNHRkplYUs0dFg5QWZzSS9ycEphalAyZWhpeVdOL2NjT3BFZnlzT2pTYTNR?=
 =?utf-8?B?ZXU4Skt1QnhhNkcvRlpJY3JNV3VJeXZ6a2xJUVZESml2QlJvTG5WMUg5NVRt?=
 =?utf-8?B?REFlbjRJY2VVSkEySCtIbGtiZ2cySEtacFBQN3VmRUdsU2pqU1g1Y1RHM0lq?=
 =?utf-8?B?TzFLNFpOYVhYSGpwRzBMVGRydzJFVE5nMmlGdEJLWFRMQnhOeHR2aTNwN0Vv?=
 =?utf-8?B?N0g0eWdFaEZnV08yVlZ1aGgrdU9FSHdCY2dzWDMyOXBPM0dYNUZaUzJhQUlF?=
 =?utf-8?B?UDlmSzdUMUFQU1JVbVFoRUNuOVNzZy9SVEYrUWYrWWI4NkFTNEUzV21TV3Jl?=
 =?utf-8?B?anp1RkhTc1V4b29zNkVIYWEyZ3FuaEdsZ0s2aHRTWk9HUU1rQ0tpaUJWSTdP?=
 =?utf-8?B?anNzYWVVYjNoWjZIbFVDTWJTU3RhQjFtY2tqdEVnb05BcGtVMlFqc0dFaFdp?=
 =?utf-8?B?NkoxdnEydi8wamwwMnlqL0M3eFRSUkxSWkhSTWhrMk5Eb1NWSnpLblRNODQz?=
 =?utf-8?B?VGp5N2wxVEd6SzVKR0piRnozTkkzOTlYVzJWaXVtY2pBaXZpTnhSQzUxaXhR?=
 =?utf-8?B?MVVpRDhtYUtlWTF0K29Yd2p2WmF1VUNVL1ZxMm9TaVpKNTZWdy9NK0tkdTZU?=
 =?utf-8?B?THl3akkwSENWaEdhM2lYazJtOThMNThwWkU0OWJDOFhyRkMrSnRqQzQ4SHdj?=
 =?utf-8?B?MHdYZ2dHUWl3MldxWG54VVo0UkFlSHp0ajBLdlhsMHQyRlRUWVUxWCtYQ0Fr?=
 =?utf-8?B?T0VRa3k2U1BCTitWMW5xbW5kM09PVHZBVVcvS1BVMndOSVpFQlE1VnRabUFD?=
 =?utf-8?B?enlwWDk2NUk5U2N5bmlPdExSTFlSNWZLL1ZidTVCbVVWenozRGtBNlhCazRC?=
 =?utf-8?B?MUdlNS9rb0tlaEh2a0xpK0NvSlhDaEVPcmhYc0hTcU93aFIySnNyMXpHOWRv?=
 =?utf-8?B?VmFHSXVHRWVOY1J4eFRBMGhYL1dHRXBDaEg0ZTh1TVNHdis0YzFMNmRrNkdo?=
 =?utf-8?B?eWFoalBMNVBmNnIyYmpsaVkzeEV4aUFyay83a0VpaTd2dGYreTBFMldGY2RP?=
 =?utf-8?B?eVRMQWF0WFEvSEp6U2tHd00vQ1FNS0Z2K2lQZTdPbkZSaURFOU15SElRam1s?=
 =?utf-8?B?K1c2WUZXWGtWK3JRUkoxUU1seUY3MUtpV1MrRTIrYUU3WkVkeG51dXhmTW5H?=
 =?utf-8?B?MjdvWkFuenNIc0REVWREL0lTQXdiaFhFTER1RDg3aG1ydEhTbkgyZHVyd2wx?=
 =?utf-8?B?THhyM2JzYmJFcjRVOEpacHBLWms5eS92N1hROExDN0RrUThoNm9GbmU0L1I1?=
 =?utf-8?B?NlUyL09hSm1ycUNXOThpSEdTRitZOWlUaEIvWldzNWw5ZTBRUWtzT0U0L3pq?=
 =?utf-8?B?RXFFMllHY2k4OWx5eEdWUVNMU2JlbS9GVVg4cXlWQUFsQmFQS3dCNUNnMk1w?=
 =?utf-8?B?eUJ4MGxpQ1BlYXBRSEtWcmM4YVZseE91L1JDTXlOUFlYaFpzZ05QdlhqZFIy?=
 =?utf-8?B?RVFLaUVHbmNlV2JCTmNhNGZTZ3pGSHA5OTlkMWRkY0xQS2tXdnVJT1ZManUx?=
 =?utf-8?B?aEpMcFB2R2xuelFpRUg3U2J3K3hieHVTQjJJMHh3bTRwNU0yeDlyQU1TakpH?=
 =?utf-8?B?VStaamV6UjVnM1hIZTB6S3FLb0hhei9YK04xSDlvOElSbmtKVkRJUEtHMVdR?=
 =?utf-8?B?andSSDZROHRiR2hMalpGRjFNeG1lWXFqcjFLcUN6d1V2UDQ5a1hUd0RBanJ6?=
 =?utf-8?B?TzI1S3pWeHk5YTVleWY1TmdqeW5QMGhvYjVuaWZyZEZQc1hqcERVOHRIdnY3?=
 =?utf-8?Q?ZXB5wrdVNTlbGYiEKl9KRpbYd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94366b-f9b8-4476-3e6a-08dc19237ce7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 19:18:59.1305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSmgl1gmWg3vfR9rPViaRWx388Fj698s8F6/ShEvbwlk4wn8Tox63kRwqLKah2ok5koOrZ/uMI1KZJReemER4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-18 07:07, Christian König wrote:
> Am 18.01.24 um 00:44 schrieb Friedrich Vock:
>> On 18.01.24 00:00, Alex Deucher wrote:
>>> [SNIP]
>>>>>>> Right now, IH overflows, even if they occur repeatedly, only get
>>>>>>> registered once. If not registering IH overflows can trivially 
>>>>>>> lead to
>>>>>>> system crashes, it's amdgpu's current handling that is broken.
>>>>>> It's years that we last tested this but according to the HW
>>>>>> documentation this should work fine.
>>>>>>
>>>>>> What could potentially happen is that the IH has silenced the source
>>>>>> of the overflow. We never implemented resetting those, but in this
>>>>>> case that here won't help either.
>>>>>>
>>>>> If the IH silenced the page faults (which quite clearly cause the
>>>>> overflow here), then how are the page faults still logged in dmesg?
>>>> There should be a hardware rate limit for the page faults, e.g. there
>>>> can only be X faults reported in N clock cycles and then a delay is
>>>> inserted.
>>> @Christian Koenig  Is that tied to xnack (i.e., noretry)?  The default
>>> is noretry=1 on gfx10.3 and newer.  But it can be overridden. It was
>>> not set on some older kernels, maybe that is the problem? @Friedrich
>>> Vock does setting amdgpu.noretry=1 fix the issue?
>>
>>
>> No, amdgpu.noretry=1 does not change anything.
>
> Well the good news first the hw engineer answered rather quickly. The 
> bad news is that the hardware really doesn't work as documented in 
> multiple ways.
>
> First of all the CLEAR bit is a level and not a trigger, so the 
> intention to clear it is indeed correct. For now please modify this 
> patch so that the CLEAR bit is set and cleared directly after setting 
> it, this way we should be able to detect further overflows immediately.
>
> Then the APU the Steam Deck uses simply doesn't have the filter 
> function for page faults in the hardware, the really bad news is it 
> also doesn't have the extra IH rings where we could re-route the 
> faults to prevent overflows.
>
> That full explains the behavior you have been seeing, but doesn't 
> really provide a doable solution to mitigate this problem.
>
> I'm going to dig deeper into the hw documentation and specification to 
> see if we can use a different feature to avoid the overflow.

If we're not enabling retry faults, then each wave front should generate 
at most one fault. You should be able to avoid overflows by making the 
IH ring large enough to accommodate one fault per wave front.

If the faults are coming from SDMA, that may be another problem. I'm not 
sure whether it can generate multiple no-retry faults from the same queue.

Regards,
   Felix


>
> Thanks,
> Christian.
>
>>
>> Regards,
>> Friedrich
>>
>>> Alex
>>>
>>>>>>> The possibility of a repeated IH overflow in between reading the 
>>>>>>> wptr
>>>>>>> and updating the rptr is a good point, but how can we detect 
>>>>>>> that at
>>>>>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
>>>>>>> then, because we're guaranteed to miss any overflows that happen 
>>>>>>> while
>>>>>>> the bit is set.
>>>>>> When an IH overflow is signaled we clear that flag by writing 1 into
>>>>>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>>>>>
>>>>>> What can of course happen is that the IH ring buffer overflows more
>>>>>> than this single entry and we process IVs which are potentially
>>>>>> corrupted, but we won't miss any additional overflows since we only
>>>>>> start processing after resetting the flag.
>>>>>>
>>>>>> An IH overflow is also something you should *never* see in a
>>>>>> production system. This is purely for driver bringup and as fallback
>>>>>> when there is a severe incorrect programming of the HW.
>>>>>>
>>>>>> The only exception of that is page fault handling on MI products
>>>>>> because of a hardware bug, to mitigate this we are processing page
>>>>>> faults on a separate IH ring on those parts.
>>>>>>
>>>>>> On all other hw generations the IH should have some rate limit 
>>>>>> for the
>>>>>> number of faults generated per second, so that the CPU is always 
>>>>>> able
>>>>>> to catch up.
>>>>> I'm wondering if there is another bug in here somewhere. Your
>>>>> explanation of how it's supposed to work makes a lot of sense, but 
>>>>> from
>>>>> what I can tell it doesn't work that way when I test it.
>>>>>
>>>>>  From the printk_ratelimit stats it would seem like >2000 faults 
>>>>> arrive
>>>>> in less than a second, so perhaps your theory about fault interrupt
>>>>> ratelimiting not working is correct (but it's hard for me to 
>>>>> verify what
>>>>> is going on without the documentation).
>>>> I'm going to ping the relevant engineer and putting someone on the 
>>>> task
>>>> to take a look.
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>>> Regards,
>>>>> Friedrich
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Regards,
>>>>>>> Friedrich
>>>>>>>
>>>>>>>> When you clear the overflow again when updating the RPTR you could
>>>>>>>> loose another overflow which might have happened in between and so
>>>>>>>> potentially process corrupted IVs.
>>>>>>>>
>>>>>>>> That can trivially crash the system.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    static int cik_ih_early_init(void *handle)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>> index b8c47e0cf37a..076559668573 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> -
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>    static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>> +
>>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    static int cz_ih_early_init(void *handle)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> -
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                    struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>> +
>>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    static int iceland_ih_early_init(void *handle)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>> +
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>    }
>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>
>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    /**
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>> +
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>    }
>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>
>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    /**
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>    }
>>>>>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>
>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    /**
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>            tmp = RREG32(IH_RB_CNTL);
>>>>>>>>>            tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>>            WREG32(IH_RB_CNTL, tmp);
>>>>>>>>> +        ih->overflow = true;
>>>>>>>>>        }
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>    }
>>>>>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>    static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>> +
>>>>>>>>>        WREG32(IH_RB_RPTR, ih->rptr);
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32(IH_RB_CNTL);
>>>>>>>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>> +        WREG32(IH_RB_CNTL, tmp);
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    static int si_ih_early_init(void *handle)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct 
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev,
>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>> +
>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>>            /* XXX check if swapping is necessary on BE */
>>>>>>>>>            *ih->rptr_cpu = ih->rptr;
>>>>>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>        } else {
>>>>>>>>>            WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    static int tonga_ih_early_init(void *handle)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>> index d364c6dd152c..bb005924f194 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>
>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    /**
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>
>>>>>>>>>    out:
>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>    static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>    {
>>>>>>>>> +    u32 tmp;
>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>
>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>        }
>>>>>>>>> +
>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>> bit),
>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>> +     */
>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>> 0);
>>>>>>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>> +        ih->overflow = false;
>>>>>>>>> +    }
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>>    /**
>>>>>>>>> -- 
>>>>>>>>> 2.43.0
>>>>>>>>>
>
