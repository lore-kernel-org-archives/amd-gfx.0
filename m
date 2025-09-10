Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153B0CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C46A10E851;
	Wed, 10 Sep 2025 05:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RzN0vzZb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DAD10E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT5bISICGdDbgegF+fUElSVALuptXyUE+AhIDoeIsw5rqal7bv/yymWqE41qBRt94rzOiG5RRQ2AtDFVI8Chy6XrcqwbzIQDVQTh76Hll6OW3L7szDVGdcmHt2DxMOg8rYqFgL1iD2IGABAKe3BtUdyF774E0G40izCnrsUeilAYMJOQJT5UcL5NFw5Fy0Zikgc/Nqb4PSP7wBcPPuQW0B9qHf9wqDQoD8qUFlzlirwi6JX8rgn6RYBhoYAgkV6ojos9YNkm+9fcyDDO3hmtNzFgf/RxF3epu6jr2o4E8AAW/oiyce6ZqbPQM3BJAGEbHuXGdLh1icVNpFgt0PEe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b44sihuSJAs7YcraT4jzFTANVY9/y4CyXfn0N4y1eNk=;
 b=vEhzed70aiUS3tJ9Kc3MHauQUYnGpxcxQGNsjn1OZ9uxEghSLB+BjM1mjdrRZKeyB+7WD7laJKQTeHtnwBxR3jlu1NcgZm5T+9k0gHERFgd0hXVfhBFSmNsyhOZWkbo0JKKfYNZnxYcK4moMrIUc87vya9c1rSNt3jjjj2ocXVM+sm3i+8ZkFwmSvtQmGe76RtwKsfnx+2SiZ2D+WuT1vSbKWb4pwWI6rSsVbFkUceAjUQdwOX4ByjPCQZU1FY7VyADbfh1sD4NTl47qzYBvM7AH8MS6Fl2KNyPyxy24byo8ioyky30+6xD4xovQnSXc+xp0AVn3KlJl11wZBohGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b44sihuSJAs7YcraT4jzFTANVY9/y4CyXfn0N4y1eNk=;
 b=RzN0vzZbsftuzdXisL9RAkWUaZ7Jkx3TvnDsEL5P4emQsWesK1Dxl4NTrMEJqqB0kVaJRYB8HLuSWmcthONXwEnAcvKFGYgyBxesD8PbdBTJLZBDmuc6u2AFBTxYQv/BJghwzShjReAfyLLgMLeNBDNkckl6o7NbxJ0VELYiMsg=
Received: from BN8PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:60::17)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:32:56 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::e4) by BN8PR12CA0004.outlook.office365.com
 (2603:10b6:408:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:32:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:32:53 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:32:45 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 "Ray Wu" <ray.wu@amd.com>
Subject: [PATCH 02/15] drm/amd/display: prepare dml 2.1 for new asic
Date: Wed, 10 Sep 2025 13:30:25 +0800
Message-ID: <20250910053222.2884632-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5cc46f-6037-40f7-e6d7-08ddf02b7f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tjZusVVzADc79eu2GR2epOSaB3dg85LPtdPPaju8WNflnUJ6vbjCXFw4bUcz?=
 =?us-ascii?Q?eAwoxFzyGdohKpOfX8oq9yp7adyRDct44wWkgecETV3FfeXWAhwsOdBpIShb?=
 =?us-ascii?Q?nN8v19GZKaBaWlcpd0I8nj438eFQmcH9vD3NW/9TeeCG8zb7ERgqssUA2ihC?=
 =?us-ascii?Q?VkKwmZ9Zikz3xwf+3DrJJtpB2+HhYUAO3Br6lqfqoBlzhfGTdgrItCXdIRZF?=
 =?us-ascii?Q?/ZtrJxNodb7lJM8rDrzMS4mFOS5kgfeR64oJtDKOePlcXJks1g5rdTsM8c2k?=
 =?us-ascii?Q?1633fuHA3CQy5iIWXpQiyMukas2GaI3jDNdAvesRP4sIEBdfGnprqCzqm88F?=
 =?us-ascii?Q?xVZX8IcZHtbiU9SD5AKC/VX+RjdF4/twibOPNiAnG5AALiQt1dmWXQouQM/q?=
 =?us-ascii?Q?ISS/G5YEb8OiyAfKu/rryh/p0TmmKOf5WHWmEwjtXV4MH2+DfE9tscnuJIDI?=
 =?us-ascii?Q?KjNVh3k8wZTyazhtQq0lroMMCFGIIW+Fu0qTpj0QnH+JIBLzlngXg0jB5FjP?=
 =?us-ascii?Q?A52HKlH039QZwi/y4oiB1XFIrsK81YJFolIt412taVrRacWoYmfsv0VyM7XV?=
 =?us-ascii?Q?4LepD+DC5FB/FXdtck1ONnZ6JLSJlVr8E70kRNLxdxdv0eweGV2de2WUBwiJ?=
 =?us-ascii?Q?wBCqVsh0Yw4IFkmgx7NFiottSYxP3qKg6WPHF3m4AQT892kvQhOt4Io5mgP5?=
 =?us-ascii?Q?7VQYuI1P6inSDHIvS33BWgXzvlheEA/7nl+vW3BJysOQLAJIwsapz9kL0QDD?=
 =?us-ascii?Q?Uor1XH5gWbf43DiZHkPdvIeU3JVww2OeAtiA+L00S4ouH796YaaHSVreMflT?=
 =?us-ascii?Q?7iJVjtKLDp2mffimhJBWk2bUtwd/PZBS+XHAT5JeFYnAvyDLzO9TKrNUIWKX?=
 =?us-ascii?Q?XZ8YKuaGOFYj1meiInkrLPHNXp1qz1PotuOb6yJxaGtY8ot571xTWzV7PY5A?=
 =?us-ascii?Q?ofUorj0kAoQpNMSg1XHlHDv+2aUaxpPPc+hMP14AV1DfZYiBcU+POLzWS/Lt?=
 =?us-ascii?Q?HMginuVAwi2FQEXG57VwW00wsp55RotVvo9miucRH+VJ9Jkm92ezAdimj0Ny?=
 =?us-ascii?Q?rJOW7+jVhbUDZmj0/90/5ORlt5DyqfbGXCwwSjUWMDTkbGhHrueRXe2LUdOs?=
 =?us-ascii?Q?0ju8t+Z5AkBkGPwzBWDT87Wk2XPZWlDfuyEfIOXElmgpFyoMM2bWvblXwUXM?=
 =?us-ascii?Q?inQOFnglo04G6CkURJhyUGkVIlShwqcYacepERV0XuX35P5NDWiP9oO/60rv?=
 =?us-ascii?Q?hW7CWKyS0TRayL530jIHXqIk4LBWUqM84O0MnDWoGblhyG4AB50Q1CQd+SQS?=
 =?us-ascii?Q?4w1+SsF9kD2iWO/27nhYRDrLf1Z/we33tmW9yUFJLAAccGzvs64s1NVpO6T7?=
 =?us-ascii?Q?OYbM3aNWkk3XAA+3fq8fZhBzI7+Q/CNUbmEAdrUkvaC8/JXazSNzUU9T3Fzy?=
 =?us-ascii?Q?XTZ9gZKzuMbE4t1B6ndjN3+1IgcLhTLwOG6xaF0XLtKO6LsGJ5rZImYZOaKL?=
 =?us-ascii?Q?WqZIgwGvYg55D0wFw5ef7d1c1bsTIufNIdvK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:32:56.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5cc46f-6037-40f7-e6d7-08ddf02b7f5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

[Why&How]
prepare dml 2.1 for new asic

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c              | 2 +-
 .../gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h   | 6 +++---
 drivers/gpu/drm/amd/display/dc/inc/resource.h               | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 883054bb18e7..c61300a7cb1c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -211,7 +211,7 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 			return NULL;
 		}
 
-		if (!dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
+		if (dc->caps.dcmode_power_limits_present && !dml2_create(dc, &dc->dml2_dc_power_options, &state->bw_ctx.dml2_dc_power_source)) {
 			dc_state_release(state);
 			return NULL;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 7de10a95cfdb..41adb1104d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -16,9 +16,9 @@ struct dml2_instance;
 
 enum dml2_project_id {
 	dml2_project_invalid = 0,
-	dml2_project_dcn4x_stage1 = 1,
-	dml2_project_dcn4x_stage2 = 2,
-	dml2_project_dcn4x_stage2_auto_drr_svp = 3,
+	dml2_project_dcn4x_stage1,
+	dml2_project_dcn4x_stage2,
+	dml2_project_dcn4x_stage2_auto_drr_svp,
 };
 
 enum dml2_pstate_change_support {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index a890f581f4e8..4e26a16a8743 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -45,6 +45,7 @@ enum dce_version resource_parse_asic_id(
 struct resource_caps {
 	int num_timing_generator;
 	int num_opp;
+	int num_dpp;
 	int num_video_plane;
 	int num_audio;
 	int num_stream_encoder;
-- 
2.43.0

