Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359BDC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 16:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1D410E3CA;
	Fri, 26 Jun 2026 16:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQxRmDEa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACD010E3CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 16:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOMl8sLC/yMJWW6lMbrxT9sMQ9LG4lrjcbOzhdS3vwEdfywYJJh3BNCpu8C9QYG9rphY0vLHRZD+sZmRynQBr0uiQW9r6mOXRL0VA4TrUcLPAnQq2P8rx5U4nHwsCKlecPCg7q/gFIqamNxjxBlNoOQYpdguOevsA37Bfq57HvypoklTZEi67du9ULTPkgu6nv2EKJIT4nAsDE7agOY16Dfro+reZ3i09ddaIW55gaw1RukXAbeELVHVVnK3r8APCqdn4P8NjOOQ0f8mbMhMR8Sr8KDhbI7unIT7i4klsyE4e2gxUdAMiTP6U+uWbGh+5+ZGqyYHzGlDwHkvNDLmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CTVUeTUeJj9xqKFWrCScyyx+2fgBsgCEIq34SGZhGQ=;
 b=Oy73dF5zgFxBXZ0xieH7R2Z1mz4fzl/BsWAvPt5mxO9N672zUEtaQ2GlA6fbVlWdie7OCHf+kr6RvIn+YJB7E5k1jDPTzMtXmIPs2grAvJsO5p7cXvFH0BOQ8qbS2jW9hRUS0FA35OF53XhNQ1PySCwImQp6bPEw+wi2MlEnpewqvQ7lPymXBkp9kESmJTOlw/xUj6DrCfwTI5NJkkwJclkFNBE0POZkraFfsMEnQyiPh5RjG/TA3QWKgkFF60sbX4tjKa0RPRRuYckSLzDw08V2PxMpknxfTqPqmD2Cn2q0EH//GOk1Qa2cPjljBYdIpRUR/FffF/2TqBK6J3FQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CTVUeTUeJj9xqKFWrCScyyx+2fgBsgCEIq34SGZhGQ=;
 b=yQxRmDEa9yZENIvLVDn96WbiU8hQelr1gabEA9MzmgxKPpc6UKhkCwYIGccimqccSWt5gpp2EhEXmTGzLX4pX4+nvEIej+68n6OrVWXt6GBeKt7t67SUBm4qsVQa2prNF41BYkUy19OLSi3p6cc4YN+xbJxhzrJbbls87MMd04k=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Fri, 26 Jun
 2026 16:42:23 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::54) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.7 via Frontend Transport; Fri, 26
 Jun 2026 16:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 16:42:23 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 26 Jun 2026 11:42:22 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <kent.russell@amd.com>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kernel panic during driver load failure
Date: Fri, 26 Jun 2026 12:42:11 -0400
Message-ID: <20260626164211.2394095-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f0a68e-a274-492f-12fb-08ded3a1e5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: xyFLtRhCzaxTyaQn5xacXT28jjMD5HGj0cAb4sMrmBfUVGAEeVZzkhtkt1+AE0cxLAmznu28qnrbuVH3oKRox3LrF93Y6RcuqEwOQFpZ+OXqOuVb/OsTWj2OGa18eGGzvPYx2Xvg+wxjJSpJcnjDALOOcYehm/OkoHKDDbGVkybnYMwJCwFCjwvfLyEwZqRqulhvSIpKz6ntnOt9XsieVy6/iqR2LVkP9BuUF/1novXsWiHJtP5L0+Q2s3186En0xHPiwXZI6A/Av0HNPGml3iZrm+ZcFIoU1k7S5leWIqGlvaqNVaovrZsoCsbAy4mkK3z81Te33pVD64kHIpv5OxnV7tnpujjT/o2y/Uh1dZwkR7rtfz+IH4RDWTRpWaN6i/U+DV8jhCK5++J6eegIAAVNslRtvP0pMV2aqiMP2hAvrawd4Y2jydTuBBMJPp/zX03IwP7mRhU7T4yuG7JUY3AapLOuSNuImyFUvJ1fbp9Zc4aj7GYQayiUcDgXcDdH4vcvnTh+lmvBqJtNLFm0rTA3FsVxyHBDA8ZIhFAkmzVt7fvb3/SxZGIhClj/n8aHsFIdnD/BTuaP0gcOUlgyJeS5fxVDm1odmxMCLv5D01GhdHfD1akA5DHga5bx3q3rWhLgHxx+e0CukUxhadHADv0dtERUgfIjyJFafa2oW3Cs1vWQ9RnBVPgVesSzxx11IDpZvJmjCBf0usw6phU0QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EEq4SLlc/Kovfp4zxSh7X2YviJt+C9zvBukIU+mYeV/ZpXam6mABMHtq9s7pjAdDd7wch7chfjdfvyt4nZ3528RA2Yyj9hGNnf7N0ONDyjUec4DjpAZEiejpi76QH+52GBSNIP2IgRYQNorxj5Tj6us5rGgcVqrHSAZ9kycZapGD8P0YuT9C47QhWp3DuH3w3uMACghiKV6CFL89dQhpCgfVCiNv9dZLW0IcSRsWOVXX+RIzh9yngQ8SYPoGjpAuUqGrGxKKS5IlUi3Tiwe4/dxZvaTAru+pAfouaDlgLroThwbgeNrbr+30haCQ3DoGie2At8egDNg8Uj1C4BIid4YRhUiF8Wvhpr093mlaOeCY+VtY09yF9JqG7iwN2v0WHwVeFMEROxizMF2Rea6PbOqrw5MPE32eqIGSgJKyT3bBKiBpkL7QIa2sZ5G/Xxf7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:42:23.0710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f0a68e-a274-492f-12fb-08ded3a1e5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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

Avoid kernel panic if MES init fails during driver load. The KIQ ring is
falsely marked as ready as ASICs that use MES, KIQ is owned by MES.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:gfx_v12_1_wait_reg_mem+0x5a/0x1f0 [amdgpu]
Call Trace:
 gfx_v12_1_ring_emit_reg_write_reg_wait+0x1f/0x30 [amdgpu]
 amdgpu_gmc_fw_reg_write_reg_wait+0xb2/0x190 [amdgpu]
 amdgpu_gmc_flush_gpu_tlb+0x1cc/0x230 [amdgpu]
 amdgpu_gart_invalidate_tlb+0x81/0xa0 [amdgpu]
 amdgpu_gart_unbind+0x72/0x90 [amdgpu]
 amdgpu_ttm_backend_unbind+0xa4/0xb0 [amdgpu]
 amdgpu_ttm_tt_unpopulate+0x13/0xd0 [amdgpu]
 amdttm_tt_unpopulate+0x29/0x70 [amdttm]
 ttm_bo_put+0x1eb/0x360 [amdttm]
 amdgpu_bo_free_kernel+0xf9/0x1f0 [amdgpu]
 amdgpu_ih_ring_fini+0x5a/0x90 [amdgpu]
 amdgpu_irq_fini_hw+0x58/0x80 [amdgpu]
 amdgpu_device_fini_hw+0x4e0/0x5b0 [amdgpu]
 amdgpu_driver_load_kms+0x60/0xa0 [amdgpu]
 amdgpu_pci_probe+0x28e/0x6d0 [amdgpu]
 pci_device_probe+0x19f/0x220
 really_probe+0x1ed/0x340
 driver_probe_device+0x1e/0x80
 __driver_attach+0xd3/0x1a0
 bus_for_each_dev+0x68/0xa0
 bus_add_driver+0x19f/0x270
 driver_register+0x5d/0xf0
 do_one_initcall+0xac/0x200
 do_init_module+0x1ec/0x280
 __se_sys_finit_module+0x2de/0x310
 do_syscall_64+0x6a/0x250
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cd6c1b6f8894..c765af54669c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3524,10 +3524,19 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 		gfx_v12_0_cp_gfx_enable(adev, true);
 	}
 
-	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
 		r = amdgpu_mes_kiq_hw_init(adev, 0);
-	else
+		/*
+		 * With MES, GFX KIQ ring is owned by the MES and is never
+		 * initialized/used directly by the driver, so it must
+		 * not be left flagged as ready. mes_v12_0_hw_init() clears
+		 * but clear here if MES init fails
+		*/
+		if (r)
+			adev->gfx.kiq[0].ring.sched.ready = false;
+	} else {
 		r = gfx_v12_0_kiq_resume(adev);
+	}
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index aaa8f4212a15..e87f1baf5cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2549,10 +2549,19 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 
 		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
 
-		if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+		if (adev->enable_mes_kiq && adev->mes.kiq_hw_init) {
 			r = amdgpu_mes_kiq_hw_init(adev, xcc_id);
-		else
+			/*
+			 * With MES, GFX KIQ ring is owned by the MES and is never
+			 * initialized/used directly by the driver, so it must
+			 * not be left flagged as ready. mes_v12_0_hw_init() clears
+			 * but clear here if MES init fails
+			 */
+			if (r)
+				adev->gfx.kiq[xcc_id].ring.sched.ready = false;
+		} else {
 			r = gfx_v12_1_xcc_kiq_resume(adev, xcc_id);
+		}
 		if (r)
 			return r;
 
-- 
2.43.0

