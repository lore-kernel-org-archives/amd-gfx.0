Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D3C5B567
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7141010E6AC;
	Mon, 10 Aug 2026 06:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvsUeoJ0";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C6D10E1D1
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 12:19:07 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so156978f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191545; x=1786796345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFo+FAm9dOuD7sRaxc5XvG2wnDlTsCrM8DjnwJd9TPY=;
 b=WvsUeoJ0o44IBhPdHLdbsK5+tCMziEw9AUAFu8gzfzcU22TbdWZ7Zu0tBFU1f7jncC
 RaydJ2GCh2L8uzk4VzmnqoseWaSCzuHeZEG9PNCQ7mA8GAHUHfzlSuNH85ODylJL9hPT
 NTCyfnHIoqlUri3kUEPVQCI9FinZOrf+B2Xq2KY/Hr5wcpx9AoIUhBQ3cYYIlWjD35/k
 ZR9y9YtsTE15p8dtnd4scxXU5Ps//nQcwplc6jmiKjbIcprnq3QN7zLRpimpByeSDTZc
 ZSiYdO2YYpQYIhitRw2jPS0+E2/qwYi8Wa1HvJvmZZbUMMSq1ZOwUA8oJn6GaWVejh2L
 t5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191545; x=1786796345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFo+FAm9dOuD7sRaxc5XvG2wnDlTsCrM8DjnwJd9TPY=;
 b=fwsmAsrUEmspai6CEQG+OP3HiptJgVIhY+ZfBrzS7nBL5hfJvxydippvJ37R+E95vr
 V5QoX4OMzldRSG2bwyHQzCt4s3OBi6XwdNEK/B3Bsn6gSMzE0EN2ox0ZpbSyWNVPPJWl
 4+lyj2dHcNLoEbxuYwYbqIjnZAQd4bftYbPmld+2km0m6m+46j1jvKt/n2ZWZJF4ilC8
 VLouAyLmKnyLiXnEbriz0TguaS+dfpzQiR4Avy24RJ8tcbZfZV1kANEGhLggwmUuhCBG
 25SYEmktSRsej3a9RAY6x0RA7PSKzdORmZdeTTNZOu5eLDtkF9pkUBluadT8EYGpKEhX
 2dmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEM23iYEF4w8nZOaryFPW+qTwpzx48yO+MSX38V9gfW0uBgpnIxf1pKnGWKno88gpkyy/a0Kij@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6s90YiTOmjDrPX2/gTXiH6qzxnNI7/5ZvV+8PuWvuxAOwlPx9
 5oIhN9jEJ3Pr4TYeq0pmSYnKtFz2YGbNdAXpG3s7OkOosKakYi9Cq5X6
X-Gm-Gg: AR+sD11H/jOtfgVXWHgTapdwiJ4rr0M1Hp7i0hQl/1ZS5uTJRdtg9xGvh/DqmmN7gEO
 NewqKlweFmpHvfksFPE207/wpHduLOh9uNqmIjyXTuMtHOh4iTLMOhKlwQBgFbHB+PUBzENg5Cw
 uWmKNBBZEYSd5putVYwrddAeLqHLo9ZSJ43cz2WuqpofEO7hTb+lH2W0q/7vMpkyCNPxEz7IvH6
 yLeYexcp2+uX7xHcvr7Z4k/foFELIuERwSbNgRzqdjfpDLvAox8phFQOCeciHRR0V2ZtX+Ci0hE
 UzodHIOYQH8x/DGHyDDy0F3unnlZwtp195WWgU9PY0se2IU+ldqia9CegJP8VUKqaJsft/y7nm+
 26L+N+1ErA8+/dKqRNAs/YmF0DeUnuTVicFX4aArJ+0cHkbbtTxs2+YgIloirSrNnUKOekeiuYh
 Pb4Iw6xRxQhVCSBE6v4sUb1LzZlTQpiJ5091GFquWkZKRtR14qIgWci6o7/ro5TMv0cBcfxoQTN
 FQx2nL/CHWLCArU/XmPaf3jA3rdL4xxpKU6M1IKuc8F7pcuXCfgzvzl381nAQLcf5ps+VXm326o
 EPLdGgBBG8DSkj2/ugjhkCilH9d48YA=
X-Received: by 2002:a05:600c:470a:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-4995e0df176mr112874695e9.13.1786191545414; 
 Sat, 08 Aug 2026 05:19:05 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995421fee8sm212371525e9.7.2026.08.08.05.19.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Aug 2026 05:19:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amdgpu: fix GTT manager warning message
Date: Sat,  8 Aug 2026 14:17:45 +0200
Message-Id: <20260808121745.72691-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

WARN_ON_ONCE() takes a condition, not a message. The string literal is
always true, so the warning still triggers but the message is never
printed.

Use WARN_ONCE(1, ...) instead to print the message and keep the
once-only behavior.

Found with a Coccinelle script. Clang's -Wstring-conversion also flags
such calls but is not enabled in kernel builds.

Fixes: 7554886daa31 ("drm/amdgpu: Fix size validation for non-exclusive domains (v4)")
Assisted-by: Claude:claude-fable-5 coccinelle
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f98bfba59a2c..f2ea881d39e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -565,7 +565,8 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	if (!man) {
 		if (domain & AMDGPU_GEM_DOMAIN_GTT)
-			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
+			WARN_ONCE(1,
+				  "GTT domain requested but GTT mem manager uninitialized");
 		return false;
 	}
 
-- 
2.39.5 (Apple Git-154)

