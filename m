Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C266FC83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 17:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B5210E0CE;
	Wed, 23 Jul 2025 17:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6CUoKbi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B466F10E0CE;
 Wed, 23 Jul 2025 17:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBDOvnli1uYP0rOvRh3yIhyCeFP+MASK5MFZGGSgC5/KV53XlwopIuFocZjXKLftt6ptVpUmBU09xI0FbxAPgcrnkU/YTxPzqQnXkKpW/Afpt6gLS4SJLbw8RykgLxV2iCpnCX+n2h0+a4cqdA2u5E2/NRSJu3oL7T1tMqtbtAKq5q1LPaP2ZkRyxOD3JSxNT2+5w2YQae/8pyysWB7EDpGuKKmfSv0VgjmLbQkqltCxBa5JZT1PDh+oWbU4MLs1KLg3swhuyLjU4fTycia4Nczy18mAHgfz69oRujGXeuENK6FF+QGfbNwD50pekUKssFGz2lvtfWp2KfzVenyEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHDFMBTm+VHzxykZ/HXf7yssaphNARp5Wx+xnJnnqgM=;
 b=askkQNkeo3hWBK3CXQEHQlz8GNGsYqVYQqyxCR17M031SiLMS+jgjLS3b4+NeO0TA0MXnNvoFmNJa83VMA33Zxvyn5j/uyC4IuYEfo1cUWslanRI0p7WjTQtwqLbZhqup0ovPjKiDWKcfdzymCwfTBEgSs3Kc5eSd0yIvqkjT0Y9beSDcmv4s01egQNVfWsoZrfXru6nG3te2smI/7FnNiqt95Kl0wYI/1eEHkMglrulNjTpFiLjHZWY+sXuYC5w8SGNalqWoQJuHjIZudQsVdxzLr//C/h7IcSwG868cu6K3xaK/mXXBOTp9m/PdTydrFOXyBx/fuo6OEs49N+Qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHDFMBTm+VHzxykZ/HXf7yssaphNARp5Wx+xnJnnqgM=;
 b=P6CUoKbiIWAIDlmIF1xhF6bs/1oUvuOYJTeU71H7gsOqVZHTvL1brnV09Z3F3BacM3wiFhylqG4jtiQzvjo4wWOfwIv+djsrGdjnAKDo8hmPgJn1lSZ3cWH6j60rI0POv8jVkyLvhYX/EUcRFOPth5vu9QjgrUMgvwamUxze4T0=
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:28:07 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::58) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:28:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:28:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:28:02 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Jul 2025 12:28:01 -0500
From: <IVAN.LIPSKI@amd.com>
To: <igt-dev@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH i-g-t v3] tests/amdgpu: Add test for native cursor fallback to
 overlay
Date: Wed, 23 Jul 2025 13:27:26 -0400
Message-ID: <20250723172754.2721348-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1608c521-8bcd-4b31-2244-08ddca0e497a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8HswZ+DP8WccBqRHI68opA7lAFY5mXICDaqiSwlYc5JpVY4WtypTiB2q12JY?=
 =?us-ascii?Q?I0UGLLsH61ffF5oWcdXkZwsSDSx+a+pb/OrXxnEyMIsNi2oXvwv3+9QfkqHM?=
 =?us-ascii?Q?LEvJFgjy0ajHLU+g23xf9xtpeceXGUpi3jXTZqT7tSg6A2jbXB+rpAh8KV4G?=
 =?us-ascii?Q?BoRgg5SFPTlZuN8kXVs7lLUm5QgYnatSHLKWUnCqqmRHQ/a82EG/mZD+qCMP?=
 =?us-ascii?Q?Y4jJfcFn0Y2pQVQAYHX4ZloR6AUIYXJ05nXLQlb4RAlq9ybFvXApYX1KGP3n?=
 =?us-ascii?Q?G9EEwWYgBEG6m2Z5oaUb8IJrJFvDL/MXLRi3mlUsdaT7/ahnL3h5o8bVB8Rn?=
 =?us-ascii?Q?tYC0M7j8Cp42HoUATqIWDEhrVgUzTCnZpV3tWerg9cY20PbciZpF0aHj8pXB?=
 =?us-ascii?Q?PyC+OQk/EJZJXITpqRCZkRjsUOdszAhHjN53VaSbblRLHjEfvVdFdsCOxAhW?=
 =?us-ascii?Q?n62WAd30qXddmCTiknk+GB7by/4YIcYstg19B5VE8hUNZqN4tuiXZcN7I4LG?=
 =?us-ascii?Q?bOVwTUJHePd+4blc0wLA4ycC13f+9eiep2BHh0jzvlZtSZaqcpVRkiizfNWs?=
 =?us-ascii?Q?lk11XLwd5MkMauN6HKmANbZcNipOQ3C6hvFy+wicpKyWpUhCAUODhBDcXU4C?=
 =?us-ascii?Q?96yRuL5jvkDV4UDFc+brC+gAaKynLhSC/dC5g/B5inCBTTaYDo5TK1ksWGOG?=
 =?us-ascii?Q?fe0I+aFwOrVWy+QfHuXL14+dg7P3cbWwYmqXxVeB9XW9mN39cDCCHc4rcf3i?=
 =?us-ascii?Q?4Qlc5r07MPu8Ng4qqrpeM/dhwc3yULm6psF9kGI0qK17f743Cr6t7U6YeQST?=
 =?us-ascii?Q?T/MWeroBXP+yyYGwlLepoaql0mh2r9068/Tb+aQ84sG5dPH6B2aERVQZcsZz?=
 =?us-ascii?Q?KC1U1j2Mk4W/Vuh0Cbdvr/+OpCTmH8ZDKVpmcjObDxwX2bWsguxCmB9RDh8a?=
 =?us-ascii?Q?NxRRaHP2nScyDj1G7bFdmLNlGM5NcYn9+ciCP+QgvWrGNwAcUSRUL+bhYRic?=
 =?us-ascii?Q?gesa76VZdU1RDQGbqicnFKi+n7Vs4jXhRtWiNHside9w0JDzhTVDXmfLjVqN?=
 =?us-ascii?Q?k21VAI5+t2Xgo9vmEtudWhhfyk3c6/E3cqXfLQEPv8viU+hZ95F9nCLOfIA3?=
 =?us-ascii?Q?A/zavErxjH17UDSMc1lAOG+bDOwRqbawevp6/JEG0TtSKvXRGRI2cH+R2orM?=
 =?us-ascii?Q?86Kr6iDu6DJJoxatu1nzesmeElxXV69PiBs/5IueeIX9rSS+rPmvmGzZ0DNH?=
 =?us-ascii?Q?UnRBPgD60ymLtJRijr3NkoIs2fYdWP7aj32KteFUtunFG6vZp7P2dx0iOvH3?=
 =?us-ascii?Q?ncLHcYYWyKhHAc3J5rp409A4NfJzi/p7lcjCEUWXtVRYH6mE6R0LrchFb65D?=
 =?us-ascii?Q?/PdloYVedKkl5WuR16Q1I/HwQBpwW7szClBhGQonE40GUltXeaRiS4FAnVVI?=
 =?us-ascii?Q?7QMvg7rYkbBfyHVyTCvbjXhczdQDbPWZFb9YRG+pG1N4zpw9qEa/Qrlm8F7y?=
 =?us-ascii?Q?9U/xwjEkfuC7KAyxs5ApuwjZclAxaC6FuDHz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:28:06.6227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1608c521-8bcd-4b31-2244-08ddca0e497a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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

It has 5 subtests:

rgb-to-yuv
Switches the primary plane to a NV12 format FB and verifies that
the cursor falls back from native to overlay.

non-full
Switches the primary planeto a FB that does not fill the entire CRTC
(currently sized at a quarter of the CRTC).

scaling-[50,75,125,150,175,200]
Switches the primary plane to a FB with a chosen scaling (50%-200%), which
is then filled in the CRTC.

max-planes
Enables 2 overlay planes, a primary plane and a cursor. Then
switches the primary plane to YUV to cause the cursor to fall back to
overlay. Verifies that the cursor can still fallback to overlay when 4
planes are enabled.

no-available-planes
Enables 3 available overlay planes, a primary plane and a cursor. Then
switches the primary plane to YUV to cause the cursor to fall back to
overlay. Verifies that the atomic commit fails due to no available overlay
planes.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 tests/amdgpu/amd_cursor_overlay.c | 484 ++++++++++++++++++++++++++++++
 tests/amdgpu/meson.build          |   1 +
 2 files changed, 485 insertions(+)
 create mode 100644 tests/amdgpu/amd_cursor_overlay.c

diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
new file mode 100644
index 000000000..cf5ea83a0
--- /dev/null
+++ b/tests/amdgpu/amd_cursor_overlay.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "igt.h"
+#include "igt_kms.h"
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
+ * SUBTEST: max-planes
+ * Description: Tests native cursor fall back to overlay cursor when a top plane
+ *				is YUV and there are two overlay planes used.
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
+	TEST_MAX_PLANES = 1 << 3,
+	TEST_NO_PLANES = 1 << 4,
+};
+
+typedef struct {
+	int x;
+	int y;
+} pos_t;
+
+/* Common test data. */
+typedef struct data {
+	igt_display_t display;
+	igt_plane_t *primary;
+	igt_plane_t *cursor;
+	igt_plane_t *overlay1;
+	igt_plane_t *overlay2;
+	igt_plane_t *overlay3;
+	igt_output_t *output;
+	igt_pipe_t *pipe;
+	igt_pipe_crc_t *pipe_crc;
+	drmModeModeInfo *mode;
+	igt_fb_t rgb_fb;
+	igt_fb_t yuv_fb;
+	igt_fb_t rgb_fb_o1;
+	igt_fb_t rgb_fb_o2;
+	igt_fb_t rgb_fb_o3;
+	igt_fb_t quarter_fb;
+	igt_fb_t scale_fb;
+	igt_fb_t cfb;
+	enum pipe pipe_id;
+	int drm_fd;
+	uint64_t max_curw;
+	uint64_t max_curh;
+} data_t;
+
+/* Retuns the number of available overlay planes */
+static int get_overlay_planes_count(igt_display_t *display, enum pipe pipe)
+{
+	int count = 0;
+	igt_plane_t *plane;
+
+	for_each_plane_on_pipe(display, pipe, plane)
+		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
+			count++;
+
+	return count;
+}
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
+	if (flags & TEST_NO_PLANES || flags & TEST_MAX_PLANES) {
+		data->overlay1 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 0);
+		data->overlay2 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 1);
+	}
+	if (flags & TEST_NO_PLANES)
+		data->overlay3 = igt_pipe_get_plane_type_index(data->pipe, DRM_PLANE_TYPE_OVERLAY, 2);
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
+	if (data->overlay3)
+                igt_plane_set_fb(data->overlay3, NULL);
+	igt_display_commit2(&data->display, COMMIT_ATOMIC);
+}
+
+/* Common test cleanup. */
+static void test_cleanup(data_t *data)
+{
+	igt_remove_fb(data->drm_fd, &data->cfb);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb);
+	igt_remove_fb(data->drm_fd, &data->yuv_fb);
+	if (data->overlay1)
+		igt_remove_fb(data->drm_fd, &data->rgb_fb_o1);
+	if (data->overlay2)
+		igt_remove_fb(data->drm_fd, &data->rgb_fb_o2);
+	if (data->overlay3)
+		igt_remove_fb(data->drm_fd, &data->rgb_fb_o3);
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
+	igt_fb_t *rgb_fb_o3 = &data->rgb_fb_o3;
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
+	if (flags & TEST_MAX_PLANES) {
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
+		igt_assert_f(ret == 0, "Expected atomic commit to succeed.\n");
+		return;
+	}
+	if (flags & TEST_NO_PLANES) {
+
+		/* Display the overlay planes. */
+		igt_plane_set_fb(data->overlay1, rgb_fb_o1);
+		igt_plane_set_position(data->overlay1, 0, 0);
+		igt_plane_set_fb(data->overlay2, rgb_fb_o2);
+		igt_plane_set_position(data->overlay2, data->rgb_fb_o1.width, data->rgb_fb_o1.height);
+		igt_plane_set_fb(data->overlay3, rgb_fb_o3);
+                igt_plane_set_position(data->overlay3, data->rgb_fb_o1.width, 0);
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
+		igt_plane_set_fb(data->overlay3, NULL);
+		igt_plane_set_fb(data->cursor, NULL);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+		/* Expected atomic commit to fail due to no available overlay planes. */
+		igt_assert_f(ret == -EINVAL, "Expected atomic commit to fail due to no available overlay planes.\n");
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
+	/* Create YUV FB for RGB-to-YUV, MAX_PLANES and NO_PLANES subtests */
+	if (flags & TEST_YUV || flags & TEST_MAX_PLANES ||flags & TEST_NO_PLANES)
+		igt_create_fb(data->drm_fd, sw, sh, DRM_FORMAT_NV12,
+					DRM_FORMAT_MOD_NONE, &data->yuv_fb);
+
+	/* Create a quarter-sized empty FB. */
+	if (flags & TEST_QUARTER_FB)
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->quarter_fb);
+
+	/* Create two RGB FBs for the overlay planes. */
+	if (flags & TEST_MAX_PLANES || flags & TEST_NO_PLANES) {
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_NONE, 0.5, 0.0, 0.0, &data->rgb_fb_o1);
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_NONE, 0.0, 0.5, 0.0, &data->rgb_fb_o2);
+	}
+
+	/* Create a third overlay plane for TEST_NO_PLANES test */
+	if (flags & TEST_NO_PLANES) {
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+			DRM_FORMAT_MOD_NONE, 0.0, 0.0, 0.5, &data->rgb_fb_o3);
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
+		{"max-planes", TEST_MAX_PLANES, 100,
+		"Tests native cursor fall back to overlay cursor when a top plane is YUV and there are two overlay planes used."},
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
+				/* Skip TEST_NO_PLANES if the ASIC has less than 3 overlay planes*/
+				if (tests[i].flags & TEST_NO_PLANES)
+					igt_require(get_overlay_planes_count(&data.display, pipe) >= 3);
+
+				/* Skip TEST_MAX_PLANES if the ASIC has less than 2 overlay planes*/
+				if (tests[i].flags & TEST_MAX_PLANES)
+					igt_require(get_overlay_planes_count(&data.display, pipe) >= 2);
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

