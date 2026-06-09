Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A35FCD8CAD
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF09010E22C;
	Tue,  9 Jun 2026 10:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="deUBCbV8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F2410E22C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytS/T7e0Cp03yGZ7gJeL4bQiSwQ5xNGlaYRQSNs9HEZMnDuzMD4T1TTkvKDhfGgfMWY96mV200mSarKzWriaBPg8v7Axiog4AlDcmMSeitEOTy5bFKbk5VzfpKV3E+Nfmo5oBAiNXMtQ1/3qzpkExD6d9gyRaOF1+sY4aIPVv60khLtaWKtqDLFoBUAKwHzFQMaodh3JNvCgLqdfr13loF5xAIDeBy+8CHa64VOq52uAAm3F+v1w5lW+4ENnMtWYPtantFP1SQDFwoUyp+KYiLSjAT70z2DTr08I+hQi9LIaSiGehNc0W178goyQnyfYt6ha323IUvOZJ9v2azdU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgNgiuEPahAY04hinxBiez9TIbiFNQj7fb5xC2z41A0=;
 b=B4MuviIGHmpmeLVocSKXMvWSKQ5mF8a9hcsHZNSbpkFC+524vFk+rx88ZjDXuiQ5MQSYkULaEni+ltu7OIjtuUSFTjDPCZ3q7UA7y1sKHpvG3YmyVup1P8P0XTAX6Vwy/13FCuqI1NJl1zJRK2zdW9k2XNHxpcluIUQSyySKsoyJG+bbXkpYA5vj+cDUFMt4Mgp9cekYK9TlkzgvueT1O68bjwbqfw+6ft6YSgTYbbPxb3Mye1Yf0PfX8i2ByB6TlpPK9N2+ntrZ6nnfdSNrw2NDH54nMwtBDmxuBUfV5ca7IZKLPjfmm5jZjM/RMLF7/sPdtXoXgmfI9CUG6LFoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgNgiuEPahAY04hinxBiez9TIbiFNQj7fb5xC2z41A0=;
 b=deUBCbV8+kdA/DKOW8zFG7LuRC3ZI+O+tU/F00cKpB3/ng11lS/Y0SQq4QBEIeZdKfyif6AAE1WCv74M/VLgRdXjchL6W+/0w/TuAK4LPWmJuwE+IbC/8p2taNBM0yHwsLdlEf+g8blwLSWnvgAVtcVzc8aRxqjKxRXb8M6hm1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 10:39:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:39:09 +0000
Message-ID: <60acd3af-f2a8-426c-9c0f-f69c90ec687a@amd.com>
Date: Tue, 9 Jun 2026 12:39:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] drm/amdgpu: move struct amdgpu_sa from amdgpu.h
 into its own header file
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: e25c6c9c-ffc3-4797-5f58-08dec61356b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|3023799007|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b5Hvvqx0iouYdLBiDqyhuV+DEf97LnbJtaMmtJWF+MsHrIwbTJXTtHG05gpPm4IuweZ4Qz7mEeerXNCZmC6zsTnsJpTtY8nj/DRO/0W75pXoACk1QXvTYr/FdrVRDsGL3TCjj8Zir4s67Oab79KqJxEvenZeLDLYipF83bClOiatFFJJUHvla/b9y+FrUllyPYkqmNTcpgdnq2YtJCABhCxSKkLpuSkRQGBPD0kPci2lvmmfJJDbvwai9CpNNS7FzQrLReauZNp6eNEXXZcDO8G8r0603yB6m9s/9jkZq3HgqtvrLiFvjcvYvKHdVeW0D43xzt2B5OGesiRmhXITqIKYgslANKRDwS1P7fwJ/H7q4KHndMYWcmA2A497uuMNejyf0EqxeOk7j4XNo8uMV0lFwaktLlZLr3rFyWvXqIj8keOSHeIt19RTtMQd4xdTD00vWI5Gvb6AaY6r9dypxl37LprE9S6+Dm9oiyJHeLsleo7o/CTQvuhOzMHGJQDJajCfv7CYYbtClI62tdZ6oZCHGWIC4CgxjS1psfJ9LYDtYBNkb4yh81pG+dtEENgKpCg63vXST/9/YTYoT0EiD84AFmEVbfa4tqniWjET8z/BpzRSZbsFl8si7yoMTawbd8QtKAwMbbNyURStAKb9iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(3023799007)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRVRitpRUJpR3REV2R3RXMyWjBVdks0K2h0cGVXaXRlUHBVNEZ1Ykh2aW5t?=
 =?utf-8?B?dGQ1cXNuKzVoUmpOeHJWNkJIMXpCc2FIRjRVdUJuMndFUUhCd3o1cHZ3d3FC?=
 =?utf-8?B?bFoyRlM3V0J4SXdlNS82QnFqMFRhTjZQckI2bXlpUVZ4bUlWaFZQYms5aStI?=
 =?utf-8?B?UXJaSmpjMTJIZzY3R2pXYm1jdEdoMzBrZjJmcnJVamNMUGNYeGxzNmtGZUpo?=
 =?utf-8?B?MTlqZkpCM1NQMm5FMENJSnNXRFJVdEI2NysrWHQ5aHJJT3hEYjJDcjduVU5S?=
 =?utf-8?B?TlQ4R2NSUXF2RG9LSkVtTnBQT2lkbXRYNzloSkJwamQ4a3JyY2dWV3dHN1pL?=
 =?utf-8?B?cVlxclVPNWxVWXJhOXVZSEVBWVRTVytnRnJvdk02cUpSUVR4UDdOUmN1SVJC?=
 =?utf-8?B?WjkyblUxUDE5MzdOZnI1T2JSVXlRdXQxRjFkL2RBVktqblkyVWtFL3FDSElB?=
 =?utf-8?B?Q0cvK0hUaXprSDhKaDVOZXV4NFlkcW5zWlR6NU9ObEtpclhTdmVqbGxCZ04x?=
 =?utf-8?B?alhHYmtNR2lNK3REWk5YN1NudTFqTXAvY1JkbDhOWmhnZzdjcE5mWGtTRklP?=
 =?utf-8?B?RFVVVmZpQXJscVNRWENPOVFmNlNjQXFGWWQrRE11VmwvNlZmT2MwZ2JWV2ln?=
 =?utf-8?B?dmlUZEpoanlDMEFEaGFLYm9QdTVSTytWQVZ1dC9iTU5hZmczbktiRElpK0Zp?=
 =?utf-8?B?SG5kcDhXTFBOSVJHdmowTHBydTY1RGJHQk9iUTBuYlQ3N3JJenZDR1FtSUth?=
 =?utf-8?B?eTNPb0h0VWJmMlRudmlJeUp3VlVReVd4ZzZEVVorcGhZVUtieHJCQmtDMlAx?=
 =?utf-8?B?b2MzWWlLTk5OK3JjYUpnL0Q1eU1TZU5KNGQzVWduYUFqVzZabzFsclppd3Vj?=
 =?utf-8?B?QVh5M040bUY0RXZGYWhsckc3RGFMUDEwL2F6WlZsb0dJVExWWVlCMmJtU2R4?=
 =?utf-8?B?M0t6bWlxb3pjbWllZHZlejNiZWJibnR5eGVVVjJjaENnVktZRFJHNVk5RnI1?=
 =?utf-8?B?cDlBL3lxcldTVXNCbWFQR3ZHdkFTV0FBZVZiai82WitDS21uVzdZVzVqb2dD?=
 =?utf-8?B?N3VyNTdSY0Vkdmk2eDhBQnFSWDJGRStpZFFjSjFINlRhM0Fwc0Rzd09ZMUtC?=
 =?utf-8?B?VHgrV0Z4c3VIZmRYNEdqbjNaUitRdXZJQjhaVGxFMVlXMkNZaEl0Ry9lM25p?=
 =?utf-8?B?K2JhOTZkdTRJSmtvSU1iaHJ6YVpwQmwzQ0xxMlducEw0SmRMUXB0VFlYeEhK?=
 =?utf-8?B?SGUxVTV1cGZPeVRSaU15dmdqMXVwS0VyR0t4ZkFUQkh2VklFQnN6TStvLzFj?=
 =?utf-8?B?amFYTkZER0xsQkdDZm1QVVBjMFZLZFFvK1FqSHo0T0piTldwUXpZa04rNGN1?=
 =?utf-8?B?OXFTNkZLbkU1VXptenkxWFFXK2QwZXBNdDJ3blIvQkc0UmptdURPOGM5MGVH?=
 =?utf-8?B?Z2licEEyeWoxVWZ3aW9SeEtzZEJ2VXpCQ3FpcUIyT2FaT3U5MU5hZ0VrajZr?=
 =?utf-8?B?UmJHSEsrNUxlMmVqd3dIakFjZHN1d0pROEdmZmsvQWMwWW5NUE1vMHl3bVdX?=
 =?utf-8?B?ekpDU01rMGZ4TFE1VVU3SjFDbnBPaFBpWDB5ZEFUZkN5YlBGWThMc2xycW9C?=
 =?utf-8?B?bWRJVmMxZ05JZzcwZEpmeDNJSGtoU2VPYVMrUEY0UnVYOHdjd29ROVpLbEFU?=
 =?utf-8?B?MFlBaXAvYk9iTFpuQStHajJmaG9SUllrNDlVekxKU0oxYXJoZ0ZVL01nNnBQ?=
 =?utf-8?B?RWRuN3FTL3FMWGFyZ3JrY0R4UXZtOEdmMWM4Y0VyeFl6RUF6Q201U3l3WnBK?=
 =?utf-8?B?L2daWUNTM2YvUG5mejNWNTlpb0tkK1NLLzFCL2Vmd08vK2d2Q0RSYS9xTE1y?=
 =?utf-8?B?eThTQ0hVQ294RG5OOEgxbjh2Q2IyRWNoMC9ScVVBVSs2NUxHa2dNMjNFWEE5?=
 =?utf-8?B?TWx5b1ZrYzhabWdNdmhZaXFFV1lVM2VVS0o4MTBIOUhLTFgzd0RRR2hva2pV?=
 =?utf-8?B?eGV4NVY5dmhZMUlRa2g0QjZ4b0dHd2kyOTg1Zzdkcm9uakVFOFl5clE5YU9S?=
 =?utf-8?B?TDFkL2syWmRUa3NSd2t3ZVJpWjFJRDFUMjBjcU9PdS95WllFdHVJUFR2ZXI2?=
 =?utf-8?B?cGJ0cnd6TCtsME1SVitGd1A5QmtUUnJkZXFyeTNmbUp6RzBaOU41em9Za3JB?=
 =?utf-8?B?b3oxL3ZsVGxHS2JuQjdYZUJoWlFtV0t1alRicDFMeU1rOWQvUzAySnh2aHY3?=
 =?utf-8?B?RGZQeEZwUmlYaVQ4VllRV20vc3U1bDNTcGZhbHpyVDgzQ3ltbmsyR0ZlRmFC?=
 =?utf-8?Q?1u9sYpLqNerGj5LZ7+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25c6c9c-ffc3-4797-5f58-08dec61356b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:39:09.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2K/Qd36Y7kQYBz7kqCZPQFl151YUTaegKg5Ods7wrpJBQ0DlywcOwDFZMuNW5b7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/8/26 21:47, Shahyan Soltani wrote:
> Move struct amdgpu_sa_manager out of the monolithic header amdgpu.h into
> its own dedicated header amdgpu_sa.h.
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into
> their own respective separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

I have a similar patch in my pipeline which is just not pushed to amd-staging-drm-next yet:

https://patchwork.freedesktop.org/patch/729166/?series=167539&rev=1

My patch is slightly better since it also moves the function declarations over and not just the structures.

So I think you can just drop this patch here when mine is pushed.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 32 +-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h | 61 ++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..d7d8664854fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -111,6 +111,7 @@
>  #include "amdgpu_reg_state.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_eviction_fence.h"
> +#include "amdgpu_sa.h"
>  #include "amdgpu_ip.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
> @@ -386,37 +387,6 @@ struct amdgpu_clock {
>  	uint32_t max_pixel_clock;
>  };
>  
> -/* sub-allocation manager, it has to be protected by another lock.
> - * By conception this is an helper for other part of the driver
> - * like the indirect buffer or semaphore, which both have their
> - * locking.
> - *
> - * Principe is simple, we keep a list of sub allocation in offset
> - * order (first entry has offset == 0, last entry has the highest
> - * offset).
> - *
> - * When allocating new object we first check if there is room at
> - * the end total_size - (last_object_offset + last_object_size) >=
> - * alloc_size. If so we allocate new object there.
> - *
> - * When there is not enough room at the end, we start waiting for
> - * each sub object until we reach object_offset+object_size >=
> - * alloc_size, this object then become the sub object we return.
> - *
> - * Alignment can't be bigger than page size.
> - *
> - * Hole are not considered for allocation to keep things simple.
> - * Assumption is that there won't be hole (all object on same
> - * alignment).
> - */
> -
> -struct amdgpu_sa_manager {
> -	struct drm_suballoc_manager	base;
> -	struct amdgpu_bo		*bo;
> -	uint64_t			gpu_addr;
> -	void				*cpu_ptr;
> -};
> -
>  /*
>   * IRQS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> new file mode 100644
> index 000000000000..a878443c8c75
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
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
> + */
> +#ifndef __AMDGPU_SA_H__
> +#define __AMDGPU_SA_H__
> +
> +#include <drm/drm_suballoc.h>
> +#include <linux/types.h>
> +
> +struct amdgpu_bo;
> +
> +/* sub-allocation manager, it has to be protected by another lock.
> + * By conception this is an helper for other part of the driver
> + * like the indirect buffer or semaphore, which both have their
> + * locking.
> + *
> + * Principe is simple, we keep a list of sub allocation in offset
> + * order (first entry has offset == 0, last entry has the highest
> + * offset).
> + *
> + * When allocating new object we first check if there is room at
> + * the end total_size - (last_object_offset + last_object_size) >=
> + * alloc_size. If so we allocate new object there.
> + *
> + * When there is not enough room at the end, we start waiting for
> + * each sub object until we reach object_offset+object_size >=
> + * alloc_size, this object then become the sub object we return.
> + *
> + * Alignment can't be bigger than page size.
> + *
> + * Hole are not considered for allocation to keep things simple.
> + * Assumption is that there won't be hole (all object on same
> + * alignment).
> + */
> +
> +struct amdgpu_sa_manager {
> +	struct drm_suballoc_manager	base;
> +	struct amdgpu_bo		*bo;
> +	uint64_t			gpu_addr;
> +	void				*cpu_ptr;
> +};
> +#endif

