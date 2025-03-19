Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B4C36002
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590E910E56E;
	Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="unlGvGjy";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369EB10E352
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iibtuZrLHiFiR1WqZO40uEnFJm4+gl8Pfp+WIiwF6FoBytHjKnVAajqyzsMZWk0o+MmgL36DlgZ7PgD6SfQr1y/EpzwCUSjoEn3Lkdzf7nDCd8MSKxMDcSfuMrplEMQjacd4GFg4ownrl2FgRLG3wlPsT/J6rk2ttjE0UULfH3NzCEKsZIuQpv1/BfeceQhlD29os4RdbO0+HmA9U9jxJBVGa4XF1xmt2CMFgiHob3LdfED+/o6n4HKxo926NkQQiR8Vl7xhxjRIjmO4QZs7FFjlqZ/wM+m4VtINpLHjjkfJZB0ofc3h1MVk/Oncge4GD80ZusoK/NHJ0E8nKRp8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jQoy6WcSn1amWUCyHcn2YoUEUdAuHyUp5PZD/MRhBA=;
 b=r8lGu3/fb/1Ug6UOqsT9NwiPi2UQs5qMA+YzRJEprm74ePQmwDvcBMO633o+NZg0uM2B/4DNcTP2z5AznXfjODtTcItIcCkIvUxnNSGpZBRw9abSJZ+48sP1TPE8H/Hct/qGTEmzOZ+g1W0Tdm1LdjqoXlPnFizKyMqnHCY9riHTMJXowJSVCYTUmSC0WL64XRzVnjNAlS61957JJJaDHYhNvlClnvcCNXgvdSBMuc0OnAlIK8cWIgUqY4+4Ik6UauZcZbFUv4j3M8yvARRs7Z4fD67O70KxmwJ3MJ0RabKjmQReYFs+WM2uk3r1aTo7irIohlewqSUSpW46Ml6gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jQoy6WcSn1amWUCyHcn2YoUEUdAuHyUp5PZD/MRhBA=;
 b=unlGvGjy4srQo6dugRwM28ot9CuKFEQKRzQFpdkVoyvq3oPFGJJX0SxuuPtG1/+5tQkwU36W+3CXzzhX7fC9V1XoEVK+TMPcltG/zjFasmu8yyg0uTMx3mc3DOiBf3zlPSY+iMLM+c3iL7QiaXlwCUdLqibyQ435c7ORN6lUIM0=
Received: from BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:23 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::6e) by BYAPR21CA0005.outlook.office365.com
 (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.8 via Frontend Transport; Wed,
 19 Mar 2025 17:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:21 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:20 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yi-Ling Chen <yi-lchen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Apply the adjusted DP ref clock for DP
 devices
Date: Wed, 19 Mar 2025 13:55:08 -0400
Message-ID: <20250319175718.2578234-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 87caa29f-5918-46ce-7bd8-08dd670f7ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dOUgrJxEi0ufw6zqyfHypop8qD8ILNb6d+sqCYignr/IuMBJ5V5lOoCjCZNF?=
 =?us-ascii?Q?DQx/PpSxN5i5HgEAT9JQmmJrtkffIMWdVMgOM48AIQ+ORuuejzzSD6XyEGg0?=
 =?us-ascii?Q?H2utW82zaf0JIddvRonQA+xkyQpB39dqJD3xmM4u+XY2tBHxRkIzT3+XRzXX?=
 =?us-ascii?Q?DT5EaY47ayogrew8iTUKhhw6U6kEfVQQ+9ULBqa6SU13NHH7d3nWeuvvWYM2?=
 =?us-ascii?Q?PZOnbrt8Db/w8iyKdCutCauMIpWRINhFdTnQmY7YeDyt5Lg+vm4W6jtZHk4S?=
 =?us-ascii?Q?1BQXPwi9bDlfRLAcMhY6sj1e6JVdsWGLeNoAWIPTWD1+Y0xYuASv0Io3eFKH?=
 =?us-ascii?Q?fJm1POJPmRTZ8pbV/1tON+9cjZowP5dVpJud5uoF1KtD2cGrmaZNnFA2k0an?=
 =?us-ascii?Q?Qvnhh2ZDrCEED1a/a4AlfOcni/tyfPcisjK/DlVaAmmAF8IsiRgIWQu9gbKQ?=
 =?us-ascii?Q?vP7vfVbPsvUT11z+Il5LsYXflanQ7lBqaqt5UH4Fn2b0Mwu7tYqPRz90UsI7?=
 =?us-ascii?Q?KjZ6raG5x0DkMoNoFt8KelJ0sY47/2EqaN5Dj3WaS/X+9OKm1R4pA87Kqrlg?=
 =?us-ascii?Q?IHv06MQniUypz7/iO0eUagqkLCksvs7LwZw4lrbopIQdH43YbcTs7+4HxYzC?=
 =?us-ascii?Q?lrbDsARNLJ6Dzc2Q0xsuLE5jWqmRSTiuyw/x4WZucr35rBT+tG8F3wN40ez/?=
 =?us-ascii?Q?NsliSpxoLlw3vOQLUs4C1z2PAnM096l0eSVzuMogzn3pSWSM/Qzg4p0xCa3J?=
 =?us-ascii?Q?9qP8zp27AU0eqOm9dIE1lK83vPAbD74IawMfgK+XxI2lwPQIcTMM5IrK8qDz?=
 =?us-ascii?Q?0E289v2cps5Np9DiRYIrMTGH5qzvddphOHMUU3K1Z543bFH1YjYDWs5sD2D3?=
 =?us-ascii?Q?scaA3jxTW6+qTrnXZvGbPivB/hZm5aYnUrJjQoOUGWMN3gfagjtXaVdOsAJ2?=
 =?us-ascii?Q?zUfl3CgpLes0v+tEFeTx4PBwQntXYeDCdvJm+rqYPfWE4MfAsRKy+9iJ4bgD?=
 =?us-ascii?Q?/NKjU7iMCoUYBSHtYQ8UZiPZE773s+0b/1/9eRhSqJ+AC3KN3OV2JD+Iqbos?=
 =?us-ascii?Q?YrUnOZR0NyLEap2UJ87zhF25WwaSSM2cQKRIVF6VXqWmxMXg+GLoRIQOoWe8?=
 =?us-ascii?Q?dsjAC3jfdZ3XkvmxUzo/oJd/Ni/HcjPpBVyczNZ4+ug9rtzXV1Ztr/u0sSgA?=
 =?us-ascii?Q?Tcw5ESMHtOhe9YZ0ewWBdGemVRJOGR3O2Eig3GzT8dceWDA98oyJz93v72tr?=
 =?us-ascii?Q?cu73G0sa56ihdFHcgyQHhwusYBDaSKpGCBqCTKdAjqVNuQ51dudfFTrSDSPe?=
 =?us-ascii?Q?X47roDLvzgVlOZao1Lp/3YX/MWrOyXfVSkbdDWybZuXPw4CAvBhM52nXlSTh?=
 =?us-ascii?Q?rTi6G1DnW83MfEENyC7aSkoEwDBuaIP1HXsn7nOGS7wjvQFV4p3H2QEZGZR/?=
 =?us-ascii?Q?pgtO2cnMTmHS0IpGC0soG8jKypLqv3QOXjd6fZGyS9RABM2PGnWRlbvO7GHq?=
 =?us-ascii?Q?mWpm+bft2d5cYrQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:22.3749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87caa29f-5918-46ce-7bd8-08dd670f7ff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80
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

From: Yi-Ling Chen <yi-lchen@amd.com>

[Why]
For some pixel clock margin sensitive external monitor, we could
not keep original DP ref clock for the ASICs supported SSC DP ref clock.

[How]
From slicon design team's comment, we have to apply the
adjusted DP ref clock for DP devices. DP 128b (DP2) signals
use DTBCLK and not DPREFCLK.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yi-Ling Chen <yi-lchen@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 077337698e0a..b4f5b4a6331a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -976,11 +976,12 @@ static bool dcn31_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 
-	// Apply ssed(spread spectrum) dpref clock for edp only.
-	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0
-		&& pix_clk_params->signal_type == SIGNAL_TYPE_EDP
-		&& encoding == DP_8b_10b_ENCODING)
+	// Apply ssed(spread spectrum) dpref clock for edp and dp
+	if (clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz != 0 &&
+		dc_is_dp_signal(pix_clk_params->signal_type) &&
+		encoding == DP_8b_10b_ENCODING)
 		dp_dto_ref_khz = clock_source->ctx->dc->clk_mgr->dp_dto_source_clock_in_khz;
+
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
 	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
 		if (e) {
-- 
2.49.0

