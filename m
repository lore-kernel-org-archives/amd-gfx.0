Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B17C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DC210E2D7;
	Tue,  8 Mar 2022 16:25:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D4A10E301
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5HeCJkzYeEFG+B4GJGhbGLmsXOxBbVtpOct/XSuNCwaWcibS6E0a6P2KFMl+K5U0st4RvRvgvC6sYuyv9UoayjHbCcO0yQ/KyGF2AA4AwnFXaN3VG2a0q0YQe46RL9rRXZgB7RcoO2s5XLydtBI2jJ47YIBykyjINOsAG1YftCJ2Js634TCm3j03fXp7gVbMpHoHyF7V4OuwPP8k08tC6ky5PEPfvpf7WxH6sdRqSn4AljlBvtWHO+Ei06FdzwjlMS9l5IMLAT/9kJtcWv00c82rIeN3ngy3MsL1POFa6rdrden1zZqac6oOS4ziuq0q0G5s7RRS7gR541DIULPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxoBynFlNX+nFVlBTlfCtmql4OFiRg46GaYYE+CZeJA=;
 b=Vz4r6kDI8EKC8hl4hh4o00s0uTrpD3EERsqFpc79koUnst6Z+JT9cLHMtvtcIBr0g1ftOBp5WyYYVSIqXS/cjpe1bbAppL2yLwskIoyZWhqBxtwpy8jRwGzcxYAKMsXAndLwnE/X+9EJuoAn2yZym9iOMlufUfBK1OaOZJqHpTHWYe1LZMKOc6kVti4XK7FUu5t1W1pMgERZ0x4ui58QExbwYoQ8/VintCjD2H+RQoVEoJ05EBmibJ1U8XUqOglbLyvQWbXSvIO9yUmUvbiXBx0+H5/A+CXnx3ppB8uMpT7Ys7NYQ1qE7u624JdR1R7HgZXOZWfFG1e+slX4H67m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxoBynFlNX+nFVlBTlfCtmql4OFiRg46GaYYE+CZeJA=;
 b=2V6ffiUpG6PTEAItlfqZAamWvZEdiqyul1ZvrRgcQNBGXWoAgKuqOROt8Pq8Be1SlkoJ1W4ZsqbywwO/EtIE3YHY7Z6YsTxPuYFWAik9u+8KAgkbdD9sosfRreGyuDsXizi4ym7cFONGdGJjQgAzI38NdrKW2+ykKYSIUPXH9LY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:25:05 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:25:05 +0000
Message-ID: <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
Date: Tue, 8 Mar 2022 11:25:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126e7db9-8e07-4402-a51e-08da01203402
X-MS-TrafficTypeDiagnostic: MW5PR12MB5652:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB565275AC6D25AFA6C6BE0876EA099@MW5PR12MB5652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl6ltfu4m25b3iGwlc3I0ZfvsWrMiz59nMuxWG5l3TafjFmf3whYv+al+chsP88bKWnmzuUEoGq8gflu78kkVS6CNNoF8MRSJh/qlhChsfJTnC3wXmjxJ9dzaLNempBwK/wcSk1LcHfpxwvv6o4vTV9h5L2g0BLyeRnwg7OIdkN3Npv1KMmO+EySJpLAubhB59WKShIZtD9RS/S0codSjeOTng7tYfjX+87FzcH0kYV6oyDyLVhoOCSVzc2qFDSzKN655JJASi95VcCDcQnkAsLMPMhVBha5+EDSwdUWSA8L+fIWuJ9eQ0KPrDbbSlx4uUbqr58fFB30pNXt2LneukuY1TnEyOYVqcabgH4hnKxMookEkTJy5b4VDawwiseA9mmKa5jfPt7ROBwwypW3I2rRPHRTmyUnpaUtMq7WWf0hYElfWojTss0QgAOBhnT9sm0h5eaTkgMvyw8RSxrevbFzwL0V53vg13d2Weebgw3Qo0SqqJfJT8MvS8tOzmHzAFANHeMRVdNWTBu4pSGsEcuWguYzfKZaiZzhDksss158MSrUhmaFpcHb1/4M23PjStbCj1sbXff99UQV1r/fWRKoKsj2gOCd95Xr0eH0Vyak4Q8t3V54W+Bhm6zRzzMsRCLky6dPwY2EXL1YWExXXIBlUr29YkzF6kjUot4XB3hyzbIc7ZAIrfQqiq8RulgXJXM8Fc4liEV2llE1dDcVTq14k0vORpRsbf8O8GrIZtKDHPnuNmX5RSTUt5P5Q2kvomNgf3FzwdysoqJ3W2s4Sq7UqWh56oa8K0QwXyqXswSXhNWtCRFohlG6pU2AM5ba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(44832011)(38100700002)(508600001)(54906003)(53546011)(31696002)(5660300002)(2616005)(6512007)(36756003)(316002)(31686004)(966005)(6506007)(6486002)(66476007)(186003)(4326008)(86362001)(66556008)(66946007)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVWZXoybHhZemtmR0tWZzNGQTFCeWlESDJsd1E1bTRGaFAwKzhBNUxuUmFY?=
 =?utf-8?B?NW5oQ283bkZzcGZOZ1lhOXZmeTR0a24vR2oxdFhUbVJ0STZsS1NFT0t0ZkJu?=
 =?utf-8?B?Z3FsNFNxWVVBOTh6UkR1ejdRelZLYU5GWXJhYUwwcGw3QWNhOTIwT3paZytR?=
 =?utf-8?B?S3VMR1Y4cEhqRzdVVXV4b3hJUkJYb2FKWHpPZENiUzhacS9XYlgwWHovSHRD?=
 =?utf-8?B?UzVkdnpZSzVzUmlrQ1dROUsyWjdVZWdrcC9vTk1SWXpFRmljY2liS0c0TXlv?=
 =?utf-8?B?VTlLcDBVYWR5aVRNaUdsWE5VRmlSY1JVZlNJOGlJT1ZnUW1KR3ROcDN6ZmtW?=
 =?utf-8?B?WmlKa0ZWK0M2M0JWc1gwU1dHU29uSW5hRUlXVVRkYnVWWFpHbVFSbk0zTEhC?=
 =?utf-8?B?Vk1SdGZ0eTJQZXBMYTl1clhtbVp5b2l4UDhKd2pBS3B5bkpnT2doMUR3NWli?=
 =?utf-8?B?YWFURisrcTRrNyt5TGRqcnNYYkt3aUs1RzNTTjdST3BzNjAyZ3NtRnlBdndn?=
 =?utf-8?B?bmdrTzE5T2V3aHY5d2JSeklCZFRZUUl3akl3bWFUQjZIN3RCbnNUeXUwTE9I?=
 =?utf-8?B?ZEx4SU56MmdFVVpFaEROSENQcE92cFlMRHlTcm0xOUkwR3NYNTV2c3pmakxr?=
 =?utf-8?B?eVZ2MEtOOFRHc0ZEdjJFV1EvUmoraHlqdE5hdVRJd1ZYNXFOdzNKSDlZK2k4?=
 =?utf-8?B?cDhST05WY0ZjZDlsRmJlWEo4K3lSR1ZnNlVoRWFpK2VSWE9hdnppUHNYWnFD?=
 =?utf-8?B?a1pQc0JPRGZTS3NJaDE3NmRJU2VvNXkzc3BjUkUxSXlyV1o2QXVYNVFaMHR0?=
 =?utf-8?B?c0s4aXZ5VlpvK0VubkZ2OFFmdmY3QlRuTldhaVlWWlBXU081ZVVXTVgvSFg5?=
 =?utf-8?B?dFZKdGNqYzhtSjlMWEdIZHRydXFKVHRCSDVjRWMreXZ5VVFham9JUHc4NUo5?=
 =?utf-8?B?ajhMdGQ2K2EwZTU4YnZzalNHY2hpVTAvZXpEVjNoMU8ySHBtMVZialR6YjBT?=
 =?utf-8?B?bVlYb3liQStJNEF2Z1pRRjFGMHU2RGVXa2RsVWtLSUFGanVMSldLL2xFRENE?=
 =?utf-8?B?b05nU0hVQWEwZURVN3I2SnZKRjVWMVZVYkVpZW1qM2NHOUxnWVpzUlVvbGRI?=
 =?utf-8?B?MTVkQkFWaFAwS05ZSEUycG82a2ZCU0FGbElxZERlWjRJVWJoeHBqRzNVeEtY?=
 =?utf-8?B?VUNmVUl5UTh1di8rbXlvR0wzVEFNYTdIV3lYd0dhdEUyMkZSa3JQSE5pNjl1?=
 =?utf-8?B?VnhBcFpHbHhwN296WUM2ME1ZYzFQWnVzSW9Dd2wvVDFkTENWQTJTQm9qU0pu?=
 =?utf-8?B?WnVlVFhzVkxrM1dLK1Fibjd0cHJwSTNuMDloVVJrdEk4SlkxVVJWd2dsNXRN?=
 =?utf-8?B?MGxWMHdyQVNLQy9UWTQrcGFvVU01UzdSOXdhbGF4eXl3UmtYZDlYaXAzN1Yz?=
 =?utf-8?B?UG9aN3JTY1gzemtVSmF2Mlk3VXl4YVkwc0lYclh4L1N0d282aS9MTExQajlm?=
 =?utf-8?B?b3RyZjl5S053RFMvcnhvUTY2WGZxL3k3Rys0Vkh1SklSMWhVc0pkZXZMWjl4?=
 =?utf-8?B?QzgraC9GQTZOK0Q3NHRWWHdMYlVRcEFLbHZ6SUtUdUVkaWQrWHI3V1g3U3JC?=
 =?utf-8?B?UlAxaSsyT3lWeDlzWEdtKzRvL1JhamFLODMxeTlwaFNxT3l6RzNLZndYRmN6?=
 =?utf-8?B?K1kvOUtUeStRTGQ3dUJFL1NldlYzckpoUVAzVWJ0bmVwT2liY3N3VnpRMHVS?=
 =?utf-8?B?U1BMM1ZwMnJOdW5BUC9zUDBzd05jTjhUNFUxbUtTc0taeFlkNDl5ZjVWNExC?=
 =?utf-8?B?UVl5cUhlSE42RkFzM0JLRGlYZnhVOVRkZk9JckgzYSt1VHA2d09zVlVPZ2dE?=
 =?utf-8?B?T1J6RFNQUXZBTlVRZDdCTEJ2SktyenVCd0U1UnpuZ2hSNTF5UjZnR0dIRFRx?=
 =?utf-8?B?RWNuSFBwT09QZGV5SjJmTHFKYkhUUTdPcU5UNmcrS2VESFpmNEROcGlBU3Zz?=
 =?utf-8?B?eUNtdDA2UVVHZ2gyRzNnc3RTQ1ZTN2I1cUNCOGxwNWdsL0M5aDhEVG5uYk5z?=
 =?utf-8?B?SG9McGpwbkQzTk4zUXpUODMxNlJDQ2c0T2lxWjJGN2hpZ2hoZDdrb215UHU1?=
 =?utf-8?B?QmdpeENvK0ZHS1JCeEFhRi9NVHowdlVQbGxRTU80L2tyN3dIeW9mN1luWklh?=
 =?utf-8?B?TUorZGhSSkhsWFFqS2VERmZ0MVcwZnBLUndiWkFVdDhtZ1ZCOWp4a3lNaGRW?=
 =?utf-8?Q?7Sf8yu03Rnt1U7Q84opdIPHfakwDVWLpD3JPSkhzcw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126e7db9-8e07-4402-a51e-08da01203402
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:25:05.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I9sJdS5GUp+h/rmjwaYD31D4HyyDbX05A+k0ehMfybXwLIbAS2hAdy2QKZGXRUAZS5FxLiJ4Vs4Mtmok5JSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-07 11:26, Shashank Sharma wrote:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a new sysfs event, which will indicate
> the userland about a GPU reset, and can also provide
> some information like:
> - which PID was involved in the GPU reset
> - what was the GPU status (using flags)
>
> This patch also introduces the first flag of the flags
> bitmap, which can be appended as and when required.


I am reminding again about another important piece of info which you can add
here and that is Smart Trace Buffer dump [1]. The buffer size is HW 
specific but
from what I see there is no problem to just amend it as part of envp[] 
initialization.
bellow.

The interface to get the buffer is smu_stb_collect_info and usage can be 
seen from
frebugfs interface in smu_stb_debugfs_open

[1] - https://www.spinics.net/lists/amd-gfx/msg70751.html

Andrey


>
> Cc: Alexandar Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>   include/drm/drm_sysfs.h     |  3 +++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..52a015161431 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> + * @dev: DRM device
> + * @pid: The process ID involve with the reset
> + * @flags: Any other information about the GPU status
> + *
> + * Send a uevent for the DRM device specified by @dev. This indicates
> + * user that a GPU reset has occurred, so that the interested client
> + * can take any recovery or profiling measure, when required.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t flags)
> +{
> +	unsigned char pid_str[21], flags_str[15];
> +	unsigned char reset_str[] = "RESET=1";
> +	char *envp[] = { reset_str, pid_str, flags_str, NULL };
> +
> +	DRM_DEBUG("generating reset event\n");
> +
> +	snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
> +	snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_reset_event);
> +
>   /**
>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
>    * change
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 6273cac44e47..63f00fe8054c 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -2,6 +2,8 @@
>   #ifndef _DRM_SYSFS_H_
>   #define _DRM_SYSFS_H_
>   
> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
> +
>   struct drm_device;
>   struct device;
>   struct drm_connector;
> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>   void drm_class_device_unregister(struct device *dev);
>   
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t reset_flags);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>   				      struct drm_property *property);
