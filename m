Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74578C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 11:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B3710E67D;
	Tue,  8 Mar 2022 11:56:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7880610E67D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 11:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bysbbhwdD9zt22ZqdoeCQ2I+eKpmw5IOrhNTEs4iDmWqHCpmZhxVL6PNtkiDdH0KKL5BI52Wg4EpZA0eXZdjCTFEDA8hCIcIQ5Y0rmPfgToRc5B+oQU83mxlXVmoz4mOL16gmvjA++P5X7dP8FFL+Ab/69cyMQw6enxWH5yDhdNVH3DLD5dRfnP/NNlFyhdtUnGjQlYnUa3QWV0DBeqK2E/exj2UzhFPZknp5iPI+naiHtVVi8rFeQ6dYOT9qMBH7WkjRGMhhOSRubpgEJbGPwjnCavpSZmMHa9G0agLLp8Mqq8Vckq+zHt4DO2Ha6fFMke3+xuUnVLvd1W1qOt7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtfAiv4lLMVJFBxreb6DltBMVbB6vhOhQiIoca4DrYE=;
 b=gRcEjb1L1C9arj2+3GzB5T2aMPKxYHtGd8OgFhPjddWqdKxxQAyBETIJAJesKGc5QxMRY0OhQOhrkOWsBD40jmaR0LD3+l0R5AITmyG6H+srPiBbkxK8Zmr/puC29MbqlzpYxHlR8LFbxDHaRMuqtQcEm/inM4N1i2gxVSjOzE4anxcMFwQgHc0ey2MxNUHVTHM905kvGZxW69nuaCG0BTyLbrdieM/6Cu3akDeYRE6U9+baqd1Xo9QCbdyYeMl671MJ/jc/cGKBDMYd7zg2Rl/zTwe37uX2pKZpSdwuMd61inWPfdHd7+PEZQsO0MDwl6LwdIGd+Ol+XUuGxrFDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtfAiv4lLMVJFBxreb6DltBMVbB6vhOhQiIoca4DrYE=;
 b=wyLyJ+JPomVKbT5XQBRBNbW/D4jqskzNVWGVRKBn5LKNqizR4lVPabpVMtnoeVg1OZo8N2oBB0KyUONz1CI+lgyqozMJw5x+3ZzrvzVzainHd7Kex8hjXrt2CZLDf3DnGwqnCgceZ5R2umHCwv807PPE7tZZbnb54nIfIOZI2Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN6PR12MB1571.namprd12.prod.outlook.com (2603:10b6:405:4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 11:56:49 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 11:56:49 +0000
Message-ID: <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
Date: Tue, 8 Mar 2022 12:56:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
 <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
 <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0327.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0660035b-696d-43e1-d018-08da00fab9f0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1571:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1571F3647345779A3B909ECAF2099@BN6PR12MB1571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3m/p/HVKYVOs2m2YTi3B9Vs0jp0G7jY4UkMS4JFAywid7MnV2iPOUK3zV/D/rjzkR2QjJGQoloepOjBmFGw5iwQbFQAyfSXLlxw0F7VBxwmG0lOVheXsI8LWI5ZqtnmYCKZBJQm0nrBMMsiIbDa+dtMjCW2zUzF+tAGPULsVkfMDqDJFz35yjt8l1/7/9Pof1PtkJlNgfbIwJeXL/1P16vpombP9QzHhkjAXlJA9AaUOgxkbWI30qxqR3UcSEpcNij9XF86f9O43qoAJ1YqXq7aan3A7EfauY1aN7eEhRG7xi3GKpNpr0uLxStUdXeaaXDqLhD/egGBiL6sRtaiVBk8pqUk4DvHHV1waQuVmDQcwwTIifovXNIeBcCaNQqsP/TF+vbkG6PCnSgC6eMwyh1szIcQSEL/bEnYs+wQSczUuAzxfNp36lSE8eNS3y1rR/Lfntpzi7sdRb2Bh4aCjIobFkPmst92HNnKZVqxwchJgN3QO8GgwIY+fIqDaMUo/QXquHGazZ8imUbaV5eh+yb3EWeI7o7iYoAF8lygUuk9bZphywy15phdtRVdfgOKAY2ws4IwVqyfO4+SknJYfQ44S7HHRWlDYLsx2TDU5Z67gBahKjlKwx676/pGz5ecKDtBB8uYvO8rWu6mlk7FNabvMTjZXGS2KP2WUJwcu1nA27IWi7LTdrZ9YBhAy0KlYX7bq8zN+/45omWoZsLeKVKMe0/Zaw+JkLRZDc3aZ0dLpozeewrKZkvjeeJ3IfL1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(508600001)(6486002)(2616005)(26005)(31686004)(186003)(4326008)(66476007)(8676002)(66556008)(66946007)(53546011)(86362001)(31696002)(8936002)(110136005)(6506007)(316002)(6666004)(36756003)(6512007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE51K0U5S25nOUFvWlJ6YUYwN2I0eCtDcU9rbFdxbFZwRFVDUmhxL2Z3alQ5?=
 =?utf-8?B?RVAxUU9BeGZWY2N1NnZGMzdxa0daVXBGbHFEendqcXdyUVFpYkJyd0JlNHI5?=
 =?utf-8?B?aE9odHR5eDlJZGpuaWNlTzZxZHlkVlUzNEIzWVBiVU5BQmxCMHM1UlNlTUUr?=
 =?utf-8?B?T0p2Q1NTRVM4WER0d09lbzgrSDA2VmQyUEIvSlFRbXd1UFZhS0JLek1vSDZa?=
 =?utf-8?B?U3Z2Wndpa2JmUE85Qm5UMWNlalZLWHdHRGtsQVpqdWppeDU3akFYVEZzVFJs?=
 =?utf-8?B?Rkc5QlBMeWg2MVl6K21MTi9QYTIzaERDMVczVkVyMDRSSi82MjRLOG1IRzl1?=
 =?utf-8?B?VXZPZ1NkUHdXWHVqVHphMHJmTW1LQWswclBOUmFzQXlPYmVhS2NnMFpORGNV?=
 =?utf-8?B?TERTZDAycHpFeGUvdDRZcEVlZWRObHlUMlBvaGRwZlB6WGRwbGttaUhNeVB0?=
 =?utf-8?B?QUdITHByLytaN1h0TmNMVHlmZjBkQytKMlhJaUw5Ym5JRmpaMERLUVFXTy9n?=
 =?utf-8?B?ZGNqMU9lV0V6ZXJoTzc1bGdwWkMzcnR1UTliZkFzZ25tYzhITjZtVGtSRVdK?=
 =?utf-8?B?YlhRcktIZTVDTWRncE4rQVhkSlpqckcyRWV5a1JBTFd2Q04vQVZWa1RqRDVl?=
 =?utf-8?B?dTFkR01XbHZ0aVZNWHFSMTdDTDJUWEVjL3JwSmN3ZGxtMTVkNXJuS1gvR0pX?=
 =?utf-8?B?UzhhWHhQcUxkWStUR3M0NkoxRXIydi9xOXlTNWN2QlNhd3ZqS2NWTmJ0d29S?=
 =?utf-8?B?OXFZK0Y3SDdteGlrc1ZIeW5vcjBPeEJxbTV3OHhEa3pCREozNjBHMEx1Uzdn?=
 =?utf-8?B?WlhRZTRzNzZEYk0rWFBod3o0YXFwcVdMWnc0T1hDQjVQaHFVOHpyNVN2MG9I?=
 =?utf-8?B?enozZURrRFJEUm1uUVRpZEg0K2o5b1hiM2RpRG8zbmdnbm9BRC9HUVlabXRB?=
 =?utf-8?B?dmd5R2lxL3pNdHNvYjJnMHlyTmxsRUQ2SFhtSjkvb200aEJ3VlhKTk9wVjM5?=
 =?utf-8?B?NlU2ckplYXluOGY4TkZydEpDcEJZdUxOVE1DMGtET1QrZjlFa3hLd3RxYnRs?=
 =?utf-8?B?V1BBUUhjWWJkbURhRkQ2NlZLcUlvVmhNR05GaFVxSFRrUUNhSEpEOVVTMWwz?=
 =?utf-8?B?Q1A0WVl6N0FFd3RtVVpMV1JCSy80STBCNktNOEs1U1htYUovd1NqY1V2RXhz?=
 =?utf-8?B?ODJKbHFtQmxXejFPYXcxZHkrbVk1R2hUd0VYWmRzSHZNZ0pWdTlCeHlaTDBT?=
 =?utf-8?B?YnozdU9aRzdmUTY2YkV3TUVHZW9RaXVzcG4zdUgrODVjSEovb09KL2tqUU9I?=
 =?utf-8?B?L3VlMkxPNTFtWmhGVDJRRDFNbkF1VitYczdEMmFVczdUZHBCcDZaNWFqKy9T?=
 =?utf-8?B?bVNGbGJMZDdxZHMyNTJKdHlVLzZFMDQ0NTZxYVdkRzk5Tyt4amcwT1ovbmZM?=
 =?utf-8?B?WkU1OHdhRGdIVnhabXJoWHZCbmUzVjJucStpVEZSLzJ2RGk3MDJLU2NSbFkz?=
 =?utf-8?B?ZGhhRUFRSFBkVjVpZVd4RVh1K1psT3VnWEVhVzhvRkdBR04reUk2dy9aOGZX?=
 =?utf-8?B?QnAzcVZCUGZCZ1JTakUralpodWxtQ1ZKZDFhK2ZUbW5yUllKSEJ4enhHS0Zw?=
 =?utf-8?B?TFV6QlhMbXRtbUx5cDNjSTREZXloMTNIWjNNaDB6NlpCby90S1lodE5ObWtY?=
 =?utf-8?B?azhSK1ltT05meS9lYndYbk5CNm50R0RMUDdDOGI3SE1BZVdIV2UrWDU0RkNC?=
 =?utf-8?B?ZWF5N3A1WDBZM25YcmtzeVZ1Yi9XNTNaZ2pmNTcwenlnK2FoZFpkSG9HNkZt?=
 =?utf-8?B?REZnTVJrekZyanRhaTY4REx3NDB6N2NZY0pXZWpRTGluS3RGbUREdGlnK0s2?=
 =?utf-8?B?cWxMQk44U00wc2gwV2w0c21wK3MxeiswN2dIS3JFd0kxN2VzNkszKzdCWlBp?=
 =?utf-8?B?bi9OYUdvVW5SNXdXRWYxcGNHWEpGRmJTSWl5MjYwVFFIbi9wblFrYUlja1d0?=
 =?utf-8?B?VDJZY2U5TVluNTJ6MjJLRG94NDJ1cDJmeEN0Z0l6b3pFU3A2ZTVSdmJadkhY?=
 =?utf-8?B?UDJPVE92TDU0TXkwZ2pndjJEYlRkU1lzN0swaVRneXNOaVJQaWo5RVBDSXRT?=
 =?utf-8?B?Q0ErVGo1N0cwOFp3R2d1c0hTWGRFSHhMcjFaK1Q2TWgvMUhnTk9GSHp2cS9R?=
 =?utf-8?Q?QkaRaTt5l1NkJZRX+D9ZKV8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0660035b-696d-43e1-d018-08da00fab9f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 11:56:49.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZggBp54P7zcIC/X+TXMMffbatCWgnb3h9tOZ+yCzPJ43caSMLpc3DvUAYysSBdX5NVbfonXpiTq0JrvbMsFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1571
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



On 3/8/2022 11:32 AM, Christian König wrote:
> Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>>
>>
>> On 3/8/2022 8:06 AM, Christian König wrote:
>>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>
>>>> This patch adds a new sysfs event, which will indicate
>>>> the userland about a GPU reset, and can also provide
>>>> some information like:
>>>> - which PID was involved in the GPU reset
>>>> - what was the GPU status (using flags)
>>>>
>>>> This patch also introduces the first flag of the flags
>>>> bitmap, which can be appended as and when required.
>>>
>>> Make sure to CC the dri-devel mailing list when reviewing this.
>> Got it,
>>
>> I was also curious if we want to move the reset_ctx structure itself 
>> to DRM layer, like
>> drm_reset_event_ctx {
>>     u32 pid;
>>     u32 flags;
>>     char process_name[64];
>> };
> 
> I was entertaining that thought as well.
> 
> But if we do this I would go even a step further and also move the reset 
> work item into the DRM layer as well.
> 
> You might also look like into migrating the exiting i915 code which uses 
> udev to signal GPU resets to this function as well.
> 
> Regards,
> Christian.

That seems like a good idea, let me quickly dive into i915 and check 
this out.

Shashank
> 
>>
>> and then:
>> void drm_sysfs_reset_event(struct drm_device *dev, drm_reset_event_ctx 
>> *ctx);
>>
>>>
>>>>
>>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>   include/drm/drm_sysfs.h     |  3 +++
>>>>   2 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>>>> index 430e00b16eec..52a015161431 100644
>>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device 
>>>> *dev)
>>>>   }
>>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>> +/**
>>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
>>>> + * @dev: DRM device
>>>> + * @pid: The process ID involve with the reset
>>>> + * @flags: Any other information about the GPU status
>>>> + *
>>>> + * Send a uevent for the DRM device specified by @dev. This indicates
>>>> + * user that a GPU reset has occurred, so that the interested client
>>>> + * can take any recovery or profiling measure, when required.
>>>> + */
>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>> uint32_t flags)
>>>
>>> The PID is usually only 32bit, but even better would be to use pid_t.
>>>
>>>> +{
>>>> +    unsigned char pid_str[21], flags_str[15];
>>>> +    unsigned char reset_str[] = "RESET=1";
>>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>> +
>>>> +    DRM_DEBUG("generating reset event\n");
>>>> +
>>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>> +
>>>>   /**
>>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>>> any connector
>>>>    * change
>>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>> index 6273cac44e47..63f00fe8054c 100644
>>>> --- a/include/drm/drm_sysfs.h
>>>> +++ b/include/drm/drm_sysfs.h
>>>> @@ -2,6 +2,8 @@
>>>>   #ifndef _DRM_SYSFS_H_
>>>>   #define _DRM_SYSFS_H_
>>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>
>>> Probably better to define that the other way around, e.g. 
>>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>>
>>> Apart from that looks good to me.
>>>
>> Got it, noted.
>> - Shashank
>>
>>> Christian.
>>>
>>>> +
>>>>   struct drm_device;
>>>>   struct device;
>>>>   struct drm_connector;
>>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>   void drm_class_device_unregister(struct device *dev);
>>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>> uint32_t reset_flags);
>>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>> *connector);
>>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>>> *connector,
>>>>                         struct drm_property *property);
>>>
> 
