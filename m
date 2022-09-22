Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA28C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B645F10EA17;
	Thu, 22 Sep 2022 00:20:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A52110EA0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltEliwK6VBAAhcsa4VMquWTn6Pic+4NXXjM8heHRjfGQQzarbBuS4FUZmV5V8BjvPCv6t1Ve84riIwFNbw0qPJlparmqh1LiPNazeUI5UGOlD8Ss6HoSCVTkCWPhYiKByEbZOZSpsaAjuC9U5ibvl7TmmCOMPvbPtN07nVft0lxjshqIrWh0FwNcbq5/g6sFFN235X/ckjqZcqdm5bHCMz0Gg8L7rfvjxKYq+GfjmHJQDaXEnZJBRS+B5METcptP0ljwlYD6VOxUe6ik5eZZSnuqFLO6zQLKYPuP+ywP1C/xRhrEyZPdALlsaoot6KKDuoVUqvnh+n4RRdl2gxAGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTup/JM5k9NkoUrl54+iNWvUiLXRqX4gpix35aJK2PE=;
 b=QaLuQXRYCo7AKSqEF0DydUSoPr6rhnN4NyK15vUAMejRIDhIwuiwuFYu4Cdkual234X4tswTjIeVHyvIaTaDmhqpIXU4OrvGazfQGZGwnG+hxWMIVL6dcNfmDtAecRXAkwFmcAVEpAYCTdlEmAHuU+KPrloCYorFHURzy2Pe4JmSmHrV8cpzJHLWAruikSVp95A+796IYltHhmClBZTnX8XH99DYh1JsN/lPbBCdBtAoQxlsY6wSTUfiHj91DP0jQLEhatd3SemTEDJTZOoKMPjFDeNUrFha3+xdPpPHt+TI/4NfqN38iuDRK/1w8VcmR4kjHmkkZPslf8G3XUKw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTup/JM5k9NkoUrl54+iNWvUiLXRqX4gpix35aJK2PE=;
 b=C8yg8wgCR0ve9bsMRMMsYq51WGbZj7IIxH4zQL3VBmTOlUsWyLIb1nQiv6ibBVUXfvlKVVyZoOzk4UJkxgXNQNe0ZzmXR9mhVIZx4UsQ2qROShSm51drBx3sfuQ6ffAvqxEKL6fngCPnGi6UuT+BF5fsZqkI3Ue7bHhITzFbjGM=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 00:19:57 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::5c) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:56 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:33 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/31] drm/amd/display: remove redundant
 CalculateRemoteSurfaceFlipDelay's
Date: Wed, 21 Sep 2022 20:18:21 -0400
Message-ID: <20220922001821.320255-32-jdhillon@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM8PR12MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: d27ef293-ab0e-46c1-d49c-08da9c302dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fc7G3jndroEwBPT5VUH/bfjU6kxLE7s77uDCtFI+t2ovsbK8Gc6icVY8dbEQUifX37qFPiABs/f3v5SgfpoPPzkiolf0gSOjQ/XUrZibrqnPGSjTbBsKuuqawNFFJzZ6cSW9FoxqUQTyXlXXt/uYCiRbdauIXCtLi4qAtGWaosumAK2PirM+P5KfvZNPzetPkMWYIUoY4v58r44h53K8u+0GzY3lCd7PyQ67gtG7heF+CXKwDShfDzyA6qpOIa7iwohdJGvzKzW/5FhcxS1pRb6OL86luJbTT1boznNhSoE1WlZLi1PXqr/t/2GdTrHaYHT9IvUEO3kOUZrV6D/Fsp/O7iHiqfdsxlQBYRhAwrmmolJEIUM+SyWDYj2JfuN6U4wpWcvGv5L5PXC4Nfy/W2jX0JwWsm1TCok1bGbFZZa3NGIw/6AFtaUpXD/gGzIbk3JujE7EJJJ4g6gUb0xWEtK/sBrFkhc9FNiH0RDjJtnZnGmzqL3bin1W5nZbtgLzEAYRfyzfR40euV9uuV+kwY0xVvAdvZpGTKtMCnKyafnlFEn2YP0iyTzNWEtoL8HuNXQ2aSyvuyag5qiEF7GGkCv8NuGT5e/ZTxXR0rGLuwLvSCfnW2zu6Cs6TsuWqeeT79Zf1Nk6iSq9/zThXCSRKMkU78PobrthhutNbt/QflEVTgdtGkEWE5USSrzWa7zeD2JIjqkQvDm6gk31gymhHE7BIh4VdR9vcub20lPVbCb3EOho7iCI32OazClu/XcXpxyUqo0FiFpVa6Zc1mCOQ+YqNzcKREdliNty5GKPahs/gfWtt2VlTTt9wXPlz/cK0uBiTRWPAnnCf0zIJlelZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(186003)(336012)(16526019)(82740400003)(36860700001)(2616005)(1076003)(26005)(41300700001)(5660300002)(40480700001)(478600001)(6666004)(40460700003)(8936002)(82310400005)(8676002)(4326008)(356005)(70586007)(70206006)(81166007)(316002)(6916009)(54906003)(2906002)(36756003)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:56.9603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27ef293-ab0e-46c1-d49c-08da9c302dfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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

There are several copies of CalculateRemoteSurfaceFlipDelay.
Reduce to one instance.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        |  4 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 40 +------------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 40 +------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 4ca080950924..8e5d58336bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -158,7 +158,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2909,7 +2909,7 @@ double CalculateTWait(
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 2b4dcae4e432..e9ebc81adc71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -182,7 +182,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2967,44 +2967,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index df4b52b2ed4c..d79b27ba8a9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -210,7 +210,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2980,44 +2980,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
-- 
2.25.1

