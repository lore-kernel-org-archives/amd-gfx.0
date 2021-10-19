Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750DE60174
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 750DE60174
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FFE6E1F7;
	Tue, 19 Oct 2021 21:15:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8E46E1F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJE69iYH8daK5T29FqF+tDdguzpvlNqISuyWNfsHktk4Nbh9XPTN6wbysmK6TD30u3pzn0/DqI+q5EpDRfdl+acETIkTa1pPV7KWHRinhG53WPnQ4/3+u/Li9RrxK0AJjU61NYMj6OpWJS5bdj1FXBN4hA8CedyWh/juiFmavpcgP33VjfW1E4Uk8IKojdxgpiTr8IjvFqzwaXpBQ4bKl2alP/sxPmzG3m+HH061WLJogRIxhipdcoggeLfM7pnQBs1ULZBDQSbKUR/tZqXDJRnFdh/xuErRUsHLEzj7p9rbkNXSSzIdJS+6cDZJaguePE+afAvPv1ItfbdXBHSX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21dYagi4ZLJ7i+YxCve8a8ooTCsOa6T4wTzqMVPCa64=;
 b=FCVww9j3U8lXuvJGvH1E3uEYHk9CzEFM/Ww7rbbeZnTAv20y8ijjcZ4WE72TK7OF5GojglTT4VK5dJfA2hG71HkP/mzqeovgKKnaMH0YjEgFb9UkfOylkOYLCBBDLu1szkTtPdPArV3uVoDGaVAq/K9Z+2u7j5W800Cvp/j2agC6EHQQ1CQ99nWW3ejBkZAtkaL3PecRKSP4PXbwMawtRIsP5Ctx/yRczn19DUi0dhi5FPbpYRWnG15jfxqMIXQ9luAmd3Xdx8Z16W+h99zBOXcsqKzjEhXh4zpgHp1g57CRCS4UV79jGOCSKy084BydPrxnIi4iFO1uSIVwd56+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21dYagi4ZLJ7i+YxCve8a8ooTCsOa6T4wTzqMVPCa64=;
 b=w6a2ZMdiqbHg2R6pl8gmir8AxC5VQi1IgRpiMptTgNSSLXfKrbrg+7qVSo4+VBK4gqdMx5t1oq12vxctr5ROolhlb7XfQYY7PmlNPuTzvbRjrTvJv7EExJXuZ/+uIQ9VpC1bpWPbW6khHOu/rZPtxv6iC1zkDOx0FkoN9EctdQU=
Received: from BN9PR03CA0301.namprd03.prod.outlook.com (2603:10b6:408:112::6)
 by MWHPR12MB1616.namprd12.prod.outlook.com (2603:10b6:301:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:14:57 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::58) by BN9PR03CA0301.outlook.office365.com
 (2603:10b6:408:112::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:57 +0000
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
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:57 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:55 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 05/13] drm/amdkfd: replace kgd_dev in static gfx v10 funcs
Date: Tue, 19 Oct 2021 17:13:26 -0400
Message-ID: <20211019211334.1552825-5-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce285456-2028-4918-18c9-08d9934580e0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1616:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1616968BF95129FCDE10FE568ABD9@MWHPR12MB1616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnGDHN1xdDkvXngm5THDzXE+H4WiQDTYOIOb8alexZJR8drWfp2J2LluTLG9HZQ3AfmubnvptqVdDBPVGt/5F3E970hHdpc+5yPj9bGtSj65WH9XUWhSwC1UkCaaMChKWl9IfAiOOPqeUVfmRLah8MGvSX/wbBdyPUwsalqSa1dk5WoE3k6qb5BKLC8hGM0regXJhvaS0yWrv3+VFYMc6sxH+yOBpP7zwBHMZeSv42SP7ZHEYC/8EUZLOGvSurlt8Lc972V6k5XQyIwBcSecYUIBIrNUaAmx0qQ6oGCpqeRc6N9r523T03IZ1J+thf6EixHTz9dCI8O7NTqIwEJvjHEQF+9SfC57aAKDOzj2lKiNmpHmHoS9jEO63VmTQhV0eX0TYiPEUId2iuscaZ4QBtf6P8DLYcdHDhdo/D4EOI4nq9vxAyYs5wqM23S9MIn6yy1flrs8r5gBKcHeXHOE/9mtJ7bkA8uj+U8hc0Zb8lh2MyqY5YhURYA2rMqRDMtM17v9lexvRbApk+pGRJ8mJnErjT6s7iRV26FXznusiFbW8AKN0P251qDManF3jFh70/5OyxyCqKAcD6nEaIVOPE8fEMCY7xqEFPBDSTHUyztwo4NMjv8L+nHEPRX4PwlHhWcnH3xtOYjURGlTiHUionDyDt1sGtM2laqSEXXrMmpwuiGD+KsUs6+TaUicveswAbC9VDxtathlT0038KCe509W7di1KeQTwaHSy3W0yHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(70586007)(5660300002)(16526019)(336012)(426003)(2906002)(356005)(81166007)(8936002)(186003)(316002)(508600001)(8676002)(47076005)(86362001)(6666004)(2616005)(54906003)(36860700001)(26005)(6916009)(4326008)(70206006)(7696005)(1076003)(83380400001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:57.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce285456-2028-4918-18c9-08d9934580e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1616
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

Static funcs in amdgpu_amdkfd_gfx_v10.c now using amdgpu_device.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 52 ++++++++-----------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 960acf68150a..69aee5b52f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -44,32 +44,26 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
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
@@ -81,9 +75,9 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
 	return 1ull << bit;
 }
 
-static void release_queue(struct kgd_dev *kgd)
+static void release_queue(struct amdgpu_device *adev)
 {
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
@@ -94,13 +88,13 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
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
 
 static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
@@ -159,13 +153,13 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
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
@@ -231,7 +225,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	m = get_mqd(mqd);
 
 	pr_debug("Load hqd of pipe %d queue %d\n", pipe_id, queue_id);
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
@@ -296,7 +290,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
 	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	return 0;
 }
@@ -313,7 +307,7 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
@@ -349,7 +343,7 @@ static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
 
 out_unlock:
 	spin_unlock(&adev->gfx.kiq.ring_lock);
-	release_queue(kgd);
+	release_queue(adev);
 
 	return r;
 }
@@ -372,13 +366,13 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
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
@@ -496,7 +490,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -506,7 +500,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	release_queue(kgd);
+	release_queue(adev);
 	return retval;
 }
 
@@ -548,7 +542,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	int retry;
 #endif
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
 		WREG32_FIELD15(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
@@ -633,13 +627,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
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
 
@@ -762,7 +756,7 @@ static void program_trap_handler_settings(struct kgd_dev *kgd,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	/*
 	 * Program TBA registers
@@ -781,7 +775,7 @@ static void program_trap_handler_settings(struct kgd_dev *kgd,
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
 			upper_32_bits(tma_addr >> 8));
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
-- 
2.25.1

