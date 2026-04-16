Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D71BF433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1172610E7DE;
	Thu, 16 Apr 2026 03:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1DWBrsD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1342C10E7DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNiwFrWMt6M/QYGhfdqol6xX2w0nB0zpsMKBW6ZFw1PO74dAHVceweVX90NZjlDXN/1XL6GtDh4IVSJOiXZXcUQ4uvL9Bx7b6W5mrCLc5k7Hj4IuBAgrHf9VSZ/mD1evmbzDk+VXd0Jpl5+2hi2o47GE5zf1n1h7nMXUzpDJim+WRpqoV2ZHgJxm/6d+wUC+LuARkAZuipYJHXEqILh3rYPPi7yW6Q6DC+cCnrxzZJSB+wu4gwlwpgRIYHBJ0Fu2EdRvNKBBHKITy7kHryCLAzoJpjyqEAM4UDS5dQnjBb5wiNP4tU9bwCenrl4nWa4j5zrg52bfIgxdE1vNkdjz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvhU074ZaBTVtvAsskiG0AyssfiohvOmIBdjfuWErMA=;
 b=PAcUU5vDeIxJJiVIAoBmaM79pFawmookn6L9/gbYCZyEXb0gEEvM0lWqoua3WTCcexK7/rpMBTpI1Btv4FZe8XzcpglRiUR5XLZ+3H3DF1mBfrb6H83GsfwnaH5nOts5QaLtOGDxnlA8zxJNZ1wGPhOFV12ONYrdVDqBKYc0x44eZCcV+yY3fPkZB+Ll7u9Gfb6x+PUZSrGY2MsdSC9+t1Gcuq9rp7OXcWoFTvCIf4j+mA/N66pd71Fgh/6Rsg5YApPWXHQll7BahW3mitkM62DiWCqKRR3/6MSEbDEmpcQW3DRV+ZovC7t+qF60uAzxQcgfbr9QAIVuW8XZmNgcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvhU074ZaBTVtvAsskiG0AyssfiohvOmIBdjfuWErMA=;
 b=a1DWBrsDBUNCkGSCDDwO1kdp9hwtJ7CKPUNzYS1LNjNlPZEsu0tlFnzn6RLWZXT6SiBMb1ppEK+sN5ZpxKL0KBRXWi0UfyfOIukfLPIdRQnXbnKf6aQ+NqT3Lu+xtipVotPaILTwVxhmsQ58ehNNvwRMYyM/IMl+CamK4g+rftA=
Received: from BL1PR13CA0449.namprd13.prod.outlook.com (2603:10b6:208:2c3::34)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Thu, 16 Apr
 2026 03:44:42 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::4) by BL1PR13CA0449.outlook.office365.com
 (2603:10b6:208:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 03:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:40 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 00/11] drm/amdgpu: Add WAIT_EVENT ioctl for render-node
 events
Date: Thu, 16 Apr 2026 09:14:09 +0530
Message-ID: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 455eadb8-2ac0-4fca-e60f-08de9b6a7e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KeRpJAKzijgLSbT91kkdwa1XWmHRTIkkHyYl3GtRPOPIwsOPilksxZ6OPQkgy3LOVPE53ZlH4+YNkq7jEaXRpm+Vy6QMIBHWS8cRqXXnMr/l/wP/rAIDt5Mk1t3f9rU/B1JELkScr2eQAUpQgqhIbWfnJBygRpChQK1dSrfTJTOn9syYxQEWz8JUMq0CvkQ3kfLTXltYnKTu28AzMRcJg0nA7QYAbaaZgwEwu639eVgB3aZsJKaMMPz47ZG/ZvZ8hWQa1h0h8EexzuoUne3ZjbkNn8IRl3U7ZF8DtrJIW5JdvxKQ0JeuR98GukVbDr7HcXL9PZ6qCEQDxjxQ2Jyv795scYSap4gbIAYv8pAq07Amwk83ypwXeTtjeIG2CCQio3mMXHWKfSiPEOWFSU1H3CFmabH73gk/Usq9eWGqX6hYEzKytXMDzyKS9dCUbjoQOLg645P1QcPoa72Hn5YpH/+SyQMlna8kaS5vBdaVHKqe4HPdrfKXPJ6NgIuW9xpdLRUmuL5Z36SPkg5VAQCVnaNQqqCIAt04kAwT+fqCrwhhdoEwyNQJHD1cqscw/sn6c8vSbUHtCuviHxg+JTYv7llMSfm0HwqQyzwNX9w0pTVa4zZmCGvDcksS43LCike8qQWSjAG1zV4bzLQ1QrlqEoIhqPxveUT57OgAN3BHdZnOIQQldGY7DPGA4PWp8SwRqWXbep0U5SKcm4okmHvWwHQDv8wFqQLwdd5pTT6PPw65Ui7mSMIxudNke1M4MKMG7MgvgCFErwaGSax02yLm6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Tm8Ns9lv5LkN/94mrbARvp+78INfjbjV5LHQUaPj7CYzHlrBb0W+do/f71YqPXgLcZbyJO180XwltJ7pH6bGcLVsbN7w10gJn5wdlRV8UlVFFG/FZdIWiYMU3Dlc1cExU2Vzsl2EkxFl60FumKjBUuE/0y7Q5Xd39N4LpqMcjQYN+fI7OxuZ0KC92cmdfVBRhNq3FtYWu4ZyLz9gtEUU6xXo6SF6LbvAEUQMBdDazv3d3O2zqJxwI5axshb7psmMHGprvBk5D+8mCf97xZiPKtDAbAdmvipPAaRl2HNROVdrGT/EDsXP0qp3WoBTL7qE43sJzaNwsejwB9xuyS8WYvOZB2lHEAgLzea0EPCbM1Qzov/vOATl+0uSzWvwB6iVHOYgzy1gYNt4p9o/Rhpw10/uhsPoOszpmRcS5bNutafH9mHM2qMSC0VyYZ83p1V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:42.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455eadb8-2ac0-4fca-e60f-08de9b6a7e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

This RFC series adds scratch/runtime error producer coverage to the
WAIT_EVENT path.

This is a follow-up to earlier WAIT_EVENT discussions, where WAIT_EVENT
serves as the metadata and consumption path, while EVENTFD is used for
notification-only wakeups.

This patch wires the INVALID_VA user queue state into WAIT_EVENT.

When user queue restore detects missing or invalid VA mappings, the
queue is marked as AMDGPU_USERQ_STATE_INVALID_VA. This condition is now
used to emit a WAIT_EVENT scratch record.

The queue's doorbell_index is used as the queue identifier.

Notes
  - Compile-tested only

This is a minimal follow-up to extend producer coverage

Srinivasan Shanmugam (11):
  drm/amdgpu/uapi: Add WAIT_EVENT ioctl and metadata structures
  drm/amdgpu: Add wait-event manager and per-file lifetime plumbing
  drm/amdgpu: Register WAIT_EVENT ioctl
  drm/amdgpu/gfx11: Queue USERQ_EOP records for WAIT_EVENT
  drm/amdgpu/uapi: Extend WAIT_EVENT with optional condition wait fields
  drm/amdgpu: Add userspace condition support to WAIT_EVENT
  drm/amdgpu: document WAIT_EVENT condition semantics
  drm/amdgpu: Add queue reset records to WAIT_EVENT
  drm/amdgpu: Detect queue reset in WAIT_EVENT
  drm/amdgpu: Add memory exception records to WAIT_EVENT
  drm/amdgpu: Add scratch records to WAIT_EVENT

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 400 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  95 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  15 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   8 +
 include/uapi/drm/amdgpu_drm.h                 | 127 ++++++
 12 files changed, 691 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h

-- 
2.34.1

