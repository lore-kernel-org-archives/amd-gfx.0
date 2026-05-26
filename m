Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274DCD6E42
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4860F10E68F;
	Tue, 26 May 2026 14:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MXglH8Ia";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9772510E68C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8fI983r3NDXh08XUoQrioa9qTu1Ml9kP5WJYIhliVW4JuG677SNwc3qVjmEhtJ2t3h21fc8ELT4KKcnub1al11WvkXKhNEo54O/NZGunwhNdD8O+t2+8vHZewDD7t2TX4btUHrVVN442XjrPn+jb2ojkXCZPkylb/cBbwEoTqOoP+QoonkSiuHz9LQPAYSBRZOtf1r3nFL4zJ/MJemrAh2SG/V2wUuFmsMt6w28MDRm7TbRkE25DEv3t1SWaJ3P5b2TQ+eTCu573GDrdWPAXPlBvKdz3tyIV5lFb4kZUbZ6A3OGkJBf77laDaUYj7d/7VlamswkmIcjmlOiN5OeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0l6P8zXs625mZwC17KEuEgsYWLkibgNNqnB3JJq2NE=;
 b=Cy46xegIjeBNQbfL5DcSUTlRXWoHI8FFi/YfHo/+3VTBeHD+X0RkXLtGd5QxNpC7rOWh7v+hWy4A7ILOsfpZTWxve8Q2wyU9GLkWe7dtGQjDyGPqodpkKvOUdLf1I+y3JApO/4KF1VMm67KrI7HNXeL3JlgByJmWw0qyTikN71/As4ndr3AXCJ9n+a2psdMhc6URqfMFu0s6H0UB36Uv0tp1CV5qDm9bNbtdwGN6G7ZVymlvp30HQMrXp9t/xVyvLJHfa8eyOj2x88ENIdIriYmgoW6yBapEbM6HrshS2bzw01SCI3wu0obpLRYjPVljGxsMSG2vHd/s8JCyrUkgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0l6P8zXs625mZwC17KEuEgsYWLkibgNNqnB3JJq2NE=;
 b=MXglH8Ia7YMfWZeQYOuecdzpNdSIGezTd38Q0VHjYeFcoDd04wjGDOTecFNMNsUMTrb9/jWvi1BTWyCM/aLaTOzIMk3yAUSkicJrGVKTphEzlKUzE/8XQGHCW8Es6dwmBK1XRgOAb/xCLjjvwUrRNFVKNBwvFW04XpT9mQmkrt0=
Received: from BN9PR03CA0665.namprd03.prod.outlook.com (2603:10b6:408:10e::10)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:12:04 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::aa) by BN9PR03CA0665.outlook.office365.com
 (2603:10b6:408:10e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:12:04 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:54 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 13/17] drm/amdgpu: implement data dump from spm ring buffer
Date: Tue, 26 May 2026 10:11:25 -0400
Message-ID: <20260526141129.592886-13-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: c587bff1-8da6-4265-aad9-08debb30c34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|6133799003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: nX1gIVtan/GDbhxoVO/ZCbw/LZ69L4LNU/fQosC8S4f++Imf2Gu7Jh5c4ZCGs0AmZP2B+4xEJ8LIYzUWyKEy49ZI8OMaYm5zbNL3z6PhOO09urRfrCcUiBh2VAZS4WntojvKJxNw4VXd/yz0MsWMjqB9V5xeKw/kLb4evRVrrAqCxSpJ9f1nX0DCa9FMVPCJyn5n/CZ86bBd//cFKlsCv+A1cdd2nq4rSxk958A1Xydsund+xVtllHGbLdmWnO2dNL5cj7WdK5+ypSxeDx46TXjplCi/ANKGwE/jq9eoAd6XCNnPbgDzIgbf9Jh9mm8dFvggAQUARCi8NlBd3Iw9+kpuWd0euc955lhSbp71yxuDqC0oDH1YRDTF/xQoOVF5rNQruLf6Xu3PMwxQgl5c0O/fIgvakImPR78Brwksn9Am5X76g3Am/lPO0ofW9Jv6Z4WyOEDvdU8xzuTK5+glC2ZJ65+9KH0UgQRJznw3WXX7bx5oLcF9d0Z8VH4JDGwVcozkv3fk7CfIrHKhyp4MHikyG/dzGSoP8eLcXjBwWY4sCctv7yA7FLMbRVydAXFJfjptpv6pW3r27YrhGyrGyzgAnVJBVFSwPRrtDWIOj97ISgVt5ePiLjfooJjvXOHQLkEhB61a/278axxle5DrgDOg9O9lVJrrnsCqEkXiv/gC8D4GtYpSXfNwDJMtdjs9XxF9Xzmq/Oh7l8Ie9mANWLnEWZck6lhVrAPpqGTDCu4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CWnSpXYbXUxY/8b8GRXS45u3YnNRmk/dtYfAqkEnaj+8WAPXenQXTVJxXiP6ODsnFviMJp4RfEaqIbAnV02OmIsUwnt9HetBnTxBBvKr8KRi2jEEi0LOcYb/G9XKhzsqQPvfesaUpFl9eB1I7VbQQ/F1WRSTZfCER5yCCHmOQgdtoEaKLOHrzV6qAhv+FfI2nUx+f3yjF5TpdbUBtOhOvZwDwcc03B36WCQ7fkPXExZNXH7VUBHet8c8KOAfalIrK9u+liRNVGJRE6qhH279Q1q57KnXvYUBKruVaqn6UHHk89KaSKtq3u2vy51r7sQYaoceAHV98Cu8j0G0cil6rNZG5GPLr3GvfULk/1gY4Pf2ygx94yr48B73RPIb3UuPJdc631V36csQzpVEQn8hdX30xZNtNjFXd139LBlj33/DcFeZ1eE5jntxgozjHSrR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:12:04.2343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c587bff1-8da6-4265-aad9-08debb30c34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 117 +++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index fb53bfc22bbd..4a04f53b3df9 100644
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

