Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE8C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BB010EC8B;
	Tue, 18 Aug 2026 20:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gY1Ty8hw";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A7210EC8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1/OSX5kZkryVGk5KaWhMe/WbGfJLRjQOTFPS2iPTktztbUBu2lQZx7h4znsKQR7mAzY8IUmonhIPq4u2RMgnn8OwSpf2gEwEsbknds1BqAdYRdUvheCkZ8HcmSGTxLIcay8H9k5e2yGieJ/kuGG5/kvzjRP2TOUqnC5m0Nm+b1lqfJvMhh6kAV0miakNNY93mMlcGQIjgqncIZRQ0SfxQP5OOzpdZBEYBWYSC86E1nrDfzQu4D+EqLv0T76cREL2471Fu+dyDSsMFwFYkGf8L8JG3vzs4Gc53JxQ1ssUB3YFoIPdZdpvRGo4bWsk8cpq9FsW0GKfYzN0a4XR+0w8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QPEPmQkBHHRTU+QIZdjSqHtmsyI4uqYynl2MOvAbIo=;
 b=la7reypZY351FRmXQxJit0OqyIpPQezJLU5yNUFLDLEVjg6esqaB4TX9aRB4TYV9Ai6FcenR2DZIF4UJumyFb/kePcuJqTa2yPRk/vXCg0HnZK02sEljl+xI0Wz0EILTrUp5WkCSKWT7lTKe9YaybIkWWVBRsWQyNQpZCZUHuBJPZrrc+0EqeIWEG3TEpLFNPPjwtKl64PHQIP2do629VITWbAppWfhGbngSr7RdHoksi6SLRlrmAV1cNZsgK1/FiCUDtNFfmPX9OH6usb3AUrmNgouPtxvxwZF2bzHX2cZrzD4Wl/n3wD4qOOUa/n226xOm3cUKCyF5lGZnJdmZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QPEPmQkBHHRTU+QIZdjSqHtmsyI4uqYynl2MOvAbIo=;
 b=gY1Ty8hwuZde1Z4EXA+s5oRTfq5Zs5wm0e44nb1srkTD570/k3gCrnz61LsbMAD32gYlYQV1F4nMIPz7SF/PUuf0vALBln3VtigjfD5qCBruMyfC0xIH/bJlByiRiIXkT1H3EJsXtgIWfh+jgDUHtA+YQX4HDeY1bv8hrOr5eps=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:21:59 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::ac) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:21:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:58 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:57 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Meera Patel <meera.patel@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 06/82] drm/amd/display: Fix DPREFCLK override when SMU isn't
 present or ready for DCN315
Date: Tue, 18 Aug 2026 16:14:58 -0400
Message-ID: <20260818202139.4172592-7-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2708db85-827d-4163-975c-08defd665afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3F7HkWinIjTTbBXP7vZyZeV45+EZGAkH8tqXu9WwmTBRqFTGjmYMH7nYeWXeQQpLno2C3APpt4rQv0pYhrCT0ZtuoEt3eZkyXxyK/UI9xOeNJ26QoMHdJ7PQkqIfkpe+ZziIxCnzBmd+04BnnMX/O83MoLeydBomAvZJOLqLazPWj3OPdpXqb1skZXU6/7UKxoLKBCsg0xRFaz9ggQmgqgSvzqB57+xd52xFMSjp/dd5M6QV63C3ZpGSSM+Dt9b6IBlddpBkbsESqr6aRnpSsQbYpdRwGpH4LLdR3VW48nAGe0+5hesjdD7gzKfhjd4KIeJP6L5Ep0bXNAkqPXXljZvzXBK1PFE/F+uwr2nDXJoLTCs21JhLqTbK+jkmV88F0qC0mSYAsNday1hc9TVWF5uzAQGTIBZx56n50BVwcjuSEo8fUEKOHOAcW0IH7oZaPCIfxo49+ge+rjvKff7tD50XPt/DUqT5EXL5iKqxo1Y+vaTR/jhuie4kGK+Gyd9bqKCM8fe49O4zLVri5G0TfnLOgPN6/9gjPbeWdDsufEj/3tybYe4kTFjtBIi+6d7KxJxU+Ce5EdUPx69XhFNtN8yddj1Vt14yHKIAJxkjt58RoFo9PpICmVdwnIb7KgYsxwHCPje1dMSRHISu5LWb4RMQADBasv2UEdd7znkvo8hXCOVdbmnC+viuDtV0v9Pk3OqRXgR3ohgvFBGkOCm8Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2DRU+X/mczKUwPlgsTElzRQMI2FGJQ9RmAa0DXtAmdQUIq6fcKHB57w5TA7s4gx6tF5yJ2bcGoLUic/YiHi2WPY4VjAZzgY+Q7aWiFXO4Pg+E7SulJsMWAI65wlUTAITgIroqVDAiBVXlNBVs58vJOXBlpeAdp7XmH8F5KoDeRCOjZwkR1KJkCWZyjTewmA3rkx66ygx2cWKQCa53dfeL0t6wMH8WV1NSGql3LdZCWuf7Q0sOCSH1Ge74bjKXNYzg00kEEm9DPMELohV07dqMvT3mOkR8eO7iTj+FxL4JMJ+T09zZl9K8rXAtaza42EjvpzUH0D2aWhgpYr1hqtUaIHafUHFFKedBUFAA0fR8aI1LG3unxawJuM9npVA/jiBJbEYyCCIP+EBT1Yi+XulcuUWhI0FYCROu6mArZ8cec7MlNSoCbQqv9HIQnxkVPFL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:58.7751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708db85-827d-4163-975c-08defd665afc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

From: Meera Patel <meera.patel@amd.com>

[Why]
If SMU has not loaded properly or is not present in a test environment,
then the DPREFCLK is overridden with an invalid value.

[How]
Add an SMU present check and shift the override below the check.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Meera Patel <meera.patel@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 6ba7cff2ce05e..8ca367b723253 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -673,16 +673,16 @@ void dcn315_clk_mgr_construct(
 				  &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
-	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dcn10_clock_read_ss_info(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn10_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
-	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
+	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled && clk_mgr->base.smu_present) {
 		int i;
 
+		clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
 		dcn315_get_dpm_table_from_smu(&clk_mgr->base, &smu_dpm_clks);
 		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
 				   "NumDispClkLevelsEnabled: %d\n"
-- 
2.43.0

