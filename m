Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4438C7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 16:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3260F10E0BA;
	Mon, 12 Jun 2023 16:23:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290B510E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 16:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRwb55AIgXAspg2cEAbFtrsnFG49R/JjlXS9Zw0OWfVW6aBCl2Iy52y2IYCGPM6MZ7389EMk12BVYJs5f0JBVHse3jvoek0ChFh0kpMpbI9S25/K8C9zed9WufNBxUYUz3JEWRjot3GNlGS6Dal2AsKnz2se96bgOLQP44pMMdc1qfWLu+Y/aIPitSOtUn352Is3bak8kfbpi40BFYUImtkTBFZemfTEKvDOojBnGkH5cevW/MVpyXIe+NyIxQ42XYjric4R4L3o0zcs01M+TwbK4bg0mBw/v9RnAzbGZ+prhSFRiY/PCUxIL2VMA7ecZsgtPS7J7R91184f7L8Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTm/+oKwkLNw7rg0yu9q19J2OpJTiQEA1EV8o5mXZOs=;
 b=A9ByJ6SgTo/3A7yGDZIfYMaOO/s3USkqyX3ntcjsVS96TotJcDK2FtG3i67VqBlpY3250K1RwEtPLdKZs0fxetBt4Eg/puTg4kicIwaL75m3tMhSUvjWsbFLNDReDXoQFxH2VvpulcvD86qTHe5Koj8J5tE0shyEedzZL9OSddSyvQ/Uk0xRNKmEFxzvtZRfUKPx24vu0cyWGL9xQc+F2EUxQ8FcFFJyLubPuM1VvSBsJIHlMer1wMVByERT4maE5oAiq2sYFrlLio4uMrbosB2L1JSp+r3yfvoVlivV12GIU5iiD0GEO3gFnzUD5aFUB2AGBzVig1RuEwytWN0lVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTm/+oKwkLNw7rg0yu9q19J2OpJTiQEA1EV8o5mXZOs=;
 b=E8R87VJuNVEj/3XF+QtnOaEV2MQbLKlsOJ+OVIeBHy84l6fdJxl3ow1aMfoKisyeTRXmTxjfHV8oCN+l8/OtPBB5TIYpY37PSXU1+Kmi3cRanODdasxnlDvSSBBuC+3fl3mM9MSfzCPYiPouVSmm5VFhj5dLpq+eDQuP1GYYGN0=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 16:23:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b5) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 16:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 16:23:49 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 11:23:47 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdgpu: Update invalid PTE flag setting
Date: Mon, 12 Jun 2023 12:23:30 -0400
Message-ID: <20230612162330.668641-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: aa40539c-acd8-4bd7-6486-08db6b616786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vICFq4iyYM2wy8hwPb42CUXAYOlvWroue+ASSx+7Xr1r+qOPZpjxztuRmCPtt1Ty4fwyS7Klhrx6tNkbPLuS7+OJH8SUrRAQ9g0iFU+eF8iwMLf7+tEhGreH6guVq5n7N0xKcntzCudTnTxM2zjuYHQYLgYuKNoZ0vCsAHI3vOX2jyFU2otWC5xsblmMO2viF7DWJtEzeALFdyDxWe+A/f0MKWRIlHaWk0ASJkOzOxsKh96/+t5ppYlkP7N+bKqR5wjVSa0QeS9/VHiFYGR047jhQgVyXEDkmtvHJOFWtoPg0Z+fm5IhlTxsZluhaapENqxTSFh8ghiF40BUCC8+xAgNsGO2igzQ7ylClklHcQKA/T0dcm2hu5G3WRg/CzCGCuvKmhF9GHal/8Fkd3iu0OR2utA9FM+IBorXDTtyYph+rNgxslASBmTluB6selZbHWBJig64gqbgq/br4UZUUlC/EbM4Hbldpy8JixKoi7AhcujLeUSZ/PTGf0bCAhATC4m9sJv59Icbb3yWoHj2x5YS7a/0pk3EW5m2pxEyCuFOIPT5mgVkxRP5m7xjiUm8SQHrmr9FRCrQxU22HIGhCsRR/oOphK4/YFCDEIvy67wtOIgGRrOx/UUCZDnFEVjDGn7OJP/np5655/GHrhVJhJrAJ11s+b0U0bnCgrQQizHa22FY+RXcjaHARzms3ZqnQy+NOpGrTB9IMBNaqCYCDgzK33h0wFUYMIwXUMHUXr+pqUScxgxA3I64FS4FHBJR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(336012)(82740400003)(426003)(44832011)(40480700001)(478600001)(8676002)(8936002)(4326008)(86362001)(70206006)(70586007)(81166007)(356005)(6916009)(5660300002)(40460700003)(41300700001)(316002)(36756003)(7696005)(6666004)(15650500001)(82310400005)(36860700001)(54906003)(2906002)(16526019)(26005)(186003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:23:49.4511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa40539c-acd8-4bd7-6486-08db6b616786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the invalid PTE flag setting with TF enabled.
This is to ensure, in addition to transitioning the
retry fault to a no-retry fault, it also causes the
wavefront to enter the trap handler. With the current
setting, the fault only transitions to a no-retry fault.
Additionally, have 2 sets of invalid PTE settings, one for
TF enabled, the other for TF disabled. The setting with
TF disabled, doesn't work with TF enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update handling according to Christian's feedback.

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 11 +++++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 6794edd1d2d2..e5c6b075fbbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -152,6 +152,10 @@ struct amdgpu_gmc_funcs {
 	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
 				      struct amdgpu_vm *vm,
 				      uint64_t addr, uint64_t *flags);
+	/* update no-retry flags */
+	void (*update_vm_pte_noretry_flags)(struct amdgpu_device *dev,
+					uint64_t *flags);
+
 	/* get the amount of memory used by the vbios for pre-OS console */
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 
@@ -343,6 +347,9 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
 	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
 		((adev), (vm), (addr), (pte_flags))
+#define amdgpu_gmc_update_vm_pte_noretry_flags(adev, pte_flags)		\
+	((adev)->gmc.gmc_funcs->update_vm_pte_noretry_flags		\
+		((adev), (pte_flags)))
 #define amdgpu_gmc_get_vbios_fb_size(adev) (adev)->gmc.gmc_funcs->get_vbios_fb_size((adev))
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1cb14ea18cd9..ff9db7e5c086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2583,7 +2583,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
+		flags = AMDGPU_VM_NORETRY_FLAGS;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9c85d494f2a2..b81fcb962d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -84,7 +84,13 @@ struct amdgpu_mem_stats;
 /* PDE Block Fragment Size for VEGA10 */
 #define AMDGPU_PDE_BFS(a)	((uint64_t)a << 59)
 
+/* Flag combination to set no-retry with TF disabled */
+#define AMDGPU_VM_NORETRY_FLAGS	(AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE | \
+				AMDGPU_PTE_TF)
 
+/* Flag combination to set no-retry with TF enabled */
+#define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | \
+				   AMDGPU_PTE_PRT)
 /* For GFX9 */
 #define AMDGPU_PTE_MTYPE_VG10(a)	((uint64_t)(a) << 57)
 #define AMDGPU_PTE_MTYPE_VG10_MASK	AMDGPU_PTE_MTYPE_VG10(3ULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea1a64be44d..39f1650f6d00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -804,6 +804,9 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}
 
+	if (adev->gmc.translate_further && level == AMDGPU_VM_PTB)
+		amdgpu_gmc_update_vm_pte_noretry_flags(adev, &flags);
+
 	/* APUs mapping system memory may need different MTYPEs on different
 	 * NUMA nodes. Only do this for contiguous ranges that can be assumed
 	 * to be on the same NUMA node.
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3ed286b72cae..aea8e80c3419 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1307,6 +1307,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 					     mapping, flags);
 }
 
+static void gmc_v9_0_update_vm_pte_noretry_flags(struct amdgpu_device *adev,
+					   uint64_t *flags)
+{
+	/* Update no retry flags when TF is enabled */
+	if ((*flags & AMDGPU_VM_NORETRY_FLAGS) == AMDGPU_VM_NORETRY_FLAGS) {
+		*flags &= ~AMDGPU_VM_NORETRY_FLAGS;
+		*flags |= AMDGPU_VM_NORETRY_FLAGS_TF;
+	}
+}
+
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 					   struct amdgpu_vm *vm,
 					   uint64_t addr, uint64_t *flags)
@@ -1445,6 +1455,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
+	.update_vm_pte_noretry_flags = gmc_v9_0_update_vm_pte_noretry_flags,
 	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
 	.query_mem_partition_mode = &gmc_v9_0_query_memory_partition,
 };
-- 
2.35.1

