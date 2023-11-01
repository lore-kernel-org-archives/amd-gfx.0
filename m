Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76066C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053BE10E77C;
	Wed,  1 Nov 2023 20:09:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFA910E77C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXhS4KsOcSQA97ls4JahcCWq33cvOY2YEWxiOTUNl2o9M4Bq0plKBTf7uMmkf0G10F/AEsp97EArkgILRaFRip2cyVRrUh9Vn+gJfD7AaUGdPFjw8pKfHC58KJyR7IGsX3JGzfCYuhvL5+fIcvsp37RmlBYk3mY6wKoMG9WiedtTi1IC9z1ni5SbuKQWa9ATYhczxEeB9vPK8KjfbUaN2e2AbfqVFG6u7Us3rFfD35UHQ4pLm0C1T83ann7qr4Ak0VTHCAmeLiH/ell5zTgPTftX1g81zmW73M84pgfIRtPapP8F7UpKqkhQyXx5A3JG0Hc3wWO0pDovZ4LOcZb1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRIfsNucv8xOb40Ftsd15DNPn14szdT7d7f7LINrWrQ=;
 b=mJ3Zr8zJF/YhWG+3YSfWkJUC4qZsuVSU1L3EYh/m1KliA8HVTZJasreCesX3rt2GImAEMN6jAioKMUkmhdnTzL5svcAx8zwhze4geiurH+egJAinWupmOv1Nw7BpopYTlEkYbsBD9KbI2CFiedI73WR9VtsLC5okgAlj4I6K5yKdXSe0pGcyk7rGMVarJmxZfOQQXQxkFDHPPPy1jbZMAi3gZcO2dY2IrwvDCDPCAIEvxAe7RorOWrIttkE63bgf0tmsHIaIbrdMs7le+4WmOxFIbL816y4+qMv/ns9kd6ayN3N7PLQ0uww7HQOr/ozeibI1jkx547lxTn04i4vBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRIfsNucv8xOb40Ftsd15DNPn14szdT7d7f7LINrWrQ=;
 b=nr7EopUcSK4LxYE2WwfdwOufl815Bu5cl9VhhTdBf/uEbMdcyXT+9uJd/cx4epPbNBM3FzAy7WfM3Md0I1QRx6p2FBDiEd46VAQdnOIGg3wutMsl9KzH9/FUj5mGNoDSjHSzDr5ILf32kUMJaHau/aLLm/2UKOq5Mvg9PsUMmOs=
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 20:08:55 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a4) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:52 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:46 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: Create optc.h file
Date: Wed, 1 Nov 2023 16:08:24 -0400
Message-ID: <20231101200832.995436-5-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b057a85-c9e0-4452-d7ac-08dbdb16606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tki+7zmJdxva7FV0ykpDWXVfU8H9Q8yxdRLR9or/oD79Sx2RkVZTRMd2JhM4XlFlny6jGrzLxk+k7ux6SnZfJ4Y8VSttb43IgWxdumD/9g7spqHNeS/hkav5CJA6iYXFtrR2UcrNsHQwvaulOYAXAf2WA/SKmIFKGYk0EzKedoxdtUdOwVnpfhrtw2V3whhvp2Q1CMBCy5D5Pshv8rVU/uL4HqShMWff/aYfD+dE1qCPsyTlIxfoWARIQU6FiVNS7xTpKDhAFuFjZkgCRDGRLF6kkty1Z/v5lnwYbltYt6cQ2GE7Dn3uj9QNOXUahFUgpwaevzQoV3uMkhnV2EUwMQAeWaTfVs2wHh/5tOU2SExTnH+5YV4EjhgpEiGu/3c2s3IWD/R4/fz+rvCi/Vc7aWcfFWJ7MIKUZv178boS3KguKFN/GPxTAuRys7FIgUL95FXrtzup3zr4KvpqUg/rOUmD2dM1LXi/lKlhcBVpnkRmW1fDS4gTFkdXEZv613jTcm1rPNN2dTgJ9xFqWmZOYmpjKVzpGR6EbZAln09tFakpPKygIcmKM0zU2xgPTF/R4wXCWAksVl4Q4kpRI3KV7JJ9sVNfz1fnHEJA8fQuc1pSD89kuNhl9m4sS0dDoPrDEpEClXVE9ivAX2Du/kp+cqHihuuWV6Wj8f8J7FxbWkZiDCPZRyvcLmjiJKmYKgCEb2bzSSXlOLt/FfBgCc+T5pqmjCgmEy58zVAdSq3Wnph8/IL3VU+RSSwmNJ7i8VjJ6edBIeCFO5qkpyEv6KduRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(1076003)(86362001)(36756003)(82740400003)(40480700001)(66899024)(41300700001)(7696005)(8676002)(4326008)(8936002)(30864003)(6666004)(2906002)(83380400001)(47076005)(26005)(2616005)(478600001)(40460700003)(316002)(70206006)(6916009)(54906003)(70586007)(81166007)(5660300002)(356005)(336012)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:55.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b057a85-c9e0-4452-d7ac-08dbdb16606d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

For all the components that participate in DCN architecture, there is a
header in the dc/inch/hw. For some reason, OPTC broke this pattern and
added all the primary functions/structs associated with that in the
dcn10_optc.h file. For consistency's sake, this commit introduces a new
optc.h file and extracts the code from dcn10_optc to this new file.

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 186 +--------------
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  | 219 ++++++++++++++++++
 3 files changed, 221 insertions(+), 186 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
index 0f580ea37576..133af994a08c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
@@ -37,7 +37,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_atomic.h>
-#include "dcn10/dcn10_optc.h"
+#include "dc/inc/hw/optc.h"
 
 #include "dc/inc/core_types.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index aaf6c981fd9e..ab81594a7fad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -26,7 +26,7 @@
 #ifndef __DC_TIMING_GENERATOR_DCN10_H__
 #define __DC_TIMING_GENERATOR_DCN10_H__
 
-#include "timing_generator.h"
+#include "optc.h"
 
 #define DCN10TG_FROM_TG(tg)\
 	container_of(tg, struct optc, base)
@@ -594,190 +594,6 @@ struct dcn_optc_mask {
 	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
 };
 
-struct optc {
-	struct timing_generator base;
-
-	const struct dcn_optc_registers *tg_regs;
-	const struct dcn_optc_shift *tg_shift;
-	const struct dcn_optc_mask *tg_mask;
-
-	int opp_count;
-
-	uint32_t max_h_total;
-	uint32_t max_v_total;
-
-	uint32_t min_h_blank;
-
-	uint32_t min_h_sync_width;
-	uint32_t min_v_sync_width;
-	uint32_t min_v_blank;
-	uint32_t min_v_blank_interlace;
-
-	int vstartup_start;
-	int vupdate_offset;
-	int vupdate_width;
-	int vready_offset;
-	struct dc_crtc_timing orginal_patched_timing;
-	enum signal_type signal;
-};
-
 void dcn10_timing_generator_init(struct optc *optc);
 
-struct dcn_otg_state {
-	uint32_t v_blank_start;
-	uint32_t v_blank_end;
-	uint32_t v_sync_a_pol;
-	uint32_t v_total;
-	uint32_t v_total_max;
-	uint32_t v_total_min;
-	uint32_t v_total_min_sel;
-	uint32_t v_total_max_sel;
-	uint32_t v_sync_a_start;
-	uint32_t v_sync_a_end;
-	uint32_t h_blank_start;
-	uint32_t h_blank_end;
-	uint32_t h_sync_a_start;
-	uint32_t h_sync_a_end;
-	uint32_t h_sync_a_pol;
-	uint32_t h_total;
-	uint32_t underflow_occurred_status;
-	uint32_t otg_enabled;
-	uint32_t blank_enabled;
-	uint32_t vertical_interrupt1_en;
-	uint32_t vertical_interrupt1_line;
-	uint32_t vertical_interrupt2_en;
-	uint32_t vertical_interrupt2_line;
-};
-
-void optc1_read_otg_state(struct optc *optc1,
-		struct dcn_otg_state *s);
-
-bool optc1_get_hw_timing(struct timing_generator *tg,
-		struct dc_crtc_timing *hw_crtc_timing);
-
-bool optc1_validate_timing(
-	struct timing_generator *optc,
-	const struct dc_crtc_timing *timing);
-
-void optc1_program_timing(
-	struct timing_generator *optc,
-	const struct dc_crtc_timing *dc_crtc_timing,
-	int vready_offset,
-	int vstartup_start,
-	int vupdate_offset,
-	int vupdate_width,
-	const enum signal_type signal,
-	bool use_vbios);
-
-void optc1_setup_vertical_interrupt0(
-		struct timing_generator *optc,
-		uint32_t start_line,
-		uint32_t end_line);
-void optc1_setup_vertical_interrupt1(
-		struct timing_generator *optc,
-		uint32_t start_line);
-void optc1_setup_vertical_interrupt2(
-		struct timing_generator *optc,
-		uint32_t start_line);
-
-void optc1_program_global_sync(
-		struct timing_generator *optc,
-		int vready_offset,
-		int vstartup_start,
-		int vupdate_offset,
-		int vupdate_width);
-
-bool optc1_disable_crtc(struct timing_generator *optc);
-
-bool optc1_is_counter_moving(struct timing_generator *optc);
-
-void optc1_get_position(struct timing_generator *optc,
-		struct crtc_position *position);
-
-uint32_t optc1_get_vblank_counter(struct timing_generator *optc);
-
-void optc1_get_crtc_scanoutpos(
-	struct timing_generator *optc,
-	uint32_t *v_blank_start,
-	uint32_t *v_blank_end,
-	uint32_t *h_position,
-	uint32_t *v_position);
-
-void optc1_set_early_control(
-	struct timing_generator *optc,
-	uint32_t early_cntl);
-
-void optc1_wait_for_state(struct timing_generator *optc,
-		enum crtc_state state);
-
-void optc1_set_blank(struct timing_generator *optc,
-		bool enable_blanking);
-
-bool optc1_is_blanked(struct timing_generator *optc);
-
-void optc1_program_blank_color(
-		struct timing_generator *optc,
-		const struct tg_color *black_color);
-
-bool optc1_did_triggered_reset_occur(
-	struct timing_generator *optc);
-
-void optc1_enable_reset_trigger(struct timing_generator *optc, int source_tg_inst);
-
-void optc1_disable_reset_trigger(struct timing_generator *optc);
-
-void optc1_lock(struct timing_generator *optc);
-
-void optc1_unlock(struct timing_generator *optc);
-
-void optc1_enable_optc_clock(struct timing_generator *optc, bool enable);
-
-void optc1_set_drr(
-	struct timing_generator *optc,
-	const struct drr_params *params);
-
-void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
-
-void optc1_set_static_screen_control(
-	struct timing_generator *optc,
-	uint32_t event_triggers,
-	uint32_t num_frames);
-
-void optc1_program_stereo(struct timing_generator *optc,
-	const struct dc_crtc_timing *timing, struct crtc_stereo_flags *flags);
-
-bool optc1_is_stereo_left_eye(struct timing_generator *optc);
-
-void optc1_clear_optc_underflow(struct timing_generator *optc);
-
-void optc1_tg_init(struct timing_generator *optc);
-
-bool optc1_is_tg_enabled(struct timing_generator *optc);
-
-bool optc1_is_optc_underflow_occurred(struct timing_generator *optc);
-
-void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enable);
-
-void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable);
-
-bool optc1_get_otg_active_size(struct timing_generator *optc,
-		uint32_t *otg_active_width,
-		uint32_t *otg_active_height);
-
-void optc1_enable_crtc_reset(
-		struct timing_generator *optc,
-		int source_tg_inst,
-		struct crtc_trigger_info *crtc_tp);
-
-bool optc1_configure_crc(struct timing_generator *optc,
-			  const struct crc_params *params);
-
-bool optc1_get_crc(struct timing_generator *optc,
-		    uint32_t *r_cr, uint32_t *g_y, uint32_t *b_cb);
-
-bool optc1_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
-
-void optc1_set_vtg_params(struct timing_generator *optc,
-		const struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
-
 #endif /* __DC_TIMING_GENERATOR_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
new file mode 100644
index 000000000000..9a8bf6ec70ea
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
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
+ * Authors: AMD
+ *
+ */
+
+/**
+ * DOC: overview
+ *
+ * Output Pipe Timing Combiner (OPTC) includes two major functional blocks:
+ * Output Data Mapper (ODM) and Output Timing Generator (OTG).
+ *
+ * - ODM: It is Output Data Mapping block. It can combine input data from
+ *   multiple OPP data pipes into one single data stream or split data from one
+ *   OPP data pipe into multiple data streams or just bypass OPP data to DIO.
+ * - OTG: It is Output Timing Generator. It generates display timing signals to
+ *   drive the display output.
+ */
+
+#ifndef __DC_OPTC_H__
+#define __DC_OPTC_H__
+
+#include "timing_generator.h"
+
+struct optc {
+	struct timing_generator base;
+
+	const struct dcn_optc_registers *tg_regs;
+	const struct dcn_optc_shift *tg_shift;
+	const struct dcn_optc_mask *tg_mask;
+
+	int opp_count;
+
+	uint32_t max_h_total;
+	uint32_t max_v_total;
+
+	uint32_t min_h_blank;
+
+	uint32_t min_h_sync_width;
+	uint32_t min_v_sync_width;
+	uint32_t min_v_blank;
+	uint32_t min_v_blank_interlace;
+
+	int vstartup_start;
+	int vupdate_offset;
+	int vupdate_width;
+	int vready_offset;
+	struct dc_crtc_timing orginal_patched_timing;
+	enum signal_type signal;
+};
+
+struct dcn_otg_state {
+	uint32_t v_blank_start;
+	uint32_t v_blank_end;
+	uint32_t v_sync_a_pol;
+	uint32_t v_total;
+	uint32_t v_total_max;
+	uint32_t v_total_min;
+	uint32_t v_total_min_sel;
+	uint32_t v_total_max_sel;
+	uint32_t v_sync_a_start;
+	uint32_t v_sync_a_end;
+	uint32_t h_blank_start;
+	uint32_t h_blank_end;
+	uint32_t h_sync_a_start;
+	uint32_t h_sync_a_end;
+	uint32_t h_sync_a_pol;
+	uint32_t h_total;
+	uint32_t underflow_occurred_status;
+	uint32_t otg_enabled;
+	uint32_t blank_enabled;
+	uint32_t vertical_interrupt1_en;
+	uint32_t vertical_interrupt1_line;
+	uint32_t vertical_interrupt2_en;
+	uint32_t vertical_interrupt2_line;
+};
+
+void optc1_read_otg_state(struct optc *optc1, struct dcn_otg_state *s);
+
+bool optc1_get_hw_timing(struct timing_generator *tg, struct dc_crtc_timing *hw_crtc_timing);
+
+bool optc1_validate_timing(struct timing_generator *optc,
+			   const struct dc_crtc_timing *timing);
+
+void optc1_program_timing(struct timing_generator *optc,
+			  const struct dc_crtc_timing *dc_crtc_timing,
+			  int vready_offset,
+			  int vstartup_start,
+			  int vupdate_offset,
+			  int vupdate_width,
+			  const enum signal_type signal,
+			  bool use_vbios);
+
+void optc1_setup_vertical_interrupt0(struct timing_generator *optc,
+				     uint32_t start_line,
+				     uint32_t end_line);
+
+void optc1_setup_vertical_interrupt1(struct timing_generator *optc,
+				     uint32_t start_line);
+
+void optc1_setup_vertical_interrupt2(struct timing_generator *optc,
+				     uint32_t start_line);
+
+void optc1_program_global_sync(struct timing_generator *optc,
+			       int vready_offset,
+			       int vstartup_start,
+			       int vupdate_offset,
+			       int vupdate_width);
+
+bool optc1_disable_crtc(struct timing_generator *optc);
+
+bool optc1_is_counter_moving(struct timing_generator *optc);
+
+void optc1_get_position(struct timing_generator *optc,
+			struct crtc_position *position);
+
+uint32_t optc1_get_vblank_counter(struct timing_generator *optc);
+
+void optc1_get_crtc_scanoutpos(struct timing_generator *optc,
+			       uint32_t *v_blank_start,
+			       uint32_t *v_blank_end,
+			       uint32_t *h_position,
+			       uint32_t *v_position);
+
+void optc1_set_early_control(struct timing_generator *optc,
+			     uint32_t early_cntl);
+
+void optc1_wait_for_state(struct timing_generator *optc,
+			  enum crtc_state state);
+
+void optc1_set_blank(struct timing_generator *optc,
+		     bool enable_blanking);
+
+bool optc1_is_blanked(struct timing_generator *optc);
+
+void optc1_program_blank_color(struct timing_generator *optc,
+			       const struct tg_color *black_color);
+
+bool optc1_did_triggered_reset_occur(struct timing_generator *optc);
+
+void optc1_enable_reset_trigger(struct timing_generator *optc, int source_tg_inst);
+
+void optc1_disable_reset_trigger(struct timing_generator *optc);
+
+void optc1_lock(struct timing_generator *optc);
+
+void optc1_unlock(struct timing_generator *optc);
+
+void optc1_enable_optc_clock(struct timing_generator *optc, bool enable);
+
+void optc1_set_drr(struct timing_generator *optc,
+		   const struct drr_params *params);
+
+void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
+
+void optc1_set_static_screen_control(struct timing_generator *optc,
+				     uint32_t event_triggers,
+				     uint32_t num_frames);
+
+void optc1_program_stereo(struct timing_generator *optc,
+			  const struct dc_crtc_timing *timing,
+			  struct crtc_stereo_flags *flags);
+
+bool optc1_is_stereo_left_eye(struct timing_generator *optc);
+
+void optc1_clear_optc_underflow(struct timing_generator *optc);
+
+void optc1_tg_init(struct timing_generator *optc);
+
+bool optc1_is_tg_enabled(struct timing_generator *optc);
+
+bool optc1_is_optc_underflow_occurred(struct timing_generator *optc);
+
+void optc1_set_blank_data_double_buffer(struct timing_generator *optc, bool enable);
+
+void optc1_set_timing_double_buffer(struct timing_generator *optc, bool enable);
+
+bool optc1_get_otg_active_size(struct timing_generator *optc,
+			       uint32_t *otg_active_width,
+			       uint32_t *otg_active_height);
+
+void optc1_enable_crtc_reset(struct timing_generator *optc,
+			     int source_tg_inst,
+			     struct crtc_trigger_info *crtc_tp);
+
+bool optc1_configure_crc(struct timing_generator *optc, const struct crc_params *params);
+
+bool optc1_get_crc(struct timing_generator *optc,
+		   uint32_t *r_cr,
+		   uint32_t *g_y,
+		   uint32_t *b_cb);
+
+bool optc1_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
+
+void optc1_set_vtg_params(struct timing_generator *optc,
+			  const struct dc_crtc_timing *dc_crtc_timing,
+			  bool program_fp2);
+
+#endif
-- 
2.25.1

