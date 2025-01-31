Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AA8C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89EC9890BB;
	Fri, 31 Jan 2025 16:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNRMYXIo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EB6890BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S07ODIiQDXV8J0FSYsvwFCDo2M0HfD7XBFCkzcdKmx/wPiEYNVBblswTvf8cSOiQ0uhxvZENg8Dbxi0hNihBqjFCkHsJRURyo0kYocG3/pctnwnGATDI20qu359mbtcG6HIl6rY5yv8LpBg2CCL9sSk3uJak0vbq3T2gPrW8VGXvo2206mIVjUO/lF4XJ0Qjw4yRR+m7keMRCrUourdhqUwk2pYIDfzYNXBDel7g5YBnepe8yy1lPmhLfVjJhqL1mR1+eyo4V8DcxX33e/NpBkWgisk6BWK1i4rO2n1lKaKRAyHBCLK+b1etEW4ITtHEroiMhjCrA1/KwFXTlDBE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LALajKK4AgBHcHYvtxL7c9wp2ze/CzQ/TcQbfDwe6Q=;
 b=VTvRogMZHBcObGyPsDLn4pcKUHjkh5FX/A/exZmY486KX8gNJOatp5I1k9sqC3mWLi4+roF/cczvp5Tpw3oTkLv6FL2AnRQY2u/FsVf3R2+vcUjyAzdq6yc+Mg/tvUaviu3n8td8csiOUf5ZOGH3GOpveRbnTerWSLb/oZxfdvU3pXfEktAQj5YQ0JRC3JdNEMOGskRKWuKeYzrCnr0n0Ov0UOmIWlCtYZOp5NuxxlwTeHNhU2x6ferGAOvd9QPLMxcEzoU6/WtttxFduL9i4IgniYdTpqDDfp7ptm6UlqeBJVDtWrcR/DjzITGFalLBb6MrGm4pXKldDn8H3yDJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LALajKK4AgBHcHYvtxL7c9wp2ze/CzQ/TcQbfDwe6Q=;
 b=MNRMYXIoEryu7RrYdMiZVOpdNBFeJOUj/l8tBP2LcDhIJdCgcgvIipbvpSYvEza4b7qkkrvD9pKyGVIp7J+qVSU33GzhJ29NY4adK6yn2qWHpzZle7i5YrKk2NLUpF5eh2oKdf2Qnqb1Xe5EJ0uvCx3wdba1TXUq9K4xATMcziU=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:01 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::62) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:57:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 00/44] VCN instance rework
Date: Fri, 31 Jan 2025 11:56:56 -0500
Message-ID: <20250131165741.1798488-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 507e8f69-3c5c-4205-c4c1-08dd42186b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pB9Dg/D8zdjhrY9Bj/kB9lmhKtxIgt+HrleAE/V24CCspFf7i58V31iAJBpL?=
 =?us-ascii?Q?ITmzU7WJYClIyShykd3H+60CQgethkxJ4HdYtWZ/ugzQJVV9tie0OLqJuskv?=
 =?us-ascii?Q?x7srnBJE27CeUVaNkHsWTdDOw+EObW+/eEDea14bRgB42kHvpZ9MTCD3xfha?=
 =?us-ascii?Q?wnwzLnKB8DYZSoLPHQs9rw3Q+z4Dl2OAmNNK+0b2Fp9EKgZFb9L+X3WjR+vD?=
 =?us-ascii?Q?2ErW+WGQ2I8Hc8+UIYguNiWqxD85Jx/6F5GtM1BsE3P6UN2QKoixDBZEWxXK?=
 =?us-ascii?Q?hUaMOtS8hwNgexNZKZEugNFlItmtrkzIVXF0sU9E8P8SOsPKYjj2cmq5lrVb?=
 =?us-ascii?Q?tz9r7m9VPIyU8eLmR6yqoKZSxTmDrKT5HtchVoNR/yHKiTL6PmcK1EHCuEFD?=
 =?us-ascii?Q?TVcjDPupMHf6L+rw0b+AzA0dTiZiGjJFvKdSHH+VfoPhC3Spnnddz19BSeyj?=
 =?us-ascii?Q?ik2zXkcslBMfn0HWsKIAfNrz8ohdn/QaxN6Ovoiol9f2+mBlDLg+6QXWyzNF?=
 =?us-ascii?Q?AQsKWWLt4pN5h1aeeLo9o9MKPns4bs9dj1lZZd2qACHYp+lRIYdyMHApuKLY?=
 =?us-ascii?Q?2/mw2FX8mNBup0Pr9ZSnnqYIipnpqe5WUL2q+dyfPgvotR9SwvQqL0JGATn6?=
 =?us-ascii?Q?OTyFBh3Yl2RZUAFRcCO96bqrVlApSo9+43kY4mtErUoOsf0HvM1WQ7Xh2lzu?=
 =?us-ascii?Q?Qul6+UoE5by3E53IrvFlHjoOiN57Z9fhBkPjyIv9coxJ+eykyFbNwHidZkW4?=
 =?us-ascii?Q?PnBBDSRgw2LeTc5ZM89jq1epFmoEfdpZvit/InltlU6tyGhKLtmqpShZtw3J?=
 =?us-ascii?Q?LHWu/ybqUVOLEbXOWZPdAXEh/YfoddXphtDSPMYxTIF7lW9XXukuFnjKy8Qz?=
 =?us-ascii?Q?MN+4p4KFrDa4QU06PEYZ/f+fcCrbjOdyIa6QfTVmquXKF5PX3ChhqL/Pw+3a?=
 =?us-ascii?Q?QYRoRax9yqh15k9aTdquzVhn7/VIF864t7naORa+t8yiCt8ye31KG7LT0BLf?=
 =?us-ascii?Q?NOMJhbIcmqMzkkVku1iPKrxDd2ll3GGyUJJGEAw1cMRqoWUuWU4J8RCFLjSw?=
 =?us-ascii?Q?hPc9LVXwHm1aW8eSG0fyxqvAYVc+/oKnzQa0JjEmQUOe1lDa52QscQcNc8C3?=
 =?us-ascii?Q?PJ6gGy6iIXESqgT4cair7P5EWdFtEIrzq8Zh/3IwBMuLhxbSHBUEnjAUwrfv?=
 =?us-ascii?Q?XPbOyklGT3DN3Q0Qf8bf3/u8TrLnf0RR9Ba555ADdFXxrNBslO05AfUq+gBH?=
 =?us-ascii?Q?LL1SV4l2jDND3ZsiUq/Hw6xDVxbXn0JKfVw1jF8zcqkLtK0vuMUP2hV/uw49?=
 =?us-ascii?Q?IDgIaKNrw9yR8n1LaSOdGYw0m3/1p8kmfgaTRKLOrsCfn4CA2xhaM77dWeYv?=
 =?us-ascii?Q?lI9+FT8RLQ+ieO25VG1XU4weZzyKmN0Ae0nDXfk252GFLzFc5E+Vy5W+Lu6v?=
 =?us-ascii?Q?jGaGof1MDIoxd04U8jfXJgkc28dXQEXrpNmBVK2gbEzKZuMZzP/y/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:00.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507e8f69-3c5c-4205-c4c1-08dd42186b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

These series reworks how instances are handled
for VCN to better split the state between instances.

This allows for per instance powergating and opens
the path to further splitting VCN IP blocks
per instance in the future if that is desirable. Per
instance powergating is needed for per engine resets
and can help save power on devices with multiple VCN
instances.

V3: Suggestions from Lijo, optimize fw binary storage

Alex Deucher (44):
  drm/amdgpu/vcn2.5: split code along instances
  drm/amdgpu/vcn3.0: split code along instances
  drm/amdgpu/vcn4.0: split code along instances
  drm/amdgpu/vcn4.0.3: split code along instances
  drm/amdgpu/vcn4.0.5: split code along instances
  drm/amdgpu/vcn5.0.0: split code along instances
  drm/amdgpu/vcn5.0.1: split code along instances
  drm/amdgpu/vcn: switch work handler to be per instance
  drm/amdgpu/vcn: make powergating status per instance
  drm/amdgpu/vcn: move more instanced data to vcn_instance
  drm/amdgpu/vcn: switch vcn helpers to be instance based
  drm/amdgpu/vcn3.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn1.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn2.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn2.5: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0.3: convert internal functions to use vcn_inst
  drm/amdgpu/vcn4.0.5: convert internal functions to use vcn_inst
  drm/amdgpu/vcn5.0.0: convert internal functions to use vcn_inst
  drm/amdgpu/vcn5.0.1: convert internal functions to use vcn_inst
  drm/amdgpu/vcn: adjust pause_dpg_mode function signature
  drm/amdgpu/vcn: add new per instance callback for powergating
  drm/amdgpu/vcn1.0: add set_pg_state callback
  drm/amdgpu/vcn2.0: add set_pg_state callback
  drm/amdgpu/vcn2.5: add set_pg_state callback
  drm/amdgpu/vcn3.0: add set_pg_state callback
  drm/amdgpu/vcn4.0: add set_pg_state callback
  drm/amdgpu/vcn4.0.3: add set_pg_state callback
  drm/amdgpu/vcn4.0.5: add set_pg_state callback
  drm/amdgpu/vcn5.0.0: add set_pg_state callback
  drm/amdgpu/vcn5.0.1: add set_pg_state callback
  drm/amdgpu/vcn: use per instance callbacks for idle work handler
  drm/amdgpu/vcn: add a generic helper for set_power_gating_state
  drm/amdgpu/vcn1.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn2.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn2.5: use generic set_power_gating_state helper
  drm/amdgpu/vcn3.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0.3: use generic set_power_gating_state helper
  drm/amdgpu/vcn4.0.5: use generic set_power_gating_state helper
  drm/amdgpu/vcn5.0.0: use generic set_power_gating_state helper
  drm/amdgpu/vcn5.0.1: use generic set_power_gating_state helper
  drm/amdgpu/vcn: optimize firmware storage
  drm/amdgpu/vcn: use dev_info() for firmware information

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   |  464 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |   47 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c    |    6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  193 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  213 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 1033 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  658 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  661 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |  611 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |  647 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |  588 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   |  499 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    8 +-
 14 files changed, 2951 insertions(+), 2679 deletions(-)

-- 
2.48.1

