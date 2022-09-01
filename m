Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311CEECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 19:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8915510E1A2;
	Thu,  1 Sep 2022 19:27:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B1810E1A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 19:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jopkC+VK72b/5MfxavB6OsM+7Y45rsZoBvD3fXafDxQUyFSip+DiRDRacZGlHWHvyFyp9qyccV7Wap8JZoJ/M3Cq1mlPmENl24jo0jCD5BJLU7SMXdWQyfOCiuNB1jVaPWzuYnA/ZuIQhSRAEL5u+9KGNgObza4aBKyUqh1tDmJFacIvqzHyGvGghbdKenPR7/LNjW2+v2D8qQQIhssCI5TKznnB12Z7pf0hrWb6wuZ5rwIViQwIc+IumO8zPNGXsp1T259SzBcUJ3ghkgHgW7FdNruNAYS7NZq/i9ljawVc9VY74odfMZ0oiN46h9iKlZZFYbb2HLxVBFoR2fwWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gFSjZao5G718L3OFHibXNrLNvtGX7ZZMlAvE0YVGoA=;
 b=NFRL549RU8Aq9Aw4M8QfCt9LdpDgjqwM/2DknMNt0DYxFrsqyNdGeAFyGHRABqMgTNl2+fXZY5EzJgLSJZHUbljr1Qmv5I2IuI7GtP1/SLypwyJPEInA8D/XaB7zvaJwek4Xx9DZNbv14ue5EGb2LTo3GUXJ1oxlE3+HTHIne6klQtlGk3mwVkYqkbqzdJ1xgYwn6enQb0WZ6tM6b3tVXHuOhnWB+DTUyZ8vSq6uE8sVPAe4yOPrihgY/XocB08q+ytKY72pZgZ0cUulubjJVUUGUcr+YLE/VvHF60/U6yu7+Re7mawE66PAAs2WiVpRSwFiMp13v4WaRS13ZkvDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gFSjZao5G718L3OFHibXNrLNvtGX7ZZMlAvE0YVGoA=;
 b=txGo2kQhgw3RiMHnINbtkxneUF2U1FkVWLtSP2fxIct3hjYNHiOoiLwxctKzF+2CBQ6BQqd5uUtJoXZxsFR6HUCueh/KuOLsn0DwstsMS6xvOTsDi4WAvwT9zACpODcfq7LoJ6nYv053GGOxo6z4L4rq2mA/0D/PSG5M8W4wKE4=
Received: from BN0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:e8::20)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 19:27:38 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::f3) by BN0PR04CA0045.outlook.office365.com
 (2603:10b6:408:e8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Thu, 1 Sep 2022 19:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 19:27:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 14:27:37 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 1 Sep 2022 14:27:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix register definitions for DCN32/321
Date: Thu, 1 Sep 2022 15:27:36 -0400
Message-ID: <20220901192736.1171423-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a702e6d1-b8a7-4f22-b3ce-08da8c500785
X-MS-TrafficTypeDiagnostic: CH3PR12MB7641:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBCaULwCf2vmFStK+I26klWX/6DsnNlmiWfmGLRgnW4LpAt/g/m5vgcRFHUbkuF6moxXPaRMTULqp2Zt2oqKsr3D1TDiylRzX4TWGklTWo9axepuK1m3Zu5GVVjNqpQRG39Y1u3UZ5HFka/WjD5gScQDJvRAobsi+HhQ317QqWaoP1DkZI55BjdYfP+jA0uyEIqBDXYxwWWKll3p8FU/RTqtOWaU6bHM49baLcJyzvrk7rT3iUYKZADRaxNMFqiK+jVdsatDOv0SyUJDXQGPC09FkIVUAfFJYe4YANGnLo2M4uXqYqxjd+vLyRi2cGT4URXzbEXTEX7q2ZGgsc3ssXbQSqZreHWrPRzy3GWqgSxwaWLm0UF04IpFxUFN2kjCImoR6gXuAsnRJaIjOoDaZxJm6dz8JTgdZRvK0NGMSKjfPO23TSmT26teZHF95O10uHxAC2TyShrPMU39q6MdwzGIHYn7/fISfQTWvC6lfygsWno1IQmVur2WFgkX4olHBPQucWaG336BUdvVxBbAHawskP6vf7+AjR2r+ZW3BcBI5I8Ze69VeU1RZ/dH4V6HzX4QRvArKVYIDCaGJuyhq08hZvXWT7g//HD9XfOYDvnmBz1T+Shh2rPwnDS1055oL4OPH6DlmO6ddxidGMUito5KZXQf7XPhVcPLZXl9qRKw3GSw58Jwyr6af7FbyvxQez+sw4Smf7CKWhkkMOp1r6mhkRttW3jSFZlgbOLBudAHx5O1aT/yaRemiDvOpJuSqj7QxZAV5n0bCF8rMRXtuazwWaO0yDxtJS2AXt0dysyeLWCTpCfE4GSmpMtOivqR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(40470700004)(70206006)(30864003)(2906002)(8676002)(7696005)(70586007)(8936002)(40460700003)(41300700001)(4326008)(426003)(336012)(2616005)(186003)(5660300002)(44832011)(36860700001)(478600001)(83380400001)(86362001)(47076005)(40480700001)(1076003)(356005)(81166007)(26005)(36756003)(82310400005)(54906003)(82740400003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 19:27:37.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a702e6d1-b8a7-4f22-b3ce-08da8c500785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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
Cc: alexander.deucher@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Fix the instatiation sequence for MPC registers and add a few other
missing register definitions that were ommited erroneously when copying
them over to enable runtime initialization of reigster offsets for
DCN32/321

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 216 ++++++++++++------
 .../amd/display/dc/dcn321/dcn321_resource.c   |  24 +-
 3 files changed, 166 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index ef0a6d468a10..9d3b8568351e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -461,22 +461,17 @@ static const struct dcn20_dsc_mask dsc_mask = {
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
index 60d8fad16eee..4c931905223d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -222,7 +222,8 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
       SRI_ARR(DP_MSA_TIMING_PARAM4, DP, id),                                   \
       SRI_ARR(DP_MSE_RATE_CNTL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP, id),  \
       SRI_ARR(DP_PIXEL_FORMAT, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),          \
-      SRI_ARR(DP_SEC_CNTL2, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
+      SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR(DP_SEC_CNTL2, DP, id),            \
+      SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),            \
       SRI_ARR(DP_STEER_FIFO, DP, id), SRI_ARR(DP_VID_M, DP, id),               \
       SRI_ARR(DP_VID_N, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),          \
       SRI_ARR(DP_VID_TIMING, DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),           \
@@ -735,75 +736,6 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
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
@@ -887,6 +819,149 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
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
@@ -1121,6 +1196,7 @@ void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_par
       SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D), SR(DCHUBBUB_DET0_CTRL),    \
       SR(DCHUBBUB_DET1_CTRL), SR(DCHUBBUB_DET2_CTRL), SR(DCHUBBUB_DET3_CTRL),  \
       SR(DCHUBBUB_COMPBUF_CTRL), SR(COMPBUF_RESERVED_SPACE),                   \
+      SR(DCHUBBUB_DEBUG_CTRL_0),                                               \
       SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),                                    \
       SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),                             \
       SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),                             \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index a93dc00ebfb5..184997a5b464 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -466,21 +466,15 @@ static const struct dcn20_dsc_mask dsc_mask = {
 
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
2.37.3

