Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ACCC98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 14:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD65510F0BF;
	Wed, 23 Sep 2026 14:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLGK+fnW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FAFE10F0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 14:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZC1OFZT275Srwn5Y7nXQvxgNk1X0hwPweT53NHNZa65y1UR3cb8v9va5+DHMqGy/zYpD7DnmEEngLVAcjKxTL7ASabugjTQWx1ce7+x011ORk2mB55YFeBVIBa0Me4DSGfcNJYNsFpln0rUJ9K95rqCdPxHvuKMAsnM/To5/hd4VaLbea7CgPDTRncuikCEvXU3AdWihxpkg24UBgZohfHU6NAOp5E3YPI20eHPApNDede/H4ecMzoiB88M3Pi6XYJIOJmI22j9LbK4QzidH9rTkzucgStbq/n7Bo1VyQBucf5l0JcKIiQPIaYeFFZegPf7hj6BNZez4+Crc4hyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuDIV6Rq/I/w8He8WIPaBJR5N47aw/YIix2P4pU4W5k=;
 b=UKlcbSQbTyCaXNkKmU++ef8dzYEwhjDTsTKF8YBahPhNZJDsCL3HvD4GtZJqJb25mmxPX5iRolgvwmXDpSgqS51rxjiih3vdYTAqIvkVeD9pEzSJqd4M2exYfq27jMobxGRPuUsprScAHGN0Qi5IxYuf7X5hh9Wxf5xlRzJG5OXSPzQ4/BxeHo3+FIJ3n3NZ9VCAlTPPWXSWhCEtBsCButq/Zh64vg+CtI2jjmKIDjl7R9ZdKYto5GmrNtcDCBQ3TB1Zi56sNAp9wRzcyl/+yfmGtphMeo+A0/NaLu1mkNu4tToOzPrfAxduOagceVrx6iHSVFQwn+88Y1TSDTw3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuDIV6Rq/I/w8He8WIPaBJR5N47aw/YIix2P4pU4W5k=;
 b=RLGK+fnWnYBkG3q9Tf7TDZgnqlgVHEIShtza6bjQvl44v9C+XyTrtJDthThZfxwJof0HvucZFUubkMZq0rZKXg+VYRvmzzsm2AO8kZiOyG3RXr7UEAizyZFPOGjFzLTPyA8DbSgsnWIMddC2JDghCfEeM0H/39ShIsikWosT2zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 14:17:04 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:17:04 +0000
Content-Type: multipart/alternative;
 boundary="------------dBC9CJwVgUmJw6UYh0xR6721"
Message-ID: <a8011684-b04b-4483-b05c-d547c1f4f86b@amd.com>
Date: Wed, 23 Sep 2026 10:17:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] drm/amdgpu: implement PMC ioctl framework
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
 <20260922093436.596947-2-lingshan.zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260922093436.596947-2-lingshan.zhu@amd.com>
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c65e8f-1a72-45f2-f015-08df197d5757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|6133799003|3023799007|10067099003|11063799006|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 58mdPxGqX30BM73gNvreZpSha1AkCeznrdMDNewynnTL3eTz2SCl6s4GUSfKXFojsEaDPhcg3dP6TbzqgkXRePQYHzvmz8Qind9V0Ig+2jp3+lakfX5r0vxy161FLA6OgtTwKh+AsWTSUVAA8EJq7SzvSjD1l1Ke26Q3EbHZeFomhFYQstOreQajGqetSXVagsz4AxN+rV1HZYqSgnMt07j8vag3+HmWurHa8UyVd0SPfBn7K/LfV9tmtcOc4sFoN/8VBzu+cA717gIGIoRL7BnOawu/aDD3iLV/mFp3llo5IJjNFvvVR1a1E+97D2pmHz3Xb19a/aIYIPiE0r4hBkPjyr8e16fkTeDf7cmUzW4Q17w1+Z1E+j9+9l0mpzrlYIEL9EDHG1E13IzLotF1/0sZofkvErXVe63lJTFfSyDSCLv29cxnVwPZHkXQNuVdGxo3Hvhdp9Y/nl7Ky93yIr/9+CYOIlU7yI80g6aWYhBGKYc8enCgW1QwwSJrcZbz73RSdB7Xpqo6QKVyVkAqZa9/3m8R/oZOzPXJnkVsTvVeNY/s2lXSg1HAjaNzWYgK6YfCJIaMqC67I/Yj6ZWbRNVZYYaEPhyTw1sXHzZi6XYgocAHBOh+6CvY/KPgEL6OGU51G8uOdMhWtXZuNMrzSFareluC0UG3tBqW8pZsSjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNQVU12SURFNjlhNTY2eTVDa0RHZVp5WlZRUEFlMnBVNjhET1ovck04Nk96?=
 =?utf-8?B?Yk1FclBGYUIrVHhDa0JmeE9kWU5FU0RMQW9BNHVpRm44MVcrdElaVkRZcEcy?=
 =?utf-8?B?NXRYeUJGV0xMRHYrdzlhdjB3RlN4RHBIcFRIa1VWNjNtQlhKR0xlUlhXZU1Y?=
 =?utf-8?B?SlVZYU03WmRqblNaamppeTFBRXNoNTA0UlI3VmlRRmZaVzE4WngrY3RZT2wv?=
 =?utf-8?B?ZVI1V3RtZFZCQm5IRnp1dUlNamVyR0ZOb2tPazNsMGNsZlNqQU1ndEZVK2Er?=
 =?utf-8?B?cEVxSmdSZVVveTlOdmJsTGtyQVRWMHB2WC9xeURrVFl2RjBOeXgxZU50T0FW?=
 =?utf-8?B?bjZTbm9rZzd0d0RlNVZzT0pVdGVVbUNoR0hBeVRqeE5tWjB3THRKcXlpZnpH?=
 =?utf-8?B?ZkhlS1Rpano4cHI3UGNTa244bDN2QmFCR2RUV1JpRzhTNHRKT1RkWW9tYW5Y?=
 =?utf-8?B?emNkZ0xvUStCTkhsUElDbVA3bmFzbTV3T1RrTjV0b2dnZHRtVldoWVM0UWta?=
 =?utf-8?B?L1lNbG54TFgxSXc4V2l5RjE1VUF6SE5xTnE2d1BwNTJnV01DZUN0QmcrTUYx?=
 =?utf-8?B?Z1lZcno3RTgrb1FaeHhZMTY4SmlsY2pKNzhiemZpMURQd09CQ1g5eUR6T3Jz?=
 =?utf-8?B?U2dkR0VqYWh1UTJlWDBMTzFWMnZnMmJvL2RTcU1tMmd2NUFQQzRtN1JkbExW?=
 =?utf-8?B?TDNYWTdCWkIrS1RQeW41K05nQ3B4Rjh3R21idm8rTHZPU2kyZkNnZVAvcm5E?=
 =?utf-8?B?U3V4cHUreVpYV3pHWUlzSmRvSlk1VmZGWG8vdEdrOWZUN3RZL29vRmZrUDZr?=
 =?utf-8?B?NFltN0JMenBLQndNYUdZMjJac05zbXVYRWVPcnVwYUN6d2FKOFYzYXlDbmtG?=
 =?utf-8?B?ZXNzZUZZTFlTTzBmdkRKMFpSZHZMMmJvcXc4eG9abXBQRGhFYkwvV0thWFpO?=
 =?utf-8?B?LzlKV0pBK0xyaHo4NEpldVkwWC9hTDhReU5nMC9zUnVvaTRjWkhaOGE3UEZQ?=
 =?utf-8?B?T2NrUFRBUmZYRGVQaFhIYU1ILzZoWE4vdlNCOGlQaTEyNHFqbktBV2hnS3Jx?=
 =?utf-8?B?cUVQVVFtRFZzRStDUnRxRkxvRTVHSW1oaDRhVklGUTdhc0k5SlVhc3I1KzY0?=
 =?utf-8?B?ZzErOG8vMnBlTk4rYkluZFpYUVBWU0JycUlxOWVOTUgwNVNCWXhZV0w3ZmIw?=
 =?utf-8?B?ZU9VK284Y3RvWStYSStTQzNSUzFlVjdWcnU1bDh2M3d3cEVSM2xOdUtPeDR4?=
 =?utf-8?B?NGdPUEY4NlhocHYzaXlWTUhwcnNXY25Bd0c2Y3BUTDVmQ1NTVi9GU2tvM0NS?=
 =?utf-8?B?YldIckZ1aU5RMjhsNkJDRXZHRStDU1F2cVpGYjVLZlJkb2Vrb3VoVEQ0empt?=
 =?utf-8?B?WlFiTEZmRFJYQUtYWFhEZ1ZQc1dJcDhnNHBPbDJPaVhVd1JYa1Ruc0xFTlpO?=
 =?utf-8?B?VWxTS3FoSDV4RjJTOEtjUXdLVXNaaU8zRDlRczMwdU9XQkphbGNmUkpsbTkw?=
 =?utf-8?B?c2syajU1VEdDSHZrTFZsUi91RkVkTjVmUFQ2Mk1ENVlGbzhKaUhkZ1VmcmRI?=
 =?utf-8?B?OVo2RHhUV0pZUHExaEt5OTBYYW1qUlpaYmp2MzNkSVpub0pNZ0dla1RaMkN1?=
 =?utf-8?B?YTdkaHlsc1JjbXk4bkwrYlNOM1R1YXF0T2tBSDRMV0g4UWFvaGg5YVdHNHRW?=
 =?utf-8?B?bGtuSTJyWDhpUXowdzE0S2JucUFxVVZ3VUswSUxYRUZaS2NHbnh1bVlKdXJv?=
 =?utf-8?B?OGh1YmZRNkFiQ2hSd2QzSTRyeDh1eWtYci82aVMvamZ4d0VUT0owcDVMYmVB?=
 =?utf-8?B?RWtBOFZ6Y01FWnlIaXFMOVlDNVpqMnhUbEc5M2xPSE12T3BlakptTU5ITVkz?=
 =?utf-8?B?NEhhcWtoMk13ZG91ZmpJd1NRUytyQ0phWkE0dGNkOHBsNWRaMnhOdFRkdmk4?=
 =?utf-8?B?ZkEyOEZYMS84cXU3QjB6a1lacVU0VHNtZDk2M3M0c2lkWXdxMmRaRVhRcFls?=
 =?utf-8?B?NC9ISzRNVVRWa2t3eTVrS0ZaaFhCeC95bU9RSit4ckpBM2dQY2lnUU5FUytJ?=
 =?utf-8?B?ay8ydkR1RmQ0Z3VDbXpVZCtJekVITVpyTEpDVjl4c0hRdzVMV1BnelFjVGVk?=
 =?utf-8?B?ZmlkRWVUaG8zTjh5WndZZWQ0UzlIL2p6ejhRamsxanFCb2xNN2t3eDRlYUFD?=
 =?utf-8?B?YUlvL2FoblV1aVQvY3VRRnRSWVBScjVZWFEwa1JjaDlHeFZnWGVXQzVsTUd3?=
 =?utf-8?B?Q1V6N24rZzBTLzdSS1dDZmdtWXYzTmlLbFBiVkdscGU4dVdoTjEvM2JHMkFw?=
 =?utf-8?Q?O7n0T7qJP1hzwoKBYc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c65e8f-1a72-45f2-f015-08df197d5757
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:17:03.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEbAHTmby5TZu93KGoS5sLP3mHqCXX2KtGVbB5SFPDM11PD4C52J0qHw1yOyPeXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

--------------dBC9CJwVgUmJw6UYh0xR6721
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-09-22 05:34, Zhu Lingshan wrote:
> This commit implements basic ioctl framework for PMC,
> including basic operations.
>
> This commit also implements AMDGPU_PROFILER_OP_VERSION
> which report profiler version to the user space.
>
> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
>   include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
>   5 files changed, 116 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6fb0a913e33b..d7db69e9d6a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>   	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>   	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
> +	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7c473f60bd28..a98c4a47e196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -55,6 +55,7 @@
>   #include "amdgpu_cwsr.h"
>   #include "amdgpu_userq_fence.h"
>   #include "../amdxcp/amdgpu_xcp_drv.h"
> +#include "amdgpu_profiler.h"
>   
>   /*
>    * KMS wrapper.
> @@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
> new file mode 100644
> index 000000000000..04902696adab
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: MIT
> +/*
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
> + *
> + */
> +
> +#include <linux/errno.h>
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu_profiler.h"
> +
> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +{
> +	struct drm_amdgpu_profiler_args *args = data;
> +
> +	switch (args->op) {
> +	case AMDGPU_PROFILER_OP_VERSION:
> +		args->version = AMDGPU_PROFILER_VERSION_NUM;
> +		return 0;
> +	case AMDGPU_PROFILER_OP_RESERVE:
> +		return -EOPNOTSUPP;
> +	case AMDGPU_PROFILER_OP_PMC:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
> new file mode 100644
> index 000000000000..c27b5f9b3ff0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
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
> + *
> + */
> +
> +#ifndef __AMDGPU_PROFILER_H__
> +#define __AMDGPU_PROFILER_H__
> +
> +#include <drm/drm_device.h>
> +#include <drm/drm_file.h>
> +
> +int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
> +#endif /* __AMDGPU_PROFILER_H__ */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9222be9a6d2a..acc63804ba8c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>   #define DRM_AMDGPU_CWSR			0x1B
> +#define DRM_AMDGPU_PROFILER		0x1C
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -83,6 +84,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>   #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>   #define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>   
>   /**
>    * DOC: memory domains
> @@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
>   	} kfd_sigbus_delay;
>   };
>   
> +#define AMDGPU_PROFILER_VERSION_NUM	1
> +
> +enum amdgpu_profiler_ops {
> +	AMDGPU_PROFILER_OP_VERSION = 1,
> +	AMDGPU_PROFILER_OP_RESERVE = 2,
[JZ] the implementation tells that it is AMDGPU_PROFILER_OP_PMC_RESERVE, 
it is better to put it under new PMC sub-ioctl op
> +	AMDGPU_PROFILER_OP_PMC = 3,
> +};
> +
> +enum amdgpu_profiler_reserve_ops {
> +	/* release the device resertaion, only the reservation owner do this */
> +	AMDGPU_PROFILER_RELEASE = 0,
> +	/* reserve the device profiler */
> +	AMDGPU_PROFILER_RESERVE = 1,
> +	/* Clear the device profiler reservation, in case the reservation
> +	 * owner can no longer release the reservation(e.g., it crashes),
> +	 * This operation does not take the reseration nor touch profielr state
> +	 */
> +	AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +	/* enum amdgpu_profiler_ops */
> +	__u8 op;
> +	__u8 pad[3];
> +	union {
> +		/* AMDGPU_PROFILER_OP_RESERVE: enum amdgpu_profiler_reserve_ops */
> +		__u8 reserve;
> +		/* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
> +		__u8 perfcount_enable;
> +		/* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
> +		__u32 version;
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
--------------dBC9CJwVgUmJw6UYh0xR6721
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-22 05:34, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260922093436.596947-2-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">This commit implements basic ioctl framework for PMC,
including basic operations.

This commit also implements AMDGPU_PROFILER_OP_VERSION
which report profiler version to the user space.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 44 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h | 33 +++++++++++++++
 include/uapi/drm/amdgpu_drm.h                | 36 ++++++++++++++++
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6fb0a913e33b..d7db69e9d6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
-	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
+	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_profiler.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7c473f60bd28..a98c4a47e196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -55,6 +55,7 @@
 #include &quot;amdgpu_cwsr.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
 #include &quot;../amdxcp/amdgpu_xcp_drv.h&quot;
+#include &quot;amdgpu_profiler.h&quot;
 
 /*
  * KMS wrapper.
@@ -3096,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
new file mode 100644
index 000000000000..04902696adab
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include &lt;linux/errno.h&gt;
+#include &lt;drm/amdgpu_drm.h&gt;
+#include &quot;amdgpu_profiler.h&quot;
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct drm_amdgpu_profiler_args *args = data;
+
+	switch (args-&gt;op) {
+	case AMDGPU_PROFILER_OP_VERSION:
+		args-&gt;version = AMDGPU_PROFILER_VERSION_NUM;
+		return 0;
+	case AMDGPU_PROFILER_OP_RESERVE:
+		return -EOPNOTSUPP;
+	case AMDGPU_PROFILER_OP_PMC:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
new file mode 100644
index 000000000000..c27b5f9b3ff0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_PROFILER_H__
+#define __AMDGPU_PROFILER_H__
+
+#include &lt;drm/drm_device.h&gt;
+#include &lt;drm/drm_file.h&gt;
+
+int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+
+#endif /* __AMDGPU_PROFILER_H__ */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9222be9a6d2a..acc63804ba8c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern &quot;C&quot; {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_CWSR			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,7 @@ extern &quot;C&quot; {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1809,6 +1811,40 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+#define AMDGPU_PROFILER_VERSION_NUM	1
+
+enum amdgpu_profiler_ops {
+	AMDGPU_PROFILER_OP_VERSION = 1,
+	AMDGPU_PROFILER_OP_RESERVE = 2,</pre>
    </blockquote>
    [JZ] the implementation tells that it is&nbsp;<span style="white-space: pre-wrap">AMDGPU_PROFILER_OP_PMC_RESERVE</span>,
    it is better to put it under new PMC sub-ioctl op
    <blockquote type="cite" cite="mid:20260922093436.596947-2-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	AMDGPU_PROFILER_OP_PMC = 3,
+};
+
+enum amdgpu_profiler_reserve_ops {
+	/* release the device resertaion, only the reservation owner do this */
+	AMDGPU_PROFILER_RELEASE = 0,
+	/* reserve the device profiler */
+	AMDGPU_PROFILER_RESERVE = 1,
+	/* Clear the device profiler reservation, in case the reservation
+	 * owner can no longer release the reservation(e.g., it crashes),
+	 * This operation does not take the reseration nor touch profielr state
+	 */
+	AMDGPU_PROFILER_CLEAR_RESERVATION = 2,
+};
+
+struct drm_amdgpu_profiler_args {
+	/* enum amdgpu_profiler_ops */
+	__u8 op;
+	__u8 pad[3];
+	union {
+		/* AMDGPU_PROFILER_OP_RESERVE: enum amdgpu_profiler_reserve_ops */
+		__u8 reserve;
+		/* AMDGPU_PROFILER_OP_PMC: 1 enable PMC, 0 disable PMC */
+		__u8 perfcount_enable;
+		/* AMDGPU_PROFILER_OP_VERSION: AMDGPU_PROFILER_VERSION_NUM */
+		__u32 version;
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
</pre>
    </blockquote>
  </body>
</html>

--------------dBC9CJwVgUmJw6UYh0xR6721--
