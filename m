Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96896D2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F8110E55E;
	Tue, 20 Jan 2026 07:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FS6s3p5v";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8C710E55E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLFi366Ucx2P9ZECdavsY0JYrut7jaOA1RTRoBLPq3DpCthcjTKSkRXBtCxqrIL5YVOhUmHN3HlaXT8vt9vGErDesekhRjeEjuye2fA/t1RUDzCWQuLg6bP/PRNayZ7BBWiM2p61qmvaRBlQ/eJ+Vc38WpaoNgdYhLn/a5dkUBrq3MNnKqa9LFHCBJIUSc+jMhf+admq1Wn5hg/J4JSayt85kps5Ep9FquMNRV2TMMdAZA2LdHAYm9YyiKExHFu6mWsluitH2QCEPGDLX/M5GoS0nJ0GD7PlJK2FGKv3Gp70t51inXdvBU/XmebnMtsgUNYhhSIENNyW1rQ4HZKs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEvI/8zwNST7MADWUjvTFN6u+rNbzsqTjFUxaXxfLY8=;
 b=y0HY7FmydtAj5RXtwzpwUiG3Nnb4/57O03BfIm1h/ye5TrqykxtFEcZ+PEaMNPViLOaebRUNb7fE/DITju7vImOrS8/PCIzK7HoIJJZwnvgoxahGhVDj/PkGa3OInpUwWmzCNb8h2h7vXYQRcnUMavD3J0aN5agfBPwpDLHtiB1IrnUTeJVLwyG7nrcKq7oP1oDiGCSRFlI5qkXsAsG0Cz0jRWovVqHASLUnRjQTstsNaA/R4CwqSjhz9jfNa/d6WvwFbzepm/FmsUXg2jBmI35s6nhGqQ+cL8ImI8XwEvi0d/L4EXSx+akJ6WeO22WKw4qplvV1uvsQMRtMedN0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEvI/8zwNST7MADWUjvTFN6u+rNbzsqTjFUxaXxfLY8=;
 b=FS6s3p5vYmK997KpwvfC/WtLQUvBhM0KnMCgoiHEd1zr9R+Ru+hokVswgxkoIfmruJtViLhyqn/diDhKWSSC7leBBEfm0L6UE0UDLO2Ln2WJ+QoLjC5NsnNae7SlpcPFnqI7BhWhEd497yMt4ZyTWKhCerFfYoRE4OUL7oxFcPE=
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:01 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ec) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 07:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 04/15] drm/amdgpu: Add didt method to register block
Date: Tue, 20 Jan 2026 12:27:38 +0530
Message-ID: <20260120065931.1300054-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c2df8d-3f5b-4643-794f-08de57f18752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qyXmnnDv+jhCs6I51PDcFguF4FLVWQ2GMWGg2JTEM5K1EWVYjcMdx4Ub6jyW?=
 =?us-ascii?Q?Dpp3KHvYhgdSlqOkQVqN1kGhyLBszqVrsvj9zcuDDYLGiNBM4Rn2N72JBTQs?=
 =?us-ascii?Q?vzYSerGYUnONhHTqjUBYKA8EkZTMDD/kD++aR0lgvmIi2wkGi1EqO5T8Bk2v?=
 =?us-ascii?Q?ll1FNlDN39rTe49eHiErLHx2XVlvSO2ajilb/SdldSQLvy2V9w9aR9nSEabF?=
 =?us-ascii?Q?99KPPCCiAJqipsby2fukB7/uvl8ta6Geb/uTCVXORwqqI6l34Pu0HEY+TJQe?=
 =?us-ascii?Q?sEkpjn7xNibHSkOKYe5J7NTfkdD9BXo92KHjMovJUdnvWIrUSx3dlDnidlmd?=
 =?us-ascii?Q?T9VFvlaGsze3PWVyDOqI4LYewzyTDUsk7/ZSXIz+kqteYjQzJ+dUX2mkJj7j?=
 =?us-ascii?Q?mJeFf2F4c5y6LrouxuaCHmYJYlUk64hsrQkS50yxozRuo0q3iPx2Qe+oqsJs?=
 =?us-ascii?Q?RcHpOF0FJea5JIB3ZoOkJyxRdN2DKXV02dPKMrRIErLJz5AUdYISc+GcBM7o?=
 =?us-ascii?Q?v/hE3oP0F/1U96xL26w6t8l39KDxX6wUGpjq6E/e9y1E9iZbW8eE6fuYSza7?=
 =?us-ascii?Q?HvdSNIUXWZpEk8+bsIpaxH/hPG2MLK0euDm1DbaBQxmd5Npwhi0H6Zi7Zpk7?=
 =?us-ascii?Q?d39mEOt/3ESyWU/QL/liazOME08dFh5a/EpVNYC8KffT9qUZB01qvcacBng5?=
 =?us-ascii?Q?zsuPJrkPV8V+psekhPT//Dk8rrUbQFwja07qh90kK+5opiXOYP1uPuPUoQ6V?=
 =?us-ascii?Q?P1Qt9fQnwfcB6ywrT+dr0Rt0zhSscHiEGIiPM8A9h4Y7r/L8Le/lwCNoF3VZ?=
 =?us-ascii?Q?Iwulufhg2frZUbpO5zV5ROlIFiNskveuHLhnkYgs8xZSuYvjyZRQjamJEHFg?=
 =?us-ascii?Q?NnNDeLibzV+PWZHtb7RBn9w2eHwkyWbd7YZMzlvVTgc6U5audQz5nRuUF8Rp?=
 =?us-ascii?Q?v9HtpYKuceBVydxx4vn5qjhLslcEQCeHTmKuXGhiE6nFAKfAanf2QSCZvjhf?=
 =?us-ascii?Q?AbdkrWEohVshzGZNlTgqcUdp07VdLOnf4VaUgjCqbj4NbwjBF6b+qDKlTSXE?=
 =?us-ascii?Q?SBVw5MkiKx45wKDw1VSIDZrjQd4Glq0qpBtBy4MC5p4i9BA5kuHcwwvJnafO?=
 =?us-ascii?Q?sH4g1XDze3ia6fm+OIts+a4rDB1kHdGAu2ER8jTViXxq28oRS5DyRTgyxiYU?=
 =?us-ascii?Q?84OsYiZISQjDAfnYgu+RYDrFQuTIoxzsWkaw7VmPvIDJyfB/oJfBjiwGHdpu?=
 =?us-ascii?Q?oCVExEWfqfx9YBOgrlYPD+8PBD9MHJDlpwCMyNvPTdqG6K4Pq1Sgwx5oQSl1?=
 =?us-ascii?Q?NwkJkXj+n8hjBiBGqZ09hcc40y27jv0uptfMFh8KgDwtzjASY6Hd8iD+u/YX?=
 =?us-ascii?Q?WqDCLk3cdZrsFgT4DCB9ADUTQt5v8VkF/ReoJ0qiIn122ZrNdrjYT0eP+d+r?=
 =?us-ascii?Q?1NY2X9xuV7ev5iEdikWmLkYvpQc5p43r/Q2N8qvrExagXka6pc9kTs9QRHh8?=
 =?us-ascii?Q?DNWb4sVUvU2nFeGan2rJZew8VK/oK8rJMTMWdWYkTKRCh9xyZvcU4vuVXxq+?=
 =?us-ascii?Q?hDpFg4p/CcG4zm871fpfN9tV9/t1uJ3KP/fez2dqwL8SNHFQxS8rVfCJYd1c?=
 =?us-ascii?Q?uVRhcppoqECLK8chmjEPyDyUeT1AOBDkaUhb20JouyjM7VHbqTTvpe1yY9zE?=
 =?us-ascii?Q?Oc+New=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:00.0915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c2df8d-3f5b-4643-794f-08de57f18752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
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

Move didt callbacks to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 ---
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 22 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/cik.c              | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c               | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/si.c               |  2 --
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/vi.c               | 12 +++++-----
 13 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b2b250308cb1..f312057494e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -906,10 +906,6 @@ struct amdgpu_device {
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
 	amdgpu_wreg64_ext_t pcie_wreg64_ext;
-	/* protects concurrent DIDT register access */
-	spinlock_t didt_idx_lock;
-	amdgpu_rreg_t			didt_rreg;
-	amdgpu_wreg_t			didt_wreg;
 	/* protects concurrent gc_cac register access */
 	spinlock_t gc_cac_idx_lock;
 	amdgpu_rreg_t			gc_cac_rreg;
@@ -1322,8 +1318,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_SMC(reg, v) amdgpu_reg_smc_wr32(adev, (reg), (v))
 #define RREG32_UVD_CTX(reg) amdgpu_reg_uvd_ctx_rd32(adev, (reg))
 #define WREG32_UVD_CTX(reg, v) amdgpu_reg_uvd_ctx_wr32(adev, (reg), (v))
-#define RREG32_DIDT(reg) adev->didt_rreg(adev, (reg))
-#define WREG32_DIDT(reg, v) adev->didt_wreg(adev, (reg), (v))
+#define RREG32_DIDT(reg) amdgpu_reg_didt_rd32(adev, (reg))
+#define WREG32_DIDT(reg, v) amdgpu_reg_didt_wr32(adev, (reg), (v))
 #define RREG32_GC_CAC(reg) adev->gc_cac_rreg(adev, (reg))
 #define WREG32_GC_CAC(reg, v) adev->gc_cac_wreg(adev, (reg), (v))
 #define RREG32_SE_CAC(reg) adev->se_cac_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 75154c0a26a7..c628d9f85518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -645,7 +645,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-	if (!adev->didt_rreg)
+	if (!adev->reg.didt.rreg)
 		return -EOPNOTSUPP;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -704,7 +704,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-	if (!adev->didt_wreg)
+	if (!adev->reg.didt.wreg)
 		return -EOPNOTSUPP;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 649c79acbbd9..40d7f3b7cb2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3861,8 +3861,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
-	adev->didt_rreg = &amdgpu_invalid_rreg;
-	adev->didt_wreg = &amdgpu_invalid_wreg;
 	adev->gc_cac_rreg = &amdgpu_invalid_rreg;
 	adev->gc_cac_wreg = &amdgpu_invalid_wreg;
 	adev->audio_endpt_rreg = &amdgpu_block_invalid_rreg;
@@ -3912,7 +3910,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->mmio_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
-	spin_lock_init(&adev->didt_idx_lock);
 	spin_lock_init(&adev->gc_cac_idx_lock);
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 1f5d6be9a0fd..c31c86bbf18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -42,6 +42,10 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.uvd_ctx.lock);
 	adev->reg.uvd_ctx.rreg = NULL;
 	adev->reg.uvd_ctx.wreg = NULL;
+
+	spin_lock_init(&adev->reg.didt.lock);
+	adev->reg.didt.rreg = NULL;
+	adev->reg.didt.wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -83,6 +87,24 @@ void amdgpu_reg_uvd_ctx_wr32(struct amdgpu_device *adev, uint32_t reg,
 	adev->reg.uvd_ctx.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_didt_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.didt.rreg) {
+		dev_err_once(adev->dev, "DIDT register read not supported\n");
+		return 0;
+	}
+	return adev->reg.didt.rreg(adev, reg);
+}
+
+void amdgpu_reg_didt_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+{
+	if (!adev->reg.didt.wreg) {
+		dev_err_once(adev->dev, "DIDT register write not supported\n");
+		return;
+	}
+	adev->reg.didt.wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 0d66a13c8d5c..239dbd6ef2f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -41,6 +41,7 @@ struct amdgpu_reg_ind {
 struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
 	struct amdgpu_reg_ind uvd_ctx;
+	struct amdgpu_reg_ind didt;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -48,6 +49,8 @@ uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_uvd_ctx_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_uvd_ctx_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_didt_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_didt_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 342a496b6020..90c9a2e1cf5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -223,10 +223,10 @@ static u32 cik_didt_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(mmDIDT_IND_INDEX, (reg));
 	r = RREG32(mmDIDT_IND_DATA);
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 	return r;
 }
 
@@ -234,10 +234,10 @@ static void cik_didt_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(mmDIDT_IND_INDEX, (reg));
 	WREG32(mmDIDT_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 }
 
 static const u32 bonaire_golden_spm_registers[] =
@@ -1990,8 +1990,8 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &cik_pcie_wreg;
 	adev->reg.uvd_ctx.rreg = &cik_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &cik_uvd_ctx_wreg;
-	adev->didt_rreg = &cik_didt_rreg;
-	adev->didt_wreg = &cik_didt_wreg;
+	adev->reg.didt.rreg = &cik_didt_rreg;
+	adev->reg.didt.wreg = &cik_didt_wreg;
 
 	adev->asic_funcs = &cik_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d0bc2dcd3066..dd8a85679f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -283,10 +283,10 @@ static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
 	address = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 	return r;
 }
 
@@ -297,10 +297,10 @@ static void nv_didt_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	address = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	WREG32(data, (v));
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 }
 
 static u32 nv_get_config_memsize(struct amdgpu_device *adev)
@@ -642,8 +642,8 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
-	adev->didt_rreg = &nv_didt_rreg;
-	adev->didt_wreg = &nv_didt_wreg;
+	adev->reg.didt.rreg = &nv_didt_rreg;
+	adev->reg.didt.wreg = &nv_didt_wreg;
 
 	adev->asic_funcs = &nv_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index bbf352ce8a64..bf9ad3ce4c65 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2045,8 +2045,6 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_wreg = &si_pciep_wreg;
 	adev->reg.uvd_ctx.rreg = &si_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &si_uvd_ctx_wreg;
-	adev->didt_rreg = NULL;
-	adev->didt_wreg = NULL;
 
 	adev->asic_funcs = &si_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 72b5cab002d8..b69e50b4a66a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -273,10 +273,10 @@ static u32 soc15_didt_rreg(struct amdgpu_device *adev, u32 reg)
 	address = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 	return r;
 }
 
@@ -287,10 +287,10 @@ static void soc15_didt_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	address = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, mmDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	WREG32(data, (v));
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 }
 
 static u32 soc15_gc_cac_rreg(struct amdgpu_device *adev, u32 reg)
@@ -971,8 +971,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 	adev->reg.uvd_ctx.rreg = &soc15_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &soc15_uvd_ctx_wreg;
-	adev->didt_rreg = &soc15_didt_rreg;
-	adev->didt_wreg = &soc15_didt_wreg;
+	adev->reg.didt.rreg = &soc15_didt_rreg;
+	adev->reg.didt.wreg = &soc15_didt_wreg;
 	adev->gc_cac_rreg = &soc15_gc_cac_rreg;
 	adev->gc_cac_wreg = &soc15_gc_cac_wreg;
 	adev->se_cac_rreg = &soc15_se_cac_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ddf4c422905c..4048c8dfdd4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -229,10 +229,10 @@ static u32 soc21_didt_rreg(struct amdgpu_device *adev, u32 reg)
 	address = SOC15_REG_OFFSET(GC, 0, regDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, regDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 	return r;
 }
 
@@ -243,10 +243,10 @@ static void soc21_didt_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	address = SOC15_REG_OFFSET(GC, 0, regDIDT_IND_INDEX);
 	data = SOC15_REG_OFFSET(GC, 0, regDIDT_IND_DATA);
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(address, (reg));
 	WREG32(data, (v));
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 }
 
 static u32 soc21_get_config_memsize(struct amdgpu_device *adev)
@@ -589,8 +589,8 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
-	adev->didt_rreg = &soc21_didt_rreg;
-	adev->didt_wreg = &soc21_didt_wreg;
+	adev->reg.didt.rreg = &soc21_didt_rreg;
+	adev->reg.didt.wreg = &soc21_didt_wreg;
 
 	adev->asic_funcs = &soc21_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d4f3df165090..11e0264617d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -368,8 +368,6 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
-	adev->didt_rreg = NULL;
-	adev->didt_wreg = NULL;
 
 	adev->asic_funcs = &soc24_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 6439b09656bf..0be52dba6a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -260,8 +260,6 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
-	adev->didt_rreg = NULL;
-	adev->didt_wreg = NULL;
 
 	adev->asic_funcs = &soc_v1_0_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 7d3b331d9217..9a0856a601c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -394,10 +394,10 @@ static u32 vi_didt_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(mmDIDT_IND_INDEX, (reg));
 	r = RREG32(mmDIDT_IND_DATA);
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 	return r;
 }
 
@@ -405,10 +405,10 @@ static void vi_didt_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->didt_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.didt.lock, flags);
 	WREG32(mmDIDT_IND_INDEX, (reg));
 	WREG32(mmDIDT_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->didt_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.didt.lock, flags);
 }
 
 static u32 vi_gc_cac_rreg(struct amdgpu_device *adev, u32 reg)
@@ -1464,8 +1464,8 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &vi_pcie_wreg;
 	adev->reg.uvd_ctx.rreg = &vi_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &vi_uvd_ctx_wreg;
-	adev->didt_rreg = &vi_didt_rreg;
-	adev->didt_wreg = &vi_didt_wreg;
+	adev->reg.didt.rreg = &vi_didt_rreg;
+	adev->reg.didt.wreg = &vi_didt_wreg;
 	adev->gc_cac_rreg = &vi_gc_cac_rreg;
 	adev->gc_cac_wreg = &vi_gc_cac_wreg;
 
-- 
2.49.0

