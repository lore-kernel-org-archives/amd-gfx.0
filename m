Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52BECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CC810EB5E;
	Sat, 27 Aug 2022 02:50:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FECF10EB5E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIxzMjt30duAQbziZQ92yWPZOTf8Lm9IvVpAa3rDOb4uqf88CVyEUHIfX2xakp0ippjYeCDHWIWo6iIOMxTby153P5ed7pngU/Wj1b+nYUmcQsNpg3d47Bxz2IZgquGMmzr4Isu3NlvmBgGCDao5qLoeOZzIb6q8JYTfVbkh9OxwSZG1tsvFIVzOESqBVXVBkIwZvBHmCH5sM3k0YdxRvE7TjMpBynhjrUTVXt6jLQ72sEIIThPIImtZn+U0vZFolP3fZbrL8GE9Re9+GhGTahlVOe6UvkBtTX1xQo04ijyRs7X78xHX1ole164Nbg4dbne7bk+3QGYuWPH5rQwnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdA0v2m8dnQ5VuuuwbzQQemGFwm4B2amfkDg0ZVo3d4=;
 b=Z57cqmWTqH5+jXg2oGQjEz2Z/8twx2CVaPXE1W7j+/fnf1GOsDF/RqaZHRHGTZpDrPk/sy1wEmWyb/D735OPhK0JZkGXt9rhi5HEpJQxCtvCH596GNeLO0U3b8Ge/H7YF0fz57MowLzZjbNynp8ZCYUH9mu12U9K5btxB0oQoI+r9vuxvcO4Adq3R8XIs4MeJhhuazI1ui5NYRx5CaXu7vovfbawCWzAKWG5TQsSU1kdov0Gs/37ohlB7/7GEi3r5IG+8sKLRJ0+bKhN51ZGgGgNeoZyBv/OtXafCZaAzzqMVLSkv3aPO5Zh6CwQuDraK8tbLDd6abhUfdA3f7+3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdA0v2m8dnQ5VuuuwbzQQemGFwm4B2amfkDg0ZVo3d4=;
 b=OxIljvIF73MXytyI69bWLJvSo7/+bQ/b3esXoqqs/JmAg3JLMr5O0r5WUGnHxiIGoMAftW+aaY2Psi3PUOohXbsrMVKwW7P0GJAXL/VebTERzrc0IiXUIyPiNPF5tklhCcUngQNItH3iQNc9LALA0b1oHCko/30VRE5woi6EAYE=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 02:50:44 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::41) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:32 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:29
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: add dcn35 basic support
Date: Sat, 27 Aug 2022 06:50:26 +0800
Message-ID: <20220826225053.1435588-7-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 032968d7-a6a6-49b6-c616-08da87d6efc7
X-MS-TrafficTypeDiagnostic: PH0PR12MB5645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2ImVKASGXB3nOeJuOjwl0nJmwyQu6X07DeNFwAjLCeIzgMQ8AeXF5y6AQ95bx96Xi+jM+RuDGaByXgeMIGlNtPnX8+sZ1V2ST1i1+J6TjLQHie3uUxi6xXeHkYb73IJ9CnsZ/lzk2kYbxKv/49C+tLMJkerp7iLQ0PdLJ3GD79b2uvq4M2IPVko134DwpwFuDl/x0TU54t1owXDQMP1FDKlZnLRdxTjOnD5l9ze+PirKFUAuhJaivXGm+SPVGLVC7G7PP7NyFi1Mdhqz69ulaJpwTXiPCcZgEppm5XG5P/tW+yjm29Fe8rUzYimrJvFB1bsQZwbMMtdC4tB4Bo7tWvzUpMrJwZP2OGmtvy6QKW4u4MhfeF0KxNTP+9NLjqOUpwGcCTF979wY9dYoW50Wk+jMmXWxBqmk2y8hWYJQ1RF5x0wkkCk7ckzeGA5pONffUmqBZYoTgv05Y5VLKVi9fw8SQWCIf6eObOWAnvB1wZEP00QVQWeAdg1PLxUcIqIFMFP7EdGDx8K1YxbzbN6KRoq4H/yhOxtBHQv7zYr5AJN2X4sWDA30uT6N5Uu+Z66sozHi+Jx0MjShyYG4R8KvL2D/KLsFPSNaFGDsL5GZvWtriFVZ3BU4yqXIwLw9Qy+kxz1Zq2nphrT6CdmbSwZfgic4O2G/ypgCF8Bc4c666IqLaGJ4Lp/YGvRQzlz29PqJx3Px8xJOmGIBCat7CoQO/PPN0bUNhiD4C7W5bgAUv57O8Eumj3GLCcPE1fUtw7UxfuqzpKQ6jL+WmZxtr3/IOhFFUfLhQFwz4f38iSwuxEyPu5pDhAFbxDK/36Ze2vK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(40470700004)(36840700001)(41300700001)(6666004)(356005)(2906002)(81166007)(7696005)(54906003)(6916009)(86362001)(478600001)(40460700003)(4326008)(8676002)(70586007)(70206006)(316002)(5660300002)(8936002)(83380400001)(36860700001)(40480700001)(336012)(1076003)(186003)(426003)(47076005)(2616005)(36756003)(26005)(82310400005)(82740400003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:44.0694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032968d7-a6a6-49b6-c616-08da87d6efc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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

