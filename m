Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7FECD6E77
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DB511284D;
	Thu,  4 Jun 2026 14:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nLax5M9Y";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB78112841
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkAM+0P0Z6q6z+YM+s6kbTeCnS44LYv6WhivrpPDxzR687rVmjql9y/g5peg3fiJPRnaMQcKq7WiXYhl4A0kCNwDrwdbMLfzNuG4IA9TInTGQE+soFgRVsAYq4/PtBZ23aIwM3IFVhAJHqdXheugr+z8SxXt7eMTuGoBmkeHmaTTnW+XsNPuXeDx4b23y9MP/p/2KLam5KYzzhWgw96pfpHeZsgSgkz7Yv+2uX4Y5fIMkwMQpiEKjCVVyMpoUcL0IIgs9HO6wXJzmsZWriWCYtfN/7oiN7CO6mHEqPttBoP04SDSu0aID48UnmhJ2cWDRi2v1X15UUHWp/XzOH9mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nz8COj+D2vMgGwSq/gU6CS8B7qafsbEILJC+lum/oY=;
 b=ixvM+w5KlqJwJPfzKqucxRjXYQzJTWbnapCvv4Y0FIhQPLVHamEBTlv8N97l2WVMGB9oDM9LZ94wOZJ311sF8FMcbhyDHNvUgaJeO5XvwbjoF2KIMiSADY3TIom6ACxq19R3KZ+9Pc/FvXKMbndb298Y0CUWgoqojj0tnX+5d4BLknNxeQz1+kVOBuKwOp17YlqFd1jKq/gyfW/vmAVSwj61F4xzc9XIceQsqcPO5m2Y0ZitJOkwBZgLcvy6b0jJ+Y2M27SwaCKMMeYNFIXIDMCnlOoVW8TXFZ0NoGfWOegwkNAcUrVhJj9OxsCIGTGg+C3m41iEyQI4908KwlBpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nz8COj+D2vMgGwSq/gU6CS8B7qafsbEILJC+lum/oY=;
 b=nLax5M9YtNOUSm778nxNEne82tcJ9eZtt5RuESafOl/omBfSdHGOSzEm/b4x0qwNqgrUR6cwXtozVod4VXcIM6Y3TZg6Lubtr6vH8nq00N3bLh+t6kNcRySpU7JHOSiJCggYTqm6Bzv/ibDHxHpgNhLwQDxd85jnjyqwVGAvSXk=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:54:57 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::68) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 14:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:47 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Temp disable repeater FGCG as
 workaround
Date: Thu, 4 Jun 2026 10:51:58 -0400
Message-ID: <20260604145428.809959-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 615b34e7-dea9-4315-cc9e-08dec2493eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kyY2WNQTXm3hkw88P7xABh2JyLlHHAOA8Trb0+pXza9bZ9oNmB47jvJQ1oHI/IDM0i8o5xf/kTeFHPDp1WBwG2WQJO8tRM7rhbsg8+lNLEFNShPwhAxgHSb9X8d8fcYL2XA5lOLkIeKilILZGfo+upCFrLrKkqokEUXzf/GEzuo0OJ/v92ON1sAV3pMizaM+G+/+mK2zI24WILYUZuKP9uTNAI9XWr+XFv70+RZszWBY+MV2rcoDnB/PG7lYn2Ez/b/33Z+14KOkC5/wBhrdCoy+wg3JulQtcc5QlvdQyUyTEDOMFZnEaUbrqfE0KyQeidelxplZHauvTBnqh39DwIbgTChucC2BpzYuZ1jrhmBnkgPDUpE8MmDZ2YesrHzB4dv8wPTVDFaHsDwdL+P91pNFNIMURMRdVsuLFVgRsFL3JR5FYROicEopMQln4ksxk0Y2DqXve+kYDJtRzM3iw+rfwNQhVh+IgT8XvRw3mbttAQeke9kqO5EquYEox+kTuzWutgzBI9p8N1RN8umRLvBgJZlMqs5YvUn+32JIcju6pY1YPrWoKVbPNMotzatxPyLWDjJ6Jzo3TiR4liFoY41aNz+g7BK2RGrWFFW/1oJ0AwjfSfUuNIb7+rLerI0/9RTWtc3o52/HQj6sLhiNIoihD8VqEubPWQOtBuqCsi06DdjASyd9v8a4LjRwWrKxXb2QCYA4CNdiUvZTLFGZLsPwIrjz5oSRjemu8FrIe3Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uB2Se5dsIGGCSwyzEid4T5uAdPHDfdM/pVIm+r7GfQUlTbkgxUF+l3KcxjYgsw4Y4F5n5ZKblBH9htMZHFWzlkCREZEFWyGcihd6LjYk9vXFMHWo97TTGypLAxPP6/fik/xbN/voMjz2CyXXF/GtbQC2nK0nn8FFW83iGZJ+rmYJpqBHG6AA0ZHKAL1tGQAM0zhUgcH2NG1grd5R+IlooJXxM/GzoUmTglXXpmo8oL5z9IGX9r/cLHsllgE2XABdkh2Xp07ZOjXX+Y8DeG+XPpNS26rsawSLG44DeMAlRth1bVF2hRwvK/NA93iYi3z1VEEJtXE1Rq0zLTu/NB81TnSETinXz4T4p5Jog4n+49ROpIc07rOTt46eMQ7TL3HIwsikHk2luK6dQAUMEuichLf7ARGEcUk6q/3+Xy6F6XKXz/YRKj90OSxXRA4MW3+k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:57.2934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b34e7-dea9-4315-cc9e-08dec2493eb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
There is an issue that is seemingly limited to DCN42 where systems with
IOMMU enabled will hang during reboot stress testing. The hang happens shortly
after DCN PG exit happens and HUBP is programmed for the first flip, but before
the first surface address is latched. Testing has shown that disabling
DCCG_GLOBAL_FGCG_REP_DIS, HUBP_FGCG_REP_DIS, and DCFCLK_GATE_DIS can mask this
issue.

Disable FGCG for these three repeater bits to avoid issue while debug is on-going.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                      | 1 +
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c   | 6 +++++-
 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c   | 6 ++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c  | 9 ++++++++-
 .../drm/amd/display/dc/resource/dcn42/dcn42_resource.c   | 1 +
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d5d9d56fbcb8..d74776802418 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1288,6 +1288,7 @@ struct dc_debug_options {
 	unsigned int min_deep_sleep_dcfclk_khz;
 	unsigned int force_odm2to1_for_edp_pixclk_mhz;
 	bool enable_replay_esd_recovery;
+	uint8_t iommu_mismatch_temp_wka;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index e57242f8bc12..adc453c81831 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -81,8 +81,12 @@ void dccg42_enable_global_fgcg(struct dccg *dccg, bool value)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->ctx->dc->debug.disable_clock_gate)
+	/* Temporary workaround for IOMMU mismatch issue.
+	 * Fine grain control via bit2 of debug flag.
+	 */
+	if (dccg->ctx->dc->debug.disable_clock_gate || (dccg->ctx->dc->debug.iommu_mismatch_temp_wka & 0x4))
 		value = false;
+
 	REG_UPDATE(DCCG_GLOBAL_FGCG_REP_CNTL, DCCG_GLOBAL_FGCG_REP_DIS, !value);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index e4602c3ddc66..57de98444f6c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -20,6 +20,12 @@ static void hubp42_set_fgcg(struct hubp *hubp, bool enable)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
+	/* Temporary workaround for IOMMU mismatch issue.
+	 * Fine grain control via bit1 of debug flag.
+	 */
+	if (hubp->ctx->dc->debug.iommu_mismatch_temp_wka & 0x2)
+		enable = false;
+
 	REG_UPDATE(HUBP_CLK_CNTL, HUBP_FGCG_REP_DIS, !enable);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 664004cadf10..96e0133880e1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -70,6 +70,7 @@ void dcn42_init_hw(struct dc *dc)
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 	bool dchub_ref_freq_changed;
 	int current_dchub_ref_freq = 0;
+	uint8_t dcfclk_gate_dis_value = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -243,7 +244,13 @@ void dcn42_init_hw(struct dc *dc)
 		/* enable all DCN clock gating */
 		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
 
-		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
+		/* Temporary workaround for IOMMU mismatch issue.
+		 * Fine grain control via bit0 of debug flag.
+		 */
+		if (dc->debug.iommu_mismatch_temp_wka & 0x1)
+			dcfclk_gate_dis_value = 1;
+
+		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, dcfclk_gate_dis_value);
 	}
 
 	dcn401_setup_hpo_hw_control(hws, true);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 7de12b16d7ad..eb7fe5d70264 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -801,6 +801,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.replay_skip_crtc_disabled = true,
 	.psr_skip_crtc_disable = true,
 	.force_odm2to1_for_edp_pixclk_mhz = 0, // disable the policy for now
+	.iommu_mismatch_temp_wka = 0x7,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.54.0

