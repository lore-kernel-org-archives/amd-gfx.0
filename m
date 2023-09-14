Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4532EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C30410E4E9;
	Thu, 14 Sep 2023 02:02:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3098C10E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpZuXIVTn9aykW/YaKJLfvJeFbdb4b5ciPv37ecEy0xj3wMo3hZTBVqj/utOFC/mbk5lk42RDmlYgGcQNJ0xleRQSHQiXieDfDqv3/dkD/KBSDxVFEY9xq40Kkfc7cLAetVjWefoTw8MGgaXPvrjrJfWjl3m7CERQgdTUAv1ubLsGgRqQCaApqT3huCWTAl2DEDVbtd3P+9fv1gl2JIBB8QwS6vfGYaoV+RE7uaC0c3QYoCinepkgzMKqv8fHnixssql9Gq+QgIxAwg0mQ8YHtOC7U7xnhZFhr7lE8Q6TePS+bOFg1TuBxNiRHoQVUxlkf9OxwELhP2IhHx0nbuC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnGi92PH6vsf2wT+5kgZV/G2C0WeTkr+AWxeXXo/2fU=;
 b=LOx+/RRHxCgSQ56RlJrL+O4du5GBgwQ7CFyKjQuy634fN2SlV8sNjWFYjOrU5uhZWoiJAa4ErIswdkMkhPnr4f8MgKq7+DIJpr0YH0Lilmh8CnzgBmdkPDh8NKTaGfQvXDZgM1QHry+xWiK5pt5Fs7LKFV1Ke4qzavIFUTarhTpM2dIaVQjknY8NknYKunbGwrq+qSDHA2AdWC5Hw5FVCD/OedlUrkqSr1pQJOSWhnvkxQ86rYqabb0FzAK4YFToNtDQEF+Y1QQ2vN54Wcq9K0N7mysv5i27p6jDjD6bibuMWlCTLgAQJojdkHA1Bp7I8T0+NvKAKD/hUO/4z3ElaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnGi92PH6vsf2wT+5kgZV/G2C0WeTkr+AWxeXXo/2fU=;
 b=IeUa6CXjmIyEH0wZr1N1j3pwfWUo06kjQ+7rMAOFfUR+IISJiZzKiMEGSWarGS73GqWxtayuJnZyVX6Yi+A+SZIu2MjzGwVCWO1kXqOLb5cVooF/aWrfrfF/dNtaMqhufYOA5nkzNSB2cCHmaLfLtPzMqjdwPKePKfHwmlJZe+s=
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 02:02:18 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::89) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:02:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/28] drm/amd/display: Drop unused code
Date: Wed, 13 Sep 2023 20:00:20 -0600
Message-ID: <20230914020021.2890026-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: e50909cc-3e36-4f06-ae20-08dbb4c6a036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ierieMtujMD9xWqSQ5iYgkONo4srnEFNUIWcRXX451i5gEIQlpvJJMo14js04vTg1nPdpJ12tgmqyyTd6+jjzLoM4ouE2smmYqYU9BpM1JZlDYDAY99qhNupchg/W66+Y0lYR7pIkYNh8F+qP1QQ4Awf/1rssZFo6JCmh4lLye4O3Lu/7QbccteQ2jIiYNFVSO7RgKeOaNF0EzLqz4jYeeOGM2JA14X1ysFceSwIg6Gh4hXsGzwPwre8lSwxh+X+FgxpmKDb7tBUTG6cUY1zxhUkmMiroo0yQjQiwZvrA+lUndx/dESgNMPV8gjARvJNepvb6dEnOOIHVF02+cEyLez9hqdYLAvdzkelZnfrsj4+7A99zMOJM+jJFO47Ev3XXuZh3kebdw2CzJcv18lzwy8byS5bgDWZ7Ahr037TpSPLIFA6XrPJDDwERKUQfqQO5avfhmc3t/K/mQb6l6CqNhkPIEMmt14MeDrVTFr4/nsBjUJ6s5LAMN3Sxe/9AsoFAsFLaDhEsnmxhw2HMzAewhNLTtBaoS3jWhtJS+M2+kdx9oMWKM7gMkUmx0HGcGYFOIxSKQiua65sjar9nMtAKgalZazSSdwGVA+6aNKiaPfCJ40BTg2KoL5myDxuDb7xS14QI5wDfMPNd1+pzg0cAqoFDHUnWIpySsSgbTepV9R2WKhaszzJwkAaZPDXeDOlTD8yeAaxopnjtm9POgc56jGQ13SkhJTAgeznDnSEvGcgT51N+r1y87FeJCt8hDS2rRYjnRG0bwiHcUC3WX+5+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(186009)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(5660300002)(70206006)(41300700001)(4326008)(8676002)(8936002)(6916009)(316002)(54906003)(66899024)(70586007)(40460700003)(81166007)(478600001)(36756003)(6666004)(26005)(2616005)(2906002)(86362001)(83380400001)(1076003)(16526019)(40480700001)(426003)(336012)(47076005)(356005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:18.6894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50909cc-3e36-4f06-ae20-08dbb4c6a036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are multiple parts of the code that DC does not use anymore, and
this commit drops those dead codes.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    |  9 --
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  4 +-
 .../display/dc/link/accessories/link_fpga.c   | 95 -------------------
 .../display/dc/link/accessories/link_fpga.h   | 30 ------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  1 -
 .../drm/amd/display/dc/link/link_factory.c    |  1 -
 6 files changed, 2 insertions(+), 138 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 484d62bcf2c2..2ec496be778a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1723,15 +1723,6 @@ static void bios_parser_set_scratch_critical_state(
 	bios_set_scratch_critical_state(dcb, state);
 }
 
-struct atom_dig_transmitter_info_header_v5_3 {
-    struct atom_common_table_header table_header;
-    uint16_t dpphy_hdmi_settings_offset;
-    uint16_t dpphy_dvi_settings_offset;
-    uint16_t dpphy_dp_setting_table_offset;
-    uint16_t uniphy_xbar_settings_v2_table_offset;
-    uint16_t dpphy_internal_reg_overide_offset;
-};
-
 static enum bp_result bios_parser_get_firmware_info(
 	struct dc_bios *dcb,
 	struct dc_firmware_info *info)
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 6af8a97d4a77..84c7af5fa589 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -33,7 +33,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_LINK)
 ###############################################################################
 # accessories
 ###############################################################################
-LINK_ACCESSORIES = link_dp_trace.o link_dp_cts.o link_fpga.o
+LINK_ACCESSORIES = link_dp_trace.o link_dp_cts.o
 
 AMD_DAL_LINK_ACCESSORIES = $(addprefix $(AMDDALPATH)/dc/link/accessories/, \
 $(LINK_ACCESSORIES))
@@ -61,4 +61,4 @@ link_edp_panel_control.o link_dp_irq_handler.o link_dp_dpia_bw.o
 AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
 $(LINK_PROTOCOLS))
 
-AMD_DISPLAY_FILES += $(AMD_DAL_LINK_PROTOCOLS)
\ No newline at end of file
+AMD_DISPLAY_FILES += $(AMD_DAL_LINK_PROTOCOLS)
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
deleted file mode 100644
index d3cc604eed67..000000000000
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
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
-#include "link_fpga.h"
-#include "link/link_dpms.h"
-#include "dm_helpers.h"
-#include "link_hwss.h"
-#include "dccg.h"
-#include "resource.h"
-
-#define DC_LOGGER_INIT(logger)
-
-void dp_fpga_hpo_enable_link_and_stream(struct dc_state *state, struct pipe_ctx *pipe_ctx)
-{
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct link_mst_stream_allocation_table proposed_table = {0};
-	struct fixed31_32 avg_time_slots_per_mtp;
-	uint8_t req_slot_count = 0;
-	uint8_t vc_id = 1; /// VC ID always 1 for SST
-	struct dc_link_settings link_settings = pipe_ctx->link_config.dp_link_settings;
-	const struct link_hwss *link_hwss = get_link_hwss(stream->link, &pipe_ctx->link_res);
-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
-
-	stream->link->cur_link_settings = link_settings;
-
-	if (link_hwss->ext.enable_dp_link_output)
-		link_hwss->ext.enable_dp_link_output(stream->link, &pipe_ctx->link_res,
-				stream->signal, pipe_ctx->clock_source->id,
-				&link_settings);
-
-	/* Enable DP_STREAM_ENC */
-	dc->hwss.enable_stream(pipe_ctx);
-
-	/* Set DPS PPS SDP (AKA "info frames") */
-	if (pipe_ctx->stream->timing.flags.DSC) {
-		link_set_dsc_pps_packet(pipe_ctx, true, true);
-	}
-
-	/* Allocate Payload */
-	if ((stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) && (state->stream_count > 1)) {
-		// MST case
-		uint8_t i;
-
-		proposed_table.stream_count = state->stream_count;
-		for (i = 0; i < state->stream_count; i++) {
-			avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(state->streams[i], state->streams[i]->link);
-			req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
-			proposed_table.stream_allocations[i].slot_count = req_slot_count;
-			proposed_table.stream_allocations[i].vcp_id = i+1;
-			/* NOTE: This makes assumption that pipe_ctx index is same as stream index */
-			proposed_table.stream_allocations[i].hpo_dp_stream_enc = state->res_ctx.pipe_ctx[i].stream_res.hpo_dp_stream_enc;
-		}
-	} else {
-		// SST case
-		avg_time_slots_per_mtp = link_calculate_sst_avg_time_slots_per_mtp(stream, stream->link);
-		req_slot_count = dc_fixpt_ceil(avg_time_slots_per_mtp);
-		proposed_table.stream_count = 1; /// Always 1 stream for SST
-		proposed_table.stream_allocations[0].slot_count = req_slot_count;
-		proposed_table.stream_allocations[0].vcp_id = vc_id;
-		proposed_table.stream_allocations[0].hpo_dp_stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
-	}
-
-	link_hwss->ext.update_stream_allocation_table(stream->link,
-			&pipe_ctx->link_res,
-			&proposed_table);
-
-	if (link_hwss->ext.set_throttled_vcp_size)
-		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
-
-	dc->hwss.unblank_stream(pipe_ctx, &stream->link->cur_link_settings);
-	dc->hwss.enable_audio_stream(pipe_ctx);
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h b/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
deleted file mode 100644
index 3a80f5595943..000000000000
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
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
-#ifndef __LINK_FPGA_H__
-#define __LINK_FPGA_H__
-#include "link.h"
-void dp_fpga_hpo_enable_link_and_stream(struct dc_state *state,
-		struct pipe_ctx *pipe_ctx);
-#endif /* __LINK_FPGA_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index d8327911c467..5a4f732e1e6c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -38,7 +38,6 @@
 #include "link_dpms.h"
 #include "link_hwss.h"
 #include "link_validation.h"
-#include "accessories/link_fpga.h"
 #include "accessories/link_dp_trace.h"
 #include "protocols/link_dpcd.h"
 #include "protocols/link_ddc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e406561c2c23..754aab662489 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -33,7 +33,6 @@
 #include "link_dpms.h"
 #include "accessories/link_dp_cts.h"
 #include "accessories/link_dp_trace.h"
-#include "accessories/link_fpga.h"
 #include "protocols/link_ddc.h"
 #include "protocols/link_dp_capability.h"
 #include "protocols/link_dp_dpia_bw.h"
-- 
2.40.1

