Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95877C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D3A10E105;
	Tue, 27 Sep 2022 09:58:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5152710E105
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfIi535S0hO8LlWrBMKqAlc+CZWgwedvG+OlOOrmxmZup7ZYMZanjgNZql2+x1DO3Y7PbpjXPkNcdJNoLHGaG8zVH4cTRJmPRUV8qPuX/RedmVVqfl66YZyzRf0gnqCfvq4y6UUZjYsOJVwLvbVmbVlb2MrxxVhCKT3Z0u9QR4FoJE3nOUVdZ3vAVxqFi/5QMWlFdtiELJsNYNRXIe6J8lPCsy5Y7AOpLzaEH4zHk3aI/iD5Ut61t0EUPv/A9pPm+MLdjV0Cdm5UxlxBtkXsl+q0Ux6hSHeUW5Rn9OW4S510q70NoPZBtHEso8KZrJfSC62wpF1KA4CjDw3qSB0uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25QBXUfDUVMQtlSDism5h9BoW/e1wxVF8W5Bm8UqnS0=;
 b=axVcpTTqBAq1RttaeXSnFrcCOfbSulVq0nDbjj04Jwg6rbkapSDcquCg+Kuefc9j+kXemgtyi7bK24m81vrkiItYFx8gm31jvGuz0QrFR2heeuiy7PxRRvEYwEhxdnRHV4dCx05pl3RNARZRzWXWkAj+5X0dT0oQORYz9fpPAQHY9/7/7gShoNAW8vWRFLUvFGoR8WYNRphoNmuIPmNA7fpPEm8E5vKYQKUYPKLyktLKVvSXOKDO64KmZ/z2vU4nXHYr8hFXgGQwvcV81Wgu+cxt+Bp5hEgQ5H6Fyw1gD4xc/L4suXvF9bt43nB6UGRZnZl24NXPtqRpWsoUfmtNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25QBXUfDUVMQtlSDism5h9BoW/e1wxVF8W5Bm8UqnS0=;
 b=I8f4K0PLzsHl013UL9glzWV8D9ZnGGd/4uVv6luOxXAO2pVVpik98kYZZiaqmcbxXO3WSKmAnz3V2awclZFDMAwIUEA7gGduVHq0vAEzd/jPyIZjC6QKtHBHoMcvocPEt0tgf1MrUJJ4KtyE4ALJsLgMxukyX5dZff38Kx/Dv9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 09:58:25 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 09:58:13 +0000
Message-ID: <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
Date: Tue, 27 Sep 2022 15:28:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220926214014.5450-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: b1298d36-ecd3-4363-7e86-08daa06eca38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDmpdHZAoiLTv3/Ymf/xexaVTphOzEXLFRjortMSUfR0DwrlAh/sY3VMp0mSVBa8QfC5SKpXhLPQP/wOGvLnBU8N6We9cNDss65qeKReZhzIq/OM0YhwaSU9lOXOL8W9grsAluO9dAYjrTyJWmchcYsLJyCBSuK/VcRLfQsN+JYqBHhFgTyGP4oDkw8YRidcH5GpmSLAxhXz3ENoZLtDZh7dBjd6Sg9XgZyIVLAduLCH++awfmssLKhFtOcRVHgVMXVzCw6P1Uk65LDvPNeqDK+rSmaCuVOzAYTm1ydRlAISmu7lMdPb02/yqulT3MwlQyXj3sady3kaSrCxtA8Fn5wGNTgARqwcCUZzh7DRLSx4g5eLKffPDO5vq7dxYHSkGHszG1/PA6ywJNSUt+7JgSqUXVehbX8XrnIpwbkiIX8CRv0J2EG0cen85TEM7RSUAfhtXxAae6W7e18QMhZ+W3Ze7R8YiN5A0TK35Dm4nwHhA0DjbD9d11DOK111XVfbybZe9f/2YrndiowzZlQIuH44EH4+fhe3V2CoMltf9loa6XnC5IpdaKsFmQEMAF4FSINSnrjdSoSHBL7pVvGfN+Je3N8CtB1IFjpTx7OaIRbiCBwUqGCoIKNpOVX+PTlYLM/IShBdZCjmzFKiFiRYkPjc+z2I3C6vnPHd0jLZ+UUn1AupYoWe4GNRfvYrkN8ny2UaOm0dh5mrfJfrxlzJT+qx3NaxW/nIcnGaOGP5A3BBhZqoN6ovqQJ1aiCqPykPKmMZZrMoTvqaTiq+/Qh18erKIVw5FgFjK5yP2LYRgQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(31686004)(2906002)(66476007)(8936002)(66946007)(66556008)(36756003)(5660300002)(38100700002)(8676002)(41300700001)(4326008)(6486002)(316002)(86362001)(478600001)(31696002)(66899015)(6506007)(53546011)(6666004)(2616005)(186003)(83380400001)(26005)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qld6ZWg3QUhadFNYZWtESGlJeTdwUlJ5MEh2VHFQMzJRV3JCVEgra21qYzNa?=
 =?utf-8?B?dmp0Q0w0NTVRc1dOQWl2WUw5WEpiQ2lpc0JwQi9jSGNmWmdZbkJtbHlSSUdL?=
 =?utf-8?B?WUVobUhQN3RSQUZxTHduTVM2U2VyUS9OQUpnM2NacVZlWmVaQWVtZFB3cWpK?=
 =?utf-8?B?blgvZnd2OTBTVkl6WStRa004SHF3UW9ROUdzOUdNSDdtZ2xiNUlteHc2aEp2?=
 =?utf-8?B?a3RtU2h0SUFqamx6SUVJNHR4cmdkZUJ1bnJSZm5zRWx2SnFodnppeW9oeXBJ?=
 =?utf-8?B?ZzBxbkY5ekh2OVFTUkNuREltZ1lNNHNLb2tWVTA2UjdaVHcyeFF0OFcyYWlk?=
 =?utf-8?B?dVlNSDI3VEVqSFhnVG9MRWtjZ1JQekhNQkdBUG1VY0NocFhxekJtREdtRXdO?=
 =?utf-8?B?cmNpYjFzRVhVSndSRFFXL2hVb3JLL3N1UFM0MFJROWEyeXozUEMvVUU2MWsz?=
 =?utf-8?B?L0NScTErR0NnaitNdGs1YjVLODR1RXJFcG94TFVNbmRSOVNJUFlSMytEUHR1?=
 =?utf-8?B?WTZVOEVYTjRjaWYwcnVPcWNiYWJxNWhya0RIVk5ZUkJIdWRGbU1QUGlFWm54?=
 =?utf-8?B?bFdWMGEyZWNpZHhVOHZlN0lYdUx6YlB2SW11cWlkdHZFZklKMERiTVZhOXg3?=
 =?utf-8?B?Tm1mTW9JWEtMQitvemxXQmNya0g5RUE1M0xNTitzVG41Nk5vYzJPQW02eXZ3?=
 =?utf-8?B?Y0RDYXlFZnJCdWpRZ09CM2paTXd4VVdnYTN0SDl0aFVLNFV4MjNvbksyMjNI?=
 =?utf-8?B?OVNMTGl1cnVsNzV6N3gvOUt2L0JJY0VSeDlFdE5mc1FWMDZsUHN0VWhYMFpG?=
 =?utf-8?B?U2lIR3hPUmIwdzg0U0tVcUtoSjFCc0dIbk1MNC85UmFFRnJPV21sL000a1pM?=
 =?utf-8?B?UG5tS0Ftdnk4NFdWaWxRMXlpQkxTd2hscEp0a2h6Vk1HbzhQdGMwZkhkNnlI?=
 =?utf-8?B?VVdpK2hPSUFLaGd2bDVtOVdWUnp5ZE8ydFNOaC9aY3lpYmdWOHRHcUp1VTh1?=
 =?utf-8?B?S2pOV1Z4S0RJL1p1UTJGcHBqcXhOVytPRnhSL0N2aENHNTZ0ZE5ZVTk0UitD?=
 =?utf-8?B?a2o4YU9zSTg0WFc2dDU3Tks5aStMNWpoWUhsc2kzVC9manJ2dWpoRGhBaDZE?=
 =?utf-8?B?Sk5nOEZsWVNKUTBHQitCZWV0eEcrMGp6VVg5Q1kyU2FPN21uN0o5TGF6M21T?=
 =?utf-8?B?Z0xzU29VTmc2VXhDSTNyK0JPK2lzRWJWeDY4cWhlZER5djV0THJOc3FvdElE?=
 =?utf-8?B?RHFPUnJROEVPVUVHSGRJOGcwcjB4YjdTOEhPcG8rb1IzRXZsYkNFbUlMUFdB?=
 =?utf-8?B?MzRBUmR6cnY4WlNUWVBibnJRcEtFT2RDcnViYklsWTVKKzRUQXlKSGdOYnBR?=
 =?utf-8?B?aCtKTFozdXJuRndvT3FRL2JBc1UwR0tnQUMrUmwrRnRKTTlobW5GTG5GQzE3?=
 =?utf-8?B?TGRQVnlyZHQyWEE2a2ZoVXZscFdiaDBEWG05L21LL25hQ1NmN014Q3hla3p4?=
 =?utf-8?B?YituRjUyNWM3cnRUZy9SMXUxcVp0OTErL09wLzVnQklQV3VhT3ViaitCUldE?=
 =?utf-8?B?Y0JhdVNBN3Z6NFRpczNLUTRjbnR5bXNGNWJEN05SOTd0emk0ZmhEVHdGZjBO?=
 =?utf-8?B?Snl5Z3FMRmN5SnkxZ1lOeHBwRlNiOGZOcXJnRkZzTDhzYU1HdGc2OXE1TnFk?=
 =?utf-8?B?cHJrcU1HRkVrV3RBR0twbFN4Qk82dHZ4RDVCek9yUmlDVzVVM1JyV1k4OWV5?=
 =?utf-8?B?TDBGQmRHcWhLMmVCdzZIU1pPazROWU9VREhscWFnQ240cFRIUFFOalJubzdF?=
 =?utf-8?B?eDM2UWpzZUFOVVFrSHQ2WmVtdDRJcXpKOFpnbSsyemtyKzloSC9vQkVITFgy?=
 =?utf-8?B?TWo5TFlTa2lsTmtQL0NiWWd3N3h6YmRDMHZjMXlMRmFFcVBDc2F5Y0RsU1FS?=
 =?utf-8?B?dUJscnlWOXg4OTF5Mkg0TlI3ZDF2akxDZWpIVDBhemFNYXl2UjZWMG9MbXNF?=
 =?utf-8?B?a3hIMHdnQ09BRXl2d2RPUWZuZ0pUUkgwU2UrTGJVUk5uUTFuY2gxcGlPcmdX?=
 =?utf-8?B?MWV6Wlk3MXF5Q01TM3RLV3lBUjNzMVpmZHB6TG5HK2ZMVlhMaHFJNkhlbDJL?=
 =?utf-8?Q?/trHgffkQcVL/lAr046sLppz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1298d36-ecd3-4363-7e86-08daa06eca38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:58:12.9799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itdlFpMHRT9AT8OhTR6kDjvzX3z2/8KDqxb52CCKiY1B7PTHi11LWNvjGxoTQNgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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



On 9/27/2022 3:10 AM, Shashank Sharma wrote:
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

If it's all about pm subsystem variable accesses, this API should rather 
be inside amd/pm subsystem. No need to expose the variable outside pm 
subsytem. Also currently all amdgpu_dpm* calls are protected under one 
mutex. Then this extra lock won't be needed.

> +
> +	if (adev->pm.workload_mode == hint)
> +		goto unlock;
> +
> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
> +	if (!ret)
> +		adev->pm.workload_mode = hint;
> +	atomic_inc(&adev->pm.workload_switch_ref);

Why is this reference kept? The swtiching happens inside a lock and 
there is already a check not to switch if the hint matches with current 
workload.

Thanks,
Lijo

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
> 
