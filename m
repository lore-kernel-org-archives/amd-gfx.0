Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E30C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 09:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB87310E0BE;
	Wed, 17 Jan 2024 09:41:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9431210E0BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 09:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4v84T25OJYPNX0Bt2OZnM86c3kLeBggdQlzMvnoskyWTJ1tGZjwZ0SFAbBWLpRw96sJlKHNyoeovK8T8VKVNPtzYhIy/e1r2iqL5ShNXt9xtaEUT/oRuOfPjW+z6ognqDYwEJ+nus1/JJ7xsp8WQZOy7x2l6xf4SrjR1hBp+Gtxom+hk7GCCmUJptmtFQOHLuXjqLOv/A+SmZvIyRZRw4vnOWX2uu9u+sSBPOS2jpaTFSRtLrwZniRM/KIXmOkB8qfCHrc0jFms2MXgaruUtL6fj3fOyG0RZ/cbs/Ohm6J8LWzIbiVkOwy6YKEl7/gLYH14VBVATOcRws2KsMKWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGuktDbBchOkZtNeORt8rM4QGrf8vm1DDKXU6w+o0uM=;
 b=J6O1SInn9U+Q6rcptNRQK54L5Omy24kcA9PacKgRlO+SIOr6608grtisUIC64+INbhHjSaBKpMJEX5zDlXc61TOSzPM9P5Y2xQVNdbKbLrRGrOEiq17qXs2P3wkGHaqiVmCxMb3ECK3fxs2IZwgyQoL9v6soOBJw2em7J/ohOzEyHK6pkYm4OlfYFPdtfUjc09czqYwfxu3bDbZ6Ywy3ZMZAmpfwbyVfA3YbWtJcEuqrb1JVnnNhTP5xdGII1fBSk2QTodOZl/Y1y3x0yJw3nTuJnywqGvVU2RTjsuwTCexZkxwHlb/bcUKNQAR/nbpqXZQg/FaLximt3zd/OsR4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGuktDbBchOkZtNeORt8rM4QGrf8vm1DDKXU6w+o0uM=;
 b=uoDW7zchZoeZ76n6m6s39zrfA1gtJKdQy0mF3i90r1nroTn7NAKZwI6b/+mKcYo/v7+HhMJXWyOaamKyv3U2h236PntYcLgwpJOVKKur/+YLrLk9FW1QzQoA5Lgngr9hl2MkiAPgRsAcWK8Lm4YuMxx3U0sHiQZYvd9jpu0xi1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Wed, 17 Jan
 2024 09:41:45 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 09:41:45 +0000
Message-ID: <f902f7a3-ea3a-46fa-9220-447e54954820@amd.com>
Date: Wed, 17 Jan 2024 15:11:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240117085229.981555-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: dd435d7c-7a66-473d-f2c0-08dc17408459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzlcjLVp3ByeGLiYqmUQvuVHx/XOVvJydA8YgGPDdRsWokYRPDz8NqLQypOaD2QZs4SfRdxbVSTR1JmaqNZ3vaegruQmdAGCuIzGGCrngwO7PDrRPeWkmoae1E4CPvUdGgOAwsoj5HUlmKA3EmAU5loHvfXqQGaGrAmsy+IsNaeRAIF2+KlJ9lLBA8IAmf9+6+bi0emrye3+JI+zNlB400m+IhpiwEFin5zxlNyiK6mwBGQQiFDfNwsAipe3HgldGSe9gbyt3V4XfXyaJpVjml9XxFF1UP1QduZZGCiBwANyoFbJ21QtjJ1hPvUGh6N9IeiFQ4OXoU91N+X3YeK8H3ejxMDU1KyKI4kcF4xySKf4szi7L8c8OgB2tiyY6+4TgSycji2YgNLGKwzKZVAZaStm3243cFj8BQPDXYLEWArT5uNE7qIhS/yQZu+7g+TowMYmFnJjgSw5YS3Prq+HKQfA2Jp/CK3axSzD4hYsqCfkeeDcLhV1rcUks6SXJboWPKMWeJ/ZcMap0Cn5S6KXneqQExdpcS03T5wzuGg0MA98esxqZn3eXRMf3LZP7S3IwpLEii9BKWWAXGWzA/Qjx7/0eT5e/HicUYI1mg/8qX2S3GoEnJYzKunX9BDOawfb4YpR90MsXNly/47brtJ30g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(83380400001)(2906002)(2616005)(66476007)(8676002)(53546011)(26005)(316002)(6512007)(4326008)(5660300002)(66556008)(6506007)(8936002)(478600001)(41300700001)(6666004)(36756003)(86362001)(6486002)(38100700002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emNTQjQ3MW9yYzg0cW9GVmVrMlJoaGNaQnZWY0lPcFRjMnJjUGgxV2djY0JD?=
 =?utf-8?B?aDF5bjNQdFIxbG9jcGxZRUVsWEFVV1hpMXl5VWpMMVRUcVpDK2w0bHh3MTF5?=
 =?utf-8?B?Sndham5QcktkUkpwOHlrM1JrM0lBbWcvNHBqWkthV3dmdWQzUTEzalQ2alZj?=
 =?utf-8?B?M1BBcXZSd0Y4NUVNdkU0RndFcjFEa1A1UzNrRTVJaUdhMnF1MXJoTVRTWTNP?=
 =?utf-8?B?UE1rNE5yUmJkS0ExdW5SeXZkSnJPVHRENHhIV1ZIZ204WDVpSnVCYmp0RFUw?=
 =?utf-8?B?ZUk5bEZ1UzRzb0haVHpRUjZycnhadDVZMjh4L1lVN0VTV3NnQngzNXk4a1JI?=
 =?utf-8?B?L1lGRWZiM1V5dmlISW9jNXJUM0tmOUZUQmY2U1NrQXkzcjFMNytuVGU0b0hu?=
 =?utf-8?B?dE5KZjdDUHBHR3prU0puT2xySnB0dFdxNXpYaExRZkhIZEVGeFcyM0hqYk5X?=
 =?utf-8?B?eXBwK0ZwdCsxYTk1cHJ1U2lmeTRsWC84dTdUdUJNdi9zMEpweDFsMXl5Wkl0?=
 =?utf-8?B?N2hQZyttbjRPb2F1RUN4YWVicUVQUFR2TnRCZXN5NmpSOG5rYkNnZ0pkMGkv?=
 =?utf-8?B?QmJrWUNkdHBYa3dEZTBtREdnaE9SN3I0b3dvTkdqaHIxWEtWYnd3anYzaTZz?=
 =?utf-8?B?K3E1L25SZTVYQWFoanpUUkJRWTMyemxVMzFueFJJbkVOTVlDNVR1MlNOTUdY?=
 =?utf-8?B?bGtYV1VkcEErZitYV0lUc0Fid3BtM0JxelZaYTF5Sy9VQ3hwdzdSVnBRWjFn?=
 =?utf-8?B?Smd4bWd3eFo0WkVMd2Nxc3l2cmVGVVFkV3l3M0pLRzJZeE5MMXZ1TW5JZXFM?=
 =?utf-8?B?Ris1bXYvOHl1V1RLbGVBZUdydE9Ib3FZU21sQTJRRlRJSmd5YjhWTDlRWGhz?=
 =?utf-8?B?ZFIrZjF0MzRIeDdEMjhvRW1BWFVJOGJ5emw0bGV5cWxGMml4T2hHRVNPQ2tO?=
 =?utf-8?B?anpMcW5zM2VzdTRuaWpYYVN3VVZCNVpFelMxa0NQcDdBYzF6aFlIQUlMdndG?=
 =?utf-8?B?aWdKVE81MVpkbURhRzVVOTEzTGw4YVpQZ1RnQXBBQ1F0c2FHa1J3YnlhTEJ6?=
 =?utf-8?B?djZEQ1M0YUN5K0JCU2lDNzQvTC90UXNuOUVUcmNhc1lobThGdXhNWkNicUxO?=
 =?utf-8?B?UXV4NmdmY2lscDQ3K0lldTdUdm1NMUdwanNhMTEybkY4SVpSVEMza3lxM2Qx?=
 =?utf-8?B?UzNlTFVGUTcreFAxaFRlaURUMXMzTFY0UUMveTk2a0ZMdHpPWFoxSDZEVERa?=
 =?utf-8?B?VVFiMmo5Sk5nKzhJZnZXTGhxWmgvdmlRNDNaQnVqbmhPM2JFOVAzMDY2RlMz?=
 =?utf-8?B?em0rcWFtMzZsbWpUdXZ4bGJXREsxSGRGTTNVakFaeTZ6WGQ5ZHpTOGhXVUtj?=
 =?utf-8?B?VG45WkNuVWJzSy9XQzdqUnF2bExoTnYyYlFRMWN2WG90OVpQSldCZXNoZVVW?=
 =?utf-8?B?UmMwOWRxRGRDZjJqUFdLUFdvUjZOeVE0cTNKYll0eDJwYldUTUJmRmFXa1cy?=
 =?utf-8?B?R0NwNEMvR0pZeWZvZFgvU2FpeU5QeHVwcXMzbkhuclBFd3l6L2tZL1A5UHRZ?=
 =?utf-8?B?L1dOTlp5ZW85a3RvaXBqL2o0ZlF5ejhaUzdHV20zNHRIMHV5L1dEdkhwYVpH?=
 =?utf-8?B?Y2ZxMDN0aUgrMTh1UDVGRDd0T1VpMjV0cUh2VjFoa1dVRHpLQUxhMFFnaWZO?=
 =?utf-8?B?V2J5dTJBcTJYUnVQODZleTNpZS9KSDkyU3E3V0NEcHJYbFZGbUNjWlE2QlIr?=
 =?utf-8?B?eWgydDNRRUN0b0VERVI1ZkUwclZWWm8vQ1grbzNBVVYvMFdjOTNnUUFuL0NN?=
 =?utf-8?B?aEVwRER5ZThGMUIwTUp2L2VtSXdCVmZjcXFzb2lUektQTWlGTlBKL2cyVFht?=
 =?utf-8?B?dTRHOTkrUjRraXc4cEZPdXdwV0tlZlc5YnhrN1JjeHVtTVZ4cWttVWZESG9t?=
 =?utf-8?B?Wnd5Tk9meVJzV09VYnhVWW1mcmh4dkFEb0tXQ0NvMTV2dlRzNktTY05DN0hX?=
 =?utf-8?B?c3NBOVhmcFFiTS82WFd3c1ZUUW0rTFdzRjIxNWQyZldsbkdMcStyQXgxV3Q1?=
 =?utf-8?B?TjdzTUxaMVB6aE9Vd3haUFVUM0laaUdrTStMTGtucXkwdXhpV1hka25ESGxG?=
 =?utf-8?Q?2GvZayhOToJUe5Nb1kuT4QT3I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd435d7c-7a66-473d-f2c0-08dc17408459
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:41:44.9708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngxJ5qevFtibGBkvLwcciiG/mN8siSb26c9aePh3R6Mik+Giz1ap/k19JaiyT2tz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/17/2024 2:22 PM, Ma Jun wrote:
> The power source flag should be updated when
> [1] System receives an interrupt indicating that the power source
> has changed.
> [2] System resumes from suspend or runtime suspend
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>   3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c16703868e5c..e16d22e30a8a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
> +#include <linux/power_supply.h>
>   #include <linux/reboot.h>
>   
>   #include "amdgpu.h"
> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>   	return smu_set_config_table(smu, &adev->pm.config_table);
>   }
>   
> +static void smu_update_power_source(struct amdgpu_device *adev)
> +{
> +	if (power_supply_is_system_supplied() > 0)
> +		adev->pm.ac_power = true;
> +	else
> +		adev->pm.ac_power = false;
> +
> +	if (is_support_sw_smu(adev))
> +		smu_set_ac_dc(adev->powerplay.pp_handle);
> +}
> +
>   static int smu_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>   	 * handle the switch automatically. Driver involvement
>   	 * is unnecessary.
>   	 */
> -	if (!smu->dc_controlled_by_gpio) {
> -		ret = smu_set_power_source(smu,
> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> -					   SMU_POWER_SOURCE_DC);
> -		if (ret) {
> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
> -				adev->pm.ac_power ? "AC" : "DC");
> -			return ret;
> -		}
> -	}

For this part of the change - driver already updates FW with the initial 
detected power state or the last detected power state before going for 
suspend. Isn't that good enough?

Thanks,
Lijo

> +	if (!smu->dc_controlled_by_gpio)
> +		smu_update_power_source(adev);
>   
>   	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>   	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 2e7f8d5cfc28..8047150fddd4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   			case 0x3:
>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>   				schedule_work(&smu->interrupt_work);
> +				adev->pm.ac_power = true;
>   				break;
>   			case 0x4:
>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>   				schedule_work(&smu->interrupt_work);
> +				adev->pm.ac_power = false;
>   				break;
>   			case 0x7:
>   				/*
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 771a3d457c33..c486182ff275 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>   			case 0x3:
>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>   				smu_v13_0_ack_ac_dc_interrupt(smu);
> +				adev->pm.ac_power = true;
>   				break;
>   			case 0x4:
>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>   				smu_v13_0_ack_ac_dc_interrupt(smu);
> +				adev->pm.ac_power = false;
>   				break;
>   			case 0x7:
>   				/*

