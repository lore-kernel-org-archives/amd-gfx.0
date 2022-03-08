Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E2110E59F;
	Tue,  8 Mar 2022 16:35:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE49E10E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5SbcZsQ+6O+oIeSj76rO7+l7nzhzkP47Ij1BlBUoI3ExXU/LrDGqdZfVkhHE+0Y0Z4cmbVNOoz5QA8b3cFLYMA/t1V6hJmDMb30nm9qYxOUt6MRE1cwpj5hoG+j9Vf9c6pzdVBLQlzK4DucvAZVMRV+NkIemGwYt+HWcNztfLk2RYkyU1Lo2+JywjhVqeIy+/uxnY5ewf6iNAg65wIwYPBmavpsDwtJ0Wh9sz5RVYPgEW3sWQ1/bkbG/FN/rWZXfz4W1YUQQLojavXnae7r10QaxU/q9LAc9qasDi/hv15WHuR96pK0rPYMplypTqHc4iITHXp+3aFNZ0SSDUlbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/V8EKfdO4nWHZphdHGZV8+nDNJqw3eMTPaFzs5DDpU=;
 b=jzBPwN9NCaL0DOZokCE2IbNoVqV9O27sEHozlOnb+1uN+VYYRy57iLvuQG2tFYHz3rXp8eMPCR9Mb+fJgKBD+PgeEgtlMavpYm+q70AJlkAbGXeA7kVby+vW7DPBw1CBtnVZ3b3sldUBZSx1NaLA0ikwS/y8f0hjpE7pBvhPOaYem+CTP8OWrQJGUeZe32vqZzPH3DfrFFpJ17MoA0DUGEVcXw8rfpUk1VNJwnDuJ/nIiMENqJkCjQhpQXyMzRwL65EID64iv8y/LUQorC8uyDcPFZ7sSal8p9HsBIp9H/8uOWl9pCJlgMWb6TCCqmQInDrDa0m1hc08ORGHHhoZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/V8EKfdO4nWHZphdHGZV8+nDNJqw3eMTPaFzs5DDpU=;
 b=cDqRYlxr8y3FspHpb4R/KgdEfltZxS5WblvfYQiFCwYmrG2+Qybkflcn97srVv4WwmrkR+ABP5adyPVpiq+vyLUdCwHTEcQPSeVdAKU6QXXKibolKAw9bdQORjtrkDu6j8or+cel1adys6hjbxUUbJGXUwYqArBtRnCNGHZ1yJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4647.namprd12.prod.outlook.com (2603:10b6:610:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 16:35:14 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:35:14 +0000
Message-ID: <e8f00c19-532f-66fd-ff08-04f34a9d9bc2@amd.com>
Date: Tue, 8 Mar 2022 17:35:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3f85d3-cd58-4053-ea47-08da01219f57
X-MS-TrafficTypeDiagnostic: CH2PR12MB4647:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB464755D37B8E3AD3B7B24D1DF2099@CH2PR12MB4647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfI1KV2Ss/6golySx9QCfYVNhkWqgA6vnFPUDkomlBW95PmD/Co5zfFIG2qnl/0BDBGAdN+A/P6EwDWXsYYI/J1Fj8Tdztr+h8IcvG+15tf5sSLlHBa9huoTLlU91ivARhRgIdX4SWQXM9tGGFvlYFuGlmXDLT8VaGi+q9boKx6nOA3S98w08kKCXF1KLisF7zKM2DHtq/MX7WW1sMEkRuNjGu7evHiVLXqTOaJw+69o6UhUWUiX9s3qWpxeXmgDDwmTA9wVJROW1I/dREHU06HsLtPxrjp+R11+Tkf7J4MvT4M9jVaCwaQSkJ4AV5zFf+u1O5hapcFLtr+KB5q3pdtCBkSU9x45pPV2YuHDOQaqLixdFvUs9O/FiHlbU5tOy6GLLxn5aXAyGlzT/QG/aShjAgLoA6WII6ywfMh4DtIZXkwKmOyS6LyIVN4Lbn4STaC3Vh6+YTPx2YAlbD8oFmBqKroCUae5xY5HL8JCSj0aBQRDdxSLumKHTEgz+YBlwCBjSUTBD4E48w2x4jVtMdR7uH2y6Bhuj5R3EMGgpU6qONCufRJwHaWpKAwe7CdrHBy7L0WGAYRZ7Nw/2vQ5Q1Bpqu5tiZQoBWJIw4/7mC50N/2ORsdqleuhjGotTi4zrkji4DP/zU/aF9cA02DfdDqluygAfWq+WBeYgFlbh5kglxAwnlX6p0RO00xL9qFuuokaTN+B9L+04pvlEmLUdAMBzatt9L+H99ls8Y3Jt0lcdBs2ZDo3lfy1Jx8OM0hvxQqlzAM3rN2qFn5uSNSAY3UWi6otz478KRAkDhu3i94Kp2c5/6hlaMxZPPeS/5m832zPO00xXq0JJIg91WUAoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(26005)(186003)(8936002)(6506007)(6512007)(6486002)(53546011)(36756003)(31686004)(6666004)(2616005)(83380400001)(508600001)(966005)(38100700002)(86362001)(31696002)(54906003)(316002)(2906002)(110136005)(66946007)(66476007)(66556008)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtFbGFoeU1QOXpubHJEWG5ydU5xU3MvQ0taZHcwRm9ES1lBaGJpRUtHNTZD?=
 =?utf-8?B?YnpkSDdSUlFnSnlSRXhPdURBRE9pSVlJL25EUitGK3pKV3JlMkI1akxTUnVE?=
 =?utf-8?B?UDhJc0p5ZUErWmh5WGhpRFVKYWRsTmdyRUtnNTlFT0x5Y2hUMVNGY0RtKzdv?=
 =?utf-8?B?Y3Y2S0c1eE1uUzh6cEJVNkRVMUlPQkUrNTZvODhwQWJZSTdjWFlEZ1F5amtq?=
 =?utf-8?B?Z3Rxb1hNVUhRbHh0ak9SWmhlbzdrV0EydllOdndNTmExQlYrNldla3VXWENI?=
 =?utf-8?B?N0VGQlRPd2hGSkF5UWRMZ05aU1hlaGdwUGE5alJSc1ZwUUdJMzJxek1CVGN3?=
 =?utf-8?B?R241Z2tsUUl0TmRWV2xUWXhjcHRha0Nramo0eUtqOVJFRisyS3lMS1RiUUZ4?=
 =?utf-8?B?a09kSXN3R2RQNXp1Mm5GQk00bmc2d0Z6MVNwNUZhdDlUTW1PTWl3RzhHQ0ZY?=
 =?utf-8?B?UGUweDc1VzNoU3dmcXJVMDJjQllWaHcycmN0NVVNQkYzN1MyUEl1Zzc3VjhY?=
 =?utf-8?B?eGF1ZFV4Ui9mN0lSTFVNQkxUUC9MNnh1K3VxRVJVMC9oVnRFUnAvSVZRNkIr?=
 =?utf-8?B?UlVtVEVkdXV2dHNMV3Z3cDF1dnFxSkE2d2R0VUl3VTR4Y0hWMjBodFNPcTNi?=
 =?utf-8?B?WDlrYjM5azRBZkdHSGp4R1N1dDhXOU8wZVlLdUNwbDZESkcybWs1UkZWVzdn?=
 =?utf-8?B?RjA4bzB3dGMvK0tJTExGUFpjZ0xwL25zcmFnVm15dyticXBlUUMyakZPVDRj?=
 =?utf-8?B?VzhQZjhnbWJWQlB1QTlhc3NzNEg1cnNlUDdqY1hZWXJDako2bVltQkRVU01v?=
 =?utf-8?B?ODk4bDl3VXF4QTk1cU5zVjZBclJEL3dOVlgrYUpUbFNWZVlYSVpIR3cvV1RC?=
 =?utf-8?B?MlVEZ2tVdjF4VGFTU1F5UU51TTJ6ODZoOWxiSFI3bG5yMXJoQ2RCczJnTjF5?=
 =?utf-8?B?Q2NGbnNWalZMNXo5bkNDdHJFVTd1czkxYXJkU0cyYnVEaVBoUXdkTXN5WkJC?=
 =?utf-8?B?ZmpkMUZyT0p1S24rSVcrVHVXQjhINUhYd2hTSUlsODYzSG5YRlhHMDUrMVRv?=
 =?utf-8?B?anN2STZzbWN0V1JjR29XOVRGZ0FFenpBTEpjaGdDeXpHMTdMQXNLZGVsaDVu?=
 =?utf-8?B?MnJlMEx5NWIyQ1hTZXoxd0Y3cjJoTWFKYTRJWHFrWEdHQ3VQYWNMbFBNbGFR?=
 =?utf-8?B?UlJEYUEwdWhUcE5yWXNVckc2RWpUQ2JWbHVycXR6REhrb2RvODFncW14aTNN?=
 =?utf-8?B?WjFmRkxHSEdkeldnYjhjbUVHcWZUcGhhcER5VUhLWk1jMjNrV3dCdFhWbFRv?=
 =?utf-8?B?d3o5TjhFQXlNclozL0Y2NU1uNUpReHAwK0ZleEFjaGVudmtETHJ0YTE0YkxJ?=
 =?utf-8?B?L0c2K2VTMXMvNnU4WlE0QUJzODZOcFgremdtcWx0NkFTM2taYThzODdmTm55?=
 =?utf-8?B?WXlnTGNGRENXdWR3bko2cVRQall1SFhwMzJqeHlzODZzL1o4a3dBcVV2SmZV?=
 =?utf-8?B?SzJ6QjZzcjZvd3pyTzRWV3NSd2FVckJXTmxzaStOWmFqWVpKL1B1Szhydi9u?=
 =?utf-8?B?Qk1MOUw0WHd5ek1mdVdGSGplbXVGamYrU0JmZUJqTFl3L2RxWFpIbVlDRE1h?=
 =?utf-8?B?eEF4azBuZmlRS3BrOXh6SWNIMGVnTGozM1lSUWNVZDZlbGtPWkNIcGZHanVQ?=
 =?utf-8?B?SU5Rb3dzcGx0SzBISGZMVjZTK0l0UXlDeVNSMGNWekozVDZhbTd5c2hQOUw3?=
 =?utf-8?B?UGFtejhpT0xKckJPY096QUcrb0crWEpZV3JJQkFCUTk0blFRbElDL0pITVAw?=
 =?utf-8?B?NHI4L2w2YlQ0RTJZQ3BUWHdwdHVvNHhxaWQxTmZhRVhoRU5TNmJTdnFFVWcw?=
 =?utf-8?B?NnAvZ244NThQcTFyMVdmYlFBejNSZmtuY29IZzNiZThuRzdpVW9HMWVvNCtB?=
 =?utf-8?B?cWgydW5uaXNHdFVwZ0lGVnV5ZEZuVjRjSEcwRXkyTU5DMHh0aGhjRmdIMlVr?=
 =?utf-8?B?QWI2UGRHVDlTUm5HYkptUE9aQTR3OS91TitRd29obTIzeUZmUzVpWndxdFdZ?=
 =?utf-8?B?QkNRWGcxSG9qb3kwVGgvK01pWkdYRlI3ODRjWjN5UlF5bmtid0kwdENyRURj?=
 =?utf-8?B?cWxJc0JzUDQ1MGFFMUFSaVpGeXpSR0tXSjlONGJlemE0VThJZkc2Zm13eFcz?=
 =?utf-8?Q?0c+BWHusn+3C9tMa6ycCPO4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3f85d3-cd58-4053-ea47-08da01219f57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:35:14.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8eswApByr1tb3Ai2ldNqJB6XoEXTo5bA9H9L31jzn1LhCPqEGnFLnVgqlP5dyz6exd2pfv06oR0XGcSgfLMjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4647
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



On 3/8/2022 5:25 PM, Andrey Grodzovsky wrote:
> 
> On 2022-03-07 11:26, Shashank Sharma wrote:
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
> 
> I am reminding again about another important piece of info which you can 
> add
> here and that is Smart Trace Buffer dump [1]. The buffer size is HW 
> specific but
> from what I see there is no problem to just amend it as part of envp[] 
> initialization.
> bellow.
> 
> The interface to get the buffer is smu_stb_collect_info and usage can be 
> seen from
> frebugfs interface in smu_stb_debugfs_open
> 
> [1] - https://www.spinics.net/lists/amd-gfx/msg70751.html
>

Noted Andrey, thank for the reminder. As you can see, this patch is 
going into DRM layer, so as of now we are accommodating the PID and VRAM 
validity information, which is common to all the DRM drivers (not only 
AMDGPU). But as a next step, we will extend this interface to provide 
driver specific custom data as well,  and that is where we will start 
digging into STB.
- Shashank

> Andrey
> 
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
