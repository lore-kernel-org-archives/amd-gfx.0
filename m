Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCEBC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472B010E688;
	Tue, 22 Sep 2026 09:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgqaT2n0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E403210EC2C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0L0Q2+iHknfStp8Qg0U+ZvjlVU+Ce+2AS57SLGXoovU3IQNYlWmxo7PfyNC0t+W2i8FYCMwwe7B/hIu0LmcIvpNfE+fIRFDnCjmYyq12SdGEsbO/1j58MekNIeSJymsgBDzePmAVsv8dVhB0HsgcPQD+F4FneqKewof/Jp7qYCF2zeFc+FN+AHcqrcAPDzyZ9kNehNzjRZhTrAtuks7kEJ+MH3LmTeoELdZufK8nOdqe6MH7XlZQu+pSOkGIs8tEK93ASVMEJiim4boZhwSPmDHBCLY6Ciwxy5qD+C1ijwhEfhRY0rc3Xbw5b99CammQBiGvMSFV2TAFWkcDxCOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r68izOYpHcOloMwesHHqQl/Qv+wot4G613TAzUd6ijo=;
 b=O7V5/mErdZZFXc2lkJ3U9UgmyLf4mmXfwH8l71tTkviApAEM/QUB+vrAGP1MZSwyYOuKRW9CCsaK90fHzRgc64bgg11fAnzDmsKt/otnMeeRO4wxRnh0ertZjljvMYwxcFMWeNckX99MWheTSMHQJrrfYgypK3QQea3VbNObba5ZqYuWtGEaAmPDE43ys5rbI+NB4TlYjAL0kYz5DaKDSA9Xnp0mh49fMkO4i0kmYbuVqhkbcb/96+K0vOPFfJ8oGeoxco+agDcFTjcG2UBopbvU7ZmOyIsArSIv/3peI10yoVkLM0TtjCrBByUB8yna0fwiGSWxdgvzWLFe0KVhgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r68izOYpHcOloMwesHHqQl/Qv+wot4G613TAzUd6ijo=;
 b=HgqaT2n0ZBVM5G3r3B9ZaNIa1J2iHyDSRGEKc5W3bH5MdxeTOTKPc/hXlf8qS4x7Da9QzhFg3DKub/k9ioLZBD9drZHfSiThfyQViCrWvD0WXQPh60ZtBbWCXtqPqoPBIMOrpJu/+WcwucXTehVHLHWNuAdImF4KkCRHxOOPPMs=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:34:09 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::63) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 09:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:09 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:07 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 00/10] amdgpu: implement Performance Monitor Counter support
Date: Tue, 22 Sep 2026 17:34:26 +0800
Message-ID: <20260922093436.596947-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c579b7f-6003-448c-5be0-08df188ca783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ccIvf3V/XamYH7jQ6zYngUQ9epXFNd4nd+YqWo1KcyYaRDRl7OcHq7ZSsFtRQzAAupLt/Kl1ZaxPNa4Wf5UI5oIZcnM7j6SKZuzx9Bzvk47XYw2+8O2SXZgBdMgmg+ngB5vub7BoyzzX4Y0j9CWBW5wfiI2MvJCbNVB50RcU3Or5td4btlKpFC0sdhc/NVAl2+GC7ogDVfyj+Gq3YK8w2DCL7SMTaPiENMb0Ygb7d1QBnMNO2oOtNnuHtQckBiBGcPfJIv83dOrwacdBPLC2Z0Ilz0JvGeNDRwbceHZTwalmkJhs3oZoUFSHC+H3K7LSXJSMyHHMwIPLAokiU++wlj/RsvnggF5S5Npkdo0jL7AfczoyvXMKEyQDje+S0bCtySMKpsfMH3qcC0EicUyei5MkhtBCb89DM1ErLWfnWq5z9/+V6M5JKglPUcGbi6cpaegIg9nCSGXavQPOT1WB5pWsJYf4y/wjqFuZsq3RmX7cokRK1iJKRbqlNhc68sPnwWcvO/NDdUWNik0yG/aKqd4Tg910++2XUyTLsy1NwSgxaRPLUzl5HVjTa3VLLrn7DVDMiVoWcbJAemxLetZ3CY6wrIID68GvSBBTK9hsMSXgpyk+3DatukHT9Y8JrIwUC+s5fH7oS4pfPxBWBtTyeetVCa9aTVhBWqDZ9bBX0W4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hv39FnvO8CDY+31FSvC3U6c/xZmVgHthKXQls2K76AJIZIHNQxbuttsuFe7NguRn3td0YbBY/h4+S1weGJ6lfabNSLTThXhEPlu82Cf9gGQkOfgYVJVVPk+EiQ627/R3krYL9kl3JVzujHKHkhcVov0+70SIgY7XoLATvCtBJY5yav56p4kTOkIth3vA4mob7gNIiVAm5z+9gaBX7aZFHZd4ZRY6E3+MylVeM0zwornNFh4xXvTfTTrApenjq7puklzlnvb4FMPR/vAKBUfR8y4EKa8Y/nPh6cNVzxkr40EB61BGr1DaRYpa1XqrGbq9vFuykF2z1CXp/A5Ius6I348lw7mhiy6Gh1c769OMJgJ398bWNyMmQ7sRiFnOViabBboKyTGlyr+hhXbzCmOzLt7zAa5G31ssIhHdrOmxRPFO+ig+XePOvtHcMSlNmUFp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:09.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c579b7f-6003-448c-5be0-08df188ca783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1
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

This series implements PMC support for amdgpu. Including two parts:
1) PMC Enablement
2) Profiler Reservation

The user space should take the reservation, then set PMC.

This series depends on and used new helper introduced in
another series:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/151692.html

Please help Review

Thanks!

Zhu Lingshan (10):
  drm/amdgpu: implement PMC ioctl framework
  drm/amdgpu: add device-wide PMC config
  drm/amdgpu: introduce PMC ioctl handler
  drm/amdgpu: implement reservation mechanism for PMC
  drm/amdgpu: set device-wide PMC enablement indicator
  drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
  drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
  drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
  drm/amdgpu: implement device PMC handler
  drm/amdgpu: set userq perf state before publish it

 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    |  95 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
 include/uapi/drm/amdgpu_drm.h                |  36 ++++
 13 files changed, 390 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

-- 
2.55.0

