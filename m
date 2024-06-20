Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7EAC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7417610EB0A;
	Thu, 20 Jun 2024 16:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbJ83GB5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9351710EB0A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx6SGz6b1SvhFDYbWBvPN4LOTh9ez2LLxx9u4yHIfa9UFUp7o1KdtUGGcwyMVprp1HRPM/Na4VtT5ZhvvqYggxW+1EoifiPsoL6OUZSbZ+n/XXjlX+D9HQuGbWPlI2tYMdIcg18EXj2ZoY3kFnel2aTdHqSm5IpSLeAAkWLMPxdTszm1qyM52PuOKFlVgqSIzFVbAtL1taUFIzqgTvmODgeEfgKyN0d6uMsnesAn4xTKJxFLuv5kpqgLO9F0uxr6ukYOlZvHcIJa7i7y6F4MzHhgsum8WYClXYWoeapdbO8ZhCNjF27Hu0zTCo3M6eqyejm3Sae/++PGEjXU/R9lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19zgo88vLIvfeWGrAWwNOEeGHrpceMMAzGg5UgEswAk=;
 b=j6YF976K6TlrkFeggn1Tf9Xcrm5PM7AhKBiO4QufUUXht0VqRhq/8jUjP99ETzzc4QXg7EIVbTD1yiRs7k2j6Q+l852Rf6BVhvB7wME8Wlh7NiF4FeJKSP9eybHrMKtHv17wPh2yJXDwija6m/veAEXAElz1drbqk5z8A4o8M2Cuw4xtPECPBUE2AT3E61OYOwKHq7Z/F5lFW5fiVCqRiG2g/CyqzGEtZ1iuGOsDj2aFeqBhbaTjNfDaltAJIfnCmMOckOufgMnn/9ziniPCs0fs8kXep2LvAj8YKz2NgOEIMdyO48vb+5z+wqkfBgLwRoQ9dYyusWWLnef0SOM/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19zgo88vLIvfeWGrAWwNOEeGHrpceMMAzGg5UgEswAk=;
 b=xbJ83GB5gJTU25LR4KI7xWQxK/WNmP9jbL61L97UyISCrKiEhEA2dSvLJFVGlARBw/5N4zdtxEhJc3dRJJUAY+qE/PKwAX4KFcLfqsPktfBUd91rUvIBlDcJfdjQLJlhfB2JsAJ7KFwGoL9h5OgCAyuHPf1AQFEoveVUCIpsmpw=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 20 Jun
 2024 16:16:52 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7a) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:16:52 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:16:49 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sung-huai Wang <danny.wang@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 20/39] drm/amd/display: Add workaround to restrict max frac
 urgent for DPM0
Date: Thu, 20 Jun 2024 10:11:26 -0600
Message-ID: <20240620161145.2489774-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f467d90-8d8d-4248-1319-08dc9144652b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iI3e2MJvJLUyvetOcdPIEvgvWa9nxu+F3KCw2g1bL7dOy3GhodLFW2OiF+LR?=
 =?us-ascii?Q?gH2kWyj7P4cAP2Ffj4OCI80aa/HjVQXJMDupNBn+jA6INc56LSH4lq9FHFzE?=
 =?us-ascii?Q?QlZWL7HCztA2LvVIim2Qm7KhdK9b00O1iFscWbKOXYegOX4+l+GzW+tY2WYn?=
 =?us-ascii?Q?aC3ReJSh+jLoP0Wiot9H5OdnnmZT1BzsXAikJAqRNzoDwBRALb4nmexa3FSA?=
 =?us-ascii?Q?XhTZLPP8PUUksKa9L3dP8/znZ80q2CQhLh218jT1zqhFywmd72Ebrf/l75Z6?=
 =?us-ascii?Q?zE4PKSrgT+z7B2EHZ7mla7TAaADWf4flZjhfAxWxHTp/B9eCu4mH802w9+dK?=
 =?us-ascii?Q?4VLbIZcp2eeTwMREZbUkiRC5BsAGwmdjGvg5BRO19QHQwpo5b/4B3HH6ftm3?=
 =?us-ascii?Q?bZQG+C3N2Lbuju6N//Br5KEfXRM0FFqb17uWMkGLXIXU1WnshWDkTVEfkKYi?=
 =?us-ascii?Q?k+sg9eEGy3xm7kE2q8CcPJIxT7aXNUJGEGj5n3cDmGOYdQuU4aZWqnwDThEG?=
 =?us-ascii?Q?NZpvMcXYoca8b1L1Z3edgY0kNmLaMoqM6hRjgAeHZRpuw5ctoChOfvuoCswC?=
 =?us-ascii?Q?tybw1jByp8K8jQvQmS3o6W1B3dI5a/IvP5yD5Fj03PhZLvYH8RQclGG9jhMK?=
 =?us-ascii?Q?/3Yt30Vms9rz4HuCkCARqNnEzICHAVMvwq41yOreS/rOuUt564CdndGhb2hl?=
 =?us-ascii?Q?/WbRiP7nGRD0wZUhnZYYxmWNToMvwMhgm/ZVPksFR6+Otlx729Rsltf+RDva?=
 =?us-ascii?Q?NPbn66/DoGJqzyWppQhoFcsLZ2dJFgwK8D1QkTMtW+cfBpg7CDwvdRm4mtsM?=
 =?us-ascii?Q?yU2v6zciiGVu1b+QrIg4Dl9UGhjOPB9bgXYb53xXZqF4mTNihqsq1OD7NEyr?=
 =?us-ascii?Q?9zRzKpdX+pC1MMsWAnrKkIEy8XNzbE2ar8mka3bJZuCONXdwjCeKenmQSPdo?=
 =?us-ascii?Q?fd96xcn4xqaLfEchj1GeFYi3ldp6KPST7zB67TYrt4Hn0z7FguWYtgGXY9/D?=
 =?us-ascii?Q?uRXs4mRSDgO8tHisIMHsHC7SvtTOTF7H6tGo2CZ5WX1r0DDDeV3iyi004Mw+?=
 =?us-ascii?Q?J2WymMB2wk6xRyTmyPnNqCuMddse780zTqVwww0zkIwqpURuDW2L44vHn7pu?=
 =?us-ascii?Q?J64MqX6f6tKrVAc3vBcXFoeZeZuTMox6czW47xx7ApGglgKzuaz5zeIZ724b?=
 =?us-ascii?Q?sXvRcJOnSb4GMluHgcSMloy9HU1J1MbFIXo9u1mtK4aeVa4g+T8sHPhj3afW?=
 =?us-ascii?Q?PyBFxh8BNd+yiwVtthzlqI4kAQJm2sxx45Bn7Ql6G8lO9veDyoddRkM8Sd2S?=
 =?us-ascii?Q?1XwAwEWB4tIGfINcTphx0Pp2Vens4Df0LReyyTaZNKuOQSBlBRMVL1JyiEdm?=
 =?us-ascii?Q?DiVhY/tnMGcG6/Hwkn/82d+Bz+Woehn9Y5gCAkt1SVI+yZFd+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:52.0111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f467d90-8d8d-4248-1319-08dc9144652b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

From: Sung-huai Wang <danny.wang@amd.com>

[WHY]
Underflow occurs on some platforms when urgent BW is close to
the maximum in DPM0.

[HOW]
It does not occur at DPM1, so as a workaround restrict the maximum
amount and increase the lowest state index for clock states until
we're out of DPM0.
Adds DML2 config options to specify this pe platform as required.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Sung-huai Wang <danny.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 ++
 .../display/dc/resource/dcn35/dcn35_resource.c    |  3 ++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index f6310408dbba..f4038ac2e476 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -628,6 +628,21 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 
 	if (result) {
 		unsigned int lowest_state_idx = s->mode_support_params.out_lowest_state_idx;
+		double min_fclk_mhz_for_urgent_workaround = (double)dml2->config.min_fclk_for_urgent_workaround_khz / 1000.0;
+		double max_frac_urgent = (double)dml2->config.max_frac_urgent_for_min_fclk_x1000 / 1000.0;
+
+		if (min_fclk_mhz_for_urgent_workaround > 0.0 && max_frac_urgent > 0.0 &&
+		    (dml2->v20.dml_core_ctx.mp.FractionOfUrgentBandwidth > max_frac_urgent ||
+		     dml2->v20.dml_core_ctx.mp.FractionOfUrgentBandwidthImmediateFlip > max_frac_urgent)) {
+			unsigned int forced_lowest_state_idx = lowest_state_idx;
+
+			while (forced_lowest_state_idx < dml2->v20.dml_core_ctx.states.num_states &&
+			       dml2->v20.dml_core_ctx.states.state_array[forced_lowest_state_idx].fabricclk_mhz <= min_fclk_mhz_for_urgent_workaround) {
+				forced_lowest_state_idx += 1;
+			}
+			lowest_state_idx = forced_lowest_state_idx;
+		}
+
 		out_clks.dispclk_khz = (unsigned int)dml2->v20.dml_core_ctx.mp.Dispclk_calculated * 1000;
 		out_clks.p_state_supported = s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported;
 		if (in_dc->config.use_default_clock_table &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 20b3970c0857..79bf2d757804 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -237,6 +237,8 @@ struct dml2_configuration_options {
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
 	struct dml2_soc_bb *bb_from_dmub;
+	int max_frac_urgent_for_min_fclk_x1000;
+	int min_fclk_for_urgent_workaround_khz;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 67ab8c1962ff..1ce0f9ecff9c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2152,8 +2152,9 @@ static bool dcn35_resource_construct(
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
 
 	dc->dml2_options.max_segments_per_hubp = 24;
-
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
+	dc->dml2_options.max_frac_urgent_for_min_fclk_x1000 = 900;
+	dc->dml2_options.min_fclk_for_urgent_workaround_khz = 400 * 1000;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
-- 
2.34.1

