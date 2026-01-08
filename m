Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5117FD14899
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 03:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E6610E66A;
	Thu,  8 Jan 2026 03:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L7AWTVQN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2643F10E66A;
 Thu,  8 Jan 2026 03:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzBs9HN/jfwiOEoxjGHlA3t88d58mvbtMQr2MJIpuhNkrzL+qNZzKg36QxiTaNc9TY2VRkSU0hK/kxvdnOUaBOo8wh8BlaMuKxVxpsdiVjS7/PPRb2/iH1HkMk2oDkPeKkbcHICQ6DkzfmWw7p3bzFOVWHMGxvdZ7Vudg7fDo+4YnR5Ytc9r3DdVvC13qMtTTO9WTmjzanWpTrHoTkPQRH3pCjovMuCmXmwmmqeEMqvyNUBRW819YUfUSCGDBYeeuhJkaMQrANu1vydr2Xc4fvqcx/UIJ6kVw3nZeLU1b62Jbu51KPZSwJGZEH8M4WE8JBox2jswvSpC7730Mw4RVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrldW4VltTZaOjZKIpfOIzZVcFEhv/Ku0HpBtH51Lew=;
 b=toFMVOGF8EtKAe1slRqqkBcNmOxlZrYfa0cm2guvkKUXRDlouWbQST6Fcee5mI+WajjEuwDle2+mEGyROu0B0VoGXs1J6zdoJyGUsSvu80vid0uhrzLw0GCRbVTQ6ncQznNnepfb9k7pci5lrFLcqb4/5IzGxtKnfsqaLZLyH/4MNNAjNlxoGOfxCZ1Bs8FD82F6N1l/9AYDUEjc79JJy3t5k9HaJJ+G7lB8bj7FbkAD3yId3Eab5dYwcH7cb/H6oky+gYwxz9mQUO653CZkp+J7dOjHD/dUJWFChkTPftVqDhtdJjIh2CrxHjIKHFNoEOSJAFueICBf7QgpvvtSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrldW4VltTZaOjZKIpfOIzZVcFEhv/Ku0HpBtH51Lew=;
 b=L7AWTVQNxHrced5XPHIEYVv/kZKv2mfKyFxjNjRTO999kmkinPan2EOjKf6h4MgdmzKro0g8A1euj7oYjzeHaAlq253Hm3BpJ+bptJCYDfYkfWB9b9r6j+QewriAPd8EDa99SbniG68FOO2TUSLAWKibaKTzq1DxftNBG0XFrmI=
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 03:08:17 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::be) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 8
 Jan 2026 03:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 03:08:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 21:08:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 19:08:15 -0800
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 21:08:15 -0600
From: <IVAN.LIPSKI@amd.com>
To: <igt-dev@lists.freedesktop.org>
CC: <sunpeng.li@amd.com>, <harry.wentland@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH i-g-t] tests/amdgpu: Add test for native cursor fallback to
 overlay
Date: Wed, 7 Jan 2026 22:07:50 -0500
Message-ID: <20260108030750.1012908-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: e49e96d3-317f-4159-f387-08de4e632ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJ/a+5yPaOXkkgY+5oqpc9hOvnR5mGIvgX83Hb5UeIic6s34VxQyJATqomR2?=
 =?us-ascii?Q?lmahbHAbk30uKlaCCwU9vYY7enYEHp5ZF23xxVl1anL7efBaARgsOIagmiwT?=
 =?us-ascii?Q?1tOTjGRbBXrc459v1M18xmrof7ha+FtWDh08EiptMNGfV75KN1OmTDHOmDQI?=
 =?us-ascii?Q?CZx53ckM8CwN1st8CNUsiN7/SaC0ZJ8VoDybchBDjt4WmpXwWNRwSFtSnMFK?=
 =?us-ascii?Q?cJD+oueViciSjXttNGg96ruzBoMPp3Wu99XavL/DJNhNKYowzhPZiDgW2P6T?=
 =?us-ascii?Q?B6sbMsUU+OpWtJphHl/MkwsxreOo+/qRx9rCDntD+TVOCqSRNWWclMhWB+T5?=
 =?us-ascii?Q?XIA031dtI3A/0nUcqI/2huPUZQzt0DoB8atjda/SZ03tXC8lz33kWM2JV2R0?=
 =?us-ascii?Q?dmAWXVd9nWzSQagBAK1MH7V0xt8SkjyU0+CMvqsQtN2d357PX51H/MECkmHE?=
 =?us-ascii?Q?tFzTZ21kPOfGO+Lp84E53xzE8fzSsRJW6PiJPnKhMOvhkK1fHxH1Z4Fjym1V?=
 =?us-ascii?Q?+l1PTyVFzmvVAaQVmuzPh4p//vZeDbhI5Y6RplMMJo+PVXmx5R0FmH5xxFhj?=
 =?us-ascii?Q?UiTYBOfz5eD0/xEgCR3IGWXc+2uMzV9gD/+YvJ3gN1aD2S/FdtKIlJa/sRrU?=
 =?us-ascii?Q?hxRaDYbRJMZnQ2icAHdmEL7jYiWOzbuATcV49F2T0ElK3pBcKFzueEVgu/Dn?=
 =?us-ascii?Q?abWdrwIgn0J0QCOY9F1IEQ1+9UL8WOdAXK9lRdIIZm+n9cjLsy1l2oBJCYRN?=
 =?us-ascii?Q?hqFUXbtxfkb+KZyNco05EqIwbwiBYStSvtHYAf/SiLLUXKE1t+hsO1a7jLaA?=
 =?us-ascii?Q?hfzZ4rQR2EZgRHdZMgCK+P6CU+ukKt4p0StI+XeqcSge18hVxq/icgUX2ozA?=
 =?us-ascii?Q?2u8Z7WLUYdYxtjhKtDDG51akf20smoIodnkvj6o7AIAP5vwuhciuEIT56tZS?=
 =?us-ascii?Q?g3k5n2aPM+Odjcj/PEgITSvQG0FL+olbojR/dn/zNQHsFdHsKfd5hH5PmCBM?=
 =?us-ascii?Q?CQcYL02/xOBFawQjyu4xlGatZM1twMxKbHCW/knACTmRhvAdvDzCmokFzW9W?=
 =?us-ascii?Q?tNp7/kWdOJVZqPi0E263DRWQmUtwS+FKhjxO/Utx8EbGEGD2FdDuA6is9dUp?=
 =?us-ascii?Q?2gLy9cFTttXLPA+oB5tpK34jzihsu/AWrwE3//eG0YuP3W65qq7Wnv3C5ybZ?=
 =?us-ascii?Q?tIlLZFXKVwKxL8b4HSlEmgEzMMTtrM1dLoSipguxujB/xXxuLzbEVjfD+gHW?=
 =?us-ascii?Q?y/fu0BGhIUaK39jBGIZmjzc4/zX5Qa+eupT4W1DCUpnxkycPprT8aBHyDzqB?=
 =?us-ascii?Q?KWTovmQ3YHmFwgNLjFR8IOW7hUp1u4YX/86zf2a/AbxIBu9x3BK4kSfbqMHv?=
 =?us-ascii?Q?otL+iSS0TRChY7UNSYb/RGpUim2tbORnJuUdmsOJC0KA+2nhGz0hDife9qdB?=
 =?us-ascii?Q?maO0LvVao+yrwz3FN1q0DQ/M7Np1XB+74AvTT7igB73c3/YsOWiA548UjZ2A?=
 =?us-ascii?Q?CZbbD6GrOc6mNxxDfEK7vcxbjnw17ayIeqUjJNFpEEQuR3nj4OKjdbDaGqXd?=
 =?us-ascii?Q?AivNqTAElkyJpGUTED4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 03:08:16.1396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49e96d3-317f-4159-f387-08de4e632ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
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
Instead, the cursor is rendered either using the primary plane (native)
or an available overlay plane (overlay). This test verifies that the
cursor correctly falls back from native to overlay mode
when the underneath primary plane is incompatible.
It has 5 subtests:

rgb-to-yuv
Switches the primary plane to a YUV format FB and verifies that
the cursor falls back from primary to overlay plane. Uses CRC to verify
that the cursor fall back to overlay plane is successful.

non-full
Switches the primary plane to a FB that does not fill the entire CRTC, not
underneath the cursor to trigger the fall back from native to overlay
plane. Uses CRC to verify that the cursor fall back to overlay plane is
successful.

scaling-[50,75,125,150,175,200]
Switches the primary plane to a FB with a chosen scaling (50%-200%), which
is then filled in the CRTC. Uses CRC to verify that the cursor fall back
to overlay plane is successful.

max-planes
Enables all but one overlay planes, a primary plane and a cursor above
the primary plane. Then switches the primary plane to YUV to cause the
cursor to fall back to use an overlay plane. Uses CRC to verify that the
cursor fall back to overlay plane is successful.

no-available-planes
Enables all available overlay planes, a primary plane and a cursor above
the primary plane. Then switches the primary plane to YUV to cause the
cursor to fall back to overlay. Verifies that the atomic commit fails due
to no available overlay planes.
NOTE: This subtest is currently only available for DCN 2.1 & DCN 3.5 AMD
APU's.

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 tests/amdgpu/amd_cursor_overlay.c | 529 ++++++++++++++++++++++++++++++
 tests/amdgpu/meson.build          |   1 +
 2 files changed, 530 insertions(+)
 create mode 100644 tests/amdgpu/amd_cursor_overlay.c

diff --git a/tests/amdgpu/amd_cursor_overlay.c b/tests/amdgpu/amd_cursor_overlay.c
new file mode 100644
index 000000000..481219f9f
--- /dev/null
+++ b/tests/amdgpu/amd_cursor_overlay.c
@@ -0,0 +1,529 @@
+// SPDX-License-Identifier: MIT
+// Copyright 2025 Advanced Micro Devices, Inc.
+
+#include "igt.h"
+#include "igt_kms.h"
+#include "amdgpu_drm.h"
+#include "amdgpu.h"
+
+/*
+ * Only two ASICs of FAMILY_RV are DCN 2.1.
+ * They can be determined by their external chip revision.
+ *
+ * This is necessary to determine if the NO_AVAILABLE_PLANES subtest is
+ * applicable to the ASIC under test.
+ *
+ * NOTE: Copied from dal_asic_id.h in AMD's display driver on Linux.
+ */
+#define ASICREV_IS_RENOIR(eChipRev) ((eChipRev >= 0x91) && (eChipRev < 0xF0))
+#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= 0xA1) && (eChipRev < 0xFF))
+
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
+ *				is YUV and there are all but one overlay planes are used.
+ *
+ * SUBTEST: no-available-planes
+ * Description: Tests native cursor attempt to fall back to overlay cursor,
+ *				but fails atomic commit due to no available overlay planes.
+ */
+
+enum {
+	TEST_YUV = 1,
+	TEST_QUARTER_FB = 1 << 1,
+	TEST_SCALING = 1 << 2,
+	TEST_MAX_PLANES = 1 << 3,
+	TEST_NO_AVAILABLE_PLANES = 1 << 4,
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
+	igt_plane_t *overlays[6];
+	igt_output_t *output;
+	igt_crtc_t *pipe;
+	igt_pipe_crc_t *pipe_crc;
+	drmModeModeInfo *mode;
+	igt_fb_t rgb_fb;
+	igt_fb_t rgb_fb_o;
+	igt_fb_t yuv_fb;
+	igt_fb_t quarter_fb;
+	igt_fb_t scale_fb;
+	igt_fb_t cfb;
+	enum pipe pipe_id;
+	int drm_fd;
+	int available_overlay_planes;
+	uint64_t max_curw;
+	uint64_t max_curh;
+} data_t;
+
+/* Retuns the number of available overlay planes. */
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
+/* Sets all overlay planes to the given fb and position, then commits. */
+static void set_overlay_planes(data_t *data, int count, igt_fb_t *fb, int x, int y)
+{
+	for (int i = 0; i < count; i++) {
+		igt_plane_set_fb(data->overlays[i], fb);
+		igt_plane_set_position(data->overlays[i], x, y);
+	}
+	igt_display_commit_atomic(&data->display, 0, NULL);
+}
+
+/*
+ * Checks the ASIC has enough overlay planes and from a supported family.
+ *
+ * Currently TEST_NO_AVAILABLE_PLANES subtest is only
+ * applicable to DCN 2.1 & DCN 3.5+ APUs.
+ */
+static bool can_support_all_overlay_planes(int available_overlay_planes, int family_id, int chip_rev_id)
+{
+	/* For now we only support ASICs with 3 overlay planes. */
+	if (available_overlay_planes != 3)
+		return false;
+
+	switch (family_id) {
+	case AMDGPU_FAMILY_RV:
+		return (ASICREV_IS_RENOIR(chip_rev_id) ||
+			ASICREV_IS_GREEN_SARDINE(chip_rev_id));
+	case AMDGPU_FAMILY_GC_11_5_0:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Common test setup. */
+static void test_init(data_t *data, enum pipe pipe_id, igt_output_t *output,
+		      unsigned int flags, int available_overlay_planes)
+{
+	int i;
+
+	data->pipe_id = pipe_id;
+	data->available_overlay_planes = available_overlay_planes;
+	data->pipe = &data->display.pipes[data->pipe_id];
+	data->output = output;
+	data->mode = igt_output_get_mode(data->output);
+	data->primary = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_PRIMARY);
+	data->cursor = igt_pipe_get_plane_type(data->pipe, DRM_PLANE_TYPE_CURSOR);
+
+	if (flags & TEST_MAX_PLANES)
+		for (i = 0; i < available_overlay_planes - 1; i++)
+			data->overlays[i] = igt_pipe_get_plane_type_index(data->pipe,
+						DRM_PLANE_TYPE_OVERLAY, i);
+	if (flags & TEST_NO_AVAILABLE_PLANES)
+		for (i = 0; i < available_overlay_planes; i++)
+			data->overlays[i] = igt_pipe_get_plane_type_index(data->pipe,
+						DRM_PLANE_TYPE_OVERLAY, i);
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
+	/* Free CRC collector first */
+	igt_pipe_crc_free(data->pipe_crc);
+
+	/* Clear all planes */
+	igt_plane_set_fb(data->primary, NULL);
+	igt_plane_set_fb(data->cursor, NULL);
+
+	for (int i = 0; i < data->available_overlay_planes; i++)
+		if (data->overlays[i])
+			igt_plane_set_fb(data->overlays[i], NULL);
+
+	/* Commit the cleared plane state before resetting the graph */
+	igt_display_commit2(&data->display, COMMIT_ATOMIC);
+
+	/* Reset the display graph after committing the null state */
+	igt_display_reset(&data->display);
+}
+
+/* Common test cleanup. */
+static void test_cleanup(data_t *data)
+{
+	igt_remove_fb(data->drm_fd, &data->cfb);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb);
+	igt_remove_fb(data->drm_fd, &data->rgb_fb_o);
+	igt_remove_fb(data->drm_fd, &data->yuv_fb);
+	igt_remove_fb(data->drm_fd, &data->quarter_fb);
+	igt_remove_fb(data->drm_fd, &data->scale_fb);
+}
+
+
+static void test_cursor_pos(data_t *data, int x, int y, unsigned int flags)
+{
+	igt_crc_t ref_crc, test_crc;
+	cairo_t *cr;
+	igt_fb_t *rgb_fb = &data->rgb_fb;
+	igt_fb_t *rgb_fb_o = &data->rgb_fb_o;
+	igt_fb_t *yuv_fb = &data->yuv_fb;
+	igt_fb_t *quarter_fb = &data->quarter_fb;
+	igt_fb_t *cfb = &data->cfb;
+	igt_fb_t *scale_fb = &data->scale_fb;
+	int cw = cfb->width;
+	int ch = cfb->height;
+	int available_overlay_planes = data->available_overlay_planes;
+	int opp_x, opp_y, ret;
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
+	/* Display the cursor. */
+	igt_plane_set_fb(data->cursor, cfb);
+	igt_plane_set_position(data->cursor, x, y);
+	igt_display_commit_atomic(&data->display, 0, NULL);
+
+	/* Place the overlay plane on the opposite quarter of the screen from the cursor. */
+	if (flags & TEST_MAX_PLANES ||
+	    flags & TEST_NO_AVAILABLE_PLANES ||
+	    flags & TEST_QUARTER_FB) {
+		opp_x = x < (data->mode->hdisplay / 2) ? (data->mode->hdisplay / 2) : 0;
+		opp_y = y < (data->mode->vdisplay / 2) ? (data->mode->vdisplay / 2) : 0;
+	}
+
+	if (flags & TEST_NO_AVAILABLE_PLANES) {
+
+		/* Display the overlay planes. */
+		set_overlay_planes(data, available_overlay_planes, rgb_fb_o, opp_x, opp_y);
+
+		/*
+		 * Trigger cursor fall back due to a YUV plane;
+		 * expect the atomic commit to fail due to no
+		 * available overlay planes.
+		 */
+		igt_plane_set_fb(data->primary, &data->yuv_fb);
+		ret = igt_display_try_commit_atomic(&data->display,
+			 DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
+
+		/* Expected atomic commit to fail due to no available overlay planes. */
+		igt_assert_f(ret == -EINVAL,
+			"Expected commit fail due to no available overlay planes.\n");
+
+		/* Exit early. */
+		return;
+	}
+
+	/* Display the overlay planes as a reference for TEST_MAX_PLANES. */
+	if (flags & TEST_MAX_PLANES) {
+		/* Display the overlay planes. */
+		set_overlay_planes(data, available_overlay_planes - 1, rgb_fb_o, opp_x, opp_y);
+	}
+
+	/** Record a reference CRC. */
+	igt_pipe_crc_start(data->pipe_crc);
+	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &ref_crc);
+
+	/* Switch primary plane to YUV FB for TEST_YUV and TEST_MAX_PLANES. */
+	if (flags & TEST_YUV || flags & TEST_MAX_PLANES) {
+		igt_plane_set_fb(data->primary, yuv_fb);
+		igt_plane_set_position(data->primary, 0, 0);
+		igt_plane_set_size(data->primary, yuv_fb->width, yuv_fb->height);
+		igt_display_commit_atomic(&data->display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
+
+	/* Switch primary plane to use a quarter-sized FB, opposite from cursor. */
+	} else if (flags & TEST_QUARTER_FB) {
+		igt_plane_set_fb(data->primary, quarter_fb);
+		igt_plane_set_position(data->primary, opp_x, opp_y);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+
+	/* Switch primary plane to use a scaled FB. */
+	} else if (flags & TEST_SCALING) {
+		igt_plane_set_fb(data->primary, scale_fb);
+		igt_plane_set_position(data->primary, 0, 0);
+		igt_plane_set_size(data->primary, data->mode->hdisplay, data->mode->vdisplay);
+		igt_display_commit_atomic(&data->display, 0, NULL);
+	}
+
+	/*
+	 * Wait for one more vblank since cursor updates are not
+	 * synchronized to the same frame on AMD hw.
+	 */
+	if(is_amdgpu_device(data->drm_fd))
+		igt_wait_for_vblank_count(igt_crtc_for_pipe(&data->display, data->pipe_id), 1);
+
+	/* Record the new CRC. */
+	igt_pipe_crc_get_current(data->drm_fd, data->pipe_crc, &test_crc);
+	igt_pipe_crc_stop(data->pipe_crc);
+
+	/* CRC Check is sufficient for this test */
+	igt_assert_crc_equal(&ref_crc, &test_crc);
+}
+
+/*
+ * Tests the cursor on a variety of positions on the screen.
+ * Specific edge cases that should be captured here are the negative edges
+ * of each plane and the centers.
+ */
+static void test_cursor_spots(data_t *data, int size, unsigned int flags)
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
+		test_cursor_pos(data, pos[i].x, pos[i].y, flags);
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
+	/* Create primary FB. */
+	igt_create_color_fb(data->drm_fd, sw, sh, DRM_FORMAT_XRGB8888,
+			    DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->rgb_fb);
+
+	/* Create cursor FB. */
+	igt_create_color_fb(data->drm_fd, size, size, DRM_FORMAT_ARGB8888,
+				DRM_FORMAT_MOD_LINEAR, 1.0, 0.0, 1.0, &data->cfb);
+
+	/* Create YUV FB for RGB-to-YUV, MAX_PLANES and NO_AVAILABLE_PLANES subtests */
+	if (flags & TEST_YUV ||
+	    flags & TEST_MAX_PLANES ||
+	    flags & TEST_NO_AVAILABLE_PLANES)
+		igt_create_fb(data->drm_fd, sw, sh, DRM_FORMAT_NV12,
+					DRM_FORMAT_MOD_NONE, &data->yuv_fb);
+
+	/* Create a quarter-sized FB. */
+	if (flags & TEST_QUARTER_FB)
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->quarter_fb);
+
+	/* Create a FB for scaling. */
+	if (flags & TEST_SCALING)
+		igt_create_color_fb(data->drm_fd, (sw * scaling_factor) / 100, (sh * scaling_factor) / 100, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 0.0, 0.0, &data->scale_fb);
+
+	/*
+	 * Create RGB FB for overlay planes for MAX_PLANES and
+	 * NO_AVAILABLE_PLANES subtests.
+	 *
+	 * The overlay FB size is quarter the screen size to ensure that
+	 * the cursor can be placed on the primary plane to trigger fall back.
+	 */
+	if (flags & TEST_MAX_PLANES || flags & TEST_NO_AVAILABLE_PLANES) {
+		/* Create RGB FB for overlay planes. */
+		igt_create_color_fb(data->drm_fd, sw / 2, sh / 2, DRM_FORMAT_XRGB8888,
+					DRM_FORMAT_MOD_LINEAR, 0.0, 1.0, 0.0, &data->rgb_fb_o);
+	}
+
+	igt_output_set_crtc(data->output,
+		igt_crtc_for_pipe(data->output->display, data->pipe_id));
+
+	/* Run the test for different cursor spots. */
+	test_cursor_spots(data, size, flags);
+}
+
+int igt_main()
+{
+	static const int cursor_sizes[] = { 64, 128, 256 };
+	data_t data = { .max_curw = 64, .max_curh = 64 };
+	enum pipe pipe;
+	igt_output_t *output;
+	igt_display_t *display;
+	int i, j, available_overlay_planes;
+	int ret, err, family_id, chip_rev_id;
+	uint32_t major, minor;
+	amdgpu_device_handle device;
+	struct amdgpu_gpu_info gpu_info = {0};
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
+		"Tests native cursor fall back to overlay cursor when a top plane is YUV and there are all but one overlay planes used."},
+		{"no-available-planes", TEST_NO_AVAILABLE_PLANES, 100,
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
+	igt_fixture() {
+
+		/* Initialize the driver and retrieve GPU info. */
+		data.drm_fd = drm_open_driver_master(DRIVER_AMDGPU);
+		err = amdgpu_device_initialize(data.drm_fd, &major, &minor, &device);
+		igt_require(err == 0);
+
+		err = amdgpu_query_gpu_info(device, &gpu_info);
+		igt_require(err == 0);
+
+		family_id = gpu_info.family_id;
+		chip_rev_id = gpu_info.chip_external_rev;
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
+			/*
+			 * Skip YUV, MAX_PLANES and NO_AVAILABLE_PLANES subtests
+			 * if YUV is not supported.
+			 */
+			if (tests[i].flags & TEST_YUV ||
+			    tests[i].flags & TEST_MAX_PLANES ||
+			    tests[i].flags & TEST_NO_AVAILABLE_PLANES)
+				igt_require(igt_display_has_format_mod(display,
+							DRM_FORMAT_NV12,
+							DRM_FORMAT_MOD_LINEAR));
+
+			for_each_pipe_with_single_output(&data.display, pipe, output) {
+
+				igt_display_reset(display);
+				igt_output_set_crtc(output,
+					igt_crtc_for_pipe(output->display, pipe));
+
+				available_overlay_planes = get_overlay_planes_count(display, pipe);
+
+				/* Require at least one overlay plane. */
+				if (!available_overlay_planes)
+					igt_skip("%s subtest requires at least 1 overlay plane.\n",
+						 tests[i].name);
+
+				/*
+				 * For now, NO_AVAILABLE_PLANES substest is only appropriate for
+				 * AMD ASICs with 3 overlay planes and with DCN 2.1 & 3.5+ APU's.
+				 */
+				if (tests[i].flags & TEST_NO_AVAILABLE_PLANES &&
+				    !can_support_all_overlay_planes(available_overlay_planes, family_id, chip_rev_id))
+					igt_skip("%s subtest requires 3 overlay planes with a supported DCN.\n",
+						 tests[i].name);
+
+				test_init(&data, pipe, output, tests[i].flags, available_overlay_planes);
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
+
+				/* Detach output and commit a clean state before moving to the next subtest */
+				igt_output_set_crtc(output, NULL);
+				igt_display_commit2(&data.display, COMMIT_ATOMIC);
+			}
+		}
+	}
+
+	igt_fixture() {
+
+		igt_display_reset(&data.display);
+		igt_display_commit2(&data.display, COMMIT_ATOMIC);
+		igt_display_fini(&data.display);
+		drm_close_driver(data.drm_fd);
+	}
+}
diff --git a/tests/amdgpu/meson.build b/tests/amdgpu/meson.build
index b718699f1..01c8b4fec 100644
--- a/tests/amdgpu/meson.build
+++ b/tests/amdgpu/meson.build
@@ -12,6 +12,7 @@ if libdrm_amdgpu.found()
 			  'amd_color',
 			  'amd_cp_dma_misc',
 			  'amd_cs_nop',
+			  'amd_cursor_overlay',
 			  'amd_deadlock',
 			  'amd_dp_dsc',
 			  'amd_freesync_video_mode',
-- 
2.43.0

