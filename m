Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC4AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 05:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B47211ABA1;
	Thu, 21 Jul 2022 05:13:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0357111AB90
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 05:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRLhtWnLa3nHX824cbdavWWdtdwiM5/+SrC2EkK5Sxmls/VaB8Gs1CvdJfUusYDYO/hwgETVVaJfrQkblMKjDYkUFgSOH8PmFrx9BgDTQ+GpxFWNYVAxSzGxFF+IEolbMY7HVYZFpdcMRCkErJHigHVKFctJrgDvjbwIc//Dx5sjxAns3ZWIH/u/kM5JNSJtYEhCWoc2imDfkStXDasJ/0vnQJyDFUgD9BvFL8MrFSgy3e9uXfQSiZ17m1GjHoXWh4tOxFPR9sQvMDnLOMKuEpFLOqK537JaOo1Ff1kmsDOaJJ6mhqHhiKlKs4T7BcgTH3dMs3W3s74YCNkBSn2yaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GePGfPfyA+NoRC71dnhEVRQJ2o6VKSBfNblftrIkDqc=;
 b=S6ex5fKG128SNbxDl4oRj1qqfjdsTVWy7Uj0RYIlFF9b12LsLXjbNR6bV/drkMh+4DmWNL5inpO9OAKe86dvT7LyZw8HVmsXCJ9VLNu8gWwzEX94YBf+FvaKJhWp52i41ijuH8rZo4OqoeTJ4jL+fEG2mGkhPPwz/BYyN8RChkAFfM/4ExV8tV1055Zhw0vJJd/XEN5lHHzC2SV/2/rylaHGC5hIgN9aIz1oZAbcQqtvbYu0L/pKonZpSxPyEysrggVYyNUor+YbKof5A2uxOEoziPWuEyUEouHV3TRgbF1caJJn8N0stEppPx6O4uMEuI7PLP7l1KvvU0zTerAv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GePGfPfyA+NoRC71dnhEVRQJ2o6VKSBfNblftrIkDqc=;
 b=KED0Z7sITniOX5FIeEqJR9k21Bd1qZkWWxvVujWzjo/l0RDK3nvuhuClukRraMHydJ1+nuDWvKSJ0zJO9vXI1YRpQVB7LMtJ34aaZDBhEyQoSvtHtYlN6YTJQT9NbC5OQ7kZx9bj9zMm3t/RzDAVddOardaNQLSoQveJ8QHHvyg=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Thu, 21 Jul 2022 05:13:24 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::93) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
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
 2022 00:13:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/display: reduce stack for
 dml32_CalculateSwathAndDETConfiguration
Date: Thu, 21 Jul 2022 01:13:02 -0400
Message-ID: <20220721051305.1356754-2-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b651736-26ce-43ae-c860-08da6ad7bcb1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h525oJPkLwtcmtd70M729Yvtjcjb+pm7waGP8uvHk84TiJCV7ujwwgBNk6dj8LlGGlLIbm3CrrUK6E+Dci6jyB15qpSsADoAxMA2EI/4U+lFjt2cxcEIXS6i7Ds+xM7mNzEI1XQZwnWnszoayRQnQmri8aCxRZOY6BtoF4bbvQdODDfv6NTBiadUpLZ/w/vmlLTIvVM2HISgNQYpxWmXDL8UnDHPzPj1sUKjTx620pkI3Iyf760y5OpLyUiv9HlnJtQRxqvCHGh0V54/z2VeA1FZi/MBgKpH7KJkTyryVZIrbH3iS60tU4Y86ekNd9Ju0sMH5Tgj7pUoBD3IGGY1gOgwuUFy2Brw2LgcNQdHqXHpvK1jxhhWzba6xI/GZ0EiDxcn6ZQRxsSfSXNn799JL7aVbiTqRz5Igg3aVuyESCv2SdhWwutPC12TvUtWWVw7qpjvAylnqvvOYCz3NVih4WAZDVBbp+fnI9E+ZhQGKXCgJ6xqufY8dNsBytk5PKFZPyi61jjuex6xfo0mOI3S3UChuhL71ZPfCrBIzEgUfsTcPZy3oDb1RBB3Cv4nyguh0SV8CbTR541awQry56brJFk/XtPUVhZccqnGq2H+e8P1v58R/b7Mu2GLW/S7P7Ky0d95ZBtdd5n+ycS6qCyTLOLUIhayZmedOxXkyi25PJkF/mqD1tSA6K7UgrEc3XlDKJcLX7qp8WBiQaTjfUQAiMt/CONgoU+1JkHTddPRIgljHnpr34fVXWy6Rcf1mQv8ZjH6cZwtAQDn3UTrzthzc1QFBPwGbGmplpFmwRAb2j86sqrunHVAlIGqLbH8C2Bib7B6lHYSs2bz9u4RUCEl9BJ2GPGY6rjzn4k/bOZjK9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(46966006)(36840700001)(8676002)(70586007)(5660300002)(30864003)(2906002)(40460700003)(82310400005)(70206006)(8936002)(356005)(4326008)(40480700001)(36756003)(36860700001)(2616005)(7696005)(82740400003)(16526019)(6666004)(478600001)(316002)(41300700001)(86362001)(81166007)(54906003)(336012)(6916009)(47076005)(19627235002)(1076003)(83380400001)(186003)(26005)(426003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 05:13:24.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b651736-26ce-43ae-c860-08da6ad7bcb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
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
 .../dc/dml/dcn32/display_mode_vba_32.c        |   3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 121 +++++++++---------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   2 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  15 +++
 4 files changed, 77 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 9c2003fbe8fa..c0e537731c1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -221,6 +221,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		// VBA_DELTA
 		// Calculate DET size, swath height
 		dml32_CalculateSwathAndDETConfiguration(
+				&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 				mode_lib->vba.DETSizeOverride,
 				mode_lib->vba.UsesMALLForPStateChange,
 				mode_lib->vba.ConfigReturnBufferSizeInKByte,
@@ -1878,6 +1879,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	dml32_CalculateSwathAndDETConfiguration(
+			&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 			mode_lib->vba.DETSizeOverride,
 			mode_lib->vba.UsesMALLForPStateChange,
 			mode_lib->vba.ConfigReturnBufferSizeInKByte,
@@ -2474,6 +2476,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			}
 
 			dml32_CalculateSwathAndDETConfiguration(
+					&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 					mode_lib->vba.DETSizeOverride,
 					mode_lib->vba.UsesMALLForPStateChange,
 					mode_lib->vba.ConfigReturnBufferSizeInKByte,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index c8a3f367d622..da5befd7fdec 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -391,6 +391,7 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
 } // CalculateBytePerPixelAndBlockSizes
 
 void dml32_CalculateSwathAndDETConfiguration(
+		struct dml32_CalculateSwathAndDETConfiguration *st_vars,
 		unsigned int DETSizeOverride[],
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int ConfigReturnBufferSizeInKByte,
@@ -455,18 +456,10 @@ void dml32_CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerSurface[],
 		bool *ViewportSizeSupport)
 {
-	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
-	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpSwathSizeBytesY;
-	unsigned int RoundedUpSwathSizeBytesC;
-	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
-	double SwathWidthdoubleDPPChroma[DC__NUM_DPP__MAX];
 	unsigned int k;
-	unsigned int TotalActiveDPP = 0;
-	bool NoChromaSurfaces = true;
-	unsigned int DETBufferSizeInKByteForSwathCalculation;
+
+	st_vars->TotalActiveDPP = 0;
+	st_vars->NoChromaSurfaces = true;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: ForceSingleDPP = %d\n", __func__, ForceSingleDPP);
@@ -501,43 +494,43 @@ void dml32_CalculateSwathAndDETConfiguration(
 			DPPPerSurface,
 
 			/* Output */
-			SwathWidthdoubleDPP,
-			SwathWidthdoubleDPPChroma,
+			st_vars->SwathWidthdoubleDPP,
+			st_vars->SwathWidthdoubleDPPChroma,
 			SwathWidth,
 			SwathWidthChroma,
-			MaximumSwathHeightY,
-			MaximumSwathHeightC,
+			st_vars->MaximumSwathHeightY,
+			st_vars->MaximumSwathHeightC,
 			swath_width_luma_ub,
 			swath_width_chroma_ub);
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		RoundedUpMaxSwathSizeBytesY[k] = swath_width_luma_ub[k] * BytePerPixDETY[k] * MaximumSwathHeightY[k];
-		RoundedUpMaxSwathSizeBytesC[k] = swath_width_chroma_ub[k] * BytePerPixDETC[k] * MaximumSwathHeightC[k];
+		st_vars->RoundedUpMaxSwathSizeBytesY[k] = swath_width_luma_ub[k] * BytePerPixDETY[k] * st_vars->MaximumSwathHeightY[k];
+		st_vars->RoundedUpMaxSwathSizeBytesC[k] = swath_width_chroma_ub[k] * BytePerPixDETC[k] * st_vars->MaximumSwathHeightC[k];
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%0d DPPPerSurface = %d\n", __func__, k, DPPPerSurface[k]);
 		dml_print("DML::%s: k=%0d swath_width_luma_ub = %d\n", __func__, k, swath_width_luma_ub[k]);
 		dml_print("DML::%s: k=%0d BytePerPixDETY = %f\n", __func__, k, BytePerPixDETY[k]);
-		dml_print("DML::%s: k=%0d MaximumSwathHeightY = %d\n", __func__, k, MaximumSwathHeightY[k]);
+		dml_print("DML::%s: k=%0d MaximumSwathHeightY = %d\n", __func__, k, st_vars->MaximumSwathHeightY[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesY = %d\n", __func__, k,
-				RoundedUpMaxSwathSizeBytesY[k]);
+				st_vars->RoundedUpMaxSwathSizeBytesY[k]);
 		dml_print("DML::%s: k=%0d swath_width_chroma_ub = %d\n", __func__, k, swath_width_chroma_ub[k]);
 		dml_print("DML::%s: k=%0d BytePerPixDETC = %f\n", __func__, k, BytePerPixDETC[k]);
-		dml_print("DML::%s: k=%0d MaximumSwathHeightC = %d\n", __func__, k, MaximumSwathHeightC[k]);
+		dml_print("DML::%s: k=%0d MaximumSwathHeightC = %d\n", __func__, k, st_vars->MaximumSwathHeightC[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesC = %d\n", __func__, k,
-				RoundedUpMaxSwathSizeBytesC[k]);
+				st_vars->RoundedUpMaxSwathSizeBytesC[k]);
 #endif
 
 		if (SourcePixelFormat[k] == dm_420_10) {
-			RoundedUpMaxSwathSizeBytesY[k] = dml_ceil((unsigned int) RoundedUpMaxSwathSizeBytesY[k], 256);
-			RoundedUpMaxSwathSizeBytesC[k] = dml_ceil((unsigned int) RoundedUpMaxSwathSizeBytesC[k], 256);
+			st_vars->RoundedUpMaxSwathSizeBytesY[k] = dml_ceil((unsigned int) st_vars->RoundedUpMaxSwathSizeBytesY[k], 256);
+			st_vars->RoundedUpMaxSwathSizeBytesC[k] = dml_ceil((unsigned int) st_vars->RoundedUpMaxSwathSizeBytesC[k], 256);
 		}
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		TotalActiveDPP = TotalActiveDPP + (ForceSingleDPP ? 1 : DPPPerSurface[k]);
+		st_vars->TotalActiveDPP = st_vars->TotalActiveDPP + (ForceSingleDPP ? 1 : DPPPerSurface[k]);
 		if (SourcePixelFormat[k] == dm_420_8 || SourcePixelFormat[k] == dm_420_10 ||
 				SourcePixelFormat[k] == dm_420_12 || SourcePixelFormat[k] == dm_rgbe_alpha) {
-			NoChromaSurfaces = false;
+			st_vars->NoChromaSurfaces = false;
 		}
 	}
 
@@ -547,10 +540,10 @@ void dml32_CalculateSwathAndDETConfiguration(
 	// if unbounded req is enabled, program reserved space such that the ROB will not hold more than 8 swaths worth of data
 	// - assume worst-case compression rate of 4. [ROB size - 8 * swath_size / max_compression ratio]
 	// - assume for "narrow" vp case in which the ROB can fit 8 swaths, the DET should be big enough to do full size req
-	*CompBufReservedSpaceNeedAdjustment = ((int) ROBSizeKBytes - (int) *CompBufReservedSpaceKBytes) > (int) (RoundedUpMaxSwathSizeBytesY[0]/512);
+	*CompBufReservedSpaceNeedAdjustment = ((int) ROBSizeKBytes - (int) *CompBufReservedSpaceKBytes) > (int) (st_vars->RoundedUpMaxSwathSizeBytesY[0]/512);
 
 	if (*CompBufReservedSpaceNeedAdjustment == 1) {
-		*CompBufReservedSpaceKBytes = ROBSizeKBytes - RoundedUpMaxSwathSizeBytesY[0]/512;
+		*CompBufReservedSpaceKBytes = ROBSizeKBytes - st_vars->RoundedUpMaxSwathSizeBytesY[0]/512;
 	}
 
 	#ifdef __DML_VBA_DEBUG__
@@ -558,7 +551,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 		dml_print("DML::%s: CompBufReservedSpaceNeedAdjustment  = %d\n",  __func__, *CompBufReservedSpaceNeedAdjustment);
 	#endif
 
-	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, TotalActiveDPP, NoChromaSurfaces, Output[0], SurfaceTiling[0], *CompBufReservedSpaceNeedAdjustment, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
+	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, st_vars->TotalActiveDPP, st_vars->NoChromaSurfaces, Output[0], SurfaceTiling[0], *CompBufReservedSpaceNeedAdjustment, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
 
 	dml32_CalculateDETBufferSize(DETSizeOverride,
 			UseMALLForPStateChange,
@@ -573,8 +566,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 			SourcePixelFormat,
 			ReadBandwidthLuma,
 			ReadBandwidthChroma,
-			RoundedUpMaxSwathSizeBytesY,
-			RoundedUpMaxSwathSizeBytesC,
+			st_vars->RoundedUpMaxSwathSizeBytesY,
+			st_vars->RoundedUpMaxSwathSizeBytesC,
 			DPPPerSurface,
 
 			/* Output */
@@ -582,7 +575,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 			CompressedBufferSizeInkByte);
 
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: TotalActiveDPP = %d\n", __func__, TotalActiveDPP);
+	dml_print("DML::%s: TotalActiveDPP = %d\n", __func__, st_vars->TotalActiveDPP);
 	dml_print("DML::%s: nomDETInKByte = %d\n", __func__, nomDETInKByte);
 	dml_print("DML::%s: ConfigReturnBufferSizeInKByte = %d\n", __func__, ConfigReturnBufferSizeInKByte);
 	dml_print("DML::%s: UseUnboundedRequestingFinal = %d\n", __func__, UseUnboundedRequestingFinal);
@@ -593,42 +586,42 @@ void dml32_CalculateSwathAndDETConfiguration(
 	*ViewportSizeSupport = true;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 
-		DETBufferSizeInKByteForSwathCalculation = (UseMALLForPStateChange[k] ==
+		st_vars->DETBufferSizeInKByteForSwathCalculation = (UseMALLForPStateChange[k] ==
 				dm_use_mall_pstate_change_phantom_pipe ? 1024 : DETBufferSizeInKByte[k]);
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%0d DETBufferSizeInKByteForSwathCalculation = %d\n", __func__, k,
-				DETBufferSizeInKByteForSwathCalculation);
+				st_vars->DETBufferSizeInKByteForSwathCalculation);
 #endif
 
-		if (RoundedUpMaxSwathSizeBytesY[k] + RoundedUpMaxSwathSizeBytesC[k] <=
-				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = MaximumSwathHeightY[k];
-			SwathHeightC[k] = MaximumSwathHeightC[k];
-			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k];
-			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k];
-		} else if (RoundedUpMaxSwathSizeBytesY[k] >= 1.5 * RoundedUpMaxSwathSizeBytesC[k] &&
-				RoundedUpMaxSwathSizeBytesY[k] / 2 + RoundedUpMaxSwathSizeBytesC[k] <=
-				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
-			SwathHeightC[k] = MaximumSwathHeightC[k];
-			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k] / 2;
-			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k];
-		} else if (RoundedUpMaxSwathSizeBytesY[k] < 1.5 * RoundedUpMaxSwathSizeBytesC[k] &&
-				RoundedUpMaxSwathSizeBytesY[k] + RoundedUpMaxSwathSizeBytesC[k] / 2 <=
-				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = MaximumSwathHeightY[k];
-			SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
-			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k];
-			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k] / 2;
+		if (st_vars->RoundedUpMaxSwathSizeBytesY[k] + st_vars->RoundedUpMaxSwathSizeBytesC[k] <=
+				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k];
+			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k];
+			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k];
+			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k];
+		} else if (st_vars->RoundedUpMaxSwathSizeBytesY[k] >= 1.5 * st_vars->RoundedUpMaxSwathSizeBytesC[k] &&
+				st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2 + st_vars->RoundedUpMaxSwathSizeBytesC[k] <=
+				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k] / 2;
+			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k];
+			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2;
+			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k];
+		} else if (st_vars->RoundedUpMaxSwathSizeBytesY[k] < 1.5 * st_vars->RoundedUpMaxSwathSizeBytesC[k] &&
+				st_vars->RoundedUpMaxSwathSizeBytesY[k] + st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2 <=
+				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k];
+			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k] / 2;
+			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k];
+			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2;
 		} else {
-			SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
-			SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
-			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k] / 2;
-			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k] / 2;
+			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k] / 2;
+			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k] / 2;
+			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2;
+			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2;
 		}
 
-		if ((RoundedUpMaxSwathSizeBytesY[k] / 2 + RoundedUpMaxSwathSizeBytesC[k] / 2 >
-				DETBufferSizeInKByteForSwathCalculation * 1024 / 2)
+		if ((st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2 + st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2 >
+				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2)
 				|| SwathWidth[k] > MaximumSwathWidthLuma[k] || (SwathHeightC[k] > 0 &&
 						SwathWidthChroma[k] > MaximumSwathWidthChroma[k])) {
 			*ViewportSizeSupport = false;
@@ -643,7 +636,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 #endif
 			DETBufferSizeY[k] = DETBufferSizeInKByte[k] * 1024;
 			DETBufferSizeC[k] = 0;
-		} else if (RoundedUpSwathSizeBytesY <= 1.5 * RoundedUpSwathSizeBytesC) {
+		} else if (st_vars->RoundedUpSwathSizeBytesY <= 1.5 * st_vars->RoundedUpSwathSizeBytesC) {
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: k=%0d Half DET for plane0, half for plane1\n", __func__, k);
 #endif
@@ -661,11 +654,11 @@ void dml32_CalculateSwathAndDETConfiguration(
 		dml_print("DML::%s: k=%0d SwathHeightY = %d\n", __func__, k, SwathHeightY[k]);
 		dml_print("DML::%s: k=%0d SwathHeightC = %d\n", __func__, k, SwathHeightC[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesY = %d\n", __func__,
-				k, RoundedUpMaxSwathSizeBytesY[k]);
+				k, st_vars->RoundedUpMaxSwathSizeBytesY[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesC = %d\n", __func__,
-				k, RoundedUpMaxSwathSizeBytesC[k]);
-		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesY = %d\n", __func__, k, RoundedUpSwathSizeBytesY);
-		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesC = %d\n", __func__, k, RoundedUpSwathSizeBytesC);
+				k, st_vars->RoundedUpMaxSwathSizeBytesC[k]);
+		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesY = %d\n", __func__, k, st_vars->RoundedUpSwathSizeBytesY);
+		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesC = %d\n", __func__, k, st_vars->RoundedUpSwathSizeBytesC);
 		dml_print("DML::%s: k=%0d DETBufferSizeInKByte = %d\n", __func__, k, DETBufferSizeInKByte[k]);
 		dml_print("DML::%s: k=%0d DETBufferSizeY = %d\n", __func__, k, DETBufferSizeY[k]);
 		dml_print("DML::%s: k=%0d DETBufferSizeC = %d\n", __func__, k, DETBufferSizeC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index d293856ba906..158cfa2af1af 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -30,6 +30,7 @@
 #include "os_types.h"
 #include "../dc_features.h"
 #include "../display_mode_structs.h"
+#include "dml/display_mode_vba.h"
 
 unsigned int dml32_dscceComputeDelay(
 		unsigned int bpc,
@@ -81,6 +82,7 @@ void dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(
 		double *DPPCLKUsingSingleDPP);
 
 void dml32_CalculateSwathAndDETConfiguration(
+		struct dml32_CalculateSwathAndDETConfiguration *st_vars,
 		unsigned int DETSizeOverride[],
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int ConfigReturnBufferSizeInKByte,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 492aec634b68..6cf814c2cc8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -182,6 +182,20 @@ void Calculate256BBlockSizes(
 		unsigned int *BlockWidth256BytesY,
 		unsigned int *BlockWidth256BytesC);
 
+struct dml32_CalculateSwathAndDETConfiguration {
+	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
+	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpSwathSizeBytesY;
+	unsigned int RoundedUpSwathSizeBytesC;
+	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
+	double SwathWidthdoubleDPPChroma[DC__NUM_DPP__MAX];
+	unsigned int TotalActiveDPP;
+	bool NoChromaSurfaces;
+	unsigned int DETBufferSizeInKByteForSwathCalculation;
+};
+
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -253,6 +267,7 @@ struct dummy_vars {
 	struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
 	DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
 	struct dml32_ModeSupportAndSystemConfigurationFull dml32_ModeSupportAndSystemConfigurationFull;
+	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
 };
 
 struct vba_vars_st {
-- 
2.35.3

