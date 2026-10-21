Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43275606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IoiPepjn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A57BA10F927;
	Wed, 21 Oct 2026 06:25:47 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205D010F927
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAudt7f3w8uLLS0iDlqsHEskoZ0b28ubpZkKw4iBJiKXgqkA5kFNTPHsRmWi7zpWFU+pOnyxIlF/mjNYCBrjD9bJiC8UxUhwZeK+2wgzIXSG0hq4K10WvzbPVVm4WAFTb2fPmgBpnk337E7ZrEvibnetVSRE/l8UguFQvcuomMOg5wConKwhjNkqy9MyhpfXR551AsitDRTSgGGZEwxxmd6W5r9gL5DOxgIrOR8mB0g459W3wHJ2DoQbvNs5CfeGhgGDD+zb1EhPxzVyAZ7oYjezOVWBkeKi8wcx1qe4g1nqQPn8AuRsUjIuoclYkfRAEfuYhln9arHt//SDjUX+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhfrWFEIZURxsiHdPBBSEzKYnBh8uOJY1lOsH6uts5Q=;
 b=nB0cidgFnAqANn0pF5fkduJWf7naa/CHP948RqPerVffwE59LiXoHpvu9RVSVSrkJeTE6mn4NEOH1aFswfTen8qi2VQsk4tHX22GnJzJuUMAtDlTpa8mVG1upuBFFtQAa/VSaCdTboAniKlTcHHUG/diQRGfRXbrWbQFK0wxBkfh5AXjP3SHfuTcgqKJAMOOx+Xiyg3Bw4HUU4Vz4ceBxpeaUN9ktQTqICnml5LGLBoZAA4w+//MzsOXdDOc5bf3r2FaRFGDLCPmzjzIPyaQnGSk40lQD44B8JCteY83tZ2orJYcWyF+j41DDj54T6LVRA/2U0d1D1PNkWdqf/zqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhfrWFEIZURxsiHdPBBSEzKYnBh8uOJY1lOsH6uts5Q=;
 b=IoiPepjn9UuhdwaFHzYu9MgSFPhDBzVBg7uJ8qYljnKCPuWdq+0+77JUK3fBNIr5xh1WkKbsnw7CZSY70xrfbUSCiZXRYn5RTPgVEQU6/hcgKX+Q1WMX++f1jYv/7gIJzM1gWGJrA32yfz1Mf5KhKaXTenVBlIvuaVf2eqVLgHg=
Received: from SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8)
 by LY0PR12MB727857.namprd12.prod.outlook.com (2603:10b6:408:3ba::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:25:36 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::28) by SJ0PR13CA0063.outlook.office365.com
 (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:25:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:31 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:27 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 03/49] drm/amd/display: Add Core 2 Workaround Manager
 scaffolding
Date: Wed, 21 Oct 2026 14:22:09 +0800
Message-ID: <20261021062519.674697-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|LY0PR12MB727857:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c381f5-fe85-4d35-306b-08df2f3c1e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|261009223327099003|261009220027099003|11063799006|261009221227099003|261009221727099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nvz9jamni1D7JUKjcPjeDPl83cfFbKK76YbEI94AbMF4prexFK+qTgSGXj8Flb0Zw0IbXQWkQSppmjW9Xox0vIRxi5TMGNDGUD8MyZ3UjX83Klg3ye6VYhrP6TQOxHHUpJNZSv9Eoxsv3SQ9pVisQLuLDZIx4uxrFjRYStXsw7qVL6dyj2lwHHQ3as0fDIvZ0HAaNulw/BQ583BYDt5RNS4LY//VX2B8yTEMxyhXFJV4kPd943BCJocmacnTh9K57HBXoUBTe5CyK0Gr1rhyg1CVLCoOCSmFBpEg/RBY4L+SE4ccg09nq561AkE8q698D6ZWt8Nd38RF0Rk7rx4jvwoxCP5MaV/4v4xP5rhpI6ZuVJBHxNW7TD6wMb5C8cdF7bl/sfl6jOsQVw5MHF7nmfqzH+NKPI4ir/wOoNAYS4o2rlSYSM6CCDQbHjmZIs2wzwF3+Sp3H7p6mT1pFPiPN91XhTFHbu09O4IkGcJ0ZG8hU6D+4vpFk9aMSDVDk15a+rVVL1697MT+VNmMeJCkdf7+btj6cr+IKVq0BfDCycQTIMAn8Am7DG/M0ueoSjrmRPcDv+cEolGBcXQUFiH1TodoEJfYthToDKTtfrecljM+YpJfXOUVIQHwcKZL+BvqSrIxXfgIAO2gAyBeKUU2B8VsGdnlO7Gyy5ChUqQX7PtOxsbj7c9ralyd0j11W1Up1ewtbqMEHrGbrJFdflmhYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(261009223327099003)(261009220027099003)(11063799006)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oXfj4aEv5KOjfuaPC/QafUCV8FUCTHg2YnGDOv58lH2blhQHzDO0ZXGqTfMwS4G1hl0tv8/cRA1uZfYYV5XAPbBk/5fUN6aiTeBiFBQBpNgb5B4evfMdgaYbZt9ILyvv2fkQ2XX6EzXmD724samMa1Jrrv+7vrgJLxCA0Ab6h7bjGB7uR79ibdDxMmCTqRIhwO67ifndbikRwUN9+sSUHtp1/7kTq3D0TqcRizFJEA/lAVcyk1W0iy7xcxZUClyJYSAEQaOaHm/Si7jLCFac7OMT0XCDoVLmkUP5lZPz3S3O12xKYPKMU7WinuLrciJZ142BreP6n5AQOFiPiEl9da8mwwVOq+X+7mxXru6iwMegNyQhj+EY7GkE17jHBxQszl63A22yZIk27UgWj5I4n8kbngKRY8MZHqXLLXiStmaA9CfulBY2NEkaVktlabHP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:35.9848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c381f5-fe85-4d35-306b-08df2f3c1e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB727857
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

Why:
Core needs a Layer-2 post-build stage that can edit a built BLS list
for errata before the Executor runs. Inline workarounds stay scattered
until that manager exists.

How:
Add an empty-registry Workaround Manager over block_sequence_state.
Keep the restore image in BSS so the kernel frame stays small, and
reject growth past MAX_HWSS_BLOCK_SEQUENCE_SIZE. Name the committed
state field current_state so the Linux current macro does not expand
it.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  1 +
 .../workaround_manager/workaround_manager.c   | 74 +++++++++++++++++++
 .../workaround_manager/workaround_manager.h   | 46 ++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index e64a098e04e3..56a39d9da119 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -87,6 +87,7 @@ FILES += core2/dc_core2_init.o
 FILES += bls_builder/bls_builder.o
 FILES += bls_builder/dcn401_init_builder.o
 FILES += bls_executor/bls_executor.o
+FILES += workaround_manager/workaround_manager.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
diff --git a/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c b/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c
new file mode 100644
index 000000000000..067a7069186b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "workaround_manager/workaround_manager.h"
+
+static const struct workaround_manager dc2_wam_empty = {
+	.registry = NULL,
+	.count = 0,
+};
+
+/* BSS, not the stack: 64 block_sequence entries exceed the kernel frame limit. */
+static struct block_sequence dc2_wam_saved_steps[DC2_BLS_MAX_STEPS];
+
+const struct workaround_manager *dc2_workaround_manager_get(void)
+{
+	return &dc2_wam_empty;
+}
+
+enum workaround_manager_result workaround_manager_apply(
+		const struct workaround_manager *wam,
+		struct block_sequence_state *bls,
+		const struct workaround_context *ctx)
+{
+	struct block_sequence *saved_steps = dc2_wam_saved_steps;
+	enum workaround_manager_result result;
+	unsigned int saved_num;
+	unsigned int i;
+
+	if (!wam || !bls || !bls->steps || !bls->num_steps || !ctx ||
+			*bls->num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE ||
+			(wam->count && !wam->registry))
+		return WAM_INVALID_INPUT;
+
+	/* Snapshot buffer is DC2_BLS_MAX_STEPS; larger built lists stay unmodified. */
+	if (*bls->num_steps > DC2_BLS_MAX_STEPS) {
+		if (!wam->count)
+			return WAM_OK;
+		return WAM_INVALID_INPUT;
+	}
+
+	saved_num = *bls->num_steps;
+	memmove(saved_steps, bls->steps,
+			saved_num * sizeof(saved_steps[0]));
+
+	for (i = 0; i < wam->count; i++) {
+		const struct workaround *wa = &wam->registry[i];
+
+		if (!wa->enabled)
+			continue;
+		if (!wa->is_applicable || !wa->apply) {
+			memmove(bls->steps, saved_steps,
+					saved_num * sizeof(saved_steps[0]));
+			*bls->num_steps = saved_num;
+			return WAM_INTERNAL_ERROR;
+		}
+		if (!wa->is_applicable(bls, ctx))
+			continue;
+		result = wa->apply(bls, ctx);
+		if (result != WAM_OK ||
+				*bls->num_steps > MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+			memmove(bls->steps, saved_steps,
+					saved_num * sizeof(saved_steps[0]));
+			*bls->num_steps = saved_num;
+			if (result != WAM_OK)
+				return result;
+			return WAM_SIZE_EXCEEDED;
+		}
+	}
+
+	return WAM_OK;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h b/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h
new file mode 100644
index 000000000000..4cbadffd6a8b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/workaround_manager/workaround_manager.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "bls_builder/bls_builder.h"
+
+enum workaround_manager_result {
+	WAM_OK,
+	WAM_INVALID_INPUT,
+	WAM_SIZE_EXCEEDED,
+	WAM_INTERNAL_ERROR,
+};
+
+struct workaround_context {
+	const struct dc_state *current_state;
+	const struct dc_state *target;
+	enum bls_builder_name builder_name;
+	unsigned int dcn_version;
+	const struct dc_bug_wa *bug_wa;
+	const struct dc_debug_options *debug;
+};
+
+struct workaround {
+	const char *name;
+	bool enabled;
+	bool (*is_applicable)(const struct block_sequence_state *bls,
+			const struct workaround_context *ctx);
+	enum workaround_manager_result (*apply)(
+			struct block_sequence_state *bls,
+			const struct workaround_context *ctx);
+};
+
+struct workaround_manager {
+	const struct workaround *registry;
+	unsigned int count;
+};
+
+const struct workaround_manager *dc2_workaround_manager_get(void);
+
+enum workaround_manager_result workaround_manager_apply(
+		const struct workaround_manager *wam,
+		struct block_sequence_state *bls,
+		const struct workaround_context *ctx);
-- 
2.43.0

