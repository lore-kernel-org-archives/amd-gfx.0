Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A46FEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA19510E601;
	Tue, 24 Mar 2026 21:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6RNvk3v";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A5710E326
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmsGu87jFH2rn1xukIvjyxY7mnWrNBV+d8ql65DfSKhHkemWkDYhxjapJz7zZHwS6mH3F/mT+CEfGCg78lK9HjzKFK4jaky6XetmdvLpAAjU8MXBq9eYL1awa0GUXlgAuj5gtEedtaQQS8mRSdX+FbKzGKVFdpwrI/LwOUoZ31jQDh5dcKGi+/TcRELsJrXQvtb0diIepAPTiYb8Nmedd8Y6/nRZ/zm2TQWv9QZwxlIAIg5RqOrVxIhDovtBOqcblxsVkjfaY0ihRF2IzQNvYQ1rDKccecKEGlFNBmwBE2h43RPR3yFmuHjpVJ4+pooepeYtvLHungB7fIAbpU4a5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU6nN43KeqqMx+aRzWoS9s+i8D1/ZSICwKLNBDVMYio=;
 b=mypwJ28gBEK4s76oB8Z74uh7G1iRV3yGUh8KJkBGRjQ/y90vJDs0oW8ToWdJe2FX22o0Yeh3PCwBxdK/PpgvNm1xqgcBOppptjqf/nU0+HbPknjUiXLdxE38i2SwRAVyh4NkdMeI9yYmeGGSZnc76AyQu5LNptJRsildPQkQ8yKe52tbG6gveS4OFqpB+gnMSk9aWeJeKufmrfb0rhNKW5HjmFHdugs95yO+xiqNbbuUcW11laBOfsWyVxGwDmeyiKKrhOWyoQel5DGkYSDQc2ojbzzwEN+b9SiEuOM34WkHExzgPYpdB4htaz/h2ODkyzQlCIXH5GbrpjICXi50FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU6nN43KeqqMx+aRzWoS9s+i8D1/ZSICwKLNBDVMYio=;
 b=M6RNvk3v0j4npjkRDvA51/h0QPUEqc9tp9OH8/72yx3SEuZ0CPUjOPagxpTEr4G0Gpqyv5MVfqhPkcj00OgCKywl0FsCzxbP47/dwQhH2mspmgVqHMJp8q8Xvd5+S01fT2QfnMbOczT1v50J9ddIWUxYFD1qjYyLh3ivZlqPtYY=
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Tue, 24 Mar
 2026 21:20:59 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::12) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:46 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 13/17] drm/amdgpu: implement data dump from spm ring buffer
Date: Tue, 24 Mar 2026 17:20:26 -0400
Message-ID: <20260324212030.822932-14-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edde23d-0d42-49b0-e88d-08de89eb3e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: RebQLa68icUhsMZy7bs1KllBGVrx7dMxnjXHcimiLWg8LqsYFdptzvIiLhMHPHsSAOFgIcDFJzvzDdo0oSiagz5Y9t+UUzLQSEAu3TbUr/CdrHpqUFZXagV+EbJha43bnrfnhgxw+ubS8LmOZgcEZnsaqtYadYC/L4ExRb52TrZHducZnmVG4SKmd/5FNw4wjtJBqsWNURVQ5iMhEfwMAULu7Tw/eeye6hrWUJhh7ShGDYBmVlOk0NWNiU9m0Aqg90ENL/MbRxEAL8MNQ8LdxhTm8nCsL5GUG8Et2tMtaGx9nfRD2jfNIW3kZ1SP/ScvZrtlwVHx8m9Pi5J4FHm/204uxdpOQsWxCKzcFZU/ZTYlRJPJ+NhXCjZUlOgChOOJwbaJnN66Ci6xqQLF113wZ+xpmZ/nyvNDoU3Rxe0xudwgKSgLFbeueLHwll0qsAOC7zr1Uk+vUdZMa0HZHlr40l3NRln82dNCGG6PdCbnDKXUsvZHs3YzkoukAMYoMk+/clg5ydvtwipj6AvQYvIHcdNeF+EnybIaMMjO2tx1sfm8DjVtZh/1fe9dF4Foj64acCJ24aW+gEEJ54xgdUpc2XGmYd8IYovExjjqqR9K7g+V+ygx6Vov7cA6Pa/4s69EIbVNfksLVsmQTSroHFnUDRSfGqy2zBUCOTROk0P/BwOBCJfrJUUWHwzs28LQGhYuvCHff7q2TJAi6W2GfrkubdHkUsdbYl7XvedavgVYIDaZFRdaG7pobY0kCOU6qRJSAv50+HJvx85rDBJIb22v7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xD/h9v+nsDjIcP+lRlnpT2u98E2BlXkfS4f3Akl2tlI/7Axjh21a9nzknt5VhriHwLe8BeniUmlbwlILp8kzWHslwnsHBSZHrQrqOIaQvsZwR6pzMagAkKT/epggKZiuqX2eSDg5xtdznVNCdATvwgjO8YHtd6kOX6IB5WHhDJAZ4oDyvzNBM5ExTb2PEuUmtsFrb6Pi0sDscZCZkzgGN8Bf+feoKmANUaYu8AlEXT6JU2nbuqGpSi5SsIcFakiP9+7a43/B5jw03sRac5vuMZMMLdxjbIZOi4oBgirrJEwx2C6FYmBnUIGH3LZb5LB24jJv2zdVPLKt8VeBMrMdE9ZzJ4jW6dEuzJEC+zuLFbD5GsB7Rcyc7Dvwv9U0LtZUbwg4H76Itb3IQMTXn0EILwQHqznsm+iiGdwWh+0wL9HbqhERNErT2/xnrlFcYEOF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:58.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edde23d-0d42-49b0-e88d-08de89eb3e3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

to complete the amdgpu_spm_work() stub by implementing the full
ring buffer drain pipeline: reading the hardware write pointer,
copying counter data from the GTT ring buffer to the user-space
destination buffer, advancing the hardware read pointer, and
waking up caller once any XCC buffers are filled.

amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst):
  Copies size_to_copy bytes from the kernel-mapped GTT ring buffer to
  the user-space destination buffer for one XCC instance.
  - Per the RLC hardware spec, ring_rptr=0 maps to cpu_addr + 0x20
    (the ring data starts 0x20 bytes past the base of the BO).
  - The destination user_address is computed as ubuf.user_addr +
    size_copied (continuing from where the previous copy left off).
  - If size_to_copy fits within the remaining user buffer space
    (ubufsize - size_copied): copies the full amount, advances
    size_copied and ring_rptr by size_to_copy.
  - If size_to_copy would overflow the user buffer: copies only the
    remaining space (user_buf_space_left), sets size_copied to ubufsize,
    advances ring_rptr, and marks is_user_buf_filled = true.
  - Sets has_data_loss = 1 and returns -EFAULT on copy_to_user()
    failure.

amdgpu_spm_read_ring_buffer(spm_mgr, inst):
  Reads the hardware wptr from cpu_addr[0] via READ_ONCE() followed by
  dma_rmb() to ensure ring buffer data written by the GPU is visible to
  the CPU before processing.
  - If no user buffer is registered (has_user_buf=false) or the current
    buffer is already full (is_user_buf_filled=true): sets has_data_loss=1,
    force-sets is_user_buf_filled=true (to handle the polling timeout
    path where the flag was not previously set), and exits. This signals
    to the user that the SPM hardware may stall.
  - If rptr == wptr: no new data, exits immediately.
  - Linear case (wptr > rptr): calls amdgpu_spm_data_copy() for the
    contiguous segment.
  - Wrap-around case (wptr < rptr): calls amdgpu_spm_data_copy() for
    the tail segment (rptr → ring_end). If rptr reaches ring_end exactly:
    if wptr == 0, resets rptr to 0 and exits; otherwise resets rptr to 0
    and calls amdgpu_spm_data_copy() for the wrapped head segment
    (0 → wptr), skipping the second copy if the first failed.
  - On exit, calls amdgpu_rlc_spm_set_rdptr() to inform the hardware
    of the updated rptr, preventing ring buffer stalls.

amdgpu_spm_work() (work_struct handler, previously a stub):
  Attaches the lead_thread's mm via kthread_use_mm() to permit
  copy_to_user() calls, then under spm_worker_mutex:
  - Resets are_users_buf_filled to false via WRITE_ONCE().
  - Calls amdgpu_spm_read_ring_buffer() for each active XCC.
  - If any XCC's is_user_buf_filled is true, sets are_users_buf_filled
    via WRITE_ONCE() and calls wake_up() on spm_buf_wq to unblock any
    thread waiting in SET_DEST_BUF.
  - Releases spm_worker_mutex before calling wake_up() to avoid
    unnecessary lock contention on the waiter's wakeup path.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 117 +++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index d4af195bbcd2..9f0d1f688d5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -35,16 +35,131 @@
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr, u32 size_to_copy, int inst)
+{
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	uint64_t __user *user_address;
+	uint64_t *ring_buf;
+	u32 user_buf_space_left;
+	int ret = 0;
+
+	if (spm->ubuf.user_addr == NULL)
+		return -EFAULT;
+
+	user_address = (uint64_t *)((uint64_t)spm->ubuf.user_addr + spm->size_copied);
+	/* From RLC spec, ring_rptr = 0 points to spm->cpu_addr + 0x20 */
+	ring_buf =  (uint64_t *)((uint64_t)spm->cpu_addr + spm->ring_rptr + 0x20);
+
+	user_buf_space_left = spm->ubuf.ubufsize - spm->size_copied;
+
+	if (size_to_copy < user_buf_space_left) {
+		ret = copy_to_user(user_address, ring_buf, size_to_copy);
+		if (ret) {
+			spm->has_data_loss = 1;
+			return -EFAULT;
+		}
+		spm->size_copied += size_to_copy;
+		spm->ring_rptr += size_to_copy;
+	} else {
+		ret = copy_to_user(user_address, ring_buf, user_buf_space_left);
+		if (ret) {
+			spm->has_data_loss = 1;
+			return -EFAULT;
+		}
+
+		spm->size_copied = spm->ubuf.ubufsize;
+		spm->ring_rptr += user_buf_space_left;
+		spm->is_user_buf_filled = true;
+	}
+
+	return ret;
+}
+
+static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	u32 size_to_copy;
+	int ret = 0;
+	u32 ring_wptr;
+
+	ring_wptr = READ_ONCE(spm->cpu_addr[0]);
+	dma_rmb();
+
+	/* SPM might stall if we cannot copy data out of SPM ringbuffer.
+	 * spm->has_data_loss is only a hint here since stall is only a
+	 * possibility and data loss might not happen. But it is a useful
+	 * hint for user mode profiler to take extra actions.
+	 */
+	if (!spm->has_user_buf || spm->is_user_buf_filled) {
+		spm->has_data_loss = 1;
+		/* set flag due to there is no flag setup
+		 * when read ring buffer timeout.
+		 */
+		if (!spm->is_user_buf_filled)
+			spm->is_user_buf_filled = true;
+		dev_dbg(adev->dev, "[SPM#%d] [%d|%d] rptr:0x%x--wptr:0x%x", inst,
+			spm->has_user_buf, spm->is_user_buf_filled, spm->ring_rptr, ring_wptr);
+		goto exit;
+	}
+
+	if (spm->ring_rptr == ring_wptr)
+		goto exit;
+
+	if (ring_wptr > spm->ring_rptr) {
+		size_to_copy = ring_wptr - spm->ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+	} else {
+		size_to_copy = spm->ring_size - spm->ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+
+		/* correct counter start point */
+		if (spm->ring_size == spm->ring_rptr) {
+			if (ring_wptr == 0) {
+				/* reset rptr to start point of ring buffer */
+				spm->ring_rptr = ring_wptr;
+				goto exit;
+			}
+			spm->ring_rptr = 0;
+			size_to_copy = ring_wptr - spm->ring_rptr;
+			if (!ret)
+				ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
+		}
+	}
+
+exit:
+	amdgpu_rlc_spm_set_rdptr(adev, inst, spm->ring_rptr);
+	return ret;
+}
+
 static void amdgpu_spm_work(struct work_struct *work)
 {
 	struct amdgpu_spm_mgr *spm_mgr = container_of(work, struct amdgpu_spm_mgr, spm_work);
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
 	struct mm_struct *mm = NULL;
 
 	mm = get_task_mm(spm_mgr->lead_thread);
 	if (mm) {
 		kthread_use_mm(mm);
 		{ /* attach mm */
-			/* TODO: dump spm ring buffer to user buffer */
+			int inst;
+
+			mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+			WRITE_ONCE(spm_mgr->spm_cntr->are_users_buf_filled, false);
+			for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+				struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+
+				amdgpu_spm_read_ring_buffer(spm_mgr, inst);
+				if (spm->is_user_buf_filled)
+					WRITE_ONCE(spm_mgr->spm_cntr->are_users_buf_filled, true);
+			}
+			if (READ_ONCE(spm_mgr->spm_cntr->are_users_buf_filled)) {
+				mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+				pr_debug("SPM wake up buffer work queue.");
+				wake_up(&spm_mgr->spm_cntr->spm_buf_wq);
+			} else {
+				mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+			}
 		} /* detach mm */
 		kthread_unuse_mm(mm);
 		/* release the mm structure */
-- 
2.34.1

