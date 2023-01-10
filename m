Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCA3C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD9B10E5F4;
	Tue, 10 Jan 2023 15:45:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F5010E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neS6PqbUncCY03F/TJYAi2HC19aOwRN9st+3NY+rKrFapaxlZESzHaHn/4W+w3GdiH5LgGTldqDn+TNT49kHP/kLC+g3YScQeYFuDSvT09z7h0S37NK/jXdFMs6lART9fJZ6GMDI6GdQ4DTlNVjH7sTw2ZOpLFJ8HxqmIeyTprIDSrMKi0NU0nMHvREl4FFund95JBrVVbwpOcodIP85JL3eE2OAb16nvayQZzRKUQdNTdWqrejo04BdAT1rpmgNLYLrVnoAly0xt9kp/fH76hdRLTGTVh89wb4umd7DSxhY7VEdauu5ozpgzHqH8f9E8mQs1eP4WUsUZVbI1TRWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MZzxD79DSbsKopW7EVF+4H7XqjQx+avzmOBO0P9Bok=;
 b=g1qvrIJntLbNWmR6bmVZPdimQ6VGMBA/8of69YKkvJyqcxpRrAqh3O6sNbtOpPRCXnCr+OLXXvPVOT+k7gD8f6ERXyrEBo5Je7ujpsWj4OoxfO8kPUu4Jb5YFtZss4mY+4j1chAEKyDL0Pw0QoWRXD6oL1vdLWZQ/cmoCg+KZ+6QwGYsXJnhEru+siLVP8klgUsqvwohEtnII1AeReaWx6Olq/rshVX3YqAIAuo92lDzGTFaqu8SGD49VwVwQZkjU0zx80XPRQTBUEYu99WVzdCGo0U1Wpdslex+GmokEubrYk6tf5HHIe9uPY+C/+lD2qD9ZuaT8H4fX3zcawbK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MZzxD79DSbsKopW7EVF+4H7XqjQx+avzmOBO0P9Bok=;
 b=Ko9vN7An084nrdwhrbc4+ahwtAfspHjszH2y/zLCp5JYyrlTwhPpIkg7lsQAAPjyZsXRYwlNgmIXzi/+4YjjiM11fxZsukJt+MkWXNOpUpg3PkYkG+Sv0t4b3StQu/4ashoSSDDLsQ4EAN4ibkPP9DnxcR/gRk88uFznvcFmUZM=
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:23 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b3) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 15:45:23 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:50 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 5/9] drm/amd/display: Use matrix of double from struct instead
 of local variable
Date: Tue, 10 Jan 2023 10:43:21 -0500
Message-ID: <20230110154325.3350916-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
References: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a12c79-8e77-49d8-333e-08daf321afe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQwEL/ZYtMyaEuUsIvHt0ikza9NKS/3F5Gd49Q8vffuMCgzcTaRhynV5+Atcpiyb9Xm6nSKbfqMD8si8NlKOhtIdn8jBzwxK0+37mXHQb5X+QkrTxXFEO3sFzRgO7abEJgFB955wFp9sJTEKEH1hy0MM8FsEADwtYD5Ydc/2ISzyPYD9mh5aXb1bhli1MXbPztIqHkfhrSJMrQqkmkrC3kp0CVB9UXu8PgPWwhGlbnhG6/vzko5jgFOIm5z4qFFzbYKRT1HaGgJLutSNLiQGxfGECbP+G1/1VqbowSE1zF/FF+zxGSkjySRnBvEwUUimFwGKhJpKRi8CphLvZuu/l7Tf+IZi3WS+tDx/mmewVP1hLagb84Jj4UaM5MdRDkK5RHnNwJVRUSTfUoRd/Y4i83JibOBDllQVjS+T1r2L++hkcR1Bsmn+8ei3KEtCj2d4aX2Y3J8IrRLylSFNyWnidSzkH3u5r6DXfV7JkmMd8lKG0aKHg4mknNZyqUT2DUhMG68uOqAdZa2MMOi70tw9TCyYVLiZBkOQqNpCckGRJYEWNTd5WyUW5XQlnE10OCzFaXV8XyMTkX621jJ56yEOTNSUijkuD1Xep710jimFRnzWP//JSjHS2JZu5bwxIV5f5XAR/Hfs970XUzBiyw9HNQjrX2l8Q2GJuK6BLMhvyU6Sxdv/lb2OAciNpxamAyLSfapVGvngvXeSwohfN/CZsNIphC/Cp0zLipGop5Pk4xJwDXP3gqxQzwGn2MKLEn5RIhK7FUsOLKnqN4LMBTg2+eIT5x3DHt1waNzC4NNKAJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(66899015)(40460700003)(8936002)(47076005)(2906002)(5660300002)(426003)(41300700001)(81166007)(7696005)(70206006)(4326008)(316002)(8676002)(70586007)(356005)(6636002)(110136005)(54906003)(26005)(82740400003)(16526019)(2616005)(1076003)(40480700001)(336012)(86362001)(186003)(36860700001)(83380400001)(966005)(36756003)(478600001)(6666004)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:23.5938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a12c79-8e77-49d8-333e-08daf321afe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It was reported that on kernel v6.2-rc1, we have the following stack
size issue:

[...]/display/dc/dml/dcn314/display_mode_vba_314.c: In function
'UseMinimumDCFCLK':
[...]/display/dc/dml/dcn314/display_mode_vba_314.c:7127:1: error: the
frame size of 2208 bytes is larger than 2048 bytes
[-Werror=frame-larger-than=]

Remove TotalMaxPrefetchFlipDPTERowBandwidth from UseMinimumDCFCLK
(DCN314), and use TotalMaxPrefetchFlipDPTERowBandwidth from struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c   | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 950669f2c10d..2ea89a26c6e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -6972,7 +6972,6 @@ static void UseMinimumDCFCLK(
 	struct vba_vars_st *v = &mode_lib->vba;
 	int dummy1, i, j, k;
 	double NormalEfficiency,  dummy2, dummy3;
-	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
 
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
@@ -6991,9 +6990,9 @@ static void UseMinimumDCFCLK(
 			int NoOfDPPState[DC__NUM_DPP__MAX];
 			double MinimumTvmPlus2Tr0;
 
-			TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
+			v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = 0;
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-				TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
+				v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] = v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j]
 						+ v->NoOfDPP[i][j][k] * v->DPTEBytesPerRow[i][j][k] / (15.75 * v->HTotal[k] / v->PixelClock[k]);
 			}
 
@@ -7003,7 +7002,7 @@ static void UseMinimumDCFCLK(
 			MinimumTWait = CalculateTWait(MaxPrefetchMode, v->FinalDRAMClockChangeLatency, v->UrgLatency[i], v->SREnterPlusExitTime);
 			NonDPTEBandwidth = v->TotalVActivePixelBandwidth[i][j] + v->TotalVActiveCursorBandwidth[i][j] + v->TotalMetaRowBandwidth[i][j];
 			DPTEBandwidth = (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) ?
-					TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
+					v->UseMinimumDCFCLK_stack_reduction.TotalMaxPrefetchFlipDPTERowBandwidth[i][j] : v->TotalDPTERowBandwidth[i][j];
 			DCFCLKRequiredForAverageBandwidth = dml_max3(
 					v->ProjectedDCFCLKDeepSleep[i][j],
 					(NonDPTEBandwidth + v->TotalDPTERowBandwidth[i][j]) / v->ReturnBusWidth
-- 
2.39.0

