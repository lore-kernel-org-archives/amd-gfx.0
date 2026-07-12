Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B81C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 17:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1B510E4CD;
	Sun, 12 Jul 2026 17:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1R092zw";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBE510E49F
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 17:39:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso10665635e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783877972; x=1784482772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Phq0P0Bl4raEjuM9bthxJSkhMvlaTT5a2ePjPoRYxnU=;
 b=p1R092zweLIMtvM/C61UmTfUuBkPOJeh1nr58jZQ/d3dhfF8v0DqELxYSd1aOcJY6Z
 +3L+Uvvujbv2swRC4meatGjxoC390Q9s5i94CNQbO45+/5wYEjQBVIS3mvckssqCD2/H
 D8Ibl3A25P9QeLKmz6+EkyqTI+jNeUU/Dx27XFhjvhambv3L4xJ4vklcf7l6bHlX9oP2
 HLqGJYPTefmoiBX5NnFeuhv/Qm5mlfPbAJkNbFeL+fR7ZBbyTz76RyrVGtzfyyluE0+5
 Yafi5L6kWw/Zi5b5E5VctXR0cRpsldrbMzdVZxn/ddaVzMMgbpGqRlXWCaAvmdXbVp2p
 YRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783877972; x=1784482772;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Phq0P0Bl4raEjuM9bthxJSkhMvlaTT5a2ePjPoRYxnU=;
 b=aLA9NdnEZTECpTV5AK03E2N3jdv1gsbnCzLM/NWWOqarPLoEhUahzrFoQel776+PhW
 U8TFah+necrKdKhg72kjc2Zd9IBUeoTBlXBCiW+VZdYc9qw+m6cC6+RMCno92KB+leos
 sUOGlJvnQ4fjob4f+pdWYHLDc9IgSa1Plo71srPaL3BGAVb5xqYpD90o4NMJKtm/j1g1
 TqLphiyuRkEM7EoiPMUhv2vex7jnMlCCbq4MdzCEhLuC2yfBF3C3s9bmjdwaoDlpRZY2
 U0Gfk5I8WmGXYNtbchgwlnRk8tDBk0f14Ibud+fCyIz/N+Lv0T7ncFcT2ZmQpLjqjnLA
 9Z5A==
X-Gm-Message-State: AOJu0YyaoSxCJQxOR/EhQ50Zww53uTIgqlLzuXwd3+AEBwRMWcdMJeZJ
 +A9iGXl9cyNhWKe9JLGCk1xmUiX7jY9Pc6OhteAjD9PAgPg+0G1tvESSaPxiSw==
X-Gm-Gg: AfdE7cmKlL9m7quuvfT6BhmiVNcfjltEDQSWeNJivo9WCYcRmnTGqtHihfrJ6fsmPmq
 /TRO+PTjH6I6btJZZMtfGpRGuYFwlzw3GBOTqZWLb3Wjvcj1TtOINclENmE+WUAqlkC4uUXn+I3
 ETNQb32q/TeT8BXab3tUDT8SX9o5R0LUdJU5m0mNhNCYlA7RSHDTL/Sa3pk7JOu0xtX6p1I12wS
 oGvCFvFSCBiNWVi2R/6KPo3QvMjucdcRlqNSmCDTm5UVF97In34cr6gGd6+EUPygp6nSdlLa3oa
 hpSsX+IEf2tgkRb9BrYn9DlLLz3+HR8j0S7DsSmBwjvc4fHAQ07pH4m+fLS0KFyhNaqa+2XPmob
 pS1ec7Q9q9h250nViXalVJw6WpCiBD6uskORjuMIC5C9QQxP43tTGnSlNY7jUvXFjIMH+d1jSUH
 GIla7/V7F8VoWxLyAm02B8T9jzy/fk6Rh+YZ9a7z3xUC9ECfvLZ7Lk81R+Ev1e7YiAfgKanrenR
 p1qdwkhxTw=
X-Received: by 2002:a05:600c:37cc:b0:493:e542:ffd5 with SMTP id
 5b1f17b1804b1-493f8884bb7mr61094745e9.5.1783877972079; 
 Sun, 12 Jul 2026 10:39:32 -0700 (PDT)
Received: from Timur-Max.home
 (20014C4E24E4950000951480CE1AD54B.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:9500:95:1480:ce1a:d54b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493fbae1cdbsm119128965e9.10.2026.07.12.10.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 10:39:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/pm/si: Don't schedule thermal work when queue
 isn't initialized
Date: Sun, 12 Jul 2026 19:39:26 +0200
Message-ID: <20260712173928.259701-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When DPM is turned off with the amdgpu.dpm=0 module parameter,
the thermal work queue isn't initialized so we shouldn't
schedule any work on it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 832953941266..6a54566d1a68 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7692,7 +7692,7 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 		break;
 	}
 
-	if (queue_thermal)
+	if (queue_thermal && amdgpu_dpm)
 		schedule_work(&adev->pm.dpm.thermal.work);
 
 	return 0;
-- 
2.54.0

