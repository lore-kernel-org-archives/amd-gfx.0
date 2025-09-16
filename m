Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B48CCAC59B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3C410E802;
	Tue, 16 Sep 2025 19:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kokKn1cR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD2110E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxnZq0/1UnJ+EjGbtu4CQszuBqGP0WrQsvs0Pho2xK80FnIsqh/EjqMC004yGYlLhWMVF2sjqalTI8EXHVWw3Lwg6LK7qcIfIgxKWgM0tFQtRAQz6jMaRUeGMT++r0FXzmH0sJ2Ao82XaQi9dnZwxIk+eodANP8eB71tTHPqUaBsOgtiFGrjAlPfqgRcZEhcy797uacDiy8DldyDfj8bf0abU9wsupEQFQ2PKP3hfjGXyCZ2N2r7MA4uSKBTZibDVpc1AvdsnE4evJCZY9KeEiITXwl1b0Wa2oMNugxrvC4eoK9gnqSfk6Uo6VhV6cleLJMSRr2ktw5vsrTAcx4m3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtW1hE7HH63Ly0UdVB6FLJE9sIAFdyUr74WVTudARq0=;
 b=QBjGgDcy/6V11t//mNOiwGaVyzXtY6RByt8ha/M9rOAgVV1CBAmpZzDZrSkjIPY7fvFZ/G5jFRHLBqdMl3YLnatRnucIUS3Bs/otabjO2xkK7f22b+M7tjjKocKwZzZox4vvZtGP4zkBRQxaCyW6t2sq6A6vvZSqbI5ew1WMxU8kSmoc9BqzeXOIQfREnsm5R7Gna+cK0R0GhDWbYXc+86Wj4DKXTS/32m4wyVwxv18HHw87AMmq4YD+QoB6bGnTTGc4ZuUxjQBhmKIrXgBAHqWvAHvywmw0VBfnEg2Gpsqf3lKuEW/G3D3yf0/zDtUe0to4F2nNnmAx+JwgCUVJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtW1hE7HH63Ly0UdVB6FLJE9sIAFdyUr74WVTudARq0=;
 b=kokKn1cRJeFN9xdOLKUqrkhw2j0rEFn+s69qzzlMqttn+Cba8G3hiBvopmqO6aEGb5KhvcE6uWtUGDbLjd+7Wt8jYZte50Wo2hc1DOQTvdsmUxZg29ocFr69Wp58rpbUAhEUzrlKSkMEGLUcB1OT30toqNAzQRoTJHP3chNp24U=
Received: from DSZP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::8) by
 IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 19:12:27 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::c9) by DSZP220CA0007.outlook.office365.com
 (2603:10b6:5:280::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:16 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:16 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>
Subject: [PATCH 16/20] drm/amd/display: Correct sw cache timing to ensure
 dispclk ramping
Date: Tue, 16 Sep 2025 15:09:36 -0400
Message-ID: <20250916191142.3504643-17-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc8fe1c-646b-4153-946c-08ddf554f9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?raVsRNbjDqfMZ+kmrz6g1XCMBWaJ/852Yaw9pNfmAQrdRc1dCmc8NadY2jfK?=
 =?us-ascii?Q?B36TdtZqmPipZzHsf1P91g/bW2d5M8zwMiYdkoFSOlxWBLnXmSRzfD/LuY2Y?=
 =?us-ascii?Q?Is19/0+mMaAHrN33QN86/VT9M6TSuqdUqGkCa3BSdc/9XdnXVk7XhFLYFzK6?=
 =?us-ascii?Q?OAnHBOHnPA0jIKDZ/TR0Xm199Qt10+1GXxV+/do3SInvx+7OYQsRbaxa7jji?=
 =?us-ascii?Q?W7P7kOyRDFGr0hNQo20qOHF0dnUhdoBi3hjAGi+qEwoJxro81FGDFnV3YcLY?=
 =?us-ascii?Q?oqpX5tnA/x5/LrdtFWnjdycwQRGTnmvhn6pENZS1FvgsaApmC9J4EkT6jgyH?=
 =?us-ascii?Q?to/eoP7BSPFdRz5LeT6i6Hj/kCFiHz1REqRVgfEuBcvX3tiUMCutG3WfKdF5?=
 =?us-ascii?Q?0hIj1zeud8LgH7gURWwUqojQmh6uoaCX4L1YA6k4uc+bpwIEQ1bArK/cdz1d?=
 =?us-ascii?Q?5fiqztWbkIRUpDmVoClSbr6QLn39eHH2kLz3A1OawgxOMk4tS8BOp/L/eIyp?=
 =?us-ascii?Q?8w2po+urZb7MBZzL63qu7scipkVP2O8o/djhmiC3MQFDpAAPZ3FO54IW8Gvo?=
 =?us-ascii?Q?mbFNTdZiQWo5fVily6YabFW6R4QUlJauyn2xfDz9J2DUS/NxW89jO1dmzUC8?=
 =?us-ascii?Q?YhTdSVP8XuDMg162yaZnSdZCtboPR3JCPE8NEMq5knEwnF6qE4nWhRDzkk/m?=
 =?us-ascii?Q?/AQzcPJUHZJN1TzSud3B91hCRGWmXoaClu/pV8+7G6K4G9BJQ3e2pCsl+QYp?=
 =?us-ascii?Q?maaRPtyen3srXn5UAaGYVt9+Agej5tESk225DbZnHMzMdVvC7cC/PTzJ8V/z?=
 =?us-ascii?Q?1m64OUK1KUwR3pfiN8zTiHvO0Q1I5le2Jdm5ufSBseXKcuwFbSePeQrWThFU?=
 =?us-ascii?Q?Paaqwx3DuEPzdRQGt5wA3MymoAGpahkpuCZooy7bJoZ2IlU/cVH6uN91xVh8?=
 =?us-ascii?Q?S0Wmgx/IICakpnwt+aBxKIdMpq1kimN0/8Edaqcc+2k/6/+X4vcTIUWPOJCt?=
 =?us-ascii?Q?20qGkdXm03n4kiRCsrESst2wMIw2NBSw81v7Dq7/qxXckFfqUVkA20NKn+w0?=
 =?us-ascii?Q?CcAU5kuL13wF1cD44OeDz8hHSnZzb/rd3m6dB6MUIDdOUAa2c6fjOpgmRX6q?=
 =?us-ascii?Q?HKL+KZcR+LWwjUBmt+zCcRAAig6kpI3btQEhy7MNw/TMpg6qRmYThCivxBpD?=
 =?us-ascii?Q?hBo8NG/nME3MxuUjsD4Z/vjmz3OAVSNeHoc8zcPDRZsEBvui9xPenU7xwwsl?=
 =?us-ascii?Q?rjcUAGmJD6ya/IakNurdhxr4REJDoqA7xrnByxq95a7/s4A6cd6hMz2E1+3v?=
 =?us-ascii?Q?v4C5Vx4Tm2/t+0ieoobvg45fDB0HJ6eQ/DiSZWH4fzH0Gd1uIq0RPCH/hTy7?=
 =?us-ascii?Q?6oguP9N1ZjO+UzrFlFM8/ItAO2p/L5Rt2sQSo2KZwvyRS34onxrXJUX9ukpR?=
 =?us-ascii?Q?Rnsf5T7tCp2+gFEl5Adch8ZxGX+cJF4N2N3zAki+0/Q1gr694gK3JUcM4glr?=
 =?us-ascii?Q?LtsvXfgkxGyb/YVN3rgC3gjtZmc8R1TDmtko?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:27.5367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc8fe1c-646b-4153-946c-08ddf554f9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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
Current driver will cache the dispclk right after send cmd to pmfw,
but actual clock not reached yet.

Change to only cache the dispclk setting after HW reached to the real clock.
Also give some range as it might be in bypass clock setting.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 86edf11b8c5a..6fc8a7491684 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -387,6 +387,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
 	int all_active_disps = 0;
+	int actual_dppclk = 0;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -472,14 +473,13 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
-		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
 		int requested_dispclk_khz = new_clocks->dispclk_khz;
-
+		int actual_dispclk;
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		/* Clamp the requested clock to PMFW based on their limit. */
@@ -487,7 +487,11 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
 
 		dcn35_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
-		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
+		actual_dispclk = REG_READ(CLK1_CLK0_CURRENT_CNT);
+
+		/*pmfw might set bypass clock which is higher than hardmin*/
+		if (actual_dispclk >= new_clocks->dispclk_khz)
+			clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
@@ -505,13 +509,20 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dpp_clock_lowered) {
 		// increase per DPP DTO before lowering global dppclk
 		dcn35_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-		dcn35_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+		dcn35_smu_set_dppclk(clk_mgr, new_clocks->dppclk_khz);
 	} else {
 		// increase global DPPCLK before lowering per DPP DTO
 		if (update_dppclk || update_dispclk)
-			dcn35_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+			dcn35_smu_set_dppclk(clk_mgr, new_clocks->dppclk_khz);
 		dcn35_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
+	if (update_dppclk) {
+		actual_dppclk = REG_READ(CLK1_CLK1_CURRENT_CNT);
+
+		/*pmfw might set bypass clock which is higher than hardmin*/
+		if (actual_dppclk >= new_clocks->dppclk_khz)
+			clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
+	}
 
 	// notify PMFW of bandwidth per DPIA tunnel
 	if (dc->debug.notify_dpia_hr_bw)
@@ -551,7 +562,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 	 * since fractional part is only 16 bit in register definition but is 32 bit
 	 * in our fix point definiton, need to shift left by 16 to obtain correct value
 	 */
-	pll_req.value |= fbmult_frac_val << 16;
+	pll_req.value |= (long long) fbmult_frac_val << 16;
 
 	/* multiply by REFCLK period */
 	pll_req = dc_fixpt_mul_int(pll_req, clk_mgr->dfs_ref_freq_khz);
@@ -778,7 +789,8 @@ static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
 
 			/* Modify previous watermark range to cover up to max */
-			table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
+			if (num_valid_sets > 0)
+				table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
 		}
 		num_valid_sets++;
 	}
@@ -939,8 +951,8 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	       is_valid_clock_value(min_dram_speed_mts));
 
 	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
-	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
-	    clock_table->NumDispClkLevelsEnabled <= NUM_DPPCLK_DPM_LEVELS) {
+	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS) {
+		/*numDispclk is the same as numDPPclk*/
 		max_dispclk = find_max_clk_value(clock_table->DispClocks,
 			clock_table->NumDispClkLevelsEnabled);
 		max_dppclk = find_max_clk_value(clock_table->DppClocks,
-- 
2.43.0

