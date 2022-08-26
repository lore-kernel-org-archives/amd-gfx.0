Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0FEECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7508E10EB49;
	Sat, 27 Aug 2022 02:27:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BAA10EB49
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh6FeJG0AuE+LI22umcwOWSmnkScQQxV1k5s9yfSG+PO0UZX/1TWtSG9Xo8dgyTk9n19OcDbjuZ4qbTdKbQO6n4r+fCBJTVKhOsE++U8A7lAF9dJ7RofNLLIfaBctn500LqfehGZWrQ3Dl4sZl7TMuOtdvWjNpw2VHkLc4ooP8d5V8N1ovLubqXVbGyr6G9RAnKuPXOLknVfAmn5M2kkK6roz/wSePmTVH49msPNLV2Et05+ogWOB2QHnudeccnDuVc+xg79VdrV12QrUIHARGqjOcSQRyUcA5Bi40vyr/PNbxlOGVPeLrtSlaLsZjDbtS915vL6AkXWMuRPNhWSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdA0v2m8dnQ5VuuuwbzQQemGFwm4B2amfkDg0ZVo3d4=;
 b=gGHEdfUx56QASlPOvKqOhvWmKDJyAearYqs/vyu2Eri+szEC0X6hbRa/ILhOz9bkYzLubOHEsYHuRtCNhQDRvAkbDgb9uKIg3VOBzIbpz/jNn8M5PM9CLtOv63W2/r0e9eIIjAvU4NGxwZtIAAcMfEY2QM6z63uH7mMUuhFzzheYZTXP/LmsfR4AStojL6chW001hZtkW3F74Zii0ht7xyEbG1Iy0j6fpGSRadIliSUolA72MyhsJpgaMCJt5oxuOi4nrpkFcGUtbCZhmXK0fwoSZBHWSwPp28esLvTDYAdHVp0zhoqNDg/+K3Rswv9YokF7O9tjkvzOZ4rLfRIzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdA0v2m8dnQ5VuuuwbzQQemGFwm4B2amfkDg0ZVo3d4=;
 b=wmtJ60bSwXPrfzwCOcSgE2iEFGPmKwSLVDE5Tozm+q8nVitVSsKHF39qGKQNHov2NZZ4Io0XxmwZbw8kO47jmFWrft9l7P3Pe86FTLXGdSL/GpfXHQge1l0mgHE7LbkY5td5iYcOzAdovPj4FQ2z07UW5+LURmm++uKQsp1KYMY=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:27:16 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::81) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:01 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:58
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: add dcn35 basic support
Date: Sat, 27 Aug 2022 06:26:55 +0800
Message-ID: <20220826222722.1428063-7-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bfe6472-5aa6-4468-138f-08da87d3a8cd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 328yhXnPz9WmdP3g6HkizrO9IOhkTe7LbC+sGeXtVpgF10Ehf1C/zRM/6fuMpa7m4XGFulCOWJJhyEqMZvk08kdPuh+uyYR6eCm+u2BD1YqfgJL2k2gN/1WD3I7T+a5UbEFIvjW0wkTmnvBnsDkEPm4/rTlHh+bBgsmL4uapbFhFkP3VFEGq9PG3b7hBD1/OP0RapIiVcnN+Z/B8IcyXA3r+K7jos2h7AgJZ2sPTF6RRfIE1vlktTKVQD7CuTz51qUxeOPwm/vAQygUyUDxfEhjUAlalltXTMY/wIPjTOCp8Hg7wGMA3AJtva1dM1LJY+3jCGZd2sl+2zrPod9T7MsH4B/4QJ2OHJWb50YTWEuN9CMPlXEQ8CEkry1vdiOueA3Xkm+fb1050jXFgsEaOpytuNbNos2T3GJbm1pK0QSLFIOIQ35mn26Bfc2R97c8S/VIt+gOuSMN3t+HY5HCa1BDV8c/p2P+CgkPcxo043VUQM8Xq90wgg3Cet0fVAENL1F5TmFYXW0iCu7BxIlWr6nyau+zSJMAeO7VGlMO3S8oHDBdF3BkSYTSpAP4cY1msFEbwg5fw+nUwi1BGjyDVvo+vgsGyNeMWlMAHh9VtTVJ3bj/F0sYICjV2NVb0VG6TO/yMob1kGGC1jaTtQ4UaP6EK/9Kv9ZurBkgMvluJDPRo7HkrDanzO3NuKxduEh6vbqFarfjFWEXxsYF5fKn1xUHNJjq0OA/EtdbClj2TNbSKVMQ8AjmoPFWVrREx+6ZNM0AUWxX9kV49xtrf5pGUszDWBk4P90qt+fq5LS5VweLZj9tRUGznaCfV4PD1ge8P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(40470700004)(46966006)(47076005)(336012)(82310400005)(1076003)(2616005)(186003)(426003)(4326008)(8676002)(5660300002)(6666004)(478600001)(26005)(40480700001)(41300700001)(7696005)(36756003)(81166007)(356005)(40460700003)(82740400003)(86362001)(83380400001)(36860700001)(6916009)(70586007)(316002)(70206006)(8936002)(2906002)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:16.5426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfe6472-5aa6-4468-138f-08da87d3a8cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
this is to add new dcn frame work

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile.rej | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h    |  9 ++++++---
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h    |  3 ++-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h        | 10 ++++++++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  3 ++-
 drivers/gpu/drm/amd/display/include/dal_types.h |  1 +
 7 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej
new file mode 100644
index 000000000000..bfbfd67a7451
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej
@@ -0,0 +1,17 @@
+diff a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile	(rejected hunks)
+@@ -160,6 +160,15 @@ AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DC
+ 
+ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN32)
+ 
++
++###############################################################################
++# DCN35
++###############################################################################
++CLK_MGR_DCN35 = dcn35_smu.o dcn35_clk_mgr.o
++
++AMD_DAL_CLK_MGR_DCN35 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn35/,$(CLK_MGR_DCN35))
++
++AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN35)
+ ###############################################################################
+ # DCN3AG
+ ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index e6c06325742a..a3c27cbb77c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -183,8 +183,7 @@
 	ABM_SF(DC_ABM1_HGLS_REG_READ_PROGRESS, \
 			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, mask_sh)
 
-#define ABM_MASK_SH_LIST_DCN10(mask_sh) \
-	ABM_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh), \
+#define ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh) \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
 			ABM1_HG_NUM_OF_BINS_SEL, mask_sh), \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
@@ -214,9 +213,13 @@
 	ABM_SF(ABM0_DC_ABM1_HGLS_REG_READ_PROGRESS, \
 			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, mask_sh)
 
-#define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
+#define ABM_MASK_SH_LIST_DCN10(mask_sh) \
+	ABM_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh), \
+	ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh)
 
+#define ABM_MASK_SH_LIST_DCN20(mask_sh) ABM_MASK_SH_LIST_DCE110(mask_sh)
 #define ABM_MASK_SH_LIST_DCN30(mask_sh) ABM_MASK_SH_LIST_DCN10(mask_sh)
+#define ABM_MASK_SH_LIST_DCN35(mask_sh) ABM_MASK_SH_LIST_DCN10_COMMON(mask_sh)
 
 #define ABM_MASK_SH_LIST_DCN32(mask_sh) \
 	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 9d5e2a7848dd..3f9582b4cc79 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -188,6 +188,7 @@ struct dcn10_stream_enc_registers {
 	uint32_t HDMI_GENERIC_PACKET_CONTROL10;
 	uint32_t DIG_CLOCK_PATTERN;
 	uint32_t DIG_FIFO_CTRL0;
+	uint32_t DIG_FE_CLK_CNTL;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 6263408d71fc..815169e08e5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -172,7 +172,8 @@
 	SRI(CM_BLNDGAM_RAMB_START_SLOPE_CNTL_R, CM, id),\
 	SRI(CM_BLNDGAM_LUT_CONTROL, CM, id)
 
-
+#define DPP_REG_LIST_DCN35(id)\
+	DPP_REG_LIST_DCN30_COMMON(id)
 
 #define DPP_REG_LIST_SH_MASK_DCN30_COMMON(mask_sh)\
 	TF_SF(CM0_CM_MEM_PWR_STATUS, GAMCOR_MEM_PWR_STATE, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
index e324e9b83136..51f5781325e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
@@ -104,7 +104,10 @@ struct dcn31_hpo_dp_link_encoder_registers {
 	uint32_t RDPCSTX_PHY_CNTL6[5];
 };
 
-#define DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(mask_sh)\
+#define DCN3_1_HPO_DP_LINK_ENC_RDPCSTX_MASK_SH_LIST(mask_sh)\
+	SE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh)
+
+#define DCN3_1_HPO_DP_LINK_ENC_COMMON_MASK_SH_LIST(mask_sh)\
 	SE_SF(DP_LINK_ENC0_DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC_CLOCK_EN, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_RESET, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_CONTROL, DPHY_ENABLE, mask_sh),\
@@ -126,11 +129,14 @@ struct dcn31_hpo_dp_link_encoder_registers {
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_TP_SQ_PULSE, TP_SQ_PULSE_WIDTH, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_STREAM_SOURCE, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_VC0, SAT_SLOT_COUNT, mask_sh),\
-	SE_SF(RDPCSTX0_RDPCSTX_PHY_CNTL6, RDPCS_PHY_DPALT_DISABLE, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_X, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_VC_RATE_CNTL0, STREAM_VC_RATE_Y, mask_sh),\
 	SE_SF(DP_DPHY_SYM320_DP_DPHY_SYM32_SAT_UPDATE, SAT_UPDATE, mask_sh)
 
+#define DCN3_1_HPO_DP_LINK_ENC_MASK_SH_LIST(mask_sh)\
+	DCN3_1_HPO_DP_LINK_ENC_COMMON_MASK_SH_LIST(mask_sh),\
+	DCN3_1_HPO_DP_LINK_ENC_RDPCSTX_MASK_SH_LIST(mask_sh)\
+
 #define DCN3_1_HPO_DP_LINK_ENC_REG_FIELD_LIST(type) \
 	type DP_LINK_ENC_CLOCK_EN;\
 	type DPHY_RESET;\
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ced176d17bae..840460ad0bf8 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -103,6 +103,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN316,
 	DMUB_ASIC_DCN32,
 	DMUB_ASIC_DCN321,
+
 	DMUB_ASIC_MAX,
 };
 
@@ -419,7 +420,7 @@ struct dmub_srv {
 	const struct dmub_srv_common_regs *regs;
 	const struct dmub_srv_dcn31_regs *regs_dcn31;
 	const struct dmub_srv_dcn32_regs *regs_dcn32;
-
+    const struct dmub_srv_dcn35_regs *regs_dcn35;
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
 	struct dmub_rb inbox1_rb;
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index d2427cf1155f..97084958d845 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -62,6 +62,7 @@ enum dce_version {
 	DCN_VERSION_3_16,
 	DCN_VERSION_3_2,
 	DCN_VERSION_3_21,
+
 	DCN_VERSION_MAX
 };
 
-- 
2.25.1

