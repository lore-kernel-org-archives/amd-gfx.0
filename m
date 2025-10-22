Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE85CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBA910E6F9;
	Wed, 22 Oct 2025 07:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Elylg5HP";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499B010E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP4xtevMLVzIQYBpBwRw4oOShcqzmnOGWdwbZZfiIRaCSPAdgr5NOQYfAnlC8hLiK65sSMdlABpWQZIX157SzR9a/vQNgUS4qI6Ac1CDnASuWuxt4+ceK8//Z4GqYcc/rqV4nBR/i0svWELtkSMFkgkiCfaQNK1KzYHesMhUUQiwjYrPu/APEVMx3bya6BCUQTRdIs5GGFqV/iCbqUwgMfQrJhQGXKyyda/yvbKUghr6YMe33juzSaPT4gESYbzCyGpg2kGa4+6Neka6hO2++BB4ukOwFKnCmwybrRrXv1wYIYZT+jtBWJdPcpnqRFNcU8U88SASJrO9lsubpAusHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7flbqwEoee7IiS0vh2gFNfzcieFeNXEbBB3LChmdkqg=;
 b=At/5Y1cx4Rgz0I6zSVX+FsoAsWEArzoBXmYJwttUaZox9XGByctv9zOsU7wKBZtkE91IO31M8te8ijtLsH5K10vD5Xjr40NlmA3NzDzIyOuyujoqtRVeaNrci2IEUzTloXlfEOb/XmCgh7Tc7H9BgRh4VGXbcVrZtFBsZ75xhgTj4rm1aSztSgadtFUO2ueDQ35l0PU+3BmkZiG9WjIuHrIgyU7O9yZPNR5ChA0Sm7qFm4RPHvqsr2c9jPnoqc9WCvbpBNtpcz1kOuIjBmFkQiLIFHe2uMl5EOjP33YQa94ywCwuS0qQKW1atG9L+iYmRWUzKL3aZBhgSiE3iQkMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7flbqwEoee7IiS0vh2gFNfzcieFeNXEbBB3LChmdkqg=;
 b=Elylg5HPvLNHN+3+8gbSbKXpmOnZpibk2yx4EPnlIhdu67oGumBWy3mcEIWJtgz2pHJFwZCUf1nhCSBJkZ2kVe0vOtgnw4Rv2LiseO7basCWzb8i7LJ2r7iVVmw3wdLvhEs8iZa3+ALdUBG/Afj/d0MVTCPj8YG9o8mTnaMC8QM=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 07:34:00 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::6f) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:58 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:33:55 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 03/20] drm/amd/display: Add opp count validation to dml2.1
Date: Wed, 22 Oct 2025 15:30:15 +0800
Message-ID: <20251022073332.666119-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: a168f848-f72c-4039-915e-08de113d5e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZyoENPP58tiZn+WKB1tbmxtkCa3gXv2OT1p1B7MZd9bVMWEaRXVOGAATbnH?=
 =?us-ascii?Q?fYxViwlbFgpkSQS7a+P2251UHTANt21t8jcXIJNmCH+3TF2B0mt+gqOAQR++?=
 =?us-ascii?Q?VAdEHCdXDtwnIV+bJqaxzq+vztjuJ+MxCaJRXVazIiTwDbmUuvmSZZVZ3z8L?=
 =?us-ascii?Q?4KkrTs+SOCF2fPGr/meXCegzPmyfXRacDnCIhG9Oc6AEpLpKZOP5+gqqOKY2?=
 =?us-ascii?Q?Ri0iDZwkwkVuyA879WNPEKhTS1z0qS7bBZ9Dpgk84V9UNnDaW9Pumvm3sQTq?=
 =?us-ascii?Q?l3+dDVwxlELXgEWuDxw3aC2b1nh5Qm0B58V7F5Q7Ov387E/eYxApaxniHu1l?=
 =?us-ascii?Q?in3D38fX9/mnNpMEt/6fCnibDySAgjtz+39hDBZq/vVRsdIMC8A0WRBEVjsm?=
 =?us-ascii?Q?BP/nJUccxdkG2NEnK39XK8+IIe5SURv9J9EresvmWI+bBh9DRIClx/BsIElK?=
 =?us-ascii?Q?DhgadpMEOmwbWh9+2/SmT3tZ3rPR8GUzgcvRaC/NQh/xaOLlQUQGZX+M3IuS?=
 =?us-ascii?Q?M9Uw4tUNzf8yhHqBUyrfL7K0NuTW+FrOJACMFTdpRmPlEI+2WhgzEZm03djR?=
 =?us-ascii?Q?DEi5tB1uBXVL06pcSpE63pJSuZybjcSZuVfnO5Y8g+axt8uHf9sfGn4CXacZ?=
 =?us-ascii?Q?sEeBij6QeRYPjHfmqMHO/tl3dZ7F7EDha2UCJ/8PUqR0KfG8RgBqn8Ml8WKw?=
 =?us-ascii?Q?9XI+gjUqu3IFN/12F84W2GGNGezbZo+pynQMS+5U9R8jqG3KGK+knNWTLgEH?=
 =?us-ascii?Q?rId0QyvFIZ4i+Z76Pg2Id1niXv+ELJVQiRTuSk8IIJu9g2A5/DrjVM/4DW05?=
 =?us-ascii?Q?FNqYcSPZG9cIUIFcPYoNfT7FaManJFGP+nK3XqKbHzy0w/0AGX0gDMY/ktLe?=
 =?us-ascii?Q?ZwQRLsfH0NysiwSOO6pGsrNK0HrrhOmdHBKHcxa5Jb4QnC3pdThPvZbvUKUc?=
 =?us-ascii?Q?nSal0lbY87PKr/HTjQKzM1EJ/BvcKZY56dB7hK4CxBnSln/jcdBoiHTNIoH+?=
 =?us-ascii?Q?0CBOrAjOHw6i/mPNTnDYkwMKuMrxnG8FAcUK4k8m93tQqxW9FZ5H1rusujTw?=
 =?us-ascii?Q?ekwDFrR6iyfYMt87Ic0PXX3iLcp5NIHP7tjX3bF0Ut9CYptM60IsS5M+QSgo?=
 =?us-ascii?Q?x2nQD6ZtfM83fDjXrHO47IEkr1C86egRnSWl3FnzxI4euBrITnAmfTeKtx8w?=
 =?us-ascii?Q?eA6eM8yBTQCIIKC4NBJxMDZe5KRUPm7f+InZxNzvbfmwPfQ6WzkSzBqUb4la?=
 =?us-ascii?Q?9qWd5i0ED/fz9hWxASlfFzsfhLs/1gDhbeyayawmBYqKNU5xwAU4PhW078/z?=
 =?us-ascii?Q?JaKIMTIMpLMeLpLhVQAVRBs4LQwDHLTZuzXY1fc506pMUOVOnza7zB27ROtW?=
 =?us-ascii?Q?zYgqMM/fCTGe1O7ICGBLzNKywGSsUb3ecGOmNDBS35HdcpbMLB23kXt1/pBO?=
 =?us-ascii?Q?mGkqnK4ixFmsSuQI8suykbk8XQnfMVovP0JuTj2TK+2V2j5ocbPxFw3JfYLv?=
 =?us-ascii?Q?XZ3/Emh8gAsbgOu9XkE3L9sLiYVo3JeY2AeKGaT1gUNkFAjxtOddyVPbtBP6?=
 =?us-ascii?Q?GskDj60Bu6gygRMRvKhUHqGwjRDlIsLggbPhVi8Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:00.0162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a168f848-f72c-4039-915e-08de113d5e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Newer asics can have mismatching dpp and opp counts and
dml needs to account for this.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 27 ++++++++++++++++---
 .../src/dml2_core/dml2_core_shared_types.h    |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 6ee37386f672..eba948e187c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -28,6 +28,7 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.writeback_interface_buffer_size_kbytes = 90,
 	//Number of pipes after DCN Pipe harvesting
 	.max_num_dpp = 4,
+	.max_num_opp = 4,
 	.max_num_otg = 4,
 	.max_num_wb = 1,
 	.max_dchub_pscl_bw_pix_per_clk = 4,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 4ccdb179b001..f16792f79bef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4047,7 +4047,9 @@ static bool ValidateODMMode(enum dml2_odm_mode ODMMode,
 	bool UseDSC,
 	unsigned int NumberOfDSCSlices,
 	unsigned int TotalNumberOfActiveDPP,
+	unsigned int TotalNumberOfActiveOPP,
 	unsigned int MaxNumDPP,
+	unsigned int MaxNumOPP,
 	double DISPCLKRequired,
 	unsigned int NumberOfDPPRequired,
 	unsigned int MaxHActiveForDSC,
@@ -4063,7 +4065,7 @@ static bool ValidateODMMode(enum dml2_odm_mode ODMMode,
 
 	if (DISPCLKRequired > MaxDispclk)
 		return false;
-	if ((TotalNumberOfActiveDPP + NumberOfDPPRequired) > MaxNumDPP)
+	if ((TotalNumberOfActiveDPP + NumberOfDPPRequired) > MaxNumDPP || (TotalNumberOfActiveOPP + NumberOfDPPRequired) > MaxNumOPP)
 		return false;
 	if (are_odm_segments_symmetrical) {
 		if (HActive % (NumberOfDPPRequired * pixels_per_clock_cycle))
@@ -4109,7 +4111,9 @@ static noinline_for_stack void CalculateODMMode(
 	double MaxDispclk,
 	bool DSCEnable,
 	unsigned int TotalNumberOfActiveDPP,
+	unsigned int TotalNumberOfActiveOPP,
 	unsigned int MaxNumDPP,
+	unsigned int MaxNumOPP,
 	double PixelClock,
 	unsigned int NumberOfDSCSlices,
 
@@ -4179,7 +4183,9 @@ static noinline_for_stack void CalculateODMMode(
 			UseDSC,
 			NumberOfDSCSlices,
 			TotalNumberOfActiveDPP,
+			TotalNumberOfActiveOPP,
 			MaxNumDPP,
+			MaxNumOPP,
 			DISPCLKRequired,
 			NumberOfDPPRequired,
 			MaxHActiveForDSC,
@@ -8358,6 +8364,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	CalculateSwathAndDETConfiguration(&mode_lib->scratch, CalculateSwathAndDETConfiguration_params);
 
 	mode_lib->ms.TotalNumberOfActiveDPP = 0;
+	mode_lib->ms.TotalNumberOfActiveOPP = 0;
 	mode_lib->ms.support.TotalAvailablePipesSupport = true;
 
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
@@ -8393,7 +8400,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			mode_lib->ms.max_dispclk_freq_mhz,
 			false, // DSCEnable
 			mode_lib->ms.TotalNumberOfActiveDPP,
+			mode_lib->ms.TotalNumberOfActiveOPP,
 			mode_lib->ip.max_num_dpp,
+			mode_lib->ip.max_num_opp,
 			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
 			mode_lib->ms.support.NumberOfDSCSlices[k],
 
@@ -8412,7 +8421,9 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			mode_lib->ms.max_dispclk_freq_mhz,
 			true, // DSCEnable
 			mode_lib->ms.TotalNumberOfActiveDPP,
+			mode_lib->ms.TotalNumberOfActiveOPP,
 			mode_lib->ip.max_num_dpp,
+			mode_lib->ip.max_num_opp,
 			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
 			mode_lib->ms.support.NumberOfDSCSlices[k],
 
@@ -8516,20 +8527,23 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		mode_lib->ms.MPCCombine[k] = false;
 		mode_lib->ms.NoOfDPP[k] = 1;
+		mode_lib->ms.NoOfOPP[k] = 1;
 
 		if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_4to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 4;
+			mode_lib->ms.NoOfOPP[k] = 4;
 		} else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_3to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 3;
+			mode_lib->ms.NoOfOPP[k] = 3;
 		} else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_2to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 2;
+			mode_lib->ms.NoOfOPP[k] = 2;
 		} else if (display_cfg->plane_descriptors[k].overrides.mpcc_combine_factor == 2) {
 			mode_lib->ms.MPCCombine[k] = true;
 			mode_lib->ms.NoOfDPP[k] = 2;
-			mode_lib->ms.TotalNumberOfActiveDPP++;
 		} else if (display_cfg->plane_descriptors[k].overrides.mpcc_combine_factor == 1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 1;
@@ -8540,7 +8554,6 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			if ((mode_lib->ms.MinDPPCLKUsingSingleDPP[k] > mode_lib->ms.max_dppclk_freq_mhz) || !mode_lib->ms.SingleDPPViewportSizeSupportPerSurface[k]) {
 				mode_lib->ms.MPCCombine[k] = true;
 				mode_lib->ms.NoOfDPP[k] = 2;
-				mode_lib->ms.TotalNumberOfActiveDPP++;
 			}
 		}
 #if defined(__DML_VBA_DEBUG__)
@@ -8548,8 +8561,16 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 #endif
 	}
 
+	mode_lib->ms.TotalNumberOfActiveDPP = 0;
+	mode_lib->ms.TotalNumberOfActiveOPP = 0;
+	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
+		mode_lib->ms.TotalNumberOfActiveDPP += mode_lib->ms.NoOfDPP[k];
+		mode_lib->ms.TotalNumberOfActiveOPP += mode_lib->ms.NoOfOPP[k];
+	}
 	if (mode_lib->ms.TotalNumberOfActiveDPP > (unsigned int)mode_lib->ip.max_num_dpp)
 		mode_lib->ms.support.TotalAvailablePipesSupport = false;
+	if (mode_lib->ms.TotalNumberOfActiveOPP > (unsigned int)mode_lib->ip.max_num_opp)
+		mode_lib->ms.support.TotalAvailablePipesSupport = false;
 
 
 	mode_lib->ms.TotalNumberOfSingleDPPSurfaces = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index ff1c47347610..051c31ec2f0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -36,6 +36,7 @@ struct dml2_core_ip_params {
 	unsigned int max_line_buffer_lines;
 	unsigned int writeback_interface_buffer_size_kbytes;
 	unsigned int max_num_dpp;
+	unsigned int max_num_opp;
 	unsigned int max_num_otg;
 	unsigned int TDLUT_33cube_count;
 	unsigned int max_num_wb;
@@ -570,6 +571,7 @@ struct dml2_core_internal_mode_support {
 	enum dml2_odm_mode ODMMode[DML2_MAX_PLANES];
 	unsigned int SurfaceSizeInMALL[DML2_MAX_PLANES];
 	unsigned int NoOfDPP[DML2_MAX_PLANES];
+	unsigned int NoOfOPP[DML2_MAX_PLANES];
 	bool MPCCombine[DML2_MAX_PLANES];
 	double dcfclk_deepsleep;
 	double MinDPPCLKUsingSingleDPP[DML2_MAX_PLANES];
@@ -580,6 +582,7 @@ struct dml2_core_internal_mode_support {
 	bool PTEBufferSizeNotExceeded[DML2_MAX_PLANES];
 	bool DCCMetaBufferSizeNotExceeded[DML2_MAX_PLANES];
 	unsigned int TotalNumberOfActiveDPP;
+	unsigned int TotalNumberOfActiveOPP;
 	unsigned int TotalNumberOfSingleDPPSurfaces;
 	unsigned int TotalNumberOfDCCActiveDPP;
 	unsigned int Total3dlutActive;
-- 
2.43.0

