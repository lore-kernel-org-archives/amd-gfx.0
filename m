Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CDAC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E79610EB56;
	Tue,  8 Sep 2026 11:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Js2Q+EMl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185C710EB56
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdnZq5QA2xc2CU3TpYLNAVeLCjByoh5QxCkEqONOuxP/QkgcKMWbXfoGz//F8V3lEtBprFOP4YKTdvRHsksmAFJej288fgUuvBbg5EHzZAf6NYvHo7Y/MCa5zanHgCoI93Yd4qQYb+w4qOnoFtrV6C7Q0g7MJHY4BI3S1l7K8pFkp+Rwv003Qky6SxXdSGQdq1n8uVCCKJe7fsN6TfbMALZlr61EcFMBlUJTi64eMNJBQLPGmXqGS51dPKWP5xZZkHO/9/Ffy0bgL8eAtmjsI8COBByf/qzJJV+m6np4ItRiV2c3g4ArNiNoBNvO5hrxCD3flYKOqmDKLGYxwuizfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMwr7CDA0tKV9925rFItPCNhBhXUKww8pgGg4AfTjIQ=;
 b=oiPLrE5OKfq7ZJsZGHFw6I0L2j/F/DXQm3+6lPwIteWCS0XLk2kqejw2/BThbm2yIgmI/EIWQ6L5o4UnWAjbqU3kyhnkD90tKyPDqflKKPuD6qLZK4I2Ijh0CwKwguS5S2WZQ4a+pfL3KP+zHrjFGo53BbbGv8JuGiTw30+xbs/ZsGdXUVf/F+yGzsEozzrsfQUS0eGuoy8F03l1S0L8pgxqlyEusNA9SzED2J71gWcmjUE3JGEUnJ/AXJ948bvALdc2vzd7Vp6FeHxGJ4QytHNo54aPweLHz9JvNF/NIppzRSF5y0bWen5cxJLfwIJDbXqaz5G+j+eLyrj8riJQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMwr7CDA0tKV9925rFItPCNhBhXUKww8pgGg4AfTjIQ=;
 b=Js2Q+EMluwTkje6V8OgU0oPfDmA4zXkXJ/iGc7XaLU+XcF+fNwIXl9HhnbgTkSfsN/3GMfdwboDGMW4st2LQS7VZ+D7kx6OW2wHK4VOuzUE5bcL6oRcvvC6dlheN2jEqW+l7JtVYnwDb914aU1nTb+l16Alh90AZUYyLlVkxT8A=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by SN7PR12MB6960.namprd12.prod.outlook.com (2603:10b6:806:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:39:26 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::69) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:25 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:16 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 38/66] drm/amd/display: Add instance field to struct mpc
Date: Tue, 8 Sep 2026 19:31:31 +0800
Message-ID: <20260908113338.2433445-39-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SN7PR12MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 571fe7fc-6bd2-4a2c-c538-08df0d9dd615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: nSElobJcUqYfGzgwlnnQypiDlOPwTd5LXkSlq3/VWiblye9eH3kmT5RRmVzn1bz7sJSxYZFs63MWhOytJL0kCayVARauwpWsRwvQHoLK0MbpVPFER7o94KFaHFwPyirzRBOcFTLIVAaIt6X1FmXSYu/ErqdpFIDcx+WrjmarxNCVsOTc/g30De8wzZGDDOv+3gx9cBc8N4HXcNDAG2vw8dLC7vbdnzs7bsJvTTXfyh7J+w9SFam53yN6HwEmLk4W5Abx+JGVeiDluLpBdIVxyNyFAp4nMFrKe/O1fAbS56vsxGe+dd8SIbvis9siNZipfthyHDRRcg6GcxTL5+yBzklFRIh9le81dBRjZQCBTLkmGuVC+ziJnZkVgKHEgq3lgllkz4ZLE9GpAtA73iUkEA4QrlGRoL7WYAOHaWaKlmdgqNqeWA85uInoKcWrIh/7Ghegj+JlfSFsYoe+L9ja2b69r5Ob5mqKVVBsbEKgfa/KcPE2Q92zmnAgxIBIIQXIMKdj9VjCQ2AX7Tyh5y1n7UeK0qPL5hQTOzk5tewSsmp5hIMAviSJMKamclmtogyYiXGYqlEIQIfGcLDv/plqTH3K/+9fIxUqsmq2KFDD8rNqM4bP+0XWqdglntKibMwDinReQN5HYU7GekQlpdvOclg4vo5Mrj5/M7EFfppWiI5BXHrX6Y4HS4ZMZuQarl2iHd1CvnajS5FNqx7WpWffkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3XPm1rKY8gonPTik/ow+9D8A6vW3fWV+VM+uBYB9OQKEqMe1q9B3wwmhJc13ZA9Ubta71VcWVvOnI614P2AVrD5KN+PFFblE8Gvrq4728vnBrZLlhVxEaMRy599HT4ZVb9IzGLGycWwq2mNSEQT+I72XMF51ZBQ5vRY1vRCaDnKY1Nr6USiA/a/135uWNpV/KRLoWOBNhYSic1HqfWYFO7juoT/nvpeSAFrCIPQAS9WcgASAoGbtRCwVbuptUIE0GQewOr+2pS8CJz4rxJtxCLIMn6QwcNrHr1yG3PZEXn4u1FqIjHzJ5uJrV9OpDuxksTRAqfooddPS9YUVXrOGug3sy9fvlr5Y8vSXGEeaNadKok1MFBkb59/INHNxtxz0qsshLCGE1/CBu64h6c4yjxN07It4cQXVOao5Y1ooIUlFGMjj29DbrynjlaISHulQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:26.1638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571fe7fc-6bd2-4a2c-c538-08df0d9dd615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6960
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

From: Tony Cheng <Tony.Cheng@amd.com>

[Why]
struct mpc has no instance identifier, unlike other DC hardware
blocks. Debug and tracing helpers need one to identify the block.

[How]
Add an inst member to struct mpc and initialize it to 0 in every
dcnXX_mpc_construct(), since there is one MPC instance per ASIC.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h            | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c   | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c   | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c   | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   | 1 +
 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index d19f90a5893e..75ebfab87efc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -281,6 +281,7 @@ struct mpc_tree {
 struct mpc {
 	const struct mpc_funcs *funcs;
 	struct dc_context *ctx;
+	int inst;
 
 	struct mpcc mpcc_array[MAX_MPCC];
 	struct pwl_params blender_params;
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
index 0f2294bedcc3..f9bd1d6e1642 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
@@ -503,6 +503,7 @@ void dcn10_mpc_construct(struct dcn10_mpc *mpc10,
 	int i;
 
 	mpc10->base.ctx = ctx;
+	mpc10->base.inst = 0;
 
 	mpc10->base.funcs = &dcn10_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
index 0e09d073ab29..905d4f23f92a 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
@@ -588,6 +588,7 @@ void dcn20_mpc_construct(struct dcn20_mpc *mpc20,
 	int i;
 
 	mpc20->base.ctx = ctx;
+	mpc20->base.inst = 0;
 
 	mpc20->base.funcs = &dcn20_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 9cc6fd38da19..f3213ecb1745 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -1589,6 +1589,7 @@ void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
 	int i;
 
 	mpc30->base.ctx = ctx;
+	mpc30->base.inst = 0;
 
 	mpc30->base.funcs = &dcn30_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 1f15ada109b6..61a1e3f06575 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -1036,6 +1036,7 @@ void dcn32_mpc_construct(struct dcn30_mpc *mpc30,
 	int i;
 
 	mpc30->base.ctx = ctx;
+	mpc30->base.inst = 0;
 
 	mpc30->base.funcs = &dcn32_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index df92d8008fe6..e59454090691 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -680,6 +680,7 @@ void dcn401_mpc_construct(struct dcn401_mpc *mpc401,
 	int i;
 
 	mpc401->base.ctx = ctx;
+	mpc401->base.inst = 0;
 
 	mpc401->base.funcs = &dcn401_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
index 0123a9fcfef5..37d024cfb3fb 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
@@ -121,6 +121,7 @@ void dcn42_mpc_construct(struct dcn42_mpc *mpc42,
 	int i;
 
 	mpc42->base.ctx = ctx;
+	mpc42->base.inst = 0;
 
 	mpc42->base.funcs = &dcn42_mpc_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
index ae6f2f1b7eca..e38582f0a319 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
@@ -273,6 +273,7 @@ void dcn60_mpc_construct(struct dcn60_mpc *mpc60,
 	int i;
 
 	mpc60->base.ctx = ctx;
+	mpc60->base.inst = 0;
 
 	mpc60->base.funcs = &dcn60_mpc_funcs;
 
-- 
2.43.0

