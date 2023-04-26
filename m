Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBFBC7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A234410E59E;
	Wed, 26 Apr 2023 16:28:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A2910E46E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlYmcE558LPnhrfcJjnYvY62MbwvsdJDlhNFHFP39gMiLQ6UsKbol8B+YKVWUS8jQ/1WZgjTB7rGJx5cnO+VvjukL+MaeX0nozW07nru0k6MsGYi0TRY/DjkiAGYL5o//dHEj+tjcxiftTkdGEMQM6cRW9TUlBMJ5ETtySFjeHmah0++cJcBB3OeU33Qn7vxMcRLJrcEyzIj6ybSTTTo/xjcCh8dXsMogYK3rzNFsqw4F/p3p5pYnRLyF0+FzkWenaL0XGOqnaXTnNEwVTkecV5tDbgbFBOWC1idsTp14p21yCWwVqMe/6H2g46tCKtuW+V0bEEmWwmJdKfQYOh4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2jysxPmPPNdOkKFlX0+Q7UcjNIAbMvb9PTZzpxpq+k=;
 b=VdGLvSGZ8a3WGb9PI2igitTuLr+LTlc0nUbFruIheoOtchdBXBRTuANF6rft3CC+3PDBbFM3uPIzendmYq/2ZnDKUN2DCYVKSqgapKgqImawIPTMpXJKj7tcNn07COTxA7TcLC54o9qoFtDHZlW8w6A9ZVi2Pq2m2LQ9cRf2n1vuAyO8ZvCubHuhLTez5vbLSG0Tm29r8d6BA/vViI/8LvQhZ4vPUhXnZkfSyYfAGokiV0tkdP/YspNgURLbBAmda1b8rqeWu7m+gsvM4FyX1wXKTH+GCbBzJ54tmEUiS5h0qyiYqJ8H+S+jQ5JVXNqsLc/FbnrGgSjVmZfEF+mlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2jysxPmPPNdOkKFlX0+Q7UcjNIAbMvb9PTZzpxpq+k=;
 b=ct4padYReeR78RGosaLjFl27meogMtBoucHVRG/GxEtmD9x1x+4W6oWM4YKmVZvX9mj3hrAknM9NoF2BzZumLSOTAHewPvAgqVhU97TC3R0WBlGrQ7NsXqsa+p4txzBKPMm+blbY1/rakeohCLYCFxLkBqSk2nx9UuWjL6qUlyg=
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 16:28:00 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::2a) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Wed, 26 Apr 2023 16:27:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:27:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:27:58 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:27:55 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amd/display: Adding debug option to override Z8
 watermark values
Date: Thu, 27 Apr 2023 00:27:07 +0800
Message-ID: <20230426162712.895717-4-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: a6007061-488b-4fdf-71b8-08db46733335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPbtIQin9ziL/np/7rTtY16nmTxrEDG2mBTE30v8M8oKYwNFtYToMLWFu2tCArgr6b+iRBuu2cHsNvsN7kO3KGhKsnM3z+R99AAYow3jM72rg7rQnHtr0TL5hYlcRiBEPtj+rMMcQ94nBjTPy5ebYtAkut6PMZg5EBXyIk4xC0BpkE1lLPD4ut7qS4LoTk+Di38GWWp12MI2F40F32+Oxek/Srb8LrmG5tCd8vmRQoEkY/MCwLkm/Ffyjn3JC/L8bJiPmzooh2BJ/Ueh6faa+Rp71cYpE5ouOLIfNer5p3sMuIt69sTfyyi+PnkAA46bJVRPBqM/rEMpPCRTflp7pHl7BgCnVadNq4eh18hD4VDbbchUgPTz5LxRysVfRw89XNXxc/s6wyxt6o17oFGULMxnOQ1ZGMUOWqvln2/EScwGgoPPJHFVL7y3rw/Tr8J+nGPrb/7+QcsnQaJDbA5+52Lgyt0fetpQpp7y/J+eFK+SoeDaQ/xUnN+EmSrPtFo3ntnpp+oiC3IesOJ7gWak7Htgk33EJ3gPq8YsOcBTP37rLYXXYoTVPP0+fgPg/peqjtVnKwgIkDYIvCIHTKprGz0de8g7kM0jxH8ZSsQJtY7098Bn6c4MgrVFRpdLf/DlmACPozvGCnpN2kcunpAQs1NJXpcCs8yvUuOaUvg4vbOHREg86u1cvF0O1k9TLdqe3d0PWarMdRXdx7FIusyRu6vcw3h+iZyPs5dz0VRWEq4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(36756003)(40460700003)(478600001)(66899021)(82740400003)(6916009)(316002)(4326008)(70586007)(70206006)(40480700001)(356005)(41300700001)(81166007)(8936002)(8676002)(2906002)(5660300002)(86362001)(36860700001)(2616005)(186003)(336012)(426003)(1076003)(26005)(6666004)(7696005)(83380400001)(47076005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:27:59.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6007061-488b-4fdf-71b8-08db46733335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
Cc: stylon.wang@amd.com, Alan
 Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Adding debug options to override Z8 watermark values for testing purposes.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  |  4 ++++
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 892e3adb99d9..fea68383bb61 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -700,6 +700,8 @@ struct dc_virtual_addr_space_config {
 struct dc_bounding_box_overrides {
 	int sr_exit_time_ns;
 	int sr_enter_plus_exit_time_ns;
+	int sr_exit_z8_time_ns;
+	int sr_enter_plus_exit_z8_time_ns;
 	int urgent_latency_ns;
 	int percent_of_ideal_drambw;
 	int dram_clock_change_latency_ns;
@@ -769,6 +771,8 @@ struct dc_debug_options {
 	int sr_enter_plus_exit_time_dpm0_ns;
 	int sr_exit_time_ns;
 	int sr_enter_plus_exit_time_ns;
+	int sr_exit_z8_time_ns;
+	int sr_enter_plus_exit_z8_time_ns;
 	int urgent_latency_ns;
 	uint32_t underflow_assert_delay_us;
 	int percent_of_ideal_drambw;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index a5b1e4bb1a22..3407f9a2c6a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1890,6 +1890,17 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
 				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
 	}
 
+	if ((int)(bb->sr_exit_z8_time_us * 1000)
+				!= dc->bb_overrides.sr_exit_z8_time_ns
+			&& dc->bb_overrides.sr_exit_z8_time_ns) {
+		bb->sr_exit_z8_time_us = dc->bb_overrides.sr_exit_z8_time_ns / 1000.0;
+	}
+
+	if ((int)(bb->sr_enter_plus_exit_z8_time_us * 1000)
+				!= dc->bb_overrides.sr_enter_plus_exit_z8_time_ns
+			&& dc->bb_overrides.sr_enter_plus_exit_z8_time_ns) {
+		bb->sr_enter_plus_exit_z8_time_us = dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+	}
 	if ((int)(bb->urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
 			&& dc->bb_overrides.urgent_latency_ns) {
 		bb->urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
-- 
2.34.1

