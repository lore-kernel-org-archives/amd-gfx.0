Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F808E9E31B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFA810E6B1;
	Thu, 12 Feb 2026 01:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pus00mU2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C3D10E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYKqePnDBVV52FmkPCykyKJVfyqhcPa9mgHCqJi7DkpWWf2HnADd6/p5ya9GeR6352k0xg+1rCxoAAW9ZIxQxy98dwlXESi7zRGJBAYEeDzZhmcnTorLTlZ1la6nlj8FLV3fQFm0Z6jHrYm0E1HHjAkP1/EiDkIqzDrCePx2L8V8s7QM7KJYkxTU20bIllLlgQdMKXNPW3Fd/3HIsHkXfUSKQKJoPFB7qWEAqmmayuQtydPqC8TxPq7H0EHnl/eyUIjQKThpCUMFV+r5h119QS5TprQrnZ39TBRhGX7/v0Lcstv7lJXaThwk1joT7ocAxBsWZLBYqHG1Wko6ylTiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NooS2D9/PHIfOqW7YYyn6M9GlA+hS7ufqryBve8xDi0=;
 b=lI7CtdnCNCpEQ+OaDAK3v44RrzjUbanOBs79W2KPrLyCIlqdC5wZL22ujdz0Sc6P6TRVSp2YUC9blM0vy6hnwDcZC96eiXxTdinLSVdi6Mw2lR4FE+h9BS1i/N272aSFbCWnDuNxSbHxbwiE1UdGd8K6INPW86891r388PrT7ydI0RtfcjnUsaALS9lIJKh8XvAewiWYvPABVJrhmQDvpVBVJIyg5S4hXNOVrcUiAwP74Bgcw0G3oCjsFzRl2QzAPBOzTNN74KZPC5b61hDeGudRtnZ0PqimDdWoV/72beM4M0EfzNICAmvf+nF7EunS+V4r+HUv5INRvnYp9UspFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NooS2D9/PHIfOqW7YYyn6M9GlA+hS7ufqryBve8xDi0=;
 b=Pus00mU205sz5Nr6GmXM4Z7WWB2DJO+3z+HPq0I917sWHA+a/PRKjkduivd2dySSUajVWUbNsQo91DbCinTnrrPjX/iHjcLPSQXwuOvZiQYygZKNn+v4Zo0t1DAQoLrSZ065uOkPdeoBZxl/D0HDmdbLbU9dnhn2U1uJjInjZtk=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 01:11:28 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::27) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Thu,
 12 Feb 2026 01:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 01:11:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 11 Feb
 2026 19:11:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Feb
 2026 19:10:01 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:10:01 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 6/7] drm/amd/display: Enable dcn42 DC
Date: Wed, 11 Feb 2026 20:09:48 -0500
Message-ID: <20260212010949.654686-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212010949.654686-1-Roman.Li@amd.com>
References: <20260212010949.654686-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: aac9b627-9bd9-4103-63a1-08de69d3a5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?utpzAROwCk1Nj2nlyYFsfyZlAqSNM/slKNs+iFABFQfL1bH/6af9Dxs7JWO3?=
 =?us-ascii?Q?7JpCpKbFe6FNEKHq3AoF2LVDW5OXid3/NfFtZ2/EwdpnrP6FgkCNKQ9ZOab/?=
 =?us-ascii?Q?ydMJKd4UXmezSDbJoq/f02REh9hsOx2b7LdEMZXic6WB+FWr9FZW7LkROsX+?=
 =?us-ascii?Q?0r8s4R33Wbp6FeOHSLpX6+RcTGnqk+Vyvtg+fUkfqvAGn8XHCClTt/k+peOZ?=
 =?us-ascii?Q?+ok58CTd3A5S7Vr+tim4J2rooTseOqD9uOkHR2CAtblSmQgQ/YMI28vWdT5U?=
 =?us-ascii?Q?a/4RQQhIQv8mnR+3SOCK7VfOg8LxCwYBuAE1/nasHm/KdZM9Xvk6T/CO0boo?=
 =?us-ascii?Q?kXGQASauI8FbKFKKquwoidz84/TL+duDd3PWtUHidVap87aftdJXjJ+SFeTU?=
 =?us-ascii?Q?0wT40Son+FXs3BpcdwQrK0rgwcr6b8621K3sfCGv6N/NmyBwy0TleQNYGsjV?=
 =?us-ascii?Q?nqJbkLK+znkgVxBCTdnoY/PCi4ONp34utx6i6qY3GQ0ownfOr9sSUPLJI284?=
 =?us-ascii?Q?BjcTO1ZdibWQNZs87GM2y2A6RguWIVVCw6zGAokTqsgqHjy2x4xUDL0+AMfv?=
 =?us-ascii?Q?FkeNN0tD3NCuTUyFjVo42jxbOBcvMGE9hIeETa2Qz4dMtSH/YQUYVNZNJTWo?=
 =?us-ascii?Q?GULyKdb5Gsaxdxlv1Ev/POBFG/7/jRzuuKTJ+h9ASojqs7fZIMGDMMuit3jS?=
 =?us-ascii?Q?+ixzRihP+SGhDCosnC5DJfHNMeXRHhDq9TaEUAiDvzMHTQTEYh0N+6xU1Xwj?=
 =?us-ascii?Q?8rXxCrtwAtfYX4tEtEP1SlibXoUvMQu7vfdrZqFqBJ3JAhpoiB14jYGFHE6d?=
 =?us-ascii?Q?smaDkHanMHbM+XRRgR0y19H3uDa20aICozZB2ZNGg2aT+iUX/f/zMt/JXP+M?=
 =?us-ascii?Q?tiRXc6ZxC4iI/Ph9/6/tln2fjz8gX4tHW4VA239RlbVm1wTZlG1VFwA0HDjm?=
 =?us-ascii?Q?oh280vtaN4QUpzWDkfSlFYewTn3qiVL3biwnFCWoJJ0IwRLi1g5hFRcT4pUv?=
 =?us-ascii?Q?rzKmamyrkxDkBtw/LSGFYXtxePSUZDlTyOqltW0Z3pTqrIuBsleT/vvMxgpK?=
 =?us-ascii?Q?9o2c5W3vbvCM42SDsDF428Q0hXZfA1wi/0VQVUM1i3c1JrQB0Q0eS+zpWWDj?=
 =?us-ascii?Q?stqux2aX8XZBt0XiHv/YGF1nccdXwiJnRGMucbmY7oSyTqCU3DwooCZn1OQa?=
 =?us-ascii?Q?an1KRRuDOZSH/B7TxwysK3BiYpjrCAXDJKpabBylhIdLWwJQucWaDeY3psEs?=
 =?us-ascii?Q?NRaShcPzo7RGCrIH/ylwcP0kai6cMm2huKhr9etDyx7lsvDUfhMx4+W5FcFt?=
 =?us-ascii?Q?ti2TxkxVfC2qkdTU545nCYk+4no46+2P49lzJkXk3ieyWriHMdew3cwizojn?=
 =?us-ascii?Q?CY8daMZT+o00LGAG8MTCsdBTGlL+PWa7Xz6F94Qhjl75FRKqLg6XiQMojuT+?=
 =?us-ascii?Q?PgUpERaHsPD86261Zc+A9b70TJTNu2sMGLbaFwQpROjBwqi3DQ69zwfhBmD1?=
 =?us-ascii?Q?rGTUKkdkMQBUfCSIhAC9lZLyKvMo4IK2xdclrM/09YOocQsSkJsxFdkvzmra?=
 =?us-ascii?Q?TpKXoUWI4LQWX8CZ+qAJ3JMbv7Qqvv8k0yfH37et7bnfAmZwe+5/j2oD8CEL?=
 =?us-ascii?Q?BexYWZJXNMvNt7mXutHZbDG9ttMYeg0phEDXxuAHZtljtHnxkIPNCp46CTeO?=
 =?us-ascii?Q?rJW5rg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s+gJUQ5WwRp9i5v6Z1NHEci4SidqceB8B5AR37vVmRTB0aUMlbqZkTgq+y72Kb06CD9zy6lwxsmaG27KLfOKN4vChjz9s06hnLcolh7iLhgqxqgtrtCpcCC6d33Ne1nTmWGTbyuKjHIFlLeFTVsp8J+v9QcUB1YvdYvZpqJ/pEVWGEj3yomNRz6Uq/Yj+ZFjTrH9cOqRp3dloxR04ipC5b40AZuRD0k9redNALhZpnJM3E533ZSSu+a8JOjgAGVJy0lCbSHCLH/ba0HfsFoCxLxrw/1K+E66Wt6R0qZ0CWn1/SlsDjhYTZPWD+PYPEVxwT98IQoxzoXiqrwUr1FWaY3U4TM7XVzWhOuz6lKUHiOLpIGpXaPJ1Mji2P/9Xe0+S5+9dYQBnO67F/p0qcPGYp7zjuReLVMV6AB/js9WaOjOt4EPqr0G/faZB/NtIVx/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:11:27.6103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac9b627-9bd9-4103-63a1-08de69d3a5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645
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

Add support for DCN 4.2 in Display Core

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../display/dc/bios/command_table_helper2.c   |  1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   | 11 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 39 +++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 ++
 drivers/gpu/drm/amd/display/dc/dc.h           | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 73 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  6 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  | 11 ++-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 15 +++-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  | 60 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dio/Makefile   | 11 ++-
 .../dc/dio/dcn10/dcn10_stream_encoder.h       | 10 ++-
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   | 10 ++-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  5 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  | 13 +++-
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |  4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |  4 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   | 11 ++-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   | 10 ++-
 .../gpu/drm/amd/display/dc/hubbub/Makefile    | 10 ++-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  6 +-
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  | 10 ++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  8 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 12 ++-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   | 13 +++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 17 ++++-
 .../display/dc/hwss/hw_sequencer_private.h    |  5 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   | 24 +++++-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 42 ++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 10 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 20 ++++-
 .../amd/display/dc/inc/hw/timing_generator.h  |  4 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |  9 +++
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  | 10 ++-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   | 10 ++-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    | 13 +++-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    | 10 ++-
 drivers/gpu/drm/amd/display/dc/optc/Makefile  | 10 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 20 ++++-
 drivers/gpu/drm/amd/display/dc/pg/Makefile    | 10 ++-
 .../gpu/drm/amd/display/dc/resource/Makefile  | 18 +++++
 42 files changed, 568 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 268e2414b34f..a93a8860535a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -84,6 +84,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_3_51:
 	case DCN_VERSION_3_6:
 	case DCN_VERSION_4_01:
+	case DCN_VERSION_4_2:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 60021671b386..586a35971350 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2017 Advanced Micro Devices, Inc.
+# Copyright 2017-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -188,4 +188,13 @@ CLK_MGR_DCN401 = dcn401_clk_mgr.o dcn401_clk_mgr_smu_msg.o
 AMD_DAL_CLK_MGR_DCN401 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn401/,$(CLK_MGR_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN401)
+
+###############################################################################
+# DCN42
+###############################################################################
+CLK_MGR_DCN42 = dcn42_smu.o dcn42_clk_mgr.o
+
+AMD_DAL_CLK_MGR_DCN42 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn42/,$(CLK_MGR_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index a13d9d7dd6c5..8cef7b6c266d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2015-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -846,6 +846,16 @@ void hwss_build_fast_sequence(struct dc *dc,
 					block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
 					(*num_steps)++;
 				}
+				if (current_mpc_pipe->plane_state->update_flags.bits.cm_hist_change) {
+					block_sequence[*num_steps].params.control_cm_hist_params.dpp
+						= current_mpc_pipe->plane_res.dpp;
+					block_sequence[*num_steps].params.control_cm_hist_params.cm_hist_control
+						= current_mpc_pipe->plane_state->cm_hist_control;
+					block_sequence[*num_steps].params.control_cm_hist_params.color_space
+						= current_mpc_pipe->plane_state->color_space;
+					block_sequence[*num_steps].func = DPP_PROGRAM_CM_HIST;
+					(*num_steps)++;
+				}
 			}
 			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
 				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
@@ -1029,6 +1039,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBP_PROGRAM_MCACHE_ID:
 			hwss_program_mcache_id_and_split_coordinate(params);
 			break;
+		case DPP_PROGRAM_CM_HIST:
+			hwss_program_cm_hist(params);
+			break;
 		case PROGRAM_CURSOR_UPDATE_NOW:
 			dc->hwss.program_cursor_offload_now(
 				params->program_cursor_update_now_params.dc,
@@ -2054,6 +2067,16 @@ void hwss_program_mcache_id_and_split_coordinate(union block_sequence_params *pa
 
 }
 
+void hwss_program_cm_hist(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->control_cm_hist_params.dpp;
+
+	if (dpp && dpp->funcs->dpp_cm_hist_control)
+		dpp->funcs->dpp_cm_hist_control(dpp,
+			params->control_cm_hist_params.cm_hist_control,
+			params->control_cm_hist_params.color_space);
+}
+
 void get_surface_tile_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
@@ -3377,6 +3400,20 @@ void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_s
 	}
 }
 
+void hwss_add_dpp_program_cm_hist(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		struct cm_hist_control cm_hist_control,
+		enum dc_color_space color_space)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_CM_HIST;
+		seq_state->steps[*seq_state->num_steps].params.control_cm_hist_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.control_cm_hist_params.cm_hist_control = cm_hist_control;
+		seq_state->steps[*seq_state->num_steps].params.control_cm_hist_params.color_space = color_space;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 639831295b21..bad8515fda58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -78,6 +78,7 @@
 #include "dcn351/dcn351_resource.h"
 #include "dcn36/dcn36_resource.h"
 #include "dcn401/dcn401_resource.h"
+#include "dcn42/dcn42_resource.h"
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "dc_spl_translate.h"
 #endif
@@ -252,6 +253,9 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 			ASICREV_IS_GC_12_0_0_A0(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_4_01;
 		break;
+	case AMDGPU_FAMILY_GC_11_5_4:
+			dc_version = DCN_VERSION_4_2;
+	break;
 	default:
 		dc_version = DCE_VERSION_UNKNOWN;
 		break;
@@ -368,6 +372,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_4_01:
 		res_pool = dcn401_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_4_2:
+		res_pool = dcn42_create_resource_pool(init_data, dc);
+		break;
 #endif /* CONFIG_DRM_AMD_DC_FP */
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce08477d1ccd..94dd90d3cb67 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-2023 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -734,6 +734,8 @@ struct dc_clocks {
 	struct {
 		uint8_t base_efficiency; //LP1
 		uint8_t low_power_efficiency; //LP2
+		uint8_t z8_stutter_efficiency;
+		int z8_stutter_period;
 	} stutter_efficiency;
 };
 
@@ -1212,6 +1214,7 @@ struct dc_debug_options {
 	unsigned int num_fast_flips_to_steady_state_override;
 	bool enable_dmu_recovery;
 	unsigned int force_vmin_threshold;
+	bool enable_otg_frame_sync_pwa;
 };
 
 
@@ -1420,6 +1423,7 @@ struct dc_plane_status {
 	struct dc_plane_address current_address;
 	bool is_flip_pending;
 	bool is_right_eye;
+	struct cm_hist cm_hist;
 };
 
 union surface_update_flags {
@@ -1456,6 +1460,7 @@ union surface_update_flags {
 		uint32_t mcm_transfer_function_enable_change:1; /* disable or enable MCM transfer func */
 		uint32_t full_update:1;
 		uint32_t sdr_white_level_nits:1;
+		uint32_t cm_hist_change:1;
 	} bits;
 
 	uint32_t raw;
@@ -1540,6 +1545,7 @@ struct dc_plane_state {
 	int sharpness_level;
 	enum linear_light_scaling linear_light_scaling;
 	unsigned int sdr_white_level_nits;
+	struct cm_hist_control cm_hist_control;
 	struct spl_sharpness_range sharpness_range;
 	enum sharpness_range_source sharpness_source;
 };
@@ -1844,6 +1850,7 @@ struct dc_fast_update {
 	struct dc_transfer_func *out_transfer_func;
 	struct dc_csc_transform *output_csc_transform;
 	const struct dc_csc_transform *cursor_csc_color_matrix;
+	struct cm_hist_control *cm_hist_control;
 };
 
 struct dc_surface_update {
@@ -1876,6 +1883,7 @@ struct dc_surface_update {
 	const struct dc_csc_transform *cursor_csc_color_matrix;
 	unsigned int sdr_white_level_nits;
 	struct dc_bias_and_scale bias_and_scale;
+	struct cm_hist_control *cm_hist_control;
 };
 
 struct dc_underflow_debug_data {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 5a365bd19933..04b8b798dfff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -751,6 +751,8 @@ char *dce_version_to_string(const int version)
 		return "DCN 3.6";
 	case DCN_VERSION_4_01:
 		return "DCN 4.0.1";
+	case DCN_VERSION_4_2:
+		return "DCN 4.2";
 	default:
 		return "Unknown";
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 7121629da38e..5de8b67f693d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -271,6 +271,15 @@ enum tile_split_values_new {
 	DC_SURF_TILE_SPLIT_1KB = 0x4,
 };
 
+enum otg_pwa_sync_mode {
+	DC_OTG_PWA_FRAME_SYNC_MODE_VSYNC = 0x0,
+	DC_OTG_PWA_FRAME_SYNC_MODE_VSTARTUP = 0x1,
+};
+struct otc_pwa_frame_sync {
+	enum otg_pwa_sync_mode pwa_sync_mode;
+	uint32_t pwa_frame_sync_line_offset;
+};
+
 /* TODO: These values come from hardware spec. We need to readdress this
  * if they ever change.
  */
@@ -1138,6 +1147,7 @@ struct mcif_buf_params {
 	unsigned int		warmup_pitch;
 	unsigned int		swlock;
 	unsigned int		p_vmid;
+	uint8_t				tmz_id;
 };
 
 
@@ -1163,5 +1173,68 @@ struct phy_state {
 	enum symclk_state symclk_state;
 };
 
+enum cm_hist_tap_point {
+	CM_HIST_TAP_POINT_1,
+	CM_HIST_TAP_POINT_2,
+	CM_HIST_TAP_POINT_3,
+	CM_HIST_TAP_POINT_4,
+};
+
+enum cm_hist_src {
+	CM_HIST_SRC1,
+	CM_HIST_SRC2,
+	CM_HIST_SRC3,
+};
+
+enum cm_hist_format {
+	CM_HIST_FORMAT_FIXED_POINT,
+	CM_HIST_FORMAT_FP16_POS,
+	CM_HIST_FORMAT_FP16_POS_AND_NEG,
+};
+
+enum cm_hist_read_channel_mask {
+	CM_HIST_READ_DISABLED,
+	CM_HIST_READ_CH1,
+	CM_HIST_READ_CH2,
+	CM_HIST_READ_CH1_CH2,
+	CM_HIST_READ_CH3,
+	CM_HIST_READ_CH1_CH3,
+	CM_HIST_READ_CH2_CH3,
+	CM_HIST_READ_ALL,
+};
+
+enum cm_hist_src1_mode {
+	CM_HIST_SRC1_MODE_R_OR_CR,
+	CM_HIST_SRC1_MODE_MAX_RGB,
+};
+
+enum cm_hist_src2_mode {
+	CM_HIST_SRC2_MODE_G_OR_Y,
+	CM_HIST_SRC2_MODE_RGB_TO_Y,
+};
+
+enum cm_hist_src3_mode {
+	CM_HIST_SRC3_MODE_B_OR_CB,
+	CM_HIST_SRC3_MODE_MIN_RGB,
+};
+
+struct cm_hist_control {
+	enum cm_hist_tap_point tap_point;
+	uint32_t channels_enabled;
+	enum cm_hist_src1_mode src_1_select;
+	enum cm_hist_src2_mode src_2_select;
+	enum cm_hist_src3_mode src_3_select;
+	enum cm_hist_src ch1_src;
+	enum cm_hist_src ch2_src;
+	enum cm_hist_src ch3_src;
+	enum cm_hist_format format;
+	enum cm_hist_read_channel_mask read_channel_mask;
+};
+
+struct cm_hist {
+	uint32_t ch1[256];
+	uint32_t ch2[256];
+	uint32_t ch3[256];
+};
 #endif /* DC_HW_TYPES_H */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index bddb16bb76d4..d2e60480fb2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -1346,6 +1346,7 @@ enum dc_cm2_gpu_mem_layout {
 
 enum dc_cm2_gpu_mem_pixel_component_order {
 	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_RGBA,
+	DC_CM2_GPU_MEM_PIXEL_COMPONENT_ORDER_BGRA
 };
 
 enum dc_cm2_gpu_mem_format {
@@ -1367,6 +1368,9 @@ struct dc_cm2_gpu_mem_format_parameters {
 
 enum dc_cm2_gpu_mem_size {
 	DC_CM2_GPU_MEM_SIZE_171717,
+	DC_CM2_GPU_MEM_SIZE_333333,
+	DC_CM2_GPU_MEM_SIZE_454545,
+	DC_CM2_GPU_MEM_SIZE_656565,
 	DC_CM2_GPU_MEM_SIZE_TRANSFORMED,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/Makefile b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
index 1d5cf0f8e79d..bf7e71166b5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
@@ -1,5 +1,5 @@
 
-# Copyright 2022 Advanced Micro Devices, Inc.
+# Copyright 2022-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -100,4 +100,13 @@ DCCG_DCN401 = dcn401_dccg.o
 AMD_DAL_DCCG_DCN401 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn401/,$(DCCG_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN401)
+
+###############################################################################
+# DCN42
+###############################################################################
+DCCG_DCN42 = dcn42_dccg.o
+
+AMD_DAL_DCCG_DCN42 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn42/,$(DCCG_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 8bdffd9ff31b..ac4d77cf763f 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -359,6 +359,16 @@
 	type SYMCLK32_LE3_EN;\
 	type DP_DTO_ENABLE[MAX_PIPES];
 
+#define DCCG42_REG_FIELD_LIST(type) \
+	type OTG0_ADD_PIXEL;\
+	type OTG1_ADD_PIXEL;\
+	type OTG2_ADD_PIXEL;\
+	type OTG0_DROP_PIXEL;\
+	type OTG1_DROP_PIXEL;\
+	type OTG2_DROP_PIXEL;\
+	type OTG3_ADD_PIXEL;\
+	type OTG3_DROP_PIXEL;
+
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
 	DCCG3_REG_FIELD_LIST(uint8_t)
@@ -367,6 +377,7 @@ struct dccg_shift {
 	DCCG32_REG_FIELD_LIST(uint8_t)
 	DCCG35_REG_FIELD_LIST(uint8_t)
 	DCCG401_REG_FIELD_LIST(uint8_t)
+	DCCG42_REG_FIELD_LIST(uint8_t)
 };
 
 struct dccg_mask {
@@ -377,6 +388,7 @@ struct dccg_mask {
 	DCCG32_REG_FIELD_LIST(uint32_t)
 	DCCG35_REG_FIELD_LIST(uint32_t)
 	DCCG401_REG_FIELD_LIST(uint32_t)
+	DCCG42_REG_FIELD_LIST(uint32_t)
 };
 
 #define DCCG_REG_VARIABLE_LIST \
@@ -490,6 +502,7 @@ struct dccg_mask {
 
 struct dccg_registers {
 	DCCG_REG_VARIABLE_LIST;
+	uint32_t OTG_ADD_DROP_PIXEL_CNTL;
 };
 
 struct dcn_dccg {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
index 3d819fc5654c..1e9ab5ff3a31 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-16 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -300,6 +300,64 @@
 	ABM_SF(ABM0_DC_ABM1_HG_BIN_57_64_SHIFT_INDEX, \
 			ABM1_HG_BIN_57_64_SHIFT_INDEX, mask_sh)
 
+#define ABM_MASK_SH_LIST_DCN42(mask_sh) \
+	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
+			ABM1_HG_NUM_OF_BINS_SEL, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
+			ABM1_HG_VMAX_SEL, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_MISC_CTRL, \
+			ABM1_HG_BIN_BITWIDTH_SIZE_SEL, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_IPCSC_COEFF_SEL, \
+			ABM1_IPCSC_COEFF_SEL_R, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_IPCSC_COEFF_SEL, \
+			ABM1_IPCSC_COEFF_SEL_G, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_IPCSC_COEFF_SEL, \
+			ABM1_IPCSC_COEFF_SEL_B, mask_sh), \
+	ABM_SF(ABM0_BL1_PWM_CURRENT_ABM_LEVEL, \
+			BL1_PWM_CURRENT_ABM_LEVEL, mask_sh), \
+	ABM_SF(ABM0_BL1_PWM_TARGET_ABM_LEVEL, \
+			BL1_PWM_TARGET_ABM_LEVEL, mask_sh), \
+	ABM_SF(ABM0_BL1_PWM_USER_LEVEL, \
+			BL1_PWM_USER_LEVEL, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, \
+			ABM1_LS_MIN_PIXEL_VALUE_THRES, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_LS_MIN_MAX_PIXEL_VALUE_THRES, \
+			ABM1_LS_MAX_PIXEL_VALUE_THRES, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HGLS_REG_READ_PROGRESS, \
+			ABM1_HG_REG_READ_MISSED_FRAME_CLEAR, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HGLS_REG_READ_PROGRESS, \
+			ABM1_LS_REG_READ_MISSED_FRAME_CLEAR, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HGLS_REG_READ_PROGRESS, \
+			ABM1_BL_REG_READ_MISSED_FRAME_CLEAR, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_OFFSET_SLOPE_DATA, \
+			ABM1_ACE_SLOPE_DATA, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_OFFSET_SLOPE_DATA, \
+			ABM1_ACE_OFFSET_DATA, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_PWL_CNTL, \
+			ABM1_ACE_OFFSET_SLOPE_INDEX, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_PWL_CNTL, \
+			ABM1_ACE_IGNORE_MASTER_LOCK_EN, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_PWL_CNTL, \
+			ABM1_ACE_READBACK_DB_REG_VALUE_EN, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_PWL_CNTL, \
+			ABM1_ACE_DBUF_REG_UPDATE_PENDING, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_ACE_PWL_CNTL, \
+			ABM1_ACE_LOCK, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_RESULT_DATA, \
+			ABM1_HG_RESULT_DATA, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_RESULT_INDEX, \
+			ABM1_HG_RESULT_INDEX, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_BIN_33_40_SHIFT_INDEX, \
+			ABM1_HG_BIN_33_40_SHIFT_INDEX, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_BIN_33_64_SHIFT_FLAG, \
+			ABM1_HG_BIN_33_64_SHIFT_FLAG, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_BIN_41_48_SHIFT_INDEX, \
+			ABM1_HG_BIN_41_48_SHIFT_INDEX, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_BIN_49_56_SHIFT_INDEX, \
+			ABM1_HG_BIN_49_56_SHIFT_INDEX, mask_sh), \
+	ABM_SF(ABM0_DC_ABM1_HG_BIN_57_64_SHIFT_INDEX, \
+			ABM1_HG_BIN_57_64_SHIFT_INDEX, mask_sh)
+
 #define ABM_REG_FIELD_LIST(type) \
 	type ABM1_HG_NUM_OF_BINS_SEL; \
 	type ABM1_HG_VMAX_SEL; \
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 2f5619078e1f..4832533b9514 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2020 Advanced Micro Devices, Inc.
+# Copyright 2020-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -123,4 +123,13 @@ DIO_DCN401 = dcn401_dio_link_encoder.o dcn401_dio_stream_encoder.o
 AMD_DAL_DIO_DCN401 = $(addprefix $(AMDDALPATH)/dc/dio/dcn401/,$(DIO_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN401)
+
+###############################################################################
+# DCN42
+###############################################################################
+DIO_DCN42 = dcn42_dio_link_encoder.o dcn42_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN42 = $(addprefix $(AMDDALPATH)/dc/dio/dcn42/,$(DIO_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h
index 54a6a4ebd636..755367506556 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -190,6 +190,7 @@ struct dcn10_stream_enc_registers {
 	uint32_t DIG_FE_CLK_CNTL;
 	uint32_t DIG_FE_EN_CNTL;
 	uint32_t STREAM_MAPPER_CONTROL;
+	uint32_t DIG_FE_AUDIO_CNTL;
 };
 
 
@@ -598,6 +599,11 @@ struct dcn10_stream_enc_registers {
 	type DP_VID_N_INTERVAL;\
 	type DIG_FIFO_OUTPUT_PIXEL_PER_CYCLE;\
 	type DP_STEER_FIFO_ENABLE
+
+#define SE_REG_FIELD_LIST_DCN_AUDIO_COMMON(type) \
+	type DIG_FE_INPUT_MUX_AUDIO_STREAM_SOURCE_SEL;\
+	type APG_CLOCK_ENABLE
+
 struct dcn10_stream_encoder_shift {
 	SE_REG_FIELD_LIST_DCN1_0(uint8_t);
 	uint8_t HDMI_ACP_SEND;
@@ -606,6 +612,7 @@ struct dcn10_stream_encoder_shift {
 	SE_REG_FIELD_LIST_DCN3_1_COMMON(uint8_t);
 	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint8_t);
 	SE_REG_FIELD_LIST_DCN4_01_COMMON(uint32_t);
+	SE_REG_FIELD_LIST_DCN_AUDIO_COMMON(uint32_t);
 };
 
 struct dcn10_stream_encoder_mask {
@@ -616,6 +623,7 @@ struct dcn10_stream_encoder_mask {
 	SE_REG_FIELD_LIST_DCN3_1_COMMON(uint32_t);
 	SE_REG_FIELD_LIST_DCN3_5_COMMON(uint32_t);
 	SE_REG_FIELD_LIST_DCN4_01_COMMON(uint32_t);
+	SE_REG_FIELD_LIST_DCN_AUDIO_COMMON(uint32_t);
 };
 
 struct dcn10_stream_encoder {
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/Makefile b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
index 8324a56fe7db..2595b2504f9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dpp/Makefile
@@ -1,5 +1,5 @@
 
-# Copyright 2022 Advanced Micro Devices, Inc.
+# Copyright 2022-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -80,4 +80,12 @@ AMD_DAL_DPP_DCN401 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn401/,$(DPP_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN401)
 
+###############################################################################
+# DCN42
+###############################################################################
+DPP_DCN42 = dcn42_dpp.o
+
+AMD_DAL_DPP_DCN42 = $(addprefix $(AMDDALPATH)/dc/dpp/dcn42/,$(DPP_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DPP_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 58b9f1cd0825..debcf308cb3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -1,4 +1,5 @@
-/* Copyright 2023 Advanced Micro Devices, Inc.
+/* SPDX-License-Identifier: MIT */
+/* Copyright 2023-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -653,6 +654,8 @@
 
 struct dcn401_dpp_registers {
 	DPP_REG_VARIABLE_LIST_DCN401;
+	uint32_t ALPHA_2BIT_LUT01;
+	uint32_t ALPHA_2BIT_LUT23;
 };
 
 struct dcn401_dpp_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/Makefile b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
index b72e2a9f9a28..f8142ebf363f 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/gpio/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2017 Advanced Micro Devices, Inc.
+# Copyright 2017-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -132,3 +132,14 @@ AMD_DAL_GPIO_DCN401 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn401/,$(GPIO_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN401)
 
+###############################################################################
+# DCN 4.2
+###############################################################################
+
+GPIO_DCN42 = hw_translate_dcn42.o hw_factory_dcn42.o
+
+AMD_DAL_GPIO_DCN42 = $(addprefix $(AMDDALPATH)/dc/gpio/dcn42/,$(GPIO_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_GPIO_DCN42)
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 8bc67ca42197..f3d562c8df4c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -53,6 +53,7 @@
 #include "dcn315/hw_factory_dcn315.h"
 #include "dcn32/hw_factory_dcn32.h"
 #include "dcn401/hw_factory_dcn401.h"
+#include "dcn42/hw_factory_dcn42.h"
 
 bool dal_hw_factory_init(
 	struct hw_factory *factory,
@@ -118,6 +119,9 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_4_01:
 		dal_hw_factory_dcn401_init(factory);
 		return true;
+	case DCN_VERSION_4_2:
+		dal_hw_factory_dcn42_init(factory);
+		return true;
 	default:
 		ASSERT_CRITICAL(false);
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index cb79a2832287..1c977fc4d0e3 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -53,6 +53,7 @@
 #include "dcn315/hw_translate_dcn315.h"
 #include "dcn32/hw_translate_dcn32.h"
 #include "dcn401/hw_translate_dcn401.h"
+#include "dcn42/hw_translate_dcn42.h"
 
 /*
  * This unit
@@ -119,6 +120,9 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_4_01:
 		dal_hw_translate_dcn401_init(translate);
 		return true;
+	case DCN_VERSION_4_2:
+		dal_hw_translate_dcn42_init(translate);
+		return true;
 	default:
 		BREAK_TO_DEBUGGER();
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/Makefile b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
index 7f2c9ee0dff1..25b196714bd8 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2020 Advanced Micro Devices, Inc.
+# Copyright 2020-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -47,4 +47,13 @@ HPO_DCN32 = dcn32_hpo_dp_link_encoder.o
 AMD_DAL_HPO_DCN32 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn32/,$(HPO_DCN32))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN32)
+
+###############################################################################
+# DCN42
+###############################################################################
+HPO_DCN42 = dcn42_hpo_dp_link_encoder.o
+
+AMD_DAL_HPO_DCN42 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn42/,$(HPO_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
index 82c3b3ac1f0d..d96fcc59cc0e 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2019 Advanced Micro Devices, Inc.
+ * Copyright 2019-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -208,17 +208,24 @@
 	type CRC_CONT_MODE_ENABLE;\
 	type HBLANK_MINIMUM_SYMBOL_WIDTH
 
+#define DCN4_2_HPO_DP_STREAM_ENC_REG_FIELD_LIST(type) \
+	type DP_STREAM_ENC_APG_CLOCK_EN
 
+#define DCN4_2_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh)\
+	DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh),\
+	SE_SF(DP_STREAM_ENC0_DP_STREAM_ENC_AUDIO_CONTROL, DP_STREAM_ENC_APG_CLOCK_EN, mask_sh)
 struct dcn31_hpo_dp_stream_encoder_registers {
 	DCN3_1_HPO_DP_STREAM_ENC_REGS;
 };
 
 struct dcn31_hpo_dp_stream_encoder_shift {
 	DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(uint8_t);
+	DCN4_2_HPO_DP_STREAM_ENC_REG_FIELD_LIST(uint8_t);
 };
 
 struct dcn31_hpo_dp_stream_encoder_mask {
 	DCN3_1_HPO_DP_STREAM_ENC_REG_FIELD_LIST(uint32_t);
+	DCN4_2_HPO_DP_STREAM_ENC_REG_FIELD_LIST(uint32_t);
 };
 
 struct dcn31_hpo_dp_stream_encoder {
@@ -241,5 +248,4 @@ void dcn31_hpo_dp_stream_encoder_construct(
 	const struct dcn31_hpo_dp_stream_encoder_shift *hpo_se_shift,
 	const struct dcn31_hpo_dp_stream_encoder_mask *hpo_se_mask);
 
-
 #endif   // __DAL_DCN31_HPO_STREAM_ENCODER_H__
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
index 66ca5a6a0415..29c8e2651442 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
@@ -1,5 +1,5 @@
 
-# Copyright 2022 Advanced Micro Devices, Inc.
+# Copyright 2022-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -101,4 +101,12 @@ AMD_DAL_HUBBUB_DCN401 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn401/,$(HUBBUB_DCN
 AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN401)
 
 ###############################################################################
+# DCN42
+###############################################################################
+HUBBUB_DCN42 = dcn42_hubbub.o
+
+AMD_DAL_HUBBUB_DCN42 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn42/,$(HUBBUB_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN42)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index 990d3cd8e050..ff9a1ae29474 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -441,6 +441,8 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_VALUE;\
 		type DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_ENABLE
 
+#define HUBBUB_REG_FIELD_LIST_DCN4_2(type) \
+	type URGENT_ZERO_SIZE_REQ_EN
 struct dcn_hubbub_shift {
 	DCN_HUBBUB_REG_FIELD_LIST(uint8_t);
 	HUBBUB_STUTTER_REG_FIELD_LIST(uint8_t);
@@ -449,6 +451,7 @@ struct dcn_hubbub_shift {
 	HUBBUB_REG_FIELD_LIST_DCN32(uint8_t);
 	HUBBUB_REG_FIELD_LIST_DCN35(uint8_t);
 	HUBBUB_REG_FIELD_LIST_DCN4_01(uint8_t);
+	HUBBUB_REG_FIELD_LIST_DCN4_2(uint8_t);
 
 };
 
@@ -460,6 +463,7 @@ struct dcn_hubbub_mask {
 	HUBBUB_REG_FIELD_LIST_DCN32(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN35(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN4_01(uint32_t);
+	HUBBUB_REG_FIELD_LIST_DCN4_2(uint8_t);
 
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/Makefile b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
index a2d1128de7a1..e0799bb873e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hubp/Makefile
@@ -1,5 +1,5 @@
 
-# Copyright 2022 Advanced Micro Devices, Inc.
+# Copyright 2022-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -94,4 +94,12 @@ AMD_DAL_HUBP_DCN401 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn401/,$(HUBP_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN401)
 
+###############################################################################
+
+HUBP_DCN42 = dcn42_hubp.o
+
+AMD_DAL_HUBP_DCN42 = $(addprefix $(AMDDALPATH)/dc/hubp/dcn42/,$(HUBP_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBP_DCN42)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 7062e6653062..80be394a8852 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-17 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -288,16 +288,22 @@
 	type MCACHEID_MALL_PREF_2H_P1;\
 	type HUBP_FGCG_REP_DIS
 
+#define DCN42_HUBP_REG_FIELD_VARIABLE_LIST(type) \
+	type HUBP_3DLUT_CROSSBAR_SEL_G;\
+	type HUBP_3DLUT_CROSSBAR_SEL_B;\
+	type HUBP_3DLUT_CROSSBAR_SEL_R
 struct dcn_hubp2_registers {
 	DCN401_HUBP_REG_COMMON_VARIABLE_LIST;
 };
 
 struct dcn_hubp2_shift {
 	DCN401_HUBP_REG_FIELD_VARIABLE_LIST(uint8_t);
+	DCN42_HUBP_REG_FIELD_VARIABLE_LIST(uint8_t);
 };
 
 struct dcn_hubp2_mask {
 	DCN401_HUBP_REG_FIELD_VARIABLE_LIST(uint32_t);
+	DCN42_HUBP_REG_FIELD_VARIABLE_LIST(uint32_t);
 };
 
 struct dcn20_hubp {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index bee617ca0838..08cbbf87a19f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -1,5 +1,4 @@
-
-# Copyright 2022 Advanced Micro Devices, Inc.
+# Copyright 2022-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -199,4 +198,13 @@ HWSS_DCN401 = dcn401_hwseq.o dcn401_init.o
 AMD_DAL_HWSS_DCN401 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn401/,$(HWSS_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN401)
+
+###############################################################################
+
+HWSS_DCN42 = dcn42_hwseq.o dcn42_init.o
+
+AMD_DAL_HWSS_DCN42 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn42/,$(HWSS_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN42)
+
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index f66a38f43a09..dc8feca578c5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016, 2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -700,6 +700,8 @@ struct dce_hwseq_registers {
 	uint32_t DOMAIN23_PG_STATUS;
 	uint32_t DOMAIN24_PG_STATUS;
 	uint32_t DOMAIN25_PG_STATUS;
+	uint32_t DOMAIN26_PG_CONFIG;
+	uint32_t DOMAIN26_PG_STATUS;
 };
  /* set field name */
 #define HWS_SF(blk_name, reg_name, field_name, post_fix)\
@@ -1245,6 +1247,13 @@ struct dce_hwseq_registers {
 	type DOMAIN25_PGFSM_PWR_STATUS; \
 	type DOMAIN_DESIRED_PWR_STATE;
 
+#define HWSEQ_DCN42_REG_FIELD_LIST(type) \
+	type DPIASYMCLK4_GATE_DISABLE;\
+	type DPIASYMCLK5_GATE_DISABLE;\
+	type DOMAIN26_POWER_FORCEON; \
+	type DOMAIN26_POWER_GATE; \
+	type DOMAIN26_PGFSM_PWR_STATUS;
+
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN_REG_FIELD_LIST(uint8_t)
@@ -1253,6 +1262,7 @@ struct dce_hwseq_shift {
 	HWSEQ_DCN31_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN35_REG_FIELD_LIST(uint8_t)
 	HWSEQ_DCN401_REG_FIELD_LIST(uint8_t)
+	HWSEQ_DCN42_REG_FIELD_LIST(uint8_t)
 };
 
 struct dce_hwseq_mask {
@@ -1263,6 +1273,7 @@ struct dce_hwseq_mask {
 	HWSEQ_DCN31_REG_FIELD_LIST(uint32_t)
 	HWSEQ_DCN35_REG_FIELD_LIST(uint32_t)
 	HWSEQ_DCN401_REG_FIELD_LIST(uint32_t)
+	HWSEQ_DCN42_REG_FIELD_LIST(uint32_t)
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 51b0f0fd8fcd..4ec324857759 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2015-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -174,6 +174,12 @@ struct program_mcache_id_and_split_coordinate {
 	struct dml2_hubp_pipe_mcache_regs *mcache_regs;
 };
 
+struct control_cm_hist_params {
+	struct dpp *dpp;
+	struct cm_hist_control cm_hist_control;
+	enum dc_color_space color_space;
+};
+
 struct program_cursor_update_now_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -755,6 +761,7 @@ union block_sequence_params {
 	struct dmub_hw_control_lock_fast_params dmub_hw_control_lock_fast_params;
 	struct program_surface_config_params program_surface_config_params;
 	struct program_mcache_id_and_split_coordinate program_mcache_id_and_split_coordinate;
+	struct control_cm_hist_params control_cm_hist_params;
 	struct program_cursor_update_now_params program_cursor_update_now_params;
 	struct hubp_wait_pipe_read_start_params hubp_wait_pipe_read_start_params;
 	struct apply_update_flags_for_phantom_params apply_update_flags_for_phantom_params;
@@ -879,6 +886,7 @@ enum block_sequence_func {
 	DMUB_HW_CONTROL_LOCK_FAST,
 	HUBP_PROGRAM_SURFACE_CONFIG,
 	HUBP_PROGRAM_MCACHE_ID,
+	DPP_PROGRAM_CM_HIST,
 	PROGRAM_CURSOR_UPDATE_NOW,
 	HUBP_WAIT_PIPE_READ_START,
 	HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM,
@@ -1411,6 +1419,8 @@ void hwss_program_surface_config(union block_sequence_params *params);
 
 void hwss_program_mcache_id_and_split_coordinate(union block_sequence_params *params);
 
+void hwss_program_cm_hist(union block_sequence_params *params);
+
 void hwss_set_odm_combine(union block_sequence_params *params);
 
 void hwss_set_odm_bypass(union block_sequence_params *params);
@@ -1761,6 +1771,11 @@ void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_s
 		bool use_default_params,
 		struct pipe_ctx *pipe_ctx);
 
+void hwss_add_dpp_program_cm_hist(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		struct cm_hist_control cm_hist_control,
+		enum dc_color_space color_space);
+
 void hwss_add_dc_ip_request_cntl(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 406db231bc72..8e3f54fb53fd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright 2015-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -222,6 +222,9 @@ struct hwseq_private_funcs {
 	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
 	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 	void (*dc_ip_request_cntl)(struct dc *dc, bool enable);
+	void (*program_cm_hist)(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		const struct dc_plane_state *plane_state);
 };
 
 struct dce_hwseq {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 2c9a4a12bd8a..91eba1985bab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * Copyright 2012-16 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -95,6 +96,26 @@ struct dcn301_clk_internal {
 	uint32_t CLK1_CLK3_BYPASS_CNTL; //dcfclk bypass
 };
 
+struct dcn42_clk_internal {
+	int dummy;
+	uint32_t CLK8_CLK0_CURRENT_CNT; //dispclk
+	uint32_t CLK8_CLK1_CURRENT_CNT; //dppclk
+	uint32_t CLK8_CLK2_CURRENT_CNT; //dprefclk
+	uint32_t CLK8_CLK3_CURRENT_CNT; //dcfclk
+	uint32_t CLK8_CLK4_CURRENT_CNT; //dtbclk
+	uint32_t CLK8_CLK0_DS_CNTL;	    //dispclk deep_sleep_divider
+	uint32_t CLK8_CLK1_DS_CNTL;	    //dppclk deep_sleep_divider
+	uint32_t CLK8_CLK2_DS_CNTL;	    //dprefclk deep_sleep_divider
+	uint32_t CLK8_CLK3_DS_CNTL;	    //dcfclk deep_sleep_divider
+	uint32_t CLK8_CLK4_DS_CNTL;	    //dtbclk deep_sleep_divider
+	uint32_t CLK8_CLK0_BYPASS_CNTL; //dispclk bypass
+	uint32_t CLK8_CLK1_BYPASS_CNTL; //dppclk bypass
+	uint32_t CLK8_CLK2_BYPASS_CNTL; //dprefclk bypass
+	uint32_t CLK8_CLK3_BYPASS_CNTL; //dcfclk bypass
+	uint32_t CLK8_CLK4_BYPASS_CNTL; //dtbclk bypass
+	uint32_t CLK8_CLK_TICK_CNT__TIMER_THRESHOLD;
+};
+
 /* Will these bw structures be ASIC specific? */
 
 #define MAX_NUM_DPM_LVL		8
@@ -194,6 +215,7 @@ struct clk_state_registers_and_bypass {
 	uint32_t dcfclk_bypass;
 	uint32_t dprefclk_bypass;
 	uint32_t dispclk_bypass;
+	uint32_t timer_threhold;
 };
 
 struct rv1_clk_internal {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index bac8febad69a..37521e17b72f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: MIT */
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -234,6 +235,29 @@ enum dentist_divider_range {
 #define CLK_COMMON_MASK_SH_LIST_DCN401(mask_sh) \
 	CLK_COMMON_MASK_SH_LIST_DCN321(mask_sh)
 
+#define CLK_REG_LIST_DCN42()	  \
+	SR(DENTIST_DISPCLK_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK_TICK_CNT_CONFIG_REG), \
+	CLK_SR_DCN42(CLK8_CLK0_CURRENT_CNT), \
+	CLK_SR_DCN42(CLK8_CLK1_CURRENT_CNT), \
+	CLK_SR_DCN42(CLK8_CLK2_CURRENT_CNT), \
+	CLK_SR_DCN42(CLK8_CLK3_CURRENT_CNT), \
+	CLK_SR_DCN42(CLK8_CLK4_CURRENT_CNT), \
+	CLK_SR_DCN42(CLK8_CLK0_BYPASS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK1_BYPASS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK2_BYPASS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK3_BYPASS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK4_BYPASS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK0_DS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK1_DS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK2_DS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK3_DS_CNTL), \
+	CLK_SR_DCN42(CLK8_CLK4_DS_CNTL)
+
+#define CLK_COMMON_MASK_SH_LIST_DCN42(mask_sh) 0
+
+
+
 #define CLK_REG_FIELD_LIST(type) \
 	type DPREFCLK_SRC_SEL; \
 	type DENTIST_DPREFCLK_WDIVIDER; \
@@ -309,6 +333,22 @@ struct clk_mgr_registers {
 	uint32_t CLK1_CLK5_ALLOW_DS;
 	uint32_t CLK5_spll_field_8;
 	uint32_t CLK6_spll_field_8;
+	uint32_t CLK8_CLK0_CURRENT_CNT;
+	uint32_t CLK8_CLK1_CURRENT_CNT;
+	uint32_t CLK8_CLK2_CURRENT_CNT;
+	uint32_t CLK8_CLK3_CURRENT_CNT;
+	uint32_t CLK8_CLK4_CURRENT_CNT;
+	uint32_t CLK8_CLK0_DS_CNTL;
+	uint32_t CLK8_CLK1_DS_CNTL;
+	uint32_t CLK8_CLK2_DS_CNTL;
+	uint32_t CLK8_CLK3_DS_CNTL;
+	uint32_t CLK8_CLK4_DS_CNTL;
+	uint32_t CLK8_CLK0_BYPASS_CNTL;
+	uint32_t CLK8_CLK1_BYPASS_CNTL;
+	uint32_t CLK8_CLK2_BYPASS_CNTL;
+	uint32_t CLK8_CLK3_BYPASS_CNTL;
+	uint32_t CLK8_CLK4_BYPASS_CNTL;
+	uint32_t CLK8_CLK_TICK_CNT_CONFIG_REG;
 };
 
 struct clk_mgr_shift {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index d88b57d4f512..39215ecb480e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -367,6 +367,14 @@ struct dpp_funcs {
 
 	void (*dpp_force_disable_cursor)(struct dpp *dpp_base);
 
+	void (*dpp_cm_hist_control)(
+		struct dpp *dpp_base,
+		struct cm_hist_control cm_hist_control,
+		enum dc_color_space color_space);
+
+	bool (*dpp_cm_hist_read)(
+		struct dpp *dpp_base,
+		struct cm_hist *cm_hist);
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index a8d1abe20f62..0db607f2a410 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -1042,6 +1042,24 @@ struct mpc_funcs {
 
 	void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
 
+/**
+ * @get_3dlut_fast_load_status:
+ *
+ * Get 3D LUT fast load status and reference them with done, soft_underflow and hard_underflow pointers.
+ *
+ * Parameters:
+ * - [in/out] mpc - MPC context.
+ * - [in] mpcc_id
+ * - [in/out] done
+ * - [in/out] soft_underflow
+ * - [in/out] hard_underflow
+ *
+ * Return:
+ *
+ * void
+ */
+	void (*get_3dlut_fast_load_status)(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow);
+
 	/**
 	* @populate_lut:
 	*
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 671ab1fc7320..2f70bb476c97 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -518,6 +518,8 @@ struct timing_generator_funcs {
 	bool (*wait_update_lock_status)(struct timing_generator *tg, bool locked);
 	void (*read_otg_state)(struct timing_generator *tg, struct dcn_otg_state *s);
 	void (*optc_read_reg_state)(struct timing_generator *tg, struct dcn_optc_reg_state *optc_reg_state);
+	void (*enable_otg_pwa)(struct timing_generator *tg,  struct otc_pwa_frame_sync *pwa_param);
+	void (*disable_otg_pwa)(struct timing_generator *tg);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/irq/Makefile b/drivers/gpu/drm/amd/display/dc/irq/Makefile
index b5e14d792378..807b73c2a758 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/irq/Makefile
@@ -198,3 +198,12 @@ IRQ_DCN401 = irq_service_dcn401.o
 AMD_DAL_IRQ_DCN401= $(addprefix $(AMDDALPATH)/dc/irq/dcn401/,$(IRQ_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN401)
+
+###############################################################################
+# DCN 42
+###############################################################################
+IRQ_DCN42 = irq_service_dcn42.o
+
+AMD_DAL_IRQ_DCN42= $(addprefix $(AMDDALPATH)/dc/irq/dcn42/,$(IRQ_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_IRQ_DCN42)
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
index 2d4b7a85847d..afc376defa0b 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2020 Advanced Micro Devices, Inc.
+# Copyright 2020-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -52,3 +52,11 @@ AMD_DAL_MMHUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn35/,$(MMHUBBUB
 AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN35)
 endif
 
+###############################################################################
+# DCN42
+###############################################################################
+MMHUBBUB_DCN42 = dcn42_mmhubbub.o
+
+AMD_DAL_MMHUBBUB_DCN42 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn42/,$(MMHUBBUB_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN42)
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
index 5402c3529f5e..cc23aae3728a 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2020 Advanced Micro Devices, Inc.
+# Copyright 2020-2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -69,4 +69,12 @@ AMD_DAL_MPC_DCN401 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn401/,$(MPC_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN401)
 
+###############################################################################
+# DCN42
+###############################################################################
+MPC_DCN42 = dcn42_mpc.o
+
+AMD_DAL_MPC_DCN42 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn42/,$(MPC_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index eeac13fdd6f5..ce1ee2062e41 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2023 Advanced Micro Devices, Inc.
+ * Copyright 2023-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -47,6 +47,16 @@ void mpc401_update_3dlut_fast_load_select(struct mpc *mpc, int mpcc_id, int hubp
 	REG_SET(MPCC_MCM_3DLUT_FAST_LOAD_SELECT[mpcc_id], 0, MPCC_MCM_3DLUT_FL_SEL, hubp_idx);
 }
 
+void mpc401_get_3dlut_fast_load_status(struct mpc *mpc, int mpcc_id, uint32_t *done, uint32_t *soft_underflow, uint32_t *hard_underflow)
+{
+	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
+
+	REG_GET_3(MPCC_MCM_3DLUT_FAST_LOAD_STATUS[mpcc_id],
+			MPCC_MCM_3DLUT_FL_DONE, done,
+			MPCC_MCM_3DLUT_FL_SOFT_UNDERFLOW, soft_underflow,
+			MPCC_MCM_3DLUT_FL_HARD_UNDERFLOW, hard_underflow);
+}
+
 void mpc401_set_movable_cm_location(struct mpc *mpc, enum mpcc_movable_cm_location location, int mpcc_id)
 {
 	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
@@ -602,6 +612,7 @@ static const struct mpc_funcs dcn401_mpc_funcs = {
 	.set_bg_color = mpc1_set_bg_color,
 	.set_movable_cm_location = mpc401_set_movable_cm_location,
 	.update_3dlut_fast_load_select = mpc401_update_3dlut_fast_load_select,
+	.get_3dlut_fast_load_status = mpc401_get_3dlut_fast_load_status,
 	.populate_lut = mpc401_populate_lut,
 	.program_lut_read_write_control = mpc401_program_lut_read_write_control,
 	.program_lut_mode = mpc401_program_lut_mode,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index fdc42f8ab3ff..6d842d7b95c7 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2023 Advanced Micro Devices, Inc.
+ * Copyright 2023-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -184,6 +184,7 @@ struct dcn401_mpc_mask {
 
 struct dcn401_mpc_registers {
 	MPC_REG_VARIABLE_LIST_DCN4_01
+	uint32_t MPCC_CONTROL2[MAX_MPCC];
 };
 
 struct dcn401_mpc {
@@ -249,6 +250,13 @@ void mpc_read_gamut_remap(struct mpc *mpc,
 	enum mpcc_gamut_remap_id gamut_remap_block_id,
 	uint32_t *mode_select);
 
+void mpc401_get_3dlut_fast_load_status(
+	struct mpc *mpc,
+	int mpcc_id,
+	uint32_t *done,
+	uint32_t *soft_underflow,
+	uint32_t *hard_underflow);
+
 void mpc401_update_3dlut_fast_load_select(
 	struct mpc *mpc,
 	int mpcc_id,
diff --git a/drivers/gpu/drm/amd/display/dc/optc/Makefile b/drivers/gpu/drm/amd/display/dc/optc/Makefile
index 29fb610c8660..06c98d70eabc 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/optc/Makefile
@@ -104,11 +104,19 @@ AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN35)
 
 ###############################################################################
 
-###############################################################################
 OPTC_DCN401 = dcn401_optc.o
 
 AMD_DAL_OPTC_DCN401 = $(addprefix $(AMDDALPATH)/dc/optc/dcn401/,$(OPTC_DCN401))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN401)
+
+###############################################################################
+
+OPTC_DCN42 = dcn42_optc.o
+
+AMD_DAL_OPTC_DCN42 = $(addprefix $(AMDDALPATH)/dc/optc/dcn42/,$(OPTC_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPTC_DCN42)
+
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index 0b3f974f452e..cf05620fd8f5 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
+ * Copyright 2012-2026 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -253,8 +253,20 @@
 	uint32_t OTG_CRC1_DATA_B32
 
 
+#define OPTC_REG_VARIABLE_LIST_DCN42 \
+	uint32_t OTG_PWA_FRAME_SYNC_CONTROL; \
+	uint32_t OTG_CRC0_DATA_R; \
+	uint32_t OTG_CRC1_DATA_R; \
+	uint32_t OTG_CRC2_DATA_R; \
+	uint32_t OTG_CRC3_DATA_R; \
+	uint32_t OTG_CRC0_DATA_G; \
+	uint32_t OTG_CRC1_DATA_G; \
+	uint32_t OTG_CRC2_DATA_G; \
+	uint32_t OTG_CRC3_DATA_G
+
 struct dcn_optc_registers {
 	OPTC_REG_VARIABLE_LIST_DCN;
+	OPTC_REG_VARIABLE_LIST_DCN42;
 };
 
 #define TG_COMMON_MASK_SH_LIST_DCN(mask_sh)\
@@ -679,6 +691,10 @@ struct dcn_optc_registers {
 	type OTG_UNBLANK;\
 	type OTG_PSTATE_ALLOW_WIDTH_MIN;
 
+#define TG_REG_FIELD_LIST_DCN42(type) \
+	type OTG_PWA_FRAME_SYNC_EN;\
+	type OTG_PWA_FRAME_SYNC_VCOUNT_MODE;\
+	type OTG_PWA_FRAME_SYNC_LINE;
 
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
@@ -687,6 +703,7 @@ struct dcn_optc_shift {
 	TG_REG_FIELD_LIST_DCN3_5(uint8_t)
 	TG_REG_FIELD_LIST_DCN3_6(uint8_t)
 	TG_REG_FIELD_LIST_DCN401(uint8_t)
+	TG_REG_FIELD_LIST_DCN42(uint8_t)
 };
 
 struct dcn_optc_mask {
@@ -696,6 +713,7 @@ struct dcn_optc_mask {
 	TG_REG_FIELD_LIST_DCN3_5(uint32_t)
 	TG_REG_FIELD_LIST_DCN3_6(uint32_t)
 	TG_REG_FIELD_LIST_DCN401(uint32_t)
+	TG_REG_FIELD_LIST_DCN42(uint32_t)
 };
 
 void dcn10_timing_generator_init(struct optc *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/pg/Makefile b/drivers/gpu/drm/amd/display/dc/pg/Makefile
index ec11d3157a57..56f610cc8406 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/pg/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright 2020 Advanced Micro Devices, Inc.
+# Copyright 2020, 2026 Advanced Micro Devices, Inc.
 #
 # Permission is hereby granted, free of charge, to any person obtaining a
 # copy of this software and associated documentation files (the "Software"),
@@ -32,4 +32,12 @@ PG_DCN35 = dcn35_pg_cntl.o
 AMD_DAL_PG_DCN35 = $(addprefix $(AMDDALPATH)/dc/pg/dcn35/,$(PG_DCN35))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_PG_DCN35)
+###############################################################################
+# DCN42
+###############################################################################
+PG_DCN42 = dcn42_pg_cntl.o
+
+AMD_DAL_PG_DCN42 = $(addprefix $(AMDDALPATH)/dc/pg/dcn42/,$(PG_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_PG_DCN42)
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index 5b42da8b79c2..1a17a885fe84 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -222,4 +222,22 @@ AMD_DAL_RESOURCE_DCN401 = $(addprefix $(AMDDALPATH)/dc/resource/dcn401/,$(RESOUR
 
 AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN401)
 
+###############################################################################
+# DCN42
+###############################################################################
+RESOURCE_DCN42 = dcn42_resource.o dcn42_resource_fpu.o
+
+AMD_DAL_RESOURCE_DCN42 = $(addprefix $(AMDDALPATH)/dc/resource/dcn42/,$(RESOURCE_DCN42))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN42)
+
+# FPU Compile Flags for FPU files
+resource_ccflags := $(CC_FLAGS_FPU)
+resource_rcflags := $(CC_FLAGS_NO_FPU)
+
+CFLAGS_$(AMDDALPATH)/dc/resource/dcn42/dcn42_resource_fpu.o := $(resource_ccflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/resource/dcn42/dcn42_resource_fpu.o := $(resource_rcflags)
+
+###############################################################################
 endif
+
-- 
2.34.1

