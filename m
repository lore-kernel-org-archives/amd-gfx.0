Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1BDC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4188010EB66;
	Tue,  8 Sep 2026 11:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cZ30svnt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC49610EB66
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Txsj+DLHaoln88e1GOn+X6z1UITZ9qkER8/TP28pmmEjr7ydNe3ie4QGOMh7s4K0bVh/82CT6SEN6XY2VxB6iTR3iI/RmaO9y45Tfa3EWiAdwlLlwbwu3L0SSaywKu9loHbcghNub6ticMonuYyK1zQMjCvJdxEwcUHM1TFDO+uLAnHKYadMFDXHJoO5/wTMNfclb8hzaorjBt/CeoLndY+hKjbLgq9OjdJeXM9q17POGpyM500iOz/KJUAESVv82HuQ+Urg104R5KU+T686yMnlIlzVq3NrW3dZhT51uLYKxomP0rd+XOO8i0+Uv+3AZ2PZ96vv/06emkCr8kdYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJtwhHoGo6XbINepOFUy+0PzTX4fa7KmopejpX1+Zhk=;
 b=ZIMGYNgz15jiV99sXcZH514ggQtFjxPAvYF0rEyPwkyfp4/bvS1TGi9HzkbwpkaClouCoQlD//OFxUjdM+wHRrY9kubDsnlVQiHPq6QGuy3pD2tW5FAUIc5kLLfdO3aXYizQb5OwwYPj/bya97EJHe6BMlVPIFC77KgW4GcgyupReuAYHmc8qrXOVI60Oo5ov6jm0AGZtuQZ9puFAj0hyuXMo0s9kGwy+fDNPCb0tTcvA3mCzBSzvhyaAfVyv2P5tKfW0ihkyZ5icke2mCFAJPPRrlU5KJOKFdvzetLr/AvhN7Tva1aGEgfShX2pZaQ+CIMIr4R5PF1RyQB3fbipsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJtwhHoGo6XbINepOFUy+0PzTX4fa7KmopejpX1+Zhk=;
 b=cZ30svnt6Ce8XOzKZ6md3GD5jyy2FD8CqbG59dg9QlpDWigMh3TrY/pS4reBN4nLUBOvZb3p9g2Y4DGjTPKARkt30bypkKTXmUwl4WltbBrURQz2IXEMqnJ8pNBNhhvf7qXnh8dN8/11/HJJtb36TnKD1HSyMwOndWtQpvh7qR4=
Received: from SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:40:14 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::b5) by SJ0PR13CA0077.outlook.office365.com
 (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:40:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:01 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:53 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 42/66] drm/amd/display: Enable power gating on dcn42b
Date: Tue, 8 Sep 2026 19:31:35 +0800
Message-ID: <20260908113338.2433445-43-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a87072b-0534-474c-1487-08df0d9df2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K8Gqdfj+ImJZpKTH1nbPIEaHLlCW0smgJ+8ammA7qaDRtY9h61Z1dgfvm9HY9qIzTzLoacMf4K05Qvqlmo5QnY6GHRlgcNxJHZF+iY8LmD8bZVanQf+fh9ISomKhtMIB2Fv2inl/9DUp/ln08B44eAsV0gAAoq/a8vZlZ/w+OUasxzdsdPkHOBiLAPDk9P8v9pXzRB6+0jZ7vHT3Edwv8m4R8uThUAskO70wUKJoEgt73047s2n1YWPgvu6nP8e6litw3cu1iBtRwSt4V3ofotlHoTWLkwbNtUrTFNK9JeYbJwzo+I1Tt0Ukv/NclZHzomGldBERKBMvQoDT91vC4/8K9+mc8Eys7SkPyFZ3MjLf9J/5h1V3P6GD57em0vWHg+xOh9HRY1Zmm4wA1d6Jy2BM5ei9WQ5vFT6ncnHWsFsg5fOOgQ9fhdmoULLR6ESSOZ2k5PBmh7wBgge5L1TexVNVhEDhnFV/cEV6rADa0VnwMADzgtkP8CghSA9ib9uSjfx3zDy292gmmOpoamsq0dqTONizMstQqfOKY7eD56lyxfNhqqR82p+9WEvFLVrvA/vzZf02tdeY9J+xqH+etT1QR/J3jsuryNEmnVmYBidlxPnBB2gfC9KEKKonIs7VDOWWsxdOy+pguAP/yg0PssCDXdgTLq4m0twiywKaTtTRXTuUyFK7wk7lWvRAgRuu9rODCPLl3DsT7tHhj07xuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j07YAI5wYdz2nlWPJx/n0jrEnNH3RxZ1B6syEh6ZVn9JnKg4qXSv1ys6iyUwOs9uhMSe2zaHUqlBynUn1TdQcFqtfaQQj80Uds/EXNOE6XEcT8z6I5LS3HJkiDxQ+gx3Odfb8KuGz3Uo216fvMGZkOc5O6xilbb/3357kNZu1lBKrQMcFDrWiKdC5OmgVrNzuYeL3JoFFPt1MRdC+zxZsbbtNYanMldijqi4VWNlo1eCBGtkdXlcJLhppqYdlTqei/5QNBtwyzxXKv40c2n03VtoNtDGHtlmb0zGxkKhqJOwmEBFkyDPewz2VnPaQe/+TLr5CU/O7/dbxas4AL1gpy6OrV5wMZyCOFO6h5gqr4HvV0OfXpubyrufxK5+Yl9gUMwckeL9nosYKDn0KeoyA7bPvEdN5zcmQgjcRBxU/TNIY27Y4aST377pWEJ2vBl6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:40:14.0804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a87072b-0534-474c-1487-08df0d9df2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

From: Gabe Teeger <gabe.teeger@amd.com>

Turn on power gating by default for dcn42b in the following domains:
DPP, HUBP, DSC.

Root clock gating is enabled for the following domains:
DPP, DSC, DPSTREAM, SYMCLK.

Now DCN42b will match the exact PG and CG policies as dcn42.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/resource/dcn42b/dcn42b_resource.c      | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 7b21badf7025..092b61b3fafc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -802,9 +802,13 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_abm_enable = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
-	.disable_dpp_power_gate = true,
-	.disable_hubp_power_gate = true,
+	.ignore_pg = false,
+	.disable_dpp_power_gate = false,
+	.disable_hubp_power_gate = false,
 	.disable_optc_power_gate = true,
+	.disable_dsc_power_gate = false,
+	.disable_dio_power_gate = true,
+	.disable_hpo_power_gate = true,
 	.pipe_split_policy = MPC_SPLIT_AVOID,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
@@ -830,14 +834,14 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}},
 	.root_clock_optimization = {
 		.bits = {
-			.dpp = false,
-			.dsc = false,/*dscclk and dsc pg*/
+			.dpp = true,
+			.dsc = true,/*dscclk and dsc pg*/
 			.hdmistream = false,
 			.hdmichar = false,
-			.dpstream = false,
-			.symclk32_se = false,
-			.symclk32_le = false,
-			.symclk_fe = false,
+			.dpstream = true,
+			.symclk32_se = true,
+			.symclk32_le = true,
+			.symclk_fe = true,
 			.physymclk = false,
 			.dpiasymclk = false,
 		}
@@ -866,7 +870,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_disp_clk_khz = 50000,
 	.static_screen_wait_frames = 2,
 	.disable_z10 = false,
-	.ignore_pg = true,
 	.disable_stutter_for_wm_program = true,
 	.min_deep_sleep_dcfclk_khz = 8000,
 	.replay_skip_crtc_disabled = true,
-- 
2.43.0

