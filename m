Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D5D10ED677
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0671A10EE31;
	Fri, 27 Mar 2026 12:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AnOsvsYf";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A669C10EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:52 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so798396b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568872; x=1775173672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=AnOsvsYfGdiwZwIyFsATjP6aX8tBDr0C0D+mKuhld+vnmBjc81fvCJ1frxgGcQMeyw
 P2VRM06UWBbuIXqoVeh19pLhR6kcf9UT79RHzSwDGepsqSmixpbl9XCcKObVqHMSu1Kp
 VxXgASAZwwMgRNxAjB3eXheMcK8nopYmsz5pQFyMZHhgN0veHACP9PgvAbU7S2XWfVW6
 qFQ3TVhd0RpSWnWBAkdGvePriTjwTzzy92HmJ5ebxPAuMqS8qnrQM6d1sk1OgLtwUucm
 dkUyCzWXcq7p/YzybzzrDuIGbuQtL1H1H7RTHAyhTdwPuTqGTSLfQZemdLU3RSimxUeV
 dr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568872; x=1775173672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
 b=BUDhC80wgPe8jvxycKMe7UzXRnhJccXKy7peKyU9Da9xgKESHisyWnVsfGRNKdTxJm
 CRlwLU+/9F3H7krxCmRTeXDm01Qzjh2X6ylGSTTVsKNLqEWYpcFZWmHJBcLQvyIeKvSx
 dJZCZZBV4ypkO/dmfR6xetOiNrNSSSWrHg/ol61g/2K2jbucqbPDOhEYdVikYZ45qUVO
 /XvsjV5tjYY/ZzD2S790EQkw53s7pjWi/OQua4GX8g5Eg/WSa4sSqv3km9gZwQKKfQ5O
 3MTHAiC2gsNtkvPAdrM4NQV+t6orlHiUg2Dob+EZig7WtMAIsJshVhTjK679+CI+ioo+
 O6Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTQzobDuDkZe2ZKPiHjmTdtMViFwZT5YUgq5CBqGjXx1aJT1xGcBljLtb197uAwuekvduaaLzd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK9JQpyoCWMn1t+B5HW8MxJ7MEwKXJuRoqv1DWuHSmQqpZmf6M
 J5wgQE1e94VmAuYktsC0li1PLALsPj7BmzSBkhi15Lh9LGS3fSbLCBirQq0UXKng
X-Gm-Gg: ATEYQzzKIUR/u8KZAfUtDFR3PHLaOF6MSG8UZbcXLmAqPv8B+us0x5IknSrbxv1NoVb
 8HtJMiFTBB2WStf3h86zxq78obP5a4AKjsJGCeLtVRjBQAXMmzmnFiezcsW2m9WF8hyqmSyrrqa
 WyzPJPz68LWWZngEUGjUW3ndwZvh4kz73JgVcw7zbd3rgcJ8CcJcW9x+o3rkv2LU9dgvsVWKG/v
 ia/NvtbGFV/KLrvFcc2F5zUDYrHzUp4qsNFdnlkKR7nukVr/hBQNHxqt5uGd5yqEcuRPiT++pIf
 z7R84dqC9HA95Bc4CzEag5hp8H9HqSB3Z9Pz3UYVR5dl0JA6Ta8suD2Ylev9+9OrWzoE2Wcl54g
 CYWzsFnfK2pUEdSKnYXJ9dPjarA4aCIc219VYediszZMka9YupCAyeDlslxb1f+LEZR/VeXsdZV
 EotpWOyfqTxxv4tBxDkRh9oXC7ZIrr2NrvSwOCGTuSSM65oxM0/SnUofU=
X-Received: by 2002:a05:6a20:3ca3:b0:398:a060:a97b with SMTP id
 adf61e73a8af0-39c877b2c2fmr512115637.1.1774568872136; 
 Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 8/9] drm/amd/display: Disable scaling on DCE6 for now
Date: Thu, 26 Mar 2026 16:47:15 -0700
Message-ID: <20260326234716.16723-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:01 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 978c024c97ba..3f9ea4fdc7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.53.0

