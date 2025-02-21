Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A054EC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240710E2DF;
	Fri, 21 Feb 2025 16:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KoZ2WVS/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B1C10E2DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7PdX8X4tcQGWn7eVDO/FXR07+cfyUDz6oCh7SBI1Ap3XbXfsLklFV/e0NIAVjKedON0Nz8oDTeYNqYabGo2ZTpw5zv/Ti9zy4zApWCvnKQdRnQ+7pyInizTjjVXpzdXBPe8i3LfOnh2/sGPkzjLUTSzmFEoGLCStEsk2H7WQhTIbgAziP7kxdfyYE5nJK56pnFC36MVGv5i30ramApqc7Di3JglQn3YomlbL9zWKmVLRfHcdqikap1tJOhWl4tcf+pbd/iO+oxGNY12w+i3hfUTDxCKuePdxO/2UBC3J6B30rskWlx6wbaHYl+bMg0zkRVpwj2Dec5gqEy5lZ/eDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBp+Lx/TU/XiI/VNESlMuI8q/2MBmpMt6Kv/y6OWCAo=;
 b=hrJftZ/NNQoe8gwDFc6F8/vQw5algE+hTwIK13LjnDVMBOq4487fmu8BOMc0klmiay58Q4z5S8FWJsKCgqGaLT9Wjqsi/DWekubZlAsQfq8TsoeiwQIiSNWQpBXC+KHli4uXeP7xM6Oh52fCYWwj1W9Mq7CFGj5dsZW2Q80z5lqIXctKO6zK1/xbRa34PupaJH6S5/f6S+egU2Q6ZB5AeCioBiZgL7SEHtRNmOq6m2bOCNzjJ2uKaEBoKT6EEGP6VYkZda/ZT/tBs8PcYVoYjCAnT6cOEM0QbC85p0Kc1Kgiblwzxhd9gR0FkXreaJ6GaA9r5CubfDuVjKQZ+ElBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBp+Lx/TU/XiI/VNESlMuI8q/2MBmpMt6Kv/y6OWCAo=;
 b=KoZ2WVS/fGKikCmAUdTf2w8qYSnPqvGAOevkSeswIcUDTYz7s14ZHFNZgFh3dNEJV0BQnwBp9ZH2GwYu9P7faVNC74skc6vKRUCKYTSJTv0MSlJ4eq4wq0Ye5O+pMMWZba8+W51rZtuFLiotDb2RfgPu7Y0ysWOZzkip3xCUOwU=
Received: from PH7PR17CA0052.namprd17.prod.outlook.com (2603:10b6:510:325::19)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:02:03 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::14) by PH7PR17CA0052.outlook.office365.com
 (2603:10b6:510:325::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:01:59 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/24] DC Patches FEBRUARY 18, 2025 V3
Date: Fri, 21 Feb 2025 11:01:21 -0500
Message-ID: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c97292-faae-4510-3024-08dd529114f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SrSzpxmszC/nIziCbE+SaAqVJg9Ir5RzueIoJ7vEnpbpoZy2C8IAsf0qj5W+?=
 =?us-ascii?Q?c7odjEN2WsUpDD9KRYW4Oti7DAlXyC6J6KBHjxXVeG2ZPmjOx+G+M0xkxc7m?=
 =?us-ascii?Q?PxCuHRsfOsmzfX3/Vf90QQwhV/NZ19DNVpH+KBezVRIgX7Z8+nWxoV3FBqKF?=
 =?us-ascii?Q?59D0SFhtNl21RcGItwFXD0y/vEXXBSKaSHEgIfK+ewhD5H2FvaDt78HQkK3J?=
 =?us-ascii?Q?EmonEslu+xpgnaCDymrbK59e72av321YxiQQMlEfti0w8m56u0HuFAO8SyYl?=
 =?us-ascii?Q?NEEhrA4EqeXKYCuF9bq9RElfNSpgpufoyygRr0aBKDNwN9aTyV7Zr36Ozrqq?=
 =?us-ascii?Q?IV7Q4Pe077O9TBbAUYwasOqSRO6JlRYyBR6OTJ/SRoqAS6eta/AhA6tdTK/D?=
 =?us-ascii?Q?bcqy04IUlH91mSb2zag2TAGakiH6KB9m6KgfECFF8PplovkiW+GBrTGkrc2E?=
 =?us-ascii?Q?l0S4ZbABO3t4aid2XIaiYwhZ/2XxYqZ6jMHIeoVundeehPiIKCY3ArWOJkxC?=
 =?us-ascii?Q?+j6lHQGkV6HZ9doqXk18hewlTIVOGOLXBJKiUUZZyCX9+HGNtj7n7+K7LFuR?=
 =?us-ascii?Q?UmaEMHJ5vY68bZxNZx61XzSr5TRxwkq881QPlWqjb5g0g5a467fmy3HFmbWC?=
 =?us-ascii?Q?h2hhuHmoLm/9+cAyAsG7aT4l1n85rZkZ+LH+TJ51M0Gyg2rezrQd3pN1N6bT?=
 =?us-ascii?Q?xggtQlQLFMEQFJYue4zmCnD0UyxgAj+6bqpCsBOoVAMpWkRUB/3lMYPNJ7hV?=
 =?us-ascii?Q?edOec4Eyr6fqJvjpOiPCWNWGoNfv7EF1rivoGXV7/OIn+Ygb3EC5O+8ZQZUN?=
 =?us-ascii?Q?SqnE+mC08oVheVPcZLx4rlc9ETiv2rNunhY2S78Qa0rgGpAnSBDsoZlFkMkG?=
 =?us-ascii?Q?IMQQt6u7tVWmqCn7u+ncuvx/ZqZ1ZKs9bg0RaX4K7aPGD8/t8pjZNxVyAF9h?=
 =?us-ascii?Q?iZp55i4NGHSKyfVnkkDqo/P9oQ3qT4Tf9Ub3JUVvL4rp+gfQSutdNPDae0A/?=
 =?us-ascii?Q?UU1GNkNMkGZFJLgSA18Ar9jYp4m/66fj3V4g/2LMxQHt4ik2NKuJUVAtcE9R?=
 =?us-ascii?Q?iLYi64l4JVYvmC34hfH2V6AU+xErLGnCZp3WMn/jgarKnhyvHIz2kqIoxMHi?=
 =?us-ascii?Q?tscRJgGP0L4WSveEbjDnv8wrx6HqBaOQpEV1BwZvr2sMDM3VhZWEY9viZ5ff?=
 =?us-ascii?Q?g3TSWpnJYoPN817ulpk9Ey4zFbxCLXtccUEoyRCgjc8UBL+e3mwRex78ueZb?=
 =?us-ascii?Q?MJNUzJclvVniMoleidwqFfHt7viBeYbdTtxD2lp0FaeEvst+LmtCQjaEV6sY?=
 =?us-ascii?Q?7Ncu2tfIy9FHrbzz0KXyV60N1k79B8598yOApoOGK4YS9V9CV2wyD7tnwcSU?=
 =?us-ascii?Q?WvrVtx0OQEHDCpAbfXe8UOUrYs7+13B6bMgDrsrmxh/yfXT088oZj8vo4wqP?=
 =?us-ascii?Q?FYkotngLrd7ThndHtBAzICe1hJrz1aZissY+sgJRkbDdt4aaeGMOPBje+X0M?=
 =?us-ascii?Q?bco35/sCgTVoVUo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:03.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c97292-faae-4510-3024-08dd529114f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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
 
- Disable PSR-SU on eDP panels
- Fix HPD after GPU reset
- Fixes on dcn4x init, DML2 state policy on DCN36
- Various minor logic fixes
  
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: update incorrect cursor buffer size

Assadian, Navid (1):
  drm/amd/display: Fix mismatch type comparison

Aurabindo Pillai (1):
  drm/amd/display: Temporarily disable hostvm on DCN31

Charlene Liu (1):
  drm/amd/display: fix dcn4x init failed

Krunoslav Kovac (1):
  drm/amd/display: Remove unused header

Michael Strauss (1):
  drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage

Mike Katsnelson (1):
  drm/amd/display: stop DML2 from removing pipes based on planes

Navid Assadian (2):
  drm/amd/display: Add opp recout adjustment
  drm/amd/display: Add SPL namespace

Nicholas Kazlauskas (2):
  drm/amd/display: Apply DCN35 DML2 state policy for DCN36 too
  drm/amd/display: Increase halt timeout for DMCUB to 1s

Ostrowski, Rafal (1):
  drm/amd/display: ACPI Re-timer Programming

Patel, Swapnil (1):
  drm/amd/display: Refactor DCN4x and related code

Peichen Huang (1):
  drm/amd/display: replace dio encoder access

Roman Li (1):
  drm/amd/display: Fix HPD after gpu reset

Samson Tam (3):
  drm/amd/display: Fix mismatch type comparison in custom_float
  drm/amd/display: fix check for identity ratio
  drm/amd/display: Fix unit test failure

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.0.255.0
  drm/amd/display: Promote DAL to 3.2.322

Tom Chung (2):
  drm/amd/display: Revert "Disable PSR-SU on some OLED panel"
  drm/amd/display: Disable PSR-SU on eDP panels

Yihan Zhu (1):
  drm/amd/display: handle max_downscale_src_width fail check

Yilin Chen (1):
  drm/amd/display: add a quirk to enable eDP0 on DP1

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  76 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  14 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  23 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  56 ++++-
 .../display/dc/bios/command_table_helper2.c   |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   8 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  94 ++++----
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   5 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   2 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   5 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   7 +
 .../drm/amd/display/dc/dm_services_types.h    |  26 +++
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  26 ---
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   3 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    | 148 ++++++------
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c  |  10 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h  |   6 +
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |   3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   5 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  66 +++++-
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |   5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  20 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 .../dc/link/protocols/link_dp_capability.c    |  33 ++-
 .../dc/link/protocols/link_dp_capability.h    |   1 +
 .../display/dc/link/protocols/link_dp_phy.c   |  16 +-
 .../display/dc/link/protocols/link_dp_phy.h   |   3 +-
 .../dc/link/protocols/link_dp_training.c      |  20 +-
 .../dc/link/protocols/link_dp_training.h      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   4 +-
 .../protocols/link_dp_training_128b_132b.h    |   1 +
 .../link/protocols/link_dp_training_8b_10b.c  |   5 +-
 .../link/protocols/link_dp_training_8b_10b.h  |   3 +-
 .../link/protocols/link_dp_training_auxless.c |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |   3 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  31 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 221 +++++++++---------
 .../dc/resource/dcn20/dcn20_resource.c        |   5 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  71 ++++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h  |  16 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  12 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |   2 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  76 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  15 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   2 +-
 59 files changed, 813 insertions(+), 406 deletions(-)

-- 
2.34.1

