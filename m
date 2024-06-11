Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46ABC27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4084B10E6DE;
	Tue, 11 Jun 2024 16:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XKS3aNAK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A5E10E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGMIjdaVppHf+Psj6mWn5UoivPQy4WkVH1OWyOSGsMnxyjO4sN5Aph5NByekmoagy4HI9ryWpYUsjfM5+CyL8OzGDmyfPfgbvIHYmym8pqzWwlWkyEjrswA4MuK+KWzquqPHqcWYxtbAO+MHdDOB0rv7D24NxNyOMfjkbJ0m5p0q4DlJRmovQbPdaZrKzApGQUWiCBQTQw4LNx+pqmaLIxGeS6bI8Bb46/EDqpZ474NUboRXCAtRv6feUTwZA3agsn0q7cTrHexMlPcVlC/Ma5Gf9BGDe7PirNYF9FgmhJpH4JQZa0fHSs3HU96sLDosTl9S+M4jbhaGjQ+cE9lwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXAlwTOKgC3iDBHF6k9YXPxt3NiY11KygOrQ0z4JpJQ=;
 b=QC8GmNOLrgaKaYHSyb1Hp49vjIQorEm9EX38JGqlYUITj4thxlW99rOs2QZw54yhFtkjlE6czVXV0dpIsjA5y1ZqQOwkN6RW60E2xQTFHLVtfiPLfiU/ebAwFF+sSiD3IJBHpmBbkZp3RhNfvIL28t9W7qoxqRrUR97gqtR8fhW2Pg4m9X3RsJAXJGtq+Cu+feTA3jUuF7TN1gX4/0fB82KCz5uf+eVN3nUG81Wt+I3fnBRaPPC0ip0wf7T3hoAkVFhmClHAWarVZg9v69ZgXavRizEPTph/l7DR1Bu0IUwknaChr9tm/+ODrATO8CpoVHOTHx59kEgMX3WN/gcuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXAlwTOKgC3iDBHF6k9YXPxt3NiY11KygOrQ0z4JpJQ=;
 b=XKS3aNAKT45QhfKa+LtOhcN5JizGRZPU6TQGeNHquHMzoS2MspAOAopqR/3ekINE1ZrBZbAv8eSZE53bZBJGGTWjjDwTm7u4SKjG1ukpNT6Vox+aCyJC/Q0yxBFn646LRvNbO3fRQt+vBhCOqFuS+fbb1ezgksF9DroM16/oKak=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:45 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::93) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:45 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:41 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 24/36] drm/amd/display: Covert integers to double before
 divisions
Date: Tue, 11 Jun 2024 12:51:27 -0400
Message-ID: <20240611165204.195093-25-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: af2c2c05-64c1-40fa-c764-08dc8a36eaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZF+UR9bFl5Uau/msH0ekiTwNWZLl0YvP0XDUpnWdWsRSK/pRCXIwybAuRQRB?=
 =?us-ascii?Q?7RSnI4vlLdUt8yog5IZaEheI8y4sDWBm0BtKG5FbtqqHnArZpW5Fv/InBcB3?=
 =?us-ascii?Q?GL9YN5Yn4WEy0kNM+CcABxGfS1W4ZLMTJbsUZqD1YQhkvEJTZ9mxAThWPbB8?=
 =?us-ascii?Q?v+eNezznxIw8TVGADZkM47dPZGEEI2DHtgUGMNWvUHRzYH2o8YmV+R8pecMz?=
 =?us-ascii?Q?aIET6uybrEoLKYapsShB7Z/443LQtfMRAMkT02CfnZOW7mYVBpD7g3dAoPXH?=
 =?us-ascii?Q?KgeSGhw+ns+/jfGrQt61u0+KcXZuyKxQKMLfbelqQvDs8YSIYoNGMiMFyEHl?=
 =?us-ascii?Q?8aW12t0JGOVSDEUflsIXSSlvu0W1OJpnJp5jFvKVaKnjatzrSNYH9HKiKFYw?=
 =?us-ascii?Q?mCTMI5QdYqNmlImkSrXmPIGayvXCDekG6xdgW/7Qlxt1fFcLfvc0Y7j9oDPC?=
 =?us-ascii?Q?vx6+huIfkWasd79EBlDt7d4msxb3L0M4Va01jV5+/PPExyOGg2cLOG+J994F?=
 =?us-ascii?Q?AuzW6a7FvBipFcVLWfLYGe+FQve3/G5j0cqyJNce0umNQadYPzm6aTJRS5r2?=
 =?us-ascii?Q?OFCEKKR27A1b8dWel+4t6zX9u3kMildfpZm/oCVzvaWGnbmNSeUnF54VBqp5?=
 =?us-ascii?Q?D4imzYPqLuYynqlZmSkkHyNnOkyboB5Qru5Uza1pzVMr74U/fbi5OsetbrZN?=
 =?us-ascii?Q?3j2Y+dOCNGuDQ/ilWzZS+QkY8mEU1BpNe6zi3UidfKggZb82f8sNijmeKu1V?=
 =?us-ascii?Q?mViseFFl+uXIEqAWsoCUr5rHPgtubo/jID+0Gen5vPzSUM21rMHhsJ8zso62?=
 =?us-ascii?Q?p45L/gUlFYav5QZxpnFRjf4xHBiAt65I1jLkO+sgJX6Cpz8JO2qq8srvD3DC?=
 =?us-ascii?Q?WKEpmBKQZOwxkPc5lsLmspSi20dScU8aRf00gNT2rSFC1BdE/EThRL3ZgsGW?=
 =?us-ascii?Q?e650B+0aN/ISs64WNqi7YHXi5QBUtLMmCeI2hVAX+NdnVS/JQ6/HzfrJeNe0?=
 =?us-ascii?Q?+mbDDOp7kIXWSu+jHETdaqOMNH0mmhgyS/xnw5EeLNEegOXqe+HXbevcBHgm?=
 =?us-ascii?Q?82IMY5nDNPUNwGg9rGB2F/M+IHS5QMCeDeSvoMdGRLYb/UKcL1rIhfh34Wlh?=
 =?us-ascii?Q?pYx7CLRvDw+5SWtPMLgJQVPYbRNAApA77cvYTE52OONaEMx/7xwsuqybTBG2?=
 =?us-ascii?Q?xd7toAfzdKWPqL6QRul2tN2Vv3fsqF17dInIPsh+VJpJ8VaZAPzFBzdnOI2e?=
 =?us-ascii?Q?YyAiX9g0y0PTgNQNQhlvbQEViQW1gDHeYZQBoDxO2w0F++8raf2BuAsEdyMe?=
 =?us-ascii?Q?YzCZsaLMgHKdNGf5iYfOhcplTe1KGO3LirFRa0ocXDdLPrnLsjwjDn4J4fN3?=
 =?us-ascii?Q?4LkitU7Qi9pC20sXo9NodgVblJKYRzhPaazWOjA4p2t8wvjwHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:45.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2c2c05-64c1-40fa-c764-08dc8a36eaee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

From: Alex Hung <alex.hung@amd.com>

Integer divisions result in loss of fractional and accuracy is lost
when assigned or compared with double. It is necessary to perform
double/integer instead or explicitly cast them to double.

This fixes 54 UNINTENDED_INTEGER_DIVISION issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 20 ++++++-------
 .../dc/dml/dcn20/display_mode_vba_20.c        | 16 +++++------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  4 +--
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  4 +--
 .../dc/dml/dcn314/display_mode_vba_314.c      |  2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  8 +++---
 .../amd/display/dc/dml2/display_mode_core.c   | 10 +++----
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 28 +++++++++----------
 .../dml21/src/dml2_core/dml2_core_shared.c    | 24 ++++++++--------
 12 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
index f1cde1e4265f..39525721c976 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
@@ -690,7 +690,7 @@ static void hack_disable_optional_pipe_split(struct dcn_bw_internal_vars *v)
 static void hack_force_pipe_split(struct dcn_bw_internal_vars *v,
 		unsigned int pixel_rate_100hz)
 {
-	float pixel_rate_mhz = pixel_rate_100hz / 10000;
+	float pixel_rate_mhz = pixel_rate_100hz / 10000.0;
 
 	/*
 	 * force enabling pipe split by lower dpp clock for DPM0 to just
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 74da9ebda016..54dd7e164635 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1882,10 +1882,10 @@ void dcn20_update_bounding_box(struct dc *dc,
 		bb->clock_limits[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
 				min_dcfclk : min_fclk_required_by_uclk;
 
-		bb->clock_limits[i].socclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
+		bb->clock_limits[i].socclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000.0) ?
 				max_clocks->socClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
-		bb->clock_limits[i].dcfclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
+		bb->clock_limits[i].dcfclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000.0) ?
 				max_clocks->dcfClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
 
 		bb->clock_limits[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
@@ -1917,35 +1917,35 @@ void dcn20_cap_soc_clocks(struct _vcs_dpi_soc_bounding_box_st *bb,
 
 	// First pass - cap all clocks higher than the reported max
 	for (i = 0; i < bb->num_states; i++) {
-		if ((bb->clock_limits[i].dcfclk_mhz > (max_clocks.dcfClockInKhz / 1000))
+		if ((bb->clock_limits[i].dcfclk_mhz > (max_clocks.dcfClockInKhz / 1000.0))
 				&& max_clocks.dcfClockInKhz != 0)
 			bb->clock_limits[i].dcfclk_mhz = (max_clocks.dcfClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].dram_speed_mts > (max_clocks.uClockInKhz / 1000) * 16)
+		if ((bb->clock_limits[i].dram_speed_mts > (max_clocks.uClockInKhz / 1000.0) * 16)
 						&& max_clocks.uClockInKhz != 0)
 			bb->clock_limits[i].dram_speed_mts = (max_clocks.uClockInKhz / 1000) * 16;
 
-		if ((bb->clock_limits[i].fabricclk_mhz > (max_clocks.fabricClockInKhz / 1000))
+		if ((bb->clock_limits[i].fabricclk_mhz > (max_clocks.fabricClockInKhz / 1000.0))
 						&& max_clocks.fabricClockInKhz != 0)
 			bb->clock_limits[i].fabricclk_mhz = (max_clocks.fabricClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].dispclk_mhz > (max_clocks.displayClockInKhz / 1000))
+		if ((bb->clock_limits[i].dispclk_mhz > (max_clocks.displayClockInKhz / 1000.0))
 						&& max_clocks.displayClockInKhz != 0)
 			bb->clock_limits[i].dispclk_mhz = (max_clocks.displayClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].dppclk_mhz > (max_clocks.dppClockInKhz / 1000))
+		if ((bb->clock_limits[i].dppclk_mhz > (max_clocks.dppClockInKhz / 1000.0))
 						&& max_clocks.dppClockInKhz != 0)
 			bb->clock_limits[i].dppclk_mhz = (max_clocks.dppClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].phyclk_mhz > (max_clocks.phyClockInKhz / 1000))
+		if ((bb->clock_limits[i].phyclk_mhz > (max_clocks.phyClockInKhz / 1000.0))
 						&& max_clocks.phyClockInKhz != 0)
 			bb->clock_limits[i].phyclk_mhz = (max_clocks.phyClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].socclk_mhz > (max_clocks.socClockInKhz / 1000))
+		if ((bb->clock_limits[i].socclk_mhz > (max_clocks.socClockInKhz / 1000.0))
 						&& max_clocks.socClockInKhz != 0)
 			bb->clock_limits[i].socclk_mhz = (max_clocks.socClockInKhz / 1000);
 
-		if ((bb->clock_limits[i].dscclk_mhz > (max_clocks.dscClockInKhz / 1000))
+		if ((bb->clock_limits[i].dscclk_mhz > (max_clocks.dscClockInKhz / 1000.0))
 						&& max_clocks.dscClockInKhz != 0)
 			bb->clock_limits[i].dscclk_mhz = (max_clocks.dscClockInKhz / 1000);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 7bf4bb7ad044..565f3c492477 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -1017,7 +1017,7 @@ static unsigned int CalculateVMAndRowBytes(
 			if (ScanDirection == dm_horz)
 				FractionOfPTEReturnDrop = 0;
 			else
-				FractionOfPTEReturnDrop = 7 / 8;
+				FractionOfPTEReturnDrop = 7.0 / 8;
 		} else if (VMMPageSize == 4096 && MacroTileSizeBytes > 4096) {
 			PixelPTEReqHeight = 16 * BlockHeight256Bytes;
 			PixelPTEReqWidth = 16 * BlockWidth256Bytes;
@@ -3231,22 +3231,22 @@ static unsigned int TruncToValidBPP(
 			if (Format == dm_420) {
 				if (DecimalBPP < 6)
 					return BPP_INVALID;
-				else if (DecimalBPP >= 1.5 * DSCInputBitPerComponent - 1 / 16)
-					return 1.5 * DSCInputBitPerComponent - 1 / 16;
+				else if (DecimalBPP >= 1.5 * DSCInputBitPerComponent - 1.0 / 16)
+					return 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 				else
 					return dml_floor(16 * DecimalBPP, 1) / 16;
 			} else if (Format == dm_n422) {
 				if (DecimalBPP < 7)
 					return BPP_INVALID;
-				else if (DecimalBPP >= 2 * DSCInputBitPerComponent - 1 / 16)
-					return 2 * DSCInputBitPerComponent - 1 / 16;
+				else if (DecimalBPP >= 2 * DSCInputBitPerComponent - 1.0 / 16)
+					return 2 * DSCInputBitPerComponent - 1.0 / 16;
 				else
 					return dml_floor(16 * DecimalBPP, 1) / 16;
 			} else {
 				if (DecimalBPP < 8)
 					return BPP_INVALID;
-				else if (DecimalBPP >= 3 * DSCInputBitPerComponent - 1 / 16)
-					return 3 * DSCInputBitPerComponent - 1 / 16;
+				else if (DecimalBPP >= 3 * DSCInputBitPerComponent - 1.0 / 16)
+					return 3 * DSCInputBitPerComponent - 1.0 / 16;
 				else
 					return dml_floor(16 * DecimalBPP, 1) / 16;
 			}
@@ -4322,7 +4322,7 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					locals->RoundedUpMaxSwathSizeBytesC = 0;
 				}
 
-				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024 / 2) {
+				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024.0 / 2) {
 					locals->SwathHeightYPerState[i][j][k] = locals->MaxSwathHeightY[k];
 					locals->SwathHeightCPerState[i][j][k] = locals->MaxSwathHeightC[k];
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 989d83ee3842..9d6675ecc5f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -1077,7 +1077,7 @@ static unsigned int CalculateVMAndRowBytes(
 			if (ScanDirection == dm_horz)
 				FractionOfPTEReturnDrop = 0;
 			else
-				FractionOfPTEReturnDrop = 7 / 8;
+				FractionOfPTEReturnDrop = 7.0 / 8;
 		} else if (VMMPageSize == 4096 && MacroTileSizeBytes > 4096) {
 			PixelPTEReqHeight = 16 * BlockHeight256Bytes;
 			PixelPTEReqWidth = 16 * BlockWidth256Bytes;
@@ -4443,7 +4443,7 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
 					locals->RoundedUpMaxSwathSizeBytesC = 0;
 				}
 
-				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024 / 2) {
+				if (locals->RoundedUpMaxSwathSizeBytesY + locals->RoundedUpMaxSwathSizeBytesC <= locals->DETBufferSizeInKByte[0] * 1024.0 / 2) {
 					locals->SwathHeightYPerState[i][j][k] = locals->MaxSwathHeightY[k];
 					locals->SwathHeightCPerState[i][j][k] = locals->MaxSwathHeightC[k];
 				} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 57cf0358cc43..eb3ed965e48b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -1399,7 +1399,7 @@ static unsigned int CalculateVMAndRowBytes(
 			if (ScanDirection == dm_horz)
 				FractionOfPTEReturnDrop = 0;
 			else
-				FractionOfPTEReturnDrop = 7 / 8;
+				FractionOfPTEReturnDrop = 7.0 / 8;
 		} else if (VMMPageSize == 4096 && MacroTileSizeBytes > 4096) {
 			PixelPTEReqHeightPTEs = 16;
 			*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index e0b52db2c210..1c10ba4dcdde 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1783,7 +1783,7 @@ static unsigned int CalculateVMAndRowBytes(
 		if (ScanDirection != dm_vert)
 			FractionOfPTEReturnDrop = 0;
 		else
-			FractionOfPTEReturnDrop = 7 / 8;
+			FractionOfPTEReturnDrop = 7.0 / 8;
 	} else if (GPUVMMinPageSize == 4 && MacroTileSizeBytes > 4096) {
 		PixelPTEReqHeightPTEs = 16;
 		*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 33cf824c5da1..0b132ce1d2cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1932,7 +1932,7 @@ static unsigned int CalculateVMAndRowBytes(
 		if (ScanDirection != dm_vert)
 			FractionOfPTEReturnDrop = 0;
 		else
-			FractionOfPTEReturnDrop = 7 / 8;
+			FractionOfPTEReturnDrop = 7.0 / 8;
 	} else if (GPUVMMinPageSize == 4 && MacroTileSizeBytes > 4096) {
 		PixelPTEReqHeightPTEs = 16;
 		*PixelPTEReqHeight = 16 * BlockHeight256Bytes;
@@ -3617,7 +3617,7 @@ static double TruncToValidBPP(
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
-		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
+		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index cb50c475746b..debfa31583a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -3714,7 +3714,7 @@ static double TruncToValidBPP(
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
-		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
+		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index ba1310c8fd77..d92fb428ee96 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1401,13 +1401,13 @@ void dml32_CalculateOutputLink(
 			if (Output == dm_dp2p0) {
 				*OutBpp = 0;
 				if ((OutputLinkDPRate == dm_dp_rate_na || OutputLinkDPRate == dm_dp_rate_uhbr10) &&
-						PHYCLKD32PerState >= 10000 / 32) {
+						PHYCLKD32PerState >= 10000.0 / 32) {
 					*OutBpp = dml32_TruncToValidBPP((1 - Downspreading / 100) * 10000,
 							OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd,
 							ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
 							DSCInputBitPerComponent, NumberOfDSCSlices, AudioSampleRate,
 							AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
-					if (*OutBpp == 0 && PHYCLKD32PerState < 13500 / 32 && DSCEnable == true &&
+					if (*OutBpp == 0 && PHYCLKD32PerState < 13500.0 / 32 && DSCEnable == true &&
 							ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
@@ -1423,7 +1423,7 @@ void dml32_CalculateOutputLink(
 					*OutputRate = dm_output_rate_dp_rate_uhbr10;
 				}
 				if ((OutputLinkDPRate == dm_dp_rate_na || OutputLinkDPRate == dm_dp_rate_uhbr13p5) &&
-						*OutBpp == 0 && PHYCLKD32PerState >= 13500 / 32) {
+						*OutBpp == 0 && PHYCLKD32PerState >= 13500.0 / 32) {
 					*OutBpp = dml32_TruncToValidBPP((1 - Downspreading / 100) * 13500,
 							OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd,
 							ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat,
@@ -1601,7 +1601,7 @@ double dml32_TruncToValidBPP(
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
-		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
+		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 	} else if (Format == dm_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index a08ae7b7d39a..791f1725b62b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -2733,7 +2733,7 @@ static dml_float_t TruncToValidBPP(
 		NonDSCBPP1 = 15;
 		NonDSCBPP2 = 18;
 		MinDSCBPP = 6;
-		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
+		MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1.0 / 16;
 	} else if (Format == dml_444) {
 		NonDSCBPP0 = 24;
 		NonDSCBPP1 = 30;
@@ -5404,10 +5404,10 @@ static void CalculateOutputLink(
 			}
 			if (Output == dml_dp2p0) {
 				*OutBpp = 0;
-				if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr10) && PHYCLKD32PerState >= 10000 / 32) {
+				if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr10) && PHYCLKD32PerState >= 10000 / 32.0) {
 					*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
-					if (*OutBpp == 0 && PHYCLKD32PerState < 13500 / 32 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					if (*OutBpp == 0 && PHYCLKD32PerState < 13500 / 32.0 && DSCEnable == dml_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
 						*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
@@ -5417,7 +5417,7 @@ static void CalculateOutputLink(
 					*OutputType = dml_output_type_dp2p0;
 					*OutputRate = dml_output_rate_dp_rate_uhbr10;
 				}
-				if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32PerState >= 13500 / 32) {
+				if ((OutputLinkDPRate == dml_dp_rate_na || OutputLinkDPRate == dml_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32PerState >= 13500 / 32.0) {
 					*OutBpp = TruncToValidBPP((1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 												OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (dml_uint_t)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
 
@@ -9701,7 +9701,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 											+ dml_max(1.0, dml_ceil((dml_float_t) locals->WritebackDelay[k] / ((dml_float_t) mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]), 1.0))
 											+ dml_floor(4.0 * locals->TSetup[k] / ((dml_float_t) mode_lib->ms.cache_display_cfg.timing.HTotal[k] / mode_lib->ms.cache_display_cfg.timing.PixelClock[k]), 1.0) / 4.0;
 
-		if (((locals->VUpdateOffsetPix[k] + locals->VUpdateWidthPix[k] + locals->VReadyOffsetPix[k]) / mode_lib->ms.cache_display_cfg.timing.HTotal[k]) <=
+		if (((locals->VUpdateOffsetPix[k] + locals->VUpdateWidthPix[k] + locals->VReadyOffsetPix[k]) / (double) mode_lib->ms.cache_display_cfg.timing.HTotal[k]) <=
 			(isInterlaceTiming ?
 				dml_floor((mode_lib->ms.cache_display_cfg.timing.VTotal[k] - mode_lib->ms.cache_display_cfg.timing.VActive[k] - mode_lib->ms.cache_display_cfg.timing.VFrontPorch[k] - locals->VStartup[k]) / 2.0, 1.0) :
 				(int) (mode_lib->ms.cache_display_cfg.timing.VTotal[k] - mode_lib->ms.cache_display_cfg.timing.VActive[k] - mode_lib->ms.cache_display_cfg.timing.VFrontPorch[k] - locals->VStartup[k]))) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index eceef0fcb316..be73784e21eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4202,10 +4202,10 @@ static void CalculateOutputLink(
 			}
 			if (Output == dml2_dp2p0) {
 				*OutBpp = 0;
-				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr10) && PHYCLKD32 >= 10000 / 32) {
+				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr10) && PHYCLKD32 >= 10000.0 / 32) {
 					*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 						OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
-					if (*OutBpp == 0 && PHYCLKD32 < 13500 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					if (*OutBpp == 0 && PHYCLKD32 < 13500.0 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
 						*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
@@ -4215,11 +4215,11 @@ static void CalculateOutputLink(
 					*OutputType = dml2_core_internal_output_type_dp2p0;
 					*OutputRate = dml2_core_internal_output_rate_dp_rate_uhbr10;
 				}
-				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32 >= 13500 / 32) {
+				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32 >= 13500.0 / 32) {
 					*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 						OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
 
-					if (*OutBpp == 0 && PHYCLKD32 < 20000 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					if (*OutBpp == 0 && PHYCLKD32 < 20000.0 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
 						*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
@@ -4229,7 +4229,7 @@ static void CalculateOutputLink(
 					*OutputType = dml2_core_internal_output_type_dp2p0;
 					*OutputRate = dml2_core_internal_output_rate_dp_rate_uhbr13p5;
 				}
-				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr20) && *OutBpp == 0 && PHYCLKD32 >= 20000 / 32) {
+				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr20) && *OutBpp == 0 && PHYCLKD32 >= 20000.0 / 32) {
 					*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 20000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 						OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
 					if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
@@ -4306,33 +4306,33 @@ static void CalculateOutputLink(
 				*RequiresFEC = false;
 			}
 			*OutBpp = 0;
-			if (PHYCLKD18 >= 3000 / 18) {
+			if (PHYCLKD18 >= 3000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 3000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "3x3";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_3x3;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 6000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 6000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 6000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "6x3";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_6x3;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 6000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 6000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 6000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "6x4";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_6x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 8000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 8000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 8000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "8x4";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_8x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 10000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 10000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 10000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
-				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0 && PHYCLKD18 < 12000 / 18) {
+				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0 && PHYCLKD18 < 12000.0 / 18) {
 					*RequiresDSC = true;
 					LinkDSCEnable = true;
 					*RequiresFEC = true;
@@ -4342,7 +4342,7 @@ static void CalculateOutputLink(
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_10x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 12000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 12000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 12000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 					*RequiresDSC = true;
@@ -7126,7 +7126,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	mode_lib->ms.support.WritebackLatencySupport = true;
 	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true &&
-			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
+			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024.0 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
 		}
 	}
@@ -11350,7 +11350,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 			mode_lib->mp.MIN_DST_Y_NEXT_START[k] = s->dlg_vblank_start + s->blank_lines_remaining + s->LSetup;
 
 			// debug only
-			if (((mode_lib->mp.VUpdateOffsetPix[k] + mode_lib->mp.VUpdateWidthPix[k] + mode_lib->mp.VReadyOffsetPix[k]) / display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total) <=
+			if (((mode_lib->mp.VUpdateOffsetPix[k] + mode_lib->mp.VUpdateWidthPix[k] + mode_lib->mp.VReadyOffsetPix[k]) / (double) display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total) <=
 				(isInterlaceTiming ?
 					math_floor2((display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_front_porch - mode_lib->mp.VStartup[k]) / 2.0, 1.0) :
 					(int)(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_front_porch - mode_lib->mp.VStartup[k]))) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index cfa4c4475821..0099e58e0b1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -942,7 +942,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	mode_lib->ms.support.WritebackLatencySupport = true;
 	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
 		if (display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].writeback.enable == true &&
-			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
+			(mode_lib->ms.WriteBandwidth[k] > mode_lib->ip.writeback_interface_buffer_size_kbytes * 1024.0 / mode_lib->soc.qos_parameters.writeback.base_latency_us)) {
 			mode_lib->ms.support.WritebackLatencySupport = false;
 		}
 	}
@@ -6731,10 +6731,10 @@ static void CalculateOutputLink(
 			}
 			if (Output == dml2_dp2p0) {
 				*OutBpp = 0;
-				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr10) && PHYCLKD32 >= 10000 / 32) {
+				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr10) && PHYCLKD32 >= 10000.0 / 32) {
 					*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 						OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
-					if (*OutBpp == 0 && PHYCLKD32 < 13500 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
+					if (*OutBpp == 0 && PHYCLKD32 < 13500.0 / 32 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 						*RequiresDSC = true;
 						LinkDSCEnable = true;
 						*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 10000, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
@@ -6744,7 +6744,7 @@ static void CalculateOutputLink(
 					*OutputType = dml2_core_internal_output_type_dp2p0;
 					*OutputRate = dml2_core_internal_output_rate_dp_rate_uhbr10;
 				}
-				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32 >= 13500 / 32) {
+				if ((OutputLinkDPRate == dml2_dp_rate_na || OutputLinkDPRate == dml2_dp_rate_uhbr13p5) && *OutBpp == 0 && PHYCLKD32 >= 13500.0 / 32) {
 					*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, (1 - Downspreading / 100) * 13500, OutputLinkDPLanes, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output,
 						OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, RequiredSlots);
 
@@ -6835,33 +6835,33 @@ static void CalculateOutputLink(
 				*RequiresFEC = false;
 			}
 			*OutBpp = 0;
-			if (PHYCLKD18 >= 3000 / 18) {
+			if (PHYCLKD18 >= 3000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 3000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "3x3";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_3x3;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 6000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 6000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 6000, 3, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "6x3";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_6x3;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 6000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 6000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 6000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "6x4";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_6x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 8000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 8000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 8000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				//OutputTypeAndRate = Output & "8x4";
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_8x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 10000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 10000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 10000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
-				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0 && PHYCLKD18 < 12000 / 18) {
+				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0 && PHYCLKD18 < 12000.0 / 18) {
 					*RequiresDSC = true;
 					LinkDSCEnable = true;
 					*RequiresFEC = true;
@@ -6871,7 +6871,7 @@ static void CalculateOutputLink(
 				*OutputType = dml2_core_internal_output_type_hdmifrl;
 				*OutputRate = dml2_core_internal_output_rate_hdmi_rate_10x4;
 			}
-			if (*OutBpp == 0 && PHYCLKD18 >= 12000 / 18) {
+			if (*OutBpp == 0 && PHYCLKD18 >= 12000.0 / 18) {
 				*OutBpp = TruncToValidBPP(&s->TruncToValidBPP_locals, 12000, 4, HTotal, HActive, PixelClockBackEnd, ForcedOutputLinkBPP, LinkDSCEnable, Output, OutputFormat, DSCInputBitPerComponent, NumberOfDSCSlices, (unsigned int)AudioSampleRate, AudioSampleLayout, ODMModeNoDSC, ODMModeDSC, &dummy);
 				if (*OutBpp == 0 && DSCEnable == dml2_dsc_enable_if_necessary && ForcedOutputLinkBPP == 0) {
 					*RequiresDSC = true;
@@ -11236,7 +11236,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
 			mode_lib->mp.MIN_DST_Y_NEXT_START[k] = s->dlg_vblank_start + s->blank_lines_remaining + s->LSetup;
 
 			// debug only
-			if (((mode_lib->mp.VUpdateOffsetPix[k] + mode_lib->mp.VUpdateWidthPix[k] + mode_lib->mp.VReadyOffsetPix[k]) / display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total) <=
+			if (((mode_lib->mp.VUpdateOffsetPix[k] + mode_lib->mp.VUpdateWidthPix[k] + (double) mode_lib->mp.VReadyOffsetPix[k]) / display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total) <=
 				(isInterlaceTiming ?
 					math_floor2((display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_front_porch - mode_lib->mp.VStartup[k]) / 2.0, 1.0) :
 					(int)(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_front_porch - mode_lib->mp.VStartup[k]))) {
-- 
2.45.1

