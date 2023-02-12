Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E8FC05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6078B10E2F9;
	Sun, 12 Feb 2023 17:00:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D1110E2EB
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZgDUQ4xwepzgZv/ULmUpJyFYOzNkDQRf8kCzGvRf/VPq0+tqWTqhMpwZanHQtF62wWsNw3AudXE3HS2tm6K+zqhhwybwqkgqk12CmOZiYCJ/UWZJcAsjc5B0T/kgk0bbHVlNOOMcny+rZipgsvYtjWwKXgUNPqiAiQ3FoefBPR0kBbKOZFyjaNQLXdQOGYPLPUCufPygHDeN1rY1vgnsDil/TKV3nwlyDXJ5wOXXYdgSVZ60h+awY4BGVeoEjHoaS6VyMNd2JxkQZt4kBzl9RNtRdatj+dqD9lkIEK55sUIOjC4PW8Je757nw7Al2ZUSpQpf9G0BI9TCt1HYUjH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3gYZ15hRqDlAv0BCg6grJANa7P33fItkcVc15TMNiU=;
 b=ZptYY7vUQ4mEDxc/Y1x8GOssIdEzO6DfxiqmMZjAFrh3ZX1Hu1LkYDMKMAuAYlyRT9zY2SxejkJ6DmlXxJDhO8eoKhWTQ4Ezk/9TOfY7LgmDddVFpXslMBQv2FYdeEQBtWIAvw1FnrYvBBOC5zLhO7pQPcb6etgdVNSuSRxQWwlqzAjg8LvRUHKntu8ocewxBAMb/UKB0SjezMICPHIjmDwDpbsUfx/NnJALV6CMXp97mWcIGhjuOAnQB7K2BVesrxuNd+8XJWwFDGXUwoY3ys0OANqLRC1kEXFdhVB8EleABoT9EXwDDkvl0Are35i9gtFPSiBOI8NOzPNn3N+1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3gYZ15hRqDlAv0BCg6grJANa7P33fItkcVc15TMNiU=;
 b=Q910sP7Nl9o1zv2H0x0RRiW3asZD+nh09l7gouInHOHWC7sAPX6fqhiINzO76JHzkWupacJylbuHFY7+u75bF7FnwufhhoY0DQ5q6768Wquw5z8PuOSOd0STq7c3i/DCZyQSAQT/1Q6rd7IcwoNMGlQxOoGMt9pSULxaQH86P/U=
Received: from DS7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::13) by
 PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:37 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::b3) by DS7P222CA0024.outlook.office365.com
 (2603:10b6:8:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:35 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/22] drm/amd/display: Fix prefetch vratio check
Date: Sun, 12 Feb 2023 11:59:38 -0500
Message-ID: <20230212165955.1993601-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT057:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: e1715c90-51f0-4b40-febf-08db0d1aa9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtYl1w5bGhvCMJRT/n09IOGtrOkKLHQyZUbwMSTXbMcZ9bmyXTgj5lDKZjYxYuLossrfFXNZsqScZjYjodX+Am4aeX3Sg4Y2bKA1LL5o86DkQ122Jr5tHhp852VD9lXib+ClOHGmcYcFlTfqaV7QPAmPhbN4Ll1Qeqtf/0/L2756XI5CMJOieMjlM+MKE+RX85vBL84m5rUcHHgPs5F+jDW3PucZyuYXrZsEPyF+tyf4++Sz2Xd+LtGe0KGkiJboNpypszG/CiZLe1aRKW1SZKIKBUC4W+JqVZ5lIHD7VsoZ9+3H05vMZ2Bpap9wAojQKfl3OE2FaRUzLzfOeB+VftCZZN3H7e73yGEEemHvvRJz3Rx18va2Nq7OxqKOlGRjoZDGC/4Q7gviufHor+ZpRa/SazhqENtxMkN1d/5hkJjO8nqtPckDr650n61N9pTUXrlN4r8uOv0/OUFaDFRgDxDQ+Bdi4gZgiEQZElURZCXz72PVYfJw8WYieZ9GaL59ArK8XzsJCPVy9rjWpPaQieWTqIAmchq+6cJiZiRKsV6rLv0CRKLc4i4HMglVuiXDHmO/Hg4XeykwsxUH7ShlnhyZwHrxIC0eFqcEIbiiCl/ojjt7QJay+kVncZpPj7WiQaqWO9vI7Zhs51dSxvdaTpK0t43o5XA+jyK2+EcURo9vMpY234ArqL/9gwWoFeazWSnRK925MsKdEMRmrIQdlKp1CJK2PsafUrcosqnL4ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(356005)(2906002)(8936002)(426003)(40480700001)(36756003)(47076005)(36860700001)(5660300002)(86362001)(70586007)(8676002)(82310400005)(4326008)(6916009)(70206006)(19627235002)(54906003)(83380400001)(316002)(41300700001)(478600001)(40460700003)(44832011)(16526019)(336012)(1076003)(82740400003)(186003)(26005)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:37.1698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1715c90-51f0-4b40-febf-08db0d1aa9d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- For prefetch max vratio check, use the calculated
  prefetch bandwidth from dml32_CalculatePrefetchSchedule
  instead of max prefetch bandwidth
- Also multiply prefetch bandwidth by VRatio since scaling
  is not considered one calculating require prefetch bw

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  9 ++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 21 ++++++++++++++-----
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  5 ++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 55567b9fcfc8..7a99a6656676 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -942,6 +942,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->UrgBurstFactorLumaPre,
 					v->UrgBurstFactorChromaPre,
 					v->UrgBurstFactorCursorPre,
+					v->PrefetchBandwidth,
+					v->VRatio,
+					v->MaxVRatioPre,
 
 					/* output */
 					&MaxTotalRDBandwidth,
@@ -972,6 +975,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
 					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
 					v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_unit_vector,
+					v->PrefetchBandwidth,
+					v->VRatio,
+					v->MaxVRatioPre,
 
 					/* output */
 					&v->dummy_vars.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation.dummy_single[0],
@@ -3373,6 +3379,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							mode_lib->vba.UrgentBurstFactorLumaPre,
 							mode_lib->vba.UrgentBurstFactorChromaPre,
 							mode_lib->vba.UrgentBurstFactorCursorPre,
+							v->PrefetchBW,
+							v->VRatio,
+							v->MaxVRatioPre,
 
 							/* output */
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_single[0],   // Single  *PrefetchBandwidth
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 069e9abb83cb..d1000aa4c481 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -6143,9 +6143,12 @@ void dml32_CalculatePrefetchBandwithSupport(unsigned int NumberOfActiveSurfaces,
 		double UrgentBurstFactorLumaPre[],
 		double UrgentBurstFactorChromaPre[],
 		double UrgentBurstFactorCursorPre[],
+		double PrefetchBW[],
+		double VRatio[],
+		double MaxVRatioPre,
 
 		/* output */
-		double  *PrefetchBandwidth,
+		double  *MaxPrefetchBandwidth,
 		double  *FractionOfUrgentBandwidth,
 		bool *PrefetchBandwidthSupport)
 {
@@ -6153,25 +6156,33 @@ void dml32_CalculatePrefetchBandwithSupport(unsigned int NumberOfActiveSurfaces,
 	double ActiveBandwidthPerSurface;
 	bool NotEnoughUrgentLatencyHiding = false;
 	double TotalActiveBandwidth = 0;
+	double TotalPrefetchBandwidth = 0;
+
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (NotUrgentLatencyHiding[k]) {
 			NotEnoughUrgentLatencyHiding = true;
 		}
 	}
 
-	*PrefetchBandwidth = 0;
+	*MaxPrefetchBandwidth = 0;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		ActiveBandwidthPerSurface = ReadBandwidthLuma[k] * UrgentBurstFactorLuma[k] + ReadBandwidthChroma[k] * UrgentBurstFactorChroma[k] + cursor_bw[k] * UrgentBurstFactorCursor[k] + NumberOfDPP[k] * (meta_row_bandwidth[k] + dpte_row_bandwidth[k]);
 
 		TotalActiveBandwidth += ActiveBandwidthPerSurface;
 
-		*PrefetchBandwidth = *PrefetchBandwidth + dml_max3(NumberOfDPP[k] * prefetch_vmrow_bw[k],
+		TotalPrefetchBandwidth = TotalPrefetchBandwidth + PrefetchBW[k] * VRatio[k];
+
+		*MaxPrefetchBandwidth = *MaxPrefetchBandwidth + dml_max3(NumberOfDPP[k] * prefetch_vmrow_bw[k],
 				ActiveBandwidthPerSurface,
 				NumberOfDPP[k] * (PrefetchBandwidthLuma[k] * UrgentBurstFactorLumaPre[k] + PrefetchBandwidthChroma[k] * UrgentBurstFactorChromaPre[k]) + cursor_bw_pre[k] * UrgentBurstFactorCursorPre[k]);
 	}
 
-	*PrefetchBandwidthSupport = (*PrefetchBandwidth <= ReturnBW) &&  (*PrefetchBandwidth <= TotalActiveBandwidth * __DML_MAX_BW_RATIO_PRE__) && !NotEnoughUrgentLatencyHiding;
-	*FractionOfUrgentBandwidth = *PrefetchBandwidth / ReturnBW;
+	if (MaxVRatioPre == __DML_MAX_VRATIO_PRE__)
+		*PrefetchBandwidthSupport = (*MaxPrefetchBandwidth <= ReturnBW) && (TotalPrefetchBandwidth <= TotalActiveBandwidth * __DML_MAX_BW_RATIO_PRE__) && !NotEnoughUrgentLatencyHiding;
+	else
+		*PrefetchBandwidthSupport = (*MaxPrefetchBandwidth <= ReturnBW) && !NotEnoughUrgentLatencyHiding;
+
+	*FractionOfUrgentBandwidth = *MaxPrefetchBandwidth / ReturnBW;
 }
 
 double dml32_CalculateBandwidthAvailableForImmediateFlip(unsigned int NumberOfActiveSurfaces,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index d41c4d8b0c7a..9ba792c633a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -1096,9 +1096,12 @@ void dml32_CalculatePrefetchBandwithSupport(unsigned int NumberOfActiveSurfaces,
 		double UrgentBurstFactorLumaPre[],
 		double UrgentBurstFactorChromaPre[],
 		double UrgentBurstFactorCursorPre[],
+		double PrefetchBW[],
+		double VRatio[],
+		double MaxVRatioPre,
 
 		/* output */
-		double  *PrefetchBandwidth,
+		double  *MaxPrefetchBandwidth,
 		double  *FractionOfUrgentBandwidth,
 		bool *PrefetchBandwidthSupport);
 
-- 
2.25.1

