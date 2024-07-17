Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBF6C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376F810E35D;
	Wed, 17 Jul 2024 19:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BADj8ad";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F9410E35D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AErvTyhutL3uPQM0GmD55H7ywCacG86a8OZur/pRCmlochpLKmgXYhbdyy014/8ljAzMCkDjyw1Yg1Q/KcGyv6Uq34vd2KZcOgTgyF+z988cUQIq9sRTqViJLeZG9+2UxjSMfKrdScuj0BeCGBnGf17iQilCmEjUoYhPLFbZBK5fDTWXq+WJP5t4R7A+jbx/TlXbPlASx8vilaJmfRlVosqDhtln8iGTd6ymmm5zxj/Dj84YhH6J57Gylp4Ao3EvjGu9nN2si6iTvQ1eGRSZmoqu82Pr4CEQjcttLyhHrw0v2t5s4bpsHALA6XvuIneIgvVPX9+dIAzSIOm7sddP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxpbXaU1Khp1eeBzqWeQ7btn9dZHaT6JLqHYkBzmqnM=;
 b=m6ptI/2D3AecHtKQVmkWDiXGIWZZ73wWUbsNAX89X31czvmyYdTqk184Z1K9b4yo4NPUiNVEs2SkWD6uNp9Giv9jhrLa461R7ri80MIMoQD5mwH9u2fKEIMPFr89UtJVrOvgxlhS1MzILkGbTfKnqu0ehaA1jd5w0VouKjenoiTBnb+tTm3NBki6i0CVp+p40d0ohEf6zXqHDZExBpumajnz8owb8EyTcdfcAhWuw7m5ehfSTHoP4mVaYvubR+BjXjuYx1QE1t754ORo/bQnhizfqWSNxXz3IyizKUISV2oyW5WzcM3kFpXjAgiCDndBgh03oJsnJIMtdUVnyUDK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxpbXaU1Khp1eeBzqWeQ7btn9dZHaT6JLqHYkBzmqnM=;
 b=2BADj8adZAB+pfpci/yPqLnqB7TEAB+CpMOo6s8/szRyYf34DMLLgkdKDWd+WQCgN0YNEJMIKfrQVMT2nRXEyh6BxPBKs88aW4+oxCFtKqpdHjpe8HzVLDZ/6caAwPMAr9PCebrqPeqs5ZIiDRn6ct82BnJfVmjiU2PYBYNmN0U=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:39:08 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::16) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:07 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches for 15 July, 2024
Date: Wed, 17 Jul 2024 19:38:39 +0000
Message-ID: <20240717193901.8821-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9753eabf-b8ed-443b-5b7f-08dca6982014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbLGaUmfx92zY1s307sJVRFzbBPyTJfN6RnAqw1NFLPqoHxwgWwrnmbDDkDj?=
 =?us-ascii?Q?WXewsRhpQktvWlIBQpgURxbrm2/3ebA6Yh4qLWkxasvdB+ikRlqJHZd3WBY8?=
 =?us-ascii?Q?e7sxTdddWMsYPOLlUJwYlc9YKG2u7iRfqRiEsRMPS5DxgiVSBgZn6WSVV67J?=
 =?us-ascii?Q?Ok0D+dv2+0/K6ooh6aYqORNdKSpBko/Z0FcMHKAP5sfqA3FeuabuLo6jCHpw?=
 =?us-ascii?Q?vjpniWPlx6xTzynzQUc1xH44J10p9J9h7/LcTVjXzgCZtWHsobfx796winbH?=
 =?us-ascii?Q?yD3sZKtbV091ewNzvkSDwB1TFlyK0OQlV7hi+ptijawVxo+5eOGqSWJUbuXb?=
 =?us-ascii?Q?cgeG4jqjDTNbYH1boeMz96EC3AlY7LZsU3/D/vxmCw3VCoD6YytlY017FCZd?=
 =?us-ascii?Q?lI8vrHoYbRI7f9WVz1IWTd6QzTylvwDxOWsjo7jwTvE3D8TRTH66lCH6heKu?=
 =?us-ascii?Q?1P36NLhav7Reetn3J2anPuSXYiARnDBLAzhU+l3CGxj7zk7cfUKWbFGWuKSW?=
 =?us-ascii?Q?hD6rsOD32wMCkFygxYLX99Z3k0Jcoa7lfbmgl7PBqwDOh7RF20JklN/oMSK4?=
 =?us-ascii?Q?DbWC64/OtC96lQgHzCgg5m9Y8GhqHSWaQThgyteS2oRyA3B23WVZRPSmzVRn?=
 =?us-ascii?Q?IwVialgiAWke197idOzwyOYTmtIOs0hPKvuP9WNysjYEB9UqY8bmjaQQ0ipw?=
 =?us-ascii?Q?GTdZv1qQzMX5kypnq+IlcNKSsoADgDrymQa+xrOPiyrQwxJEC6u4dlFhdAE2?=
 =?us-ascii?Q?DglaVOQ6OYWy8csGsC3d2iAhNKp2N8u02bAqMK8WY/JgdSJ2paeYZ6XwGkMS?=
 =?us-ascii?Q?rK/VRaNelRSX/NTD2RPZJC1TpjJqjrkKiNJ36GO1OESSbI4KDbizRzelmVWa?=
 =?us-ascii?Q?7m8wyz3WZ44hnVPBcrniUqyUOQbNP+ouVIM9veKCyxeIgGr3x7GDNIwUro60?=
 =?us-ascii?Q?ND6F1NnNpmIBcTousmp54jhmiiro20k4gQdbNZooj3R1cQu7s3FqrJgMeoAH?=
 =?us-ascii?Q?zU7qrKP2e0YF+lsOxqgbORjdPmbIhSOA+lMdjSbwaUaYkjaYvWc47i9tx2E4?=
 =?us-ascii?Q?g9A2R85jSB6423SPtJqIoiJyWUqcJB5BKYOL7IpEMtBIo2WbCyRjnCBdxy59?=
 =?us-ascii?Q?bi/CkmafAzZY5J4QS1qUW9M8tEkhVKaF1JIvmXDoNYoAjod+hWBOmXmIPJC9?=
 =?us-ascii?Q?qw2XcMWEu6Z5e2LBRsvMr7ee2X3Tey93zfz6+KTeTNnJzjBJF4wGnPiGor+7?=
 =?us-ascii?Q?k1gV9UH/sEB/sdxwBfVeiSUa3MV52dyGRoitvr5daVjfWgeGRMtoaw8UpPWG?=
 =?us-ascii?Q?inBlrON/dn5oOkPR7xApWDbGMjBqOo20piiy4cpFmMYZbCVBv6R3fFlIaNd0?=
 =?us-ascii?Q?zxhM6CWo5x3Vz9NmYTb4LhZaU6Czoi3sp7UF+50petwOW4uh9DORzSOB94e3?=
 =?us-ascii?Q?Eb3dT/PrTK4b+i5NV37Rv9PRRINvPnoA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:08.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9753eabf-b8ed-443b-5b7f-08dca6982014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* bug fixes for SubVP, DML, SPL, DCCG, and various stability fixes
* more reorganization of code into corresponding sub components
* renaming certain variables in DML to better reflect their relevance.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Add MST debug message when link detection fails
  drm/amd/display: Check link_res->hpo_dp_link_enc before using it

Aric Cyr (1):
  drm/amd/display: 3.2.293

Aurabindo Pillai (3):
  drm/amd/display: rename dcn3/dcn4 to more sound terms
  drm/amd/display: rename dcn401_soc to dcn4_variant_a_soc
  drm/amd/display: remove unused folder

Austin Zheng (1):
  drm/amd/display: Check if Mode is Supported Before Returning Result

Dillon Varone (2):
  drm/amd/display: Remove hardmax usage for dcn401
  drm/amd/display: Various DML2 fixes for FAMS2

Gabe Teeger (1):
  drm/amd/display: Fix Potential Null Dereference

Hansen Dsouza (3):
  drm/amd/display: Add private data type for RCG
  drm/amd/display: Add RCG helper functions
  drm/amd/display: Add source select helper functions

Ilya Bakoulin (1):
  drm/amd/display: Add helper function to check for non-address fast
    updates

Joshua Aberback (1):
  drm/amd/display: Remove duplicate HWSS interfaces

Revalla Hari Krishna (1):
  drm/amd/display: Refactoring HPO

Rodrigo Siqueira (2):
  drm/amd/display: Remove ASSERT if significance is zero in math_ceil2
  drm/amd/display: Remove old comments

Ryan Seto (1):
  drm/amd/display: Fix visual confirm bug for SubVP

Samson Tam (1):
  drm/amd/display: ensure EASF and ISHARP coefficients are programmed
    together

Sung Joon Kim (2):
  drm/amd/display: Check for NULL pointer
  drm/amd/display: Check top sink only when multiple streams for DP2

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  44 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  36 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 712 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   2 -
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |  13 -
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn401/Makefile    |  10 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  51 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  24 +-
 .../dml21/inc/bounding_boxes/dcn3_soc_bb.h    |   8 +-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |  10 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |  10 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  10 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 186 ++---
 .../dml21/src/dml2_core/dml2_core_shared.c    | 192 ++---
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c | 130 ++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   2 +-
 .../lib_float_math.c                          |   2 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   3 +-
 .../amd/display/dc/dml2/dml2_internal_types.h |   1 +
 .../display/dc/dml2/dml2_translation_helper.c |  41 +-
 .../display/dc/dml2/dml2_translation_helper.h |   2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  28 +-
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |  15 +
 .../dcn31/dcn31_hpo_dp_link_encoder.c         |   0
 .../dcn31/dcn31_hpo_dp_link_encoder.h         |   0
 .../dcn31/dcn31_hpo_dp_stream_encoder.c       |   0
 .../dcn31/dcn31_hpo_dp_stream_encoder.h       |   0
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 364 ++++-----
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   1 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   2 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 -
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   1 -
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 -
 .../display/dc/hwss/hw_sequencer_private.h    |   2 -
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   5 +
 62 files changed, 1401 insertions(+), 615 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn303/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn401/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.h (100%)

-- 
2.39.2

