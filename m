Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC4C5B560
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1A010E6C4;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyeTa2Zy";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78AA10F510
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:06:41 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2956064f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786115200; x=1786720000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G28kgXcfjTi7WfcubT6ss2iDfVIyc9TJDmSGXp/+TIA=;
 b=GyeTa2Zy3Sux5cj69LNolJh+DFeMv6BXL3kMlAGEq/SC1C2WeVdlBM775fSwnrhwl2
 vcUNksSfEzKSKxSSAPN9yptjfPyahLw7NAHK48FgImIXjDv6cDcr5OTLOwXPTNWjIPz9
 VUoBfSrh85FcyOZsyWnq7tgmnIM0M5gXyEEaYJ5TfyJnYSo4K4la3edBvwPMyBAUVCVb
 y/DpN8ADLzKbVyuORAB/8klGXxnj9+7ObmRj5tduoYRmZlIk/QwazN+fd2E78iolSD3b
 +MZYonDojflur8b435720XlABoNtSvPYRDam6nG7+4VMqtxYtdSlMEbmzFSuzlcYPunR
 Xw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115200; x=1786720000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G28kgXcfjTi7WfcubT6ss2iDfVIyc9TJDmSGXp/+TIA=;
 b=UAWCgHBdBJgNVNyD7FTkScLmpK/MfM6/9OP3M/L6rbu9xYeIZ9o8CQQcs0IQ/BHbVN
 qG0i8bEB5ctkguEbLLqX1q2fD9e4m3Xs3vBqj/9LWDy7P8z7W6m7vy1EWMOo7G5s59vW
 IyTgDAI7CiNWfjMV91cy5Q0sL+Jj1iqEdLHNIsv5HDdtNVzBP9+5pMcuTZey73p1Cb5O
 FIER0zjVn/xvcHK6s5t6djQWDgJdxf057/Seg1SPPu1AL7yMfvGeGYTvj3xrdS8yaOST
 fZfGuw2Ni7Qe1Zrl3xlUCoMlEBAqgazYJycfosQwn49E1jWQVW5j2iEK2KFhAkOnPZl3
 LHkg==
X-Gm-Message-State: AOJu0Yy/AaTdsgtlMmjzm5t9vuJfsB24e7yU0lto0eMTEbv80JU9RnqY
 w/rUdNsJls4oRFvyAHs0dqxmQ1YXCfQGdmO6OuMFc1jnZi/qRrJW6BjlbLo9Sw==
X-Gm-Gg: AR+sD132v4tFStm441TN1jTCnk5m4HmGko9Aewpj7PsIIDXeDC66Dw6A+foI+DX+DJ0
 q7vbXvEf1/nmgDtQGr83kJOyi29ySLqvpyDvi8xUaHTCUZW1VngD0aU6FdcJBARmE3jFhMOnKQ5
 HWGgqaRpElVbvePHkUFdqK/70ukXaAp0h5CKF6PTN2WiL6CV97DUBGLa/x5jLbICQ2pS9RIgOIp
 +hdLYtACROQkkQ9eA+eEo6UY50jWz27WlAL6DzZ5h47tCzHqYCwHxOf4tmPr2FD6vMF948Xt92w
 Z5T6oNr6RUjgPK4lzMKvjMyEQvnHUiR5C9QsWhiME9Z0g0x4lE/jvAXgbQ5CCjZbSbL6eQUy98m
 e+Ni/J8PYmaeFRjAYmbynKlrqyyAj7SsuT/B/aPzvWauNrPfElGsHquy1S54eTWGlIz4fmGQ76L
 bqn5Z02AA4gxN1tx6m8KTiTxFz8+G8N6KmpisAqsUwHOlQNg3U+7K3ibopBzUbH+l1Dh9TPFXmj
 lc=
X-Received: by 2002:a05:6000:46cf:b0:475:3a97:8e2c with SMTP id
 ffacd0b85a97d-47fec62d8b8mr28368415f8f.16.1786115199830; 
 Fri, 07 Aug 2026 08:06:39 -0700 (PDT)
Received: from jessie ([2a01:e0a:11a7:6110:b562:8bda:11ee:8074])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8f33sm7237899f8f.27.2026.08.07.08.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:06:39 -0700 (PDT)
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
To: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
Cc: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
Date: Fri,  7 Aug 2026 16:58:55 +0200
Message-ID: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

amdgpu_dm_crtc_set_vblank() dereferences acrtc_state->stream when
vblank is enabled/queried from DRM_IOCTL_MODE_CRTC_GET_SEQUENCE before
a stream is attached to it.

BUG: kernel NULL pointer dereference, address: 0000000000000008
RIP: amdgpu_dm_crtc_set_vblank+0x6b/0x4d0 [amdgpu]
Call Trace:
 drm_vblank_enable
 drm_vblank_get
 drm_crtc_get_sequence_ioctl
 drm_ioctl_kernel
 drm_ioctl

Reproduced by running VKCTS with WSI tests enabled on RADV.

Guard the enable path on acrtc_state->stream being non-NULL, matching
the existing checks in this function.

Fixes: 34d66bc7ff10 ("drm/amd/display: Fix Xorg desktop unresponsive on Replay panel")
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 46d85457c77b..62eac6e65334 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable) {
+	if (enable && acrtc_state->stream) {
 		struct dc *dc = adev->dm.dc;
 		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
-- 
2.54.0

