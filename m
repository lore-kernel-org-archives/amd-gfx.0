Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA0FC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B688E10E69F;
	Wed, 10 Jan 2024 21:55:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE6810E6A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1nNvDM2XPws2tKp7N2coYUpc5fuPHaEsEvrvvNnTf3bS8kozBorhbefYNQ/3ZjKMernAil9m5BjtPz9pj6u2tFKouV7FyW2hlLYaposNmGd0r4f+g3K5C8OWyKdUQhYqBCT66U53d72zD3EkwA+Rwt+qaLzsuKgYhR5PiHRVfs1F9tuHdHi6Nm/4+DE3jbY30ir9rLTYU185xX0rXigUN4qq7R0Rky4jtJpqFjKLy8E5Vnn8w4aej5tFNm+7D0zxFQhrqdMR3mg34Ow8hl9bhGxXQmWWhswaFsUDsz2lEnw0ukaf06v4bOg3D7S3BRUxUbnlIWX+b06YWgG8QZyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4Vfyo0sbO+UfPzPFH7vUrltBlrTtHwUXGur3bVgXrM=;
 b=ZZCP/85RdMF54H/R63XDLwxsWah43DnJSWhcKchwFzsPowj66fdcgU+fzbndcfmSmHudamSOQwve9M3i+KCbw37BoEG3qL5fUN5aEpnd2HwYr+f8YC3LqvedeOZam2eX9skNrLxfLS5ZkKYM3YG2Md835FWc7YwUWSlS2oGI8l0BuiOg9KDesFYDR1D2EW3JK+MLEH0rL1ZRCOArGKFvDqgo5euSDq/Lf0dswiQ8XRzj5OT/npT+2a8sMYajkGhmFScqTS6MAES8gsEo3EA3l/kpx1ox7TLw0eo34RJ81sffw79XWxYBH3YtsSg3bj880Ma8wFxOYPGOL2ZEabB8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Vfyo0sbO+UfPzPFH7vUrltBlrTtHwUXGur3bVgXrM=;
 b=dS1Mb1hNWYGbiLUPsqLnoxaZ5v+Sq7gRKnhVgQsO0iXwb9zi/NdEvh0eLvSp/WFfWhBQfEobWrNTimf081Cm12yUAE4XsxbXv5UKFm/jl4bdVQO6dYKDqrdrsEdcnbsLComdLv4WpVAe633jBcyfZeq12gp4iE+KkIhUfS6VNok=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 21:55:05 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::8e) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 21:55:04 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:55:01 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: Floor to mhz when requesting dpp disp
 clock changes to SMU
Date: Wed, 10 Jan 2024 14:52:49 -0700
Message-ID: <20240110215302.2116049-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8ebbc-d960-4f13-41b8-08dc1226cddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwau8IzqFF68f+C8MmAk72wdsZMJxArNBIa52p14IUW/VTdwQMK/i6rIUfesI4cc7LVPTRENouvHdTEk2luaSaoNip5f1x1fUXU+oWYE1zxHCy4NIZpc5NSB/NomidRJidcNIA+P2zYFX4a8OcXfRsJ3/qVhi/TEwX87SO/1K7FxTQ1n//daaa5paN4ZYbYFYZ4Cr0e4eSd5XdZxR3YFA957F7nrEt+EnqxPqPJsLbnUB/Eokew05+/MxG46sSW9AIudM92Qh3SlmbaCWAbJg+z/TiNmdV11yXmtQdY9hmdLmwd0H/1Yw+JjAVQkHvzDbUHMJpa9KxTX2kBBJTeLywVFe6MTMTMudAgB0Mng0OOYPMegRf0OEzdP6hwuQ0aTttgy/HNMlNajYQivPj8DEPRO7XLUsx7dezAY/NCIKqgrk5x0jZBzji/ujRkBByKZtbVKinxxSOGr/PfC1H+W5OtyC90XnwC+bmtmIPCY0UN9Z+A4K4d1sz8PDX5DNlFSRbUGyOumA3jPJ8iT4A3Qy7ypFn+dRnk4JrhGye68LlIdpwtA5hfTpY/JzqkFr5Dk6o6W0zlzVKG0wXb+IzesWBFPNzdO1zj2RLOlmToFIEQidBfUuvLnrjsxof3/VDU1sPDBRrjABtePBU+HRnAmvyCEKIPIuzLSwcAHBNP36EWel5VaTtslljT4uo2+KOkZK+vgTfrr8xAS/Se8dZQlo92S0aUELEjztXcWD1FdEpyIs1UTXMr84YgYxKP86XttmK4MpHMSBOuvOhAGrM636g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(4326008)(2906002)(36756003)(40480700001)(7696005)(5660300002)(82740400003)(6666004)(44832011)(47076005)(6916009)(40460700003)(478600001)(2616005)(1076003)(26005)(36860700001)(41300700001)(86362001)(83380400001)(336012)(426003)(16526019)(356005)(81166007)(70206006)(70586007)(8936002)(8676002)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:55:04.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8ebbc-d960-4f13-41b8-08dc1226cddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
SMU uses discrete dpp and disp clock levels. When we submit SMU request
for clock changes in Mhz we need to floor the requested value from Khz so
SMU will choose the next higher clock level in Khz to set. If we ceil to
Mhz, SMU will have to choose the next higher clock level after the ceil,
which could result in unnecessarily jumpping to the next level.

For example, we request 1911,111Khz which is exactly one of the SMU preset
level. If we pass 1912Mhz, SMU will choose 2150,000 khz. If we pass
1911Mhz, SMU will choose 1911,111kHz, which is the expected value.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 40 +++++++++++++++++--
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  5 +++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index aadd07bc68c5..8fa0aae941c3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -387,7 +387,15 @@ static void dcn32_update_clocks_update_dentist(
 		uint32_t temp_dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / temp_disp_divider;
 
 		if (clk_mgr->smu_present)
-			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(temp_dispclk_khz));
+			/*
+			 * SMU uses discrete dispclk presets. We applied
+			 * the same formula to increase our dppclk_khz
+			 * to the next matching discrete value. By
+			 * contract, we should use the preset dispclk
+			 * floored in Mhz to describe the intended clock.
+			 */
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK,
+					khz_to_mhz_floor(temp_dispclk_khz));
 
 		if (dc->debug.override_dispclk_programming) {
 			REG_GET(DENTIST_DISPCLK_CNTL,
@@ -426,7 +434,15 @@ static void dcn32_update_clocks_update_dentist(
 
 	/* do requested DISPCLK updates*/
 	if (clk_mgr->smu_present)
-		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr->base.clks.dispclk_khz));
+		/*
+		 * SMU uses discrete dispclk presets. We applied
+		 * the same formula to increase our dppclk_khz
+		 * to the next matching discrete value. By
+		 * contract, we should use the preset dispclk
+		 * floored in Mhz to describe the intended clock.
+		 */
+		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK,
+				khz_to_mhz_floor(clk_mgr->base.clks.dispclk_khz));
 
 	if (dc->debug.override_dispclk_programming) {
 		REG_GET(DENTIST_DISPCLK_CNTL,
@@ -734,7 +750,15 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 
 		if (clk_mgr->smu_present && !dpp_clock_lowered)
-			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+			/*
+			 * SMU uses discrete dppclk presets. We applied
+			 * the same formula to increase our dppclk_khz
+			 * to the next matching discrete value. By
+			 * contract, we should use the preset dppclk
+			 * floored in Mhz to describe the intended clock.
+			 */
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK,
+					khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
 
 		update_dppclk = true;
 	}
@@ -765,7 +789,15 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			dcn32_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 			dcn32_update_clocks_update_dentist(clk_mgr, context);
 			if (clk_mgr->smu_present)
-				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+				/*
+				 * SMU uses discrete dppclk presets. We applied
+				 * the same formula to increase our dppclk_khz
+				 * to the next matching discrete value. By
+				 * contract, we should use the preset dppclk
+				 * floored in Mhz to describe the intended clock.
+				 */
+				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK,
+						khz_to_mhz_floor(clk_mgr_base->clks.dppclk_khz));
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 6f4c97543c14..e668cc21cd28 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -393,6 +393,11 @@ static inline int khz_to_mhz_ceil(int khz)
 	return (khz + 999) / 1000;
 }
 
+static inline int khz_to_mhz_floor(int khz)
+{
+	return khz / 1000;
+}
+
 int clk_mgr_helper_get_active_display_cnt(
 		struct dc *dc,
 		struct dc_state *context);
-- 
2.34.1

