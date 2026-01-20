Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E0D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289BC10E559;
	Tue, 20 Jan 2026 07:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cTHkN9Vd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 635EF10E559
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EooPwi8ZH8rq8QfMbAdF4x3Kp5xYiDzXxKReCbhPSnDGfcdNblTYfag/xkOi+UcXajzsP55Hg33EMcDTc4eWo66LLpEHrXfGPa9ZYt8xAFAOyF2g91CPZHBCxDs1iO18dh9Dh2NOIm3ryHcmbBs38cue1YXWOPvinq8BiArbCbu6G3sEUNSlwRxkpnvDahJ4o+KtdfUQFS6JyXyFR19wz6QZAnT2DSC+dOSMpLTnGVHo98D6ICl5b7tYsvPuIp1jmMdt2+5mG/sL9zmq86R8JJ8EqBPbPA5PniyeR/mqZNeLe//JKwjM7npClRv34JVzFdF7W+FvzUDX9C+g1b5wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i670h0hh7Jwxe9YE8dPneGO9+9pgHH+fem8Q/bM9pdw=;
 b=Zw0QkE61FFO2en9S9TCxgBjAAj9akGsaPjUE/dIEw9XMwsEJ+JVQ5q35lpWwnh/B6Xa1YNTdz+xz/A7WcjRD2H6ojjxzALiwGcF+nedH0GMmRvf/d4vy142FbklSq+6ZKjNzB8JfQmfJ2l3N2JQ52+Bqf1+VezUG3FCWjDTnqIzAJxpp77IpMOP2yne1yl14f3O3WKWRUviC+Pl7ADabbbACebF/OhcpWNpJo0Qg/74trCvhDpOfFHpJP7SMRT7cALQgBp0q2aKMkx3BzRElD/qoei5B6nmlzSCqQ+8TdOYvJ0+WhA4kwB0OiFOxO5LD1HRwGmhxJluQXxfBSrEYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i670h0hh7Jwxe9YE8dPneGO9+9pgHH+fem8Q/bM9pdw=;
 b=cTHkN9Vd868RfGgsMNr/WFVwwnHbcVSax1hiEjvfmhnfU2ajf3xR5KpB0xeMqN2AWu0zqqFgzV7uQPSeT3LPjg7kYmoqdzK6kIDiUf9E8WxjcL1Rf2s3m0+oXThrlI5dI8BwGsVMQWXN/u+A69ajXl7FzdudJ3srOAe6kI9qkc8=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:59:58 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8b) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 06:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:59:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 03/15] drm/amdgpu: Add uvd indirect to register block
Date: Tue, 20 Jan 2026 12:27:37 +0530
Message-ID: <20260120065931.1300054-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 936d0459-7f51-4bd3-6953-08de57f18658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJU5i6dYHcmq1vLvLyp6IMeI4S0rdyjjJ4gTxRceX+bJm2pDJK7f6fENYyYe?=
 =?us-ascii?Q?u9R5fL+IXnnYnYBHPzFQr+3wdStRj9kDn1J2wlony2ULn57JZSWl8sNEblup?=
 =?us-ascii?Q?BsgLOcTpIyTlqsznh8Z4HkyxC2PV9JqSa60CK9RcwpJlA5KIUmw7V+29d+AA?=
 =?us-ascii?Q?cHHr8mqN5aJdoHTAPcspa1+mresfYwfLhvb+nldDwJwj7JysDEV3WauG0ud0?=
 =?us-ascii?Q?QGQTBEN0fe4S8LF3auVj9EgEW/iOE2xzwSw2m+B0qgGiVF6efglT5BzxI5yK?=
 =?us-ascii?Q?lPcklZfCwYozmPSD8L6jO6dgTugGhXZhgupnoBNS/HyZXFmM19kfMedn4IpG?=
 =?us-ascii?Q?V+EmhshQsd5PQYC460boFh0sx7Wstly5qpcFJ6gB/3gMInZmvNr0J44WUQog?=
 =?us-ascii?Q?zMo+C4Nrt3CgaY8v3mAY5+GHhjejGXlyjHJHpzkC3359B/U7JGDV8v3aA7zk?=
 =?us-ascii?Q?uxI5cYz9g/TUwnRb7GJ0s2qR9PgBePnDeCE7LqxHp93/pykJ6bAmMh7vmp+p?=
 =?us-ascii?Q?zaL8QHEydM6Xkix3N8jsZUq7QB0tOKa5KDsnFq3yTuqA2rhLFy41lGmPsu1b?=
 =?us-ascii?Q?Q5BnL1ygN68HMNDzweSEKnaq31RrRn2dwRHcek6t4L+7gXUtWx52KG0jS/nG?=
 =?us-ascii?Q?wv4AKfCOlCi1Xec3ByYwQJ7Fiz/byrVEl232msXbhmmjeVphiCD+q2dVI+mb?=
 =?us-ascii?Q?GVZ0GN9ZVm7EJ7oHzjspLEkBa2PXyElCjpjhO+smk3EYXSHSaDuF3lxlSjqN?=
 =?us-ascii?Q?SvL1yme5s5JFkbQYWhWIetdkJ5LtwyoCqdoF+DCrRXubfP6vnIUiRSlSaZq2?=
 =?us-ascii?Q?gnIL7T4a+9Pe+VjKjRj8PESAf+41XY2OdIWvu07HlVB5bwxcdtV5uTYXaxbk?=
 =?us-ascii?Q?Ks+8MRY5ZHq0+5422GjFFMbeOtHRse2ZZzplu7jawN4Jm+VNJh2F5KLvFV6j?=
 =?us-ascii?Q?+8B/ZmXQVk7UfgUKYNeeVJFh0czuQpFeo5d3Bj04rH3450lSFnN+0b9OcqqM?=
 =?us-ascii?Q?ED4gJvn/b0IwdnwNiTKB4GUYxhqMvzeiY+s91aNBKffbG93xU82zWYDhkac7?=
 =?us-ascii?Q?7/9jBwjDQszzDKeREvs56X+7Ay9qPNv6F/pdvt/vymc1v4MWEWyl++glH+Oz?=
 =?us-ascii?Q?QpRYhUkGCyWvzPH8EO9fJVV4AcguIdfcSQFPlLJbV+WyLRQDlZnAaOB+IOKR?=
 =?us-ascii?Q?7EwQnFXrlRglBKf25NUiRpRhXuUQnJ8Ufsff3vqa+QsYtZ4ok+pjX5tptDZW?=
 =?us-ascii?Q?flobtpcte7TrmNs5out1Jfvn8JFzB4+XEyqIVb7LmEjmpE2tEVA6GKQkcJdp?=
 =?us-ascii?Q?z4cZX4qe5XmP/zkGuCnyOXlgSE828VfdTpj3M9vRdGEt8BbPJZELagi1QNex?=
 =?us-ascii?Q?Omj/ZH/uUqassxn4EXhxhnK2wLMzTeQlkAHOkVbLi4EUJ7C0jZJmXbdAafEb?=
 =?us-ascii?Q?19YMq3bPoLsxdHD6W0ArOXN1d/9UJ3jEnPzqQMfVURCXNVnZxsTq3iHbmsTz?=
 =?us-ascii?Q?hoAGnkXscM4xpGyPAeQc+1J8qWe12aKzBZ1QejFlD1svKpxkT9e7VX3BA9z5?=
 =?us-ascii?Q?sD6UTTCncUGqoOmHQDeoHBqp1HiplIrezKBlwWue6JaiGIuzdRW06I/2wPeB?=
 =?us-ascii?Q?Ub5Ds3w0kPZrYCO6zaSioZuYlv4HEtd2c5Lx65RUjOfBmhNi02DJA+U3Zgog?=
 =?us-ascii?Q?CL/iXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:59:58.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936d0459-7f51-4bd3-6953-08de57f18658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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

Add uvd indirect method to register access block and replace the
existing calls from adev.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 ---
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/cik.c              | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 ---
 drivers/gpu/drm/amd/amdgpu/si.c               | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 ---
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  2 --
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/vi.c               | 12 ++++-----
 12 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9de738600a64..b2b250308cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -905,11 +905,7 @@ struct amdgpu_device {
 	amdgpu_rreg64_t			pcie_rreg64;
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
-	amdgpu_wreg64_ext_t			pcie_wreg64_ext;
-	/* protects concurrent UVD register access */
-	spinlock_t uvd_ctx_idx_lock;
-	amdgpu_rreg_t			uvd_ctx_rreg;
-	amdgpu_wreg_t			uvd_ctx_wreg;
+	amdgpu_wreg64_ext_t pcie_wreg64_ext;
 	/* protects concurrent DIDT register access */
 	spinlock_t didt_idx_lock;
 	amdgpu_rreg_t			didt_rreg;
@@ -1324,8 +1320,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG64_PCIE_EXT(reg, v) adev->pcie_wreg64_ext(adev, (reg), (v))
 #define RREG32_SMC(reg) amdgpu_reg_smc_rd32(adev, (reg))
 #define WREG32_SMC(reg, v) amdgpu_reg_smc_wr32(adev, (reg), (v))
-#define RREG32_UVD_CTX(reg) adev->uvd_ctx_rreg(adev, (reg))
-#define WREG32_UVD_CTX(reg, v) adev->uvd_ctx_wreg(adev, (reg), (v))
+#define RREG32_UVD_CTX(reg) amdgpu_reg_uvd_ctx_rd32(adev, (reg))
+#define WREG32_UVD_CTX(reg, v) amdgpu_reg_uvd_ctx_wr32(adev, (reg), (v))
 #define RREG32_DIDT(reg) adev->didt_rreg(adev, (reg))
 #define WREG32_DIDT(reg, v) adev->didt_wreg(adev, (reg), (v))
 #define RREG32_GC_CAC(reg) adev->gc_cac_rreg(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 10ab72a12ec2..649c79acbbd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3861,8 +3861,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_invalid_wreg64_ext;
-	adev->uvd_ctx_rreg = &amdgpu_invalid_rreg;
-	adev->uvd_ctx_wreg = &amdgpu_invalid_wreg;
 	adev->didt_rreg = &amdgpu_invalid_rreg;
 	adev->didt_wreg = &amdgpu_invalid_wreg;
 	adev->gc_cac_rreg = &amdgpu_invalid_rreg;
@@ -3914,7 +3912,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->mmio_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
-	spin_lock_init(&adev->uvd_ctx_idx_lock);
 	spin_lock_init(&adev->didt_idx_lock);
 	spin_lock_init(&adev->gc_cac_idx_lock);
 	spin_lock_init(&adev->se_cac_idx_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 5debc5c39101..1f5d6be9a0fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -38,6 +38,10 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.smc.lock);
 	adev->reg.smc.rreg = NULL;
 	adev->reg.smc.wreg = NULL;
+
+	spin_lock_init(&adev->reg.uvd_ctx.lock);
+	adev->reg.uvd_ctx.rreg = NULL;
+	adev->reg.uvd_ctx.wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -58,6 +62,27 @@ void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 	adev->reg.smc.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_uvd_ctx_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.uvd_ctx.rreg) {
+		dev_err_once(adev->dev,
+			     "UVD_CTX register read not supported\n");
+		return 0;
+	}
+	return adev->reg.uvd_ctx.rreg(adev, reg);
+}
+
+void amdgpu_reg_uvd_ctx_wr32(struct amdgpu_device *adev, uint32_t reg,
+			     uint32_t v)
+{
+	if (!adev->reg.uvd_ctx.wreg) {
+		dev_err_once(adev->dev,
+			     "UVD_CTX register write not supported\n");
+		return;
+	}
+	adev->reg.uvd_ctx.wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 225d89eabed5..0d66a13c8d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -40,11 +40,14 @@ struct amdgpu_reg_ind {
 
 struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
+	struct amdgpu_reg_ind uvd_ctx;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_smc_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_uvd_ctx_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_uvd_ctx_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index cd5cd5da4d47..342a496b6020 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -201,10 +201,10 @@ static u32 cik_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	r = RREG32(mmUVD_CTX_DATA);
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 	return r;
 }
 
@@ -212,10 +212,10 @@ static void cik_uvd_ctx_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	WREG32(mmUVD_CTX_DATA, (v));
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 }
 
 static u32 cik_didt_rreg(struct amdgpu_device *adev, u32 reg)
@@ -1988,8 +1988,8 @@ static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.smc.wreg = cik_smc_wreg;
 	adev->pcie_rreg = &cik_pcie_rreg;
 	adev->pcie_wreg = &cik_pcie_wreg;
-	adev->uvd_ctx_rreg = &cik_uvd_ctx_rreg;
-	adev->uvd_ctx_wreg = &cik_uvd_ctx_wreg;
+	adev->reg.uvd_ctx.rreg = &cik_uvd_ctx_rreg;
+	adev->reg.uvd_ctx.wreg = &cik_uvd_ctx_wreg;
 	adev->didt_rreg = &cik_didt_rreg;
 	adev->didt_wreg = &cik_didt_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2e7cd27e45c9..d0bc2dcd3066 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -642,10 +642,6 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
-	/* TODO: will add them during VCN v2 implementation */
-	adev->uvd_ctx_rreg = NULL;
-	adev->uvd_ctx_wreg = NULL;
-
 	adev->didt_rreg = &nv_didt_rreg;
 	adev->didt_wreg = &nv_didt_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index cbdf8a1c6511..bbf352ce8a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1099,10 +1099,10 @@ static u32 si_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	r = RREG32(mmUVD_CTX_DATA);
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 	return r;
 }
 
@@ -1110,10 +1110,10 @@ static void si_uvd_ctx_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	WREG32(mmUVD_CTX_DATA, (v));
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 }
 
 static struct amdgpu_allowed_register_entry si_allowed_read_registers[] = {
@@ -2043,8 +2043,8 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &si_pcie_wreg;
 	adev->pciep_rreg = &si_pciep_rreg;
 	adev->pciep_wreg = &si_pciep_wreg;
-	adev->uvd_ctx_rreg = si_uvd_ctx_rreg;
-	adev->uvd_ctx_wreg = si_uvd_ctx_wreg;
+	adev->reg.uvd_ctx.rreg = &si_uvd_ctx_rreg;
+	adev->reg.uvd_ctx.wreg = &si_uvd_ctx_wreg;
 	adev->didt_rreg = NULL;
 	adev->didt_wreg = NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e310b7c8bf1e..72b5cab002d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -245,10 +245,10 @@ static u32 soc15_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
 	address = SOC15_REG_OFFSET(UVD, 0, mmUVD_CTX_INDEX);
 	data = SOC15_REG_OFFSET(UVD, 0, mmUVD_CTX_DATA);
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(address, ((reg) & 0x1ff));
 	r = RREG32(data);
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 	return r;
 }
 
@@ -259,10 +259,10 @@ static void soc15_uvd_ctx_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 	address = SOC15_REG_OFFSET(UVD, 0, mmUVD_CTX_INDEX);
 	data = SOC15_REG_OFFSET(UVD, 0, mmUVD_CTX_DATA);
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(address, ((reg) & 0x1ff));
 	WREG32(data, (v));
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 }
 
 static u32 soc15_didt_rreg(struct amdgpu_device *adev, u32 reg)
@@ -969,8 +969,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
-	adev->uvd_ctx_rreg = &soc15_uvd_ctx_rreg;
-	adev->uvd_ctx_wreg = &soc15_uvd_ctx_wreg;
+	adev->reg.uvd_ctx.rreg = &soc15_uvd_ctx_rreg;
+	adev->reg.uvd_ctx.wreg = &soc15_uvd_ctx_wreg;
 	adev->didt_rreg = &soc15_didt_rreg;
 	adev->didt_wreg = &soc15_didt_wreg;
 	adev->gc_cac_rreg = &soc15_gc_cac_rreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9d683ab74c41..ddf4c422905c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -589,10 +589,6 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 
-	/* TODO: will add them during VCN v2 implementation */
-	adev->uvd_ctx_rreg = NULL;
-	adev->uvd_ctx_wreg = NULL;
-
 	adev->didt_rreg = &soc21_didt_rreg;
 	adev->didt_wreg = &soc21_didt_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 867cc4fdc98f..d4f3df165090 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -368,8 +368,6 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
 	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
-	adev->uvd_ctx_rreg = NULL;
-	adev->uvd_ctx_wreg = NULL;
 	adev->didt_rreg = NULL;
 	adev->didt_wreg = NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index f8a49424adeb..6439b09656bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -260,8 +260,6 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
-	adev->uvd_ctx_rreg = NULL;
-	adev->uvd_ctx_wreg = NULL;
 	adev->didt_rreg = NULL;
 	adev->didt_wreg = NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 925cc275fe84..7d3b331d9217 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -372,10 +372,10 @@ static u32 vi_uvd_ctx_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	r = RREG32(mmUVD_CTX_DATA);
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 	return r;
 }
 
@@ -383,10 +383,10 @@ static void vi_uvd_ctx_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->uvd_ctx_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.uvd_ctx.lock, flags);
 	WREG32(mmUVD_CTX_INDEX, ((reg) & 0x1ff));
 	WREG32(mmUVD_CTX_DATA, (v));
-	spin_unlock_irqrestore(&adev->uvd_ctx_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.uvd_ctx.lock, flags);
 }
 
 static u32 vi_didt_rreg(struct amdgpu_device *adev, u32 reg)
@@ -1462,8 +1462,8 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
 	}
 	adev->pcie_rreg = &vi_pcie_rreg;
 	adev->pcie_wreg = &vi_pcie_wreg;
-	adev->uvd_ctx_rreg = &vi_uvd_ctx_rreg;
-	adev->uvd_ctx_wreg = &vi_uvd_ctx_wreg;
+	adev->reg.uvd_ctx.rreg = &vi_uvd_ctx_rreg;
+	adev->reg.uvd_ctx.wreg = &vi_uvd_ctx_wreg;
 	adev->didt_rreg = &vi_didt_rreg;
 	adev->didt_wreg = &vi_didt_wreg;
 	adev->gc_cac_rreg = &vi_gc_cac_rreg;
-- 
2.49.0

