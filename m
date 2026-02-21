Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C927FE98E06
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A77E10E289;
	Mon, 23 Feb 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M4gOzhY8";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B10DF10E10C
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 03:44:22 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-824a3ba5222so1467697b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771645462; x=1772250262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJmFbB3FwMiKYWU/wDkbhYitxVoyIrAuDm/JRU1AydA=;
 b=M4gOzhY8tkMZlqCVXTcNV7sElzvpS36HLc4HSFSeH7zC1tm4pqmYFIuVNLx5e+KCvZ
 4JCGTU43y9sEmj0wl5Vzq8nL0IcEr/9ifzYMdJiTfPeFgrHETHQuP3ybVwrALXKBfcqk
 hXLwLCQJVPJ1heuqH4nQCZ7LkBK28brpF8vncgbWjQezw0rPHJzqhjnThS8i1bVDloxO
 WqYS0Pms0Tu2+pxqUw4aJBlYAZF2rwKGPmpXTJ+udhfmBVP1cYqnAPAACfVnurXZUYTE
 BIeM9/+uPCb/vG2SdCnOoSYW2PaOPs6oJvyIlOBRSIetQSV1fu3gfTROmU01Dam+x7bs
 XH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771645462; x=1772250262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJmFbB3FwMiKYWU/wDkbhYitxVoyIrAuDm/JRU1AydA=;
 b=ffwBF8DJJ8AKzRaZrXd/OyyWqxYL6N29v/2rQ5BYA3zDz9xZ9UHbzj1Chmy3doGb7b
 VEY7XN7HSUCiPqMuuJvA7toyk9qhm1u8Lvw5GCTkdfgyMtPqBZO6MZtabSS6VtDd2Wag
 QUelsYymZid+oktHtdbGggtzZzi3u8Y3F1xpZmEb8UmDFU+uAVariDj8KY1qI9BRbW1u
 eXRxqer/1C8FuOPFcTP/jmStVknbPjxnuJP0gm/VjB0F4kv5v57qNI8aTMnZ+keSBfAj
 M2j6Os8JNhcSAgUEjr9QG+BOPLU+wqUvnNQ8QyLUIQ63etEZRdObTcmsj06QFwtDhf+9
 rtUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVePFgzTEdA5CNCuw+PVqqmqKXdMCAIloXkKbHgHIc3hINtlOX2HfuzHGj3lWWg8i9LlIGj6tQr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4ObkYSJo1g0+fAVgQskl8fi+fnKZvUwLNhg7cnULoKwOWFQVH
 2nYG2Sdsu0TwiwtN8hme8OzoLuXort6XKGhW0w4PJQxoXrxhGyICZ0ze
X-Gm-Gg: AZuq6aK6sHCkQmDOuagfNEcalw93/BD8PmwUcTq9Rnb/p0ibRs5/TsVclvCoNWOtrjx
 lbGvK58EFqskdZZdcnyVjawfV/Cq4ebWee9qqbvmo6qnU5GC/T9U4j5uWqzY8pITMvYQJSeX9ZN
 ucSYPFka9K/K3I15ZjZPJoG8ymFrtrMJSpKYcBpIAYasNndVastj6DJuQCVbs80SofV2mp2n6FX
 omtuYO/lnW8QDaRIkc1U+oO96y3JjypC+yQXRhxSDJY3oT5/HOZWcIgz0Ygjrnj0psfG5aJIN3k
 GsO5w8zJswA3WKH/TfteklQp/d2iEZX2bHnGcKOzX64ahAUmjPw53zDIbXzIFZ4VqNMQXr4nR82
 0zjCNymHN7k4UE6Suvc7BirPhV1qiRF6FoX0jQCetE1skB/VQIoCgbKxdMGxXKZBwbCrN
X-Received: by 2002:a05:6a00:430c:b0:822:682d:2c5f with SMTP id
 d2e1a72fcca58-826da948eddmr1927546b3a.28.1771645462263; 
 Fri, 20 Feb 2026 19:44:22 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd8ba11bsm714951b3a.50.2026.02.20.19.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 19:44:21 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org (open list:AMD POWERPLAY AND SWSMU),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at high
 pixel clocks"
Date: Fri, 20 Feb 2026 19:44:01 -0800
Message-ID: <20260221034402.69537-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221034402.69537-1-rosenp@gmail.com>
References: <20260221034402.69537-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:05 +0000
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

This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.

Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 29cecfab0704..05eaa06dfa34 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3486,11 +3486,6 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	 * for these GPUs to calculate bandwidth requirements.
 	 */
 	if (high_pixelclock_count) {
-		/* Work around flickering lines at the bottom edge
-		 * of the screen when using a single 4K 60Hz monitor.
-		 */
-		disable_mclk_switching = true;
-
 		/* On Oland, we observe some flickering when two 4K 60Hz
 		 * displays are connected, possibly because voltage is too low.
 		 * Raise the voltage by requiring a higher SCLK.
-- 
2.53.0

