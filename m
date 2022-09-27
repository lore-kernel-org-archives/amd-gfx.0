Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DB5C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 12:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74010E910;
	Tue, 27 Sep 2022 12:23:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2870610E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 12:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQcK/fG29+P7cg505XXX37YAZ4mH5qB9RXG7vfxNBryo9PxUIh7A5RmNLDxV1fnQc+pNsOkBL+JXUrQhf5OZz3y0/RstwkEJJsaaKO6MKnkR4f2+0TNFN9zII7Mo4zZfQdHBTjwRn/hxgsaIYu6FZS4Q66hHVG+nY/K1DjNBcfVYNAREV8ri1Kzqezhx1+qWtuPZCS6MPxuayTSc14EKn/BXGBiegeVaVHAc2JrSZSV0iDAmqJyqDlozGrU+8xGCBqCv89xaOc22v+e8a2Jf8edLMB2u6z//MeJ3HLNbheMatr687zRjTiMqtXLq7b4Mk6u7KiGbT1URFQkGHb7EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IL4dMtAFw59jMCYjkKn69dGo9iLp2TRVqC+EyemWWw=;
 b=B7tNjAHXZdd4V/uI6Y9hHsC1cRHfGaoLSBgbc2wvJ/RVDU3s1oYkrFTfUR5wqLB02//Rpgt6OQlwWR8peKGauM7olAoxilf9mGAT5bnI35qSL6QwsZsufmz5VpOpZmI2zGpRv+p5MPgZOjSnHaW25iIDY6WuZs24XWPFRzK+rDfgXFweWluNsuw88+hc++3d3WoGrDUQ6YUfN+SlRRfquJeOgiDksc5gSvEei+RbvSfYPwtnGi766bW8wVaLvEPZobenU2BjMpt4f/JntP8DTuh05ylbqW10b6mh+WCM/Lt4kga+YrMewV76uoGmzE6Spz22L/xidb7HvTGCL+InNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IL4dMtAFw59jMCYjkKn69dGo9iLp2TRVqC+EyemWWw=;
 b=OAvoCttX57oC64oe9DI3EjpHqaKT2Hk2xG7SnFuHW/qwJGIDBGH4zw8cddS++BbNr0fGCHw4D4P78SW6DvpKEpKhJZWSD62dPG0GhlY6e0ZbeR+/SXKgIOsjswembKamZEbAk96ieFSFv12U20M1reISvjvm6KqAIzo1fACkLMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 12:23:50 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 12:23:50 +0000
Message-ID: <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
Date: Tue, 27 Sep 2022 14:23:41 +0200
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
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0037.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6bbd9d-2cb3-4818-4854-08daa083222f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw5kvyodApxyWmzft789UVIWv2bGNQpIpZVIpCKaAWthYuB1YoNlessU8Pm4ZBk0CtKNxZO94fituCtAm2HZcym3JMMebfTfv/5wd9zYVfvnphNhK/O5cNpgtlCR7X+H+TUmaegBmcdT+Dtijeneeko1QzexhRJVC3OBblhJ2cMfHq5cyLEBPHrM6nMroUsdYL50HoK5evodGXc7FNmR/gApJB/QryCUnqyRL0pzoC5149KyzEkbi+2/M9czc3lBEa2fP9k92dkg4BR6aGOaSoNBIX9FejICjjQQaCmOYo3A3EQNvRK7KNHQtw6fO83P1KRYn+4gCiaALuFAG+DcTmT7y3EnlA92OkKv77ZBXd38AfojIV0fmRqBNrtvRvD8IiSNf0tTOjG7GWIfzTNZ9IXgHk9Anvp7DcMC7CXqHL+iGpdREYCfOcflIa8BLSK1NM4GEIw+hqck3UmCwinyiwP/QbPrCWdhHyM9SYbOVhRxrl1RaH9dloW1B4pPhOrDTqu8NA4Xko2VepM7M/rlZ/zkF1CpbnptqV3LLbnGlDmSuaulmVNFAiwsiWmAmVCvtrY66wHAbeKIELYBNqvr3/9pgRUnq5cWpFW4+sBBc+XPvJLzL0MwxykCGjjnXdxASHVD28yIbTfGszgmmFj1vEJYooOtpjkl5nyQif0UHRlKenUIXo4fU9bmn1l37/JX+vYgtkx70UsvuGhskSzgprykFYMVeTqxKbxdqPeHGF/+rnUnaCsRlZyJKdNrDsGm3/RphWJ4Xfuvs8GIwlShPV8cWibyZ5fQOhNcm/b3xdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(6512007)(26005)(6486002)(8936002)(41300700001)(31686004)(6666004)(478600001)(4326008)(6506007)(8676002)(53546011)(5660300002)(30864003)(2616005)(2906002)(36756003)(83380400001)(38100700002)(66899015)(66946007)(316002)(66556008)(86362001)(31696002)(66476007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzV1NlQ2TUtFM1QrbUVZYm5IZmdIUmxtQlV1d1VwY1ZPZTJwQ1EvOHV1WDVH?=
 =?utf-8?B?M1hzL0dmaEw2dCtoR1NPZEpxVk13cGcwT2xFeGx0SFpYamJEbElSNGJYOEhF?=
 =?utf-8?B?QWo2NFo4Um96ekdmd1o1WEs3VVNTOS95eFZGMFhQYmoyYlBMWS9rSGphazI3?=
 =?utf-8?B?a05jTk9pbTJNM01LMFNjaXl4aW41enh1UUNKTUYrMDRodXN5SVdUa0JyZWZ5?=
 =?utf-8?B?TVJJRE9PRWR3bWI2M0xiU2VDRkhSblhZV2JLcmlVSUY4akN4bmptYXA4N0Zh?=
 =?utf-8?B?YWNFVERTVmtUcTlZYmgwdU1MM0ZZOUhEdXppdUorb3hkWUo0YXR5a2Nndzdj?=
 =?utf-8?B?Zm91QWJQWGlGSzg1a3AxSjN3cThZSHdlVUZjV3UwVGxNR3BaZUQzcXgrdWZj?=
 =?utf-8?B?cmJjakk4TWVha0ZCUGVIWjViYjJhUmd2TTAyazVYYndqRVRvNDF4NDlWL3lt?=
 =?utf-8?B?aW5nWWdzZmxFdlpMYktLZzFUY0JPZ1hrR1h6djM3WUNKa2s5clJoTjBBZmdN?=
 =?utf-8?B?N3RPUytzQXVIK2FHb0R5eXZCaS94KzJCTVh3K1hYR1V5Ri9CeCtjLzltanBO?=
 =?utf-8?B?NXVLK0lsNmpqVjB1dEt0aDJOa1I1ZGdkU1YxNWlWT00zMktzY09LdW1HaDJy?=
 =?utf-8?B?ZEJjUndHUjh6UFRxSHdYSFp3MUxYK0p1Y2p0NWFmWnhIWDhMUHFMOGpMeTlP?=
 =?utf-8?B?OEVmL2J5NVVkRTJpZElibjhxTGs0b2ErTThTa2psa256T3BGN2R2TlFLdC9a?=
 =?utf-8?B?QVFzb0RWYWZhQ0U2bWZrS3IvWXF2b0tYRW9VN044TXZUNi96MWZpdHVmZGR4?=
 =?utf-8?B?Z2p1MWVrc2VBTm5LbjNsbFNzV2RaZjNXSHJRZmR4Nm5scHc2eVJLRDZNZmhG?=
 =?utf-8?B?dXJ6S29IVGdiOEx1NjVxdzJGNXExUm9CaHBSaStXZ3BiM1Q5eEJWU3RDSHhC?=
 =?utf-8?B?ZFVlSzRRZXcwMVBHbEt3UUIvaVZ1L2dJbEFxVTVQMWsrUWkzQTJZMWpDNFdC?=
 =?utf-8?B?bGw5bFFGREpWNTF3M2pmVTNxT3UrRlZvTXVGR245Wm9JaUpGS0pubzVGY2xu?=
 =?utf-8?B?VWJ6elRUSGhwRlBuSVZUbDM0ZWZJUnI3UXRiY2pCZWE4Ukw4alRYSzRLTTE5?=
 =?utf-8?B?ckdjeTlUaG5kOFE0RHMzb21SL01obzAyMWVPbTdoTE43TkVkaElzd2NldU5U?=
 =?utf-8?B?RThKMXI4MDIrcUZNYk9DUm1xaTB4SUZxazQ0MmsxUklGdkRLaXlkRllRZVdL?=
 =?utf-8?B?dVdRRjVBd1FJeGZRTmRTSDBUWHFTT1RNNGVQMGFZWExpTHVBdEdsZ1FmRXVJ?=
 =?utf-8?B?V2l2SEZRZ0thczFYazRKSEdqK3AyRld2RjlKRHliTVh5YWNCSWFqTzJIb1dC?=
 =?utf-8?B?TVp6c0dyRGRPZmk5ZjZjWE9Nd0lqUStiNXhmYmZQWVpjakxHVFVlMjFNS0Mr?=
 =?utf-8?B?UjJBdFJCcy9KUzZPZGZsRC9hdEhpREdnU1dIbVN0OWc4cjhaSWRkckdCSG9U?=
 =?utf-8?B?Q0VNQVhkNEV4LzRyUDI4d0x0b21PUWN4aVZrbENkSjVkVW5KTlFjeFN1ODZr?=
 =?utf-8?B?QTRqek1qZEt2cXV1UVdDaUVWczdPa0lxYjZYK1QwSmpZWFRSeTl2eENaUkJV?=
 =?utf-8?B?MTd5TWJpTnpYZXNxSFZJWTVacVc1Z3hyUExYNFpjOG9QWnZlaGxWYUg1cWZ6?=
 =?utf-8?B?VlB6QzI2Q2szbnFHVlMvWnY2Vm9oZ3VKY3h4ZG9XTDNxWFJIZVVma1krNU9z?=
 =?utf-8?B?amp1dzh5ZXdlUVE0Q1BURmFsQW9oMHd2b2RETFFkK1dCelJjMVBGQ0JpbXlp?=
 =?utf-8?B?TW8vdnEyQ09GYVpST3hMWElOSVNQSWwzTzR1N3J3a1VlRzJ3MlJnWWF1eHhr?=
 =?utf-8?B?Q3EwQXVwRDRUSXJLcnNidDFvU1VjcXdVTUxLc0RJK1FFQXlxSmJrOEgvS3Bn?=
 =?utf-8?B?TDlKMzVJdkdLd2hlM0VrT3ZKSFBHN3g0Z0hlTTZqVW9YSkdKVmVZN09OazZ0?=
 =?utf-8?B?c3RUSkZ5eFhCR3U4WjhwNWxyWEd2Y0MweG5wK2VPN0QyRlc5cmx1eU96bTE0?=
 =?utf-8?B?aWtvN1MycEtZV0d2QzJ5MUYxb2pzYllRbGFzdE5xeTR5UllJdWlqRkR4UklK?=
 =?utf-8?Q?E12PTgHE8DEMxEsZgDG3Bgpxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6bbd9d-2cb3-4818-4854-08daa083222f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 12:23:50.2593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqOtI+Os06+itS4D+CzBFgmJu7Bv4TuohhKeNreZlff+zaY7JUuCvKI9g0TOeBc0bigkzGD0uHtEwKMjgagIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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



On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>> This patch adds new functions which will allow a user to
>>>> change the GPU power profile based a GPU workload hint
>>>> flag.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>> +++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>> amdgpu_pll.o \
>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>> amdgpu_virt.o \
>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> new file mode 100644
>>>> index 000000000000..a11cf29bc388
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> @@ -0,0 +1,97 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#include <drm/drm.h>
>>>> +#include "kgd_pp_interface.h"
>>>> +#include "amdgpu_ctx_workload.h"
>>>> +
>>>> +static enum PP_SMC_POWER_PROFILE
>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>> +{
>>>> +    switch (hint) {
>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>> +    default:
>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>> +
>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>> +    }
>>>> +}
>>>> +
>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>> +                uint32_t hint)
>>>> +{
>>>> +    int ret = 0;
>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>> +            amdgpu_workload_to_power_profile(hint);
>>>> +
>>>> +    if (adev->pm.workload_mode == hint)
>>>> +        return 0;
>>>> +
>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>
>>> If it's all about pm subsystem variable accesses, this API should 
>>> rather be inside amd/pm subsystem. No need to expose the variable 
>>> outside pm subsytem. Also currently all amdgpu_dpm* calls are 
>>> protected under one mutex. Then this extra lock won't be needed.
>>>
>>
>> This is tricky, this is not all about PM subsystem. Note that the job 
>> management and scheduling is handled into amdgpu_ctx, so the workload 
>> hint is set in context_management API. The API is consumed when the 
>> job is actually run from amdgpu_run() layer. So its a joint interface 
>> between context and PM.
>>
> 
> If you take out amdgpu_workload_to_power_profile() line, everything else 
> looks to touch only pm variables/functions. 

That's not a line, that function converts a AMGPU_CTX hint to PPM 
profile. And going by that logic, this whole code was kept in the 
amdgpu_ctx.c file as well, coz this code is consuming the PM API. So to 
avoid these conflicts and having a new file is a better idea.

You could still keep a
> wrapper though. Also dpm_* functions are protected, so the extra mutex 
> can be avoided as well.
> 
The lock also protects pm.workload_mode writes.

>>>> +
>>>> +    if (adev->pm.workload_mode == hint)
>>>> +        goto unlock;
>>>> +
>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>> +    if (!ret)
>>>> +        adev->pm.workload_mode = hint;
>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>
>>> Why is this reference kept? The swtiching happens inside a lock and 
>>> there is already a check not to switch if the hint matches with 
>>> current workload.
>>>
>>
>> This reference is kept so that we would not reset the PM mode to 
>> DEFAULT when some other context has switched the PP mode. If you see 
>> the 4th patch, the PM mode will be changed when the job in that 
>> context is run, and a pm_reset function will be scheduled when the job 
>> is done. But in between if another job from another context has 
>> changed the PM mode, the refrence count will prevent us from resetting 
>> the PM mode.
>>
> 
> This helps only if multiple jobs request the same mode. If they request 
> different modes, then this is not helping much.

No that's certainly not the case. It's a counter, whose aim is to allow 
a PP reset only when the counter is 0. Do note that the reset() happens 
only in the job_free_cb(), which gets schedule later. If this counter is 
not zero, which means another work has changed the profile in between, 
and we should not reset it.

> 
> It could be useful to profile some apps assuming it has exclusive access.
> 
> However, in general, the API is not reliable from a user point as the 
> mode requested can be overridden by some other job. Then a better thing 
> to do is to document that and avoid the extra stuff around it.
> 
As I mentioned before, like any PM feature, the benefits can be seen 
only while running consistant workloads for long time. I an still add a 
doc note in the UAPI page.

- Shashank

> Thanks,
> Lijo
> 
>> - Shashank
>>
>>> Thanks,
>>> Lijo
>>>
>>>> +
>>>> +unlock:
>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>> +                  uint32_t hint)
>>>> +{
>>>> +    int ret = 0;
>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>> +            amdgpu_workload_to_power_profile(hint);
>>>> +
>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>> +        return 0;
>>>> +
>>>> +    /* Do not reset GPU power profile if another reset is coming */
>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>> +        return 0;
>>>> +
>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>> +
>>>> +    if (adev->pm.workload_mode != hint)
>>>> +        goto unlock;
>>>> +
>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>> +    if (!ret)
>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>> +
>>>> +unlock:
>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>> +    return ret;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>       mutex_init(&adev->psp.mutex);
>>>>       mutex_init(&adev->notifier_lock);
>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>       mutex_init(&adev->benchmark_mutex);
>>>>       amdgpu_device_init_apu_flags(adev);
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>> new file mode 100644
>>>> index 000000000000..6060fc53c3b0
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>> @@ -0,0 +1,54 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>> +#define _AMDGPU_CTX_WL_H_
>>>> +#include <drm/amdgpu_drm.h>
>>>> +#include "amdgpu.h"
>>>> +
>>>> +/* Workload mode names */
>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>> +    "None",
>>>> +    "3D",
>>>> +    "Video",
>>>> +    "VR",
>>>> +    "Compute",
>>>> +    "Unknown",
>>>> +};
>>>> +
>>>> +static inline const
>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>> +{
>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>> +        return 
>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>> +
>>>> +    return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>> +}
>>>> +
>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>> +                uint32_t hint);
>>>> +
>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>> +                uint32_t hint);
>>>> +
>>>> +#endif
>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> index 65624d091ed2..565131f789d0 100644
>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>> +    /* SMU workload mode */
>>>> +    struct mutex smu_workload_lock;
>>>> +    uint32_t workload_mode;
>>>> +    atomic_t workload_switch_ref;
>>>> +
>>>>       struct config_table_setting config_table;
>>>>       /* runtime mode */
>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>
