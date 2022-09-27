Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30AEC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46FD10E928;
	Tue, 27 Sep 2022 12:54:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EE110E920
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqQvziwTssnUyQhfRwVRfz8ZEAO6HQaWQqmqQTPMCKFmdqUk9owExHw/rVmBjciPyWH76QlesKjhgsSo092wWN/ijcADnewwP1TkFxCoSyY3P0jKoM+Y9pAEyuynvGV8s7mT3lnFcWvscrUZophOsJLBgosYF7aZfZ4ioAU95sd1a6xKkE7wRDVjktmjZivnqnQU0usOfr/5nc98s5q5NvDhxBztqBYk2cG6j6y8/RRlOkmKgwmSgovn03DsYLMFuyL4UHJYgmdM58VlwPeAU7FZBt1u3JrtgLbjBZgnykVJ00FwhFVquwSYqiCIOK8gaLTlUlUluTzWV0LFiJWwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy55fDGWhG0wZbfJAsaEkOgBkCfPysjlwERQgB+0ZMs=;
 b=bdkvZ1HcVxcqWQU2JxNYQzBllkFoQFmiR7CT23+hn0Zlk1gWFQvujUkxzPdaf8mwIt6nuu4y9qS9vaiMfSBGgZVhCgSDGKJDrzg7Bf7E8DGzWXAbuIJ2kP3vMHZLGwOCucVKmK3+Sy/GWHV/7Kea1+1yiHYWuaQRTsJy0ViRlOhVQbgTWu8HI9bYiNY5LdiMPDGAfFU+BlCDEIM9tl/63MBatA8BJrAyjSjPtAj1qN6C3aMumGsJwVRoiABciwGCyzzd/HptJYehnw11YG3sxNlYhJG5i10v2pxB593h7rT/ONBA1P+h7O4bZdmZiA0+tehDUsAYxqvWfHx3vcyIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy55fDGWhG0wZbfJAsaEkOgBkCfPysjlwERQgB+0ZMs=;
 b=MABa0Arp0NWjcAOCgrrRHUxKV3ME7IbDRI51aVKH+z+RhiqXYzJEW/uoeSKZtXrmOp0oOWnis6wOMLBoT2v93ibhTu3lINEHe2lgRW7n2dH5SlRcONE2Gl7hQkpg56bXBOvMAhC4CVD/k6brF2XBtjuUIyWloeBCLmrnfmUWLSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 12:54:05 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 12:54:05 +0000
Message-ID: <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
Date: Tue, 27 Sep 2022 14:53:57 +0200
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
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4f48b8-c7b3-41d7-a435-08daa0875bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GSYsAV9oY8kX+gY/w2d0jkF/QHsGW/ItjASE1ErkLFxUSKX2sGXHTcDtKq5cKKc2Db8QLgTV82kNVwQQGg5QmteM5OUxuwo0yrYEe/NkakeFJfX4RH6BqXEkYLoRx3j3ismtpccN274IfEDBLWCXnsxHF2HKrUvHoDkjX8gdk1fSIPkcvd5Lujm4kOqV5VTkNCME3stzltzg2oVePtqddrxt7O5yVdND+zQjddmUBFMDQC5+g9HtBy/fOjN5G1tr9HYPVsN555m+eLWn8YBZ95khZuWuFC7CMu3AQheaVsw2HauAsgM/+9/mEDU3COGt0QAfcmQxpHupGa7VP57Ue/uaCU1QXU+FJ0GXsn3ZhlbJ7fKVPayMMJQb6UK7b05hh5Q3XJkcGQOPuU95nrFDV2o2Ld7rxY/qsmsjUoQwPkKCISJTFYX0Ik0JowsGvObqwWyfW8nkdy0z57RX7rub4KOZyyX7eTiMpZukQ9dJZ94KCnzMKqAORF1V3JeCck5R5oBCgUoLsg7KroCNeMGHmj5PYr6Pix82+kULMgFbLj3oLb7RUcz96LfA+IoBGC3IcFqD/E/pUFbpdzcSrNV6JOUVZxldODiCGuvGEFRVqZB9un1eWP4rAckEQ3/MV6k/7i9YPkSiej9c/Lo2bLKUgiXrtHcPuJOlcnfZsUbCHlZka2AqoY7+sZFlBek5gn4pTz8U6SJRaAiaPlPw2a7JG3O1o2JHC8a/rQRPOWDgzBlywttX/Fdttyk8ERh9xPRsJs6CZvWveSlAaQUX0gecx8/Q64wccd4NsX3nZrmUMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(186003)(83380400001)(31696002)(316002)(8936002)(86362001)(66476007)(66556008)(6512007)(41300700001)(8676002)(4326008)(478600001)(2616005)(26005)(36756003)(2906002)(31686004)(6486002)(30864003)(66899015)(6506007)(38100700002)(66946007)(6666004)(53546011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJnOUk2dUgzVHpONWQ2ZnFoUGM3eG4yblFlYm51RWFvYkhnMU9ZSlZWUjlJ?=
 =?utf-8?B?UkZMVWgvZjdIaDV2emVBZXZ5OVh5ODZJRXUwRzFjQlQ2djkyQm5YMXNwcnZE?=
 =?utf-8?B?QW9DaE1HTlNJQ2IxaFd5QkRWcFB4M0ZPRkdsWWtzTTJSSW9Db3NQZzRvNXdV?=
 =?utf-8?B?SFJ0SVFCdURPOTF1UGkwNnNDOFRqaFBQdWhIb0duMzB3NXBMWWs2R3Q0OWpz?=
 =?utf-8?B?MlNOTWtYczQvbm1yU0kzeDFrNmJzVnZGVTBCWmM1SkJlbnRHV05pOGd1Y291?=
 =?utf-8?B?Ty9jR1g3N1hkanNLUlNDM3g4Yk9DZUV1ZEpPa2lCbTRKaVNMTlUvOUhlOUFX?=
 =?utf-8?B?a1JEMjY2L3ZHN0FETXY4NEduekV6Szg1SXNaRGswY252Y3FUT2I1eUFNZGk5?=
 =?utf-8?B?N3RNbkUyV1BTT1dhYzlTSkk4YVlrdVdNNldNa3Rlb2ZnMUw3eEo4ZEF2OWJs?=
 =?utf-8?B?VWRDMklOSG1FOHVoenNrNnFDWGJCSGJZMUJ4R01LOHAwWlpBQlUwWVdwcW8x?=
 =?utf-8?B?aC83SnZpTVBNQjBDdHpMS0lMVkNWcWN2NVRCVENzQ3dJUUhDeFdSVWs5Nm9n?=
 =?utf-8?B?WlNDMHNRN09UVjFwSXNwN2g0NlRvYlV3dDRRN3hQWU9iZ3JRUXFWUjJ5VmNE?=
 =?utf-8?B?YjljUExETjBEY21oSm1QU0lURk12dHhTTGVsRTdHd0F1SFZVdTdDeWR5bXFM?=
 =?utf-8?B?NkYwY1dzQlZ2WHhLeUlmM2ErZ05xaGhsak1EQnEwQ0x3b09YTGtKOXJGYVc5?=
 =?utf-8?B?b0NsUXhGOWNZdnlXSTBKU3JFZTNLak4yM1NocU1ab09nZ0xxLzVHSm5pQW9a?=
 =?utf-8?B?TWRhU2h2MFE0SzRUWnpnU0ZNV0d3Y09VRFRueld6cnc3Q3BsQm13eEZqNmxL?=
 =?utf-8?B?QmFrS21aSGVuM0ZEbEx1SHdFN0lZTGpmbmlteXUybGkwMDlSZUxhSnJQTmpn?=
 =?utf-8?B?Vi9KNUk1UVVSb2Z4RlgxVzhaZ2xETkQ3TE42WG9wSGZzNG5JNVlLM3NLbUxQ?=
 =?utf-8?B?UnZiL0tzZ2MyMEVjb1V3MXBhTHFHYjdDSnorSGprKy9TbkRzS0tDQ3V5TDFl?=
 =?utf-8?B?T0FpRmJUVDRlNHZlS3hldHZqZlBNdldIM3RxcytqK0NRcWx4UFJlM3ZpajZG?=
 =?utf-8?B?N1AwRVZGVG9INkY0bURJMnMvcUpZL3B2WDhUOVZHUGtoQ2xCMmU1ejFMQ0s3?=
 =?utf-8?B?WlIyVjFiU1dqY1dTYjczTFNOZEVIcHFjdzRxTkdOT3BCNDJpNG9wQU4yTHg0?=
 =?utf-8?B?NGtwSzZ3ZytjZTVkVEZPMlRDRUVTaWtIdGRZZVlNTHZ2R0FDbkZhZjM5Vk1D?=
 =?utf-8?B?WVEvczhDb2N2Q1hJRjViQ09wUTFld0dDZ3IwWjZMOWRISUhtd3NCaU1PNkRx?=
 =?utf-8?B?bXZIRDRVdkx3RXl5Qjc0WlBHUG1SU2JrM1RlVE5PWjRuQ0d2NmlEZG5NSzdZ?=
 =?utf-8?B?OEFEazlwVUFmL1llRkt3VkI2Y1p1UWIzcHlmUEtEbEtJTWV2cnVHMU92RTN2?=
 =?utf-8?B?MnI5czRleitQeUFLOU9rY0NZT2psRWVqdnFZVU8vcVNVOTNiVFdmNzRPVnEv?=
 =?utf-8?B?cWFpeVJXOVBaQ00wNzlESkVyN1VpTEhqTGRXYk00cEZTU0NFbEVTZ1c4NHda?=
 =?utf-8?B?ZHYzVTBsZ0hmdDBuUE8vYmtmQnZMSmhTN3BnN2x0K1NMVURCUmF4UWJVL3pP?=
 =?utf-8?B?ZmNJSGZUZGVIcmMrY0tNcG5TcDA3NkJ5VDFENitwSlNIZDJlTXpoZk41RFRo?=
 =?utf-8?B?UmlZdVFNS3FZRk5palcxZ0NtN0VTamRJQ25KaXp2OUs5TThvaEMwNDBrTEpN?=
 =?utf-8?B?STdXcjhKM01JRG8vNnlUWGYwZzRubE40VlhSY0N5b1lTZ1FoSmhYWTZhTEtG?=
 =?utf-8?B?U2dxMnUyWjdJajVScHE3enp2dHliM2lZdGZqL2ZCWlhGb2dxRmhRN3VXbXp6?=
 =?utf-8?B?a3hIc0t0NFJWQnlRR3RDN0NnTGhlaHZJRmhwWG1EbGRET0dyQnpLWWFTZStk?=
 =?utf-8?B?TnRTNVV4V09MSTJsVjlCdVNYNW9RRFNaTkhpY29QR2poeFQydTExYzFEeE5P?=
 =?utf-8?B?WklWajVydWdMVWtIQjlxTHptZFhpdWFlUTk4bGlDanV2WE4wSzlGd0VLUjBF?=
 =?utf-8?Q?yD95knPoB56C+feAvMDsx2xMT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4f48b8-c7b3-41d7-a435-08daa0875bce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:54:05.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YYnfHn2eoklHV2NK/bjWAiLQ0uwOYD2m0A6OSNHwpY2yo78J9KVfxRFvAnZ/Qlo14y02AzC640ptpvaMMDfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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



On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>> This patch adds new functions which will allow a user to
>>>>>> change the GPU power profile based a GPU workload hint
>>>>>> flag.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>> +++++++++++++++++++
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>   create mode 100644 
>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>> amdgpu_pll.o \
>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>> amdgpu_virt.o \
>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..a11cf29bc388
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>> @@ -0,0 +1,97 @@
>>>>>> +/*
>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including without 
>>>>>> limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall be 
>>>>>> included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>>> USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +#include <drm/drm.h>
>>>>>> +#include "kgd_pp_interface.h"
>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>> +
>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>> +{
>>>>>> +    switch (hint) {
>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>> +    default:
>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>> +
>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>> +                uint32_t hint)
>>>>>> +{
>>>>>> +    int ret = 0;
>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>> +
>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>
>>>>> If it's all about pm subsystem variable accesses, this API should 
>>>>> rather be inside amd/pm subsystem. No need to expose the variable 
>>>>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>>>>> protected under one mutex. Then this extra lock won't be needed.
>>>>>
>>>>
>>>> This is tricky, this is not all about PM subsystem. Note that the 
>>>> job management and scheduling is handled into amdgpu_ctx, so the 
>>>> workload hint is set in context_management API. The API is consumed 
>>>> when the job is actually run from amdgpu_run() layer. So its a joint 
>>>> interface between context and PM.
>>>>
>>>
>>> If you take out amdgpu_workload_to_power_profile() line, everything 
>>> else looks to touch only pm variables/functions. 
>>
>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>> profile. And going by that logic, this whole code was kept in the 
>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. So 
>> to avoid these conflicts and having a new file is a better idea.
>>
>> You could still keep a
>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>> mutex can be avoided as well.
>>>
>> The lock also protects pm.workload_mode writes.
>>
>>>>>> +
>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>> +        goto unlock;
>>>>>> +
>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>> +    if (!ret)
>>>>>> +        adev->pm.workload_mode = hint;
>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>
>>>>> Why is this reference kept? The swtiching happens inside a lock and 
>>>>> there is already a check not to switch if the hint matches with 
>>>>> current workload.
>>>>>
>>>>
>>>> This reference is kept so that we would not reset the PM mode to 
>>>> DEFAULT when some other context has switched the PP mode. If you see 
>>>> the 4th patch, the PM mode will be changed when the job in that 
>>>> context is run, and a pm_reset function will be scheduled when the 
>>>> job is done. But in between if another job from another context has 
>>>> changed the PM mode, the refrence count will prevent us from 
>>>> resetting the PM mode.
>>>>
>>>
>>> This helps only if multiple jobs request the same mode. If they 
>>> request different modes, then this is not helping much.
>>
>> No that's certainly not the case. It's a counter, whose aim is to 
>> allow a PP reset only when the counter is 0. Do note that the reset() 
>> happens only in the job_free_cb(), which gets schedule later. If this 
>> counter is not zero, which means another work has changed the profile 
>> in between, and we should not reset it.
>>
>>>
>>> It could be useful to profile some apps assuming it has exclusive 
>>> access.
>>>
>>> However, in general, the API is not reliable from a user point as the 
>>> mode requested can be overridden by some other job. Then a better 
>>> thing to do is to document that and avoid the extra stuff around it.
>>>
>> As I mentioned before, like any PM feature, the benefits can be seen 
>> only while running consistant workloads for long time. I an still add 
>> a doc note in the UAPI page.
>>
> 
> 
> a) What is the goal of the API? Is it guaranteeing the job to run under 
> a workprofile mode or something else?

No, it does not guarentee anything. If you see the cover letter, it just 
provides an interface to an app to submit workload under a power profile 
which can be more suitable for its workload type. As I mentioned, it 
could be very useful for many scenarios like fullscreen 3D / fullscreen 
MM scenarios. It could also allow a system-gfx-manager to shift load 
balance towards one type of workload. There are many applications, once 
the UAPI is in place.

> 
> b) If it's to guarantee work profile mode, does it really guarantee that 
> - the answer is NO when some other job is running. It may or may not 
> work is the answer.
> 
> c) What is the difference between one job resetting the profile mode to 
> NONE vs another job change the mode to say VIDEO when the original 
> request is for COMPUTE? While that is the case, what is the use of any 
> sort of 'pseudo-protection' other than running some code to do extra 
> lock/unlock stuff.
> 

Your understanding of protection is wrong here. There is intentionally 
no protection for a job changing another job's set workload profile, coz 
in that was we will end up seriazling/bottlenecking workload submission 
until PM profile is ready to be changed, which takes away benefit of 
having multiple queues of parallel submission.

The protection provided by the ref counter is to avoid the clearing of 
the profile (to NONE), while another workload is in execution. The 
difference between NONE and VIDEO is still that NONE is the default 
profile without any fine tuning, and VIDEO is still fine tuned for VIDEO 
type of workloads.

In the end, *again* the actual benefit comes when consistant workload is 
submitted for a long time, like fullscreen 3D game playback, fullscreen 
Video movie playback, and so on.

- Shashank

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
>>>>>> +
>>>>>> +unlock:
>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>> +                  uint32_t hint)
>>>>>> +{
>>>>>> +    int ret = 0;
>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>> +
>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    /* Do not reset GPU power profile if another reset is coming */
>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>> +
>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>> +        goto unlock;
>>>>>> +
>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>> +    if (!ret)
>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>> +
>>>>>> +unlock:
>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>>>> *adev,
>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>> new file mode 100644
>>>>>> index 000000000000..6060fc53c3b0
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>> @@ -0,0 +1,54 @@
>>>>>> +/*
>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>> + *
>>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>>> obtaining a
>>>>>> + * copy of this software and associated documentation files (the 
>>>>>> "Software"),
>>>>>> + * to deal in the Software without restriction, including without 
>>>>>> limitation
>>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>>> sublicense,
>>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>>> whom the
>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>> conditions:
>>>>>> + *
>>>>>> + * The above copyright notice and this permission notice shall be 
>>>>>> included in
>>>>>> + * all copies or substantial portions of the Software.
>>>>>> + *
>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>> KIND, EXPRESS OR
>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>> MERCHANTABILITY,
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>>>> EVENT SHALL
>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>>> DAMAGES OR
>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>> OTHERWISE,
>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>>> USE OR
>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>> + *
>>>>>> + */
>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>> +#include "amdgpu.h"
>>>>>> +
>>>>>> +/* Workload mode names */
>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>> +    "None",
>>>>>> +    "3D",
>>>>>> +    "Video",
>>>>>> +    "VR",
>>>>>> +    "Compute",
>>>>>> +    "Unknown",
>>>>>> +};
>>>>>> +
>>>>>> +static inline const
>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>> +{
>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>> +        return 
>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>> +
>>>>>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>> +}
>>>>>> +
>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>> +                uint32_t hint);
>>>>>> +
>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>> +                uint32_t hint);
>>>>>> +
>>>>>> +#endif
>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>> +    /* SMU workload mode */
>>>>>> +    struct mutex smu_workload_lock;
>>>>>> +    uint32_t workload_mode;
>>>>>> +    atomic_t workload_switch_ref;
>>>>>> +
>>>>>>       struct config_table_setting config_table;
>>>>>>       /* runtime mode */
>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>
