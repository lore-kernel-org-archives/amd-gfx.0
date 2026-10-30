Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCD606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0kmni+I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F22112957;
	Fri, 30 Oct 2026 17:18:37 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A53112944
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 17:18:31 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso686683a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793380711; x=1793985511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=t0kmni+I/cJiVoBqkLrTzjq0Vf4hsOCRvDxIvYRehk6jpFoNXvr/zI5nUnViAvROFr
 sClPkxtQpfUn62N4PE7ogWS4/CaYx0V4nw89eiC3yfJKtFWpJNtA2HNP1nPUhSsARH9P
 BNml0wuDoDMnEinJVLgSsZQ0wtPL8jRX8ad5q6rsCsXEDfHZ6Xp405F/ur+h/X61gr1r
 FDvfzZ9UJbH627N3ZFMcL+LMvJfLO0YN8cgOyjOXIGBlMGz9g1GSuSt+MpFUBSnOIg/k
 ECDpXYAwqSNJqfy45PjKth4KTbt+rpso9Q9fTwf8wjN/aCXU/HRgV4Jsdtarkjh4n0F7
 Gmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380711; x=1793985511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=cS2n8g2hVKL8oQ6iZg/uvCyD7srhy69hxhi7kx5Fxo6hJX/tB6jbUYfq0nGRpN8amG
 v/NzJcRDKZM5DtvXWRnTvtWn3SIRU29eqovds8tKsIcEmrwjgegGS4mCGyrB4JsgpUqp
 Gzf2DlAHmxpdocxJopcCLKNjv4+0Xvh4/Yx+KQdBnCzHrHxmQHlCZA7/NA37GqTFORgb
 xvkDpTiBdglkZ92GypZmoLmCpA8MN2XKo1kV6vodY4TgKIvAseVwiA4ufGXCI22EVR2K
 oH9P0WOHjBrlMCxF8fXtwkuaxKHj0ygFCjHAQz7qjaHU2dv5ZUjAH6xrRkha/F2kALCs
 58gw==
X-Gm-Message-State: AFq9FYL1V9rsEuNJQDrbSS/aLjYDlsjZUrOHS/LSu577Yc8Ly8T3tbzo
 lNZmMZ+K65a6aW2R29tv5tGaADkQ2nKalxLESzfHBhbTGOSmJXo/0BkgpZg0zUe+
X-Gm-Gg: AYBFou0Hj6riRz2C9SvHux0N4bkpsTzuQrawagg42NIdS3tDmaGTXWJPCcemUOVOwD1
 Olm5hX+HqbT/qhh1ebKkALCNMGOUpHMIm2hF3+D8biyQwjqa3pilYaS2HvkCxAAcGMU+OiQ3rGp
 qMLnkvTBrTBA4J7pj/WImke56UbIJBHD7WSztGD72YQiTMoavauFTjeJMlWhIDCW/ovmw/lZFUQ
 RwxhNxDfcw9z+XX8Az+RvQTAda0LTBy+KWCS26MUConQBVM4j0l+nU7uAz+JXjzR7r4eLveWh54
 YB+g0JTrEoJt5FALwe2XxA/4kBWg/1H/nBkLn317hEIUj+ETXNg5bJPF/VCOy1hgqwXynXsknoq
 xpnGaQQtW4jdWpFG8cl01qLDkk2V2ynQbRle5VxFWkJc3eL08rJMYlQRIKDQA0XYYLZOpK8pYXH
 02wZpjl15rLwKXcJmDEv1DfEq0OXxVgO9X0Y/TiQTusP0R+stduJsrldLKdqt7YWA5C8PHj0b0d
 gqJ4KFasU0Sjc1JbsrM496AeiREZ+SIaa89STOzOFPtbQbIMgwMeBn2UCoHIyjtlCSMAjsw5Frz
 WrRVGMMEOzCV2SY8INrXh3xqozs=
X-Received: by 2002:a17:90b:390c:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3ae8985c4e4mr2415454a91.64.1793380710858; 
 Fri, 30 Oct 2026 10:18:30 -0700 (PDT)
Received: from DPBox.lan ([45.207.158.52]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm4762387a91.3.2026.10.30.10.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:18:30 -0700 (PDT)
From: MuXian Chen <a18165943161@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch,
 MuXian Chen <a18165943161@gmail.com>
Subject: [PATCH RESEND] drm/amd/display: drop RGBA8888 from plane format lists
Date: Sat, 31 Oct 2026 01:18:16 +0800
Message-ID: <20261030171816.11610-1-a18165943161@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DC's enum surface_pixel_format has no RGBA8888 (memory order A,B,G,R):
fill_dc_plane_info_and_addr() has no case for it and returns -EINVAL.
Yet rgb_formats[] and overlay_formats[] advertise DRM_FORMAT_RGBA8888, so
compositors (KWin on Wayland) pick it for layers with alpha and every
atomic commit fails once per frame, flooding dmesg with

  amdgpu 0000:06:00.0: [drm] *ERROR* Unsupported screen format RA24
  little-endian (0x34324152)

and forcing a fallback to composition on every frame.

Remove the two entries.  No working configuration is lost: a plane that
advertises RGBA8888 can never convert it in fill_dc_plane_info_and_addr(),
on any display generation.

Tested on Raphael 610M (DCN 3.1.5): before, ~240 atomic commits per second
failed with -EINVAL; after, the plane format list no longer contains RA24
and dmesg is clean.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5339
Signed-off-by: MuXian Chen <a18165943161@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 9139823..6d5454f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -49,11 +49,13 @@
  * For future use cases we should either initialize them dynamically based on
  * plane capabilities, or initialize this array to all formats, so internal drm
  * check will succeed, and let DC implement proper check
+ *
+ * DC has no surface format for DRM_FORMAT_RGBA8888, so it must not be
+ * advertised here or in overlay_formats.
  */
 static const uint32_t rgb_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XRGB2101010,
 	DRM_FORMAT_XBGR2101010,
 	DRM_FORMAT_ARGB2101010,
@@ -70,7 +72,6 @@ static const uint32_t rgb_formats[] = {
 static const uint32_t overlay_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_RGB565,
-- 
2.56.0

