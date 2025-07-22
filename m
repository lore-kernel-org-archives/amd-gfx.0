Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52809C87FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 15:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F4C10E301;
	Tue, 22 Jul 2025 15:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHmNVCBA";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB89D10E2FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 15:58:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3453508f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753199926; x=1753804726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQ0IXPGo5ddI4uKLDvUC1LpLO/476KQM4Z4vcCvJIUk=;
 b=kHmNVCBAw/ug8O0whQRgJey0vKtuAVF0iBuXKoQSKkGqWlOKbik8J3wPN6QI/l1rYV
 IhZiKA/1vflutMCamWoEKABkY/RGph9/CmQ7GYhU1ywfB1dJNi0JxNFLfdkZElOGcHAB
 dCUYlsPjupiatzUxIUsxmB1w6QJa3zTPp7vm1nXM4q1miJXZkmN7k6r+nyAkNmUntL9q
 V+g62Dy0Kvl2RwUS7amwoSQVsbu3Vcf4v4lT06c4l93mafhRe8AuNXUtCW6TPteKL5FZ
 FTrdOIDU9jpbhdLBl820w0zSWtj8jj3a3SIkyqhuoTuRkC4vn+3BNabZwv25VKoxze84
 QatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753199926; x=1753804726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQ0IXPGo5ddI4uKLDvUC1LpLO/476KQM4Z4vcCvJIUk=;
 b=eBOPpds0ZhaPhNlD6hcotYKYdg6oQyff1MAof4/1cdHFYSMaPdVWJq4lIOet/aTXI+
 Hb8c/LnBKjxkEJhSyaidDLfcQrqEX9C2nBSGhX9eofTT8X0dXuK8srbAPCkcBC2yq1xA
 nbRibCoaIgFGGcC9PNwPUQ0haBQ/mL8YODH7gWuvuFVR0EbthyIv7IXz6U+XqojXrjmW
 kW3eHdIgBU3VZ+6aM0Xd9LAO8+js8qZOb5snl8Gcxkb0PhmYnECggIIXXSL+W8YEpwwL
 jlC349GikYtOpg1NzIMtKqhVLHc1Qmbi3wXQtBPF0bbGWQnMLwvg1Kzve/heRRt33LBi
 +QFw==
X-Gm-Message-State: AOJu0YzmE1IgHUCpd2o5W5Hfe8o0Ue5JoNjqv/oULyUMs2Z8I31T0fwH
 U/lzcXlEr9rMkAYlp++YV+T38KYZlhW8YiCWLUzHQ/dIfpNfSXa92pu44hwCcg==
X-Gm-Gg: ASbGnctyIiOV6oICjLna3aUHl6Nfk1mbjk4QxCFoIRabwL3SsID52LFh6ftRIwjrkR3
 t67DRCjZZ8Hm76ssdgfOL5WCi06MJTvw/J3yA5hwwAonXqupFzOV8Wue3wj3xQDK1MCuztHSA5e
 OgFrB4+dQBZexcruYz/v3y9iKgqnrWJCHbte2ZnVM5EZ/RVP+Z2KSyDAq4vt/djOxSGdDQd0huw
 EfehEm9ifnc700mAndvzIGsilzyuCpCRST/Q6KfTpo38jFBYAE9NLewO779NUTzDxcuLI26I7KR
 jQobYZer0cGWGY52z9W886KS9K9zxcqv5VW/wJ/X5qjEPhpGBfKlcZf0fvlKE/nWkkZ4lzN5Aaw
 2vGUTV5ieXqyXxYrK/Y76T8slk8+vglBA
X-Google-Smtp-Source: AGHT+IH0mbpkr38wZO8RgH2t5+QyLad4CIdVgkiZNmw6DQz1aXnf63cE6BQN8tM1Vvk96bYclz1NFQ==
X-Received: by 2002:a05:6000:430a:b0:3b7:6345:c53 with SMTP id
 ffacd0b85a97d-3b763450cbcmr3818845f8f.51.1753199925874; 
 Tue, 22 Jul 2025 08:58:45 -0700 (PDT)
Received: from Timur-Hyperion ([2a0a:f640:1810:c696:604:c93:8102:bad7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4893fsm13948241f8f.52.2025.07.22.08.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:58:45 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amd/display: Don't overwrite dce60_clk_mgr
Date: Tue, 22 Jul 2025 17:58:29 +0200
Message-ID: <20250722155830.67401-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722155830.67401-1-timur.kristof@gmail.com>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
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

dc_clk_mgr_create accidentally overwrites the dce60_clk_mgr
with the dce_clk_mgr, causing incorrect behaviour on DCE6.
Fix it by removing the extra dce_clk_mgr_construct.

Fixes: 62eab49faae7 ("drm/amd/display: hide VGH asic specific structs")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 33b9d36619ff..4071851f9e86 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			return NULL;
 		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
-		dce_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
 #endif
-- 
2.50.1

