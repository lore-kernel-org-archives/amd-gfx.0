Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DC7CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1D410E6C8;
	Wed,  5 Nov 2025 15:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0pfwvsRz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC40210E2D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuGVKRZm/r4Yu6fWaFAsPDZIC6JVeeixv25vY2Tbew2XT2Wtf9ilehaf2Ufqv/VSk2zX7Go7QabEQ6hiHanOdjl2Dp1aArUqjfgXOGscel0tyeKwyZ4kMVvglQ3cduRFcrQPqy3KXWrASCyc9vtOtJEv4Uwq6sBGppATqMgMt5f9goT0URwppO+7f/2NpqlB10ADs7ltWlZMq61qJ20PLgmiS9Ra7OnMVZViT+H01r1U7GBJLE4Wd46BYCOliZ9XMGOeTPmHmdB0adUUGY6bS5sgFZ9IR9W+AR65VJ+ELL1tXxLCuP5m8dG1f29p1lrHU84mtlmZ+9Sft+/J0X2xWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3pylKIWDwV8SxMUOWs8H/KKG1kyZhpbN+0eLaQUMbU=;
 b=S4+4mwVCRK33dYYwi0Q+IZU9rg9UGGbUVYwgo5fYayQ0uOUY0U2FoZ6GHRYdsBa7aePeMplgHh8Dl2JeEiBHe5sEwosRKCfj3d0/TT62hkeJwhTji1PfQwpz11sYVjI6VrtfTCcqdvRpyf3zxra/Z2ce7+e4FfxkuQKzIOFWM/a3wEjALM0NT23CE2S+V9qmjolLpV5BaU1ly1z7aeYIbQdzhErram59A/4AFsVCP6QhTTi2tZePbHjUPpI+jlUH7HDnunoo53ZdVeYvKDHDyvy2oivXmRVZdVeJpfAzk/lpnpimatDLTOC3SxrRxK4bi0q1p3LDTNP5uSaDHDfODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3pylKIWDwV8SxMUOWs8H/KKG1kyZhpbN+0eLaQUMbU=;
 b=0pfwvsRzXi4281pgNyevtUbP9dmmlMFqKXxBnbgOk0puYkZTK/OlctCPj6JmJg3X9MYgBPy1SAGghhiHIoX1V33rPdBxbJKlgf4fFE1pn1W7oxHLWqvZPiwEqAVV23gbquYrJse3BQMf4v4VwbfF/07C3uQzRi4q8Qfmkymr6sw=
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 15:41:03 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::f5) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 15:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:54 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:40:53 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:53 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ian Chen <ian.chen@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 05/13] drm/amd/display: Add new SMART POWER OLED interfaces
Date: Wed, 5 Nov 2025 10:36:20 -0500
Message-ID: <20251105154035.883188-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a1c12d-1774-40da-4c21-08de1c81ba3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ucFAtz5Mdqr+jfLeExjF255v34ty+Sbf4JrD1mzs4zxJHX5Xj56/1CeTsRj?=
 =?us-ascii?Q?qOtlLJM5OGuaR8eWqnRku6YR37gZdVBmQrV7aujq6d/fjwBB1X5KsXtxgJVe?=
 =?us-ascii?Q?VLSVqKOGjSeFlmz156H/uU6CH6+E/zuGAe1Fjz4d7HFbGAOtVQHmMgRRGxzv?=
 =?us-ascii?Q?D17JJAmfAGNHYj4My+kdOUgg6Ri1CH1Nkoxb+HfHJm1qXUzl7yQbciJjKQRi?=
 =?us-ascii?Q?R13kgqq+60hQ7XWAHT9z+bRui70cWVGHET7236r2pSSL1GGX51C/dtYY8iS2?=
 =?us-ascii?Q?9cdNKtYT+dgW3i35+JTeWavuMSITz1hMZ6Tte4evJ8JiyRArfwwuyZ1qRWKD?=
 =?us-ascii?Q?I8Zz3y+xWX7DebVlFClqF2KnX25wwN/gpmtCRHSrR2WD52W+1fsLLm5TqU+a?=
 =?us-ascii?Q?xT3jCemVHrjOttkhjDwiOJpgdnebxKi1PCDsiL8MGMqTi6tu2gG43KiN6a+L?=
 =?us-ascii?Q?9KE9lRaz+S79RayefevFvkhGpF2lXpshB6Wi60cZvMz4lgGhY92h9YhA5USl?=
 =?us-ascii?Q?/qzqxuGv/3FiUGyCTxWPrp5xS4oe0p7fYpNwZg4aL6Dx7lNr00LXqBuyZNRA?=
 =?us-ascii?Q?owIq3lBYQ8scVARNgRbqg817vvilzS0UMThu+K4uYgsg9Q4rA6k/mcFhsAH0?=
 =?us-ascii?Q?T6KsgJHTzq5054JClbkhHbe+/mFy/dvITKCxxdQ3F9R+Rlq6zf4txgoddH9b?=
 =?us-ascii?Q?8YuQsAnHLTtuevEWvmr7FttTZyzNV6oI8ybXbTHBtsgly9tFboWq7Ss+AVCb?=
 =?us-ascii?Q?6tBOGuTmx5hOz+HCkwZhdAEPFohSyYT/n0UyKeoTa0pFPTCEUk/kySVFdPvt?=
 =?us-ascii?Q?tbHo5HNSJ9F02NInxjBu1GvuOCv6Y1G+LhxbIw0/Ptsa++WgDPrQ4fo94jhS?=
 =?us-ascii?Q?ERv0cy0ieGI0jHEa9nw3KpGZtpePPiv+f2LoOeedYOHoeGTttL5SJMtuxJYM?=
 =?us-ascii?Q?wz1K8dOv/CYZY8Eqmk1ZI8BmmcN/KCNkjs68S6xT0/dPRk1ezIH79djT5vvt?=
 =?us-ascii?Q?IG+iU5tXxCFXCekctPm20agy6IueEsFc10q4vm3Qi3WEHaflrM8JMyn/zGov?=
 =?us-ascii?Q?knl93SRi56+3n8RBhJZ8ejhfLW/ZLgXBeqgCsOEpcgrzHHKr8PoXK3BxF6Tj?=
 =?us-ascii?Q?ufXYxJLYMsyDWIOvsJ54SFFM1y6LqeDYbmmCiCrXRRHYTrnwv7b+lBH7Jk/t?=
 =?us-ascii?Q?79TEDngq/fdv9zM4RQzGhnzUAXUv4XnoTuvqGGN/pxcEctRODZaKEbGeinAp?=
 =?us-ascii?Q?ZQz4W4hyINsCcbnOC0ej3PAq/3LgnTBHQTVTqjKCR9Lg0iWC2WwAFDydpTG8?=
 =?us-ascii?Q?zmm/AxQnRcRLj6pq1Y1V8y0w+aUpGmRHFvpA+l/CK9tvLGklq48Ije9k87rm?=
 =?us-ascii?Q?dmQzkIq4DXHR/xIUSg7oxdkZyLFAA0oMwH4pQDoABCase7NfnIYkuhWV7e4M?=
 =?us-ascii?Q?V1eF5hMARPNm71EZayv4KMHdQNSDEc8thTxe+Lam/lehYBvkUDtjR8UOidfE?=
 =?us-ascii?Q?Xc9H81zjDTYDN7eFDzuQCOPRBS5YH8IDiemLCLahO3j6TvEG6yv1d6YVefZm?=
 =?us-ascii?Q?cTn2UaGNrmtHGy6V0V0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:03.3696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a1c12d-1774-40da-4c21-08de1c81ba3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

From: Ian Chen <ian.chen@amd.com>

[why && how]
To optimize power consumption on certain OLED LED panels
by sending MaxCLL per frame to TCON

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 89 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      |  7 ++
 2 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5e79962c5f2b..3999b5835066 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5977,6 +5977,95 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 	return true;
 }
 
+bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_t peak_nits,
+			uint8_t debug_control, uint16_t fixed_CLL, uint32_t triggerline)
+{
+	bool status = false;
+	struct dc *dc = link->ctx->dc;
+	union dmub_rb_cmd cmd;
+	uint8_t otg_inst = 0;
+	unsigned int panel_inst = 0;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &link->ctx->dc->current_state->res_ctx;
+	int i = 0;
+
+	// get panel_inst
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return status;
+
+	// get otg_inst
+	for (i = 0; i < MAX_PIPES; i++) {
+		if (res_ctx &&
+			res_ctx->pipe_ctx[i].stream &&
+			res_ctx->pipe_ctx[i].stream->link &&
+			res_ctx->pipe_ctx[i].stream->link == link &&
+			res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			pipe_ctx = &res_ctx->pipe_ctx[i];
+			//TODO: refactor for multi edp support
+			break;
+		}
+	}
+
+	if (pipe_ctx)
+		otg_inst = pipe_ctx->stream_res.tg->inst;
+
+	// fill in cmd
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.smart_power_oled_enable.header.type = DMUB_CMD__SMART_POWER_OLED;
+	cmd.smart_power_oled_enable.header.sub_type = DMUB_CMD__SMART_POWER_OLED_ENABLE;
+	cmd.smart_power_oled_enable.header.payload_bytes =
+		sizeof(struct dmub_rb_cmd_smart_power_oled_enable_data) - sizeof(struct dmub_cmd_header);
+	cmd.smart_power_oled_enable.header.ret_status = 1;
+	cmd.smart_power_oled_enable.data.enable = enable;
+	cmd.smart_power_oled_enable.data.panel_inst = panel_inst;
+	cmd.smart_power_oled_enable.data.peak_nits = peak_nits;
+	cmd.smart_power_oled_enable.data.otg_inst = otg_inst;
+	cmd.smart_power_oled_enable.data.digfe_inst = link->link_enc->preferred_engine;
+	cmd.smart_power_oled_enable.data.digbe_inst = link->link_enc->transmitter;
+
+	cmd.smart_power_oled_enable.data.debugcontrol = debug_control;
+	cmd.smart_power_oled_enable.data.triggerline = triggerline;
+	cmd.smart_power_oled_enable.data.fixed_max_cll = fixed_CLL;
+
+	// send cmd
+	status = dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	return status;
+}
+
+bool dc_smart_power_oled_get_max_cll(const struct dc_link *link, unsigned int *pCurrent_MaxCLL)
+{
+	struct dc *dc = link->ctx->dc;
+	union dmub_rb_cmd cmd;
+	bool status = false;
+	unsigned int panel_inst = 0;
+
+	// get panel_inst
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return status;
+
+	// fill in cmd
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.smart_power_oled_getmaxcll.header.type = DMUB_CMD__SMART_POWER_OLED;
+	cmd.smart_power_oled_getmaxcll.header.sub_type = DMUB_CMD__SMART_POWER_OLED_GETMAXCLL;
+	cmd.smart_power_oled_getmaxcll.header.payload_bytes = sizeof(cmd.smart_power_oled_getmaxcll.data);
+	cmd.smart_power_oled_getmaxcll.header.ret_status = 1;
+
+	cmd.smart_power_oled_getmaxcll.data.input.panel_inst = panel_inst;
+
+	// send cmd and wait for reply
+	status = dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY);
+
+	if (status)
+		*pCurrent_MaxCLL = cmd.smart_power_oled_getmaxcll.data.output.current_max_cll;
+	else
+		*pCurrent_MaxCLL = 0;
+
+	return status;
+}
+
 uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 					    uint8_t dpia_port_index)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ba7bab51a3b..4c501e12706d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2719,6 +2719,13 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				uint32_t link_index,
 				struct aux_payload *payload);
 
+/*
+ * smart power OLED Interfaces
+ */
+bool dc_smart_power_oled_enable(const struct dc_link *link, bool enable, uint16_t peak_nits,
+	uint8_t debug_control, uint16_t fixed_CLL, uint32_t triggerline);
+bool dc_smart_power_oled_get_max_cll(const struct dc_link *link, unsigned int *pCurrent_MaxCLL);
+
 /* Get dc link index from dpia port index */
 uint8_t get_link_index_from_dpia_port_index(const struct dc *dc,
 				uint8_t dpia_port_index);
-- 
2.43.0

