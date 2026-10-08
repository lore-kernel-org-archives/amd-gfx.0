Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3407BCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 07:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA3510FC88;
	Thu,  8 Oct 2026 07:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIAqPWbM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D3310FC7F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 07:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8xPRtDE70u47izizBfBcQIkp9vi5kRHNa35CJzgbescKhOXOGGZrE599od6wVn79V4ZPBb1by7/Z/l01jZNKNWYeVtkgbM6EpXjnG8Kd0Qv1e4mv1TlFRftHPff5Ik7j3jWn7mYASaC8Zj8kS1hwR6RvKYs8H1wb/S6OKWomnpAa9tbuBkiKRWlrRiA4OtjIseA/ZNo0lAiiOZ/8806i3c1fhFRQyMRWslTKu4xT/KhoAR94+YE/UJpotgvxTgRcGRp/U7YKEoXIXrQTmdjfDli1fTEo5DxLwxoy8SDCagOrMgAuFgXb6T/OBgEEjdufv7p8RX1C3OOOcNP0Bqbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVYQrjft7XVxF71qC+csHgrrjuKOIQv5UrPiyiNxIUI=;
 b=qAFzt0pvQHZH/el1CDYQl/kGRXS3REDI0qMDntZZocCLhIMd/SvG92FEaYTpyBhtczx3dRYGAoxiqRakyL5VsURmJ36A56isy0r4DQQ2rIMx1ED758MD2mh75UL6AoWxVT2gmbh0yJjgC0SiOnhqRTnYAbBkc01ZvfkTxlF1MnTDIhJTHIf77HHU2MdZWwvIxjL6JiFKPpI7RyiZ3t1STjrK+EBF9Y08H7wg745q0Hrjj63fX2uVrbfmtAV/ByaQ1zyUWU0CreUNTcF7M0FnxkXEtyxOmfmzng1An3VXYjEVWZSTp/WHIcFYswVFj99KSpVotvoHLXNOHhxUmRlzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVYQrjft7XVxF71qC+csHgrrjuKOIQv5UrPiyiNxIUI=;
 b=lIAqPWbMgLRtKMgZQcZ2+LAnHFeM2ykFppEfPtFrOFFswIdy6K96om5En4J9cunEWywAv3ejdMTy9zv0xSyunkfp5ZjnNeSs1B0leE3vpR8prAAOk9liIHjjPwz4sJ+W8oaHcCrO6nWyXTqhD2K6tkDkFA+lTlj/0jpRsJToHMw=
Received: from DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18) by
 DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Thu, 8 Oct 2026 07:06:13 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::3c) by DM6PR01CA0013.outlook.office365.com
 (2603:10b6:5:296::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 07:06:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 07:06:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:06:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/7] drm/amdgpu: Add CWSR and second-level trap handler support
Date: Thu, 8 Oct 2026 12:35:35 +0530
Message-ID: <20261008070542.1111149-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b782514-7578-418b-4928-08df250aa341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9jZcyVgLNTbNsPOuGZi0e4ClkcfgEtN0g6PZcK/0IcXkoADzM5kj/VGSbcLxpQtcwyRRm30VNIZ3dIXiwJVAt80v/gL8KzZSYScjJQdm7siYMCYGz/w5c2R2O0ILqi/cMbTeZUUzP6yZR/ChHOQ6+3UyLJw3KojHie9Fv5w1NRI7DBDXPlcf8A6CYDi3Ha+ZySo620QisCBBcMM5CWvsIiPVt79RXIUlXa5OISu6OC9/47wGmy/1fHs8PwJzt+ygyy7Fn83/djXuzkyz2mv6uoqBVwShQq2gVWemiloiw0ZF3zq+TmQcy80cq7BUso+ZMxJVXWgruIPOoneh8T0fe7zbLN6lByWc43Ie6aBos+yc2DJMmGD8exd/iVWng6Q5bhBAELND9PQdQ4vVmBs/LqgPRWZWfxAb0qMLIGm9FfSq+VCyt8xIc1W55iOLV5nY4KYuJiNgweafR3Fy0M6tRBlFxcQr3rkroxsBpVFvuJlUu6xcSAkDGoqYXO84dCanHpwzgzeGMUtc/ie135IN+muqAsMPnI/jg+vlvPzTeU7b9DLQE/Nxol08Lcv6ABzWcBDXsqDbyj0038+UecNjhiYkRm0v3KlcjLJ7E/Hw9GrstMLL59GYPuGb3Tf5CLD0t5/ugzjcXqMzh8jK/QHvSp2TNHnfXUDk/4/aNyLFgm0jrGVb0TKQfVD77NNaPb7d7y0ucLJZ24ZyLdaqBa+73Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SoKJ3voHv+25GHh8Ym82RVEZCglcb9loPxDnvGiHO09ldG31HcgcM7hpBLjeF3PMGl4rl4M4jqL9w3n8XbaJgI7OSUVrJjv9rO5cK24iv+f2Zyfhrxft0jDjjqMAaD9NvkLdZXgLeUwHRHPt7VSV58zaYQ7XfwDB9/Oh+BFi5dy38Y4tPz2deLVO+jF7YVod9preJ4helMMxNGM/QJN+Vp2lEwhhsTJClwAx3a9Ho+L0GFz15DFEJjnaGxCw3R52ht6xmFd4gfmnYCI8TvHCvl3zKBcvjvGtv0lcjJaLdbaXdlr6L2NSuoxZjtJCm0ldzKKX3JNi6lPWncIiFja+Oj7OlkPYwU5b5dvtrX6stLsAvKlrMd1MZLVPISX4lpOsGNeoZRHJD9PcT7uSxe3hKDi0Bwb2QBi6NBl6vhzvjD9vXzX/mOwcy+JiAtV6TJX8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 07:06:12.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b782514-7578-418b-4928-08df250aa341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

Hi all,

This series adds the CWSR infrastructure required for user queues and
extends the trap handling support to provide a userspace second-level
trap handler.

The first part of the series adds the CWSR infrastructure, integrates it
with user queues, and exposes the required CWSR userspace interfaces.

The trap handling infrastructure is then extended to support a
second-level userspace trap handler. The first-level TMA contains the
second-level TBA and TMA addresses and provides helpers to install,
clear, and update the second-level trap state.

The first-level trap state is owned by the GPUVM so user queues and
kernel-managed queues using the same GPUVM share the same trap state.

For kernel-managed VMIDs, the first-level TBA and TMA registers are
programmed through the GFXHUB setup path. The implementation handles the
generation-specific trap enablement and multi-XCC programming
requirements.

The second-level trap handler is controlled through new SET_L2_TRAP and
CLEAR_L2_TRAP operations on the existing VM ioctl. There is no separate
TRAP ioctl.

The series also includes the locking and lifetime fixes required by the
CWSR/trap infrastructure. In particular, the per-VM TMA BO uses the VM
root reservation to avoid recursive ww_mutex acquisition, and VM mapping
validation is performed while holding the VM root BO reservation.

The patches are organized as follows:

  1. Add the core CWSR infrastructure for user queues.
  2. Integrate CWSR with the user queue path.
  3. Add the CWSR userspace interfaces.
  4. Add the second-level trap handler infrastructure.
  5. Move first-level trap state ownership to the GPUVM.
  6. Program first-level trap TBA/TMA for kernel-managed VMIDs.
  7. Add SET_L2_TRAP and CLEAR_L2_TRAP operations to the VM ioctl.

The series has been rebased onto amd-staging-drm-next and build tested.

Thanks,
Srini

Lijo Lazar (4):
  drm/amdgpu: Add CWSR infrastructure for user queues
  drm/amdgpu: Integrate CWSR with user queues
  drm/amdgpu: Add CWSR userspace interfaces
  drm/amdgpu: Add second-level trap handler infrastructure

Srinivasan Shanmugam (3):
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 723 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  60 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  14 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  29 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  16 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  38 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  38 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  53 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  41 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  53 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  38 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  42 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  46 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  46 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  | 106 ++-
 include/uapi/drm/amdgpu_drm.h               |  91 +++
 27 files changed, 1676 insertions(+), 41 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

