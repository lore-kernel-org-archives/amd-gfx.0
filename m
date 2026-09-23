Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F1EC982FA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 12:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF11710EFEF;
	Wed, 23 Sep 2026 12:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YkE6DAmA";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F6510EFEF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 12:20:39 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c29703cb796so111507466b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166037; x=1790770837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FDK7rg7jNv6PbgGpMo5z276JXHxYVcQLdBPeAG1nKQA=;
 b=YkE6DAmAIvlUlsssyP62Imvf8SoqAaYcl9oL/9Yfj7x/6o8hRp4IkNBGSEeEZ72Ctc
 zHgrJFcqDgp7W4/4XjAhMjyqavbgE6QTOGGLyVBWao1ilFVAeHX9tOIgrtVnmAIPRtWl
 LCzKYxIyL5gxMPOk/dfimbePsBu0RjZFyG8cHdFkuWmFc5qbZLD+pjxY7cbNt3DPCVQc
 bBTuGnYmbuQKOqCp1wiWRUflQAcLAQfQ9cQgXzWlxOh661ekV5XSm8ODhQ20h1A69wMN
 nFDJxrJ+cs+yYvM4x+igGsksdrBsPE8bZUE2PgieovVzVEo9E7esz1PqPGnZCOvgjwJb
 huuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166037; x=1790770837;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FDK7rg7jNv6PbgGpMo5z276JXHxYVcQLdBPeAG1nKQA=;
 b=IALL9mhCXzboRZorn1eEJHH++sDs+iQJpgdqkPlf1KwKSyJ4pN78wQC7l79gGYieN6
 X/RRnAVBjT+E5d+lr/eeg6xPVIT/xiyHOfgFiZFri+/+Z9ttJzER6kHZVEvLCxCta6RV
 BcJwKCQLMZQRzg4c60wer7NSBFSzL1YfP59cDTDeL7nWn5N84xyKNir2qRHbZi6Jby2X
 x4NUyblWeKpyH9jGdr2rP8SlXcGeTElytVjUQJbN7H+Xvpws177sQt6SaZWRRWSXhBFD
 RBixBK88Sz4Vj3CAAt0+r3Nli6qyn8YAG/V5fBcH+/hYQrb286UFbePtyvHrtPgQuiHN
 lJUQ==
X-Gm-Message-State: AFuF++mFc1+Ndhs3TMqWJMgXg8jZwJ1W6UYPVhlTDkNCXRLC/sD4HuJ2
 EWmOdRah4Qsy8nqUweHfxnF4JPJEQAbr/AKh1uUXIalGxUoaC/9ApHIFS4mxsvGMQfQ=
X-Gm-Gg: AYBFou13BEsYKeWn5ENzXyr7KqbkgdaFJL1XVUEnmtHErnaGq38NIWoCnnetvkl03zy
 elS9xbf6uufntkogLrr98gyAEpJvVj88Ybem58xMcjCLqOveg39++Q8CTl7v3b2r2ZPNRqj4+79
 oqvDGeZcuyX/MG5rQgHzdibMIlARvqLc+YiMF003O35pUHY763J7n4xDwxA3boTDGIMKVuWaUik
 tLy6kGsg6haCcnksEBvbCc+k+z3puGDNw2UgQJC4LDr3WebktDesQa1GAolDa6xYCFu7wgmqR+b
 siis35AnNz7rJ0nYl040xAhSTCYIuquDwuL58JzkJ0Kz5S+dL6WbIrLDFzzR5mUVI1tem3bAXZb
 Fdjp90aRgzWfsuqipkRGt9pkYTpUNnVpqjKV9a9nr7xSkMFBUut6Ctc/Ejm/BBnFWvROB8cJ2DJ
 lKpIZ+lj0vbBVnamOB+HEjxqhOZe/K0YDH6N5kDGVWljy4ZvfMk+FJlS5g/l21/UOTIlOtkYiDj
 ugxovqhAvvjmoB0GwkwEdqakNlwWnVaBgIR
X-Received: by 2002:a17:907:a890:b0:c26:1648:a069 with SMTP id
 a640c23a62f3a-c2aadf8c984mr204100566b.36.1790166037471; 
 Wed, 23 Sep 2026 05:20:37 -0700 (PDT)
Received: from Timur-Hyperion (86FF5B49.dsl.pool.telekom.hu. [134.255.91.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae5c604fsm108284966b.13.2026.09.23.05.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:37 -0700 (PDT)
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
Subject: [PATCH 2/3] drm/amd/display: Fix fast updates on DCE 8.1
Date: Wed, 23 Sep 2026 14:20:32 +0200
Message-ID: <20260923122033.1046651-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923122033.1046651-1-timur.kristof@gmail.com>
References: <20260923122033.1046651-1-timur.kristof@gmail.com>
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

DCE8 should use legacy fast updates.
This was already set for DCE 8.0 and 8.3, but it seems
that DCE 8.1 (found in Kaveri chips) was forgotten.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 26820d35478a..2f4de697ec4b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1148,6 +1148,8 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.55.0

