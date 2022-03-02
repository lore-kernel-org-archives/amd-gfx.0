Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44110C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 05:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F3D10EAFD;
	Wed,  2 Mar 2022 05:48:12 +0000 (UTC)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com
 [203.205.221.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96B10EAFD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1646200087;
 bh=D/JdRfylauMoYuXSlLyF8tsjvhJVrbjWvgwY8MY63gc=;
 h=From:To:Cc:Subject:Date;
 b=SGmCiDQaSElGbosAL82o143beUPctHk8kIfjqMEMmsYSfKwC5ZXnYY1O7OAepxeRK
 uW8Z2mxcFWJo+cZ31CF4cmvYHdHcvQEpr2fGdBuSoMFUhiP943HpOvJvA9tZnL0DQI
 f9ZsyEwI/s6zSLrLhEXmvQVdW0fA5m+5K98HR/1A=
Received: from localhost.localdomain ([111.193.130.237])
 by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
 id BFAB0A0A; Wed, 02 Mar 2022 13:47:58 +0800
X-QQ-mid: xmsmtpt1646200078tfx4vgbbu
Message-ID: <tencent_3B1D4616459C636279304EC722467432BF09@qq.com>
X-QQ-XMAILINFO: NKOD9ak1rlu/pEKCBxk88nwx6sPXZdA0s/PmCDRJIsdxaK/58hfyzuwqUjWpOU
 qxJ34U5LCyG091AhhRV0UObGfWrTPY4xKWzg6dmyIVVsJTukeQ3trX0c4NuUefu2c+tz1SHoVP6W
 uI0aubWeSb6VyaPbup3u0l5eqxPEDV9QPMIkF+FkWjTg9retKsXr3zjjPBXgvGcJulhIwtHm5iSx
 /vRUUZhAhClNVhkASbl8/QIttE7v+z520p4vK+d6hlLdlDWa8WhT5xG8ZPc43nFJs0d60usab5jt
 DqgVyXeCFrtekp9a98xzW5dEef0vzgJ5KoN4lMWRA/g2CskUVkUx8i9HYEPh8l+MLM9LmeGWpz66
 G00DGcSHCkDgUBhYe+yNhPpcUPx8vp8wMc5ouuSpSHeVlCH9k3FWjvNYorkYxXbn9RhfPvQSvWQP
 oXd3abDX5b18S5BlN95eEMH954Kki+RBHghTSFwrGPsaCoA9vFEVk2Gr+++JOSk9qvCQKi5m22dT
 PhAVgvJe7t/sru1JHX5cGwf63dMysPC9X26wFApVR7GaWSD3sBA8fBfucqwbX03Yis1p05ta54PB
 LYI1Ap5l/8PPnDl9KYZS+mgXCnQnICz1FPBn38wb0iP7dj7swEjueniHIz5vXlpbpEgbXLbQaoKU
 NQVOS4fHCezdqOfmYarr8Q9PN8ZQDzWWTui6OmDs3TJNicn53DVsrzrMf5SRFIoKV1+wwteAFCQy
 FTOBSbXTfEdTdHeKeOeYJQRqneLtTwzWVLbiyBPvJDMkMekVnaL5p2E58LesYrwLP2DZCJUVY6Do
 ZpTDkC9JQsup5kf/NXnYGkg0ceWcUSwp646OyWH8KR3zwHaWqOC8iI1BjZ1P26FExhXRJZaMnf/g
 hRwOLfMNYGdLWsQC8p8JJ/ehR8MGhMHCD/VEKjQgLk
From: Weiguo Li <liwg06@foxmail.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: fix potential null dereference
Date: Wed,  2 Mar 2022 13:47:58 +0800
X-OQ-MSGID: <20220302054758.577060-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"ctx" is dereferenced but null checked later. Swap their positions
to avoid potential null dereference.

Found using a Coccinelle script:
https://coccinelle.gitlabpages.inria.fr/website/rules/mini_null_ref.cocci

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index f522b52725e4..b4f035ce44bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -258,11 +258,12 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 *stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev;
 	enum amd_dpm_forced_level current_level;
 
 	if (!ctx)
 		return -EINVAL;
+	adev = ctx->adev;
 
 	current_level = amdgpu_dpm_get_performance_level(adev);
 
@@ -289,12 +290,13 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev;
 	enum amd_dpm_forced_level level;
 	int r;
 
 	if (!ctx)
 		return -EINVAL;
+	adev = ctx->adev;
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
-- 
2.25.1

