Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80988C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 14:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CAA10E193;
	Sun, 18 Jan 2026 14:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRHqIoF3";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB62D10E193
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 14:57:45 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b874c00a3fcso572086566b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768748264; x=1769353064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7jFigC8qdbCmuCsWDSOrySJ258CloRAtOqLZY/8HYwo=;
 b=NRHqIoF3rAvAItH7hSVrIIAuYSC9c1vB/lJa+z+Wcj+ISx8+IWfUQXMYvcCDAVjphq
 e213aIfvjj4AQnanO3vwJgXL42PolKUcB0vBnYtqZNpaiuGak1e2qRhOOSvcZ2ChG9Fx
 +gxGn6kY6yQG4OOnkJkWpyZMEXNLnWa4bFhkI8I9P5oqrZ17546ShdDfz4B+VHw2IVbs
 Q9YJMMXru0Ixia7hywvPss7g2c8AfY8Xksfi+TAUPKlxMUmLSJkSH91QHVKGqCCoRYK0
 /ObMnSOkdhjhndntCWJthD/XPE6Yb9HUuwx1PCfJEuAj/La/yjXaNk3XVw9iXErGdQjz
 WPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768748264; x=1769353064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jFigC8qdbCmuCsWDSOrySJ258CloRAtOqLZY/8HYwo=;
 b=ppksN1t5PUr5Az4sz+KZ1XKVnSmT/G7Zbm8JXhS3wF9AHT28gB6JaomNFBr8fc8faY
 AxekvhbIFGsDTokpT2MC8BdpBu9WanHynf8xfNYIfsE6fAb43bj9GWdy4zXh3Mef13lS
 Ycgvy7U6h8yWR43ABrgEmi4HB1+QxiAo0+DcuYaqJOK9vXL7WleIECZv5w7D+znSzg9i
 10gardcJwQPVWcd70aUqQtAlnGN9oSBFjNQroX/IM/kqZWmhmwUcHkUn0lFb1+5H0DLt
 Cg70F8LjiyQ+wKuLoa8B82hXWTiRufi5bgTblRedrtoSJhEMqvy32dG/qxqYeUtJ2Y1e
 L/sw==
X-Gm-Message-State: AOJu0YyNySev7MZpNz8IISy4JIhRVA8W+t3X9fyKBiEDdQ2cskWm/ItV
 mAlbKD4ayeSEToQrytjGS5x3eekOO95O3Vw8PA0jaBod3t9HQr33lLT8g+z12Q==
X-Gm-Gg: AY/fxX4C5t2/rfz4oUt4EWZxeOi84Yv8QEQce4fECudF7PsN3KOsPMMiuXinddPb0W6
 qsa1N/7x+Y/BPaVbYKaY/JpLjxYHhmvGVsJt8pk+A8RhFKoMPJBMZR95zytlyo7AQgWWmNGKUEM
 jqpBcVrBa4lSc1H0MxdX3wqPUma7sHVwmVhwNOLHfDtXJMrAZnXplZU7Xfi5h/5heJY1jEqNYj4
 1MWrTH8dmh2zEqxPG7sWDm5MxIyIQ8EIvhJoF7yWd5dOCF3IHan29mAiXwytZcojYzkCOL6S9o3
 jzIrVVo3U8Cb8f6vlynwmrPov5tnmzQjP4eYqjslDAGWsoAWI9K/KLsTxNyO4HDB48MwquvUL8L
 jvBltHZIoyadnaIJxFF0Ynbo8CvGWppt0yjJj/NfRlF6r5KiYmRyQ/R19LhI5gTllPHZl8gCha5
 B62IJojMtxLP+/OreFCp2hWtPokHt0UcTTAqeuhwUFRp4FS6qia24/3GyphSstWFPkts5xC63vZ
 OO3CEwHs6jc
X-Received: by 2002:a17:907:1c81:b0:b76:bcf5:a388 with SMTP id
 a640c23a62f3a-b8793040ba1mr778077266b.50.1768748264067; 
 Sun, 18 Jan 2026 06:57:44 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fa4f3sm822660966b.50.2026.01.18.06.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 06:57:43 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Reject cursor plane on DCE when scaled
 differently than primary
Date: Sun, 18 Jan 2026 15:57:41 +0100
Message-ID: <20260118145741.36198-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Currently DCE doesn't support the overlay cursor, so the
dm_crtc_get_cursor_mode() function returns DM_CURSOR_NATIVE_MODE
unconditionally. The outcome is that it doesn't check for the
conditions that would necessitate the overlay cursor, meaning
that it doesn't reject cases where the native cursor mode isn't
supported on DCE.

Remove the early return from dm_crtc_get_cursor_mode() for
DCE and instead let it perform the necessary checks and
return DM_CURSOR_OVERLAY_MODE. Add a later check that rejects
when DM_CURSOR_OVERLAY_MODE would be used with DCE.

Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4600
Suggested-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 655c9fcb078a..3e1ba5521f2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12262,10 +12262,9 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 
 	/* Overlay cursor not supported on HW before DCN
 	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401 in addition to DCE
+	 * as previous DCN generations, so enable native mode on DCN401
 	 */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0 ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
@@ -12585,6 +12584,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 * need to be added for DC to not disable a plane by mistake
 		 */
 		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
+			if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
+				drm_dbg(dev, "Overlay cursor not supported on DCE\n");
+				ret = -EINVAL;
+				goto fail;
+			}
+
 			ret = drm_atomic_add_affected_planes(state, crtc);
 			if (ret)
 				goto fail;
-- 
2.52.0

