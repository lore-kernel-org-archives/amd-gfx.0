Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDD2C47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 10:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D77210EC68;
	Mon, 22 Jan 2024 10:10:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C775E10EC68
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 10:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lclqnwEkVh+7749Y5cE9gzJf9+cePD60d+AsJO0vKcLPBeVALA+MiwruahOK1lXa0SqLzBS84CA8FGrZbvim7rVRkX64xbuzw2B6fU8wZ+DPBpe16mJuNqvBxAEDeS3+HuUDlefeJbnMSj6+bVQTsH459YECgrrwfSbFHTRY1FTgkOf1JteVUAqSUKFcDtq3DRToFJKHHBA0ab4cNlQrsX8y5LqFR0W+ob6/oJ3dbvaIBfvmDHYM6rJ90vXSSWZXWaFmzdz1cE4mjudiMP6OF/bZ5irIugg36NQ7lkKsw3kbGr5sXmzVcsNh07JnoCw3fUHaxDozFk6iGVsN6RCiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy+jMxZWVT/x9lFq2us9bcVdlX6IJWrJo7kGmsT5zUA=;
 b=FqwwglLXt5ZNDMIIJwb6LZw0KIrvoRfAgd+i0nTOjx9fHcn3WeMus0eQyPxj3dyUaMM8IF21V6vtIPQgJq4+5Ca9Ac85Gd9vVQqsWuYeA2Vmt7AoHHl6oFIT6K1AGBkTalW1kX5AwDo76GO6oGQgFNERE78lTKtZ134IPlHLq8bsrRWxM9pM76PbS/1PFMaVeULTWuQT17YHUNf8T5TH1wTRYV6YY0ZRwEbhcmLrtwR12FzDI1lJE7MZjT8RqqANtA3vCpKrTU0VBcWE1X9NP/LzAHhUgHKNhAWb4niDm15zy0KqtgpYFXlVldWV/7StOzcLmMFm6neKcjTOhynUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy+jMxZWVT/x9lFq2us9bcVdlX6IJWrJo7kGmsT5zUA=;
 b=UGNYcC4kZDxVZtzeQQmDqSdI53P3ttWq6A4xXDjsHtsO6yTYtRHYXLZD2enxcVkz2Ol5KxU66Is8/NxDk6Olt2G8yS/PxPx2YudPM8BSAdjxhbSmo5Gbc+MBfUAFEiOWvTbBEnAz88n8CHqU19dzz91aQKGYYm/19uTdt3KshXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 10:10:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 10:10:31 +0000
Message-ID: <0db29a99-f434-4886-9204-54eafaefa31a@amd.com>
Date: Mon, 22 Jan 2024 11:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, Alex Deucher
 <alexdeucher@gmail.com>, "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
 <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
 <42af4788-10bb-4107-bd1a-05f15dc9c1fa@gmx.de>
 <4d3e3c70-3307-4068-9416-613a19f587d4@gmail.com>
 <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6590bae2-406d-4f45-a3e9-5dc6653925cf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM8PR12MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4fc941-82b0-4a52-9fa0-08dc1b325d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4mKBk0XfHeP8ARbg00WatA9mJbVe1AbpwH8bXvlN9PQgL5uxRxTTFCndLOQ8rbvUU8MRiyUjJmQAbMzOKbCVydxDz+1tV/xTO3XbQCBE9faojI2RLubuNJ3G/mpepfwZeIe3Eeut28P5l6FVojlqa/F2HPGHXLvpGKHLsmblEwheviBUL5ZHHGLP45e7rXZygkubMWYLP3PVmuY3izpchdYsNMPDNwNlZq2VSeGfAGNrTJLm+e+1Wzwpb3D2qGhKEwrNj02xGV26eSZUNUK+K1j4CiirxCnPKqi3g8X5VNavQU81oid9bO+mLO5hIIzkGQSRgLw2NLj2aYOCSsOA0F1c7XvKiMNSUCP0ug7R/UECQNGeqxEZmK4wT0QEvE4dV4+Q0ffaaK0MhBCl04EZgbTxBXBkGZjYk8krgqAn/L4d0tQznlVdqawqPjAArziaVJxxddRKxA7Dnshlz627goGQzIrumLX+1/9yu/dmEaTA3VF7GfH9T0rCYBvy6NMysVb8KS4Td6antJW8cBhqXkwLgLq0ZEzCtRH9Lg+YimhIctnu55iuMDzMQ75jLmaGVg9LzsH6vqn8Hb5O3OMSt46Oa4SkZl0K89KizVG0lrtjKr5jgKyLdw4gy0rGaI0cIwNeGTLQakY1my8/WEz7sSa/2CD+K0FcDYfMgzO4u8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(66574015)(2616005)(26005)(41300700001)(38100700002)(66476007)(66556008)(66946007)(54906003)(316002)(6636002)(5660300002)(2906002)(30864003)(110136005)(8676002)(8936002)(4326008)(6506007)(6512007)(6666004)(53546011)(6486002)(478600001)(36756003)(31696002)(86362001)(31686004)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRqL1BrK0NaV3dCSVJ0NEJzMHhhLzRnaG9kUk1KVkY0UlpCdXlCYUdxN2F3?=
 =?utf-8?B?VVArbE1FNXpXMkhiK3Bybk43Q05aMldMWklwbHFTeDNlaERwaXlmeXJ5VnBX?=
 =?utf-8?B?MmJkdWI5aSswMUQ0dEk3WlpIQVM3U2ZmbHdxSE5XVHI3VnQra2ZuQjFmUW9P?=
 =?utf-8?B?ZzA4Um40K0tqRUpQdG1UdlNuMWt0R0o2WUJyYUNwR2lSemNtNXBBYjYrbHJr?=
 =?utf-8?B?WmdJOEZRdGlHb0dVV1AxTUJHa1VzVmZYcFFKbmhYWVRoYlpKZThZaXdEZmtv?=
 =?utf-8?B?NUhGSUVLOEhvUGV0aThydHBDbHQrcnJVVHp3ZkxmVFBabGdoekNlWkJQMU5k?=
 =?utf-8?B?NERFTjVUa1VnbGhOOXpRT3VFdnBaWjdpRy9ydjdkdE9Jdy9Cd3cwc2tIc2ls?=
 =?utf-8?B?Rkk5ZFFHalJIbWg3SGxJek5SSFl3RGpabWVhd3pXaG05dVIxTnVUNGF6QjFv?=
 =?utf-8?B?WDgzQ1RNcDBCbUU1d3FHdXcxVUJWeGVWM0JWNGxMaHRnRHl1QmFOZEZtNGNV?=
 =?utf-8?B?TmFTVFdSQWV0Yko2MjlhekxsZUlFTnAwRnUzazhaaWhUZ2YrK3RJT25BMkli?=
 =?utf-8?B?bjlSdWV6OUdQZjVVVWhTN2pqWUU2RWlHY1hVMWhWZmxkbk9wRkxMU1M4T0VN?=
 =?utf-8?B?dlo1RTl4YmV1ZXByblNXNWJvTGZKSEJ6U2RXTFI1MkN4bU53ZU5LS0VvZ2N3?=
 =?utf-8?B?UnFPaHhHNXl2SXFlQTdoSElYQkw5SXlxamxyMUtlNDZRRTE4d3l0bUZhZ0Jy?=
 =?utf-8?B?cmVlTWVlV1VOVzFrWWZaMHBhdWYrQk9KK0VMUGdYYXdFR2VncUtURXYzR0NX?=
 =?utf-8?B?alErbkFyOFhqaE9OT3VFRzBSRURqWk1lT1hCK1BEdzVwcytkYUVmeGs3c2po?=
 =?utf-8?B?SHRyaVJMWmxHc1g5MGw1QmpUTUNucjZrNmo5RklsODNNdjRzNmlrOWZsY1Fn?=
 =?utf-8?B?M01SbHovR3hkV1JENzVuMU9aL3hFL1ozK1BFVlpIRVlYc3Q5Z1ZsVFBkVXhr?=
 =?utf-8?B?dndHRkpTYXIvVUdEM25yNWVWVjE1WWdmMEdJbmR5RVZZay92QjBuOFMrdDdn?=
 =?utf-8?B?UlNwSy9CYk5sZXJ5MWo3Rm0rNGJGYm0vN0NPTTJ0VzVCVFVNM09QQ1hvUXVt?=
 =?utf-8?B?ejFMa2dpMjRNaFFSYW1ITHhkOGlON0pjbnR6T3ovQlRTY2hyV0dtaVdCa25K?=
 =?utf-8?B?VDNVK2JzN2dkaUFOYlloMmpoYkNqK3FDWUlKVnVJbjRBS2FQNUFTNnVsYTlG?=
 =?utf-8?B?eUlCM0dUUGF2MCt5QlRzWjhTLzVwcFJ4L0R4TmRYS0c0RnpzRzJwdXlvZ1or?=
 =?utf-8?B?cUtCQm5GREw0YllWSWx3d0dDU1lGYTY0MjNscFU5Y2MwT2tmMGt4eFIyZlFW?=
 =?utf-8?B?SEI3UDMwMUdqNDliMysxVTlnN2FuakNFTzN3T05oalkvblB1WU8vRzM5SnE0?=
 =?utf-8?B?eVdGNld0SisvcGpvVjkrWDJXeFNtL1U4SFJqd24yV2dGRlJOR2djV2Q0NWdZ?=
 =?utf-8?B?Tm9uNnlqa0Q2MW5TaEZwY3ZTTUJGUkNQUXEyeUlwZ2lIZ2Fha2Ficmk2Sjd1?=
 =?utf-8?B?bGlzUlVwQ0I3RERRWmZrTjAvUTZqWGpCMldabmV2WXZXNG1JeHhqS2Q5VXpY?=
 =?utf-8?B?eVVrOVRIRkNmTHdNZmJ0OGZQdmhLVmIvREdTajhwRlY1eFNlaUptUFp5dENz?=
 =?utf-8?B?ZzdULzQzVURtVlp2dWhGNmt0eTNLQmlHZjJ2UWxJRFlxK3ZRN1l1a2lLRjJa?=
 =?utf-8?B?N3d3Y3drOTRielZoUy96dHpkWVgyZWZMZGpldkVUQWVIUXdyNmtSVTkyd1cv?=
 =?utf-8?B?VG5NQUgyZ2JhaVRKY3E0TlBORGQ1bmlzOVRaR01ERlhLT09QcmtRY0JYVXJH?=
 =?utf-8?B?TUg1alZsaHg3YldrWTNsQUMzalM5Q0NNRjhpSFNoVmpPQ3dqSERhWnpPL0NH?=
 =?utf-8?B?N29zV2U5UVVKM211K1VCZHN4N2o1Wk9ITEJkL3V6S2t5SllIUEt6L0NrQUU2?=
 =?utf-8?B?KzF0R1IvbTdCSWNQemRJaExPWXFadzdvUUJzeCtJNGkzbEZmSHM1SXh4Sllt?=
 =?utf-8?B?cXplaUdZaG50QmxRdjhTdmxZSGFOckhLbTllbmhITTVPdE9NSmFCZ2lYRG8v?=
 =?utf-8?Q?kRy52fbTMUwf4pFpPMvyxvOyy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4fc941-82b0-4a52-9fa0-08dc1b325d66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 10:10:31.4853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTTuSFayVAObCGjq2BZMdCmC7UoDcSM3rNtS+V7G49VNsLfmJS2hDsXv8N00gaSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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

Am 19.01.24 um 20:18 schrieb Felix Kuehling:
> On 2024-01-18 07:07, Christian König wrote:
>> Am 18.01.24 um 00:44 schrieb Friedrich Vock:
>>> On 18.01.24 00:00, Alex Deucher wrote:
>>>> [SNIP]
>>>>>>>> Right now, IH overflows, even if they occur repeatedly, only get
>>>>>>>> registered once. If not registering IH overflows can trivially 
>>>>>>>> lead to
>>>>>>>> system crashes, it's amdgpu's current handling that is broken.
>>>>>>> It's years that we last tested this but according to the HW
>>>>>>> documentation this should work fine.
>>>>>>>
>>>>>>> What could potentially happen is that the IH has silenced the 
>>>>>>> source
>>>>>>> of the overflow. We never implemented resetting those, but in this
>>>>>>> case that here won't help either.
>>>>>>>
>>>>>> If the IH silenced the page faults (which quite clearly cause the
>>>>>> overflow here), then how are the page faults still logged in dmesg?
>>>>> There should be a hardware rate limit for the page faults, e.g. there
>>>>> can only be X faults reported in N clock cycles and then a delay is
>>>>> inserted.
>>>> @Christian Koenig  Is that tied to xnack (i.e., noretry)? The default
>>>> is noretry=1 on gfx10.3 and newer.  But it can be overridden. It was
>>>> not set on some older kernels, maybe that is the problem? @Friedrich
>>>> Vock does setting amdgpu.noretry=1 fix the issue?
>>>
>>>
>>> No, amdgpu.noretry=1 does not change anything.
>>
>> Well the good news first the hw engineer answered rather quickly. The 
>> bad news is that the hardware really doesn't work as documented in 
>> multiple ways.
>>
>> First of all the CLEAR bit is a level and not a trigger, so the 
>> intention to clear it is indeed correct. For now please modify this 
>> patch so that the CLEAR bit is set and cleared directly after setting 
>> it, this way we should be able to detect further overflows immediately.
>>
>> Then the APU the Steam Deck uses simply doesn't have the filter 
>> function for page faults in the hardware, the really bad news is it 
>> also doesn't have the extra IH rings where we could re-route the 
>> faults to prevent overflows.
>>
>> That full explains the behavior you have been seeing, but doesn't 
>> really provide a doable solution to mitigate this problem.
>>
>> I'm going to dig deeper into the hw documentation and specification 
>> to see if we can use a different feature to avoid the overflow.
>
> If we're not enabling retry faults, then each wave front should 
> generate at most one fault. You should be able to avoid overflows by 
> making the IH ring large enough to accommodate one fault per wave front.

That is the exact same argument our HW engineers came up with when we 
asked why the APU is missing all those nice IH ring overflow avoidance 
features the dGPUs have :)

The only problem with this approach is that on Navi when a wave is 
blocked by waiting on a fault you can't kill it using soft recovery any 
more (at least when my understanding is correct).

>
> If the faults are coming from SDMA, that may be another problem. I'm 
> not sure whether it can generate multiple no-retry faults from the 
> same queue.

Regarding faults the SDMA is relatively harmless compared to the 3D 
engine, IIRC the resolve queue is something like 128 entries deep. So 
you never see more than those 128 faults if I'm not completely mistaken.

Sunil is setting up a test system for this in an AMD lab and will play 
around with a few HW features to mitigate the issue. I still hope that 
we can completely avoid the overflow altogether.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Regards,
>>> Friedrich
>>>
>>>> Alex
>>>>
>>>>>>>> The possibility of a repeated IH overflow in between reading 
>>>>>>>> the wptr
>>>>>>>> and updating the rptr is a good point, but how can we detect 
>>>>>>>> that at
>>>>>>>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at 
>>>>>>>> all
>>>>>>>> then, because we're guaranteed to miss any overflows that 
>>>>>>>> happen while
>>>>>>>> the bit is set.
>>>>>>> When an IH overflow is signaled we clear that flag by writing 1 
>>>>>>> into
>>>>>>> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
>>>>>>>
>>>>>>> What can of course happen is that the IH ring buffer overflows more
>>>>>>> than this single entry and we process IVs which are potentially
>>>>>>> corrupted, but we won't miss any additional overflows since we only
>>>>>>> start processing after resetting the flag.
>>>>>>>
>>>>>>> An IH overflow is also something you should *never* see in a
>>>>>>> production system. This is purely for driver bringup and as 
>>>>>>> fallback
>>>>>>> when there is a severe incorrect programming of the HW.
>>>>>>>
>>>>>>> The only exception of that is page fault handling on MI products
>>>>>>> because of a hardware bug, to mitigate this we are processing page
>>>>>>> faults on a separate IH ring on those parts.
>>>>>>>
>>>>>>> On all other hw generations the IH should have some rate limit 
>>>>>>> for the
>>>>>>> number of faults generated per second, so that the CPU is always 
>>>>>>> able
>>>>>>> to catch up.
>>>>>> I'm wondering if there is another bug in here somewhere. Your
>>>>>> explanation of how it's supposed to work makes a lot of sense, 
>>>>>> but from
>>>>>> what I can tell it doesn't work that way when I test it.
>>>>>>
>>>>>>  From the printk_ratelimit stats it would seem like >2000 faults 
>>>>>> arrive
>>>>>> in less than a second, so perhaps your theory about fault interrupt
>>>>>> ratelimiting not working is correct (but it's hard for me to 
>>>>>> verify what
>>>>>> is going on without the documentation).
>>>>> I'm going to ping the relevant engineer and putting someone on the 
>>>>> task
>>>>> to take a look.
>>>>>
>>>>> Thanks,
>>>>> Christian.
>>>>>
>>>>>> Regards,
>>>>>> Friedrich
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Friedrich
>>>>>>>>
>>>>>>>>> When you clear the overflow again when updating the RPTR you 
>>>>>>>>> could
>>>>>>>>> loose another overflow which might have happened in between 
>>>>>>>>> and so
>>>>>>>>> potentially process corrupted IVs.
>>>>>>>>>
>>>>>>>>> That can trivially crash the system.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    static int cik_ih_early_init(void *handle)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>> index b8c47e0cf37a..076559668573 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>>>>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> -
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>    static void cz_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>> +
>>>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    static int cz_ih_early_init(void *handle)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>> index aecad530b10a..1a5e668643d1 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>>>>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> -
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void iceland_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                    struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>> +
>>>>>>>>>>        WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    static int iceland_ih_early_init(void *handle)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>> index d9ed7332d805..ce8f7feec713 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>> +
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>>    }
>>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>>
>>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    /**
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>> index 8fb05eae340a..668788ad34d9 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>>>>>>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>> +
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>>    }
>>>>>>>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>>
>>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    /**
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>> index e64b33115848..0bdac923cb4d 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>>>>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>>    }
>>>>>>>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void navi10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>>
>>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    /**
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>> index 9a24f17a5750..ff35056d2b54 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>>>>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>            tmp = RREG32(IH_RB_CNTL);
>>>>>>>>>>            tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>>>            WREG32(IH_RB_CNTL, tmp);
>>>>>>>>>> +        ih->overflow = true;
>>>>>>>>>>        }
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>>    }
>>>>>>>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>    static void si_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                   struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>> +
>>>>>>>>>>        WREG32(IH_RB_RPTR, ih->rptr);
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32(IH_RB_CNTL);
>>>>>>>>>> +        tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
>>>>>>>>>> +        WREG32(IH_RB_CNTL, tmp);
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    static int si_ih_early_init(void *handle)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>> index 917707bba7f3..6f5090d3db48 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>>>>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct 
>>>>>>>>>> amdgpu_device
>>>>>>>>>> *adev,
>>>>>>>>>>        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void tonga_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                      struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>> +
>>>>>>>>>>        if (ih->use_doorbell) {
>>>>>>>>>>            /* XXX check if swapping is necessary on BE */
>>>>>>>>>>            *ih->rptr_cpu = ih->rptr;
>>>>>>>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>        } else {
>>>>>>>>>>            WREG32(mmIH_RB_RPTR, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32(mmIH_RB_CNTL);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> +        WREG32(mmIH_RB_CNTL, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    static int tonga_ih_early_init(void *handle)
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>> index d364c6dd152c..bb005924f194 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>>>>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void vega10_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>>
>>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    /**
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>> index ddfc6941f9d5..bb725a970697 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>>>>>>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>        tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
>>>>>>>>>>        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR, 1);
>>>>>>>>>>        WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
>>>>>>>>>> +    ih->overflow = true;
>>>>>>>>>>
>>>>>>>>>>    out:
>>>>>>>>>>        return (wptr & ih->ptr_mask);
>>>>>>>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>    static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>>>>>>>>>>                       struct amdgpu_ih_ring *ih)
>>>>>>>>>>    {
>>>>>>>>>> +    u32 tmp;
>>>>>>>>>>        struct amdgpu_ih_regs *ih_regs;
>>>>>>>>>>
>>>>>>>>>>        if (ih == &adev->irq.ih_soft)
>>>>>>>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>            ih_regs = &ih->ih_regs;
>>>>>>>>>>            WREG32(ih_regs->ih_rb_rptr, ih->rptr);
>>>>>>>>>>        }
>>>>>>>>>> +
>>>>>>>>>> +    /* If we overflowed previously (and thus set the 
>>>>>>>>>> OVERFLOW_CLEAR
>>>>>>>>>> bit),
>>>>>>>>>> +     * reset it here to detect more overflows if they occur.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (ih->overflow) {
>>>>>>>>>> +        tmp = RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
>>>>>>>>>> +        tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, 
>>>>>>>>>> WPTR_OVERFLOW_CLEAR,
>>>>>>>>>> 0);
>>>>>>>>>> + WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
>>>>>>>>>> +        ih->overflow = false;
>>>>>>>>>> +    }
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    /**
>>>>>>>>>> -- 
>>>>>>>>>> 2.43.0
>>>>>>>>>>
>>

