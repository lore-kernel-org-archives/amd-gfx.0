Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7DFF3D60A
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D892E10E136;
	Sun, 29 Mar 2026 16:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D7DVGXBW";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA6210E136
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:15 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486b96760easo40554535e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800194; x=1775404994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85F1z/m3nChnr58/BSQmxeW/kxl7jQ4FEp1bTyRHqCw=;
 b=D7DVGXBWwEXUPOxufpWy7+0ZjDofAOHn+dr9ObQ8bjiCxWmhMfQ2hoLWq31S4A8YN2
 0i7TWJDNBoSZqoe//Y3kxF64UmpIq+NXuNCSFzFpVmQLS0eZKUuKXYxz5HfdIIqAyKk8
 gajCRxI5xBQPWBV7TP1HKwJAXBM601Ik8JBnanqj/f2MzdE8KbhahpPzMOaDol7Vk0xj
 ITt7pl+w2GZi/rP/1kq6reA5YBt7A8hMVsdXTVrIVW1wqwcqo3JE+aUIR7dSCSr6jgbx
 Y1T3TFlUJ4bhu9iTTthEwcMkbwSeQO8z2NzcSEyTpQGeIc/6jCGMjaHpPO3htbHzJyKX
 XZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800194; x=1775404994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85F1z/m3nChnr58/BSQmxeW/kxl7jQ4FEp1bTyRHqCw=;
 b=JJlWBSdbWaYk6WufH8uSH9J8EupEybPegTYv1OzHzdoCqB5nI35zmjIa1d3CNCzv3R
 KCq7T+TU8eYr1+yyFww9Ty7Keb0BvnDHnO7FO7BLtNb8HRsPT9dJet4RXDtokZA/1cKd
 p2Q6Z7ORv7A4Rrbu2L4lbrM8Ttho8rP8EPoLEwL44FxvGhoLzCRRZYUqWUhDEz626oHp
 0Zb4CUEBPupeKT0qhID+JGLFw79xxjKOLq8dvhzqG3DAiG+YVG6LstThhg/39mkKoe0C
 B/iA7PuILxoe7yBQDw/UVCPRnuAMOQ1zlU2epKWeRoCGlRUq+qd7vbhzrk0zBeUSdixs
 Vk5Q==
X-Gm-Message-State: AOJu0YyCpRubl4AELlJq7slcSN0qAp1HzdFlOLnHZ5McYQJDGzwAI0H7
 /VNduHDaEYPlI41CTYBr2TzJhhK3MPXblL4yQWBUIpZjC0/AYGy6NNz5EH7YuA==
X-Gm-Gg: ATEYQzw/mAQ0zygVmccUN85xHccGQ0QwiQttYxpO+J/dMN97R29KQ5IMAZzoRyUsUqQ
 UlNBtkgAvp1O85OBtTOyTfNHrj0mm9YQ8vEZxL6cXClwjYnAb74E6xTsHp/WTGPWNSJZuxmrH6V
 5CS7MP/+B6b6M9ByDOXRJo/sFgJ4u7E4DkupXeeUmaKFZ2JFw3SKqkJCNLqm7fEQNZ+50CJ64J4
 JD2gr6MXvM4PYpztCLD6s3/+ymecsKbaswR8uVAEEOg6MllUMvPhI3KlA5hALxhp6H74A5vx4BJ
 U937Joomoo3cbcPP8z1uqk8ATfFhHEGGTralws0L+Lc5T7E/Gv/hqKMv1rhbIgZG+sCOw0WWTww
 Dndahd1zbqsJ+BypQuUzYF/3D77FZyxJ27bKILu/AORCTd4KLUm5mSlGoMrENy+veiU/fy1VLS3
 AStf4BjVQbhV7mrOKmBNGFRCdemgGxleZEIlryFTGaqY3wLKwkJIdXPvHCoryi3+V98OI=
X-Received: by 2002:a05:600c:621b:b0:483:9139:4c1d with SMTP id
 5b1f17b1804b1-48727d87f18mr168594455e9.14.1774800194122; 
 Sun, 29 Mar 2026 09:03:14 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:13 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/9] drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
Date: Sun, 29 Mar 2026 18:03:02 +0200
Message-ID: <20260329160306.3417458-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
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

There is no AMD GPU with the ID 0x66B0, this looks like a typo.
It should be 0x67B0 which is actually part of the PCI ID list,
and should use the Hawaii XT powertune defaults according to
the old radeon driver.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 858f118130452..6382dee5a2ba3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -245,7 +245,7 @@ static void ci_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
 		smu_data->power_tune_defaults = &defaults_hawaii_pro;
 		break;
 	case 0x67B8:
-	case 0x66B0:
+	case 0x67B0:
 		smu_data->power_tune_defaults = &defaults_hawaii_xt;
 		break;
 	case 0x6640:
-- 
2.53.0

