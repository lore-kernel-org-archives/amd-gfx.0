Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04CAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 10:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBB410E4E2;
	Tue,  8 Mar 2022 10:32:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9931610E4E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 10:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A18makkyai20W6fFTobX6Wea0RnzlD21/mARg2q1yJ4TrcYAzqfGxYwTmuY+9QUFoTEMnktRyOZp/qAZrOQu3e8l0ynhdPLbwVigES2/F9tttcB8xafKCVcIey1l/L/SB/nCVWwAPg7RjIVQ3uYlBS3ypBbj8BxEXdAx9ETNnr//MgYXQ9LU/oVgEZ/DbD9AugTJRxoFbgaWYnUlppF0Em0UjS2b7ebnfVsjBzerPia/7XmPlsi3U5LbwLCuqqBfAkVJYdlQ9vieGO/ydG3+bSBKDWIk2vINQhIO/5QLT8yJvAxcXnrokplMnQfrp546PK1AT+6w4WS6tKMxfpApXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2fMJf7xb5NJtyWggIPQ8/P0pf7x7rYOJXrfY+JWfxM=;
 b=bsnNoo9TY7I8vhjotZElIJG7xZ6vNZ36tmmY7icDAEdIIDONwVDJMj1V/Mx0ZNsbaijkJIi/Ay2AMuFgbmS73iTo9Tk/Hqz+y/ebcT80v25Tm6S6b5tmDRn5kX1B8zJwtg271ocqoehDrPMRFVyfM1+/iq8+tKEO+diCYTeIITHrLuCH4Navf1/qyHjTbDbwXjkUVIMQ0t8Dj3vpe0YQ5dvJBzhVSQtAoYXD+Kty5F4C3b13YH4I8gsJhqTFFD5g8E96Q8RxjipD3ps2MRwsKCYnYU/lzsGA8JIjcL3B5fchiZMBCBtbg6xhIbfWBLQr2hjz74/hgX4inYe1kyqfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2fMJf7xb5NJtyWggIPQ8/P0pf7x7rYOJXrfY+JWfxM=;
 b=Gc11hlGtbE61GWs/xP6Iyd9bizNI9B+O5soKXMKWja6kWmZlbolHZo+bNDzKel6Pd0dqmRpTKH8YwsD98bEmUwwggZenawlYSxM5QYulQT9yOuM5KQMpH1cI6Re80QHAkhaV+jh8dyyaSLixcPjFaFEGAtsCS2AlqSQDiaI5+Z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BYAPR12MB4725.namprd12.prod.outlook.com (2603:10b6:a03:a2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 10:32:08 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 10:32:08 +0000
Message-ID: <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
Date: Tue, 8 Mar 2022 11:32:01 +0100
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0187.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::12) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab020482-4d7d-4ecc-94f9-08da00eee5ad
X-MS-TrafficTypeDiagnostic: BYAPR12MB4725:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4725AB0F7520F832E60548C883099@BYAPR12MB4725.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 543x8xzYKixRAjzlKTWClP6P84DVKrh4A0YuWFtF7qcxEM6mCabbo4q3n5fuyfA6Jsd4ELSIF5RvGx5eIRAJPLyAP9qLH8fU95pr5yWsgcg0zMN8y/zpsfYhTzAWn49fLybrTGTKKfIPya3UiSJmS6K6z8eR1ZusgZiBUWNWRkb9cUTWIuPNB2QJizNPD5SFfL/CgQUjzUlOKPu7eW9O2fSBLpNvIktMPngFll8viVJ1BoYfbL4zQhaT89N8/ZFnRYZW/RjuwQfq26PeJ1rLU5QUDHxtvneEn5y0afE8b3w7QoGKJL4dAEg2CGtFHHSfBwSGDVWjJK+lNoekEll10819ncMXHR1vjV408jZ9vxPk+dmcaBrG+dPnEheFUEcqKHzKUGdKLxEdrpReaH0JGLtuaOwKjJws3CA1vUMdnyCCpONfH8U0Afy/G6BQSw+nVJ0v5vKwvFYQSTpraFejzYvnIIcRioSqu4qzc6RSdeEM+FcaOV2uvTq3GLjAKCDsXKyXJuFQ0Fnt37XJG1BC3NAGShpBHGE4R2m1N7/wLYYR1Ah1KWIFXv/hvOZChLfHaE8V8+t6nZi9XWsRuR6hZS7XGss7NpN/YzDjVZ19/gwR5AyKd4xhIdeirQPbXwx/IoEPhORTPlEKF024Buf7g35GSiiX0emXKOTCqCt+pbANWgMuIs2fNeVpl0EXPYqAjldxtGjn/LQc8HtkvoFTzRKvmE2539FQ5sATTjrYXAOQX+F7FJvq/5KJ885VUZgS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(316002)(31686004)(110136005)(36756003)(4326008)(86362001)(31696002)(8676002)(6506007)(2616005)(5660300002)(6666004)(66946007)(53546011)(26005)(38100700002)(6512007)(6486002)(508600001)(8936002)(66476007)(66556008)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RSs2aklLY1M5cnlUdDBzUVNUdDdWblBFb094Q2lzcDVJeno1bmxXMXRhYVpq?=
 =?utf-8?B?eHlXWjl0TkxKL2FOM0l1QUExRVdCMVVIUGs3dlF0L0N4NE1TTllZZTljbk1k?=
 =?utf-8?B?N1F5bnBVVWFpbmpPMVA5djloUDFWRitZYzVERWExeEhDeXdORk9yYk5KbWkr?=
 =?utf-8?B?VUd3UDFIZGlpNjNhWVh0UER6emRmbTZJMVoybEgrRTh2SDYxYkJkNGdYTVNK?=
 =?utf-8?B?UUNNb2oxK3Q3MlFBTGpzQU1jUmQ4dlNBT3BoZVJtNXJYNEJyd0twYlhRTUhz?=
 =?utf-8?B?RVBXZlhDRTZpbHlYaEJKcjl5d080QUVpUExIMDRlNmV4QWtZTWxGM2RlTngw?=
 =?utf-8?B?RzJzLzBYRitmdzBVditrYUtrVUdxdkRjRS9aZGE2REhlaVlIVjZlMXNFcWZh?=
 =?utf-8?B?TU5ueWhlWmE3ZG5BR1VCWi9lS2ExTmdYdHdQMnlEZGVMcE10YTJQM0JuOGND?=
 =?utf-8?B?RkN6N3NTL0ZubjBpUjRhVXE0N2xhYVo5Wnp5SXBkLzhSVDhteWsvTmFFUDc1?=
 =?utf-8?B?K2xFWlVUZUpPTlZhN0RZVngvZmpWQW00WDErVDJBWXI5enBXa0hZOTIzcTFF?=
 =?utf-8?B?ZXpqc3JYWmlrTkhkVmc2MWUvamN5eERZa20vbTJvaXptcnZmWTcwcnM3Z05p?=
 =?utf-8?B?Q25NalQwWnpiQzVnaTI0c2ErdkRHWkpzdWlZRU9BMWh6aTdnK3BmaFpOdHo1?=
 =?utf-8?B?WmsrUXZmYitJSlRrSlVReXJjNzZhSFNOQXNUTzF5dU5MWTJMWUdmQ2tPTHI4?=
 =?utf-8?B?UnlXaldnNzAxenc5RGcvRjRiQXZ3N1d5VzhVNnlNVVBEYjNXaUdHRmsxQkxP?=
 =?utf-8?B?dk8rbzJBVkJKSnVGSVNXWHJGcWJSQ1lkSHpLanhDdXhVV093c1JPWFZJOVdl?=
 =?utf-8?B?VEtucjZaTm1YRjBzUWo0SkFqWUJwVXpSd3ByVEtSYVJraUN4YVpvRmh4RTlw?=
 =?utf-8?B?SFN0VnVNL3ZOc2xDbXV2TWdQN3pkcVNUaGN6WEcxU0hMVmNkbW5kVFlUc01q?=
 =?utf-8?B?RXlRSjhtL3ZUQ3hBcEZyZWMxL01xQTZzUS94SFBnZSs0TGp6V1BjR2lkSUdY?=
 =?utf-8?B?cGF3VXFtdUR0ZkRMWjEvYVoxRnBaNDhIZmJLeStoVlFVWkVNd3h0OHdBM2p1?=
 =?utf-8?B?b3BhcFMxQnRYdE5tcHV3TXN3dGJBMFk4SGFoRXZhdlFKVmV6TGFOZis0Ujdo?=
 =?utf-8?B?UEZSYytEU09hcnk0ZlI3UUJFMDAwMVBlVW1ZQUYxZC9uRjJ6SkQxcG5HODBO?=
 =?utf-8?B?cldmUnZBM1M1WlBYTGk0MzVLQkx1SGw0aW8xaG83aDI1YnRzUkh4R2RYd0lC?=
 =?utf-8?B?LzZMTDRQSGdpeVgrTmxUcnA1K245em43UFVoUFBKTm9mZmpqTG4zT3pyVnpp?=
 =?utf-8?B?RGVHNWwrdERpVGcwN1FhQUQrVDhUdnJRcEsrVmRZZGVINXJ5UXY0Y0k1UGpq?=
 =?utf-8?B?YzFIMmhlUW04QzVBaDlNTG96Y3NFdDlicmxuVXdvSkp1QWVkQmlqMlM5bjB4?=
 =?utf-8?B?NjdYZ3pJUmhQTUZUaXUrVlU2eVkzQzl2dTdzcTlNb09rTWhuNW94OFJsL3ZP?=
 =?utf-8?B?S3BZU3VseENGN2xBZ0dDaFJGSXVnZGd5Sm5raWwra0EwazI4TmNET0FsMmM1?=
 =?utf-8?B?NW9JeGYvOFJ3ekJPaW8wNStjSWVUTC82SWxiNzkrdk1QMDlpTGZEWXRnZXJj?=
 =?utf-8?B?eXpwTS9GVGFFeFhUUFlJZ0ovdVFaWFJ1c2dGUDEvajY0QkxtMkE0azZhbXpl?=
 =?utf-8?B?ZGtnak9BR2lQTnhaS08yM3llZk1CNFVpbDgrbytMZ2tUczAwaUZncEI1NjY3?=
 =?utf-8?B?TGxFMStDdzNsMnlscWYwZEdLY2Q5OVlWOUxHekxpemJ1dHl1ak1sT2t6eFBm?=
 =?utf-8?B?czZ2dVV1T0JWTEFZajhJNVM4dlMvd3hXTzZ6NStyclBXcjFRaFk3S3J6Rmt4?=
 =?utf-8?B?TFQ5MG5QM3FhSlBHQUwxMUw3NlFqbEdEcnYvb2lOSUFrLzNYTkRxNHBZS2Qv?=
 =?utf-8?B?bi9ObkRidUdxYjVLZS9oM0ZTUUptVVQwZlVQWDViUTBocTBmVnJISjZpMmVy?=
 =?utf-8?B?UXRwRVdyMkp1Ukdrb3BSa1c1ck1wNzNxUUNSU1BDR3l4Q0dUVVNXeE40d1BI?=
 =?utf-8?Q?9o2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab020482-4d7d-4ecc-94f9-08da00eee5ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 10:32:08.3639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRMMYjObe/VePbyg0j/RuogqXjSEj8dgnpqRDgNc1Qfn5K8prWhaJrdGejRLcFzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4725
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

Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>
>
> On 3/8/2022 8:06 AM, Christian König wrote:
>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
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
>> Make sure to CC the dri-devel mailing list when reviewing this.
> Got it,
>
> I was also curious if we want to move the reset_ctx structure itself 
> to DRM layer, like
> drm_reset_event_ctx {
>     u32 pid;
>     u32 flags;
>     char process_name[64];
> };

I was entertaining that thought as well.

But if we do this I would go even a step further and also move the reset 
work item into the DRM layer as well.

You might also look like into migrating the exiting i915 code which uses 
udev to signal GPU resets to this function as well.

Regards,
Christian.

>
> and then:
> void drm_sysfs_reset_event(struct drm_device *dev, drm_reset_event_ctx 
> *ctx);
>
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
>>
>> The PID is usually only 32bit, but even better would be to use pid_t.
>>
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
>>
>> Probably better to define that the other way around, e.g. 
>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>
>> Apart from that looks good to me.
>>
> Got it, noted.
> - Shashank
>
>> Christian.
>>
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
>>

