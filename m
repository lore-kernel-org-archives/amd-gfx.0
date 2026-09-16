Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D3C982C3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 15:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FBA10E3C8;
	Wed, 16 Sep 2026 15:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wn187bsE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7438D10E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 15:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7pO6vOWMOCyWmF0mxIXsdt7fzA/1WSTSkJwjfYmFh3uteVHlfzV6MnIYf0zI1uM+hAUxOGXkIVwpKzRfI2E53bwYCIC3A7zQ/aXXdHTrdJmbBIxTZ5Bb8NKSBPTrzDrjMfpYXANbNZxCTsY93FBr71qeToIzHTp/T0Nq6EbxB1/WQaR7Xl+6lzZlkzQWugFCNqJeZq+JitFK2sKJRl5rugoTasJWLck2RZxKk9zTyicjKu/Oi1BgRvRQW/Hlejd6EthmE9cp8rQnr6ZTX6vveSMPj6/d31qU1zNzwN7t2UyIg1UPEwY6wMC2DBTy9QuB/lTd+O2lujtrHVJ9v+geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0TsemP61/75lJg2Z5wpHZ6ZPfdTmo2jFnmtXjANKPA=;
 b=ZQw+SBhV2h5ayw4G+XBF8oaVrC6GDI7R1pnoILLrCIaT2xU8akRp6SXStOnKsJGmpWD/idBEJKKnhbRk2I9mj6wYCYTG8Gv3QpvKe+Fux5wsiTlQQDBz6T9djVFoexu8VQvb0+PfWsu2nkCJMQNoGh8VL7l7oPycZAnTXKraGQFcDX7TEnxWbFlwRWCgfnm+Q3CWI73agsx18nS8DxtRYWbiKjDUvRvWMZb/B0GxMNhPdHdWOPQL9pFdtbQqCuPYOdEdHLnS8E9ckYIevdQkXe8/7vr7wQwCR7pZMMV728BapwAV2Pb8bHJ8pqiafbn1+xcfUeLZyvdH1mt2XcVlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0TsemP61/75lJg2Z5wpHZ6ZPfdTmo2jFnmtXjANKPA=;
 b=wn187bsEqo3fHA0CJFqHVIhUn6X+q8C6+E4dj9KqRRwQaHZ2qK9+pZolmmEgOJoLh0HBGZBznHJMY+8txhY4GTrgaFgRDS/3+PSJXGsOn8NMZo7QCntnOxytl1gLkhlxntYTe6SvP+bJhzH2jJM+7L/JW071bqp8GYEaxvz37c8=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:25:41 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::31) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Wed, 16
 Sep 2026 15:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 15:25:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 10:25:39 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v10] drm/amdgpu: Resync UALink ring wptr after reboot
Date: Wed, 16 Sep 2026 11:25:28 -0400
Message-ID: <20260916152528.3918848-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: be54ab92-c05a-4265-2a78-08df1406c49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|6133799003|5023799004|56012099006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: f5pLLmvGANLbbd3MCcPuhiKYND8SORHBfLH9p4KOu6i2+T1m/qxHd85DaK/l6B+UMhFIWQfRfhnI3F7918zvmsay4wA9Mk0bvhTiJLBWXG/47Pkvh0P6mDkCENLoiF6Im+8cfT/3tlvw82G/Ewe57jTC8HpxPgxdFHFzX5ifpad7sghMs/4ysdN1zQiLmOc/6cyvBRBTWpk9Il3gyYY0qUFsv5tXKkFdDKPa7bF5HyUGC1KjC0SPp53fhDvpzEPcB0TvN4MatjPsFYpzD0PentwxYw3ZEsTpbrh9W0b4AxdQu2APxWEJXL7hHtE5We4oSVo0eiS0d0G0KaZjGvS7VDzLXksl8Kut5Bide6QxWESsLIr4YsA089Zrv5tHsTCVzeCF03NW+jHDolKQV/MsvXDTEsn/ESA94lUBU/Wf4x2YIygaL4srFNry3Iq0lwlURu+UMpOQSHhfWvamDrmr19QBXL4Y+vFlMo8GR7ooWRaoLoXxm15RHnroUKpdU+nXJ8HPDnXD4zWAfta1vicD8fOAftfn9mW8b+pr0oLh74SFWACBdu+JfMD9ix95KuxZ/dCg2ZrtyzBv/28A7ToYb7RRy/m5M4VJh8CUG2bfehhGhce/wi8sqWdqVUcnnyWymurFS860wCwNqUPCgGKhaqn8NDqrDGAVWGSf+UUCAkEy6eVd7+izofENPqE/1KHwe2s6whLkysdk8xQBAsqxaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(6133799003)(5023799004)(56012099006)(3023799007)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rqkLxDWqNdfQA9uKf5FnBTz5vwUDKnJ2YVa6TYTYm1Nwd3mpAcaFTdxAUTxxpw3fjdFOi6AkJg/piCVquAgVNipNYBDxkQi+RioqWWBDSRA4ypv0txcPvSb5cDUkfzjH+1fZoRqUMwxXpR6dPCNQUPUt1R/BMlGp1j0C9bEr7vdZOf/MoHEEqW1e7e11tOyxpdOYE764NHTONBq8OpVdcZVhz+xpD3/HJnub4MkLtj4OmXD9GQt2pTWmD1vm9I954mFL6je6AEOoKokN8S4xgfjezApqduL2wnWzLDLF1uFVPJ5X/uxlUR48r3NhcKDEA03htXe+Aypcu9Ae7o+uXWQpnXEgEbqymAxtv/xQ6lrLHWvgmtX0HHEOFEjFp1FKTjI3QX9M/siu0WDNkNUdxuYbWTo6lRWLIWqQUzvLjb/83WamNRata7o/nhGDRyPl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:25:40.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be54ab92-c05a-4265-2a78-08df1406c49a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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
local wptr and rptr to resync, before the first message is sent. Either
side can notice first, so do this both when setting up the connection
and when receiving the HELLO from the peer.

On the sdma path, read the wptr in a fence callback because the IB buffer
holding the result is recycled once the fence signals, so reading it
after dma_fence_wait_timeout() is too late. The lsdma path copies
synchronously, so it reads the wptr directly.

Take peer->lock in the callers (amdgpu_ualink_remote_interrupt and
amdgpu_ualink_remote_shootdown) instead of in amdgpu_ualink_send_command,
so the ring->ready check and the send are atomic against a concurrent
ring reset.

Move the rptr refresh and ring-full check out of amdgpu_ualink_send_command()
into amdgpu_ualink_ring_check_space(), so it runs under the caller's
peer->lock before the job is allocated.

On a failed NPA-REQ send, reset the connection like the NPA-RSP timeout path
already does, so the next attempt resyncs the ring wptr.

On connection reset, amdgpu_ualink_reset_peer_rings() only clears
ring->ready, so the writeback address is re-registered on the next send.

v10:
  - Fix the resync missed on the receiving side: after a reboot the peer
    may send HELLO before we set up the connection, so resync the ring
    wptr in amdgpu_ualink_process_hello_msg() too.

v9:
  - Fix the unnecessary connection reset after an app exits: the peer is
    idle here but still busy handling NPA revokes on the remote, so the
    HELLO reset a healthy connection. Only send it if the wptr changed.
  - Resync both rings together under peer->lock, read both remote wptr
    before updating either so a failed read changes nothing.

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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 339 +++++++++++++++++----
 1 file changed, 287 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index b2c2650b0149..c0327f6854a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -56,6 +56,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 size_in_pages, u32 flush_type);
 static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
 static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id);
+static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
+					  u32 remote_accel_id);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -2282,11 +2286,23 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
 						generation_count);
 	}
 
+	/* Peer may have rebooted. */
+	r = amdgpu_ualink_ring_resync_ptrs(adev, sender_acc_id);
+	if (r < 0) {
+		dev_err(adev->dev,
+			"HELLO: resync sender AccId %u ptrs failed %d\n",
+			sender_acc_id, r);
+		goto out_set_state;
+	}
+	if (r)
+		amdgpu_ualink_reset_peer_rings(adev, sender_acc_id);
+
 	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
 	if (r)
 		dev_err(adev->dev, "HELLO-ACK: send failed to remote AccId:%u\n",
 			sender_acc_id);
 
+out_set_state:
 	mutex_lock(&conn_state->lock);
 	if (r) {
 		conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
@@ -2303,6 +2319,14 @@ static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
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
@@ -2324,16 +2348,31 @@ static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
 	 * already done by another thread.
 	 */
 	mutex_lock(&conn_state->lock);
-	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
-		r = 0;
-		goto out;
-	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
-		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
+	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
+	    conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
 		r = -EAGAIN;
 		goto out;
 	}
 
+	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED &&
+	    !amdgpu_ualink_peer_idle(adev, remote_acc_id)) {
+		r = 0;
+		goto out;
+	}
+
+	/* Peer is idle or not connected, it may have rebooted. Skip the
+	 * handshake if the rings are still in sync, it would reset the remote.
+	 */
+	r = amdgpu_ualink_ring_resync_ptrs(adev, remote_acc_id);
+	if (r < 0)
+		goto out;
+	if (!r && conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED)
+		goto out;
+
+	amdgpu_ualink_reset_peer_rings(adev, remote_acc_id);
+
 	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
+
 	mutex_unlock(&conn_state->lock);
 
 	/* Send HELLO message */
@@ -3670,7 +3709,7 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 		dev_warn(adev->dev,
 			"IMPORT: NPA-REQ send failed to remote AccId:%u\n",
 			remote_acc_id);
-		return r;
+		goto reset_conn;
 	}
 
 	/* Wait for the NPA_RSP to come back */
@@ -5511,6 +5550,34 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
 typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
 				   u32 dw1, u32 dw2, u32 dw3);
 
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
@@ -5536,6 +5603,10 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 
+	r = amdgpu_ualink_ring_check_space(adev, remote_accel_id, ring, wb_cpu);
+	if (r)
+		goto out;
+
 	/*
 	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
 	 *
@@ -5552,25 +5623,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
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
@@ -5628,12 +5681,11 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
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
 
@@ -5664,12 +5716,9 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
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
@@ -5678,21 +5727,15 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
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
@@ -5732,6 +5775,192 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 		remote_accel_id, npa + offset);
 }
 
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
+	if (!r)
+		*wptr = wptr_cb.result;
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
+ *
+ * After a reboot on either side the two ends disagree on wptr. Read the remote
+ * wptr of both peer rings and adopt it as the local wptr and rptr.
+ *
+ * Return 0 if both rings already match, 1 if they were resynced, or a negative
+ * error code if a remote read failed, leaving the rings untouched.
+ */
+static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
+					  u32 remote_accel_id)
+{
+	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
+	struct amdgpu_ualink_wb *int_wb, *tlb_wb;
+	u64 int_wptr, tlb_wptr;
+	int r;
+
+	/* ring->wptr and ring->rptr are owned by the send path. */
+	guard(mutex)(&peer->lock);
+
+	/* Read both before updating either, so a failure changes nothing. */
+	r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
+					   &peer->interrupt, &int_wptr);
+	if (!r)
+		r = amdgpu_ualink_read_remote_wptr(adev, remote_accel_id,
+						   &peer->shootdown, &tlb_wptr);
+	if (r) {
+		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
+			ualink_accel_id(adev), remote_accel_id, r);
+		return r;
+	}
+
+	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
+		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
+			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
+		return 0;
+	}
+
+	dev_dbg(adev->dev,
+		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
+		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
+		remote_accel_id, int_wptr, tlb_wptr);
+
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
+				  RB_TYPE_REMOTE_INTERRUPT);
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
+				  RB_TYPE_TLB_INV);
+
+	peer->interrupt.wptr = int_wptr;
+	peer->interrupt.rptr = int_wptr;
+	peer->shootdown.wptr = tlb_wptr;
+	peer->shootdown.rptr = tlb_wptr;
+
+	/* Drop the stale writeback rptr, it disagrees with the resynced wptr. */
+	WRITE_ONCE(int_wb->rptr, int_wptr);
+	WRITE_ONCE(tlb_wb->rptr, tlb_wptr);
+	return 1;
+}
+
+static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
+					   u32 remote_accel_id)
+{
+	struct amdgpu_ualink_peer *peer = &to_remote(adev)->peer[remote_accel_id];
+
+	dev_dbg(adev->dev, "remote accel_id %u\n", remote_accel_id);
+
+	guard(mutex)(&peer->lock);
+
+	peer->interrupt.ready = false;
+	peer->shootdown.ready = false;
+}
+
 static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
 					   u32 remote_accel_id, u32 ring_type)
 {
@@ -5794,6 +6023,9 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->shootdown;
+
+	guard(mutex)(&peer->lock);
+
 	if (!ring->ready) {
 		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
@@ -5802,11 +6034,11 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 			return r;
 	}
 
-	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
-				       amdgpu_ualink_emit_shootdown,
-				       flush_type, upper_32_bits(addr),
-				       lower_32_bits(addr), size_in_pages);
-	return r;
+	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
+					  ring->wb_cpu,
+					  amdgpu_ualink_emit_shootdown,
+					  flush_type, upper_32_bits(addr),
+					  lower_32_bits(addr), size_in_pages);
 }
 
 /**
@@ -5835,6 +6067,9 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->interrupt;
+
+	guard(mutex)(&peer->lock);
+
 	if (!ring->ready) {
 		dev_dbg(adev->dev, "accel_id %u ring not ready\n", remote_accel_id);
 		r = amdgpu_ualink_update_wb_address(adev, remote_accel_id,
@@ -5843,10 +6078,10 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 			return r;
 	}
 
-	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, ring->wb_cpu,
-				       amdgpu_ualink_emit_interrupt,
-				       dw0, dw1, dw2, dw3);
-	return r;
+	return amdgpu_ualink_send_command(adev, remote_accel_id, ring,
+					  ring->wb_cpu,
+					  amdgpu_ualink_emit_interrupt,
+					  dw0, dw1, dw2, dw3);
 }
 
 /**
-- 
2.50.1

