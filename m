Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA90EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C0410E5BC;
	Wed, 12 Jul 2023 17:14:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7FF10E5BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpYdXgAEkyDW5Gf/jOgDwT5Cakawc422gRKHF18wvFFPcx0PWhuAPbObRm46mNIh60/QKaLUyPSYcRSto4fc9k69ZlFQ7Qjb0rA/gHrt/UUTAasIW9NuUlhWRtHhCZrlTPToy5xpyhREVA0/dDXm2mr/FBFlo8zzDhzDBHV9BmHkQyK34BLGgSrg1lAv0uJRcWSDH0/xl5NZNAk17tid8T+fkOdVCF+Yee+0FjyEv+K4iEP5xL4SJWUE1/GbSn8xFk8dBCRzYb1yq/OaVp7mzQRgkU9/qfmfu2NekXOuKCSvRrG9UphjtPUyI553XlJwQZZEF/fzRTYb5pdpgna+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4jFeSrqpj3i1K4HmhF6AorDTiAi/ZCZSufl/jSlKzE=;
 b=el2gvusyXde4fRYrbEO9Nj72T39bwqZoz3zCzeMyUgIXrEyizSQJ4TdcNKCyQdccarofmAHWVb6RO2wTzzuiCGPX1bWZwfDNOYUtV2rThA9jTE9D3Z295XTA54OJKAYDJ+5MSjDHeHeoJtMgw25fxAIoLHqDEBscclWwfa2ispG99+mQ8CWM7aWrTv/3FHRwcoEqZ9v3if97NXZRpTyjT1OnXave2LQv1wSnU/Xp1lXQpb2VDCGQm9T1hpGTTvUJzbsSc63PPviQaAKf4fRgEQ3W3XukckByMY0Zy8FlD2zBgfdXHwcEuoOwBoO9qodZQVD2LUyLxRZW+g+EU3L5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4jFeSrqpj3i1K4HmhF6AorDTiAi/ZCZSufl/jSlKzE=;
 b=0pII9c2WTZn8Iad8ra4Vp1FO7vun6DRyR9GH8sIxEZbwwkVCvPCFRBzTto1vqa60wMOJGAbCRkVPAHoj8kyM+wxMX+6OFqWpFfoeWRv40MlvZss5XtnVxwe32emwU7BtUlGt7QFlW3RseQ0SyWrQ9/D4/BqL216ObZvIJJ5lvjk=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:14:31 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::6d) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:30 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:26 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/33] drm/amd/display: Fix DP2 link training failure with RCO
Date: Thu, 13 Jul 2023 01:11:32 +0800
Message-ID: <20230712171137.3398344-29-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a360c42-3032-4aa0-4003-08db82fb74c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jJzVyyDtUI6a87WYV7ZTy/SOfKhI3XtqoFQgrpf2jS4FiLouzF1y9xUa01ognCPo1RtdxLE48mDI9XmXXbSfAySfYWE8TQjIJDaPV1FUfA63/HCxT3Ff3mUsrvf2YHdU0qY36wMOBakRLo4OSvSGmlEfq9VHjtYkpQo5KdD+5YJNxHxAKx+2dB2zboQF94c6k8xMTMDdYpsWDUe67aCHOZAAePGoLeFC14APpqMapaY1rBJDwrZKqoI4x/dkpn4xP3+wssK12NgjeaJkq1m/Phuhc75EpPm2K0lkIfWG4GyzCR6U4bzk66foP1NkiN1jKbJSH6GFEGQ+F+oDhXCBHAqZt8uwwc8KGzsM9fhzGicd4bPbwlOpp+M19hnoyAQsYMrvFRqXhJz2fgDVaaaQK5mHpTj9dwC5lPqeMF0w++KngpKNbecQhyK9s0XbWAMEImEL1zbQnLhgsfx0MmPgMSlD31mD9TnvCrf/IFemHyd7geT87l81Lv1feCnkqEQNcZIvTdAIq9gkitCBV2zPPjnwFXrrSQ7EjTE/5vJT6YgoiiP08lnR4gx5iQO4YEodV3tr/E6yQhAdbiI8h7RkKcA841sJgHgY+UddqDihcH2oYGFY/B29j6ENOI574d25saI2AOf55tXkylLCtcofj8NaceFrhXmYSkqOrf6aLj2hTmanFgGzDBznF9c964D4nIS1P39lbwGEAZhj3qyNEFXtPR6TQQVJZnBZcWJ4EiBLvLBeh/3ECsK1Pm9Nip4z9R36JKmjfGYH/hTptYkhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(6666004)(36860700001)(47076005)(186003)(1076003)(26005)(426003)(83380400001)(336012)(36756003)(82310400005)(2616005)(86362001)(81166007)(356005)(82740400003)(40480700001)(4326008)(70586007)(70206006)(6916009)(2906002)(41300700001)(316002)(8676002)(8936002)(54906003)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:30.9746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a360c42-3032-4aa0-4003-08db82fb74c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <haoping.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
When RCO is enabled for symclk32_le we get failures during
DP2 link traing compliance tests.

[How]
Break out symclk32_le RCO into a separate function that is
called for hpo when link is enabled/disabled.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 49 +++++++++++--------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  5 ++
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  5 ++
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   | 10 ++++
 5 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 65c1d754e2d6..96b73d79f980 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -284,19 +284,11 @@ void dccg31_enable_symclk32_le(
 	/* select one of the PHYD32CLKs as the source for symclk32_le */
 	switch (hpo_le_inst) {
 	case 0:
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-					SYMCLK32_LE0_GATE_DISABLE, 1,
-					SYMCLK32_ROOT_LE0_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE0_SRC_SEL, phyd32clk,
 				SYMCLK32_LE0_EN, 1);
 		break;
 	case 1:
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-					SYMCLK32_LE1_GATE_DISABLE, 1,
-					SYMCLK32_ROOT_LE1_GATE_DISABLE, 1);
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE1_SRC_SEL, phyd32clk,
 				SYMCLK32_LE1_EN, 1);
@@ -319,19 +311,38 @@ void dccg31_disable_symclk32_le(
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE0_SRC_SEL, 0,
 				SYMCLK32_LE0_EN, 0);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-					SYMCLK32_LE0_GATE_DISABLE, 0,
-					SYMCLK32_ROOT_LE0_GATE_DISABLE, 0);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLK32_LE_CNTL,
 				SYMCLK32_LE1_SRC_SEL, 0,
 				SYMCLK32_LE1_EN, 0);
-		if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
-			REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
-					SYMCLK32_LE1_GATE_DISABLE, 0,
-					SYMCLK32_ROOT_LE1_GATE_DISABLE, 0);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+void dccg31_set_symclk32_le_root_clock_gating(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+		return;
+
+	switch (hpo_le_inst) {
+	case 0:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				SYMCLK32_LE0_GATE_DISABLE, enable ? 1 : 0,
+				SYMCLK32_ROOT_LE0_GATE_DISABLE, enable ? 1 : 0);
+		break;
+	case 1:
+		REG_UPDATE_2(DCCG_GATE_DISABLE_CNTL3,
+				SYMCLK32_LE1_GATE_DISABLE, enable ? 1 : 0,
+				SYMCLK32_ROOT_LE1_GATE_DISABLE, enable ? 1 : 0);
 		break;
 	default:
 		BREAK_TO_DEBUGGER();
@@ -660,10 +671,8 @@ void dccg31_init(struct dccg *dccg)
 	dccg31_disable_symclk32_se(dccg, 2);
 	dccg31_disable_symclk32_se(dccg, 3);
 
-	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le) {
-		dccg31_disable_symclk32_le(dccg, 0);
-		dccg31_disable_symclk32_le(dccg, 1);
-	}
+	dccg31_set_symclk32_le_root_clock_gating(dccg, 0, false);
+	dccg31_set_symclk32_le_root_clock_gating(dccg, 1, false);
 
 	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream) {
 		dccg31_disable_dpstreamclk(dccg, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index 0902ce5eb8a1..e3caaacf7493 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -179,6 +179,11 @@ void dccg31_disable_symclk32_le(
 		struct dccg *dccg,
 		int hpo_le_inst);
 
+void dccg31_set_symclk32_le_root_clock_gating(
+		struct dccg *dccg,
+		int hpo_le_inst,
+		bool enable);
+
 void dccg31_set_physymclk(
 		struct dccg *dccg,
 		int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 0746ed31d1d1..ad3f019a784f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -362,6 +362,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.disable_symclk32_se = dccg31_disable_symclk32_se,
 	.enable_symclk32_le = dccg31_enable_symclk32_le,
 	.disable_symclk32_le = dccg31_disable_symclk32_le,
+	.set_symclk32_le_root_clock_gating = dccg31_set_symclk32_le_root_clock_gating,
 	.set_physymclk = dccg31_set_physymclk,
 	.set_dtbclk_dto = dccg314_set_dtbclk_dto,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 8dc804bbe98b..93592281de32 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -123,6 +123,11 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			int hpo_le_inst);
 
+	void (*set_symclk32_le_root_clock_gating)(
+			struct dccg *dccg,
+			int hpo_le_inst,
+			bool enable);
+
 	void (*set_physymclk)(
 			struct dccg *dccg,
 			int phy_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index 586fe25c1702..dc1cb5478e08 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -108,6 +108,11 @@ static void enable_hpo_dp_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
+	if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
+		link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
+				link->dc->res_pool->dccg,
+				link_res->hpo_dp_link_enc->inst,
+				true);
 	link_res->hpo_dp_link_enc->funcs->enable_link_phy(
 			link_res->hpo_dp_link_enc,
 			link_settings,
@@ -122,6 +127,11 @@ static void disable_hpo_dp_link_output(struct dc_link *link,
 		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
 				link_res->hpo_dp_link_enc, signal);
+		if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
+			link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
+					link->dc->res_pool->dccg,
+					link_res->hpo_dp_link_enc->inst,
+					false);
 }
 
 static void set_hpo_dp_link_test_pattern(struct dc_link *link,
-- 
2.34.1

