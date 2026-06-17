Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC12ACD98F3
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F9F10F0DC;
	Wed, 17 Jun 2026 19:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hm7Wjx6W";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3289810F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:47 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so480475e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723686; x=1782328486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFaBTQlbUPtRW85ENB7kycXvD7e/DLvOEgwsVVNiRzY=;
 b=Hm7Wjx6WD7ELAXQcIncpsty27MeId8+HpFdm2HDFwYq42K8D6qko4jFhj+IUrKOXg5
 muFe+3hNNZ25AE4cpxqB7s9WLWTvIqQMngLECK2Zo/8XNEkAOwXJcS9ZhUzJRnLled+Y
 SZy3N6qoXw2O0bDgMXfJqhjoWLCeCQLT8HJUXAIMl9h3KJq+PtiERLYQ/ldX9DhYxhCz
 xi675ToARcLugiP3AIt1aSxNRtsmSq5QrECMYfjS2THqMBTgJ+WbF0vnkRYW01oPtqwc
 c2hR2CXMmXR31XUsOrFl4kws5L7ZAC0fKZIqA7SGla02KxeUaxt8QRWTqvMcA1+8E12t
 vHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723686; x=1782328486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pFaBTQlbUPtRW85ENB7kycXvD7e/DLvOEgwsVVNiRzY=;
 b=l8ascANVH32aajg+8Ecq1PJzWI0wCnbfBu74BxIquFbbWGxjdfpthv8ka5OOrXKfiB
 WI5QT34xMhJRFRUiiI6HxNbvKsYlT4EF70a6P0W/9DnyhdOVIqh+S02q+TuiP0ozeipg
 28ZlPygMBdhiFG1a/hB4l3SBaHO7m8z0MLTl539Ji39ghWlUI5Zn3P6kSdkCrn8RJaHH
 yfGcBnzzEBsZ63wvgyldWYDBDGA9sOqyI0A1y/8B2wVB1+VxU+D5lbDuAh8IRc5TcYND
 aocuGzeYp2B55hj10bcFClMgxMZWwSwDskUQ8p+OdG4eJl+qf7In8bClwme1kEMiRDQk
 yfeA==
X-Gm-Message-State: AOJu0YzNWADJlRiBlIKrp+Rc9bDdab71zW6fXNP/xBPNzwTegecDMFMS
 WMh5p3htfSGEZ7DMhsnsanXnL7wFT4+UGcTVwXoTxuqcDsvijl2sJvY/EYAtsA==
X-Gm-Gg: Acq92OHKRyhIVCfwyjGpqU75Kccy2uPdSvQgEoAI//DgL+2BEvLBnQ+BUHbMywOnXE6
 8NVY1tGOOnbYc/FtrW7P0KcvlJ/z+Ge8WeJ3fBQQW8+nzbBNcv8sf2nqw/GT68c+ywANItHUqwk
 CbdaRG19adG14JjZgpLGk2vntlyxf5rmgMOUbie7/wKrx5P65QEZQ9dxatlyVIZx7G21nt12i+m
 QuyU3JHlPnYu0mb3wSjlbZ1PGI41L/5ACk1274iE72msUPGw1W4mW8J5n4vTFFK4+3RSHhNRoqX
 8A4Fyi0J1LBx6cizSyIBTHfayB1EWTV3hez2TzrfgWpWzoPzhcO3tpj8x2alhXyVSrVKz0DxGnq
 BbzusWfAoFvrPLaanhu8ZGLuFJzmzla0SjoUPsIWMkKi8etyblzwXnvLquBI9O6XZ2VZ4LAmL8j
 Q7byGRTvNv5JU/cDaOLgN/WSBV3FVGAo4RvReUQuA5RUccDmWN8msGVg==
X-Received: by 2002:a05:600c:3595:b0:490:a964:14f8 with SMTP id
 5b1f17b1804b1-492381e1c96mr15633985e9.8.1781723685643; 
 Wed, 17 Jun 2026 12:14:45 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:45 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/17] drm/amdgpu/gfx8: Stop CP and RLC during reset
Date: Wed, 17 Jun 2026 21:14:23 +0200
Message-ID: <20260617191428.1784083-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

The only case when they may not go idle is when we are dealing
with a GPU hang, in which case we should just forcibly disable
these even when they aren't idle.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7bd668f71b41..9fe430e3ae65 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4868,14 +4868,12 @@ static int gfx_v8_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	}
 
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	if (!gfx_v8_0_wait_for_idle(ip_block))
-		gfx_v8_0_cp_enable(adev, false);
-	else
+	if (!amdgpu_in_reset(adev) && gfx_v8_0_wait_for_idle(ip_block))
 		pr_err("cp is busy, skip halt cp\n");
-	if (!gfx_v8_0_wait_for_rlc_idle(adev))
-		adev->gfx.rlc.funcs->stop(adev);
-	else
-		pr_err("rlc is busy, skip halt rlc\n");
+	if (!amdgpu_in_reset(adev) && gfx_v8_0_wait_for_rlc_idle(adev))
+		pr_err("rlc is busy\n");
+	gfx_v8_0_cp_enable(adev, false);
+	adev->gfx.rlc.funcs->stop(adev);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return 0;
-- 
2.54.0

