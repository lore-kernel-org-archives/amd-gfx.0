Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC91CD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 10:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE0F810E240;
	Tue,  9 Jun 2026 10:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+WMtx+/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB7810E240
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 10:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN/oCprjsaNKr+SrfvHDfBmKoLIlZnojMIUT+1MdJJSrkf7XgiUDgfBrLgirhA1IdCkR229oktP04AszzYyNHkC3h/ytTGoQENOL/hBrxRtenkJXXZgGCHuHDQoZ2PQ5gihc7VcTsQ8OOoLUKUfK13H4Moqsi0gb8MvJA5rGKp52Mt4Fu0avK4QAo84gwHXhBIB1eSavkLcbpdBaHMzu7ZXIgIEVH4TS6ZQ/cVjRzDq6KbC12m/2Z4NHfXVT2WChuC3OrFfHeVYOVAufXcOlXSMnyq6FtvXrjehtTgRW9c4e8YNlIE03lAz5sWmGuxcG68vH4MK7UeR68SoWy3EWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP8u89aXVXS0niz7ecyCO4Wlwdyzfbqcow8icnRa3bk=;
 b=LN0svsWMy9+kxy3Wej5OV+ZHTCZQVJchuCRiPtxJxiv2Ge8hk4ogZQcM21wAfGiK5eJz6KGn7YGma7hbpHBgqMIssbGXr2x1xyRJAsiUGBpby3cHgfbC9ZkBngfkGng4Gt0w67iJD+BjmsBvf352Az1405Ux5m+sHyAVrE2i7EOnpWy48FpK5GQUzWprsJTdC3LfP/dUst9CHCjmdqRLQPCkNMQWWWqPjOATGpM2CYrQaajaz83TSExmy9/vsi2r5AhGmhwSa9ayCY/M1fJo2zfyAbM6lqRf2QliXywTjp++1+B6XQh+8jAph6tLrLdxStleAcUFNR+oirJIY4XGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP8u89aXVXS0niz7ecyCO4Wlwdyzfbqcow8icnRa3bk=;
 b=e+WMtx+/9CTkN3wSKY04q7SVrzG2IJ4TOsPrUAK2nXLXKJEpHzZ8igLOaExK6eo8ikpo06JCBKHM1Xm9oJ5edjh3Q7kCze9k4IG/yWR/AqUJtwk+cFFm4tIi7zx00boP6l+ch0BPEO88a9fKQisFXeFqk9JUPlgf5L1iUq/WX6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 10:44:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 10:44:31 +0000
Message-ID: <7db78da9-90fe-40f2-b120-e78e2aff69a4@amd.com>
Date: Tue, 9 Jun 2026 12:44:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] drm/amdgpu: move struct amdgpu_uid and helpers
 into separate files
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander Deucher <alexander.deucher@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
 <20260608194741.1590055-4-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260608194741.1590055-4-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1643878a-2743-41e8-a5e6-08dec61416bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|3023799007|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dEz1n9P1s9FUcj5qrj7QbeU0K1B4uVnPcf9+xpyMrZnWmYlSJPXAHHfggbycfvdPCnFkEWExTc2rIGfmKPBGDEtclzwKtPpoKdD7NMyL5vgK93Mlg3kw9FQTzfx5SF0BD+WHAb7rrr1PlMDSuQMQhxSNTMYi6GSt/4SxQidJgU0puZ3b9oMAJF4ZCXchPW1Nrx5W0U10P1qbAeVpt1ClAFz3jvIHdp61Xk5y0uRY7yqP0hRJf950B0H0pfvb3tNCdwxlTczn+AxnIMkJXtY+mKG7P7rkZAHzrKXDwPUGCrfBmMGMR0BFaa0OEjezFnmTp5wGake6e5UDwRmLlFmuRa2/MzPEDZF+/c5Es9/sxrJ4Yr0BkI/45K6Qmbuk97XzLttA3SdzrTBgmuZRCcNCCTHM+N3kN1iAof58yfaOgIO+x/imuzoDZZGbwW54MTRPNuHbOF0zsseHZY4nW7v1DNImo//JNG+CwAHcSpP4mBFyG+tn65U7cNiNMBmpS3m1LcqJR3sMfmq1Ygjqj5NHtqQNW1utWfETw9wmyiXahnSsBpAzEHA+kWxKyYNdLKISFdvcx2AgeRe4s8/zOkagmlsKDD7Rud7LAyqOIHME1/dnqTquoH0aMERAmjW6XnKuC1eOrmpe+JZtGuxrQ1SElA6oIrz9cSoO5fzZojAG3yKfyJhIk08fbmsx27tRQNyc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(3023799007)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdoc2xHLzY4QXpNaVdmWWpaSGpuU1RHaU00SmxsSFlsdjFmV05MNHB1R1BT?=
 =?utf-8?B?cmtzTUd2UUhibFRMMVlwZDJTM1J2SmhCUkRWd1h4eVFySWZkQWlES1NvWDRS?=
 =?utf-8?B?MlJtKzgzUXpqMlRoZ3lEay9jMWFsOUVpbERJR1piNFdVYlVaRGtiMXhTRk1C?=
 =?utf-8?B?MU5yU092UGIzdDNiMEI1c3lkT0I2cUpVbmFMSTJTQStNM09uY3Z5c2xLS0wy?=
 =?utf-8?B?S2ZUOHkxTXE5TTQzR1FnVHVxZFQrWng1YWVkTmp6MWpXVWdLcHlIUFZvd0pY?=
 =?utf-8?B?a05EZ2RvSXZDZlFMRjJXak9mWnFxUXZRL1ZBeHpmM0RyUFYrdk5tMEg2YjVV?=
 =?utf-8?B?TU9qa04vUGZEd2tWRGp2VTMrQnV6Umxxa0dZMHQ5SDQ3bGxPd3k5UE05cTIv?=
 =?utf-8?B?dHd1cTFFNFJ0TXBFWEtkdlRSelhralVVYm84RjRxMGU2VXJrRHlMQ2J2V2Zq?=
 =?utf-8?B?UHp4TjhLaitEeGRnZldIMTJSUnphOHhPT21LK0tQKytIeW1pbkkxVDJwd0ln?=
 =?utf-8?B?VXp6UlJlZy9ZMlVXdWR0ZVAzeDYrbThKemtQYi9icDkyMDJ5T3JJcndrb3hY?=
 =?utf-8?B?SkkvTldzelBtZTRsTGloYW45cGc5UkNwTXcwYWxaVWU5OTN6eW9qMkNlbzcy?=
 =?utf-8?B?MS9pTlNUYy9MU1d6SFJnbm5US09tTi9pNSsxa3ZHejFpS211WVpFcWhtWnNy?=
 =?utf-8?B?SUpKNGNpSVBpckxrWUkzWm92SVhxMmR5YXp2UWRmV2ppNXM4cm15STc4dFdp?=
 =?utf-8?B?TFRXR1dUQ1Zpd1hpenBXd3Iyd1A1TGpuOGh6c2RCMTBLSkxIMi9yOGhZYlc3?=
 =?utf-8?B?ZVdDcjBkREF1YjBtbXp5T1MrSC8yMXNXdUZIRjdOTHFvUDVhUCt6TGVGc0ZG?=
 =?utf-8?B?MDFKVThQRXJMcEt5WWxTcDBUZHRIOGxOakZuUStwS1ptekRYQnZMOGdNQlBj?=
 =?utf-8?B?aGl0YTdxTmw3UmNieVVMYlJ4NEMxb1dvRTF6ZG9FbnRKaCs5dTRQSGgvd2kr?=
 =?utf-8?B?NXVnMlJScVNscjdOdmk3ZHViVUhWMlpDam9BMUVLaUpmc0xrdVBHUW80OEtR?=
 =?utf-8?B?YU5hS3ZqTi9udzFiRXgrUHhSQ01NV25lalhhY292azlkU3g1T09lY2xYWWdD?=
 =?utf-8?B?TE85b1lDVWo4TnFlSjZrc0ZoMUcxaTE5bGFxOU5PbXR0bk1OME9yV2hxOWVV?=
 =?utf-8?B?aGlITlpFTk1LQ1lnejN0L0x2VVV4NFBHa0MzTFNuQkZlS1JMRHBmTkovbjVE?=
 =?utf-8?B?NnpKN1ZaME1yb3dHVFpRdnZlR21YQVdtVUdSVklJek1PWWRYZFZocmNrQllX?=
 =?utf-8?B?U29NdXd3cHFJQ3hHYlFhVnBjQVJFcW9uMmswWXI2a2RsN05URWsvSlJ1c3hp?=
 =?utf-8?B?TmRSUlMwbnNpcEFpMWd4UE5TcnBTZDcwRzVKTnBmNm42Yy9rZEZiZXNaRUJR?=
 =?utf-8?B?VjBTQlhFV0IvM2VEUG5lck4zMmFhaklhZDBWd2kyLzdmZ1lwRlVOSWgwYzdt?=
 =?utf-8?B?d3VUeENLR0RXZGVxejNzVXNPOVZmWHNCbFZaMXpCVlpDVW9EdTdSSkVRamRE?=
 =?utf-8?B?TXYvRGEzMktDOGpkeEFIQUxScWZjR2dZOHphZXVORU9aTTVuU0I5M1BJSFdH?=
 =?utf-8?B?U1F5NWNUL3puWmZLRnl2cTVTQXdrZTdPeW1sVWd4eXp4U1E5dmRqbGcyY0JT?=
 =?utf-8?B?cnhBTHlTQ2lTYlprZnVQQytFalNQek9rS0oyTER4bkVkSHJqVmZmd2x6SU5X?=
 =?utf-8?B?dmtJeVJONWdaNlpHRU45OHYza213NHNzVzhvQTlRZDM2NjZxRlFSL2J4b0FT?=
 =?utf-8?B?VSsyVWpFSitzUWY0L3V5ZlEyVmRGM0NwSjlEYUdkVzYvVUNZaHVLVC8zTURa?=
 =?utf-8?B?T29HOGdrQmo1TW9NaERNaHQvT3cvTWhHQU1UWXhRMXVJL3J5ZEt3RktsN1dM?=
 =?utf-8?B?ZzFQcWhaUUQwZWZyek5tWEsycFdvTVpBRVZoeHNrdjZzN1BQS2ZkVXVMKzJx?=
 =?utf-8?B?MFkzeG5PcVZDWGQ3SmlSWisydWlBL2pIWGw1aG1Xcm1ySFJHeFNHamo0S2Zi?=
 =?utf-8?B?ajFVNVdTWGMrS09OY3Q4U1dHVHVCMkZGdlNhcTdMVzQzS3g0a1FldjZzdGxM?=
 =?utf-8?B?L3FRNEpDWGduRG5DWjRlQUhiZVJLUDI2M2tnZlR4M1BybUpzckluQlB2cElF?=
 =?utf-8?B?S2d3QlJhZWNVRWRpZjAvNTR2SjNSUmtqTmpMWjF3aExvVDZFR2dodERYVUt1?=
 =?utf-8?B?Y284RExpaEtNNTU3NjRIV2NrNitWa043SzhOdHJRNmtJRFNDb24zSFpaZktE?=
 =?utf-8?Q?HukWhWrrV8BofRcbBL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1643878a-2743-41e8-a5e6-08dec61416bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:44:31.7721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+XF+MCi3FXKHIDKYCiT+umeZnfWw8nLqeGyEtzPtZFFiVXKXx47R41l75+mhXPW
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
> Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file into a new amdgpu_uid.h file.
> 
> Move functions amdgpu_device_set_uid() and amdgpu_device_get_uid() out of
> amdgpu_device.c into new dedicated amdgpu_uid.c file.

I'm not so familiar with the technical background, could be that it would be better to just move the defines into amdgpu_device.h.

@Alex what's you take on that?

Regards,
Christian.

> 
> Update amdgpu/Makefile to build amdgpu_uid.o
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c    | 75 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h    | 50 +++++++++++++++
>  5 files changed, 127 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index e6deb24f73bb..415e73e0a1af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o
> +	amdgpu_wb.o amdgpu_uid.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9a714b4b59bc..0f8743254fe6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -114,6 +114,7 @@
>  #include "amdgpu_sa.h"
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
> +#include "amdgpu_uid.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -553,21 +554,6 @@ struct amdgpu_mmio_remap {
>  	struct amdgpu_bo *bo;
>  };
>  
> -enum amdgpu_uid_type {
> -	AMDGPU_UID_TYPE_XCD,
> -	AMDGPU_UID_TYPE_AID,
> -	AMDGPU_UID_TYPE_SOC,
> -	AMDGPU_UID_TYPE_MID,
> -	AMDGPU_UID_TYPE_MAX
> -};
> -
> -#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
> -
> -struct amdgpu_uid {
> -	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
> -	struct amdgpu_device *adev;
> -};
> -
>  #define MAX_UMA_OPTION_NAME	28
>  #define MAX_UMA_OPTION_ENTRIES	19
>  
> @@ -1530,10 +1516,4 @@ static inline int amdgpu_device_bus_status_check(struct amdgpu_device *adev)
>  
>         return 0;
>  }
> -
> -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> -			   enum amdgpu_uid_type type, uint8_t inst,
> -			   uint64_t uid);
> -uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> -			       enum amdgpu_uid_type type, uint8_t inst);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 15a6a9010fc8..602e7eb1cc5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6872,53 +6872,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
>  	size += sysfs_emit_at(buf, size, "\n");
>  	return size;
>  }
> -
> -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> -			   enum amdgpu_uid_type type, uint8_t inst,
> -			   uint64_t uid)
> -{
> -	if (!uid_info)
> -		return;
> -
> -	if (type >= AMDGPU_UID_TYPE_MAX) {
> -		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> -			     type);
> -		return;
> -	}
> -
> -	if (inst >= AMDGPU_UID_INST_MAX) {
> -		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
> -			     inst);
> -		return;
> -	}
> -
> -	if (uid_info->uid[type][inst] != 0) {
> -		dev_warn_once(
> -			uid_info->adev->dev,
> -			"Overwriting existing UID %llu for type %d instance %d\n",
> -			uid_info->uid[type][inst], type, inst);
> -	}
> -
> -	uid_info->uid[type][inst] = uid;
> -}
> -
> -u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> -			  enum amdgpu_uid_type type, uint8_t inst)
> -{
> -	if (!uid_info)
> -		return 0;
> -
> -	if (type >= AMDGPU_UID_TYPE_MAX) {
> -		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> -			     type);
> -		return 0;
> -	}
> -
> -	if (inst >= AMDGPU_UID_INST_MAX) {
> -		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
> -			     inst);
> -		return 0;
> -	}
> -
> -	return uid_info->uid[type][inst];
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
> new file mode 100644
> index 000000000000..9b81e8198a73
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
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
> + */
> +#include "amdgpu_uid.h"
> +#include <linux/dev_printk.h>
> +#include "amdgpu.h"
> +
> +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> +			   enum amdgpu_uid_type type, uint8_t inst,
> +			   uint64_t uid)
> +{
> +	if (!uid_info)
> +		return;
> +
> +	if (type >= AMDGPU_UID_TYPE_MAX) {
> +		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> +			     type);
> +		return;
> +	}
> +
> +	if (inst >= AMDGPU_UID_INST_MAX) {
> +		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
> +			     inst);
> +		return;
> +	}
> +
> +	if (uid_info->uid[type][inst] != 0) {
> +		dev_warn_once(
> +			uid_info->adev->dev,
> +			"Overwriting existing UID %llu for type %d instance %d\n",
> +			uid_info->uid[type][inst], type, inst);
> +	}
> +
> +	uid_info->uid[type][inst] = uid;
> +}
> +
> +u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> +			  enum amdgpu_uid_type type, uint8_t inst)
> +{
> +	if (!uid_info)
> +		return 0;
> +
> +	if (type >= AMDGPU_UID_TYPE_MAX) {
> +		dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> +			     type);
> +		return 0;
> +	}
> +
> +	if (inst >= AMDGPU_UID_INST_MAX) {
> +		dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\n",
> +			     inst);
> +		return 0;
> +	}
> +
> +	return uid_info->uid[type][inst];
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
> new file mode 100644
> index 000000000000..d92ddcce9f58
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
> @@ -0,0 +1,50 @@
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
> +#ifndef __AMDGPU_UID_H__
> +#define __AMDGPU_UID_H__
> +
> +#include <linux/types.h>
> +
> +#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID type */
> +
> +struct amdgpu_device;
> +
> +enum amdgpu_uid_type {
> +	AMDGPU_UID_TYPE_XCD,
> +	AMDGPU_UID_TYPE_AID,
> +	AMDGPU_UID_TYPE_SOC,
> +	AMDGPU_UID_TYPE_MID,
> +	AMDGPU_UID_TYPE_MAX
> +};
> +
> +struct amdgpu_uid {
> +	uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
> +	struct amdgpu_device *adev;
> +};
> +
> +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> +			   enum amdgpu_uid_type type, uint8_t inst,
> +			   uint64_t uid);
> +uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> +			       enum amdgpu_uid_type type, uint8_t inst);
> +#endif

