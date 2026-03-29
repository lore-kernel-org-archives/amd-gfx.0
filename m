Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACAAF3D5FF
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F2D10E25C;
	Sun, 29 Mar 2026 09:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A3CI5fT8";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8754210E0C2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 04:40:23 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5a0faa0d15cso3531472e87.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 21:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774759222; x=1775364022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mk52gQWQ3YwbPCH+HI+PLYhISpoSwXiTg6BTfM8lBMw=;
 b=A3CI5fT8IUY9RYmhNWDE60u5taRDhdKQKR1Dk2wG2aUKOyJmewSmhyxwnUXhJY1hcU
 hdm0BHzVXA2D0t2fbIRr5jz+CpofU5cWJCJVihcMoVoobkaFnp97vEwp8R0nZWR/SxyH
 UzgEpz9uooR8ePKICzmYTNY0ausxMYg7Ey2WtATsDogJbNafupDd9ktBOj0ILo9itqO+
 CkF+Bc/08/2pLVKuFMyBsyqOVBgajGlofR2AX9B11t5iW+SxrzTqzSedn+fxC6hcukNL
 LYrKf3qLYknnPIFdxolZAwFg9X9yx1wAED5tegU74WOBuOsNrf6itUhBjH7YSe+r3THE
 Bh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774759222; x=1775364022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mk52gQWQ3YwbPCH+HI+PLYhISpoSwXiTg6BTfM8lBMw=;
 b=QcwZhxhFQEBkjkDimVCkDwR007x4EaQcQLg7fmE+72mNVxeoUbYCslA71wPZJrQXRU
 +X83ebgXJ5QmgOQeOf+x+/sNuBB2YUlOrh+I6XGohzw66UqaRfPxdLwixz6ilgcK59KN
 UibgWHND2vZTwYBLh+A4g+uWrxy5fGvENoBd+C9qyaTpy8fOC8EEyFQMKRFZbaqCRC+q
 b4TmEg/3knDv+1ft7ZtPX+Pr+/uwH+I08ZIfGIEw6GumMytPXnGhUqfqwYiJPkeH8uRB
 Dklyv5STaMqBOncv1HNZ/aCeobs5jNAphWMY8VtBwkKZwKVYTaXqWUbJvssmx3qwjBB/
 WOuw==
X-Gm-Message-State: AOJu0Yx5HcxQsuyqzmkRwsi/8xe0oRw1UnE7B0ABKYA4TG+6dZd6bAWs
 teJPaEweKTYurQDjTM0z5nI6geEaLOZbB7W0tRaaAe9fFPBM288r0aROlyDet4U=
X-Gm-Gg: ATEYQzxTLNb5i3NAY86UTNcTBX3Ul7Nctr2urq3epC6/NJfFFX8AXjCrMQhNJ6nvGv/
 /Jer1NKxH3cVVpmr7BNsq3o6zJXqPzxDUHBgJ4FtBX37C5eOYGd3WSSAhat5gBKKEfpI8xfG7aM
 IlVDddRoT6KNQbAOe0fvtNNUlEffSiQ5xXJJ0ozRjbvPM+zB7IoeMcTtgrhOBIZdbZ0h7rxjt3G
 5DPmySxQNfUP7CHeuCGsKXBmk21LTQhQEhGDbrotLzS7zhDHFiIG/0KZjxUOoaUS5F39gQEWpdJ
 S86Lq0YUtC7AwZviOZmp67kIM2v944/7ufz5UbgDQJb6w5R8Ux0Zn50z4FBB/PjPvkquFcGiFjd
 UqU5zu+q3Zo5MdVvd/AjlCPBCPSJeTjdc4J/Vc/djlzV01QjdMe1vNx0oQco+EigSjMy01sxbiL
 4LLA767YjdO6PfvazyzTbRmiCwZDA=
X-Received: by 2002:a05:6512:4022:b0:5a1:5725:6194 with SMTP id
 2adb3069b0e04-5a2ab930326mr2715163e87.34.1774759221442; 
 Sat, 28 Mar 2026 21:40:21 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b145772fsm836212e87.71.2026.03.28.21.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 21:40:21 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, Sbenazar <voroninan95ton@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 1/4] drm/amd/display: reset sr_skip_count on non-fast
 updates
Date: Sun, 29 Mar 2026 07:40:05 +0300
Message-ID: <20260329044014.30276-2-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329035830.21953-1-voroninan95ton@gmail.com>
References: <20260329035830.21953-1-voroninan95ton@gmail.com>
 <20260329044014.30276-1-voroninan95ton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

sr_skip_count is initialized to AMDGPU_DM_PSR_ENTRY_DELAY (5) at stream
creation time but is never reset when a non-fast (MEDIUM/FULL) update
occurs. After the first 5 fast commits following stream creation, the
counter permanently stays at 0.

This means that after any full-frame update that disables Panel Replay or
PSR (e.g., a workspace switch), the very next fast update will set
allow_sr_entry = true (because !0 == true), allowing self-refresh to be
re-enabled immediately — potentially in the middle of an ongoing
animation.

Fix this by resetting sr_skip_count to AMDGPU_DM_PSR_ENTRY_DELAY
whenever a non-fast update occurs, ensuring that at least 5 fast commits
must happen before self-refresh features are re-enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Sbenazar <voroninan95ton@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9854,6 +9854,12 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);

 	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		/*
+		 * Reset skip count after non-fast updates to prevent
+		 * self-refresh from being re-enabled too soon during
+		 * ongoing animations (e.g., workspace switch).
+		 */
+		aconn->sr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 		if (pr->config.replay_supported && !pr->replay_feature_enabled)
 			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
 		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
--
2.48.1

