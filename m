Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE1C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6481A10EA78;
	Mon, 21 Sep 2026 20:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ExamzPXf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61FE10EA83
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1j3aixQ3PkH0oOOGACAVvuqkEj8ZtEBryIsX9BZ0bIqUmSQkv9Udl639snHcVR3ociyXWu9nv4MKuCghLCYI981s/4wOEokJPkH1hENWdeuu3CqP5vWKxh1EJwXks0akbIVzFr+8ED1/CXBkbReIQGhz33YIymCjYhQgAtfKVruiDnYhWnvQbYTASNGpDclOmzLjW3q3vL6xxXTdreTzmWBwxT4AFCJjPYI5eZPMmecuRCaD8T45vOevrVOWlaAGjoQBKETyP1F33kO7CQof6rVIpVLzFTkiYmMjGJZGau3xv5jvKsC0ZRjI5sPVaNHQUSHDgd2uh8aG1Ic/aWRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKHFTexIBdq5RFa4Q6FnlQ9WVSJC/w9aAgheniwRPhk=;
 b=RQFmFvMZlrogoz67AaoAhnyUDQf+pPUp7SYCZxw7aC4YMgm2WYg0lOb0+0dKtFgFKVdkiWhKZNFRFj5lEZjFqLj0E/WCHQmAZohefoK89KXrwDxJZ+iTDwH+7JbyeoVdRmqXr1sJoYV9yshwRAudd00lj57i1xcE5oiUEwAyYyDMWfVDkZmFNg0Mez9rEkbp9evRKfu5lIx/hq5M3ppNNxr/byvqTKAV12cThCaWB9ItBLQ23mHJDI3hbWNyAbhY9wjz1GvXJeoz33klKguEwAmP9cJDQBk/J3cH09O1r71sS5seN7nbk1+F+cqN7Of+DTQ+zs8P0djgN61YoQqXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKHFTexIBdq5RFa4Q6FnlQ9WVSJC/w9aAgheniwRPhk=;
 b=ExamzPXfLcBucDChnClJo580AAnuBWNLmXNKvC4Qvbi+44izpq0hdFl/3FFBFFvDHx1NckamS4UhLLr1W8HAMsqlQw3h//KWArf7Obm0bBB/HF8VMyRBTPDE4eQDro8uZproUq8VjU2UOzgYTKee5enoc0Z6QQXETEihgRqMxdY=
Received: from CP5P284CA0024.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:94::11)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:26 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10d6:103:94:cafe::75) by CP5P284CA0024.outlook.office365.com
 (2603:10d6:103:94::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: implement data dump from spm ring buffer
Date: Mon, 21 Sep 2026 16:03:09 -0400
Message-ID: <20260921200313.865829-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba90952-f781-414f-1cb5-08df181b6505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|6133799003|5023799004|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZlsboKA6OlcFKk3Lhfc5YAs+bUWRM8Z9FPZj78n2ChIGeUVsM5u624Nxev5ATBFWldWwm2yJdXG3vSbnQZ++3ew/B2bPx+WAfjGyOD8TmHKydfVu+Lgh9MVsqLbWehqYgPbWMXQ0ntpxolsWZmNINST7eFuULU/qH/e1zjXIEZBI4MP5yK/e6MwrqXU2cGAybrbP4YPmzeEAac4tZmLi4hhQIq2XSsTM/i9UYIYncuZxq0y1m6PY3+VyOrWndvpaaWPp9uUj+b2oTPG7pGDaF/LUsjjlXvFSz0LH+qu803snY1ipglgCq7Ag21qeJnD1gjaCCRpldH0TPt4exPvxT7qB2Kr5Cv4ioS1LE9llGhIOMeeMQ34VfxNq0lXcj4YBus5+X4GFM+RcBkx3lsZ1llpeCrgLf34SoAQ3XX6IQMQWM0zQQpDVdZ8brkRQdSQ8a4HB1uF9dVbjPizKTUhiSc5b6vbTNd0Jv4cGrU65VmmKHcNyLcbVrlxrcrjY1IjIVSZ0pRf0XnUrLZLN9bwWOlZMEFoygtLvOzJN7GDvUxSAZeNrGkJF0O8VjNw+A0MSA9E86M0meNZwrbHHK03M1yVIYcBsX4UKb7dDrluCGh20hi8nizzZEPc9pRntB96sOiELew0NyOzX4N3URwgUjg088u13hDjKc7rzn6+74yH9b9BpX0eKUiZ5kap0Y/utQpYJVtIxbJi+kZU2tlVZag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(6133799003)(5023799004)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZtWtjo/ZL3ccS/mh2L1DRG8mSpHmiIrkp196RWN+T2hvXI4gf249H4a4BY/D+kxeDzh6lgMKzCnh7m0rjoUrF429mtnLVLeB+zK0YEATg3XoPDWowwPQrX/CYHyKB6m0uQI/ALCa57TTwAEyl/4sN3U1PbKabdCKnyWGvViyFwv/Gmq7CQTbT70lGsPR0llSPSElK7CsTOvVS7/XivMR2V+ad+h0zIHf2qBjhSJmrBnU45NhOREzNmOsVIKlDVAmD3+QvwZEjkCcMbyenysd4KyQAENe99kOyvKXP/4t9Mgg/jlLYn5s8hxvzAw8SSAF9NltiJS8/hvxLcD767gQbeEkhtu41BocY7BFnQJEpFOpcz+oTH9cqm4zZMLso/NLDr2KguXbIv9U9s0oc7qW/J7kscmmvOV4pDHQlz+mVZ8Y5D6ylaTNv6Q8wLGgD4HV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:24.7470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba90952-f781-414f-1cb5-08df181b6505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

Implement the drain path that copies SPM counter records out of the
per-XCC ring buffers into the destination buffer installed by
AMDGPU_SPM_OP_SET_DEST_BUF; amdgpu_spm_work() was a stub until now.

The worker snapshots spm_cntr and lead_thread together under
spm_irq_lock and bails out if either is NULL, so a work item still queued
when RELEASE runs does not touch a dying session. It attaches the lead
thread's mm with kthread_use_mm() so copy_to_user() targets the profiler's
address space, and drains the XCC instances of the partition under
spm_worker_mutex, which locks out SET_DEST_BUF and the RELEASE teardown.

Per instance, amdgpu_spm_read_ring_buffer() snapshots is_spm_started and
ring_rptr in one spm_irq_lock critical section, since _spm_stop() clears
the flag and resets rptr under the same lock. The hardware write pointer
is rejected unless it is below ring_size, because a corrupted value would
make the copy run past the ring and leak kernel memory to userspace.
Records are copied in one segment, or in two when the producer has
wrapped, and the current rptr is always published back to the RLC with
amdgpu_rlc_spm_set_rdptr().

Copies stop at the end of the user buffer and mark it filled, which sets
are_users_buf_filled and wakes spm_buf_wq so a thread blocked in
SET_DEST_BUF can install a new buffer. Nothing is propagated out of the
worker; a failed copy, a bad wptr, or a missing or full user buffer set
has_data_loss as a hint that the ring may have stalled. SET_DEST_BUF
flushes the worker after installing a buffer unless every instance was
started by that same call. The polling thread that schedules the work is
added by a later patch.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 226 +++++++++++++++++++++++-
 1 file changed, 225 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index b3132f9a8c0a..d17fb2963981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -21,6 +21,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/kthread.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 
 #include "amdgpu.h"
@@ -49,9 +51,227 @@ static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file
 	return spm_mgr->file == filp;
 }
 
+static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr,
+				struct amdgpu_spm_cntr *spm_cntr, u32 ring_rptr,
+				u32 size_to_copy, int inst)
+{
+	struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
+	u64 __user *user_address;
+	u64 *ring_buf;
+	u32 user_buf_space_left;
+	unsigned long flags;
+	u32 new_rptr;
+
+	if (!spm->ubuf.user_addr)
+		return -EFAULT;
+
+	user_address = (u64 __user *)((void __user *)spm->ubuf.user_addr + spm->size_copied);
+	/* From RLC spec, ring_rptr = 0 points to spm->cpu_addr + AMDGPU_SPM_META_SIZE */
+	ring_buf = (u64 *)((u8 *)spm->cpu_addr + ring_rptr + AMDGPU_SPM_META_SIZE);
+
+	user_buf_space_left = spm->ubuf.ubufsize - spm->size_copied;
+
+	if (size_to_copy < user_buf_space_left) {
+		if (copy_to_user(user_address, ring_buf, size_to_copy)) {
+			spm->has_data_loss = true;
+			return -EFAULT;
+		}
+		spm->size_copied += size_to_copy;
+		new_rptr = ring_rptr + size_to_copy;
+	} else {
+		if (copy_to_user(user_address, ring_buf, user_buf_space_left)) {
+			spm->has_data_loss = true;
+			return -EFAULT;
+		}
+
+		spm->size_copied = spm->ubuf.ubufsize;
+		new_rptr = ring_rptr + user_buf_space_left;
+		spm->is_user_buf_filled = true;
+	}
+
+	/* _spm_stop() resets rptr to 0 and is serialized against the drain
+	 * path by spm_worker_mutex, so this store cannot resurrect a stale
+	 * rptr. spm_irq_lock pairs with the rptr snapshot taken under it.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	WRITE_ONCE(spm->ring_rptr, new_rptr);
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	return 0;
+}
+
+static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr,
+				       struct amdgpu_spm_cntr *spm_cntr, int inst)
+{
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	unsigned long flags;
+	u32 size_to_copy;
+	u32 ring_wptr;
+	u32 ring_rptr;
+	bool is_started;
+	int ret = 0;
+
+	/* Snapshot is_spm_started and ring_rptr together under spm_irq_lock to prevent
+	 * _spm_stop from resetting ring_rptr=0 between the check and access.
+	 * If SPM is not started, ring_rptr is stale and must not be accessed.
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	is_started = spm->is_spm_started;
+	ring_rptr = spm->ring_rptr;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	if (!is_started)
+		return 0;
+
+	ring_wptr = READ_ONCE(((u32 *)spm->cpu_addr)[0]);
+	dma_rmb();
+
+	/* Validate hardware-provided wptr to prevent OOB kernel read.
+	 * Corrupted wptr could cause size_to_copy to exceed ring buffer
+	 * bounds, leaking kernel memory to userspace.
+	 */
+	if (ring_wptr >= spm->ring_size) {
+		spm->has_data_loss = true;
+		dev_dbg(adev->dev, "[SPM#%d] Invalid wptr:0x%x >= ring_size:0x%x\n",
+			inst, ring_wptr, spm->ring_size);
+		goto exit;
+	}
+
+	/* SPM might stall if we cannot copy data out of SPM ringbuffer.
+	 * spm->has_data_loss is only a hint here since stall is only a
+	 * possibility and data loss might not happen. But it is a useful
+	 * hint for user mode profiler to take extra actions.
+	 */
+	if (!spm->has_user_buf || spm->is_user_buf_filled) {
+		spm->has_data_loss = true;
+		/* Mark user buffer as filled when no user buffer was set
+		 * or buffer is already full, signaling profiler to stop.
+		 */
+		if (!spm->is_user_buf_filled)
+			spm->is_user_buf_filled = true;
+		dev_dbg(adev->dev, "[SPM#%d] [%d|%d] rptr:0x%x--wptr:0x%x\n", inst,
+			spm->has_user_buf, spm->is_user_buf_filled, ring_rptr, ring_wptr);
+		goto exit;
+	}
+
+	if (ring_rptr == ring_wptr)
+		goto exit;
+
+	if (ring_wptr > ring_rptr) {
+		size_to_copy = ring_wptr - ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, ring_rptr, size_to_copy, inst);
+	} else {
+		/* Copy tail segment [rptr..ring_size) */
+		size_to_copy = spm->ring_size - ring_rptr;
+		ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, ring_rptr, size_to_copy, inst);
+
+		/* Copy wrapped segment [0..ring_wptr) if tail copy completed */
+		if (spm->ring_size == READ_ONCE(spm->ring_rptr)) {
+			if (ring_wptr == 0) {
+				/* No wrapped data; reset rptr to start. */
+				spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+				WRITE_ONCE(spm->ring_rptr, 0);
+				spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+				goto exit;
+			}
+			/* Reset rptr to 0 before copying wrapped segment. */
+			spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+			WRITE_ONCE(spm->ring_rptr, 0);
+			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+			size_to_copy = ring_wptr;
+			if (!ret && !spm->is_user_buf_filled)
+				ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, 0,
+							   size_to_copy, inst);
+		}
+	}
+
+exit:
+	/* Read rptr under spm_irq_lock to pair with the snapshot above. */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	ring_rptr = spm->ring_rptr;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+	amdgpu_rlc_spm_set_rdptr(adev, inst, ring_rptr);
+	return ret;
+}
+
 static void amdgpu_spm_work(struct work_struct *work)
 {
-	/* TODO: dump spm ring buffer to user buffer */
+	struct amdgpu_spm_mgr *spm_mgr = container_of(work,
+						      struct amdgpu_spm_mgr,
+						      spm_work);
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =
+						      to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+	u32 xcp_id = prof_xcp_mgr->xcp_id;
+	struct amdgpu_spm_cntr *spm_cntr;
+	struct task_struct *lead_thread;
+	struct mm_struct *mm = NULL;
+	unsigned long flags;
+	u32 xcc_mask;
+	int ret;
+
+	/* Snapshot spm_cntr and lead_thread under spm_irq_lock.
+	 * Protects against amdgpu_spm_release() racing: release sets both
+	 * to NULL under this lock, so either we see both non-NULL (safe to
+	 * proceed) or one/both NULL (bail out).
+	 */
+	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+	spm_cntr = spm_mgr->spm_cntr;
+	lead_thread = spm_mgr->lead_thread;
+	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	if (!spm_cntr || !lead_thread)
+		return;
+
+	ret = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get XCC mask for XCP %u\n", xcp_id);
+		return;
+	}
+
+	mm = get_task_mm(lead_thread);
+	if (mm) {
+		kthread_use_mm(mm);
+		{ /* attach mm */
+			bool filled;
+			int inst;
+
+			mutex_lock(&spm_cntr->spm_worker_mutex);
+			WRITE_ONCE(spm_cntr->are_users_buf_filled, false);
+			/* XCC instance index space is consistent across:
+			 * - acquire: for_each_inst(inst, xcc_mask) -> spm[inst]
+			 * - drain work: for_each_inst(inst, xcc_mask) -> spm[inst]
+			 * - interrupt: spm[xcc_id] where xcc_id is HW XCC instance
+			 * All use the same XCC-instance index space from xcc_mask.
+			 */
+			for_each_inst(inst, xcc_mask) {
+				struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
+
+				/* Errors logged but not propagated: this is async work,
+				 * copy_to_user errors are surfaced via has_data_loss flag.
+				 */
+				ret = amdgpu_spm_read_ring_buffer(spm_mgr, spm_cntr, inst);
+				if (ret)
+					dev_dbg(adev->dev,
+						"[SPM#%d] ring buffer drain failed: %d\n",
+						inst, ret);
+				if (spm->is_user_buf_filled)
+					WRITE_ONCE(spm_cntr->are_users_buf_filled, true);
+			}
+			filled = READ_ONCE(spm_cntr->are_users_buf_filled);
+			mutex_unlock(&spm_cntr->spm_worker_mutex);
+			if (filled) {
+				dev_dbg(adev->dev, "SPM wake up buffer work queue.\n");
+				wake_up(&spm_cntr->spm_buf_wq);
+			}
+		} /* detach mm */
+		kthread_unuse_mm(mm);
+		/* release the mm structure */
+		mmput(mm);
+	}
 }
 
 int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
@@ -712,6 +932,10 @@ static int amdgpu_spm_set_dest_buf(struct amdgpu_spm_mgr *spm_mgr, void *data,
 			mutex_unlock(&spm_cntr->spm_worker_mutex);
 		}
 	}
+
+	if (xcc_mask & ~started_mask)
+		flush_work(&spm_mgr->spm_work);
+
 	goto out;
 
 start_failure:
-- 
2.34.1

