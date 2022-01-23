Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD2C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBD910EA26;
	Sun, 23 Jan 2022 18:21:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F43F10E97C
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTGKsszHWQ8fTRc3EhiDl8mCW4HZ0RnTJ/NoIyEuB9VWIntGpPBRmWFrIDnWy5xY6OxjkCccnp44W5tzTyzm2uBaoxwTikzWppi+ZayGoEea4bpeb9HCp/AzaS8BiGKkP8zAxQ6/JSciZlf6NCLCm5aAd4fGuIKmUqr24ZOdEuPFZCNrqPUBnrzYNT0kqbE0aTstNG6mWgcxdtG9WH765P2KsTOn4N+EYeshQmZzS5rGyUIoTXtP9TlxmqGgzG7rIbJ+pVPyngdAzdHjqTFNp2h3yTFPkDckyFDhiLbqzo3wlT39OiDFEK031ofR7EiGc8aCm4Ca9SMl5Vd9XyxY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTckP0dxsQNvBPy1+DHseBaRJRjs4AT80C5GA38Gn9Y=;
 b=QhYRqSTjKoEG6/EHbaE0qNTyxVhyEnlSAa3nM0Jc+lue9E89TWJnSNpKc/UCeYJWG0lT6sa2geXj8lBC++KezjYNPTR5S4ulNhlfKARvtJ+P2bsPd9eD9r5ea/vGS+TEw6y9UFr0LSyR1x6+nBJJZ7td35t5shoodEwmJDPB79SjUWODEoTXzW9ORkNTV9kTD6l+1cZd2tOZ++QGnA83QCQUpSGKFM5dbAiUW5VVzjvB6yP6SnMCkj21tgdufqq8+zp3ujg3t7sH9z9AMycUVTXTXheMLSQZRzKz+Fid88SDCBDtahCqpDHU75pcXtKKb9dMRUPWw2JGrbGPLHTPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTckP0dxsQNvBPy1+DHseBaRJRjs4AT80C5GA38Gn9Y=;
 b=o/DCh8RomC44bbjmR7ggZHgTvw4XUkSQDs7Et5LvuPQCX+oYouYtJO37MFndVUnlOZ8OC09iKE0AkDdfyO1DDBZGyxjavWkbRIsFjLL4Psj7xS0fhh4E+89L3CfvMtGap9ui5CDp079Zt5fR/MYCf0K42QoaQIvcP77BfhfH6TY=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 18:21:17 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::7b) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:16 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:14 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/24] drm/amd/display: Fix disabling dccg clocks
Date: Sun, 23 Jan 2022 13:20:18 -0500
Message-ID: <20220123182021.4154032-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8396bf1-2e60-467f-3830-08d9de9d2542
X-MS-TrafficTypeDiagnostic: BY5PR12MB4917:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4917A1801236F309EF1A9E8A985D9@BY5PR12MB4917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmXaHx7P9ems54vOniwv8YI9S2Ia0DoB+LA3Q6imh6x25YrLDJPkzV0ovbRxCZveTyUOSiZ1j5eE5h+zP9CkrI5g2O3kHt4TsYglqd1CiZjoEQK8Oqi/lnMux5mJfCXrQ9G2lSTZDiY+xVpaTTcy8Dc512ytySm3FsHDpbOMPpRCwnjBSY6gIV/pUutQF+yw4JFBfZr6JX6UPj240ZmCvLuP70EPwtHHiroojzHJUBA0oAfMmKnRq2/tiI/exf8HI5B5e5hZDKcqIWac9AUBbyS27OPozXFqsckaOaLQY9BgOOs1YCGN6njkaypMWUHUyj25SzAx5LUyGPEznS2p5ebhAbuYkfiiUxS8geP0tY3Wfm0WB2ziLMS3A0tbGDXIfcMkKRcTyaq0arKz9VvOH/ajOWvPMvrHl0YZl6m6SVocTmfiJL54wbYvVdKh9PSCO0/JBoc6dLVrsRiIxhpZ0qa53gKlayrPp1gb5uK4+c7aD3a1lxqCXd2Op2Z8FUAgMzzdKG3ZwlXsuFvA+mz58wKnBWvc1asK2Bp0QzXBHzrpQP44lvz7c6LFm+QnWvlgYac471nJ4QsCXZoG3MioxILAKRIsZvRZvJNaJIsYrxGAkBP/eLWN7Pi7m7u0aBSDSLla2kVyaOSEMovsH+aFtZ+agdyIoLnGGxFxzeN8V3fEj4iJgQxt8j28JNwkWPHAmok0wpo1OSmr7BQBYE0Hrq2H/xAS4cx2/427aS3TZzMeNtZqzYxTmuqdFPDa97lfR8Nbxtlp2X4Jy3OFQxvHDs9GT0m/C77r0KdkSyuio4k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(426003)(2616005)(4326008)(5660300002)(2906002)(70586007)(40460700003)(47076005)(26005)(81166007)(54906003)(36860700001)(356005)(83380400001)(8936002)(8676002)(1076003)(6916009)(86362001)(186003)(36756003)(16526019)(82310400004)(316002)(336012)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:16.5495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8396bf1-2e60-467f-3830-08d9de9d2542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[How & Why]
Updated procedure to match hardware programming guide.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  7 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 44 ++++++++++++-------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  1 +
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index f98aba308028..493c47a3d06e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -183,8 +183,14 @@
 	type SYMCLK32_ROOT_SE1_GATE_DISABLE;\
 	type SYMCLK32_ROOT_SE2_GATE_DISABLE;\
 	type SYMCLK32_ROOT_SE3_GATE_DISABLE;\
+	type SYMCLK32_SE0_GATE_DISABLE;\
+	type SYMCLK32_SE1_GATE_DISABLE;\
+	type SYMCLK32_SE2_GATE_DISABLE;\
+	type SYMCLK32_SE3_GATE_DISABLE;\
 	type SYMCLK32_ROOT_LE0_GATE_DISABLE;\
 	type SYMCLK32_ROOT_LE1_GATE_DISABLE;\
+	type SYMCLK32_LE0_GATE_DISABLE;\
+	type SYMCLK32_LE1_GATE_DISABLE;\
 	type DPSTREAMCLK_ROOT_GATE_DISABLE;\
 	type DPSTREAMCLK_GATE_DISABLE;\
 	type HDMISTREAMCLK0_DTO_PHASE;\
@@ -233,6 +239,7 @@ struct dccg_registers {
 	uint32_t DSCCLK2_DTO_PARAM;
 	uint32_t DPSTREAMCLK_ROOT_GATE_DISABLE;
 	uint32_t DPSTREAMCLK_GATE_DISABLE;
+	uint32_t DCCG_GATE_DISABLE_CNTL2;
 	uint32_t DCCG_GATE_DISABLE_CNTL3;
 	uint32_t HDMISTREAMCLK0_DTO_PARAM;
 	uint32_t DCCG_GATE_DISABLE_CNTL4;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index ea4f8e06b07c..720bd35582b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -121,7 +121,8 @@ static void dccg31_enable_dpstreamclk(struct dccg *dccg, int otg_inst)
 		return;
 	}
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
-		REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+			DPSTREAMCLK_GATE_DISABLE, 1,
 			DPSTREAMCLK_ROOT_GATE_DISABLE, 1);
 }
 
@@ -130,8 +131,9 @@ static void dccg31_disable_dpstreamclk(struct dccg *dccg, int otg_inst)
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
-		REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
-				DPSTREAMCLK_ROOT_GATE_DISABLE, 0);
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				DPSTREAMCLK_ROOT_GATE_DISABLE, 0,
+				DPSTREAMCLK_GATE_DISABLE, 0);
 
 	switch (otg_inst) {
 	case 0:
@@ -180,7 +182,8 @@ void dccg31_enable_symclk32_se(
 	switch (hpo_se_inst) {
 	case 0:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE0_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_SE0_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE0_SRC_SEL, phyd32clk,
@@ -188,7 +191,8 @@ void dccg31_enable_symclk32_se(
 		break;
 	case 1:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE1_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_SE1_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE1_SRC_SEL, phyd32clk,
@@ -196,7 +200,8 @@ void dccg31_enable_symclk32_se(
 		break;
 	case 2:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE2_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_SE2_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE2_SRC_SEL, phyd32clk,
@@ -204,7 +209,8 @@ void dccg31_enable_symclk32_se(
 		break;
 	case 3:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE3_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_SE3_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_SE_CNTL,
 				SYMCLK32_SE3_SRC_SEL, phyd32clk,
@@ -229,7 +235,8 @@ void dccg31_disable_symclk32_se(
 				SYMCLK32_SE0_SRC_SEL, 0,
 				SYMCLK32_SE0_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE0_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_SE0_GATE_DISABLE, 0);
 		break;
 	case 1:
@@ -237,7 +244,8 @@ void dccg31_disable_symclk32_se(
 				SYMCLK32_SE1_SRC_SEL, 0,
 				SYMCLK32_SE1_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE1_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_SE1_GATE_DISABLE, 0);
 		break;
 	case 2:
@@ -245,7 +253,8 @@ void dccg31_disable_symclk32_se(
 				SYMCLK32_SE2_SRC_SEL, 0,
 				SYMCLK32_SE2_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE2_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_SE2_GATE_DISABLE, 0);
 		break;
 	case 3:
@@ -253,7 +262,8 @@ void dccg31_disable_symclk32_se(
 				SYMCLK32_SE3_SRC_SEL, 0,
 				SYMCLK32_SE3_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_se)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_SE3_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_SE3_GATE_DISABLE, 0);
 		break;
 	default:
@@ -275,7 +285,8 @@ void dccg31_enable_symclk32_le(
 	switch (hpo_le_inst) {
 	case 0:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_LE0_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_LE0_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE0_SRC_SEL, phyd32clk,
@@ -283,7 +294,8 @@ void dccg31_enable_symclk32_le(
 		break;
 	case 1:
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_LE1_GATE_DISABLE, 1,
 					SYMCLK32_ROOT_LE1_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE1_SRC_SEL, phyd32clk,
@@ -308,7 +320,8 @@ void dccg31_disable_symclk32_le(
 				SYMCLK32_LE0_SRC_SEL, 0,
 				SYMCLK32_LE0_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_LE0_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_LE0_GATE_DISABLE, 0);
 		break;
 	case 1:
@@ -316,7 +329,8 @@ void dccg31_disable_symclk32_le(
 				SYMCLK32_LE1_SRC_SEL, 0,
 				SYMCLK32_LE1_EN, 0);
 		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE(DCCG_GATE_DISABLE_CNTL3,
+			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+					SYMCLK32_LE1_GATE_DISABLE, 0,
 					SYMCLK32_ROOT_LE1_GATE_DISABLE, 0);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index a013a32bbaf7..4039273872be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -66,6 +66,7 @@
 	SR(DSCCLK1_DTO_PARAM),\
 	SR(DSCCLK2_DTO_PARAM),\
 	SR(DSCCLK_DTO_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL2),\
 	SR(DCCG_GATE_DISABLE_CNTL3),\
 	SR(HDMISTREAMCLK0_DTO_PARAM)
 
-- 
2.25.1

