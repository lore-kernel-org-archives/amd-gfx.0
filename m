Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD48EE49A0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C179110E455;
	Wed, 23 Aug 2023 15:51:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2BA10E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ7zx81syJX8xd6MKiO1OGav++o1I2DjMZbERx1r6EFkj4NSDDU1ABF9PfsRX8NCtPDjPemeVQbfFY586p0Gk0suHjba9PGGHx5VYzGZDEkaN++xnCs4l/FZ9JJ0HeCLxrMhH+dCB7R/l54FNSOFwzGq+IJhXPxhPiky+VSsnKWFjm2oV8Y2o1MsJ0mVRRCX7ypaGDbqO6XflrGbxb6MzVNdSWc6ZncJ4bUbXm9pavDcVsl7H7sEhSsbDbYNJdd2X6B7OShMYtFcX0tJP3JL8JPwsw2cUgtoAou9GVqHw5tVkbvUGcri5pbFMj3iHG3OT4YslXn2NO3DJEkdtsK4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX8Yyg2Ke8/uh2mUtWOlKL5C5gGaPRhFhywlSPFeQ2c=;
 b=ZU7ULhuAimeBG0Uo/tI9fSz4pdtBuxVPt0x0mDaoJcOaWcz4ONjMRZyaZofysoNbL6ojtE5qvvOAeNMoEgc/mJS1Xow8ga4qABvOB8Gx/TGOz25IRxAlhj1aii0TGo7kvs+WKgmUEz8sg4Qp09mRcJ6+uE0i6TQ93ZWD24F0EnycXQD8dYzfXv2vDhEDMFdKDwr5mZWoEM0zvpvG2NVcD2JGu+iy6mvxmpGIC7DSAROicvixWQGfHls14SXJQ/4AXJQD8MoQZbKSE6DX87sQTUrKumFFk6Jb0LluvacgiHeaWiB7BNOKSqs7cTQH8/W4r+uGAXB2NXdT+OycE3rqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX8Yyg2Ke8/uh2mUtWOlKL5C5gGaPRhFhywlSPFeQ2c=;
 b=jdRCqTcVowPTfopT4Vh0R9moDr7Lw1u20WcT6k30eTvqsiq67ESEgzIUHrDdj/PAoyEpMf/hPfbJE77insUCfyVNrFVQQIgOdYDywN5t+6qmPeYOm/1hu8kdsObZNftw1UtlTB+2UN8w6Z03nSOBlJNd89VvHopIWfyuMIgWYuI=
Received: from CY5PR18CA0036.namprd18.prod.outlook.com (2603:10b6:930:13::21)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:19 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::20) by CY5PR18CA0036.outlook.office365.com
 (2603:10b6:930:13::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/35] drm/amd/display: Add DCN35 HUBP
Date: Wed, 23 Aug 2023 11:50:34 -0400
Message-ID: <20230823155048.2526343-21-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: ca228d3b-e31b-4e82-7968-08dba3f0cab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kzRSSXRt/Ii9DrqzwY615tDmA4iwvTwmrskxKSaeaGekY4JQDIQ4t+gLKAPoGas/wsY4AsmrM3M6HEAxQSXMZKkDX4+7sEsjlHjq7i3DodEoqwVG1rTtk1sZbYJXUTkc0YJSGKSQYYwVK6L20t96alnTaRednKGx6g4if13ScpRv5PKDrlQcAE1bKQFBXNoH+8qwWthJjFIicx78apodO1RNgITzeaU7yFsoxPizohRiN8Kx7hQ65ArLPMRjk1ELsRzZypP/uSUGfJdArfU/WEBaEviwY1K1q9MafbKPKRhUAq3k1bar54+ZRQpjhPIfO33kGKd4GHPyifbkjUI9ffdVKHrdbv3nhArFMvWlnBBvRq25ImhHN0ILukxalg89hxfCxvcvfmlezw46yvMR5Hg7T5PPLp0VAe3aztaJ7eW+0vtASq6zZOVUhScAH3ineoqOdr3oQJ9gKnX/T/EyqbZ5ShR96Ric5fsTwr+AlaKoypwiTONLp8SONFJAQpMlCxpK9ZWXPBgWFP7sfQQqTaPW1nG7bkxueHYqzgsRXADPxi3hqbLQAr7zoOQA706G7/tDprF36GKzWPG0aRMRwWmHT/VQvp8MerEIYKpAxdU+lTeqzXFTwqL6g4CbYnMy6F9Rn9iYGHyakA44nNqeRdqjuKaqsoRdU7genr++t8+y0L7p94a44VzzVaieTV5jqE+R62njZJTKnwXW6/0E7uIeocMWF1hsj2avE8to16T2MwSLiAsBEKPmVMitj36y30j4HiqDmM6907S6BFiOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:19.0070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca228d3b-e31b-4e82-7968-08dba3f0cab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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
Add HUBP handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c | 104 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  59 ++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
new file mode 100644
index 000000000000..2ae7b151b56c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
@@ -0,0 +1,104 @@
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
+#include "dcn35_hubp.h"
+#include "reg_helper.h"
+
+#define REG(reg)\
+	hubp2->hubp_regs->reg
+
+#define CTX \
+	hubp2->base.ctx
+
+#undef FN
+#define FN(reg_name, field_name)                                           \
+	((const struct dcn35_hubp2_shift *)hubp2->hubp_shift)->field_name, \
+		((const struct dcn35_hubp2_mask *)hubp2->hubp_mask)->field_name
+
+void hubp35_set_fgcg(struct hubp *hubp, bool enable)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(HUBP_CLK_CNTL, HUBP_FGCG_REP_DIS, !enable);
+}
+
+static void hubp35_init(struct hubp *hubp)
+{
+	hubp3_init(hubp);
+
+	hubp35_set_fgcg(hubp, hubp->ctx->dc->debug.enable_fine_grain_clock_gating.bits.dchub);
+
+	/*do nothing for now for dcn3.5 or later*/
+}
+struct hubp_funcs dcn35_hubp_funcs = {
+	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
+	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
+	.hubp_program_surface_flip_and_addr = hubp3_program_surface_flip_and_addr,
+	.hubp_program_surface_config = hubp3_program_surface_config,
+	.hubp_is_flip_pending = hubp2_is_flip_pending,
+	.hubp_setup = hubp3_setup,
+	.hubp_setup_interdependent = hubp2_setup_interdependent,
+	.hubp_set_vm_system_aperture_settings = hubp3_set_vm_system_aperture_settings,
+	.set_blank = hubp2_set_blank,
+	.dcc_control = hubp3_dcc_control,
+	.mem_program_viewport = min_set_viewport,
+	.set_cursor_attributes	= hubp2_cursor_set_attributes,
+	.set_cursor_position	= hubp2_cursor_set_position,
+	.hubp_clk_cntl = hubp2_clk_cntl,
+	.hubp_vtg_sel = hubp2_vtg_sel,
+	.dmdata_set_attributes = hubp3_dmdata_set_attributes,
+	.dmdata_load = hubp2_dmdata_load,
+	.dmdata_status_done = hubp2_dmdata_status_done,
+	.hubp_read_state = hubp3_read_state,
+	.hubp_clear_underflow = hubp2_clear_underflow,
+	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
+	.hubp_init = hubp35_init,
+	.set_unbounded_requesting = hubp31_set_unbounded_requesting,
+	.hubp_soft_reset = hubp31_soft_reset,
+	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_in_blank = hubp1_in_blank,
+	.program_extended_blank = hubp31_program_extended_blank_value,
+};
+
+bool hubp35_construct(
+	struct dcn20_hubp *hubp2,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn_hubp2_registers *hubp_regs,
+	const struct dcn35_hubp2_shift *hubp_shift,
+	const struct dcn35_hubp2_mask *hubp_mask)
+{
+	hubp2->base.funcs = &dcn35_hubp_funcs;
+	hubp2->base.ctx = ctx;
+	hubp2->hubp_regs = hubp_regs;
+	hubp2->hubp_shift = (const struct dcn_hubp2_shift *)hubp_shift;
+	hubp2->hubp_mask = (const struct dcn_hubp2_mask *)hubp_mask;
+	hubp2->base.inst = inst;
+	hubp2->base.opp_id = OPP_ID_INVALID;
+	hubp2->base.mpcc_id = 0xf;
+
+	return true;
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
new file mode 100644
index 000000000000..3addd66ed01b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
@@ -0,0 +1,59 @@
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
+#ifndef __DC_HUBP_DCN35_H__
+#define __DC_HUBP_DCN35_H__
+
+#include "dcn31/dcn31_hubp.h"
+
+#define HUBP_MASK_SH_LIST_DCN35(mask_sh)\
+	HUBP_MASK_SH_LIST_DCN31(mask_sh),\
+	HUBP_SF(HUBP0_HUBP_CLK_CNTL, HUBP_FGCG_REP_DIS, mask_sh)
+
+#define DCN35_HUBP_REG_FIELD_VARIABLE_LIST(type)          \
+	struct {                                          \
+		DCN32_HUBP_REG_FIELD_VARIABLE_LIST(type); \
+		type HUBP_FGCG_REP_DIS;                   \
+	}
+
+struct dcn35_hubp2_shift {
+	DCN35_HUBP_REG_FIELD_VARIABLE_LIST(uint8_t);
+};
+
+struct dcn35_hubp2_mask {
+	DCN35_HUBP_REG_FIELD_VARIABLE_LIST(uint32_t);
+};
+
+
+bool hubp35_construct(
+	struct dcn20_hubp *hubp2,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dcn_hubp2_registers *hubp_regs,
+	const struct dcn35_hubp2_shift *hubp_shift,
+	const struct dcn35_hubp2_mask *hubp_mask);
+
+void hubp35_set_fgcg(struct hubp *hubp, bool enable);
+
+#endif /* __DC_HUBP_DCN35_H__ */
-- 
2.41.0

