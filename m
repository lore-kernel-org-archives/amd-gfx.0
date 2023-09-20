Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B5BCE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EC210E42B;
	Wed, 20 Sep 2023 03:19:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B96C10E428
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2aVb32u8/P+r/J7b71gF89Ofh0Lig4KMm70QKMBS8K76nFJG4ePlLf1fErxwKHc0/EbWAQdI+flbM7Gw5a2+UQ3x+h0GgXBQW9Dzr1fdL8xWvE3QVmmYY+v6zNL9MMygp9hgzK9fgEOPqGfTJDfNwmkq0gwWS5TM7QoyS17DyRRUPheZy1V24O4lVCHGxJhbfLk3O8BVrRMQ8gEuCwUvd6BCeGGW7XC2ctRF5LyBwE1sTVisNorv7z0Mg9epWm/RoIJhFZn+pKsNu/Q2z/mwxS9q4FTRvo6xmrVvC461Bu7Vj5Yh7QdUixwce1nkBdfWVDOA5o171RxC5dfR/RnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hkn7jrz4ZFNHqBlSpNhMQPnU8085lcYmAiiTTmfXsw=;
 b=eYhRtH4XlxXcRxnZ4sFlLbjy9Q0f+knRxitDANcbqeKdzo2fNryqbR5EbxXLcpOv5T7/DYOl++9WUjv8usaOH8Lnv8ZEhCUQR1bpbCEnjLSx794aio2ECf5ATSnwjSWCuJidq83DAolPCFGazO26XbPWcwvbEO098RpbS6LTDtccugwXyB7lTa8C/oE2NeWME+Y05qEF138/88m362N0/SLnhrl5R9Xelc3uIFZOXR58tFUOcSvtwBC/M1AsqHF57WIj9WpYh3pmJyq/VPnCQuXJjtPnu/DMbKv6iohS0E06UyfkvfQNtTokexqyT+WyLUxgqPzGiMAqWU5HCF+syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hkn7jrz4ZFNHqBlSpNhMQPnU8085lcYmAiiTTmfXsw=;
 b=3SK5+4FlscWoQNWfhMsy6Nmma4Al4fXRl6LJKyIc3YDOUv5KYsaqBvI9XhLXV0ITGKzzAASMYfmL3zCPnKjne5Q669UIiLg140Kur2xPdAGprqmF2mJnyi/O67G6Surv4xZ+XPwJhqcOg4bVDNXG4R7xJ60Gegel2/MJW7umC80=
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 03:19:29 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::72) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:19:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:19:25 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:18:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: Improve x86 and dmub ips handshake
Date: Wed, 20 Sep 2023 11:16:11 +0800
Message-ID: <20230920031624.3129206-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 959a679e-739d-4025-cf9b-08dbb9886697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qr63/E9M0leMPoi11LMH3t6ONuu9fcbFhHmwdxjx/CgJ7ny6EEWV15x4fYe59klw1JpaNFcCq6GqyE+t4A61jWXnMkPKqVAq03Z335ddcuMK+2ZecFVyDdiQTxes5zKiF60EJeHcHtK47NL7FN6QC4t85V13uANKyb8bDRZzezFmMiVFeeBo97mL0oI/4lIFKeUQXN2T2eYpW2kBVyMPJdPay6VKh8OhxYXmYOhlGat4Z6Gy3XeJQD9IWM+oqZ8fLJSLFXP1+xCjGxxdI8o0dXrEBLTQjyYhN56mFV6UfPjP2k/6YZ7cOD75RIxwZaB6Jr7WvkghIzBsWlM63QiyTNc3dLsZdPZxpCeVipwjZVJy9kaEti9hbwmzYYsauWZPNQeoRWGVq2ytKcMz4eG3u5DnR7Cq7DvDFw9Zs41FNqtf7lQ4N6FzfdqZFPwE8fSUgtcN8+bb6KSo0GGryQ290rwDZBJNwbZPRoINBpQ1E1YfHOW2t/OqsX6TbOgBMWdqM/OTIPO5lVtVrNr2/KF1O/t7jdMC9sHFyP3lmyeDk8ISNWsVg0lhX5ihZH9cS7aL+LjoMXDsLaA9q2rdevq7ztdTXAnIQCdAfpl9SxHHVUIc6VyisaIFVJ+BLtLYly6X5YXQy8NSpQ/YRPYyTegN6fgBDH+zMR2wQRrtmkgvHtQMkplEEbPO/Z/g6BPA+GpmycMruqetH5hvraHvl0Pi7zmkbf1zGMKuGDixiJchXQ4GvoHzyRGX4c+9LlNVk6Ydtgya6u+Yv0TQzmjSv0vNNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(5660300002)(7696005)(86362001)(316002)(41300700001)(54906003)(70206006)(70586007)(478600001)(6666004)(6916009)(8936002)(2616005)(36860700001)(8676002)(40480700001)(356005)(26005)(81166007)(82740400003)(2906002)(30864003)(47076005)(426003)(336012)(36756003)(1076003)(4326008)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:19:29.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959a679e-739d-4025-cf9b-08dbb9886697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
There is a race condition between x86 and dmcub fw when attempting to exit
IPS2. Scenarios including exiting IPS2 before IPS2 has been entered. This
can cause unexpected hang when DMCUB attempt to exit while PMFW still
tries to enter IPS2.

[How]
A new design has been introduced to remove race conditions and improve the
handshake between x86 and DMCUB. An AON scratch register is borrowed from
PMFW to determine whether DMCUB has committed to IPS entry or not.

In the case when dmcub has committed IPS entry, x86 must poll until an exit
event occurred either from DMCUB(IPS1) or PMFW(IPS2). x86 will wait
upperbound of evaluation and IPS entry time to ensure IPS2 exit event has
been sent to PMFW.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 37 ++++++++++++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 14 ++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 57 +++++++++++++++----
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    | 30 ++++++----
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.h    |  3 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  4 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 +-
 11 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 819d273f011d..c9c7baf45be3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -738,6 +738,34 @@ static void dcn35_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
+static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
+
+	if (dc->debug.disable_ips == 0) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS1) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	}
+
+	if (!allow_idle) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
+	}
+
+	dcn35_smu_write_ips_scratch(clk_mgr, val);
+}
+
 static void dcn35_exit_low_power_state(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -757,6 +785,13 @@ static bool dcn35_is_ips_supported(struct clk_mgr *clk_mgr_base)
 	return ips_supported;
 }
 
+static uint32_t dcn35_get_idle_state(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dcn35_smu_read_ips_scratch(clk_mgr);
+}
+
 static void dcn35_init_clocks_fpga(struct clk_mgr *clk_mgr)
 {
 	dcn35_init_clocks(clk_mgr);
@@ -844,6 +879,8 @@ static struct clk_mgr_funcs dcn35_funcs = {
 	.set_low_power_state = dcn35_set_low_power_state,
 	.exit_low_power_state = dcn35_exit_low_power_state,
 	.is_ips_supported = dcn35_is_ips_supported,
+	.set_idle_state = dcn35_set_idle_state,
+	.get_idle_state = dcn35_get_idle_state
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index f42c0a727dc8..cf74e69cb2a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -444,9 +444,9 @@ void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *cl
 			enable);
 }
 
-void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
+int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr)
 {
-	dcn35_smu_send_msg_with_param(
+	return dcn35_smu_send_msg_with_param(
 		clk_mgr,
 		VBIOSSMC_MSG_DispPsrExit,
 		0);
@@ -459,3 +459,13 @@ int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_QueryIPS2Support,
 			0);
 }
+
+void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param)
+{
+	REG_WRITE(MP1_SMN_C2PMSG_71, param);
+}
+
+uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr)
+{
+	return REG_READ(MP1_SMN_C2PMSG_71);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
index 4d441d6db8d0..8fb65a49351b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
@@ -174,8 +174,10 @@ void dcn35_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zst
 void dcn35_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn35_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable);
 
-void dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
+int dcn35_smu_exit_low_power_state(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_ips_supported(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
 int dcn35_smu_get_dprefclk(struct clk_mgr_internal *clk_mgr);
+void dcn35_smu_write_ips_scratch(struct clk_mgr_internal *clk_mgr, uint32_t param);
+uint32_t dcn35_smu_read_ips_scratch(struct clk_mgr_internal *clk_mgr);
 #endif /* DAL_DC_35_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fd5040966ba0..ed9b72ac369f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -965,6 +965,8 @@ struct dc_debug_options {
 	bool replay_skip_crtc_disabled;
 	bool ignore_pg;/*do nothing, let pmfw control it*/
 	bool psp_disabled_wa;
+	unsigned int ips2_eval_delay_us;
+	unsigned int ips2_entry_delay_us;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 91b3a4610957..973d7938f47b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1100,31 +1100,64 @@ void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 
 	cmd.idle_opt_notify_idle.cntl_data.driver_idle = allow_idle;
 
-	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	if (allow_idle) {
+		if (dc->hwss.set_idle_state)
+			dc->hwss.set_idle_state(dc, true);
+	}
 
-	if (allow_idle)
-		udelay(500);
+	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
 void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
+	uint32_t allow_state = 0;
+	uint32_t commit_state = 0;
+
 	if (dc->debug.dmcub_emulation)
 		return;
 
 	if (!dc->idle_optimizations_allowed)
 		return;
 
-	// Tell PMFW to exit low power state
-	if (dc->clk_mgr->funcs->exit_low_power_state)
-		dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+	if (dc->hwss.get_idle_state &&
+		dc->hwss.set_idle_state &&
+		dc->clk_mgr->funcs->exit_low_power_state) {
+
+		allow_state = dc->hwss.get_idle_state(dc);
+		dc->hwss.set_idle_state(dc, false);
+
+		if (allow_state & DMUB_IPS2_ALLOW_MASK) {
+			// Wait for evaluation time
+			udelay(dc->debug.ips2_eval_delay_us);
+			commit_state = dc->hwss.get_idle_state(dc);
+			if (commit_state & DMUB_IPS2_COMMIT_MASK) {
+				// Tell PMFW to exit low power state
+				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
+
+				// Wait for IPS2 entry upper bound
+				udelay(dc->debug.ips2_entry_delay_us);
+				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
-	// Wait for dmcub to load up
-	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+				do {
+					commit_state = dc->hwss.get_idle_state(dc);
+				} while (commit_state & DMUB_IPS2_COMMIT_MASK);
 
-	// Notify dmcub disallow idle
-	dc_dmub_srv_notify_idle(dc, false);
+				if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
+					ASSERT(0);
+
+				return;
+			}
+		}
+
+		dc_dmub_srv_notify_idle(dc, false);
+		if (allow_state & DMUB_IPS1_ALLOW_MASK) {
+			do {
+				commit_state = dc->hwss.get_idle_state(dc);
+			} while (commit_state & DMUB_IPS1_COMMIT_MASK);
+		}
+	}
 
-	// Confirm dmu is powered up
-	dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
+		ASSERT(0);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
index 06960fada059..03ef7820139a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
@@ -647,18 +647,10 @@ bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	// TODO: review other cases when idle optimization is allowed
 
-	if (!enable) {
-		// Tell PMFW to exit low power state
-		if (dc->clk_mgr->funcs->exit_low_power_state)
-			dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
-
-		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
-	}
-
-	dc_dmub_srv_notify_idle(dc, enable);
-
 	if (!enable)
-		dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true);
+		dc_dmub_srv_exit_low_power_state(dc);
+	else
+		dc_dmub_srv_notify_idle(dc, enable);
 
 	return true;
 }
@@ -1192,3 +1184,19 @@ void dcn35_optimize_bandwidth(
 			dc->hwss.root_clock_control(dc, &pg_update_state, false);
 	}
 }
+
+void dcn35_set_idle_state(const struct dc *dc, bool allow_idle)
+{
+	// TODO: Find a more suitable communcation
+	if (dc->clk_mgr->funcs->set_idle_state)
+		dc->clk_mgr->funcs->set_idle_state(dc->clk_mgr, allow_idle);
+}
+
+uint32_t dcn35_get_idle_state(const struct dc *dc)
+{
+	// TODO: Find a more suitable communcation
+	if (dc->clk_mgr->funcs->get_idle_state)
+		return dc->clk_mgr->funcs->get_idle_state(dc->clk_mgr);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h
index 7c0ff7b163a9..14bbdb0fa634 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h
@@ -79,4 +79,7 @@ void dcn35_dsc_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst,
 		bool power_on);
+
+void dcn35_set_idle_state(const struct dc *dc, bool allow_idle);
+uint32_t dcn35_get_idle_state(const struct dc *dc);
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index d68efe5c64a4..a9553a87b959 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -117,7 +117,9 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
 	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
 	.block_power_control = dcn35_block_power_control,
-	.root_clock_control = dcn35_root_clock_control
+	.root_clock_control = dcn35_root_clock_control,
+	.set_idle_state = dcn35_set_idle_state,
+	.get_idle_state = dcn35_get_idle_state
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 06fd02084d7c..67ff19d4116d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -748,6 +748,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
 	.disable_ips = true,
+	.ips2_eval_delay_us = 200,
+	.ips2_entry_delay_us = 400
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index cb2dc3f75ae2..fa9614bcb160 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -262,6 +262,8 @@ struct clk_mgr_funcs {
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 	void (*exit_low_power_state)(struct clk_mgr *clk_mgr);
 	bool (*is_ips_supported)(struct clk_mgr *clk_mgr);
+	void (*set_idle_state)(struct clk_mgr *clk_mgr, bool allow_idle);
+	uint32_t (*get_idle_state)(struct clk_mgr *clk_mgr);
 
 	void (*init_clocks)(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index e0dd56182841..d4d59a916668 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -422,7 +422,8 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state, bool power_on);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
-
+	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
+	uint32_t (*get_idle_state)(const struct dc *dc);
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
-- 
2.37.3

