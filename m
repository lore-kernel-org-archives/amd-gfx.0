Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD4C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9D210E816;
	Wed,  7 Sep 2022 18:13:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0525110E80B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIYeDAB8tCj9HZptAlikP/dIVGMTCSidp7B4U1MAz1qa/rl+Orq/6E2QE42K+GxFirxXZO6olBmq1XJNIpI/WjxTAiYV078e7BKcBE/P8m0yNg8h82717ab70pLMT3P2IEI7Zs6+GUh2f8EsAGZL9yHYRrBkkBzsxqsHGvpHA2skRuVoWCL7YaYDVbqbH/JOPaWKPn6tPPcui4oHDnG41k9Ed/KeowNJ8xFPSIcnJmS7cI2xdOBpQzc3TsmzNuCVOfVNhVqJ3FaWtPgsgJHEolo+MWwKHcaDV4+lcAFhWD2d5CW+54SIYaA/x+xVgsrb1CGlnRj2efrus8q8pHXUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiiGwzrkPbpHmDuFlnAP0vTD7yQtV3kTd22MogIMHZQ=;
 b=biMe1FjSKaTGmtHGR0/birybmszhyTsVLxN2tEEcM6bYRGhnmwken3lTBg0G955CVzEiTSIkq6k+0ovU2bZGYpAowwcDI8jom8Ayw/nvfM5PLwKWTI5W8/glnuX6/PQM+yILtHocn6+6iz05KKngEoPE8hpnT/vI4MmdknsCji2C8eaY+fziRbOwalc3+oL6RvWXtKLzwp2NLww9w7B0eFF/AUfOe8nkD6p1j9SyNQ0oBOJVYN+3g6kXoVDgJdfTMYBXaqsV9BlZOl9vdmsfjHiN5BOoAdNL/t09+YIxODj3vn+fUHwU5rzcSN4Ld+azVzA0JFZH/8Dh2wg8MIhyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiiGwzrkPbpHmDuFlnAP0vTD7yQtV3kTd22MogIMHZQ=;
 b=JiKPUtDKXgKnCsZH8AccUVI0tWomBeZ6yj3asxVfaeiMrzSBWpJ4LKwTmZbaMvSVSHaD0159njeZ4v/yvFVrtPMcBTcUE0bRcM2BndfOUAOwcZx+8fwLAKkkJkEP5yc3pUwCPN3NJlZLBNRHxUl9FoTDvEwzVmBfWAQ+0JS0m3A=
Received: from DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 7 Sep 2022 18:12:38 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::d) by DM5PR06CA0074.outlook.office365.com
 (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:37 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:36 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/21] drm/amd/display: Fix register definitions for DCN32/321
Date: Wed, 7 Sep 2022 14:11:59 -0400
Message-ID: <20220907181200.54726-20-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab8ed2c-5ef3-4b08-9284-08da90fc8be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jo31HsUi/D5yZy/JcCY/DwirtYkHqRT+t8M6SdDWpDUJ6iOEnSxJVWUetuDlTfI0P3ixeKS5FP3HdC8mWGd0AxpktFoyJPna0iCrof+xVZlDdR6bF+RiKKDTcE31uzsciDASbOMb5tnQw3f06OpEScNnlHDNA5I4W12Lr1/HRVOPX0+bgG7W1eMPMBVwgujB2Fs9AGwRnKnr3WJkYOu2qTPmunYhl4z7653c5o6+xKDxuPpd4UWyuKQiRhgsY3qv0ZGoZJ2oZgcbXVqJZa7WyOwn4Ap03zRdw4sUfIECUMGExfMtTouJynL3f9qbxMV4R+Lw8Qu2SukQh1wtu7+84oZnacU/O7eCzg9ukeUn96P1BvlwxS3qnd2JxjfJDXtuqDkekkEhFGaphZ3nekA1qRlophfDdrFB4MoIxJf+EvLQw6IC6AGMS7jCzJAGe6Klfv5C73hMQtzcu7tcMXF2ulzcOBfejo+peIBdkbWt+enP4SJU2NLasTgKmnGYsFo6Z8uRXhigcAUX6sh6gp4IDE8ZnpbV2ixoS1hxNBiFRiJ5nT28UFO+tClQbbd2wH098LGqtLSsj5B4eiyJzliONMBT8JDibTn5z0j1CrAfXCf9jAacLdOUQr3uhpa5VEmXfauvogjwHxIuRVlvl9LBGG7UROwCUWNGYilHnKfgGGXtKsCUI1VffsMM4WDdTvMgXqVoZXsaSY1FkyV7s/ifh74spNy8ybk9q0vJpisWx6JT40KAG4+oexTWXXFO4c9x3+0mkN4O4AgWK5KV98Q9dooZW+MJv8A8Cjm3NSg99QZN3M5OnENqrnHVObmHAHLZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(426003)(47076005)(2616005)(83380400001)(8676002)(30864003)(5660300002)(6666004)(8936002)(2906002)(16526019)(70586007)(44832011)(36756003)(70206006)(40480700001)(356005)(6916009)(316002)(54906003)(478600001)(86362001)(40460700003)(41300700001)(82740400003)(81166007)(26005)(1076003)(4326008)(186003)(7696005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:37.8842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab8ed2c-5ef3-4b08-9284-08da90fc8be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
Fix the instatiation sequence for MPC registers and add a few other
missing register definitions that were ommited erroneously when copying
them over to enable runtime initialization of reigster offsets for
DCN32/321

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 216 ++++++++++++------
 .../amd/display/dc/dcn321/dcn321_resource.c   |  24 +-
 3 files changed, 166 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0b94a783d285..11f1435b8c07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -468,22 +468,17 @@ static const struct dcn20_dsc_mask dsc_mask = {
 };
 
 static struct dcn30_mpc_registers mpc_regs;
-#define dcn_mpc_regs_init()\
-		( \
-		MPC_REG_LIST_DCN3_0_RI(0),\
-		MPC_REG_LIST_DCN3_0_RI(1),\
-		MPC_REG_LIST_DCN3_0_RI(2),\
-		MPC_REG_LIST_DCN3_0_RI(3),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
-		MPC_MCM_REG_LIST_DCN32_RI(0),\
-		MPC_MCM_REG_LIST_DCN32_RI(1),\
-		MPC_MCM_REG_LIST_DCN32_RI(2),\
-		MPC_MCM_REG_LIST_DCN32_RI(3),\
-		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
-		)
+
+#define dcn_mpc_regs_init() \
+	MPC_REG_LIST_DCN3_2_RI(0),\
+	MPC_REG_LIST_DCN3_2_RI(1),\
+	MPC_REG_LIST_DCN3_2_RI(2),\
+	MPC_REG_LIST_DCN3_2_RI(3),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
+	MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
 
 static const struct dcn30_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index d1e85622dd3b..95f3517724d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -225,7 +225,8 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
       SRI_ARR(DP_MSA_TIMING_PARAM4, DP, id),                                   \
       SRI_ARR(DP_MSE_RATE_CNTL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP, id),  \
       SRI_ARR(DP_PIXEL_FORMAT, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),          \
-      SRI_ARR(DP_SEC_CNTL2, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
+      SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR(DP_SEC_CNTL2, DP, id),            \
+      SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
       SRI_ARR(DP_STEER_FIFO, DP, id), SRI_ARR(DP_VID_M, DP, id),               \
       SRI_ARR(DP_VID_N, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),          \
       SRI_ARR(DP_VID_TIMING, DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),           \
@@ -738,75 +739,6 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
 #define MPC_DWB_MUX_REG_LIST_DCN3_0_RI(inst)                                   \
   SRII_DWB(DWB_MUX, MUX, MPC_DWB, inst)
 
-#define MPC_MCM_REG_LIST_DCN32_RI(inst)                                        \
-  ( \
-  SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),                               \
-      SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),                          \
-      SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),                          \
-      SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),                          \
-      SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),                           \
-      SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),                         \
-      SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),                         \
-      SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),                          \
-      SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),                   \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst),                               \
-      SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),                              \
-      SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),                               \
-      SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),                         \
-      SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),                 \
-      SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),                    \
-      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),                       \
-      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),                       \
-      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),                       \
-      SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)                              \
-  )
-
 #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst)                            \
   ( \
   SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)          \
@@ -890,6 +822,149 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
       SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)                             \
   )
 
+#define MPC_REG_LIST_DCN3_2_RI(inst) \
+	MPC_REG_LIST_DCN3_0_RI(inst),\
+	SRII(MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC, inst),\
+	SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst), /*TODO: may need to add other 3DLUT regs*/\
+	SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMA_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_B, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_G, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_R, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_0_1, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_2_3, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_4_5, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_6_7, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_8_9, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_10_11, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_12_13, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_14_15, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_16_17, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_18_19, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_20_21, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_22_23, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_24_25, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_26_27, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_28_29, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_MCM, inst),\
+	SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)
+
 /* OPTC */
 
 #define OPTC_COMMON_REG_LIST_DCN3_2_RI(inst)                                   \
@@ -1124,6 +1199,7 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
       SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D), SR(DCHUBBUB_DET0_CTRL),    \
       SR(DCHUBBUB_DET1_CTRL), SR(DCHUBBUB_DET2_CTRL), SR(DCHUBBUB_DET3_CTRL),  \
       SR(DCHUBBUB_COMPBUF_CTRL), SR(COMPBUF_RESERVED_SPACE),                   \
+      SR(DCHUBBUB_DEBUG_CTRL_0),                                               \
       SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),                                    \
       SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),                             \
       SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),                             \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index b602fdbbaf10..1bbc0bdf5dc3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -473,21 +473,15 @@ static const struct dcn20_dsc_mask dsc_mask = {
 
 static struct dcn30_mpc_registers mpc_regs;
 #define dcn_mpc_regs_init()\
-		( \
-		MPC_REG_LIST_DCN3_0_RI(0),\
-		MPC_REG_LIST_DCN3_0_RI(1),\
-		MPC_REG_LIST_DCN3_0_RI(2),\
-		MPC_REG_LIST_DCN3_0_RI(3),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
-		MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
-		MPC_MCM_REG_LIST_DCN32_RI(0),\
-		MPC_MCM_REG_LIST_DCN32_RI(1),\
-		MPC_MCM_REG_LIST_DCN32_RI(2),\
-		MPC_MCM_REG_LIST_DCN32_RI(3),\
-		MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
-		)
+	MPC_REG_LIST_DCN3_2_RI(0),\
+	MPC_REG_LIST_DCN3_2_RI(1),\
+	MPC_REG_LIST_DCN3_2_RI(2),\
+	MPC_REG_LIST_DCN3_2_RI(3),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
+	MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
+	MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
 
 static const struct dcn30_mpc_shift mpc_shift = {
 	MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
-- 
2.34.1

