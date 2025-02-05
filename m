Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F4AC0219A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED51B10E725;
	Wed,  5 Feb 2025 03:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJ3rEtz9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03B510E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGoGP4Xt51zSSkzl8K42KBABiDSAPijSCvY91KvkmlUtZnvIPMJrOsaP01P3gSxBpf0hHcWdqR/qHxNOKIwWW3lGeV7kCmQakt0Iym8igqr1Dvsb9Hm7qFvqhlyFFNm2+jaaupyt+78kCzRkycApCU1J3iRB3lyg4ntwCuPsnM89I3n5MLI9xjdkhH/WUvwpOXAabqapv3g6j0/91MVZJ6bqBWkeqj+c0GpOPRCuyORNR2spOkTM8oJ2QrCF9IOBfHG8XXC9bNPKc0D/kiIngMUBi9tAdJTqAyBY+9G6wKBc2UQCh0Rol89KThdf475ay47qcT8WdTptBk+VtwdJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ummMW9JI3b2KKrNn72Z+8ZrcQJWUz8ItGVmBJLD/fOc=;
 b=e+qYWoL5K82Q4Sak3jwRE8vce8Kcne88uc+R6JqHaRdJM6vUCWjUroB6ULgoEOcyUEpmQ0+RCnGmwPPmjyFh3rDzFsPvit1iqlBuLyiZrJ7252neB4HgVA6WWNHUmZVXyq50K9J3rx8zLClDydQqulSeOchpu7tNsBTxbylkLI44uwIIkYiFECnn2bpPqEaWLi09LttjMDg2lE2SR3P4bMkueCRSbD09FithlssduwkHVYLE1xW8j59Aq3DmDfFkKW0/DbbyHUDOmRlw23b8rSba6tmFCe4aYIy3mfG/7moacjewIzmY9c/tjNqdrioKpdRLkpxCQYMYvaUYzWytaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ummMW9JI3b2KKrNn72Z+8ZrcQJWUz8ItGVmBJLD/fOc=;
 b=WJ3rEtz9qXo1m8LC/S979BrskYrTlg6BqvzoI6X9RpVlHIG+CWAnPj2CmgbviSbOUq3teQjp9ncBtm7ofiEhe84Y/vAWcCBp361wjx7pju7QALfkCuYeopOQAGidKFKsYX0SptWBTYwT0AjOVYsqhuqct22t0hX6HENeW2Z2gA0=
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:11:54 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::e4) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 03:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:11:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:19 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:15 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem
 Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Wayne
 Lin <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, "Taimur Hassan"
 <Syed.Hassan@amd.com>
Subject: [PATCH 07/12] drm/amd/display: Add DCN36 DML2 support
Date: Wed, 5 Feb 2025 11:08:52 +0800
Message-ID: <20250205030857.2608094-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 697bd60b-31e4-401c-66b2-08dd4592d7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q9JSGUb99SFBOWbTYTXg0tEIM5UvL0DcBDvTF0aLBBQJPgYAOOUNNmepER6v?=
 =?us-ascii?Q?jqVyZ/mDcsoc2PzDMoI04CbWxTnAGS7on7Orhl9npUsxGCNZHUJs9+ThWfL5?=
 =?us-ascii?Q?knrERC8so6FQWkhmA/bYO/CuQVcKn1/lQdwfEwrtdmJpO6s/p92iemZBsvPW?=
 =?us-ascii?Q?AfCtIH5yax/iOKiM+qiW2oRXkPH/uTuTOrtu9T5Zn+p9LMsrIW4mY9CL06KC?=
 =?us-ascii?Q?UwY3kCoJTC4D58Nl/rxp+1tu3IlVnOU+ygwNC/XDe7Va+ATQQI5ywO8GVyBQ?=
 =?us-ascii?Q?n3CWnGeF5C1zUgP/OoVa51gVeZANpI7rVVT8BUNK73EuzYFFNeQB+EC7Zjex?=
 =?us-ascii?Q?XAC9bdwG2JGhkEFYRSwLlXcmxIPY5RZAbTpIqgEBHT78XitaJjY1fG5HCmIY?=
 =?us-ascii?Q?C7/y4hC3olTH8hDf7hi0S+3Lp7D/549B/0bCsceh1ASrT2DyWhld5aMlhwOn?=
 =?us-ascii?Q?NXa2kxlSgVZrXQ2+/CuYybvUJXs0H200cuaWXZivJ/1TTOLGx/v/ZcWidfs/?=
 =?us-ascii?Q?9u7EfV9DTPJIEUKeYA8tabYO7eSfJw1GFtvndbmj993gelP6nGrB4CNSWyR8?=
 =?us-ascii?Q?H1ubuJPlkGXDeuu4vX0gA+6gQ16xNqUIKRjD/uyiD51rL3vzukIEXs5gz5x2?=
 =?us-ascii?Q?spGNNqQKoTMPlst3k2CqGvMJKc/TaK005A5wjakRxTHXRR9S9TGkZsyDANzb?=
 =?us-ascii?Q?C5RDY6LflPrysAjVzgMZ2WtRCjH3jgvwCtYyjFBoXnzE4SYrmD7s5cRKLfkE?=
 =?us-ascii?Q?1XvOm0shb5K8LVG4QXBgAFKLxubcXRK2R2wQVTzSsb5UhoaXx4SYE6CH3pom?=
 =?us-ascii?Q?JM6CtkIFleKASd8vPfBq12LPI4u0lw7QPx56E5aNwGNOvTxjZ3nWL0MoOGm2?=
 =?us-ascii?Q?Xn6slzuXZnMoY7AUj4HZ7LPhLHFDWDgsIGFHVLYe0h+yldTC2VLWNeDflSk5?=
 =?us-ascii?Q?NgTyMkxQLcwR1yLwWwMtIs6AhcI4CbXzohjsH3NcNQ3Q8D6m8cw9lIxTESvZ?=
 =?us-ascii?Q?Bh2sbxYFOUTZMim1DifGPBxQA8tNdV6okMFrc3vSOaItlIfMhcoyhA5cRsfq?=
 =?us-ascii?Q?BOcinz55q0rJWFsYjFHOgH0p84rDxiV7AwckqlxwrszAaZ6SpZBgYBfuRYpS?=
 =?us-ascii?Q?FUhTaD3e5volFjP9MgmwRdYUSguS0QpehAKtotY/XfuH8oGfa5td6P5g6Vs6?=
 =?us-ascii?Q?shIYv891EqAr6nzVBfy6PryVqXQF2a1kQjZYz3hLAK/dpF96PJOk0gnH2lLg?=
 =?us-ascii?Q?san06qxZfRF0uClyLh2z+HO8teZ+2gTGfUOFYeghloSCtqgU/5H0mJ1/STSu?=
 =?us-ascii?Q?W+mOdCzVg4tFTrMwDLsx/IdIEntsq2uIQNkFNszi6Uu0I6SjEBMoQczjmWF4?=
 =?us-ascii?Q?NbPh0N0vd7EoABuRfa26eeTyYjJlDpfv+i034EYpTmcXwpLtVI0wmBGjn++Q?=
 =?us-ascii?Q?FvyhToVoO0Nj8zPpklwbac1eH3RHcCErR5XRwo7aVN92ktOQtSsKDw+SWF58?=
 =?us-ascii?Q?a8Qug3j1hB5f1Ws=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:11:53.9995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697bd60b-31e4-401c-66b2-08dd4592d7a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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

Enable DML2 for DCN36.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h   | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c             | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c            | 4 ++++
 4 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index dd3f43181a6e..0670e4dc4fd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -38,6 +38,7 @@ enum dml_project_id {
 	dml_project_dcn35 = 3,
 	dml_project_dcn351 = 4,
 	dml_project_dcn401 = 5,
+	dml_project_dcn36 = 6,
 };
 enum dml_prefetch_modes {
 	dml_prefetch_support_uclk_fclk_and_stutter_if_possible = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index c4c52173ef22..ef693f608d59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -301,6 +301,7 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	policy->AssumeModeSupportAtMaxPwrStateEvenDRAMClockChangeNotSupported = true; // TOREVIEW: What does this mean?
 	policy->AssumeModeSupportAtMaxPwrStateEvenFClockChangeNotSupported = true; // TOREVIEW: What does this mean?
 	if (project == dml_project_dcn35 ||
+		project == dml_project_dcn36 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
 		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index b8a34abaf519..f829d5ac7c8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -107,6 +107,7 @@ void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, stru
 
 	case dml_project_dcn35:
 	case dml_project_dcn351:
+	case dml_project_dcn36:
 		out->rob_buffer_size_kbytes = 64;
 		out->config_return_buffer_size_in_kbytes = 1792;
 		out->compressed_buffer_segment_size_in_kbytes = 64;
@@ -292,6 +293,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 
 	case dml_project_dcn35:
 	case dml_project_dcn351:
+	case dml_project_dcn36:
 		out->num_chans = 4;
 		out->round_trip_ping_latency_dcfclk_cycles = 106;
 		out->smn_latency_us = 2;
@@ -506,6 +508,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		p->dcfclk_stas_mhz[3] = 1324;
 		p->dcfclk_stas_mhz[4] = p->in_states->state_array[1].dcfclk_mhz;
 	} else if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
+			dml2->v20.dml_core_ctx.project != dml_project_dcn36 &&
 			dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
 		p->dcfclk_stas_mhz[0] = 300;
 		p->dcfclk_stas_mhz[1] = 615;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 556a780466ce..45584e2f5dfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -72,6 +72,7 @@ static void map_hw_resources(struct dml2_context *dml2,
 		in_out_display_cfg->hw.NumberOfDSCSlices[i] = mode_support_info->NumberOfDSCSlices[i];
 		in_out_display_cfg->hw.DLGRefClkFreqMHz = 24;
 		if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
+			dml2->v20.dml_core_ctx.project != dml_project_dcn36 &&
 			dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
 			/*dGPU default as 50Mhz*/
 			in_out_display_cfg->hw.DLGRefClkFreqMHz = 50;
@@ -762,6 +763,9 @@ static void dml2_init(const struct dc *in_dc, const struct dml2_configuration_op
 	case DCN_VERSION_3_51:
 		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn351;
 		break;
+	case DCN_VERSION_3_6:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn36;
+		break;
 	case DCN_VERSION_3_2:
 		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn32;
 		break;
-- 
2.37.3

