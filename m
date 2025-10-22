Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF405CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CE310E6F2;
	Wed, 22 Oct 2025 07:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KFHBXsJS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6884E10E6F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMEofTZsmzuXXyUA3wfp4lZ7B8s4QfpFAysarf4kYj6N1NEYRq+53Cpo9wMArG10uij+EbiomhRnw9qoFZ/SB4g4cWMNSS1HVaHSp4zqjhpgpS+WEpQf3qy7lL+AjzLSaiH7oaXpn3Xfk0d+7otjDEoy03kygVirzSkxJPgQngMrNpTMXdAdKuts71P5i7Ct6V7Ah/pbEGlFViUQlVH8qr+tGaIMbS4RzdAclpmwlSFrM/jxZvL0txlA6nGpVn9+FciM0qUpLKp0gRv3EZ41eHshXqvmaTpfX25kkxxIHoA6f8n1Gujo5IMhX1cfMzDmAgzB7c2MmOh2+qwVYiyo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqU2boK1Yo7RrpOOucTBZQar4NMMtlOYsDLGlzXIFXg=;
 b=b3nsABbYx22DY0PWeidC/uL7pEv0tP+xGIH4ENC0j3vTLi6zSFmsxUyUuVRlgoQJbDL4zf7ZPd9XsgQJ4AlDie/bXS1bJagNwsVO95QMiUID6Nbf/XSRPw603tKHgiw6uV5LnlP0n9yHP8XVAG13rFeauPXn9atuIAkExjM2KKcg67V0B43WiRLqEjZIshRu5sX+6yn78YcHZYGeUmJXMFF3IdYcSrs7xa8xRR8l5A2RSYoRxewS7saYYI42CIPA7P8gCxxxB1qPZp6ikLTWv+ZBWyb0/r350eX2G0e7rgArBH9+w0z4MLHQitm/nJ/vaJGhA/aPNobXlSx8UY61rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqU2boK1Yo7RrpOOucTBZQar4NMMtlOYsDLGlzXIFXg=;
 b=KFHBXsJS9pfHecnJbBo83CVR5eRBTz6pZiWDPV1kXbzRPgPsrDi5xOA9kSbW/jxltVyTW6l59dqCyyvO5imQAPGbKiu+tvD6Kna1J9QuLTCQw0USt/pk+LGFolH0cI5fFFniy4bW5dxY9JBfFGq6RksxrYmxfGbWhnSzWua3uns=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Wed, 22 Oct
 2025 07:33:50 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::5e) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:33:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:33:49 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:33:48 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:33:40 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, waynelin <Wayne.Lin@amd.com>
Subject: [PATCH 00/20] DC Patches October 27, 2025
Date: Wed, 22 Oct 2025 15:30:12 +0800
Message-ID: <20251022073332.666119-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a0d539-60ce-4c44-1ea2-08de113d57e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sESV8ri14v4BioGlc7lN7E0M6iw8TMyglh48/de11LlvkQW/slGgd0/kzlwt?=
 =?us-ascii?Q?aiHyMvy4N+5W7ycAbc4EU4TIFl/kZGf5/jvx/KLyKGy8hHTJ9Z1HoKHnE/g1?=
 =?us-ascii?Q?UVWePp0znX57crNEslpbau7QL4gjO8MhHxfH/w69OLSGXbplBzA4/lkhSqAo?=
 =?us-ascii?Q?qCbqXS8MqoUG6POHfVJ0Sptuu2n5TyE+vKXQfQcNSspsr4jCuZlGn8rVqfGu?=
 =?us-ascii?Q?bLtTjVdtSSC0HuuxGC6jV2vI8uHT8MJRVD1PNZJp5i2cfaFCEzcbddLM1f/i?=
 =?us-ascii?Q?wkTJTfSiZLT15NbBT+RBzUf9bzTNX/IYnnR7CqvfU0LU4WwQmBaDuPeFeWFc?=
 =?us-ascii?Q?t60TTw3e2GlVOhV+BQnOQnmUtQBKZoirCGH7X53X/5iRFUZhN908M3ErKkiO?=
 =?us-ascii?Q?Q1sVYilbba4+mDwcVSLnaZCtII++PCWcjWEfbkawikaKSxrrtCCaBc/vnc8X?=
 =?us-ascii?Q?Twusi3SAxmsK5oXY+RbWm1x7tI/s+4uS0aHZ/MJMFZ+LIw23QqsiuDtM4fKV?=
 =?us-ascii?Q?pkkY67TwQB5iP5LKacl4alksWRU5p8s0TqN/Yyz/exsHOfPumU/2vLqBE2Pd?=
 =?us-ascii?Q?IXpD7pWhdp4gpqotysKtRDjsnzkCCC6QKNGKttx1WNWnu9yGvWUp6ZrHokrQ?=
 =?us-ascii?Q?naYEjecRbn38PovFkzK5aoE9nAH8MOzVvw6+HYlhYwWXE1rMFJlYYsuZyCOF?=
 =?us-ascii?Q?wLcdSM/J2yzsDt2duYzgqBZhrvvK8fcj/NTjMsTEf9Wc3Ne36hccj09Y7l2L?=
 =?us-ascii?Q?1uXwZVs9Zr61Baqf7Y/3LRbU0ozkvv+CpyJITvDK/f7EcT6FIluK7xjF95UI?=
 =?us-ascii?Q?mujNV3lwaAEBORbUU6MprDNKvjYUfG32PYCx1m9Va7XonFNu4l5rY3MhSLEC?=
 =?us-ascii?Q?tar17vDCWpV9x8DfCVZv+oz2+S3iRfN0cyGyzmQcwo2Ihcp9pMYUfjEBkvsL?=
 =?us-ascii?Q?PnMDJBSuZ4epiOc4Tudrs5IRMb0+fXK5BV+SEV/6J7XUOPsYNJknEflpOgM9?=
 =?us-ascii?Q?yROVuysQFe33rtGQJFncZOxoPLy0cXS7NBqel94DAvpc393nhFAP0rO0SAlR?=
 =?us-ascii?Q?zVE3wCDdQJmw47tFrrDyMnJoZIE7F+peSoqbTvE8QJUik/8LO+wvRpP7RING?=
 =?us-ascii?Q?KkcBvCifbTnTLqQhFT5wfbk3Qbh50uS24PwreyN5Mqe+dCMNoEGhM5reBOKq?=
 =?us-ascii?Q?qQjU25hviKB0zSeObkaPubfZBHrtpG5cR6RrozVReL2YhuM1kZrydV6evF2u?=
 =?us-ascii?Q?tLKkOSZSUWSFGELgEWIIX5c5iW1n48djja/JbLe9l4P2308/AusymhPXsAGJ?=
 =?us-ascii?Q?u8wi2JJhh3NQscZVIfmHg/uppZntr3nT0/+kmbd/Df/x/Bf1NultRi5gyAXe?=
 =?us-ascii?Q?Q4Rp8x6LBzjehKNYXYUEr1nmiGQgpil3+5leuFzHwrb6eBw1GgUKQYFGY7ld?=
 =?us-ascii?Q?W9ZxAEO0G+aqfMYxaHPok+O0JohrA9QBzN8CovMdjJdl7yKHaaw0arAmxJZb?=
 =?us-ascii?Q?7gQJGFALqXUDJhe9+Jq7sJCsT8srfzRv3wVmFPtZIuzV81Avv7ZcxWrdeQhr?=
 =?us-ascii?Q?IMEcMdFtT8wb5DZBEoHeJB3dmRTOXdYW+/b22B2l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:33:49.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a0d539-60ce-4c44-1ea2-08de113d57e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
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

- Fix incorrect return of vblank enable on unconfigured crtc
- Add HDR workaround for a specific eDP
- Make observers const-correct
- Add lock descriptor to check_update
- Update cursor offload assignments
- Add dc interface to log pre os firmware information
- Init dispclk from bootup clock for DCN315
- Remove dc param from check_update
- Update link encoder assignment
- Add more DC HW state info to underflow logging
- Rename dml2 to dml2_0 folder
- Fix notification of vtotal to DMU for cursor offload
- Fix wrong index for DCN401 cursor offload
- Add opp count validation to dml2.1
- Fix DMUB reset sequence for DCN32
- Bump minimum for frame_warn_limit

---

Alex Hung (1):
  drm/amd/display: Add HDR workaround for a specific eDP

Alvin Lee (1):
  drm/amd/display: Update cursor offload assignments

Austin Zheng (3):
  drm/amd/display: Add dml2_0 folder
  drm/amd/display: Update dml2 references to use dml2_0 folder
  drm/amd/display: Remove dml2 Folder.

Dillon Varone (1):
  drm/amd/display: Fix DMUB reset sequence for DCN32

Dmytro Laktyushkin (1):
  drm/amd/display: Add opp count validation to dml2.1

Dominik Kaszewski (3):
  drm/amd/display: Remove dc param from check_update
  drm/amd/display: Add lock descriptor to check_update
  drm/amd/display: Make observers const-correct

Ivan Lipski (1):
  drm/amd/display: Fix incorrect return of vblank enable on unconfigured
    crtc

Karen Chen (1):
  drm/amd/display: Add more DC HW state info to underflow logging

Mario Limonciello (1):
  drm/amd/display: Bump minimum for frame_warn_limit

Meenakshikumar Somasundaram (2):
  drm/amd/display: update link encoder assignment
  drm/amd/display: Add dc interface to log pre os firmware information

Nicholas Kazlauskas (2):
  drm/amd/display: Fix wrong index for DCN401 cursor offload
  drm/amd/display: Fix notification of vtotal to DMU for cursor offload

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.33.0
  drm/amd/display: Promote DC to 3.2.356

Zhongwei Zhang (1):
  drm/amd/display: init dispclk from bootup clock for DCN315

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  87 ++++++-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 220 ++++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  45 +++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   8 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  68 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  21 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  64 ++++-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    | 123 ++++++++++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   2 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   3 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.h  |   3 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 141 -----------
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    | 140 +++++++++++
 .../display/dc/{dml2 => dml2_0}/cmntypes.h    |  18 +-
 .../dc/{dml2 => dml2_0}/display_mode_core.c   |   2 +
 .../dc/{dml2 => dml2_0}/display_mode_core.h   |   0
 .../display_mode_core_structs.h               |   3 +-
 .../display_mode_lib_defines.h                |   2 +-
 .../dc/{dml2 => dml2_0}/display_mode_util.c   |   0
 .../dc/{dml2 => dml2_0}/display_mode_util.h   |   2 -
 .../dml21/dml21_translation_helper.c          |   0
 .../dml21/dml21_translation_helper.h          |   0
 .../dc/{dml2 => dml2_0}/dml21/dml21_utils.c   |   0
 .../dc/{dml2 => dml2_0}/dml21/dml21_utils.h   |   0
 .../dc/{dml2 => dml2_0}/dml21/dml21_wrapper.c |   4 +-
 .../dc/{dml2 => dml2_0}/dml21/dml21_wrapper.h |   0
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   1 -
 .../dml21/inc/dml2_external_lib_deps.h        |   0
 .../dc/{dml2 => dml2_0}/dml21/inc/dml_top.h   |   0
 .../dml21/inc/dml_top_dchub_registers.h       |   0
 .../dml21/inc/dml_top_display_cfg_types.h     |   0
 .../dml21/inc/dml_top_policy_types.h          |   0
 .../dml21/inc/dml_top_soc_parameter_types.h   |   0
 .../dml21/inc/dml_top_types.h                 |   0
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.h      |   0
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  29 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |   0
 .../dml21/src/dml2_core/dml2_core_factory.c   |   0
 .../dml21/src/dml2_core/dml2_core_factory.h   |   0
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |   0
 .../dml21/src/dml2_core/dml2_core_utils.h     |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h      |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.h   |   0
 .../dml21/src/dml2_mcg/dml2_mcg_dcn4.c        |   0
 .../dml21/src/dml2_mcg/dml2_mcg_dcn4.h        |   2 +-
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   0
 .../dml21/src/dml2_mcg/dml2_mcg_factory.h     |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn3.c        |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn3.h        |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |   0
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   0
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
 .../lib_float_math.c                          |   0
 .../lib_float_math.h                          |   0
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   0
 .../dml21/src/dml2_top/dml2_top_legacy.c      |   0
 .../dml21/src/dml2_top/dml2_top_legacy.h      |   0
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   0
 .../dml21/src/dml2_top/dml2_top_soc15.h       |   0
 .../dml21/src/inc/dml2_debug.h                |   0
 .../src/inc/dml2_internal_shared_types.h      |   0
 .../{dml2 => dml2_0}/dml2_dc_resource_mgmt.c  |   0
 .../{dml2 => dml2_0}/dml2_dc_resource_mgmt.h  |   0
 .../dc/{dml2 => dml2_0}/dml2_dc_types.h       |   0
 .../dc/{dml2 => dml2_0}/dml2_internal_types.h |   2 +-
 .../dc/{dml2 => dml2_0}/dml2_mall_phantom.c   |   1 +
 .../dc/{dml2 => dml2_0}/dml2_mall_phantom.h   |   0
 .../display/dc/{dml2 => dml2_0}/dml2_policy.c |   0
 .../display/dc/{dml2 => dml2_0}/dml2_policy.h |   0
 .../dml2_translation_helper.c                 |   3 +
 .../dml2_translation_helper.h                 |   0
 .../display/dc/{dml2 => dml2_0}/dml2_utils.c  |   0
 .../display/dc/{dml2 => dml2_0}/dml2_utils.h  |   0
 .../dc/{dml2 => dml2_0}/dml2_wrapper.c        |   0
 .../dc/{dml2 => dml2_0}/dml2_wrapper.h        |   0
 .../display/dc/{dml2 => dml2_0}/dml_assert.h  |   0
 .../dc/{dml2 => dml2_0}/dml_depedencies.h     |   1 +
 .../dml_display_rq_dlg_calc.c                 |   0
 .../dml_display_rq_dlg_calc.h                 |   0
 .../display/dc/{dml2 => dml2_0}/dml_logging.h |   1 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  16 ++
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   2 +
 .../drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   1 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   8 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |   1 +
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   5 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  33 +--
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |   6 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   3 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    | 136 ++++++++++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   8 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 147 +++++++++---
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  28 +--
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  76 +++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 121 +++++++++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  12 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  27 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  13 ++
 .../amd/display/dc/inc/hw/timing_generator.h  | 130 +++++++++++
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |  16 ++
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h  |   5 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |  14 +-
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.h  |   6 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |  13 ++
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |   6 +-
 .../drm/amd/display/dc/opp/dcn35/dcn35_opp.c  |  13 ++
 .../drm/amd/display/dc/opp/dcn35/dcn35_opp.h  |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  38 ++-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 131 +++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   2 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   7 +-
 .../dc/resource/dce110/dce110_resource.c      |   5 +-
 .../dc/resource/dce112/dce112_resource.c      |   7 +-
 .../dc/resource/dce120/dce120_resource.c      |   8 +-
 .../dc/resource/dce80/dce80_resource.c        |   8 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   7 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   6 +-
 .../dc/resource/dcn201/dcn201_resource.c      |   6 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   6 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   6 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   6 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   6 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   6 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   7 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   6 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   8 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   6 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   8 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   8 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   8 +-
 .../dcn401/dcn401_soc_and_ip_translator.h     |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  25 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  12 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  50 ++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  39 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   2 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +
 182 files changed, 1920 insertions(+), 530 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/cmntypes.h (93%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_core.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_core.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_core_structs.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_lib_defines.h (95%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_util.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/display_mode_util.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_translation_helper.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_utils.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_wrapper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/dml21_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/bounding_boxes/dcn4_soc_bb.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml2_external_lib_deps.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top_dchub_registers.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top_display_cfg_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top_policy_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top_soc_parameter_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/inc/dml_top_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_dcn4.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_dcn4.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_dcn4_calcs.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_dcn4_calcs.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_factory.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_factory.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_shared_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_utils.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_core/dml2_core_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_dpmm/dml2_dpmm_factory.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_dpmm/dml2_dpmm_factory.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_mcg/dml2_mcg_dcn4.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_mcg/dml2_mcg_dcn4.h (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_mcg/dml2_mcg_factory.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_mcg/dml2_mcg_factory.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn3.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn3.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_factory.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_pmo/dml2_pmo_factory.h (97%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_standalone_libraries/lib_float_math.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_standalone_libraries/lib_float_math.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_top/dml2_top_interfaces.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_top/dml2_top_legacy.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_top/dml2_top_legacy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_top/dml2_top_soc15.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/dml2_top/dml2_top_soc15.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/inc/dml2_debug.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml21/src/inc/dml2_internal_shared_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_dc_resource_mgmt.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_dc_resource_mgmt.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_dc_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_internal_types.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_mall_phantom.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_mall_phantom.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_policy.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_policy.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_translation_helper.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_translation_helper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_utils.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_utils.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_wrapper.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml2_wrapper.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml_assert.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml_depedencies.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml_display_rq_dlg_calc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml_display_rq_dlg_calc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml2 => dml2_0}/dml_logging.h (99%)

-- 
2.43.0

