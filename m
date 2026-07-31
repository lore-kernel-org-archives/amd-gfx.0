Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D26C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C9E10F3FB;
	Fri, 31 Jul 2026 21:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="So7hvK6K";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF4E10F402
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgKYzeaNwkbzO+fx8BfJJ4yPwJIVwStAfEIjL0RgKxDfLLkDtyoYTszRE1cFhx9mAlquwdBLeJZseMRqopSJhPd7d/7iRNTK6lLwUst2AVvrqzHKS/Eprt7Yv83ZDQfq55Bo2t40kfE+jreQ+dg3WkWa5Zjbyyulg7U+X5VegLfH01BubMiSbVqjgDO5l4vvQsERTvyUoWdYqfAGwLp47W5j9gFxp6ZMBEFVL7x+fqsUaDgK/X/otkpqxI3kk05+LNHQQeZEzyKetmllg9+StrYPHIwZmPN7J+1z/bXQvUgyAA9DYqRe5US+cU7NwGgprRIhknYukIOXjoWU4pvm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emOutDCgvWtB4X9JDkhlCOGUeyNq7W9aG3zL8hDmTh0=;
 b=XVl0F33tt16crkbCdD4hI87GDBR/ZaDK+9BiUYl5dYLVj19mOTsj+B3Aov/+naBR55pF350jbRDXZUfLU04fxjaqOln88jYBT8/M1iJbxUTnuW88GveTCv6k2FEa3QPsMpUaiVi141mXnVLu0zobEr1LYcJ1g5rVAeKTqyw9VV8AM/Bp/iwNrDlI6DHBinG0OPKyO78/nKhT0KOIk40eaKwfquo5RA/resD96RsJRBT1QSibMCmTDX77omAEMRmjYXLs7wcba6Ds5K7awy5Z/OhykDx33VQ3p6GJ0nWmEXguJD+QnZDpIrESQZURYWF7AW3QSqV/yQcx/mxe15C8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emOutDCgvWtB4X9JDkhlCOGUeyNq7W9aG3zL8hDmTh0=;
 b=So7hvK6K5UIA8I0usBY5jXL9c6c7zxoc3tqaQEGfTEskyqpDM6OGDe3zocH+dZhytUufx0BWw5HGet7e/wbSJnZaN3NiwCfHtHPiMR+l3Det9OXe6aOIR7/sslDxEWbjvjlCohE3AnuXJVUWcklBM/lBDMgRHsNKiFqw/6yFcEM=
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:56 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::49) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 21:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:56 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:55 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 28/41] drm/amd/display: Cover crtc vblank restore
 replay-supported path
Date: Fri, 31 Jul 2026 17:12:49 -0400
Message-ID: <20260731211302.3040343-29-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 608a0b1f-e17f-40af-88b2-08deef48e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|11063799006|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: LFaoycgOWr3GLxQhxf9+l0D1ImnIyZg1Vb4FgLG6l/XXoed2xyPSJtUyAvMrNYXm+1poJ68Hc3R+Jp9kfizAmHUzbBh8mOODrnO5Dd+5lAXpHJuZVMIErnWZUeb4CYzKDop+T4dhaywKcTBwvQehpNI6xfaW+A++JmmK/AjU5ojwCa5RsGmNzm6qvlMlTHEG6MCM06Kd9osTid/m51tt0FvH/cvbgduTWqtEJxCxEKCqFDgWgaUmmA/U2f5WTSuBZ4EVFnF4xP9i1xbxZ66ckRt+7efV9vXXtGF/o1XTE2DthbUg+I4j6hLOAsNi61nwgoej9T0kRDFvo+57ONdX+8F0GUGfKw+Z1PYqtxsaDPgIxyz/3dNs20s4tAjPhRIynO3gi4E955iBbVIMcJWYSTOwQqI0JM12GXKUU0kW/MA98D0lf44NJ65DGIUwU+KrscB9xuta/DIGRs76wWWzDj/IpAaycuJF2dwsAzPZcQ5r3jKUf3wNFVA+L3RyvTS4QrsBFGliyQ0ta/655Y28ZusRWTha+auZ4UeXq8R3ZeplcpP+1rzBhBt4FjKmU9UZ4JVc2J4Uhlqhiw0agO4NT+J0zHRaQ9ccBYSRmT1LtJ4qU9H1PH/CKKk6cCJnzirEHGGCerGEQLzyoLl+sVW1taYPUUFMlHTg6EAfihtNCGhC+E+HIvdQe7VAIh3nrJr2mP/SrMZaF9Ggfd+qMQ85GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9CF63Ua5CKJkMNv8OPoO9owA9WEsiYAKLJmqMDDJpnm8JfrQnHekcoWdQDr/M97ebzmXRJSKZoue7JIEJ9q9IVMekSPrLxJ8KRH9XbJkxCNmT/4LS0oJ8WRVBN25vx597CQexMu630dKTv250miGFY+PhJubXn084EJwPrre9cCs/lk0dI4QW+GhRndK4ovfv49jOvO5V2UkD4xG9HL0lcHx7B3wDUiM3W4anSy5tAIx+1xCII7xOjWAGSffcUbh83Jv5oXQKzwxWaTzil99PEHrJXqD1eR3xhEQtSIts8hk/2VB3iyC8F+0ai97658pWy/IXbPWfZQBmP/pZs1RVaL9TSgttjL1KS9Xt05uR2ZStlCZax2wasDeJxzcn9JsUs3iGlJXpftk6YUFkYwsJdLbCefsRy8FCRLVPwpbs98UFTGZPN7gg9h3YsWznugr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:56.5540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608a0b1f-e17f-40af-88b2-08deef48e96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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

Add dm_test_crtc_enable_vblank_ips_restore_replay to cover the
pr->config.replay_supported side of the sr_supported OR in
amdgpu_dm_crtc_set_vblank().

The existing IPS restore test establishes self-refresh support via the PSR
version. This test instead marks the PSR version unsupported and sets
replay_supported, forcing the sr_supported computation to fall through to
the replay branch while still calling drm_crtc_vblank_restore().

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index b64660064902..805c171564c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -1172,6 +1172,57 @@ static void dm_test_crtc_enable_vblank_ips_restore(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
 }
 
+/**
+ * dm_test_crtc_enable_vblank_ips_restore_replay - Test IPS restore via replay support
+ * @test: The KUnit test context
+ *
+ * Same as dm_test_crtc_enable_vblank_ips_restore() but self-refresh support is
+ * established through replay rather than PSR: the PSR version is unsupported, so
+ * the sr_supported computation must fall through to pr->config.replay_supported.
+ * The enable path still calls drm_crtc_vblank_restore() and completes.
+ */
+static void dm_test_crtc_enable_vblank_ips_restore_replay(struct kunit *test)
+{
+	struct dm_crtc_state *acrtc_state;
+	struct drm_vblank_crtc *vblank;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dc_link *link;
+
+	/* DCE_VERSION_8_0 supports VRR -> the vupdate-irq branch is walked. */
+	acrtc = dm_test_crtc_setup_enable(test, &adev, DCE_VERSION_8_0);
+
+	/* OTG unassigned -> amdgpu_dm_crtc_set_vupdate_irq() returns 0 early. */
+	acrtc->otg_inst = -1;
+	acrtc_state = to_dm_crtc_state(acrtc->base.state);
+	acrtc_state->freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
+
+	/* Non-NULL get_vblank_timestamp keeps drm_crtc_vblank_restore() quiet. */
+	acrtc->base.funcs = &dm_test_crtc_funcs;
+
+	/* IPS enabled and not fully disabled -> first restore condition holds. */
+	adev->dm.dc->caps.ips_support = true;
+	adev->dm.dc->config.disable_ips = DMUB_IPS_ENABLE;
+
+	/*
+	 * PSR unsupported but replay supported -> sr_supported is driven by the
+	 * pr->config.replay_supported side of the OR.
+	 */
+	link = acrtc_state->stream->link;
+	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+	link->replay_settings.config.replay_supported = true;
+
+	/* Immediate vblank disable is the last condition gating the restore. */
+	vblank = drm_crtc_vblank_crtc(&acrtc->base);
+	vblank->config.disable_immediate = true;
+
+	adev->irq.installed = true;
+	dm_test_crtc_arm_irq_src(test, &adev->crtc_irq, 1);
+	dm_test_crtc_arm_irq_src(test, &adev->pageflip_irq, 1);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_crtc_enable_vblank(&acrtc->base), 0);
+}
+
 /* Tests for amdgpu_dm_crtc_update_crtc_active_planes() */
 
 /**
@@ -1814,6 +1865,7 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
 	KUNIT_CASE(dm_test_crtc_enable_vblank_in_reset),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_queues_work),
 	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore),
+	KUNIT_CASE(dm_test_crtc_enable_vblank_ips_restore_replay),
 	/* amdgpu_dm_crtc_update_crtc_active_planes */
 	KUNIT_CASE(dm_test_crtc_update_active_planes_no_stream),
 	/* amdgpu_dm_crtc_count_crtc_active_planes */
-- 
2.34.1

