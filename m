Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E38DC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EDC10EC43;
	Wed, 29 Mar 2023 20:14:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBB910EC39
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+JK3QogG5qHr9xOW+6761sL3EyGA2gqSfaal74L1Z8yIzlKs80YybKRWbyL+y8rY0Hb37P4008mRYyLHo0n+30k553jCm0bB2cxSxm5oHC/YKF9xQX6XumgSxhiOZpfmQH8eojXYoksZVst2hllaXr5k+87TrcgnPZ4kR1t114YCb29W8vUksFlVlLS8sh9mtv1xhkAaV0xVzP0MuzJ6YxIziPm3W7h7sP4K/3bbFldNe1o0NJnM7Yz08Q+sHDVH0VKiNii1WatIHWavA0lpsYI5792p8XcTthDJZrEITra0Hx50EmWXT4zdt+hIX7VfMmj67HpgquBNkCWE7Lw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOyxN9U/MDh9QTpBnvkHoYaE7bs+ae41uQN5rG1AYHE=;
 b=KsO6n6sBJAkR3Aw/Nw9IWeajT6Vvp18kU0Iwv07dtfkT/QjYlufKBs4cDxNdEhe2xPtz/nQw36N10fuA4LMNsEJX7A08d7yi48PYQUWcXhZNB0c9jJEIT0MZQZv7n1RJrdoFMok9Z1MpnARLMaVcgPtEnzWtw3B9Wzi101LnltbSMchG51XEBy2Um9G1vnOsQOIBcDN0CWoS7B02h61UgSqWcm+Y3nMD/aCjwIFThYHWYlcbDUU5x0HzOkWGt+LRoWYGLtttOP1CzV2qSLiQm3ILlO2+QYil1v5RTBMaW9ceGb+tx3jxQaAQlccJKPiNExEHK2GGIXu9It9aHAKRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOyxN9U/MDh9QTpBnvkHoYaE7bs+ae41uQN5rG1AYHE=;
 b=i/QGmrP5LttOpaWxyPozDBvNw5B6LK0i4C1UjP41j7PdOEobWpeGwLs4FclKGhIH76O5fIbybJF226flf4vaR1CDqtkg/AoeSODgJ23FwQ0hJ55WRVxMq01yd7xzt+Scr0Yw3db/itB4h/W09UaaJ4MQSzSNcHrhFNoDZOVN5uc=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:14:50 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ac) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amdkfd: Use instance table for GFX 9.4.3
Date: Wed, 29 Mar 2023 16:14:22 -0400
Message-ID: <20230329201426.1982669-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|PH0PR12MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba07935-04e1-4c55-9af9-08db30924046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoyMUsQUGhDfA1G8/qR6Zt8A6M0CyVP7wrNsDWiaWkv4ntO1kJVZWNX0tym5emTlxPLwOknpOvSO39URlXj4jfgeiklXT7VVyDccXeBZV3f33pLhRBg6IgCK4h2vGXk9Lr57DA1BFi3+OPvHxwNUgzALWMU608csBeXE4sNdJu3fVWLiTDqD7rqP5/9TtBIZQmx+eXhbQ7verEMEHq+sQqzIIvbPL7B5y+RSwvTj4WDrJeVStjpmq3QhjUyA2dEwnneGpVtmY6MH6YMGngIvDont98GpsqVIeKqgFM8qdazz1OYtN8hqTiBT0PWcFXWWS4JUxK6DeGTDmobaUcKER2l4kojIv5LUh6SjrBTivBjJgmMq5B3I9Ra3lABATpJIVkXgQVLevyIhZpV6l2Bu43rFa+4TUizzFp5yXdDS9HUoO6O4+DIHMO5NvwI9QCOxpvQJXHgoxoABRkD9xRQ6ZbPXh7fXnDVit5919s8GmmOmUrhjMQ0Sy4gNy/XUzg8gVrloQrIZkB4dwFdy7PTk7s+HU9uyhoU/+2tuzTrHXmLQ/quTpiYb41jrYaWspDar77QanZayMKPn1cm5BOCtlZntGXmQ8AUjtv5KIMk+qtJ0j1tvTh9ZPnfqfjfPVykf3kULHPcG/e4ZNqhcCcVi5ouGg0TlTY3WwEg7rhM7ktxVIvgJ5vfrZsxe0dULLDwWIBEcdLLaMdMUFt5xJ35+UaRI25PoazL4TuK8m3gohJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(336012)(47076005)(426003)(8676002)(356005)(81166007)(6916009)(41300700001)(36756003)(82740400003)(40480700001)(82310400005)(40460700003)(4326008)(8936002)(7696005)(6666004)(83380400001)(70206006)(316002)(70586007)(36860700001)(478600001)(2906002)(16526019)(26005)(5660300002)(1076003)(186003)(86362001)(54906003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:50.3378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba07935-04e1-4c55-9af9-08db30924046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

For GFX 9.4.3, use the logical to physical mapping table,
to get the correct XCD instance when accessing registers on
bare metal.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 60 +++++++++----------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 58adbf2262cb..81dfbe39fd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -223,8 +223,9 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 {
 	unsigned long timeout;
 	unsigned int reg;
+	unsigned int phy_inst = GET_INST(GC, xcc_inst);
 	/* Every two XCCs share one AID */
-	unsigned int aid = xcc_inst / 2;
+	unsigned int aid = phy_inst / 2;
 
 	/*
 	 * We have to assume that there is no outstanding mapping.
@@ -261,7 +262,7 @@ static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 	 * to.
 	 */
 	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX),
-		aid * 4 + (xcc_inst % 2) + 1);
+		aid * 4 + (phy_inst % 2) + 1);
 	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid,
 		pasid_mapping);
 	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_LUT_INDEX),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 7918a00cbb5a..9fa9aab22fe9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -50,12 +50,12 @@ static void kgd_gfx_v9_lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint3
 			uint32_t queue, uint32_t vmid, uint32_t inst)
 {
 	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, mec, pipe, queue, vmid, inst);
+	soc15_grbm_select(adev, mec, pipe, queue, vmid, GET_INST(GC, inst));
 }
 
 static void kgd_gfx_v9_unlock_srbm(struct amdgpu_device *adev, uint32_t inst)
 {
-	soc15_grbm_select(adev, 0, 0, 0, 0, inst);
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, inst));
 	mutex_unlock(&adev->srbm_mutex);
 }
 
@@ -90,8 +90,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 {
 	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
@@ -167,7 +167,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id,
 
 	kgd_gfx_v9_lock_srbm(adev, mec, pipe, 0, 0, inst);
 
-	WREG32_SOC15(GC, inst, mmCPC_INT_CNTL,
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -234,17 +234,17 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
-	hqd_base = SOC15_REG_OFFSET(GC, inst, mmCP_MQD_BASE_ADDR);
+	hqd_base = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_MQD_BASE_ADDR);
 
 	for (reg = hqd_base;
-	     reg <= SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI); reg++)
+	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
 		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_DOORBELL_CONTROL),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
 					data);
 
 	if (wptr) {
@@ -274,25 +274,25 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_LO),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
 		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
 		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
 		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
-		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
+		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_EOP_RPTR),
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
 			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -370,8 +370,8 @@ int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
-	for (reg = SOC15_REG_OFFSET(GC, inst, mmCP_MQD_BASE_ADDR);
-	     reg <= SOC15_REG_OFFSET(GC, inst, mmCP_HQD_PQ_WPTR_HI); reg++)
+	for (reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_MQD_BASE_ADDR);
+	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
 		DUMP_REG(reg);
 
 	kgd_gfx_v9_release_queue(adev, inst);
@@ -491,13 +491,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 	uint32_t low, high;
 
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
-	act = RREG32_SOC15(GC, inst, mmCP_HQD_ACTIVE);
+	act = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32_SOC15(GC, inst, mmCP_HQD_PQ_BASE) &&
-		   high == RREG32_SOC15(GC, inst, mmCP_HQD_PQ_BASE_HI))
+		if (low == RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE) &&
+		   high == RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
 	kgd_gfx_v9_release_queue(adev, inst);
@@ -538,7 +538,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 
 	if (m->cp_hqd_vmid == 0)
-		WREG32_FIELD15_RLC(GC, inst, RLC_CP_SCHEDULERS, scheduler1, 0);
+		WREG32_FIELD15_RLC(GC, GET_INST(GC, inst), RLC_CP_SCHEDULERS, scheduler1, 0);
 
 	switch (reset_type) {
 	case KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN:
@@ -555,11 +555,11 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, inst, mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32_SOC15(GC, inst, mmCP_HQD_ACTIVE);
+		temp = RREG32_SOC15(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE);
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
@@ -633,8 +633,8 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 
-	WREG32_SOC15_RLC_SHADOW(GC, inst, mmGRBM_GFX_INDEX, gfx_index_val);
-	WREG32_SOC15(GC, inst, mmSQ_CMD, sq_cmd);
+	WREG32_SOC15_RLC_SHADOW(GC, GET_INST(GC, inst), mmGRBM_GFX_INDEX, gfx_index_val);
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_CMD, sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		INSTANCE_BROADCAST_WRITES, 1);
@@ -643,7 +643,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		SE_BROADCAST_WRITES, 1);
 
-	WREG32_SOC15_RLC_SHADOW(GC, inst, mmGRBM_GFX_INDEX, data);
+	WREG32_SOC15_RLC_SHADOW(GC, GET_INST(GC, inst), mmGRBM_GFX_INDEX, data);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return 0;
@@ -842,17 +842,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	/*
 	 * Program TBA registers
 	 */
-	WREG32_SOC15(GC, inst, mmSQ_SHADER_TBA_LO,
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_LO,
                         lower_32_bits(tba_addr >> 8));
-	WREG32_SOC15(GC, inst, mmSQ_SHADER_TBA_HI,
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_HI,
                         upper_32_bits(tba_addr >> 8));
 
 	/*
 	 * Program TMA registers
 	 */
-	WREG32_SOC15(GC, inst, mmSQ_SHADER_TMA_LO,
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TMA_LO,
 			lower_32_bits(tma_addr >> 8));
-	WREG32_SOC15(GC, inst, mmSQ_SHADER_TMA_HI,
+	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TMA_HI,
 			upper_32_bits(tma_addr >> 8));
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
-- 
2.39.2

