Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA34606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cA5RDEKD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF30211236F;
	Thu, 12 Nov 2026 22:06:23 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0123211236F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrsJBOAQGNNDVz2GZ6Yf6AQ/DzDdJjBuVLAyDhvUCmedwmEUrhERfnLPvdQwUdhMslMXiM0l+e4MijriN80sRVbCdLhbCbGtCPShsKwvKB8cRrbB2XL7LJ0g71MlgUfo/3lr9ks36ndFTFuTweXV0XsMo2xq0vvNzkt9qfxFfhbhMo/JSxnh+HwKbkNTWQtTAcJfnOPRIkSpCjjLgt8B2dbjLpLYhINDjyjg6c7HR7zPzgW8HJ0tW3X8h7QlXCi7k9XH1ykHJANplzSfP/9U8D5vav1ylTC43jwF2ILEh9aF9fSlA43qZ41Mjs+UC/I1zAQE4AoFJAB71uz1o9+KXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUcH9akRH7Ak6qffJsKpgQvd5XUncmAQXMDsozV0JxE=;
 b=HoHDl43S+uY6dYg3iHf395ckzrQJcPafaxEQp7ceHmw6QPFehr5KgjJZrwpawntJUQpkeZbJK7VrJstT176PcvgHu9LGZz+E6SOmxIPsAW+b1K+Gc16rVuqwahT+SaQup3MQeEBs38GgfNx2NgKjk3pAcwK89GRAeJMeQWgmBNG64mmGq/PMBkPN7Wt7hge7ZOnDmeod41XfugIirGmjsAnaiBNkQDcEgrfvNqeX/OsNyu/Y3uIutmxdMAd8W5oP6NHq/wzcXrfBQCtRWxagog03JwzyLoV4mtyrGkGLlDXLtwnYJP2k2DYxmCMZ1wKv6PcFOtKS7rLy1rNsvodfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUcH9akRH7Ak6qffJsKpgQvd5XUncmAQXMDsozV0JxE=;
 b=cA5RDEKDyVdZ9TATqqeF6iSqRFQX6GIk2LvYB781rPSHdbY7ZkNOkpDxyxyvv091Y2yl122/zp9FXq9kCfaPCgpkgOdrLfXViw8qBG/2hzmgVj1KxLaeszT4bwUVKbhTjx/UT7xaapk5ya7JyLdmYH9muxepmK7L05yQxtfIvJ8=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH3PEPF0000409C.namprd05.prod.outlook.com (2603:10b6:518:1::48)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 22:03:48 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH3PEPF0000409C.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 22:02:10 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 22:02:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:24:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 15:24:32 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 15:24:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
Date: Thu, 12 Nov 2026 16:24:17 -0500
Message-ID: <20261112212417.1769071-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5e2108-208b-45db-68f4-08df41089854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|6133799003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: WIW9tW9095aP98m5APT4Gp9d6WXvTrKEX1YtG+BVp3dy0tuSa8C/8AcdFvEsxS91xk8hQpRtNtWfCVrn8TzkTHcJ031/+YTQHng5+54ABEKKrez2qg8QhdTYtPA+bAGGVRtTQpAyS9imyLBRdhwTjeTrM8WRPJW0ioGiTuc1Zhwcp2LvwzIbMHSp0NIeOejBfm3R2dzn+2PSw9BCNvY0VamLLVDzlwhb1eS1NJgZ1ztJf26/mIqgNWIEY+Fx69/UxeJn3zsraq9H/fzanx5QoI0a9N7vgLe/tpjmVhxK+r99mjXmCpoENwJiTw5kc0mVS0PiyPffxln8lQRqCjKDMhXw4yi9M1NETrgLRDTwCQkzM7LXhHome6PjwiqJvK+OSK0Pya7q6yNPzTsfoPFrgJKLpU8WGRjcZGJvcx8a7/BVEtJXmbv6vh7TmupXjyTY24z702nxSbtmzxCyErRVrP1VPfvjbQil4lnHFjZquGnfzKutUD/w17eWbNijtTzFlGudXeRODv2pf9l4n3xlJZGerFJF2HiejFe5yUaUBJeCoMa5PHq9R88PYM3AunXHSbC2TwAdkr1fBNxi8ifqzezp+/YADawoqSkImxxAxSOW6FssvTAdTq+ITs0nq4MDOePk1Q2UwqVGqKx/Uyu582Pgwcjfl7PTY7etttvMp6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(6133799003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B1G3xdrQFoAprLZVrrTqCPRxy1T2LDiccOMwxh4ps8/bdV48vSnhOS+AZr3qohvNBOgMVTrts6BzhWRlMZVLP5nezS7O8GMYBZpXxDXNmV1Csko9PkeK+m/JmZSiyHjEKAz0hjNf4wG+y1m4dhz8ApCpGDlGWUhAx91d2lC1UPCwdiU3A4xZjYl2kxEm/yxuicCooGpxz/tRNKt/HEBTSEQ63FJcmUGTAjIroEgYz3IR0HIHiCXlxGYij8MmejAmNj0TTMoAqJl5b0t2moJCpaPxX6g7ru5N0prB+OMaIowdwsSX2nm0pFDF+exnynbqbaUu2STRvIHwd/xMZfZBT/tahSKvyEW+5iXgZJ+yVspypKqPBB7C/mxFGWoSo8LPYOPN40rqh1PaPjKrifV7jxi353DFFqIaiC4ZEzicXU7AxBKkFKQFTGIuA8pXDPY3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 22:02:08.0375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5e2108-208b-45db-68f4-08df41089854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  4 ++--
 11 files changed, 49 insertions(+), 19 deletions(-)

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
index 1f57d0fa2c044..2bbe83d98563a 100644
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
 
@@ -2962,6 +2963,14 @@ static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
 		WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
+
+	if (ring
+	    && amdgpu_sriov_is_pp_one_vf(adev)
+	    && ((ring->funcs->type == AMDGPU_RING_TYPE_GFX)
+		|| (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
+		uint32_t reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
+		amdgpu_ring_emit_wreg(ring, reg, data);
+	}
 }
 
 static const struct amdgpu_rlc_funcs gfx_v12_1_rlc_funcs = {
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

