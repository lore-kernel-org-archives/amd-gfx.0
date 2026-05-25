Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29BFCD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E43810E0F4;
	Mon, 25 May 2026 11:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4p4lOqG";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E4C10E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:22:08 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso8123782f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779708127; x=1780312927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TR4eWP7zFCU/FkJrQjiTvGV3X1n9lSJQpAdko06zQKw=;
 b=h4p4lOqG1dX1EyJZBuJdZYUP2J77CI6dF1jWEbV6xIzTHfwd9t5qD1wWuAOLxMNoaE
 q1FNoUt4qh92MXgWYrnPFrr5cb9/xm5FiLayu0EDkNAikItTER4lbGDtj24Y7X89yumz
 qRL9tNqxA02BOe6JnLFLtVmVrt1HQ5h7Nu+O0Aq63z4IKn+XUrHP1rlQWlK8qcyqaCUi
 Yt7eKEHw3cLpS1yrU/+lZDYpX4GRsHLHC7NUTDl7ZRLlM9kzvpWCPTYJEhSiHGhTBXk2
 GtmmiHV/Jre5ACwcgbYDkKIW9LtWfkHt81F39gWXNA3/vzmmCcfNfTYU8vn7FvDyek73
 uiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708127; x=1780312927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TR4eWP7zFCU/FkJrQjiTvGV3X1n9lSJQpAdko06zQKw=;
 b=O2mWo1JwkzzwuxDeP8qTxkx3G23GEWo7+lGnq6qd17SYk8fUjp/etqGW+gORnbovVr
 WCDMrI5vuMp9+ILj3FKF4XHeYBDZfPz81Vd1vTky/OCc08GRySf7cBF3w9EffY5pSTm8
 Kf+o+NRxiGEfX8unLS7kiaGHuGvxFqKb0y787MG8xQf+AcwMA7hC6+oTtWBd4EjaPNFx
 4QtmZwGLMbj0s9sWVyBiVOSiMJLUkZksrXU0mlW3Fe03vbqBjDqIz2HfRSoZx7qCxpNY
 W/0GpYyURPakRFqkT6N/c3yDBL9IUqcfUmVu8YkNJSLzkoFF6GAc8d4n+Z07OkGlwC+q
 liMA==
X-Gm-Message-State: AOJu0YybDE1coPYY3w58OLgmwrzvDmSCiOBuM5W0a0lXKWWrBvCIcIWu
 qT2s8Tgcf1q+tM+IQoUArtJ5TfhqhEfaOVf8h9R3f4kHyXKyE03ZVoM2Zg9X/g==
X-Gm-Gg: Acq92OFtrmh9tnVVXG3O42YKa1Q+HIFE/Q3Sb4PQQTLfWwQVOaVk6LeN8ztmmD0v89A
 F5mAg7PshbQk1uhh3jgatPVKY4Eni3HRw3p6esDCebCeRTm85JUMHt8rBxAEsB+POSLk59pGkoQ
 EqWtGMpJCjjBTgRERwqmwCg68Pag7jeh0Kjn3T7uifWVOdxLjhYuZuf7ZabcfiIYlwbzYXzI4kK
 R0AUk3oQ39rAZrY6g3WXbgdBmX4mR4IkoHuJhmxNmz6b1//NuZVxWDjPaz+2Me4UZTMFs/9aIde
 FThfBfayY2hlhUCdp3c1GuBbmRK/U/rBfMOrAhfqCZvqz95movZv4B1NF84yhL4q1we7wJrGiDh
 dinj6uQeKMh6o/HUMUC9rX2IzZpOll3w8Ur+zHdlSUq4j4XZFkQ/qnraiIc03DZm/y5KJWWtPmG
 0Tk/LFtxN3CLDxBzVZzLNuseCRvFD8oFdpuaIMkOPNXOOIEM84VRjIhTUHy7gEqqeq
X-Received: by 2002:a05:6000:25e1:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-45eb389d3e1mr24925668f8f.19.1779708126658; 
 Mon, 25 May 2026 04:22:06 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6bc5479sm28185624f8f.0.2026.05.25.04.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:22:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on all SI
Date: Mon, 25 May 2026 13:22:04 +0200
Message-ID: <20260525112204.12604-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

It seems that Pitcairn has the same issues as Tahiti
with regards to the TLB size. This commit fixes a
VCE1 FW validation timeout on suspend/resume on Pitcairn.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 02f85802f579..cd0fd77578d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -203,7 +203,7 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 	int r;
 
 	/* Align to TLB L2 cache entry size to work around "V bit HW bug" */
-	if (adev->asic_type == CHIP_TAHITI) {
+	if (adev->family == AMDGPU_FAMILY_SI) {
 		alignment = 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
 		num_pages = ALIGN(num_pages, alignment);
 	}
-- 
2.54.0

