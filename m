Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECCCC88E45
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB0210E41E;
	Fri, 11 Sep 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BW3TT9J/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DF310E41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICKzMTZR1Oa91HkW4izMh/7tmY6jxeKvm6VHkOeuEJKZqeEau9CnvOt7zJEeoQYtiZpz2Q39FEaF5Mqg6/PngLJc5F87ghwXxPp2SKckV32cr5ka/SEig1+0LSipHB+p4BVkMqXgUrtm4UwoiKJvRn5CfQnj4pd80U3khD1FjEU6A+0icOmFHC69Y/dqsqhGGvye087xKzb60eu/bXclagWOK+dMqZPb5igI+rFxpZbsDonYi4UZeJwZ41MXxl/lH8Z/fIxaXuzLYXymS8k9vsmP2TQVVq8yqzjfTY80FgJiIsPnWX+yaUv2k5MAvkZnmFmFPXYNk8eeC7/fv+oSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PICGiBspzIcpG6IW0G2OplhMyHgafMD279ia33P2L/o=;
 b=huGC80ObJFU/u6ZkDGBdG5DkapUc9N6d4ngVfJLOMN/cFX6pIJKFbSVxVQrMUyQc1TupekdeoG5QoY6+uJTNwFNhIJS0QyyHyTNkSejExvhkNDsTTH9STQ8Q9TMI1uMm1bX4wjWJOp3rtwCW+QA6mS7Mvaqb2ju1/jOylJLjR6jj5eTbjPSmhefAoN4xc8v98X2VwD7EKUjJ+O8yqnedwmKeO1wRh8yFQROFgFw35vBSSnqA81vtC2ZyoCM/AYvd86lbq8zfgfm3BwsDrLB05fMbVIBoQAj6KdogUWLATUj9g1tXIwo87jKtyz9LGoBIo+hQxAPaFy+y4fXw68M2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PICGiBspzIcpG6IW0G2OplhMyHgafMD279ia33P2L/o=;
 b=BW3TT9J/BNQIf/suasmCrHlr5YDMKHdJUPd3hgymRuDdeGy0+JFScn5jBVR2N4t0cTICJzpi4yWDK/8++ZD6xz8BHokG2Y7DaR/Uuc6BOC471oLd79z/sTg0FgDCHOprV4Y2U+5Mbmrh+QUaazTLEMbezuk4M0Ir06+u0VqVgAI=
Received: from CH2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:610:5b::23)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:23 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::69) by CH2PR07CA0049.outlook.office365.com
 (2603:10b6:610:5b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:22 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 0/8] rework runtime_pm for GPU ioctl access
Date: Fri, 11 Sep 2026 11:42:03 -0400
Message-ID: <20260911154212.591213-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc8c7b1-5aa8-423f-a4ec-08df101b4589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|6133799003|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +mrv0P0KEimez9WYpxFk1rTcVEViRNioznn8MMJek6Qbc8UY1/Y1hZr7yKeRTlNdIy6jXBsAjKSQpnf6sYc8JG2o8psg6aW6zQDBnhZ/7934drOvUi2Nw9j9tGudkFF0t8k8vWZvjSpP7bg/CRQo2Ts/HqOHT9+3Oey7iZw66cV0d4klXxf5U6jYF0qGcEyILC1grYzNDzVmAF2WZt7hpY4BIwEQlJTpolTSp8qmjzGI3Rxrd7vEcab5cwoQCyA2OzoVa6aPSQJwNLivtZ4yr9ZYqEQB51b7YYClZq4Rcw28UVptbZmucBqYPT0nNN6czgTiSvEhFjBE/gGppxjS4k5hFc7N8mKf9gTiNDNgn5nAoc984lQbhzth++113jWzPD9MxKcHT5MTkpKL4Lz4CugCUuwoF13WtNxU6ycFCDHtbDvl3uj5G5+hN0AjN3XtJbVwR44L7X451pMiYrlWFI43Dpbb+xuuYwtJM4wnC7anVHNpU+J5cT7o++YsqT0SUn5G0XnGuLU3caGmRQXua9iQDmTKrT1NkAa/JO+9gRh1pbWDcBIXJ4dEaeFjj3tK4CdLn/3843pkm6Ep7H0Ez3tInXdZjWNtbjPX1ibNshnU1AKcIgwWv2Qzruv2sEQVNSTPIzVjryVfC7FGp0aAIlFqfmFaMTn/MzjiO0ArjVunbiumyJDatDU0cM+xgP3g8BCJ5uZBazZ9lhZUEoqqZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(6133799003)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CoFP9EfGHclMT/zYiSKffyvTjQFHTOwkVImqVTlMIg/KCsUiJuKSCluIxN7BTAk+1lq/8eiVK8ouWizohzk3HEnd4m7dGs7pBFZaewdQ/SAioVXK7bB8Vfn05vScdc3/jNS1ttpgn+B1tS1A8dG6v2R0cwZjSjxjsQCBcUJqc1bA/hi7gpufbnMAysYJhCC9ekTo1C9Vqkyhy1DK2Dxh6CTstp6ZpvpOhEh2PDJ4PDN+ZyolIx7jUwZEQ8ySf9cx1FSQmqhOibCTMNDvhgkPKepOiqvIG9EXbrTv+FLppyBD90jVH6xMDb4hASRXB9bzT8YTfLX1qJtL/ibDjLMygD/kAqvclEBKf7NVEUJC5pFzhCxdIZvCCJo4Fjx/yPjgy2iUYpHZDbuIxOj31VZtLACd6nt1Fcz7WkURxNCqmzD2c6hLjnAgqr9C2b30c3TX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:22.6264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc8c7b1-5aa8-423f-a4ec-08df101b4589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

Historically, the GPU was woken up from sleep anytime userspace
triggered an open system call or utilized an ioctl, even if 
hardware access to the GPU was not required.

This 8-patch series reworks the runtime_pm system for ioctls, jobs, and
open/close calls to allow a few tools such as AMD-SMI to function
without waking up the GPU.

Pierre-Eric Pelloux-Prayer (7):
  drm/amdgpu: use pm_runtime_resume_and_get amdgpu_gem_create_ioctl
  drm/amdgpu: use pm_runtime_resume_and_get for ctx ioctl
  drm/amdgpu: rework runtime pm management for cs
  drm/amdgpu: push down runtime pm handling in amdgpu_gem_create_ioctl
  drm/amdgpu: handle runtime pm in amdgpu_gem_userptr_ioctl
  drm/amdgpu: prevent suspend in fault handler
  drm/amdgpu: get rid of amdgpu_drm_ioctl

Shahyan Soltani (1):
  drm/amdgpu: defer GPU resume from open/close to first use

 drivers/gpu/drm/amd/amdgpu/Makefile        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 10 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 23 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h    |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 63 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 15 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c  | 45 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 42 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 16 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 12 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  2 +-
 15 files changed, 138 insertions(+), 114 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c

-- 
2.55.0

