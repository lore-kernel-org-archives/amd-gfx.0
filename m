Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48125C28B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E314910E2C7;
	Tue, 11 Mar 2025 21:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KL5rKe6m";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB8710E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0Np2mFCZ/qajk5MnqCwDmMSsX5TbIaO+9xNnmCgQaRqgHCvlqRlsQZgKRFLPxo74428SxPNJQjOnWqNlbWaeSbHdTaqcFAn8yjy+MpAifCKH4CD/S3aX/RqhWqakjJForjq7U5ing92zuBh9qYM8frgneGhnXjZ2GSKUP0w0BpK2K9KuUkVB2lX1MfT8xq3ap6FAVrAnfQ2Mkh2a7ayN8nr4XSyeowpabclIckSomgDvKmdabwX8yhnvdttBGUQAprNpXH2nKBgVn3bCXhHGGtm7Qkrl8Iz0oMj103TPo6rbIrwjGpSARqNY4bde95Nb3UFyskjWp5l8bk0EbuxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL83OxAGRefJ65L7VE16Pggar6kMoVVjFqcJrKEhap8=;
 b=ZPWYdJHRLsb1FsWtovJpeQx+6Yj0HhSrCDClWfoKI7NPxrqIKnbozZr3s/+sMsyRxvgaJJRVl5ZyqFGe8y8b0yVCdO9AMdc2mCsrW+adWEsWRjxavNlj4mIFEbrvZVki8hXtr43QRrZmM1DiLO4VusKJAUHi30T+XEXU3XMOZZ0XREePS3NQWgWkuAMKDS+sp++Z5mgtT4mcWpkBDSumWv3DgLTaNssVvNPT8cQNTchFHavNF9YvHPhjomNNYEkguVzyWc2j5S+sVrPr7Wuxd7kuiadHhMh/vLgntIrAh1FmEQ4w9GociCSyVfuZjlYdlQg31dV8Nb3rmXcjYuoVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL83OxAGRefJ65L7VE16Pggar6kMoVVjFqcJrKEhap8=;
 b=KL5rKe6mCByxKaQU+TIFW0QsRV+lDjNr+/zgL8rAmANKZf2nu1+fvKz2n/v2IvSRZBTvRZo6Uf9Yx8lAZBR9qCAfO4vVb0xnKeKbahrbC8rZSw0qMYNDFX0IojSQ5mqTMFvS5w3DDpuR6HJqNUrxhOuiPhN/yispssE8gEuC64w=
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:49:33 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::3f) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:49:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:49:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jing Zhou <Jing.Zhou@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chris Park <chris.park@amd.com>, Eric Yang
 <eric.yang@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/11] drm/amd/display: Guard against setting dispclk low for
 dcn31x
Date: Tue, 11 Mar 2025 15:42:04 -0600
Message-ID: <20250311214618.3106637-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b1aa7e-8a48-40db-11f2-08dd60e69bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1B9xCz9HDQoyBauUKZ9dsI/tqmnFfUZMYsEc6Pz3VW/R9XI9Fw+CtxQE9+uh?=
 =?us-ascii?Q?JRiNRoP4qz9BkaICo8m5qCX5tufowNWuswXv1IRsGylTw1eBwHEaJLFygDfz?=
 =?us-ascii?Q?QsLQ+u1pQi4X9SZpthpD2eA+6wbfB85aCOxTFIiezIrHbyxUm5XZ5sr030nZ?=
 =?us-ascii?Q?NDYmOE9wzpyTwjzDziIcJHRwEqhPAn/JvdmMwCuqg08zr6rAiQ/toxrLPzgQ?=
 =?us-ascii?Q?/7yM1zchtwVkCSNm+J3IUj9zO4XNxIr4KLkehAjImhGp69AnxfiNypLwND7T?=
 =?us-ascii?Q?G8lQKAm1FrsFrAcrQCilXyMN1GtXQiC+/umaG5ExLUuJngHldg1N+d3Gq3dW?=
 =?us-ascii?Q?cKjETpM1tlpFC5lt6uvq+FoDuVouH4/8/w/MFSuCJCPFLR1Y8+iBo9mkV5+p?=
 =?us-ascii?Q?fEywwebnViL99W2cpwv9B+3K3FwuYqukz+5qpliFAHZauwJ4g4Yo60R7EKgR?=
 =?us-ascii?Q?jB+RfX578NugHBG8pS48sk27mW1dTiU4dkskaw8mqnepb4AX/EFyC6bs/qTg?=
 =?us-ascii?Q?Hr0y0nK1eXFDOXVYXN0Ory42hBdfiVY41F5fFtGz49WzSi9/9iDuq9pT0egz?=
 =?us-ascii?Q?v3x9oNHMVpMyWl1eKsG6QoY32hXNOqA+V21hW38xdqFmNyFTNf+g+fY2Yv2N?=
 =?us-ascii?Q?Osdl56W85Cyjny9Tts57v/yRDRipkQxnDdEWvVuSMkdrh/sy3R1BJwvhI3Sp?=
 =?us-ascii?Q?f4zGeXuao5Ti4Qw+QtJZag9eAFOyxSXNgRUVoSlVzq9kaLI2opHiH3DpwvF+?=
 =?us-ascii?Q?nLr6JbF+TPc0x3revTSqtJYr021OS4MhhBpJKqUmzUFvUXCVa5OsZh/ovUgS?=
 =?us-ascii?Q?zJz0y/3eCf7J8VtP2kvMRTQxi/8QkvrzEtzNxJOPVpL07CDZd4gjyv2HEpK9?=
 =?us-ascii?Q?7P0I8EYKvmyXtbwltG6lQNBDG1MM6WVm3CO0hgrKc/t1pTSvpqW7DOzcJGxR?=
 =?us-ascii?Q?secsjFAg4WtRVmHmdnZyyI5RhBBJZYkBC7DWlcv2hFV9FKmuMyfHqMsUwtP6?=
 =?us-ascii?Q?px0DY/BisXnXWM8XvjT1NMlcFXSfxnInU4KhiepNcJTCMO+/fZUHnItow/Po?=
 =?us-ascii?Q?V4Eyaor1FZx1m34fBQekusxB5ZED3lh9gJP9QheXZiHtGMySQx4XM/DAjnTC?=
 =?us-ascii?Q?AhJzmAc+WmP2RSmzVRjbwj1tWl7TMOmEMmuhOjcnwan/cSJwQTJ5jG3ursV8?=
 =?us-ascii?Q?6QDwQnynWJhR97jECnJZoiyxuLcMmaUEmmK3OkVTl9nRfMwGjD4EwD3BIlmF?=
 =?us-ascii?Q?dqZFVtMpEjeYZnm0hChqpOFiLmy+PrdGjq6EjmzoO9P5/1WFxhj8G/Xo0JTe?=
 =?us-ascii?Q?e9dE/gswWhdDBcRNPgIiDCF2Bt329bY1dixCrZi9CRba/5OjofMCA7ant7wY?=
 =?us-ascii?Q?02/x8lYcx5xwzvJjcwceKVjYxrmRqqAImsbxqYHMvs86b41Wbb0SAImr9LrA?=
 =?us-ascii?Q?+3PvomsdF26DeAYT/URntRh9tHS/2ol6TLiXyoxTfPBVpGAz8vCQKuI65WR4?=
 =?us-ascii?Q?3+c4oY/QVYVDniA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:49:33.1218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b1aa7e-8a48-40db-11f2-08dd60e69bf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

From: Jing Zhou <Jing.Zhou@amd.com>

[WHY]
We should never apply a minimum dispclk value while in
prepare_bandwidth or while displays are active. This is
always an optimizaiton for when all displays are disabled.

[HOW]
Defer dispclk optimization until safe_to_lower = true
and display_count reaches 0.

Since 0 has a special value in this logic (ie. no dispclk
required) we also need adjust the logic that clamps it for
the actual request to PMFW.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Eric Yang <eric.yang@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 20 +++++++++++--------
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        | 13 +++++++++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 19a15acd1509..e4d22f74f986 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -130,7 +130,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -202,15 +202,19 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		/* No need to apply the w/a if we haven't taken over from bios yet */
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, true);
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
 
+		dcn315_disable_otg_wa(clk_mgr_base, context, true);
+
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn315_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, false);
+		dcn315_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 4b19d9cf27ce..49efea0c8fcf 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -140,7 +140,7 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -209,11 +209,18 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn316_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
-- 
2.43.0

