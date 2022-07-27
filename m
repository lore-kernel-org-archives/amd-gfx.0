Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E608DC19F29
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A2EC7B89;
	Wed, 27 Jul 2022 22:19:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29962C7B34
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxDsqekMxXCLmvL0pgYoXu+qVcNifbDK7vtty0AU/xi5UDRsSg7c4ezIHBEPPrHmR6TSBWqGpc9cPV9YdS4dLfnzalamJBxBqNz+8nDwzyhe3veUc6N7k2ntdJbqXnLzVT8J3Avs8Y6SAtBcLspu9L4bIlIknGJpsOvR3Dp2DimxcYFCLjTD61p12sWiGJ12Yxu5PnaYPDOX7LY8R/Ga0ECFGKoKMovxprLgbX61mSFxsLTuCg+aEJhx1CqxryqOzpHi/YCvfrwSTOBR850LMPleRWvcLNpjJiT2Cvl6hf9R0laMrZdGminSaYs0Wv87jN+zMoYOVOetWi4Xq9Vi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMQIuvawa1YEIxB4U5305GEwJsgkDo7qNmszQeig9H4=;
 b=DXJk+hlsuoLkS4HE+54s8A16AyFUGMtNzuk5T3Wta/OzbKRlzs/b4aw+hR8zWSk5wRx3qkcl6U87O0dBozrrISMWSrFdE73HEBDjywTdFxEao4t6Yoa7Z861kumNTEo+eks2BnO33ZRhcVWRTTGlLoObFblsC8ChcbT5mWQS7Fh77gACSpWQq/0DMzMKRr8waBs2kCrhQWDD+W9oqFka3Zr4zU+P/nDMF2655WS5rtnJzDBPQ9oBL0PwdGUp03pXIg3rEJmRcy6sP4RenOpxWmJ6RxpylZLRwmP5BObCKzGdr67iKLTqpO+x87Yvp2Bgyvm5Kwl8rs6oTXwQjwKpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMQIuvawa1YEIxB4U5305GEwJsgkDo7qNmszQeig9H4=;
 b=wpn7OiG0NzyVEgQ64MqJV+aptWLuHcwldtlUDgRMCPi0gmunXyJMC5ibK17CST8C5Ybm9t1G+kdoymdJ/zBpEfGrqonWp0hq0PTs1nPAHorZ9rQtTRYiYmLTxqZP37uBCIshnJnWvG4jVbvyeKtvy8O0cSUVuShd/EeWPvAHdWw=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 22:19:25 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::f) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 22:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 22:19:24 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 17:19:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] Revert "drm/amd/display: reduce stack for
 dml32_CalculateVMRowAndSwath"
Date: Wed, 27 Jul 2022 18:18:54 -0400
Message-ID: <20220727221855.324361-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
References: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89b1656a-f424-46dc-0e53-08da701e104c
X-MS-TrafficTypeDiagnostic: PH7PR12MB5618:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDmY4bEU5kkoOEMqnDW0m71me0Q1vJ5AuRpwkQ0wl+xrK3iGE/ABuR9hzC4G58Nfsl2V/FqpekcX3014JH/IbIPoreQiIpWunBcHwAQDdmqpqbZo5eLksaBTqnPNtfERLCVdU9uopV4gDtB3X8RHzKnS10vjwrLXuWP1RDfJt7GLfvyCouxn0y5W17fAcsHmqIrd1hoxIR0uWXL/9+rKkPF7467Ee7yPgG5lyrEsirVZfwp3UXPQEbMWh1V1HcKGB3nNHrY12U4jI0DANRZANlOgX1Cl/G2rGY2SopzgvVXOy/7V7Z9wXCpQXfzXRpJ5m4SNlkhYExkUniZWlIw4j1FDZtW694P48Vv8qMJtbA8RD9oF56SJZRDao/LaxMqaXiS67LjrekoAVz/YY/s7t9P503T/Qt3CtyOFxtkgiiiISn3IeIJx4ArPbuz3OSK6krOjAvHzzhtIwd0o0avZUgw7rlRE1Ji5nLR08e/0Q/VJYWMsuIl/LiSvwm6POg/BKzKu1df2N6zNOjL9SAbBS75XIvS/3JyT5K7VtFnHZf7kJhBKiQNIyx6YornzJfcvpl73zE/z8jfFeeGOGU3XHvQCDKAQPPwi8wAx6RCyTmocACeuld4lWpkvg6vJC5c7a/UzJDBwxVA2/3WJitTwGgVuh6RzGJ8iZilHTo7AXVD9kczyWv5pTP5GtHrNf5mQJReyX7+IoPNs3vSo/oabpC3lRuG+ysgal+gBw0Wb8cpOQMKvEmqBV+YzrXfesqiQx6Y1LSxySkpslX3dGUDFscYgcKN5lEUzJ5SMP6mhhMH0qx2vxSslcNRXJulrabCPBiv9zwbxw/ZGf4kDg4JzAWzFm+9yERB6bl0RC3BjtZQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(30864003)(426003)(1076003)(316002)(36860700001)(40460700003)(19627235002)(186003)(356005)(4326008)(8936002)(16526019)(5660300002)(6916009)(336012)(2906002)(41300700001)(70586007)(81166007)(26005)(47076005)(2616005)(83380400001)(40480700001)(8676002)(6666004)(7696005)(54906003)(82740400003)(82310400005)(86362001)(478600001)(36756003)(70206006)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:19:24.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b1656a-f424-46dc-0e53-08da701e104c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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
Cc: Leo Li <sunpeng.li@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit a0a68cda2ef8446b55d1b0baa8c352812639b196.

This commit was a part of a patchset responsible for reducing the stack
size. However, after some other changes, this commit becomes
unnecessary, so we are reverting it here.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 110 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  19 ---
 4 files changed, 62 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 55f351d5b610..3cfd3cc4d60c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -461,7 +461,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 	{
 
 		dml32_CalculateVMRowAndSwath(
-				&v->dummy_vars.dml32_CalculateVMRowAndSwath,
 				mode_lib->vba.NumberOfActiveSurfaces,
 				v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.SurfaceParameters,
 				v->SurfaceSizeInMALL,
@@ -2746,7 +2745,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 			{
 				dml32_CalculateVMRowAndSwath(
-						&v->dummy_vars.dml32_CalculateVMRowAndSwath,
 						mode_lib->vba.NumberOfActiveSurfaces,
 						v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.SurfParameters,
 						mode_lib->vba.SurfaceSizeInMALL,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index c0dab2b2c446..f9adfd7371dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1867,7 +1867,6 @@ void dml32_CalculateSurfaceSizeInMall(
 } // CalculateSurfaceSizeInMall
 
 void dml32_CalculateVMRowAndSwath(
-		struct dml32_CalculateVMRowAndSwath *st_vars,
 		unsigned int NumberOfActiveSurfaces,
 		DmlPipe myPipe[],
 		unsigned int SurfaceSizeInMALL[],
@@ -1933,6 +1932,21 @@ void dml32_CalculateVMRowAndSwath(
 		unsigned int BIGK_FRAGMENT_SIZE[])
 {
 	unsigned int k;
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
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (HostVMEnable == true) {
@@ -1954,15 +1968,15 @@ void dml32_CalculateVMRowAndSwath(
 				myPipe[k].SourcePixelFormat == dm_rgbe_alpha) {
 			if ((myPipe[k].SourcePixelFormat == dm_420_10 || myPipe[k].SourcePixelFormat == dm_420_12) &&
 					!IsVertical(myPipe[k].SourceRotation)) {
-				st_vars->PTEBufferSizeInRequestsForLuma[k] =
+				PTEBufferSizeInRequestsForLuma[k] =
 						(PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma) / 2;
-				st_vars->PTEBufferSizeInRequestsForChroma[k] = st_vars->PTEBufferSizeInRequestsForLuma[k];
+				PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsForLuma[k];
 			} else {
-				st_vars->PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma;
-				st_vars->PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsChroma;
+				PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma;
+				PTEBufferSizeInRequestsForChroma[k] = PTEBufferSizeInRequestsChroma;
 			}
 
-			st_vars->PDEAndMetaPTEBytesFrameC = dml32_CalculateVMAndRowBytes(
+			PDEAndMetaPTEBytesFrameC = dml32_CalculateVMAndRowBytes(
 					myPipe[k].ViewportStationary,
 					myPipe[k].DCCEnable,
 					myPipe[k].DPPPerSurface,
@@ -1982,21 +1996,21 @@ void dml32_CalculateVMRowAndSwath(
 					GPUVMMaxPageTableLevels,
 					GPUVMMinPageSizeKBytes[k],
 					HostVMMinPageSize,
-					st_vars->PTEBufferSizeInRequestsForChroma[k],
+					PTEBufferSizeInRequestsForChroma[k],
 					myPipe[k].PitchC,
 					myPipe[k].DCCMetaPitchC,
 					myPipe[k].BlockWidthC,
 					myPipe[k].BlockHeightC,
 
 					/* Output */
-					&st_vars->MetaRowByteC[k],
-					&st_vars->PixelPTEBytesPerRowC[k],
+					&MetaRowByteC[k],
+					&PixelPTEBytesPerRowC[k],
 					&dpte_row_width_chroma_ub[k],
 					&dpte_row_height_chroma[k],
 					&dpte_row_height_linear_chroma[k],
-					&st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k],
-					&st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k],
-					&st_vars->dpte_row_height_chroma_one_row_per_frame[k],
+					&PixelPTEBytesPerRowC_one_row_per_frame[k],
+					&dpte_row_width_chroma_ub_one_row_per_frame[k],
+					&dpte_row_height_chroma_one_row_per_frame[k],
 					&meta_req_width_chroma[k],
 					&meta_req_height_chroma[k],
 					&meta_row_width_chroma[k],
@@ -2024,19 +2038,19 @@ void dml32_CalculateVMRowAndSwath(
 					&VInitPreFillC[k],
 					&MaxNumSwathC[k]);
 		} else {
-			st_vars->PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma;
-			st_vars->PTEBufferSizeInRequestsForChroma[k] = 0;
-			st_vars->PixelPTEBytesPerRowC[k] = 0;
-			st_vars->PDEAndMetaPTEBytesFrameC = 0;
-			st_vars->MetaRowByteC[k] = 0;
+			PTEBufferSizeInRequestsForLuma[k] = PTEBufferSizeInRequestsLuma + PTEBufferSizeInRequestsChroma;
+			PTEBufferSizeInRequestsForChroma[k] = 0;
+			PixelPTEBytesPerRowC[k] = 0;
+			PDEAndMetaPTEBytesFrameC = 0;
+			MetaRowByteC[k] = 0;
 			MaxNumSwathC[k] = 0;
 			PrefetchSourceLinesC[k] = 0;
-			st_vars->dpte_row_height_chroma_one_row_per_frame[k] = 0;
-			st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k] = 0;
-			st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k] = 0;
+			dpte_row_height_chroma_one_row_per_frame[k] = 0;
+			dpte_row_width_chroma_ub_one_row_per_frame[k] = 0;
+			PixelPTEBytesPerRowC_one_row_per_frame[k] = 0;
 		}
 
-		st_vars->PDEAndMetaPTEBytesFrameY = dml32_CalculateVMAndRowBytes(
+		PDEAndMetaPTEBytesFrameY = dml32_CalculateVMAndRowBytes(
 				myPipe[k].ViewportStationary,
 				myPipe[k].DCCEnable,
 				myPipe[k].DPPPerSurface,
@@ -2056,21 +2070,21 @@ void dml32_CalculateVMRowAndSwath(
 				GPUVMMaxPageTableLevels,
 				GPUVMMinPageSizeKBytes[k],
 				HostVMMinPageSize,
-				st_vars->PTEBufferSizeInRequestsForLuma[k],
+				PTEBufferSizeInRequestsForLuma[k],
 				myPipe[k].PitchY,
 				myPipe[k].DCCMetaPitchY,
 				myPipe[k].BlockWidthY,
 				myPipe[k].BlockHeightY,
 
 				/* Output */
-				&st_vars->MetaRowByteY[k],
-				&st_vars->PixelPTEBytesPerRowY[k],
+				&MetaRowByteY[k],
+				&PixelPTEBytesPerRowY[k],
 				&dpte_row_width_luma_ub[k],
 				&dpte_row_height_luma[k],
 				&dpte_row_height_linear_luma[k],
-				&st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k],
-				&st_vars->dpte_row_width_luma_ub_one_row_per_frame[k],
-				&st_vars->dpte_row_height_luma_one_row_per_frame[k],
+				&PixelPTEBytesPerRowY_one_row_per_frame[k],
+				&dpte_row_width_luma_ub_one_row_per_frame[k],
+				&dpte_row_height_luma_one_row_per_frame[k],
 				&meta_req_width[k],
 				&meta_req_height[k],
 				&meta_row_width[k],
@@ -2098,19 +2112,19 @@ void dml32_CalculateVMRowAndSwath(
 				&VInitPreFillY[k],
 				&MaxNumSwathY[k]);
 
-		PDEAndMetaPTEBytesFrame[k] = st_vars->PDEAndMetaPTEBytesFrameY + st_vars->PDEAndMetaPTEBytesFrameC;
-		MetaRowByte[k] = st_vars->MetaRowByteY[k] + st_vars->MetaRowByteC[k];
+		PDEAndMetaPTEBytesFrame[k] = PDEAndMetaPTEBytesFrameY + PDEAndMetaPTEBytesFrameC;
+		MetaRowByte[k] = MetaRowByteY[k] + MetaRowByteC[k];
 
-		if (st_vars->PixelPTEBytesPerRowY[k] <= 64 * st_vars->PTEBufferSizeInRequestsForLuma[k] &&
-				st_vars->PixelPTEBytesPerRowC[k] <= 64 * st_vars->PTEBufferSizeInRequestsForChroma[k]) {
+		if (PixelPTEBytesPerRowY[k] <= 64 * PTEBufferSizeInRequestsForLuma[k] &&
+				PixelPTEBytesPerRowC[k] <= 64 * PTEBufferSizeInRequestsForChroma[k]) {
 			PTEBufferSizeNotExceeded[k] = true;
 		} else {
 			PTEBufferSizeNotExceeded[k] = false;
 		}
 
-		st_vars->one_row_per_frame_fits_in_buffer[k] = (st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k] <= 64 * 2 *
-			st_vars->PTEBufferSizeInRequestsForLuma[k] &&
-			st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k] <= 64 * 2 * st_vars->PTEBufferSizeInRequestsForChroma[k]);
+		one_row_per_frame_fits_in_buffer[k] = (PixelPTEBytesPerRowY_one_row_per_frame[k] <= 64 * 2 *
+			PTEBufferSizeInRequestsForLuma[k] &&
+			PixelPTEBytesPerRowC_one_row_per_frame[k] <= 64 * 2 * PTEBufferSizeInRequestsForChroma[k]);
 	}
 
 	dml32_CalculateMALLUseForStaticScreen(
@@ -2118,7 +2132,7 @@ void dml32_CalculateVMRowAndSwath(
 			MALLAllocatedForDCN,
 			UseMALLForStaticScreen,   // mode
 			SurfaceSizeInMALL,
-			st_vars->one_row_per_frame_fits_in_buffer,
+			one_row_per_frame_fits_in_buffer,
 			/* Output */
 			UsesMALLForStaticScreen); // boolen
 
@@ -2144,13 +2158,13 @@ void dml32_CalculateVMRowAndSwath(
 				!(UseMALLForPStateChange[k] == dm_use_mall_pstate_change_full_frame);
 
 		if (use_one_row_for_frame[k]) {
-			dpte_row_height_luma[k] = st_vars->dpte_row_height_luma_one_row_per_frame[k];
-			dpte_row_width_luma_ub[k] = st_vars->dpte_row_width_luma_ub_one_row_per_frame[k];
-			st_vars->PixelPTEBytesPerRowY[k] = st_vars->PixelPTEBytesPerRowY_one_row_per_frame[k];
-			dpte_row_height_chroma[k] = st_vars->dpte_row_height_chroma_one_row_per_frame[k];
-			dpte_row_width_chroma_ub[k] = st_vars->dpte_row_width_chroma_ub_one_row_per_frame[k];
-			st_vars->PixelPTEBytesPerRowC[k] = st_vars->PixelPTEBytesPerRowC_one_row_per_frame[k];
-			PTEBufferSizeNotExceeded[k] = st_vars->one_row_per_frame_fits_in_buffer[k];
+			dpte_row_height_luma[k] = dpte_row_height_luma_one_row_per_frame[k];
+			dpte_row_width_luma_ub[k] = dpte_row_width_luma_ub_one_row_per_frame[k];
+			PixelPTEBytesPerRowY[k] = PixelPTEBytesPerRowY_one_row_per_frame[k];
+			dpte_row_height_chroma[k] = dpte_row_height_chroma_one_row_per_frame[k];
+			dpte_row_width_chroma_ub[k] = dpte_row_width_chroma_ub_one_row_per_frame[k];
+			PixelPTEBytesPerRowC[k] = PixelPTEBytesPerRowC_one_row_per_frame[k];
+			PTEBufferSizeNotExceeded[k] = one_row_per_frame_fits_in_buffer[k];
 		}
 
 		if (MetaRowByte[k] <= DCCMetaBufferSizeBytes)
@@ -2158,7 +2172,7 @@ void dml32_CalculateVMRowAndSwath(
 		else
 			DCCMetaBufferSizeNotExceeded[k] = false;
 
-		PixelPTEBytesPerRow[k] = st_vars->PixelPTEBytesPerRowY[k] + st_vars->PixelPTEBytesPerRowC[k];
+		PixelPTEBytesPerRow[k] = PixelPTEBytesPerRowY[k] + PixelPTEBytesPerRowC[k];
 		if (use_one_row_for_frame[k])
 			PixelPTEBytesPerRow[k] = PixelPTEBytesPerRow[k] / 2;
 
@@ -2169,11 +2183,11 @@ void dml32_CalculateVMRowAndSwath(
 				myPipe[k].VRatioChroma,
 				myPipe[k].DCCEnable,
 				myPipe[k].HTotal / myPipe[k].PixelClock,
-				st_vars->MetaRowByteY[k], st_vars->MetaRowByteC[k],
+				MetaRowByteY[k], MetaRowByteC[k],
 				meta_row_height[k],
 				meta_row_height_chroma[k],
-				st_vars->PixelPTEBytesPerRowY[k],
-				st_vars->PixelPTEBytesPerRowC[k],
+				PixelPTEBytesPerRowY[k],
+				PixelPTEBytesPerRowC[k],
 				dpte_row_height_luma[k],
 				dpte_row_height_chroma[k],
 
@@ -2189,12 +2203,12 @@ void dml32_CalculateVMRowAndSwath(
 		dml_print("DML::%s: k=%d, dpte_row_height_luma         = %d\n",  __func__, k, dpte_row_height_luma[k]);
 		dml_print("DML::%s: k=%d, dpte_row_width_luma_ub       = %d\n",
 				__func__, k, dpte_row_width_luma_ub[k]);
-		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowY         = %d\n",  __func__, k, st_vars->PixelPTEBytesPerRowY[k]);
+		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowY         = %d\n",  __func__, k, PixelPTEBytesPerRowY[k]);
 		dml_print("DML::%s: k=%d, dpte_row_height_chroma       = %d\n",
 				__func__, k, dpte_row_height_chroma[k]);
 		dml_print("DML::%s: k=%d, dpte_row_width_chroma_ub     = %d\n",
 				__func__, k, dpte_row_width_chroma_ub[k]);
-		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowC         = %d\n",  __func__, k, st_vars->PixelPTEBytesPerRowC[k]);
+		dml_print("DML::%s: k=%d, PixelPTEBytesPerRowC         = %d\n",  __func__, k, PixelPTEBytesPerRowC[k]);
 		dml_print("DML::%s: k=%d, PixelPTEBytesPerRow          = %d\n",  __func__, k, PixelPTEBytesPerRow[k]);
 		dml_print("DML::%s: k=%d, PTEBufferSizeNotExceeded     = %d\n",
 				__func__, k, PTEBufferSizeNotExceeded[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 974006e5ecb7..158cfa2af1af 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -362,7 +362,6 @@ void dml32_CalculateSurfaceSizeInMall(
 		bool *ExceededMALLSize);
 
 void dml32_CalculateVMRowAndSwath(
-		struct dml32_CalculateVMRowAndSwath *st_vars,
 		unsigned int NumberOfActiveSurfaces,
 		DmlPipe myPipe[],
 		unsigned int SurfaceSizeInMALL[],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index b326184cfa4a..6cf814c2cc8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -196,24 +196,6 @@ struct dml32_CalculateSwathAndDETConfiguration {
 	unsigned int DETBufferSizeInKByteForSwathCalculation;
 };
 
-struct dml32_CalculateVMRowAndSwath {
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
-};
-
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -286,7 +268,6 @@ struct dummy_vars {
 	DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
 	struct dml32_ModeSupportAndSystemConfigurationFull dml32_ModeSupportAndSystemConfigurationFull;
 	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
-	struct dml32_CalculateVMRowAndSwath dml32_CalculateVMRowAndSwath;
 };
 
 struct vba_vars_st {
-- 
2.35.1

