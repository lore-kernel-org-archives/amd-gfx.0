Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493CDC6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B659E10E37D;
	Tue, 27 Sep 2022 14:34:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA1A10E37D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk8WbLc9eRrYQf23v1LlHdIymZoDWvx663IfQRlkwQVuThLXNdTY7Qk4fAkF6SreBdFCRLZaImVCGcl/x55X2m5YwzPAtbO0cFU/olGRGWkJFKh9EOoH+jifWOUgmurLzI1XzQ0FejdaVWqlBEV2fM4TvfA5C1h1l5jxkMRkqaDdlt6KaJVi/GiQjE82J9W4gdLUqbDJ2aqtzwT+pOg13u6YOj4ab9Gp8xU8nHTwR5o9uIN9IgRlL9ZcuQoVK931WCZNYdff4wyVcg1qT+iSBzzIPYkVvcZTCKNcbaDJIeiIUhtW7DCWAJHWUlko+sx+Amn3jPFhmmyHtUoHzn8GOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+23PWThtOrrK9OiWzkRvirWMqRjMTkzpMi8QvCtYQsk=;
 b=avpvsQLs5U5kEIPmin/CEy5JR7AHcunKdvrQg1g0HcpuDKyyXAHWdIkt1jd+Nz5ccJpYXPUfas5IEQJqsnWE0rN5xz5aTKAvPPKWQYQI94uRm5y6mHBVDryaJK0KCdzl/CxHl/0rOviRZ1GUMT7lNEToXYBDp5a1/rNNapuAIfoAOjF9JTaVdeSQF8z9pJx/OZq6Kve7uJ0AVKSE9DBflmD8jHuHbaombSID2qeg7i7pTcU9tRMpgRudmtqwcIL4+K2UbyRxwf1NI5JoujeiP4bfidpvpnpJ8tCvGlzb2Axss0lSKcyUXQ2UtnGWj5MeCdCa6bTjFPQEhRJBYTpFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+23PWThtOrrK9OiWzkRvirWMqRjMTkzpMi8QvCtYQsk=;
 b=VBqynbnpHP6Xa3rvaoW7Uce6TvJsVoPCIOyPrnK0ulYlvzyVmpH6P3wqr9xTF+/W4/FMCrCHeVbgTlkoJeLfpcitUl9GS/7eesT/72z9HCX3XvTZ9BU3okQ0XigE1qJLLFkEh/h+9Xdu9yWa+ftAZby+WZWfQvEOCFg/U+faacw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.24; Tue, 27 Sep 2022 14:34:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 14:34:48 +0000
Message-ID: <2c5263e5-c0c9-57db-83b9-eccda2292c14@amd.com>
Date: Tue, 27 Sep 2022 20:04:38 +0530
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
 <76175d88-be18-3ac7-536c-96ee527c5f95@amd.com>
 <38334f83-a4ad-2a53-543a-302d174950ae@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <38334f83-a4ad-2a53-543a-302d174950ae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: c489cb4b-5876-4691-ce7b-08daa0956e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdmKs653SWrGZm+Blf4KUYaO5YCLXajLd51Glh4Kl1D/BikVjzgI2HeWFvskXgq9ygSmLR06GLCCGd79DJccaJNOqC4HxKLumg4PMeGsSroaX1FOCXD2avdmGtCHeBuEuCTwjc/qu6xV5ncVcQ4aBkIKViYyOR6zcMYOPRTOqshwMblRNV1eGhAcXb9dBfuPxn2wmiQL1t5FaviHL+6kdZpiGkHwiyQH9curSIIbSAv19IEhmYVbN7X12crpcyHuY+Vt5qdcznKtwsX/yfAJ28MmRjgYIgy2SD1CGm8SBGnA9BiqBqiumA/MTi/pl0U3IFy/U0sbaVlYLfnAO5Efeo3zwULgLcTdhqifqn0r4ShNwAo+6tAVHJRF/Tvzml5EBzjBpkN/8b4NJvUqJLyjCIIl33XXwERtKOqf8zn8eXr1h55tvniD0EGUlnDtpA7xOdJwsrY3SakjbqKyLC93IF8wUoFQFCENZsBgDI0fXV0BORcUXLEwBOKFgnEfHdFW2cdEMU691vPnnZuu7ynhn5JO7sK+1qenCAOQSc/nlAtDTxB6wP/aiK3piAfRYGGyTvykwuKzw2/EEHvLtM+dmhMGmtKhSxYKDet0jhVHULhzwjR5qf+uTUpTRg6eMAgStxart9cP8IE9Ly3dP9BhTzHRzJHam1rFR6T/vwHSTbJiZv68rEPlkK0jB9JHhVZtMZrJyrIm6up57aUQN5eaQtiLcOOo5ASWUF3rXHQeoXEZrYZUPYv2egW9fOVgvlwfQkHFFM/L8wmLUnzdgei8fol0/9/Z/Ykn+W53bO6bV9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(30864003)(5660300002)(6512007)(6666004)(26005)(41300700001)(8936002)(53546011)(6506007)(36756003)(2906002)(83380400001)(38100700002)(186003)(316002)(6486002)(2616005)(31686004)(4326008)(66556008)(66476007)(66899015)(66946007)(478600001)(8676002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1JTDdPS21lN3pPWEtCV04vWWFHbGFiTU5nUWk2NlozR3J0d09jWUs0Mks4?=
 =?utf-8?B?RFJUeGpZVkdxN09GM2pRRTh2d0Q1TW5EeHBGdFpaaHRPNWdoazk0MG1tN1hD?=
 =?utf-8?B?cmdSZko1ZDVNRWQrd0ZtdUZoeGRsenl5ZG1CYzJPSjN4bnNwQWJsampzUzZ0?=
 =?utf-8?B?ZVlNY0hESDJJbDhTYkF3N0xlbXBaczdrU3NDT0VHckF0MVl1b09ZdnZadEdK?=
 =?utf-8?B?Y2dTMlUyY2RjRjkzK3JWekFvYjV5U1IyZTVaVWNDNWw0b1lWcitaaEl4MHg3?=
 =?utf-8?B?a1dUY0huZWw1cHR3d0s0cXZGbC8yRFZualdrTjJ6aVFLaTVGWGtVT1pJb0pJ?=
 =?utf-8?B?OEtCNnBQbHExTUFCbkhEd0kyNjFHT1NyaVNZSUFjOTF6QXR1WkRNOGd4ZzYy?=
 =?utf-8?B?ZExValNGTXVsNGtwK0dOdTRMVkk3c1Q4a001RWl5OHl4NDdnZG5kTkNjWUQw?=
 =?utf-8?B?eDRwQ0ltKzNYUVE4YzVBTHlvcndNZk5VY3lyNytEL0ZsRXJNaEVHSnFVZVJT?=
 =?utf-8?B?MG45UEFRQ291am9rcGZLK2hXdC9ZVzZhb0FrUXdJZzkwVWFLUWNuSkVaSlZu?=
 =?utf-8?B?TEd6bXFxWVFlR3p1dEo0dk1oTDdBSEJGeWN4UFVOcW5laFZ4djlyQzJGb2Zj?=
 =?utf-8?B?T1FtM3BhZnNjTUMzL2hRWTAwbXh0OTZ4cng1YVVlNDRnaDMyUHRxd0VvaWFC?=
 =?utf-8?B?c1JYdjFoUjIvRzR4b1REdmlPNk1HMGhEdlo1SFdIQU9NNEttZm03NS9aU3ZS?=
 =?utf-8?B?L1FZVnFZUFVQQUdxNHYrSVFKVFFiMTZQWStNT2JLMkR0WnpPRHJGMm53NVp2?=
 =?utf-8?B?OHV4M2dzd2ZVcXA2TmVhM1MxMlVwZ1UydmlSa1daTm9wUjV6dnJ0b3dtSnZH?=
 =?utf-8?B?M0xSRDF3SGZyU0hyenRVRTVLOVEvRVUycTd2K1lIays0aFpyNzBMRHlENmxZ?=
 =?utf-8?B?MmFEZmNzQlNYSlFmMnlSN2Z0SlBHNDhNZW9DTmduS0xhRkk0NFVycXptNDFn?=
 =?utf-8?B?cWJYRHY0azFWQ3d1Y2M0ekZXNTJjTUtMVy9GcHdwQ3FjTi93a29JcFp1Yy9W?=
 =?utf-8?B?cXRBUVAxWUNtVnB2YWVEdk9WQ0ZWMHFXYklpcEk1UjlMNXNlbzZ4bXc5VXpR?=
 =?utf-8?B?dHRwcFAwdk45czZOdVlJQ21pVHFXQW8wUGxoY0tyYzdvRVQvOEhQckJybnBE?=
 =?utf-8?B?cndROGRkV0tjM0tkRVZ2VGNrSUZiMUhrRHo3eHk1T0hmOVVYU09FdS9RK1Vn?=
 =?utf-8?B?cGJVNmlTckVOUUVWM2l2cXg4QjJqcHBvMUl0SEJWUnB0dEw2WDRkaTAwLy9V?=
 =?utf-8?B?b1RkMm5yYkpWRjd1SlROd0hYbE9xZlcxeUZyM1ZYSkxOS2krK0lCengyQ1lM?=
 =?utf-8?B?aGp4SWUwczc4L0J6RUVncFdwSENnSnMrT21yOEluVEFwVEw5UWhlZm9PMHBy?=
 =?utf-8?B?Y2RGWHlCNE5UWVBYZWRaYmZqWkZiZlJOUGJ2MWNsV2pUTHdYQnlJbHNid1NY?=
 =?utf-8?B?VEphNDJKOHJpR0FJRmlBNlUxYUdLd2ZNUVN4L3NKa0Fzd0lTSmZzMWhqbG5y?=
 =?utf-8?B?bFNNMXlSbjVyS1BFR3M5Tk80NVpsSVZqcFhML2hpdFB0ZUFKOENuelBodXZa?=
 =?utf-8?B?T25WVzIvY1l4bEhsSWZUd05GMmJXTUx1NDkxNUlLMWlhT0dIYVNST0lRb1Rl?=
 =?utf-8?B?eFhRMEtlbVlnL1phY3laUFI5UU40dFV6OEFRdW1ScGtxNWpNb3k4WXhoS1hy?=
 =?utf-8?B?KzA3S1R1akV5Y0cydVVwRk15bklTOTRnQ0V3UUVBRVdDTkxFWFNvRVlUbGsx?=
 =?utf-8?B?Q2g4emRWWGhXRWFvcStUcXNvUFJPMFE1d0xyL3NVUHhQQlJjQkxvRjcvLzZx?=
 =?utf-8?B?RmZJOXlmVWZ0SXFVQkI0OG1oUEhEaE9BWEg3S1FtQmdkNGJ3UVRGNTUyenlO?=
 =?utf-8?B?K0ovRnV5Z1FPVzJmM0l0L2ZVVU95ZU9BWWtVKzAvSitZb0MrUUw0WHZHa2dY?=
 =?utf-8?B?dHRUVjVyb0R2NWszeXRTVHQyS0l5NkQxSjVvSmhhSis5YVRzdmNBdFJNbjY1?=
 =?utf-8?B?ZWwva1NPb2NqNlEwK0pXWGhmTmlaN0doQVp1aUMyZTQrWSttS0FpeGM0eElN?=
 =?utf-8?Q?Z3+cp2Q+ltrVOeH7Bn3uow/S7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c489cb4b-5876-4691-ce7b-08daa0956e13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:34:48.7146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK9yWflB7+mgpRGMehQ6b+vNwUsa4mtJ6eTDKKj9slf7Mld3EGOJzv4p0USCOwLf
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 7:50 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 4:00 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 7:17 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/27/2022 3:29 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>>>>>> This patch adds new functions which will allow a user to
>>>>>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>>>>>> flag.
>>>>>>>>>>>
>>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>>>>>> +++++++++++++++++++
>>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>>>>>   create mode 100644 
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>>   create mode 100644 
>>>>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>>>>>>> amdgpu_pll.o \
>>>>>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>>>> amdgpu_sync.o \
>>>>>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>>>>>>> amdgpu_virt.o \
>>>>>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 000000000000..a11cf29bc388
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>> @@ -0,0 +1,97 @@
>>>>>>>>>>> +/*
>>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>>> + *
>>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>>> person obtaining a
>>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>>> (the "Software"),
>>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>>> without limitation
>>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>>> distribute, sublicense,
>>>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>>>> to whom the
>>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>>> conditions:
>>>>>>>>>>> + *
>>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>>> shall be included in
>>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>>> + *
>>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>>>> NO EVENT SHALL
>>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
>>>>>>>>>>> OR OTHERWISE,
>>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>>>>>>>>>>> OR THE USE OR
>>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>>> + *
>>>>>>>>>>> + */
>>>>>>>>>>> +#include <drm/drm.h>
>>>>>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>>> +
>>>>>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>>>>>> +{
>>>>>>>>>>> +    switch (hint) {
>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>>>>>> +    default:
>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>>>>>> +
>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>>>>>> +    }
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>> +                uint32_t hint)
>>>>>>>>>>> +{
>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>>> +        return 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>>
>>>>>>>>>> If it's all about pm subsystem variable accesses, this API 
>>>>>>>>>> should rather be inside amd/pm subsystem. No need to expose 
>>>>>>>>>> the variable outside pm subsytem. Also currently all 
>>>>>>>>>> amdgpu_dpm* calls are protected under one mutex. Then this 
>>>>>>>>>> extra lock won't be needed.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is tricky, this is not all about PM subsystem. Note that 
>>>>>>>>> the job management and scheduling is handled into amdgpu_ctx, 
>>>>>>>>> so the workload hint is set in context_management API. The API 
>>>>>>>>> is consumed when the job is actually run from amdgpu_run() 
>>>>>>>>> layer. So its a joint interface between context and PM.
>>>>>>>>>
>>>>>>>>
>>>>>>>> If you take out amdgpu_workload_to_power_profile() line, 
>>>>>>>> everything else looks to touch only pm variables/functions. 
>>>>>>>
>>>>>>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>>>>>>> profile. And going by that logic, this whole code was kept in the 
>>>>>>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. 
>>>>>>> So to avoid these conflicts and having a new file is a better idea.
>>>>>>>
>>>>>>> You could still keep a
>>>>>>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>>>>>>> mutex can be avoided as well.
>>>>>>>>
>>>>>>> The lock also protects pm.workload_mode writes.
>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>>> +        goto unlock;
>>>>>>>>>>> +
>>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>>>>>> +    if (!ret)
>>>>>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>>>>>
>>>>>>>>>> Why is this reference kept? The swtiching happens inside a 
>>>>>>>>>> lock and there is already a check not to switch if the hint 
>>>>>>>>>> matches with current workload.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This reference is kept so that we would not reset the PM mode 
>>>>>>>>> to DEFAULT when some other context has switched the PP mode. If 
>>>>>>>>> you see the 4th patch, the PM mode will be changed when the job 
>>>>>>>>> in that context is run, and a pm_reset function will be 
>>>>>>>>> scheduled when the job is done. But in between if another job 
>>>>>>>>> from another context has changed the PM mode, the refrence 
>>>>>>>>> count will prevent us from resetting the PM mode.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This helps only if multiple jobs request the same mode. If they 
>>>>>>>> request different modes, then this is not helping much.
>>>>>>>
>>>>>>> No that's certainly not the case. It's a counter, whose aim is to 
>>>>>>> allow a PP reset only when the counter is 0. Do note that the 
>>>>>>> reset() happens only in the job_free_cb(), which gets schedule 
>>>>>>> later. If this counter is not zero, which means another work has 
>>>>>>> changed the profile in between, and we should not reset it.
>>>>>>>
>>>>>>>>
>>>>>>>> It could be useful to profile some apps assuming it has 
>>>>>>>> exclusive access.
>>>>>>>>
>>>>>>>> However, in general, the API is not reliable from a user point 
>>>>>>>> as the mode requested can be overridden by some other job. Then 
>>>>>>>> a better thing to do is to document that and avoid the extra 
>>>>>>>> stuff around it.
>>>>>>>>
>>>>>>> As I mentioned before, like any PM feature, the benefits can be 
>>>>>>> seen only while running consistant workloads for long time. I an 
>>>>>>> still add a doc note in the UAPI page.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> a) What is the goal of the API? Is it guaranteeing the job to run 
>>>>>> under a workprofile mode or something else?
>>>>>
>>>>> No, it does not guarentee anything. If you see the cover letter, it 
>>>>> just provides an interface to an app to submit workload under a 
>>>>> power profile which can be more suitable for its workload type. As 
>>>>> I mentioned, it could be very useful for many scenarios like 
>>>>> fullscreen 3D / fullscreen MM scenarios. It could also allow a 
>>>>> system-gfx-manager to shift load balance towards one type of 
>>>>> workload. There are many applications, once the UAPI is in place.
>>>>>
>>>>>>
>>>>>> b) If it's to guarantee work profile mode, does it really 
>>>>>> guarantee that - the answer is NO when some other job is running. 
>>>>>> It may or may not work is the answer.
>>>>>>
>>>>>> c) What is the difference between one job resetting the profile 
>>>>>> mode to NONE vs another job change the mode to say VIDEO when the 
>>>>>> original request is for COMPUTE? While that is the case, what is 
>>>>>> the use of any sort of 'pseudo-protection' other than running some 
>>>>>> code to do extra lock/unlock stuff.
>>>>>>
>>>>>
>>>>> Your understanding of protection is wrong here. There is 
>>>>> intentionally no protection for a job changing another job's set 
>>>>> workload profile, coz in that was we will end up 
>>>>> seriazling/bottlenecking workload submission until PM profile is 
>>>>> ready to be changed, which takes away benefit of having multiple 
>>>>> queues of parallel submission.
>>>>>
>>>>> The protection provided by the ref counter is to avoid the clearing 
>>>>> of the profile (to NONE), while another workload is in execution. 
>>>>> The difference between NONE and VIDEO is still that NONE is the 
>>>>> default profile without any fine tuning, and VIDEO is still fine 
>>>>> tuned for VIDEO type of workloads.
>>>>>
>>>>
>>>> Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);
>>>>
>>>> The line that follows is amdgpu_dpm_switch_power_profile() - this 
>>>> one will allow only single client use- two jobs won't be able to 
>>>> switch at the same time. All *dpm* APIs are protected like that.
>>>>
>>>
>>> this also protects the pm.workload_mode variable which is being set 
>>> after the amdgpu_dpm_switch_power_profile call is successful here:
>>> adev->pm.workload_mode = hint;
>>>
>>>> Protection 2 is - ref counter.
>>>>
>>>> It helps only in this kind of scenario when two jobs requested the 
>>>> same mode successively -
>>>>      Job 1 requested compute
>>>>      Job 2 requested compute
>>>>      Job 1 ends (doesnt't reset)
>>>>
>>>> Scenario - 2
>>>>      Job 1 requested compute
>>>>      Job 2 requested compute
>>>>      Job 3 requested 3D
>>>>      Job 1 ends (doesnt't reset, it continues in 3D)
>>>>
>>>> In this mixed scenario case, I would say NONE is much more optimized 
>>>> as it's under FW control. Actually, it does much more fine tuning 
>>>> because of its background data collection.
>>>>
>>>
>>>
>>> It helps in mixed scenarios as well, consider this scenario:
>>> Job 1 requests: 3D
>>> Job 2 requests: Media
>>
>> Ok, let's take this as the example.
>>
>> Protection case :
>>
>> Job 1 requests: 3D => adev->pm.workload_mode = 3D; and protected by 
>> mutex_lock(&adev->pm.smu_workload_lock)
>>
>> Jobe 2 requests  => adev->pm.workload_mode = Media;
>>
>> What is the use of this variable then? Two jobs can come at different 
>> times and change it independently? Any use in keeping this?
> 
>> Some other job came in and changed to some other value. So, what is 
>> the use of this lock finally?
>>
> ?? The locks are not to save the variable from being changed, but to 
> save the variable being changed out of context. If two threads try to 
> change it at the same time, one of them will have to wait until the 
> other critical section is done execution.
> 
> Do note that this variable is changed only when 
> amdgpu_dpm_switch_power_profile() call is successful. Going by the same 
> logic, what is the use of having these pm locks inside the function 
> dpm_switch_power_profile(), as Job 1 changed the power profile to 3D, 
> and Job 2 changed it to media :) ?

That lock is protecting the swsmu internal states from concurrent access 
and not profile mode. Here I don't see the use of this variable.

  Using those locks does not prevent
> chaning the PM profile, it makes sure that it happens in a serialized way.
> 
>> Use case:
>>
>> Job 1 requests: 3D
>> Job 2 requests: Media
>>
>> Job 1 now runs under Media. What is achieved considering the intent of 
>> the API and extra CPU cycles run to protect nothing?
>>
> 
> This is how it is intended to work, I have explained this multiple times 
> before that we do not want to block the change in PP from two different 
> jobs. The lock is to protect concurrancy sequence, not change in mode:
> 
> without that lock in the worst case scenario:
> 
> Thread: 1
> Job 1 requests: 3D
> PM mode changed to: 3D
> just before writing (adev->pm.workload_mode = 3d) this thread schedules out
> 
> Thread:2
> Job 2 requests: Media
> PM mode changed to: Media
> adev->pm.workload_mode = media
> 
> Thread 1 schedules in:
> adev->pm.workload_mode = 3d but PM mode media.
> 
> State machine broken here. So the lock is to provide sequential 
> execution of the code.
> 
> 
> If your suggestion is we should not let the mode get changed until one 
> job is done execution, that's a different discussion and certainly not 
> being reflected from what you wrote above.

My suggestion is not to waste extra CPU cycles/memory when the API 
doesn't give any guarantee about its intended purpose (which is to keep 
the profile mode as requested by a job). Let it be stateless and 
document the usage.

Thanks,
Lijo

> 
> - Shashank
> 
>> Thanks,
>> Lijo
>>
>>> Job 1 finishes, but job 2 is ongoing
>>> Job 1 calls reset(), but checks the counter is non-zero and doesn't 
>>> reset
>>>
>>> So the media workload continues in Media mode, not None.
>>>
>>> - Shashank
>>>
>>>>> In the end, *again* the actual benefit comes when consistant 
>>>>> workload is submitted for a long time, like fullscreen 3D game 
>>>>> playback, fullscreen Video movie playback, and so on.
>>>>>
>>>>
>>>> "only under consistent", doesn't justify any software protection 
>>>> logic. Again, if the workload is consistent most likely PMFW could 
>>>> be managing it better.
>>>>
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
>>>>>>>>> - Shashank
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Lijo
>>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> +unlock:
>>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>>> +    return ret;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>> +                  uint32_t hint)
>>>>>>>>>>> +{
>>>>>>>>>>> +    int ret = 0;
>>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>>>>>> +        return 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    /* Do not reset GPU power profile if another reset is 
>>>>>>>>>>> coming */
>>>>>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>>>>>> +        return 0;
>>>>>>>>>>> +
>>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>>> +
>>>>>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>>>>>> +        goto unlock;
>>>>>>>>>>> +
>>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>>>>>> +    if (!ret)
>>>>>>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>>>>>> +
>>>>>>>>>>> +unlock:
>>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>>> +    return ret;
>>>>>>>>>>> +}
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct 
>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>>>>>> diff --git 
>>>>>>>>>>> a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>> @@ -0,0 +1,54 @@
>>>>>>>>>>> +/*
>>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>>> + *
>>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>>> person obtaining a
>>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>>> (the "Software"),
>>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>>> without limitation
>>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>>> distribute, sublicense,
>>>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>>>> to whom the
>>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>>> conditions:
>>>>>>>>>>> + *
>>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>>> shall be included in
>>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>>> + *
>>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>>>> NO EVENT SHALL
>>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
>>>>>>>>>>> OR OTHERWISE,
>>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
>>>>>>>>>>> OR THE USE OR
>>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>>> + *
>>>>>>>>>>> + */
>>>>>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>>>>> +#include "amdgpu.h"
>>>>>>>>>>> +
>>>>>>>>>>> +/* Workload mode names */
>>>>>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>>>>>> +    "None",
>>>>>>>>>>> +    "3D",
>>>>>>>>>>> +    "Video",
>>>>>>>>>>> +    "VR",
>>>>>>>>>>> +    "Compute",
>>>>>>>>>>> +    "Unknown",
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +static inline const
>>>>>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>>>>>> +{
>>>>>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>>>>>> +        return 
>>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>>>>>> +
>>>>>>>>>>> +    return 
>>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>>> +
>>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>>> +
>>>>>>>>>>> +#endif
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>>>>>> +    /* SMU workload mode */
>>>>>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>>>>>> +    uint32_t workload_mode;
>>>>>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>>>>>> +
>>>>>>>>>>>       struct config_table_setting config_table;
>>>>>>>>>>>       /* runtime mode */
>>>>>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>>>>>
