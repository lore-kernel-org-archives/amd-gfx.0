Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C50C04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D8DC7CDC;
	Wed, 27 Jul 2022 22:19:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7EBBC7846
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxXX23pfP+MuuOpuVe0PFEf1Weh6XHQ9+0KMEox94ZhKDZJuuRdKUB+bqCvMcAbSbiMv7FRdDB+IqM7C2LPL1C4SUVrta/fhzESXk2CMlwT7A6BepEO3/ZgEpigdpni645++Xln/H8oJwPRwH/a7Gye+m3FJwHBnx8M2pX+j4jwifSTg81YVvktWlXyPO1v9Q+0uAGK9PceriIwlX2sYJAiUvO3Hg3HXGEj3+WhqFRbuCUOE4SmZZxjTH4swKViPa+jVtphsXRUiaofuBswUROcELIVZG629nlFmHg1ifpwudCHB+d7MRKgHw4tlbul1cb5Jl4xqWK0DgyQZC4OEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsCYaoLVGSlkdlbRNxnBjWSo24bt0cuMB/BmmxShbLg=;
 b=XkQQRyshHzxzIY3bbcNGV/zZCNmWAPDWSYTFKCptu7PjZS8g1C7MphcU31We+o99BdB2lOVJAc3N3AhApuc7adivhX63NJfSFu6b4/47qk7lIS3CNvBTkPsEBQmjRvNlZYdklkR2ymnwiHPBDejhDVNtBg4LacTSCsCmtO1nFiFa6BjdJgzJnNKBv1/lBMa7Gz3KS6akSznMPVhUAWByDEQWhtI62aNr2mODUusfNW03wI0ZL5uSIjn15UQtOsiI+ke/0sbCQ6giapnDR4TURbhZ7aMrprkZi4RC5kKYCBvdV8HT4Xl8uyuXGvFLkazh7WUIC5Iyp0t0ORcmzvfwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsCYaoLVGSlkdlbRNxnBjWSo24bt0cuMB/BmmxShbLg=;
 b=NATpulogPgxNwwE5ZbAxv7wBzIQPkn03Q1Y4RlrYvSzTRichBaUWzT4fQXiDpInmgH7MZPcqX9vYLucbPIgsiYctrimU284zVES75Dhrqd+VUVpBBkGK7Crng5mlBA4Ecc9nTJalltMOyszn5FtCnX4VVS61k9Fed8g8kKPfUPg=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 22:19:26 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a5) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Wed, 27 Jul 2022 22:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 22:19:25 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 17:19:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Revert "drm/amd/display: reduce stack for
 dml32_CalculateSwathAndDETConfiguration"
Date: Wed, 27 Jul 2022 18:18:55 -0400
Message-ID: <20220727221855.324361-5-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6ad1623-d9f5-485b-2b27-08da701e10ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/csdDccrqQeSjm2JsB7mUkWeWtZq2LZxA+gwPoH1isR1d467IDUhRSLThjrY0KWkRT9Q6B1ioQfsFGsZ2yMtUm1al62UaNMylI4HrgbPxufAkzGRJ0WBlw8jUu9FlMb5Xy4hjEUF94vzEvupjPkx+KClAt23aKIjO0iyrWTpq0q3lu5MAp0NsLxGwkDVLvpCAT8Mu4vROOFmbWKcISdngykZ5ik5KzM6BzQXJBZ+L/QQd/o8wIZ4Pq1IxxakBGOOooOyvX/mgfo/jWNYHOuv9Wrn/gt1JJcwR9nMG5KR7Ht6jN5gnkJAUi5mHqUhM8Wrq0C7wG+qGlgjK2ls8pvRmbFaeoOBMwfLn8LVFeanGMDFfP0w9u1ety4g1KwALBQnJ6rs5Xpny8nGO/03YepyE88yzbNtN67k++mQevFAHe8FLUZw/e22vsG5uEOIYhSQr+zdN+44wssT40Q74mhQ5N4EuZYuDERK2TZVBcG/OmQ+M9/br7jeIy7gFglQwEZq4fXzMKXCOLSMa5dHP4fiW6x+jg6NFIRO3A1yQT29TmTnAk+A9k8hosBoDh/HFmD4zrUT+E7xT9t/8i4VqzR8tyeK1J5j08OXA5MoLUtIaKJDKzXuCJxh1cAtWC0+wlDLAAzAQY8jlssGTkljkNc7TnyJUbFWK11yuI1wZmRFlq5fdcml2gb+NjotpVgtfeo6RbxqSR1GCpEy/RuvjmU9E//VWh7/Wh5hSayMVk8QkJBSI0lTTcIiyMLUAphnuP592YYep3Vp4az7fogjXxsfhkwv8ZI1dgo7sIDnuB2Ej/iFadxhUGWugIYCjVZmlxP3DihlfVZ3O8v5bZuSnQ/RAjqccA1b4zOMZZ/i79xooQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(40470700004)(8936002)(86362001)(16526019)(478600001)(186003)(1076003)(7696005)(5660300002)(316002)(30864003)(36756003)(82310400005)(82740400003)(41300700001)(70206006)(36860700001)(47076005)(70586007)(26005)(2616005)(6666004)(19627235002)(40480700001)(336012)(2906002)(426003)(356005)(83380400001)(4326008)(6916009)(54906003)(40460700003)(8676002)(81166007)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:19:25.9845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad1623-d9f5-485b-2b27-08da701e10ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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

This reverts commit ca6730ca0f01cd918087344c0c22cf6ed840db9d.

This commit was a part of a patchset responsible for reducing the stack
size. However, after some other changes, this commit becomes
unnecessary, so we are reverting it here.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |   3 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 121 +++++++++---------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   2 -
 .../drm/amd/display/dc/dml/display_mode_vba.h |  15 ---
 4 files changed, 64 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 3cfd3cc4d60c..cb2025771646 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -221,7 +221,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		// VBA_DELTA
 		// Calculate DET size, swath height
 		dml32_CalculateSwathAndDETConfiguration(
-				&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 				mode_lib->vba.DETSizeOverride,
 				mode_lib->vba.UsesMALLForPStateChange,
 				mode_lib->vba.ConfigReturnBufferSizeInKByte,
@@ -1948,7 +1947,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	}
 
 	dml32_CalculateSwathAndDETConfiguration(
-			&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 			mode_lib->vba.DETSizeOverride,
 			mode_lib->vba.UsesMALLForPStateChange,
 			mode_lib->vba.ConfigReturnBufferSizeInKByte,
@@ -2545,7 +2543,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			}
 
 			dml32_CalculateSwathAndDETConfiguration(
-					&v->dummy_vars.dml32_CalculateSwathAndDETConfiguration,
 					mode_lib->vba.DETSizeOverride,
 					mode_lib->vba.UsesMALLForPStateChange,
 					mode_lib->vba.ConfigReturnBufferSizeInKByte,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index f9adfd7371dc..05fc14a47fba 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -391,7 +391,6 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
 } // CalculateBytePerPixelAndBlockSizes
 
 void dml32_CalculateSwathAndDETConfiguration(
-		struct dml32_CalculateSwathAndDETConfiguration *st_vars,
 		unsigned int DETSizeOverride[],
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int ConfigReturnBufferSizeInKByte,
@@ -456,10 +455,18 @@ void dml32_CalculateSwathAndDETConfiguration(
 		bool ViewportSizeSupportPerSurface[],
 		bool *ViewportSizeSupport)
 {
+	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
+	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpSwathSizeBytesY;
+	unsigned int RoundedUpSwathSizeBytesC;
+	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
+	double SwathWidthdoubleDPPChroma[DC__NUM_DPP__MAX];
 	unsigned int k;
-
-	st_vars->TotalActiveDPP = 0;
-	st_vars->NoChromaSurfaces = true;
+	unsigned int TotalActiveDPP = 0;
+	bool NoChromaSurfaces = true;
+	unsigned int DETBufferSizeInKByteForSwathCalculation;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: ForceSingleDPP = %d\n", __func__, ForceSingleDPP);
@@ -494,43 +501,43 @@ void dml32_CalculateSwathAndDETConfiguration(
 			DPPPerSurface,
 
 			/* Output */
-			st_vars->SwathWidthdoubleDPP,
-			st_vars->SwathWidthdoubleDPPChroma,
+			SwathWidthdoubleDPP,
+			SwathWidthdoubleDPPChroma,
 			SwathWidth,
 			SwathWidthChroma,
-			st_vars->MaximumSwathHeightY,
-			st_vars->MaximumSwathHeightC,
+			MaximumSwathHeightY,
+			MaximumSwathHeightC,
 			swath_width_luma_ub,
 			swath_width_chroma_ub);
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		st_vars->RoundedUpMaxSwathSizeBytesY[k] = swath_width_luma_ub[k] * BytePerPixDETY[k] * st_vars->MaximumSwathHeightY[k];
-		st_vars->RoundedUpMaxSwathSizeBytesC[k] = swath_width_chroma_ub[k] * BytePerPixDETC[k] * st_vars->MaximumSwathHeightC[k];
+		RoundedUpMaxSwathSizeBytesY[k] = swath_width_luma_ub[k] * BytePerPixDETY[k] * MaximumSwathHeightY[k];
+		RoundedUpMaxSwathSizeBytesC[k] = swath_width_chroma_ub[k] * BytePerPixDETC[k] * MaximumSwathHeightC[k];
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%0d DPPPerSurface = %d\n", __func__, k, DPPPerSurface[k]);
 		dml_print("DML::%s: k=%0d swath_width_luma_ub = %d\n", __func__, k, swath_width_luma_ub[k]);
 		dml_print("DML::%s: k=%0d BytePerPixDETY = %f\n", __func__, k, BytePerPixDETY[k]);
-		dml_print("DML::%s: k=%0d MaximumSwathHeightY = %d\n", __func__, k, st_vars->MaximumSwathHeightY[k]);
+		dml_print("DML::%s: k=%0d MaximumSwathHeightY = %d\n", __func__, k, MaximumSwathHeightY[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesY = %d\n", __func__, k,
-				st_vars->RoundedUpMaxSwathSizeBytesY[k]);
+				RoundedUpMaxSwathSizeBytesY[k]);
 		dml_print("DML::%s: k=%0d swath_width_chroma_ub = %d\n", __func__, k, swath_width_chroma_ub[k]);
 		dml_print("DML::%s: k=%0d BytePerPixDETC = %f\n", __func__, k, BytePerPixDETC[k]);
-		dml_print("DML::%s: k=%0d MaximumSwathHeightC = %d\n", __func__, k, st_vars->MaximumSwathHeightC[k]);
+		dml_print("DML::%s: k=%0d MaximumSwathHeightC = %d\n", __func__, k, MaximumSwathHeightC[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesC = %d\n", __func__, k,
-				st_vars->RoundedUpMaxSwathSizeBytesC[k]);
+				RoundedUpMaxSwathSizeBytesC[k]);
 #endif
 
 		if (SourcePixelFormat[k] == dm_420_10) {
-			st_vars->RoundedUpMaxSwathSizeBytesY[k] = dml_ceil((unsigned int) st_vars->RoundedUpMaxSwathSizeBytesY[k], 256);
-			st_vars->RoundedUpMaxSwathSizeBytesC[k] = dml_ceil((unsigned int) st_vars->RoundedUpMaxSwathSizeBytesC[k], 256);
+			RoundedUpMaxSwathSizeBytesY[k] = dml_ceil((unsigned int) RoundedUpMaxSwathSizeBytesY[k], 256);
+			RoundedUpMaxSwathSizeBytesC[k] = dml_ceil((unsigned int) RoundedUpMaxSwathSizeBytesC[k], 256);
 		}
 	}
 
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
-		st_vars->TotalActiveDPP = st_vars->TotalActiveDPP + (ForceSingleDPP ? 1 : DPPPerSurface[k]);
+		TotalActiveDPP = TotalActiveDPP + (ForceSingleDPP ? 1 : DPPPerSurface[k]);
 		if (SourcePixelFormat[k] == dm_420_8 || SourcePixelFormat[k] == dm_420_10 ||
 				SourcePixelFormat[k] == dm_420_12 || SourcePixelFormat[k] == dm_rgbe_alpha) {
-			st_vars->NoChromaSurfaces = false;
+			NoChromaSurfaces = false;
 		}
 	}
 
@@ -540,10 +547,10 @@ void dml32_CalculateSwathAndDETConfiguration(
 	// if unbounded req is enabled, program reserved space such that the ROB will not hold more than 8 swaths worth of data
 	// - assume worst-case compression rate of 4. [ROB size - 8 * swath_size / max_compression ratio]
 	// - assume for "narrow" vp case in which the ROB can fit 8 swaths, the DET should be big enough to do full size req
-	*CompBufReservedSpaceNeedAdjustment = ((int) ROBSizeKBytes - (int) *CompBufReservedSpaceKBytes) > (int) (st_vars->RoundedUpMaxSwathSizeBytesY[0]/512);
+	*CompBufReservedSpaceNeedAdjustment = ((int) ROBSizeKBytes - (int) *CompBufReservedSpaceKBytes) > (int) (RoundedUpMaxSwathSizeBytesY[0]/512);
 
 	if (*CompBufReservedSpaceNeedAdjustment == 1) {
-		*CompBufReservedSpaceKBytes = ROBSizeKBytes - st_vars->RoundedUpMaxSwathSizeBytesY[0]/512;
+		*CompBufReservedSpaceKBytes = ROBSizeKBytes - RoundedUpMaxSwathSizeBytesY[0]/512;
 	}
 
 	#ifdef __DML_VBA_DEBUG__
@@ -551,7 +558,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 		dml_print("DML::%s: CompBufReservedSpaceNeedAdjustment  = %d\n",  __func__, *CompBufReservedSpaceNeedAdjustment);
 	#endif
 
-	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, st_vars->TotalActiveDPP, st_vars->NoChromaSurfaces, Output[0], SurfaceTiling[0], *CompBufReservedSpaceNeedAdjustment, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
+	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, TotalActiveDPP, NoChromaSurfaces, Output[0], SurfaceTiling[0], *CompBufReservedSpaceNeedAdjustment, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
 
 	dml32_CalculateDETBufferSize(DETSizeOverride,
 			UseMALLForPStateChange,
@@ -566,8 +573,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 			SourcePixelFormat,
 			ReadBandwidthLuma,
 			ReadBandwidthChroma,
-			st_vars->RoundedUpMaxSwathSizeBytesY,
-			st_vars->RoundedUpMaxSwathSizeBytesC,
+			RoundedUpMaxSwathSizeBytesY,
+			RoundedUpMaxSwathSizeBytesC,
 			DPPPerSurface,
 
 			/* Output */
@@ -575,7 +582,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 			CompressedBufferSizeInkByte);
 
 #ifdef __DML_VBA_DEBUG__
-	dml_print("DML::%s: TotalActiveDPP = %d\n", __func__, st_vars->TotalActiveDPP);
+	dml_print("DML::%s: TotalActiveDPP = %d\n", __func__, TotalActiveDPP);
 	dml_print("DML::%s: nomDETInKByte = %d\n", __func__, nomDETInKByte);
 	dml_print("DML::%s: ConfigReturnBufferSizeInKByte = %d\n", __func__, ConfigReturnBufferSizeInKByte);
 	dml_print("DML::%s: UseUnboundedRequestingFinal = %d\n", __func__, UseUnboundedRequestingFinal);
@@ -586,42 +593,42 @@ void dml32_CalculateSwathAndDETConfiguration(
 	*ViewportSizeSupport = true;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 
-		st_vars->DETBufferSizeInKByteForSwathCalculation = (UseMALLForPStateChange[k] ==
+		DETBufferSizeInKByteForSwathCalculation = (UseMALLForPStateChange[k] ==
 				dm_use_mall_pstate_change_phantom_pipe ? 1024 : DETBufferSizeInKByte[k]);
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: k=%0d DETBufferSizeInKByteForSwathCalculation = %d\n", __func__, k,
-				st_vars->DETBufferSizeInKByteForSwathCalculation);
+				DETBufferSizeInKByteForSwathCalculation);
 #endif
 
-		if (st_vars->RoundedUpMaxSwathSizeBytesY[k] + st_vars->RoundedUpMaxSwathSizeBytesC[k] <=
-				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k];
-			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k];
-			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k];
-			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k];
-		} else if (st_vars->RoundedUpMaxSwathSizeBytesY[k] >= 1.5 * st_vars->RoundedUpMaxSwathSizeBytesC[k] &&
-				st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2 + st_vars->RoundedUpMaxSwathSizeBytesC[k] <=
-				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k] / 2;
-			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k];
-			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2;
-			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k];
-		} else if (st_vars->RoundedUpMaxSwathSizeBytesY[k] < 1.5 * st_vars->RoundedUpMaxSwathSizeBytesC[k] &&
-				st_vars->RoundedUpMaxSwathSizeBytesY[k] + st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2 <=
-				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
-			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k];
-			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k] / 2;
-			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k];
-			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2;
+		if (RoundedUpMaxSwathSizeBytesY[k] + RoundedUpMaxSwathSizeBytesC[k] <=
+				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = MaximumSwathHeightY[k];
+			SwathHeightC[k] = MaximumSwathHeightC[k];
+			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k];
+			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k];
+		} else if (RoundedUpMaxSwathSizeBytesY[k] >= 1.5 * RoundedUpMaxSwathSizeBytesC[k] &&
+				RoundedUpMaxSwathSizeBytesY[k] / 2 + RoundedUpMaxSwathSizeBytesC[k] <=
+				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
+			SwathHeightC[k] = MaximumSwathHeightC[k];
+			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k] / 2;
+			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k];
+		} else if (RoundedUpMaxSwathSizeBytesY[k] < 1.5 * RoundedUpMaxSwathSizeBytesC[k] &&
+				RoundedUpMaxSwathSizeBytesY[k] + RoundedUpMaxSwathSizeBytesC[k] / 2 <=
+				DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
+			SwathHeightY[k] = MaximumSwathHeightY[k];
+			SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
+			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k];
+			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k] / 2;
 		} else {
-			SwathHeightY[k] = st_vars->MaximumSwathHeightY[k] / 2;
-			SwathHeightC[k] = st_vars->MaximumSwathHeightC[k] / 2;
-			st_vars->RoundedUpSwathSizeBytesY = st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2;
-			st_vars->RoundedUpSwathSizeBytesC = st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2;
+			SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
+			SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
+			RoundedUpSwathSizeBytesY = RoundedUpMaxSwathSizeBytesY[k] / 2;
+			RoundedUpSwathSizeBytesC = RoundedUpMaxSwathSizeBytesC[k] / 2;
 		}
 
-		if ((st_vars->RoundedUpMaxSwathSizeBytesY[k] / 2 + st_vars->RoundedUpMaxSwathSizeBytesC[k] / 2 >
-				st_vars->DETBufferSizeInKByteForSwathCalculation * 1024 / 2)
+		if ((RoundedUpMaxSwathSizeBytesY[k] / 2 + RoundedUpMaxSwathSizeBytesC[k] / 2 >
+				DETBufferSizeInKByteForSwathCalculation * 1024 / 2)
 				|| SwathWidth[k] > MaximumSwathWidthLuma[k] || (SwathHeightC[k] > 0 &&
 						SwathWidthChroma[k] > MaximumSwathWidthChroma[k])) {
 			*ViewportSizeSupport = false;
@@ -636,7 +643,7 @@ void dml32_CalculateSwathAndDETConfiguration(
 #endif
 			DETBufferSizeY[k] = DETBufferSizeInKByte[k] * 1024;
 			DETBufferSizeC[k] = 0;
-		} else if (st_vars->RoundedUpSwathSizeBytesY <= 1.5 * st_vars->RoundedUpSwathSizeBytesC) {
+		} else if (RoundedUpSwathSizeBytesY <= 1.5 * RoundedUpSwathSizeBytesC) {
 #ifdef __DML_VBA_DEBUG__
 			dml_print("DML::%s: k=%0d Half DET for plane0, half for plane1\n", __func__, k);
 #endif
@@ -654,11 +661,11 @@ void dml32_CalculateSwathAndDETConfiguration(
 		dml_print("DML::%s: k=%0d SwathHeightY = %d\n", __func__, k, SwathHeightY[k]);
 		dml_print("DML::%s: k=%0d SwathHeightC = %d\n", __func__, k, SwathHeightC[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesY = %d\n", __func__,
-				k, st_vars->RoundedUpMaxSwathSizeBytesY[k]);
+				k, RoundedUpMaxSwathSizeBytesY[k]);
 		dml_print("DML::%s: k=%0d RoundedUpMaxSwathSizeBytesC = %d\n", __func__,
-				k, st_vars->RoundedUpMaxSwathSizeBytesC[k]);
-		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesY = %d\n", __func__, k, st_vars->RoundedUpSwathSizeBytesY);
-		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesC = %d\n", __func__, k, st_vars->RoundedUpSwathSizeBytesC);
+				k, RoundedUpMaxSwathSizeBytesC[k]);
+		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesY = %d\n", __func__, k, RoundedUpSwathSizeBytesY);
+		dml_print("DML::%s: k=%0d RoundedUpSwathSizeBytesC = %d\n", __func__, k, RoundedUpSwathSizeBytesC);
 		dml_print("DML::%s: k=%0d DETBufferSizeInKByte = %d\n", __func__, k, DETBufferSizeInKByte[k]);
 		dml_print("DML::%s: k=%0d DETBufferSizeY = %d\n", __func__, k, DETBufferSizeY[k]);
 		dml_print("DML::%s: k=%0d DETBufferSizeC = %d\n", __func__, k, DETBufferSizeC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 158cfa2af1af..d293856ba906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -30,7 +30,6 @@
 #include "os_types.h"
 #include "../dc_features.h"
 #include "../display_mode_structs.h"
-#include "dml/display_mode_vba.h"
 
 unsigned int dml32_dscceComputeDelay(
 		unsigned int bpc,
@@ -82,7 +81,6 @@ void dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(
 		double *DPPCLKUsingSingleDPP);
 
 void dml32_CalculateSwathAndDETConfiguration(
-		struct dml32_CalculateSwathAndDETConfiguration *st_vars,
 		unsigned int DETSizeOverride[],
 		enum dm_use_mall_for_pstate_change_mode UseMALLForPStateChange[],
 		unsigned int ConfigReturnBufferSizeInKByte,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 6cf814c2cc8d..492aec634b68 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -182,20 +182,6 @@ void Calculate256BBlockSizes(
 		unsigned int *BlockWidth256BytesY,
 		unsigned int *BlockWidth256BytesC);
 
-struct dml32_CalculateSwathAndDETConfiguration {
-	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
-	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpSwathSizeBytesY;
-	unsigned int RoundedUpSwathSizeBytesC;
-	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
-	double SwathWidthdoubleDPPChroma[DC__NUM_DPP__MAX];
-	unsigned int TotalActiveDPP;
-	bool NoChromaSurfaces;
-	unsigned int DETBufferSizeInKByteForSwathCalculation;
-};
-
 struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation {
 	unsigned int dummy_integer_array[2][DC__NUM_DPP__MAX];
 	double dummy_single_array[2][DC__NUM_DPP__MAX];
@@ -267,7 +253,6 @@ struct dummy_vars {
 	struct DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
 	DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation;
 	struct dml32_ModeSupportAndSystemConfigurationFull dml32_ModeSupportAndSystemConfigurationFull;
-	struct dml32_CalculateSwathAndDETConfiguration dml32_CalculateSwathAndDETConfiguration;
 };
 
 struct vba_vars_st {
-- 
2.35.1

