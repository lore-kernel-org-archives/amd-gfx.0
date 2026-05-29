Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBC1CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3012110FB7E;
	Fri, 29 May 2026 09:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nTmQZ4Dz";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92DE10FB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:09:13 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bd9a71b565aso1708613266b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780045752; x=1780650552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XmwIy/5pYGKcfGAQhOO6vuDz4yVaMMTA3Olq1h5E510=;
 b=nTmQZ4DzhBtGNu1+H0kYrDjy8czHEsOPMK648EeZDS3fk1Ai/eZL7iRA3sAxrwDKe4
 u2/NtsgeUhKsbRfa5Ui/8HUHXvnhxv5ojjfPVITd3g3wJyojnk5LzrNc4HehYEswQlJs
 FopMwl1GZsy8pMrkkuEI/92T+N7Uo309FYuesnKTqodeODQlsJjav/u1Eu1cZzg4cmXg
 xvI5HFzMeVt6rTkK6UpK7JD64de8jWacxq4cWPqtEy4hF/i6OoP7QwLs1ZHYH45u5Ypt
 hSWrqE4wHq7FdCPEgwRSpNPlF4BsuxdKD7v8TfbFWvPfSdpyyLqDxbMuU0ezrmGzLvVz
 HRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780045752; x=1780650552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmwIy/5pYGKcfGAQhOO6vuDz4yVaMMTA3Olq1h5E510=;
 b=Eu65waotupN2Jjae42871oX64Uc81dApejDkLw3IgTa+rjCajXcLlXzfBiXqUjpy7D
 lhiBK94I88gzaHuX98fY5mqpMltHUO5SfytcjJMqzCnfIsWvz98X/I/smIOr3wt+5149
 Gx1DD6RuoBHIXBvwiDbczahYv2tSUEmIPsc3yLFjisA1wjtbLHu/e2nwXQ56cv7jLgDo
 gdam1yaSGpzpa29FaGqLC4C5QKhLxOrp9wflQ3D1RrvWdmcDTnprTQVtLN1ZxZSVy9AU
 MX+89o0AIaepNyiOyIjxq4ECz2f9xwX8Wls7h5reUNNQHDkedLMB7xaWUJJOFn2qaBKT
 RRlg==
X-Gm-Message-State: AOJu0YzMm8BOJzq/5lfDJOIpE5YT9dDNjf6FIAtjIXvfZlpfX3sA/XJ3
 7apqp1H2hHDM64u+4YXkPeFaAq3WZ57dphwAnwgJFKluOW25Y1wF6hUo3svtLg0w0QQ=
X-Gm-Gg: Acq92OGZx1YFobCbo5y10jLbp52/CYZ+k8KLc6QPuhdtdWk8qVz1OZl7lwOM1WoLYZ7
 VaMMftFq2ozBSu6fh/LD0md3Ez0MXT5tDP2YDGpeF+6CMrj3fDpPJOT6oy8C4vxIycltGYs5Mk2
 kSes+jQr2KIAZWEYfDcUjAdYy4GnbFjN1OGE+8Td0cx87N7g6RlgHpg3o9K6QAcj5HgJR5GKPo/
 VCRaHmJTwWJxKxaeqAeqwzkBCGjyzkVwvPxEE2W/5T5oAglN9mYV0Gi3EyawGw6vf7wep3QKFxX
 stRlp3hfLGeSap5X8IswgkkZQOXyNnxOk+33YzRK4355kipiMFZCLEnqzGvSRMZoUAy/dHWH9ym
 6a9b7WY6FiapBYTgkeO69Z/jvA86FsNJXM5TemcfBqzf6h3lyzQv6Dv0oEU2I8ThtLEn58I0Ioy
 RVaINr98rYv8HDZXMZcRYXJCY7z6gLv9OqC6lK3vXhqX2rncTVJD75DSFDEdGWz6gYUpUwySKe1
 lewO3NHhtGTTJSg
X-Received: by 2002:a17:907:868d:b0:bc3:989f:5179 with SMTP id
 a640c23a62f3a-be9cb9c6181mr119685166b.22.1780045752072; 
 Fri, 29 May 2026 02:09:12 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354bb7asm2200645f8f.20.2026.05.29.02.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:09:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
Date: Fri, 29 May 2026 11:09:08 +0200
Message-ID: <20260529090909.13206-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When there is a preferred link rate setting, it needs to be
applied to both the current and initial link rate.
This was regressed by a "coding style" fix, which caused
the current link rate to not respect the preferred value.

This commit restores the functionality of NUTMEG,
the DP bridge encoder found on old APUs such as Kaveri.

Fixes: b74322eea36b ("drm/amd/display: Fix coding style issue")
Cc: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 817b4010edcbe..f44c13300a59c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -750,8 +750,10 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 	if (req_bw > dp_link_bandwidth_kbps(link, &link->verified_link_cap))
 		return false;
 
-	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN)
+	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN) {
 		initial_link_setting.link_rate = link->preferred_link_setting.link_rate;
+		current_link_setting.link_rate = link->preferred_link_setting.link_rate;
+	}
 
 	/* search for the minimum link setting that:
 	 * 1. is supported according to the link training result
-- 
2.53.0

