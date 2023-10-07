Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD49E95A61
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 08:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5668F89654;
	Sat,  7 Oct 2023 08:54:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4179F89654
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 08:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuj/5qsNuYTEZaCbsL/etkSLpUK/gS4jI8KCO/bmx26bxNQnCjTVCXYkSEEdbXk3zDYrdrgkKdxuvMSsCV4TTNYc4LUQy36SkqkC+CKrpehkkKHHzrucUUx+E6eilUaiDJmL+yLr3mPm2rgNE0pLKNm1fq5VkyaOMSPm4InlVsx/ZDF55iwm0PRUIbnxYU/PBi7RrrkC+q0mU1leKPxyS0n7EIIWmMxZg2dmGFCMz/TuQZnvU4334+Q/a8LSoSawhgNaYmXmFq3gxW0Gq7OStCtMp3QPEr4sg34EDC1HsjkH2gk0JeJAPosJU79MTpTCyTjU1/e5R7jj6nnWIST0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EllBwcmLzM7G835EmO84FistlTVNYwHpwLKGETiruNI=;
 b=ZPGZn0ERQ2JTwjIfhTILTvecHMkUTvPgihlNzJPCOXIWQZkoCxGpZh0/E8sPRE4FZiWh38xhlk+ojttclfStvvX3RFr5He1HwsqLI5eNhqberTOSCr4SFhJIjwsiyIaSYj1zzbM3gl1XfsxP1kNOsgWoP0rUqMOsMvCcbY+vt+qZy+0BOnBAISoxADCGDGsv0h5SDu5zVcxmDqQUpCI1fSrQB/kakR3PLXZdJ8ZUUhiwTDpmA2QlxaXYH25NDP9gK5/CcqPmMMDPTYDKc6btlX05mOb5/NVnTA2RtPSQKuuB+oyYRijW4qfTwKli1BU+igUHLEP2sqSato/VfOYQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EllBwcmLzM7G835EmO84FistlTVNYwHpwLKGETiruNI=;
 b=R1njeFf090tRzn/KAC5tIqQjkpzjbm3GidNK9pr47IFQjFS75WBsomX2AkjmTw1cuXDdneX8JC8oKzpk3VKC26H82Gjn1vWag5nV47rae1gpG0EYnHbD9RxZ7ClNvIVxIGHAe0vXVQCXN/TW72+5AzjNfC2Wcc5AYNNPDWJDx9A=
Received: from DS7PR03CA0230.namprd03.prod.outlook.com (2603:10b6:5:3ba::25)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 08:54:18 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a) by DS7PR03CA0230.outlook.office365.com
 (2603:10b6:5:3ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.40 via Frontend
 Transport; Sat, 7 Oct 2023 08:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 08:54:18 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 7 Oct
 2023 03:54:16 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/umsch: fix psp frontdoor loading
Date: Sat, 7 Oct 2023 16:54:00 +0800
Message-ID: <20231007085402.67350-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4820260f-b7b5-4e4e-6769-08dbc712fdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /A70DTqHoWxSnG1ebY8/P3OlaT04r5WBREDZ/8/jhAviCwTZzqRwX+byejPGH9Fsc2C9pHxhtZbigdKMqSp5ZYdRjRxX8GhbJG42E68RJGODyzHyrxco71XtKPn6WYNWuuylg4VlUIbTVP35Kp90il8hQ90ByY1+JSgcoPTfh8WQ1zRFP1ECJrajiSow0HQb7qbH56opBKIvbS89NaxtcymrErtQpxoudodNFV9ydWsCW/EE6Q5hpCpROY/R4070Wea/dYArcQ4xgs+h/URGrFGEylza/y90Km8Vo45pRO2U+sN4r/zlliQHlKUpWzxKj2KESSgAZzyETyvppLbz+BIxvHDmTICUfS0YCrKLZM8naikfPz2VhVtw+JHkJ3rP67ZWI8cJAAAmOyqWYBjSrpHe6y/F2JNcNt7JONT+gH4pPXYNj0TKOavJiAiIrT898RbJV4mOf+2EqNi8P30VT1KOWU4VG68pgKNzEMpGe1WUr0N5S6mjhRdVfU/5UY/BU64qnGcsa1CDlRT/Gir/opChtAQgaLrTLf3HVZHafB08sF/VW/wDWMXh/6oaXpPcebH+LV+w7fwCP2WgXSk//WHGTswYTKkPs24ewMhM731gAtGL9jMz4zIHEIma7vazFRDOmsyIJLbftFiZS1ub+2CE36KtV6cgqzXEUtkJCHQDg9TomjsvhSulVKR01gZ695gzGKCLb2715z5fv1uv5iOTOHDGur+sSikW4agrqKF+l92VDCTUuefyIja42P/q639RlvospxnpklchTHI5ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(2616005)(82740400003)(26005)(1076003)(81166007)(356005)(336012)(426003)(16526019)(54906003)(6916009)(70586007)(316002)(70206006)(41300700001)(6666004)(478600001)(7696005)(47076005)(36860700001)(83380400001)(86362001)(36756003)(8676002)(4326008)(8936002)(5660300002)(30864003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:54:18.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4820260f-b7b5-4e4e-6769-08dbc712fdcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These changes are missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  35 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h |  18 +++-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c   | 107 ++++++++-----------
 3 files changed, 72 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index aeff9926412f..9d89c4186989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -75,17 +75,6 @@ struct umsch_mm_test {
 	uint32_t		num_queues;
 };
 
-int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size)
-{
-	struct amdgpu_firmware_info ucode = {
-		.ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
-		.mc_addr = adev->umsch_mm.cmd_buf_gpu_addr,
-		.ucode_size = ucode_size,
-	};
-
-	return psp_execute_ip_fw_load(&adev->psp, &ucode);
-}
-
 static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
 			  uint64_t addr, uint32_t size)
@@ -694,15 +683,17 @@ int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch)
 	return 0;
 }
 
-void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
-			      void* cmd_ptr, uint32_t reg_offset, uint32_t reg_data)
+int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch)
 {
-	uint32_t* ptr = (uint32_t *)cmd_ptr;
-
-	*ptr++ = (reg_offset << 2);
-	*ptr++ = reg_data;
+	struct amdgpu_device *adev = umsch->ring.adev;
+	struct amdgpu_firmware_info ucode = {
+		.ucode_id = AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
+		.mc_addr = adev->umsch_mm.cmd_buf_gpu_addr,
+		.ucode_size = ((uintptr_t)adev->umsch_mm.cmd_buf_curr_ptr -
+			      (uintptr_t)adev->umsch_mm.cmd_buf_ptr),
+	};
 
-	return ptr;
+	return psp_execute_ip_fw_load(&adev->psp, &ucode);
 }
 
 static void umsch_mm_agdb_index_init(struct amdgpu_device *adev)
@@ -824,11 +815,9 @@ static int umsch_mm_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = umsch_mm_load_microcode(&adev->umsch_mm);
-		if (r)
-			return r;
-	}
+	r = umsch_mm_load_microcode(&adev->umsch_mm);
+	if (r)
+		return r;
 
 	umsch_mm_ring_start(&adev->umsch_mm);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index d83fdf2da464..8258a43a6236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -150,6 +150,7 @@ struct amdgpu_umsch_mm {
 	struct amdgpu_bo		*cmd_buf_obj;
 	uint64_t			cmd_buf_gpu_addr;
 	uint32_t			*cmd_buf_ptr;
+	uint32_t			*cmd_buf_curr_ptr;
 
 	uint32_t			wb_index;
 	uint64_t			sch_ctx_gpu_addr;
@@ -167,19 +168,28 @@ struct amdgpu_umsch_mm {
 	struct mutex			mutex_hidden;
 };
 
-int umsch_mm_psp_update_sram(struct amdgpu_device *adev, u32 ucode_size);
-
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws);
 int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch);
 
 int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch);
 int amdgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch);
 int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch);
-void* amdgpu_umsch_mm_add_cmd(struct amdgpu_umsch_mm *umsch,
-			      void* cmd_ptr, uint32_t reg_offset, uint32_t reg_data);
+
+int amdgpu_umsch_mm_psp_execute_cmd_buf(struct amdgpu_umsch_mm *umsch);
 
 int amdgpu_umsch_mm_ring_init(struct amdgpu_umsch_mm *umsch);
 
+#define WREG32_SOC15_UMSCH(reg, value)								\
+	do {											\
+		uint32_t reg_offset = adev->reg_offset[VCN_HWIP][0][reg##_BASE_IDX] + reg;	\
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {				\
+			*adev->umsch_mm.cmd_buf_curr_ptr++ = (reg_offset << 2);			\
+			*adev->umsch_mm.cmd_buf_curr_ptr++ = value;				\
+		} else	{									\
+			WREG32(reg_offset, value);						\
+		}										\
+	} while (0)
+
 #define umsch_mm_set_hw_resources(umsch) \
 	((umsch)->funcs->set_hw_resources ? (umsch)->funcs->set_hw_resources((umsch)) : 0)
 #define umsch_mm_add_queue(umsch, input) \
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 99713949b61f..a60178156c77 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -34,23 +34,10 @@
 #include "umsch_mm_4_0_api_def.h"
 #include "umsch_mm_v4_0.h"
 
-#define WREG32_SOC15_UMSCH(ptr, reg, value) \
-({	void *ret = ptr; 										\
-	do { 												\
-		uint32_t reg_offset = adev->reg_offset[VCN_HWIP][0][reg##_BASE_IDX] + reg; 		\
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)					\
-			ret = amdgpu_umsch_mm_add_cmd((&adev->umsch_mm), (ptr), (reg_offset), (value)); \
-		else											\
-			WREG32(reg_offset, value);							\
-	} while (0);											\
-	ret;												\
-})
-
 static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 {
 	struct amdgpu_device *adev = umsch->ring.adev;
-	void* ptr = umsch->cmd_buf_ptr;
-	uint32_t data;
+	uint64_t data;
 	int r;
 
 	r = amdgpu_umsch_mm_allocate_ucode_buffer(umsch);
@@ -61,97 +48,95 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 	if (r)
 		goto err_free_ucode_bo;
 
+	umsch->cmd_buf_curr_ptr = umsch->cmd_buf_ptr;
+
 	data = RREG32_SOC15(VCN, 0, regUMSCH_MES_RESET_CTRL);
 	data = REG_SET_FIELD(data, UMSCH_MES_RESET_CTRL, MES_CORE_SOFT_RESET, 0);
-	ptr = WREG32_SOC15_UMSCH(ptr, regUMSCH_MES_RESET_CTRL, data);
+	WREG32_SOC15_UMSCH(regUMSCH_MES_RESET_CTRL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 1);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 1);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 1);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
+	WREG32_SOC15_UMSCH(regVCN_MES_CNTL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_BASE_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, VMID, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, EXE_DISABLE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_BASE_CNTL, CACHE_POLICY, 0);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_CNTL, data);
+	WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_CNTL, data);
 
+	WREG32_SOC15_UMSCH(regVCN_MES_INTR_ROUTINE_START,
+		lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+	WREG32_SOC15_UMSCH(regVCN_MES_INTR_ROUTINE_START_HI,
+		upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START,
-				 lower_32_bits(adev->umsch_mm.irq_start_addr >> 2));
+	WREG32_SOC15_UMSCH(regVCN_MES_PRGRM_CNTR_START,
+		lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
+	WREG32_SOC15_UMSCH(regVCN_MES_PRGRM_CNTR_START_HI,
+		upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_INTR_ROUTINE_START_HI,
-				 upper_32_bits(adev->umsch_mm.irq_start_addr >> 2));
-
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START,
-				 lower_32_bits(adev->umsch_mm.uc_start_addr >> 2));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_PRGRM_CNTR_START_HI,
-				 upper_32_bits(adev->umsch_mm.uc_start_addr >> 2));
-
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_BASE_LO, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_BASE_HI, 0);
 
 	data = adev->umsch_mm.uc_start_addr + adev->umsch_mm.ucode_size - 1;
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(data));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_INSTR_MASK_HI, upper_32_bits(data));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_MASK_LO, lower_32_bits(data));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_INSTR_MASK_HI, upper_32_bits(data));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_LO,
-				 lower_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_BASE_HI,
-				 upper_32_bits(adev->umsch_mm.ucode_fw_gpu_addr));
+	data = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ?
+	       0 : adev->umsch_mm.ucode_fw_gpu_addr;
+	WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_LO, lower_32_bits(data));
+	WREG32_SOC15_UMSCH(regVCN_MES_IC_BASE_HI, upper_32_bits(data));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_MIBOUND_LO, 0x1FFFFF);
+	WREG32_SOC15_UMSCH(regVCN_MES_MIBOUND_LO, 0x1FFFFF);
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_LO,
-				 lower_32_bits(adev->umsch_mm.data_start_addr));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_BASE0_HI,
-				 upper_32_bits(adev->umsch_mm.data_start_addr));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_BASE0_LO,
+		lower_32_bits(adev->umsch_mm.data_start_addr));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_BASE0_HI,
+		upper_32_bits(adev->umsch_mm.data_start_addr));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_LO,
-				 lower_32_bits(adev->umsch_mm.data_size - 1));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_LOCAL_MASK0_HI,
-				 upper_32_bits(adev->umsch_mm.data_size - 1));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_LO,
+		lower_32_bits(adev->umsch_mm.data_size - 1));
+	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI,
+		upper_32_bits(adev->umsch_mm.data_size - 1));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_LO,
-				 lower_32_bits(adev->umsch_mm.data_fw_gpu_addr));
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_DC_BASE_HI,
-				 upper_32_bits(adev->umsch_mm.data_fw_gpu_addr));
+	data = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ?
+	       0 : adev->umsch_mm.data_fw_gpu_addr;
+	WREG32_SOC15_UMSCH(regVCN_MES_DC_BASE_LO, lower_32_bits(data));
+	WREG32_SOC15_UMSCH(regVCN_MES_DC_BASE_HI, upper_32_bits(data));
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_MDBOUND_LO, 0x3FFFF);
+	WREG32_SOC15_UMSCH(regVCN_MES_MDBOUND_LO, 0x3FFFF);
 
 	data = RREG32_SOC15(VCN, 0, regUVD_UMSCH_FORCE);
 	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, IC_FORCE_GPUVM, 1);
 	data = REG_SET_FIELD(data, UVD_UMSCH_FORCE, DC_FORCE_GPUVM, 1);
-	ptr = WREG32_SOC15_UMSCH(ptr, regUVD_UMSCH_FORCE, data);
+	WREG32_SOC15_UMSCH(regUVD_UMSCH_FORCE, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
+	WREG32_SOC15_UMSCH(regVCN_MES_IC_OP_CNTL, data);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_IC_OP_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_IC_OP_CNTL, data);
+	WREG32_SOC15_UMSCH(regVCN_MES_IC_OP_CNTL, data);
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_LO, 0);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP0_HI, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_GP0_LO, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_GP0_HI, 0);
 
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_LO, 0);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_GP1_HI, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_GP1_LO, 0);
+	WREG32_SOC15_UMSCH(regVCN_MES_GP1_HI, 0);
 
 	data = RREG32_SOC15(VCN, 0, regVCN_MES_CNTL);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_INVALIDATE_ICACHE, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_RESET, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_HALT, 0);
 	data = REG_SET_FIELD(data, VCN_MES_CNTL, MES_PIPE0_ACTIVE, 1);
-	ptr = WREG32_SOC15_UMSCH(ptr, regVCN_MES_CNTL, data);
+	WREG32_SOC15_UMSCH(regVCN_MES_CNTL, data);
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		umsch_mm_psp_update_sram(adev,
-					 (u32)((uintptr_t)ptr - (uintptr_t)umsch->cmd_buf_ptr));
-	}
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
+		amdgpu_umsch_mm_psp_execute_cmd_buf(umsch);
 
 	r = SOC15_WAIT_ON_RREG(VCN, 0, regVCN_MES_MSTATUS_LO, 0xAAAAAAAA, 0xFFFFFFFF);
 	if (r) {
-- 
2.25.1

