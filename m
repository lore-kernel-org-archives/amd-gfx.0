Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67927D711D5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4080D10E597;
	Mon, 22 Dec 2025 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PfHyICgh";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2002410E150
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 08:02:14 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so1976088b3a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 00:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766217733; x=1766822533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t0yjTU9k4zkkVGpLyzkoTzrEOACK8nCEpapOdu6BBUw=;
 b=PfHyICghgYjqdPFmK6VUhMyK7L/a6AQHnAWTS/mdzUproj50WdjSV1jAFxBmKoDZig
 bUGD4cyYmogiEOsTc4FTH8Wc2GvNE/3TSEx7EVDLRh6zh2CeLaAmaziJoPyeuue7wPKN
 hFkO8NgYIUA+wCte8UHuflggPwmeJznGnePE92lKR9NuuoCzobB0pkew5SxNWKZKtO+I
 PpLooL6L9U/sYxQerd40JB6wOfnp6ShdWJ0s0noMrbc2nL5lb+RCsHrxPH8ydbzIfGF8
 D5lvbZWtbZc70e0fsI4nVw03G9Wf1KxoCi8+eHGO6pocCTA43r/wlTANNTIFbjXL3OyZ
 AyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766217733; x=1766822533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0yjTU9k4zkkVGpLyzkoTzrEOACK8nCEpapOdu6BBUw=;
 b=fhJ2t8SRLCZwrhFaE3OzjUm6AKcQ59GcpcYTV9gNwEMSaSwDPKHz15pn5rWCh3lyOp
 4VV8G1EMzxvXyVcn8GzPjqw4/3i5yzdSqEgABMYZtnlBxhpjBre9Ifu+KJwsP1hv4CY2
 QMCd7c9XUSR2FPmgMJFQWqfy4v70/td68Vf2v24uS3fKpuqEhwUz1pPSQXqFaZyYy+8u
 zhJ82RnEQIfgS50ObxUzafldoExGObbUiw/PTw5W+xzgmIL86hxUOKQB7KmrEmmzQcIS
 CBqN5lBrItqc8Nv4JV+fGdyWcC2oA+KKmjOQqbPIhvtq9NklbQIgXpUgIJ/ITNJ9pDHO
 Ygyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5MiqaFuMNBvx5IyJSQUw1f8lr2tN99leufIaa+FE9kGTUhtkCfqVT/HpY0rLo+8HrVaIuguzO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG34Ni+1RMn00n3yHpZGBeOVRuxSkRbnbYJUPYSdSQliR9oZNn
 yE3ZlEukibxfYQmhos36xnA27dOOlugSEtw9JNsbKbDcQ2p+clTXeF4R
X-Gm-Gg: AY/fxX50dG2/bNYSA9vSdeZWWQl0DhwVbzIMn3xFHBr/c609pC1YjcDsTel7MrXJBc+
 iO6LG/wa0qfJYa3KtDgo3Vc1dNDUXip0iAyc8lN8Pz1VaKDIZd2tN76K9I6CInpgT7rmSHhmbHV
 OJRYEpZ+cnKaQ6i3zwO7cPDoT61hoabemSZj1kFRkBYai3L1OD4XhRIS4ikJvGEXvm4f/esTAl+
 mdmJFkUmO9ivy9khFEB8/aiD2WkfqYTG0OC6NM3ppdKlT7Eilu77gjXHYDt2HqY/tIySQT9KsC4
 teD+lyt40Y1Cx0VBFMvTC0WEImD82ECVut/u5gr/wJDgTl4Tj1xyrJGITQ29kPdV/3Zke0dIzqK
 B8kdwCzSQL/OolieDb9//Tp0NukT++kPdoHl6OzrE0fjlsXEVyR8OXOUStXnNzeZ7MHXiLiSvjB
 KZN7En0qPew7mRF5z+Kom+c1HEQChzRL7vwvW8hQ24WwbbIxSSGso5Rtoj6EkJUg==
X-Google-Smtp-Source: AGHT+IH29IOy31k2BtNarCe+9zp7xxMuT1IvtqtIgzk/XemAzrpP1YIyNNAYRCxAUgVPzsRp52n+wA==
X-Received: by 2002:a05:7022:e98b:b0:11c:b3ae:c9e9 with SMTP id
 a92af1059eb24-12172311f8fmr5580780c88.43.1766217733259; 
 Sat, 20 Dec 2025 00:02:13 -0800 (PST)
Received: from titanite-d300.amd.com ([165.204.154.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-121724cfc0esm17426947c88.2.2025.12.20.00.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 00:02:12 -0800 (PST)
From: Mukesh Ogare <mukeshogare871@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mukesh Ogare <mukeshogare871@gmail.com>
Subject: [PATCH v2] drm/radeon: convert VCE logging to drm_* helpers
Date: Sat, 20 Dec 2025 16:01:56 +0800
Message-ID: <20251220080156.1961026-1-mukeshogare871@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

Replace legacy DRM_ERROR() and DRM_INFO() logging in the VCE code
with drm_err() and drm_info() helpers that take a struct drm_device.

Using drm_* logging provides proper device context in dmesg, which is
important for systems with multiple DRM devices, and aligns the radeon
driver with current DRM logging practices.

No functional change intended.

Signed-off-by: Mukesh Ogare <mukeshogare871@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index a203992cb932..fd176034b251 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -121,7 +121,7 @@ int radeon_vce_init(struct radeon_device *rdev)
 	if (sscanf(c, "%2u]", &rdev->vce.fb_version) != 1)
 		return -EINVAL;
 
-	drm_err(&rdev->ddev, "Found VCE firmware/feedback version %d.%d.%d / %d!\n",
+	drm_info(&rdev->ddev, "Found VCE firmware/feedback version %d.%d.%d / %d!\n",
 		 start, mid, end, rdev->vce.fb_version);
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
-- 
2.43.0

