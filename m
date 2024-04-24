Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45CCC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE4C113948;
	Wed, 24 Apr 2024 08:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24Pye3UH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62043113948
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8UV+3peZm7MlOekZHJE20AkyEwr4C+uBmFroIVIHiBKhmukB0fpm1+ib23xd84mHmx6x25opwplPpb6pv10/6lY8mcOF1xscj+pupzRRkX9ogrGhq3R6oql8zGQjuY7sIlGgDabgDr1PDV4hZGbpBaq87LjVZO2cSYq7sLgwR+Y46MZVT9zKiqQQ93Dgb/t0fiBNrB6EICzVBKVgnNmvUpVrEPWVOTeAwynsK40ybB50Fz3kUxDJBrGoVTViAy7oSIbl63j/KvZIUt+LfGGujTx4JTuoZsm2XorVcNXcpx5NYateLRP5a9nAz1q5qVNBY7skduqsZ0/AhxGvhbQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9VUQ7L2vuNd4Pz/GNatzh3sYlCOaAOVJZB4UCr06bg=;
 b=REN0Afd+IstMKMW6VIDmPlmLoONif97o04moEQ32J5Ry+w8dlVdHXyCi6nXp0rnpBCc0/Tf8/URa+9av7VUOdS1ljO2Q9+DEqnUP6OkYGlitGw5YVuzgj7rUtSimcclRGJg2lxJzouUGQZtKu/7Vt6dX7l+xaNl2h6KFTcz1dt8oFi2KwvYNdnJLcLigH6jhbx+EpXtfj4k8akEh+YjJD+cM9uCEp3aqTH89n87EKR3HmLvkxvjO6ieYx1crN8c0X9tuVrM/+Np72bZZlF6EvDVgrzV6grjbScqI0rOYr/MUZ+x28v3IN0lAftii36zpjzIZeHozU7pRz7ZofRkCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9VUQ7L2vuNd4Pz/GNatzh3sYlCOaAOVJZB4UCr06bg=;
 b=24Pye3UH0l5XnL3if17vlMAXEQcZSHXv1aQLfcdU8XdKBld7/NlelS8oq6o7428mSHGbRg6L5033SpWmaFIrpIzqkVQrbW5RvIZvtBgCoH1ibJy2YYv5kyJ/f2Y+jyvDbIqmg/uMRqzMu2FwaR6IMyiyuK4flb/tJyUJtmvLBnY=
Received: from BN9PR03CA0138.namprd03.prod.outlook.com (2603:10b6:408:fe::23)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:49:46 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::d8) by BN9PR03CA0138.outlook.office365.com
 (2603:10b6:408:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 08:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:49:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:49:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:49:44 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:49:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/46] DC Patches April 29, 2024
Date: Wed, 24 Apr 2024 16:48:45 +0800
Message-ID: <20240424084931.2656128-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df92ffe-18ee-439c-c9dd-08dc643b7df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TCunUYk54cvMf7PktVpTWvla0svAROaYg5PczTMvs6HpF+haQMGUyuJ1J6Gm?=
 =?us-ascii?Q?7euAB/QkWeSSXL0Taa+zaHeoI0ErdKycI+39Skrt0MtS1pHl4L9vVX3EnJLJ?=
 =?us-ascii?Q?A1ZkD45tnBX8rmAqtMROLQOaCWThdHvVyMRJzRU9DZlhoGTRhX8DLVDv3+rY?=
 =?us-ascii?Q?F20WS8TY6H7T/zU8XDz5iSVJ9j83FVC2k8vq6jhVZpos8udWgxnfcqtRZmqj?=
 =?us-ascii?Q?fA2URtB79syqBD7vF4t3JV5Qa7Wf2CFGF3tVkK0ZJ68Uuwh5pypMgg0QkltX?=
 =?us-ascii?Q?PuWfpOsCWhgx2Lr3/Ic3lk7kPHhKZinlGEZUR4XN7jvISId/23LnDTCoGEj2?=
 =?us-ascii?Q?qVniW8dJnBJ6ZakJxnGXr5r6KiPZEdgYejz/8LCuwNlo16iL3bPEsFxxQYFb?=
 =?us-ascii?Q?ORxTvvxVhlTAkgkRlP6bXdA+/SYFCKEaANz719hG46VMI9Kbw4O2U6s8rn6l?=
 =?us-ascii?Q?sBEu/CgzJCPDvjBYp4yU/wstAt8IDW0/3YovN88d9gvhjxFMPwmdTLELKpDO?=
 =?us-ascii?Q?M+EZAOr41QpTkxC5PY0NASzxp6lEOg2QfJpD6t7V+m4PmSmK3MEWkz2e0+iD?=
 =?us-ascii?Q?iemj+RJdvxty66J6azo2EVGGLdwbxwJUE4doDDv+yLhoiBrt9NJTmEmF4K1m?=
 =?us-ascii?Q?aWTBMXsS7/mM9frPc0IFQzP3cJQXNCsEyMt+dHfr2cx4+Z8Wa/gtUDZbvpYU?=
 =?us-ascii?Q?wGplZKjUgr7YWc/LFBGjyvUEzAcfSz0lMZtKrVxYelti22M8/Z0Zrhc5N3A7?=
 =?us-ascii?Q?LaU5uUsc7+frIvRoljJmxZahojEXUZZhgapgfDJjHuBcqJ++1pq/oEx20R1h?=
 =?us-ascii?Q?7iUCX2RzYwPJu5cAZaXpBF+50SfGX1tgWD6vOx13HtLZVfSOCesrevKGgzBI?=
 =?us-ascii?Q?ZZLSLOg1Ngrh8W7tya6DgAnklNylQkxH+CUKTfcIugLlhugnJ9xVM6TirtjR?=
 =?us-ascii?Q?yDmknDQhI8JmlhZ4w4PVxqHt+cD/jGo0tDpnrSvuyzIpLgPxMsqhZi3nwGPd?=
 =?us-ascii?Q?i69EDkoNn4Srbgln8xD/Klm8c8aCwNfDlqAez7diDUgr/xpaxWrQU21ZB/UX?=
 =?us-ascii?Q?253B5RrgT9IEx/+xT6BSfqqOhi4Zr4diW2ZPgz9nPqpBmIHGt2DVvU9G7U+v?=
 =?us-ascii?Q?TKW6gd7WsnRvvh4LF4gk1Vc9U1OrHqouH/8ElmhG+8GW7AaDHO1d/6mzJofh?=
 =?us-ascii?Q?Gx0f/oPgncpij51IwxmFJKqU5bXBnSvfUG3F8CmqM98K9L+n3OacTS5HFQPr?=
 =?us-ascii?Q?/Z4QmZfZ+baQV4a148JNLhtHYTXxm3GlmqVH6D9SveqJMfBlP1QZ7l50tWT6?=
 =?us-ascii?Q?ycq9kWEIBWciA0C97KPvKjBqunV45gar/VzHPKV+5iajilsFEb+9Wpv0GQFx?=
 =?us-ascii?Q?AJvlZco7d+3b1TDVUqdfmvZ5u+aS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:49:45.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df92ffe-18ee-439c-c9dd-08dc643b7df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

- Disable seamless boot on 128b/132b encoding
- Change ASSR disable sequence to avoid corruption
- Fix few IPS problems
- Enable Replay for DCN315
- Fix few ODM problems
- Fix FEC_READY write timing
- Fix few FPO problems
- Adjust DML21 gpuvm_enable assignment
- Fix divide by 0 error in VM environment
- Fix few DCN35 problems
- Fix flickering on DCN321
- Fix mst resume problem
- Fix multi-disp FAMS problem
- Refactor Replay
- Update some of the dcn303 parameters
- Enable legacy fast update for dcn301
- Add VCO parameter for DCN31 FPU
- Have cursor and surface updates together
- Fix problems reported by Coverity

---
Alex Hung (9):
  drm/amd/display: Check index msg_id before read or write
  drm/amd/display: Check pipe offset before setting vblank
  drm/amd/display: Skip finding free audio for unknown engine_id
  drm/amd/display: Do not return negative stream id for array
  drm/amd/display: ASSERT when failing to find index by plane/stream id
  drm/amd/display: Remove redundant include file
  drm/amd/display: Fix uninitialized variables in DM
  drm/amd/display: Fix uninitialized variables in DC
  drm/amd/display: Fix uninitialized variables in DC

Alvin Lee (3):
  drm/amd/display: Only program P-State force if pipe config changed
  drm/amd/display: Assign linear_pitch_alignment even for VM
  drm/amd/display: For FPO + Vactive check that all pipes support VA

Aric Cyr (1):
  drm/amd/display: 3.2.283

Daniel Miess (1):
  drm/amd/display: Enable RCO for PHYSYMCLK in DCN35

Dennis Chan (1):
  drm/amd/display: Refactor for Replay Link off frame count

Harry Wentland (2):
  drm/amd/display: Do cursor programming with rest of pipe
  drm/amd/display: Always use legacy way of setting cursor on DCE

Hersen Wu (2):
  drm/amd/display: Add NULL pointer check for kzalloc
  drm/amd/display: Fix overlapping copy within dml_core_mode_programming

Ilya Bakoulin (1):
  drm/amd/display: Fix FEC_READY write on DP LT

Iswara Nagulendran (1):
  drm/amd/display: Restrict multi-disp support for in-game FAMS

Joan Lee (1):
  drm/amd/display: Enable Replay for DCN315

Leo Ma (1):
  drm/amd/display: Fix DC mode screen flickering on DCN321

Nevenko Stupar (1):
  drm/amd/display: gpuvm handling in DML21

Nicholas Kazlauskas (2):
  drm/amd/display: Add trigger FIFO resync path for DCN35
  drm/amd/display: Notify idle link detection through shared state

Revalla Hari Krishna (1):
  drm/amd/display: Refactor HUBBUB into component folder

Rodrigo Siqueira (10):
  drm/amd/display: Improve registers write
  drm/amd/display: Add missing SMU version
  drm/amd/display: Adjust codestyle for dcn31 and hdcp_msg
  drm/amd/display: Add VCO speed parameter for DCN31 FPU
  drm/amd/display: Adjust functions prefix for some of the dcn301 fpu
    functions
  drm/amd/display: Enable legacy fast update for dcn301
  drm/amd/display: Update some of the dcn303 parameters
  drm/amd/display: Remove legacy code in DC
  drm/amd/display: Add log_color_state callback to multiple DCNs
  drm/amd/display: Handle the case which quad_part is equal 0

Roman Li (2):
  drm/amd/display: Re-enable IPS2 for static screen
  drm/amd/display: Add periodic detection for IPS

Sung Joon Kim (1):
  drm/amd/display: Disable seamless boot on 128b/132b encoding

Swapnil Patel (1):
  drm/amd/display: Change ASSR disable sequence

Wayne Lin (2):
  drm/amd/display: Remove unnecessary files
  drm/amd/display: Defer handling mst up request in resume

Webb Chen (1):
  drm/amd/display: Revert "dc: Keep VBios pixel rate div setting util
    next mode set"

Wenjing Liu (2):
  drm/amd/display: take ODM slice count into account when deciding DSC
    slice
  drm/amd/display: use even ODM slice width for two pixels per container

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 105 ++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  59 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  28 +++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../drm/amd/display/dc/bios/command_table.c   |   2 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   8 ++
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  23 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  24 +++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  14 +--
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  30 +++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  10 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  12 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../dc/dce110/dce110_timing_generator.c       |  18 +++
 .../dc/dce110/dce110_timing_generator.h       |   2 +
 .../dc/dce110/dce110_timing_generator_v.c     |   3 +-
 .../dc/dce120/dce120_timing_generator.c       |   1 +
 .../display/dc/dce80/dce80_timing_generator.c |   1 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  12 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  12 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  40 ++++++-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  63 +++--------
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  36 +++++-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |   3 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   4 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |   7 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  22 +---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  22 +++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   8 +-
 .../display/dc/dml2/dml2_translation_helper.c |   6 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/dpp/dcn10/CMakeLists.txt   |   6 -
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   5 +-
 .../amd/display/dc/dpp/dcn20/CMakeLists.txt   |   5 -
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn201/CMakeLists.txt  |   4 -
 .../amd/display/dc/dpp/dcn30/CMakeLists.txt   |   5 -
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   2 +-
 .../amd/display/dc/dpp/dcn32/CMakeLists.txt   |   4 -
 .../amd/display/dc/dpp/dcn35/CMakeLists.txt   |   4 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  30 +++--
 .../drm/amd/display/dc/gpio/gpio_service.c    |   6 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   2 +-
 .../gpu/drm/amd/display/dc/hubbub/Makefile    | 100 +++++++++++++++++
 .../dc/{ => hubbub}/dcn10/dcn10_hubbub.c      |   2 +-
 .../dc/{ => hubbub}/dcn10/dcn10_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn20/dcn20_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn20/dcn20_hubbub.h      |   2 +-
 .../dc/{ => hubbub}/dcn201/dcn201_hubbub.c    |   0
 .../dc/{ => hubbub}/dcn201/dcn201_hubbub.h    |   0
 .../dc/{ => hubbub}/dcn21/dcn21_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn21/dcn21_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn30/dcn30_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn30/dcn30_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn301/dcn301_hubbub.c    |   0
 .../dc/{ => hubbub}/dcn301/dcn301_hubbub.h    |   0
 .../dc/{ => hubbub}/dcn31/dcn31_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn31/dcn31_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn32/dcn32_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn32/dcn32_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn35/dcn35_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn35/dcn35_hubbub.h      |   0
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   6 -
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  28 +----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  42 ++++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   4 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  29 +----
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   4 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  68 +++++-------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  34 +++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   4 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 --
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 -
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   4 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 -
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../dc/irq/dce110/irq_service_dce110.c        |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  11 +-
 .../dc/link/protocols/link_dp_capability.c    |  16 +--
 .../dc/link/protocols/link_dp_irq_handler.c   |  10 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  14 +--
 .../dc/link/protocols/link_dp_training.c      |   2 +-
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../amd/display/dc/link/protocols/link_hpd.c  |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  46 ++++----
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  10 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   1 -
 .../amd/display/dc/optc/dcn201/dcn201_optc.c  |   7 +-
 .../amd/display/dc/optc/dcn201/dcn201_optc.h  |   3 -
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   3 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |   1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  15 ++-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   2 -
 .../display/dc/resource/dce80/CMakeLists.txt  |   4 -
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   5 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  20 +++-
 .../dc/resource/dcn303/dcn303_resource.c      |  13 ++-
 .../dc/resource/dcn31/dcn31_resource.c        |   5 +
 .../dc/resource/dcn314/dcn314_resource.c      |   5 +
 .../dc/resource/dcn315/dcn315_resource.c      |  14 +++
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   5 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  15 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +
 .../gpu/drm/amd/display/include/dal_types.h   |   1 -
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   8 ++
 .../amd/display/modules/power/power_helpers.c |   8 +-
 160 files changed, 952 insertions(+), 469 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn10/dcn10_hubbub.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn10/dcn10_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn20/dcn20_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn20/dcn20_hubbub.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn201/dcn201_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn201/dcn201_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn21/dcn21_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn21/dcn21_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn30/dcn30_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn30/dcn30_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn301/dcn301_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn301/dcn301_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn31/dcn31_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn31/dcn31_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn32/dcn32_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn32/dcn32_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn35/dcn35_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn35/dcn35_hubbub.h (100%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt

-- 
2.37.3

