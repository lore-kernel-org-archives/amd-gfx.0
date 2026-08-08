Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C4C5AE5D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FECF10E6AA;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lShLWjyu";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAA210E04F
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 14:01:57 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso466332a91.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786197717; x=1786802517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
 b=lShLWjyuz05lj7sipBy3R0AYDol0i0HqzuZf0aZi15Wqp8WVRJE8dCaT7biOUGj9ui
 Iao9CrHBR2SkbCBio9ul896sMc01foDFVLCQZZ9xT4sqt8VguGAPtyzg+dCNwNdRdwvI
 ZBO4odlmIHhM7OZdx2zOQmP8VjRWokNBm/5IZAd/rFkCRroAfoZUDym0Y5JxASj95yYv
 D/BtIELUkMhXEK0MHPzFwnhNZ9d/7ERQJCwDTtrO+EF7oLYaJrmq6FmpaGyW1WeflFkD
 LEEjBnh0TPuv02Dc4V/caUJZhTFm6Z4gcuber8qpvXjY+YzpyqejFGhX7QhQORPJq0WO
 UlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197717; x=1786802517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LWQEkJchPYeC0ZoavYUr3xCkFVeRdSuQOuSKSluD+U8=;
 b=dbuBgWW5+0y2T294xA0PpK3cMt4b0ecJJiMFydFNLPpD3vMgHo87uIN0QP2mRjZ0IN
 i5/HqCkFhIq5+TrPsEL1+idw3t7QqKHSLHXQM7LUww6d1LWlwY2B8XIlAaUwGeJ4eU1y
 Ew8ZVd6ZxpV0Ulkx26AtoHIgtV1PPJ851cfv81S0QS0qgoGOS49vVcsIbpM3F3n8CCjk
 Kh7fMZ4o55itIEIm7CZHM0bNF5b/WltdKN4UDcckPLOI0YqHbRoOeEBy7rgPG2d8grmf
 S2WqtZzDsjMZxhSlUIi3r8j6VrU+RobZf1Z1s/+O0lWapjZQwfFctLPglue+NrJH7t4B
 D6nQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpF52OxQtm2eUc6Wh12vUrqztorLK28FRzj0brx7txjfBEx+6uNo/MC7ijEeHARoaH1u4UbA/ee@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwISC5kaCMvmeBjW4j+qCXOIavXH59IXaZ1WIb15RdGAM4znMq6
 NZEwd8N0ZoHPZJdZ+cO10woHDwC7OVVJeDbJTWVQkexjyOYxv/50YV46
X-Gm-Gg: AR+sD12V9656ABytevSdc/d9M/jTB1ut81PmcCF6JwYUowH5hDt2TZLoV1g2dl2+WwD
 id8H0vdkx30tp1Rrl93U2z0gW1GiFezFWOsjhpjFB2j8AZ4JKS1NKaohm+7DHjbCh8BIUzqtF4Z
 u0mac+ngmdL2LIinq028u70kGJMVxeiF+O45Uq6ofwFbEdE7rYx3z3F9PZ2PPSIess86qqo1s7n
 OqBiuQdy86eVkVUWiAD4C6A6PJodgdIuJE2yWr0rAFeVvQ3pZjnks7K8EVWp3yRU4KJ11wq/UEE
 VPneoYaGXk8JihXi3avT36NIGl4DVyO1wvT0asLLKtQCAfd4qUCamkDq/yHatHIb0rszsPhW7os
 qnF9OuGFz45rYHJfkMB8CO+XzJAxl8Sgb8OBBI0lL4s6MmXsQLh6wH/k2Ihs6NQ8DhXxbg3/Ku0
 H89Iwf97MFH1NizrmU/KvpxvA1vK2QIPaliw6xCNNRmCk=
X-Received: by 2002:a17:90b:3f43:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-3903c54302bmr31739321a91.8.1786197716470; 
 Sat, 08 Aug 2026 07:01:56 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085dbf82csm8638162a91.1.2026.08.08.07.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:01:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:59:42 +0800
Message-ID: <20260808135942.2880971-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
devices, but radeon_driver_unload_kms() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
unload path.

This issue was found by manual code inspection.

Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dc43fd790a9c..4a99c09f4164 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
-- 
2.43.0

