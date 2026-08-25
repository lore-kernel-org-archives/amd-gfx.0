Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD73C61DB6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 07:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7FB10E153;
	Tue, 25 Aug 2026 07:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4IiaAhx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D1A10E153
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 07:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt/kyoO6GZEj56fu4GIMWbPU9LvyN9+LowjuD3Q5pNBlpPufighyoZRK+KpIRw6O4+t5L14Tu3rn/xwfz37/8SrMefmZX3Z+Gy5/DTSYofTjxgMnJeBFQauH3UaB4Kgd58y+fNKmbMdPlpFVjjiJnc7sA5d4SSgLCcJdzhAcGUNki0cJY/PQ7qqRXeJAh42+h2+0eFnUCeV90HCbcKCL5DhM0PpQgj3JHK8P8xD3TbGIoCtdZQuifUmNxTIKWB9dTNeTW+xikmCFSJcLBuil3XC6q4X9J5zRPKVlQramCy2vmuoVKAW7xX/kUQx0d0c8uK15HGKMg8OzVe+rEM3bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CXWCNq1v2/GK4zi3jeC9pcPJ5bEQRBqicuOwq/HYI0=;
 b=lxn74EuKoQztJd5X/goW3lOiX9ufDjPaJmqdR2TP344i/rd94nLQPKpPvZJEZngT4Ov2zV0LHbWh2vT0njzEV5dfIVGjf9Uat8cwgd5zKtE4WK3Pdz23XM6bjooymDI9Yh45w9GvqtOOlZbwOYhCnRPxieEhCZnm7A8cGwLiMm15l9pBgKgn6k4kX+TsXBnChv5avlHNGhn8NvlF1Sx+lgbYuN3Gglo6LAXTSpNrqKTPSkkQVtSdibDvbmONS8vn7njJ7CUEY9w9CyASK8OktPwYtsqPKwHM2Kf2aOaIA2/92YlxOPxX8BIJPuYwSDSUv/WkFcSbaCCVp36EPSloXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CXWCNq1v2/GK4zi3jeC9pcPJ5bEQRBqicuOwq/HYI0=;
 b=M4IiaAhxb8g6AW7MsSTJwCvlzV9iNoxgArbLF9/ls7bWOEcRMSnH9E54SLbiBtHGbpPkjdpdqUiS06Uqn1EEi1G8SvM5wkF4Y8+xdPXU18OnVQhDTmZy/eiWoBd7kqwTuMqBztWC47yv9GbUKm8hp6CTW1gS6C60VdDBZdIjH1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:36:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 07:36:03 +0000
Message-ID: <8c0de079-ef57-47be-98aa-aa08b97a0268@amd.com>
Date: Tue, 25 Aug 2026 09:36:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Rename amdgpu_cwsr to amdgpu_trap
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260820073209.3939864-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260820073209.3939864-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: bab7bc21-5c33-457a-4fd3-08df027b8420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SrN90OgD2rX+mI5c2TZEC84TbSsT73dhRKt9771o621z9Xa/7rT6uaBpdHZWA0tBk3vOfkcqPSGCfpUWKUXpHh+eFnjqQedf9zZ5htskWpT3n1mssW6CiHHkELYJDKppEFOoM4dBfBr3b68nhtX6hTc9iCLWKEg7MK1EobWITdZIv+gkkjOsrcIfx/MFRS7IlBHmFSTiryiqfde5ufTTFgiDVJewA6NgOqZAEnmQRJniDKgwhUV79GJaQS5cBBgFuzYY3LirvHKzoXxgPowcKumCBZbuDDHSyvBt81EFawB0g1VzH1JhEfXVOi4y3qgxChNfu+yRvkWnrj3BZxy/mvy0IiDKeXmS/29g2QHktA36dWeMax6iVf8I0gWXLi9jbRMSiK6tkBZvEl60NsIEbb0qkfTy7mkf9VgdhjRtXlMBAOP0RFV4vN0RQNrHZH77rKoGOWzLnLnMcRIPN1hZujmNHJEO8A60JhHUGlyW9OB1Enj1S/D8MxeS8XbPddEu4KvwzAwLiB9EtzyyvkFihaqCu7cpspDGbKXaV3SI4eig+m3fm0c7tezpBaaboPTT1cRFFMNZohKhtR8Fm38vU76KtmgZBR/4H4gn6UwR7LHN+cGPposvMM15nHRsCjdxGPkN5UoOxq2cMA7lgt2AFeIODCyrPfF74hjeUAvdB48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNqbjFZYVdpQ2dZcnJTNStrM3o3djZlY3hpeDArYmdHdVZNd25XdUVJNnVH?=
 =?utf-8?B?cEMxdWhlbEpxWTBHS2liaFpwMEg2OWV0elJBNWNRUHFJT0lGT2J1WHl3djFH?=
 =?utf-8?B?UmNCYWxWT3FJRTY5YllHa2tmdTJWTVdaQXpJWlg1NUtGcDlHanBuUWRUb1dX?=
 =?utf-8?B?WmJIS0N4ZkZRWjhBclJ5SysrYjBMV2FpeHdWTHhYYmhsdXdraUsxMjRMQ3lY?=
 =?utf-8?B?YXRORDRzak05Ui84VjFzSmxSY1RsTndsYVNpdTFxSlpicE52OVBiUm1LOXl1?=
 =?utf-8?B?MWFnSlcrL2tEOThsc3BpOTBlMWcvN1BuamFiWTBSYVQ3UGF6UjU5L3M0Q0JB?=
 =?utf-8?B?RUc4TlpIa1BHSnBMMTlKUnpiWXZna1JDczgyQ2dTTUh0R0J1bGlCa29UcEkr?=
 =?utf-8?B?NTMwb1dNY1VxZlhRWitKcGdBN2tyK3V4c2NGRHhRTWRuR3JxMUJNTzkzNmlI?=
 =?utf-8?B?MFJSZ1dTV1A0b24yS09oT292bGFaT3B3a3YxL2h6eXlXcDB2UTNqMnlwMW5u?=
 =?utf-8?B?L1BPY0ljOXkwdFJRV1haY3kwT29FYXFJSktJYlVhWjhhaEVyMXBTaWdZUHZx?=
 =?utf-8?B?ZGJNV3FocU1LMi9ydXZsdEpESGRUWldRZG40TWRsQzlreVoyQWVUNWk5bElv?=
 =?utf-8?B?YVpKYWU1Szg0dGpNUHVJemxXNThuU0Jja2hvNE9tbjZ3dHVITjFlWXlwWjRr?=
 =?utf-8?B?Y0FWWU9DbmMxQ3g4ZGNlcHZCVFErdHlsaVBveXZCakM3STkyOEwxODEvcWY4?=
 =?utf-8?B?dmxNZVB6WXpSVFArWlpGK0ppcVNVNDVCbVp3bW5UZmVuU3d4ZGRJbkQzRUI1?=
 =?utf-8?B?eE1vSjU5MEo2T1hBcXpvVSsvSG5vYWhJSXNyNnk1V25veHFKTTcxaThHV0xJ?=
 =?utf-8?B?SVpXNjFzQkI1Ni9vdzBCd2gxSUJCOHovY28ycXdvd1JHZnZVQXdwTjdxR0h5?=
 =?utf-8?B?cFFYakkxVVhDVEdLKzZ0ZHh5WTZHb2NjaytwNyszbFNDc1cvYXRSeDd6NkNm?=
 =?utf-8?B?RmZjTDhFNjUrUVZJSGt1YW5wZEFYYS8xcEhFM3dsc0g4TWdXSThXYlliMVZn?=
 =?utf-8?B?cGtwQXBVSC9yK2NDNG9LMTVJdnppcm9CNDBhZ3hSTEtFWEdyQzU2ZjNnV1o1?=
 =?utf-8?B?OWc1eWtYa2o1YWVpcU1BYktsNUs5WE9GU1pkcWpyK2RVcUFkc21BVlFybjJm?=
 =?utf-8?B?WGg4UlhhNGI4SjVnS0V1R2kxL214NjdETU9oY1QyNGM4Qm90aFRwdEN2ZHRJ?=
 =?utf-8?B?RWV5eDVQNXRHNE5TajdWMXBRQVJBeUdYcGtzUXBBa3FaYlQrendLSzhUdzZv?=
 =?utf-8?B?VEo2SFpRZjErUmN4RnBUcm1LbWdHaWFzQ3VKTUcxbzZyWWVOUGJwell0Um9h?=
 =?utf-8?B?Q3R5S2U3Q0dxblo1WHlaK1NjWklybUExRGxXRW8yUG5XbEVQeHdMVWs5K09q?=
 =?utf-8?B?SEF3aitvYUhUaURLb2FXWmpjN3BKTUZZY0hZOG9MTzJoYnh2a2dLSGNVUjMz?=
 =?utf-8?B?cVhSNVU1a0JqZ3FsL09xNEk4bG1aeFp5YUFIajM1Z2J2Q3Jpc1JxMGdCekRp?=
 =?utf-8?B?b0ptVlRxQVgwMjE2NmM2cmJHV21YcDd1bVV5M2pFank3TmsrbHJJYmRPcXJV?=
 =?utf-8?B?djUwMEZ1b0ZEYllkSkhQOGJ6dXBDMGxRZmlvbk1ibFlsSDgwbnNzZ0RzclE4?=
 =?utf-8?B?RE9sMlVzN3NNL0VROE1oQXVVMkRxZDBjb2pKaGZKeTJLMUNEeUpuQk01bVVn?=
 =?utf-8?B?R2lDYVpDVkxqWVp2MCtOTEpTY0V2T3I0Z0l6WWQvZnU0Qm5zU3JlcWplWUND?=
 =?utf-8?B?YUdnUGVsZW9wcU1GUjg3T2RvNnhVUDR6MVRoZENZZk1SYnlHTGJEaHYySFhq?=
 =?utf-8?B?Z2RGSVJMakhndzNvZHFTWnVEUHlmeVUvTUMwSFZjbllQenc4UitkM1BaNWIz?=
 =?utf-8?B?aFFEYjNmRi9Pb3RFWVV5L2hjNlY3bmlTbE1wYkZLMnhydVd5TUdkRGk1VHRU?=
 =?utf-8?B?Uk92NkJINk81MmJ0djN4NHBmTTBPU0JvZkNmejk3MS8xUnhuTjJqY3NkL3VR?=
 =?utf-8?B?TmJ2VUpHRVhobjJNQWZZSHNhWVJPb216bitxaWZ2c3FlM1JmZE84a2VnWm9o?=
 =?utf-8?B?UmhxZjlKN011RVdPNjF5aWxhN0Y4VVJQTitXa0JhMzFMMFQ0RzFHSXVMMTlZ?=
 =?utf-8?B?Rm5zQUJUc1ZuK0R3V2dxcnZVTitXS0tvMEpOTk11U2VGZ2lwUXBGWHAyeW41?=
 =?utf-8?B?WUtlS3BqekQyN2I0cUlmR0VQTXhucjhqVmlVWXM1d2I0L21PR1FzNDdqOEpO?=
 =?utf-8?Q?cJPGkcSgaImK680vzI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab7bc21-5c33-457a-4fd3-08df027b8420
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:36:03.3850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRVktZbHXGmxU4mNMFUspaIqcFCfplO8opTMZ7kGgn8rE7sLmhtJpDbPTPYVbZA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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

On 8/20/26 09:32, Srinivasan Shanmugam wrote:
> CWSR (Compute Wave Save Restore) is only the context save/restore
> feature. The level 1 trap handler manages CWSR as well as the
> second-level userspace trap handler added for render-node user queues.
> Keeping the file and ioctl named after CWSR is misleading now that the
> code manages both levels of trap handling.
> 
> Rename files and ioctl to reflect the broader trap handler scope so
> future trap handler features have a natural home without further naming
> confusion.
> 
>   amdgpu_cwsr.c         → amdgpu_trap.c
>   amdgpu_cwsr.h         → amdgpu_trap.h
>   AMDGPU_CWSR ioctl     → AMDGPU_TRAP ioctl
>   amdgpu_cwsr_* symbols → amdgpu_trap_* symbols
> 
> The cwsr_enable module parameter and cwsr_trap_handler.h ISA binaries
> are not renamed — they are specific to the CWSR context save feature.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  28 +-
>  .../amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c}   | 257 +++++++++---------
>  .../amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h}   |  44 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  16 +-
>  include/uapi/drm/amdgpu_drm.h                 |  14 +-
>  11 files changed, 195 insertions(+), 196 deletions(-)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.c => amdgpu_trap.c} (64%)
>  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_cwsr.h => amdgpu_trap.h} (66%)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6fb0a913e33b..ec199715ee76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o
> +	amdgpu_wb.o amdgpu_trap.o amdgpu_events.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8eff6b9ebe81..e3763c197138 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -327,8 +327,8 @@ struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_coredump_info;
>  struct amdgpu_video_codecs;
> -struct amdgpu_cwsr_isa;
> -struct amdgpu_cwsr_trap_obj;
> +struct amdgpu_trap_isa;
> +struct amdgpu_trap_obj;
>  
>  enum amdgpu_cp_irq {
>  	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
> @@ -417,7 +417,7 @@ struct amdgpu_fpriv {
>  	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
> -	struct amdgpu_cwsr_trap_obj *cwsr_trap;
> +	struct amdgpu_trap_obj *trap_obj;
>  
>  	/* Eviction fence infra */
>  	struct amdgpu_eviction_fence_mgr evf_mgr;
> @@ -965,7 +965,7 @@ struct amdgpu_device {
>  	 */
>  	struct amdgpu_kfd_dev		kfd;
>  
> -	struct amdgpu_cwsr_info *cwsr_info;
> +	struct amdgpu_trap_info *trap_info;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..380989f4c965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,7 +81,7 @@
>  #include "amdgpu_events.h"
>  #include "amdgpu_virt.h"
>  #include "amdgpu_dev_coredump.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> @@ -2395,7 +2395,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	r = amdgpu_cper_init(adev);
>  
>  	if (!r) {
> -		r = amdgpu_cwsr_init(adev);
> +		r = amdgpu_trap_init(adev);
>  		if (r == -EOPNOTSUPP)
>  			r = 0;
>  	}
> @@ -2797,7 +2797,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> -	amdgpu_cwsr_fini(adev);
> +	amdgpu_trap_fini(adev);
>  	amdgpu_cper_fini(adev);
>  
>  	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7c473f60bd28..a93ee106ab92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,7 +52,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userq.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_userq_fence.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>  
> @@ -3079,7 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -	DRM_IOCTL_DEF_DRV(AMDGPU_CWSR, amdgpu_cwsr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
>  	/* KMS */
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f8a30e52e2a0..610a1ffc5fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -48,7 +48,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_vm.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1495,21 +1495,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		}
>  	}
>  	case AMDGPU_INFO_CWSR: {
> -		struct drm_amdgpu_info_cwsr cwsr_info;
> +		struct drm_amdgpu_info_cwsr trap_info;
>  		int num_xcc, r;
>  
>  		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
> -		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
> +		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
>  			return -EOPNOTSUPP;
>  		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -		cwsr_info.ctl_stack_size =
> -			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> -		cwsr_info.dbg_mem_size =
> -			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
> -		cwsr_info.min_save_area_size =
> -			amdgpu_cwsr_size_needed(adev, num_xcc);
> -		r = copy_to_user(out, &cwsr_info,
> -				 min((size_t)size, sizeof(cwsr_info))) ?
> +		trap_info.ctl_stack_size =
> +			adev->trap_info->xcc_ctl_stack_sz * num_xcc;
> +		trap_info.dbg_mem_size =
> +			adev->trap_info->xcc_dbg_mem_sz * num_xcc;
> +		trap_info.min_save_area_size =
> +			amdgpu_trap_size_needed(adev, num_xcc);
> +		r = copy_to_user(out, &trap_info,
> +				 min((size_t)size, sizeof(trap_info))) ?
>  			    -EFAULT :
>  			    0;
>  		return r;
> @@ -1641,8 +1641,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>  
> -	if (amdgpu_cwsr_is_enabled(adev)) {
> -		r = amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	if (amdgpu_trap_is_enabled(adev)) {
> +		r = amdgpu_trap_alloc(adev, &fpriv->vm, &fpriv->trap_obj);
>  		if (r)
>  			dev_dbg(adev->dev, "cwsr trap not enabled");
>  	}
> @@ -1716,7 +1716,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	}
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> -	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
> +	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
>  
>  	if (pasid)
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> similarity index 64%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> index 7e5a08b0a1c8..c58b84b39d73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
> @@ -23,13 +23,13 @@
>  
>  #include "amdgpu.h"
>  #include "cwsr_trap_handler.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  extern int cwsr_enable;
>  
> -#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> -#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +#define AMDGPU_TRAP_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
> +#define AMDGPU_TRAP_TMA_OFFSET (AMDGPU_TRAP_TBA_MAX_SIZE)
>  
>  #define SGPR_SIZE_PER_CU 0x4000
>  #define LDS_SIZE_PER_CU 0x10000
> @@ -38,12 +38,12 @@ extern int cwsr_enable;
>  #define DEBUGGER_BYTES_PER_WAVE 32
>  #define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
>  
> -enum amdgpu_cwsr_region {
> -	AMDGPU_CWSR_TBA,
> -	AMDGPU_CWSR_TMA,
> +enum amdgpu_trap_region {
> +	AMDGPU_TRAP_TBA,
> +	AMDGPU_TRAP_TMA,
>  };
>  
> -static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
> +static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
>  {
>  	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
>  
> @@ -52,7 +52,7 @@ static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
>  	return addr;
>  }
>  
> -static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  
> @@ -63,80 +63,80 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc)
>  {
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return 0;
>  
>  	return num_xcc *
> -	       (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
> +	       (adev->trap_info->xcc_cwsr_sz + adev->trap_info->xcc_dbg_mem_sz);
>  }
>  
> -static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> -					 struct amdgpu_cwsr_info *cwsr_info)
> +static void amdgpu_trap_init_isa_details(struct amdgpu_device *adev,
> +					 struct amdgpu_trap_info *trap_info)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  
>  	if (gc_ver < IP_VERSION(9, 0, 1)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx8_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
>  	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_arcturus_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
>  	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_aldebaran_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
>  	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
>  		   gc_ver == IP_VERSION(9, 4, 4)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
>  	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
> +		trap_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
>  	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx9_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
>  	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_nv1x_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
>  	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx10_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
>  	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
>  		/* The gfx11 cwsr trap handler must fit inside a single
>  			   page. */
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
> +		trap_info->isa_buf = cwsr_trap_gfx11_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
>  	} else if (gc_ver < IP_VERSION(12, 1, 0)) {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
>  	} else {
>  		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_1_0_hex) >
> -			     AMDGPU_CWSR_TBA_MAX_SIZE);
> -		cwsr_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> -		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
> +			     AMDGPU_TRAP_TBA_MAX_SIZE);
> +		trap_info->isa_buf = cwsr_trap_gfx12_1_0_hex;
> +		trap_info->isa_sz = sizeof(cwsr_trap_gfx12_1_0_hex);
>  	}
>  }
>  
> -static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_get_vgpr_size_per_cu(struct amdgpu_device *adev)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  	uint32_t vgpr_size;
> @@ -164,7 +164,7 @@ static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
>  	return vgpr_size;
>  }
>  
> -static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
>  {
>  	uint32_t lds_sz_per_cu;
>  
> @@ -173,11 +173,11 @@ static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
>  			(adev->gfx.cu_info.lds_size << 10) :
>  			LDS_SIZE_PER_CU;
>  
> -	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
> +	return amdgpu_trap_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
>  	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
>  }
>  
> -static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
> +static uint32_t amdgpu_trap_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
>  {
>  	uint32_t sz;
>  
> @@ -188,8 +188,8 @@ static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
>  	return sz;
>  }
>  
> -static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> -					    struct amdgpu_cwsr_info *cwsr_info)
> +static void amdgpu_trap_init_save_area_info(struct amdgpu_device *adev,
> +					    struct amdgpu_trap_info *trap_info)
>  {
>  	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
> @@ -209,10 +209,10 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
>  			       array_count / gfx_info->max_sh_per_se * 512) :
>  			   cu_num * 32;
>  
> -	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
> +	wg_data_size = ALIGN(cu_num * amdgpu_trap_get_wg_ctxt_size_per_cu(adev),
>  			     PAGE_SIZE);
>  	ctl_stack_size =
> -		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
> +		wave_num * amdgpu_trap_ctl_stack_bytes_per_wave(adev) + 8;
>  	ctl_stack_size =
>  		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
>  		      PAGE_SIZE);
> @@ -226,62 +226,62 @@ static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
>  	if (IP_VERSION_MAJ(gc_ver) == 10)
>  		ctl_stack_size = min(ctl_stack_size, 0x7000);
>  
> -	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
> -	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> -	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
> +	trap_info->xcc_ctl_stack_sz = ctl_stack_size;
> +	trap_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
> +	trap_info->xcc_dbg_mem_sz = dbg_mem_size;
>  }
>  
> -int amdgpu_cwsr_init(struct amdgpu_device *adev)
> +int amdgpu_trap_init(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
> -		kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +	struct amdgpu_trap_info *trap_info __free(kfree) =
> +		kzalloc(sizeof(*trap_info), GFP_KERNEL);
>  	void *ptr;
>  	int r;
>  
> -	if (!amdgpu_cwsr_is_supported(adev))
> +	if (!amdgpu_trap_is_supported(adev))
>  		return -EOPNOTSUPP;
>  
> -	if (!cwsr_info)
> +	if (!trap_info)
>  		return -ENOMEM;
> -	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +	amdgpu_trap_init_isa_details(adev, trap_info);
>  
> -	if (!cwsr_info->isa_sz)
> +	if (!trap_info->isa_sz)
>  		return -EOPNOTSUPP;
>  
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
> -				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TBA_MAX_SIZE, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT, &trap_info->isa_bo,
>  				    NULL, &ptr);
>  	if (r)
>  		return r;
>  
> -	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +	memcpy(ptr, trap_info->isa_buf, trap_info->isa_sz);
>  
> -	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
> -	adev->cwsr_info = no_free_ptr(cwsr_info);
> +	amdgpu_trap_init_save_area_info(adev, trap_info);
> +	adev->trap_info = no_free_ptr(trap_info);
>  
>  	return 0;
>  }
>  
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev)
> +void amdgpu_trap_fini(struct amdgpu_device *adev)
>  {
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return;
>  
> -	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> -	kfree(adev->cwsr_info);
> -	adev->cwsr_info = NULL;
> +	amdgpu_bo_free_kernel(&adev->trap_info->isa_bo, NULL, NULL);
> +	kfree(adev->trap_info);
> +	adev->trap_info = NULL;
>  }
>  
>  /*
>   * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> - * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
> + * it maps virtual address amdgpu_trap_trap_handler_vaddr() to this VM, and each
>   * compute queue can use this virtual address for wave save/restore
>   * operations to support compute preemption.
>   */
> -static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +static int amdgpu_trap_map_region(struct amdgpu_device *adev,
>  				  struct amdgpu_vm *vm,
> -				  struct amdgpu_cwsr_trap_obj *cwsr,
> -				  enum amdgpu_cwsr_region region)
> +				  struct amdgpu_trap_obj *cwsr,
> +				  enum amdgpu_trap_region region)
>  {
>  	uint64_t cwsr_addr, va_flags, va;
>  	struct amdgpu_bo_va **bo_va;
> @@ -292,20 +292,20 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>  	if (!cwsr || !vm)
>  		return -EINVAL;
>  
> -	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
> +	cwsr_addr = amdgpu_trap_tba_vaddr(adev);
>  
> -	if (region == AMDGPU_CWSR_TBA) {
> -		size = AMDGPU_CWSR_TBA_MAX_SIZE;
> +	if (region == AMDGPU_TRAP_TBA) {
> +		size = AMDGPU_TRAP_TBA_MAX_SIZE;
>  		bo_va = &cwsr->tba_va;
> -		bo = adev->cwsr_info->isa_bo;
> +		bo = adev->trap_info->isa_bo;
>  		va = cwsr_addr;
>  		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
>  			    AMDGPU_VM_PAGE_EXECUTABLE);
>  	} else {
> -		size = AMDGPU_CWSR_TMA_MAX_SIZE;
> +		size = AMDGPU_TRAP_TMA_MAX_SIZE;
>  		bo_va = &cwsr->tma_va;
>  		bo = cwsr->tma_bo;
> -		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +		va = cwsr_addr + AMDGPU_TRAP_TMA_OFFSET;
>  		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
>  	}
>  
> @@ -317,7 +317,7 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>  	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
>  	if (r) {
>  		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>  		amdgpu_vm_bo_del(adev, *bo_va);
>  		*bo_va = NULL;
>  		return r;
> @@ -327,13 +327,13 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>  	if (r) {
>  		dev_err(adev->dev,
>  			"failed to do page table update of %s region, err=%d\n",
> -			(region == AMDGPU_CWSR_TBA ? "tba" : "tma"), r);
> +			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
>  		amdgpu_vm_bo_del(adev, *bo_va);
>  		*bo_va = NULL;
>  		return r;
>  	}
>  
> -	if (region == AMDGPU_CWSR_TBA)
> +	if (region == AMDGPU_TRAP_TBA)
>  		cwsr->tba_gpu_va_addr = va;
>  	else
>  		cwsr->tma_gpu_va_addr = va;
> @@ -341,9 +341,9 @@ static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr,
> -				    enum amdgpu_cwsr_region region)
> +static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr,
> +				    enum amdgpu_trap_region region)
>  {
>  	struct amdgpu_bo_va **bo_va;
>  	uint64_t va;
> @@ -352,7 +352,7 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
>  	if (!cwsr)
>  		return -EINVAL;
>  
> -	if (region == AMDGPU_CWSR_TBA) {
> +	if (region == AMDGPU_TRAP_TBA) {
>  		bo_va = &cwsr->tba_va;
>  		va = cwsr->tba_gpu_va_addr;
>  	} else {
> @@ -374,15 +374,15 @@ static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
>  {
> -	struct amdgpu_cwsr_trap_obj *cwsr;
> +	struct amdgpu_trap_obj *cwsr;
>  	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
>  	int r;
>  
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  	if (!vm || !trap_obj)
>  		return -EINVAL;
> @@ -390,7 +390,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!cwsr)
>  		return -ENOMEM;
>  
> -	bo = adev->cwsr_info->isa_bo;
> +	bo = adev->trap_info->isa_bo;
>  	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> @@ -405,18 +405,18 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		}
>  	}
>  
> -	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAGE_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_TRAP_TMA_MAX_SIZE, PAGE_SIZE,
>  				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
>  				    &cwsr->tma_cpu_addr);
>  	if (r)
>  		goto err;
>  
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TMA);
>  	if (r)
>  		goto err;
> -	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
>  	if (r) {
> -		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
>  		goto err;
>  	}
>  
> @@ -433,19 +433,19 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return r;
>  }
>  
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *cwsr_params,
>  				int num_xcc)
>  {
>  	uint32_t min_size, max_size;
>  
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  
>  	if (!cwsr_params)
>  		return -EINVAL;
>  
> -	min_size = amdgpu_cwsr_size_needed(adev, num_xcc);
> +	min_size = amdgpu_trap_size_needed(adev, num_xcc);
>  	max_size = 2 * min_size;
>  	/*
>  	 * Only save area size details checked. Address validation needs to be
> @@ -463,8 +463,8 @@ int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **trap_obj)
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **trap_obj)
>  {
>  	struct amdgpu_bo *tba_bo;
>  	struct amdgpu_bo *tma_bo;
> @@ -473,7 +473,7 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
>  		return;
> -	tba_bo = adev->cwsr_info->isa_bo;
> +	tba_bo = adev->trap_info->isa_bo;
>  	tma_bo = (*trap_obj)->tma_bo;
>  
>  	if (!tba_bo || !tma_bo)
> @@ -496,8 +496,8 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		}
>  	}
>  
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> -	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TBA);
> +	amdgpu_trap_unmap_region(adev, *trap_obj, AMDGPU_TRAP_TMA);
>  err:
>  	drm_exec_fini(&exec);
>  	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> @@ -505,9 +505,9 @@ void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	*trap_obj = NULL;
>  }
>  
> -static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
> +static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
>  					  struct amdgpu_vm *vm,
> -					  struct amdgpu_cwsr_usr_addr *usr_addr)
> +					  struct amdgpu_trap_usr_addr *usr_addr)
>  {
>  	struct amdgpu_bo_va_mapping *va_map;
>  	uint64_t addr;
> @@ -539,23 +539,23 @@ static int amdgpu_cwsr_validate_user_addr(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -static int amdgpu_cwsr_set_l2_trap_handler(
> -	struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -	struct amdgpu_cwsr_trap_obj *cwsr_obj, struct amdgpu_cwsr_usr_addr *tma,
> -	struct amdgpu_cwsr_usr_addr *tba)
> +static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +					   struct amdgpu_trap_obj *cwsr_obj,
> +					   struct amdgpu_trap_usr_addr *tma,
> +	struct amdgpu_trap_usr_addr *tba)
>  {
>  	uint64_t *l1tma;
>  	int r;
>  
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  
>  	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
>  		return -EINVAL;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tma);
> +	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
>  	if (r)
>  		return r;
> -	r = amdgpu_cwsr_validate_user_addr(adev, vm, tba);
> +	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
>  	if (r)
>  		return r;
>  
> @@ -570,7 +570,7 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>   * Userspace cwsr related ioctl
>   */
>  /**
> - * amdgpu_cwsr_ioctl - Handle cwsr specific requests.
> + * amdgpu_trap_ioctl - Handle trap handler specific requests.
>   *
>   * @dev: drm device pointer
>   * @data: request object
> @@ -579,29 +579,28 @@ static int amdgpu_cwsr_set_l2_trap_handler(
>   * This function is used to perform cwsr and trap handler related operations
>   * Returns 0 on success, error code on failure.
>   */
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  {
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> -	union drm_amdgpu_cwsr *cwsr = data;
> +	union drm_amdgpu_trap *cwsr = data;
>  	struct amdgpu_fpriv *fpriv;
>  	int r;
>  
>  	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
>  
> -	if (!fpriv->cwsr_trap)
> +	if (!fpriv->trap_obj)
>  		return -EOPNOTSUPP;
>  
>  	switch (cwsr->in.op) {
> -	case AMDGPU_CWSR_OP_SET_L2_TRAP: {
> -		struct amdgpu_cwsr_usr_addr tba;
> -		struct amdgpu_cwsr_usr_addr tma;
> +	case AMDGPU_TRAP_OP_SET_L2_TRAP: {
> +		struct amdgpu_trap_usr_addr tba;
> +		struct amdgpu_trap_usr_addr tma;
>  
>  		tba.addr = cwsr->in.l2trap.tba_va;
>  		tba.size = cwsr->in.l2trap.tba_sz;
>  		tma.addr = cwsr->in.l2trap.tma_va;
>  		tma.size = cwsr->in.l2trap.tma_sz;
> -		r = amdgpu_cwsr_set_l2_trap_handler(
> -			adev, &fpriv->vm, fpriv->cwsr_trap, &tma, &tba);
> +		r = amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, fpriv->trap_obj, &tma, &tba);
>  	} break;
>  	default:
>  		return -EINVAL;
> @@ -610,13 +609,13 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	return r;
>  }
>  
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr_obj,
>  				    bool enabled)
>  {
>  	uint64_t *l1tma;
>  
> -	if (!amdgpu_cwsr_is_enabled(adev))
> +	if (!amdgpu_trap_is_enabled(adev))
>  		return -EOPNOTSUPP;
>  
>  	if (!cwsr_obj)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> similarity index 66%
> rename from drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> rename to drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> index 06036954627e..c35ae6a11cfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
> @@ -20,8 +20,8 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> -#ifndef AMDGPU_CWSR_H
> -#define AMDGPU_CWSR_H
> +#ifndef AMDGPU_TRAP_H
> +#define AMDGPU_TRAP_H
>  
>  #include <linux/types.h>
>  
> @@ -31,11 +31,11 @@ struct amdgpu_device;
>  struct amdgpu_vm;
>  
>  /**
> - * struct amdgpu_cwsr_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
> + * struct amdgpu_trap_obj - CWSR (Compute Wave Save Restore) buffer tracking
>   * @bo: Buffer object for CWSR area
>   * @bo_va: Buffer object virtual address mapping
>   */
> -struct amdgpu_cwsr_trap_obj {
> +struct amdgpu_trap_obj {
>  	uint64_t tma_gpu_va_addr;
>  	uint64_t tba_gpu_va_addr;
>  
> @@ -45,7 +45,7 @@ struct amdgpu_cwsr_trap_obj {
>  	void *tma_cpu_addr;
>  };
>  
> -struct amdgpu_cwsr_info {
> +struct amdgpu_trap_info {
>  	/* cwsr isa */
>  	struct amdgpu_bo *isa_bo;
>  	const void *isa_buf;
> @@ -56,44 +56,44 @@ struct amdgpu_cwsr_info {
>  	uint32_t xcc_cwsr_sz;
>  };
>  
> -struct amdgpu_cwsr_params {
> +struct amdgpu_trap_params {
>  	uint64_t ctx_save_area_address;
>  	/* cwsr size info */
>  	uint32_t cwsr_sz;
>  };
>  
> -struct amdgpu_cwsr_usr_addr {
> +struct amdgpu_trap_usr_addr {
>  	uint64_t addr;
>  	uint32_t size;
>  };
>  
> -int amdgpu_cwsr_init(struct amdgpu_device *adev);
> -void amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +int amdgpu_trap_init(struct amdgpu_device *adev);
> +void amdgpu_trap_fini(struct amdgpu_device *adev);
>  
> -int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
> -static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
> +int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **cwsr_obj);
> +void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		      struct amdgpu_trap_obj **cwsr_obj);
> +static inline bool amdgpu_trap_is_enabled(struct amdgpu_device *adev)
>  {
> -	return adev->cwsr_info != NULL;
> +	return adev->trap_info;
>  }
>  
> -uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
> -int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
> -				struct amdgpu_cwsr_params *cwsr_params,
> +uint32_t amdgpu_trap_size_needed(struct amdgpu_device *adev, int num_xcc);
> +int amdgpu_trap_validate_params(struct amdgpu_device *adev,
> +				struct amdgpu_trap_params *cwsr_params,
>  				int num_xcc);
> -static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
> +static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
>  {
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  
>  	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
>  }
>  
> -int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
> +int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
>  		      struct drm_file *filp);
> -int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
> -				    struct amdgpu_cwsr_trap_obj *cwsr_obj,
> +int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
> +				    struct amdgpu_trap_obj *cwsr_obj,
>  				    bool enabled);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index feffebb210ea..fcc01e98569d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,7 +34,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  #include "amdgpu_trace.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -251,7 +251,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  
>  int amdgpu_userq_input_cwsr_params_validate(
>  	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params)
> +	struct amdgpu_trap_params *cwsr_params)
>  {
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
>  	struct amdgpu_device *adev = queue->userq_mgr->adev;
> @@ -260,11 +260,11 @@ int amdgpu_userq_input_cwsr_params_validate(
>  	int r;
>  
>  	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> -	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
> +	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, cwsr_params,
>  					num_xcc);
>  	if (r)
>  		return r;
> -	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
> +	cwsr_size = amdgpu_trap_size_needed(queue->userq_mgr->adev, num_xcc);
>  	if (!cwsr_size)
>  		return -EOPNOTSUPP;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 26f7fef3048c..a6a8c50d1ae0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -44,7 +44,7 @@ enum amdgpu_userq_state {
>  };
>  
>  struct amdgpu_mqd_prop;
> -struct amdgpu_cwsr_params;
> +struct amdgpu_trap_params;
>  
>  struct amdgpu_userq_obj {
>  	void		 *cpu_ptr;
> @@ -202,6 +202,6 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  					struct amdgpu_bo_va_mapping *mapping);
>  int amdgpu_userq_input_cwsr_params_validate(
>  	struct amdgpu_usermode_queue *queue,
> -	struct amdgpu_cwsr_params *cwsr_params);
> +	struct amdgpu_trap_params *cwsr_params);
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..1704300622b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,7 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> -#include "amdgpu_cwsr.h"
> +#include "amdgpu_trap.h"
>  
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -172,10 +172,10 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  		queue_input.is_kfd_process = 1;
>  		queue_input.is_aql_queue = 1;
>  	}
> -	if (fpriv->cwsr_trap) {
> -		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
> -		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
> -		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
> +	if (fpriv->trap_obj) {
> +		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
> +		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
> +		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
>  	}
>  
>  	amdgpu_mes_lock(&adev->mes);
> @@ -455,7 +455,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  
>  	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>  		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> -		struct amdgpu_cwsr_params cwsr_params;
> +		struct amdgpu_trap_params cwsr_params;
>  
>  		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
>  			DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -497,7 +497,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			mqd_user->flags &
>  			AMDGPU_USERQ_CREATE_FLAGS_QUEUE_AQL_COMPUTE;
>  
> -		if (amdgpu_cwsr_is_enabled(adev)) {
> +		if (amdgpu_trap_is_enabled(adev)) {
>  			struct amdgpu_fpriv *fpriv =
>  				uq_mgr_to_fpriv(queue->userq_mgr);
>  			int num_xcc;
> @@ -518,7 +518,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			userq_props->ctx_save_area_size =
>  				compute_mqd->ctx_save_area_size;
>  			userq_props->ctl_stack_size =
> -				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
> +				adev->trap_info->xcc_ctl_stack_sz * num_xcc;
>  		}
>  
>  		kfree(compute_mqd);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9222be9a6d2a..552cbf483543 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,7 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
> -#define DRM_AMDGPU_CWSR			0x1B
> +#define DRM_AMDGPU_TRAP			0x1B
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -82,7 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
> -#define DRM_IOCTL_AMDGPU_CWSR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
> +#define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
>  
>  /**
>   * DOC: memory domains
> @@ -1748,10 +1748,10 @@ struct drm_amdgpu_info_cwsr {
>  };
>  
>  /* cwsr ioctl */
> -#define AMDGPU_CWSR_OP_SET_L2_TRAP 1
> +#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
>  
> -struct drm_amdgpu_cwsr_in {
> -	/* AMDGPU_CWSR_OP_* */
> +struct drm_amdgpu_trap_in {
> +	/* AMDGPU_TRAP_OP_* */
>  	__u32 op;
>  	struct {
>  		/* Level 2 trap handler base address */
> @@ -1765,8 +1765,8 @@ struct drm_amdgpu_cwsr_in {
>  	} l2trap;
>  };
>  
> -union drm_amdgpu_cwsr {
> -	struct drm_amdgpu_cwsr_in in;
> +union drm_amdgpu_trap {
> +	struct drm_amdgpu_trap_in in;
>  };
>  /*
>   * Supported GPU families

