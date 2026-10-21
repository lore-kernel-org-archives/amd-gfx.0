Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C0606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S9Xd1psl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36CD10F930;
	Wed, 21 Oct 2026 06:25:47 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9EF10F92F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC9OHBrrIYt9gh0roDQDFQ9ZHIhk+rbKD/gJ/z2awZK36xfXyWwLt1qEELpevo4Gf/ARVf5LbQvi+8GYapF7kQalpvA74jZeHZiWk8ZxlJxJWNROTy5pOWhkkazaLzKCTVYxSccMsGmcpgmpL6IfPD9W0l/f0RkIe54NEkk254vD+x4KPmyMqiIi8RuM8f0FZ+FMXaaSJ/L2UctHNs56LiSX5QoiwngNEUGuBpWfT6K9vEyqFuLYuDFCHiWGXTiy30/W5ZM0m4JG6VKonkvDowlfXtB0ZPv+ZYhPeQdpI5MQe3cddAYoOs3s1NBb9//Q5wP/QGwWAJ72NOqFscKZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPRSgyVUrm1BUg8gMhUC4WCe0i1c2DT7ywXACZ1NToc=;
 b=Z72U5oMqadXBOwbeAcffFc7GToiEptrwdoRbFk0HjZyQWFWL3gFukGEbL6WxhSSVhZ5fuq2LMtd/4I4UTPNqtghOAzrvtKTfTk9EKJbdodrgbm8eXrbE+q98Ye5rr/CHr3Snee52KEiQ1H25q/AUyuiY7bQszJCtg+dtesOlamO4tH2u0/DgFGxhYvBVcHo4ASVgN4RsVChTgzd67jeZZfXH2JFhvVAaMrS9Wld985XJMLC/FfcXLzA/UbXIPnLBRAB2onPZ/tOLI5YFTwnCGcwOp6UVkbyP0TAZWFobgskxh3F9JNUu/5o03GjuCfUZzx+YBrjGaWxwke3P7fj5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPRSgyVUrm1BUg8gMhUC4WCe0i1c2DT7ywXACZ1NToc=;
 b=S9Xd1pslWfOzDVPofCXW+F1fb3jxP1zfI7F88aofztv92q1M32uktugbCDreBkdUNkaYxSSE+rerlWHK8Jdis1XjOHDgL+0msYINQELn85aJZ57ufIjYrzajcTuDG47EECCpwvymKlR9WenAK1V11BT/vvXihZSrxrMvgvIzgsA=
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:25:36 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::a) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:25:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:35 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 04/49] drm/amd/display: Scaffold DMUB inbox BLS dispatch
Date: Wed, 21 Oct 2026 14:22:10 +0800
Message-ID: <20261021062519.674697-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbfab5c-891c-47eb-8ebd-08df2f3c1e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|261009223027099003|10067099003|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VphjfibAA0SsD2m8YzZ1e/ioFA+NIuuzSNXeFFzS/1d5VFyo23sxZ2gkaDaBLkbX9rfA6wHevMSgA/P8RDRRcFLvO4LsxaEK7utGgLiebWE5pMDpsb1T2yc6ewh7L+YM3zWqO0VDqp+hWdbb0A9E3MZXIy3eC3sxQT7P1BUwxe3a4ABNQHkEfxL6uXd2XK9V/T5t2PgIN/UeOaceTh0vzxJtWGTEYqIcLunMMgoL9oVbcIrOmHKIxdFCaDCG6wYRcY+bx91qZFjMcsNDAELzTEcLrMtMhhmwWcxhyopboKJ3U7UPGtXAXKNdlZaEBnXwO12elJg6juSZGF/7u9r5zPTg3Fy0ZmlPhbKdWneKjdhsnHp6cE5FzZKa1Vgj/U1xzNyj9er7vXv2AWivWpJiE/mXXRe8nRyFPav0SKgk3f26eez5la6D1mQ2N7KxuO0Uv4RUiK/me+nWFYxuCxqLv40geDLrEAyvhcFNBCArhUUd+bPZXAUj+eWnwOyDYsfLetIJP0ITxzraLGF3OxISccIfkWSE3weql8wXx/tSvDjBuUnaMDrXkfXfeOk1nZrFohRBhDaycOuo++4DuESGF7McQrzAc4G44J23P1NlTgioXUDAAmovo48tdhp7GttQWMmdUqYT1ZNFBowQmfl8dwIRCDFLQkKfKU0YvlW/Q3sn6kpIg4Md/ki9WcegPkYhIdBZH+PU1xR98a5HuFzOyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VeQVFjFDMsp9Bpiszsp8Kcm1L3fOXBqHV6EXVxbFZGF7js7Kf6lZFJBeDWg1BcmVhWlEfukGvuCn3pWNeupThBNuEVsy4DXQzfD1Ow5LmYFMV5cQk9zzvcpiGtRGh80LgB9aD/Hd/tr70HpAmqt7pchOXAhsrC58Nemmer2r21fSpgiHXiYTtRw++KRgTyUF/GjgRYmJJAvt+Z2eRt2O8mf7GzJqwINCqQyZ0mALa63TAnstxeVcovN6b52ihu1G59PCGUl9Ym2Ga7e035a7+5BDrpzh5e3BrBVVZ2sesIch/vSIln6k0envsxs56q9/dVNW5jCti6oJQyleh/BY7bjdFVFJ1ZeY8sLsFz7rwEMzUeEo25KC7NhERUO7nIl3eJUofot/bPAjqUl2nzxvJCwfROTb9N6x8kx8WjjEEQKnSYloDLGmhvhR3w0foR/O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:35.8959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbfab5c-891c-47eb-8ebd-08df2f3c1e18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

Why:
This is still builder/executor scaffolding, not a live init path.
The legacy hwseq is still in use; adding inbox dispatch does not cut
initialization over.

How:
Dispatch DMUB_SEND_DMCUB_CMD through the DMUB messenger. The
messenger copies the builder-built command and forwards the entry's
wait type without reading the payload.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |  1 +
 .../display/dc/bls_executor/bls_executor.c    | 37 ++++++++++++++
 .../dc/dmub_messenger/dmub_messenger.c        | 46 +++++++++++++++++
 .../dc/dmub_messenger/dmub_messenger.h        | 51 +++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 56a39d9da119..795b30b066c6 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -88,6 +88,7 @@ FILES += bls_builder/bls_builder.o
 FILES += bls_builder/dcn401_init_builder.o
 FILES += bls_executor/bls_executor.o
 FILES += workaround_manager/workaround_manager.o
+FILES += dmub_messenger/dmub_messenger.o
 
 AMD_DISPLAY_FILES += $(addprefix $(AMDDALPATH)/dc/, $(FILES))
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index b1425f8ca73c..407683755509 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -7,12 +7,16 @@
 #include "dm_services.h"
 #include "clk_mgr.h"
 #include "dccg.h"
+#include "core_types.h"
+#include "dc_dmub_srv.h"
 #include "bls_executor/bls_executor.h"
+#include "dmub_messenger/dmub_messenger.h"
 
 static bool dc2_bls_step_supported(const struct block_sequence *step)
 {
 	struct clk_mgr *clk_mgr;
 	struct dccg *dccg;
+	struct dc_context *ctx;
 
 	switch (step->func) {
 	case LEGACY_CLK_MGR_INIT_CLOCKS:
@@ -31,11 +35,40 @@ static bool dc2_bls_step_supported(const struct block_sequence *step)
 	case DCCG_INITIALIZE_CLOCKS:
 		dccg = step->params.dccg_initialize_clocks_params.dccg;
 		return dccg && dccg->funcs && dccg->funcs->dccg_init;
+	case DMUB_SEND_DMCUB_CMD:
+		ctx = step->params.send_dmcub_cmd_params.ctx;
+		if (!ctx || !ctx->dmub_srv || !ctx->dmub_srv->dmub ||
+				!step->params.send_dmcub_cmd_params.cmd ||
+				(ctx->dmub_srv->idle_allowed && !ctx->dc))
+			return false;
+		return true;
 	default:
 		return false;
 	}
 }
 
+static enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
+		const struct block_sequence *entry)
+{
+	struct dmub_messenger messenger;
+	struct dmub_messenger_init_data init_data;
+	struct dmub_send_cmd_params params;
+	struct dc_context *ctx;
+
+	ctx = entry->params.send_dmcub_cmd_params.ctx;
+	init_data.ctx = ctx;
+	init_data.dc_dmub_srv = ctx->dmub_srv;
+	params.cmd = entry->params.send_dmcub_cmd_params.cmd;
+	params.wait_type = entry->params.send_dmcub_cmd_params.wait_type;
+
+	dmub_messenger_construct(&messenger, &init_data);
+	if (messenger.funcs->inbox_cmd_send_and_wait(&messenger, &params) !=
+			DMUB_MSG_OK)
+		return DC2_BLS_EXEC_ERROR;
+
+	return DC2_BLS_EXEC_OK;
+}
+
 enum dc2_bls_exec_result dc2_bls_execute(
 		const struct block_sequence *steps,
 		unsigned int num_steps)
@@ -78,6 +111,10 @@ enum dc2_bls_exec_result dc2_bls_execute(
 			entry->params.dccg_initialize_clocks_params.dccg->funcs->dccg_init(
 					entry->params.dccg_initialize_clocks_params.dccg);
 			break;
+		case DMUB_SEND_DMCUB_CMD:
+			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
+				return DC2_BLS_EXEC_ERROR;
+			break;
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
new file mode 100644
index 000000000000..077e15d82b19
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include "dm_services.h"
+#include "dc_dmub_srv.h"
+#include "dmub_messenger/dmub_messenger.h"
+
+static enum dmub_msg_result dmub_inbox_cmd_send_and_wait(
+		struct dmub_messenger *messenger,
+		const struct dmub_send_cmd_params *params)
+{
+	if (!messenger || !messenger->ctx || !messenger->dc_dmub_srv ||
+			!messenger->dc_dmub_srv->dmub || !params ||
+			!params->cmd)
+		return DMUB_MSG_ERROR;
+
+	if (messenger->dc_dmub_srv->idle_allowed && !messenger->ctx->dc)
+		return DMUB_MSG_ERROR;
+
+	/*
+	 * Transport only: copy the builder-built command through the
+	 * injected DMUB service. Do not read the command header or payload.
+	 */
+	if (!dc_wake_and_execute_dmub_cmd(messenger->ctx, params->cmd,
+			params->wait_type))
+		return DMUB_MSG_ERROR;
+
+	return DMUB_MSG_OK;
+}
+
+static const struct dmub_messenger_funcs dmub_messenger_funcs = {
+	.inbox_cmd_send_and_wait = dmub_inbox_cmd_send_and_wait,
+};
+
+void dmub_messenger_construct(struct dmub_messenger *messenger,
+		const struct dmub_messenger_init_data *init_data)
+{
+	if (!messenger)
+		return;
+
+	messenger->funcs = &dmub_messenger_funcs;
+	messenger->ctx = init_data ? init_data->ctx : NULL;
+	messenger->dc_dmub_srv = init_data ? init_data->dc_dmub_srv : NULL;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
new file mode 100644
index 000000000000..a66b167fba47
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#pragma once
+
+#include "dm_services_types.h"
+
+struct dc_context;
+struct dc_dmub_srv;
+union dmub_rb_cmd;
+
+/*
+ * Live DMUB_SEND_DMCUB_CMD still carries wait_type. Distinct inbox
+ * primitives are unresolved in the DMUB Messenger spec, so this shim
+ * forwards the builder-selected wait without interpreting the command.
+ */
+struct dmub_send_cmd_params {
+	union dmub_rb_cmd *cmd;
+	enum dm_dmub_wait_type wait_type;
+};
+
+struct dmub_messenger_init_data {
+	struct dc_context *ctx;
+	struct dc_dmub_srv *dc_dmub_srv;
+};
+
+enum dmub_msg_result {
+	DMUB_MSG_OK,
+	DMUB_MSG_NO_MSG,
+	DMUB_MSG_TIMEOUT,
+	DMUB_MSG_ERROR,
+};
+
+struct dmub_messenger;
+
+struct dmub_messenger_funcs {
+	enum dmub_msg_result (*inbox_cmd_send_and_wait)(
+			struct dmub_messenger *messenger,
+			const struct dmub_send_cmd_params *params);
+};
+
+struct dmub_messenger {
+	const struct dmub_messenger_funcs *funcs;
+	struct dc_context *ctx;
+	struct dc_dmub_srv *dc_dmub_srv;
+};
+
+void dmub_messenger_construct(struct dmub_messenger *messenger,
+		const struct dmub_messenger_init_data *init_data);
-- 
2.43.0

