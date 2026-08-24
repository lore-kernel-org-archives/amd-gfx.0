Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A74C5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE89710E870;
	Mon, 24 Aug 2026 22:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yLG3nyWN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A87110E881
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yF5NWttL1mZGzG3l2o85jRsotWgEA1spRJQMBsLSKxmJvqsCfMZixJWr2rbsvSQhu9tHt375ZjLuiiL6q0LcISAYtG1xTVYq07FeDtUa1145u+W9cWEandMgPZjNf5hvKCgJCLMwS8E3FV3bugAI/HVZ91r8p6N9d2o/8bhVGQ3rBMQVBg0+lA7k25yvJ4FqqacOgIJZe9tTumMY6t4+HXq8jlBfIhlE8DD0RzhwUmGK5vo0qANHyxIFSUwGyBHaMcxd1/Vav+YbulRlD/GsCtzFXhZ+BF40OF10WUcCgc9l8fZ72pdGIsd+pNe9IrneQPcdD5E+Tpp00WPiCQMQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy6CzD26tEYrXVS0V88ok7v9HEXSQWBvCEg7eDwTJbU=;
 b=atRQCz/vITjzyVa3SsdKIExzyNpxn6EhaLFL1kDD4kjCBukYRA6qBg3O0y8Q6gtQUs1lJ4OmbweCeoxVDypv2kR+WKe1PfpNOk2VMSmjxRIJbI0JhWn9AIE73ha08eDycakWXH88evsRVCqbbMIan2ACD2e8OdOnXbrqW6GXAyMa8bXqap7aK37pgojL8hYFH/zKvw+35m6sOpbViGokXe6BFo9Qf0Be0RIfQ9N/YS7elYp4kgMVaLshuyCf0A162GfwJ5oGcA7oKDvkgGH2I+oxbZfyKP3LrtlqtoI7Dpx8/bPgSSG8oUg9Xrd8xXDit5D3foaTLTSjDnQ64bvYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy6CzD26tEYrXVS0V88ok7v9HEXSQWBvCEg7eDwTJbU=;
 b=yLG3nyWNnFet+1Ty+vaaDtcxykjgnJ3FJrviukXBjqsOvNGpw6yMd+drcGkeuiBZgbTRs9Ii/Ksi9u+5XPJ65RrOjEvSM+tgiGOqh6g5DUWv3JymvkB6gglVxcCPEPem2KXV9Add74NsSHhgu2IfOfPUKJZaNsdsvy1lG69GPOE=
Received: from DS7P220CA0038.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::29) by
 SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:23 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::5) by DS7P220CA0038.outlook.office365.com
 (2603:10b6:8:223::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/30] drm/amdgpu/gmc: add new callback to lookup vmid to
 pasid mapping
Date: Mon, 24 Aug 2026 18:13:41 -0400
Message-ID: <20260824221352.1793542-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: aca22e53-15e5-4f0b-5249-08df022d0d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ipPEiPLL1RSAg4RmUL6NRRycDcx+KCVLCR6KCocs+RH3OGXf/2mpJ5bkoIwSLgWUycmZbr8/VEmQarrfaaG6zMkB9nJVnZoCbCjWTeJg7OQG+UFhEY/NHtpQ+dHbmTkdxV25d4XOqXDsxRrrnz4ZADuhZXP7wlaOGy6KkSWqeuDp2xzggzYhdZG7B9iD3EH6Nx0QhVlPvi2/43gOhQ5FfRXISUs5xBuVJy6CaJx6MRNdOau+X12UbN6qdM6Q288ek+IVZVnwRnnrFnVJpY7PvMpYq0h/0a+ksnAM/ogo586OsONw4wKTLujWNuizUA+cfbtzLDrkPBdqzhMpz3fjOiK9nN7Ta9zfNebrDTQeEdP3DNz9V5pbiaRhEPMPLZnkjmRwJVHcz4xPGu+lzLIap5ekb3wK+iIhigCYdt+W9CUAliLAYdoAUZvIA5I+ubWDJfah95n8Ib+ya1cPgr89cQEBGkL22zwMYo29AFFcPGjuE+3TEgpbqoBgw/xnDff0hawUMO77Qaos0elsSRsCDxT1cQCLXf7Z4X+W2XI9J81QL4GKGGE/ya1lYNezubP/Km3Y+3UjrQiAz/072BzGfrenqLKAyW9W53N69r6EbTio8uvC29oKau62MEHyFlaHoye0UDvmvB/kq9bWfxmAOclJ3S9psmxrXoV/3rqyD3m1Kvuaq5RZ7uUFgp/fQJ4/8AZqPNk+lfgCklEz4wr+8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VxAzR9KWoKRNVRb8ggEOqhewibr4eXCPM5oY0kVAeg3/rSQ1cjfmQS7rbVRoG73MXwpxvgNcryyeCZTV6pZ4NAq0NSkPrk5PXJpm1Tq1phhBHVgN4opUoMyzZwkPG6M3wqwLrRTLG+xEkXme5rV246hXJ1mJDIxzhssfbtzeS2kKXHSHaGpQnnkpSbVUlj72eowk1F/u/gyjyjEHnIACKSV8GRxKhASs80x6BUC5OocbYsMg/pY7/nsa/yh0vb/BiaPjL12pKx+44IApTd4rSRNV+KBkthe5Cm95XCovgkYecX8s2IUkYiXtb2btz7sFqgFwq/BGWSS6BFnQaNMpj0KGNPRGo5/Zoicm1jG6FFnn84tMmGJJoDxKA/TmsR/txvWmVPoeRBBxvJOrxmohBPxYmXGA5KoKSnM8a1EEhMyqzacu48lHpAbkj8DqFNiC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:23.1696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca22e53-15e5-4f0b-5249-08df022d0d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
index 204cf1c360896..27785b1b38ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -171,6 +171,10 @@ struct amdgpu_gmc_funcs {
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
@@ -384,7 +388,8 @@ struct amdgpu_gmc {
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
index 23d9fe995a2b5..0028639448956 100644
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
index 098e1340554c5..b34bd7881726d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -200,7 +200,8 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -338,7 +339,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -546,6 +547,7 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cffc818880d12..9179dc0787f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -196,7 +196,8 @@ static bool gmc_v12_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 
 static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+					uint8_t vmid, uint8_t inst,
+					uint16_t *p_pasid)
 {
 	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
@@ -374,7 +375,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid,
+		valid = gmc_v12_0_get_vmid_pasid_mapping_info(adev, vmid, 0,
 							      &queried);
 		if (!valid || queried != pasid)
 			continue;
@@ -581,6 +582,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 6c0d2689cc05d..3fa1ec3dca273 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -668,6 +668,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v12_1_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8edaa54fca82f..19a10acedc6ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -746,7 +746,8 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 }
 
 static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
-					uint8_t vmid, uint16_t *p_pasid)
+						     uint8_t vmid, uint8_t inst,
+						     uint16_t *p_pasid)
 {
 	uint32_t value;
 
@@ -908,7 +909,7 @@ static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		bool valid;
 
 		valid = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
-								 &queried);
+								 inst, &queried);
 		if (!valid || queried != pasid)
 			continue;
 
@@ -1321,6 +1322,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
+	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
-- 
2.55.0

