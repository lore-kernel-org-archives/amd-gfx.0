Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B417CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD79B10E127;
	Tue, 26 May 2026 07:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NNiUXQd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A06810E127
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnsKUm5n03ZhoVKEHetKencW0TIHIBEygl1Muu7JV0maGSZ50YQAOrLG8xgF2qEKNFumOZPD+7b8gwtS0nEIrgJl8qF82pU3r6JB6sscJF32eFbz6BG5THYNfQo6dVRnoV3zwVyQlwrevxMBFWEAPrQgWuaIzmW3q7UgLhB6jIqrOs33mdskKSDampKxsO66hzEvB4atJanbSiZQOQVXsSmgI4c1NCA8K+5yO8qM+DcNrH4K3gPOSe8qhxpgGGPsm4Bwm60N8G8yMx6tTmlGig2vboKBgmsx7VBpvK7S24FTppNLt9JWXx1ZvDjH6VF+WP1oJPfltiRHeNolUXLINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bq+oUOZxxPsWY6B8JVGeT+yqMJCirObWgc9RXGWLI4=;
 b=JJCOv8ZrfQYp9jFEiNqEksSgndPgwd2XN4Bii/9L1Yj7X5xnQlLTq9DnimLwPHxyCIHK/5/tYY8a7lHYW2xR1ZT66NnEK0zWeyNeS/b1sd92Xi7LYg47UMw2qPiC4KbUNV1/fUajClWxo7YdKIyZsZE/cU5PVW+/d6H31tPgScDgC5gaqWVgvYkWUcUCF9cPfdvSfJDW/MqBCPx0TzxaF2l4VrjOR0two/f/SbRqe9h7ezyTfTOBLZsB75klNd+WFMLV705Htoms1ZGdxA76ivXBjlDO/rAvzUi/2wYrtRtiVEPkQRoRxxJh7IZWu4YlCxnic4kbkbtkr4saUUc5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bq+oUOZxxPsWY6B8JVGeT+yqMJCirObWgc9RXGWLI4=;
 b=3NNiUXQdMq1A4R9mjjdl34iHTuoNlwWbaSpKklEDvsyenfRF+5Bo2o4q2P1CXwcfeXSlpjdHAzgR2Grc8+a/PjKmyLVIDVZz0mQJrpqcscpt1eSSa5SrSDnVWwa/Y7zRJhNjBXqCsvVAo7kxI9EJZOGqhvAH/4ev2N0Sby3KpLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 07:39:29 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 07:39:29 +0000
Message-ID: <0086fc92-7a66-4e77-b49d-1b9bc6c110a7@amd.com>
Date: Tue, 26 May 2026 13:09:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: add ioctl to handle RAS poison error
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 Felix.Kuehling@amd.com, David.YatSin@amd.com, Kent.Russell@amd.com,
 Perry.Yuan@amd.com
References: <20260526022834.2380471-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260526022834.2380471-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 69229a72-5d07-4d11-2787-08debaf9eb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|6133799003|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 91i/hE1mF3xRolT58dghjziC7dKP9HiNPYbysXb6FHQrw7Xp2fDsSjbp2/VVgJHxps+gbSJCy1+OfzurLYE0bTN5Qo6Ehyk66O0UDlMwsLAVes9IZtzKJFNCe4RqKBHYIH4q0boC5dln9j4BeZv/lIoOaWoJUbukPXbXlQkkYtJ1lNdAGNLitm7obEHBL+Dmqv9fgFBGdXWzfMGQHg/he7/ary+I8ktpOVicSYFiDYamLlqbkf7PxL2RBRsPJbtwTTbgCLyPTBGxgEI7/hYDtPVBSWZ4uks4bv+46zIWmTEAYZ9amFtvP6mjPrJR6rY1UD8rHwyillVwnr8cRa7M1SWMJD/cLgXNygRSoNnR5KGmC0PxJCUiU259XJVmXdluysFtoqL0WkMRZbFl536lxe3441urg+HHs/3e7hhv/cRMMOzW38RN7HscncPFpdyui63rhns9Dk/mXzqifYMxZQ82rRsnJYTdtPw2EoCjw1B73+9meByPQPzpAwySUcRbq7Qxk7kWSiax7pifA1/Pf6xstM/DCfnKVgUZWltcn3Crkq4GxdX85fxHOW7Pp1AQX6rK4+hqAcEhbaS5BZMdGxyJPN/qHcxCpB94isV3OKkR/hvaxU8MY5dTtkROgYObw6IiPHdwR1tgcO6f4TKIp8o6rvRUq3wYLJXJ/scIQRgNIdybX24zevFvpv/Qc+NniyAb/etrA37YunIpt9l2qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1SZVliV3lHZGVmRndYd1Vac2dPWnFydlZPTzhlZndSNzNrUjlIZDIwbGZo?=
 =?utf-8?B?eUo4Kys4Y2ZCS1hBWjlYaEJPQll4KzRPeGQ4SWFFTmROdFppU1hSaXI2MTEz?=
 =?utf-8?B?cnVqZ1NWRWptai9WeDE3a2ptV3VoMmFxbm1ONHVNTlJhaEZDTVgwUEFlMmNu?=
 =?utf-8?B?dHZxK3FITjhpOHJtOVdmZ0Q4MnYrRVpBekVqdzhvczRqK1piOGYzVDdtMkF2?=
 =?utf-8?B?WVdXWmhUZENXb0ErUVBGTGRGdlRoZkEzVVdIK3dPenkxU3lENzhiUHFwallm?=
 =?utf-8?B?WUE0eVVqbVY2WWFqb1RKZ28zdklhQnBDeVIwL0R0QjUrSDNySE1KTjN6bmcr?=
 =?utf-8?B?ZGdad1A3Tm5hbml2bWMwVEpucm9sWk9EcGswVG04QVVJL0hjbG9KODMzMngw?=
 =?utf-8?B?cWp3clBFWk9Zazk0di9hbElKdFM5RmZMOVJOOUdOd3hSdWNEbk0wMk9IQktF?=
 =?utf-8?B?NmJvZGJvUGh5SVI0QjlDd3ovRmhUV3lKeUQrMzZEQkgxZHo1eURtZWpwa3Nk?=
 =?utf-8?B?eWpzWCtidlg4ekNmVXdGa1U1cnBzNk5GVGVabWdqS3ROVmxWZVVQTnlHbUpw?=
 =?utf-8?B?cmxmY3krQmlyR2N1TE9UVHRCTGtHQlFQNmhVU0NFVytDQjJoM2NGWGtRWFNS?=
 =?utf-8?B?dWx2ZGpKd0FjUC96eFB0ZG1KNTlxYUd1Y0kwdWJXM0lWR2JNWm9VbWlieUI5?=
 =?utf-8?B?NFB5alJBM1IxdzJQcEMxbkdZc04xcmF1UjlQM1Uyd25Jc1lrb3VHNFJLeVMx?=
 =?utf-8?B?Y3VaOVA3VE1zUFJGdU1Pci9HM2hrTk5ydmNVQVpmNnBhQ3JaKzYrRlp5Vklu?=
 =?utf-8?B?ejkwU1FjUWNpV2p4UmRmcGpudHZ5ZnFVWlI4V3hvZFBDQ3gvcGk4amc2Sk5v?=
 =?utf-8?B?aFZnOHlZeXRlbHhtNE1lY3RETG0vTmVZMVdGcGlOV2IrYUE5cWt0ZEQ5YzN6?=
 =?utf-8?B?b0xZaXZrMlY0NEEzK2tsMTA1eUtYWmJKTkxLQ2RDNk9HTlgrMHJHRnE1c1Fo?=
 =?utf-8?B?RmxYeEFqUWY3SU5OZXpBcThIVElPMVUrTWpHNmd6NGFaVHFIZDNLZUxvWldG?=
 =?utf-8?B?UGlKTm04OEs2Wk9sNW5NSW52aFJkclZWYTFnVjBPNVM0VExWaGROaEhramFu?=
 =?utf-8?B?MlRTc2FnRGRKZW0vYm5RQmZPc1RRTmxqQWdNVTc4UVM1YXZTeFFRREYxVlBC?=
 =?utf-8?B?M3hlcFg1YmJPaUFYcjg3ZGVuRWpub1VvZnRzaDdTUlArU2JPM2xvNjlFOG1W?=
 =?utf-8?B?Rm45ZTFQREZwZmNEZUZMUTEwcTdRRU9lUS9RMDBFY3R1NGgxTkZVazVUWFll?=
 =?utf-8?B?NWRuVE5tdG95cHgxcit5akNvbEFleFZpVUhRbE9EMCtvZi9iS2ZIK3psL0NJ?=
 =?utf-8?B?dXlzSUljSVZnUVU3WXV4ZEI1Y09uQ1ErdDl1bUNkZ2tkUmlyc2dqK2t3KzRV?=
 =?utf-8?B?bXlqdjB6VEFMbTNmWTh0RWtjT2M5ZUEreEZ6TXY1d0lUY1JGKzRyOFlKVlpG?=
 =?utf-8?B?QTdycWcwQmo2WWNjdU5VcVlqZjBpT0tvZWxub0I2RUdwb1AxckMwdlVTUDdj?=
 =?utf-8?B?U0tRN2FSQmsweGY0bFAvTG5obXB1WGNvYzVZUlNDcUZqV1hGbm01RkZCMlpE?=
 =?utf-8?B?d1NKbE4wckZzclN2Z0NXT2dFd2tnYXYxSzJqMy9xc1RuRDNoaS80aWI1Z3hu?=
 =?utf-8?B?VWhhdy8rOHQyM0kzREJzZVB5ZllFSWxvUHhHU0xmdnlaVENlNE00UG9pdkhB?=
 =?utf-8?B?cmI2TUVaL2pIYVFPTHhhOXBHUXJYaytIbjdSalJ2UnNmOVNVb1Q2L3hjckVt?=
 =?utf-8?B?QkdYWVpPMVAvMkRLQXIyeHQxdGM4UFlMdHBaZ3NRNHlDNE8rUys1QTBDYkM5?=
 =?utf-8?B?bE5xbTFxR0lzUFRnd0NuRVBSS3ZzL0Y3S050aE81dnhtanJFb2k4cUM0eTlt?=
 =?utf-8?B?RGI0RlVMdEtjTVBEcnc0akh6YUNrc1ByVkJ2aGZNYldOK2xUNHE2dHhwSmhH?=
 =?utf-8?B?b1U2RnFBOU95TWtuZjd5U1QwVEN6c2RRR1V3ZHdJL0lEbDlHQUF4Y0JhTitD?=
 =?utf-8?B?RFhNc0cxdTZvRWRJditoSFUybUc1UkVZYy9JTFZ1N0YxbS9OTms2TkxuZDhC?=
 =?utf-8?B?NVk0ZDZDZGZ6T0d2RFZHbUxrYlZqNnhyWG5acjYxNk1LTWZCcGxzRnhPRmVj?=
 =?utf-8?B?SVhURXRqeGVyWXQwNjk5bnZoMXhiemYrTEF0dXJXSlpzaU5HbjhuZ1NYdUJn?=
 =?utf-8?B?VTBVU3lobmxWa0FkVzR6cW9tanhvcjRvVmx4a2M1S2E0RjhPdzczRk5tVmZo?=
 =?utf-8?Q?+s8eGAGg2Uv8oyRC6S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69229a72-5d07-4d11-2787-08debaf9eb7e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:39:29.5044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II6h66N/NbzAy05pp5eDEOYDhI81IALsa1X2kEruT7J3xA/+RguPaK8av2v5tnU2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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



On 26-May-26 7:58 AM, Yifan Zhang wrote:
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
> to control per-process SIGBUS delivery.
> 
> Userspace for this can be found at:
> https://github.com/ROCm/rocm-systems/pull/6190
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Have one generic comment on the ioctl naming convention. Need comments 
from Alex/Christian also.

Apart from that looks good to me -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 69 +++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 15 +++++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 33 +++++++++++
>   include/uapi/drm/amdgpu_drm.h              | 21 +++++++
>   8 files changed, 173 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..771ec0608270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>   int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>   		      struct drm_file *filp);
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>   
>   /*
>    * functions used by amdgpu_encoder.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5333e052d56d..68d83a6e6b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>   int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>   					uint32_t domain,
>   					struct dma_fence *fence);
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
>   #else
>   static inline
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> @@ -241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>   {
>   	return 0;
>   }
> +static inline
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   /* Shared API */
>   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..4d4d21babc61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..772e0fda7e14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
> +	struct drm_amdgpu_user_options *args = data;
> +
> +	switch (args->op) {
> +	case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> +		return amdgpu_amdkfd_set_sigbus_delay(current,
> +						      args->kfd_sigbus_delay.value);
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
> index e9be798c0a2b..92027c5aae61 100644
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
> @@ -1337,6 +1339,71 @@ void kfd_signal_reset_event(struct kfd_node *dev)
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
> + * Encoded value (stored on the kfd_process):
> + *   0          - default: SIGBUS immediately (no opt-in)
> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
> + *                handle the error in time (safety timeout)
> + */
> +
> +void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
> +{
> +	struct kfd_process *p = container_of(to_delayed_work(work),
> +				struct kfd_process, signal_work);
> +
> +	if (p->lead_thread)
> +		send_sig(SIGBUS, p->lead_thread, 0);
> +
> +	kfd_unref_process(p);
> +}
> +
> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> +					 struct kfd_process *p)
> +{
> +	u32 delay_ms = atomic_read(&p->kfd_sigbus_delay_ms);
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
> +	/*
> +	 * Take an extra reference for the delayed worker. If the work is
> +	 * already pending (e.g. another device of this process consumed poison
> +	 * just before), drop the reference and skip rescheduling - the process
> +	 * only needs to be notified once.
> +	 */
> +	kref_get(&p->ref);
> +	if (!schedule_delayed_work(&p->signal_work, msecs_to_jiffies(delay_ms))) {
> +		kfd_unref_process(p);
> +		return;
> +	}
> +
> +	dev_info(dev->adev->dev,
> +		 "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS error opt-in safety timeout)\n",
> +		 p->lead_thread->comm, p->lead_thread->pid, delay_ms);
> +	return;
> +
> +send_now:
> +	send_sig(SIGBUS, p->lead_thread, 0);
> +}
> +
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   {
>   	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
> @@ -1391,7 +1458,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   	rcu_read_unlock();
>   
>   	/* user application will handle SIGBUS signal */
> -	send_sig(SIGBUS, p->lead_thread, 0);
> +	kfd_signal_sigbus_with_delay(dev, p);
>   
>   	kfd_unref_process(p);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f037062c33ea..ae6d1ecb14d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -957,6 +957,20 @@ struct kfd_process {
>   	size_t signal_event_count;
>   	bool signal_event_limit_reached;
>   
> +	/**
> +	 * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option for
> +	 * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
> +	 * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
> +	 *
> +	 *   0          - send SIGBUS immediately (default)
> +	 *   0xFFFFFFFF - suppress SIGBUS delivery
> +	 *   other      - delay SIGBUS delivery by this many milliseconds
> +	 */
> +	atomic_t kfd_sigbus_delay_ms;
> +
> +	/* Delayed signal delivery to user */
> +	struct delayed_work signal_work;
> +
>   	/* Information used for memory eviction */
>   	void *kgd_process_info;
>   	/* Eviction fence that is attached to all the BOs of this process. The
> @@ -1554,6 +1568,7 @@ void kfd_signal_vm_fault_event(struct kfd_process_device *pdd,
>   void kfd_signal_reset_event(struct kfd_node *dev);
>   
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
> +void kfd_signal_sigbus_delayed_fn(struct work_struct *work);
>   void kfd_signal_process_terminate_event(struct kfd_process *p);
>   
>   static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 419bb8086ccd..dd48ad9a3438 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -992,6 +992,33 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   	return process;
>   }
>   
> +/**
> + * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
> + * @task: task in the target process
> + * @ms:   encoded delay value (0 = immediate, 0xFFFFFFFF = suppress,
> + *        otherwise delay in milliseconds)
> + *
> + * Stores the SIGBUS delivery option on the kfd_process associated with
> + * @task. If the calling process has not opened /dev/kfd yet (no
> + * kfd_process exists), this is a no-op - the option only applies to
> + * processes that actually use KFD.
> + */
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
> +{
> +	struct kfd_process *p;
> +
> +	if (!task->mm)
> +		return -EINVAL;
> +
> +	p = kfd_lookup_process_by_mm(task->mm);
> +	if (!p)
> +		return 0;
> +
> +	atomic_set(&p->kfd_sigbus_delay_ms, ms);
> +	kfd_unref_process(p);
> +	return 0;
> +}
> +
>   static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>   {
>   	struct kfd_process *process;
> @@ -1328,6 +1355,11 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
>   	kfd_process_table_remove(p);
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
> +	/*
> +	 * If work pending, cancel it and drop the extra ref
> +	 */
> +	if (cancel_delayed_work_sync(&p->signal_work))
> +		kfd_unref_process(p);
>   
>   	/*
>   	 * Dequeue and destroy user queues, it is not safe for GPU to access
> @@ -1584,6 +1616,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   
>   	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>   	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
> +	INIT_DELAYED_WORK(&process->signal_work, kfd_signal_sigbus_delayed_fn);
>   	process->last_restore_timestamp = get_jiffies_64();
>   	err = kfd_event_init_process(process);
>   	if (err)
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..ab71c4b4aeac 100644
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
> @@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
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
> +	struct {
> +		__u32 value;
> +	} kfd_sigbus_delay;
> +};

Rather than 'user', it may be good to consider naming it as 
amdgpu_proc_options (process related options).

Thanks,
Lijo

> +
>   #if defined(__cplusplus)
>   }
>   #endif

