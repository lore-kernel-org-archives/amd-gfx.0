Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B0AF433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FD910E7D1;
	Thu, 16 Apr 2026 03:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3prAkTie";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1F710E7D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdn6m9YU7lNyUV167j6sAX9imp4ThxNi0NcVuXgfkcWW27RfJv9z43eeGAJmaAc6MljlIKsrxI9LV7W95drmBJ3Oyy0WQN7XJyAMWUAPxmXOr83TM8zWjTsyTzTwegBhVFIRPlRkrmdB8eQlLL6/voNt1lGqu1qZc4h0AGtfIfFc7S5/q2LGPc2REix3vmobPlFohfy/NoExxDAmx28sVz0mvECB95BbBjY3Qv6GnQc+TN4JnOG0Gfj9tCqJJSpVFC/DPS9qQhsBMcN1q6BE/9HaRTs0xzGI2JVDUlUwB7L9BxyxG9nhADvt1NwsMSdphRggx+3vy0HT0e6RYhaa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpKny6DX06gVJMXWFLS54UUco7J2QLXmBGPU/qLJVHA=;
 b=e5ermbqd0RRtiiYfZBoKgGHyc+prAG8MJrxvlz4d/FRXkXrFIpoVwuTZiwspD31mE4ZlipA1Sb8ar6MfnBjy41vMgfAT+LDegSmMJfC3ULLT0DQrSFZU72yGKOcIjMPRl86eokjb5g3Iv/ZQGVF2mEmmzPzZ6mIsSl9WnROu/CORwKReSCSWjWRe/E2Giv9RCeMovd0AGJHCkRsEr96iD9dJNGUFHSRM+wC//x/69X65IL8j52i29Z2IHqbVFG9hZ9KrvvImqY+oO8ggCE6CsmWReR/I1P9OXMPhvCuO7FB41k9256VuAkAxAunf1Lwk64gCbvTscSdEqpbbA41heA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpKny6DX06gVJMXWFLS54UUco7J2QLXmBGPU/qLJVHA=;
 b=3prAkTieBoWQJuxdvOsQKXfdeakIJQui3TWQzihICRFbS1kKhVol1uEOVkeOIqG2RnbqCXcgjzUzjm+dPJZT1JhJkrIyErrKBgFJFSwMvilo8WZK81MStp6HrhzJCkUOuBrFfaNaskVmeiydlQJjn6skqzVz+J1X97ZhAm9tjRE=
Received: from DS7PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:3b5::6) by
 CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Thu, 16 Apr 2026 03:27:20 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::8c) by DS7PR03CA0031.outlook.office365.com
 (2603:10b6:5:3b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Thu,
 16 Apr 2026 03:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:18 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 00/10] drm/amdgpu: Render-node EVENTFD subscriptions
 (toward KFD/KGD event unification)
Date: Thu, 16 Apr 2026 08:56:49 +0530
Message-ID: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 34774a44-78b7-4302-6741-08de9b681103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Bg2ncKKL4aD2tZaskQF6Jfi3FVekM5r2nOfBWD9yShwC3fTo0K7y3wauhovGAU9vCvC5kl/9qwW2e0+HZ6c7vPRn+cVG3tNGb5+t+LL7xaxvz9mxMDKrq4oYbKKq3OVEsXU3qLYThSontndur6XYsENKcq+2hT557G3A4ZRqIuzC/A7X91Ca+JWLabGHIfV4MzfFsafveygeSF2s2aIorIJ/MRixlTnnP1bCf3lHJM/TLFShfeKxHf3VWFXp/UY1IP1ttTKNb+t1rkDwsm1WwtpARQDBQVJnVLgKSlSs4/KC8kg1iv5lH1ksjYvn22Q3wA6FscCaBeIGnZVwniMmewOYpRf1erphNtnugrOkvbjX8Cj5Qoxdgk5v14pa9E34tptA55lsVCr2Fagfd6XnTdidjbl2R9ijBSBRG1n4ICz/wQFamUtsgbPHzH7FGcH4H4wEoH1RydCmLwrVO10/d9EJ7wTe31zg8f2piKqkmOuYSVcBaOS2C+dOOdk6P2veWcz8fHZLCLQiQy9mRpKIjpbtuUQGhQmv6Q+kZRpk+ENFg5+bmaMdSc+mhAvXKzdDVlvkuNXOtkt53bcN3Y9Jihp0qJHkqFsdKaeeh6WVbvRbWaAiFYCQmbfr5nr0aCwddPwm74Npzx83CFV1zSyf5BqnoL8RNqRMJjNqhC9rgy4be5mHwmJRAe0gCDKQ0rN6fTTIJAuRq7V0Qt3d1sYDZZcScQEiIHTXm3O0SRSUO8qGFaZ2PCia2XJtAFZcyPuxI2qdLk9JG/G5/j92P+riIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bqvrn+kDLgI11mDgTNPOPQClE6+XhtUxtyf16gie7O8oAH2WH5Nfkaax+LLVnarzEqSeBV5xtWl0fNMoo9T+wX0JyalKplIh/ws2HrTAa+nnZYGvdfT2R+6sB4puSMh/1HYiVI09vsq3oC/TZIPiul79UUlcTQldZitYTDJlLQN/bfh0gW1Zq8+BNFCgr9SvDrwsyFMkhBPnrQFUFHRP3SQI6nt8gzTGXj+BZNVBQiFXD8qLw0OPBMJn4tC5qlkYQ46gnuYUoGOW0rcwNiD5goScY1moi2RPIgHejGa62//j/sFy8X+56M5G8nJ7TtNbUYAMAuV/ktsCLfy3OEk7ew1qL5+qIAhAzw2GxEPjAjkCfYkG+9KL8/80CO6nSob/3Sp1/PV3fMQ9MpYIcjULWz2amIRZ9Hcp/nj8tN8x+h/jFjKPA/GJ2nDdgxSW4Y1g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:19.7126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34774a44-78b7-4302-6741-08de9b681103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

The queue-aware EVENTFD series introduced notification-only subscriptions
for render-node events and wired USERQ_EOP as the first producer.

This series extends EVENTFD producer coverage by signaling additional
kernel-defined event types from existing KGD/userq paths:

- QUEUE_RESET
- MEMORY_EXCEPTION
- SCRATCH

EVENTFD remains notification-only. Metadata delivery continues to be
handled by WAIT_EVENT.

Compile-tested only.

Srinivasan Shanmugam (10):
  drm/amdgpu: Add render-node EVENTFD manager core
  drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
  drm/amdgpu: Wire userq manager to fpriv eventfd manager
  drm/amdgpu/uapi: Add unified EVENTFD ioctl for render node
  drm/amdgpu/uapi: Define kernel event types for EVENTFD subscriptions
  drm/amdgpu: Make EVENTFD subscriptions queue-aware
  drm/amdgpu/gfx11: Signal USERQ EOP eventfds via userq manager
  drm/amdgpu: Signal QUEUE_RESET eventfds
  drm/amdgpu: Signal MEMORY_EXCEPTION eventfds
  drm/amdgpu: Signal SCRATCH eventfds

 drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 417 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  67 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  44 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  13 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |   8 +
 include/uapi/drm/amdgpu_drm.h               |  43 ++
 12 files changed, 632 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h

-- 
2.34.1

