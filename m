Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB040606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0me6j5J+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7808E10F810;
	Tue, 17 Nov 2026 17:12:56 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A1D10F810
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivOs/J/G8ntvLzzJljwp6VkFJF8rtoemWUJggIGMz0FbXz5eS5/VdW5kU+z4YEDj36rl+99qHazNhW7/88rbxvfSvoe8zmRTqwnbyVImDipGH6Qm/OIovEYScP+tqdXUd+QdGmiMxI1nizGrX8cO1kfU86XaMf2TglqXCTmQnF/CIHE/h1I7iTLwqpXdu+6gLUPqb9NJNUoVJzlNIEM95ydU4RAlygu0dWUdu0AU5fpamNP5Hz5gFGfaTPj8rMQu1UJeaxKOUoRdlzgu24ooen48Z4MMIgSK48813/uJPuq+PZTyDy0Iy5NTpw3p3nOKCP4PbrI/rIvqvzBjMKM5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNpKf8Ib8CMtET0WKd5wJDk99/3NMeY4HybJBGdSa8s=;
 b=cR6vset3T/oq076XniCRuJlS+zUKE6AIt+NiXE+u/gBaAclmMCOMv682YjQQM/mXvoswxDtUU9ncYwF3TvRbBG94NKhXPsNFlSJgZRA8QQ9PpqvQvDYInojdLFwEb7dHfkPbUPXM6976o06imYKJHUv8IT2oTIvN0rncyiV4CBrSpnmWXw4RfysUlt2EOal/8zneV2sPGVvIcgx7YLKPQLzGLu58q/zCtY+ZWYPFIglXeeI8mQ+yobzvAgFcrP/D7rl037zfIk8EgkCq/KfVPJ631XbLB1HB095sC6aq2K6HMznxOZ+7jRPnXmCeTdu58qzHemc4VuDSw02MRWLYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNpKf8Ib8CMtET0WKd5wJDk99/3NMeY4HybJBGdSa8s=;
 b=0me6j5J+EvozPAgn6abkl6mThq/HINGIy4G4fGjOvUQUlf/YWlLlZC520iyAbXjyeLvnxBfeC7iHjqFOlryfHnwTMmWFY2IhXVTiD2AV27ylmVKXmIeUQ2QPj0GcFN4eAlnuhljp9lUfKtikTmb2SBrICn2z3o7Oo7NzKAqnhA0=
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:12:45 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::96) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Tue, 17
 Nov 2026 17:12:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:12:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:12:43 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:12:34 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "James
 Lin" <pinglei.lin@amd.com>
Subject: [PATCH 04/33] drm/amd/display: Add DPMS-v2 files
Date: Tue, 17 Nov 2026 05:50:41 +0800
Message-ID: <20261116215641.2800595-5-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 45465c9c-a086-463b-6379-08df44cdfeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|3023799007|11063799006|260925022911599003|260925021311599003|260925021911599003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|261021121427099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: JLCqO3xuPH5QyCkK56S02cYI1nLECu+DzszUDWJJ/C9HTulTjnjorx+v79e5JO014TOWQs84menRq5KHxfSt0kQeRzemKSXTaCfTYfD+dR9BEhf+BaGgDPoghcDOFG9krQLYFY01bbzDJN3JIEnfhnCqSF4MyW8N5z+4MLR6j7FC245ssb2UtnLS5d5WWnJ/R5k8B9K62GVSA9zrh/LbC85/l7U5jssXP32d639iTBklxi+NSedBbBK6zr45I9h8oUNb7bmhF9wAKvB1bD/ZBPBEcaGEM5DeLgRMp2Omdirnvae0n5emozzPcY5bGvUMSRcmtUmWAT0/h/EuGLWDBasoH3ALDKFSwCMRKglDpb/CKX3EhXvm8h2xSYEOiMQPw0d08r02hnnRrDolJyZKhe9o2w4f2zEnacTFUSdJahcFJKFijBxzhPPbVWZgxnN1dWYd9rEV3Yy+bjF2pGfD8DJSzJek9CJlmDiSftmjh5RL38HjASxvwkDlT+XSJ/XwZnIrYDFxicpz+sFVyQBuR3wvGQ/UwPUwT64rW/58I/t3+WWxzky6hhXleGVIXCbmnXUgWdtHmXQd3MvzGHTY8r1fl24rqJgR2bbEJXESX7N1vcd0voFDbKfhYKsw9eYW2f5qiddqNLsk3XlSnDyZOR55Wv8qS2UZwlEZ+4tusdYnv73vGu3oTy+yEc46u+lKaFXxvY/cZN5SIZyEgg+l2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51f+vA9E7h4x6MCUUWCytnRyaPLF4rgDMjhxaA3FkkmV9bpRU+l0oz0xrfOdXcCwJEthdOE0mL8PDAohKtHJIE9hKeh4Bbk+s+nzwUMOUR3Cx+ttwYK1FbEW6qzkTERubNuKY27rSwry8u1dUtQ7cUtBqgtn/eglE+H7iOtiav0mQxT2oe8VXIcDaP0q6CQRtEQNVihUCakO2/HFb708PcaanSAftUF1oC7mBfJ31Wnok2iFGUQF6b6Re+4mq1d7Ru5qjdPoHG0d2w2B6Stxjkcu8Ftr/Reo/UzjEsCzspzfVwF3JUs4vcMXBHuQJ3SnnhEKdqsFrqyDYitRy9uk18pEyxw8+CK2+0oUvmUzQHvVitB8UJpcIERMMUUmVEDnz58Ql37kPOTC/gk3CJzgZ/p3G/S+Y1QKpDGxovaQmbo/QIQhb8v5ssIEISGVIqCA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:12:44.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45465c9c-a086-463b-6379-08df44cdfeca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why]
Split into smallest possible increment to allow for parallel
review of different aspects of DPMS-v2 design.

[How]
* Add DPMS-v2 files with empty DPMS-on/off functions
* Add flag to dc_config to choose between v1 and v2
* Use flag in link_create_link_service to update vtable

Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |  6 ++-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  9 +++-
 .../drm/amd/display/dc/link/link_dpms_v2.c    | 44 +++++++++++++++++++
 .../drm/amd/display/dc/link/link_dpms_v2.h    | 38 ++++++++++++++++
 .../drm/amd/display/dc/link/link_factory.c    | 21 ++++++---
 7 files changed, 114 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 463a3fc2d8c2..3ca650461cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1070,7 +1070,11 @@ static bool dc_construct_ctx(struct dc *dc,
 
 	dc->ctx = dc_ctx;
 
-	dc->link_srv = link_create_link_service();
+	const struct link_service_options link_service_options = {
+		.enable_dpms_v2 = dc->config.enable_dpms_v2,
+	};
+
+	dc->link_srv = link_create_link_service(link_service_options);
 	if (!dc->link_srv)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b71a9a5cd424..01f549010d07 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -645,6 +645,7 @@ struct dc_config {
 	// Set by the DM around a commit that runs where allocation is not
 	// permitted; requires preallocate_scratch_state.
 	bool use_preallocated_state;
+	bool enable_dpms_v2;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index b2f86c51d470..d9a9d5f9f61c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -77,7 +77,11 @@
  */
 #include "core_types.h"
 
-struct link_service *link_create_link_service(void);
+struct link_service_options {
+	bool enable_dpms_v2;
+};
+
+struct link_service *link_create_link_service(struct link_service_options options);
 void link_destroy_link_service(struct link_service **link_srv);
 
 struct link_init_data {
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 0eb433b5d822..ea08f1b1e60e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -23,8 +23,13 @@
 # It abstracts the control and status of back end pipe such as DIO, HPO, DPIA,
 # PHY, HPD, DDC and etc).
 
-LINK = link_detection.o link_dpms_v1.o link_factory.o link_resource.o \
-link_validation.o
+LINK = \
+	link_detection.o \
+	link_dpms_v1.o \
+	link_dpms_v2.o \
+	link_factory.o \
+	link_resource.o \
+	link_validation.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/, \
 $(LINK))
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
new file mode 100644
index 000000000000..43c3f7dfa343
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include "dc/link/link_dpms_v2.h"
+
+enum dc_status link_set_dpms_off_v2(struct pipe_ctx *pipe_ctx)
+{
+	// TODO: Implement
+	(void)pipe_ctx;
+	ASSERT(false);
+	return DC_ERROR_UNEXPECTED;
+}
+
+enum dc_status link_set_dpms_on_v2(struct dc_state *state,
+				   struct pipe_ctx *pipe_ctx)
+{
+	// TODO: Implement
+	(void)state;
+	(void)pipe_ctx;
+	ASSERT(false);
+	return DC_ERROR_UNEXPECTED;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h
new file mode 100644
index 000000000000..c6728932691a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef LINK_DPMS_V2_H
+#define LINK_DPMS_V2_H
+
+#include "dc/inc/core_status.h"
+
+struct dc_state;
+struct pipe_ctx;
+
+// TODO: Add RESOURCED state
+enum dc_status link_set_dpms_off_v2(struct pipe_ctx *pipe_ctx);
+enum dc_status link_set_dpms_on_v2(struct dc_state *state,
+				   struct pipe_ctx *pipe_ctx);
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 7bf1364659ea..919f67b76f91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -31,6 +31,7 @@
 #include "link_resource.h"
 #include "link_validation.h"
 #include "link_dpms_v1.h"
+#include "link_dpms_v2.h"
 #include "accessories/link_dp_cts.h"
 #include "accessories/link_dp_trace.h"
 #include "protocols/link_ddc.h"
@@ -111,10 +112,16 @@ static void construct_link_service_validation(struct link_service *link_srv)
  * with the link and link's enable/disable sequences as result of the stream's
  * dpms state change.
  */
-static void construct_link_service_dpms(struct link_service *link_srv)
+static void construct_link_service_dpms(struct link_service *link_srv, struct link_service_options options)
 {
-	link_srv->set_dpms_on = link_set_dpms_on_v1;
-	link_srv->set_dpms_off = link_set_dpms_off_v1;
+	if (options.enable_dpms_v2) {
+		link_srv->set_dpms_on = link_set_dpms_on_v2;
+		link_srv->set_dpms_off = link_set_dpms_off_v2;
+	} else {
+		link_srv->set_dpms_on = link_set_dpms_on_v1;
+		link_srv->set_dpms_off = link_set_dpms_off_v1;
+	}
+
 	link_srv->resume = link_resume;
 	link_srv->blank_all_dp_displays = link_blank_all_dp_displays;
 	link_srv->blank_all_edp_displays = link_blank_all_edp_displays;
@@ -305,7 +312,7 @@ static void construct_link_service_dp_trace(struct link_service *link_srv)
 	link_srv->dp_trace_source_sequence = dp_trace_source_sequence;
 }
 
-static void construct_link_service(struct link_service *link_srv)
+static void construct_link_service(struct link_service *link_srv, struct link_service_options options)
 {
 	/* All link service functions should fall under some sub categories.
 	 * If a new function doesn't perfectly fall under an existing sub
@@ -318,7 +325,7 @@ static void construct_link_service(struct link_service *link_srv)
 	construct_link_service_detection(link_srv);
 	construct_link_service_resource(link_srv);
 	construct_link_service_validation(link_srv);
-	construct_link_service_dpms(link_srv);
+	construct_link_service_dpms(link_srv, options);
 	construct_link_service_ddc(link_srv);
 	construct_link_service_dp_capability(link_srv);
 	construct_link_service_dp_phy_or_dpia(link_srv);
@@ -330,14 +337,14 @@ static void construct_link_service(struct link_service *link_srv)
 	construct_link_service_dp_trace(link_srv);
 }
 
-struct link_service *link_create_link_service(void)
+struct link_service *link_create_link_service(struct link_service_options options)
 {
 	struct link_service *link_srv = kzalloc_obj(*link_srv);
 
 	if (link_srv == NULL)
 		goto fail;
 
-	construct_link_service(link_srv);
+	construct_link_service(link_srv, options);
 
 	return link_srv;
 fail:
-- 
2.43.0

