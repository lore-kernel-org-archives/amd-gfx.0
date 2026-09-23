Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4339C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8AA10E874;
	Wed, 23 Sep 2026 12:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iB6FUfWD";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098FD10E874
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:20:38 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f7db0so92776866b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166036; x=1790770836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fpAgRUPMm10wfqdAzp4L3YAQ7shq257O7hQP1lPE4Is=;
 b=iB6FUfWD634E2tzVJO3tE7jByAHEsU+n1ODdHoBjfXBopMh3Svb7k2QRXZaafNKKke
 9rsQK1XvJsLPjeIdDvvPKcQ8OWGNU6Q0475C+awEvYgg0WYxDMOgsCfyF6yDDga7mjC8
 BxvU0CYj3Xk9jvftGEZU0DC2evRvjwfCAKRDVLVtFpuMhtocxSNKeyb9CMIFDOAjsIaN
 myKm8+TdX7OaUiCMFA9IT8rcvSKRSjyaFxTGAkhOkqADfPGkAfswYfApCKhi5I1q7Kbz
 gwiP8m1P7Ra2EBQ1c7w+Xm3mUzMOqU/bDKePG4T9AAZNLv8UFQC8SGR4Lfx+77L6EFzM
 5n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166036; x=1790770836;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fpAgRUPMm10wfqdAzp4L3YAQ7shq257O7hQP1lPE4Is=;
 b=HIsHYSHB7PRCmJeJpGRj8zOJDk+a+5ZR/GXIPcXcyMxQxLRmoyna8J8+YE9pmx9VO9
 KPew8txQ1IG5qGyRE3BM8nxIDXBycWM95x4d5HNXbbOh/zuD2Q12KK23LLTz/J+6dVWp
 bw02Z11LgDayxvTyU/dtDy0+naAXSCcl0DJU3sqzGx1/9p89P5fTIrzfYFAUfwZev5YG
 g2zbqIJijlXoDJcJI184HKxy6Er4sXODwtNR8OTllEQHuynhUZvshif7lnU+BTuMdKgI
 AWNiOrVQO5Z9NSr/kb07cZrb7E+vWDQFalkpuGeewtgDIRauLNjGSt4wv4vdd/SLM2+S
 X+Jw==
X-Gm-Message-State: AFuF++nR70T0Ju5In8aOog6wFxuHA2aHbFe2v8fpwRU1F3ScwXGfQaAj
 QbrCF0DuOLeiBGRzWn7+saplose8WF2yfe7brnNP2ePyRgDItvE3h8QNClYtdfbokiI=
X-Gm-Gg: AYBFou1gJLYQUgKtS6RJ+jYwuvhseofylTY+fNaYYUAqrcltCQ2d30Hx7nrRGYt1KED
 3THOosGsuCl9p29usGF2aRbJSfTCHA0k6bv/nGmWrDLWeXayi2UF8dpbz4sJJaHQl5R1f0Gb0VE
 cK/fMiNJ/gUVyApSERGqQ8j2+2QvxLYjYWrljPrtRSJ4dQbE5YlBsN+wejx1mIINDc5+tMz3ipO
 J4o7wrwTqYxCo0q27BVQ9Rv6Guyh3AgpioPqj4DnyY/yVV3DtpdWEDmgeJ31EC6AG+fkO2TtNdq
 cX06MVyvS2pKbMf+1ku5+XWnAuQfgBndEvIDjz1lharwVvNJvuL0ON7QfdJZvrAj+UvwDBdpujp
 SVpm4vm/UqzO93rJb9ORxNuOS9DVfqsS3RKA4WFwMYrCkZxHGCA+fa85ki1lyftBkGCvfB0DzoD
 /hrAOEpD/AJZ9h84SPmzJXgjrhNR+x9vWcBpS4TdUV1fED2GtXLmTwf2p/4c1/EKXd++QxFqhyq
 l38Quq8B9MPNgJirO5mXndp5ngVid7136k=
X-Received: by 2002:a17:907:e84b:b0:c25:cb7e:1cc9 with SMTP id
 a640c23a62f3a-c2aade3f821mr206336066b.7.1790166036021; 
 Wed, 23 Sep 2026 05:20:36 -0700 (PDT)
Received: from Timur-Hyperion (86FF5B49.dsl.pool.telekom.hu. [134.255.91.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae5c604fsm108284966b.13.2026.09.23.05.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:35 -0700 (PDT)
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
Subject: [PATCH 1/3] drm/amd/display: Fix fast updates on DCE 6.x
Date: Wed, 23 Sep 2026 14:20:31 +0200
Message-ID: <20260923122033.1046651-1-timur.kristof@gmail.com>
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
Set that flag for DCE 6.0, 6.1 and 6.4 (all DCE6 versions).

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
 .../amd/display/dc/resource/dce60/dce60_resource.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index d2d56a1c4b8b..8612cc66a6ba 100644
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
@@ -1134,6 +1142,8 @@ static bool dce61_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
@@ -1332,6 +1342,8 @@ static bool dce64_construct(
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.55.0

