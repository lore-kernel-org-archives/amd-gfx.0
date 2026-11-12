Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC74606A32E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RfeYnZej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 585D01122FA;
	Thu, 12 Nov 2026 23:38:07 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A871122FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 23:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGLuIQb8WyLupZYkQ8eM5wV/eRGmmSj9Cpd1alNA2yLbppCRToEtuHvQStuzZ7Qr3hF5eOZCS1frsgsJQDsKim1tkKmjegvrbEJPFrl3N+9lUpA1xo4WpTK0jz/0nQ2/czpJF/XDWvpxs1zwIldBpqiPE+S3QL2ohibF07yFYWP+RI7c8jlE25XiOAkotAecisFoGGKZt7ZXTcmyRfQfDh1oM/Loxi+McPL+IiN551UCtcd/x7DpciPyWajWnZ65kDGq2aAPUQ/p0jsV12ZJLwpyxnYEMHhn1ODAdjsHa7M+pQ8GumKZDh+1hxpGpiEKF/cYKDKp6vwjg75d5HsrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JGzZnio/a1f97yD+VLVIpaBTVuayNsiuoRT/5waJ3s=;
 b=Yoma6GbXvDvl6bRqOXFBQ/JwTaSoJNABgjnaB9NY06kEm1n4Sirbqa2yT63bGJfU8rwfgrK8z0O00k5lTM1tEY807EUQT3S15tRUxbFLPhXqqPtWzoKGWW6DUEslCupAPDSYZ1BDpyEvsIasyzwtBaXIS2KHr2ugyO1RGmSLp8sH3dmC9k/6PwgdpuQAD9x/I3+sPmCqLRkVTGRKXYG0gcpMgb4yHny7c/1Km3HxHtfq/5JSddQY5bbkk64TT6SsVENwtIz00VoTrYvJmmoFfEBL+lSblPuFImobNJNoK9EolRcERVqpcXfhhtc+LHIXGVNQI/E/AtaS87I3wrTaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JGzZnio/a1f97yD+VLVIpaBTVuayNsiuoRT/5waJ3s=;
 b=RfeYnZejtDRzUu4hHL/0bRq4Ph+9F0vO9EuqOMVvEqblzDqJoy8fEKzbzJYxkd6P+Kh9TRJ4Utkhpg5CPwHFMe8pc3u0DeOb6ZEAFz4SogxlNhDsoJkAIgnOo7SJByPYP42cFdC0e9wKUQRGlMMdKIcPQ/BTw7AGpW8GNQRax9c=
Received: from BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 23:37:53 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8b) by BL1P222CA0015.outlook.office365.com
 (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Thu,
 12 Nov 2026 23:37:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 23:37:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:48:09 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 15:48:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
Date: Thu, 12 Nov 2026 16:48:02 -0500
Message-ID: <20261112214802.1774412-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 945fedcd-a4b9-4735-8c82-08df4115f750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: yB10qbGe66r4nk5Z5Br7VuGSgNqtt2TiJesX9/7KTmzq23q5bG7ILKWWXG9HhDVRdfBewg2vb3nnCEQcy+jCd0enq9fCG2TU/LjDxX0+y9sbtrwxd7DqKMeCZ4aI/KiKG1mVFw+Y/CoyVBZGVJ+Lfe3+msp65mkJ/svubQqWkIkh3tH3PDN1ThpsDQhxEFmMCwStdEhiiDs3yvPN+F6QrUeYkB5WwC+3B8PhCN4zYr105fEMsC64XXH0omb7mBRsngXnew32XESZ99myZJwvnX3DRKwj7GP6wU3gG3xQSi12s66T1eUEgVsQzHr8Bs5jXKbda23cg8o6KXfUVDO6KPA0ESV7DhCJbhCqB1FmgMy+pIKyRheolUjfF0DnPNxRtuh1wvd1hVlIlaaMwI6jyJeC4KfRzM67d8DFwPiTLLiJNmb2Z+DJu/MrV0kUT1KAS8Khp/e9GykAnl4bknrEQYRx7IKdjYvMnCNAZLxTHcmFn67HQPG7o/gWNI/jfopUdKC+JMxydLAQB2ybmCgxxON6m2h3aAHToTfjWEB1gRZ/tdmdtO335hVQB9jzrFFw8xvCKochAaR0xW2RPF+GDBH9sMc5XwxgjwEyAXeT3WiZnNdYqbGnAgXV050X1wmNVXWAd25gMJWTIqj5v1d+nAX0svl2714EKTsMXtguy/jjnghRoWCxkcUFdFJxrnbYKLmG2jBoYm7VNJSUXc9yYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DgVbNs657ozz7EhyqaymB8/JQ8ECq1IXmW0JnA2a+66yqEZsYURMfufElizhU8xepFiyrQemnS/eXYOc0H6/awkZmbMp3gXE61TKvzIhatuG6I24sfGkMPATaogGF9E1UGNtRPmZBH8uW520aMcp+jQ6TcrHgk1iglPcsqHTxzDgsARvGyWa+ECr+BxX+a0SzkrRixL15uRfQhlLu/dBeY2dVoiUTyVAGHOdsgoryW2Yv9GnIDOH+J5RHitSaDPaaVOLslCf0SybR1pfoTk7Wo1tAC/rABgJ1pu9P43aVElTJYsZFdkF8wS+ZxLDFspKU5ABAXmDkdbDjKpOwcmNt1fXjJdoDz9lqpcUNXkC51JcizxUSZZp5OLqhQFARyuf/p+DiNQAT02b1iVR50rQ2RONrtlm2QL/gyUNPXNw2e7Nca/n+X/jALgi2ceGyh2i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 23:37:50.7910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945fedcd-a4b9-4735-8c82-08df4115f750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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

This largely reverts commit 90b1b26bb030d6c666f8cad52cd3d8019d404ad9.

Not emitting the spm update via the ring causes CI flakeyness on
gfx11.  Add back the SPM ring emission, but skip the MMIO path
if ring is specified.

v2: drop ring code in gfx 12.1.  We aren't supporting KCQs on 12.1
so the code is not used.

Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB path")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  4 ++--
 11 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 324d25c77897a..1ff5d5cfb141d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -750,7 +750,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	if (emit_spm_needed)
-		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id,
+		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id, NULL,
 							   ring->adev->vm_manager.spm_vmid);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6210edf1937aa..a24cdf5852a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -213,7 +213,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (emit_spm_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
 						     adev->vm_manager.spm_vmid);
 
 	if (emit_gds_needed)
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
index 7683e8a0a4380..f226758b15467 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8187,7 +8187,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d068a9d9c72c..ac814c12d60f2 100644
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
+	if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
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
index df2fb09bbcd86..07f981f27bcc8 100644
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
+	if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
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
index 2e2673a6dbbf5..0b01801b0571b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5227,7 +5227,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 }
 
 static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
-		unsigned int vmid)
+		struct amdgpu_ring *ring, unsigned int vmid)
 {
 	amdgpu_gfx_off_ctrl(adev, false);
 
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

