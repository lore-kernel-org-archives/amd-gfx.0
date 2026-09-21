Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D40C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3DB10E1FF;
	Mon, 21 Sep 2026 20:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iz02riJd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741DA10E1FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv4XB0bvS/lW0swFbGINVeb4gNLaVhCKEY6hdoWjYA2Q5f8FoJyxjr6JbYFYApvq+UAA/AKZU8GPmFSX64AVv1w1j5m3xCK+YmKHkkSSz26SmNjZyNIZRgKyRGgU5XRdM6MSIhdeTRSxaXzxdooghGDMmrrF5Kp+r6YyinBw9VbsaD/lNnXdY+QA8Bx1RMDRnIBu20D56HYa+mm55NtEdTK5DdMmTCYMkM/AzqwfSalV0xXmIBKBgH+0jf0LT6Idcg3vtHhFzv9LVdjprJGLC08G7irmqXS05VzncvL2iYT3xK4dRUI5qkOwlkv7olKwiCSrNqU3OZN9C03P9RKJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH6vBiQxeaS8I1jUQzl5gsPmaR9qGiGGVXWHSpq/GLc=;
 b=OzsbwXXwSxeYGLD5EX0pS613YBK6i3esstiCZenmLGnSB2Zia/mODWeQvc85VuJIF8dBERI1+tkYSVFp3vCdZLZ3KaC+bgxYWKRkZopfINg0ir8jlgWdNKNWyJ8t17gmgG3f5xCepLs/64sYD/r26/vcwyvRw2kGf0R1H/lulzlv9Y2C7F2VQGpYzkXYS5gZvl5bQ0FlaYu/yFsO7ZOjhhSM4j7ogb279yJT9oeRHbzLqj93DfAVrBxELdIOC8ExkAPn3jOCYo1ieCgfDRIq/wuUJuY7+QR/DF8vmoQInMLOzqgLJtu0A1pK1c3Sl1rwEJrb2iLUXIzLXL0cEHgC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH6vBiQxeaS8I1jUQzl5gsPmaR9qGiGGVXWHSpq/GLc=;
 b=Iz02riJdlqw4KrkbEVtw/3rA5k7whMZOx/TTLPct9PzkFPbM6j/2/vOjjfFLuskrjWLJ4sl4ahK8SJJoz9Md475E8Kh7ZWsf1C3mUcWiFsA01Hk5ZoxuQ8sM5hiMsqMIgwsoKo07Wubso4D9zyXigdRFB43t0fNa5RwGwp7Z/Z4=
Received: from BN9PR03CA0426.namprd03.prod.outlook.com (2603:10b6:408:113::11)
 by EAYPR12MB964616.namprd12.prod.outlook.com (2603:10b6:303:2ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:22 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::5) by BN9PR03CA0426.outlook.office365.com
 (2603:10b6:408:113::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:20 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:20 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: add generic RLC SPM interface layer
Date: Mon, 21 Sep 2026 16:03:04 -0400
Message-ID: <20260921200313.865829-3-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|EAYPR12MB964616:EE_
X-MS-Office365-Filtering-Correlation-Id: 264ba776-92aa-41a3-065c-08df181b62fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|3023799007|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: Lvhh3tmA4g/L+Cp0wTgl97cSmXmIh1AOmwciAccfhC9Vqm2e+bGr3uxVNTZFg1TaTWCN90O4vl/t8jDCGawKRYw4B1P3NhR/uytV/18rbCfBM3B+dOI6uzBE1td1WBKgRqK2imcX8lLERcpPzDmLed3PxYdSv5z8hN4yFXzj0RrqeZeZE0FkKU2AV/4VZ5K03u9IPKQxM/XNgV0SzVG331Jr23LYeTK6O9r8gWpCIJioblhe3wBqStG6+xYpvc1zvIx3AQKGetqJ9UJSo9Y6ZQYbDeojPro6cD5cLNRW8BqOuKpmuwTaUXb3KB9P2YUCdkbBPbXB/Sfvku1s9W5q0xKUMk2eYoQUqiuCHMrw+evXcHfsNAebXZpdkicudPUXkY2k30zJ7aEj/VYTE1/p/T6GSPxdLwHix0ZyCuswSu+ECHcWbharQPvqHbmM3ZGZrlAgup+aImG/jPGrh+HLzEp/Y+df712zGnC/3VYRMF+SFhsco4go2Lodps+se1utyX6S7q1+yeU7EASJAkYpH6juVWP9mBRfdeQzJ/S7JEWMgrHHC05m9/omrpAh9Hix/x4qmAL2GYHs5AEorMSYQRu0m2n9qNZpi/CR5mqXWWVSbXqM1jhrvm2/72KCmmL1oNU21tup9tYE2qVjQ9xL9chhXrBnvlalSq0muCh1z3MnNvXuTPtZo6Nf5wbOVzmV2eomS0vria2YeeqBIM18kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(3023799007)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2bo9iCUYTECZ97EvPT96ffZy4izpKDwgn+UnQ3jjr+mQ+bFOgzqKxo7zw2cGVKdGrDJ+RIzSkI30St7+OPKsumlaYdn1wCUrI/LGCw/qPRfkvpSmJhj+HOTMR9WYpylP9yDFRYZEz5hezPh7uZTC8lQpbQekIcta2Tb0E/lFfcxLGhbCIy8S0VTRJIwL0pvM3GMzQ0/R+Tf4iL4ax0QLXFv/QAx4wspZJ7kiiVSoa8mhK9R5n47eh+RA89z2jBsVsW/RB7yAS7Bm8s8D5SSFPhAHpmm5HHzhZrBCSVEUOej22NHersUlFX37LNqdxbWfkISIcRGvIXRaI3ZUu+YSWRW5ECI9FpHGCeRMH6tchNQR5OAdToPW27YGE1T8x9HogiTStFaAnvvcy7YvbryFTjHJ4SB1XFuLLHD4CD4eaPNdThRNxEaaQ1bFjCq+FWHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:21.3195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264ba776-92aa-41a3-065c-08df181b62fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB964616
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

Every GFX IP programs the RLC SPM (Streaming Performance Monitor) block
through its own registers, so without a common layer the SPM manager
would have to open-code that per-IP sequencing at each call site. Add a
hardware-agnostic layer: the manager drives SPM through a few generic
entry points and each IP only supplies register programming via an
amdgpu_spm_funcs table in adev->gfx.spmfuncs.

All SPM programming is issued through the KIQ ring so it is serialised
against other KIQ users and the RLC firmware; each op emits a polling
fence and waits so the firmware has consumed the packet before the call
returns. The per-IP callbacks run under the KIQ ring_lock and may only
emit packets, and set_spm_config_size tells the generic layer how much
ring space one op needs.

acquire reserves a VMID on the GFX hub for the SPM stream; release stops
the stream and waits for that stop to complete before freeing the VMID,
so the RLC can never keep streaming into a VMID that has been reused.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  15 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 230 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |   7 +
 3 files changed, 252 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index aefd4f03b443..fd87075962f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -174,6 +174,20 @@ struct amdgpu_kiq {
 	void			*mqd_backup;
 };
 
+struct amdgpu_spm_funcs {
+	void (*start)(struct amdgpu_device *adev, int xcc_id);
+	void (*stop)(struct amdgpu_device *adev, int xcc_id);
+	void (*set_rdptr)(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+	void (*set_spm_perfmon_ring_buf)(struct amdgpu_device *adev, int xcc_id,
+					 u64 gpu_addr, u32 size);
+	/* Dwords amdgpu_rlc_spm_kiq_submit() reserves on the KIQ ring for one
+	 * submission. Must cover the largest of the callbacks above plus the
+	 * polling fence emitted after them; amdgpu_ring_write() has no bounds
+	 * check, so a short value silently corrupts the ring.
+	 */
+	u32 set_spm_config_size;
+};
+
 /*
  * GFX configurations
  */
@@ -429,6 +443,7 @@ struct amdgpu_gfx {
 	struct amdgpu_mec_bitmap	mec_bitmap[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_kiq		kiq[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_imu		imu;
+	const struct amdgpu_spm_funcs		*spmfuncs;
 	bool				rs64_enable; /* firmware format */
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 002fae3c380e..79641e537fbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -622,3 +622,233 @@ void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev)
 	else
 		adev->gfx.rlc.reg_funcs = &amdgpu_rlc_reg_funcs;
 }
+
+/**
+ * amdgpu_rlc_spm_kiq_submit - helper for SPM KIQ command submission
+ * @adev: amdgpu device pointer
+ * @xcc_id: XCC instance ID
+ * @emit_fn: callback to emit commands into the ring
+ * @emit_ctx: context pointer passed to emit_fn
+ *
+ * Common pattern for SPM KIQ operations: lock, alloc, emit, fence, commit,
+ * unlock, wait. Centralizes error/undo paths.
+ *
+ * Callers guarantee spmfuncs is non-NULL.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int amdgpu_rlc_spm_kiq_submit(struct amdgpu_device *adev, int xcc_id,
+				     void (*emit_fn)(struct amdgpu_device *, int, void *),
+				     void *emit_ctx)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	unsigned long flags;
+	signed long r;
+	u32 seq;
+	int ret;
+
+	spin_lock_irqsave(&adev->gfx.kiq[xcc_id].ring_lock, flags);
+	ret = amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	if (ret) {
+		spin_unlock_irqrestore(&adev->gfx.kiq[xcc_id].ring_lock, flags);
+		return ret;
+	}
+
+	emit_fn(adev, xcc_id, emit_ctx);
+
+	ret = amdgpu_fence_emit_polling(kiq_ring, &seq, MAX_KIQ_REG_WAIT);
+	if (ret) {
+		amdgpu_ring_undo(kiq_ring);
+		spin_unlock_irqrestore(&adev->gfx.kiq[xcc_id].ring_lock, flags);
+		dev_warn(adev->dev, "%s SPM KIQ fence emit failed (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock_irqrestore(&adev->gfx.kiq[xcc_id].ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(kiq_ring, seq, MAX_KIQ_REG_WAIT);
+	if (r < 1) {
+		dev_warn(adev->dev, "%s SPM KIQ fence timeout (seq=%u)\n", __func__, seq);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void amdgpu_rlc_spm_emit_start(struct amdgpu_device *adev, int xcc_id,
+			   void *ctx)
+{
+	adev->gfx.spmfuncs->start(adev, xcc_id);
+}
+
+static void amdgpu_rlc_spm_emit_stop(struct amdgpu_device *adev, int xcc_id,
+			  void *ctx)
+{
+	adev->gfx.spmfuncs->stop(adev, xcc_id);
+}
+
+/**
+ * amdgpu_rlc_spm_cntl - start or stop SPM hardware stream
+ * @adev: amdgpu device pointer
+ * @xcc_id: XCC instance ID (must be < adev->gfx.xcc_mask bit count)
+ * @cntl: true to start, false to stop
+ *
+ * Caller must ensure xcc_id is valid - no bounds checking is performed.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl)
+{
+	if (!adev->gfx.spmfuncs)
+		return -EINVAL;
+
+	if (!(cntl ? adev->gfx.spmfuncs->start : adev->gfx.spmfuncs->stop))
+		return -EINVAL;
+
+	if (!adev->gfx.spmfuncs->set_spm_config_size) {
+		if (cntl)
+			adev->gfx.spmfuncs->start(adev, xcc_id);
+		else
+			adev->gfx.spmfuncs->stop(adev, xcc_id);
+		return 0;
+	}
+
+	return amdgpu_rlc_spm_kiq_submit(adev, xcc_id,
+					 cntl ? amdgpu_rlc_spm_emit_start : amdgpu_rlc_spm_emit_stop, NULL);
+}
+
+struct amdgpu_rlc_spm_rdptr_ctx {
+	u32 rptr;
+};
+
+static void amdgpu_rlc_spm_emit_set_rdptr(struct amdgpu_device *adev, int xcc_id, void *ctx)
+{
+	struct amdgpu_rlc_spm_rdptr_ctx *rdptr_ctx = ctx;
+
+	adev->gfx.spmfuncs->set_rdptr(adev, xcc_id, rdptr_ctx->rptr);
+}
+
+/**
+ * amdgpu_rlc_spm_set_rdptr - update SPM ring read pointer
+ * @adev: amdgpu device pointer
+ * @xcc_id: XCC instance ID (must be < adev->gfx.xcc_mask bit count)
+ * @rptr: new read pointer offset
+ *
+ * Caller must ensure xcc_id is valid - no bounds checking is performed.
+ */
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr)
+{
+	struct amdgpu_rlc_spm_rdptr_ctx rdptr_ctx = { .rptr = rptr };
+	int ret;
+
+	if (!adev->gfx.spmfuncs || !adev->gfx.spmfuncs->set_rdptr)
+		return;
+
+	if (!adev->gfx.spmfuncs->set_spm_config_size) {
+		adev->gfx.spmfuncs->set_rdptr(adev, xcc_id, rptr);
+		return;
+	}
+
+	ret = amdgpu_rlc_spm_kiq_submit(adev, xcc_id, amdgpu_rlc_spm_emit_set_rdptr, &rdptr_ctx);
+	if (ret)
+		dev_warn(adev->dev, "Failed to update SPM rdptr to 0x%x on XCC %d (%d)\n",
+			 rptr, xcc_id, ret);
+}
+
+struct amdgpu_rlc_spm_perfmon_ring_ctx {
+	u64 gpu_addr;
+	u32 size;
+};
+
+static void amdgpu_rlc_spm_emit_perfmon_ring_buf(struct amdgpu_device *adev, int xcc_id, void *ctx)
+{
+	struct amdgpu_rlc_spm_perfmon_ring_ctx *ring_ctx = ctx;
+
+	adev->gfx.spmfuncs->set_spm_perfmon_ring_buf(adev, xcc_id,
+						     ring_ctx->gpu_addr,
+						     ring_ctx->size);
+}
+
+/**
+ * amdgpu_rlc_spm_acquire - set up SPM for a specific XCC instance
+ * @adev: amdgpu device pointer
+ * @xcc_id: XCC instance ID (must be < adev->gfx.xcc_mask bit count)
+ * @vm: virtual memory context for VMID allocation
+ * @gpu_addr: GPU address of SPM ring buffer
+ * @size: size of SPM ring buffer in bytes
+ *
+ * Allocates a reserved VMID, initializes SPM VMID to 0, and programs the
+ * ring buffer address and size. On failure, reverts VMID to 0xf and frees
+ * the reserved VMID.
+ *
+ * Caller must ensure xcc_id is valid - no bounds checking is performed.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+			   struct amdgpu_vm *vm, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_rlc_spm_perfmon_ring_ctx ring_ctx = { .gpu_addr = gpu_addr, .size = size };
+	int r;
+
+	if (!adev->gfx.spmfuncs ||
+	    !adev->gfx.spmfuncs->set_spm_perfmon_ring_buf ||
+	    !adev->gfx.rlc.funcs ||
+	    !adev->gfx.rlc.funcs->update_spm_vmid)
+		return -EINVAL;
+
+	r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+	if (r)
+		return r;
+
+	/* init spm vmid with 0x0 (outside ring_lock to avoid sleep-in-atomic) */
+	adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0);
+
+	if (!adev->gfx.spmfuncs->set_spm_config_size) {
+		adev->gfx.spmfuncs->set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size);
+		return 0;
+	}
+
+	/* set spm ring registers */
+	r = amdgpu_rlc_spm_kiq_submit(adev, xcc_id, amdgpu_rlc_spm_emit_perfmon_ring_buf, &ring_ctx);
+	if (r)
+		goto err_revert;
+
+	return 0;
+
+err_revert:
+	adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0xf);
+	amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+	return r;
+}
+
+/**
+ * amdgpu_rlc_spm_release - tear down SPM for a specific XCC instance
+ * @adev: amdgpu device pointer
+ * @xcc_id: XCC instance ID (must be < adev->gfx.xcc_mask bit count)
+ * @vm: virtual memory context for VMID release
+ *
+ * Stops the SPM stream via KIQ, waits for completion, then reverts SPM VMID
+ * to 0xf and frees the reserved VMID. Waiting ensures the firmware has stopped
+ * SPM before the VMID is reclaimed, preventing VMID reuse while hardware is
+ * still active. On stop failure, still reverts VMID and frees reservation
+ * (best-effort cleanup) to prevent resource leaks.
+ *
+ * Caller must ensure xcc_id is valid - no bounds checking is performed.
+ */
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm)
+{
+	int r;
+
+	r = amdgpu_rlc_spm_cntl(adev, xcc_id, false);
+	if (r)
+		dev_warn(adev->dev, "SPM stop failed on XCC %d (error %d), proceeding with VMID cleanup\n",
+			 xcc_id, r);
+
+	/* revert spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0xf);
+
+	amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 959d60c90dcd..18b925a0d164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -26,6 +26,8 @@
 
 #include "clearstate_defs.h"
 
+struct amdgpu_vm;
+
 #define AMDGPU_MAX_RLC_INSTANCES	8
 
 /* firmware ID used in rlc toc */
@@ -384,4 +386,9 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
 void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
 
+int amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl);
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+			   struct amdgpu_vm *vm, u64 gpu_addr, u32 size);
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm);
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr);
 #endif
-- 
2.34.1

