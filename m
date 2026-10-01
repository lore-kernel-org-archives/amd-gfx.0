Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB410CA5FC4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 00:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4105610E2C6;
	Thu,  1 Oct 2026 00:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IoEIotsB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33FA10E2C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 00:51:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD/LOOrBChdY3RdjtRJavHd+na+IH3i85Z6dXpxBjVXWcZ9zaBnC8hgDVjycZXU7sj0B+DxbNw7elcPLwhZeuKFLdPuyNugWBWgaoFHnQ3t+q4weCwsLf9oW5qIf+HMm7EtPUpA9N2QZjFFZtaBBultvxZEvD2nBsS+CTo+FsQrsMbGV8npLsMqZNmEyj7xOYZjEYzxWVZ1qHpnT6KrDd1Y+KFQ8aOflEaRl0MepwqPUaPNK7gSrqAS5EkpBaQw1EPClRGr0HFRwcGJ4x/qvc9t6vhxUXMDLMGJkd0iKSVJyPckZ74ZTsXQAUTUAicUnu0z3JPatB/K3T2mGt9t8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qooiF9pYXWmgaZVKMHrdzMMCF07VXwa2W1TWWkqwfc=;
 b=kM6VU7d6PcFuciyjRueuXzr3V0lq9WDkvekbAgQcP2e3DFXEodS4pq49hS7hrHv+LYuCUsgOhHHgARor9VIhCF7hbYc23XJzcTvKbkhI9imF0Zn+DIJs3LdWEa+NhiCkf10SKquRvyx6L6GZOC7LpCu9TPN4+bzymm700LFQZCYiMu0MbPi6BovA6YyVeBWHPmiX+G+f2SELER/x6gHboCewZfJLHQB+JQ//XBWMDsK0XXPxowLXL580zb1cP/BavYqptWEVxEginQVFrd1Q4J6pNVjJ8+eLNvO1rJyZrz7cG0rB9U0Ht1HT5w0U8y90VHa5WySwXNPsyy91pVNK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qooiF9pYXWmgaZVKMHrdzMMCF07VXwa2W1TWWkqwfc=;
 b=IoEIotsB9cn1J9oyo+A7kLpnc83JnATrROeBQV7XounA5dyx1itIfzmRcmktVVT/2rgOPJ9sr8jkPRTV8s3js/1lb/AI7KZldbU/tekuKcxOX2JKKEpgdPzI9doy01TJRBXcwzDuQPjvk5euwoNJ1hoFno3od+N2TIjh696UWb8=
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 00:51:24 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::2a) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Thu, 1
 Oct 2026 00:51:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 00:51:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 19:51:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 19:51:21 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 19:51:21 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Sunpeng
 Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amdgpu: serialize vblank counter reads against GPU reset
Date: Wed, 30 Sep 2026 20:51:03 -0400
Message-ID: <20261001005114.115268-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 44487b74-1c32-4c90-761a-08df1f561d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 6foyLjV/V5tnhDMqDMSX+UIlchjg3YV8zoxXg9BQ8/p9mUbFaY0u8SvSEfmKAzO9ituPHqLeY3f/GNWMFCxDw4Dj1EJWpEnV8Q2xeCQaTmnexTwIR3G1n5mNG72dZ6rHG/nwEn1fkiy7tx/qazlXPZRMXk1r5l1pV72Iot9BmWBTcTqwNbocABlzarUtnN5XqfcZoC5YklIqjo2NrIkZwEJHSLrvMMjfFV4kOGdH1N8VSj1YG+uveHhhZkA5FRkRaT4EN9YcxQujvNamlgDkoUohAaXMTkf5vCgzrk1qRB7EvFE5Dt8fTzWVYxdBrrMhwe60HZ87E7BxOHgffLpZg7rhEVyemR4/MenQNFeTbWpKXwXiHKD3T6o/A48DcjMZaAXM8a39kPzvuKt+/pHMOdz0ZvNvXHPgVzv0I2fbS4kBHGpr6VXj4m9c7ndMaF4USVlznonp9eLLxO3JMbX0CaIi7XYC2SzY6nftNJIvdstIfFYfLgu8IE9MLgOWTc2jVxUL4ZecqBLDzVGhI8XofB0tgh5Zg1WcHRFe5i4oJpHcYRYJApPNVJmCCtqtBlFguKEfmHrMgCRGsK89MwkApgWrvkPNXp609YCXYKU4mDkcpHig2SWUhMfo/lRQLsHumB+inv0u9RRyyEvjibb0eV+s7BIhCMC2cb+E84P380U2VRADPW/CSpRyLEsX/md9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mP4lCou/I8tsvJOW7o8BDtRuZXTLFraTaYCihDX5yp8/qfU5CoXZ0VLVzp4xgTOFvFJi+raS9lVLJwQXxWKG23N6euXuuM/i6CeSYnN2yt99Q3/ZgwItMwwUpVRvla4A6v53kaBvXl8LRQ9Y1oB/Sb7P5IKN2H0/Dt6ThFpigcH5m/feZtpnvCaKoAQ8LJdRZe/ANu9iNORrx+lGWsD5uGJbohaevSRdHSH3T0EEVSgeoY7rcS7EQVgHLJOkyYJ6JN7L9fx9CxfiNEEzGhchhW3kfsXYjkonZS8HTIMiRq4Xpe+6p5ozTWqAh6wIRJibbJwFBk1UsvUwJrb7VVRd7ywHpCE8NzHAJOpjqiVaeY8CaB4rHMhPT5SCpOCy2ce1AJIWHDWgR+92WxRuQRCIbEyiKDsiKI1p7+tJgbx9gVwm5ha0dtt/mIogzBTzXDHo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:51:22.9331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44487b74-1c32-4c90-761a-08df1f561d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The vblank counter callback reads display registers and scanout
position without holding reset_domain->sem. During GPU recovery,
display commit work can call the callback while reset owns the
semaphore for writing. The hardware access then triggers the
lockdep_assert_held() in amdgpu_device_skip_hw_access() and sets
TAINT_WARN when lockdep is enabled.

Try to acquire the reset semaphore for reading before accessing the
hardware, and hold it across the counter and scanout-position reads.
If reset is already in progress, return DRM's cached software vblank
count instead. This avoids blocking behind reset and avoids accessing
display hardware while it is being reset.

The cached count is less accurate than the hardware count, but is
used only when reset prevents a safe hardware read. This addresses
the reset-time warning from this vblank path; it does not suppress or
fix unrelated lockdep warnings.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Sunpeng Li <sunpeng.li@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bac072d73e16..f34150d20a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -30,6 +30,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_vblank.h>
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
 #include "atom.h"
@@ -1669,6 +1670,9 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 		DRM_ERROR("Invalid crtc %u\n", pipe);
 		return -EINVAL;
 	}
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return drm_crtc_vblank_count(crtc);
+
 
 	/* The hw increments its frame counter at start of vsync, not at start
 	 * of vblank, as is required by DRM core vblank counter handling.
@@ -1714,6 +1718,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 		DRM_DEBUG_VBL("NULL mode info! Returned count may be wrong.\n");
 	}
 
+	up_read(&adev->reset_domain->sem);
 	return count;
 }
 
-- 
2.43.0

