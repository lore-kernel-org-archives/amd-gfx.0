Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D19C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D96F10EEC3;
	Thu, 30 Mar 2023 15:09:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513E510EEC3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJXh2IBUydM1cFyl+vNIGEEtpE29P0eftszjrVgKax42X/fRWorb//ayiVWn9TXcMHx4I0L7N4lImPDw98HJqGxOnCpuqftqEOQ/X/bbRLN2Szqc0zUMN4dY7dIXOJ/vfygDLO2DXqqH/89/PdTZ0JtnX26rnV7TjyS0q/zJr2yr6V7Ul5DDlj14cNTP0chkaVdNDmRY9o8uLQL7diVxQa49SxVLOCrJ7eFKLoD7wku59UnJu7ByFrcp5Q3aYNDT7ziRcupRU83IhLrcjGDT5wtgIObOjzbgE+N1Nwz6TnXkj1kAw2RrJC3kWRshCa65jktudznYJjJaV343cOgFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jDrJVrdCar1Wcald6S4HGjpLP99zCeUYgrZQuUs4sM=;
 b=ER5z2iqpncVrSGgimrPvZKx5jHwDS5a6tFp7Zi4EGyEsPMgznf9jDtTyvkCNkWe1Sp0vVMfM1+ov3uC5ZhRU6YKAiY9ZTXKLvOKNVdxqXci7e73CM1lq+kDM2QqxUZW/VmcHIsn78dbK1BqXNXQSjsvDZjeK6OMNJ2ez28jPX9M8zap/hghzA9D/KLDEnf2dA7PgVMJ97ZXzF4oto2sKQ54kTOA4UdzuR7KTUsvSTtH2lWUd8E6vBGmIVEpPxPd+QPDpeLAr301WVY8VS7nK1SgvdwEbXNnFSNYM/BwMxC8nr/2NsKpBDYW1TFV7gXl7btVS+dSzt1YHc0aWOuRqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jDrJVrdCar1Wcald6S4HGjpLP99zCeUYgrZQuUs4sM=;
 b=JFwlFcMRi3FRYO4AbA7fr53q/3wYAupbu7CV+1t6cwpbZSzldSnp9CzksdF/f+0uTHhCJRi0Wd18iOBZ8SxzyHll0vJ+oRHiG9X6hhjLWLr5A5NJbWhrDREDfhS56JP+TmyiRBwi1kO637jTuyNU+or5c1EE3BtvWpek6AP47kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 15:09:46 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 15:09:46 +0000
Message-ID: <f7254294-9b35-b0a7-89d4-3951db30ed8c@amd.com>
Date: Thu, 30 Mar 2023 17:09:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
 <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
 <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
 <e41c9db6-8633-e7b6-e1e8-c5bd6d607975@amd.com>
 <e256850e-8392-ce27-5aa3-fa5bb485be71@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <e256850e-8392-ce27-5aa3-fa5bb485be71@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c57144-d459-4403-d2ed-08db3130cc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nom8xfBEihdD0Xpcq4/R5fKiRhRSD8qUv+MelgmZc25fGvuLMEcqleC7CWOYi9y5wjnMQ0mIDrGrNToPbJAlhC3JuRnwIEE/xg6QQO1Q94NAfO4kxM6h4DDtYmlFJeeVyokByihKvv6igMLYsoaHoMMTL8hyw7bnpdeivyB0PgxSy7LOM687ftHrN0kVsvCp4ktf4ulnviWJlOwfKlE2ngQx5jPOg1+4Kmcp5c/+eWEgZ+VQQHcsy6sG5rmSA+nwR6xJRT06gD/syMIMmb9m28BFUNBEBUUz9PmAqLcc4Cd2v1ZMRGzyGnGnp+e9zCumBfJ2au1zUy+Se6/+7cqgznqwIVVVCNR+gkifcJTfugIHhGgOiyXpcAw1+v6jWuZQ2wAA7ufP5AEp7c59FKQxj98Y2vo0ilgGl3itVEgz3JrcObjjkeMvtHbmDwLbRT07SOIUssREtbJUVqTWfu6S82UBWsUrKyDEomVsUtLHaXtN+sq70lLsTa2RcekWtsccDKfykFxegsJzO0Psg3UXvuQJtrlould0sSNNTM8+T0iq0VvCujvYNbIZtQ+TPRFp7cyNbm7TCJJhw2PgOjLnVZ1pyPNUzOHwZC//fTDMI5Kyv/3dzz33ityyhdyS+SSob0SII7lUiT8tGqbVJl6/Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(6666004)(4326008)(66574015)(66946007)(316002)(8936002)(66476007)(26005)(6506007)(41300700001)(54906003)(5660300002)(186003)(44832011)(83380400001)(478600001)(2616005)(66556008)(8676002)(6512007)(110136005)(6486002)(53546011)(38100700002)(31686004)(86362001)(31696002)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHp4TWVVMU1xay9mT3FMUnUwUjl3akZ1QUxhOHhWM25OekJoOGNDVGptaFIy?=
 =?utf-8?B?K3d3NUlsUkQ2a1dCWjZWZG5wSWVKZjgwWGlQOUJXVVRXenFHL0J1Nmh0MXo0?=
 =?utf-8?B?bHdzcGovOUIzSFhQYkRvRVdqMC9KanNKc1RLN3lnR3VnNGZkbzFoQ240OFNE?=
 =?utf-8?B?UmFlaG9ZR2sxdno2RDlrNFAvWExlbHhzbFZsOXVRNnBiTzFudDVuSFlWVVI4?=
 =?utf-8?B?aVphQmhQVEVHVVkwYWlrakNEc3dkVXJJZUpOeERReC9tNWZZQVhMK2ZFNjAv?=
 =?utf-8?B?WkxnMkJaNlB2ZDF3T0ZhenByOVMwclQ1ZkxGeUlFR1FFOWtyK3RDT1dOczZk?=
 =?utf-8?B?N3F1VzhrdmlOYnBKSGxhS2psUW5JSkNtVDJtWWdMRm9ERHpObUdPekdSeXZz?=
 =?utf-8?B?ZDNleFZtMDVnVmdKajhCTTJhUmlORWd2T2hzUFJrODFDcUlNK0lJWFZuTklw?=
 =?utf-8?B?dUh0ZWFEa1RiR3lldEg5NEIxOHdPVkV2NTh6ejVnY1NZdmY1emsrRGxQTlJs?=
 =?utf-8?B?a3VSbDR0Ym9PamVpcmFXMW91eFZVWjZaQXlkL0QxdHZFVVREL1p2dkt1Wnlm?=
 =?utf-8?B?dGJyUGxVNVdTZ2RmN2d3NG1ibWxCWGpFcm8rcDQ3NW5JYzlmTGlUTGxSMEY0?=
 =?utf-8?B?ZmE4aGgzU29FbVJGQTFUWVhQK05qWHVGOEFMcmlVckc0SmVqbVgxYXlwK25F?=
 =?utf-8?B?UXRkNmxOV0Fpa2lielFkcVVOdE03aEFsN0M3UytoYzUvZXdhQmd6Mm43VWdW?=
 =?utf-8?B?VEVPcEJzcWJ1dEpKandhOWh5TUsyQ2IvaVZ6OHBZZm42TjJRL3V1bFc4MXlM?=
 =?utf-8?B?ZlgwckhmM0VnbzMvMzhaaW5mK3h6SlBQZmNINSt6djUzYWxlSWJKcnJsYWlk?=
 =?utf-8?B?NXIvQThRQkp0cHZJQktqTE95R0ViRURmV1J1OGNqWnNTd08yazdaQ3AzY2Uw?=
 =?utf-8?B?aXBndmpQSGlRSURMa2JwaVl4bWN3UGhuSWFyeXRMNkV6ZkdxcWNEclFFbWVP?=
 =?utf-8?B?Y1A3L2UvUHZoYXJLWnl6d2J6dUdoOFYySlRzYkt2RTFjcC9YUjFFL3FJYmNV?=
 =?utf-8?B?di80b3M4YjcyemRzSDlhMXdOYitySFJ2akJNQUIvZDNCZU4wU2pLa05ObnRZ?=
 =?utf-8?B?VGMzbXBhSXN1eitvYS9XVG5sRjBqTHVrV3d0UzI0V1lNWUlXZjNnWlFlNnhB?=
 =?utf-8?B?WFhGSzZVeDU1VzY2b0krVkhaMVovUlJnclprejUzeEdPR1E0TXdEaFFOSmNG?=
 =?utf-8?B?UlFiRUZrZlNVNHlDalIrTkl4SzIyK2lrSUlhdzlHTU8vRXhOWmlEbjVwdEp0?=
 =?utf-8?B?QVRuZER5Qk8rRzc1ZC9XZVRRS3N5dVVLcUxVbG1ESktZT3l4MlA0MGxkaGRn?=
 =?utf-8?B?amkyQ3A4ejJWcUI1WE5lYklOL0kzTThMcUI3TGdjMWtXTGpQaFhnZXk0Tmd6?=
 =?utf-8?B?eXZhOFRLN3dkYWJuRnhUR3JYUkhlOE8wQmd5L1lidGZnbEg5MHN5Zi9aQlJZ?=
 =?utf-8?B?czEvdTVWWENpUW5kRWVMNEYzTUFESVRVM012NDl0eno0MFR3Uk5HOCs4R1By?=
 =?utf-8?B?VDZJVmxKUFljVVpHLzA2RlhaM3J3OTlLSkJGMEhGeENKV3FiZmIxZlV2TVFD?=
 =?utf-8?B?NUtZajZpeWRxVXU0cHNKbk4zT01MTmVIczRaWmdoOTVwSDMwVFQvOHR4QlBs?=
 =?utf-8?B?QmVGTSt3ZUlkZ0FCOXIyUURtOEdRc3pya3N5LzFwVDdTdUVWU2hLKytJMGxN?=
 =?utf-8?B?ZXlySkhLM2ZJS2FTMWNtcUZ2Ukk0anc5aFNjNHFLOGxTQzcvRnFiWlV0Q2FX?=
 =?utf-8?B?anhwVjFReUhJd3hPeFZpQk1qbEN6a1RCaHBVZWl0YjQzQUdlSFgxQnhaMjYv?=
 =?utf-8?B?YnpEYkNwSmFzMzFHTzRNa21VUnRYZnNQay8zWS9tWmlKYlpnQ1hzck9HN0k0?=
 =?utf-8?B?clY2elAwMGZLam9BcWRTRnlTZk41cUViSlB6VklqMGtSL2VGM1h5NXZPL212?=
 =?utf-8?B?WUxzaU1wQTlYcjU3Q25ER1ZTNEpxR0FOZWVsSUlydkk1NEVlSmMzNWZpRkI0?=
 =?utf-8?B?b1czTDg5dnhpeWZCT0lHWFdZMHcxeWJja3cwZFdOTjJaNW0ySE44TWh2elVF?=
 =?utf-8?Q?oxNIBglff8uGh9MnFMGFs6tWV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c57144-d459-4403-d2ed-08db3130cc2b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:09:45.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSn6uZoAchZm4omyfEld36X6sCUWshhNYBpN/gNmEWqOlDfMObzhb/MCYgZfZx5+4VJNhwM7PjfEmeoFLglS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:59, Luben Tuikov wrote:
> On 2023-03-30 10:53, Shashank Sharma wrote:
>> On 30/03/2023 16:49, Christian König wrote:
>>> Am 30.03.23 um 16:40 schrieb Shashank Sharma:
>>>> On 30/03/2023 16:24, Luben Tuikov wrote:
>>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>
>>>>>> This patch:
>>>>>> - creates a doorbell page for graphics driver usages.
>>>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>>>     kernel-doorbell-bo's cpu address.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44
>>>>>> +++++++++++++++----
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>>>    3 files changed, 57 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> index 6581b78fe438..10a9bb10e974 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>>>>        /* doorbell mmio */
>>>>>>        resource_size_t        base;
>>>>>>        resource_size_t        size;
>>>>>> -    u32 __iomem        *ptr;
>>>>>> +    u32    __iomem        *ptr;
>>>>>>          /* Number of doorbells reserved for amdgpu kernel driver */
>>>>>>        u32 num_kernel_doorbells;
>>>>>> +
>>>>>> +    /* For kernel doorbell pages */
>>>>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>>>>    };
>>>>> Here's an example where it could be confusing what the difference is
>>>>> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
>>>>> As the comment to the struct doorbell_obj declarations says
>>>>> in patch 7,
>>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>>>> +struct amdgpu_doorbell_obj {
>>>> What is the confusion ? This is the object which is holding doorbell
>>>> page. There could be 2 type of
>>>>
>>>> doorbell pages, kernel and process, this is a kernel one.
>>>>
>>>>> Perhaps we should call it "struct amdgpu_doorbell_bo", since
>>>>> it does contain amdgpu_bo's, which are doorbell's bos.
>>>> This is not a buffer object (memory), this is doorbell object, so
>>>> calling it bo would be wrong.
>>> I think what Luben means is that in object orient programming this
>>> here would be the class. The object is then the actual instantiation
>>> of that.
>>>
>> Why should we even bother about OOPs terminology in kernel C code ? I
>> think we are spending too much time in something not worth.
> Because you're using "object" incorrectly. Especially for people with
> vast programming experience, this creates confusion. Please don't use
> "obj" in the name of a structure. Perhaps use "bo" or "page" or something
> which it really _is_. But don't mix OOP terminology in non-OOP code. We
> have people who program both sides of the isle and this creates confusion.

The correct usage of object is valid only in context of OOP, not in C 
code.  As I have mentioned,

object or obj has been used in the existing AMDGPU code at multiple 
places, and it did not create

confusion so far, so it should be good now as well. I certainly don't 
find it a reason to change the

name of the structure.

- Shashank

> Let's use structure names which really describe what something is. This would
> help very much new people reading the code in the future, to form mental
> concepts and better understand the code.
> Regards,
> Luben
>
>>
>>> But I have some real doubts that this is the right approach in the
>>> first place.
>>
>> I would like to discuss and understand more on this technical aspect.
>> Can you please have a look at the whole series and check how we have
>>
>> handled the existing doorbell clients (KFD, MES), and if you feel the
>> same, we should talk more on this ?
>>
>> - Shashank
>>
>>> Regards,
>>> Christian.
>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>>      /* Reserved doorbells for amdgpu (including multimedia).
>>>>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct
>>>>>> amdgpu_device *adev,
>>>>>>    int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>>                    struct amdgpu_doorbell_obj *db_obj);
>>>>>>    +/**
>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel
>>>>>> doorbells for graphics
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * Creates doorbells for graphics driver
>>>>>> + *
>>>>>> + * returns 0 on success, error otherwise.
>>>>>> + */
>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>>> *adev);
>>>>>> +
>>>>>>    #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>>    #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index),
>>>>>> (v))
>>>>>>    #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> index 8be15b82b545..b46fe8b1378d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct
>>>>>> amdgpu_device *adev,
>>>>>>        return 0;
>>>>>>    }
>>>>>>    +/**
>>>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel
>>>>>> doorbells for graphics
>>>>>> + *
>>>>>> + * @adev: amdgpu_device pointer
>>>>>> + *
>>>>>> + * Creates doorbells for graphics driver
>>>>>> + *
>>>>>> + * returns 0 on success, error otherwise.
>>>>>> + */
>>>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device
>>>>>> *adev)
>>>>>> +{
>>>>>> +    int r;
>>>>>> +    struct amdgpu_doorbell_obj *kernel_doorbells =
>>>>>> &adev->doorbell.kernel_doorbells;
>>>>>> +
>>>>>> +    kernel_doorbells->doorbell_bitmap =
>>>>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>>>>> +                              GFP_KERNEL);
>>>>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>>>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>>>>> +        return -ENOMEM;
>>>>>> +    }
>>>>>> +
>>>>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells *
>>>>>> sizeof(u32);
>>>>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>>>>> +    if (r) {
>>>>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n",
>>>>>> r);
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>    /*
>>>>>>     * GPU doorbell aperture helpers function.
>>>>>>     */
>>>>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>            adev->doorbell.base = 0;
>>>>>>            adev->doorbell.size = 0;
>>>>>>            adev->doorbell.num_kernel_doorbells = 0;
>>>>>> -        adev->doorbell.ptr = NULL;
>>>>>>            return 0;
>>>>>>        }
>>>>>>    @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>        if (adev->asic_type >= CHIP_VEGA10)
>>>>>>            adev->doorbell.num_kernel_doorbells += 0x400;
>>>>>>    -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>>>> -                     sizeof(u32));
>>>>>> -    if (adev->doorbell.ptr == NULL)
>>>>>> -        return -ENOMEM;
>>>>>> -
>>>>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>>>> adev->doorbell.size);
>>>>>>        return 0;
>>>>>>    }
>>>>>>    @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct
>>>>>> amdgpu_device *adev)
>>>>>>     */
>>>>>>    void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>>>>    {
>>>>>> -    iounmap(adev->doorbell.ptr);
>>>>>> -    adev->doorbell.ptr = NULL;
>>>>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>>>>> +    amdgpu_doorbell_free_page(adev,
>>>>>> &adev->doorbell.kernel_doorbells);
>>>>>>    }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> index 203d77a20507..75c6852845c4 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>>>            return r;
>>>>>>        }
>>>>>>    +    /* Create a boorbell page for kernel usages */
>>>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>>>> +    if (r) {
>>>>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>>>>> +        return r;
>>>>>> +    }
>>>>>> +
>>>>>>        /* Initialize preemptible memory pool */
>>>>>>        r = amdgpu_preempt_mgr_init(adev);
>>>>>>        if (r) {
