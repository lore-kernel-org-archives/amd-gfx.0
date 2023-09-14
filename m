Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E452CEE021A
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D4910E222;
	Thu, 14 Sep 2023 02:01:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C33E10E222
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZShhKxi0ZIjbqDTuyZ5W6jnbEVO3SMFIIjUz4juv/YNeK+rXMowy9BzN6vfvPOPGKsA9AZ/xiVmi1MvQEpxjhiNILJvBi78xHncraz+sHKtlcJCo/bEBgh74GuA4ilrwMakt23caaK3gXy93lG8l7fLwVU/Gf2VG4dXN7jsZhZ/MN4YO9jdcMSqc4dhLtsPMR/x2hB4nfCyGH2MU0brCFwo1cr+ZPk/uaxDmMTiQX6OE/zZ1wwAvaLj4xWFk5a/ZzjFpHhD99xXQuZTHE9NrmpUolk6lsUNggSMgFcEX07p/TNnquN2CSzuj48OKJYJy0u9j9oPAiA2KNBuSDmVC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM0wlPv2jjgYY2hs3QT+bHGVesVoKiieMRTWrDfppIQ=;
 b=h1nwqej5lteoxPsWTkVIhrbaJ5UNaXLwnuItymcaxyANw7BdDYvbTEVviQWhQLCt6CfIAB4KfUDEQiUq93YpNnivHzPt8ky3OC0V6ttG6TD/iUCX5W8sd/GBVy3ajwMuwnf81cJVqSDUu5vOT9OaP5Nl/MQJ3Ms46kHiZBRVzLq6EmStol17bHlBwpEVxa4QL1jlR52B2KvIshBENS7Ea5pnpqwU+4Vkrf93bP0qYRWy0ykYL3p27WhugrnbfW8Phk5IX54Epc636HvRTAs2vFZwawuu8WlwJ7NyZ3QaLhooBE0tTTJYSgEfvYFSa78ZChMPw4eUMAX2hQY728NC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM0wlPv2jjgYY2hs3QT+bHGVesVoKiieMRTWrDfppIQ=;
 b=Isue08yJ+V6d9wyiEJSDRdLeoYOfZuIoXJWTKfjBYKrs7Bd385ptD26ZWTJN9/uvuJTnQ2E9uUfcDi51jLHKJB5fHDyJlQb/qSyoFgWfCSI9ndhVSGpMH2sYzfs+iu+HeQ4yq0pzQLIi0MwO1yR56fxAdb4GoPu4QXRhhu1Lck8=
Received: from SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) by BY5PR12MB4951.namprd12.prod.outlook.com
 (2603:10b6:a03:1d2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:01:47 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::8f) by SN6PR2101CA0020.outlook.office365.com
 (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.6 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/28] drm/amd/display: Correct z8 watermark mask
Date: Wed, 13 Sep 2023 20:00:06 -0600
Message-ID: <20230914020021.2890026-14-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|BY5PR12MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f003d79-d2c6-4809-ba2b-08dbb4c68dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ub3379Zt6+Gd/0ZefMg2+SW0hAlYZkj7iyxybC5U9VkymJ3J0lhVrbLqvqg++LPLNnjPhmxP6FUByEIGuS/Z3pDWotsX0WF/u3h9lLjSHU5cvASOrkxRbLFBb3lDg9yUGgL1UuZhunuXpFxUczbS4zCzLEid59jbTbkmq1tUgXpvKB2QEeNFXswAXTeH/BPSmajPWg+8SGz/YjSKZRlNf60TMU1NfIgORY7ZAEEse6pXQfi09drVYJvaDtYGLiJT4q55zjLe/arb6UogbTH0tsFmMvmJhGIzI3zFyEcy2Ixj1dLoNioaRsmg9wWVUPoqmfmX8so5zZKFL2BLX5AT7526Lz8vaOHaoVLDwQefGSaIX2vrQ8eHJ07pZtLBNuk67k8g39b/cGN8DJzzODRZtLvyI0uve+hBSAVuiT6spapdvYf00j8PgKOWhh/bZ5rElhnK8sexH+bUOjta9f7cXUQ23F0JXzj1LxMPbQcGXx9cTHMMouQtWxVZjYoPKCVbnkrTfuYZjpqOtLEBwp2VNCAtKg4UTyM/1SRsmwS1zhzEKa1HfByt1tzIsb4zErZBFrXSVfAflXWs2piymE85SjhkjcTQenxeaniRxa5hr2uHKvpcs8qvLcAlCMRNUO0rXFNHNjG0D1CL2nJBFX2dTBiyo3UTSwYmIiHcA7IqgV7Zvpe4U1A0g0+8P4QunaoWzUDX/P6o7kNUOvhZnXyczTUhqjJBklb15vB2aSWC2Djmj8SC7goJnSO0KUgiXEnu/O8OoL0xZNhOmi0ngZ3Apw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(478600001)(6666004)(336012)(426003)(83380400001)(26005)(2616005)(41300700001)(1076003)(316002)(70586007)(2906002)(70206006)(8936002)(5660300002)(6916009)(8676002)(54906003)(4326008)(36756003)(86362001)(36860700001)(47076005)(356005)(81166007)(82740400003)(16526019)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:47.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f003d79-d2c6-4809-ba2b-08dbb4c68dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Correct z8_watermark mask from 16bit to 20bit. Also, do not set dcn35
dprefclk in clk_mgr_construct.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c |  2 --
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c  | 16 ++++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index ca6ce13921a7..b258eb37a859 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -930,8 +930,6 @@ void dcn35_clk_mgr_construct(
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn35_read_ss_info_from_lut(&clk_mgr->base);
-	clk_mgr->base.base.dprefclk_khz =
-		dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn35_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index e9b1734e0c67..a0dc2e0c79c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -124,7 +124,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_A calculated =%d\n"
@@ -140,7 +140,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->a.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->a.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_A calculated =%d\n"
@@ -158,7 +158,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_B calculated =%d\n"
@@ -174,7 +174,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->b.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->b.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_B calculated =%d\n"
@@ -191,7 +191,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_C calculated =%d\n"
@@ -207,7 +207,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->c.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->c.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_C calculated =%d\n"
@@ -224,7 +224,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_D calculated =%d\n"
@@ -240,7 +240,7 @@ static bool hubbub35_program_stutter_z8_watermarks(
 				watermarks->d.cstate_pstate.cstate_exit_z8_ns;
 		prog_wm_value = convert_and_clamp(
 				watermarks->d.cstate_pstate.cstate_exit_z8_ns,
-				refclk_mhz, 0xffff);
+				refclk_mhz, 0xfffff);
 		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, 0,
 				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, prog_wm_value);
 		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_D calculated =%d\n"
-- 
2.40.1

