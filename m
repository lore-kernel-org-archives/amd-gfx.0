Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CABD14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3590610E271;
	Thu,  8 Jan 2026 04:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SVI9MNZd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3D710E271
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+C+YVAaM1inKXogvhNoXPtPnZZMQErE9XqJ/UKnKmQrD8vy9bCb+WS5bmbHtqYKuWIWlTvoiV+aOEEVUkwTx3g8xTMN1pTe5/gOez3h2c4WCIHhD7rU9qVJtyHrF9MF/WPae00UFaMPemiOqD7XyuU11lgfUfGMrDnXAWj19BV67VRkExHeOpTAUfpAWrmtPYNtyYNgoZJOsI80wJJoNeE7w/PnmWMl3aLQEuT79pQiyg95AYKUJ7kO7xMlYyaArx0PN6nflDpULr2GWJ1XHR4Lm9v4q4uUA41lTy4K4Q50/EArJv2rJv5S5mIwCMOOCjGognkSvM98e757VL3I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsHZ0QY6na8iuekdzsRvGchnrE1OzBZ+9mYwnMfl7kY=;
 b=BP5Njrfo1hg0PnhV5D0FSqeLqXEL2qN200Od2LS81n0QdcPGpo2rhwk3anodrpv8f+zavLys4gGnKnFbjiZd+esq25auJZtWHVgcenZa2bDEJ9PPWH16xOprDFnhJtv/6RrfYEZON4D2q5b4Ww5D9MwLRNKqavcDvla/oXBmlDvt0vCGLiZPfgjMxS7JtO+dpCSP0tL+VH8U3pN88Wg40JCF39gRRhs8oEfLUvhwV7DGk4n1wYupJLEwIfqKbqYRXokEqFPPJici/W0a9Df6SDI2vV13rNFEXeXqaOh6Y0OTtW+R7LIF34g9uONBtQV+zUsowoeS6xCMjpe2VRc5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsHZ0QY6na8iuekdzsRvGchnrE1OzBZ+9mYwnMfl7kY=;
 b=SVI9MNZdTM0Jeup+w5vtLWBJZWeEQHTWZsNZeui3ZCKQmsFAwsvgM1DnFoQJa5cxWRfXAWC9R30RmRxih7HO1rQ0dYPLYReRNS2B12rJlFznwfnxx3MT59/gUbzy4ysRIyxyykVWV5QT4s0tjG9P98CQz+s2qbJmxYJoRB8svWQ=
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Thu, 8 Jan 2026 04:49:12 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::1b) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 8
 Jan 2026 04:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 00/24] Add smu message control block
Date: Thu, 8 Jan 2026 10:17:16 +0530
Message-ID: <20260108044839.4084279-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 205625be-8745-445c-2721-08de4e71440e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gHn6oe11KGh4svkRKcpAx6kqDAqWBZq+O8rcbQVO51lZLocSz/Z8ZPdXOXvg?=
 =?us-ascii?Q?CIFxBWE8H6+65zRI8OaXDT6jI3WxDhN6X/nLUT+Bm1hOBvbR12vo09ak13kf?=
 =?us-ascii?Q?EW83ogMwKBKDboWb/S5P+HismpigtqqKinxqW+K29tIZOOTSZktXkVdYNpQy?=
 =?us-ascii?Q?EupofM9a0xgrO1I55tMJRux1IdI7KYFTF6J4cJErXWOIhNsH2R71mp42Bz0p?=
 =?us-ascii?Q?B1oLThML3BioDCpxwIizJ6Hxut1w4Gtuw2Fdp2hWuWm7MoJqvY1oLxZjNlRH?=
 =?us-ascii?Q?d8b2QKR+3Cjzb3EaY2ewIOjcR2OoP804HdiNjdCbbqVUXrAYB35G8C7ODSH4?=
 =?us-ascii?Q?tdosK4B07ywR/gR7ogzetfVG0GJyYHsGRgmNMPlcx0ETMr7YUzvjcBGhzwgd?=
 =?us-ascii?Q?EYCW+EDYOcVRVnZodJXknONrEpsR4kTMGDtFPEP3gQ623dFP4euox0BJ1GnB?=
 =?us-ascii?Q?gwUgi1I3wbK9WfZHAaLrNZT9FstZ5oPoqqfSGVSoFwPLiJNProkfzgan64Qg?=
 =?us-ascii?Q?G6SVc/wsCG8aJ8b7P1QlolHzQct35yVPityg5InuZGk9TNGZXYB9eNbpiw3W?=
 =?us-ascii?Q?tYXIoZGiF4wXTOAA+OsOG2rWHrn9sZDI6Y2RAMcCdr7wvqctIJmxkV7nloeo?=
 =?us-ascii?Q?ySLb6buNUj3FOKcJQ6OrEzQfK5VMQM8ilW/10BP+QlrsTTB+jEY0ePFTrIDr?=
 =?us-ascii?Q?L2YVMRwaEf8gn8ebojsqZJpRePDZK0c3x38XxS65/Cpf6G3FdL1j/woGhnOa?=
 =?us-ascii?Q?7UFVwDPYd001YYBlqD5Zarvx5UhW27H1XRISC71E0dga3CJS+QeAqMtPU7VB?=
 =?us-ascii?Q?28UeAQd/SsFONBzk9Oz343ic2Xo/qRcrAPC/co/qYX/cgH94+hrUwP37G3Nx?=
 =?us-ascii?Q?JUJ5WvtTUyDNOM8PF1tN1F/EfQY6bB2NOHyDRJw2uYfDXrVYMgxU0VCh6mt0?=
 =?us-ascii?Q?Eg4cVmcUg8rP/gCUdhHo/bGekzYq4fiVS6nxt9M4u5Od9l4Z/HGhINnz0X8+?=
 =?us-ascii?Q?sfeVUtGXsqMWIaQLhnxketsB28qqPX5iKzZHWd/hxDmrAyYQZcFbb91yaJyE?=
 =?us-ascii?Q?xHwYcrADkS2GRr3pMtHQQKGKF4t+gokQ8bY6EofhPlQf87EhiDQnq8P0seX2?=
 =?us-ascii?Q?47Xw1mUWAnURLQP06i/DLKWa8KPBhrYh57aNU9JYSvdsRRrZDGa3gLgsRgeH?=
 =?us-ascii?Q?HDU7KuFH/9d6qhlO3JPPRYF4Gz/+NXUyn7VlTvZUxAm+JhzEVf+LJnBJ2Bwk?=
 =?us-ascii?Q?lHI6cd4SodWNPGuaGEh1AefDyF7MTeyzCg/nP6iNlFxgjfu2HfwMcXpilYFI?=
 =?us-ascii?Q?DcNAzNc1PcggP/vEPN34U1qZOJ247gVOjDL3Ps38xheCA51V/e7Osb3rYejW?=
 =?us-ascii?Q?x2tZutxgpik+lCEu/QeRSUIWluilHyNYaTeQASpeIHoBy8DG4ADtQcsIwkw2?=
 =?us-ascii?Q?DoleOgU02lK7IHRb9XTPIl3z1GnV0oP5w9choOoCIvP06BoPwlCrHUvrybKw?=
 =?us-ascii?Q?ECzL7XIP1L2obSLYCjJcbuAbbq4KzRxRSewG2+XeXWkhFPVOQ9wmvfMgxg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:11.2457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205625be-8745-445c-2721-08de4e71440e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

The series adds a message control block to take care of driver-PMFW mailbox communication. This
helps for individual IP version to have its own instance and differentiate if there is a protocol
mismatch with the common one.

Message control block primarily contains -
        Message config to provide mailbox register addresses
        Message operations - callback operations to support messaging protocol

Both may be overridden by IP versions for any custom handling.

The legacy ppt callback functions for messaging are removed as well as part of this series as they
are not used.

v2:
 Write all message input params and read all output values (Asad)
 Modify debug prints to print all in/out params.
v3:
 Rebase and implement changes for SMUv15 SOCs.

Lijo Lazar (24):
  drm/amd/pm: Add smu message control block
  drm/amd/pm: Add message control for SMUv11
  drm/amd/pm: Add message control for SMUv12
  drm/amd/pm: Add message control for SMUv13
  drm/amd/pm: Add message control for SMUv14
  drm/amd/pm: Add message control for SMUv15
  drm/amd/pm: Use message control in messaging
  drm/amd/pm: Add async message call support
  drm/amd/pm: Replace without wait with async calls
  drm/amd/pm: Remove unused legacy message functions
  drm/amd/pm: Drop legacy message fields from SMUv11
  drm/amd/pm: Drop legacy message fields from SMUv12
  drm/amd/pm: Drop legacy message fields from SMUv13
  drm/amd/pm: Drop legacy message fields from SMUv14
  drm/amd/pm: Drop legacy message fields from SMUv15
  drm/amd/pm: Drop legacy message related fields
  drm/amd/pm: Drop unused ppt callback from SMUv11
  drm/amd/pm: Drop unused ppt callback from SMUv12
  drm/amd/pm: Drop unused ppt callback from SMUv13
  drm/amd/pm: Drop unused ppt callback from SMUv14
  drm/amd/pm: Drop unused ppt callback from SMUv15
  drm/amd/pm: Drop unused ppt callback definitions
  drm/amd/pm: Add debug message callback
  drm/amd/pm: Use message control for debug mailbox

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 111 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   2 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  21 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  17 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  29 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  24 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  12 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  31 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  12 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  23 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 700 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 -
 31 files changed, 692 insertions(+), 541 deletions(-)

-- 
2.49.0

