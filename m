Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B277ACD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D026410E68A;
	Tue, 26 May 2026 14:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NPOIQrET";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108C610E67C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvZZFBQEwoR5dOP1PBYQ4Dwd6hEf8Ot/KxEbqIAlwlMBWzk/T6JZ2XFfUAOUyWNiJu3+dvpQOhMi++AUqkzA09MnTidQ/Z/cz/jnYxjowBqo0X+ejVjBZvW+BUVDFCVxNHSOKAV29gLx47WIYqpZwUbzYcMIttIO+SPqQAiVtOjru0eBZFvZPbaNaFbWwQ9xHO8JAUhK3214zcQ0hmFOwKQ2M/LPFcdQ4fJv2U4E1xXKDoeJKQ1YbHscgfx9ITn8ZmsBZjss3ROAi/FTIvZzALR34WPLEOqRgEf5VKZfuy+UuOuTt+Bd8VolcR3RQjw8CLT1+FeMWviwvls+wYqV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0iv3DfnBiJNwVkhOWKvdHqQp1wK9koLtlc6WjawDUA=;
 b=Pq2whaP/dv530DLjAGROMRq62rKvbC7SAS+oHRfuXJBR4quWemmfGj2W+Zx9Z6SbHJm/dGi1VTDHhmjq4BHmGm88NOcE3gJm+nVB6Y5/Cb9PAU+pis7XOU6XSZUmnwm0KxFFGj48vTw8L29uxfOb2FpFvei2iuMBif6FrSNTc+GcA4FICaUsZg0h1Pu79Ery26f3E7Lf4Kr4zyXD9IFm3ztbUj2SokhPnCmPOD866YAiXwn6FbRj3TftbZOM1PI60qH6HARWYzsmSsKsrxZU9ZlyXxHlNFEUhrb8D2x17fgDfAKlYuTHWG6Ct2nmEKpPiiYR5gr6a7/cJhnHwm5uQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0iv3DfnBiJNwVkhOWKvdHqQp1wK9koLtlc6WjawDUA=;
 b=NPOIQrET6C+FpWNt1ZX5zotFYNNBxUtVu79YtwmnQA95etjotWTHBN9kOFUripHdgqTYcklj2KcuQiCxfZdEXldghl4Wc7DWx+MhKXzMjc5AJpRaUhpGxMJWLbFjk504iMERQbpNmH1TlJGDR27i3YNFb/i0mqYOPut3ly6nzHQ=
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 14:11:55 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::28) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 14:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:55 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:51 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 06/17] drm/amdgpu: add RLC SPM interface to
Date: Tue, 26 May 2026 10:11:18 -0400
Message-ID: <20260526141129.592886-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: f85690e3-d0bb-406d-dac6-08debb30be45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: z3QRVnkbHoHe1Ym7d4VtkZ9bM2d5qcKg+IQyjI0g54eBC5ITggxiY0fZzQ0N+Rk7ZpLIRAe9DUNAKdjqH3CUJRprtB5VF61WMpxsW9Lx80lGv+ajCk5PHGRQm2VDn2VpZrZOgf4kC9gfoS/RmQog3aja7xf6gkcYWG0o85jDWXR/friOv0KzzoVSpcSqNnZDImQLtMi9uQYMU/8BBB1x8dJPnXiMm0YQtemglGlO9l2HqyFgGhX763qJyABvx6reS+/+P89+xiYJaKZmvbBAFYChplkmmdpcXM9ainf9sRHDlmQOPEAROp4n3oIkqtRfnSZZh1JKvOPsVdMxFAPkYTig2P/ypEPC5gzjvsBOheYg/hH23FBiC7PRCA77rtNxtlP9GDupGm2dIRuQAgYsr6/L09Hs9kYcXCPoR4esI0bTONWFCQtpi/r4YbLgYKr6KP561MrlQe0l5A0mA775Dm99PmYoqCpny2jiw24mvAoDmjUykU48j2RKw08XjO0EiWseKa/zg+SRub2njLJJZ/bUCwJlHQtQ9W4YOQu87wmfQj+65SGx4HApaADRenTWw56n8GlEnkSke1HpFs9PdtF6RuF0o8KvRTTskn2dfR+gt0hduKbsCbZ0FMy8WC0RPS4WiiocuUiecouAFq+K3xDsS+/3jXG0q1Hc4Nf/g8mWLdXHu0IHIISU0CAwX743XykSS27gIet9Z4OrJ752p+4I+1OKJw8bwXFQljSgpBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kKCANstPm4I+RWb7M2bIXu0oO08S9YgEiA2ZP92Ro6pJYuRaBTGiU1MF3sk63vAytBC/hOQepjskUjkYNFFi43QiLkECxB//MBKKd9qzuTGgCNYJLso64TZ+2Ia2eJMwmq/EYilJM6FkmBie4LPhJ4t/DhEWuaRKMhjH4ngMrmaxCbtQP7RUYUTUQObYUTm2oA1oM2Q6apK6cAEGsXc1Do3hLyyIAAFxM9I9/mEDezncL1NFNUoHEHvLJdZs5kiwMAOZz1I/K/ZccPvMK5guJWyYcvVG+ZYPRtLJOk+sPcYK3OqLOS0ooHBJtQV8PjVhJzQQWoaqgrfOQcvFq1N3KCn+f4pOL68Amq2EOM3pV99m40FtHt74q2K4ALoX4ZAbwdJb6v0IJHYWDSCZB0/m8WfzidMBUumAFPFwbaeW5zyo5kaR/OCT5yNbT/ixlpvV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:55.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85690e3-d0bb-406d-dac6-08debb30be45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

to introduce the hardware-agnostic RLC (Run List Controller) SPM interface
layer that sits between the generic SPM manager and IP-specific register
programming.

A new function table struct amdgpu_spm_funcs is added to amdgpu_gfx.h,
with the following callbacks to be implemented per IP version:
  - start(adev, xcc_id):   enable SPM hardware and interrupt
  - stop(adev, xcc_id):    disable SPM hardware and interrupt
  - set_rdptr(adev, xcc_id, rptr): update the SPM ring read pointer
  - set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size): configure
    the SPM ring buffer base address and size registers
  - set_spm_config_size: KIQ ring space (in DWORDs) needed per operation

A pointer to the active function table is stored in adev->gfx.spmfuncs.
All RLC SPM functions are no-ops when spmfuncs is NULL.

Five generic RLC SPM functions are implemented in amdgpu_rlc.c:
  amdgpu_rlc_spm_acquire(adev, xcc_id, vm, gpu_addr, size):
    Sets up SPM for a specific XCP instance. Allocates a reserved VMID
    on the GFX hub for the caller's VM, initializes the SPM VMID to 0x0
    (from the default 0xf), then programs the ring buffer base address
    and size via the KIQ ring. On failure, reverts the VMID to 0xf and
    frees the reserved VMID.

  amdgpu_rlc_spm_release(adev, xcc_id, vm):
    Stops the SPM stream via the KIQ ring, reverts the SPM VMID to 0xf,
    and frees the reserved VMID.

  amdgpu_rlc_spm_cntl(adev, xcc_id, cntl):
    Starts (cntl=true) or stops (cntl=false) the SPM hardware by
    dispatching start()/stop() through the KIQ ring under the KIQ
    ring_lock spinlock.

  amdgpu_rlc_spm_set_rdptr(adev, xcc_id, rptr):
    Advances the SPM ring read pointer via the KIQ ring, informing the
    hardware that the CPU has consumed data up to rptr.

  amdgpu_rlc_spm_interrupt(adev, xcc_id):
    SPM interrupt handler stub.

All KIQ ring operations are serialized under the per-XCC KIQ ring_lock
spinlock.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 90 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  6 ++
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a0cf0a3b41da..b126ce881fae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -169,6 +169,16 @@ struct amdgpu_kiq {
 	void			*mqd_backup;
 };
 
+struct amdgpu_spm_funcs {
+	void (*start)(struct amdgpu_device *adev, int xcc_id);
+	void (*stop)(struct amdgpu_device *adev, int xcc_id);
+	void (*set_rdptr)(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+	void (*set_spm_perfmon_ring_buf)(struct amdgpu_device *adev, int xcc_id,
+				u64 gpu_rptr, u32 size);
+	/* Packet sizes */
+	int set_spm_config_size;
+};
+
 /*
  * GFX configurations
  */
@@ -423,6 +433,7 @@ struct amdgpu_gfx {
 	struct amdgpu_mec_bitmap	mec_bitmap[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_kiq		kiq[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_imu		imu;
+	const struct amdgpu_spm_funcs		*spmfuncs;
 	bool				rs64_enable; /* firmware format */
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 572a60e1b3cb..faf2a34df42f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -583,3 +583,93 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 		amdgpu_gfx_rlc_init_microcode_v2_5(adev);
 	return 0;
 }
+
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	if (!adev->gfx.spmfuncs)
+		return;
+
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	if (cntl)
+		adev->gfx.spmfuncs->start(adev, xcc_id);
+	else
+		adev->gfx.spmfuncs->stop(adev, xcc_id);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	if (!adev->gfx.spmfuncs)
+		return;
+
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	adev->gfx.spmfuncs->set_rdptr(adev, xcc_id, rptr);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+			struct amdgpu_vm *vm, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	int r = 0;
+
+	if (!adev->gfx.spmfuncs ||
+		!adev->gfx.rlc.funcs->update_spm_vmid)
+		return -EINVAL;
+
+	r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+	if (r)
+		return r;
+
+	/* init spm vmid with 0x0 */
+	adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0);
+
+	/* set spm ring registers */
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	r = amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	if (!r) {
+		adev->gfx.spmfuncs->set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size);
+		amdgpu_ring_commit(kiq_ring);
+	}
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+
+	if (r) {
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0xf);
+		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+	}
+	return r;
+}
+
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	if (!adev->gfx.spmfuncs)
+		return;
+
+	/* stop spm stream and interrupt */
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	adev->gfx.spmfuncs->stop(adev, xcc_id);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+
+	/* revert spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid) {
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0xf);
+		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(xcc_id));
+	}
+}
+
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	/* TODO: */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index e535534237a1..c5da9e428c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -374,4 +374,10 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor);
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl);
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_vm *vm, u64 gpu_addr, u32 size);
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm);
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 #endif
-- 
2.34.1

