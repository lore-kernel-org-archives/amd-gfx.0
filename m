Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C2C44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEFA10F6F1;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLgERtJk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCEA10F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BITLN0ibEf1/R2VTUzI1p3yaWOVLFFlCSxD1lKFA4RFSL1qdcGK24cRdhinznYSJ11RBQ0amGKHg6Ud4OPLrgEvk1JTABn1E7yq6/tMqG5gv5bmUX0Y1bq9T0wyEojnjwfRRwBOsw5x+qRxH2arxqCv8Mi3Ks2gmz6MlOM9j/h+Nfxd59VBYodbKTwPtSKi23AN3x0mLnkukamKyvhJvYXP2DOgCZYh+kzQ3gmcFIga4sKBlq0N6ISY+fD4bISHvSecMb8RYs+d45YVPZU11nuP4omkLyhf2/mhTrnx2+brSrBUGObp/bCSfaXTTKi2z6LZSrYdc6E5H2RPvJ7UxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms3rbsMca1Hvjf369hRrZ/oo3xQ0o6r16/PHtD+ZbVQ=;
 b=vPoBRqKFPIWlRyz4bTXmzwX7NS9LaBFqhHk33FdTS5zOztVeshuSQaN0ZhyllPW4rKnDwqB+GFwYK4XFJ346XfiwU6MDOADfAlPK2YqxLJ+RlURHmVoU2uzyLMdAuI50uDfxNQkX+LMCG3I0VrH9gt7FPAqN5K9q+gB4NWP452kmDxjPP1bLi4J++ioaSDFrdM5lZ2Vj3KJb+k/uMe66H2rnojKJIYuYLZeU/81qGJtvpAnjzOvhoXo8S9t2Lxnbl0XPU9xy8VGdmGVn7OMFi1Gr/oaxDmLFqFnW9iqAq8FHIQ4Qcf/Dq8/MBT7tPMStfMxFwANPYK6fbA8D9HonMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms3rbsMca1Hvjf369hRrZ/oo3xQ0o6r16/PHtD+ZbVQ=;
 b=vLgERtJkHPZkDqWH5/aUfujwNFU/magL2u+iXPWiTWpLrPVSDNcZidbf68cMhUSgehQD0Ja2jzvUa8Kt1jL1y6qooWuKYLLqLO425IcfbtmqfGg4YvqndnQsvXrusKnW/vPkS7wrZnoGVZGxL4lQpVgYnJZDHh2C18UEJiXT0jw=
Received: from MN2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:208:1a0::38)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:35 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::7d) by MN2PR07CA0028.outlook.office365.com
 (2603:10b6:208:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:22 -0500
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
Subject: [PATCH 60/80] drm/amd/display: Add KUnit test for wb jobs
Date: Thu, 9 Jul 2026 16:48:28 -0400
Message-ID: <20260709205936.5719-61-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dc03a9-5cb3-4fd4-61d1-08deddfd66ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|18002099003|22082099003|6133799003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: SlTyX0wt6snq7AyYnPdjjhH0WVjliUP2BRDiFl33U4zzBh//86pZYr3Kxu4KlwnYNHJh6uMh1jmgMS0XXu2h2C37/TBDYJYruRwySjXCzZieHYGvHnsK0RvRae1o8v9T9k+UhpWpBSOnDiWC23vF/J6EgHsiNj1yuGNq74MGVuUmhdEpuPciwfp7t+LzPDaPoeqDxBMuoc02M2sHonOJELhqTKgWlyF5vDobaIZ3d3vCuq+OyFOhVuKVuhlZ5nulRW9HHuSgQ3dtU5nr+UJkccgmTN/krvj4syrcH7lFvnQxcwTX6uO7TA/Us7Et1v1GLViQVsHsnPz1Nl7Xuyy436kDJyra57f2DGfHjO/OzAoW+kc9lgU6RSstBmhnEoSQSc74NOz9WkNaduqafFaXEwQeTuId5aLSZdNeAN1Vn3XDkpBe6nujRScaAJRYMPzcLmLpaNVhPry5ZlkhJkhqoiiQCquCKsmyxI1JYLmtYsJTwFBiByCrn87RU9p6P6y1/wNnse2/9ub0QvekcPx8OGESNxqhDQjHZ7m+//hVppzaYJJd76yl2fzteqySVM9q5ddPAFmpVT+wp3DhSqNSEHBWk3JWewkWewC3x51tCpcL/DlEszYZA4DhrrzTAa6WVZedDy60loEAJUmQOaie+TT6iwfaMemvGcFXSEl39QhJGkiOYK9381/bX2mrJ8U3Tju6Ixghz/+GSsNQodEpLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bba2rDl88LYawdnSAXELeXEI8WH6rfQ5RO1rz+WihuUx6sqK1HM+2oN7AGevzNkPhZ4RyWcLjksbbcCmIte+sxb/kxnIJauVeNjgjznDGaQOr0ZAbbbhDanwrEzy+oVJrRnhsOB1esW8rEZFeWdQD+rYfEr9vu5Y5UO1TlHWCqeRNwUQ7eXUjZhdAfkd/XuKgeUKABhTERfrEO1gniSghqNT8VKfpqiDzHjwUiFjGN681uAjlnmgqT9b8hNej/7BogiJAFKED5FT9JsIvx/hX7OnyZ44vvIxdvLcCs1I1PxsG0andFA5yCwb6lzMnLdQoRm4DrgRAZ90vSDP6vbLbMOkLf+FmlXszWxdi5dKEejRi+OFcOLR/h/UzmvTZyV3a0Z979xbA+SzOBxdGieK3HQ6/KaXAPKCpKdznbaQd/u5XQoGGKyDUlDUHWE+skiA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:35.1856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dc03a9-5cb3-4fd4-61d1-08deddfd66ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Add KUnit tests to verify both functions return early when
job->fb is NULL without touching any buffer object.

Assisted-by: Copilot:Claude-Opus-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  6 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  4 ++
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       | 44 +++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 0bf82e46f773..1fbb568a5c80 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -85,7 +85,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *conn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
 
-static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			       struct drm_writeback_job *job)
 {
 	struct amdgpu_framebuffer *afb;
@@ -146,8 +146,9 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
 	amdgpu_bo_unreserve(rbo);
 	return r;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
 
-static void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct amdgpu_bo *rbo;
@@ -167,6 +168,7 @@ static void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 	amdgpu_bo_unreserve(rbo);
 	amdgpu_bo_unref(&rbo);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_wb_cleanup_job);
 
 static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs = {
 	.atomic_check = amdgpu_dm_wb_encoder_atomic_check,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index 7e9fd7a036fa..5fd616bc43b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -44,6 +44,10 @@ int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_connector_state *conn_state);
 int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector);
+int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+			     struct drm_writeback_job *job);
+void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+			      struct drm_writeback_job *job);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index c71f61a2438d..b43bc244487e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -364,6 +364,47 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
 }
 
+/* Tests for amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */
+
+/**
+ * dm_test_wb_prepare_job_no_fb - Verify prepare_job early return without a framebuffer
+ * @test: KUnit test context
+ *
+ * When job->fb is NULL there is nothing to pin, so amdgpu_dm_wb_prepare_job()
+ * must return 0 without touching any buffer object.
+ */
+static void dm_test_wb_prepare_job_no_fb(struct kunit *test)
+{
+	struct drm_writeback_job *job;
+	int ret;
+
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+
+	job->fb = NULL;
+	ret = amdgpu_dm_wb_prepare_job(NULL, job);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+/**
+ * dm_test_wb_cleanup_job_no_fb - Verify cleanup_job early return without a framebuffer
+ * @test: KUnit test context
+ *
+ * When job->fb is NULL there is nothing to unpin, so amdgpu_dm_wb_cleanup_job()
+ * must return immediately.
+ */
+static void dm_test_wb_cleanup_job_no_fb(struct kunit *test)
+{
+	struct drm_writeback_job *job;
+
+	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, job);
+
+	job->fb = NULL;
+	/* Should return without dereferencing any buffer object. */
+	amdgpu_dm_wb_cleanup_job(NULL, job);
+}
+
 static struct kunit_case dm_wb_test_cases[] = {
 	/* amdgpu_dm_wb_encoder_atomic_check */
 	KUNIT_CASE(dm_test_wb_atomic_check_no_job),
@@ -378,6 +419,9 @@ static struct kunit_case dm_wb_test_cases[] = {
 	KUNIT_CASE(dm_test_wb_get_modes_bounded_by_max),
 	/* amdgpu_dm_wb_connector_init */
 	KUNIT_CASE(dm_test_wb_connector_init_success),
+	/* amdgpu_dm_wb_prepare_job / amdgpu_dm_wb_cleanup_job */
+	KUNIT_CASE(dm_test_wb_prepare_job_no_fb),
+	KUNIT_CASE(dm_test_wb_cleanup_job_no_fb),
 	{}
 };
 
-- 
2.55.0

