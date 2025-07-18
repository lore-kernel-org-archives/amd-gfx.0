Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1FFC83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 15:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F34E10E9EC;
	Fri, 18 Jul 2025 15:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmKv+m76";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3119C10E9EC;
 Fri, 18 Jul 2025 15:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm/5X1EGebLQDRNclb9av6BUYmhW0CHvRbESo0/fIA05QidzV7GGxSpuP4inNBQpGMFk4eOBKfVrb2BHXsv8prSN3IsnZnzuyv8s4N9JOs2pzmeUgavLw5RaWSPmiICg+zuDU9MYO0gMkAJhn9dXAjmGptQzEpyMhml/uTM4G/x3/1bpPubaC3DzNgBrKaO4HQ6LqyTgsYkANr5221KavFgON/RU8Cdr20GWDFdeKPr7/XDbq+74g626MnNiGdYqDCOiUwqOxpEmMnvdtTOKI8aC0QNPg0A1jqKicYJ1iOn2Joa9jERlhgFKOW2/zZfEWdtwNil85M67IQgZMHd+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX3GcmdfgFUzmkj5qSqJAXmBb95Z/1+kRpvJSEf2rnY=;
 b=KuFuIlAM8E0CrmzIc+ysVkqPtIO5zp/jeyWANPn7Ra0rQGllpxMWsskSrgyDXunbXRIh60tmgdXaIy6kTb0YQDUxSYqnBICwC2ccsxGuT+gyTtUV9R3xCC8GzfevvT40YTBaj725f3tFsQ9iYdwo2HpDiuYwnJBwyBqJuI6jCTGk/sGqFos4GgkMEwnh47UpGRIX8nXEjYaE5Z9AobEzLS2NwIurI+h1z6dQgX4aCTsmkvzz2HYnegSrrjPI1FHLO/iO7C2XYWsNkNA8Q/ItI14LW75eoqt/XLNOmwKJnFLGW3soMBE3B77RN5K47LhHlcD80wQiPwnQ2DVYdh94Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX3GcmdfgFUzmkj5qSqJAXmBb95Z/1+kRpvJSEf2rnY=;
 b=XmKv+m76kG85Ng71GLYeiMgxQrjoSJXJwbq27HMelCU8c2qa73HzIp7PUiWJUdiCt3A99D9yOsq2TSU9V/FJQRoc3kJU7Ihlr0LINCehdZsoousz9PJsR24prxDQn5PfFQ/voP+r99DTeXQUPf7bib+NIEQ6r+T1Tv8Iuwn6OQo=
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 15:57:13 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::37) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Fri,
 18 Jul 2025 15:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Fri, 18 Jul 2025 15:57:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 10:57:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 10:57:11 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 10:57:11 -0500
From: <IVAN.LIPSKI@amd.com>
To: <igt-dev@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH i-g-t v2] tests/amdgpu: Add test for native cursor fallback to
 overlay
Date: Fri, 18 Jul 2025 11:56:36 -0400
Message-ID: <20250718155702.97877-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bcb562-7343-4724-1f6f-08ddc613c2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4jFTmET7L9TbKKqguyukZxMo1++ZmuzxaemN2nppz8+nl0V6mkhnsUwSr0xT?=
 =?us-ascii?Q?k7A1OtNz3CV0raot6uzaTDoKZUdvKG6bPJphuqVcSTftfVHIKe+7EhbR04i+?=
 =?us-ascii?Q?x+PZJ9ZD/PEiIIak7XStCnO6AaYxH3zqtWiFJps/XdwKLoCXTkK6W14H5Lo2?=
 =?us-ascii?Q?hBuz570pFJjLLR+3byseDlawGaKtISSQ3L+joqzcK72pnYjmX9rJ4rUlRgZc?=
 =?us-ascii?Q?1b6/rAt2DSG1QtCGmdnhI/Ni62NasajYW5I/I42n4guwe0/WMm7WQLFk1qmc?=
 =?us-ascii?Q?x2KweMR0gidftkbjz7fg8+kzrc4yN2RyGjQXU0lslxEXx7IKCGL4INvAWO3W?=
 =?us-ascii?Q?sIXjS4abz/hR2q6CPdwBUOLywWxAAyRhye2IKK7wtjDwkgBJTW7we2hX7CBs?=
 =?us-ascii?Q?ZidO4IwCk3+yaZrJAxaLKMae3n8GyX/6buBU6A/vmA+WKI8AwBvMkYIQapiA?=
 =?us-ascii?Q?+GZlRQRnCzMHxz75S7uuwuEnBUTjzIkB6jxLef1kaUOOVzVfQogqZkbH1897?=
 =?us-ascii?Q?WoBJpGP84/f7Aahlk3Cx+KTyWFwe4zURlcA1T1tMAv95ItjG++cVJkwfuc9a?=
 =?us-ascii?Q?oykGQFQ4Dh1ZvDazELQdJLuHoWN73Ztb+UBhVBRWxP5YHSrqpfx+XQR0hrsb?=
 =?us-ascii?Q?yNF8tY90szFwpqUwcKORHmDpcEVBcGznSeiJusI6Y/l7Kb9Ww5FzRqetJRnJ?=
 =?us-ascii?Q?Fs8fs0oNRwLt9gNgA2JzqXzTh4knWbbTklzg9tRCiewVooxzIBNqff9NwYYU?=
 =?us-ascii?Q?1IUr8JnQyFFaFvLg1q7YipsZrFCJ2Mh9TlIeDXDyrm+JbN7/Myfg8Q7I5zL9?=
 =?us-ascii?Q?tC1VQIyLeKkktg6rYVpWLGvVtP4AZIilEeNMR7qXI+HC+fWLEpDEz06cl12S?=
 =?us-ascii?Q?yqJmvLACcc8jIsF0OLmkZMtfhxK50K+SRtVIZLS0F6ocI/GGhcmno4ihKFBH?=
 =?us-ascii?Q?cxXOi/z5RnyH9/IanTpNzi3PuMrmAXurDrTz2tX4QTa0WKcBviBwvcgSmj+l?=
 =?us-ascii?Q?4lqBiOL6h+ylK8Oo9ePLesgf6UB2z6DGSw0y/UeCyGjoZ0kEJAG7k2X0IS4f?=
 =?us-ascii?Q?uGJ3JsMAW5m9eZLiusVXfyn5eRfE5cIje3oJcZKSiHJZV+JStdeYXwfvoMbJ?=
 =?us-ascii?Q?OLKm3HrK1qMO2EWEybbptOqxwn+IyDKM7voR848cF51vUBQcbVv53tOo7/kE?=
 =?us-ascii?Q?W/ektTGUbGL1xlMO5Lukaqct7/NszxQ61UP6EEPMie5ln1S0eYlCEQbbrU37?=
 =?us-ascii?Q?bf4EpQOmW/3uqF1D1m1O4LyKatRAJ4nJfYaENv3eOGrlOMTdzOnfTo2fkA27?=
 =?us-ascii?Q?jcr80lQT8esuopo/lkPV8dWzBuTff9xk2QFz6BAP2nvCm67gK7nYTpcurW4k?=
 =?us-ascii?Q?38ZfLuiclGy5N5Lq0dLSZC2dzWiPt+nvfdobs4ddo4YrR7b02GogBsNiUIcg?=
 =?us-ascii?Q?Btltch/cuL0o1felVyG38T6+D+c3kr6plZxdn4htdmOw58rCI6tccEGV1V35?=
 =?us-ascii?Q?If/ir0z43+TjI7Hwybo2l48cjtPZO4j5Io6V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:57:13.0422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bcb562-7343-4724-1f6f-08ddc613c2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why & How]
The AMD display hardware does not use dedicated cursor planes.
Instead, the cursor is rendered either using the primary plane
or an available overlay plane. This test verifies that the
cursor correctly falls back from native to overlay mode
when the underneath primary plane is incompatible. It also tests

It has 4 subtests:

rgb-to-yuv
Switches the primary plane to a NV12 format FB and verifies that
the cursor falls back from native to overlay.

non-full
Switches the primary planeto a FB that does not fill the entire CRTC
(currently sized at a quarter of the CRTC).

scaling-[50,75,125,150,175,200]
Switches the primary plane to a FB with a chosen scaling (50%-200%), which
is then filled in the CRTC.

no-available-planes
Enables all available overlay planes, a primary plane and a cursor. Then
switches the primary plane to YUV to cause the cursor to fall back to
overlay. Verifies that the atomic commit fails due to no available overlay
planes.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 tests/amdgpu/amd_cursor_overlay.c | 414 ++++++++++++++++++++++++++++++
 tests/amdgpu/meson.build          |   1 +
 2 files changed, 415 insertions(+)
 create mode 100644 tests/amdgpu/amd_cursor_overlay.c

diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
new file mode 100644
index 000000000..1a230da11
--- /dev/null
+++ b/tests/amdgpu/amd_cursor_overlay.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "igt.h"
+
+/**
+ * TEST: amd_cursor_overlay
+ * Category: Display
+ * Description: Tests cursor fall back from native to overlay
+ * Driver requirement: amdgpu
+ */
+
+/**
+ * SUBTEST: rgb-to-yuv
+ * Description: Tests native cursor fall back to overlay cursor when a top plane
+ *				switches from RGB to YUV.
+ * SUBTEST: non-full
+ * Description: Tests native cursor fall back to overlay cursor when a top plane
+ *				does not fill the crtc.
+ * SUBTEST: scaling-%d
+ * Description: Tests native cursor fall back to overlay cursor when a top plane
+ *				is scaled.
+ *
+ * arg[1].values: 50, 75, 125, 150, 175, 200
+ *
+ * SUBTEST: no-available-planes
+ * Description: Tests native cursor attempt to fall back to overlay cursor required,
+ *				but fails atomic commit due to no available overlay planes.
+ */
+
+enum {
+	TEST_YUV = 1,
+	TEST_QUARTER_FB = 1 << 1,
+	TEST_SCALING = 1 << 2,
+	TEST_NO_PLANES = 1 << 3,
+};
+
+typedef struct {
+	int x;
+	int y;
+} pos_t;
+
+typedef struct {
+	int x;
+	int y;
+	int w;
+	int h;
+} rect_t;
+
+/* Common test data. */
+typedef struct data {
+	igt_display_t display;
+	igt_plane_t *primary;
+	igt_plane_t *cursor;
+	igt_plane_t *overlay1;
+	igt_plane_t *overlay2;
+	igt_output_t *output;
+	igt_pipe_t *pipe;
+	igt_pipe_crc_t *pipe_crc;
+	drmModeModeInfo *mode;
+	igt_fb_t rgb_fb;
+	igt_fb_t yuv_fb;
+	igt_fb_t rgb_fb_o1;
+	igt_fb_t rgb_fb_o2;
+	igt_fb_t quarter_fb;
+	igt_fb_t scale_fb;
+	igt_fb_t cfb;
+	enum pipe pipe_id;
+	int drm_fd;
+	rect_t or;
+	uint64_t max_curw;
+	uint64_t max_curh;
+} data_t;
+
+/* Common test setup. */
+static void test_init(data_t *data, enum pipe pipe_id, igt_output_t *output,
+		      unsigned int flags)
+{
+	data->pipe_id = pipe_id;
+	data->pipe = &data->display.pipes[data->pipe_id];
+	data->output = output;
+	data->mode = igt_output_get_mode(data->output);
+	data->primary = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_PRIMARY);
+	data->cursor = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_CURSOR);
+
+	if (flags & TEST_NO_PLANES) {
+		data->overlay1 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 0);
+		data->overlay2 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 1);
+	}
+
+	igt_info("Using (pipe %s + %s) to run the subtest.\n",
+		 kmstest_pipe_name(data->pipe_id), igt_output_name(data->output));
+
+	igt_require_pipe_crc(data->drm_fd);
+	data->pipe_crc = igt_pipe_crc_new(data->drm_fd, data->pipe_id,
+					  IGT_PIPE_CRC_SOURCE_AUTO);
+}
+
+/* Common test finish. */
+static void test_fini(data_t *data)
+{
+	igt_pipe_crc_free(data->pipe_crc);
+	igt_display_reset(&data->display);
+	igt_plane_set_fb(data->primary, NULL);
+	igt_plane_set_fb(data->cursor, NULL);
+	if (data->overlay1)
+		igt_plane_set_fb(data->overlay1, NULL);
+	if (data->overlay2)
+		igt_plane_set_fb(data->overlay2, NULL);
+	igt_display_commit2(&data->display, COMMIT_ATOMIC);
+}
+
+/* Common test cleanup. */
+static void test_cleanup(data_t *data)
+{
+	igt_remove_fb(data->drm_fd, &data->cfb);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb);
+	igt_remove_fb(data->drm_fd, &data->yuv_fb);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb_o1);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb_o2);
+	igt_remove_fb(data->drm_fd, &data->quarter_fb);
+	igt_remove_fb(data->drm_fd, &data->scale_fb);
+}
+
+
+static void test_cursor_pos(data_t *data, int x, int y, unsigned int flags, unsigned int scaling_factor)
+{
+	igt_crc_t ref_crc, test_crc;
+	cairo_t *cr;
+	igt_fb_t *rgb_fb = &data->rgb_fb;
+	igt_fb_t *yuv_fb = &data->yuv_fb;
+	igt_fb_t *quarter_fb = &data->quarter_fb;
+	igt_fb_t *rgb_fb_o1 = &data->rgb_fb_o1;
+	igt_fb_t *rgb_fb_o2 = &data->rgb_fb_o2;
+	igt_fb_t *cfb = &data->cfb;
+	int cw = cfb->width;
+	int ch = cfb->height;
+	int ret;
+
+
+	cr = igt_get_cairo_ctx(rgb_fb->fd, rgb_fb);
+
+	igt_plane_set_fb(data->primary, rgb_fb);
+	igt_display_commit2(&data->display, COMMIT_ATOMIC);
+
+	igt_paint_color(cr, 0, 0, rgb_fb->width, rgb_fb->height, 0.0, 0.0, 0.0);
+
+	/* Draw a magenta square where the cursor should be. */
+	igt_paint_color(cr, x, y, cw, ch, 1.0, 0.0, 1.0);
+	igt_put_cairo_ctx(cr);
+
+
+	if (flags & TEST_NO_PLANES) {
+
+		/* Display the overlay planes. */
+		igt_plane_set_fb(data->overlay1, rgb_fb_o1);
+		igt_plane_set_position(data->overlay1, 0, 0);
+		igt_plane_set_fb(data->overlay2, rgb_fb_o2);
+		igt_plane_set_position(data->overlay2, data->rgb_fb_o1.width, data->rgb_fb_o1.height);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+		/* Display the cursor. */
+		igt_plane_set_fb(data->cursor, cfb);
+		igt_plane_set_position(data->cursor, x, y);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+		/* Trigger cursor fall back due to a YUV plane;
+		 * expect the atomic commit to fail due to no
+		 * available overlay planes.
+		 */
+		igt_plane_set_fb(data->primary, &data->yuv_fb);
+		ret = igt_display_try_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
+
+		/* Remove the overlay planes. */
+		igt_plane_set_fb(data->overlay1, NULL);
+		igt_plane_set_fb(data->overlay2, NULL);
+		igt_plane_set_fb(data->cursor, NULL);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+		/* Expected atomic commit to fail due to no available overlay planes. */
+		igt_assert_f(ret != 0, "Expected atomic commit to fail due to no available overlay planes.\n");
+		return;
+	}
+
+	/* Display the cursor. */
+	igt_plane_set_fb(data->cursor, cfb);
+	igt_plane_set_position(data->cursor, x, y);
+	igt_display_commit_atomic(&data->display, 0, NULL);
+
+	/** Record a reference CRC */
+	igt_pipe_crc_start(data->pipe_crc);
+	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &ref_crc);
+
+	/* Switch primary plane to use YUV Fb. */
+	if (flags & TEST_YUV) {
+		igt_plane_set_fb(data->primary, yuv_fb);
+		igt_plane_set_position(data->primary, 0, 0);
+		igt_plane_set_size(data->primary, yuv_fb->width, yuv_fb->height);
+		igt_display_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
+
+	/* Switch primary plane to use a quarter-sized FB. */
+	} else if (flags & TEST_QUARTER_FB) {
+		igt_plane_set_fb(data->primary, quarter_fb);
+		igt_plane_set_position(data->primary, 0, 0);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+	/* Switch primary plane to use a scaled FB. */
+	} else if (flags & TEST_SCALING) {
+		igt_create_fb(data->drm_fd,
+			data->rgb_fb.width * scaling_factor / 100,
+			data->rgb_fb.height * scaling_factor / 100,
+			DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_LINEAR, &data->scale_fb);
+
+		igt_plane_set_fb(data->primary, &data->scale_fb);
+		igt_plane_set_position(data->primary, 0, 0);
+		igt_plane_set_size(data->primary, data->mode->hdisplay, data->mode->vdisplay);
+
+		igt_display_commit_atomic(&data->display, 0, NULL);
+	}
+
+	/* Wait for one more vblank since cursor updates are not
+	 * synchronized to the same frame on AMD hw.
+	 */
+	if (is_amdgpu_device(data->drm_fd))
+		igt_wait_for_vblank_count(data->drm_fd, data->display.pipes[data->pipe_id].crtc_offset, 1);
+
+	/* Record the new CRC. */
+	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &test_crc);
+	igt_pipe_crc_stop(data->pipe_crc);
+
+	/** CRC Check is sufficient for this test */
+	igt_assert_crc_equal(&ref_crc, &test_crc);
+}
+
+/*
+ * Tests the cursor on a variety of positions on the screen.
+ * Specific edge cases that should be captured here are the negative edges
+ * of each plane and the centers.
+ */
+static void test_cursor_spots(data_t *data, int size, unsigned int flags, unsigned int scaling_factor)
+{
+	int sw = data->mode->hdisplay;
+	int sh = data->mode->vdisplay;
+	int i;
+		const pos_t pos[] = {
+		/* Test diagonally from top left to bottom right. */
+		{ -size / 3, -size / 3 },
+		{ 0, 0 },
+		{ sw / 4 - size, sh / 4 - size },
+		{ sw / 4 - size / 3, sh / 4 - size / 3 },
+		{ sw / 4, sh / 4 },
+		{ sw / 4 + size, sh / 4 + size },
+		{ sw / 2, sh / 2 },
+		{ sw / 4 + sw / 2 - size, sh / 4 + sh / 2 - size },
+		{ sw / 4 + sw / 2 - size / 3, sh / 4 + sh / 2 - size / 3 },
+		{ sw / 4 + sw / 2 + size, sh / 4 + sh / 2 + size },
+		{ sw - size, sh - size },
+		{ sw - size / 3, sh - size / 3 },
+		/* Test remaining corners. */
+		{ sw - size, 0 },
+		{ 0, sh - size },
+		{ sw / 4 + sw / 2 - size, sh / 4 },
+		{ sw / 4, sh / 4 + sh / 2 - size }
+	};
+
+	for (i = 0; i < ARRAY_SIZE(pos); ++i)
+		test_cursor_pos(data, pos[i].x, pos[i].y, flags, scaling_factor);
+}
+
+static void test_cursor(data_t *data, int size, unsigned int flags, unsigned int scaling_factor)
+{
+	int sw, sh;
+
+	igt_skip_on(size > data->max_curw || size > data->max_curh);
+
+	sw = data->mode->hdisplay;
+	sh = data->mode->vdisplay;
+
+	test_cleanup(data);
+
+	/* Create RGB FB for reference. */
+	igt_create_color_fb(data->drm_fd, sw, sh, DRM_FORMAT_XRGB8888,
+			    DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->rgb_fb);
+
+	/* Create YUV FB for RGB-to-YUV and NO_PLANES subtests */
+	if (flags & TEST_YUV || flags & TEST_NO_PLANES)
+		igt_create_fb(data->drm_fd, sw, sh, DRM_FORMAT_NV12,
+					DRM_FORMAT_MOD_NONE, &data->yuv_fb);
+
+	/* Create a quarter-sized empty FB. */
+	if (flags & TEST_QUARTER_FB)
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->quarter_fb);
+
+	/* Create two RGB FBs for the overlay planes. */
+	if (flags & flags & TEST_NO_PLANES) {
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_NONE, 0.5, 0.0, 0.0, &data->rgb_fb_o1);
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_NONE, 0.0, 0.0, 0.5, &data->rgb_fb_o2);
+	}
+
+	/* Create a FB for scaling. */
+	if (flags & TEST_SCALING)
+		igt_create_color_fb(data->drm_fd, sw, sh, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->scale_fb);
+
+	/* Create a cursor FB. */
+	igt_create_color_fb(data->drm_fd, size, size, DRM_FORMAT_ARGB8888,
+				DRM_FORMAT_MOD_LINEAR, 1.0, 0.0, 1.0, &data->cfb);
+
+	igt_output_set_pipe(data->output, data->pipe_id);
+
+	/* Run the test for different cursor spots. */
+	test_cursor_spots(data, size, flags, scaling_factor);
+
+}
+
+igt_main
+{
+	static const int cursor_sizes[] = { 64, 128, 256 };
+	data_t data = { .max_curw = 64, .max_curh = 64 };
+	enum pipe pipe;
+	igt_output_t *output;
+	igt_display_t *display;
+	int i, j;
+	struct {
+		const char *name;
+		unsigned int flags;
+		unsigned int scale_factor;
+		const char *desc;
+	} tests[] = {
+		{ "rgb-to-yuv", TEST_YUV, 100,
+		"Tests native cursor fall back to overlay cursor when a top plane switches from RGB to YUV" },
+		{"non-full", TEST_QUARTER_FB, 100,
+		"Tests native cursor fall back to overlay cursor when a top plane does not fill the crtc"},
+		{"no-available-planes", TEST_NO_PLANES, 100,
+		"Tests native cursor attempt to fall back to overlay cursor required, but fails atomic commit due to no available overlay planes."},
+		{"scaling-50", TEST_SCALING, 50,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+		{"scaling-75", TEST_SCALING, 75,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+		{"scaling-125", TEST_SCALING, 125,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+		{"scaling-150", TEST_SCALING, 150,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+		{"scaling-175", TEST_SCALING, 175,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+		{"scaling-200", TEST_SCALING, 200,
+		"Tests native cursor fall back to overlay cursor when a top plane is scaled"},
+	};
+
+	igt_fixture {
+		int ret;
+
+		data.drm_fd = drm_open_driver_master(DRIVER_AMDGPU);
+
+		igt_display_require(&data.display, data.drm_fd);
+		igt_require(data.display.is_atomic);
+		igt_display_require_output(&data.display);
+		display = &data.display;
+
+		ret = drmGetCap(data.drm_fd, DRM_CAP_CURSOR_WIDTH, &data.max_curw);
+		igt_assert(ret == 0 || errno == EINVAL);
+		ret = drmGetCap(data.drm_fd, DRM_CAP_CURSOR_HEIGHT, &data.max_curh);
+		igt_assert(ret == 0 || errno == EINVAL);
+
+		kmstest_set_vt_graphics_mode();
+	}
+
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		igt_describe_f("%s", tests[i].desc);
+		igt_subtest_with_dynamic_f("%s", tests[i].name) {
+
+			/* Skip YUV and NO_PLANES subtests if YUV is not supported*/
+			if (tests[i].flags & TEST_YUV || tests[i].flags & TEST_NO_PLANES)
+				igt_require(igt_display_has_format_mod(display,
+							DRM_FORMAT_NV12,
+							DRM_FORMAT_MOD_LINEAR));
+
+			for_each_pipe_with_single_output(&data.display, pipe, output) {
+
+				igt_display_reset(display);
+
+				igt_output_set_pipe(output, pipe);
+				if (!intel_pipe_output_combo_valid(display))
+					continue;
+
+				test_init(&data, pipe, output, tests[i].flags);
+
+				for (j = 0; j < ARRAY_SIZE(cursor_sizes); j++) {
+					int size = cursor_sizes[j];
+
+					igt_dynamic_f("pipe-%s-%s-size-%d",
+						      kmstest_pipe_name(pipe),
+						      igt_output_name(output),
+						      size)
+						test_cursor(&data, size, tests[i].flags, tests[i].scale_factor);
+
+					test_cleanup(&data);
+				}
+
+				test_fini(&data);
+			}
+		}
+	}
+
+	igt_fixture {
+		igt_display_fini(&data.display);
+		drm_close_driver(data.drm_fd);
+	}
+}
diff --git a/tests/amdgpu/meson.build b/tests/amdgpu/meson.build
index 421e686d3..b9f1842e2 100644
--- a/tests/amdgpu/meson.build
+++ b/tests/amdgpu/meson.build
@@ -10,6 +10,7 @@ if libdrm_amdgpu.found()
 			  'amd_color',
 			  'amd_cp_dma_misc',
 			  'amd_cs_nop',
+			  'amd_cursor_overlay',
 			  'amd_deadlock',
 			  'amd_dp_dsc',
 			  'amd_freesync_video_mode',
-- 
2.43.0

