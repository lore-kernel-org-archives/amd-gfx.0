Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED5960174
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9ED5960174
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A5E6E0CC;
	Tue, 19 Oct 2021 21:14:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC736E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsJgpTdgTQbjYDU4dLj0TbWdfzsEQjGgiupzPqkPwc7Uu22Iw0sMmd6cmZTYXIMczp8dhyCgUvVE5gFhjb/sI1qJA7AKguFewBkLIxAnvkw/tzv4X6zB1c0pzZnOT0Ws7CxmkMosis86G89Kp5Dm26uN3MXs1R7xN5mMpXZKGZC3/p/DovOq64F0/KfAOxTr9g1gvm+34ZK6CswY99Ho51K4/hgZlmUlqIyaWC5d6PMhAi/MrE8xSIVbTbQ8JPQwKrI+1pETEpEGd78OeX8dizqb1A9Qey/G2opngtC7QXSuATgN47ppfsQWS3SvAj/Uyun3TUJANF3xOT1sobp5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HUteE8eqp0NWldrvV/98PDoGXiSvPrzeulxi7lJQVc=;
 b=hYIVUZnvYrK/eIkXhD9LSzAkpb/28rS7ls9RnoF34dljJW3vVcVQcOn5blmCc8yuW3TU4r92Eus0aJaPi//Kc1zZIZiL9ah5eIhgY0ss7aNx8MQ/w7mfumyvagHqJGDgsA8U9c/v17N2jkx/mX4drBUQ6f48LQC9mydqgkGcJ6c9BnHJD4WV1qh+nLlaFiERXcZj4rgNq8gra3nUAhoxRRb8A7U+DLrMnq1BA0UcQVO02VAFPorr9PMsW0KUE2g20u/cofBlIl4RlUob9SUE7mulYjA3Q6pH17/KXAVU/w1mNfxUaX155ISTjquqHLRDjXLUBNpeltqKY14LGFZjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HUteE8eqp0NWldrvV/98PDoGXiSvPrzeulxi7lJQVc=;
 b=lOeY0pbmn0WJ79DmsaUJFNYt8DsPKj01/g1VO5RJSZhag+6mEY0uUI2c1sskC91ovKDIcI6oy8JrAvOencmABGQHd8FnV4VZ8M8kZ5jf1NgrAECgznfSBAqt7yked+LpgWXLB6O36jZJBrnqOecabPH1hPL8klumlSK0zBpt/D8=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 21:14:54 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b0) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:54 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:53 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 02/13] drm/amdkfd: replace kgd_dev in static gfx v7 funcs
Date: Tue, 19 Oct 2021 17:13:23 -0400
Message-ID: <20211019211334.1552825-2-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf5f3b9d-dd3e-4d94-c21d-08d993457ee4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5146:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5146E7094785CDEFCC38554F8ABD9@BN9PR12MB5146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsczgzFiMKzMTePyHaqj2rqtljJnoa8ShJOE+np5stLa+6wq6i5YQDG7bR/6f1goZkJq9cwujjvR+jypvQplKW9RtDgsiXzYj0HUiu9Pwe+vCyAjyh2nUZZyChkWgxu1Q9J2XJKGPx35+91Zd7M24QigccZJJ+s0fLdsPwYgixKMHnR+FhrZsusQve3FmXEku267wGa599V6OgzWix99FozHEIwpRwnvZJ16aOU/0Vcx0enZyETNrGD7UzbDb7YxE05ts/Sgsd6fVem9imkCbJWWpEmy0uZu+ZhDOuvU6z35loMgkwDsSl8MlG+McT+n1QjiNDV+eSLpAbR9NMGuX/DVLwfcRosh7wlbt1w22ofEIphPzdvIN5qrHMY4CzoYQdYLQ5Q4sxK2QMYNRSmieDmG6BGASvzdRwEBvDrGdeQxqegz1+M2NrHSPxnjuJwUMb3TtVFNAIpHbFkGdhFvl+R265qi/cd+0hX5fntV3V7SUvJtpWaAYpLYwDYdX3nUp1cmq9MIrk0Tuh8EQFMs5RRUbAug137Bcy4/mQl7zmEmNyUHWfNxdjlx6lxLdc2H6phujguM86lK+tObj85CWb34gI0J+yBmJRwucnl8yHml/j1OTnkoCqvXsmN/YF6dI1kNLegVmmGm2+N5ipddy24jxG2qb5H8yyWXldjx6XHtIP2vvHgceG1YiLYgM5/whUuMobGmwjaWwjyRcj6mYE3BcuRIfyorYvtWL59SJr4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(70586007)(8676002)(2906002)(54906003)(36860700001)(426003)(316002)(81166007)(83380400001)(70206006)(6916009)(336012)(8936002)(26005)(4326008)(1076003)(86362001)(508600001)(82310400003)(6666004)(186003)(356005)(7696005)(36756003)(2616005)(47076005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:54.0153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f3b9d-dd3e-4d94-c21d-08d993457ee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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

Static funcs in amdgpu_amdkfd_gfx_v7.c now using amdgpu_device.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 51 +++++++++----------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index b91d27e39bad..d00ba8d65a6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -87,38 +87,33 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 	return (struct amdgpu_device *)kgd;
 }
 
-static void lock_srbm(struct kgd_dev *kgd, uint32_t mec, uint32_t pipe,
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
 			uint32_t queue, uint32_t vmid)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 	uint32_t value = PIPEID(pipe) | MEID(mec) | VMID(vmid) | QUEUEID(queue);
 
 	mutex_lock(&adev->srbm_mutex);
 	WREG32(mmSRBM_GFX_CNTL, value);
 }
 
-static void unlock_srbm(struct kgd_dev *kgd)
+static void unlock_srbm(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-
 	WREG32(mmSRBM_GFX_CNTL, 0);
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
 
-static void release_queue(struct kgd_dev *kgd)
+static void release_queue(struct amdgpu_device *adev)
 {
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
@@ -129,14 +124,14 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 
 	WREG32(mmSH_MEM_CONFIG, sh_mem_config);
 	WREG32(mmSH_MEM_APE1_BASE, sh_mem_ape1_base);
 	WREG32(mmSH_MEM_APE1_LIMIT, sh_mem_ape1_limit);
 	WREG32(mmSH_MEM_BASES, sh_mem_bases);
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
@@ -174,12 +169,12 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
 
-	lock_srbm(kgd, mec, pipe, 0, 0);
+	lock_srbm(adev, mec, pipe, 0, 0);
 
 	WREG32(mmCPC_INT_CNTL, CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
 			CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
 
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 
 	return 0;
 }
@@ -220,7 +215,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_MQD_CONTROL. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
@@ -239,16 +234,16 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 	 * release srbm_mutex to avoid circular dependency between
 	 * srbm_mutex->mm_sem->reservation_ww_class_mutex->srbm_mutex.
 	 */
-	release_queue(kgd);
+	release_queue(adev);
 	valid_wptr = read_user_wptr(mm, wptr, wptr_val);
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	if (valid_wptr)
 		WREG32(mmCP_HQD_PQ_WPTR, (wptr_val << wptr_shift) & wptr_mask);
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
 	WREG32(mmCP_HQD_ACTIVE, data);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	return 0;
 }
@@ -271,7 +266,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	if (*dump == NULL)
 		return -ENOMEM;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE0);
 	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE1);
@@ -281,7 +276,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	for (reg = mmCP_MQD_BASE_ADDR; reg <= mmCP_MQD_CONTROL; reg++)
 		DUMP_REG(reg);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	WARN_ON_ONCE(i != HQD_N_REGS);
 	*n_regs = i;
@@ -380,7 +375,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32(mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -390,7 +385,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 				high == RREG32(mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	release_queue(kgd);
+	release_queue(adev);
 	return retval;
 }
 
@@ -426,7 +421,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	WREG32(mmCP_HQD_PQ_DOORBELL_CONTROL, 0);
 
 	switch (reset_type) {
@@ -504,13 +499,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out\n");
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
 
@@ -651,9 +646,9 @@ static void set_scratch_backing_va(struct kgd_dev *kgd,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
 
-	lock_srbm(kgd, 0, 0, 0, vmid);
+	lock_srbm(adev, 0, 0, 0, vmid);
 	WREG32(mmSH_HIDDEN_PRIVATE_BASE_VMID, va);
-	unlock_srbm(kgd);
+	unlock_srbm(adev);
 }
 
 static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
-- 
2.25.1

