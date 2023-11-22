Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4C0C61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 15:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CCC10E12E;
	Wed, 22 Nov 2023 15:17:23 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EC610E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 15:16:03 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c871890c12so62544221fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1700666161; x=1701270961;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k4la8UpxEoYpxdcxRxCTap7JavEAWyXMLLtxwyAIxnQ=;
 b=UrtlSFn4Ygqch0iabtfxj50BtgT95EyuY5qQ3Qbo5SNqK9ko9dlhX858+eoCJ3wwh3
 JuwBKaQzGRrxlgMl8W1ENNriw6WM8ryNuNRtdzf/XMoFK5CbuCPbHXoI0I7HnJKmZFlt
 UAb0eq4DObRD39DnB9Qwbz+KKYoDtsi9dyuHCw+fOKbS6UKtgCGwK5YEK79xIhkUZ6cC
 WjxGWLNf8Njf+ackZIOtqbpkcWLpSwxD87sWdo+n4sbPm64E00QH0SD60fcoTpsCmxNJ
 LKRNyjyBNSboSJfjK4bR6Tk5mk7lIsYyMtBwDc/oHfCEjIgcRa/IwiNwj0LaB/7HFaZC
 2amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700666161; x=1701270961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k4la8UpxEoYpxdcxRxCTap7JavEAWyXMLLtxwyAIxnQ=;
 b=lmiSOZTitSLdPLirAYsvmIX7xteUYy+ziCPA/4pRw1bfRpcNG9i0umotWF/0mUxovn
 5SxRdk7Un/LtB8piizwfPn7usFid+IiJ31Rj5V9miNJ6FxmUmfC2CUacf7nLS427ORyQ
 QV//p1KOCX21lEQ3lEFc/gxucRF6+TJKRXPJJdQ45nhZnTWPz+9ePtEDUFfs5D3nTH5d
 FDB9mQ5CphqZHIkQbPmBUCpzRkqDL8U0QslUGD1SyT7ozHZuRFR0JeXVQv8uV66Aqhqf
 Yz20+JUSb0JB3ll5C/k+3P+nDXBAMY9L6JtCPoI+MW1vPoS8zcYXVSvgbmIkAINk1i24
 /dxg==
X-Gm-Message-State: AOJu0YyUtugLJtOzo1YwetT9F8VFsAbyJ5E6ilx8FRXzpf9MDlltR7z8
 4jVJGXNywx0buEiY3BzBiBwnZOaWb7xSzFqrXQ==
X-Google-Smtp-Source: AGHT+IE7acJ+mrGKI8dEez9Jr/Q/F4Vd3LZiM8dT1TFVtj+xd4Ur812Xsa7Cv6FUQui9CyMjIrBpIw==
X-Received: by 2002:a2e:9f52:0:b0:2c5:38d:f80b with SMTP id
 v18-20020a2e9f52000000b002c5038df80bmr1914914ljk.6.1700666161007; 
 Wed, 22 Nov 2023 07:16:01 -0800 (PST)
Received: from belltron.int.bell-sw.com ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a2e8e6d000000b002c87988459dsm1084206ljk.86.2023.11.22.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 07:16:00 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: avoid amdgpu_crtc dereference before crtc
 check
Date: Wed, 22 Nov 2023 18:15:25 +0300
Message-Id: <20231122151525.66910-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Nov 2023 15:17:22 +0000
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

'amdgpu_crtc' is set with 'container_of(crtc, ...)', and at
the same time 'crtc' ptr is checked for NULL before and after
'amdgpu_crtc' dereference in args passed to drm_dbg_atomic():

  * when setting 'struct dm_crtc_state *crtc_state'
  * inside amdgpu_dm_plane_get_cursor_position(), the function
    doesn't set position.enable when crtc is NULL.

Considering all this, it is safer to move drm_dbg_atomic() after
'position.enable' check. It can guarantee that 'crtc' is valid
and that 'amdgpu_crtc' also has a valid pointer.

Detected using the static analysis tool - Svace.

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 116121e647ca..47d8d569d9eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1242,10 +1242,6 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-	drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
-		       amdgpu_crtc->crtc_id, plane->state->crtc_w,
-		       plane->state->crtc_h);
-
 	ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
 	if (ret)
 		return;
@@ -1261,6 +1257,10 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		return;
 	}
 
+	drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
+		       amdgpu_crtc->crtc_id, plane->state->crtc_w,
+		       plane->state->crtc_h);
+
 	amdgpu_crtc->cursor_width = plane->state->crtc_w;
 	amdgpu_crtc->cursor_height = plane->state->crtc_h;
 
-- 
2.25.1

