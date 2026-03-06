Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9660AF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B4110E2F6;
	Fri,  6 Mar 2026 03:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWQ0F256";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E0010E2F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFRmpsTYNPatnMw9T7gcFsSvqY8OvY/+9eFR6m/DL7DhbOe9sDeesBL9lXFSxqomR23XPMcHQn/C6yfWNPuILwIBpqerFUsZKl2nDiWueExxlWBH+HhPXRo0qCb7FrGYftb87XVaZQOqSGi8jvGTl/PvfENBc2HCsmEpxl0xsqu5MUJrcXVkhMBuXvmXy3JZmQI5rWJCYzo5PneHKwHsdqmyb76YQ3GlP1YvbodlWr0zd14TGNPBcYmwpNJ13HRhoCz3Ly0zKZn5blivu1tMeGMv9kwtl/mQlXQN4ZaSJniJR87AIRyS+Y91kUjKzEg6ZYIvlOIETkMXPGxL5QQicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ARcfq5m9N7ZVbDoa/0pD5Qp/JkTapi7y6oxW1xbRdY=;
 b=EYHPU6x1z1TZPodmFREla5SNrX+OvYbJCxYVLQwEGtYCtEgGYG3Nvo7Q7K498kqkfdmLdGUX6MgMOgAu7dXRGCruWYakv7GdJ/ZnijKDu2O+3BBqswN+Qg/eXxSdaqHyNZRoUNQBWWBabUq5z1BDeTqtKKVLO7yNdC0FYAOmdfxonG6BxInVsGTwh5JQoKBbX1/6yfqAxn49iTIllY8RBjJkzI5JCzMYFvbji+wyChL93lKQmiHqq4ImSYugN/16XthwIPP/xre59WdmOnP2QbPId7Nhh//Zhi9wokkaFeL2jB9gyfzq9eL/HLBHBuIyJG+PIit51lnhCtsx7hui5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ARcfq5m9N7ZVbDoa/0pD5Qp/JkTapi7y6oxW1xbRdY=;
 b=JWQ0F256HHNF1oNCzXw4HSObbjrqfTRrk+OxCa5+qKZ3Q+gsVww3mF9kP7BiSPe8iGZrhWCPxXB27+2jtPlcYIaKiA3H5WA+Z+YfAMeDBowSmbC6k3CIyHu9Eo5SxKkaGLTOk4Jn704JqJE6H2OwWUOuEMNHPHpKJvjEbJ6GLTY=
Received: from BYAPR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:40::19)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 03:24:40 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::f3) by BYAPR04CA0006.outlook.office365.com
 (2603:10b6:a03:40::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 03:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:24:39 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:24:37 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 04/21] drm/amd/display: Set chroma taps to 1 if luma taps are 1
Date: Thu, 5 Mar 2026 20:13:30 -0700
Message-ID: <20260306031932.136179-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6b1b02-b3aa-4675-adbc-08de7b2fe6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: VmyDSIDkMcM+pbHpnjVjw5prBdPsvvlQeEc9SrHjM16ApqoZJRBtreQshtH8rFAiGquOZoiw3TQsfc2IE77h/ykzA3JvL3Cx3JDx73kzHZMt2vFXvFvJ79TwzconmsVVhlSy/PvfdQVAX6zwog108SkQrjjl2olo9bPF9mJKSME2qWakq8vQRdNE947xaIl3sJyOSNzzBh3ekL5PGN6Yap730k8y/w/qvqL9BAY1Pn1iZweU2QM3pz3+jzAD0xO2RxfKK4B+phC+fUvfbbJuolIiBQIooxzamCtTUSvFQsCZmLSbDBKJlKv+LBfRyKIPq9aW78P/4VFZ2Si2rvTZN2EvxXyuercyNdqwXKFqlpIra3OnRbn/zTMfLWCt9+Ty42MrVC+VAMcKhb7lL6fKy06DLvoU/QwMk7ep1S5oyxrGXyVsvJmh6gnW+IbW+NEUaCW2Iv19sLFFeUyJChWQZhAGzWb5CpQ2jT3DritqX8Ji6aEXA9tA3J0yJck0lV0dj2LOUjmw+/KdBFSGAswtwr9ejytd21Prf1CtWLdnbquNNpjLvamjqXS4G9Z7YLHt7WqJ9mA9i5FZ2l5vGVFGzp+H+DawuKgsjUnM3CpM8z/k4fBEfja8bg23CHdDf8xwxKC/JyFk4fz9tZygFzYrgJQd+glHiazJm1d1CkBk1vtBtkZ7KIVTX5tzAC9/U6JrQ49wM5fjEQEPHuP3Ksos2BJ4J1eENjcWVQT8ug8QirQ3Y5qORo5zLnL67KCRijFJCWoKYzJzv0IStlxDmy4F6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ATYY/KSnt5GAEP8Pwpvk78zbPn+twHiP0ALktg1OH0aOBi22kqDtCIGieakJmpvwsYdR4ii+1lLxCIO5QevcEt0Ueqt3CSe8LrtzHQSXAc+3bk9f0p6uzgxCUh5zE253sDf71FFJWCD7tjtgxMWNVDkac6rnxxhv6clcM8NsP1RUN9xvpKH1KnmIFZ17YX+gtm9KFuPTrSFroiLVtR2AVbaUL68Qz9wmlmp627tcHDFdN3MTdv/OcgVFMhlr4yY/WauDg0cRoCO1FuzWi62pEBTmRYvNPoqi7sMSJorEKd18ksUZwT4NlL0FDEhv4JyMDej+b8sMUcMM7kK267sk1rxFu5Ae8xhlamF6q0cVRu40jjFMJ4r9Zz6o300QK2IUQEVzFZB7QH3Zeujc3Aow9Uj6A/IwonTVxY/rpkSX1qWf2DzVZytCPqRR9R53p8ij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:24:39.5273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6b1b02-b3aa-4675-adbc-08de7b2fe6a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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

From: Harry Wentland <harry.wentland@amd.com>

When luma is unscaled we also want chroma to be pixel-perfect.
When luma taps are > 1 the result will be a blurred luma plane,
even when the image isn't scaled.

This makes WIP IGT tests for CSC colorop pass.

Co-developed by Claude Sonnet 4.5.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c | 8 ++++++--
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index ce91e5d28956..0e70ffc784b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -172,10 +172,14 @@ bool dpp1_get_optimal_number_of_taps(
 		scl_data->taps.h_taps_c = in_taps->h_taps_c;
 
 	if (!dpp->ctx->dc->debug.always_scale) {
-		if (IDENTITY_RATIO(scl_data->ratios.horz))
+		if (IDENTITY_RATIO(scl_data->ratios.horz)) {
 			scl_data->taps.h_taps = 1;
-		if (IDENTITY_RATIO(scl_data->ratios.vert))
+			scl_data->taps.h_taps_c = 1;
+		}
+		if (IDENTITY_RATIO(scl_data->ratios.vert)) {
 			scl_data->taps.v_taps = 1;
+			scl_data->taps.v_taps_c = 1;
+		}
 		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
 			scl_data->taps.h_taps_c = 1;
 		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index c7923531da83..8a146968ee15 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -524,10 +524,14 @@ bool dpp3_get_optimal_number_of_taps(
 		scl_data->taps.v_taps_c = max_taps_c;
 
 	if (!dpp->ctx->dc->debug.always_scale) {
-		if (IDENTITY_RATIO(scl_data->ratios.horz))
+		if (IDENTITY_RATIO(scl_data->ratios.horz)) {
 			scl_data->taps.h_taps = 1;
-		if (IDENTITY_RATIO(scl_data->ratios.vert))
+			scl_data->taps.h_taps_c = 1;
+		}
+		if (IDENTITY_RATIO(scl_data->ratios.vert)) {
 			scl_data->taps.v_taps = 1;
+			scl_data->taps.v_taps_c = 1;
+		}
 		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
 			scl_data->taps.h_taps_c = 1;
 		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
-- 
2.43.0

