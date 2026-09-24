Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C9C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF29710F735;
	Thu, 24 Sep 2026 18:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WuUgc2pZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F6C10F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8O28APMOeoMuF+H2Gctqtp4z0vgq/ZVd6bD89xBmaHRI49r3ybxqL62EkFpZgH5IG2dp9KBpf8NRpG5U9gIojTlzhS4XgRQtepZyC0VXGsv31krjMrqt53CJotsJ5z5isyYeZf88Sc3eSnzgdtueKfQABNf4I7g4kLohDK64y7dH0symHBziEyOVXlP1IymlCJu5MdBBxCHShBZFMeWRNDAe61qv3hKWg5XD5qKZiJxluA2IbB25nRHH3Fm1DzI65OgmUBwT07sNsBuEHnMj535Er4zMVUt1mHyEzXRNXw+PI7w7qlEoTw7F4w4WDavl0xM9eI+TiTNXcggONMgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xabrPmq3yDsANAthKi9mz16geilpK7FhKGFKvEb6RQ4=;
 b=hAmcaMqj9O/u0KUaWP7LD1R0X+2tNhB1ZPxaEx6F1jJ/YimzDRszNe9cliqBholqmYT2Q2N3nHZPOFCOMZK0gTXzHgR8X2VZ2M9sKvvvR00D3ccemlNa52qPtVA+5KL4uJ041ViV0SCrhvxn+hhvSfwOul56gecyndBfVlL9UKI67YGq/txMMWbsHeuxxZIA9DKL9mMWVz6FJiqHmsMBNXm9ID/nk2NwsFvtotGvLfF5MtJP7/ENpgofq2oPt8C31rZ0LslgT8oC4tK32YREFqFUljeapUyAdWSwiC8JC08cvEtMrJxkgMsZqoL4VSZUKj0pJM+CHQEevnG8bYBCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xabrPmq3yDsANAthKi9mz16geilpK7FhKGFKvEb6RQ4=;
 b=WuUgc2pZIbCEc9cYQ15FJ1KMiX2OcJjSpZLVtMB4Zoz5f7K+alHamBK/jOHkfsi6EmAPbd8sAGoujRMecd9Rhot6CEIGkNIiGcaLKuK6UBKcyV2gSpoI0VRYu8txlc1RKg/p9FCE5Nfl8tp4h7yi2px4igUfOO2o73Q6wzhQxYw=
Received: from SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::22)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Thu, 24 Sep
 2026 18:46:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5) by SJ0P220CA0014.outlook.office365.com
 (2603:10b6:a03:41b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:15 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:01 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/34] drm/amd/display: Consolidate bandwidth overrides
Date: Thu, 24 Sep 2026 14:45:16 -0400
Message-ID: <20260924184824.596894-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: aef4f83f-09bd-4107-1be7-08df1a6c1ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|3023799007|10067099003|56012099006|18092099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uUm9zvwGDacPzqXf0apgDPw80Xu4vJwQZAwXtNcpP8EFKKEEW3GvocHEnUKgSppRWCROxDKYa2UtjGf1qmKljOpybwReroJ2iu+ZjcSPd0aEDN8gZA3t27ayAIOtB/OfUWExg8vt07GcTONqA6N5ljWms8crzE1CWxNDEZm8xxv1WIxXeO8cEKr/xCnx6Oq4qnBhjTf1ojTpIbOh6FwkHYFUQ6NoOb7oC8DwJHroUxJaEo+p/kP/7pj8q4tMUozDcyYmwn3CNc7+yG2kEYpAOWNVmGpOhv5YySlY9CViGWv54pACTZWddBh2zFMrZSBdpFK0g6acCBbFXUBstDKHAM9yf77ySM6MYFQ5ynfr544YYHiQuGGXOPw6uIle1omKOe7x9XWASwm/7E03V/d62nKO5yk1mq+cZel+p7l5EjlXzdzawBcG/oSrf+ayB7r0cZCev2FDOHGGP+fpxdYBs67zwpvtMc3mGlcM28og6IxpXJkqKHQHxeJh3Bf5v3pviyfSEqljfIs5sStEX+w0WAuARPvBjZsWy6nTNf2udJTkjtuVbQ96gfHSDPsjwN2rKQFv4/l5sJQq/3hH/2kB4VXX/qQ5pE6a++f4wA7cZUYP0A7NjLOjmqnb+B2eSq6Ppr5vUduol6Yo5g4akpWJhFnSylEHxbzaOv29B9WClWjUqGq7EldX8P8kF5E4dICAHd+T4a1fmiC885ZJpkyslw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(3023799007)(10067099003)(56012099006)(18092099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i3Tq2zK/cV7mA+HSFaM8R6zgtN9P+FndLEsTihyLG4DzgDTvjOEQU6MvwoeAYk2XHtDHONCoc+iiNMMxB9SdI08v33rowXWVmk6PSV3DwuSu7aRRmID4o49LxylqE7l05tf3R4OKkg5O7wGVoIqicq6K6j4PNV1UrTLimIuGYwurgV5q6ooml7e3oM6SovcdIBtMx8oqmm+sLg5lLh9r9IkMTy7VwRN5/hiyOpXvYP1BrRkuIq3gGSBguV8CZFzAjo3UdcqTTLERZxpw3Ce8YBws/lKNZpjcM5DTanc+Tvtpqs7j4127j1z/EtRehNDJ/nj7rPfs0m0Wl2UzG0C+wGc1Kvhfs50XhDFiIHul6dPOBgBBPjQbL+OQzOGiR5cJe4ekp2KZdpx9DgE1jDxgBDHNwV+xdKMxFrH9E9QiXfDfxwm6FC8Bsx7RYRXbRg8e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:15.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef4f83f-09bd-4107-1be7-08df1a6c1ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Bandwidth overrides must be applied in a defined order so debug
settings are reflected in the final parameters.

[How]
Group clock adjustments with the clock table override and derive
the final mode limits after all clock table changes.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 75 ++++++++++---------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 00d96232a013..4cca1db2a79a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -484,18 +484,19 @@ static int dcn60_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 
 /**
  * dcn60_override_dc_mode_limit - Override DC mode limits from the clock table.
- * @dc_limit: output DC mode limit to populate
- * @clk_table: clock table already populated (and possibly overridden)
+ * @clk_mgr: clock manager instance
+ * @bw_params: bandwidth parameters containing the clock table and DC limits
  *
  * Sets the DC mode max frequency for each clock to the highest populated DPM
  * level in the clock table. Deriving the limit from the clock table (rather
  * than the raw DAL init table) ensures any overrides applied to the clock
  * levels are respected.
  */
-static void dcn60_override_dc_mode_limit(
-		struct clk_limit_table_entry *dc_limit,
-		const struct clk_limit_table *clk_table)
+static void dcn60_override_dc_mode_limit(struct clk_mgr_internal *clk_mgr,
+		struct clk_bw_params *bw_params)
 {
+	struct clk_limit_table_entry *dc_limit = &bw_params->dc_mode_limit;
+	const struct clk_limit_table *clk_table = &bw_params->clk_table;
 	const struct clk_limit_table_entry *entries = clk_table->entries;
 	const struct clk_limit_num_entries *num_entries = &clk_table->num_entries_per_clk;
 
@@ -513,6 +514,11 @@ static void dcn60_override_dc_mode_limit(
 			entries[num_entries->num_memclk_levels - 1].memclk_mhz : 0;
 	dc_limit->fclk_mhz    = num_entries->num_fclk_levels ?
 			entries[num_entries->num_fclk_levels - 1].fclk_mhz : 0;
+
+	if (clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch)
+		dc_limit->dtbclk_mhz = 0;
+
+	bw_params->dc_mode_softmax_memclk = dc_limit->memclk_mhz;
 }
 
 static unsigned int dcn60_get_dc_mode_limit_mhz(const DpmClock_t *dpm_clk)
@@ -618,16 +624,40 @@ static void dcn60_populate_clk_table(struct clk_mgr_internal *clk_mgr,
 
 /**
  * dcn60_override_clk_table - Override the clock table with hardcoded values.
+ * @clk_mgr: clock manager instance
  * @clk_table: clock table to override
  *
  * Temporary debug/bring-up override that replaces the DPM clock levels
  * populated from the DAL init table (see dcn60_populate_clk_table) with a
- * fixed set of hardcoded values. Implement any override as needed.
+ * fixed set of hardcoded values, then applies the configured minimum clock
+ * floors.
  */
-static void dcn60_override_clk_table(struct clk_limit_table *clk_table)
+static void dcn60_override_clk_table(struct clk_mgr_internal *clk_mgr,
+		struct clk_limit_table *clk_table)
 {
-	/* Override as needed */
-	(void)clk_table;
+	unsigned int i;
+
+	if (clk_mgr->base.ctx->dc->debug.min_disp_clk_khz) {
+		unsigned int min_disp_clk_mhz =
+			khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_disp_clk_khz);
+
+		for (i = 0; i < clk_table->num_entries_per_clk.num_dispclk_levels; i++)
+			if (clk_table->entries[i].dispclk_mhz
+					< min_disp_clk_mhz)
+				clk_table->entries[i].dispclk_mhz
+					= min_disp_clk_mhz;
+	}
+
+	if (clk_mgr->base.ctx->dc->debug.min_dpp_clk_khz) {
+		unsigned int min_dpp_clk_mhz =
+			khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_dpp_clk_khz);
+
+		for (i = 0; i < clk_table->num_entries_per_clk.num_dppclk_levels; i++)
+			if (clk_table->entries[i].dppclk_mhz
+					< min_dpp_clk_mhz)
+				clk_table->entries[i].dppclk_mhz
+					= min_dpp_clk_mhz;
+	}
 }
 
 /**
@@ -701,29 +731,8 @@ static void dcn60_override_utm_qos_model(struct clk_bw_params *bw_params)
 static void dcn60_override_bw_params(struct clk_mgr_internal *clk_mgr,
 		struct clk_bw_params *bw_params)
 {
-	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	unsigned int i;
-
-	if (clk_mgr->base.ctx->dc->debug.min_disp_clk_khz) {
-		for (i = 0; i < clk_table->num_entries_per_clk.num_dispclk_levels; i++)
-			if (clk_table->entries[i].dispclk_mhz
-					< (unsigned int)khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_disp_clk_khz))
-				clk_table->entries[i].dispclk_mhz
-					= (unsigned int)khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_disp_clk_khz);
-	}
-
-	if (clk_mgr->base.ctx->dc->debug.min_dpp_clk_khz) {
-		for (i = 0; i < clk_table->num_entries_per_clk.num_dppclk_levels; i++)
-			if (clk_table->entries[i].dppclk_mhz
-					< (unsigned int)khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_dpp_clk_khz))
-				clk_table->entries[i].dppclk_mhz
-					= (unsigned int)khz_to_mhz_ceil(clk_mgr->base.ctx->dc->debug.min_dpp_clk_khz);
-	}
-
-	if (clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch)
-		bw_params->dc_mode_limit.dtbclk_mhz = 0;
-
-	bw_params->dc_mode_softmax_memclk = bw_params->dc_mode_limit.memclk_mhz;
+	dcn60_override_clk_table(clk_mgr, &bw_params->clk_table);
+	dcn60_override_dc_mode_limit(clk_mgr, bw_params);
 
 	if (dcn60_should_apply_temp_utm_override)
 		dcn60_override_utm_qos_model(bw_params);
@@ -812,8 +821,6 @@ static bool dcn60_fetch_dal_init_table(struct clk_mgr_internal *clk_mgr)
 	dcn60_populate_utm_qos_model(clk_mgr, &bw_params->utm_qos_model, init_table);
 
 	dcn60_override_bw_params(clk_mgr, bw_params);
-	dcn60_override_clk_table(&bw_params->clk_table);
-	dcn60_override_dc_mode_limit(&bw_params->dc_mode_limit, &bw_params->clk_table);
 
 	return true;
 }
-- 
2.53.0

