Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1706DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 09:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C113510E42C;
	Tue,  8 Mar 2022 09:31:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2E010E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 09:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8R+iz+LuMhtyYFQJ0vcaAOQJdh1SRXXd8U7eZFkvq7bEO3vL4N8kIOfiCyByMRkUF5nYslhpuug+p/Aq2BHKpwkRffDx0HVBMzeBG79xArmgWytUbOxb93HAYyKAWWn4iWSQjjC1DFQVNMxP1clfqkf8P2rKQg0/JZz/BO3o0CoLVg7bL9m0drEQmpM7retUY2QU690RXwl4eGszrYtxfRBjyycg3gkZQIjd9lpPEc384gZspbEFi+vjNqo0ABpmE0N1l9r5kviUpdBts8ke6UGik+DV9hL8Pb3OGxvXQE7wiVUfa42FAC+aUbra793T44qPNA0eTBQb3hkqW/dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz9owc3GqcWGGGZaLBdDeH4QyCqsCYCW7DLni3SzRjs=;
 b=fKnOwA9bh/z2MpY63D5+y1uFnXjsWaKbo4P2y5sSI9Uak3w1I6en2hOAFz8hvxwuVnSj5RbshA1nOC8xbHClzTrR8MLyWcLZFo+0bfFLlqSciRcT2dR7BOeTPfV3ZHND+InN0L8qMnH9Lb9ZjZ6+0yeD/N1BJXssTjErCyTNWAajA9b7fYw8n8Eq57eel92tXaze/TM0HCwp+ulhr6Y5OOpoL+poZ2cGoaSiOAG55+GTslKxnHAvZyTsbZOXRwU0je01bQSgfxOoMlr6MLV3t17wDIBJTsup2EJOd5A4vwXqtRs0Or1vBfZFKsVI2rAaW9MpLEIAKeDCUfma3sojIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz9owc3GqcWGGGZaLBdDeH4QyCqsCYCW7DLni3SzRjs=;
 b=OcJb9B/R2pQCxUPAm2s1kSUg05pFQWyzD59jjPBvALVlTcfVbyCIXgvkKMLtjem+lMj8817Y7XQl0c7VbHAhP0cft8bnnGWwbM8IyG5tAnnO/OlsFDjuxvLu4g/sXMmc8++V1eEwiUW7VhrYeD9TckGJ1xwQRWIcIkTS1Zd8+/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:31:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:31:17 +0000
Message-ID: <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
Date: Tue, 8 Mar 2022 10:31:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f07d73a-5334-4f7a-8731-08da00e66536
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32824E3CFACF35F7D96BDDA1F2099@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLteuzD1aM5oT+0GsPodlqTcjiHA1+NliChKBviw7W2P4uLlK4eTQKQ86dWS4Nu5BAZxfgueFls6MJPpZI4uE0VdEDZjn0whZKYqHw3HT47AR3BNSE5nODoEPXqFIcrVyYmArT3qB9kOmoGdN5Z1le+lyghclsmx1kyrWFC4Y3UV2v/FodhecpsU2xt20FxFagKW0w7/TeSLtgKNZyxyFO2J+3D05yI+FUMmq1aV7AqAwBp8PsAUvc8sPyOy7X5YvmjemxqPvtfYGh3SJk+T8hyuSI0q4j/5ywU/wexx9B66Bp0HLhlek0CSNYgHBxS4YZ0kUin9sn3phZOeGhpwnp5+qmH7/mJ4YGa6fX7IOoFQNueoHKpjP9gXup/1H2FErXxVNs1yPoFWvMegQexWQQPqJkmeCTv3LjM1zxrAw0+aU1TyjnSbwEn/WFZ9W15lYMa/dtUZ2cr+1dTi9XjYPvAR6u5AXEVrBm+htYKsovAv4bGxGGNa7QUAW0OR6IeiI1WR49qTongHDyfOks9eOD4x94BAp6QzWpRgPLodnBWelK2znrvvCgn9s5YetSgN57fP+Pnxxa49H19oeFjZTRkn4DLhPSaEl0PmTBeJi14bhJ2r/NCoU0S1P9eTj6yDLphLEt9Cd1MO6WUrCfkdPIrMN7LpT6M0sbhBE35c3+xODkY69cP1smoQUil7kdo6ceA886uKvn/pToXd01KhWS9uqW5vRTKKrBJIuFvgOT90UNWS185vEi1pi2NbnxXa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(4326008)(66556008)(508600001)(66476007)(8676002)(31696002)(5660300002)(8936002)(6506007)(6666004)(36756003)(53546011)(31686004)(26005)(6486002)(86362001)(316002)(2906002)(186003)(38100700002)(6512007)(110136005)(54906003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjQxRVBIL0tITi9oRkFmTTl0dGlPcXJKWVlCdmZ4Rnpzczg4Z000SDR2WWZV?=
 =?utf-8?B?Z1NIc2o2UGl6dlJyUi9SUEpSa2FGdmpSWFBNb3FmRFVTelNQVWIxSUkyS0V4?=
 =?utf-8?B?dFR0R3JnV294TE1Gb2QxSHFWK0Y2alRleTRzcFJaMDgxTWF6QTEvaWNsN1pR?=
 =?utf-8?B?V3E5d1grVmNtZkNQWlpCMkNyQXJ0M0Y5TXJlODg4S1lLRkwxSHJyVzR4OGtN?=
 =?utf-8?B?TnJRSHNxWU0zeWVnMzVyc1dFWTNxdEtTVU9mSUJ4Q1hKMTFHRUV5MUFKeVR1?=
 =?utf-8?B?eTZxaUxVeVZBWVJBTVZzdkhrd0VGSEFXZmRWRWx5U2xZRlB4K3NoQ25tQ3Yr?=
 =?utf-8?B?RzlXb1pkdmRrNXBZOHU2M3l2WTFIS2I2b1lpUFo4NlRyeDl4YitGRlgvWi9j?=
 =?utf-8?B?YUVUQU5KelFtNEtxQkpGbG9EdUM4cnBTYVZjdjRwa3NHa2JjUkhsSlBYWmpJ?=
 =?utf-8?B?UWJUV2RTOGIxWHhDSmNhM2syMldORjkyeTdCd2VPUVI5eXBmRm1WQkRFSlM1?=
 =?utf-8?B?S1Rlc3pvSXp4MkEwRkxtOWRQZHZiRUxUZDBxWWd5Rm8rZkg5RVZmYWFPUkpR?=
 =?utf-8?B?VUhFblZQaldKeklGWjZpM3FDV1E4MjFub3NHN3JIZ3RNMFkyZkNPT1IxTVNS?=
 =?utf-8?B?MGw0ak8vdDBaV3JZM0pxR3lKUU9HN0xBOGxjNTdvc3g4NEU0Q1QrK2t0TVNV?=
 =?utf-8?B?Zk5UVlhaUTR2dEFHK2dROUlEZ3pHU3lqSUlhVUJVWGx5TTVMNVVHVFFzZ3ZS?=
 =?utf-8?B?dXB2YjdHazVjZ3dpamlVc1d1RGhZWm95NVl6ZmFyR3F0VjJzamZhdWdpS21V?=
 =?utf-8?B?MGpoUEltOXg4cU5aTGVvTzNyQWtMNjVmeWZmSHVucmtGUmVGRm5yZVFSZDRq?=
 =?utf-8?B?WHhzU3BvVVA1ek94ZlRiV3RSNVRCQU5UOXZpbWRmdi9xT3UwOW1aQ29FYTcx?=
 =?utf-8?B?bHNYSUxCeHZrbXFFVmVJNStlZkZianhMWG5WVzJSV3hrVW9uMXplMXZ5RWJP?=
 =?utf-8?B?M09VakgzdjNNTWd0WW1taDV2L0VSb0lXblF4c1YzaVRpdFA4K0J3RmVDL1lo?=
 =?utf-8?B?Ny9IME1OeE8zYXBQQXQvYzJYNG96WkZZZTdSUjFSVnVPUVlzc0s2RnY3WGIw?=
 =?utf-8?B?WkpPalB1cFFjVUtSRWhNTFNVR3pKaHp2Z1Qya2ppYjc4ZkVVQVB3UW56ZEF1?=
 =?utf-8?B?YXNreHRmS1BkYndscjZ3MG44TDBkVHY0c3drUmxkYjZMb3NFMDRYQjMxTVVL?=
 =?utf-8?B?SzNibFJOQ3Z3MFNvM0xIR05Sd2tET3ZQNG5VV09STWxUWVN3MlVxSzE5Vm5i?=
 =?utf-8?B?a3lrajlheUJyTmRDQ3lyNm5zUjc5Q20xYlNabHE5Qlp0SHdKRzEzRi9pN3JU?=
 =?utf-8?B?Vnp0NFZzMjJCU2QvbjFJWWpiTTVEK2Z5YmpxOGNkNU8xOVpFSjF6MXRIV0kx?=
 =?utf-8?B?OExlZFZvaGlrRWZiTS9NemFjc0FVRFJqVXFDTDlGYWZpVUZvYTBqTjNNdmxX?=
 =?utf-8?B?U2N5Z0VCM09SV082R3FWODU4Sm9ZTm82MFpDZERtRmp4YkV5azhRdE1PRWpH?=
 =?utf-8?B?amlqMDU5aVNQUHRPelFPcHA2MmdOZlRhTzB0dVFRTEwyd3V2OFczWCtwSFpq?=
 =?utf-8?B?NGpnam9DNnJscmRmVUxPRXd2UkdvRFF3TWJ5UWVJeUVWdmF5TlMxYXRrbjR0?=
 =?utf-8?B?Vm1SUmNWVmVxZndBQWdjcENRTW1MbDNmOTloMnE5VVprbFhCMFZYekc3ZHF2?=
 =?utf-8?B?WEVleFpaNjNLZEZKdkN3N09VcE1pQ1c0ODNzRTVSSHBBZXJSZ2pUSjdOcG01?=
 =?utf-8?B?S2FuOGdrUWJSQkoyU1NXYVB4Tms5aFo2UnRVSmoyY1Z4TTJwWDdNWnV6REE2?=
 =?utf-8?B?YnIwYy9uczNMUWV5TjkzdFh3bmdBYktEaGlPT1FSaEZHZHVaUlNJS0dtWXhP?=
 =?utf-8?B?KzVGdVFuK1dXbDZnU1FRcndDRmt3ZUdVNHh2dXV2Tm5VSk1vUkhZZVdWYURk?=
 =?utf-8?B?bS8wZWFoZVdsODhURW45QVlnbDJQYzN3cWlaMFJBanNEdnFlbGZBTk9VYXNS?=
 =?utf-8?B?NVdtaEZkbkIxT2cxSjZnbXV2NlB0UW11QWd5SGM4QlFqTUpkSWhNODgyc0Nx?=
 =?utf-8?B?QTh1ZWp0OHBlcjJKVElWaTc1RmhGblhWTnovQVk4MEJrYUJDc1BXOGVEd1dZ?=
 =?utf-8?Q?lqtBnZ0+zzwJeTWHWQdxMbU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f07d73a-5334-4f7a-8731-08da00e66536
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:31:17.1439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZo0FKX+xVgfm5wz9rVnJ3CYzwHwye4DgYTG0KZLVf8stH9amF1ZvrtTVxSXG2jFDCyzaR7uIo75706h8NKY3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
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



On 3/8/2022 8:06 AM, Christian König wrote:
> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>> From: Shashank Sharma <shashank.sharma@amd.com>
>>
>> This patch adds a new sysfs event, which will indicate
>> the userland about a GPU reset, and can also provide
>> some information like:
>> - which PID was involved in the GPU reset
>> - what was the GPU status (using flags)
>>
>> This patch also introduces the first flag of the flags
>> bitmap, which can be appended as and when required.
> 
> Make sure to CC the dri-devel mailing list when reviewing this.
Got it,

I was also curious if we want to move the reset_ctx structure itself to 
DRM layer, like
drm_reset_event_ctx {
	u32 pid;
	u32 flags;
	char process_name[64];
};

and then:
void drm_sysfs_reset_event(struct drm_device *dev, drm_reset_event_ctx 
*ctx);

> 
>>
>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>   include/drm/drm_sysfs.h     |  3 +++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>> index 430e00b16eec..52a015161431 100644
>> --- a/drivers/gpu/drm/drm_sysfs.c
>> +++ b/drivers/gpu/drm/drm_sysfs.c
>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>>   }
>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>> +/**
>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
>> + * @dev: DRM device
>> + * @pid: The process ID involve with the reset
>> + * @flags: Any other information about the GPU status
>> + *
>> + * Send a uevent for the DRM device specified by @dev. This indicates
>> + * user that a GPU reset has occurred, so that the interested client
>> + * can take any recovery or profiling measure, when required.
>> + */
>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>> uint32_t flags)
> 
> The PID is usually only 32bit, but even better would be to use pid_t.
> 
>> +{
>> +    unsigned char pid_str[21], flags_str[15];
>> +    unsigned char reset_str[] = "RESET=1";
>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>> +
>> +    DRM_DEBUG("generating reset event\n");
>> +
>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>> +    kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>> +}
>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>> +
>>   /**
>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any 
>> connector
>>    * change
>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>> index 6273cac44e47..63f00fe8054c 100644
>> --- a/include/drm/drm_sysfs.h
>> +++ b/include/drm/drm_sysfs.h
>> @@ -2,6 +2,8 @@
>>   #ifndef _DRM_SYSFS_H_
>>   #define _DRM_SYSFS_H_
>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
> 
> Probably better to define that the other way around, e.g. 
> DRM_GPU_RESET_FLAG_VRAM_LOST.
> 
> Apart from that looks good to me.
> 
Got it, noted.
- Shashank

> Christian.
> 
>> +
>>   struct drm_device;
>>   struct device;
>>   struct drm_connector;
>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>   void drm_class_device_unregister(struct device *dev);
>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>> uint32_t reset_flags);
>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>> *connector);
>>   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>>                         struct drm_property *property);
> 
