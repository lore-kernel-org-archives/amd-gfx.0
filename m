Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F7AC10F07
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4493510E5ED;
	Wed,  6 Dec 2023 19:52:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EA210E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHNWt3nGKkxQfkmCDlJ405IjwzsmOevDhvltx+1dNlXti8EgPCL+hNKu5BUAwj5d0/8TlszRKyjRFyESvW/BhIL0KkTNRNcZ2/ENOWPFvIjt+qC0UJWduUfH4mB9H9/E6Czn4mGIC7xAoSMx0Mk6jj/1m7NGrOS8Q82Gb6QC64ei+BGUXIU2bnd4bhFf3RaNiDRRq4cpzpsxEHBaWstbmlgdEjqdAbu0IHz7WROns32hhKC+uKBw0nLr4tSnYR/jF5Slq0NIPnV/SF59lBwqYt1dE4V1fzvSD4eh/hLK+3JTHo1H/RaqUeghUpydbagxwo6gM8zTeCrTQUmgQEOjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DyM+h9c4Y4LogUDBl8qGDcrv+966HCxIpEfquoI0yI=;
 b=T09822WFNYhI51uwRQ0mPN16K9ezHYvccVxG5L2A27+LUjaPwD+aTCFtJXzN8TKYqMmc816iecn7YyTUXhOMb0sELVSERGKNZPf6BVGptIEBCAz5Aob72QIs/iG4I/qtojcuysGwjViRN7X/81wchpHVjSAD8Gr0vuWG7LBxxENlCR8Fgz5RYkFsfHQHJTOsjrREkgLWjyGJXb4V8L/KOvET2ayK4Pw0sJiNWq5emeDOKImx6GqRwRNjIuaiFAnAwL011SSoEcmyzSyQD8f3Flyjf0ylsEh5ktr1jmvCaekwI2QHpO+Q2YCY6cI06g0t10j976SgNoRAKY5xYNJ85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DyM+h9c4Y4LogUDBl8qGDcrv+966HCxIpEfquoI0yI=;
 b=a8h5aYpiIh/abG2hfPsZwsNyNnnZ1A0Y9iasfl8eZdV2SCKNy3BkXswkSPEsxDg0ORuayf+WyZC9dhFWfmydScvaKKMg70Tu9dOHbKRxcQr8XqYpyhWeZrQ6H/+SPjqAIChPtgdpmNjBv7/X6P+KhDCkgvOgBBR1hXTlhniCC+g=
Received: from CY8PR12CA0061.namprd12.prod.outlook.com (2603:10b6:930:4c::20)
 by CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:45 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::32) by CY8PR12CA0061.outlook.office365.com
 (2603:10b6:930:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:43 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:43 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: For prefetch mode > 0,
 extend prefetch if possible
Date: Wed, 6 Dec 2023 14:52:31 -0500
Message-ID: <20231206195234.182989-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f367cbe-cda6-4582-7186-08dbf694ea47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVrdg7vsPStCT2R/ox+EQRUDLASRxDf7IDT0XLfuGi44aaepUQn9Yhdvelqm4IVItQ/dllbd4g4QrPz+i0cREPucvh1axGgNL6ubkGdjpm5Wjl1SZwhGMS980DSOK3WRR97IRwlv5YDOyTRHnqWNYOApXckdUNKrzodOH4VKtpTlAuaYFeaP3R24m+3EeRhic4BDAE4LPAsWroE2sgNLKmAPDN6wbjAfkSylF2oRYJ9ov228wzNAyQRkvuIdEghofmisBNkTc1DYJ1chdGPhlp8YP1nnCQeqPPaqT/qLiAyK7EF4Bx0Mo7DqavXFe5/uT/xX56zVhEQoqOiDh8F39Jsq2eWnvubKtERi6VlrE/bIGSe9y0VhvVEL4ZC+ydpoIKBHTejUy/N6Kes2/cFZYlhykTkLbGnCxd2qERxQIeN5bjC/OxjGp6Z3JSGmUibIM6J+mV6S5/PmlyEHKSTHdacH1Vusv/NtZGT/+4KROHAzcBbkA7o9H3u9VAlQ8aOgvuxcx8EWtq/EpTN5Wv/Ob0H7B+VujterqA5YpA6BgJCiT3pOf3aYtUMhMkn/DZrhQJTvFpSi+3yaHD2LC8SqwOsYE63F9+6fm8dKawx3U9Fj7Tqx2RTi1naHs0sk/zyJZzPUOtsMXWYGnxI44+D8Ys0V3YCnwftVEvTh8H7WmQNV1b5RetF44oWys47k36AmucipOMDoEST5ZwPzzugzb1GBLPSwys4lHN6Zps+jGzhECPUhoO/kpMd95wZ1TSlVhGCu+q6QpCjyXkvK8Bx/mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(44832011)(7696005)(6666004)(36756003)(2616005)(6916009)(54906003)(316002)(70586007)(478600001)(70206006)(41300700001)(4326008)(2906002)(40480700001)(82740400003)(81166007)(47076005)(40460700003)(36860700001)(26005)(1076003)(83380400001)(86362001)(336012)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:44.8263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f367cbe-cda6-4582-7186-08dbf694ea47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
For mode programming we want to extend the prefetch as much as possible
(up to oto, or as long as we can for equ) if we're not already applying
the 60us prefetch requirement. This is to avoid intermittent underflow
issues during prefetch.

The prefetch extension is applied under the following scenarios:
1. We're in prefetch mode 1 (i.e. we don't support MCLK switch in blank)
2. We're using subvp or drr methods of p-state switch, in which case we
   we don't care if prefetch takes up more of the blanking time

Mode programming typically chooses the smallest prefetch time possible
(i.e. highest bandwidth during prefetch) presumably to create margin between
p-states / c-states that happen in vblank and prefetch. Therefore we only
apply this prefetch extension when p-state in vblank is not required (UCLK
p-states take up the most vblank time).

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../dc/dml/dcn32/display_mode_vba_32.c        |  3 ++
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 33 +++++++++++++++----
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index cbdfb762c10c..6c84b0fa40f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -813,6 +813,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					(v->DRAMSpeedPerState[mode_lib->vba.VoltageLevel] <= MEM_STROBE_FREQ_MHZ ||
 						v->DCFCLKPerState[mode_lib->vba.VoltageLevel] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 							mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
+					mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] > 0 || mode_lib->vba.DRAMClockChangeRequirementFinal == false,
+
 					/* Output */
 					&v->DSTXAfterScaler[k],
 					&v->DSTYAfterScaler[k],
@@ -3317,6 +3319,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->SwathHeightCThisState[k], v->TWait,
 							(v->DRAMSpeedPerState[i] <= MEM_STROBE_FREQ_MHZ || v->DCFCLKState[i][j] <= DCFCLK_FREQ_EXTRA_PREFETCH_REQ_MHZ) ?
 									mode_lib->vba.ip.min_prefetch_in_strobe_us : 0,
+							mode_lib->vba.PrefetchModePerState[i][j] > 0 || mode_lib->vba.DRAMClockChangeRequirementFinal == false,
 
 							/* Output */
 							&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index d940dfa5ae43..80fccd4999a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3423,6 +3423,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightC,
 		double TWait,
 		double TPreReq,
+		bool ExtendPrefetchIfPossible,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
@@ -3892,12 +3893,32 @@ bool dml32_CalculatePrefetchSchedule(
 			/* Clamp to oto for bandwidth calculation */
 			LinesForPrefetchBandwidth = dst_y_prefetch_oto;
 		} else {
-			*DestinationLinesForPrefetch = dst_y_prefetch_equ;
-			TimeForFetchingMetaPTE = Tvm_equ;
-			TimeForFetchingRowInVBlank = Tr0_equ;
-			*PrefetchBandwidth = prefetch_bw_equ;
-			/* Clamp to equ for bandwidth calculation */
-			LinesForPrefetchBandwidth = dst_y_prefetch_equ;
+			/* For mode programming we want to extend the prefetch as much as possible
+			 * (up to oto, or as long as we can for equ) if we're not already applying
+			 * the 60us prefetch requirement. This is to avoid intermittent underflow
+			 * issues during prefetch.
+			 *
+			 * The prefetch extension is applied under the following scenarios:
+			 * 1. We're in prefetch mode > 0 (i.e. we don't support MCLK switch in blank)
+			 * 2. We're using subvp or drr methods of p-state switch, in which case we
+			 *    we don't care if prefetch takes up more of the blanking time
+			 *
+			 * Mode programming typically chooses the smallest prefetch time possible
+			 * (i.e. highest bandwidth during prefetch) presumably to create margin between
+			 * p-states / c-states that happen in vblank and prefetch. Therefore we only
+			 * apply this prefetch extension when p-state in vblank is not required (UCLK
+			 * p-states take up the most vblank time).
+			 */
+			if (ExtendPrefetchIfPossible && TPreReq == 0 && VStartup < MaxVStartup) {
+				MyError = true;
+			} else {
+				*DestinationLinesForPrefetch = dst_y_prefetch_equ;
+				TimeForFetchingMetaPTE = Tvm_equ;
+				TimeForFetchingRowInVBlank = Tr0_equ;
+				*PrefetchBandwidth = prefetch_bw_equ;
+				/* Clamp to equ for bandwidth calculation */
+				LinesForPrefetchBandwidth = dst_y_prefetch_equ;
+			}
 		}
 
 		*DestinationLinesToRequestVMInVBlank = dml_ceil(4.0 * TimeForFetchingMetaPTE / LineTime, 1.0) / 4.0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 592d174df6c6..5d34735df83d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -747,6 +747,7 @@ bool dml32_CalculatePrefetchSchedule(
 		unsigned int SwathHeightC,
 		double TWait,
 		double TPreReq,
+		bool ExtendPrefetchIfPossible,
 		/* Output */
 		double   *DSTXAfterScaler,
 		double   *DSTYAfterScaler,
-- 
2.39.2

