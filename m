Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CB7E6814B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B4510E480;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJNSYCfb";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C61510E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:29 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8f947ea8easo25678366b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260328; x=1771865128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KSOhFxZTGl0VyB0dvJbtjxL4ii4LJZxM+Bjjm62DzE=;
 b=MJNSYCfbcL6ZQn/MsGyEUdVcLAEI8XCuHZe6NBJ/HNjopz7h1Q/Ht7ZJ9tnanYStgV
 UZcy/aJh0kyedszX3L7PbZbdoBA3/9epyckcDMkVUOg3NJfGeDsrMw0T5ZHbxi8f7ZUH
 tSPHUt7onLy2SVhjS+CLt7bzHLMIVjhcSVO69jexr6qz/xQ9KHWJlgN1S/J/vvUgL59m
 CZXSv9lS4dSFubu0BRXhRP/478yYundaj0eiUSHNBo+K1tqdyvbn0fs35BUatp7rDEqQ
 zzsGJsUTrGBXIwMph/b4Jcy7Ko3oGyqy2moFOzYpHlDmJWHw8TOOzWHGT/TYjM6IAhRw
 uQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260328; x=1771865128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4KSOhFxZTGl0VyB0dvJbtjxL4ii4LJZxM+Bjjm62DzE=;
 b=Yq6Pyi3hZ2EXgnGrIhkXflXooYEL+eYNqXnfBJcCuLodMNzdvhyAYtXzZ9lXQ1SKRv
 tg6lvJTDwJs1TU8uUnBQ3d1/KRrKtDFziunSuvEUgq7IWEF5LUQmw5yNWbZ4frzenNho
 74NdpdlnNlmbTZsxW96lthtMJeThOpzBrJZEaU7Nvmyamb1skIyfen6fS9umQiY1fKRU
 BWjPPwKjHzzNrmDXMTSaRrQOt0KP7BulSVlrQ7voBeTKtNYWn8tSYBImXsEvU6xLCvC2
 hIP92NlhWz/7+Y0qxmJX1U/Y7SQ8/nnRTfZlLQsXrELxVJ8Az1W2juDHDXcOFqOALW2M
 iweg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt1ZiF/efgsb9/T6JfoCAE3OwqPR4DjcysSTm7DwqKq0xO3QxMO5exyzFLT9uBuHMnmZBJbDOK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzgpisy6wlVzILiMzIVjpfmGXOoZ2b/4Ll8njCjiM+QsV01jcTO
 NHWIIbmWgX03JW9irw7ekfxPGx/oOA1+0O8okzAKYCyTbM5WewytmIZ2
X-Gm-Gg: AZuq6aIbVhZXrZ58y9AfLX8M/OTc0xch37E7ahDWWd/zoaoJzFWRURSzSkycPpfgSnZ
 KxR7s+QoN7iv44K+Kk4OmLIDOZRiCPgmU03Hl2KR+AZo3bu8++nT+cPib1XMM4q9JYcrfLuB47Q
 DAk9k/y8bowBp6vx7T3Aa7mOPQbxvctkvWkQGBJkRDt+zjBn5G5gt+LigyI1NkxSQg2g6l6I7aO
 FeQIvMtsH2MBZ6NwVVnnDcbtv/HSlswRJIxPprU0FbrEqt3RCDc4RXg9yKfPsn+NYRvr12U7hWG
 SXFryd4EkHrtenrFOvVT/7YXeTRGIWHXsYPmtzjCawObd4v7x/EZGJmWpT4Ae6OeEviIA8sLQzv
 CpI95RG5+1g4wfHWgmjrxYg0T6qqcmccGo38rGhHmqNaFTlNajV1fCw/kQkUC2wMsKp/+We0A+w
 RlUa1chcMXTmgeg0xuakpRcE46Vm3oW8djZMGPA8hvVUKKlIR7ycv3fwUIkZ3TIyi5SbOPSw49X
 k5G
X-Received: by 2002:a17:906:6a24:b0:b87:3c3a:cb7e with SMTP id
 a640c23a62f3a-b8face00ea5mr368555866b.6.1771260327617; 
 Mon, 16 Feb 2026 08:45:27 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:27 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 06/27] drm/amd/display: Check for VRR range in CEA AMD vsdb
Date: Mon, 16 Feb 2026 17:44:55 +0100
Message-ID: <20260216164516.36803-7-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 64d1dae4d214..b3bf5e0c19a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13332,6 +13332,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		/* Some eDP panels only have the refresh rate range info in DisplayID */
 		if (is_monitor_range_invalid(connector))
 			parse_edid_displayid_vrr(connector, edid);
+		/*
+		 * Many monitors expose AMD vsdb in CAE even for DP and their
+		 * monitor ranges do not contain Range Limits Only flag
+		 */
+		if (is_monitor_range_invalid(connector))
+			monitor_range_from_vsdb(&connector->display_info, &vsdb_info);
 
 		if (dpcd_caps.allow_invalid_MSA_timing_param)
 			freesync_capable = copy_range_to_amdgpu_connector(connector);
-- 
2.53.0

