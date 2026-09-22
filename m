Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A04FC98304
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 05:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1346910E73E;
	Tue, 22 Sep 2026 05:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D1A0uHYb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE61210EB12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 05:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs6Q5ga7pO0Ho4ofE4SqtESMTl2UtsOFqVJQQo48BFL3U2jSfVD2n5/ZOMGnuTzITkJpQ7vFg1QP6acmnmy2FkBX1eQ0keSB5dLxlupIsBEyzzRu5voUwOzQLD81ArF12B3MQymVaJew02zqzXuidklGABYZUayt3hZJMVNBwKfR6tJwew8aZzctZgugmt4F8XctaKgwZkQPEtdTDHuGfiYZk+i7QoRUsb5pGSv3hFSziLbHaMNwTnevC0YWZp2cgqSGnVvp5QOTKWB6yKp0gf5NgLCiLsoCic2/8wgr+49r9Hl/GRItDItyk6MOEQrllq5ZIN+D/iqESZ4GmW2D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3R10RuO0MlN3KuK5SGK0sRjo6Xfh+LpP14JTquBkyg=;
 b=bvADsw8v2XIBDB0oKG59CuOAaXpHUSYR5xVDhZk/zb9+yBrKrCzp1gUgvazzf/APVjjjJAe9G+w2r4bnuFLLfyfEcZ/vVgoICuKww81Vu1dm5FR75SaLUOqakSoQHnq9Q7UhM/XRosLVyLfuPk9OhErAHdJItyNocNGiC5tRUQddVRLWjYaM+B3NwmuO73h06cZejbluIr1T8SJNNCZpAPzqwnbxHHDbaK3XnS29IAmykGQ6oigy4Z7gZZsK7NqgTT09Vm2HIgO9DeZ6ntO/sRwCvevHZfnC5qJwhnTArpPnbDkr/kZ1Qidxyba6E1ezcsjgOqfCIYYvc8UpIU3DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3R10RuO0MlN3KuK5SGK0sRjo6Xfh+LpP14JTquBkyg=;
 b=D1A0uHYblKl75lqqUH/FNRmS7ArAJLHxagUYCFA/KGH4KCRMSmp0jAVfEFX2DxqhWDXnyU21wZ6cMPdg67G1WcrjE8Xmm38h6UO6U+SZLZgIRgK0yMcq1aD/KsbLcuH+UNv7Y9J+DpCzBOnJLxPgjrQKK0XmhVYDgkhUJuHd+v0=
Received: from SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::30)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 05:20:08 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::32) by SA9P221CA0025.outlook.office365.com
 (2603:10b6:806:25::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Tue,
 22 Sep 2026 05:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 05:20:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 22 Sep 2026 00:20:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
Date: Tue, 22 Sep 2026 10:49:32 +0530
Message-ID: <20260922051933.772319-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
References: <20260922051933.772319-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3e9265-cf6f-4651-d96b-08df18692b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2zz2PUzOt3A83OcyIdiFRjvC2ZXANUrf0rqoPXQqpLMY2Im2sJTvhcYhRCpMxDu2isljXzQ0R8R/pkCStvrToSlc+9bWKwnKBJkYFHV3b3A3OcnH3ufXTlfEGB1aiGT06C4DU1C/8XK7NRB3ix3g8wIxZUIzfljeZwJZXK/33Un/DV1wGprQTnS0aqi5VHGBMw+8x7FN3sJUjf6RWmfN7rSKIpfa41FK81jESMR9LyHY4y0RoJHy6Xx+Vnm0b/CWaeOeES6IX64C8Hr4ziCxMbQ0T7FF8OrpbJ7T/V56eXCsZRo9oLuLkabPcB8c5q3FMRLJt/+xegV+HX/SmtvUkN05YmXyX9fbOdRuwEUEI8dCk73XP/N0ZZqSzgaj/jRT9NbFyHxGDIKpYpIjV4qJ+033f/z5S9kHTRwyG61nyHZVp7d9Vuxt9q1x8dy2k7BowYutCCz55fuTUldoeN9fVT33Xgfdpe0KjUn3bsjwHR3lL8zCnFFyV3MnBMhdhjGTXq2uOUIuaEHr60rdijqVF3ybbr0rrAo3wFJWpa2gFHaeQIQ2NyG43gfnDnyhws99WN+LuG+jIWJOnrXoCvwHWCzTt54zLMWfrepIitE67WtGeXf72XR7ybrs+GLwVYl1VQx/3U6ULFGxnIrX6BgKAUEdjD0gSlArrXzL61oErlPpyoxAcYOOxuLk5qT93ghnwYMYL6sUBzTMI8c0sRvXCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L2vwXjM9JSHBdeLBC30GOuAJmNSqpbSGO4LnD972L0QAhqGK+sKyMbIHqofNDO5zuP5hszQKZUTHIu8mpIWPbKnYpPv1Q2oNdSIuGSXZ0y0vYUzP5dWJ+qXxiiRAboEL+SAcd808CPEBD4cDa7iOWa0AmL5niGHBB2Qx4CaZu3FEqXmlneUDiokdPx3iDHNNEg39d5LKDw+8vxyYMYGdMklFxsdEZFtRbZspt5Yh/XsFwonQzLUj4Q6F+CzG0gXad86Iq93LlVHuumQaRQkwmcd6ULWypnpSj+4eiySSOADCUWW2IdsQt6VcbC2OO51isrxbD0ATalfUw7qZdYcuoL88AUazuj8bAr6ej3UdWV6em9igMyG6R54ojRwXp9GQ0WCVFTMDAbcFbJEtg+8OYGCFQDg2Uu3Sjk+RYK92FjZWjsiYEkpZDYMCxktKWKxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 05:20:08.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3e9265-cf6f-4651-d96b-08df18692b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

User-queue VMIDs receive their trap register state from MES/KIQ at queue
creation. Kernel-managed VMIDs do not; program them here.

Add program_kernel_trap_tba_tma() to each gfxhub generation and call it
from setup_vmid_config(). No vmhub callback is introduced: the operation
is generation-specific and belongs in each gfxhub's own setup path.

Both TBA and TMA addresses are GPU virtual addresses taken from the
common trap mapping established at vm_init. TRAP_EN is safe to set at
this point: any GPUVM assigned to a kernel-managed VMID already has a
valid trap mapping before it can execute work.

TBA and TMA are mapped at GPU-page-aligned virtual addresses within the
common trap VA reservation. Keep the first-level trap layout internal to
amdgpu_trap and expose only the absolute TBA/TMA addresses to the gfxhub
programming code.

The helper is named program_kernel_trap_tba_tma() because it selects
each kernel-managed VMID and writes its TBA/TMA registers; it does not
configure the VMIDs themselves.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  9 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 12 ++-----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 40 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 36 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 36 +++++++++++++++++++
 8 files changed, 198 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 05d8f48e06cb..0dd75832f351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -57,13 +57,20 @@ enum amdgpu_trap_region {
 
 static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
 {
-	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_UQ_START(adev);
+	u64 addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
 
 	addr = amdgpu_gmc_sign_extend(addr);
 
 	return addr;
 }
 
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr)
+{
+	*tba_addr = amdgpu_trap_tba_vaddr(adev);
+	*tma_addr = *tba_addr + AMDGPU_TRAP_TMA_OFFSET;
+}
+
 static inline bool amdgpu_trap_is_supported(struct amdgpu_device *adev)
 {
 	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 323c49a53dad..92ff3d2aee80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -77,6 +77,9 @@ struct amdgpu_trap_usr_addr {
 int amdgpu_trap_init(struct amdgpu_device *adev);
 void amdgpu_trap_fini(struct amdgpu_device *adev);
 
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr);
+
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bbf4aa96e15a..cc54847f11de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -177,17 +177,11 @@ struct amdgpu_trap_obj;
 #define AMDGPU_VA_RESERVED_TRAP_SIZE		(1ULL << 16)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
-/* TBD: Ideally, existing TRAP VA should do. There is a conflict with KFD mapping that needs to be
- * resolved. Revisit later.
- */
-#define AMDGPU_VA_RESERVED_TRAP_UQ_SIZE (3ULL << 12)
-#define AMDGPU_VA_RESERVED_TRAP_UQ_START(adev) \
-	(AMDGPU_VA_RESERVED_TRAP_START(adev) - AMDGPU_VA_RESERVED_TRAP_UQ_SIZE)
 
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-#define AMDGPU_VA_RESERVED_TOP                                            \
-	(AMDGPU_VA_RESERVED_TRAP_UQ_SIZE + AMDGPU_VA_RESERVED_TRAP_SIZE + \
-	 AMDGPU_VA_RESERVED_SEQ64_SIZE + AMDGPU_VA_RESERVED_CSA_SIZE)
+#define AMDGPU_VA_RESERVED_TOP \
+	(AMDGPU_VA_RESERVED_TRAP_SIZE + AMDGPU_VA_RESERVED_SEQ64_SIZE + \
+	 AMDGPU_VA_RESERVED_CSA_SIZE)
 
 /* See vm_update_mode */
 #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..b02970c4ab34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -290,6 +291,38 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -337,6 +370,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..3f402acf20bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -295,6 +296,38 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -342,6 +375,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..bb5b4ffed065 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -406,6 +407,42 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void
+gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	int xcc, vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for_each_inst(xcc, adev->gfx.xcc_mask) {
+		for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, xcc);
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TBA_HI,
+				     upper_32_bits(tba_addr >> 8) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc), regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8));
+		}
+	}
+	/* Reset the VMID selector on every XCC instance. */
+	for_each_inst(xcc, adev->gfx.xcc_mask)
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t xcc_mask)
 {
@@ -468,6 +505,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_1_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..6cca45b374a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -280,6 +281,38 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -327,6 +360,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..680b171c4c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -287,6 +288,38 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	int vmid;
+
+	if (!amdgpu_trap_is_enabled(adev) ||
+	    !adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
+		return;
+
+	amdgpu_trap_get_l1_addr(adev, &tba_addr, &tma_addr);
+
+	WARN_ON(!IS_ALIGNED(tba_addr, 256));
+	WARN_ON(!IS_ALIGNED(tma_addr, 256));
+
+	mutex_lock(&adev->srbm_mutex);
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
+			     upper_32_bits(tba_addr >> 8) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8));
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -334,6 +367,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
-- 
2.34.1

