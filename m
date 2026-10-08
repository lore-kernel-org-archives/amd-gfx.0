Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B27CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6264610E853;
	Thu,  8 Oct 2026 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qzJqPu7g";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CE410E853
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 14:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5XXRlvVT/RiRompwEdpTZjOezFUg2AqEahwmZcD/6dPFbwLn+ZSMF647bElZNVimuufmkFxtYcSGuUObwNwj/PhA+g7qzAOZcSmy78GVXqldUYb4f3TPjmKbdmKKZIeEm+rV2lvj3MdkvHGN4ngRkVoxQv3c2HzBvB7FUAG1OBSmsJEnU0xk+vHLZTu+qJQnPyBpporSnDFfGTKimPZliSxTdF4MduV6eVoZ9qAmYJ9PwSMQfj9qcypzLywcxBPUlqUuJzHhPQ4i6dnEyJZwXuqT9hGH3evgXZ1F0axRBBEcXhefzOXEOMGMijY3pMcsuGmzbh0H78avNjrZJ08bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LLOQqi03+W0hiO3G30amEZmpG3yatIKVkzvKYhjCX8=;
 b=R/bgTKmyIdl6jpgcbt6MhOxc9zZCarUuxBaaBElztjJCjIKNZZ90iLdif/rcMRqervCTE9czh8ZVDu1A6XXjVhIfIhkJ1hJQl705gC+b6m73DovFUbkSL1nuTXUgVr2VZ0EwSDUfrIqM5SLlNwLw4Ak1/EWXFsMaQG0EwT+GkBRaIt0rbmFVbGjDrL4by1EpdulYp2CXowkesTzKosC+Dgl+4maSeW/4aKS0kSRguS29AT4E9tUe4fi2YhS0oS1B2oFxuUJrtX0CBTEumWUfFiF+yCkUrw9OLlp8Rj7sYZYVSMJbGavxP5W0eRyveBQD4CwhMSkbI9lB4SW50fzF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LLOQqi03+W0hiO3G30amEZmpG3yatIKVkzvKYhjCX8=;
 b=qzJqPu7goYX2j05tFPj52iOz59zaoQlxl0sUDi5S6Hm6aFj+9nBWbVUiftRXNxFjA3f2Igl6L4cUlxu/tygw7od2cIJtnoErLlYQzYtm66I7UFuXmvQSe0LHIo3/9KNt5pmmqTEfDTk4eAJJ2YEic54PxbVd/tGlk17TS13lJrE=
Received: from CH5P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::17)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 8 Oct
 2026 14:06:37 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::5e) by CH5P223CA0005.outlook.office365.com
 (2603:10b6:610:1f3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu, 8
 Oct 2026 14:06:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 14:06:36 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:06:29 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v2] drm/amdkfd: fix lost wakeup in interrupt drain on debugged
 process exit
Date: Thu, 8 Oct 2026 22:06:05 +0800
Message-ID: <20261008140605.944513-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e546c00d-6686-4f33-9e17-fee0cf25eaed@amd.com>
References: <e546c00d-6686-4f33-9e17-fee0cf25eaed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ce453a-a5df-4987-1c6f-08df25455df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JQqLot4r+2bwTe6OvyqyliPUTu/3DR/L22CfA7Xc/lA9BoYHNIuaG3gtpsZNWFNigjVdfakrBsIC/mX37pFwB8GLJ+qehH3IoukCKGXl6uWDfmo5CR3U5MjBpbVGjkJb6wxgsCyVPCYgumIWCg8KdlHT2XUzcRKxJCzXxD164tBBLq0cWTqs5OK2y61O7l8Ti4TGd4Wy6BXtB9cNRZUffe0blJk7qjSzU3u3VdKxJskXnGHJ54GxkAY1Ue2lVYSDjfi04OTF1xc8NcaIoHHiYsljcWoULYDan3iUjGiT9I0rmevOA84QFbuQKJQ9DJAOcQGxiaR1Z2KLQZoh3Og3CJfyfOteLeqBtTUE0FSYDUP50of6pNVD42H7EerNDrV6i0RSAXSfrGuI7X2X0THvB8Y+vpws0YvINYwGzRM/UEN14spKsjsQSZ60dVu+CvvyGdAU/kYRFe1IdF/IagQgg9d52xMr5pKUws3CZdBGx7Ma36PuUtOj8AiUuD0JfiVNF1rBcnmgjUM4ds69z30P5qwFTHA8EzkQzTixKf4otNrGHbZSb2b5NPGG7bCqLhHjIkhonYruiDD/rNP6IAtWLFULj/ClhC37VEjOaIWFlZdO6aUjKBY+zxVg2enG9+MB7ruzQSrOmmJsJs3W0pEILvrSkmAUz8CIWC9iSdXHR0K+QmMT+WxwZ+axMz4c1AZnTXjL0C2FN7eNj/5Q+SxzEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JIq1fo+JuH0NIQeD43iF0Q0Gr+myc3h04DWdSAw2xMtXJV7DTjDXDiZ7Y9T5C4HLYYQNwmR0J8Z+wc47C3+OL9t2999QC+pErOUsIcC63M6yawFw2P7HeQXSA7bT8zlycYMJvGK5K0+o/v8vR7+bZ8LueaoNJIQGSlOZFRldMulM5peNpGmuF1s7TERa3dWhTAI9MT4j8JWEDfWDxqXOFFOH1jXx9AdhDgd4ldlbTKn5jpMgw8mYwG0DM5ljM/dFSUpFY63WHFJOxRRs+Etv1kPEbLBORrAXHabWsjwkNKnwjJqGaHjK3n+jEstf2moKwq4SCDsF0GE+dxxaL4nNzzuwGM5gBbfhOaze04jH1EnWhBFjoLPDlQ82xKzrvR9iLw+9Bqnrxn/qwb4c/6EvxpzomEjmsX0yGpX0M1GgibI6vlVtcLHEDcy9Rm9LnXsc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:06:36.8965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ce453a-a5df-4987-1c6f-08df25455df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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

When a debugged process exits, kfd_process_notifier_release_internal()
first removes it from kfd_processes_table and then calls
kfd_dbg_trap_disable(), which drains the process interrupts. The drain
sends a fence through the IH and waits, without a timeout, for
kfd_process_close_interrupt_drain() to wake it up. That wakeup looks
the process up by PASID in kfd_processes_table, which no longer holds
it, so the wakeup is lost and the exiting task sleeps forever. The
fatal signal has already been consumed in do_exit(), so the
interruptible wait cannot be broken either.

The wait happens inside the mmu_notifier release callback, i.e. within
the global mmu_notifier SRCU read-side critical section, so every
synchronize_srcu() on it stalls as well. Any other process releasing
its mm then hangs in D state and the system needs a reboot. This is
seen with rocgdb on MI300X.

Fix this by:

- Waiting on a completion in struct amdgpu_fpriv, looked up by PASID
  through amdgpu_pasid_xa, instead of looking the process up in
  kfd_processes_table. The DRM file owning the PASID is still
  referenced by KFD while it drains, so the drain fence always finds
  its waiter. The drain logic moves to amdgpu_ids.c and KFD only
  passes the PASID.
- Bounding the wait with a timeout, since the fence can be lost when
  the IH ring or the KFD interrupt FIFO overflows, and warning when the
  drain does not complete.
- Passing drain_irqs to kfd_dbg_trap_disable() and skipping the drain
  when the process itself exits. Its interrupts are no longer delivered
  once it is out of kfd_processes_table, and its PASID owner is cleared
  before the PASID is freed and later reallocated cyclically.

v2: track drains with a completion in amdgpu_fpriv via amdgpu_pasid_xa
    and move the drain logic to amdgpu_ids.c; pass drain_irqs to
    kfd_dbg_trap_disable() and skip the drain on process exit instead
    of deferring it (Felix)

Fixes: 12fb1ad70d65 ("drm/amdkfd: update process interrupt handling for debug events")
Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 62 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 10 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 46 ++++++------------
 9 files changed, 93 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce671731b700..c32d3b0b4153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -426,6 +426,9 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	/** Signaled when a KFD interrupt drain fence for this PASID is seen */
+	struct completion	irq_drain_done;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 5e424e3b6e71..87cc297109a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -171,6 +171,68 @@ struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid)
 	return xa_load(&amdgpu_pasid_xa, pasid);
 }
 
+/**
+ * amdgpu_pasid_drain_irq - wait for pending KFD interrupts of a PASID
+ * @adev: amdgpu device the drain fence is sent to
+ * @pasid: PASID whose interrupts should be drained
+ * @ih_fence: IH entry injected as the drain fence
+ * @timeout: maximum time to wait, in jiffies
+ *
+ * Injects @ih_fence behind the interrupts already queued for KFD and waits
+ * until amdgpu_pasid_drain_irq_done() is called for @pasid.
+ *
+ * The caller must hold a reference to the DRM file that owns @pasid, so
+ * that its amdgpu_fpriv stays valid after the PASID lock is dropped.
+ *
+ * Returns:
+ * 0 on success or when no fence could be sent, -ENOENT if @pasid has no
+ * owner, -ETIMEDOUT on timeout or -ERESTARTSYS if interrupted.
+ */
+int amdgpu_pasid_drain_irq(struct amdgpu_device *adev, u32 pasid,
+			   u32 *ih_fence, unsigned long timeout)
+{
+	struct amdgpu_fpriv *fpriv;
+	unsigned long flags;
+	long r;
+
+	amdgpu_pasid_lock(&flags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	if (fpriv)
+		reinit_completion(&fpriv->irq_drain_done);
+	amdgpu_pasid_unlock(flags);
+	if (!fpriv)
+		return -ENOENT;
+
+	if (amdgpu_amdkfd_send_close_event_drain_irq(adev, ih_fence))
+		return 0;
+
+	r = wait_for_completion_interruptible_timeout(&fpriv->irq_drain_done,
+						      timeout);
+	if (!r)
+		return -ETIMEDOUT;
+
+	return r < 0 ? r : 0;
+}
+
+/**
+ * amdgpu_pasid_drain_irq_done - signal that a KFD interrupt drain completed
+ * @pasid: PASID carried by the drain fence
+ *
+ * Called by KFD when it processes the drain fence injected by
+ * amdgpu_pasid_drain_irq().
+ */
+void amdgpu_pasid_drain_irq_done(u32 pasid)
+{
+	struct amdgpu_fpriv *fpriv;
+	unsigned long flags;
+
+	amdgpu_pasid_lock(&flags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	if (fpriv)
+		complete(&fpriv->irq_drain_done);
+	amdgpu_pasid_unlock(flags);
+}
+
 /**
  * amdgpu_pasid_free_delayed - free pasid when fences signal
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 46b2c2160126..2af733d96d60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -98,6 +98,9 @@ int amdgpu_pasid_alloc(unsigned int bits, struct amdgpu_fpriv *fpriv);
 void amdgpu_pasid_lock(unsigned long *flags);
 void amdgpu_pasid_unlock(unsigned long flags);
 struct amdgpu_fpriv *amdgpu_pasid_get_fpriv_locked(u32 pasid);
+int amdgpu_pasid_drain_irq(struct amdgpu_device *adev, u32 pasid,
+			   u32 *ih_fence, unsigned long timeout);
+void amdgpu_pasid_drain_irq_done(u32 pasid);
 void amdgpu_pasid_free(u32 pasid);
 void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 			       u32 pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bac072d73e16..8b080e2e1496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1507,6 +1507,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		goto error_pasid;
 
+	init_completion(&fpriv->irq_drain_done);
+
 	pasid = amdgpu_pasid_alloc(16, fpriv);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1d86ddfd6bde..b3ebbee76088 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3223,7 +3223,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 
 		break;
 	case KFD_IOC_DBG_TRAP_DISABLE:
-		r = kfd_dbg_trap_disable(target);
+		r = kfd_dbg_trap_disable(target, true);
 		break;
 	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
 		r = kfd_dbg_send_exception_to_runtime(target,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059..8bed0d0f9bd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -655,7 +655,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	kfd_dbg_set_workaround(target, false);
 }
 
-static void kfd_dbg_clean_exception_status(struct kfd_process *target)
+static void kfd_dbg_clean_exception_status(struct kfd_process *target,
+					   bool drain_irqs)
 {
 	struct process_queue_manager *pqm;
 	struct process_queue_node *pqn;
@@ -664,7 +665,8 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		kfd_process_drain_interrupts(pdd);
+		if (drain_irqs)
+			kfd_process_drain_interrupts(pdd);
 
 		pdd->exception_status = 0;
 	}
@@ -680,7 +682,7 @@ static void kfd_dbg_clean_exception_status(struct kfd_process *target)
 	target->exception_status = 0;
 }
 
-int kfd_dbg_trap_disable(struct kfd_process *target)
+int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs)
 {
 	if (!target->debug_trap_enabled)
 		return 0;
@@ -704,7 +706,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	}
 
 	target->debug_trap_enabled = false;
-	kfd_dbg_clean_exception_status(target);
+	kfd_dbg_clean_exception_status(target, drain_irqs);
 	kfd_unref_process(target);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fbb751821c69..5babf9b992cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -43,7 +43,7 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 			unsigned int source_id, bool use_worker,
 			void *exception_data,
 			size_t exception_data_size);
-int kfd_dbg_trap_disable(struct kfd_process *target);
+int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs);
 int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
 			uint32_t *runtime_info_size);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2847a5ec5ede..ef9c698bd5cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1030,10 +1030,6 @@ struct kfd_process {
 	uint64_t exception_enable_mask;
 	uint64_t exception_status;
 
-	/* Used to drain stale interrupts */
-	wait_queue_head_t wait_irq_drain;
-	bool irq_drain_is_open;
-
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
 
@@ -1245,7 +1241,7 @@ bool enqueue_ih_ring_entry(struct kfd_node *kfd, const void *ih_ring_entry);
 bool interrupt_is_wanted(struct kfd_node *dev,
 				const uint32_t *ih_ring_entry,
 				uint32_t *patched_ihre, bool *flag);
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
 void kfd_process_close_interrupt_drain(unsigned int pasid);
 
 /* amdkfd Apertures */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..c1a01260463e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -55,6 +55,8 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+#define KFD_IRQ_DRAIN_TIMEOUT	msecs_to_jiffies(1000)
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -1019,8 +1021,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		if (ret)
 			pr_warn("Failed to create debugfs entry for the kfd_process, ret = %d\n",
 				ret);
-
-		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
 	mutex_unlock(&kfd_processes_mutex);
@@ -1420,7 +1420,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
 	 * on the freed process context. Retiring the context last avoids this.
 	 */
-	kfd_dbg_trap_disable(p);
+	kfd_dbg_trap_disable(p, false);
 
 	if (atomic_read(&p->debugged_process_count) > 0) {
 		struct kfd_process *target;
@@ -1430,7 +1430,7 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 		hash_for_each_rcu(kfd_processes_table, temp, target, kfd_processes) {
 			if (target->debugger_process && target->debugger_process == p) {
 				mutex_lock_nested(&target->mutex, 1);
-				kfd_dbg_trap_disable(target);
+				kfd_dbg_trap_disable(target, true);
 				mutex_unlock(&target->mutex);
 				if (atomic_read(&p->debugged_process_count) == 0)
 					break;
@@ -2313,17 +2313,14 @@ int kfd_resume_all_processes(void)
 	return ret;
 }
 
-/* assumes caller holds process lock. */
-int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 {
 	uint32_t irq_drain_fence[8];
 	uint8_t node_id = 0;
-	int r = 0;
-
-	if (!KFD_IS_SOC15(pdd->dev))
-		return 0;
+	int r;
 
-	pdd->process->irq_drain_is_open = true;
+	if (!KFD_IS_SOC15(pdd->dev) || !pdd->drm_priv)
+		return;
 
 	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
 	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
@@ -2342,32 +2339,17 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 	}
 
 	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
-	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
-						     irq_drain_fence)) {
-		pdd->process->irq_drain_is_open = false;
-		return 0;
-	}
-
-	r = wait_event_interruptible(pdd->process->wait_irq_drain,
-				     !READ_ONCE(pdd->process->irq_drain_is_open));
+	r = amdgpu_pasid_drain_irq(pdd->dev->adev, pdd->pasid, irq_drain_fence,
+				   KFD_IRQ_DRAIN_TIMEOUT);
 	if (r)
-		pdd->process->irq_drain_is_open = false;
-
-	return r;
+		dev_warn_ratelimited(pdd->dev->adev->dev,
+				     "irq drain on pasid 0x%x did not complete (%d)\n",
+				     pdd->pasid, r);
 }
 
 void kfd_process_close_interrupt_drain(unsigned int pasid)
 {
-	struct kfd_process *p;
-
-	p = kfd_lookup_process_by_pasid(pasid, NULL);
-
-	if (!p)
-		return;
-
-	WRITE_ONCE(p->irq_drain_is_open, false);
-	wake_up_all(&p->wait_irq_drain);
-	kfd_unref_process(p);
+	amdgpu_pasid_drain_irq_done(pasid);
 }
 
 struct send_exception_work_handler_workarea {
-- 
2.43.0

