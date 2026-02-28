Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F48FEE4CE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 13:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6033C10E4EB;
	Mon,  2 Mar 2026 13:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZnD7AHqN";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDED210E27C
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 10:00:58 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43987b97701so2237342f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 02:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772272857; x=1772877657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pi+GFLSwi3pjYjAmI89JNYKtrRFb4ualdoW7/2mbzi4=;
 b=ZnD7AHqNc7cbg+Z+YVkEYv47gUQ37WjMXDBsgXk3waZ2tcWI4J0RBoh1AiZAn/pkBD
 GS7U/dxexhDfW2+EhBLyMq5e1z/kjcKXlqUrSlIJBcbyEuMT/Mg9Piy0k8G74nWD2CJa
 FV4wi9WhnQdhnB9GOgi9whdA2QFwnpkIyh+8NhzC6fEyHJI9UGRCFAN2R9Zk56lvvhpx
 tUjRxSu49NzNtU2a32QIkJtZaxaQhAoJfqY4yUhPmRFe3lt57m9IwivM37I4uI9lSLjr
 zKEgS5yzBhRurVrd/I5pf7bJnL5j4/kwXDixWmwQrkgBnpyUzKPeLmN6SavbNhA1z7aW
 fMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772272857; x=1772877657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pi+GFLSwi3pjYjAmI89JNYKtrRFb4ualdoW7/2mbzi4=;
 b=HqgxuZ8GjO7+II3N4NAk/ejlaNjZQmbbuUa5KVaqIl1uun76B87PN+M7BBXbXQu+Qx
 gNHE0VDgMbgm1S6izR/NAL3IkYU+SybCidVQZ99/8DlZOrZcwYC6Qjt9+W+2Vuap7DMH
 f8H+L4N6QOsWH0PzDS9FLBsdsewEkpAbGobGL8+/0G1bY22IBii87pwzgnLfQOaIqII7
 v/hECEIDmqzM5IiJ7+0tt4I5ivjdYZVk5OvwXmM6MHbcvw2qb9C/UZOeGK8aa6xBGK5N
 tJHM4M79T4ejWgGfDgpWice25jJwCiGUuDaryiDHupth4EfodqYl0KmtFLlqIeMRP/bi
 l1sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUestu2diypvtYErtohc3HIRZwV5O3mq8S20rxcbB+AcSuHx9cFECBxJ2U7IDixCnIxEw+ZJAoH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/J6gNBOCTyXPcDHtJtNhJRycaZlMZnIpmlCtyd7idvyljemU4
 vFOTRPbdjEEAKtVXh1JJevcDA6UsdV6vb9RReQnD7aA4NicBgIxH1cqb
X-Gm-Gg: ATEYQzwOnChjVk2nOIWlCf/tJN9SahGz3Q/NDt1pwXzAfngW4X7GBgLRz5ZOPd7ADBI
 4UxpMEBWbyp2UxcMAlrKojAJ82/RGAcMLE4SkRf5qCHHXGhfE6uXjuUfOXBrCLO3vqUKfbkqbeq
 xXCGjmlx9T33bZ0paRNJbAnltN1u8UVLO+1eRFwlylo11M9jUANHHkqA3Kx5+EthnPmmbV6irKZ
 SBMOkq118nPga5TDAROhywrvuK0VU61kKEYPykC2aTfZaG4T3HQcR55wWAOD4pDE95+q51B+Nwt
 Hhf2V3WRj6HIx543avbywRhxSOg0TRCecO09CTK26av+xo9AzXSkI+me2eZ8+U0W6u9dAv9Nzp7
 8AvhCn4nRGEn7mSB/TFUrWya9VsGrNwMcjvzsyPjbqkgqQxR3Q7boqTZ7l3SGzStNA/qJhrw8JF
 3G8DYlNdDLe0aog+VJXCHwPw==
X-Received: by 2002:a05:6000:288c:b0:435:b7ca:7521 with SMTP id
 ffacd0b85a97d-4399ddf211fmr10631779f8f.15.1772272856846; 
 Sat, 28 Feb 2026 02:00:56 -0800 (PST)
Received: from localhost ([87.254.0.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a523sm12770570f8f.19.2026.02.28.02.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 02:00:56 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: remove extra ;
 from statement, remove extra tabs
Date: Sat, 28 Feb 2026 09:59:38 +0000
Message-ID: <20260228095938.548728-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Mar 2026 13:48:22 +0000
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

There is a statement that has a ;; at the end, remove the extraneous ;
and remove extra tabs in the code block.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 71cfc623bc2d..f3fa8eb4bcce 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1165,9 +1165,9 @@ void dm_helpers_override_panel_settings(
 		link->panel_config.dsc.disable_dsc_edp = true;
 
 	if (dc_get_edp_link_panel_inst(ctx->dc, link, &panel_inst) && panel_inst == 1) {
-			link->panel_config.psr.disable_psr = true;
-			link->panel_config.psr.disallow_psrsu = true;;
-			link->panel_config.psr.disallow_replay = true;
+		link->panel_config.psr.disable_psr = true;
+		link->panel_config.psr.disallow_psrsu = true;
+		link->panel_config.psr.disallow_replay = true;
 	}
 }
 
-- 
2.51.0

