Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E01C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 08:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B7010E911;
	Wed,  9 Mar 2022 08:05:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D603610E907
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 08:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCvsTI3ik8H+dh1Cg/GGAvw4tz2l22Ft+oLiAoPPXf5N63Z0UCG9KBBsknJ9Vp/x/5UPGNF8qYvCBIDYTDC1Nk8yMMwff84MNrMcL5PjlMf9yH5e/28meVYFcfeR373qyJlIMcaux9BFlJ37RkfotWwmxE4a6FGxR1MmFBiBUD3nJQitfolZwzZJEh/U6MEQDAcMYrqCnvF2NLggaPpAmQfUdeiZzLfybCy6l5tqbcTcz3ibIP7kyEB17OzTl23pc4Xfo/PoNR07aK4kmFoFbHXug4/XrA1g0HFCXRFL5PGysN3QR+Y74Zykqr96vEHbWihB+JSVvay+3DXaIRhzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq829Z/+FSowG9JKqqah/kgU5KKIG6/QR7efiyF4xUg=;
 b=KqBwTf2NOuVqAGeOWzSER9U20I9MKrJoj06Z6xlv9NU6Pw8NyaYLCYqgB6LL2GFg45vQjWT8gsfB4+Ke/kL8VlYq5xDfZZTegvvFLLZcgFrK4MSlzOSlgsqW446Yn54CDfKqKI/+gCqXg4QoKKc8gDfV5b2/sHan/UqtGqzmisKJ8ywZF9P1qeKDCwTAPt5u/ViwfZ5jiut0ctOFAfgcokO/2MgbRdgWX0jwwd0EFFR+PPzqeZc8+cWnxV4zO5xfT5vSYYBiLGWRWsy4Q9V3nhVp/mRewOp2hPGuE+IrnN6cgenW75MIriI1ZXXvSIk1ZJx+6kyzkKWVmD6Y8KpH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq829Z/+FSowG9JKqqah/kgU5KKIG6/QR7efiyF4xUg=;
 b=L/OZMLuzHhh68tfVsOdpNRDwKSMDXqMdf6OUzyuRoliACBU90bPZmV+hhIwkaej3x2w2Eo2Th3Gkv/O0KqiZ+yBh9ic+nJfacwxWuan3IAuIF0NSMfU1IPA7JWyrdu7EG9ebMvlNtLb3ha1ICWzmkZRWwxTUv72DQzWnxV/qxvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MWHPR12MB1535.namprd12.prod.outlook.com (2603:10b6:301:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 08:05:27 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:05:27 +0000
Message-ID: <19cf3ef3-6cf2-d0d1-1762-66dfcd254309@amd.com>
Date: Wed, 9 Mar 2022 09:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
 <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
 <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
 <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
 <4e7494e7-ebf4-e830-95a8-cd9a4fceb2b6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4e7494e7-ebf4-e830-95a8-cd9a4fceb2b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:203:69::18) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dff20fe-c272-4d63-e369-08da01a3910f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1535:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15356AF9A9ADC44823C35ED2830A9@MWHPR12MB1535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B92aYenIv690ubKsx+Wi1Jrdit+cHcVligjjT6dBDx/phP/ZyhhYkTEpN6EERUuFhxXfKNBjMDGkbwZQ5+5mvQpc1a1OrlOtQgXvT/8FScuWc0N3nwmlV/HwU4KLiDW/oRCWPp9Nw6toOT4DV7ZS3JjnOBr+Hkm0L+h4LpWhbLnhnZZUYyEsP2RT2Vifs9EBYOLLjKovGHZUhP7hYUuWQy/p4MkxGYOxH52j0Qtv3gwitUVjx7QbGgzhTAkJ82v0Fh2x5PsDnjpkt87CHuIZ1HocuA5axqhfxzVZdQoRZcvEUORiN3wft1fnZzkLE8ah/YfS/2Lgj1vwC+iPYgm0DC7lK+z1LnE8PAaylo+BBpmZ7UA0JTTmGGSf2aWVKEDLUliJdHdfnp7LjrqYLndjWRIwBeLNKbjVLvDffVDnVpek+qAdQOLV2C/qI0ZDbW9TSKKTbWYbfUxwwyWBF+1W2At+CIEGpIVaZuIomeHOkmPJYUg/UYLH7Tld45nPcf4SKYuLdBMEwoxXB1rqEd/y3DIMDRmtwom2V5uVZxtLoabnqL95RstFf0nBwBWbo0MCI18J/vxWCbw/XEnWA2Hq5YxzX97pcfHgmifz1FLJmOZIuN46i9yyloFsSWZqr2IphxMIjQWn9H6ktiABCyw7waAzRVAdZYAkwLYUQkdv5ij+of07QfDPWIEzeQQf2/toR6WQJOHGkGisEKMZiFJNNdhS9mfVMNTvotnkboBfFBKAxKqTZzha9jRYGbaHenJB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(316002)(4326008)(66946007)(110136005)(8676002)(38100700002)(31696002)(86362001)(53546011)(66476007)(8936002)(2906002)(2616005)(5660300002)(66574015)(6512007)(186003)(6486002)(6506007)(6666004)(508600001)(83380400001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFR4M0k0WXVHNyt6aXVTZVg3bkt2VnM0a2NXNXdac2dLcGZLTU9McjUrYXhk?=
 =?utf-8?B?cFRmMEVKcW9pVm40aWdpSWJjYWhBeVJ1TDRPY3NiZW0ydEVOQjVsRHBaaTh5?=
 =?utf-8?B?MVZKbGRER2lzR0ljdDFueEo5RVVwTnhaUmhvbEwxaVhmUGJZLzJHRkdnT2hX?=
 =?utf-8?B?cElyaGNGMTg3ZDZ0QTBZT0dOSUdIZjJaRUppL3RpREZQS0NGK080Z0hsUWYr?=
 =?utf-8?B?anJIS0NyVGp1Rkp1K1M0MEl6WHgrYlMvZU5OWlNSRHBoOVBjYmQ3R2NmSzda?=
 =?utf-8?B?T0JrK2llMkN5SUl3Y3RxT2pFdHBQTEVZbXdibXJDdEZNMzU3dVhHTVM3ZWtm?=
 =?utf-8?B?WDBlNjEyYzM0ZFBBVW8reVdKUzNLcHlDTVFRSWhaNlpacVRDVG5yczN3cnJQ?=
 =?utf-8?B?VEgwVDhrRnFtUmkzK0JxeWlDVUJlYU5EQktYS1JKbFB1YkUyb3dyWi9PN2Vr?=
 =?utf-8?B?Q3hsWWxKd0NKUUNTOGdhZUFDbmtLYmNZK1h2ZktBY2ttVmdRODJCSXhhc3FG?=
 =?utf-8?B?TFNLOWZpYjZsT2ltM01UekFIUEhQblVCbnhrRFRUdnYydGNQdWE1c08zdFJ6?=
 =?utf-8?B?K2N1emFITmFVMXQ0Y3J5K2hNdnhqSVBTeUV4WXpET2lQMXVEZGJUa0pPcGY0?=
 =?utf-8?B?MXg2dUtRRjJSbnc4SFZGMXpaYzN1L3dSKzNmbFFXbmc1UmxXK2hQY205K2pL?=
 =?utf-8?B?Szhpbkd6TXFzZk90ZkpvQVE1UWpKdW1ZZnFTM2FXS3QvaDR6QUxpNUM3UHNR?=
 =?utf-8?B?WGcrVDI3QUtLc1NabGVJajYwVDdUNDk1ckVxbmZ4a09wZE1TZ0JYV0Rxci8y?=
 =?utf-8?B?N05NdjljM2o5c083L1cyMFJrVkgrMmppeU9kalgxU2NadHFaaEdtYXpTaHIz?=
 =?utf-8?B?eVZML0lvbFpWY3lSYkJnd0lYVy9PRURoVDdJc3N6dTFLNDJJSldPYmZLRlZX?=
 =?utf-8?B?am5JRjh4VGlsMVUrL2NtZU0xZURlR256ZkVuNytXVGw2ZlV2MXlET2RhNGs2?=
 =?utf-8?B?VU16TGIzaHloZTZvL0hSbjBWWHFCd1k5NE80VlFlSVpnL0JsOUFyRXhtcVZy?=
 =?utf-8?B?VzFRRGY2TTU2TDBPV2czRndwM1FLV0lKa1BTTjVEUThwUWxIY21RM3Ywb0NX?=
 =?utf-8?B?K1J5MWx6R3lsaUZJTFNYc1hIYm5kMlRGSkRaK0Yxa0lBYUlncGNkUTdtbVFj?=
 =?utf-8?B?MVZucnNHckkxNHlSWkJoVVZKTjdxdTdiMTJhd0s4alJZbndPa3g4UEJGUCtz?=
 =?utf-8?B?anZsK2ZXQ0NHUkxoSER6NTdBb3hsUzZKdjBSTUZESGNVeTlkSnNMQkxVcmJ2?=
 =?utf-8?B?bWtOZnNFT09GT29IRytRSGh6dUxzaWlrTzlQVUQ5T2M1TXhRb0FDeTFvaDlX?=
 =?utf-8?B?QTBPUE5xeTdSaU5wRklxdHR0Q1Q1ajMzNWRTOEV2cUtnTURPb25waWQxWmdH?=
 =?utf-8?B?TkwvRWZRK1A3MnRGT1cxV2NENFRkZGtieExwNDlUamVnRGVEdFRWWElhTVRO?=
 =?utf-8?B?MUg1R3MzT2lFaEtySmNuWS9iQlVVSXlsZUQzb2tFQTBlL3NmVWEzS214RWM5?=
 =?utf-8?B?R0RhcFY2MFBmZUxucTdlOGN5SjlNY3J2aFVDcm0wUFM2azZzcWM3a2JSRll3?=
 =?utf-8?B?RGdIem0xNGxwNWF6YmFJVjZScFlBRVhiL3M1YVcxeDBySTFzazZ3M2QyZzBa?=
 =?utf-8?B?T0FTVUU0ZXVmTmIvWk14WXRIMzBUdExqQlVhajQrVzZ2VVJTYnVHdDRUL09S?=
 =?utf-8?B?VnU1ZHVqU1BnSU5ES3JmVkY0ZkhhWk12M1gzRHYveUhyWElidFVzVDdVUDZY?=
 =?utf-8?B?eVBZa1dDOThOZVkvaHFXMVo1VjFrZEVRS2w4Tlp2OXhjMmF6Y2V4R3pNQVUv?=
 =?utf-8?B?K0hka09GeFZ4R2xueFRSR0tOSkErMXh2Sm11U2VjUGpaS2MzbWRXa2VmSDZI?=
 =?utf-8?B?akQ5Q21jcWIyN29CTkpwYnh3SE51M21GVkkvZjlaeXg5emEwMU1SdFJuZnlP?=
 =?utf-8?B?eW5SOTRuR2VDdkpiYzBCSk8zTGN3cDZ3ZTQ4RFZBdlhpNHhpMmh2L3NxcURl?=
 =?utf-8?B?RnJiNDM4dVZyM1pITlFHeXRIS3JTMmswcTBQRXhaS0d2QTErZVB5ZzZ2dVp1?=
 =?utf-8?B?R1BKRHkvUVhCZHp5MmoxVWdaaUVwaHlUc1ZCUmF1KzlvUk5OaDE2S0NsbFVk?=
 =?utf-8?Q?VZYKJT1DTDNZJ2emLu5xPAs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dff20fe-c272-4d63-e369-08da01a3910f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:05:27.7004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaPj+v6PM/x5M1LFfnkNiqRysUKGwKXlfcVn+HkHzu50CJYWt/vX9yPL8LVFLC5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1535
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.22 um 17:40 schrieb Sharma, Shashank:
>
>
> On 3/8/2022 12:56 PM, Sharma, Shashank wrote:
>>
>>
>> On 3/8/2022 11:32 AM, Christian König wrote:
>>> Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>>>>
>>>>
>>>> On 3/8/2022 8:06 AM, Christian König wrote:
>>>>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>>>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>
>>>>>> This patch adds a new sysfs event, which will indicate
>>>>>> the userland about a GPU reset, and can also provide
>>>>>> some information like:
>>>>>> - which PID was involved in the GPU reset
>>>>>> - what was the GPU status (using flags)
>>>>>>
>>>>>> This patch also introduces the first flag of the flags
>>>>>> bitmap, which can be appended as and when required.
>>>>>
>>>>> Make sure to CC the dri-devel mailing list when reviewing this.
>>>> Got it,
>>>>
>>>> I was also curious if we want to move the reset_ctx structure 
>>>> itself to DRM layer, like
>>>> drm_reset_event_ctx {
>>>>     u32 pid;
>>>>     u32 flags;
>>>>     char process_name[64];
>>>> };
>>>
>>> I was entertaining that thought as well.
>>>
>>> But if we do this I would go even a step further and also move the 
>>> reset work item into the DRM layer as well.
>>>
>>> You might also look like into migrating the exiting i915 code which 
>>> uses udev to signal GPU resets to this function as well.
>>>
>>> Regards,
>>> Christian.
>>
>> That seems like a good idea, let me quickly dive into i915 and check 
>> this out.
>>
>> Shashank
>
> I had a quick look at I915, and it looks like both I915 and AMDGPU 
> drivers have very different methods of passing the data to the work 
> function, via different internal structures. Which means it would be 
> much additional work in both the drivers to move the work function 
> itself in the DRM layer.
>
> To me, now it seems like it would be better if we can just provide 
> this interface to send the uevent and its structure, and the drivers 
> can collect their information and pass it to WQ in their own way.
>
> How do you feel about it ?

That does not sounds like a good approach to me. If we add common drm 
functionality then we need to take the existing drivers into account.

What driver specific information does i915 pass to the work function?

Christian.

>
> - Shashank
>
>>>
>>>>
>>>> and then:
>>>> void drm_sysfs_reset_event(struct drm_device *dev, 
>>>> drm_reset_event_ctx *ctx);
>>>>
>>>>>
>>>>>>
>>>>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>>   include/drm/drm_sysfs.h     |  3 +++
>>>>>>   2 files changed, 27 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>>> index 430e00b16eec..52a015161431 100644
>>>>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>>>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>>> drm_device *dev)
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>>> +/**
>>>>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>>>> reset
>>>>>> + * @dev: DRM device
>>>>>> + * @pid: The process ID involve with the reset
>>>>>> + * @flags: Any other information about the GPU status
>>>>>> + *
>>>>>> + * Send a uevent for the DRM device specified by @dev. This 
>>>>>> indicates
>>>>>> + * user that a GPU reset has occurred, so that the interested 
>>>>>> client
>>>>>> + * can take any recovery or profiling measure, when required.
>>>>>> + */
>>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>>> uint32_t flags)
>>>>>
>>>>> The PID is usually only 32bit, but even better would be to use pid_t.
>>>>>
>>>>>> +{
>>>>>> +    unsigned char pid_str[21], flags_str[15];
>>>>>> +    unsigned char reset_str[] = "RESET=1";
>>>>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>>> +
>>>>>> +    DRM_DEBUG("generating reset event\n");
>>>>>> +
>>>>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>>> +
>>>>>>   /**
>>>>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent 
>>>>>> for any connector
>>>>>>    * change
>>>>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>>> index 6273cac44e47..63f00fe8054c 100644
>>>>>> --- a/include/drm/drm_sysfs.h
>>>>>> +++ b/include/drm/drm_sysfs.h
>>>>>> @@ -2,6 +2,8 @@
>>>>>>   #ifndef _DRM_SYSFS_H_
>>>>>>   #define _DRM_SYSFS_H_
>>>>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>>
>>>>> Probably better to define that the other way around, e.g. 
>>>>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>>>>
>>>>> Apart from that looks good to me.
>>>>>
>>>> Got it, noted.
>>>> - Shashank
>>>>
>>>>> Christian.
>>>>>
>>>>>> +
>>>>>>   struct drm_device;
>>>>>>   struct device;
>>>>>>   struct drm_connector;
>>>>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>>>   void drm_class_device_unregister(struct device *dev);
>>>>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>>> uint32_t reset_flags);
>>>>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>>> *connector);
>>>>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>>> *connector,
>>>>>>                         struct drm_property *property);
>>>>>
>>>

