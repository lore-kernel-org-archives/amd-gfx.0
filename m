Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3268C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C1410EDD3;
	Fri, 14 Apr 2023 15:54:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F51C10EDD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0K5eZfXRNxds5KzNV2HC+SJSD6PDvmUjFvQBAcGTDiGAylH+pdQ17B9K/EGE0fTm2cIdMA0gK/PHGciLKOPFOVtVjcyeBOjh74dLKl8XWrloMGlUoajaE9GpUaedpBcshpr9PmzgqoVTyArLcgXD7Lq7pdO2ubJoaKRODLsCH83U4PbTZ5wa6bQC8Vc7lm/PwevzyVPasHmKoYTczcAGGHk1wFACfQUszzTFiStkG3Oh3LGEew/5ZDGhasxLJI7JN1oZ2ugJ4rVyEY0HpyflxyQ+pspf7gfDinwIFv3yhhEpJRJEmxZZ4oSqygsqHdtFJ7n/QtLr4FwZcaB0MJmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhFK3S12H0+fZLUM1nwaDFpdi6mx5JCeYVYvCnitHXI=;
 b=FjH1ogDWJum/WHZs38jJFVFObMTE3kk1VOcoB/q3YpLpPcJ/TqPVmRtpmHF1OHB636l5QLbXXHLvOSomzqsZUN6jtQrOXS3pqoq41i2yvjjWV2ha77qdtFy84+fGDZCgeAKJrJBE+sdTOykYBEVp9BpoajWqjivCIej6vwir+j8qlkOfBjiNwe7iS48unRknqUP6QGxgTNu3f58taYNmqhpCaWKcIhiNmzUtl42N9WnES1E1QBPTOQxui1RFkB47b4+SPB6CakPiG3C5y2Q7K+6zOExR8Ld4ToLDB2OEM5xBvbtMLys7P3ybFviUUj/RggAYf8cLdDqrUy6Ath1Edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhFK3S12H0+fZLUM1nwaDFpdi6mx5JCeYVYvCnitHXI=;
 b=Wy7bVwzdV0icYUzTG54m8UTdr8nM8Kkjxuci3A4TYiNntvfPuo6WtIzKO6/JWGBqVr+5xrFhNnxB6TORiPjtOXCOWpameWTnVgqXJQPQmF/G3MVhlTgbqKnkD0ywhSZQrmSrk99ZCNoD9TyivGjHTtQy30GaJ4HJgymm3n4TBGo=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:27 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::b5) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:25 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/66] drm/amd/display: Correct output color space during HW
 reinitialize
Date: Fri, 14 Apr 2023 11:52:51 -0400
Message-ID: <20230414155330.5215-28-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5d62bd-5fa8-427d-1532-08db3d0086e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nS9klHiwKrpMRePmn6s0+imZUnveLonao6nDDYQyWoze0M0WmGbJsXnwRS4XL6ylZYsponyfe0cV1H6G4UGDtm4jsbYVyY0VOGOY8FCNge7B6oUovMR5FMkmaxiwvF/lhnwQMr/opOFWn94MtD5GhWpZ8ZJubm2uziZiz0BizsTpniGZOwJyVkjEyR4xpDHhXmuGlY0NxszYqUX91uDKuwniUrylgpN7tW3aE3OozGUv0epEw3EO3eYmCaL4Wf40PEBlMEDt9LY4yTtvhADv5QH9cyD3OM2M1WTot5l6VBXskrxthrLazkgO2rIxZYLKtvf9N34fdIk9FuuSu7FCBIEvCqRsQEbJOqCApHzLxuLVpFWPO7NQew1JGbwM1wDxU5KlYuv9SYsXLs1REinjLTk6rE83S35VU2vSGasaJlhj1EGNry0HOC/w6mdsOxWcG4AScA3jtrIO6TZbdTSMA8312ZgqwtxaNR6T6PqcjkT6WdjoLkemWRjRt0vcG+irz62cPk3h4cVoHJug5A0D6C6sxeSR/Tq9Qyi4uI7tKtMNbuMT9znLF4p2wKQwaQm+aPwnAIxYfS0eIo1KlaXiRd/m3HWIZGLHqiwSvtmM4Yob3Wf9HYe38ZoLRMEIBQ5aiDr/R05ozatr+UIJtYY0k4VikbXUoqI3+Di+0C3JHXX7/iN7QULHuWFBkEgIFLAANkLCXrJwTrGrCKFGjFP6gMxED7hCCmcpWuTwntU2u08=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(1076003)(26005)(70586007)(70206006)(36756003)(40480700001)(2906002)(6666004)(83380400001)(82310400005)(47076005)(2616005)(186003)(16526019)(36860700001)(4326008)(6916009)(82740400003)(40460700003)(54906003)(86362001)(5660300002)(8676002)(8936002)(81166007)(316002)(356005)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:27.4715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d62bd-5fa8-427d-1532-08db3d0086e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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
 Michael Mityushkin <michael.mityushkin@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Mityushkin <michael.mityushkin@amd.com>

[Why]
Doing core_link_disable_stream or set_dpms_off when reinitializing
hardware causes issue to repro with external display connected. This is
unnecessary, blanking pixel data should be sufficient.

[How]
Call disable_pixel_data while reinitializing hardware instead of
core_link_disable_stream or set_dpms_off.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Michael Mityushkin <michael.mityushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 422fbf79da64..5800acf6aae1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -313,6 +313,10 @@ void dcn20_init_blank(
 	}
 	opp = dc->res_pool->opps[opp_id_src0];
 
+	/* don't override the blank pattern if already enabled with the correct one. */
+	if (opp->funcs->dpg_is_blanked && opp->funcs->dpg_is_blanked(opp))
+		return;
+
 	if (num_opps == 2) {
 		otg_active_width = otg_active_width / 2;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 3a32810bbe38..8598ea233ef3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -58,6 +58,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 5267e901a35c..ce53339b2e10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -60,6 +60,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
-- 
2.34.1

