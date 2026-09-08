Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA45C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 21:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EDBF10E52E;
	Tue,  8 Sep 2026 21:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CulkiBtd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25FB10E52E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 21:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcW2uYT5nhHImFk3kbJoRtjQDEyBJKOCMeDOhhcP4CunEC36q6lsBAiX28H4gUZuKCUOGXjCdt5PTmQgBQUD0NyZYQIiNcD63JUrEthgj19+avyMcNiaqc3i/1Bw4k4H38RqKfkuNmAEVfFcdej3KBhgLGGi7s8e2GMO2oAAggqeiYL9RYG+h/U5YsQmCzAze/43VAg5o48iTpXGXpbLwr3KwyP7ud9+/52FJUG+TYO20JQs75qFpQ6ObmjfVkcmz61uSvDr3k43FMbAXpvxT3GkEOvAeSyKIjrs92d/7OlQbb7QtDTeoVVFPJrUMxd6Ge+WHkDupcDai0c9FJjcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOP7Z8Qx/6z2VL9wX2WNfhiei05pdZuhQkgUJxy6wXs=;
 b=vi8OKyu+s7b2tbGHpZygBEAC2Sfz6fs9DDeftfdFgl/OQcP9EOSLpYXxMuPbAIvT2u9UcQNFf+SMaeEoNO/gDC7T36HYj9TQ868OjYA/Vl1lIzgHySC8llrLzA3SUazVjEPYQ/tBKGGqm7xMP/hfp0jTanpptbIusYI+1c7x8oSNtcZk9Q9qU7wD4VDOoFBjtJs+gW5vKOyim7d/+E/ULMfFh8AskE7xDk0CkhP450ndM4mQrakq16VHheV37orYiq2XZlClvEUvGbo4mTQf+/W0AhYvFTxRLPDR0teXQgXakFsM/8cz/Pp1GeKtfgq6FGwjKZHQZk1dncreG0lGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOP7Z8Qx/6z2VL9wX2WNfhiei05pdZuhQkgUJxy6wXs=;
 b=CulkiBtdDO1YZIZz+aKOmSWkj1oqtpKY93znz5OoFVZ1w6xCcVwmYL+u13uHB/bHU3H5ymLMzxwc85kH9vOWNhoZo/HJ2RExnCBJX41rLJ+4y1B5oQkkMYftPI0Nl2A4nrNsoTENA/tV8MJuY6DoQw8uy4083kEnRTfCaKlknBQ=
Received: from CH0PR03CA0319.namprd03.prod.outlook.com (2603:10b6:610:118::32)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 21:30:08 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::4e) by CH0PR03CA0319.outlook.office365.com
 (2603:10b6:610:118::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 21:30:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Tue, 8 Sep 2026 21:30:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 16:30:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v8] drm/amdgpu: Resync UALink ring wptr after reboot
Date: Tue, 8 Sep 2026 17:29:30 -0400
Message-ID: <20260908212930.427287-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8484cc-d30e-4cab-c217-08df0df05b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|6133799003|3023799007|10067099003|11063799006|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: OlEKZtwTNBtI4R+cbQ30w4U1BV6oOfZCtMk3XeRHBFPrMibXwewOE860x+BqUDBhVawWM1y08CKmZF2fPACkP2PfJP9nqMjfMLZjhftcWwXhPOz/2//FxLGy79osBfYes+H0/CmwnnpW1I/q0cHTtzp7Mlj6RaBt0hhn6saYD/XOO2sxpigjc+SIFm3632fhs8ylS34nFrsbrtGu0UOb30kuezhHGKH78zujEIPDzxj0q2BN5hVgdkArNJNQQpMTOcCugSsE2m7sRxDAZhWspeJ6u9RrX2Glq9stge/BYmyv4RHXrnSpvw59Q5cUWFQOs/cBfhHwOUNeJfUZBK/f1fzWmFqYRa0HnhgReH97o5VQrKMGK7JR1ja51gQeQGkbNNZ1/qGGEig9ZiW3kdIF8A4Y8n9z/DF0o0819m9OhBb3dE/P/cdkYwkq3uNSKH77G7gQpxIczc3porIP5+L15ptr7Geymid3ADAXeioFOCsDoh55Dn9D0fxsH5M/OQhjnmBbPaja1TrvDCtCe3MeOS0+c3xs+WuRspdIFTcnzuJbk+0IqOhlyDS8TuQ72Csco+ZN3aA46+YBm8gg2nrXjAY1sqMZ6EtgOoPmtQsAU9UJRcosetCv/A0LE90gp8lESG+qGEqNUhbwTnnYcFdLDsGPSRql43XjrLKN2bg+zCBgODVTcQa9AKIqv8dntSTX6rGYYuivHKA30DqrldWWJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f+WmNdYpyGTAjOaIjDz0JWTDGo3DEfRrQVwEuP7NMiZIBwqx0N7Hqr7JmirHDv9Elnm+N4m1PLL74NYM8kwOrL9AHO4gve7xsnXYZjh9CCIPzZXhWXrsSuX2oFbOGspqKuyrFxUtDf61dHUwPWwpHAQApkX7wSF5PusZwUrw9/7bIMQhGFiZjOgRs9Ltl676UQD7Pet7nSrUL08RkIBBVmKXvYvf/K9d+8lKnlAz6Ph67yJHXuBXz43XdmrlnhY1BIk8f4vSsbbHjWqSnuOhM40989TQZ3pZ/aeej++CbJ8XYAiebropXbbMarwuhRNZPtoJQW66JHV4huXSr4J8p9ksDTX+koCaq9/RSNbcP+0hJUKfspPONOgAuodDC56pkzBllyW8y+edLDOFVObtngyEi9FF/bp2AWYvww0VXzcScJndXcDxXCR90hXm2S1k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 21:30:08.2975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8484cc-d30e-4cab-c217-08df0df05b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699
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

When one side of UALink nodes reboots, its ring wptr resets to 0 while
the peer keeps a stale value. Read the remote wptr and adopt it as the
local wptr and rptr to resync, when setting up the connection, before
the first message is sent.

On the sdma path, read the wptr in a fence callback because the IB buffer
holding the result is recycled once the fence signals, so reading it
after dma_fence_wait_timeout() is too late. The lsdma path copies
synchronously, so it reads the wptr directly.

Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
because amdgpu_ualink_update_wb_address() also reads the remote wptr and
must run under the same lock.

On connection reset, amdgpu_ualink_reset_peer_rings() only clears
ring->ready; the remote wptr is re-read on the next update wb command.

v8:
  - Fix regression with concurrent import ioctls: do the idle check and
    ring reset in amdgpu_ualink_setup_connection() under conn_state->lock,
    and return -EAGAIN for IN_PROGRESS/PENDING first.
  - Reset the peer rings only, the imp/exp xarray cleanup is not needed to
    resync wptr.

v7:
  - With v6 reboot one node of vPOD test passed on minirack.
  - Use the per-remote imported and exported handle lists for the idle
    check instead of walking the xarrays.
  - Rename amdgpu_ualink_resync_peer_rings() to
    amdgpu_ualink_reset_peer_rings(), it only clears ring->ready.

v6:
  - Check idleness per remote accelerator instead of globally, and reset
    the stale connection at the import ioctl so the peer re-runs the
    HELLO handshake after a reboot.

v5:
  - Resync the ring pointers at the import ioctl when the connection is
    completely idle (no exported or imported BOs), so the first command
    from a new application after a remote reboot/reset succeeds.
  - Put the sdma wptr read fence callback on the stack instead of
    allocating it; it is cancelled on timeout so it never outlives the
    call.

v4:
  - Cancel the sdma fence callback on the wait timeout/failure path so it
    cannot write into the caller's stack after the function returns, and
    free the callback state in one place.

v3:
  - Resync both rings at connection setup instead of on the send path.
  - Set the writeback rptr too, the stale value disagrees with the
    resynced wptr until the remote FW writes it back.

v2:
  - Match the FW change: resync wptr only on the first send or after a
    timeout, instead of checking the remote periodically.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 288 +++++++++++++++++----
 1 file changed, 244 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ab564202f550..5c6ef467043c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -55,6 +55,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 size_in_pages, u32 flush_type);
 static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
 static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id);
+static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -2304,6 +2307,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 	mutex_unlock(&conn_state->lock);
 }
 
+/* True if nothing is exported to, or imported from, this remote accelerator. */
+static bool amdgpu_ualink_peer_idle(struct amdgpu_device *adev, u32 remote_accel_id)
+{
+	/* Unlocked: a racing import at worst costs one redundant ring resync. */
+	return list_empty(&adev->ualink.imp_handles_list[remote_accel_id]) &&
+	       list_empty(&adev->ualink.exp_handles_list[remote_accel_id]);
+}
+
 static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 					  u32 remote_acc_id)
 {
@@ -2325,13 +2336,21 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	 * already done by another thread.
 	 */
 	mutex_lock(&conn_state->lock);
+	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
+	    conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
+		r = -EAGAIN;
+		goto out;
+	}
+
+	/* Peer is idle, it may have rebooted, force both rings to resync wptr
+	 * before the NPA handshake.
+	 */
+	if (amdgpu_ualink_peer_idle(adev, remote_acc_id))
+		amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
+
 	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
 		r = 0;
 		goto out;
-	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
-		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
-		r = -EAGAIN;
-		goto out;
 	}
 
 	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
@@ -3671,7 +3690,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		dev_warn(adev->dev,
 			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
 			remote_acc_id);
-		return r;
+		goto reset_conn;
 	}
 
 	/* Wait for the NPA_RSP to come back */
@@ -5512,6 +5531,184 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
 				   u32 dw1, u32 dw2, u32 dw3);
 
+struct amdgpu_ualink_wptr_fence_cb {
+	struct dma_fence_cb base;
+	u64 *wptr_cpu;
+	u64 result;
+};
+
+static void amdgpu_ualink_read_wptr_fence_cb(struct dma_fence *fence,
+					     struct dma_fence_cb *cb)
+{
+	struct amdgpu_ualink_wptr_fence_cb *wptr_cb;
+
+	wptr_cb = container_of(cb, typeof(*wptr_cb), base);
+	wptr_cb->result = *wptr_cb->wptr_cpu;
+}
+
+static int amdgpu_ualink_read_remote_wptr(struct amdgpu_device *adev,
+					  u32 remote_accel_id,
+					  struct amdgpu_ualink_ring *ring,
+					  u64 *wptr)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer = &remote->peer[remote_accel_id];
+	struct amdgpu_ualink_wptr_fence_cb wptr_cb = { };
+	struct amdgpu_ring *sdma_ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 ndw, ndw_copy_cmd;
+	u64 wptr_gpu, *wptr_cpu;
+	int r = 0;
+
+	*wptr = 0;
+
+	/* 1 sdma copy command to read wptr */
+	ndw_copy_cmd = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+
+	/* wptr 2 dwords */
+	ndw = ndw_copy_cmd + 2;
+	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
+	if (r)
+		return r;
+
+	ib = &job->ibs[0];
+	wptr_gpu = ib->gpu_addr + ndw_copy_cmd * 4;
+	wptr_cpu = (u64 *)(ib->ptr + ndw_copy_cmd);
+
+	dev_dbg(adev->dev, "read wptr from remote %u npa gart wptr 0x%llx use %s\n",
+		remote_accel_id, ring->wptr_npa_gart,
+		remote->use_lsdma ? "lsdma" : "sdma");
+
+	if (remote->use_lsdma) {
+		r = amdgpu_lsdma_copy_mem(adev, ring->wptr_npa_gart, wptr_gpu, 8);
+		if (!r)
+			*wptr = *wptr_cpu;
+		amdgpu_job_free(job);
+		goto out;
+	}
+
+	wptr_cb.wptr_cpu = wptr_cpu;
+
+	amdgpu_emit_copy_buffer(adev, ib, ring->wptr_npa_gart, wptr_gpu, 8, 0);
+
+	sdma_ring = &adev->sdma.instance[0].ring;
+	amdgpu_ring_pad_ib(sdma_ring, ib);
+	WARN_ON(ib->length_dw > ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+
+	r = dma_fence_add_callback(fence, &wptr_cb.base,
+				   amdgpu_ualink_read_wptr_fence_cb);
+	if (r == -ENOENT) {
+		/* Fence already signaled; the callback won't run, do it inline. */
+		amdgpu_ualink_read_wptr_fence_cb(fence, &wptr_cb.base);
+		r = 0;
+		goto out_put_fence;
+	} else if (r) {
+		/* -EINVAL: NULL fence or func, not expected here. */
+		goto out_put_fence;
+	}
+
+	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
+	if (r > 0) {
+		r = 0;	/* read wptr successfully */
+		goto out_put_fence;
+	}
+
+	dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
+		remote_accel_id, r);
+
+	if (r == 0)
+		r = -ETIME;
+
+	/*
+	 * Timed out: the callback is still armed and wptr_cb is on our stack.
+	 * Cancel it so it can't fire after we return and write into the freed
+	 * stack frame.
+	 */
+	dma_fence_remove_callback(fence, &wptr_cb.base);
+
+out_put_fence:
+	*wptr = wptr_cb.result;
+	dma_fence_put(fence);
+
+out:
+	dev_dbg(adev->dev, "remote %u wptr 0x%llx return %d\n",
+		remote_accel_id, *wptr, r);
+	return r;
+}
+
+/**
+ * amdgpu_ualink_ring_resync_ptrs - sync local ring pointers from remote
+ * @adev: amdgpu device pointer
+ * @remote_accel_id: remote accelerator ID
+ * @ring: ring buffer to resync
+ * @wb_cpu: CPU virtual address of the ring writeback buffer
+ *
+ * After a reboot on either side the two ends disagree on wptr. Read the
+ * remote wptr and copy it into the local wptr and rptr to resync.
+ *
+ * Return 0 on success or a negative error code if the remote read failed.
+ */
+static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
+					  u32 remote_accel_id,
+					  struct amdgpu_ualink_ring *ring,
+					  struct amdgpu_ualink_wb *wb_cpu)
+{
+	u64 remote_wptr;
+	int r;
+
+	/* Read remote wptr and adopt it as our wptr and rptr. */
+	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id, ring, &remote_wptr);
+	if (r) {
+		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
+			ualink_accel_id(adev), remote_accel_id, r);
+		return r;
+	}
+
+	dev_dbg(adev->dev, "accel_id %u wptr 0x%llx sync to remote %u wptr 0x%llx\n",
+		ualink_accel_id(adev), ring->wptr, remote_accel_id, remote_wptr);
+
+	ring->wptr = remote_wptr;
+	ring->rptr = remote_wptr;
+
+	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
+	WRITE_ONCE(wb_cpu->rptr, remote_wptr);
+	return 0;
+}
+
+/*
+ * Refresh rptr from the writeback and check the ring has room for one more
+ * command. The caller must hold the peer lock.
+ *
+ * Return 0 on success or a negative error code.
+ */
+static int amdgpu_ualink_ring_check_space(struct amdgpu_device *adev,
+					  u32 remote_accel_id,
+					  struct amdgpu_ualink_ring *ring,
+					  struct amdgpu_ualink_wb *wb_cpu)
+{
+	ring->rptr = READ_ONCE(wb_cpu->rptr);
+
+	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
+		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
+			remote_accel_id, ring->wptr, ring->rptr);
+		return -EFAULT;
+	}
+
+	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
+		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
+			remote_accel_id, ring->wptr, ring->rptr);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 				      u32 remote_accel_id,
 				      struct amdgpu_ualink_ring *ring,
@@ -5537,6 +5734,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 
+	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
+	if (r)
+		goto out;
+
 	/*
 	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
 	 *
@@ -5553,25 +5754,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
 				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
 	if (r)
-		return r;
-
-	mutex_lock(&peer->lock);
-
-	ring->rptr = READ_ONCE(wb_cpu->rptr);
-
-	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
-		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
-			remote_accel_id, ring->wptr, ring->rptr);
-		r = -EFAULT;
-		goto unlock_free;
-	}
-
-	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
-		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
-			remote_accel_id, ring->wptr, ring->rptr);
-		r = -ENOSPC;
-		goto unlock_free;
-	}
+		goto out;
 
 	ib = &job->ibs[0];
 	src = ib->gpu_addr + ndw_copy_cmd * 4;
@@ -5629,12 +5812,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 			dev_dbg(adev->dev,
 				"remote %u lsdma copy failed (r %d), skip completion wait\n",
 				remote_accel_id, r);
-			mutex_unlock(&peer->lock);
 			return r;
 		}
 
 		goto out_wait_complete;
-        }
+	}
 
 	sdma_ring = &adev->sdma.instance[0].ring;
 
@@ -5665,12 +5847,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	if (r <= 0) {
 		dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
 			remote_accel_id, r);
-
 		if (r == 0)
 			r = -ETIME;
-
-		mutex_unlock(&peer->lock);
-		return r;
+		goto out;
 	}
 
 out_wait_complete:
@@ -5679,21 +5858,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	 */
 	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
 
-	/* increase local copy ring wptr, only if FW not timeout */
-	if (r != -ETIME)
-		ring->wptr++;
-
 	/*
-	 * Release ring lock after the remote FW handle command completes to
-	 * prevent race conditions.
+	 * Advance wptr unless the remote timed out, even if the FW returned an
+	 * error status. On timeout the caller resets the connection, which
+	 * resyncs wptr from the remote in amdgpu_ualink_setup_connection.
 	 */
-	mutex_unlock(&peer->lock);
-	return r;
-
+	if (r != -ETIME)
+		ring->wptr++;
 
-unlock_free:
-	mutex_unlock(&peer->lock);
-	amdgpu_job_free(job);
+out:
 	dev_dbg(adev->dev, "ret r = %d\n", r);
 	return r;
 }
@@ -5733,6 +5906,19 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 		remote_accel_id, npa + offset);
 }
 
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id)
+{
+	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
+
+	dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
+
+	scoped_guard(mutex, &peer->lock) {
+		peer->interrupt.ready = false;
+		peer->shootdown.ready = false;
+	}
+}
+
 static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 					   u32 remote_accel_id, u32 ring_type)
 {
@@ -5754,6 +5940,10 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
 				  ring_type);
 
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_accel_id, ring, wb_cpu);
+	if (r)
+		return r;
+
 	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
 				       amdgpu_ualink_emit_update_wb_addr,
 				       upper_32_bits(wb_npa),
@@ -5795,18 +5985,23 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->shootdown;
+
+	mutex_lock(&peer->lock);
+
 	if (!ring->ready) {
 		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
 						    RB_TYPE_TLB_INV);
 		if (r)
-			return r;
+			goto out_unlock;
 	}
 
 	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
 				       amdgpu_ualink_emit_shootdown,
 				       flush_type, upper_32_bits(addr),
 				       lower_32_bits(addr), size_in_pages);
+out_unlock:
+	mutex_unlock(&peer->lock);
 	return r;
 }
 
@@ -5836,17 +6031,22 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->interrupt;
+
+	mutex_lock(&peer->lock);
+
 	if (!ring->ready) {
 		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
 						    RB_TYPE_REMOTE_INTERRUPT);
 		if (r)
-			return r;
+			goto out_unlock;
 	}
 
 	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
 				       amdgpu_ualink_emit_interrupt,
 				       dw0, dw1, dw2, dw3);
+out_unlock:
+	mutex_unlock(&peer->lock);
 	return r;
 }
 
-- 
2.50.1

