Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5FAC624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 12:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B02010E159;
	Fri,  4 Sep 2026 12:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="krIHdaya";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DA210E159
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 12:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhmfiKBNCapn0N96774+DxrKBH4kRe7AZQdAQKZw4F0Te9nXvvqtKXLUmyi/LpnVZXNAle52ABrNJ/9Cqlq1obLKOYwRL7TAzjFGk5K7KFLZJPyV1NBvgqr4hETOfUYOURLsyFczSt9V1FzdGaxv77Vw+Sf1S3e4A4qOWc+P3OZRzJDsqsIR2lJkO4gPLzShroG2oSxFK7tez5V5SGHvzkeSWfv7RTeNkShLT6SBvQftzpR99JuCUAX4r6YwZ5iPfq5kvFINEJxJI5SQzy7FCRny8pgVg2Pp9Zrhfw4Wg4L+O4OYA+bnuw6ZMvstUVb9TiyK4NYUihlsCE5oZODoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDtX20bbnvM2tTDFw3j+Jf8cHkJVOzFRITJlo/Zcg7w=;
 b=qPH0NWhzvBHXHQmhUqdQtmY8ZjAttpYdiUzjldFEW649/r4oAymPQoxRxfTZ+jD3+i0zvDR3ziDx/8y30M3fHOqX333HdlJ55ynXiTUWcRr+G3SnP+tG672FWNSTY69BCBvywxP13GTW1IAjcRGxpfs334bPRL7HGVeBulzZmavQxJZBoxeDlLVCgw/J4Kj9K5OVxsju8JfLZLN2EGWPrF8Q9KkzzsrvCfbp7r1YiT7Ohm9dE7XWN1AZ+gn7T0I5TicpCscBCtHkp1hmhZWhHqe0IK0sLqJGuvULBH5kZAUFTp2VpFi1kqx3gmmF5mCidYQeuHExPbDFO01hiDL7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDtX20bbnvM2tTDFw3j+Jf8cHkJVOzFRITJlo/Zcg7w=;
 b=krIHdayaQPKy+uRye321Lf0FZqKbtzmwHJ7ATdoYkQbwxcfqAsag/kwv/MigqGdXmEtASZwTKHelurKPsaQPHacpTm0BCzJAqhODHJ2Jl81Je1NvnoPcSsaNJ0EVr7iPYUAa0DkU+jIlGvhwJdhlCIuwkaWHu9vZB818Jru1cSU=
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:59:39 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:330:cafe::13) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Fri, 4
 Sep 2026 12:59:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 12:59:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 07:59:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/3] drm/amdgpu: Second-level trap handler for render-node
 user queues
Date: Fri, 4 Sep 2026 18:29:20 +0530
Message-ID: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d01e9b-c0fb-4e05-7b25-08df0a8460ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|5023799004|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: YLr8xotmefIsCkDzYxieoZsoxWmFJ8QatPyW9t56FIs0ofPipiYxZOIYoGGEbHhxpQ+fKRZZiPDEcPdsneAOnU/w+Nf2Zd3JLdmXx52jn9MwfAOxGliSBA9gbBUWo/RuIBy1ncy5SWpIqwwyvVQzxGXH79TAL06BgYlc72mc9K9qNg8y4M/Xt/Fw15trJsaFU0KCltN0J0IgEfsqQK16ZjI+hzPQ6iy3IoIUNCeEVpDe3whLdgE/QkTLASApsZU+vXV+n5aGwvuqIs9l3I+n5ojGdCPiezPgtEgLCUKx8Ujq2l/7KvCfQUaxFaEoh70DlM/aN3U+Y30bfeDAFqpKOvtuvVKCepUF7+fN6zvZrenCM9z7PNfle/sBBu48AxWWOeIrHvyYTtQlbIUORs4XV19KSml+vLxIoP8hrR89CZQjvvDI05VKnAsUusXRLsWpYpcpnT7xNEfPl1B9JBMs085tNFApLfFD+shTs+jloKLFVCmhsCt8D9HDgEgkytqxowbv+0ejWTCuE9GDHZnSHkzivY5GDjGimbdXrjwzWhHIw5sPU7omto1f4zciz3yWwK5eox53CeAbdn7g7pXuc9r+r3eMiRtNB+N4HrGqE2azhJU1dCdGieXzS+o2P/oaPbNU9+os2ClqdqHGA70pbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(5023799004)(18002099003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AZhHk7U4jOobX9ySWl8QSX0FGR9XUo35Rog8nJSR4PoRRGynOfO2+1C3Bml0rU40B2fhTU1WUoFqIqfOpBazLom2b5oqSfpNAj01BacIGdGRqlb2tUue9zdYLC0ZVU+0+I2vqmzr+7RJWyJmeYLffePE5/5YjvxY1HdWf8sSG+AsEy0+bPT9D08my407qlRg264x9YWETJ9ZjRxAyaN/v7qz5YVXOdB7amlk7C0VNasiU3krTJZvtO452Ua3aT5767DYJHMBfKG60IIDpsvelCDeqtpMnM5ZSI+SlSSMbqZC9IwE9srtnW7IUpH7cIe0EHXwifcg/9yxIPt+1ODdd0oiX9VShsQy80St3bipZEmTC4a0+UY3/oFkIRd5PFkfoOW6LhWMq5EuMaIrNn54It0DOllu4y1u7WDSBLYk0j9W3z3K/1AcJFSN60kGbCVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:59:38.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d01e9b-c0fb-4e05-7b25-08df0a8460ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

This series adds support for a userspace second-level trap handler on
render-node user queues (UQs), equivalent to what KFD already provides
for compute workloads via the HSA trap handler ABI.

When a GPU shader hits an exception, the hardware jumps to the
first-level CWSR trap handler. The first-level handler checks two slots
in the per-VM TMA buffer for a second-level handler address and
forwards the trap to userspace if one is installed.

The second-level handler is a per-VM (per-process) setting. All shader
waves executing under this VMID share the same handler regardless of
queue type. GFX and compute queues from the same process share the same
VMID, so one SET_L2_TRAP covers all queue types for that DRM file
descriptor. This is confirmed to work for GFX9 and later hardware.

Two new VM ioctl operations are added:
  AMDGPU_VM_OP_SET_L2_TRAP   (op = 3)
  AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4)

Both TBA and TMA buffers MUST be allocated with VM_ALWAYS_VALID. The
GPU jumps to TBA on hardware exception without any software submission,
so the kernel cannot track these BOs in a job's used-buffer list. An
evicted BO leaves a stale page table entry, causing a GPU page fault on
the next shader exception.

Changes in v2:
  - Move SET_L2_TRAP from the old TRAP ioctl (never released to
    upstream) into the VM ioctl as a per-VM property. The TRAP ioctl
    and its associated structures are removed entirely (Patch 1).
  - Add VM_ALWAYS_VALID validation in amdgpu_trap_validate_user_addr().
    SET_L2_TRAP returns -EINVAL if TBA or TMA BO does not have this
    flag. Without it, eviction leaves a stale page table entry
    (Natalie Vock).
  - Clarify in kdoc: SET_L2_TRAP is per-VM (per-process). No conflict
    between processes on user queue VMIDs. kq_tma_bo is CWSR scratch
    for the first-level handler only. SET_L2_TRAP for kernel queue
    VMIDs is not supported in this series (Lijo Lazar).
  - Replace void *tma_cpu_addr with struct iosys_map tma_map. On dGPUs
    the TMA BO may be placed in VRAM and accessed via MMIO (PCI BAR);
    raw pointer dereferences are unsafe there.
  - Add evict-flush-write-restore sequence in SET_L2_TRAP. Writing TBA
    and TMA as two separate stores creates a race window where a
    trapping wave reads a mismatched pair.
  - Evict user queues in amdgpu_trap_free() at file close to prevent
    waves from trapping into a freed TMA BO.
  - Intercept GEM_VA UNMAP and CLEAR to disable the handler when TBA
    or TMA is unmapped without calling CLEAR_L2_TRAP first (Patch 3).

RFC v1: https://patchwork.freedesktop.org/series/172489/

Srinivasan Shanmugam (3):
  drm/amdgpu/uapi: Add second-level trap handler ops to VM ioctl
  drm/amdgpu: Add VM ioctl handlers for second-level trap handler
  drm/amdgpu: Disable L2 trap handler when its VA range is unmapped

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 -
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  22 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c      | 298 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h      |  63 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  25 ++
 include/uapi/drm/amdgpu_drm.h                 |  98 ++++--
 10 files changed, 402 insertions(+), 134 deletions(-)

-- 
2.34.1

