Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF82C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 20:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA37C10FA12;
	Wed, 15 Dec 2021 20:45:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2952610FA12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 20:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjRSVLmFEn+HDUG9ePyNXR5iUbGJa7vBsLDNcUXaZVDkQ3ecK8dSvSO4oXuNaClhZeI1NQZfK3l8fCCQheKHMuhdEUlBlLw7OwDh9IEbEom+5OFJwCUN3cAjbtT0agzZV/HzHtSyD3kMywGPbfA0YqopFggtaW6iazxAjQPK9v40M3DQsSXEONwggPHn+XM296P4nf+nWfeV4rxOCwnLakUqGvaRLtzvSLabUIrMk8jf4iKZZfwhvAkOie/pT7r3D9duTlrzTMQIrGI2xkGBTXcKZVW4Okicpxa15WbAQHLUvyfGtUBmrRyx3jBM+vnJbHALYe7n+016ReaPbEGXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=kodosH6gzY3gCVaz6dzw+c3lYholzNs3mut/T0w4x+8QOR1pf0l0vhAnsfQBbuBLvEjMB6mpo/D2c3L7cnjo3kRUOmrXqy1GMX2245htNmlRdjhDfnCQUj5owsDRCdrYHbbBG8O7apUsyzTvlp4fdStsqKE8H1VMVxIKd9nUpOsLUTekux8JeKYOCEnV2Kq3Zu95qiqnYBqhhPyCKY4tUiV86iFUW0UyTOJKmuVC6+72Mujvbqg1NbnHcCorM3qI0W1W/iyDp2K38oUQAkPop7WSL9W9FMtuY2LpAW5JoLBW+EymeM9oMJjXchkR1WFEJ0WsI8Zqssd1s5CulqrDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=rid4wUaReOBUa1zqnUv4/mZ8O5LLCiLIzlIfqM9/8Tnci5327ureC+lAeV17mEEKH6/xtRlkcSfkOB/0IO0c+HR7sdTADYn1aO4Ja7z2CjN6LeBhF0jSY/R4AQUEBjKUc3R8l60zfYPdPQI7L1+PTgxjDO4i4t3vfJtTF6dYoYo=
Received: from DM5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:3:23::34) by
 CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 20:45:05 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::fd) by DM5PR13CA0024.outlook.office365.com
 (2603:10b6:3:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Wed, 15 Dec 2021 20:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 20:45:05 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 14:44:58 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Date: Wed, 15 Dec 2021 20:44:37 +0000
Message-ID: <20211215204439.7216-4-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215204439.7216-1-victor.skvortsov@amd.com>
References: <20211215204439.7216-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8db894f-e061-4324-9e4f-08d9c00bc67e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5386:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB538676B95EC3E83B3277D11F8B769@CH0PR12MB5386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SwkAhWgOFRTPisSJYcQRwrZpEOwtsN4MkFRXH82TtChIuAW4g/bBs6+5NtnBCprOwFmKMGFq6VWLeD7BqVeGuYAdUBvW/iDBffd0wesHtDX8O+1z3umwiHynM+RsN/dS1ReX0v56Zd8eSrb+ddm5fpcVmoUZXDhwHg0qCxcRMw84v+A2mCRH0b2DpGDFtsWjPEe+iNLjOI/Ku7JqpM0KadZRLNjtBoY6oOygVY1MRfQQ5yOITjHGxfr9Ih5TYs7XGD2ABTiAknk0OdYfyqTgTI9rYMTnpS0WZmg1e9Hd4mzfB4I++THB5H2Jbu4K+bW6SEmfh3pzcwnzIbvad8fZALkSANhOkSjoYzRE+C3jbLESCYdhpt8nPQ+ZnaRBEd8VRKmIZhfLGZ+1CMNrZJIdaNC0Et1k6Jl1XEX9i1GmQOsgDP1hpdyLvHCYzQwbSzW9+7SUjS9IuXS2xWXGUe3dPOiEacUNqXjaU/BOzTAXMcQuVqivVtehaDZAMUc3xY34l4OQoVGOdip79xC8mUefaWblSRNeN70goasc7fUxiAs6ZypDAOYq/HGSLQOWGekOM4E9TWP/RfQipQe/aMUVaEwa1aSMuXRU8TrAeo/9cTvIdvvkV3OgMOybrXZ6dky1RyfKVcCZYAkxcXSieO0nbs33SaKK2Ddx9qfAws22OvTHQRPQGmkuCcC/aF6nTD04e4PfWgKQjWzWTGQonqakTZgc2PTi6nnbfHe6RphFmbe3PufB5iqjv/fahdgKuV7CJCYAoZcZwM7NXM8QW7PdirRZCVx+SofqDf8ZG5sPu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(110136005)(2616005)(336012)(36756003)(186003)(6636002)(83380400001)(40460700001)(26005)(426003)(47076005)(8936002)(5660300002)(16526019)(81166007)(36860700001)(4326008)(86362001)(508600001)(2906002)(6666004)(316002)(44832011)(82310400004)(70206006)(7696005)(70586007)(1076003)(8676002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 20:45:05.6157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8db894f-e061-4324-9e4f-08d9c00bc67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
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

