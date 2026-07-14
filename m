Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C0AC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8C110EC34;
	Tue, 14 Jul 2026 08:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HaaTXxMM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59C710EC34
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPbbuGuQC3EXjaf7BlLs2Ue8jlzxOhiugXZBrhRt13DFX5ZZwMYWDph/6QkA2DWDOBo6jcWrY1j8sIO92yvBEg842o/Tbmc00u8zG7BUTmmpGg6m4WxaunpDZtNkO0fkM6EuVTECfhXcCrlrIevnUUvdN9INk+upONDndioW3TRH4GLh0oVe2GNWl8z4No+2QrB/hiiWT7+1p02MHueq+O01g5fHpN1VkAmqdROuBI3dnew2kDcXESZcbbSvGvElkQjz559UHfaXtD7cz+A2MJobDxY311W+kz5fxB44xwTB6tWLGffIbpyEpkC65SLtYFPeoGufh884kmcPvB7wxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BUY5yfLYzUKnxJwmVhMo7H77vA5TRDp0Uo+IBH5T+s=;
 b=YbO2BKYpjB91sMA2QXh8QDZFeoWTAAt/rBuOicLdsewVhn6aE+zZCW73XGj/XZkUsK6vypmU+aDsa/78dwN3kxfxy5SCgj7Yqd8b21XE0nxv+ZXTtK/iyEffRvZfRXIqeP2mKumbNOWi1+QC7euirdNxTtD02p0IBNsoMXixWa2g/hBt2RcnhbBIGl/XuZkDjZv+59swWKgLuM/IDhvspXn+NBa4V2olyP1zox0oQxJz0QJ0B1BZnAb347oD7iTBQkUIqIS/CsmwwCngwe6rqwTDWRttSVgFO4l8B03rweEmymRljPKs/0NsIARK7uUL8byXoR7OHUkfPIqfvsAH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BUY5yfLYzUKnxJwmVhMo7H77vA5TRDp0Uo+IBH5T+s=;
 b=HaaTXxMMlKRSPftOsYgY1dQHSkZZOT7H5qYW5PmGUeAlyCF1Mh/IammmfjpRfhPeEe8rxwMk6O+NQ0+3ONoG4k3QJTBLb3j9CeJy34SzbcD6TxiL4XtPHbVb6/emmm1w27qtoUcdb88EkX2UJU8Bizj5khVBZ2mtJqTw5EwVG9I=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 08:10:34 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::25) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 08:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:10:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:10:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 0/5] drm/amdgpu: Add WAIT_EVENT ioctl for render-node events
Date: Tue, 14 Jul 2026 13:40:18 +0530
Message-ID: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ac9e94-e93d-4571-2fd5-08dee17f615b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|6133799003|56012099006|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: e4dERavgYZCsn94P2YKpdQYDNArge2FSCzeK7wJKxYMmPzkzXGz1iBN2F1Y1/0vWP9BkUmlriiS7hBNdP+Rfn9PYIdDUIQ9AVfZoA9qixswFTVNthNNH4r2cvVg/AvUlxgRkePcW7ua5fWHXx7tDQFvuaCAKS4BUkdJwtrQs0PxfO22mw2LSswtYBFRqvkE+HtOubVHsbl8PTqkUiBQcNIc6Rf5D9X0gE2k2FCJbQYgHWDhdGcNGVQBY7sJeZyruD/i5fbzOsO4YIbODOyyGHpbzAwRpJMlmS28/kQaSDuM2aQW+Lhj+LIUKcpIXiMzjegM3wvf9w+//WWKI8PoJqQPC17rJOZyoXUfVagE6D6td3cexJjZxPRBNYB6/th7200L1dCyduFSpetukLn8yqiqO3QU6iXA5ye+KBbsKqdwScekmvjXxtuuyUo1lPb9eVj6GnkdEvDqEdLmuK9cSAYF0CGkjxQlMsZYoRy1xSBVZnCHm+JtSafrJrCdxV4rDFjjchZowIp6MQ+WLL9LhBmbjOB7QeAtdstu9D9Yd/67ywr+dRd2oryD08mP1vpC0EOGTGEChUUxXD0BjUfqUmy8vKZ8/zE28kDch9pQaoaIrYqXdjSBhkhrhclbEvd+w/f48UsGERPPJQqTDtp25xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(11063799006)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q7rAtw7tL10I8ED9TaNz9MbV9JvXZdTlaM/xASqzhyp8v0U8fp9uvdScOeuFWzANLLIr4+1XqdRyJp3vkzl63iN96RenuXzUHTMNEQz/5PJgT9um6H17TDrwpWtFnecv9xX6iSoNIz129mpF4MK5aFV3+qB798PE2QjtmC28aUZw5Uy/KDvmMqrRZ3yNYiJqCd+3csFkus+ZlO6H4dI14oJAKbF3faMCx5I2+BYBQqV17B7212oTNaHXnZHrDGzsBvpQDPWEMmjfIEZSa/J5q1GH5m/cc9nEsTStOe/2B7dWt27jc+d3b9mUMlZeJact7swRts5m0CVB01alrtMUUYpmNgEyxfOhZw5RiPuMwVfTe0bSm+cqIa/5+JyBw2c00iiN8dkfPpdVI45+WStIEaPCnMCclJoYYGQDNAZSFU1nONTKk1MQ/KHRi02e0lTD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:10:34.2375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac9e94-e93d-4571-2fd5-08dee17f615b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
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
AMDGPU event records and associated metadata.

WAIT_EVENT complements the EVENTFD notification interface. EVENTFD
provides lightweight wakeups when an event occurs, while WAIT_EVENT
allows userspace to retrieve the corresponding event type, queue
identity, and event-specific metadata.

This series builds on the render-node EVENTFD infrastructure introduced
in:

  https://patchwork.freedesktop.org/series/164618/#rev7

It also depends on the EVENTFD producer series:

  drm/amdgpu: Wire GPU events into EVENTFD notifications
  https://patchwork.freedesktop.org/series/168402/#rev4

The series adds the WAIT_EVENT infrastructure and producers for
USERQ_EOP and QUEUE_RESET event records.

Base branch:
  origin/amd-unified-interface

Base commit:
  540d68973c0b
  ("drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all")

The patches are organized as follows:

  1. Define the WAIT_EVENT ioctl and metadata structures.
  2. Add the per-file WAIT_EVENT manager, lifetime handling, and ioctl
     registration.
  3. Remove queue-scoped WAIT_EVENT records during queue teardown.
  4. Record USERQ_EOP WAIT_EVENT notifications.
  5. Record QUEUE_RESET WAIT_EVENT notifications.

WAIT_EVENT records are maintained per DRM file. For queue-scoped
events, queue_id is treated as a userspace USERQ handle and is resolved
to the corresponding queue object at the ioctl boundary. Internally,
records are matched using queue pointer equality and hold queue
references while pending.

Changes since v8:

* Clarified the WAIT_EVENT UAPI documentation for queue_id.

  - Document queue_id as the userspace USERQ queue handle for a queue
    created through DRM_IOCTL_AMDGPU_USERQ.
  - Apply the same clarification to the ioctl arguments and returned
    queue-scoped metadata.

* Squashed the WAIT_EVENT ioctl registration patch into the wait-event
  manager and per-file lifetime plumbing patch, as suggested by Alex.

* Reduced the series from six patches to five patches.

* Rebased onto the latest EVENTFD infrastructure and EVENTFD producer
  series.

The USERQ_EOP and QUEUE_RESET producer implementations are unchanged
from v8 and retain Alex's Reviewed-by tags.

Only compilation tested.

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
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 339 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  78 ++++
 include/uapi/drm/amdgpu_drm.h                 | 109 ++++++
 9 files changed, 571 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

