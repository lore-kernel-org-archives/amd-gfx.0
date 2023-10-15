Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F9CDB47E
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Oct 2023 11:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946C310E0D7;
	Sun, 15 Oct 2023 11:10:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC35A10E0D7
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Oct 2023 11:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCsGsr9MFYjWS9eT0h6a6gt2cIsRQDNx8CAWCzCb8wo+gGxO0NCEtnMTIvnUEMUFX68JKGVpGbHSC+9o7tH+8sw0ey3gLSUAFw7jLvFk7mkq8AylqnVlwrwq/PeNiDE1xQIYGWRs953lRYgNytuk+h8wrbxgabftwaj5oiBCkpt+WJRHQE7CtvnKSNmQZdu3XEL3vU3mafi2arGXtzk50HIknVMHm6qrpwLyhhq7RB5xDESCoxQ5o4jX0hr8/Z/LSQGrZtSjNu+ouB2QdIO3031dzfzS0maYfqlMqbr2bLXnYYAweHgcX3HjIZ2WVRizur6fC1MWdW7XX89XasMAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHnORBgtETjAX5tI23Cx8YDwLyDejnwyySFA7UyKw2c=;
 b=UVb/eQRP/piGjVxbicTbKbBWbgmQpRr2ELa5RdaU6mgkidU0NzdEKavuTModrkiM2NXvOM5AXc56c5cvSbP4Q2VDlbIQBX3V59mE3eXXIdTx1Rdj8XaXcxVoTo2j+3V+wB489Q3eCnAQN1LNROu+pXSR/nOOuzHAew0OHMtbru/uWJ+51EKLXFFKInNh16r64FWFNApKMlyFG+J3tMiDQtUQVAqOvIF/5aM1XHSX1loW7tZGIx1RyvvkI4qA9UCo0gS5g30udNuKvX3pLt4p+eYNDLvVQ5jqBrjzFBl1uNZiit5W9E6BjngJLZGiAUid0DQXscUD4M5haQaQrSxf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHnORBgtETjAX5tI23Cx8YDwLyDejnwyySFA7UyKw2c=;
 b=J7C/mn6vMpuOzqsIWjDMpeuQeD7I1bwCS5sM0DRy/e5K0b8uPkqr3iDOJDHCqsXAJb/7+qiP/xZd7yn3R7VtUJw0KpdoFQw6V+F+t4JxpnboHi52nXxmyyZvAVlXKYHHUAxGh5fzvFVJ+NLmlIHsceVwj3syOPNaapfwL4qojTs=
Received: from SA9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::9) by
 DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Sun, 15 Oct 2023 11:10:25 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::bd) by SA9P223CA0004.outlook.office365.com
 (2603:10b6:806:26::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Sun, 15 Oct 2023 11:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sun, 15 Oct 2023 11:10:24 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 15 Oct
 2023 06:10:19 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Remove brackets in macro to conform to
 coding style
Date: Sun, 15 Oct 2023 19:11:40 +0800
Message-ID: <20231015111145.386031-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ffe21d5-fdf5-4e02-7e5b-08dbcd6f5491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYVLVMxdgBJ7DlZfTnWez60Q9Gx00k0WbcXNS6lTGL4wMZqmiqOQSfh8XfE0z0GI/WONonwDNN/m2U74t6JE554GZylVzZfqcQI+qUdYlD6H4WeZRo8j/Sg4i31GfwirdeV6xoF/SzXlXxZJC4iAZupTWkZBRKkTMl6pJdUcLiPNOfNI4zAcK8nbpp/aP48dMtXhnS4uxJHEeG3miIJYUU30OXruiH2QRhHROshwculhzmtf6Jkd2JwtKbNlFvmEuVDJIr7VUu8PCUeEr7gknr+2qrSbj2kKwNc8kwUZFYBi2+qAZs7saHbVrZ4xFx9XS92ZwMgJiXGg25kh7oqYt9MR//Io9kBr14YCdne32OkIMkY3391+vCTm7/PxCp0JiYMWDrae0MJtqwYvCQYpDEG10EWI4pfSwORRw6RNuF85+v8Xhcn4ZKBYWWNlT1X9JZmUakdtsfbA4pEUTR1ACN59fdlHy7n5SdIFStNwys2FIN4ax8/5ZwoiWgGhuUFBedu6KS+zeGbIqymW5MrA+1WGZUP0x6w9mib6JR6RbiRjl9sdLp8hoEqbOPuL2dV1BisJL4n6JaXKr02sJEKgdf9vR2YHYnp5dTLCJutLkZhbTTeY+w4wtudA6SaDCzDWiQjg3JB3AfdujclOCDO5qx/1zwV+ABVs7+5/wOBP6J4VNBH08B7kp+CUx5VlzG+lJ0R5Y09SX02e1g3mIvxqVB3LkiSKGCpzA4vdXNoqat9MtrS0JbR/o37zL2ZKb5pA4r1trtncZFvadsZXG3WhCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(426003)(336012)(16526019)(26005)(1076003)(2616005)(36860700001)(30864003)(83380400001)(47076005)(54906003)(70206006)(70586007)(4326008)(8676002)(8936002)(316002)(6916009)(6666004)(41300700001)(7696005)(5660300002)(44832011)(478600001)(2906002)(82740400003)(356005)(81166007)(40480700001)(36756003)(86362001)(66899024)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 11:10:24.6317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe21d5-fdf5-4e02-7e5b-08dbcd6f5491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Many of the register macros defined ind dcn32_resource.h have
extra brackets. This is not conforming to the style of those
defined in other DC header files.

[How]
Remove these brackets in dcn32_resource.h

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 154 ++++--------------
 1 file changed, 36 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index f075982363be..b931008114c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -187,7 +187,6 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 
 /* CLK SRC */
 #define CS_COMMON_REG_LIST_DCN3_0_RI(index, pllid)                             \
-  (                                                                            \
   SRI_ARR_ALPHABET(PIXCLK_RESYNC_CNTL, PHYPLL, index, pllid),                  \
       SRII_ARR_2(PHASE, DP_DTO, 0, index),                                     \
       SRII_ARR_2(PHASE, DP_DTO, 1, index),                                     \
@@ -200,12 +199,10 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 0, index),                              \
       SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 1, index),                              \
       SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 2, index),                              \
-      SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 3, index)                               \
-  )
+      SRII_ARR_2(PIXEL_RATE_CNTL, OTG, 3, index)
 
 /* ABM */
 #define ABM_DCN32_REG_LIST_RI(id)                                              \
-  ( \
   SRI_ARR(DC_ABM1_HG_SAMPLE_RATE, ABM, id),                                    \
       SRI_ARR(DC_ABM1_LS_SAMPLE_RATE, ABM, id),                                \
       SRI_ARR(BL1_PWM_BL_UPDATE_SAMPLE_RATE, ABM, id),                         \
@@ -217,12 +214,10 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, ABM, id),                  \
       SRI_ARR(DC_ABM1_HGLS_REG_READ_PROGRESS, ABM, id),                        \
       SRI_ARR(DC_ABM1_ACE_OFFSET_SLOPE_0, ABM, id),                            \
-      SRI_ARR(DC_ABM1_ACE_THRES_12, ABM, id), NBIO_SR_ARR(BIOS_SCRATCH_2, id)  \
-  )
+      SRI_ARR(DC_ABM1_ACE_THRES_12, ABM, id), NBIO_SR_ARR(BIOS_SCRATCH_2, id)
 
 /* Audio */
 #define AUD_COMMON_REG_LIST_RI(id)                                             \
-  ( \
   SRI_ARR(AZALIA_F0_CODEC_ENDPOINT_INDEX, AZF0ENDPOINT, id),                   \
       SRI_ARR(AZALIA_F0_CODEC_ENDPOINT_DATA, AZF0ENDPOINT, id),                \
       SR_ARR(AZALIA_F0_CODEC_FUNCTION_PARAMETER_STREAM_FORMATS, id),           \
@@ -231,41 +226,33 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SR_ARR(DCCG_AUDIO_DTO_SOURCE, id), SR_ARR(DCCG_AUDIO_DTO0_MODULE, id),   \
       SR_ARR(DCCG_AUDIO_DTO0_PHASE, id), SR_ARR(DCCG_AUDIO_DTO1_MODULE, id),   \
       SR_ARR(DCCG_AUDIO_DTO1_PHASE, id)                                        \
-  )
 
 /* VPG */
 
 #define VPG_DCN3_REG_LIST_RI(id)                                               \
-  ( \
   SRI_ARR(VPG_GENERIC_STATUS, VPG, id),                                        \
       SRI_ARR(VPG_GENERIC_PACKET_ACCESS_CTRL, VPG, id),                        \
       SRI_ARR(VPG_GENERIC_PACKET_DATA, VPG, id),                               \
       SRI_ARR(VPG_GSP_FRAME_UPDATE_CTRL, VPG, id),                             \
-      SRI_ARR(VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG, id)                          \
-  )
+      SRI_ARR(VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG, id)
 
 /* AFMT */
 #define AFMT_DCN3_REG_LIST_RI(id)                                              \
-  ( \
   SRI_ARR(AFMT_INFOFRAME_CONTROL0, AFMT, id),                                  \
       SRI_ARR(AFMT_VBI_PACKET_CONTROL, AFMT, id),                              \
       SRI_ARR(AFMT_AUDIO_PACKET_CONTROL, AFMT, id),                            \
       SRI_ARR(AFMT_AUDIO_PACKET_CONTROL2, AFMT, id),                           \
       SRI_ARR(AFMT_AUDIO_SRC_CONTROL, AFMT, id),                               \
       SRI_ARR(AFMT_60958_0, AFMT, id), SRI_ARR(AFMT_60958_1, AFMT, id),        \
-      SRI_ARR(AFMT_60958_2, AFMT, id), SRI_ARR(AFMT_MEM_PWR, AFMT, id)         \
-  )
+      SRI_ARR(AFMT_60958_2, AFMT, id), SRI_ARR(AFMT_MEM_PWR, AFMT, id)
 
 /* APG */
 #define APG_DCN31_REG_LIST_RI(id)                                              \
-  (\
   SRI_ARR(APG_CONTROL, APG, id), SRI_ARR(APG_CONTROL2, APG, id),               \
-      SRI_ARR(APG_MEM_PWR, APG, id), SRI_ARR(APG_DBG_GEN_CONTROL, APG, id)     \
-  )
+      SRI_ARR(APG_MEM_PWR, APG, id), SRI_ARR(APG_DBG_GEN_CONTROL, APG, id)
 
 /* Stream encoder */
 #define SE_DCN32_REG_LIST_RI(id)                                               \
-  ( \
   SRI_ARR(AFMT_CNTL, DIG, id), SRI_ARR(DIG_FE_CNTL, DIG, id),                  \
       SRI_ARR(HDMI_CONTROL, DIG, id), SRI_ARR(HDMI_DB_CONTROL, DIG, id),       \
       SRI_ARR(HDMI_GC, DIG, id),                                               \
@@ -309,28 +296,22 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DP_SEC_METADATA_TRANSMISSION, DP, id),                           \
       SRI_ARR(HDMI_METADATA_PACKET_CONTROL, DIG, id),                          \
       SRI_ARR(DIG_FE_CNTL, DIG, id), SRI_ARR(DIG_CLOCK_PATTERN, DIG, id),      \
-      SRI_ARR(DIG_FIFO_CTRL0, DIG, id)                                         \
-  )
+      SRI_ARR(DIG_FIFO_CTRL0, DIG, id)
 
 /* Aux regs */
 
 #define AUX_REG_LIST_RI(id)                                                    \
-  ( \
   SRI_ARR(AUX_CONTROL, DP_AUX, id), SRI_ARR(AUX_DPHY_RX_CONTROL0, DP_AUX, id), \
-      SRI_ARR(AUX_DPHY_RX_CONTROL1, DP_AUX, id)                                \
-  )
+      SRI_ARR(AUX_DPHY_RX_CONTROL1, DP_AUX, id)
 
 #define DCN2_AUX_REG_LIST_RI(id)                                               \
-  ( \
-  AUX_REG_LIST_RI(id), SRI_ARR(AUX_DPHY_TX_CONTROL, DP_AUX, id)                \
-  )
+  AUX_REG_LIST_RI(id), SRI_ARR(AUX_DPHY_TX_CONTROL, DP_AUX, id)
 
 /* HDP */
 #define HPD_REG_LIST_RI(id) SRI_ARR(DC_HPD_CONTROL, HPD, id)
 
 /* Link encoder */
 #define LE_DCN3_REG_LIST_RI(id)                                                \
-  ( \
   SRI_ARR(DIG_BE_CNTL, DIG, id), SRI_ARR(DIG_BE_EN_CNTL, DIG, id),             \
       SRI_ARR(TMDS_CTL_BITS, DIG, id),                                         \
       SRI_ARR(TMDS_DCBALANCER_CONTROL, DIG, id), SRI_ARR(DP_CONFIG, DP, id),   \
@@ -344,26 +325,20 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DP_SEC_CNTL, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),       \
       SRI_ARR(DP_DPHY_FAST_TRAINING, DP, id), SRI_ARR(DP_SEC_CNTL1, DP, id),   \
       SRI_ARR(DP_DPHY_BS_SR_SWAP_CNTL, DP, id),                                \
-      SRI_ARR(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)                            \
-  )
+      SRI_ARR(DP_DPHY_HBR2_PATTERN_CONTROL, DP, id)
 
 #define LE_DCN31_REG_LIST_RI(id)                                               \
-  ( \
   LE_DCN3_REG_LIST_RI(id), SRI_ARR(DP_DPHY_INTERNAL_CTRL, DP, id),             \
       SR_ARR(DIO_LINKA_CNTL, id), SR_ARR(DIO_LINKB_CNTL, id),                  \
       SR_ARR(DIO_LINKC_CNTL, id), SR_ARR(DIO_LINKD_CNTL, id),                  \
-      SR_ARR(DIO_LINKE_CNTL, id), SR_ARR(DIO_LINKF_CNTL, id)                   \
-  )
+      SR_ARR(DIO_LINKE_CNTL, id), SR_ARR(DIO_LINKF_CNTL, id)
 
 #define UNIPHY_DCN2_REG_LIST_RI(id, phyid)                                     \
-  ( \
   SRI_ARR_ALPHABET(CLOCK_ENABLE, SYMCLK, id, phyid),                           \
-      SRI_ARR_ALPHABET(CHANNEL_XBAR_CNTL, UNIPHY, id, phyid)                   \
-  )
+      SRI_ARR_ALPHABET(CHANNEL_XBAR_CNTL, UNIPHY, id, phyid)
 
 /* HPO DP stream encoder */
 #define DCN3_1_HPO_DP_STREAM_ENC_REG_LIST_RI(id)                               \
-  ( \
   SR_ARR(DP_STREAM_MAPPER_CONTROL0, id),                                       \
       SR_ARR(DP_STREAM_MAPPER_CONTROL1, id),                                   \
       SR_ARR(DP_STREAM_MAPPER_CONTROL2, id),                                   \
@@ -398,12 +373,10 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, DP_SYM32_ENC, id),     \
       SRI_ARR(DP_SYM32_ENC_SDP_AUDIO_CONTROL0, DP_SYM32_ENC, id),              \
       SRI_ARR(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id),                 \
-      SRI_ARR(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id)                   \
-  )
+      SRI_ARR(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id)
 
 /* HPO DP link encoder regs */
 #define DCN3_1_HPO_DP_LINK_ENC_REG_LIST_RI(id)                                 \
-  ( \
   SRI_ARR(DP_LINK_ENC_CLOCK_CONTROL, DP_LINK_ENC, id),                         \
       SRI_ARR(DP_DPHY_SYM32_CONTROL, DP_DPHY_SYM32, id),                       \
       SRI_ARR(DP_DPHY_SYM32_STATUS, DP_DPHY_SYM32, id),                        \
@@ -432,12 +405,10 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL1, DP_DPHY_SYM32, id),                 \
       SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL2, DP_DPHY_SYM32, id),                 \
       SRI_ARR(DP_DPHY_SYM32_VC_RATE_CNTL3, DP_DPHY_SYM32, id),                 \
-      SRI_ARR(DP_DPHY_SYM32_SAT_UPDATE, DP_DPHY_SYM32, id)                     \
-  )
+      SRI_ARR(DP_DPHY_SYM32_SAT_UPDATE, DP_DPHY_SYM32, id)
 
 /* DPP */
 #define DPP_REG_LIST_DCN30_COMMON_RI(id)                                       \
-  ( \
   SRI_ARR(CM_DEALPHA, CM, id), SRI_ARR(CM_MEM_PWR_STATUS, CM, id),             \
       SRI_ARR(CM_BIAS_CR_R, CM, id), SRI_ARR(CM_BIAS_Y_G_CB_B, CM, id),        \
       SRI_ARR(PRE_DEGAM, CNVC_CFG, id), SRI_ARR(CM_GAMCOR_CONTROL, CM, id),    \
@@ -552,12 +523,10 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(CURSOR_CONTROL, CURSOR0_, id),                                   \
       SRI_ARR(OBUF_MEM_PWR_CTRL, DSCL, id),                                    \
       SRI_ARR(DSCL_MEM_PWR_STATUS, DSCL, id),                                  \
-      SRI_ARR(DSCL_MEM_PWR_CTRL, DSCL, id)                                     \
-  )
+      SRI_ARR(DSCL_MEM_PWR_CTRL, DSCL, id)
 
 /* OPP */
 #define OPP_REG_LIST_DCN_RI(id)                                                \
-  ( \
   SRI_ARR(FMT_BIT_DEPTH_CONTROL, FMT, id), SRI_ARR(FMT_CONTROL, FMT, id),      \
       SRI_ARR(FMT_DITHER_RAND_R_SEED, FMT, id),                                \
       SRI_ARR(FMT_DITHER_RAND_G_SEED, FMT, id),                                \
@@ -569,37 +538,29 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(OPPBUF_3D_PARAMETERS_0, OPPBUF, id),                             \
       SRI_ARR(OPPBUF_3D_PARAMETERS_1, OPPBUF, id),                             \
       SRI_ARR(OPP_PIPE_CONTROL, OPP_PIPE, id)                                  \
-  )
 
 #define OPP_REG_LIST_DCN10_RI(id) OPP_REG_LIST_DCN_RI(id)
 
 #define OPP_DPG_REG_LIST_RI(id)                                                \
-  ( \
   SRI_ARR(DPG_CONTROL, DPG, id), SRI_ARR(DPG_DIMENSIONS, DPG, id),             \
       SRI_ARR(DPG_OFFSET_SEGMENT, DPG, id), SRI_ARR(DPG_COLOUR_B_CB, DPG, id), \
       SRI_ARR(DPG_COLOUR_G_Y, DPG, id), SRI_ARR(DPG_COLOUR_R_CR, DPG, id),     \
-      SRI_ARR(DPG_RAMP_CONTROL, DPG, id), SRI_ARR(DPG_STATUS, DPG, id)         \
-  )
+      SRI_ARR(DPG_RAMP_CONTROL, DPG, id), SRI_ARR(DPG_STATUS, DPG, id)
 
 #define OPP_REG_LIST_DCN30_RI(id)                                              \
-  ( \
   OPP_REG_LIST_DCN10_RI(id), OPP_DPG_REG_LIST_RI(id),                          \
-      SRI_ARR(FMT_422_CONTROL, FMT, id)                                        \
-  )
+      SRI_ARR(FMT_422_CONTROL, FMT, id)
 
 /* Aux engine regs */
 #define AUX_COMMON_REG_LIST0_RI(id)                                            \
-  ( \
   SRI_ARR(AUX_CONTROL, DP_AUX, id), SRI_ARR(AUX_ARB_CONTROL, DP_AUX, id),      \
       SRI_ARR(AUX_SW_DATA, DP_AUX, id), SRI_ARR(AUX_SW_CONTROL, DP_AUX, id),   \
       SRI_ARR(AUX_INTERRUPT_CONTROL, DP_AUX, id),                              \
       SRI_ARR(AUX_DPHY_RX_CONTROL1, DP_AUX, id),                               \
-      SRI_ARR(AUX_SW_STATUS, DP_AUX, id)                                       \
-  )
+      SRI_ARR(AUX_SW_STATUS, DP_AUX, id)
 
 /* DWBC */
 #define DWBC_COMMON_REG_LIST_DCN30_RI(id)                                      \
-  ( \
   SR_ARR(DWB_ENABLE_CLK_CTRL, id), SR_ARR(DWB_MEM_PWR_CTRL, id),               \
       SR_ARR(FC_MODE_CTRL, id), SR_ARR(FC_FLOW_CTRL, id),                      \
       SR_ARR(FC_WINDOW_START, id), SR_ARR(FC_WINDOW_SIZE, id),                 \
@@ -693,13 +654,11 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SR_ARR(DWB_OGAM_RAMB_REGION_26_27, id),                                  \
       SR_ARR(DWB_OGAM_RAMB_REGION_28_29, id),                                  \
       SR_ARR(DWB_OGAM_RAMB_REGION_30_31, id),                                  \
-      SR_ARR(DWB_OGAM_RAMB_REGION_32_33, id)                                   \
-  )
+      SR_ARR(DWB_OGAM_RAMB_REGION_32_33, id)
 
 /* MCIF */
 
 #define MCIF_WB_COMMON_REG_LIST_DCN32_RI(inst)                                 \
-  ( \
   SRI2_ARR(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB, inst),                          \
       SRI2_ARR(MCIF_WB_BUFMGR_STATUS, MCIF_WB, inst),                          \
       SRI2_ARR(MCIF_WB_BUF_PITCH, MCIF_WB, inst),                              \
@@ -747,13 +706,11 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI2_ARR(MMHUBBUB_WARMUP_ADDR_REGION, MMHUBBUB, inst),                   \
       SRI2_ARR(MMHUBBUB_WARMUP_BASE_ADDR_HIGH, MMHUBBUB, inst),                \
       SRI2_ARR(MMHUBBUB_WARMUP_BASE_ADDR_LOW, MMHUBBUB, inst),                 \
-      SRI2_ARR(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB, inst)                 \
-  )
+      SRI2_ARR(MMHUBBUB_WARMUP_CONTROL_STATUS, MMHUBBUB, inst)
 
 /* DSC */
 
 #define DSC_REG_LIST_DCN20_RI(id)                                              \
-  ( \
   SRI_ARR(DSC_TOP_CONTROL, DSC_TOP, id),                                       \
       SRI_ARR(DSC_DEBUG_CONTROL, DSC_TOP, id),                                 \
       SRI_ARR(DSCC_CONFIG0, DSCC, id), SRI_ARR(DSCC_CONFIG1, DSCC, id),        \
@@ -801,8 +758,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL, DSCC, id),         \
       SRI_ARR(DSCCIF_CONFIG0, DSCCIF, id),                                     \
       SRI_ARR(DSCCIF_CONFIG1, DSCCIF, id),                                     \
-      SRI_ARR(DSCRM_DSC_FORWARD_CONFIG, DSCRM, id)                             \
-  )
+      SRI_ARR(DSCRM_DSC_FORWARD_CONFIG, DSCRM, id)
 
 /* MPC */
 
@@ -810,32 +766,25 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
   SRII_DWB(DWB_MUX, MUX, MPC_DWB, inst)
 
 #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst)                            \
-  ( \
-  SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)          \
-  )
+  SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)
 
 #define MPC_OUT_MUX_REG_LIST_DCN3_0_RI(inst)                                   \
-  ( \
   MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst), SRII(CSC_MODE, MPC_OUT, inst),  \
       SRII(CSC_C11_C12_A, MPC_OUT, inst), SRII(CSC_C33_C34_A, MPC_OUT, inst),  \
       SRII(CSC_C11_C12_B, MPC_OUT, inst), SRII(CSC_C33_C34_B, MPC_OUT, inst),  \
       SRII(DENORM_CONTROL, MPC_OUT, inst),                                     \
       SRII(DENORM_CLAMP_G_Y, MPC_OUT, inst),                                   \
-      SRII(DENORM_CLAMP_B_CB, MPC_OUT, inst), SR(MPC_OUT_CSC_COEF_FORMAT)      \
-  )
+      SRII(DENORM_CLAMP_B_CB, MPC_OUT, inst), SR(MPC_OUT_CSC_COEF_FORMAT)
 
 #define MPC_COMMON_REG_LIST_DCN1_0_RI(inst)                                    \
-  ( \
   SRII(MPCC_TOP_SEL, MPCC, inst), SRII(MPCC_BOT_SEL, MPCC, inst),              \
       SRII(MPCC_CONTROL, MPCC, inst), SRII(MPCC_STATUS, MPCC, inst),           \
       SRII(MPCC_OPP_ID, MPCC, inst), SRII(MPCC_BG_G_Y, MPCC, inst),            \
       SRII(MPCC_BG_R_CR, MPCC, inst), SRII(MPCC_BG_B_CB, MPCC, inst),          \
       SRII(MPCC_SM_CONTROL, MPCC, inst),                                       \
-      SRII(MPCC_UPDATE_LOCK_SEL, MPCC, inst)                                   \
-  )
+      SRII(MPCC_UPDATE_LOCK_SEL, MPCC, inst)
 
 #define MPC_REG_LIST_DCN3_0_RI(inst)                                           \
-  ( \
   MPC_COMMON_REG_LIST_DCN1_0_RI(inst), SRII(MPCC_TOP_GAIN, MPCC, inst),        \
       SRII(MPCC_BOT_GAIN_INSIDE, MPCC, inst),                                  \
       SRII(MPCC_BOT_GAIN_OUTSIDE, MPCC, inst),                                 \
@@ -889,8 +838,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRII(MPCC_OGAM_RAMB_START_BASE_CNTL_G, MPCC_OGAM, inst),                 \
       SRII(MPCC_OGAM_RAMB_START_BASE_CNTL_R, MPCC_OGAM, inst),                 \
       SRII(MPCC_OGAM_CONTROL, MPCC_OGAM, inst),                                \
-      SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)                             \
-  )
+      SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)
 
 #define MPC_REG_LIST_DCN3_2_RI(inst) \
 	MPC_REG_LIST_DCN3_0_RI(inst),\
@@ -1034,11 +982,9 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_MCM, inst),\
 	SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)
-
 /* OPTC */
 
 #define OPTC_COMMON_REG_LIST_DCN3_2_RI(inst)                                   \
-  ( \
   SRI_ARR(OTG_VSTARTUP_PARAM, OTG, inst),                                      \
       SRI_ARR(OTG_VUPDATE_PARAM, OTG, inst),                                   \
       SRI_ARR(OTG_VREADY_PARAM, OTG, inst),                                    \
@@ -1100,22 +1046,17 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(OPTC_BYTES_PER_PIXEL, ODM, inst),                                \
       SRI_ARR(OPTC_WIDTH_CONTROL, ODM, inst),                                  \
       SRI_ARR(OPTC_MEMORY_CONFIG, ODM, inst),                                  \
-      SRI_ARR(OTG_DRR_CONTROL, OTG, inst)                                      \
-  )
+      SRI_ARR(OTG_DRR_CONTROL, OTG, inst)
 
 /* HUBP */
 
 #define HUBP_REG_LIST_DCN_VM_RI(id)                                            \
-  ( \
   SRI_ARR(NOM_PARAMETERS_0, HUBPREQ, id),                                      \
       SRI_ARR(NOM_PARAMETERS_1, HUBPREQ, id),                                  \
       SRI_ARR(NOM_PARAMETERS_2, HUBPREQ, id),                                  \
       SRI_ARR(NOM_PARAMETERS_3, HUBPREQ, id),                                  \
-      SRI_ARR(DCN_VM_MX_L1_TLB_CNTL, HUBPREQ, id)                              \
-  )
-
+      SRI_ARR(DCN_VM_MX_L1_TLB_CNTL, HUBPREQ, id)
 #define HUBP_REG_LIST_DCN_RI(id)                                               \
-  ( \
   SRI_ARR(DCHUBP_CNTL, HUBP, id), SRI_ARR(HUBPREQ_DEBUG_DB, HUBP, id),         \
       SRI_ARR(HUBPREQ_DEBUG, HUBP, id), SRI_ARR(DCSURF_ADDR_CONFIG, HUBP, id), \
       SRI_ARR(DCSURF_TILING_CONFIG, HUBP, id),                                 \
@@ -1186,11 +1127,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DCN_SURF1_TTU_CNTL1, HUBPREQ, id),                               \
       SRI_ARR(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),                                \
       SRI_ARR(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),                                \
-      SRI_ARR(HUBP_CLK_CNTL, HUBP, id)                                         \
-  )
-
+      SRI_ARR(HUBP_CLK_CNTL, HUBP, id)
 #define HUBP_REG_LIST_DCN2_COMMON_RI(id)                                       \
-  ( \
   HUBP_REG_LIST_DCN_RI(id), HUBP_REG_LIST_DCN_VM_RI(id),                       \
       SRI_ARR(PREFETCH_SETTINGS, HUBPREQ, id),                                 \
       SRI_ARR(PREFETCH_SETTINGS_C, HUBPREQ, id),                               \
@@ -1217,35 +1155,24 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SRI_ARR(DCN_CUR1_TTU_CNTL0, HUBPREQ, id),                                \
       SRI_ARR(DCN_CUR1_TTU_CNTL1, HUBPREQ, id),                                \
       SRI_ARR(DCSURF_FLIP_CONTROL2, HUBPREQ, id),                              \
-      SRI_ARR(VMID_SETTINGS_0, HUBPREQ, id)                                    \
-  )
-
+      SRI_ARR(VMID_SETTINGS_0, HUBPREQ, id)
 #define HUBP_REG_LIST_DCN21_RI(id)                                             \
-  ( \
   HUBP_REG_LIST_DCN2_COMMON_RI(id), SRI_ARR(FLIP_PARAMETERS_3, HUBPREQ, id),   \
       SRI_ARR(FLIP_PARAMETERS_4, HUBPREQ, id),                                 \
       SRI_ARR(FLIP_PARAMETERS_5, HUBPREQ, id),                                 \
       SRI_ARR(FLIP_PARAMETERS_6, HUBPREQ, id),                                 \
       SRI_ARR(VBLANK_PARAMETERS_5, HUBPREQ, id),                               \
-      SRI_ARR(VBLANK_PARAMETERS_6, HUBPREQ, id)                                \
-  )
-
+      SRI_ARR(VBLANK_PARAMETERS_6, HUBPREQ, id)
 #define HUBP_REG_LIST_DCN30_RI(id)                                             \
-  ( \
-  HUBP_REG_LIST_DCN21_RI(id), SRI_ARR(DCN_DMDATA_VM_CNTL, HUBPREQ, id)         \
-  )
-
+  HUBP_REG_LIST_DCN21_RI(id), SRI_ARR(DCN_DMDATA_VM_CNTL, HUBPREQ, id)
 #define HUBP_REG_LIST_DCN32_RI(id)                                             \
-  ( \
   HUBP_REG_LIST_DCN30_RI(id), SRI_ARR(DCHUBP_MALL_CONFIG, HUBP, id),           \
       SRI_ARR(DCHUBP_VMPG_CONFIG, HUBP, id),                                   \
-      SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id)                                  \
-  )
+      SRI_ARR(UCLK_PSTATE_FORCE, HUBPREQ, id)
 
 /* HUBBUB */
 
 #define HUBBUB_REG_LIST_DCN32_RI(id)                                           \
-  ( \
   SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A),                                   \
       SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B),                               \
       SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C),                               \
@@ -1286,13 +1213,11 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SR(DCHUBBUB_ARB_MALL_CNTL),                                              \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
       SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
-      SR(SDPIF_REQUEST_RATE_LIMIT)                                             \
-  )
+      SR(SDPIF_REQUEST_RATE_LIMIT)
 
 /* DCCG */
 
 #define DCCG_REG_LIST_DCN32_RI()                                               \
-  ( \
   SR(DPPCLK_DTO_CTRL), DCCG_SRII(DTO_PARAM, DPPCLK, 0),                        \
       DCCG_SRII(DTO_PARAM, DPPCLK, 1), DCCG_SRII(DTO_PARAM, DPPCLK, 2),        \
       DCCG_SRII(DTO_PARAM, DPPCLK, 3), DCCG_SRII(CLOCK_CNTL, HDMICHARCLK, 0),  \
@@ -1308,38 +1233,31 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       DCCG_SRII(PHASE, DTBCLK_DTO, 2), DCCG_SRII(PHASE, DTBCLK_DTO, 3),        \
       SR(DCCG_AUDIO_DTBCLK_DTO_MODULO), SR(DCCG_AUDIO_DTBCLK_DTO_PHASE),       \
       SR(OTG_PIXEL_RATE_DIV), SR(DTBCLK_P_CNTL),                               \
-      SR(DCCG_AUDIO_DTO_SOURCE), SR(DENTIST_DISPCLK_CNTL)                      \
-  )
+      SR(DCCG_AUDIO_DTO_SOURCE), SR(DENTIST_DISPCLK_CNTL)
 
 /* VMID */
 #define DCN20_VMID_REG_LIST_RI(id)                                             \
-  ( \
   SRI_ARR(CNTL, DCN_VM_CONTEXT, id),                                           \
       SRI_ARR(PAGE_TABLE_BASE_ADDR_HI32, DCN_VM_CONTEXT, id),                  \
       SRI_ARR(PAGE_TABLE_BASE_ADDR_LO32, DCN_VM_CONTEXT, id),                  \
       SRI_ARR(PAGE_TABLE_START_ADDR_HI32, DCN_VM_CONTEXT, id),                 \
       SRI_ARR(PAGE_TABLE_START_ADDR_LO32, DCN_VM_CONTEXT, id),                 \
       SRI_ARR(PAGE_TABLE_END_ADDR_HI32, DCN_VM_CONTEXT, id),                   \
-      SRI_ARR(PAGE_TABLE_END_ADDR_LO32, DCN_VM_CONTEXT, id)                    \
-  )
+      SRI_ARR(PAGE_TABLE_END_ADDR_LO32, DCN_VM_CONTEXT, id)
 
 /* I2C HW */
 
 #define I2C_HW_ENGINE_COMMON_REG_LIST_RI(id)                                   \
-  ( \
       SRI_ARR_I2C(SETUP, DC_I2C_DDC, id), SRI_ARR_I2C(SPEED, DC_I2C_DDC, id),  \
       SRI_ARR_I2C(HW_STATUS, DC_I2C_DDC, id),                                  \
       SR_ARR_I2C(DC_I2C_ARBITRATION, id),                                      \
       SR_ARR_I2C(DC_I2C_CONTROL, id), SR_ARR_I2C(DC_I2C_SW_STATUS, id),        \
       SR_ARR_I2C(DC_I2C_TRANSACTION0, id), SR_ARR_I2C(DC_I2C_TRANSACTION1, id),\
       SR_ARR_I2C(DC_I2C_TRANSACTION2, id), SR_ARR_I2C(DC_I2C_TRANSACTION3, id),\
-      SR_ARR_I2C(DC_I2C_DATA, id), SR_ARR_I2C(MICROSECOND_TIME_BASE_DIV, id)          \
-  )
+      SR_ARR_I2C(DC_I2C_DATA, id), SR_ARR_I2C(MICROSECOND_TIME_BASE_DIV, id)
 
 #define I2C_HW_ENGINE_COMMON_REG_LIST_DCN30_RI(id)                             \
-  ( \
       I2C_HW_ENGINE_COMMON_REG_LIST_RI(id), SR_ARR_I2C(DIO_MEM_PWR_CTRL, id),  \
-      SR_ARR_I2C(DIO_MEM_PWR_STATUS, id)                                           \
-  )
+      SR_ARR_I2C(DIO_MEM_PWR_STATUS, id)
 
 #endif /* _DCN32_RESOURCE_H_ */
-- 
2.42.0

