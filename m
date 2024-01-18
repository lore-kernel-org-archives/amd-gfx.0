Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854CAC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 02:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0844E10E0CD;
	Thu, 18 Jan 2024 02:25:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFEB10E0CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 02:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc/pekPX/uf5I1vw1Pru7uFinFMqD+58wbK6odnqjW9LT0ToJRK74rfvmrazhx0vTHTAMDP++a483WNlbkoQbw4gNY+W6HamLg/7HBhSmX53I87r6E8gLEK8FnztWwhOPEYC2NH0Hm1pY3T1YJj6F04vTEARSTJ1PeYqwJC0AYdIxpV67JjAajZLRyJtukFdvb0QrYWL9gJGMcHmjBK0Ooi0LmDvUFBb2KGzNxBRA5njzxxrXstGajOFddrlSYORvFA6ht4zHLhLvBYc5UFq6EhnhoDaqmrbNSoz1vUuJAju9/BQqPdJ4bBWp79pQvkSoK0cAeb4/ieTa0i+2jDm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7dK0VLJAbGYYHQ9LAEuj7sl2wOewRickTFeb488U18=;
 b=J1LFGqW4k/QylCjuBtmN6qvGki09NoPzFifrlN3fcXDz5NB988mTxa+D0OZ93PjsbJ6+OXDfYlCxqo9D/c7h5ws+p2nI8F6TZcewcQ5VDCO3ARcBvXTIyVb4NBUyAIQ/H222Gy5+5V3SupA2pTLFB34OmwXzcNZGnCoYVXsdKgo+V0b2oMaipT39wkO6+ist4ivvwCMmEq5U6HVG1LJ6U9i/bkWpHOsXCnCxRF36u4uheOpmxXcenkOW5/eZIUuMkQu0iI5H9/N0x/z+P7cqgMtnUze7TFYo08h8Ix8J0u9yBhY+vEHGVLUMScOvrK3sVYH7mz37Nj5hUcG4RPB8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7dK0VLJAbGYYHQ9LAEuj7sl2wOewRickTFeb488U18=;
 b=MWN1Oau1UrhlO8zCYHBaMazknYk8zkcMWpa9lqGs+v4gn6EF2ALlTxKtWyAmnfKBT64E4UdWhnjfoTIjDDvjwIZGZ4Axc3I6bYjg44Z+xEZjxr+3+UozRnLhvWHOAmk+FJTUSgTY8cTKhALV4m3eLuN1rXMUQOqb+X9HqNQJgnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 02:24:54 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7181.026; Thu, 18 Jan 2024
 02:24:54 +0000
Message-ID: <9a10bd66-6551-416a-a61f-2ff8c209cc44@amd.com>
Date: Thu, 18 Jan 2024 10:24:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
 <f902f7a3-ea3a-46fa-9220-447e54954820@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <f902f7a3-ea3a-46fa-9220-447e54954820@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb62aef-82d3-40e9-e06b-08dc17cca7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Rufn/9RGNcHzRLW03hhREh1nb6d5oKKdNPagvdy0ihMGF7RvqV6MK9glPBP4VOnhrdZISsQT0tPIqNCALms/TfgtzgaN/UeXwZlXLaQ+BcNG+nu15jdJqKqfkT035L7kyL6vUEt4VKCIure6vmQMK2oK4D4wTuXiSj2s6Xd6/QV0EMXXnugXr19Qal7QJgHiwhAg+k78/pTOMoIIiuGGfw8gSfMnljpia86UTOrq2o6ZnCF5emSNh4H2OImrrEcXYpkOiPHt0bz/hxrGx+ZV1TNyaFEHlLdAPAMNgRPqSSR8kB4EhFNWy24NOf9Inih+O30sDq//fq0bQ+b/TEuv3PKuO4aq2kEEv5VDlBlGKoQgk2g2QSSoQ9ngh2xUhah7fq2dGEBB5JG6G5VOdM0ZjzcET3uxzo6Jgr5oUgoY/svAL8M3Z/CMrV1mbWa806TeBfo3ASPquNlHXABQvavgtPSNShNIPh+ZogkCc6TOE60tw7Jg15KUqLPJVp6yy0cTY6J5Is6iTmGlexg2W8hR97x9wwoFF5/tpU6MSe3YwqrUxFhWCwf7VnoWkVr/YxPwz22nWrEwTyDQEfiB+mAKjhXSKa5PZ8zctU0eeuy2e7copgG4nGuUDhfFrxWI4H+aoN/XMLlu+iXclxAhcEW5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(6666004)(5660300002)(66556008)(38100700002)(8676002)(2616005)(4326008)(41300700001)(2906002)(6486002)(8936002)(110136005)(478600001)(316002)(66476007)(66946007)(31696002)(36756003)(6512007)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNCSmFMSHp4Y1dZenFvckNIaVhPWUttWVFKYzdDMEtLY2NibnI3b0RDNFc3?=
 =?utf-8?B?czl0cWY5d1ZaeE52NENQbURuN1NUa0dWMlMyYjFwT1RwWnhYeEdpK3g0V09R?=
 =?utf-8?B?L3lFTDhQVytRaHpMS3NJbWNjUlhveGRnU25NbkZ1QTdmazV1UzJuMFlyKzhp?=
 =?utf-8?B?ajhzSzdBbFZLSG4rMUkyVE1va0NSUjl0U0hRN0NpbXl6ak9iUmUzbkJyVW1O?=
 =?utf-8?B?ekJ2endubStEMmdnSWwrK2s4enlxRWJmczVMQkhuTWhNYzlOaTA1cXNraVlF?=
 =?utf-8?B?V1NMUXl3ZHJnOVRzT2c3OWxHTjRDWW9YZGhQWDBxSnp5eldZWWl0aVpiRlYx?=
 =?utf-8?B?dEp4ZEZjdjBmdjg5SHdRa094dXFCM0k1eTZ2aXlhY3I0cDRYKzJ0bTRSMlZa?=
 =?utf-8?B?cHZQSUlhSnc4NFlCY0Q2OWEzMlRaeU1sVEZvRTY2N0QzOHp6d0VwZGFzaVZM?=
 =?utf-8?B?TUo0cW9RRUxxNnU1ZlJEOTBMeFpvMzA2UkFaWWRKQkV2aFVWd1djSEdWSXkw?=
 =?utf-8?B?alY2Tk5hTTA0Qithcm1zVC8zcWZSRFlwMXV6SThaUFROM1hBaTdlVldLM2pl?=
 =?utf-8?B?dUxISiswZ25tZGE3NkZzazN2QjBVNzJBK2hxTXRPZENxdC9yNE82OVE2M0Qz?=
 =?utf-8?B?cFNOSFMyS1Z0bjBrTWZub2RxVWJpUmZkVnNvZjF6ZmJnWkticThCYjV1VjYy?=
 =?utf-8?B?VWpUQkdDV3FzUVhhOU43UXZERnJwM1ViRzBqSlM0WUZuY29oaTZvQk9LM2NJ?=
 =?utf-8?B?Skw2SXVrOFhWWmtOcFlmY25nQm1CZU9ERzMxdmlhWnNvU1BsUVVkLzJMU2NN?=
 =?utf-8?B?VEZ4bGZvZ2JDZHliUktoTEhHY05mdFkvSFNaTmx0dGR5MHlWMTd2UmFkRUt2?=
 =?utf-8?B?cC9ycHYyYjUwd242d1NZczRnR0tsSFJvUjBwMFYwSHVmcllOSjNyeVNOSjlP?=
 =?utf-8?B?OGtUSVZJOCsrUG56NEdRdVQ3RWkvdlVjNnhVTDROZTY4aFJVcGl1VkMrRWdL?=
 =?utf-8?B?Rm81aVNiZ1FnaE5hZ25YSGpvWFFWT0ZGWGNFalZ0WVVaZEYyZWxhU00zRHVW?=
 =?utf-8?B?MGYwN1VYMzAzYndGelo2TVRGR3pBaEVJQzVyQ2hrYmhseVd2Y3JKbXBHbURi?=
 =?utf-8?B?ekQ3cGFXOXVKcHcwRGtVNnBXdHZhaEw0bXVYbjFsSlJ1NmF2V2VrSlM1cE9V?=
 =?utf-8?B?aVZIMUhwalgzaXVZSHhZTTdzdk0zK0V5V2gvMmxZeTljUm9SV2JOeFgxcFIw?=
 =?utf-8?B?RWJhZXgrQUxkTWVPUlhndGN3VTFtSnh6QXgyQlpYcS9yMU93Um51NkZ1SnB5?=
 =?utf-8?B?YnNwQnJVRzBUekV0V3lPTFY2Wmh2U2FNVDczUC9acjlSUC9hQlNTZVR5dDA5?=
 =?utf-8?B?MnFtYnFBMkNwUTV3QTRYalNvTktpVW41dC8xMUdmeGxGcDU2aTNuNmUwQVR4?=
 =?utf-8?B?VXVwZGl0eFR1WElRd3hwUXBjdW13TmtDbFdKS1FjSmUxWXBGbTN6UXg0eFRt?=
 =?utf-8?B?N1crcjF1VTFZVmdMaWRlTS9aaUp1aWg5Mm5Qcm96azFxVE14RGl1T3ZXbVdj?=
 =?utf-8?B?TFg2eTN6U1lOaFdRSmJxOFpXeEs2bTBlbGczdHJxZVF0NkFRdEM5K29Wa015?=
 =?utf-8?B?NGhDUEROcjVkVzUyQUp2dDh0cENtOVI5dGtJbXhMYzhFUXg2czF5SExTbU01?=
 =?utf-8?B?czlzajJjMThzNXpkV09VS3RZdGE3NTVrSG1zU1Z3YWNYYVdxQUVFK0dxbVVD?=
 =?utf-8?B?OG9Uc0tRSkV6YzNaV1RoOS84MERpMC84cG96VGNZQW9odVExU2ovUEo2Y0Zm?=
 =?utf-8?B?WDJRY1VZZFIzNFdKanY3bjFWSVZEUGdwL1VQVW1NeU9BMU13MDEyNGd1QWJI?=
 =?utf-8?B?MFA0UnZ2RmtCSkR6a1Z3Ry9makc2c25DMUcwaUpVR2VjVHNDdWcwVXl6cHA0?=
 =?utf-8?B?Smdrd1JVRDNOa0hNdzVsS1R2Y0hhdjhmMm5EajcreGNCMW9naVl3QXA3TVdj?=
 =?utf-8?B?RTQrR2R4bnhXZ0tsY2JXUWYxNDVDNXViL1pMRzQvQUQwSU9KeERMeDJKdndo?=
 =?utf-8?B?VG16THJ4VUJucEJBb1FDbXFVb2lSaFQ4Zi9CNTBNZ1F2clV6ZmxDZ1FyZWNM?=
 =?utf-8?Q?1J826nzi7Njcaisbd6DqcL42m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb62aef-82d3-40e9-e06b-08dc17cca7ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 02:24:54.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eq/XZjurFWYHPtSKht3rdFqttIZKVoetT4VFB7WnWczE43d4TZe1GXVIyW81h0Fg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
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

Hi Lijo,

On 1/17/2024 5:41 PM, Lazar, Lijo wrote:
> On 1/17/2024 2:22 PM, Ma Jun wrote:
>> The power source flag should be updated when
>> [1] System receives an interrupt indicating that the power source
>> has changed.
>> [2] System resumes from suspend or runtime suspend
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>>   3 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index c16703868e5c..e16d22e30a8a 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -24,6 +24,7 @@
>>   
>>   #include <linux/firmware.h>
>>   #include <linux/pci.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/reboot.h>
>>   
>>   #include "amdgpu.h"
>> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>>   	return smu_set_config_table(smu, &adev->pm.config_table);
>>   }
>>   
>> +static void smu_update_power_source(struct amdgpu_device *adev)
>> +{
>> +	if (power_supply_is_system_supplied() > 0)
>> +		adev->pm.ac_power = true;
>> +	else
>> +		adev->pm.ac_power = false;
>> +
>> +	if (is_support_sw_smu(adev))
>> +		smu_set_ac_dc(adev->powerplay.pp_handle);
>> +}
>> +
>>   static int smu_late_init(void *handle)
>>   {
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>>   	 * handle the switch automatically. Driver involvement
>>   	 * is unnecessary.
>>   	 */
>> -	if (!smu->dc_controlled_by_gpio) {
>> -		ret = smu_set_power_source(smu,
>> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>> -					   SMU_POWER_SOURCE_DC);
>> -		if (ret) {
>> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
>> -				adev->pm.ac_power ? "AC" : "DC");
>> -			return ret;
>> -		}
>> -	}
> 
> For this part of the change - driver already updates FW with the initial 
> detected power state or the last detected power state before going for 
> suspend. Isn't that good enough?
> 

The power source may change during system suspend, so it's necessary to detect the
power source again before system reads the power related data, such as max_power_limit.

Regards,
Ma Jun


> Thanks,
> Lijo
> 
>> +	if (!smu->dc_controlled_by_gpio)
>> +		smu_update_power_source(adev);
>>   
>>   	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>   	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index 2e7f8d5cfc28..8047150fddd4 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>   			case 0x3:
>>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>   				schedule_work(&smu->interrupt_work);
>> +				adev->pm.ac_power = true;
>>   				break;
>>   			case 0x4:
>>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>   				schedule_work(&smu->interrupt_work);
>> +				adev->pm.ac_power = false;
>>   				break;
>>   			case 0x7:
>>   				/*
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> index 771a3d457c33..c486182ff275 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>   			case 0x3:
>>   				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>   				smu_v13_0_ack_ac_dc_interrupt(smu);
>> +				adev->pm.ac_power = true;
>>   				break;
>>   			case 0x4:
>>   				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>   				smu_v13_0_ack_ac_dc_interrupt(smu);
>> +				adev->pm.ac_power = false;
>>   				break;
>>   			case 0x7:
>>   				/*
> 
