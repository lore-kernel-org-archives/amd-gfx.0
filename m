Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E831FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3907410E3AC;
	Wed, 29 Apr 2026 01:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sKhIiduH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CC910E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giwOiGJRKNDQHTahrO0J7gWS/BXZCtXCksr1DeNmx2VvlyGPIvbbI30tbnysB/geLcAGvAAxOOtI74O1iSGew3S5G5b2Pmm/sv4/36bdcjILp2OnFMv+v7tI/FaHFNfaN11duqCp6D8fFG8lDsO9b1pHPMiYwZgkw3bEVqb7BrBdR4uROI42Qb9osrKwkpRq/iV2ZDifUGJ2v4U5bQs0ruF+HGm1emrCrj3Jw/lhUVpeRLPmFhuGHlwr7zpvpv9pI9HRo5+ELkQEjAT+cYOcX+1KyDAZtxXrWG1pJM15ga2dDYvMPSnPIjN/gl0SKxiyQQohuZ81szXm9sjjeDtK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOAdWns+aJWi5JQlcoLMVWtAoQ8+3dri8MPxl/812wg=;
 b=mMMOyVM7F31JVB3Zbs1YfJLQc347s4x8Ffu8rk5Ta6IjYFj8iO8fAHCsKERtB+q2ngtcoLlVqvEXB3QDAMYP7O06lCXioT+p9+V6+YTXmlavz9Hbl9Jium45WOoreUlLtfb8uzoov4s1L5mDAbahLWmYbGQePDuL3A6Bt81zGMxY4UJFMS6h3fSuap1sT5iXdhNVCLb8o2cR1Sttwo2g0HeTdaf5GPozO6fTrp4D0VRTjyH7mEN25bg13ZOKQUw6jPJEAiwQKA0JCXx//LP30Z7gbgCx+lPJtgPo9yhwASAJMFGMDTfrJZ51ZSWxXsvwO26wMmfGpsgXa5xhVA2Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOAdWns+aJWi5JQlcoLMVWtAoQ8+3dri8MPxl/812wg=;
 b=sKhIiduHCDEsJo2IDerhYPsGkPR9DKcb97lOJVnAqbpwjn2dYkNP5T83nDLocSCseZVGfiwCzAqb0xeWWLImwMDd71Ojuj8OFnJqI1I53MuhG0/ZnG7zH0F6dyeLfvM2OaGOEr5oOC45W3iM+7XnS+97tO1Og7b/sG9zXhujTBo=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Wed, 29 Apr 2026 01:53:38 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::53) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:53:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 20:53:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 20:53:36 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:53:27 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 11/17] drm/amd/display: Fix type mismatches using guards and
 explicit casts
Date: Wed, 29 Apr 2026 09:19:20 +0800
Message-ID: <20260429012055.2065869-12-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: c63e561b-4fd2-4293-12bc-08dea5922174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: U+lE+PbKmO8VMYClBipjPBzC+Sa3tcMIBYmQjBf2PJwIwE9MYOZPnYzeAJhrZzt6t5UYgspeKgkhtiUMPgfHl2JrLFOS6fmpVRlgGPrOMygNlZMm7PrAYDD+SHwCOt0U7077yt51DlkwfEC3+EZg4GMpkDIFHBySOM4SjhRwFLHArJbRjCgHpKzJWQbKmRC7Zsiq6GWPvBZaOHYvYtudCCWZNvOR9eQX+41jit/T5GW6SMYLdr8nV9oO84N41cgqy+5wcM42z8f42kzZHW+H62phWmjOBVJodv0kDEEzBJHUB+A9UmfRoRlMcfq4ZlGh9eob5wb4298RihbuHo4YQ+0zsuRcYBlhRBye/0tiz+qdXygcw/fnqQdlzJyi0o0RKhLZCZbmxj7m2CYZjEqcaPDd/qj8U1T0SacpasP5wACZPCNvg76Ueq6Zu59kwq4pKSdWqQKWv+ZDVSBY2Kh9ggXgVCA/cJ7q4lDwOfURybsLleTeU7Ej6mWcxB6YTi2cCB4mokL4t1xfrMCZHGi219aBsTJ1cuasLG0fTxD9RQ5qA9FbxM/Otjozk915JGE53pZCjlb2soU1h/Wl7K4t96fI8yN7HA8BWpnm8Bvg05ece/flkeqdtJqhVz99UkbF6YlnYRvbGC23ogmOEZGC2mniQBR3c8lRVewY+eTx0TDGnV22P1rEpuxEbOI7bVzEWUTrVvXcXw8FrvNiRET6Vl+iSOpyhM/7RPBiD3NuqvvL10aynlgR292x07ROVF60tm/2qT8YapZKbunx4e4tVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LM4iSfNuF8MSfvaT5Mzsa971MtmM6sTuXCEhaBoGZkpDOOf47hJhcHE1gWAa5ZG2p7Fky/9QYt1u5VLunJ1eO5WD49EmCGslpaFGfqWlH0suL49IDCTQFSCDgeJHGhU6sVd/iQWzuL84IGPZnDi4VFV7vrA61CN7DUGZxG21YvE+cVu2M2kydnlEja6Qa9yYLY5fIAl6hwr57O0FB0XGQ2h5YgQdiigVEmmjXb6s9H7mU0v8FMwpDNPkPPTcGpeMAPsUupBwbcU1Po3As1DAC8pqvRBjjg1XbwSE2v3+vcXytbgW275GFhtSeGmckoCnd7ylixUwqLgyd0ZP2M/emo7tk5AoUkzZqSQhdrB6b7PSFSDpY2DIXIth8hLkZ82/Uoia/BFC7h8dOWyqvhyRSh6NTGdLaSKRo19SN+vSxmQpl54PnwHib327X54CF8Uh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:53:37.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63e561b-4fd2-4293-12bc-08dea5922174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

[Why]
Address signed/unsigned comparison warnings across dc paths to keep
builds warning-clean and improve type safety at comparison boundaries.
Most warnings came from signed loop/index temporaries compared against
unsigned counters and table sizes, plus a smaller number of mixed
signed/unsigned clock, bandwidth, and geometry comparisons.

[How]
Aligned iterator and temporary variable types with the semantic type
of the compared bounds. Used unsigned indices for loops bounded by unsigned
counters and table sizes, while retaining signed types where values are
semantically signed or participate in arithmetic that may legitimately go
negative. Where mixed signed/unsigned comparisons are intentional, applied
explicit boundary casts or guarded comparisons instead of broad type
changes.

No functional behavior changes are intended; this is a warning-resolution
and type-alignment cleanup.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/basics/conversion.c    |   2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   6 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  11 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  30 ++---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  17 ++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  30 ++---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  41 +++----
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  55 ++++-----
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  53 +++++----
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  43 +++----
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  21 ++--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 111 +++++++++---------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  19 +--
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  24 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 109 +++++++++--------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  10 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  67 ++++++-----
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   3 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  12 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  22 ++--
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   2 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   8 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  11 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  13 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   2 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   3 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   3 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   7 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   5 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  26 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  55 ++++-----
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  34 +++---
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  15 ++-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  32 ++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  68 ++++++-----
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  43 ++++---
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  21 ++--
 .../drm/amd/display/dc/link/link_detection.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   4 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +-
 .../drm/amd/display/dc/link/link_validation.c |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |   4 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   2 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   4 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   2 +-
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |   6 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   4 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |   6 +-
 69 files changed, 631 insertions(+), 542 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/conversion.c b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
index bd1f60ecaba4..a1f2350388e2 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/conversion.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/conversion.c
@@ -131,7 +131,7 @@ void convert_hw_matrix(struct fixed31_32 *matrix,
 		       uint16_t *reg,
 		       uint32_t buffer_size)
 {
-	for (int i = 0; i < buffer_size; ++i)
+	for (uint32_t i = 0; i < buffer_size; ++i)
 		matrix[i] = int_frac_to_fixed_point(reg[i], 2, 13);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index fd19b6470628..e81b852daebe 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -302,7 +302,7 @@ static void calculate_bandwidth(
 	fbc_enabled = false;
 	lpt_enabled = false;
 	for (i = 4; i <= maximum_number_of_surfaces - 3; i++) {
-		if (i < data->number_of_displays + 4) {
+		if (i < (int32_t)(data->number_of_displays + 4)) {
 			if (i == 4 && data->d0_underlay_mode == bw_def_underlay_only) {
 				data->enable[i] = 0;
 				data->use_alpha[i] = 0;
@@ -2767,7 +2767,7 @@ static bool is_display_configuration_supported(
 	const struct bw_calcs_vbios *vbios,
 	const struct dce_bw_output *calcs_output)
 {
-	uint32_t int_max_clk;
+	int32_t int_max_clk;
 
 	int_max_clk = bw_fixed_to_int(vbios->high_voltage_max_dispclk);
 	int_max_clk *= 1000; /* MHz to kHz */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index 13296c6ec08f..b35a44976477 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -63,11 +63,11 @@ static const struct state_dependent_clocks dce110_max_clks_by_state[] = {
 /*ClocksStatePerformance*/
 { .display_clk_khz = 643000, .pixel_clk_khz = 400000 } };
 
-static int determine_sclk_from_bounding_box(
+static uint32_t determine_sclk_from_bounding_box(
 		const struct dc *dc,
-		int required_sclk)
+		uint32_t required_sclk)
 {
-	int i;
+	uint32_t i;
 
 	/*
 	 * Some asics do not give us sclk levels, so we just report the actual
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 369421e46c52..06a51f47aed7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -88,7 +88,7 @@ static void ramp_up_dispclk_with_dpp(
 		struct dc_clocks *new_clocks,
 		bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 	int dispclk_to_dpp_threshold = rv1_determine_dppclk_threshold(clk_mgr, new_clocks);
 	bool request_dpp_div = new_clocks->dispclk_khz > new_clocks->dppclk_khz;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index bb4f3bd7532e..c0abbdd2cf5c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -104,7 +104,7 @@ uint32_t dentist_get_did_from_divider(int divider)
 void dcn20_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 
 	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
@@ -255,9 +255,12 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 			pp_smu->set_display_count(&pp_smu->pp_smu, display_count);
 	}
 
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+				new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index df06e5cd27aa..b5378344d2bc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -106,7 +106,7 @@ static void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
 static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, int ref_dpp_clk, bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 
 	clk_mgr->dccg->ref_dppclk = ref_dpp_clk;
 
@@ -644,6 +644,8 @@ static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsi
 static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params, struct dpm_clocks *clock_table, struct integrated_info *bios_info)
 {
 	int i, j = 0;
+	unsigned int entry_idx;
+	unsigned int wm_idx;
 
 	j = -1;
 
@@ -667,28 +669,28 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 
 	bw_params->clk_table.num_entries = j + 1;
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->FClocks[j].Freq;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemClocks[j].Freq;
-		bw_params->clk_table.entries[i].voltage = clock_table->FClocks[j].Vol;
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->FClocks[j].Vol);
-		bw_params->clk_table.entries[i].socclk_mhz = find_socclk_for_voltage(clock_table,
-									bw_params->clk_table.entries[i].voltage);
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++, j--) {
+		bw_params->clk_table.entries[entry_idx].fclk_mhz = clock_table->FClocks[j].Freq;
+		bw_params->clk_table.entries[entry_idx].memclk_mhz = clock_table->MemClocks[j].Freq;
+		bw_params->clk_table.entries[entry_idx].voltage = clock_table->FClocks[j].Vol;
+		bw_params->clk_table.entries[entry_idx].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->FClocks[j].Vol);
+		bw_params->clk_table.entries[entry_idx].socclk_mhz = find_socclk_for_voltage(clock_table,
+									bw_params->clk_table.entries[entry_idx].voltage);
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (wm_idx = 0; wm_idx < (unsigned int)WM_SET_COUNT; wm_idx++) {
+		bw_params->wm_table.entries[wm_idx].wm_inst = wm_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (wm_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[wm_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[wm_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[wm_idx].valid = true;
 	}
 
 	if (bw_params->vram_type == LpDdr4MemType) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index bf7f92fd41d7..958b8d1dad2f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -228,9 +228,12 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (enter_display_off == safe_to_lower)
 		dcn30_smu_set_num_of_displays(clk_mgr, display_count);
 
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+				new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
@@ -251,8 +254,10 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	// invalidate the current P-State forced min in certain dc_mode_softmax situations
 	if (dc->clk_mgr->dc_mode_softmax_enabled && safe_to_lower && !p_state_change_support) {
-		if ((new_clocks->dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000) !=
-				(clk_mgr_base->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000))
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if ((new_clocks->dramclk_khz <= softmax_memclk_khz) !=
+				(clk_mgr_base->clks.dramclk_khz <= softmax_memclk_khz))
 			update_pstate_unsupported_clk = true;
 	}
 
@@ -263,7 +268,7 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* to disable P-State switching, set UCLK min = max */
 		if (!clk_mgr_base->clks.p_state_change_support) {
 			if (dc->clk_mgr->dc_mode_softmax_enabled &&
-				new_clocks->dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+				new_clocks->dramclk_khz <= (int)(dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000))
 				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 					(uint16_t)dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 			else
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 70f6f0913f13..e40bbc495fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -533,7 +533,7 @@ static struct clk_bw_params vg_bw_params = {
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < num_clocks; ++i) {
 		if (clocks[i] > max)
@@ -565,6 +565,7 @@ static void vg_clk_mgr_helper_populate_bw_params(
 		const struct vg_dpm_clocks *clock_table)
 {
 	int i, j;
+	unsigned int entry_idx;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	uint32_t max_dispclk = 0, max_dppclk = 0;
 
@@ -599,16 +600,17 @@ static void vg_clk_mgr_helper_populate_bw_params(
 
 	bw_params->clk_table.num_entries = j + 1;
 
-	for (i = 0; i < bw_params->clk_table.num_entries - 1; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].fclk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].memclk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].voltage;
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->DfPstateTable[j].voltage);
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries - 1; entry_idx++, j--) {
+		bw_params->clk_table.entries[entry_idx].fclk_mhz = clock_table->DfPstateTable[j].fclk;
+		bw_params->clk_table.entries[entry_idx].memclk_mhz = clock_table->DfPstateTable[j].memclk;
+		bw_params->clk_table.entries[entry_idx].voltage = clock_table->DfPstateTable[j].voltage;
+		bw_params->clk_table.entries[entry_idx].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->DfPstateTable[j].voltage);
 
 		/* Now update clocks we do read */
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[entry_idx].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[entry_idx].dppclk_mhz = max_dppclk;
 	}
+	i = (int)entry_idx;
 	bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].fclk;
 	bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].memclk;
 	bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].voltage;
@@ -619,16 +621,16 @@ static void vg_clk_mgr_helper_populate_bw_params(
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 
 	if (bw_params->vram_type == LpDdr4MemType) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 68a121dbb489..dc7f50095a13 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -525,7 +525,7 @@ static void dcn31_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < num_clocks; ++i) {
 		if (clocks[i] > max)
@@ -541,8 +541,8 @@ static unsigned int find_clk_for_voltage(
 		unsigned int voltage)
 {
 	int i;
-	int max_voltage = 0;
-	int clock = 0;
+	unsigned int max_voltage = 0;
+	unsigned int clock = 0;
 
 	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
 		if (clock_table->SocVoltage[i] == voltage) {
@@ -563,6 +563,7 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 						    const DpmClocks_t *clock_table)
 {
 	int i, j;
+	unsigned int entry_idx;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	uint32_t max_dispclk = 0, max_dppclk = 0;
 
@@ -597,24 +598,24 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 		ASSERT(0);
 	}
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++, j--) {
+		bw_params->clk_table.entries[entry_idx].fclk_mhz = clock_table->DfPstateTable[j].FClk;
+		bw_params->clk_table.entries[entry_idx].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
+		bw_params->clk_table.entries[entry_idx].voltage = clock_table->DfPstateTable[j].Voltage;
 		switch (clock_table->DfPstateTable[j].WckRatio) {
 		case WCK_RATIO_1_2:
-			bw_params->clk_table.entries[i].wck_ratio = 2;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 2;
 			break;
 		case WCK_RATIO_1_4:
-			bw_params->clk_table.entries[i].wck_ratio = 4;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 4;
 			break;
 		default:
-			bw_params->clk_table.entries[i].wck_ratio = 1;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 1;
 		}
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
-		bw_params->clk_table.entries[i].socclk_mhz = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[entry_idx].dcfclk_mhz = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
+		bw_params->clk_table.entries[entry_idx].socclk_mhz = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
+		bw_params->clk_table.entries[entry_idx].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[entry_idx].dppclk_mhz = max_dppclk;
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
@@ -622,16 +623,16 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 	//bw_params->dram_channel_width_bytes = dc->ctx->asic_id.vram_width;
 	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 0d5892266112..5fe59adc862f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -295,7 +295,7 @@ void dcn314_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 		(new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
-		int requested_dispclk_khz = new_clocks->dispclk_khz;
+		uint32_t requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn314_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
@@ -616,7 +616,7 @@ static unsigned int convert_wck_ratio(uint8_t wck_ratio)
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < num_clocks; ++i) {
 		if (clocks[i] > max)
@@ -634,6 +634,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
 	uint32_t max_pstate = 0,  max_fclk = 0,  min_pstate = 0, max_dispclk = 0, max_dppclk = 0;
 	int i;
+	unsigned int entry_idx;
 
 	/* Find highest valid fclk pstate */
 	for (i = 0; i < clock_table->NumDfPstatesEnabled; i++) {
@@ -723,26 +724,26 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 	 * Set any 0 clocks to max default setting. Not an issue for
 	 * power since we aren't doing switching in such case anyway
 	 */
-	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
-		if (!bw_params->clk_table.entries[i].fclk_mhz) {
-			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
-			bw_params->clk_table.entries[i].memclk_mhz = def_max.memclk_mhz;
-			bw_params->clk_table.entries[i].voltage = def_max.voltage;
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++) {
+		if (!bw_params->clk_table.entries[entry_idx].fclk_mhz) {
+			bw_params->clk_table.entries[entry_idx].fclk_mhz = def_max.fclk_mhz;
+			bw_params->clk_table.entries[entry_idx].memclk_mhz = def_max.memclk_mhz;
+			bw_params->clk_table.entries[entry_idx].voltage = def_max.voltage;
 		}
-		if (!bw_params->clk_table.entries[i].dcfclk_mhz)
-			bw_params->clk_table.entries[i].dcfclk_mhz = def_max.dcfclk_mhz;
-		if (!bw_params->clk_table.entries[i].socclk_mhz)
-			bw_params->clk_table.entries[i].socclk_mhz = def_max.socclk_mhz;
-		if (!bw_params->clk_table.entries[i].dispclk_mhz)
-			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
-		if (!bw_params->clk_table.entries[i].dppclk_mhz)
-			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_mhz)
-			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
-			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
-		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
-			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dcfclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dcfclk_mhz = def_max.dcfclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].socclk_mhz)
+			bw_params->clk_table.entries[entry_idx].socclk_mhz = def_max.socclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dispclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dispclk_mhz = def_max.dispclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dppclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dtbclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
@@ -750,16 +751,16 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index ef184f28e426..b6f26475ac16 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -203,7 +203,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
-		int requested_dispclk_khz = new_clocks->dispclk_khz;
+		uint32_t requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn315_disable_otg_wa(clk_mgr_base, context, true);
 
@@ -489,6 +489,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		const DpmClocks_315_t *clock_table)
 {
 	int i;
+	unsigned int entry_idx;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	uint32_t max_pstate = clock_table->NumDfPstatesEnabled - 1;
 	struct clk_limit_table_entry def_max = bw_params->clk_table.entries[bw_params->clk_table.num_entries - 1];
@@ -544,26 +545,26 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 	/* Set any 0 clocks to max default setting. Not an issue for
 	 * power since we aren't doing switching in such case anyway
 	 */
-	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
-		if (!bw_params->clk_table.entries[i].fclk_mhz) {
-			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
-			bw_params->clk_table.entries[i].memclk_mhz = def_max.memclk_mhz;
-			bw_params->clk_table.entries[i].voltage = def_max.voltage;
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++) {
+		if (!bw_params->clk_table.entries[entry_idx].fclk_mhz) {
+			bw_params->clk_table.entries[entry_idx].fclk_mhz = def_max.fclk_mhz;
+			bw_params->clk_table.entries[entry_idx].memclk_mhz = def_max.memclk_mhz;
+			bw_params->clk_table.entries[entry_idx].voltage = def_max.voltage;
 		}
-		if (!bw_params->clk_table.entries[i].dcfclk_mhz)
-			bw_params->clk_table.entries[i].dcfclk_mhz = def_max.dcfclk_mhz;
-		if (!bw_params->clk_table.entries[i].socclk_mhz)
-			bw_params->clk_table.entries[i].socclk_mhz = def_max.socclk_mhz;
-		if (!bw_params->clk_table.entries[i].dispclk_mhz)
-			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
-		if (!bw_params->clk_table.entries[i].dppclk_mhz)
-			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_mhz)
-			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
-			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
-		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
-			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dcfclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dcfclk_mhz = def_max.dcfclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].socclk_mhz)
+			bw_params->clk_table.entries[entry_idx].socclk_mhz = def_max.socclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dispclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dispclk_mhz = def_max.dispclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dppclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dtbclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
 
 	/* Make sure all highest default clocks are included*/
@@ -575,16 +576,16 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 	bw_params->num_channels = bios_info->ma_channel_number;
 	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index aa8f2a5edc21..72a38f7a761c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -211,7 +211,7 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
-		int requested_dispclk_khz = new_clocks->dispclk_khz;
+		uint32_t requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
@@ -452,7 +452,7 @@ static void dcn316_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < num_clocks; ++i) {
 		if (clocks[i] > max)
@@ -468,8 +468,8 @@ static unsigned int find_clk_for_voltage(
 		unsigned int voltage)
 {
 	int i;
-	int max_voltage = 0;
-	int clock = 0;
+	unsigned int max_voltage = 0;
+	unsigned int clock = 0;
 
 	for (i = 0; i < NUM_SOC_VOLTAGE_LEVELS; i++) {
 		if (clock_table->SocVoltage[i] == voltage) {
@@ -491,6 +491,7 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 		const DpmClocks_316_t *clock_table)
 {
 	int i, j;
+	unsigned int entry_idx;
 	struct clk_bw_params *bw_params = clk_mgr->base.bw_params;
 	uint32_t max_dispclk = 0, max_dppclk = 0;
 
@@ -525,46 +526,46 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 		ASSERT(0);
 	}
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++, j--) {
 		int temp;
 
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->DfPstateTable[j].FClk;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->DfPstateTable[j].Voltage;
+		bw_params->clk_table.entries[entry_idx].fclk_mhz = clock_table->DfPstateTable[j].FClk;
+		bw_params->clk_table.entries[entry_idx].memclk_mhz = clock_table->DfPstateTable[j].MemClk;
+		bw_params->clk_table.entries[entry_idx].voltage = clock_table->DfPstateTable[j].Voltage;
 		switch (clock_table->DfPstateTable[j].WckRatio) {
 		case WCK_RATIO_1_2:
-			bw_params->clk_table.entries[i].wck_ratio = 2;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 2;
 			break;
 		case WCK_RATIO_1_4:
-			bw_params->clk_table.entries[i].wck_ratio = 4;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 4;
 			break;
 		default:
-			bw_params->clk_table.entries[i].wck_ratio = 1;
+			bw_params->clk_table.entries[entry_idx].wck_ratio = 1;
 		}
 		temp = find_clk_for_voltage(clock_table, clock_table->DcfClocks, clock_table->DfPstateTable[j].Voltage);
 		if (temp)
-			bw_params->clk_table.entries[i].dcfclk_mhz = temp;
+			bw_params->clk_table.entries[entry_idx].dcfclk_mhz = temp;
 		temp = find_clk_for_voltage(clock_table, clock_table->SocClocks, clock_table->DfPstateTable[j].Voltage);
 		if (temp)
-			bw_params->clk_table.entries[i].socclk_mhz = temp;
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
+			bw_params->clk_table.entries[entry_idx].socclk_mhz = temp;
+		bw_params->clk_table.entries[entry_idx].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[entry_idx].dppclk_mhz = max_dppclk;
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
 	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8773a8321735..f78b33076e70 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -236,9 +236,9 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
 		for (i = 0; i < num_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
-					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
+					< (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
-					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
+					= (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
 	}
 	for (i = 0; i < num_levels; i++)
 		if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz > 1950)
@@ -247,9 +247,9 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz) {
 		for (i = 0; i < num_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
-					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
+					< (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
-					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
+					= (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
 	}
 
 	for (i = 0; i < num_levels; i++)
@@ -269,7 +269,7 @@ static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 {
 	struct dccg *dccg = clk_mgr->dccg;
 	uint32_t tg_mask = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -314,7 +314,7 @@ static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, s
 void dcn32_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 
 	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
@@ -673,9 +673,12 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 
-		if (dc->debug.force_min_dcfclk_mhz > 0)
-			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-					new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+		if (dc->debug.force_min_dcfclk_mhz > 0) {
+			int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+					new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+		}
 
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz) &&
 				!dc->work_arounds.clock_update_disable_mask.dcfclk) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index ddcde2433211..6c6848e375e1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -257,7 +257,7 @@ static void dcn35_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 {
 	struct dccg *dccg = clk_mgr->dccg;
 	uint32_t tg_mask = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -280,7 +280,7 @@ static void dcn35_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 static void dcn35_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 	bool dppclk_active[MAX_PIPES] = {0};
 
 
@@ -450,9 +450,12 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_MISSION_MODE;
 		}
 	}
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+				new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
@@ -478,7 +481,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
-		int requested_dispclk_khz = new_clocks->dispclk_khz;
+		uint32_t requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
@@ -980,7 +983,7 @@ static void dcn351_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 static uint32_t find_max_clk_value(const uint32_t clocks[], uint32_t num_clocks)
 {
 	uint32_t max = 0;
-	int i;
+	uint32_t i;
 
 	for (i = 0; i < num_clocks; ++i) {
 		if (clocks[i] > max)
@@ -1027,28 +1030,29 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	uint32_t max_pstate = 0, max_dram_speed_mts = 0, min_dram_speed_mts = 0;
 	uint32_t num_memps, num_fclk, num_dcfclk;
 	int i;
+	unsigned int entry_idx;
 
 	/* Determine min/max p-state values. */
 	num_memps = (clock_table->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS) ? NUM_MEM_PSTATE_LEVELS :
 		clock_table->NumMemPstatesEnabled;
-	for (i = 0; i < num_memps; i++) {
-		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[i]);
+	for (entry_idx = 0; entry_idx < num_memps; entry_idx++) {
+		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[entry_idx]);
 
 		if (is_valid_clock_value(dram_speed_mts) && dram_speed_mts > max_dram_speed_mts) {
 			max_dram_speed_mts = dram_speed_mts;
-			max_pstate = i;
+			max_pstate = entry_idx;
 		}
 	}
 
 	min_dram_speed_mts = max_dram_speed_mts;
 	min_pstate = max_pstate;
 
-	for (i = 0; i < num_memps; i++) {
-		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[i]);
+	for (entry_idx = 0; entry_idx < num_memps; entry_idx++) {
+		uint32_t dram_speed_mts = calc_dram_speed_mts(&clock_table->MemPstateTable[entry_idx]);
 
 		if (is_valid_clock_value(dram_speed_mts) && dram_speed_mts < min_dram_speed_mts) {
 			min_dram_speed_mts = dram_speed_mts;
-			min_pstate = i;
+			min_pstate = entry_idx;
 		}
 	}
 
@@ -1078,31 +1082,32 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 
 	num_dcfclk = (clock_table->NumDcfClkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
 		clock_table->NumDcfClkLevelsEnabled;
-	for (i = 0; i < num_dcfclk; i++) {
+	for (entry_idx = 0; entry_idx < num_dcfclk; entry_idx++) {
 		int j;
 
 		/* First search defaults for the clocks we don't read using closest lower or equal default dcfclk */
 		for (j = bw_params->clk_table.num_entries - 1; j > 0; j--)
-			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[i])
+			if (bw_params->clk_table.entries[j].dcfclk_mhz <= clock_table->DcfClocks[entry_idx])
 				break;
 
-		bw_params->clk_table.entries[i].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
-		bw_params->clk_table.entries[i].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
-		bw_params->clk_table.entries[i].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
+		bw_params->clk_table.entries[entry_idx].phyclk_mhz = bw_params->clk_table.entries[j].phyclk_mhz;
+		bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz = bw_params->clk_table.entries[j].phyclk_d18_mhz;
+		bw_params->clk_table.entries[entry_idx].dtbclk_mhz = bw_params->clk_table.entries[j].dtbclk_mhz;
 
 		/* Now update clocks we do read */
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemPstateTable[min_pstate].MemClk;
-		bw_params->clk_table.entries[i].voltage = clock_table->MemPstateTable[min_pstate].Voltage;
-		bw_params->clk_table.entries[i].dcfclk_mhz = clock_table->DcfClocks[i];
-		bw_params->clk_table.entries[i].socclk_mhz = clock_table->SocClocks[i];
-		bw_params->clk_table.entries[i].dispclk_mhz = max_dispclk;
-		bw_params->clk_table.entries[i].dppclk_mhz = max_dppclk;
-		bw_params->clk_table.entries[i].wck_ratio =
+		bw_params->clk_table.entries[entry_idx].memclk_mhz = clock_table->MemPstateTable[min_pstate].MemClk;
+		bw_params->clk_table.entries[entry_idx].voltage = clock_table->MemPstateTable[min_pstate].Voltage;
+		bw_params->clk_table.entries[entry_idx].dcfclk_mhz = clock_table->DcfClocks[entry_idx];
+		bw_params->clk_table.entries[entry_idx].socclk_mhz = clock_table->SocClocks[entry_idx];
+		bw_params->clk_table.entries[entry_idx].dispclk_mhz = max_dispclk;
+		bw_params->clk_table.entries[entry_idx].dppclk_mhz = max_dppclk;
+		bw_params->clk_table.entries[entry_idx].wck_ratio =
 			convert_wck_ratio(clock_table->MemPstateTable[min_pstate].WckRatio);
 
 		/* Dcfclk and Fclk are tied, but at a different ratio */
-		bw_params->clk_table.entries[i].fclk_mhz = min(max_fclk, 2 * clock_table->DcfClocks[i]);
+		bw_params->clk_table.entries[entry_idx].fclk_mhz = min(max_fclk, 2 * clock_table->DcfClocks[entry_idx]);
 	}
+	i = (int)entry_idx;
 
 	/* Make sure to include at least one entry at highest pstate */
 	if (max_pstate != min_pstate || i == 0) {
@@ -1148,44 +1153,44 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	 * Set any 0 clocks to max default setting. Not an issue for
 	 * power since we aren't doing switching in such case anyway
 	 */
-	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
-		if (!bw_params->clk_table.entries[i].fclk_mhz) {
-			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
-			bw_params->clk_table.entries[i].memclk_mhz = def_max.memclk_mhz;
-			bw_params->clk_table.entries[i].voltage = def_max.voltage;
+	for (entry_idx = 0; entry_idx < bw_params->clk_table.num_entries; entry_idx++) {
+		if (!bw_params->clk_table.entries[entry_idx].fclk_mhz) {
+			bw_params->clk_table.entries[entry_idx].fclk_mhz = def_max.fclk_mhz;
+			bw_params->clk_table.entries[entry_idx].memclk_mhz = def_max.memclk_mhz;
+			bw_params->clk_table.entries[entry_idx].voltage = def_max.voltage;
 		}
-		if (!bw_params->clk_table.entries[i].dcfclk_mhz)
-			bw_params->clk_table.entries[i].dcfclk_mhz = def_max.dcfclk_mhz;
-		if (!bw_params->clk_table.entries[i].socclk_mhz)
-			bw_params->clk_table.entries[i].socclk_mhz = def_max.socclk_mhz;
-		if (!bw_params->clk_table.entries[i].dispclk_mhz)
-			bw_params->clk_table.entries[i].dispclk_mhz = def_max.dispclk_mhz;
-		if (!bw_params->clk_table.entries[i].dppclk_mhz)
-			bw_params->clk_table.entries[i].dppclk_mhz = def_max.dppclk_mhz;
-		if (!bw_params->clk_table.entries[i].fclk_mhz)
-			bw_params->clk_table.entries[i].fclk_mhz = def_max.fclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_mhz)
-			bw_params->clk_table.entries[i].phyclk_mhz = def_max.phyclk_mhz;
-		if (!bw_params->clk_table.entries[i].phyclk_d18_mhz)
-			bw_params->clk_table.entries[i].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
-		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
-			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dcfclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dcfclk_mhz = def_max.dcfclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].socclk_mhz)
+			bw_params->clk_table.entries[entry_idx].socclk_mhz = def_max.socclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dispclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dispclk_mhz = def_max.dispclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dppclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dppclk_mhz = def_max.dppclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].fclk_mhz)
+			bw_params->clk_table.entries[entry_idx].fclk_mhz = def_max.fclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_mhz = def_max.phyclk_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz)
+			bw_params->clk_table.entries[entry_idx].phyclk_d18_mhz = def_max.phyclk_d18_mhz;
+		if (!bw_params->clk_table.entries[entry_idx].dtbclk_mhz)
+			bw_params->clk_table.entries[entry_idx].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 
-	for (i = 0; i < WM_SET_COUNT; i++) {
-		bw_params->wm_table.entries[i].wm_inst = i;
+	for (entry_idx = 0; entry_idx < (unsigned int)WM_SET_COUNT; entry_idx++) {
+		bw_params->wm_table.entries[entry_idx].wm_inst = entry_idx;
 
-		if (i >= bw_params->clk_table.num_entries) {
-			bw_params->wm_table.entries[i].valid = false;
+		if (entry_idx >= bw_params->clk_table.num_entries) {
+			bw_params->wm_table.entries[entry_idx].valid = false;
 			continue;
 		}
 
-		bw_params->wm_table.entries[i].wm_type = WM_TYPE_PSTATE_CHG;
-		bw_params->wm_table.entries[i].valid = true;
+		bw_params->wm_table.entries[entry_idx].wm_type = WM_TYPE_PSTATE_CHG;
+		bw_params->wm_table.entries[entry_idx].valid = true;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 2b7718336135..2654f4dacee3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -291,17 +291,17 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
 		for (i = 0; i < num_entries_per_clk->num_dispclk_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
-					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
+					< (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dispclk_mhz
-					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
+					= (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_disp_clk_khz);
 	}
 
 	if (clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz) {
 		for (i = 0; i < num_entries_per_clk->num_dppclk_levels; i++)
 			if (clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
-					< khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
+					< (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz))
 				clk_mgr_base->bw_params->clk_table.entries[i].dppclk_mhz
-					= khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
+					= (unsigned int)khz_to_mhz_ceil(clk_mgr_base->ctx->dc->debug.min_dpp_clk_khz);
 	}
 
 	/* Get UCLK, update bounding box */
@@ -558,7 +558,7 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 static void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, bool safe_to_lower, int ref_dppclk_khz)
 {
-	int i;
+	uint32_t i;
 
 	clk_mgr->dccg->ref_dppclk = ref_dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
@@ -841,9 +841,12 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	}
 
 	/* UPDATE DCFCLK */
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+				new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index c4ed6c3594c2..41729426d08c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -167,7 +167,7 @@ void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
 void dcn42_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		struct dc_state *context, bool safe_to_lower)
 {
-	int i;
+	uint32_t i;
 	bool dppclk_active[MAX_PIPES] = {0};
 
 
@@ -282,9 +282,12 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_MISSION_MODE;
 		}
 	}
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+	if (dc->debug.force_min_dcfclk_mhz > 0) {
+		int force_min_dcfclk_khz = dc->debug.force_min_dcfclk_mhz * 1000;
+
+		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > force_min_dcfclk_khz) ?
+				new_clocks->dcfclk_khz : force_min_dcfclk_khz;
+	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
@@ -298,8 +301,9 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 
 		/* Clamp the requested clock to PMFW based on DCN limit. */
-		if (dc->debug.min_deep_sleep_dcfclk_khz > 0 && clk_mgr_base->clks.dcfclk_deep_sleep_khz < dc->debug.min_deep_sleep_dcfclk_khz)
-			clk_mgr_base->clks.dcfclk_deep_sleep_khz = dc->debug.min_deep_sleep_dcfclk_khz;
+		if (dc->debug.min_deep_sleep_dcfclk_khz > 0 &&
+			clk_mgr_base->clks.dcfclk_deep_sleep_khz < (int)dc->debug.min_deep_sleep_dcfclk_khz)
+			clk_mgr_base->clks.dcfclk_deep_sleep_khz = (int)dc->debug.min_deep_sleep_dcfclk_khz;
 
 		dcn42_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 	}
@@ -315,13 +319,13 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && has_active_display == false))) {
-		int requested_dispclk_khz = new_clocks->dispclk_khz;
+		uint32_t requested_dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		/* Clamp the requested clock to PMFW based on their limit. */
-		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
-			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < (uint32_t)dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = (uint32_t)dc->debug.min_disp_clk_khz;
 
 		dcn42_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
@@ -692,7 +696,7 @@ void dcn42_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn42_
 
 void dcn42_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct dcn42_watermarks *table = NULL;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct clk_mgr_dcn42 *clk_mgr_dcn42 = TO_CLK_MGR_DCN42(clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7f364d4ac279..6447b85c7ce5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -174,7 +174,7 @@ static void destroy_links(struct dc *dc)
 
 static uint32_t get_num_of_internal_disp(struct dc_link **links, uint32_t num_links)
 {
-	int i;
+	uint32_t i;
 	uint32_t count = 0;
 
 	for (i = 0; i < num_links; i++) {
@@ -202,7 +202,7 @@ static bool create_links(
 		struct dc *dc,
 		uint32_t num_virtual_links)
 {
-	int i;
+	uint32_t i;
 	int connectors_num;
 	struct dc_bios *bios = dc->ctx->dc_bios;
 
@@ -343,7 +343,7 @@ static bool create_link_encoders(struct dc *dc)
 	bool res = true;
 	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
 	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
-	int i;
+	unsigned int i;
 
 	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
 	 * link encoders and physical display endpoints and does not require
@@ -383,7 +383,7 @@ static void destroy_link_encoders(struct dc *dc)
 {
 	unsigned int num_usb4_dpia;
 	unsigned int num_dig_link_enc;
-	int i;
+	unsigned int i;
 
 	if (!dc->res_pool)
 		return;
@@ -1138,7 +1138,7 @@ static void disable_all_writeback_pipes_for_stream(
 {
 	(void)dc;
 	(void)context;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < stream->num_wb_info; i++)
 		stream->writeback_info[i].wb_enabled = false;
@@ -1151,7 +1151,7 @@ static void apply_ctx_interdependent_lock(struct dc *dc,
 {
 	(void)dc;
 	(void)context;
-	int i;
+	unsigned int i;
 
 	/* Checks if interdependent update function pointer is NULL or not, takes care of DCE110 case */
 	if (dc->hwss.interdependent_update_lock)
@@ -1338,7 +1338,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
-	int i, j;
+	unsigned int i, j;
 	struct dc_state *dangling_context = dc_state_create_current_copy(dc);
 	struct dc_state *current_ctx;
 	struct pipe_ctx *pipe;
@@ -1801,7 +1801,8 @@ bool dc_validate_boot_timing(const struct dc *dc,
 	struct dc_crtc_timing hw_crtc_timing = {0};
 
 	struct dc_link *link = sink->link;
-	unsigned int i, enc_inst, tg_inst = 0;
+	unsigned int i, enc_inst;
+	unsigned int tg_inst = 0;
 
 	/* Support seamless boot on EDP displays only */
 	if (sink->sink_signal != SIGNAL_TYPE_EDP) {
@@ -1930,7 +1931,7 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		struct dcn_dsc_state dsc_state = {0};
 
 		/* Find DSC associated with this timing generator */
-		if (tg_inst < dc->res_pool->res_cap->num_dsc) {
+		if (tg_inst < (unsigned int)dc->res_pool->res_cap->num_dsc) {
 			dsc = dc->res_pool->dscs[tg_inst];
 		}
 
@@ -2131,7 +2132,7 @@ void dc_trigger_sync(struct dc *dc, struct dc_state *context)
 
 static uint8_t get_stream_mask(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	unsigned int stream_mask = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -2205,7 +2206,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	struct pipe_ctx *pipe;
-	int i, k, l;
+	unsigned int i, k, l;
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 	struct dc_state *old_state;
 	bool subvp_prev_use = false;
@@ -2445,7 +2446,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
  */
 enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params *params)
 {
-	int i, j;
+	unsigned int i, j;
 	struct dc_state *context;
 	enum dc_status res = DC_OK;
 	struct dc_validation_set set[MAX_STREAMS] = {0};
@@ -2485,7 +2486,7 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 
 		if (status) {
 			set[i].plane_count = (uint8_t)status->plane_count;
-			for (j = 0; j < status->plane_count; j++)
+			for (j = 0; j < (unsigned int)status->plane_count; j++)
 				set[i].plane_states[j] = status->plane_states[j];
 		}
 	}
@@ -2575,7 +2576,7 @@ bool dc_acquire_release_mpc_3dlut(
 		struct dc_3dlut **lut,
 		struct dc_transfer_func **shaper)
 {
-	int pipe_idx;
+	unsigned int pipe_idx;
 	bool ret = false;
 	bool found_pipe_idx = false;
 	const struct resource_pool *pool = dc->res_pool;
@@ -2647,7 +2648,7 @@ static void process_deferred_updates(struct dc *dc)
 
 void dc_post_update_surfaces_to_stream(struct dc *dc)
 {
-	int i;
+	unsigned int i;
 	struct dc_state *context = dc->current_state;
 
 	if ((!dc->optimized_required) || get_seamless_boot_stream_count(context) > 0)
@@ -2888,7 +2889,7 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 			/* Making dst rect smaller requires a bandwidth change */
 			update_flags->bits.bandwidth_change = 1;
 
-		if (u->scaling_info->src_rect.width > check_config->max_optimizable_video_width &&
+		if (u->scaling_info->src_rect.width > (int)check_config->max_optimizable_video_width &&
 			(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
 			 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
 			 /* Changing clip size of a large surface may result in MPC slice count change */
@@ -3477,7 +3478,7 @@ static void copy_stream_update_to_stream(struct dc *dc,
 		stream->test_pattern = *update->pending_test_pattern;
 	/* update current stream with writeback info */
 	if (update->wb_update) {
-		int i;
+		unsigned int i;
 
 		stream->num_wb_info = update->wb_update->num_wb_info;
 		ASSERT(stream->num_wb_info <= MAX_DWB_PIPES);
@@ -3672,7 +3673,8 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_state **new_context)
 {
 	struct dc_state *context;
-	int i, j;
+	int i;
+	unsigned int j;
 	enum surface_update_type update_type;
 	const struct dc_stream_status *stream_status;
 	struct dc_context *dc_ctx = dc->ctx;
@@ -4242,7 +4244,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	int j;
+	unsigned int j;
 
 	// Check if block sequence programming is enabled
 	if (dc->debug.enable_block_sequence_programming) {
@@ -4434,7 +4436,8 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 {
 	union dmub_rb_cmd cmd;
 	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
-	unsigned int i, j;
+	int i;
+	unsigned int j;
 	unsigned int panel_inst = 0;
 
 	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
@@ -4495,7 +4498,8 @@ static void build_dmub_update_dirty_rect(
 {
 	union dmub_rb_cmd cmd;
 	struct dmub_cmd_update_dirty_rect_data *update_dirty_rect;
-	unsigned int i, j;
+	int i;
+	unsigned int j;
 	unsigned int panel_inst = 0;
 
 	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
@@ -4592,7 +4596,8 @@ static void commit_plane_for_stream_offload_fams2_flip(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_state *context)
 {
-	int i, j;
+	int i;
+	unsigned int j;
 
 	/* update dirty rect for PSR */
 	dc_dmub_update_dirty_rect(dc, surface_count, stream,
@@ -4633,7 +4638,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	int i, j;
+	int i;
+	unsigned int j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
 	bool should_offload_fams2_flip = false;
@@ -4673,7 +4679,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	if (!top_pipe_to_program)
 		return;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < (int)dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream && pipe->plane_state) {
@@ -4752,7 +4758,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	int i, j;
+	int i;
+	unsigned int j, pipe_idx;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
@@ -4774,8 +4781,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[pipe_idx];
 
 		if (pipe->stream && pipe->plane_state) {
 			if (!dc->debug.using_dml2)
@@ -4806,8 +4813,8 @@ static void commit_planes_for_stream(struct dc *dc,
 				stream);
 	ASSERT(top_pipe_to_program != NULL);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[pipe_idx];
 
 		// Check old context for SubVP
 		subvp_prev_use |= (dc_state_get_pipe_subvp_type(dc->current_state, old_pipe) == SUBVP_PHANTOM);
@@ -4815,8 +4822,8 @@ static void commit_planes_for_stream(struct dc *dc,
 			break;
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[pipe_idx];
 
 		if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
 			subvp_curr_use = true;
@@ -5018,16 +5025,16 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 
 		if (dc->debug.validate_dml_output) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
+			for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+				struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
 				if (cur_pipe->stream == NULL)
 					continue;
 
 				cur_pipe->plane_res.hubp->funcs->validate_dml_output(
 						cur_pipe->plane_res.hubp, dc->ctx,
-						&context->res_ctx.pipe_ctx[i].rq_regs,
-						&context->res_ctx.pipe_ctx[i].dlg_regs,
-						&context->res_ctx.pipe_ctx[i].ttu_regs);
+						&context->res_ctx.pipe_ctx[pipe_idx].rq_regs,
+						&context->res_ctx.pipe_ctx[pipe_idx].dlg_regs,
+						&context->res_ctx.pipe_ctx[pipe_idx].ttu_regs);
 			}
 		}
 	}
@@ -5349,7 +5356,7 @@ static void swap_and_release_current_context(struct dc *dc,
 		struct dc_state *new_context, struct dc_stream_state *stream)
 {
 
-	int i;
+	unsigned int i;
 	struct dc_state *old = dc->current_state;
 	struct pipe_ctx *pipe_ctx;
 
@@ -5609,7 +5616,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 
 	/* force full surface update */
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
+		for (j = 0; j < (unsigned int)dc->current_state->stream_status[i].plane_count; j++) {
 			dc->current_state->stream_status[i].plane_states[j]->update_flags.raw = 0xFFFFFFFF;
 		}
 	}
@@ -6118,7 +6125,8 @@ bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips)
 
 void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const *caller_name)
 {
-	int idle_fclk_khz = 0, idle_dramclk_khz = 0, i = 0;
+	int idle_fclk_khz = 0, idle_dramclk_khz = 0;
+	unsigned int i = 0;
 	enum mall_stream_type subvp_pipe_type[MAX_PIPES] = {0};
 	struct pipe_ctx *pipe = NULL;
 	struct dc_state *context = dc->current_state;
@@ -6217,7 +6225,7 @@ static void blank_and_force_memclk(struct dc *dc, bool apply, unsigned int memcl
 	struct dc_state *context = dc->current_state;
 	struct hubp *hubp;
 	struct pipe_ctx *pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &context->res_ctx.pipe_ctx[i];
@@ -7028,7 +7036,8 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 {
 	struct dc_state *context;
 	struct resource_context *res_ctx;
-	int i;
+	unsigned int i;
+	const unsigned int max_pipes = MAX_PIPES;
 
 	if (!dc || !dc->current_state || !state) {
 		if (state)
@@ -7052,7 +7061,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture HUBP programming state for each pipe */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		state->hubp[i].valid_stream = false;
@@ -7174,7 +7183,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	/* Capture HUBBUB programming state */
 	if (dc->res_pool->hubbub) {
 		/* Individual DET buffer sizes - software state variables that program DET registers */
-		for (i = 0; i < 4 && i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < 4u && i < dc->res_pool->pipe_count; i++) {
 			uint32_t det_size = res_ctx->pipe_ctx[i].det_buffer_size_kb;
 			switch (i) {
 			case 0:
@@ -7198,7 +7207,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture DPP programming state for each pipe */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		if (!pipe_ctx->stream)
@@ -7239,7 +7248,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 		state->dccg.dispclk_khz = dc->clk_mgr->clks.dispclk_khz;
 
 		/* Per-pipe clock configuration - only capture what's essential */
-		for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 			if (pipe_ctx->stream) {
 				/* Essential clocks that directly affect underflow risk */
@@ -7266,7 +7275,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 		}
 
 		/* DSC clock state - only when actually using DSC */
-		for (i = 0; i < MAX_PIPES; i++) {
+		for (i = 0; i < max_pipes; i++) {
 			struct pipe_ctx *pipe_ctx = (i < dc->res_pool->pipe_count) ? &res_ctx->pipe_ctx[i] : NULL;
 			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->timing.dsc_cfg.num_slices_h > 0) {
 				state->dccg.dscclk_khz[i] = 400000; /* Typical DSC clock frequency */
@@ -7283,7 +7292,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture essential DSC configuration for underflow analysis */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		if (pipe_ctx->stream && pipe_ctx->stream->timing.dsc_cfg.num_slices_h > 0) {
@@ -7311,7 +7320,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture MPC programming state - comprehensive register field coverage */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		if (pipe_ctx->plane_state && pipe_ctx->stream) {
@@ -7379,7 +7388,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture OPP programming state for each pipe - comprehensive register field coverage */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		if (!pipe_ctx->stream)
@@ -7497,7 +7506,7 @@ bool dc_capture_register_software_state(struct dc *dc, struct dc_register_softwa
 	}
 
 	/* Capture OPTC programming state for each pipe - comprehensive register field coverage */
-	for (i = 0; i < MAX_PIPES && i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < max_pipes && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
 		if (!pipe_ctx->stream)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index f3cf3eb983dd..ffa3130853c2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -666,7 +666,7 @@ void set_p_state_switch_method(
 		/* SubVP */
 		enable_subvp = false;
 
-		for (int i = 0; i < dc->res_pool->pipe_count; i++) {
+		for (unsigned int i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 			if (pipe->stream && dc_state_get_paired_subvp_stream(context, pipe->stream) &&
@@ -1211,7 +1211,7 @@ void hwss_execute_sequence(struct dc *dc,
 		struct block_sequence block_sequence[MAX_HWSS_BLOCK_SEQUENCE_SIZE],
 		int num_steps)
 {
-	unsigned int i;
+	int i;
 	union block_sequence_params *params;
 	struct dce_hwseq *hws = dc->hwseq;
 
@@ -2550,7 +2550,7 @@ void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_con
  * operations to complete. It should be invoked as a pre-amble prior
  * to full update programming before asserting any HW locks.
  */
-	int pipe_idx;
+	unsigned int pipe_idx;
 	int opp_inst;
 	int opp_count = dc->res_pool->res_cap->num_opp;
 	struct hubp *hubp;
@@ -3019,7 +3019,7 @@ void hwss_hubp_wait_flip_pending(union block_sequence_params *params)
 	struct hubp *hubp = params->hubp_wait_flip_pending_params.hubp;
 	unsigned int timeout_us = params->hubp_wait_flip_pending_params.timeout_us;
 	unsigned int polling_interval_us = params->hubp_wait_flip_pending_params.polling_interval_us;
-	int j = 0;
+	unsigned int j = 0;
 
 	for (j = 0; j < timeout_us / polling_interval_us
 		&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
@@ -3031,7 +3031,7 @@ void hwss_tg_wait_double_buffer_pending(union block_sequence_params *params)
 	struct timing_generator *tg = params->tg_wait_double_buffer_pending_params.tg;
 	unsigned int timeout_us = params->tg_wait_double_buffer_pending_params.timeout_us;
 	unsigned int polling_interval_us = params->tg_wait_double_buffer_pending_params.polling_interval_us;
-	int j = 0;
+	unsigned int j = 0;
 
 	if (tg->funcs->get_optc_double_buffer_pending) {
 		for (j = 0; j < timeout_us / polling_interval_us
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index deb23d20bca6..afdf9f8b16d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -33,7 +33,7 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 {
 	bool is_dig_stream = false;
 	struct link_encoder *link_enc = NULL;
-	int i;
+	unsigned int i;
 
 	/* Loop over created link encoder objects. */
 	if (stream) {
@@ -161,7 +161,7 @@ static enum engine_id find_first_avail_link_enc(
 		enum engine_id eng_id_requested)
 {
 	enum engine_id eng_id = ENGINE_ID_UNKNOWN;
-	int i;
+	unsigned int i;
 
 	if (eng_id_requested != ENGINE_ID_UNKNOWN) {
 
@@ -248,7 +248,7 @@ static struct link_encoder *get_link_enc_used_by_link(
 /* Clear all link encoder assignments. */
 static void clear_enc_assignments(const struct dc *dc, struct dc_state *state)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid = false;
@@ -523,7 +523,7 @@ struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
 {
 	struct link_encoder *link_enc = NULL;
 	enum engine_id encs_assigned[MAX_LINK_ENCODERS];
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAX_LINK_ENCODERS; i++)
 		encs_assigned[i] = ENGINE_ID_UNKNOWN;
@@ -624,7 +624,8 @@ bool link_enc_cfg_validate(struct dc *dc, struct dc_state *state)
 	bool valid_uniqueness = true;
 	bool valid_avail = true;
 	bool valid_streams = true;
-	int i, j;
+	int i;
+	unsigned int j;
 	uint8_t valid_count = 0;
 	uint8_t dig_stream_count = 0;
 	int eng_ids_per_ep_id[MAX_PIPES] = {0};
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1ab76c2d0f72..ad377a991451 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -446,7 +446,7 @@ bool resource_construct(
 {
 	struct dc_context *ctx = dc->ctx;
 	const struct resource_caps *caps = pool->res_cap;
-	int i;
+	unsigned int i;
 	unsigned int num_audio = caps->num_audio;
 	struct resource_straps straps = {0};
 
@@ -463,7 +463,7 @@ bool resource_construct(
 		 * PORT_CONNECTIVITY == 1 (as instructed by HW team).
 		 */
 		update_num_audio(&straps, &num_audio, &pool->audio_support);
-		for (i = 0; i < caps->num_audio; i++) {
+		for (i = 0; i < (unsigned int)caps->num_audio; i++) {
 			struct audio *aud = create_funcs->create_audio(ctx, i);
 
 			if (aud == NULL) {
@@ -481,14 +481,14 @@ bool resource_construct(
 
 	pool->stream_enc_count = 0;
 	if (create_funcs->create_stream_encoder) {
-		for (i = 0; i < caps->num_stream_encoder; i++) {
+		for (i = 0; i < (unsigned int)caps->num_stream_encoder; i++) {
 			pool->stream_enc[i] = create_funcs->create_stream_encoder(i, ctx);
 			if (pool->stream_enc[i] == NULL)
 				DC_ERR("DC: failed to create stream_encoder!\n");
 			pool->stream_enc_count++;
 		}
 
-		for (i = 0; i < caps->num_analog_stream_encoder; i++) {
+		for (i = 0; i < (unsigned int)caps->num_analog_stream_encoder; i++) {
 			pool->stream_enc[caps->num_stream_encoder + i] =
 				create_funcs->create_stream_encoder(ENGINE_ID_DACA + i, ctx);
 			if (pool->stream_enc[caps->num_stream_encoder + i] == NULL)
@@ -499,7 +499,7 @@ bool resource_construct(
 
 	pool->hpo_dp_stream_enc_count = 0;
 	if (create_funcs->create_hpo_dp_stream_encoder) {
-		for (i = 0; i < caps->num_hpo_dp_stream_encoder; i++) {
+		for (i = 0; i < (unsigned int)caps->num_hpo_dp_stream_encoder; i++) {
 			pool->hpo_dp_stream_enc[i] = create_funcs->create_hpo_dp_stream_encoder(i+ENGINE_ID_HPO_DP_0, ctx);
 			if (pool->hpo_dp_stream_enc[i] == NULL)
 				DC_ERR("DC: failed to create HPO DP stream encoder!\n");
@@ -510,7 +510,7 @@ bool resource_construct(
 
 	pool->hpo_dp_link_enc_count = 0;
 	if (create_funcs->create_hpo_dp_link_encoder) {
-		for (i = 0; i < caps->num_hpo_dp_link_encoder; i++) {
+		for (i = 0; i < (unsigned int)caps->num_hpo_dp_link_encoder; i++) {
 			pool->hpo_dp_link_enc[i] = create_funcs->create_hpo_dp_link_encoder((uint8_t)i, ctx);
 			if (pool->hpo_dp_link_enc[i] == NULL)
 				DC_ERR("DC: failed to create HPO DP link encoder!\n");
@@ -518,7 +518,7 @@ bool resource_construct(
 		}
 	}
 
-	for (i = 0; i < caps->num_mpc_3dlut; i++) {
+	for (i = 0; i < (unsigned int)caps->num_mpc_3dlut; i++) {
 		pool->mpc_lut[i] = dc_create_3dlut_func();
 		if (pool->mpc_lut[i] == NULL)
 			DC_ERR("DC: failed to create MPC 3dlut!\n");
@@ -551,11 +551,11 @@ static int find_matching_clock_source(
 		struct clock_source *clock_source)
 {
 
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->clk_src_count; i++) {
 		if (pool->clock_sources[i] == clock_source)
-			return i;
+			return (int)i;
 	}
 	return -1;
 }
@@ -1876,7 +1876,7 @@ int recource_find_free_pipe_not_used_in_cur_res_ctx(
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_pipe, *cur_pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		cur_pipe = &cur_res_ctx->pipe_ctx[i];
@@ -1899,7 +1899,7 @@ int recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_pipe, *cur_pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		cur_pipe = &cur_res_ctx->pipe_ctx[i];
@@ -1922,7 +1922,7 @@ int resource_find_free_pipe_used_as_cur_sec_dpp(
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_pipe, *cur_pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		cur_pipe = &cur_res_ctx->pipe_ctx[i];
@@ -1946,7 +1946,7 @@ int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_pipe, *cur_pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		cur_pipe = &cur_res_ctx->pipe_ctx[i];
@@ -1969,7 +1969,7 @@ int resource_find_any_free_pipe(struct resource_context *new_res_ctx,
 {
 	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
 	const struct pipe_ctx *new_pipe;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		new_pipe = &new_res_ctx->pipe_ctx[i];
@@ -2564,7 +2564,7 @@ static bool update_pipe_params_after_odm_slice_count_change(
 		struct dc_state *context,
 		const struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	struct pipe_ctx *pipe;
 	bool result = true;
 
@@ -2587,7 +2587,7 @@ static bool update_pipe_params_after_mpc_slice_count_change(
 		struct dc_state *context,
 		const struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 	struct pipe_ctx *pipe;
 	bool result = true;
 
@@ -2604,7 +2604,7 @@ static int acquire_first_split_pipe(
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct pipe_ctx *split_pipe = &res_ctx->pipe_ctx[i];
@@ -2628,7 +2628,7 @@ static int acquire_first_split_pipe(
 			split_pipe->pipe_idx = (uint8_t)i;
 
 			split_pipe->stream = stream;
-			return i;
+			return (int)i;
 		}
 	}
 	return FREE_PIPE_INDEX_NOT_FOUND;
@@ -2640,7 +2640,7 @@ static void update_stream_engine_usage(
 		struct stream_encoder *stream_enc,
 		bool acquired)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->stream_enc_count; i++) {
 		if (pool->stream_enc[i] == stream_enc)
@@ -2654,7 +2654,7 @@ static void update_hpo_dp_stream_engine_usage(
 		struct hpo_dp_stream_encoder *hpo_dp_stream_enc,
 		bool acquired)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
 		if (pool->hpo_dp_stream_enc[i] == hpo_dp_stream_enc)
@@ -2679,14 +2679,14 @@ static inline int find_acquired_hpo_dp_link_enc_for_link(
 static inline int find_free_hpo_dp_link_enc(const struct resource_context *res_ctx,
 		const struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts); i++)
 		if (res_ctx->hpo_dp_link_enc_ref_cnts[i] == 0)
 			break;
 
 	return (i < ARRAY_SIZE(res_ctx->hpo_dp_link_enc_ref_cnts) &&
-			i < pool->hpo_dp_link_enc_count) ? i : -1;
+			i < pool->hpo_dp_link_enc_count) ? (int)i : -1;
 }
 
 static inline void acquire_hpo_dp_link_enc(
@@ -2773,9 +2773,10 @@ static inline int find_fixed_dio_link_enc(const struct dc_link *link)
 static inline int find_free_dio_link_enc(const struct resource_context *res_ctx,
 		const struct dc_link *link, const struct resource_pool *pool, struct dc_stream_state *stream)
 {
-	int i, j = -1;
+	unsigned int i;
+	int j = -1;
 	int stream_enc_inst = -1;
-	int enc_count = pool->dig_link_enc_count;
+	unsigned int enc_count = pool->dig_link_enc_count;
 
 	/* Find stream encoder instance for the stream */
 	if (stream) {
@@ -2931,7 +2932,7 @@ static void remove_dio_link_enc_from_ctx(struct resource_context *res_ctx,
 
 static int get_num_of_free_pipes(const struct resource_pool *pool, const struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	int count = 0;
 
 	for (i = 0; i < pool->pipe_count; i++)
@@ -3608,7 +3609,7 @@ void update_audio_usage(
 		struct audio *audio,
 		bool acquired)
 {
-	int i;
+	unsigned int i;
 	for (i = 0; i < pool->audio_count; i++) {
 		if (pool->audios[i] == audio)
 			res_ctx->is_audio_acquired[i] = acquired;
@@ -3621,7 +3622,7 @@ static struct hpo_dp_stream_encoder *find_first_free_match_hpo_dp_stream_enc_for
 		struct dc_stream_state *stream)
 {
 	(void)stream;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->hpo_dp_stream_enc_count; i++) {
 		if (!res_ctx->is_hpo_dp_stream_enc_acquired[i] &&
@@ -3950,7 +3951,7 @@ static bool acquire_otg_master_pipe_for_stream(
 		if (pool->dpps[pipe_idx])
 			pipe_ctx->plane_res.mpcc_inst = (uint8_t)pool->dpps[pipe_idx]->inst;
 
-		if (pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
+		if ((unsigned int)pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
 			int tg_inst = pool->timing_generator_count - 1;
 
 			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
@@ -4194,7 +4195,8 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	int del_streams_count = 0;
 	int add_streams_count = 0;
 	bool found = false;
-	int i, j, k;
+	int i, j;
+	unsigned int k;
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
@@ -4421,7 +4423,8 @@ enum dc_status dc_validate_global_state(
 		enum dc_validate_mode validate_mode)
 {
 	enum dc_status result = DC_ERROR_UNEXPECTED;
-	int i, j;
+	int i;
+	unsigned int j;
 
 	if (!new_ctx)
 		return DC_ERROR_UNEXPECTED;
@@ -4880,7 +4883,7 @@ struct clock_source *dc_resource_find_first_free_pll(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->clk_src_count; ++i) {
 		if (res_ctx->clock_source_ref_count[i] == 0)
@@ -5398,7 +5401,7 @@ void check_syncd_pipes_for_disabled_master_pipe(struct dc *dc,
 	struct dc_state *context,
 	uint8_t disabled_master_pipe_idx)
 {
-	int i;
+	unsigned int i;
 	struct pipe_ctx *pipe_ctx, *pipe_ctx_check;
 
 	pipe_ctx = &context->res_ctx.pipe_ctx[disabled_master_pipe_idx];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index dbee34935c2f..0cc26f750586 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -954,7 +954,7 @@ bool dc_state_remove_phantom_streams_and_planes(
 	const struct dc *dc,
 	struct dc_state *state)
 {
-	int i;
+	unsigned int i;
 	bool removed_phantom = false;
 	struct dc_stream_state *phantom_stream = NULL;
 
@@ -979,7 +979,7 @@ void dc_state_release_phantom_streams_and_planes(
 	unsigned int phantom_count;
 	struct dc_stream_state *phantom_streams[MAX_PHANTOM_PIPES];
 	struct dc_plane_state *phantom_planes[MAX_PHANTOM_PIPES];
-	int i;
+	unsigned int i;
 
 	phantom_count = state->phantom_stream_count;
 	memcpy(phantom_streams, state->phantom_streams, sizeof(struct dc_stream_state *) * MAX_PHANTOM_PIPES);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index a1a08828e236..438e6415db6d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -514,7 +514,7 @@ bool dc_stream_program_cursor_position(
 		/* apply/update visual confirm */
 		if (dc->debug.visual_confirm == VISUAL_CONFIRM_HW_CURSOR) {
 			/* update software state */
-			int i;
+			unsigned int i;
 
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
 				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -533,7 +533,7 @@ bool dc_stream_program_cursor_position(
 
 		if (stream->drr_trigger_mode == DRR_TRIGGER_ON_FLIP_AND_CURSOR) {
 			/* apply manual trigger */
-			int i;
+			unsigned int i;
 
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
 				struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -559,7 +559,7 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dc_writeback_info *wb_info)
 {
 	bool isDrc = false;
-	int i = 0;
+	unsigned int i = 0;
 	struct dwbc *dwb;
 
 	if (stream == NULL) {
@@ -968,7 +968,7 @@ struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
 	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
 
 	// see if one is allocated for this stream
-	for (int i = 0; i < num_rmcm; i++) {
+	for (unsigned int i = 0; i < num_rmcm; i++) {
 		if (dc->res_pool->rmcm_3dlut[i].isInUse &&
 			dc->res_pool->rmcm_3dlut[i].stream == stream)
 			return &dc->res_pool->rmcm_3dlut[i];
@@ -979,7 +979,7 @@ struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
 		return NULL;
 
 	//see if there is an unused 3dlut, allocate
-	for (int i = 0; i < num_rmcm; i++) {
+	for (unsigned int i = 0; i < num_rmcm; i++) {
 		if (!dc->res_pool->rmcm_3dlut[i].isInUse) {
 			dc->res_pool->rmcm_3dlut[i].isInUse = true;
 			dc->res_pool->rmcm_3dlut[i].stream = stream;
@@ -1011,7 +1011,7 @@ void dc_stream_init_rmcm_3dlut(struct dc *dc)
 {
 	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
 
-	for (int i = 0; i < num_rmcm; i++) {
+	for (unsigned int i = 0; i < num_rmcm; i++) {
 		dc->res_pool->rmcm_3dlut[i].isInUse = false;
 		dc->res_pool->rmcm_3dlut[i].stream = NULL;
 		dc->res_pool->rmcm_3dlut[i].protection_bits = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 15167d0bd467..b03c8fc2f7ce 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -69,7 +69,7 @@ void dc_plane_destruct(struct dc_plane_state *plane_state)
 uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane_state *plane_state)
 {
 	uint8_t pipe_mask = 0;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < plane_state->ctx->dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc_state->res_ctx.pipe_ctx[i];
@@ -115,7 +115,7 @@ const struct dc_plane_status *dc_plane_get_status(
 {
 	const struct dc_plane_status *plane_status;
 	struct dc  *dc;
-	int i;
+	unsigned int i;
 
 	if (!plane_state ||
 		!plane_state->ctx ||
@@ -286,7 +286,7 @@ void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
 					   bool clear_tiling)
 {
 	struct dc *dc;
-	int i;
+	unsigned int i;
 
 	if (!plane_state)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0dd6d1463137..7c8d179e3554 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -151,7 +151,7 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
 	enum dmub_status status = DMUB_STATUS_OK;
-	int i;
+	unsigned int i;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
@@ -193,7 +193,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
 	enum dmub_status status;
-	int i;
+	unsigned int i;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
@@ -430,7 +430,7 @@ static void dc_dmub_srv_populate_fams_pipe_info(struct dc *dc, struct dc_state *
 		struct pipe_ctx *head_pipe,
 		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data *fams_pipe_data)
 {
-	int j;
+	unsigned int j;
 	int pipe_idx = 0;
 
 	fams_pipe_data->pipe_index[pipe_idx++] = (uint8_t)head_pipe->plane_res.hubp->inst;
@@ -448,7 +448,8 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 {
 	union dmub_rb_cmd cmd = { 0 };
 	struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
-	int i = 0, k = 0;
+	unsigned int i = 0;
+	int k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
 	struct dc_stream_status *stream_status = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index e221384f7611..9650cccf1b8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -432,7 +432,7 @@ void generic_reg_wait(const struct dc_context *ctx,
 {
 	uint32_t field_value;
 	uint32_t reg_val;
-	int i;
+	unsigned int i;
 
 	if (ctx->dmub_srv &&
 	    ctx->dmub_srv->reg_helper_offload.gather_in_progress) {
@@ -447,7 +447,7 @@ void generic_reg_wait(const struct dc_context *ctx,
 	 * This value comes from experiments.
 	 *
 	 */
-	ASSERT(delay_between_poll_us * time_out_num_tries <= 3000000);
+	ASSERT(delay_between_poll_us * time_out_num_tries <= 3000000u);
 
 	for (i = 0; i <= time_out_num_tries; i++) {
 		if (i) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
index ee55ec21d270..72c0950808ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
@@ -171,7 +171,7 @@ static void dce_ipp_program_input_lut(
 	struct input_pixel_processor *ipp,
 	const struct dc_gamma *gamma)
 {
-	int i;
+	unsigned int i;
 	struct dce_ipp *ipp_dce = TO_DCE_IPP(ipp);
 
 	/* power on LUT memory */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 5f40ae9e3120..2ef022db95ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -815,6 +815,7 @@ static bool dce110_link_encoder_validate_hdmi_output(
 {
 	enum dc_color_depth max_deep_color =
 			enc110->base.features.max_hdmi_deep_color;
+	int max_hdmi_pixel_clock_khz = (int)enc110->base.features.max_hdmi_pixel_clock;
 
 	if (max_deep_color < crtc_timing->display_color_depth)
 		return false;
@@ -825,7 +826,7 @@ static bool dce110_link_encoder_validate_hdmi_output(
 		return false;
 
 	if ((adjusted_pix_clk_khz == 0) ||
-		(adjusted_pix_clk_khz > enc110->base.features.max_hdmi_pixel_clock))
+		(adjusted_pix_clk_khz > max_hdmi_pixel_clock_khz))
 		return false;
 
 	/* DCE11 HW does not support 420 */
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index d178dcc4306d..b3640682fa60 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1173,13 +1173,13 @@ bool dce_transform_get_optimal_number_of_taps(
 {
 	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
 	int pixel_width = scl_data->viewport.width;
-	int max_num_of_lines;
+	uint32_t max_num_of_lines;
 
 	if (xfm_dce->prescaler_on &&
 			(scl_data->viewport.width > scl_data->recout.width))
 		pixel_width = scl_data->recout.width;
 
-	max_num_of_lines = dce_transform_get_max_num_of_supported_lines(
+	max_num_of_lines = (uint32_t)dce_transform_get_max_num_of_supported_lines(
 		xfm_dce,
 		scl_data->lb_params.depth,
 		pixel_width);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index a3cd04fc44f7..2f4d368bd3fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -58,7 +58,7 @@ static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 	union dmub_rb_cmd cmd;
 	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
 	uint32_t edp_id_count = dc->dc_edp_id_count;
-	int i;
+	unsigned int i;
 	uint8_t panel_mask = 0;
 
 	for (i = 0; i < edp_id_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 9ffc7fd3212e..502a2d9b155f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -342,8 +342,8 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	struct pwl_result_data *rgb_minus_1;
 
 	int32_t region_start, region_end;
-	int32_t i;
-	uint32_t j, k, seg_distr[MAX_REGIONS_NUMBER], increment, start_index, hw_points;
+	int32_t k;
+	uint32_t i, j, seg_distr[MAX_REGIONS_NUMBER], increment, start_index, hw_points;
 
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
@@ -398,8 +398,8 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 			if (j == hw_points - 1)
 				break;
 			if (i >= TRANSFER_FUNC_POINTS) {
-				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
-					     i, TRANSFER_FUNC_POINTS);
+				DC_LOG_ERROR("Index out of bounds: i=%u, TRANSFER_FUNC_POINTS=%u\n",
+					     i, (uint32_t)TRANSFER_FUNC_POINTS);
 				return false;
 			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
@@ -547,8 +547,8 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 	struct pwl_result_data *rgb_plus_1;
 
 	int32_t region_start, region_end;
-	int32_t i;
-	uint32_t j, k, seg_distr[MAX_REGIONS_NUMBER], increment, start_index, hw_points;
+	int32_t k;
+	uint32_t i, j, seg_distr[MAX_REGIONS_NUMBER], increment, start_index, hw_points;
 
 	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index baf663b661c8..feb6ca92802c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -59,7 +59,7 @@ unsigned int snprintf_count(char *pbuf, unsigned int bufsize, const char *fmt, .
 	va_end(args);
 
 	if (ret_vsnprintf > 0) {
-		if (ret_vsnprintf < bufsize)
+		if ((unsigned int)ret_vsnprintf < bufsize)
 			chars_printed = ret_vsnprintf;
 		else
 			chars_printed = bufsize - 1;
@@ -73,7 +73,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsigned i
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct dcn_hubbub_wm wm;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -111,7 +111,7 @@ static unsigned int dcn10_get_hubp_states(struct dc *dc, char *pBuf, unsigned in
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -189,7 +189,7 @@ static unsigned int dcn10_get_hubp_states(struct dc *dc, char *pBuf, unsigned in
 static unsigned int dcn10_get_rq_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -231,7 +231,7 @@ static unsigned int dcn10_get_rq_states(struct dc *dc, char *pBuf, unsigned int
 static unsigned int dcn10_get_dlg_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -288,7 +288,7 @@ static unsigned int dcn10_get_dlg_states(struct dc *dc, char *pBuf, unsigned int
 static unsigned int dcn10_get_ttu_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -328,7 +328,7 @@ static unsigned int dcn10_get_ttu_states(struct dc *dc, char *pBuf, unsigned int
 static unsigned int dcn10_get_cm_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -383,7 +383,7 @@ static unsigned int dcn10_get_cm_states(struct dc *dc, char *pBuf, unsigned int
 static unsigned int dcn10_get_mpcc_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -414,7 +414,7 @@ static unsigned int dcn10_get_mpcc_states(struct dc *dc, char *pBuf, unsigned in
 static unsigned int dcn10_get_otg_states(struct dc *dc, char *pBuf, unsigned int bufSize)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = bufSize;
@@ -491,7 +491,7 @@ static unsigned int dcn10_get_clock_states(struct dc *dc, char *pBuf, unsigned i
 static void dcn10_clear_otpc_underflow(struct dc *dc)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->timing_generator_count; i++) {
 		struct timing_generator *tg = pool->timing_generators[i];
@@ -508,7 +508,7 @@ static void dcn10_clear_otpc_underflow(struct dc *dc)
 static void dcn10_clear_hubp_underflow(struct dc *dc)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct hubp *hubp = pool->hubps[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index f73c5f42ea68..7163426a0920 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -696,7 +696,7 @@ static void wbscl_set_scaler_filter(
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-			if ((pair * 2 + 1) < taps)
+			if ((uint32_t)(pair * 2 + 1) < taps)
 				odd_coef = filter[phase * taps + 2 * pair + 1];
 			else
 				odd_coef = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 9dbccf58dde5..bfd5515c2f4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -172,11 +172,13 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	hw_points = fixpoint ? (hw_points - 1) : hw_points;
 
 	j = 0;
-	for (k = 0; k < (region_end - region_start); k++) {
+	uint32_t region_span = (uint32_t)(region_end - region_start);
+	for (k = 0; k < region_span; k++) {
 		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
 		start_index = (region_start + k + MAX_LOW_POINT) *
 				NUMBER_SW_SEGMENTS;
-		for (i = start_index; i < start_index + NUMBER_SW_SEGMENTS;
+		int32_t index_end = (int32_t)(start_index + NUMBER_SW_SEGMENTS);
+		for (i = start_index; i < index_end;
 				i += increment) {
 			if (j == hw_points)
 				break;
@@ -258,7 +260,7 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 			uint32_t green_clamp;
 			uint32_t blue_clamp;
 
-			if (i >= hw_points) {
+			if ((uint32_t)i >= hw_points) {
 				if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
 					rgb_plus_1->red = dc_fixpt_add(rgb->red,
 							rgb_minus_1->delta_red);
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 13e14aad3daa..872ea3646023 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -622,10 +622,11 @@ static bool dcn10_link_encoder_validate_hdmi_output(
 {
 	enum dc_color_depth max_deep_color =
 			enc10->base.features.max_hdmi_deep_color;
+	uint32_t pix_clk_100hz = (uint32_t)adjusted_pix_clk_100hz;
 
 	// check pixel clock against edid specified max TMDS clk
 	if (edid_caps->max_tmds_clk_mhz != 0 &&
-			adjusted_pix_clk_100hz > edid_caps->max_tmds_clk_mhz * 10000)
+			pix_clk_100hz > edid_caps->max_tmds_clk_mhz * 10000)
 		return false;
 
 	if (max_deep_color < crtc_timing->display_color_depth)
@@ -633,11 +634,11 @@ static bool dcn10_link_encoder_validate_hdmi_output(
 
 	if (crtc_timing->display_color_depth < COLOR_DEPTH_888)
 		return false;
-	if (adjusted_pix_clk_100hz < (TMDS_MIN_PIXEL_CLOCK * 10))
+	if (pix_clk_100hz < (TMDS_MIN_PIXEL_CLOCK * 10))
 		return false;
 
-	if ((adjusted_pix_clk_100hz == 0) ||
-		(adjusted_pix_clk_100hz > (enc10->base.features.max_hdmi_pixel_clock * 10)))
+	if ((pix_clk_100hz == 0) ||
+		(pix_clk_100hz > (enc10->base.features.max_hdmi_pixel_clock * 10)))
 		return false;
 
 	/* DCE11 HW does not support 420 */
@@ -647,7 +648,7 @@ static bool dcn10_link_encoder_validate_hdmi_output(
 
 	if ((!enc10->base.features.flags.bits.HDMI_6GB_EN ||
 			enc10->base.ctx->dc->debug.hdmi20_disable) &&
-			adjusted_pix_clk_100hz >= 3000000)
+			pix_clk_100hz >= 3000000)
 		return false;
 	if (enc10->base.ctx->dc->debug.hdmi20_disable &&
 		crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 2bdd063cc1e1..2b8afe46ff1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -824,7 +824,7 @@ void dpp1_program_input_lut(
 		struct dpp *dpp_base,
 		const struct dc_gamma *gamma)
 {
-	int i;
+	unsigned int i;
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 	bool rama_occupied = false;
 	uint32_t ram_num;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
index 0d2c9fcd3362..b9adf8433b36 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
@@ -256,7 +256,7 @@ static void dpp1_dscl_set_scaler_filter(
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-			if ((pair * 2 + 1) < taps)
+			if ((uint32_t)(pair * 2 + 1) < taps)
 				odd_coef = filter[phase * taps + 2 * pair + 1];
 			else
 				odd_coef = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index e7880fc61b4a..d24f02d201f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -517,11 +517,16 @@ bool dpp3_get_optimal_number_of_taps(
 	else if (max_taps_c < min_taps_c)
 		return false;
 
-	if (scl_data->taps.v_taps > max_taps_y)
-		scl_data->taps.v_taps = max_taps_y;
+	{
+		uint32_t max_supported_taps_y = (uint32_t)max_taps_y;
+		uint32_t max_supported_taps_c = (uint32_t)max_taps_c;
 
-	if (scl_data->taps.v_taps_c > max_taps_c)
-		scl_data->taps.v_taps_c = max_taps_c;
+		if (scl_data->taps.v_taps > max_supported_taps_y)
+			scl_data->taps.v_taps = max_supported_taps_y;
+
+		if (scl_data->taps.v_taps_c > max_supported_taps_c)
+			scl_data->taps.v_taps_c = max_supported_taps_c;
+	}
 
 	if (!dpp->ctx->dc->debug.always_scale) {
 		if (IDENTITY_RATIO(scl_data->ratios.horz)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 4f3b48ed8679..340111e3deac 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -176,7 +176,7 @@ static void dpp401_program_cursor_csc(
 	struct color_matrices_reg cur_matrix_regs;
 	unsigned int i;
 	const uint16_t *regval = NULL;
-	int arr_size = sizeof(dpp_input_csc_matrix) / sizeof(struct dpp_input_csc_matrix);
+	unsigned int arr_size = sizeof(dpp_input_csc_matrix) / sizeof(struct dpp_input_csc_matrix);
 
 	if (color_space < COLOR_SPACE_YCBCR601) {
 		REG_SET(CUR0_MATRIX_MODE, 0, CUR0_MATRIX_MODE, CUR_MATRIX_BYPASS);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 8b7e55e337d3..df3c21ef57a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -253,7 +253,7 @@ static void dpp401_dscl_set_scaler_filter(
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-			if ((pair * 2 + 1) < taps)
+			if ((uint32_t)(pair * 2 + 1) < taps)
 				odd_coef = filter[phase * taps + 2 * pair + 1];
 			else
 				odd_coef = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 8dfb6dd14eb2..8dcdda46ee1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -858,19 +858,20 @@ static bool decide_dsc_target_bpp_x16(
 		int *target_bpp_x16)
 {
 	struct dc_dsc_bw_range range;
+	uint32_t target_bandwidth_kbps_u = (uint32_t)target_bandwidth_kbps;
 
 	*target_bpp_x16 = 0;
 
 	if (decide_dsc_bandwidth_range(policy->min_target_bpp * 16, policy->max_target_bpp * 16,
 			num_slices_h, dsc_common_caps, timing, link_encoding, &range)) {
-		if (target_bandwidth_kbps >= range.stream_kbps) {
+		if (target_bandwidth_kbps_u >= range.stream_kbps) {
 			if (policy->enable_dsc_when_not_needed || options->force_dsc_when_not_needed)
 				/* enable max bpp even dsc is not needed */
 				*target_bpp_x16 = range.max_target_bpp_x16;
-		} else if (target_bandwidth_kbps >= range.max_kbps) {
+		} else if (target_bandwidth_kbps_u >= range.max_kbps) {
 			/* use max target bpp allowed */
 			*target_bpp_x16 = range.max_target_bpp_x16;
-		} else if (target_bandwidth_kbps >= range.min_kbps) {
+		} else if (target_bandwidth_kbps_u >= range.min_kbps) {
 			/* use target bpp that can take entire target bandwidth */
 			*target_bpp_x16 = compute_bpp_x16_from_target_bandwidth(
 					target_bandwidth_kbps, timing, num_slices_h,
@@ -1053,10 +1054,11 @@ static bool setup_dsc_config(
 	int max_slices_h = 0;
 	int num_slices_h = 0;
 	int pic_width;
+	uint32_t pic_width_u;
 	int slice_width;
 	int target_bpp;
 	int sink_per_slice_throughput_mps;
-	int branch_max_throughput_mps = 0;
+	uint32_t branch_max_throughput_mps = 0;
 	bool is_dsc_possible = false;
 	int pic_height;
 	int slice_height;
@@ -1066,12 +1068,13 @@ static bool setup_dsc_config(
 
 	dc_dsc_get_policy_for_timing(timing, options->max_target_bpp_limit_override_x16, &policy, link_encoding);
 	pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
+	pic_width_u = (uint32_t)pic_width;
 	pic_height = timing->v_addressable + timing->v_border_top + timing->v_border_bottom;
 
 	if (!dsc_sink_caps->is_dsc_supported)
 		goto done;
 
-	if (dsc_sink_caps->branch_max_line_width && dsc_sink_caps->branch_max_line_width < pic_width)
+	if (dsc_sink_caps->branch_max_line_width && dsc_sink_caps->branch_max_line_width < pic_width_u)
 		goto done;
 
 	// Intersect decoder with encoder DSC caps and validate DSC settings
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index 9c326ad1d3b1..7ee31cae5959 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -168,8 +168,9 @@ bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct ds
 {
 	struct dsc_optc_config dsc_optc_cfg;
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+	uint32_t max_image_width = (uint32_t)dsc20->max_image_width;
 
-	if (dsc_cfg->pic_width > dsc20->max_image_width)
+	if (dsc_cfg->pic_width > max_image_width)
 		return false;
 
 	return dsc_prepare_config(dsc_cfg, &dsc20->reg_vals, &dsc_optc_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 41c3b814b6bd..363e83ad21db 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -119,8 +119,9 @@ bool dsc401_validate_stream(struct display_stream_compressor *dsc, const struct
 {
 	struct dsc_optc_config dsc_optc_cfg;
 	struct dcn401_dsc *dsc401 = TO_DCN401_DSC(dsc);
+	uint32_t max_image_width = (uint32_t)dsc401->max_image_width;
 
-	if (dsc_cfg->pic_width > dsc401->max_image_width)
+	if (dsc_cfg->pic_width > max_image_width)
 		return false;
 
 	return dsc_prepare_config(dsc_cfg, &dsc401->reg_vals, &dsc_optc_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 3b9542c08f3d..e12ed7591848 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -833,7 +833,7 @@ bool hubbub401_get_dcc_compression_cap(struct hubbub *hubbub,
 		struct dc_surface_dcc_cap *output)
 {
 	struct dc *dc = hubbub->ctx->dc;
-	const unsigned int max_dcc_plane_width = dc->caps.dcc_plane_width_limit;
+	const int max_dcc_plane_width = (int)dc->caps.dcc_plane_width_limit;
 	/* DCN4_Programming_Guide_DCHUB.docx, Section 5.11.2.2 */
 	enum dcc_control dcc_control;
 	unsigned int plane0_bpe, plane1_bpe;
@@ -1198,6 +1198,7 @@ bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs
 
 	bool wm_pending = false;
 	uint32_t temp;
+	bool allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req != 0;
 
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
@@ -1205,8 +1206,8 @@ bool dcn401_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs
 	/* P-State stall threshold */
 	REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
 
-	if (safe_to_lower || arb_regs->allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
-		hubbub2->allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req;
+	if (safe_to_lower || allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+		hubbub2->allow_sdpif_rate_limit_when_cstate_req = allow_sdpif_rate_limit_when_cstate_req;
 
 		/* only update the required bits */
 		REG_GET(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, &temp);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 73b6b0ffcb74..ddfc60e845a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -503,6 +503,7 @@ static bool dcn42_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb
 
 	bool wm_pending = false;
 	uint32_t temp;
+	bool allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req != 0;
 
 	/* request backpressure and outstanding return threshold (unused)*/
 	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
@@ -510,8 +511,8 @@ static bool dcn42_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb
 	/* 401 delta: do not update P-State stall threshold (handled by fw) */
 	// REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
 
-	if (safe_to_lower || arb_regs->allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
-		hubbub2->allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req;
+	if (safe_to_lower || allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+		hubbub2->allow_sdpif_rate_limit_when_cstate_req = allow_sdpif_rate_limit_when_cstate_req;
 
 		/* only update the required bits */
 		REG_GET(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, &temp);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 244d4462fa9e..cf2c9f80056e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -710,7 +710,7 @@ void hubp2_dmdata_load(
 		uint32_t dmdata_sw_size,
 		const uint32_t *dmdata_sw_data)
 {
-	int i;
+	unsigned int i;
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	/* load dmdata into HUBP buffer in SW mode */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e6712cffeb04..921e70c14346 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -504,7 +504,7 @@ dce110_translate_regamma_to_hw_format(const struct dc_transfer_func *output_tf,
 	}
 
 	j = 0;
-	for (k = 0; k < (region_end - region_start); k++) {
+	for (k = 0; k < (uint32_t)(region_end - region_start); k++) {
 		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
 		start_index = (region_start + k + MAX_LOW_POINT) *
 				NUMBER_SW_SEGMENTS;
@@ -1810,7 +1810,7 @@ static void power_down_encoders(struct dc *dc)
 
 static void power_down_controllers(struct dc *dc)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
 		dc->res_pool->timing_generators[i]->funcs->disable_crtc(
@@ -1820,7 +1820,7 @@ static void power_down_controllers(struct dc *dc)
 
 static void power_down_clock_sources(struct dc *dc)
 {
-	int i;
+	unsigned int i;
 
 	if (dc->res_pool->dp_clock_source->funcs->cs_power_down(
 		dc->res_pool->dp_clock_source) == false)
@@ -1829,7 +1829,7 @@ static void power_down_clock_sources(struct dc *dc)
 	for (i = 0; i < dc->res_pool->clk_src_count; i++) {
 		if (dc->res_pool->clock_sources[i]->funcs->cs_power_down(
 				dc->res_pool->clock_sources[i]) == false)
-			dm_error("Failed to power down pll! (clk src index=%d)\n", i);
+			dm_error("Failed to power down pll! (clk src index=%u)\n", i);
 	}
 }
 
@@ -1916,13 +1916,13 @@ static void clean_up_dsc_blocks(struct dc *dc)
 	struct stream_encoder *se = NULL;
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
-	int i;
+	unsigned int i;
 
 	if (!dc->caps.is_apu ||
 		dc->ctx->dce_version < DCN_VERSION_3_15)
 		return;
 	/*VBIOS supports dsc starts from dcn315*/
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++) {
 		struct dcn_dsc_state s  = {0};
 
 		dsc = dc->res_pool->dscs[i];
@@ -2000,7 +2000,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	struct pipe_ctx *pipe_ctx = NULL;
 	struct dce_hwseq *hws = dc->hwseq;
 	int edp_with_sink_num;
-	unsigned int edp_num;
+	unsigned int j, edp_num;
 	int edp_stream_num;
 	int i;
 	bool can_apply_edp_fast_boot = false;
@@ -2020,8 +2020,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	/* Check fastboot support, disable on DCE 6-8-10 because of blank screens */
 	if (edp_num && edp_stream_num && dc->ctx->dce_version > DCE_VERSION_10_0) {
-		for (i = 0; i < edp_num; i++) {
-			edp_link = edp_links[i];
+		for (j = 0; j < edp_num; j++) {
+			edp_link = edp_links[j];
 			if (edp_link != edp_streams[0]->link)
 				continue;
 			// enable fastboot if backend is enabled on eDP
@@ -2262,7 +2262,7 @@ static void get_position(struct pipe_ctx **pipe_ctx,
 static void set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params)
 {
-	unsigned int i;
+	int i;
 	unsigned int triggers = 0;
 
 	if (params->triggers.overlay_update)
@@ -2549,7 +2549,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	enum dc_status status;
-	int i;
+	unsigned int i;
 	bool was_hpo_acquired = resource_is_hpo_acquired(dc->current_state);
 	bool is_hpo_acquired = resource_is_hpo_acquired(context);
 
@@ -2915,7 +2915,7 @@ static void dce110_init_pipes(struct dc *dc, struct dc_state *context)
 
 static void dce110_init_hw(struct dc *dc)
 {
-	int i;
+	unsigned int i;
 	struct dc_bios *bp;
 	struct transform *xfm;
 	struct abm *abm;
@@ -3137,7 +3137,7 @@ static void dce110_apply_ctx_for_surface(
 		int num_planes,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	if (num_planes == 0)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 566edc05b99d..169f34ea75b1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -225,7 +225,7 @@ void dcn10_lock_all_pipes(struct dc *dc,
 	struct pipe_ctx *pipe_ctx;
 	struct pipe_ctx *old_pipe_ctx;
 	struct timing_generator *tg;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -298,7 +298,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	DTN_INFO(
 		"HUBP:  format  addr_hi  width  height  rot  mir  sw_mode  dcc_en  blank_en  clock_en  ttu_dis  underflow   min_ttu_vblank       qos_low_wm      qos_high_wm\n");
@@ -456,7 +456,7 @@ static void dcn10_log_color_state(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
-	int i;
+	unsigned int i;
 
 	DTN_INFO("DPP:    IGAM format    IGAM mode    DGAM mode    RGAM mode"
 		 "  GAMUT adjust  "
@@ -616,7 +616,8 @@ void dcn10_log_hw_state(struct dc *dc,
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	int j;
+	unsigned int i;
 
 	DTN_INFO_BEGIN();
 
@@ -686,8 +687,8 @@ void dcn10_log_hw_state(struct dc *dc,
 	// dcn_dsc_state struct field bytes_per_pixel was renamed to bits_per_pixel
 	// TODO: Update golden log header to reflect this name change
 	DTN_INFO("DSC: CLOCK_EN  SLICE_WIDTH  Bytes_pp\n");
-	for (i = 0; i < pool->res_cap->num_dsc; i++) {
-		struct display_stream_compressor *dsc = pool->dscs[i];
+	for (j = 0; j < pool->res_cap->num_dsc; j++) {
+		struct display_stream_compressor *dsc = pool->dscs[j];
 		struct dcn_dsc_state s = {0};
 
 		dsc->funcs->dsc_read_state(dsc, &s);
@@ -1059,7 +1060,7 @@ static void apply_DEGVIDCN10_253_wa(struct dc *dc)
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	struct hubp *hubp = dc->res_pool->hubps[0];
-	int i;
+	unsigned int i;
 
 	if (dc->debug.disable_stutter)
 		return;
@@ -1089,7 +1090,7 @@ void dcn10_bios_golden_init(struct dc *dc)
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *bp = dc->ctx->dc_bios;
-	int i;
+	unsigned int i;
 	bool allow_self_fresh_force_enable = true;
 
 	if (hws->funcs.s0i3_golden_init_wa && hws->funcs.s0i3_golden_init_wa(dc))
@@ -1130,7 +1131,7 @@ static void false_optc_underflow_wa(
 		const struct dc_stream_state *stream,
 		struct timing_generator *tg)
 {
-	int i;
+	unsigned int i;
 	bool underflow;
 
 	if (!dc->hwseq->wa.false_optc_underflow)
@@ -1157,7 +1158,7 @@ static void false_optc_underflow_wa(
 static int calculate_vready_offset_for_group(struct pipe_ctx *pipe)
 {
 	struct pipe_ctx *other_pipe;
-	int vready_offset = pipe->pipe_dlg_param.vready_offset;
+	unsigned int vready_offset = pipe->pipe_dlg_param.vready_offset;
 
 	/* Always use the largest vready_offset of all connected pipes */
 	for (other_pipe = pipe->bottom_pipe; other_pipe != NULL; other_pipe = other_pipe->bottom_pipe) {
@@ -1290,7 +1291,7 @@ static void dcn10_reset_back_end_for_pipe(
 		struct dc_state *context)
 {
 	(void)context;
-	int i;
+	unsigned int i;
 	struct dc_link *link;
 	DC_LOGGER_INIT(dc->ctx);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
@@ -1764,7 +1765,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i;
+	unsigned int i;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2095,22 +2096,22 @@ static void log_tf(struct dc_context *ctx,
 	// DC_LOG_GAMMA is default logging of all hw points
 	// DC_LOG_ALL_GAMMA logs all points, not only hw points
 	// DC_LOG_ALL_TF_POINTS logs all channels of the tf
-	int i = 0;
+	unsigned int i = 0;
 
 	DC_LOG_GAMMA("Gamma Correction TF");
 	DC_LOG_ALL_GAMMA("Logging all tf points...");
 	DC_LOG_ALL_TF_CHANNELS("Logging all channels...");
 
 	for (i = 0; i < hw_points_num; i++) {
-		DC_LOG_GAMMA("R\t%d\t%llu", i, tf->tf_pts.red[i].value);
-		DC_LOG_ALL_TF_CHANNELS("G\t%d\t%llu", i, tf->tf_pts.green[i].value);
-		DC_LOG_ALL_TF_CHANNELS("B\t%d\t%llu", i, tf->tf_pts.blue[i].value);
+		DC_LOG_GAMMA("R\t%u\t%llu", i, tf->tf_pts.red[i].value);
+		DC_LOG_ALL_TF_CHANNELS("G\t%u\t%llu", i, tf->tf_pts.green[i].value);
+		DC_LOG_ALL_TF_CHANNELS("B\t%u\t%llu", i, tf->tf_pts.blue[i].value);
 	}
 
 	for (i = hw_points_num; i < MAX_NUM_HW_POINTS; i++) {
-		DC_LOG_ALL_GAMMA("R\t%d\t%llu", i, tf->tf_pts.red[i].value);
-		DC_LOG_ALL_TF_CHANNELS("G\t%d\t%llu", i, tf->tf_pts.green[i].value);
-		DC_LOG_ALL_TF_CHANNELS("B\t%d\t%llu", i, tf->tf_pts.blue[i].value);
+		DC_LOG_ALL_GAMMA("R\t%u\t%llu", i, tf->tf_pts.red[i].value);
+		DC_LOG_ALL_TF_CHANNELS("G\t%u\t%llu", i, tf->tf_pts.green[i].value);
+		DC_LOG_ALL_TF_CHANNELS("B\t%u\t%llu", i, tf->tf_pts.blue[i].value);
 	}
 }
 
@@ -2278,7 +2279,7 @@ static bool wait_for_reset_trigger_to_occur(
 	/* To avoid endless loop we wait at most
 	 * frames_to_wait_on_triggered_reset frames for the reset to occur. */
 	const uint32_t frames_to_wait_on_triggered_reset = 10;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < frames_to_wait_on_triggered_reset; i++) {
 
@@ -2290,7 +2291,7 @@ static bool wait_for_reset_trigger_to_occur(
 		if (tg->funcs->did_triggered_reset_occur(tg)) {
 			rc = true;
 			/* usually occurs at i=1 */
-			DC_SYNC_INFO("GSL: reset occurred at wait count: %d\n",
+			DC_SYNC_INFO("GSL: reset occurred at wait count: %u\n",
 					i);
 			break;
 		}
@@ -3263,7 +3264,7 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
 {
 		struct pipe_ctx *pipe_ctx;
 		struct timing_generator *tg;
-		int i;
+		unsigned int i;
 
 		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -3294,7 +3295,7 @@ void dcn10_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
@@ -3466,7 +3467,7 @@ void dcn10_get_position(struct pipe_ctx **pipe_ctx,
 void dcn10_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params)
 {
-	unsigned int i;
+	int i;
 	unsigned int triggers = 0;
 
 	if (params->triggers.surface_update)
@@ -3553,7 +3554,7 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 
 static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < res_pool->pipe_count; i++) {
 		if (res_pool->hubps[i]->inst == mpcc_inst)
@@ -3794,7 +3795,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	// Swap axis and mirror vertically
 	else if (param.rotation == ROTATION_ANGLE_270) {
 		uint32_t temp_y = pos_cpy.y;
-		int viewport_height =
+		uint32_t viewport_height =
 			pipe_ctx->plane_res.scl_data.viewport.height;
 		int viewport_y =
 			pipe_ctx->plane_res.scl_data.viewport.y;
@@ -4121,7 +4122,7 @@ void dcn10_get_clock(struct dc *dc,
 void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits)
 {
 	struct resource_pool *pool = dc->res_pool;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct hubp *hubp = pool->hubps[i];
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index c2ea0106fdec..07c53a8e73b5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -79,7 +79,7 @@ void dcn20_log_color_state(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
-	int i;
+	unsigned int i;
 
 	DTN_INFO("DPP:  DGAM mode  SHAPER mode  3DLUT mode  3DLUT bit depth"
 		 "  3DLUT size  RGAM mode  GAMUT adjust  "
@@ -400,6 +400,7 @@ void dcn20_init_blank(
 	struct output_pixel_processor *bottom_opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
 	uint32_t otg_active_width = 0, otg_active_height = 0;
+	unsigned int num_opp_cap = (unsigned int)dc->res_pool->res_cap->num_opp;
 
 	/* program opp dpg blank color */
 	color_space = COLOR_SPACE_SRGB;
@@ -413,7 +414,7 @@ void dcn20_init_blank(
 	/* get the OPTC source */
 	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
 
-	if (opp_id_src0 >= dc->res_pool->res_cap->num_opp) {
+	if (opp_id_src0 >= num_opp_cap) {
 		ASSERT(false);
 		return;
 	}
@@ -426,7 +427,7 @@ void dcn20_init_blank(
 	if (num_opps == 2) {
 		otg_active_width = otg_active_width / 2;
 
-		if (opp_id_src1 >= dc->res_pool->res_cap->num_opp) {
+		if (opp_id_src1 >= num_opp_cap) {
 			ASSERT(false);
 			return;
 		}
@@ -1405,9 +1406,9 @@ void dcn20_pipe_control_lock(
 	}
 
 	if (flip_immediate && lock) {
-		const int TIMEOUT_FOR_FLIP_PENDING_US = 100000;
+		const unsigned int TIMEOUT_FOR_FLIP_PENDING_US = 100000U;
 		unsigned int polling_interval_us = 1;
-		int i;
+		unsigned int i;
 
 		temp_pipe = pipe;
 		while (temp_pipe) {
@@ -1870,7 +1871,7 @@ void dcn20_update_dchubp_dpp(
 static int dcn20_calculate_vready_offset_for_group(struct pipe_ctx *pipe)
 {
 	struct pipe_ctx *other_pipe;
-	int vready_offset = pipe->pipe_dlg_param.vready_offset;
+	unsigned int vready_offset = pipe->pipe_dlg_param.vready_offset;
 
 	/* Always use the largest vready_offset of all connected pipes */
 	for (other_pipe = pipe->bottom_pipe; other_pipe != NULL; other_pipe = other_pipe->bottom_pipe) {
@@ -2038,7 +2039,7 @@ void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2242,7 +2243,7 @@ void dcn20_post_unlock_program_front_end(
 	unsigned int timeout_us = 100000;
 	unsigned int polling_interval_us = 1;
 	struct dce_hwseq *hwseq = dc->hwseq;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (resource_is_pipe_type(&dc->current_state->res_ctx.pipe_ctx[i], OPP_HEAD) &&
@@ -2266,7 +2267,7 @@ void dcn20_post_unlock_program_front_end(
 		if (pipe->plane_state && !pipe->top_pipe && pipe->update_flags.bits.enable &&
 			dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
 			struct hubp *hubp = pipe->plane_res.hubp;
-			int j = 0;
+			unsigned int j = 0;
 
 			for (j = 0; j < timeout_us / polling_interval_us
 				&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
@@ -2285,7 +2286,7 @@ void dcn20_post_unlock_program_front_end(
 		if (resource_is_pipe_type(old_pipe, OTG_MASTER) && resource_is_pipe_type(pipe, OTG_MASTER) &&
 			resource_get_odm_slice_count(old_pipe) < resource_get_odm_slice_count(pipe) &&
 			dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
-			int j = 0;
+			unsigned int j = 0;
 			struct timing_generator *tg = pipe->stream_res.tg;
 
 			if (tg->funcs->get_optc_double_buffer_pending) {
@@ -2420,7 +2421,7 @@ void dcn20_optimize_bandwidth(
 		struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -2438,10 +2439,13 @@ void dcn20_optimize_bandwidth(
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					true);
 
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+	if (dc->clk_mgr->dc_mode_softmax_enabled) {
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if (dc->clk_mgr->clks.dramclk_khz > softmax_memclk_khz &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz <= softmax_memclk_khz)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+	}
 
 	/* increase compbuf size */
 	if (hubbub->funcs->program_compbuf_size)
@@ -2478,7 +2482,7 @@ bool dcn20_update_bandwidth(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	struct dce_hwseq *hws = dc->hwseq;
 
 	/* recalculate DML parameters */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 0988369bd968..476c2112afec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -287,7 +287,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 bool dcn21_is_abm_supported(struct dc *dc,
 		struct dc_state *context, struct dc_stream_state *stream)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 2705c58a9150..a2c8d4b21ac3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -79,7 +79,7 @@ void dcn30_log_color_state(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
 	bool is_gamut_remap_available = false;
-	int i;
+	unsigned int i;
 
 	DTN_INFO("DPP:  DGAM ROM  DGAM ROM type  DGAM LUT  SHAPER mode"
 		 "  3DLUT mode  3DLUT bit depth  3DLUT size  RGAM mode"
@@ -581,7 +581,7 @@ void dcn30_program_all_writeback_pipes_in_tree(
 	struct dc_writeback_info wb_info;
 	struct dwbc *dwb;
 	struct dc_stream_status *stream_status = NULL;
-	int i_wb, i_pipe, i_stream;
+	unsigned int i_wb, i_pipe, i_stream;
 	DC_LOG_DWB("%s", __func__);
 
 	ASSERT(stream);
@@ -645,7 +645,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i;
+	unsigned int i;
 	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
@@ -1197,10 +1197,13 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
 
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+	if (dc->clk_mgr->dc_mode_softmax_enabled) {
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if (dc->clk_mgr->clks.dramclk_khz <= softmax_memclk_khz &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > softmax_memclk_khz)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+	}
 
 	dcn20_prepare_bandwidth(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 5a90ff83b65c..71643ccf23d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -72,7 +72,7 @@
 static void enable_memory_low_power(struct dc *dc)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	int i;
+	unsigned int i;
 
 	if (dc->debug.enable_mem_low_power.bits.dmcu) {
 		// Force ERAM to shutdown if DMCU is not enabled
@@ -116,7 +116,7 @@ void dcn31_init_hw(struct dc *dc)
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
-	int i;
+	unsigned int i;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -671,7 +671,7 @@ void dcn31_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
 void dcn31_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params)
 {
-	unsigned int i;
+	int i;
 	unsigned int triggers = 0;
 
 	if (params->triggers.surface_update)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7dbaaf9403f2..fd42f0afc3a9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -226,7 +226,7 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
  */
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
-	int i;
+	unsigned int i;
 	uint32_t num_ways = 0;
 	uint32_t mall_ss_size_bytes = 0;
 
@@ -351,7 +351,7 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
  */
 void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	bool enable_subvp = false;
 
 	if (!dc->ctx || !dc->ctx->dmub_srv)
@@ -607,7 +607,7 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
  */
 void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 
 	/* Unforce p-state for each pipe if it is not FPO or SubVP.
 	 * For FPO and SubVP, if it's already forced disallow, leave
@@ -674,7 +674,7 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
  */
 void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	unsigned int num_ways = dcn32_calculate_cab_allocation(dc, context);
 	bool cache_cursor = false;
 
@@ -728,7 +728,7 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
  */
 void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	struct dce_hwseq *hws = dc->hwseq;
 
 	// Don't force p-state disallow -- can't block dummy p-state
@@ -793,7 +793,7 @@ void dcn32_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i;
+	unsigned int i;
 	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
@@ -1655,6 +1655,7 @@ void dcn32_init_blank(
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
 	uint32_t otg_active_width = 0, otg_active_height = 0;
 	uint32_t i;
+	unsigned int num_opp_cap = (unsigned int)dc->res_pool->res_cap->num_opp;
 
 	/* program opp dpg blank color */
 	color_space = COLOR_SPACE_SRGB;
@@ -1668,12 +1669,12 @@ void dcn32_init_blank(
 	/* get the OPTC source */
 	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
 
-	if (opp_id_src0 >= dc->res_pool->res_cap->num_opp) {
+	if (opp_id_src0 >= num_opp_cap) {
 		ASSERT(false);
 		return;
 	}
 
-	for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+	for (i = 0; i < num_opp_cap; i++) {
 		if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src0) {
 			opp = dc->res_pool->opps[i];
 			break;
@@ -1683,11 +1684,11 @@ void dcn32_init_blank(
 	if (num_opps == 2) {
 		otg_active_width = otg_active_width / 2;
 
-		if (opp_id_src1 >= dc->res_pool->res_cap->num_opp) {
+		if (opp_id_src1 >= num_opp_cap) {
 			ASSERT(false);
 			return;
 		}
-		for (i = 0; i < dc->res_pool->res_cap->num_opp; i++) {
+		for (i = 0; i < num_opp_cap; i++) {
 			if (dc->res_pool->opps[i] != NULL && dc->res_pool->opps[i]->inst == opp_id_src1) {
 				bottom_opp = dc->res_pool->opps[i];
 				break;
@@ -1751,7 +1752,7 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx)
 {
-	int i;
+	unsigned int i;
 	const struct pipe_ctx *cur_pipe, *new_pipe;
 	bool is_seamless = true;
 
@@ -1812,10 +1813,13 @@ void dcn32_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
 
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+	if (dc->clk_mgr->dc_mode_softmax_enabled) {
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if (dc->clk_mgr->clks.dramclk_khz <= softmax_memclk_khz &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > softmax_memclk_khz)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+	}
 
 	dcn20_prepare_bandwidth(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 71d6f7db93a4..a094c8b40a85 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -145,7 +145,7 @@ void dcn35_init_hw(struct dc *dc)
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
-	int i;
+	unsigned int i;
 
 	print_pg_status(dc, __func__, ": start");
 
@@ -930,14 +930,15 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
+	unsigned int ui = 0, uj = 0;
 	unsigned int edp_num = 0;
 	struct dc_link *edp_links[MAX_NUM_EDP] = { NULL };
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
-	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
-		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
-				dc->res_pool->hpo_dp_stream_enc[i]) {
+	for (ui = 0; ui < dc->res_pool->hpo_dp_stream_enc_count; ui++) {
+		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[ui] &&
+				dc->res_pool->hpo_dp_stream_enc[ui]) {
 			hpo_dp_stream_enc_acquired = true;
 			break;
 		}
@@ -948,11 +949,11 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 
 	update_state->pg_res_update[PG_DWB] = true;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+	for (ui = 0; ui < dc->res_pool->pipe_count; ui++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[ui];
 
 		for (j = 0; j < PG_HW_PIPE_RESOURCES_NUM_ELEMENT; j++)
-			update_state->pg_pipe_res_update[j][i] = true;
+			update_state->pg_pipe_res_update[j][ui] = true;
 
 		if (!pipe_ctx)
 			continue;
@@ -975,9 +976,9 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
 				if (!pipe_ctx->top_pipe && pipe_ctx->plane_res.hubp &&
 				    pipe_ctx->plane_res.hubp->inst != pipe_ctx->stream_res.dsc->inst) {
-					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
-						update_state->pg_pipe_res_update[PG_HUBP][j] = false;
-						update_state->pg_pipe_res_update[PG_DPP][j] = false;
+					for (uj = 0; uj < dc->res_pool->pipe_count; ++uj) {
+						update_state->pg_pipe_res_update[PG_HUBP][uj] = false;
+						update_state->pg_pipe_res_update[PG_DPP][uj] = false;
 					}
 				}
 			}
@@ -997,10 +998,10 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	}
 
 	/*domain24 controls all the otg, mpc, opp, as long as one otg is still up, avoid enabling OTG PG*/
-	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
-		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+	for (ui = 0; ui < dc->res_pool->timing_generator_count; ui++) {
+		struct timing_generator *tg = dc->res_pool->timing_generators[ui];
 		if (tg && tg->funcs->is_tg_enabled(tg)) {
-			update_state->pg_pipe_res_update[PG_OPTC][i] = false;
+			update_state->pg_pipe_res_update[PG_OPTC][ui] = false;
 			break;
 		}
 	}
@@ -1034,10 +1035,11 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
 	int i = 0, j = 0;
+	unsigned int ui = 0, uj = 0;
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < (int)dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *cur_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
 
@@ -1111,9 +1113,9 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		if (dc->links[i]->type != dc_connection_none)
 			update_state->pg_pipe_res_update[PG_PHYSYMCLK][dc->links[i]->link_enc_hw_inst] = true;
 
-	for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++) {
-		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i] &&
-				dc->res_pool->hpo_dp_stream_enc[i]) {
+	for (ui = 0; ui < dc->res_pool->hpo_dp_stream_enc_count; ui++) {
+		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[ui] &&
+				dc->res_pool->hpo_dp_stream_enc[ui]) {
 			hpo_dp_stream_enc_acquired = true;
 			break;
 		}
@@ -1126,8 +1128,8 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
 
 	if (dc->caps.sequential_ono) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+		for (ui = 0; ui < dc->res_pool->pipe_count; ui++) {
+			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[ui];
 
 			if (new_pipe->stream_res.dsc && !new_pipe->top_pipe &&
 			    update_state->pg_pipe_res_update[PG_DSC][new_pipe->stream_res.dsc->inst]) {
@@ -1137,9 +1139,9 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
 				if (new_pipe->plane_res.hubp &&
 				    new_pipe->plane_res.hubp->inst != new_pipe->stream_res.dsc->inst) {
-					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
-						update_state->pg_pipe_res_update[PG_HUBP][j] = true;
-						update_state->pg_pipe_res_update[PG_DPP][j] = true;
+					for (uj = 0; uj < dc->res_pool->pipe_count; ++uj) {
+						update_state->pg_pipe_res_update[PG_HUBP][uj] = true;
+						update_state->pg_pipe_res_update[PG_DPP][uj] = true;
 					}
 				}
 			}
@@ -1186,6 +1188,7 @@ void dcn35_hw_block_power_down(struct dc *dc,
 	struct pg_block_update *update_state)
 {
 	int i = 0;
+	unsigned int pipe_idx = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl)
@@ -1199,11 +1202,11 @@ void dcn35_hw_block_power_down(struct dc *dc,
 	}
 
 	if (!dc->caps.sequential_ono) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
-			    update_state->pg_pipe_res_update[PG_DPP][i]) {
+		for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+			if (update_state->pg_pipe_res_update[PG_HUBP][pipe_idx] &&
+			    update_state->pg_pipe_res_update[PG_DPP][pipe_idx]) {
 				if (pg_cntl->funcs->hubp_dpp_pg_control)
-					pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
+					pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, pipe_idx, false);
 			}
 		}
 
@@ -1262,7 +1265,7 @@ void dcn35_hw_block_power_down(struct dc *dc,
 void dcn35_hw_block_power_up(struct dc *dc,
 	struct pg_block_update *update_state)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl)
@@ -1275,7 +1278,7 @@ void dcn35_hw_block_power_up(struct dc *dc,
 		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, true);
 
 	if (!dc->caps.sequential_ono) {
-		for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
+		for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++)
 			if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 				if (pg_cntl->funcs->dsc_pg_control)
 					pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
@@ -1304,7 +1307,7 @@ void dcn35_hw_block_power_up(struct dc *dc,
 void dcn35_root_clock_control(struct dc *dc,
 	struct pg_block_update *update_state, bool power_on)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl)
@@ -1328,7 +1331,7 @@ void dcn35_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
 	}
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (power_on) {
 				if (dc->res_pool->dccg->funcs->enable_dsc)
@@ -1449,7 +1452,7 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params)
 {
-	unsigned int i;
+	int i;
 	unsigned int triggers = 0;
 
 	if (params->triggers.surface_update)
@@ -1569,7 +1572,8 @@ bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
  */
 static void dcn35_calc_blocks_to_ungate_for_hw_release(struct dc *dc, struct pg_block_update *update_state)
 {
-	int i = 0, j = 0;
+	unsigned int i = 0;
+	int j = 0;
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
index 93fe5b262a3d..8720e47fb33a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
@@ -152,7 +152,7 @@ void dcn351_hw_block_power_down(struct dc *dc,
 void dcn351_hw_block_power_up(struct dc *dc,
 	struct pg_block_update *update_state)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl || dc->debug.ignore_pg)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0133950ab396..55a672b4e886 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -143,7 +143,7 @@ void dcn401_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i;
+	unsigned int i;
 	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
@@ -1281,7 +1281,7 @@ static bool dcn401_check_no_memory_request_for_cab(struct dc *dc)
 
 static uint32_t dcn401_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
-	int i;
+	unsigned int i;
 	uint32_t num_ways = 0;
 	uint32_t mall_ss_size_bytes = 0;
 
@@ -1423,10 +1423,13 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
 
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+	if (dc->clk_mgr->dc_mode_softmax_enabled) {
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if (dc->clk_mgr->clks.dramclk_khz <= softmax_memclk_khz &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > softmax_memclk_khz)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+	}
 
 	/* Increase clocks */
 	dc->clk_mgr->funcs->update_clocks(
@@ -1472,7 +1475,7 @@ void dcn401_optimize_bandwidth(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
 	/* enable fams2 if needed */
@@ -1492,10 +1495,13 @@ void dcn401_optimize_bandwidth(
 		hubbub->funcs->program_arbiter(hubbub, &context->bw_ctx.bw.dcn.arb_regs, true);
 	}
 
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+	if (dc->clk_mgr->dc_mode_softmax_enabled) {
+		int softmax_memclk_khz = dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000;
+
+		if (dc->clk_mgr->clks.dramclk_khz > softmax_memclk_khz &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz <= softmax_memclk_khz)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
+	}
 
 	/* increase compbuf size */
 	if (hubbub->funcs->program_compbuf_segments)
@@ -2466,7 +2472,7 @@ void dcn401_program_front_end_for_ctx(
 	struct dc *dc,
 	struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	unsigned int prev_hubp_count = 0;
 	unsigned int hubp_count = 0;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2633,7 +2639,7 @@ void dcn401_post_unlock_program_front_end(
 	unsigned int timeout_us = 100000;
 	unsigned int polling_interval_us = 1;
 	struct dce_hwseq *hwseq = dc->hwseq;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (resource_is_pipe_type(&dc->current_state->res_ctx.pipe_ctx[i], OPP_HEAD) &&
@@ -2657,7 +2663,7 @@ void dcn401_post_unlock_program_front_end(
 		if (pipe->plane_state && !pipe->top_pipe && pipe->update_flags.bits.enable &&
 			dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
 			struct hubp *hubp = pipe->plane_res.hubp;
-			int j = 0;
+			unsigned int j = 0;
 
 			for (j = 0; j < timeout_us / polling_interval_us
 				&& hubp->funcs->hubp_is_flip_pending(hubp); j++)
@@ -2676,7 +2682,7 @@ void dcn401_post_unlock_program_front_end(
 		if (resource_is_pipe_type(old_pipe, OTG_MASTER) && resource_is_pipe_type(pipe, OTG_MASTER) &&
 			resource_get_odm_slice_count(old_pipe) < resource_get_odm_slice_count(pipe) &&
 			dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM) {
-			int j = 0;
+			unsigned int j = 0;
 			struct timing_generator *tg = pipe->stream_res.tg;
 
 			if (tg->funcs->get_optc_double_buffer_pending) {
@@ -2761,7 +2767,7 @@ bool dcn401_update_bandwidth(
 	struct dc *dc,
 	struct dc_state *context)
 {
-	int i;
+	unsigned int i;
 	struct dce_hwseq *hws = dc->hwseq;
 
 	/* recalculate DML parameters */
@@ -3262,9 +3268,10 @@ void dcn401_program_all_writeback_pipes_in_tree_sequence(
 		struct block_sequence_state *seq_state)
 {
 	struct dwbc *dwb;
-	int i_wb, i_pipe;
+	unsigned int i_wb, i_pipe;
+	unsigned int num_dwb_cap = (unsigned int)dc->res_pool->res_cap->num_dwb;
 
-	if (!stream || stream->num_wb_info > dc->res_pool->res_cap->num_dwb)
+	if (!stream || (unsigned int)stream->num_wb_info > num_dwb_cap)
 		return;
 
 	/* For each writeback pipe */
@@ -3912,7 +3919,7 @@ void dcn401_update_mpcc_sequence(struct dc *dc,
 
 static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < res_pool->pipe_count; i++) {
 		if (res_pool->hubps[i]->inst == mpcc_inst)
@@ -3987,7 +3994,7 @@ void dcn401_set_hdr_multiplier_sequence(struct pipe_ctx *pipe_ctx,
 void dcn401_program_mall_pipe_config_sequence(struct dc *dc, struct dc_state *context,
 		struct block_sequence_state *seq_state)
 {
-	int i;
+	unsigned int i;
 	unsigned int num_ways = dcn401_calculate_cab_allocation(dc, context);
 	bool cache_cursor = false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index 53ff5a02af02..af1c574eca7b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -65,7 +65,7 @@ void dcn42_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i;
+	unsigned int i;
 	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
@@ -967,7 +967,8 @@ void dcn42_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 {
 	bool hpo_frl_stream_enc_acquired = false;
 	bool hpo_dp_stream_enc_acquired = false;
-	int i = 0, j = 0;
+	unsigned int i = 0;
+	int j = 0;
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
@@ -1090,7 +1091,8 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state)
 {
 	bool hpo_dp_stream_enc_acquired = false;
-	int i = 0, j = 0;
+	unsigned int i = 0;
+	int j = 0;
 
 	memset(update_state, 0, sizeof(struct pg_block_update));
 
@@ -1222,6 +1224,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state)
 {
 	int i = 0;
+	int pipe_count = dc->res_pool->pipe_count;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 	bool block_disabled = true;
 
@@ -1235,7 +1238,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 			pg_cntl->funcs->hpo_pg_control(pg_cntl, false);
 	}
 
-	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+	for (i = pipe_count - 1; i >= 0; i--) {
 		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 			update_state->pg_pipe_res_update[PG_DPP][i]) {
 			if (pg_cntl->funcs->hubp_dpp_pg_control)
@@ -1255,7 +1258,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+	for (i = 0; i < pipe_count; i++) {
 		if (!update_state->pg_pipe_res_update[PG_MPCC][i] ||
 			!update_state->pg_pipe_res_update[PG_OPP][i] ||
 			!update_state->pg_pipe_res_update[PG_OPTC][i]) {
@@ -1310,7 +1313,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 void dcn42_hw_block_power_up(struct dc *dc,
 	struct pg_block_update *update_state)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 	bool block_enabled = false;
 
@@ -1344,7 +1347,7 @@ void dcn42_hw_block_power_up(struct dc *dc,
 			pg_cntl->funcs->plane_otg_pg_control(pg_cntl, true);
 	}
 
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (pg_cntl->funcs->dsc_pg_control)
 				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
@@ -1371,7 +1374,7 @@ void dcn42_hw_block_power_up(struct dc *dc,
 void dcn42_root_clock_control(struct dc *dc,
 	struct pg_block_update *update_state, bool power_on)
 {
-	int i = 0;
+	unsigned int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl)
@@ -1395,7 +1398,7 @@ void dcn42_root_clock_control(struct dc *dc,
 					dc->hwseq->funcs.physymclk_root_clock_control(dc->hwseq, i, power_on);
 
 	}
-	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < (unsigned int)dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (power_on) {
 				if (dc->res_pool->dccg->funcs->enable_dsc)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 7924fe4ab3a5..026c55ca0196 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -524,7 +524,7 @@ static void read_current_link_settings_on_detect(struct dc_link *link)
 	uint8_t link_rate_set = 0;
 	uint32_t read_dpcd_retry_cnt = 10;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
-	int i;
+	unsigned int i;
 	union max_down_spread max_down_spread = {0};
 
 	// Read DPCD 00101h to find out the number of lanes currently set
@@ -655,7 +655,7 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 	unsigned long long enter_timestamp;
 	unsigned long long finish_timestamp;
 	unsigned long long time_taken_in_ns;
-	int tries_taken;
+	unsigned int tries_taken;
 
 	/**
 	 * this function will only exist if we are on dcn21 (is_in_alt_mode is a
@@ -1619,7 +1619,7 @@ struct dc_sink *link_add_remote_sink(
 
 void link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 {
-	int i;
+	unsigned int i;
 
 	if (!link->sink_count) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 72fbcd31e32a..d52155e86f0f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2109,7 +2109,7 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 		int sink_index = 0;
-		int i = 0;
+		unsigned int i = 0;
 
 		for (i = 0; i < link->sink_count; i++) {
 			if (link->remote_sinks[i] == NULL)
@@ -2130,7 +2130,7 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 	link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, req_bw);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		int i = 0;
+		unsigned int i = 0;
 
 		for (i = 0; i < link->sink_count; i++) {
 			if (link->remote_sinks[i] == NULL)
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 765b731a12a4..5d28f91a7af7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -381,7 +381,7 @@ static bool encoder_is_external_dp(
 
 static void link_destruct(struct dc_link *link)
 {
-	int i;
+	unsigned int i;
 
 	if (link->ddc)
 		link_destroy_ddc_service(&link->ddc);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index eb791285ed06..ec083e8b75b4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -302,9 +302,11 @@ static bool dp_validate_mode_timing(
 
 	req_bw = dc_bandwidth_in_kbps_from_timing(timing, dc_link_get_highest_encoding_format(link));
 	max_bw = dp_link_bandwidth_kbps(link, link_setting);
+	uint32_t max_uncompressed_pixel_rate_100hz =
+		link->dpcd_caps.max_uncompressed_pixel_rate_cap.bits.max_uncompressed_pixel_rate_cap * 10000U;
 
 	bool is_max_uncompressed_pixel_rate_exceeded = link->dpcd_caps.max_uncompressed_pixel_rate_cap.bits.valid &&
-			timing->pix_clk_100hz > link->dpcd_caps.max_uncompressed_pixel_rate_cap.bits.max_uncompressed_pixel_rate_cap * 10000;
+			timing->pix_clk_100hz > max_uncompressed_pixel_rate_100hz;
 
 	if (is_max_uncompressed_pixel_rate_exceeded && !timing->flags.DSC) {
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 01b3d56cdc89..817b4010edcb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1353,7 +1353,7 @@ bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 	union down_stream_port_count down_strm_port_count;
 	union edp_configuration_cap edp_config_cap;
 
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < read_dpcd_retry_cnt; i++) {
 		status = core_link_read_dpcd(
@@ -1752,7 +1752,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union dp_downstream_port_present ds_port = { 0 };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 20;
-	int i;
+	unsigned int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
 	bool is_fec_supported = false;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index d79c18c4903a..dd854d992692 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -197,7 +197,7 @@ static void link_dpia_send_bw_alloc_request(struct dc_link *link, int req_bw)
 
 	request_bw = request_reg_val * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
-	if (request_bw > link->dpia_bw_alloc_config.estimated_bw) {
+	if (request_bw > (uint32_t)link->dpia_bw_alloc_config.estimated_bw) {
 		DC_LOG_ERROR("%s:  Link[%d]:  Request BW (%d --> %d) > Estimated BW (%d)... Set to Estimated BW!",
 				__func__, link->link_index,
 				req_bw, request_bw, link->dpia_bw_alloc_config.estimated_bw);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index dd19b912c48c..f9e0ba24d401 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -65,7 +65,7 @@ bool dp_parse_link_loss_status(
 	/*1. Check that Link Status changed, before re-training.*/
 
 	/*parse lane status*/
-	for (lane = 0; lane < link->cur_link_settings.lane_count; lane++) {
+	for (lane = 0; lane < (uint32_t)link->cur_link_settings.lane_count; lane++) {
 		/* check status of lanes 0,1
 		 * changed DpcdAddress_Lane01Status (0x202)
 		 */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index ddff0db4ce70..605bf19dc4f2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -310,7 +310,7 @@ static void maximize_lane_settings(const struct link_training_settings *lt_setti
 	max_requested.FFE_PRESET = lane_settings[0].FFE_PRESET;
 
 	/* Determine what the maximum of the requested settings are*/
-	for (lane = 1; lane < lt_settings->link_settings.lane_count; lane++) {
+	for (lane = 1; lane < (uint32_t)lt_settings->link_settings.lane_count; lane++) {
 		if (lane_settings[lane].VOLTAGE_SWING > max_requested.VOLTAGE_SWING)
 			max_requested.VOLTAGE_SWING = lane_settings[lane].VOLTAGE_SWING;
 
@@ -568,7 +568,7 @@ enum link_training_result dp_check_link_loss_status(
 			sizeof(dpcd_buf));
 
 	/*parse lane status*/
-	for (lane = 0; lane < link->cur_link_settings.lane_count; lane++) {
+	for (lane = 0; lane < (uint32_t)link->cur_link_settings.lane_count; lane++) {
 		/*
 		 * check lanes status
 		 */
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
index 27e653234850..0779db249765 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
@@ -422,7 +422,7 @@ void mpc1_init_mpcc_list_from_hw(
 
 				if (out_mux == mpcc_id)
 					tree->opp_list = mpcc;
-				if (bot_sel != 0xf && bot_sel < mpc10->num_mpcc) {
+				if (bot_sel != 0xf && bot_sel < (unsigned int)mpc10->num_mpcc) {
 					bot_mpcc_id = bot_sel;
 					REG_GET(MPCC_OPP_ID[bot_mpcc_id],  MPCC_OPP_ID,  &opp_id);
 					REG_GET(MPCC_TOP_SEL[bot_mpcc_id], MPCC_TOP_SEL, &top_sel);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 9e66b9b97c63..e6426ccee2d8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -375,7 +375,7 @@ void optc1_set_vtg_params(struct timing_generator *optc,
 	if (REG(OTG_INTERLACE_CONTROL)) {
 		if (patched_crtc_timing.flags.INTERLACE == 1) {
 			v_init = v_init / 2;
-			if ((optc1->vstartup_start/2)*2 > asic_blank_end)
+			if ((uint32_t)((optc1->vstartup_start/2)*2) > asic_blank_end)
 				v_fp2 = v_fp2 / 2;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
index 72bd43f9bbe2..dd3510ceee95 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
@@ -380,7 +380,7 @@ void pg_cntl35_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
-	int i;
+	unsigned int i;
 	bool block_enabled;
 	bool all_mpcc_disabled = true, all_opp_disabled = true;
 	bool all_optc_disabled = true, all_stream_disabled = true;
@@ -460,7 +460,7 @@ static bool pg_cntl35_mem_status(struct pg_cntl *pg_cntl)
 
 void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl)
 {
-	int i = 0;
+	unsigned int i = 0;
 	bool block_enabled;
 
 	pg_cntl->pg_res_enable[PG_HPO] = pg_cntl35_hpo_pg_status(pg_cntl);
@@ -494,7 +494,7 @@ void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl)
 
 static void pg_cntl35_print_pg_status(struct pg_cntl *pg_cntl, const char *debug_func, const char *debug_log)
 {
-	int i = 0;
+	unsigned int i = 0;
 	bool block_enabled = false;
 
 	DC_LOG_DEBUG("%s: %s", debug_func, debug_log);
diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 96290538a889..4a096fa3fc10 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -503,7 +503,7 @@ void pg_cntl42_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	uint32_t power_gate = power_on ? 0 : 1;
 	uint32_t pwr_status = power_on ? 0 : 2;
 	uint32_t org_ip_request_cntl;
-	int i;
+	unsigned int i;
 	bool block_enabled;
 	bool all_mpcc_disabled = true, all_opp_disabled = true;
 	bool all_optc_disabled = true, all_stream_disabled = true;
@@ -564,7 +564,7 @@ void pg_cntl42_plane_otg_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 
 void pg_cntl42_init_pg_status(struct pg_cntl *pg_cntl)
 {
-	int i = 0;
+	unsigned int i = 0;
 	bool block_enabled;
 
 	pg_cntl->pg_res_enable[PG_HPO] = pg_cntl42_hpo_pg_status(pg_cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index 16160f35da1b..e0802359829e 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -50,15 +50,15 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 		dml_clk_table->fclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
 		dml_clk_table->dcfclk.num_clk_values = (uint8_t)dc_clk_table->num_entries_per_clk.num_dcfclk_levels;
 		for (i = 0; i < min(DML_MAX_CLK_TABLE_SIZE, MAX_NUM_DPM_LVL); i++) {
-			if (i < dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
+			if (i < (int)dc_clk_table->num_entries_per_clk.num_dcfclk_levels) {
 				int j, max_fclk = 0;
 
 				dml_clk_table->dcfclk.clk_values_khz[i] = dc_clk_table->entries[i].dcfclk_mhz * 1000;
 				for (j = 0; j < MAX_NUM_DPM_LVL; j++) {
-					if (dc_clk_table->entries[j].fclk_mhz * 1000 > max_fclk)
+					if ((uint32_t)(dc_clk_table->entries[j].fclk_mhz * 1000) > (uint32_t)max_fclk)
 						max_fclk = dc_clk_table->entries[j].fclk_mhz * 1000;
 					dml_clk_table->fclk.clk_values_khz[i] = max_fclk;
-					if (max_fclk >= 2 * dml_clk_table->dcfclk.clk_values_khz[i])
+						if ((uint32_t)max_fclk >= 2 * dml_clk_table->dcfclk.clk_values_khz[i])
 						break;
 				}
 			} else {
-- 
2.43.0

