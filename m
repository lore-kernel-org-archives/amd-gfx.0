Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C599D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F3A10E568;
	Tue, 20 Jan 2026 07:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAJ/3+Du";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6C010E565
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZba21H0js+BNVdpBl3AaLR/rJ8IEefUyOf5xDZNAY8gk6ts5G+51bcj27UBHm8z30zD2dS4Blc1bVGe4BT4EUoObhUAsm0yGryWDsLrL+dlpf68lux2VSKOb0oZvoFaAk9wgzrk8F4p0nPKk4OJ0760LvcP+9eVvAtThban0zPr3ln5xzdZdu7T867tU1Trx7kd/uZuKhSMDgQnVQKzPEjMrJ9z6EK2744YCudpw9vFKkW5vXEqndVX+yaVEiXHW2ZxsK4GyWzbSRDvQvTqp2t3K7HMoAn1yhpGXubVunblmeIK5QYWGfvlMdra4/opfq7YVjzbvgkeJODFKrVtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUF6TiSeag4+9CGTV/cIjyYMkkBKYPze9yaHLdJy4wY=;
 b=Sl441bKDPzJCijVpN+BtzXr97Xs9SRbixy1bvXd8BLgU9rVOli9BuKL0fVTrcZw+4DmMWCFG4zSKwblMOz4lEnDU4Q9j68ehPA5MOTGu6EaRjdha9bHQ5bFj37EiAtKD2OehgzSbwiu/NSIlrYOBYpdzWmzg8O9udfqG+OmmIZx2/3se9jxBbAC7jhlkwgIHyjG78amAqxhJSdrfgxXT2K1W0qmgKPjAMzQxoAqiwpYIOuBb2YkbU9LYA40H0jr12nYescqy0SQAWWhu43xEYdEcl7yFIYF/cOv+/GCMO78M1B3oNVrTaGg5INPe8Ie8pdhSHq9XQRVUmy8ejTrtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUF6TiSeag4+9CGTV/cIjyYMkkBKYPze9yaHLdJy4wY=;
 b=fAJ/3+DuB5r45wULKHsQUQMa2FP5LF+FqVB+nTv2w4ipsEd6wrGuxRPYu64SsKXzx/3tL+ISa/BLwUKN+yFaQj0K29o3TS/v+tYKVoXixysCmRE8C07nWo2xkGfeN7FNqoE7rzhwzKl3L4v8QVnLOwN4KSLs1xU9bXmWUHC+nCM=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 07:00:15 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::31) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:09 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 11/15] drm/amdgpu: Add pcie64 indirect to register block
Date: Tue, 20 Jan 2026 12:27:45 +0530
Message-ID: <20260120065931.1300054-12-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d0cace-77b5-4392-264d-08de57f19037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQo0UF9Nljtvt6nmzLzlwxRWqNaljPCzzva9SYEvG05DpN6cXBOgoxGyjcO+?=
 =?us-ascii?Q?F59a5bRR+4R6CzVrUxH48tGyubuPyKmnN/OkABUSv2V8WS+OHvWzMZjk6wuI?=
 =?us-ascii?Q?zYJ6SNMQpO63DU/Y1EVgxziFpaWiLFv1p9gKRuTxd7GCH6o9PWhWQMsyGrAJ?=
 =?us-ascii?Q?bdTu6Ipx8r0svfQaPTfZrCZmsDoReigWPUNHGzCEje0UX66c6yrMrH9OqvTF?=
 =?us-ascii?Q?a1AGgaELkvvxWT7H/5jRFdMkjv/E6K4EQzU6m5mG8wPdjwXsIIC3KcRrxkuO?=
 =?us-ascii?Q?2hTHCvBp9ynQGnscfo+Xwq4qfDGTGkZFEYP4pkk3eMr249lnpmOOTEKLtboM?=
 =?us-ascii?Q?8XaQBXgwDR6rqQpC2b6gkQH4PgBxuJPnLXf0bUgpndSJFnNziIe2lEpfRrOj?=
 =?us-ascii?Q?cDuS2qFP5rFfxyABQveAhlu5bBVtVOHnQMwomKziVN8d1zX79I1ORaR6pjr+?=
 =?us-ascii?Q?RdjE9Ws2TM+fSDeb7nqFRPFtWFXYranSjACzlnmOH8xAC890XEEIHiPr/nnp?=
 =?us-ascii?Q?mk3RtuBOZ859ljWX1rgebFJb8rRRnIWfFPZ2MyJ2e2TXkrWQpGSUPx9itRIf?=
 =?us-ascii?Q?imQ6e1sv7ovdOqzzabK1oNrN6ctsJZx1ju1pszzF6zKFctkgey6yy8+M0k1W?=
 =?us-ascii?Q?Cme2pNIbfmg8hgFV7TjchTFypEaiSG89jCUQKSDvmCPxS8hj72hgyMS6yjuN?=
 =?us-ascii?Q?dKsH46O94tgmAT7c43uAnav8eF37VL6GjGkGXPJFrKjONgmaJkerKK8pQzw4?=
 =?us-ascii?Q?tdYdlSmTK8Dr4VWP9ryJ+q3BPZ5dkBvnWDit0b8U2zfTZuCUiPOAelAMK2cm?=
 =?us-ascii?Q?3N9co7GbtCBkh28wdE9iQLLd1/sam043iOvBrKTPHxmNXUeFZQD60AVVjHly?=
 =?us-ascii?Q?bMX6XbI8CyBdavGcZL/GK0Hjn5hWFrNtIqOReVOmNbEkomcom80KALZxl+TC?=
 =?us-ascii?Q?Yv5q/9etxYUA7LGms950MaWZzikz5DYPdzxjYZmUZo+tNQtBEtuu/NK/wfwe?=
 =?us-ascii?Q?lEQz7+jMM4VoXTPygdDGMSVVlp6OC2DIBiVqchR/m5coHsilNtRNt3zdXBnK?=
 =?us-ascii?Q?dw9T5PswX/ry37sO/D0j2LT7jf9LfEkT+a4fZhPGsMM6lMqOPirll8+ejqLe?=
 =?us-ascii?Q?TWF7bLnGfPbs5ntE7eJRil0stN8Bc4mKAHso0es/hhGotz8KpmPu3z/Xfm0I?=
 =?us-ascii?Q?hYtbQ+ziP6qfcckMCArM7X8txFHJ5fLPFr4RRX1sPM2nL289ZtccO8PjMV+0?=
 =?us-ascii?Q?NX6gSk76oUPa2xewaxl+kU3QUJPUIwxlEzu43YAIF6otak+54K3k9jX26hBc?=
 =?us-ascii?Q?mCZ5T8gJC6lQ6khyUhhd7B8ZXc006Vl4Y0zb362BtaIPqXtvM1SJABBIoYIk?=
 =?us-ascii?Q?dtaDVuMd0Jq3aixlkfwh4qhBMjzZjwfxcLhe/Gb++od0c1P1cJ4WBL8SbQX8?=
 =?us-ascii?Q?aneRBw//kUB0VkJIuWwXr2qtfj+XWZmJ2q9CsicqvaW6nKbZpowAyuhffi1b?=
 =?us-ascii?Q?3wgstW3QgNEalB8Ysf7zg3i/FaSVU47Sg16ocdJVTDEi8SgSbHG+rnq8J3qu?=
 =?us-ascii?Q?l5rP0MTMZoscVs6ftNxn27x9cywCLPehHngp/SOZZrnIubaHHf6Y731Fa5r+?=
 =?us-ascii?Q?901Hxcns4NnrPk10l3Z10IfqkjIYeqiJFQOiR4UswnSUDd8qzpYnQQcelEys?=
 =?us-ascii?Q?vg1nYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:15.0363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d0cace-77b5-4392-264d-08de57f19037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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

Move 64-bit pcie indirect read/writes to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 38 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 20 ++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  9 +++--
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  4 +-
 9 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3197383f41c..29dbad0a1ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -896,8 +896,6 @@ struct amdgpu_device {
 	struct amdgpu_reg_access reg;
 	/* protects concurrent PCIE register access */
 	spinlock_t pcie_idx_lock;
-	amdgpu_rreg64_t			pcie_rreg64;
-	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
 	amdgpu_wreg64_ext_t pcie_wreg64_ext;
 	struct amdgpu_doorbell		doorbell;
@@ -1292,8 +1290,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_PCIE_PORT(reg, v) amdgpu_reg_pciep_wr32(adev, (reg), (v))
 #define RREG32_PCIE_EXT(reg) amdgpu_reg_pcie_ext_rd32(adev, (reg))
 #define WREG32_PCIE_EXT(reg, v) amdgpu_reg_pcie_ext_wr32(adev, (reg), (v))
-#define RREG64_PCIE(reg) adev->pcie_rreg64(adev, (reg))
-#define WREG64_PCIE(reg, v) adev->pcie_wreg64(adev, (reg), (v))
+#define RREG64_PCIE(reg) amdgpu_reg_pcie_rd64(adev, (reg))
+#define WREG64_PCIE(reg, v) amdgpu_reg_pcie_wr64(adev, (reg), (v))
 #define RREG64_PCIE_EXT(reg) adev->pcie_rreg64_ext(adev, (reg))
 #define WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
 #define RREG32_SMC(reg) amdgpu_reg_smc_rd32(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 69f2f9b664ae..bf576faa84b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -858,24 +858,6 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-/**
- * amdgpu_invalid_rreg64 - dummy 64 bit reg read function
- *
- * @adev: amdgpu_device pointer
- * @reg: offset of register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- * Returns the value in the register.
- */
-static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t reg)
-{
-	dev_err(adev->dev, "Invalid callback to read 64 bit register 0x%04X\n",
-		reg);
-	BUG();
-	return 0;
-}
-
 static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t reg)
 {
 	dev_err(adev->dev, "Invalid callback to read register 0x%llX\n", reg);
@@ -883,24 +865,6 @@ static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t r
 	return 0;
 }
 
-/**
- * amdgpu_invalid_wreg64 - dummy reg write function
- *
- * @adev: amdgpu_device pointer
- * @reg: offset of register
- * @v: value to write to the register
- *
- * Dummy register read function.  Used for register blocks
- * that certain asics don't have (all asics).
- */
-static void amdgpu_invalid_wreg64(struct amdgpu_device *adev, uint32_t reg, uint64_t v)
-{
-	dev_err(adev->dev,
-		"Invalid callback to write 64 bit register 0x%04X with 0x%08llX\n",
-		reg, v);
-	BUG();
-}
-
 static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg, uint64_t v)
 {
 	dev_err(adev->dev,
@@ -3759,8 +3723,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_reg_access_init(adev);
 
-	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
-	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 395f02834404..fc7c2dc458c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -63,6 +63,8 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	adev->reg.pcie.wreg = NULL;
 	adev->reg.pcie.rreg_ext = NULL;
 	adev->reg.pcie.wreg_ext = NULL;
+	adev->reg.pcie.rreg64 = NULL;
+	adev->reg.pcie.wreg64 = NULL;
 	adev->reg.pcie.port_rreg = NULL;
 	adev->reg.pcie.port_wreg = NULL;
 }
@@ -223,6 +225,24 @@ void amdgpu_reg_pcie_ext_wr32(struct amdgpu_device *adev, uint64_t reg,
 	adev->reg.pcie.wreg_ext(adev, reg, v);
 }
 
+uint64_t amdgpu_reg_pcie_rd64(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.pcie.rreg64) {
+		dev_err_once(adev->dev, "PCIE 64-bit register read not supported\n");
+		return 0;
+	}
+	return adev->reg.pcie.rreg64(adev, reg);
+}
+
+void amdgpu_reg_pcie_wr64(struct amdgpu_device *adev, uint32_t reg, uint64_t v)
+{
+	if (!adev->reg.pcie.wreg64) {
+		dev_err_once(adev->dev, "PCIE 64-bit register write not supported\n");
+		return;
+	}
+	adev->reg.pcie.wreg64(adev, reg, v);
+}
+
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg)
 {
 	if (!adev->reg.pcie.port_rreg) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 4423b872b46e..e6c0a59973c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -33,6 +33,8 @@ typedef uint32_t (*amdgpu_rreg_t)(struct amdgpu_device *, uint32_t);
 typedef void (*amdgpu_wreg_t)(struct amdgpu_device *, uint32_t, uint32_t);
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
+typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device *, uint32_t);
+typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
 
 typedef uint32_t (*amdgpu_block_rreg_t)(struct amdgpu_device *, uint32_t,
 					uint32_t);
@@ -56,6 +58,8 @@ struct amdgpu_reg_pcie_ind {
 	amdgpu_wreg_t wreg;
 	amdgpu_rreg_ext_t rreg_ext;
 	amdgpu_wreg_ext_t wreg_ext;
+	amdgpu_rreg64_t rreg64;
+	amdgpu_wreg64_t wreg64;
 	amdgpu_rreg_t port_rreg;
 	amdgpu_wreg_t port_wreg;
 };
@@ -92,13 +96,12 @@ void amdgpu_reg_pcie_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_pcie_ext_rd32(struct amdgpu_device *adev, uint64_t reg);
 void amdgpu_reg_pcie_ext_wr32(struct amdgpu_device *adev, uint64_t reg,
 			      uint32_t v);
+uint64_t amdgpu_reg_pcie_rd64(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_pcie_wr64(struct amdgpu_device *adev, uint32_t reg, uint64_t v);
 uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
 			   uint32_t v);
 
-typedef uint64_t (*amdgpu_rreg64_t)(struct amdgpu_device *, uint32_t);
-typedef void (*amdgpu_wreg64_t)(struct amdgpu_device *, uint32_t, uint64_t);
-
 typedef uint64_t (*amdgpu_rreg64_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg64_ext_t)(struct amdgpu_device *, uint64_t, uint64_t);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 302c56630bd8..7ce1a1b95606 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -637,8 +637,8 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->nbio.funcs->set_reg_remap(adev);
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
-	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
-	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
 	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c05ab38371c6..70e218ad7e18 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -965,8 +965,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->reg.pcie.rreg_ext = &amdgpu_device_indirect_rreg_ext;
 	adev->reg.pcie.wreg_ext = &amdgpu_device_indirect_wreg_ext;
-	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
-	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 	adev->reg.uvd_ctx.rreg = &soc15_uvd_ctx_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 3695fd951aa4..73a4dfa74c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -584,8 +584,8 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->nbio.funcs->set_reg_remap(adev);
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
-	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
-	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
 	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 2b2b8737ec5e..308f32daa780 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -364,8 +364,8 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->nbio.funcs->set_reg_remap(adev);
 	adev->reg.pcie.rreg = &amdgpu_device_indirect_rreg;
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
-	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
-	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
 	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index c55a402f3dba..ca6d6755dde1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -254,8 +254,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.pcie.wreg = &amdgpu_device_indirect_wreg;
 	adev->reg.pcie.rreg_ext = &amdgpu_device_indirect_rreg_ext;
 	adev->reg.pcie.wreg_ext = &amdgpu_device_indirect_wreg_ext;
-	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
-	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
+	adev->reg.pcie.rreg64 = &amdgpu_device_indirect_rreg64;
+	adev->reg.pcie.wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
 	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
-- 
2.49.0

