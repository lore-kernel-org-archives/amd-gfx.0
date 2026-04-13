Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EF9F34C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BC010E4A8;
	Mon, 13 Apr 2026 14:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xYPt9+Jg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FE610E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPlkoCb4QlbJiDbNKKMkwzLaMPvzwsLC1K3W0vxplCWl8Skqaxh/zRxaFsh3TBx0YOF/MgBiZFJjqQ59SPdq+KCWwDg8YhVGdDT7mrOz2v7DgtGl1gWRFUIP6qNC6VKRQZYl1wsCMBhTNk15P/+o5fYE7Hbs9RmguazhmyeRhXo2RJ+47VgiwBCKRTsvo8fEuasXvnCdY2+eX8vWqoYn3uVIJThS1+UQy0yJzS4bBqUfJJ5gtk7xfzzKKfj7tqUmEUzSN4XVbjV5A75mYss+i9ygLiF23ML9Pzjb+V+N+NMeQ1NWRNJ+SHvzPZppk5FnIOA09PKlJXdC93r0i+C3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7R9pr9Vh6W/xjkduQapxwfQcJJRVLHGj+W76PwA2Rg=;
 b=s31jGVXqjHsBV1bUBg11ATNOPByzq6wokO7l64JDuup90WSCQnsVTVidS0p+/IIZ+9BuapOlb4cdRcWORqUbRNe17WXs46VW6RFTbINDSsTgafPdIMVyI5qKYMdzDaBWBfYzDjq0YxHdVEvX83TO72lfu2L0QoW5BePiGSO66L9KnyCUCZfLLMtBPJRVufaTtfD06EJRHL0K7jfqrRoocelOp84wsDUlL6gOIhoQf/lHc1zrfqMDnl+/0xndSXQqFKusF76/Z6+3fC7GHI+OSKQ2D7EPLiLzxgvLA6USgaOVIWZGplYPT9wr8Nm6V0net/nHqSUPFZCNYOfhWOnvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7R9pr9Vh6W/xjkduQapxwfQcJJRVLHGj+W76PwA2Rg=;
 b=xYPt9+JgTS49k+5uMOnszQwpfkQZPCpT1+Ooz+ZvsZBRZHI1bUdBQukAJGedzAT2fGUdUB8dtjbisAlbpHk32YgkUhI0GOrNE5l8N56MwnVuRm8uOL1p65HGkSpmOEZ5Muc7Xunte1GEBHieZQnBtBU8yM9+pIPXC7zpmJOQgiI=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.33; Mon, 13 Apr 2026 14:58:15 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::4a) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:58:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Apr 2026 09:58:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 0/4] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Mon, 13 Apr 2026 20:27:41 +0530
Message-ID: <20260413145745.2326236-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: bdec304f-de61-4f64-172a-08de996d16af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sQYJV6YarGGVQtTGUj0b14JOelBirOCyXsHe6i4hsYcECJpleIMQq2j3qtQG7v/ciTBrufQN38a87KPncoHLrYLQ7xHALzwNEioecCfPjOTBKdrIFVZ+jNILNZ1CmGarmcj0LVYHBTrhbSPHMfQ04PBbPMQ7+9mNvFHQFbee6qIUiKrmzK8CVjNKdG2x2nucOsyI0VAZKN5MKQ+MxRekgv3nfEcXlMS59HYK/cXjsNonbJvIoKUNBffEtrCb7vx9e4ZZk/175IOSiODLovZjuSY9LiMhb/bRmBc5xrE7KO1hJA4dJfn8tPp8drSqYSGqiVfxJkbra+4UnWRdqyxpICrOqGJCQ2GHLpqZOL5ftlO0DKvqI8gUSxjx14J8P1VAyRWvMX8zgCZ6IMD6hGkDNUQjg2eTQ0Igc/1RIDd5RCwvdkY1MWNEbr4X3QQJWLSOGz5fuuvvdyiDFCbiNK6U6tF009vgC1Ehklll7OLjOOrO0yjLgP9DRpw2lDmG4nJYS9o9kisin78ihn8bU1xmZUCwoJ8NZ7jFaBe9+HKoKGAlLEqla/kIHgrIX7TNA1EqlE6bj3hAvohch9qBK8RzgO5WTC9sDJ76g3S9yohih0vu0FHbEgR3kZOpdn+Tqe3ySSodLzvPa9910U6TX9uDRvcpIdJh86aUtIwuGE6CtZ91uPIF4x9ZZXpqxRC72GKDU+l5DZ4rMFN/52dqH9P83zn0cDMLDl+ntLHSz2cPVBnFSd2vA5+h1adXTV9+rHKla9yjPFHy9weqrM7LipHajw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yor7KfY3Kx45xH/O87v4SPTJ0pWcPPxYjbWrnD4kl9oiNJns4gkTXapxR6UbfK1tLHno+5YudaMig1tKHcZLDwiCqEeZMWWhQ8PEaztbasKWllVJjgyZHi97ldaWA9f5dg174vCv/37+OSCnzunRKOCpOUDzZ9P01ssD2QyGOUmmj6YXZl2XcuNgMi59FahQfCuq/7UJui+upJ7b6Pukzl5k7B+PZlA3eQt52JtyD7oRn1Rp6tCCjknYXFHaDhb6XiJryTWCOQqYzh0j6QNPtNHnVWLOlG4DrlUUesYCPaONQOBtE7JFpZqDRJHDJsvrJUBc44Qld1umSexuyqMkh6hJrqygRJICvmEs9c1ikwoqAIrDoT7rsmvbWo2HnOVGDDaADsP81Jl/xUGC+VbWikaoOpRqTKnIcuyyZBhLQVY94aYserfoHYI0bAro3TMs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:58:14.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdec304f-de61-4f64-172a-08de996d16af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263
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

This series adds a render-node WAIT_EVENT ioctl as the metadata and
consumption half of the event unification work.

The existing render-node EVENTFD interface remains notification-only.
This series adds a separate wait path for:
- event-type selection
- optional queue/source selection
- timeout
- metadata copy to userspace
- single-consumer delivery semantics

The wait path is per render node / per GPU. It does not implement
cross-GPU aggregation.

The design follows the current direction discussed for event
unification:
  - EVENTFD = signaling / notification only
  - WAIT_EVENT = event selection + metadata delivery + consumption
  - single-consumer semantics for waiters

This series intentionally wires USERQ_EOP first. The UAPI and core wait
manager support additional event types, and producer hook sites for
queue reset, memory exception, and scratch events can be added in
follow-on patches.

Compile-tested only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Srinivasan Shanmugam (4):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 250 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  60 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 include/uapi/drm/amdgpu_drm.h                 | 103 ++++++++
 10 files changed, 428 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

