Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DB606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KYqR0nsi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1516210F93C;
	Wed, 21 Oct 2026 06:25:52 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2E410F8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKJIpNQoB5lFXBxETzeGc2q6II0lR7B/RtwCkhnEPgi6Tm/AJrf+Mjds+1ty11XUFxw68sDUhJVxeN35L3zEiH3xxZu6V4c0RC9CaXZ38zEsMRhEkwezRr8ETJajrjBllMDop8gfH+y4WXP263pZH0qknzk+pxqdGpgyCAwJtMTVNkNyi6EMH/CX1bG1VUhmMq8eVWdMJBUB6PGkPQLp4xgVNsGR9BXh5MFXSBsBUfLV5ikDtiy5Z7eQ4MAXwrjB2il3YNkBmhyMeVutcSL9PSAbif0JmKqDmlr/AvqFuKLCrqm+qrhCOd23wy5gRw3yJshFi0cnqmQWVEc1QsKi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYvY2hpO1QV0utkkwQzFGyq2G4KvC6YCBIIVsYqbXeA=;
 b=kJL4Rtgw0aluA7QNEGC0t3XHOJ3nOfietKpSrzs+f0W2zWQP5mI70PXkEr+BqfmsWv7pgcwhhGiQt6BUZe1s0Zhz/SkL3drwvYwfJvMq/ZNZhGM4DnjOo2EaYK2zSvRYlDbRBBbvbs9kSOEgCerx/PvnOe4HvHP2SJif5YBb0jG3wz4cUFTdCNTVyoFG0J5zzXEvUUAJRfANSWWx1+i9dupHgO9WlguCbV5Dv+is7BECnH6LbrPed4xcl/bj9OrVA57bajncJ4Ne8sr8y380eNiXJt7n5JsMZo6QGeBiZt+b6oNKpp0X8g+ZfV2zoVtqIA2WV2szAAT7RVwSTFPvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYvY2hpO1QV0utkkwQzFGyq2G4KvC6YCBIIVsYqbXeA=;
 b=KYqR0nsiE2reanBah3D69ZfUv+9JYZIuyxEFeckmozAY1h9Oy1mAk2WHt2JZ4iYnpEPhCHDq8bGATEDRzjLWIVj2F2B6i3ciB8mqlhG/rjd7Ng9AIuJs1NWm3r1KXKaYu7xjninRg4UdNvt+mATUn1zFHCDioRosqTdE6prX5+I=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:25:40 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::5d) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:25:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:25:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:25:39 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:35 -0500
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
Subject: [PATCH 05/49] drm/amd/display: Scaffold generic DMUB GPINT BLS
 dispatch
Date: Wed, 21 Oct 2026 14:22:11 +0800
Message-ID: <20261021062519.674697-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b11f305-0884-4381-a439-08df2f3c2063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|11063799006|56012099006|261009221227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5TtD4lMiW5UTgfwpn9BrkEwEy3NGNoFQmv521gsFWdzzmMt7QB+KcsA7BGwjcu5fglPqwAvdsxmVTtNgpFBpDg6I/X1AcXiWiqMFBrhYtLJHgWJXeKf5SvTSVBLnkSeF/KOwKW2+I4GmKnP4MTQkBzb82r6FaW71qlYA9zGlmeTKk7rg8vI5z5nmYfGlqJ/PDjhD1O3XDBDioIwhj0x25HCLXuIHEdGP4DGgQFJQ8sn6jhRJMosPZ+Evx4eRo6HzFd/+o9h8akwuxNXiZtlfKpEgBUiPLCvTOqURnwf5Tgr0q7WkcEkubcaTF55DYPGNPuNyOLoqk9ltOb5Kg0PUFRof6KtBA88hdRXGSePOUsUnguSV3P46Z6szSajJm9WCJU0Srtub8MtqoAas8zS7ZnvwjZkKQerf9j2cdU2n9xfxUm9fofYecgbmL9AuJouslYAuKcfVn8YE9phBkx53C6r9ikK5B/U8mdnMlfTe1c7ITYIo20MYMyQxfp75J+uzMlgOxdDpwWLGAQeYUXSet5XdtaXe6jJj0JcPNbdt7LRvSjxaec6Eb/llIeUmALLsvqcoamk6RSYWeU2UpsPfbASNo99thTGKyCfPMNiiA0bb6E+SCIiPA+q1QGLgh+m//Ww1BIR1EdMVPeYHaTWLknzmAAhA6+/jIEiAzFE0m9gyJgxZykZNyuFmB92B37xJphlrh15fRw2rmw6pDBAPrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7rOg9+xB3MvcgWCic5GWPx/mStnfehcbDARfFzZANv/7353ua5zvY1pZtzeASANEGLT65I/Nlpmh4wnbss5LS34n+XEUtxNu6xAwZyrAQGHbCEl8gjOKHdxRR4uPn3deCVy60bVrEslIEo5DdiBJfpGsQuwH13DJfpN4qmCvyJ6MImxhD+MPM3NmiDsaMoYwZz7Fe0dK9VQQFAKI90aUXMTqFZ31cDUppjXzlaGQeuYRsyUoOXQbA8tVZHPF5RO48DN0lZth5PKU9ws/Q0qzEI35smSXwfp4CShW90TloZod7EVkbTSQ63U2Xx+RzSDTnRGQ1fUfjUOxAZcuMHjgE8ua53jV/MbYxym5cNM6QZi6bP0a3vyD91ENV9u8UOamsrHW99tFLGmYwtNBetKjcBkPEJqDOSfyb+0LKJQb4tqJ40Muc9kHbhfQe/BZhvyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:25:39.7394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b11f305-0884-4381-a439-08df2f3c2063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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
The legacy hwseq is still in use; adding GPINT dispatch does not cut
initialization over.

How:
Register DMUB_GPINT_SEND_AND_WAIT with flat command, parameter, and
raw-response fields. dc2_bls_execute takes struct dc2 and dispatches
gpint_send_and_wait on the DMUB messenger.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/bls_executor/bls_executor.c    | 39 ++++++++++++++++++-
 .../display/dc/bls_executor/bls_executor.h    |  2 +
 .../dc/dmub_messenger/dmub_messenger.c        | 35 +++++++++++++++++
 .../dc/dmub_messenger/dmub_messenger.h        |  4 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  8 ++++
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
index 407683755509..93f80cf63142 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.c
@@ -12,8 +12,11 @@
 #include "bls_executor/bls_executor.h"
 #include "dmub_messenger/dmub_messenger.h"
 
-static bool dc2_bls_step_supported(const struct block_sequence *step)
+static bool dc2_bls_step_supported(const struct dc2 *dc2,
+		const struct block_sequence *step)
 {
+	const struct dc *dc = dc2 ? &dc2->dc : NULL;
+	struct dmub_srv *dmub;
 	struct clk_mgr *clk_mgr;
 	struct dccg *dccg;
 	struct dc_context *ctx;
@@ -42,6 +45,17 @@ static bool dc2_bls_step_supported(const struct block_sequence *step)
 				(ctx->dmub_srv->idle_allowed && !ctx->dc))
 			return false;
 		return true;
+	case DMUB_GPINT_SEND_AND_WAIT:
+		if (!dc || !dc->ctx || !dc->ctx->dmub_srv ||
+				!dc->ctx->dmub_srv->dmub ||
+				(dc->ctx->dmub_srv->idle_allowed &&
+				!dc->ctx->dc))
+			return false;
+		dmub = dc->ctx->dmub_srv->dmub;
+		return dmub->sw_init && dmub->hw_funcs.set_gpint &&
+				dmub->hw_funcs.is_gpint_acked &&
+				dmub->hw_funcs.get_gpint_response &&
+				step->params.dmub_gpint_params.response;
 	default:
 		return false;
 	}
@@ -69,7 +83,24 @@ static enum dc2_bls_exec_result dc2_bls_exec_dmub_send(
 	return DC2_BLS_EXEC_OK;
 }
 
+static enum dc2_bls_exec_result dc2_bls_exec_dmub_gpint(
+		struct dc2 *dc2, const struct block_sequence *entry)
+{
+	struct dmub_messenger messenger;
+	struct dmub_messenger_init_data init_data;
+
+	init_data.ctx = dc2->dc.ctx;
+	init_data.dc_dmub_srv = dc2->dc.ctx->dmub_srv;
+	dmub_messenger_construct(&messenger, &init_data);
+	if (messenger.funcs->gpint_send_and_wait(&messenger,
+			&entry->params.dmub_gpint_params) != DMUB_MSG_OK)
+		return DC2_BLS_EXEC_ERROR;
+
+	return DC2_BLS_EXEC_OK;
+}
+
 enum dc2_bls_exec_result dc2_bls_execute(
+		struct dc2 *dc2,
 		const struct block_sequence *steps,
 		unsigned int num_steps)
 {
@@ -80,7 +111,7 @@ enum dc2_bls_exec_result dc2_bls_execute(
 		return DC2_BLS_EXEC_ERROR;
 
 	for (i = 0; i < num_steps; i++)
-		if (!dc2_bls_step_supported(&steps[i]))
+		if (!dc2_bls_step_supported(dc2, &steps[i]))
 			return DC2_BLS_EXEC_ERROR;
 
 	for (i = 0; i < num_steps; i++) {
@@ -115,6 +146,10 @@ enum dc2_bls_exec_result dc2_bls_execute(
 			if (dc2_bls_exec_dmub_send(entry) != DC2_BLS_EXEC_OK)
 				return DC2_BLS_EXEC_ERROR;
 			break;
+		case DMUB_GPINT_SEND_AND_WAIT:
+			if (dc2_bls_exec_dmub_gpint(dc2, entry) != DC2_BLS_EXEC_OK)
+				return DC2_BLS_EXEC_ERROR;
+			break;
 		default:
 			ASSERT(false);
 			return DC2_BLS_EXEC_ERROR;
diff --git a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
index 6f45b37a3b87..561dabaaa294 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_executor/bls_executor.h
@@ -6,6 +6,7 @@
 #pragma once
 
 #include "bls_builder/bls_builder.h"
+#include "dc_api_dispatch/api_shim.h"
 
 enum dc2_bls_exec_result {
 	DC2_BLS_EXEC_OK,
@@ -13,5 +14,6 @@ enum dc2_bls_exec_result {
 };
 
 enum dc2_bls_exec_result dc2_bls_execute(
+		struct dc2 *dc2,
 		const struct block_sequence *steps,
 		unsigned int num_steps);
diff --git a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
index 077e15d82b19..d99c1bd6e914 100644
--- a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
+++ b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.c
@@ -5,6 +5,7 @@
 
 #include "dm_services.h"
 #include "dc_dmub_srv.h"
+#include "hwss/hw_sequencer.h"
 #include "dmub_messenger/dmub_messenger.h"
 
 static enum dmub_msg_result dmub_inbox_cmd_send_and_wait(
@@ -30,8 +31,42 @@ static enum dmub_msg_result dmub_inbox_cmd_send_and_wait(
 	return DMUB_MSG_OK;
 }
 
+static enum dmub_msg_result dmub_gpint_send_and_wait(
+		struct dmub_messenger *messenger,
+		const struct dmub_gpint_params *params)
+{
+	struct dmub_srv *dmub;
+
+	if (!messenger || !messenger->ctx || !messenger->dc_dmub_srv ||
+			!messenger->dc_dmub_srv->dmub || !params ||
+			!params->response)
+		return DMUB_MSG_ERROR;
+
+	if (messenger->dc_dmub_srv->idle_allowed && !messenger->ctx->dc)
+		return DMUB_MSG_ERROR;
+
+	dmub = messenger->dc_dmub_srv->dmub;
+	if (!dmub->sw_init || !dmub->hw_funcs.set_gpint ||
+			!dmub->hw_funcs.is_gpint_acked ||
+			!dmub->hw_funcs.get_gpint_response)
+		return DMUB_MSG_ERROR;
+
+	/*
+	 * Transport only: issue the builder-selected GPINT and write the
+	 * raw response. Do not interpret the command or the result.
+	 */
+	if (!dc_wake_and_execute_gpint(messenger->ctx,
+			(enum dmub_gpint_command)params->command_code,
+			(uint16_t)params->param, params->response,
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+		return DMUB_MSG_ERROR;
+
+	return DMUB_MSG_OK;
+}
+
 static const struct dmub_messenger_funcs dmub_messenger_funcs = {
 	.inbox_cmd_send_and_wait = dmub_inbox_cmd_send_and_wait,
+	.gpint_send_and_wait = dmub_gpint_send_and_wait,
 };
 
 void dmub_messenger_construct(struct dmub_messenger *messenger,
diff --git a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
index a66b167fba47..6d3bf5791e28 100644
--- a/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
+++ b/drivers/gpu/drm/amd/display/dc/dmub_messenger/dmub_messenger.h
@@ -9,6 +9,7 @@
 
 struct dc_context;
 struct dc_dmub_srv;
+struct dmub_gpint_params;
 union dmub_rb_cmd;
 
 /*
@@ -39,6 +40,9 @@ struct dmub_messenger_funcs {
 	enum dmub_msg_result (*inbox_cmd_send_and_wait)(
 			struct dmub_messenger *messenger,
 			const struct dmub_send_cmd_params *params);
+	enum dmub_msg_result (*gpint_send_and_wait)(
+			struct dmub_messenger *messenger,
+			const struct dmub_gpint_params *params);
 };
 
 struct dmub_messenger {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 24e438202ba0..06496f78d856 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -142,6 +142,12 @@ struct send_dmcub_cmd_params {
 	enum dm_dmub_wait_type wait_type;
 };
 
+struct dmub_gpint_params {
+	unsigned int command_code;
+	unsigned int param;
+	unsigned int *response;
+};
+
 struct lsdma_send_pio_copy_params {
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint64_t src_addr;
@@ -1216,6 +1222,7 @@ union block_sequence_params {
 	struct legacy_clk_mgr_is_dc_mode_present_params
 			legacy_clk_mgr_is_dc_mode_present_params;
 	struct dccg_initialize_clocks_params dccg_initialize_clocks_params;
+	struct dmub_gpint_params dmub_gpint_params;
 	struct hubbub_program_watermarks_params hubbub_program_watermarks_params;
 	struct hubbub_program_arbiter_params hubbub_program_arbiter_params;
 	struct hubbub_program_compbuf_segments_params hubbub_program_compbuf_segments_params;
@@ -1389,6 +1396,7 @@ enum block_sequence_func {
 	LEGACY_CLK_MGR_INIT_CLOCKS,
 	LEGACY_CLK_MGR_IS_DC_MODE_PRESENT,
 	DCCG_INITIALIZE_CLOCKS,
+	DMUB_GPINT_SEND_AND_WAIT,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
-- 
2.43.0

