Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9625C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 18:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D5510F838;
	Wed, 15 Dec 2021 18:55:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5A310F836
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 18:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bURIk153Q7U94scx1NaGK8BmTfrVrJmb/W3TnELO2xh64oCJLUIwsuspJY0KlIKY6/9K6H5lwShpmpYpENVetsZZxAAbPozkxXEKMpWO+Wkr96j5AAVPqyhS6s9WhYjgOfZY885OiTHPaECoyInYtFdBy4dAXhDgWvSxMJLYcQ1IV1HqOWHLDrrXwmJGS2X3TEUC0ZtgY4ZAh/pUpZVIiDc2tQLwNrOxDNMSEuYPED5rIepZ+0fHeQahJyzs6WP45Eh4oF+tHn5ZklWEeo8RLBv4vO5E54ZZ3aqcr+lEaUeQSXx7ngEFzmWxr00z+DF0sqWO4fvLWqLKPSFwLclHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=AlbWQa/UwTlziMAj72WETqOxzRWzpkH19fzBD2DRa3UXU3SyBrVrKKkyVTFUN/pWc2dKNVCB3mVq4xjrAZbvPjrmZApLOiJFLSakQzApnN5e2QPDdD4CfVjcIr30gDjUy86avGafp294rlr1xs0SyZ7zc1b6/50bUki2NJyPb0SSaRhFM4l4CaWDGATdC9+7VF53NGzUAYtv3XgQ4/KCvPuKj8B7Q3FC+dgy7tGo0KLsCW6HlJViffWCXydcmgYxwfah2Ilyvf+gNA452uFH1FR2xez280kH7l7WS1JHpkyEvqQYW76KBiNjjm8B85+UWySlZpXM2BXFUYPF91gyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDZUv/wFOuWZREmGGHVeGffK9QzdALb/zEnTg+iXv08=;
 b=Drk95LVp8sN6rEhs1RecQfuaFwj5yFPFp6gRxdZgMc+h54YhDGXSNJ23sstht5jiXn9Fs/VAM6rx+fD92SpsIOHyGLof8Sc/+txj9V5OInu6nMZ1moynLwIDmqdmfbhn/5OMoqi1M5D4Ix1eBV7tO40MOinDhfMd6My9bRjb3Is=
Received: from DM3PR12CA0120.namprd12.prod.outlook.com (2603:10b6:0:51::16) by
 BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 18:55:27 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::60) by DM3PR12CA0120.outlook.office365.com
 (2603:10b6:0:51::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Wed, 15 Dec 2021 18:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 18:55:27 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 12:55:25 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: Modify indirect register access for
 amdkfd_gfx_v9 sriov
Date: Wed, 15 Dec 2021 18:55:08 +0000
Message-ID: <20211215185510.15134-4-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215185510.15134-1-victor.skvortsov@amd.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c454e7c2-e987-40cc-1e10-08d9bffc7580
X-MS-TrafficTypeDiagnostic: BN9PR12MB5051:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB505117FBDD54598CA192683C8B769@BN9PR12MB5051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h67lYsSq+Jj9YY2OXxIOSVC5NshC0x9Ae+ms8im9R0CicEFxkYYx+PMKC+00UI5IkuPZTZdCzw+kBzcGMhpTs9Fmgvi1upqBb93RUqjwbl8C4Z/4b3ygC/2YM0S+63rFKNLspWDtOUZlAfteigbvCY87nPRJqGuASSZwNu9T5Ch3pN00ZsDrOoVJEPbDGbbRFIBLb3vIBtURpi5LxH5s8bT6DtiTmBZK2dfPe3Kd741SBD3dbB4JB8O/1YWaAOrpC7XacyT0pHTXjC2V3vZ8m0sqbmoJR0mSWyCvEOpKDPJUakfNjXGyQa+cVD/qLu2LQpz8L4CoehsV+qiVNU4nCUOalB8mgSpx+s9WWKWoeUtjzNIGDhUyzERoCNkQrE/dDNhTeHFs9j49Bv3eU3mQKbdgzM6BC57/kz5PEpIi8G/E8h4E4nIWGkSj9g9YzjE8r1p46gWN2rPy00k0GUCx66l984T0jutrdufmDhn+dKObsySwA4St0o0n+g8CZEUY7ICFP/e7JLZr4owRTMbHNg8nhpjZgbbOmkkV25RGQxurT1r0RPEunNycCdKrRbLMBVH4TlCWG0G81/XJkCLTY1nNWnZBHlTxY+fTo1VYJUQYc9XLTYxova2lO7d3GgjGUW14eKiNfU3HWpeWcPm4KqHRuxdFR8pOXkVEY7U3cJyj4Y+xld6W2mIoRUZ0WVD17pDcWPHvqhXnv1i2wXNODJ36s1X8odQZy4mlo14rknDBw9cskTs/XFTSBnnCj9gspFTsH/CAsa3JL6xS8GinvRSqYVOF4j2pDsTlfCQ8FE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(47076005)(508600001)(316002)(8936002)(426003)(8676002)(36756003)(336012)(2906002)(26005)(6666004)(1076003)(44832011)(4326008)(110136005)(16526019)(2616005)(36860700001)(186003)(70586007)(86362001)(70206006)(81166007)(7696005)(356005)(82310400004)(83380400001)(40460700001)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:55:27.2536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c454e7c2-e987-40cc-1e10-08d9bffc7580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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

