Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC6CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610C910E00C;
	Wed, 24 Jun 2026 03:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f1ARJ9LC";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C3C10E00C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upig0XlLxYLXplsnGd5mkxvu0LztDVZOldL4CjT4LLO7rkztXWprAjq+QYwoxveO8PmjbjDf1xYiBPrWLB91EuIWAVSKeDtPxvp35WEFRwWfIl8EyMr5oTje7J3jAFrXmCHrd8oB/C8Pv30DTaPvIx/qc+CZSt8C735GuCFZz5DsuQUVNw0zQWiu0gRW+BIH44MuGcmmOLF/9642e9DzrOqlbA7iReXhwsq6rIQn5LsM2QFuOc3sPfBSh6+fLYoZ6G9zsW6vp19v4KVx/qdmHQEDauo9xTrVBpthzIzgRNX+2n6A7zJ2vy8iVf7sIqr7sj+ui2rG1hLTT/GBeVkoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKOkEbpZO+X5361KiCa67Ybq5TbmS5jzBJFpvX+yxTA=;
 b=nGqGvc3POzPDPaOnu8qqgH2YnQrrW84dCjQLAhbIy1YBI02fdBxsMi6IlMecJane2yL9igW0rqHTNeQpZ6VSzd8RPw56tUcQlIRhy20H2LNAWBzOtNK/7GhcJ4n+1WkEnV7p70m+4+r45NbRYbEgd0pzuI3pG7F0sVB9OBY/yP7jBQt5nnNFKZEfisd5SQE4b+Fvpg9Y9EeKqqvzxhw5Oc7KSM0XdW3FoqssCnhWm2CCdD5hP5BCvejEua1NLdkhWNWN0g3hN27Hq5uSzm6FMPDrbDrBqZA9U6o454rox83UemyjZN5Ap3HcQ2UmZ4PpWlgZlUIxtaHi1EvcgVqDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKOkEbpZO+X5361KiCa67Ybq5TbmS5jzBJFpvX+yxTA=;
 b=f1ARJ9LC4mKwsPXz0LpFMrw7lwXiT4P3chgwVumOjdwjIwtqObxw3jvjE0smRuRgz+qAZHFJJkw97u2d7wCCf17CnMHopBO0wnOpGjvm7fKu+mQGzsVvBSQ9HvLhX27rM8XlRHOx8hIn8ArT6n8KOZm0PcuRSYrYUhy96iUcDAc=
Received: from DS7PR03CA0244.namprd03.prod.outlook.com (2603:10b6:5:3b3::9) by
 IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 03:26:20 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::23) by DS7PR03CA0244.outlook.office365.com
 (2603:10b6:5:3b3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 03:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 03:26:20 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 22:26:17 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH 0/2] drm/amdgpu,amdkfd: fix MES queue type handling
Date: Wed, 24 Jun 2026 13:26:06 +1000
Message-ID: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 058380f5-a85f-47c8-bbf2-08ded1a05c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: r0gYE3Nb9H2MTdEd+4ZqS9VbdOfgQG9PZNpABtJ9mzFumbIT1+Ur7zuBvPmBLsv1SF1IYYQLYheXBICULXZ8J5iVc/ZClXXRMyjFINTMnTejSZEL5wt1BcNOkHCiszGuZAm9nm1ZqWd7+kmh+tGPjx3Z6COS82O2YXEMeczSdZ4etryOvTUW6c+e44Lcrys3kKWMdjXXiXhP9E8qti8JNfVmWHe8FDjl2AWfCoYMdmnykJ5peK9wCIz48sdgyzN648LXZeFRWM7ZVgMy9VswO+aqhH484brTosBB16gafAkarIwsUVUjmXbqPxthlZNgl6ZuplNENVDS59eZW4K0XYi0sDnNyBgJG602Zz3htKcfst2xeMwK0AdtNKZU9sgJbe/A21RDY5zvBuqL9gGZUi6ubzxWBC5Lt+j/+nHUN3Tag+fxgwNYeHQLcW1GMiLUYimLA/Q5iHhbRR42dcBm2Cx0w/vOCyH3bUu9GeUCxWY0YwhY1wJGi9hgbVde37CmBNc/pxmGQyw2+aA6CHep8On9buoUqnc1MRRGHjLQYun4E0rHRpBizOlgzN18RlkE085kQBGDL5jbLb7XeMTU3jQuhDMYAKCfPOSvsupwwCZaF8u3dHyOUJQIf7wj7IUNQxasYyOxqQqWu7Q9yTUh+q7QVjbpXRQDhlBuNAJyFkfnQSbY5blVKY6UoZzj5KeLEBCOHkkq3gEM3goTsU6irQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3scbb+4Yg1gzKv2fsYRo2emTamlkeSMvLW9uSeITfevtu2NbXSMdDEF+qG7n0A0McytKSoJB4LboYNtvB/uYfbz4LXqmAQlNURfDJyI+vVUeaURf1zXZfTnUkyPE3J+J7ft7xx7e/1txAlW/xT9H/kdSkhokb98KjaCA3/vBYe0CqHiZjMwsOuydVwCen+qQQ9rvEiitx2j1MjLq1OOMAnRzX62JezA4/GF+6HDj2EoP1ip17iHbQ79apCjHLyanJL3/x1GIPXtbJAdU3pz0c+d0mm+ES5CBQuGEpp0UIXUTdEAdsDRHFYO2AnmraB/rukjyLLP0JvtiV3XqjC7CEcGS/VexgotHHN+YepSKZqZAzXjN4O8icIe4OWbP/TowEXApKSPjRrJluv4sQVS/STLXb9WpIavTwv9hy2tL66xPzjwHK/Fi+pEkTCwXLJ7C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:26:20.2191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058380f5-a85f-47c8-bbf2-08ded1a05c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

Hi,

This series fixes MES queue type handling for KFD queues.

MES ADD_QUEUE programs the firmware using the queue type supplied by
the driver, but REMOVE_QUEUE was leaving queue_type zero-initialized.
Since zero decodes as GFX in the REMOVE_QUEUE packet, a KFD compute
queue could be removed as a GFX queue.

This was observed during a debug-trap suspend/remove sequence: the
failing REMOVE_QUEUE packet used queue_type=GFX for doorbell 0x1002,
while the matching ADD_QUEUE packet for that doorbell had used
queue_type=COMPUTE. MES can then search in the wrong queue class and
the REMOVE_QUEUE command may not complete.

The first patch sets queue_type for REMOVE_QUEUE using the same queue
information as ADD_QUEUE.

The second patch fixes the type abstraction used by KFD. The MES input
interface expects enum amdgpu_ring_type values; conversion to
MES_QUEUE_TYPE is handled by the MES backend when building firmware
packets. KFD now returns AMDGPU_RING_TYPE_* values from the helper,
renames the helper to make that explicit, and uses it consistently for
add, remove, and reset paths.

Geoffrey McRae (2):
  drm/amdgpu,amdkfd: correct setting MES queue type
  drm/amdkfd: use amdgpu ring types for MES queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  3 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 19 +++++++++++--------
 6 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.43.0

