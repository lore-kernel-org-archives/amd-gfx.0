Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A227DCA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 20:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416EA10E5DE;
	Mon,  8 Sep 2025 20:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XL+q3MZW";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B3810E5D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 20:42:33 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45decc9e83dso1683935e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757364151; x=1757968951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SHu+39NCL3M5+f2JERBRiaCBa9DhGxQBszDvow8SwaY=;
 b=XL+q3MZWsQ11EfOMdQkrUKt2F6i9y6ReKaSX+g0Ms0ejZ4prwlPT1llHFMr+mXr4wA
 1uayfn/EY5MhnC24O2p6/0Ll/X61QZIvLj5U29yDLBc2OxC+ShyZJrNHs31NlBOAI8Ar
 lTgkVBBdHMp1vdZpc5ePM1LKaNwgB0wiQJxqYArWGM5mByPTaITJWZqBeAgPcEKJY60L
 LniGKVvDl2VhvmX6N2vzr2Z2nadfP1SBaxriOtsRQ+SoiQPArtQ8R6WlZ0N40oS1g+Ak
 xcYhT+L0ie/qpJ2Ce8WtBiNu7PCjrX7C4sNRXOOKKgH5uYFyI/lVy4jCtG0GK0q7j6Ch
 bt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757364151; x=1757968951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SHu+39NCL3M5+f2JERBRiaCBa9DhGxQBszDvow8SwaY=;
 b=SSu31zloZHgpfD4acfxhNPZdPv7nwSKdlQK0A29gGRY7UOvEpWw6u1IEZqO1NoFA8c
 H9BQzO8HPbd+iyAjX61UEBjw48C0PgAcVS1fd+WEemLY596108BE+djN+a403cV05aB8
 cPooKIxkjw3TVJSgDYv23mIBD4RmsZSFs3m2WJVw/JQQbdZXBYoaZcE5NbRKTT5OMKvH
 ePO+Xed0K+OYmfbfTxZ3eGxhaS00f2jcUT5rYczo+zxF1Z6aVJus4H0L/jklyWfjRHYz
 eY9s3ujIQPp9HJKfWutOZJ3leE3/gx/HKCd+qq4keJeiKD8HkmHG0cRyC+iXG7VEWLni
 RiCA==
X-Gm-Message-State: AOJu0YyezYmpb7s/PqHJWSjJQmSXZNmBo1CmQ5NtWe2jUI2lBJYqcCQO
 SHDLDt2V2MbtwDN2Owpvwud1kl2J1V1UDgNdjbMYdldvJWosZuu9Gi9bzZl3s4hEa3k=
X-Gm-Gg: ASbGncuHcHbV6peCj4QJ+renqXvTzg1IV4pOcdpgSmWAYHFv+hfZmOq9vl3tMCEv6z7
 CzdNpW7kyA/cAWwqXRrM7eAtTJ0Tay6FqNe38vCZ7tlbguoTCRhp591TubV8VVu6DKeECDa7Klp
 m6ATFtNgR0PKAuq3AbMf3Yfs1/TLvhJp3z7jQ4Cv1ofKhPmYlx6ob1JpkHz0+BaHSwzFupwL76L
 /ZkjJ8cI/5FIzlGtFDjy+ZnMnmwBKv44wOpicsrithd11Oz1ogQ/BCktw2fcye22GVCi+FpaDE5
 M8YmcSHVgU1ZIKAz4p43VUFmHwbPFD/JE4WFo+kYlpOXLFcvPxtuyiEri0AEtw58oGgMuoeFkyr
 iLgBmrBeEtRvblTgxdWnAeF+uPQYV7uJbPPI5QGOzMsIl2Nvbh2ND94PJTgsiK/uEbSJcZQ==
X-Google-Smtp-Source: AGHT+IH6SrZ4rnHz0SdQjRvMg220svsa62ersD74iIWzyBzDtpmxdRORV5rrl2PO7nx/xzcW3ICpEQ==
X-Received: by 2002:a05:600c:5247:b0:45d:e285:c4d7 with SMTP id
 5b1f17b1804b1-45de285c731mr56026195e9.9.1757364151243; 
 Mon, 08 Sep 2025 13:42:31 -0700 (PDT)
Received: from localhost ([2a02:2f0c:5904:b700:1ac0:4dff:fe61:eea8])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3cf34491a65sm42026135f8f.56.2025.09.08.13.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 13:42:30 -0700 (PDT)
From: =?UTF-8?q?Silviu-Alexandru=20=C8=98tefan?=
 <stefan.silviu.alexandru@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Silviu-Alexandru=20=C8=98tefan?= <stefan.silviu.alexandru@gmail.com>
Subject: [PATCH] drm/amd/display: Register DP aux only if used
Date: Mon,  8 Sep 2025 23:42:07 +0300
Message-ID: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The aux channel is always registered if the connector is DP,
even when the link doesn't contain DP. When using the DisplayPort
connector in DP++ mode, the I2C is done directly over the pins,
not over an aux channel. The practical effect is the creation of
2 I2C devices for DDC, one from the actual pins, and another from
the aux channel.

This generates duplicate results from tools like ddcutil, for
example using a cheap passive DP-to-DVI cable:

Display 1
   I2C bus:  /dev/i2c-3
   DRM_connector:           card1-DP-1
...
Display 3
   I2C bus:  /dev/i2c-7
   DRM_connector:           card1-DP-1
...

The "real" bus is i2c-3, while the aux i2c-7 doesn't work.

Any read on the aux channel succeeds, but always returns an all-zero
buffer, further confusing ddcutil which just says "Maximum retries
exceeded", even if it will never work.

The dc_link->aux_mode is true if the link actually intends to use
aux for DDC I2C, so skip registering aux unless the link is
actually in aux mode.

i2cdetect -y 3:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
40: 40 41 -- -- -- -- -- -- -- 49 -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- 59 -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

i2cdetect -y 7:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

Signed-off-by: Silviu-Alexandru Ștefan <stefan.silviu.alexandru@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eae..1759071e02a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7429,6 +7429,16 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 	return &new_state->base;
 }
 
+static inline bool amdgpu_dm_should_register_dp_aux(
+	struct amdgpu_dm_connector *amdgpu_dm_connector)
+{
+	int connector_type = amdgpu_dm_connector->base.connector_type;
+
+	return ((connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
+		(connector_type == DRM_MODE_CONNECTOR_eDP)) &&
+	       amdgpu_dm_connector->dc_link->aux_mode;
+}
+
 static int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
@@ -7445,8 +7455,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 
 	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
-	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
-	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
+	if (amdgpu_dm_should_register_dp_aux(amdgpu_dm_connector)) {
 		amdgpu_dm_connector->dm_dp_aux.aux.dev = connector->kdev;
 		r = drm_dp_aux_register(&amdgpu_dm_connector->dm_dp_aux.aux);
 		if (r)

base-commit: 837f3abbfebdb355ed049c2b06b54108e2bbdf35
-- 
2.51.0

