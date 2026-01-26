Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7623ED1951F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE3210E4A5;
	Mon, 26 Jan 2026 21:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F1Rc+z6B";
	dkim-atps=neutral
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D3010E49F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:43 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3205272f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461722; x=1770066522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6XJoxoMZ06S+OHHhijNcoqIlf1RGFibnw7NourtJ6s=;
 b=F1Rc+z6B/pAUrwhXSH5acbUNKEEFCZwXSscEC9oWkHTunXB+m9F2uB3okakWsAgNK4
 D36jmYYBm9J12ymCsJ924wT1oNnDjpLyZUrfh4XLADjdCyIoG6hCryMJBgFbxfNJjff7
 A3DiieYXqc9Mvpq6niqwTIgBJC6sTJ2w1gcOQ7zdWB4/TR9yC94Nt4QqpZTi4mGnfG4U
 bZhaJkA2Bd0kqqfc+Hu5mSMYBAWfgKvUwGh+KE8UoHk7/SjE4RD7/M9Iik2OL2WmrZ3s
 /Cyjl+5bd1jcup+pD1yfdKQa9MCr0ItJUivGsJcYc7KapZ0gfFwvJE6st1kdhpj5iuTO
 rmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461722; x=1770066522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6XJoxoMZ06S+OHHhijNcoqIlf1RGFibnw7NourtJ6s=;
 b=vFalKD4WwVTu0F77U2KpFRiklM0hB1ruiaaoWi/m/oWeaczDsH3gdjToW/rHFCZFB9
 Q79zpCscgw0RYJRgLRHoMWPWm05gqL8IOshebNsZJ1v16wx3XWafTPQjRExwFH5LrWUa
 eOvK9SiUPOWytE3dLb9VykW1+aJPPcGHt0l11Tl0RpX/U4oiKGC6Ve1Ac/eQGaNxiCg1
 PGerGzHlr495rPdp41HHZ6ZgB/BnfZc01iw5RYGixpraoV3oMtE+UU1L7DIVBF67tsof
 px008xQBLX8i31NqiEJvP1UeYNBVXUy50u5f7UWZtNrrddUd/pugBw8wDd7HHCyb3jqp
 YyfA==
X-Gm-Message-State: AOJu0YxmMIU4Bl+unZA4ooi/ADKo8+Z+CcJtIFUoczXhemjZlCbp2yTJ
 ENIuqhW/ce030s5FCl5jjh7bzWtuX4hRlwo8dBKSEs6spou1XA2SABq0XkvwdbWy
X-Gm-Gg: AZuq6aKk+9wFMLpoXJAzWGVlLr0L1K6QUHBxF+mpUvYr3CnNViY5r2x/aAWt5wumsvA
 qJevMpSY2qrGCayRXHfyAr0GFFTUAqxqFnQhYpMMQ8SI7/Hbi5YicGDl9Gb8a6fktg531U1HrN4
 EeoDcsXQ+bo6FgLQnAmoutHyzyVmPbiMgNJZ2aHIaejmV7ZEmrTYpbbGafuWf62sVnAmYGxvjxh
 zF0ke63mwvDkedlBA84XT29nTS5GSqYYxATHWjjv+TowPawKSYUlp0VnOuBIFkhGYFkyoFw76FN
 QJdOe/1ftTta37HGIFt39di2gQqhurJB6GjX8i/CWS+gD85RrGWXms7IqGkEpSortkoA9nt/+iR
 Sm34T/Oa29s0/5DpSC6wWFoVvaEhdwnu9wJn83LG60lgvftK5/BpviBYDG/pCcJK19J/FiZqtMv
 rtFiHcUFuIEuUaPUFcEqLsaroaiyXKcCTSu+B9id+YFYlH+wzrnaP8
X-Received: by 2002:a5d:5916:0:b0:435:8f1b:bb32 with SMTP id
 ffacd0b85a97d-435ca19142emr7450792f8f.32.1769461722215; 
 Mon, 26 Jan 2026 13:08:42 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:41 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/14] drm/amd/display: Only use analog stream encoder with
 analog engine
Date: Mon, 26 Jan 2026 22:08:26 +0100
Message-ID: <20260126210837.21885-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

Some GPUs have analog connectors that work with a DP bridge chip
and don't actually have an internal DAC: Those should not use
the analog stream encoders.

Fixes: 5834c33fd3f6 ("drm/amd/display: Add concept of analog encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index a916872db7bd..83b9abb64bfc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -979,7 +979,10 @@ struct stream_encoder *dce100_find_first_free_match_stream_enc_for_link(
 	struct dc_link *link = stream->link;
 	enum engine_id preferred_engine = link->link_enc->preferred_engine;
 
-	if (dc_is_rgb_signal(stream->signal))
+	/* Prefer analog engine if the link encoder has one.
+	 * Otherwise, it's an external encoder.
+	 */
+	if (dc_is_rgb_signal(stream->signal) && link->link_enc->analog_engine != ENGINE_ID_UNKNOWN)
 		preferred_engine = link->link_enc->analog_engine;
 
 	for (i = 0; i < pool->stream_enc_count; i++) {
-- 
2.52.0

