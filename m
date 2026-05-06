Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC07CD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DF110ECE4;
	Wed,  6 May 2026 07:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NXsfXFQH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010070.outbound.protection.outlook.com
 [52.101.193.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC2710ECE4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgTBkGsJz943nr2klxKnwCbV0O7A6jimO7D2iC6+J5b03G4CDQ+rKjyOzAZnBOhqAOVzeqEPK391jqV327AA5LANOgRo+op/rp/i/1I3k62nZlFWv9PTe6s8Hey2UTAW4y0k/rjunRhlDofEFhfBTd6uCPOOPefYpAzzq6EAlZadO63Ef1H6cxLVC2xdSQWz8OU23HKajKH1+lsfjqMFK9N2Y8VaThWk9RLX9s37I4XJJQYbn/hoK+II9IDT31hH0bjoVKSFwTnuujU5D+fN+hfQ7nL4KT7bcPwEcGRoqTQ8LIOSMwMBLEE0M1kBFfOd5q6LGkm+XkWOl6qG4dwD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SZre4qVQg9H/SmEU/hk7R66/BSzKs7jnEDyI5OAmfU=;
 b=baAtJlZlBdaNAGsBJeMAy1n8FQidD0s6/SNzvjkdOUzS/kFUauH2lNza1KnuRuVgYq+BBndmetSXgnELkgpLshsEwi0z/rybGFxZpf/jNNO5bZLqjNlZUkkrtIT+RFIJ4NDAmKJYAShBn4paUTwaaTnIeMdm+EAUHMJd99e4420tD+S6xKrH885g0PleZDHYF3FtRk2zkYuwol4MoLsAwYevGEfIMOzfB2FXZc2ESq73HSZaVxVgFeU7CV6CQJOuKDyQkbiJ3BSTm01lLxjOKo/4kuKQWxJI87pongF0xFgFlo5y8BiN/jWJYm35KCJoOQC8lgDLL5/uVQNg3IBrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SZre4qVQg9H/SmEU/hk7R66/BSzKs7jnEDyI5OAmfU=;
 b=NXsfXFQHqiOUKEvpI35gRGuZ35uZOY2pRNqtYx/bEyd7ZmgxbqH3TjUQ3lcShEskUOFLnIk0O2qomW2L7qAZ7T5U/XS9YM4+R6A8RbBOLPOCjwDlSQWx6yZBs7G6j59jtUsSbCwROgv9hBA4/0oL6ohdPdtou9eg4Nlu1t4ZGqc=
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:05:29 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::94) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.24 via Frontend Transport; Wed,
 6 May 2026 07:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:05:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:05:21 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:12 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, Aric
 Cyr <aric.cyr@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 14/20] drm/amd/display: Fix enum decl warnings
Date: Wed, 6 May 2026 12:31:12 +0800
Message-ID: <20260506043342.2164710-15-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: e95d9586-a548-4e10-592f-08deab3ddb2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: AYuQGmRBqnJv9uRE58hJqLVjj17fnD6ScoPOxigM3SZ/hJJYRAxEzIOdlZcDK6MxXS2ieJo++pbUBk90ojyGT7Bagp0gcsyVT6Kl0KBHLtxOth9xLwf8vCSA9g05HFRo7c90sgnsiA1jNGMLAi0WCDQ260NhdtIRpCQ2wZCtVcr+/2bV/ZS2Gfi3KAjNST0kxwoWRnErjy/IHY9hkh8Uaiwq7aYmi/5mbBGAMCTFP5n9ILpvM+4pDU+timoX0vGBWyUOreYrNrZY9LfSwyCywuQeJQtP7++SmMEuU2S+6Kij6ZdtxeNnCSQqcVsL8KiE2Hjw5Nqy69WYZJyzZv/o03yUUms7EwdUjpnWMQj0QORr4A9ZdS+yhE3iHeTRZ4su+3yP2V3Q2ah24PWxS4n3E5QVyeK6Bjm3rXrytp6SFMpsjhNCaijw/iVr2dfpnWnZB9d790yytswPvR02AE1QM5eZ2AP7uyK55Lq2R9ZYeaJMuqqsp2KREplcN++LwCJRX+yiq7Y81VAhcNGVId1KfiJXaDZs0DnEWIThQcv8NUmOYHDXmNWlSFDAnHCBfB/6g1n2d2Uiu6zJQnUVwpo5f3aEKk3ZqaBgsSILTe0wS6MSJTgl6SSIQT9g9WV9g3tuFI7xTtREbFNjFEyp7+68Av8WR/C+xFV9EWRayqOgLKt5VbzEBenOaNYnPgDjU4IgCL5RBMpBq0ypr8Km2Rs+yz/bCxnpWGJf1SltVYA1SBs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WPaCWolQCfxYrKe7bhF1GoH3wtXFIVx2eqHCA3EdBPBT6WJkWcuRuiIN+R237fEj0Xf1hLlXyHEYWfEuw0HtlnIM6I+48k98z1Yz4dHihyxqIL3FJNWKyW1DfjhEgBM5Ic1yvKXjZ+uE8Q8cH/kQCDQTGWAj7QE3yEPHpwqT4F8GRzGhPXr2q2vCRQFPS/7zp9C7lDPtYH+3HP1pK4fX1gDXvMSL3qRhIOTwx6gXtGAzy2kKLZ4ZBnxKA5ARJGBSw2Odu2J2jk8tYtBkrEvCCKNqvPkAUyyGb42OLy/n/VMyM5HhBuaaiKSW2+buFAIgIiWMu+jOzEHOQLhbS1hEvI4a7wtotDyJzYM1R8tSszsRgClkzoIdLecQ3jW0nMY0hqnaWrKgwSg0tQjWYvsmjYpTpZj5ubbbH7xL/c/KnPZkAMzXYX9OYPw5WFLoP7rf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:29.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95d9586-a548-4e10-592f-08deab3ddb2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
warnings were triggered by enum forward declarations that are not
valid in C++ without an explicit underlying type.

[How]
- Replace problematic enum forward declarations with C++-safe forms where
  applicable.
- Use plain integer types for interface-only declarations that do not
  require strong enum typing.
- Update dependent winterface signatures and related type usage
  consistently.
- Add required include and type-visibility fixes to avoid follow-on parse
  and type-resolution issues.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  1 +
 .../amd/display/modules/inc/mod_color_types.h | 47 +++++++++++++++++++
 .../amd/display/modules/inc/mod_info_packet.h |  9 +---
 .../modules/inc/mod_info_packet_types.h       | 37 +++++++++++++++
 4 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h

diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 107aec6a1265..63704d21a0b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -30,6 +30,7 @@
 #ifndef __DM_HELPERS__
 #define __DM_HELPERS__
 
+#include "modules/inc/mod_info_packet_types.h"
 #include "dc_types.h"
 #include "dc.h"
 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h b/drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
new file mode 100644
index 000000000000..bf7313df585b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef MOD_COLOR_TYPES_H_
+#define MOD_COLOR_TYPES_H_
+
+enum predefined_gamut_type {
+	gamut_type_bt709,
+	gamut_type_bt601,
+	gamut_type_adobe_rgb,
+	gamut_type_srgb,
+	gamut_type_bt2020,
+	gamut_type_dcip3,
+	gamut_type_unknown,
+};
+
+enum predefined_white_point_type {
+	white_point_type_5000k_horizon,
+	white_point_type_6500k_noon,
+	white_point_type_7500k_north_sky,
+	white_point_type_9300k,
+	white_point_type_unknown,
+};
+
+#endif /* MOD_COLOR_TYPES_H_ */
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index ddd64b7e4c04..11b127eb13d8 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -27,6 +27,7 @@
 #define MOD_INFO_PACKET_H_
 
 #include "dm_services.h"
+#include "mod_info_packet_types.h"
 #include "mod_shared.h"
 //Forward Declarations
 struct dc_stream_state;
@@ -47,14 +48,6 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
 
-enum adaptive_sync_type {
-	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
-	ADAPTIVE_SYNC_TYPE_DP                    = 1,
-	FREESYNC_TYPE_PCON_IN_WHITELIST          = 2,
-	FREESYNC_TYPE_PCON_NOT_IN_WHITELIST      = 3,
-	ADAPTIVE_SYNC_TYPE_EDP                   = 4,
-};
-
 enum adaptive_sync_sdp_version {
 	AS_SDP_VER_0 = 0x0,
 	AS_SDP_VER_1 = 0x1,
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h
new file mode 100644
index 000000000000..30a5259ef36b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet_types.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef MOD_INFO_PACKET_TYPES_H_
+#define MOD_INFO_PACKET_TYPES_H_
+
+enum adaptive_sync_type {
+	ADAPTIVE_SYNC_TYPE_NONE                  = 0,
+	ADAPTIVE_SYNC_TYPE_DP                    = 1,
+	FREESYNC_TYPE_PCON_IN_WHITELIST          = 2,
+	FREESYNC_TYPE_PCON_NOT_IN_WHITELIST      = 3,
+	ADAPTIVE_SYNC_TYPE_EDP                   = 4,
+};
+
+#endif /* MOD_INFO_PACKET_TYPES_H_ */
-- 
2.43.0

