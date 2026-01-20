Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01797D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F66410E55A;
	Tue, 20 Jan 2026 07:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DVOUD3s";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D60610E55A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtwLLzInyBydHtdDw4zVIcuqYReyGpMdVWtEmmXyz3Qybu9HxvZPQ49AInY7oPTgiM4EkaVPjhtvTk3JCYYNFLd6nmWAGlYEC9z88XJx7w+MNS5ksnkcfuMMJ7L9JmLb3KQYjccs0y95f7iI4NJvftXADb0exklqfd54qrlIz648XFNl3TthabIxId9Vm80oHfJuzhba+FgN101HSxEBzS/d5SrGENAslk0X3vnhYyKcMPdcy/eOO8+2FS+r5shfbzOZl07cLuk0Aa+rK/1YYUEadu/ChAXvjxhEBECg39XyknB2lYvL5LlreGh6idc6fljZMjgRXmkZORdvSTS9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2CMAURcSewYleGiZdkAtsRD5onJ4Q+xjiZEBSixEVk=;
 b=S2HueR75EcwrTmitWjuN8dUqoxljXMzmBMB45/NUyc+mRESlGwnyWhlFl7ntFgfE8fA7h/VPDAOi4DhC3TTvMi2ZRsQJKXPSG7M6yv1WjFNIZpSOKDT1Co2WaEmVZscauXR/2v+PgPIXT7Jck+Z5MyvKJtVuhv13ttIMNAJpaLVhbSXAHWbcEif9cno+uer3GN08doULcNGjrzB5V5CMmJOKk6FT50lCqH+qXwMauBSTvAH7FcAR0o18XjgB0CACLIWXncwH01qADqQJtY8Pae5rTbGV0iAn5NqXENxtv6wDYw2tCzKVJTxMRsCkzrggYqW8/hQhNH2ZubITpTS2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2CMAURcSewYleGiZdkAtsRD5onJ4Q+xjiZEBSixEVk=;
 b=5DVOUD3sKVTcu1gCgNh+G0GWQLcFxZDqevbZCfYLwRNJRC0d/1YQSHADqcxSzezOOBlq1UkpzyL8E8e8TFbV9tUFF9Er01aOemooo8ZbonVqQezdxKwmafqzdEEwIiKCmpyLhfavm/6vBH+PvGvSfYv18dSm1GKdd7KcQ1fFbHs=
Received: from SJ0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:a03:33e::29)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:15 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::bb) by SJ0PR03CA0054.outlook.office365.com
 (2603:10b6:a03:33e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 10/15] drm/amdgpu: Add pcie ext access to register block
Date: Tue, 20 Jan 2026 12:27:44 +0530
Message-ID: <20260120065931.1300054-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a02f28-750f-46ef-6011-08de57f18fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vV5ZX7AwMV1KCZstyw7OnAzFmuYBbfxsOor8m44eAChkB0uDCrqVUwl833+S?=
 =?us-ascii?Q?shM1QE8IG2tQbjgCqST95Y7nAORGIUCx/1VL21gqhLRR01kXs9WDEawOoFwH?=
 =?us-ascii?Q?Rc3jaisS6scj+XP2XL4yv7wAdbC8BDTqqgMdWYjZUAg8eNTTbqI6nnhJb5mk?=
 =?us-ascii?Q?Y07wPmAHNvjebsD9dayMRir9tM2JJzzdgTPOKPmZoe96+QWDBGN0Yq9L4K1N?=
 =?us-ascii?Q?SO8CMpj7DNXmW1/959w1B+oRTDa9rfeKRdzGthZfYuYyEWfQOa8qyJYmo4Wu?=
 =?us-ascii?Q?BX6wocyTxrspnqS9eRQrb28wJNaVhLROLVuHnzrmhcbyCESLRefViz5b2WR/?=
 =?us-ascii?Q?2s16ZTopyX/4YKwFvFrPWP4VXyEuKjDukwQArMJrOLuXuIIFsHmuJzgn2x3s?=
 =?us-ascii?Q?I8NMSlc0Nb/G0mRcIdgrC1yGOCo7woJhOAy5Mwu6pExylsRfOa8dwygon4ym?=
 =?us-ascii?Q?j2j4hnN4Khr1oE1OKebpbLZbn1g7iIt47TEohB5Jr/m62Fn2CGyTKGyDUgxi?=
 =?us-ascii?Q?dut1EKojuvKeaXuT8lwhC6HHZt/5e1A8Istfiwo6KY4U7zgvciUSiMFegDXj?=
 =?us-ascii?Q?dyYmMTcewWKfzSqugvMlOTefIBOmQDQXRFXZASjlGEMR0hVyEekDJRZHBQI1?=
 =?us-ascii?Q?qwIy0ktKMy8MhTKMvEgSeMW7/Pewwxvxrci1zCMo00Nmtg14vTXTDmWgoRAG?=
 =?us-ascii?Q?bazF7areO5jfMaLGmVy+CeGD0+SvGg1+wCUBVao1aIMFGlX8RMCQ98YX0TJb?=
 =?us-ascii?Q?EcLm7RPxPPPgoQva50gxIQzDa3jJtZafiLk+4Z9Kw+ZpGTXZXRePQEaXUj60?=
 =?us-ascii?Q?yoixe2sKGkpep/Z6nKnX2iCQqi8vJSG4K9f5f0HqAcCqj14vgJU8qlORkC/W?=
 =?us-ascii?Q?EqtmaXy4OuSZumcszg4n6PCj35XvUkQjG2LCwqohxsRKs/ytlYBNdmjRnpj5?=
 =?us-ascii?Q?qZ72Sl6Fd4bNm0wgBzHFvrrz6wj0B1e0ykTs/ozAPmb1ZOY4a58Rb/gkfStV?=
 =?us-ascii?Q?vfuFd73qUIt+j5EmyKKyVMQq5MYbj5sPmRueWzq+CE/xNtAs40iPpKZJrxJI?=
 =?us-ascii?Q?AOOOcH0M8BnWUEvx3eAJRtW1BVU/Mh2vr76coTQOekOR1VBldSKhB4Pft/RW?=
 =?us-ascii?Q?n+hY+Hxxm08y/fpfzLN20EanRdQMIV1W508qff5hi9UPC0NRUlyNgbm4gsOa?=
 =?us-ascii?Q?hkVILPAdo40Ij/9ldTz9HZNJwPFGRDR9L7H95ND5sIAgSs8LbyYKLLIL6eUX?=
 =?us-ascii?Q?OclDAymVLiEj3K4vWsEqK0zil4wvdNELiG4dQ8HbPwJfYhxJYLu13HOo1lWa?=
 =?us-ascii?Q?teqmpEPaOZLiywpRP7PV6VQCDD3oeg5aI7LXjLrOgrlIJwYQN7nRAt8+POmF?=
 =?us-ascii?Q?iuVxJUw0wtpDexcu3kcTOXcQPKxU5UlqbCTr1rezZcZ0RuIjWiS9eH3uiLey?=
 =?us-ascii?Q?BeeZ8TdoIxQHRmnMF3grQQ6nlHjt2J/KfQDprAcTO22QS1pE2LKQAjuXt7Ob?=
 =?us-ascii?Q?jiJ8Utz200xpmeq0dkwa19R4jT6TfMILM78+ILKg3jpUEiOi/KH5ATE8UOEc?=
 =?us-ascii?Q?5reYugGvTj2XseXAJHISdeIeJFMmBMDdR0uDXNlN+JUzaJd1KSjKcW+zLoPt?=
 =?us-ascii?Q?Vip7GwntedXUbcpzT+EBPe+Ojf5mjRSWgXBnL16BXPdP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:14.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a02f28-750f-46ef-6011-08de57f18fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758
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

Move pcie extended access (64-bit address) to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 17 ---------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 21 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    | 10 ++++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  4 ++--
 6 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5c54042d6fdb..e3197383f41c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -896,8 +896,6 @@ struct amdgpu_device {
 	struct amdgpu_reg_access reg;
 	/* protects concurrent PCIE register access */
 	spinlock_t pcie_idx_lock;
-	amdgpu_rreg_ext_t		pcie_rreg_ext;
-	amdgpu_wreg_ext_t		pcie_wreg_ext;
 	amdgpu_rreg64_t			pcie_rreg64;
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
@@ -1292,8 +1290,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_PCIE(reg, v) amdgpu_reg_pcie_wr32(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) amdgpu_reg_pciep_rd32(adev, (reg))
 #define WREG32_PCIE_PORT(reg, v) amdgpu_reg_pciep_wr32(adev, (reg), (v))
-#define RREG32_PCIE_EXT(reg) adev->pcie_rreg_ext(adev, (reg))
-#define WREG32_PCIE_EXT(reg, v) adev->pcie_wreg_ext(adev, (reg), (v))
+#define RREG32_PCIE_EXT(reg) amdgpu_reg_pcie_ext_rd32(adev, (reg))
+#define WREG32_PCIE_EXT(reg, v) amdgpu_reg_pcie_ext_wr32(adev, (reg), (v))
 #define RREG64_PCIE(reg) adev->pcie_rreg64(adev, (reg))
 #define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (reg), (v))
 #define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 862cda9aacac..69f2f9b664ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -858,21 +858,6 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg)
-{
-	dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", reg);
-	BUG();
-	return 0;
-}
-
-static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t reg, uint32_t v)
-{
-	dev_err(adev->dev,
-		"Invalid callback to write register 0x%llX with 0x%08X\n", reg,
-		v);
-	BUG();
-}
-
 /**
  * amdgpu_invalid_rreg64 - dummy 64 bit reg read function
  *
@@ -3774,8 +3759,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_reg_access_init(adev);
 
-	adev->pcie_rreg_ext = &amdgpu_invalid_rreg_ext;
-	adev->pcie_wreg_ext = &amdgpu_invalid_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 11ba235ee143..395f02834404 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -61,6 +61,8 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 
 	adev->reg.pcie.rreg = NULL;
 	adev->reg.pcie.wreg = NULL;
+	adev->reg.pcie.rreg_ext = NULL;
+	adev->reg.pcie.wreg_ext = NULL;
 	adev->reg.pcie.port_rreg = NULL;
 	adev->reg.pcie.port_wreg = NULL;
 }
@@ -202,6 +204,25 @@ void amdgpu_reg_pcie_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	adev->reg.pcie.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_pcie_ext_rd32(struct amdgpu_device *adev, uint64_t reg)
+{
+	if (!adev->reg.pcie.rreg_ext) {
+		dev_err_once(adev->dev, "PCIE EXT register read not supported\n");
+		return 0;
+	}
+	return adev->reg.pcie.rreg_ext(adev, reg);
+}
+
+void amdgpu_reg_pcie_ext_wr32(struct amdgpu_device *adev, uint64_t reg,
+			      uint32_t v)
+{
+	if (!adev->reg.pcie.wreg_ext) {
+		dev_err_once(adev->dev, "PCIE EXT register write not supported\n");
+		return;
+	}
+	adev->reg.pcie.wreg_ext(adev, reg, v);
+}
+
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg)
 {
 	if (!adev->reg.pcie.port_rreg) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 8a83eb36945b..4423b872b46e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -31,6 +31,8 @@ struct amdgpu_device;
 
 typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t);
+typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
+typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
 
 typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
 					uint32_t);
@@ -52,6 +54,8 @@ struct amdgpu_reg_ind_blk {
 struct amdgpu_reg_pcie_ind {
 	amdgpu_rreg_t rreg;
 	amdgpu_wreg_t wreg;
+	amdgpu_rreg_ext_t rreg_ext;
+	amdgpu_wreg_ext_t wreg_ext;
 	amdgpu_rreg_t port_rreg;
 	amdgpu_wreg_t port_wreg;
 };
@@ -85,13 +89,13 @@ void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
 				 uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_pcie_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pcie_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_pcie_ext_rd32(struct amdgpu_device *adev, uint64_t reg);
+void amdgpu_reg_pcie_ext_wr32(struct amdgpu_device *adev, uint64_t reg,
+			      uint32_t v);
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 			   uint32_t v);
 
-typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
-typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
-
 typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 33955b625bbb..c05ab38371c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -963,8 +963,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->nbio.funcs->set_reg_remap(adev);
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
-	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
-	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
+	adev->reg.pcie.rreg_ext = &amdgpu_device_indirect_rreg_ext;
+	adev->reg.pcie.wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d0bc844a5ba6..c55a402f3dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -252,8 +252,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
-	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
-	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
+	adev->reg.pcie.rreg_ext = &amdgpu_device_indirect_rreg_ext;
+	adev->reg.pcie.wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
-- 
2.49.0

