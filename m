Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5FCC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AF110EC97;
	Tue, 18 Aug 2026 20:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BClhP+5d";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D471410EC9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtrbegomWHOM6w4S0cTDT2UvvXdXvH7e67BEr8N5b0vfNchy55PmHcdo+uHI3rWJPbFkhhdAJypba7y/38mbrM0vVMOc3kZDGxGCCZd0XmtCUcoaUBJxPJoKkaRro3JdCk7KqF8Hu3cd4kyBg+fGdVQCZn1ffI8KO3YvWLa+3Un1w+QPUnKRB1GrvX00e4kZK+5BNxZRYVhjFIQxjkK9tBMTDj086lhvlt2dujUE6DbNM5N4QZwZq/FsWiKT4okSiucYd9FC+HrTL85ok6yDqYdvznIoKJpgywoh6VqoMdTju4YxIDDUk7Ko4nnQBggnulCmFGHEiohG66H4IYh1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTnbybUryYYmaY9QqZwtawYXbaywmdmHuq6/NFUtggc=;
 b=g3NCuJCw6i9RHk/JyDonPYAlFGwS26jLP7sBeuRcuw0Z+iTEFukD4P98gy1/639rEJonQbvhN5wqmx0sEcZ+nH+f682QTlTkUZIvrvXoDizqy92VOfT3/3FyYyZhhU7/oNpsnnxL3hs+NV2CF+SLTQ8/cvPOPvGUdNYpQYitBcI0F35Vau3o7hgfb3gObWR+OcTv0UXpOHocjSZTq/mqHS9eODND6bjqWEObPXxE0bCgYA6HWxYbNCuZyRT6RCQ0SMmegYPjnPxzfkVG9ckedvH0Z4M36xwDL57bTFZ/1/Xjwjy9qZxVQ63Gg6U/yIVq1GweqfGEnF+vsyahmYuh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTnbybUryYYmaY9QqZwtawYXbaywmdmHuq6/NFUtggc=;
 b=BClhP+5dJ92yLNZWYWJBDsWn91+CSgQK2hhsex/QBbTUv0hS7v8r5+jCakkHXu+fvsbdDADVK+EKdGMuDugTt8O8kwCSI5MEJvtLM9NcCFocB1b9iZxnDANgPp7MDC5p4fGTIeBzN1a+Bus9Lac8tT5HhqwdMxkLgG22JFeWsl0=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 20:22:22 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::1c) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:10 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:09 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 23/82] drm/amd/display: Test dm_helpers_is_dp_sink_present
Date: Tue, 18 Aug 2026 16:15:15 -0400
Message-ID: <20260818202139.4172592-24-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4d0db8-6d96-4321-93de-08defd6668e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jkrOxu3VTYQh/gmiJdrbBaGF4XK8eN8U2dRX6hIW5+D72TpEAOWqRts3g34BoKA7yZBeTgyjisn1YNnTc2U3C7CN56TSLTTqMeXLgA/isGYV5aHImVE1niT5E4eaCJ6+T2jd9QWRYFQy6tUzzGdXVM8lAMMSjBTfxlplPslACcAnYAYprAzSqXJ2YrZfD/oVlgUAir57hGWdeuvQkzFObriDAWnCES7LkAUHdgO19v651t5k7SWk0Hiws8cRq4227i5mV0Gp4PJoLQBBcyg3oGcj3fqRfVjbEpchKk5Umk+PdBjFlPTR1aRC1aS8KnGIJ78Tq1jOi6VsQNSPFSiLE+D4FwbuCC755iBaw+MGTEat8q2VtnLxeYVUu2z5qGD2zTx+TUD8CUG0MhgGQPLk3jJ793NkJczZp0XeJSHI3noRMkcxMobs93egoPRaqvOU/fNI+RP0sffyRxcOGgmzqQczbEtyDbHj/5V48qWYfxGNBclkWXXqsxSc3spjbqrBJRJdokiEe6aju8lQ0MEW/geX+3olNoGGgOMNjaLs37B8O382NDCiTjPFa15vX7ed6yFrYTjEC1ORkK8uS93/YetF3KZgNfDcm+0I94IZv1WucjFkFxbiuJdGtynAH99fYs2wzAcWDjKTHpPQ+mYs2zldIHxK++uIwFIgYbxTE+vOeX7Pp7vgVp6xe0nrXoY7gwBILl6Rhe5T8I6o24xzcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FBlWTp3Xa+ex46SEdQ9hMS+l6N1d/Q8SFCMaOwhdxzYe/Ij051CCm15/0IvxT5Kgr0fxvEoq81KqlC9rTTzdZ8QHMwhmWrUJSkFa6WLcsM4xfGR3opUmbL8YFmL5lbhm5SdR8iCSRXjlnJroxjjlKbQ7WsAjkM4apiCIagbdCMgkQtH10WUT8iBniPYkAJ/Ny23nqH4fM2eCQQx+4gAA+k99Woi8rm4nCOyJMc5ODbBv8CP2PY8jZM1cC51T3TBxppdgyvzNyMwyocTyD3OsXFk0Qty74LWnHD1EphoZkaDPrOrbCnFLhCNym/k0bc+N9ALya8/muDwcuNuHcam3HF8Xhvq1kkrnL/nbQ0H31ENyibfvROOxdIk5QXMMSvg2G3EUr1B7DrRru2hMRySij3qPy/CoB4SmvMed4RNbq1eofmIvzmJgS+nZoSGR8cEi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:22.1116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4d0db8-6d96-4321-93de-08defd6668e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
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

[WHAT]
Add a KUnit test for dm_helpers_is_dp_sink_present() that walks past the
early NULL checks and reaches the link service query.

A fake detect_dp_sink_present callback reports a sink, which covers the
DDC lookup and the return of the link service result.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 170e0ee425b23..b0733961545dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -12,6 +12,7 @@
 
 #include "dc.h"
 #include "core_types.h"
+#include "link_service.h"
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
@@ -4043,6 +4044,49 @@ static void dm_test_dmub_set_config_sync_unknown_error(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)result, (int)SET_CONFIG_UNKNOWN_ERROR);
 }
 
+/* Tests for dm_helpers_is_dp_sink_present() */
+
+static bool dm_test_dp_sink_present_true(struct dc_link *link)
+{
+	return true;
+}
+
+/**
+ * dm_test_is_dp_sink_present_queries_link_service - Test sink presence query
+ * @test: The KUnit test context
+ *
+ * With a connector present the helper takes the AUX hardware mutex and
+ * forwards to the link service.
+ */
+static void dm_test_is_dp_sink_present_queries_link_service(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+
+	aconnector->dm_dp_aux.aux.drm_dev = &adev->ddev;
+	aconnector->dm_dp_aux.aux.transfer = dm_test_dpcd_ack_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+
+	link_srv->dp_is_sink_present = dm_test_dp_sink_present_true;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_TRUE(test, dm_helpers_is_dp_sink_present(link));
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4237,6 +4281,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_gpu_mem_alloc_and_free),
 	/* dm_helpers_dmub_set_config_sync */
 	KUNIT_CASE(dm_test_dmub_set_config_sync_unknown_error),
+	/* dm_helpers_is_dp_sink_present */
+	KUNIT_CASE(dm_test_is_dp_sink_present_queries_link_service),
 	{}
 };
 
-- 
2.43.0

