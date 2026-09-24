Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532F7C98327
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1386C10F737;
	Thu, 24 Sep 2026 18:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcyAvFqQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B7510F726
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twkWa92T4tnTnQ/feElmqFG5Kz+5MnCW74oXotaL3V+cnyzH+oHhS4hZbPyW8NryUu1dlfFwqB83+D47dZ3RNOI+eSZGRFOnSqa1BefhB0Csbuke8eWOpQpZxHhWZ4wWVv9L9eKzL5uLzsKNDXpwipgrf7nBOHh4H32xgud9/97TrbsB07EK+IwI9VZ2xll03cQiNnypCF+cdTymIS3xgLUOOMrMU9qSap8xXPgd3CEyqbHFfDt6albGTu/vxApeGFkUna9cUtrDoxibbmE6GM8VSC8vNufNpriiG0P0U/EAZkl3uXkMY9z4tmyLJOWbcwSU6mM2tenK/MQ9tkt7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF7goFmc/vhMtSVJM71DlUKJbbB75k0xwOMANyPV13E=;
 b=bVpyT7a3bMXZmYxjLVL7Gbhh37PU8ANWD0inNNFhQjgeqEsQYO4LwPdwHQTCSUgclJSOOAPEb/rJl67FBmfCccmOQIWuSL3lTyDcBE1qp5SYkSzpHj0tJ6hsS4roX9rgh5Zo5yjX7/CHuFVihdOQbLnSmeDPGdYLchezruGEixGh5TpE6NFiv3N6ZFKlbcDFHTryPND3zzeA7g0hdLQ9AkOcNX73EbO7m+AuPXkx5OHLlJVCLsa37z0hTr6kWA/uwaUAG5A+MrHCjI0OjHg/kecDRzKwBTCyUPf+uylB9/uxFdFN9Itj+59SrcmvCultJO1qZhKO8vnU8Sx8Volt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF7goFmc/vhMtSVJM71DlUKJbbB75k0xwOMANyPV13E=;
 b=DcyAvFqQr6u3rAgPBVy1VrSJL7S9KL8PLPNjX4zM2sJQH+n8fHBWcxwKARay1dbMjkNq8B+uZujY7h5ClHTeGu0E+o1dqqEYnkhMNKP8HDZSyBxfWcXP+o0cgpemDr9SpF61pwJRAB1mhKeI29jt1+bAG94wGWWaoNpaAWtLWDk=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 18:46:19 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1d) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:19 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:07 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 09/34] drm/amd/display: Keep public DC lifecycle APIs stable
 beside Core 2
Date: Thu, 24 Sep 2026 14:45:22 -0400
Message-ID: <20260924184824.596894-10-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aecfdae-0a4a-4ea6-e835-08df1a6c1f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BBVpmFVAcTMRKqTXVliWDoe4xM1ZXM9+wN577z3Il2Ayj8n3GR012EEUVVAq5gMZXJuaemOBvC45rrWij0trp+yH+ZjUTiAUmZAQhlaGc6A0v63oZe/l4mjh03YKQoTytEdMgM5frl41Ou5XmtiPqKbfD3dcH6VDpzWm3D9nGPTQIqakWm027PkTr3ATAHcl8smrdbEw0FwWQjwjRkEXCIyRPPocTT7YUGX72ZufVz+0641P3Z1HgZ5MNGmb5w97SoEPqz7A/slQEH1U4KT3whWFxPXzKApHLBbQ/y81zUbI3qJk+1NpvYxBeYdXTwWoarVk2cRLxyvJsXKWJKQxVKQqpcrrjMP3gxKa1y5od7xGn8t8H/9BJPSGKZyuD82zMCEUv5IMcC6/kJ4ZfQMO7MS+Oyx3BwTp7OsjDYsFchjwvda8WnBfUQrKyAa8BuEV3cwLiRQedbC5O92yt7vKsWVVc6wVDjuWI/Qf41s2rYTaa3pHIshd2bCN0bqQ96Dvvh+V2ZDbmliKCPU+2TRhUBSH5IswFYwfPbHMftK3CTiMtTy6vnvo2Nauq7uWJp3z4Lg6A3KaBKLhpGHxX31IpdC1WX2z8J/ybsOQTF+102aqDkR02P8f1yPL4c/sZ3C88014waz0FJ+Cc5DkGp8LDXARXjQV1ORCICMgYEemUb9Xgdnio6owq5UyylnbluDcwqLkYoCubTVC2hzHxZa8xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bnKx/KU9ZFF11CVOBRKPZh7/ShnVcFndLF2Q8XcQeOv3HDs6LPr76zf88bblbCHJm9zx7PUZmzciaRt4vwS6mnvwGyuzn0FttpXmQAMyIpfRL3xwfW7becXsRU+1oFRQjFbZY1xGRMIxskSfvNsBlPEH7bC6FvxBNQqpEuMNY1Mqva/HVqQQ9T5ib6DrxlKVQUI16Nq8HLhcLyl1XKF8vTULApqRw/PJz9l74gdMp5IDxBEJi5dmNGUV9my+FuNOxqRwNQRTJl1JeeVOzmG1jfZMzX/CKt7bUxwqRZqXe2qnW3YBofvNEs0L8M94+BWyNouTCFGgPG7kvZ6wVWWo0w6nnKmYs/Ek/nvtyd5hcIkC+joyAl+G5JFKP6q54ZmhG36QiQSSGBtpFc0AxZpWsg1Dwj+8zMjDIMoRgRV+D9D04GicZROz5rIeUXMhA3Ci
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:19.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aecfdae-0a4a-4ea6-e835-08df1a6c1f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

From: "Cheng, Tony" <Tony.Cheng@amd.com>

DMs still call dc_hardware_init and dc_hardware_release while Core 2
lands next to legacy. Those entry points live in dc/dc_api_dispatch:
LEGACY calls the old bodies directly, CORE2 uses core2_funcs. dc_create
allocates struct dc2 and returns the inner dc (TO_DC2). The shim only
records selection; dc_construct still constructs Core2. No dispatch
fields on public struct dc, and no architect spec edits.

TO_DC2 is a typed upcast (struct dc is the first member of struct dc2).
Shim headers are included for UNIT_TEST as well as production so TO_DC2
is defined when core_gtest compiles dc.c.

Assisted-by: Cursor:cursor
Signed-off-by: Cheng, Tony <Tony.Cheng@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  3 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++++++++----
 .../drm/amd/display/dc/core2/CMakeLists.txt   | 10 ++++++
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   | 34 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core2/dc_core2.h   | 19 +++++++++++
 .../drm/amd/display/dc/core2/dc_core2_init.c  | 13 +++++++
 .../drm/amd/display/dc/core2/dc_core2_init.h  | 10 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 .../display/dc/dc_api_dispatch/CMakeLists.txt |  9 +++++
 .../amd/display/dc/dc_api_dispatch/api_shim.c | 32 +++++++++++++++++
 .../amd/display/dc/dc_api_dispatch/api_shim.h | 19 +++++++++++
 .../amd/display/dc/inc/dc_core_interface.h    | 31 +++++++++++++++++
 12 files changed, 206 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 99aa8f75de7b..f868999515dd 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -69,6 +69,7 @@ FILES += dc_fused_io.o
 FILES += dc_helper.o
 FILES += dc_memory_pool.o
 FILES += core/dc.o
+FILES += dc_api_dispatch/api_shim.o
 FILES += core/dc_debug.o
 FILES += core/dc_hw_sequencer.o
 FILES += core/dc_link_enc_cfg.o
@@ -80,6 +81,8 @@ FILES += core/dc_state.o
 FILES += core/dc_stream.o
 FILES += core/dc_surface.o
 FILES += core/dc_vm_helper.o
+FILES += core2/dc_core2.o
+FILES += core2/dc_core2_init.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 369569e3b701..17db12fe8022 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -90,6 +90,8 @@
 #endif
 
 #include "dce/dmub_outbox.h"
+#include "dc_api_dispatch/api_shim.h"
+#include "core2/dc_core2.h"
 
 #define CTX \
 	dc->ctx
@@ -982,6 +984,8 @@ static void dc_destruct(struct dc *dc)
 	kfree(dc->vm_helper);
 	dc->vm_helper = NULL;
 
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		core2_destruct(dc);
 }
 
 static bool dc_construct_ctx(struct dc *dc,
@@ -1179,6 +1183,10 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
+	api_shim_construct(dc, init_params);
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		core2_construct(dc);
+
 	return true;
 
 fail:
@@ -1565,7 +1573,8 @@ static void disable_vbios_mode_if_required(
 
 struct dc *dc_create(const struct dc_init_data *init_params)
 {
-	struct dc *dc = kvzalloc_obj(*dc);
+	struct dc2 *dc2 = kvzalloc_obj(*dc2);
+	struct dc *dc = dc2 ? &dc2->dc : NULL;
 	unsigned int full_pipe_count;
 
 	if (!dc)
@@ -1613,7 +1622,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 destruct_dc:
 	dc_destruct(dc);
-	kvfree(dc);
+	kvfree(TO_DC2(dc));
 	return NULL;
 }
 
@@ -1639,7 +1648,7 @@ static void detect_edp_presence(struct dc *dc)
 	}
 }
 
-void dc_hardware_init(struct dc *dc)
+void legacy_hardware_init(struct dc *dc)
 {
 
 	detect_edp_presence(dc);
@@ -1662,7 +1671,7 @@ void dc_deinit_callbacks(struct dc *dc)
 void dc_destroy(struct dc **dc)
 {
 	dc_destruct(*dc);
-	kvfree(*dc);
+	kvfree(TO_DC2(*dc));
 	*dc = NULL;
 }
 
@@ -6676,8 +6685,7 @@ bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc,
 	return false;
 }
 
-/* cleanup on driver unload */
-void dc_hardware_release(struct dc *dc)
+void legacy_hardware_release(struct dc *dc)
 {
 	dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(dc);
 
@@ -6685,6 +6693,16 @@ void dc_hardware_release(struct dc *dc)
 		dc->hwss.hardware_release(dc);
 }
 
+static const struct dc2_funcs dc2_legacy_funcs_table = {
+	.hardware_init = legacy_hardware_init,
+	.hardware_release = legacy_hardware_release,
+};
+
+const struct dc2_funcs *dc2_legacy_funcs(void)
+{
+	return &dc2_legacy_funcs_table;
+}
+
 void dc_mclk_switch_using_fw_based_vblank_stretch_shut_down(struct dc *dc)
 {
 	if (dc->current_state)
diff --git a/drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
new file mode 100644
index 000000000000..c20602c351b5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
@@ -0,0 +1,10 @@
+#
+# @file  CMakeLists.txt
+# @brief Core 2 sources. Subdirectory files are listed relative to this dir.
+# @copyright Copyright © 2026 Advanced Micro Devices, Inc. All rights reserved.
+#
+
+dal3_subdirectory_sources(
+  dc_core2.c
+  dc_core2_init.c
+  )
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
new file mode 100644
index 000000000000..f496e4d66575
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+#include "core2/dc_core2.h"
+#include "core2/dc_core2_init.h"
+
+static void core2_hardware_release(struct dc *dc)
+{
+	dc2_legacy_funcs()->hardware_release(dc);
+}
+
+static const struct dc2_funcs core2_funcs_table = {
+	.hardware_init = core2_hardware_init,
+	.hardware_release = core2_hardware_release,
+};
+
+const struct dc2_funcs *core2_funcs(void)
+{
+	return &core2_funcs_table;
+}
+
+void core2_construct(struct dc *dc)
+{
+	(void)dc;
+}
+
+void core2_destruct(struct dc *dc)
+{
+	(void)dc;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
new file mode 100644
index 000000000000..a761e85a9973
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "inc/dc_core_interface.h"
+
+struct dc;
+
+struct dc_core2 {
+	const struct dc2_funcs *legacy_funcs;
+};
+
+/* Core2-local; selection lives in the API shim, not here. */
+const struct dc2_funcs *core2_funcs(void);
+void core2_construct(struct dc *dc);
+void core2_destruct(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
new file mode 100644
index 000000000000..d4777cdbd569
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+#include "core2/dc_core2_init.h"
+
+void core2_hardware_init(struct dc *dc)
+{
+	dc2_legacy_funcs()->hardware_init(dc);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
new file mode 100644
index 000000000000..a4fa0365cd4f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+struct dc;
+
+void core2_hardware_init(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c8e6e949ce79..9c8e55715e47 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,6 +51,7 @@
 #include "dml/dml1_frl_cap_chk.h"
 
 #include "sspl/dc_spl_types.h"
+#include "inc/dc_core_interface.h"
 
 struct abm_save_restore;
 
@@ -1389,6 +1390,7 @@ struct dc_init_data {
 	uint32_t *nbio_reg_offsets;
 	uint32_t *clk_reg_offsets;
 	void *bb_from_dmub;
+	enum dc2_selection dc2_selection;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
new file mode 100644
index 000000000000..1654558a844d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
@@ -0,0 +1,9 @@
+#
+# @file  CMakeLists.txt
+# @brief DC API dispatch / public shim. Subdirectory files are listed relative to this dir.
+# @copyright Copyright © 2026 Advanced Micro Devices, Inc. All rights reserved.
+#
+
+dal3_subdirectory_sources(
+  api_shim.c
+  )
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
new file mode 100644
index 000000000000..3dcfde8308c5
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc.h"
+#include "dc_api_dispatch/api_shim.h"
+#include "core2/dc_core2.h"
+#include "inc/dc_core_interface.h"
+
+void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params)
+{
+	/* DM override today; ASIC allow-list later. Owned only by this shim. */
+	TO_DC2(dc)->selection = init_params->dc2_selection;
+}
+
+void dc_hardware_init(struct dc *dc)
+{
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		core2_funcs()->hardware_init(dc);
+	else
+		legacy_hardware_init(dc);
+}
+
+void dc_hardware_release(struct dc *dc)
+{
+	if (TO_DC2(dc)->selection == DC2_SELECTION_CORE2)
+		core2_funcs()->hardware_release(dc);
+	else
+		legacy_hardware_release(dc);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
new file mode 100644
index 000000000000..fee03a5dd596
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dc.h"
+#include "inc/dc_core_interface.h"
+
+struct dc2 {
+	/* First member: TO_DC2 is a typed upcast, not container_of. */
+	struct dc dc;
+	enum dc2_selection selection;
+};
+
+#define TO_DC2(ptr) ((struct dc2 *)(ptr))
+
+void api_shim_construct(struct dc *dc, const struct dc_init_data *init_params);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
new file mode 100644
index 000000000000..35a6218c1285
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+struct dc;
+
+/*
+ * Construction-time Core implementation selection. Zero is LEGACY so existing
+ * callers that leave dc uninitialized keep production behavior.
+ */
+enum dc2_selection {
+	DC2_SELECTION_LEGACY = 0,
+	DC2_SELECTION_CORE2,
+};
+
+enum dc2_hw_ownership {
+	DC2_HW_OWNERSHIP_RELEASED = 0,
+	DC2_HW_OWNERSHIP_OWNED,
+};
+
+struct dc2_funcs {
+	void (*hardware_init)(struct dc *dc);
+	void (*hardware_release)(struct dc *dc);
+};
+
+void legacy_hardware_init(struct dc *dc);
+void legacy_hardware_release(struct dc *dc);
+const struct dc2_funcs *dc2_legacy_funcs(void);
-- 
2.53.0

