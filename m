Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B4CD2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E333D10E56B;
	Tue, 20 Jan 2026 07:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YgPCdGQB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C5110E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB8PX1q3hZqtReMK4EWsYXlYgVxna2D0HMCjJx9rCr4FXOED/R25tvjjTORDNxtKrwL+6THrb9hO74R0nozpUm7dgpAyPXT2ATK1H82u2AyUjn8kwB82taKETRD9BG6lDgsBTwa1SFfz2F4TjRk3BRBQk2mD5tvy9d/uPKc0EHhngRqI34KLLQG7QHfXethWNfTewoMO0EstTOOxaYnkKyQ+RKUhS/MAZWzSAPD8qI8XmdEnpRaS8kMGnqoKbFhokPZa3iXmeEdwGfsDg/RqubOFzbmdAr+98cGaBt9DvstpvQnTXmGHjT461OLbFxALIa9XHDbf6eo0kL6xbzMAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAaAG+IA1vwtL6KKoXTf1oqA04EcAqEJaZXzdZx6nZY=;
 b=UiMIFxb4b9Sa1Bkdc1DrkTB8eJW0C9NV6r843SWALVaslXYQ8vZsT+uaUUIDihzq+FPldCVHRbpL3RDzyX3Q1d8ygiMW5t0te2B42eymcOnUM2DrHpIRy99BmQF6fMsIdZpKwy6X50yYVoVMBmr6pVFjdf5vz1N6zHCAxUdu8f9rzcJqxeywOrFptUDOIKWsnsvlL09fTSvNLf98FwyMDUtdzlS4IZHKKLLwC8lkoTuNEo/dbL1MAF0pQ/U4yCp+Ff3DLhuXhg9HYjoVK/4KWuTQNO6+KiniwfcGWmoXQkEGwIQsV1ja5hzVZb7oIxWsy6DPDyQSBKcMYIUy9qauJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAaAG+IA1vwtL6KKoXTf1oqA04EcAqEJaZXzdZx6nZY=;
 b=YgPCdGQBchkx2+1GsiNVMqicZv8fWh42iFNXZQEsk3hE9nnaYTnkbtRnbBtVk/Ty66NU+8Y2W1lLG5umzEmARyJNIKs6EhZmsL/ArBrjt6X6QDR1rRvAz47CWNaVBxqiLagt763+lBTeJsrUI2HZ6tylJs+lHW95gZAIga80EbI=
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:00:17 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2c) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 12/15] drm/amdgpu: Add pcie64 extended to register block
Date: Tue, 20 Jan 2026 12:27:46 +0530
Message-ID: <20260120065931.1300054-13-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b01a0f3-2b07-4ba0-3bc0-08de57f190cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vCxZqgq9XSuVHxwzZOntaxFthUHcJRheGtOEdSj7CMmaxyPT5iT9cEnO54yI?=
 =?us-ascii?Q?SVHZiOIf5pMnOOhFbrkJed/U+vptORx2iwnT+uv6YgQVMz/td8dAeqeHN71S?=
 =?us-ascii?Q?uctvEcJDApenvKAlxzigp/TEE2wymlwo8ne4Ad7mK5pcqwN3ZUEy79lcZ1uE?=
 =?us-ascii?Q?mt93y3fdm5oUCmZQz36d+nyi2qdMOkEDomRKSzXR5zr0/j3f81Ef/4/YiLOk?=
 =?us-ascii?Q?No+GmL3VKMxazBHF5cZY4loL74yZNDrqblXskZP9y1bI8xon+u/l0CdwoV+q?=
 =?us-ascii?Q?bhis2jEkeFY/q+Umd6b0VFr1lgWN9UemT3jUMoZrnNMLNkFfJvCbYqpEI0ci?=
 =?us-ascii?Q?huRu0wZcu9K6GbWH5SW8kEkVPmPC3S9X9dhXPVV4ENSfN8bO/y4I4TDC9Fi0?=
 =?us-ascii?Q?c3w7XZGuCDIfeQ4haxt/7Jnuveun6U7FgaEEQ5vyOriMmlzqgdzR+bhb9Glq?=
 =?us-ascii?Q?wYbwxfIM857HJLmaHvGy9N9mF3NfW2A5zNQ0sL7KjTN+iXRZIOmMJESm9kTe?=
 =?us-ascii?Q?ML88XcVyyGSeq7ZYeg5CAljXDEwHLv9W1i0AbDq9WyUYx8RkKuLHs9/IQLSB?=
 =?us-ascii?Q?veEC3ouCYosguaw/G91sFVg3T3jztuB5MgiP0+IqWCnDawsAS214USOTbNir?=
 =?us-ascii?Q?GMsUAHNp18E9jnFLrszmYgAh1b9PCeqXyteSsqJ+/X0u4E1eebtsQAt+NsGk?=
 =?us-ascii?Q?izhMsl2t0PnUupjg6gnQ1m/siV2XGzHijLsPvlUomRjlirKyrouH04gREajp?=
 =?us-ascii?Q?N/se9oj9cTgVI8AAYQOvFxFwOvUD3vRJ8QqZu0Yu9eICqBEoH7Hd+501ElQL?=
 =?us-ascii?Q?gyamy7dBCw6HOy3DkfSwzUZ1+C8s8hcl+1CJay9uRHYEuAZdWxcX+6HgWaS6?=
 =?us-ascii?Q?42Tggt4zipUvHYl6NjPNmLXPnM+DM8u4QxGdrzpdNApY8rKT2cXqMlJmxkNi?=
 =?us-ascii?Q?+EIgaYml3K4wf0GZ2i3aiC/wXZYqF7/vpmkC/D+mqenh667E67X37nTSuvaW?=
 =?us-ascii?Q?eMLGdQh7pIMfMXmIs45KO/A5dPG1+VYDPGwdRxMBhwqbWrqRBWPKWcYf5w/f?=
 =?us-ascii?Q?CJ4M2M6aSDSl5mIAQyhLaqxYfvkbAZe/pwVoWVdUiF3VOannh8tP96lGhpv0?=
 =?us-ascii?Q?QBmSNBH2hskz07tlzuePdybFVfozQiKrrLs9CgRleFNlzcg6N2nIEYdftRkb?=
 =?us-ascii?Q?hu3qDLCnHBaMFG76OQrZhdThcBR0HY+yyDPUZ6kofzzgUeQgO/dzx+RvaFFh?=
 =?us-ascii?Q?ZhMQ9+c1DPWOzdrlFZN/O7AQctogggpQsEfVLbfUppTG64YF/Nzwj2d3a/1Y?=
 =?us-ascii?Q?aOwJJVnsHAijtz+nW/t0e5JtLtRhVbp5DF+SvUeEm36GZmyMqkWYPt1Ysxro?=
 =?us-ascii?Q?RiazGCIqt9m4Vp5VQpC/k9facr61jr8LqCJmI+x25ttGa6j9n3n4BwaSUTod?=
 =?us-ascii?Q?3BPRZsMnyXjQoC1Xco4o/ZKG0sDQXSZ0W1DDeL2ejU5EQTgKuZeGBk3FuvHc?=
 =?us-ascii?Q?ycaObT4w+flFLu+m01FJiwx8GvWdwBGxOt3q8YeczOg5bL4jVHi3sQRCNQWA?=
 =?us-ascii?Q?+byQaUzcL90EdR4JQQPpHMsOtbm7wP9IuOqH0FxjfHM99OsdjYpxGdEgNhj3?=
 =?us-ascii?Q?fGU+zRcDbQrHC14jTgNDFLkDqUepU4GiFSEcH05yfKHuRBAqRtKRSwHEHn+0?=
 =?us-ascii?Q?xVNJ5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:16.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b01a0f3-2b07-4ba0-3bc0-08de57f190cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

Add extended pcie 64-bit access method to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 18 ----------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 21 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    | 10 ++++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  4 ++--
 6 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 29dbad0a1ae0..aef36ba57886 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -896,8 +896,6 @@ struct amdgpu_device {
 	struct amdgpu_reg_access reg;
 	/* protects concurrent PCIE register access */
 	spinlock_t pcie_idx_lock;
-	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
-	amdgpu_wreg64_ext_t pcie_wreg64_ext;
 	struct amdgpu_doorbell		doorbell;
 
 	/* clock/pll info */
@@ -1292,8 +1290,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_PCIE_EXT(reg, v) amdgpu_reg_pcie_ext_wr32(adev, (reg), (v))
 #define RREG64_PCIE(reg) amdgpu_reg_pcie_rd64(adev, (reg))
 #define WREG64_PCIE(reg, v) amdgpu_reg_pcie_wr64(adev, (reg), (v))
-#define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg))
-#define WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
+#define RREG64_PCIE_EXT(reg) amdgpu_reg_pcie_ext_rd64(adev, (reg))
+#define WREG64_PCIE_EXT(reg, v) amdgpu_reg_pcie_ext_wr64(adev, (reg), (v))
 #define RREG32_SMC(reg) amdgpu_reg_smc_rd32(adev, (reg))
 #define WREG32_SMC(reg, v) amdgpu_reg_smc_wr32(adev, (reg), (v))
 #define RREG32_UVD_CTX(reg) amdgpu_reg_uvd_ctx_rd32(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf576faa84b9..7ab4b99823a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -858,21 +858,6 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t reg)
-{
-	dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", reg);
-	BUG();
-	return 0;
-}
-
-static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg, uint64_t v)
-{
-	dev_err(adev->dev,
-		"Invalid callback to write 64 bit register 0x%llX with 0x%08llX\n",
-		reg, v);
-	BUG();
-}
-
 static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 {
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
@@ -3723,9 +3708,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_reg_access_init(adev);
 
-	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
-	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
-
 	dev_info(
 		adev->dev,
 		"initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index fc7c2dc458c3..0e2722e3722e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -65,6 +65,8 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	adev->reg.pcie.wreg_ext = NULL;
 	adev->reg.pcie.rreg64 = NULL;
 	adev->reg.pcie.wreg64 = NULL;
+	adev->reg.pcie.rreg64_ext = NULL;
+	adev->reg.pcie.wreg64_ext = NULL;
 	adev->reg.pcie.port_rreg = NULL;
 	adev->reg.pcie.port_wreg = NULL;
 }
@@ -243,6 +245,25 @@ void amdgpu_reg_pcie_wr64(struct amdgpu_device *adev, uint32_t reg, uint64_t v)
 	adev->reg.pcie.wreg64(adev, reg, v);
 }
 
+uint64_t amdgpu_reg_pcie_ext_rd64(struct amdgpu_device *adev, uint64_t reg)
+{
+	if (!adev->reg.pcie.rreg64_ext) {
+		dev_err_once(adev->dev, "PCIE EXT 64-bit register read not supported\n");
+		return 0;
+	}
+	return adev->reg.pcie.rreg64_ext(adev, reg);
+}
+
+void amdgpu_reg_pcie_ext_wr64(struct amdgpu_device *adev, uint64_t reg,
+			      uint64_t v)
+{
+	if (!adev->reg.pcie.wreg64_ext) {
+		dev_err_once(adev->dev, "PCIE EXT 64-bit register write not supported\n");
+		return;
+	}
+	adev->reg.pcie.wreg64_ext(adev, reg, v);
+}
+
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg)
 {
 	if (!adev->reg.pcie.port_rreg) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index e6c0a59973c4..791b3e50ac9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -35,6 +35,8 @@ typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
 typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
+typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device *, uint64_t);
+typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device *, uint64_t, uint64_t);
 
 typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
 					uint32_t);
@@ -60,6 +62,8 @@ struct amdgpu_reg_pcie_ind {
 	amdgpu_wreg_ext_t wreg_ext;
 	amdgpu_rreg64_t rreg64;
 	amdgpu_wreg64_t wreg64;
+	amdgpu_rreg64_ext_t rreg64_ext;
+	amdgpu_wreg64_ext_t wreg64_ext;
 	amdgpu_rreg_t port_rreg;
 	amdgpu_wreg_t port_wreg;
 };
@@ -98,13 +102,13 @@ void amdgpu_reg_pcie_ext_wr32(struct amdgpu_device *adev, uint64_t reg,
 			      uint32_t v);
 uint64_t amdgpu_reg_pcie_rd64(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pcie_wr64(struct amdgpu_device *adev, uint32_t reg, uint64_t v);
+uint64_t amdgpu_reg_pcie_ext_rd64(struct amdgpu_device *adev, uint64_t reg);
+void amdgpu_reg_pcie_ext_wr64(struct amdgpu_device *adev, uint64_t reg,
+			      uint64_t v);
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 			   uint32_t v);
 
-typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device *, uint64_t);
-typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device *, uint64_t, uint64_t);
-
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t acc_flags);
 uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 70e218ad7e18..a3c9a557c284 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -967,8 +967,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.pcie.wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
-	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
-	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
+	adev->reg.pcie.rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
+	adev->reg.pcie.wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 	adev->reg.uvd_ctx.rreg = &soc15_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &soc15_uvd_ctx_wreg;
 	adev->reg.didt.rreg = &soc15_didt_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index ca6d6755dde1..26e7566a5479 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -258,8 +258,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
 	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
-	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
-	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
+	adev->reg.pcie.rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
+	adev->reg.pcie.wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 
 	adev->asic_funcs = &soc_v1_0_asic_funcs;
 
-- 
2.49.0

