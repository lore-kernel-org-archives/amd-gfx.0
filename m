Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F5BC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD951134A1;
	Fri, 22 Jul 2022 20:41:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F8311BC1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQqSIjXmo9JBtjgffwcL9IeGQKaTOIOpEe3M9BVAzQ8Iv7F17dz1NShEQKuag1U4l38HKgfQK0/+G3s2ORwG3C+f31FDG1wDuwAD0QfSR8lgXn14h3fRN7kqGmHC3gfXBVgQXHq/DnUqld+lKMNozDaX3OUlR7Z0JFOc/NaA8JvO5knf0AaxUYl1r2BnXJuWy/8tG+vp7uX6f8pYxhlxyjgsC4dlLYl5V+3ykOPppAlSW/Msnuo0dDW5klY75Hz8zScb334cpnOZQiSB8tgt4HEwSvf7wBNDX45K2vGGXpV87GxaYXS/sdOpLpY1KShTGwM2I0sznXuT3IGts2iLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUaGTBhuN4yJ1X0lJ1/YlqSQLgppVpmkNrk+D5zRfL8=;
 b=m9e7GCu2fSarAB0g3NzJ1BPfTECQLTV0weZMSQNXZRmI8CuT7w+MaER+oJvjQ/9sY+61/IaKY6zZsF/7vbxXVYjhJxFgfOdb7BCeOvrHK0u/XO4qPwJGEyoM3VWJO+ODLVz1OhNFDL0xYSojpyzzRrqEPeCcc0djpiLFKkSqKG/F9UXIfmnezXMo0e6vaBlKW7tJL75JffURRk0UWuGG9M7BLg9SF1IUDmWeNJXh3pg0qajuoTNo0spuwOy3QiX7l3q8Z6w2zWM4SNf+RDjpmog2yIOJeIdYEH9ZIIkBTMgrA9nc4QT6Mv0LBsLlc49xxftDiSNQ14zm1Dy6LCmSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUaGTBhuN4yJ1X0lJ1/YlqSQLgppVpmkNrk+D5zRfL8=;
 b=d7AKAQ6AbArGbRXUqe5PUOu8tK8h91e9J6DOna7JT5T0laYV9mbs1F7C07VTvjuWosSRYSN8krfcGSka5wj22WXMMVyJRnrXwEljSChyjORgXOtpt6kauAeUE0VoFvgNTlfSJvxlVEPDaJazMz0q2bf6/khSRKyt6wf5/BrCyZM=
Received: from MW3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:303:2b::7)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:40:53 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::4a) by MW3PR05CA0002.outlook.office365.com
 (2603:10b6:303:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.16 via Frontend
 Transport; Fri, 22 Jul 2022 20:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:40:52 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:40:32 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/31] drm/amd/display: Create patch bounding box function for
 isolate FPU
Date: Fri, 22 Jul 2022 14:31:20 -0600
Message-ID: <20220722203137.4043516-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095743f9-985a-48a3-b47d-08da6c227843
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAldwx/mGUdFmtKzhbcV/n1UTmPKlQYHzYZyiTWszQqfPf+5vWbTqJvAZl0RLhPmSx4a2CQ2ZplZhjjnvexeyDWxCN7rkN73wm4w7IfnHs2uo/602gclezSP/dFslkzMLOKclL8Q9jaTnsGpkzXQCqKQ4MqELJaXvZ7aazuLK6EXTdxbxr3k+cceUuoSao35kiRlMxJ92v4KPST6/gUnSesC8onLuxmut04tDUrPRC5YeraFn1Bi8hLo0CPqG4zGbX/13mkjNm4Cius/wdTgEY6/oDY82YTqIWU6eYGKB7NKdhkzv1X6zaD3twTb97ztkZVriuZkiUkceStnLFKFy0f062aBIOWyfVIuxi1ZvD/IqVxVT8oZyv4oQ6Wlepsg8E75JuOM4m5wsGm9UUt0XZp+XyTq4D1hDZ3PPui7+GubCNOCRxO25Z+tRC9zhuKAvLKvwgP8nh7iaDt4uzxGkwzu8T/52xUBBaz9Rqujlorjlpoc0SLVtobywGSPZ7gVmBqyhLjQoBq4fOnfNa549ZlaPbds9y8vBBq0rnpqkKgP6YlfKAkjCoFsf00rxHIG0xgfAvdEetadem9sBnE8X7AtUQhAXSFS2YEWRl7Gonh8zKOcMf+WCSqHNmzJdsSxrJZQC9w3oiqXxfHz49CcBynryVXxgBIOoYj4mRiub7Cc5fqUVWjdaG0XLz+rC+h5IqUyCYHIR+bWsPBfIuk2F175skO8mWSUSe/RH/TeJXdL0H+U+ot6I2C1qDOU6Q6EI/drJKQ8uzyl3kS+HnPJrucyuB5rRSHGEoSFnpXBDZO2TKd1vk1jmuvjNPSc/ZEGT0eiD8UtdKxrMBEq41fFGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(2616005)(356005)(41300700001)(82740400003)(478600001)(81166007)(26005)(426003)(7696005)(86362001)(336012)(1076003)(16526019)(316002)(54906003)(83380400001)(186003)(6666004)(47076005)(6916009)(82310400005)(40480700001)(40460700003)(5660300002)(44832011)(8936002)(8676002)(4326008)(70206006)(70586007)(36860700001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:40:52.6862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095743f9-985a-48a3-b47d-08da6c227843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

In the DCN30 resource, we have a small patch to the bounding box struct;
this patch uses FPU operations. This commit moves that specific part to
its function under the DML folder.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 19 ++----------------
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 20 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  2 ++
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index e5e54097a07d..8bdf3573610f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1521,26 +1521,11 @@ static bool init_soc_bounding_box(struct dc *dc,
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
-
-	DC_FP_START();
 	dcn20_patch_bounding_box(dc, loaded_bb);
+	DC_FP_START();
+	patch_dcn30_soc_bounding_box(dc, &dcn3_0_soc);
 	DC_FP_END();
 
-	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = {0};
-
-		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-			if (bb_info.dram_clock_change_latency_100ns > 0)
-				dcn3_0_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_0_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_0_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
-		}
-	}
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 9e32b45b63dc..6dd9a70314c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -721,3 +721,23 @@ void dcn3_fpu_build_wm_range_table(struct clk_mgr *base)
 	base->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
 	base->bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
 }
+
+void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *dcn3_0_ip)
+{
+	dc_assert_fp_enabled();
+
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = {0};
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_0_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_0_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
index 3e4221af1c1e..cab864095ce7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
@@ -71,4 +71,6 @@ int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 void dcn3_fpu_build_wm_range_table(struct clk_mgr *base);
 
+void patch_dcn30_soc_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *dcn3_0_ip);
+
 #endif /* __DCN30_FPU_H__*/
-- 
2.37.1

