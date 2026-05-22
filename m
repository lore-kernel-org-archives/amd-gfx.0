Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65DCD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F0610E578;
	Fri, 22 May 2026 00:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKM/kY/v";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11BB10E578
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpQ1eCeoTOucqHu9AiOFkck1vaDs/kqFxvHdrPnQxUByPD6nrV181G9HlW8URSt++g4ZVc/sUBhPftLZOeXacJbSfuspgNC/kAQlQ6ox4lHgDhZa9MMhU2JZkpzIN9fCB3oMqCOsNVuRusZhfirjxR+9ukgBaFbFugywrQf6lmeuePT58NBaT4XXuFtOERePL2i2IoRpIMNuG3pAb1vdmWjEePpwW/TrK6p9i96KRWSW0igwXwgbpBtLVA65EHCw4vtmnywV2cF6hY75BUmnu6DZU50Q3O81g7rnT2CgRlFrQB/Kxt+GlNVRriIROoOwfEMcw1nOgO4j66Ho95W8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak4zoudjf5qFg0nS0HsledP5suD5uigkB09gHyI9Ing=;
 b=Y5ZIhtDuO6dluKzBI8P0Gb3ftm4kR5IgAULnZ5J2WcQ53g7XQ/njIZnwtxm4K3H7NDSB8E6A9ZhnftN4SzBOm83rHMx3GQmtVkfF6XEDTrIwOhtt+/xpRZZxjuhY8viMO1Yq4HeJl3ImD6C+8noinIvGI76WWDF2rS8m6gl+3KpqcXUY5j/kpfR2T48EfqOPUQRrdCEby4k86M7g4T7dFiJTMRmIMkxh/9bf/3nAde3bsgDOUk3ouoYFqM6cwMOmFAYguBHRmuE+8BhISojKBIu4vIdLWfZw0CORcMSt6k5Kkr4zBNvjhPI2v2NQAaLuixAU57Voe8iHFvZj8gLkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak4zoudjf5qFg0nS0HsledP5suD5uigkB09gHyI9Ing=;
 b=nKM/kY/vd6sIphScPnADlXZkt0uzYy8JYhjqIniEZZn0mrelzknGk1p1/YS+5Dxf2O373Mv7FNBpRCTpdahp1eb5Zy/6WqswO0iJ2OW8IWds27bzYx2f0YnWs9dIInWfjEHrWExGa24fweh3i40TusVMDlYErKNitGVbs2Xe6h0=
Received: from DS7PR03CA0171.namprd03.prod.outlook.com (2603:10b6:5:3b2::26)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:23 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::80) by DS7PR03CA0171.outlook.office365.com
 (2603:10b6:5:3b2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Fri, 22
 May 2026 00:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 17:21:09 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/42] Enable pipe reset for compute
Date: Thu, 21 May 2026 20:20:06 -0400
Message-ID: <20260522002048.98506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 57836bd6-5831-4921-c95a-08deb7980df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|6133799003|5023799004|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NlP78bjD6DrgKIeGqyxoItkoUH0XJI4x49p3FVsJanlwOIq9PSbtgxxka/Z26+uDJrqnJQHMhtF6PgT0AfFbLkJo/+2OI6YSRB9NRymrm2jpC6a8kriken3cCjkOV0xOeAf6Tx+Vl1lvbxxJd9MkLhnGEIltXB4XfK1oW+Uu+yp08Jyn1uN+9A34ukpz2VqahV+/i85OmYseqaPuncxuKypqJ4MVAz1KV19s+8NcoOO35ZLK9YzwvZGTpJIecfJ6+DCMoPNst1CO+T7qFeXbTkV0QBexCyRaPfjijrAHzwFrQ7yzJMARpw8vAyS7eWdoBPb5AYtu0czl5xxJ/oc/0kzHeuiOvuA/uFugkNJttt13M8XPRt02gqNsonrWTqjHk7osyXQzbUlLgbAXY2D+3C1WyMQhQvKG/6qCLV/2YzJtH6hiI2RwkWumq+2F4ZiJoSqIRVVlIGME81jg0Zv/55R3tU44fId8zpkAcJFeu04uU/qNY/6Aam6IIGw7fUicD3e9UA41EsX4ueOaNRYovLXgwoiOPmrjOyIQ8F61ckNw89ZXBJdZ3MIdHrNYnv9a+ATLzjEywlxiytR6rusKwJJpFQ5uy4K/MmB/v12kuwvIC9jT/GpN074pKsw70aMqmJN7ub5W4/zKPEzhMs+7PahjpmlKxWxHy3KWX2MwBe0OAqa6ovjow41A64yKkn6miWdDwjE6GzHX4MdHrcr/vLPs7dM9a2wkYf62n432IeQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(5023799004)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Du//9LC33QnKE2W+P7l7RHy6/IRIeMjxw10jbGMtsCPZ5/m+P7PCL+i6pbUe3ag8B5ALBQ+vkB/ErzlAFS52YadGfG8b2XA8cSc/lGRZLpBV2bRmGTbHzlgQZjbkPSJroc/3jGrIqZ0f5mim2N8PD8Z0PV/VowMBObUbB/TybOLPq2qOxwTCKZ4fywLtjs7Jh1vyQBSB5QGVwhWw1Roiny1qIrU+1+5omnR3K3X8F0TrfBe0yo5EJlx3yHwjCGQs5SpvQLIvEgpfQuJdirDxZXOVGf0EV9kU0m7rmJCljNvLFTb/5t7Vv4fX/+9T8yp2V1/e4yiND2sLtzoAAoDiwrCcCTOkHjqODxNFSgaoM8CUNavFtEwtwWq3hxtE1M8gid0enI5VmcoZHGDjkRwfxuTGSTpJGhWKIn5aY1gsH7xE6gHa+q1n/lalgzPa62p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:22.9570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57836bd6-5831-4921-c95a-08deb7980df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
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

There are certain corner cases where a queue reset is not
able to recover a hung queue.  A pipe reset can recover
some of those cases, however, when the pipe is reset
all queues on that pipe are reset.  This requires
coordination across all components using compute queues.
There is quite a bit of prep work in this series, some
of which I sent out previously. Another prerequisite
for this was reworking the userq reset path.  It should
be more straight-forward now.  The final patch also
needs to be updated once the new MES firmware is relased so
we can check the proper firmware versions. Using older
MES firmware may fail and end up in an adapter reset in some
cases where the pipe reset would have worked so it should
be comparable to the current behavior.

Alex Deucher (34):
  drm/amdkfd: always resume_all after suspend_all
  drm/amdgpu: don't reemit if there is nothing to reemit
  drm/amdgpu: track guilty fence for queue reset
  drm/amdgpu/fence: add helper to extract the guilty fence
  drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL
    fence
  drm/amdgpu/vcn: handle pipe reset more gracefully
  drm/amdgpu/sdma: handle pipe reset more gracefully
  drm/amdgpu/mes12: use proper grbm_select function
  drm/amdgpu/gfx11: only need to remap KCQs when reset via MMIO
  drm/amdgpu/gfx12: only need to remap KCQs when reset via MMIO
  drm/amdgpu/mes11: move pipe reset to mes use_mmio patch
  drm/amdgpu/mes12: move pipe reset to mes use_mmio patch
  drm/amdgpu/mes: add userq reset helper
  drm/amdgpu/mes: add a MMIO queue reset helper
  drm/amdgpu/userq: split the queue reset from adapter reset
  drm/amdgpu/userq: add per queue reset callback
  drm/amdgpu/userq: add mes userq reset callback
  drm/amdgpu/userq: switch to per queue reset
  drm/amdgpu/userq: drop detect_and_reset callback
  drm/amdkfd: rework MES queue reset sequence
  drm/amdgpu/gfx: add a helper for MQD restore
  drm/amdgpu/gfx11: use the new MQD helper for queue reset
  drm/amdgpu/gfx12: use the new MQD helper for queue reset
  drm/amdgpu/gfx11: unmap the queue via MES on reset for MMIO path
  drm/amdgpu/gfx12: unmap the queue via MES on reset for MMIO path
  drm/amdgpu: store whether to use MMIO or MES for reset
  drm/amdgpu: Use a common KGQ and KCQ reset helper for gfx11/12
  drm/amdkfd: split out mes queue reset sequence into standalone
    function
  drm/amdkfd: plumb a helper to reset a KFD user queue
  drm/amdgpu/userq: add MES userq reset helper
  drm/amdgpu/gfx: add a common helper to handle MES compute resets
  drm/amdgpu: use a single entry point for mes compute reset
  drm/amdgpu/mes11: enable compute MMIO pipe reset
  drm/amdgpu/mes12: enable compute MMIO pipe reset

Amber Lin (3):
  drm/amdgpu: Allocate enough space for hpd info on gfx11
  drm/amdkfd: Update queue reset support on KFD topology
  drm/amdgpu: Expand MES queue/pipe reset support

Jesse Zhang (4):
  drm/amdgpu/mes_v12_0: use mes schedule pipe for legacy queues on
    unified MES
  drm/amdgpu/mes_v12_1: use mes schedule pipe for legacy queues on
    unified MES
  drm/amdgpu/gfx11: Refactor compute pipe reset and add HQD cleanup
  drm/amdgpu/gfx12: Refactor compute pipe reset and add HQD cleanup

Shaoyun Liu (1):
  drm/amd/amdgpu/include : update mes api header v11/v12

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  54 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 193 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  67 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  84 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  64 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 264 +-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 216 +-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 111 ++++----
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.h    |   9 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 250 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 263 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  22 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  24 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 ++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   3 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |   5 +-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |   5 +-
 26 files changed, 1150 insertions(+), 708 deletions(-)

-- 
2.54.0

