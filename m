Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C318FC6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 13:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE86510E39B;
	Tue, 27 Sep 2022 13:47:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0709010E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 13:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXe8Q7WcpP0jWTQX4QH6hCuJO0QnlVovloLaNRRac2jn3wJCZDU+Ry1IcH4DWhF1OJAOl1o5jgfd9+DTW9dw0OUVYWwejhr4nanbBqnHWkWLnrx3mBZv9+Fdf79IAUlK9oAviMO0jQKpuBeAbpTC/uHKkuBovEnaQ+gK0Z302ZVshep7nfEjKF+U4czb+g+6+xYdmEGmcFNupRLahZxgQuHMZYsuhzB6S1aGx7uz/CbGO0Mt29PD2YpiCcvFcpvLf4rjwfbfL8PcrTmj7X81f6THumaIfJTgQjO1x5n7+Gy8EBrf9U4WApnIdb4WifrnCeKeAY3HvYHI0pIpZ1g7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APjz79fpK3ZLUZIPlGGAjd0HIUnFxjMp95MnhN4OJlk=;
 b=OaaRvcNkec1DaKnYHXUErF9Sk4obgkRWaX0cIWs0V/xUweLM68yzAeRJAIIB61adeVZgfuFsU/qScBYun727wS3bQ4Lu+5yYeAt4OAkkujkk9Hr31Qgb3C8YUdK/KjdJ3GcLrFgNvJCRZZX+BdayomMOLpUkQ+uS7FyTjO+JjBMHL+gj3HwcDsuzAhTpGlElVQtP2R+BbHGdqLObKWVcoc+it3Wa/bO7k7bodi/30vIWIHtah8hugYPk31BPt2dty2tzM8eRSwZMG5UGHklM3UkY7QzHsS/MAO45SphwnMnVXjLa/+3wQp6LZmDAI4GckvWLvuSRRNN7100Rs454Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APjz79fpK3ZLUZIPlGGAjd0HIUnFxjMp95MnhN4OJlk=;
 b=QqRnMNNySwJFE3fU3uABB3kIyNnMTn4LYemBnJ1yydqAkTwipzJOXnTvqFZOqQKTdt2BRRQG8hOPBPB4L7Xd+NlRJ5hvxi2PQiqrWHr9e2tjlSXml4amqhhTNY/Bl2ookLYcsZdnx1u57vO+AF1gnXKvQWtksmUSwrSLSxp6AFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:207::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 13:47:42 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 13:47:42 +0000
Message-ID: <6dbc17c2-729b-e3de-1b94-4b800354e816@amd.com>
Date: Tue, 27 Sep 2022 15:47:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
 <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
 <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
 <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
 <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
 <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
 <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0776.eurprd06.prod.outlook.com
 (2603:10a6:20b:484::33) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 418039b4-4d1b-4f80-4b58-08daa08ed9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtZ1JPfZf+XSje7n1yZBtTg1xi4co3dDgkCW9WNynlCXDjy3VUUI3KCo4T+XSLbHvg4mdtOrQ9bwtBOO+sjozjO0PHwbKA+UcC+Y7Sx8+ZHXGEWtUBLEPq483K29Pkw+x8jntKvyp4g5PS65PkBdG+XwvtAUOdv1eodGajyFHblJHmeTDBlLC7Bg02+/iH/aJ0SAmKT7HQWK6UHIfX18NDpo2jXpDsL4KiMO9o4RFmGkJe+nDG8Qvt421vPf+rOe8eJbleKGBSiQymw27VZtq+IV82XVnhiwrf/MZbre8JMViUtnK/ty7KEmg4jOIXPoNx0tJIYfXp5fNiyx8iWbswLcen9/F67uRCK9vlVddPxX8023+b0H7W605MlbGnmL606D3ZqOnWMIuUygV8NIlJ7NrKBcAy7M61DT1/BQl1vGWuN2wyO2jdr4xqn6q/Agm9JchKDKY+pEjO3RO3i/XbFI8hjiu7PBJhIqKdakh7Zgcln6SrEJnnAZT3I19+y0qo4B7fNN4lhGMFHUkSgJDzutyEiZdkeULFfgI+W4htnlJ9oRw5sdYdROgB3O4U2ALvrRSoG/Ahik1EcPtOWClBOwvkb9fC2JO48joT4Yjn2X+yCka/ejNiAwTI4P5bj0bavkSiUBU0WOjPQ/0HUyLGIyzjtvnFi1wqGvzzanj5Nw+pJPz9v7UB8hoA5sYBJWsBmEvkjS00Y8OOe3oZyvXV2QBHmu7SNGYn2gD9BoVQKq1n6ZUSzfACoPpmNEpEDUkDgsPgw/0xyFSnqliPt74pbK8wsVH2pibZv7K50yPDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(26005)(30864003)(2906002)(2616005)(186003)(5660300002)(6512007)(31686004)(6506007)(83380400001)(8936002)(66899015)(53546011)(86362001)(36756003)(31696002)(66476007)(6486002)(66556008)(66946007)(478600001)(316002)(8676002)(38100700002)(6666004)(4326008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhORE9lVG4yN1p5NnJHMFRlMjJ5ZlY0TVdEWS9UR0dOdnhsMHE0cDllTDVW?=
 =?utf-8?B?aE9JNGlVa1pMdm96REloQmtmM0RWcWJaT3NyYndwcFdkeERWWUZibGVNbkph?=
 =?utf-8?B?dVM3ditxcVZHL3JPRE9aWXpYT2hGcncyZWEvRXBHMFhDVHFIMVBTSlJqVTBp?=
 =?utf-8?B?cU5ybGhpL3VHR2JsWTJROWF5WTgzQVlqeFV2MEpXRWVwbkV6VlRlelVPNDZG?=
 =?utf-8?B?SWNjdjQybHhxZ2dVZDNKL0I2WWFiYVFhRldqaURlZEV5UjRCbVFZTHJkTURh?=
 =?utf-8?B?ZmZiR0hqajV5MndRZGxydzFmM0dMTWJQTGpmR0JMc1VJdGtxK2t5UkFnUVJm?=
 =?utf-8?B?bEdDTUNmRU1wM2JmTGQrekxPd0gzaG82aXhMK2FURXc0bm91OTc3SVlxN0cw?=
 =?utf-8?B?M0ZjTnVPWkFjdU41ZnlDRFBkYnhBaWY1MFppQnloWmJua1MxTTZwZjRnbWN1?=
 =?utf-8?B?cEpQUWVNb1VEeGp3YUlvNCtGZUhLMzBrUDhvVEt1VHVSWU5jV0Q1R0tXSDlk?=
 =?utf-8?B?YjZlMG9JTWRkdElOUGczYU13VEQvTlFrYVM3a0lDV2ticythWjhpRy9NTFhV?=
 =?utf-8?B?Wm9xelNaNE1VRVVlU0sydWpVcGp5eVQ2U3cybDhNQTlNMDJuek8xZVlNcXpK?=
 =?utf-8?B?Mmk5WEZoYWl4dE1Scnp2YURiUi9EWHB6b2Q4NUREUVAwdnZYMVR2MVVOT3Q3?=
 =?utf-8?B?bXZvekRDVUppc2U5Ny9RbTM2UFlNYzJub0FMRWVPZ1o1Sm1WSytGcUlYT29M?=
 =?utf-8?B?TERheHBhcDFSUlNUZHhPSGtaMXBmR0tRSCt3QnhQT1dJRzc1Ny9RdkJyMG00?=
 =?utf-8?B?T2ppTEVBL25hWGRwS2RLblpveDJvT1hWUlU0NTg1cDFzNzE3ODdzUmNtVWlz?=
 =?utf-8?B?bm5EeUcvRUpTQzkvUy8wWTZha3VCYnNYNXVKTktWV3pqb2RMeExMTklmMmh4?=
 =?utf-8?B?ZmM4U2pGa040VExIVW5QRi83RkptK1BINEJvM0ZSUkZXYUpQNlBCL1g2V1JB?=
 =?utf-8?B?dmQzZVBiVkVUS203UXg3VG41UExPN3pHWkFlelNDWHBjeXd6UXA1YTRISUtD?=
 =?utf-8?B?d2VabWV0a0M2VHpPWkxRTEMwc0pPMng1U0pXOW1rUXpjYzUyVjVGSG85T2Vr?=
 =?utf-8?B?MHJGYTNoMXFReXRhQkR4ZWxYZkloZEovZ1NDblFwdjZ3Zy9JL1VhSkRBN1dD?=
 =?utf-8?B?azFPTEpKOWF0eW9lcm4xeXE4V0dLd24rbUJxOVRRQW5YcTRVcmM2WTBwUkFs?=
 =?utf-8?B?K29WYTNkU2pJYzgrWW5MRldwSTRnN2REbC9kLy9NQmlnRW96M1RzUVliNy9o?=
 =?utf-8?B?a3l3VUg4SmxLVjFWVW9OYWR3d2RLNzdNNE1jRkU1REFpRWFkSXJBUkZhTEtm?=
 =?utf-8?B?ZVFCbCtuZUhpd2VYL3ZmWmMvbmsvbHVRSm1DRWhKdnJ3SFdBMkxta2NBdWhu?=
 =?utf-8?B?REdIWUY1RCtWbU5MQkhkd1JpblN1U3BSVGl3WnFYQ1VYUXlYbVdpcENiRmJX?=
 =?utf-8?B?SUxMQk94WmtpL09RclplYklROWhhcEhOeUl5ZEVWaHJrc2owaXF3UVRTclUz?=
 =?utf-8?B?dlRxUnVya21hYll3STdLa3J5WmFkZVF5dVNaUlFoaXJ5Qmhtbmw4RHhRVEgy?=
 =?utf-8?B?a2pkSW9NeDBrRm1hOEJoQWNiSUdDays2ZXNXcUx2V3B6azhFWXZmcHA1dEJk?=
 =?utf-8?B?MjNYVUVWWWVDVDVwR2VtUWdNREtPK2NjNnV4L3FlcFg1bUJ4NHBIVGlCSnRm?=
 =?utf-8?B?YVEyUFpMTnhYZFNnaVJWaU8zZXhjSlI5TE9RMWpDaVJidU5pVFkyWlhnSEYw?=
 =?utf-8?B?ZlY3K0EzM0MycGRUSnczU0J5MG4rRVFjeGZRejlZWG9KVTl4OGo1QVpiL1JS?=
 =?utf-8?B?MXRqQlNsRVphQzJrd1M2bGYwaXd0eFNiTWNPRWJZN0FpeGRvM1dqcXU5Y2NU?=
 =?utf-8?B?d0I5VkdRclg3cGZhZkxJVkhYMGlvaFhwWjM4cDVaQVE2SFpUZmFCeUpQK0Rv?=
 =?utf-8?B?cGVQUlhrMzlZSW5hbXFYbXZOVzhYbzVQbFN2VlJXaUN4TEZoM0lUWlFJVnpV?=
 =?utf-8?B?WW81S2Nvbm1aV1E4dk5oVzlRNDR4eWl1V0JGemFCY3dWNDhxWjJNc1IzRUpN?=
 =?utf-8?Q?EyhJza/HC0Wr/+/uPKJkf471x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418039b4-4d1b-4f80-4b58-08daa08ed9a2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 13:47:42.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QcSs0tklchiZJniATQwm2WfRCCBdSzksOOZFAv6uxnCo9F0b30l0ptaQwDfx4oe0JZxS6Ccj8FZsNbxX6t9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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



On 9/27/2022 3:29 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>>> This patch adds new functions which will allow a user to
>>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>>> flag.
>>>>>>>>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>>> +++++++++++++++++++
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>>   create mode 100644 
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>   create mode 100644 
>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>>>> amdgpu_pll.o \
>>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>>>> amdgpu_virt.o \
>>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..a11cf29bc388
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>> @@ -0,0 +1,97 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +#include <drm/drm.h>
>>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>> +
>>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>>> +{
>>>>>>>> +    switch (hint) {
>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>>> +    default:
>>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>>> +
>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>> +                uint32_t hint)
>>>>>>>> +{
>>>>>>>> +    int ret = 0;
>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>> +
>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>
>>>>>>> If it's all about pm subsystem variable accesses, this API should 
>>>>>>> rather be inside amd/pm subsystem. No need to expose the variable 
>>>>>>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>>>>>>> protected under one mutex. Then this extra lock won't be needed.
>>>>>>>
>>>>>>
>>>>>> This is tricky, this is not all about PM subsystem. Note that the 
>>>>>> job management and scheduling is handled into amdgpu_ctx, so the 
>>>>>> workload hint is set in context_management API. The API is 
>>>>>> consumed when the job is actually run from amdgpu_run() layer. So 
>>>>>> its a joint interface between context and PM.
>>>>>>
>>>>>
>>>>> If you take out amdgpu_workload_to_power_profile() line, everything 
>>>>> else looks to touch only pm variables/functions. 
>>>>
>>>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>>>> profile. And going by that logic, this whole code was kept in the 
>>>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. So 
>>>> to avoid these conflicts and having a new file is a better idea.
>>>>
>>>> You could still keep a
>>>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>>>> mutex can be avoided as well.
>>>>>
>>>> The lock also protects pm.workload_mode writes.
>>>>
>>>>>>>> +
>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>> +        goto unlock;
>>>>>>>> +
>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>>> +    if (!ret)
>>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>>
>>>>>>> Why is this reference kept? The swtiching happens inside a lock 
>>>>>>> and there is already a check not to switch if the hint matches 
>>>>>>> with current workload.
>>>>>>>
>>>>>>
>>>>>> This reference is kept so that we would not reset the PM mode to 
>>>>>> DEFAULT when some other context has switched the PP mode. If you 
>>>>>> see the 4th patch, the PM mode will be changed when the job in 
>>>>>> that context is run, and a pm_reset function will be scheduled 
>>>>>> when the job is done. But in between if another job from another 
>>>>>> context has changed the PM mode, the refrence count will prevent 
>>>>>> us from resetting the PM mode.
>>>>>>
>>>>>
>>>>> This helps only if multiple jobs request the same mode. If they 
>>>>> request different modes, then this is not helping much.
>>>>
>>>> No that's certainly not the case. It's a counter, whose aim is to 
>>>> allow a PP reset only when the counter is 0. Do note that the 
>>>> reset() happens only in the job_free_cb(), which gets schedule 
>>>> later. If this counter is not zero, which means another work has 
>>>> changed the profile in between, and we should not reset it.
>>>>
>>>>>
>>>>> It could be useful to profile some apps assuming it has exclusive 
>>>>> access.
>>>>>
>>>>> However, in general, the API is not reliable from a user point as 
>>>>> the mode requested can be overridden by some other job. Then a 
>>>>> better thing to do is to document that and avoid the extra stuff 
>>>>> around it.
>>>>>
>>>> As I mentioned before, like any PM feature, the benefits can be seen 
>>>> only while running consistant workloads for long time. I an still 
>>>> add a doc note in the UAPI page.
>>>>
>>>
>>>
>>> a) What is the goal of the API? Is it guaranteeing the job to run 
>>> under a workprofile mode or something else?
>>
>> No, it does not guarentee anything. If you see the cover letter, it 
>> just provides an interface to an app to submit workload under a power 
>> profile which can be more suitable for its workload type. As I 
>> mentioned, it could be very useful for many scenarios like fullscreen 
>> 3D / fullscreen MM scenarios. It could also allow a system-gfx-manager 
>> to shift load balance towards one type of workload. There are many 
>> applications, once the UAPI is in place.
>>
>>>
>>> b) If it's to guarantee work profile mode, does it really guarantee 
>>> that - the answer is NO when some other job is running. It may or may 
>>> not work is the answer.
>>>
>>> c) What is the difference between one job resetting the profile mode 
>>> to NONE vs another job change the mode to say VIDEO when the original 
>>> request is for COMPUTE? While that is the case, what is the use of 
>>> any sort of 'pseudo-protection' other than running some code to do 
>>> extra lock/unlock stuff.
>>>
>>
>> Your understanding of protection is wrong here. There is intentionally 
>> no protection for a job changing another job's set workload profile, 
>> coz in that was we will end up seriazling/bottlenecking workload 
>> submission until PM profile is ready to be changed, which takes away 
>> benefit of having multiple queues of parallel submission.
>>
>> The protection provided by the ref counter is to avoid the clearing of 
>> the profile (to NONE), while another workload is in execution. The 
>> difference between NONE and VIDEO is still that NONE is the default 
>> profile without any fine tuning, and VIDEO is still fine tuned for 
>> VIDEO type of workloads.
>>
> 
> Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);
> 
> The line that follows is amdgpu_dpm_switch_power_profile() - this one 
> will allow only single client use- two jobs won't be able to switch at 
> the same time. All *dpm* APIs are protected like that.
> 

this also protects the pm.workload_mode variable which is being set 
after the amdgpu_dpm_switch_power_profile call is successful here:
adev->pm.workload_mode = hint;

> Protection 2 is - ref counter.
> 
> It helps only in this kind of scenario when two jobs requested the same 
> mode successively -
>      Job 1 requested compute
>      Job 2 requested compute
>      Job 1 ends (doesnt't reset)
> 
> Scenario - 2
>      Job 1 requested compute
>      Job 2 requested compute
>      Job 3 requested 3D
>      Job 1 ends (doesnt't reset, it continues in 3D)
> 
> In this mixed scenario case, I would say NONE is much more optimized as 
> it's under FW control. Actually, it does much more fine tuning because 
> of its background data collection.
> 


It helps in mixed scenarios as well, consider this scenario:
Job 1 requests: 3D
Job 2 requests: Media
Job 1 finishes, but job 2 is ongoing
Job 1 calls reset(), but checks the counter is non-zero and doesn't reset

So the media workload continues in Media mode, not None.

- Shashank

>> In the end, *again* the actual benefit comes when consistant workload 
>> is submitted for a long time, like fullscreen 3D game playback, 
>> fullscreen Video movie playback, and so on.
>>
> 
> "only under consistent", doesn't justify any software protection logic. 
> Again, if the workload is consistent most likely PMFW could be managing 
> it better.
> 
> Thanks,
> Lijo
> 
>> - Shashank
>>
>>> Thanks,
>>> Lijo
>>>
>>>> - Shashank
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> +
>>>>>>>> +unlock:
>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>> +                  uint32_t hint)
>>>>>>>> +{
>>>>>>>> +    int ret = 0;
>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>> +
>>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    /* Do not reset GPU power profile if another reset is 
>>>>>>>> coming */
>>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>> +
>>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>>> +        goto unlock;
>>>>>>>> +
>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>>> +    if (!ret)
>>>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>>> +
>>>>>>>> +unlock:
>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct 
>>>>>>>> amdgpu_device *adev,
>>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>> @@ -0,0 +1,54 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>> +#include "amdgpu.h"
>>>>>>>> +
>>>>>>>> +/* Workload mode names */
>>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>>> +    "None",
>>>>>>>> +    "3D",
>>>>>>>> +    "Video",
>>>>>>>> +    "VR",
>>>>>>>> +    "Compute",
>>>>>>>> +    "Unknown",
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static inline const
>>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>>> +{
>>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>>> +        return 
>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>>> +
>>>>>>>> +    return 
>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>> +                uint32_t hint);
>>>>>>>> +
>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>> +                uint32_t hint);
>>>>>>>> +
>>>>>>>> +#endif
>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>>> +    /* SMU workload mode */
>>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>>> +    uint32_t workload_mode;
>>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>>> +
>>>>>>>>       struct config_table_setting config_table;
>>>>>>>>       /* runtime mode */
>>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>>
