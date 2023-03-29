Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244FAC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC4910EB71;
	Wed, 29 Mar 2023 15:48:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB0110EB64
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9IFXOCqoXXpPoUsQ9vW7TnO2X374yH8QvQ69cXEK0aCFqBt1Ds8kffhqlPkahnF8KGmvlKoh2iK2wIFf936RDtE/A2p9/yxgF2NnIsrjzc9XQZCp1zzeaa2YtBS4PFt6BS8tVP+5CyQcQFz0L4RrcOP0/tmQCoHn3h+LNko4KFJCeSBsfKudlwG376CueiXIbuWnSGvViN74DYYcis9Xoxf1laSM8Qek17R4FN3IltOqzpLNoR9cam/IZj7VTQcbHx2gYVR085qtXYnlatjRcybBTnaGS6W1E965U39oPajKB47LIFpizgphl0sO+QoPnYpVwCvzFZGC8BqT/Zbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlxbI0ZiCIGT9+a2U6+t/IjG59VRuEIVYyIFhJae+cc=;
 b=K73D0JPo7gR/PRu3k7hdX4FWFYIRhOZL63M2VasTDEBAz/L36TExcZA+sSRyKsC9dym3jV+2Y8i3LO9Hxag0sfyE0i6g6f4NWCIDZpX5ml55HFTLCtN/uYo0RIPggrKwKDGQ5wEwHN42tOH8mkF3a0BFUs5q48Hg+rpl+uwaCcYFJD3ckzQ3fq+g5GlNWm78Z+g3F/EQGqecKsXPrIcoX7dWanILiRBTv4tJh4oq/X8gNYXrjmglyTdgSa6uRUj4Tra0teN0im2a+ys0kF2l3vVlmkfLDxyY8/blD0HC8ISCrcWyKoNSE2bmnpGVy0lE8YYmkguAMu82eGL00ch82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlxbI0ZiCIGT9+a2U6+t/IjG59VRuEIVYyIFhJae+cc=;
 b=GiVzSXU7vh8B4a1sQgU+dQ85TX6eKbD2wbHuz7R24fcJaAKKVYOa8oHyXBXUJqhu/4IextqGIVf95mQ2lkrL61DYZ3Lh3BoSGo5UW2eVGN3t6bXgKIR56WW7ZSPxJjMArFIYJW51+f832bTrKLFHdsdtm4Iwc3142AmPGk4iqiA=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Wed, 29 Mar 2023 15:48:14 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::bd) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 15:48:14 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] AMDGPU Doorbell manager
Date: Wed, 29 Mar 2023 17:47:37 +0200
Message-ID: <20230329154753.1261-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c800ca-3609-463b-847d-08db306d01d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxQjGG+WSMbgiC/y2BMptELObrc3aNiOGsYqHIPbdHCpsspWR5OUYep7y8PJXU8QgxGNBfIWpWPmOLoxCHybL6OymvX670pDYBxK4+TZRopNXHcWB5OqHMGNQOnhLx6EVlnV77wwiMSnzK5nFBdvjjjGfa/vO0fhW8+HU2Dm2l+MKvCBXjeS3fsf2OA2POJxOrfqGoOnelXvCHDT+R2c4FdlZ8fOrH3P3qwTdoMemKuA7j1vOezmCBYzmvH4+AThTlwo3VrpmXtPPn+/u84focX+1PHVAEsyWeHfhSdVxRK20K2y1Uzh4gJETh/iAWdBVb4XqRRiPnDAl3DUfMDjRUfBlzM581l9wKU/TpdgJ/+Za2YSQf+A4hQTaA+cuDc9KH2u2WpOlzKwXgefhTztI3uat3ZXO82k9PXmFQIoCEkT5P6HNtRMC1E1VDKiZoqC+FYtNc+1SuvqZkhJ4Op6GiFAHB/n4VMDN4Wy32PY8OV1B6L8yOwG0Mtj/47hdA/mIn+y0yzTCXmWPbCnzzYqezEBZP1AyflVHRHShbw8gGcfLii7BpL7I1m77vjlbRb1q2/PpePNeEHSkwWY5o8lB2ZhoHOSJrAfyRPf7hzS8cvAiLmUol58c/Iwg7c31zDB/J9YXcfDjIg2kpbQ8cQVdAGNGuYJL7s5Ho4qksclJ6MhmlsScqtkgKKNiclCQK5EI4D3SfIV7vkDDuGxD38QjWTC24QM/OgeNrkEpuL6+I8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(44832011)(41300700001)(2906002)(5660300002)(8676002)(4326008)(6916009)(70206006)(70586007)(54906003)(316002)(7696005)(36756003)(2616005)(478600001)(83380400001)(1076003)(186003)(336012)(26005)(8936002)(40480700001)(40460700003)(36860700001)(426003)(47076005)(86362001)(16526019)(356005)(81166007)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:14.2967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c800ca-3609-463b-847d-08db306d01d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul
 Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The doorbells in AMDGPU drivers are currently managed by different
users in a scattered way, across the driver. The existing clients are:
- AMDGPU graphics driver for kernel level doorbell writes.
- AMDGPU MES module for kernel level doorbell write (MES ring test).
- AMDGPU MES modules for kernel level aggregated doorbell writes.
- AMDGPU MES module for MES process doorbell writes.
- AMDKFD module for KFD/KIQ kernel doorbell writes.
- AMDKFD module for KFD process doorbell writes.
- AMDGPU usermode queues for usermode doorbell writes (upcoming).

This patch series introduces Doorbell-manager to keep the doorbell handling
at a central place. The fundamental changes are:

- Introduce and accommodate a new GEM domain for doorbells.
- Prepare the AMDGPU ttm backend for handling doorbell allocation.
- Introduce doorbell-manager functions to allocate, free and index
  doorbells in one unique way.
- Create doorbell BOs for kernel-level and process level doorbell
  opertations, and place it in existing structures.
- Modify the existing graphics, KFD and MES code to use the
  doorbell-manager functions.
- Remove the existing doorbell management code in KFD/MES.

PS: This series has been sanity tested with kfd_test_suit to ensure
    it is not introducing any regressions due to kfd doorbell changes.

The idea is that:
- a kernel client can call doorbell manager functions to allocate/free
  doorbell pages.
- a usermode app can directly allocate a page from the doorbell bar just
  like a GEM object and use it for different usermode queues.

Alex Deucher (2):
  drm/amdgpu: add UAPI for allocating doorbell memory
  drm/amdgpu: accommodate DOMAIN/PL_DOORBELL

Shashank Sharma (14):
  drm/amdgpu: rename num_doorbells
  drm/amdgpu: include protection for doobell.h
  drm/amdgpu: create a new file for doorbell manager
  drm/amdgpu: don't modify num_doorbells for mes
  drm/amdgpu: add helper to create doorbell pages
  drm/amdgpu: initialize ttm for doorbells
  drm/amdgpu: create kernel doorbell page
  drm/amdgpu: validate doorbell read/write
  drm/amdgpu: get absolute offset from doorbell index
  drm/amdgpu: use doorbell manager for kfd kernel doorbells
  drm/amdgpu: use doorbell manager for kfd process doorbells
  drm/amdgpu: remove ununsed functions and variables
  drm/amdgpu: use doorbell mgr for MES kernel doorbells
  drm/amdgpu: user doorbell mgr for MES process doorbells

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 164 ----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 102 +++++-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 304 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 165 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  11 +-
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  13 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 198 ++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  23 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  26 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  16 +-
 include/uapi/drm/amdgpu_drm.h                 |   7 +-
 19 files changed, 636 insertions(+), 472 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c

-- 
2.40.0

