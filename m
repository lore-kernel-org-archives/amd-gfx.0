Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BCEC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807BAB649F;
	Fri,  5 Aug 2022 17:59:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CD4B649F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWSpEIEEGBMY4/tMdy0uTTY4wrHkAQ9txrKkYEy2S0yluj5OboDoQ4miVGFMh7ZVVc9Wf8OuYPOKAPqBBGaBd3eVHRiSxMTjdrXJB8D5AqfwtXEKklq9hQ9JqAjkaBl4nUkdflx9a3KmZH4/525g39PLJXeBbO2VVj87SP2q5yKE5gZ4aoQ+no9E3Bh8a3bf5C7MG5wVLeDy7z4z3oFyWdANzWaJQGE1hq56MV48/Gboll1JH9zahyHZ+i5V3el7ISqMUmburBf7JSTUT0fi1L4Hd8NRr8E7qE7T+7dd+ZTlfIDTjD9s8eQUJwNCaz+y8du4AXGwAHUo1abo9+BdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAU5yMfoE9aK4BKJJz7YH4Zzwn+haTuie3B2eCL1hjA=;
 b=ZaMhIHB5/oR64MifJsXO0RiNpKT6BfOdVcMOpvgaNKlC9X6Jn2OXi4QnUhjMnpEyroZVGdEwY1ZHYMnzzMQvdwm/lPkADiGZuX1dBdP6n33MCZj8rUQhHo1Q/fpG2pNIAJf/kfQVUoRQ/M5tzJlk29uonwBjOQlslLuj/8Q1o/1Moa1DAArsSOWUuMQsFEKOK+HwGUux6m2K2RAsSQBEh2z9LEf507oLEeqRRQu2kSvrDXqM+pvpbf5w9gOB7T8W2oZU6VkvaPmvQRWiVUc2GIioi7ERwJ1+y6bWPK2DVMT4RqqGJPo1MaT67dUoiM745dA66hzNxMW+7Q0yK4p+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAU5yMfoE9aK4BKJJz7YH4Zzwn+haTuie3B2eCL1hjA=;
 b=3gcr6vHnocuRJ4UnzS24wci7siCMwx7J8vd6vnhRg7hvy3mU0P6jjb9o96U40JeCcJURgYImkSffrX9MpuDfqUrhZJU/YR7lY2jv6l3ds0cOjObBxuT0XfEG3F04b5heE38iIjYvT6WE7RHuZYek8pkJnUlvs8Mtr6qcyeo4IlA=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 17:59:37 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::56) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:30 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:24 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/32] drm/amd/display: Refactor SubVP calculation to remove
 FPU
Date: Sat, 6 Aug 2022 01:58:02 +0800
Message-ID: <20220805175826.2992171-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 182189f7-3906-4b8f-e495-08da770c432d
X-MS-TrafficTypeDiagnostic: DS7PR12MB6143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t4J7cL36zG2oTnBOe9MfhjKmrewzmuJPs0LXUFIR1dSPTaPFtiD1zeKdsUeNIfQiAjHZM80tIPLwia0lXzOToIxVbb6hHqozBQ4+WS+7DVwVrWL7sFS0Di9EfW3eDH5BhyO6ffCW9nfevpLnh2NditKmpMZi/VYHsGQQ2Wzi/pPMB5ZJMZAtt61t604122ydMoU5OVAYAviT19vTvNZibiKCRN7dA0Q6QARL+0Teo6boxUnZK9sIpejOIS8A481c6Z/Kn6RX9PvCr33lBypTifxejUdxXbAHOD2cIun737cU5BhW3cFOl5UhjL92Bex+I8p1WegNjnjT3wQQzlPOlRKoLW/WyMuXswdtq6o9xM/+X3G2H6F8db0IOfJhcYglInj+qHt/q6G/S22uSaeRXVAGLPtJ/RM5xFNhWmzv4wCGHBKk9VcG4qLfbD+pj6g9hNycp2xhGQh4jERtYFI3lS6sMDqFEjIQAIRx2QaZZQZSm6PPkvn2AojaFQWOGnHWDAatfq7QMfibj1ZyMKLWxHZWP9qfAJQ+ewr5q+QBn+8ydCM+gnJRtXEhw6lTNd0Mc4IxCptS4brlHHg2wFcRVLFXvm0FTUCMJTQAo4LWjgrDKNiDrj3wSb3J+y3A3ihgSDBLEdMlB7SEKLpXDPs4VNOlsHYg0VJcfqN59yt4+PtYvPfBUe7R1/VkjqHo35edL5vFigl44PpBy0TCJDrKuCTYeM843JODaiIpG2+HdG9QlAGJr3hyd+q0YCoqA5O98X9SOtRHAeRCQfohJ2Lm8/e2M37iFSKoVlJBaKFaEMfZ9ZqY5bvnNeR2n/6gBYZPDDyprVcnbXmvJ+X6ps3cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(4326008)(8676002)(5660300002)(40480700001)(70586007)(70206006)(316002)(82310400005)(8936002)(40460700003)(2906002)(6916009)(36860700001)(478600001)(86362001)(36756003)(82740400003)(356005)(81166007)(41300700001)(26005)(54906003)(2616005)(83380400001)(47076005)(6666004)(7696005)(426003)(186003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:37.5021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182189f7-3906-4b8f-e495-08da770c432d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Refactor calculation to remove floating point operations

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 86 ++++++++++----------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c7582f834a43..ffa1c0148330 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -417,43 +417,42 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	struct dc_crtc_timing *main_timing = &subvp_pipe->stream->timing;
 	struct dc_crtc_timing *phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
 	struct dc_crtc_timing *drr_timing = &vblank_pipe->stream->timing;
-	int16_t drr_frame_us = 0;
-	int16_t min_drr_supported_us = 0;
-	int16_t max_drr_supported_us = 0;
-	int16_t max_drr_vblank_us = 0;
-	int16_t max_drr_mallregion_us = 0;
-	int16_t mall_region_us = 0;
-	int16_t prefetch_us = 0;
-	int16_t subvp_active_us = 0;
-	int16_t drr_active_us = 0;
-	int16_t min_vtotal_supported = 0;
-	int16_t max_vtotal_supported = 0;
+	uint16_t drr_frame_us = 0;
+	uint16_t min_drr_supported_us = 0;
+	uint16_t max_drr_supported_us = 0;
+	uint16_t max_drr_vblank_us = 0;
+	uint16_t max_drr_mallregion_us = 0;
+	uint16_t mall_region_us = 0;
+	uint16_t prefetch_us = 0;
+	uint16_t subvp_active_us = 0;
+	uint16_t drr_active_us = 0;
+	uint16_t min_vtotal_supported = 0;
+	uint16_t max_vtotal_supported = 0;
 
 	pipe_data->pipe_config.vblank_data.drr_info.drr_in_use = true;
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
 
-	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
+	drr_frame_us = (uint64_t)drr_timing->v_total * drr_timing->h_total * 1000000 /
+			(uint64_t)(drr_timing->pix_clk_100hz * 100);
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
+	mall_region_us = (uint64_t)phantom_timing->v_addressable * phantom_timing->h_total * 1000000 /
+			(uint64_t)(phantom_timing->pix_clk_100hz * 100);
 	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	min_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)min_drr_supported_us / 1000000) /
-			(double)drr_timing->h_total;
-
-	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-			dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
-			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-	drr_active_us = drr_timing->v_addressable * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
-	max_drr_vblank_us = (double)(subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
+	min_vtotal_supported = (uint64_t)drr_timing->pix_clk_100hz * 100 * min_drr_supported_us /
+			(uint64_t)(drr_timing->h_total * 1000000);
+
+	prefetch_us = (uint64_t)(phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total * 1000000
+			/ (uint64_t)(phantom_timing->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp_active_us = (uint64_t)main_timing->v_addressable * main_timing->h_total * 1000000 /
+			(uint64_t)(main_timing->pix_clk_100hz * 100);
+	drr_active_us = (uint64_t)drr_timing->v_addressable * drr_timing->h_total * 1000000 /
+			(uint64_t)(drr_timing->pix_clk_100hz * 100);
+	max_drr_vblank_us = (subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
-	max_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)max_drr_supported_us / 1000000) /
-			(double)drr_timing->h_total;
+	max_vtotal_supported = (uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us /
+			(uint64_t)(1000000 * drr_timing->h_total);
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
@@ -547,10 +546,10 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
-	subvp0_prefetch_us = (phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total /
-				(double)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp1_prefetch_us = (phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total /
-					(double)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp0_prefetch_us = (uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total * 1000000 /
+			(uint64_t)(phantom_timing0->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp1_prefetch_us = (uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total * 1000000 /
+			(uint64_t)(phantom_timing1->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
 
 	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
 	// should increase it's prefetch time to match the other
@@ -558,16 +557,17 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
-					(phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1) /
-					(double)phantom_timing1->h_total;
+				((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+					(phantom_timing1->pix_clk_100hz * 100) + ((uint64_t)phantom_timing1->h_total * 1000000 - 1)) /
+					((uint64_t)phantom_timing1->h_total * 1000000);
+
 	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
-					(phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1) /
-					(double)phantom_timing0->h_total;
+				((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
+					(phantom_timing0->pix_clk_100hz * 100) + ((uint64_t)phantom_timing0->h_total * 1000000 - 1)) /
+					((uint64_t)phantom_timing0->h_total * 1000000);
 	}
 }
 
@@ -618,13 +618,11 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			(((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
-			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
-			(double)phantom_timing->h_total;
+			((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * (phantom_timing->pix_clk_100hz * 100) +
+					((uint64_t)phantom_timing->h_total * 1000000 - 1)) / ((uint64_t)phantom_timing->h_total * 1000000);
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-			(((double)dc->caps.subvp_fw_processing_delay_us / 1000000) *
-			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
-			(double)phantom_timing->h_total;
+			((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * (phantom_timing->pix_clk_100hz * 100) +
+					((uint64_t)phantom_timing->h_total * 1000000 - 1)) / ((uint64_t)phantom_timing->h_total * 1000000);
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
-- 
2.25.1

