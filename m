Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA8C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FD810E5F3;
	Tue, 10 Jan 2023 15:44:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC3910E5F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVFH/IfGBPTBSy6eMt4wPjv+k0bqKPmB+5J9MQMWroxnXWZKPDBNg1MFf+c2RpkpEWOP94ZibcQVLWdQC8Hjb6JgNwtPILCoUzb7eV2B1SfiqgHuVjpsIB4qYzUC/nYgvIIULG1Q7AnQpGztKPUm6mnyvJ1/sRCJr8DRr8i8fXd7VE8gFlQfJGeojzORu8C5/ERpc2d7VOWzrsAFWrvlOzEKjWu8wsP0tCTvpxTi/jr3nUHS7OyX1yaPPJOPyutG8IDnNYf52iupqF7qfdJrU1+9tM+yrV2iPXNThK0DBoS2gN9oGMTJPtOG4+VGSNBiXuYDHwPIZh5CAU8XVT3fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A/VMFCW1AElTkekMKRghRaBn67g8RCWRgPo2N4RYfk=;
 b=JIT62zx1CdF2HjpEYHpWuwbssqzRm+BAMFn9Jykfrf00X6UD2B5HYqpsEo3ueNP1aH6bwPXPRKyjclPaCywYvXqeEk7PjGDjdintYZAxck9zjalofTiPc/Ul9Fy9h4uIM9qqw3KSrfsWl+3NmCUa4F1Cx78Pob5+QIEPBqWgiNV8Uy760HU+yEnA0wcMI5i0Leg1ZtYu48NLSg9VOXGSKJBTj4ldBUDeXh2OzUmCwcUfTScE7CUuDdltWoCbaPauj04hw1FFhUhpqI/FtzBBQO5NXRwYzHTVcen4+W4m4UQAEe4RU8+u+bH1Q6WLcBxMqhqcHL5uKUiyk0omS3AyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A/VMFCW1AElTkekMKRghRaBn67g8RCWRgPo2N4RYfk=;
 b=e6GFlmAIL7rA3IRPZ0KJNqD2pFYcE32QmDGE1QWds2oK6jRXheIQLrElnA4I0KwSYxmW8ggOddYBCMpLkYUeuT95wvjeF+pg+DAVQF2/ZuOfy4hFICgkVIH3MdUWu4t5CuYRx/83IGpzIhUeIwDnQcv3nCIhyF5pyOjVNsFOAv0=
Received: from DM6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:5:134::36)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:44:52 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::cb) by DM6PR13CA0059.outlook.office365.com
 (2603:10b6:5:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:44:51 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:47 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 2/9] drm/amd/display: Move two arrays of doubles to
 UseMinimumDCFCLK_vars
Date: Tue, 10 Jan 2023 10:43:18 -0500
Message-ID: <20230110154325.3350916-3-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7cdbff-5508-441f-026a-08daf3219cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vKCzMNBATar4itEu6KIJx6YyFU5oj0XCBz6YPHizkp1Sd1Z9DntmXGD6v2kbguTt/psauQKQ48vklld9bIEkDeF10HlMvbQJwJ6Bp4gTulcoy/51DrFLjX1//m1j0naplhL6uvXO2vvBBPxPBfD95YFo8zlBkiRc5NHskGQ52i4sFNsHf88ASiWey0XhlaAjXzFyI6uyJdBsE0BfcOY8ZAAml0FMNm8+C1NQjJ1qHlBSh7hitLVYDvNk/fpLYSu86EfB/W9mhQhvF0+O+Ahm4CyAbWtN4oSXWr3gUA6AlPrBbDTMUuDhWFP7fLPHdJqWdedPv0OoJJx6vnKZ7CD0/n/XTDMltJqCMjy29auYeCqRSpfqDWZ6Sw/e2O1uomSXkQV+z+t9ZNuVh3LJZyKsU33KzMBj3ZfKmKqeRy8nbcO6iVe+7+j2GLxuId2SLbK8i1b6/AClv8pNy0eU/Zb38FFCwU6WxJLEQCExZ2Q04aL1wXXQv+4tC6utvQ2ERkUGOQec07N+ur32r2ftg6wSaEOCscEk4tVUlXbLpSMR0Yr0GVELmfJI9hi+zDjRrkicuv7JWJFRHBqiqrmEVE0cFCrsuLbtknxVY9nDPO0zKUbD96FmUlObZjjTZusAUux3B/GHP6VEGNLuc5LcdLFUAoVGksXV79GL51UlMf+u7iy/V1gH6MExuUzOmVizgL8iBfMeLx9Kbdt00JBoQi7kdKMUoMsJmq+kam11Kn3lLhN/TiBs2d/zdyVVB3lWLi/+w08L0oN1l5g0rw2gLsIyZYLexHG+Sp6A57OtHhW9HU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(66899015)(8936002)(40460700003)(5660300002)(82310400005)(6666004)(83380400001)(86362001)(966005)(478600001)(16526019)(7696005)(186003)(26005)(81166007)(356005)(70586007)(70206006)(40480700001)(36860700001)(8676002)(82740400003)(4326008)(336012)(1076003)(2616005)(2906002)(36756003)(316002)(19627235002)(426003)(47076005)(41300700001)(110136005)(54906003)(6636002)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:44:51.8141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7cdbff-5508-441f-026a-08daf3219cf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

make[3]: *** [/kisskb/src/scripts/Makefile.build:504: drivers/media]
Error 2
[...]/display/dc/dml/dcn31/display_mode_vba_31.c: In function
'UseMinimumDCFCLK':
[...]/display/dc/dml/dcn31/display_mode_vba_31.c:7082:1: error: the
frame size of 2224 bytes is larger than 2048 bytes
[-Werror=frame-larger-than=]

This commit moves two arrays of doubles from UseMinimumDCFCLK to
UseMinimumDCFCLK_vars and makes the necessary changes to access those
values from the struct.

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn31/display_mode_vba_31.c        | 20 +++++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h |  2 ++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 00d3c57f0d98..28dcd46a28c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6932,8 +6932,6 @@ static void UseMinimumDCFCLK(
 	NormalEfficiency = v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0;
 	for (i = 0; i < v->soc.num_states; ++i) {
 		for (j = 0; j <= 1; ++j) {
-			double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
-			double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
 			double DCFCLKRequiredForPeakBandwidthPerPlane[DC__NUM_DPP__MAX];
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait;
@@ -6986,13 +6984,13 @@ static void UseMinimumDCFCLK(
 				double ExpectedPrefetchBWAcceleration;
 				double PrefetchTime;
 
-				PixelDCFCLKCyclesRequiredInPrefetch[k] = (v->PrefetchLinesY[i][j][k] * v->swath_width_luma_ub_all_states[i][j][k] * v->BytePerPixelY[k]
+				v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] = (v->PrefetchLinesY[i][j][k] * v->swath_width_luma_ub_all_states[i][j][k] * v->BytePerPixelY[k]
 						+ v->PrefetchLinesC[i][j][k] * v->swath_width_chroma_ub_all_states[i][j][k] * v->BytePerPixelC[k]) / NormalEfficiency / v->ReturnBusWidth;
 				DCFCLKCyclesRequiredInPrefetch = 2 * ExtraLatencyCycles / NoOfDPPState[k]
 						+ v->PDEAndMetaPTEBytesPerFrame[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth * (v->GPUVMMaxPageTableLevels > 2 ? 1 : 0)
 						+ 2 * v->DPTEBytesPerRow[i][j][k] / NormalEfficiency / NormalEfficiency / v->ReturnBusWidth
-						+ 2 * v->MetaRowBytes[i][j][k] / NormalEfficiency / v->ReturnBusWidth + PixelDCFCLKCyclesRequiredInPrefetch[k];
-				PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
+						+ 2 * v->MetaRowBytes[i][j][k] / NormalEfficiency / v->ReturnBusWidth + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k];
+				v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] = dml_max(v->PrefetchLinesY[i][j][k], v->PrefetchLinesC[i][j][k]) * v->HTotal[k] / v->PixelClock[k];
 				ExpectedPrefetchBWAcceleration = (v->VActivePixelBandwidth[i][j][k] + v->VActiveCursorBandwidth[i][j][k])
 						/ (v->ReadBandwidthLuma[k] + v->ReadBandwidthChroma[k]);
 				DynamicMetadataVMExtraLatency[k] =
@@ -7006,9 +7004,9 @@ static void UseMinimumDCFCLK(
 
 				if (PrefetchTime > 0) {
 					double ExpectedVRatioPrefetch;
-					ExpectedVRatioPrefetch = PrefetchPixelLinesTime[k]
-							/ (PrefetchTime * PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
-					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * PixelDCFCLKCyclesRequiredInPrefetch[k] / PrefetchPixelLinesTime[k]
+					ExpectedVRatioPrefetch = v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
+							/ (PrefetchTime * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / DCFCLKCyclesRequiredInPrefetch);
+					DCFCLKRequiredForPeakBandwidthPerPlane[k] = NoOfDPPState[k] * v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k] / v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k]
 							* dml_max(1.0, ExpectedVRatioPrefetch) * dml_max(1.0, ExpectedVRatioPrefetch / 4) * ExpectedPrefetchBWAcceleration;
 					if (v->HostVMEnable == true || v->ImmediateFlipRequirement[0] == dm_immediate_flip_required) {
 						DCFCLKRequiredForPeakBandwidthPerPlane[k] = DCFCLKRequiredForPeakBandwidthPerPlane[k]
@@ -7066,13 +7064,13 @@ static void UseMinimumDCFCLK(
 			for (k = 0; k < v->NumberOfActivePlanes; ++k) {
 				double MaximumTvmPlus2Tr0PlusTsw;
 				MaximumTvmPlus2Tr0PlusTsw = (v->MaximumVStartup[i][j][k] - 2) * v->HTotal[k] / v->PixelClock[k] - MinimumTWait - DynamicMetadataVMExtraLatency[k];
-				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + PrefetchPixelLinesTime[k] / 4) {
+				if (MaximumTvmPlus2Tr0PlusTsw <= MinimumTvmPlus2Tr0 + v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4) {
 					DCFCLKRequiredForPeakBandwidth = v->DCFCLKPerState[i];
 				} else {
 					DCFCLKRequiredForPeakBandwidth = dml_max3(
 							DCFCLKRequiredForPeakBandwidth,
-							2 * ExtraLatencyCycles / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0 - PrefetchPixelLinesTime[k] / 4),
-							(2 * ExtraLatencyCycles + PixelDCFCLKCyclesRequiredInPrefetch[k]) / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0));
+							2 * ExtraLatencyCycles / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0 - v->UseMinimumDCFCLK_stack_reduction.PrefetchPixelLinesTime[k] / 4),
+							(2 * ExtraLatencyCycles + v->UseMinimumDCFCLK_stack_reduction.PixelDCFCLKCyclesRequiredInPrefetch[k]) / (MaximumTvmPlus2Tr0PlusTsw - MinimumTvmPlus2Tr0));
 				}
 			}
 			v->DCFCLKState[i][j] = dml_min(v->DCFCLKPerState[i], 1.05 * dml_max(DCFCLKRequiredForAverageBandwidth, DCFCLKRequiredForPeakBandwidth));
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 660c22a19c8d..733947be3737 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -251,6 +251,8 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
 
 struct UseMinimumDCFCLK_vars {
 	double TotalMaxPrefetchFlipDPTERowBandwidth[DC__VOLTAGE_STATES][2];
+	double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
+	double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
 };
 
 struct dummy_vars {
-- 
2.39.0

