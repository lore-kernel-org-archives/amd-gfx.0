Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC90CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 15:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D9A10F6EB;
	Thu,  1 Oct 2026 15:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07Ojr5it";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622CD10F6EB
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 15:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A56ozhqRYnl1i0X6y7VQqN0HUAOsi9aGGNK00ezyImLW6e1Yb3t00hwKbZR81rglAF50gmPmFXI6cpqnr2IR1Om+mLVn5Q4O3dJs/YW3zC+cziuBRHO+GasE2HaHFYy/pgIxQPwrzhE1irUlcJ0k+sArybj7vAAZ+QVrbMXxANAIs50P/OSdk78uKVwbSSprnRjoy2nfEb7BL88tmpbhiOiWuNXFKt4dcft/ykmbbZPdm/Bn8kEAP/tRlwa1a0Phc8w3jhlFRxG95yQgHxQNKmueqvhOm05GZEc7GWiw536vZKUxMlwJ8XHOYwDCo0kHtWqxLMK+IMDWDTCkG3rEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSQuWEBBJ8BJu0YeHZ7mPjp9JQEXfgcAHWpFNusR7aI=;
 b=fijXUxt6YOZQhWGpSwAptgLx04mzuN4hcewNndKuexn4sYQXaQAZnwaJ3QCuIP3dCMsfxV1N87yEeZABAiXcoyeobcp6PB93/q0E56LmgN5J0Bpr8Nc2MZ7Mssgl2rYf0gOePTL2qtoPDMJKMUGzg2PePOU5ZE79pwOU5SJwhIXch/rZg7Q8M8gRCiw2vtNbDhjFk3NEOUvQBrdqS7UmdHjBuVybYuv7eCdlI/RZGYTmHE8zFFW6weUBZ8/mHnqb9I+QLEHUZaYEae2ECpnIYOCLU29H90c8eVcEf/NKCEh0I2LMZCKl+WketpqcWTSHw38erTDk2RoYHNDsJybj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSQuWEBBJ8BJu0YeHZ7mPjp9JQEXfgcAHWpFNusR7aI=;
 b=07Ojr5itFFBo9m18+0gM+dSqAHsAuknV4Cz5aYZsuTPjIIUaPcYSvM9MtxKh26x1t8vFnVLP9EZqi4jcdASWUJScBEqS0ow26khJHf4SHlM3EZPwG1a5gPNtD/KUyczJYD5vtS2ZSHgSL/yhuQyB5ZUv4h4H3fgpjkD7tf07b04=
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 15:19:34 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::76) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:19:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:19:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:19:32 -0500
Received: from [10.4.45.161] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 10:19:32 -0500
Message-ID: <3a53ec99-50db-4434-9a83-eedf454a187b@amd.com>
Date: Thu, 1 Oct 2026 11:19:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: serialize vblank counter reads against GPU
 reset
To: <vitaly.prosyak@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>
References: <20261001005114.115268-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261001005114.115268-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: df42a220-dbad-4db2-fc84-08df1fcf65cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|42112799006|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MY7Zuev1auI4bA1TMY7hA6T+FxNyWo7zG8R2R1zE2C35eyLhlTp3efCUoZIMZPxR0PoaTG6iX8GUSkOEhMOp8+wyfk9kumv003gfBheulKNKLq3ca0veNLVefd5beiyAa7yDL1oJbmxq2LFroWVaWv9CO75gwGN3y201KJsryh4MAvlTcCmzU6HSf49LMQs8eu7HrisG02n77KNj8dGAS6ouel8zdWeHZ3rG4xYvtU/hlXoE/dnzCqsD+XPRgXmL/4BJuam/uz2MK//a8+LEUUQ3tCAvn6SENNR7jrtwCRXoio2NuFyBMOVwDZJPNZzbytakR0lEGOpGxZx5hfFfyDz9dhF3dEcQEaVosFfy9XQnB0RF7xxBMu7D4d+AKEVW6muhafSJ9uaorj8KFOp1Nr/2fgyj/SnvXJgizRDpcpH+dJucIR+FOrZDgA9D52dYSyrm9SXZDWfNZThH4oNJA/wgJwI187f0vzxN6bcEnd6+8PCJLXmvv3P01ykAllM6eR8Q3OXz4LDt7GnNtqH9616ShpUX7lXxEmVy7m6IFpSDSrmktsV4KW41L8/qIKvZXmdjcmP6oM+Sn9Iyc4zkpa7m0OuyBoSSJTqIV3vmF46wIbSLL2CkAAkIFBDhX/8c0OL9JNLW7JUM7TGdXNaG6hT3oGDzgSuOkesC3zNuJZfk9BtY+QwRRrq8k+mw4J/9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(42112799006)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ji2J/JTVNBwNLZazIgidXPgMoo76ECOUxCHxdsby6EqxRik4JtzHpktGDvuvkPYoWoLzht/7qW+ZdQWnn5dfgF4+dkryuUeG/nH0fWFPn4yIvaZBTRhlhjnA2QY3SToRf9xbXID92MKPs0e5hehQgdTdQXbTmDOmAShvShhoAfKnHV3py2hZOHCllXy0ogPj44sOr48Csf0oVjXKfbG6W+iTPv731HYcuxxE4iC8BfT46BIYN0m4Jcu+kxtuFM9aCe5fydEOM2kb0jclcuNbj9az2TeflTklMoQDX/mVGLm8BVYq6doLAU1wO2yfqpLzBZG7DEZ/sfSoM2goSYrKulC1ok6gO3jdyNTwZV6o7OR4Z8Hjmae1d/2z4jBs2bdNQgbaAh7Drek3TWV2oAJt9C12jmYSl09WwcLeLkurD3c46c8fSFkgSy/uT3yK2rGK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:19:33.5262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df42a220-dbad-4db2-fc84-08df1fcf65cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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



On 2026-09-30 20:51, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The vblank counter callback reads display registers and scanout
> position without holding reset_domain->sem. During GPU recovery,
> display commit work can call the callback while reset owns the
> semaphore for writing. The hardware access then triggers the
> lockdep_assert_held() in amdgpu_device_skip_hw_access() and sets
> TAINT_WARN when lockdep is enabled.
> 
> Try to acquire the reset semaphore for reading before accessing the
> hardware, and hold it across the counter and scanout-position reads.
> If reset is already in progress, return DRM's cached software vblank
> count instead. This avoids blocking behind reset and avoids accessing
> display hardware while it is being reset.
> 
> The cached count is less accurate than the hardware count, but is
> used only when reset prevents a safe hardware read. This addresses
> the reset-time warning from this vblank path; it does not suppress or
> fix unrelated lockdep warnings.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Sunpeng Li <sunpeng.li@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index bac072d73e16..f34150d20a2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -30,6 +30,7 @@
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_vblank.h>
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
>  #include "atom.h"
> @@ -1669,6 +1670,9 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  		DRM_ERROR("Invalid crtc %u\n", pipe);
>  		return -EINVAL;
>  	}
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return drm_crtc_vblank_count(crtc);
> +
>  
>  	/* The hw increments its frame counter at start of vsync, not at start
>  	 * of vblank, as is required by DRM core vblank counter handling.
> @@ -1714,6 +1718,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
>  		DRM_DEBUG_VBL("NULL mode info! Returned count may be wrong.\n");
>  	}
>  
> +	up_read(&adev->reset_domain->sem);
>  	return count;
>  }
>  

