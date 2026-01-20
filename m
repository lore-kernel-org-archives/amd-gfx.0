Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE80D2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B9D10E561;
	Tue, 20 Jan 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSH8A/Cy";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E26E10E561
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXaQwp8x7EVaQ7/qk1fnhAGhJrTHgnJhcNA4O7NNI3hXJOfp1A6J+7+satOMopfA/ouEgPbDtAi70LotiRkBLhV5fi+ek+mGo7HQyaAvYfrrz8sUMgdsIKGIeFMISMJhWI+PLJu/SqxjX3gNW+jWtU6Cl+Dxttm/LrxiXhnMAtB8v7F3YZ0fwC8hx8loiw78d5uQp2jvFS5hn381dniIh1eJrNHDpNDsJZnI0qYfBpu9Hs/jh1cOruKIBde2sQ1XZqXsYYiK5hTbiXiSH/FDEhBOoqSxpXJvJFf+9aWNh6Ol828zATXRE7Lew2Zr9VBrXpJufAp2wGutNgHLv/D1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IETsrcMLPzh5pTZELm1xi5BGlt9hHNOf9MQoG1nxdsg=;
 b=dF70gOBxial59H5cn/watxrJy+jK/a9B+MrXO7buS7c+sFEqxf04/V8U5L1GIMNCge7P3n4uXE4d7lDoWPVmwk+xFdpFNPIrAZvmz9J4pjJmiB2z5GdsppS5yAAq9JGYP6uUonq94Hz7JjOaFifwK3G5Vmr/lU0Ot5l9gfWw21oo+1QmA09Nt1MrGo+KdUvGw3y18/EabToAOwgEdJpoDIqL+iWuQqQ91rw3iWvtCGxO7p4U8JJpAWwcbsQDt+EoRk3q0pweq/onFqOoxrKTzCZOlQ1INL55T8iYeNmtUHJxlEcsJYB0fF+OfdHJAMk+pGOVvtH8W9iTMzYJFGW3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IETsrcMLPzh5pTZELm1xi5BGlt9hHNOf9MQoG1nxdsg=;
 b=JSH8A/CyOCXlSy1F3a5XM0GZfqj5/nz+lDZ8ld4u0lTy2+LJAgaXiXzq42gQ2VYOZEVs6Ovnuu0qhyZYi1k8ru1gvb/Ci8TRQDnJmzvBy4cUbCkpTQncxaHnmKqASbpu6uiP3mrK7i9TiAB+njIPAMZbN/sTB0o8UpJGaqMkT+8=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 07:00:11 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6a) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:01 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 06/15] drm/amdgpu: Add se cac method to register block
Date: Tue, 20 Jan 2026 12:27:40 +0530
Message-ID: <20260120065931.1300054-7-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b24d22-88c0-4a67-269c-08de57f18e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMYiIT4iuhAXw6z9rHsXiOdCQKA14JhecD592vQDVdkiqvyHaq2MXvEuk1j8?=
 =?us-ascii?Q?+T+iqdZuHX3Lyvg7OtQl90t+aLZCo3W7IdNJ1pDMcbha57CMlsujVH0MYtKQ?=
 =?us-ascii?Q?peJgOy6hfV93COPIVNfLTRMj4m0dufFJYRDGQxazKx9fT5pAcT5xHXzNfIcl?=
 =?us-ascii?Q?z7A7DpYyAW3buMoJHffZMJZoBcxZhkwh2opaqV8dmNdQ6g2rjPBpKV8VlYjt?=
 =?us-ascii?Q?6KRQok4/tRDvdr1dda/7gY1NNbsY4BRNRnt/jdJvhaoJq7qP6CgAqcZbaw42?=
 =?us-ascii?Q?qsqpk83gXMMpCeOSp+Rap+yUhCV/cEjkLtRdiOKeHEImfcLkt7gGSfFLNvGF?=
 =?us-ascii?Q?mgXM4b5/dtCEQkNBUThFkmRuQ4tkQ+UWNEZoSIVDJoHFWAV04XQI89OVruUB?=
 =?us-ascii?Q?Ch4poEHHrwahL1mScAGlDfQr9o2fNvAnIfYL2RrV0jlwnzUCVUeQzF1ty5ov?=
 =?us-ascii?Q?tsdVDOMECTzyRSErK2T06Na2AOoAw6meSXYywXmtI3exibUNvbsDXMaNNeld?=
 =?us-ascii?Q?mPCyJdP/9+sQ0s57pd+SY3OlvPeipErI7afVEOGOVINQGKG6nfxXALymd/PQ?=
 =?us-ascii?Q?tkgNz8ztNl1ucZvde0F1RB8JBuX/HDozuxPXkDKe8nh9whQSytanC0NXjIZI?=
 =?us-ascii?Q?ajOtvBoMiKEZQJnsHv0T03QzAysRcbsaNsDlVbrYjiVC8Wim8Sp5Zfvbsen0?=
 =?us-ascii?Q?e8+BPD5SpZZoIj1D37xLhn4cjU2sOjXZHspk/9CqwWuuQO2gQbeNlrzaSDij?=
 =?us-ascii?Q?N2mANn20ayx1i8SqMNfSd3y6rURufcYNohVpD6LbFS7mPs5RznkRDK6irgKo?=
 =?us-ascii?Q?j8MKU0nn2o9DrQW9ASSim2uF/Pi8UjXRRooRmjhsuLkAngNGZoMR9JZL61n6?=
 =?us-ascii?Q?sYVBZVXG8+Zw3GdNNyOcYh4DMIQFzsRJSK4o1M7uWSXJig5zdpj3207Zv8k+?=
 =?us-ascii?Q?wUCtciZxhMvXCV1CkkcTHHwiR+uPq6vE1OSq9z8AXJPbf2OYZ5bzCpTxapq/?=
 =?us-ascii?Q?nrIoH5lVc0/hgIwjSMviSf44iuwlYcb+FqYiAB8XRwTY11cc/sVQIJtCA3ZY?=
 =?us-ascii?Q?89KxIkHgx8WYlRYXDd8TCzjbAiRZRq8+Msrl7ppDjENOWhGbFPtGjEC8Zqs7?=
 =?us-ascii?Q?/KXYrT2C9NPmPZUTHhVVgAZ9sLdJ6HL45iyEVAq6rXCIXd1RYk7+k7vwJzzu?=
 =?us-ascii?Q?/fdwrb0xIGMdPttsyp66s4s/+m3zhOsmrAzNSzRx5oYTqNyBSCAqlTXVv/4O?=
 =?us-ascii?Q?AKu/xTCx1ZJwFy6UzaI8PXhThwZ6hU2kUgEKT06G572CbRbS2vThZ5EWB8pO?=
 =?us-ascii?Q?/9OD3S24BrpCSlcQx2rWbmF856AN8sa4eOe9YzAFD+yBa7tJyeprXpkLIlxN?=
 =?us-ascii?Q?zLtRSCP3YM0TNxYA6gUsCcYhQhurY1IK3+msqdIRe2DlXFka4YrxIrgDOscC?=
 =?us-ascii?Q?NnYab9bN0TTPWmNqYi1xC+BdH5wQr5x8+7rONRQem8LvhzsU7zwlxVeLVcdP?=
 =?us-ascii?Q?RKhX43Yk7cbV+LXrwK5U+Rt7LTsshPsGJCwum8JTlWGa5u0eoiHfAYAPs6wp?=
 =?us-ascii?Q?3hJ1S5ha4RIlhVqEOy0TkP4gxW7XXhQCOnILesQGYa6dKUuWOux1d/sZcuQv?=
 =?us-ascii?Q?+BF3Icoa6wYeUulzIKZlI0nQ5zOV4S/8qJmD7FDHovBPjD7SfOIUlHLe6iW2?=
 =?us-ascii?Q?CxOZCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:11.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b24d22-88c0-4a67-269c-08de57f18e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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

Move se cac access callbacks to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  8 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 24 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 12 +++++-----
 5 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 95defe443a5d..4f22b7da4657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -906,10 +906,6 @@ struct amdgpu_device {
 	amdgpu_wreg64_t			pcie_wreg64;
 	amdgpu_rreg64_ext_t			pcie_rreg64_ext;
 	amdgpu_wreg64_ext_t pcie_wreg64_ext;
-	/* protects concurrent se_cac register access */
-	spinlock_t se_cac_idx_lock;
-	amdgpu_rreg_t			se_cac_rreg;
-	amdgpu_wreg_t			se_cac_wreg;
 	/* protects concurrent ENDPOINT (audio) register access */
 	spinlock_t audio_endpt_idx_lock;
 	amdgpu_block_rreg_t		audio_endpt_rreg;
@@ -1318,8 +1314,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_DIDT(reg, v) amdgpu_reg_didt_wr32(adev, (reg), (v))
 #define RREG32_GC_CAC(reg) amdgpu_reg_gc_cac_rd32(adev, (reg))
 #define WREG32_GC_CAC(reg, v) amdgpu_reg_gc_cac_wr32(adev, (reg), (v))
-#define RREG32_SE_CAC(reg) adev->se_cac_rreg(adev, (reg))
-#define WREG32_SE_CAC(reg, v) adev->se_cac_wreg(adev, (reg), (v))
+#define RREG32_SE_CAC(reg) amdgpu_reg_se_cac_rd32(adev, (reg))
+#define WREG32_SE_CAC(reg, v) amdgpu_reg_se_cac_wr32(adev, (reg), (v))
 #define RREG32_AUDIO_ENDPT(block, reg) adev->audio_endpt_rreg(adev, (block), (reg))
 #define WREG32_AUDIO_ENDPT(block, reg, v) adev->audio_endpt_wreg(adev, (block), (reg), (v))
 #define WREG32_P(reg, val, mask)				\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef4c91482061..137ddce64536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3908,7 +3908,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	spin_lock_init(&adev->mmio_idx_lock);
 	spin_lock_init(&adev->pcie_idx_lock);
-	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
 	spin_lock_init(&adev->virt.rlcg_reg_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 69db9de507c5..d75ef23581a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -50,6 +50,10 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.gc_cac.lock);
 	adev->reg.gc_cac.rreg = NULL;
 	adev->reg.gc_cac.wreg = NULL;
+
+	spin_lock_init(&adev->reg.se_cac.lock);
+	adev->reg.se_cac.rreg = NULL;
+	adev->reg.se_cac.wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -129,6 +133,26 @@ void amdgpu_reg_gc_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
 	adev->reg.gc_cac.wreg(adev, reg, v);
 }
 
+uint32_t amdgpu_reg_se_cac_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.se_cac.rreg) {
+		dev_err_once(adev->dev, "SE_CAC register read not supported\n");
+		return 0;
+	}
+	return adev->reg.se_cac.rreg(adev, reg);
+}
+
+void amdgpu_reg_se_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v)
+{
+	if (!adev->reg.se_cac.wreg) {
+		dev_err_once(adev->dev,
+			     "SE_CAC register write not supported\n");
+		return;
+	}
+	adev->reg.se_cac.wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index 3736fd571771..63929999cd76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -43,6 +43,7 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_ind uvd_ctx;
 	struct amdgpu_reg_ind didt;
 	struct amdgpu_reg_ind gc_cac;
+	struct amdgpu_reg_ind se_cac;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -55,6 +56,9 @@ void amdgpu_reg_didt_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 uint32_t amdgpu_reg_gc_cac_rd32(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_reg_gc_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
 			    uint32_t v);
+uint32_t amdgpu_reg_se_cac_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_se_cac_wr32(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 534cd336a9b6..64e47435d9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -320,10 +320,10 @@ static u32 soc15_se_cac_rreg(struct amdgpu_device *adev, u32 reg)
 	unsigned long flags;
 	u32 r;
 
-	spin_lock_irqsave(&adev->se_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.se_cac.lock, flags);
 	WREG32_SOC15(GC, 0, mmSE_CAC_IND_INDEX, (reg));
 	r = RREG32_SOC15(GC, 0, mmSE_CAC_IND_DATA);
-	spin_unlock_irqrestore(&adev->se_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.se_cac.lock, flags);
 	return r;
 }
 
@@ -331,10 +331,10 @@ static void soc15_se_cac_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->se_cac_idx_lock, flags);
+	spin_lock_irqsave(&adev->reg.se_cac.lock, flags);
 	WREG32_SOC15(GC, 0, mmSE_CAC_IND_INDEX, (reg));
 	WREG32_SOC15(GC, 0, mmSE_CAC_IND_DATA, (v));
-	spin_unlock_irqrestore(&adev->se_cac_idx_lock, flags);
+	spin_unlock_irqrestore(&adev->reg.se_cac.lock, flags);
 }
 
 static u32 soc15_get_config_memsize(struct amdgpu_device *adev)
@@ -975,8 +975,8 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.didt.wreg = &soc15_didt_wreg;
 	adev->reg.gc_cac.rreg = &soc15_gc_cac_rreg;
 	adev->reg.gc_cac.wreg = &soc15_gc_cac_wreg;
-	adev->se_cac_rreg = &soc15_se_cac_rreg;
-	adev->se_cac_wreg = &soc15_se_cac_wreg;
+	adev->reg.se_cac.rreg = &soc15_se_cac_rreg;
+	adev->reg.se_cac.wreg = &soc15_se_cac_wreg;
 
 	adev->rev_id = amdgpu_device_get_rev_id(adev);
 	adev->external_rev_id = 0xFF;
-- 
2.49.0

