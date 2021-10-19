Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EF6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5975460174
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5975460174
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A916E0C4;
	Tue, 19 Oct 2021 21:15:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185B36E8E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+WTg1IR4IiCOeuPWlBHiLKDumPpeKTUOtXWCQ0vAsF8btSfJGZz+SXrI19ZrXwmKOy5OmFWjCNtJzxmCsp0foyl18qEaQLqzK/yuFi1AOmHj89zpnklLI8OiXAdtFMeMRo9vJ471Qa3FYZNZjyjrZnGxbgXFIV7J1MFHWWT7Li93eHu2a+9CJeyDDAj3dLeNJ3pKaOjP9+cSFqqfamxcAs0bG3WPgMl8LBBJ4UAhwrojo9yEpW8HHrvilCXzqOgaZKfw/sSVHBB3v+vhz9RHnqhXF/LUQFOfTaq2jrlq5PrrDd4DtapdO3nfhs2mQwOihT5DxNx/JTGBjzYlxPJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs82ZVqbxntxFOrg8yd2XFiyxsFCcK6+vmQBDFQLHfU=;
 b=Sjs7MIBpk1J7cwEuXp6h7w2+FXStgomkSWt9YUXkRiq4UrMChPXSRWy8qa6pvbJk88+4poWkXk1FAPGNJ3b76uyNaEc42RE0evwzlyPz4Iuyp6+8azeg0jl3np3HYzg0SnkunHzUNqBUWFJMRMgjpjuBQPSF/EGjdXnrCeXYwG0JrF/7ToaGg3vpP1If353capO1QmAPJfAhaw43n9yu2UAmAoiVyxyO4Z4U7H5fiJgwx6C9zV1cMWZxy2b8S5NbkYjx4D5/0zZcJmT/XpPTOfnhI8bRBfeww2gzbuAwAZ8kPt08ubJ5/u2cOniM6+y2JbbYLdfFAIp5acLeFijv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs82ZVqbxntxFOrg8yd2XFiyxsFCcK6+vmQBDFQLHfU=;
 b=Pa0u7BVFIwg23bwiyvGkVEolReTnBedWayn6y6bEZyID9hRUjIz2SJHY5rEPNkRmNWYyJEDlchcl5jdvmse+XaFRRLUvhZ5bet5LcA15+lPw4bBVhCXlrfqHtw5v3/s6PKAZjbj+zViEEV1TgCTJ76yzuXnNmQEVETuZt+W3v70=
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Tue, 19 Oct
 2021 21:14:58 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::4c) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:58 +0000
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
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:58 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:56 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 06/13] drm/amdkfd: replace kgd_dev in static gfx v10_3 funcs
Date: Tue, 19 Oct 2021 17:13:27 -0400
Message-ID: <20211019211334.1552825-6-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a60832e-d397-42a3-bd4c-08d993458168
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4070140502E774E377F63C738ABD9@CH2PR12MB4070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQEOPhdTENkY0/Apoc4FgCpnCJN4dCCe6f0F0IzEW/kGnghiuJaelxfbmPfHR/hlbv0csEOl2aYqM/giHFo7U8rn6tyUdcFeUOIrY5ihXelgZ1SuYkygYmP9hefRGH0heGGqNFYs2GoetFHTW8XSyZ9Nz5U/zViWHJ5H+6Uv2blKGG7hrsO9wZuDwWAWYPFD8P0f7iBwXodvpLA0GC5l5tVenjLCqfibRua5Rg7w5ADF7yWs5rhcOzr0ihVhGHM0erbjzSOA2YXtdCijy6c0dEC8viYtVc2zYV1O5cJE4WXEn9x8kGjTB13JU5enZbjrohf0u1Ny2dSBJGxXUqGKALxbR1+SZhtXAbuX0qhe4gknuSwugA+dxCAmPFOBnsjmg7ly7b3WminhFBMcWOglrVoQ966CUwJ8EiP286qQW44XsCNWRQqE9gdFI7NZHh1NpA+oglThW1pdC0cu8bNyX/6LzdVCOww92MwIIWZ41rA11yhwW50YBWxHX1xwzkssjbs19A8O0+4/3z31fmpW51ghlZcO4eMt1g8ZdZiNa+UDmECaWzrrmFDFjL+AIeg0tGgJ4CphcIGC9/1ntYnSgI9tx9oGdwbd4jntwwzbYDHEC1MnA7zolnFL6o3lOOvRb31oj2O4+2ZC+3GMpTXXiCadmY2wKyAZgVvzMOpDcMuQfEdtxQB1mgY3U+f0dWTP3646es52SYppZ/K1femXXyB16/6xgEQo3YZrmNgx+ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(2906002)(81166007)(186003)(26005)(7696005)(8936002)(54906003)(336012)(4326008)(82310400003)(8676002)(5660300002)(47076005)(6666004)(36756003)(70586007)(1076003)(2616005)(36860700001)(508600001)(316002)(16526019)(83380400001)(356005)(70206006)(6916009)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:58.2367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a60832e-d397-42a3-bd4c-08d993458168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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

Static funcs in amdgpu_amdkfd_gfx_v10_3.c now using amdgpu_device.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 52 ++++++++-----------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index dac0d751d5af..b33a9fe715cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -43,32 +43,26 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 	return (struct amdgpu_device *)kgd;
 }
 
-static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe,
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	mutex_lock(&adev->srbm_mutex);
 	nv_grbm_select(adev, mec, pipe, queue, vmid);
 }
 
-static void unlock_srbm(struct kgd_dev *kgd)
+static void unlock_srbm(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	nv_grbm_select(adev, 0, 0, 0, 0);
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
@@ -80,9 +74,9 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
 	return 1ull << bit;
 }
 
-static void release_queue(struct kgd_dev *kgd)
+static void release_queue(struct amdgpu_device *adev)
 {
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 static void program_sh_mem_settings_v10_3(struct kgd_dev *kgd, uint32_t vmid,
@@ -93,13 +87,13 @@ static void program_sh_mem_settings_v10_3(struct kgd_dev *kgd, uint32_t vmid,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
 	WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 /* ATC is defeatured on Sienna_Cichlid */
@@ -127,13 +121,13 @@ static int init_interrupts_v10_3(struct kgd_dev *kgd, uint32_t pipe_id)
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(kgd, mec, pipe, 0, 0);
+	lock_srbm(adev, mec, pipe, 0, 0);
 
 	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
 		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 
 	return 0;
 }
@@ -201,7 +195,7 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	m = get_mqd(mqd);
 
 	pr_debug("Load hqd of pipe %d queue %d\n", pipe_id, queue_id);
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	/* HIQ is set during driver init period with vmid set to 0*/
 	if (m->cp_hqd_vmid == 0) {
@@ -281,7 +275,7 @@ static int hqd_load_v10_3(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
 	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	return 0;
 }
@@ -298,7 +292,7 @@ static int hiq_mqd_load_v10_3(struct kgd_dev *kgd, void *mqd,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
@@ -334,7 +328,7 @@ static int hiq_mqd_load_v10_3(struct kgd_dev *kgd, void *mqd,
 
 out_unlock:
 	spin_unlock(&adev->gfx.kiq.ring_lock);
-	release_queue(kgd);
+	release_queue(adev);
 
 	return r;
 }
@@ -357,13 +351,13 @@ static int hqd_dump_v10_3(struct kgd_dev *kgd,
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
@@ -481,7 +475,7 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -491,7 +485,7 @@ static bool hqd_is_occupied_v10_3(struct kgd_dev *kgd, uint64_t queue_address,
 		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	release_queue(kgd);
+	release_queue(adev);
 	return retval;
 }
 
@@ -525,7 +519,7 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
 		WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
@@ -555,13 +549,13 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void *mqd,
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue pipe %d queue %d preemption failed\n",
 					pipe_id, queue_id);
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
 
@@ -666,7 +660,7 @@ static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	/*
 	 * Program TBA registers
@@ -685,7 +679,7 @@ static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
 			 upper_32_bits(tma_addr >> 8));
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 #if 0
-- 
2.25.1

