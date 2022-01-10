Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC81BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 07:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151C8113959;
	Mon, 10 Jan 2022 07:36:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E395F113959
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 07:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0uihqr2lF3x86tEFJ+FaOsY6JJM3APs9QpHSotMlBkH4+n0FurYPb9LEAcN8NHnzYxL35nhM2UeSbnyc1pS/dGbZwCGkFzOG20HGpRUl45qL9KK8YSqYKDMGd/Z/J99YPVyErUI5em6KpVQm78kt+H3YndLtQ02Lww6ckrGsqdfasFwITu1zbwuhOEZMtaMYxa5NxaDkrN9uu7HM/scZjlcbN51Y5SAitcMMIdKixq924B8ru4f8fM7icGM8UMDYxnX3sp9XkhV+DoZS8Uq1qHuBnrrs3EdyjjY5U6+oGJuGIwrqWCswwjPr9ngiCfdwrl322VL6BWwuzcPYWszMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fhyh4hRtlao5lG2VVHynCRCsAWQ1KKF4FWvTvUXXp4=;
 b=SQNZiMODosHBTildui8XgoHWfiPDe35PbI4hCcXsiQcT5q5RINi9GbQxqL2LjxCW7APXziaKT/SA5xae9VtOYrL/3HYhxTPYy70wpDw3wcx3WuBeHz+QXw6iDAeOMhEGlFOB0wU7svG3OW8orEY8HjK1D0nQF7h+wdDHZOMOkCkRIO+n4s6swA9QNfyzGe2JRzZaNTGeCwR2uKjiCYg20EJSWDHa0xP/XuihnVD1vpHbRo+o7hQgL1LS4DIcBycIMjMPHhTZ55ZoljrHeBcWTJ7nidjGqDsNRXyQ2ZWD7lCxz1zI7rd7OsKi1GMN+fZYxiYGiHW1TlkitFfnIWLrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fhyh4hRtlao5lG2VVHynCRCsAWQ1KKF4FWvTvUXXp4=;
 b=qOGTE/o1K9HxQq2zwMfoENq7fOK/ZArny1Gtf/VFXfTrUtmKFVurC+Q22t6hv0LjKVpBi5vc+0UvVnnU7YHXXbTmOHM6dbR5in6bLptDls3/BSgAmYvHBU4WbdrziKWjbLtZp6bmhQ7QH1kfEfXyi0ZqOO9HHcFTIB5XYLqN77Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 07:36:21 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 07:36:21 +0000
Message-ID: <1a71e156-5e04-6d49-53c2-c8ec83e2ce47@amd.com>
Date: Mon, 10 Jan 2022 13:06:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220110060042.3159997-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220110060042.3159997-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44afae29-9e7d-4cee-d9b3-08d9d40be5ab
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB331939D9D0C95C437BFF5F7A97509@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40SvzUEHoJXSvBHmtBCCAKx/vZcNLt7ozdXDo6bjZ3rPm3TRA7eIgVR/sQyrk1BCnlSxZXPhAc6uitn5+Itp56BmKuG2pq/fP053DistdNZ2bF6aP64/qHIhagV7FoovJ+u8Gk5IWF+YuQfrK6OdVIfJJRG8u7u5xDLw1BJVL/Q2qAg7rs0d2FN7dz4QEhPP4ePZtn/WSU1canxBJsFsIMnxwGWBzYqbnClP5TqZl9wQfdBK/sX2ByyxCzxcOpBUGFt2G9/jU+tdIFZHPpG3bYKRpIYNIfrLLbTWF5osNZY0/dWZFxotjYn41oH8e+k6pQZPPn+3Pq8GvDv8ri4WKiTAImfpQh3VWA+KjVaKof5zsN+UZGhRk5ot7Stka53U3uei++GI1dyIcpG9rKASco3+2CtQxwyFsNhkqSKv5qumIwTm+40lRcLKUMZpszMnC/8TRTUNp0wc+F+P+qoPJBSUR+mTF6PvhMglbhbOs6y1ivwo7r3OUSp2MZ3HTUcatDwCrFnx4PUjhvBHCxlU0qrYfclon1hSuoJGVJ9XcnFDaJRqJqM7U9ZweI8A7U3HT3joc7aUAHiIKEfUibOJafvX/YI/wkpsNcvzzTmeGL5Nf3GNsaDsTkip87fL3MzxEAdaO5mJTSDUL5W6VrwZU2w6Z3c8acaNnO8FX+LRoXbszM5a76GYqttqX3t/ruE+eyMi+YlLCz7KJSTCli/ajZZvAT/ZS+WtqT2Ls4jbmCP+SIoFFJ8gMxZXqBP6QMrX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6506007)(2906002)(38100700002)(6512007)(2616005)(6486002)(66476007)(66556008)(66946007)(36756003)(6666004)(8936002)(316002)(8676002)(53546011)(4326008)(26005)(86362001)(508600001)(186003)(83380400001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDJuMldNbFY2aCtzU09YRTl4VGUremFva2hocVRJMENVczhsUDUvbGV6WXYv?=
 =?utf-8?B?ZGoxNU9TOGhCK3FEaFZvQkNkc2x2ZDhtWHJuMEc2Nzl2bmI1WTY0OXZRYjlC?=
 =?utf-8?B?UUk5S1lhQmlHNUxVQjhDNGVlSzdXdVlKYWlrcmxFTVprTllucGRKb1BPakV2?=
 =?utf-8?B?VGJMb2Z3aEtUcU92dXBNRzdWS1RRaWVXY2FhbS94cEM3L3Z1MXhSN0JOQk0x?=
 =?utf-8?B?aUEraE9jL0dLSWUyc0I3MkR3Z0FrZzhnRUswWjdVUE5nU1ozR2pCMEswTnBW?=
 =?utf-8?B?akZweElTN1NRa3Y2T0xCSUNicDcyMnZ0Nm9XZEJnbTNJSFJlZ21yeTVTL0hM?=
 =?utf-8?B?b3dodWN5cERBaG9XcmtEZE03TkhaODdhcEZCWXhlSnBlYm5ZVDlGbjkweE0v?=
 =?utf-8?B?em8yT2JaT3ZJMWN4VjJ4eEFDeDU5RnNJZDlnMlpwZmJtSFZHNCtTSUVzMkxl?=
 =?utf-8?B?WEs1aXcxWGl3N2wzYkdHdWdyWU9QZTlpVVJjWXhxM3BsV0lpeTFSSkpBVDZS?=
 =?utf-8?B?VXhzM0ZTNTJHK2FpOEJqTm9UMGp5SHl2YTEzNS9xNmNKZzZMMkFKSEdrUGRw?=
 =?utf-8?B?ck9UVHFBMmJvWGZqOTN1SVkrSWZtZm1jYTF2NWN0WU56SHVkWWhyd2Z5T1c2?=
 =?utf-8?B?Tzh1akRUN0FqZ3pEUElGK2xJb3AvYWNPdXlvTHZ1SG5hTm9yaTAxQ2pObUd3?=
 =?utf-8?B?c0J6L3k2RnNpUWdvb29kNFJVTjk0SXFLdjdoU2xUelRPYzY5cmZYR0tLL2l2?=
 =?utf-8?B?SHNFa0YwUk53VzVDL2FIY3I0MkJUMjlacWF6bGtYM01udU5PWTFQejdCTU9z?=
 =?utf-8?B?alZZc0VBQnc3ZVFHeWkxRncyMDVpTEpGalFqZDVBSWhmdk0rY0JsRWwxdFVq?=
 =?utf-8?B?eVlLUWlNZGdadTZEMlNaM2NLQVJXeU1iS2lVU2ZHbTJMUWVySzIxSnh5ZjJs?=
 =?utf-8?B?a1FxQ04xTDRscU5ZcU9FUlRaTHBEeW1hQ2piTE42ZDNKcGExaGVDNWJkT0gz?=
 =?utf-8?B?Nk93bXJUYVFHTmYzOERiVGdkZzRCaWNVclRLZEhacWYwMytlVVMrUWRkdmdu?=
 =?utf-8?B?NXdCam1iNlZJRkJoS3NKcXl2d3FiQ3c4NE1DQUVybmFVMWNhNWRMaEJDMm93?=
 =?utf-8?B?TEZvQzNaZlhDYm5wVzRLSkx0NGhWeHN2MnpPTmJQN0dhZUNuQXhsWEs3WEwv?=
 =?utf-8?B?L2QwK1RVUGFmNGNCUllwcC9Wc3d3MW1jL09kOU1GcDFyWlpibGloSEQ0MXdy?=
 =?utf-8?B?Z3EvZ3MvZVByckNyeERhZkszVXNsbU1ha0JjS1NNT3AwNUh1Yk5Ocnp3YW9I?=
 =?utf-8?B?S0M1bmVtV1M4QzNpZUJxc2RrWWtFRGFpeC83WS9ERjRKQStHSGpoQ3FwTGRS?=
 =?utf-8?B?VEp0bnFOZjgvZCt0NU5nZ3Nibjh3dUp6WEZLRndjcTlXTkMyWlFoYmhTcFE3?=
 =?utf-8?B?Y1RIY0N4ckw4NWJsdjA5eUlrWk5VL2V3Q0ZRRXh0OXRqK2xzMUo5aE8yZVNL?=
 =?utf-8?B?VnNWYklBNG1UWWRzUXR2ME0wcWFWb0VRbmVBRVRkNVFLQ3dUZlphWTNDY2M4?=
 =?utf-8?B?MERiYzNWbEFTaGdKaCtuU2wyRHJnNERvWDJTM1JDNzBoOGZiMlp6ckVvdXlX?=
 =?utf-8?B?TWhGYkRzRXc0YnI0T05tMU4wOU9EZFFXbTM1M2tNZ2tzYisrZVhXN01RT2Nz?=
 =?utf-8?B?bjRBNWlVMVE3L0pxcjBubUdJUWg1cTBoZXlpYjFXU2c2SXo1RStpYVJQemxm?=
 =?utf-8?B?YzBBc0RZT0dhajQwWHZNUGVtaTVFUmkreXFXQmNISzV4VUpia3l6NytMUHFZ?=
 =?utf-8?B?Z2lGcnZRMXM1TDA0cGw2RXRKMzRkS2diODdDTGZURGMzbWdINFdlaHJLU1Bw?=
 =?utf-8?B?VklSdzZIY3ZyUFlqZTN1OC9ZcjFRZHpsNjZLczJLSWlvdUhERnlKM2RXaExJ?=
 =?utf-8?B?ZDB4aFF0QVVwTVhzTmx4MWJTL1AvcG44djRvYXJRTGYvbUhRZlhaNUExT0xZ?=
 =?utf-8?B?czdUbWJSNFNUUHNGZmR0RitLQmFzRVRUZ2NpblVsRDdVakNxeW0rOGd0eUxI?=
 =?utf-8?B?SXNvVnl3YVRQUmx3ekNKak9nUElsaUNhblNzWGtDWDJxenJpTGduMnVHMU9k?=
 =?utf-8?Q?lwQc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44afae29-9e7d-4cee-d9b3-08d9d40be5ab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:36:21.6515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOOy8kpEXO7d2aynttEwFVP0867GUTZh8TEWczp8mW+dMF93YVUTDyHcVCaz5Wt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/10/2022 11:30 AM, Evan Quan wrote:
> Before we relied on the return values from the corresponding interfaces.
> That is with low efficiency. And the wrong intermediate variable used
> makes the fan mode stuck at manual mode which then causes overheating in
> 3D graphics tests.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ia93ccf3b929c12e6d10b50c8f3596783ac63f0e3
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 20 ++++++++++----------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 12 ++++++++++++
>   3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 68d2e80a673b..e732418a9558 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1547,3 +1547,26 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>   
>   	return ret;
>   }
> +
> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device *adev,
> +					  enum fan_operation_id id)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +
> +	switch (id) {
> +	case FAN_CONTROL_MODE_RETRIEVING:
> +		return pp_funcs->get_fan_control_mode ? 1 : 0;
> +	case FAN_CONTROL_MODE_SETTING:
> +		return pp_funcs->set_fan_control_mode ? 1 : 0;
> +	case FAN_SPEED_PWM_RETRIEVING:
> +		return pp_funcs->get_fan_speed_pwm ? 1 : 0;
> +	case FAN_SPEED_PWM_SETTING:
> +		return pp_funcs->set_fan_speed_pwm ? 1 : 0;
> +	case FAN_SPEED_RPM_RETRIEVING:
> +		return pp_funcs->get_fan_speed_rpm ? 1 : 0;
> +	case FAN_SPEED_RPM_SETTING:
> +		return pp_funcs->set_fan_speed_rpm ? 1 : 0;
> +	default:
> +		return 0;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d3eab245e0fe..57721750c51a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3263,15 +3263,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* mask fan attributes if we have no bindings for this asic to expose */
> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_RETRIEVING) &&

As per the current logic, it's really checking the hardware registers. 
For ex: we could have some SKUs that have PMFW based fan control and for 
some other SKUs, AIBs could be having a different cooling solution which 
doesn't make use of PMFW.


>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
> +	    (!amdgpu_dpm_is_fan_operation_supported(adev, FAN_CONTROL_MODE_RETRIEVING) &&
>   	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
>   		effective_mode &= ~S_IRUGO;
>   
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_SETTING) &&
>   	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
> +	    (!amdgpu_dpm_is_fan_operation_supported(adev, FAN_CONTROL_MODE_SETTING) &&
>   	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
>   		effective_mode &= ~S_IWUSR;
>   
> @@ -3291,16 +3291,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* hide max/min values if we can't both query and manage the fan */
> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_SETTING) &&
> +	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_RETRIEVING) &&
> +	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_SETTING) &&
> +	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_RETRIEVING)) &&

If this is the case, I think we should set pm.no_fan since nothing is 
possible.

Thanks,
Lijo

>   	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>   		return 0;
>   
> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
> +	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_SETTING) &&
> +	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_RETRIEVING)) &&
>   	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index ba857ca75392..9e18151a3c46 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -330,6 +330,16 @@ struct amdgpu_pm {
>   	bool			pp_force_state_enabled;
>   };
>   
> +enum fan_operation_id
> +{
> +	FAN_CONTROL_MODE_RETRIEVING = 0,
> +	FAN_CONTROL_MODE_SETTING    = 1,
> +	FAN_SPEED_PWM_RETRIEVING    = 2,
> +	FAN_SPEED_PWM_SETTING       = 3,
> +	FAN_SPEED_RPM_RETRIEVING    = 4,
> +	FAN_SPEED_RPM_SETTING       = 5,
> +};
> +
>   u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
>   int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>   			   void *data, uint32_t *size);
> @@ -510,4 +520,6 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>   						  unsigned int *num_states);
>   int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>   				   struct dpm_clocks *clock_table);
> +int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device *adev,
> +					  enum fan_operation_id id);
>   #endif
> 
