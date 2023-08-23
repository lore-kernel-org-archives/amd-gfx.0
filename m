Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFF9EE49B6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EF210E456;
	Wed, 23 Aug 2023 15:51:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A740010E445
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3FqMg3Ytjr/RvHK4/AhPWy2T+n/xPG2xJRn4scimmdCsb71YoBKiCqS9gMVnTuKQYnWoDe/ddUjcRjj9ZZbxS0gxULr7Lj+Ha7b7DyUnp0V5gpKUEdWVzS0TsOZSYUP4AM59YATM+hpRV7b1Kv4k4TX4EPGPJWiEgmm7ao3EfxRGUktmS4L7blR3BrsfM7UMNiJgHUfYfZ76ROChU5M7EwCsib3jmqzbxXp9WhDYtm9hhvR3zjhXb6qMLQuVVw8gX0VeySa0eoKPeRw1X9Dz3e4+HVX3sIzSuZShilDBCNaQS3VpxXI0w76mU0n7x3PGmIW2TZ6PzG4geMUddmm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWSBlW2iHawH9ZLU1LjYpNTXh/jEwGEf9eqxT0wJQRk=;
 b=S2oPHXsptkWcUoCp9imCWhFT0OSm1IlV/rzUK/sLmtviJsVMOhc3McjVQHSd3ekLDZu9FlOFoeg5Kp35qT9ycO1XKFPb5jXqmCK6UrEC11oe+V2IiXxZEJ4K71UNnF8kb9l8mziZ0KqCrrS9bcz1vWVocKWcidGMcnPAWIo+vR/YJH2+QY8+RI7pVuW6l3BLt38UPu40dyoEohzmPoGWYQ05NeWGNdO6PZdtRjJseWbh5PtLxL/RcNCf3/q9/DFttKo3Rt00G/YNGmgmKWIoBm7/99/49alT3PAILhDL8JUuHP4k+HBmtRUJU0+iPnwpwXr2yE05bFbnQUUNkIEqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWSBlW2iHawH9ZLU1LjYpNTXh/jEwGEf9eqxT0wJQRk=;
 b=akPr374ddK0VxmWK5/fFUkg3/lKWmao+vEFhOMZQgn8QCj5rNp1hLrgesW8gcSwCcOejTwEqR6v5bZJse7Ze+IoxrVFvglBURgG04lTNXlF2pGYTkzlKlLJItHB4OiHjIljmiuF6gHhoxVk7OWkN/bRNHcS0y5JXcc55N+SyltM=
Received: from CY5PR18CA0042.namprd18.prod.outlook.com (2603:10b6:930:13::32)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Wed, 23 Aug 2023 15:51:17 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::46) by CY5PR18CA0042.outlook.office365.com
 (2603:10b6:930:13::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/35] drm/amd/display: Add DCN35 OPTC
Date: Wed, 23 Aug 2023 11:50:30 -0400
Message-ID: <20230823155048.2526343-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 9061877e-5d79-4266-4d71-08dba3f0c961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaQiVxa9pvd9NA5gxmQZCZf8XDCcV7O1UVCjxe1LT5wUE5uVF4Und+0MBY78zv2KmvktC2CZVj1zNbGxhSKWkwX+8jFfIHhXvCl6Ol9+0W8C2wjLPtF/rKruB/HwSz1wzfbjcZ0JU4mTtwy2Vlr3gqpx8waDJypZ4XaMW3jT1YjACaDgGqDczGZ3FD9z3PHI3A5rdTgO9BOpvar3uqjd48ybHM0x8qrNY3ppvwK0Qd9DU3K9wTr9BKLEHDVRsBHIeYkHzcQ6NBbATlr7ZKgSecuhRhbCQc/Q6+hGKCL2u1ZvJfyJ2FP4qL/rMbwk5BBBlR180YrkXDGhtj616Olp3RLw6nuDuR7U5IcxzAhbnSWiz3zYuiMoloHZ7WJzXWe0oem0Xju9KXgEzyIJdy3gyhOwPsaICbn3TwTgASpD7CXCx0/knEF66tlEmMGdv+5Za3/510ypTh+L+l4rbWL9J4juEHgQcosR7sKWkiNh6xFR0gdEp7yeOZ3MkngWqgBuC0r1HFZC8VcNshjjbbW6oLXgQsloDQe/+0CEM3cgtqTl+lVAoQtxD4hfjJKjq8wjCRjAmFDeGK1PHv3OQUDagxwG/MU7dZY9ZE6TNh/iFGjQNAdoXbNdUH60f+ppeSVgodvcPCNdwtsElDc32QhoXGmdGTv3jyHOORPTmejSAmF6z03oZnbbzRGlIIWz69I0tfeGdblWPJtyF8dfhK3tZZlLWBPaNxx4GkI0DjFxLSHU3+IIOQc0R471TttKWe7mFPKf4S6anNKjj2Xalwoh3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(66899024)(40460700003)(6666004)(478600001)(36860700001)(83380400001)(47076005)(82740400003)(356005)(81166007)(30864003)(2906002)(70206006)(336012)(1076003)(426003)(16526019)(7696005)(26005)(2616005)(70586007)(36756003)(6916009)(41300700001)(8676002)(8936002)(316002)(86362001)(5660300002)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:16.8039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9061877e-5d79-4266-4d71-08dba3f0c961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add OPTC handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 284 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h | 219 ++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
new file mode 100644
index 000000000000..5f7adc83258b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#include "dcn35_optc.h"
+#include "dcn35_optc.h"
+
+#include "dcn30/dcn30_optc.h"
+#include "dcn31/dcn31_optc.h"
+#include "dcn32/dcn32_optc.h"
+#include "reg_helper.h"
+#include "dc.h"
+#include "dcn_calc_math.h"
+
+#define REG(reg)\
+	optc1->tg_regs->reg
+
+#define CTX \
+	optc1->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name) \
+	optc1->tg_shift->field_name, optc1->tg_mask->field_name
+
+/**
+ * Enable CRTC
+ * Enable CRTC - call ASIC Control Object to enable Timing generator.
+ */
+
+static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
+		struct dc_crtc_timing *timing)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t memory_mask = 0;
+	int h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	int mpcc_hactive = h_active / opp_cnt;
+	/* Each memory instance is 2048x(314x2) bits to support half line of 4096 */
+	int odm_mem_count = (h_active + 2047) / 2048;
+
+	/*
+	 * display <= 4k : 2 memories + 2 pipes
+	 * 4k < display <= 8k : 4 memories + 2 pipes
+	 * 8k < display <= 12k : 6 memories + 4 pipes
+	 */
+	if (opp_cnt == 4) {
+		if (odm_mem_count <= 2)
+			memory_mask = 0x3;
+		else if (odm_mem_count <= 4)
+			memory_mask = 0xf;
+		else
+			memory_mask = 0x3f;
+	} else {
+		if (odm_mem_count <= 2)
+			memory_mask = 0x1 << (opp_id[0] * 2) | 0x1 << (opp_id[1] * 2);
+		else if (odm_mem_count <= 4)
+			memory_mask = 0x3 << (opp_id[0] * 2) | 0x3 << (opp_id[1] * 2);
+		else
+			memory_mask = 0x77;
+	}
+
+	REG_SET(OPTC_MEMORY_CONFIG, 0,
+		OPTC_MEM_SEL, memory_mask);
+
+	if (opp_cnt == 2) {
+		REG_SET_3(OPTC_DATA_SOURCE_SELECT, 0,
+				OPTC_NUM_OF_INPUT_SEGMENT, 1,
+				OPTC_SEG0_SRC_SEL, opp_id[0],
+				OPTC_SEG1_SRC_SEL, opp_id[1]);
+	} else if (opp_cnt == 4) {
+		REG_SET_5(OPTC_DATA_SOURCE_SELECT, 0,
+				OPTC_NUM_OF_INPUT_SEGMENT, 3,
+				OPTC_SEG0_SRC_SEL, opp_id[0],
+				OPTC_SEG1_SRC_SEL, opp_id[1],
+				OPTC_SEG2_SRC_SEL, opp_id[2],
+				OPTC_SEG3_SRC_SEL, opp_id[3]);
+	}
+
+	REG_UPDATE(OPTC_WIDTH_CONTROL,
+			OPTC_SEGMENT_WIDTH, mpcc_hactive);
+
+	REG_UPDATE(OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, opp_cnt - 1);
+	optc1->opp_count = opp_cnt;
+}
+
+static bool optc35_enable_crtc(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	/* opp instance for OTG, 1 to 1 mapping and odm will adjust */
+	REG_UPDATE(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, optc->inst);
+
+	/* VTG enable first is for HW workaround */
+	REG_UPDATE(CONTROL,
+			VTG0_ENABLE, 1);
+
+	REG_SEQ_START();
+
+	/* Enable CRTC */
+	REG_UPDATE_2(OTG_CONTROL,
+			OTG_DISABLE_POINT_CNTL, 2,
+			OTG_MASTER_EN, 1);
+
+	REG_SEQ_SUBMIT();
+	REG_SEQ_WAIT_DONE();
+
+	return true;
+}
+
+/* disable_crtc */
+static bool optc35_disable_crtc(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	/* disable otg request until end of the first line
+	 * in the vertical blank region
+	 */
+	REG_UPDATE(OTG_CONTROL,
+			OTG_MASTER_EN, 0);
+
+	REG_UPDATE(CONTROL,
+			VTG0_ENABLE, 0);
+
+	/* CRTC disabled, so disable  clock. */
+	REG_WAIT(OTG_CLOCK_CONTROL,
+			OTG_BUSY, 0,
+			1, 100000);
+	optc1_clear_optc_underflow(optc);
+
+	return true;
+}
+
+static void optc35_phantom_crtc_post_enable(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	/* Disable immediately. */
+	REG_UPDATE_2(OTG_CONTROL, OTG_DISABLE_POINT_CNTL, 0, OTG_MASTER_EN, 0);
+
+	/* CRTC disabled, so disable  clock. */
+	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
+}
+
+static bool optc35_configure_crc(struct timing_generator *optc,
+				 const struct crc_params *params)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	if (!optc1_is_tg_enabled(optc))
+		return false;
+	REG_WRITE(OTG_CRC_CNTL, 0);
+	if (!params->enable)
+		return true;
+	REG_UPDATE_2(OTG_CRC0_WINDOWA_X_CONTROL,
+			OTG_CRC0_WINDOWA_X_START, params->windowa_x_start,
+			OTG_CRC0_WINDOWA_X_END, params->windowa_x_end);
+	REG_UPDATE_2(OTG_CRC0_WINDOWA_Y_CONTROL,
+			OTG_CRC0_WINDOWA_Y_START, params->windowa_y_start,
+			OTG_CRC0_WINDOWA_Y_END, params->windowa_y_end);
+	REG_UPDATE_2(OTG_CRC0_WINDOWB_X_CONTROL,
+			OTG_CRC0_WINDOWB_X_START, params->windowb_x_start,
+			OTG_CRC0_WINDOWB_X_END, params->windowb_x_end);
+	REG_UPDATE_2(OTG_CRC0_WINDOWB_Y_CONTROL,
+			OTG_CRC0_WINDOWB_Y_START, params->windowb_y_start,
+			OTG_CRC0_WINDOWB_Y_END, params->windowb_y_end);
+	if (optc1->base.ctx->dc->debug.otg_crc_db && optc1->tg_mask->OTG_CRC_WINDOW_DB_EN != 0) {
+		REG_UPDATE_4(OTG_CRC_CNTL,
+				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				OTG_CRC0_SELECT, params->selection,
+				OTG_CRC_EN, 1,
+				OTG_CRC_WINDOW_DB_EN, 1);
+	} else
+		REG_UPDATE_3(OTG_CRC_CNTL,
+				OTG_CRC_CONT_EN, params->continuous_mode ? 1 : 0,
+				OTG_CRC0_SELECT, params->selection,
+				OTG_CRC_EN, 1);
+	return true;
+}
+
+static struct timing_generator_funcs dcn35_tg_funcs = {
+		.validate_timing = optc1_validate_timing,
+		.program_timing = optc1_program_timing,
+		.setup_vertical_interrupt0 = optc1_setup_vertical_interrupt0,
+		.setup_vertical_interrupt1 = optc1_setup_vertical_interrupt1,
+		.setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
+		.program_global_sync = optc1_program_global_sync,
+		.enable_crtc = optc35_enable_crtc,
+		.disable_crtc = optc35_disable_crtc,
+		.immediate_disable_crtc = optc31_immediate_disable_crtc,
+		.phantom_crtc_post_enable = optc35_phantom_crtc_post_enable,
+		/* used by enable_timing_synchronization. Not need for FPGA */
+		.is_counter_moving = optc1_is_counter_moving,
+		.get_position = optc1_get_position,
+		.get_frame_count = optc1_get_vblank_counter,
+		.get_scanoutpos = optc1_get_crtc_scanoutpos,
+		.get_otg_active_size = optc1_get_otg_active_size,
+		.set_early_control = optc1_set_early_control,
+		/* used by enable_timing_synchronization. Not need for FPGA */
+		.wait_for_state = optc1_wait_for_state,
+		.set_blank_color = optc3_program_blank_color,
+		.did_triggered_reset_occur = optc1_did_triggered_reset_occur,
+		.triplebuffer_lock = optc3_triplebuffer_lock,
+		.triplebuffer_unlock = optc2_triplebuffer_unlock,
+		.enable_reset_trigger = optc1_enable_reset_trigger,
+		.enable_crtc_reset = optc1_enable_crtc_reset,
+		.disable_reset_trigger = optc1_disable_reset_trigger,
+		.lock = optc3_lock,
+		.unlock = optc1_unlock,
+		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
+		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
+		.enable_optc_clock = optc1_enable_optc_clock,
+		.set_drr = optc31_set_drr,
+		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
+		.set_vtotal_min_max = optc1_set_vtotal_min_max,
+		.set_static_screen_control = optc1_set_static_screen_control,
+		.program_stereo = optc1_program_stereo,
+		.is_stereo_left_eye = optc1_is_stereo_left_eye,
+		.tg_init = optc3_tg_init,
+		.is_tg_enabled = optc1_is_tg_enabled,
+		.is_optc_underflow_occurred = optc1_is_optc_underflow_occurred,
+		.clear_optc_underflow = optc1_clear_optc_underflow,
+		.setup_global_swap_lock = NULL,
+		.get_crc = optc1_get_crc,
+		.configure_crc = optc35_configure_crc,
+		.set_dsc_config = optc3_set_dsc_config,
+		.get_dsc_status = optc2_get_dsc_status,
+		.set_dwb_source = NULL,
+		.set_odm_bypass = optc3_set_odm_bypass,
+		.set_odm_combine = optc35_set_odm_combine,
+		.get_optc_source = optc2_get_optc_source,
+		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
+		.set_out_mux = optc3_set_out_mux,
+		.set_drr_trigger_window = optc3_set_drr_trigger_window,
+		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
+		.set_gsl = optc2_set_gsl,
+		.set_gsl_source_select = optc2_set_gsl_source_select,
+		.set_vtg_params = optc1_set_vtg_params,
+		.program_manual_trigger = optc2_program_manual_trigger,
+		.setup_manual_trigger = optc2_setup_manual_trigger,
+		.get_hw_timing = optc1_get_hw_timing,
+		.init_odm = optc3_init_odm,
+};
+
+void dcn35_timing_generator_init(struct optc *optc1)
+{
+	optc1->base.funcs = &dcn35_tg_funcs;
+
+	optc1->max_h_total = optc1->tg_mask->OTG_H_TOTAL + 1;
+	optc1->max_v_total = optc1->tg_mask->OTG_V_TOTAL + 1;
+
+	optc1->min_h_blank = 32;
+	optc1->min_v_blank = 3;
+	optc1->min_v_blank_interlace = 5;
+	optc1->min_h_sync_width = 4;
+	optc1->min_v_sync_width = 1;
+
+	dcn35_timing_generator_set_fgcg(
+		optc1, CTX->dc->debug.enable_fine_grain_clock_gating.bits.optc);
+}
+
+void dcn35_timing_generator_set_fgcg(struct optc *optc1, bool enable)
+{
+	REG_UPDATE(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, !enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
new file mode 100644
index 000000000000..39d3f342ba63
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __DC_OPTC_DCN35_H__
+#define __DC_OPTC_DCN35_H__
+
+#include "dcn10/dcn10_optc.h"
+
+#define OPTC_COMMON_MASK_SH_LIST_DCN3_5(mask_sh)\
+	SF(OTG0_OTG_VSTARTUP_PARAM, VSTARTUP_START, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_OFFSET, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_PARAM, VUPDATE_WIDTH, mask_sh),\
+	SF(OTG0_OTG_VREADY_PARAM, VREADY_OFFSET, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, OTG_MASTER_UPDATE_LOCK, mask_sh),\
+	SF(OTG0_OTG_MASTER_UPDATE_LOCK, UPDATE_LOCK_STATUS, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_START_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_END_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL0, MASTER_UPDATE_LOCK_DB_EN, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_START_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL1, MASTER_UPDATE_LOCK_DB_END_Y, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, OTG_MASTER_UPDATE_LOCK_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_X, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL4, DIG_UPDATE_POSITION_Y, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_UPDATE_PENDING, mask_sh),\
+	SF(OTG0_OTG_H_TOTAL, OTG_H_TOTAL, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_H_BLANK_START_END, OTG_H_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A, OTG_H_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_H_SYNC_A_CNTL, OTG_H_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL, OTG_V_TOTAL, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_START, mask_sh),\
+	SF(OTG0_OTG_V_BLANK_START_END, OTG_V_BLANK_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_START, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A, OTG_V_SYNC_A_END, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_A_POL, mask_sh),\
+	SF(OTG0_OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_START_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_DISABLE_POINT_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_FIELD_NUMBER_CNTL, mask_sh),\
+	SF(OTG0_OTG_CONTROL, OTG_OUT_MUX, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EN, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_SYNC_OUTPUT_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_STEREO_EYE_FLAG_POLARITY, mask_sh),\
+	SF(OTG0_OTG_STEREO_CONTROL, OTG_DISABLE_STEREOSYNC_OUTPUT_FOR_DP, mask_sh),\
+	SF(OTG0_OTG_STEREO_STATUS, OTG_STEREO_CURRENT_EYE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_EN, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_V_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_3D_STRUCTURE_CONTROL, OTG_3D_STRUCTURE_STEREO_SEL_OVR, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MAX, OTG_V_TOTAL_MAX, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_MIN, OTG_V_TOTAL_MIN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MIN_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_V_TOTAL_MAX_SEL, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_FORCE_LOCK_ON_EVENT, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_SET_V_TOTAL_MIN_MASK, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MIN_EN, mask_sh),\
+	SF(OTG0_OTG_V_TOTAL_CONTROL, OTG_VTOTAL_MID_REPLACING_MAX_EN, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_CLEAR, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_MODE, mask_sh),\
+	SF(OTG0_OTG_FORCE_COUNT_NOW_CNTL, OTG_FORCE_COUNT_NOW_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_SOURCE_PIPE_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_RISING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FALLING_EDGE_DETECT_CNTL, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_POLARITY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_FREQUENCY_SELECT, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_DELAY, mask_sh),\
+	SF(OTG0_OTG_TRIGA_CNTL, OTG_TRIGA_CLEAR, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_EVENT_MASK, mask_sh),\
+	SF(OTG0_OTG_STATIC_SCREEN_CONTROL, OTG_STATIC_SCREEN_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_FRAME_COUNT, OTG_FRAME_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_BLANK, mask_sh),\
+	SF(OTG0_OTG_STATUS, OTG_V_ACTIVE_DISP, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_HORZ_COUNT, mask_sh),\
+	SF(OTG0_OTG_STATUS_POSITION, OTG_VERT_COUNT, mask_sh),\
+	SF(OTG0_OTG_NOM_VERT_POSITION, OTG_VERT_COUNT_NOM, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO0, OTG_M_CONST_DTO_PHASE, mask_sh),\
+	SF(OTG0_OTG_M_CONST_DTO1, OTG_M_CONST_DTO_MODULO, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_BUSY, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_EN, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_ON, mask_sh),\
+	SF(OTG0_OTG_CLOCK_CONTROL, OTG_CLOCK_GATE_DIS, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT0_POSITION, OTG_VERTICAL_INTERRUPT0_LINE_END, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_CONTROL, OTG_VERTICAL_INTERRUPT1_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT1_POSITION, OTG_VERTICAL_INTERRUPT1_LINE_START, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_CONTROL, OTG_VERTICAL_INTERRUPT2_INT_ENABLE, mask_sh),\
+	SF(OTG0_OTG_VERTICAL_INTERRUPT2_POSITION, OTG_VERTICAL_INTERRUPT2_LINE_START, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_EN, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_ON, mask_sh),\
+	SF(ODM0_OPTC_INPUT_CLOCK_CONTROL, OPTC_INPUT_CLK_GATE_DIS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_OCCURRED_STATUS, mask_sh),\
+	SF(ODM0_OPTC_INPUT_GLOBAL_CONTROL, OPTC_UNDERFLOW_CLEAR, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_ENABLE, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_FP2, mask_sh),\
+	SF(VTG0_CONTROL, VTG0_VCOUNT_INIT, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_OCCURRED, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_FORCE_VSYNC_NEXT_LINE_CLEAR, mask_sh),\
+	SF(OTG0_OTG_VERT_SYNC_CONTROL, OTG_AUTO_FORCE_VSYNC_MODE, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL0_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL1_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL2_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_WINDOW_DB_EN, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC1_DATA_B,  CRC1_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC2_DATA_B,  CRC2_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_R_CR, mask_sh),\
+	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_G_Y, mask_sh),\
+	SF(OTG0_OTG_CRC3_DATA_B,  CRC3_B_CB, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL, OTG_CRC0_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL, OTG_CRC0_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL_READBACK, OTG_CRC0_WINDOWA_Y_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL_READBACK, OTG_CRC0_WINDOWA_Y_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL_READBACK, OTG_CRC0_WINDOWB_X_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL_READBACK, OTG_CRC0_WINDOWB_X_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL_READBACK, OTG_CRC0_WINDOWB_Y_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL_READBACK, OTG_CRC0_WINDOWB_Y_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL_READBACK, OTG_CRC1_WINDOWA_X_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL_READBACK, OTG_CRC1_WINDOWA_X_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL_READBACK, OTG_CRC1_WINDOWA_Y_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL_READBACK, OTG_CRC1_WINDOWA_Y_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL_READBACK, OTG_CRC1_WINDOWB_X_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL_READBACK, OTG_CRC1_WINDOWB_X_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_START_READBACK, mask_sh),\
+	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_END_READBACK, mask_sh),\
+	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
+	SF(GSL_SOURCE_SELECT, GSL2_READY_SOURCE_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, MANUAL_FLOW_CONTROL_SEL, mask_sh),\
+	SF(OTG0_OTG_GLOBAL_CONTROL2, GLOBAL_UPDATE_LOCK_EN, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_X, OTG_GSL_WINDOW_END_X, mask_sh), \
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_START_Y, mask_sh),\
+	SF(OTG0_OTG_GSL_WINDOW_Y, OTG_GSL_WINDOW_END_Y, mask_sh),\
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
+	SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_MASTER_MODE, mask_sh), \
+	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
+	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
+	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG2_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG3_SRC_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
+	SF(ODM0_OPTC_MEMORY_CONFIG, OPTC_MEM_SEL, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DATA_FORMAT, mask_sh),\
+	SF(ODM0_OPTC_DATA_FORMAT_CONTROL, OPTC_DSC_MODE, mask_sh),\
+	SF(ODM0_OPTC_BYTES_PER_PIXEL, OPTC_DSC_BYTES_PER_PIXEL, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_DSC_SLICE_WIDTH, mask_sh),\
+	SF(ODM0_OPTC_WIDTH_CONTROL, OPTC_SEGMENT_WIDTH, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_START_X, mask_sh),\
+	SF(OTG0_OTG_DRR_TRIGGER_WINDOW, OTG_DRR_TRIGGER_WINDOW_END_X, mask_sh),\
+	SF(OTG0_OTG_DRR_V_TOTAL_CHANGE, OTG_DRR_V_TOTAL_CHANGE_LIMIT, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE, mask_sh),\
+	SF(OTG0_OTG_H_TIMING_CNTL, OTG_H_TIMING_DIV_MODE_MANUAL, mask_sh),\
+	SF(OTG0_OTG_DOUBLE_BUFFER_CONTROL, OTG_DRR_TIMING_DBUF_UPDATE_MODE, mask_sh),\
+	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh),\
+	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh)
+
+void dcn35_timing_generator_init(struct optc *optc1);
+
+void dcn35_timing_generator_set_fgcg(struct optc *optc1, bool enable);
+
+#endif /* __DC_OPTC_DCN35_H__ */
-- 
2.41.0

