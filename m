Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214FFC282D3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C242C10E6F0;
	Wed,  5 Mar 2025 05:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bcmp40Jg";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FAEF10E6F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIey4qItzIWt028kRwCFRezzjkebuO0Re3N4gdJge9TvLHc1PpYXCN5DONCbPw8mTaTfXKxsFh1x1BZgN/rquKFNn+9UwQKvvEvlOHuXyvOXP1i62ucsZXqJx4uP4zf8Hy2mMNe+OW4Xdk2trKzfc1sAT7wW6AHlsfLmLwlGz0Q8AUfsOn2MUrFkLfgTONGNS4Vt/CGK7P06NEE3JYiLgpYqulouyn7GfZX55gjDTQtrWO5NMfHWkOX7GXwXhPeasRAppEkdvqIHea67ulV49S76Bxr1anAHpFvXaxXmhGQwVyAHrj3/iZkrVYi2uTrSXxSPvZFkSBx0OoHbqN+7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+QOQUwFKhLqEAwNDDQ0n+ZzcJ1xb9KI4L2XC9gaeQA=;
 b=KRP2I+VBKbaGhW1mRb895ET86zdfofNVpEgsp+l6whnzRqDBlEBQvIbzBnrQY/edT+Kq/ORRZr0hgV1FbdjhFfiXJJsdBmgcQcuFDrbPHxPIeKoqW58mumcUhTUQRngfpIGtKEcQQCN7phhqhBwngl6AFiCX5aPBDUE2YO9W1aVYbpm+G1iDhNpspf1cJqJqS/nNDsWUApTya5zRMSjs7Zu7zk70/MYl/kqacmh0DzF2fqwk+nb7SzswMgn4L5vy7TsX0CIT3+ANFdrVdRPUudXSGbImvWa14W6slm4K19zC9hCZkthl6E875ed3vDXME193WrLZ8dL98h9s09I4tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+QOQUwFKhLqEAwNDDQ0n+ZzcJ1xb9KI4L2XC9gaeQA=;
 b=bcmp40JgA0SSk6EB1Ymte0CuHfIHLBfM5MCehNwcPmFLRRuPI3ZRMwW2D1LlBQPC+Z3rKQ3ipg8J76XtCivNvDrAPGn59ZnItoMygJW9bXS+2wBlMLxJtZr9mSzXIhPCin+6O06EXitl43u3+Hh3hKH0tAjQicNp70n07s6UVMc=
Received: from MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:50 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::f) by MN2PR22CA0012.outlook.office365.com
 (2603:10b6:208:238::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:22 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:17:18 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>
Subject: [PATCH 21/22] drm/amd/display: remove minimum Dispclk and apply oem
 panel timing.
Date: Wed, 5 Mar 2025 13:14:01 +0800
Message-ID: <20250305051402.1550046-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 9514fa73-5bda-4aef-d384-08dd5ba512db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CphLB6kcxrmBYqqvxoqmgHeyCwwfKDZdguwXGmBL92WNTjcGucg+b5eg2pN4?=
 =?us-ascii?Q?znNtP4EXd04BcJkzB6G2ERT6l9Snv9vxpS6Ab9aN383iUWoSg2jyD/2FbP93?=
 =?us-ascii?Q?R98gBAwEJ5klNpMOuWWyOe2V9BVX1zap9ilYsWOqbZxxTxJjjy4eWFhbXqEY?=
 =?us-ascii?Q?aMhW3CHFbvtzZG8Q0z6dLAgmdv6VFlc7rd1qDYITHnRaEYZVTwiLEJ5PRCoi?=
 =?us-ascii?Q?c3whCbuIpf7lgKWFE62/wrCB5a4LOqkE/LMU4q3AUtvfvheeKS7JPb06FEEe?=
 =?us-ascii?Q?63FsbNHRLsdGrfcmb1edD8mc4mU3WbmJTKS2rEsi7NOhGtps6WDnFFJnP5RK?=
 =?us-ascii?Q?yB3E90X8Jh/YZ7tIg09jWvDmHrpc5QOIBSrFrehhPa2OoS3fVuavO0GWkFv3?=
 =?us-ascii?Q?DsOWEYlO3kVxGAdgM+PZ/J8U+3735oUzecsK37tVoi9N8qA5d8tn/exnyWrN?=
 =?us-ascii?Q?XgEcuWPTzW7wBnMvqBRFiC4Ko4ckvh/GsNVbeybljr2Lak9Ttz0qbWXxGI/j?=
 =?us-ascii?Q?7xBiGzsTe18cGWSCfZdrQDNn5remE1Z74exUsiZK/Duxa3+XcST3GJaOPYnL?=
 =?us-ascii?Q?XDDLVww8DqenR0bkxH6e6yn+E2w66juD2dfHLSKHqj//mGnw5Duo162T6liH?=
 =?us-ascii?Q?cjF8He4mJ6LvOkaBCKO3PhMYv9hS7UhZxA9FBxOp2i/irY9YztVS7qy+ZSaB?=
 =?us-ascii?Q?QXPsdU2P/BJW2ztDyAB2lOIzeQakinE2ZjQyRdnvgp3sTvqJSTAAQzMwIsUd?=
 =?us-ascii?Q?OHAM9Wo2ip21qILTGoZmWyPSoJf25Ve2ePjaJ5kWOD/enzYow9HrvCprqdNs?=
 =?us-ascii?Q?rdOepfkl4xhVOIgJzzoE6+nevWlcgD1Y7+PuZvcPpr5sw/Ty3aTZ/i9sp5dD?=
 =?us-ascii?Q?vgLoKjWEMjrbyLf82KD3dhVl/8ccVBr3fFAogN1ybZfP+vvde4RfMYfsdvRP?=
 =?us-ascii?Q?Ac9yg9Wdu0QzFCjIiLauSgfHdoevTLNB+mVii9izCtV8r5jXgCcVor4Q7cYq?=
 =?us-ascii?Q?TNQcYD9ZQxTSHFD8m/IcKEv5InZ+Dk2EduwaWwzNpDQY3Fmk2kFqOTK6DbYe?=
 =?us-ascii?Q?c3euh1mbkFg+/zopJGY0XXGqTx9mN+CGnDTy7pu+obvG9ej8hT79+r7wjfnR?=
 =?us-ascii?Q?q3mnDfzzRi420R7cZ3xUVUny8qya0115bNtbQWuBv2wBLZ6c2HrbznuXS2bD?=
 =?us-ascii?Q?CBjdOQWGB5vYZsOKq9+ahWnjqRaAe1t3qod5PiWXTpoqNo1Ev3RruLJoKjhw?=
 =?us-ascii?Q?CcKEZ88DR7bdza9AwU2WBYC2O0K6+rJci/Wfy8QdnuJFTK40ffXAOQv6dJs+?=
 =?us-ascii?Q?caxVK49Ix4w9Nj1gw0oQY8jR5gKolYp+PkkrAdYfhLhQa4lrhO6zpwixrnfX?=
 =?us-ascii?Q?YwTHa8czt30R4fjd337pm/XEFmUpLgFoF5AbzGr60m8DTuRDA1EZ923CJ7ls?=
 =?us-ascii?Q?pE4WtvVGRrRuwcQFRdjH9ThEhOWTrBKDoycXHFOhi7iPsVlyj5icuac8ERJ6?=
 =?us-ascii?Q?Pn75p+Fges/LOJ4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:50.0137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9514fa73-5bda-4aef-d384-08dd5ba512db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

[why & how]
1. apply oem panel timing (not only on OLED)
2. remove MIN_DPP_DISP_CLK request in driver.

This fix will apply for dcn31x but not
sync with DML's output.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c | 2 --
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c      | 3 ++-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index a0fb4481d2f1..19a15acd1509 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -194,8 +194,6 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	if (new_clocks->dppclk_khz < MIN_DPP_DISP_CLK)
 		new_clocks->dppclk_khz = MIN_DPP_DISP_CLK;
-	if (new_clocks->dispclk_khz < MIN_DPP_DISP_CLK)
-		new_clocks->dispclk_khz = MIN_DPP_DISP_CLK;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index c3e50c3aaa60..4b19d9cf27ce 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -201,8 +201,6 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
 	if (new_clocks->dppclk_khz < 100000)
 		new_clocks->dppclk_khz = 100000;
-	if (new_clocks->dispclk_khz < 100000)
-		new_clocks->dispclk_khz = 100000;
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index dbc6e533dcac..5656d10368ad 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1066,7 +1066,8 @@ void dce110_edp_backlight_control(
 			DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
 	}
 
-	if (!enable && link->dpcd_sink_ext_caps.bits.oled) {
+	if (!enable) {
+		/*follow oem panel config's requirement*/
 		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
 		msleep(pre_T11_delay);
 	}
-- 
2.34.1

