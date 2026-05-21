Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FABCD343F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 04:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FA510E46C;
	Thu, 21 May 2026 04:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYOoLkaM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754F810E46C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 04:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcYfttRgNT9+pta4aVBUCjaYvwVRr9f2I5PcKiP/Sj5r7n/1tf+dIwOaH7npRjYKynO+IFICLnchxRrToj8hWNkEqaR/fBPxm4YQSm73Hfpj/Cgn3EtGZtWGV4Zn/Uck9cLUJjvRopnyrp0vgcqwgrgL1Je5Ek9jEwqkpjBrb5iGiDXRoZVRVvNzQ+qtJ4bE6TJaQ6MN7Izlvv0CPJ6I7YkbFFk+DyesSHMkcsOiNzmBLpfsYqMom+ARkdFVIIEpVToEGxXztvTcvuJD32T57pZFxy0ynpDFLlfCwTg2CxpSmVSM9zsgAuLsfDjomtP+BBsPijJieVwv/gkXszE1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWxIpngY4N0Bl5xQOWTEpVnMQTmvFDQtsuOs0Fd1VwI=;
 b=YUitQ+IY6sOiJ24/gAwZN9y7G0n7wdmiPYf1xeT4G8NLW0RiQnBzX7pEkNhDQXqHvMCgmT1UmHQd+xTIgnJNQqRcK5EkdnQvl6u8nxLpHsqWzgE7FH2sJVI78/Jau1F+onMtZYn1dskipq+n/UwriduGOMrLg9r0SaL5zPsLPUjB0StdNtOD7WF9VoCx1OeAu+ZU3KDwZXKUNggFthcnP2r0oMtWrU4LEIKKka/2VLn+qe7csUSKK+X+eIUx2m4rpEH/0RzXpRh6LWQVUSnZetiTpUOp6sbDsuVTFlxu+Cs+ZVZc1pt5glSmt5OcFjojfBq74646058TxlEdlvIm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxIpngY4N0Bl5xQOWTEpVnMQTmvFDQtsuOs0Fd1VwI=;
 b=rYOoLkaMuY4Mzu0HzSV2liZNvdTqVftbAN3g8+9jlbfmeu0z11fZ5Y60mMPXFSjbG1CcQUVyApCJ0t/lYzZ9isHLqPMB6I+ccXDlbjijbz1IcIlKH3aIIzA1w2OQ9Com1Lqv/p61thBjF17XC3JT9s8IXaLgPF8OuHUUYc5Tg5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 04:35:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 04:35:30 +0000
Message-ID: <adc4600a-1d3c-4e79-9b6e-2e433bb3223e@amd.com>
Date: Thu, 21 May 2026 10:05:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, David.YatSin@amd.com, Kent.Russell@amd.com,
 Perry.Yuan@amd.com
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260515132702.1494187-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 60be71ea-cebc-4a7c-89ee-08deb6f2635c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: JKBuQ7JatKHUta/hmgo+Rqnl6voJ3yFLy9m4Jh7uQWzcZQRTuFq59m9mvzl8GASIZmc8HsygQDzqOqwZsdtUAGqTY/1ClqYGLCmMXCoE8+5Z0We6u92ujfmg1N0uteOzY2yl49IQfcIKIqw6BuP2iu5aYjrXVrtxOJH5zt+48sRBC6P7fS0Zw6bszLsrj0UhWm13PvHvpFFNoTfqWocvNayg053QP29KDgeCPqCeCg4aWUknULj8CHKkzexljjOmdeLVDz9PY75YkFyoi1jKvYG2O+OwJ8iuUAbmGMiFm4RAG/+c5quXS1QKf9TCXY7QG+Er76ul7m6u3ov2Sy1bv4xSZJUMpWBMwjq5vAJJnSs42/ViHTBdfZW1z94+poqrpuUAo56WidGueadMs0SKMVhKk+Q9EvdR1vp3cEOzJBQaVLyYGTdc3suR6xpLPrbuUeRtEgeKP5dgLIOBmMAQWEH5ABIDybvy2Vkun1BDrnruG2+TgBcHPSUt12o5DAw7eOAx5MFUAhEtpG5kooVrgVGhIG1vlrbZmRHiyPN2UAIz4HxSPFnikm08+qqr8UOQoQIlqh1er8TqtHBubMdeulNTEUnmYtj+/0HyzM9FzgXfyWPm1a5xdMnusCUlvNgNb5UKKgJQ57dTvinnKW/GaBWC/XERXPuzdG2cN0c/5lBBITP4KPRqLlF3O+cfPFgu4eOh98HUT5S4Pqmb168oyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pKT1k5VzBFZWh1c0xuQUY5NndPaHdKSjU2SGlVUWI3dGFJQi9YK2M3bjIx?=
 =?utf-8?B?b1RocVJWWHpESTJFMGdNdFNwZWV5eEFsSDR5Wk1XTzZsQ2FNUHlKMDBwZUdR?=
 =?utf-8?B?NjAxeWwrdFg4bFBsZlE1Y2hSdEdMNzRobDFXSnNOaXZ0L1NSbDMxVjBkRlNp?=
 =?utf-8?B?bml5V2lkMFhwYjk0YjJNNkFBYVYrMGN6Tmg0S3pSVWtJaW5XdThvNTkySU1B?=
 =?utf-8?B?TUNxZEdxb0xPNEZoYS9DSFBHWHNjZXUxdmJwczY5Qkc3NTUzUG1aSVBsTFdM?=
 =?utf-8?B?S0lpQW5XV1BxblM2T1VnbllPcEJRMzBaRUZncWQwMDdJa3ZqbS9JS3VKU0ZD?=
 =?utf-8?B?Z3E5ZjFtRTdtbkRYNWt4Tm85TFNBL25HZXNaeWhTZHE4N2luUGpITUN4dVYx?=
 =?utf-8?B?b1l0VXFtaVhaWGNHWGRDbk4zUWFQVnBDaHZVQUZEZktzbmU5bWw0UjdMRHlV?=
 =?utf-8?B?ZTB6ZzZ1SWYrZlpseVdQWjNkb0xva0sreENNeHJEVVBhdm8vQzAweWZhK012?=
 =?utf-8?B?MXRvRjZoK0N6TEdEMDN0bjFEUU5qc2xwaUFJNnpkamV5UlMxT0cxQzkyWFdm?=
 =?utf-8?B?eDR2SzUzQkdHY1M5Skl5OGtiQjVVZ3pIS2ROUDIzT1JHeGs4MTJPbU9EYUtJ?=
 =?utf-8?B?ZkNOYTBtZ3JhMGdnRWhvVi84eE5nYnc1TGQwNU9GTjY2ZTdpckRITjRkdFVj?=
 =?utf-8?B?QjNXNHRVRU9zV3phaXlUUTZTQWU5MVl6U1VxZnR3UXI2OUVIS2NyUWFHK2pa?=
 =?utf-8?B?NWN6bWtoZnQwNzhPYVJZa3hFV2VmWFRmK0w0N2s2ajhlQ0hKc2JibEhRMkF4?=
 =?utf-8?B?S0hVNkhFMlcrb1VQb2U0LzlyeUhzUDk5SGdVZk0rcTNTQmxzR21DYzJxYmlE?=
 =?utf-8?B?VkcvWmh6aldRQ01ZMmYyVmswTlIzYUZPSWdpdGdsNDd6QzBpOW9MTEdmV05s?=
 =?utf-8?B?ZGhkV0RXUjBzaGdNMzhWVmFZVHdZdzZFTmJyQjdaQXhtODl2SWFKK3FFcDdW?=
 =?utf-8?B?TzdpVzZCZWtWWWE0VnQyRkN1eHFrRWp3ZjN3SCt6aXBkRlZNMzRsTU04M1Y1?=
 =?utf-8?B?aDgxNFZtcjZySlYxS0tGYk4wWGRHOHJYZ1lIbmszQkhpOGZZNFFGM1ZFL2V3?=
 =?utf-8?B?WlYyRndnV0hPampDOCtUbUNWd3lQbmhlU2VBOTFwS3lIdi9NZ2FpVmtReURx?=
 =?utf-8?B?WVhhRUpETXc0OUFOTDNSeld1N3c2dDhHamdDME02YzdxMzN3d0ZSSkJEd2Jj?=
 =?utf-8?B?V1ZQZHZzcU1SajZqZEpya0M2NHNuOG9GQXd4TC9EWUw3QlpjN2hkaHc3dFFG?=
 =?utf-8?B?TGhJSzdlNUVCTWlQYjI5S2ZRamQxUnBFbHduN3p4elVqZ2VBZkc3SzhyK3RW?=
 =?utf-8?B?OUpIbGFqY3l4aDl3MEtBeW14dnlsK2FiaGNLcWNpS0xPcXY0OUsrM2xiN0VK?=
 =?utf-8?B?aWo3eE5YOU56NktydlQvNm9NbDNtUTJMb3Z2ZkNaWXg2Z1liSE8yaHV6TEJN?=
 =?utf-8?B?TkhkbFRaV1kveHltMTFVdHd5Umo3ajhQek5jeXdXV1BBSEQ2RUt5RUtiQmVV?=
 =?utf-8?B?Q2I3Y09MMFM3ZFlFK2tVdGt5bHNVT1RvbVVrR2Vjalk3NVhUaEU4R1ZwNC9j?=
 =?utf-8?B?bEpYM2hxcnhpRFhMM0swSitrWTczSkhRU3RpbkNRRGJJZFQwcGtWWWt2U2pk?=
 =?utf-8?B?L3lrUFRhdTNGRTg3Zk4rSys4SnVaM3lUbXYyc2ZKdkhEUm9Id1YvMkczL0Fm?=
 =?utf-8?B?b1pnZjQ5dytNeG5hWVM1MkVYUmk2clNadzhlcDJzNUQyMklXeDNSUmRHbVJO?=
 =?utf-8?B?WEU1dGgxdTNCckxPeDVnSWdrRXlMb0k4REw2TGZtRG56WFBwM0RVdVo2NHhY?=
 =?utf-8?B?MUtIWUc0bGJLYkxMUTQxNFJqZ3JiK1Q1NzR1ZnpFenBnUjJzY2VoN0tGSkI5?=
 =?utf-8?B?TWZvZE5zVE02MmM5am40ZUtBTlZMTTNXNU9VakRkY01iN0lXMlhmVzBrRzl2?=
 =?utf-8?B?UDJUZUhnVzY4OVNXVkJxTGxPNG1vaWFJaUlYVW5Oc0YrWnBZZzdEc1ZhQlQ3?=
 =?utf-8?B?SnZUZ1NCcnI3dExCbFVmM3dXTXJLNWx1Tm5Gc2NzOWNabjV0K1QxK2kzWmVn?=
 =?utf-8?B?SzYxVU9pMnA0VGhHWjhwaDVncW93U2huZ3p6cTlFUGRLN2dFaTBaTnVvY0Rk?=
 =?utf-8?B?dHE0TW9lZitSVjkrNWpoOTZ4UXF1V2VYelg5VndESUtoUUtBUmZaUmNZeEJD?=
 =?utf-8?B?S3dqRGdLL2V2bStJRVhlZWpMTWovakE2QWNRNHgzYzBhelEwVEl6WWtDUzZQ?=
 =?utf-8?B?MmNwdDNtd0ZrOVBabVFQNE12c3BpTWJJRXNZS0pUQzdKZ2dHR0MxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60be71ea-cebc-4a7c-89ee-08deb6f2635c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:35:30.3448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kx9R1jPbyxv1+Gy2WlKP/UF7wes18oVtPc95lmT/7W2xZ80jrThMT2IpbleISma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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



On 15-May-26 6:57 PM, Yifan Zhang wrote:
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
> to control per-process SIGBUS delivery.
> 
> Userspace for this can be found at:
> https://github.com/ROCm/rocm-systems/pull/6148
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>   include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>   5 files changed, 179 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..6a5459b59af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>   
>   	/** GPU partition selection */
>   	uint32_t		xcp_id;
> +
> +	/**
> +	 * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set via
> +	 * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
> +	 *
> +	 *   0          - send SIGBUS immediately (default)
> +	 *   0xFFFFFFFF - suppress SIGBUS delivery
> +	 *   other      - delay SIGBUS delivery by this many milliseconds
> +	 */
> +	atomic_t		kfd_sigbus_delay_ms;
>   };
>   
>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>   int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>   		      struct drm_file *filp);
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>   
>   /*
>    * functions used by amdgpu_encoder.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 99688391e70b..cad18bd6f8b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..7903587b8bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   	return 0;
>   }
>   
> +/**
> + * amdgpu_user_options_ioctl - set per-fd user options
> + *
> + * @dev: drm dev pointer
> + * @data: pointer to struct drm_amdgpu_user_options
> + * @filp: drm file
> + *
> + * Sets options stored on the per-file amdgpu_fpriv. Currently the only
> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
> + * controls how KFD delivers SIGBUS for poison/RAS events to the calling
> + * process (immediate, suppressed, or delayed by N milliseconds).
> + */
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct drm_amdgpu_user_options *args = data;
> +
> +	switch (args->op) {
> +	case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> +		atomic_set(&fpriv->kfd_sigbus_delay_ms,
> +			   args->kfd_sigbus_delay.value);

Why this is stored at device level? A signal is process specific. I 
think the delay should be associated with the process regardless of 
multi-dev scenario.

Thanks,
Lijo

> +		return 0;
> +	default:
> +		DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
> +		return -EINVAL;
> +	}
> +}
> +
>   /**
>    * amdgpu_driver_open_kms - drm callback for open
>    *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..2ff6348105b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -29,10 +29,12 @@
>   #include <linux/uaccess.h>
>   #include <linux/mman.h>
>   #include <linux/memory.h>
> +#include <linux/workqueue.h>
>   #include "kfd_priv.h"
>   #include "kfd_events.h"
>   #include "kfd_device_queue_manager.h"
>   #include <linux/device.h>
> +#include <uapi/drm/amdgpu_drm.h>
>   
>   /*
>    * Wrapper around wait_queue_entry_t
> @@ -1337,6 +1339,115 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   }
>   
> +/*
> + * Per-process opt-in for poison-consumption SIGBUS handling.
> + *
> + * Default: kernel sends SIGBUS to the process immediately when poison is
> + * consumed, in addition to delivering the KFD HW/MEMORY exception events.
> + *
> + * Userspace (ROCr) can opt-in per-process via the
> + * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> + * option. This lets the app's registered system-event callback handle the
> + * RAS error first, instead of being killed by SIGBUS.
> + *
> + * Encoded value (set on any of the process' amdgpu render fds):
> + *   0          - default: SIGBUS immediately (no opt-in)
> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
> + *                handle the error in time (safety timeout)
> + *
> + * Per-process scope: the option is honored if ANY of the process' amdgpu
> + * fds has been configured. This matches the slide deck's "Per-process,
> + * App set at init" semantics, while keeping the UAPI on amdgpu where ROCr
> + * sets it.
> + */
> +struct kfd_sigbus_delayed_work {
> +	struct delayed_work work;
> +	struct kfd_process *p;
> +};
> +
> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
> +{
> +	struct kfd_sigbus_delayed_work *dw = container_of(to_delayed_work(work),
> +				struct kfd_sigbus_delayed_work, work);
> +	struct kfd_process *p = dw->p;
> +
> +	if (p->lead_thread)
> +		send_sig(SIGBUS, p->lead_thread, 0);
> +
> +	kfd_unref_process(p);
> +	kfree(dw);
> +}
> +
> +/*
> + * Resolve the per-process SIGBUS opt-in setting by scanning all of the
> + * process' KFD pdds (each backed by an amdgpu render fd). Returns the
> + * "most lenient" value across all fds, in this priority:
> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
> + *
> + * Rationale: if the app has explicitly opted in on any GPU it uses, it
> + * wants the chance to handle the error in userspace.
> + */
> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
> +{
> +	u32 result = 0;
> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct amdgpu_fpriv *drv_priv;
> +		u32 v;
> +
> +		if (!pdd || !pdd->drm_file)
> +			continue;
> +		if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
> +			continue;
> +
> +		v = atomic_read(&drv_priv->kfd_sigbus_delay_ms);
> +		if (v == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED)
> +			return v;
> +		if (v > result)
> +			result = v;
> +	}
> +
> +	return result;
> +}
> +
> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> +					 struct kfd_process *p)
> +{
> +	u32 delay_ms = kfd_get_sigbus_delay_ms(p);
> +	struct kfd_sigbus_delayed_work *dw;
> +
> +	if (delay_ms == AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
> +		dev_info(dev->adev->dev,
> +			 "SIGBUS suppressed for process %s(pid:%d): app opted in to handle RAS error\n",
> +			 p->lead_thread->comm, p->lead_thread->pid);
> +		return;
> +	}
> +
> +	if (delay_ms == 0)
> +		goto send_now;
> +
> +	dw = kzalloc(sizeof(*dw), GFP_ATOMIC);
> +	if (!dw)
> +		goto send_now;
> +
> +	/* Take an extra reference for the delayed worker. */
> +	kref_get(&p->ref);
> +	dw->p = p;
> +	INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
> +
> +	dev_info(dev->adev->dev,
> +		 "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
> +		 p->lead_thread->comm, p->lead_thread->pid, delay_ms);
> +	schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
> +	return;
> +
> +send_now:
> +	send_sig(SIGBUS, p->lead_thread, 0);
> +}
> +
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   {
>   	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
> @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   	struct kfd_event *ev;
>   	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>   	int user_gpu_id;
> -
>   	if (!p) {
>   		dev_warn(dev->adev->dev, "Not find process with pasid:%d\n", pasid);
>   		return; /* Presumably process exited. */
> @@ -1391,7 +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   	rcu_read_unlock();
>   
>   	/* user application will handle SIGBUS signal */
> -	send_sig(SIGBUS, p->lead_thread, 0);
> +	kfd_signal_sigbus_with_delay(dev, p);
>   
>   	kfd_unref_process(p);
>   }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..dfc91d25c80d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> +#define DRM_AMDGPU_USER_OPTIONS		0x1A
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>   
>   /**
>    * DOC: memory domains
> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>   #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
>   #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
>   
> +/*
> + * Definition of user options
> + *
> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> + *    0:          Disable sigbus delay - SIGBUS will be raised immediately
> + *    0xFFFFFFFF: SIGBUS will not be raised
> + *    other:      Set the sigbus delay in milliseconds
> + */
> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY		0
> +
> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED	0xFFFFFFFFu
> +
> +struct drm_amdgpu_user_options {
> +	__u32 op;
> +	union {
> +		struct {
> +			__u16 value;
> +			__u16 _pad;
> +		} kfd_sigbus_delay;
> +		__u32 _pad;
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif

