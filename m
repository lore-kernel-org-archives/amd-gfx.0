Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10AFD2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA1510E555;
	Tue, 20 Jan 2026 07:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="214AWGoO";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC8A10E555
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRo/D1+80BfTOtuMXHYGBFGv1IfgW6t/xYlM7/D7WQugUvwxKD1lFowA6SoiXVwlhgwO8411mw/00MT2yRi7HuRhN0MekHXNB9QufJAeNaHegsVoPP/jYMhkFFArK/ytyauQtPOjCF+XrQzGrU/fgR3+eJImOrPnymrTFFqDmWilPZ4ruk1JT2sJyY4G/KM8Vv3Hq+ykxmOhuTgMDhSoXAvAD5FVmsYvQGNgz74UvHhpwvsJofEkbvFlNM5rvLeC3VJ3LeSRTh+0mtiFfZgG76Au/lZy9gOJK695hqji5pV5RxEsgKCbSXHrt31dkX825Ser1VHWXJP9LHHZdKVg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zvTWJU6YlyRXGPM7D4Sc0pimgW63MqtZ3OzoRfo0BE=;
 b=mk+D/MGlnbvOlVroh37goTHQceTSNO0MYAhkK3jnRcLRPcCUEOMvF5EkkSYMcgwWsNouwUrVxCnvDQ/vBUnDxvORDreu3C5IYvo/t/16F04ltGyVPw7PvpBcxLBJpWC1do8fNbPA3rpHirISTnqAAimnEd1wXb/CBL0XSh3SNskiOlptjH/tFb0DGNPUSdAUuioGbkM3uJTfGu/JFblXFi/jJb2+sNUNqTbxNZiKMutw8LFyjEGdoglrmm9u+r4lisLF6aBwgw9z1ZZlD5ILdChY5Z/GCO3AeFtK8tAq3mIvw9gTLodQH+hE6zxA0re1ClkiL3ZTswcQzx6kvyMVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zvTWJU6YlyRXGPM7D4Sc0pimgW63MqtZ3OzoRfo0BE=;
 b=214AWGoOoWSEMPCjjsrdEhwuktTuilheqS4bIGnPoZxMN3EXp8eEIK87SY1kQlRrFaXG6H7lCErvxWhI6MlKa1HGldevxOU2m5XO1B4IIp/uPjtxnCTk8we34UhIb9iE6ITF/VEO7LA2EMMRSIUrST1R1sHdpT7T6rpSJPphWj8=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:59:55 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::60) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:59:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 01/15] drm/amdgpu: Move register access functions
Date: Tue, 20 Jan 2026 12:27:35 +0530
Message-ID: <20260120065931.1300054-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f58a4e-108d-429c-ae80-08de57f1844f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eLZOFWqSlUI92eKMkGDuDbndpf3336oqYVuyazEenebOz5eisEAjfx3MkqG+?=
 =?us-ascii?Q?UXGmAWIrIHCU+ddRo8H8bCfh0toVctKdMHH8/tR6Lh7TC4nZVAnddvNYhzBr?=
 =?us-ascii?Q?wniehZYiS4Fayz6HdE9K3VHG9nz/z9TjTf7x1KyhgYvbPRbr1zrGw+ByAk5B?=
 =?us-ascii?Q?xJFpzNsRLB3DVXi0JeKTDbP/Ov9FN6gFvH6DJ80oKi541t/UsIaz360Wea6+?=
 =?us-ascii?Q?RPNarfOrbOaJGvrsd1HWA9S5sFpZ4WmLy6azMjVpAHrE/lNNZc7zRJYDvKOg?=
 =?us-ascii?Q?2QpLOgAwVZbj+80u3a3L27pEdYWODfs5sNZAkfFVfYTJUAADNlUKY8XJzDiM?=
 =?us-ascii?Q?D656XnZpTZsR8OV/u5agc3CWKh4boSVY3MtdN7mMD8Jmh9XwOaJPSwEd5cyJ?=
 =?us-ascii?Q?U906Z3zAOra/AWnmuBwh5ei9so6OPkUMbWohVzhryD2sAPXnY6YGNNjO1J2w?=
 =?us-ascii?Q?yoYWFbdC177nKNABr7LWPGud7LXEYsdiQ5eKjqX58OgAgh2BS2g+kw0T0yOv?=
 =?us-ascii?Q?5ra9mbqYkhdJVzB/KoeZDBpdu1/MWTetXJ8SJr10xCT9Anol/q5V/n+yUU6I?=
 =?us-ascii?Q?uiS8xVnXliVfwu4Q/DW72jD5o3jRKXwXZuKlSF9gpMoVW/m4ARLyQCH68IKl?=
 =?us-ascii?Q?kILDEB5jh6qO5B7jzoH+ym9togKt4nWP4EUd67kXLMqF5zBEjnHjSpxXPjgW?=
 =?us-ascii?Q?MgFER/PnhuEZo+FCSV5cJp48Jjsie4vWEzuv6MEA2cRMX4TbXxlH11lM/6j8?=
 =?us-ascii?Q?lAWKVt3anPKq5hp04ufBf408oI6FlQDQP5YJe8BwOlPddFj4sR6qGBJh1Thq?=
 =?us-ascii?Q?ZovE1qdG2OixhlKgkcr70ZxZ3ohj5Yc6U+IaaJN5QscCdj8dQfdyqOovYtZE?=
 =?us-ascii?Q?4TRVHYB/pjkZy3azZmFg0CVYhjyZohgqvyEWDwhK1LxTNOyn617eMQAqL0XP?=
 =?us-ascii?Q?1tlPSCCyQqq3gF4gyxYwLkcQIzKKFWlRtFimgQdgKuNhuOGJG3PNqJM/x87K?=
 =?us-ascii?Q?KZebjeBfUzHgaRq8HpYwJ5jI8TPadfl+s0nrALkPQIu+nJeP6EoNPYQNHywd?=
 =?us-ascii?Q?6ULv/2IDqbV1XoSvKWO6rYoVM0h/GvpuN0reFw1jRAdBn9PivuLTjsxJm6oz?=
 =?us-ascii?Q?p5EifJZKU6RfTXUA1Z8HNgO/E1IAtm62xuhC1CY60uKRSYb+BEqE4iSwmyGL?=
 =?us-ascii?Q?K5/dxVNRfJiZ+V1qH2nXhkBUImNP0ew+ayGKTRqDdm26vEwp81IBsiS9FCtu?=
 =?us-ascii?Q?Qy6VccR+QUImMZsSJry21/cfGQYANkqzAPmOTN+CCQ0uFj+u8qG+uuDLQwy9?=
 =?us-ascii?Q?avl4ZFQ7RJqIqony/rXJRqDIvvFxldxOw2L9NaXIjbTh0mzcJOs3gsTW/6fG?=
 =?us-ascii?Q?hXo9f+lCro4d/L9xDoI7fmhG2TAMhISDC7Owd0qJyu3oJHIqMnnnzNoqBNCn?=
 =?us-ascii?Q?bI9h+d/MZ0lJHNI6/+6cKuLcsr2ZYXY/TTakdIxcKc/yNxQg52KVy4cWW9k5?=
 =?us-ascii?Q?xmlbLJlcin9GUxkpdjKno0Cth94TLMBYEmf6f9ZiU/Bwrr3YAAJbF+l4HoX1?=
 =?us-ascii?Q?uGDFsS7xe+KqPGLf+RpADf+Tk2NRYn4d47yrFF2ZhfHL8TNCyHJJvhXpvrIZ?=
 =?us-ascii?Q?ryZwhu+NM7Ul0ByoqK4QdMW+Mj3zABHzxPo5XFzXHrJY7n2YI6nXmYhu/utO?=
 =?us-ascii?Q?ACIlog=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:59:55.0473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f58a4e-108d-429c-ae80-08de57f1844f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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

Move register access methods from amdgpu_device.c to a dedicated file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 615 -----------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 644 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  85 +++
 5 files changed, 731 insertions(+), 671 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8e22882b66aa..006d49d6b4af 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -47,7 +47,7 @@ subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
 amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
-amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
+amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c11535c44c6..d847a1a0b3c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -81,6 +81,7 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_lsdma.h"
 #include "amdgpu_nbio.h"
+#include "amdgpu_reg_access.h"
 #include "amdgpu_hdp.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_virt.h"
@@ -680,21 +681,6 @@ void amdgpu_cgs_destroy_device(struct cgs_device *cgs_device);
 /*
  * Core structure, functions and helpers.
  */
-typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device*, uint32_t);
-typedef void (*amdgpu_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t);
-
-typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device*, uint64_t);
-typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device*, uint64_t, uint32_t);
-
-typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device*, uint32_t);
-typedef void (*amdgpu_wreg64_t)(struct amdgpu_device*, uint32_t, uint64_t);
-
-typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device*, uint64_t);
-typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device*, uint64_t, uint64_t);
-
-typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device*, uint32_t, uint32_t);
-typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, uint32_t);
-
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
@@ -1289,42 +1275,6 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			       void *buf, size_t size, bool write);
-uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
-			    uint32_t inst, uint32_t reg_addr, char reg_name[],
-			    uint32_t expected_value, uint32_t mask);
-uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
-			    uint32_t reg, uint32_t acc_flags);
-u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
-				    u64 reg_addr);
-uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
-				uint32_t reg, uint32_t acc_flags,
-				uint32_t xcc_id);
-void amdgpu_device_wreg(struct amdgpu_device *adev,
-			uint32_t reg, uint32_t v,
-			uint32_t acc_flags);
-void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
-				     u64 reg_addr, u32 reg_data);
-void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
-			    uint32_t reg, uint32_t v,
-			    uint32_t acc_flags,
-			    uint32_t xcc_id);
-void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-			     uint32_t reg, uint32_t v, uint32_t xcc_id);
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
-
-u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
-				u32 reg_addr);
-u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
-				  u32 reg_addr);
-u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
-				  u64 reg_addr);
-void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
-				 u32 reg_addr, u32 reg_data);
-void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
-				   u32 reg_addr, u64 reg_data);
-void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
-				   u64 reg_addr, u64 reg_data);
 u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
 bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 				       enum amd_asic_type asic_type);
@@ -1515,10 +1465,6 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring);
 
 void amdgpu_device_halt(struct amdgpu_device *adev);
-u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
-				u32 reg);
-void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
-				u32 reg, u32 v);
 struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b34498..523e21edd036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -846,558 +846,6 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 	return false;
 }
 
-/**
- * amdgpu_device_rreg - read a memory mapped IO or indirect register
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- * @acc_flags: access flags which require special behavior
- *
- * Returns the 32 bit value from the offset specified.
- */
-uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
-			    uint32_t reg, uint32_t acc_flags)
-{
-	uint32_t ret;
-
-	if (amdgpu_device_skip_hw_access(adev))
-		return 0;
-
-	if ((reg * 4) < adev->rmmio_size) {
-		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg, 0);
-			up_read(&adev->reset_domain->sem);
-		} else {
-			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-		}
-	} else {
-		ret = adev->pcie_rreg(adev, reg * 4);
-	}
-
-	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
-
-	return ret;
-}
-
-/*
- * MMIO register read with bytes helper functions
- * @offset:bytes offset from MMIO start
- */
-
-/**
- * amdgpu_mm_rreg8 - read a memory mapped IO register
- *
- * @adev: amdgpu_device pointer
- * @offset: byte aligned register offset
- *
- * Returns the 8 bit value from the offset specified.
- */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return 0;
-
-	if (offset < adev->rmmio_size)
-		return (readb(adev->rmmio + offset));
-	BUG();
-}
-
-
-/**
- * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register with specific XCC
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- * @acc_flags: access flags which require special behavior
- * @xcc_id: xcc accelerated compute core id
- *
- * Returns the 32 bit value from the offset specified.
- */
-uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
-				uint32_t reg, uint32_t acc_flags,
-				uint32_t xcc_id)
-{
-	uint32_t ret, rlcg_flag;
-
-	if (amdgpu_device_skip_hw_access(adev))
-		return 0;
-
-	if ((reg * 4) < adev->rmmio_size) {
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    adev->gfx.rlc.rlcg_reg_access_supported &&
-		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
-							 GC_HWIP, false,
-							 &rlcg_flag)) {
-			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, GET_INST(GC, xcc_id));
-		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
-			up_read(&adev->reset_domain->sem);
-		} else {
-			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-		}
-	} else {
-		ret = adev->pcie_rreg(adev, reg * 4);
-	}
-
-	return ret;
-}
-
-/*
- * MMIO register write with bytes helper functions
- * @offset:bytes offset from MMIO start
- * @value: the value want to be written to the register
- */
-
-/**
- * amdgpu_mm_wreg8 - read a memory mapped IO register
- *
- * @adev: amdgpu_device pointer
- * @offset: byte aligned register offset
- * @value: 8 bit value to write
- *
- * Writes the value specified to the offset specified.
- */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if (offset < adev->rmmio_size)
-		writeb(value, adev->rmmio + offset);
-	else
-		BUG();
-}
-
-/**
- * amdgpu_device_wreg - write to a memory mapped IO or indirect register
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- * @v: 32 bit value to write to the register
- * @acc_flags: access flags which require special behavior
- *
- * Writes the value specified to the offset specified.
- */
-void amdgpu_device_wreg(struct amdgpu_device *adev,
-			uint32_t reg, uint32_t v,
-			uint32_t acc_flags)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if ((reg * 4) < adev->rmmio_size) {
-		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v, 0);
-			up_read(&adev->reset_domain->sem);
-		} else {
-			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-		}
-	} else {
-		adev->pcie_wreg(adev, reg * 4, v);
-	}
-
-	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
-}
-
-/**
- * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect mmio or with RLC path if in range
- *
- * @adev: amdgpu_device pointer
- * @reg: mmio/rlc register
- * @v: value to write
- * @xcc_id: xcc accelerated compute core id
- *
- * this function is invoked only for the debugfs register access
- */
-void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
-			     uint32_t reg, uint32_t v,
-			     uint32_t xcc_id)
-{
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    adev->gfx.rlc.funcs &&
-	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
-		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return amdgpu_sriov_wreg(adev, reg, v, 0, 0, xcc_id);
-	} else if ((reg * 4) >= adev->rmmio_size) {
-		adev->pcie_wreg(adev, reg * 4, v);
-	} else {
-		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-	}
-}
-
-/**
- * amdgpu_device_xcc_wreg - write to a memory mapped IO or indirect register with specific XCC
- *
- * @adev: amdgpu_device pointer
- * @reg: dword aligned register offset
- * @v: 32 bit value to write to the register
- * @acc_flags: access flags which require special behavior
- * @xcc_id: xcc accelerated compute core id
- *
- * Writes the value specified to the offset specified.
- */
-void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
-			uint32_t reg, uint32_t v,
-			uint32_t acc_flags, uint32_t xcc_id)
-{
-	uint32_t rlcg_flag;
-
-	if (amdgpu_device_skip_hw_access(adev))
-		return;
-
-	if ((reg * 4) < adev->rmmio_size) {
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    adev->gfx.rlc.rlcg_reg_access_supported &&
-		    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
-							 GC_HWIP, true,
-							 &rlcg_flag)) {
-			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, GET_INST(GC, xcc_id));
-		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-		    amdgpu_sriov_runtime(adev) &&
-		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
-			up_read(&adev->reset_domain->sem);
-		} else {
-			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-		}
-	} else {
-		adev->pcie_wreg(adev, reg * 4, v);
-	}
-}
-
-/**
- * amdgpu_device_indirect_rreg - read an indirect register
- *
- * @adev: amdgpu_device pointer
- * @reg_addr: indirect register address to read from
- *
- * Returns the value of indirect register @reg_addr
- */
-u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev,
-				u32 reg_addr)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_data_offset;
-	u32 r;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	r = readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-
-	return r;
-}
-
-u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
-				    u64 reg_addr)
-{
-	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
-	u32 r;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_index_hi_offset;
-	void __iomem *pcie_data_offset;
-
-	if (unlikely(!adev->nbio.funcs)) {
-		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
-		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
-	} else {
-		pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-		pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	}
-
-	if (reg_addr >> 32) {
-		if (unlikely(!adev->nbio.funcs))
-			pcie_index_hi = AMDGPU_PCIE_INDEX_HI_FALLBACK;
-		else
-			pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-	} else {
-		pcie_index_hi = 0;
-	}
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-	if (pcie_index_hi != 0)
-		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
-				pcie_index_hi * 4;
-
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	r = readl(pcie_data_offset);
-
-	/* clear the high bits */
-	if (pcie_index_hi != 0) {
-		writel(0, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-
-	return r;
-}
-
-/**
- * amdgpu_device_indirect_rreg64 - read a 64bits indirect register
- *
- * @adev: amdgpu_device pointer
- * @reg_addr: indirect register address to read from
- *
- * Returns the value of indirect register @reg_addr
- */
-u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
-				  u32 reg_addr)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_data_offset;
-	u64 r;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-
-	/* read low 32 bits */
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	r = readl(pcie_data_offset);
-	/* read high 32 bits */
-	writel(reg_addr + 4, pcie_index_offset);
-	readl(pcie_index_offset);
-	r |= ((u64)readl(pcie_data_offset) << 32);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-
-	return r;
-}
-
-u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev,
-				  u64 reg_addr)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	unsigned long pcie_index_hi = 0;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_index_hi_offset;
-	void __iomem *pcie_data_offset;
-	u64 r;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-	if (pcie_index_hi != 0)
-		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
-			pcie_index_hi * 4;
-
-	/* read low 32 bits */
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	r = readl(pcie_data_offset);
-	/* read high 32 bits */
-	writel(reg_addr + 4, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	r |= ((u64)readl(pcie_data_offset) << 32);
-
-	/* clear the high bits */
-	if (pcie_index_hi != 0) {
-		writel(0, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-
-	return r;
-}
-
-/**
- * amdgpu_device_indirect_wreg - write an indirect register address
- *
- * @adev: amdgpu_device pointer
- * @reg_addr: indirect register offset
- * @reg_data: indirect register data
- *
- */
-void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
-				 u32 reg_addr, u32 reg_data)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_data_offset;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	writel(reg_data, pcie_data_offset);
-	readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
-void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
-				     u64 reg_addr, u32 reg_data)
-{
-	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_index_hi_offset;
-	void __iomem *pcie_data_offset;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-	else
-		pcie_index_hi = 0;
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-	if (pcie_index_hi != 0)
-		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
-				pcie_index_hi * 4;
-
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	writel(reg_data, pcie_data_offset);
-	readl(pcie_data_offset);
-
-	/* clear the high bits */
-	if (pcie_index_hi != 0) {
-		writel(0, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
-/**
- * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
- *
- * @adev: amdgpu_device pointer
- * @reg_addr: indirect register offset
- * @reg_data: indirect register data
- *
- */
-void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
-				   u32 reg_addr, u64 reg_data)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_data_offset;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-
-	/* write low 32 bits */
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
-	readl(pcie_data_offset);
-	/* write high 32 bits */
-	writel(reg_addr + 4, pcie_index_offset);
-	readl(pcie_index_offset);
-	writel((u32)(reg_data >> 32), pcie_data_offset);
-	readl(pcie_data_offset);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
-void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
-				   u64 reg_addr, u64 reg_data)
-{
-	unsigned long flags, pcie_index, pcie_data;
-	unsigned long pcie_index_hi = 0;
-	void __iomem *pcie_index_offset;
-	void __iomem *pcie_index_hi_offset;
-	void __iomem *pcie_data_offset;
-
-	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
-	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
-	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
-		pcie_index_hi = adev->nbio.funcs->get_pcie_index_hi_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
-	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
-	if (pcie_index_hi != 0)
-		pcie_index_hi_offset = (void __iomem *)adev->rmmio +
-				pcie_index_hi * 4;
-
-	/* write low 32 bits */
-	writel(reg_addr, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
-	readl(pcie_data_offset);
-	/* write high 32 bits */
-	writel(reg_addr + 4, pcie_index_offset);
-	readl(pcie_index_offset);
-	if (pcie_index_hi != 0) {
-		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-	writel((u32)(reg_data >> 32), pcie_data_offset);
-	readl(pcie_data_offset);
-
-	/* clear the high bits */
-	if (pcie_index_hi != 0) {
-		writel(0, pcie_index_hi_offset);
-		readl(pcie_index_hi_offset);
-	}
-
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
 /**
  * amdgpu_device_get_rev_id - query device rev_id
  *
@@ -7371,39 +6819,6 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	pci_wait_for_pending_transaction(pdev);
 }
 
-u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
-				u32 reg)
-{
-	unsigned long flags, address, data;
-	u32 r;
-
-	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	WREG32(address, reg * 4);
-	(void)RREG32(address);
-	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-	return r;
-}
-
-void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
-				u32 reg, u32 v)
-{
-	unsigned long flags, address, data;
-
-	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
-	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
-
-	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
-	WREG32(address, reg * 4);
-	(void)RREG32(address);
-	WREG32(data, v);
-	(void)RREG32(data);
-	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
-}
-
 /**
  * amdgpu_device_get_gang - return a reference to the current gang
  * @adev: amdgpu_device pointer
@@ -7586,36 +7001,6 @@ bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
 	}
 }
 
-uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
-		uint32_t inst, uint32_t reg_addr, char reg_name[],
-		uint32_t expected_value, uint32_t mask)
-{
-	uint32_t ret = 0;
-	uint32_t old_ = 0;
-	uint32_t tmp_ = RREG32(reg_addr);
-	uint32_t loop = adev->usec_timeout;
-
-	while ((tmp_ & (mask)) != (expected_value)) {
-		if (old_ != tmp_) {
-			loop = adev->usec_timeout;
-			old_ = tmp_;
-		} else
-			udelay(1);
-		tmp_ = RREG32(reg_addr);
-		loop--;
-		if (!loop) {
-			dev_warn(
-				adev->dev,
-				"Register(%d) [%s] failed to reach value 0x%08x != 0x%08xn",
-				inst, reg_name, (uint32_t)expected_value,
-				(uint32_t)(tmp_ & (mask)));
-			ret = -ETIMEDOUT;
-			break;
-		}
-	}
-	return ret;
-}
-
 ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
 {
 	ssize_t size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
new file mode 100644
index 000000000000..4b8888f82b64
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/delay.h>
+
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_trace.h"
+#include "amdgpu_virt.h"
+#include "amdgpu_reg_access.h"
+
+#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
+#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
+#define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+
+/*
+ * register access helper functions.
+ */
+
+/**
+ * amdgpu_device_rreg - read a memory mapped IO or indirect register
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @acc_flags: access flags which require special behavior
+ *
+ * Returns the 32 bit value from the offset specified.
+ */
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t acc_flags)
+{
+	uint32_t ret;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			ret = amdgpu_kiq_rreg(adev, reg, 0);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		ret = adev->pcie_rreg(adev, reg * 4);
+	}
+
+	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
+
+	return ret;
+}
+
+/*
+ * MMIO register read with bytes helper functions
+ * @offset:bytes offset from MMIO start
+ */
+
+/**
+ * amdgpu_mm_rreg8 - read a memory mapped IO register
+ *
+ * @adev: amdgpu_device pointer
+ * @offset: byte aligned register offset
+ *
+ * Returns the 8 bit value from the offset specified.
+ */
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if (offset < adev->rmmio_size)
+		return (readb(adev->rmmio + offset));
+	BUG();
+}
+
+/**
+ * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register with specific XCC
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Returns the 32 bit value from the offset specified.
+ */
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev, uint32_t reg,
+				uint32_t acc_flags, uint32_t xcc_id)
+{
+	uint32_t ret, rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return 0;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(
+			    adev, acc_flags, GC_HWIP, false, &rlcg_flag)) {
+			ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag,
+						      GET_INST(GC, xcc_id));
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+			   amdgpu_sriov_runtime(adev) &&
+			   down_read_trylock(&adev->reset_domain->sem)) {
+			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		ret = adev->pcie_rreg(adev, reg * 4);
+	}
+
+	return ret;
+}
+
+/*
+ * MMIO register write with bytes helper functions
+ * @offset:bytes offset from MMIO start
+ * @value: the value want to be written to the register
+ */
+
+/**
+ * amdgpu_mm_wreg8 - read a memory mapped IO register
+ *
+ * @adev: amdgpu_device pointer
+ * @offset: byte aligned register offset
+ * @value: 8 bit value to write
+ *
+ * Writes the value specified to the offset specified.
+ */
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (offset < adev->rmmio_size)
+		writeb(value, adev->rmmio + offset);
+	else
+		BUG();
+}
+
+/**
+ * amdgpu_device_wreg - write to a memory mapped IO or indirect register
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @v: 32 bit value to write to the register
+ * @acc_flags: access flags which require special behavior
+ *
+ * Writes the value specified to the offset specified.
+ */
+void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+			uint32_t acc_flags)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_domain->sem)) {
+			amdgpu_kiq_wreg(adev, reg, v, 0);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		adev->pcie_wreg(adev, reg * 4, v);
+	}
+
+	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
+}
+
+/**
+ * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect mmio or with RLC path if in range
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: mmio/rlc register
+ * @v: value to write
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * this function is invoked only for the debugfs register access
+ */
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg,
+			     uint32_t v, uint32_t xcc_id)
+{
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (amdgpu_sriov_fullaccess(adev) && adev->gfx.rlc.funcs &&
+	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
+		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
+			return amdgpu_sriov_wreg(adev, reg, v, 0, 0, xcc_id);
+	} else if ((reg * 4) >= adev->rmmio_size) {
+		adev->pcie_wreg(adev, reg * 4, v);
+	} else {
+		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+	}
+}
+
+/**
+ * amdgpu_device_xcc_wreg - write to a memory mapped IO or indirect register with specific XCC
+ *
+ * @adev: amdgpu_device pointer
+ * @reg: dword aligned register offset
+ * @v: 32 bit value to write to the register
+ * @acc_flags: access flags which require special behavior
+ * @xcc_id: xcc accelerated compute core id
+ *
+ * Writes the value specified to the offset specified.
+ */
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v, uint32_t acc_flags, uint32_t xcc_id)
+{
+	uint32_t rlcg_flag;
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if ((reg * 4) < adev->rmmio_size) {
+		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_runtime(adev) &&
+		    adev->gfx.rlc.rlcg_reg_access_supported &&
+		    amdgpu_virt_get_rlcg_reg_access_flag(
+			    adev, acc_flags, GC_HWIP, true, &rlcg_flag)) {
+			amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
+						GET_INST(GC, xcc_id));
+		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+			   amdgpu_sriov_runtime(adev) &&
+			   down_read_trylock(&adev->reset_domain->sem)) {
+			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
+			up_read(&adev->reset_domain->sem);
+		} else {
+			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+		}
+	} else {
+		adev->pcie_wreg(adev, reg * 4, v);
+	}
+}
+
+/**
+ * amdgpu_device_indirect_rreg - read an indirect register
+ *
+ * @adev: amdgpu_device pointer
+ * @reg_addr: indirect register address to read from
+ *
+ * Returns the value of indirect register @reg_addr
+ */
+u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_data_offset;
+	u32 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	r = readl(pcie_data_offset);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
+u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
+	u32 r;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	if (unlikely(!adev->nbio.funcs)) {
+		pcie_index = AMDGPU_PCIE_INDEX_FALLBACK;
+		pcie_data = AMDGPU_PCIE_DATA_FALLBACK;
+	} else {
+		pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+		pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	}
+
+	if (reg_addr >> 32) {
+		if (unlikely(!adev->nbio.funcs))
+			pcie_index_hi = AMDGPU_PCIE_INDEX_HI_FALLBACK;
+		else
+			pcie_index_hi =
+				adev->nbio.funcs->get_pcie_index_hi_offset(
+					adev);
+	} else {
+		pcie_index_hi = 0;
+	}
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset =
+			(void __iomem *)adev->rmmio + pcie_index_hi * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r = readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
+/**
+ * amdgpu_device_indirect_rreg64 - read a 64bits indirect register
+ *
+ * @adev: amdgpu_device pointer
+ * @reg_addr: indirect register address to read from
+ *
+ * Returns the value of indirect register @reg_addr
+ */
+u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_data_offset;
+	u64 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+
+	/* read low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	r = readl(pcie_data_offset);
+	/* read high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	r |= ((u64)readl(pcie_data_offset) << 32);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	unsigned long pcie_index_hi = 0;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+	u64 r;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
+		pcie_index_hi =
+			adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset =
+			(void __iomem *)adev->rmmio + pcie_index_hi * 4;
+
+	/* read low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r = readl(pcie_data_offset);
+	/* read high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	r |= ((u64)readl(pcie_data_offset) << 32);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+	return r;
+}
+
+/**
+ * amdgpu_device_indirect_wreg - write an indirect register address
+ *
+ * @adev: amdgpu_device pointer
+ * @reg_addr: indirect register offset
+ * @reg_data: indirect register data
+ *
+ */
+void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
+				 u32 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	writel(reg_data, pcie_data_offset);
+	readl(pcie_data_offset);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
+void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
+				     u32 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_index_hi, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
+		pcie_index_hi =
+			adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+	else
+		pcie_index_hi = 0;
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset =
+			(void __iomem *)adev->rmmio + pcie_index_hi * 4;
+
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel(reg_data, pcie_data_offset);
+	readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
+/**
+ * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
+ *
+ * @adev: amdgpu_device pointer
+ * @reg_addr: indirect register offset
+ * @reg_data: indirect register data
+ *
+ */
+void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
+				   u64 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+
+	/* write low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
+	readl(pcie_data_offset);
+	/* write high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	writel((u32)(reg_data >> 32), pcie_data_offset);
+	readl(pcie_data_offset);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
+				       u64 reg_data)
+{
+	unsigned long flags, pcie_index, pcie_data;
+	unsigned long pcie_index_hi = 0;
+	void __iomem *pcie_index_offset;
+	void __iomem *pcie_index_hi_offset;
+	void __iomem *pcie_data_offset;
+
+	pcie_index = adev->nbio.funcs->get_pcie_index_offset(adev);
+	pcie_data = adev->nbio.funcs->get_pcie_data_offset(adev);
+	if ((reg_addr >> 32) && (adev->nbio.funcs->get_pcie_index_hi_offset))
+		pcie_index_hi =
+			adev->nbio.funcs->get_pcie_index_hi_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
+	pcie_data_offset = (void __iomem *)adev->rmmio + pcie_data * 4;
+	if (pcie_index_hi != 0)
+		pcie_index_hi_offset =
+			(void __iomem *)adev->rmmio + pcie_index_hi * 4;
+
+	/* write low 32 bits */
+	writel(reg_addr, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel((u32)(reg_data & 0xffffffffULL), pcie_data_offset);
+	readl(pcie_data_offset);
+	/* write high 32 bits */
+	writel(reg_addr + 4, pcie_index_offset);
+	readl(pcie_index_offset);
+	if (pcie_index_hi != 0) {
+		writel((reg_addr >> 32) & 0xff, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+	writel((u32)(reg_data >> 32), pcie_data_offset);
+	readl(pcie_data_offset);
+
+	/* clear the high bits */
+	if (pcie_index_hi != 0) {
+		writel(0, pcie_index_hi_offset);
+		readl(pcie_index_hi_offset);
+	}
+
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
+u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
+{
+	unsigned long flags, address, data;
+	u32 r;
+
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	r = RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+	return r;
+}
+
+void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
+{
+	unsigned long flags, address, data;
+
+	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
+	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
+
+	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
+	WREG32(address, reg * 4);
+	(void)RREG32(address);
+	WREG32(data, v);
+	(void)RREG32(data);
+	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+}
+
+uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
+				    uint32_t reg_addr, char reg_name[],
+				    uint32_t expected_value, uint32_t mask)
+{
+	uint32_t ret = 0;
+	uint32_t old_ = 0;
+	uint32_t tmp_ = RREG32(reg_addr);
+	uint32_t loop = adev->usec_timeout;
+
+	while ((tmp_ & (mask)) != (expected_value)) {
+		if (old_ != tmp_) {
+			loop = adev->usec_timeout;
+			old_ = tmp_;
+		} else
+			udelay(1);
+		tmp_ = RREG32(reg_addr);
+		loop--;
+		if (!loop) {
+			dev_warn(
+				adev->dev,
+				"Register(%d) [%s] failed to reach value 0x%08x != 0x%08xn",
+				inst, reg_name, (uint32_t)expected_value,
+				(uint32_t)(tmp_ & (mask)));
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
new file mode 100644
index 000000000000..e03865c0c093
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMDGPU_REG_ACCESS_H__
+#define __AMDGPU_REG_ACCESS_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+
+/*
+ * Registers read & write functions.
+ */
+typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
+typedef void (*amdgpu_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t);
+
+typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
+typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
+
+typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device *, uint32_t);
+typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
+
+typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device *, uint64_t);
+typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device *, uint64_t, uint64_t);
+
+typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
+					uint32_t);
+typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t,
+				    uint32_t);
+
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t acc_flags);
+uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev, uint32_t reg,
+				uint32_t acc_flags, uint32_t xcc_id);
+void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+			uint32_t acc_flags);
+void amdgpu_device_xcc_wreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v, uint32_t acc_flags, uint32_t xcc_id);
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg,
+			     uint32_t v, uint32_t xcc_id);
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset,
+		     uint8_t value);
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
+
+u32 amdgpu_device_indirect_rreg(struct amdgpu_device *adev, u32 reg_addr);
+u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev, u64 reg_addr);
+u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev, u32 reg_addr);
+u64 amdgpu_device_indirect_rreg64_ext(struct amdgpu_device *adev, u64 reg_addr);
+void amdgpu_device_indirect_wreg(struct amdgpu_device *adev, u32 reg_addr,
+				 u32 reg_data);
+void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev, u64 reg_addr,
+				     u32 reg_data);
+void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev, u32 reg_addr,
+				   u64 reg_data);
+void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev, u64 reg_addr,
+				       u64 reg_data);
+
+u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev, u32 reg);
+void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v);
+
+uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
+				    uint32_t reg_addr, char reg_name[],
+				    uint32_t expected_value, uint32_t mask);
+
+#endif /* __AMDGPU_REG_ACCESS_H__ */
-- 
2.49.0

