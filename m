Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E92CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 08:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDF710EF92;
	Wed, 20 May 2026 08:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RKL38Tn1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF4F10EF92
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 08:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0lb3fZYiAIyb4beBxgAAdhklQy7ps1FluKV+UVtcMK76CzGMcw3w0zsFlKiZBOoefoXIiwFOUKa5vwS7I0y2y+5G/V/tzhNB/sri9+o5kOTPvFcWDRE/DwrvbaOkD6zeArlSPPHleDF9YEHRV5mvec5IPJL/8TD35k2Kpt4Kq32mlVzMLHDB29TykVaIHJTD3Elzwr9RcIJPlg+mqNCh8u3bne13e4k1sgXKL7iTNrvOfa8f9yXp5Do0f3iE8BsjeLB4ct8RCw/Cqh5nN9KUOOHOJ8eaAb7VyenrhAIdbpDcvOeic+DLAPP4c4wRC79aSzkcPQf+Se5h7j3XAeOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpn1qvNUjEBt5M0ajK5kCBwc6H8MMSZNqxy//q3oCm0=;
 b=qD9C1DVAQ1CLLoJWsAq+vX0F3zoWmoAwH4OaMtPuA5vBVtEny7W9XFUcvmpyuzFmlL8pdGKaHoGZQRqOAIcSxdavEF0XjgB/IvOxPZg30IqfXUxGMbZmXdM51AET2cqJqFmm2THxezKGyqgLbmKiEQPYFCpEbB4jSD643/AbEa0rJO7pOOZoiN5Rh1iCkKZ6HOuqtR2GxI2pvvmBBeU+F9DGaZS/KyjEZhgjXM/bnLXchTy4BborI0D8a4ukmGR5+rI5uWpi0Vh7/howyD9Z0+VEV9pgzPoqC7n/5zQZIXPko4QtjKGD61lGlQuPkfsbRyu+3AMrzyDo7shATj+dlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpn1qvNUjEBt5M0ajK5kCBwc6H8MMSZNqxy//q3oCm0=;
 b=RKL38Tn1A0lOkDihG37ghnvaDNs56EdgykMeXlROCKFDnoMYQvUloe8KfC5OwwCa1MOVN3sWjWGlgoCTmBg4itdlreImfW0awJFifSUPdXUxXEgzg/kBx3o9Lt3vHcFafuE9n7yxGc7rlbx1lCsZsdOn9b491eT1M2CL4glM9kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 08:35:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 08:35:46 +0000
Message-ID: <504729b6-32f7-49e9-993e-13b4aae58c42@amd.com>
Date: Wed, 20 May 2026 10:35:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add lockdep annotations for lock ordering
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260520015609.127747-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520015609.127747-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f323fe9-5c87-4129-6721-08deb64ac9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: aO9cNK85Ydwy8gj4vM10HpwjfY/5S40ox10NGbljxf8oAi01TZB0Hj8HTyFqily+u1sbbIZsaz5+4oEyH4dyeae97oAgPzU0WC+HwW09mSMDnXDPFavgnHo8QP+VI1Lzoosbh/a4ReC5o/zLg7Rlab50OVvmQxWYQNQJdu2jm5dvGLzojl7Sh0c4SXtUaiO0Ewg0+byS4vjLMk8Cz2bxck9kdhK0fH3VXyGDHe1uuUOZw5R0VwDn7lYYnpSq0lgH0+I8ycG8bbFRIStoGLvUCgtvN9+PZJhqxv4VVeRhVkBzmIhSxyZKK8Pvm0DmoRfkz+9ISqzQGHd5Pa8zw1l2sKBB75Ivjedo73aIAEj/v5ij/IVmPTGrrSjmr9+IaGnBBVPbOpxJHYLa3g0Axo5uczDr93S9VW0+HtV3cQRoDw4DtLYqTH6ETpaIjDzaJvmaFhiuSY9OHOjZSvu09syxcCXQvH7OZtZTOpYiSMpaBUPboRLC1/rsqIlwON9NV3RPhJfputmDWbVIKkTKgJONKChBjfV2zQj7A/0V+6zYaCzJv8AfOF2nDWvYIE0bpI94BWSv/GxgstbnxQyUl8UDLFR+0N+Oe/3rMxt3CtN5dSVep3b0b69NDdau2vbZm8OBH0tUs3HO6osrZyrSKCWdPGZj9wl52p8eTucbnZfOhEU41B63kcONcIOlAVx5IY8u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlyY1BDZ2VrMXR5NXYzc292M200QlJhN1p1N1lndWpYaCtoM2xSZndmRzJ0?=
 =?utf-8?B?LzlJbmxjb1ZGYWZTVFRBVGhkMzkrZDMvL2ExTGNUQm1jSFlRZEpTZVZJeGFC?=
 =?utf-8?B?Y2FzRkk2amtjaEJGR2l2dUw5OHN4R1k1T0Y0Y2lkQjFFdHRNbmpUMFpYVDJw?=
 =?utf-8?B?b1BZdmZBRW83QSsvbm9YRnFvMVUrdDBnRW55YnVLNDFBR0xvYjl0d1NtbENn?=
 =?utf-8?B?ay9ra2pCYzZiZzRYV0Vra1VPM21GQUd2Y1AxQXlTSWpjbnFnQkhiM0VJeGVq?=
 =?utf-8?B?NmdiYVcyNmhCanNZanNVb1RiSE1OSW9SSlA2V1czN2M3Y09lUUs1VlRFemo5?=
 =?utf-8?B?ZURNbG9MZjJIa05ZYkVSMU1TRkJEWTRrRFFhSnNuNGRESUwzZi9Ha1NrYkdn?=
 =?utf-8?B?SUl0ekFMcmdQSTlFSUVTQVdWeW9ZK2ZObkZtVVJRNmlRQUpFS2ZBWmIvMXc5?=
 =?utf-8?B?Ylp6SzJPaXc4K05pU240RkJDaVFGWFhvZTdCcm0vK1VydEs0ZW9tYjUweTFT?=
 =?utf-8?B?MmxiVThqYWpUUGhtUzZLb0ZZWjRORjgvOXBFV3RHbzFZL05HQ2JoVFVjYW1N?=
 =?utf-8?B?NzFiSmI2cEpYNUZPVzVZVWRWUXdpKzIxN25UWmpTSk5WcTVSQ2RJdFk4TlEy?=
 =?utf-8?B?Wm81YlN3R3JYSXJmM2hINGc1VzIxSDhXcTFVRmU0WUpVTENIWkdqOXhPeHFv?=
 =?utf-8?B?YTRpS3RSVlhFcmNtRDUvUjhKZWUzRjFoUzdwOXZySmwvSUxlSFM3djZPV0RW?=
 =?utf-8?B?N1hub1hUZWJLQThBZk5WNXBubmwxRTU3M1ZGQytIbzlGNWhhVVB6aEpCVXBU?=
 =?utf-8?B?bXY0RzlvRW1QWWkvSVFLYmhERG55QnlIVTZwbkxqOUZHV01ocVp4cms4cFpP?=
 =?utf-8?B?OXNBYnRQd2dncWRXR1F4WUlsaWN6cENsa0g3SE5GTTh6WllKVEFmNTFCWlpz?=
 =?utf-8?B?aW1TNEp6UU1XVkhhWU5VZzh5RFJaY2dsWk0xY2N4djNFcTliRmRhNGFDWk8w?=
 =?utf-8?B?WTFKRzNqZCsreEFTOXV1ajAvait5SGMrQ2I3ZkovTkEzOGREOHl5S2gvb1Vn?=
 =?utf-8?B?MGU3cElkNXBDTVNYL0ppcmRBL3VSbXo2amVRT3Y0UW9KL0VRZmxHNzRDZlVB?=
 =?utf-8?B?VlZ5TjZza1JnTWFhZWthMXF2ZmpnOXpWdm5aZjRmSHdIWjJvd2p2QnlzTHBS?=
 =?utf-8?B?OGxaVTBERFlqTk5PRk95aVErSXJ3Zndacnl2NU5JTHNheW1EdXRFdUpaUDNK?=
 =?utf-8?B?b2YvdlNraEt5eEtlWnMxVlYyMHh1Qmtvck9NWTF1YzhLUllqMWxYUmFsVFFX?=
 =?utf-8?B?NHBiQzZJZ0VMNlRDb3Nlc3V0OHdHYUp3dDZJL3RXYkxqWklHck1QT1lMOVlG?=
 =?utf-8?B?MmFkNGdJSWNxcXF5OGtSa3ZCVXZxeFF1eDY0N3BFSUxOL1k2YWJ0N0dBTlhJ?=
 =?utf-8?B?djBTNGRFeVpLc2VHQUhlYjZGazd3ckxhMXRPVjJ4dEdOMU9paW5zMXpKWlpj?=
 =?utf-8?B?dDRsYVNnRnZoZ0RFRGdPYk5vaUFzb28yLytuZXVla3p0Zk9GK1ZzeDFzV1o1?=
 =?utf-8?B?b0pvdTNJSTZzQ090WHBQbGl0TzViUzlKQWtvS1VHWlk3NnZxTm1nOEhaUXRk?=
 =?utf-8?B?Nk50ZFFWSk55bUxrZkVKdTVvL3JJRDFuMVQrKzRvalBrSVFtQ3JkUEFTVktK?=
 =?utf-8?B?NzQ0VXdxY0xkWTd4UEJqRWVTOTdEVzI0M2tpUTBocWp2ZzQ2QjJTN2E3eDNi?=
 =?utf-8?B?UFpRSDBkNzBVWStnMmxyeXJud1BUdUFNUjBaaTE5VGcrcEhtRGsvS1dQK0RU?=
 =?utf-8?B?eWg5RGVWQllJRDBxc2JzN0lhTFhFK0Z1VnB2aG5WcElxcm16RUoyTkZmeUhW?=
 =?utf-8?B?amtWTTltUllLVVBvaldzVW53c1VQMUhhaGlZMUNRVGhLb3ZyM0FOSFdDTnNt?=
 =?utf-8?B?WWNKK1JsK25ETnZsV243ZzlEd29HSk5TVGNZNEwvTElkQXV6bm1ZNjYyMytv?=
 =?utf-8?B?TExwVzhYaEZZeW9KWnB2M3ByVmQ1QkhackdKMFBxN1RScmExWGdPQ002aFRk?=
 =?utf-8?B?d3lRSlBINE9XdDF0VGJjQ21tNnl2UGNNSk5ySENoSG53c0wzOWJKdEkvNGRa?=
 =?utf-8?B?VTZOUEwxVUJFTVRpdzVXWUFzM2prUWxkRUVFZGNsWklCNFFRMFExR0x5R2Vs?=
 =?utf-8?B?b3FSb0RxbTY3ejZONTNzcHY0WG05eUdGTTRhdFg2Q29KWWlqV0hGRVlZcXhP?=
 =?utf-8?B?UjFoLzBrcEF2SS8vUDJyaVU5Mi9hQklKZFpPOEpuYjV2VXYwZGhKeEYrb2ww?=
 =?utf-8?Q?amr6cs7AkCD67f/5xR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f323fe9-5c87-4129-6721-08deb64ac9a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:35:46.3013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEDRbwyyspG897iYav0AG5VQQUvWx3r4vY1UNSVWfkMeJQInuT6E7A+Ei7U76z6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
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

Hi Vitaly,

On 5/20/26 03:55, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add lockdep annotations to teach lockdep the correct lock hierarchy
> and catch ordering violations during development. This follows the
> pattern established by dma-resv in drivers/dma-buf/dma-resv.c.
> 
> Lock ordering hierarchy (outermost to innermost):

> 1. reset_domain->sem - GPU reset synchronization
> 2. reset_lock - Reset control mutex
> 3. notifier_lock - MMU notifier synchronization
> 4. vram_mgr->lock - VRAM memory allocator
> 5. srbm_mutex - SRBM register access
> 6. grbm_idx_mutex - GRBM index register access
> 7. mmio_idx_lock - MMIO index access (spinlock)

You probably need to update the commit message, the code comment has more entries than that.

> 
> The implementation provides:
> - Lock ordering training at module init (amdgpu_lockdep_init)
> - Lock class association for real driver locks (amdgpu_lockdep_set_class)
> 
> Requires CONFIG_PROVE_LOCKING=y to activate.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: I1ff16ea256214d5599888e87d2320f24948d4f31
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 175 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h |  39 +++++
>  6 files changed, 222 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee3574797bc2..ba80542ead9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -69,7 +69,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0408476f1070..e276508ec704 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -105,6 +105,7 @@
>  #include "amdgpu_mca.h"
>  #include "amdgpu_aca.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_lockdep.h"
>  #include "amdgpu_cper.h"
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ccbe6c885cf..159882f5fdab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3739,6 +3739,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->pm.stable_pstate_ctx_lock);
>  	mutex_init(&adev->benchmark_mutex);
>  	mutex_init(&adev->gfx.reset_sem_mutex);
> +
> +	/* Associate locks with lockdep classes for ordering validation */
> +	amdgpu_lockdep_set_class(adev);
>  	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
>  	mutex_init(&adev->enforce_isolation_mutex);
>  	for (i = 0; i < MAX_XCP; ++i) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4d4d21babc61..0df6b2a3afdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3159,6 +3159,9 @@ static int __init amdgpu_init(void)
>  {
>  	int r;
>  
> +	/* Train lockdep on correct lock ordering */
> +	amdgpu_lockdep_init();
> +
>  	r = amdgpu_sync_init();
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> new file mode 100644
> index 000000000000..55e99ed1e677
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Lockdep annotation for AMDGPU lock ordering
> + *
> + * This module teaches lockdep the correct lock ordering to catch
> + * potential deadlocks at development time rather than runtime.
> + *
> + * Based on dma-resv lockdep approach from:
> + * drivers/dma-buf/dma-resv.c:dma_resv_lockdep()
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_reset.h"
> +
> +#ifdef CONFIG_LOCKDEP
> +
> +/* Lock class keys for associating with real driver locks */
> +static struct lock_class_key amdgpu_userq_sch_mutex_key;
> +static struct lock_class_key amdgpu_userq_mutex_key;
> +static struct lock_class_key amdgpu_reset_sem_key;
> +static struct lock_class_key amdgpu_notifier_lock_key;
> +static struct lock_class_key amdgpu_srbm_lock_key;
> +static struct lock_class_key amdgpu_grbm_lock_key;
> +static struct lock_class_key amdgpu_mmio_lock_key;
> +
> +/**
> + * amdgpu_lockdep_set_class - Associate lock class keys with real locks
> + * @adev: AMDGPU device
> + *
> + * Call during device init to associate lock classes with actual locks
> + * so lockdep can track them properly.
> + */
> +void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
> +{
> +	lockdep_set_class(&adev->gfx.userq_sch_mutex,
> +			  &amdgpu_userq_sch_mutex_key);
> +	lockdep_set_class(&adev->srbm_mutex, &amdgpu_srbm_lock_key);
> +	lockdep_set_class(&adev->grbm_idx_mutex, &amdgpu_grbm_lock_key);
> +	lockdep_set_class(&adev->mmio_idx_lock, &amdgpu_mmio_lock_key);
> +	lockdep_set_class(&adev->notifier_lock, &amdgpu_notifier_lock_key);
> +
> +	if (adev->reset_domain)
> +		lockdep_set_class(&adev->reset_domain->sem,
> +				  &amdgpu_reset_sem_key);
> +}
> +
> +/**
> + * amdgpu_lockdep_init - Teach lockdep the correct lock ordering
> + *
> + * Instantiates dummy objects and takes locks in the correct order to
> + * train lockdep. This helps catch lock ordering violations during
> + * development.
> + *
> + * Lock ordering hierarchy (outermost to innermost):
> + *
> + * 1. userq_sch_mutex     - Global userq scheduler (enforce_isolation)
> + * 2. userq_mutex         - Per-context userq (held across queue create/destroy)
> + * 3. reset_domain->sem   - GPU reset synchronization
> + * 4. reset_lock          - Reset control lock


> + * 5. notifier_lock       - MMU notifier lock
> + * 6. vram_lock           - VRAM allocator lock

Those two should come before the reset lock.

> + * 7. srbm_mutex          - SRBM register access
> + * 8. grbm_idx_mutex      - GRBM index access
> + * 9. mmio_idx_lock       - MMIO index access (spinlock)
> + *
> + * Evidence:
> + * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
> + *   amdgpu_userq_stop_sched_for_enforce_isolation() which takes userq_mutex
> + * - userq_mutex -> reset_domain->sem: amdgpu_userq_create() holds
> + *   userq_mutex (via ensure_ev_fence) then takes reset_domain->sem
> + * - reset_domain->sem -> notifier_lock: reset path can trigger HMM

That would be extremely bad because HMM can wait for the reset path. Where do you see that?

> + *   invalidation
> + *
> + * Note: mmap_lock ordering relative to GPU locks is already taught
> + * by dma-resv (drivers/dma-buf/dma-resv.c).
> + */
> +int amdgpu_lockdep_init(void)
> +{
> +	struct amdgpu_reset_domain *reset_domain = NULL;
> +	struct amdgpu_reset_control reset_ctl;
> +	struct mutex userq_sch_mutex;
> +	struct mutex userq_mutex;
> +	struct mutex notifier_lock;
> +	struct mutex vram_lock;
> +	struct mutex srbm_mutex;
> +	struct mutex grbm_idx_mutex;
> +	spinlock_t mmio_idx_lock;
> +	unsigned long flags;
> +
> +	/*
> +	 * Initialize dummy reset domain
> +	 */
> +	reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
> +							"lockdep_test");
> +	if (!reset_domain)
> +		return -ENOMEM;
> +
> +	/* Initialize dummy locks */
> +	mutex_init(&userq_sch_mutex);
> +	mutex_init(&userq_mutex);
> +	mutex_init(&reset_ctl.reset_lock);
> +	mutex_init(&notifier_lock);
> +	mutex_init(&vram_lock);
> +	mutex_init(&srbm_mutex);
> +	mutex_init(&grbm_idx_mutex);
> +	spin_lock_init(&mmio_idx_lock);

Don't you need to associate those with the lockdep classes somehow?

Apart from that looks really good to me.

Regards,
Christian.

> +
> +	/*
> +	 * Take locks in the correct order to train lockdep.
> +	 * This establishes the dependency chain.
> +	 */
> +
> +	/* Level 1: Global userq scheduler mutex (outermost) */
> +	mutex_lock(&userq_sch_mutex);
> +
> +	/* Level 2: Per-context userq mutex */
> +	mutex_lock(&userq_mutex);
> +
> +	/* Level 3: Reset domain semaphore */
> +	down_read(&reset_domain->sem);
> +
> +	/* Level 4: Reset control lock */
> +	mutex_lock(&reset_ctl.reset_lock);
> +
> +	/*
> +	 * Mark potential memory reclaim boundary.
> +	 * GPU operations might trigger memory allocation/reclaim.
> +	 */
> +	fs_reclaim_acquire(GFP_KERNEL);
> +
> +	/* Level 5: Notifier lock */
> +	mutex_lock(&notifier_lock);
> +
> +	/* Level 6: VRAM allocator lock */
> +	mutex_lock(&vram_lock);
> +
> +	/* Level 7: SRBM register access */
> +	mutex_lock(&srbm_mutex);
> +
> +	/* Level 8: GRBM index access */
> +	mutex_lock(&grbm_idx_mutex);
> +
> +	/* Level 9: MMIO index access (innermost lock, spinlock) */
> +	spin_lock_irqsave(&mmio_idx_lock, flags);
> +
> +	/*
> +	 * All locks acquired in order.
> +	 * Lockdep has now learned the valid dependency chain.
> +	 */
> +
> +	/* Release in reverse order */
> +	spin_unlock_irqrestore(&mmio_idx_lock, flags);
> +	mutex_unlock(&grbm_idx_mutex);
> +	mutex_unlock(&srbm_mutex);
> +	mutex_unlock(&vram_lock);
> +	mutex_unlock(&notifier_lock);
> +
> +	fs_reclaim_release(GFP_KERNEL);
> +
> +	mutex_unlock(&reset_ctl.reset_lock);
> +	up_read(&reset_domain->sem);
> +	mutex_unlock(&userq_mutex);
> +	mutex_unlock(&userq_sch_mutex);
> +
> +	/* Cleanup */
> +	amdgpu_reset_put_reset_domain(reset_domain);
> +
> +	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_LOCKDEP */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> new file mode 100644
> index 000000000000..04adb58665bf
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Lockdep annotation interface for AMDGPU
> + */
> +
> +#ifndef __AMDGPU_LOCKDEP_H__
> +#define __AMDGPU_LOCKDEP_H__
> +
> +#include <linux/lockdep.h>
> +
> +struct amdgpu_device;
> +
> +#ifdef CONFIG_LOCKDEP
> +
> +/**
> + * amdgpu_lockdep_init - Train lockdep on correct lock ordering
> + *
> + * Call once during module init to establish the lock dependency chain.
> + */
> +int amdgpu_lockdep_init(void);
> +
> +/**
> + * amdgpu_lockdep_set_class - Associate lock class keys with real locks
> + * @adev: AMDGPU device
> + *
> + * Call during device init to associate lock classes with actual locks.
> + */
> +void amdgpu_lockdep_set_class(struct amdgpu_device *adev);
> +
> +#else /* !CONFIG_LOCKDEP */
> +
> +static inline int amdgpu_lockdep_init(void) { return 0; }
> +static inline void amdgpu_lockdep_set_class(struct amdgpu_device *adev) {}
> +
> +#endif /* CONFIG_LOCKDEP */
> +
> +#endif /* __AMDGPU_LOCKDEP_H__ */

