Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0467AC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A80210E2CE;
	Wed, 16 Aug 2023 06:08:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E3310E2D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVVxPrWEcRH+E0WS0QAPkGg2gsxQXW0j5gYV+qSrGI04XHbusr0llVAplNw6y8g2dZJdHN7Aq1qcdajbVSdGtnYqSBWlNzTQWrZ0aOx49aWmBl6spnRNSdAAfbiN0wAhvIXwIa8RD04MiEmYYjf5nU3efkXcjNVHAItRUtd0epQ564NHM4fTZYqOMwV5nuKHzeg8blxGPAd57f9skIoerxp2VkOEMvJCtE/RC0gF0RHP6ACxgeMSmanOuNJSBhDAhJ8yWa15AtnIE4KQEnGSP1vgGURqso+pBzZsq+z4aj7t9TtM5PkTxoPFXsfudkWdt+nw3lOf6kRyZFdvKdmedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAYpEU+FC/Y4hiBAM0UZukKJIzxK8/eZchGu5jKKWMg=;
 b=e75iqSFNCG97Mjy3ODU6QvkSp3pYDPDklOrb2Y/ApbWYUkWjLQy5MMgDXw03JAa0UREnTAWLJMMPi45s9EuCbk/+B6NtFo+9unb2Dc8iW5XhJoEfgycpAWXAmMKKPwUui3E4xrBZzj6QrNS1Ihe3cMUzQ6z1XdOMNI+ZYe6whRM+PghT+1XI5umYcJS+bRFgurdQ1EM8IXTGwcei2vthnerJQO6V1cRLVZwW7NWw6JzFXUiz+4H0nLSdECXobrsPZCa2Y/NW+QxaZmhjnmDaN3EYzTTq7q1KVsP3fl4NfxA8lzj+XYcNuRWghSqS0sLl+QiSqo0ApIZMuPs4IPI6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAYpEU+FC/Y4hiBAM0UZukKJIzxK8/eZchGu5jKKWMg=;
 b=iMEUYLLgHNKFeuCjWB9LVmhhSfF9hUba4pYW3hfdUyZZi9Icg7NUcvtfSXcO22PT/U7dLV1WNiXGGydYGSRg2w736NWRm/7wRvy6n8uouK8+cZNRyRqiKH8h/xmPhk0pLL1piTtyH9TULqeTpzY8goWIJfxtmQNhatq/MPM1bBk=
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:08:29 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::c3) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:28 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:08:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: set minimum of VBlank_nom
Date: Wed, 16 Aug 2023 14:06:51 +0800
Message-ID: <20230816060658.2141009-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ0PR12MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb9b20e-59a4-432f-c68f-08db9e1f3641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5+L165FqhuHgMbOGD/rFt1rqWy2udwL5xmOWSYBLP1VF7+34rFmxlZQb5OlH5vcSPbQA10404IfTuYCfRlu+iHTo0uHbfCfDe196QTKXhsIKLe84Liu7HyYtjHdUsl9ZtidZjVc1daXFC6wY5QG22ETVtSpVVSE/iSOi22+vHrLYpX3b1mA4kDCMKBVar1LCqzJHY7p9AGJFnmS+tTVDoWDLe/GWF3qvhjmrWbPGB7xSzXnnUHc2tIDaloRgMVYCJf0g8enxZgCuPXdrDzd1fWuLZPBRa5lZn4IFfHrCo1X2cxeXxmiyU3ZzTPPKaJLn4WfJ4aXsUDEBpZqFCYzR/C3jVYRa6gCHnD4WsJl5LkDDmNKRfz6fJ+XrPf0EFOJC7TcQo39iZEBLzCltfm+SkJC32Zr71ZnXru07nqByxQTcjaGenm68ZcFpXBFMH8AOHKpWLm4HRg5UkR8ugSc+YwbodeGJuWZHZ4QthhMSJKc3vERIvYF/+I2HPdZTeLFc60OJZKNDlynPpKC88z9iQPIKd+TK5ICqmWcKEH5j1l6wTPjPvPPO/iLFJdkzFd5++u3K9GCWLhkt1eCRaMd18sbWhMjJG1zcnyGmZBdB+AI2SjKZLcYmk4J6XfLbAX9Yxnz1u4/ysNeRnMJm5lvtqSaaWandhQvXujhCOmdUbAWVlNpO05B1egiX11JKiobx/Jdku+FzVWtNEIISqSNVqXSD+EQLBwSrPBX3gxNp9YztpBxbyOa0Nu2lTCmLS6nOHMnm7VnV/ws+j1wqNc4uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:29.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb9b20e-59a4-432f-c68f-08db9e1f3641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, ChunTao Tso <chuntao.tso@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ChunTao Tso <chuntao.tso@amd.com>

[Why]
If VBlank_nom is too small, it will cause
VStartUP_Start smaller than VBackPorch + VSync width which is an
invalid case for VStartUP_Start and where to send AS-SDP.

[How]
Setup a minimum value to VBlank_nom

Reviewed-by: Reza Amini <reza.amini@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
---
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 07adb614366e..fb21572750e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -293,6 +293,17 @@ static unsigned int micro_sec_to_vert_lines(unsigned int num_us, struct dc_crtc_
 	return num_lines;
 }
 
+static unsigned int get_vertical_back_porch(struct dc_crtc_timing *timing)
+{
+	unsigned int v_active = 0, v_blank = 0, v_back_porch = 0;
+
+	v_active = timing->v_border_top + timing->v_addressable + timing->v_border_bottom;
+	v_blank = timing->v_total - v_active;
+	v_back_porch = v_blank - timing->v_front_porch - timing->v_sync_width;
+
+	return v_back_porch;
+}
+
 int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *context,
 					       display_e2e_pipe_params_st *pipes,
 					       bool fast_validate)
@@ -310,6 +321,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
 		unsigned int num_lines = 0;
+		unsigned int v_back_porch = 0;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -323,9 +335,16 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		else
 			pipes[pipe_cnt].pipe.dest.vtotal = timing->v_total;
 
+		v_back_porch  = get_vertical_back_porch(timing);
+
 		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, num_lines);
-		pipes[pipe_cnt].pipe.dest.vblank_nom = max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width);
+		// vblank_nom should not smaller than (VSync (timing->v_sync_width + v_back_porch) + 2)
+		// + 2 is because
+		// 1 -> VStartup_start should be 1 line before VSync
+		// 1 -> always reserve 1 line between start of vblank to vstartup signal
+		pipes[pipe_cnt].pipe.dest.vblank_nom =
+			max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width + v_back_porch + 2);
 		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
 
 		if (pipe->plane_state &&
-- 
2.37.3

