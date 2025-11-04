Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B647BCCFA0D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C05310E5F4;
	Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AlVj1e2a";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77C010E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A5ikB88y92GJDkzW9RPoOwE3zXFXo9O1BTWR9GLqTMw=; b=AlVj1e2aRn0OAM8dgKSwRPpUbX
 DcXaJCi4fPGqY4abJ7u5qi/dIcliqhtvqUhPGGyt6KaKi9pDcz0vjwfHwIc+u6rkjIcUxhhJk8ISS
 CGVvHM8gq8Imsul9YkfPXLMFM6sUmAcYv4EWVnBAucIiKGRt7120/Kan0Y8STHX/FOMczl8xmVnAf
 kG+FhGxBe3wOtByRM8nahxj1L8qpzyRBFA8GbGTtBHJE1r41i6yPBuI8wowQB8TRQx2YMnnS1vzL7
 QsY16FgD9rvhXDxDt2ISJN2dgKhv9zU79OeV61Dr+NqXwJJxZjqW59F1bKojJqAZGa2Yme50aFFxI
 yiY8p5Sw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg8-001OER-2y; Tue, 04 Nov 2025 15:06:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 03/25] drm/amdgpu: Choose SOC15 RLC register read write
 functions at init time
Date: Tue,  4 Nov 2025 14:03:59 +0000
Message-ID: <20251104140421.88520-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

Currently on every RLC register read the driver checks for three different
conditions to decide which of the two register read/write functions to
call.

As these register operations are macros, which is required for register
name expansion to work, the result is a significant explosion of generated
(redundant) code which the compiler cannot optimise away.

We however know that all of the three conditional are static and can
therefore move the decision to driver init time. All that we need to do is
define a new vfunc table for the SOC12 RLC read/write functions and just
use them directly.

Bloat-o-meter agrees the driver size savings are significant:

add/remove: 9/31 grow/shrink: 74/1012 up/down: 39784/-381724 (-341940)
...
Total: Before=9421643, After=9079703, chg -3.63%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  8 ++---
 9 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 654f4844b7ad..2b31a47617d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4558,6 +4558,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 
+	amdgpu_early_init_rlc_reg_funcs(adev);
 	amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 5aa830a02d80..9b5b5ecb370a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -548,3 +548,42 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static const struct amdgpu_rlc_reg_funcs amdgpu_sriov_rlc_reg_funcs = {
+	.rreg32 = amdgpu_sriov_rreg,
+	.wreg32 = amdgpu_sriov_wreg,
+};
+
+static u32
+amdgpu_rlc_rreg(struct amdgpu_device *adev, u32 reg, u32 acc_flags, u32 hwip,
+		u32 xcc_id)
+{
+	return amdgpu_device_rreg(adev, reg, 0);
+}
+
+static void
+amdgpu_rlc_wreg(struct amdgpu_device *adev, u32 reg, u32 value, u32 acc_flags,
+		u32 hwip, u32 xcc_id)
+{
+	amdgpu_device_wreg(adev, reg, value, 0);
+}
+
+static const struct amdgpu_rlc_reg_funcs amdgpu_rlc_reg_funcs = {
+	.rreg32 = amdgpu_rlc_rreg,
+	.wreg32 = amdgpu_rlc_wreg,
+};
+
+void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.rlc.reg_funcs = &amdgpu_rlc_reg_funcs;
+}
+
+void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev) &&
+	    adev->gfx.rlc.funcs &&
+	    adev->gfx.rlc.rlcg_reg_access_supported)
+		adev->gfx.rlc.reg_funcs = &amdgpu_sriov_rlc_reg_funcs;
+	else
+		adev->gfx.rlc.reg_funcs = &amdgpu_rlc_reg_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 2ce310b31942..d1a397c4577d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -261,6 +261,11 @@ struct amdgpu_rlc_funcs {
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
+struct amdgpu_rlc_reg_funcs {
+	u32  (*rreg32)(struct amdgpu_device *adev, u32 reg, u32 acc_flags, u32 hwip, u32 xcc_id);
+	void (*wreg32)(struct amdgpu_device *adev, u32 reg, u32 val, u32 acc_flags, u32 hwip, u32 xcc_id);
+};
+
 struct amdgpu_rlcg_reg_access_ctrl {
 	uint32_t scratch_reg0;
 	uint32_t scratch_reg1;
@@ -293,6 +298,7 @@ struct amdgpu_rlc {
 	/* safe mode for updating CG/PG state */
 	bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
 	const struct amdgpu_rlc_funcs *funcs;
+	const struct amdgpu_rlc_reg_funcs *reg_funcs;
 
 	/* for firmware data */
 	u32 save_and_restore_offset;
@@ -360,4 +366,8 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor);
+
+void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
+void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 751732f3e883..4999e57a11df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7827,6 +7827,8 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* init rlcg reg access ctrl */
 	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v10_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 252517ce5d5a..0a48ef22557b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5258,6 +5258,8 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v11_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 35d5a7e99a7c..6cbb8f933ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3873,6 +3873,8 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v12_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f1a2efc2a8d0..e59741ce2d51 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4812,6 +4812,8 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* init rlcg reg access ctrl */
 	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v9_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e0b50c690f8c..48ed96ec7296 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2520,6 +2520,8 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 	/* init rlcg reg access ctrl */
 	gfx_v9_4_3_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v9_4_3_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 242b24f73c17..b7f928521f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -38,14 +38,10 @@
 	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset))
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip, inst) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_wreg(adev, reg, value, flag, hwip, inst) : \
-	 WREG32(reg, value))
+	adev->gfx.rlc.reg_funcs->wreg32(adev, reg, value, flag, hwip, inst)
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip, inst) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
-	 amdgpu_sriov_rreg(adev, reg, flag, hwip, inst) : \
-	 RREG32(reg))
+	adev->gfx.rlc.reg_funcs->rreg32(adev, reg, flag, hwip, inst)
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
 	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
-- 
2.48.0

