Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C2C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 20:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B666C10E8B5;
	Thu, 17 Jul 2025 20:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UzBoe2pl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE3E10E89D;
 Thu, 17 Jul 2025 20:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABrV4bOy9Jn6PYmQrQxSwzj2esvUINlMciOJPMP/RTTRTytluB15c7NsItMNqrgo5gDjs7s3HghTvReVE7SD4HU/2RR6WG1bghSqvH2NRckBwGg+AXlx5mJdqODk1G/Kk9UQNEkknn81QQ/eDtnGAhj6/NuTk+CrlSHe+aBshDy8GidQQINA0sH0hhhyZyQZ9xgGWaZ7+YbnEKZymMsxIyYr3prvO/5AqGMOuLAKQHbmFKOo7bOEU86uHm8sA96h3Iwv5BsEfnkBcDszdPtd+qjW4bFrh0dqiyP+gWoirfvvc4lQeBGjYvXYnYXvPixQ+kW0TkjIDQ1ryqlFZpYN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS/FO3YGx6XjXycGaajzrT8v1MqQ3AxBbAcdDfF8wKc=;
 b=qIKNCIBTs/fLEaS0O+08Ftqam/I1qpURNMDXu9vT6VQxyXpk9sxnu6h/hk5CY0WvcajyQbptLtWuNjtT9k7R/H9TXVTyYAx8rYq9kc9I5y4NPVzYOp6wTWlhMSJ0cqfYRtcWo5HCkDqkGPl6TxeFRke2WFPuKnWEE/chxvqye/Gs7uRqr2uXILq8MbCykxuOj/+tcfCfiaCoQtmK+sGO35w4CwrAuL1ctStiLvYldFHtiiag291a2wF/VwcgNEUucN+s5f7tflg7cE2ePz8CNV7yY0pBgaCj/3zGDnVTqdslO0DmBmhS2mKFHKh1mnGBHnOMs4xcH0gqw5uWF0PP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS/FO3YGx6XjXycGaajzrT8v1MqQ3AxBbAcdDfF8wKc=;
 b=UzBoe2plE523wkZcECXzNGUtArs0+oQHlY8mHZjtZ/LMT70B/4qiKeXcy2IHhIpnOv5inv3Zu6lv1LrOvizeAUzOoeahwYLVVdh+uKs5W0VvX5Nc9FjTqgrz/UcLRqjdLh7re9xq62cA5onKbOLngMuUI/5G1BxUt6cbznOUI7I=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 20:42:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::6b) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 20:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 20:42:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 15:42:49 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 17 Jul 2025 15:42:49 -0500
From: <IVAN.LIPSKI@amd.com>
To: <igt-dev@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH i-g-t] tests/amdgpu: Add test for native cursor fallback to
 overlay
Date: Thu, 17 Jul 2025 16:41:46 -0400
Message-ID: <20250717204155.17468-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: db64fde2-1616-44df-79b8-08ddc5727f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?psZDZlDCIMTizq5CVOT04TfvnjCpD07FjM01MAryjEYZLcNajfd0KS/d9Y8J?=
 =?us-ascii?Q?lA0CkQagciLv30KWNwS5C4bgFwJ1AqBTKUWDmPhH/2Tjwu4hTbVwvxSp4NCz?=
 =?us-ascii?Q?l5N41lNbHxJA0hxOPBvPcyx31EcLirZQeQfj/95ChfoQpny+RwxjOItRW12k?=
 =?us-ascii?Q?9rKliPdlgDJpFwwW9O29rYanOT26mr3OaTxuK54Ik+1h97OiyNVyykVqjOBF?=
 =?us-ascii?Q?uCwrnItLJgKW0miK/JMNrR4B/s0NjUOgG2ejRCtlWWbwjC70JE9LyuovswbG?=
 =?us-ascii?Q?kJ9PNdtH4aT+jdz2Cc3Se50JG5zq93dGl1AXfak/ctOQnFxPVY7lS5YtTr5i?=
 =?us-ascii?Q?aXecfV6Rf1r77/iYRHEWkuEEs9bUyzbGp75VGwQakjcd094PqNJ8ylU92QA2?=
 =?us-ascii?Q?pGOmlWqSnvGgC/k706N5tLgGSqh6jtN3aW6NtXdJkKJjebFukFfCuY7O1LuW?=
 =?us-ascii?Q?yL36klZi+U+8rp7KP25Nqq1tOR9nn6fNg9KLuiG6hX5ucUj7zwe5x2R08UuP?=
 =?us-ascii?Q?6e2YNWJOU08JSMBPeSabbu/HuT+fUrVnS+e+Vukk2y4i1v11sdTgKOq/9EQt?=
 =?us-ascii?Q?ThpSbtM/IrPY4kTjiNwQOEcQyGJ0q5hs9SoK6QH0ftYxVcRlBSgplmb6OHVA?=
 =?us-ascii?Q?vlsQhaGtgTEUvwfXI8rAwzdx7M5lQwz8XjhSSfEwifCou9OynywbA4bzh3ST?=
 =?us-ascii?Q?lwv1SyCBa4ZLxkV99zPShBwVxOA/EYK/9NtxafZu5TTZovU3RCrsLbhMVESv?=
 =?us-ascii?Q?fI72T0s2DCWFogJL0os405yVynpFWEK4HIw6Jwp8qegG3bsvPLThl7BxUjiG?=
 =?us-ascii?Q?UkWQ5dzfq59k/DRwYSu+fkDOr3W4p8qZbRoQVa536uxwo3DJy0IgyLB/91Ko?=
 =?us-ascii?Q?XmO/dN3xHK4Xko9uHfXfWTUjG7JALu6M3ZDgbR72igbwJRB1gl3xxfdO5hYN?=
 =?us-ascii?Q?qw3/IrU5Tf8GpVZh2jHrtc1I+QmWgkRj7L7y9wLOWIgpo/oimCZLjuwxVc0T?=
 =?us-ascii?Q?SmFZFiwjRd6s7oLn5QIqjvtnuTf9bX65ppv9TJBT+TKeY1LTIJRmyKucbc8V?=
 =?us-ascii?Q?1Y4XaGXZrBXIXNdywZHbe3EhDFrAcco2eUj00pGa3Q0wpBFKj+HiAWqcSaQh?=
 =?us-ascii?Q?uikgUJx9496GkzyV8kpPWQy9REeR3P4o9sZDrAI5q9D6OdtSlBUDTd8hYVIc?=
 =?us-ascii?Q?70MQhSnTIC4EW2Ka1MK1VuT43iwwcc1Jziq+2TWsfajiDUmYzs5m94zIvU8q?=
 =?us-ascii?Q?FXlGsZZUfMvisGQvmo6z7GDiZTeMNeo/dmuGKXpQqhCRBcEqLVQOKsUCvJ8t?=
 =?us-ascii?Q?zU9ERjJq/w5JsRVQ2JRjmy1LZPbT1xEjfjGdi9F/LvSazqEMQj9wvkidUXnM?=
 =?us-ascii?Q?D2G4WsaeLTHZ3Zjr4knzQ4r1xXpqpEKcTvNo+nEsSeqdql4vhD/um6TzN6/b?=
 =?us-ascii?Q?FW6WMMWrcK5eyNUGgD7kbWnD8bwZHp/R57SK7SPkqeY2MtxrCQUj1TYwy4zo?=
 =?us-ascii?Q?mOZD1Pxt/x5Z9+qYuZ5C/VJDlUaeqLbJObSJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 20:42:51.3166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db64fde2-1616-44df-79b8-08ddc5727f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452
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
 tests/amdgpu/amd_cursor_overlay.c | 433 ++++++++++++++++++++++++++++++
 tests/amdgpu/meson.build          |   1 +
 2 files changed, 434 insertions(+)
 create mode 100644 tests/amdgpu/amd_cursor_overlay.c

diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
new file mode 100644
index 000000000..52cae8454
--- /dev/null
+++ b/tests/amdgpu/amd_cursor_overlay.c
@@ -0,0 +1,433 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+ */
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

