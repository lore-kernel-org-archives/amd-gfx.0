Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A513C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178EA10F07A;
	Wed, 15 Jul 2026 13:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LhB4Qbqh";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4636310F07A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVpV4mE6K5htihVho/6+y4cKzDg6Aab4/tHvaaMxWU1R6e9wh4fte1USy/0pSsuGZQ+JiGLnV/pBKL4x1xH8vKpMfqean30ytpihy1MFDnMFSLzCUDXY434RmT5qPX47ad25Iph+CwtbLDaEuZ5Dwd5XsNqe3SHYCUM9/m9p2MkpdmlbHr5JC6ZthaF8awV5vv/3ks2QjBSGsuyLRj5YANCrHI6zpAWyyWHAwtj6gPwPdnotVktzxNCTAawBOy9OXdxoP9FYzcqH5+C52fpJToWIZWp5bgYr4tkt4clgvVB8vNNPBUK26pT00qtyQuZK4SwEcC05J1Qdbs6+QEzDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h985n7AhhSnuG3hmhDD4eRybJ3KffUWaoWWbBP2gIiY=;
 b=wiUicIonZ8INdE7u/R9+0zrNDp3LhJbMbWuHn1t517cUwAil2sGPjVZ0psjgcHEtlDQww0sxniCuCNZsqiqO2jNiBAXyR+Z1zvWeO9kwg7dI1+2UjjSEb0At38upnaGqo/YCUJ/mu02S7qE1VsXRI9V59R6Db8WQ11I3a0Mo2zEj5uaUOjo4AedCYVJWkHDh0YjCk6+jX4mo3YZvAgKoMrs5shYjdryVc6sMmhf/gsPxYfNmHXkg/+HNUDlseo2wD+jCGWaY6RNmsgPD3Xu45re263OhkaEL2sKZiwl5/jH2zTxz0kqI7GWo5JZFDE/4WyVqSLXpbNzVos0ZMErTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h985n7AhhSnuG3hmhDD4eRybJ3KffUWaoWWbBP2gIiY=;
 b=LhB4Qbqhqeij7Tlrp4ZFeNJIjZ3fEU2/0o5DzzsEDmxjdadnpIoeFffF0uACXBmvVoqifPDFqg/vvqNjZKaA1P4JvAcuOSJq0jCdIzVo97iJQt3HGAUwZZeIOi5bgU0w64SUGtkdZ3ceSBw1K/10rDxlidTfvmBIfmiXhXxFLD4=
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:46:03 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:03 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:50 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 15/70] drm/amd/display: Replace amdgpu_dm_kunit_helpers.h with
 dm_helpers.h
Date: Wed, 15 Jul 2026 21:37:25 +0800
Message-ID: <20260715134432.1975118-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 473c7d0a-6211-4dee-aee9-08dee27769ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: vAVuxIJ2wky08th0GHpu1NITzz05Do3fhtNggCXg4wSAi9v42V3oq5sHQxQcDmpns+BPUdEJq5vDj723sYE21pFvVc55z7qXZHlwUxmJuge0Rw1Kxh55SEeviR31jiFpqNz/NnC7Yu022O4F0rItpU8xnFDveCOrl6ZY98fl18+t8tTVtVTyieM8ebQDnTyicvIOZY83eZyTT9Oe8DRB6EgVIII9ww5o/2gw9xiWr2DXpuk7pGHEKOLRW+Lu5dTEmzJ5suCbW+U0zb6kfWVHMJTGiIp3RGVqYBMU7T0GlqJanjtLtM5HfrJwGUhbtqqZnEmsjc+Ve5ooAUfbc0GwKhCNcJ2NE9kbJiJNps6dj53beYqTEkR47k9zX2fF8iLHULIb3RWrOiIVZSsEoZGdu22LMXhkR2VJhNeYlWKYJJl+pTLs+bTArQCj+uE/aHgpibDllBGPz8XJDtWF1IArF+Va9qeD1yf5exSW2vaV4ySWGpD41kEIHWCH1bIKx24sb/Z0w0T+7qGv1M00YkRSo7yi5PjwK/lrIyXhXK4rGGNc2wIpuxkSMP0c1/m3URDvlZHZ5FajiBKRMQAQwYMpL5sE0DmS09E03adV1RJXbxez0dfPrxdTDSD29CDb/UokELPqCkh7FPFeY8INb8JHQEQ6YtU2z1ah/axst8jgJkaxH5pNECx9a0k3qkZNuqqu+Eu0psZBW6HrNO0YitWN6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wIo9WKKav3wnFM147flxNOd8GeL9YwNQvBeqsShoVb20N4lKX40EKSYswvR33ZOMw/alDliQxueq8vWR8Fmx2c3XNuZDLQvWyYSvpWvmZflxCT2+m0eiIrAVYGUphOWRpm6WU9hUYGIO+eQd6H3xwmr/rOHbRTJaMqdQSNdmw7yKNDI94E6SrfAHWI7xbNmD45WTA/y6ZEHwiEh5/Uj9QiiDNjF4cC9KD6BuTiz8eylu8fuaN9D89JNw1sKHAXnOziYkp6O2AfTGfS7guRyTkSgL+c/SsBmpu6vU3xXYnfnRsSVBe86n9ZegVcza8skB6/Btvny2rpud1QKJsnUT5OamzXal8oTICw2h9GFvxcMGPz3ObPxSJAjz1cuJBh2uex+6hY/aM7kWA9bUm0lLMwhUvnxwpzE8cNNB8b+ZhdCwrjZB+bxaKyfx9B4ihF/z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:03.4997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 473c7d0a-6211-4dee-aee9-08dee27769ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Drop the amdgpu_dm_kunit_helpers.h include across the amdgpu_dm source
files and use dm_helpers.h instead

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  1 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  1 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  2 +-
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       | 20 -------------------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   | 11 ++++++++++
 drivers/gpu/drm/amd/display/dc/os_types.h     | 10 ++++++++++
 24 files changed, 37 insertions(+), 41 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f3ac4307eb5a..cb10c5fa374e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -70,7 +70,6 @@
 #include "amdgpu_dm_audio.h"
 #include "amdgpu_dm_dmub.h"
 #include "amdgpu_dm_connector.h"
-#include "amdgpu_dm_kunit_helpers.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 7bba82ce2182..fb0ff9c9c823 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -26,7 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_audio.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "dc.h"
 
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 373ef4d217f1..43bf6cccb9ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -47,7 +47,7 @@
 
 #include "amdgpu_dm_trace.h"
 #include "amd_shared.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 				     int bl_idx)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 77e0480d469d..bcb2cee8c6e8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -33,7 +33,7 @@
 #include "amdgpu_dm_colorop.h"
 #include "dc.h"
 #include "modules/color/color_gamma.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 0301cb333770..eb4a4722d50f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -31,7 +31,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_dm_colorop.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "dc.h"
 
 const u64 amdgpu_dm_supported_degam_tfs =
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 56e3e32c184f..c7d8810958f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -42,7 +42,6 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_connector.h"
-#include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_wb.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 47fd849c58a1..1f9528364e53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -33,7 +33,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 static const char *const pipe_crc_sources[] = {
 	"none",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 81574e447728..ec863b9f4466 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -34,7 +34,7 @@
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "modules/inc/mod_power.h"
 
 #define HPD_DETECTION_PERIOD_uS 2000000
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 21f6a01840ef..7a60b29e021c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -38,7 +38,7 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_dmub.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include <linux/component.h>
 #include <linux/firmware.h>
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 9a2d2706deb0..f25783bf1b48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -31,7 +31,6 @@
 #include "dm_helpers.h"
 #include <drm/display/drm_hdcp_helper.h>
 #include "hdcp_psp.h"
-#include "amdgpu_dm_kunit_helpers.h"
 
 /*
  * If the SRM version being loaded is less than or equal to the
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c59da4f447fc..c172bb76bcda 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -48,7 +48,6 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 #include "clk_mgr.h"
-#include "amdgpu_dm_kunit_helpers.h"
 #include "amdgpu_dm_helpers.h"
 
 #define MCCS_DEST_ADDR (0x6E >> 1)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 087401f7a8e4..e6e2b19e09e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -33,7 +33,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_irq.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a9575bf25fc2..4e57572e12b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -32,7 +32,7 @@
 #include "amdgpu_dm_ism.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_trace.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
deleted file mode 100644
index 1f910a6a00c0..000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Copyright 2026 Advanced Micro Devices, Inc.
- */
-
-#ifndef AMDGPU_DM_KUNIT_HELPERS_H
-#define AMDGPU_DM_KUNIT_HELPERS_H
-
-#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-#define STATIC_IFN_KUNIT
-#define INLINE_IFN_KUNIT inline
-#define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
-
-#else
-#define STATIC_IFN_KUNIT static
-#define INLINE_IFN_KUNIT
-#define EXPORT_IF_KUNIT(symbol)
-#endif
-
-#endif /* AMDGPU_DM_KUNIT_HELPERS_H */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index a7679675dd32..18ef0e875179 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -40,7 +40,6 @@
 
 #include "dc.h"
 #include "dm_helpers.h"
-#include "amdgpu_dm_kunit_helpers.h"
 
 #include "ddc_service_types.h"
 #include "dpcd_defs.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 4ffbe2dbdf97..c67d068b9a5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -37,7 +37,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_plane.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "amdgpu_dm_colorop.h"
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 0d2e5294d062..8431e164a0db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -33,7 +33,7 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "dm_pp_smu.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "amdgpu_dm_pp_smu.h"
 
 STATIC_IFN_KUNIT void build_pm_display_cfg(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f87de3d18ac0..dbad0a6d3a2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -30,7 +30,7 @@
 #include "dc.h"
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 STATIC_IFN_KUNIT
 bool link_supports_psrsu(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
index cf28d50c3b5e..0a7602ed70b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
@@ -28,7 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 struct amdgpu_dm_quirks {
 	bool aux_hpd_discon;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 42e17119461d..ee2e4754b089 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -31,7 +31,7 @@
 #include "modules/power/power_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "dc/inc/link_service.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 6c0464754ed8..dbdda6ed12d4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -36,7 +36,7 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_trace.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 
 	unsigned long long
 	dm_get_elapse_time_in_ns(struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 9e7bad4d6ed0..a7594012a0b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -29,7 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_wb.h"
-#include "amdgpu_dm_kunit_helpers.h"
+#include "dm_helpers.h"
 #include "amdgpu_display.h"
 #include "dc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 63704d21a0b5..f5252931ce35 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -192,6 +192,17 @@ void dm_helpers_mccs_vcp_set(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#define STATIC_IFN_KUNIT
+#define INLINE_IFN_KUNIT inline
+#define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
+
+#else
+#define STATIC_IFN_KUNIT static
+#define INLINE_IFN_KUNIT
+#define EXPORT_IF_KUNIT(symbol)
+#endif
+
 bool dm_helpers_dp_handle_test_pattern_request(
 		struct dc_context *ctx,
 		const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 6af831710489..538d00105738 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -57,6 +57,16 @@
 #include "amdgpu_dm/dc_fpu.h"
 #endif /* CONFIG_DRM_AMD_DC_FP */
 
+
+/*
+ * On Linux this is provided by <linux/kconfig.h> and evaluates Kconfig
+ * options for both built-in (=y) and module (=m) cases. Windows has no
+ * Kconfig, so config options are never set here and this always yields 0.
+ */
+#ifndef IS_ENABLED
+#define IS_ENABLED(option) 0
+#endif
+
 /*
  *
  * general debug capabilities
-- 
2.43.0

