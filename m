Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FAFCDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 08:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C83B10E33E;
	Fri, 26 Jun 2026 08:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="R4hgFkZS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6512710E34A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xoJdTBQZdVm4a0YefFfdbw8z7s5cLiJiMTkW4rq8BHE=; b=R4hgFkZSShl9EKF8PlByk3QTzO
 FhdNbWPdup2ZJWpaEOtNBf06ZCMslEDR/2cGfxnsO7ybKNfwhfi8tC0YUDy5mbsY+JZm75OMagKBy
 s2jHFuBpltDHIZnFLeIylGdaYO6pXZ3/V7aDkl+6jP3tqVWL3RlCQGhvP1E1dxRyShhODgySJ25vC
 O5Uf3qaq1ZIf6r2F6E+iQ2xo7IgkLGSEKIV74MGpJFzWo8QA/WQPd1218OTfynf/jAI6DmOdpftRp
 Onrx64/HU2RVi5g93xvgcGmgqhVlVa+Jem8j8Zh5B+hv/VPG5cXycoSHkycXXdD9qYtRC2OgVojFc
 KqV+lTXw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wd2M0-005Pwm-Fy; Fri, 26 Jun 2026 10:56:04 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu: Save some cycles on the job submission path
Date: Fri, 26 Jun 2026 09:55:57 +0100
Message-ID: <20260626085558.97923-3-tvrtko.ursulin@igalia.com>
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

Every job submission on the Steam Deck ends up walking the list of IP
blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is like
the below, while the second half is from amdgpu_gfx_profile_ring_end_use:

 amdgpu_gfx_profile_ring_begin_use
  amdgpu_dpm_is_overdrive_enabled
   is_support_sw_smu
    amdgpu_device_ip_is_valid

On a game menu screen at 90Hz refresh rate we end up with ~840 calls per
second which sticks out when the submission worker is profiled with perf:

  13.78%  [kernel]  [k] __lock_text_start
  10.86%  [kernel]  [k] __lookup_object
   8.76%  [kernel]  [k] __mod_timer
   4.94%  [kernel]  [k] queued_spin_lock_slowpath
   1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
   1.54%  [kernel]  [k] preempt_count_add
   1.42%  [kernel]  [k] amdgpu_sync_peek_fence
   1.18%  [kernel]  [k] amdgpu_vmid_grab
   1.17%  [kernel]  [k] amdgpu_ib_schedule
   1.14%  [kernel]  [k] kthread_worker_fn

Lets short-circuit this walk by simply caching the result of
is_support_sw_smu() in the device.

This is a micro-improvement but it is at least conceptually nicer to avoid
repeating the same walk so much.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
---
v2:
 * Approach changed to cache sw_smu status only.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++---------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b09410d6d8f..9803967d15f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -851,6 +851,7 @@ struct amdgpu_device {
 	struct dev_pm_domain		vga_pm_domain;
 	bool				have_disp_power_ref;
 	bool                            have_atomics_support;
+	bool				is_sw_smu;
 
 	/* BIOS */
 	bool				is_atom_fw;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e6b75ecafe4..7f935a5778b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -74,6 +74,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_ras_mgr.h"
 #include "amdgpu_pmu.h"
+#include "amdgpu_smu.h"
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
@@ -2130,6 +2131,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	adev->cg_flags &= amdgpu_cg_mask;
 	adev->pg_flags &= amdgpu_pg_mask;
 
+	amdgpu_smu_early_init(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 208a2fba6d40..82c9ae6a5092 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -591,17 +591,13 @@ static int smu_get_power_num_states(void *handle,
 	return 0;
 }
 
-bool is_support_sw_smu(struct amdgpu_device *adev)
+void amdgpu_smu_early_init(struct amdgpu_device *adev)
 {
 	/* vega20 is 11.0.2, but it's supported via the powerplay code */
-	if (adev->asic_type == CHIP_VEGA20)
-		return false;
-
-	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(11, 0, 0)) &&
-	    amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
-		return true;
-
-	return false;
+	adev->is_sw_smu = adev->asic_type != CHIP_VEGA20 &&
+			  (amdgpu_ip_version(adev, MP1_HWIP, 0) >=
+			   IP_VERSION(11, 0, 0) &&
+			   amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC));
 }
 
 bool is_support_cclk_dpm(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d76e0b005308..efc52d97058b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1952,7 +1952,13 @@ int smu_link_reset(struct smu_context *smu);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
 
-bool is_support_sw_smu(struct amdgpu_device *adev);
+void amdgpu_smu_early_init(struct amdgpu_device *adev);
+
+static inline bool is_support_sw_smu(struct amdgpu_device *adev)
+{
+	return adev->is_sw_smu;
+}
+
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_write_watermarks_table(struct smu_context *smu);
 
-- 
2.54.0

