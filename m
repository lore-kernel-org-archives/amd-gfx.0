Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECD9C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA93910EB68;
	Tue,  8 Sep 2026 11:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZU50KK1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D677D10EB68
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG/uG1IKuadBgD9OjWihAsOvqLemedGT3UY+sDjGn/Y4t0Up2kiWcoZj5uRqysWsxzCQd5l6OTSd2FvpyVN1Ib0Rkjjh1HXeZHxTVGBriV2NnVXvrRTkr0cunfd3CWWOkQtG0q3rrXUgEZFx+RzRPlvLa9V++VtqwiJn8JxqrdlkMYnXsyc4n2LpHxYbZUmnc9Pwp9ilR5eQc0ahiRwKaxHjF4gvfLiiJ1V6i4yWdw4UTFeTebyQaAh9hLoHXAjRbA/qyfyDL1OJqNtIi9CFqXH22rTTpSyXre6whyJdKMM+/iaNEc6UuEY7ZmiuFghvxESj+XBwnxHhvamQcsJiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrWcYtpdd0pGrRZ2cj6+8PkO4SZm7vMKAOM5aevZWrU=;
 b=IGCU2woItqJyPLmiV7JEW8A95AkgKchodvOG/scuklz0n8QziwEOgNiqUHRd4zAEOlE6c4/4RGz0tXj58aYvuCr+Y5rMASEaRlDvIGD8uSavDnxsPRajeBAuWmsvlPBZIFwvElva9G2Som+YIWmTRhTp5JCFzDW70OspuoXersUAPbxFQ1GC3RoTv7kir8W8ds+Qg0BjM7lCaoF43+Nt76PQp0YgowSCJIpdWc6fxak+qVF0M4aVW7gXCmyg4ztc+frHX0Ey2UNYEpMSktvrA2JYAPHhoaAihoWG3PZgfLOtjwfSz86w5Wyf36KwJOcoQUNsOTZd0JnWFtXvwlvfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrWcYtpdd0pGrRZ2cj6+8PkO4SZm7vMKAOM5aevZWrU=;
 b=BZU50KK1j/vh4WVNu2gavK4gwrKhUlGgIZxxnDlJt882nzyU3/yHvAOqgq956ny2eTOAymXtFwRGcuRNL9R1mWvej3DvoJXALvhh6VrB6aNvK4K2ITSRpBNcxRhNb7mhMrzZeuel3fjwraU8XrF6kaLyj1go9qvjRwV5MV63CBU=
Received: from BN9PR03CA0205.namprd03.prod.outlook.com (2603:10b6:408:f9::30)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 11:42:11 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::5b) by BN9PR03CA0205.outlook.office365.com
 (2603:10b6:408:f9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:01 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:41:52 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Wang, Sung-huai" <Danny.Wang@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 52/66] drm/amd/display: Add is_odm_enabled callback to skip
 init_odm on active ODM pipes
Date: Tue, 8 Sep 2026 19:31:45 +0800
Message-ID: <20260908113338.2433445-53-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 649cf04b-2d57-43ee-d983-08df0d9e3840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oPDDpg+LslCC5PZ+a8s0mzLFDV67m4WZohlmoYJxNWvK+ijnGxzvMCEjSj3fg9l0u3Vhyzsife9y0CEGcM91jeuIEQRKHB9Lkf28MQ4rGhIevauCreMQOktfyEX2MqAJDImknSUH/0fwo2V0SmjfrFxo4UzPEE7NyvHX9s8HyFxfoxrauaHRj5NFPvZuXDmkds9WAa1uUK5t6XruUlV1rGvTP/HdufHPg5oGImrtzCBnR+49kViLQAweCXRsf8EBixVm1LJBiDKx6gNL3qFYWAFIuPv95yOTQY1YeFnt5qDE9RNb6EScRYp7ajunirIe8VKj623DZ5mdUrF8bwJRK79gkxjvv9JRmKjmIYkqyI/2WtaZdPtAIeg42ix3QViKlYLuR65LZg4NVoQ7gA/t/B9Mds81VCeQEsXFGNW3ll1YUVuxnRg/r5VScKxKJAzOgVP56K9EJ3pGEFwFQlYdumQ0kiB8uUDrjyBIFZN1Po+mmE3mfKVhOpGp98rM2LkmtflTfuXkIXtSmrIv/7jxM5Z45gDWU7Nz+Pxb/zwF7/AKCsqpp+Kk5ciPcPsbSIW6E6rJRDYKV6vOmuAJeih5k9OYSWhhY/Wp5qp693+1ypN094hnX4TsQ0GgOP3govnVvugMWLWPqpiBcbhQMpKesSVuDEtfwKNnNQv8HMrHm/CTGSY+mcJd35Lw+1OjbhX7rXB7Uo2ub111b4yhlqX3mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uZ0FvER7xf2jGsmsF9OppNeSn6wzTwguyWglevZDF/COTQNelQj1t26LTffhnyr7TjKYdMMT00c5Dysr7kNdb7bUj/OvMrz5Zo800ulQNpKQAkG+ekvYMc7AxtvEjNFmpC9EicX9ELkhfXQSycTzva3flCmDmP7L1Ys0b8XZNHZQKb72SIpgZPNDLRJ8vCGLWL1xEZ67Al0OYG3cuOSi6rtB6rZ1QiwD9vmb1xfGbOIxO+BEPNeoiXBy0b00CY5R0gDwyEhTsibLkTAEzBErJ609mlhiA5C8C5QgwgidoT78TAlhgM0NyZt1CmyuQj+xb+oFamnp5Ou/8u6mRHp/pNhosi+84B5iYpn9Nycx+Jpc1kjzY+KIY6g2HUbYYXWl41MXUOQD1mePWM9eXOx4vm852agbf3CB1Y8Irh9eso72N6KuTKpCuSrc0GjiZih4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:10.9273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649cf04b-2d57-43ee-d983-08df0d9e3840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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

From: "Wang, Sung-huai" <Danny.Wang@amd.com>

[Why]
dcn10_init_pipes unconditionally calls init_odm on all enabled TGs,
resetting ODM combine state even when it should be preserved.

[How]
Add is_odm_enabled callback to timing_generator_funcs and
guard init_odm to skip when ODM is already active.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Danny Wang <Danny.Wang@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  4 +++-
 .../gpu/drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h |  1 +
 .../gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c   |  1 +
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c |  1 +
 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c |  1 +
 7 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 270b6f2d4377..7fa329229ae0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1750,7 +1750,9 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 		if (tg->funcs->is_tg_enabled(tg)) {
 			if (tg->funcs->init_odm)
-				tg->funcs->init_odm(tg);
+				if (!tg->funcs->is_odm_enabled ||
+					!tg->funcs->is_odm_enabled(tg))
+						tg->funcs->init_odm(tg);
 		}
 
 		tg->funcs->tg_init(tg);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 2eaba65894ab..52d4d57358cd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -512,6 +512,7 @@ struct timing_generator_funcs {
 			uint32_t vtotal_change_limit);
 
 	void (*init_odm)(struct timing_generator *tg);
+	bool (*is_odm_enabled)(struct timing_generator *tg);
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
 	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 	void (*wait_odm_doublebuffer_pending_clear)(struct timing_generator *tg);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 3ace83e1b50f..ce9cd32b807a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -221,6 +221,15 @@ void optc31_set_drr(
 	}
 }
 
+bool optc3_is_odm_enabled(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t num_segments = 0;
+
+	REG_GET(OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, &num_segments);
+	return num_segments > 0;
+}
+
 void optc3_init_odm(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -503,6 +512,7 @@ static const struct timing_generator_funcs dcn31_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
+		.is_odm_enabled = optc3_is_odm_enabled,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
 		.optc_read_reg_state = optc31_read_reg_state,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 119a954fe3e5..19d90c65a22b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -274,6 +274,7 @@ bool optc31_immediate_disable_crtc(struct timing_generator *optc);
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
 void optc3_init_odm(struct timing_generator *optc);
+bool optc3_is_odm_enabled(struct timing_generator *optc);
 
 void optc31_read_otg_state(struct timing_generator *optc,
 		struct dcn_otg_state *s);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 7250478a5092..f5faa49680ef 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -247,6 +247,7 @@ static const struct timing_generator_funcs dcn314_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
+		.is_odm_enabled = optc3_is_odm_enabled,
 		.set_odm_bypass = optc314_set_odm_bypass,
 		.set_odm_combine = optc314_set_odm_combine,
 		.set_h_timing_div_manual_mode = optc314_set_h_timing_div_manual_mode,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 897f857db448..406446e5eae5 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -614,6 +614,7 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
+		.is_odm_enabled = optc3_is_odm_enabled,
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
index fd9c2b6b8b3c..1e4f2051d732 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
@@ -261,6 +261,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
+		.is_odm_enabled = optc3_is_odm_enabled,
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
-- 
2.43.0

