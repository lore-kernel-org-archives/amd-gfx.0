Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF4D35664
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E127810E5E4;
	Wed, 28 Jan 2026 01:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PUuabZiQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC14510E5E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su+il+Nt1xEPxyABK2xnhNI+dTISACsTU8QrGO6A1ZEwQUJAkOius69psxOUvFuH3X2Gzx6vzpLq0ljrbRH/H/Bm/eVqPFbibi+nNysT81qJrCZyqGuWIwBXjIZ2N3o+/DlsWqaoq9SD/vmQDXnbTtFwja8NY8+vpxUyk5zMwd948G0WAJUEojJS7YNwe8tO6B/vBIIMcrkG8pBZT3lY1rZTDvbf3L7YJqxh5+XGdqIaSyIkoKw/xMpP3E9e7EY+5CPPW12WszUw4iGkmTNC8oMg0/VMcbjbNqYFEmMViM21At8k6ylOtIFQFGX2XX8iT8GFITJT4eqMU+j1RRq5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78wt4VyKdhytnBqSSJgX7AH0x/cmO+wG4rsX4TPm8Tk=;
 b=zSyjZ7hkMYDoFfQEY6aTYzsbQxftb4o+V0JpRj4RHr5tqsj5lchNpo/5xrqLRHqVHD8n6m8tImOB8cvNzDmv3u7A3MR+OZ7ztP0Ck+AYg2Js05dORNvZzCvNIYq/gLvJ50FVIWsSAcVw7pjjbCER/AMOyBwmELfg7ncz4OvZrr/PsJSoEydsoPpObEQCq94sPmC9Y2ZhikLSxXpvTtlYJxRTu5rIDNgWnlLuFNzJQAF12/IOzcyLvW6Pxx/5+TcXOeGDs2it57rqAY0OKJtR41GI8dxntFIc8fc99Q+EFOW6E68dPfhgIl1rovCZzIR282mFmx3Rd2oLWcRma7Skig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78wt4VyKdhytnBqSSJgX7AH0x/cmO+wG4rsX4TPm8Tk=;
 b=PUuabZiQO6j8L/P+PpfgK8a0HmESghnhO+2fDRbVh7qd0iF/GJW0vPcWMiWH94d8mdnOwnc1m6eAXbRrGjfc7HzyusKVu3bEyAlQX88AcPnY3V0r3Ld0wABfZyQq7pBwODKj/AJ6cMOlykRQ33kkyhbrIJCfvEjZudawFgWwKVY=
Received: from MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) by
 LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 01:59:22 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::60) by MN2PR01CA0041.outlook.office365.com
 (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 01:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:21 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 19:59:21 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:18 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 03/21] drm/amd/display: External panel replay fsm control
Date: Wed, 28 Jan 2026 09:51:28 +0800
Message-ID: <20260128015538.568712-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: af99d3c7-add3-4305-17b2-08de5e10db06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b80eMAAJCKotOAV8zjSWz+VII4Vy8u+O3aDQUirEapTXAGr/K3/Sw9GPgu77?=
 =?us-ascii?Q?VCV8jKrwXV52SZLBwNVzzrNucaePUfUTaaCzrhSTQx2YFy/De2FLelhCHJ6l?=
 =?us-ascii?Q?IKSpnbdBrWLD8CFLJAN7xQ+f16UzoVyhvOJFeJz5LZGtJE9EeYvOv9j8e/14?=
 =?us-ascii?Q?+WgP9Pfdp5S0c7BP6AHIWRvQAyarG4cDoKWmwiWIut1hoiNCNlIknqnO1tIR?=
 =?us-ascii?Q?M+o7+lFIpP+kXX/dO7JmhTZDwrz/D1XZ1cjGxJI/8D7CKAUyujw+ETAL8JVO?=
 =?us-ascii?Q?kfiO4lYY4gKckDuKifW3MkZtsmw2iJLCjOvQxQ14JRvLYRcXPp7Y92EYIzHk?=
 =?us-ascii?Q?Pl9sPdOkSXVr5QvwxBSk/zCX5QlfNk/wLmt7t6UOgnC64qPxwDZfv8K1G3AO?=
 =?us-ascii?Q?pyqkfm4aPTAc/sEuR/0IXZl5x2IbEK03xKx1jDauWnmXcr7imZljImQt+FXF?=
 =?us-ascii?Q?B6mWo/GS5XJYYBobcnStHvxiXhe0/ADOHL1vHsw9G8Jj3xfk+a6XwptL71hF?=
 =?us-ascii?Q?kmDSYSrQIHYeDE5l85wmmJETPOV08m+08bPK1Z/7LS0zcrwZIdYdAl/c7HF2?=
 =?us-ascii?Q?6i2HhrEJ9yAaXzLQtdwe/51+Bb2/MioY3foLtUrQ/DPZt3cgcOs/C0fGz2vF?=
 =?us-ascii?Q?XpjPVKB5trQHbjlj5ekDefeaUPBR61bzCdja2wi8yEt6tPu0x+vUoEtvYf0m?=
 =?us-ascii?Q?4c6n1VFOBG/HJqtCiX4ZUFlwhValb6kP588O7BXcb6vXHOlb4O3wUDQfMf6A?=
 =?us-ascii?Q?AXdhbdTNGCzLGstQGecQcUkHK29eXPBL9EGXaA4uNbnnZ9QYC8eBbHnjhJ7+?=
 =?us-ascii?Q?+SkDOaAudbuattXpxDke/GVHKi8z5wWHZabNmMfjXQvyX9VLDno6AQuf1MrV?=
 =?us-ascii?Q?H1iJgpsjqm0VaYVWSv51bmjgEi2DBA2A7UF2cAdRSu9Fe7In78D47AqoabJo?=
 =?us-ascii?Q?roBY9avLGpJNUp+ITJZr0b3qRsV+xpN6RmhZ7cyKLEyS2Xv5spWq8IFV3eNP?=
 =?us-ascii?Q?J7PPo6tpfyjTg7d3JtjHLSZeuGcxSdpYiLLMkBiVN3i+sI0yfmGdmEfA1eZU?=
 =?us-ascii?Q?Xo+h0iLB8dAQ8eY2xZhDnAMhnEir0ZP0na4IU2pSJvAXSDFeU3l6vDT09hum?=
 =?us-ascii?Q?ku25C2swnP0cQw4EgxOH/4jy+o+DMQ8EL9M+7Vy0r2upf5Mt9LoL8oUdD20A?=
 =?us-ascii?Q?JeMGwyxJ3RsPJwyJfj9K5lLMjEOrX7lptAUxU90B01ZzRIUJyox6J+0+Cv4B?=
 =?us-ascii?Q?wTFDJMUYOybyKBH/BDHv/+BT+NvWDC6RF8j3Y28ppKSfVGiLzYij09zhFPeq?=
 =?us-ascii?Q?p+yARoYosSryiy2Xd0G4GxPWhyiHgEZ/XR7tTN9xVpjs5SPooEScUFqOfooe?=
 =?us-ascii?Q?Byk8hchjPVE+MjeRNwqSadT7wapRzI3lOlQZ071u5M0BP8gIqIZveFRhqw0Y?=
 =?us-ascii?Q?0PxC/wbKG712gGHbZHpK2y+hdxpEE+NyLzkRZ8E2ZI/UDOhI7LUpWUs6WrTj?=
 =?us-ascii?Q?kl7c19HnDqDiTGaYDlcCRRC2dZ+W+sWlePTEwVz4Q4n51Pf3TSBvmP20gaGx?=
 =?us-ascii?Q?Z04Xa17b4Ly9ChYNeM2IzhbxGtc42PSKD3el1YQE+T2fsB22HX7/heDygsO3?=
 =?us-ascii?Q?O3OPKjEYPP+cJEmBZdEe1MB30ooMERiEgQuBvFijQc0u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:21.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af99d3c7-add3-4305-17b2-08de5e10db06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
To correctly control external panel replay fsm.

[HOW]
1. External panel replay is 1-A option only now.
2. Update cursor update and dirty rects commands for external
panel replay support.
3. Add external panel replay support flag in dc.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 19 +++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 15 ++++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  | 52 +++++++++++++++++++
 5 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cb85b7ac2697..4305691ba45e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3860,7 +3860,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
 		return;
 
-	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
+	if (!dc->config.frame_update_cmd_version2 && !dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
 		return;
 
 	memset(&cmd, 0x0, sizeof(cmd));
@@ -3880,7 +3880,11 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 		if (srf_updates[i].surface->flip_immediate)
 			continue;
 
-		update_dirty_rect->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+		if (dc->config.frame_update_cmd_version2)
+			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_2;
+		else
+			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
+
 		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
 		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
 				sizeof(flip_addr->dirty_rects));
@@ -3894,6 +3898,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 
 			update_dirty_rect->panel_inst = panel_inst;
 			update_dirty_rect->pipe_idx = j;
+			update_dirty_rect->otg_inst = pipe_ctx->stream_res.tg->inst;
 			dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 		}
 	}
@@ -3916,7 +3921,7 @@ static void build_dmub_update_dirty_rect(
 	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
 		return;
 
-	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
+	if (!dc->config.frame_update_cmd_version2 && !dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
 		return;
 
 	memset(&cmd, 0x0, sizeof(cmd));
@@ -3935,7 +3940,12 @@ static void build_dmub_update_dirty_rect(
 		/* Do not send in immediate flip mode */
 		if (srf_updates[i].surface->flip_immediate)
 			continue;
-		update_dirty_rect->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+
+		if (dc->config.frame_update_cmd_version2)
+			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_2;
+		else
+			update_dirty_rect->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
+
 		update_dirty_rect->dirty_rect_count = flip_addr->dirty_rect_count;
 		memcpy(update_dirty_rect->src_dirty_rects, flip_addr->dirty_rects,
 				sizeof(flip_addr->dirty_rects));
@@ -3948,6 +3958,7 @@ static void build_dmub_update_dirty_rect(
 				continue;
 			update_dirty_rect->panel_inst = panel_inst;
 			update_dirty_rect->pipe_idx = j;
+			update_dirty_rect->otg_inst = pipe_ctx->stream_res.tg->inst;
 			dc_dmub_cmd[*dmub_cmd_count].dmub_cmd = cmd;
 			dc_dmub_cmd[*dmub_cmd_count].wait_type = DM_DMUB_WAIT_TYPE_NO_WAIT;
 			(*dmub_cmd_count)++;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ab19b6230945..ce2eceba2ab7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -560,6 +560,7 @@ struct dc_config {
 	bool enable_dpia_pre_training;
 	bool unify_link_enc_assignment;
 	bool enable_cursor_offload;
+	bool frame_update_cmd_version2;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index dc1b3f6c22c9..e4dd5ca70987 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1034,12 +1034,19 @@ static void dc_build_cursor_update_payload0(
 		struct pipe_ctx *pipe_ctx, uint8_t p_idx,
 		struct dmub_cmd_update_cursor_payload0 *payload)
 {
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	unsigned int panel_inst = 0;
 
-	if (!dc_get_edp_link_panel_inst(hubp->ctx->dc,
-		pipe_ctx->stream->link, &panel_inst))
-		return;
+	if (dc->config.frame_update_cmd_version2 == true) {
+		/* Don't need panel_inst for command version2 */
+		payload->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_2;
+	} else {
+		if (!dc_get_edp_link_panel_inst(hubp->ctx->dc,
+			pipe_ctx->stream->link, &panel_inst))
+			return;
+		payload->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
+	}
 
 	/* Payload: Cursor Rect is built from position & attribute
 	 * x & y are obtained from postion
@@ -1052,8 +1059,8 @@ static void dc_build_cursor_update_payload0(
 
 	payload->enable      = hubp->pos.cur_ctl.bits.cur_enable;
 	payload->pipe_idx    = p_idx;
-	payload->cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 	payload->panel_inst  = panel_inst;
+	payload->otg_inst    = pipe_ctx->stream_res.tg->inst;
 }
 
 static void dc_build_cursor_position_update_payload0(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0e953059ff6d..2e38b6840c71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1230,7 +1230,7 @@ struct replay_settings {
 	uint32_t replay_desync_error_fail_count;
 	/* The frame skip number dal send to DMUB */
 	uint16_t frame_skip_number;
-	/* Current Panel Replay event */
+	/* Current Panel Replay events */
 	uint32_t replay_events;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index bbd6f93f5c98..cc3b44cf7662 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -35,6 +35,46 @@
 
 #define DP_SINK_PR_ENABLE_AND_CONFIGURATION		0x37B
 
+static unsigned int dp_pr_calc_num_static_frames(unsigned int vsync_rate_hz)
+{
+	// at least 2 frames for static screen
+	unsigned int num_frames = 2;
+
+	// get number of frames for at least 50ms
+	if (vsync_rate_hz > 40)
+		num_frames = (vsync_rate_hz + 10) / 20;
+
+	return num_frames;
+}
+
+static void dp_pr_set_static_screen_param(struct dc_link *link)
+{
+	struct dc_static_screen_params params = {0};
+	struct dc *dc = link->ctx->dc;
+	// only support DP sst for now
+	if (!dc_is_dp_sst_signal(link->connector_signal))
+		return;
+
+	for (int i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link) {
+			struct dc_stream_state *stream = dc->current_state->res_ctx.pipe_ctx[i].stream;
+			unsigned int vsync_rate_hz = div64_u64(div64_u64(
+											(stream->timing.pix_clk_100hz * (u64)100),
+											stream->timing.v_total),
+											stream->timing.h_total);
+
+			params.triggers.cursor_update = true;
+			params.triggers.overlay_update = true;
+			params.triggers.surface_update = true;
+			params.num_frames = dp_pr_calc_num_static_frames(vsync_rate_hz);
+
+			dc_stream_set_static_screen_params(dc, &stream, 1, &params);
+			break;
+		}
+	}
+}
+
 static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_state *stream)
 {
 	/* To-do: Setup Replay */
@@ -159,6 +199,9 @@ bool dp_pr_get_panel_inst(const struct dc *dc,
 	if (!dc || !link || !inst_out)
 		return false;
 
+	if (dc->config.frame_update_cmd_version2 == false)
+		return dc_get_edp_link_panel_inst(dc, link, inst_out);
+
 	if (!dc_is_dp_sst_signal(link->connector_signal)) /* only supoprt DP sst (eDP included) for now */
 		return false;
 
@@ -199,6 +242,9 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
+	if (enable && !dc_is_embedded_signal(link->connector_signal))
+		dp_pr_set_static_screen_param(link);
+
 	if (link->replay_settings.replay_allow_active != enable) {
 		//for sending PR enable commands to DMUB
 		memset(&cmd, 0, sizeof(cmd));
@@ -276,6 +322,12 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 			pipe_ctx->stream->timing.v_border_top + pipe_ctx->stream->timing.v_border_bottom) /
 			pipe_ctx->stream->timing.dsc_cfg.num_slices_v;
 
+	if (dc_is_embedded_signal(link->connector_signal))
+		cmd.pr_copy_settings.data.main_link_activity_option = 0x03;//OPTION_1C;
+	else
+		// For external DP, use option 1-A
+		cmd.pr_copy_settings.data.main_link_activity_option = 0x01;//OPTION_1A;
+
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
 }
-- 
2.43.0

