Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFA606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3WcAkLRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE5010E17F;
	Tue,  3 Nov 2026 02:29:50 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE0F10E17F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFLdcmlY77n7IM1Lyc0VprtqoIP2T+mkjHAJHLtrN+6oN0WqwZ4d2yd6Gg3nJrv/bRYPEpf+dV2EiK7oroyQzqEj3MSfVPuaUebfIpVTZBTeljH7r1OSE4BWMC19X3U+0jX+dNsXOEUbDMAwMNURIu93lpXZWyEWD53nH11sbpcA7efF0Brp0wahyLGUCfWBDaUdI8o0HVOHBY42zx8RjAoNrvDeJ+Ceo54ZFfDvwEQXbLfeVQ/lxmUjU6j9GWiqOSw9YPjKnzjbj8gFkTSmKN3xYtZUBWfkaX1Akx0YcaVKSP/vGQD71W45lbaJfwzKAh17i7pEgITfIRsWWhKDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBw6DFBQgyn2I6NWS0iHzYc/GCqojxh0eR30cZWGtfU=;
 b=QoKkD/ivpZDVwZ9S4BSOvw2aMsT45xTiHGZ6viIigKMZvgJdpB19PXU2aHTjbuWsl9KK8Zv0AQpe4DDP5O7XnXf8miOBOKjdJcADyJEL9KTEny3qo6QOK8tnksJf2lJG93kF1R/Kz1URKYshwPcFKVX9xLuF1oLbebbWlQaDKRTP0U/Cw6XpTAtd1GFA+RtCsJ+XV3yMgtJkkRtgCuAZJ0hOf420DqTJ2zacfUgsgo2chDWp2Qtnf1fUxXKjk8/TCDPWDTZ6lXJzQQdu2wbItdJAm1oDJcVcYwELwWTQ9Pb3L8kvoTHGC8wmQbasuc66kSfNwuyuCEdOkzTtccaecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBw6DFBQgyn2I6NWS0iHzYc/GCqojxh0eR30cZWGtfU=;
 b=3WcAkLRI7rbmyArYv8YCQZVY2+Q5LazKZhZ58sHPirhSyVMjWCP6lOuXV4sF1UJPscAISq7CkG+n8ZFRZZDknCADsQODafqGEcUP/wg6S5lXtEjmnEbwKYBOiArqc9lq00zS71JfkNaFTEJr2YB9NyBcKCZk6Prq1YZaGyMqLyk=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:29:40 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::46) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:29:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:29:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 20:29:37 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/7] drm/amdgpu: Add CWSR and second-level trap handler
 support
Date: Tue, 3 Nov 2026 07:59:17 +0530
Message-ID: <20261103022924.1495748-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: b2850eec-5a5c-47e5-d52b-08df39524f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|18002099003|56012099006|261102123227099003|13003099007|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: QAdco3lYsGyNN12aHD0YTCUI1l1+ZAxquvbXXPNfBDrQjXJKz2xC3hcL0iSQV620gYH0E4X+Hl5rEJibcV/7aY6afLJKF5vfNPAKxmC3ey7tc15K7I8n8fz458YEC8s3r/mRz0O/UOKMmeeySsgnKknPvvrXaC87Hy/K1CTNckXBPiuY/yl73fPBufONNa+2ip92EgMhKB5D6FelNvMILDRMrsjUjxvIGDQnddd7FvXt+2wpovhfANV7Iu/JFK4RZMZ/pyfS9/WrpDn4HAhMcH9NCiFYQfpGTRavSRYokZ8Rc4MansAOlfUINiGc+0Oyw/iRh7B0IS0Ju3WPvXb2qBo8DUHap2Tss//wERucfa/M5NyOwDI9qOVxKN/7y//vQlG1iunc55chRzFRaYbwdkJQu3HMrW7P/dBpNBsniodLWoumKDxPKRZ1A9ZUqjThM3uuKXss26uIb+ocvo66rW7oUZZevjeltlYFVa4lnkcLvomZ39aBNZkgpNCaq6sDE/lubogSIDz8Q06tzQpT8P5W122rW0ih7LWPhQQHpf18kp/OLiMzpFutssqd1qW38/nvjKrsD7OwFI5of6VDdMEkOoBd8znrrSQK4mY42sRxPVQ2vE+30wIANY0Seyevkd2sSqcGYxdxhb0lKqdKGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(56012099006)(261102123227099003)(13003099007)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LY9l5i6BO6gvdTbLlPtbY106fKiuO+iwPD7v59crd4K416gCZ3dlbdWtBTN2MqFVHf3oFPxmLeQOcZo4BaRqNxf7LbcvXiC4OCJMeswXAOk/T7oEPuMvYRWbCS/myRzU0gBn45FSeeaqk4DUtAY9oKTFiT2D1GbfefZjl0zjlxMCZBkHu60WQ68F/e92PzE1Wtsp0e3SlspU9hKB5yc1313IxBZxX2Sc2y6Z2qhMVgxrZ7Rl8hRcMA++GcvTsV/Si46Sawvq8Ht9Pc08Fyck9XqD3pbklBp8D3jDSMKcUDyrbQgHExxpQ/xFmnC/E0SZ0RopU7g3NonD68z5V3ZcSuvby5pvz0dcmvbyO9GwdZLL/3HnSAPnpUzTCzfC5XC2RfDcII9IbB5Zci5YY+vGO29QAu3cshQBk5AkU++bpNWD66i/pcg6IXqa4GfXkOSh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:29:39.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2850eec-5a5c-47e5-d52b-08df39524f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds support for Second-Level Trap Handlers (SLTH) for
AMDGPU user queues.

Today, the kernel provides a first-level trap handler through the
existing CWSR infrastructure. This series extends that model by allowing
userspace to install a second-level trap handler on a per-GPUVM basis.

When a trap occurs, execution first enters the kernel-managed first-level
trap handler. The first-level trap handler then transfers control to a
userspace-provided second-level trap handler. After the second-level
handler finishes execution, control returns back to the original shader
through the normal trap return path.

Changes since v2
================

  - Fixed second-level trap address validation to correctly validate
    user-provided TBA/TMA GPUVM mappings.
  - Simplified the L2 trap UAPI structure layout.
  - Removed explicit padding fields.
  - Removed obsolete padding validation checks.
  - Verified VM ioctl ABI size remains unchanged:
        sizeof(union drm_amdgpu_vm) = 40
  - Aligned GFX12.1 trap ISA selection with existing KFD handling.
  - Replaced obsolete GFX12.1 trap ISA selection with
    revision-specific trap blobs:
        cwsr_trap_gfx12_1_0_rev_0_hex
        cwsr_trap_gfx12_1_0_rev_1_hex
  - Applied the GFX12.1 update consistently in:
        amdgpu_cwsr.c
        amdgpu_trap.c
  - Additional bring-up, validation and testing.


Base Tree
=========

Series developed on top of:
  11a08cd5ab25
  drm/amdgpu: save VKMS modeset state from the system PM path only

Branch:
  amd-staging-drm-next


Validated Patch Series
======================

  63a8b1c841cf drm/amdgpu: Add CWSR infrastructure for user queues
  6a009e39acd4 drm/amdgpu: Integrate CWSR with user queues
  593a519d44f6 drm/amdgpu: Add CWSR userspace interfaces
  5144dc590439 drm/amdgpu: Add second-level trap handler infrastructure
  3756d2ce7e0b drm/amdgpu: Make first-level trap state GPUVM-owned
  0c27773bb8e6 drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  19de9a0ed07c drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl


Validation Platform
===================

GPU:
  Navi48 (0x746f)

Firmware:

  MES_KIQ feature version: 1
  MES_KIQ firmware version: 0x00000094

  MES feature version: 1
  MES firmware version: 0x00000094

  VBIOS version: 113-G2820100-001


IGT Validation
==============

Associated IGT series:

  tests/amdgpu: Add SLTH validation tests for trap handling and trap return

  https://patchwork.freedesktop.org/patch/765208/?series=177473&rev=1

The IGT series adds dedicated validation coverage for:

  - SLTH installation
  - SLTH removal
  - Trap invocation
  - VGPR preservation
  - Trap return handling
  - Execution resume after trap
  - Queue execution recovery
  - GFX KQ path
  - GFX UMQ path
  - Compute KQ path

Validated tests:

  slth-gfx-kq-vgpr-proof
  slth-gfx-umq-vgpr-proof
  slth-comp-kq-vgpr-proof
  slth-comp-kq-returnproof


What The Tests Verify
=====================

slth-gfx-kq-vgpr-proof

  - Installs a second-level trap handler.
  - Dispatches a workload containing s_trap.
  - Executes trap handling.
  - Returns through the trap return path.
  - Verifies VGPR values after execution resumes.
  - Verifies the expected proof value.

slth-gfx-umq-vgpr-proof

  - Installs a second-level trap handler.
  - Executes through the UMQ path.
  - Exercises queue recovery and resume.
  - Verifies VGPR preservation.
  - Verifies the expected proof value.

slth-comp-kq-vgpr-proof

  - Executes SLTH through the compute KQ path.
  - Verifies trap handling execution.
  - Verifies VGPR preservation.
  - Verifies the expected proof value.

slth-comp-kq-returnproof

  - Executes trap handling.
  - Exercises trap return.
  - Verifies execution continues after trap return.
  - Verifies the final proof value after resume.


Representative IGT Validation Flow
==================================

The validation performed by the proof-oriented tests follows:

  Install SLTH
        ->
  Dispatch shader workload
        ->
  Execute s_trap
        ->
  First-level trap handler executes
        ->
  Second-level trap handler executes
        ->
  Trap return executes
        ->
  Execution resumes
        ->
  Expected proof value written
        ->
  IGT validates result
        ->
  Remove SLTH


Representative IGT Traces
=========================

For ex: 

GFX KQ VGPR proof test:

  [IGT] Starting subtest: slth-gfx-kq-vgpr-proof

  [IGT] Installing second-level trap handler
  [IGT] Dispatching proof workload
  [IGT] Triggering s_trap
  [IGT] Waiting for completion

  [IGT] Expected proof value observed
  [IGT] VGPR validation successful

  [IGT] Clearing second-level trap handler
  [IGT] Subtest passed


GFX UMQ VGPR proof test:

  [IGT] Starting subtest: slth-gfx-umq-vgpr-proof

  [IGT] Installing second-level trap handler
  [IGT] Dispatching proof workload
  [IGT] Triggering s_trap

  [IGT] Queue restore completed
  [IGT] Execution resumed

  [IGT] Expected proof value observed
  [IGT] VGPR validation successful

  [IGT] Clearing second-level trap handler
  [IGT] Subtest passed


Compute KQ VGPR proof test:

  [IGT] Starting subtest: slth-comp-kq-vgpr-proof

  [IGT] Installing second-level trap handler
  [IGT] Dispatching proof workload

  [IGT] Expected proof value observed
  [IGT] VGPR validation successful

  [IGT] Clearing second-level trap handler
  [IGT] Subtest passed

Representative Kernel Traces
============================

SLTH installation:

  amdgpu: VM ioctl SET_L2_TRAP

  amdgpu: installing L2 trap handler
      (tba_va=0x0000010000000000
       tba_sz=8192
       tma_va=0x0000010000002000
       tma_sz=4096)

  amdgpu: updated L2 trap descriptor
      (tba=0x0000010000000000
       tma=0x0000010000002000)

These messages confirm that the userspace-provided
second-level trap handler was successfully installed
and programmed into the first-level trap descriptor.

SLTH removal:

  amdgpu: VM ioctl CLEAR_L2_TRAP

  amdgpu: clearing L2 trap descriptor

  amdgpu: updated L2 trap descriptor
      (tba=0x0000000000000000
       tma=0x0000000000000000)

These messages confirm successful removal of the
installed second-level trap handler.


End-to-End Result
=================

The validation demonstrates that:

  - Userspace can install a second-level trap handler.
  - The kernel validates user-provided trap buffers.
  - The first-level trap handler transfers control to the
    second-level trap handler.
  - Trap descriptors are programmed correctly.
  - The second-level trap handler executes successfully.
  - Trap return resumes execution correctly.
  - Queue execution continues after trap processing.
  - Expected proof values are observed.
  - VGPR state is preserved across trap handling.
  - Userspace can successfully remove the installed
    second-level trap handler.

In simple terms, the series has been validated from
installation of the second-level trap handler,
through trap execution and trap return,
all the way to workload completion and cleanup.

Testing on Navi48 hardware confirms successful
SLTH installation, trap execution, execution resume,
proof validation, and SLTH removal.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c    | 551 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 771 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    | 148 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  98 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  14 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  75 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  61 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  47 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  59 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  50 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  55 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  55 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c  | 107 ++-
 include/uapi/drm/amdgpu_drm.h               |  90 +++
 28 files changed, 2443 insertions(+), 62 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

