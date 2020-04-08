Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318ADC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFDE2074F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTWaG0i9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFDE2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C970A6EA61;
	Wed,  8 Apr 2020 13:31:15 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2377A6EA61
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:31:14 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id n17so5531846qtv.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sSCr1jBgRbNHd9ZNWLxdGhWDBjyGUKzXZb7mEGIS/Lc=;
 b=cTWaG0i9Ndpgx3bJAw38M8aJkNyleOpqRV9sz0xEbKuvC4hOrEwzlFA30yyCZZQjhU
 M+9v/xJ3SIPNuRviCzOsbaBI/6SMEtD2EEQ+wHyIV5JuKJabsZpAaVeFql0g+y4jxrAx
 QBCHSzDjO+SetpYJvuEDk2j4bglg5mTFTchQJGYNBe3Lv43e1OEDY1HZ2biPYd0GQLyT
 c+z2q2r+e/wX9iNNnDLq3clIwmPgmfkHkgQE6LIHgH3ntvCuNE/CjBstrBQc7BNTJUjO
 lcBwvpiEksJrmQvtJmRs4pY9POT9+HUCdTkZVfyozGuWl4QdL+7Zd5NrlJF0W6rZriRy
 foeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sSCr1jBgRbNHd9ZNWLxdGhWDBjyGUKzXZb7mEGIS/Lc=;
 b=ZhCDI6t0OwhSVl5U8NOzEvdB8y0vWxKCQn308FHlvjqwmY5FGL/HY6L62ShQxlH003
 txJa5nA9y9d2ncXqovOW0K6uoNu3mPnZys/3FwdBA+CcWIz5iLivUNQCJ0jf9XzAamqk
 AsuXUGDCA+DoJ+T/e/KizDXlEyn02JxZRGd8US4oP7Qcaia7xl9Txh+dqsOgV4TB6pwZ
 /6GBXgL+OCRr41uxn2u3j5rSt2oEF5dzZB0+p6EmznhM7gAUG9rmJ4JG6rjACCKn05gz
 pEZejnzwALKN+B3k75GJQ7X8ynfC/jGJAjKIJOn5/fFdv50EFKMEXBGDLKpIIhpK3K/a
 aTsA==
X-Gm-Message-State: AGi0PuZrJ0SIPFyV/AgGJEgX8rpxPVGI2mLoCum5bGieg+qUUJ4zd129
 4E7MUjDRx3MOAg3aD4ApX+sAhj+b
X-Google-Smtp-Source: APiQypK654MNrFyh9LrNwtUIT8DFGt5BM2Mrj1y7aSz+2TkI66Zkg8APSFSuPdLD5wYyAIUNfcRvFg==
X-Received: by 2002:aed:21b0:: with SMTP id l45mr7456921qtc.47.1586352672957; 
 Wed, 08 Apr 2020 06:31:12 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id r128sm1623366qke.95.2020.04.08.06.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 06:31:12 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix warning when compiling without debugfs
Date: Wed,  8 Apr 2020 09:31:05 -0400
Message-Id: <20200408133105.1743707-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fixes unused variable warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1155fb686e36..417925a0d739 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4738,10 +4738,10 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 static int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
+#if defined(CONFIG_DEBUG_FS)
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-#if defined(CONFIG_DEBUG_FS)
 	connector_debugfs_init(amdgpu_dm_connector);
 #endif
 
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
