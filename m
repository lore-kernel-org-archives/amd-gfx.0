Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87D8C47DAF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 01:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC9710E8DB;
	Fri, 19 Jan 2024 01:55:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B1F10E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 01:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEdZSWBkEgyj0fDY7yhWyBVrL3zAuTBkqd9aNLcEhjd+flkrIBhc6GNARnrdyOfkRzPB2H8rI0omO04RB1njC6PLHdJa8BaAiyaWkrFdWoreyQvTGlG2xfGRJWwTYtLP9eB6hIpopJfyNVv/0v7AdW/feMBFa1mu3JagydEB01cUvOtrK/j8q2XGo6aOsf1OOmL47+v4UZg1VQErBZMMr6Xhy9/gdKOwXeqV4heQcsJtMvGssn8ZPDKZXaPLaJnHGl8uYQM8EhrsBwrhvYZ9SSDJBChQ1b0jwnP4nJeyWo6YmT+5pVDxfhzBCDrIkbnVLvP3xKsa9SX8i4Eg61um6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1mitX2eTfk+kMWnU8XLC5UImiIUc6UwH9i7slnUvNc=;
 b=JCt4aWqEczJIwDI3gsoE25uswq3ko8yaCXpXtDw3Q2Lcu51FcyOiQPAyVX22LMWRGpsDlnYNrowqRLd/s3iUaZFltjoMrBajg3bhZxz4QZplgNGWxD5de8OZk9zJIpMBqVRCAPsxehdiGMe52l/sd34X7zFBVtM/iZy9bcSWYwqJqB8I7D9SJvzQJjKHnC6io3kdGnc2Hj3HwDpm5Cb4EhU+8tOhhKtyDiewuMwPvvucelF71br/fzTd6Oxc8O94LqOoA5GVOjYPQDoJUm0nhabFvInh9wt2J57Jb05g3+jISpVLWi6nTvgE1wMRphjV2s37GNejePaXpZqNx5gbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1mitX2eTfk+kMWnU8XLC5UImiIUc6UwH9i7slnUvNc=;
 b=fCEBMAnFNzWE1WXfjPXkApQFc5Qh1qPCExTIzvVhRZIBV0elkyQWNZZslGP/Dbgg9WOp2Abz6GSEANUEW1goTxLiHSldTcNWQujfYNOu59Chb80LBjkzW3JEfpLE7OkqVL3fxqS8MxxlA4lVTH1yUEFx+vnH6OkzFtehrzHiOKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 01:55:07 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::831c:60ba:97df:9720%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 01:55:07 +0000
Message-ID: <f051eb1a-feb3-494d-9380-362a751c0f1d@amd.com>
Date: Fri, 19 Jan 2024 09:54:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240118072742.999070-1-Jun.Ma2@amd.com>
 <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
 <234bcb1d-afa7-49ae-8524-2d81b283b2aa@amd.com>
 <27424290-d360-448e-9476-85c5eece6b4d@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <27424290-d360-448e-9476-85c5eece6b4d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ac4bbd-e7ce-4292-5044-08dc1891a998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/rHwOGJSTbIeCxhM5lbLl8vPwddLnA3M/4YbDJpoSPQZwqkaV51UtTtg4rZNkXiU/tU8OJn+dXZD8l4vjmuOc9iGFkvvIOL5QbVcH5wpbKimz7eBuP/ITehAXxXuR5XhOpqjWXx8Bbpj/RcYeJ6ErojYPCxPG7Rd5ws3JTsyIYZ/VGjs+nz3ZIiByY4TMrdYC6yHuG0JihehZRFYd/oTCzfd8LHYIU2105nQdBm4W1jqbR0XzGx74+bE5yzFqjvGaqFia4hGr9o063I8eA0GTF+qBGnDCU6BYFTFrnuj5CYa/cG+OTm8DzN/fCF5kN6kaT+eVUSW0wdkGIsMHJK1Zxx/4PVUPE65KYpwRRksTz7M2Awt8Pfc4RzyocbeMCB/+0aRvAem2ChD1UqUJurJyMA2+r4QcZrHxa8Z2POD9tTL9iFcUW6a2kkMZQm5TzHkToFBEvoUgZ840EX/TgrRwmm3YLGj91O01mMTUdHjc9fv2Imo1CfC6mJclHRDlrUhhmwHG2JM9JXfz4/StFBocNJO1ess/pHKpVSbe/EEUpYGrFoUXmOcSBJwKKNuN/3iJw3HB1wEt6J8dHZXloLVwbDiB/e+85I+h5MNM2rQjG4fsgezu95FQzczz/RKMTlGiZpGGZXPZTItDfXmPOKWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(38100700002)(5660300002)(6486002)(2616005)(26005)(31696002)(31686004)(36756003)(6506007)(41300700001)(83380400001)(110136005)(66476007)(66946007)(316002)(66556008)(6512007)(53546011)(4326008)(478600001)(6666004)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1M0Z0RWNjdxNm56YUJaUno4eGFBUFlQMlM5cENFQTlnM1FaK0YzbTl4RUxP?=
 =?utf-8?B?RVBBemlwQThzSFV6MHNsblNndFZMWWNtL3pFclljUzNiaEIrbzYwbUZLYkxu?=
 =?utf-8?B?Znlla1pEVTVpU2JaMFhwSFdENVBCSmx0Vld5OXBkU1hpZmRXYlc5SktaS0xE?=
 =?utf-8?B?S2NMVTFzL3JXb09ka3ZraVMwallmYUFKU2FRT1dTalArZFFEQVd1SW5uV0ww?=
 =?utf-8?B?Yk5IOUFDcWZQTmNORCtXNU5IbWYwOFRxU2NJNC8yMGNId0pkOWlRRkt2OVY3?=
 =?utf-8?B?bnErK3VJVzZyMnFkT1NLWDZOTERGbmtwRjBNL3pjRTZiTUVjeFFCYUhyZEU4?=
 =?utf-8?B?QU0yNnhYeCttWTRoTS9mUHRqSXo3dlNaYUZrZGpmM2xNQWk1NDJublkrLytB?=
 =?utf-8?B?NHVCZ2VKUU1mSktmOXVzTkt0RStFSy9UQTZ6WUpYeUo5dzkvMUJlY01EcXJh?=
 =?utf-8?B?YWZ1TGIxZXVacWYrdVBuaWQwWkZqdEtLUW9YOFNUS2kxQ0srRlFTdGZSWi95?=
 =?utf-8?B?N3pFSXJITkZtdGFXREp3a0JpTllGU1BqdE8zaDFOZFdIeE5ONEs5cFJuRFFF?=
 =?utf-8?B?Qk9JUjRJTkRsMWxWMjZpV0FzWWxFSWZEQXNsdmtzSjJ3dHRKajh3WklxdEFz?=
 =?utf-8?B?STlCK0REYUhQUms1QWlzcjBUZzRXVUFwUXFxdWk1Q0gvY1RxRGtxOWZlSzJy?=
 =?utf-8?B?Yk5ITVF4S280Rnc3Ulkrd1cvclo0Q3ZZWFZSZWtJWkIzQTFQK04vbkZZUkxz?=
 =?utf-8?B?d1QzbmJ2R1pzYytwdUQ4cmY0aU8yUDhYcFhEQkJSN0VPUXZaU001Ky9GNlZr?=
 =?utf-8?B?ZTg3V0N4aGlJVjRJMWJ4OE9TdWRYdjh6d2s3QWlzYkRtcDBZUE5BK1ZUUytm?=
 =?utf-8?B?MDA4QUpHUjZVVnRSSjh4SFo0WWZRajhSRG5TcVlnb3BLNDl2ZUxzQ1ZZS1F5?=
 =?utf-8?B?QjhkemZEQk1UUGd0ay9UK0RMRWRkaU9WZzFCTWR5R2x3ZE9HbWlHYlg0MWVO?=
 =?utf-8?B?UklHM0o3TUVFOUlla3ZKMmVUdU91QS9GUmpuaGI3blJRSVBUd28zcUZyUGZk?=
 =?utf-8?B?b1VZNGFtd0N3VG5YK0E0REZHMCtWR01JcVZiMkpuNUx5OW54bGkvb2ttWTZx?=
 =?utf-8?B?RjVlWTZYVzM2WjUxV29UMldJVEpJR2VRYm02SnZmQTNiZ2lVUUVGV0dQY0M4?=
 =?utf-8?B?a0l2ZFlhSjFheCtQYVc5cDBFVmlkSjMzcnFhNlRreTlIWng1QU5nQXFSOXY1?=
 =?utf-8?B?YjRzV1FSQ25udFRzSCtnVUhLSUZQcXFCcnQ0d1JuOUV6Yk42Z2FkZk9GVC9B?=
 =?utf-8?B?emtlQk4rTGIxNWh6UnRqdHhMMzlQYzRDckxCOWZZdVk1bkpaa2hrQTNEZDVZ?=
 =?utf-8?B?M2tjREhYU2hxQSt1amUxUE1qUTFnV2NDclBPRTM2TDJrWXZDZU5tNVQvdXVw?=
 =?utf-8?B?c2RxbnFIMWxONVNsOGVuYUNKYllUdW5ZL2lEUnIrMU9pT1B6cXh0QTdpcU9h?=
 =?utf-8?B?L1puYUtIWnBnWk1aUXNzelZZRW9zUWRrL2lJSVN6Ym84eWhWVGwzU1gvYUlk?=
 =?utf-8?B?S1dkbDRSSGdZMzhwQVlITUJqTEdtalF5RDhkem5mZFV1WjJZUlZpOG81bURw?=
 =?utf-8?B?eU5WYjFuY3J1SUgzU2liOGZ3ZmRSSXNxa210UVVxeGhtZUhHRS9xdlNxNVVO?=
 =?utf-8?B?NG8wTGNnZTJXRldOeW95ZnBnV05ZcEtPZGl0SVNQOGNJc1BYNllmMEIxa0xF?=
 =?utf-8?B?aGFUQmdock1zRERLdDRxSFJrWkZ1c2piTlFQcTdwVkE0RnhxOVhiUkhLMW1o?=
 =?utf-8?B?aXhyN1AxenFUYjF1VUM5bm5xTG1oaTBES1dDNGY2K1RJTCtJTFowcEtpekZo?=
 =?utf-8?B?bWk4ajc3RzJCZC9IODVYcGJHemJXN2dRejdzM0E4Y1JhdDdyQ3MvQTluUDQ0?=
 =?utf-8?B?bDJmK2doelJ0Zkg5V1Vza1VBQWdKcGZCemlSb1lLd0w0TWpwMW1xOXkyaHZ1?=
 =?utf-8?B?MkU3MFF3K0pCS0hhblhWdjluMjBnbHdiTWlQWnNZcWMzMnEyRnFnVTZ1U3lV?=
 =?utf-8?B?QWxNMWl1d3JhMkhPUjBVb3Y1cTRwWFhmTUc3bVgvVGRrSVhJNC9hbTVPWWt0?=
 =?utf-8?Q?W9bF1P41SFS5gimunkiJJnDEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ac4bbd-e7ce-4292-5044-08dc1891a998
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 01:55:07.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veb4vRi7AzjA91r94DAl/NijlCU241z6CVmBPj5N/W3+vVXZiCw5MzBU5nf3gELg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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

On 1/18/2024 5:24 PM, Lazar, Lijo wrote:
> On 1/18/2024 2:31 PM, Ma, Jun wrote:
>>
>>
>> On 1/18/2024 4:38 PM, Lazar, Lijo wrote:
>>> On 1/18/2024 12:57 PM, Ma Jun wrote:
>>>> The power source flag should be updated when
>>>> [1] System receives an interrupt indicating that the power source
>>>> has changed.
>>>> [2] System resumes from suspend or runtime suspend
>>>>
>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
>>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
>>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
>>>>    3 files changed, 7 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index c16703868e5c..a54663f2e2ab 100644
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
>>>> @@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
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
>>>> +	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>> +	smu_set_ac_dc(smu);
>>>
>>> In the older logic, driver initialization/resume fails if the message
>>> fails. This one doesn't care about the return value. Is there a reason
>>> to ignore and continue?
>>
>> I think printing an error message in smu_set_ac_dc() is enough,
>> and stopping the driver initialization/resume seems a bit excessive.
>>
> 
> FW not responding to a message usually means FW is not in a good state 
> which could later affect the system anyway. Since there are other FW 
> interactions after this probably ignoring this is fine.
> 
> BTW, what is the issue seen after resume when power source is not set 
> correctly? If that issue creates real problems, then it's worth 
> considering keeping the FW informed about the real power source, and 
> fail if it doesn't succeed.
> 
I didn't see any serious problems, the only problem is we may read incorrect
power related data values because of wrong ac_power value.

Regards,
Ma Jun
> Thanks,
> Lijo
> 
>> Regards,
>> Ma Jun
>>>
>>> Thanks,
>>> Lijo
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
