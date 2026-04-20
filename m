Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50A4F588C3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5993C10E62B;
	Mon, 20 Apr 2026 13:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3MYqDoT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8594210E62B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxXzeF7N1w8cuj0aVa4Y8lVyBbbFOO285jIqXvH5hzC48dZmyuqtu/Z0AXJm+RNUEE/nycQEF04A01D1Qmv36y1xjRW7fR+/+VMoMu57AsciyHQyuUT1UfKtoaUwlo3wbLLvi7Ra1WHmgXe53V91Z6lpVduyGd01GmEVEtQijTo+5uMReq65h62QM2h0hGtoIGCN+jyw1SCW52D732xHZbgML6EP5A6UViVgrfTU3kPjsS3dE0zK48Gx+N3x1xIYu33fwQa/uQRmfEcs05yU8MdIgI9/TF6wOhacLPJqKdoRUHVgD95CyRqs3A6cIpdHoLgdyO1hePpuLA0LSf3K5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68d1ZJKHEvXD0V6+4kf/GVO8VAj9oMJiW27iAoap9Sc=;
 b=qBzg3gkFxaTK7ac0pYfc8qEN5xWeDgSXW6oNBe1iwRXeITo/TK7kNbWGmFNehYazvV0kKmIS93RXw8vahNn1Ky9VeKI8qWPC9H0XyIRmCvmhc/ZGy8KwxEi/FyVhHtAmmZiFDwK5vLRnQn/17U+Uy/5PW0SYP1vT25bK8ZXwsDKYu6EHAZmcRe5PNdZymXz8ruqxnoPUnyKfGOiN/ZcFhmtpyfPaS/LfWuZP0FIp19N9AjneWOoHcMApJtByPuwfVaYUk1cZWMGYHubeOFTO/z3H3kx7Ec83W1KihMK16tRGI51yZMhyKGLoapunoeDxSQrjNl2zOVtUhrBeX1yB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68d1ZJKHEvXD0V6+4kf/GVO8VAj9oMJiW27iAoap9Sc=;
 b=V3MYqDoTRhiyD9T9gx7qGSEVT4RprXtWCudiSEcAoj4WjU2jZlCyeRUV7bhSwFfgoYCurK6ri5yo8z8U5Jbe4wIfPp/6m+YJv8tId2gmU/2iA/MjTE2Hwl2Hsl6P75zHacGBueCzBX3O9d9tc0ZX+7+pzzm18r/6A44yzFOpj2s=
Received: from BYAPR08CA0018.namprd08.prod.outlook.com (2603:10b6:a03:100::31)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Mon, 20 Apr
 2026 13:38:01 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::5b) by BYAPR08CA0018.outlook.office365.com
 (2603:10b6:a03:100::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:38:01 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:38:00 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Kent.Russell@amd.com>, <Andrew.Martin@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v2 0/2] drm/amdgpu: per-PTE MTYPE override for NUMA locality
Date: Mon, 20 Apr 2026 09:37:03 -0400
Message-ID: <20260420133705.3721315-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ca0064-c751-4ff7-453f-08de9ee20adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XDH48VX1PJoeQjw/2WJXDqME1K4LPfBdHPh9VxwVwP5OX/aejDEBBEooc+97npdNeyRFZRxAWsynSu/dqweTP0fG2gog/S0iv679mVrNUTgKuraU23zZl3Gurs1/g13W5yY96F+/bKFaUBCaessnIK5qoEYdDO3yR+VbF5C5nFWxTHUt45xarE76+79LvpweewOjh6jxG238fqE1f+0/Td3FWOK8oSeR3da6GmDQerdPPxR3HI2kGqxjnrg6vuKhtKoamL4N82WMnjNOaW5l05o9TQ4URV9mzY6dgv1Wz7zFW7TTe7VrLXbq303qUK2KTJHu7NyUvz9dWckXZeyy07NqYsVDtqXNnHEbMu3jmz4A1pa8jFDuck9CrkGB/NVjeskIMt1OHyN+6h62oeZ+5aTIOvwgmx3oDfcUlY3ZXcApP6CxCiAI/K9eD8RsK484AWRdOx2YCDPCuUI4dnGq8hA7XDnnCXjQxK+SRr6trvIDUUSuJ9jyKchATP0EMM3MFN3X+yNvLnUn2BPyslMYSHsXrFtBaUUqhEGDxTH/OVUTtc9+zfXn3WnZwqq1faKP+jwyiTN9qGB0Kho2A/63K8LQdaNM8++91U1tbliF4T5MUIZNq8vJCYMHeSY8jvRmSLDxPUnuBGrXKWTe/B5ASELHx7NPxX0H/TOYIKbAIHMaxaRuPDwgSQ/UMEwcFZnmFttm5p8hdPh4gsg9XRTsthGn6cgfiU8q6Nn0dvw8OTmvYvrxOKUgOiRwZlsycXt+YLstIPJeYlnp0OZtAacJag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WTvgRttyj2eB10rC4ySvgdS5S+nkAeaxy/qhWQH5mSQLKVFnGYnugUl9RBXTdV6tVtjqtKB1MYOhFtYQEnvyEbFKG1d/CUBotnKxH7VsQNRp9Y4+AfLHTH6Tfq+HuTgYyKU35Z2hPsGXuI/XwCwyZDTWxnVTZiL9nGzvtLYIkVD6rFd/zE6v1F3NLPxkwVVRQmLVTK0KNZF/3iJem5CtKPsyS/Bjslnzddhp6yfWjoRNPdHUXZyhe4I1P2vVgokfudFbf3ytvvxuZA3eukXHElR3LZeXKHHBzcKxGyry/9oVGc23b0bXCY6TcbI4SiXw/VnkCnTdnKdajtOF3fRFX1B8Kn1tuyJKUXHrz9Ydph4GTQrII1BHkiALJF1loHQr0OIfyHBlN7TvSTbBkJ/rU7/v7O+gFbTM7bNPSffW2dYQ29aYu+1Z+HYgwRWplmiS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:38:01.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca0064-c751-4ff7-453f-08de9ee20adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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

This series refactors the NUMA-aware MTYPE override for VM page table
entries on GFX 9.4.3 APUs (MI300A). Previously, the override was applied
once per contiguous range in the centralized amdgpu_vm_pte_update_flags(),
which missed scattered pages (pages_addr path) that could span multiple
NUMA nodes.

Patch 1 moves amdgpu_device_check_iommu_direct_map() earlier in device
init so that ram_is_direct_mapped is available when gmc_funcs are
configured during IP early init.

Patch 2 moves the MTYPE override into the individual CPU and SDMA update
backends at per-PTE granularity, enabling correct NUMA-local MTYPE
selection for scattered pages. It also hoists the eligibility checks
(APU type, IP version, direct-mapped RAM, multi-NUMA) from runtime to
init time via a new gmc.override_pte flag, avoiding repeated checks on
every PTE update.

Philip Yang (2):
  drm/amdgpu: Move amdgpu_device_check_iommu_direct_map() earlier
  drm/amdgpu: move VM PTE MTYPE override to per-PTE granularity

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  9 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 35 +++++++++------------
 8 files changed, 44 insertions(+), 37 deletions(-)

-- 
2.50.1

