Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FA2D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC90310E232;
	Tue, 20 Jan 2026 06:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FHBcMJm+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46ABC10E232
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjTXSoRyMrtlyKi3dTBxHNGaLHzOcE4eUGYu67L0ruAC2KpcDhGvYzZ/GCz19gSNhXS6QJZlW8jbSDeCvMtPGMA5n8poJwFkzMPkTOUpjWnEkDPh5QCfSm+rulAftjCMeq63A2GRAump2G18vdVMggT0OHJGKZCyNy8uNT6kfwZqy7h024hz9+4BL/iRn6asoZPvMpeBHDfzGvrOCt6yvZQ5LANvk0+5E/oGhPEU0oHrjfKho9W05VkuaWyivW/a1skDIUtNjyWnBDRAv1zl1l8eh8sYd2ePdEayM/D6M90/K5KG1mCK114Op1g0FI91T9BnHIvzI756/NyLewUddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD79q9WKZrFECtcpf6UQ74vxa77SfgNnmAYVUzruMnQ=;
 b=EE1dN4lBktK1niURM0uZ0Yn2QMgGUgPNke9kXB0sKCfZUrngkcTZg/+YZTgd+TBNtFXf35YZdY9PkjGgTEGVi3kL5wip6edr+EY8EYrdcdJMV4pkbHQRtMCDOguKDoXYKHGNyS6Ge1J9lpzkuF/jpEbW5QEbZLkC1boZwVcgAw98sVCshifMdbWHzQqkrzm+iXyf9UQ+PRKpKQ67Qt19nAr3Y6v08fUwAPpE+QrBWMf99mWeIUS1gkB84uqAhxnHeCuGuAl8uvYtDidq1S20BpfjsStskfYNaEXq3i3cEHbfrIXHPkPPtKAb72wbaxEq4XJ6I4Q2v8BG2Ayk5sfvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD79q9WKZrFECtcpf6UQ74vxa77SfgNnmAYVUzruMnQ=;
 b=FHBcMJm+ZQl/aHrnlcbWCklbcVup1P62XMNfUo7yTJqav+NZ9DyjPAnCg+zpqiA1ZafEEkKLPv8cuh/rTBZnVUnyc1c3QTlkOa1qqUkEGbWpN/eLRR174ZpLhpV16sUoUO9pwsMwvVQauGmHnh34U2Mf8nYZGux8TIzRp6JRkdY=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:25 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::80) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 0/7] Refactor smu feature bit implementation
Date: Tue, 20 Jan 2026 11:42:17 +0530
Message-ID: <20260120061402.1287680-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c9e0f2-e792-4937-5cf0-08de57eb287c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LXQR1IfWQyrln5lAtdK5WvvBtbVGAzyUCFiErs5Db8mw73g5dkRxCtcN7DS1?=
 =?us-ascii?Q?89Z91IGLrSLzPFV2zQPMH2n0kt/ykInnMvZAv/UIoM8VR+q7EJptBwSFa5T/?=
 =?us-ascii?Q?iSJQM+rB6ReddkG9vPM1fzGp4tTCQ5YNJ4SXp/CqCklVnjDteo4upElz7PEZ?=
 =?us-ascii?Q?wuOX5h0ia0LKZ0rG0d5ZnlkJoL4hZiCHIfnhm9MSGuvwfT1OsiMzADaeJHbB?=
 =?us-ascii?Q?ZPe3dog1DnVgP3dLq21P+RoUOF6DCUrg8qHeo0Vmaa5AAySqvGNgudUzhCms?=
 =?us-ascii?Q?fCvleU99Gc68j4gNgWswW8vmKj5bPC9cTZJse50Go3n1sxEyr9BI2M7cEPEc?=
 =?us-ascii?Q?0PKUDfzJ9q3v5CnglQMvT+T1kjuA/PznpOCMvozn09p2Wt+yeMKp7wBSyYPx?=
 =?us-ascii?Q?e993w5sKuM+bvArh0PIAjwPZJO11jnzk+o+J76Vt46xor5vy0tXt+TLtMiqW?=
 =?us-ascii?Q?CtfUV7bflT10mbyfTcl3YttktHeXP+rI4E2518JZ2NcNJRbMne/IchwFYZ2j?=
 =?us-ascii?Q?ORNKV4sHszJQG7btBRxWm/taI84p7uLxiueh8dedNz9Wob6V3wSmjbgvYbQ4?=
 =?us-ascii?Q?2nree7bNnuntQHkoRAxITytqun3iVedACDbsMjy8Q4cYXXLIZQ5hVGWf4XU7?=
 =?us-ascii?Q?rnSSEwriGsYCPvIPOBu/E4po4DOVbodSHBLuZJ2xWw+t61R7Os+d3E59+++W?=
 =?us-ascii?Q?jo7bZZvtqgBavnSCwZ10sSOcoo8T3jS3jQtY5cznoQ7Gi/QbM/8r1KI5THTE?=
 =?us-ascii?Q?PCHLbXRDvxxBon9rPDuwWLEw/VL1V2Zu+qEe73/7XDcZ6KHHw5bwE/9ZRK86?=
 =?us-ascii?Q?oufAVaEcOBWiBuFYmrusiAHY59eW4JATj4O9v25/lQtcIigjHsra7OsRVdUK?=
 =?us-ascii?Q?mdAmQstTZUY4lr81UKE7FbywnuPxQ5cClFCLNuwuCgMgcY2DwEGLsqxRxkkm?=
 =?us-ascii?Q?5NyG9VSfD6u77nOOO3AgE7Tu8yko6nPj2cbgbt3rtfZSxmbp0gtfj8joTw3w?=
 =?us-ascii?Q?zv8Dil9pQCRPUyZVflCdE5lGrMmLAStvgLQn82TZpCh+KMxNMW6BdVMs/U0f?=
 =?us-ascii?Q?oUq2MQez9LIMWXQtwt4QBtp/MCVU6K/vKzJQaLRBSwXqSnp+FFpb7XrSFnLz?=
 =?us-ascii?Q?Eaibd6xhsEImJlIixrSH7l4HZ77Q/cR2ae2K+jptLcrZkqYjeu6UnlaatEdk?=
 =?us-ascii?Q?9jyFVNlJeP9GqtePBoXwyEjAB3UJyjn3BXvvBzb6W5Qc6PJTPoL4CoqQCpTa?=
 =?us-ascii?Q?PqSIQqOczWr07c6o2h8DXiRNESLOIrJo+tEd7x9iLZVrCtUsApmmmAda2nxh?=
 =?us-ascii?Q?rxlbg7BsKnngmvvxcKDHiN9cGlM+FN1awW705Xuduv3b5924BFyEqGJoyElR?=
 =?us-ascii?Q?dviYutypYDcxMf4BpT3Un6PmbFKKZqWhPwtoiQqhv7PJXfiVLlIljKECOdP7?=
 =?us-ascii?Q?lQcY9Wv8RFtl6NWK0SiPm1RDU4Wg57ixJLG3KP2/m1PSV8UWIPWzROF/PyLJ?=
 =?us-ascii?Q?L5y2SXC5oSV+wdr8iOZjZI34Vm7ZaoqZyKHjErMIg6HLZg7qxO+LYvVX0H7b?=
 =?us-ascii?Q?3HobkI7CE9vKgoHlhwC4mMVEMM0OjaixcY1Fj7DzQgV0zFLnm2f+ZPNwI8+d?=
 =?us-ascii?Q?ShcJdGe45ETC3n0Pj/UxYaFk80F1n4VVjKVRYz1mHFo3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:24.0470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9e0f2-e792-4937-5cf0-08de57eb287c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

Presently a 64-bit bitmask is used to represent the PM features enabled/supported by SOC. The
number of features has grown to nearly 64 and could extend beyond that. Instead of using a 64-bit
mask, implement a data structure around bitmap and move the implementation to use the datastructure
instead of directly operating on 64-bit bitmask.

v2:
 Use to_arr32 instead of direct assignment

Lijo Lazar (7):
  drm/amd/pm: Add smu feature bits data struct
  drm/amd/pm: Add smu feature interface functions
  drm/amd/pm: Remove unused logic in SMUv14.0.2
  drm/amd/pm: Initialize allowed feature list
  drm/amd/pm: Use feature bits data structure
  drm/amd/pm: Change get_enabled_mask signature
  drm/amd/pm: Add default feature number definition

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  48 ++---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 204 +++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  33 ++-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  24 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 119 +++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 116 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  29 +--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   4 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  37 ++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  58 +++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  20 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  34 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  29 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  39 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 103 +++++----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  29 +--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  33 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  69 ++----
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   6 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  33 +--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  82 +++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 +-
 26 files changed, 662 insertions(+), 508 deletions(-)

-- 
2.49.0

