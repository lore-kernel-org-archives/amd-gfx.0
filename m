Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A28C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 09:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CBA10E75F;
	Thu, 18 Jan 2024 09:25:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8062F10E75E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 09:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd6QHFIUUI3uJ6YuPAZNJSn0MhcZpbvN2M/ShG+yhj5G8di8FkpDvDEmvyWoYYhHPjDKFXjjTkMVIlHqAk0/9g8geEZR0y8rMToAxYeV6kaaSeKa3uMjahP5byug+90COVbZlPfnlZPHkk/v8Wv+RsUJrCqTutqKw6CdLEbKpFJ4h+IkP2p5Tzja5wO2AciFLuhxYYy+amD2OPncHOEQu5bJvTJNVxglzhSXOaBJOTun93ELVbvD5O3Xn+I9V3225DYH1c4zk9ckalD4AbJKsJ0E1toJ2OeA4kAzkm48Osvp01z0Gr/gtfxVCRIDm3X9lmdKtqvyZWG6vKzP+w4uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NXDIz6AwvjVdr6iNR6efowJhQqBVThaAQr92eeDPUE=;
 b=m9qESsgojv+ZyZ4IW6+0A6flFSA6TfSktzxn0WBdhu7K2n8eHQBVUgBdj5SHM9dCE93Qp11SM73D9HxM1+8GHvoANqMNZmrYYYieLq7OsII5MGmBgxtrX+yS21SH4v69oSuvAjtBO72rLcjpNlTK6JlC6EpbpyD1wjeygmZE5Kn99wbMFRoNFU4kfJ8uC1CPNfZvFP+yQo3ueqdKtQw14vBH2FequVKFQCJm0yNOKIpPlIcYItalyhZ3CSKqqSr+CDM/HVe8HGwJboxdubpLPUzMl5eF042MheDcdwt0+K1UKR3rGwbusEHI8i2Q1T1zC/26tv6Mro0oT0HdafCZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NXDIz6AwvjVdr6iNR6efowJhQqBVThaAQr92eeDPUE=;
 b=XwOTKHD5TiEEDnxIZIXSngWcFs/s3lJtv89uvez9tHkqS734VgR9sgdce4q/1gUsmH1Y7F/tK75uUkjT+gn9Ltp+MoMgVimueyME/yMGscxFHFjtqh8aYfVPjhgeJunGXS4clJ3CmSYQS/Ink+CG7ImSYVFRRw98YHGR74lZ/18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 09:24:55 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 09:24:55 +0000
Message-ID: <27424290-d360-448e-9476-85c5eece6b4d@amd.com>
Date: Thu, 18 Jan 2024 14:54:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240118072742.999070-1-Jun.Ma2@amd.com>
 <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
 <234bcb1d-afa7-49ae-8524-2d81b283b2aa@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <234bcb1d-afa7-49ae-8524-2d81b283b2aa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: a797cc40-a9bc-4a98-3d3e-08dc1807550f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M57OFPtTt85vZxWggwmHA7n+V10ikVSy+vHM0E2riau6AvjI497B3/HKj90M9L7PWB1B9/dzze33UUuxheyaL0FPZ3IKlRFGVUI++zdjcwX1opp1NcHJ6vOhLvDITNMbGIvYokNMrh4QD9XMPCLEIA/Od2hMtfF4oKfLRcGgriTBpkeKzJbXlr94g4OCJEbhVPTnOoUC5t6BjxCj+XtV+TdufijijOmz2sH4F4RXehranjkTBndcp17OHlmZn36ZJYSoOfPZLnWqW/A9e4FMY+MAiBsBBd+toniKbyG4UxvERUX6f3T1VIhFOChSCPJR42nWuTm3ph5XZqPbCcTMenU1dojhwo2RP/Uz+HbEpyNGGfgL85pp3cjOfD2pYif4iugrI5qqK9eoeShj2fgQJiRn7P3BY8yHHn7SdGIHUpJhXtdqnU3qsnRvqazYDj74MA/l29FFJnTnE8YsJMuDDvr/QnX2RdIHjNct5qFtKyz6PBVWdLoFccy+dgFEMgLcrSnlKnTw9vlM9dd6C1M6TiGa47wekEjCKkZiddKJO65QqdOXNx2RfpXi8LXO3l4YPBCaXfFJbFSf+etU/PEN1blPpZQ2Jgi4G0jsRPq1TcVA8oySlzg81mNw6R9LhCdbu84Hf0zzBlRJfnQF7pCxIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(38100700002)(83380400001)(31696002)(86362001)(36756003)(6486002)(110136005)(316002)(66476007)(66556008)(66946007)(2906002)(8676002)(8936002)(4326008)(5660300002)(26005)(2616005)(6506007)(53546011)(6512007)(478600001)(6666004)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZiYy9PbFI3ZnJwQ2k0VVJZK0JjSGxic1l5aUFpTjJCK1VZOWFHQVAxZFZh?=
 =?utf-8?B?eXplM1puNHdyZ29CQytTT29Gc1BpWDgzaTRQRnVjclkzbXJwVVJMSmM3NFRM?=
 =?utf-8?B?Y1d3cXEzcklsajYxZkM3MlJtcWpMRXZrblBVTjJnVTduMWxTQWdURitWR0Y1?=
 =?utf-8?B?US9xc3hKVHFOUU8vV0dSMGkxR0NodzM5TDNPU1poWUM3czN3YTlVNjdYRTl5?=
 =?utf-8?B?VDVaT2lJOG1Cd2lxejVtVkVRc2lYVS92MmZKYm1zdXMweG1LYm1jdGQrcVRl?=
 =?utf-8?B?R0h1K2lzaHMxZmRNUjNJZW9zajYvVTdQSldpcTNDQXVFZXVxSjFINTF2M2R6?=
 =?utf-8?B?cThFNkxkY3hjVnM5emJnSmU2QlpOdWlmc0VXSGlkK1NRcEQ3Q3ZLaFhxZnJj?=
 =?utf-8?B?RnFNejZZUWsyNEdicEZmT2tFY2pBWTFGZDA1Y3gwZTQ0SUk0SW5nTklpdmI2?=
 =?utf-8?B?OFVlaHBhUzdLMWt1M2ZaTVVZaXRFT3VLSE9PZitCTFpINnJscndwREtuYUd1?=
 =?utf-8?B?V0pFMjVtYmVDbm4rajYwckpKdWpjSXVlQTJSd3RBSE9wRGdxRWZIRzUzMm9L?=
 =?utf-8?B?K3dtOHgzdnJReUxjekltOVZ5VEsvNFBCOTNuV3drV2swMGU3Y1UxQm10c3Ix?=
 =?utf-8?B?NC8zeGtvTUUxS3ovUlZQSXVjNjZnRWxRY0M5VjRDOXVMa2IvUUFGYVdEd1NI?=
 =?utf-8?B?eStmRzdRLzNLSi9IeGdrVUxWZS90Y3ZzVlBkSFlEcjF0c2RFR3VJOHVZeDFG?=
 =?utf-8?B?ei9qS0ZJaTVobGFUbXNsZjR2QVZieFFpTDBaZ2xuZDFvSjdMUFF6blJKM20w?=
 =?utf-8?B?R3JkV2o0b3p6aURUaXZ3bVRMdHNGZ0VON3pnem5kM0dDYWhYam5zY1N2cTY5?=
 =?utf-8?B?bi9COGdWRXVyKzF5OGFFeGoxUkZMUTBldXRCRzBkcmpIWDhiNzNnMDRFUlpG?=
 =?utf-8?B?d2FqNHExd0Y1VXZNQTVVNVFYTmhCZWw5ZVdqazd3dWhCZXd5THVsTnVVeStB?=
 =?utf-8?B?ZnhkeXZEZFVTK0RBbzJDVi9ObmVkTnZIeEQvUHhMZTI2YlhsanRGb1ZFYkR4?=
 =?utf-8?B?Y0Mzc3JHT1dJR1F3bitVa01tTm5rMDRvUlhLTCtJOVh1ZFJROEVXTzc5bTlH?=
 =?utf-8?B?YmYrV2FPazVadFFnSjJkWXUxdlNpKzd0R0FDeFVxd1h2S0R6b2ttbWdPN2hy?=
 =?utf-8?B?OUVMZWFuSlF6OEoya2llM2xPcGgxeGp5ZzFGK3lQZFJrQm9MeUN4cnVaQXQ3?=
 =?utf-8?B?aVZHUDJEOFFNbzdoWlB4enJKVUU1alEvdTQ5NHEvMGl0cEJVbi8yV0dxYWRY?=
 =?utf-8?B?R0pwNGJoZzg5RVpwdUw5ZFR2d3ZSdGNnYzREY1Y1U3FpUUhURTY1bVh0ZDJp?=
 =?utf-8?B?RUtrbU4zdjNYTjhSc3NIblFDQVcxTkhpNG1TMzlibDZSNm15bWdXc2YrOEo5?=
 =?utf-8?B?ZDV0U0dkTE9JWXNYUWliNlN3Q3V6NVdEMldMWGlzd0FCU2NuRnUyRkdvc0Mx?=
 =?utf-8?B?SG5CeFpSUmdJTWtEeVJrek5kTmxadGZPcDlRdCtDL0I1TURiTjR3VHdTbzZ3?=
 =?utf-8?B?RGtGaVQ0b2IreXgxcUVkV21najNubTFyd25sRFJTMXVOSGJXUE5tSzFvRTJq?=
 =?utf-8?B?djFjdU9vVm81dXRLOGMvcy9nbnB3RHgzRTFjTjNpVXdacnY1NHlxRDBITEhT?=
 =?utf-8?B?YUxzRkErcTNuejNkT0Iraks5R3ptZmhObkxEcE5TVkIvWUpmaWRDZkVBL2Zk?=
 =?utf-8?B?d1JDcDVkcDd6SnBZbkNwY3hqWGRTWE9ubmxMVlB1dzRMa1dibzFwY0ZpRGs2?=
 =?utf-8?B?bUVtTUJMYnA3ZXN1QVNRMDVXaWtrSWZ2VmFJRWhyY2tVZyttcE1ydTFLSE4y?=
 =?utf-8?B?UUR4dVoxSC9GN3I5WUpuclhjZVd4alJmbnppdHZwbzZheFRnNkpMQ0xMcUhZ?=
 =?utf-8?B?dUZPRk9mb1BNcFJRSG9hRmlqOUw0TUlLbmdLK2cvMnc2a2tRK2hvZzEzSFk5?=
 =?utf-8?B?LzBXY3VrSUVwMVYyYnE2aXhmVDJDRGpXdVdNNHk0V1VvWE9ZWlIwekI4R0J0?=
 =?utf-8?B?dWc1L2lmQ2VydmVwSzlJbTZla0IvZnpKK0NOcGJTNDlhSnFmcXROUHJmTWxP?=
 =?utf-8?Q?f+sKvHhypEM9fM4UJ8EkZvvsU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a797cc40-a9bc-4a98-3d3e-08dc1807550f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:24:55.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtZtLYIAEoqwXPuBhzq376tnZzvVwIwwb/Ql31XMEWmnoSOAzRcW1m9hJp4XLJy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

On 1/18/2024 2:31 PM, Ma, Jun wrote:
> 
> 
> On 1/18/2024 4:38 PM, Lazar, Lijo wrote:
>> On 1/18/2024 12:57 PM, Ma Jun wrote:
>>> The power source flag should be updated when
>>> [1] System receives an interrupt indicating that the power source
>>> has changed.
>>> [2] System resumes from suspend or runtime suspend
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
>>>    3 files changed, 7 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index c16703868e5c..a54663f2e2ab 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -24,6 +24,7 @@
>>>    
>>>    #include <linux/firmware.h>
>>>    #include <linux/pci.h>
>>> +#include <linux/power_supply.h>
>>>    #include <linux/reboot.h>
>>>    
>>>    #include "amdgpu.h"
>>> @@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
>>>    	 * handle the switch automatically. Driver involvement
>>>    	 * is unnecessary.
>>>    	 */
>>> -	if (!smu->dc_controlled_by_gpio) {
>>> -		ret = smu_set_power_source(smu,
>>> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>>> -					   SMU_POWER_SOURCE_DC);
>>> -		if (ret) {
>>> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
>>> -				adev->pm.ac_power ? "AC" : "DC");
>>> -			return ret;
>>> -		}
>>> -	}
>>> +	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>> +	smu_set_ac_dc(smu);
>>
>> In the older logic, driver initialization/resume fails if the message
>> fails. This one doesn't care about the return value. Is there a reason
>> to ignore and continue?
> 
> I think printing an error message in smu_set_ac_dc() is enough,
> and stopping the driver initialization/resume seems a bit excessive.
> 

FW not responding to a message usually means FW is not in a good state 
which could later affect the system anyway. Since there are other FW 
interactions after this probably ignoring this is fine.

BTW, what is the issue seen after resume when power source is not set 
correctly? If that issue creates real problems, then it's worth 
considering keeping the FW informed about the real power source, and 
fail if it doesn't succeed.

Thanks,
Lijo

> Regards,
> Ma Jun
>>
>> Thanks,
>> Lijo
>>>    
>>>    	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>>    	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index 2e7f8d5cfc28..8047150fddd4 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>>    			case 0x3:
>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>    				schedule_work(&smu->interrupt_work);
>>> +				adev->pm.ac_power = true;
>>>    				break;
>>>    			case 0x4:
>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>    				schedule_work(&smu->interrupt_work);
>>> +				adev->pm.ac_power = false;
>>>    				break;
>>>    			case 0x7:
>>>    				/*
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 771a3d457c33..c486182ff275 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>>    			case 0x3:
>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>> +				adev->pm.ac_power = true;
>>>    				break;
>>>    			case 0x4:
>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>> +				adev->pm.ac_power = false;
>>>    				break;
>>>    			case 0x7:
>>>    				/*
>>

