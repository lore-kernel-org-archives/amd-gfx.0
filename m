Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E4FD88DF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1CC10E302;
	Wed, 11 Mar 2026 04:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaiAb1w6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAAD10E2FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi0Hge0GP41g1xHSB+cRK870mV19/MU7kUCZFj296DRqzJFuWPQQX8AWAMJL2IW1DMzM8dCuQ5FjA6r+TDSe8JhVSsUpY4vHbsW2izpkynK8XBWiezbxsWaQglBqyQSuePWadfDbSSiC6y2dvCaCd6yOCppPQEv94FonGG+dAsj2GtV/mZ+la5CK1zKwjD1jE1ZnOwDCaXb9DgdImcnQVpCe9Tgnmq6vOvMpIlrStmi5wDYZ8g4BkG6gxbcBbZmHVyp7kKl9jAK70+IsGh3bILrI4Q4tkWMIPpx+B6FbIyktY4+seEptl9Xh8WsPtQcULcG6JObNj+fVtNjl6Mg7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py314F878N8m4AVX/GVGGvHopZDkvmuZivKEMSlH6XI=;
 b=jj83gwVb5j3Kats+BeVfKKmD7/DuOAKzEQBDRto97RFGBCxwd4DrPVbRWiITMzyv4fn7Ay2P/XjC4lWjgTJoIN839bLTzpTgx+MejEslZjnvpvUmn9yvMCdYUn7XuHaitCk8uVo9QDJhjDPzKnTM86sX4SL5Rfvu5h9qFPnsfx25rUUYhYNRpuC3zQitL6GYPt4MI5ImSUT6iGBhrOe5gduiw5hEDGt9tUGFt3RJ9pEJ8I6maDAHXBcbp9Ef5JF8qhhDsnaqurBmjLd2A3b84xVBLR0jcj6Ykl1mMWV22ivhY5wStB9IShvX9Oc9d0Ql0o0cYAV0y5O5nxcsS6ERVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py314F878N8m4AVX/GVGGvHopZDkvmuZivKEMSlH6XI=;
 b=OaiAb1w6+NjIYTQhaPDW6iu6DMmpQ3mcjVHlzG6Oi7ISYqqQ7pFYwVsLnq2YfKY5hovYhFQDKauwxxBaPixEUZlflAkOSkFMtag/l+fRD7dqBAWC2MqkmqysV4rTxI50PnN8AudCzPLCg4wZn/YVaovx4cwOvWIl54ZB4SdvNHo=
Received: from PH0PR07CA0120.namprd07.prod.outlook.com (2603:10b6:510:4::35)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:03:55 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::4d) by PH0PR07CA0120.outlook.office365.com
 (2603:10b6:510:4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:54 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:50 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 5/9] drm/amd/display: Silence static analysis warning
Date: Wed, 11 Mar 2026 11:33:00 +0800
Message-ID: <20260311040501.2693643-6-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0c2955-392f-416c-e9c0-08de7f233670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GhE3NewoWYDvTiIug0ydWuQI0k63kb3HTLQNE5YDIDHFt6dciiEz+Z7vg0K8Gz+5NTtsVynF2A1iWNECgbtBBOil9Sqnzvx1i3cGH4izY/wJ1v+kTT2KmSzGKJ1jEovBEZb3nHeePUlaQFU9tfm5roxzC7Lmd18v5Rqf/CGAg8zZWvsWGQ/VzrBJeGFQcen6P9NFtdIhgnmU00q4yxSyr0EQU93JUboYjHQfTnX1K1KOvwT6YmP3aT9cEgdQQ/PuPgEpD8N8UkfWdgIdnoV8JmjjeWysRl3I/byWrKHGgM5fFn7ryOdzchTykEUazdc4fKO80KpKoy8gT/DWXaeTqvmU+gr6D6BxLcrduzTxzFjs5qy4yyNGkg00IuK10By0ENIiaXWCgwydL87Bfw1y+7cL4nvzEY0SOmldAO2SDfdUR7STWSwbZejDM9gDPXuWVii91cd2VLt+HkIdmolAgK9ARFuuq0coULWoTuP7AgUpAGJMi7OcgKcBUBsqxdxNMztFbforn+HN8sipN+pXPNSkajPmC7gyHBhdcr3iELKHlglcikGqR5km+UGSKL+7zR/+lM0C5ro8uSfRLHgo7d/5otLe3W2yC4o+mPB2UsCAUIvy06A3Lg69TBhoFH0lWZ4ThTzoK3gPHmq4zVDs5dBNq/7VDUo01B5du8TVbEXrbjB+AxqScH08Ph8h7qxWsFTF61r1yNlvgOO9p22cNewg5XwuLO4khQ5kubXC+QCiKLWIbnpOkJ46b0He163jO2R1TJ/rnfHblC52s3uZwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XOzZKMk0tDccXEb8K8TI2vB+HIKHcDfUtWr9YVSaTN8AlhTdgyiwPOiw2z4nUxSv9E5QsGQCiGmm5feCs98AayOxUwbaippkvNFnbY3t2+0edYt0XayMdzMo0DoGu9JNqKWiV+mIy2DIzcOD+VzBI+2uI64f0snHhVcO05zgILHisANMOaTknZp/Oz3bSju/hW7QU89zOmgui6psuhRbxgsNK1q2m7awaKcd/o25Isp07UDUUSnZ/mdowM3Zr/BZnuBdzLAGxNtaOqApD0EqEwQug5UlOyNxBxhtQpL1XQ0idUZYiViMZL2tfnbwLFkFZ9TjKonCZynF+XgDPdobCErnrrPIPtj2ohktFGfv9WvY3cCn1nzsKsV53fqiVsRUGNAJ8/T1HP8vZwM9Qx16/nJtrkaUP+t7cXqPRFX0wyluVr9vE/yn76f855vidCrW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:54.6531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0c2955-392f-416c-e9c0-08de7f233670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Silence static analysis warnings by ensuring swath size temporaries are
initialized before use. No functional change intended.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 2 +-
 .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index cd8cca651419..48905ca39b70 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -5304,7 +5304,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	double LinesInDETC;
 	unsigned int LinesInDETYRoundedDownToSwath[DC__NUM_DPP__MAX];
 	unsigned int LinesInDETCRoundedDownToSwath;
-	double FullDETBufferingTimeY[DC__NUM_DPP__MAX];
+	double FullDETBufferingTimeY[DC__NUM_DPP__MAX] = { 0 };
 	double FullDETBufferingTimeC;
 	double ActiveDRAMClockChangeLatencyMarginY;
 	double ActiveDRAMClockChangeLatencyMarginC;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 0748ef36a16a..19b142412a84 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -459,8 +459,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 {
 	unsigned int MaximumSwathHeightY[DC__NUM_DPP__MAX];
 	unsigned int MaximumSwathHeightC[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX];
-	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX];
+	unsigned int RoundedUpMaxSwathSizeBytesY[DC__NUM_DPP__MAX] = { 0 };
+	unsigned int RoundedUpMaxSwathSizeBytesC[DC__NUM_DPP__MAX] = { 0 };
 	unsigned int RoundedUpSwathSizeBytesY;
 	unsigned int RoundedUpSwathSizeBytesC;
 	double SwathWidthdoubleDPP[DC__NUM_DPP__MAX];
@@ -2988,7 +2988,7 @@ void dml32_UseMinimumDCFCLK(
 		for  (j = 0; j <= 1; ++j) {
 			double PixelDCFCLKCyclesRequiredInPrefetch[DC__NUM_DPP__MAX];
 			double PrefetchPixelLinesTime[DC__NUM_DPP__MAX];
-			double DCFCLKRequiredForPeakBandwidthPerSurface[DC__NUM_DPP__MAX];
+			double DCFCLKRequiredForPeakBandwidthPerSurface[DC__NUM_DPP__MAX] = { 0 };
 			double DynamicMetadataVMExtraLatency[DC__NUM_DPP__MAX];
 			double MinimumTWait = 0.0;
 			double DPTEBandwidth;
-- 
2.43.0

