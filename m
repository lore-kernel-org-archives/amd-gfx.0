Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D10C6FA8E
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 15:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4302210E959;
	Tue, 27 Sep 2022 15:20:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F21510E961
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 15:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUcaPIsvx3/cb+4u+2nJrGHPCqI+C8PEbsVVUeN3uPJtzD/tZWTzwpzbhQsCoV03OGuyEaM7WsB/RJZLj/zNwwqZUq4Y4LQ2T9/rsQyNli9FuO3jYjl/oJZyzOaR5hIMwQMhmjJuhyZLBTtXbpBk/sQn8c/EYqz3ZH4Qv96BMIo1K9dGXzfEhZHowx4BOXpTqdk4M8KnRdqI7/4fHXKXKexRs7nLJQ7Y41juenkp4Nv1jQ3WDmihD6unRFNKJ8MqpEHBllF6JcG4AV+6GtW/dM2xDkiRQKG/n8sDDFWx+dkh4xVjCYYq2+Az/mrdm3eAbQ1ko+F1eVV9vOrb0QPt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tO8fRXV2P4EzE0Zot35WG8Xna9PsEkEMXhbscIl6mM=;
 b=Js3bcyMboOZq1f2hQ3ra6q8wsW3rTYM21SxhzgM0qWou3fAl1Afdn0rgz/QTZeBiIv83kLFAqD1u789D8FaO+bVanHDnyCRtr0c8M4KEPlJM7xgp9T3/imGxmg2WUpkXa4nQ2n96ko4ESLzHKgP8o7e98800mpL369IbASr9efR4yw89WQNelCH9oxrUiClZNuDafr58d9QN9pCgGhnq9HtIwJ0TZMVxi5slsq0qhUI7Zwqp0UXvYOYQ/ON8CGeCfFPGSqkAryjbYGmRjqvSLqUwJHv61RAr1hreNm7H4sSJJXSI1sDyXNxsZ09Tm/8NiZeaCILsnts18tH0ZJQSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tO8fRXV2P4EzE0Zot35WG8Xna9PsEkEMXhbscIl6mM=;
 b=VRPppsTdlhmfFx9f9DVZ03PNDlkRhkburOgCFpA9FydSU/agYpFvjazqa7IvwywvERnnpUKxmx6JK94PqZovXk5S6P9xafnN1MGbvHaWw6aEkGk5ckWrviYfWN469bxr9iZYH617B4i287y0CvUXnP1EoC9UT67rbdmSxUSPXtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:20:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 15:20:33 +0000
Message-ID: <f41c1fac-370c-30dc-f63d-0913020eb6ef@amd.com>
Date: Tue, 27 Sep 2022 11:20:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220926214014.5450-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 4026c8f1-8f9e-43b7-ddef-08daa09bd255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0+u6t4c1b1kmI5YJCFp1vDMM/PPyf7Jtn1QjLD9n7eYhC7gbzSYrymn+j+dsYvF2lEheu1yKxkvuIklK8QWfFGxOhnoEKvejWNs4osPlnAg8NVUWRB9TpK+BSaqTHp1Z9vw6NCrX6G16DGGhgLxmkdMYXMgmdRjgnCoDTgeZEhcCjwdpNFSkfQqbgFaUBCd9cfcc9NJeq9CQU/Jz6CKl9Pu4VUpH+XCDr57LrJMs2wERknFnV7+3Y0S+mc3G5GngToGRt13+RRYXKThfVvX8cfaMz2WKyg5YWd1VSXILC8BaDSc7wewNZDZhZMxNe4mmzgWdelUJUNkwN3YnXLbVcwCgfP3LKcnyEcGbbQwk4wY0w9HWsY93VfNmGBtbLvUmLjK+VDLEbdqvfuGmtAuToOofbb5XQhXke9AVCJuRUuvMl8bpWSdjgU+w+AJFWVLvhO6B+7yuqI1Z62VOnYA6iBFlT4PTIKiAQgkNLm49H7eyRqimBAPdHk/J1AM7cbwCWCcvKCDw9vznGBFvU1V9ksOedXFyFRouH9zWcisqS0wRyqGi7Ppoko5/bfUyuXn4X0cFllYAkWU74S2t9e1LC+eiBW2rhrb7jECAAQsD7rG3CdgzLWzZGCxxa5lv2ukid2u8Lm0JpL1QV5YbJUfSlrBopm7tMNpdHg9QgZRwU3/eIjnblfLNABFs0Q13nwcDVjOwYNPwDmZbe2rVd+xxT04m7HJ5uZiaaUfHZd4flX32dB9IBRGuigIT1v++xw3KV0St33MjQATg2Z6GUlqzFQZGN+PjKz0jW1JSQnSJ0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(36756003)(316002)(2906002)(44832011)(41300700001)(5660300002)(8936002)(31696002)(86362001)(4326008)(66476007)(66556008)(66946007)(186003)(2616005)(83380400001)(66899015)(6486002)(478600001)(26005)(6512007)(6506007)(8676002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdXRGQ5SVR6RUpkMktUc2t3SDJEVkpOS1VBeXJ2c1ZRbG95V3FOQjE4MmVz?=
 =?utf-8?B?Y1I5ekFQZHA4b0pUbFVmZ00xVVpESnJTNVFXRFNPMzFwcERYU3I1TitpZitV?=
 =?utf-8?B?Q2tXS3FhNG91MXF3MGxjdDhELzZuNGFsYTFldm5mSEFReFZDQkNxYkVLRzRp?=
 =?utf-8?B?VzQ2MVRFQWZSdmRKcjN3aTZ6MW9Xakt5QmliYzdPcFQxS3cwbU5OelVFU1F0?=
 =?utf-8?B?UStERXdvYnRpQlJHTXJOMVJ0RGNDN1ROUHozcTBER0t2UGxNcTFlbW5wVWZ6?=
 =?utf-8?B?Qm8wV0txdFhIV1M5b2VSbzRXR0VwZzdDdzc0K29OSytSL3hYeUJiZjlmbVdQ?=
 =?utf-8?B?SnR1UjFHY0RIT3ZxdDdoZWRybDRQbDNuRWtOUDEyekkwUkY2S0tZaXdlOCti?=
 =?utf-8?B?VnFiYVllcjBGeUx3ZW9yYysvb0VwdVVuK1Z5NFYzQ2JhWVRmWWV0UWNNeGY5?=
 =?utf-8?B?UzE5WVY5UnBIbHNLRWFLdFZtSUt3QXd4T2xiVks5YTdSUHRkTVVXRk9aRVBC?=
 =?utf-8?B?eFRVelRyZVlZUmxQUWo4NGw0dEJJTzVWSHFYRW9KVVZFTHBqUkQrdno5Nmt5?=
 =?utf-8?B?MlZKdWNOWmJCMFJaSjNJNml5VjhnYW5vWTgyUHA1R0RNOU12eTU4cU5OZVJM?=
 =?utf-8?B?NGc4OWJrS0xzRGV4VGRINmVkellXVnZzNTM1eld6cmlNaTRpUC93c1pidXJK?=
 =?utf-8?B?QzlMd0VwQW02MUlybzlGa2tIY2pjUnhNOU8rNFhrSkVzSnNMR3NJeTVEaExr?=
 =?utf-8?B?dWsvN2xURS9pSCtKUnRxRENHelNaN0N1UVZTSVNYd2ptNkVpUjZoaUpjM3RL?=
 =?utf-8?B?TklXdmFxNkRSd0dnbXhTOS9PYUVCZzJpbmlwQ1VHdUVzOC82UU9wSkZsaTRC?=
 =?utf-8?B?SUVZcDQ3K2NtUC9OSlU4U05hanNWRVh1cG1lbnp1Ujg5QzgxMThoa0xqdUgy?=
 =?utf-8?B?VnZxaDlQS25TLzArb2N2TTZGTStGSXNWRE50QnRvRzFiZFA5N3pCeW9FYzJt?=
 =?utf-8?B?WnNDQktPQ0R1NmNzZS9Lb0tHWERqSGlpWUg2RVg5VGljWWtWZDU0dEJMZ2V3?=
 =?utf-8?B?cVFGVEtjVUxqL3FJMnR6TFNkaWVmMXhiRll3Wm1CT1lJYUt0OVg5cmlCbksr?=
 =?utf-8?B?V1NUbCs4QzRIUUxVR0ZaakNhUUU4cHpZYXBZa012b3VGcFpweTllMXhvSHdT?=
 =?utf-8?B?dDdCT2VlbjB4Z3JkOHp6c29oZ3g4SGxBYU1teHdYd2RxWm5uanFuQ01vR0dM?=
 =?utf-8?B?dnEvL1dQb2ZHQkcxUUJTVkNieUpoMmg2RERCamY3L29RdEo2dmtrT0ZqZnl1?=
 =?utf-8?B?bkxzUmowR29YMXRlaDE5QWFydnlSVTNoS3pYUkJPVXFCVWxuOElVVk1ieWlG?=
 =?utf-8?B?eC9Yb2FzN3hhMk16dHFTeGNlNUJxWkpITGhkRitiSXR1MHlpSmpSMi9vY21q?=
 =?utf-8?B?cy9udDZraVVMVGhLMTkwNnIySGI1cFAxN3dyUTdiMzIvSXI4ZktVR0Fsb0NZ?=
 =?utf-8?B?NFg2OFVZK0QwZjc0QkF2M2J2R2huc1JZMzlhalhwUEF1ZWVFQXNpNTYwUlpN?=
 =?utf-8?B?bzM4a3dwYjIxT1N5Z1Q1cVE3d2VzVWVsQTJveWJUTk1ZWkhycDNmcFdmZ2dI?=
 =?utf-8?B?bm9kamJHOE1xaURnaUg0RmFlVzZPTlNEMXNHVTlEUWhleU1jK1FyYVZwWGxs?=
 =?utf-8?B?UVZJT1B1NTR3QUJIdUg4dGxIQXJaajRSTDNXWEJJTnVjTGN6cUNIZ0cvSFZQ?=
 =?utf-8?B?bUxxa1MwWjYwNitMQnRkL2dTUXk2WXJKMDZzdUpoV3FrU0I4RTBWcXArdlFH?=
 =?utf-8?B?MkR2T2U2MHBtY0QyNVEwRGRQbFhoUzcreGFBVGE3UHppeWwwekRZTFRrcWNp?=
 =?utf-8?B?bWlEeGVwM1BNQ1gyUFdHYVlQWnJFdzlDNHIyby8xNW44Ynl3a2hQV2loZVNz?=
 =?utf-8?B?eVNtdERhZ3gzN1Q0b3ZYVExMQjNXOS9jclF6aXA5U2xtQzR2V3lvK0FzcUZp?=
 =?utf-8?B?WmFLZFo1clhXVjM3SXNuWmhWNEZybUxwNDdKazNxaUJQVlhQS1ZZWGFESWJN?=
 =?utf-8?B?ZVFJUU00MDlIS1h2aitnU1V0WFpidE82ZFBlcXRvb2tyc1lmWk1WZkdNdU5t?=
 =?utf-8?Q?sSmJ84V6ppKh60H0LeoXrV/jL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4026c8f1-8f9e-43b7-ddef-08daa09bd255
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:20:33.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+w0YfeAO3gmlRMNrLVi42vukiikfFgGSzfcizbZBc9SzXKa3miNzPHfvprre/m1gNZ7yfnQfHiq6y8dpWyEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Am 2022-09-26 um 17:40 schrieb Shashank Sharma:
> This patch adds new functions which will allow a user to
> change the GPU power profile based a GPU workload hint
> flag.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>   5 files changed, 158 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 5a283d12f8e1..34679c657ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>   	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>   	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
> -	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> +	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_ctx_workload.o amdgpu_sync.o \
>   	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
>   	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>   	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> new file mode 100644
> index 000000000000..a11cf29bc388
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
> @@ -0,0 +1,97 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <drm/drm.h>
> +#include "kgd_pp_interface.h"
> +#include "amdgpu_ctx_workload.h"
> +
> +static enum PP_SMC_POWER_PROFILE
> +amdgpu_workload_to_power_profile(uint32_t hint)
> +{
> +	switch (hint) {
> +	case AMDGPU_CTX_WORKLOAD_HINT_NONE:
> +	default:
> +		return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +
> +	case AMDGPU_CTX_WORKLOAD_HINT_3D:
> +		return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
> +		return PP_SMC_POWER_PROFILE_VIDEO;
> +	case AMDGPU_CTX_WORKLOAD_HINT_VR:
> +		return PP_SMC_POWER_PROFILE_VR;
> +	case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
> +		return PP_SMC_POWER_PROFILE_COMPUTE;
> +	}
> +}
> +
> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint)
> +{
> +	int ret = 0;
> +	enum PP_SMC_POWER_PROFILE profile =
> +			amdgpu_workload_to_power_profile(hint);
> +
> +	if (adev->pm.workload_mode == hint)
> +		return 0;
> +
> +	mutex_lock(&adev->pm.smu_workload_lock);
> +
> +	if (adev->pm.workload_mode == hint)
> +		goto unlock;
> +
> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
> +	if (!ret)
> +		adev->pm.workload_mode = hint;
> +	atomic_inc(&adev->pm.workload_switch_ref);
> +
> +unlock:
> +	mutex_unlock(&adev->pm.smu_workload_lock);
> +	return ret;
> +}
> +
> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
> +				  uint32_t hint)
> +{
> +	int ret = 0;
> +	enum PP_SMC_POWER_PROFILE profile =
> +			amdgpu_workload_to_power_profile(hint);
> +
> +	if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
> +		return 0;
> +
> +	/* Do not reset GPU power profile if another reset is coming */
> +	if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
> +		return 0;
> +
> +	mutex_lock(&adev->pm.smu_workload_lock);
> +
> +	if (adev->pm.workload_mode != hint)
> +		goto unlock;
> +
> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
> +	if (!ret)
> +		adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
> +
> +unlock:
> +	mutex_unlock(&adev->pm.smu_workload_lock);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index be7aff2d4a57..1f0f64662c04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);
>   	mutex_init(&adev->pm.stable_pstate_ctx_lock);
> +	mutex_init(&adev->pm.smu_workload_lock);
>   	mutex_init(&adev->benchmark_mutex);
>   
>   	amdgpu_device_init_apu_flags(adev);
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
> new file mode 100644
> index 000000000000..6060fc53c3b0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef _AMDGPU_CTX_WL_H_
> +#define _AMDGPU_CTX_WL_H_
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu.h"
> +
> +/* Workload mode names */
> +static const char * const amdgpu_workload_mode_name[] = {
> +	"None",
> +	"3D",
> +	"Video",
> +	"VR",
> +	"Compute",
> +	"Unknown",
> +};
> +
> +static inline const
> +char *amdgpu_workload_profile_name(uint32_t profile)
> +{
> +	if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
> +		profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
> +		return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
> +
> +	return amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
> +}
> +
> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint);
> +
> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
> +				uint32_t hint);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 65624d091ed2..565131f789d0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>   	struct mutex            stable_pstate_ctx_lock;
>   	struct amdgpu_ctx       *stable_pstate_ctx;
>   
> +	/* SMU workload mode */
> +	struct mutex smu_workload_lock;
> +	uint32_t workload_mode;
> +	atomic_t workload_switch_ref;

You have only one ref counter. I think you need one per profile. For 
example, imagine you have two contexts. C1 wants COMPUTE, C2 wants 
VIDEO. They start and finish jobs in this order:

	C1		C2
	start COMPUTE			enables COMPUTE profile
			start VIDEO	enables VIDEO profile

	...		...

	finish COMPUTE			does nothing because refcount not 0
			finish VIDEO	disables VIDEO profile

Now the COMPUTE profile stays enabled indefinitely.

Regards,
   Felix


> +
>   	struct config_table_setting config_table;
>   	/* runtime mode */
>   	enum amdgpu_runpm_mode rpm_mode;
