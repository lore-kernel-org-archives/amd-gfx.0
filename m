Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E39C677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75C210E615;
	Tue, 10 Jan 2023 16:58:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEB310E615
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtxPkiI+040PVKlRApVYP5UYStjsh/Sd7dZ+d43e7srbPqO5+0O4bni0wiOp182L8wP9i64dyt2cIwntzmGOJ2HUH9m5rg7l+qyb2Gl8uSuv4NJeQWNWuy5/OAJLYf4yqcW7J9RbzpNATtI13YLZ+nsvQrzOdPya0mTypTXZKB130UkaHQsuVxHiyJnGXLapoaTJjh4m93VOGOip+VMaF4XcT3ff30sAo8gddQ2aNvLsHxpykT4foRIUTKhsK31kCmLNT2n2qPZdimLy6pIWDX20kZG8f9XO8gJR6R4rCdnrgcOXm6ZhbgJ4QprWmvlxIo0Nw6bs3feqKnk9U7Qz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/nOIH4ptUV+DwfW2FHLz9R0tcKt4Q00/3zxLzemRVg=;
 b=UIgzFRaPliq/nTPw3E3pEAF3t3qzjUYSohTM7llNlM6Ar8H8Pv4ZzoW4td/9bYxH6YqOAQHwoduNPtOiTZyrEarvVH8CDkWseuM+/Q5aq7ED8Qwh7aBboEs3b1SivVDY+Kig8Lfiv4GJUkazKpLa8DV4ooeYmXrsUi81rVzNR0aPGl5qZaklLQmJp/5QeUnigz1FNhZPVFYIDUlyKtmjJRUgXysR+0PnsTjVUnN93a9XvZ6BbGU2HZLejfvZk+NbfVwx7oEDMh4kI5A7RS6XUegpVzgAvwBNQFZUA60moEyudiIXU7K7neSxiSRWX9N9c1cZ5k1UOYCIj2I6zpnHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/nOIH4ptUV+DwfW2FHLz9R0tcKt4Q00/3zxLzemRVg=;
 b=3bDpXCZoYZ2rGUgO7KplP455ZZ5B6vBTdKowYnuSNdWPxIpJJisXVnViarDvGqM0oN6gXegfBiT1FkFRlGbd788FWH7ynzoXgYMN+qeCO0muaVEomhfbC1NHz89IpCUvVA2mpk5ySCOhBgZhn5aCuOlrtOvOSSPFg4POdr+wn6U=
Received: from MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::14)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:22 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::63) by MW4P223CA0009.outlook.office365.com
 (2603:10b6:303:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:21 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:57:59 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/37] drm/amd/display: move dp phy related logic to
 link_dp_phy
Date: Tue, 10 Jan 2023 11:55:18 -0500
Message-ID: <20230110165535.3358492-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab4bedb-dd62-4d16-8e0d-08daf32be17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLxFx6A6PMpJdRfYAWeLkWjbWCekTaPHUH2ZRKluXA943i9AFNCdK7kF4sNZz6Ke5JipCwk50rHMPjIuzi5Wp0TF6pmhWjLbxI/AU2V6q/XwaAe5se98J8hiYyFHDNJiS1PxGZ8oKY5XkNSAe5HvOgiO9vnPLe0w3RGPmHzkLDSp/O3ERsEhDGbKkjhIg7XB7WLgSyfLe07mc9LVCrjlUzHiakk7ex4v4CMZLytdaz2J/khXYH/6j7POeRiVFT3Vcf1ma7gugNXrgci/Y5ZC/NN0johQg271t0HlrYKxod1ClOATEL0Hv2M2OlqNK79uBLaVgL/1Xar6pKk2UFwR4+PbAfnHX6IBnR/Wb7BSLHCNHvo+HVOv3ZbDNHvY8f6YujYh64oqM32sFKMwHDRlokLg7UmG8gwPR/wWdsrE0eIV8Q9Hl1wL9sOZyhU7gEamwfgbbiY0XlBJkMH45TtBAinWSYQfR0iY4dDVXtV9OdsRAfTfSQJHvSppe1oRnv+w5ZOSeXWDUcLxxH//mwydSSJciyLVr5KyMfy5W4xyoRIEij1F1SMeCybQHcrpkhaRGISBFOvLJmDqPThCMn/1kVzJoJfVQQz9lfEvAQxwIFpN/QWHDR4zM3zebUUHV43bif8UYLX8ucciR8WYtalbG/PRrwWjTXMvK7SWt64+OUvZxC8ujyN1x1VBtqXvxqFzniYxNE995MWnQq1355CmLRHG+MWGwo2DdbPmLukCSHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(8936002)(5660300002)(40460700003)(30864003)(47076005)(426003)(336012)(82310400005)(7696005)(83380400001)(356005)(6666004)(2616005)(478600001)(186003)(26005)(16526019)(1076003)(82740400003)(6916009)(8676002)(70206006)(4326008)(70586007)(316002)(41300700001)(36860700001)(81166007)(40480700001)(54906003)(66899015)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:21.7004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab4bedb-dd62-4d16-8e0d-08daf32be17f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 127 +--------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  19 ---
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dp_phy.c | 144 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/link/link_dp_phy.h |  51 +++++++
 .../amd/display/dc/link/link_dp_training.c    |   1 +
 .../dc/link/link_dp_training_128b_132b.c      |   1 +
 .../display/dc/link/link_dp_training_8b_10b.c |   1 +
 .../dc/link/link_dp_training_auxless.c        |   2 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    |   1 +
 14 files changed, 210 insertions(+), 149 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index ae54a9719910..704860e6ba84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -35,6 +35,7 @@
 #include "resource.h"
 #include "dsc.h"
 #include "dc_link_dp.h"
+#include "dc_link.h"
 #include "link_hwss.h"
 #include "dc/dc_dmub_srv.h"
 
@@ -3395,7 +3396,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 				continue;
 
 			link = aconnector->dc_link;
-			dp_receiver_power_ctrl(link, false);
+			dc_link_dp_receiver_power_ctrl(link, false);
 			drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_port->mst_mgr, false);
 			link->mst_stream_alloc_table.stream_count = 0;
 			memset(link->mst_stream_alloc_table.stream_allocations, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 6a2e0d867853..957e1bc8981b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -55,6 +55,7 @@
 #include "link/link_dp_trace.h"
 #include "link/link_hpd.h"
 #include "link/link_dp_training.h"
+#include "link/link_dp_phy.h"
 
 #include "dc/dcn30/dcn30_vpg.h"
 
@@ -2174,7 +2175,7 @@ void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init)
 		}
 
 		if ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)
-			dp_receiver_power_ctrl(link, false);
+			dc_link_dp_receiver_power_ctrl(link, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index baf2e35d0ac6..cef89519c12e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -45,6 +45,7 @@
 #include "link/link_dp_training_fixed_vs_pe_retimer.h"
 #include "link/link_dp_training_dpia.h"
 #include "link/link_dp_training_auxless.h"
+#include "link/link_dp_phy.h"
 #include "resource.h"
 #define DC_LOGGER \
 	link->ctx->logger
@@ -139,21 +140,6 @@ uint8_t dp_convert_to_count(uint8_t lttpr_repeater_count)
 	return 0; // invalid value
 }
 
-void dc_link_dp_set_drive_settings(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	struct link_training_settings *lt_settings)
-{
-	/* program ASIC PHY settings*/
-	dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
-
-	dp_hw_to_dpcd_lane_settings(lt_settings,
-			lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
-
-	/* Notify DP sink the PHY settings from source */
-	dpcd_set_lane_settings(link, lt_settings, DPRX);
-}
-
 static enum clock_source_id get_clock_source_id(struct dc_link *link)
 {
 	enum clock_source_id dp_cs_id = CLOCK_SOURCE_ID_UNDEFINED;
@@ -2195,7 +2181,7 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
 
 	if (!link->dpcd_caps.dpcd_rev.raw) {
 		do {
-			dp_receiver_power_ctrl(link, true);
+			dc_link_dp_receiver_power_ctrl(link, true);
 			core_link_read_dpcd(link, DP_DPCD_REV,
 							dpcd_data, length);
 			link->dpcd_caps.dpcd_rev.raw = dpcd_data[
@@ -4106,20 +4092,6 @@ void dc_link_clear_dprx_states(struct dc_link *link)
 	memset(&link->dprx_states, 0, sizeof(link->dprx_states));
 }
 
-void dp_receiver_power_ctrl(struct dc_link *link, bool on)
-{
-	uint8_t state;
-
-	state = on ? DP_POWER_STATE_D0 : DP_POWER_STATE_D3;
-
-	if (link->sync_lt_in_progress)
-		return;
-
-	core_link_write_dpcd(link, DP_SET_POWER, &state,
-						 sizeof(state));
-
-}
-
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
 {
 	if (link != NULL && link->dc->debug.enable_driver_sequence_debug)
@@ -4127,50 +4099,6 @@ void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
 					&dp_test_mode, sizeof(dp_test_mode));
 }
 
-
-static uint8_t convert_to_count(uint8_t lttpr_repeater_count)
-{
-	switch (lttpr_repeater_count) {
-	case 0x80: // 1 lttpr repeater
-		return 1;
-	case 0x40: // 2 lttpr repeaters
-		return 2;
-	case 0x20: // 3 lttpr repeaters
-		return 3;
-	case 0x10: // 4 lttpr repeaters
-		return 4;
-	case 0x08: // 5 lttpr repeaters
-		return 5;
-	case 0x04: // 6 lttpr repeaters
-		return 6;
-	case 0x02: // 7 lttpr repeaters
-		return 7;
-	case 0x01: // 8 lttpr repeaters
-		return 8;
-	default:
-		break;
-	}
-	return 0; // invalid value
-}
-
-static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset)
-{
-	return (convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == offset);
-}
-
-void dp_enable_link_phy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum signal_type signal,
-	enum clock_source_id clock_source,
-	const struct dc_link_settings *link_settings)
-{
-	link->cur_link_settings = *link_settings;
-	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
-			clock_source, link_settings);
-	dp_receiver_power_ctrl(link, true);
-}
-
 void edp_add_delay_for_T9(struct dc_link *link)
 {
 	if (link && link->panel_config.pps.extra_delay_backlight_off > 0)
@@ -4236,57 +4164,6 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 	return result;
 }
 
-void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	struct dc  *dc = link->ctx->dc;
-
-	if (!link->wa_flags.dp_keep_receiver_powered)
-		dp_receiver_power_ctrl(link, false);
-
-	dc->hwss.disable_link_output(link, link_res, signal);
-	/* Clear current link setting.*/
-	memset(&link->cur_link_settings, 0,
-			sizeof(link->cur_link_settings));
-
-	if (dc->clk_mgr->funcs->notify_link_rate_change)
-		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
-}
-
-void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal)
-{
-	/* MST disable link only when no stream use the link */
-	if (link->mst_stream_alloc_table.stream_count > 0)
-		return;
-
-	dp_disable_link_phy(link, link_res, signal);
-
-	/* set the sink to SST mode after disabling the link */
-	dp_enable_mst_on_sink(link, false);
-}
-
-void dp_set_hw_lane_settings(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	const struct link_training_settings *link_settings,
-	uint32_t offset)
-{
-	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
-
-	if ((link_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && !is_immediate_downstream(link, offset))
-		return;
-
-	if (link_hwss->ext.set_dp_lane_settings)
-		link_hwss->ext.set_dp_lane_settings(link, link_res,
-				&link_settings->link_settings,
-				link_settings->hw_lane_settings);
-
-	memmove(link->cur_lane_setting,
-			link_settings->hw_lane_settings,
-			sizeof(link->cur_lane_setting));
-}
-
 void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e349976f385f..b89093e14195 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -583,4 +583,6 @@ int dc_link_aux_transfer_raw(struct ddc_service *ddc,
 
 enum lttpr_mode dc_link_decide_lttpr_mode(struct dc_link *link,
 		struct dc_link_settings *link_setting);
+void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on);
+
 #endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
index 758f4b3b0087..394d83a97f33 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
@@ -71,7 +71,7 @@ void dce110_optimize_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
 
-void dp_receiver_power_ctrl(struct dc_link *link, bool on);
+void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on);
 
 void dce110_edp_power_control(
 		struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index a4d9f1fea046..31159a86b28c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -134,30 +134,11 @@ void disable_dp_hpo_output(struct dc_link *link,
 void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool is_dp_128b_132b_signal(struct pipe_ctx *pipe_ctx);
 void edp_panel_backlight_power_on(struct dc_link *link, bool wait_for_hpd);
-void dp_receiver_power_ctrl(struct dc_link *link, bool on);
 void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
-void dp_enable_link_phy(
-	struct dc_link *link,
-	const struct link_resource *link_res,
-	enum signal_type signal,
-	enum clock_source_id clock_source,
-	const struct dc_link_settings *link_settings);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
 
-void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal);
-
-void dp_disable_link_phy_mst(struct dc_link *link, const struct link_resource *link_res,
-		enum signal_type signal);
-
-void dp_set_hw_lane_settings(
-		struct dc_link *link,
-		const struct link_resource *link_res,
-		const struct link_training_settings *link_settings,
-		uint32_t offset);
-
 void dp_retrain_link_dp_test(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		bool skip_video_pattern);
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 2e3d2073f8bd..c2d9b3d29994 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -26,7 +26,7 @@
 LINK = link_hwss_dio.o link_hwss_dpia.o link_hwss_hpo_dp.o link_dp_trace.o \
 link_hpd.o link_ddc.o link_dpcd.o link_dp_dpia.o link_dp_training.o \
 link_dp_training_8b_10b.o link_dp_training_128b_132b.o link_dp_training_dpia.o \
-link_dp_training_auxless.o link_dp_training_fixed_vs_pe_retimer.o
+link_dp_training_auxless.o link_dp_training_fixed_vs_pe_retimer.o link_dp_phy.o
 
 AMD_DAL_LINK = $(addprefix $(AMDDALPATH)/dc/link/,$(LINK))
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c
new file mode 100644
index 000000000000..422365ac67e9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+/* FILE POLICY AND INTENDED USAGE:
+ * This file implements basic dp phy functionality such as enable/disable phy
+ * output and set lane/drive settings. This file is responsible for maintaining
+ * and update software state representing current phy status such as current
+ * link settings.
+ */
+
+#include "link_dp_phy.h"
+#include "link_dpcd.h"
+#include "link_dp_training.h"
+#include "clk_mgr.h"
+#include "resource.h"
+#include "dc_link_dp.h"
+
+#define DC_LOGGER \
+	link->ctx->logger
+
+void dc_link_dp_set_drive_settings(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	struct link_training_settings *lt_settings)
+{
+	/* program ASIC PHY settings*/
+	dp_set_hw_lane_settings(link, link_res, lt_settings, DPRX);
+
+	dp_hw_to_dpcd_lane_settings(lt_settings,
+			lt_settings->hw_lane_settings,
+			lt_settings->dpcd_lane_settings);
+
+	/* Notify DP sink the PHY settings from source */
+	dpcd_set_lane_settings(link, lt_settings, DPRX);
+}
+
+void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on)
+{
+	uint8_t state;
+
+	state = on ? DP_POWER_STATE_D0 : DP_POWER_STATE_D3;
+
+	if (link->sync_lt_in_progress)
+		return;
+
+	core_link_write_dpcd(link, DP_SET_POWER, &state,
+						 sizeof(state));
+
+}
+
+void dp_enable_link_phy(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum signal_type signal,
+	enum clock_source_id clock_source,
+	const struct dc_link_settings *link_settings)
+{
+	link->cur_link_settings = *link_settings;
+	link->dc->hwss.enable_dp_link_output(link, link_res, signal,
+			clock_source, link_settings);
+	dc_link_dp_receiver_power_ctrl(link, true);
+}
+
+void dp_disable_link_phy(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	struct dc  *dc = link->ctx->dc;
+
+	if (!link->wa_flags.dp_keep_receiver_powered)
+		dc_link_dp_receiver_power_ctrl(link, false);
+
+	dc->hwss.disable_link_output(link, link_res, signal);
+	/* Clear current link setting.*/
+	memset(&link->cur_link_settings, 0,
+			sizeof(link->cur_link_settings));
+
+	if (dc->clk_mgr->funcs->notify_link_rate_change)
+		dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
+}
+
+void dp_disable_link_phy_mst(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal)
+{
+	/* MST disable link only when no stream use the link */
+	if (link->mst_stream_alloc_table.stream_count > 0)
+		return;
+
+	dp_disable_link_phy(link, link_res, signal);
+
+	/* set the sink to SST mode after disabling the link */
+	dp_enable_mst_on_sink(link, false);
+}
+
+static inline bool is_immediate_downstream(struct dc_link *link, uint32_t offset)
+{
+	return (dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) ==
+			offset);
+}
+
+void dp_set_hw_lane_settings(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	const struct link_training_settings *link_settings,
+	uint32_t offset)
+{
+	const struct link_hwss *link_hwss = get_link_hwss(link, link_res);
+
+	if ((link_settings->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) &&
+			!is_immediate_downstream(link, offset))
+		return;
+
+	if (link_hwss->ext.set_dp_lane_settings)
+		link_hwss->ext.set_dp_lane_settings(link, link_res,
+				&link_settings->link_settings,
+				link_settings->hw_lane_settings);
+
+	memmove(link->cur_lane_setting,
+			link_settings->hw_lane_settings,
+			sizeof(link->cur_lane_setting));
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h b/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h
new file mode 100644
index 000000000000..717e078fd564
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_LINK_DP_PHY_H__
+#define __DC_LINK_DP_PHY_H__
+
+#include "link.h"
+void dp_enable_link_phy(
+	struct dc_link *link,
+	const struct link_resource *link_res,
+	enum signal_type signal,
+	enum clock_source_id clock_source,
+	const struct dc_link_settings *link_settings);
+
+void dp_disable_link_phy(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+
+void dp_disable_link_phy_mst(struct dc_link *link,
+		const struct link_resource *link_res,
+		enum signal_type signal);
+
+void dp_set_hw_lane_settings(
+		struct dc_link *link,
+		const struct link_resource *link_res,
+		const struct link_training_settings *link_settings,
+		uint32_t offset);
+
+#endif /* __DC_LINK_DP_PHY_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_training.c
index 0011618ae978..60db0939492b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_training.c
@@ -38,6 +38,7 @@
 #include "link_dp_training_fixed_vs_pe_retimer.h"
 #include "link_dpcd.h"
 #include "link_dp_trace.h"
+#include "link_dp_phy.h"
 #include "dc_link_dp.h"
 #include "atomfirmware.h"
 #include "link_enc_cfg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.c
index 3a02ba0724c1..f0811557668a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_128b_132b.c
@@ -30,6 +30,7 @@
 #include "link_dp_training_128b_132b.h"
 #include "link_dp_training_8b_10b.h"
 #include "link_dpcd.h"
+#include "link_dp_phy.h"
 #include "dc_link_dp.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c
index 9021f7bca166..c3eeed9303b3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b_10b.c
@@ -29,6 +29,7 @@
  */
 #include "link_dp_training_8b_10b.h"
 #include "link_dpcd.h"
+#include "link_dp_phy.h"
 #include "dc_link_dp.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.c
index 319f0a59a3c8..f84b6ea53e8b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_auxless.c
@@ -27,8 +27,8 @@
  *
  */
 #include "link_dp_training_auxless.h"
+#include "link_dp_phy.h"
 #include "dc_link_dp.h"
-
 #define DC_LOGGER \
 	link->ctx->logger
 bool dc_link_dp_perform_link_training_skip_aux(
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.c
index 821f4896d77a..468ac5a2557b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dp_training_fixed_vs_pe_retimer.c
@@ -34,6 +34,7 @@
 #include "link_dp_training_fixed_vs_pe_retimer.h"
 #include "link_dp_training_8b_10b.h"
 #include "link_dpcd.h"
+#include "link_dp_phy.h"
 #include "dc_link_dp.h"
 
 #define DC_LOGGER \
-- 
2.39.0

