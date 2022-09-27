Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670DCC6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5931B10E94A;
	Tue, 27 Sep 2022 14:00:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513CA10E94A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hETTcB5LIPiLO3Sdk3OKf4s6ms1LlA9ZYYvqE3mitHCR6TR75XkMbvdBHznTOVqfLdJKkNylcUAVXgMpOa/a+ZjkckUiWPWRSEhS9tFb2bOOhHux0kLVioUOXcZjAcidsAaRHXehxugteK60/WKgLbJ9HhlTC4jDa9Pw+QbG/8Cg1zMxrYD3Poi2dyHPDkHVaD/T3XSiLuFsgyK+Da/L7ZikseWy7or6qbvQWP+lxfgvCo3Meib4FxDgHFLftt9y13qg193S9gGSSiCzgc7/Dun5EX/qLMuy9eXcw6UinY4Kl4TWRzhdzpxdxdZKeNQdrqgVGTug0j5rY8ookfOQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6jmYs1Rm/vYTwvZupTpoh/WMYoVZQiVh6bLOH3K4Vw=;
 b=XWLh6c2baiX84/ATMfRzRNOWsFWPMLowTl1hoUqpHg+EZuGwhT9xnma3y01H2imNOY0KnX5oB6DfR3sF45PPM0UQmw+H34RTmW+LmjNBg4ib32jWk+oRLppoHLnG3eCe1S7R/vdyumVIEhb6hjNMN60F6BAFrcA8I3wQlVx6a0HW8lWVbXgIxXN+tBmIxfxgZC9Q+nGT/fB0eKsw1Pxd00ND+69KxMxKq9/Ar1FAUwuLNqx/qkLuJ3QPq2sEW9kTUbcb1tVyni6HynkakT8bT2qN7WcNwKr9UqIM71ei6cEK95jMtzJd9yMf7Sae6HF4HyxvbM0WbZWyiqWwa0jKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6jmYs1Rm/vYTwvZupTpoh/WMYoVZQiVh6bLOH3K4Vw=;
 b=yipNjKPn0mR5NXPLNkl43d6O54Og8eaz5luHiNRdg4PoriI0oXOz8KcCuXcfPspfNAP9Nj7KJp/IIB9hbePdq+AVbYdSqBEI3Yu8deKUcba5VKyaOxLWQUGe9U94FjffAfhz4clDoxjhRxTrwfTBNZeMC6rbXzrZ9ys8Uhrk3Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 14:00:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 14:00:43 +0000
Message-ID: <76175d88-be18-3ac7-536c-96ee527c5f95@amd.com>
Date: Tue, 27 Sep 2022 19:30:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
 <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
 <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
 <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
 <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
 <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
 <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
 <6dbc17c2-729b-e3de-1b94-4b800354e816@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <6dbc17c2-729b-e3de-1b94-4b800354e816@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3552b9a4-bc70-4af0-d100-08daa090ab1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5816Nhf7E018Ztu+mKl6ot/pBH7BdCFByGzF2BJy26wEEG4Yzp0THZPsACprWtqSXwiS6pvB4hcKoByCur0zXM0WMAQFmKOTWy5swQOaqOn1RRvo1ay3n9yP5l4ZTNfFk6BaCwHHd9jn77udNEPsFZdQiNrnCSdX6rmffywCb170xtOpbzDFcHlufnaxMFgFmgVplxijGtv3u4Tal0PlQTk4zONTe9P+iZlEhglokk1gq4/T2zlblpqrRc3bCqHcZkEwe7gqr3HPRLsvVZzhwAC5CMMpc4ZqOGelSEs65DExREgOiSRexjs/ff6XYRsvcDhJlLjIRCqPF3obAZSIm/ECI8+A0W9V7WtmXwTAnZIed3/KHwmereyuFQiW5agcHCLtfgEYnBSVLCbHZdIUo3dO1Sud9bHONvE/hnrhobojynsRbchvMG8kRKWn0CPQ23Wyz7C+VDaF2GcploWPdktSX98lT1ES5yDb5uN1ZdKUwomZWk9HH0+x+QmVwZLUYjSiY38TGDYhnfiObBzXa2jkvQRh3DHozqDjtetVrX+HROwDmOr+JgwjLJu/7Vx8BhfXm+hFUg6q6cMMG6MFhEpFMcUn5evxX/FUNT9w+2OIm3J5MPCBNbFoXwlUJFKkNcTVTbbCGHBCaXYHn1itlLB7gVWRJf+EqtwGGXH2oo9qEecHbgO/14cSI6Uwf0ycrs4+b4PKTCOBFDTcu2UtDWAHELISSpKnwcGQzan+43VK76LBogytzoAy6NbUBvdQuItiHxH0QGTF/Mbgzsr4wZjNfmBa8E3Ay7/DcggnFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(66899015)(31686004)(66476007)(2906002)(38100700002)(30864003)(86362001)(36756003)(66946007)(5660300002)(66556008)(8936002)(4326008)(83380400001)(6512007)(316002)(478600001)(41300700001)(8676002)(53546011)(6506007)(186003)(31696002)(2616005)(6666004)(6486002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDNvTi9UdGhPL3lSTFJTS2YrQ1dWcGNTWHg0Wlk4T2lWQzJBOWV4MCtyUEQx?=
 =?utf-8?B?a3hEaTZ0WnF4MWVpK1ZUdkFmQU1Dck95aVduMDhTMkEyMS9QMzI4K1RMYVpa?=
 =?utf-8?B?SXdxaTVBbFZwbVBDWTc1T2JEUC9oYWt1eG95RTJDYytTOUo2NG9IRS9BUUU2?=
 =?utf-8?B?VldmYlFJczlzTzhGTHRTYmF0TmlDREFGYXZHZHhkbUdDdDB1WTduV0dvKzFH?=
 =?utf-8?B?emRUdTFBcG5ERnZnMkF2b3FuaXByUytMZi9nR0hLN2NlOG53N2h6ckt4dy9v?=
 =?utf-8?B?c1RlWU5JQlgwSGxQVWIzaGpCb2FiY2xBak9tSzFEOEpaNVJoa0lOenp3Z1RR?=
 =?utf-8?B?dWZwSXE0TFVuOUtJc1RWRyttK0F4UTdjTmZBWnpVZmV1Z2hIMjNsY2xuUFVN?=
 =?utf-8?B?QzdJWGFScFVUMFFKbHJiT2pyYjBmSEdaUUIyeE5ROEFUZ3A1NW9aSDZtcVdI?=
 =?utf-8?B?T1RlWlhmZ2NOTnIzTmgraHFGZUgvejczUG5RNTVRbzBndUVLcXVOaldmRVpY?=
 =?utf-8?B?UUNZT05HSGFNekdoSjlzWGxzaWMyY2lJbm92UG45S1MzSHF3NnYydTFIN2c4?=
 =?utf-8?B?TVgxVmVYaUhxcXZDU1RIU1RFQkxjZTB2OUJKN0VmMytGMU5kcHV5blpLWW1L?=
 =?utf-8?B?ekFTVktUN0R6WHBkaGFNZHZEWktZUG5XNDB0SUc5cms4bHVqUjFoYTlac3c3?=
 =?utf-8?B?V25nWGkvL0dybDU4UTRXOUhzOUo5WVVTNXVyOHFFYmkxNEhZMFNUc2FiUkQy?=
 =?utf-8?B?QzI1RHlNK1NEa1FFV0k1bkdjSkRuVTVaVUJWQXF5K0ExbDBPa1hQbCtMaGU1?=
 =?utf-8?B?ZlVQVkZOM3FBRmNYaFFTVExFWTNOaEVPUmZoUXcvSTEzMXEweUx3VlF5RnBH?=
 =?utf-8?B?WG1OSWNWV2JXVTFFditmUlRnRG1sMno2T0VlNVh5UlZlUUZDNWZldGxxVFly?=
 =?utf-8?B?Zm1rVlFzcHZNR3pPTFlHS0V2d0lDRHdxbFk2clRFZ1VHRkV1dlZtc2VmTHpP?=
 =?utf-8?B?ZTNYckU3Z1N1ODFrSkt2RytsSzlHV2loZEhyRkdnRVppd2hDTkFaZXlzYWJO?=
 =?utf-8?B?S1R6Qkp3QUJCNmxPL3QxazcrQU1ldlN5bUtSUDRsS3VQWHE1ZHNEa2xNNVQy?=
 =?utf-8?B?MzFMQ01uRk83QXNMTjFJRUhHSlEvV2k1QzdyRkFJWE9ZYVB0RXIvdUZWVUEw?=
 =?utf-8?B?YzU2SHVOeTNMWHBGV0VlZGdpSkdKSEJXUFdqTmJoTjJOditha3NBbVRzcS85?=
 =?utf-8?B?OG12WkFxWU9xeERWdS8wUlpuQXh3M09Uc2MyTno3TXlwZWgzOXhsMXczN1ZU?=
 =?utf-8?B?TmhWRnFNSkgva2NuNWMyelQ0ZnhMRFhqVWc5amFqbFBlNUE3S2ZNMm9pK2Qr?=
 =?utf-8?B?dFl5SEI1akozV3VCME05bW5tRExjMEpzMXVsMzYycEowWFk5bTdha09rTFVW?=
 =?utf-8?B?NDlMSG9tMFBhK0plK1lENDNISDFka1I5WjFYTFR5WGMxeTNVV05wRHhGTExp?=
 =?utf-8?B?dWlRM3orUTZLOXJrVXNmL0ZNVEw2eENtRE50QjZLOWlOTzdrWFVGVWtVbFdR?=
 =?utf-8?B?MVMyLzhqcDlWMWJYdXBGWGRpVTgxVGxQQVUyZ3JFT0RWNTM4MkI5Z1RMYmZW?=
 =?utf-8?B?RlQrVWhuanZlZW80cUR2NlZyaGVQN0NVUHJGQ2RPaTV0eS9FMncrQm4rRC9l?=
 =?utf-8?B?TWNrL2dxbitRTnE4TktiS0tJT1pRTkxMVnFBeENhYmpVQ0UyNGZoTE8yczA4?=
 =?utf-8?B?Zkx1Q09ybkloQ3F5OFNCSHhvY29qK0JUNlhxWVhWT0ZkUWYyKzVqZ0VYY1hI?=
 =?utf-8?B?V3RnNWdPMVdlTVEweThEU1JmNHp1djNhOEtMNlQxNXpGR1puYXFhQXZ5MHBF?=
 =?utf-8?B?Y25oRExaWUFzM0oxTEZJQ2dEUmY1N3h4OWl2dU8xTWNQak5sZVdmYmZ1Tm5o?=
 =?utf-8?B?MGFqWlJIQjlwczBoVUhBS0hZMitYOEFiMWptS043TVRMMi9ERU1xVGhPdjNZ?=
 =?utf-8?B?eWc0djl4eHBSaUl6TXU5SGlSMEN5SnRjU3NJQkdPSzJ4a09EQ3FpcUM1aWpw?=
 =?utf-8?B?T3ZUOHBMSkxaZklKU29Yc0pJUjhpY09yVFcyVm4zQVJGMjZTQ2tEd0tnR3pl?=
 =?utf-8?Q?KPmDQYfdLS7rTQxUwAX/pATSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3552b9a4-bc70-4af0-d100-08daa090ab1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:00:43.5726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB5uxyf0zvv4GxlSORsMLOH1zPD7GJXcf0vyNmLyPfwP6R1tTwQvm9cAQ7CXCRll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 7:17 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 3:29 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>>>> This patch adds new functions which will allow a user to
>>>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>>>> flag.
>>>>>>>>>
>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>>>   create mode 100644 
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>   create mode 100644 
>>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>>>>> amdgpu_pll.o \
>>>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>>>>> amdgpu_virt.o \
>>>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..a11cf29bc388
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>> @@ -0,0 +1,97 @@
>>>>>>>>> +/*
>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>> + *
>>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>>> obtaining a
>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>> (the "Software"),
>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>> without limitation
>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>> distribute, sublicense,
>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>> to whom the
>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>> conditions:
>>>>>>>>> + *
>>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>>> be included in
>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>> + *
>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>> MERCHANTABILITY,
>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>> NO EVENT SHALL
>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>>> OTHERWISE,
>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>>> THE USE OR
>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +#include <drm/drm.h>
>>>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>> +
>>>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>>>> +{
>>>>>>>>> +    switch (hint) {
>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>>>> +    default:
>>>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>>>> +
>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>>>> +    }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>> +                uint32_t hint)
>>>>>>>>> +{
>>>>>>>>> +    int ret = 0;
>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>> +
>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>
>>>>>>>> If it's all about pm subsystem variable accesses, this API 
>>>>>>>> should rather be inside amd/pm subsystem. No need to expose the 
>>>>>>>> variable outside pm subsytem. Also currently all amdgpu_dpm* 
>>>>>>>> calls are protected under one mutex. Then this extra lock won't 
>>>>>>>> be needed.
>>>>>>>>
>>>>>>>
>>>>>>> This is tricky, this is not all about PM subsystem. Note that the 
>>>>>>> job management and scheduling is handled into amdgpu_ctx, so the 
>>>>>>> workload hint is set in context_management API. The API is 
>>>>>>> consumed when the job is actually run from amdgpu_run() layer. So 
>>>>>>> its a joint interface between context and PM.
>>>>>>>
>>>>>>
>>>>>> If you take out amdgpu_workload_to_power_profile() line, 
>>>>>> everything else looks to touch only pm variables/functions. 
>>>>>
>>>>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>>>>> profile. And going by that logic, this whole code was kept in the 
>>>>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. 
>>>>> So to avoid these conflicts and having a new file is a better idea.
>>>>>
>>>>> You could still keep a
>>>>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>>>>> mutex can be avoided as well.
>>>>>>
>>>>> The lock also protects pm.workload_mode writes.
>>>>>
>>>>>>>>> +
>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>> +        goto unlock;
>>>>>>>>> +
>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>>>> +    if (!ret)
>>>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>>>
>>>>>>>> Why is this reference kept? The swtiching happens inside a lock 
>>>>>>>> and there is already a check not to switch if the hint matches 
>>>>>>>> with current workload.
>>>>>>>>
>>>>>>>
>>>>>>> This reference is kept so that we would not reset the PM mode to 
>>>>>>> DEFAULT when some other context has switched the PP mode. If you 
>>>>>>> see the 4th patch, the PM mode will be changed when the job in 
>>>>>>> that context is run, and a pm_reset function will be scheduled 
>>>>>>> when the job is done. But in between if another job from another 
>>>>>>> context has changed the PM mode, the refrence count will prevent 
>>>>>>> us from resetting the PM mode.
>>>>>>>
>>>>>>
>>>>>> This helps only if multiple jobs request the same mode. If they 
>>>>>> request different modes, then this is not helping much.
>>>>>
>>>>> No that's certainly not the case. It's a counter, whose aim is to 
>>>>> allow a PP reset only when the counter is 0. Do note that the 
>>>>> reset() happens only in the job_free_cb(), which gets schedule 
>>>>> later. If this counter is not zero, which means another work has 
>>>>> changed the profile in between, and we should not reset it.
>>>>>
>>>>>>
>>>>>> It could be useful to profile some apps assuming it has exclusive 
>>>>>> access.
>>>>>>
>>>>>> However, in general, the API is not reliable from a user point as 
>>>>>> the mode requested can be overridden by some other job. Then a 
>>>>>> better thing to do is to document that and avoid the extra stuff 
>>>>>> around it.
>>>>>>
>>>>> As I mentioned before, like any PM feature, the benefits can be 
>>>>> seen only while running consistant workloads for long time. I an 
>>>>> still add a doc note in the UAPI page.
>>>>>
>>>>
>>>>
>>>> a) What is the goal of the API? Is it guaranteeing the job to run 
>>>> under a workprofile mode or something else?
>>>
>>> No, it does not guarentee anything. If you see the cover letter, it 
>>> just provides an interface to an app to submit workload under a power 
>>> profile which can be more suitable for its workload type. As I 
>>> mentioned, it could be very useful for many scenarios like fullscreen 
>>> 3D / fullscreen MM scenarios. It could also allow a 
>>> system-gfx-manager to shift load balance towards one type of 
>>> workload. There are many applications, once the UAPI is in place.
>>>
>>>>
>>>> b) If it's to guarantee work profile mode, does it really guarantee 
>>>> that - the answer is NO when some other job is running. It may or 
>>>> may not work is the answer.
>>>>
>>>> c) What is the difference between one job resetting the profile mode 
>>>> to NONE vs another job change the mode to say VIDEO when the 
>>>> original request is for COMPUTE? While that is the case, what is the 
>>>> use of any sort of 'pseudo-protection' other than running some code 
>>>> to do extra lock/unlock stuff.
>>>>
>>>
>>> Your understanding of protection is wrong here. There is 
>>> intentionally no protection for a job changing another job's set 
>>> workload profile, coz in that was we will end up 
>>> seriazling/bottlenecking workload submission until PM profile is 
>>> ready to be changed, which takes away benefit of having multiple 
>>> queues of parallel submission.
>>>
>>> The protection provided by the ref counter is to avoid the clearing 
>>> of the profile (to NONE), while another workload is in execution. The 
>>> difference between NONE and VIDEO is still that NONE is the default 
>>> profile without any fine tuning, and VIDEO is still fine tuned for 
>>> VIDEO type of workloads.
>>>
>>
>> Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);
>>
>> The line that follows is amdgpu_dpm_switch_power_profile() - this one 
>> will allow only single client use- two jobs won't be able to switch at 
>> the same time. All *dpm* APIs are protected like that.
>>
> 
> this also protects the pm.workload_mode variable which is being set 
> after the amdgpu_dpm_switch_power_profile call is successful here:
> adev->pm.workload_mode = hint;
> 
>> Protection 2 is - ref counter.
>>
>> It helps only in this kind of scenario when two jobs requested the 
>> same mode successively -
>>      Job 1 requested compute
>>      Job 2 requested compute
>>      Job 1 ends (doesnt't reset)
>>
>> Scenario - 2
>>      Job 1 requested compute
>>      Job 2 requested compute
>>      Job 3 requested 3D
>>      Job 1 ends (doesnt't reset, it continues in 3D)
>>
>> In this mixed scenario case, I would say NONE is much more optimized 
>> as it's under FW control. Actually, it does much more fine tuning 
>> because of its background data collection.
>>
> 
> 
> It helps in mixed scenarios as well, consider this scenario:
> Job 1 requests: 3D
> Job 2 requests: Media

Ok, let's take this as the example.

Protection case :

Job 1 requests: 3D => adev->pm.workload_mode = 3D; and protected by 
mutex_lock(&adev->pm.smu_workload_lock)

Jobe 2 requests  => adev->pm.workload_mode = Media;

What is the use of this variable then? Two jobs can come at different 
times and change it independently? Any use in keeping this?

Some other job came in and changed to some other value. So, what is the 
use of this lock finally?

Use case:

Job 1 requests: 3D
Job 2 requests: Media

Job 1 now runs under Media. What is achieved considering the intent of 
the API and extra CPU cycles run to protect nothing?

Thanks,
Lijo

> Job 1 finishes, but job 2 is ongoing
> Job 1 calls reset(), but checks the counter is non-zero and doesn't reset
> 
> So the media workload continues in Media mode, not None.
> 
> - Shashank
> 
>>> In the end, *again* the actual benefit comes when consistant workload 
>>> is submitted for a long time, like fullscreen 3D game playback, 
>>> fullscreen Video movie playback, and so on.
>>>
>>
>> "only under consistent", doesn't justify any software protection 
>> logic. Again, if the workload is consistent most likely PMFW could be 
>> managing it better.
>>
>> Thanks,
>> Lijo
>>
>>> - Shashank
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> - Shashank
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> - Shashank
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +unlock:
>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>> +                  uint32_t hint)
>>>>>>>>> +{
>>>>>>>>> +    int ret = 0;
>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>> +
>>>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    /* Do not reset GPU power profile if another reset is 
>>>>>>>>> coming */
>>>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>> +
>>>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>>>> +        goto unlock;
>>>>>>>>> +
>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>>>> +    if (!ret)
>>>>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>>>> +
>>>>>>>>> +unlock:
>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct 
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>> @@ -0,0 +1,54 @@
>>>>>>>>> +/*
>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>> + *
>>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>>> obtaining a
>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>> (the "Software"),
>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>> without limitation
>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>> distribute, sublicense,
>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>> to whom the
>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>> conditions:
>>>>>>>>> + *
>>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>>> be included in
>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>> + *
>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>> MERCHANTABILITY,
>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>> NO EVENT SHALL
>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>>> OTHERWISE,
>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>>> THE USE OR
>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>>> +#include "amdgpu.h"
>>>>>>>>> +
>>>>>>>>> +/* Workload mode names */
>>>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>>>> +    "None",
>>>>>>>>> +    "3D",
>>>>>>>>> +    "Video",
>>>>>>>>> +    "VR",
>>>>>>>>> +    "Compute",
>>>>>>>>> +    "Unknown",
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +static inline const
>>>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>>>> +{
>>>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>>>> +        return 
>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>>>> +
>>>>>>>>> +    return 
>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>> +                uint32_t hint);
>>>>>>>>> +
>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>> +                uint32_t hint);
>>>>>>>>> +
>>>>>>>>> +#endif
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>>>> +    /* SMU workload mode */
>>>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>>>> +    uint32_t workload_mode;
>>>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>>>> +
>>>>>>>>>       struct config_table_setting config_table;
>>>>>>>>>       /* runtime mode */
>>>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>>>
