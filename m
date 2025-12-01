Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF96DD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B57010E371;
	Mon,  1 Dec 2025 10:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t6hah4qE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDE010E373
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4wE1T6qIg7wTDGc5mnFAxFxbC/s5XGgspC6LG0cB8sZeSw/MBHHY2Pzgm7X9JudFaR1tETmINwL4/mnGYN2ftSo0b/zj5XV6orxutygAqN0sCg/Znxbh0XpcG7/Lf1s0pjL76cww9UTjiNYZYidpf3mNNUVjTJUgx6Ir1aV6mQyG5O+we6whORXrND2TkxaJZ+svqnL4W3WNzqdwwxoyMnt4sR1zynn+s/hG844/8IIHgnJLYdRLzyrTPQI118LK9FZ153F8rMn2ueaHF1EpObLBPJ35c9XkIgGBQkyU7lW9YwI6rRKu0ZrKvyUF/0F7YvaZI/g6lwxQGpxlW/d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VikKw5uV+/OKat1MxB94fnimP3ylPqu+9OGu6qbf1WA=;
 b=rQUzHp3n/gO0ivqBOCUAzbaR/uOEJtuviBAIgV/hJRwMIq2VXy4GMEZRd3I2tbTc2+diUZooVyOoar4edhy5Z9mCaaOD+ZjIvN+TrKLc75y6jL341kTKiakQsqDO7MGFy6Gdww7JTdp8EDFGMbm4bhRohBKiF3pf3hLdGxvA/v3rUmbFbXgTnzbkPqGVlMt6j8pxO8gDYLwAOeY/kL+wPerbqY4JbvyG5RbAt8FHbgUP3coHMjaZXYaWx5y7ff+aTfGe4lyrbOgIHE2dKT+JUjp2jTp1ws9krKgLysI4MKAS8BOheOId+9G1FlALiIinwXX8S0Sh6kANWTtw3O7qIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VikKw5uV+/OKat1MxB94fnimP3ylPqu+9OGu6qbf1WA=;
 b=t6hah4qEEIiMk21sak0QiTyk5ywLxt0PWqzNSgmcBzUlDPu2SUo2XM7AIRVU+S49wkBC2u4WvBoLoEthrbYRanGSZPBzZbwOpGmp3rgtIQWfgFpbo403vwTJiyDvkWWX+S8ONP8bJYwN9BXPN570gdq2av6TdRJkaeJ8FHqyBxI=
Received: from CH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:610:32::26)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:13 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::9a) by CH0PR07CA0021.outlook.office365.com
 (2603:10b6:610:32::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 00/17] Use common function to print dpm table
Date: Mon, 1 Dec 2025 15:33:13 +0530
Message-ID: <20251201101331.101584-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: e68dd51d-ae8e-4e86-dd40-08de30c2603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PuyP/a4Zc0UeqOf7lhSAKc4FGIC55SF+BaL0lDO4m9WQmX54yqUEIVkv5H+g?=
 =?us-ascii?Q?d/mgLiZve0vKAXp0c7gJaWH6iBaBvMwk98f8upBzVSrvfxO1UX5dHYp74R1w?=
 =?us-ascii?Q?TF8LgjCWuUh2RqadLXiIn3L+JZHuCcBlbpDo3a4VHgophNXMbKthsV/QaGJq?=
 =?us-ascii?Q?CEQbZfEbjivkHGmD/eBuU1GdP7k2l8jOPGboQsRSFV5TiXydRN/MK+rGDLWs?=
 =?us-ascii?Q?WL8Bi/t3mROB/GXLEuG+kEGOLeqfnDxJyaRBFnS5mvtW54djvS35ASJ+tQGT?=
 =?us-ascii?Q?KIZLPVVLtQoWHOeh4bPmhgui/+1LCgkBjrLyGTx8uckN8AJmCYjNZjpF6Q3q?=
 =?us-ascii?Q?17HfkPqrE7BXbAu2QooSrMzweTSMzF8dbN73UBybcFz3sMIr4i7VuGTI/+gg?=
 =?us-ascii?Q?t97RdYMwDhaxosdW9YSpaGChu2yeryeK9F/66i3IO/C8QctiSE5D5PrWPr7p?=
 =?us-ascii?Q?Ox1Y0cXcABpzlzBNrNEyEmOK2FXHbQAKl5E6ltZQ+L6ahxr6aFL0i+5HuGw4?=
 =?us-ascii?Q?9a3YqXgD9dOHSPm5JRRNGmjTWIX//UMGVOONz/m8r5jhIJpG9Q0b4w0I8SlU?=
 =?us-ascii?Q?qgd8KDIEvC2w0vgpA5vC3xE2Eq8PXE0/8okhWd0axBaB6yyd1O8XHeNpehRy?=
 =?us-ascii?Q?oXAM6TVj1+IXPoEG8v8fU93oVYwEyP0Y7PGY/YmGrRUYjysqzXRuTSEz1v1u?=
 =?us-ascii?Q?wbz7eayy7R14IuGeY7OTGzKnBM2ZrX0pbwHCJ+DImd+QohbLJX7mwpAwOFur?=
 =?us-ascii?Q?4Y0gZ2v/P/hBr1EK6fkV7+YaMT3vztT4+qxkRFmjgbiLnWmigYMvollKKEBX?=
 =?us-ascii?Q?+9gwA5eWnEVUNki1mco6D8OpCrQdiWa4MtHtr6C+ZpSwTI4mwbUTkGZkMp1w?=
 =?us-ascii?Q?LsGvCPgxzc6TRC3uZ2zQYT8dBHE75FkPqIyOsWkDt/lo8aoXMg7uQX7fu80r?=
 =?us-ascii?Q?MiGQz7klUY0PIOq09g8+MbPoQcNMGVQk3Ra0R08nSmOOHKrfSynJu7lka/uF?=
 =?us-ascii?Q?5gON0jrAMBnCRfxonCQ83okLVcouJPIEVuntB/BK3//pDeVtjyfGKO2dzpuj?=
 =?us-ascii?Q?W45DTgwZiZtwoFbJagKRANu/uJztbK2H90Nu/GYGZYBfxa0o6+CVQD/K6bQj?=
 =?us-ascii?Q?0cbad05f3FZPj5nFMIYR5yZaclAsC+k+Y4S595kCh5co3Rzxaf1pnosFR5zv?=
 =?us-ascii?Q?nLeoAvnQTJRW+HjICY/FVHk4z7g4LPTGSgU55mfIrwb1v9wIjunQoBjoa5zm?=
 =?us-ascii?Q?oRdVdBKTZw+sHS+R128MHWSfSxQiEUBGhi+V7ymOtNAgN0x8/iq/5xUhmSMj?=
 =?us-ascii?Q?O9JdvGEaEqOBJ+IQkzSgzKeqo+JLXxNnaB0wnQdwItINmIqRpYWOED8bZBXw?=
 =?us-ascii?Q?T2GUlWYvT17cM9PtmvUjVozAGLGOuKu2vs4usUs3xP9Q1LzA8PZFd2xPrxTa?=
 =?us-ascii?Q?bLfVaIzNZzXc/Fo7sLR1chTAq7M9XYstSTvECE4y5ULvjfRIuHRsdy/BFiWD?=
 =?us-ascii?Q?nJi0iHTm50iItpunflNGMvpsEECdkjASn9ZeHcxt7YSOq7WrgrIYADQBNm83?=
 =?us-ascii?Q?N0rzA3RH6t5FRqO6YFk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:12.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68dd51d-ae8e-4e86-dd40-08de30c2603c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
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

This is a follow-up to the series which keeps only emit_clock_levels to print dpm table. This series
moves the print dpm table to a common helper. Presently, each IP version is maintaining separate dpm
table structure which is really not required to represent dpm tables. A common dpm table structure
is used across IP versions. Pcie dpm table follow a different format, hence it is kept separate. A
helper function is used to print the clock tables in pp_dpm_*clk interface. The function takes the
common dpm table and current clock. It helps to keep some uniformity in pp_dpm_*clk interface across
IP versions. 

APUs currently don't use dpm table for printing pp_dpm_*clk, hence they are not moved yet to use the
helper function.


Lijo Lazar (17):
  drm/amd/pm: Add clock table structure
  drm/amd/pm: Use generic dpm table for SMUv11 SOCs
  drm/amd/pm: Use generic dpm table for SMUv13 SOCs
  drm/amd/pm: Use generic dpm table for SMUv14 SOCs
  drm/amd/pm: Add generic pcie dpm table
  drm/amd/pm: Use generic pcie dpm table for SMUv11
  drm/amd/pm: Use generic pcie dpm table for SMUv13
  drm/amd/pm: Use generic pcie dpm table for SMUv14
  drm/amd/pm: Add a helper to show dpm table
  drm/amd/pm: Use common helper for arcturus dpm
  drm/amd/pm: Use common helper for navi10 dpm table
  drm/amd/pm: Use common helper for sienna dpm table
  drm/amd/pm: Use common helper for aldebaran dpm table
  drm/amd/pm: Use common helper for smuv13.0.0 dpm
  drm/amd/pm: Use common helper for smuv13.0.6 dpm
  drm/amd/pm: Use common helper for smuv13.0.7 dpm
  drm/amd/pm: Use common helper for smuv14.0.2 dpm

 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  31 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  49 +--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  47 +--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  47 +--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 188 ++++------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 200 ++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 197 ++++------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  40 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 249 ++++--------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  86 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 205 ++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 353 +++++-------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 205 ++++------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  81 ++--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 215 ++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 118 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  10 +
 17 files changed, 857 insertions(+), 1464 deletions(-)

-- 
2.49.0

