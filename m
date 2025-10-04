Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A957CAC5B0
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Oct 2025 06:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C765D10E00F;
	Sat,  4 Oct 2025 06:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFSslXrT";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDACC10E00F
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Oct 2025 06:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoJVIDVwBPDqr+/BQsbHWlmFRZFPovogGlVX0VekhmjseJyDONFSDgLiZ1XA4iByJ9iIPUYhTjTFMrnKpznl8yat0J6txB3rbReGEawDC4Rf1c449Fw/Wb3yDo5SF0r7J/msx/og8XyWN+Sv+iexBXTsw/D+rvI1a0do9FoePCod9ZPI4xH35Jwh7+jUQVP2ikiA/Kv0p6rmLz0GYJnZYr8rGZ1Qx+5TW6SBlFwZT/M3bk4wfCb/1svAz/wy/4dUfERF2w1ghrhBoy/vy6Etk9MD8m2waZ+GZMYu+K+6ccdoH4SOhBzdUp6i9gy7XjmrlDf6KY4U47+W61ExUXtOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9xv91mhgW9Nbvv+BUMAvawMMd/y2ZilRx2JNuVEnMc=;
 b=lY3f17bxPJnskbKZiIhkGzOOu2cOVSGMp/JlaOOteOluPg3/WTF2oJB/6NxGcjy28XhDum0gFNz+yHPbTI8jI/vtL1OYnuWyewKIHnqxeNLe7Md2ZxLyd/O3jEs2tTDw/xa0R5zIjytjqSLkLR7REDhw/RCNjABYPozuxKKTkibn6feEqjMwsW87PBYc1vAPf/XgJcTT31Njop3MVKg6RCERXKgPmB6FZ3MaXjeUYlCIoWHNP+QM8goKpeIjpoXOpFwc6pZFlZo0egBUOVaKxZLVXzLXcyz4LIgmJvlCTupSpx110vkIHInYTQk4pXAw76Pkz2fndn3DkwdpPRBRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9xv91mhgW9Nbvv+BUMAvawMMd/y2ZilRx2JNuVEnMc=;
 b=rFSslXrTG2g/VFl4946plFDrp/uxvOu/BuUMzLRX5LVTSEx5cOACC++HeH20yhou/ObxyLovVW+P0pIGGER+1WG+oJP59+qMZyfymbBvqNjH+09sZH1hPiw8Cjhcfmv1yYNxGoAIaq8c7IN744mtmW/c+c8nWa0v4XO2X9E2keA=
Received: from BN9PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:fb::32)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Sat, 4 Oct
 2025 06:30:53 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::19) by BN9PR03CA0057.outlook.office365.com
 (2603:10b6:408:fb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.18 via Frontend Transport; Sat,
 4 Oct 2025 06:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Sat, 4 Oct 2025 06:30:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 23:30:51 -0700
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Oct 2025 23:30:50 -0700
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, <Lijo.Lazar@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v3] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Date: Sat, 4 Oct 2025 14:30:45 +0800
Message-ID: <20251004063045.3901777-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: a3478cc4-6567-408b-db6e-08de030f90c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OxVOWOOCecnb9Fz98ZQ4LCSiB5V/jvUBTrLUykyoumEbjNdg8kaWWmOFUJwV?=
 =?us-ascii?Q?TfbSf77LLtRlAFbkO/Tuf7o5iHfURHOiwZsNo7soHSPwU5tx3s0t7UMM/SMI?=
 =?us-ascii?Q?ieGqLfqz53Zg1NuglTirs27+NSdx6K/2r6QGOn7ISBHiPuRH1V/jQ5x20n21?=
 =?us-ascii?Q?A2WwyxOMv3XWqxbdtf7du+QTlfMRdiNX7+mXqIqEPuGUKcWkQ1s5rdc3lExD?=
 =?us-ascii?Q?bob/HJx+90uPK8rRxXzekS9t6szKAdx56nfPim4fIbmU6EjaW/0Ume5ZvRtl?=
 =?us-ascii?Q?fIhdsn9r6UKUISkt3oa1LVaEzMWjEj5IoBZKsIcgs9lbF9wZvUKlzDaJqzGE?=
 =?us-ascii?Q?QVgjfgJFUCGKCvq69rbbwTbECpVRi2wq5Ur1UhabpOL5KRsbFSRn/LynVQa0?=
 =?us-ascii?Q?E1ag4SfVkRSuik6RKc7fxV1E3qQB+FaUO6imNA/uZPDSyAt9MXlim0jlVdGt?=
 =?us-ascii?Q?KWqjzwIo1AAIR1YkwiVu9CdvSkwg/s5n1etWzSgTonOE+EZ7xYXwDy44yCxv?=
 =?us-ascii?Q?znx+VlwT8tNaBDp7sCZcPbcKyuAaHfvSnDqmtJ41kvN9BdVbGnTksErhkrQX?=
 =?us-ascii?Q?tQtPHb6n4sjRLyWp+p1MlSXdQMTsM1iiaplKz8RtXVhtgvBUQJKLTMKstZRO?=
 =?us-ascii?Q?DG2x3Mva7zWr4LkxY2FS67APOGEpmIPWyUo9wwTWeFWvnIivJfvV3oLi7yhl?=
 =?us-ascii?Q?1vLN19vlqilGE9IyIh5wBQWc0HwFTckUwqEIhCBo5rN1YBTsZb6F5kCXt84y?=
 =?us-ascii?Q?9JiXbsTgaLarO71a+wZpnvOWJJ51iC2TjDNfVv6d8m8CNc8e9KqgZ6gBOzPD?=
 =?us-ascii?Q?vXSsAIkdR93qIntmuBDgVgv0ucfNcw3SwOlvv3A8KW9FQHNGEaiUOwRNTSED?=
 =?us-ascii?Q?Qbc7v6C0HRFhdM5Tq3XLBFKQ05eHS542rq2sBvGwu+8TnpABSsZNmuFWLOT7?=
 =?us-ascii?Q?/O+vZ9kphFQlLFiaIIGoGfl9hnZiSfdHf26Kg0YW1NRHYcnp2s3br+gMB8BI?=
 =?us-ascii?Q?+j2dDye6G5YljdmrEd94WM0zpj1W4+vCkXnQBgpJgN3UmWkAhK6/QGStA/fj?=
 =?us-ascii?Q?PtKQHHqE8Dm43SpYdaX6anLPeekGgLrRP8x3JnAD5ltTarMNhf/wIZy8QGXB?=
 =?us-ascii?Q?A5zh2FaHqOYdnV9MGj+PcQbbUMHS+gvpMoQx0IPb0dpS+vPhFjt/vJxOoDe7?=
 =?us-ascii?Q?YPc9CzSYmb6wjQhwOXNOIdqvdiBDMRnc8Xp/q1AHZC8/+rNuxALn8trPy9sR?=
 =?us-ascii?Q?GyJoNEEdt0jAe/6FhwdFi/MDIyc1CpbQ/qCGW7n/UuYxiqxCvR9UjdHmiTvM?=
 =?us-ascii?Q?O7Q2zSW3Jn4cqHfFh5cvZTLE+DwwZcPgY0v0mTmObel2iPdHhSQXUFkrnpE9?=
 =?us-ascii?Q?hqFtYzUxbYc1EXwVCDYxbtSY+wlk21z8nuW57m/PJ6jm24qT9RkuAs6Bg69r?=
 =?us-ascii?Q?KF00bMv0gbyia4kXRSV1JW2gcu8wF+CdtLkHQZG+64qGRRzhm3zDm0Qm/IG2?=
 =?us-ascii?Q?/nhKoUJ/xJmkYqLDqIi1TYffbFJjn0f/wzPhkaxw/MqqyFW1afn/VMUnXMbb?=
 =?us-ascii?Q?4xrUFDGvQz+S1stKjPA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 06:30:52.1036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3478cc4-6567-408b-db6e-08de030f90c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
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

Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for
hdp flush. This register need to be write from CPU for nbif to aware,
otherwise it will not work.
Add kiq ring callback to emit GPU_HDP_FLUSH, in amdgpu_device_flush_hdp
if no ring provided.

v2: remove changes to flush_hdp callback
v3: add mes fix

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 73 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  1 +
 9 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a77000c2e0bb..57d3ea33dec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7269,6 +7269,8 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 
 	if (ring && ring->funcs->emit_hdp_flush)
 		amdgpu_ring_emit_hdp_flush(ring);
+	else if (!ring && amdgpu_sriov_runtime(adev))
+		amdgpu_kiq_hdp_flush(adev, 0);
 	else
 		amdgpu_asic_flush_hdp(adev, ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f02e36ccc1e..ecd7908590de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1194,6 +1194,78 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
 }
 
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	signed long r, cnt = 0;
+	unsigned long flags;
+	uint32_t seq;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *ring = &kiq->ring;
+
+	BUG_ON(!ring->funcs->emit_hdp_flush);
+
+	if (amdgpu_device_skip_hw_access(adev))
+		return;
+
+	if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready) {
+		hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
+		hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
+		ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0; /* Use CP0 for KIQ */
+
+		amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
+					      ref_and_mask, ref_and_mask);
+		return;
+	}
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
+	amdgpu_ring_emit_hdp_flush(ring);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r)
+		goto failed_undo;
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	/* don't wait anymore for gpu reset case because this way may
+	 * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
+	 * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
+	 * never return if we keep waiting in virt_kiq_rreg, which cause
+	 * gpu_recover() hang there.
+	 *
+	 * also don't wait anymore for IRQ context
+	 * */
+	if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
+		goto failed_kiq_hdp_flush;
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+		if (amdgpu_in_reset(adev))
+			goto failed_kiq_hdp_flush;
+
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY)
+		goto failed_kiq_hdp_flush;
+
+	return;
+
+failed_undo:
+	amdgpu_ring_undo(ring);
+failed_unlock:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+failed_kiq_hdp_flush:
+	dev_err(adev->dev, "failed to flush HDP via KIQ\n");
+}
+
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 {
 	if (amdgpu_num_kcq == -1) {
@@ -2484,3 +2556,4 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_compute_sched_mask_fops);
 #endif
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index fb5f7a0ee029..5bccd2cc9518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8841d7213de4..751732f3e883 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9951,6 +9951,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v10_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 66c47c466532..10d2219866f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2438,7 +2438,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
 			if (version_minor == 3)
 				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
 		}
-		
+
 		return 0;
 	}
 
@@ -3886,7 +3886,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	memcpy(fw, fw_data, fw_size);
-	
+
 	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
 	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
 
@@ -7320,6 +7320,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 710ec9c34e43..e2bb8668150d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5597,6 +5597,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 0856ff65288c..d3d0a4b0380c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6939,6 +6939,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_rreg = gfx_v8_0_ring_emit_rreg,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.emit_hdp_flush = gfx_v8_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v8_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index dd19a97436db..f1a2efc2a8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7586,6 +7586,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 77f9d5b9a556..b1fa4036befb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4798,6 +4798,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 	.emit_wreg = gfx_v9_4_3_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_4_3_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_4_3_ring_emit_reg_write_reg_wait,
+	.emit_hdp_flush = gfx_v9_4_3_ring_emit_hdp_flush,
 };
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

