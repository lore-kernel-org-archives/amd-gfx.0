Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC264C3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A2910E11B;
	Wed,  7 May 2025 02:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ak79iJ4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1EC10E730
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4ASYxmpTjtrP8nfZlU1ni6ucZ8iLMu0LSBmrqFDcoA/iWWwnavgJFLh0C+kbu8d8/HK282EU8p56f/Eh5lU6C9clIAj7JgI+TDOTE0Lfpo0fuF1c4XBKAsaYeAlq4x1Esn1j26C68c3Wd8Qp4jyT2gzkVTDNoEtIpa/cYU5T2XuUjlulVoNQadoRU/sQuo6w1yFK+nwXONIwVmOsfAwQPwJjv8d3cw1m+HYK5p6MfknbQUAg8xBCYi8nFPdGOuWuVb2BXk5SjZG1mQEfz4C1QfxoHRPwRaK9HfpfB5+raseNQo8ZZuqDE7pM5fJ3/UuFJ/qEVDZ69iXmfHrjAT5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkWw+CAfIESmm6lwIWyeQcTY/yBooghxSqZtU7cU/Lg=;
 b=pYUoBjFbN9/Yrfx63HGVdjGoZ31+bG0edW5UkU29CYf4DUHZUiZCltQmz7HDh5n6zqR8P+mhXfxOuhajUfq2m0/S1YpRJ56ql7HNs+cLmMsJ00su7vQl4bZ3ca4mkS5fC5ERv6lxzTwwMbEeEjTzsIVqsjBZ0IvRaDI/zDHRm1ChZdnF8pibANCi9DFohOuye/tyJmNFnc/XKbYgsEw5Ccn98J+8dE2yvF2QQVDYHuP6fJVJLNeZkRfQNb+rr2RfJ2lv7rSx5XCGG1MZrfhImX/34UBTpsxPBYI98KH5KO/VHO0hjAq7KQGePv8Ht/v0Xz+8452NEPJAdnP7ijTNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkWw+CAfIESmm6lwIWyeQcTY/yBooghxSqZtU7cU/Lg=;
 b=4ak79iJ43iEE4llNTWSWiBXS0H4X5ph4ZTJEFuYIMIkMHDjFBlGgi+DXGwCQUQo/MuyRVQDJRhQDVAxm7aIaOPvkVBIu+k5D6yLPWsBD98CDa7RAfxCNPgLP66SPrieprctgSR5knTiObJpdmUhMdJYwj5d3fbusFNEJulaF0sY=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 02:43:03 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8a:cafe::f6) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Wed,
 7 May 2025 02:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:00 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:42:57 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 00/14] DC Patches May 12, 2025
Date: Wed, 7 May 2025 10:34:44 +0800
Message-ID: <20250507024242.1928299-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: f84d36f3-25bb-403c-c406-08dd8d10e30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|30052699003|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wq/6FgrqIf9AfgO3nqh67ZN6gZzRz9BF93cci2aSIBeGD2pyyPkf5BgCddYX?=
 =?us-ascii?Q?HZn7DwxUN69UY3S8/ImwhJvSCUS7VqUG3Sxc5O1Z8mJV7PAdOsIAmlsP4Kt9?=
 =?us-ascii?Q?o6aUHegzvucSUUN3yNVYLg2dWIb0tdeo0LBmoPZfx7crYlMFBdDhsy6y7ajZ?=
 =?us-ascii?Q?choRCXZZ7mtxXsWxtPyjAO+MX8Y6UbOZrnwzexFid/A1f82wgSD/DAjRQxir?=
 =?us-ascii?Q?E6TD1psbipQp6IGggNlFKnAtunF8AgpNUp8FfZHt5i7LiGKsQlXcnS56mbhH?=
 =?us-ascii?Q?HxrDS804cc+9+BHnC1PVTQlyqM6aOsrX4OT3Xj+V9AclQW9plU+rW2uUVJWO?=
 =?us-ascii?Q?ThgISUU/qwWrBJxy4foPCnsyk02TWfrFvQ6TQ/fNeEF1k1XM4LtNMZ8WUR7g?=
 =?us-ascii?Q?WlqTMTvH3KShPkUUTZmKipmk/sCzHe/v+SBR/z39Nj/mCA1xJW0TnOkk9sSy?=
 =?us-ascii?Q?/4dtiP0yAiAT2QkXc2kkIHnZnZEhIk2cCeEPwhjqsOcyGBZjDXdPqs/noxnu?=
 =?us-ascii?Q?G4Y5pvX3tjsebCPxJMeiMQqoaFxXOp1rc9VnpL8cmzzsVc1X7GoVN7BOv9WW?=
 =?us-ascii?Q?gilKo0y5CIql39iRgliqHoo03LxY7yzC4o0xvd9T1V3hFnIDGeIQG9UB//kY?=
 =?us-ascii?Q?5OOCYFaLcUgPtVPvEpyfDyNYZ7/VqbEi77mkopF/2A8AMWVSJ7btPuxKfc+K?=
 =?us-ascii?Q?p+YCBNbor1UmUP+Tg3VLOGVfj3G60ZgqxZciShJcmNFYg73nR6Exu1wy4c43?=
 =?us-ascii?Q?Aq82hPKf6q894cceOnuO+Wy/syQauMwH4TRD7pecb6KKSD9p9NfDpVz2M130?=
 =?us-ascii?Q?wV8CF/jZ30nKlT0Fys40uTP+66CTZICeslQVky5R4voQ3ohkfxq5jvRoRDxd?=
 =?us-ascii?Q?kGGWFNTGlgmza0nnMxdonUYAErUsEYK+afliHuu2qr9pQ/Z7TnQLEFPP2L70?=
 =?us-ascii?Q?juvnogQyWxrSE9VpVumbeHwm31d5uyl61X0ROe+h7z0HJAXShm1t4daq6Hqi?=
 =?us-ascii?Q?crC/hAh7PmGoXk//TG7+jEvdKgmcm4tkWpqWvoJLQQBGXS5uCaTMApASJVHn?=
 =?us-ascii?Q?QOM17TnxJmP1YHG90n6f7TjezlitlyIL7B8uNmtpT935ijxlRmsiq/BIZDfg?=
 =?us-ascii?Q?q/y7F8+GuEy7Jc7BSeqe9E6Lb09cI2tXttg/bSCHNFXzPsOypnVssqtbqa6P?=
 =?us-ascii?Q?TkIDwDfzNtyMOVaTkBmzAerrxl0VtmpP3Ng0XiBovkw331w0lLRcEtBT5Y+x?=
 =?us-ascii?Q?nQTz2sQM81cS0hke4IgFoFq9ZgdcXRjR18HgEC13xD3kmqBT8YYNJpDDBYhP?=
 =?us-ascii?Q?AEfdTAhCLCVRcpTJKyz6gkma8CmR8LMGtepSt5Wmhrx1tv7+7Ilz0f2/wWLe?=
 =?us-ascii?Q?RvVLakKku7VZPPFTm2R4oOPaGdsDMXk30N5KSu8uewidx3O3ScwOvjX6y+5L?=
 =?us-ascii?Q?G3ELr6P/LSGoCn919l25tziARBTGd20S8pKoc2pLAG/qhT8+6bjKYSUwAs24?=
 =?us-ascii?Q?d4Vh3hI1cnanqlbVDMub3HWpdBNK79tEGRov?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(30052699003)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:02.3381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84d36f3-25bb-403c-c406-08dd8d10e30f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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
* Refactor DMI quirks
* Fix link-off issue triggered by quick unplug/replug
* Fix race condition when submitting DMUB commands
* Correct reply value when AUX Write incomplete
* Backup / restore plane config only on update

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Aurabindo Pillai (1):
  drm/amd/display: check stream id dml21 wrapper to get plane_id

Dillon Varone (2):
  drm/amd/display: Backup and restore plane configuration only on update
  drm/amd/display: Fix race in dmub_srv_wait_for_pending

Gabe Teeger (1):
  Revert: "drm/amd/display: Enable urgent latency adjustment on DCN35"

George Shen (1):
  drm/amd/display: fix link_set_dpms_off multi-display MST corner case

John Olender (1):
  drm/amd/display: Defer BW-optimization-blocked DRR adjustments

Mario Limonciello (1):
  drm/amd/display: Restructure DMI quirks

Michael Strauss (1):
  drm/amd/display: Add early 8b/10b channel equalization test pattern
    sequence

Samson Tam (1):
  drm/amd/display: disable EASF narrow filter sharpening

Sung Lee (1):
  drm/amd/display: Program triplebuffer on all pipes

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.10.0
  drm/amd/display: Promote DC to 3.2.333

Wayne Lin (2):
  drm/amd/display: Correct the reply value when AUX write incomplete
  drm/amd/display: Return the exact value for debugging

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 159 +---------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  | 178 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  46 +++--
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  14 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   3 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  20 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  13 +-
 .../dc/link/protocols/link_dp_capability.c    |   8 +
 .../dc/link/protocols/link_dp_capability.h    |   3 +
 .../dc/link/protocols/link_dp_training.c      |   1 -
 .../link/protocols/link_dp_training_8b_10b.c  |  52 ++++-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  14 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  50 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  58 +++---
 .../amd/display/include/link_service_types.h  |   2 +
 24 files changed, 439 insertions(+), 221 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c

-- 
2.43.0

