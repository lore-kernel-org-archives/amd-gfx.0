Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AC1C6FA8E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DC710E11B;
	Sun, 26 Feb 2023 16:55:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D79B10E11B
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ/nQdDHHhk9VJIyXuVUkUlsrUp06mZZWhMbI7jboIJ86SkxN4u+7PTfeKqAOdnDQ4hCts/b5+0yrPHMMo0cKbtku+bf/jJDf2mTEV0k+x04Tufmz+M7RQy1ws9FDbDOSaimzOdhTxK1i4teA5ktt3ODN8oG8/1vnV8lbDjYIMNkTIQld03fSDzZUtHSthhGZnGBqmYNt0FXNmh7GI1OT8b/SMknfl5mS8Ecw9Jz5pQ6sP66B5oIQvLHeTyS7PAgj4bHbJxby9LFmGs8XYYQtm9D04u1OS2GQfxgbpGu6w8+n82KmaTtFB4rytAvvaYqO00vieJ6io8imOtQaGP6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYvfTn34p7i9fqjRSW1T47vBdm84R1fLbnodIV+B7wY=;
 b=bgEO4daGtSUqsFFXGAeQSrGoHJko2Kvm3s8YNx/en7f8xn01TYtJTDYu+KrTFw6wXKMBCoWvNi4MafVBhc38jCfWtVXz91evBOPPbs7ZBQwGtNyNPEitWqv1rB+CCF464Ft0bTDb4btSUZWBL+mbcybYfAT3yxcFW0X10BF5k5KEBx+iXwsv93xnar7Q2g5bSHNTOBgC60s3v/jr0I7uXanmAJ/ioqoAfQHljoljUWAkcbdguqZYdSaNvcZq+9I6bj14h3BkzGiCL8rCYqkrVSPQPyGUok9SBatKL7DLQOcoF+Bh6yDIwdyGfPylTFzl/yJTXPni+oyTk03KMru6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYvfTn34p7i9fqjRSW1T47vBdm84R1fLbnodIV+B7wY=;
 b=XbWggZfbMFNtUgLBm8B+miyu5i9mOBXzqgG+zGy27H/YrRILWzN6a63lBnMLidj9JqDCwH0q7g/qI5ufZPVbZljguG80OYqNwX9T/gj3xnBDXPdOZqEiV14EOhRIO8jLgBUmq1MiwX3KaGRuz65aHIshSFTztvxPjJ5vDKl10dM=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 16:55:11 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::df) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Sun, 26 Feb 2023 16:55:10 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:08 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] Usermode queue fencing synchronization
Date: Sun, 26 Feb 2023 08:54:29 -0800
Message-ID: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d989350-6fad-47ff-e9e6-08db181a38eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leoUXeXy1BWle2pIk5ysdnhkBLaUmxkD2KDAnQUuNTFcj6bWNz4KP/YWH6NrOdZutyqgE6w+7yg1ElA2Hu8W9TlRhxfJLykCQJ2zathbYwXYxE1rCI43b+ot1ZygoUsKPxRDDQmvR1T7amjNAS6oSlZf3ymyUEuOQNq6+zlpiZNkLZPVZrh91Hl8zGLZwX9SiOIeJ8/dAO8PMCLwTzIOjWe9XotZwYXXOULqYM7gyK6FxbX3nLWXvJLaCpU/wcPN12+WizyY52QAhxaLFnhcSzx+Y91OcwckdTGU5CuNV2DKLqvDv56tg1mtGC5SspdMyheNa+37Zhadvh+LilRuNRTj0Wo8bh1wWAh/5akOM0b8xrp5ZmVLwlTjySn75WuNMutpO4JfZtzRMqdReqdGpytVcxQHgMebu9UtCUdmdezFkduuh9/5KkHZLHnu8uuP2PcbeE/LA5Negk68KTSFP9g0CfSDmLiSqHV97y7x0mA51Gqhv3RnT0S+WLRfVNP7yFYD6h2jHJAQSJ/tC8hthmpIrxabAgCzwukIn49jtlCLe92LN6Ef9rqdcnV0iygHBfvj4Fh0HJa/ZGcu5iuvN+ZqwHWBwG8Mra0Q2R1NEqsqZpMDBcNUTzNfpa3+FP3gOo7on7WQUoQhriedjgIeonoYPBYebifABISGoLIcQQEc5hoFHnBLNaBN7QWhPrKX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(8676002)(6666004)(36756003)(40460700003)(86362001)(36860700001)(8936002)(82740400003)(81166007)(426003)(47076005)(82310400005)(356005)(5660300002)(40480700001)(478600001)(336012)(2616005)(186003)(26005)(966005)(1076003)(4326008)(6916009)(70206006)(7696005)(2906002)(316002)(41300700001)(70586007)(16526019)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:10.5789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d989350-6fad-47ff-e9e6-08db181a38eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series introduces fence drivers for usermode graphics
queues synchronization.

The idea here is, we insert a hardware fence signal command at the end of user process
graphics rendering commands and the creates a fence using the current wptr. On the
Otherhand, a process required to access these shared resources should wait on the
fence address/wptr value provided by the driver through wait ioctl function.
Here the hardware/firmware supposed to write the read pointer into fence address.
Hence the process waiting on the fence address equating the fence address (wptr) >= rptr,
before start consuming the buffers. This way we achieve the implicit synchronization
among userspace process for the shared resources.

The core usermode queue and doorbell design patches in review are seen below
which are prerequisites for this work.
Task 1: https://patchwork.freedesktop.org/series/114065/
Task 2: https://patchwork.freedesktop.org/series/113669/#rev2

Alex Deucher (1):
  drm/amdgpu: UAPI headers for userqueue Secure semaphore

Arunpravin Paneer Selvam (5):
  drm/amdgpu: Implement a new 64bit sequence memory driver
  drm/amdgpu: Implement a new userqueue fence driver
  drm/amdgpu: Add mqd support for the fence address
  drm/amdgpu: Implement userqueue signal/wait IOCTL functions
  drm/amdgpu: Enable userqueue fence interrupt handling support

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     | 158 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h     |  48 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 512 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  68 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  21 +
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  20 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
 drivers/gpu/drm/amd/include/v11_structs.h     |   4 +-
 include/uapi/drm/amdgpu_drm.h                 |  46 ++
 15 files changed, 919 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

-- 
2.25.1

