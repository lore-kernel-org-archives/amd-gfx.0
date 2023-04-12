Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0226C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3680610E0E0;
	Wed, 12 Apr 2023 16:26:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C7410E0E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+hYIOk2Jrp6/EIXPKjGOF43r2noozmOaLwGRNnYpwjiZZUbOj++qDSd3Fwcr4n7MYn/2iGpuhzI6GVuRA8hgpZRYAwuLGGnHj2ezhMo475uD/FYKogUEaOq5g6xt7aBg6yDBvDUyoEpVz/elNKWGFVuPRxv/U003SPn5DXQOSlewTrjJG7UlBUFezEdfK14aKOiZJN3opgohbvntungkizGfwSd8oI21Xwwpa+oLcGRqcKio+z1G6xqcilR/nzKK+Lk1Ggpw5VSkvOlTt7m5DUKq1551w+Ur2+abSHm5fhViuUd+p1zztr0fTZjITrVlckjg//koWAnTIMj4S8umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPC25y3YFkb1rTeDqhXI469zbz6BLYUAak6yPUsqZd4=;
 b=ESALJw7x1SRmM60Y3A1jvFSPBVMKiz5Qrzw6RMffB7eaxaXQjErA7WEgAq2UWbWL5SyPHjRFA6DLTuznUrxz3WscjtjhIKowjj3LCR4I+UGmEqoPqSZKWjymjUf4DonbAqb20CiGKWIDkhFOMYO20mREjgLlJ1FXKdV5Eou2KsmixgFF+4IPxBxWH/uGfeaDx3DJ/eOUjfRQIGWe+mG/+vnqAUKQFCsMIgWw/ek4vdEXwctzrKaQo/lNlqMtsH8yDsMY8maQG+KfqkRFQBbp0Ro1GQaWCUsjqc7YWvkl/ntKvvEqalwvnYwERPADnbZtF8fJTEX5UOIt1VNSs9/StA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPC25y3YFkb1rTeDqhXI469zbz6BLYUAak6yPUsqZd4=;
 b=Gnt6qV5qrcgF5Gaz4o/E/nQ0ylLCCl6DiY8w2z5iNhHLdf/OrVWL7Oi97coM1RCtQYltv6bdesL2hQNtBTrG+NMy0c8uIUuBvWB5QnvB15373k9uD5G6aKJjUiJwM/I+J3LDmx3cNluyp6Awex1+HhdVPYMwZL+HEkbhqKw5XLQ=
Received: from BL1PR13CA0077.namprd13.prod.outlook.com (2603:10b6:208:2b8::22)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 16:25:59 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::17) by BL1PR13CA0077.outlook.office365.com
 (2603:10b6:208:2b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.4 via Frontend
 Transport; Wed, 12 Apr 2023 16:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:25:58 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:25:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/12] AMDGPU doorbell manager
Date: Wed, 12 Apr 2023 18:25:24 +0200
Message-ID: <20230412162537.1357-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe1d2dc-28cc-4eec-1bd5-08db3b729931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZKJzawJjFlN9PpdItBjDpeMRGvoCHaiitOY8ybOo7VZJhjyXCS9uQ6QfIOdY4LKJu5L5ohNnhMyeBmmpVCGT28yPUMRE17tYXt9Skt/K1n4znnuvUyCJ9czsd43hwzWpI9tCMgDrSMHNUJRM7S2viYW1TcP7MpIRHhk414uUyZnX1FXUSIAMX5JuetS6M0GbTVfE4rI43sPFQH2kSZp0tl8PqBQCMBrncwplpIbrKGLerG7zELBLgfyTD8zLA1DqD26f2wS6Nrkl2Z/95Cznhzl5jPLcwDFTWPNMf2P376pDasV3tATxqK2D4K/wJhCsMWJHJfKe5zqocBrw+2ipoxmhDp1Y6dfi0nLH4Dhn+OoqzPYZWrlV2DezltWh/r50iaDgQ0H88IeHNDH4SRFp+b2Yg4h/UPTSHCs9mNkBPoqzgWvlQIAiSgjnikNu0GoZrUojESBsSIwM/omlwo10b9mi0XbpKTVi0dnYWT2YtQzJflAGiSutFSNz+nNDk3VdUK5+RvqNOe0w26cOApoDoP48vR+6eFlLkms1yDRNbay8++GAGKETlf14jhyoQhw42Y12vRMt0gIvg5NbVKogP/V6UOo8LfBJ0tLJYPZR+i8kkBYqgHvIfFlcZZ0nuwA9PJyTD1LO7CTuX7J2Ysrb7b1WDeMFlBCxqQ5KdunZgbaQrdvwAyIbSzHjiNe77+f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(16526019)(36756003)(40460700003)(40480700001)(186003)(426003)(26005)(1076003)(47076005)(336012)(6666004)(2906002)(2616005)(478600001)(82310400005)(316002)(70586007)(70206006)(8676002)(54906003)(41300700001)(5660300002)(44832011)(8936002)(83380400001)(6916009)(966005)(7696005)(4326008)(82740400003)(356005)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:25:58.5031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe1d2dc-28cc-4eec-1bd5-08db3b729931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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
Cc: mukul.joshi@amd.com, contactshashanksharma@gmail.com, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Doorbells in AMDGPU drivers are currently managed by different clients
in a scattered way, across may places. The existing clients are:
- AMDGPU graphics driver for kernel level doorbell writes.
- AMDGPU MES module for kernel level doorbell write (MES ring test and
  aggregated doorbells).
- AMDGPU MES module for MES process doorbells.
- AMDKFD module for KFD/KIQ kernel doorbells.
- AMDKFD module for KFD process doorbells.
- AMDGPU usermode queues for usermode doorbell writes (upcoming).

This patch series introduces doorbell-manager to keep the doorbell
handling at a central place. The fundamental changes are:
- Introduce and accommodate a new GEM domain for doorbells.
- Prepare the AMDGPU ttm backend for handling doorbell allocation.
- Create doorbell BOs for kernel-level and process level doorbell
  opertations, and place it in existing structures.
- Modify the existing graphics, KFD and MES code to use the
  doorbell-manager functions.
- Remove the existing doorbell management code in KFD/MES.

The idea is that:
- a kernel client can call doorbell manager functions to allocate/free
  doorbell pages.
- a usermode app can directly allocate a page from the doorbell bar just
  like a GEM object and use it for different usermode queues.
- There is no direct UAPI change in this series, just an additional flag
  for GEM_OBJECT_DOORBELL, here:
  https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/286

PS: This series has been sanity tested with kfd_test_suit to ensure
    it is not introducing any regressions due to kfd doorbell changes.

Alex Deucher (2):
  drm/amdgpu: add UAPI for allocating doorbell memory
  drm/amdgpu: accommodate DOMAIN/PL_DOORBELL

Shashank Sharma (10):
  drm/amdgpu: create a new file for doorbell manager
  drm/amdgpu: don't modify num_doorbells for mes
  drm/amdgpu: initialize ttm for doorbells
  drm/amdgpu: create kernel doorbell pages
  get absolute offset from doorbell index
  drm/amdgpu: use doorbell manager for kfd kernel doorbells
  drm/amdgpu: use doorbell manager for kfd process doorbells
  drm/amdgpu: remove unused functions and variables
  drm/amdgpu: use doorbell mgr for MES kernel doorbells
  drm/amdgpu: cleanup MES process level doorbells

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 174 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 230 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 148 +++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  13 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   2 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 207 +++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  21 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  22 +-
 include/uapi/drm/amdgpu_drm.h                 |   7 +-
 19 files changed, 446 insertions(+), 494 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c

-- 
2.40.0

