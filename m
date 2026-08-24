Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3DC61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8817110E5B0;
	Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2wxK5wJ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A66710E5AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCU7Bvz7Y4pFkWXUzGxC+eEePDSgjKvTcKTfVnUYKxhaxHiRrQnHYeA/PvtUDumEst4FzkkscXzOOTW5F+IaBgjw3Dex2aORwepdkWPte5uGWW/E6miiR9dyVoIPlNSlbhbk+Vifk2PhOTSJQEhdKTWJwFYq7Mtd4t6g7MKCns3G594BNwGJ7NFjUO8Ml4jvRQcwFxHfzmqitIbTV1tWmzjcQKbt+FhscG1YlEQCPtYiCd2LANAc4AIT5G1aH/1LeUK6xqpe32m7t8jI6450S/uhvOOJOB60RIUTEwo0/2xj35gf5/8sdOvu/8VeG47g4ODOK9ooe0t386DRsjyMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6dPsc/Q/dStrxwO3dTz2/aCRhM7BSMQ3RcfPoy77S8=;
 b=yc2du3HTelD0K+4JTVYXUqC11PNGZG9qf7Vyxb+w4Oi7C1gO/12PkUWjNCxCipyHwOiQ6DLqm5rnHsJBM8c5pXD+baBB8tYR+9a8SKPHH2o4tD4rnpVe4UrRgPfi5mSH54/rfXU1ePV5DQFDt87jdsbCzEMgf4fbagBxEdIL7bp1S8WuSmSYQE6QAEPzAdGJYGIR1rJ9x8pjppHphRUHaZUpuXZAZXGrkMROCQgkdPHvJwkBE9qzjqTRoZA7VBh707Obd7/NJ1uVAB0YZAv4X5biL4cQPel8o8Nnvbzy40obudDRwSttDkfuwRhaqzICGLZZ7DG7b5BxTd9DiHL/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6dPsc/Q/dStrxwO3dTz2/aCRhM7BSMQ3RcfPoy77S8=;
 b=d2wxK5wJpYfFqz8YmWqH0EV1F+O71fvC4XKRo+CxtFPxXsIaYkoR3Ml93EiHcxxO/TsJjnmkU4vkxISCPWthNprD5F70z4Rr0cw4OD3aIVJZ4APdZIHbdDVa8FzWAopJABpo4WQRWVABEE9onGwN4lc7RhaQ0pGfmWGF71ogljM=
Received: from MN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:52f::22)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:11 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::82) by MN0PR03CA0023.outlook.office365.com
 (2603:10b6:208:52f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/30] drm/amdgpu: add a gmc flag for using MMIO for TLB flush
Date: Mon, 24 Aug 2026 18:13:27 -0400
Message-ID: <20260824221352.1793542-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: a1db5e00-cab6-424f-b4dc-08df022d0489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rVlrx/CieAvjDfx9iKBHvYRm5GKmyabR3IZ6fZZRDbM0YH3aljZxPqwYzSMuHvNMWaOejlQCN3QI0Gt3HnUfkb7TwXgl2kDUI3MzS9IdXMC6BOJFfkwo+sIwvqmkcYPBeVGtlPAW6G4NldABoivwBaH7p17Zyf8eLLQfun/d7B7ZCO7ss9lbljNoulIghlzpkvJFEfcLVZ/I6RvC3fAhHAFQjN24jvb6ogkQ3d8EpLQTQv4s3VjJIPc704wOo+epYVw36CgVvl4/6VnaRz4oMS/yeEWEmawVZPZcH01bsr/vNjYDDTYU+vLbuL8ymqUfiCig9q2F7qI/8HJdPNKdAYhFLQMrJf0y8HwlJld36HoYdgHXHuaIj2HM6CBOIvCFm3p5w1oFNI+MW9NZoXFOPogROvIYgwoK1bFkXqfA23Yl5Lov5rYF6l79yYPbcx0aXwh4DLir5O7YvxYdNOymPF0Xuh7zDh8c0QrJlCpzknNEZplxTyj6KgVAyk9D4VFH5igmFkgTJRx6L4iwFMuniGOLSjc78xuNtWWLu2Qa0XS9O8d8XJNkkvPbHG/E4I2ZlYPoHIBllnBhogYi+jN5e6Q8vwCN6ciRrAsIqyZhoSzPxaoLoAX0crtXErdk1U4CD1LW2ky8yhx3VZqsTngGZLUWPCJpF7IMo8RLq11LOA8XBAj3Yw7nMCtOKO0UBXB0HJYamy4euPVnLKUX0kpULg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QxnicQuw/4Dew/bnmmH8OY1s86Im8okJE/jvPdxm9RE29Q9w9/4wRLb4zzA9XN6WEsxI4TsZ+eiMNLOO7MeBIInyrI/Fh6SnSABefKIXLLVk4WTxhS/SN8eHhdZkqDLLXPLlv6bAXdZv4JCPJZ22PgIt0UDbOV6AHxbV1Uj+WNFreeaNj7l/Tc8euDSFyYLdG+srkCEQ1GJz6tbRn5oF/BRM9prHlGvcPfUH444djfB+TVYP/ezgCxIcHbyuU2pA20b9rdqMuKFlRhEnGEUEnFRtSgUuYAn0kpd+2TOsn+7xCZlZnr8LQ9bIoX3DRs6Da0ygi4z1S8iu7DBvarM2iYEb/G1svJAN/pWhDSk+N5k60XFJRVOicXtpc9TqpDkYJc9RkjrRIAY3IKS1nLoS7BrAEv9AZfoatd/t5JjxspmGlpV/jtT1kN58t/yk8kXt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:08.2380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db5e00-cab6-424f-b4dc-08df022d0489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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

No intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 5 ++++-
 6 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c0884797dd544..f8f4df37d5805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -367,6 +367,8 @@ struct amdgpu_gmc {
 	bool flush_pasid_uses_kiq;
 
 	bool override_pte;
+
+	bool use_mmio_for_tlb_flush;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8d88651b18ef9..7ea1c4b878e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -256,7 +256,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, GET_INST(GC, 0));
 		return;
@@ -883,6 +883,9 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 41ebc6ae182cc..fc730504be5f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -244,7 +244,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, GET_INST(GC, 0));
 		return;
@@ -865,6 +865,9 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3b7764b94de19..3b1fe15fa1c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -315,7 +315,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
@@ -968,6 +968,9 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 5fe43f7eab29d..6c0d2689cc05d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -375,9 +375,9 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
 	 */
-	if (((adev->gfx.kiq[inst].ring.sched.ready ||
-	      adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)))) {
+	if ((adev->gfx.kiq[inst].ring.sched.ready ||
+	     adev->mes.ring[MES_PIPE_INST(inst, 0)].sched.ready) &&
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 		const unsigned eng = 17;
 		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 80f1cf1f21736..1ff1d2ea02b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -799,7 +799,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * properly under bare metal
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+	    !adev->gmc.use_mmio_for_tlb_flush) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -2056,6 +2056,9 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
+	adev->gmc.use_mmio_for_tlb_flush =
+		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+
 	return 0;
 }
 
-- 
2.55.0

