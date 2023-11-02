Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03EAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 04:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D64010E7F6;
	Thu,  2 Nov 2023 04:22:07 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB9D10E7F6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 04:22:05 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso3745635e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Nov 2023 21:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1698898923; x=1699503723; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZwWyspK+XPCtmA8GrXQiGYA1eOJSYOJSKoXN9b/7Gc=;
 b=JJCeftjG6pk4+uo5T6kRQEc/JK/sCc2rsjICy70/frZnZee3SC0mxSLTD8Rt1dLAig
 tPvRkiLKbksh53qq5MZnYEwBU0Z7bNHwLjQ0xPJI0RY6tGFl+FW8aPYPY5Br8DCmtqPR
 GRpiJ485qSP31h3Yo13Oq1cZR1UA6rFcOTcOeUqae3CVFOc/ryMSpibWeCvgvyHlj8Gg
 +663GkKSY+HUiUTUMAr14nMpSwUrmNpxfLb5CMEam010hcBxK+h4AU9zWiPgLvKgFKZM
 JoOHJZc2V5kgniVOXT37aLwgc+57IH8xYq/9nHZ/wVlwfWn8UJ/LRmGaxqRSDCDeLm0H
 qM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698898923; x=1699503723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ZwWyspK+XPCtmA8GrXQiGYA1eOJSYOJSKoXN9b/7Gc=;
 b=fdZKgbWEOxoQtBTQV80ducDvsZl8RqR9n0E+zOYfciMyPI7IfLD8ooNGm1Z6StX7gK
 CRvOUfGS5Lagr32IuyaqWP0NEYteUVhK/jvpquFM4at8+F1q7FLN28KW3HHGa+kUUPhq
 p8QmVEKgaI0FLnHdHyOo9/3Y8RWAncpHwaavSe/oXBwwz/dtdWWdgKlUKXJ7WAxsvUj+
 hOj0s0EzunSmA7F9za/w9JpA0R7UwonyBSx6DNDKCmPMenxaKGJAbQItBu2gZQKuavbs
 yYrOIry8c1FHSfB1evI7NhjsU6V3XnAeAFXDFUG93qiMlYiLCLCS9hTgQBjI5sLE8ccm
 q3dg==
X-Gm-Message-State: AOJu0YzyJQIDC4JuDliyfKe+ZFGqAakx9aVWiMGy/01/aQzk5ORRxfXL
 pmOvjDSo8v0VqFvtqzJnkCWkMn8JVKslCvYlBFBjUA==
X-Google-Smtp-Source: AGHT+IHxSmLnkIFR3Hgkcm8PiDMcVFmR9I/PASgEnVYRktwvEbzW12ONifqo5KAvL5VY5tZA4c+v/A==
X-Received: by 2002:a05:600c:3589:b0:401:b2c7:349b with SMTP id
 p9-20020a05600c358900b00401b2c7349bmr15237258wmq.7.1698898923162; 
 Wed, 01 Nov 2023 21:22:03 -0700 (PDT)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b004068de50c64sm1432553wmq.46.2023.11.01.21.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 21:22:02 -0700 (PDT)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Set color_mgmt_changed to true on unsuspend
Date: Thu,  2 Nov 2023 04:21:55 +0000
Message-ID: <20231102042200.2070333-1-joshua@froggi.es>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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
Cc: Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise we can end up with a frame on unsuspend where color management
is not applied when userspace has not committed themselves.

Fixes re-applying color management on Steam Deck/Gamescope on S3 resume.

Signed-off-by: Joshua Ashton <joshua@froggi.es>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index adbeb2c897b5..ae650707f234 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2967,6 +2967,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
-- 
2.42.0

