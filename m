Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A4CC79F82
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 18:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BCB10E203;
	Fri,  4 Sep 2026 18:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAcp8E6G";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E442610E203
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 18:34:20 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so12208995e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788546859; x=1789151659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EaBeN77O1/tyfJFrWpLwox160xlc2z0iwYR1UhhHFGA=;
 b=CAcp8E6GIdYIQe/RJk+7ijaNksIxo3x2we/dxahKMVu9Jj4OxmGamZY9YjDhyA68+u
 5TMV1Hj6hD5AW92YpVbabF9peysG9gkYelLf4O6wss/eCnrFeaZcvxxm+OkOnJ40fu1G
 v5DyLq5vZqeo+MZ29A8ytfbPNGc4LXkAkCTYGJShTOKmZBZRFvXeEUQLssf4x6jbcbak
 UBFuKWOP4C3E+fYPaiwclV3oGeVva7F5VRtg6cHH5y148RXnGcR58yFlAcncdf9JNSsf
 AtERrAG2hoPMdjdc5dcLqtlejRojA7kFym8At8WmG2dU1SRTzpJ1QbN63k6pF5yRY3C2
 Th5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788546859; x=1789151659;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EaBeN77O1/tyfJFrWpLwox160xlc2z0iwYR1UhhHFGA=;
 b=SeCurwxKx5M2g/zSsJUwndHB9lD9VscCmVRxvlzgMHs0KHritRDXFR/sBpcXyQvr05
 DUXs/aqkOLFaKBwW21uGYYP3e5jCGb8tkZeMsIOqzw0VHTagi2LvPAET42QkR/sfZXv7
 zdn5WpENehwsIss+JZ+6zzWbDPYuHakND4Uifvofdgyzqn1RFiyIybohSFzJPhH5/BYs
 T1rrkme0gv/5p3f389Rq//+VoHS2KWhyYyIK3gP7UfftN+56dCuoJCJHTwQj4qdu3eVU
 N2aVUsIloSVEB1YVxMyXWAUzjl7wNuQ8c1IBhtb74KH9yx51ktql7hyywGB89yZlqLMj
 +pbA==
X-Gm-Message-State: AFuF++nMT8OB/J4SbhPfNBdpfFKS58BuR+4SIrY6hh3rSV6+/PJmN54D
 P+UPrgzg+s0ZDzsd3Dnvmf8Z4Qk6poeuAspIPVaQvHlvXE5t2A/V8l0W5uzfQLcP
X-Gm-Gg: AYBFou294pJwIx+KXDTb9YZtE4ivN2QoB1tTsT/4u//bL4BM8wUWMLlm8WeD/KKWF45
 CCXKZctstx2a5I1h3r8eeXAQQJxtQJ7eSFDZVnepub6MkQPiYCTOIp6NbmD3Dp3FKSRR5/xsala
 IiKkhk0AjBh7KDTSyl5P7XNBbhq6sQxhgDifvJt3epiJ3o5mZqwdjjordzGpDIMeYgPIIHS/RNC
 zukXAQYcjjDHWOmeqbIQzNq8gO84b+KQn/MkrMk0mh+1gchvab/My0vkI1LGclSePL1vuxAiKSY
 IH5Xtl30IGHi2EAlNGDNttaEXjP31t1IWRJggTR+1ekIYXs7iciHAIPctXgYtUqHiQg7v2chCm5
 QGF+VhQKtujlbvRmI1kfbX8gCKRJ8ZUOMRI8DaOSU/hxUUfTDguclPtZ1ClHGagpfa03wQS0rN0
 PaiCIx9qr+JmgfBpumDL1SE5S+JXFmWklXXMuI3gUe0XIYYd26jzeDeqPTwXUUkBqtkH7P8Hd2d
 u7C98EzeJ8VnDeJaZ1xqlKy9/rnaAk=
X-Received: by 2002:a05:600c:83c4:b0:499:db6d:bc97 with SMTP id
 5b1f17b1804b1-49cf7f5058emr91956235e9.0.1788546858896; 
 Fri, 04 Sep 2026 11:34:18 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm118373095e9.5.2026.09.04.11.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:34:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amdgpu: Delete SI/CIK/VI IH soft_reset() code
Date: Fri,  4 Sep 2026 20:34:05 +0200
Message-ID: <20260904183409.571117-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The code for SI/CIK/VI IH (interrupt handler) IP blocks
has a soft_reset() function for each block.
These functions are not called from anywhere and are
dead code. It's unclear what the original intention
was or why the IH block would ever need to be reset.

All SI/CIK/VI GPUs have been working well for
10+ years without ever resetting the IH block
so it's time to just delete the dead code.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 31 ------------------------
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 31 ------------------------
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 31 ------------------------
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 30 -----------------------
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 32 -------------------------
 5 files changed, 155 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 314d8f1d64cc..73ec61bc69de 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -373,36 +373,6 @@ static int cik_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int cik_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -425,7 +395,6 @@ static const struct amd_ip_funcs cik_ih_ip_funcs = {
 	.suspend = cik_ih_suspend,
 	.resume = cik_ih_resume,
 	.wait_for_idle = cik_ih_wait_for_idle,
-	.soft_reset = cik_ih_soft_reset,
 	.set_clockgating_state = cik_ih_set_clockgating_state,
 	.set_powergating_state = cik_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 8d02602f8433..82bff26abd5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -367,36 +367,6 @@ static int cz_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
-						SOFT_RESET_IH, 1);
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int cz_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -421,7 +391,6 @@ static const struct amd_ip_funcs cz_ih_ip_funcs = {
 	.suspend = cz_ih_suspend,
 	.resume = cz_ih_resume,
 	.wait_for_idle = cz_ih_wait_for_idle,
-	.soft_reset = cz_ih_soft_reset,
 	.set_clockgating_state = cz_ih_set_clockgating_state,
 	.set_powergating_state = cz_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 49002c80dc71..29faaa726644 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -361,36 +361,6 @@ static int iceland_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0;
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		srbm_soft_reset = REG_SET_FIELD(srbm_soft_reset, SRBM_SOFT_RESET,
-						SOFT_RESET_IH, 1);
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -413,7 +383,6 @@ static const struct amd_ip_funcs iceland_ih_ip_funcs = {
 	.suspend = iceland_ih_suspend,
 	.resume = iceland_ih_resume,
 	.wait_for_idle = iceland_ih_wait_for_idle,
-	.soft_reset = iceland_ih_soft_reset,
 	.set_clockgating_state = iceland_ih_set_clockgating_state,
 	.set_powergating_state = iceland_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 52118765dccf..2c5ac398b582 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -247,35 +247,6 @@ static int si_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(mmSRBM_STATUS);
-
-	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int si_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -298,7 +269,6 @@ static const struct amd_ip_funcs si_ih_ip_funcs = {
 	.suspend = si_ih_suspend,
 	.resume = si_ih_resume,
 	.wait_for_idle = si_ih_wait_for_idle,
-	.soft_reset = si_ih_soft_reset,
 	.set_clockgating_state = si_ih_set_clockgating_state,
 	.set_powergating_state = si_ih_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index d84c08698dff..194487a71fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -379,37 +379,6 @@ static int tonga_ih_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	u32 srbm_soft_reset;
-
-	if (!adev->irq.srbm_soft_reset)
-		return 0;
-	srbm_soft_reset = adev->irq.srbm_soft_reset;
-
-	if (srbm_soft_reset) {
-		u32 tmp;
-
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-
-	return 0;
-}
-
 static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
@@ -432,7 +401,6 @@ static const struct amd_ip_funcs tonga_ih_ip_funcs = {
 	.suspend = tonga_ih_suspend,
 	.resume = tonga_ih_resume,
 	.wait_for_idle = tonga_ih_wait_for_idle,
-	.soft_reset = tonga_ih_soft_reset,
 	.set_clockgating_state = tonga_ih_set_clockgating_state,
 	.set_powergating_state = tonga_ih_set_powergating_state,
 };
-- 
2.55.0

