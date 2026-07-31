Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF8AC55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56C210F3F6;
	Fri, 31 Jul 2026 21:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+kAfMDG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E94B10F403
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/6wre7vCtI8w8MTSza1OzHlBBXYXyY2Qn2uElNYuBiuEopvosdhY0TgZvx8MKdXlX+x7EEJVZrax+j6gJrO50QXcA/d+X+OXFNSzxQcnu0mpE5gD3IP5bNgFicM7DaOwXDaffai8mWtxHXhRnuQfRWQB72ikMNUIXFiXwOCOnvSLPRuvV+XeQwGt5zpmPv9Egl7jzv9qhmrTlf4asq6I0Tu993q+jOYkLw0il4IEzCoDfSJEM0cDWcn1W/mlOWTTtjVoJB+2Jeeb/JTM7d+fNazatDIS+BC/HrdqI8jZAHbu9TXdMrDMGP9bqWzoIRKzQFeXQjjVn3UD7Q+IdM8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xb3rgV6jEOu8RSGxCa01dDwsi0ORjw6uotCr1elZG4=;
 b=xjHRyIbikkE/63OOUmYvHkLOv0Xob/3ksKw2N5B/0hDPPd/oCQwdQ02tVWm1EUoK8xhgi62xXr6YlPu1ZunGjB/fknTpNY/72v3CVbyL2zCHx7s0qnsGRzgGepYItdyGvShx7WrJHHBBktcO++cES5VmSR3oXNLO7kLLmWp5RIAWemV7WuneAgNfUSQyNvclRmcuCm3wo8MEnXTkL8zFM2+9L5F5CAqxp3cE3XgaLy9YmhKJTRGgwqsLjfSfkMoI5VeTht9Eifc9nX8Sganf5/s7oIdhcILgLkiuo1Kz3xTfzTQOXH1kHoZqOaX6KQMSDK5Ekx9QIdKjNvSDvPFrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xb3rgV6jEOu8RSGxCa01dDwsi0ORjw6uotCr1elZG4=;
 b=U+kAfMDGi9ZD1NZK86knI43oxj4L95p53RIZVPMloudiy6acQNywFWpXorG6Pmf4lezhQd8dlzcHk0EFBdi1HmWIk5xQIBAJnCzRGgoiv4+Dvm/IcpWistkimx7h/d+ge7j1XF7DUMJUaxRpryGQx796xainbmHqSNL6BU9uu24=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 21:15:38 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::9b) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:37 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:36 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH 09/41] drm/amd/display: Ensure dtbclk is enabled
Date: Fri, 31 Jul 2026 17:12:30 -0400
Message-ID: <20260731211302.3040343-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fe7a63-2a3f-4538-cb1b-08deef48de90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: R1giAcRc0injiNr8ipLtyMBl88W3UqRjlmcdG1qv8FTIoZjMRXALUEx592L1dS7jaoDyR8dk9dOVEC2wTuJQlD1mWQz5W403Ql6B5DZl/8TWxj0x5fX0AC9kMt+rmzPA9tMML3UvU1X3joFhbyD9fmMyJ3KuHvE16+4crnr737HzTJUKWo7XHgT3BlDq6bp+/YRKRA66z/MiHSsH3hKv81YoZr1BYuU+3Hud9EhYSsi3yWkCPaXqvBdbnKkN6/J6IHOAbjyxiHMIerctFPq4uMro31Is6n1rhphcvhc4nZnMlWeRW9O/GT3zzMOyCaXhwuiD6MuMYhMUIPqY6Zk+lXUWxPZ+0aBidtYXPbgqodrAvp/bP9e0T683n2ETYpUQ2Pp3NfVndgUS8f5zUc+1oC4RXKMM46GXb2wmamd4fdxpyEJwp6yV6WTKQc4O5OE5a6c3Y01HBYYcokKPRdfvK5L8j00jCVFroLnji9tfN9a6ICzZqOBf6tp+/N9SrNaKBE+H4Ia8n0fZB6TSOMgxi84nycsmLp0w255pyj64pyjrDF/0fOf8iWOfr7hhDCgJdnyBDAT2ka9rzd8+oYa4El4BSzCMk9Z0VMhhH01r7zojiIiVGz37onPVnMb4BFYqYCEMR4qFw5PjStn2+ozEaUfMYWHSKQjOpSziurY0a6oDzhpJ2Xaj0ZDuA7OU1tK9Yc5i8TFLCvNNIdc27sUX1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VDCU/taxMxdT4MvLW41pKCgcXnDZDkOefVliSASp09i3at9q2sY5S9qZN1wmH6CFCtQSXtLZp952iqDB8kY5Lz1rpWXkpKvxMO2AZwTjKtTPzKxIuTopKLFQA6elOWKHJNmJBa6hxu5QzByfzPdNhu9hkCxfQyIrkv4ng94JyXn8bEvJuaOe8B17z3CMk9Z+YrqrnW4EXAjybn8IEthQxtv7O2ann0j/J8j/mqWmzSpnt53NHDlkqJKKR6kKONZ8VzuX1AWd3uKdbQv0fzu82Sqc6aNVN7/io+PyUZUaEkmTuNG0AEKcldVmt+/T2mFpObhPWh1pDekOLxMe+sQ7VSO1K2WDqdCsEuWu4Tk8tTHVvsL2zNVGXdpsghVLt/cRyDI8CiYoTV6csaV8PV040PzUoNbkFyMJVLH3xMsduCwnonCXSnfBzQs7B3+e+s4M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:38.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fe7a63-2a3f-4538-cb1b-08deef48de90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
ensure dtbclk is enabled before hdmistreamclk_en

pmfw could stop dtbclk on idle.
driver needs to ensure dtbclk enabled is enabled before hdmistreamclk_en
also disable debounce timer on dcn42.

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 28 +++++++++++++++++--
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  4 +++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 18 ++++++++++--
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index c7b9bad93a93..19ef0b92e8e6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -220,6 +220,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
 	bool has_active_display;
+	int actual_dtbclk = 0;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -260,8 +261,9 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 		 * For dcn42b (no dtbclk hardware), init_clk_states sets dtbclk_en=false and
 		 * new_clocks->dtbclk_en should always be false, so this block never executes.
 		 */
-		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
-			int actual_dtbclk = 0;
+		actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
+
+		if (new_clocks->dtbclk_en && actual_dtbclk < 590000) {
 
 			dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
 			dcn42_smu_set_dtbclk(clk_mgr, true);
@@ -343,7 +345,6 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 		dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
 		clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
 	}
-
 	if (dpp_clock_lowered) {
 		// increase per DPP DTO before lowering global dppclk
 		dcn42_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
@@ -1051,7 +1052,27 @@ void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 		dm_helpers_free_gpu_mem(clk_mgr_base->ctx, DC_MEM_ALLOC_TYPE_GART,
 				smu_dpm_clks.dpm_clks);
 }
+void dcn42_request_dtbclk(struct clk_mgr *clk_mgr_base, bool enable)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	/*pmfw might turn off dtblck based on allow_dtbstop*/
+	clk_mgr_base->clks.dtbclk_en = false;
 
+	if (enable) {
+		int actual_dtbclk = 0;
+
+		dcn42_smu_set_dtbclk(clk_mgr, true);
+		actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
+		if (actual_dtbclk > 590000) {
+			clk_mgr_base->clks.ref_dtbclk_khz = actual_dtbclk;
+			clk_mgr_base->clks.dtbclk_en = true;
+		}
+	} else {
+		clk_mgr_base->clks.dtbclk_en = false;
+		dcn42_smu_set_dtbclk(clk_mgr, false);
+	}
+}
 static struct clk_mgr_funcs dcn42_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1065,6 +1086,7 @@ static struct clk_mgr_funcs dcn42_funcs = {
 	.get_max_clock_khz = dcn42_get_max_clock_khz,
 	.get_dispclk_from_dentist = dcn42_get_dispclk_from_dentist,
 	.is_smu_present = dcn42_is_smu_present,
+	.request_dtbclk = dcn42_request_dtbclk,
 	.notify_cstate_disable = dcn42_notify_cstate_disable,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index 330242747fff..f90c6e2e85c2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -84,4 +84,5 @@ void dcn42_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr, struct dcn42
 void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int);
 void dcn42_update_clocks_fpga(struct clk_mgr *clk_mgr, struct dc_state *context, bool safe_to_lower);
 int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base);
+void dcn42_request_dtbclk(struct clk_mgr *clk_mgr_base, bool enable);
 #endif //__DCN42_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index e52fb7248a88..47ec08071ceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1118,6 +1118,10 @@ static bool dcn401_program_pix_clk(
 		if (clock_source->ctx->dc->caps.is_apu &&
 			pix_clk_params->requested_pix_clk_100hz &&
 			dc_is_hdmi_frl_signal(pix_clk_params->signal_type)) {
+			//make sure dtbclk is enabled
+			if (clock_source->ctx->dc->clk_mgr->funcs->request_dtbclk)
+				clock_source->ctx->dc->clk_mgr->funcs->request_dtbclk(
+					clock_source->ctx->dc->clk_mgr, true);
 			/*need hdmistreamclk before vpg block register access*/
 			clock_source->ctx->dc->res_pool->dccg->funcs->set_hdmistreamclk(
 				clock_source->ctx->dc->res_pool->dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index ec678bd249ef..614beb5924fd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -427,6 +427,7 @@ struct clk_mgr_funcs {
 			struct block_sequence_state *seq_state);
 
 	void (*execute_clk_mgr_block_sequence)(struct clk_mgr *clk_mgr);
+	void (*request_dtbclk)(struct clk_mgr *clk_mgr_base, bool enable);
 };
 
 struct clk_mgr {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 75ec3b701d81..714168e1ece6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -415,6 +415,18 @@ void hdmi_frl_LTS_clear_Link_Setting(struct ddc_service *ddc_service)
 
 }
 
+static uint8_t hdmi_frl_get_max_ffe_level(struct dc_link *link,
+		struct dc_hdmi_frl_link_settings *link_settings)
+{
+	uint8_t max_ffe_level =
+			(link_settings->frl_link_rate > HDMI_FRL_LINK_RATE_12GBPS) ? 7 : 3;
+
+	if ((uint8_t)link->dc->debug.limit_ffe < max_ffe_level)
+		max_ffe_level = (uint8_t)link->dc->debug.limit_ffe;
+
+	return max_ffe_level;
+}
+
 static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_service,
 		struct dc_hdmi_frl_link_settings *link_settings)
 {
@@ -436,7 +448,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	struct hpo_frl_link_encoder *hpo_frl_link_enc = ddc_service->link->hpo_frl_link_enc;
 	struct link_encoder *dio_link_enc = ddc_service->link->link_enc;
 	uint8_t sink_version = 0;
-	uint8_t FFE_Levels = (uint8_t)ddc_service->link->dc->debug.limit_ffe;
+	uint8_t FFE_Levels = hdmi_frl_get_max_ffe_level(ddc_service->link, link_settings);
 	uint8_t current_FFE = 0;
 	bool override_FFE = false;
 	bool flt_no_timeout = false;
@@ -616,7 +628,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 						}
 						current_FFE++;
 						override_FFE = true;
-						if (current_FFE > 3)
+						if (current_FFE > FFE_Levels)
 							current_FFE = 0;
 						if (flt_no_timeout)
 							current_FFE = 0;
@@ -642,7 +654,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 						}
 						current_FFE++;
 						override_FFE = true;
-						if (current_FFE > 3)
+						if (current_FFE > FFE_Levels)
 							current_FFE = 0;
 						if (flt_no_timeout)
 							current_FFE = 0;
-- 
2.34.1

