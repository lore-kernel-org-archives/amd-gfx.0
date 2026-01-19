Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E3CA600C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6D510E3B2;
	Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePdh6OJ/";
	dkim-atps=neutral
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E36010E301
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:54 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b8715908e58so75476066b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785113; x=1769389913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjUW8QutM1erT9rGZZG1L0OVEG29nCs3yzGVKhAVPiQ=;
 b=ePdh6OJ/TS6WNjPIoeTnKbTzjSjwxesMBC21IqqcBj/Bi0dXlrJgthvdQ7Xxw0leY8
 0h1dc3LUcw31a6ppkyyvfG26aUNnmJ8saxzUEArg8QU2kOYTmyCswJF6aWWAoQOXyipF
 4taJlIASTg449nY74LDF6MQPHUFMqsyz5zLOSgW3uMATpGH4X3FbjvE+l/6mCWPocjWe
 390S/MVs/3+OnRn7sGCqjvi4/tTjB694ugLcYyaTSKdAV7UIjlP9T7ERF0oiiNOE6Zi4
 Bc73TQWKXUsNAYjX0n93C6OvfijNhd2esB4KwRE+KPVDoFugES3TESb+uUyiy0Ysi9Ug
 7rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785113; x=1769389913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VjUW8QutM1erT9rGZZG1L0OVEG29nCs3yzGVKhAVPiQ=;
 b=jCYfBnNZgXo5+ZM+3POFOJjehbauGTBn5r0wLqzEr7OK/1rDe9Q/wHlB3dTOmWSGJH
 onbB+1na6uE46jQB+GglGBPmJ+eekvXcBes9chUmPqGbagclB4aLQXC/Bfco+QwNaYxO
 1hFLC9TUpa/2dn6pxmtIlyDSUCBX4oI+hoQqTjS0D+UYA0TKGIKobdNxj7CkUBjqeTj6
 uov+eV+tGyLEF1Ceh+VFRTKUPawAoAJzOMrkCVYVNidbzRDk7sJ+hWHN8ufdHp12bznI
 d7HfuGhuoTGLzLPbzaUDXEtzN9r5IHU0Jop09Syo3lQPV446Vw4j8Am/Lj2VRXwi7QTJ
 G7Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWIWPpu9q/N/cE2UVyY8U7MRGIcYXiqUfVx2lh/x8xN8LRVOoIgn6ZtXb36DodvGTV9gx+YF5/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJNd3VQi0dKGI9rwF++cQeXNRYkpSUiF4iND0AuVg9yIRgy285
 0UtrOBqOR44IQePdFsFRiOkbcEPXJpuKfijnsZZM0fEt6kprs1/4zt/0ZOlZ0wFZ
X-Gm-Gg: AY/fxX73AxpdAX1F8yXneSXi7/oYg8DzYtmQVrvUCoQavI02koUPCWKOnd2nw60Zj+6
 GXX8pYmXynx75TRJWsRWJeRthXg1RO0cavjtDigt6wT03YC5IMGA2EQjLo2YxVI/QacXtVsuQTS
 4op27zquZl1CQk5w7scVj86/0xorKK8CRU0fO16kaUJhW1hpxmnjW+IdErHbfuNUYhMd9gDgj8g
 8crlG3lTlq4fPMG6fd+sRSXXiZpC7N6Luo/5JWxvqLHm3fVTT9mnFaTA9zMjIvOS3visAsTs39v
 V4fyPoOerfM0QPtVUyUmLz4urTD4tp7qWjHu2Ff8Z+LH9OQLy45OhmktEsVcEoZEVT5Nj8py/8A
 WvimInkHwukAE46SSPxCHz7GlkmY1RIRYArb2HRCuJ+O91E/U+ZBX4rHD7iigq3LDgp4nQhXejB
 /7Cl/qTf9FNpdBMLXin+vMO07vnP2IHaJHmwzEHAZfFTwus/CIj16iMqSzNLuB1gtj
X-Received: by 2002:a05:6402:5242:b0:650:854c:454a with SMTP id
 4fb4d7f45d1cf-654524cdd07mr4619489a12.1.1768785112567; 
 Sun, 18 Jan 2026 17:11:52 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:52 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 03/17] drm/amd/display: Check for VRR range in CEA AMD vsdb
Date: Mon, 19 Jan 2026 02:11:32 +0100
Message-ID: <20260119011146.62302-4-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

[Why]
Some monitors only expose GTF ranges (or others, without Range Limits
Only flag). This breaks VRR even though they have explicit FreeSync
support.

Currently, if monitor ranges were missing, amdgpu only searched for AMD
vsdb in DisplayID but many monitors have it in CEA, just like HDMI.

[How]
For DP and eDP connections, check for VRR ranges provided in AMD vendor-
specific data block if VRR range wasn't detected.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3894
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4457
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4747
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4856
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d83c65dc93d7..69f3dbfe4ca3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13270,6 +13270,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    sink->sink_signal == SIGNAL_TYPE_EDP) {
+		/*
+		 * Many monitors expose AMD vsdb in CAE even for DP and their
+		 * monitor ranges do not contain Range Limits Only flag
+		 */
+		if (valid_vsdb_cea && is_monitor_range_invalid(connector))
+			monitor_range_from_vsdb(connector, &vsdb_info);
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
-- 
2.52.0

