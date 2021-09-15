Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 01:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98CC60F6C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 01:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B98CC60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CA86E88F;
	Wed, 15 Sep 2021 01:43:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902A16E88E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 01:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbPhAuQd3z+ruZZJiAQ1B/FQ1R4/Rw85JIuA+l0qEsXtpLGPY+/W8DchZ2fhDVK0b21sBssls7PRgjcDQ7cxQ/zUJGg4wcd0ZKRZB8v62aNbz7slykB/SK3loKc8kwYLjsiuJvFAQbOn+5nPoz5Mp6BEtqRxfZ3086i9NXVFsZSlV9QRLST3iu3xvH0NiFJ846a53OKqJUFCsp9J3bIysUqKYuCUi3S5Ip2na08BLEvmk+CA7BftioJEENBfNdXoj/iTnwnnmvIeyosKDUwWGpb4DA+H2NPVf9p7LObDKxUxf1bdfOTTF7m2iHRFvfJH6Oa+ZRpwusOypicN2LHeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=bfxG7hDB2qCzZo5Qhjjb0hyjOJs1/tdJKGx5MqjfxIQ=;
 b=MQQMCGUu3AWcjdem5l+8px81nzv3vu+mF9fcMUSWDjgQh5aHLevpnjWH26Tm7ndYPH9L6/Edct1KK4HWuNhQGGSdg2r58hNIQN/6QpZhouCEbeI8PPOm9Aal3yHPWt4kr6dx+ygqO80u5gU/C+9D3BUQa8Vs3ozXInaYFskh539Qque5C5raeKxNQcpT3ulb12xkQhGZpRXPThHuzh8c+N9dZ6AYVSzgI3FU05xXAzG/POOT07dgkvzspdbPkopjT7giXsJ8SgAAFjpmpSItqna9aRHDpwHlfY1VQhHIRSPyQ6nhQmKhVfpsNz30B/ynUOuJ6dIBMNKdw1KhWbZuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfxG7hDB2qCzZo5Qhjjb0hyjOJs1/tdJKGx5MqjfxIQ=;
 b=1rBf6s1Q6lz3DtZ3euxqlwSYw0TCZONBVAYcpMF1JGUwQ1fVMgOCaTuOi4bE+0i2rT8RyV03bsQE3Fs3yzFXIk3zbx9XFocvQgS02u3ab02uD0TWCmMmgtkGSVP9W9/KgVxahmNVJ59YIdMYtbgqgUXfpq6haTGg49ROdwDpk+M=
Received: from DM5PR07CA0155.namprd07.prod.outlook.com (2603:10b6:3:ee::21) by
 BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Wed, 15 Sep 2021 01:43:18 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::af) by DM5PR07CA0155.outlook.office365.com
 (2603:10b6:3:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 15 Sep 2021 01:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 01:43:17 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 20:43:15 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <andrey.grodzovsky@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Put drm_dev_enter/exit outside hot codepath
Date: Wed, 15 Sep 2021 09:42:56 +0800
Message-ID: <20210915014256.20404-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d244ac2b-9533-4f9b-d644-08d977ea312d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4756:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47560DF02C20FEB9CAFCF0D987DB9@BL0PR12MB4756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWvWr734o/r2rnqkyfednmFsVrm7AfGdNZduQJocDTrtSOItodwihi+fQoLtpYfnWWPHF63AN999UoSa2/EzwlZe4fXJ8/GcXC82RMn4YLWw8d4UiAQKpeWkg6LFPMiUGgFI0BuIv7CaYIHikCYmh5sKQrwQLI1N1JOlcTNEQdCDQ8qmRIkWv/cgTZIpOt6TRobPj3UI5Gmnusly1oViYBLlYy+a/wz1TreiqJdaGTS5eppoLjh8Fq1TcvCGfb7GWUxNRAmz/3y4y8EAvYgmianL+FjtIZbpbc+a1eYCyuiciHyVJeQrwUPeIPpZUe9O/lRdZgEW9N1zUI55z0riDmY9NSZQE+58aWNcz1LZcFt+UUry3nJiCqOw9LUfbBT+97e4PAGhco3HwPMXG2aKzeDE6ZdgxWARjaJw6Uf1omJYH4GUNvaG6hxSL65SkBkMXlPJSV06z+VcRWWLoYTkQQrPlS0ZMPL+mBNVXzQsCEiNzMpSeYly1wxARLm6MeyDbX/j0wVVJcotjDggRs8lT7kFWwZkl/kWk4+Dsqc/jrStLXqIb+DZJufDXE/MLhgCk316I2s9m4Ot0oeYdw6/YmkZqBSypyHZQPzPL7XsYmkQanqnJJcp7LCM6Yllr5tr/ZmWiw1D1i5juIoc79TcFr2N/6gmRGhxK9zIMv42bQvytXvty5Ff+fdOMg/lFi+JS90gefm5a6dUECE7KMWThiqby7bWNe7U3JUjNxAgCT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(46966006)(36840700001)(26005)(4326008)(36860700001)(478600001)(54906003)(426003)(186003)(82310400003)(16526019)(81166007)(316002)(356005)(83380400001)(2906002)(7696005)(36756003)(82740400003)(86362001)(336012)(8936002)(70206006)(6666004)(47076005)(5660300002)(70586007)(6916009)(2616005)(8676002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 01:43:17.9676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d244ac2b-9533-4f9b-d644-08d977ea312d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
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

We hit soft hang while doing memory pressure test on one numa system.
After a qucik look, this is because kfd invalid/valid userptr memory
frequently with process_info lock hold.

perf top says below,
75.81%  [kernel]       [k] __srcu_read_unlock
 6.19%  [amdgpu]       [k] amdgpu_gmc_set_pte_pde
 3.56%  [kernel]       [k] __srcu_read_lock
 2.20%  [amdgpu]       [k] amdgpu_vm_cpu_update
 2.20%  [kernel]       [k] __sg_page_iter_dma_next
 2.15%  [drm]          [k] drm_dev_enter
 1.70%  [drm]          [k] drm_prime_sg_to_dma_addr_array
 1.18%  [kernel]       [k] __sg_alloc_table_from_pages
 1.09%  [drm]          [k] drm_dev_exit

So move drm_dev_enter/exit outside gmc code, instead let caller do it.
They are gart_unbind, gart_map, vm_cpu_update(already hold in its
caller) and gmc_init_pdb0(no need)

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 -------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 76efd5f8950f..d7e4f4660acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include <drm/drm_drv.h>
 
 /*
  * GART
@@ -230,12 +231,16 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	u64 page_base;
 	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
 	uint64_t flags = 0;
+	int idx;
 
 	if (!adev->gart.ready) {
 		WARN(1, "trying to unbind memory from uninitialized GART !\n");
 		return -EINVAL;
 	}
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return 0;
+
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
 	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 	for (i = 0; i < pages; i++, p++) {
@@ -254,6 +259,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
 
+	drm_dev_exit(idx);
 	return 0;
 }
 
@@ -276,12 +282,16 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 {
 	uint64_t page_base;
 	unsigned i, j, t;
+	int idx;
 
 	if (!adev->gart.ready) {
 		WARN(1, "trying to bind memory to uninitialized GART !\n");
 		return -EINVAL;
 	}
 
+	if (!drm_dev_enter(&adev->ddev, &idx))
+		return 0;
+
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
 
 	for (i = 0; i < pages; i++) {
@@ -291,6 +301,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
+	drm_dev_exit(idx);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 54f059501a33..e973488250e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -31,7 +31,6 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
-#include <drm/drm_drv.h>
 
 /**
  * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
@@ -153,10 +152,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 {
 	void __iomem *ptr = (void *)cpu_pt_addr;
 	uint64_t value;
-	int idx;
-
-	if (!drm_dev_enter(&adev->ddev, &idx))
-		return 0;
 
 	/*
 	 * The following is for PTE only. GART does not have PDEs.
@@ -165,8 +160,6 @@ int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
 	value |= flags;
 	writeq(value, ptr + (gpu_page_idx * 8));
 
-	drm_dev_exit(idx);
-
 	return 0;
 }
 
-- 
2.25.1

