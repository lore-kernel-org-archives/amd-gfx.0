Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7914CC43458
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jul 2026 11:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E730F10E330;
	Sat, 11 Jul 2026 11:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MliJ+CbH";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE8510E330
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 11:34:40 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so965533f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jul 2026 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783769679; x=1784374479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5LEHFGoeFWQTC2SbVcXkDWPFiHomBrxs9pIvaqiyQmo=;
 b=MliJ+CbHq+gnlFqqn8XGw5PP8jLgHjkSMeix06FWC7Dd5bpOTSDj7AqeW2uEvV6XZ5
 16wlH00yHAkbzgtnlEqJyPLnJmWay873N5oDhgADbM9v31ayCnlyWGsryWsyeTMdpPF9
 ARTV0ORW6k6Pmlgk5TSHN+k2e0zQehSZI06mFG+6E533X7KSmPxTw8t8VyuSKt5OZ9YS
 FVOQlJC/lbw3zywGeiWG++Cvae0yWigABr6AND53MyFMc5FcnHgTE7ayn2EDuyMwETE6
 rI5jQPZFdVoKTFDadV4Gb4YZI7eU7OlDlxvQTWsPibt833A633bMLOXXzNbOubkExkB/
 /Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783769679; x=1784374479;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5LEHFGoeFWQTC2SbVcXkDWPFiHomBrxs9pIvaqiyQmo=;
 b=JyfJEneQg1eJdbQ+yTB5Gp8cluzZkCDxOw9cx78LHV8j903RPSV0M4CygFWPP8wn3v
 fLbJoS+iRYp3F9nM7rTwnj+7BBzxM0MPUOS6jFjpdWniysa+0D9w6Fs/n3fCRzz1m53P
 3loT3qee+c5SOQqkJgbmEuVsG20ndabYsas1aO8irwfIaEm3NvjyaoF4Eg5bmQflDRkP
 XR4dfkwiv4SXQXUlFugIjqggzTW3Z/R5Qb0tVXKAYXAtBPj6omVu2lojsv6pu6nBNgpn
 haKdKF4pkJB3oaV6TsF3YPGUhKCgaJzifTS9rDrzzF2cBb2J7ltSN0tAU46z4NFDuA2B
 P2Dg==
X-Gm-Message-State: AOJu0Yzpai/7D8YWqboIP0gE9RLwKb5VJPZwhH2lUuKD8ogRpODCwH0N
 B5vdAZ+wbO6FeATvtPSwMaCFCtzXiXI1bnM5meTPGLccVf/pFyXwTFa5dHlvRCYs
X-Gm-Gg: AfdE7cnZS9XYtsq1I10lBVZCFkYK76GyLeh7xlAzx43M0cLXgSJ9Hp8b6RDl/wD5a8b
 DkyGXewnjknvZqlU1L1V0ZMklqS2vtjebgw6wNzeDYd1krchSHgRqCZuYdhohqCOI5kq0C7sa0n
 TOYmaYgQUOIhzPQKy5Z7I9y8BmOnWDJOAAD7Z0M9fLXMHxcNirqN0SYhToH6UQA4tEN2h+y+mZT
 duCxqBtK4Kr5r77HA0kfNlGQ8QOEd2OTMs2B8u8D04F6fqUFhcgye6RAUSZwLQV/LSxgy+2cadh
 2DDAycHD3+fhlwxHOFgoMKJVC5QiVlaiZLQKmYakCkayYYJTE2s0cVWWcEDTAZy9kAZ3T12ZyrR
 e9eVmsHQpTiafQhzVKjlxNT+5qi7OtYUwIJB9mUvWGwbvwZBH15vEmwkCHKUXw4PiOgORT66Yu8
 H1GGr+7L4j/5ziyPKJFJMyHCu/Cb57sj3wa7JMf9zXhnpNe5uWAEBgoA==
X-Received: by 2002:a5d:5f88:0:b0:475:f0f0:9ec5 with SMTP id
 ffacd0b85a97d-47f2dce39f8mr2394784f8f.48.1783769678999; 
 Sat, 11 Jul 2026 04:34:38 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm69401778f8f.0.2026.07.11.04.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 04:34:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, mario.limonciello@amd.com,
 alex.hung@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 =?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?= <viktor_jaegerskuepper@freenet.de>
Subject: [PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs
Date: Sat, 11 Jul 2026 13:34:35 +0200
Message-ID: <20260711113435.28917-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Always set native cursor mode when the CRTC is disabled,
to make sure it doesn't cause atomic commits to fail when
they are trying to disable the CRTC.

Fixes: 41af6215cdbc ("drm/amd/display: Reject cursor plane on DCE when scaled differently than primary")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5432
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..61b0b7531959 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6608,10 +6608,15 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	/* Overlay cursor not supported on HW before DCN
 	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
 	 * as previous DCN generations, so enable native mode on DCN401/420
+	 *
+	 * Always set native cursor mode when the CRTC is disabled,
+	 * to make sure it doesn't cause atomic commits to fail when
+	 * they are trying to disable the CRTC.
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
+	    !dm_crtc_state->base.enable) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
-- 
2.55.0

