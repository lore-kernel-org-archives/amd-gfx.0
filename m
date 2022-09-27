Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DAC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B679410E8F4;
	Tue, 27 Sep 2022 12:11:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9864610E8F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbtByEdA+yWl/ZLlfuUBykBTNp2okznnDUZviAnCzRLLiX7sajJy6fUvUk/d4rjZnx2NCJdjhhR4cjb2kQaqE7HsarDbdn3AVf+vJ0U7BhqMlNj0VrTlkBidERqI7+V/O9aDhHrhoNqESm98owba98mMaSx1gPC04cRKok/296msMK5T6LpFO3vHAamU+4eUfes+QFUV+mrj+9ih2IDijbbJDx4bqF8YyTURALgq7rEATmbYTDkxchxgqlya9DG1Als9VA1YOGfdicvyMW1XjfusKAa/ppJkqK60OqV9PrIIzGcNhiJauo/txmOQzggPVq2sSeori7w76ABnGEmYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnZUPSqHbNwdp/KBANpjYln/0o7AUJc4o9hDMdGVK5E=;
 b=PzfEy50Q7a0wYByqQjox5vGYhgRBfk2xycwJiRdYCSOR3yJVPE5n3lzNRR+oS/cM2JhgzWfH30KVZqkNP2HGX26XnnmEMqTmJQ8iaHOszkdCli/Pp7gQrz5gWrhJ8qu4g4sJq+mWjjN3WorDmGH59+k1qf2C+kUqmfprT6t9HW+tsYNbqOfBsqxcHx6ziImeVin80dMY5wjdr5XxUGLw9PpLKR8Dafu0l7WZTwG66hALzDJk96uhaDkTGgHfCUST7C6ujeTRlHUxFfxK60VCuW1v1Qr8U94c+pWHROsE4IEP0ARbgNKWPuGJ2wewlbkfAn8hAhCHNGakCksKv/GlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnZUPSqHbNwdp/KBANpjYln/0o7AUJc4o9hDMdGVK5E=;
 b=RbY7zwjDH+JU9K0cxTu9gxVezJNhnaI9M7NrR8oJVjf6Q4SaEKbnL0jAvdEwJ/8wanXP2LNmMFhR/8qtAS6VmDmoONM3zRHcTVQyy7DbcCGVhsOqYy0ABs/AVSbvBNCEcvaSeJvjSQIBfEbRDiXtRu4uKpsBd7bRG9/ZHQV0nUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 12:11:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 12:11:02 +0000
Message-ID: <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
Date: Tue, 27 Sep 2022 17:40:52 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: c30d0f5f-7c57-4c7c-86e6-08daa081585f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXWfiX44BLQ1LyYrFgBn9efLvBwmNgMGuhpA+FR+xrFq0c1dKSE9n3SQqgN96gkPFNkWA/u6qeb3iak0yKHLsqFyn60RD6edroVM16KIAgUvDlEcTj6Sm4Gkmm3/tbEbfGnhzMhdKAOIsL0XQShEFxA9qIyp8fKfzPU6VtCWKYA6Av91ac47e2mtazSDa8BigCHkDHNdTzV10hqo3J1LFIxOHnvvA30YjG/WjuGVPrLByqRE/ij2pNCIU9xuvEhnRbXhdDJYl3E1PvFGSJZtQsN9o0FO7DLG4zpG6XQNmeJaycQ3GftsU2finI1QxRT2YLDL4vuTWp+KZTKL+9XqOtQSNI0Z3xyav8HHjiGpeBlI4cMajBP8xq8GnYCQvLiUUOvAviCg2D+gWYJk56WhQ+/0s0iLUbgSXIoWPQ4LvVFq3VdxWtt9O/qvWBDCpPqpYBrCFgfugt8wRVhMA5UTAxg8NeLccdBqT4Omk04+6fc2JLIF9QZt/peaEC8HsFe8bY/0TfK/EuEzITBuhV5xiSRVELcU5VmvSfvp1gp0/Qb0z4ljNcCkYTDG0Ht9Q8ujj+bxxHmsCYK0sPGfKkgseH1sf84Iqx2HOMty7kREwuT0rgdk1gWlDEUJKSBJO0/rh0TriFPAxh9VfPKx1ayl95vGNqenQya1x++kPgkajylnBoRwZNPi8Epav7RA8oL36MBt3lm9Sxq1stuuyS/yC8+EzgFPy7D1UcWSHgqnjeEgVfFhhlDTTc01LrMIvSUzwNDPQuolXgL5f9/FHeJQM2FOkC8o2JWWO2UPjVL9PnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(4326008)(6666004)(478600001)(41300700001)(53546011)(6486002)(66946007)(8676002)(6506007)(66556008)(66476007)(316002)(36756003)(38100700002)(186003)(26005)(2616005)(86362001)(6512007)(66899015)(83380400001)(31696002)(30864003)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmEwY1Zka0F2YUVxNFlHZkxsSzZaNVUrajdqTDdtRzYzZnVDZ0U2ZUc5bFBt?=
 =?utf-8?B?U2xQYTB6NWpjSE5WYnNndVJPenkzMGNRYWM2elNwcVdqQUI3MjBLWHg2UGZu?=
 =?utf-8?B?ai8xNUt5Q0ZqaTZIQUFBVGRVWGY5SkNpT05kNDhpQTg1U3VtaHZsZ0tCejNo?=
 =?utf-8?B?L3lKK3RiV0p2TUFZRXpFaWZjRldta01yR0RPSGZpeHlqRkZzU0FOVWtXcmg5?=
 =?utf-8?B?KytXdHBRZmlXRGY1TnE4Z1hrOTRKZkw2dVJ6WkY3Y2VOK0NPSjJZbHRISTRh?=
 =?utf-8?B?S1pEQ0Jodk9PQ2FTTjVjVGVVWmFOSHUwNlZYTnhVSzdlSUR1M1VXWE9CcW9m?=
 =?utf-8?B?Q2NKTWFDMXFKZ1BLMkZ5dzlQWk5CbENJaXVQUm04VXN2aGVyVlI2UVg0Zi82?=
 =?utf-8?B?Z2lnUTV1ZVZwcm1lcFJWYTZRSHBkdkt6MEZIcHdsdXZRUTZpY0t4VWxSMVFu?=
 =?utf-8?B?d3NJcVdEN3lxTHdoNnBWbzR2MkE1b3Z5V1B2TXVodXFaY0VNRWxQTGRONG5v?=
 =?utf-8?B?dnRYWk1CR1lFb0ZGTnplbEkrU3BXNnFPVnRFZm1NT0lNczJEc1R1dmFXb1cy?=
 =?utf-8?B?SGdzcURIME1iZXFqcmVrOWNHNkhvTHI4TWFPUTRIUnVOUmNybnJHMXVETkd6?=
 =?utf-8?B?eERBWDZRdlI0dE11WE4vMHZhbXhxQWxGY1ozR05ISForRW1nWERkbGUzaEhD?=
 =?utf-8?B?dkVBeWZFanNYSzdHeG9ncGNlZDVVVTMvWUtFaTdjbFVCWFdLbkxUQXdOeWFz?=
 =?utf-8?B?bWQyMzZ1SnlKWE5MT2JqQkM0VlBSZmdaNU5zTHBBTWdlMG1XVzRGNEx3SlZz?=
 =?utf-8?B?bVVLK1pOMFdzTXBWSmpjdHhjUTlaTEpLOS8zdnNlK2VZT3FPWWNtTFF5OWhS?=
 =?utf-8?B?MmdCV2hWUHNKQk1kNW53TTJ0MDNXZWR1NHI4Ym9odDdEUjJrZU5UQ2VYQ2JF?=
 =?utf-8?B?M0FKWUYwSjVXMHVwRHMwSEp2VmtNMHFDZzhBRDRKWGVDelFraHJCd0RnKzh3?=
 =?utf-8?B?VDdNOWpmMmIybEY0a1VnTitlajRxVFlJRlhWdTNSK0hiRWw0ZUxIMVMvK3Rh?=
 =?utf-8?B?dXphRlI0ZnVyNzdTcTVEb1N0R1dpRDFwbCtucjdIbFdJWHczcXpWQVJOaUx1?=
 =?utf-8?B?OUFpSWlQZUJOQ1lxVTd1K0Z4cWE1MlRmZXdYSEJLV242SkFZZU5mYzNtZzBv?=
 =?utf-8?B?Y2tTNFRIRlNwaHlCRmNlUXUzZVBxWlhVazhhb2R4eldaVTRFZWYwSTVHMUZh?=
 =?utf-8?B?czJ3ZXAzbTZKMjg0aFMxdUxmL29kREppaDkwOVdBOVVtbVdvL3dsbFN3RmFl?=
 =?utf-8?B?T09Nbk1vUS9lRkY0elRKdlJvbFo4M3FGaTJXU0doajl5b1ZTT0xqYjc0azhl?=
 =?utf-8?B?aEVKVXhuMUlYZ2FkWmlDRVFRa1YvUjEwaXEyT3g5enFLQ1Fadm0zUmJUbXVT?=
 =?utf-8?B?ZDdPUmc4OUMrM3dBNWpSSzY2WjZBOWVvTFFtU0xZK2MxbUUrdENmdnBIcTlR?=
 =?utf-8?B?Y1ZKbE5YWFpRZVl0S0VBWDhwRm9LVHNReXFVL3d6SUtHU3d0ODBMUGQ5Wnp6?=
 =?utf-8?B?Z3BnTHNTaVlGS3VjWnc2dVkrazFmaDdsQjFvV3dMNERuVExCK09tSkJDK2RD?=
 =?utf-8?B?Y0E4MlI4a2dzNnNFNXJxWExQTnJmQzJvT2tRVzQ3MGhGdmc4U3hUSXBCT2hn?=
 =?utf-8?B?SDk3QXdmRDl2WnVBS1RkZTRvM01PdnRGcHlLK25KcEV0L0ZHNDR2cHlhcWNS?=
 =?utf-8?B?R2FENitqa0kzK3AzUWN4Z0dZVFRSa29MQXovT1pJcEFDb1NtWnUyUVpCdXg3?=
 =?utf-8?B?RmFRWGhoaGpTUDlOQWhwZk9qWkF2Zy9xNG1kalYzWUdQSjFBZ2FxZFBEZnNO?=
 =?utf-8?B?Ymo4QXJtanR1N3ZSRncyNTg4WkRWVVBBakFMLzNoWnZqbjhEZ3A1aEVyUnNa?=
 =?utf-8?B?WHl3UnpycE54ZmtGS3MwVTBNbzR0NnJEaTVTZ2xmYmkyQnMzZHV0RXRpbnln?=
 =?utf-8?B?MjBXM3dvdmYwZnpmV2J0eWRGa2dTZHRhbjgvaVlPK2dwNW1TZGY2T1ZJaitu?=
 =?utf-8?B?UzJXWFhRWk9xbW9lT3h4eDkreGpXZ1Flc05lM1RDWVFIZWl1REhoY3pNTURm?=
 =?utf-8?Q?ClAgq7Hk5vAx8s05ql3KHfhl+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30d0f5f-7c57-4c7c-86e6-08daa081585f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:11:02.3820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbqJ21wOb4YwJ6aQ8wjy5zMJKcZnV2RjF8qUqa8+YVq9NT5mgQzh5TMp2F62JJjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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



On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>> This patch adds new functions which will allow a user to
>>> change the GPU power profile based a GPU workload hint
>>> flag.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 5a283d12f8e1..34679c657ecc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>> amdgpu_pll.o \
>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>> amdgpu_virt.o \
>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> new file mode 100644
>>> index 000000000000..a11cf29bc388
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>> @@ -0,0 +1,97 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom 
>>> the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#include <drm/drm.h>
>>> +#include "kgd_pp_interface.h"
>>> +#include "amdgpu_ctx_workload.h"
>>> +
>>> +static enum PP_SMC_POWER_PROFILE
>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>> +{
>>> +    switch (hint) {
>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>> +    default:
>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>> +
>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>> +        return PP_SMC_POWER_PROFILE_VR;
>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>> +    }
>>> +}
>>> +
>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>> +                uint32_t hint)
>>> +{
>>> +    int ret = 0;
>>> +    enum PP_SMC_POWER_PROFILE profile =
>>> +            amdgpu_workload_to_power_profile(hint);
>>> +
>>> +    if (adev->pm.workload_mode == hint)
>>> +        return 0;
>>> +
>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>
>> If it's all about pm subsystem variable accesses, this API should 
>> rather be inside amd/pm subsystem. No need to expose the variable 
>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>> protected under one mutex. Then this extra lock won't be needed.
>>
> 
> This is tricky, this is not all about PM subsystem. Note that the job 
> management and scheduling is handled into amdgpu_ctx, so the workload 
> hint is set in context_management API. The API is consumed when the job 
> is actually run from amdgpu_run() layer. So its a joint interface 
> between context and PM.
> 

If you take out amdgpu_workload_to_power_profile() line, everything else 
looks to touch only pm variables/functions. You could still keep a 
wrapper though. Also dpm_* functions are protected, so the extra mutex 
can be avoided as well.

>>> +
>>> +    if (adev->pm.workload_mode == hint)
>>> +        goto unlock;
>>> +
>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>> +    if (!ret)
>>> +        adev->pm.workload_mode = hint;
>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>
>> Why is this reference kept? The swtiching happens inside a lock and 
>> there is already a check not to switch if the hint matches with 
>> current workload.
>>
> 
> This reference is kept so that we would not reset the PM mode to DEFAULT 
> when some other context has switched the PP mode. If you see the 4th 
> patch, the PM mode will be changed when the job in that context is run, 
> and a pm_reset function will be scheduled when the job is done. But in 
> between if another job from another context has changed the PM mode, the 
> refrence count will prevent us from resetting the PM mode.
> 

This helps only if multiple jobs request the same mode. If they request 
different modes, then this is not helping much.

It could be useful to profile some apps assuming it has exclusive access.

However, in general, the API is not reliable from a user point as the 
mode requested can be overridden by some other job. Then a better thing 
to do is to document that and avoid the extra stuff around it.

Thanks,
Lijo

> - Shashank
> 
>> Thanks,
>> Lijo
>>
>>> +
>>> +unlock:
>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>> +    return ret;
>>> +}
>>> +
>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>> +                  uint32_t hint)
>>> +{
>>> +    int ret = 0;
>>> +    enum PP_SMC_POWER_PROFILE profile =
>>> +            amdgpu_workload_to_power_profile(hint);
>>> +
>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>> +        return 0;
>>> +
>>> +    /* Do not reset GPU power profile if another reset is coming */
>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>> +        return 0;
>>> +
>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>> +
>>> +    if (adev->pm.workload_mode != hint)
>>> +        goto unlock;
>>> +
>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>> +    if (!ret)
>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>> +
>>> +unlock:
>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>> +    return ret;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index be7aff2d4a57..1f0f64662c04 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>       mutex_init(&adev->psp.mutex);
>>>       mutex_init(&adev->notifier_lock);
>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>       mutex_init(&adev->benchmark_mutex);
>>>       amdgpu_device_init_apu_flags(adev);
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>> new file mode 100644
>>> index 000000000000..6060fc53c3b0
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>> @@ -0,0 +1,54 @@
>>> +/*
>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person 
>>> obtaining a
>>> + * copy of this software and associated documentation files (the 
>>> "Software"),
>>> + * to deal in the Software without restriction, including without 
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom 
>>> the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be 
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#ifndef _AMDGPU_CTX_WL_H_
>>> +#define _AMDGPU_CTX_WL_H_
>>> +#include <drm/amdgpu_drm.h>
>>> +#include "amdgpu.h"
>>> +
>>> +/* Workload mode names */
>>> +static const char * const amdgpu_workload_mode_name[] = {
>>> +    "None",
>>> +    "3D",
>>> +    "Video",
>>> +    "VR",
>>> +    "Compute",
>>> +    "Unknown",
>>> +};
>>> +
>>> +static inline const
>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>> +{
>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>> +        return 
>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>> +
>>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>> +}
>>> +
>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>> +                uint32_t hint);
>>> +
>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>> +                uint32_t hint);
>>> +
>>> +#endif
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index 65624d091ed2..565131f789d0 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>       struct mutex            stable_pstate_ctx_lock;
>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>> +    /* SMU workload mode */
>>> +    struct mutex smu_workload_lock;
>>> +    uint32_t workload_mode;
>>> +    atomic_t workload_switch_ref;
>>> +
>>>       struct config_table_setting config_table;
>>>       /* runtime mode */
>>>       enum amdgpu_runpm_mode rpm_mode;
>>>
