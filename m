Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDBCC52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8294D10E539;
	Thu, 15 Aug 2024 22:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+BpFAcr";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B246310E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWQIg/iphtCo0Wf8nYuAJz9kdAXGQIkCVVdaX8i8Y1C/Q8ZntXilSPj/kECVhhobFIraljvWTDv8KrZw/TTG3m8JA0ee1oCRaeW29TDtqudfJCsvRRPUhNOwhu85jSDEvcRts6pU11ksu1QuwjDsts0x1zPlM/CezqVV4cTK6js8Uub7T7B1Xvz8m05HndxCl6sdIYfKYCqDmQaA1GCuqXHgxnZeIoJBss2pWDxmeGr1a3u3Hcj0lYHzfPn5PtJfwgyN1EFP3Mq37/wSQM5NXiptNhbbe9sYYpbcA4epYuZSfhOnDTdgA/za9Mu/gP/WsA6usoiw0HAVi9vOUKi4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jlxnRVnKU9RdO3WDLzahLQzhtypVhPSxSVr9O3aU5g=;
 b=MGYvhuurmFivBSLf+Dtfl4FKZ+/AkQAYszq//gywjGEP3g8UEhRvCnGHtqN6cld54gvtGzBKo1P0uklVCueOIWzZCUeLovo65No7cvuOBi5dErUm1zbWqZBQr4cSDIk2vI47xf7Fub/kqKZt2IiwB7zR2b9ggmlttpiFwponDVn31v/42vGbXzK77OkoLAho5enl2qI0vKjXgLvTMOG7eR3kzrvkJFZO7SnUd1/P8dgRdBwtFapgGJ25M/btI68pbc1S1/RE+HafLjy/vuJfRnJn1+X4kHclATjazSYfO8Xk032lP2tahQtgoRmkxfsJs++NdXqeU6sYz5LVpJpOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jlxnRVnKU9RdO3WDLzahLQzhtypVhPSxSVr9O3aU5g=;
 b=F+BpFAcrHub5jJhYWLSmB6/L6qSD6LO+agDBEdARQwVHyUJD0zYfjzxe0azFOOqHrCVYbGuKMQAYO/n48DV6jYnOIV0X72GD+dlgcItxrYf+q5xuYg6Bf9u0LRiZvXQBCKwEgPEpQehvWqYBGf1YhLzqqmD7VUA0nntT5fjVw8g=
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 22:45:33 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::1b) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:32 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:27 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Roman Li <Roman.Li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/13] DC Patches August 15, 2024
Date: Thu, 15 Aug 2024 18:45:12 -0400
Message-ID: <20240815224525.3077505-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 021ad56a-98a4-4f83-d552-08dcbd7bf904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TVIJAM5aQmTvw89yvV/kk5aZVB3yn5DE7JZDBUqevSSAH0rPdcQpRb3Y1+NN?=
 =?us-ascii?Q?xmzFMBrPNnAR+6ye1C3+Fqa+7I+fvhfU5tcJtYMvIXHpCt1vDxhdsSS45+bs?=
 =?us-ascii?Q?pZtQCBUBBOcUtTBViq6WyvceHlEJOUPQyg7quwewssfYvfGdz+NfF46U11/A?=
 =?us-ascii?Q?vfB7ffqSBbXjrF+h+QYjHjTuXbqa0IWHz0+JjSmPQDaA+o7Kh3wRt+dnpsNJ?=
 =?us-ascii?Q?wjwQZcfPVwkRbL//U0lsuTl5dINyoMQxjQ4mUwympqVFP3+0pAgm5Oc2ZftT?=
 =?us-ascii?Q?Xy7GgGqu7Kio2S5HhUGVM8ATg6ILP0y/3AMyDanOp0S1pVSq+h2B8MWVGcei?=
 =?us-ascii?Q?tLbEzoYcIjrEymOiIYbuz7kDIF8PIheAXu2J0AzBNlFQqLl/emv1Z/x4sA5f?=
 =?us-ascii?Q?m7M20zykMMimNaPB6xq/rCxfsCTy2ZESxU0H4nQoSffcgEMgn5tRW75Zyo9N?=
 =?us-ascii?Q?4ueil/z+ixRe5Jf+9Bc1VSAiZW8T3B8rWj9JTU9ZTHOhJnH8Lby0J7SFtgGG?=
 =?us-ascii?Q?hDYNRyQez31Z4hK3sy+HU7vmyEkMVxiP3SUs18rwKZNU/Gsshmv3VMFSfh5A?=
 =?us-ascii?Q?tK8kwpDxgkigvBIVLBg9I7KMx4UW9DZPiHgf6aMG49LWMARWUnNWFApWcBeS?=
 =?us-ascii?Q?ZXU0Em77taGaCnfbGsj+CjUWl9fSPeLXod52p92W1TXjBrHaFPUw7ssnzGOk?=
 =?us-ascii?Q?5zTWwMysBRjPFruZwwBuxGShLEwh+IwfIfKfo0+NCzIEzfNwTPnNYUQSu8F9?=
 =?us-ascii?Q?icI4ApCJ71htf19oWZJWfcgIq5nxfSBTOPo1vKzxj8EqN4Lk7uAyIOwkgsGA?=
 =?us-ascii?Q?LYXcdrpA5AfBmKCMs9FxSWs3hA0EH7H/k4WCUdS/A3/aU9mWXxOhNQziYzxB?=
 =?us-ascii?Q?ESLiff4aI5vvq8FfKgh1o8lvbqHtg/Swz39Hh/rcNUQ/fkllssyqbnMmu5W1?=
 =?us-ascii?Q?K1b9Eau4V1HZxsQptuADvHFFMZbTFMXyTJlngIWEBoAe1lkbA6dKDiTsxdkC?=
 =?us-ascii?Q?CsnaXMY0KU6pgJkVpQ0XCZynUEeyWUsEEHrzT1Z78d/0XpUt1nPF6Gx4ySde?=
 =?us-ascii?Q?uSCPEsh8t6MHKS7bOMjEqlQ86TPnOyTiOPZdnpjrzMqIRfMfzgxaIiZqobdO?=
 =?us-ascii?Q?yQlQJPJHksrg7Vnlh5sGyMwZn2qLydUPt65YtdBgUBeP0YCW2axBB7DAL0Ay?=
 =?us-ascii?Q?et+SUigEkiTKk7B+eliXfdjrZHoCMm6rmCiLhlNaDQ8ZZHrBTc7yrP2uVU9o?=
 =?us-ascii?Q?BnaduWX71Eac5NLMCyxcqYn6S+mwv08GspeaDYHrUW5Ad2w20+RGjXMYUtFN?=
 =?us-ascii?Q?VUbp5vOC2uADK+fpVjmRE2Col4taAJs2LToZTKS+dWCFBK79PDh0CqvQ7k6j?=
 =?us-ascii?Q?4sD7yAAiEYAcoztUdWeSY3XoFboOvyD8TMTqslRkRATQdTA0pEEkKkwVVlRT?=
 =?us-ascii?Q?X3eN3JerhDK+zPuB8oKUmCyCuXa7c/r7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:33.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021ad56a-98a4-4f83-d552-08dcbd7bf904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: remove an extraneous call for checking dchub clock

Austin Zheng (1):
  drm/amd/display: DML2.1 Reintegration for Various Fixes

Fangzhi Zuo (1):
  drm/amd/display: Fix a typo in revert commit

Hansen Dsouza (1):
  Revert "drm/amd/display: Update to using new dccg callbacks"

Ilya Bakoulin (1):
  drm/amd/display: Fix construct_phy with MXM connector

Martin Leung (1):
  drm/amd/display: Promote DC to 3.2.297

Michael Strauss (2):
  drm/amd/display: Update HPO I/O When Handling Link Retrain Automation
    Request
  drm/amd/display: Allow UHBR Interop With eDP Supported Link Rates
    Table

Nevenko Stupar (1):
  drm/amd/display: Hardware cursor changes color when switched to
    software cursor

Nicholas Susanto (2):
  drm/amd/display: Remove redundant check in DCN35 hwseq
  drm/amd/display: DCN35 set min dispclk to 50Mhz

Sung Joon Kim (1):
  drm/amd/display: Support UHBR10 link rate on eDP

Tim Huang (1):
  drm/amd/display: fix double free issue during amdgpu module unload

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   3 -
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   2 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 478 +++++++------
 .../dml21/src/dml2_core/dml2_core_factory.c   |   2 +-
 .../dml21/src/dml2_core/dml2_core_shared.h    |  37 -
 .../src/dml2_core/dml2_core_shared_types.h    |  22 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     | 631 ++++++++++++++++++
 .../dml21/src/dml2_core/dml2_core_utils.h     |  39 ++
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  54 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  20 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  44 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 .../display/dc/link/accessories/link_dp_cts.c |   8 +
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   4 +-
 .../drm/amd/display/dc/link/link_factory.c    |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |  59 +-
 .../link/protocols/link_edp_panel_control.c   |  14 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 35 files changed, 1110 insertions(+), 366 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_utils.h

-- 
2.34.1

