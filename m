Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3D3C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 10:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5720889B01;
	Mon, 21 Sep 2026 10:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="etPPDBAx";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C71D89B01
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 10:41:41 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a60591bb18so1884938a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789987300; x=1790592100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=77n7/qL5OD4+XuK76fVkKDFPHd6U1KVt25LeeV8um4Q=;
 b=etPPDBAxD68GQq5qdaq3WgUZSDlR3EaCLuJOaKkyAbZWsWTkH2/3nQsqud7Zjrw2LX
 3gib6d3xP+sSDg1N+7Ske1ssGCtpB5iQ/1Xykgif+KgoWMmFlihzFWWJFneEI4mFd78V
 jcwlv8v2JHd2cLGwpI+E9poZ4Rhq3WloWdwKyOUc9vx2+abDtomFX7fpPbJ99MYyxCRg
 0TsM8iANxLTl37NEmJvGveMmptsgnQP8id9NmYrXR9uxLnghIttraySEpX1a++F4FYXs
 3YpGBQvQmsQNxcCmHIv/KL31ygULBWQRMrYEcJSHA0AxBzIlkW2QSpcrsLYaiSsP3LxH
 pXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789987300; x=1790592100;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=77n7/qL5OD4+XuK76fVkKDFPHd6U1KVt25LeeV8um4Q=;
 b=ToZEjKh9G/7hv0PwKj1F7w5YHiABwj1rPCweFOBm8EVX8fWVmMA76Ii4S3BBz40AAO
 0E9xXgxPAPE+qbsUXv2v3BGRTKoGPC30O6ZiNZ1a5Q7GaeB90lp5SAZCkiamHc1DM0MH
 ihJ36/GcCE5sPii0uZehzc6ag1SxJB1bql43HKYMnBMnXdFIaZbSzcUYk2OFJmmu4jhN
 YDzHCFATBUi+dLrKLfeHeOY59nal4aDbWeaTPWczGjDsoq8crR/E4Iv+nrReBCV5nAlh
 88I2hF83Al1wNV35NTdE42c95My2djcPtrPMAzVgkZ89qOZtWe9eUCWODW/Dc/PlT+HH
 wVDA==
X-Gm-Message-State: AFuF++nYsH7zQBz10D4TZZAu/gxHooIXlm8SzhtQHQoKTM8pO7uXRKNa
 MKguRwyvhAgXqV1KcfyvvDUDCNy5RixAYN6sUXB9TPhCCPEpLUzhfONYPpcVwQyM
X-Gm-Gg: AYBFou2x11IcaD80M7lFJRpp3oPlkhUOa1dMnkbPWF9PO463q7J51GKwQpEJ9PacfJ1
 Dz1BJG06HPzBYz1VI5LWkC6ZImcP1WJRa0IxKKK7rEcFsuvW9zPpahVlVN4PE0k4wFBFM7O4c9g
 3VnKz+GTGONNm5za67TQHIJz/+boXPmj1okpdRHbNtkmh3SlivmZ+a+6MmtNp0BBryrRMYF7cTa
 B4r+yeX5TzpyPRgOvP2+K38Dr+bYm5wID1sxAQKuhobB7Qg9/K6uKcztvTBnYU8R5G6eIBd2P78
 YEZlWyD+9bybHCJZuf/n0UX+zVM87nrfV1ruBEiBRg6cjXHC6S0EQGWw09Rw9yU6PHkWRHoqULJ
 AUhTY8/hKmJWx+epdUwsIIU6JJPYQsJPvccfzy/6+qCYzIJ/iVcebodWTlYAxfnySjDe60VcfWk
 xTHq1KgLj5sbl79r3BuI2pFfh2n07hHJty83fE72UUmWyoSE2iVaMJudghuLnfK6NBGpMq3G4W+
 PWgahn0OGnkH5cKqwkrifuWgeX8X/Mw9nxho2GV
X-Received: by 2002:a17:906:4fcb:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c2a1640592amr968006166b.1.1789987299631; 
 Mon, 21 Sep 2026 03:41:39 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a38a10553sm267300666b.21.2026.09.21.03.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:41:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Fix fast updates on DCE6
Date: Mon, 21 Sep 2026 12:41:36 +0200
Message-ID: <20260921104136.23990-1-timur.kristof@gmail.com>
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

DCE6 should use legacy fast updates, just like all DCE8 - DCN2.

Technically DCE6 should have been included when the fast update
code was refactored, but it just happened to work until now.

A recent commit "Attach only plane updates that actually changed"
has exposed this issue because with that commit, DC accidentally
took the new fast update code path for DCE6 as well, which caused
it to boot into a black screen with a flip done timeout.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/resource/dce60/dce60_resource.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index d2d56a1c4b8b..f4efa55952f3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
 		ABM_MASK_SH_LIST_DCE110(_MASK)
 };
 
+static const struct dc_debug_options debug_defaults = { 0 };
+
+static const struct dc_check_config config_defaults = {
+	.enable_legacy_fast_update = true,
+};
+
 #define CTX  ctx
 #define REG(reg) mm ## reg
 
@@ -937,6 +943,8 @@ static bool dce60_construct(
 	dc->caps.max_cursor_size = 64;
 	dc->caps.dual_link_dvi = true;
 	dc->caps.extended_aux_timeout_support = false;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.55.0

