Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB0C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCED10EB42;
	Tue,  8 Sep 2026 11:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMwKeN25";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5D210EB42
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpUzhfJr6tpSqBUk8ya7F+xFxLzcOCp/0wUZDTiMvVLq5v1+byjf243krJm1hLQCUgcfMGOBwq+uu+PsrVXvcAzZrVEiVSMsNoMCXP6J+EmGzR1kSZzRxk57cCyjauJgmzKs8vqYSc3kpBkE+SxWPN0xy7uT5UqKp6P7TT4aF6++4SL02eaTfdj5Snn6cHLuoM5MPBHhx4TlwOni7gdbZalPqNOrAAhythpNp1XWgsE0SdVAKPFhHFiVCalc0PZUoYXCsXogSoGEgdVGo+/jg9T8tdy4TG+u89TNqhB7LmV4dNcBLNelwFmJoIBwh7FfEJB8WddCLprD2QA9cs5e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGkPmgZZzNyIUpLjBUY0A4MnPnVy9WjP+VllPytc+x0=;
 b=F9nbKNJZ+kWsV13r40b0K1yNa2hswflkbjpRwCcc8TvKZJXsZa+M2XfpWVt9mHbQBbklo6bJVsR3SrECULNbid1m/XAF8KQTovmRoDsS+VACAKLsj4CBBiFr0IdKNzmx+vIkBbDUk4bX77pSVOTUnCXsmh7ef8XQR6GiBXFupWdbuDIVfqk7TJ7lVCAh1ocKMkWQ0BO20bJdKIPtx1/SaVvHG+Ks8fH15lyEsHSxvtCXYjyP+PwTRhoMUsZO+pleZcq/cJDJZP/V3uAlMNPfHvbn7gpYJnGCO/sCJDfpUE3FgranQof+WWjIOYIM+sl0uKGhxucX3KH+LrtVi9HORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGkPmgZZzNyIUpLjBUY0A4MnPnVy9WjP+VllPytc+x0=;
 b=nMwKeN252sFoYU092DVlKSbw+gBmbgKmQpVXVK+G8IJSu3U5ziQpYU493C5E8oDteJjM5v2Vh66bSwlehvOr1s9q2ckh4buAaEzw8VB3h4ugpBRJS+4zoRxo+BP9WCpHfstkl5J8ox0XVP9JEmOVysIYAbn/mpUT9O9l/Gm4k0Y=
Received: from BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:36:12 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::88) by BL1PR13CA0427.outlook.office365.com
 (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:08 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:00 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 16/66] drm/amd/display: Test panic flush DCC teardown
Date: Tue, 8 Sep 2026 19:31:09 +0800
Message-ID: <20260908113338.2433445-17-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aab655e-fa39-418b-9df8-08df0d9d625d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: GBP6ed1MJJci7hIs1Nf6i2sw5ki9xjqsNHOyn4ClPOZO1s23heRY5TKApagC1lNuCCM/xDZyu2mZJ++JUk1x0Ky4j0eniVwrp3pDzS8VQLU+iubc82t0ZuV/Va32pXVWqX4iuVt/sGFTVKmEronlOtuDifzhYur9574ZMQ2heqpEPKZtwPQNpUcjBeRjA6VelHvli8G/Udl65bShKawaJH56SPO440DXqYuZp81Fuu879ZCjAt/6S1ulsPqrxlzoEj4t1i1e0+J8Cf3/fQHt9pqz5GLQzMFGzKRPhVJz9qWY2WmqYT0J+is3vw30gAbUsB/ZjZsQe3VdwO8I/zPJ2M9i8AjGPkpxBDSALPMLmxDElXvNFvRwN2+hkp1p6OMC/tQMsTtraESowfz3pCfiJglSfFzpax8ZXLXK3Rw9Y/2HxL/ajwVBYoj3D7x+RMjQe0QRUOfz3jUGiT8dHYz6DtK+EX0199LukKUdrB2Pb63qQOyboSYzK7o6PW7/2eofKk4PG6YC95CdjK94jfJ95IdgddbAt7GfS4CMFthOnPLtv1IxMdoSTQZkJz3MxwnOTso5YnYBhjhPJ71k4slA1+xri61/gdAYpMe4XrXM9SOHijkqg+oc4pwgtAFFVZWmJ8OuO4cGcPIaPTMMwzo6/hgT9Tx3jGSwi0LR2q89oqRdeir6yY0sadY4eqH63mYhMMQm8uR6z0ONxwIEClOc7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LqGbHsFpy+aYvNCf0zx5AFl7tFTwRqHWZ7xlRYM4qtxgHwE4NFBdGm2fMEhacZ1NxlgSHWKTmqGdCX1helLeGlPeenfKEFMNLnC2rDR6d3XQWMD+/0727VDCJ5V8mpQaGYQafLBh4orQeTl2uOizGNKlXBOMM53SjPweNW45ziBNq1TZb28qGBVp+8atR2lYeeM+e7txc6pVHZTyCD+eXI+PK/8S/XPAK3s9Za9hpYbPbi/cyR3uxHJt0Xv2FzK1ywE1gRel9qAOCyvVxMkInPZSMDoOdyjol4coqZz2Pim2+JGHWWrEF/HI9X2fTp3WU3LiBqemEWYFLpSdgOV8MLtpEOyFYOncTWkj8fTiEyaBRWGdignXG405iXEcWzWyabJUBmypRk6wCMJjv16mDMD51umUngPLxfDR25oK8gXa/LZD/qxnjTKfljVstwbn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:12.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aab655e-fa39-418b-9df8-08df0d9d625d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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
Add a KUnit test for amdgpu_dm_plane_panic_flush() covering the
request to clear DCC and tiling on the active pipe.

[HOW]
Install a spy on dc->hwss.clear_surface_dcc_and_tiling and drive the
flush with a non-linear framebuffer, counting the calls that ask for
the tiling teardown.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index c71e241df7b1..20826691b55d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3885,6 +3885,62 @@ static void dm_test_handle_cursor_update_no_stream(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->acrtc->cursor_height, 64);
 }
 
+static int dm_test_clear_dcc_tiling_count;
+
+static void dm_test_clear_surface_dcc_and_tiling(struct pipe_ctx *pipe_ctx,
+						 struct dc_plane_state *plane_state,
+						 bool clear_tiling)
+{
+	if (clear_tiling)
+		dm_test_clear_dcc_tiling_count++;
+}
+
+/**
+ * dm_test_panic_flush_disables_dcc() - Verify panic flush disables DCC.
+ * @test: KUnit test context.
+ *
+ * Verify if panic_flush asks DC to clear DCC on the active pipe, and requests
+ * the tiling teardown as well when the framebuffer is not linear.
+ */
+static void dm_test_panic_flush_disables_dcc(struct kunit *test)
+{
+	struct dc_plane_state *dc_plane_state;
+	struct dm_plane_state *dm_plane_state;
+	struct resource_pool *res_pool;
+	struct drm_framebuffer *fb;
+	struct drm_plane *plane;
+	struct dc *dc;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	dc_plane_state = kunit_kzalloc(test, sizeof(*dc_plane_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, dc_plane_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+	KUNIT_ASSERT_NOT_NULL(test, res_pool);
+
+	dc = dm_kunit_alloc_dc_with_ctx(test);
+	dc->current_state = dm_kunit_alloc_dc_state(test);
+	dc->hwss.clear_surface_dcc_and_tiling = dm_test_clear_surface_dcc_and_tiling;
+	res_pool->pipe_count = 1;
+	dc->res_pool = res_pool;
+	dc_plane_state->ctx = dc->ctx;
+
+	fb->modifier = AMD_FMT_MOD;
+	dm_plane_state->base.fb = fb;
+	dm_plane_state->dc_state = dc_plane_state;
+	plane->state = &dm_plane_state->base;
+
+	dm_test_clear_dcc_tiling_count = 0;
+
+	amdgpu_dm_plane_panic_flush(plane);
+
+	KUNIT_EXPECT_EQ(test, dm_test_clear_dcc_tiling_count, 1);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3973,6 +4029,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_atomic_check_success),
 	/* amdgpu_dm_plane_panic_flush() */
 	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
+	KUNIT_CASE(dm_test_panic_flush_disables_dcc),
 	/* amdgpu_dm_plane_drm_plane_reset() */
 	KUNIT_CASE(dm_test_plane_reset_initializes_state),
 	/* amdgpu_dm_plane_drm_plane_duplicate_state() */
-- 
2.43.0

