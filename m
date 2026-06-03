Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB31CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB121120E3;
	Wed,  3 Jun 2026 16:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LYsXUlFl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83B91120E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn0uAAQdhGmgO8hQMczb4byJOVY7oZe9jNKIy9k+QtcNyhunt6HPZDDKzk9mJ1Xolw9ujqOE5wwN14UmdQk5xPSvqcbBigJzIlx06UhvXTRXt3iYkL1R49htmQMyYtf3rS7gntVWrpZR6iHLAOJTXPvH6iU5x69lqo7xJVL72ociJAI3NwmE8HkqfwI1gam32ltf6tYocpyx5PBoyNbJ04ATkPzDJJo6idL+jd7W4qOGyrjugyc6+ShQO+kVDU3n8cKgHqpUE4RODGH0TK8t/KXJxcdI1LMT2ebDgf4Her5sRkLQLL3JXyxID17x8MX6CCffaYCF1IcdLqSZaDqcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAQr/wMaqfhvfh9p4foT7u6acoBsbcaeR8QWQ6udXiw=;
 b=gTvf519J0iDqen7ztCAPdJjtrj8txenDnm74saKEzzLxKxQ1N3O1rApWJbn9F3e6GmZKUQqhev2SXjx5tkS7PL7Hke95+5W48EdwXTHTmfNVblhbH2UA0cl28Bm03W0ZfIldbJgWJFIsLpcssZSfLEb3/LS85kEP4FHLB5CzvhoLppIzxIPGjh6PcvlSmRjsoGLd5uvANaBwqAL+D08YpU9KwcRelh7FMXvGP+xEm2t8Zg7RmsEcwP+gP4r9FXEmYP/OGBXnOTa3QVoeTH2BXOEr0TA/O3OVmL3kAbSKnfUnIulrgHXYz6mye8ofG2EzHrK/h3M+dyVIVRAy06+iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAQr/wMaqfhvfh9p4foT7u6acoBsbcaeR8QWQ6udXiw=;
 b=LYsXUlFl/7bq6BrMvD0qlIdqOVtxSuZ5bVX9klVvVgzTBn26UUk5pAWLTdRnZIUG/VJVav3FImoVlAi/KaB4ZKW7QwDPWFCEu7zKtLrvbrTcnAUt4+dELgdtMPMgPDHha9QgWrKuN73EYYOpCVi0nDm/P1qzF8+83VILcz+09rc=
Received: from MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 3 Jun 2026
 16:36:14 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::9f) by MN2PR05CA0058.outlook.office365.com
 (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/5] drm/amdgpu: Add Debugger Support for Render-node Events
Date: Wed, 3 Jun 2026 22:05:57 +0530
Message-ID: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: e353f26d-bbdf-490f-0eaa-08dec18e399b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7JRKRHc3zm/KF9y8mDBgGNv9Km68WI5sb4OefBaw8PvyVHm98X6EoKLiw3T8zxC8qVqnRu4hXiBahB/g+MGtxOQqIcPPlsQVY2tfaLCnBFVhJZOqzkd1MdfGo0RyicHElCm9UxlEF8LWFuIyzG96tP+wtDhJ3DcRw9FIsjT5mH3Ub7j0k8xYgGw0zdzoul2s7LGeeF73kDlhtlz0m4TMowVlpDVSqyghKinZQzgq66TRhEwtxKvR2PRDZRsry2z7Fr8WDQjNP7Gitl/v/PE9lc6qijg0RKGvqJpIB6Kn+YR+WrbnR2Wxwjv1Di/x7B2aEESoynJbQ0sQGZ60twVdEChU77qJZf7zoV9EnDqakzzpVCd8mHXzBxjtt5wcyGVKtodtf1hEunnQZVltDiri4ZJ67T6N11wzW6bcDZDuQgICDxrW71nGE1K6W81mzkpHQf5m0IOsCEJ3J+ey8aCSZ3zHKj+vTJGUzmy5vqO/wByOoZ0KDopc4RxVhD47ZF+SEq50W9RyLzFQMNIKgZm6VvLdZVRDQLE2QQxSkPAaJy8inmhkHlYyXvGBLDbfcjmH5lzzef3FgJV4Vnnfdb37gtZFs6YQeG2/H41qHbKXFaQEfswp/Gzn5tFeEPTBAVavigR6GkJyG63m77hfpfBdJNXT8MFq43xkYN9O5DAmDdzr95MFnt5R2YCL1t5cmlfkicAgUgqBzDDuIUCUEnqcQhxpYWfYBp6Df90umoumhzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1zRPO33kk421JonQ3hHEg/+cq4zptiG4pfldqOCnUR3YCQ7bYKYyRmBUS1tHOXqR1sgE1QjufYJ0MgL3pugxKO7veGG6c5xbsvTZv2TL9XeyQNuKiexFZRHVQCKXT5AOih4N76qR6O2mDinDaP6XQvnE3a9vhu7XQWklUq+Lxw7nFyH8myZHxjN7G93p0M1CumCQs95A5gd7WaxHmIi/C7A37Q3D6zptYzpJJFxVsNFQU0mfJHlCDIcrIE8Z5pkgRrOoPzu4jL5e9pitFXr930Bj3Cgx0T22NmaWc4EIjuPtgjipYADVTpdgNmilYht9FRP8ZSJvaZdHbbCEe/mGGw/Rk8Mc8SIL3a8uEGKwOYKmwKxRa84/J9uovoGrAtLp+oovASd8ZAbYAh9kKMdwRKSuGMIF+AAPBPyLj4ZqVwuElGByXjk14ylPLinXv98J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:12.8792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e353f26d-bbdf-490f-0eaa-08dec18e399b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

This series adds initial Debugger support on top of the render-node
EVENTFD and WAIT_EVENT frameworks.

A debugger can attach to a render-node client, receive events through a
dedicated debug fd, and forward selected events to the application. The
series introduces the core infrastructure required for debugger-managed
event handling, including debugger attachment, debug event queueing,
event delivery, forwarding, and detach handling.

Testing:
Compilation tested
Driver load/unload tested

Srinivasan Shanmugam (5):
  drm/amdgpu/uapi: Add debug event definitions
  drm/amdgpu/wait-event: Export push-data helper
  drm/amdgpu: Add debug event fd core
  drm/amdgpu: Register debug event ioctl
  drm/amdgpu: Route events through debugger

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_debug_event.c   | 408 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_debug_event.h   |  52 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    |  16 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  94 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  27 +-
 include/uapi/drm/amdgpu_drm.h                 |  52 +++
 12 files changed, 608 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_debug_event.h

-- 
2.34.1

