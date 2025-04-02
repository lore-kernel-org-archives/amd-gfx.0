Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE83C3601A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2F910E821;
	Wed,  2 Apr 2025 16:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2NrCtmm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F244610E821
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1BRllhY5h07NH0pFlWR8S1bog9Hcnss90hxduqJ5WjjnknRXH2/Ln+C9lw7LoB5PzXjv9X6LQx32I+N25oDrBSHaqGet3nyWQu9ZnZaZLB4mhiGT1cTOlTO8irDxGD0CZTU9MPcsOW0ARA5MSV0zTcnEoQhUgv2YiN6NPRCN0O52autr2BNrdSFpcUo3EWOTNI1QGMRSlAeEYcImBlAToYBautLdUD0NYEQs7VSUp6MOASRVHQGcibbwEx5LPEyYzclrehwHekRpvZ8lUPzpK8NMLqBZ6+9aIiUutqAOioDCvdsjI5732YBhBOo+CQFL4wqpMyGLjObPfPvd3iq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2z/tPAYO6acRNF1J1EQeyewsewiuAbE+lIoVRua0Jc=;
 b=fODpseqLzDoSrwtj2o3xP56lj4+bOABdkaXUmpkH5c5K8qgEC/MhC6inCEYIjn42aTAXqyeKgcUaLFkl/aVp0EDby+y4V+ToilvgK29bXzEpf5curVt/63E5LZrOjW86Ku+/CIXY2SgkGUSeCSfZnfeEAteeeS8wxAWn1cUcgOypdVdgtCE3ZphNSI2OZwTcc3mQuJQGFvWqxzcHOkaZLlkwhT2cZGxBMPj31KXwFF3Y23IMmzOl9TIw2BWcHsYFlwwqzqmA+c/Rdq6JcGLRijGpgJrcnPDfuDxZhxdmfXz7KOJPJcCyrQGjPCNVld8fGF9DLLnZxzoIV4tlXQRWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2z/tPAYO6acRNF1J1EQeyewsewiuAbE+lIoVRua0Jc=;
 b=F2NrCtmmy56hQp8kgcUkirZkDEQmnppnB6SbW2kx4+gK3/5IP2Xo8UYa8Tl/NN2nV/vAG0kkVgqcWeSVj9ULgsEuLHRDp4Pxdsi6dtUKjPBup+6GhMOTCdvqZE6+bpeNCir8KONRaaQRs2a0mgteaEi2hbIUC51ekfjKEwNWzeY=
Received: from CH5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:1f1::23)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:13:39 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::a0) by CH5PR03CA0011.outlook.office365.com
 (2603:10b6:610:1f1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:37 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:32 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/16] DC Patches April 02, 2025
Date: Wed, 2 Apr 2025 12:13:04 -0400
Message-ID: <20250402161320.983072-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c071713-d6f4-485a-92ff-08dd720153ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s6/A3TewhgdpoS90gAS6vOL8wM6MJ2xz0aM2lCr8rww6KpaFByB1c7Ra0Zkk?=
 =?us-ascii?Q?C6Bvw+QqzVJRbOIktM9mUCMoXNASJ61+NEXKbI6qBhol9Kl8woMr1tOOr/HC?=
 =?us-ascii?Q?/BNGQFt7u3CWn3DsqiycWDO6NhbKI5pA/yrkmA15G3M20URbuc1UZCvN9RtS?=
 =?us-ascii?Q?jMkxIW9ZtcmwXgvdlgTHJoI1BeZ9zAit/2hEG5O9yHkDANVPE9s7aGquiyPT?=
 =?us-ascii?Q?RSok6A8aw1s9fIeS8TRypFid8Cj5bR6c8FnSytzYu5rzqFnGb+tJmBS1vHOV?=
 =?us-ascii?Q?PavT0MfsIaPjvQeNZsUJVvmGOpQQnapw4qXrKRC/n4kywtCVMD6WhZv1DcUi?=
 =?us-ascii?Q?IqMPOUyHqBnZL/9u2DUWC9NPfJMNLauKPhzNeS+6EhzyMBnKJ4G0egJFoMVB?=
 =?us-ascii?Q?NqYO38ZnI1BoYqQwlTCJTDwAZT7dXeLkEUOzUOeHjvMg/WRRnPojWHeQORHN?=
 =?us-ascii?Q?9hk4Gk/PMlno2oZ0JQY/PK0vcf+QM9YlAA5AM8aV6BOEDS2WYT6OAkLZYnfX?=
 =?us-ascii?Q?K+bqfvLH3yNKRAGh735bpih8CbExLX22sdOaeAtI921/c2Qhl4EZYe5WfjFf?=
 =?us-ascii?Q?jiBj9Z+61WG1RewCqrkhX8Xhy2C/ezAzZOhnYbWWsRJ9bNakUkEvKKy4yKvk?=
 =?us-ascii?Q?HRoJj4hDuywICxfpwE9xmRxnprQHMHNjdM26YqKkhopzed/z2CfaPh7B0W+7?=
 =?us-ascii?Q?NxULAdHzyN9zdYTFOJQsOxvfVlmWcJSHbs7Csd+rk5TIBEJOt1s6jiyjI8/K?=
 =?us-ascii?Q?52DodudvNTcopYFWjEJ2BtydXoewnoNd2rS72Wr1s1MP9/Wt5IW0yTFBRv2c?=
 =?us-ascii?Q?GUSeaeIlQlH+qrTpoe5M+WNV1PfYI/mxyJELtsllc0Qi4LswfnJk+Z4+xo/+?=
 =?us-ascii?Q?4c2XCZ9QN+TFbKSoOWn6LcUm+yYyLElrFhfPy6ufhVS35y2Cd5Ml82sbuITR?=
 =?us-ascii?Q?XYFH+hSLtFBY7Yaq5tjeclKrL667kmV52UyqYSm4Rs+OdN052kqk7955CE/t?=
 =?us-ascii?Q?ZORmyiZQ0dgZpu1T8Xk3o+Scs8dcfwUL/4yJVV+awNzH6E2zhUg6vUqikVak?=
 =?us-ascii?Q?5UfOGMDeD8cXmSm4GLKtomDMQz5dBdf6V/f5fhNoZY0mgUP8PMpn627+ygqM?=
 =?us-ascii?Q?5iL70nurbE15rLLF/wBWRrVKjJyzITEcBU4MrYxPID1vLiYOiF0EVw4i61cr?=
 =?us-ascii?Q?sHcIjjvZJ4nm3QJJnAir74i9N7mmmwIxDbvOiwEef0VbLCvUnDXoytqYAERE?=
 =?us-ascii?Q?WrZ5ygknR0zJ11eOUfjBtdM5juw04YCGff35bkb71YylI7AzrzGc+1SAibBV?=
 =?us-ascii?Q?el0p4lSlG961kq5dZSHUlG6t6QGZVy6OOEdmQJpwHYUkt1c+FDuw9fnx3+DY?=
 =?us-ascii?Q?q2ZTGX3qucXEtdSS8xkxVtBrOC7ZPnxpOtjTQ4SI+mH1U7kJ8dacs/ofUwIv?=
 =?us-ascii?Q?5Rmi3mL59RXyYGOK5ugn319wnwxMKRwXEFu/+WKaglbigfaz5oWGgN9jgBnJ?=
 =?us-ascii?Q?NwXGj5LB7HQ8msE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:37.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c071713-d6f4-485a-92ff-08dd720153ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

From: Roman Li <Roman.Li@amd.com>

Display Core version 3.2.328 summary:
 
* Add DCN301 specific hubbub init function
* Optimize custom brightness curve
* Correct SSC enable detection for DCN351
* Turn off eDP lcdvdd and backlight if not required
* Use DMUB Fused IO interface for HDCP
* Extend eDP-on-DP1 quirk list

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ausef Yousof (2):
  drm/amd/display: wait for updates to latch before locking
  drm/amd/display: dont disable dtb as dto src during dpms off

Charlene Liu (1):
  drm/amd/display: turn off eDP lcdvdd and backlight if not required

Dillon Varone (1):
  Revert "drm/amd/display: Fix VUpdate offset calculations for dcn401"

Dominik Kaszewski (1):
  drm/amd/display: HDCP Locality check using DMUB Fused IO

Kevin Gao (2):
  drm/amd/display: Correct SSC enable detection for DCN351
  drm/amd/display: Add DCN301 specific hubbub init function

Mario Limonciello (6):
  drm/amd/display: Optimize custom brightness curve
  drm/amd/display: Adjust all dev_*() messages to drm_*()
  drm/amd/display: Move PSR support message into amdgpu_dm
  drm/amd/display: Remove double checks for
    `debug.enable_mem_low_power.bits.cm`
  drm/amd/display: Add HP Probook 445 and 465 to the quirk list for eDP
    on DP1
  drm/amd/display: Add HP Elitebook 645 to the quirk list for eDP on DP1

Sherry Wang (1):
  drm/amd/display: rename IPS2 entry/exit message

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.5.0
  drm/amd/display: Promote DC to 3.2.328

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 241 +++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  56 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |  41 ++-
 .../display/dc/clk_mgr/dcn35/dcn351_clk_mgr.c |   1 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   8 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  38 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  | 144 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_fused_io.h  |  31 +++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   8 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   9 +-
 .../display/dc/hubbub/dcn301/dcn301_hubbub.c  |  34 ++-
 .../display/dc/hubbub/dcn301/dcn301_hubbub.h  |   3 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 122 +++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   7 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   8 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  44 ----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   1 +
 .../link/protocols/link_edp_panel_control.c   |   2 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   4 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../display/modules/hdcp/hdcp2_execution.c    |  53 +++-
 .../display/modules/hdcp/hdcp2_transition.c   |  48 +++-
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  73 ++++++
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  38 ++-
 42 files changed, 934 insertions(+), 168 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_fused_io.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_fused_io.h

-- 
2.34.1

