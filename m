Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3B1CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2E710E6FF;
	Wed, 22 Oct 2025 07:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OltdmX8B";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5D910E6FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWSKyveNqMv4dnnmMwxzYVDNlCj7uk0Nu2QklMjLozS9tYX5qdxvz0HM2Ase1ts2c0P5nnpzXESw5XgcOhO//PC2eHPFotNEPu/ptuNl41R/TenXJgi5q+s5ZSThLQ7MdJ0m+SKnkZiRPbvR0Nyjvi8fpfNfSvyVb8snfW3rDgLSHNe75xhjo4MLRgdvpP70FIrNeck0a8jRcpbbHmYpRpb6BKcg+f6XCpWUSiiHE5Dy1T+1h8brkSzvTDORVe6U7lZR0rw3AE5ovRmso6oGG9YnhPDYz9CBvfa1QJTiyAusXagywVnC+cIHSIowTD1DOEHzqdaSJ+aDsnvGbZ58sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5vj3qo0AMDUzm2XpKCwIFHnc/UUdARfDzgOlvayPRY=;
 b=oyfSh74y8r+wbm79iWTHCYQ1V7a3sNhvWSa7Xz6fcfdhz5KlEU2fk6llfHXQgHLwty3+tcLjepxIrk9gsH0S6Kt7Yvi0F+LHq0USA/biR6NPA6jWsRjUlrw7TQN9JhqHwH24UouRWp8eoTiOMdCaB9fw9uGKnZibRGLlVufdaW/F3O9r1TEJyHt+5wR8Hl4MTc/M+53wV8zf62t5hd3dq9S9mEf0sfFv63/ZpZAC/4STEuOHL9GYmegybGiW7XIJcyqja55p3Lb60VU3A1uBdN3bU4W4izGB8FnQVd9lEqG/POm15xJ+HAdo4O9BJaqaQfMeWY/W3PRy94XW6KDr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5vj3qo0AMDUzm2XpKCwIFHnc/UUdARfDzgOlvayPRY=;
 b=OltdmX8B7dpv+escsUBT33eg/mE0O+x/fO69CrTbv56QSvOAmBMxJs7BJWgaSEOshxu/mYwgzE1AFWT74cIcsenUrtjsSanBqhTHV/DT8SJ5QSGC6lTtw2WbU+5NbHTOnSB8tRE3Db4MVgMDcYA0cgkBU53NHkoyKHKdAwby/Ig=
Received: from DS7PR03CA0252.namprd03.prod.outlook.com (2603:10b6:5:3b3::17)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 07:34:45 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::51) by DS7PR03CA0252.outlook.office365.com
 (2603:10b6:5:3b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 07:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:34:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 00:34:44 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Oct
 2025 02:34:43 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:34:40 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Karen Chen <Karen.Chen@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 09/20] drm/amd/display: Add more DC HW state info to underflow
 logging
Date: Wed, 22 Oct 2025 15:30:21 +0800
Message-ID: <20251022073332.666119-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: bb281674-a2a2-432e-8678-08de113d78d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fsDNoKD/xTVoN6RAYxhE5x6LBo46Hcpiy+8AWsdfkeyAYw7MyduJtjes0H+Y?=
 =?us-ascii?Q?yXv97cACHerodMb7y1QKOfj10JCx7QzXfniZdVJI8dAldo51Mb12gIw7rEU8?=
 =?us-ascii?Q?P6uJrEhSW+OF0pMdM817GwMH/7VsaJrPlFpwYm1h002DpP2spxTEhkbYzGb7?=
 =?us-ascii?Q?bKP5iiHGEMMSQ8Ax2j62Z9KYFGwbZZMbRS6G7i6hWOO9teCsat0BdVVxYSjd?=
 =?us-ascii?Q?dJSVrjRno7XWM4B9AkreOC0iqOwSNuXfYNqjDZjd7qyzGFJn54v/PBWR94i/?=
 =?us-ascii?Q?9Sly8xkTtEM+WvbM2ayAhzA0+y75t6ngVAVz1bG7Ou8EyrPukz96i8FmlV8a?=
 =?us-ascii?Q?ayXd8polwU24L90+pgXh+Ja651wNRzwrfM6yaQbvNNgjauTv7xcBSDM9MPi3?=
 =?us-ascii?Q?8O8et6FApcflUYmwbW83KVUkHDoJXsZs0xVFGDGkA4LGO2+55c9C64a8vaS3?=
 =?us-ascii?Q?za8iTog26HxBKq58bt2NRI1iYS2cxKiht4v0QXbt140fYWIIZ5PTJeulvuDX?=
 =?us-ascii?Q?9p8uqKyjZRJY/+kuLFozTVUbv81S+EkUuq13+eXMGHd9dhvRhQIdK9YyyyXP?=
 =?us-ascii?Q?Dska6s0cDJN1iiJZRuvtJK9atgNivO9iAb44+QkE349hNvWIt2rS9K/YncWU?=
 =?us-ascii?Q?nD3pbRdd0T66d7/pQ5r66euiu3fF3xh/Ar+FXESt4NYDP270qDTKppsWxEsz?=
 =?us-ascii?Q?VuFRVMv3zBS+LDbWRb6dApN/VeR2UcPnfNQS8OIyasTLogziGxrn8KDMkgio?=
 =?us-ascii?Q?JOpsm06Ri6hpmU7WkO/3dQxSTmVojrdbZlccT3zPLTbcFQNZk9QpOKLnq3hg?=
 =?us-ascii?Q?8we4mzR9zCv6iW1MK6zEFG1RXRcgdFXCXe6FtO9JjqflkD6ql6y95YnC7lmg?=
 =?us-ascii?Q?n4kg9+AE/LJdi4u8tv8yQ45Sjk3A3bSpZvr+2xEUm+6+SPQKUusgI0oQbhT4?=
 =?us-ascii?Q?VGwDecGGw3Hwrc2I9AKDPdEvdGphTBXfTCa2L1M7s2FIvwnHbMrXxyhGE5/R?=
 =?us-ascii?Q?w4t3sdpwGnbZJU3MYtwfh97lK+GxdyjOSv8DA92v35CQuI8LuZOtli3f0ac+?=
 =?us-ascii?Q?Z6gKE60EcyNFUNFWv8FP/OSV6uHpIurC5OoWmH7UtdAU0NRc7JrJ/riHeRTO?=
 =?us-ascii?Q?Ib+b6GUwGxZhqDQv26P5BufDYpsRhyI9Yb6bj3yjFwb/0cNubGpbK1Vh5EQW?=
 =?us-ascii?Q?lyx6LsbsN6uy/qvEsJUQdYcaic8FiV5L456qWav/2DjXc/WarEeMfmNC3I6z?=
 =?us-ascii?Q?b0rcpvy4BrIlEw3dvJ6m39f2hW6g0qsk+bYajujNE8+i7f2vAubBWBBiJUsU?=
 =?us-ascii?Q?NB66dLNJ83F9YD13MqBqhQ0A/Ypwx0KBmWRRcRHYajQs7Xa1eibC7RibcdmL?=
 =?us-ascii?Q?eEMVBbnyDPeewVV+YKITwziSDrAaUmsoItFsKP+C2TMev2LHNlbaNGce63pg?=
 =?us-ascii?Q?yMFNKGMUNsM5ipPYdy1blbcecT/bz2VrfGP5PxLWoRG1ShP+Izd6Xer7OrZ9?=
 =?us-ascii?Q?uE+scgO7pBOV15eF+22vGf63K5msFx3S9m1tD0p01ZUYLffqA0dbw6/PlSEM?=
 =?us-ascii?Q?ufmypA3qFXYf82yL6CcCL2huPcNojP9JUyuPpFlc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:34:45.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb281674-a2a2-432e-8678-08de113d78d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

From: Karen Chen <Karen.Chen@amd.com>

[Why]
Debugging underflow issues frequently requires knowing the
HW state at the time of underflow. To enable capturing this
HW state information, interface functions are needed for the
various DC HW blocks.

[How]
This change adds the interface functions to read HW state for
the following DC HW blocks:
- HUBBUB
- HUBP
- DPP
- MPC
- OPP
- DSC
- OPTC
- DCCG

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Karen Chen <Karen.Chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  30 ++--
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  64 +++++++-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    | 123 +++++++++++++++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   2 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   3 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.h  |   3 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  16 ++
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   2 +
 .../drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   1 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   8 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |   1 +
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   5 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  33 +---
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |   6 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   3 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    | 136 +++++++++++++++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   8 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 147 ++++++++++++++----
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  76 ++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 121 +++++++++++++-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  12 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  27 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  13 ++
 .../amd/display/dc/inc/hw/timing_generator.h  | 130 ++++++++++++++++
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
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  38 ++++-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 131 ++++++++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   2 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 59 files changed, 1133 insertions(+), 150 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 769b2c2f9d7f..ea629c06ec53 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -54,6 +54,14 @@ struct abm_save_restore;
 struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
+struct dcn_hubbub_reg_state;
+struct dcn_hubp_reg_state;
+struct dcn_dpp_reg_state;
+struct dcn_mpc_reg_state;
+struct dcn_opp_reg_state;
+struct dcn_dsc_reg_state;
+struct dcn_optc_reg_state;
+struct dcn_dccg_reg_state;
 
 #define DC_VER "3.2.355"
 
@@ -1831,20 +1839,14 @@ struct dc_surface_update {
 };
 
 struct dc_underflow_debug_data {
-	uint32_t otg_inst;
-	uint32_t otg_underflow;
-	uint32_t h_position;
-	uint32_t v_position;
-	uint32_t otg_frame_count;
-	struct dc_underflow_per_hubp_debug_data {
-		uint32_t hubp_underflow;
-		uint32_t hubp_in_blank;
-		uint32_t hubp_readline;
-		uint32_t det_config_error;
-	} hubps[MAX_PIPES];
-	uint32_t curr_det_sizes[MAX_PIPES];
-	uint32_t target_det_sizes[MAX_PIPES];
-	uint32_t compbuf_config_error;
+	struct dcn_hubbub_reg_state *hubbub_reg_state;
+	struct dcn_hubp_reg_state *hubp_reg_state[MAX_PIPES];
+	struct dcn_dpp_reg_state *dpp_reg_state[MAX_PIPES];
+	struct dcn_mpc_reg_state *mpc_reg_state[MAX_PIPES];
+	struct dcn_opp_reg_state *opp_reg_state[MAX_PIPES];
+	struct dcn_dsc_reg_state *dsc_reg_state[MAX_PIPES];
+	struct dcn_optc_reg_state *optc_reg_state[MAX_PIPES];
+	struct dcn_dccg_reg_state *dccg_reg_state[MAX_PIPES];
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index a9b88f5e0c04..8bdffd9ff31b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -425,7 +425,69 @@ struct dccg_mask {
 	uint32_t SYMCLKD_CLOCK_ENABLE; \
 	uint32_t SYMCLKE_CLOCK_ENABLE; \
 	uint32_t DP_DTO_MODULO[MAX_PIPES]; \
-	uint32_t DP_DTO_PHASE[MAX_PIPES]
+	uint32_t DP_DTO_PHASE[MAX_PIPES]; \
+	uint32_t DC_MEM_GLOBAL_PWR_REQ_CNTL; \
+	uint32_t DCCG_AUDIO_DTO0_MODULE; \
+	uint32_t DCCG_AUDIO_DTO0_PHASE; \
+	uint32_t DCCG_AUDIO_DTO1_MODULE; \
+	uint32_t DCCG_AUDIO_DTO1_PHASE; \
+	uint32_t DCCG_CAC_STATUS; \
+	uint32_t DCCG_CAC_STATUS2; \
+	uint32_t DCCG_DISP_CNTL_REG; \
+	uint32_t DCCG_DS_CNTL; \
+	uint32_t DCCG_DS_DTO_INCR; \
+	uint32_t DCCG_DS_DTO_MODULO; \
+	uint32_t DCCG_DS_HW_CAL_INTERVAL; \
+	uint32_t DCCG_GTC_CNTL; \
+	uint32_t DCCG_GTC_CURRENT; \
+	uint32_t DCCG_GTC_DTO_INCR; \
+	uint32_t DCCG_GTC_DTO_MODULO; \
+	uint32_t DCCG_PERFMON_CNTL; \
+	uint32_t DCCG_PERFMON_CNTL2; \
+	uint32_t DCCG_SOFT_RESET; \
+	uint32_t DCCG_TEST_CLK_SEL; \
+	uint32_t DCCG_VSYNC_CNT_CTRL; \
+	uint32_t DCCG_VSYNC_CNT_INT_CTRL; \
+	uint32_t DCCG_VSYNC_OTG0_LATCH_VALUE; \
+	uint32_t DCCG_VSYNC_OTG1_LATCH_VALUE; \
+	uint32_t DCCG_VSYNC_OTG2_LATCH_VALUE; \
+	uint32_t DCCG_VSYNC_OTG3_LATCH_VALUE; \
+	uint32_t DCCG_VSYNC_OTG4_LATCH_VALUE; \
+	uint32_t DCCG_VSYNC_OTG5_LATCH_VALUE; \
+	uint32_t DISPCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t DP_DTO_DBUF_EN; \
+	uint32_t DPIACLK_540M_DTO_MODULO; \
+	uint32_t DPIACLK_540M_DTO_PHASE; \
+	uint32_t DPIACLK_810M_DTO_MODULO; \
+	uint32_t DPIACLK_810M_DTO_PHASE; \
+	uint32_t DPIACLK_DTO_CNTL; \
+	uint32_t DPIASYMCLK_CNTL; \
+	uint32_t DPPCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t DPREFCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t DPREFCLK_CNTL; \
+	uint32_t DTBCLK_DTO_DBUF_EN; \
+	uint32_t FORCE_SYMCLK_DISABLE; \
+	uint32_t HDMICHARCLK0_CLOCK_CNTL; \
+	uint32_t MICROSECOND_TIME_BASE_DIV; \
+	uint32_t MILLISECOND_TIME_BASE_DIV; \
+	uint32_t OTG0_PHYPLL_PIXEL_RATE_CNTL; \
+	uint32_t OTG0_PIXEL_RATE_CNTL; \
+	uint32_t OTG1_PHYPLL_PIXEL_RATE_CNTL; \
+	uint32_t OTG1_PIXEL_RATE_CNTL; \
+	uint32_t OTG2_PHYPLL_PIXEL_RATE_CNTL; \
+	uint32_t OTG2_PIXEL_RATE_CNTL; \
+	uint32_t OTG3_PHYPLL_PIXEL_RATE_CNTL; \
+	uint32_t OTG3_PIXEL_RATE_CNTL; \
+	uint32_t PHYPLLA_PIXCLK_RESYNC_CNTL; \
+	uint32_t PHYPLLB_PIXCLK_RESYNC_CNTL; \
+	uint32_t PHYPLLC_PIXCLK_RESYNC_CNTL; \
+	uint32_t PHYPLLD_PIXCLK_RESYNC_CNTL; \
+	uint32_t PHYPLLE_PIXCLK_RESYNC_CNTL; \
+	uint32_t REFCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t SOCCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t SYMCLK_CGTT_BLK_CTRL_REG; \
+	uint32_t SYMCLK_PSP_CNTL
+
 struct dccg_registers {
 	DCCG_REG_VARIABLE_LIST;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index 8664f0c4c9b7..97df04b7e39d 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -709,6 +709,128 @@ void dccg31_otg_drop_pixel(struct dccg *dccg,
 			OTG_DROP_PIXEL[otg_inst], 1);
 }
 
+void dccg31_read_reg_state(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	dccg_reg_state->dc_mem_global_pwr_req_cntl = REG_READ(DC_MEM_GLOBAL_PWR_REQ_CNTL);
+	dccg_reg_state->dccg_audio_dtbclk_dto_modulo = REG_READ(DCCG_AUDIO_DTBCLK_DTO_MODULO);
+	dccg_reg_state->dccg_audio_dtbclk_dto_phase = REG_READ(DCCG_AUDIO_DTBCLK_DTO_PHASE);
+	dccg_reg_state->dccg_audio_dto_source = REG_READ(DCCG_AUDIO_DTO_SOURCE);
+	dccg_reg_state->dccg_audio_dto0_module = REG_READ(DCCG_AUDIO_DTO0_MODULE);
+	dccg_reg_state->dccg_audio_dto0_phase = REG_READ(DCCG_AUDIO_DTO0_PHASE);
+	dccg_reg_state->dccg_audio_dto1_module = REG_READ(DCCG_AUDIO_DTO1_MODULE);
+	dccg_reg_state->dccg_audio_dto1_phase = REG_READ(DCCG_AUDIO_DTO1_PHASE);
+	dccg_reg_state->dccg_cac_status = REG_READ(DCCG_CAC_STATUS);
+	dccg_reg_state->dccg_cac_status2 = REG_READ(DCCG_CAC_STATUS2);
+	dccg_reg_state->dccg_disp_cntl_reg = REG_READ(DCCG_DISP_CNTL_REG);
+	dccg_reg_state->dccg_ds_cntl = REG_READ(DCCG_DS_CNTL);
+	dccg_reg_state->dccg_ds_dto_incr = REG_READ(DCCG_DS_DTO_INCR);
+	dccg_reg_state->dccg_ds_dto_modulo = REG_READ(DCCG_DS_DTO_MODULO);
+	dccg_reg_state->dccg_ds_hw_cal_interval = REG_READ(DCCG_DS_HW_CAL_INTERVAL);
+	dccg_reg_state->dccg_gate_disable_cntl = REG_READ(DCCG_GATE_DISABLE_CNTL);
+	dccg_reg_state->dccg_gate_disable_cntl2 = REG_READ(DCCG_GATE_DISABLE_CNTL2);
+	dccg_reg_state->dccg_gate_disable_cntl3 = REG_READ(DCCG_GATE_DISABLE_CNTL3);
+	dccg_reg_state->dccg_gate_disable_cntl4 = REG_READ(DCCG_GATE_DISABLE_CNTL4);
+	dccg_reg_state->dccg_gate_disable_cntl5 = REG_READ(DCCG_GATE_DISABLE_CNTL5);
+	dccg_reg_state->dccg_gate_disable_cntl6 = REG_READ(DCCG_GATE_DISABLE_CNTL6);
+	dccg_reg_state->dccg_global_fgcg_rep_cntl = REG_READ(DCCG_GLOBAL_FGCG_REP_CNTL);
+	dccg_reg_state->dccg_gtc_cntl = REG_READ(DCCG_GTC_CNTL);
+	dccg_reg_state->dccg_gtc_current = REG_READ(DCCG_GTC_CURRENT);
+	dccg_reg_state->dccg_gtc_dto_incr = REG_READ(DCCG_GTC_DTO_INCR);
+	dccg_reg_state->dccg_gtc_dto_modulo = REG_READ(DCCG_GTC_DTO_MODULO);
+	dccg_reg_state->dccg_perfmon_cntl = REG_READ(DCCG_PERFMON_CNTL);
+	dccg_reg_state->dccg_perfmon_cntl2 = REG_READ(DCCG_PERFMON_CNTL2);
+	dccg_reg_state->dccg_soft_reset = REG_READ(DCCG_SOFT_RESET);
+	dccg_reg_state->dccg_test_clk_sel = REG_READ(DCCG_TEST_CLK_SEL);
+	dccg_reg_state->dccg_vsync_cnt_ctrl = REG_READ(DCCG_VSYNC_CNT_CTRL);
+	dccg_reg_state->dccg_vsync_cnt_int_ctrl = REG_READ(DCCG_VSYNC_CNT_INT_CTRL);
+	dccg_reg_state->dccg_vsync_otg0_latch_value = REG_READ(DCCG_VSYNC_OTG0_LATCH_VALUE);
+	dccg_reg_state->dccg_vsync_otg1_latch_value = REG_READ(DCCG_VSYNC_OTG1_LATCH_VALUE);
+	dccg_reg_state->dccg_vsync_otg2_latch_value = REG_READ(DCCG_VSYNC_OTG2_LATCH_VALUE);
+	dccg_reg_state->dccg_vsync_otg3_latch_value = REG_READ(DCCG_VSYNC_OTG3_LATCH_VALUE);
+	dccg_reg_state->dccg_vsync_otg4_latch_value = REG_READ(DCCG_VSYNC_OTG4_LATCH_VALUE);
+	dccg_reg_state->dccg_vsync_otg5_latch_value = REG_READ(DCCG_VSYNC_OTG5_LATCH_VALUE);
+	dccg_reg_state->dispclk_cgtt_blk_ctrl_reg = REG_READ(DISPCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->dispclk_freq_change_cntl = REG_READ(DISPCLK_FREQ_CHANGE_CNTL);
+	dccg_reg_state->dp_dto_dbuf_en = REG_READ(DP_DTO_DBUF_EN);
+	dccg_reg_state->dp_dto0_modulo = REG_READ(DP_DTO_MODULO[0]);
+	dccg_reg_state->dp_dto0_phase = REG_READ(DP_DTO_PHASE[0]);
+	dccg_reg_state->dp_dto1_modulo = REG_READ(DP_DTO_MODULO[1]);
+	dccg_reg_state->dp_dto1_phase = REG_READ(DP_DTO_PHASE[1]);
+	dccg_reg_state->dp_dto2_modulo = REG_READ(DP_DTO_MODULO[2]);
+	dccg_reg_state->dp_dto2_phase = REG_READ(DP_DTO_PHASE[2]);
+	dccg_reg_state->dp_dto3_modulo = REG_READ(DP_DTO_MODULO[3]);
+	dccg_reg_state->dp_dto3_phase = REG_READ(DP_DTO_PHASE[3]);
+	dccg_reg_state->dpiaclk_540m_dto_modulo = REG_READ(DPIACLK_540M_DTO_MODULO);
+	dccg_reg_state->dpiaclk_540m_dto_phase = REG_READ(DPIACLK_540M_DTO_PHASE);
+	dccg_reg_state->dpiaclk_810m_dto_modulo = REG_READ(DPIACLK_810M_DTO_MODULO);
+	dccg_reg_state->dpiaclk_810m_dto_phase = REG_READ(DPIACLK_810M_DTO_PHASE);
+	dccg_reg_state->dpiaclk_dto_cntl = REG_READ(DPIACLK_DTO_CNTL);
+	dccg_reg_state->dpiasymclk_cntl = REG_READ(DPIASYMCLK_CNTL);
+	dccg_reg_state->dppclk_cgtt_blk_ctrl_reg = REG_READ(DPPCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->dppclk_ctrl = REG_READ(DPPCLK_CTRL);
+	dccg_reg_state->dppclk_dto_ctrl = REG_READ(DPPCLK_DTO_CTRL);
+	dccg_reg_state->dppclk0_dto_param = REG_READ(DPPCLK_DTO_PARAM[0]);
+	dccg_reg_state->dppclk1_dto_param = REG_READ(DPPCLK_DTO_PARAM[1]);
+	dccg_reg_state->dppclk2_dto_param = REG_READ(DPPCLK_DTO_PARAM[2]);
+	dccg_reg_state->dppclk3_dto_param = REG_READ(DPPCLK_DTO_PARAM[3]);
+	dccg_reg_state->dprefclk_cgtt_blk_ctrl_reg = REG_READ(DPREFCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->dprefclk_cntl = REG_READ(DPREFCLK_CNTL);
+	dccg_reg_state->dpstreamclk_cntl = REG_READ(DPSTREAMCLK_CNTL);
+	dccg_reg_state->dscclk_dto_ctrl = REG_READ(DSCCLK_DTO_CTRL);
+	dccg_reg_state->dscclk0_dto_param = REG_READ(DSCCLK0_DTO_PARAM);
+	dccg_reg_state->dscclk1_dto_param = REG_READ(DSCCLK1_DTO_PARAM);
+	dccg_reg_state->dscclk2_dto_param = REG_READ(DSCCLK2_DTO_PARAM);
+	dccg_reg_state->dscclk3_dto_param = REG_READ(DSCCLK3_DTO_PARAM);
+	dccg_reg_state->dtbclk_dto_dbuf_en = REG_READ(DTBCLK_DTO_DBUF_EN);
+	dccg_reg_state->dtbclk_dto0_modulo = REG_READ(DTBCLK_DTO_MODULO[0]);
+	dccg_reg_state->dtbclk_dto0_phase = REG_READ(DTBCLK_DTO_PHASE[0]);
+	dccg_reg_state->dtbclk_dto1_modulo = REG_READ(DTBCLK_DTO_MODULO[1]);
+	dccg_reg_state->dtbclk_dto1_phase = REG_READ(DTBCLK_DTO_PHASE[1]);
+	dccg_reg_state->dtbclk_dto2_modulo = REG_READ(DTBCLK_DTO_MODULO[2]);
+	dccg_reg_state->dtbclk_dto2_phase = REG_READ(DTBCLK_DTO_PHASE[2]);
+	dccg_reg_state->dtbclk_dto3_modulo = REG_READ(DTBCLK_DTO_MODULO[3]);
+	dccg_reg_state->dtbclk_dto3_phase = REG_READ(DTBCLK_DTO_PHASE[3]);
+	dccg_reg_state->dtbclk_p_cntl = REG_READ(DTBCLK_P_CNTL);
+	dccg_reg_state->force_symclk_disable = REG_READ(FORCE_SYMCLK_DISABLE);
+	dccg_reg_state->hdmicharclk0_clock_cntl = REG_READ(HDMICHARCLK0_CLOCK_CNTL);
+	dccg_reg_state->hdmistreamclk_cntl = REG_READ(HDMISTREAMCLK_CNTL);
+	dccg_reg_state->hdmistreamclk0_dto_param = REG_READ(HDMISTREAMCLK0_DTO_PARAM);
+	dccg_reg_state->microsecond_time_base_div = REG_READ(MICROSECOND_TIME_BASE_DIV);
+	dccg_reg_state->millisecond_time_base_div = REG_READ(MILLISECOND_TIME_BASE_DIV);
+	dccg_reg_state->otg_pixel_rate_div = REG_READ(OTG_PIXEL_RATE_DIV);
+	dccg_reg_state->otg0_phypll_pixel_rate_cntl = REG_READ(OTG0_PHYPLL_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg0_pixel_rate_cntl = REG_READ(OTG0_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg1_phypll_pixel_rate_cntl = REG_READ(OTG1_PHYPLL_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg1_pixel_rate_cntl = REG_READ(OTG1_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg2_phypll_pixel_rate_cntl = REG_READ(OTG2_PHYPLL_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg2_pixel_rate_cntl = REG_READ(OTG2_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg3_phypll_pixel_rate_cntl = REG_READ(OTG3_PHYPLL_PIXEL_RATE_CNTL);
+	dccg_reg_state->otg3_pixel_rate_cntl = REG_READ(OTG3_PIXEL_RATE_CNTL);
+	dccg_reg_state->phyasymclk_clock_cntl = REG_READ(PHYASYMCLK_CLOCK_CNTL);
+	dccg_reg_state->phybsymclk_clock_cntl = REG_READ(PHYBSYMCLK_CLOCK_CNTL);
+	dccg_reg_state->phycsymclk_clock_cntl = REG_READ(PHYCSYMCLK_CLOCK_CNTL);
+	dccg_reg_state->phydsymclk_clock_cntl = REG_READ(PHYDSYMCLK_CLOCK_CNTL);
+	dccg_reg_state->phyesymclk_clock_cntl = REG_READ(PHYESYMCLK_CLOCK_CNTL);
+	dccg_reg_state->phyplla_pixclk_resync_cntl = REG_READ(PHYPLLA_PIXCLK_RESYNC_CNTL);
+	dccg_reg_state->phypllb_pixclk_resync_cntl = REG_READ(PHYPLLB_PIXCLK_RESYNC_CNTL);
+	dccg_reg_state->phypllc_pixclk_resync_cntl = REG_READ(PHYPLLC_PIXCLK_RESYNC_CNTL);
+	dccg_reg_state->phyplld_pixclk_resync_cntl = REG_READ(PHYPLLD_PIXCLK_RESYNC_CNTL);
+	dccg_reg_state->phyplle_pixclk_resync_cntl = REG_READ(PHYPLLE_PIXCLK_RESYNC_CNTL);
+	dccg_reg_state->refclk_cgtt_blk_ctrl_reg = REG_READ(REFCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->socclk_cgtt_blk_ctrl_reg = REG_READ(SOCCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->symclk_cgtt_blk_ctrl_reg = REG_READ(SYMCLK_CGTT_BLK_CTRL_REG);
+	dccg_reg_state->symclk_psp_cntl = REG_READ(SYMCLK_PSP_CNTL);
+	dccg_reg_state->symclk32_le_cntl = REG_READ(SYMCLK32_LE_CNTL);
+	dccg_reg_state->symclk32_se_cntl = REG_READ(SYMCLK32_SE_CNTL);
+	dccg_reg_state->symclka_clock_enable = REG_READ(SYMCLKA_CLOCK_ENABLE);
+	dccg_reg_state->symclkb_clock_enable = REG_READ(SYMCLKB_CLOCK_ENABLE);
+	dccg_reg_state->symclkc_clock_enable = REG_READ(SYMCLKC_CLOCK_ENABLE);
+	dccg_reg_state->symclkd_clock_enable = REG_READ(SYMCLKD_CLOCK_ENABLE);
+	dccg_reg_state->symclke_clock_enable = REG_READ(SYMCLKE_CLOCK_ENABLE);
+}
+
 static const struct dccg_funcs dccg31_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
@@ -727,6 +849,7 @@ static const struct dccg_funcs dccg31_funcs = {
 	.set_dispclk_change_mode = dccg31_set_dispclk_change_mode,
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
+	.dccg_read_reg_state = dccg31_read_reg_state,
 };
 
 struct dccg *dccg31_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
index cd261051dc2c..bf659920d4cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h
@@ -236,4 +236,6 @@ void dccg31_disable_dscclk(struct dccg *dccg, int inst);
 
 void dccg31_enable_dscclk(struct dccg *dccg, int inst);
 
+void dccg31_read_reg_state(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
+
 #endif //__DCN31_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index 8f6edd8e9beb..ef3db6beba25 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -377,7 +377,8 @@ static const struct dccg_funcs dccg314_funcs = {
 	.get_pixel_rate_div = dccg314_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
-	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src
+	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src,
+	.dccg_read_reg_state = dccg31_read_reg_state
 };
 
 struct dccg *dccg314_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
index 60ea1d248deb..a609635f35db 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h
@@ -74,8 +74,7 @@
 	SR(DCCG_GATE_DISABLE_CNTL3),\
 	SR(HDMISTREAMCLK0_DTO_PARAM),\
 	SR(OTG_PIXEL_RATE_DIV),\
-	SR(DTBCLK_P_CNTL),\
-	SR(DCCG_AUDIO_DTO_SOURCE)
+	SR(DTBCLK_P_CNTL)
 
 #define DCCG_MASK_SH_LIST_DCN314_COMMON(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 0aa41759f79d..bd2f528137b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -2453,6 +2453,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
 	.dccg_root_gate_disable_control = dccg35_root_gate_disable_control,
+	.dccg_read_reg_state = dccg31_read_reg_state,
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index ad7a5850d31b..7b9c36456cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -41,8 +41,9 @@
 	SR(SYMCLKA_CLOCK_ENABLE),\
 	SR(SYMCLKB_CLOCK_ENABLE),\
 	SR(SYMCLKC_CLOCK_ENABLE),\
-	SR(SYMCLKD_CLOCK_ENABLE),\
-	SR(SYMCLKE_CLOCK_ENABLE)
+	SR(SYMCLKD_CLOCK_ENABLE), \
+	SR(SYMCLKE_CLOCK_ENABLE),\
+	SR(SYMCLK_PSP_CNTL)
 
 #define DCCG_MASK_SH_LIST_DCN35(mask_sh) \
 	DCCG_SFI(DPPCLK_DTO_CTRL, DTO_DB_EN, DPPCLK, 0, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 0b8ed9b94d3c..663a18ee5162 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -886,6 +886,7 @@ static const struct dccg_funcs dccg401_funcs = {
 	.enable_symclk_se = dccg401_enable_symclk_se,
 	.disable_symclk_se = dccg401_disable_symclk_se,
 	.set_dtbclk_p_src = dccg401_set_dtbclk_p_src,
+	.dccg_read_reg_state = dccg31_read_reg_state
 };
 
 struct dccg *dccg401_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
index f466182963f7..b12f34345a58 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h
@@ -1348,7 +1348,8 @@ struct dcn_dpp_mask {
 	uint32_t CURSOR0_COLOR1; \
 	uint32_t DPP_CONTROL; \
 	uint32_t CM_HDR_MULT_COEF; \
-	uint32_t CURSOR0_FP_SCALE_BIAS;
+	uint32_t CURSOR0_FP_SCALE_BIAS; \
+	uint32_t OBUF_CONTROL;
 
 struct dcn_dpp_registers {
 	DPP_COMMON_REG_VARIABLE_LIST
@@ -1450,7 +1451,6 @@ void dpp1_set_degamma(
 void dpp1_set_degamma_pwl(struct dpp *dpp_base,
 		const struct pwl_params *params);
 
-
 void dpp_read_state(struct dpp *dpp_base,
 		struct dcn_dpp_state *s);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 94d0dc3461d2..fdc8789bb5d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -84,6 +84,22 @@ void dpp30_read_state(struct dpp *dpp_base, struct dcn_dpp_state *s)
 	}
 }
 
+void dpp30_read_reg_state(struct dpp *dpp_base, struct dcn_dpp_reg_state *dpp_reg_state)
+{
+	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
+
+	dpp_reg_state->recout_start = REG_READ(RECOUT_START);
+	dpp_reg_state->recout_size = REG_READ(RECOUT_SIZE);
+	dpp_reg_state->scl_horz_filter_scale_ratio = REG_READ(SCL_HORZ_FILTER_SCALE_RATIO);
+	dpp_reg_state->scl_vert_filter_scale_ratio = REG_READ(SCL_VERT_FILTER_SCALE_RATIO);
+	dpp_reg_state->scl_mode = REG_READ(SCL_MODE);
+	dpp_reg_state->cm_control = REG_READ(CM_CONTROL);
+	dpp_reg_state->dpp_control = REG_READ(DPP_CONTROL);
+	dpp_reg_state->dscl_control = REG_READ(DSCL_CONTROL);
+	dpp_reg_state->obuf_control = REG_READ(OBUF_CONTROL);
+	dpp_reg_state->mpc_size = REG_READ(MPC_SIZE);
+}
+
 /*program post scaler scs block in dpp CM*/
 void dpp3_program_post_csc(
 		struct dpp *dpp_base,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index f236824126e9..d4a70b4379ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -594,6 +594,8 @@ void dpp3_program_CM_dealpha(
 void dpp30_read_state(struct dpp *dpp_base,
 		struct dcn_dpp_state *s);
 
+void dpp30_read_reg_state(struct dpp *dpp_base, struct dcn_dpp_reg_state *dpp_reg_state);
+
 bool dpp3_get_optimal_number_of_taps(
 		struct dpp *dpp,
 		struct scaler_data *scl_data,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
index fa67e54bf94e..8a5aa5e86850 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c
@@ -134,6 +134,7 @@ static struct dpp_funcs dcn32_dpp_funcs = {
 	.dpp_dppclk_control			= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
 	.dpp_get_gamut_remap		= dpp3_cm_get_gamut_remap,
+	.dpp_read_reg_state			= dpp30_read_reg_state,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
index f7a373a3d70a..977d83bf7741 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c
@@ -95,6 +95,7 @@ void dpp35_program_bias_and_scale_fcnv(
 static struct dpp_funcs dcn35_dpp_funcs = {
 	.dpp_program_gamcor_lut		= dpp3_program_gamcor_lut,
 	.dpp_read_state				= dpp30_read_state,
+	.dpp_read_reg_state			= dpp30_read_reg_state,
 	.dpp_reset					= dpp_reset,
 	.dpp_set_scaler				= dpp1_dscl_set_scaler_manual_scale,
 	.dpp_get_optimal_number_of_taps	= dpp3_get_optimal_number_of_taps,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 36187f890d5d..96c2c853de42 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -248,6 +248,7 @@ static struct dpp_funcs dcn401_dpp_funcs = {
 	.set_optional_cursor_attributes	= dpp401_set_optional_cursor_attributes,
 	.dpp_dppclk_control			= dpp1_dppclk_control,
 	.dpp_set_hdr_multiplier		= dpp3_set_hdr_multiplier,
+	.dpp_read_reg_state			= dpp30_read_reg_state,
 	.set_cursor_matrix			= dpp401_set_cursor_matrix,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index ee8c11e085cd..242f1e6f0d8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -35,6 +35,7 @@ static void dsc_write_to_registers(struct display_stream_compressor *dsc, const
 static const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
+	.dsc_read_reg_state = dsc2_read_reg_state,
 	.dsc_validate_stream = dsc2_validate_stream,
 	.dsc_set_config = dsc2_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
@@ -155,6 +156,13 @@ void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state
 		DSCRM_DSC_OPP_PIPE_SOURCE, &s->dsc_opp_source);
 }
 
+void dsc2_read_reg_state(struct display_stream_compressor *dsc, struct dcn_dsc_reg_state *dccg_reg_state)
+{
+	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+
+	dccg_reg_state->dsc_top_control = REG_READ(DSC_TOP_CONTROL);
+	dccg_reg_state->dscc_interrupt_control_status = REG_READ(DSCC_INTERRUPT_CONTROL_STATUS);
+}
 
 bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
index a9c04fc95bd1..2337c3a97235 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h
@@ -606,6 +606,7 @@ bool dsc2_get_packed_pps(struct display_stream_compressor *dsc,
 		uint8_t *dsc_packed_pps);
 
 void dsc2_read_state(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
+void dsc2_read_reg_state(struct display_stream_compressor *dsc, struct dcn_dsc_reg_state *dccg_reg_state);
 bool dsc2_validate_stream(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
 void dsc2_set_config(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 		struct dsc_optc_config *dsc_optc_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
index 6f4f5a3c4861..f9c6377ac66c 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c
@@ -32,6 +32,7 @@ static void dsc35_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static const struct dsc_funcs dcn35_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
 	.dsc_read_state = dsc2_read_state,
+	.dsc_read_reg_state = dsc2_read_reg_state,
 	.dsc_validate_stream = dsc2_validate_stream,
 	.dsc_set_config = dsc2_set_config,
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
index 7bd92ae8b13e..c1bdbb38c690 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c
@@ -26,6 +26,7 @@ static const struct dsc_funcs dcn401_dsc_funcs = {
 	.dsc_disconnect = dsc401_disconnect,
 	.dsc_wait_disconnect_pending_clear = dsc401_wait_disconnect_pending_clear,
 	.dsc_get_single_enc_caps = dsc401_get_single_enc_caps,
+	.dsc_read_reg_state = dsc2_read_reg_state
 };
 
 /* Macro definitios for REG_SET macros*/
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index b433e16842bf..81c83d5fe042 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -66,6 +66,10 @@ struct dcn_dsc_state {
 	uint32_t dsc_opp_source;
 };
 
+struct dcn_dsc_reg_state {
+	uint32_t dsc_top_control;
+	uint32_t dscc_interrupt_control_status;
+};
 
 /* DSC encoder capabilities
  * They differ from the DPCD DSC caps because they are based on AMD DSC encoder caps.
@@ -100,6 +104,7 @@ struct dsc_enc_caps {
 struct dsc_funcs {
 	void (*dsc_get_enc_caps)(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock_100Hz);
 	void (*dsc_read_state)(struct display_stream_compressor *dsc, struct dcn_dsc_state *s);
+	void (*dsc_read_reg_state)(struct display_stream_compressor *dsc, struct dcn_dsc_reg_state *dccg_reg_state);
 	bool (*dsc_validate_stream)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg);
 	void (*dsc_set_config)(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg,
 			struct dsc_optc_config *dsc_optc_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
index e7e5f6d4778e..181a93dc46e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
@@ -440,33 +440,15 @@ void hubbub3_init_watermarks(struct hubbub *hubbub)
 	REG_WRITE(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, reg);
 }
 
-void hubbub3_get_det_sizes(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes)
+void hubbub3_read_reg_state(struct hubbub *hubbub, struct dcn_hubbub_reg_state *hubbub_reg_state)
 {
 	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
 
-	REG_GET_2(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, &curr_det_sizes[0],
-		DET0_SIZE, &target_det_sizes[0]);
-
-	REG_GET_2(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, &curr_det_sizes[1],
-		DET1_SIZE, &target_det_sizes[1]);
-
-	REG_GET_2(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, &curr_det_sizes[2],
-		DET2_SIZE, &target_det_sizes[2]);
-
-	REG_GET_2(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, &curr_det_sizes[3],
-		DET3_SIZE, &target_det_sizes[3]);
-
-}
-
-uint32_t hubbub3_compbuf_config_error(struct hubbub *hubbub)
-{
-	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
-	uint32_t compbuf_config_error = 0;
-
-	REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR,
-		&compbuf_config_error);
-
-	return compbuf_config_error;
+	hubbub_reg_state->det0_ctrl = REG_READ(DCHUBBUB_DET0_CTRL);
+	hubbub_reg_state->det1_ctrl = REG_READ(DCHUBBUB_DET1_CTRL);
+	hubbub_reg_state->det2_ctrl = REG_READ(DCHUBBUB_DET2_CTRL);
+	hubbub_reg_state->det3_ctrl = REG_READ(DCHUBBUB_DET3_CTRL);
+	hubbub_reg_state->compbuf_ctrl = REG_READ(DCHUBBUB_COMPBUF_CTRL);
 }
 
 static const struct hubbub_funcs hubbub30_funcs = {
@@ -486,8 +468,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub3_init_watermarks,
 	.hubbub_read_state = hubbub2_read_state,
-	.get_det_sizes = hubbub3_get_det_sizes,
-	.compbuf_config_error = hubbub3_compbuf_config_error,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
index 49a469969d36..9e14de3ccaee 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
@@ -133,10 +133,6 @@ void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
 
 void hubbub3_init_watermarks(struct hubbub *hubbub);
 
-void hubbub3_get_det_sizes(struct hubbub *hubbub,
-	uint32_t *curr_det_sizes,
-	uint32_t *target_det_sizes);
-
-uint32_t hubbub3_compbuf_config_error(struct hubbub *hubbub);
+void hubbub3_read_reg_state(struct hubbub *hubbub, struct dcn_hubbub_reg_state *hubbub_reg_state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
index cdb20251a154..d1aaa58b7db3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
@@ -1071,8 +1071,7 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
-	.get_det_sizes = hubbub3_get_det_sizes,
-	.compbuf_config_error = hubbub3_compbuf_config_error,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub31,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
index 4d4ca6d77bbd..237331b35378 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
@@ -1037,8 +1037,7 @@ static const struct hubbub_funcs hubbub32_funcs = {
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
 	.set_request_limit = hubbub32_set_request_limit,
 	.get_mall_en = hubbub32_get_mall_en,
-	.get_det_sizes = hubbub3_get_det_sizes,
-	.compbuf_config_error = hubbub3_compbuf_config_error,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
index a443722a8632..1b7746a6549a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
@@ -589,8 +589,7 @@ static const struct hubbub_funcs hubbub35_funcs = {
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
 	.dchubbub_init = hubbub35_init,
-	.get_det_sizes = hubbub3_get_det_sizes,
-	.compbuf_config_error = hubbub3_compbuf_config_error,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub35_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index a36273a52880..d11afd1ce72a 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1247,8 +1247,7 @@ static const struct hubbub_funcs hubbub4_01_funcs = {
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
 	.program_arbiter = dcn401_program_arbiter,
-	.get_det_sizes = hubbub3_get_det_sizes,
-	.compbuf_config_error = hubbub3_compbuf_config_error,
+	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
 void hubbub401_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index cf2eb9793008..f2571076fc50 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -105,7 +105,9 @@
 	SRI(DCN_CUR0_TTU_CNTL0, HUBPREQ, id),\
 	SRI(DCN_CUR0_TTU_CNTL1, HUBPREQ, id),\
 	SRI(HUBP_CLK_CNTL, HUBP, id),\
-	SRI(HUBPRET_READ_LINE_VALUE, HUBPRET, id)
+	SRI(HUBPRET_READ_LINE_VALUE, HUBPRET, id),\
+	SRI(HUBP_MEASURE_WIN_CTRL_DCFCLK, HUBP, id),\
+	SRI(HUBP_MEASURE_WIN_CTRL_DPPCLK, HUBP, id)
 
 /* Register address initialization macro for ASICs with VM */
 #define HUBP_REG_LIST_DCN_VM(id)\
@@ -251,7 +253,19 @@
 	uint32_t CURSOR_HOT_SPOT; \
 	uint32_t CURSOR_DST_OFFSET; \
 	uint32_t HUBP_CLK_CNTL; \
-	uint32_t HUBPRET_READ_LINE_VALUE
+	uint32_t HUBPRET_READ_LINE_VALUE; \
+	uint32_t HUBP_MEASURE_WIN_CTRL_DCFCLK; \
+	uint32_t HUBP_MEASURE_WIN_CTRL_DPPCLK; \
+	uint32_t HUBPRET_INTERRUPT; \
+	uint32_t HUBPRET_MEM_PWR_CTRL; \
+	uint32_t HUBPRET_MEM_PWR_STATUS; \
+	uint32_t HUBPRET_READ_LINE_CTRL0; \
+	uint32_t HUBPRET_READ_LINE_CTRL1; \
+	uint32_t HUBPRET_READ_LINE0; \
+	uint32_t HUBPRET_READ_LINE1; \
+	uint32_t HUBPREQ_MEM_PWR_CTRL; \
+	uint32_t HUBPREQ_MEM_PWR_STATUS
+
 
 #define HUBP_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
@@ -688,6 +702,123 @@ struct dcn_fl_regs_st {
 	uint32_t lut_fl_mode;
 	uint32_t lut_fl_format;
 };
+struct dcn_hubp_reg_state {
+	uint32_t hubp_cntl;
+	uint32_t mall_config;
+	uint32_t mall_sub_vp;
+	uint32_t hubp_req_size_config;
+	uint32_t hubp_req_size_config_c;
+	uint32_t vmpg_config;
+	uint32_t addr_config;
+	uint32_t pri_viewport_dimension;
+	uint32_t pri_viewport_dimension_c;
+	uint32_t pri_viewport_start;
+	uint32_t pri_viewport_start_c;
+	uint32_t sec_viewport_dimension;
+	uint32_t sec_viewport_dimension_c;
+	uint32_t sec_viewport_start;
+	uint32_t sec_viewport_start_c;
+	uint32_t surface_config;
+	uint32_t tiling_config;
+	uint32_t clk_cntl;
+	uint32_t mall_status;
+	uint32_t measure_win_ctrl_dcfclk;
+	uint32_t measure_win_ctrl_dppclk;
+
+	uint32_t blank_offset_0;
+	uint32_t blank_offset_1;
+	uint32_t cursor_settings;
+	uint32_t dcn_cur0_ttu_cntl0;
+	uint32_t dcn_cur0_ttu_cntl1;
+	uint32_t dcn_cur1_ttu_cntl0;
+	uint32_t dcn_cur1_ttu_cntl1;
+	uint32_t dcn_dmdat_vm_cntl;
+	uint32_t dcn_expansion_mode;
+	uint32_t dcn_global_ttu_cntl;
+	uint32_t dcn_surf0_ttu_cntl0;
+	uint32_t dcn_surf0_ttu_cntl1;
+	uint32_t dcn_surf1_ttu_cntl0;
+	uint32_t dcn_surf1_ttu_cntl1;
+	uint32_t dcn_ttu_qos_wm;
+	uint32_t dcn_vm_mx_l1_tlb_cntl;
+	uint32_t dcn_vm_system_aperture_high_addr;
+	uint32_t dcn_vm_system_aperture_low_addr;
+	uint32_t dcsurf_flip_control;
+	uint32_t dcsurf_flip_control2;
+	uint32_t dcsurf_primary_meta_surface_address;
+	uint32_t dcsurf_primary_meta_surface_address_c;
+	uint32_t dcsurf_primary_meta_surface_address_high;
+	uint32_t dcsurf_primary_meta_surface_address_high_c;
+	uint32_t dcsurf_primary_surface_address;
+	uint32_t dcsurf_primary_surface_address_c;
+	uint32_t dcsurf_primary_surface_address_high;
+	uint32_t dcsurf_primary_surface_address_high_c;
+	uint32_t dcsurf_secondary_meta_surface_address;
+	uint32_t dcsurf_secondary_meta_surface_address_c;
+	uint32_t dcsurf_secondary_meta_surface_address_high;
+	uint32_t dcsurf_secondary_meta_surface_address_high_c;
+	uint32_t dcsurf_secondary_surface_address;
+	uint32_t dcsurf_secondary_surface_address_c;
+	uint32_t dcsurf_secondary_surface_address_high;
+	uint32_t dcsurf_secondary_surface_address_high_c;
+	uint32_t dcsurf_surface_control;
+	uint32_t dcsurf_surface_earliest_inuse;
+	uint32_t dcsurf_surface_earliest_inuse_c;
+	uint32_t dcsurf_surface_earliest_inuse_high;
+	uint32_t dcsurf_surface_earliest_inuse_high_c;
+	uint32_t dcsurf_surface_flip_interrupt;
+	uint32_t dcsurf_surface_inuse;
+	uint32_t dcsurf_surface_inuse_c;
+	uint32_t dcsurf_surface_inuse_high;
+	uint32_t dcsurf_surface_inuse_high_c;
+	uint32_t dcsurf_surface_pitch;
+	uint32_t dcsurf_surface_pitch_c;
+	uint32_t dst_after_scaler;
+	uint32_t dst_dimensions;
+	uint32_t dst_y_delta_drq_limit;
+	uint32_t flip_parameters_0;
+	uint32_t flip_parameters_1;
+	uint32_t flip_parameters_2;
+	uint32_t flip_parameters_3;
+	uint32_t flip_parameters_4;
+	uint32_t flip_parameters_5;
+	uint32_t flip_parameters_6;
+	uint32_t hubpreq_mem_pwr_ctrl;
+	uint32_t hubpreq_mem_pwr_status;
+	uint32_t nom_parameters_0;
+	uint32_t nom_parameters_1;
+	uint32_t nom_parameters_2;
+	uint32_t nom_parameters_3;
+	uint32_t nom_parameters_4;
+	uint32_t nom_parameters_5;
+	uint32_t nom_parameters_6;
+	uint32_t nom_parameters_7;
+	uint32_t per_line_delivery;
+	uint32_t per_line_delivery_pre;
+	uint32_t prefetch_settings;
+	uint32_t prefetch_settings_c;
+	uint32_t ref_freq_to_pix_freq;
+	uint32_t uclk_pstate_force;
+	uint32_t vblank_parameters_0;
+	uint32_t vblank_parameters_1;
+	uint32_t vblank_parameters_2;
+	uint32_t vblank_parameters_3;
+	uint32_t vblank_parameters_4;
+	uint32_t vblank_parameters_5;
+	uint32_t vblank_parameters_6;
+	uint32_t vmid_settings_0;
+
+	uint32_t hubpret_control;
+	uint32_t hubpret_interrupt;
+	uint32_t hubpret_mem_pwr_ctrl;
+	uint32_t hubpret_mem_pwr_status;
+	uint32_t hubpret_read_line_ctrl0;
+	uint32_t hubpret_read_line_ctrl1;
+	uint32_t hubpret_read_line_status;
+	uint32_t hubpret_read_line_value;
+	uint32_t hubpret_read_line0;
+	uint32_t hubpret_read_line1;
+};
 
 struct dcn_hubp_state {
 	struct _vcs_dpi_display_dlg_regs_st dlg_attr;
@@ -718,7 +849,6 @@ struct dcn_hubp_state {
 	uint32_t hubp_cntl;
 	uint32_t flip_control;
 };
-
 struct dcn10_hubp {
 	struct hubp base;
 	struct dcn_hubp_state state;
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index f325db555102..7062e6653062 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -145,7 +145,8 @@
 	uint32_t FLIP_PARAMETERS_2;\
 	uint32_t DCN_CUR1_TTU_CNTL0;\
 	uint32_t DCN_CUR1_TTU_CNTL1;\
-	uint32_t VMID_SETTINGS_0
+	uint32_t VMID_SETTINGS_0;\
+	uint32_t DST_Y_DELTA_DRQ_LIMIT
 
 /*shared with dcn3.x*/
 #define DCN21_HUBP_REG_COMMON_VARIABLE_LIST \
@@ -176,7 +177,10 @@
 	uint32_t HUBP_3DLUT_CONTROL;\
 	uint32_t HUBP_3DLUT_DLG_PARAM;\
 	uint32_t DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE;\
-	uint32_t DCHUBP_MCACHEID_CONFIG
+	uint32_t DCHUBP_MCACHEID_CONFIG;\
+	uint32_t DCHUBP_MALL_SUB_VP;\
+	uint32_t DCHUBP_ADDR_CONFIG;\
+	uint32_t HUBP_MALL_STATUS
 
 #define DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type) \
 	DCN_HUBP_REG_FIELD_BASE_LIST(type); \
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 556214b2227d..0cc6f4558989 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -476,6 +476,126 @@ void hubp3_read_state(struct hubp *hubp)
 
 }
 
+void hubp3_read_reg_state(struct hubp *hubp, struct dcn_hubp_reg_state *reg_state)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	reg_state->hubp_cntl = REG_READ(DCHUBP_CNTL);
+	reg_state->mall_config = REG_READ(DCHUBP_MALL_CONFIG);
+	reg_state->mall_sub_vp = REG_READ(DCHUBP_MALL_SUB_VP);
+	reg_state->hubp_req_size_config = REG_READ(DCHUBP_REQ_SIZE_CONFIG);
+	reg_state->hubp_req_size_config_c = REG_READ(DCHUBP_REQ_SIZE_CONFIG_C);
+	reg_state->vmpg_config = REG_READ(DCHUBP_VMPG_CONFIG);
+	reg_state->addr_config = REG_READ(DCSURF_ADDR_CONFIG);
+	reg_state->pri_viewport_dimension = REG_READ(DCSURF_PRI_VIEWPORT_DIMENSION);
+	reg_state->pri_viewport_dimension_c = REG_READ(DCSURF_PRI_VIEWPORT_DIMENSION_C);
+	reg_state->pri_viewport_start = REG_READ(DCSURF_PRI_VIEWPORT_START);
+	reg_state->pri_viewport_start_c = REG_READ(DCSURF_PRI_VIEWPORT_START_C);
+	reg_state->sec_viewport_dimension = REG_READ(DCSURF_SEC_VIEWPORT_DIMENSION);
+	reg_state->sec_viewport_dimension_c = REG_READ(DCSURF_SEC_VIEWPORT_DIMENSION_C);
+	reg_state->sec_viewport_start = REG_READ(DCSURF_SEC_VIEWPORT_START);
+	reg_state->sec_viewport_start_c = REG_READ(DCSURF_SEC_VIEWPORT_START_C);
+	reg_state->surface_config = REG_READ(DCSURF_SURFACE_CONFIG);
+	reg_state->tiling_config = REG_READ(DCSURF_TILING_CONFIG);
+	reg_state->clk_cntl = REG_READ(HUBP_CLK_CNTL);
+	reg_state->mall_status = REG_READ(HUBP_MALL_STATUS);
+	reg_state->measure_win_ctrl_dcfclk = REG_READ(HUBP_MEASURE_WIN_CTRL_DCFCLK);
+	reg_state->measure_win_ctrl_dppclk = REG_READ(HUBP_MEASURE_WIN_CTRL_DPPCLK);
+
+	reg_state->blank_offset_0 = REG_READ(BLANK_OFFSET_0);
+	reg_state->blank_offset_1 = REG_READ(BLANK_OFFSET_1);
+	reg_state->cursor_settings = REG_READ(CURSOR_SETTINGS);
+	reg_state->dcn_cur0_ttu_cntl0 = REG_READ(DCN_CUR0_TTU_CNTL0);
+	reg_state->dcn_cur0_ttu_cntl1 = REG_READ(DCN_CUR0_TTU_CNTL1);
+	reg_state->dcn_cur1_ttu_cntl0 = REG_READ(DCN_CUR1_TTU_CNTL0);
+	reg_state->dcn_cur1_ttu_cntl1 = REG_READ(DCN_CUR1_TTU_CNTL1);
+	reg_state->dcn_dmdat_vm_cntl = REG_READ(DCN_DMDATA_VM_CNTL);
+	reg_state->dcn_expansion_mode = REG_READ(DCN_EXPANSION_MODE);
+	reg_state->dcn_global_ttu_cntl = REG_READ(DCN_GLOBAL_TTU_CNTL);
+	reg_state->dcn_surf0_ttu_cntl0 = REG_READ(DCN_SURF0_TTU_CNTL0);
+	reg_state->dcn_surf0_ttu_cntl1 = REG_READ(DCN_SURF0_TTU_CNTL1);
+	reg_state->dcn_surf1_ttu_cntl0 = REG_READ(DCN_SURF1_TTU_CNTL0);
+	reg_state->dcn_surf1_ttu_cntl1 = REG_READ(DCN_SURF1_TTU_CNTL1);
+	reg_state->dcn_ttu_qos_wm = REG_READ(DCN_TTU_QOS_WM);
+	reg_state->dcn_vm_mx_l1_tlb_cntl = REG_READ(DCN_VM_MX_L1_TLB_CNTL);
+	reg_state->dcn_vm_system_aperture_high_addr = REG_READ(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR);
+	reg_state->dcn_vm_system_aperture_low_addr = REG_READ(DCN_VM_SYSTEM_APERTURE_LOW_ADDR);
+	reg_state->dcsurf_flip_control = REG_READ(DCSURF_FLIP_CONTROL);
+	reg_state->dcsurf_flip_control2 = REG_READ(DCSURF_FLIP_CONTROL2);
+	reg_state->dcsurf_primary_meta_surface_address = REG_READ(DCSURF_PRIMARY_META_SURFACE_ADDRESS);
+	reg_state->dcsurf_primary_meta_surface_address_c = REG_READ(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C);
+	reg_state->dcsurf_primary_meta_surface_address_high = REG_READ(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH);
+	reg_state->dcsurf_primary_meta_surface_address_high_c = REG_READ(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C);
+	reg_state->dcsurf_primary_surface_address = REG_READ(DCSURF_PRIMARY_SURFACE_ADDRESS);
+	reg_state->dcsurf_primary_surface_address_c = REG_READ(DCSURF_PRIMARY_SURFACE_ADDRESS_C);
+	reg_state->dcsurf_primary_surface_address_high = REG_READ(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH);
+	reg_state->dcsurf_primary_surface_address_high_c = REG_READ(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C);
+	reg_state->dcsurf_secondary_meta_surface_address = REG_READ(DCSURF_SECONDARY_META_SURFACE_ADDRESS);
+	reg_state->dcsurf_secondary_meta_surface_address_c = REG_READ(DCSURF_SECONDARY_META_SURFACE_ADDRESS_C);
+	reg_state->dcsurf_secondary_meta_surface_address_high = REG_READ(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH);
+	reg_state->dcsurf_secondary_meta_surface_address_high_c = REG_READ(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH_C);
+	reg_state->dcsurf_secondary_surface_address = REG_READ(DCSURF_SECONDARY_SURFACE_ADDRESS);
+	reg_state->dcsurf_secondary_surface_address_c = REG_READ(DCSURF_SECONDARY_SURFACE_ADDRESS_C);
+	reg_state->dcsurf_secondary_surface_address_high = REG_READ(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH);
+	reg_state->dcsurf_secondary_surface_address_high_c = REG_READ(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH_C);
+	reg_state->dcsurf_surface_control = REG_READ(DCSURF_SURFACE_CONTROL);
+	reg_state->dcsurf_surface_earliest_inuse = REG_READ(DCSURF_SURFACE_EARLIEST_INUSE);
+	reg_state->dcsurf_surface_earliest_inuse_c = REG_READ(DCSURF_SURFACE_EARLIEST_INUSE_C);
+	reg_state->dcsurf_surface_earliest_inuse_high = REG_READ(DCSURF_SURFACE_EARLIEST_INUSE_HIGH);
+	reg_state->dcsurf_surface_earliest_inuse_high_c = REG_READ(DCSURF_SURFACE_EARLIEST_INUSE_HIGH_C);
+	reg_state->dcsurf_surface_flip_interrupt = REG_READ(DCSURF_SURFACE_FLIP_INTERRUPT);
+	reg_state->dcsurf_surface_inuse = REG_READ(DCSURF_SURFACE_INUSE);
+	reg_state->dcsurf_surface_inuse_c = REG_READ(DCSURF_SURFACE_INUSE_C);
+	reg_state->dcsurf_surface_inuse_high = REG_READ(DCSURF_SURFACE_INUSE_HIGH);
+	reg_state->dcsurf_surface_inuse_high_c = REG_READ(DCSURF_SURFACE_INUSE_HIGH_C);
+	reg_state->dcsurf_surface_pitch = REG_READ(DCSURF_SURFACE_PITCH);
+	reg_state->dcsurf_surface_pitch_c = REG_READ(DCSURF_SURFACE_PITCH_C);
+	reg_state->dst_after_scaler = REG_READ(DST_AFTER_SCALER);
+	reg_state->dst_dimensions = REG_READ(DST_DIMENSIONS);
+	reg_state->dst_y_delta_drq_limit = REG_READ(DST_Y_DELTA_DRQ_LIMIT);
+	reg_state->flip_parameters_0 = REG_READ(FLIP_PARAMETERS_0);
+	reg_state->flip_parameters_1 = REG_READ(FLIP_PARAMETERS_1);
+	reg_state->flip_parameters_2 = REG_READ(FLIP_PARAMETERS_2);
+	reg_state->flip_parameters_3 = REG_READ(FLIP_PARAMETERS_3);
+	reg_state->flip_parameters_4 = REG_READ(FLIP_PARAMETERS_4);
+	reg_state->flip_parameters_5 = REG_READ(FLIP_PARAMETERS_5);
+	reg_state->flip_parameters_6 = REG_READ(FLIP_PARAMETERS_6);
+	reg_state->hubpreq_mem_pwr_ctrl = REG_READ(HUBPREQ_MEM_PWR_CTRL);
+	reg_state->hubpreq_mem_pwr_status = REG_READ(HUBPREQ_MEM_PWR_STATUS);
+	reg_state->nom_parameters_0 = REG_READ(NOM_PARAMETERS_0);
+	reg_state->nom_parameters_1 = REG_READ(NOM_PARAMETERS_1);
+	reg_state->nom_parameters_2 = REG_READ(NOM_PARAMETERS_2);
+	reg_state->nom_parameters_3 = REG_READ(NOM_PARAMETERS_3);
+	reg_state->nom_parameters_4 = REG_READ(NOM_PARAMETERS_4);
+	reg_state->nom_parameters_5 = REG_READ(NOM_PARAMETERS_5);
+	reg_state->nom_parameters_6 = REG_READ(NOM_PARAMETERS_6);
+	reg_state->nom_parameters_7 = REG_READ(NOM_PARAMETERS_7);
+	reg_state->per_line_delivery = REG_READ(PER_LINE_DELIVERY);
+	reg_state->per_line_delivery_pre = REG_READ(PER_LINE_DELIVERY_PRE);
+	reg_state->prefetch_settings = REG_READ(PREFETCH_SETTINGS);
+	reg_state->prefetch_settings_c = REG_READ(PREFETCH_SETTINGS_C);
+	reg_state->ref_freq_to_pix_freq = REG_READ(REF_FREQ_TO_PIX_FREQ);
+	reg_state->uclk_pstate_force = REG_READ(UCLK_PSTATE_FORCE);
+	reg_state->vblank_parameters_0 = REG_READ(VBLANK_PARAMETERS_0);
+	reg_state->vblank_parameters_1 = REG_READ(VBLANK_PARAMETERS_1);
+	reg_state->vblank_parameters_2 = REG_READ(VBLANK_PARAMETERS_2);
+	reg_state->vblank_parameters_3 = REG_READ(VBLANK_PARAMETERS_3);
+	reg_state->vblank_parameters_4 = REG_READ(VBLANK_PARAMETERS_4);
+	reg_state->vblank_parameters_5 = REG_READ(VBLANK_PARAMETERS_5);
+	reg_state->vblank_parameters_6 = REG_READ(VBLANK_PARAMETERS_6);
+	reg_state->vmid_settings_0 = REG_READ(VMID_SETTINGS_0);
+	reg_state->hubpret_control = REG_READ(HUBPRET_CONTROL);
+	reg_state->hubpret_interrupt = REG_READ(HUBPRET_INTERRUPT);
+	reg_state->hubpret_mem_pwr_ctrl = REG_READ(HUBPRET_MEM_PWR_CTRL);
+	reg_state->hubpret_mem_pwr_status = REG_READ(HUBPRET_MEM_PWR_STATUS);
+	reg_state->hubpret_read_line_ctrl0 = REG_READ(HUBPRET_READ_LINE_CTRL0);
+	reg_state->hubpret_read_line_ctrl1 = REG_READ(HUBPRET_READ_LINE_CTRL1);
+	reg_state->hubpret_read_line_status = REG_READ(HUBPRET_READ_LINE_STATUS);
+	reg_state->hubpret_read_line_value = REG_READ(HUBPRET_READ_LINE_VALUE);
+	reg_state->hubpret_read_line0 = REG_READ(HUBPRET_READ_LINE0);
+	reg_state->hubpret_read_line1 = REG_READ(HUBPRET_READ_LINE1);
+}
+
 void hubp3_setup(
 		struct hubp *hubp,
 		struct _vcs_dpi_display_dlg_regs_st *dlg_attr,
@@ -505,30 +625,6 @@ void hubp3_init(struct hubp *hubp)
 	hubp_reset(hubp);
 }
 
-uint32_t hubp3_get_current_read_line(struct hubp *hubp)
-{
-	uint32_t read_line = 0;
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-
-	REG_GET(HUBPRET_READ_LINE_VALUE,
-		PIPE_READ_LINE,
-		&read_line);
-
-	return read_line;
-}
-
-unsigned int hubp3_get_underflow_status(struct hubp *hubp)
-{
-	uint32_t hubp_underflow = 0;
-	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-
-	REG_GET(DCHUBP_CNTL,
-		HUBP_UNDERFLOW_STATUS,
-		&hubp_underflow);
-
-	return hubp_underflow;
-}
-
 static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -558,8 +654,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_clear_tiling = hubp3_clear_tiling,
-	.hubp_get_underflow_status = hubp3_get_underflow_status,
-	.hubp_get_current_read_line = hubp3_get_current_read_line,
+	.hubp_read_reg_state = hubp3_read_reg_state
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index 842f4eb72cc8..c767e9f4f9b3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -296,6 +296,8 @@ void hubp3_dmdata_set_attributes(
 
 void hubp3_read_state(struct hubp *hubp);
 
+void hubp3_read_reg_state(struct hubp *hubp, struct dcn_hubp_reg_state *reg_state);
+
 void hubp3_init(struct hubp *hubp);
 
 void hubp3_clear_tiling(struct hubp *hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 47101847c2b7..189045f85039 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -110,9 +110,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
 	.hubp_clear_tiling = hubp3_clear_tiling,
-	.hubp_get_underflow_status = hubp3_get_underflow_status,
-	.hubp_get_current_read_line = hubp3_get_current_read_line,
-	.hubp_get_det_config_error = hubp31_get_det_config_error,
+	.hubp_read_reg_state = hubp3_read_reg_state,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index 41c8f78efdc3..a781085b046b 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -222,9 +222,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
 	.hubp_clear_tiling = hubp3_clear_tiling,
-	.hubp_get_underflow_status = hubp3_get_underflow_status,
-	.hubp_get_current_read_line = hubp3_get_current_read_line,
-	.hubp_get_det_config_error = hubp31_get_det_config_error,
+	.hubp_read_reg_state = hubp3_read_reg_state
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index b140808f21af..79c583e258c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -209,6 +209,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.dmdata_load = hubp2_dmdata_load,
 	.dmdata_status_done = hubp2_dmdata_status_done,
 	.hubp_read_state = hubp3_read_state,
+	.hubp_read_reg_state = hubp3_read_reg_state,
 	.hubp_clear_underflow = hubp2_clear_underflow,
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp35_init,
@@ -218,9 +219,6 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
 	.hubp_clear_tiling = hubp3_clear_tiling,
-	.hubp_get_underflow_status = hubp3_get_underflow_status,
-	.hubp_get_current_read_line = hubp3_get_current_read_line,
-	.hubp_get_det_config_error = hubp31_get_det_config_error,
 };
 
 bool hubp35_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 0fcbc6a35be6..3a2e0848173e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -1071,9 +1071,7 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
 	.hubp_clear_tiling = hubp401_clear_tiling,
 	.hubp_program_3dlut_fl_config = hubp401_program_3dlut_fl_config,
-	.hubp_get_underflow_status = hubp3_get_underflow_status,
-	.hubp_get_current_read_line = hubp3_get_current_read_line,
-	.hubp_get_det_config_error = hubp31_get_det_config_error,
+	.hubp_read_reg_state = hubp3_read_reg_state
 };
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index e47ed5571dfd..81bcadf5e57e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -53,7 +53,8 @@
 #include "link_service.h"
 #include "dc_state_priv.h"
 
-
+#define TO_DCN_DCCG(dccg)\
+	container_of(dccg, struct dcn_dccg, base)
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1235,44 +1236,47 @@ void dcn30_get_underflow_debug_data(const struct dc *dc,
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
-	if (tg) {
-		uint32_t v_blank_start = 0, v_blank_end = 0;
-
-		out_data->otg_inst = tg->inst;
-
-		tg->funcs->get_scanoutpos(tg,
-					  &v_blank_start,
-					  &v_blank_end,
-					  &out_data->h_position,
-					  &out_data->v_position);
-
-		out_data->otg_frame_count = tg->funcs->get_frame_count(tg);
-
-		out_data->otg_underflow = tg->funcs->is_optc_underflow_occurred(tg);
+	if (hubbub) {
+		if (hubbub->funcs->hubbub_read_reg_state) {
+			hubbub->funcs->hubbub_read_reg_state(hubbub, out_data->hubbub_reg_state);
+		}
 	}
 
 	for (int i = 0; i < MAX_PIPES; i++) {
 		struct hubp *hubp = dc->res_pool->hubps[i];
-
-		if (hubp) {
-			if (hubp->funcs->hubp_get_underflow_status)
-				out_data->hubps[i].hubp_underflow = hubp->funcs->hubp_get_underflow_status(hubp);
-
-			if (hubp->funcs->hubp_in_blank)
-				out_data->hubps[i].hubp_in_blank = hubp->funcs->hubp_in_blank(hubp);
-
-			if (hubp->funcs->hubp_get_current_read_line)
-				out_data->hubps[i].hubp_readline = hubp->funcs->hubp_get_current_read_line(hubp);
-
-			if (hubp->funcs->hubp_get_det_config_error)
-				out_data->hubps[i].det_config_error = hubp->funcs->hubp_get_det_config_error(hubp);
-		}
+		struct dpp *dpp = dc->res_pool->dpps[i];
+		struct output_pixel_processor *opp = dc->res_pool->opps[i];
+		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
+		struct mpc *mpc = dc->res_pool->mpc;
+		struct timing_generator *optc = dc->res_pool->timing_generators[i];
+		struct dccg *dccg = dc->res_pool->dccg;
+
+		if (hubp)
+			if (hubp->funcs->hubp_read_reg_state)
+				hubp->funcs->hubp_read_reg_state(hubp, out_data->hubp_reg_state[i]);
+
+		if (dpp)
+			if (dpp->funcs->dpp_read_reg_state)
+				dpp->funcs->dpp_read_reg_state(dpp, out_data->dpp_reg_state[i]);
+
+		if (opp)
+			if (opp->funcs->opp_read_reg_state)
+				opp->funcs->opp_read_reg_state(opp, out_data->opp_reg_state[i]);
+
+		if (dsc)
+			if (dsc->funcs->dsc_read_reg_state)
+				dsc->funcs->dsc_read_reg_state(dsc, out_data->dsc_reg_state[i]);
+
+		if (mpc)
+			if (mpc->funcs->mpc_read_reg_state)
+				mpc->funcs->mpc_read_reg_state(mpc, i, out_data->mpc_reg_state[i]);
+
+		if (optc)
+			if (optc->funcs->optc_read_reg_state)
+				optc->funcs->optc_read_reg_state(optc, out_data->optc_reg_state[i]);
+
+		if (dccg)
+			if (dccg->funcs->dccg_read_reg_state)
+				dccg->funcs->dccg_read_reg_state(dccg, out_data->dccg_reg_state[i]);
 	}
-
-	if (hubbub->funcs->get_det_sizes)
-		hubbub->funcs->get_det_sizes(hubbub, out_data->curr_det_sizes, out_data->target_det_sizes);
-
-	if (hubbub->funcs->compbuf_config_error)
-		out_data->compbuf_config_error = hubbub->funcs->compbuf_config_error(hubbub);
-
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 61c4d2a7db1c..500a601e99b5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -71,6 +71,125 @@ enum pixel_rate_div {
    PIXEL_RATE_DIV_NA = 0xF
 };
 
+struct dcn_dccg_reg_state {
+	uint32_t dc_mem_global_pwr_req_cntl;
+	uint32_t dccg_audio_dtbclk_dto_modulo;
+	uint32_t dccg_audio_dtbclk_dto_phase;
+	uint32_t dccg_audio_dto_source;
+	uint32_t dccg_audio_dto0_module;
+	uint32_t dccg_audio_dto0_phase;
+	uint32_t dccg_audio_dto1_module;
+	uint32_t dccg_audio_dto1_phase;
+	uint32_t dccg_cac_status;
+	uint32_t dccg_cac_status2;
+	uint32_t dccg_disp_cntl_reg;
+	uint32_t dccg_ds_cntl;
+	uint32_t dccg_ds_dto_incr;
+	uint32_t dccg_ds_dto_modulo;
+	uint32_t dccg_ds_hw_cal_interval;
+	uint32_t dccg_gate_disable_cntl;
+	uint32_t dccg_gate_disable_cntl2;
+	uint32_t dccg_gate_disable_cntl3;
+	uint32_t dccg_gate_disable_cntl4;
+	uint32_t dccg_gate_disable_cntl5;
+	uint32_t dccg_gate_disable_cntl6;
+	uint32_t dccg_global_fgcg_rep_cntl;
+	uint32_t dccg_gtc_cntl;
+	uint32_t dccg_gtc_current;
+	uint32_t dccg_gtc_dto_incr;
+	uint32_t dccg_gtc_dto_modulo;
+	uint32_t dccg_perfmon_cntl;
+	uint32_t dccg_perfmon_cntl2;
+	uint32_t dccg_soft_reset;
+	uint32_t dccg_test_clk_sel;
+	uint32_t dccg_vsync_cnt_ctrl;
+	uint32_t dccg_vsync_cnt_int_ctrl;
+	uint32_t dccg_vsync_otg0_latch_value;
+	uint32_t dccg_vsync_otg1_latch_value;
+	uint32_t dccg_vsync_otg2_latch_value;
+	uint32_t dccg_vsync_otg3_latch_value;
+	uint32_t dccg_vsync_otg4_latch_value;
+	uint32_t dccg_vsync_otg5_latch_value;
+	uint32_t dispclk_cgtt_blk_ctrl_reg;
+	uint32_t dispclk_freq_change_cntl;
+	uint32_t dp_dto_dbuf_en;
+	uint32_t dp_dto0_modulo;
+	uint32_t dp_dto0_phase;
+	uint32_t dp_dto1_modulo;
+	uint32_t dp_dto1_phase;
+	uint32_t dp_dto2_modulo;
+	uint32_t dp_dto2_phase;
+	uint32_t dp_dto3_modulo;
+	uint32_t dp_dto3_phase;
+	uint32_t dpiaclk_540m_dto_modulo;
+	uint32_t dpiaclk_540m_dto_phase;
+	uint32_t dpiaclk_810m_dto_modulo;
+	uint32_t dpiaclk_810m_dto_phase;
+	uint32_t dpiaclk_dto_cntl;
+	uint32_t dpiasymclk_cntl;
+	uint32_t dppclk_cgtt_blk_ctrl_reg;
+	uint32_t dppclk_ctrl;
+	uint32_t dppclk_dto_ctrl;
+	uint32_t dppclk0_dto_param;
+	uint32_t dppclk1_dto_param;
+	uint32_t dppclk2_dto_param;
+	uint32_t dppclk3_dto_param;
+	uint32_t dprefclk_cgtt_blk_ctrl_reg;
+	uint32_t dprefclk_cntl;
+	uint32_t dpstreamclk_cntl;
+	uint32_t dscclk_dto_ctrl;
+	uint32_t dscclk0_dto_param;
+	uint32_t dscclk1_dto_param;
+	uint32_t dscclk2_dto_param;
+	uint32_t dscclk3_dto_param;
+	uint32_t dtbclk_dto_dbuf_en;
+	uint32_t dtbclk_dto0_modulo;
+	uint32_t dtbclk_dto0_phase;
+	uint32_t dtbclk_dto1_modulo;
+	uint32_t dtbclk_dto1_phase;
+	uint32_t dtbclk_dto2_modulo;
+	uint32_t dtbclk_dto2_phase;
+	uint32_t dtbclk_dto3_modulo;
+	uint32_t dtbclk_dto3_phase;
+	uint32_t dtbclk_p_cntl;
+	uint32_t force_symclk_disable;
+	uint32_t hdmicharclk0_clock_cntl;
+	uint32_t hdmistreamclk_cntl;
+	uint32_t hdmistreamclk0_dto_param;
+	uint32_t microsecond_time_base_div;
+	uint32_t millisecond_time_base_div;
+	uint32_t otg_pixel_rate_div;
+	uint32_t otg0_phypll_pixel_rate_cntl;
+	uint32_t otg0_pixel_rate_cntl;
+	uint32_t otg1_phypll_pixel_rate_cntl;
+	uint32_t otg1_pixel_rate_cntl;
+	uint32_t otg2_phypll_pixel_rate_cntl;
+	uint32_t otg2_pixel_rate_cntl;
+	uint32_t otg3_phypll_pixel_rate_cntl;
+	uint32_t otg3_pixel_rate_cntl;
+	uint32_t phyasymclk_clock_cntl;
+	uint32_t phybsymclk_clock_cntl;
+	uint32_t phycsymclk_clock_cntl;
+	uint32_t phydsymclk_clock_cntl;
+	uint32_t phyesymclk_clock_cntl;
+	uint32_t phyplla_pixclk_resync_cntl;
+	uint32_t phypllb_pixclk_resync_cntl;
+	uint32_t phypllc_pixclk_resync_cntl;
+	uint32_t phyplld_pixclk_resync_cntl;
+	uint32_t phyplle_pixclk_resync_cntl;
+	uint32_t refclk_cgtt_blk_ctrl_reg;
+	uint32_t socclk_cgtt_blk_ctrl_reg;
+	uint32_t symclk_cgtt_blk_ctrl_reg;
+	uint32_t symclk_psp_cntl;
+	uint32_t symclk32_le_cntl;
+	uint32_t symclk32_se_cntl;
+	uint32_t symclka_clock_enable;
+	uint32_t symclkb_clock_enable;
+	uint32_t symclkc_clock_enable;
+	uint32_t symclkd_clock_enable;
+	uint32_t symclke_clock_enable;
+};
+
 struct dccg {
 	struct dc_context *ctx;
 	const struct dccg_funcs *funcs;
@@ -81,7 +200,6 @@ struct dccg {
 	//int audio_dtbclk_khz;/* TODO needs to be removed */
 	//int ref_dtbclk_khz;/* TODO needs to be removed */
 };
-
 struct dtbclk_dto_params {
 	const struct dc_crtc_timing *timing;
 	int otg_inst;
@@ -214,6 +332,7 @@ struct dccg_funcs {
 	void (*set_dto_dscclk)(struct dccg *dccg, uint32_t dsc_inst, uint32_t num_slices_h);
 	void (*set_ref_dscclk)(struct dccg *dccg, uint32_t dsc_inst);
 	void (*dccg_root_gate_disable_control)(struct dccg *dccg, uint32_t pipe_idx, uint32_t disable_clock_gating);
+	void (*dccg_read_reg_state)(struct dccg *dccg, struct dcn_dccg_reg_state *dccg_reg_state);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 2ce47c403840..dafc8490efb5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -137,6 +137,14 @@ struct dcn_hubbub_state {
 	uint32_t dram_state_cntl;
 };
 
+struct dcn_hubbub_reg_state {
+	uint32_t det0_ctrl;
+	uint32_t det1_ctrl;
+	uint32_t det2_ctrl;
+	uint32_t det3_ctrl;
+	uint32_t compbuf_ctrl;
+};
+
 struct hubbub_system_latencies {
 	uint32_t max_latency_ns;
 	uint32_t avg_latency_ns;
@@ -216,6 +224,8 @@ struct hubbub_funcs {
 
 	void (*init_watermarks)(struct hubbub *hubbub);
 
+	void (*hubbub_read_reg_state)(struct hubbub *hubbub, struct dcn_hubbub_reg_state *hubbub_reg_state);
+
 	/**
 	 * @program_det_size:
 	 *
@@ -242,8 +252,6 @@ struct hubbub_funcs {
 	void (*program_compbuf_segments)(struct hubbub *hubbub, unsigned compbuf_size_seg, bool safe_to_increase);
 	void (*wait_for_det_update)(struct hubbub *hubbub, int hubp_inst);
 	bool (*program_arbiter)(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs, bool safe_to_lower);
-	void (*get_det_sizes)(struct hubbub *hubbub, uint32_t *curr_det_sizes, uint32_t *target_det_sizes);
-	uint32_t (*compbuf_config_error)(struct hubbub *hubbub);
 	struct hubbub_perfmon_funcs {
 		void (*reset)(struct hubbub *hubbub);
 		void (*start_measuring_max_memory_latency_ns)(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 09c224691618..d88b57d4f512 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -65,7 +65,6 @@ union defer_reg_writes {
 	} bits;
 	uint32_t raw;
 };
-
 struct dpp {
 	const struct dpp_funcs *funcs;
 	struct dc_context *ctx;
@@ -203,6 +202,19 @@ struct dcn_dpp_state {
 	uint32_t gamcor_mode;
 };
 
+struct dcn_dpp_reg_state {
+	uint32_t recout_start;
+	uint32_t recout_size;
+	uint32_t scl_horz_filter_scale_ratio;
+	uint32_t scl_vert_filter_scale_ratio;
+	uint32_t scl_mode;
+	uint32_t cm_control;
+	uint32_t dpp_control;
+	uint32_t dscl_control;
+	uint32_t obuf_control;
+	uint32_t mpc_size;
+};
+
 struct CM_bias_params {
 	uint32_t cm_bias_cr_r;
 	uint32_t cm_bias_y_g;
@@ -226,6 +238,8 @@ struct dpp_funcs {
 
 	void (*dpp_read_state)(struct dpp *dpp, struct dcn_dpp_state *s);
 
+	void (*dpp_read_reg_state)(struct dpp *dpp, struct dcn_dpp_reg_state *dpp_reg_state);
+
 	void (*dpp_reset)(struct dpp *dpp);
 
 	void (*dpp_set_scaler)(struct dpp *dpp,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index c62c4c1ed7c3..a79019365af8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -238,6 +238,7 @@ struct hubp_funcs {
 	void (*hubp_clk_cntl)(struct hubp *hubp, bool enable);
 	void (*hubp_vtg_sel)(struct hubp *hubp, uint32_t otg_inst);
 	void (*hubp_read_state)(struct hubp *hubp);
+	void (*hubp_read_reg_state)(struct hubp *hubp, struct dcn_hubp_reg_state *reg_state);
 	void (*hubp_clear_underflow)(struct hubp *hubp);
 	void (*hubp_disable_control)(struct hubp *hubp, bool disable_hubp);
 	unsigned int (*hubp_get_underflow_status)(struct hubp *hubp);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 22960ee03dee..a8d1abe20f62 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -350,6 +350,15 @@ struct mpcc_state {
 	struct mpc_rmcm_regs rmcm_regs;
 };
 
+struct dcn_mpc_reg_state {
+	uint32_t mpcc_bot_sel;
+	uint32_t mpcc_control;
+	uint32_t mpcc_status;
+	uint32_t mpcc_top_sel;
+	uint32_t mpcc_opp_id;
+	uint32_t mpcc_ogam_control;
+};
+
 /**
  * struct mpc_funcs - funcs
  */
@@ -373,6 +382,24 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			int mpcc_inst,
 			struct mpcc_state *s);
+	/**
+    * @mpc_read_reg_state:
+    *
+    * Read MPC register state for debugging underflow purposes.
+    *
+    * Parameters:
+    *
+    * - [in] mpc - MPC context
+    * - [out] reg_state - MPC register state structure
+    *
+    * Return:
+    *
+    * void
+    */
+	void (*mpc_read_reg_state)(
+			struct mpc *mpc,
+			int mpcc_inst,
+			struct dcn_mpc_reg_state *mpc_reg_state);
 
 	/**
 	* @insert_plane:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 747679cb4944..e1428a83ecbc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -297,6 +297,16 @@ struct oppbuf_params {
 	uint32_t num_segment_padded_pixels;
 };
 
+struct dcn_opp_reg_state {
+	uint32_t dpg_control;
+	uint32_t fmt_control;
+	uint32_t oppbuf_control;
+	uint32_t opp_pipe_control;
+	uint32_t opp_pipe_crc_control;
+	uint32_t opp_abm_control;
+	uint32_t dscrm_dsc_forward_config;
+};
+
 struct opp_funcs {
 
 
@@ -368,6 +378,9 @@ struct opp_funcs {
 			struct output_pixel_processor *opp,
 			enum dc_pixel_encoding pixel_encoding,
 			bool is_primary);
+
+	void (*opp_read_reg_state)(
+			struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index f2de2cf23859..da7bf59c4b9d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -175,6 +175,135 @@ struct dcn_otg_state {
 	uint32_t otg_double_buffer_control;
 };
 
+struct dcn_optc_reg_state {
+	uint32_t optc_bytes_per_pixel;
+	uint32_t optc_data_format_control;
+	uint32_t optc_data_source_select;
+	uint32_t optc_input_clock_control;
+	uint32_t optc_input_global_control;
+	uint32_t optc_input_spare_register;
+	uint32_t optc_memory_config;
+	uint32_t optc_rsmu_underflow;
+	uint32_t optc_underflow_threshold;
+	uint32_t optc_width_control;
+
+	uint32_t otg_3d_structure_control;
+	uint32_t otg_clock_control;
+	uint32_t otg_control;
+	uint32_t otg_count_control;
+	uint32_t otg_count_reset;
+	uint32_t otg_crc_cntl;
+	uint32_t otg_crc_sig_blue_control_mask;
+	uint32_t otg_crc_sig_red_green_mask;
+	uint32_t otg_crc0_data_b;
+	uint32_t otg_crc0_data_rg;
+	uint32_t otg_crc0_windowa_x_control;
+	uint32_t otg_crc0_windowa_x_control_readback;
+	uint32_t otg_crc0_windowa_y_control;
+	uint32_t otg_crc0_windowa_y_control_readback;
+	uint32_t otg_crc0_windowb_x_control;
+	uint32_t otg_crc0_windowb_x_control_readback;
+	uint32_t otg_crc0_windowb_y_control;
+	uint32_t otg_crc0_windowb_y_control_readback;
+	uint32_t otg_crc1_data_b;
+	uint32_t otg_crc1_data_rg;
+	uint32_t otg_crc1_windowa_x_control;
+	uint32_t otg_crc1_windowa_x_control_readback;
+	uint32_t otg_crc1_windowa_y_control;
+	uint32_t otg_crc1_windowa_y_control_readback;
+	uint32_t otg_crc1_windowb_x_control;
+	uint32_t otg_crc1_windowb_x_control_readback;
+	uint32_t otg_crc1_windowb_y_control;
+	uint32_t otg_crc1_windowb_y_control_readback;
+	uint32_t otg_crc2_data_b;
+	uint32_t otg_crc2_data_rg;
+	uint32_t otg_crc3_data_b;
+	uint32_t otg_crc3_data_rg;
+	uint32_t otg_dlpc_control;
+	uint32_t otg_double_buffer_control;
+	uint32_t otg_drr_control2;
+	uint32_t otg_drr_control;
+	uint32_t otg_drr_timing_int_status;
+	uint32_t otg_drr_trigger_window;
+	uint32_t otg_drr_v_total_change;
+	uint32_t otg_drr_v_total_reach_range;
+	uint32_t otg_dsc_start_position;
+	uint32_t otg_force_count_now_cntl;
+	uint32_t otg_global_control0;
+	uint32_t otg_global_control1;
+	uint32_t otg_global_control2;
+	uint32_t otg_global_control3;
+	uint32_t otg_global_control4;
+	uint32_t otg_global_sync_status;
+	uint32_t otg_gsl_control;
+	uint32_t otg_gsl_vsync_gap;
+	uint32_t otg_gsl_window_x;
+	uint32_t otg_gsl_window_y;
+	uint32_t otg_h_blank_start_end;
+	uint32_t otg_h_sync_a;
+	uint32_t otg_h_sync_a_cntl;
+	uint32_t otg_h_timing_cntl;
+	uint32_t otg_h_total;
+	uint32_t otg_interlace_control;
+	uint32_t otg_interlace_status;
+	uint32_t otg_interrupt_control;
+	uint32_t otg_long_vblank_status;
+	uint32_t otg_m_const_dto0;
+	uint32_t otg_m_const_dto1;
+	uint32_t otg_manual_force_vsync_next_line;
+	uint32_t otg_master_en;
+	uint32_t otg_master_update_lock;
+	uint32_t otg_master_update_mode;
+	uint32_t otg_nom_vert_position;
+	uint32_t otg_pipe_update_status;
+	uint32_t otg_pixel_data_readback0;
+	uint32_t otg_pixel_data_readback1;
+	uint32_t otg_request_control;
+	uint32_t otg_snapshot_control;
+	uint32_t otg_snapshot_frame;
+	uint32_t otg_snapshot_position;
+	uint32_t otg_snapshot_status;
+	uint32_t otg_spare_register;
+	uint32_t otg_static_screen_control;
+	uint32_t otg_status;
+	uint32_t otg_status_frame_count;
+	uint32_t otg_status_hv_count;
+	uint32_t otg_status_position;
+	uint32_t otg_status_vf_count;
+	uint32_t otg_stereo_control;
+	uint32_t otg_stereo_force_next_eye;
+	uint32_t otg_stereo_status;
+	uint32_t otg_trig_manual_control;
+	uint32_t otg_triga_cntl;
+	uint32_t otg_triga_manual_trig;
+	uint32_t otg_trigb_cntl;
+	uint32_t otg_trigb_manual_trig;
+	uint32_t otg_update_lock;
+	uint32_t otg_v_blank_start_end;
+	uint32_t otg_v_count_stop_control;
+	uint32_t otg_v_count_stop_control2;
+	uint32_t otg_v_sync_a;
+	uint32_t otg_v_sync_a_cntl;
+	uint32_t otg_v_total;
+	uint32_t otg_v_total_control;
+	uint32_t otg_v_total_int_status;
+	uint32_t otg_v_total_max;
+	uint32_t otg_v_total_mid;
+	uint32_t otg_v_total_min;
+	uint32_t otg_vert_sync_control;
+	uint32_t otg_vertical_interrupt0_control;
+	uint32_t otg_vertical_interrupt0_position;
+	uint32_t otg_vertical_interrupt1_control;
+	uint32_t otg_vertical_interrupt1_position;
+	uint32_t otg_vertical_interrupt2_control;
+	uint32_t otg_vertical_interrupt2_position;
+	uint32_t otg_vready_param;
+	uint32_t otg_vstartup_param;
+	uint32_t otg_vsync_nom_int_status;
+	uint32_t otg_vupdate_keepout;
+	uint32_t otg_vupdate_param;
+};
+
 /**
  * struct timing_generator - Entry point to Output Timing Generator feature.
  */
@@ -381,6 +510,7 @@ struct timing_generator_funcs {
 	void (*set_vupdate_keepout)(struct timing_generator *tg, bool enable);
 	bool (*wait_update_lock_status)(struct timing_generator *tg, bool locked);
 	void (*read_otg_state)(struct timing_generator *tg, struct dcn_otg_state *s);
+	void (*optc_read_reg_state)(struct timing_generator *tg, struct dcn_optc_reg_state *optc_reg_state);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
index 85298b8a1b5e..6bfd2c1294e5 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
@@ -1514,6 +1514,21 @@ static void mpc3_read_mpcc_state(
 		  MPCC_OGAM_SELECT_CURRENT, &s->rgam_lut);
 }
 
+void mpc3_read_reg_state(
+		struct mpc *mpc,
+		int mpcc_inst, struct dcn_mpc_reg_state *mpc_reg_state)
+{
+	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
+
+	mpc_reg_state->mpcc_bot_sel = REG_READ(MPCC_BOT_SEL[mpcc_inst]);
+	mpc_reg_state->mpcc_control = REG_READ(MPCC_CONTROL[mpcc_inst]);
+	mpc_reg_state->mpcc_ogam_control = REG_READ(MPCC_OGAM_CONTROL[mpcc_inst]);
+	mpc_reg_state->mpcc_opp_id = REG_READ(MPCC_OPP_ID[mpcc_inst]);
+	mpc_reg_state->mpcc_status = REG_READ(MPCC_STATUS[mpcc_inst]);
+	mpc_reg_state->mpcc_top_sel = REG_READ(MPCC_TOP_SEL[mpcc_inst]);
+
+}
+
 static const struct mpc_funcs dcn30_mpc_funcs = {
 	.read_mpcc_state = mpc3_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
@@ -1544,6 +1559,7 @@ static const struct mpc_funcs dcn30_mpc_funcs = {
 	.release_rmu = mpcc3_release_rmu,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.mpc_read_reg_state = mpc3_read_reg_state,
 	.set_bg_color = mpc1_set_bg_color,
 	.set_mpc_mem_lp_mode = mpc3_set_mpc_mem_lp_mode,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
index 103f29900a2c..e2f147d17178 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h
@@ -1096,6 +1096,11 @@ void mpc3_power_on_ogam_lut(
 	struct mpc *mpc, int mpcc_id,
 	bool power_on);
 
+void mpc3_read_reg_state(
+		struct mpc *mpc,
+		int mpcc_inst,
+		struct dcn_mpc_reg_state *mpc_reg_state);
+
 void mpc3_init_mpcc(struct mpcc *mpcc, int mpcc_inst);
 
 enum dc_lut_mode mpc3_get_ogam_current(
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
index 6f0e017a8ae2..83bbbf34bcac 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
@@ -1020,6 +1020,7 @@ static const struct mpc_funcs dcn32_mpc_funcs = {
 	.release_rmu = NULL,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.mpc_read_reg_state = mpc3_read_reg_state,
 	.set_bg_color = mpc1_set_bg_color,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index e1a0308dee57..eeac13fdd6f5 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -598,6 +598,7 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.release_rmu = NULL,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
+	.mpc_read_reg_state = mpc3_read_reg_state,
 	.set_bg_color = mpc1_set_bg_color,
 	.set_movable_cm_location = mpc401_set_movable_cm_location,
 	.update_3dlut_fast_load_select = mpc401_update_3dlut_fast_load_select,
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
index 71e9288d60ed..45d418636d0c 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.c
@@ -372,6 +372,17 @@ void opp1_pipe_clock_control(struct output_pixel_processor *opp, bool enable)
 	REG_UPDATE(OPP_PIPE_CONTROL, OPP_PIPE_CLOCK_EN, regval);
 }
 
+
+void opp1_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state)
+{
+	struct dcn10_opp *oppn10 = TO_DCN10_OPP(opp);
+
+	opp_reg_state->fmt_control = REG_READ(FMT_CONTROL);
+	opp_reg_state->opp_pipe_control = REG_READ(OPP_PIPE_CONTROL);
+	opp_reg_state->opp_pipe_crc_control = REG_READ(OPP_PIPE_CRC_CONTROL);
+	opp_reg_state->oppbuf_control = REG_READ(OPPBUF_CONTROL);
+}
+
 /*****************************************/
 /* Constructor, Destructor               */
 /*****************************************/
@@ -392,7 +403,8 @@ static const struct opp_funcs dcn10_opp_funcs = {
 		.opp_program_dpg_dimensions = NULL,
 		.dpg_is_blanked = NULL,
 		.dpg_is_pending = NULL,
-		.opp_destroy = opp1_destroy
+		.opp_destroy = opp1_destroy,
+		.opp_read_reg_state = opp1_read_reg_state
 };
 
 void dcn10_opp_construct(struct dcn10_opp *oppn10,
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h
index c87de68a509e..38d0d530a9b7 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn10/dcn10_opp.h
@@ -63,7 +63,8 @@
 	uint32_t OPPBUF_CONTROL1; \
 	uint32_t OPPBUF_3D_PARAMETERS_0; \
 	uint32_t OPPBUF_3D_PARAMETERS_1; \
-	uint32_t OPP_PIPE_CONTROL
+	uint32_t OPP_PIPE_CONTROL; \
+	uint32_t OPP_PIPE_CRC_CONTROL
 
 #define OPP_MASK_SH_LIST_DCN(mask_sh) \
 	OPP_SF(FMT0_FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_EN, mask_sh), \
@@ -153,7 +154,6 @@ struct dcn10_opp {
 	const struct dcn10_opp_registers *regs;
 	const struct dcn10_opp_shift *opp_shift;
 	const struct dcn10_opp_mask *opp_mask;
-
 	bool is_write_to_ram_a_safe;
 };
 
@@ -188,4 +188,6 @@ void opp1_pipe_clock_control(struct output_pixel_processor *opp, bool enable);
 
 void opp1_destroy(struct output_pixel_processor **opp);
 
+void opp1_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index f5fe0cac7cb0..ce826a5be4c7 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -377,6 +377,18 @@ uint32_t opp2_get_left_edge_extra_pixel_count(struct output_pixel_processor *opp
 		return 0;
 }
 
+void opp2_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state)
+{
+	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
+
+	opp_reg_state->dpg_control = REG_READ(DPG_CONTROL);
+	opp_reg_state->fmt_control = REG_READ(FMT_CONTROL);
+	opp_reg_state->opp_pipe_control = REG_READ(OPP_PIPE_CONTROL);
+	opp_reg_state->opp_pipe_crc_control = REG_READ(OPP_PIPE_CRC_CONTROL);
+	opp_reg_state->oppbuf_control = REG_READ(OPPBUF_CONTROL);
+	opp_reg_state->dscrm_dsc_forward_config = REG_READ(DSCRM_DSC_FORWARD_CONFIG);
+}
+
 /*****************************************/
 /* Constructor, Destructor               */
 /*****************************************/
@@ -395,6 +407,7 @@ static struct opp_funcs dcn20_opp_funcs = {
 		.opp_destroy = opp1_destroy,
 		.opp_program_left_edge_extra_pixel = opp2_program_left_edge_extra_pixel,
 		.opp_get_left_edge_extra_pixel_count = opp2_get_left_edge_extra_pixel_count,
+		.opp_read_reg_state = opp2_read_reg_state
 };
 
 void dcn20_opp_construct(struct dcn20_opp *oppn20,
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
index 34936e6c49f3..fb0c047c1788 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
@@ -59,7 +59,8 @@
 	uint32_t DPG_COLOUR_G_Y; \
 	uint32_t DPG_COLOUR_R_CR; \
 	uint32_t DPG_RAMP_CONTROL; \
-	uint32_t DPG_STATUS
+	uint32_t DPG_STATUS; \
+	uint32_t DSCRM_DSC_FORWARD_CONFIG
 
 #define OPP_DPG_MASK_SH_LIST(mask_sh) \
 	OPP_SF(DPG0_DPG_CONTROL, DPG_EN, mask_sh), \
@@ -171,4 +172,7 @@ void opp2_program_left_edge_extra_pixel (
 
 uint32_t opp2_get_left_edge_extra_pixel_count(struct output_pixel_processor *opp,
 		enum dc_pixel_encoding pixel_encoding, bool is_primary);
+
+void opp2_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c
index 3542b51c9aac..e11c4e16402f 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c
@@ -51,3 +51,16 @@ void dcn35_opp_set_fgcg(struct dcn20_opp *oppn20, bool enable)
 {
 	REG_UPDATE(OPP_TOP_CLK_CONTROL, OPP_FGCG_REP_DIS, !enable);
 }
+
+void dcn35_opp_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state)
+{
+	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
+
+	opp_reg_state->dpg_control = REG_READ(DPG_CONTROL);
+	opp_reg_state->fmt_control = REG_READ(FMT_CONTROL);
+	opp_reg_state->opp_abm_control = REG_READ(OPP_ABM_CONTROL);
+	opp_reg_state->opp_pipe_control = REG_READ(OPP_PIPE_CONTROL);
+	opp_reg_state->opp_pipe_crc_control = REG_READ(OPP_PIPE_CRC_CONTROL);
+	opp_reg_state->oppbuf_control = REG_READ(OPPBUF_CONTROL);
+	opp_reg_state->dscrm_dsc_forward_config = REG_READ(DSCRM_DSC_FORWARD_CONFIG);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h
index a9a413527801..c6cace90e8f2 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h
@@ -31,7 +31,8 @@
 
 #define OPP_REG_VARIABLE_LIST_DCN3_5  \
 	OPP_REG_VARIABLE_LIST_DCN2_0; \
-	uint32_t OPP_TOP_CLK_CONTROL
+	uint32_t OPP_TOP_CLK_CONTROL; \
+	uint32_t OPP_ABM_CONTROL
 
 #define OPP_MASK_SH_LIST_DCN35(mask_sh)  \
 	OPP_MASK_SH_LIST_DCN20(mask_sh), \
@@ -64,4 +65,5 @@ void dcn35_opp_construct(struct dcn20_opp *oppn20,
 
 void dcn35_opp_set_fgcg(struct dcn20_opp *oppn20, bool enable);
 
+void dcn35_opp_read_reg_state(struct output_pixel_processor *opp, struct dcn_opp_reg_state *opp_reg_state);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 8b2a8455eb56..803bcc25601c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -209,7 +209,43 @@
 	uint32_t OPTC_WIDTH_CONTROL2; \
 	uint32_t OTG_PSTATE_REGISTER; \
 	uint32_t OTG_PIPE_UPDATE_STATUS; \
-	uint32_t INTERRUPT_DEST
+	uint32_t INTERRUPT_DEST; \
+	uint32_t OPTC_INPUT_SPARE_REGISTER; \
+	uint32_t OPTC_RSMU_UNDERFLOW; \
+	uint32_t OPTC_UNDERFLOW_THRESHOLD; \
+	uint32_t OTG_COUNT_CONTROL; \
+	uint32_t OTG_COUNT_RESET; \
+	uint32_t OTG_CRC_SIG_BLUE_CONTROL_MASK; \
+	uint32_t OTG_CRC_SIG_RED_GREEN_MASK; \
+	uint32_t OTG_DLPC_CONTROL; \
+	uint32_t OTG_DRR_CONTROL2; \
+	uint32_t OTG_DRR_TIMING_INT_STATUS; \
+	uint32_t OTG_GLOBAL_CONTROL3; \
+	uint32_t OTG_GLOBAL_SYNC_STATUS; \
+	uint32_t OTG_GSL_VSYNC_GAP; \
+	uint32_t OTG_INTERLACE_STATUS; \
+	uint32_t OTG_INTERRUPT_CONTROL; \
+	uint32_t OTG_LONG_VBLANK_STATUS; \
+	uint32_t OTG_MANUAL_FORCE_VSYNC_NEXT_LINE; \
+	uint32_t OTG_MASTER_EN; \
+	uint32_t OTG_PIXEL_DATA_READBACK0; \
+	uint32_t OTG_PIXEL_DATA_READBACK1; \
+	uint32_t OTG_REQUEST_CONTROL; \
+	uint32_t OTG_SNAPSHOT_CONTROL; \
+	uint32_t OTG_SNAPSHOT_FRAME; \
+	uint32_t OTG_SNAPSHOT_POSITION; \
+	uint32_t OTG_SNAPSHOT_STATUS; \
+	uint32_t OTG_SPARE_REGISTER; \
+	uint32_t OTG_STATUS_HV_COUNT; \
+	uint32_t OTG_STATUS_VF_COUNT; \
+	uint32_t OTG_STEREO_FORCE_NEXT_EYE; \
+	uint32_t OTG_TRIG_MANUAL_CONTROL; \
+	uint32_t OTG_TRIGB_CNTL; \
+	uint32_t OTG_TRIGB_MANUAL_TRIG; \
+	uint32_t OTG_UPDATE_LOCK; \
+	uint32_t OTG_V_TOTAL_INT_STATUS; \
+	uint32_t OTG_VSYNC_NOM_INT_STATUS
+
 
 struct dcn_optc_registers {
 	OPTC_REG_VARIABLE_LIST_DCN;
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 4f1830ba619f..c6417538090f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -315,6 +315,136 @@ void optc31_read_otg_state(struct timing_generator *optc,
 	s->otg_double_buffer_control = REG_READ(OTG_DOUBLE_BUFFER_CONTROL);
 }
 
+void optc31_read_reg_state(struct timing_generator *optc, struct dcn_optc_reg_state *optc_reg_state)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	optc_reg_state->optc_bytes_per_pixel = REG_READ(OPTC_BYTES_PER_PIXEL);
+	optc_reg_state->optc_data_format_control = REG_READ(OPTC_DATA_FORMAT_CONTROL);
+	optc_reg_state->optc_data_source_select = REG_READ(OPTC_DATA_SOURCE_SELECT);
+	optc_reg_state->optc_input_clock_control = REG_READ(OPTC_INPUT_CLOCK_CONTROL);
+	optc_reg_state->optc_input_global_control = REG_READ(OPTC_INPUT_GLOBAL_CONTROL);
+	optc_reg_state->optc_input_spare_register = REG_READ(OPTC_INPUT_SPARE_REGISTER);
+	optc_reg_state->optc_memory_config = REG_READ(OPTC_MEMORY_CONFIG);
+	optc_reg_state->optc_rsmu_underflow = REG_READ(OPTC_RSMU_UNDERFLOW);
+	optc_reg_state->optc_underflow_threshold = REG_READ(OPTC_UNDERFLOW_THRESHOLD);
+	optc_reg_state->optc_width_control = REG_READ(OPTC_WIDTH_CONTROL);
+	optc_reg_state->otg_3d_structure_control = REG_READ(OTG_3D_STRUCTURE_CONTROL);
+	optc_reg_state->otg_clock_control = REG_READ(OTG_CLOCK_CONTROL);
+	optc_reg_state->otg_control = REG_READ(OTG_CONTROL);
+	optc_reg_state->otg_count_control = REG_READ(OTG_COUNT_CONTROL);
+	optc_reg_state->otg_count_reset = REG_READ(OTG_COUNT_RESET);
+	optc_reg_state->otg_crc_cntl = REG_READ(OTG_CRC_CNTL);
+	optc_reg_state->otg_crc_sig_blue_control_mask = REG_READ(OTG_CRC_SIG_BLUE_CONTROL_MASK);
+	optc_reg_state->otg_crc_sig_red_green_mask = REG_READ(OTG_CRC_SIG_RED_GREEN_MASK);
+	optc_reg_state->otg_crc0_data_b = REG_READ(OTG_CRC0_DATA_B);
+	optc_reg_state->otg_crc0_data_rg = REG_READ(OTG_CRC0_DATA_RG);
+	optc_reg_state->otg_crc0_windowa_x_control = REG_READ(OTG_CRC0_WINDOWA_X_CONTROL);
+	optc_reg_state->otg_crc0_windowa_x_control_readback = REG_READ(OTG_CRC0_WINDOWA_X_CONTROL_READBACK);
+	optc_reg_state->otg_crc0_windowa_y_control = REG_READ(OTG_CRC0_WINDOWA_Y_CONTROL);
+	optc_reg_state->otg_crc0_windowa_y_control_readback = REG_READ(OTG_CRC0_WINDOWA_Y_CONTROL_READBACK);
+	optc_reg_state->otg_crc0_windowb_x_control = REG_READ(OTG_CRC0_WINDOWB_X_CONTROL);
+	optc_reg_state->otg_crc0_windowb_x_control_readback = REG_READ(OTG_CRC0_WINDOWB_X_CONTROL_READBACK);
+	optc_reg_state->otg_crc0_windowb_y_control = REG_READ(OTG_CRC0_WINDOWB_Y_CONTROL);
+	optc_reg_state->otg_crc0_windowb_y_control_readback = REG_READ(OTG_CRC0_WINDOWB_Y_CONTROL_READBACK);
+	optc_reg_state->otg_crc1_data_b = REG_READ(OTG_CRC1_DATA_B);
+	optc_reg_state->otg_crc1_data_rg = REG_READ(OTG_CRC1_DATA_RG);
+	optc_reg_state->otg_crc1_windowa_x_control = REG_READ(OTG_CRC1_WINDOWA_X_CONTROL);
+	optc_reg_state->otg_crc1_windowa_x_control_readback = REG_READ(OTG_CRC1_WINDOWA_X_CONTROL_READBACK);
+	optc_reg_state->otg_crc1_windowa_y_control = REG_READ(OTG_CRC1_WINDOWA_Y_CONTROL);
+	optc_reg_state->otg_crc1_windowa_y_control_readback = REG_READ(OTG_CRC1_WINDOWA_Y_CONTROL_READBACK);
+	optc_reg_state->otg_crc1_windowb_x_control = REG_READ(OTG_CRC1_WINDOWB_X_CONTROL);
+	optc_reg_state->otg_crc1_windowb_x_control_readback = REG_READ(OTG_CRC1_WINDOWB_X_CONTROL_READBACK);
+	optc_reg_state->otg_crc1_windowb_y_control = REG_READ(OTG_CRC1_WINDOWB_Y_CONTROL);
+	optc_reg_state->otg_crc1_windowb_y_control_readback = REG_READ(OTG_CRC1_WINDOWB_Y_CONTROL_READBACK);
+	optc_reg_state->otg_crc2_data_b = REG_READ(OTG_CRC2_DATA_B);
+	optc_reg_state->otg_crc2_data_rg = REG_READ(OTG_CRC2_DATA_RG);
+	optc_reg_state->otg_crc3_data_b = REG_READ(OTG_CRC3_DATA_B);
+	optc_reg_state->otg_crc3_data_rg = REG_READ(OTG_CRC3_DATA_RG);
+	optc_reg_state->otg_dlpc_control = REG_READ(OTG_DLPC_CONTROL);
+	optc_reg_state->otg_double_buffer_control = REG_READ(OTG_DOUBLE_BUFFER_CONTROL);
+	optc_reg_state->otg_drr_control2 = REG_READ(OTG_DRR_CONTROL2);
+	optc_reg_state->otg_drr_control = REG_READ(OTG_DRR_CONTROL);
+	optc_reg_state->otg_drr_timing_int_status = REG_READ(OTG_DRR_TIMING_INT_STATUS);
+	optc_reg_state->otg_drr_trigger_window = REG_READ(OTG_DRR_TRIGGER_WINDOW);
+	optc_reg_state->otg_drr_v_total_change = REG_READ(OTG_DRR_V_TOTAL_CHANGE);
+	optc_reg_state->otg_dsc_start_position = REG_READ(OTG_DSC_START_POSITION);
+	optc_reg_state->otg_force_count_now_cntl = REG_READ(OTG_FORCE_COUNT_NOW_CNTL);
+	optc_reg_state->otg_global_control0 = REG_READ(OTG_GLOBAL_CONTROL0);
+	optc_reg_state->otg_global_control1 = REG_READ(OTG_GLOBAL_CONTROL1);
+	optc_reg_state->otg_global_control2 = REG_READ(OTG_GLOBAL_CONTROL2);
+	optc_reg_state->otg_global_control3 = REG_READ(OTG_GLOBAL_CONTROL3);
+	optc_reg_state->otg_global_control4 = REG_READ(OTG_GLOBAL_CONTROL4);
+	optc_reg_state->otg_global_sync_status = REG_READ(OTG_GLOBAL_SYNC_STATUS);
+	optc_reg_state->otg_gsl_control = REG_READ(OTG_GSL_CONTROL);
+	optc_reg_state->otg_gsl_vsync_gap = REG_READ(OTG_GSL_VSYNC_GAP);
+	optc_reg_state->otg_gsl_window_x = REG_READ(OTG_GSL_WINDOW_X);
+	optc_reg_state->otg_gsl_window_y = REG_READ(OTG_GSL_WINDOW_Y);
+	optc_reg_state->otg_h_blank_start_end = REG_READ(OTG_H_BLANK_START_END);
+	optc_reg_state->otg_h_sync_a = REG_READ(OTG_H_SYNC_A);
+	optc_reg_state->otg_h_sync_a_cntl = REG_READ(OTG_H_SYNC_A_CNTL);
+	optc_reg_state->otg_h_timing_cntl = REG_READ(OTG_H_TIMING_CNTL);
+	optc_reg_state->otg_h_total = REG_READ(OTG_H_TOTAL);
+	optc_reg_state->otg_interlace_control = REG_READ(OTG_INTERLACE_CONTROL);
+	optc_reg_state->otg_interlace_status = REG_READ(OTG_INTERLACE_STATUS);
+	optc_reg_state->otg_interrupt_control = REG_READ(OTG_INTERRUPT_CONTROL);
+	optc_reg_state->otg_long_vblank_status = REG_READ(OTG_LONG_VBLANK_STATUS);
+	optc_reg_state->otg_m_const_dto0 = REG_READ(OTG_M_CONST_DTO0);
+	optc_reg_state->otg_m_const_dto1 = REG_READ(OTG_M_CONST_DTO1);
+	optc_reg_state->otg_manual_force_vsync_next_line = REG_READ(OTG_MANUAL_FORCE_VSYNC_NEXT_LINE);
+	optc_reg_state->otg_master_en = REG_READ(OTG_MASTER_EN);
+	optc_reg_state->otg_master_update_lock = REG_READ(OTG_MASTER_UPDATE_LOCK);
+	optc_reg_state->otg_master_update_mode = REG_READ(OTG_MASTER_UPDATE_MODE);
+	optc_reg_state->otg_nom_vert_position = REG_READ(OTG_NOM_VERT_POSITION);
+	optc_reg_state->otg_pipe_update_status = REG_READ(OTG_PIPE_UPDATE_STATUS);
+	optc_reg_state->otg_pixel_data_readback0 = REG_READ(OTG_PIXEL_DATA_READBACK0);
+	optc_reg_state->otg_pixel_data_readback1 = REG_READ(OTG_PIXEL_DATA_READBACK1);
+	optc_reg_state->otg_request_control = REG_READ(OTG_REQUEST_CONTROL);
+	optc_reg_state->otg_snapshot_control = REG_READ(OTG_SNAPSHOT_CONTROL);
+	optc_reg_state->otg_snapshot_frame = REG_READ(OTG_SNAPSHOT_FRAME);
+	optc_reg_state->otg_snapshot_position = REG_READ(OTG_SNAPSHOT_POSITION);
+	optc_reg_state->otg_snapshot_status = REG_READ(OTG_SNAPSHOT_STATUS);
+	optc_reg_state->otg_spare_register = REG_READ(OTG_SPARE_REGISTER);
+	optc_reg_state->otg_static_screen_control = REG_READ(OTG_STATIC_SCREEN_CONTROL);
+	optc_reg_state->otg_status = REG_READ(OTG_STATUS);
+	optc_reg_state->otg_status_frame_count = REG_READ(OTG_STATUS_FRAME_COUNT);
+	optc_reg_state->otg_status_hv_count = REG_READ(OTG_STATUS_HV_COUNT);
+	optc_reg_state->otg_status_position = REG_READ(OTG_STATUS_POSITION);
+	optc_reg_state->otg_status_vf_count = REG_READ(OTG_STATUS_VF_COUNT);
+	optc_reg_state->otg_stereo_control = REG_READ(OTG_STEREO_CONTROL);
+	optc_reg_state->otg_stereo_force_next_eye = REG_READ(OTG_STEREO_FORCE_NEXT_EYE);
+	optc_reg_state->otg_stereo_status = REG_READ(OTG_STEREO_STATUS);
+	optc_reg_state->otg_trig_manual_control = REG_READ(OTG_TRIG_MANUAL_CONTROL);
+	optc_reg_state->otg_triga_cntl = REG_READ(OTG_TRIGA_CNTL);
+	optc_reg_state->otg_triga_manual_trig = REG_READ(OTG_TRIGA_MANUAL_TRIG);
+	optc_reg_state->otg_trigb_cntl = REG_READ(OTG_TRIGB_CNTL);
+	optc_reg_state->otg_trigb_manual_trig = REG_READ(OTG_TRIGB_MANUAL_TRIG);
+	optc_reg_state->otg_update_lock = REG_READ(OTG_UPDATE_LOCK);
+	optc_reg_state->otg_v_blank_start_end = REG_READ(OTG_V_BLANK_START_END);
+	optc_reg_state->otg_v_count_stop_control = REG_READ(OTG_V_COUNT_STOP_CONTROL);
+	optc_reg_state->otg_v_count_stop_control2 = REG_READ(OTG_V_COUNT_STOP_CONTROL2);
+	optc_reg_state->otg_v_sync_a = REG_READ(OTG_V_SYNC_A);
+	optc_reg_state->otg_v_sync_a_cntl = REG_READ(OTG_V_SYNC_A_CNTL);
+	optc_reg_state->otg_v_total = REG_READ(OTG_V_TOTAL);
+	optc_reg_state->otg_v_total_control = REG_READ(OTG_V_TOTAL_CONTROL);
+	optc_reg_state->otg_v_total_int_status = REG_READ(OTG_V_TOTAL_INT_STATUS);
+	optc_reg_state->otg_v_total_max = REG_READ(OTG_V_TOTAL_MAX);
+	optc_reg_state->otg_v_total_mid = REG_READ(OTG_V_TOTAL_MID);
+	optc_reg_state->otg_v_total_min = REG_READ(OTG_V_TOTAL_MIN);
+	optc_reg_state->otg_vert_sync_control = REG_READ(OTG_VERT_SYNC_CONTROL);
+	optc_reg_state->otg_vertical_interrupt0_control = REG_READ(OTG_VERTICAL_INTERRUPT0_CONTROL);
+	optc_reg_state->otg_vertical_interrupt0_position = REG_READ(OTG_VERTICAL_INTERRUPT0_POSITION);
+	optc_reg_state->otg_vertical_interrupt1_control = REG_READ(OTG_VERTICAL_INTERRUPT1_CONTROL);
+	optc_reg_state->otg_vertical_interrupt1_position = REG_READ(OTG_VERTICAL_INTERRUPT1_POSITION);
+	optc_reg_state->otg_vertical_interrupt2_control = REG_READ(OTG_VERTICAL_INTERRUPT2_CONTROL);
+	optc_reg_state->otg_vertical_interrupt2_position = REG_READ(OTG_VERTICAL_INTERRUPT2_POSITION);
+	optc_reg_state->otg_vready_param = REG_READ(OTG_VREADY_PARAM);
+	optc_reg_state->otg_vstartup_param = REG_READ(OTG_VSTARTUP_PARAM);
+	optc_reg_state->otg_vsync_nom_int_status = REG_READ(OTG_VSYNC_NOM_INT_STATUS);
+	optc_reg_state->otg_vupdate_keepout = REG_READ(OTG_VUPDATE_KEEPOUT);
+	optc_reg_state->otg_vupdate_param = REG_READ(OTG_VUPDATE_PARAM);
+}
+
 static const struct timing_generator_funcs dcn31_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -377,6 +507,7 @@ static const struct timing_generator_funcs dcn31_tg_funcs = {
 		.init_odm = optc3_init_odm,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
+		.optc_read_reg_state = optc31_read_reg_state,
 };
 
 void dcn31_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
index 0f72c274f40b..98f7d2e299c5 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
@@ -274,4 +274,6 @@ void optc3_init_odm(struct timing_generator *optc);
 void optc31_read_otg_state(struct timing_generator *optc,
 		struct dcn_otg_state *s);
 
+void optc31_read_reg_state(struct timing_generator *optc, struct dcn_optc_reg_state *optc_reg_state);
+
 #endif /* __DC_OPTC_DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index 4a2caca37255..43ff957288b2 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -256,6 +256,7 @@ static const struct timing_generator_funcs dcn314_tg_funcs = {
 		.set_h_timing_div_manual_mode = optc314_set_h_timing_div_manual_mode,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
+		.optc_read_reg_state = optc31_read_reg_state,
 };
 
 void dcn314_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index b2b226bcd871..3dcb0d0c931c 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -365,6 +365,7 @@ static const struct timing_generator_funcs dcn32_tg_funcs = {
 		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 		.get_pipe_update_pending = optc3_get_pipe_update_pending,
 		.read_otg_state = optc31_read_otg_state,
+		.optc_read_reg_state = optc31_read_reg_state,
 };
 
 void dcn32_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 52d5ea98c86b..f699e95059f3 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -511,6 +511,7 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
+		.optc_read_reg_state = optc31_read_reg_state,
 };
 
 void dcn35_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 5af13706e601..a8e978d1fae8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -533,6 +533,7 @@ static const struct timing_generator_funcs dcn401_tg_funcs = {
 		.set_vupdate_keepout = optc401_set_vupdate_keepout,
 		.wait_update_lock_status = optc401_wait_update_lock_status,
 		.read_otg_state = optc31_read_otg_state,
+		.optc_read_reg_state = optc31_read_reg_state,
 };
 
 void dcn401_timing_generator_init(struct optc *optc1)
-- 
2.43.0

