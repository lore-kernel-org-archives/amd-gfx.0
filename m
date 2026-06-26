Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F530CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 08:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6BD10E333;
	Fri, 26 Jun 2026 08:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BkQW1Bf8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3501910F3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kZKSh8ZEB9n0xi77rNhswLVtpX36HvQmo7+c1HLM+tE=; b=BkQW1Bf8A+ZhuzIkq5zMMcPigT
 AZHEYugA+mTjaXl0+/deCPa0qZx5Rvsr9OeRm6Y0T3zpEb7lutTCM0bQSNrQt8AEALR9RRSVb/Lzy
 irIxbnR8B+35BK+lXJZD2UPLGHnMGxPGCwvnvT0cSmj+X9Os5TqpWHI2Xh/iMbsewGHNst5i7eDwc
 p3SUPuXfK0tDxuO1XEMR/fn/b/nq+x/gQC6jC7fZFiP83rHMsH95aJCfLnraIiWYFd8XTrdjT67l0
 SZKkyZrpl0VtZEcDlqlVYD3qEvftGumxSLx5IGJdXbOJIR0PeAVrk3QNV+Zc03JZmGGgUwKp3Nhmj
 7p4wjsqw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wd2M1-005Pwt-8t; Fri, 26 Jun 2026 10:56:05 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu: Do not fiddle with the idle workers too much
Date: Fri, 26 Jun 2026 09:55:58 +0100
Message-ID: <20260626085558.97923-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Idle workers only need to be canceled or pushed back if we are potentially
idle. Make the both operations conditional on the pre-increment and post-
decrement status of the in-flight job counter.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 12 +++++-------
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 85372af1216d..623a5339bc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2460,9 +2460,8 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 	else
 		profile = PP_SMC_POWER_PROFILE_COMPUTE;
 
-	atomic_inc(&adev->gfx.total_submission_cnt);
-
-	cancel_delayed_work_sync(&adev->gfx.idle_work);
+	if (!atomic_fetch_inc(&adev->gfx.total_submission_cnt))
+		cancel_delayed_work_sync(&adev->gfx.idle_work);
 
 	/* We can safely return early here because we've cancelled the
 	 * the delayed work so there is no one else to set it to false
@@ -2490,9 +2489,9 @@ void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
 	if (amdgpu_dpm_is_overdrive_enabled(adev))
 		return;
 
-	atomic_dec(&ring->adev->gfx.total_submission_cnt);
-
-	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
+	if (atomic_dec_and_test(&ring->adev->gfx.total_submission_cnt))
+		schedule_delayed_work(&ring->adev->gfx.idle_work,
+				      GFX_PROFILE_IDLE_TIMEOUT);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 63ee6ba6a931..57935c321515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -134,8 +134,8 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	atomic_inc(&adev->jpeg.total_submission_cnt);
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
@@ -145,8 +145,9 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
 {
-	atomic_dec(&ring->adev->jpeg.total_submission_cnt);
-	schedule_delayed_work(&ring->adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+	if (atomic_dec_and_test(&ring->adev->jpeg.total_submission_cnt))
+		schedule_delayed_work(&ring->adev->jpeg.idle_work,
+				      JPEG_IDLE_TIMEOUT);
 }
 
 int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b261aa7c1ba8..8d2abf706dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -506,9 +506,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
-	atomic_inc(&vcn_inst->total_submission_cnt);
-
-	cancel_delayed_work_sync(&vcn_inst->idle_work);
+	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
@@ -550,10 +549,9 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 	    !adev->vcn.inst[ring->me].using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
-	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
-
-	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
-			      VCN_IDLE_TIMEOUT);
+	if (atomic_dec_and_test(&ring->adev->vcn.inst[ring->me].total_submission_cnt))
+		schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
+				      VCN_IDLE_TIMEOUT);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8b8184fe6764..0d8a3cea63ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -159,9 +159,8 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *v = &adev->vcn.inst[ring->me];
 
-	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
-
-	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
+	if (!atomic_fetch_inc(&adev->vcn.inst[0].total_submission_cnt))
+		cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	/* We can safely return early here because we've cancelled the
 	 * the delayed work so there is no one else to set it to false
@@ -207,10 +206,9 @@ static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
 	    !adev->vcn.inst[ring->me].using_unified_queue)
 		atomic_dec(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
-	atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
-
-	schedule_delayed_work(&adev->vcn.inst[0].idle_work,
-			      VCN_IDLE_TIMEOUT);
+	if (atomic_dec_and_test(&adev->vcn.inst[0].total_submission_cnt))
+		schedule_delayed_work(&adev->vcn.inst[0].idle_work,
+				      VCN_IDLE_TIMEOUT);
 }
 
 /**
-- 
2.54.0

