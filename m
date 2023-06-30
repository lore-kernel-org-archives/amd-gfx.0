Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFEEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09C710E4A7;
	Fri, 30 Jun 2023 15:56:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2CE10E49F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibG2hn+1V9PsyynBvVwfbaZ9HvWC7KCs8fXAO6kYhlj/+umuuME68NTGzyA2DsV1xUxf9oCAdNcD9OXu4cn+PGaJ0WnTEmujgBkl11hHg34Yc+6UdKqB6mx6wvRXMS/3NbKbtwsDBeUzGHHH41Ms8jkmN4z2YXEKBMYWZo6tFA7TTKCT3NwiXawsOq7FqikwoCyCnw39UMRtiYcjuM/q4qFFN72z0jGpLp9/fYinTX3berL6ac0SToyijl3nYnvHG0OqDd+EvFZmJbGoIci54gAxqPJXtoO2Y22uuVjqgqj2d7xUiKFiI83CqBPSzZp+I4gvMtJwbm4ZFt9Dperk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c55agIAyu8W6cEfSuknZz137WM66CZr3mhVdeH9APek=;
 b=f6D+MA4TRB9xkcswI0EKN6rulij4CnN2wrqzYjzcbypbPxdD2+PcrjJRomBUQ/hVza/7ZFME+mrX4J4Y2H0IC1fAXME6tMOqKHjIeTN0cj5GW5aGEWRoFzPovosAEscCoFiVMlfOKbvrISSwtjQOK0cJjzRiEi9kYW2AcWNuB7ceuGfm4gzwpkj0Gf0QMfFBQBN0VhqRL7GsTs+Pl7UOWHrBqffNHJdk5tf2MRgudG79z4KPtaTqXNUb/f5oJg/g2u7jZMzttNe3bBUoaQxxrSq/TJyPZc5VYaj99xo+SdL0iJ2N3pD6hqKDlD3oIw2R1muo+jPfMw1KutrXEXGn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c55agIAyu8W6cEfSuknZz137WM66CZr3mhVdeH9APek=;
 b=3Z8PsgFvipRn2oSbGGGPmpATK+qiAyGhvQgUO1HlaX5rw123vRtHdTtwtC0YOazDxZCLGgHHy+mSTDfN423Ewo+nGTUBu336SJ7Qia3yLibiKFXaU5q0QLpoCkipSu8EbWMEKfYDUZIIAtkTJLg6Y9Js1O6TlTpXdbfVHttaWdI=
Received: from BN9P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::15)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 15:56:32 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::7c) by BN9P221CA0021.outlook.office365.com
 (2603:10b6:408:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 15:56:31 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: Fix error & warnings in gmc_v9_0.c
Date: Fri, 30 Jun 2023 21:26:03 +0530
Message-ID: <20230630155603.3388617-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
References: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1993d941-69fa-4696-bba5-08db798292ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZX28taEX/x927qEUJPlRwWd5b75TTh2d0LoIbjM5Pyp8eJyc9yYrCP6hRl9baGREFKWF3NllsE+Q0877W792qHGxQuK8M7VdcjaVjiF7ocBBgZ9VEQrgzwx5TfgKTKT6MiVKDClAGDH+QsnPB0JhrGoPVFoH6eY6ofB8B+uoKCQhXj1l0CpwRzgrTxNd9JhWTRbrXgRt6gZVBtL02cnlyq+/NFcfnuCJA10cHUEJBC618dRaxf8+te52ppwyOS48QLIS5byTrzGd68ZQWzJ+mtkqMKN+gyPA3vcB7UW9NBVAG513mthzPFJMKR1fOAdIgcD1mGa941/NdvH1fglOd0cftaTeA/h7NdVZ2fc96vqPJOjNSRBXXb5iPJszBvoQp+aeJ+J+KBGYeuPLf+K0AX0HYq/IJAlM36gKrfp+g+WVqslc2vEWq9hwMtO+fTSBoxhmvso9OnTXSfiXNPMbGJc5JkPPu5yzAUvdAKphuHZc3/ddOOwg21OUzUtvHlZ5IK1zAnDNbvHQQhfioYTlet5+VNwhya97LbbeRFkVdLCH68nWxnP7Ln8esxfzBzUrIeecTfxpWQX2uMSLgoc407XBou1BkDYDsnxRuSIRiuD7xcV1RmyCrkfspYCRNkUlh71Dha7K3EEh5PjZ2Yn3lkTpPEhcY42R0HFHZTp9kfZTVph/QNxWizey0B+lwwW7MtiLF7Zs2Q+0nAQcNMqpBghNf6uQXQRfT/Y+EmgQmr5vyvHb5FKhgF+klx/GoWD7mEMvuJLrhAsYXaIFQ+PRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(110136005)(86362001)(54906003)(36756003)(478600001)(2906002)(40480700001)(44832011)(5660300002)(4326008)(40460700003)(6636002)(8676002)(81166007)(70586007)(70206006)(356005)(316002)(8936002)(41300700001)(83380400001)(2616005)(66574015)(16526019)(426003)(186003)(36860700001)(47076005)(26005)(336012)(7696005)(1076003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:31.6378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993d941-69fa-4696-bba5-08db798292ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch error & warnings:

ERROR: that open brace { should be on the previous line

WARNING: static const char * array should probably be static const char * const
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 37 ++++++++++++---------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ebdbc823fae3..3f4fa94875bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -81,7 +81,7 @@
 
 #define MAX_MEM_RANGES 8
 
-static const char *gfxhub_client_ids[] = {
+static const char * const gfxhub_client_ids[] = {
 	"CB",
 	"DB",
 	"IA",
@@ -332,14 +332,12 @@ static const char *mmhub_client_ids_aldebaran[][2] = {
 	[384+0][1] = "OSS",
 };
 
-static const struct soc15_reg_golden golden_settings_mmhub_1_0_0[] =
-{
+static const struct soc15_reg_golden golden_settings_mmhub_1_0_0[] = {
 	SOC15_REG_GOLDEN_VALUE(MMHUB, 0, mmDAGB1_WRCLI2, 0x00000007, 0xfe5fe0fa),
 	SOC15_REG_GOLDEN_VALUE(MMHUB, 0, mmMMEA1_DRAM_WR_CLI2GRP_MAP0, 0x00000030, 0x55555565)
 };
 
-static const struct soc15_reg_golden golden_settings_athub_1_0_0[] =
-{
+static const struct soc15_reg_golden golden_settings_athub_1_0_0[] = {
 	SOC15_REG_GOLDEN_VALUE(ATHUB, 0, mmRPB_ARB_CNTL, 0x0000ff00, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(ATHUB, 0, mmRPB_ARB_CNTL2, 0x00ff00ff, 0x00080008)
 };
@@ -416,13 +414,14 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
 
 static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *src,
-		unsigned type,
+		unsigned int type,
 		enum amdgpu_interrupt_state state)
 {
 	u32 bits, i, tmp, reg;
 
 	/* Devices newer then VEGA10/12 shall have these programming
-	     sequences performed by PSP BL */
+	 * sequences performed by PSP BL
+	 */
 	if (adev->asic_type >= CHIP_VEGA20)
 		return 0;
 
@@ -466,7 +465,7 @@ static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
 
 static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *src,
-					unsigned type,
+					unsigned int type,
 					enum amdgpu_interrupt_state state)
 {
 	struct amdgpu_vmhub *hub;
@@ -631,8 +630,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
 	dev_err(adev->dev,
-		"[%s] %s page fault (src_id:%u ring:%u vmid:%u "
-		"pasid:%u, for process %s pid %d thread %s pid %d)\n",
+		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
 		hub_name, retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid,
 		entry->pasid, task_info.process_name, task_info.tgid,
@@ -816,7 +814,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	const unsigned eng = 17;
+	const unsigned int eng = 17;
 	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
@@ -1033,13 +1031,13 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 }
 
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					    unsigned vmid, uint64_t pd_addr)
+					    unsigned int vmid, uint64_t pd_addr)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
 	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
+	unsigned int eng = ring->vm_inv_eng;
 
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -1081,8 +1079,8 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	return pd_addr;
 }
 
-static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
-					unsigned pasid)
+static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
+					unsigned int pasid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reg;
@@ -1373,10 +1371,10 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 	}
 }
 
-static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
+static unsigned int gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 {
 	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
-	unsigned size;
+	unsigned int size;
 
 	/* TODO move to DC so GMC doesn't need to hard-code DCN registers */
 
@@ -2305,7 +2303,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	DRM_INFO("PCIE GART of %uM enabled.\n",
-		 (unsigned)(adev->gmc.gart_size >> 20));
+		 (unsigned int)(adev->gmc.gart_size >> 20));
 	if (adev->gmc.pdb0_bo)
 		DRM_INFO("PDB0 located at 0x%016llX\n",
 				(unsigned long long)amdgpu_bo_gpu_offset(adev->gmc.pdb0_bo));
@@ -2491,8 +2489,7 @@ const struct amd_ip_funcs gmc_v9_0_ip_funcs = {
 	.get_clockgating_state = gmc_v9_0_get_clockgating_state,
 };
 
-const struct amdgpu_ip_block_version gmc_v9_0_ip_block =
-{
+const struct amdgpu_ip_block_version gmc_v9_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_GMC,
 	.major = 9,
 	.minor = 0,
-- 
2.25.1

