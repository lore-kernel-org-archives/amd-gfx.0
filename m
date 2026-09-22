Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB22C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B464010E741;
	Tue, 22 Sep 2026 05:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAqV9t6n";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE6410E5D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXvYAMNVst4ZZngR7/Btyza+A88r2RzhPNiXklAQq0u0nPKzhwcVZTLUdZVEL/0tknGv3HGWrdHXwaqG3EHPMPPtCmGMoDCyULjT+AmnA/IH+NbcLk4JqqbC1bLV35S+g+QNK6wvn1JwvAMQtbahsbv4jr8HML5ig58m5bwUTWwJs3Mre1SYeMM3s4IpHZ0IMdwYN4aLjjEPfO3TMTwTR0vT7SQtv/xJp8oY6BPpQI7fHSt3h2SR6lFkQ6T8nUl8kVy+Ha+hAbMQ3zfvP8/GhqJ42DPyC575xUOVhsqyBaUZiy+6RRfDqNjuy5ItH6jLosISdeY+MJhKBmo99oCYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPfOMj6uqJ+IU/5SYcHmEcH64QEakghJVdxqp36ipB0=;
 b=IMjxUas3t4Ss1JxOviBTPgzZUAOMFGsWXE2YTMctjA6dmvapLyaxHcc7nxNaElNc/2EsjoCHbvFbY9jwWy78WjdEC7Hd+lrqLm2H6GDoOYXahGc0Nt6w50V7+27yFbvzflYjicd8uSLpjcjSSwVzpxNnZo8ZWU5oZeCgXsl7FZCUwejYnvWUxEHtNefVww6WOxahDxSZQn+J+PYMjHzPuvlGXr3iMS2T2d/zP1wslhUCjBny2rJcmA1cDwp2AlZtoaqTdy2pFAslGUUrRUsCQN9aAfoi9oh3xMDeYFMYxFL6AasENoFQjKVO09OMVaKJGs6SXqoGl+qm50fvultp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPfOMj6uqJ+IU/5SYcHmEcH64QEakghJVdxqp36ipB0=;
 b=uAqV9t6nU+nqACVTc4d37KpXs6SIdxOhW7U261F3nBukpZ1UzJwhwcGFF6+EIusKVCimgJixtZkB3l6GBqimXaA2hOFjqyAXh8w4a+uZdr9X20XvD5Vpc6C2Mi/1gi4ddbiLi4tM0pUac6r12t6lIPk8jzHwXi121kYHDGD8qW0=
Received: from SN7PR04CA0176.namprd04.prod.outlook.com (2603:10b6:806:125::31)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 05:19:56 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::89) by SN7PR04CA0176.outlook.office365.com
 (2603:10b6:806:125::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 05:19:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 05:19:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 00:19:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/4] drm/amdgpu: Second-level trap handler for render-node
 user and kernel queues
Date: Tue, 22 Sep 2026 10:49:29 +0530
Message-ID: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: af582313-a7da-4185-2fcc-08df186923ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: CZhGg71hcOocUoMzoL8pFT+66QBP2EVQGxffHDUK0HlKNAuJ/DeWY170HQK/aXAkieE9eKENEkZ9mwQThOVk3fZzw5C5+FCwwZs9apXm74LHnP17a6UFO9ggc26VJyEq9zHcLgVMDl3REIx63yuGzREOisSVHwkjK23HmVz0O1uHa15WM4Iqtm4BXheoZo780AQbISGN3ae1vaqMjFObUTfd/sm00lS/f5lvdPvFReS9qXTa7LzV7dvmzjl5bOSciOpLmV4/n1JGR0H6KU91cBL/PDCNtnq5NJwDc6yjYQCn5zJ1SNuqzZCKgv5QiOuFR1D0DGx2Lpyas4Y/m9Zx7brgUzDgcUKzyTlXYMpUpHPtk6DIb497ZWsk3RyUUTsSLtqXj4lJnvTiUVTmZ6xAxWvz/f1VfP6L2nZw3wNTcHmB7HduXKoWtQxViiU6xFhc1MXB1ez/B/GwhhxeeUeV9dvJm87S39bYUdaqfXQdPXuv6BOO/12SjhiRsw+Nh1GCHYPZDuwr5IHC3kaL+3ihlZ98LZTKAs6GrJG8lwAHY5aEvZm0ZNOTo/LL1vNXwIGklfDZ8+NI4UlZFmRuMksyXrrBGf77SgZ/ii2WiHoILWnTR2K9wL1PUfP7BwLo+iSK5d6cQEZ3wnmdft0UFOMeIxQ3bI/f+ar8wvd+FLjPrONPMCPWdWb8TIATQYsqKn4ti+7NFzFuLFf9wIF9M5GYSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E/kB9jBVe0cgd3RWnmQtbFr0hVLLNcBiB/hgP4d/rRtNFktnVjyqx6h1Q6wK9kzd+vD7ZCZg/PVhA4x615p1IxmPK+RoqBA50zFi+jWHQXBJs7189BRrzhWnretizDaMVD03iwXjzKamqqawDrHsyfQbOQiVW3ataLRjzBe7+YAaGsnNjOsFMsnJJq5sQy5O/CF+My57RcbhzXZk7RQvAl5nNjQyAuVrgXU/6/Iv1fKhf41HKGaFMCitGbvtU0WfbxjQ/0IUGk2VX8DOYfsi4h0uYvJt/TFd2LI0PsaZYi7FQ6RGEU/tXh5C4TUm+kFJwlOX8iV4J2oZ3yeJeM9bo8dWj33nZZx95yOzBZq78zDvMcEhXaQtQs4iuUJdjuiIYs4G0PUtHaQ06dUT4UQfxhFozYJ8diqB4XHCjQmgNSm79hWX4e3PEKaOT24uvCwR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:19:55.8509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af582313-a7da-4185-2fcc-08df186923ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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

This series adds second-level trap handler support for render-node user
queues and kernel-managed VMIDs.

The first-level trap state is associated with the GPUVM because the TBA
and TMA are mappings in that GPU virtual address space. This allows all
queue paths using the same GPUVM to use the same first-level trap state.

User queues receive the first-level TBA/TMA information through MES.
For kernel-managed VMIDs, the required trap registers are programmed
from the gfxhub setup path.

The first-level TBA/TMA layout is kept private to amdgpu_trap. Gfxhub
only obtains the final addresses through amdgpu_trap_get_l1_addr() and
does not need to know how the reserved trap VA is divided.

SET_L2_TRAP and CLEAR_L2_TRAP are exposed through the VM ioctl. The
second-level trap handler is configured per GPUVM.

Thanks to everyone who reviewed v1 and provided feedback.

Changes in v2:
- Make the first-level trap state owned by the GPUVM and remove the
  duplicate file-private trap object.
- Allocate the trap object after releasing the initial VM root
  reservation to avoid recursive reservation.
- Use the common AMDGPU_VA_RESERVED_TRAP_START for the first-level trap
  mapping and remove the separate user queue trap VA reservation.
- Place the first-level TMA at a GPU-page-aligned offset after the
  two-page first-level TBA mapping.
- Keep the first-level TBA/TMA layout private to amdgpu_trap and provide
  the final addresses through amdgpu_trap_get_l1_addr().
- Keep the first-level TMA BO unpinned and map it only while accessing
  its contents.
- Protect TMA CPU accesses with the reset-domain read lock.
- Place dma_wmb() after the final TMA descriptor write.
- Evict user queues and wait for outstanding work tracked by the GPUVM
  reservation before changing the second-level trap descriptor.
- Restore user queues while the VM root reservation is held, including
  SET/CLEAR error paths.
- Remove the VM_ALWAYS_VALID requirement for userspace second-level TBA
  and TMA mappings.
- Remove the unused GEM_VA UNMAP helper and the associated L2 removal
  state.
- Update the SET/CLEAR documentation to describe the second-level trap
  handler as a per-GPUVM setting and match the current synchronization
  behavior.
  
Only compilation and driver load tested.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (4):
  drm/amdgpu: Add second-level trap handler infrastructure
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 400 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  71 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  46 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  16 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  36 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  36 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  40 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  36 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  36 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  |   7 +-
 include/uapi/drm/amdgpu_drm.h               |  94 +++--
 16 files changed, 676 insertions(+), 166 deletions(-)

-- 
2.34.1

