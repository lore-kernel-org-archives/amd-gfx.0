Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C5ECD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A0F10E256;
	Tue,  9 Jun 2026 10:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XO1TAMBF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E0210E256
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lydJeCF3Aa8iTPiwuNKnKhSz6PESDjQYwhBkVFRuWGJYRnvicuMbUP2PW7xre7GFk9GM+lun7dVIymiIrJapKP9e72j95qEJ9114me46DRcNWLYoOZZpon+66xCUiwsAsTEiSh0BJe4q5hfb3GeewXlX11CDJz0UdPEwy8sLU7cCP+iAy8l2khLF43PNyslnYuEfCZ1BBJSHbchhwNzjqsltOmu6T5jBM0+b1Atqrvyq8TemXCEofz0+3uV3smJ45d4wLrWQxzXCd3RilzQ/0o24aqGUtLVHY7dvehZfzgPYBXWmh0vlenqFhO9nCOYF7zHoVX4N8pIj0fxr1/gXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xA1S94UFP1joTOAlw+zawUgbrL6jaykbSrk2qQTYso=;
 b=aAFkSgbQoSogg+KztnLPEB6d8tnE72n1GO3zJL7uGWQeHjGZDSRg3w2rfGjtiZRLYAHj1qdgeeuXYHX7Q/+Gn0yZcnGl8IqaXyIHMErf00MXLcVKvJnGD0Uz+P9sbwpqjSOtkvuvLrECQq774U75ODEaz3QkHIZfOTZsj1vj4R6gX3uJgNuHrfV9J7fuWV07BolGvZ9HQNsAfrLwcYvHZ0AB9aYg1/yY6UOcLPnV7XEfRjBgNASU0T4P8pt+v1CXyDCuqpqePmgBI3e56Ne90FhDG2AK45XJZyQRB8ht0bL4NsK7cQvI/ZqIuI1W9Qrj0qgpHEo9OrpmcHWZaPO4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xA1S94UFP1joTOAlw+zawUgbrL6jaykbSrk2qQTYso=;
 b=XO1TAMBFn7fhcmzpIbJhLtTfQB1V7OzTlC+Kp0FJ1+8mgPR05+wpq9BYZe/IbWfv9KQ9b7/SiioPUyJlU2OC8PeLQATfaRPqTdw9xMkMfEsem0mbxinmKnuBTD0d5gymEiy/Hk9VsV7z+Lt9z/a0/geEDytDFABFEUX8uHiXA1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA6PR12MB999202.namprd12.prod.outlook.com (2603:10b6:806:450::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 9 Jun 2026
 10:58:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:58:05 +0000
Message-ID: <c2600b6d-0032-47fc-aef8-859be4164ad8@amd.com>
Date: Tue, 9 Jun 2026 12:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-6-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-6-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA6PR12MB999202:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a9cb5d-c2c0-4243-dda4-08dec615fb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|18002099003|6133799003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: dMcC+z/b1hDHEDzINL02U11o55jxphh0SaT+IuhfFpSyvfTwM0KbtnMTAqKoZ+A94qHD1KVZpicp1SNsTqmooF/FbkB6ClACCsE8o8xB3VNp/z+psJT0ojhiDBeP3BC3GnZU/gvhLZN4VtWaFfsbOl0jhaKxu2GvPHhK695ZoDm2D2kWqXpR//TJUsP11POunYkbZxG+6d+fBh1B9YQe2lcy+yI+GhG53ON0xmRUSlvJmgn9i+AGXAwpuzodAPy8/wR3/TtZuyuYweVSRdXE0YID3RwA5NsR1e74E59uMTy+FpKNJ3VJPJPuHAKIq3NrbQheXug4a39a9r8pb7/Fd6BWXCwoRI4HmiA6htFmCbEGttcmgdgezhQtwbxO38qq1BTbDKD/jgeT9wGf9wDQueiZiOerTbHVBzKPifPF16fK5U6hDSYjZ4QhfZVXq+EMT1/JEgk8/PTe9mOlcp5bt5826oQcZ5W711fp64Wf60tCnnvYRuXnTAttC7nj5v6SurM1kd/QBBPMfZMt0yKVgJ7Ofj2B5UDwWfi0WOnWbDA4ZUMPjPJRGsY1tI7iVDZ+ECiliXbWk2vcsvArzQmGW6eU5wEQxegn0N6JCAyLWF3RpfY+tp36Cf3YttZQUM39zO4SYNwdTV96hViEuWSR6NyPLXrEYN6Chw6D99Mo3+YdHExjxDIQrnwxtUCYcnKM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2J2b24vUmhBeitVeFBRZ3V1UkNYMDRCRTQvUjBjUk5hSDFxVHlTNlBEMUty?=
 =?utf-8?B?aEpYeUsvQlBZN0lMdVZmSGxWN2RJYi9wKzl4Z05leWxOTWhhZlV5TG9qWjNB?=
 =?utf-8?B?UnRHdnJLelh2a3UxbGdnNDhvZk10SnJjaEYrckhXTHdZY2JqMk9VTis3YUln?=
 =?utf-8?B?ZWh1T2hqcWlYSCtTc2dPZ1NEUzlLeUFPY1JUWHdhZjdsNDNUbFdwcm90aG1G?=
 =?utf-8?B?bSs2VVFhckN4aHRkTGNHZE1qYUJVUVdWUlRwN1d3TERDWjA0SHVvRG9KNDlo?=
 =?utf-8?B?T2ZwMFpwRnM1bldqaVdDY01TK0Ewc0V4RS93NTA0ZmZ5cVpZLzhJTHo1VmI5?=
 =?utf-8?B?ZXZVN3I3OVRiOGJXdU9nWVJjOTd1RWtreFhnL1BDSHVhN1ZMcFNJV08rdlRX?=
 =?utf-8?B?UGovVjJ6bWwzdGhLR2xLQ25tWHE1cHFPa1E4Sm1RWVcvVGI4MUlaYmt1K0g2?=
 =?utf-8?B?b3RJRzVjcVdKVUNxeE92WnVHN1FWdm9lSEZqRzE1cXhhNGlKUGFBc09DUUNU?=
 =?utf-8?B?NXp2ODJGS1pBL1I1RWcvaXlQQmxVR2R0R0x3ZzNtTWVHRU5yZUVEMTZBU0ZU?=
 =?utf-8?B?UGYwZGdBcGh1Qi8zcmtTN0NCYmR2Vlk0WlV0a2M4amdMWWR3QlplMkptZms1?=
 =?utf-8?B?dTIxQUpoM1RtZ2lJSnFBOEhjS2xjMnNyVnZneWVTbFNUVG1mZnhZMW5DZUlM?=
 =?utf-8?B?dXpkR0o4UTNaUmJ5aG9KaVVTN0xuNUY0RWV2U0VTRzRlbEtsU3JUWDBrbWFX?=
 =?utf-8?B?VkZZNzhzb1diRnN3VllUczlzcGtCVXBNUHFWeGZXRmg0dmt6MytaOUFLZ0pL?=
 =?utf-8?B?UHlqVDlWQXEvblUzeDZLUjRPY2UyeW15ZnF4bEVTdVhYREwzQ290UHYwdWp1?=
 =?utf-8?B?NjVNNzJQVTRpN0NmSGFKMGZnelB4dk1QVUI3bEVMTVF4OG1OWjV6eHdjMllP?=
 =?utf-8?B?dStKQlRIdHlVNjA4RGZFVWNyMVBpUXZ3MTE2RUYrc2VzV3VPVkkzL002RFgw?=
 =?utf-8?B?dVRUSUpaMS8xWndiZDUxWW1tMnp5STNMVXJwT0ZOT3FZVkxaVS9iaDIxUThP?=
 =?utf-8?B?SnpzZWw4Sjc4UERhL2FUUm1YK2FzTzVDYmR3WkJhY09Ra2tUc0svRnRSc2RR?=
 =?utf-8?B?b213dUVKckthbytNODRldlFxS1ltVFBqamwxb0djbEwxQXF1UU9TR1Zib2Qz?=
 =?utf-8?B?dFlHME9KTHZnY25laUJIVm5McFVFcytwcmJIL3BMcVRnMnVhbTU5OUxGeXBn?=
 =?utf-8?B?UFVrZG1FY3VLckJxaW9oeHIyTWp2VGJSYmV2Y2tTSnJxbmo4djVacWg1eUUw?=
 =?utf-8?B?MUtlbzlxVUZ5eXJHanV6Z0YrMkw1MTdBZFNOYzgzS3NXVXlyb3U5cjV1Nk9J?=
 =?utf-8?B?ZVppSnRVWXJkZlErdElCdDAwbnU1M1lJMUlZcmtHVVFGcncrYnNobjlEWHYx?=
 =?utf-8?B?dmVNY0xsM0V3R2hKMGwyeDBXV291NHJST3BKd3NrMVlqMzZKOGJPdEFZcU00?=
 =?utf-8?B?TUZVbE5RRUJ4SXM4aEhmdVA5a2tYaG55eEpTdzVVZ1E3bllrZVVZRXArYVU2?=
 =?utf-8?B?c3ZnYWJqanUvbG5CZDArWHhGS2JBbG1HNHJNN1lXVWg1elRReGRSSkJYdDJr?=
 =?utf-8?B?aXBwYy94SkJNbndhaVk0bVFmK1Q1bm5maVR5U3pwM2diY2NDWmdNQkNrTmFt?=
 =?utf-8?B?UDVoWnFvMVdaYk9sZ1VDeTFGWjJNK2dYc01JblhpMWlyTHppdjlFMytRQzZM?=
 =?utf-8?B?Wm1FeUs3SFhwR2FXeGJHSURUUXBvZmZZOVNIemlVanBTcHg2bkkrbXR4T0tF?=
 =?utf-8?B?NmhuVGRkd01kbTFTM1pFbHBTZi9QLzBlWVoyVm56eXphMjlxZjUzTFJGUXVD?=
 =?utf-8?B?a2pueDdDRUVLVTdITjVHZDZTZ09qYytWK25VdjFOcWtvUEJuUWFRUWdQZUVv?=
 =?utf-8?B?WlZZRmRmYk9USTRaZTBYWTJzZ2NNV1IvbkhLM0UwL3dUTDQvaWNKaWRpeHVr?=
 =?utf-8?B?c2dxWnpkTHl3a1ZOT3o0RU13bkdvK2tLTmp0UUkyQnlVeTFvNXpWQ3cwNzd1?=
 =?utf-8?B?Sm1KdDdUOUxiT09qd2R2MFFHbXZuNGcva1FoYmsyZ0FGNXR5WmU4ZzZ4WWtr?=
 =?utf-8?B?cDBTRXF1eHN1d0c1VHdOOXZpT3dQYnhXWXRYWlZTeWZtTGYzcjZvV2ttZDFF?=
 =?utf-8?B?WVdxUUFDRFRVUnNocGRoelM0OGNaTitSaDZnQkNUZGpnVTNsZGtYelFHMjI1?=
 =?utf-8?B?L2R0cXNDdktGcWxmb0ovTlVSZ2lUY0p4NEVzT09NZUFqMXJZVnNWZGZQamlY?=
 =?utf-8?Q?ob0EAr0Vzq6gcY95KZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a9cb5d-c2c0-4243-dda4-08dec615fb9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:58:05.2677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtRPO9WBGpqIzfig4M0Y5FDklgoSyID1p8gAMXSZZ1QZkMs5hxqRaxBuX4fThPiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR12MB999202
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
> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h into
> a new amdgpu_mqd.h file.

No need for a new header, that can go into amdgpu_mes.h

Thanks,
Christian.

> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 47 +---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h | 75 +++++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8fb70731ea58..9473626ea96f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -114,6 +114,7 @@
>  #include "amdgpu_sa.h"
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_mqd.h"
>  #include "amdgpu_uid.h"
>  #include "amdgpu_video_codecs.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
> @@ -611,44 +612,6 @@ struct amd_powerplay {
>  					  (rid == 0x01) || \
>  					  (rid == 0x10))))
>  
> -enum amdgpu_mqd_update_flag {
> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> -       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> -};
> -
> -struct amdgpu_mqd_prop {
> -	uint64_t mqd_gpu_addr;
> -	uint64_t hqd_base_gpu_addr;
> -	uint64_t rptr_gpu_addr;
> -	uint64_t wptr_gpu_addr;
> -	uint32_t queue_size;
> -	bool use_doorbell;
> -	uint32_t doorbell_index;
> -	uint64_t eop_gpu_addr;
> -	uint32_t hqd_pipe_priority;
> -	uint32_t hqd_queue_priority;
> -	uint32_t mqd_stride_size;
> -	bool allow_tunneling;
> -	bool hqd_active;
> -	uint64_t shadow_addr;
> -	uint64_t gds_bkup_addr;
> -	uint64_t csa_addr;
> -	uint64_t fence_address;
> -	bool tmz_queue;
> -	bool kernel_queue;
> -	uint32_t *cu_mask;
> -	uint32_t cu_mask_count;
> -	uint32_t cu_flags;
> -	bool is_user_cu_masked;
> -};
> -
> -struct amdgpu_mqd {
> -	unsigned mqd_size;
> -	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> -			struct amdgpu_mqd_prop *p);
> -};
> -
>  struct amdgpu_pcie_reset_ctx {
>  	bool in_link_reset;
>  	bool occurs_dpc;
> @@ -1035,14 +998,6 @@ struct amdgpu_device {
>  	struct amdgpu_kfd_dev		kfd;
>  };
>  
> -/*
> - * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
> - * as fence address and writes a 32 bit fence value to this address.
> - * Driver needs to allocate at least 4 DWs extra memory in addition to
> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
> - */
> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> -
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>  					 uint8_t ip, uint8_t inst)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
> new file mode 100644
> index 000000000000..3806ade5fa71
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mqd.h
> @@ -0,0 +1,75 @@
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
> +#ifndef __AMDGPU_MQD_H__
> +#define __AMDGPU_MQD_H__
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_device;
> +
> +enum amdgpu_mqd_update_flag {
> +	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
> +	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
> +	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> +};
> +
> +struct amdgpu_mqd_prop {
> +	uint64_t mqd_gpu_addr;
> +	uint64_t hqd_base_gpu_addr;
> +	uint64_t rptr_gpu_addr;
> +	uint64_t wptr_gpu_addr;
> +	uint32_t queue_size;
> +	bool use_doorbell;
> +	uint32_t doorbell_index;
> +	uint64_t eop_gpu_addr;
> +	uint32_t hqd_pipe_priority;
> +	uint32_t hqd_queue_priority;
> +	uint32_t mqd_stride_size;
> +	bool allow_tunneling;
> +	bool hqd_active;
> +	uint64_t shadow_addr;
> +	uint64_t gds_bkup_addr;
> +	uint64_t csa_addr;
> +	uint64_t fence_address;
> +	bool tmz_queue;
> +	bool kernel_queue;
> +	uint32_t *cu_mask;
> +	uint32_t cu_mask_count;
> +	uint32_t cu_flags;
> +	bool is_user_cu_masked;
> +};
> +
> +struct amdgpu_mqd {
> +	unsigned mqd_size;
> +	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
> +			struct amdgpu_mqd_prop *p);
> +};
> +
> +/*
> + * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
> + * as fence address and writes a 32 bit fence value to this address.
> + * Driver needs to allocate at least 4 DWs extra memory in addition to
> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
> + */
> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> +#endif

