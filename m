Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190C3C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE92410E8B9;
	Thu,  6 Oct 2022 21:27:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E3A10E8B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sce7dZiLr1xOQ0tVZRit6wtTmXYVILlbE1R0fIdbUd3d9rQ2nxISA/8DnWUvRwOzpV7UfWRAmrqhw0owH1gzsGAfdpfM8u00fxD1aS2/nJsVQHGNouBMTj9JxIKj05uf7p3pS5BkgkUHCGW2+KNPCl+hKLm/OgK9krltx9tMl6og7/o88921LA/uSqvSMCx8hhr4JNeheV1qs32WZPy3J3mRKlDaIWRc/OMTcVKriaJaZ18KzBRNnaRKvmpi4X+OMGeaDdwg7fsHTJKzvzRBRO9G/iHymjA3QLFqLfu9ZIamUAxP9kMw+6RijeW0th9lY5Wj6MV7SVSesr09mklFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD7eBYVFe2hjUEo2lAjDVbc+Jc642w4QBiDlKlRTZMU=;
 b=DHiRwgXz/+dNfxH+PW4RrHGV4JC/5EEArhiRuqCX4zggiJiJNLcKVkmNcqKExlLvKHZvklsTPougUa/6ThB/D/6WWPLI931qBHRdqXs9X1vcMdUsvpUytByFeJvoMd0UonyZCMb2bKT+DNlsAXlm0QLrT6ERI90icr6Zd+1bRHU4+2vq25cociFKhKAOU2j7RJENPT7FsGGgWF+29s3TbJRJL5sNYZV81qYdjknTaGIIIBUCZ1oek331aoD40+jQd09TU4UKdeEtI9kV7IfVo2tq6qq8BiWyRAlIh4aYTSadlGyB2MMBeFDc+fEVqXLhCrj0TXgK680Ic79xiq2omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD7eBYVFe2hjUEo2lAjDVbc+Jc642w4QBiDlKlRTZMU=;
 b=hK4ujoH+PoVBgXAgfxF3LEZuMkcoRpY2ZbNe8RxBjLfsWh7walYMKqa2/f9v1KNBQ7theCTBXl2H3/x0ZCiRlItdiHjdBs6bbgZpLbfPCg0XOXkBSZAINXfPWp7OhmOXEFEH51tr/XhfU0R3xPeX+bMgPEVy2dNKWfkfEyJ5WzI=
Received: from BN9PR03CA0104.namprd03.prod.outlook.com (2603:10b6:408:fd::19)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Thu, 6 Oct 2022 21:27:44 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::92) by BN9PR03CA0104.outlook.office365.com
 (2603:10b6:408:fd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:43 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:42 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/23] drm/amd/display: Acquire FCLK DPM levels on DCN32
Date: Thu, 6 Oct 2022 17:26:38 -0400
Message-ID: <20221006212650.561923-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: d978e673-9522-42d0-ba56-08daa7e19b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGYUG45RWpwtfXO0rCjMEMWhTYyhs+DMu7DL93cVZPN78NO3CmeUj/KxOGnF8wO+gvvfRA4Hh7j3bCTGWmPz9S4AwqpGenY/wLLlMVjitxGBfy+QSeU+5z/2mqznkX0FvIuXM5s2A3FPzveJE7+Ulbaw61qYnwcR4rSmfKCsZqEHEMPcSxDv9K6wb0nXcSbbA0wbaDmPT0LYIy5N7A3ck6/OKvKehNq26XMJ1F0hn0oJ0p4C8g7fQdLZ77tRNOteuqsUvfehxmXNzKV5ZMcI5/d3C50H6XGslVNAcoN7aRv6Oz+3YBvDTHLyF/aaO+2AuLH6+ymHdg2I4YREAh+gRt4mGm5Qk+7UMjtQ2W3CX9AS7U81Atgw4h6QtoqDIkbR9hFRAHaFIhkP9dYKLp36LjVXKW9tl9y1f03PaiqSlQD5+DAJc9ELr+6Wph4N85vU/Lc49Ixuc3m8BKITzsngPACbMAB95wO3dzDur4lVMteoDcM8MXBjJlGHQtp1BXWZLyCOLDgvhsnMoQeVrDm9auw8ZQuqXHVHsrnZ5GtCbyjQD0kmeM3W1t3sFfXRatuzVc0ozUeNV+g3pfuuCpUQPFYaYgt1ynZcsY2d2DStqL54OUOilWMNP4Kxn3AuLMQmuHYQUJOEu21qczUUYUeRyCmwNrk01kzaHT6UEITx7czV8OpMkcLPNhBg1gnUJhSd3nlp6PqzT0N6+MJq3DFvJfMD/h/6KwAJp5tL8pKD+zyxNfMXt6BTzM2NI3ypWopiqrxv7mjxJpOI/xny2ybguYs7iSOK8OV4MC7O8agMFkg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(6666004)(8936002)(2616005)(41300700001)(8676002)(4326008)(186003)(1076003)(2906002)(83380400001)(70586007)(336012)(36860700001)(16526019)(40460700003)(426003)(36756003)(86362001)(47076005)(44832011)(26005)(5660300002)(82310400005)(54906003)(40480700001)(316002)(478600001)(81166007)(82740400003)(356005)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:43.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d978e673-9522-42d0-ba56-08daa7e19b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Why & How]
Acquire FCLK DPM levels to properly
construct DML clock limits. Further add
new logic to keep number of indices for
each clock in clk_mgr.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 41 ++++++++++++-------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 15 ++++++-
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 96d5e0d5b3ce..99ae3255dcb9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -156,7 +156,7 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	unsigned int num_levels;
-	unsigned int num_dcfclk_levels, num_dtbclk_levels, num_dispclk_levels;
+	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
 
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
@@ -180,27 +180,28 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	/* DCFCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_DCFCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
-			&num_levels);
-	num_dcfclk_levels = num_levels;
+			&num_entries_per_clk->num_dcfclk_levels);
 
 	/* SOCCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_SOCCLK,
 					&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
-					&num_levels);
+					&num_entries_per_clk->num_socclk_levels);
+
 	/* DTBCLK */
 	if (!clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch)
 		dcn32_init_single_clock(clk_mgr, PPCLK_DTBCLK,
 				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
-				&num_levels);
-	num_dtbclk_levels = num_levels;
+				&num_entries_per_clk->num_dtbclk_levels);
 
 	/* DISPCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_DISPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
-			&num_levels);
-	num_dispclk_levels = num_levels;
+			&num_entries_per_clk->num_dispclk_levels);
+	num_levels = num_entries_per_clk->num_dispclk_levels;
 
-	if (num_dcfclk_levels && num_dtbclk_levels && num_dispclk_levels)
+	if (num_entries_per_clk->num_dcfclk_levels &&
+			num_entries_per_clk->num_dtbclk_levels &&
+			num_entries_per_clk->num_dispclk_levels)
 		clk_mgr->dpm_present = true;
 
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
@@ -383,7 +384,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			/* to disable P-State switching, set UCLK min = max */
 			if (!clk_mgr_base->clks.p_state_change_support)
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
 		}
 
 		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
@@ -634,7 +635,7 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
 	} else {
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
@@ -650,22 +651,34 @@ static void dcn32_set_hard_max_memclk(struct clk_mgr *clk_mgr_base)
 		return;
 
 	dcn30_smu_set_hard_max_by_freq(clk_mgr, PPCLK_UCLK,
-			clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+			clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1].memclk_mhz);
 }
 
 /* Get current memclk states, update bounding box */
 static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
 	unsigned int num_levels;
 
 	if (!clk_mgr->smu_present)
 		return;
 
-	/* Refresh memclk states */
+	/* Refresh memclk and fclk states */
 	dcn32_init_single_clock(clk_mgr, PPCLK_UCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz,
-			&num_levels);
+			&num_entries_per_clk->num_memclk_levels);
+
+	dcn32_init_single_clock(clk_mgr, PPCLK_FCLK,
+			&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
+			&num_entries_per_clk->num_fclk_levels);
+
+	if (num_entries_per_clk->num_memclk_levels >= num_entries_per_clk->num_fclk_levels) {
+		num_levels = num_entries_per_clk->num_memclk_levels;
+	} else {
+		num_levels = num_entries_per_clk->num_fclk_levels;
+	}
+
 	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
 
 	if (clk_mgr->dpm_present && !num_levels)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index d9f1b0a4fbd4..591ab1389e3b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -95,10 +95,23 @@ struct clk_limit_table_entry {
 	unsigned int wck_ratio;
 };
 
+struct clk_limit_num_entries {
+	unsigned int num_dcfclk_levels;
+	unsigned int num_fclk_levels;
+	unsigned int num_memclk_levels;
+	unsigned int num_socclk_levels;
+	unsigned int num_dtbclk_levels;
+	unsigned int num_dispclk_levels;
+	unsigned int num_dppclk_levels;
+	unsigned int num_phyclk_levels;
+	unsigned int num_phyclk_d18_levels;
+};
+
 /* This table is contiguous */
 struct clk_limit_table {
 	struct clk_limit_table_entry entries[MAX_NUM_DPM_LVL];
-	unsigned int num_entries;
+	struct clk_limit_num_entries num_entries_per_clk;
+	unsigned int num_entries; /* highest populated dpm level for back compatibility */
 };
 
 struct wm_range_table_entry {
-- 
2.25.1

