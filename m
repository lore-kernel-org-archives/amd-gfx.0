Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8F6C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 22:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7771E10E505;
	Thu, 25 Jan 2024 22:28:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292DC10E505
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 22:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl5BHfTZ54ASP64B1DEInXAR5fX/yO5phdof7bk9E48juvY71miEqh1cgqjQlcbq3gER6MHDVAIcfYYZBv9ew6bkBJ2e6Iw1PuilV6CSzDQV+apBOz6wcUo4epPiuOh8blWusXW+9zRopBBTYN3KGFXFBlUT+486poLz5yMMzZX2vjaO/sJ0hq4JwI1onQPa5ul68KteGxAvEAmobxfrY/yEt2iGwkZLfb8Jp2BOukyVFXZbBxYI+MyGX0ZLLPAIHTL8hpdGOaIkEKoNeHuymGDk87PF27R/EKY+0ftDkb1G8Kavvi9Snq3wC3fewirOijjRPTVHYzrFz6tQGNVovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8wxfmUi7RqqAK5Oq4fqGW9aDfX5O1k1eC2UA/wtGsU=;
 b=OZVDF7E07TJpoU//rZtrilHPBTtPVFXUU5xnD4fUhyI9SkgE1KYWxbPGAHmF7FtsRAJTAkeNPoR4cJIS3IKByE5BKJgwfwf1rMeWD6JhvEVmCTfXAuKf+ELd5fibMYYYoEsvIUsxKaVhiYs2MjdmPGfo1k5J/qZ+xD2djjpqqNqqQ9Y/4fKnOBru6iMDycNzUUvhqh1JKotOehazc6pG51UyiutGYv9QMl7joV032w69HZ+AmGms/r2cb0DAjRzBh3oWTTNOlhFSPUAnYkuCxmmloGLa0GkOqEetmK9+DDg757IDNTIo4n3KA4PgQR1zLvJEsCLzYb3UZE5jcxnTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8wxfmUi7RqqAK5Oq4fqGW9aDfX5O1k1eC2UA/wtGsU=;
 b=UUIoJtJbvhBxaJZW/Man6qALxxnxjxpcskKDqfWW2QzjKmqqe9p5fd+CR0Ys5MoT416lPsCXUmzYAcn5nfLf19EwYa87R8FjQjfYjFSih6DXjO13LFQ95eYWiud4kr0IYcZHtajCRzwIOikhPRaqfh6uj90iA3W5PR5eOnoPeYs=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 22:28:20 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::1b) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 22:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 22:28:19 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 16:28:18 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
Date: Thu, 25 Jan 2024 17:27:48 -0500
Message-ID: <20240125222748.2089791-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b04ca63-d8e9-4de0-3c48-08dc1df4eec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnU3QGIwn3Ac53CZ3WZ0oO2I3SWr9NEpVxYV/9RMZ4zKWEWKGOOFMW/V3OS0+ggTJ07u/V4s/VtAyjpcnuEWZr7jlAbzhp8Xi4yZxGMjRH0NmhmPMwS+GGeF37a5Ba80Q0z/hZXSP6Vmk+Ifi14ujFPklw4dUg9NsetkPVdFr9uUtpLj6pyZ/Ru2PM9Dm73zaK5jWu+NbB9cSwpzzJY+RbdhCZvgAOdd1yofQ1b0hpbqNcXEsfOXwJINby56pDSOJyli5jEwyiQNRReh6aFf/EgHhlAPNNBUqdQU3EfG1rqthEI3oTw+zxhdsITdNbhWdt9LDtPE+F4w05ZkR/dQiRZNogB5pwyiblvwQE5KhmTCQgEoobA9TAaqhBJ08l53KqCtdsdDbvLB7xa2/vnJRmV3Famtyau+V0j3OxDXHZzDaZ60bjuD/WPL0U3y+YoMEgjKP9JLiJtZ4fOx2HaaINcpQG2xZsH8iEMAQsCHxUuyuefzUtUD5fe8K0IsX2nZV2X8Ribd2lG9/VRZYhXoYmQanM9yIQaNb3/WaMBJRy4LmomOfW4sk0UPovw/pPIGJSFkuhDbxhxFXVXeVLFTu/hQzazuh6qpLpXQAx/PJ+l9Rk7hgtl0a2ovA3Y/3cMI1+X9vgidLCaTZUh0BETOybQhn7pXBojvVWxp3X3uzaWNJkgmA+o0SKSx39T3wgsSblmoZxrpSrmxj238SqOJYgddyNFDHOMH3tsPwFsNdiXNTSMb6d4G9RUDHW8CfBrfRfnTu466wTXbtO1lyjQueg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(4326008)(8676002)(8936002)(44832011)(5660300002)(70586007)(2906002)(86362001)(70206006)(316002)(54906003)(36756003)(36860700001)(47076005)(356005)(6916009)(81166007)(7696005)(82740400003)(478600001)(83380400001)(6666004)(1076003)(26005)(2616005)(426003)(336012)(41300700001)(16526019)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 22:28:19.4231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b04ca63-d8e9-4de0-3c48-08dc1df4eec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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
Cc: Jay Cornwall <jay.cornwall@amd.com>, Christian
 Koenig <christian.koenig@amd.com>,
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
 4 files changed, 30 insertions(+), 23 deletions(-)

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
index 666698a57192..f23b6153d310 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -135,11 +135,19 @@ struct amdgpu_mem_stats;
 #define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < AMDGPU_MMHUB1_START)
 #define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
 
-/* Reserve 2MB at top/bottom of address space for kernel use */
+/* Reserve space at top/bottom of address space for kernel use */
 #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_CSA_START(top)	((top) \
+						 - AMDGPU_VA_RESERVED_CSA_SIZE)
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
+#define AMDGPU_VA_RESERVED_SEQ64_START(top)	(AMDGPU_VA_RESERVED_CSA_START(top) \
+						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_START(top)	(AMDGPU_VA_RESERVED_SEQ64_START(top) \
+						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(2ULL << 20)
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

