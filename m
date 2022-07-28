Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC10C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F70F11A28E;
	Thu, 28 Jul 2022 20:34:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB1B11A28E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 20:34:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llU6ALruKvWB4kxxUo018+E6JAH9LbmrcYYlWWQ4mckMMfBbTF7stJTiWjqqJ+rmy4XBRr4bFa7tqGOEiHsJEQKnzhVtynooyHmcerJnE7SFYhYj3fxULl9fCmxsjaplE7Q98pIem1BpTQHyGcnbIXgu0KGZbJLH/OqUduad6q3P8c/owKKDj8T8up/2ogBGkb4TeCx+5gRxaNjEKqj9FBkJdYqsDL/meXFKvWrGNE2wzfKO9YvyipNR1IVffQN8wdUkrNn7kRbxFV1h0IQDsNCfGlqwMmMSW+vRjVYIcXxvjFv1HymqaKXtNVyX4F7icQaMSGzMKEQc8oB+H49sOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ785rrGUPg1CVDRwHs6P/xWRvlnQBwdSRQsa6CT8ls=;
 b=TqotQ1jEP6XgKzM8ZJgJu95aGvoiBB/aOaCHpJ/HH1x6hANdG9EI8n9Rt3mFzN313V9B2kwkpdx3I3oQrwmIc4zJwJ+QNjAodUXqxshr8svt5xBxCQWV4uRicPG2l3b+gllqdSPc+gk8NbdHZ4wfCLKCkxp0p7OFbo4v9WcfhkZE1SI8rQZnEF70EneW2JupmJiq+TrySYe/+MVQvKV92Cu73sQd0jsGFeE72Cfml7mmigzCW/s0N/tdNZgIthD5NQ0braIxHs2FTIoEDA7lS/suYBEnKUO0ckEYnVPlbM4AiTbh4NbXCWUTT3UzE6AZ8pLb8idgdbolK30olPfMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ785rrGUPg1CVDRwHs6P/xWRvlnQBwdSRQsa6CT8ls=;
 b=z9nq7dqsJOUyU4h6hPkwphtfh/h3XnUoXPFlIDYZ2ygXNOt3sXzCg2FtcMWsXnhKHZ3NHBTPPjLIelIG0JMRLBpVa03o2sf701F17rIrSbffM7RVhRvb2/vCg7JLlQZVl5jLhyHH+YkIZQx9WQUfzFIer5+KSKXQpOk9Q2dq0uc=
Received: from MW4PR03CA0143.namprd03.prod.outlook.com (2603:10b6:303:8c::28)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 20:34:05 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::29) by MW4PR03CA0143.outlook.office365.com
 (2603:10b6:303:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20 via Frontend
 Transport; Thu, 28 Jul 2022 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 20:34:05 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 15:34:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix a compilation failure on PowerPC caused
 by FPU code
Date: Thu, 28 Jul 2022 16:33:47 -0400
Message-ID: <20220728203347.2019728-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cd32a93-7bec-4daa-aa99-08da70d883db
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zp2mEVa2ltIhEV3Gd3wJaR9b/0veWmsW42LuYyEbJ0Mk4O1m+5ShgwrUwgQ4+/pY/kl9srbHZO+a8X4vBUnc5WC9OujIUPiCYdAZuYZ06r0DWxy/379qsbNQHuqURhMoX57EC/C/JIl7k3XvU9FuoR39/wFvfkC+z9hyciJOBLiUXi+/cDMEaygSqBgRcG3JMl5CHvbfGhptGHimFgPp8idBX0DrjnjYsJ4SHlygl4V8hVmdhYWuPlB6jfYg6q3sODyOderkasqzQFJ0L8ISR5UlUUDJvNsIpMDLee3sYmBYj+KyxMvnQXFPFPtRoPEhpp64hz3iL8uTyP5p/8inS6e8LFvdhu3OQtE5T4SQATzlJZ71MqwE9nNPx56nn6rr8/LIm8HfY4MDrfWYe6Jgrz13z7DeMpUXLj/Tn9bliepPtGxW2czmWEj2f++SiYD0Ih5EZfGwLgqfkKX1XHoc4a67xr4ue0HkvZKjk5AGyOgwL4lLuW4YfFy0l7XAyrUM3r4NlYfeyYtRkqzhtJDzQN0B8Atoh+db4b92CSD1OfL6SAheReelpUsRgaF4XZbtqGgQ6pqL8efo/109T14hVZm2qgrweGuYhC43s6wbGcNLJJMFbjwqW+Uv3WscLDtxqermD+nglXiCTC7vIMIsLolrIpYRESRMsrHbfPhB0MPzxhLaXDfA++6bZPU7fdCsF3EPQcflWc7muDpKED0q37dlyoKrueQ3AL+aprlMEpHeZjXCjghAsEU0+dU9hEYq/hd+tM8YKvAesxd79bmHPln01MdqJFhgQKMNVa752OwMXL7hF3hWg3aA7v5SgKTrwDpwefp56moqbz8xPb2FSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966006)(40470700004)(36840700001)(41300700001)(336012)(7696005)(186003)(1076003)(82310400005)(6666004)(47076005)(26005)(40460700003)(2906002)(81166007)(82740400003)(356005)(40480700001)(316002)(2616005)(83380400001)(426003)(16526019)(6916009)(54906003)(36860700001)(70586007)(70206006)(36756003)(86362001)(8676002)(8936002)(5660300002)(4326008)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 20:34:05.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd32a93-7bec-4daa-aa99-08da70d883db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We got a report from Stephen/Michael that the PowerPC build was failing
with the following error:

ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o

This error happened because of the function optc3_set_vrr_m_const. This
function expects a double as a parameter in a code that is not allowed
to have FPU operations. After further investigation, it became clear
that optc3_set_vrr_m_const was never invoked, so we can safely drop this
function and fix the ld issue.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c        | 8 --------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h        | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c        | 1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 --
 4 files changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index d072997477dd..1782b9c26cf4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
 }
 
-void optc3_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg)
-{
-	DC_FP_START();
-	optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
-	DC_FP_END();
-}
-
 void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 33bd12f5dc17..dd45a5499b07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc);
 
 void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
 
-void optc3_set_vrr_m_const(struct timing_generator *optc,
-		double vtotal_avg);
-
 void optc3_set_drr_trigger_window(struct timing_generator *optc,
 		uint32_t window_start, uint32_t window_end);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 992e56c6907e..eff1f4e17689 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
-		.set_vrr_m_const = optc3_set_vrr_m_const,
 		.set_drr = optc31_set_drr, // TODO: Update to optc32_set_drr once FW headers are promoted
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc3_set_vtotal_min_max,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 62d4683f17a2..4cfa733cf96f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -302,8 +302,6 @@ struct timing_generator_funcs {
 			int group_idx,
 			uint32_t gsl_ready_signal);
 	void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
-	void (*set_vrr_m_const)(struct timing_generator *optc,
-			double vtotal_avg);
 	void (*set_drr_trigger_window)(struct timing_generator *optc,
 			uint32_t window_start, uint32_t window_end);
 	void (*set_vtotal_change_limit)(struct timing_generator *optc,
-- 
2.35.1

