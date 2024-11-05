Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D55D36138
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90F910E614;
	Tue,  5 Nov 2024 20:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkbquBvC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C558710E60F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDtyJqYOVJcgW/P77fPzhg6geNmELmKV+H75LrxLilQBna6hfWgK4vmU/4MqZJmwrGDOTYRQ3ZH4vK9kcNn5gMsnbpWl308Z+yw5hIkVdYPwn56XO3NoAMnQRdOUl3r5DUDgwNwniW6Sb0g+wHByc/EOf+KXre2ClNYJh+oLIaUJONfzzaBrU2W+rhz1NX3ZRN80u18UdFK36pgzawp6zu9K4L9w080DCD87RWwsZeClwNzPBtp+FhotdhumyddhQSpG/Li7mqQVVbHIAwKh8jvRJrs6vC5uAlSWUfeytL055U4GRBkV288hf1vURChuCiTQByH1kJj0sY3aJBYVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcDM0YcG2uD3s1OU7MGmNAX+2Lb+R0JR13uQPF8BB30=;
 b=XjF4I1uBeV+fWp7hQAZrPzmJXYmw76J0p5MhEVyUSGLrzv2o5wLB9SZeSx/OEHGFTxw4EvCqMHVn0jcO+3J1k3CNqnyiajzw4DCiqHhK39/b1n5dd7ztJvvj1jMdS1/kuX5aahXRe+9iTJ8wBijUFvY4oMpxjWjXVFCvcYH/qfpaTUMC4C+RAHa7hjRS2EotW9/YsS26vOK1fWzt9ce4ziaY8P4pAj2QW+9cqc2UB1kjQvyNRYp7Jg4Pr2tMHretfObELcT8TF1OyFqOuYMJleMOm/g0tjc9wihBSXamgW2tMuTXfqmaD8arkrqX6IL1kvW9akKl+GXoI0FSTj6wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcDM0YcG2uD3s1OU7MGmNAX+2Lb+R0JR13uQPF8BB30=;
 b=LkbquBvCNmQ19zxQOjAAvmZuQ+hjFl1vjr+aAM0xi23IJ5doMvOe/Y+81CkF9/msguL/B4yVc95yMOlV69xrFJ8CZOqnlNs/wct5Jsq0dDDWNP3QUOAtMPKmhXPNTpHddcHsw0PXk1QwLkoh65aiKq3dmKjltptJEJror/wkpRY=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:24:37 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::db) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:36 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:31 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 09/16] drm/amd/display: Update SPL Taps Required For Integer
 Scaling
Date: Tue, 5 Nov 2024 15:22:10 -0500
Message-ID: <20241105202341.154036-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9f3a36-255b-449a-6ecd-08dcfdd7de47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jdcLKNjuUVs5ad9tJznmF71H87bF5j0B81afI0HvEadFGezzcwRQOSTaoMIQ?=
 =?us-ascii?Q?F51YJ4S5cO/dtlj74ktdRNephrdgIs+mr7Kb/3ilFE6xgY4VTYMD0lY6dEU9?=
 =?us-ascii?Q?a4NFZ1fDTBCXFFnA4jr3p2kaMs2BecNxsUcdCaDLJZ971gZsFr3mW970eO88?=
 =?us-ascii?Q?SyptdFoG9t6BGhlBhskPU2UB5roi0o7OJor6NcfGGEvYiz3Qkrp39Oh2oVzo?=
 =?us-ascii?Q?Fkr+2k10ep9Tcc7WcuxzHDDbufFW4oBr0J4E/wv4NUXDeCpMYP3KcbjZsJup?=
 =?us-ascii?Q?rf5Hzhg5RGCi0FfxNrnAMG+wl24t+DgnHz6/6Kewie4YrDG0T2VZ5rscsbR4?=
 =?us-ascii?Q?9/Z6b+i5ecqbexg9k+iO60hM4JoC37JJqjksBs4gHKkHMw6q/Rr8SH1DNVAZ?=
 =?us-ascii?Q?hOye5HZ8BABXzZhs1+M8r8Wpdu7HACDEyh+lPeTe4f7TCbPuoIZeCnDgGMbX?=
 =?us-ascii?Q?bpInphQyK/PUaMnk6/t/m1N+QGQDCun8R71GSJPSdRuEaa3edw+pXCGV7tR8?=
 =?us-ascii?Q?QcA6/wkNLctcxQLMHmgd4xTo79RwrJ041N5C1bv6f3/VVG36bHM1uT9gcHVU?=
 =?us-ascii?Q?+EWgQ8It4Vq76dX6QlooG5YvKFPADfvPssYvvupuRaTs+FhTBhmKZ0RKHSq1?=
 =?us-ascii?Q?OSWnU+J+PaEBByLipcHGzpZOYbFDdWO/tbBxrwa2UIm5XBDiQWXV8fdSHz3K?=
 =?us-ascii?Q?QVp+muMX/JFX/YWEoNi3tZnIt3y82lS4/tTUN1PFGfWf2G1B7VcbMn88onTF?=
 =?us-ascii?Q?api594fT4rByruXQmRgL4RNY5ZUDrpaAG3CjBRlGtjakrKGw18lvA0c/i14x?=
 =?us-ascii?Q?v5WEKQMg9wCTNpnyGzwVv/0uIvliR9L+vIOkwCMUinDRpGbX9YZ32Z909j7g?=
 =?us-ascii?Q?GAz6RrnclSkIyX29smKaHqaFGMpfkI8rxyg1Xgf+AimsTHJxE0tJkW7td4md?=
 =?us-ascii?Q?edLe1I89+nx+e0BEEHQKniziGeAdxjJb2P/AjbxVR3fffcVGc1p7k8PRUkbV?=
 =?us-ascii?Q?U/6Ojd24xv6XYUi6mY5IwWj11RACQBu1ZXUYIQa2VAZvoaXdJ2EhQuRCGWAj?=
 =?us-ascii?Q?3vxlTDBZVguUoPGWI6rOf+ueQHdk2ohwV5BkNO8fyquihvrvsmL27GOiGYsE?=
 =?us-ascii?Q?f3SCNSX6eALDohE13nvWAy1Iw7KtdVTOikg9jY5yZ1eDQdbRZ01cXU6Pa8qH?=
 =?us-ascii?Q?o1fYVTbg2hmtw8jdQuMigHa6utTfoITZ0mZGVb0a7ImspjTrZBiU8eTE6AL0?=
 =?us-ascii?Q?AA62CpfgvpEDN/M/gT27vxWTTxgIzIvkR6ljG+0tcYLsjBQVkkHbW+wVH+Ak?=
 =?us-ascii?Q?0sYAJqK78bK6pYdcc1mWCCXTnzMJpPn5Sa6irqaIlCLS3S9xO+00RTlB2+so?=
 =?us-ascii?Q?9Fq2KZogravnH7GpAnrqfr2pS7VnmmA3mFnrbpt492yNuco/zQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:36.8005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9f3a36-255b-449a-6ecd-08dcfdd7de47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

From: Austin Zheng <Austin.Zheng@amd.com>

Number of taps is incorrectly being set when integer scaling is enabled.
Taps required when src_rect != dst_rect previously not considered.
Perform the calculations when integer scaling is enabled.
Set taps to 1 if the scaling ratio is 1:1.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index a29a9f131e04..614276200aa0 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -910,6 +910,16 @@ static void spl_get_taps_non_adaptive_scaler(
 		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c - 1;
 	else
 		spl_scratch->scl_data.taps.h_taps_c = in_taps->h_taps_c;
+
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz))
+		spl_scratch->scl_data.taps.h_taps = 1;
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert))
+		spl_scratch->scl_data.taps.v_taps = 1;
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c))
+		spl_scratch->scl_data.taps.h_taps_c = 1;
+	if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c))
+		spl_scratch->scl_data.taps.v_taps_c = 1;
+
 }
 
 /* Calculate optimal number of taps */
@@ -936,10 +946,7 @@ static bool spl_get_optimal_number_of_taps(
 
 	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
 	if (spl_in->scaling_quality.integer_scaling) {
-		spl_scratch->scl_data.taps.h_taps = 1;
-		spl_scratch->scl_data.taps.v_taps = 1;
-		spl_scratch->scl_data.taps.v_taps_c = 1;
-		spl_scratch->scl_data.taps.h_taps_c = 1;
+		spl_get_taps_non_adaptive_scaler(spl_scratch, in_taps);
 		*enable_easf_v = false;
 		*enable_easf_h = false;
 		*enable_isharp = false;
-- 
2.46.1

