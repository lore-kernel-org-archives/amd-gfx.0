Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92707C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 15:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF4810E283;
	Tue,  8 Mar 2022 15:37:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB5E10E283
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 15:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO7hbyCklru2+70pZmec2INO325rbbDunsvlZaUewEo5MqLWVyxoe6GuSO5x8PSbMuNGg/VP4gTI9Pf3h/NnXHN4fWlkm8EBFYviaEzPJRrr6RWL+Ieay3N48k4PduUS72896PUdLWEpaBckCpWIHRex0xiOrzLgZ7kku8wb9dWRqT4Os8aXDXrp6gveSLMIM6ovPNmg4St3AzA2mlENe7Du4i4E3Dh1ioVAx89fErWZZ9vXT9ZcXsq0p50qp4qy5VSspsBTCBIuVtqA3nZ0PXCTsZOzNZ+QEHVJbdevEN9Z3eyED9eqpemzEs/+1hKIYGxpEndq/4VVg1Zz/iQodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DAiW0pryTg5Mx3//Yzo6btpkBYUCwcg1LOG+gq8ito=;
 b=B8kD8yBMJk9BsJ1Tw4ZjDhSihvuGs5fp1vIm8auZNF/gPMvlGKPPg8zRbQJj3L495SzqL3mW8vfWZQ7Sz+IA6qstUVPlmP81qE5ibpL0TwLJTy8YQcTR84NIxhYbGfGtR78pQcGsbN3sAqeBeqS+qEwrhoY1SAfBgdySGKlOooMvwVhNoLaKpv+OC6AG58jV26WeseVHD6a1y+JFp5SW05qr5lZbu4h9qZS06k5Rtvu8wfUQorHcvOuzmiTYjZQdvzocHwJkMOtzoOit4tv1ZlsU7HYMJU8k7pjObsC8yaMqBguq2T/8Odl/PXlfUT79AE6UyPMkKhIzRRBvPIzcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DAiW0pryTg5Mx3//Yzo6btpkBYUCwcg1LOG+gq8ito=;
 b=23kEkrmV5XWakkS1IiuwLV1sdi/3ghEEFlxmleWu3GiXKD0vL0xkyjTC5WMEAqylYpB+0M4seiKp0kuqS+SH8DLsYqOliGthGBO+Tn88RaE+HeALDvx4Pyf1VdnzM0JjcYigAbyDj1cECbAwscGjB/b5zlgc3wmfOcpwvAbOM8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 15:37:51 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 15:37:50 +0000
Message-ID: <05e0a27c-999c-cdbd-631a-93a78e76bdc2@amd.com>
Date: Tue, 8 Mar 2022 21:07:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
 <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
 <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
 <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::14) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde9763d-8448-4f54-a788-08da01199a1a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4930242843209052598344ADF8099@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cC6kRCtAc1G6+rvbd/RHulF9RB4qltxfd8HZZ4FZ0OEYvTbTct5jK7kXNpdH0GLhqJLpnCgVRi5CSpWjUFuIwUtDHiHzTgsaCxWFtAURRYjq0qxaIUu/SwC2fEBzODr4AXhQ4ufad1HUBgcxE1rwZjNZmBk/3cPGi7M0uxc4wIPaO5pI+WJf5bORtWmU00cmNHzv9g4uJMGny7pVPiXOQaEUmCv19vnfHQJMKNCHLYzmCS4QsXZD4Nwjp8zj8F4B93b7kRPFZiADwBpGk6fIbBITqU/mh7sefatYD5v5t7OqUBiQ6BqblE6l+4w6QbwNNFRLASxrx22bxviudaKbZD/rAB39+9zOQBUEMq87lJlFs/HT0kcyazuexWr89g3GJUhbXcM2RaIJKwZSQbwcPWMNed14tMah+hJfzMrI/pmIMmiiBWR4zRyx7lYTWqcYMQFoT8q2PR7fjXpHUZ7B8YfVzL7FTLhtzOM1Xj4Q7PS/rTv5RkIWWY5pHwUoxdKwMf7uMy75bYNER6Gt5b0Z7FOYpxsulK+5zp3hpImUCmacnIpLUPhe9aB8dBQ2BE8KRkeqhewIhihN/g/YCfYDVkB0hhU1K4bIFrA0I5Pog/RzeDnhcuDFPyiYiWxjuqmrqCuMK2hNhAzm03g80ARL64VbqavYTRTfYYhMRuC2/apksdKDlmT72ny3240vGy814YurJh2BVnmb2wAODf/dOoJ8BR9yb5j9g+xIsE08f+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(508600001)(6486002)(2616005)(66574015)(26005)(31686004)(186003)(4326008)(66476007)(8676002)(66556008)(66946007)(53546011)(83380400001)(31696002)(8936002)(110136005)(6506007)(316002)(6666004)(6512007)(36756003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhXZ2JvK0NWRFp1dis2OERBUS9CQnNlU1M2RXl0VHIxYzdrTzlvSFZZWHhq?=
 =?utf-8?B?NGNqbHVHbUtBNWxUR2Q2WGFhbjBXanRrQXhXWktNd0dUa2RzcCs3cDdIanVO?=
 =?utf-8?B?eStkWGhWZHZDL1h4eVRuMS9mcHZycFpGZXhvWDB3MFZwNG5wMW9sbmVUdXZr?=
 =?utf-8?B?MzZwVWUrNHYyakc5a3d0dE93Qk9VS1ovNWZRS0VnSU5PNkJqaE50cFFkY2tp?=
 =?utf-8?B?Y2NRb1ZtOVp3L3B0SUV0RDAveEFyUXBOOU0xeFQ5YUk3VnpsNVExNDZzaVla?=
 =?utf-8?B?R0UwTjl6dXNaYytkdXRhK2NpV1Yrc1gvSTI0RjU4eGxsSjJRc0pPdTRGSCtk?=
 =?utf-8?B?dy9YWWpMVjNkRTFuYzV1S1BmRjBQdWpNRFV4SDY4OTFrTkkxajFhdmpHNG1n?=
 =?utf-8?B?eVQ5ckM2Z1ZCaXJWWm4yak9TK3cxWWw3K3VKRHU2bWQ1dUZhNXRIcnJhRHQv?=
 =?utf-8?B?a0JrMCsrTWEzbnNRaDc4T3FTK0YyUEtvVUEwR244OVQwUkJsVXJORGZkaXhr?=
 =?utf-8?B?MGZXSEdjbzhyTHhrZmJHL1F3RDFYR3A2WDZzbTdmK0RtOFlOMy8xZ0dXWERr?=
 =?utf-8?B?OWRQTmVQbFM4ZFBxRnJucjB4RmViVzJEejhQemxoYzd2K0NIeUJnY0NRSjJ4?=
 =?utf-8?B?WHh6V3VRdXcyQUNnZk1DaEx0TUdDTDBNcFpvQ3V1bWVJcFhLV0tpTXhyZWVD?=
 =?utf-8?B?UmlQbW96aytpb0s0UFE5Zk9zMldQQXpqY1pnMXdBbmQxdk5sUjU0cFlZZ1NU?=
 =?utf-8?B?U2YyWkJiWC9ESUlhTGtDM0ozcUhWV0xIOG12U3MzRHJWWXdVaTFrcGJrMWJo?=
 =?utf-8?B?RXhsdlV1Vk5PaXM5STBMc014YUlsbDNJS0xsNldBZjdHWkRwWjNENHEvRW1N?=
 =?utf-8?B?S1NCcmhFaGkxTExKU2I0NEdJWExqb0pKekNaeVRwTTRldHRncFhUOHVXWDVk?=
 =?utf-8?B?UllxZ254M0V3UzBTYmpwRUVHbTc4VlExQituSGNpekR4OVZiaGRTMFYwbmVs?=
 =?utf-8?B?VVVyMGowc01LRWo5bUF0RWdUdUZSdTFPRmVsU1Y1amMrVFg4RGUzR3RZTVcx?=
 =?utf-8?B?OWlLcXNvY3d4TmlFNkFWeFA0bkhPL01JRGpnRml6UHlvMGVtK3pQT0xNS2pj?=
 =?utf-8?B?NC80U0hwTndaUnY3T1pobTBmY1RqS0lHTVZnTjZ1bTYxZkZ2Y3kwNEZTYmF4?=
 =?utf-8?B?ZW1Ia1FQcThicWFXcEc4azRnODhiSDR3cHRjOTJxejJSTUI2bVhjMlNkbURq?=
 =?utf-8?B?OE1Ja3Z2YVhPTkJ0RVkzblcrSnpwMWlCZ3RwR1YrM3cxL0o1Mnl4enQ0NVUv?=
 =?utf-8?B?WWpnY1NvWU1wK3dRd3JTTWJZRXEvKytUUTd0eHl1RmRlYUhod3FyVlFyYThj?=
 =?utf-8?B?cmNUUFlJR0hnYnNqSmc2S0FpZjB2VDB2SmNleHBjanlQN2lCU1ZwZXFvYXdV?=
 =?utf-8?B?Skk4enU2eHV3cU5tUWk1b2VXeUsySW9ZOXBVZk9xRWdwQjlvZE5sMzVDSFdp?=
 =?utf-8?B?OHhacHdtcW53UXdRdWNYWktUUml3TEVyQ2dpWVRDTmltb0ZzcWhLVWc1UXBn?=
 =?utf-8?B?UWRsbjhmeW0zMzJwNkw2bWp5bE9kY1hIcHFCK0FBdlN1SWxNYUF5QWRsaUl5?=
 =?utf-8?B?YkdaTExGUmNzL1RkV2JySzZSTGRSQUxxbkNWRFVEZCsyWHo4RnJxa0wvUFEw?=
 =?utf-8?B?b2xxWXkwN2UyN1JoM0Q2RHRZUWtmT2NIb3R6VmlpQ0F3V1N6UHJaSSsvZG0z?=
 =?utf-8?B?NWtxZTFWWHBWSGVwd3BBamUxYkRQNWUxdEFOaUtkdVFPZG1yaFI3c3ZQS3Vl?=
 =?utf-8?B?bWprMWduaHRHeEdmRFh6Q3M1ejJTbzdKdkJpSlBrT1ozZ2loT1YyRWU5S2w4?=
 =?utf-8?B?OE9nZk9kVDVCYmh6LzFjSWdWd1k2aWkzN1FRRytZUFlPUE9VR3BnVFF2SnVU?=
 =?utf-8?B?ZjlSRUdKR0FaK2pqeXZYMjRPN0FWMHdpZ1JveHZ1YlJjK0ZLTWhDYXd0eVJC?=
 =?utf-8?B?SFA3SHJmT0RtT0c0SHBTUUdlSHpwZjlkWlRHY04wSmxuTXNacjNvK3RlWnJE?=
 =?utf-8?B?RlpkcHp1U0lCT3I1cytEUzBaam51Z0ZuMm5sdGl4VjFJRVYyWU9DbnUremtK?=
 =?utf-8?B?UE51VHg1elV5Z3pSeEJXZ1pYeWpvS1lwNUlaSS8xeXdjQTI3bGZXMDczb1NO?=
 =?utf-8?Q?kIokKVGSQhNUuOPNSU566wE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde9763d-8448-4f54-a788-08da01199a1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 15:37:50.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6huDLaX1BCrhdwC8zhwDNgSh6S91Sxd9hi8ECCzDucN2sZB1Vs4UnAWg+Zy/WMfuLMK0Gtecrdhvs+dOiewnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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


On 3/8/2022 5:26 PM, Sharma, Shashank wrote:
>
>
> On 3/8/2022 11:32 AM, Christian König wrote:
>> Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>>>
>>>
>>> On 3/8/2022 8:06 AM, Christian König wrote:
>>>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>
>>>>> This patch adds a new sysfs event, which will indicate
>>>>> the userland about a GPU reset, and can also provide
>>>>> some information like:
>>>>> - which PID was involved in the GPU reset
>>>>> - what was the GPU status (using flags)
>>>>>
>>>>> This patch also introduces the first flag of the flags
>>>>> bitmap, which can be appended as and when required.
>>>>
>>>> Make sure to CC the dri-devel mailing list when reviewing this.
>>> Got it,
>>>
>>> I was also curious if we want to move the reset_ctx structure itself 
>>> to DRM layer, like
>>> drm_reset_event_ctx {
>>>     u32 pid;
>>>     u32 flags;
>>>     char process_name[64];
>>> };
>>
>> I was entertaining that thought as well.
>>
>> But if we do this I would go even a step further and also move the 
>> reset work item into the DRM layer as well.
>>
>> You might also look like into migrating the exiting i915 code which 
>> uses udev to signal GPU resets to this function as well.
>>
Hi Christian,

Can we access adev in common drm (even if we can access adev it will not 
be common code)

move work function to drm need to be protected(i.e reset_domain->sem), 
adding something like reset_sem to drm_device?

Regards,

S.Amarnath

>> Regards,
>> Christian.
>
> That seems like a good idea, let me quickly dive into i915 and check 
> this out.
>
> Shashank
>>
>>>
>>> and then:
>>> void drm_sysfs_reset_event(struct drm_device *dev, 
>>> drm_reset_event_ctx *ctx);
>>>
>>>>
>>>>>
>>>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>   include/drm/drm_sysfs.h     |  3 +++
>>>>>   2 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>> index 430e00b16eec..52a015161431 100644
>>>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>> drm_device *dev)
>>>>>   }
>>>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>> +/**
>>>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>>> reset
>>>>> + * @dev: DRM device
>>>>> + * @pid: The process ID involve with the reset
>>>>> + * @flags: Any other information about the GPU status
>>>>> + *
>>>>> + * Send a uevent for the DRM device specified by @dev. This 
>>>>> indicates
>>>>> + * user that a GPU reset has occurred, so that the interested client
>>>>> + * can take any recovery or profiling measure, when required.
>>>>> + */
>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t flags)
>>>>
>>>> The PID is usually only 32bit, but even better would be to use pid_t.
>>>>
>>>>> +{
>>>>> +    unsigned char pid_str[21], flags_str[15];
>>>>> +    unsigned char reset_str[] = "RESET=1";
>>>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>> +
>>>>> +    DRM_DEBUG("generating reset event\n");
>>>>> +
>>>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>> +}
>>>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>> +
>>>>>   /**
>>>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>>>> any connector
>>>>>    * change
>>>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>> index 6273cac44e47..63f00fe8054c 100644
>>>>> --- a/include/drm/drm_sysfs.h
>>>>> +++ b/include/drm/drm_sysfs.h
>>>>> @@ -2,6 +2,8 @@
>>>>>   #ifndef _DRM_SYSFS_H_
>>>>>   #define _DRM_SYSFS_H_
>>>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>
>>>> Probably better to define that the other way around, e.g. 
>>>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>>>
>>>> Apart from that looks good to me.
>>>>
>>> Got it, noted.
>>> - Shashank
>>>
>>>> Christian.
>>>>
>>>>> +
>>>>>   struct drm_device;
>>>>>   struct device;
>>>>>   struct drm_connector;
>>>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>>   void drm_class_device_unregister(struct device *dev);
>>>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t reset_flags);
>>>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>> *connector);
>>>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>> *connector,
>>>>>                         struct drm_property *property);
>>>>
>>
