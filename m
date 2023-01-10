Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA224C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3800A10E5F7;
	Tue, 10 Jan 2023 15:45:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A0510E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI4dLvye1Fy3VM8MFIHIjlrt+MlWvOt5IRlP+4NhGQ6TGB0aSK9GGt1PcaLLEjSf/9SI6IXKbOXsLnxRvGWLoULpgtYD6HZ1FN7QfFfRTYxKPU9KhZXWBRct2bK85pK6WIuNzrnqGRTpAr2injJkD4DcC0Ce5G6wgeVNMQN/LVO1wdF0z08B1Oa1PikBiZPiUV6/y6ZfmOKYQu9gUdxuu738WEPi0O23yaIermWc211nu+4FvAklYVNMgKd0xz19nI+FcnC89iZeUXLcBx6qsvB2ceTTi6HNkumGvMH4KvEfYCmeFeTyyCyn8M42ETojlKPoi2le67JuVJWIZ9D2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S61EjN7efGIVuLDh5Nps4L/xmGcSZvReJwIK9yBfFF8=;
 b=m6R/aSw74NyYW6xXIMu3b/N1fhjEEIkJzEvS+dZoCZxHOSe61VNsSSnClnQFjrDBwpVc0FGeXbsAZqdcrznauf7Ckrgv+p5eNL7YwakBh1aj7HJ2ZVlnitrLqhquHUsIgunWu6nAWa6poA4ZqdJzLL4V9iXpiJ/krzxdqxXrKHlVwNCC6MmuiE+HHiy6nGnZfRZyzKyNZBilfoDb53H0wK2z4OB+W5IHQsyAPE7mvTRz+Qq1fo9bgrf8G62gYIJ2k4e8pt1bZKesPd7rph/41wHTtBBkR8Cbe35tYCOjMM849kEd30CR2J2px4UMyGRCMf3VPxAt4xUWutxYCvb5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S61EjN7efGIVuLDh5Nps4L/xmGcSZvReJwIK9yBfFF8=;
 b=rzAbvQJ9gxo4WQ8KgkV+0MiUz6xt5brUVrEkwKaz83CPrqmTU2cqVXNVYHhiGEWkBlIdOh5nTAOVCBqGCicY4DHGfaT9M0an2KcDx31p3SJB9G9qPqoISmG8vfXXZGQoZlpuCMAS25hd/HdMWv/RLnhs4sX3n0ogwxlW8fQLLsM=
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:45:24 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::1f) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 15:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 15:45:24 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 7/9] drm/amd/display: Use PrefetchPixelLinesTime from struct
 instead of local variable
Date: Tue, 10 Jan 2023 10:43:23 -0500
Message-ID: <20230110154325.3350916-8-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: a540c53a-63c5-4e60-a157-08daf321b02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fo7Riflqtv1U5YBLDPrjRiSG1BiCOa290u74ZPJSmcRky5Dkzp1yDiE1rO+By/NrOU/lLvXEquCKDJmgVTWRD2QDwk32bjrgKlmIAj53pNs1Avw8QKW2ItIt0jHQ280qQ+4JG6BQO49cNcNRInlYSVt6omqkQt0eAurXpDPhQg2gHfBjMiMrSiI1cHDzCx+Q4PqeWBWxALYFXDT+BI61oM0DEPWqRnBkJcPWuclUb3qgaiSyUt4njRlweZcs5zoOGS7VMMJ1n2a1DQSjhKydl3x7osgDSseH6yWSqdfKnMNYNvJznrOsyQIda/NUCf7VRNCOtEX1wvV7yZbZYytvThGkcj9zKya+assG9Pf8nA/fvnb723L840auQVIpEmw2QnDcgCQJ+zRIuFvhyEz2JkViTOA7aY3pJpnW2HSsFDrVrI6iCyXNQD1yCUZxjBon5oisvnWxR+4g5QGvZiW4aVmdMUpP4R9iePCtFTL+dS8GBJRkpsipqVy44ixoC3vZA944g3iYD/rB4vvPsZUrgfsGv/R2DsilTCGPsTb9FbxNUqY25yz6Q+b+oOexjhpnvM95orA+LFCNxQu7qI6rNEiihgkGjPb506xwjhCrqnkZwTVHl1mAr8e0gOC4aitPzYWUrDObZ/XjlNF5KyeK8XrWhjROItBbeAfzB0tCEEq1Td3N0NWu05IIlDn4+TMq0Unh1QNK658OzEwiaKkaI5Ym6j8V8oR6u8hwvVx6xX6vWcT57pfjc9YXFP9gCrGtLABhqJCH/UpPQ2snk/I47fSDipTevx7ode5vAXLCaE8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(41300700001)(426003)(4326008)(1076003)(2616005)(6636002)(19627235002)(110136005)(8676002)(70206006)(336012)(316002)(36756003)(70586007)(54906003)(82310400005)(40480700001)(86362001)(36860700001)(8936002)(356005)(81166007)(5660300002)(83380400001)(82740400003)(2906002)(66899015)(966005)(16526019)(26005)(6666004)(186003)(478600001)(7696005)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:45:24.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a540c53a-63c5-4e60-a157-08daf321b02f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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

This commit replaces the local PrefetchPixelLinesTime from the same
version in the UseMinimumDCFCLK_vars struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dml/dcn314/display_mode_vba_314.c  | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 8de1f7840b5a..f51885d3dd2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -6976,7 +6976,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
 			double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
@@ -7034,7 +7033,7 @@ static void UseMinimumDCFCLK(
 						+ v->PDEAndMetaPTEBytesPerFrame[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth * (v->GPUVMMaxPageTableLevels > 2 ? 1 : 0)
 						+ 2 * v->DPTEBytesPerRow[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth
 						+ 2 * v->MetaRowBytes[i][j][k] / NormalEfficiency / v->ReturnBusWidth + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k];
-				PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
+				v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
 				ExpectedPrefetchBWAcceleration = (v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k])
 						/ (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k]);
 				DynamicMetadataVMExtraLatency[k] =
@@ -7049,9 +7048,9 @@ static void UseMinimumDCFCLK(
 				if (PrefetchTime > 0) {
 					double ExpectedVRatioPrefetch;
 
-					ExpectedVRatioPrefetch = PrefetchPixelLinesTime[k]
+					ExpectedVRatioPrefetch = v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
 							/ (PrefetchTime * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
-					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / PrefetchPixelLinesTime[k]
+					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
 							* dml_max(1.0, ExpectedVRatioPrefetch) * dml_max(1.0, ExpectedVRatioPrefetch / 4) * ExpectedPrefetchBWAcceleration;
 					if (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) {
 						DCFCLKRequiredForPeakBandwidthPerPlane[k] = DCFCLKRequiredForPeakBandwidthPerPlane[k]
@@ -7110,12 +7109,12 @@ static void UseMinimumDCFCLK(
 				double MaximumTvmPlus2Tr0PlusTsw;
 
 				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - DynamicMetadataVMExtraLatency[k];
-				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + PrefetchPixelLinesTime[k] / 4) {
+				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4) {
 					DCFCLKRequiredForPeakBandwidth = v->DCFCLKPerState[i];
 				} else {
 					DCFCLKRequiredForPeakBandwidth = dml_max3(
 							DCFCLKRequiredForPeakBandwidth,
-							2 * ExtraLatencyCycles / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0 - PrefetchPixelLinesTime[k] / 4),
+							2 * ExtraLatencyCycles / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0 - v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4),
 							(2 * ExtraLatencyCycles + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k]) / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0));
 				}
 			}
-- 
2.39.0

