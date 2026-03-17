Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D33DFB5EA9
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 03:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A944F10E33C;
	Tue, 17 Mar 2026 03:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AOgmixn1";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08AF10E33C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaqDJ1PSKgbOCnXVD8PghMb+5Yj0PcNk1suudtkau+xyG6SSoY0xL1IL39Gx93y09hBEQLP2lbX9wt+Jme+ks0VM7nw0j3qQhfjE65fDAiVt4xDjyQgvFdEEJy2Aks7Jf3neWBe7AtGuuXoWMAaQeDn5Y1+zj5v2TcPd6K79VhqQfBam8WVi8UgLYYsn0DTynMOtqM5gvsfuDaEAtsxAcdtQZTG3WN/yyr1ntkGwxhSFcSwyA0gb4MDz9dxMxFf0A+NrWK5jdl+kF5BVJ4AKL6zWUkv8FMjxII7ZC/9H27SPR+WSJX3sS9q8JuXh3Eq/zYWvlcbYsuTZpG9xWbiPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGIlapavse3PJxrl/f5/DIAU57uKM7UAQMLeKYCHWuY=;
 b=KFJwgdvIwMXnayRcZbkYGBFye4Foroiy3qFWlrTfr116UxePwJ2c8eJILazwlxKyvDj4iPYvjYkXn5RS2WLtzHWyfySUTWYyHv2+12/be06pcOahPjtsoFFrf62Br7oNGoisuxnYpWMOPujm2bD5RtDTaIE4b2nzqpbc1KeS+5W+zRMTFZMHdvTwDHjscUPJzJbLp1akZH427tb611lEJfB74rk0xMCq1ZaaHmmoqyIoQuXkuhoH4ZADlSUKMDjs+y781c+WK7FaxoJdjzcvTK1/Rg97ol2kk+d6vYqTm2tftNwYXznO1XAPlkp2RZ2t3tpUrqeOuuEYISchAhX8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGIlapavse3PJxrl/f5/DIAU57uKM7UAQMLeKYCHWuY=;
 b=AOgmixn1TLM3M5n9hX+FYKSsSQ8ImzLrA0B6r84WWjhwgaY9wkAY3KMOncE1llNxwCNebcBy7o2kyjbIxtFXk+o3WujASVIKf5arTF9igdUsVoGV4czT9fj2pjOg7V36k+0fXRRmOIXKc9hWUGF8XZQwpp7phlK90v2rmczvqxo=
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 03:08:58 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::f1) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 03:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 03:08:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Mar 2026 22:08:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Jerry Zuo
 <jerry.zuo@amd.com>, Sun peng Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer assumptions in
 dcn42_init_hw()
Date: Tue, 17 Mar 2026 08:38:38 +0530
Message-ID: <20260317030838.1943783-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: c68ada72-c6a9-4830-8a45-08de83d28803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7pQrRhdMusuSw4oao5ED1UCRUI1NYZzFpsWTrClRWEjkIg9IaKN77cX1GcQoJ2B62ushEbFFxrWAi7yxXHN4pXu/XTQuYn+wWZQgKYzLeT/udEMRMifUorTe/SZM8xMrDgCYFySq1aGwboDaUwRzMm4GavnWJrfnQVEbUupcf1fbXUQbznMKoDY5oay6ziGEu8qLVMLHl0ULX77MMxGu6k5XFOFzgQ/wVI5w63SnQbSN+4Gd9LAmBtyIdAjuorTp+nFkNuwKCSMCq3/JuHZvXU85OySwUa/pBDwtY26iEO//vfy2GFvKC1gU02dCOAVWBYQ27JIfrxzpzdYQdKsT78zrVDwult/M9oJPdg+ID6M80OQGefJTSya4AKzMvtHDfms81fgDuAwECbnVOwotmCZkHEtt68ygSUQa/AcqyL14p5MAP5ID/eb9YtHs3hvOo4pZxrZ+aEJCD6mvgUR5EPbrcSs3MxONUaw6CLceV7gFLmyQuSuqyhLqtgAccjyBz8EgzaD73izypr9kI1qoD+gAGIGBncoQlKm6mltv6obzAfw6DtNmKwjqw0Wo7hv0OROiXC/cvtXr7deS0zFGDCsM7BQwSOTQeUnrRTYLPQJyCKmL5M/vW+UfRbTO6vd/JAPEi67K5G6b9smUYK/WkUN4l/FFtePi+2mRAonTfkG8dvY/IGyIzyM8Q6sOt1Lp9FxPScTEsypC+mT7L7x0sVUBl3KYPluCLzfTNkmmRn/LeQbwAOpNkPwxxLq932ROfqcq6sFj9a9A4KqGAZVM9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /QipZYoTNA69pmcofgtxn0WSOo6HjRsoXp7wgPcn/TbPRcY0v2HXOwb2XZZ9gaoE49rzFigKwXcgSp1QR90iVGz9AI1oCe57zfP641EG5Qp+Tytqe1DeWDRGglhBwfEmUfZwfFsyM8zLQKTBcNep4VWqrKq8wJSUHLaZh4Gb+OXULWHDl4Yy9Voj76G/9DlI+6f9BxEkKd8qs1f2mXdmdLY3kGqRYHEBiq58QWOwqYUAltwIXO4xy16MS8+InlmBk50NE7IEhOYdcCDRJARmep/YHJvusiS91Lmg4Q2DVLO/CZjbNIoJU4ofra4QBrh78/qyI0SW7b5WQKzTS39NPvVlwyKzDLpR4TnCZxsbtyTCB3+huuSHGp/bd6q89I7bwtRs+d4ELnc9KdJlrmFMB0byUqmz8F403iu1J9CLVcg/bdpskr9rgAEW7vOrolJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:08:58.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68ada72-c6a9-4830-8a45-08de83d28803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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

dcn42_init_hw() calls update_bw_bounding_box() when FAMS2 is disabled or
when the dchub reference clock changes. However the existing condition
mixes the callback pointer check with only one side of the || expression:

  ((!fams2_enable && update_bw_bounding_box) || freq_changed)

This allows the block to be entered through the freq_changed path even
when update_bw_bounding_box() is NULL. The function is then called
unconditionally inside the block, which can lead to a NULL pointer
dereference.

Additionally, the code dereferences dc->clk_mgr->bw_params without
verifying that dc->clk_mgr and bw_params are valid.

Restructure the condition so that the update trigger remains the same
(FAMS2 disabled or dchub ref clock changed), but guard the call with
explicit checks for:

  - update_bw_bounding_box callback
  - dc->clk_mgr
  - dc->clk_mgr->bw_params

Also introduce a helper boolean (dchub_ref_freq_changed) to improve
readability of the clock-change condition.

This fixes Smatch warnings about inconsistent NULL assumptions in
dcn42_init_hw().

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:264 dcn42_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 253)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn42/dcn42_hwseq.c:278 dcn42_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_bounding_box' could be null (see line 274)

Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Sun peng Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 8e12dc1297c4..e307cc6363dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -69,6 +69,7 @@ void dcn42_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
+	bool dchub_ref_freq_changed;
 	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
@@ -260,8 +261,12 @@ void dcn42_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 
-	if (dc->res_pool->hubbub->funcs->set_request_limit && dc->config.sdpif_request_limit_words_per_umc > 0)
-		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub, dc->clk_mgr->bw_params->num_channels, dc->config.sdpif_request_limit_words_per_umc);
+	if (dc->res_pool->hubbub->funcs->set_request_limit &&
+	    dc->clk_mgr && dc->clk_mgr->bw_params &&
+	    dc->config.sdpif_request_limit_words_per_umc > 0)
+		dc->res_pool->hubbub->funcs->set_request_limit(dc->res_pool->hubbub,
+							       dc->clk_mgr->bw_params->num_channels,
+							       dc->config.sdpif_request_limit_words_per_umc);
 
 	// Get DMCUB capabilities
 	if (dc->ctx->dmub_srv) {
@@ -269,13 +274,18 @@ void dcn42_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+
+		/* sw and fw FAMS versions must match for support */
 		dc->debug.fams2_config.bits.enable &=
-				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
-		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
-			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
+			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
+		dchub_ref_freq_changed =
+			res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq;
+
+		if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
+		    dc->res_pool->funcs->update_bw_bounding_box &&
+		    dc->clk_mgr && dc->clk_mgr->bw_params) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
-			if (dc->clk_mgr)
-				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		}
 	}
 	if (dc->res_pool->pg_cntl) {
-- 
2.34.1

