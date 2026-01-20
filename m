Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B997AD2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595CC10E556;
	Tue, 20 Jan 2026 07:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HWhFW0h6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B0910E556
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXp+6KrbqqRSLefOLMiU+6Uv4PXI7BVsezMHB0RdIGo4vH1mgsN0gPBJuY/ZCy609FU8hFRgdCSBtKGwcYNsl03wNJ4BXxB0G16K62F3aSdqzkkla2jy8J7fhH7+D1Ur+sKXO8agbYFGTie9fDUeUMDiBlpJhw6L3qaGkuql57uGYN2OY67KvhKCbt7VQjKt/TD2Ve3TQ1pGD3QHPymzVo2WO+2GrlrttNwffHljaXbI9xVHJKM5vnMkbOcD8IpJoe/tvIS55ij5/Xt4bTf+Y0j4I8MYkWapNHVZmDrAqRizpgWtdf/nz5oP35LLH+jzpu1EUPColGxSJSKQZ6kpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0ddfuJ/2G0RYD84tFYJHLdn7FVegE1OnXK5P/uc+RQ=;
 b=ejKhm6qKg5f6JQ1qflRBViNtoXU4tUJ0VZGQGsMa1ayb1PW2Vbigte2+0vXcccAeJjUZkX58ave7bMtd58ZUpyjEZ44lLh8RwqVNNAzGeFysOu4DeacYVKwdVn7Q/P0mpjjBBBq/Yae92uH1KfTenoFCO7xgaFgvGHIh+DIBYivF6E0vgfI7O8D3jgVWsZu5eB9BCjgLCjQpBPtBKh/QVRuatEBWa7wYHCdGs/DLCYK5UC9MIHqtw8du6+cP2j9GAXQayDTy69ZF1WfP6LnF6xOa+s+R80fWjsCPjbpqwl4pOUg58Kw79HdYQ/PPqoKgLqxGnTlZ2qLkvEI7+liaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0ddfuJ/2G0RYD84tFYJHLdn7FVegE1OnXK5P/uc+RQ=;
 b=HWhFW0h6lDdz3Hbk1CaiO02GLv/n95Bx4uIKy762fGvkqTiUkS0QsYd7HQ3MXloYimsnWQA4j6184D+kRAyOwIkIoAZ9QjpnYWRCNzNdYH8nDMh212iA5fuYnBm9Yn7DChOQZB+/Eyc6RCCFHwEcPCbHxKkKCKgltixUYf1/+sY=
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:59:57 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::33) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
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
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:59:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 02/15] drm/amdgpu: Add smc method to register block
Date: Tue, 20 Jan 2026 12:27:36 +0530
Message-ID: <20260120065931.1300054-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ace7159-39e0-4c56-4e76-08de57f185d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4sJW8xL2z6uSqDrx0E5Zsohrj82MxFAqfmLzw/buD9qFYapBmumchDLnEEP5?=
 =?us-ascii?Q?z3W/g6InHs+HtWxuEvDao5GDeWnugUnE24HctgPG7AnuL+3VTltGpm6+rGA1?=
 =?us-ascii?Q?wLRPPZyHYE0JTphMr3NBya7+WGuBquTo4bjA8hrUcc2Yo+5/Ry+iuFs1bqwy?=
 =?us-ascii?Q?4c5xsQ4CJB+W7TXQqSwXti6TTzEA6ZT3ufcWJhFMiHRkL5oqVQVw/bAH29Zc?=
 =?us-ascii?Q?cFOS2lrWTv4KHONrTxRvu9pOEEO5tSyZgBisPb/S22WkeXGqRM5yPzTz5sg6?=
 =?us-ascii?Q?9XQZxzi0KOwq1Zf4s4zEYVQXrEncSLOz/7SO1514E6Rpm/J2F9Uh0B18kClb?=
 =?us-ascii?Q?eYegGr1EPPn05lHoWHb55YwdBx5Uiw0aTsF2LgXauQ8WExFfh3udp0BS6b+k?=
 =?us-ascii?Q?yi82k10H8g5Bem17W0dmuFTm1WNbExS8BC3Tn2fMOp1BXH0nFA/exzIkUd6e?=
 =?us-ascii?Q?STNyz1CKACk+Nj9OB/eTGZ7xbl69kWsTKgBBN5F/A8sSfVlmjAb2nfDf2na8?=
 =?us-ascii?Q?96xnoW9CJZeEH6VifrtZLNEt/FocXEKIbMD5H5dBbaAo1NgK36iqL97ZotTt?=
 =?us-ascii?Q?/VPxSRd9iz4QfklAm5ZeBYctZj4dk3l9MPT6zC52zx0kQMo3fV/KLAojv5Z4?=
 =?us-ascii?Q?sMSSrVTAKkJag3sEUgfvaZuxbEsg/5MrkdiDZvqM7PNgYZ0sUWWZzt3HS06c?=
 =?us-ascii?Q?+7Sg+8WEqReAwa0XCRKwx/VNhZ1KoLpbNL7mYtpGfaWs0aPzIM9Fit+7d2el?=
 =?us-ascii?Q?dKfzpA5YBP9aMjr7AlRSIwpz13s7C0QBjHAJFCvcRH7RSsBkdlWTfJguwnJe?=
 =?us-ascii?Q?+9bNgItK3fUd88tcnHdrFsno/CNnSqk8O2LKo0e4PMzS7XRlgUy6xlpHxS0O?=
 =?us-ascii?Q?k7qOzqeQI1Peg8WjFB/fF+9k/fmw397n5Q3H2Wu+TDZDeoaDhUG3o0EOJv/R?=
 =?us-ascii?Q?FtcosinbjDxYcAhJVCkii0E1kVER0wK2x8KLbCTd6qkNY/kfCxI4mPcfTjPT?=
 =?us-ascii?Q?Qj3pDgu8By+rabdSaQYsid6a8Xgnnq79LxAKaoPzUdQF9a9RAmf5MglUG6J0?=
 =?us-ascii?Q?R5hjwbVWv6HMsJW16sCgALFRD2Ht642+8tKu8LYzMPrH398acyW//LkV7NUL?=
 =?us-ascii?Q?4mO/ff76+cytIXBRq1O0Kh6orqyKjGL0waGSN29Ct8Ly9A36a04hjz5th/X1?=
 =?us-ascii?Q?l53an8l1YUo5E4NC7x5yIY5KpQzyCklVhzmzJ6Z9No2aFDapwGjiVQgT18Tx?=
 =?us-ascii?Q?KBDxcv3XN6VxlJn4N/l1eOZ1Qx03Ib1ViJeumlQSeIzVtuEj94iEK1pdMHNy?=
 =?us-ascii?Q?O3soOnzAjvLP01djocyCYo4LaVzaKNNKxZzRerOHMzvOYBy6HZvnZX+22n2K?=
 =?us-ascii?Q?VpOJhSF9HrFm6gxGsmFwJSu2zW/JZ1AQF1PIYfLqhWBORjUzfOxHPJYBHaft?=
 =?us-ascii?Q?gYPhpn/ag4xk9ouIulNjWDHg9thIVPf0QRiKzxWmi+Cewszy9eGwvSs7M9WJ?=
 =?us-ascii?Q?4s+COGhUufxmx+C54d98TWExBLFOtKieAdLdHf11mqwhG3QyOTaJzGzF4ybA?=
 =?us-ascii?Q?SCi8WRqVkSa3/wwmcsMPg+4sr24m7Rf38GjMbCehsMZEto8QO9aIhT9JqNkA?=
 =?us-ascii?Q?4nfoma/Pasye41j9B3ZY4IJdolm7qW4vh6Wo+kJpuQHRe+pksatLmbahgxlR?=
 =?us-ascii?Q?PzP0kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:59:57.5942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ace7159-39e0-4c56-4e76-08de57f185d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

Define register access block which consolidates different register access
methods. Add smc method to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 25 +++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    | 18 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/cik.c              | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/nv.c               |  2 --
 drivers/gpu/drm/amd/amdgpu/si.c               | 12 ++++----
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/vi.c               | 28 +++++++++----------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    | 16 +++++------
 14 files changed, 84 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d847a1a0b3c2..9de738600a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -892,10 +892,8 @@ struct amdgpu_device {
 	/* protects concurrent MM_INDEX/DATA based register access */
 	spinlock_t mmio_idx_lock;
 	struct amdgpu_mmio_remap        rmmio_remap;
-	/* protects concurrent SMC based register access */
-	spinlock_t smc_idx_lock;
-	amdgpu_rreg_t			smc_rreg;
-	amdgpu_wreg_t			smc_wreg;
+	/* Indirect register access blocks */
+	struct amdgpu_reg_access reg;
 	/* protects concurrent PCIE register access */
 	spinlock_t pcie_idx_lock;
 	amdgpu_rreg_t			pcie_rreg;
@@ -1324,8 +1322,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (reg), (v))
 #define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg))
 #define WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
-#define RREG32_SMC(reg) adev->smc_rreg(adev, (reg))
-#define WREG32_SMC(reg, v) adev->smc_wreg(adev, (reg), (v))
+#define RREG32_SMC(reg) amdgpu_reg_smc_rd32(adev, (reg))
+#define WREG32_SMC(reg, v) amdgpu_reg_smc_wr32(adev, (reg), (v))
 #define RREG32_UVD_CTX(reg) adev->uvd_ctx_rreg(adev, (reg))
 #define WREG32_UVD_CTX(reg, v) adev->uvd_ctx_wreg(adev, (reg), (v))
 #define RREG32_DIDT(reg) adev->didt_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1f3e52637326..75154c0a26a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -761,7 +761,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
 	ssize_t result = 0;
 	int r;
 
-	if (!adev->smc_rreg)
+	if (!adev->reg.smc.rreg)
 		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
@@ -820,7 +820,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
 	ssize_t result = 0;
 	int r;
 
-	if (!adev->smc_wreg)
+	if (!adev->reg.smc.wreg)
 		return -EOPNOTSUPP;
 
 	if (size & 0x3 || *pos & 0x3)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 523e21edd036..10ab72a12ec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3849,8 +3849,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->fence_context = dma_fence_context_alloc(AMDGPU_MAX_RINGS);
 	bitmap_zero(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
 
-	adev->smc_rreg = &amdgpu_invalid_rreg;
-	adev->smc_wreg = &amdgpu_invalid_wreg;
+	amdgpu_reg_access_init(adev);
+
 	adev->pcie_rreg = &amdgpu_invalid_rreg;
 	adev->pcie_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg_ext = &amdgpu_invalid_rreg_ext;
@@ -3913,7 +3913,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 
 	spin_lock_init(&adev->mmio_idx_lock);
-	spin_lock_init(&adev->smc_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
 	spin_lock_init(&adev->uvd_ctx_idx_lock);
 	spin_lock_init(&adev->didt_idx_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 4b8888f82b64..5debc5c39101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -33,6 +33,31 @@
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
 
+void amdgpu_reg_access_init(struct amdgpu_device *adev)
+{
+	spin_lock_init(&adev->reg.smc.lock);
+	adev->reg.smc.rreg = NULL;
+	adev->reg.smc.wreg = NULL;
+}
+
+uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.smc.rreg) {
+		dev_err_once(adev->dev, "SMC register read not supported\n");
+		return 0;
+	}
+	return adev->reg.smc.rreg(adev, reg);
+}
+
+void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+{
+	if (!adev->reg.smc.wreg) {
+		dev_err_once(adev->dev, "SMC register write not supported\n");
+		return;
+	}
+	adev->reg.smc.wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index e03865c0c093..225d89eabed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -25,15 +25,27 @@
 #define __AMDGPU_REG_ACCESS_H__
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 struct amdgpu_device;
 
-/*
- * Registers read & write functions.
- */
 typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t);
 
+struct amdgpu_reg_ind {
+	spinlock_t lock;
+	amdgpu_rreg_t rreg;
+	amdgpu_wreg_t wreg;
+};
+
+struct amdgpu_reg_access {
+	struct amdgpu_reg_ind smc;
+};
+
+void amdgpu_reg_access_init(struct amdgpu_device *adev);
+uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c081784a19c4..cd5cd5da4d47 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -179,10 +179,10 @@ static u32 cik_smc_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmSMC_IND_INDEX_0, (reg));
 	r = RREG32(mmSMC_IND_DATA_0);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 	return r;
 }
 
@@ -190,10 +190,10 @@ static void cik_smc_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmSMC_IND_INDEX_0, (reg));
 	WREG32(mmSMC_IND_DATA_0, (v));
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 }
 
 static u32 cik_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
@@ -1027,7 +1027,7 @@ static bool cik_read_bios_from_rom(struct amdgpu_device *adev,
 	dw_ptr = (u32 *)bios;
 	length_dw = ALIGN(length_bytes, 4) / 4;
 	/* take the smc lock since we are using the smc index */
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	/* set rom index to 0 */
 	WREG32(mmSMC_IND_INDEX_0, ixROM_INDEX);
 	WREG32(mmSMC_IND_DATA_0, 0);
@@ -1035,7 +1035,7 @@ static bool cik_read_bios_from_rom(struct amdgpu_device *adev,
 	WREG32(mmSMC_IND_INDEX_0, ixROM_DATA);
 	for (i = 0; i < length_dw; i++)
 		dw_ptr[i] = RREG32(mmSMC_IND_DATA_0);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return true;
 }
@@ -1984,8 +1984,8 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->smc_rreg = &cik_smc_rreg;
-	adev->smc_wreg = &cik_smc_wreg;
+	adev->reg.smc.rreg = cik_smc_rreg;
+	adev->reg.smc.wreg = cik_smc_wreg;
 	adev->pcie_rreg = &cik_pcie_rreg;
 	adev->pcie_wreg = &cik_pcie_wreg;
 	adev->uvd_ctx_rreg = &cik_uvd_ctx_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index f17c3839aea1..2e7cd27e45c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -635,8 +635,6 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->smc_rreg = NULL;
-	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 509d43b238f3..cbdf8a1c6511 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1077,10 +1077,10 @@ static u32 si_smc_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmSMC_IND_INDEX_0, (reg));
 	r = RREG32(mmSMC_IND_DATA_0);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 	return r;
 }
 
@@ -1088,10 +1088,10 @@ static void si_smc_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmSMC_IND_INDEX_0, (reg));
 	WREG32(mmSMC_IND_DATA_0, (v));
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 }
 
 static u32 si_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
@@ -2037,8 +2037,8 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->smc_rreg = &si_smc_rreg;
-	adev->smc_wreg = &si_smc_wreg;
+	adev->reg.smc.rreg = si_smc_rreg;
+	adev->reg.smc.wreg = si_smc_wreg;
 	adev->pcie_rreg = &si_pcie_rreg;
 	adev->pcie_wreg = &si_pcie_wreg;
 	adev->pciep_rreg = &si_pciep_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 54b14751fd7a..e310b7c8bf1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -961,8 +961,6 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->smc_rreg = NULL;
-	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2da733b45c21..9d683ab74c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -582,8 +582,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->smc_rreg = NULL;
-	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index ecb6c3fcfbd1..867cc4fdc98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -362,8 +362,6 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->smc_rreg = NULL;
-	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 59ab952d5cce..f8a49424adeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -250,8 +250,6 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->smc_rreg = NULL;
-	adev->smc_wreg = NULL;
 	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a574b6c8e63..925cc275fe84 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -324,10 +324,10 @@ static u32 vi_smc_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32_NO_KIQ(mmSMC_IND_INDEX_11, (reg));
 	r = RREG32_NO_KIQ(mmSMC_IND_DATA_11);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 	return r;
 }
 
@@ -335,10 +335,10 @@ static void vi_smc_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32_NO_KIQ(mmSMC_IND_INDEX_11, (reg));
 	WREG32_NO_KIQ(mmSMC_IND_DATA_11, (v));
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 }
 
 /* smu_8_0_d.h */
@@ -350,10 +350,10 @@ static u32 cz_smc_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmMP0PUB_IND_INDEX, (reg));
 	r = RREG32(mmMP0PUB_IND_DATA);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 	return r;
 }
 
@@ -361,10 +361,10 @@ static void cz_smc_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmMP0PUB_IND_INDEX, (reg));
 	WREG32(mmMP0PUB_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 }
 
 static u32 vi_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
@@ -649,7 +649,7 @@ static bool vi_read_bios_from_rom(struct amdgpu_device *adev,
 	dw_ptr = (u32 *)bios;
 	length_dw = ALIGN(length_bytes, 4) / 4;
 	/* take the smc lock since we are using the smc index */
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	/* set rom index to 0 */
 	WREG32(mmSMC_IND_INDEX_11, ixROM_INDEX);
 	WREG32(mmSMC_IND_DATA_11, 0);
@@ -657,7 +657,7 @@ static bool vi_read_bios_from_rom(struct amdgpu_device *adev,
 	WREG32(mmSMC_IND_INDEX_11, ixROM_DATA);
 	for (i = 0; i < length_dw; i++)
 		dw_ptr[i] = RREG32(mmSMC_IND_DATA_11);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return true;
 }
@@ -1454,11 +1454,11 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->flags & AMD_IS_APU) {
-		adev->smc_rreg = &cz_smc_rreg;
-		adev->smc_wreg = &cz_smc_wreg;
+		adev->reg.smc.rreg = cz_smc_rreg;
+		adev->reg.smc.wreg = cz_smc_wreg;
 	} else {
-		adev->smc_rreg = &vi_smc_rreg;
-		adev->smc_wreg = &vi_smc_wreg;
+		adev->reg.smc.rreg = vi_smc_rreg;
+		adev->reg.smc.wreg = vi_smc_wreg;
 	}
 	adev->pcie_rreg = &vi_pcie_rreg;
 	adev->pcie_wreg = &vi_pcie_wreg;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
index 281a5e377aee..e1c509bfc390 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
@@ -65,7 +65,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device *adev,
 
 	addr = smc_start_address;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	while (byte_count >= 4) {
 		/* SMC address space is BE */
 		data = (src[0] << 24) | (src[1] << 16) | (src[2] << 8) | src[3];
@@ -109,7 +109,7 @@ int amdgpu_si_copy_bytes_to_smc(struct amdgpu_device *adev,
 	}
 
 done:
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return ret;
 }
@@ -252,7 +252,7 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_device *adev, u32 limit)
 	if (ucode_size & 3)
 		return -EINVAL;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	WREG32(mmSMC_IND_INDEX_0, ucode_start_address);
 	WREG32_P(mmSMC_IND_ACCESS_CNTL, SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK, ~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
 	while (ucode_size >= 4) {
@@ -265,7 +265,7 @@ int amdgpu_si_load_smc_ucode(struct amdgpu_device *adev, u32 limit)
 		ucode_size -= 4;
 	}
 	WREG32_P(mmSMC_IND_ACCESS_CNTL, 0, ~SMC_IND_ACCESS_CNTL__AUTO_INCREMENT_IND_0_MASK);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return 0;
 }
@@ -276,11 +276,11 @@ int amdgpu_si_read_smc_sram_dword(struct amdgpu_device *adev, u32 smc_address,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	ret = si_set_smc_sram_address(adev, smc_address, limit);
 	if (ret == 0)
 		*value = RREG32(mmSMC_IND_DATA_0);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return ret;
 }
@@ -291,11 +291,11 @@ int amdgpu_si_write_smc_sram_dword(struct amdgpu_device *adev, u32 smc_address,
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&adev->smc_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.smc.lock, flags);
 	ret = si_set_smc_sram_address(adev, smc_address, limit);
 	if (ret == 0)
 		WREG32(mmSMC_IND_DATA_0, value);
-	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.smc.lock, flags);
 
 	return ret;
 }
-- 
2.49.0

