Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58658C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002E610E38C;
	Tue, 27 Aug 2024 16:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGu36LJl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDD510E38C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYEsEVPnTMRGjhGpGIdDe3i9+GOSsLBumBizeGFr7ZFb9j7u9kVU4M3Xor0atP1Gl4g5mXec7my5wOTxFELWT7fNemqnHyXhhy1NCbiQNIIUbOtP85/z15KzBOV4P6mNo1oSNUfxWgvnJGL50QaKPV+xIui6cgVYI04HbpyCRmq4k+MUFtjReomBvAyzIvrX+oV/ZqGAd9bcUE5QqE7uddal/pI8VdnnhSeb6lGCjASfDT1lLaZYSAEoq7AE+KNXjjb8pxw/qLI2hc1cMsytKg4fXLjwqI9Uhn/7iLA52HpzSARpFmZ63TNC3sNQJcPNtt4M9hCMC//Ul8k0EKPd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBJJnjjg818o4mx9KKKCcdvn+NXcKQ3lP/73uwx/tyA=;
 b=j/WPMrdx/OyYs2FHXMI8txmQsSFBGe6fEamOgSILrk7eGSrzGdPyPFmJU7Ggaaw5nO08FPx1vc6rUG87D64vxU3MDk3ihTYEFkefHsfaQUXDGwWKqMXZQw/g+ulo/V54GrUBYZLKrPgNuSvrIAWEWx1JFo8Z5BAR++RTVjfigzsygvJekFUrq9jF0wa7R/dxohtOlp+rKNHF1YR0qYb1kFanIaRL5U1Jg9dBRK47my4IL1EONOs9XZ30YPEkJueBkjrUEn2CKrJRVa9CQDVa/mXAQTq/DkDA6Nr+ouDxJoMAU5Ibj+DjZcJmflkPX9jQg5lMMJFdTd4ZUInLcdnUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBJJnjjg818o4mx9KKKCcdvn+NXcKQ3lP/73uwx/tyA=;
 b=rGu36LJlvKuFeb2vNzZVrpPF142u9pkQSl/uf+RquTD+VzzB+4GKLYSB34apskEpcewDv605et8Auzbj9bg9qD0iM2OOd3WJMMbCv99IYumtTs1zT2nYNXLeOF+3zObuMeJZ9f5HtW6fABVYexgHi2Jj+k3l5c5CqehSnifeqUM=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Tue, 27 Aug
 2024 16:41:03 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::a5) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:03 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:01 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches August 27, 2024 
Date: Tue, 27 Aug 2024 12:37:20 -0400
Message-ID: <20240827164045.167557-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 263a4fd1-b3e9-4e58-04e0-08dcc6b70a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rcqJsFgeR6rEBH/EEXw47vklPEVpWm9ZfmdSbJweTYvUsXO3tSiXSAQEEN49?=
 =?us-ascii?Q?AONzglI2QVP6S6TagCl9N/f/+tL4Ka/3KVNWr/CuY5k0m+cCLIeFLj5E+dRY?=
 =?us-ascii?Q?y6w/6dU7JJHCM9jMjLW/p0G+Zf0uDWEZ4D50nxRVUrL6FhgE2Kx0UXlJQwT9?=
 =?us-ascii?Q?tWs9tG8dtbjxHvHyGnX+TAn8z0e/fwFxU+iY1WZIYw/4Pmz3ROjRXAPYuUYJ?=
 =?us-ascii?Q?YxhcXGCuZWSh/BzVK9qHDIdTzJgKknZqL/rNP7RmMBTZffcqSQTX/d7Wb1lg?=
 =?us-ascii?Q?QWm1K5cStkFNOtjPCMVYCDOAoktYNHzkYwTyEyzDfYJPJi8lbCgnoDS53q8g?=
 =?us-ascii?Q?rqwrwQ2L0gAqZXkly8a0xCdjq7om3E0ilhKPQ3b8f4tRpoK/vJZja3k71iP2?=
 =?us-ascii?Q?0QEgIcw7P67WSgOe5FHdxFeZ/obGdju9zpGWkU86tUj6/zYfgH8cMc3aikN1?=
 =?us-ascii?Q?hAH8qb538AEB1o4V/kY0fSEa/OygkIJE8Dabu0u8Sx7HHLn1KSWK8yV9PjEc?=
 =?us-ascii?Q?zzpeVPKzrsBg3otZucxnCa4fh9qjy9aRVojHNDdNubwSCHTKEhP6N8rCCVpU?=
 =?us-ascii?Q?azwTVI6rbPXIYw5RapEq/ZXXr/0Pbkg2hBixfmZO2LbkPb2v6/zr+shj3OYF?=
 =?us-ascii?Q?pM0G2zlo2HdJ3harw7eIc1AB6nWZb42MSQ196YaOC6GbkMnVavi8h4X1o6/q?=
 =?us-ascii?Q?vEsvppEo66UDScFHKN2BQRgEAtxvDD4/NUMvWua6xUQF7elmKil/V/0s5Pls?=
 =?us-ascii?Q?vimD6jVAd5SITdWSwcBQ7TbXbodtTgAKo4etLMHUs5pgX2C5BdQ6zX4xvv7M?=
 =?us-ascii?Q?Ph2z/uKMVGRgEQDYbmydFwTBxxTXUdwVUJ6kjrfx63eMzqXe2OjB4ct3d0O+?=
 =?us-ascii?Q?DKQp0sSe651b03Pq7iKW7EU5QXVuHxN2rIMZrSQjgsfe3zhGk2Pc55DgtRua?=
 =?us-ascii?Q?N8WhrUPZvnVOfmh0OHS/+fAMwxyBwzTq4M4M7GWaJ04DhkIOawnqCPzDa6VG?=
 =?us-ascii?Q?btKEs6I22mVh/ZBnPqNTOLlX6gga16OiP39fEMniLqzwo88Wl35Fv46dHoNi?=
 =?us-ascii?Q?JgCaWUdxR/jDJ9nRr84JewbtoAKD7GJYDn2N0/rjWTqnIavGJWz58pupWwBB?=
 =?us-ascii?Q?9pIaDa+Hm1gMzrlH7x+lIfgUX1I2tPwz/cLL9fvrImdy08t/NyG52CNldUeF?=
 =?us-ascii?Q?ea9QN1I05sMeLKylCHNBfedjd40LfSER0hRYJ3zm5m9SAZSWN0mvYxL/Xy5c?=
 =?us-ascii?Q?IDEMd2tNnloghdgI3oYXg5e+1M2Ey2H4WpI40PNM76/+xKiEXboil4Q2Qz+j?=
 =?us-ascii?Q?YtZDUSZRlBFhLerNdg7E97vxLqcojpNEzOp8bnb1t+FzR6K1eq1itM9huLKb?=
 =?us-ascii?Q?EEdtTTcla00Pru8/dqS2KLKi7EOSeXk9e2Zppsro21KXlWBt9AvKL9/Vt7ft?=
 =?us-ascii?Q?s8Z2siXnx3dPjVXVsRVK8/aonbgCLDgU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:03.2753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263a4fd1-b3e9-4e58-04e0-08dcc6b70a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.299

Daniel Sa (1):
  drm/amd/display: only trigger BIOS related assert for older ASICs

Dillon Varone (2):
  Revert "drm/amd/display: Wait for all pending cleared before full
    update"
  drm/amd/display: Block timing sync for different signals in PMO

Gabe Teeger (1):
  drm/amd/display: fix graphics hang in multi-display mst case

Hansen Dsouza (1):
  drm/amd/display: Fix flickering caused by dccg

Leo Li (1):
  drm/amd/display: Lock DC and exit IPS when changing backlight

Meenakshikumar Somasundaram (1):
  drm/amd/display: Add dpia debug option to control power management

Nicholas Susanto (2):
  drm/amd/display: Fix DCN35 set min dispclk logic
  drm/amd/display: Refactor dccg35_get_other_enabled_symclk_fe

Qili Lu (1):
  drm/amd/display: fix dccg root clock optimization related hang

Relja Vojvodic (1):
  drm/amd/display: Add sharpness control interface

Samson Tam (2):
  drm/amd/display: re-enable Dynamic ODM policy
  drm/amd/display: disable sharpness if HDR Multiplier is too large

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  52 +++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  11 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 168 ++++++++------
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |   3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   3 +-
 .../amd/display/dc/dml2/dml2_internal_types.h |   2 +-
 .../display/dc/dml2/dml2_translation_helper.c |  67 +++---
 .../display/dc/dml2/dml2_translation_helper.h |   2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  12 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  24 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  27 ---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  49 +---
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   9 -
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  45 ----
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |  13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |   3 -
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |   9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  16 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |   6 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |   4 +-
 .../display/dc/spl/dc_spl_isharp_filters.c    | 213 +++++-------------
 .../display/dc/spl/dc_spl_isharp_filters.h    |   2 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  27 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   2 +-
 48 files changed, 346 insertions(+), 532 deletions(-)

-- 
2.46.0

