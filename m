Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E0C433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EBD223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJGBHdLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EBD223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D2A6E7DD;
	Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6984B6E7DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:16 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b4so16491408qkn.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xvb8EkHVHrLfJGlCqEFlXRgC5SCROi0PsS8a56e8UU4=;
 b=rJGBHdLFaK5P4uKp8iiZdbF790tMHDXYBb/kgV8GLllpO4YthcPrKockVXy+aQHaXa
 DVYkfGOXRYppXTObm47cwbJdXwuzM3Xayaigs79N4Lp/9n9kJ1YYZ2nNyLlS7m24x9Zx
 +1tTFYr+6L/3HTJujwH8MKbqiOabXO4mCmIMN9IlGl00ApLCK8fAyFEJM0j9eNTTOKCX
 LO24gdYFTNE4oOUxQRT9jrVytuoyyilUjglbHbNilx1eDlbVj4etOILy7646B4ZS5Hz/
 AGwOIPeJW5XO7USDd42aHNtCQdKChOjpV2ZmYKl8t0G+cxnBEVBxm8ZCayacG6KAvM+l
 WjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xvb8EkHVHrLfJGlCqEFlXRgC5SCROi0PsS8a56e8UU4=;
 b=q3GB9qXyMf3/SuC6oD7q/bu0tCNaLzHpIbFqrv+K3SxW0CpHy3tOlBQcmUCvaL4h7d
 V1Y9VxeQAJLIOw7f+yKIqa/4mvF6bQ7QK0BlPq4FYzYmqQnYiELj08Vyb7uta3W01CEK
 K4dLG43RCu21tbATTuLjXoBPRHVQ1Mv9S2IHxv8o7a4tuuqselGBMCLUojCW65AXfFGe
 XDqhjC1edNSTpYa15hCiblECj/h+YIdmr1kerFG/CuOyCAzrltTnUzcRW+kDuLz9arF3
 MmrSAZOkjil57J2eAV722IUi1PLFVfOpkQLBs1SoK1oxEGEiuPnZQZDZ3Q9qMyHwjWeU
 1zlw==
X-Gm-Message-State: AOAM5313bThcL6y1YxnuZVcS4JaFJci29XzD//yYaZ5NAs+mDKTxgpOU
 5Qdj5QQIAaz36pgLFkSxJcavEp2m
X-Google-Smtp-Source: ABdhPJxfLOok39uSVzBZjFg6MjLkDswQ3lnfdBt/crI2Inkoau0qZy9vt5eNcN23Cu4Y4kb2MOodow==
X-Received: by 2002:a37:8fc5:: with SMTP id r188mr5414864qkd.447.1594751055404; 
 Tue, 14 Jul 2020 11:24:15 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/42] drm/amdgpu: set asic family and ip blocks for
 navy_flounder
Date: Tue, 14 Jul 2020 14:23:16 -0400
Message-Id: <20200714182353.2164930-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Add the asic family and IP blocks for navy flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 99ed9cbfefcb..3efca05e5d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1810,6 +1810,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	case  CHIP_NAVI14:
 	case  CHIP_NAVI12:
 	case  CHIP_SIENNA_CICHLID:
+	case  CHIP_NAVY_FLOUNDER:
 		adev->family = AMDGPU_FAMILY_NV;
 
 		r = nv_set_ip_blocks(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
