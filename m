Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C650FC47258
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 16:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931A210E31E;
	Mon, 15 Jan 2024 16:11:53 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1290F10E315
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 16:06:41 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e72a567eeso15465765e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 08:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1705334799; x=1705939599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS6uEFfS17C84C/JkCgS0wU+p+hCSHHIkna0klpWICo=;
 b=Ep9luy5REfCXvc2A1Xy8shQmqLAKZAqdfvM6OFPnWNxF7TVdNSSpf1v381kcy4avg6
 znZ5nYnulVm25GOIiOJ8gAmNhayKTF8DMZZPbe5UCfuF8IZjVJVaFqyMXMBDHSoZDZMz
 OgCWY8KPFh3OLNjF4ku6QgiLFHmw9kl313XmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705334799; x=1705939599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KS6uEFfS17C84C/JkCgS0wU+p+hCSHHIkna0klpWICo=;
 b=c63UqGdlCs9iHgx8oo1clOEhMSmwjpmTey32U5sG+5O56T8gwXLRTt/rv7Ntsyc3hB
 J6HcGJ6zLo0b4E/9dv05v5NJ3Luz5iZyOFelRw9uZSmiBVZvK9ox+h8yNGepN+2byfGv
 IjxpfgkPEgssmDktGX6mB6kxw+lW8KNSN758+HjXVUZZIxWtv7b//5M2zr7mwNLjNWPa
 lC8eMrSO4ls6jhLFzp5JNzEXwyPCerQmoEExnzh1/Wbo4VRWGqurgRvO59vyrIk28+FF
 Fy1dsT4yBYXqg8TPZiaZCriMKb31A6L6h1UGPtFkKAdqdsCSdHA/gZn4sGkRKfEox3MA
 enMg==
X-Gm-Message-State: AOJu0Yzmic1WDlNfzhEIFyZgbrVQICIT1iL/HHoH8UZvppXRg0ZAWfHf
 WIQMPbg5lv+SaDJlPzGQ5zf+HKtdI8Q3QQ==
X-Google-Smtp-Source: AGHT+IGIFWa9QLCBbPDN6iDa6GNEG3d3p28dSrUxb7dRFIBura+H4RnbieSbhVlV5zzIcWtVLi78jg==
X-Received: by 2002:a05:600c:a0e:b0:40c:34f9:6c2a with SMTP id
 z14-20020a05600c0a0e00b0040c34f96c2amr1712919wmp.159.1705334799361; 
 Mon, 15 Jan 2024 08:06:39 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 08:06:38 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH v2 1/4] drm/amd/display: Remove unnecessary
 SIGNAL_TYPE_HDMI_TYPE_A check
Date: Mon, 15 Jan 2024 16:05:51 +0000
Message-ID: <20240115160554.720247-2-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160554.720247-1-andri@yngvason.is>
References: <20240115160554.720247-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jan 2024 16:11:52 +0000
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
Cc: amd-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Werner Sembach <wse@tuxedocomputers.com>

Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check that was performed in the
drm_mode_is_420_only() case, but not in the drm_mode_is_420_also() &&
force_yuv420_output case.

Without further knowledge if YCbCr 4:2:0 is supported outside of HDMI,
there is no reason to use RGB when the display
reports drm_mode_is_420_only() even on a non HDMI connection.

This patch also moves both checks in the same if-case. This  eliminates an
extra else-if-case.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Andri Yngvason <andri@yngvason.is>
Tested-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f6575d7dee971..cc4d1f7f97b98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5575,11 +5575,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	timing_out->v_border_bottom = 0;
 	/* TODO: un-hardcode */
 	if (drm_mode_is_420_only(info, mode_in)
-			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
-	else if (drm_mode_is_420_also(info, mode_in)
-			&& aconnector
-			&& aconnector->force_yuv420_output)
+			|| (drm_mode_is_420_also(info, mode_in) && aconnector->force_yuv420_output))
 		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
 	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
 			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-- 
2.43.0

