Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA28C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC5110E381;
	Tue, 14 May 2024 08:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrDyqs6W";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E7910E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRzSvzOSV7nvXXXxsM55w1hW26ndib2kCsgmzS7yblDmOJdCSrBtQzJjA0PB8Y+gQp3v/bFP8tILDnJEJyy/SzO5VtAswTMv+18X90mS/5CwzyTiY1xm9XxR+/CW5gHO+lcVRAOKhlcJIk9lWI1vxhOL4iRbtPe519huP2XBwOTXR+pPIns2YuG9/MWlPi1NomZa6EQC4NcbGbpxyKWnAQK09iC1yIdT5caHF3O4LEIYO15UUtsAvZ5bE+RrJ9i0l4ByFya3doPmZkN00RDsxqFjYJ8+DW6IwtyVFJrxvvEz3Slv4je9t5vA3X8Ex0rnsUOeFbnSZR0AKZWikVY2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu9IjO953YC6238QfVDuZ2HJjiUF1b9K9EKCDOTy3jk=;
 b=ao/8RQ+j028StBYqBAAD1WmZXoQYER30vXb5VJ2qs3IC7am3D2khA9Ia1/tJ/BgEtPZn+XgRRpVRAoMRNF6B+YKs84h2RPyNvDWXk9rR5H3ZcLLvY8u130mpbKgQ6oZrPgVaXMg3pR8T39cT2+NPMghHpYmocdRQCuQ7pZTXAZitj392KJxxejkgU8dMskdV0YNyGJ8u4Vz9TzaB6jEUc/OgOPYMYe6bQiVV+NIcuX8YduhagQFpiJEstivixti4CKTS8T205n+fGWYSqbdmBJ4i8kHht4pKyPOSN32vwfWH9K6glAeEnrSfdOxyQo6iY4oIjY6/+uWoVwBne7oakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu9IjO953YC6238QfVDuZ2HJjiUF1b9K9EKCDOTy3jk=;
 b=DrDyqs6WiEnRF8yiKULb2sg0F08q+qcQbMz1kZkhtwk8oNKexrJQSZQi7/1247xHfEE/hAmN5UGZszujBBs6hdxJCgAFLEcf+6doRN/bwRFhl1YtwRqwRcshrPgA/RQNDieeimRbqNefp3ttCWImIx8TuUVf6bss0ke5gA7212Y=
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 08:14:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::7f) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 08:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 08:14:56 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 03:14:55 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add debug flag to enable RAS ACA driver.
Date: Tue, 14 May 2024 16:14:44 +0800
Message-ID: <20240514081444.4095904-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c35fce-648a-4acd-d42b-08dc73edf125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PObvd8BxjGOfKRQYJdzQdRkS6ChWphF5QDrYJJTQU9bKmrjrTQMa9S4xrIpt?=
 =?us-ascii?Q?G6XYm0wO0Bgj81vn7cxsxC14FLdyZJ03CToBWMlR4e+EzlRNTu0nzUJdhk9d?=
 =?us-ascii?Q?e8/w9TvspBmYfQ7eaUsZ+u7rAGO3824llz3WimrRBWrgP/WIf4aQkk5vxcXS?=
 =?us-ascii?Q?A3HCno9Q5yTHIxe6oClmiyTB47OywKPWiXyFkdx4vnYKs16FJE/R1ql+snIg?=
 =?us-ascii?Q?rTu8fpl6aZry/K6nG9QJBIq/6tfVtnA33uWJY7b6+hXEqgBD1vI2Y1kIMGGn?=
 =?us-ascii?Q?4NTc7/dFU2gFlHbshB41/jSyLRAnhwNZ0naKpRCx7Kg1EgUeMY1ikQz22aO4?=
 =?us-ascii?Q?g207q3FvyWJ0+hd/WzZk5MN6six3xllOIEahvr14TRhosJGxXUnoSp8EsdGE?=
 =?us-ascii?Q?j0tMeEBc4v+G1AlHaYawFLhcxhiXqk9xKopIocrrVR0YeO/Nzdnl6ARBdA7V?=
 =?us-ascii?Q?APquKQ72IoTZZbsi+yMOWRSXiJAiCzeyf5jmLcSNoYwVMobDuzy3pnIlJDI1?=
 =?us-ascii?Q?A8NTXTMFrk1uVtF6F7kycFPbOaCjC6bjqR/9aE7b7z/7ifEj4M4wFDdiaid4?=
 =?us-ascii?Q?ToLPCgQ5kZxtsBiFifvy4UasVQxuhCDdg5Rvx4DIhDILzi0HVcr6CX7Gf73W?=
 =?us-ascii?Q?YGglMzaXaGB0G2h/fnRnbTeFrNhVlam6V3LVLbRYmpYDuseXIZOWj/HkYlJt?=
 =?us-ascii?Q?AwCHeeDDl1qWlNUVhBn4RoWMu9aT9ITspD8SScfxeCQZExvmfutGwpifrEhg?=
 =?us-ascii?Q?I2JLA4X0qFEHTl2fD9UAFzECYXqG1jrf5HutPsxhQcU7QvzAUb5HdOuWIQ7C?=
 =?us-ascii?Q?gy736fYukVGAi+kpF0ZDXRLrfM9M4EfDw8Q2/lUCyd96gFUiRsKfrKB6bCnI?=
 =?us-ascii?Q?QkMiIfzugKUjB2oWKkNJ9fQjZSAYkfxphRTQhwGMH5FhUbQU+MroJO7vmkN+?=
 =?us-ascii?Q?iijahxvfKa9oVuKDUT6Ni9V1/H+Aw+Iac8kKuJx+3SBo+dnLYs4ahrm07QTD?=
 =?us-ascii?Q?3iJIusl4o7HGcJCUOAR2lv9vgvaliqGWhh4OIOnuuMUbQDj2y0ykRUpul99+?=
 =?us-ascii?Q?ptfg4jOeXdbkSUcee9iTK2OoWqx9WRwGV0+l3A++LZS5SyQRiCMn/MZyxJlY?=
 =?us-ascii?Q?yK3i2m95lMGN+QR2wt48hKlGZgr4DWTj4djGAg2aKv4+L36x5RWg40uSSGOG?=
 =?us-ascii?Q?5EWERyz46T53KxPu7L9CuJ3NUL6jd49sGDdWKHGHuwO3dPQN/hy6CUhFCiLh?=
 =?us-ascii?Q?WAeQ6Nf0MTOD9Q/hxKESDbKh9UpABzDxyTyLtpXhU0Jxmm4JdOvOK1w0Mieg?=
 =?us-ascii?Q?+QlhR5TBm/SMgUyjia//8fyULJlvjZN3C7qAjY54YLeffqmMN3a9STvH6bzl?=
 =?us-ascii?Q?Bqq/EOmcp/g2Zx+HILdzecfAvqhs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 08:14:56.9374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c35fce-648a-4acd-d42b-08dc73edf125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

Use debug_mask=0x10 (BIT.4) param to help enable RAS ACA driver.
(RAS ACA is disabled by default.)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 846c3550fbda..550a42e3961f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1171,6 +1171,7 @@ struct amdgpu_device {
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
+	bool				debug_enable_ras_aca;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 987a1b4d4503..0b1b9911bd99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -686,7 +686,8 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 
 bool amdgpu_aca_is_enabled(struct amdgpu_device *adev)
 {
-	return adev->aca.is_enabled;
+	return (adev->aca.is_enabled ||
+		adev->debug_enable_ras_aca);
 }
 
 int amdgpu_aca_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index caf89d21b61c..a2de55ab3a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -129,6 +129,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_LARGEBAR = BIT(1),
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
 	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
+	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2192,6 +2193,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: place fw in vram for frontdoor loading\n");
 		adev->debug_use_vram_fw_buf = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_RAS_ACA) {
+		pr_info("debug: enable RAS ACA driver\n");
+		adev->debug_enable_ras_aca = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
-- 
2.34.1

