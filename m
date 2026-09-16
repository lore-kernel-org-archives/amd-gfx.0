Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5913C982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1980010ECBF;
	Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fO9OrVPV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A04D10ECA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uO30KP5IqzJTo/OvGKonX8E6XddqDJEDuCsPQXOn41cNE3Y8Ly0ILhjtwPGQHf/UxNLikiaanrn5uCBbGKZhECm4jbZVfX3f0wrP3Vvp4DkmOsks9bnq4H1k5Ami508+/eLuQydJ3oeYxOd7hff54uRF7KLEpHWT9k2yb87+uNSyTLM7dizlROHmdcgkok/v8mN39Zfe4vwgsy0F/XrPdep4zqaLH+L5Aw+HiXkuLYOV9fmmlZ7QMzLSm0ASvZZkia68zeFufWg3Wd2O4Wao8YPhDWGhK3nfB6XK2xN7/nKAl0i223crxSUsI5rE92PrLkYtiygpvvqXN4oyJvUu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJpp+PYcq2zNrJ3aJXdo+aoakIzRe/VTqLq/hoJy6uY=;
 b=jtMoK8BSeo6q90lRVG1X4QXY0NBjl5P/wY1m5ROywbLelERy0aDg8cyQQT9dd6vO0eUwOhbZl82eHHgeFqIE6SP1Yq06yrg2vI9GHuyTgtez5P6l++EvIKzyy2vTa6ASaItwTihTVNLRo7f0S0N5qbD0+RNGB+CtkomXqLZA/TSRfFTNsur9AwGhJYuoV8pvoTtCBfvADctnlE1fOwTryR3bXf+iqQZ/JAB8V40UMZPvi36nTyoLMlWp688GO3h6nwGr8HPp8lDT+CMNHN3hIPIk0YMS0nXTPp4Yl+HI1VCmp4syTT/AqXfC8z+qg0A4O0hX6Y3eDmqyoDyUgmuqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJpp+PYcq2zNrJ3aJXdo+aoakIzRe/VTqLq/hoJy6uY=;
 b=fO9OrVPVhDynBmLjQhSlhmIcyCGvKObbCnVUq+Qt41x+PY8zYkyAtft7n//xZ5STDkrdeIqvJmRqDibWfmoP7jxRwYaZi1/yM1HW9NXzdhiBRe+fUcFNPWIEhtPHviLgtfosIunSBEDV4lzaGIsPOgK7prV0UGQand1ObzUDdSE=
Received: from CH0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:610:e4::30)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:51 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::8f) by CH0PR03CA0205.outlook.office365.com
 (2603:10b6:610:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:50 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:36 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 30/64] drm/amd/display: Test MST topology start
Date: Wed, 16 Sep 2026 13:51:45 -0400
Message-ID: <20260916175301.368306-31-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fff09d-d004-470e-3dea-08df141b537c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5rttSDlThGLiiBQmH1uP/5m3G14Dj+jFtfY3yDo7nf5f+enA08C02Q3bNGXhUZQL4uzjiuMfl6DiWGlaPv4w4Vr3Fm9tFUeRgndkuekhOa/W5WKzr6eBJHHTzWusyjvciQaPg3S56A2ufiuOL/fgvUG+VxTuvQYwUo6y3VBrKPfvkm3/UmrqOjak5mHhJaeCWA/tVwTMyNPvw5Yj1nDeOhIRyH8V7bm9P70Bf+PplAaI97D494DC07ZNg1IaRlQm4RGWeDLTXdTM1f3kyIm+kw/xDSd3W9Z6lppsf0NjINGAXhf2MhuUR5lusRCOejlsoHd9qjJiJuF9BNK7sJaA/ax3t35S2O5Q27zN5V6t1ES53LP7ZsXXfqIeenf+jXb4zlKwE94vnCKLiBe2aGNTCAi/vdtpi2ftX9sqMlaZvPVTzolNt4EMubMZY4IFV+kYIzWWsMjG5Gq8XhDC7bd1Mrn+H+7YVOGepE0jp0/eTMUwhQmt8mOf9aTI6reHlca8HhHQpnxGxWFDozILbU9lG65BslRYMbOYwJeLYebmiltALIj/tWEdgTot8/he7TnRlF22+XEcuohWmYE2F2SDC36Y1xkGYVju/Ab1sknmOSFunG0ZZH4r1Zc/hFNxZPo7LDcUqFvgqbt2skC7VQdwUmSiZdtdIdZCBESsZ/aQrTiqpBa0esXJtD7yWGD776Rm0CddLaxFuua4bnYOPZ4+zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wFpC3fAHdU1OHn2qNVB+6/Fwg3m76+sLU/uQP7mgdOuxbK84U8WzSGAaeuvA0dvLzlxkcnZzFjkWhStolQabMwQ3Hop8ncfF6sc+AUYmLyBYN+uKNczJBOV88WBgQ4Bm0aOe+aXrXph69vryqkW1KkU/Pz0xZKF88SWafneYYASgVsHj+qXizIDnV8L9oJEqNcv27bjbtcE/8YWfNqagvlWNS25WA0OWXNhQugH4rl/ZKfihOwLRJv6SHw8SsaS59MnBpBQD7Hpd/mMenYBxaDw0kT60RzyBzxs83yhb5Y8U7ltP2g0iyV9bSLSC99Uxlk7NcKFEQsPm62dLgXjoMbTXmbWhbpzQt7V8Gp4i+VBaIV1nIrvcqshseX19hrW21JeCDNtrG+XDjopKaAFsrgOs6EiTfIkKusN5LSNsnv9HYLA/7RU/s3x/nnCLqd4z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:50.6649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fff09d-d004-470e-3dea-08df141b537c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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
Add a KUnit test to cover dm_helpers_dp_mst_start_top_mgr() its
success path.

[HOW]
Mark the topology manager as already in MST mode, so
drm_dp_mst_topology_mgr_set_mst() returns success without touching the
AUX channel or queueing the link probe work, and the helper reports
that MST was started.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index b38601c1da5a..09eba15c2705 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -3535,6 +3535,30 @@ static void dm_test_mst_start_top_mgr_set_mst_fail(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_mst_start_top_mgr(NULL, link, false));
 }
 
+/**
+ * dm_test_mst_start_top_mgr_already_started - Test MST start on an active manager
+ * @test: The KUnit test context
+ *
+ * With the topology manager already in MST mode,
+ * drm_dp_mst_topology_mgr_set_mst(true) is a no-op that returns success, so the
+ * helper logs the cached DPCD caps and returns true.
+ */
+static void dm_test_mst_start_top_mgr_already_started(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	link = dm_kunit_alloc_link(test);
+
+	mutex_init(&aconnector->mst_mgr.lock);
+	aconnector->mst_mgr.mst_state = true;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_TRUE(test, dm_helpers_dp_mst_start_top_mgr(NULL, link, false));
+}
+
 /**
  * dm_test_mst_stop_top_mgr_active - Test MST stop on an active topology manager
  * @test: The KUnit test context
@@ -4881,6 +4905,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_mst_stop_top_mgr_null_priv),
 	KUNIT_CASE(dm_test_mst_start_top_mgr_boot),
 	KUNIT_CASE(dm_test_mst_start_top_mgr_set_mst_fail),
+	KUNIT_CASE(dm_test_mst_start_top_mgr_already_started),
 	KUNIT_CASE(dm_test_mst_stop_top_mgr_active),
 	/* dm_helpers_dp_write_hblank_reduction */
 	KUNIT_CASE(dm_test_dp_write_hblank_reduction_false),
-- 
2.55.0

