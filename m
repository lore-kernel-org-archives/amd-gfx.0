Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0860C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD7710EDB2;
	Thu, 16 Dec 2021 19:42:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D038910EDAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBK+QTu7+oTJ8ANNlnsEIrdwkMg21Iiwfz6XzoCwi8ZwwzUvtj3UIUMLdcSPUyxZ/DRXgjI0Jf9cK4hlqsDtI9/a508nseL+Gx9F/+Mv66QTnnskFVPhjYPDW0L0yVQ/xn1Lx0I0KTnzkHFlX5dvmbq5006mozglX37Krk1V3dOUroGgpt+X78jSTXzdXu0PAwdPj6SyEJDrpL8ZjLlyisPCtyssPZsw7TVCtxHKhfAYjSfEHtiJrSrVN8Rehz2mbBAog8cmcuwfmMxmxRTLkLhS+dtGtYuu5rl/x/cYj4SRP93afpa7K05aMbFuTW7SDPVHvazNgSTv11ExuopZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=dM/TAhw6Pm3FIH5I25PvFVb3TWn34FcvFvZMwIUE5J2LcPnfPW4obRO0zXt1UDlFwNMr+wFHU0wHuCgFZBPnUfvZmNTSnUPgvUxKwEnv0BJJeEAMvWizjwaQhgn1nC/0ySGKf4dZPHG2IrAKK2J5KtYOPnc4Tg7055s8iWB8JD4pv/QP1YDtjV8E5yAo4xL4OqEzOrJVSoUYlqYVXGPCwirZh//aCJNYpYFJowSlb7dXpj8NBuBVz4yfN5AAKlI0fw4YrYouE5ec49jmJjbcPyIXydcGwXojEBQmSULac96oM3uqGE1lkc2z39296it1Msim16zPc0Tkaa5j5wdavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=VQQW84usph9xUnPpXk0mvrpv2THDVQZt0EwGZemWjWOFjqZ6UVmdaU3CB5MO5Cz58ORZmyKNFwklYQ/AwRamK1ZxssorMhMyDc5hkCiXfUIKvZBsns9r+yrhhBfQTTmEn5jSBR1oh2aJw4xX1UUvO2cnZl8Nlv9IxGaBSB9F31Y=
Received: from DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 19:42:55 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::75) by DM5PR2001CA0008.outlook.office365.com
 (2603:10b6:4:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:54 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:53 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Date: Thu, 16 Dec 2021 19:42:31 +0000
Message-ID: <20211216194233.3839-4-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216194233.3839-1-victor.skvortsov@amd.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e0d361-e390-4963-6976-08d9c0cc4117
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2350C0F67848295CCA54321F8B779@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUJui62kxh6HPh6QGm7n9G2vwbQj5OXTR/J7KcPg7RjVKliKMUX2yLM7HU556SzRq+CwaVhXuNYjdFt6rxC9vk7AGyVQLS2+NA+7jNbcRFscBmAFj4kufwnnKp0larzojkZZyWqHa5aVCp/iI4hgphh1yiq79xq5pb2K0Wv9G9aKFRS5XM7egQJpoI8s6eQVfbBmFTWa93o223FmsBvDY7XTlQ9lc8felywiGJknVTd45cTjOq4HRyYnG6gS0Hqgm/5oAexRlmKdwZ2enq7jd/1BJrUCIxc7rxs1WjtxqSJxRdCwQs9jXtOEellHAM/1vTPTzWGmAVBJjgAaH5eE2w4iri3oD5y7313IsNqcjatOQqBQSJF2NALHR5bzBONfSFYEDerRPUW5UNw41++rt+z8n94rq/CwGmX2oXxYxEvL1nxmJkCqwfJoef57cJLCBdGug8Qdl7nqXK95ni4dkHwCiRAeSVZxOzDTCia0dZfOIW88FA7Tvxu7k1TU3suIxPntcwCn/TokFe5apC1jGy44l1g4T8sVmXdh1Z2XF22Sa5Vr3tyJZ21/styLipU3D4rd+c0O79t0PbUFXNRZOzeKgQvAVkbOO5Z8IX/PZ05b+WpN9RpJ6iu2VqNmIWrRQYnCRtHVwGmfv8RZPnfi64gwImEnqimEEiKBWPI07wuxo6sTNoklYyr1MRuTi4ZHyoNUUEClM3f3OCOk6CJIBbestxB2ba47zZoKIKY7xfOf+KlJX1wSGYhwaHgHSXTn2/+Gc42CV9EKY6Z9sPDyqUhm7IbzHKxyCGFkr4WNDKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(16526019)(44832011)(1076003)(70206006)(426003)(26005)(8676002)(2616005)(36860700001)(2906002)(5660300002)(508600001)(6666004)(8936002)(316002)(186003)(81166007)(36756003)(70586007)(4326008)(86362001)(7696005)(47076005)(82310400004)(356005)(336012)(83380400001)(40460700001)(6636002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:54.6682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0d361-e390-4963-6976-08d9c0cc4117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify GC register access from MMIO to RLCG if the indirect
flag is set

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ddfe7aff919d..1abf662a0e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -166,7 +166,7 @@ int kgd_gfx_v9_init_interrupts(struct amdgpu_device *adev, uint32_t pipe_id)
 
 	lock_srbm(adev, mec, pipe, 0, 0);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
+	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
@@ -279,7 +279,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		       lower_32_bits((uintptr_t)wptr));
 		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
+		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
 	}
 
@@ -488,13 +488,13 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 	uint32_t low, high;
 
 	acquire_queue(adev, pipe_id, queue_id);
-	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
 		high = upper_32_bits(queue_address >> 8);
 
-		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
-		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
+		if (low == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
+		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
 	release_queue(adev);
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
-		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
+		temp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
 			break;
 		if (time_after(jiffies, end_jiffies)) {
@@ -645,7 +645,7 @@ int kgd_gfx_v9_wave_control_execute(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 
 	WREG32_SOC15_RLC_SHADOW(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
+	WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);
 
 	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
 		INSTANCE_BROADCAST_WRITES, 1);
@@ -722,7 +722,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
 	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
 	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
 	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
-	reg_val = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
+	reg_val = RREG32_SOC15_IP(GC, SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
 			 queue_slot);
 	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
 	if (*wave_cnt != 0)
@@ -809,8 +809,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
 
 			gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
-			queue_map = RREG32(SOC15_REG_OFFSET(GC, 0,
-					   mmSPI_CSQ_WF_ACTIVE_STATUS));
+			queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 			/*
 			 * Assumption: queue map encodes following schema: four
@@ -860,17 +859,17 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	/*
 	 * Program TBA registers
 	 */
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+	WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
                         lower_32_bits(tba_addr >> 8));
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+	WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
                         upper_32_bits(tba_addr >> 8));
 
 	/*
 	 * Program TMA registers
 	 */
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
 			lower_32_bits(tma_addr >> 8));
-	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+	WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
 			upper_32_bits(tma_addr >> 8));
 
 	unlock_srbm(adev);
-- 
2.25.1

