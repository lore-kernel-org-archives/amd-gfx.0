Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564C9EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 21:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB33C10E048;
	Mon, 17 Jul 2023 21:02:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0726410E2B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 21:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg5FbWA8hOVnpPqpUY2e98x/tJqNG+8UcYCA0aXcAt96yOaIl6l3p+O1fASvIEBadS/d61EeXQXGN/CBILqAAKZal6rTQbMih0WqhP3llStDAxYJT9ePXb9GL3FFY/8ZD/MA+YYXlDIfzwzsbfma9MHYLA9Evll4K5ltOyIyBK89Y6GutElg/hNlahjWZb3BxKnl8j5w+oNaQcvo+0oKuwN9i5gFuwYwv2snAnpoeHwk+gcf1OCOU/w+9kXnCUuHbw9DZlwAtj/QHvWBiN59rg2P8Fi4xkVVKmz9b5uGLTCBNgsTNzE2W9hPY+WKcJHFSFyOOHXpXL2fGrb1ckh7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSoGZPlc5Ms7GOSbByThsQHOJCA7m8DfKHlXhhy4Jzc=;
 b=CLLN7969fErqbSamjLW9GJVo0rjVlgpqBlwp1wRMxgqvh6qlwQ2f87RRiWYnMYzDXiO5OQT4KyoUkD49QrsCnLT9o1sfYCF1+HuKlH2ZB2uaqImqia9O3u2EbDm6BYa/Ru0hpvy/dtPoFdncvkzWwpsn4q7XwSm80w+EJ9iuAZBXaDUXVTMtDbf42zeZ48MUq8JMjVZGmzEh/wOfZQ2BHaQq9eOw24HS5TeNi4Px0DBb9unWUW6o4Yu4EV8uAo2WCxbRIrwr//6sXA8lHYxTk79ZDBb+lzjnjn8H6cWKzIzZDxpnS/lI754NlP8t4il3UMhdDs/1dKMqgBVEcZpP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSoGZPlc5Ms7GOSbByThsQHOJCA7m8DfKHlXhhy4Jzc=;
 b=HdUteOkHoM6/jiHEZLuvhvLfJNeC7+YL71Oknv06PpD2/pg5MZxIWqIz3K5Y+w1o9G5BCLPIZaqGYpSHnpnzmR3coQMmHPZosO+aRjxZBF7Fh+MyNQKyXcmA0nvE8yx462d8mEdqT8l0/iHnrxiZUTcF5NsEG1dWoAMrojFmqok=
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 21:01:56 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:100:cafe::29) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Mon, 17 Jul 2023 21:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 21:01:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 16:01:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 17 Jul
 2023 14:01:55 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 17 Jul 2023 16:01:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: remove an unused file
Date: Mon, 17 Jul 2023 17:01:55 -0400
Message-ID: <20230717210155.1714239-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: eda50e22-a20b-4bba-d430-08db87090e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1zyQVrxJGNhL0oo3YvrjI9k3ruMNqLnfPHwscQMu0gZAMHP2/wE6/qib43zlr3LKe9nPFovohuRd0lETSkAlNGhTFItiVjW+jwMqs1eYobhNh7rCcLrOmwnrQYDhKO1Z8E1ze0UBEdlrq14URAsvr+97/nQfG0HjaBM5pbERMa3zl9BDSGOFR7BQid2qPPXbM0KH1YzlYo01B+fIPsdLsft344ynJeyri/MmKQ4i/iW4JY0w3yVK1VTjwEgWU7t/7jPedzXgX5q8Avl3Nm1riTMjoJxKZK6oKNDO3V+YNyYmu6Gxj5VeibskODtOgQRtQypYid8tEo2BfdpJvEDkzrUnEzMdHcMJKMD2PddKhyIMTBwdxneO+LqOF354a0PA9RA1wxmGRvbD9jwCqtL/3IVUfa6Ro3lEbBgDPel2UUw4Xp5OAauTtUh9vBQSQtEzjuJjyk2uHoFdGMdQMQIggSOW4T+UFm6wF5/JZ0SDnsrWbv6QZfKwQqwhcofs/OqCHXoEZn2gkFI7eZB5/qpA1ns1whsxcvVw7UNAbEriDWoKYfQh+gpncNvXcw/1nsA/Tu9Y+xn857ODW7Id1ZYE9831W3tfg+jzQ8NntScELk/4ONuM1RgdVxxr8mPbGbB5EZ6t6dVs62v4is/qZEjiTy8BGxKRcwrnXklIOhgI3SSaXqbg/nNLICywIqf1hpBugbOVrnKStO9ccB0qMKbJ6p+ZTC2ex+Bgt3fg6fHZ43gOdsCSTCIiFhIA9GU68Bh7yHZwrIe+Q0CwOUn7mogCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(54906003)(82740400003)(356005)(81166007)(7696005)(8676002)(8936002)(478600001)(5660300002)(41300700001)(70206006)(316002)(4326008)(70586007)(6916009)(336012)(426003)(36860700001)(83380400001)(186003)(47076005)(2616005)(1076003)(26005)(86362001)(36756003)(44832011)(2906002)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 21:01:56.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda50e22-a20b-4bba-d430-08db87090e14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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
Cc: aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com,
 nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Internal subvp state is not referenced in driver code, so it can be removed.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   2 -
 .../amd/display/dmub/inc/dmub_subvp_state.h   | 183 ------------------
 2 files changed, 185 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index d52d5feeb311..a87afb796f47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -47,11 +47,9 @@
 #include "clk_mgr.h"
 #include "dsc.h"
 #include "dcn20/dcn20_optc.h"
-#include "dmub_subvp_state.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn32_resource.h"
 #include "link.h"
-#include "dmub/inc/dmub_subvp_state.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
deleted file mode 100644
index 21b02bad696f..000000000000
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * Copyright 2019 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef DMUB_SUBVP_STATE_H
-#define DMUB_SUBVP_STATE_H
-
-#include "dmub_cmd.h"
-
-#define DMUB_SUBVP_INST0 0
-#define DMUB_SUBVP_INST1 1
-#define SUBVP_MAX_WATERMARK 0xFFFF
-
-struct dmub_subvp_hubp_state {
-	uint32_t CURSOR0_0_CURSOR_POSITION;
-	uint32_t CURSOR0_0_CURSOR_HOT_SPOT;
-	uint32_t CURSOR0_0_CURSOR_DST_OFFSET;
-	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH;
-	uint32_t CURSOR0_0_CURSOR_SURFACE_ADDRESS;
-	uint32_t CURSOR0_0_CURSOR_SIZE;
-	uint32_t CURSOR0_0_CURSOR_CONTROL;
-	uint32_t HUBPREQ0_CURSOR_SETTINGS;
-	uint32_t HUBPREQ0_DCSURF_SURFACE_EARLIEST_INUSE_HIGH;
-	uint32_t HUBPREQ0_DCSURF_SURFACE_EARLIEST_INUSE;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_SURFACE_ADDRESS_C;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C;
-	uint32_t HUBPREQ0_DCSURF_PRIMARY_META_SURFACE_ADDRESS_C;
-};
-
-enum subvp_error_code {
-	DMUB_SUBVP_INVALID_STATE,
-	DMUB_SUBVP_INVALID_TRANSITION,
-};
-
-enum subvp_state {
-	DMUB_SUBVP_DISABLED,
-	DMUB_SUBVP_IDLE,
-	DMUB_SUBVP_TRY_ACQUIRE_LOCKS,
-	DMUB_SUBVP_WAIT_FOR_LOCKS,
-	DMUB_SUBVP_PRECONFIGURE,
-	DMUB_SUBVP_PREPARE,
-	DMUB_SUBVP_ENABLE,
-	DMUB_SUBVP_SWITCHING,
-	DMUB_SUBVP_END,
-	DMUB_SUBVP_RESTORE,
-};
-
-/* Defines information for SUBVP to handle vertical interrupts. */
-struct dmub_subvp_vertical_interrupt_event {
-	/**
-	 * @inst: Hardware instance of vertical interrupt.
-	 */
-	uint8_t otg_inst;
-
-	/**
-	 * @pad: Align structure to 4 byte boundary.
-	 */
-	uint8_t pad[3];
-
-	enum subvp_state curr_state;
-};
-
-struct dmub_subvp_vertical_interrupt_state {
-	/**
-	 * @events: Event list.
-	 */
-	struct dmub_subvp_vertical_interrupt_event events[DMUB_MAX_STREAMS];
-};
-
-struct dmub_subvp_vline_interrupt_event {
-
-	uint8_t hubp_inst;
-	uint8_t pad[3];
-};
-
-struct dmub_subvp_vline_interrupt_state {
-	struct dmub_subvp_vline_interrupt_event events[DMUB_MAX_PLANES];
-};
-
-struct dmub_subvp_interrupt_ctx {
-	struct dmub_subvp_vertical_interrupt_state vertical_int;
-	struct dmub_subvp_vline_interrupt_state vline_int;
-};
-
-struct dmub_subvp_pipe_state {
-	uint32_t pix_clk_100hz;
-	uint16_t main_vblank_start;
-	uint16_t main_vblank_end;
-	uint16_t mall_region_lines;
-	uint16_t prefetch_lines;
-	uint16_t prefetch_to_mall_start_lines;
-	uint16_t processing_delay_lines;
-	uint8_t main_pipe_index;
-	uint8_t phantom_pipe_index;
-	uint16_t htotal; // htotal for main / phantom pipe
-	uint16_t vtotal;
-	uint16_t optc_underflow_count;
-	uint16_t hubp_underflow_count;
-	uint8_t pad[2];
-};
-
-/**
- * struct dmub_subvp_vblank_drr_info - Store DRR state when handling
- * SubVP + VBLANK with DRR multi-display case.
- *
- * The info stored in this struct is only valid if drr_in_use = 1.
- */
-struct dmub_subvp_vblank_drr_info {
-	uint8_t drr_in_use;
-	uint8_t drr_window_size_ms;	// DRR window size -- indicates largest VMIN/VMAX adjustment per frame
-	uint16_t min_vtotal_supported;	// Min VTOTAL that supports switching in VBLANK
-	uint16_t max_vtotal_supported;	// Max VTOTAL that can still support SubVP static scheduling requirements
-	uint16_t prev_vmin;		// Store VMIN value before MCLK switch (used to restore after MCLK end)
-	uint16_t prev_vmax;		// Store VMAX value before MCLK switch (used to restore after MCLK end)
-	uint8_t use_ramping;		// Use ramping or not
-	uint8_t pad[1];
-};
-
-struct dmub_subvp_vblank_pipe_info {
-	uint32_t pix_clk_100hz;
-	uint16_t vblank_start;
-	uint16_t vblank_end;
-	uint16_t vstartup_start;
-	uint16_t vtotal;
-	uint16_t htotal;
-	uint8_t pipe_index;
-	uint8_t pad[1];
-	struct dmub_subvp_vblank_drr_info drr_info;	// DRR considered as part of SubVP + VBLANK case
-};
-
-enum subvp_switch_type {
-	DMUB_SUBVP_ONLY, // Used for SubVP only, and SubVP + VACTIVE
-	DMUB_SUBVP_AND_SUBVP, // 2 SubVP displays
-	DMUB_SUBVP_AND_VBLANK,
-	DMUB_SUBVP_AND_FPO,
-};
-
-/* SubVP state. */
-struct dmub_subvp_state {
-	struct dmub_subvp_pipe_state pipe_state[DMUB_MAX_SUBVP_STREAMS];
-	struct dmub_subvp_interrupt_ctx int_ctx;
-	struct dmub_subvp_vblank_pipe_info vblank_info;
-	enum subvp_state state; // current state
-	enum subvp_switch_type switch_type; // enum take up 4 bytes (?)
-	uint8_t mclk_pending;
-	uint8_t num_subvp_streams;
-	uint8_t vertical_int_margin_us;
-	uint8_t pstate_allow_width_us;
-	uint32_t subvp_mclk_switch_count;
-	uint32_t subvp_wait_lock_count;
-	uint32_t driver_wait_lock_count;
-	uint32_t subvp_vblank_frame_count;
-	uint16_t watermark_a_cache;
-	uint8_t pad[2];
-};
-
-#endif /* _DMUB_SUBVP_STATE_H_ */
-- 
2.41.0

