Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E46CC9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A5410F732;
	Thu, 24 Sep 2026 18:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Je+0l6eB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFB810F730
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvrX9X28C4+DpHL7DnmXYuEN84G7HE3V+xW2n7jjEYeeB1Ao78fIJWvH0TwrtMFzh95N6Hjiq9zTODYdXDQN2cpqnUi0ZWsA1X7o3L+tttc4w8JG9SAx1u0mMTWbpzR3TBT/5uaUg1AOYPK+9/+6cUbvb6eM3JkqGVDbHtusdeNwD/3LmbDKO8E8QIwB+Iq86Pq6ayLlhwL4L2yvkY7QEGGk02O49GtkI5ISuJvrsRcZF2umWWtr4qKXDjUGR0kOcAzsywtIDFEOk/NOvt+VbDJZ7PN3HkZbwl9sSMba68VHuCfXxXRkNq868ybL+obUmXGTmYmCxj1hyx0F6SxwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cr8iPosGw31FOZqcV4uCFUCy9XvYahJRLSjYRabNxg=;
 b=mhMRNjuPUGvWBdK2DAngYF2Z42p/AkiEHqrqqJmD2mAeOkyu95xJqo70C2zVYQeWcQ1ulAttIfowSz0kvWBt7I4mD+M5HpD0H9h1UxC0OHRHEfCmjMe8WZ0Wy8vS0cAaE7AWaNEN/mAJP+Pf3dVolFiAsaWCOrwlsUBZ4KvHbpFI1jGKJeENHVmGrhZU5zYItKXJBUunqbHJ8Q44WTm/QqG5xeCLVR4Q2ddTtAeB4x1wSZBXMIaM9DNi+u7wGDF9W1yEu/x1D0f2MXruGFDpoIJYLOZ/zU4EBQOR6Kl2y5Caq4YZVScCuKymlAPEFPgPxJA1xTvQ7CQQmfvTD15QAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cr8iPosGw31FOZqcV4uCFUCy9XvYahJRLSjYRabNxg=;
 b=Je+0l6eBbm/uKpwbV332OrGs+w61mb38vgvrpUycIbAiphw7TXH+tmArp5YL+mT5EjRC4QO1n6Iw/gXWFVQBr4XvzEY3vKdxQkNehpiriMOEGBlIf0DCnl77cyh99CzQvNRNGceNOwAPAQm6UeA1bdQBj1eWbhnRBxkH358WEDo=
Received: from PH8P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::19)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:41 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::90) by PH8P221CA0018.outlook.office365.com
 (2603:10b6:510:2d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:40 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:21 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, Leo Chen <leo.chen@amd.com>
Subject: [PATCH 28/34] drm/amd/display: Fix zero dlg_reg write to
 program_ext_vblank
Date: Thu, 24 Sep 2026 14:45:41 -0400
Message-ID: <20260924184824.596894-29-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b4d320-68db-4356-46a0-08df1a6c2be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /3da2Fo7dJwTM+BuimNlJq46sK42IzC0ynMbPol69fPmuv/TpRyG5AClcQR1kFS7Ww71z4Ym65JNlrgGc12iUo2HD0mR02CQ4FTQC+hETmb56U+7PWzx3oLF05TtFxf6wz+laRMD3NYKOgB9/U9GL3btdG4J7cs2v+Vcze8ymrJECzYXzPd8fznHsqvBHtQMLKupuvP8YYyILuqdioo2WXQ7cNmDq4Avh0CEWWaVYkFc5wEmMVrgcXcj8QIRkpoLXw7m5DzMlfBSeADDVcBooD/ssWIv3P2FNyilUXkvgmr9oqLuZJSLAJjSKQ771LpwJUSGCiUCS32SHFSeXtY6KZ0G9GIkjJeth8dkJxZJW3tP/Grc1ETI8eT7O0rykl3EcloOQkApM0j7vVU9THVZKU2CVKDtPwZelqLbdvQz2m34mF3ogp6eK/77s1+jrA6lSASixHVGA0hEFvKFfbVu6X/QgQw1vB5pdbxqXT+u/LHk7KPY3F7wjsNRgSRLC2YUk6VVwdbwUVfkGzF0g+vPTrQjPNVCk+PbP1GcODcW96yHbWVvhICRZqHAzF5ooxDhtWoatXLn695rIqo169CWNHwPE734pw/cUXg4el4FDLdG8a/X2HSMTKnwRNea9kfy+T1cqIPLjX9IQRykRrE+wvlEejVoXuN1wGVTo5canWC0cDzNDPD2lrXU9leKnP2mYWEQiv4Nu1Cky8U1gNrWRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PM5WbRi9Io2JtCCeSvIeCwzgrL4BHVhtXO7RV7YTpJaOdSy2yJ7bv+yGPAhYTXjntf5Y6yktyLaMGNvhrmKNR+JsDEBuvSpTgjlmFPUDrIF4xbg6606kczEvqmHUtMy9xQTgeFGCl+tfy9NIycMNdEBxSRcsyLtD9q3JMldQ8X2xUEwH4wpujZ2zMrEhfUYNQq8grbmWu8e2fp381LE3WNgMLCv5DP/U9ZklDwET77RJctmSIVWPOtVgHYjq1y1BqYqI6iP+QW/hPbpPbczFlHIWkrigqABRBw27zDg9AmVhXI07XxQ0clwgX3V+SBCmRl8k/pAzZJHZcfa8spDAWMzdLzNycm5vigHGMUs1jTjQCXY6573MHif72noCh9wf1A2vJbKFzNhE0IX2Y2YoQ5rfowA2tPyE6TZG5jtAFzWdNZzhVKvrk/z5trRoUPyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:40.4395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b4d320-68db-4356-46a0-08df1a6c2be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
fix some non initialized reg_offset
allow z8_only to program_ext_vblank

[CLEANED]
for dml2.1, dlg_reg moved inside hubp_reg
add current_compbuf_size check ensure HW state reached.

Partial application: DCN42 register-list additions only.
References: commit d5f3d9c1b8f6
("drm/amd/display: Add DCN42B code to DC")
References: commit 002f32db0d42
("drm/amd/display: Fix dcn401_optimize_bandwidth")
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Reviewed-by: Leo Chen <leo.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
index 926ddc156a2b..f74d5690c89d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
@@ -114,7 +114,12 @@
 	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D),\
 	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D),\
-	SR(DCHUBBUB_ARB_QOS_FORCE)
+	SR(DCHUBBUB_ARB_QOS_FORCE),\
+	SR(DCHUBBUB_TEST_DEBUG_INDEX),\
+	SR(DCHUBBUB_TEST_DEBUG_DATA),\
+	SR(DCHUBBUB_CTRL_STATUS),\
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL1),\
+	SR(DCHUBBUB_TIMEOUT_DETECTION_CTRL2)\
 
 #define HUBBUB_MASK_SH_LIST_DCN4_2(mask_sh)\
 	HUBBUB_MASK_SH_LIST_DCN32(mask_sh), \
-- 
2.53.0

