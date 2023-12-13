Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BF1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D2F10E703;
	Wed, 13 Dec 2023 06:15:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E6A10E703
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbnGX9t5w5dswGEcmheeUob8wFRCjR+yWo2OSP4pSyNhwfqfIo4hAwEWPzxFAXl8cSguYy7MGpa2+4frbBP59Bql3pM6WkHOKsxgNATS66+AXgUlOXwilOYuWBLfc9DKsgdABHk4toN4itWqvQ/kXyfGMphAbg1rMXPPlCBb52gq5uCz+QRaKqybsg+//mN1HDIhvzK9OisG5wkuAPfVr0utpTe+V8it2hi5tzfNVGN2CgVMng6+gwMkzf3SJ6isZNq8XelJHn1PcFT3zBTmSvb5skA6nfLQn0rDPamCCfs/zc/ZQiRLJoHaWnSsV8EdgPu0sPWL1etFVa0c+k5lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZurmFbSzQjSOYerasTNJU5DO0TxLQLPa3dp08SUyJg=;
 b=BJnrBGz2lJSl/VokBhy+pLsLzJWJAd8gxAWEWB5tEgWH2bNwTY/TVy1ao0Q/lxMcTRs3GD3drt7npr15TffjpMazCXZkDKD0Y/XjlvzYO3QvEw/XEoCeaWrr8E7fWOPbK+rDhBSZUp70/Ul6P4GawMjR5yFk2UHEYKEqsItP9YzgijqfpLnwij4dmvU75xAOlfYKwPiWMDolyK47Lf3Pmr7XASwXarlkc3lJnnAHAd7bIP270Ug7psQaSLLUHmp3tgA1mkuOfmif3sy1mKivtwqUVwUEJZ8Hfmhsufyo5MA8JYDCquN0xImCkTffbIgC70l/q5DofuF4CAojeVRehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZurmFbSzQjSOYerasTNJU5DO0TxLQLPa3dp08SUyJg=;
 b=e0gNDhW4RuJfM46IfkOchXm8LPlKD3d1RSWuZf17V5Y2sbDKWzg3yEUNSa1x7fS5q41TfIjgrnNHseGjeGpqG+hWgz4QQw+5/0VG/cMDMS7zCbDS/J+8wdGL4QS68U446EM7AaA02IaUik9e05kcf88/iOqnxS1PIz73qufRmgU=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:15:16 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::78) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 06:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.8 via Frontend Transport; Wed, 13 Dec 2023 06:15:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:15:15 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:15:10 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/25] drm/amd/display: change static screen wait frame_count
 for ips
Date: Wed, 13 Dec 2023 14:12:25 +0800
Message-ID: <20231213061227.1750663-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bc3cc9-7c6c-4f60-626e-08dbfba2e02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rspDURaCwO+xqcQjVTrq6EuG4L1pOKJ4TNCCR1t0B0ZOXjm0IEcFUQq6DXtZe5yrXRKTpziCngLkJyWHrWytIzc+j3K8qBUOazWzPMj1/qhyl7h1Eb6CnAtM8/UJiAtvHwvj6ffHNi1q0Dr5FrEX83LeL5mONd/olzc1bGhn5P1W+FGCeB7ZQwIBxmjLvuc2F6iZ8zquGRgOxzH6hmmCLbvw+CqHW0As0Hx3vkRNn/fDsrvdp2qmYHfR2tBy51v1nJ9mJf579OAiQ2z+K4guV5ZXv9mn7+P0JX7TCU5mtJhxT0AacxwBorcqmoiHT+yQ0+1UVJD4yETkUiBI6SSnGcp2uqVmDseJSRcEZP/84/BJzU1zEMvw8Wl1EowzGLVxlnAj2iRfOnTNQcSg/8URRULduaEKdPfM1O+eUh5rm1n88RZgKXHbDY9GWFsu4bgL89bUJFWkdLYspsnwTJjLYWXImlcvfdCJ4ynjbDoBDd71/Ucm9f488mtHsGr9NMV7uJKIZpq0WS+VmOoklZQD4JdkLKlKmv/k6fxaT7NahNVQRgFPL3+q+oYNd7axUxqc9Nv0qsZ1CzEYk9pfjcxkj2qAMe2bTC9MF8nqItu61mi5KYunhkbB/iuujOXTwptdo6QAZr5trjn7Zrq4jaIHRXA9Pch1F6eYQ9Pm6Git20y76ycovWSux6qeVIOtefIciEtu50F9IaiyDzQFXyxD3bt3F3H4zbmmovSAKNDxkKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(70206006)(82740400003)(81166007)(356005)(36756003)(86362001)(70586007)(36860700001)(47076005)(83380400001)(426003)(1076003)(2616005)(7696005)(6666004)(2906002)(54906003)(6916009)(316002)(478600001)(4326008)(5660300002)(8936002)(41300700001)(8676002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:15:16.5904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bc3cc9-7c6c-4f60-626e-08dbfba2e02e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Allen
 Pan <allen.pan@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen Pan <allen.pan@amd.com>

[Why]
the original wait for 2 static frames before enter static screen
was not good enough for IPS-enabled case since enter/exit takes more time.

[How]
Changed logic for hardcoded wait frame values.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Allen Pan <allen.pan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 41 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  4 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  3 +-
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a270b4bf7b95..f622f4f0e1a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -982,6 +982,7 @@ struct dc_debug_options {
 	unsigned int ips2_entry_delay_us;
 	bool disable_timeout;
 	bool disable_extblankadj;
+	unsigned int static_screen_wait_frames;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index d594905eb246..a630aa77dcec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -68,7 +68,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.prepare_bandwidth = dcn35_prepare_bandwidth,
 	.optimize_bandwidth = dcn35_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
-	.set_drr = dcn10_set_drr,
+	.set_drr = dcn35_set_drr,
 	.get_position = dcn10_get_position,
 	.set_static_screen_control = dcn30_set_static_screen_control,
 	.setup_stereo = dcn10_setup_stereo,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 582852ed21fb..ad710b4036de 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1312,3 +1312,44 @@ uint32_t dcn35_get_idle_state(const struct dc *dc)
 
 	return 0;
 }
+
+void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
+		int num_pipes, struct dc_crtc_timing_adjust adjust)
+{
+	int i = 0;
+	struct drr_params params = {0};
+	// DRR set trigger event mapped to OTG_TRIG_A (bit 11) for manual control flow
+	unsigned int event_triggers = 0x800;
+	// Note DRR trigger events are generated regardless of whether num frames met.
+	unsigned int num_frames = 2;
+
+	params.vertical_total_max = adjust.v_total_max;
+	params.vertical_total_min = adjust.v_total_min;
+	params.vertical_total_mid = adjust.v_total_mid;
+	params.vertical_total_mid_frame_num = adjust.v_total_mid_frame_num;
+
+	for (i = 0; i < num_pipes; i++) {
+		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
+			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
+			struct dc *dc = pipe_ctx[i]->stream->ctx->dc;
+
+			if (dc->debug.static_screen_wait_frames) {
+				unsigned int frame_rate = timing->pix_clk_100hz / (timing->h_total * timing->v_total);
+
+				if (frame_rate >= 120 && dc->caps.ips_support &&
+					dc->config.disable_ips != DMUB_IPS_DISABLE_ALL) {
+					/*ips enable case*/
+					num_frames = 2 * (frame_rate % 60);
+				}
+			}
+			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
+				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
+					pipe_ctx[i]->stream_res.tg, &params);
+			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
+				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
+					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
+						pipe_ctx[i]->stream_res.tg,
+						event_triggers, num_frames);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index b7bafe7fe2fd..fd66316e33de 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -86,4 +86,8 @@ void dcn35_dsc_pg_control(
 
 void dcn35_set_idle_state(const struct dc *dc, bool allow_idle);
 uint32_t dcn35_get_idle_state(const struct dc *dc);
+
+void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
+		int num_pipes, struct dc_crtc_timing_adjust adjust);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1aa4649fdc35..39594e8ffb5e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -780,7 +780,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
 	.ips2_eval_delay_us = 200,
-	.ips2_entry_delay_us = 400
+	.ips2_entry_delay_us = 400,
+	.static_screen_wait_frames = 2,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.37.3

