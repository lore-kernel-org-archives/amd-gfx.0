Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C2C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE5A24679
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk9cTtWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE5A24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308586E97A;
	Mon, 27 Jan 2020 19:38:09 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46576E97A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 19:38:06 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id v195so10815057qkb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yr1XI1idoQ9DrWmR1bK6XGrZwtuROhEGC76nw3mhj78=;
 b=Pk9cTtWccjAS0dj+CFbyIwARuBa/Cuv3jSDYjXJJn64A8qaacC402smznGSZU2x1PG
 Bglrh6y25R1O5sjPn0U8otvTPP2BiYhvW0gAPg+ont02W01wjxIrTmC2WpiGCAKQzkxA
 K7RF4Kdr30XY3/cCj7ogwBiFFCnZ2NA3u8VNquzr+ufrNqsBjKfn926DUfSeq7o6B4dF
 O4dLbBu07Ld+r/RAV99qpdl/V8uJGKLfN6dJb0priW2YLgrxoPblPVneuny1Gjm1fy/e
 vgmA2BKrB21crt7Lomg3aZ7e3zjRrvQO1SvidffoRK2WXRjpod9we/1/tJukVNANTMXN
 Je/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yr1XI1idoQ9DrWmR1bK6XGrZwtuROhEGC76nw3mhj78=;
 b=pNum2pAXbUnGtcrqPBFtPHTd7iVhJ4ZfuHp5c6K3aNgEgrwqbIh2dtjpF0OMjJ6WeE
 DeHuc7TUIj276ccpKLHcvAATm/ZMnqCfCRyvcDyeB8VWJireq5TUQ5t4XlXPJLdz7hmk
 294/Oz9ikCHP79ez8HztdDsd/2Lg+PZ6OX6byTO+UB7z33CUMlfPnxFcJNtLx1hJlicM
 yx/Zg29NIzms5tha+/3kgfpWLOIUnc9FSNI6hbGLjQiE6fI0khS+fWJ9AjREiYA0l8Hm
 sk/fuS+ME8HBhsrDLu328fw7wwEBGBy8dJKW3N5XGyCnTp4aqgrqtsezE+mpDsC6u2+d
 IN+Q==
X-Gm-Message-State: APjAAAU96QQOBV+4D5nmQkqYFYez5rxakQQUOetIhonyxFVDEXcVJSd9
 ga8zAn+UxhdzpLVx+oWM5kVNsfqg
X-Google-Smtp-Source: APXvYqw68ZuK6tM5sXqOYhht3LnW7KbZZgzSvFWWNx1jUALwKtyVjm6QApsSbj2EvwuxYMj9A2dvSQ==
X-Received: by 2002:a37:4ed3:: with SMTP id
 c202mr11322699qkb.219.1580153885852; 
 Mon, 27 Jan 2020 11:38:05 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id k17sm10178749qkj.71.2020.01.27.11.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 11:38:05 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable GPU reset by default on renoir
Date: Mon, 27 Jan 2020 14:37:57 -0500
Message-Id: <20200127193757.28379-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127193757.28379-1-alexander.deucher@amd.com>
References: <20200127193757.28379-1-alexander.deucher@amd.com>
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

Everything is in place.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 69248d1b2417..5030a09babb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3762,6 +3762,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
 		case CHIP_ARCTURUS:
+		case CHIP_RENOIR:
 		case CHIP_NAVI10:
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
