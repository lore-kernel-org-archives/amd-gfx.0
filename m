Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9923D49C90
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A0110E941;
	Fri, 30 Jan 2026 10:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="m3qeegoP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B401010E967
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bRBFTb3EzEe/NkpBqqLaL4GZFIhkn7V535xWcN9mcy8=; b=m3qeegoPoIKLKjn8ktTo1TQItz
 pb0jBl4AovWVqJkMiuOvpfjjAUlc0bmHPo4D/fF2NLCTzQMJ8gp5RSeBrUR9ROZVkKTqLqpDXrggN
 CL+u+QB2b2R9Z7bMQVtf5yrohlQWtCGD5HCY8EyFJlnHnlsgYEn2r11NVdV+t6HuDEyMyf6f9eEr0
 Jx0Bct7BBDf5LyIzzeRq049QG7svO7jEvhVY0TaQzWG/2i04dBUAltoqGpy/Xkwwo7OJAkcF0Tf2y
 BxUtkyGxapyvf88sRc1PaB+OjyVdfSf3Yh6W7dydaRMj94kIaKCUsSG2m4L6kzUvSYQKIzgeI+QQd
 nS1e6WCw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vllM1-00BhEf-Vm; Fri, 30 Jan 2026 11:03:54 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC 1/2] drm/amdgpu: Choose SOC15 RLC register read write functions
 at init time
Date: Fri, 30 Jan 2026 10:03:49 +0000
Message-ID: <20260130100350.2883-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130100350.2883-1-tvrtko.ursulin@igalia.com>
References: <20260130100350.2883-1-tvrtko.ursulin@igalia.com>
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

Currently on every RLC register read the driver checks for three different
conditions to decide which of the two register read/write functions to
call.

As these register operations are macros, which is required for register
name expansion to work, the result is a significant explosion of generated
code which the compiler cannot optimise away.

We however know that all of the three conditionals are static at runtime
and can therefore move the decision to driver init time. All that we need
to do is define a new vfunc table for the SOC12 RLC read/write functions
and use them directly.

Bloat-o-meter agrees the driver size savings are significant:

add/remove: 9/31 grow/shrink: 74/1012 up/down: 39784/-381724 (-341940)
...
Total: Before=9421643, After=9079703, chg -3.63%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c    | 39 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 10 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  8 ++---
 10 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e69ab8a923e3..0d5837ca9e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4458,6 +4458,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
 
+	amdgpu_early_init_rlc_reg_funcs(adev);
 	amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 572a60e1b3cb..002fae3c380e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -583,3 +583,42 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 		amdgpu_gfx_rlc_init_microcode_v2_5(adev);
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
index e535534237a1..959d60c90dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -262,6 +262,11 @@ struct amdgpu_rlc_funcs {
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
@@ -303,6 +308,7 @@ struct amdgpu_rlc {
 	/* safe mode for updating CG/PG state */
 	bool in_safe_mode[AMDGPU_MAX_RLC_INSTANCES];
 	const struct amdgpu_rlc_funcs *funcs;
+	const struct amdgpu_rlc_reg_funcs *reg_funcs;
 
 	/* for firmware data */
 	u32 save_and_restore_offset;
@@ -374,4 +380,8 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor);
+
+void amdgpu_early_init_rlc_reg_funcs(struct amdgpu_device *adev);
+void amdgpu_init_rlc_reg_funcs(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb26c..83710f08e70f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7829,6 +7829,8 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* init rlcg reg access ctrl */
 	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v10_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 427975b5a1d9..12a39259a2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5273,6 +5273,8 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v11_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 79ea1af363a5..998a008ecc8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3879,6 +3879,8 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v12_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index eb9725ae1607..e048c975537d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2882,6 +2882,8 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_1_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v12_1_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a80..26786f71467b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4816,6 +4816,8 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	/* init rlcg reg access ctrl */
 	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
 
+	amdgpu_init_rlc_reg_funcs(adev);
+
 	return gfx_v9_0_init_microcode(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345..2e17fc1157fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2525,6 +2525,8 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
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
2.52.0

