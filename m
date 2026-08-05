Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E43C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DEB10ED1A;
	Wed,  5 Aug 2026 06:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BaK6xGzh";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF3C10ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI5sJItubFA8hASBUQO6Z3ar1gwCra1f8AtcwiOnbgiLlvG/CXLjdagIcZod+Fabf3gJc35315t0SV/LAgpNfFR6ds2OO/x1wWGyJCq68vXcGUrJLYbU0KAU7T2St3H+Ej+xo/5XdYVMDTC6HgHW4xxaBfbHmWsVmGzqOZCAs9A/sSwvy7ERVhDkj+7RDzlX98fBd+phUydMRIZnbf6/PSEUQlCHeuakNf/mGcLQKZdScxIxfavSWFkRffIrvTL2fjDZK6ozClLQ0kt2vkrb0PJzG1fC4B6XssbPrNhjFqXt18XD5MaOjVeoi64VZUzLsXqRQpX8BdPxf4eSfiKcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0bKoB7SbVaD+nfLpN6SdtdagJ1TKG/KaTsTQOpTTew=;
 b=rHkvI2s4Uc3wY0WE1cc6Ob/I+HqM7ioiKCCTQ6mANRbsrw20kYdWNrgsm15jyJqK+ZpAbTbaM/Fto36nAG7wcQX4w5j591MD//TxKGyCGa1UatiTEROWJ5kwGj0or02+VSSKHsHF1b6OYtXCv83ZsZtQuk2t97spNZlPo1a623uzGqBgRYinl1GOnZU6SKiDWFSQ47dyUsWV/SiFSgdl7ccfixXxOXhmLi+aS4jIuFRjPuck3TfMOT+a2AXI0pB8ILCGQhadGvctdtLfkuNtr/85/B0ezOwNOnG2JoTvbLe8JV7LfUzWzCitD7rP/nxUNLFpJ2MFDaeW8n5dSd8Bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0bKoB7SbVaD+nfLpN6SdtdagJ1TKG/KaTsTQOpTTew=;
 b=BaK6xGzhXHzO4m3855h7ETrlmAMljSvz5jV5vfZVMwhkuWiu4b1kEBmrmgQadmOaZvWlakgyNlRhfP6t/zG5hbIrtuOrMcQ2zmtFr5X9RdCa5xznGkkYbm9x+AcUcrwi1p5wLby2ZPwgoEr+JUB6994iW5PcPXHAkngy8kawh1c=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 06:42:20 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::32) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:42:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:42:03 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:42:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, YiLing Chen <Yi-Ling.Chen2@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 32/34] drm/amd/display: Extend inbox0 HW lock support to DCN35
Date: Wed, 5 Aug 2026 14:36:44 +0800
Message-ID: <20260805063937.2145774-33-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc53d60-cd30-4ba9-4fc5-08def2bcb27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|3023799007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x8QJi9awKw1ehOKJVdjAQT30S22iFuRK17CyWzUybv1brco3mr55nAtQTFqQt2SfTQtZd/yOv4VdXvdmCKZ7X+VX0UaIh4VSkVh99uYKJl6q7hTnzEXWLeOCnf07qogmPmddIYFKuIhiTF1N0Fq5I+irccnMKQOKWPhlS9WqYykM30XOCxal/NNjAOnZDS+zopZ3vIz+dDP5fCJDQfbOc17+7hTnqsp3ixTNeau4bMUaJNAgCWj74ehuUJ22i/UAAg05RSnmAhm0RU9sItYjf2z9AiXVk4RSWVf+K0gt1XIb3OqTbtm86G3vtYOKpEBBqw4QgcXJz0XpQN0EK9YuDeiZGHXpoh4k7lsOsZbzm+dU3kDXm4laMhVTp9fOsbOWmXsrtTzPZJYAaXm9mwSmPlkCb3VzhhEkc0ULzBACKP7efdzupj3cb5zPkyIuslfmdji4JQHbZymZTBZwMuo0kAWWGtxlKrmXMoCo7DR2XVmpDddUiWYbOsua/cxS2Upp+sIkvz++i0et18GoCq46RXZNFGwjJ/mvp8LzaZXK7fjRXsDhIhf8UpVp0WVFXAjprGl5cBdRm2PbeYCSvQjuEIrKDnpz7YOeyxMmpJeaDly8FguxGPZnGxkER6jkF2Pqc2W3WlYj2or826sNMKeedyoDrXLBLZ3WxxPH6F2fG7DKg17w5YYJeqMK/E/VRAdJFqSQINbxur8WpmoOOM0i1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(3023799007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p6Hj3GZqzR1QOmx1zCWAtcDJjQQEdkiQK1ztAJK9H8f2rwVAfMr7C7CURo0a6M/E7AFXr3j9zdlbQC4UxX+XIe5DqZdkmlcMNRHDajodZa8OX5Vlaf2Q5PBoTtFDwkq1XvqxWVlCiQcnZOU9k7aSeb9IYUf/Zp2hLjaBJHH7lMt0PQknSwa9doCsEZN7KBQv7Vrh16ipoNUhpJs5q2Rjo3lc+aIcw5BYwk7Z/lDVMehqhoNE8/DlFJjgPn/nTD69d4p3A/Sbv15rQq56WnFmezlsPpty0sSzZaldtbvMpCawQbzDrkrt5FNOd8GN/zMhXVf58OJLw7STw0D1iPwe8sabFpx2QXqxRi2TAstzwVfnVXFF1YimtfkcKIymEIuFEtillSuF/Cdm1BLlwJlYTPB+NvURQwXId/xoQvNLipvJepzJi3NMrqyNTWdKAJKS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:42:19.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc53d60-cd30-4ba9-4fc5-08def2bcb27e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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

From: YiLing Chen <Yi-Ling.Chen2@amd.com>

[Why & How]
Apply the inbox0 lock mechanism for DCN35 to prevent racing with
driver/FW.

This requires DMUB firmware 0.1.68.0 or newer.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: YiLing Chen <Yi-Ling.Chen2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 43 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  4 ++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +
 4 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6e1079377f48..09b59466ae7a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1835,3 +1835,46 @@ void dcn35_disable_link_output(struct dc_link *link,
 
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
+
+void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
+{
+	/* use always for now */
+	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
+
+	if (!dc->ctx || !dc->ctx->dmub_srv)
+		return;
+
+	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
+	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
+		return;
+
+	if (!dc_dmub_srv_is_cursor_offload_enabled(dc) &&
+		!dmub_hw_lock_mgr_does_context_require_lock(dc, context))
+		return;
+
+	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
+	hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
+	hw_lock_cmd.bits.lock = lock;
+	hw_lock_cmd.bits.should_release = !lock;
+	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+}
+
+void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params)
+{
+	struct dc *dc = params->dmub_hw_control_lock_fast_params.dc;
+	bool lock = params->dmub_hw_control_lock_fast_params.lock;
+
+	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
+	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
+		return;
+
+	if (params->dmub_hw_control_lock_fast_params.is_required) {
+		union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
+
+		hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
+		hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
+		hw_lock_cmd.bits.lock = lock;
+		hw_lock_cmd.bits.should_release = !lock;
+		dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 235ebf00bd1f..e402e30f755d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -27,6 +27,8 @@
 #ifndef __DC_HWSS_DCN35_H__
 #define __DC_HWSS_DCN35_H__
 
+#include "inc/core_types.h"
+#include "dc.h"
 #include "hw_sequencer_private.h"
 
 struct dc;
@@ -113,5 +115,7 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
+void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
+void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params);
 
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index fc18d2207711..56e5dfef126a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -135,6 +135,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
 	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
+	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
+	.dmub_hw_control_lock_fast = dcn35_dmub_hw_control_lock_fast,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 19ec5b4edfdc..521b126d4736 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -124,6 +124,8 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 	.get_underflow_debug_data = dcn30_get_underflow_debug_data,
+	.dmub_hw_control_lock = dcn35_dmub_hw_control_lock,
+	.dmub_hw_control_lock_fast = dcn35_dmub_hw_control_lock_fast,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
-- 
2.43.0

