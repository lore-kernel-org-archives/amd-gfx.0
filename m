Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF124C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7854310EC8F;
	Tue, 11 Aug 2026 15:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzGU/1xx";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10BD10EC8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUrJDZBUZfFGFZn7RqkPAjLTjoXgVjquOmzisxzE9xOw/lUgbNCE/wwJZ0yRr6eoMpJJBcAdtwvWayZZWd1KMlL8vs8mVRW9wnXHtPSpbXqVSPtUBtRzpLlUwrxntFPoDeYpBIeQVWm4oUW+OcbEpJLepg6Jwlm1p8D3/LtRa2XrBpcr03jXeejsnNKXPO0XAYL4C/pnhQMMXb2eo5esD8Oj1KPI78J/Bp8Jt6aJwL0pBuW9ZSVHRqjnphyXUMYNuPuRMefFU5RitRyX0FXBcSPkwWGrk28GerdeIEC8mfHndmz3V8lwFdDl7v2kNrCTYRTkITxp+vPKzgiFYb3+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMudwxXbDCd0xF0SZZGjziVjDFAEsfNvCJ/Pe1w9lZQ=;
 b=zUNpMCTSFwwCF68YCiO4INr7J3Q/g7N/e2G09U5CHZXviq46Pti2xqTLzoCQFsAOTF5kW29k5SxygsA9kKGc4gHVUiPeaYwTUYAsx2mThHPChmYs15h6PyVBKFx4/KdsAJY5V6DIaxMqNQE5cj0QwCPvl9QpZwMnz74Qh7NpA4XAtul5DjBo1he6JW7oqX2iTSZC3Ug2klEE4cW3q5wYvQOtBo8cDybSS8Xg24KFzfddotvfIW5/rAdeDOwc6BYZfkkAz+8MDpMi22wYfqDTKVVtyWXTOmkpyGOUB1KALDwbfbPGsw5VRCB0xVtZ4NLiYxTfuSgXZzhcc6W+JFvnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMudwxXbDCd0xF0SZZGjziVjDFAEsfNvCJ/Pe1w9lZQ=;
 b=SzGU/1xxaoQEK29mUegpVEg6szmD+KkFK9dkYr0ZNP/Fg4llMh7I1ku++325HoHSiPgiAuvc2WnH54xEoa8VK4Sr0MYPbMthes2fimb+Lw0X4EEN6qdrTzWEf6rAF0DrJ9K+LGvKvTRmn28IUrWauOhv/4XCfNto/diNq1tdY2E=
Received: from CH0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:610:74::16)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:49:33 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::74) by CH0PR04CA0071.outlook.office365.com
 (2603:10b6:610:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:32 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:23 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Leo Chen
 <leo.chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 09/24] drm/amd/display: Send DPM0 clock values to DMU
Date: Tue, 11 Aug 2026 05:28:43 +0800
Message-ID: <20260810213010.1703162-10-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5e1157-8024-4654-0ae5-08def7c02339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|10067099003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: hIo7BqMILxR3pxMdzGsr0JpP6mSWOZt5BbUMcM3drrfzFxnf2nM29Vw4E4/LuQpmG3xaPCUTdNOvGZG0m1lMMTVOupNKvvtISFBVrj1koqee/52/fB86z2iC+LiyOMSSG3KpU5+tuF3K/nijTt1rJ5Vgx4BiMz/abO0nQZgxWonc4PLY/w/EyvP/1p/PBnLDQzxVJF4/HdhWxVigKhZ2qnpnvI/mTJN97tKee4pIVekw4T4SfDFaa6noQ1q6Snh+0jyfTrkJQDwTiyqSQFutSMFJaJX06OkHfcDWUqp9eb02XUMfkILO9RIQjAGQNEaBkF10uoifV6yz07ynYcwcLX69Hzu/BPrZ46Thc7p8/70AbKGFOnDcwn0vBYdBAfezAmaIV7Zlitu1WNHoEJGErFBsV2EXJTR1RZoa8OlEE8j26ZEC/3vkkxbVAtihfh3eosLl1A25q88/l+QprjIKRhNfZWpTkMkVC82jts0mL52v4iHAqeLdPRUMG1BWCoKcTgc2R/VnmG+pLkGvsSHWyZn+TLjaLxRyiocZDTXbQiEuCRtAzK4NGTgyHSLveyLDZgn/zH9E71iWxsQAH18LEDNZL2spCUPNQxhF27n/GVvSFxmWaZYQFhQhQYHYbtTJThD+NNGXGc0eJP7sHqSL2/mN2b0DLnq5mv533xI8oSJFajRL5oiZM7ooiZ09qyKb9F0OcLy6e3Y0FfYNO8yuFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WZJLJ23MgrDCdMqP7XJSsIJ3KxG7FrXvADlsCSM9KHMFK6yoPTY9GLEIXlx+PAHd7/+6IVsdN04DXmR4duA7Bnc6841ypgzam/LykFwjZKYtQeaEF8yf7HbcflWIHoqI0Ijwm0bmIsM5HzN8AJDV6XdNzY6f9twE8oe7TdT4ShJAm1N+nixrcG3EbCw1DiSYMm6Qayf2MEzy88hvvk5OxjEZnAN/VMj4/OMXs0BfbUtem/oJdKuKxcowWwsMATkKWJla+BsxJTOMK/KZAKlXH4bmW+dWq92lfIiss7DVvXhIdnGktZdOSmA++CN9/E18yMA82hKgkR3FF399q+XOIY7XJ0AtD2KCnQqlMvubTlxTz2iD+lkbGPBItfUAIHkEywBq8XtMpJdNmEvH1YW+8RG/x375J2p4lupKT12NK/ftR70U5ujtruXGzIXlRjQ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:32.9320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5e1157-8024-4654-0ae5-08def7c02339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
Z8 Retention requires clocks to be put into bypass for the PLL
to be powered down.

Notify DMU of the DPM0 clock values, which is likely always going
to be running of a bypass clock.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 12 ++++++++++++
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h |  5 +++++
 .../amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c   |  1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h      |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index a2ecde8362a5..c62be9f25dae 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -214,6 +214,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	union dmub_rb_cmd cmd;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct clk_mgr_dcn42 *clk_mgr_dcn42 = TO_CLK_MGR_DCN42(clk_mgr);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	bool update_dppclk = false;
@@ -364,6 +365,16 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz;
 	cmd.notify_clocks.clocks.dispclk_khz = clk_mgr_base->clks.dispclk_khz;
 	cmd.notify_clocks.clocks.dppclk_khz = clk_mgr_base->clks.dppclk_khz;
+	/* Communicate the minimum (DPM0) clocks and bypass ceiling so DMUB does not
+	 * assume hardcoded per-ASIC values (e.g. for Z8-Retention clock lowering).
+	 * DPM0 is the lowest populated DPM level (entries[0]); 0 when the SMU DPM
+	 * table is unavailable, in which case DMUB falls back to its own defaults.
+	 */
+	cmd.notify_clocks.clocks.dpm0_dispclk_khz =
+		clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz * 1000;
+	cmd.notify_clocks.clocks.dpm0_dppclk_khz =
+		clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz * 1000;
+	cmd.notify_clocks.clocks.max_bypass_clk_khz = clk_mgr_dcn42->max_bypass_clk_khz;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
@@ -1113,6 +1124,7 @@ void dcn42_clk_mgr_construct(
 
 	clk_mgr->base.dccg = dccg;
 	clk_mgr->base.dfs_bypass_disp_clk = 0;
+	clk_mgr->max_bypass_clk_khz = 0;
 
 	clk_mgr->base.dprefclk_ss_percentage = 0;
 	clk_mgr->base.dprefclk_ss_divider = 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index f90c6e2e85c2..f64c1ccee8c3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -44,6 +44,11 @@ struct dcn42_ss_info_table {
 struct clk_mgr_dcn42 {
 	struct clk_mgr_internal base;
 	struct dcn42_smu_watermark_set smu_wm_set;
+	/* Max dispclk/dppclk (kHz) that can run on a bypass source with the PLL
+	 * powered down. Communicated to DMUB for Z8-Retention clock lowering.
+	 * SMU does not expose this, so it is a fixed per-ASIC value set at construct.
+	 */
+	uint32_t max_bypass_clk_khz;
 };
 
 bool dcn42_are_clock_states_equal(struct dc_clocks *a,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 90cc2c3aabe4..3420edcf4ffb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -618,6 +618,7 @@ void dcn42b_clk_mgr_construct(
 
 	clk_mgr->base.dccg = dccg;
 	clk_mgr->base.dfs_bypass_disp_clk = 0;
+	clk_mgr->max_bypass_clk_khz = 0;
 
 	clk_mgr->base.dprefclk_ss_percentage = 0;
 	clk_mgr->base.dprefclk_ss_divider = 1000;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index c273d97ec88d..1d10fe8f1998 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3009,6 +3009,9 @@ struct dmub_clocks {
 	uint32_t dppclk_khz; /**< dppclk kHz */
 	uint32_t dcfclk_khz; /**< dcfclk kHz */
 	uint32_t dcfclk_deep_sleep_khz; /**< dcfclk deep sleep kHz */
+	uint32_t dpm0_dispclk_khz; /**< DPM0 (minimum) dispclk kHz from SMU DPM table, 0 if unknown */
+	uint32_t dpm0_dppclk_khz; /**< DPM0 (minimum) dppclk kHz from SMU DPM table, 0 if unknown */
+	uint32_t max_bypass_clk_khz; /**< max dispclk/dppclk achievable on a bypass source (no PLL) kHz, 0 if unknown */
 };
 
 /**
-- 
2.43.0

