Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75986C88E58
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D612310F6AA;
	Fri, 11 Sep 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxnVPjgZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD14310F69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUqPAZhAntAs88NSjxUK1MQ3MaFjyiExwCUW7P33NXvbjXSwXScEzC5iYWAxV3znj3A/ALJtj+fgZL9oZ5lXXmgDA3GwYRzdDQGipPqpXQMzUpc+0jst7EP8E6CegPFm+BiwIvxXAjS8NGfYcOi2pj1PV7Mb9yEg3X76DJv3c3xgaZH5eF/fHLxn/8MG3UpoH1XQVJ/6keu0zhecnoIeoYYVyXluf5E7/N3Dyv7VIqTu4cRNJ+Q4+xDTEBW9W4eTa2NhLTKEGvlt1at9yBbWM/HWdLCunoFyvVEhLKXpUu3+D+AarpNEdjPCJToI6Nz3eIos9oWqmmT4pUGJehnn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jivYjk4DE129D45wHl1Gpj4BpKUqqcwfj1nPGwnGSoM=;
 b=jfzeJGW3BzCSf/OMbihpwrzsW1hmykGX5/GGBTf1MqJ18QMySjr/gMDud3meOIKrHvLqmEv3PLtrO4EfljalpNqKEwhWdImNM+Z0sjR/HCst8EU0QDyoNsz2EF1DoWaa6Wei2Ua1IzirYD6sWXtJQjSRFSC/dydA88WfP12Co8gTLVwrqM/jtv5AEfz3XTTrRjOTHglrW5oU+20vi0+1Bb+qDHju6hYyhG4IsXHv2o4uzN3wX2k/zfMutwXzAfHAvnOFL/v9RuSbgSwygoz1d3/9lindJpmt7QE2WTcdLJWX0C6ZUAz4euhMmwFEemzSV0E3aaQucJ0WyYDASUaN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jivYjk4DE129D45wHl1Gpj4BpKUqqcwfj1nPGwnGSoM=;
 b=HxnVPjgZ4ftJU8sLj8UHPrEA+QhTMtRqcWqNf/L97pTXFWMCho+wA4w/0YZx6JZsWhjV+nXXsTvxM9SES6iI14VrVNDuHQErVRNn32wVwVWt2wkLdx9GIdLazUzw14pDPPGYCwqIbClSsACxLXkjLeAvldynwTxCwfD9bOvZWOk=
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by EAYPR12MB999180.namprd12.prod.outlook.com (2603:10b6:303:2c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:10 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::48) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/23] drm/amdgpu/gmc: add new callback to lookup vmid to
 pasid mapping
Date: Fri, 11 Sep 2026 13:55:35 -0400
Message-ID: <20260911175544.1314467-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|EAYPR12MB999180:EE_
X-MS-Office365-Filtering-Correlation-Id: c457a96e-ad61-4502-5636-08df102df65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: emSQoh+NHl8PoqVyjWpLE+7cIW6uKZO1qVjOhqcG826FPrzhKQNo1NaOe9BN731JSb7vMiZcWLyXuyVnc7tBxFtrAvis8PPbsffxhFN1sEZw4O3sru7WluddHULqnWuZc8htuSgFuKDwud+do8oGzgKzgeB5IzagU1DlaHXAAiQjeKhOsY4mxCTA8/UQN/8vfaqRLqeiuda7AvQEHiQ7CEsNESdwf0176dOyF4+eSDeyQS/u7HDU71cvA3bbLZWpHyQRmtY4fk6/KbByVdHmJ+eWDftZ4i2O+4RK2lPMNxjR9fM7yMYxfzzO5ye/s9rX9t5xwB6Nbi10alzluSs5Tf+LyW9643WpK1Kc3EOrWmURHTivBFQB8igb21eQnI1pIzs5pYLOp/2kyWtFU4U7pBQTiV/gsZMPnI6sc+Gzqo2ZBcCuGfvwkbhrgA41Iy3JCtIY3IdqOh3nhTj1KJDTPYxnGVpnjh5LKvwVt82v/wlTSdtvYTql1o43SfRuktkb7Xf7W+X9KqrjGVAv2H4iiisFnXAGHX+ufJS7inEpPbc897Xu4WnvN0jKG7bVCHZO9rJ1ljEJ3sAk5qUxH8NevEqluix7ICvJkrEGDweSo/fgR6W0WriVh+bbqcocCFAXyTqZeU3rU3UEoy3tkjbzb2IGoiBtzISV8anB3dHreVJu+6FczLq2FKsQfjjqHear83sigqpxIy3pd/gGO7pdRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: onHEf3gYtKAE4KyLrYZUU1JWJU+iUxrGeROtOXc9i46nx84O0kOqECNuj6kiDnX6pr1Y8ZeauxVlWevjTsL6VuS1+dDjkTjti1peDMTS6KXLc8q+HXRvh1eh3ApzlTOYzgvFyXib2G/nOEPWBRxC65O4VlaenQutYAHhwwdmDn1DwOPBFc/j1Yl5JeVp5nmx3akjYeBB+WV9affKisI9EVgbWjD/QcaQXwlR78V0fKZxg3QDlkbd3aFL5rJLczfRHocwTS3ZaSRpMtyR8Fztm8sMhbVeBu6SE6CRSaZjoOUquAFJYByDZEXUlPsnzy3iwcWvqIhXfMkQOQU5OCnhqQCPo20B0YeVcfiIXZvvfp1EmR9QKXN9IYA1mhO0eXOuv1Su+V8A1dD/VuhrlXjeHnkvMVsZaymyDW7vbY3/tmLBwpV1oHkNqqEa41JyHxS7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:10.2206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c457a96e-ad61-4502-5636-08df102df65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999180
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

Look up the mapping so we know which vmid to flush.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 ++++--
 6 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 55b696b85d544..bbd52028a775f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -174,6 +174,10 @@ struct amdgpu_gmc_funcs {
 	/* Change the VMID -> PASID mapping */
 	void (*emit_pasid_mapping)(struct amdgpu_ring *ring, unsigned vmid,
 				   unsigned pasid);
+	/* look up the vmids for the pasid */
+	bool (*get_vmid_pasid_mapping_info)(struct amdgpu_device *adev,
+					    uint8_t vmid, uint8_t inst,
+					    uint16_t *p_pasid);
 	/* enable/disable PRT support */
 	void (*set_prt)(struct amdgpu_device *adev, bool enable);
 	/* get the pde for a given mc addr */
@@ -385,7 +389,8 @@ struct amdgpu_gmc {
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
-#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
+#define amdgpu_gmc_get_vmid_pasid_mapping_info(adev, v, i, p) (adev)->gmc.gmc_funcs->get_vmid_pasid_mapping_info((a), (v), (i), (p))
+#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags)	\
 	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
 					   (pte_flags)))
 #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 4f287e9118893..d1fdebaad488f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -204,7 +204,8 @@ static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	uint32_t value;
 
@@ -346,7 +347,7 @@ static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		bool valid;
 
-		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid, 0,
 								  &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -555,6 +556,7 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v10_0_get_atc_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
 	.get_vm_pte = gmc_v10_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f7aae39f2d1b9..715fe442ccee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -203,7 +203,8 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -341,7 +342,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -549,6 +550,7 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 6e2168794d31c..17766b7ce8c45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -199,7 +199,8 @@ static bool gmc_v12_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -377,7 +378,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -584,6 +585,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 3349e8bc1c206..efb8e0c15c968 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -757,6 +757,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_1_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cae11bd1c754a..9367282d7a5ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -727,7 +727,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 }
 
 static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+						     uint8_t vmid, uint8_t inst,
+						     uint16_t *p_pasid)
 {
 	uint32_t value;
 
@@ -889,7 +890,7 @@ static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		bool valid;
 
 		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-								 &queried);
+								 inst, &queried);
 		if (!valid || queried != pasid)
 			continue;
 
@@ -1302,6 +1303,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
-- 
2.55.0

