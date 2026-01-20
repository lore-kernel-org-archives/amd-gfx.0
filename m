Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A246D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1626F10E572;
	Tue, 20 Jan 2026 07:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIz8Jvon";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB5010E56E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLoHfCgbiPGu3c+EDpEwftMX1Lz5ldA4sNA5X/JYNorSkapmSxoXjUcCVbSpSRxHpODvJfG/mrpwemXc1bkMXaOZ5vWiB0tljneCP2JSt/wZpM3TzLogSFXxC4PzSa7L/YlmodWKjszZjUNCsnpD1YvZEXT5QU5G7DYwjU6xATI/CmEC+4DysUIHOcZjXbs0fPDoQsNSP/jNi5Gsj5IX4ejfgrLUz+o3pKERCeOXsMM/3Z2niyWXAr5OA4hRTYO8CmDNMrJ0yjdPFqR+9g1embCG/njlTXP37IhzOQknHkqPfmfpxYy9IBPovOo+NsFuQfS+s3p0w+jQTMBi/MvBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xPFCXiCCMzTOgs3vEA/6zNymWzueEa1KXB/4Mvcngg=;
 b=GBVr/P51pDwdsZetk0y6rHGWAM7JGt30Mlf0gTQUtiKmBPEww0RRiMghVElC0/mZ/AyY8fGR0R6YJI8dGr9Bdj7oQ/BFY1qAqp0tTlycEzWyMoJHX6lUXUpZ3z3uGlg5iLRUPqWYxUrspsW2zt6uxaaaUFIDk1nWwh3rhjkpcqZeZL2Q8c17Z3OnrD48Ro2gErchoAQI+B68lQsL2cNU7OPG6AfZv+Xk4Y7ucO4B0+zFa23RCKaA3rEBhkjWvRMkpLhZcbvwiZy+dX6dLs7QZY4Ex3DlLAMbIjW1AuGaab2NV+vadqKkR88dAB6vvOWC5Ksf0Qf+q/IOajMIKabFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xPFCXiCCMzTOgs3vEA/6zNymWzueEa1KXB/4Mvcngg=;
 b=OIz8Jvonu/yYnwWjKjxJAs6iTLKp6FAhtGlmNaGqZc5cdgobyvJyfeWxzIbrjCwdd6hK6Yj6Vyyy/izmUiKh/TCH4BB6wBmPU5ptTUQdUNMTKdBvE9qKTuGS/U8dfokHLhfhJVBkbXUv5xqRwExpPH75alDT5btg7mWC+t6ByNo=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::28) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 14/15] drm/amdgpu: Add smn callbacks to register block
Date: Tue, 20 Jan 2026 12:27:48 +0530
Message-ID: <20260120065931.1300054-15-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e2e77d-29c2-47b3-8032-08de57f19250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D9AjBvQMnTYMvcsvhd01Qwy4waEdRCITCOYryFC9QcBcTsmnES6eQ7pbey30?=
 =?us-ascii?Q?Lu7pjtlvJmuLT6VM4IahkJr4IrehnezcWgCYkByn8bN+Dojvgx4Mdrdbzcwh?=
 =?us-ascii?Q?goKNIKEdlk/Ps3pwYchPPgnXBfbX2sgm72UcvR+B5cSqMeS/kKwZv68CgMUd?=
 =?us-ascii?Q?08wl4yPBeNpynVL39h7MFnPzofPR8CZPbTOPYR39qe+NDFdntW5+TnxmBZfx?=
 =?us-ascii?Q?/SvN/9qqOkqQ28C7lAvHGbIbqK0YugJy4U2sn3626TbAoAyAc8SbQljaxtyc?=
 =?us-ascii?Q?RSTykaZvD9vKnmgxGodrnbPLRQN+nrVgwBj+ukCnfV0q6/b7yjV6buu1gQXB?=
 =?us-ascii?Q?WI2avQx/ljPRu6gJV0De+WrmqaW8MKpaX3nYjwApMuq1wlWEheHEV9RGWmyG?=
 =?us-ascii?Q?bbA2TM0Xn8jeSCTjZmX4ACRCzsNE1qE3rRQINmnzfjdwzs0uBd/3rmTaeVfw?=
 =?us-ascii?Q?1sB0q+v0FlfqHpLY/e6FiDVVDGxkxWPpHcmEJ+Np7Wx+YJRbF5oBWfjiOkIr?=
 =?us-ascii?Q?tJAGC3CPbXQzGJ72aN/NqQSMa4OZBR2Ov+dtAGzNgYCo/Mssv1J3sAx72LhL?=
 =?us-ascii?Q?xTuSP8fyW/XfjmbGOtdYYHfh/A/jRBafkbO94P6+IpGR+rdlIo922EWpJESk?=
 =?us-ascii?Q?Lid2uNmG7hqYamhjQ38+9ZJb+Bf0pzqvlLwH1dSwkETC7lbuV7DUSLG/HsNk?=
 =?us-ascii?Q?OdlXYl+C6AXGfYCd5Uvj0yViTrQFDOL90ojnBf7yW9bmOSp73KKf7o/iy0nh?=
 =?us-ascii?Q?X8IocDCpWiSL/wVd/FaEUtC65+G+SaVDomGiB6iWtUMFkCoBaLGVVDRn+QYX?=
 =?us-ascii?Q?n5oBMUQbUrVIop/kE2gckRQuKo+XlT2ym0iZc5m9ciAa78ueY0o1l1GXIbtk?=
 =?us-ascii?Q?G1Qk4oZO7syx4c4oBKhPHjwtEMvE+6TV//oWxm2zHBK67b7rbLyeEGvPavHN?=
 =?us-ascii?Q?rXJYU3KiLLxrLqiEKgVHYLqam2F2UaFG2OOOMlVgrFxOsPYqIPqVxjRgsLpH?=
 =?us-ascii?Q?Grz/GFBOj+pfh1qQGuRDsXuGH8AWiSqw2UPYY1bS6lNONJJfGk3t+8h2uLqA?=
 =?us-ascii?Q?72FDUG+A9D9emh8cA4V/ydkyYlNSwgQtV51ayFr+vRzkxoX4uJeWxOo6nZ0B?=
 =?us-ascii?Q?8PJqCglrdsrlW1C4lNwf0BF1e4ckutSH4ZNX1wY7OuZiVcoJqbracXb5z6TH?=
 =?us-ascii?Q?cLWPwZi+XRMMBv4nBhx49Y0DoxOIKlnxc21vEL8pKdxtooahlcqQ9rcRLbm9?=
 =?us-ascii?Q?1JZ+Se6cxIVLM1po62W2QLqGXx0lBweF9vHvDgBRd4lNETeFb86CwMvJFsFD?=
 =?us-ascii?Q?i7zvr2K+oALvIyQ9VpsgtmKniQbH9ks5fB14oYE2jbzAhOdf8FTKdlhbkIbO?=
 =?us-ascii?Q?w4djgESnZV6ZriVwOOM/mMcoqG4R7mv0AKHFUCYr8jp3YUjjVtxNyHGdgWFo?=
 =?us-ascii?Q?K4m6PFbpeMEVg3wyyZEZtq0SgYGA8PNiWBdVuplG9iP/sqiBbE5S2IqRa4kP?=
 =?us-ascii?Q?IsjswDqGnG5395g74N4OJafhn4d0aSv/YgEWGzqAPDVUpV8joHldZ1zklHp/?=
 =?us-ascii?Q?NMWXv01lwbEfmF5W4F4pvY8uNnUz6cO2Wy6xL/AbGeLTHAt2WfHd2n3m0XR2?=
 =?us-ascii?Q?KAudAXqI2ruWVys/DOVjMSaqUml0BzAO2jJnXoVxYG39ZTECalt0lVm7HvEH?=
 =?us-ascii?Q?wl4VAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:18.5795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e2e77d-29c2-47b3-8032-08de57f19250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
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

Add smn block to register access and callback interface definition to
get smn base.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index a996ab1254a1..4f58e9e81670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -283,6 +283,17 @@ void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	adev->reg.pcie.port_wreg(adev, reg, v);
 }
 
+uint64_t amdgpu_reg_get_smn_base64(struct amdgpu_device *adev,
+				   enum amd_hw_ip_block_type block,
+				   int die_inst)
+{
+	if (!adev->reg.smn.get_smn_base) {
+		dev_err_once(adev->dev, "SMN base address callback not set\n");
+		return 0;
+	}
+	return adev->reg.smn.get_smn_base(adev, block, die_inst);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index dc0e81cef3b9..b3b941cc7b7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -27,6 +27,8 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
+#include "amdgpu_ip.h"
+
 struct amdgpu_device;
 
 typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
@@ -42,6 +44,9 @@ typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
 					uint32_t);
 typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t,
 				    uint32_t);
+typedef uint64_t (*amdgpu_reg_get_smn_base64_t)(struct amdgpu_device *adev,
+					 enum amd_hw_ip_block_type block,
+					 int die_inst);
 
 struct amdgpu_reg_ind {
 	spinlock_t lock;
@@ -69,6 +74,10 @@ struct amdgpu_reg_pcie_ind {
 	amdgpu_wreg_t port_wreg;
 };
 
+struct amdgpu_reg_smn_ext {
+	amdgpu_reg_get_smn_base64_t get_smn_base;
+};
+
 struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
 	struct amdgpu_reg_ind uvd_ctx;
@@ -77,6 +86,7 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_ind se_cac;
 	struct amdgpu_reg_ind_blk audio_endpt;
 	struct amdgpu_reg_pcie_ind pcie;
+	struct amdgpu_reg_smn_ext smn;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -109,6 +119,9 @@ void amdgpu_reg_pcie_ext_wr64(struct amdgpu_device *adev, uint64_t reg,
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 			   uint32_t v);
+uint64_t amdgpu_reg_get_smn_base64(struct amdgpu_device *adev,
+				   enum amd_hw_ip_block_type block,
+				   int die_inst);
 
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t acc_flags);
-- 
2.49.0

