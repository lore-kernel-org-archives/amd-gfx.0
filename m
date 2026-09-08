Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B9DC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110BE10EB76;
	Tue,  8 Sep 2026 11:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vSPp7X/r";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012000.outbound.protection.outlook.com
 [40.107.200.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6866710EB76
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttJj3mCqLN6Q8z0At5qWJMuTmpby3AjOIhLVabwPuSqM3udakM7hNEm+3Q378fR8KIxFI/xP9s/8mpWJeoH6wteoQyz+/Qs/Rwuhzsm7HaIw6fVW9k7eXd0C/YmWnAaQkO53Tk2l68UjUtFsgHDRXZ67ixbWrdXTvhIdmWzmerm5BOHC9/mRB5AnO2Vu67qcj7jbQTnfaNpM+3TUppYrgZv7tg4k9wGm/W1UYqbfYrQU3HjK1FilY8QGYvjt9lgoAeCo26PSxNUE4GfgY1SbcCM/urdto/QZdFWpPm6LkYNusyqx6uGk0RHQBAn8vQ/nD8VahsbXoOzMg+g3hMd+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvJ8vf/IgsW4ChrVqBuSQ8XsjK+eQx+XTCwe79cxZsI=;
 b=bESyP6SbBkXn5TwL9XgNtjDEeD1On3XJjZEkrVHDUI5DrVlEBps3QmoAroXebSjjjUXkvMULK7/aBPrFgSHGUl0QJP5u3h/Q4BYkUsjnjGw2NXY4RDHdWHhodjxSTFuTjwoZwznHuc+91jIqV43ky0jyT6gVGbMbOtEqp9tlCo9cgkgFcTu4Cd0WJJddUMicY+NFHlMtSqwnZbm/R/jzI6dIfoVy5yPrpYN5ybEvMSwTe6tsBfOZaZ5rxiNbNFHmidotkhCxOMdF3KEYoWroJRTPaJZ6W9EA+WIL/dfKenjSmKc3GlT4jzCY1ZMuk4ISOf5GmO6MYyNOkAFral79vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvJ8vf/IgsW4ChrVqBuSQ8XsjK+eQx+XTCwe79cxZsI=;
 b=vSPp7X/rEB+qyzcyWqwlSbU7JY2OZPzuvVJTlH/5qeWmVv9PrVNGhpZFFuHfi1Pyf883FB/W4N6smOQ1wfhFAel+znq0Bp5Ba3GqtqTTm35bou+A7g+AyzM6rPJd9NX/yVjwELXbRggmp7mDvtWUXDFL2jzY2ib57QqQss9becE=
Received: from IA1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::6)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:44:07 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::a5) by IA1P220CA0019.outlook.office365.com
 (2603:10b6:208:464::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:44:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:43:51 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:43:37 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 63/66] drm/amd/display: Add inbox0 HW lock helpers for DCN35
Date: Tue, 8 Sep 2026 19:31:56 +0800
Message-ID: <20260908113338.2433445-64-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: b914bcca-e419-4885-71a9-08df0d9e7d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TfiIxNKSrIDfT9op1At9bb0fkAy38NOlsiFvkW8wrdThhCNqx3PYuKlE3lK/dI6fH179yhFJKGURxVy8kYDQIQz3/MF8AV/ATQVUk2es37/JdDVo/e8SA+NuI07xeEY265ke0FaLXv0jXj8URfcE5GVC+0YIxXNUCSM/r3bTPoGe4kCPL8HhL8FNOqtW7m4s0yU4JL9V5qS1dc3oPDcReEe6MRozYl209Thk96uOv1LWvOYOTLoNnPsdT891PEWdwPTEJHZsbEoWeZUuPWh0lJBV4YR+R9YoHlL+RA+pRLJPDIs8OHJEuoBndqsAMxECrsAvAtiPcwVp4KNFpP+YLlndXqPFQBZHStKzT/XU3jjrZ03RpcGaLSlu1WawLsaZO0r8qFSiaRTInnbGP8iCDZ2SBWiNfVgToeFf+hnzbtT0wUjgoY/HhJTenz/LgTYg1qCEpMvh7ptU/EEXPDdqA0QHQwaiJlgRlS7hyZdchs9Ux3URlYDO0NUjSIMBxx5JzZZ5WwYsiBjU4G/gasNyleoPkyTFg0j7352ttYHt7x7XMHneCEVb7RlSjx4BHhdnGoJOvLkDh/s6+d0FlOa2QPCunA4UMZK75qY7sSz08eCXfxILYndLsVbuIzdlCevB1sA0AwhzbMtMJePPcELjMnWnFoGwCjmyzSKyerN764njOkMpyRF63AWqU47WOByiMnAG2DidvHex+w6FmEx79g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wy5S+NdxDinmHsFPD9NXiPhrmH+EijN5WOJad5/caJbSTkt/nnfRZejFnGFD4Kv1Fo5dyA8/GcGbA0N79YRIXL2xagvSDEpHG7IFIyekOC/fwGic5kxTXF5ZpB48b3B8d1cuiMrtjJzjSajkSZAhDef02jn+RnLZ44BNVj46bXVYPRIQhDFBDuPMG+Taiovl0/kL1BwDxejfXi7Mcb7ty7iSgf6OiQUXfzDhSKznmSSWI151KcYELthmdCv7J0iHkeZ85JNXjEdhvnHqG0pOT0V419iHgiI4ZkNbfsJBZGI1rWeFawoZcEOpSs9uJUbFxi9gPoXqnlIWF6B0i1ElyK0NizfeOi1c9NwMJGAIqpRateB4xOxZDJQdxrRltxA4qSYnJIGWB+SbVbY4B8xduaKWBhp2pF2LzZG2eGQh6/S4qCheNc1SjggMnfSVpjeH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:44:06.3674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b914bcca-e419-4885-71a9-08df0d9e7d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
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

From: Tom Chung <chiahsuan.chung@amd.com>

Add dcn35_dmub_hw_control_lock() and dcn35_dmub_hw_control_lock_fast(),
a SW lock mechanism to prevent racing between driver and FW.

The helpers are not wired into dcn35_funcs/dcn351_funcs yet, so there is
no functional change: DCN3.5/3.5.1/3.6 keep using the existing inbox1
lock path. Enabling them will come in a follow-up patch.

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 43 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  4 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 942d3f3d9f25..a0944d53860e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1822,3 +1822,46 @@ void dcn35_disable_link_output(struct dc_link *link,
 
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
index fce9acb5c2fc..392ccbcb343c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -27,6 +27,8 @@
 #ifndef __DC_HWSS_DCN35_H__
 #define __DC_HWSS_DCN35_H__
 
+#include "inc/core_types.h"
+#include "dc.h"
 #include "hw_sequencer_private.h"
 
 struct dc;
@@ -115,5 +117,7 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
+void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
+void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params);
 
 #endif /* __DC_HWSS_DCN35_H__ */
-- 
2.43.0

