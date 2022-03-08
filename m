Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BBFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE86410E5EC;
	Tue,  8 Mar 2022 16:36:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E3210E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Euqpih/HFAP/SQEllM1HdzDj9e33hP10wZ1GLowKM0wZFhDsVw+7x1Zy6JLwnZh9xp8DBjPxOP7dYAkdXa8CW5DxsYdeb1iBeV7looLmaGcDhc2ZJUvvg2AtN3Rtrvnx2e5ZEAVjPwW+gzEtcyJcRUjHE9Cx820CAg0ZKQJTbGQ5tqMtdhKfdIMhIqwsflHXXIixs2nsUAqQ/jTpaVgCUWPntaikpqiY0jsSvb1XGVUSEQa3D/cuWBrWDYXM0L0DGDpkukx7Pwb4TG8G70zH94yZM16R+6tFcHUJbTp93A713HqS+CZwUOTYJy5D6ZCIp49jY3o8fuaU7miWJDngUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3Cb4u68s2t36+xtmHvqDGiOrRr6F+oSCzbqiMenXss=;
 b=bOKFoARLZv+EbBYvOkHZUzr17sVLqNoVXWaTWZPDxwkHZLBg0tN7PQE8Sf+C6LE+5lGvmKvLEJ6Mi99WYTpTMqSCyWhShlsqpwqRiDPHeAQOS22ejLlBbSNbnwCnYfW7cYwbeJNzQ8Jwdyl1FGhwHSsvStQIo8E3Pg1x7lfF311Xb+CuoiJxTXHLvnEv5CkSZtSGvg5NcEHnlFWwzImzZgK1BZ8xqUnwQewDbpMlB1Bod3t856KdBRXHKLaT0ho4Jme+Pxz+i4a27JRorcHFTCXmOZfJCCRlOrIH5tsqQGPvQ475C9X+T/m+XZS2umkcCDLTFUPAoMsvVd4GZGYShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3Cb4u68s2t36+xtmHvqDGiOrRr6F+oSCzbqiMenXss=;
 b=SrFQhMU/o+eCMOlsvUqNckY669Xdmd7AtV3SptCTNYMP2MhOVvqIxY90Ul6nki7BxNP3VGaXEAajdQTAB675yZFHwBG+VZaD4twzfalOTxbUOlZiJz0mexDJXVjtc9xLgfbvcVIsakWbV1rkCiKhmsCTErRKiZOGxuVDaXQHcKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB2923.namprd12.prod.outlook.com (2603:10b6:5:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.21; Tue, 8 Mar
 2022 16:36:15 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:36:15 +0000
Message-ID: <0aed55a3-4cfb-e4b0-6736-1b9b01c8ede6@amd.com>
Date: Tue, 8 Mar 2022 11:36:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <e8f00c19-532f-66fd-ff08-04f34a9d9bc2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <e8f00c19-532f-66fd-ff08-04f34a9d9bc2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e439d20b-10b8-44f7-463a-08da0121c38e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2923C3A4F3F405B4F7E21F44EA099@DM6PR12MB2923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2dfajTkvDL2y5OWIlVbY1/kotOp0YglE2XV0bsU5mSuw/Rs5UaK66mAUcKBGuSGH/L0hsl6jqcItFpCMs5H1o52bKDxdMzclCt3pd2IEla7oSTHDJZSLA/advReAsxKZsR9ivn5zBxu3NQfsa6wpTzIkaVTDnlIcvi0zfjNNTGo+japdItvJUCgv/U0VGm9qIq+F7HNowOdhAFPprR6xHb/471O5hVRBZ9t3WDD+OkFf6emxzjqhbbNCPm6I8ZvCzXfwG5cRFtKUftkleQwqDh6BW3G1Y5hH3qttg8AZ8BbfIsOFpENHyTT0ZzmjV9DcFIImBKns9j0c/SPdwKGt93YKkMCENbcb0AOzNxZNyfzmN9ZePWufl2pKHkMWzbaF07ALA+08Ek5fbTvMF+zfk3k66TE6qCxLhthTtJP4sxwHJih4Fj5ylmT7pBJASSll7VTsdal4jL/ToX6uJErCtIgLdGOhdJHgWhLxbkYEkLEwnbBw78Py84+LyDf14l9/NOWlpjMItMg732npDmBUUtoofJeLMivzBpY6a6yPBv/CfL3k1/H7IQmrG5qrh2sfrZq7rdFbHd43XUiJ/vP5Y9oZIL+LQ5Ef0CExM5luDADHo4NalrJsjRvUeWLR5MafzEe78AL6W2nmC9XS3Urm6n18tZ+QMR7b5JueU9tiGOvsLlhL1+8DkF0xmMz2fLjUIp/scxat2V6YWyyOPGyAicjiMQyAm09ykBuOTvAXBSdSf9VXCWhIf9HjhhfCJWnNCB5s/qbiHPbj8soPKvt0bby5xrNv7LwRDchePzgBjYXmZojsrA8XDQBnGYy4DWR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(110136005)(66946007)(66556008)(66476007)(8676002)(316002)(38100700002)(31686004)(508600001)(966005)(54906003)(6512007)(2616005)(8936002)(2906002)(6486002)(83380400001)(53546011)(5660300002)(36756003)(86362001)(44832011)(186003)(31696002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlZRXlHU2RwM0pCRW8xZnRYbmozRDExUXBhd1BRa0xncUdKbFE2U2VZSVBL?=
 =?utf-8?B?dDdWRkc0MGdxc0dzcTNYZVpaRW9vVEx1bFFtbkg1WTVTVkdiMXlieE4xYWhO?=
 =?utf-8?B?QUFHQ2ZTVmc2dzhXdCtiamZMUmZSVUpQMkpvb3dXZG9jQ2lTMXB6SFFFeWdJ?=
 =?utf-8?B?UVdkOWdlM1RhbFdKNzVudlZUcXQ5QXFRVzdtbmdzUEJ3dS9GMmN2VnY2bk9Q?=
 =?utf-8?B?SXBvUEt4RVRXSHgvb1IyRHdPWjR1OFkzb3pRM1d0c0FhUElEbUVQSmFrL0NT?=
 =?utf-8?B?Uk9UaisrWGpsQkRsOEZOcyt2Y1NjWGh6KzIxak5Rak0xSlVKZmszYnZVU2xQ?=
 =?utf-8?B?bkRIb2lNbGo1aTJHd2N5Y1VuRXNZVU5nZGVITTU5a2I5dGVXdjlNaFRaUlox?=
 =?utf-8?B?cVE0OFc3TWlpNE96eFdkRUFvc25GeDNCWms4bVNBSVIwUzJmL0VOQ1JkRUd1?=
 =?utf-8?B?U1NFWXBQWThFc1hNNGFUWFFxUzJuYzRLRTlQR05FcHY2QWZYQkg1L1RsZ3li?=
 =?utf-8?B?UkZOWkp3bVB5dnRaQnl5cHNsNmZBdlhxekNjRG9DNXgxc000Nnd4SnBJZ3dN?=
 =?utf-8?B?NFJ1Y1pYeXVzcklDazRFRjJna3YzY1NqZUk4WHNiNDQwQnlvVmUvQWxPa245?=
 =?utf-8?B?Y2l6WnNXd1UxNGd5M3dTclFxS0EydlNkNTc0K2dYL2ducVlqUzduczdKWEIy?=
 =?utf-8?B?ZkNrL3JTbEJSN1BRZTJCWURNWnYzOVpFRnQwc2U0alZOM2ZqMkp0SzFXV0VR?=
 =?utf-8?B?emhlVHUzN1NiMDNpbzlmblNMVkw5OGNaZTArY3F5WlhNSXl0dkNjdHFYSjI5?=
 =?utf-8?B?T2QvMDJGdHhwOTZvTHB5OTZmQms2RkpqWXFqb0M2S0hLaHI5ZUxEU1N2Tm45?=
 =?utf-8?B?eS9FS1BVZmxhMWFFcnRvUUVYaEtwK0NFYzMzNVNFMTZmcXY4d3JLYzJPdkpH?=
 =?utf-8?B?NkRxUEpodVZNeTVzdHUxTk1iNVB2N2JXc2VOTlpFeU50enM2Nk8xYmp0YzM3?=
 =?utf-8?B?Q2R1ekR1RGNmRWNKRS80ZmxFNklqUGtYN09mN21yZDJvK05XbVQ5ZFdSK2hm?=
 =?utf-8?B?SFhMYzVQdkRIMW9jZFZmcGtoMGRSaGZYaFNRR1R5Y01YN2UzbmdQWG84ZHgw?=
 =?utf-8?B?SGdGclA5TVgyaHJFcHNPMFAzcDJYUHlQODZDTy9weG0rWW1NVGNaaUQrVWp4?=
 =?utf-8?B?V3cvQnI5dmdmaGtHUVBFN1NKb0hBenpKUTdlMWwxbGVVcFpQTktSWGIvbk4r?=
 =?utf-8?B?Q1hjaHNGRUVTc3BjWmkrM3IwdS9iRXJqV1ZXdzhnWGQ3NUJrdk11Z05jM3cy?=
 =?utf-8?B?UTEvYktnenQ4bjFXM1VoNGFET2dQMUkwWVpWTWs3RGJkcmJTVzQyYU1qNnZz?=
 =?utf-8?B?WmdKNnR4cE91RWhjdjdORGlvMXZBMnV6Si9kOUdEdjIwQ0U4LzlEOWVkT2FS?=
 =?utf-8?B?WGxlTUJCVThBcW41ZFZNd3N4R3hDUnVzU1dEN05EcFdPcU5sWitJZThmYktK?=
 =?utf-8?B?MVdySVJYMlgxbjZJY21OMzMwSmxMU05OcFk1d1NGSHJneGhrNGdIb3BzWDVL?=
 =?utf-8?B?QlpYcEdDT0pmcU5NRlplNStwR3hxMEN6MkJqd3J0TmN4VnVJdXRiRUlBUEEw?=
 =?utf-8?B?MGVUT0JRdHRySUU4MC84U2FHWDl1UnJBRS9iekNYQmFXTXNhc29XLzJEamNW?=
 =?utf-8?B?Z25meFNWY2JZbUl5TTdKd1BGMDkrSnlxZTVkcXlGUUdzMjUxZFdOZ285YTIv?=
 =?utf-8?B?M2F4NE1ubTN1STU4YjAyMnArUys4OFdQeFdaUHgvVlF4Z3V6Tzg3bTA4WFlH?=
 =?utf-8?B?WXFhbXpZcHdBYXpWMkd1dHRhVkxoT1RrNWY1QzdqSlNmTDdwTDBsSzdVRDNR?=
 =?utf-8?B?T0ViK2FKVzBaU1NvSUQxUU0vTUdtcUJGclRkejBOd0RrbzlGcjBOTVpMNzlD?=
 =?utf-8?B?NjdndHlLQ3YwZm03Rmc1WXhOcFRBQ3lmL2V5dUZUZzJnR1hPcEgzNEpsYVlK?=
 =?utf-8?B?ZnByTVUrUHVNNmZOVFpHeFJCZnRxbUhIU2wvNnhLMXlqeEtPVS9wcWJZTkps?=
 =?utf-8?B?WFNmeEhQWGw5TWtXUkRKK0J6dGRUM2pWclFDV0VCVkVoTDBWd2NldVBNTE5M?=
 =?utf-8?B?M3VzN3VRV2Nlck9VNTB0blF0aUFreUh0aFBuM3ZVdnZEYTh3eVNUWjlQR1ps?=
 =?utf-8?B?NlA1bDFxd1Q5VXJKRkZPWjZtRDZNUmZNUE1XRlVmMitWRDVpME8xNFBra2d4?=
 =?utf-8?Q?iylMONn3UkundNIN+SSGBHaBMnPRAlt5MISF3E2U1c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e439d20b-10b8-44f7-463a-08da0121c38e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:36:15.3869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/eB6UoPy6F2AmN+Tvz8dH6JZmaft3XZWv2h1u9cwMsIQR89mFKdvh5GdsK6qsGEQxNxrHNXc/PUSQrlcQrlxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
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
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-08 11:35, Sharma, Shashank wrote:
>
>
> On 3/8/2022 5:25 PM, Andrey Grodzovsky wrote:
>>
>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>
>>> This patch adds a new sysfs event, which will indicate
>>> the userland about a GPU reset, and can also provide
>>> some information like:
>>> - which PID was involved in the GPU reset
>>> - what was the GPU status (using flags)
>>>
>>> This patch also introduces the first flag of the flags
>>> bitmap, which can be appended as and when required.
>>
>>
>> I am reminding again about another important piece of info which you 
>> can add
>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW 
>> specific but
>> from what I see there is no problem to just amend it as part of 
>> envp[] initialization.
>> bellow.
>>
>> The interface to get the buffer is smu_stb_collect_info and usage can 
>> be seen from
>> frebugfs interface in smu_stb_debugfs_open
>>
>> [1] - https://www.spinics.net/lists/amd-gfx/msg70751.html
>>
>
> Noted Andrey, thank for the reminder. As you can see, this patch is 
> going into DRM layer, so as of now we are accommodating the PID and 
> VRAM validity information, which is common to all the DRM drivers (not 
> only AMDGPU). But as a next step, we will extend this interface to 
> provide driver specific custom data as well,  and that is where we 
> will start digging into STB.
> - Shashank


Got it.

Andrey


>
>> Andrey
>>
>>
>>>
>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>   include/drm/drm_sysfs.h     |  3 +++
>>>   2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>>> index 430e00b16eec..52a015161431 100644
>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device 
>>> *dev)
>>>   }
>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>> +/**
>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
>>> + * @dev: DRM device
>>> + * @pid: The process ID involve with the reset
>>> + * @flags: Any other information about the GPU status
>>> + *
>>> + * Send a uevent for the DRM device specified by @dev. This indicates
>>> + * user that a GPU reset has occurred, so that the interested client
>>> + * can take any recovery or profiling measure, when required.
>>> + */
>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>> uint32_t flags)
>>> +{
>>> +    unsigned char pid_str[21], flags_str[15];
>>> +    unsigned char reset_str[] = "RESET=1";
>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>> +
>>> +    DRM_DEBUG("generating reset event\n");
>>> +
>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>> +}
>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>> +
>>>   /**
>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>> any connector
>>>    * change
>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>> index 6273cac44e47..63f00fe8054c 100644
>>> --- a/include/drm/drm_sysfs.h
>>> +++ b/include/drm/drm_sysfs.h
>>> @@ -2,6 +2,8 @@
>>>   #ifndef _DRM_SYSFS_H_
>>>   #define _DRM_SYSFS_H_
>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>> +
>>>   struct drm_device;
>>>   struct device;
>>>   struct drm_connector;
>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>   void drm_class_device_unregister(struct device *dev);
>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>> uint32_t reset_flags);
>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>> *connector);
>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>> *connector,
>>>                         struct drm_property *property);
