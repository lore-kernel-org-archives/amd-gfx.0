Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B01DC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D2D10EEAF;
	Thu, 30 Mar 2023 14:49:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426EF10EEA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHDRuhOIxQ19QbMunnWQu3h3Bakx6b6edRYaG87i5nLEvpTZyYUyDCGht9/7gVmclc5a+k8K3ReHlZlzeKx0ZwclphCORXEjCjbXcgfShq9KvDhJvgHJu1at0aRpN0zG4Xko77wpjYSajLoFeBXStGYy7r2V6lC5VqAhomtLtGNWFWxcgfn+nS/ToNoWWem2L+Q0/qhmr1Bh45QWpXAP958gXuFIIbou7uWBC8wBER8c//hEV1WCX8wZYPdnFQS4IbLkEYN/bPDIfzfuFPAJ+pylbfd47ErdMIzHLTRfJFABs/R6rmC04L74/ph+Ls6t+HyemrLsDdOlEGbA3RUyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or5UxuBWtGvYsiQ6abEBgNIyLa4xcWWtUs7r4P1s3m8=;
 b=j0llHPSEAnNKcoPISWW5iye3ppr5E+2gwrZu4tsfc5DmqYj7fQCN5fUMY1Kzd9GUz6OMNjYZg6ueylRf3Y4A2TWZzJTHO9rHm0lDSg1A/dFIdqeRb9v01qlb5YisBcGNXaPkEcMk7ZfwH5dr04/mH/Zg/nEaFyLDRaQEXE4fGV5ZVd+LMR4mw/zxpJPqMoHaFCR4+zUW4h9YaVruoRwlOwWteUOuy4T73Ld8uQea/ilqm/WBqnEBSG2WhK2G9kVrtrz3Wgs0wIreVeEsxiLm80mKQjHNr7Tzxr704WxdIABCv5UR/U7PyGBqyikEuIiZYjIV7GKjlAXJpJ0DcmB/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or5UxuBWtGvYsiQ6abEBgNIyLa4xcWWtUs7r4P1s3m8=;
 b=UbCrGaGHsUo95iCYE/luetiC2CSkHguF7RzyEpOEGKkT3ui8O5499BNUl4jmg2+ncnA6h5Tq0hJ5rzCS4wqjk+RSa6jwhF6A/HdoDszn7r9RkpbcwfhZ5qDBKfG87mxUXsijbqSc8FC5mOut/U6Zc7xtAsrjYzxcdrsqdtanVBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:49:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:49:24 +0000
Message-ID: <51e57144-dde5-6bfb-45ad-0dcc79bf0cae@amd.com>
Date: Thu, 30 Mar 2023 16:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-10-shashank.sharma@amd.com>
 <41c5746c-8db9-07b4-2500-cf023031f221@amd.com>
 <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <fc73c097-5ea9-2e15-f459-e9bc2bd05c95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c66d199-1bdb-4523-0a3e-08db312df45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjPETucPGF92ECCSj0+Wu41UhguHMTEgJfEX6RgS5QMXDNqaIIrLZXoh8ipSduz+/0qUEchkzu/W3iet/GEPqLkxn3ISsqCTT/ijy1yPXj4AehAPankBa3Ps3KYoXkG3DUIhrGAIucdwNtTywmtvMET3veCp3osqMnhub2mwbrD4kNrn2arqgfb+bLLQ4Hc9lsE4mZDBaNS1ldXOow847kXEeL1giYPkKt9zl0Wr05WkKPNrdv4lpGb6TzAqNrYok+F8lOi1Y8z+Fc1Gkdf0TpGSl5N5M/9VMTgYg50Z+BbPE3cR03hYGMDxt2u48fAQWO5/l4XJ4T7DqFEd3NKrY6SAbjmZWaZ3tmLUmbiRifVOd3iLENFqx+hSULb868mu8/znsk4IWCr+hmVdb6oKpkVh6BajFG8sv/1MPI8xjumq0C/eDBKiHXVaurXoeSkc0l9AzIwbJ+i2k6E+zchp1Z1+AUaMJ8i7s/CF02oRV+22zScHrjOmLQoQ5P9oBL2zBLik/dEAJEmF8/FQR7qcRw2sm0IXTJ965INgP/fRCEpkqPlzotDPwufGQZiV1vtV94v2c7pC3ihlx2DLhbh18AAh1xFzYjWnu26u0Op9YK2xu3+i0ktoD3lnVHa4TQg3cLQYM8n0FhooYIFsiKDqzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(31686004)(83380400001)(6666004)(53546011)(66556008)(478600001)(316002)(110136005)(54906003)(6512007)(6506007)(36756003)(31696002)(66476007)(66946007)(8676002)(41300700001)(86362001)(4326008)(2616005)(38100700002)(5660300002)(6486002)(2906002)(8936002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tUOW5iUjUvTk52RkRnUmFjNk9aZnljbEczVXdMMjZqcWlkeiszREM1dHJl?=
 =?utf-8?B?QW9Nb2pBQ2hybncrQVBqN2dsRVVVUXBnTWh1TEREQmVDTGsyMlcyczVTR0ZE?=
 =?utf-8?B?bXlnM3dIdjNpR3V6NXQ2Q09OY2pOM3JxR2EvMFJCZ0dvN0RQeE9OR0x1QnJU?=
 =?utf-8?B?WGIvbmY4SVJoVFhyM2dHQU1IUzdUd2k2V0pGb2pkYUVQODJXVDQzOEwxK3o2?=
 =?utf-8?B?VGdyVTVTSXZIWkIvb0lZM3BoZGxsSGN3RDZ6azYwQlJtVXpyUEJKTmF6SWdj?=
 =?utf-8?B?dUhMMlhNWEZweDN2UE9Eb0FmTkNKSkE0M1huRFA5WTczNmZ0S3F4UVB2Nkl1?=
 =?utf-8?B?cG9BLy96MnVkSTFuU0cvek9MK3VERVdYTlNQcGQ0MWxNenR2NnhDREpzMkdi?=
 =?utf-8?B?NnhQaVZqZ255ZkIxazJXNmdrYWtYSVBxNHhqRFh3WUg5N1VRQUEyRUdOQjRZ?=
 =?utf-8?B?UVJVdmJkVVFYVkVFbzdZR0J6UXpUUEJ5SXNFTStyc21VRS95dzBIUlFEdzgv?=
 =?utf-8?B?R2Qva25aNGRoVzRxcUhvc2ozalBwa3lXT2g1TEczb2NFQm83U0QweFM2dDNh?=
 =?utf-8?B?ZGdSYW4vdGg5M2JJekNuUndKZ3YxanU3RTliNVI5d2FvTkFZUnRCdEFUR0cv?=
 =?utf-8?B?Y2lvQWFnQUF5TGxtcFJzYnZ5cWtvTkdlZmFLdXBkMEIxd1YrVlYyajd0eDdI?=
 =?utf-8?B?SGNiNzdtVWxXRGpUVTJkNldPRkIyM3kyaG0vbjVvYm4yVFdNN2J6bE9lcDdG?=
 =?utf-8?B?R2p1U2hqTTNZR1lReGt2L0t3dzVuK1g1eUZNVFpUVk1Va0tVa24xd1JLeTVp?=
 =?utf-8?B?YUpBaFQxN0lmNDVHK3U1aVpqOUdzTGpWWDFnUzF6bXhBMEdESy9FblE3M2dl?=
 =?utf-8?B?dzI2aXBHZGhBeE4vR24yaEkrYzNVRjdxdmlGQVB6TzNKc2c3dFV4UDk2cVJZ?=
 =?utf-8?B?bGpNYStrdHEwMTl2blNwMFJScWZBMndPRjlaRVVzZzhlbVVPMWx1TVVOZTRa?=
 =?utf-8?B?WnV0NXE5a0w0N1Zvb3RLNG1Ldjd1aWd6SWQ1N3RVbm5mdmt4am1oWFdPcGlj?=
 =?utf-8?B?OWJycTI4d1QreTQ3SmpPaUREQTBSclc4VzBhbnR3bVRUQUx0V0NTRm5mTkl3?=
 =?utf-8?B?Ums2V3pHZlhkOHFZK3hOWTNDcHlablVNS2xHUjlZYm9Bd3RyWjg5OTNrVGJy?=
 =?utf-8?B?SGFBRDZJRjBqMG03VmJPcWpUNGYxNWxjSXJleXN3OENPTFhnclpwRFBuVURy?=
 =?utf-8?B?K3dUUnh4WGU1MWNzMGZPaFNGM2dpbVhGWnBydzVoeklpbXdLaEdmTFYrV3Vu?=
 =?utf-8?B?SVFwOFhGSzI0aDlSSzNXM2tQZDRheEpTdi8zVnpvQ05xQUpFYm1SRWpPNEhL?=
 =?utf-8?B?bEhZVG11ZTJMWHNYVThXdC9BNi8xd010U05UdVAvdnk4UTNSODd3WWFpcGh0?=
 =?utf-8?B?TWp4eG1IY3NjM3JjL0xOZ2hqNWVGaGRsUXJDVkRWRm5pemRUYTRabU14T1VM?=
 =?utf-8?B?Y1ZrRzY5VkpHdkhDWUV0UUtTQW5mdFlYWGlMOEkzTWpXSG1VRUU0QVYvQW5O?=
 =?utf-8?B?N293VVo0cEhzS2UxVEdkM1FFOEprb3ZoV2NvMTJ6SVlIT2RwSU9teVhuZWFO?=
 =?utf-8?B?UEJncllXK21QdUxHWWZob1pJOUcrNEI3b0MwTVd6UlN5dGZaOFZkM2dxZDdG?=
 =?utf-8?B?MUxuanRWbk8yOWpnQzF4TVhreHVaRWNMWFVBU0FkbStBWHo4Q2xxdGJ0UDEw?=
 =?utf-8?B?SGtoeGczUm8xM1hXVjRwdFpORklxRm1zaGhtaEVsYVRJYUFkM3JWRW5wUVdk?=
 =?utf-8?B?WmN2WEN6N2JidFBObTZ6SU1NNzFrZG0yRGdBYldTb0hRQXdPZ1RGR2d1K3JX?=
 =?utf-8?B?RTFIMVlxamdGbXZwSmdJbFI0dEZDYVVUOTJSQnp3RE1qMitLa21ueHZ5dHp3?=
 =?utf-8?B?YVg5Q0lqUklMSk9RNlgvWjZrZitwQ0RpbmVaeWF3d0hBRTB5S05HVDErZFFW?=
 =?utf-8?B?UmUvalNKVUJ4RFRkZW5Ca1VCWXNDdGtWSDRWY1hxbWxUckJzNG5acWtGTk5I?=
 =?utf-8?B?UW1LV0R2eURoZ1JSRHErWWI0TTl5UkloRklEcGNJby9vVmdCUnZlcDhuMjgr?=
 =?utf-8?B?MlNkWDlCN1ZybC9ZV3haTWt1NXBTdEZiT0Z6M2k0cWZRNCtqbDJOZGlvc0dP?=
 =?utf-8?Q?gtUoIpFGvn+sA9xgsOYHXV4y+ZOLVVUl8UeHdwYnPGXY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66d199-1bdb-4523-0a3e-08db312df45c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:49:24.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnOoE7synuSlqFbR7Roe2avFn+flcRRyCUwX1nYn/8MHSNQ9HV/HCWSBKAcq/1If
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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

Am 30.03.23 um 16:40 schrieb Shashank Sharma:
>
> On 30/03/2023 16:24, Luben Tuikov wrote:
>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch:
>>> - creates a doorbell page for graphics driver usages.
>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>    kernel-doorbell-bo's cpu address.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 
>>> +++++++++++++++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>   3 files changed, 57 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> index 6581b78fe438..10a9bb10e974 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> @@ -49,10 +49,13 @@ struct amdgpu_doorbell {
>>>       /* doorbell mmio */
>>>       resource_size_t        base;
>>>       resource_size_t        size;
>>> -    u32 __iomem        *ptr;
>>> +    u32    __iomem        *ptr;
>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>       u32 num_kernel_doorbells;
>>> +
>>> +    /* For kernel doorbell pages */
>>> +    struct amdgpu_doorbell_obj kernel_doorbells;
>>>   };
>> Here's an example where it could be confusing what the difference is
>> between "struct amdgpu_doorbell" and "struct amdgpu_doobell_obj".
>> As the comment to the struct doorbell_obj declarations says
>> in patch 7,
>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>> +struct amdgpu_doorbell_obj {
>
> What is the confusion ? This is the object which is holding doorbell 
> page. There could be 2 type of
>
> doorbell pages, kernel and process, this is a kernel one.
>
>> Perhaps we should call it "struct amdgpu_doorbell_bo", since
>> it does contain amdgpu_bo's, which are doorbell's bos.
>
> This is not a buffer object (memory), this is doorbell object, so 
> calling it bo would be wrong.

I think what Luben means is that in object orient programming this here 
would be the class. The object is then the actual instantiation of that.

But I have some real doubts that this is the right approach in the first 
place.

Regards,
Christian.

>
> - Shashank
>
>>
>> Regards,
>> Luben
>>
>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>> @@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct 
>>> amdgpu_device *adev,
>>>   int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>                   struct amdgpu_doorbell_obj *db_obj);
>>>   +/**
>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>> doorbells for graphics
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Creates doorbells for graphics driver
>>> + *
>>> + * returns 0 on success, error otherwise.
>>> + */
>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>> *adev);
>>> +
>>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> index 8be15b82b545..b46fe8b1378d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> @@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct 
>>> amdgpu_device *adev,
>>>       return 0;
>>>   }
>>>   +/**
>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>> doorbells for graphics
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * Creates doorbells for graphics driver
>>> + *
>>> + * returns 0 on success, error otherwise.
>>> + */
>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>> *adev)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_doorbell_obj *kernel_doorbells = 
>>> &adev->doorbell.kernel_doorbells;
>>> +
>>> +    kernel_doorbells->doorbell_bitmap = 
>>> bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
>>> +                              GFP_KERNEL);
>>> +    if (!kernel_doorbells->doorbell_bitmap) {
>>> +        DRM_ERROR("Failed to create kernel doorbell bitmap\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * 
>>> sizeof(u32);
>>> +    r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
>>> +    if (r) {
>>> +        bitmap_free(kernel_doorbells->doorbell_bitmap);
>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
>>> +        return r;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * GPU doorbell aperture helpers function.
>>>    */
>>> @@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct 
>>> amdgpu_device *adev)
>>>           adev->doorbell.base = 0;
>>>           adev->doorbell.size = 0;
>>>           adev->doorbell.num_kernel_doorbells = 0;
>>> -        adev->doorbell.ptr = NULL;
>>>           return 0;
>>>       }
>>>   @@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>> -                     adev->doorbell.num_kernel_doorbells *
>>> -                     sizeof(u32));
>>> -    if (adev->doorbell.ptr == NULL)
>>> -        return -ENOMEM;
>>> -
>>> +    adev->doorbell.ptr = ioremap(adev->doorbell.base, 
>>> adev->doorbell.size);
>>>       return 0;
>>>   }
>>>   @@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct 
>>> amdgpu_device *adev)
>>>    */
>>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>>   {
>>> -    iounmap(adev->doorbell.ptr);
>>> -    adev->doorbell.ptr = NULL;
>>> + bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
>>> +    amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 203d77a20507..75c6852845c4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>           return r;
>>>       }
>>>   +    /* Create a boorbell page for kernel usages */
>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to initialize kernel doorbells. \n");
>>> +        return r;
>>> +    }
>>> +
>>>       /* Initialize preemptible memory pool */
>>>       r = amdgpu_preempt_mgr_init(adev);
>>>       if (r) {

