Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC04C07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734C010E8A9;
	Fri,  1 Dec 2023 13:29:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2312410E89F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmt0YMnGd56tMD0gyw/CgX+vEHCcBzYg4TkjGbvhl+xrajLveVM5O6vGkNkoWQiAKvvK0DZgr57Rnd4dsAqLWl4g/buX258oYgWGiiphkWm1ZJlO++UYegbnRpTKdfEfyBzE8qhXdFEG6mCEtExLfXLdCPCbbUl81bcybgwGuro0l+ypdlu0hJQxu+Ccj4d3ihaqV6x5Q8+XjFI0gscVXjs5u853XhVdEUJ8NbufiuaVUSDkxHbCpNOKC3zeAiU4LHMSe4+qA7xDLExWuoFVqD+GHCkSTrfg0K9zsVA2sKQkO82b3h8HiYx1efKJoYNsZNjI0yxh0Ug4cMl+rNEGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DX5yowpqKlvVEtZNAG5FRwLsG6QPqvMRPf7X95R3bw=;
 b=m50u0wK9G+tVYac6Y4xn0hIWbvYefoowfc3Xoist+42tYjrJADtPfaUL992tByxaV++bdQQeU1wlMbpvJZ5NTUEPmGTWqvHnTIunsk9Pf+ccAW2ExY3c9g9NgFueEjl8OVdBLSCNXh/1m+encmzvV77A9ESUI8+yD5UptW1Ermb892p9oOnGbAyViXYTHplkvCFWe4FTVitcA2xmsJFJSmizjCW4iY9iAMKH3PDc+O271/I6FKEP4ng3BwsS7Rf5rthCnaX/ig1BMjSlWsfTZvkzT1J7xFq8R9KgPhfc+sYzoxUIOvwjUsBSoVnlx963FRglvUTuL2NBWewbd+s65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DX5yowpqKlvVEtZNAG5FRwLsG6QPqvMRPf7X95R3bw=;
 b=pl+TtXGqX3mBSgoBJHVx042KNGuRzgr7OvK5JDhM8dO9UV+Lb5xnxUOURgdbmsqYLW58OAQhLmpQ7gjDfDRIO8oGo8Cg68VnGYM90ZnkX9HWHL7Ey100HI6E/+fBnzizDHLjq5O8nAxVJmieaeXDN0mrSkUP4B2rPJBndVk6SfI=
Received: from CH2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:610:4c::11)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:29:36 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:610:4c:cafe::15) by CH2PR10CA0001.outlook.office365.com
 (2603:10b6:610:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:36 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:33 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 43/47] drm/amd/display: Disable DWB frame capture to emulate
 oneshot
Date: Fri, 1 Dec 2023 06:25:39 -0700
Message-ID: <20231201132731.2354141-44-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 741d0194-5ef5-4f7a-e933-08dbf2718ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/PAodojAdsrQlOOGKwujJvFFXtb04zKctOXl460muPRap5+buxEZv598Plhz5gkT5s8LVngDpoMemNKDaMdg3WqERPX0pUxKlU192eKace43P+hrdBVksVUx5p1sUPla3nZ1q45U2f4PWLi4O9/jmxx21eV/m44VvhhYnEwy3jH9Esv/H0jxMA4u0a6yaBGiCmrYCDjzOiAXUVdDCoYWIguFdBAaESMdnR50/Ujeyi+Nw2+9FNMpShyI3UR2ZVE28wrL94ad9ojgJ4GEevp1caxnuwxw2URD6YiWRVn2EkLqXKVunYyI84ADMCYFDbIjaKLc1XKh/jxJ66U9HmzA2MtvylVATlmYmmYehb8HiI81YD+fFROFwy2+7O4Wi2scTNVy+2aXZGsSwq1h47VZc0Y9RmNR7nOj4zZRizFIWZkt6fw1nTPYtaa4xNt5Y8q8XikiYeBgT5uun3FjVJqV7YfoAXLb9lnYIORrmSUyohDBRRaxfF2kPKUU1PMVFbo2zDOjAZgLbozAbNJGAsMXGucjOgcxzRb1VpP2KhNngpcSFURo/irc6J9N0UxlYEv4t7wXojwTtSQq2eD3knnmGnP3ndVeVYrD6qGXJoVQRXkw3DB37WI+ZXrh5EFHNmFUtTeEOwmZmnXhUvIc3HuRfrie2ShzOJOn+5ok9LZWv7uOJdIV0CvTRbW7nwWX390NnRTHhACLBOCZ4mlgEmM89iyqpPS8Vei1XGZxy0kTDaci05UjnY7zaJmQy9rnu/UVj34vi1lit3r+aJGg7oRfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(83380400001)(82740400003)(426003)(336012)(2616005)(26005)(16526019)(8936002)(86362001)(47076005)(81166007)(356005)(1076003)(40480700001)(8676002)(478600001)(70586007)(70206006)(54906003)(36860700001)(6916009)(316002)(2906002)(41300700001)(40460700003)(4326008)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:36.2578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741d0194-5ef5-4f7a-e933-08dbf2718ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
drm_writeback requires to capture exact one frame in each writeback
call.

[HOW]
frame_capture is disabled after each writeback is completed.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c4fbcb8ff95..0814b277d922 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -592,8 +592,20 @@ static void dm_crtc_high_irq(void *interrupt_params)
 						       list_entry);
 			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
 
-			if (job)
+			if (job) {
+				unsigned int v_total, refresh_hz;
+				struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
+
+				v_total = stream->adjust.v_total_max ?
+					  stream->adjust.v_total_max : stream->timing.v_total;
+				refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
+					     100LL, (v_total * stream->timing.h_total));
+				mdelay(1000 / refresh_hz);
+
 				drm_writeback_signal_completion(acrtc->wb_conn, 0);
+				dc_stream_fc_disable_writeback(adev->dm.dc,
+							       acrtc->dm_irq_params.stream, 0);
+			}
 		} else
 			DRM_ERROR("%s: no amdgpu_crtc wb_conn\n", __func__);
 		acrtc->wb_pending = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 3dd9f4ab2261..38cd29b210c0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -489,6 +489,33 @@ bool dc_stream_add_writeback(struct dc *dc,
 	return true;
 }
 
+bool dc_stream_fc_disable_writeback(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t dwb_pipe_inst)
+{
+	struct dwbc *dwb = dc->res_pool->dwbc[dwb_pipe_inst];
+
+	if (stream == NULL) {
+		dm_error("DC: dc_stream is NULL!\n");
+		return false;
+	}
+
+	if (dwb_pipe_inst >= MAX_DWB_PIPES) {
+		dm_error("DC: writeback pipe is invalid!\n");
+		return false;
+	}
+
+	if (stream->num_wb_info > MAX_DWB_PIPES) {
+		dm_error("DC: num_wb_info is invalid!\n");
+		return false;
+	}
+
+	if (dwb->funcs->set_fc_enable)
+		dwb->funcs->set_fc_enable(dwb, DWB_FRAME_CAPTURE_DISABLE);
+
+	return true;
+}
+
 bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index e61eea6db29c..4ac48c346a33 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -454,6 +454,10 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_writeback_info *wb_info);
 
+bool dc_stream_fc_disable_writeback(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t dwb_pipe_inst);
+
 bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst);
-- 
2.42.0

