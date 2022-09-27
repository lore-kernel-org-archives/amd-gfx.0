Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1DC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 13:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E5810E353;
	Tue, 27 Sep 2022 13:29:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F9E10E93B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 13:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMfWxlhBitn4+xD/EuYbAjFoDSGNHOdLsOyQVe4cgYhx/65gOn4EwcqSkYlT9aYiMt17HBLnYPxeKjK6QT/BG2ko6ECx61TJllaTsFJ8IpTveVnVY26CbMEnGUhyX/jxdQeX0bBtNynQNBQ19RA6wZFMEaQhAYS2y3de5EvLk/ZJiQwt43mo5X506rHm+GB3GkhBOcaN53AemO+5RwZ41lBEhyOPO6ALjmlJY9UQbPzBOv5AHdkF/FDq484Rt0ontILmKEgtrznoWsU4NUilheHGatxSfQoU4yckQiTWESiyqCbBdXjBRFVHN+pMtVYPKUp7BdE3impaDHD7JJD0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mjURwkXm84gJv+bo9Es4Ga3JPRJXoColh/2fS6h5Bc=;
 b=L2Y0+Wx2YxvQQ7J1QSGRd8+/XTlwllrCNeZ8t2Paykno3m2sNF0BeoR56H0P3H4bRCSjsfSfOWjf4O3ZV+oD7k2IdUNXntVC5AmHK3CyNIXPeicoJP2pT+27G51QrD9fMbnmjQsn4OG6MIDaLJtauWa4gO9BY78ejo7YYWeGd5lEHZnBlMktVaTTNgYRuFVuqGXvCGlMxWv+cSjMIoVY4Q0Uk3BGOM5VRq2LdqEAG/WwGtn9L0bIkOUYuECi7fNzaRijr81tdddBs1H6vDmU7XR5XXbKg0aL4H653OqeZhFVQf7j8V9CuNOY4SPiVFrxmafK6cDqunVb7yEVB/MYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mjURwkXm84gJv+bo9Es4Ga3JPRJXoColh/2fS6h5Bc=;
 b=DTs2T81/9rOQoqDBCqwGztewaiAh0Z8C8bM4B3NjKFPhyqOBWgik3TCIesB81QWNN/n2HzbXMjPgNbUOQShA1vRdy4Br3NQG1/AcCqrvuD6H2NN1PDL80cFA3MlfK5D8Q5bcSNvBeWgZghxagZ2bhhpmUuzDNIUv0GRccTZDYlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 13:29:17 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 13:29:17 +0000
Message-ID: <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
Date: Tue, 27 Sep 2022 18:59:07 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ded486-7bb1-4ab0-4fe7-08daa08c46dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rE8bPvi5v5ZSXypTxyl3bCwjCZzaQVKW80Q6Q5os27USFbDd4jRzoTHyAZgaJz8hBs3FpSHHf4w65jQwpLPQFzfiDLeOxdpYUPWv0o+coUGYfAD4o+X7uX5NdkPYVp2JJjaGMygQIIkmvTgn4ER676qYP7QXj3EV7LABmGE3KnO8MCnjcG6SDzCDg1eC10bL4VVthzG/aoU9cq/AEzDZU1BQNqWkLMhWQf165PWf3prhQurp8fX6xsmwEy+tr6siFZ9oxEbqhZPv1U1TTrYjo4wfqJH7tLZ0s+FaHrOz8flyJcNdZsunudrcb0BwHn7hOpS/JNPVVlXQVw56yyDV8VFqyl0CY3lgJjwHy74lxmMafPn52HAnFFkyl/c4ikFNF34krGWvmejUZSrwyeECyB1sL/ftr4ztJRGsYxXTcPXaFur22m1NJqSqNYYuvW6Gww8Hf/8JB/7fkxRk+EHn8HzryVwSqqXYGFHSzqJlPKRBmDlziXrH21Kpqh5Osic5lKeQubvCh87sJvD1WEloe3Xnig0KzZPv0APXzpp7tc1wG8i4hnjVS/5q9IHkT0bJdD9qV5eGJgA9eyJGUe9rU/s1zLIJiINiS+O0SjScI408R6+IrBuI+CmVrPjbHrDj7rt94NyVNrpe5QwKTAmusJJsIeKQ2qJZZng2eWeJkA9PCkgfbO+/6Lm0PzmmsNROQjMrayb74TdtvsprYzJ+fJTzxfQLvaowTIx1h97wCOpCrPrKKZ4nGqSFsFndOyo9GowJRRSwJxTqpJQjFI0X0ku+5SsNh8MvYhPYnBjbdrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(31686004)(2906002)(66899015)(8936002)(8676002)(66556008)(66946007)(66476007)(30864003)(36756003)(5660300002)(38100700002)(4326008)(41300700001)(6486002)(86362001)(316002)(478600001)(31696002)(6506007)(53546011)(6666004)(2616005)(186003)(83380400001)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVFDbEFSaDc4MFZmMjg0NzI0N24rZG1sa0R0K0EzaHArR1NtK3RUWmNjRi9i?=
 =?utf-8?B?Y3h3ZXEwa0ZtUDVFUC83a1RWTHRDcXVJcjExSm5RN2VHNnk2Z0pDbWhrZjBs?=
 =?utf-8?B?NCsrUVFUbTZFZjlsQjdHZU9qaWVhTVVDYThGYndrdThZWUQya1BuTnpLT0xq?=
 =?utf-8?B?NFdTVnJtbUdTeWxyT0h6VDQzbjBJMURXZXozcEpqZHUzajBjcHpFMDBlZXB3?=
 =?utf-8?B?YnpoWnVJb3lzMnlDbThLdFZ3VUFMYkh5MWZrbjFHSlQ3eWVvSTk5K0hzdnFk?=
 =?utf-8?B?MU1lZ1dueWxSSlFrUWpDazhFZVcyYk9MQWtubURKZGI5czFqK1Ird2lxTlpL?=
 =?utf-8?B?ZkszR3dDL1RzY3B6WHppb3d2SDdsS1EvMHFyY0c2WFR3QnE5MWQ1L3FYb1NT?=
 =?utf-8?B?UTdkVU5zTExzSXZzaVJWd0xDVDZNZE5KV0dIRFRuWWczd1RnNFk5aXRzQUNQ?=
 =?utf-8?B?RFVFZ0NoRVZjalFmRUxZMmxsZm1JNGEvMlQ2RjBjVjdXRWxXZWI3aVhRczhY?=
 =?utf-8?B?VERrTHI2dWNzTy9KenYwdHlOQm5rQUQxR1VDWmRXWlNJdXlWd3NvTFVGQk1X?=
 =?utf-8?B?SEdZWkowZ0tCV1NRcE5UaXI1S011cFNIT0p4RTZRWWU4WXBIQ2dpL2VYbUNR?=
 =?utf-8?B?ZUZFV24xZ29WWTFHdStEZ3dNKzltdnYzakFJZU1naTB5bmcxNmxGaC94SzdW?=
 =?utf-8?B?TzBNNzlhU1RrM1p5bUhscFlxSmNybjFra0s4QUhDdDQ2R0psc2Q5RXVTV09q?=
 =?utf-8?B?dUFHYmJZNzI4eGphYVRxSTNTbDViZ28ycGRFaGphcndrSURNR3JrcS9ydW4v?=
 =?utf-8?B?SHZGc0dPWVdCay9WTVJDYmM1dTgxVEllM1pKZlhnK3g2V1pwZHVreFJnYkhK?=
 =?utf-8?B?R01zOVdWRWhRQW1wZ3FNM09CR3VST1ZmaGZpZjVVZFdBcE9xaDM1c3cyb2Q3?=
 =?utf-8?B?QXRpMk5EeCtpSDZTRVZHTkpLRlBwNFdqTXhnOFNpeUpzc2xjUzc2dXIvSkgz?=
 =?utf-8?B?ZXpScWJFSHIvcE04UHNvSGY3RXR5UytGczJ6b2Y5R0lqazIxbnBTSzFyUlFE?=
 =?utf-8?B?L1B1ZnR5a1djZ2FIOVpHZHMvRFg2TlJHVnJvVG5Dd1V3QVF4dEEvYXpqTmhE?=
 =?utf-8?B?OGlJTzUyWVhCYTlqZjN6cEdUNlkzZHFnbHExTC9sSHRPSkg5MUlXUkZHZXZX?=
 =?utf-8?B?SHNEVDJjUkVFVzkwVDFOaFAwaUVkbkxMcEt6bEpYaDhkSWdhQ1FVQktBYmg3?=
 =?utf-8?B?MmxRRUxneGtFYWNQVDdlazMzSno4T1M3WFhPamJtaEJhV1M4eEU4cGwwZlE2?=
 =?utf-8?B?SWUzeG1XMFFYbTVCamNQSWE5NjZMdVFYV2xyWHFwd0lmREUyVDEyK3FLdUVK?=
 =?utf-8?B?eTV4TUF0SDhyTTdhSWxKZ1lKRi9nSTFnQlhmV2poSEhVMzJaeEFKWkpMOTYw?=
 =?utf-8?B?MDBJbkw4MC9yR29XR2lhaTRSSXNPM2ZocnprVGlnYWVJQTBoUDVoL0NOQUhO?=
 =?utf-8?B?WkowSkVCc1l4OEx6YnRwWXdISUJ6TjFoam11bExpRnRGWHVXN1pnYzlBKzNk?=
 =?utf-8?B?cGt0ZFpObDFuZVlFS0t1KzZHSDJ4SHZnQ0JtcVQyVzExTTNFT3czUzg4YXNP?=
 =?utf-8?B?Q2lMVWU3Y3FJQ2hMc3RycEV2RzFzRklhN3pDdjV1d3hMcFUreS9sbVl4anZP?=
 =?utf-8?B?ckJadm51VnRNY1RCb0ZsM01qT2hRZVYxTDRYTkZvU2RnWkE2RVg4d3JJdkRY?=
 =?utf-8?B?N1FqMXNEaHZSOGxvRWVnSFFkbmw4TENPNGEyRTh2QzhjSnVCUWthWmNsRlM4?=
 =?utf-8?B?TnV0VEFBaEtvdSt5bTdmSGlya0N0OTIxR3dNa04vSTAyV2QxNllzdFQ2TFMx?=
 =?utf-8?B?VFJlb1czanUvQlBtQnk0Uk9keGxkQkF0UU9iRHdqek1hNjVsWGt1NzExZkl3?=
 =?utf-8?B?N0tOd1dabS8vby92U1ZUS3FoenVWUUJac2V4V2QydDdSZEhzU1Q0dHJBZzkz?=
 =?utf-8?B?NDJxc0hRcXE5Q2Zjb3JiamJuLzJ4ZDF0dVJyNGZBNUQzRWY0eEhYbzNZWkVT?=
 =?utf-8?B?QU1aeTdXVlpuWWIwclM0enFEUTd2QmlRNTJMeHg2THNJZS9COXZxbUhQSTQ4?=
 =?utf-8?Q?8LROS7eFEQ0DYRcolvVbIfjqc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ded486-7bb1-4ab0-4fe7-08daa08c46dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 13:29:17.2774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJaJ1er21kgDKvZ/ZUMf4zQIVJc1xkbHhI5YLr+U7O0LmuThNXRFmTaGVjgrHpq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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



On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
> 
> 
> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>
>>
>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>> This patch adds new functions which will allow a user to
>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>> flag.
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>> +++++++++++++++++++
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>   create mode 100644 
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>   create mode 100644 
>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>>> amdgpu_pll.o \
>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>>> amdgpu_virt.o \
>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..a11cf29bc388
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>> @@ -0,0 +1,97 @@
>>>>>>> +/*
>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>> + *
>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>> obtaining a
>>>>>>> + * copy of this software and associated documentation files (the 
>>>>>>> "Software"),
>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>> without limitation
>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>> sublicense,
>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>> whom the
>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>> conditions:
>>>>>>> + *
>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>> be included in
>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>> + *
>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>> KIND, EXPRESS OR
>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>> MERCHANTABILITY,
>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>>> EVENT SHALL
>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>>> DAMAGES OR
>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>> OTHERWISE,
>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>> THE USE OR
>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +#include <drm/drm.h>
>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>> +
>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>> +{
>>>>>>> +    switch (hint) {
>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>> +    default:
>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>> +
>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>> +                uint32_t hint)
>>>>>>> +{
>>>>>>> +    int ret = 0;
>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>> +
>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>
>>>>>> If it's all about pm subsystem variable accesses, this API should 
>>>>>> rather be inside amd/pm subsystem. No need to expose the variable 
>>>>>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>>>>>> protected under one mutex. Then this extra lock won't be needed.
>>>>>>
>>>>>
>>>>> This is tricky, this is not all about PM subsystem. Note that the 
>>>>> job management and scheduling is handled into amdgpu_ctx, so the 
>>>>> workload hint is set in context_management API. The API is consumed 
>>>>> when the job is actually run from amdgpu_run() layer. So its a 
>>>>> joint interface between context and PM.
>>>>>
>>>>
>>>> If you take out amdgpu_workload_to_power_profile() line, everything 
>>>> else looks to touch only pm variables/functions. 
>>>
>>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>>> profile. And going by that logic, this whole code was kept in the 
>>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. So 
>>> to avoid these conflicts and having a new file is a better idea.
>>>
>>> You could still keep a
>>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>>> mutex can be avoided as well.
>>>>
>>> The lock also protects pm.workload_mode writes.
>>>
>>>>>>> +
>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>> +        goto unlock;
>>>>>>> +
>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>> +    if (!ret)
>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>
>>>>>> Why is this reference kept? The swtiching happens inside a lock 
>>>>>> and there is already a check not to switch if the hint matches 
>>>>>> with current workload.
>>>>>>
>>>>>
>>>>> This reference is kept so that we would not reset the PM mode to 
>>>>> DEFAULT when some other context has switched the PP mode. If you 
>>>>> see the 4th patch, the PM mode will be changed when the job in that 
>>>>> context is run, and a pm_reset function will be scheduled when the 
>>>>> job is done. But in between if another job from another context has 
>>>>> changed the PM mode, the refrence count will prevent us from 
>>>>> resetting the PM mode.
>>>>>
>>>>
>>>> This helps only if multiple jobs request the same mode. If they 
>>>> request different modes, then this is not helping much.
>>>
>>> No that's certainly not the case. It's a counter, whose aim is to 
>>> allow a PP reset only when the counter is 0. Do note that the reset() 
>>> happens only in the job_free_cb(), which gets schedule later. If this 
>>> counter is not zero, which means another work has changed the profile 
>>> in between, and we should not reset it.
>>>
>>>>
>>>> It could be useful to profile some apps assuming it has exclusive 
>>>> access.
>>>>
>>>> However, in general, the API is not reliable from a user point as 
>>>> the mode requested can be overridden by some other job. Then a 
>>>> better thing to do is to document that and avoid the extra stuff 
>>>> around it.
>>>>
>>> As I mentioned before, like any PM feature, the benefits can be seen 
>>> only while running consistant workloads for long time. I an still add 
>>> a doc note in the UAPI page.
>>>
>>
>>
>> a) What is the goal of the API? Is it guaranteeing the job to run 
>> under a workprofile mode or something else?
> 
> No, it does not guarentee anything. If you see the cover letter, it just 
> provides an interface to an app to submit workload under a power profile 
> which can be more suitable for its workload type. As I mentioned, it 
> could be very useful for many scenarios like fullscreen 3D / fullscreen 
> MM scenarios. It could also allow a system-gfx-manager to shift load 
> balance towards one type of workload. There are many applications, once 
> the UAPI is in place.
> 
>>
>> b) If it's to guarantee work profile mode, does it really guarantee 
>> that - the answer is NO when some other job is running. It may or may 
>> not work is the answer.
>>
>> c) What is the difference between one job resetting the profile mode 
>> to NONE vs another job change the mode to say VIDEO when the original 
>> request is for COMPUTE? While that is the case, what is the use of any 
>> sort of 'pseudo-protection' other than running some code to do extra 
>> lock/unlock stuff.
>>
> 
> Your understanding of protection is wrong here. There is intentionally 
> no protection for a job changing another job's set workload profile, coz 
> in that was we will end up seriazling/bottlenecking workload submission 
> until PM profile is ready to be changed, which takes away benefit of 
> having multiple queues of parallel submission.
> 
> The protection provided by the ref counter is to avoid the clearing of 
> the profile (to NONE), while another workload is in execution. The 
> difference between NONE and VIDEO is still that NONE is the default 
> profile without any fine tuning, and VIDEO is still fine tuned for VIDEO 
> type of workloads.
> 

Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);

The line that follows is amdgpu_dpm_switch_power_profile() - this one 
will allow only single client use- two jobs won't be able to switch at 
the same time. All *dpm* APIs are protected like that.

Protection 2 is - ref counter.

It helps only in this kind of scenario when two jobs requested the same 
mode successively -
	Job 1 requested compute
	Job 2 requested compute
	Job 1 ends (doesnt't reset)

Scenario - 2
	Job 1 requested compute
	Job 2 requested compute
	Job 3 requested 3D
	Job 1 ends (doesnt't reset, it continues in 3D)

In this mixed scenario case, I would say NONE is much more optimized as 
it's under FW control. Actually, it does much more fine tuning because 
of its background data collection.

> In the end, *again* the actual benefit comes when consistant workload is 
> submitted for a long time, like fullscreen 3D game playback, fullscreen 
> Video movie playback, and so on.
> 

"only under consistent", doesn't justify any software protection logic. 
Again, if the workload is consistent most likely PMFW could be managing 
it better.

Thanks,
Lijo

> - Shashank
> 
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
>>>>>>> +
>>>>>>> +unlock:
>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>> +                  uint32_t hint)
>>>>>>> +{
>>>>>>> +    int ret = 0;
>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>> +
>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    /* Do not reset GPU power profile if another reset is coming */
>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>> +
>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>> +        goto unlock;
>>>>>>> +
>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>> +    if (!ret)
>>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>> +
>>>>>>> +unlock:
>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>> +    return ret;
>>>>>>> +}
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>>>>> *adev,
>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>> @@ -0,0 +1,54 @@
>>>>>>> +/*
>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>> + *
>>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>>> obtaining a
>>>>>>> + * copy of this software and associated documentation files (the 
>>>>>>> "Software"),
>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>> without limitation
>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>>> sublicense,
>>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>>> whom the
>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>> conditions:
>>>>>>> + *
>>>>>>> + * The above copyright notice and this permission notice shall 
>>>>>>> be included in
>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>> + *
>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>> KIND, EXPRESS OR
>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>> MERCHANTABILITY,
>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>>> EVENT SHALL
>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>>> DAMAGES OR
>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>> OTHERWISE,
>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>> THE USE OR
>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>> +#include "amdgpu.h"
>>>>>>> +
>>>>>>> +/* Workload mode names */
>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>> +    "None",
>>>>>>> +    "3D",
>>>>>>> +    "Video",
>>>>>>> +    "VR",
>>>>>>> +    "Compute",
>>>>>>> +    "Unknown",
>>>>>>> +};
>>>>>>> +
>>>>>>> +static inline const
>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>> +{
>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>> +        return 
>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>> +
>>>>>>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>> +}
>>>>>>> +
>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>> +                uint32_t hint);
>>>>>>> +
>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>> +                uint32_t hint);
>>>>>>> +
>>>>>>> +#endif
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>> +    /* SMU workload mode */
>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>> +    uint32_t workload_mode;
>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>> +
>>>>>>>       struct config_table_setting config_table;
>>>>>>>       /* runtime mode */
>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>
