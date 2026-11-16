Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B7606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T/EIYXXV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE7710F312;
	Mon, 16 Nov 2026 17:00:48 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242E510F312
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 17:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrwr1AIVl8e728e/kneRdxAPq2gXEgLiGiREpeyihKgngIVa51/tmb1gsujYN0EUjIF4C3aAHYKlJecfSDfrcRoJqQ+KJwg5gyObOXf4uKjepE+FwalSKG/Wj+1mz3Wv/JdbRzHQNy2NzE9/jRE4dWon7k9fyW7pg0thO4k9ocG8AkNo3Nv1ZcGci4z3oYbZB8tmKSpEzB2/HIUQz3PbqwVVWN52yhB4qt6mxEf/2oRKnnmDHGT/TwsNJgkcWl4ZZipuLYnQaeiWbnJeqe2RJl9/lwr+h7n0TtXHnA6pDDkKDrl/dD2LIho01l1scU7CpK0MVTPT3b8JQQKk0dR3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMLWR9dLWg7jmB7NRbEQeb1AFWoFzMdwI0ws3iuEwP4=;
 b=WC/bLfXgSxKvk4oqRn3uU7jo8s//xEdnrtU4vXKuhafI4yCCLOau6ndVqBAzL2CekHB0jB0czF9C3ZkwIOc1dsIP8sPxSM1YVohrWX7U6JOdztkKMFKSP1BgbiP8rVJiCk3zVtvNYZjeaHSUXTwpZ0qi8CEJ4Xtds+JDs8dx7AzSulcvvKgVr01xNWed1ABmTVFnAq/9LbBHfcTEWRt+qNlYZswG2k3YYpj0vfPttQAGTcXZ2WOlxrLWffc2LX053BpVEEtJrA8vWkv/KZjBFwLu8iR+PKmSmnEPqaXCs5/OHdLRDC3xPcAhzFc3KqEw+2RyIxo3rm38GRzgDX5XiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMLWR9dLWg7jmB7NRbEQeb1AFWoFzMdwI0ws3iuEwP4=;
 b=T/EIYXXVKy+PH+75vDdshKIaRKwIN56gu0K81bi+4onvUqo5WJeWFAhwY4WrEKNPW+t2oJrT9T6ioEUW3yUwNEfLWX8iLpuAYGwIKn+2mZpMLLOTfk7j7VqQCZnup33IqgRb8nN4PM5c1wkwHSv5vkKSQGIOL8xWSV+JxDo3L9k=
Received: from PH7P220CA0132.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::24)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 16:57:32 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::9) by PH7P220CA0132.outlook.office365.com
 (2603:10b6:510:327::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:57:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:57:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 10:57:29 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 10:57:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
Date: Mon, 16 Nov 2026 11:57:13 -0500
Message-ID: <20261116165713.1945549-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116165713.1945549-1-alexander.deucher@amd.com>
References: <20261116165713.1945549-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: d895c757-f25e-40df-74dd-08df4402b4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: H/n8BmROHN+FPY/uXlwqyI18q9MkTXVTaJnq54dY1CBHtjAK/qsBfeZiBWHCe8Y1YyYpMnRx35cmENIlT+A8Xr+ETmWxxtphwN1yJ1JfepxgD9N4rHFXa/5QXhJBxTJnIhob6Ef1NAzaneYnUgCr1K/Qf6UPX0xNGXjWSMXQ+7DWscKOenpM4txR8a72pKR8blQfHxezG7mg2LJhSygVPtSKMx8tq0GYVFmXRkMABpnznBFXVRl9qW58h4B/e8KpHjZeAsjeyUzOPqTmSiHCTQjBUMefS2NR5dCfpCWXRU1ZN3Ycivkzjn3PmmSVL7DOZ5FV3nJ8mI1r5X6PwosOR7vOUFCoULAdMIMWiq/TyDWFv9NCfCpmA/NvcQIi7iZYQY+G4NSVJSHMICUvogwsdfxwIlLESZH1Z9rjT5t9m0EkXkJyr+/bbyX6x/z/c1kfZRKS5RK9POEbDBlqh6LNSHIzRVJPr9jlRGnGFno41BOTNN3C6fpsB3eGcVrBY08ugM4gcFIt2AKhcGO3kg9dCx3oz6OvYiBT3DPcg9RTGqktaUQjUtxo2zFjv2j2OT6wV1DPXThl52XwhyLzrd6pTZA02sTxXdNi4NbRmL++eEfqKcWlYa3cV9LmAlhYduN/swP9YSNsIP6f5QUuT++0yyLyKVn0Hs4qOZam+ocFP45q3N/aUEzcWmaDWDCHppPhAw/T3qldlB1i31hLKRUrmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: URLDx0kJVOYQOvCe3vZ1k8CBEDLbdRim58OL03cadiVQmdQTsUz8L4MGfr2JPguqim5MEokEMlAAoy8nSf9bHga8TZb7bxgvwruJw1TODZzw0bCY9+zym4i8FM2Gz7qSzzJhVRXIEgzSN8iP+nsq5mDF/f7QZMD+sAQ7fmEDJauChsN9bkUYigXxtwTJzd4btzKKQVNuJx+jlnHD2QLOwpdSgUsNpYOY4gQUwqkQsGcPkFwYigI3bjSqG9E1ZLe9KHbjpM5nLZXYKovmO2r2vTyfEkoBENcs/C9//5RprWCPtvKutN1+QdDwfyduB5n86/t206/F8oaqsS+9O2U1LYkHrgsfCRm7fbTiX87j4g2cMu/p/D3RW8sCF9i6uwTgFMyTJn9+BQDQAnH/nUJ86+ci8I5jMzVKDpShhy6LOpP8QfXpB5nbYZhuiTYlXbaq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:57:32.3005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d895c757-f25e-40df-74dd-08df4402b4d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not emitting the spm update via the ring causes CI flakiness on
gfx11.  Add back the SPM ring emission, but skip the MMIO path
if ring is specified.  Do this for all chips with gfxoff.

v2: drop ring code in gfx 12.1.  We aren't supporting KCQs on 12.1
so the code is not used.
v3: emit via the ring for all chips with gfxoff
v4: skip MMIO writes when ring is non-NULL, fix ib emit size

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: 2fb5a4572c76 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  7 +++++--
 10 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f98a7c6797b3c..ae028eeacaed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -121,6 +121,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool emit_spm_needed = adev->gfx.rlc.funcs &&
+		adev->gfx.rlc.funcs->update_spm_vmid &&
+		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		 ring->funcs->type == AMDGPU_RING_TYPE_GFX);
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
@@ -209,6 +213,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
+	if (emit_spm_needed)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
+						     adev->vm_manager.spm_vmid);
+
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index e38a8ea02c520..2ae2c1d0f702b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
-			unsigned int vmid);
+			struct amdgpu_ring *ring, unsigned vmid);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7683e8a0a4380..b28dd5eaf1bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8187,8 +8187,18 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
-{
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (ring) {
+		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+			u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
+			u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+			amdgpu_ring_emit_wreg(ring, reg, data);
+		}
+		return;
+	}
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	gfx_v10_0_update_spm_vmid_internal(adev, vmid);
@@ -9692,6 +9702,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v10_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v10_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 + /* update_spm_vmid */
 		5 + /* COND_EXEC */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
@@ -9749,6 +9760,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* update_spm_vmid */
 		20 + /* gfx_v10_0_ring_emit_gds_switch */
 		7 + /* gfx_v10_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d068a9d9c72c..c0e74e12cd15d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+				      struct amdgpu_ring *ring,
 				      unsigned int vmid);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
@@ -2606,7 +2607,7 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_device *adev)
 	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
 	 * once it runs, also after a GPU reset or a resume.
 	 */
-	gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+	gfx_v11_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -5615,12 +5616,22 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 }
 
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 reg, pre_data, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+
+	if (ring) {
+	    if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+		(ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+		    data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+		    amdgpu_ring_emit_wreg(ring, reg, data);
+	    }
+	    return;
+	}
+
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df2fb09bbcd86..0c212b9a56398 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -287,6 +287,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+				      struct amdgpu_ring *ring,
 				      unsigned int vmid);
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
@@ -2158,7 +2159,7 @@ static int gfx_v12_0_rlc_resume(struct amdgpu_device *adev)
 	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
 	 * once it runs, also after a GPU reset or a resume.
 	 */
-	gfx_v12_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+	gfx_v12_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -3978,12 +3979,23 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
+				      struct amdgpu_ring *ring,
 				      unsigned vmid)
 {
 	u32 reg, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+
+	if (ring) {
+		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+			data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+			amdgpu_ring_emit_wreg(ring, reg, data);
+		}
+		return;
+	}
+
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
@@ -5322,6 +5334,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v12_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v12_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 + /* update_spm_vmid */
 		5 + /* COND_EXEC */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
@@ -5369,6 +5382,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.get_wptr = gfx_v12_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v12_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* update_spm_vmid */
 		7 + /* gfx_v12_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
 		7 + /* gfx_v12_0_ring_emit_pipeline_sync */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c044..227942e87cc8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -217,7 +217,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
 static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-				      unsigned int vmid);
+				      struct amdgpu_ring *ring, unsigned vmid);
 
 static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				   int mem_space, int opt, uint32_t addr0,
@@ -1866,7 +1866,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 	int r;
 
 	/* init spm vmid with 0xf */
-	gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
+	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		gfx_v12_1_xcc_init_csb(adev, xcc_id);
@@ -2945,10 +2945,14 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
-				      unsigned int vmid)
+				      struct amdgpu_ring *ring,
+				      unsigned vmid)
 {
 	u32 reg, data;
 
+	if (ring)
+		return;
+
 	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 58135757190c8..3c9e478d5f6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3477,16 +3477,19 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
 
 static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
+	if (ring)
+		return;
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	data = RREG32(mmRLC_SPM_VMID);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index df935827b002a..e818280139791 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4084,7 +4084,8 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
+
 	return 0;
 }
 
@@ -5483,10 +5484,13 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 }
 
 static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
+	if (ring)
+		return;
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	if (amdgpu_sriov_is_pp_one_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2e2673a6dbbf5..be45c10b6f579 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5227,8 +5227,18 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
-{
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (ring) {
+		if ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+		    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+			u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
+			u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+			amdgpu_ring_emit_wreg(ring, reg, data);
+		}
+		return;
+	}
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	gfx_v9_0_update_spm_vmid_internal(adev, vmid);
@@ -7548,6 +7558,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.get_wptr = gfx_v9_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 + /* update_spm_vmid */
 		5 +  /* COND_EXEC */
 		13 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
@@ -7604,6 +7615,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 + /* update_spm_vmid */
 		5 +  /* COND_EXEC */
 		13 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
@@ -7663,6 +7675,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* update_spm_vmid */
 		20 + /* gfx_v9_0_ring_emit_gds_switch */
 		7 + /* gfx_v9_0_ring_emit_hdp_flush */
 		5 + /* hdp invalidate */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 151336e6094f7..f28ffe8a5ac55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1586,7 +1586,7 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -1609,10 +1609,13 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-					      int inst, unsigned int vmid)
+					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
+	if (ring)
+		return;
+
 	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
-- 
2.56.1

