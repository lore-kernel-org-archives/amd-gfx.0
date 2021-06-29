Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51275C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CA161D4D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CA161D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22D189F85;
	Tue, 29 Jun 2021 15:55:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F7989F8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4shf70JDEVu21wWCH/h4jGpZz84OOU4iL7gtEv+2WdbsQIVijvLEaZLLQLbFlUar4LA9w6WUv91VdWB8/O1Rofz46fubZubUc7CTDtIUgzDuVSgTl1Y8a18T4+g31MJRnvcbhcsm38IgzOdctrbrxewEV9VWRZOvpKqgG931+8Z5YR712I60gB7WCG0WbN5/URR7WDNsBpb/IlFOEmg4iySrE/hlhAYihXKhaKPIUEPcRegGTn1nLmSqCq/lSLaVhH1Hl0q4gOET7obgCdpO7SytN4qfLBHhEsj00QuZAaEudO0M+gRDISgIxXcBYoWjIkGnKoUhBpB+uSeKck5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+b0VPP1btBWWNU+u1+JKOFJqDB7SoibW19TTO/7kEg=;
 b=G6ZOBszfWoVJD5n7h/MgvaYDeZHWjuxkv/ziSnxnw1MhVFPanppqvUwuULYFYL1pJY2BrErICKIgrAAGgxxcr9TvVPU+OtkrRzzJ4qCd7U5GXnTa+jDkvEVPKG8Ntmilmrk6pE3wGKuQulKMGfl2Ew7/II7+ZudAxeBhJTmRFx+sdtevOo9h5KjiemEiNt9vnlYuvsJiTkUpbFPAyvW3M0FyrljbZPX8et1yC9q48ZHkTqFYzZ2mAwPmoLioG3yqwmVTxC3rct8CXflnK1NC1kdtazMa3un6BGQvYC6VV7WPvjv6CmwzI8LNXJzgzrQjNxkB7boQLrskxoIyr3k9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+b0VPP1btBWWNU+u1+JKOFJqDB7SoibW19TTO/7kEg=;
 b=0viAJ1MlHfGIFr1CYLaS+Jr9LspiuxCrZT2mwxDYe7ruLGbH8wwjY8rVHDkr8ksx0OgMEM9DHA2aUomOljvUMYrrkf8YlB7X9MExzyoWRlnnLW4ckCmP9WRAFa4URifhcp7KQV07MhBM9g01tD0gXs8dDVJxPPdhYm2pkTv/p+w=
Received: from DM5PR15CA0046.namprd15.prod.outlook.com (2603:10b6:4:4b::32) by
 MN2PR12MB3424.namprd12.prod.outlook.com (2603:10b6:208:cc::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Tue, 29 Jun 2021 15:54:58 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::90) by DM5PR15CA0046.outlook.office365.com
 (2603:10b6:4:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:58 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/12] drm/amd/display: Adjust types and formatting for future
 development
Date: Tue, 29 Jun 2021 11:54:18 -0400
Message-ID: <20210629155422.26118-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e0ed442-1281-4233-e38a-08d93b163f57
X-MS-TrafficTypeDiagnostic: MN2PR12MB3424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34245BBC2A2E8B5FF8FD954E98029@MN2PR12MB3424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUExhaz5X0wr7zL615og9w7DF65Hg5deHYhxK21foB1T6kzfi75ZQw3xO5FUVoQJu5KupjY24QEa4QqWx2PIY8t6dMEamqE0P0aDAFWs8NJk4QONFRvjf6lDzX8Bp/We1Swe5bkzzotmcrtx57C6cuVjMed6lL451nk5mS3ZsbStMDCoRwcJP8DPN6PtiiZw7B53VzD5hhNtAOqLFOxwSbZFzuIERgRifg+eOljMqtCPfG3qLHJWj3GvLKUx8qK7Kz7nwZ9waBV2J/QH3Wfyt9Jkh+9auwBicjfhoIoYzNcIOr9ofWp0ed72I892lO6BIAVBADWV6wlpXBzdzzgUoLtJUkeawIg1FIQyphHHqYcZuh09iRDlA8Fbq/K5qZ/K4UKw+WmsLlRLp7OGh+QePeXAVqy6BL/uVOJgZOeytduF/XCIwgF26qMBSX+Xq/Zk1ydWIjd/JoLd3lenp6ZpkgdfWgB7AntdPwW9UeWR869/h2+ALVMytUDLIQQHj8QzQZLHVhZC4X6eWnshgaIbRW0dHIlx8q867TG/XIr5iKilfc02+UIOt2VZnKMqGU+54gmqd4OgDEA+jadKbCBXN8saP49YNyy/db7JXg4a11DiWKooS/QuY9rXwZNEuud724coGkuinTD1n81gv3jTykX8Z502fShDzhDZGLjNJcZgy6DLrL6B38RR2K1Ci+h6PBy7dPI+UySl6ABbHhlLsoZm8KQbcW3m+qykmCLvhT79qD0uJONKVTdTR578eKDgk4RLUi5f7VbNVLXk6Rntbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(46966006)(36840700001)(16526019)(86362001)(30864003)(26005)(6916009)(82740400003)(36860700001)(2906002)(4326008)(81166007)(19627235002)(186003)(8676002)(356005)(6666004)(5660300002)(1076003)(2616005)(316002)(478600001)(45954011)(8936002)(70206006)(70586007)(36756003)(83380400001)(54906003)(47076005)(82310400003)(336012)(426003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:58.6540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ed442-1281-4233-e38a-08d93b163f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3424
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

Type adjustments and formatting fixes.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/dml/dcn21/display_mode_vba_21.c | 11 ++++++-----
 .../display/dc/dml/dcn30/display_mode_vba_30.c | 18 ++++++++++--------
 .../display/dc/dml/dcn31/display_mode_vba_31.c | 15 ++++++++-------
 .../amd/display/dc/dml/display_mode_enums.h    |  4 +++-
 .../drm/amd/display/dc/dml/display_mode_vba.c  | 12 +++++++-----
 .../drm/amd/display/dc/dml/display_mode_vba.h  |  4 ++--
 6 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index c26e742e8137..20a8cd4eb8b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -2267,7 +2267,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					&locals->UrgentBurstFactorLumaPre[k],
 					&locals->UrgentBurstFactorChroma[k],
 					&locals->UrgentBurstFactorChromaPre[k],
-					&locals->NotEnoughUrgentLatencyHiding,
+					&locals->NotEnoughUrgentLatencyHiding[0][0],
 					&locals->NotEnoughUrgentLatencyHidingPre);
 
 			if (mode_lib->vba.UseUrgentBurstBandwidth == false) {
@@ -2300,7 +2300,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		}
 		mode_lib->vba.FractionOfUrgentBandwidth = MaxTotalRDBandwidthNoUrgentBurst / mode_lib->vba.ReturnBW;
 
-		if (MaxTotalRDBandwidth <= mode_lib->vba.ReturnBW && locals->NotEnoughUrgentLatencyHiding == 0 && locals->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
+		if (MaxTotalRDBandwidth <= mode_lib->vba.ReturnBW && locals->NotEnoughUrgentLatencyHiding[0][0] == 0 &&
+				locals->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
 				&& !DestinationLineTimesForPrefetchLessThan2)
 			mode_lib->vba.PrefetchModeSupported = true;
 		else {
@@ -4821,7 +4822,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							&locals->UrgentBurstFactorLumaPre[k],
 							&locals->UrgentBurstFactorChroma[k],
 							&locals->UrgentBurstFactorChromaPre[k],
-							&locals->NotEnoughUrgentLatencyHiding,
+							&locals->NotEnoughUrgentLatencyHiding[0][0],
 							&locals->NotEnoughUrgentLatencyHidingPre);
 
 					if (mode_lib->vba.UseUrgentBurstBandwidth == false) {
@@ -4848,13 +4849,13 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				locals->BandwidthWithoutPrefetchSupported[i][0] = true;
 				if (mode_lib->vba.MaximumReadBandwidthWithoutPrefetch > locals->ReturnBWPerState[i][0]
-						|| locals->NotEnoughUrgentLatencyHiding == 1) {
+						|| locals->NotEnoughUrgentLatencyHiding[0][0] == 1) {
 					locals->BandwidthWithoutPrefetchSupported[i][0] = false;
 				}
 
 				locals->PrefetchSupported[i][j] = true;
 				if (mode_lib->vba.MaximumReadBandwidthWithPrefetch > locals->ReturnBWPerState[i][0]
-						|| locals->NotEnoughUrgentLatencyHiding == 1
+						|| locals->NotEnoughUrgentLatencyHiding[0][0] == 1
 						|| locals->NotEnoughUrgentLatencyHidingPre == 1) {
 					locals->PrefetchSupported[i][j] = false;
 				}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9d2016d8fafe..e1a961a62add 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -2596,7 +2596,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			}
 		}
 
-		v->NotEnoughUrgentLatencyHiding = false;
+		v->NotEnoughUrgentLatencyHiding[0][0] = false;
 		v->NotEnoughUrgentLatencyHidingPre = false;
 
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
@@ -2681,7 +2681,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			if (v->VRatioPrefetchY[k] > 4 || v->VRatioPrefetchC[k] > 4)
 				VRatioPrefetchMoreThan4 = true;
 			if (v->NoUrgentLatencyHiding[k] == true)
-				v->NotEnoughUrgentLatencyHiding = true;
+				v->NotEnoughUrgentLatencyHiding[0][0] = true;
 
 			if (v->NoUrgentLatencyHidingPre[k] == true)
 				v->NotEnoughUrgentLatencyHidingPre = true;
@@ -2689,7 +2689,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		v->FractionOfUrgentBandwidth = MaxTotalRDBandwidthNoUrgentBurst / v->ReturnBW;
 
 
-		if (MaxTotalRDBandwidth <= v->ReturnBW && v->NotEnoughUrgentLatencyHiding == 0 && v->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
+		if (MaxTotalRDBandwidth <= v->ReturnBW && v->NotEnoughUrgentLatencyHiding[0][0] == 0
+				&& v->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
 				&& !DestinationLineTimesForPrefetchLessThan2)
 			v->PrefetchModeSupported = true;
 		else {
@@ -2794,8 +2795,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		}
 
 		v->VStartupLines = v->VStartupLines + 1;
-		v->PrefetchAndImmediateFlipSupported = (v->PrefetchModeSupported == true && ((!v->ImmediateFlipSupport && !v->HostVMEnable && v->ImmediateFlipRequirement != dm_immediate_flip_required) || v->ImmediateFlipSupported)) ? true : false;
-
+		v->PrefetchModeSupported = (v->PrefetchModeSupported == true && ((!v->ImmediateFlipSupport &&
+				!v->HostVMEnable && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required) ||
+				v->ImmediateFlipSupported)) ? true : false;
 	} while (!v->PrefetchModeSupported && v->VStartupLines <= v->MaximumMaxVStartupLines);
 	ASSERT(v->PrefetchModeSupported);
 
@@ -4753,7 +4755,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->HostVMMinPageSize,
 				v->HostVMMaxNonCachedPageTableLevels,
 				v->DynamicMetadataVMEnabled,
-				v->ImmediateFlipRequirement,
+				v->ImmediateFlipRequirement[0],
 				v->ProgressiveToInterlaceUnitInOPP,
 				v->MaxAveragePercentOfIdealSDPPortBWDisplayCanUseInNormalSystemOperation,
 				v->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelMixedWithVMData,
@@ -5164,7 +5166,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					v->NextMaxVStartup = v->NextMaxVStartup - 1;
 				}
 			} while (!((v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
-					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
+					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
 							|| v->ImmediateFlipSupportedForState[i][j] == true))
 					|| (v->NextMaxVStartup == v->MaxMaxVStartup[i][j] && NextPrefetchModeState > MaxPrefetchMode)));
 
@@ -5305,7 +5307,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					&& ViewportExceedsSurface == 0 && v->PrefetchSupported[i][j] == 1 && v->DynamicMetadataSupported[i][j] == 1
 					&& v->TotalVerticalActiveBandwidthSupport[i][j] == 1 && v->VRatioInPrefetchSupported[i][j] == 1
 					&& v->PTEBufferSizeNotExceeded[i][j] == 1 && v->NonsupportedDSCInputBPC == 0
-					&& ((v->HostVMEnable == 0 && v->ImmediateFlipRequirement != dm_immediate_flip_required)
+					&& ((v->HostVMEnable == 0 && v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
 							|| v->ImmediateFlipSupportedForState[i][j] == true)) {
 				v->ModeSupport[i][j] = true;
 			} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index a9667068c690..ce55c9caf9a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -3036,10 +3036,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		}
 
 		v->PrefetchAndImmediateFlipSupported =
-				(v->PrefetchModeSupported == true
-						&& ((!v->ImmediateFlipSupport && !v->HostVMEnable
-								&& v->ImmediateFlipRequirement != dm_immediate_flip_required) || v->ImmediateFlipSupported)) ?
-						true : false;
+				(v->PrefetchModeSupported == true && ((!v->ImmediateFlipSupport && !v->HostVMEnable
+				&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required) ||
+				v->ImmediateFlipSupported)) ? true : false;
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: PrefetchModeSupported %d\n", __func__, v->PrefetchModeSupported);
 		dml_print("DML::%s: ImmediateFlipRequirement %d\n", __func__, v->ImmediateFlipRequirement == dm_immediate_flip_required);
@@ -5103,7 +5102,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->HostVMMinPageSize,
 				v->HostVMMaxNonCachedPageTableLevels,
 				v->DynamicMetadataVMEnabled,
-				v->ImmediateFlipRequirement,
+				v->ImmediateFlipRequirement[0],
 				v->ProgressiveToInterlaceUnitInOPP,
 				v->MaxAveragePercentOfIdealFabricAndSDPPortBWDisplayCanUseInNormalSystemOperation,
 				v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency,
@@ -5542,7 +5541,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 				v->NextPrefetchMode = v->NextPrefetchMode + 1;
 			} while (!((v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
-					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
+					&& ((v->HostVMEnable == false &&
+							v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
 							|| v->ImmediateFlipSupportedForState[i][j] == true))
 					|| (v->NextMaxVStartup == v->MaxMaxVStartup[i][j] && NextPrefetchModeState > MaxPrefetchMode)));
 
@@ -5702,7 +5702,8 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					&& v->PrefetchSupported[i][j] == true && v->DynamicMetadataSupported[i][j] == true
 					&& v->TotalVerticalActiveBandwidthSupport[i][j] == true && v->VRatioInPrefetchSupported[i][j] == true
 					&& v->PTEBufferSizeNotExceeded[i][j] == true && v->NonsupportedDSCInputBPC == false
-					&& ((v->HostVMEnable == false && v->ImmediateFlipRequirement != dm_immediate_flip_required)
+					&& ((v->HostVMEnable == false
+					&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
 							|| v->ImmediateFlipSupportedForState[i][j] == true)
 					&& FMTBufferExceeded == false) {
 				v->ModeSupport[i][j] = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index 64f9c735f74d..1051ca1a23b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -109,7 +109,9 @@ enum clock_change_support {
 };
 
 enum output_standard {
-	dm_std_uninitialized = 0, dm_std_cvtr2, dm_std_cvt
+	dm_std_uninitialized = 0,
+	dm_std_cvtr2,
+	dm_std_cvt
 };
 
 enum mpc_combine_affinity {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index d3b1b6d4ce2f..73f5be26abc4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -396,7 +396,6 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 
 	mode_lib->vba.NumberOfActivePlanes = 0;
 	mode_lib->vba.ImmediateFlipSupport = false;
-	mode_lib->vba.ImmediateFlipRequirement = dm_immediate_flip_not_required;
 	for (j = 0; j < mode_lib->vba.cache_num_pipes; ++j) {
 		display_pipe_source_params_st *src = &pipes[j].pipe.src;
 		display_pipe_dest_params_st *dst = &pipes[j].pipe.dest;
@@ -409,6 +408,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 			continue;
 		visited[j] = true;
 
+		mode_lib->vba.ImmediateFlipRequirement[j] = dm_immediate_flip_not_required;
 		mode_lib->vba.pipe_plane[j] = mode_lib->vba.NumberOfActivePlanes;
 		mode_lib->vba.DPPPerPlane[mode_lib->vba.NumberOfActivePlanes] = 1;
 		mode_lib->vba.SourceScan[mode_lib->vba.NumberOfActivePlanes] =
@@ -667,9 +667,9 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 				mode_lib->vba.ViewportHeightChroma[mode_lib->vba.NumberOfActivePlanes] = src->viewport_height_max / vdiv_c;
 		}
 
-		if (pipes[k].pipe.src.immediate_flip) {
+		if (pipes[j].pipe.src.immediate_flip) {
 			mode_lib->vba.ImmediateFlipSupport = true;
-			mode_lib->vba.ImmediateFlipRequirement = dm_immediate_flip_required;
+			mode_lib->vba.ImmediateFlipRequirement[j] = dm_immediate_flip_required;
 		}
 
 		mode_lib->vba.NumberOfActivePlanes++;
@@ -845,9 +845,10 @@ void PixelClockAdjustmentForProgressiveToInterlaceUnit(struct display_mode_lib *
 
 	//Progressive To Interlace Unit Effect
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
+		mode_lib->vba.PixelClockBackEnd[k] = mode_lib->vba.PixelClock[k];
 		if (mode_lib->vba.Interlace[k] == 1
 				&& mode_lib->vba.ProgressiveToInterlaceUnitInOPP == true) {
-			mode_lib->vba.PixelClock[k] = 2 * mode_lib->vba.PixelClockBackEnd[k];
+			mode_lib->vba.PixelClock[k] = 2 * mode_lib->vba.PixelClock[k];
 		}
 	}
 }
@@ -890,8 +891,9 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 		mode_lib->vba.DISPCLK = soc->clock_limits[mode_lib->vba.VoltageLevel].dispclk_mhz;
 
 	// Total Available Pipes Support Check
-	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k)
+	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
 		total_pipes += mode_lib->vba.DPPPerPlane[k];
+	}
 	ASSERT(total_pipes <= DC__NUM_DPP__MAX);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index d18a021d4d32..90e87961fe3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -676,7 +676,7 @@ struct vba_vars_st {
 	double         AlignedDCCMetaPitchY[DC__NUM_DPP__MAX];
 	double         AlignedDCCMetaPitchC[DC__NUM_DPP__MAX];
 
-	unsigned int NotEnoughUrgentLatencyHiding;
+	unsigned int NotEnoughUrgentLatencyHiding[DC__VOLTAGE_STATES][2];
 	unsigned int NotEnoughUrgentLatencyHidingPre;
 	int PTEBufferSizeInRequestsForLuma;
 	int PTEBufferSizeInRequestsForChroma;
@@ -877,7 +877,7 @@ struct vba_vars_st {
 
 	int PercentMarginOverMinimumRequiredDCFCLK;
 	bool DynamicMetadataSupported[DC__VOLTAGE_STATES][2];
-	enum immediate_flip_requirement ImmediateFlipRequirement;
+	enum immediate_flip_requirement ImmediateFlipRequirement[DC__NUM_DPP__MAX];
 	unsigned int DETBufferSizeYThisState[DC__NUM_DPP__MAX];
 	unsigned int DETBufferSizeCThisState[DC__NUM_DPP__MAX];
 	bool NoUrgentLatencyHiding[DC__NUM_DPP__MAX];
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
