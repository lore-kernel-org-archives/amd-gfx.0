Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CFBD2ED11
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985A010E565;
	Tue, 20 Jan 2026 07:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsUAT2Yu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C2B10E562
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5NIVbOPHmyR6gcTEPi8yOn39tyFHnYU5MYDzz2r2389Ghj9/LY1jDAPrSZOq2mXJ8NxrT4i/+wGcSzy328UACG33Tlrjo1qneAXbWRUrkoie63AeWYbH93RyRydwvCs/qcI9q0I6McrzoPkpTMZdoSUGfPjPW7KJjZ+Eg0KP+Jhb/tWdH+BfszzymQJggovJrdxbJVx9imEFs9tcb86+E0/xavHPUXTufHk19Zdo3Oz71OOEZCJH5WBBPh44u1nbkiQEKNkSAF8I5zINh0keAhdKas/f0kCChqdpAZCt91enBAdV2nfIbAgHhT96tolUSF2PV+yQ6YydCiSzVv9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RId7WrGeytLRB2WacZAiXrWrC/iOT+G5HlNGQfTRFtY=;
 b=hp4aR+sSV0OIxXQF0uTTBKh4EyLAFwycfr+TSjXbkl+IiQWWEye9fTtU8Rjkwsk5QAGpwJkBUJCbHKbo3O+WyYioaDTh2blwPzJHQTCeUSpKRfIpLs5km/lePxsYnKYQ9wLJriTZ4DrvKfEW0Uiqhp4UzA8lYKfU3DF/UQq86AE2ik/2fmXEnPWgkdyIVPKflyzjOEQwn0iyBjqPxPtp/TOvom21noQRGaH20LYtwE0C6ptjKUMJEun//Pddy85qtJXNEnfDkcJx4v/P3FLRnUY9ECkXECRqcVUuZwTMLGuTA8xTLFzdaCUPhtDRM+zSrmrtosSTz7amEPozi+iKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RId7WrGeytLRB2WacZAiXrWrC/iOT+G5HlNGQfTRFtY=;
 b=OsUAT2YuilvHc48cmRk6vQiMWcJVGZFc2TTjZ6cDbLtC2ColWnhY3QddIyYLI+IV9SPrvQKRh2lasg767oqPmb5mJF3ZIrLPkH+dSxqLWD2gNIkxPIcaGAtv85oxQbyCtPoHWY4iUEtGUTX2O3QmnmoEWf5z97m6dOPvC8ikxYI=
Received: from SJ0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:a03:3a1::32)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:13 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6e) by SJ0PR03CA0387.outlook.office365.com
 (2603:10b6:a03:3a1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:06 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 09/15] drm/amdgpu: Add pcie indirect to register block
Date: Tue, 20 Jan 2026 12:27:43 +0530
Message-ID: <20260120065931.1300054-10-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 08193d15-e587-4520-4ca2-08de57f18f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AOXPyuF/gqZ5kGSZtirZCkIsY8majodk07B+R6n5QQwPjrHNBfO8a+vd50qe?=
 =?us-ascii?Q?naS6OIS6GcGY61k1FtEfjotEm2KZKW8dZ1/x14jJ4M2q1+fsEoLA3cpk6Aoh?=
 =?us-ascii?Q?dUCy0GmBS1c9dbyQXzD5zDIF1nxyIZNje1qwp3zoSKRw6tzF5146LiTDMylF?=
 =?us-ascii?Q?sQPo1BLgRk1dNFAr9gj/rMhqCfdbwiZdN2Qmh2nFjKWONInWFKCt3jrZJDTa?=
 =?us-ascii?Q?90jpchMzUc+xQoBYOUygKe8mTID6zVA/ZKrO3kOEg4bXLS4JCXGTGuyIU56W?=
 =?us-ascii?Q?tM9vFKiuLxADy+o38IRTCldiHob4EcL8HRVb643bTb8ZgS7XRPNKvbF3g+av?=
 =?us-ascii?Q?5SC2zbgl9+bTH6DZPWycY3qEUSj/DYy+bLliPE1WnRCtJTNfTlyk3TK2m8S3?=
 =?us-ascii?Q?31bjrz6+dZWWOanxidqHP3da4349SUr6D8fOan21JcSyjV/TD4s4QnlZwCmI?=
 =?us-ascii?Q?U95dwqxU9QiRiuJiXZX5rcHP6YyGe6xSmwZ7CMG7Iv5oOPp/BndApvzk744/?=
 =?us-ascii?Q?urSuCDxeSwGIZKdRh2K/2SghvmNV5fUAy3mE73rm9OTlmiOvMlIZMDkVBpu3?=
 =?us-ascii?Q?NmO6yDEOrQwEAwsySBO0dF07OfKbT7418/0AHmct/aX42JTipiNcnkxWLXpR?=
 =?us-ascii?Q?/K5lKhbEeSeepJ3k5TGlTOKzI4O7nGkk7SEmc5HSIvBdpPR5CbnN57KcnPvS?=
 =?us-ascii?Q?vfMyWHh8Dh6YuRqkXv5x5/2/DJar8Cc26lXCU3R3t6fITmbGDdb57RL39Vnn?=
 =?us-ascii?Q?Xw8hDO3H0EAabdgLM47ROuFQh68KIq2DVrot3PxwrR4afeeIvcnL8yvaKiI6?=
 =?us-ascii?Q?dvLK9JxuQN0plqrpKsVCq5iW3eVesh/YoWW0z/DqwnVRQrmY2ixsUMb0HFks?=
 =?us-ascii?Q?fuZb5mikqKlY79bhaGUgqyH7sDzdaWM02vqwhcs+jcrC7wiqpLtxzHdbHug/?=
 =?us-ascii?Q?srURD103UJJ+KSm7y5eMQP+TmP2sx7kbVt/H3s6UI6Y6GY7dtWbp8UaHPfGq?=
 =?us-ascii?Q?bJJ/hVld4CREvIFv/Vc+0qJ186UHkdEa9X5/DYPLxjlBrz2PIZQace4UOoA7?=
 =?us-ascii?Q?to0EkEhMHCp+wk1QbJX+zYKJyolBthqFAHojdt0sLwOR5oCut91luGZxu+yd?=
 =?us-ascii?Q?qnyn2bXxlZLtmm3y4p+TLj3WFKVHEsgrbOXWrDWs3kjUXpyWgjmti8IEAxHq?=
 =?us-ascii?Q?cDzsUbkxYrzPv3BM9eDpH4Vl1q/kjkuDRa7nOoS/Q789RUStQVXXjJIF4Nyj?=
 =?us-ascii?Q?0RpP+pVYMj8D57kriDmc+Aem4okYCSV7Duem9d5h+KxlBJ52kWgsDQF98l4X?=
 =?us-ascii?Q?8eJqkjt26qLlNpSSPvuG6i21zvj4BVHNENzwy7wnYCIh7SWmrJcXVL5AENTY?=
 =?us-ascii?Q?MLdoxFKVb/PjYbKEJDVPej0r1mwTbMEHdWTHJXFcz4TJnvphpW1zRBZfirHI?=
 =?us-ascii?Q?iNaPYiUGJ51dR7J44/2xFQHigax1q/Rv8qK4WclEuccyvLiJGOmDhMxJn5M6?=
 =?us-ascii?Q?r9nE0JJe+C8jpEzS73NKNfNu2fmUsPU9AnytuT5dEZcNXA4jwwSyHE05v1q+?=
 =?us-ascii?Q?7o9TPUL4b1K09ggdR92BfKcWq+aIcHuL6YLtztsd5otoVkk1qi3dqsckxTlp?=
 =?us-ascii?Q?VHbPFMyWPJeu/PjcdP0kBjptQilqKiD3Nud3ETZ1kXYS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:13.3605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08193d15-e587-4520-4ca2-08de57f18f3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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

Move pcie indirect access to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 37 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 30 ++++++++++++---
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/cik.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |  4 +-
 12 files changed, 47 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9678fddb8ad4..5c54042d6fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -896,8 +896,6 @@ struct amdgpu_device {
 	struct amdgpu_reg_access reg;
 	/* protects concurrent PCIE register access */
 	spinlock_t pcie_idx_lock;
-	amdgpu_rreg_t			pcie_rreg;
-	amdgpu_wreg_t			pcie_wreg;
 	amdgpu_rreg_ext_t		pcie_rreg_ext;
 	amdgpu_wreg_ext_t		pcie_wreg_ext;
 	amdgpu_rreg64_t			pcie_rreg64;
@@ -1290,8 +1288,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define RREG32_XCC(reg, inst) amdgpu_device_xcc_rreg(adev, (reg), 0, inst)
 #define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
-#define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
-#define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
+#define RREG32_PCIE(reg) amdgpu_reg_pcie_rd32(adev, (reg))
+#define WREG32_PCIE(reg, v) amdgpu_reg_pcie_wr32(adev, (reg), (v))
 #define RREG32_PCIE_PORT(reg) amdgpu_reg_pciep_rd32(adev, (reg))
 #define WREG32_PCIE_PORT(reg, v) amdgpu_reg_pciep_wr32(adev, (reg), (v))
 #define RREG32_PCIE_EXT(reg) adev->pcie_rreg_ext(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 88e2cc27dbea..862cda9aacac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -858,23 +858,6 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-/**
- * amdgpu_invalid_rreg - dummy reg read function
- *
- * @adev: amdgpu_device pointer
- * @reg: offset of register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- * Returns the value in the register.
- */
-static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t reg)
-{
-	dev_err(adev->dev, "Invalid callback to read register 0x%04X\n", reg);
-	BUG();
-	return 0;
-}
-
 static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg)
 {
 	dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", reg);
@@ -882,24 +865,6 @@ static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg
 	return 0;
 }
 
-/**
- * amdgpu_invalid_wreg - dummy reg write function
- *
- * @adev: amdgpu_device pointer
- * @reg: offset of register
- * @v: value to write to the register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- */
-static void amdgpu_invalid_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
-{
-	dev_err(adev->dev,
-		"Invalid callback to write register 0x%04X with 0x%08X\n", reg,
-		v);
-	BUG();
-}
-
 static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t reg, uint32_t v)
 {
 	dev_err(adev->dev,
@@ -3809,8 +3774,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_reg_access_init(adev);
 
-	adev->pcie_rreg = &amdgpu_invalid_rreg;
-	adev->pcie_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg_ext = &amdgpu_invalid_rreg_ext;
 	adev->pcie_wreg_ext = &amdgpu_invalid_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 175fdfc5229b..11ba235ee143 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -59,6 +59,8 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	adev->reg.audio_endpt.rreg = NULL;
 	adev->reg.audio_endpt.wreg = NULL;
 
+	adev->reg.pcie.rreg = NULL;
+	adev->reg.pcie.wreg = NULL;
 	adev->reg.pcie.port_rreg = NULL;
 	adev->reg.pcie.port_wreg = NULL;
 }
@@ -182,6 +184,24 @@ void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
 	adev->reg.audio_endpt.wreg(adev, block, reg, v);
 }
 
+uint32_t amdgpu_reg_pcie_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.pcie.rreg) {
+		dev_err_once(adev->dev, "PCIE register read not supported\n");
+		return 0;
+	}
+	return adev->reg.pcie.rreg(adev, reg);
+}
+
+void amdgpu_reg_pcie_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+{
+	if (!adev->reg.pcie.wreg) {
+		dev_err_once(adev->dev, "PCIE register write not supported\n");
+		return;
+	}
+	adev->reg.pcie.wreg(adev, reg, v);
+}
+
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg)
 {
 	if (!adev->reg.pcie.port_rreg) {
@@ -231,7 +251,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
-		ret = adev->pcie_rreg(adev, reg * 4);
+		ret = amdgpu_reg_pcie_rd32(adev, reg * 4);
 	}
 
 	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
@@ -296,7 +316,7 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev, uint32_t reg,
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
-		ret = adev->pcie_rreg(adev, reg * 4);
+		ret = amdgpu_reg_pcie_rd32(adev, reg * 4);
 	}
 
 	return ret;
@@ -354,7 +374,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
-		adev->pcie_wreg(adev, reg * 4, v);
+		amdgpu_reg_pcie_wr32(adev, reg * 4, v);
 	}
 
 	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
@@ -381,7 +401,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg,
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
 			return amdgpu_sriov_wreg(adev, reg, v, 0, 0, xcc_id);
 	} else if ((reg * 4) >= adev->rmmio_size) {
-		adev->pcie_wreg(adev, reg * 4, v);
+		amdgpu_reg_pcie_wr32(adev, reg * 4, v);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
@@ -422,7 +442,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev, uint32_t reg,
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 		}
 	} else {
-		adev->pcie_wreg(adev, reg * 4, v);
+		amdgpu_reg_pcie_wr32(adev, reg * 4, v);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index eb449dbb8fd4..8a83eb36945b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -50,6 +50,8 @@ struct amdgpu_reg_ind_blk {
 };
 
 struct amdgpu_reg_pcie_ind {
+	amdgpu_rreg_t rreg;
+	amdgpu_wreg_t wreg;
 	amdgpu_rreg_t port_rreg;
 	amdgpu_wreg_t port_wreg;
 };
@@ -81,6 +83,8 @@ uint32_t amdgpu_reg_audio_endpt_rd32(struct amdgpu_device *adev, uint32_t block,
 				     uint32_t reg);
 void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
 				 uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_pcie_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_pcie_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 			   uint32_t v);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 90c9a2e1cf5b..a4461574f881 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1986,8 +1986,8 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	adev->reg.smc.rreg = cik_smc_rreg;
 	adev->reg.smc.wreg = cik_smc_wreg;
-	adev->pcie_rreg = &cik_pcie_rreg;
-	adev->pcie_wreg = &cik_pcie_wreg;
+	adev->reg.pcie.rreg = &cik_pcie_rreg;
+	adev->reg.pcie.wreg = &cik_pcie_wreg;
 	adev->reg.uvd_ctx.rreg = &cik_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &cik_uvd_ctx_wreg;
 	adev->reg.didt.rreg = &cik_didt_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b3abf6554386..302c56630bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -635,8 +635,8 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
+	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index a517c6cd0711..4aadb7a19a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2039,8 +2039,8 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	adev->reg.smc.rreg = si_smc_rreg;
 	adev->reg.smc.wreg = si_smc_wreg;
-	adev->pcie_rreg = &si_pcie_rreg;
-	adev->pcie_wreg = &si_pcie_wreg;
+	adev->reg.pcie.rreg = &si_pcie_rreg;
+	adev->reg.pcie.wreg = &si_pcie_wreg;
 	adev->reg.pcie.port_rreg = &si_pciep_rreg;
 	adev->reg.pcie.port_wreg = &si_pciep_wreg;
 	adev->reg.uvd_ctx.rreg = &si_uvd_ctx_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 64e47435d9e1..33955b625bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -961,8 +961,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
+	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
 	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 968d9be033d8..3695fd951aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -582,8 +582,8 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
+	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 7c59d9b0a541..2b2b8737ec5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -362,8 +362,8 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->nbio.funcs->set_reg_remap(adev);
-	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
+	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 8c808a6d08a5..d0bc844a5ba6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -250,8 +250,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	adev->pcie_rreg = &amdgpu_device_indirect_rreg;
-	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
+	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
+	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg_ext = &amdgpu_device_indirect_rreg_ext;
 	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b8b6e1ea0d52..7d1f9a25b109 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1460,8 +1460,8 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->reg.smc.rreg = vi_smc_rreg;
 		adev->reg.smc.wreg = vi_smc_wreg;
 	}
-	adev->pcie_rreg = &vi_pcie_rreg;
-	adev->pcie_wreg = &vi_pcie_wreg;
+	adev->reg.pcie.rreg = &vi_pcie_rreg;
+	adev->reg.pcie.wreg = &vi_pcie_wreg;
 	adev->reg.uvd_ctx.rreg = &vi_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &vi_uvd_ctx_wreg;
 	adev->reg.didt.rreg = &vi_didt_rreg;
-- 
2.49.0

