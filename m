Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64FACA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 13:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664F210E564;
	Mon, 12 Oct 2026 13:12:55 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCB510E564
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 13:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4KRUSFOTVvrQyffxGAhU5sXoIz8P7KNG+CyfIuR0AiDvhFXj/YxibD8xkXdRXXSzOgp3xdoDjprXj0I/P67e+Z6T/sPdXgjkBQoP18Yi4IWf0oKeNKRZDiiRnRnP0nAK6l0u+izVpV5JREYkoTXnipmo/ZTKOiWLgTWHS/9iN6pkbl3qmErcNxMKSbfFISDygY8YKUEN3ghc0b28OZlYEmgqRVytg2IPOxc/hooSm3pXdQdf8A6ihDQuvBCPCavuOasswURh9xr6s94N+ff0HdAQMNwH/DNVAKy3Dbm6IRhuqKlbAepr4a3VBRi8hNnNtwAOJcZSHLLE/fBXih53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VufsBIdAok8mTMvC868X61xKnJ6CrgIyPlDseFEg2kY=;
 b=NI8rU6nCqcWfLfEx82qGsTY1upj/9jTfJ9Zniq0aGHVGgujLzWbr+WzVJNg1ssYg0bnyI8z1cRTV7dBw0daZN30o2eNXRagdTPtOttP68f1uPNCmSJxa4uiEEKqUO56VZg+XYwF/Fm33dfjyvRASp0Cb/EicRHt09GgDJVdhel08rjbOSDr4GQTkQfyTM85IjiP0h45tkBxadfT5UkD2mRuuarfWIxzRxUeXqBWq0q2yZ4xYhTr4RFKVp4bdOLOLWgsQHEqV5AhyLJKdgX+hb813YrTw4p+wo+YEmPO49Gq4J2rht31cCWRc8UxhK1rmzB+z6cGwXkKH8dEaRePdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VufsBIdAok8mTMvC868X61xKnJ6CrgIyPlDseFEg2kY=;
 b=UVa1pUvIp4yVXiCIXYLUNve9Xpa1DJejHJ7f7/jMIK8F/QSTWk07pb/dvo0lECcXzsgjU9DAkFcxL1mvpQbKn6yF2cKtOBEYGprTANuOYcqtuE/oVBUPa6AB3fiRY3GcGPRZ8h03V7MrLGfmyxQG8mo7qEZf32oDIaKY82fv+dQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 13:12:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:12:45 +0000
Message-ID: <deafe16c-0d2f-4042-80cd-99d88bcb3381@amd.com>
Date: Mon, 12 Oct 2026 15:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Integrate CWSR with user queues
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 James Zhu <James.Zhu@amd.com>
References: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
 <20261008070542.1111149-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261008070542.1111149-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: e446fc5c-d0f2-4c64-9891-08df28628125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: iDTRUE2h6JP1X4clIZT6BULt7EWMweAQgrZZvrcySyHhTz3NBAM0nZIWlXDjhmvebEARDbrJ1Tcgi1VdqhNHjGFuYJfpUpM2yOKm/z6cvhNNsMCzjWAWCLQeoXs/V5QKTkY7LZAX4nFiy1qdUnfwq+GH3j4eOVRl7Qv8yB02c4GdqjAl4qdYk5DPQNBVogEJdAoIpuSr6xwYNlGoddyc7GAB8uHfm8S9skn0eTTHtJ97/9VMx8AfyZoxYntehOrJuDcVjBpHL0UKgR2Et091+Br+fLi0RMzgTRD7tWflbxVeCpH/ivM1HgQtNHNIj8ZgThS6XqPPxLjMTxQmblq6HEh9u0MH2VycBI5pB9uyVyMX5/GOuyOBgtsb80YtcAh/WG5rA95UJTBkgAeGOzimGkv4IAGL730EVBP89qTANvlBdYly3VFFWzVUndGD268jclABGEuMTveNxEdWmuHhPIpsufWXjiJzMex29jZp8mP1Dcca45tKFtGTMvr1vaIZnz1ZEX4urq8bLSYpWGe7NNMwvKfqycXLFVgk1I9hLbY0QvWHeboJ0vDOyRcdCw4/PxiBj3f0DDdpUI7p+o7iR9tdlad1vSgKmVvJLhVruJZHlPAuW/HhDBW9pg8r8IYA4kH55n43LiLV7nCh8lRiVZWc/kL0pLa0Qik/tt9aXWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFpkeFlab2xNYmViWGd3TmJHTzRyV0FLNHZBY0MyeHhneE1tN2ZsWkNMYm1y?=
 =?utf-8?B?enUzQWxBUzQzeCtjL0FhOHU2ejRtWmhZK0Z1YTVyS1dWdWw2UXQ4elllUzQ0?=
 =?utf-8?B?eXJ6MkM4U08rS1lRR2xldmVqTENZajNCaExsRzJGK0QwTzNhc2hjUFE1UkN5?=
 =?utf-8?B?NUQ3TkNoYU5OZ3FLUlB2bXVkdkJma0w5RnNrVVRjYmZYWFZLeGZUNGZRaU5h?=
 =?utf-8?B?S1pCUVEyVGhMYzAyMTk1QzJVQXRlMy9tY2NPaGM1WGgzS0h3Y2szVEVBMGty?=
 =?utf-8?B?R3J6N1FvR3dIQUw1UFlocE9mNEF4Z0t3dW02YStiRmpIUTc4S0FnMEtKQkIw?=
 =?utf-8?B?VnRFTGNHYmxjSElORGFHWDVqZTBqUU5QWnFmS3dKczhoS2xJbktGMW0zOStZ?=
 =?utf-8?B?alhCWTUxV0krL1c1VGwyNGZuQkwxbFdsS0tnejVLTXd4WnZzdGhGNmcvc3JD?=
 =?utf-8?B?TzlTTUI3QjgyMU9uejM3cHU3OUV1YVY3dnB4NzBob3dERUVHcjVnNnVTeC9o?=
 =?utf-8?B?WEkxMUFPMGU3emRTUUdtdURhSzUzK1E3TkVvNnpTKytWRlhVZjU4QjNHU0xx?=
 =?utf-8?B?MU4xZzRCUXlBUEdydjhxTzVpdFh0RXNVdFMzQVZyUGtSVXJsT1VPcHlVdFNN?=
 =?utf-8?B?aE01b0F5OUt4RFdha2Vteks2N2NHVjFPb1FKNVg5MHN3eko4QU83ejVzYmJJ?=
 =?utf-8?B?SmlDMmE0WDBHMTZZRjZkUTZoODlvTzNROGNETU5xbUF6am1uejY1V2YyOHpU?=
 =?utf-8?B?Tnhyc2tyVFBocFZabnQ2VTJBWDRRUkgrVGJxcTJGdmt5bnVxWG1XZjhlZGwv?=
 =?utf-8?B?c25wT3JBbDlxbW9EalR1QUdLcWdTV3hISTg3WHJ6REJ0allnUzFhbEg3a3dU?=
 =?utf-8?B?R1BIQjVmbXppbzNCbzl4RW15aHBabVRVK0hZOG90bklVa0l0QkN1VHo1ZzVN?=
 =?utf-8?B?MmNvMUltdkFFZkJDWWtlb3B5VkZwdEk3NTVTb0lBNTIzRmREVWhlSmJNMjQy?=
 =?utf-8?B?aVRIekFWUnB5aFhuUm0wK0ZjN1hjMWZPZmM5TkYxbEp2bXdqZGwvMEpDS1Fk?=
 =?utf-8?B?TWtRWUhoWTRONjRJRW5aN0xtYUM3MGtaWU1RbTlCM0J4WXh1K0lUZEp4WHVv?=
 =?utf-8?B?ekFvTnA2RFhxazdMNU5OUGs2blQ4ZVdFa3VLYUpzR3RiY01zMVljeG9kbU1X?=
 =?utf-8?B?VlBONkJNbkhWcnFuUDAvZ2V3eVNQZEo2eFRBekJkQ2YvWEZISmxtYnBvcHM3?=
 =?utf-8?B?Q2FGVTlwVUhoYjMvVU44RzhrOUJqWWhlOTVMelNnUHI0UkNCdDg4bytLRHNR?=
 =?utf-8?B?NzBqbU96NTAzcnBBUG9FSWc1ZUVkKy84VU02dnZaZXZsWEk3bi83VC9keHUz?=
 =?utf-8?B?WHYrOFluZG4rZTBlVFp4S1RLYUNBUHczTTI1aEN0WDEwaWtSNlRzeks3WjNa?=
 =?utf-8?B?aldaRkJEKzlVSm1Va0FNeEVCQTJVekFVMlBUVEx0K2wyNU56WVlTMk1Gampt?=
 =?utf-8?B?VkQxaTdrc3ZXcktURW90bGlFQ3VOcitjN2hPNTB2UGNhVUJ2OVRPWDFQRXI1?=
 =?utf-8?B?bG4xUDNFYXcxajltRzFZT3RncG5vRFlKV211VGVoK1B5MU9EdXpsbGVCaGRy?=
 =?utf-8?B?UUtBL2tBcWw5b0hMWFVtL3l5MWZrdWtGaURXeVB2TXI4V2FFUWhwZFdDS3FJ?=
 =?utf-8?B?WWNySW1lNVZwUDgxNUJXWm5mUnMyZ3U5bXIzQm1yTHF3dzhwdjZ3WHRLR2dp?=
 =?utf-8?B?Mk9YWUsrV294M29oYXdmbURvUzczSzV1Tlh4blovaTg5dkQzSHlmODVRbUVi?=
 =?utf-8?B?eThmTmVvZDVFNTY5VlYvMDNCRVJMYk40OGphRnlIcnE2SXN4QkZ1Y2VOaFAr?=
 =?utf-8?B?dHpNdXdMSytEeHZ6OFR3K2NyRWNHWHlNSzhWeXJGOE1nNExuQ2RaczhBQkZY?=
 =?utf-8?B?aG93Wk9aRjIxaytSZXY1aWFDKytNTTlwUVhWd09tYzY1ZlA2MHhTa3RqMHJU?=
 =?utf-8?B?eWVQcmFSaGdxamxiNWhtVHlrNHp6RnFKVmpuRzc4QjNLd2Z3am1UT2MvM0lW?=
 =?utf-8?B?OXNkL0RCbVgrR0R2L04yb2JtRHNVYVo3SFg4akovb3dPeXpPZGZNbW5LMDRZ?=
 =?utf-8?B?QzVzL0JFbFhDVFN4ZXVyMzFjRzhjeVQ1Yi9NN3hsSkI3TTlzVnZJNXM1NHAv?=
 =?utf-8?B?YmtoMmR1bElCQXFrV1hJZFZoUExXR0x1ZkEwcWhIRFRKS2ZIR0NmKzQ5OFhp?=
 =?utf-8?B?QXhKc203K2ppK1B6TlpycmJlL1ZmZFAzbDIxaHJZRklnQmo2NnR5eDdJamlR?=
 =?utf-8?Q?JYoz/ZnpESAczsY7/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e446fc5c-d0f2-4c64-9891-08df28628125
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:12:45.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 358AjFyoZ+0a9iuuH9y/ZPclCoEtvS4TvAKbDR6K7AYSZDYHXmtU1vx1zy4nhGxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

On 10/8/26 09:05, Srinivasan Shanmugam wrote:
> From: Lijo Lazar <lijo.lazar@amd.com>
> 
> Initialize the CWSR handler during device initialization and release
> the associated resources during device teardown.
> 
> Add a per-file CWSR trap object for render-node user queues and map the
> first-level CWSR trap handler into the GPUVM associated with the file.
> Use the mapped TBA and TMA addresses when programming user queues.
> 
> Add user save area parameters to the MQD properties for compute queue
> creation and validate the parameters before using them for MQD
> initialization.
> 
> The CWSR parameter validation walks the VM mapping tree and updates the
> user queue VA mapping state. Reserve the VM root BO around the
> validation so the required VM reservation is held while accessing the
> mapping tree.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Co-developed-by: James Zhu <James.Zhu@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |   6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  10 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  25 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   8 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 102 +++++++++++++++++----
>  9 files changed, 163 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 26561a4f4db8..bdd55ac5b06e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -333,6 +333,7 @@ struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
>  struct amdgpu_cwsr_isa;
> +struct amdgpu_cwsr_trap_obj;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -421,6 +422,7 @@ struct amdgpu_fpriv {
>  	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
> +	struct amdgpu_cwsr_trap_obj *cwsr_trap;
>  
>  	/* Eviction fence infra */
>  	struct amdgpu_eviction_fence_mgr evf_mgr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> index 7f922559e297..5717e1d662fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -78,4 +78,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
>  int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>  				struct amdgpu_cwsr_params *cwsr_params,
>  				int num_xcc);
> +static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> +{
> +	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
> +}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e0014611f039..5a7f111763bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,6 +81,7 @@
>  #include "amdgpu_reset.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> +#include "amdgpu_cwsr.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -2549,6 +2550,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  
>  	r = amdgpu_cper_init(adev);
>  
> +	if (!r) {

Better make that if (r) goto init_failed; to keep the style consistend.


> +		r = amdgpu_cwsr_init(adev);
> +		if (r == -EOPNOTSUPP)
> +			r = 0;
> +	}
> +
>  init_failed:
>  
>  	return r;
> @@ -2946,6 +2953,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> +	amdgpu_cwsr_fini(adev);
>  	amdgpu_cper_fini(adev);
>  
>  	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f34150d20a2f..f3945b3988d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -49,6 +49,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_ras_mgr.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_cwsr.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1552,6 +1554,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  			 r);
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
> +
> +	if (amdgpu_cwsr_is_enabled(adev)) {

Better move that check into amdgpu_cwsr_alloc().

Apart from those nit picks looks good on first glance,
Christian.

> +		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +		if (r)
> +			dev_dbg(adev->dev, "cwsr trap not enabled");
> +	}
> +
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
>  	file_priv->driver_priv = fpriv;
> @@ -1621,6 +1630,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	}
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> +	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 2b13a5b37539..b3df09dbcbad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -527,6 +527,14 @@ struct amdgpu_mqd_prop {
>  	uint32_t cu_mask_count;
>  	uint32_t cu_flags;
>  	bool is_user_cu_masked;
> +	bool aql_queue;
> +	u32 queue_percentage;
> +	/* used in gfx9 and gfx12.1 */
> +	u32 pm4_target_xcc;
> +	/* cwsr params */
> +	u64 ctx_save_area_addr;
> +	u32 ctx_save_area_size;
> +	u32 ctl_stack_size;
>  };
>  
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e29823ae8672..6eea0ca40556 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -35,6 +35,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_cwsr.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -266,6 +267,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	return -EINVAL;
>  }
>  
> +int amdgpu_userq_input_cwsr_params_validate(
> +	struct amdgpu_usermode_queue *queue,
> +	struct amdgpu_cwsr_params *cwsr_params)
> +{
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
> +	struct amdgpu_device *adev = queue->userq_mgr->adev;
> +	u32 cwsr_size;
> +	int num_xcc;
> +	int r;
> +
> +	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
> +					num_xcc);
> +	if (r)
> +		return r;
> +	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
> +	if (!cwsr_size)
> +		return -EOPNOTSUPP;
> +
> +	return amdgpu_userq_input_va_validate(
> +		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
> +		&queue->userq_vas.va.cwsr);
> +}
> +
>  static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..727f60c40bbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -41,6 +41,7 @@ enum amdgpu_userq_state {
>  };
>  
>  struct amdgpu_mqd_prop;
> +struct amdgpu_cwsr_params;
>  
>  struct amdgpu_userq_obj {
>  	void		 *cpu_ptr;
> @@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
>  			u64 eop;
>  			u64 shadow;
>  			u64 csa;
> +			u64 cwsr;
>  		} va;
> -		u64 va_array[6];
> +		u64 va_array[7];
>  	} userq_vas;
>  
>  	uint32_t	gang_ctx_array_index;
> @@ -200,4 +202,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
> +int amdgpu_userq_input_cwsr_params_validate(
> +	struct amdgpu_usermode_queue *queue,
> +	struct amdgpu_cwsr_params *cwsr_params);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 420ce997bebc..b5326c2067db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3327,6 +3327,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>  	/* set CU mask */
>  	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
>  
> +	/* If non-zero, assume cwsr is enabled */
> +	if (prop->ctx_save_area_addr) {
> +		mqd->cp_hqd_persistent_state |=
> +			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
> +		mqd->cp_hqd_ctx_save_base_addr_lo =
> +			lower_32_bits(prop->ctx_save_area_addr);
> +		mqd->cp_hqd_ctx_save_base_addr_hi =
> +			upper_32_bits(prop->ctx_save_area_addr);
> +		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
> +		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
> +		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
> +		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1b76c10d1ac2..3b7a1479fbf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -27,6 +27,7 @@
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_cwsr.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -115,6 +116,7 @@ static int convert_to_mes_priority(int priority)
>  static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>  	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
> @@ -146,24 +148,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>  	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
>  
> +	if (fpriv->cwsr_trap) {
> +		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
> +		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
> +		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
> +	}
> +
>  	if (mes->use_rs64mem) {
>  		if (!uq_mgr->proc_ctx_allocated) {
> -			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
> +			r = amdgpu_mes_alloc_proc_ctx_index(mes,
> +							    &uq_mgr->proc_ctx_array_index);
>  			if (r) {
> -				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
> +				DRM_ERROR("Failed to allocate userq process index err:%d\n",
> +					  r);
>  				return r;
>  			}
>  			uq_mgr->proc_ctx_allocated = true;
>  		}
>  
> -		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
> +		r = amdgpu_mes_alloc_gang_ctx_index(mes,
> +						    &queue->gang_ctx_array_index);
>  		if (r) {
>  			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
>  			return r;
>  		}
> -		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
> -		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
> +
> +		queue_input.process_context_array_index =
> +			uq_mgr->proc_ctx_array_index;
> +		queue_input.gang_context_array_index =
> +			queue->gang_ctx_array_index;
>  	}
> +
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>  	amdgpu_mes_unlock(&adev->mes);
> @@ -174,7 +189,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  
>  	amdgpu_mes_userq_queue_mapped(adev);
>  
> -	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
> +	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
> +			 userq_props->doorbell_index);
> +
>  	return 0;
>  }
>  
> @@ -398,6 +415,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> +		struct amdgpu_cwsr_params cwsr_params;
>  
>  		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
>  			DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -405,7 +423,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> -		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					  mqd_user->mqd_size);
>  		if (IS_ERR(compute_mqd)) {
>  			r = PTR_ERR(compute_mqd);
>  			goto free_mqd;
> @@ -416,6 +435,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(compute_mqd);
>  			goto free_mqd;
>  		}
> +
>  		r = amdgpu_userq_input_va_validate(adev, queue,
>  						   compute_mqd->eop_va, 2048,
>  						   &queue->userq_vas.va.eop);
> @@ -427,29 +447,63 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>  		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> +		userq_props->hqd_queue_priority =
> +			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>  		userq_props->hqd_active = false;
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +		if (amdgpu_cwsr_is_enabled(adev)) {
> +			struct amdgpu_fpriv *fpriv =
> +				uq_mgr_to_fpriv(queue->userq_mgr);
> +			int num_xcc;
> +
> +			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
> +							 fpriv->xcp_id);
> +			cwsr_params.ctx_save_area_address =
> +				userq_props->ctx_save_area_addr;
> +			cwsr_params.cwsr_sz =
> +				userq_props->ctx_save_area_size;
> +			userq_props->ctl_stack_size =
> +				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +
> +			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
> +
> +			r = amdgpu_userq_input_cwsr_params_validate(
> +				queue, &cwsr_params);
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
> +		}
> +
>  		kfree(compute_mqd);
>  	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
>  		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
>  		struct amdgpu_gfx_shadow_info shadow_info;
>  
>  		if (adev->gfx.funcs->get_gfx_shadow_info) {
> -			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
> +			adev->gfx.funcs->get_gfx_shadow_info(adev,
> +							     &shadow_info, true);
>  		} else {
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
> +		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
> +		    !mqd_user->mqd) {
>  			DRM_ERROR("Invalid GFX MQD\n");
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					  mqd_user->mqd_size);
>  		if (IS_ERR(mqd_gfx_v11)) {
>  			r = PTR_ERR(mqd_gfx_v11);
>  			goto free_mqd;
> @@ -465,7 +519,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
> +
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_gfx_v11->shadow_va,
>  						   shadow_info.shadow_size,
>  						   &queue->userq_vas.va.shadow);
>  		if (r) {
> @@ -474,7 +530,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_gfx_v11->csa_va,
>  						   shadow_info.csa_size,
>  						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
> @@ -487,13 +544,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>  		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
>  
> -		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
> +		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
> +		    !mqd_user->mqd) {
>  			DRM_ERROR("Invalid SDMA MQD\n");
>  			r = -EINVAL;
>  			goto free_mqd;
>  		}
>  
> -		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> +		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
> +					   mqd_user->mqd_size);
>  		if (IS_ERR(mqd_sdma_v11)) {
>  			r = PTR_ERR(mqd_sdma_v11);
>  			goto free_mqd;
> @@ -504,7 +563,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			kfree(mqd_sdma_v11);
>  			goto free_mqd;
>  		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
> +
> +		r = amdgpu_userq_input_va_validate(adev, queue,
> +						   mqd_sdma_v11->csa_va,
>  						   32,
>  						   &queue->userq_vas.va.csa);
>  		amdgpu_bo_unreserve(queue->vm->root.bo);
> @@ -519,7 +580,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	queue->userq_prop = userq_props;
>  
> -	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
> +	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
> +				     userq_props);
>  	if (r) {
>  		DRM_ERROR("Failed to initialize MQD for userqueue\n");
>  		goto free_mqd;
> @@ -528,7 +590,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	/* Create per-process MES process context BO */
>  	r = mes_userq_create_proc_ctx_space(uq_mgr);
>  	if (r) {
> -		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
> +			  r);
>  		goto free_mqd;
>  	}
>  
> @@ -540,7 +603,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	}
>  
>  	/* FW expects WPTR BOs to be mapped into GART */
> -	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
> +	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
> +					  userq_props->wptr_gpu_addr);
>  	if (r) {
>  		DRM_ERROR("Failed to create WPTR mapping\n");
>  		goto free_ctx;

