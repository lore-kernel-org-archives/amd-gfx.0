Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE2160F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BE2160F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCEA6E8E9;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D7A6EA9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgzChgHThLYpFiXaqQ0LlxnOjK7IPhBryhVsvGVPSSiRSMkM2lFwuBCSrID4lfJqZUwiJPSk78E45PJV2we5/DRH5xGgBWtDX7S8e8fM5h+rpeaOtN+qQJVZuURImYkgSsBk7ct6trLSmNm88vby5OiuARG5ebD6eOFDWKUMiynvQlBUyIfY29Z923lp/V/qHLKJlGPSnDULjrgNFGLrObr3FLfGuigNBTwLcaOiDtsVUsdzlhuzFIjxaFIYIQuIj8lP0IFosvjLVJmaFvBnSFw+02xJRwGuuLmKHBC5omf3aEEv3l+gDMb2/TqvpElkYwZBZxiUM//tTUNeJz90rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCtLBlkvp+XXxaAJqFnJp/3U9CqmWaQ9t+rqX65Om4o=;
 b=OIZqeRFWE37JPKvinImLBQZYJT1JCs9n5BSqXsFsjjtGz+yBtt24HSt5Ixjvdzdu5nmqMP6hn4P36A4GfI0hyy5UDnqNZxxLxKEox5nvqlpDnBqgs+TpjguxWquNeT8hxiSRMsvIP+Ax+sWS4m0m5qXIyfY0VRLwERr3yc/NzhH+/e1NaHg1a++hArripEvSSN64WhlCpLx1rc0gvgDUoHe4yms/DksifPWZpbrife0R8T7ZeNnY4Z0/2uM56+vK8z0MRZ4pRsIEk8rPbMHWNBFXP83tRHv3Xw0D//0InaoD9b6PO29wjr31DR7qZdm3NI2YMCG5UxzUMpZw5/djiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCtLBlkvp+XXxaAJqFnJp/3U9CqmWaQ9t+rqX65Om4o=;
 b=e4ka4OL7jc0w08/q0e+l6Dc6pg1PI3OfAyMEuDNKQ1nWHf3/xK3fw3K7CL14QBgaLFZv8CYs/0ZxzMlOk+6d0HjSkAOt/DPnF4ZsI8AKLw3QoDnzbV+e6XQwLRm2Q+ztxWmsVJI/i9RTMv1LV0Zt0N7hQebq5d3TJT66f0/CgPM=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by CY4PR1201MB2534.namprd12.prod.outlook.com (2603:10b6:903:da::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 21:14:57 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::b0) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:56 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:54 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 04/13] drm/amdkfd: replace kgd_dev in static gfx v9 funcs
Date: Tue, 19 Oct 2021 17:13:25 -0400
Message-ID: <20211019211334.1552825-4-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ddff4c-5538-45b3-43b9-08d993458064
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2534:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2534376473EF5A90303C715A8ABD9@CY4PR1201MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOt4gcc8vs4CmKmHy7gGAgpydZ3hfRwHyrHcvZRp4vI9buWjtfaMpIKzMRPuxul/9Wv99jy/x8RtNpLMxtbqKgFMGFggmygfLT10d7scbQsGLFDtcGSrL5o2L70tb2teeveZnjQmNMEuHnb3F2VE9uwKdtlTEIgyegXTyUgElhta1wuSFYfnJH7YgehOBplU9uKdQWVcSz7pZQxvbv42x9GRRSLjJPfMlvihVfyluo4nWyNqPQZOHRKl89FfCVii31hgESmhRdnbP6IuAOqZbzwhZ+J5e3y0TQGDcCtqRhrVcscTyHO7As9k6EurGqEUQQqATicXztFQqNJHAVldkIXVj4d60QvXgOkBnRpQOy5rdyiIDH8mD82XxomsGYTD++Qu0rhiJ1BqxyS/jb779AsOTMjE9BfaqgBiqF+IkgtUyKS2y1G7DTy1MIflbBkVint4QaQtG6sC7axEpbW/Ex9Pe8fmb1DXVhgLVQ/cLZQ1z67YXhAikG5dtd+78bTVGE4/GI/rK4YYkn+6Tz98F80P9XoO36xpzzU73rtlCDMO2JAdHaKWA0c7+hCmUHCwp2IUdCvsSf0xK0ty93wGAsbAZMSfmd8yyHWRu1i2gfrzV+L8R5cUyfWde3qY0Cn6iuh8rQzyJMSmHWFqO8h+9G/KsErPnxl/Ux36R0nSQcQIDyoHnORlRZ9SkPTzd9UwJbKzUBggZ9hIdgS8FAESTWlKU4BNPacCAkM0q9uJCjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(70206006)(4326008)(70586007)(83380400001)(5660300002)(8676002)(36860700001)(356005)(6666004)(1076003)(81166007)(86362001)(26005)(336012)(16526019)(7696005)(186003)(6916009)(316002)(47076005)(426003)(2616005)(508600001)(2906002)(54906003)(36756003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:56.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ddff4c-5538-45b3-43b9-08d993458064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2534
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

Static funcs in amdgpu_amdkfd_gfx_v9.c now using amdgpu_device.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 52 ++++++++-----------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index bcc1cbeb8799..a79f4d110669 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -51,32 +51,26 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 	return (struct amdgpu_device *)kgd;
 }
 
-static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe,
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, mec, pipe, queue, vmid);
 }
 
-static void unlock_srbm(struct kgd_dev *kgd)
+static void unlock_srbm(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	soc15_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
+static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
 				uint32_t queue_id)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(kgd, mec, pipe, queue_id, 0);
+	lock_srbm(adev, mec, pipe, queue_id, 0);
 }
 
 static uint64_t get_queue_mask(struct amdgpu_device *adev,
@@ -88,9 +82,9 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
 	return 1ull << bit;
 }
 
-static void release_queue(struct kgd_dev *kgd)
+static void release_queue(struct amdgpu_device *adev)
 {
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
@@ -101,13 +95,13 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
@@ -180,13 +174,13 @@ int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(kgd, mec, pipe, 0, 0);
+	lock_srbm(adev, mec, pipe, 0, 0);
 
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 
 	return 0;
 }
@@ -245,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
@@ -308,7 +302,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	return 0;
 }
@@ -325,7 +319,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
@@ -361,7 +355,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 
 out_unlock:
 	spin_unlock(&adev->gfx.kiq.ring_lock);
-	release_queue(kgd);
+	release_queue(adev);
 
 	return r;
 }
@@ -384,13 +378,13 @@ int kgd_gfx_v9_hqd_dump(struct kgd_dev *kgd,
 	if (*dump == NULL)
 		return -ENOMEM;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	for (reg = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
 		DUMP_REG(reg);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	WARN_ON_ONCE(i != HQD_N_REGS);
 	*n_regs = i;
@@ -508,7 +502,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -518,7 +512,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
 			retval = true;
 	}
-	release_queue(kgd);
+	release_queue(adev);
 	return retval;
 }
 
@@ -555,7 +549,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
 		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
@@ -584,13 +578,13 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			release_queue(kgd);
+			release_queue(adev);
 			return -ETIME;
 		}
 		usleep_range(500, 1000);
 	}
 
-	release_queue(kgd);
+	release_queue(adev);
 	return 0;
 }
 
@@ -887,7 +881,7 @@ void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	/*
 	 * Program TBA registers
@@ -905,7 +899,7 @@ void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
 			upper_32_bits(tma_addr >> 8));
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
-- 
2.25.1

