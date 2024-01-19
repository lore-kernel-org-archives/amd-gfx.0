Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18DBC4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 04:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361D610E7E3;
	Fri, 19 Jan 2024 04:31:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DDC10E7E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 04:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNzdjQp4Xhjd4m4F7CCWSbrpmbYLtuoVpJhQzHh6F/2WnOMLtC5TMi45TYLypK9Ln5QGLL16TnXeI41GAUwXgvVm20P3hfD1D3tuMcSOtRrcn4c8ra8lvMN8/hP8ai3oaV8IDQ4X/KJpUP3ipopCpkq3+PPPK6/jDe5NDjIUjg7rUcYCKE3YsDVVlKv2niLstaKeJW/fU8OoUqm0u6c0I65LshYcoMQxVx9pMRvyqalhGYWNHHLYV3AV/1QQiyXQpHe7uqJzAttQW0+CSpUznU48eLmT8RUk5ITHBU7T3Xspzkcc6FhsG+3fxT3jif65bWWOc+YujAJMteXLEg9Dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS6gaJQUqVwPcnIxsSng2rfnFIyu8ZGTiLycM/aK+7M=;
 b=Xq9PtX7IIxaQmJn82Iuy2UqDIP0vD32COUmQ9TU0/dmYcTqSkIrhLpGEkt5vE0VwvADadZ7IVmQXOl/PNPhTjGRT75ZZdM0IrQVqKRV6KOfSAONvrflmR8x39a6L3FBglkLgYMvQWpt/QCwTLwzffyK8CHshepAKGE4azCUHjlzHr7sou0B/DJsLeTb9a6AkWFwevqMhQGIxr74FVMzjBB7XnfIIl+MzRaz9eBDNyuzyQtJb3g11q/3FlY8RV9EI9ewzqaMs8iBOntbynpUMxE/0aMQpQJYpl3LRoAw8HVV8nis4bC4Fe5ZsOrZQVHYJTcKQwjZ+2h3yPQ0bICG2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS6gaJQUqVwPcnIxsSng2rfnFIyu8ZGTiLycM/aK+7M=;
 b=lLHbWtg2Vn7LK4iyaIUpdMGjo3hw6tIbqD1vo++hbyqN3ItuoKW8FCajK8X25V47/WemcG7fcNOMRP5QBwEXEuAiL0Bq+kVhP47o8IQlv+9FvCl8M2GehJ5Xm6iNv5lnt0IuSN3VbtKvdVyjTtYYVbjhKDwmZA9kOKm7z+NgX0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Fri, 19 Jan
 2024 04:31:14 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Fri, 19 Jan 2024
 04:31:14 +0000
Message-ID: <8524def8-a97f-4b29-985e-a3261407006c@amd.com>
Date: Fri, 19 Jan 2024 10:01:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240118072742.999070-1-Jun.Ma2@amd.com>
 <00f5700d-84e0-4baf-accb-624d73004466@amd.com>
 <234bcb1d-afa7-49ae-8524-2d81b283b2aa@amd.com>
 <27424290-d360-448e-9476-85c5eece6b4d@amd.com>
 <f051eb1a-feb3-494d-9380-362a751c0f1d@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <f051eb1a-feb3-494d-9380-362a751c0f1d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a98f9a4-8c4b-4e6d-2d4a-08dc18a7783f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcmyMAK85xK3HixNDvXlEZpN7MMLvwGk5+d1H4wTSQ5K9+N05IgcuRJ8oshlPt8fb2Rn12W9y4mnl2qnAtu89DCLTpd94ulSI4ZOeMUefvdD1tLD1IWUyHS0WNZte1uPGaWdsZ9CW50HbcJ0AwCyaPU8P9aOux7KYIItj111ErHadHEHvlVDgKbHiAzlKiEIQo9ncn2tjam4uI+FWh1DIcGHaMHNdrJ5JXL+tyuRl2MVRp4TLTX7ZWeFcjMFWwwaoTeKXzJ+FOQqGrt3xr+rK7G0/HnkbKzSMP9JpVPdNJ+M3HACiFLB9pPIeJVe9GCWr+hz+1p2l1rJ/rKSlpA8We/+9M7fa7D+5KdJOUzpZ7BlnMZqRcOiRPMa2Fx72QP67RcZyvayOZ50XVaP++FNkQs6rtIqwG3oVzxjtWYgrcm5M13P1FDfLuHfkh5VplHfxoTRqS2fR9F1+ZAJZUdg0Xe+03BQNDht9iF5O5LuOyZG0XNndjnOS3mY8SopEpjwJ6pbdFcmq2uUf3MWXvookMw/zq9jFC7yxvtotQS86kok+HyhlSyaZto2GyAv0vXASgKNXq9t/sYfUaeJpHmyjlS89Phg+0nH+IFFXlp5gHosi6OYqO48ymBmTBN5YbcB69vthxhBFtvKsHMyPHhNuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(53546011)(2616005)(6506007)(26005)(478600001)(6512007)(83380400001)(8676002)(5660300002)(4326008)(41300700001)(8936002)(316002)(66556008)(66476007)(66946007)(6486002)(110136005)(2906002)(86362001)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjYxcndKSEQxT2pqSGIzMFZoQ0xXOVJyK0s2UXZXWGhZUjZDYy9RVEpRU01I?=
 =?utf-8?B?cWFycDhjeTdJSVJ4N3ZaNWNFYkp5M2pCcXJGQ2liczVsZW15c01XK0JDVEpB?=
 =?utf-8?B?T2srYklpanpzTnlxOVZONSt1ZkxlMXFJd0JCM1VPQU1jWjYrV1VwT05telYx?=
 =?utf-8?B?YzFYTFUyclhwdFVzNHNjZk1qaFBSTU84Rjk5a1V6T2FyOW5hd095dWVnTXpj?=
 =?utf-8?B?S3l1L2ZULzFOOVlHT3BXRGdBMWxiZTdIVy9UWHJ5MklDVXpmd0xWMnZabkNt?=
 =?utf-8?B?RnBWUTNoTXA0bjA1YVlJZGFTeEROa2hJM0JmQy9ZSmpyWlNqQXpaYnlRbWll?=
 =?utf-8?B?YURHdnlLTkZJRTM3WFlzSTR3MUk3REJ3MlJLVGN3aUVIZUJGd0w3VmRNcVEw?=
 =?utf-8?B?ZnovVFQwU1Z3Rmh1MXVDc1lvdStiVk1VWVl0eTNnRzlkbk9JVm5RMlNETjhS?=
 =?utf-8?B?bUdkU2QvM1VPazhlaUxrNGJNSk1XQm5BN2NoTlNMLzB5WTNQOUd0NXdjdHd3?=
 =?utf-8?B?SGZwanYvdlg1ckJZK2JyM25CUkVHRzlid2lXUVpPKysveVZQajNmVVhFalk3?=
 =?utf-8?B?Uy8yU2Zsdlhnd1JmVmkvS045UTVEU1dWZ2RYc0RFb1VRRVg2R0xFR2pQK2FM?=
 =?utf-8?B?aFAwenhtaEY2R3VPbU9rQmM5V3EwZmJGc09CZWNrL0lEUFdib1dQRXBzQTNt?=
 =?utf-8?B?YUxVKzY5NVBCZk1KTjVEdUxWYUZOMU0yZGhSVlloS2R3eng5Y3JHTm82cGhH?=
 =?utf-8?B?RmdTY2hkTVZCcjNWeko1elJ2eGNySUZOZk14M3lvN2NXVVFhK05TeDdVUjVi?=
 =?utf-8?B?dm00MDZRaUQyR3RVc1piQ0RXRHlvT09TdHlVc3ZBdHRZblRFbWw4bm5EZWph?=
 =?utf-8?B?V1JtOGNWNG9aRjNHKytzV3gxQnBXM0VUZWNRMTBqWFNpdGp3bnkyemxDWXdu?=
 =?utf-8?B?VDE5M2h1dm1SSEcrbG9QZlVWdzE1RTA2ZGR0ajN3OEtNTkd2c0twM3J6SmhR?=
 =?utf-8?B?SVN2QkVHZ1czbTJaSlllekMyamRoOVZVWmoySlJGSkw4WENnclM2VkE3a1M3?=
 =?utf-8?B?UjZSY0tYL2RuU0dvZ2twVFZkRDVvSzNZSFVnUk9rcXNEMWVNbWFSTjQzc0hr?=
 =?utf-8?B?SHdZZUZ6T0swRGJKeExBa3RhaEphSzdURG04eHlTZHV4VVhJSjZua2ZSQk0w?=
 =?utf-8?B?bXFWTE8xa3hoSVVHajk5QmtnRDkwYnJmZVdlakNFbllNeVdRMnRGeFFLSkpr?=
 =?utf-8?B?NHRtVVNVSE9OeGtYM1ZOZVhIVWpBSHFwTEQzK25IRWtCRTVRZms0TTcrS3NS?=
 =?utf-8?B?Kys0eDdOM1NRMm9meTJ6RlMyK0U0R3VNQ0szUE1DQUIwTDljN3l6ZVVDZHA4?=
 =?utf-8?B?Zkk4SzF2SG5uSkdCL1FJbit3VHdBTjVYbThTSGRjUjZKcVlaQVQxWUduYTlJ?=
 =?utf-8?B?MFBBazRrclBwRi9CYkE4OTZDVmNZdU93Ykl5QXNQTUlBdWxNZ2RkdjFLLzZl?=
 =?utf-8?B?WWE1ci9rUmlLcmxKaDFUaEFONmhpcDNHNHlSbnowUGxFbndyb29qL2llRSth?=
 =?utf-8?B?amdUOGRrbUJlQ2ZzZ051N0F4NDFGcTk3MTFmWGJVN3ZnODRFN0R3dnAyL0pH?=
 =?utf-8?B?RlFHc0Rlekp3eGhzSkZoMW9uYXNnSkRaZU83UkJjM04wOWpCL0drVVRSUTJ4?=
 =?utf-8?B?MGNaN1dyc2ZvWEJ5cHJhSmJoSDYxaEVuNDNzbnVtT3dNUTNNZTExb25RaldL?=
 =?utf-8?B?d21jeHBCb2FqRlZEVHhNdzNUcWtWQW5SUXE4NlFoQnNsTXpzWEx5aUhlaUIr?=
 =?utf-8?B?WVZWMWFCNk9OLzdKRWxhWm5mNklNODQvR25QNHJheWR4Q2pjeG5wbjZoSEIy?=
 =?utf-8?B?K0kxWitGcTZTMVJvN1RzS0kxT05pdnl5RTVZU3RiQVZERVZzb0ZCU29RcnF1?=
 =?utf-8?B?QWNHdHJlMUEyU295aDAzcTNJK0RKMXgybXhXalRFbXY2OEVmWVl6V1g4aCs3?=
 =?utf-8?B?SGVmUDF3R2FNaVkzUTFuOE01VjJwYitOK1ZaSWR6QUt4dUp3ZW1mcVR5bkVv?=
 =?utf-8?B?U3JackFtOGI2cUl3VWRuZVl0YkpiSU9BMVJDY012VVNCaEpTNXhXVEVkdkgr?=
 =?utf-8?Q?uRURHBZWu+NcjZcOjOwRenXw2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a98f9a4-8c4b-4e6d-2d4a-08dc18a7783f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 04:31:13.9892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4T4/6K05Smesna4a7n/HfBj3Y4RSL9lYeJ/6IMBeeiZxkWNS6nM7d4EYpbs6dVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

On 1/19/2024 7:24 AM, Ma, Jun wrote:
> Hi Lijo,
> 
> On 1/18/2024 5:24 PM, Lazar, Lijo wrote:
>> On 1/18/2024 2:31 PM, Ma, Jun wrote:
>>>
>>>
>>> On 1/18/2024 4:38 PM, Lazar, Lijo wrote:
>>>> On 1/18/2024 12:57 PM, Ma Jun wrote:
>>>>> The power source flag should be updated when
>>>>> [1] System receives an interrupt indicating that the power source
>>>>> has changed.
>>>>> [2] System resumes from suspend or runtime suspend
>>>>>
>>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 13 +++----------
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  2 ++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  2 ++
>>>>>     3 files changed, 7 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index c16703868e5c..a54663f2e2ab 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -24,6 +24,7 @@
>>>>>     
>>>>>     #include <linux/firmware.h>
>>>>>     #include <linux/pci.h>
>>>>> +#include <linux/power_supply.h>
>>>>>     #include <linux/reboot.h>
>>>>>     
>>>>>     #include "amdgpu.h"
>>>>> @@ -817,16 +818,8 @@ static int smu_late_init(void *handle)
>>>>>     	 * handle the switch automatically. Driver involvement
>>>>>     	 * is unnecessary.
>>>>>     	 */
>>>>> -	if (!smu->dc_controlled_by_gpio) {
>>>>> -		ret = smu_set_power_source(smu,
>>>>> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>>>>> -					   SMU_POWER_SOURCE_DC);
>>>>> -		if (ret) {
>>>>> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
>>>>> -				adev->pm.ac_power ? "AC" : "DC");
>>>>> -			return ret;
>>>>> -		}
>>>>> -	}
>>>>> +	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>>> +	smu_set_ac_dc(smu);
>>>>
>>>> In the older logic, driver initialization/resume fails if the message
>>>> fails. This one doesn't care about the return value. Is there a reason
>>>> to ignore and continue?
>>>
>>> I think printing an error message in smu_set_ac_dc() is enough,
>>> and stopping the driver initialization/resume seems a bit excessive.
>>>
>>
>> FW not responding to a message usually means FW is not in a good state
>> which could later affect the system anyway. Since there are other FW
>> interactions after this probably ignoring this is fine.
>>
>> BTW, what is the issue seen after resume when power source is not set
>> correctly? If that issue creates real problems, then it's worth
>> considering keeping the FW informed about the real power source, and
>> fail if it doesn't succeed.
>>
> I didn't see any serious problems, the only problem is we may read incorrect
> power related data values because of wrong ac_power value.
> 

Thanks for the clarification. Patch is

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Regards,
> Ma Jun
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Ma Jun
>>>>
>>>> Thanks,
>>>> Lijo
>>>>>     
>>>>>     	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>>>>     	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> index 2e7f8d5cfc28..8047150fddd4 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>>>>     			case 0x3:
>>>>>     				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>>>     				schedule_work(&smu->interrupt_work);
>>>>> +				adev->pm.ac_power = true;
>>>>>     				break;
>>>>>     			case 0x4:
>>>>>     				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>>>     				schedule_work(&smu->interrupt_work);
>>>>> +				adev->pm.ac_power = false;
>>>>>     				break;
>>>>>     			case 0x7:
>>>>>     				/*
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> index 771a3d457c33..c486182ff275 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>>>>     			case 0x3:
>>>>>     				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>>>     				smu_v13_0_ack_ac_dc_interrupt(smu);
>>>>> +				adev->pm.ac_power = true;
>>>>>     				break;
>>>>>     			case 0x4:
>>>>>     				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>>>     				smu_v13_0_ack_ac_dc_interrupt(smu);
>>>>> +				adev->pm.ac_power = false;
>>>>>     				break;
>>>>>     			case 0x7:
>>>>>     				/*
>>>>
>>

