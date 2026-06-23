Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2B8CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7945D10E108;
	Tue, 23 Jun 2026 08:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8MCX0Po";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06E110E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 08:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLmnlltiJaY1SjR/ZHVNMd6NvcMX/sYrST8vxAhEcnTbcTemlnbVeMww+/Uh+ButU9wtZ0w3i0t0lk2XIHuJLZ+1+7Y6G4LCncjvq9k7xTnRIY0i5TLIA22vQmvoDdv4oyVTABY0OAlU1SLHNMJYXo3wbOlQf1AdcI6s5PIMcOKeVPnNQTdFNG1AyY+xQyFfmPhziz1nxSM+3S4cB9t6Y4cJhVoGZztdPFk13vmGZKo+wA44a+wZUzHurcW64jgtDemQ7HuT7LZBq+3HGbSIkoRvk+uUr9+JHwf26B/jY2dqGcA2ELTlHGaNTxVmPtdmCWSaH/CKoqLpY7hg1uoXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w38Bb/VTkotblnADZFC7JaLF5WeAVmBlWzKViqCO4dk=;
 b=eVI8pfFGmkl0AajZP5Yk60x/7g0+H19/LHqIz+v0iGmezS5FN5UcRBd92pzpCinri3qYLcC+b2gQQuXNp+9sa1sI2W60wrSCbdWDAnczs01f6UluSIOBvdXbX6LQct5ssM/5/j+63R+DPB6TlQXsIlMei+2dRiDJfKMNhiLv6qYgKdK+8D2z1xE1QuAgvfFVySxKiyN9UKRmWxV22xdHHiKhiqAm/VVLMXKZhij2gKw0qapd14gD2qtbvLaLMHq1W72j3O3vFlChs+PhuSaxxlDm0d7tZUkoOnjLg22gAXI+P2PaMHYna0zHjkFIGnhWau0Z6Kd1zSrcL1K6FBod3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w38Bb/VTkotblnADZFC7JaLF5WeAVmBlWzKViqCO4dk=;
 b=X8MCX0PoF8m6730/9h1UKNHsGoMDODEHuCPMdhzF+4etJhkMHzNzieY7o6PNVFvKLBU7Jy0289BvehYT10SBjX9SNuF6bWngmS/LvdHTDbb5cuiZtnaRnBs+VizphYO34nUKZqbNub1U6rv5Te1a/iXEaEha3RJKYC+buxGxPxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:55:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:55:35 +0000
Message-ID: <3bfbcf70-1af8-4795-a62f-8f0002e633f9@amd.com>
Date: Tue, 23 Jun 2026 10:55:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and helpers
 into separate files
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622195729.181216-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad89b5a-9c29-4b59-591d-08ded1053031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: UONA1ZMKTPe0031Bc4x1o/WnRqG3l2EH7zl/GtxHufqm1gDtQWeoMij0zzqQJMDpDbR/IqgZuhUzX9Rq8OsowwA6sHVjliOSlr2PLrCm9wmVTgPtCLV36N2D7hUk2cOQQuXudXbUn6yb9QI2vjonbN2x946vvVMWPLASrDopFgEWI13nFjN6I8JXdYX1Pvn9ANQ0ysx44nUtkyqQ29sNsIzqtknh22/TmXh3QQvQ7EHeZFApfVt1672sGiUt6m+Noma2p4t/hVsFCmjl0r75KgQ1So2oHIcFLMFw6DrQ6kI4yVhMolZl7YLXmhb87dTsdj5sYNJUFxCRQ53Lo5GVrNa1HhfHUysbYFIvJW5rFuQ8xtApd2wyOFH6yikFGhyAT3bEAv9v6kLKqp5nKYZBTk7q81SQexB5JO/yAJ2LCX5lnLQ55pbpq4jlUWs1xI1iPE2Ff/9EeGSmFjWTEVT9F2SEuApfp1pHxHA+a8O37DssQIsAqOgVcrfYYqL94RRBoMjbdqxGlcEYbkHVojIBjDHqf0UMTN2G6i4mDoQKrk1aapW8FF0l03/TlbvlxWK6QzbYYKsdpELqz+q5uGE8/z+zKA8ltupKL7J+CnzFGgWXrJFM7MBcVyWMUEFPkIUSLNoT+4SEoimJFRbiD6eMlHlY0bkvvPB0YEyHpVjDrTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTl2ZWdRRGt4bzBwdThaQjBLdWRkOFM3Q2xvV3A0d2E2QndxK2FFUnBKRHZj?=
 =?utf-8?B?OUppcTRXbk90ZGFHOUhVZnZ3TkZIakd0LzRsamowMGE0bGlTMzN6K3pXNUVB?=
 =?utf-8?B?RGR4L2lGUnFRVStQODIzM043WXdROVphL2gwMy9nM29SMUdFSzVRakJhaEor?=
 =?utf-8?B?c05CK3pQeEgrSHdlSEU0TFBUVUZCU21NeWdPZ01MeEU2TkVSL04wMzRzeWNk?=
 =?utf-8?B?Z0VoZWxLNWNNYUlWck9aQ0lyekdzbWhEbFp3R0J0UzdnakFWOUFCK1Q2SW82?=
 =?utf-8?B?NHpIMThMVi9wTk45a3ZuNDMzNGtLMEt4Nys4ckxTLzF4YUYydk11NXNsQmIw?=
 =?utf-8?B?Z0thSWlsVW1DQ0lsbHJvRzRQQXcvSzBwbWNNZ1BIcDNtTjZrakRBN3dCR2Fx?=
 =?utf-8?B?WGdXU0tUU2pHcVdkMXZSQmNvZ2RxYUlUNDNMTTY3cEUwdE1GMzNuWklwUGZY?=
 =?utf-8?B?VDk3MVpZY1B6WVBBd2RITit4TjlZdk9tcHlYbjFJcEdEVjFHZDJqMko0RXph?=
 =?utf-8?B?N2RwOGh5b1NrN3ZYTnFmdjg5eTVGb2EwbytlaCtqaVg2SDZ5dWZDVjl0OHhl?=
 =?utf-8?B?NThGQnFSNU1CVk9ORWdoZm9iZDBiajFTUWw1aktlZHc3ajZKZzNiSHFKSWg2?=
 =?utf-8?B?SjdqYVc5TWFJY2ZuR0pPWDZHeXlMd3IrYkE1WE9wa28xditvRUhPelFlQi9E?=
 =?utf-8?B?WXZzZDQxZWlMbnFpME9uZk1hMVUvNW5LL2hWNzhJcTlaMEs5V2J6ZnVYNVJr?=
 =?utf-8?B?bU1rR3FoVldRTFFpTjhuaVF0aUs4Ris1dmdUdWZSOWw2WVFOcHg2NnlVc0dZ?=
 =?utf-8?B?MHVKZjYxdmNNNjRWeTByYThVMStFN0hSMGp2SjJlUS9wQnFxV1pRMTVWNVpR?=
 =?utf-8?B?c2NMMlBEbWloTnZQQyszaGovbzNWbWRZUXZXbU5peCtVclFFQk1VZHd2Z2RM?=
 =?utf-8?B?azF1M09ZeElWRno5M25MZm4zeTZWUWh0VUZVSUdEazVMcXNGOUhJYklCSkZq?=
 =?utf-8?B?UDd1WURINDZNb29nd0h5eFZyenhJVnBWUFJWT0dDQmlCb1RqVEQzNzdoUVBC?=
 =?utf-8?B?VVBRdGg4MWlVVS84QVpyRUo2Z0ZBZ0RJekJ0OU52MGU3eGFtYUZzWDZpdTJ2?=
 =?utf-8?B?TU1vaGYxdzNUQjFNNGUvUk5hUHJtWkZrNXJBNG41bUtmOW9Xcm9Ec0RCVmZ0?=
 =?utf-8?B?ajlCNHNJVWlLRytEZGZkTE1HMFpBQWxSQXI5MG5JT0pQdTNaWEMxOTdRdE1R?=
 =?utf-8?B?NzErbjl5QnRUYzhlbmpVemorQStkeHljQzNQd0VFcjEwQ1p5OFFhVk9wREZy?=
 =?utf-8?B?SGxwTFJmK0Fwa1BFYTZrU3pyRUQzbkZJc2lmdDZDRUpjZGFuemZ1VktDUkI3?=
 =?utf-8?B?TkEzNElSODhOMHB2M2liZkZNc1QxeW15b09oNEp6ZmNQczZKMkJDUERmM3lS?=
 =?utf-8?B?TkM3QzFQSWVZWVl4dXFFTVJLNlhkd3ZIckZkWjJQQmF6WThrK0VQeFRaMnps?=
 =?utf-8?B?ZlRrM2VwM2VnTXpKa3lXL3BMemRsdE9GYS83UzRXZ0x3dkw4NE5BcHo4cCtt?=
 =?utf-8?B?OUU1Wkc5SzJPK2pwTnFzODVlTzhjQitVTFBUQkNmdDZ2Mk9OcjBLOFFIL2hv?=
 =?utf-8?B?TnZZN2VRSmdzYkkvN3VQanIvNFZRYjliZEZWcFpvVkZNTkMreGhrT3JIb1RG?=
 =?utf-8?B?REhvZGhmbTFhRitraDBFa0JhL3JFTUFIYm9IcGFFRFlpM0VubzhKSktQUEtm?=
 =?utf-8?B?amlwcERyVkRvT3dEQi9RZDliZS9HMWJxMFpXcVNVMmFVL1gvWnJFblpPUTJl?=
 =?utf-8?B?NnBZN2lVbU5zMGlRT0VlVEFjNzl6RDlHSVNJMjhKekZmdk5QS0RSd2V2Q25R?=
 =?utf-8?B?R1k2eFVOZm1NNkUwYk9KSlBjRDZzSUJsczZwUmcvRWVyU0M3aWoxak5lYTNU?=
 =?utf-8?B?bTlkcHE5S21zY3lKOUNQRU5VcnQ1RnRLdDZLWk1vYlZBR2xxSUZlYTdicndT?=
 =?utf-8?B?TnVvVkU0d0FBdUZrYUdtUkZDeFV6UlR5eDNKaHlTcjY3VklZeGt6RHUwYXZS?=
 =?utf-8?B?VGdMRi9kN1Fnb2s0NWw0VG1UdnJlOXMyM2RxRUJJZXdkYk53N1pTaldhaUlp?=
 =?utf-8?B?a0pUejFiSjRZSC95akU0dG9VS1BNVXdnb1ZMcHFMSU5XUWJVbml1SXNGbFFi?=
 =?utf-8?B?VUlpcjU3M1o2NTNZeWVnTFh4V3JiU0tzOU9QeFRsTkZ0bStTVWdEVW1jZEhO?=
 =?utf-8?B?VGJZOHo4L3JZTkp6b3J5ekpqSXRZSjFaQnB5UzN0U3BKL21YRlRwN09Pam04?=
 =?utf-8?Q?enJdVnCs1LF1Ctqig8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad89b5a-9c29-4b59-591d-08ded1053031
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:55:35.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6YBtnzf0Ew0l+xa5Xzn9GOOCyzJnAz7p9bITerBywak4jEXx3aNIE6xLpTot9KH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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

On 6/22/26 21:57, Shahyan Soltani wrote:
> Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file into a new amdgpu_uid.h file.
> 
> Move functions amdgpu_device_set_uid() and amdgpu_device_get_uid() out of
> amdgpu_device.c into new dedicated amdgpu_uid.c file.
> 
> Update amdgpu/Makefile to build amdgpu_uid.o
> 
> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
> separate headers.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> 
> ---
> This patch and patch 7 can be dropped if moving amdgpu_uid out of 
> amdgpu.h is not desirable.

I think we should really just move the defines in a new file called amdgpu_device.h.

The uid is something device specific and it is a bit overkill to have a separate C file for it.

Regards,
Christian.

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
> index 10dc7cfd607e..ab5fdbb5e4b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o
> +	amdgpu_wb.o amdgpu_uid.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4ffcc0cc6404..fe951a901d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -116,6 +116,7 @@
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_sa.h"
> +#include "amdgpu_uid.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -551,21 +552,6 @@ struct amdgpu_mmio_remap {
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
> index d6931e1184d0..8d55658ecb31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6717,53 +6717,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
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
> index 000000000000..6cf6b3f12271
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

