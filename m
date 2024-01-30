Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADEC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 20:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9942711352D;
	Tue, 30 Jan 2024 20:08:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74582113556
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 20:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwJy+8z1uHZJvfN4mLWajzNW13OL0oSrgKOC3GnzZIH05D+J8l6U+RBbQfbpZDFmJBWDuiHRMgnXoJJKAxLDW6GrrxUXufvI7/aZpLpc7x0tJ00mPQvhE4OTj4BZcy+malc6+x2Gpf2tjvE5hFfoS9fr4oHUVVbkmB4y/h344cl3o/HEqJiavzrIEBbVldPCD0uUMYMhGFQIT8moXmOOEwuEdad3KJiWYXxG03fMuy1QD8D1rrMWkaawLLvKQHwjG71rw/AeDPyr87YzZSralx09ptioScRGBeo50y9BushXKWZKMgK3Y7HZdn7odNTg/lGKMhHqjtBnrd+7gFJ+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2VAD7Nb6wPPQ5J5i+DXZukOhYSsb4sWv9bQaoOiUaM=;
 b=JKAT5xBXuI5pRuzxcVeb7A0DzabnGIpSCE3+y3rRfUTSN6VfNhl0yV+he1y1HW+r6brN+uVe95GQ/+RhGIvjSnEU9O8W9RztTd87+u9NnS1ntqsTONlsDOOKFhbmTkr5HqY8zRYoak8L9++A2E2+jwG6+4w/38jwE/N+cFUzsUfrPlGmOheGRmHbUX5z1Or0V0y/g6S2a7O7P/tdoh5N6rih8OV5zJiQ2PW4wI+cp84b5iNABs44v8n37R/eUBsmgz+Sukqxr3MFtn9NlfafHf1L/FcM88dvxN3qy1qvuCMLO9GH0ayHIteaeGmOzwal+tfiPfr00GGTIwma+xoQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2VAD7Nb6wPPQ5J5i+DXZukOhYSsb4sWv9bQaoOiUaM=;
 b=MtSXXoUTJTeqY/1J6Skucl/xYcBdavkyMuIvsfeUfE3ShkbvzWPmp9EtIk97Vkeae8EkpmP/gbqFV+Bk5+FUYX1BeeoERNEtsx+nLkJ9NNIXRVov/7f2krOWQjMwMM9j/Hafq+POM4/A8+3SzeNl4ckeHpnEvsuu/gkCj+LT4Aw=
Received: from CY8PR19CA0048.namprd19.prod.outlook.com (2603:10b6:930:6::8) by
 BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 20:08:39 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::cf) by CY8PR19CA0048.outlook.office365.com
 (2603:10b6:930:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 20:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 20:08:39 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 14:08:38 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Date: Tue, 30 Jan 2024 15:08:10 -0500
Message-ID: <20240130200810.2434013-2-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130200810.2434013-1-felix.kuehling@amd.com>
References: <20240130200810.2434013-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a45409-90c6-4d0a-ad4b-08dc21cf3ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAMEu+ftZK1KKKbCuOKe3q/knkvLgWGLcUiR1IJJcawaugQhqqQZUK/oR6J7+yGFQ+aciV19KbxlFjbqn2ZfKPsFQ+yKOBfE22HQJgSAt2KdI4CRhGWuY8e1D54Zy98xDjxAVZwu9Hl4OEBoCSqdA224Hn6ItsDLngdlJ2/xVE9qBCCtRzMeZCvcMpKy/XhoyIBAEIsWJEd1hiSRBxJDrlaSVmTHdoSu8rSjg4j9uR2ZdYWNQgjjTdSdf4syyHxrQdrrZZtpIAJKrKBSnDytVPSEpciWz59yVQ2N6qKT5RtxPmqk07jJLXKFngJaQcSWuPcQ3aHOoVpmQbNWNfJu9RqaDf1CQHsJ9ezFw1SYUfMj41Fmrf7YjPnt6UEW3/tHxbWYymO6B16/usDQHu+ehgbZXlERk5VMEcpW6dsIh4qFYU1cn4Z1rS5UhYtw8oh9WwHgY0J+JQg/SrC/s5YllaSIXG/5lq5ugbcAhJrmN2zWPDuAwA1GuASNjF4aFn7LJdOpc2HVFzxPJxglopR9kaPW13ldwxn7UAidcwPSJoStmNQySKjzGaRs9q8JdsWDWi0GIVCyW05jOQ9trbTIvTdrCPNEB+Ko1zZhpe59tc718osf0n8C0a7JIPT71151cqIJRyOWoldv3D2UD7KBbECSZcFnbMAr9q62Fs4YgFFLyj6f+u1TUxOky7lrLLjk2di4DpXRwcSljO0sWcspdiFutZXs9FGPhQ6Sfoaskr9ivgqJyaDez94HQ3jfBYrlzMOnyd3fLRUVTaQOCOx+gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(426003)(83380400001)(6666004)(2616005)(336012)(7696005)(478600001)(316002)(70206006)(6916009)(54906003)(86362001)(70586007)(41300700001)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(8936002)(4326008)(8676002)(356005)(81166007)(40480700001)(40460700003)(47076005)(82740400003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:08:39.3882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a45409-90c6-4d0a-ad4b-08dc21cf3ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: jay.cornwall@amd.com, lang.yu@amd.com, christian.koenig@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
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

Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 10 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
 4 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 823d31f4a2a3..53d0a458d78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -28,9 +28,9 @@
 
 uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
 {
-	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
+	uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
+		adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
 
-	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
 	addr = amdgpu_gmc_sign_extend(addr);
 
 	return addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 3d0d56087d41..9e769ef50f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -45,11 +45,8 @@
  */
 static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 {
-	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
-
-	addr -= AMDGPU_VA_RESERVED_TOP;
-
-	return addr;
+	return AMDGPU_VA_RESERVED_SEQ64_START(
+		adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2c4053b29bb3..c2407f6a7e83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -137,9 +137,17 @@ struct amdgpu_mem_stats;
 
 /* Reserve space at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_CSA_START(top)	((top) \
+						 - AMDGPU_VA_RESERVED_CSA_SIZE)
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_SEQ64_START(top)	(AMDGPU_VA_RESERVED_CSA_START(top) \
+						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_START(top)	(AMDGPU_VA_RESERVED_SEQ64_START(top) \
+						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
+#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
+						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
 						 AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 6604a3f99c5e..f899cce25b2a 100644
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
@@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
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
+	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
+		pdd->dev->adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
 }
 
 int kfd_init_apertures(struct kfd_process *process)
@@ -407,12 +415,6 @@ int kfd_init_apertures(struct kfd_process *process)
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

