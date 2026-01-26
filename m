Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF44D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BA510E4B3;
	Mon, 26 Jan 2026 21:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UgAOz8n8";
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3CA10E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:49 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so38343285e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461728; x=1770066528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyrAKaLIHL9O4klLRTv9E6wseZUTZO793HPLl6lcB0M=;
 b=UgAOz8n8igiyRJjwy4RCeAJjb83yhVdQnx8zJyebBbbOCysitPBUSFQhfVRMbx5bk5
 2NZQxQ0nnLPgsZsi8bwEU2LaA4waNkvEVGKTPlfnZvGU3ETWwbi1KYNvAxPSV5byEHV/
 j7prC+v+idi8wzSVg76INyyZsUzOu9lQmxgXrGAZOTs7s7pKu1EqbA+f3X4oiDLDI0kB
 cKV4j57xIcpGxT3RyUDW8y7Gz7oMcW9/iaYIvU6bTiGht2VSUPgtwjpzPDAuII8Y8Az2
 jchRdqy7F3N+GZ+m4kpFbsul9QjYd8bNr93Y9zybCVmwXFyZGbZh1URsPPLVcf+542Mh
 ymBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461728; x=1770066528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyrAKaLIHL9O4klLRTv9E6wseZUTZO793HPLl6lcB0M=;
 b=Dztcnjk4cpb+ZZX79ho7aUCdYKfma2ZY7W2z08XdVdcco6Uu7sAy1ono9PoSdN3Grc
 O28d5FmNU1SXu6mD8KTUdkLQiHXQ/Yd/wRvO2hGZjXCJmgPWAlBDBIdsTvGagdXIbUot
 lHmv5DQRfE1QvWXYXbOMp2vOJQNwVEd9SXNVaXvyrAPuzXbO4fToe3CqdNQ0OeVQ8psa
 xYR6hj1UhPjIihHc9KqB1EVH1CsRdQksJWm1xDGr1vSiiGCHnqC1jVLZJPgQQN9+U8M2
 yBVWoscAz3Ie2FgkvvWvDzTrkAbF2w6IuMn6XevSE4T6dl0L2+H6rah6SBsWPMvisJ0V
 EHhw==
X-Gm-Message-State: AOJu0YyKCZc3EN8rH5gxVDl22bfVuioGzFfKJhkFkXfKZjuBR71fW868
 L9FN0/cW+WxEULcJorTxLoyg8mT4v6GKTlc3H4pPfldKjxf3Yo9fUFYjpWVQEgxs
X-Gm-Gg: AZuq6aKcBHFTOykNz2uOq8wgkXm+IsYsez3T42royeA38T8PTWs8AwdpgPkSSRGGoOy
 CjaKNygEA6yNIjcY+WLOw4MxaAO/7s51PKGyr+d3e5YeFddELO0tHt5hC127l+Cs9Ux6cQCi8Ku
 V0n8Nh1F/X5irMlSDJ2RlECMhiYTE+0vA3WeVF7JDYomOrh3c+2Qc7uXzEw36rH0V57pVhtD1xV
 p+5AOpf3BB7vPJuCNNG54lK2W3yIYO7NYt3Df7uMaWVT+wT1620HCGcFqljtZIA/mXur3ugjRQl
 A6njzPl5JQA+JfjWD7TLMAaKUskijPMuQRSfw6PfxH8OJD44b2Dz8kmPikxvKfpTXK48Q1F9gmx
 3oeylGH0IZKThDs5Qo0YYmkBFgbpRrOgE+dZQWd9PdNiXSnDmeLEhgWvQHHmB/9HeRfShnCy+LC
 6PzwcDA+E2YUjMu9tcp7UNz3NyjTgkn9LSW6rVsytoMBN0YR0c8yS1
X-Received: by 2002:a05:600c:3e88:b0:47d:333d:99c with SMTP id
 5b1f17b1804b1-4805ce574edmr98200315e9.18.1769461728110; 
 Mon, 26 Jan 2026 13:08:48 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:47 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/14] drm/amd/display: Use preferred DP link rate if specified
Date: Mon, 26 Jan 2026 22:08:32 +0100
Message-ID: <20260126210837.21885-10-timur.kristof@gmail.com>
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

The DisplayPort code already has the concept of preferred link
settings, but it only allows setting a preferred lane count and
link width at the same time. It does not consider the possiblity
that some devices may not work on lower link rates but may
support various lane counts.

Allow specifying a preferred link rate which will be used as
the initial link rate when deciding the DP link settings.

This is necessary to support NUTMEG which only works with HBR
but not with RBR.

For reference, see the legacy non-DC amdgpu display code:
amdgpu_atombios_dp_get_dp_link_config()

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index cdc7587cf0b6..e12bf3dd3e46 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -743,6 +743,8 @@ static bool decide_dp_link_settings(struct dc_link *link, struct dc_link_setting
 {
 	struct dc_link_settings initial_link_setting = {
 		LANE_COUNT_ONE, LINK_RATE_LOW, LINK_SPREAD_DISABLED, false, 0};
+	if (link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN)
+		initial_link_setting.link_rate = link->preferred_link_setting.link_rate;
 	struct dc_link_settings current_link_setting =
 			initial_link_setting;
 	uint32_t link_bw;
-- 
2.52.0

