Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41507CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0ED210EED9;
	Wed, 13 May 2026 14:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1ln0M2z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3966E10EEE6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmOisGcrCY9YUrtuC4zPr7RnzNlOEVDxpEor8F3712NyLDQXpKXlrSSDusfMX+5tZ4DQ3rGgITU1+fIpqtq8WAMbQs2e+Iflz0c9NGBmu2wsEwo5H+3hbyQCbl2ZZ7UKyFwiOaJbxZZBjNo09bh+JJos92Xv+tGOttkyaMXohcsaIEjDlO3+Zfw+6brZHMdsUKGvdUR7xFSzy43fgkpu9H4CudOWoROK8e0BSdlktX1dS7Tooej0vQva5xzhp6hQz5nVn6kFY4qzidwi5PWR/gWi8fM4o4Mw70lCBh+WwwNwVA0BjjbRAmZd5tGAupiPHMHdqSsfMyqIQjO0HErj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsXsR+G7itwjPpk355LTQJuZWcwEBTwLUKigdylBUN8=;
 b=DMoGUyaVzx1QUQiYGHalPiFtjGrJ8nXH6C7mvebRY/jSvpyq6FuuTMm1VW+BM2Cc0DpcI96blVQNi/6zwV0chFU5g01B9XZEhx7kspHnRs9LN7VDxvd+Fviy5+vR/6+iDa4topFf1haAMYgl9gCgr9iBWU6M7DJ1ynjsVvD6C9BgsYSfsmLP18kHrOCFFo8o/FG2wGfVzYKP3TmldxVcDygigaeRmFY6yeRKsdpp/uSmTACZgkxxDHqDLo3d+VOr+/HIYl252dB0cQ84m0+fB4m9isjW/Jp1cuZn4MJMXSshs0rELqAqO9KRqydCxTOj26BzyJe2hzoVeDpBtGxUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsXsR+G7itwjPpk355LTQJuZWcwEBTwLUKigdylBUN8=;
 b=W1ln0M2zudDgRSPLv/tung3X+7zR6vhW5mQaWCzMRM3ndmcmkwagwwFhRMMnnzIyh3uLFR+yLYhMZQEigiKBxStceWDupLBvkVSh72ZjeK0Uo4L83C6Pk+g65MrcexyRj6RDKxnWwssHdrxMf7r+xV6emPC5vY7j41JhqiefxN8=
Received: from CYZPR19CA0005.namprd19.prod.outlook.com (2603:10b6:930:8e::26)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:24 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::1c) by CYZPR19CA0005.outlook.office365.com
 (2603:10b6:930:8e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:21 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:20 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 10/28] drm/amd/display: Add KUnit test for replay
Date: Wed, 13 May 2026 10:29:32 -0400
Message-ID: <20260513143213.1852892-12-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 598c23cb-c6d2-4a62-7f18-08deb0fc9696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: yzWwTReT6kGndOrGCimFhKWBlO6DhTGdzuLG7OQE+k2sr/D2ckMxPE4L8cPHQ5ajVBHilmst7qbvHm0TGBB0hbI7Vx3zGMY6jIEtDCQhZRjBi3hjnKelmBZvGo3R04LcuUMqbfY0fc0ii+GbOe3NYsXOqlKXf4UOtCXzmlsJ/GaSAQc91VTXRwRa8Nl2/ugGQKoOsFgPMvoxkXjNs4QYIPGhmLSA8GMbGlfg42WE6l0DgjDMnj77fz7dbJurTyPP7Rc8onXQKIfLOIX8moC9xHUikTF8hPIwV7Es4AKq4qGu72cNOmt+xesyw6kvDLkEqzd7jL6e5sRq8RsCtlQ2sTZvEB3cLS3iJteCWmkwGxuUa2EnQfRpgC/KOflIaWz2RNNY1qRxeAkXn/1d4UCLxhKMRt93ZpTrbowo2ch53mv/JHsNZ8l+hukpsF0lLPF6eAZtb/JWP2WZybCgfb9JMNNBq2yahCSb427kNqcFtc4bZwui4OQApM577ZIA0O6hQ/WbowLoW5SL6yPJ4n8jAPB2jlU8jYnvN0phvFK5/ip8socv3SajOCjLndUlgI3hmyph9Sd4yQB+M9gJGH6BO6ps2MEeVMbxUOShmMm0SJFofephsuFSp3PwQNnILQfQ2kk2ij8VnOD5HcxFbFYjTtwcYbA/KO0PtHrpoxq6Wa5yf/BtuQJXyK2eEWs1DU/LPD4tYL8WIESAs0Mzj5XLq+cJwWrHoP0DnMcNmXUrB1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K9O5vtxDRAlM5BsfvQN2oR3RdafykhDbKj53Si2FAP9mN3rmGmhLJLQAJOOAnKbWmMZQ171vj4mvaaIZQIrL3LaKpSBAX/EsbKqiYPe1f8cSshCPPvPXFqYIJcTKM5ElhovkVZNJ68Aam9jPNEeNHTjogZHdSeYwR8aTXXlhnckkonzbcJyfEVdwyVpZrlqj0qzGmK3rQXS38ud3mhppQz46Kr2vLDmOXHWqa8UfpQRxJ7KvwtizQFGI0z3qJWbrharfEKOx92dRo5jhhGchPsHAIjBVBGRf0ayb9GucHDGkQ1/kFQbgh2dtoDW/OU0vlGRADZ8qRUvs+Z7A+nUrkHphfaOWzMTPs6r91Bj6zddzSBCRuKWOtKIj8cq0iJ+e4CqQFv8jUfeVXyTCtHk4pVb+3ULPhI/oaOngb2pF6I9rEmL+d0kC1pohmdDzPKw9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:23.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 598c23cb-c6d2-4a62-7f18-08deb0fc9696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

From: Alex Hung <alex.hung@amd.com>

Add KUnit tests for amdgpu_dm_link_supports_replay() which
validates panel replay capability based on link DPCD caps,
freesync state, and VSDB info. Nine test cases cover the
positive path and each individual failure condition.

Export the function under CONFIG_DRM_AMD_DC_KUNIT_TEST and
add the amdgpu include path to the tests Makefile so that
amdgpu_dm.h can resolve amdgpu_mode.h types under UML.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   3 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   | 206 ++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 297125d1db70..22aa4305d2af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -31,6 +31,8 @@
 #include "modules/power/power_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
 #include "dc/inc/link_service.h"
+#include "amdgpu_dm_kunit_helpers.h"
+
 
 /*
  * amdgpu_dm_link_supports_replay() - check if the link supports replay
@@ -68,6 +70,7 @@ bool amdgpu_dm_link_supports_replay(struct dc_link *link, struct amdgpu_dm_conne
 
 	return true;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_link_supports_replay);
 
 /*
  * amdgpu_dm_set_replay_caps() - setup Replay capabilities
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index f29b5c0dac8e..7d9c983f4995 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
new file mode 100644
index 000000000000..28ff8bbcc0f7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_replay.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+
+/* Extern declaration for the function under test */
+extern bool amdgpu_dm_link_supports_replay(struct dc_link *link,
+					   struct amdgpu_dm_connector *aconnector);
+
+/*
+ * Helper: allocate a dc_link, amdgpu_dm_connector, and dm_connector_state
+ * wired up so that to_dm_connector_state(aconnector->base.state) works.
+ */
+struct replay_test_ctx {
+	struct dc_link *link;
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_connector_state *dm_state;
+};
+
+static struct replay_test_ctx *alloc_replay_ctx(struct kunit *test)
+{
+	struct replay_test_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+
+	ctx->dm_state = kunit_kzalloc(test, sizeof(*ctx->dm_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm_state);
+
+	/* Wire connector state so to_dm_connector_state() works */
+	ctx->aconnector->base.state = &ctx->dm_state->base;
+
+	return ctx;
+}
+
+/*
+ * Helper: set all conditions for replay support to pass so individual
+ * tests can disable one condition at a time.
+ */
+static void set_all_replay_caps(struct replay_test_ctx *ctx)
+{
+	ctx->dm_state->freesync_capable = true;
+	ctx->aconnector->vsdb_info.replay_mode = true;
+	ctx->link->dpcd_caps.edp_rev = EDP_REVISION_13;
+	ctx->link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 1;
+	ctx->link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	ctx->link->dpcd_caps.pr_info.pixel_deviation_per_line = 1;
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = 1;
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — all caps met */
+
+static void dm_test_replay_supports_all_caps(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+
+	KUNIT_EXPECT_TRUE(test,
+			  amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — freesync not capable */
+
+static void dm_test_replay_no_freesync(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->dm_state->freesync_capable = false;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — no replay mode in VSDB */
+
+static void dm_test_replay_no_vsdb_replay_mode(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->aconnector->vsdb_info.replay_mode = false;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — eDP revision too low */
+
+static void dm_test_replay_edp_rev_too_low(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.edp_rev = EDP_REVISION_12;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — no ALPM AUX wake cap */
+
+static void dm_test_replay_no_alpm_aux_wake(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 0;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — no adaptive sync SDP */
+
+static void dm_test_replay_no_adaptive_sync_sdp(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 0;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — zero pixel deviation */
+
+static void dm_test_replay_zero_pixel_deviation(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.pr_info.pixel_deviation_per_line = 0;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — zero max deviation line */
+
+static void dm_test_replay_zero_max_deviation_line(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = 0;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* Tests for amdgpu_dm_link_supports_replay() — both deviation fields zero */
+
+static void dm_test_replay_both_deviations_zero(struct kunit *test)
+{
+	struct replay_test_ctx *ctx = alloc_replay_ctx(test);
+
+	set_all_replay_caps(ctx);
+	ctx->link->dpcd_caps.pr_info.pixel_deviation_per_line = 0;
+	ctx->link->dpcd_caps.pr_info.max_deviation_line = 0;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_link_supports_replay(ctx->link, ctx->aconnector));
+}
+
+/* End of tests for amdgpu_dm_link_supports_replay() */
+
+static struct kunit_case dm_replay_test_cases[] = {
+	KUNIT_CASE(dm_test_replay_supports_all_caps),
+	KUNIT_CASE(dm_test_replay_no_freesync),
+	KUNIT_CASE(dm_test_replay_no_vsdb_replay_mode),
+	KUNIT_CASE(dm_test_replay_edp_rev_too_low),
+	KUNIT_CASE(dm_test_replay_no_alpm_aux_wake),
+	KUNIT_CASE(dm_test_replay_no_adaptive_sync_sdp),
+	KUNIT_CASE(dm_test_replay_zero_pixel_deviation),
+	KUNIT_CASE(dm_test_replay_zero_max_deviation_line),
+	KUNIT_CASE(dm_test_replay_both_deviations_zero),
+	{}
+};
+
+static struct kunit_suite dm_replay_test_suite = {
+	.name = "amdgpu_dm_replay",
+	.test_cases = dm_replay_test_cases,
+};
+
+kunit_test_suite(dm_replay_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_replay");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

