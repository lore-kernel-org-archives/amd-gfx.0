Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC4CC48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 22:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E77E8825E;
	Tue, 13 Feb 2024 22:13:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LhPrAFiD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 081D810E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 22:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS+/rfhlmk1IMPY3XB0K6yqhxCJvo8CeCUHUe1WZc0ZzJMYEwazIV6OvygR+4v9AHiB2Mm19KfJ9EfHfHnK/b5mhZZFaOJYnoRdxTbPWOWxHvAAVDzlhqnB1D+7O5N4vB1rvKtEjc6DOM+cpW4Fm5+k/I6gjO6YPYc7k8IUINGchk4igY4TYko7nRIBAHzouOtGpGBJQtjYE9agSBT0STfO3dUHXORy33fEeKMWdsW4U3mdFgKmvf3vgqW2MZVLxpGrA31FYMpa8ekFM7JvFvwJSK5qrXNi9S7w48zE2oKgruq39JldJzDpKsf6nIWnesfoT3YkEGd+vb6i7hAK7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHZwDx7izw1N61cQ54fW+hnrcVNgFnYp1ZRBUD4sqXU=;
 b=Mk2a1lKyO1Xg1sz0bZOLD57WisWCFWZgd7U+JOKqK9Hz2wRyMwOe7XKFvywAI/Ol+Jwnfj712r6WDWxmT84W0IOu7r2Su5G3cLkDTGu54tKpXYnqdZFXk/s0R1Vcxl+I98+Zy9+hHvzCIhoPWB75brWugBeQ4y7b8YfIxYupDmSCOps6b5tTO41bn3QU3UNq5vv1OK6pRKil5Idd97yID61M5tCo+atUDzvEBA9whEDLTgof0I1DHO8XT0fIE66aTvSzx6HJZSQmEjXBhikEn3OOakSLRe+H69Scq3lHQDqMpdQ4lAhSL//XcYvPUqol4Fio/GXA8OdN+UDVvneBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHZwDx7izw1N61cQ54fW+hnrcVNgFnYp1ZRBUD4sqXU=;
 b=LhPrAFiDAo2BhGhi8Xd7jE4Oss9AAOWa2+2FeYNm3/YQTcHX3iUtBqhYZMADUEn3D7JMrzwTxkhxp/6fiTCXuYxU1Hlygvs0BA3yer3UDeOgVKWjm41X2y70Y6WSYQo/wvkRCyDzxvmA+s+INb9uKt3KQpjwaIbC7vnp+gnQkug=
Received: from DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23) by
 SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Tue, 13 Feb 2024 22:13:16 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::9) by DS7P222CA0006.outlook.office365.com
 (2603:10b6:8:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Tue, 13 Feb 2024 22:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Tue, 13 Feb 2024 22:13:16 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:13:15 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <arunpravin.paneerselvam@amd.com>,
 <lang.yu@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>, Jay Cornwall <jay.cornwall@amd.com>
Subject: [PATCH v3] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
Date: Tue, 13 Feb 2024 17:12:30 -0500
Message-ID: <20240213221230.3271736-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe0f298-f241-41e5-fb09-08dc2ce0fa33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kh6VoGj7PEgA9vwuv6+LnBjUriHmV8MOYHLUMyvv0fUJ7M0f7gogXozVjuhnkbVP1STgQec7TnV9VEmkgG9s4fqbhFvjY1F4xMigmMVepPBfC7pSaO/HWUTj6L9x/U84Sus5VqA9oTA28roBnC6Ufm7LQqeTh1HJfnNLuXDP09WEMUvFZSTgeCJ5U0XpJUOYgCbrXdCcCOhJAacvU3EHKG2Tr4wzR+1PVy7EL5yVEpeRinaH5qcHqsel3KpNgdV7+z611iPtqzo9ZkR12Hzl0iN4AEv92YRw8kgLdL8Rq2QI9vgXeRrD/9p42NG3nU76s2L/kaBrNNVOg8lHxkN++eXWCntmotPC5nE+DpKyFsB4oyakuumURp9AxuI7o9Z2XQPzZhxwf5P9kf2tSSjzOxvf/APKCN0aRnohatKivRcWO5WofGm4ACkEMzMHK+Y9prNibj/Ng/pxkAgXSfuEZ2XSHQijfVqspwYSfsChJ2m0S+n7+9UdVgsBDllVkbtt4nYwI7HpQHCN7Y1mYI/igfBCfJYu/T7AfntmZcWnHZpzPRV5kjJNjv0Ry6s59hFLd2riXvgGo1bJxxzKBq+YJZtqudzlnRjyS61JL1sOT3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(316002)(54906003)(86362001)(44832011)(2906002)(6666004)(5660300002)(70586007)(70206006)(6916009)(4326008)(8936002)(8676002)(478600001)(7696005)(41300700001)(36756003)(26005)(2616005)(1076003)(83380400001)(356005)(81166007)(336012)(426003)(16526019)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:13:16.0681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe0f298-f241-41e5-fb09-08dc2ce0fa33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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

The TBA and TMA, along with an unused IB allocation, reside at low
addresses in the VM address space. A stray VM fault which hits these
pages must be serviced by making their page table entries invalid.
The scheduler depends upon these pages being resident and fails,
preventing a debugger from inspecting the failure state.

By relocating these pages above 47 bits in the VM address space they
can only be reached when bits [63:48] are set to 1. This makes it much
less likely for a misbehaving program to generate accesses to them.
The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
access with a small offset.

v2:
- Move it to the reserved space to avoid concflicts with Mesa
- Add macros to make reserved space management easier

v3:
- Move VM  max PFN calculation into AMDGPU_VA_RESERVED macros

Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  6 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 11 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 ++++++++++----------
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 823d31f4a2a3..b0fb14a4b43c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -28,9 +28,8 @@
 
 uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
 {
-	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
+	uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(adev);
 
-	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
 	addr = amdgpu_gmc_sign_extend(addr);
 
 	return addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 3d0d56087d41..4b9afc4df031 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -45,11 +45,7 @@
  */
 static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 {
-	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
-
-	addr -= AMDGPU_VA_RESERVED_TOP;
-
-	return addr;
+	return AMDGPU_VA_RESERVED_SEQ64_START(adev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2c4053b29bb3..42f6ddec50c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -137,9 +137,18 @@ struct amdgpu_mem_stats;
 
 /* Reserve space at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_CSA_START(adev)	(((adev)->vm_manager.max_pfn \
+						  << AMDGPU_GPU_PAGE_SHIFT)  \
+						 - AMDGPU_VA_RESERVED_CSA_SIZE)
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
+						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
+						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
+#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
+						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
 						 AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 6604a3f99c5e..4a64307bc438 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -36,6 +36,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/processor.h>
+#include "amdgpu_vm.h"
 
 /*
  * The primary memory I/O features being added for revisions of gfxip
@@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 	 * with small reserved space for kernel.
 	 * Set them to CANONICAL addresses.
 	 */
-	pdd->gpuvm_base = SVM_USER_BASE;
+	pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
+	/* dGPUs: the reserved space for kernel
+	 * before SVM
+	 */
+	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
+	pdd->qpd.ib_base = SVM_IB_BASE;
+
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 }
@@ -339,18 +346,18 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-        /* Raven needs SVM to support graphic handle, etc. Leave the small
-         * reserved space before SVM on Raven as well, even though we don't
-         * have to.
-         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
-         * are used in Thunk to reserve SVM.
-         */
-        pdd->gpuvm_base = SVM_USER_BASE;
+	pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
+
+	/*
+	 * Place TBA/TMA on opposite side of VM hole to prevent
+	 * stray faults from triggering SVM on these pages.
+	 */
+	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev);
 }
 
 int kfd_init_apertures(struct kfd_process *process)
@@ -407,12 +414,6 @@ int kfd_init_apertures(struct kfd_process *process)
 					return -EINVAL;
 				}
 			}
-
-                        /* dGPUs: the reserved space for kernel
-                         * before SVM
-                         */
-                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
-                        pdd->qpd.ib_base = SVM_IB_BASE;
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
-- 
2.34.1

