Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF99CC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 05:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD8D11AC1D;
	Thu, 21 Jul 2022 05:13:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0128F11ABA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 05:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzKlDwLF5w8QJUfhpqFUXda2auGdbcE8e9qVZU9hI7fgQc9vdqQZVLgJiqL0daKzHZ4BRGpnuwzg4VLu5mdZLh4bFjyzjHmjgkTSxLJ/2NBfLyOGEzEUtUEBcwHB32uUv3rq1ScequZi23vDZzwEXp/ReS5gGopUL6TPSlMHzhWxnLfxxPbSWrlcq5sAva825dSQLY3cfY4h4rVQ81ZuKxcHY+TSkfr674KNNmOJiYmZAv/IRhOy64k6EacjFHMfoa22WX3R0abHUxGP3O9r/MmdmF0QSTTogEBMSUdNonTkCjx14gan0Oy23wNxEu1QBwNd33/lwooORok8Fukmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIVpKuayQ3hqVHpyLW2BXS5hviISVSX4mqVFcCHAzac=;
 b=JYN1LE7uwOLy5K/bIMjQVxYfLJF1ascdyON2Ao8Ty1Up/j5mRyI+nNQT87n4tEjBmnwL45+eeXVEaeRCOHWp/LgoahzV90TJySgo8y6AnjwCZ2tA6P6xIUezKiQZ3783SNhMezKiIYuE3zA0U2Z1A9R+lSYO8YH36sMLUDxrgoVuyxwRt90iiQpDZOvjtv6az9iGOlH+a/pHCAziL45OTaj4DKdzsDw1J3nYauxIsEX+jCLGN2IMCyRz73sLP1aetHaKBoASNbK1jMkeTYOmcJvnfsAAxkdkw6ulRsQu3d8zinZRYx1hzbNFKLlTwK/rN5uvgd0QItgIFww5/x9Y+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIVpKuayQ3hqVHpyLW2BXS5hviISVSX4mqVFcCHAzac=;
 b=2xan7qz6GbM8rFUtRR5iR5vI8olBtZU1WFyNDFTJjcc3TVpKB0/shXk4sxffktuOLJRFOKTKkE0K5FoU3G6Jt6o9N9tpZaQtwgj0wSXvgMfumM4qoBPKmoVQlyfYLixldO8+82hrWzPYHkCO2bIfggXS0pDVSaLLg5qMaE5E0xA=
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 CY4PR12MB1685.namprd12.prod.outlook.com (2603:10b6:910:11::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Thu, 21 Jul 2022 05:13:24 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::bd) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 05:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 05:13:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 00:13:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/display: reduce stack for
 dml32_CalculateVMRowAndSwath
Date: Thu, 21 Jul 2022 01:13:03 -0400
Message-ID: <20220721051305.1356754-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220721051305.1356754-1-alexander.deucher@amd.com>
References: <20220721051305.1356754-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec418277-ee73-4af9-afe1-08da6ad7bcfb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1685:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyMFN3auTB4KjF83kE48vfkCDknu8Xpt1M34RtGBtfqdTlDYWNj+s/e9xIAOZIS8wLM2TA72CBgEotksNjdrcO2QJ8+PXWl8ZBuGDuk2wh0MfjOZlA2OcdoM2O8X0ElLQfAjq1FwWjSGsqwwcjaqc/eJUdt2bUVU9BFpvg8vNcFYbfWaL26lRb3aW3hNZtBorOSbvTiinxuRIiwU/k8vcOJKRRC3SZmlWUmg5cje1q9dWFdVu4kdmZO/x1L58jve9nNBdA7peAyA1U29k6qntLj5Rc/9EB7nFmJJ6GPbsLfUgMKre3aGeJYBrAF1rMzAgUM58Z4q7bFaHBOzlYxU8wHtpwWDbK88BjFus3ipOWlTXLaPYzy9EUpZ2aS5lf4ikM7dSeApRLmPaXNleaoVqAa0pAbMMyOKd0oOTb3H6bZOM9oLzyXGlbdj5L01bTAV6OM2BzPwCRq7dWe7iSF3wqr+JqxPfF6hVk8shdpzqmQ+1TJuvIIO9RFFHkiiw8i2D2wPvSoEvC+tDFb5chdFz8oYa5hwng1LYpDodaS7IDdcTd9J6FxvXhAskYPkq+pyKaKj4fw1hVQDe4ShozqAnYmN0DNaxKFhNLi2uyFW9Yo25tTHCBvpidA94qm5RQM+8QdgL94W3efI3QAJmrzUJqZWatPvZM5mt+M4UMtsONiAL3lQtC/1KhMgQfXA0qgylx5rwVgVZGZk7Jj+sMbyO7/xVvku9lnBVvBbyUtne3uH6abxIq/vgmdHUescBBU3BmF3ezbDtN0Q4j1uuRty5mPviyL+8MymJvoa5SMcS6y6dmP9bzWay7jI3XgSnlzIjMWweVUimpvSbFrckiPxm1xF5kOvxWpD4xgWnrM9IoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(478600001)(5660300002)(1076003)(316002)(2616005)(2906002)(26005)(82310400005)(6666004)(356005)(30864003)(41300700001)(82740400003)(86362001)(8936002)(336012)(83380400001)(7696005)(186003)(40460700003)(16526019)(36860700001)(40480700001)(47076005)(426003)(70206006)(6916009)(36756003)(19627235002)(54906003)(8676002)(70586007)(4326008)(81166007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 05:13:24.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec418277-ee73-4af9-afe1-08da6ad7bcfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1685
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move stack variables to dummy structure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 110 ++++++++----------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  19 +++
 4 files changed, 70 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index c0e537731c1f..0ecc9e4c52a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -461,6 +461,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	{
 
 		dml32_CalculateVMRowAndSwath(
+				&v->dummy_vars.dml32_CalculateVMRowAndSwath,
 				mode_lib->vba.NumberOfActiveSurfaces,
 				v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.SurfaceParameters,
 				v->SurfaceSizeInMALL,
@@ -2676,6 +2677,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 			{
 				dml32_CalculateVMRowAndSwath(
+						&v->dummy_vars.dml32_CalculateVMRowAndSwath,
 						mode_lib->vba.NumberOfActiveSurfaces,
 						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
 						mode_lib->vba.SurfaceSizeInMALL,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index da5befd7fdec..9ebd3207ce42 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1867,6 +1867,7 @@ void dml32_CalculateSurfaceSizeInMall(
 } // CalculateSurfaceSizeInMall
 
 void dml32_CalculateVMRowAndSwath(
+		struct dml32_CalculateVMRowAndSwath *st_vars,
 		unsigned int NumberOfActiveSurfaces,
 		DmlPipe myPipe[],
 		unsigned int SurfaceSizeInMALL[],
@@ -1932,21 +1933,6 @@ void dml32_CalculateVMRowAndSwath(
 		unsigned int BIGK_FRAGMENT_SIZE[])
 {
 	unsigned int k;
-	unsigned int PTEBufferSizeInRequestsForLuma[DC__NUM_DPP__MAX];
-	unsigned int PTEBufferSizeInRequestsForChroma[DC__NUM_DPP__MAX];
-	unsigned int PDEAndMetaPTEBytesFrameY;
-	unsigned int PDEAndMetaPTEBytesFrameC;
-	unsigned int MetaRowByteY[DC__NUM_DPP__MAX];
-	unsigned int MetaRowByteC[DC__NUM_DPP__MAX];
-	unsigned int PixelPTEBytesPerRowY[DC__NUM_DPP__MAX];
-	unsigned int PixelPTEBytesPerRowC[DC__NUM_DPP__MAX];
-	unsigned int PixelPTEBytesPerRowY_one_row_per_frame[DC__NUM_DPP__MAX];
-	unsigned int PixelPTEBytesPerRowC_one_row_per_frame[DC__NUM_DPP__MAX];
-	unsigned int dpte_row_width_luma_ub_one_row_per_frame[DC__NUM_DPP__MAX];
-	unsigned int dpte_row_height_luma_one_row_per_frame[DC__NUM_DPP__MAX];
-	unsigned int dpte_row_width_chroma_ub_one_row_per_frame[DC__NUM_DPP__MAX];
-	unsigned int dpte_row_height_chroma_one_row_per_frame[DC__NUM_DPP__MAX];
-	bool one_row_per_frame_fits_in_buffer[DC__NUM_DPP__MAX];
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (HostVMEnable == true) {
@@ -1968,15 +1954,15 @@ void dml32_CalculateVMRowAndSwath(
 				myPipe[k].SourcePixelFormat == dm_rgbe_alpha) {
 			if ((myPipe[k].SourcePixelFormat == dm_420_10 || myPipe[k].SourcePixelFormat == dm_420_12) &&
 					!IsVertical(myPipe[k].SourceRotation)) {
-				PTEBufferSizeInRequestsForLuma[k] =
+				st_vars->PTEBufferSizeInRequestsForLuma[k] =
 						(PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma) / 2;
-				PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsForLuma[k];
+				st_vars->PTEBufferSizeInRequestsForChroma[k] = st_vars->PTEBufferSizeInRequestsForLuma[k];
 			} else {
-				PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma;
-				PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsChroma;
+				st_vars->PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma;
+				st_vars->PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsChroma;
 			}
 
-			PDEAndMetaPTEBytesFrameC = dml32_CalculateVMAndRowBytes(
+			st_vars->PDEAndMetaPTEBytesFrameC = dml32_CalculateVMAndRowBytes(
 					myPipe[k].ViewportStationary,
 					myPipe[k].DCCEnable,
 					myPipe[k].DPPPerSurface,
@@ -1996,21 +1982,21 @@ void dml32_CalculateVMRowAndSwath(
 					GPUVMMaxPageTableLevels,
 					GPUVMMinPageSizeKBytes[k],
 					HostVMMinPageSize,
-					PTEBufferSizeInRequestsForChroma[k],
+					st_vars->PTEBufferSizeInRequestsForChroma[k],
 					myPipe[k].PitchC,
 					myPipe[k].DCCMetaPitchC,
 					myPipe[k].BlockWidthC,
 					myPipe[k].BlockHeightC,
 
 					/* Output */
-					&MetaRowByteC[k],
-					&PixelPTEBytesPerRowC[k],
+					&st_vars->MetaRowByteC[k],
+					&st_vars->PixelPTEBytesPerRowC[k],
 					&dpte_row_width_chroma_ub[k],
 					&dpte_row_height_chroma[k],
 					&dpte_row_height_linear_chroma[k],
-					&PixelPTEBytesPerRowC_one_row_per_frame[k],
-					&dpte_row_width_chroma_ub_one_row_per_frame[k],
-					&dpte_row_height_chroma_one_row_per_frame[k],
+					&st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k],
+					&st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k],
+					&st_vars->dpte_row_height_chroma_one_row_per_frame[k],
 					&meta_req_width_chroma[k],
 					&meta_req_height_chroma[k],
 					&meta_row_width_chroma[k],
@@ -2038,19 +2024,19 @@ void dml32_CalculateVMRowAndSwath(
 					&VInitPreFillC[k],
 					&MaxNumSwathC[k]);
 		} else {
-			PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma;
-			PTEBufferSizeInRequestsForChroma[k] = 0;
-			PixelPTEBytesPerRowC[k] = 0;
-			PDEAndMetaPTEBytesFrameC = 0;
-			MetaRowByteC[k] = 0;
+			st_vars->PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma;
+			st_vars->PTEBufferSizeInRequestsForChroma[k] = 0;
+			st_vars->PixelPTEBytesPerRowC[k] = 0;
+			st_vars->PDEAndMetaPTEBytesFrameC = 0;
+			st_vars->MetaRowByteC[k] = 0;
 			MaxNumSwathC[k] = 0;
 			PrefetchSourceLinesC[k] = 0;
-			dpte_row_height_chroma_one_row_per_frame[k] = 0;
-			dpte_row_width_chroma_ub_one_row_per_frame[k] = 0;
-			PixelPTEBytesPerRowC_one_row_per_frame[k] = 0;
+			st_vars->dpte_row_height_chroma_one_row_per_frame[k] = 0;
+			st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k] = 0;
+			st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k] = 0;
 		}
 
-		PDEAndMetaPTEBytesFrameY = dml32_CalculateVMAndRowBytes(
+		st_vars->PDEAndMetaPTEBytesFrameY = dml32_CalculateVMAndRowBytes(
 				myPipe[k].ViewportStationary,
 				myPipe[k].DCCEnable,
 				myPipe[k].DPPPerSurface,
@@ -2070,21 +2056,21 @@ void dml32_CalculateVMRowAndSwath(
 				GPUVMMaxPageTableLevels,
 				GPUVMMinPageSizeKBytes[k],
 				HostVMMinPageSize,
-				PTEBufferSizeInRequestsForLuma[k],
+				st_vars->PTEBufferSizeInRequestsForLuma[k],
 				myPipe[k].PitchY,
 				myPipe[k].DCCMetaPitchY,
 				myPipe[k].BlockWidthY,
 				myPipe[k].BlockHeightY,
 
 				/* Output */
-				&MetaRowByteY[k],
-				&PixelPTEBytesPerRowY[k],
+				&st_vars->MetaRowByteY[k],
+				&st_vars->PixelPTEBytesPerRowY[k],
 				&dpte_row_width_luma_ub[k],
 				&dpte_row_height_luma[k],
 				&dpte_row_height_linear_luma[k],
-				&PixelPTEBytesPerRowY_one_row_per_frame[k],
-				&dpte_row_width_luma_ub_one_row_per_frame[k],
-				&dpte_row_height_luma_one_row_per_frame[k],
+				&st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k],
+				&st_vars->dpte_row_width_luma_ub_one_row_per_frame[k],
+				&st_vars->dpte_row_height_luma_one_row_per_frame[k],
 				&meta_req_width[k],
 				&meta_req_height[k],
 				&meta_row_width[k],
@@ -2112,19 +2098,19 @@ void dml32_CalculateVMRowAndSwath(
 				&VInitPreFillY[k],
 				&MaxNumSwathY[k]);
 
-		PDEAndMetaPTEBytesFrame[k] = PDEAndMetaPTEBytesFrameY + PDEAndMetaPTEBytesFrameC;
-		MetaRowByte[k] = MetaRowByteY[k] + MetaRowByteC[k];
+		PDEAndMetaPTEBytesFrame[k] = st_vars->PDEAndMetaPTEBytesFrameY + st_vars->PDEAndMetaPTEBytesFrameC;
+		MetaRowByte[k] = st_vars->MetaRowByteY[k] + st_vars->MetaRowByteC[k];
 
-		if (PixelPTEBytesPerRowY[k] <= 64 * PTEBufferSizeInRequestsForLuma[k] &&
-				PixelPTEBytesPerRowC[k] <= 64 * PTEBufferSizeInRequestsForChroma[k]) {
+		if (st_vars->PixelPTEBytesPerRowY[k] <= 64 * st_vars->PTEBufferSizeInRequestsForLuma[k] &&
+				st_vars->PixelPTEBytesPerRowC[k] <= 64 * st_vars->PTEBufferSizeInRequestsForChroma[k]) {
 			PTEBufferSizeNotExceeded[k] = true;
 		} else {
 			PTEBufferSizeNotExceeded[k] = false;
 		}
 
-		one_row_per_frame_fits_in_buffer[k] = (PixelPTEBytesPerRowY_one_row_per_frame[k] <= 64 * 2 *
-			PTEBufferSizeInRequestsForLuma[k] &&
-			PixelPTEBytesPerRowC_one_row_per_frame[k] <= 64 * 2 * PTEBufferSizeInRequestsForChroma[k]);
+		st_vars->one_row_per_frame_fits_in_buffer[k] = (st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k] <= 64 * 2 *
+			st_vars->PTEBufferSizeInRequestsForLuma[k] &&
+			st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k] <= 64 * 2 * st_vars->PTEBufferSizeInRequestsForChroma[k]);
 	}
 
 	dml32_CalculateMALLUseForStaticScreen(
@@ -2132,7 +2118,7 @@ void dml32_CalculateVMRowAndSwath(
 			MALLAllocatedForDCN,
 			UseMALLForStaticScreen,   // mode
 			SurfaceSizeInMALL,
-			one_row_per_frame_fits_in_buffer,
+			st_vars->one_row_per_frame_fits_in_buffer,
 			/* Output */
 			UsesMALLForStaticScreen); // boolen
 
@@ -2158,13 +2144,13 @@ void dml32_CalculateVMRowAndSwath(
 				!(UseMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame);
 
 		if (use_one_row_for_frame[k]) {
-			dpte_row_height_luma[k] = dpte_row_height_luma_one_row_per_frame[k];
-			dpte_row_width_luma_ub[k] = dpte_row_width_luma_ub_one_row_per_frame[k];
-			PixelPTEBytesPerRowY[k] = PixelPTEBytesPerRowY_one_row_per_frame[k];
-			dpte_row_height_chroma[k] = dpte_row_height_chroma_one_row_per_frame[k];
-			dpte_row_width_chroma_ub[k] = dpte_row_width_chroma_ub_one_row_per_frame[k];
-			PixelPTEBytesPerRowC[k] = PixelPTEBytesPerRowC_one_row_per_frame[k];
-			PTEBufferSizeNotExceeded[k] = one_row_per_frame_fits_in_buffer[k];
+			dpte_row_height_luma[k] = st_vars->dpte_row_height_luma_one_row_per_frame[k];
+			dpte_row_width_luma_ub[k] = st_vars->dpte_row_width_luma_ub_one_row_per_frame[k];
+			st_vars->PixelPTEBytesPerRowY[k] = st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k];
+			dpte_row_height_chroma[k] = st_vars->dpte_row_height_chroma_one_row_per_frame[k];
+			dpte_row_width_chroma_ub[k] = st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k];
+			st_vars->PixelPTEBytesPerRowC[k] = st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k];
+			PTEBufferSizeNotExceeded[k] = st_vars->one_row_per_frame_fits_in_buffer[k];
 		}
 
 		if (MetaRowByte[k] <= DCCMetaBufferSizeBytes)
@@ -2172,7 +2158,7 @@ void dml32_CalculateVMRowAndSwath(
 		else
 			DCCMetaBufferSizeNotExceeded[k] = false;
 
-		PixelPTEBytesPerRow[k] = PixelPTEBytesPerRowY[k] + PixelPTEBytesPerRowC[k];
+		PixelPTEBytesPerRow[k] = st_vars->PixelPTEBytesPerRowY[k] + st_vars->PixelPTEBytesPerRowC[k];
 		if (use_one_row_for_frame[k])
 			PixelPTEBytesPerRow[k] = PixelPTEBytesPerRow[k] / 2;
 
@@ -2183,11 +2169,11 @@ void dml32_CalculateVMRowAndSwath(
 				myPipe[k].VRatioChroma,
 				myPipe[k].DCCEnable,
 				myPipe[k].HTotal / myPipe[k].PixelClock,
-				MetaRowByteY[k], MetaRowByteC[k],
+				st_vars->MetaRowByteY[k], st_vars->MetaRowByteC[k],
 				meta_row_height[k],
 				meta_row_height_chroma[k],
-				PixelPTEBytesPerRowY[k],
-				PixelPTEBytesPerRowC[k],
+				st_vars->PixelPTEBytesPerRowY[k],
+				st_vars->PixelPTEBytesPerRowC[k],
 				dpte_row_height_luma[k],
 				dpte_row_height_chroma[k],
 
@@ -2203,12 +2189,12 @@ void dml32_CalculateVMRowAndSwath(
 		dml_print("DML::%s: k=%d, dpte_row_height_luma         = %d\n",  __func__, k, dpte_row_height_luma[k]);
 		dml_print("DML::%s: k=%d, dpte_row_width_luma_ub       = %d\n",
 				__func__, k, dpte_row_width_luma_ub[k]);
-		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowY         = %d\n",  __func__, k, PixelPTEBytesPerRowY[k]);
+		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowY         = %d\n",  __func__, k, st_vars->PixelPTEBytesPerRowY[k]);
 		dml_print("DML::%s: k=%d, dpte_row_height_chroma       = %d\n",
 				__func__, k, dpte_row_height_chroma[k]);
 		dml_print("DML::%s: k=%d, dpte_row_width_chroma_ub     = %d\n",
 				__func__, k, dpte_row_width_chroma_ub[k]);
-		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowC         = %d\n",  __func__, k, PixelPTEBytesPerRowC[k]);
+		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowC         = %d\n",  __func__, k, st_vars->PixelPTEBytesPerRowC[k]);
 		dml_print("DML::%s: k=%d, PixelPTEBytesPerRow          = %d\n",  __func__, k, PixelPTEBytesPerRow[k]);
 		dml_print("DML::%s: k=%d, PTEBufferSizeNotExceeded     = %d\n",
 				__func__, k, PTEBufferSizeNotExceeded[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 158cfa2af1af..974006e5ecb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -362,6 +362,7 @@ void dml32_CalculateSurfaceSizeInMall(
 		bool *ExceededMALLSize);
 
 void dml32_CalculateVMRowAndSwath(
+		struct dml32_CalculateVMRowAndSwath *st_vars,
 		unsigned int NumberOfActiveSurfaces,
 		DmlPipe myPipe[],
 		unsigned int SurfaceSizeInMALL[],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 6cf814c2cc8d..b326184cfa4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -196,6 +196,24 @@ struct dml32_CalculateSwathAndDETConfiguration {
 	unsigned int DETBufferSizeInKByteForSwathCalculation;
 };
 
+struct dml32_CalculateVMRowAndSwath {
+	unsigned int PTEBufferSizeInRequestsForLuma[DC__NUM_DPP__MAX];
+	unsigned int PTEBufferSizeInRequestsForChroma[DC__NUM_DPP__MAX];
+	unsigned int PDEAndMetaPTEBytesFrameY;
+	unsigned int PDEAndMetaPTEBytesFrameC;
+	unsigned int MetaRowByteY[DC__NUM_DPP__MAX];
+	unsigned int MetaRowByteC[DC__NUM_DPP__MAX];
+	unsigned int PixelPTEBytesPerRowY[DC__NUM_DPP__MAX];
+	unsigned int PixelPTEBytesPerRowC[DC__NUM_DPP__MAX];
+	unsigned int PixelPTEBytesPerRowY_one_row_per_frame[DC__NUM_DPP__MAX];
+	unsigned int PixelPTEBytesPerRowC_one_row_per_frame[DC__NUM_DPP__MAX];
+	unsigned int dpte_row_width_luma_ub_one_row_per_frame[DC__NUM_DPP__MAX];
+	unsigned int dpte_row_height_luma_one_row_per_frame[DC__NUM_DPP__MAX];
+	unsigned int dpte_row_width_chroma_ub_one_row_per_frame[DC__NUM_DPP__MAX];
+	unsigned int dpte_row_height_chroma_one_row_per_frame[DC__NUM_DPP__MAX];
+	bool one_row_per_frame_fits_in_buffer[DC__NUM_DPP__MAX];
+};
+
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -268,6 +286,7 @@ struct dummy_vars {
 	DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
 	struct dml32_ModeSupportAndSystemConfigurationFull dml32_ModeSupportAndSystemConfigurationFull;
 	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
+	struct dml32_CalculateVMRowAndSwath dml32_CalculateVMRowAndSwath;
 };
 
 struct vba_vars_st {
-- 
2.35.3

