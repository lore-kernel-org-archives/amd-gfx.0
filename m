Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356AAC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BD810E164;
	Wed, 15 Jul 2026 13:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzRQeBBL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0772A10E164
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuPCyGD+/NClRP8kU4+peIUPp+jVMRySIvUrg4gXCuONcvQ7f6lrcO3MS5sFbP1slHmVRT2pjs/jfZaOrXLctruGE4hrs8JhEhIc/lu/gPSuzKS66aRpQj+E0OLE1gXzQJyUaro2o/4HuMDbhz0pT5fgcTg633V+D1F5IghcoFnq9JUJnSaLFjgIL2BdKT3aPSY1XxRNsAhcSsuXas9ANOCJzb/unizCzwFuIqDJqGu3bKP4HHd36ofVKqRlM9qz2oDqeP1P/Rm/d/IQB6shCC+J2M7cG8RN1wqZjNu9lnTVvwcsKdxWkV7C+ix20hNcGRq8rcxd66N49jMRXBgdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGhTo0QvB3U/uRmRIw2JRogGymV7Sf3XLmy9mqYVldE=;
 b=tfNBwMRY+pxHlGY0xJhTAjtPHetcXasEKGStprW2N0hc/Q8OABro5ZmY5jGiz9OneKl19lim/bpPmcTinFlUkI4KaNKTfDYSEP8+ia6xP/RLBvaSh2nSSsvNwNrXVQ3B3jVVyDtgmFvFZM8WC851CrYR0vloR1TzZGY9mKAtrUBIUgvALdzTpjQSJUPrYIlgE+ioT8/zVdm+lf6qu/1CQgqCX/MB6MYm7bzOiI74Ek7Ojb92hgx5ZFUl6+i65IFvDfGnZjHFn5PvZGN6F8Ek6PU6tEehODzxHjkkBQTFJ7XrYRI8xqfy7BeQva422oyAa/ON9+YcHSNrU7FkLNk+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGhTo0QvB3U/uRmRIw2JRogGymV7Sf3XLmy9mqYVldE=;
 b=zzRQeBBL99uiWb+ykX7YEZJpEJdJCPHYmpnVYGwV6Uyhx+qyGeAQkrHqERKUL1PK3Jf6clxudxDzaNam3IjJfFcXVUkNjUGqnrt5+tXPNb2I5KdofUPR3MN4JL8+UgEMeGnXMO3Iic7+cS4uufYzGaSe5XfHLZHKcyJVjnhiauY=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:17:20 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::65) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 13:17:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 08:17:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 0/5] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Wed, 15 Jul 2026 18:46:59 +0530
Message-ID: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c9c771-ece1-4260-dc73-08dee27366a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: cPnn8PhF2EG2DZzQ21JaydOgKVMobi3w1XH/p1F06unIj4MlKUFYrs47ZN5uGYzMde03MZ427xXJYlwG21iYEfgDHaYMnh69HVuHRScZit2Vo3NB8KfZ4yIimzbdgo8FeNifoD0GOwssbTXMYZNidQT5teV3Dt4UExBgjJo/qD7pecg0IkJyXviqTARtq5cLEYg6GFH/tm/w8AQqEQRExMRfpfwmWBcBWUjOcBBGDrIx7RSWq2zuSGjzioPQFwP21jDim4HVR3Ym4VzXMnSw5rG4dzAgJ4CE68yfMPawV6cqME+bBj4NsbTXr7fhouoawcanMCFu+KuEn7qVzXRukG1iA/kSGeMBiVc3qZXf7VYcbLsy5YGY7TnGt7GhwZeWhvM9BTyih/KXOrkWAeN71R5Wn1zCZIxi6BIGxHH65bSYlnizV+CP5yF6wLhH7Ur1dLM8yukIw095gVIRPmaHjwaKKwDkPmiGu5DrVpv5mVEZn6YrerpzejhKjCbe2ymnEfzye3izYcfhP6bI6dF8h7VnLphKw4cXZAhPC+Pq9tekVpWuUclFn0VXeH6PqU4HITMlBKC0UXfcFnef2uIJBoKENv63HjVjWFCySeASzwSdtubTBp9SlKaad9/COwW7O2UOi0mECN9wlbXiZTFX7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sPQIJZSrGhCNBoDbIF1y9wJeeZWV4sYIdcNmbuePBdsTRZZCXBxj6frfCsIO5NLyZXkfLg7J5a6NP/EAQPxjfTEZ47VpRa3svzr5iaWYcJo+YwKV2GOPLJBuAY8RXMzxzrwBUhLBianfUtL7xTOcQJp+9QQPOzFv+OuxzmYAgnc+0MtlI3Hkh4hJUfiZf7JhP7ZhGTRXm6J5nw00N+9UsAOE822wJ6pMK7kyQmETwIM+TLuqXS9FwAa53P3gmQdV28r7hloZvxcaXqNghywSRfQIEKhw+q354POrlp9mTMkZm6FQ6cwMMXgvNjftpV9Sxls+WLNFxGnlBk/voBiYy37vv9ChIkVtjUAOcXqCXaEb1H8P+xKO24gUIj5f0bTJj3v5LfmJzzDUugCFBL9Cmq4NIfXMoFmgJcqhKMmCj16rKFWnvQN1GEd/s/Cdv654
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:17:20.3893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c9c771-ece1-4260-dc73-08dee27366a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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

This series introduces a render-node WAIT_EVENT ioctl for retrieving
AMDGPU event records and their associated metadata.

WAIT_EVENT complements the EVENTFD notification interface rather than
replacing it. EVENTFD provides lightweight readiness notifications,
while WAIT_EVENT allows userspace to retrieve the corresponding event
type, queue identity, and event-specific metadata.

This series builds on the render-node EVENTFD infrastructure introduced
in:

  https://patchwork.freedesktop.org/series/164618/

It also depends on the EVENTFD producer series:

  drm/amdgpu: Wire GPU events into EVENTFD notifications
  https://patchwork.freedesktop.org/series/168402/

The WAIT_EVENT manager is maintained per drm_file. Queue-scoped requests
resolve the userspace queue_id to the corresponding user queue at the
ioctl boundary. Pending records are matched internally using queue
pointer equality, while queue_id remains a userspace identifier used at
the UAPI boundary and returned in event metadata.

The initial producer set records USERQ_EOP and QUEUE_RESET events by
reusing the existing queue-resolution paths:

  - USERQ_EOP records are generated from
    amdgpu_userq_process_fence_irq(), reusing the existing
    doorbell-to-queue lookup.

  - QUEUE_RESET records are generated from
    amdgpu_userq_handle_hung_queue(), where successful queue reset
    handling already converges.

This avoids additional queue lookups, queue scans, or changes to the
existing interrupt handling paths.

MEMORY_EXCEPTION and SCRATCH WAIT_EVENT producers are intentionally not
included in this series. MEMORY_EXCEPTION depends on separate PASID to
file-private lookup work, while SCRATCH follows a different notification
path and will be addressed separately.

Changes since v9
================

- Replace the relative timeout with an absolute CLOCK_MONOTONIC
  deadline, as suggested by Christian.

- Recompute the remaining timeout after every wakeup so interrupted or
  spurious wakeups continue to honor the original userspace deadline.

- Add kerneldoc for the WAIT_EVENT manager, timeout conversion,
  matching helpers, producer helpers, and teardown paths.

- Clarify the lifetime of the per-file WAIT_EVENT manager. The USERQ
  manager is torn down before the embedded WAIT_EVENT manager is
  finalized, so queues are removed from producer lookup paths before the
  manager can go out of scope.

- Keep queue pointers as the internal routing and matching key for
  queue-scoped events.

- Populate queue_id only at the WAIT_EVENT ioctl boundary after a record
  is matched, keeping queue_id as a userspace identifier rather than an
  internal routing key.

- Simplify queue reference cleanup by relying on
  amdgpu_userq_put() to handle NULL pointers.

- Improve documentation describing manager state, event matching, and
  teardown ordering.

Srinivasan Shanmugam (5):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Remove queue-scoped WAIT_EVENT records on queue teardown
  drm/amdgpu: Record USERQ_EOP WAIT_EVENT notifications
  drm/amdgpu: Record QUEUE_RESET WAIT_EVENT notifications

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  33 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 508 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    | 101 ++++
 include/uapi/drm/amdgpu_drm.h                 | 115 ++++
 9 files changed, 769 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

