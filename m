Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE313D374AD
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9153E10EBCD;
	Fri,  5 Dec 2025 21:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="22T0cDJJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA5310EBCD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGdIIVi5dmNFvuiEKyOkhLuojV0/jUIsBUWPnROYwyKMmRBPXvwRw0rF95B99FIs+oIvSceKSLZHwS13H3KajsCo0KAQx75GR07O6HB2CM0u46fRXVBOtun0hdUEN/mdZAkxzL5nEUvek5dz8wfz0AJiYSMwwdWCkq01rNI4Byh7CSSLFRbIsfMULoP4zU9q2TVRbAnk9Ob4UuQy77VjPRwKuZCablH5znWDHvZtnFmv3eqFeUh4b3dB/O/ixrhvGU8JpPceYr4lw4ZtYP/rvzCq5ZdKDFydezh9KalY7u53C1CyZTFLmLNpQ6NnVYvGG0xzS96xOgZgTVAtyBkxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfgPpH9AmT6x1F5R4SXAxWX5GWl0jpAwvdCbzn5j/7Q=;
 b=Odldr/tET8KwlVwVgzEGi2diybiyMz7bK6qBA2Vs2uFOjBmf5JvJsvDW8y3vcDMRhbWHHHdmsUyH3sqGJGvW4eyCa935V8M8xJVmOvujeYj+iPigjKSQw60/3Obnz2Hyt2VZs26J7sW7NCpRcgjX9YgLT/sdGP/91oEhhSvClVnHGoThEel5Liwa1CEk4zzSi9GU/Drm505tIa9BpnQf0cRfe1ZzpF5b3QwB0NFqbx0whENoIRQeBwEgSZaNS8lnK05zSRQXcVB49L2lv9NNjew1r5trfQdNJYQPT4os8wx49jqQgCKVK5rTSYzwLY6SDc7z2os8lmV4Q6zcVbqoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfgPpH9AmT6x1F5R4SXAxWX5GWl0jpAwvdCbzn5j/7Q=;
 b=22T0cDJJfyttI2lgcOkXSRqD/+yrHAJKwvssnmEmEWDQSyXEpoe1iNjsdO1aNW6+JW5CORc9Q0xlvZSL4GHhFhj5UvXlvGGjkE5aV3nNVzGBM9m2hAe4SOeKi0Qd+wxOrxUz9wtKL+T+BJOkPp7UjIPvz1lsCUlOMvb1A1GVC1Q=
Received: from DM6PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:40::44) by
 DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Fri, 5 Dec 2025 21:49:48 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::47) by DM6PR03CA0031.outlook.office365.com
 (2603:10b6:5:40::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:44 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 0/5] drm/amdkfd: Move gfx9 MQD to HBM
Date: Fri, 5 Dec 2025 16:49:17 -0500
Message-ID: <20251205214922.1095629-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b87fd0-cd8d-4aad-460f-08de344835f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ysuVp1w/cSnxbQYIJx7HtQTGGLgPaMahLJYv+wHjW82Nbn6U219dwCrsHxYV?=
 =?us-ascii?Q?AxGhN0EOX3KjSEAuqRJa9M1ul0XxF4+cVXY3UwJ2C8F3JfBFSv70TmNU24Kq?=
 =?us-ascii?Q?XT6B0jxtMIDv+dgBH7KgSFmLkShQb3Do3w6VC2kAgUEtWPl6qS1axz6g6su2?=
 =?us-ascii?Q?/dj/U2E+zk5SQFylbSH5/2P5KH/VDscnRe+Pb0AsNh/S+gVysdzvme98+MV9?=
 =?us-ascii?Q?R21qStwhRG+Y9xKxbTypiZGxpRvpkq90l6PhAgByr4tvKqg+aZq7F43LwsAb?=
 =?us-ascii?Q?0yUsRaHevrFU7RVKQjwjC/hndjqxWXmAOrXU5h306Ui6kmP7XUAsdTZ+XQHZ?=
 =?us-ascii?Q?smmC5HdLEx++iYhQ+KWDtIlWL5siy2Su1MDtlhUPNeX1zmNQNQndtSyEVZz6?=
 =?us-ascii?Q?vQSIC5Kf8eVTOzuJTsByF3IoC2DGG3kk6YVdNpQg7mkFx5uLgLEuTl7EECkq?=
 =?us-ascii?Q?4B/VpMHrzpChVIS9l9+2qFFOh+SEAlLDrP7Dd8zTMFcFDwC2pCRsuf8cQJHF?=
 =?us-ascii?Q?Y72YS2yNeWXUIKR7EeKt0LBNQkyswdKjExUkJfbnhIYyD3Rs6LZ2BFpl8kQ0?=
 =?us-ascii?Q?owO98lciwwir4W0+yMjfUFKveOnz8Idk2kJQvMMtITuPfA1o8KbXGnOEHQbH?=
 =?us-ascii?Q?eaIXUDtsDMjaCAZNSpCYwk3nM11jluvA6YYwwrTRs8pCC5Nu/BkRKU6Xo8v0?=
 =?us-ascii?Q?hLKGtkgHlbYBvaIZERKz+ZVQ30hGjpzzoLGqC8Uhbn8EOseaCGpFXDHvMKQo?=
 =?us-ascii?Q?6v7TPu6CO/9vEg635wpe3ROQsNil+zRNkA7RQSnHmKdO5NTbqHus0nl3rOOp?=
 =?us-ascii?Q?vdB7w2yDCzLS4abKUxARNfZImeHfcNReitCSumIY8zGpNnPgDGXcdKTWr+8i?=
 =?us-ascii?Q?m9AUIHc6KwkKyv5kPgGbREpWpwnRsbPM2KUiBmb7y121lywRrit/FNDoYyLH?=
 =?us-ascii?Q?dgU5MyFOxhWHi+S5+IOiVSDkTYuXejwmRtPL05PSzIIQKjRJ66erJaE+4JcL?=
 =?us-ascii?Q?TrescO4HvldNH7WTU7jdla7iDFOKGg4febHbz0K4anjy0kX2yj+wxaMBUyN+?=
 =?us-ascii?Q?rLvsMCaIAxf3DiDB+1IoNZy2gkTY4w21yGER4L7WU+SwNkOKCx5Z0jrFYRHI?=
 =?us-ascii?Q?zZ4+WbDxRX33QtSaqRI51z4r8fYBoqNkKcZpbfkXe5vDDgiFxdpbiBch+nlg?=
 =?us-ascii?Q?6ghZ8jQM4GdJhE6Y5wfyaUwgxS0UfNVkbff5jqL2w3OHIz1tqAUUMvznWvxT?=
 =?us-ascii?Q?lrx2df6G7jn1dHVSpQWfeQQIvraeh3v344kbUZGFxaeNGhtTW5W9tMrb1pzW?=
 =?us-ascii?Q?znFMhg9lw3Zl7PZuLpWDitWSAILguzu8A1Kr8qQTbuKj6m2dy7RWDqnczF1/?=
 =?us-ascii?Q?5jVEnIuYi8zEBzv6SmBHC+YQOmYY2yOFVVHGS6vbVjl1QZQziNGrqzLmbKzj?=
 =?us-ascii?Q?6cqhbENMXbitUL07sf2rh9d5Thgsx7DmDsqoCsTI5NWRqMM7NLdtXtNo4Nko?=
 =?us-ascii?Q?aVH+xeOB1Oa7rRKZiEFt2JLx/frgqjAOCnMpkwDuym0+PPpr3YZiwnP/wyMf?=
 =?us-ascii?Q?RPR3kBmpWgOhbwmYDDM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:48.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b87fd0-cd8d-4aad-460f-08de344835f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

To reduce multiple queues switch latency, move user queues MQD to HBM,
and map on GART with mtype RW.

v3:
 - add patch 1 to fix gfx9 mtype update bug
 - patch 2 use ASIC specific mtype
 - patch 5 use drm mm to alloc GART entries and store in mqd obj

v2:
 - patch 4 GART mapping use MC address, vram_base_offset + physical address

Philip Yang (5):
  drm/amdgpu: Fix gfx9 update PTE mtype flag
  drm/amdkfd: Bind MQD in GART with mtype RW
  drm/amdkfd: Add domain parameter to alloc kernel BO
  drm/amdkfd: Move gfx9 MQD to VRAM domain
  drm/amdkfd: Map VRAM MQD on GART

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 110 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  13 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  15 +--
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  18 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  12 +-
 16 files changed, 179 insertions(+), 50 deletions(-)

-- 
2.50.1

