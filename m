Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA01FEC119
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BB510E62B;
	Tue, 24 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rr1WbAI0";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9582010E168
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:20:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0LinVnkPimsqbVxmxzSjwHOmLGu94U8gjRM08lyuZcBwruTGDPkA6DjbSr60YgZMXaDk6RbDnCDrn1YpfvCgizitCSv9utDYU0D559hVckSyjcrcwr6zUCrlU6dfKJfGnY56zNt7SXi/boI0zgoU8Q2gjoiDI43ICUvk0XllcQqPHIQu3sgp35rKlFNyvteVyYRPN8UklpVnqm4mAZitADKpeiJgA/plLwp/rooJAzoTHKXNZZiH1//p5TpCIq26wtlSbhuRlheohtM2M7cVC8R4y5wjZigVEFHAkGtllLRvGXIAYPEYB+XAoIxpp7m+q0GzOU+6Y10/MKrucIUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3DGU5mlJQ/feSzy5Y0mynUAdln2P0IYXs78GokJ34E=;
 b=n783eYXlbcNTZIBQZA3IK0f9yybZT+2K0J/peO4Klm9wdygpFZ6HA/3zQuy/yzCeU18nUNnppzg6UO51N+yVna6pf88k3OhPlhAMbZsknD9cWqLDQCtDemv8ZSzRd0Opid3a2MQCcwiC2HO1/FpY4C/QHkSkxIkl9ZmjpJMCr8/ERLNIqlisS0AbBT9gEDWUupfGrODfVRYocAWKEDctBsGmibpy4Bf7Bx8IsCL5+52B29Sw1fCuyI2C1q4d3xiN1Yf2dOXQXy5/S5kdZWAca+DGpY26Itt1dzoYEHD9ZccuhQa8A2im0CGsAEyiEYAOMRVdniIWai7GTn06V9jOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3DGU5mlJQ/feSzy5Y0mynUAdln2P0IYXs78GokJ34E=;
 b=Rr1WbAI0LmOFjJ7MMb/AZrvPitfj5NecQ+SZquByi+ckW7F4w4gp98286rrXoH9I2/i9O8XJegIxF5C3Xy12A8L65nWGqC3Sn2QyTtyhn0PYQUlLgXpq0v203VBudyGanhtSsa6aPCSJcJZKZXINWvpPZdHa3AY+OasiyvFMIO4=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:53 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::15) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:43 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 06/17] drm/amdgpu: add RLC SPM interface to
Date: Tue, 24 Mar 2026 17:20:19 -0400
Message-ID: <20260324212030.822932-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e26fd3-b84a-42fc-4f65-08de89eb3afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: QWBud/fG4c0H8N3Av8V2BLPdb8zR5dYAlAobQsmm+WxS2b19F6+LiLDyp0/dOz6QFd0RknZ6J5RUZmXDKxiKGNn5uikCXP0T/AcvpGaI0WlUjfah3S00MIfNMRmly8zt5rzT/qoc/E8z39/JckZ0Z5CwMK0fieLJIkvbjNyV3nqINrl3HrgLDd98tJaCboX4N3CbjZqOXtS+ZdMtHx6pLP6O10WAs2z8p46RAV/SS6GHhj7SpzWdj5xSw4HpX55dXAF1RL7G7Dv+gyhs42GbISeJ7PFIEioFHCxOlLLeyRnLzy6HE9aa8y+z/Pvr2vM5QaKIGs9f5Agbx5+Rvph4QdN8mwRJxkrZeilZqub2H8RwniqNETtwtUVxzOk8bQnkXZk8yJqUb/sSBxAIy2nDM4Eh/EzFQe7aYt9w+LsIFI67wJ/Y3x480++EJqjW3+x60LZBG2bfs2gUjRXfJO8u6N5cmw5WAkfjrAnv1vYzZwR+DQdy50gE/rJyDZmlyeluNfCA6Wj+anAtK8dPR58AI0r6O63t19QiEq7RygE/aMKwYYPT5NbXleuimYXiVQP2l+1twmf+zKCnZzXIcOvgzPm27Zvlyr+CioMamI0Yy8LKCNRodrhOQ99crkPnGtIxYvA/HSMiyPqXmwnR2mn7mfh98ohJZ2+7dUDn1NjiBwn9zLWZV1edKiW1+TyHz5yJOB+Hl0gIRK4CBZErvN7c1DUeTdBxAyVT4kUT6UOKEf+tG0+JKndW8ILMz8rBwDFP5r/sdvd/8d7OGqo4BucsdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iq7lPED7vhehNPaNMspaBLWS4O1izZUOvf2V+tzCvRxdBENL92RVyisjqhLRKmW0w08MhArQZ5wnwp4EtjGATD7nPIEC5Tbd5aaZMtvxBRuGUa8JaflF5Hh8Wk9suz6ZnN+KXL/MW68QTGQkDie+ya6GoGDlMVw7Ne5BrV0dz7JmbBTK+1+3trJjW+3wlnR8nxCIpVk+xiq+eK4xFBQcKvYiJk9VmDdgiKZmygSYQsNREr+h2ktX+hmxoRgBXGS6AKdu49iJYHWR8c8HBoQ0c9TtYkUazxq5LT9Tf2CUVsljT7BF+gDrrXXUQ1Ev0DKLIGK/d8TdBiw6+ejmwyxgrvgvXacPHs78y4nm31nQkp/tW2Gw6H7iok+V3+DXndRnaoq4vSWpEff6Sv2a9kiBrQoVYwsBOWrQn0wcwh5Fi7w+ZdTTQlgCZ9RtsDM92PPM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:53.2631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e26fd3-b84a-42fc-4f65-08de89eb3afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 90 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  6 ++
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..016eed89d6f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -164,6 +164,16 @@ struct amdgpu_kiq {
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
@@ -418,6 +428,7 @@ struct amdgpu_gfx {
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

