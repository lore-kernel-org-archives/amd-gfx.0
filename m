Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC838C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF2460F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADF2460F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CBE86E8C5;
	Tue, 19 Oct 2021 21:15:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DF16E1F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIjZHzS8qk+f2Lx00xtcxG+kWvaesrXZKdQ/8FrtlI0JMG+Fp8ilqlL7nDc9AqfLzs3WLzB6u3s5fKVsjhU6g8R2XoMYAJX+Q6YpCahrCGkSdf3Z9Yvg+e39jsoMvTuHo2qIwVy6i+HBTSCPidLSajpBvfoCr9+iSM27MXywW/J8AfiCh4cmPIF2Z5kiPj/P+W2E3vMFWpGzSJeoC3WOaOhDMb3wpWpc4z3JuDBV9RShPkiZtUwglF4zh7jaeeBZMpLWrZNgP/EbpFC3gfYAbbYDuLfauBMpcWTefnD1ShflL8lC0XRFkpSXGjjEVEPjzWxnlawvYfyqIuinOH16oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UNhrWPhWzBb1M8lMfqOrGUjO4bLdmBbxERJLG51zAM=;
 b=WvCWPB+S151sMUOBHpmE44xyRlM6z9o3cUsvAwlHzYrWMe0QtBtvspuVcDXi3WSikJfylMZFUoX1Du2vlJZHnS3APreTHvSkjJFdG8NA6nJLd0xAsaioZYpcj6pF6MwdLrXs9Cx5asqw3Ij6cqF3rb/CIKj1Upe4jOfh8QDg0/CFKnZZeDL9h1Xg8b+z0yDohEvVoXVLFtz+jZWcGVa0mygWh3BPo9amnTb+CJsQDjuujVKbxpo6vrmk7dOHgM4AJ8I6YghJAG0/xB5PDwwhalsGnMmnPS/egPmhIFVUktl0Hx1tOCmkbxf5tAPgZNTXTzVYr/GwxRhmogMigNFSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UNhrWPhWzBb1M8lMfqOrGUjO4bLdmBbxERJLG51zAM=;
 b=nsTIHeyAEY4m0Xpo3PrLtFcp6OUFuq7rI7i+9ShcVlCx3txdN8K9yMJ2/SAFNPmU3bg0d8GOz8ZNkIwL1UtTGok6XCKR8gUEW1kCsWVLVJL+igpZAw36EQBOwvuVhC5SbFhHO+9lezPMhNfAKKkBuIJNGexJtYK1dDsK1EpQMqs=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by BN8PR12MB2916.namprd12.prod.outlook.com (2603:10b6:408:6a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:14:55 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::8d) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:55 +0000
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
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:55 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:53 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 03/13] drm/amdkfd: replace kgd_dev in static gfx v8 funcs
Date: Tue, 19 Oct 2021 17:13:24 -0400
Message-ID: <20211019211334.1552825-3-Graham.Sider@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a8761da-b02c-48a5-0871-08d993457f8a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2916:
X-Microsoft-Antispam-PRVS: <BN8PR12MB291647978599F922D6CADAD78ABD9@BN8PR12MB2916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFBihBOHM16hhugPsW8JToMliTQ3M8OejdJK3eGoa2HkE0g4hMcuuseEG+sU2KNNVcuVc0CxvooU0KbwzGwZrEhKcS0s/hJFGcU9pR0vQYXtDTqSDGakaNVjMFw/nTb2NCOzSFX3Os4yR3F4tR5pTiB8U36C4tFcWrhr9EHCrhQooFMGA89D0TAHyuCbNB/ulLoNj3ox3V45jQVl/RjZgjBd8IjqIQj0//UqUpxwEqa4WYWxihcHa2CykoGB9sLiXX60VxPK4DE7TQGH5FfxEhA6f65vgsp+w/63vUAzdWTm8tL7pEWPIpVGFHeRcWEVAv0WamSwDp2v51EkaVWalx+E82YUfI1KZPH8EQIXWdPrPKVaGM+ylK3RElledjEpWxl5Po7EQ/2Wmt13qRluQveI2Y+pWRGq3gJkJoRO09dgRmGgvyyK0hkpOKUazFMACeFtqMNJzwpnyVO3r58Z0DSqyjOr4wHqdFjZUQwleiaWS0dxApcHZF2A6cDazTCMjvt6EVUdwWUbyzDs5n065NG9iOz/Bux9tqzIf3dLOotcVMrSVIRpRt8EKbKp6QV9lGoPRPfJkRKVrTGKvgURO8hHsPoEQNxQejKpjLhnyt8pC/4Bh9oxU2UQBpSsewGprI5QVSKcSSOyCh99PKssFNW7YR6X5/qQ+3kXc1ipUboYudHwD0BNcYtO/KgkY1dYFTk+jVBbn2L4uMMc9qSOZ09840pwwK5oqf78GvdBd/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(426003)(7696005)(5660300002)(6916009)(316002)(70206006)(70586007)(83380400001)(86362001)(1076003)(2616005)(36860700001)(82310400003)(54906003)(508600001)(6666004)(47076005)(26005)(16526019)(8676002)(186003)(356005)(81166007)(2906002)(336012)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:55.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8761da-b02c-48a5-0871-08d993457f8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2916
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

Static funcs in amdgpu_amdkfd_gfx_v8.c now using amdgpu_device.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 51 +++++++++----------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 5ce0ce704a21..06be6061e4c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -44,38 +44,33 @@ static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
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
@@ -86,14 +81,14 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
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
@@ -132,12 +127,12 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
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
@@ -178,7 +173,7 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	/* HIQ is set during driver init period with vmid set to 0*/
 	if (m->cp_hqd_vmid == 0) {
@@ -226,16 +221,16 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
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
@@ -258,7 +253,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	if (*dump == NULL)
 		return -ENOMEM;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE0);
 	DUMP_REG(mmCOMPUTE_STATIC_THREAD_MGMT_SE1);
@@ -268,7 +263,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
 	for (reg = mmCP_MQD_BASE_ADDR; reg <= mmCP_HQD_EOP_DONES; reg++)
 		DUMP_REG(reg);
 
-	release_queue(kgd);
+	release_queue(adev);
 
 	WARN_ON_ONCE(i != HQD_N_REGS);
 	*n_regs = i;
@@ -375,7 +370,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32(mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -385,7 +380,7 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
 				high == RREG32(mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	release_queue(kgd);
+	release_queue(adev);
 	return retval;
 }
 
@@ -422,7 +417,7 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	acquire_queue(kgd, pipe_id, queue_id);
+	acquire_queue(adev, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
 		WREG32_FIELD(RLC_CP_SCHEDULERS, scheduler1, 0);
@@ -502,13 +497,13 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
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
 
@@ -612,9 +607,9 @@ static void set_scratch_backing_va(struct kgd_dev *kgd,
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

