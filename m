Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C10C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 11:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE24361002
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 11:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE24361002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170276F413;
	Thu,  7 Oct 2021 11:40:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682F86E86D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 11:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR92ffw6UsOmjnxa5BT5vdKVm8yFwiYkXWKMHcJavj82hpMDP0RZJKgEpLlNTFj1MfeM4VKiIhjHI65A7VWiLuidEWHht4NC9rf6gnnF8pPIIRxBFShboEh7UNWoBaz5NqeSrt2INOx15dP+6bCd0j0aYbx9LMuBwz6iIaTidDcv2K1ctrVj3k8Dvt/xARwiTZa2MrhcjriFE3hkT9jQ6y/qesWpBOu4JbKzSw7qaMm16ZRHiD0999T+efqFt6Kfo4QLnIAuO5o8u3il1BJ01wPO5PXggTmdQsHbTZchuvuyc0k+VZCX+D8UiQ15lw5fLlTBWmebnUdyOacR/fTnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlOhLhZ0VXkKjJ5+A/yMoJFv4as5cqwOF4R1jegQHQU=;
 b=awGrCUBdvOl8464ihdMGZYFSahlvsipKINLAUJnzR8VSdGkeXe+zxhdGobmp5j+fsQWCUygZmMqZQD6ygKE6FWEzX+m2c0KVkGSKM2DIL8Ui9XSF4SC6sacJeMtmEIyNgxbjqQ3LObr0UueYSKVcxKYslgBJee6mymqxUb/lbRX+NFbCJ9kS0HJcXKVQr+TV8zxUIq1F/XgWXOKDJLQOTKlab/yCRa/v+Q0L1A54iYvkiB1N8w6ZfOjRCuMqSf1Lma4fT+aOUD+u8e4o2+/Xx2CJBVp+iniEWeCuQMDjOKBaqcnTRNRl1ZxnwUQfzUA+IRZ+sTiDV9WnCFzCUO5VwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlOhLhZ0VXkKjJ5+A/yMoJFv4as5cqwOF4R1jegQHQU=;
 b=Q1tUUM3Nk9v1EjsHaYA8+NeXLuTZaNhQKQgIkP6ps6Wl+VDpA9LVIqn0TeJzXdoYTiQK09VFfOnjecVd+awqQFv56eHFdVonRV96tvvLt4tk+FEY3LmOmfD7LGYMSdIsXcJJqIgEdBCXKWixdKDazkowmFzhLWyvDXMdHoRaCiE=
Received: from MW4PR04CA0091.namprd04.prod.outlook.com (2603:10b6:303:83::6)
 by CH2PR12MB3877.namprd12.prod.outlook.com (2603:10b6:610:27::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 11:40:17 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::51) by MW4PR04CA0091.outlook.office365.com
 (2603:10b6:303:83::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Thu, 7 Oct 2021 11:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 11:40:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 7 Oct 2021 06:40:13 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <andrey.grodzovsky@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm for consistency when accessing
 drm_device
Date: Thu, 7 Oct 2021 19:40:01 +0800
Message-ID: <20211007114001.12123-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5023783-bf23-42b2-fcd8-08d989873c25
X-MS-TrafficTypeDiagnostic: CH2PR12MB3877:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38778BF0547A8FF53AF4F73CF1B19@CH2PR12MB3877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6edePHL0qMlJnyv0/KIUzEjm1h5v0tSYmU/C0ADOXA5UZ0Vu19bT6baRR2irRZcMZRUpuknlAjkrVP8DIZfqxPha72OJeDKOSWsUG+G0eS/efNj7pdVg9+FBADhO8njwQdn9uN7FdfKg+3i8oR8HlNZ9IZ0Z/MpnuNzE0zaRGeQc00/AXFqgWi/TkOSw5uVp4gapb3ZN6Yt6vN1CIGx3vg4cEqT0OPgP2LZomanZ4V3iYkJfSYYq+qW/azq7s7KNUir4ApmoP/rYDOIiB5a9NSrOOBqu7ul1TXX4eawRMdhbPHMOATAycrMIargzGoqMKG4xllnz5dOb8MW4pNyGY4H1JQORi8MBrqO7KFS6Lzs8OGqf3XQicNa6EmfF4imJpn9MygTjiJmESnqOu/q9uuzHdP3L/cpe1QsQMAkMzlsHrXhm/B9ZJBpb8A8IDaTHjG1yLEjGYVgH7xWTB3gwaE3Zxjx+3/nwqgav5a+oR/00B1POTdLSWUjIOI5Y0mJXnoVLNyGgiRlA18QrFUAPKg7GA+RBM6LS5SM/7KikFugOF1TfHYfi1bEuF/ycHHrjB34k5WEhN8WFoC5xjCh8bwZoudOAM4WmYdxqeBZ8Ato1hu9Uo4vHC4SpjkQ6FzmQCzV3kX//cCTk0/MFMUc0Iyor54eqwuLEeyTbLemrGc09zUHNJYq7M7jR3ReA7ZK3Avm25oxU6tVYuWF7mF/daxnsf112ebJ3hPkqxb8LP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(336012)(4326008)(186003)(16526019)(316002)(82310400003)(70206006)(70586007)(508600001)(426003)(36756003)(1076003)(6666004)(7696005)(2616005)(30864003)(8676002)(8936002)(2906002)(110136005)(86362001)(356005)(36860700001)(47076005)(83380400001)(81166007)(6636002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 11:40:17.0709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5023783-bf23-42b2-fcd8-08d989873c25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3877
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

adev_to_drm is used everywhere, so improve recent changes
when accessing drm_device pointer from amdgpu_device.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      | 2 +-
 16 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57638fe9cfc2..37f6c3a43541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -306,7 +306,7 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
 	uint64_t last;
 	int idx;
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
 	BUG_ON(!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd4ba076ff8a..1320f84c63cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -556,7 +556,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			drm_sched_stop(&ring->sched, NULL);
 
 		/* You can't wait for HW to signal if it's gone */
-		if (!drm_dev_is_unplugged(&adev->ddev))
+		if (!drm_dev_is_unplugged(adev_to_drm(adev)))
 			r = amdgpu_fence_wait_empty(ring);
 		else
 			r = -ENODEV;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index d7e4f4660acf..d3e4203f6217 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -238,7 +238,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 		return -EINVAL;
 	}
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return 0;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
@@ -289,7 +289,7 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		return -EINVAL;
 	}
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return 0;
 
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8d2716297070..45761d0328c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -748,7 +748,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 	int idx;
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index e1aa4a5e6a98..054d6210be7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -368,7 +368,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
 {
 	if (adev->irq.installed) {
-		drm_irq_uninstall(&adev->ddev);
+		drm_irq_uninstall(adev_to_drm(adev));
 		adev->irq.installed = false;
 		if (adev->irq.msi_enabled)
 			pci_free_irq_vectors(adev->pdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index de29518673dd..f222ec17a523 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -38,7 +38,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
 
-	if (!drm_dev_enter(&adev->ddev, &idx)) {
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		DRM_INFO("%s - device unplugged skipping recovery on scheduler:%s",
 			 __func__, s_job->sched->name);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fd6e38ad493c..6b39e6c02dd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -440,7 +440,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(&psp->adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
 		return 0;
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
@@ -3272,7 +3272,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 {
 	int idx;
 
-	if (!drm_dev_enter(&psp->adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
 		return;
 
 	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 8a26459bd80b..6f8de11a17f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -454,7 +454,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 		if (!adev->uvd.inst[j].saved_bo)
 			return -ENOMEM;
 
-		if (drm_dev_enter(&adev->ddev, &idx)) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
 			if (in_ras_intr)
 				memset(adev->uvd.inst[j].saved_bo, 0, size);
@@ -487,7 +487,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 		ptr = adev->uvd.inst[i].cpu_addr;
 
 		if (adev->uvd.inst[i].saved_bo != NULL) {
-			if (drm_dev_enter(&adev->ddev, &idx)) {
+			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
 				drm_dev_exit(idx);
 			}
@@ -500,7 +500,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(&adev->ddev, &idx)) {
+				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 					memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
 					drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index caa4d3420e00..688bef1649b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -313,7 +313,7 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
 	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
 			    adev->vce.fw->size - offset);
 		drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4d3f2386ef53..c7d316850570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -325,7 +325,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 		if (!adev->vcn.inst[i].saved_bo)
 			return -ENOMEM;
 
-		if (drm_dev_enter(&adev->ddev, &idx)) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
 			drm_dev_exit(idx);
 		}
@@ -349,7 +349,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 		ptr = adev->vcn.inst[i].cpu_addr;
 
 		if (adev->vcn.inst[i].saved_bo != NULL) {
-			if (drm_dev_enter(&adev->ddev, &idx)) {
+			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 				memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
 				drm_dev_exit(idx);
 			}
@@ -362,7 +362,7 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
-				if (drm_dev_enter(&adev->ddev, &idx)) {
+				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 					memcpy_toio(adev->vcn.inst[i].cpu_addr, adev->vcn.fw->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
 					drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a1ddf74bbdba..0e7dc23f78e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -845,7 +845,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			return r;
 	}
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
 	r = vm->update_funcs->map_table(vmbo);
@@ -1395,7 +1395,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (list_empty(&vm->relocated))
 		return 0;
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
 	memset(&params, 0, sizeof(params));
@@ -1718,7 +1718,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
 
-	if (!drm_dev_enter(&adev->ddev, &idx))
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
 	memset(&params, 0, sizeof(params));
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index aaf200ec982b..21a325ea49cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -698,7 +698,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			return -ENOMEM;
 		}
 
-		if (drm_dev_enter(&adev->ddev, &idx)) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 226b79254db8..d1fc4e0b8265 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -565,7 +565,7 @@ static int vce_v4_0_suspend(void *handle)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
 			void *ptr = adev->vce.cpu_addr;
@@ -615,7 +615,7 @@ static int vce_v4_0_resume(void *handle)
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 
-		if (drm_dev_enter(&adev->ddev, &idx)) {
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
 			void *ptr = adev->vce.cpu_addr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 43f46ab07dda..091d8c0f6801 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -198,7 +198,7 @@ static int vcn_v2_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f4a7a30ecebd..59f469bab005 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -240,7 +240,7 @@ static int vcn_v2_5_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 135a9c553af8..dbfd92984655 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -263,7 +263,7 @@ static int vcn_v3_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i, r, idx;
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 			volatile struct amdgpu_fw_shared *fw_shared;
 
-- 
2.17.1

