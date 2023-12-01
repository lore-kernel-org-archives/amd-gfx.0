Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999FAC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8544F10E8A5;
	Fri,  1 Dec 2023 13:29:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E8910E89C
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYzV2sGuGKsoJ+QvHxqPEOr0nensvgZeDwbOBc+3FRRe8CwXFP2dVBIfdFSXzpIcRDFfKscroFituzY82P47TLqRMo+fMzZ8gl6IH174VNOoi+DlAfxr939NzG1q6Jd2LjdsnRh7zlHvB7n4piOBJ/0G+jflFLxU4Q+TrMPCi/6AGZYEI4Z4JBI5sud6VpNvvAiVgGrTXXiZAZ730KOEbUpJVGNdU9UWV2V9Y9j7PF/mCncSXFTSfzs3S61wjDmsqvVejD/s7+dXveQZbtXhc0l0BV6xqnuO3ctrYkfkL+qOICt8YKDRKnFPBeJuWqsp8ODabD4zZf6NwE3XlZMmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQFFV+zu1NqfpuR3jV8AthVPRoQEwv2XxaiQTQeA9p0=;
 b=ZlGP1kgEjR6SoHTZ+L5sRbM4AddhFO02rrFv088gN6Zbm43GDoZvwNxq/RlLVs6QqHxLP61J56NBNtSky8JL3QI5mjvWhCf5plBUaGZtetM+G9HD+MaR0K32EwFFUxGkg2cAychRO8PWXn47kQgCsM1tjiuRMufDihbkAwv5zhszgkQYhsD73dDemzuSqmiuyH6iwVRtOtoLry6A5QyoEgCvRLWni1Vrq+yb0CTyFZZGUQjJkJfJTDnZmhCPI3b7OE+hj70KzDBl/kXyaa4GHt8D4drPEi+nqNqSv2TTWVxRHB7oJ9jgPdbMNxpRZ/hfN9lOZCcJkETNSB8RMBy4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQFFV+zu1NqfpuR3jV8AthVPRoQEwv2XxaiQTQeA9p0=;
 b=juUicpsbKzPbJ1lOhQVRAjml7WThuDMAYwTKJljJi6CYp0wbWlPxnviKdguqvy0ifSa9WVCuymNI7YRxgssD10dQISJUxyalifjIxTXkN91xb7R0hQsgvffwySfJ7kfcXVWUOWEduHnQg43Hwy0jHjzwKWG2gd5utgYWgZ/jWrU=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:23 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::d0) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.30 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/47] drm/amd/display: Add writeback enable/disable in dc
Date: Fri, 1 Dec 2023 06:25:32 -0700
Message-ID: <20231201132731.2354141-37-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c24060-dae3-49c5-2519-08dbf271880b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73pHxfRxkIaQm8mAGUchnSFHPaHDCTf6CspGXhGZK3fm+jY/6MY0yG+vEcrrNeHaHbuRcsGBWw6XKJD5VtRdHIX1xLTI4L42gbsXb30snrAYwn7UWvahnAQxbSXGuQQYJvc5rtVkamGaqaupOoGmBpSV8CWml6ariusfJFtzzilsBAVIasxI+sqKgLorFciuvi1z5A6o59+/Ez1ao1D64DLM7+I2FEsuKB58zVYHN8p275B+UB4pXqp7J3rGBIxC4WUVvOgR5sDswqWID60Dl+tsCkZQvLM+WV05UbFpXs8xT+gvBv3UOH15wWBfIYf6myyNX/I/FfeG6wdg+PBGOQyt80pWZ+CWyzR8HSptTgnCrpXXEU6wvFFpCJJUKNw0Sf+eCC1hrO1mSJEdbi2P41kq+oKeh9LZjxmar/pTWG3+TcAbmNJALbD8ppH9aNlHQE0FcZlLXldBWegunWh3VTQFJYNbUw90CH6EONF+8viBsvUSE3EI5do94S+Olu1C6oDJqRbEuLNB40BqsY9YU0sA9XtFKcd/i2CqYUkMolcB7kNlxORyEaoG2i+8tyBhxFuwwg3UwZg7VrlrCCzlTPsbexRJN4qXaLByx4QDasdMTz9US/09GF5doMYod7CidrhTJFy1vu8SRZSPaFNBHI2211tc29glv9/RgL3kEynNemeC7nElEQOurpA9xaAB1FnaHGBcii4DsZsb7BrrRHDTEpHs4fUVzTf/+mMuu0IP6N+VzEiE2wtszSRntxZetOtNkkil0iCTyKkaS38VXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(426003)(336012)(83380400001)(82740400003)(16526019)(26005)(478600001)(6666004)(2616005)(1076003)(40480700001)(8936002)(70586007)(70206006)(4326008)(316002)(54906003)(6916009)(8676002)(36860700001)(81166007)(356005)(47076005)(5660300002)(2906002)(86362001)(36756003)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:22.9933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c24060-dae3-49c5-2519-08dbf271880b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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

[WHAT]
The enable and disable writeback calls need to be included in the
coressponding functions in dc_stream.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 33 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  4 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 4bdf105d1d71..e71d622098d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -467,6 +467,25 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 		dwb->otg_inst = stream_status->primary_otg_inst;
 	}
+
+	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+		dm_error("DC: update_bandwidth failed!\n");
+		return false;
+	}
+
+	/* enable writeback */
+	if (dc->hwss.enable_writeback) {
+		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+
+		if (dwb->funcs->is_enabled(dwb)) {
+			/* writeback pipe already enabled, only need to update */
+			dc->hwss.update_writeback(dc, wb_info, dc->current_state);
+		} else {
+			/* Enable writeback pipe from scratch*/
+			dc->hwss.enable_writeback(dc, wb_info, dc->current_state);
+		}
+	}
+
 	return true;
 }
 
@@ -511,6 +530,20 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 	stream->num_wb_info = j;
 
+	/* recalculate and apply DML parameters */
+	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+		dm_error("DC: update_bandwidth failed!\n");
+		return false;
+	}
+
+	/* disable writeback */
+	if (dc->hwss.disable_writeback) {
+		struct dwbc *dwb = dc->res_pool->dwbc[dwb_pipe_inst];
+
+		if (dwb->funcs->is_enabled(dwb))
+			dc->hwss.disable_writeback(dc, dwb_pipe_inst);
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index d71faf2ecd41..fd8a8c10a201 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -367,6 +367,10 @@ void dcn30_enable_writeback(
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
+
+	/* Warmup interface */
+	dcn30_mmhubbub_warmup(dc, 1, wb_info);
+
 	/* Update writeback pipe */
 	dcn30_set_writeback(dc, wb_info, context);
 
-- 
2.42.0

