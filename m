Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6714DC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 07:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE7410E042;
	Thu, 18 Jan 2024 07:12:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17AF10E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 07:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPYlTC7/7x9TVdWNYRhxS69c3hgLeB8/+wQ7Ty35kdseRppdqQ/jDOORG3+hYkF5lOqxTe8wPZlIa5/75iV2ArgNdt8DS94fdJJ7RXjxEvEtMoIq63a07HEp3h0q+g9gkteoOv8o1BLIspl3ULVTcD6WsZhKlaDkxNsEzxwSiHdJcBSQNKWrbYbP7UiK3gTJ/x0cujjmuur36X6KEK10NJSzxQEvwKRihMeyS7q0qhitkqIJOuN2dWbIaAoeUqMIbfj/mdPWnp5kP6n7PMRkEbqv8TdItjEAnjvW4e8G6ZdNKd1F8PrqOIxr+50/QgLClyuj1U7QjBrSDbMckrRFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhmiJnZpkyrapgiMztMrM21LIr4xHOnbatpz5JVTygQ=;
 b=QuzZLvXOCopLksM0gI+mGMoHayOQ0tNCU7NOqcKs3ZuZir99dzQGP17w3iBImcUKuzN4cQAWgaUCrv34Tkojl4EASFrJ56Fp45jpdKwdCzx2Q8eJkRWUyK1pcDrwSy31cqL0Jm54r8eXZpfXu4ittipC21KkPh/ABQeXrqzePVXq3J397zREpwfDfUbWw9eHypSNZmUBohiZOrhSC2Zi3nrbTjQpXtL6zogQr0Dhpa1+p7W+GWekTeDmMj6JLJU2UUy04QqQljpU4sP8de7KxVk2R4m5xREtc2teJiEBl2iXogWIRzROk1ATlFztizSw1MnFAQHIOfLmuZ3WqfJzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhmiJnZpkyrapgiMztMrM21LIr4xHOnbatpz5JVTygQ=;
 b=K8nQKgL/OBt28Dv5lFY/vtSMzFdMnqJODtS6zV6AQH5J7M3mw/y9IeDbwnwlGnHWvYSJpHbmBS93sYx0D2YPGaeHtSnsLwF8SVsZ+kZ97WxTVyBl+NRvb2uFPO3Bw6hTFq3z0pjt7e/my6aUtRMLNwwA1r8bBPvnr+rLzclZmbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 07:12:09 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 07:12:09 +0000
Message-ID: <82ab2a6e-8088-42d3-a9db-f5ca9cd7280a@amd.com>
Date: Thu, 18 Jan 2024 15:12:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
 <f902f7a3-ea3a-46fa-9220-447e54954820@amd.com>
 <9a10bd66-6551-416a-a61f-2ff8c209cc44@amd.com>
 <5c524240-057d-4bcb-8155-c995f2ec2365@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <5c524240-057d-4bcb-8155-c995f2ec2365@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbf10bf-ca71-4eac-4c04-08dc17f4c938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqlYTL5fmlZl09D5HUsCZ4EniRLF3ouIVO3Kqe42LOuEfjwVQ/tNRIr2iORHGkXp7l13pVIb7bJwHT0xe9Dne4b/zpF/UykQRn3Jx5psUhKkC2+wHNBf+L10wY4CGAFs/xIf+OIrt+dN2srIqhCuA8rnaEN3wg0zYhZmjFAUGcKkrkbXk26Jqa2xc8jjF+vW0ZLBZ9cICD1yd9vZtdm0tawKqoEXp5pXT7qiWwpA062/cG7oCbg6uSU/a5PF1QUqIvr4JXjVldOhBeysFXskXUMRoQwidDZbCpCH+sXXVe2CW7VSfrKegs6bg/PuzlMDu8VuKgC63vfROauaP4x45uucN6UAAmrtIZygOlXe+vmYNGTw0FMV9Tz5hRs1yPED0/kk0+FglndYcBN9QtccIF44v/cQzeKt+GnqyetuUGK8EWD1lkTCWaMBu+vzR96Zw6HYnZdTKLQrJEUMGJOqI+oaXpe88C6ngImos6hbyFY4BJskJ8HU9yIqfCSfq9sqzktmUA8kO7Hlo1d2ojgMIkyEsYXYX95KH+e1CpQ58U4m+zISr+xsa/KLjPKdQ4skzJNd/LxeG6exKETBl5P3YPIxdwZ5vACZlY8Yy+KFYfD4m+2O73VNUqNiiGlqHfxL28Tqk6KARNdezB1P4GtkNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(26005)(6512007)(83380400001)(31696002)(36756003)(8936002)(8676002)(4326008)(5660300002)(53546011)(6506007)(2616005)(38100700002)(66946007)(66556008)(66476007)(316002)(110136005)(2906002)(6666004)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1k5K3RCdTVOM1FCeHQrdnJxdjZPb1prUGN6VlJjelRlRnBMZ1IvNUtIa1Jo?=
 =?utf-8?B?SmlaL0pucmZIS2VvaDJxUHJ2Rlh2cy9WOWpCYU5odTB2YkhvSDFSVDhveXUw?=
 =?utf-8?B?YU00SHl2TFVKcFpzWmt6c0NBNEdPRC9tTEpTUTljR1RyNktyVGNnbVZpTmFL?=
 =?utf-8?B?S2hldmptMmdJM0JRempKaVNGUTV6dEJiTHJzNURnSHpDM1l5b0RjOHlnb2N3?=
 =?utf-8?B?RVR2cFgzR1NLaWF2THhuY0lOTGhSVG5NblJnMERzTlRCeHlOdlVoY0ZGaW8r?=
 =?utf-8?B?TDJZVXRyeUZkR1l1a1MxT1RWbFNIMldibkJMekVDWnV2USs0dEo5MjNtWTBV?=
 =?utf-8?B?L1Qzc0E0eUpTc0dyOHRNUUoxUFZRNitHV1kvRm4xaHc3L2kzSVV4WFdnK1Ba?=
 =?utf-8?B?UWpKZVJ6RFljS0Y2c1ZjR1o2blRjK213M2owclI4dFhtRmN2eHFsUWFaTjJV?=
 =?utf-8?B?d2FvR2NhdUY4UzdKUGFVN3pTd0g5UlpWU3VicTNrbFNRUkxYbm5Lb1hRbE4r?=
 =?utf-8?B?Z2RjcEhyM0xWc1lkZ3haMTVTM3VmSFRxbmZsOVNxSWNNYitzZnYxTlY0QlNi?=
 =?utf-8?B?MlMxNldJVGgzRDA0Zk4wanBkN0tKZmJtMUZmUllobHYvUWd0RTlTSExNZ1NQ?=
 =?utf-8?B?TnhTUGVBdVI5ZTZxazZhUmkyV2Y2NmRmbEc3NFBabEhneFNvWWh0ZlVINmhX?=
 =?utf-8?B?MDJnWFBzR28wVXJuaFhvTTRlUzRpdStHVGpubmY2Sk1WUDZHd3lndlRMNEt5?=
 =?utf-8?B?V0dKekNrZ1JhZDd6QUtiQWVXSGVERllHZHpDeDNhZDhuTEE3dXVRZ1B3VzU0?=
 =?utf-8?B?eDBrbkR2OHVSYnNKZG1xWWFEVzlXRzJyYUQxQWpVUnllQkJuTk85ek9LN1ZU?=
 =?utf-8?B?NEtiVjQvOHNpck9va3doaE1UaWRtTFlleVl0R1FOYjN3K1BZcDdiYWM2WGt0?=
 =?utf-8?B?bGF0VWY1VEx2VXRzU0F6S2xWOGZHaWdjdHppb0QzUHZwazBweU9DRVU4N1RD?=
 =?utf-8?B?SlA3enJYOXRIN1RXMTU2Q3RZU0dRTTFKN2tuMFYxaTJwcSticCs5enhVcFhO?=
 =?utf-8?B?RUhoWmhkVm51N3h0a28rVFo0Z1NvdFAwaFc2QnU1UXltMjUvY1VFdjA4cHhq?=
 =?utf-8?B?Z2dDWWU2MU9qTUM2RUM3Ym12RVdXdTFMa2loS0pGVGpxZU4xaHlvMW1YdTlF?=
 =?utf-8?B?c1V4dTdKZzVpb0NtL1Awczc0Skg1UWVrWVlXL0NXY2RTZmNmazlNVkhGZnN5?=
 =?utf-8?B?TDM0VW04aHg2YkQ3Qjh6OFI5VVVxQ3NIbUlkVnhFTkVKOXkwMjczSkprZURM?=
 =?utf-8?B?U1EvY3p2RDZEK3ZBcGc5M3EraHhESEVXa3dmOGNTcS9jUjhIUmxURStBUFk1?=
 =?utf-8?B?WEFhSXNhbnlyY2czbDB6dDgzUE5tUkJJbVhiRWF3T3JoQnFVaktnOGJwNkdE?=
 =?utf-8?B?Mi9GRFB3SjJGYmpMSWVldjdqODR6MThXOCtJMGdpWWVIakdmY0xiZXFRckxj?=
 =?utf-8?B?QjRrYktuajE4WHp0b3ZNRlc4L0NEVnNXclh0c3R4eVY0SXU1UTNGVlY4WU1F?=
 =?utf-8?B?VVpjR0t0SGdCUWs5d2NOVGhwdVRxL2hod25SSHFqanN1K0h5cDQvUlNKZEtB?=
 =?utf-8?B?U2lHLzRBMWFQWE9yZW1qV3U2V3RtOGlLYzZIMEpKeWtFS1VtRGpBYXlpR0or?=
 =?utf-8?B?a1JxS0l6dHo5MkI3MU5Ubm1nQUtha0w5MGJydDFEdUovYnpieTArSWRzUVJl?=
 =?utf-8?B?akFabjAxQ0lCcXRzN0dTdjlpRmpCUGJSdStYcG01Z01iL0o5ckFmbjZ2Yy9F?=
 =?utf-8?B?SUI4d0llemlvMmdMWUhINllyUUh1akpvR1BIT3ZQR2h5VlRDVXlKNTlicDdE?=
 =?utf-8?B?R3NtYXJUaDVvTVJCSkp6MzIranhRcHZBNjhpUzFNSHdacm93WnU1MVdwS29B?=
 =?utf-8?B?Wm4wT1gyOC9WUndyUmJUd1hIRUdYY2lqa0M0bHJ6bXBwVS9sVStKLytPRFVw?=
 =?utf-8?B?eERzSjkwdWdBYVlncHptZUp1OG9IYmQ0Mk1aZGRUT3VVUEFXWUV6ME43T08w?=
 =?utf-8?B?TUVrRGVuMUZTU0t3U28rMjMyRFhLeFBvbjdGWlljN1JiYVJlcWZiUFlUSS9T?=
 =?utf-8?Q?GSiHIVyOhPi8nrsTJ3Fv6iiQR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbf10bf-ca71-4eac-4c04-08dc17f4c938
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:12:09.8090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdtpB+Snjgx6wgp9BN49Wu1xA67F5BlacyG3NqwmTk/1tyGm64N9hsyYfVpZEK3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
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



On 1/18/2024 1:05 PM, Lazar, Lijo wrote:
> On 1/18/2024 7:54 AM, Ma, Jun wrote:
>> Hi Lijo,
>>
>> On 1/17/2024 5:41 PM, Lazar, Lijo wrote:
>>> On 1/17/2024 2:22 PM, Ma Jun wrote:
>>>> The power source flag should be updated when
>>>> [1] System receives an interrupt indicating that the power source
>>>> has changed.
>>>> [2] System resumes from suspend or runtime suspend
>>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>>>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>>>>    3 files changed, 18 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index c16703868e5c..e16d22e30a8a 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -24,6 +24,7 @@
>>>>    
>>>>    #include <linux/firmware.h>
>>>>    #include <linux/pci.h>
>>>> +#include <linux/power_supply.h>
>>>>    #include <linux/reboot.h>
>>>>    
>>>>    #include "amdgpu.h"
>>>> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>>>>    	return smu_set_config_table(smu, &adev->pm.config_table);
>>>>    }
>>>>    
>>>> +static void smu_update_power_source(struct amdgpu_device *adev)
>>>> +{
>>>> +	if (power_supply_is_system_supplied() > 0)
>>>> +		adev->pm.ac_power = true;
>>>> +	else
>>>> +		adev->pm.ac_power = false;
>>>> +
>>>> +	if (is_support_sw_smu(adev))
>>>> +		smu_set_ac_dc(adev->powerplay.pp_handle);
>>>> +}
>>>> +
>>>>    static int smu_late_init(void *handle)
>>>>    {
>>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>>>>    	 * handle the switch automatically. Driver involvement
>>>>    	 * is unnecessary.
>>>>    	 */
>>>> -	if (!smu->dc_controlled_by_gpio) {
>>>> -		ret = smu_set_power_source(smu,
>>>> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>>>> -					   SMU_POWER_SOURCE_DC);
>>>> -		if (ret) {
>>>> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
>>>> -				adev->pm.ac_power ? "AC" : "DC");
>>>> -			return ret;
>>>> -		}
>>>> -	}
>>>
>>> For this part of the change - driver already updates FW with the initial
>>> detected power state or the last detected power state before going for
>>> suspend. Isn't that good enough?
>>>
>>
>> The power source may change during system suspend, so it's necessary to detect the
>> power source again before system reads the power related data, such as max_power_limit.
>>
> 
> Ok. For dGPUs, then refresh of power state after resume will be required 
> in GPIO controlled case also. Since FW is reloaded, FW may not detect it 
> as a power source change.
> 
> Rather than creating another wrapper function, it is simpler to do 
> something like
> 	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> 	ret = smu_set_ac_dc(smu);

Ok, will fix this in v2.

Regards,
Ma Jun
> 
> Thanks,
> Lijo
> 
>> Regards,
>> Ma Jun
>>
>>
>>> Thanks,
>>> Lijo
>>>
>>>> +	if (!smu->dc_controlled_by_gpio)
>>>> +		smu_update_power_source(adev);
>>>>    
>>>>    	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>>>    	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>> index 2e7f8d5cfc28..8047150fddd4 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>>>    			case 0x3:
>>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>>    				schedule_work(&smu->interrupt_work);
>>>> +				adev->pm.ac_power = true;
>>>>    				break;
>>>>    			case 0x4:
>>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>>    				schedule_work(&smu->interrupt_work);
>>>> +				adev->pm.ac_power = false;
>>>>    				break;
>>>>    			case 0x7:
>>>>    				/*
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>> index 771a3d457c33..c486182ff275 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>>>    			case 0x3:
>>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>>> +				adev->pm.ac_power = true;
>>>>    				break;
>>>>    			case 0x4:
>>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>>> +				adev->pm.ac_power = false;
>>>>    				break;
>>>>    			case 0x7:
>>>>    				/*
>>>
> 
