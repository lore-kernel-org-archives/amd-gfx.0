Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6879C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 05:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A24910E074;
	Wed, 16 Sep 2026 05:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixq0deUz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5CB10E074
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpqdJ7ZM3InaciiB+D8QWDFTx5Dc8DlkDsmOo+8G8T6Gv8kLgp+JRypB6Eods46J47WtqVLvjkJ8OFksRxKAHW9ylrQLoBnvXEckIigzG8FmTRaV2Hm6ZOLgNiE4SdGjfYB92HkltXMClfP6ec1Hm3yfB/0qZV4o2FhNC6zVAAOpjxk+Baq2/Kk8nKsDRynlFkM1m9S4tzy/9zh/NLgdiOOE9XfCb8RKHw8S3TzQ0ZL3LptUbU/gsHAgwjpFNYUXokuIYmSd7YUn6trsM4bnyJbUKzqZ/YANr3zWNmKqXxA9kDtW75KqDQEAq4P5tOIlZ66oShMZ6FkbOWo/BBbcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXaijMfpTuCtB0Itxjk9U145YJw/3LTwP9G8VfA1C2I=;
 b=b8i9oJfm79uiDB+eU5wRhUq9E01rIfEZcJN5lWn0Qn/1DqGtjlHZYRYN3ZSN5YABlr1HSYRjVGcqY4a3/rYww2lu3we5cisk0T8T9t1xZsR6LCOJxFMSyZmt3haPnMwAqj4SabF5qhC6hcfaWtZ2TzjsKiEfro60kDW4v2oaxJybVf7vx6dksdIH3ziIPcnfdlBqIloLlPycYY48hyzXum3TBwyAnoZ00MDgPgiBH2LHTnLfzPSJ0HlLlHXwJu7MSCDEpjOWkqGuug0TglX5bRAztPqNVS3FscSMMSOmxEM/m/zqCeqgvHtepd4/wuFy8EqTUu5faZTopMD+l0y+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXaijMfpTuCtB0Itxjk9U145YJw/3LTwP9G8VfA1C2I=;
 b=ixq0deUzCg0xvMSmWOOskwh5E/zE70x86jLtYq4RQKfCcpVV1pirw+yLQVGs3xsCZr8I+IKeqx5Q6t8z11J9+a4EwIQD/WLjASMHTuUQod9+AW6tpwKiDYvudYPXL1VioW3zb9n9opzgNPaIivUGTR10MDsVRat0kyrkMXUQkbY=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 05:37:43 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:510:348:cafe::71) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 05:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:37:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 00:37:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/4] drm/amdgpu: Second-level trap handler for render-node
 user and kernel queues
Date: Wed, 16 Sep 2026 11:07:18 +0530
Message-ID: <20260916053722.601067-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b40fc0-8a5a-4f6d-0f51-08df13b4a18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|5023799004|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7ky5+qubvBopT+/J288D+o5sxOgkHfRugmaDN8y0hJ3EGfgMdxyyEKKYyw6KFZbcoAOqlxAu+TDu56unVBW6xUa7bpBy9b360tQWcblyWNrKq1ZEIYSCF0aicBvvuabSRdwaiH8Am0TmxVF6B1pUVxzTPKQ9dwdyVmwuHXD+CTRfLGpSjEhku+Dq0FxuAeoSdedzUC69fpizrpK9tKsWe2LWsTVSRW5Nj3T4+Htj85Ey9iaBJ72FEipyHOXpalpojoVnXlYlbSxdJhxQHavR5RGUkZQie696+w1FdweccYmZda/n38cj2SrefWeglO6ZB+RWbOXMhFop2xOKXVikBwp/cPputoJO9AZHdM77vrSA8+oGxPHJwP4hwSohvH+ciqivt4CDzmrzx1BB80yUC/vx7XfmJCunDLsNOUV2zhmydBGad1sr9Nj+vWh2uLXA8eYYgMxQ6vbrz3XtFBzS9WbQs98MO0sGj/3D8M+fDhBWg75VRdIrOolReIBzcde15pK28S2z3lHyu5fU6tKrzPmx8soiWHOTKnpKf9pYp2/CifFEvm7BAYD7D4u51wFCqWOq3za6uktWFIXv/P1eZtHSnI5WN/gbk+rz5uEUTXKhMVSEYkQelbDJbL/B8fQ7hXsMWw3K64wbiqjsqnDYjWxHzvf3czIVt3vY5JvfFwtO0RoYMmG1SMLfGkKgRRR0tcOL3XM5+qv0NI+GZ4tTRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RMoOM79pe/5Q5bOmyTnCv0tbMgmHdlxeqjyk2D/B7MaTUri1vwWcDcOH1hA8qgVGXcUpNI+HgMf50uZr37fQrtu/DNlHVyHYMPV0sD+8yf6c9AHMIJuPOJ1RhyDMknjrxNjApTqwNINuUbh/JWzkfPiJjtKDglWiiBVOzuMDM74ii49tX2pw8ftTslq1PP6FafGYkYeqo/Px33Ul578uDFPLCPJSJ0ojPUUkEr9lBKMf6TsWRLLoGbUAdh2Rwgc+GAaDqN80hm+AquHDQoExxTr4BW6HRVaMACCuEc78EdM/ETcCMI7OlrpCjNPjzyIIJHDA5qfKAZpeEaUukNYutbb4bWIWmI0N1EXgZshiGVIRZz+dNhVlrY/DFbAq0CMPv1SYidKEVGvxqKSw4JrpoJgdseXF0Q+Ql3VvbMWlABiOwa0bUIo3tR/ao4HuX/Pf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:37:43.3974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b40fc0-8a5a-4f6d-0f51-08df13b4a18c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

Background
==========

When a GPU shader hits a hardware exception (s_trap 1), the first-level
CWSR trap handler reads TMA slots 0 and 1. If slot 0 contains a non-zero
address, the handler chains to the user-installed second-level TBA and
TMA. This is the mechanism used by RADV/Valve for GPU shader debugging.
KFD already provides this for compute workloads via kfd_process. Render-
node file descriptors had no equivalent.

Design
======
  - One global TBA BO (adev->trap_info->isa_bo) holds the shared ISA
    binary and is mapped into every GPUVM at AMDGPU_VA_RESERVED_TRAP_START.
    The ISA binary is identical across VMs for the same hardware generation,
    so one device-level allocation is sufficient.

  - One per-VM TMA BO is allocated at vm_init and mapped at
    AMDGPU_VA_RESERVED_TRAP_START + 0x1800. The 0x1800 offset matches
    KFD_CWSR_TMA_OFFSET so both KFD and render-node VMs share the same
    per-VM buffer layout.

  - SQ_SHADER_TBA/TMA registers are programmed for kernel-managed VMIDs
    from each gfxhub's setup_vmid_config() path. User-queue VMIDs receive
    their register state from MES/KIQ at queue creation.

  - SET_L2_TRAP is a per-VM operation exposed via the existing VM ioctl.
    All shader waves executing under that VMID — whether submitted through
    user queues or kernel queues — see the same second-level handler.

  - For user queues, SET/CLEAR evicts all queues and flushes the GPU TLB
    before writing the descriptor. For kernel queues, the VM is drained
    via amdgpu_vm_wait_idle() before eviction and the write.

  - Both TBA and TMA BOs must be allocated with VM_ALWAYS_VALID. The GPU
    jumps to TBA automatically on exception without any software job
    submission, so the kernel cannot add them to a job's used-buffer list.
	
Only compilation tested.

Srinivasan Shanmugam (4):
  drm/amdgpu: Add second-level trap handler infrastructure
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 288 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  73 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c   |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  44 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  35 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  35 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  39 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  35 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  35 +++
 include/uapi/drm/amdgpu_drm.h               | 114 ++++++--
 14 files changed, 613 insertions(+), 120 deletions(-)

-- 
2.34.1

