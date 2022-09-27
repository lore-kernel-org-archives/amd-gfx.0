Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A7BC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 06:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CCE10E569;
	Tue, 27 Sep 2022 06:09:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0371D10E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 06:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUPXnwOdjp5z2+OzhAnY+lHWc8CfxjhYkUJdXNJA0CNu9mAqMXPI23zynEpeAR8xVjzq2DZz3bJO98B2bVReVfMm74zJQZNKmA/pNUmM34mz7fBPIQvmwRwVzkCrZJcxxbeWl//axHcxPBlvOozs+YuzLE5qdgddeNsNJv0bCZ8Vo52Z4bjj5kQhWiT95gLy72WlIVg+oDJDGoJFC9/GZ/f6LHqQl33Hk896x9I8sfGhURbSgupYoDPc8CclY9VOfF1C8EEMIzoObUN+4f6f3iQpJzdaHJu8pXt+xP5wwHLb7R4HWlcNmbZBB0M16/eN9pLyGc9xjFFKrCwFjJxwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ynfk8fh/DFVAPye2LbjCbqs/SsLeIm4PKlZmDKyE+oc=;
 b=S4Rh93VbM4dFUZa+7juHs15iLdkMYF0KgUKuixvHAkqME7EBe9JbFk/2kL/tfTtok5VwL1FUWdmG6Ncr6RRUt9/ktaGbPmzdNVv7CSo/k+PsnLOFdfkzg6zVZIzfNXD4hDn986wRSZDB72dqgnpM45gGEErBIoOlhlBAS1lFdk3HGSLm6MyJotIFSSogNwSW2H6d0029oWUgTkXCFKexc3CvCJDq1mB1mYuS0pqlwT7HDlun0GDzQLVapbHGgsD4IZ6lRWZrrp3iJ1PL+vd8gJoQNrBFJLwjaElmkxGPuC+vch7nXsW03hDN8pQyKLcAxWATTYrpJ74tEs+Yfo6dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynfk8fh/DFVAPye2LbjCbqs/SsLeIm4PKlZmDKyE+oc=;
 b=MMWh7H8YLKVrxPmPTgDjLSQqfDo4fj+yjZ7Ll7PI8+LlG6cyI1v+Yb+7Mh+vQKEs8PvlDWgekBJ2h28HJApkbN2rfPz+Qdv7HAHBYCTYZGNgo4yH0mgf7PXRm7HiB8ytcxh/7GiVrqk3/r12f/Me287rsUgH5EdNwViBSZycMOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 06:08:58 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::9df1:3438:95:8347%5]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 06:08:58 +0000
Message-ID: <67ebd1e5-1d8b-5a25-c76f-8bc65ee14313@amd.com>
Date: Tue, 27 Sep 2022 08:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926214014.5450-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0206.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::31) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BL0PR12MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: ed77ce41-a886-48bc-4f61-08daa04ec3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTgQccVXOUItyjjCh1CRWr4qHaKZNQFWlnkf0wemG5ddCd2pOkLvGQ2pq92H0Zmxf98t9HGFkFO3HOl47tal+Y0X/oTlTGV/R3AztbQv3JMQPeWAj+XhiDFEbW1IEmAm1GJeXcEi+elw/Ct1HxSbRe8oR946H8qzHK4v9+Sa8zAOBikuzGBjp67/zRvaydqZy/VCM76lSElpVYZF2D9tOL94XpEFWh2AX9G9EpP5uOoZDGObIf2MDX3N/BTzOylqkhG4YhnzLXej94Et40pfJj1QoDfgHY0BeApL5JWbmaiKKB2r+0NB3GvEeptUoVt+dXTbXwgmzUcwqfwqUism/GUed9zwjsd10qanF2J1exqQ4jne8LCuHHd9fqvh8COri1Zkag3QljuIuITEioSonE+wcaiqUbKT0mGJ9YXDYhsDpRtKo2KUt4z3fjrxfvRn0+RDLyh/c/ux6sr0P+cRE+Tf2RYwR3duBAq/hGd9NVT9Dh91Sw1uEDdqvddgDWisef5X84KipF0l8VXXg8dp6AZFupa8CQqWQYFl4qvv41CHbQERhbgqyICcI46Arw2BUW5ncnJ68DeR4WRn4h5KxU+9dnX5oFb9wMdKqvA/UvAb46DShoges6ivBYFNAy9/IGt9rvFdSXX4+pPPa4Bn3hlTW7Q/hFeP7U1+EVyEGxCSH2mbK8ixxRRcADw7CwdUswPtAyouiBzp54mfJwusy57lkdxqfhY05JV/N48+3T5zYSYR46ITQlvBftgYXTTSrXSJ4tIYj4fthMUxqVXDea6pFPQxXlfU4Hminv+2+AE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(6506007)(4326008)(6666004)(478600001)(41300700001)(6486002)(66946007)(8676002)(66556008)(66476007)(316002)(36756003)(38100700002)(186003)(26005)(2616005)(6512007)(86362001)(31696002)(83380400001)(66899012)(31686004)(5660300002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpOcTJKWWt6ZXAwZHRjd2l0eWZtRHk5bGtHSEVHYVRCZUJSL2UvaXVrNVQv?=
 =?utf-8?B?NU50SEFRUjJzUHJwd3kxK3FBZ3NBT3dxM21ENnRoanlZZkgrZ2xzT0lSSUdl?=
 =?utf-8?B?bHZaTXppdkp2eTY4b05FS3Z6YWt0NkE2NEh2YWVKUEhkL0JLTW1wZ2sva1A5?=
 =?utf-8?B?YkQvZnpTRWxUNUwvZ0ZpeUpaU0hualhNT3Nja3hlUG41MHRydTRRVGRsUnJC?=
 =?utf-8?B?U3lUa0F5NnVPQ2ZYRmM5bUV3R3ptK0Q0QlZtMjlWUFMwYXEyTXlhLzU1UXky?=
 =?utf-8?B?SU1xYlU4TmZBbVFiTWpKSUtQeVRtcU1xTmZtcFBONW9mZnM2ZUV4VHJMK0FT?=
 =?utf-8?B?KzFmQ0dkUlk0QU1JZUFKVnM2VTk3bE81b1FxQmRHUWZrMnFhbE5FMUNxbm82?=
 =?utf-8?B?TzVCSU9KYjBLVEs5anBkNzg2WmxWNGFlR2VkVlpUMGRZQW1OeUVlUGQ4U0l1?=
 =?utf-8?B?cllaRkJuYzhidU4rcFh3RXRDUzRsUnRlNkVBdWkwSlNjZE1aMUhaNTdGRjkw?=
 =?utf-8?B?Tkl2NjJEZTRNek0yK3FtWk9EaVhjRHA2QjVIdGx1L0lRMkdTUm1UK1A3YUhK?=
 =?utf-8?B?MkdVaUpWTzRMRWdPd25najBDdG43VjRVaHcxdkwyd294a24xb3U3WFQxbEtL?=
 =?utf-8?B?d1p1b2hLanY4OFowT2x2L0F3YU9hWDVHV1ExaUlxMGJCNjJpNHZNK1VMcUl5?=
 =?utf-8?B?b1NId0FVQTZhb3J1MC9icmtzMXZqUkxZaEhVYmZhRncwTzZXYUtJM0RLczlw?=
 =?utf-8?B?aHR2eVlDRGZEQVF6NmJJR1FLcW50ZkR1S0FvanR0cFZnUENCcEkxS3dSV2M0?=
 =?utf-8?B?MGVmMENSd3pyMGxWS1pTZ3ZwTnBaQ1NOVHhYaUVUbE00cEd3VEhRNFJnT0RO?=
 =?utf-8?B?UWxDQU52dHJBdng0NGNjTnNlT3VaWnBoMFcwdmxvN0lSR0pWaFpCc2lrOGVh?=
 =?utf-8?B?VURpNktWNUlHUm5YbEtqR1hkRFo3Y2RmTEtLMG5MMmV5VERobkJ4TDIvWjlI?=
 =?utf-8?B?UXp4ZWIvc0QwMnZtK1QrbG9FRHNYNUNzWGFmbXZEQ2JaWnRHZmZ5RUFGQU9R?=
 =?utf-8?B?dWFTQXlTTmZXQWdlY2pkeGI1dkZwU0trcjc0Nlo5RXlFMmJGU3BxSG9WTkVS?=
 =?utf-8?B?SmFvUmhDV1Z6RlJKK2R0bUhPRERCSi9ITjIyaXpQYkxMVnRIODV5c2xOVnRh?=
 =?utf-8?B?ZGxycjFwUENNRTBTRTBRSjJDYUNtVzJ3c1pVZHdPVkE2TDRUd2FqZFdiUDBU?=
 =?utf-8?B?b21RNU56Uk9CbVc0eFY2QnBXYXJUYWxlYzJPRHFPbGZmZWk5ejFyOWJFZkFX?=
 =?utf-8?B?ckx5alZnWWh0cnZLU09CbXJDYW5yOVBGYVZ4eE5pRExRV0dMbCtoQmxKS1Y5?=
 =?utf-8?B?VG1KS3NwaW1YQUIxbHRReERsbmR2eXFPZHJWbW9MODBSOVJZV04rRWNJUEVq?=
 =?utf-8?B?WjVRTkh2ckt1SmtGMG5BaFluT0NVT1Irb3RudDllQU9XWXBqdGxxZ0JoT1Uv?=
 =?utf-8?B?dVpWMlg4Q0QxWTR2czg0aWdHbHl2cHUxMG41ZFYyYjVhczJnb0NVanJQM3Iw?=
 =?utf-8?B?VHZkRFNpZHcrZWkzendiMXZwRi9Id09RZ2FUb0N2THVnWXl4MmQ0M2lnY0k2?=
 =?utf-8?B?aHBXd2pzbGNhU0FxcGw5OU9zdE00YUFQZklUUDM2aXdVV1l4ZlNoL0dTMnFG?=
 =?utf-8?B?MjJuUXJvWld0cTJwQ2ZmU0RTRnV4N1E2Um1EUy83RmpXRlN4Vzg0Q0RGdjh3?=
 =?utf-8?B?UE5PTlVtLzVrWDhuUmNzMGoyeXc2NWF0RG42RnkwOGFncWU1anVGNk5lcE9u?=
 =?utf-8?B?NXowVTJYRUpBZ0JYWHZTNkZ5cEM5UlkyeDVySWw2eE1ISklSRE9ySk9GTlVt?=
 =?utf-8?B?SEljcEF5VFlqd3Z0d0t3d0U4QUNwd21wVUhRQUwrbXpGWkxuU0N6MzBXa0xk?=
 =?utf-8?B?Ny84cGc1dTBHM28xZXNXQ2NQNlpvSy9ta3BmSmY5eGZQRGVWSWZOazZnMVYy?=
 =?utf-8?B?MFpxb0FaWHorVGc5ZWZmbHhoMkhIeE56Yld5R2ZyVE1wZ0pTNGJ6bWZDbEwv?=
 =?utf-8?B?WTdoN0p5d2t4dXlKdXZuU05QdXB2emFlY0xXR1QvcStCVGxaZTJ5YWt2cDkv?=
 =?utf-8?Q?aekbYjzDCiI7bYET57sdmSURa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed77ce41-a886-48bc-4f61-08daa04ec3bb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 06:08:57.9322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri5OGRil4Qffw7JCp9P/Nr7TqSZqkexYYDWeDMOZEHX/P+cRr1nSw8gfpbek+TpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> This patch adds new functions which will allow a user to
> change the GPU power profile based a GPU workload hint
> flag.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Alex needs to take a closer look at this stuff, but feel free to add my 
acked-by.

Christian.

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
> +
>   	struct config_table_setting config_table;
>   	/* runtime mode */
>   	enum amdgpu_runpm_mode rpm_mode;

