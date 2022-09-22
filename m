Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65ECECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83B710EA14;
	Thu, 22 Sep 2022 00:20:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866B010E9FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7EyzU+PBLTGXlAMxy03FcwcBbfS45oceUhNuR6SMxVbFvda1L4rwkuMhZuwhVtY/C+SZVXtm3I0A1+ZjxqtFv9xDxqICEZmwODWeiMIQw1tPpWCVsRVG9NPirUdAVfX98AEolTTsl7HgF7NpmWJ2ApUJfIgrWaXu4QpkvWhRQzE1lEa6AtOt9/WUEq9I0DnijfvU+Qk8hTRehJuiti+RwRV9ft77gQIX5+hbt7ww8hQLwlWhYtgn4VbzKSwvqmVEebSEy4nHs0nUzzSLL99U6u2ab8DgQzhKLelR0KPDTBa+60DAXabt7Saw6Qk8yXAD2Om4F3FKFmB7pvQ7wpnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaZaS1Bw4lSVWs9zJup830/fIUZoDy03HEkC5C7ButE=;
 b=NCXGce68oiVH4sgBfmSbmUrEh95tDRDMh7Wl6L4JjhTLqJKfjsyko346bAnXQ4t/RwLTUs5ossheLKU4m6Ns+NZMxes2EB151C8a8otLI+q2IIUSYZCVn2PEIuvQ1JBiGH6SW+e8ym3KSLdVvi4SGtgpnTKcQGNqHdhvil02oD5+3Xzn+vN/MNCLtFyIiZF167OilW344wE4lThVVEoBoN63T/8DkhlFLyhX5gjU+C17vweVwt1gUiWyUYwEBGTbTtUBw9Jen+VtT+g1Zydqcv18NlpSVV7ztdJXQ3zXM3vsQ8vPuG9Zb12iClgpca6FFxgmI6HlnDCTq/1QrEjDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaZaS1Bw4lSVWs9zJup830/fIUZoDy03HEkC5C7ButE=;
 b=4XTXuY+KBPsqoUN/W/zQRXsdQGtLrwCcDsmun96Ke+OwrN2nSXc12MtCdbSj+JCJAe2acY4LBRiOqvv/gwZ6b4YEpxAPOgwj3MMJ4TRrpr2rUL7+Iv60Mu2SZZ8z571s4VAvWlGaZ7MHHlDyvygF3FFN4JIOJ4alKO3tSyjbWdo=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:19:32 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::89) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:31 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:29 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/31] drm/amd/display: remove redundant CalculateTWait's
Date: Wed, 21 Sep 2022 20:18:19 -0400
Message-ID: <20220922001821.320255-30-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f7255a-45ee-41d6-63c4-08da9c301eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jp+E9vQ3vLC89hLtxfLvifFYaw/CaHI0GSzylE7tXyXnsNyzbf5xl9A+y+3JzMFqpz5gyAbMoj7zMjKN8weGA8Ae1s5wlzuFvR1k/Fciqfmzl4q8hc/CVB4lYA5Fz5nIc2aHAzlCnZfmm22fc/K2uryAGvfuJlW7zcBGJ9VMd595mf2cfrq+Giix4YsxLesqJKeM3Pv9MP+kYftVUK+GqNVb2pWyOPTpLamL21H/lN4ikGybtZ0I1aYO5H+1uCStFv72MK8h83MZmrOiU6nWV2XhxBlbgSeJBvsm3VlCpzCxjO6PWFl+FSXGx3ClDPO5mP2zbbxIW7QpMYckV3Lj0trGaS6CHfpqQ5/CPqaJUwjii5FDISdC88cf76/AshDrkXHVJgr3RhpX2/QNn4Wn+Wn2OYTyMidywSfKPsanOjJdOPqHk7yGC/1ECbfh9/ujl4WJPE6rp74Fd70OnsjMXomVsi5Kko1pGh+i0pzGiQ/UypWP2Bo0Ghn3e30nFUXmhrKytp0sixxhs6iL55z2hNoNwgKw4o0HYpuzVgAx61+61c+fomtN97zRyOLAjWQ7Nk/B/9BAyNqkyxyS0uSHjvd5xEK8pYXyp3kGKENz3lphyDhhjBAYXDlEG2aIqCS2Apua4Hb7z/jz+O2+KnX9xUFucQ89dXtxK5sy4vfDdKHMO/sd2/gkXITTlBlawtPEDItomePzE+kObaEWDiDyBGfnR9BOiMIHNNlrJkteOLPcE29oEXa7Jnf76SuQlz0vbueeFrZzBKqTbp4DuIthMsQciJ7H9XHrnf9hzux0MPgV7uVL2RCRiBnHwSyXKSWT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(26005)(478600001)(6666004)(36756003)(81166007)(82740400003)(356005)(83380400001)(40480700001)(47076005)(82310400005)(1076003)(16526019)(186003)(36860700001)(40460700003)(41300700001)(426003)(336012)(5660300002)(8936002)(2906002)(316002)(6916009)(54906003)(4326008)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:31.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7255a-45ee-41d6-63c4-08da9c301eff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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
Cc: stylon.wang@amd.com, =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Tom Rix <trix@redhat.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Rix <trix@redhat.com>

There are several copies of CalculateTwait.
Reduce to one instance and change local variable name to match common usage.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 16 +++++++-------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 21 ++-----------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 19 +----------------
 .../dc/dml/dcn30/display_mode_vba_30.c        | 18 +---------------
 .../dc/dml/dcn31/display_mode_vba_31.c        | 13 +-----------
 .../dc/dml/dcn314/display_mode_vba_314.c      | 13 +-----------
 6 files changed, 14 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index d3b5b6fedf04..56c9c097823d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -153,10 +153,10 @@ static unsigned int CalculateVMAndRowBytes(
 		bool *PTEBufferSizeNotExceeded,
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime);
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
@@ -2920,20 +2920,20 @@ static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime)
 {
 	if (PrefetchMode == 0) {
 		return dml_max(
-				DRAMClockChangeLatency + UrgentLatencyPixelDataOnly,
-				dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly));
+				DRAMClockChangeLatency + UrgentLatency,
+				dml_max(SREnterPlusExitTime, UrgentLatency));
 	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly);
+		return dml_max(SREnterPlusExitTime, UrgentLatency);
 	} else {
-		return UrgentLatencyPixelDataOnly;
+		return UrgentLatency;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index edd098c7eb92..6b54be569691 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -177,10 +177,10 @@ static unsigned int CalculateVMAndRowBytes(
 		bool *PTEBufferSizeNotExceeded,
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime);
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
@@ -2993,23 +2993,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(
-				DRAMClockChangeLatency + UrgentLatencyPixelDataOnly,
-				dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly);
-	} else {
-		return UrgentLatencyPixelDataOnly;
-	}
-}
-
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 1d84ae50311d..d2dfa82d52a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -205,7 +205,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame);
 
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
@@ -3007,23 +3007,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatency,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(
-				DRAMClockChangeLatency + UrgentLatency,
-				dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 479e2c1a1301..e62bc56e4e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -216,7 +216,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
@@ -3213,22 +3213,6 @@ void dml30_CalculateBytePerPixelAnd256BBlockSizes(
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatency,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency,
-				dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml30_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 8dfe639b6508..338db0cac8c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -230,7 +230,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame);
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
+double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -3347,17 +3347,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 			&dummysinglestring);
 }
 
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency, dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml31_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 0d12fd079cd6..e17b253208cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -244,7 +244,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame);
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
+double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -3459,17 +3459,6 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 	return true;
 }
 
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency, dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml314_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
-- 
2.25.1

