Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE52606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aaLLfhq3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBAEA10EBFA;
	Mon,  2 Nov 2026 08:06:59 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8671128E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 16:43:44 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdab9e9761cso581389a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793378623; x=1793983423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=aaLLfhq32urUxAfjcRK7e1T/WG1fjeRNA2SX/xl6sBs7mCTbeXJ8p2ZBzIohKA9q0a
 b36ZG4ryDflnxgo1NUvYTNyWxE5QA6KqyK3fS6fmmSJnOkmDhTrEyyCTHkpY4WYr6ljd
 eO57gawE2xML3xm/mXfoClvWZydn+/rRn5UV3mFYJoXc+drBEIs52P9Fhi9iDvdNu02g
 oYLxXmxNlaMHgxtSAZidYEbN2HwB77E014bqbVTR8w1HInJu9vnhpAMTBm+ny0yVzFEa
 hG6zJlm7U0fOJS1JUVP42xE1z9iCQNuaErw24JtqeV7K7mJVaVeRVU4lS/ZddurYpfPa
 sNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378623; x=1793983423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvi5ysW072lSJORWkYMVzsyAYOUWuxONOWbZatRvF7Q=;
 b=NxGLL9EyMMqEbz00I4b4EyEAB4bso6rLTiJBwisg07aJ7h0gLza32MV4sHkuIFx+1m
 xS76GESZjX8aK8vyMi7DZ9j7VUxhda5jSDIdJqbx33mWpb5E/LRAr3uogb0GwZtISBBb
 09IFq/U5BDzTuedU4flRQuOoQb7TEEce7HUukDOEW+GE6RYMn5PQgfZGsYEp85hNOxU8
 SKbTaanowWYyvDr8I0z93sdM5n0emZciZ+H3BwlfsudSP+w7bYt0RARfqPnpfIQZdgmm
 nND1YhCj8MhoHUnLsOEdCdV9usncNMiZyq7wKSeQezeML4zTRc4I+9mAHEzJEzH6M15H
 nYrA==
X-Gm-Message-State: AFq9FYKiAvxlxCM6pwmGH1S3/VyfCeYNGOQjdLt5aQiX8brn/5gMQNMc
 g7cfB6PFkMCOna2dtmOoyZagmtEAX5ehAJpRqsBbyB1t9bA/p3OJkU+HNLrqDQ==
X-Gm-Gg: AYBFou3I11cLO/hv3hsXBWF5x6iizs7YdQ0QzvPiJ6/uiUeKTLa2pev8P4EPl+6dsP2
 W4hvSjZDCUs9d1b/FVJs3FVaIffwvI6vsThFkc5m86JounWCccdiTTl8QNxQyrckugrlkDMTRrz
 pAT27hm7PtygoWtkcx3u47TA4suZCmp6UfOvxPd6YXcWPCj/QC0whMamkYEjUUTGUI1IvoF8hzl
 veVw0bJ+mvzDaEivuY1PtkOQyznxbRoMd3vGJNjBzuQEj6nQT4O397zc14Uha9F70dqV1/Br2MT
 I0RQaaEG/HPDw67ap4A9bJXwe4H1q2HDQK0VdecLSkTdxvq2JckiKFto7vhZ+vp8cgkO3AtAyeT
 Z4u5sTtKvr74XxqQxArM9me9HnNzkC7p3dQnH+IwSPVyMm3F84rohicmYeR9Pl28QX8piYErC3n
 nwpFaC+zk3gzur6gtEP2VUtW1wmKRG8XQJcHjPi7IwYBv6TphNyw7yNLidE560kD+X1H1jWJPvF
 bKbhNUK4tHdbNL+pM8HQJIcP3zTk4rTg8MYKDKXEKAFwpWfjLCXqq9t0nZhOc38LHTEnIKE/qWL
 7Zh21UMrAICZmtUMARwd0ycSAhk=
X-Received: by 2002:a05:6a20:2447:b0:3e8:ea76:9825 with SMTP id
 adf61e73a8af0-3e92864603bmr3245757637.4.1793378623433; 
 Fri, 30 Oct 2026 09:43:43 -0700 (PDT)
Received: from DPBox.lan ([45.207.158.52]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada9ad592sm245652b3a.50.2026.10.30.09.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:43:42 -0700 (PDT)
From: MuXian Chen <a18165943161@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch,
 MuXian Chen <a18165943161@gmail.com>
Subject: [PATCH] drm/amd/display: drop RGBA8888 from plane format lists
Date: Sat, 31 Oct 2026 00:43:27 +0800
Message-ID: <20261030164327.8461-1-a18165943161@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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

