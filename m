Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C9606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFcjqJvu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB00112466;
	Thu,  5 Nov 2026 13:45:35 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F9710E3F8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:06:48 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1780478eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 07:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793804807; x=1794409607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=srOy3C5I/IQfUjrUYw7AbLY9/VnfU44F/qy2laTqkjs=;
 b=SFcjqJvuuPjBTflgGSRQ5WXsLIbAknKhwVNBn4ODAymsB58XNnJx5+VM+MGxbTrinr
 rEU9O3aUkNwz9d3a5IJzzAg9OPdcG7fnVzhCgelI+Y2P3WcUBTYcqOc+/CGiRfTD2+mT
 1B4XP8CA/zoBHLHCcBTmQ3sC39wqugMQ1ksKQ7GkKKeriqHC5V8WBDaPAes3rokO4XXs
 +VGsjFN7wfPlxyryrl5IOhM1DKt2Z0ozn2dIcBxwcl+gNdpV3Vji6jDs5ZRBjq6cLT7a
 bVTGWcX/beYEZLkvngAFMC9Rm8ocEaSfYIXYQpmYuK3sBkeF5m5SRYHrf8T0YTcxy1JM
 VR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804807; x=1794409607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=srOy3C5I/IQfUjrUYw7AbLY9/VnfU44F/qy2laTqkjs=;
 b=wFAoUaQf42owuiLQfRgQBjBOVMQVZ8zfa74ZuTfUOE1p/5QoGXbzUlR2WrYZRjxsR+
 YymBANExL6i5AUQ1uja2fw8A8jIcW8nSiSKqydnGSmhN+t2wDa0JxagHICavNouIZbmG
 YViByYd+K8wKwHq3cefJx0jkquFvaqwHysfu7PAlTQ85ynBya5Q0OfLdI4zp6OzXNyg+
 0HQVVjATfAEJPpG0lmRhJbJb6dUQjmO66RmC7OvO5W4DZduQwQns3drLZXIrhGe368P4
 L5J+UY5pJOaE1EYHmO8jcWe4QfpwiVspAteUW9Fiqf1Xdhceyv/KaUELUyz9LOrH7zyO
 4d9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHz6i1JDE5JJ8WOjFzTTRalNojCpnMgnu+WUmfbG6q27m49KfnI+gR4msT1gqSkEruj9bkC9DN@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iQNCb3aAbU/wP/Hgiv7QUKKgh8ZUuZJhPyAtrpPW+lYdOGU+N
 l7MmekT7Y690BYjPmSwN+flNNMYZTVvy05RMuuYRMCUId0kEZoAEeXbQ
X-Gm-Gg: AYBFou1CLME1wzBYxKKDECYYZAMB4UcBii/HcZF0+sP1UjEETVwYcu5QJNCZe3sd+Hd
 bygyBlFbfK+eSsyRyECxIVld6fedbVLTkllTLpXuqzJgWk8PtW0RzJXdAhSqWUth9SkwuS6Z9PJ
 IKJzD5He1V+vGVAE3PxXUh63PRKIJ2lfQC9Lk1zcbSplv89R0reGdDupYteuLZUg/bsadjreBhu
 6oBL3Xb+wzU0gNo96c1g/ksII5ftR0pfVVruuVNtJ3XfaGco0OH+0m9f76ZGWz7Li6UH75bumpJ
 fUaad/2D1yg+HvxxoIbVSJbjldAjCturkOzaP3qwOJz1OOiS9mTwCj71JkZmKfe7Dtgux24EMGO
 BShjmj64NHxKdrOav/6dZXGA3N/tWatd5bZBzXFLmARSMAQpfzERXAGAbx6ZS4bIweJ5+G6lhDq
 GiIky13nZL0Ux+QtAngLknD9VGMjq32FYkPqMk6cM6oVYrh114CLJx5bu6ueFv/kqZ49d137mwc
 zTd8siD2Z3jle46HgF14FejGl6G2/Ypl37MutFTYhXu6ldt30UofePS2uE8kHPjrlyaOp4jHvPL
 m6fgvVxJ56eIp6rgepDX8aTWYbhsaCcM9CcPfL62imLTXu8HszkS65xOZmy3YpMWdCzUi030I2+
 h8pw0w01LsH0RcyFYSCv/Fu/Ubz1A
X-Received: by 2002:a05:7301:4203:b0:36a:50f4:ed0d with SMTP id
 5a478bee46e88-36a50f4ef92mr20087021eec.25.1793804807290; 
 Wed, 04 Nov 2026 07:06:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:5040:8550:f5e4:709a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm527287eec.10.2026.11.04.07.06.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 07:06:46 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: use str_enable_disable() in
 amdgpu_ualink_set_irq_state()
Date: Wed,  4 Nov 2026 20:36:23 +0530
Message-ID: <20261104150632.33843-2-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261104150632.33843-1-sinha.aryan03@gmail.com>
References: <20261104150632.33843-1-sinha.aryan03@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the open coded ternary with the helper from the string_choices.h.
Same output.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f875209e5..a307d165a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -34,6 +34,7 @@
 #include <linux/math.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 
 static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
@@ -6558,7 +6559,7 @@ static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
 	 * interrupt driver.
 	 */
 	dev_dbg(adev->dev, "ualink interrupt %s\n",
-		state == AMDGPU_IRQ_STATE_ENABLE ? "enable" : "disable");
+		str_enable_disable(state == AMDGPU_IRQ_STATE_ENABLE));
 	return 0;
 }
 
-- 
2.46.0

