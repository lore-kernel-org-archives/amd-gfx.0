Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB80C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 14:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD8810E04B;
	Thu, 26 May 2022 14:06:26 +0000 (UTC)
X-Greylist: delayed 487 seconds by postgrey-1.36 at gabe;
 Thu, 26 May 2022 09:44:39 UTC
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B617F10EA80
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1653558273; bh=YiVO9Z+7BbDvulQLJMKhwpIkzvy8COlR1+pQfWMbqW8=;
 h=From:To:Cc:Subject:Date;
 b=fhrxWVslmrxmohgox4hX4OMR3czZPGf/9F+CqrO8g7BS00IeeRRXImp3RpmFf9gk3
 NHTYG3jSBBYw+GWWZ7GiLxDRi0pI75sy0yiAiLs9N1d8dWjMHohNPrbzrzlBnZOkXy
 sTrhcI3hQtuYqQigu+rxA1VLpvz+tqlWA3wtasNI=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
 id 74B23E43; Thu, 26 May 2022 17:29:11 +0800
X-QQ-mid: xmsmtpt1653557351t2ogozzdr
Message-ID: <tencent_9934C5D4CD39D3C35606F674AE61310F2007@qq.com>
X-QQ-XMAILINFO: MyHh0PQai9Fp6tHOjQ0UYffo5ElvQ5paDEg2XYJB+HIITHW6nzyPwpdeFV1pvb
 9tSW+PeFMKB8/pGBjoIwkRQqCZGP0YPYVx0uzDxkY6MbHCtUdLVw1TfZ9vfAtG8/nlHUuZ/j552m
 HC1E0JyY1OGC46TuGaPK5PyGWonxJa9mIAn4s5rIZ/uS5Ia5MKTtUIt3MRyark65fIGCcj0e+iy3
 D4Qu//IJhchvyd3VPTfsKIPuazGvYTYsVluUB/wJx9efn2LOKGOsM0e9rs4qlAlsw6kCcd+VoStJ
 pZJE2gPTQUUOzwPcly1dlinwWlV7HMdN9YPAe4XJ2gk28BEapk4nJUKGsl6UOE1JolFQEqks7uxO
 OjvS9tO52WWICLTsPqdpcu32wGU0h4iCtMkDW+rP0cGTE1gyDFmBQD4yT+RGzuX7p6qkvv2KRdnz
 dufEmrwqk2KFSTWfn5qL72dtTeuoFSAPWCqve9WYfvh5ng/5hHjunu8P1ggiR0l2YgRaqvu2853v
 bPFf4LFxaYydBscJ6HT+kWgAJLXAv4Ha+8RkJXCFY9SLdhhtVDWZf5mGPFcSwgABoPPUiPEitNlm
 Lt2QvNQnlqEn/UN3EXL9OOPqu9zIxbzXTZD0a3PvYr7NEhLPZPFOETSOTN+pK74FsMG4mWaM7pry
 WN+n7CztCgbRjnnBHlYRVdWpdLXvOYXGhC7n8lBVnI3g/VBADAzyriEh1ymeRbpGY63L8QX3dmcg
 gfxheZiGVmGkxqvGD/RQSg9ga9KWONY6Mx91IlYOgHqmZTnV2gnBitjPrDFE7Jmzbtrm/gTndjgs
 JI9q/PLht8/zzzMfr+h5NOxr/FyOx4DByyxp31KEZ/PdjI6koewk1yDNSxoFRbFkpuInGjqpi5UQ
 ==
From: 1064094935@qq.com
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: Fix spelling typo in comments
Date: Thu, 26 May 2022 17:29:09 +0800
X-OQ-MSGID: <20220526092909.1164946-1-1064094935@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 May 2022 14:06:23 +0000
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
Cc: David Airlie <airlied@linux.ie>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 pengfuyuan <pengfuyuan@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, k2ci <kernel-bot@kylinos.cn>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: pengfuyuan <pengfuyuan@kylinos.cn>

Fix spelling typo in comments.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                       | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_api_def.h                  | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c               | 4 ++--
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7606e3b6361e..35c303c865be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -271,7 +271,7 @@ extern int amdgpu_vcnfw_log;
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
 
-/* smasrt shift bias level limits */
+/* smart shift bias level limits */
 #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
 #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
index 3f4fca5fd1da..c31abf554878 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
+++ b/drivers/gpu/drm/amd/amdgpu/mes_api_def.h
@@ -33,7 +33,7 @@
  */
 enum { API_FRAME_SIZE_IN_DWORDS = 64 };
 
-/* To avoid command in scheduler context to be overwritten whenenver mutilple
+/* To avoid command in scheduler context to be overwritten whenever multiple
  * interrupts come in, this creates another queue.
  */
 enum { API_NUMBER_OF_COMMAND_MAX = 32 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 62139ff35476..8855a75dc75e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6705,7 +6705,7 @@ static void dm_disable_vblank(struct drm_crtc *crtc)
 	dm_set_vblank(crtc, false);
 }
 
-/* Implemented only the options currently availible for the driver */
+/* Implemented only the options currently available for the driver */
 static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
 	.reset = dm_crtc_reset_state,
 	.destroy = amdgpu_dm_crtc_destroy,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 4385d19bc489..733f99a6e8e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -619,7 +619,7 @@ static int get_max_dsc_slices(union dsc_enc_slice_caps slice_caps)
 }
 
 
-// Increment sice number in available sice numbers stops if possible, or just increment if not
+// Increment slice number in available slice numbers stops if possible, or just increment if not
 static int inc_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
 {
 	// Get next bigger num slices available in common caps
@@ -650,7 +650,7 @@ static int inc_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
 }
 
 
-// Decrement sice number in available sice numbers stops if possible, or just decrement if not. Stop at zero.
+// Decrement slice number in available slice numbers stops if possible, or just decrement if not. Stop at zero.
 static int dec_num_slices(union dsc_enc_slice_caps slice_caps, int num_slices)
 {
 	// Get next bigger num slices available in common caps
diff --git a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
index 61ee4be35d27..2c40212d86da 100644
--- a/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
+++ b/drivers/gpu/drm/amd/display/modules/vmid/vmid.c
@@ -66,7 +66,7 @@ static void evict_vmids(struct core_vmid *core_vmid)
 	}
 }
 
-// Return value of -1 indicates vmid table unitialized or ptb dne in the table
+// Return value of -1 indicates vmid table uninitialized or ptb dne in the table
 static int get_existing_vmid_for_ptb(struct core_vmid *core_vmid, uint64_t ptb)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
index 45f5d29bc705..15b313baa0ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/arcturus_ppsmc.h
@@ -120,7 +120,7 @@
 #define PPSMC_MSG_ReadSerialNumTop32		 0x40
 #define PPSMC_MSG_ReadSerialNumBottom32		 0x41
 
-/* paramater for MSG_LightSBR
+/* parameter for MSG_LightSBR
  * 1 -- Enable light secondary bus reset, only do nbio respond without further handling,
  *      leave driver to handle the real reset
  * 0 -- Disable LightSBR, default behavior, SMU will pass the reset to PSP
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
