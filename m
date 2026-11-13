Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626A606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iSBXxyRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4099112673;
	Fri, 13 Nov 2026 15:50:34 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55093112640
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnLauo3i84RIhYtR45nBPp5lGp6dLTouCoSruTv/e3BBiX5DMbr5g7VzNfhdqeGvHK6l/sqOaDt6fLCiHUPHXepF39S1VZ2GKQ9KpNjZWNlyDVAYUZKY7SCkZj0i1GNsqjvP9h/jAHYTM2YkmVSSuJ2+KynKLW8/WOnjaKoH6PACriWWO1clOsLUbzYxYN9BuJm0G/qUaXgcVQ/4St7+f34l4OfJ8UQemnTY3LwTjdGmIUkJrTUNDTz3mbpmE2rEP+mMQ4Y4K0n1btsWCdCKIn7mNPOCk3cjKe7OdMNCtnRixxBFojiBbzKh2/D3geGxZ45EZkTWlIqsnte8Z6CoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff3fF0+QM5yQfCnruv7WkclLj0s7zgx+kb8HRLYAgPQ=;
 b=dOCQPaISQRf4WWcn67u1axbwWTZ9KXett2+WBn+aivABTfBG0f1wG5rkNZQRlCVZ0RwBsWCyLq9xi7KGrkTPb5PmEwqKFyvAbv1l5vd2/kZiN1DaMPIb85umWmXDgdkIyP/tOwsJeDBlMNTOoAn0xadvZD7KJnEOmSrBL249e2/vjzrBV4CP6XyCm9butESag85m2qUiRJVX7Ny0Xkf1hUrENjE9He+IclSEQdmYB2iKyM3NZWR4y8ClUk3HRUkhOvRSk4KYFZkdVmXG3cyc5XUxABus3LkVnmRb69Ze5lENSpywuUaUvcND43aXG1YfmjrH/xSSw8tLbSzITNTadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff3fF0+QM5yQfCnruv7WkclLj0s7zgx+kb8HRLYAgPQ=;
 b=iSBXxyRUQj8Jkd6W2JX4Fj3P82zFguj4/l6IWuqXzzOxOzR9A6WvNVSFAypgAGVUm8CNg1aQ8BDYzdLPu9uo1FRV0gzj2Fo1tP72CbND3IiCOGIgWZukDQzc8QqcMIY0IfOrW0ID84Hxqu3BhGSOuQ+mWaOTJI1grfu2xbSLV3w=
Received: from CY5PR19CA0022.namprd19.prod.outlook.com (2603:10b6:930:15::33)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 15:50:14 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:930:15:cafe::85) by CY5PR19CA0022.outlook.office365.com
 (2603:10b6:930:15::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 15:50:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:50:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:50:08 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 13 Nov 2026 09:50:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
Date: Fri, 13 Nov 2026 10:49:54 -0500
Message-ID: <20261113154954.1865439-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113154954.1865439-1-alexander.deucher@amd.com>
References: <20261113154954.1865439-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: dc70071a-419f-46b9-0bad-08df419dce9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261026140227099003|11063799006|10067099003|56012099006|261021121427099003|261022105027099003|261028144727099003|261022075727099003|261026121527099003|261021123027099003|261009223027099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rNhiya0gm8r5l4PY4qM22eQ2ri50MW9LrSuB2GvV/d8Kxlo0jioHHB9nOpBS7/otqUcJ3lF1HDx2KgXmmiRz8SyQNZtGWtM5Us8tD5xocK1uPs4jyaCK/+z7UZhHhKQf2Ix2iVBkyOB2D5sew4dSyK5b2xI8OcydhdkcJv6lB5rgnnmrAxqJ1DbbEyfndeM5w6QURE6IL/03Pd1h30n4c3PMh0wnylaSnXiI+rdypySSIFBw5MJF0nrkBQILbLdY3H6QiFHN9zrl0q8+c3Bb5cJmPt7x4bjQqv2L5DWyJzsaXxKnDjr1/D7Dgv2LtIMxhQkWwd4VpQjodL2wDd/7voue0p7GPWwYlDGcSgPq/mBatid/xMe96sADgucf5eOsKM9G+IqHn+lkomPEK3zC1/Z08jcYKPk2AAXXISehcx8fmQQmmTCwX/enVyVHp774b0+FK5iZOrBa8PZM+rJQho8r6QhhW6/QlUvKqvQ3u+XkABD7C/0iVeuAI2t1r1yaCbQG260vERKBrK0CUQudGPvOti9/HRGM6500rlHzTHCyXdY7t7zPWa/ifABdCr98etPw/jmDY5ScIBhS0L7Eym1mz4BodlKqwbyaLBxIKDMwkwWF0IYCnRQVUYxinR9z610kWAEvTVkqpuS2nBXcpjLvS3AoUV11hvmdyy7ny76fJOrYatkgg1fmQu+mm6ShFr53u4YAG74LGHh2fm5/bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261026140227099003)(11063799006)(10067099003)(56012099006)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zh4MS7GU1kr0XH1xrtSueYLxyIkWvlWmVIn845AfhI2eDzwPLhY1kiAeelySlKcaaQCwBy21YFN97VSuRGgKn21al5upf3abdYDRduAeFhUINmTZM0kGzymmE3DedUUOsPQ2V0Istup7JKmYQ8QX4LobjTiB85fsY3iUeKokN6M8LFd5mvkUy+XZCKQ4een46iOQpHkH4+I3Tqizw16lrNXEV11rxktSN8+66VDpCFEZ3UzoNjs88jR+1ENhp1yp+WyfR83yHhG+5/43HsxMmWJm7lK3zkRsEbfkFZLL6MpslQIZhnBhXW6BN7UoXoLzaIbMsyGCh2F4HjRlqsanb8vDWWwJE99oU2x0dUQw8Y3heQMQ386qGHVFIamjWaFvFA2I3VxeKJCtolNvbjWNIfIsy4dIMQxvEp127y2DVNh3q7IuChYrox/JhhPJ3Wa6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:50:14.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc70071a-419f-46b9-0bad-08df419dce9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: 2fb5a4572c76 ("drm/amdgpu: remove the now-redundant runtime SPM VMID update")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 ++--
 10 files changed, 67 insertions(+), 19 deletions(-)

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
index 7683e8a0a4380..9d58af0c678c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8187,8 +8187,17 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
-{
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (ring &&
+	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
+		u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
+		u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+		amdgpu_ring_emit_wreg(ring, reg, data);
+		return;
+	}
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	gfx_v10_0_update_spm_vmid_internal(adev, vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d068a9d9c72c..fbf34c346201c 100644
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
@@ -5615,12 +5616,21 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 }
 
 static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 reg, pre_data, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+
+	if (ring &&
+	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
+		data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+		amdgpu_ring_emit_wreg(ring, reg, data);
+		return;
+	}
+
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
 		pre_data = RREG32_NO_KIQ(reg);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index df2fb09bbcd86..b01e239db195f 100644
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
@@ -3978,12 +3979,22 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
+				      struct amdgpu_ring *ring,
 				      unsigned vmid)
 {
 	u32 reg, data;
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+
+	if (ring &&
+	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
+		data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+		amdgpu_ring_emit_wreg(ring, reg, data);
+		return;
+	}
+
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f57d0fa2c044..bf69d71e6b065 100644
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
@@ -2945,7 +2945,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
 				      int xcc_id,
-				      unsigned int vmid)
+				      struct amdgpu_ring *ring,
+				      unsigned vmid)
 {
 	u32 reg, data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 72c84b61fda16..43dea0810137b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3256,7 +3256,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -3483,7 +3483,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 }
 
 static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4666aa5b38c75..360a958f7577d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1276,7 +1276,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -5484,7 +5484,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 }
 
 static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned vmid)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2e2673a6dbbf5..7d001d7e3a0d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5227,8 +5227,17 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
-{
+		struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (ring &&
+	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
+	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
+		u32 reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
+		u32 data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+		amdgpu_ring_emit_wreg(ring, reg, data);
+		return;
+	}
+
 	amdgpu_gfx_off_ctrl(adev, false);
 
 	gfx_v9_0_update_spm_vmid_internal(adev, vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index da031caa4e9e6..30c8b751849cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1397,7 +1397,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
@@ -1609,7 +1609,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-					      int inst, unsigned int vmid)
+					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
 {
 	u32 reg, pre_data, data;
 
-- 
2.56.0

