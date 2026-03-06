Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA8DF513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6B210E0A9;
	Fri,  6 Mar 2026 03:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wW3FFEoW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204B410E0A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/x0s4FqgurnK2PZ6vV0DBpCPzO0LP5OCZbx4Z1B7dbeQtpbiMClKIN6xASh5LcdWRHRhFvjdSE1Htl237NtGmGlQdqUiClkqXXEBegL3oZd0n9V5iYsiP/pVZi+j6mS0SR/uYhhGDSGeHx7o9SQqNETCxRLuq+A+6kteBrSN+9NgzXTlTfpQixkCSQu8D2WvR+nf5AWAV6ncmLeAkQJ+d8+D81PBdvDt/BUpRFF+y0gkg06xsqnBIjY9lkw5ErssganVystbqQ6MRnivEXQYjQ6KtVkHQdSezvPFa/XbDZZT2TcLd9LK2PJeaEsFDf8MEYQqML5PtW/JyYgfAOUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwiJeeNYoIy6R6ToNKueWIJPweLUeWDCQ4tk6cP/rbg=;
 b=ZgEbwXJlbgM+qUlYJCsOOw72185xHwhv5LUDvlqR4efpC5LkCaCI9yS9VWdCOPjQnkxDy8BMTP4lZ942NxSZF/4z6gVE65vty1NpHkNVFl2McuZJBu9tepIsu9m0bLsk+q4mBHs4TakYVMFCtF0qbl6UrgwEHJR+S9fHev4KBR9pyEPwPNwO09IRRVl+56vQ6pZ1/lsNlm/lyInRq+Y5q3cXxEM4mmv/axALK2ABtLRQdnqc01/IPDNoHdaZIh96dcIiIbmJMcovIynfFDvuKuy64nZ1P30M0yL1/pkmL3C0fbZf4cqpuo/KMJCt8/TTwbJ385Nz50LmELpRaItp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwiJeeNYoIy6R6ToNKueWIJPweLUeWDCQ4tk6cP/rbg=;
 b=wW3FFEoWjmJNesVkp/dudyQjDDXdJZ1rxrxFnLoyuP0FHr8psgcjFdDKCN6W+Q2Lp3YwCOFuc3q1oodGsIOlx/2zd3yKbYNop2BkxBQ0cFaEFntXeqEomfYsExuuQ++hhx9lNs55FZ3VO8Ap4xq1nurahOZFnrL8pW/AHIHTuT4=
Received: from BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 03:23:48 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::41) by BYAPR04CA0016.outlook.office365.com
 (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:23:47 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:23:45 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/21] DC Patches March 05, 2026
Date: Thu, 5 Mar 2026 20:13:26 -0700
Message-ID: <20260306031932.136179-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: a39d910d-7a4b-4525-626d-08de7b2fc773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: bTOGV+Onds2QGc/9N/YgKedvc02NSx+H8bcCo68xZQlOMLk1CW1Y/W8DSm9MTWKEh+Qtqe5xts18tS+tDgNCmxZ1FS9CwhL7iXW+yjtN9vweh2H7GhaSJ42VX51qOhDcm+wurvbF0paOWpRkJK07ko44fe//tWmKOLqm7XXdOmPNTyE0H+4TuFTHiF4rhMCALc7p0pnI/ayVrHxGDv7monZB7wCBWxc+Vz5Bi6/u0qbMfBtYN51k6tCgQIQFKpvzwoK3tCoBx211g8GEOZTdm6quuId/0PbpxyQPetOib+FR7hBBMhCigGTl+ZocjKg1NADlRhTs7MQrKUV7chmFNCEVVe9oaJATks9a6nSVAU6LyQDvAd+7nYcpX0IUJ5GanCyDfEMQ2zwSEwVm9zNsUE7aCleQ4ZvXxtoGYeyn0Vv9xp4bxf3j6g0rMR3X7M1fQeC+sSI3DCWJlm7wJ01sHpH/mUykWzpFVGOtXp0wqULWm4sC3bfVX8MozaTI7zpnf3APAdxuSEZz6KzkzGoJ+4fdV37A0tCQx/KHD9wNgLERy8NKtxm3qFRjp0LpgyISDh3MhO8Hsz/Z2I8OdC9ZGs9945vqqiiskERgj2kWwsyONYBpHG50WWHAnnzm/KQq7dUmWDMOogXGxUD51i90akBNXD7TeW0KAInrreILYcLFtbrJ4cfoOvPoRB3sNC0NgIUdC5WJIIn3WDpYn1OWp0wxYkCgxGG35LG6p7qpB1I96v2i1f29CW8SVc6+xtUxDKYMf2V0wbVNCg9SdymMQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BtwtMmj5QhpDaP+jUL3B5+OgH0RmpIsTUUzmnKs4CxTj8rJV8V+a/yz0isfekQGaHs1rgn6jATAQmA/8kKF94Q1Y4bMLaFejOMgAcrVMsXk+wuUzBdb0PPUTCsFGNj6iX9jeXepO2hkIfH98k/esMglHCkH+CsEki5PuhCXSDGfOVShVp8LXFSj1tvo4NsdRBtwHsCHgl4TnUYEXZdm9XqIawGwN340Q3wANP/oe8x+vHhiHOSv5APYnrd4e3x8z/wmrPDxC1OZjK0ETG92ORtrd460aCgiuMqEj0/Itco8i78GRXOWDDDg4ly3qv2Ll3uy1OGctaoFGUtvyFR2RRt8S6L0l+WEYR09HzE68331G9HZScyvh3o6vRUGytFe4wEyzmC04P2Ch986/shg2VuGfL3wWtYh081aWFmQYlYudl2pRTLydOXXsJp30GeHL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:23:47.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39d910d-7a4b-4525-626d-08de7b2fc773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
* Fixes on compiler warnings
* Introduction of NV12/P010 formats to color pipeline
* Improvements on reply and DML2
* Enablment on DCN42

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: Update underflow detection

ChunTao Tso (1):
  drm/amd/display: Add new types to replay config

Clay King (1):
  drm/amd/display: Clean up unused code

Gaghik Khachatrian (2):
  drm/amd/display: Clean up NULL pointer warnings in dml2
  drm/amd/display: Fix compile warnings in dml2_0

Harry Wentland (3):
  drm/amd/display: Set chroma taps to 1 if luma taps are 1
  drm/amd/display: Add NV12/P010 formats to primary plane
  drm/amd/display: Add COLOR_ENCODING/COLOR_RANGE to overlay planes

Ivan Lipski (2):
  drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
  drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21

Nicholas Kazlauskas (2):
  drm/amd/display: Fix HWSS v3 fast path determination
  drm/amd/display: Add documentation and cleanup DMUB HW lock manager

Ovidiu Bunea (1):
  drm/amd/display: Add min clock init for DML21 mode programming

Peichen Huang (1):
  drm/amd/display: Return early from vesa replay enable function

Roman Li (3):
  drm/amd/display: Enable dcn42 DC clk_mgr
  drm/amd/display: Add DML support for dcn42
  drm/amd/display: Sync dcn42 with DC 3.2.373

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.50.0
  drm/amd/display: Promote DC to 3.2.373

Tom Chung (1):
  drm/amd/display: Add back missing memory type in array

Weiguang Li (1):
  drm/amd/display: Add ESD detection for replay recovery

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  11 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  16 +
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   1 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 301 +++++-----
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 134 ++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   1 -
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  41 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   9 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  61 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   1 +
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  26 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |   9 +-
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |  21 +-
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.h  |   8 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   5 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.h  |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  20 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |  59 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |  11 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  16 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  31 +
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   3 +
 .../amd/display/dc/dml2_0/display_mode_core.c |   4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |  56 +-
 .../dml2_0/dml21/dml21_translation_helper.h   |   1 +
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  15 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   | 263 +++++++++
 .../dml21/inc/dml_top_display_cfg_types.h     |  13 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   3 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      | 111 ++++
 .../dml21/src/dml2_core/dml2_core_dcn4.h      |   1 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |   9 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  63 +-
 .../dml21/src/dml2_core/dml2_core_utils.h     |   2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  33 ++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h      |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   6 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h |   2 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |  76 +++
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.h       |  12 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   4 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   2 +
 .../dml21/src/dml2_top/dml2_top_legacy.c      |   1 -
 .../src/inc/dml2_internal_shared_types.h      |   3 +
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |  41 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   3 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   8 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  21 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.c   |   5 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   4 -
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 201 ++++---
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  85 ++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  16 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 158 ++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  32 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 421 +++++--------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   | 553 +++---------------
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |  10 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  73 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  36 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 112 ++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../drm/amd/display/dc/link/link_detection.c  |  12 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  36 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |  23 +-
 .../link/protocols/link_edp_panel_control.c   |   3 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |   4 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 177 +++---
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  | 390 ++----------
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  50 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   2 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    | 105 +++-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  13 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   2 -
 .../dc/resource/dcn42/dcn42_resource.c        |  10 +-
 .../display/dc/soc_and_ip_translator/Makefile |   3 +
 .../dcn401/dcn401_soc_and_ip_translator.c     |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       | 163 +++++-
 .../dcn42/dcn42_soc_and_ip_translator.h       |   1 +
 .../soc_and_ip_translator.c                   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 ++-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   3 +
 .../include/asic_reg/clk/clk_15_0_0_offset.h  |  44 ++
 .../include/asic_reg/clk/clk_15_0_0_sh_mask.h |  52 ++
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   2 +
 .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  |   9 +
 108 files changed, 2675 insertions(+), 1902 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h

--
2.43.0

