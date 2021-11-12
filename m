Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA53A61213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA53A61213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457786EB07;
	Fri, 12 Nov 2021 00:56:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716176EB07
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsOOQR7qgMX4JYpRt3wJbzPtINsF1UsaP8ufqjs3XgKCzwwUeo12Zr2VPkPapOM+Z2ZX3+0+N8FaV0zKbDJxTe5Eo+08IFyOu864DuT4iqjxBSNY4EldlLkBCHXhUDo0wuQZOSLEDiAc1JpxE2XH/La5aKikHMcUED+cJc583s4ivkNBEQYOAUWHp0Qj/my6YCAsJG5FWjNbu78Oi5v4KN+qe27WRAyyYlwJh2oYScQmGvNE6vyROpxn0gql1O6sKNfAleJOC/vzxaVRtY8U5w8JeJidRR6akd9vARk38Au+XFOfCb+9qD+Sd8qKGDjtcEPN8O12vD3vT96CGyihow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rthKLgveYvSkJv+RgRIe2vf+b05N2wkHpUCKyUuhwXg=;
 b=VXMrO0KbtT3wRanfoossj3SBnRUzbU5VIHLBmRWdcaqY8GaNLQjED1S6j43iPpYIxSYdPxkfvqAeO5J5PjHIi73B1HMiCD/Fefa4b9GI2tQ6RX/iPna7X5T6jeGdxLbV8Ag7Vsj/WjtJoy4RZveMZ0lrgcsH3TIAn8wGY9u7CHgtjW+cNY4j7X60mAHt2i65Xr4XuP6W8k93FnDaqzd2iS1YudKAlw+Qpd8FXN4xZjIVXSxjZTHHWOxCufMVplZEOlrtpNAIARLQFYPV4hqFKmyQusv0510e/Nr4O7cGMym6f49ezkENa70hRaIN5M10qvUJq56AdRH8pQBEzg2QhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rthKLgveYvSkJv+RgRIe2vf+b05N2wkHpUCKyUuhwXg=;
 b=vAl/SXmLphrccjynzgtHiKjLZROX8KNN/sNo+9VV7fGCgayrA3BsI1PdtoVCn0CrR2kaM06W4vNc0MUVihlMBa0EMFEp4KhL9LBUDc9sFbFXwLhbuDIdH/w8jhUFZHilnZuQdXcWao8Kutdt4ucOGF+gGcVGYe0r98aYyegQC3A=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 00:55:56 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::86) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:53 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:50 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: fixed the DSC power off sequence
 during Driver PnP
Date: Fri, 12 Nov 2021 08:54:36 +0800
Message-ID: <20211112005438.5505-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 525a13d0-ebcd-45f1-d8f4-08d9a5772ed8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382337A6C7B39E4AABC5CCFFC959@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yACD1NQdzXKwWGOaS1zjUSX/p8Rn/KiIwzLfrP+B3ymBDKP8K+PbNX9QT308GcB1kzHfWKPoleII5jTPJaOuHvGA91mZOTatU+Uz3h+nqcxobwzVfYywGivxOTDFUHpEg7ek+3Iz/fki0GIs4iZvV9n+wJRRnL6aPV1mFTFxFz1IbdrdPHwz8GQ4RiohhE7FOqmsP0qHce7dEe5jz8bCoCpwH9y42JB8MWEzP+50VSpA6HIJidpHaUaOzsGkLHKpxC5CTVi5fLI2R4FdpIUmVbbM5FTkiC6gL5X3oE+ETzkp8GkmZY0vLdSvcrbDoVmQFzgFdQerR700gNu8R+8VlWc84gLM8r8Wmt5cWLha1aglivsnD/uKrPpu4OKR/f0lJaekRYO17BC7/i8LVEHNhsNI9eLSM3r82BpyPcD4wfWbU7oQTA43dagYCDPRXFiBqs1avVqzAKA8GsiWd04mjlRgf3z6QlyBSdRRbO0z6qCMPZ6BvA+uXjLa5CR2MszS9ct541OwA1jXivOTNI+oDuhlaewapnmQ/3xr1cf8oeFCT5clYGA/VbfUltzpOP2X9zAxh68qhwMVoNzTBhlSPz13eIJbasE+ZpdwYEVLLJxbZz+QNbkt//o8j7+pyloAqXNkYQxHXa+O3K4EavdU+Yvhx9eTRa5ASnQi034i/FSqfgCwhnq5M3pZcGDM2LeaDWAmx7WbfmwzPM0yQoGBB1/b7aT7pmsQ7BeTIIh/3eI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(7696005)(8936002)(508600001)(2616005)(1076003)(316002)(83380400001)(4326008)(36756003)(336012)(426003)(81166007)(8676002)(6666004)(186003)(47076005)(6916009)(86362001)(5660300002)(70206006)(70586007)(54906003)(26005)(2906002)(36860700001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:55.3561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525a13d0-ebcd-45f1-d8f4-08d9a5772ed8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Yi-Ling Chen <Yi-Ling.Chen2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>

[WHY]
After unloading driver, driver would not disable DSC function.
At next loading driver, driver would power all DSC engines off.
When driver powered the active DSC off, the screen would be gray
until reprograming DSC relatived register correcntly.

[HOW]
1. Remove DSC Power down code into init_pipes()
2. Depend on  the OTG mapping information and DSC status to skip
power off for the working DSC.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 37 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 14 +++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |  3 ++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  5 ---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  2 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 9 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 135e2b58cc73..c50427bfab77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1362,6 +1362,43 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 		tg->funcs->tg_init(tg);
 	}
+
+	/* Power gate DSCs */
+	if (hws->funcs.dsc_pg_control != NULL) {
+		uint32_t num_opps = 0;
+		uint32_t opp_id_src0 = OPP_ID_INVALID;
+		uint32_t opp_id_src1 = OPP_ID_INVALID;
+
+		// Step 1: To find out which OPTC is running & OPTC DSC is ON
+		for (i = 0; i < dc->res_pool->res_cap->num_timing_generator; i++) {
+			uint32_t optc_dsc_state = 0;
+			struct timing_generator *tg = dc->res_pool->timing_generators[i];
+
+			if (tg->funcs->is_tg_enabled(tg)) {
+				if (tg->funcs->get_dsc_status)
+					tg->funcs->get_dsc_status(tg, &optc_dsc_state);
+				// Only one OPTC with DSC is ON, so if we got one result, we would exit this block.
+				// non-zero value is DSC enabled
+				if (optc_dsc_state != 0) {
+					tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+					break;
+				}
+			}
+		}
+
+		// Step 2: To power down DSC but skip DSC  of running OPTC
+		for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+			struct dcn_dsc_state s  = {0};
+
+			dc->res_pool->dscs[i]->funcs->dsc_read_state(dc->res_pool->dscs[i], &s);
+
+			if ((s.dsc_opp_source == opp_id_src0 || s.dsc_opp_source == opp_id_src1) &&
+				s.dsc_clock_en && s.dsc_fw_en)
+				continue;
+
+			hws->funcs.dsc_pg_control(hws, dc->res_pool->dscs[i]->inst, false);
+		}
+	}
 }
 
 void dcn10_init_hw(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 79b640e202eb..ef5c4c0f4d6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -162,6 +162,8 @@ static void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_ds
 	REG_GET(DSCC_PPS_CONFIG2, PIC_WIDTH, &s->dsc_pic_width);
 	REG_GET(DSCC_PPS_CONFIG2, PIC_HEIGHT, &s->dsc_pic_height);
 	REG_GET(DSCC_PPS_CONFIG7, SLICE_BPG_OFFSET, &s->dsc_slice_bpg_offset);
+	REG_GET_2(DSCRM_DSC_FORWARD_CONFIG, DSCRM_DSC_FORWARD_EN, &s->dsc_fw_en,
+		DSCRM_DSC_OPP_PIPE_SOURCE, &s->dsc_opp_source);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index c90b8516dcc1..8c34751b0e58 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -190,6 +190,19 @@ void optc2_set_dsc_config(struct timing_generator *optc,
 		OPTC_DSC_SLICE_WIDTH, dsc_slice_width);
 }
 
+/* Get DSC-related configuration.
+ *   dsc_mode: 0 disables DSC, other values enable DSC in specified format
+ */
+void optc2_get_dsc_status(struct timing_generator *optc,
+					uint32_t *dsc_mode)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_GET(OPTC_DATA_FORMAT_CONTROL,
+		OPTC_DSC_MODE, dsc_mode);
+}
+
+
 /*TEMP: Need to figure out inheritance model here.*/
 bool optc2_is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 {
@@ -579,6 +592,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.get_crc = optc1_get_crc,
 		.configure_crc = optc2_configure_crc,
 		.set_dsc_config = optc2_set_dsc_config,
+		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = optc2_set_dwb_source,
 		.set_odm_bypass = optc2_set_odm_bypass,
 		.set_odm_combine = optc2_set_odm_combine,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
index be19a6885fbf..f7968b9ca16e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
@@ -98,6 +98,9 @@ void optc2_set_dsc_config(struct timing_generator *optc,
 					uint32_t dsc_bytes_per_pixel,
 					uint32_t dsc_slice_width);
 
+void optc2_get_dsc_status(struct timing_generator *optc,
+					uint32_t *dsc_mode);
+
 void optc2_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 5d9e6413d67a..f5e8916601d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -332,6 +332,7 @@ static struct timing_generator_funcs dcn30_tg_funcs = {
 		.get_crc = optc1_get_crc,
 		.configure_crc = optc2_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
+		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
 		.set_odm_bypass = optc3_set_odm_bypass,
 		.set_odm_combine = optc3_set_odm_combine,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index bdaeb6ebdacb..a668feff30b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -192,11 +192,6 @@ void dcn31_init_hw(struct dc *dc)
 			link->link_status.link_active = true;
 	}
 
-	/* Power gate DSCs */
-	for (i = 0; i < res_pool->res_cap->num_dsc; i++)
-		if (hws->funcs.dsc_pg_control != NULL)
-			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
-
 	/* Enables outbox notifications for usb4 dpia */
 	if (dc->res_pool->usb4_dpia_count)
 		dmub_enable_outbox_notification(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index a4b1d98f0007..e8562fa11366 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -256,6 +256,7 @@ static struct timing_generator_funcs dcn31_tg_funcs = {
 		.get_crc = optc1_get_crc,
 		.configure_crc = optc2_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
+		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
 		.set_odm_bypass = optc3_set_odm_bypass,
 		.set_odm_combine = optc31_set_odm_combine,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index 0c83e79d3ce3..346f0ba73e86 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -61,6 +61,8 @@ struct dcn_dsc_state {
 	uint32_t dsc_pic_height;
 	uint32_t dsc_slice_bpg_offset;
 	uint32_t dsc_chunk_size;
+	uint32_t dsc_fw_en;
+	uint32_t dsc_opp_source;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 7390baf916b5..c29320b3855d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -290,6 +290,8 @@ struct timing_generator_funcs {
 			       enum optc_dsc_mode dsc_mode,
 			       uint32_t dsc_bytes_per_pixel,
 			       uint32_t dsc_slice_width);
+	void (*get_dsc_status)(struct timing_generator *optc,
+					uint32_t *dsc_mode);
 	void (*set_odm_bypass)(struct timing_generator *optc, const struct dc_crtc_timing *dc_crtc_timing);
 	void (*set_odm_combine)(struct timing_generator *optc, int *opp_id, int opp_cnt,
 			struct dc_crtc_timing *timing);
-- 
2.25.1

