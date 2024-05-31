Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E4CC25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C594E10E4D8;
	Fri, 31 May 2024 16:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYvK5w8j";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC8210E5A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWRJswNw5yOfmT6z/KG3wIoV+AeYuDbkwJe+hkr5ThX+cWdS0PGy62yqYZY57ZOGFzpAqiR9pQdIV/MepIrGBgy7oiig7/7sgmk3KFl/uJND5SEmWT9q1kx8CxA2TYeHp73KsSUFYLw1Qelc8skd5i8Ltidzuqh0PfO6/bdWdLTF0+EEUVjIUtHZmFgJYiCxPpAwlQfXm1VptyuGmmQglltIRoXmpyenEYCtm6XbSILG9Q9wGIuWGZIky5Rs2BLgBaVTvpQd7e/ugE/SY3jWVM5w4BzflLVd5r8eL332XIWrJSVFAxHJ+3dGX40L56CSprJDNjyFVwGNSaA7LA0aOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkJuPQ0/P6pNV5bBga4Bj2jMD4XQHC7y5OdXm/2pxuo=;
 b=Tv4igwCOf0KZwLkjIyGNGUdY7Idg9vk+LcAxytU+a5yTx6VNViqsKWRoH8Jqib1+x+3s2srodCoXG84oqyB2EmWr589/xJ/kizFPhNMlGRQww88bIFwrE94A18sWDvrvPeJ7XZcTFhLfpfDul0qi47RbkIIFo21xu2fuV18BoHPFccveIuClIUSQERtjhSG/I6uWaAqPrAnzgoCo+TeGa1EbxsVL5zVhfVJWsAfJQS1AT+LZlIsffC+ND36GSDjKTvlr34r75EQWf91UaXmh6ol9B2XqJkStBSpmpoGJcFNmNoJDUJ2Vzo6R+UcRVLDSqJ08zrMF6jgzvCk01HgXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkJuPQ0/P6pNV5bBga4Bj2jMD4XQHC7y5OdXm/2pxuo=;
 b=dYvK5w8jTKZJ7eIK2+k/14jKVMQmz8SpHoKT3q+WHrkrtu/yF1yl6DL5CXob5NP1UldseMfHjM6vtY3Lh3Ad+dp+w/DZRKyR8A+6zFYzGK9zmfdCt4vg5fRdePCUObNp60oUh/cCJLC5yaBIpZFiVT6bHf2P/Nu7+u4dWTqLsWk=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:55 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::48) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Fri, 31 May 2024 16:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:50 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung Joon Kim <sungjoon.kim@amd.com>, Jun Lei
 <jun.lei@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 31/32] drm/amd/display: Fix DSC slice and delay calculations
Date: Fri, 31 May 2024 12:51:44 -0400
Message-ID: <20240531165145.1874966-32-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e5bcde-ed8f-4a48-e55d-08dc81921e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DD/Ioed1WrZUZeMsthNObr4AIOgryBfFhnMk18duG0veCjq9h2Ob8a/vLzBo?=
 =?us-ascii?Q?Ph3JhOwTtIIeiMic9UfukSDa1ZXSr53EwBPNOs133CMpNYN0SaQWM7IVIPr/?=
 =?us-ascii?Q?yFSNs8Ab9lQZbLCj4e4oFd65GuaTv7sOUBdmw0cK9111wmkdgbbn8aKuNc9j?=
 =?us-ascii?Q?t8uiLDPtJRf43OEgQvqkLnny9xOH5oQnd0YTFuCaFHyzousWI+EsCTFhQSgh?=
 =?us-ascii?Q?a9Ymx/da17neGxXcT6YsdOKpNlp1gQLrq4+bU6cCq+xr+2EZn0SMW8xYx+jp?=
 =?us-ascii?Q?jLzBhxruft+Tp2ZdM95FtrUj1Na4fYDQOJ7H8QvRJmSxIUVgozWo51PhOcRs?=
 =?us-ascii?Q?0UMzPM0x6h+3cj08L4oFNs2Y6uQNvFL8dTNKGnaMgVVD48wJW+eXde540fwF?=
 =?us-ascii?Q?f9+rv1xrTZSEKPEaZMjq5XwX0+Skr9cNJzUlvWM78k/5euSora1YK9NZdsN8?=
 =?us-ascii?Q?KOObhpHVcv+89Kr9F4EBYQD3vV04WwhpKz6zmuPv3Dlso4ymMU0RSfFPrvLD?=
 =?us-ascii?Q?rtViix0Yi6kA83u1DU3d8uU1J6E8gPDy4JFhyTeLAdKLWkFB4rTy2g10Y/y6?=
 =?us-ascii?Q?5k/G7VFLVC5wBh5fTFNlRuFQIrPJt32jnDUhjewyXjg8oW/rx/CC0AY/Lb1D?=
 =?us-ascii?Q?wErLQQ4S4bT+Ew077IPK6vig6/deSDirScVxmrPkPFW/+w/TxGqmSr7PrMWL?=
 =?us-ascii?Q?YYvJ2lkHERSDYX2eK5Ee+sCGr78wgGl8AddIiby1K68AznDFI+a2mXwd5Now?=
 =?us-ascii?Q?rcuCt9LChXpk4WfpkbyZ3MZ4WqyQg0V5R+cgigVzP0a8Hnn1Si3drQQdGwsq?=
 =?us-ascii?Q?f9gzDqY5BgYpmV+wzbqsxf2uYMUU2bexyjJFb43Rx8/LzBZnoKtneJm3arM2?=
 =?us-ascii?Q?YDYuPRO+loJ3nFjP2IHA8HBKWuVzGKbYlgKvMyH2brX9iSeIPzbqFVLIPTu7?=
 =?us-ascii?Q?wyNO8wygh624UgzS1YmcQtRVrqAfFxl0COCaV9ohtJNvNrAXrx9fGcrpxq/P?=
 =?us-ascii?Q?GTNrUXCVUKwm9Xq1zW4xp1CQjE1LO326jVouyicNTYITQNOaj/JNuaN2zgKl?=
 =?us-ascii?Q?iD+idb17CuhwPkJ0xDKSBPaXTnsjI7UBaK2BxbLBnUPcgjHxi/KSome44XVb?=
 =?us-ascii?Q?GaAZLxbuqVq6ixyuNnNskzoQK8hi2w3Nzwkn0MyW4xevzn5rmfSEm/2TLXRF?=
 =?us-ascii?Q?LEFFwK09bRYCBxnEX995vVE0MxplbAPfPmvoyQqNp5VbHoixAR4sHxNwy4r6?=
 =?us-ascii?Q?MUIZnJMpdUyJ/HvT5/GLCOT8M4Iuk/sCdvuPu5demL65U47F+68s7TLSTzhd?=
 =?us-ascii?Q?ItmojhdxW5p2n29m0oDw0WVsJbT9l05Uzog/YwATive7wk+0JHp4Ar6iuCAv?=
 =?us-ascii?Q?2bHEZqxJANN6Qh3Awlbbd5wGYVSf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:55.4335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e5bcde-ed8f-4a48-e55d-08dc81921e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

From: Sung Joon Kim <sungjoon.kim@amd.com>

[why]
There are other factors that determine the number
of DSC slices. The slices should not be determined
in DML but retrieve the value calculated from driver.

[how]
Update the logic to determine DSC slice.
Make DSCDelay per display pipe.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Sung Joon Kim <sungjoon.kim@amd.com>
---
 .../amd/display/dc/dml2/display_mode_core.c   | 45 +++++++++++--------
 .../dc/dml2/display_mode_core_structs.h       |  1 +
 .../display/dc/dml2/dml2_translation_helper.c |  1 +
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index ff2adc9eab0d..a08ae7b7d39a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -115,6 +115,7 @@ static void CalculateODMMode(
 	dml_float_t DISPCLKDPPCLKDSCCLKDownSpreading,
 	dml_float_t DISPCLKRampingMargin,
 	dml_float_t DISPCLKDPPCLKVCOSpeed,
+	dml_uint_t NumberOfDSCSlices,
 
 	// Output
 	dml_bool_t *TotalAvailablePipesSupport,
@@ -5516,6 +5517,7 @@ static void CalculateODMMode(
 		dml_float_t DISPCLKDPPCLKDSCCLKDownSpreading,
 		dml_float_t DISPCLKRampingMargin,
 		dml_float_t DISPCLKDPPCLKVCOSpeed,
+		dml_uint_t NumberOfDSCSlices,
 
 		// Output
 		dml_bool_t *TotalAvailablePipesSupport,
@@ -5563,7 +5565,7 @@ static void CalculateODMMode(
 	*NumberOfDPP = 0;
 
 	if (!(Output == dml_hdmi || Output == dml_dp || Output == dml_edp) && (ODMUse == dml_odm_use_policy_combine_4to1 || (ODMUse == dml_odm_use_policy_combine_as_needed &&
-		(SurfaceRequiredDISPCLKWithODMCombineTwoToOne > StateDispclk || (DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit)))))) {
+		(SurfaceRequiredDISPCLKWithODMCombineTwoToOne > StateDispclk || (DSCEnable && (HActive > 2 * MaximumPixelsPerLinePerDSCUnit)) || NumberOfDSCSlices > 8)))) {
 		if (TotalNumberOfActiveDPP + 4 <= MaxNumDPP) {
 			*ODMMode = dml_odm_mode_combine_4to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineFourToOne;
@@ -5573,7 +5575,7 @@ static void CalculateODMMode(
 		}
 	} else if (Output != dml_hdmi && (ODMUse == dml_odm_use_policy_combine_2to1 || (ODMUse == dml_odm_use_policy_combine_as_needed &&
 				((SurfaceRequiredDISPCLKWithoutODMCombine > StateDispclk && SurfaceRequiredDISPCLKWithODMCombineTwoToOne <= StateDispclk) ||
-				(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit)))))) {
+				(DSCEnable && (HActive > MaximumPixelsPerLinePerDSCUnit)) || (NumberOfDSCSlices <= 8 && NumberOfDSCSlices > 4))))) {
 		if (TotalNumberOfActiveDPP + 2 <= MaxNumDPP) {
 			*ODMMode = dml_odm_mode_combine_2to1;
 			*RequiredDISPCLKPerSurface = SurfaceRequiredDISPCLKWithODMCombineTwoToOne;
@@ -5880,11 +5882,11 @@ static dml_uint_t DSCDelayRequirement(
 
 	if (DSCEnabled == true && OutputBpp != 0) {
 		if (ODMMode == dml_odm_mode_combine_4to1) {
-			DSCDelayRequirement_val = 4 * (dscceComputeDelay(DSCInputBitPerComponent, OutputBpp, (dml_uint_t)(dml_ceil((dml_float_t) HActive / (dml_float_t) NumberOfDSCSlices, 1.0)),
-												(dml_uint_t) (NumberOfDSCSlices / 4.0), OutputFormat, Output) + dscComputeDelay(OutputFormat, Output));
+			DSCDelayRequirement_val = dscceComputeDelay(DSCInputBitPerComponent, OutputBpp, (dml_uint_t)(dml_ceil((dml_float_t) HActive / (dml_float_t) NumberOfDSCSlices, 1.0)),
+												(dml_uint_t) (NumberOfDSCSlices / 4.0), OutputFormat, Output) + dscComputeDelay(OutputFormat, Output);
 		} else if (ODMMode == dml_odm_mode_combine_2to1) {
-			DSCDelayRequirement_val = 2 * (dscceComputeDelay(DSCInputBitPerComponent, OutputBpp, (dml_uint_t)(dml_ceil((dml_float_t) HActive / (dml_float_t) NumberOfDSCSlices, 1.0)),
-												(dml_uint_t) (NumberOfDSCSlices / 2.0), OutputFormat, Output) + dscComputeDelay(OutputFormat, Output));
+			DSCDelayRequirement_val = dscceComputeDelay(DSCInputBitPerComponent, OutputBpp, (dml_uint_t)(dml_ceil((dml_float_t) HActive / (dml_float_t) NumberOfDSCSlices, 1.0)),
+												(dml_uint_t) (NumberOfDSCSlices / 2.0), OutputFormat, Output) + dscComputeDelay(OutputFormat, Output);
 		} else {
 			DSCDelayRequirement_val = dscceComputeDelay(DSCInputBitPerComponent, OutputBpp, (dml_uint_t)((dml_float_t) dml_ceil(HActive / (dml_float_t) NumberOfDSCSlices, 1.0)),
 										NumberOfDSCSlices, OutputFormat, Output) + dscComputeDelay(OutputFormat, Output);
@@ -6938,20 +6940,25 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 
 	/*Number Of DSC Slices*/
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-		if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k) {
-			if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 4800) {
-				mode_lib->ms.support.NumberOfDSCSlices[k] = (dml_uint_t)(dml_ceil(mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 600, 4));
-			} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 2400) {
-				mode_lib->ms.support.NumberOfDSCSlices[k] = 8;
-			} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 1200) {
-				mode_lib->ms.support.NumberOfDSCSlices[k] = 4;
-			} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 340) {
-				mode_lib->ms.support.NumberOfDSCSlices[k] = 2;
-			} else {
-				mode_lib->ms.support.NumberOfDSCSlices[k] = 1;
+		if (mode_lib->ms.cache_display_cfg.plane.BlendingAndTiming[k] == k &&
+			mode_lib->ms.cache_display_cfg.output.DSCEnable[k] != dml_dsc_disable) {
+			mode_lib->ms.support.NumberOfDSCSlices[k] = mode_lib->ms.cache_display_cfg.output.DSCSlices[k];
+
+			if (mode_lib->ms.support.NumberOfDSCSlices[k] == 0) {
+				if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 4800) {
+					mode_lib->ms.support.NumberOfDSCSlices[k] = (dml_uint_t)(dml_ceil(mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] / 600, 4));
+				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 2400) {
+					mode_lib->ms.support.NumberOfDSCSlices[k] = 8;
+				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 1200) {
+					mode_lib->ms.support.NumberOfDSCSlices[k] = 4;
+				} else if (mode_lib->ms.cache_display_cfg.output.PixelClockBackEnd[k] > 340) {
+					mode_lib->ms.support.NumberOfDSCSlices[k] = 2;
+				} else {
+					mode_lib->ms.support.NumberOfDSCSlices[k] = 1;
+				}
 			}
 		} else {
-			mode_lib->ms.support.NumberOfDSCSlices[k] = 0;
+			mode_lib->ms.support.NumberOfDSCSlices[k] = 1;
 		}
 	}
 
@@ -7050,6 +7057,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 					mode_lib->ms.soc.dcn_downspread_percent,
 					mode_lib->ms.ip.dispclk_ramp_margin_percent,
 					mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz,
+					mode_lib->ms.support.NumberOfDSCSlices[k],
 
 					/* Output */
 					&s->TotalAvailablePipesSupportNoDSC,
@@ -7072,6 +7080,7 @@ dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
 					mode_lib->ms.soc.dcn_downspread_percent,
 					mode_lib->ms.ip.dispclk_ramp_margin_percent,
 					mode_lib->ms.soc.dispclk_dppclk_vco_speed_mhz,
+					mode_lib->ms.support.NumberOfDSCSlices[k],
 
 					/* Output */
 					&s->TotalAvailablePipesSupportDSC,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index f595e48ae7b8..f951936bb579 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -575,6 +575,7 @@ struct dml_output_cfg_st {
 	dml_uint_t AudioSampleRate[__DML_NUM_PLANES__];
 	dml_uint_t AudioSampleLayout[__DML_NUM_PLANES__];
 	dml_bool_t OutputDisabled[__DML_NUM_PLANES__];
+	dml_uint_t DSCSlices[__DML_NUM_PLANES__];
 }; // dml_timing_cfg_st;
 
 /// @brief Writeback Setting
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 705985d3f407..a800bfca1239 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -739,6 +739,7 @@ static void populate_dml_output_cfg_from_stream_state(struct dml_output_cfg_st *
 	out->DSCEnable[location] = (enum dml_dsc_enable)in->timing.flags.DSC;
 	out->OutputLinkDPLanes[location] = 4; // As per code in dcn20_resource.c
 	out->DSCInputBitPerComponent[location] = 12; // As per code in dcn20_resource.c
+	out->DSCSlices[location] = in->timing.dsc_cfg.num_slices_h;
 
 	switch (in->signal) {
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
-- 
2.34.1

