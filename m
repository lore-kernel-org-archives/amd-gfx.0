Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97968CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 04:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086F410E73E;
	Sat,  3 Oct 2026 04:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rzUKiMbb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012029.outbound.protection.outlook.com
 [40.107.200.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B45E10E73D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 04:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tux3dRjNdTFxz7+yn6zkYkGtt5T3loAKym3AiLVAXQ5HfZaMo/BjxQLFD5XkE0nAmXb8jgiNG+SSoK4NAzPvUtIB7l7aHLY6r1jIhFhIwdrlHGKQM9LRVglGqNWH0iCQnSvPkhX7SfFb4TYLvUwkj0s7aEMCmUpcoMjJDpruzNLRrWCSRbqXoZlv1AwrxPsYtoxFWRNICWZwZCZmajrJ0WcCcjYS8z7lbJltUszLGZHm6T86HDY7F8QaEdoZsQkOIe81/mLZ0PksD+j7JxkoL9LYfXxM0QPy4a5mcNWzDOzuKGsGhMdo6e7zKzZeBG67d/8xaWiLI3Pvg5ZObg0rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zszWN9jcEUj6tJ6Aj1zgMXcQmE/UTLUe9iq0hbOLg3A=;
 b=vLR5KQ4IwwJxc1silFMdsD1kio6bKUm2WFcXfEpE6r3A6JH5m/LkKJiIpP8U2y1AZenY3e+PsDBFIce/wJesjEBxc2gXG0XJAm53VJNB0FWki1CZea+PNnuYgy8c3uErcJxKj4xczjdHomuG1KDKWxFfUm8gRu3oj1qXRQBGHtFyAz/7CzKIeWRp6dCtFLR9jdctSJtxLGrli6E04u3O+rEDDxUctyQDS3KT61PpXLj/iUanB4L3DPZjJtJjsibKx9guBZvoakChUtQuE+ESXCip8gyOdmUUsTCdwM++HrbOs8ZnlDfcT2vmAO/PztXtcABy7xOeqGfRHpd6gNhs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zszWN9jcEUj6tJ6Aj1zgMXcQmE/UTLUe9iq0hbOLg3A=;
 b=rzUKiMbbH7h4sC2PA6s4B/4FyktnNf0RQaP1vEx3Q/THxw3FnfX283KYPDIMpdN0osFZixb+26q3fTxF2P25197K7IkbnLbDrlvJ29Aj24K4oEA1j6zaghzzWbbAIkIuS+wqDHg02oABJXu/YAR8Wj4XOhSlo1Cqq+XD+Jf3UHk=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sat, 3 Oct
 2026 04:40:27 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::5) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Sat, 3
 Oct 2026 04:40:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sat, 3 Oct 2026 04:40:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 23:40:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>,
 "James Zhu" <james.zhu@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: Program trap TBA/TMA for kernel-managed
 VMIDs
Date: Sat, 3 Oct 2026 10:09:52 +0530
Message-ID: <20261003043953.936202-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
References: <20261003043953.936202-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c51ff1-e466-4019-d178-08df210871b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vAPUSB9ZN50T2ew5P07N6HRMG4mKPIEwSyBvyRudHq+i55y2fxZ3SgQ2aIR92CWFMfT49SMUUWvkAafAcRbxJGpvXAH14BNFxfe0OPJBJXmbAO6zf2euQaTjShJHo5uX23OJD+sYCBNNhiankTxKs9UsqoXZJvUHCl00suoeKf8nkz+qEN5Pb+WvEKXXazMq7kz/yc1SBTtej9VF40R+2wLAW18wAKiXKBoWKEJAzjrt0xwtL5jFqxS0CQ/pPiwBGFymvd1RNRCwqIsp/g4sroJ56sujFA3rW81KstNG0wm6k2FjXfqiLXi5N7aDD7ikGdqZVplWI51R8dtDsytzG1mkKQkf0lNcynxDZYbDUdrwb3gdeuyuDrKUaNuROzW1LaWt85IdPk92IhMuNU1r89yh088ALzX1fcD0hloQK1O1D9f8kKlzwbtyDQwU+s6Lh7uV7KWEG1Y2YhDFu1+muOjMKIcPZ2Z/bQskYRQj1kocP/vaECCZGx6hNY/HGC6K0bvxv0h9c9GFpOxrx17WAIqZHuU6zUK2qfL+I07rdISWLiiuHweVTu3NPbgqNNqNtvqg/uOG8L/2Xq0mMpGHT6bPjUPo+6ScVqx42RZflrisZz+LUm3VZ5xKuxT7iLT2w7gO/gkED1tGypuWxxwuvxXto8kZ6baLrF13wOfyRVkZ1iirq81O9TxQISfm8zJpLK24Sf2rdErLyYFAb2LfKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IcVxNJc69CI2q03UhSMOIjyr/kR12+Dr9ftOvnTi/an0LmA4OOyA5/f0S/z6daFm5a37BpXS3cg12ly0jKs1ilJ1+LwyWkWnv96LgxkzgJjrMTjZYr0l2k0mdzMMtLzUOwE9QmqaHDj365tvzGZO09ADxixwpSHs/0X+MsRPT4iON934RRzBQXPII4n2r84HK8swU18/iBAMr5LNWCZXH7xfkCZOCBaa1GFuACNI7kHXMPz/Tg6KmpDyMCN4xNCVEeT0egqvIHfl0XJQAOM1sgEM5k6Bquh3Xt2llh4OG6p45IBz20i6aeefwK4HOS0ZfPblZPkev3rspqkgDW8mzhCbQrcIeUD5hGDLDyYnq9HHy4DNGs5LGQXXNL7u9GlSWqgay7rChIsHNeO68hVGr7BTLfkesy1d95+/+cdDjrNTiLPvIarHEJOxnbP4wjHv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 04:40:26.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c51ff1-e466-4019-d178-08df210871b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
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

User queues get their first-level TBA and TMA from MES/KIQ when the
queue is created. Kernel-managed VMIDs do not use this path, so program
their trap registers from the gfxhub setup path.

Get the TBA and TMA addresses from the first-level trap mapping and
program them for each kernel-managed VMID.

The trap registers use the SRBM selector, so keep the programming under
srbm_mutex and restore the VMID selector after the registers are
updated.

Mask the TBA and TMA address fields before writing the registers. Keep
TRAP_EN disabled on the affected GFX11 ASICs to preserve the existing
trap workaround.

On multi-XCC hardware, program the requested XCCs and restore the VMID
selector on each XCC afterwards.

Keep the first-level trap VA layout inside amdgpu_trap. The gfxhub code
only needs the final TBA and TMA addresses.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
Changes in v3:
- Keep the separate reserved first-level trap VA range.
- Add kernel VMID trap programming for gfxhub_v3_0_3.
- Mask the TBA and TMA address fields before programming the registers.
- Keep TRAP_EN clear on affected GFX11 ASICs.
- Improve multi-XCC handling and restore the VMID selector on each XCC.

 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 53 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 38 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 46 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 46 ++++++++++++++++++
 8 files changed, 269 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 02d29e884206..6f0dbf1c6098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -63,6 +63,13 @@ static inline uint64_t amdgpu_trap_tba_vaddr(struct amdgpu_device *adev)
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
index c78c60e3d18d..c43e2c6338e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -76,6 +76,9 @@ struct amdgpu_trap_usr_addr {
 int amdgpu_trap_init(struct amdgpu_device *adev);
 void amdgpu_trap_fini(struct amdgpu_device *adev);
 
+void amdgpu_trap_get_l1_addr(struct amdgpu_device *adev,
+			     u64 *tba_addr, u64 *tma_addr);
+
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..6b5ca31074c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v11_5_0.h"
 
 #include "gc/gc_11_5_0_offset.h"
@@ -290,6 +291,40 @@ static void gfxhub_v11_5_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v11_5_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
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
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -337,6 +372,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v11_5_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..8f3dda85e870 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v12_0.h"
 
 #include "gc/gc_12_0_0_offset.h"
@@ -295,6 +296,40 @@ static void gfxhub_v12_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v12_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
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
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -342,6 +377,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c2fd1e6616e..d1c97f9ab554 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -21,6 +21,7 @@
  *
  */
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "amdgpu_xcp.h"
 #include "gfxhub_v12_1.h"
 
@@ -406,6 +407,55 @@ static void gfxhub_v12_1_xcc_disable_identity_aperture(struct amdgpu_device *ade
 	}
 }
 
+static void
+gfxhub_v12_1_program_kernel_trap_tba_tma(struct amdgpu_device *adev,
+					 uint32_t xcc_mask)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
+	int xcc;
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
+	for_each_inst(xcc, xcc_mask) {
+		for (vmid = 1;
+		     vmid < adev->vm_manager.first_kfd_vmid;
+		     vmid++) {
+			amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0,
+						    vmid, xcc);
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_LO,
+				     lower_32_bits(tba_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TBA_HI,
+				     (upper_32_bits(tba_addr >> 8) &
+				      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+				     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_LO,
+				     lower_32_bits(tma_addr >> 8));
+			WREG32_SOC15(GC, GET_INST(GC, xcc),
+				     regSQ_SHADER_TMA_HI,
+				     upper_32_bits(tma_addr >> 8) &
+				     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+		}
+	}
+
+	/* Reset the VMID selector on every XCC instance. */
+	for_each_inst(xcc, xcc_mask)
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, xcc);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 					       uint32_t xcc_mask)
 {
@@ -468,6 +518,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *adev,
 
 		hub->vm_cntx_cntl = tmp;
 	}
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v12_1_program_kernel_trap_tba_tma(adev, xcc_mask);
 }
 
 static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..5fd1abda896b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v2_0.h"
 
 #include "gc/gc_10_1_0_offset.h"
@@ -280,6 +281,40 @@ static void gfxhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v2_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	unsigned int vmid;
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
+			     (upper_32_bits(tba_addr >> 8) &
+			      SQ_SHADER_TBA_HI__ADDR_HI_MASK) |
+			     (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -327,6 +362,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v2_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..29d712843dd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -22,6 +22,7 @@
  */
 
 #include "amdgpu.h"
+#include "amdgpu_trap.h"
 #include "gfxhub_v3_0.h"
 
 #include "gc/gc_11_0_0_offset.h"
@@ -287,6 +288,48 @@ static void gfxhub_v3_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
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
+	tba_hi = upper_32_bits(tba_addr >> 8) &
+		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
+
+	if (!amdgpu_trap_has_dbg_wa(adev))
+		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -334,6 +377,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index b3b1085c7cd3..1db1421ae51c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "gfxhub_v3_0_3.h"
+#include "amdgpu_trap.h"
 
 #include "gc/gc_11_0_3_offset.h"
 #include "gc/gc_11_0_3_sh_mask.h"
@@ -292,6 +293,48 @@ static void gfxhub_v3_0_3_disable_identity_aperture(struct amdgpu_device *adev)
 
 }
 
+static void
+gfxhub_v3_0_3_program_kernel_trap_tba_tma(struct amdgpu_device *adev)
+{
+	u64 tba_addr, tma_addr;
+	u32 tba_hi;
+	unsigned int vmid;
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
+	tba_hi = upper_32_bits(tba_addr >> 8) &
+		 SQ_SHADER_TBA_HI__ADDR_HI_MASK;
+
+	if (!amdgpu_trap_has_dbg_wa(adev))
+		tba_hi |= 1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT;
+
+	mutex_lock(&adev->srbm_mutex);
+
+	for (vmid = 1; vmid < adev->vm_manager.first_kfd_vmid; vmid++) {
+		amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, vmid, 0);
+
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
+			     lower_32_bits(tba_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI, tba_hi);
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
+			     lower_32_bits(tma_addr >> 8));
+		WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
+			     upper_32_bits(tma_addr >> 8) &
+			     SQ_SHADER_TMA_HI__ADDR_HI_MASK);
+	}
+
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -339,6 +382,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 	}
 
 	hub->vm_cntx_cntl = tmp;
+
+	if (amdgpu_trap_is_enabled(adev))
+		gfxhub_v3_0_3_program_kernel_trap_tba_tma(adev);
 }
 
 static void gfxhub_v3_0_3_program_invalidation(struct amdgpu_device *adev)
-- 
2.34.1

