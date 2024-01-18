Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CCC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 09:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF5610E179;
	Thu, 18 Jan 2024 09:01:47 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C977610E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 09:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHNNOqjZ95UyfKpybcyHPm0YNvuy0uz4KxbV9TEyb+eiod9rZ9O1Jzm1uv0RQ195ZRPBw3u4R+yoPPE8wLJxOAkvVzlnm3M18EvHOR0Q10Be62V3F9AJ3a68y9nPEpOs4oSHtD8d6hKqPw+/wynhTAU6zOijpaYrfGhnTqgyRH0jUh/slsqotGHDzlhjUe9/rWpJdfBTd7KYRiGsoC1YvPNTvWomsFoNGS5OMF4wGiIgGLvl+/ZtiXmxZNC1c574R6VDs9JxkOyfAnvCRymlfTl/uGxNW9Dx9XsZGC8pakq8J3ykJBmIHI5eQFEcIUTKU0JXZK//0cwh3HmuJWBGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iq0poyjYqHhbVJ57rnOjVcPWMxMQLdfrRb231zOvcI=;
 b=Ol4YF3/rlu1C92pJTOTw52qt2z9P713KytFJsGQAIskLDPCUnaPJy9jnI65NO4kIWmnn7XPLesDABHwQQZ9DmiZk819TvvTBcNnSL8Yv6elNZEK4+LXCN55M5vWn/+SWgDLmsjjFYh1trM2Jt5AlR/zIJgZOuGuZH265o9mRx/F+YdqnbMbURoFBu3Ue86gPuv4PBwjvwdy4bcY8VLWvs9p4qt/ScUCTB/Ptpo+jjFATwtVuIJRba3vzSMw4jZje4L1z8okS2B9qt0d89mpyr9GIGuwL/e/nX4AZYunfuzoHbwmR+/KXlmq8saMUIYkvGMrPTJA4cbypp3hWdld0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iq0poyjYqHhbVJ57rnOjVcPWMxMQLdfrRb231zOvcI=;
 b=SqhzVT2pf+gxbOgU0uAQ8eHLNAe2F+QrXZAyIrEtc6/R3eS2Vp9M208FRgcEgL9agWFr3qljsGJxTlcJfqna6hLxP4FwYDKBhDzwZJCj0UpIlvlXapwXAMFPvk3LEdvcH3T80AVUm9N+20twxHq5akpvH/lckseR6jPwROGVXTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 09:01:41 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 09:01:40 +0000
Message-ID: <234bcb1d-afa7-49ae-8524-2d81b283b2aa@amd.com>
Date: Thu, 18 Jan 2024 17:01:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240118072742.999070-1-Jun.Ma2@amd.com>
 <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 476cf129-54a6-4aa0-60c3-08dc18041577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTfSLya2CKmCFqoVhnFeeckJKDlABNoslar9pdmJjAuKVeCRWVINcwbndie+eay0qoq1CUdGBnuhNl2tBXjnC9SPDpq4rMiGUkKhQ754NlJ3b/qHW8eCmI33ewOac7aM6znpVMSr3LaEME99fKeA3pZmvmc300KyLuVhtqe7syq1X2HcOca5DxnVZAkYXHcss16jcIKSNUzLPM9HEt0Xb8zvywuJozcPE2aOGzwBYoMk9ojLU+ZMda9KeqyxCSpLLPfCkPObBEGM3++ALCaj9lgB2XUmmwGA+mOW7BWIann2vnx/X4GKDLBwkLh+WVPKq/YeqAEgwNbI1OW9/JR3bjT1gf0OpCQpVqe3tcdwPjeFGy+m4fAzoE4byt+xxh4sy1yI3ZAgoK8ZWohDDwTRzZKuIKxPCzdQlbYbK5LsXReSu7axJ7aD72D1VZgmtYcmkrjOE14NgjDKLX6aDG6xoV7i29ZicAdoFR79DG/9oHbt+J8VkSivOFF17yvep6Fx2SyHsqqEgCO4WFiSo+GXigul5+82ZKdbcOCd0Tg+Fpis9V4EdtzADO+ndApPlSMWjUUUmukJMGbSV2XnTEj7Gt4SjhO4gIskR2JtaXkX28rBypSDygnFen0AZorcFz6N18GcdN82XqhHlDROKgm+kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4326008)(8936002)(2616005)(26005)(66476007)(110136005)(5660300002)(2906002)(66946007)(31696002)(36756003)(66556008)(6486002)(316002)(31686004)(8676002)(6512007)(6506007)(53546011)(478600001)(6666004)(41300700001)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJpRE1IQ0p5SjlIRStLR0ZvVnU3M3VJaXZNUjYyT1NMU01TV0I2aEh4T1lM?=
 =?utf-8?B?VEltdHQ5Z2NjY2hIYzRsL0pjRlZVMEtpaWVRMkc0OTBhY1BUWVQxNEVnSWlJ?=
 =?utf-8?B?K2lmYnVJUStYZ2ozTm5ubVJOQkRPSE40ZHBtY2h4U0IxWm90RTYxMXZGSkxx?=
 =?utf-8?B?WWZGOWgrMmxPcjNtY1JxTGRvVnp3YzE2aE83cnU3TjdoSHJTMEg4bjAzL0Nz?=
 =?utf-8?B?aFRzckxQaUtzclpvL1lWSkxMMllRTERVOGIyd2JiNExISVd5TWNPZjBYS1Zq?=
 =?utf-8?B?YWlYNHN4NndKUDIxb3QyS0Fuc2t4NC9IN1ZQclRDclRMLy9HU3oyc0xJSTZP?=
 =?utf-8?B?dEFWOTlYdU0vU0V5OUJqeE45TXdqRU1wQkV2ZmhSb1RtTVdETVdxbldITnFo?=
 =?utf-8?B?b1RISlVDdjk5ZFNhMk1UbFd3NjhIVUROSGtrWTl5Y0lpVWQrMGdhV3NnRmlJ?=
 =?utf-8?B?SDdFQTV5dHRTOFZNdkN6T3BIQUxMWHZlMCtTU0ZHZlVTeHVFVldtRVRWRWdM?=
 =?utf-8?B?REFwV3RGNUhXMk9IWGtXYTlocmtZUGhFTUJqakV3dWJVTUZyYUtPNlh1RnF4?=
 =?utf-8?B?c0Vac0hVcFJNQ3FyL25UTVBEMUpsT3pmNnpjQTVteTRsYXV6b2diVVJ5Qmts?=
 =?utf-8?B?SXFudjVwaGh5ckpLNU1ZN3VvSExOTUNXVy9PbWx1SHBHU29oYlZHWkRSL3Nl?=
 =?utf-8?B?ejdDVkhWNE5qZUIvRS91OURvbVJoV0FwOWNXa0ExTERIbXlsNzRsd3cwQ3Zj?=
 =?utf-8?B?K2JWTkhHVVV3N2Ixd3c3SVV1Y2J3LytwQjZ2bXR6czlvWmZnZTRmeHZBYVhX?=
 =?utf-8?B?S1VONDBUaGVCaGFHZnBLV3BxWEx2eUZKQ3ZSdmR1b25EUnZaZHZXSXNHWG5N?=
 =?utf-8?B?S3pObVUvQmEwVlhFZUJjVEVtM2lmSURTQ0gxanpXZlJKMloyRTNvSTlSVWJv?=
 =?utf-8?B?Z3lwbmJ4aHJTTWRyNEJLMjZrcExaUUlDQWVmZ2lkc2FEdFlLa1dGbE05WTRy?=
 =?utf-8?B?MDdXakRCMmk4Rzh1QzdFRS9TR0s2anRnT2NQVjJLTzVFT25mbjFTdDlTQnZZ?=
 =?utf-8?B?WUhsVWJYQmlXK2JqZFdkSlVQVUxKcDU2UEs0T0o2REdvVU9qSkd3TEJGRlov?=
 =?utf-8?B?SE5mL3ZiQjdsTytSazZjOFVDRGExQ3NOTG5EM0VKRU9oL1g1TGxTTlR6RCtk?=
 =?utf-8?B?eGJtRzgvMkFPNjZJQVc3SmFNek5nSkNwVGtuQUtPOWg1bVBlZ1QvQkVGQkFK?=
 =?utf-8?B?eEZmb2JqYlNyOTQxVGZOTzBrWHJuUkVsSEtTSzN3UElTZkVYRUdrNHprbktm?=
 =?utf-8?B?OWtRbS8yNi9nUjl3NEhRM1JUeWpoNWdIMWdVNmZSRFd0Y0FCdmI1MDF0d2pM?=
 =?utf-8?B?QWg4UG11VlcxNFRPQ05WWnZHN1owdU5xNWQ1dnVQRVRpRnl6K1VLYWV3Z0Jm?=
 =?utf-8?B?VEZMdjgvei9nLzNreURyd3hjbHZ4U3ViRjVnWVR1dm81eWZ3MTlJNzFiMDAz?=
 =?utf-8?B?Wk1Cd0E2U0ZnQlBBRUs5cmt3Sno1VEhDZlZONHN5OWhLazN2amNYL2lqaW5n?=
 =?utf-8?B?Z2RhRVdpNSs3TlZ6V3ljK05uS1ZuMzZJbDR1TS9hY3FINHQ1NkVielljaXlU?=
 =?utf-8?B?Rzgza3gwVm9rbFNuSlBkMTlKa3JGQklwWnVoblVQTmpOQm50K0hCdzVjMWNQ?=
 =?utf-8?B?Q1NWcVUzNHZockRiVUthSEU1alp6RjEwQ243bXlDeWM0MXB5LzFObUFzSEtY?=
 =?utf-8?B?a0NJWmlRVHgyVDdjQ1EzSTN3RndUdmJGNmNyT2d6WnpyVGpJa0lrUEwvUkxD?=
 =?utf-8?B?R3FmNno2MDI0Ujh4aGcwRDZyZ2JaRXU0SlFkNmtnNGdoeHJya2FsS2hLQmV5?=
 =?utf-8?B?WjUxVFBrSUIvWW5MajRMeGRCc3djandpT0hpWjJaRHNuZm1YMmdLckt5SjhK?=
 =?utf-8?B?YzE2TWxEUXdKMlFvczVPZVA5QWp1UVZqSzVMZkN1SUhGNHdzdlpUeVpRZjA0?=
 =?utf-8?B?aHdBc2V6WXo5ZWJsZkFlbWlET3dRWjYwVVkxMmJYVmlSZmV6YWR6NTZ0OG5K?=
 =?utf-8?B?bWNHWnN0aHlEdDlkTk90cy9aNWtYMWFlVmY1STFxRkJ6WmNWNW52ZGtRWnJ6?=
 =?utf-8?Q?7+DY8wVwIvnAxyhz7l7HafDoT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476cf129-54a6-4aa0-60c3-08dc18041577
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:01:40.2065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6c+YPFbgsUwv1fenSBJMzgZtWCk0uKUFqN39473fKUXOc5uFb3yKYH8nzWf3nmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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



On 1/18/2024 4:38 PM, Lazar, Lijo wrote:
> On 1/18/2024 12:57 PM, Ma Jun wrote:
>> The power source flag should be updated when
>> [1] System receives an interrupt indicating that the power source
>> has changed.
>> [2] System resumes from suspend or runtime suspend
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
>>   3 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index c16703868e5c..a54663f2e2ab 100644
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
>> @@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
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
>> +	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>> +	smu_set_ac_dc(smu);
> 
> In the older logic, driver initialization/resume fails if the message 
> fails. This one doesn't care about the return value. Is there a reason 
> to ignore and continue?

I think printing an error message in smu_set_ac_dc() is enough, 
and stopping the driver initialization/resume seems a bit excessive.

Regards,
Ma Jun
> 
> Thanks,
> Lijo
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
