Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1C0CA5FEF
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 16:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574E610E2B9;
	Sat,  3 Oct 2026 16:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXXJ/teN";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFD910E158
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 16:15:54 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso477724f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791044152; x=1791648952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eJALif/NZKKKwgBHANRUIYhyULS4mSKxyPgmAZ59sbU=;
 b=lXXJ/teNPZx4OCWKpqxSiAW9yYL48weKnf33lXBvhRA/Uh0y7GZ4UVUrAvDVXWSOXq
 KMT65WOPkuVdf6Zyjl6BTPbuFz4v0e99oIvBxchZnLivhCyyoDNviOdQ/WZHqz/4MCG2
 Q8BlHvlVuooQkRas6Mez+Cau7Sf/RRtLgk9D9sQdWUZTdTdiI0iyy2j6yKFoCTshyOeS
 2IV67OkkI6xFwgu24h41txzZUVpwvhYSgo+jmGqTluk0TZtdDV10b1CTOuRLZMEN53Px
 EWEE2mHmaNCy9ApV5VVAd29lLFi0TLSqqYVi0ZtSDN7KmSPf2qzJSm2GzhM7OtfhPHVI
 VPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791044152; x=1791648952;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eJALif/NZKKKwgBHANRUIYhyULS4mSKxyPgmAZ59sbU=;
 b=ACv3/nYDFQgyyu7tkj4DxmH8GmCP5R3GS/Ksds0AKplNfzr/ZWjHItfE6uhcdfJmR8
 eiX3yJFAslPX2I0BG7ioRXLkxrtBK/bjF+owwNm29BQVlqAvowYUOsk505+45y4NsKUF
 Hjo+fHbCi6O3HuMJAt8AGv/D9Wf52ZKYIcLbs0nsn7nVzzYD4uMonkv+NG+bEnn8qtvD
 0oE+a7KIKc4lMzbFmvGpm3YE9foTby+kWb4gANmoNrBvmg+EKHSBHEwSmfQZUtfga+dY
 UM1WE2/Xq77Um3gIqwYBG57xKck667tyO+SsvsICnUfl3XXrBZcGxlMgPClSh8EKFMsr
 hsSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLRfoEnRBUE2GtAapbTos6iRFt+SyoKvcJf2SEAL9qCWEwqq8PqCMztl7qAWvSy3ytOHCt7YB0@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIpgknB2z0QhJSd1gh4kifK+VSnQG8QsuKy1zrY1RfgzuZiE3Bl
 a127d8Difm66sUgP8P4alTrP3TcMMI9qFGlwSi8a4ho7xuyaOFpVaFLN
X-Gm-Gg: AYBFou1UD63im0hw9NK8sEZ8BvLrhxbgPQIWzf2+dRXCVQmGxlrNWLIyPEhJt3BxJxf
 8MadeO4xHs4ymzsRldgbDs2ezNuk2Wd/yY16u8qkU6NB4kXiVgT7bGaYMvURiZ33ql5jGVsJOAn
 QWl0R6flApzLU11M7jKsNhBaeD8YYjZF7vHvDFciZcTnYr3cCi3axsB3ZAeSLh9dOoOavsDVyYN
 4DkKSJ7gJUiOO+s1JubHyUUa5Jq6FDXXdm5WRR6//86SPCNJ2KqutZUGgRkWBdQO4xfdnGCl3X7
 7ar5t0xOXZOQGEKVY7vr3Rq2kFIN+UUHyI0zA0CL2FlQxJB+YU5ot7ixIYYlZ9EdULT/wJPydxG
 ZnDfo7JDAmEV9vTCsfFzGzCAWITU3Bf++LcPE9+ye9053JaNNHu5VpMBAj52GeynLfOmPFq0knO
 uKeJPgDo05JYFa9bPCNBlZEWOUNHaHxBDoFuELqNS8081+tpBRcwqFwu3p+4ocsJHgMk426lsS7
 +09N7z/uxsUlaGifFI9LYpQf7xXTrhSvtwIXBA5SYxILuUs+bviKlEwD6AvMFHOE6Q4
X-Received: by 2002:a05:6000:2382:b0:488:84af:caf8 with SMTP id
 ffacd0b85a97d-48c48018dddmr3795373f8f.55.1791044152278; 
 Sat, 03 Oct 2026 09:15:52 -0700 (PDT)
Received: from localhost
 (p200300eba703ae00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a703:ae00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm14067659f8f.37.2026.10.03.09.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:15:52 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/2] drm: add edid_overridden flag to drm_connector
Date: Sat,  3 Oct 2026 18:15:07 +0200
Message-ID: <20261003161525.23600-2-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261003161525.23600-1-johanneswueller@gmail.com>
References: <20261003161525.23600-1-johanneswueller@gmail.com>
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

When an EDID override is in effect, the physical connector may not
match reported capabilities. Adds a drm_connector flag that allows
drivers to detect such mismatches.

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
v2: rebased, no functional change.

 drivers/gpu/drm/drm_edid.c  | 2 ++
 include/drm/drm_connector.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 42f4e41c459f..9ea6f5f19131 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2424,6 +2424,7 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 	struct edid *edid, *new;
 	size_t alloc_size = EDID_LENGTH;
 
+	connector->edid_overridden = false;
 	override = drm_edid_override_get(connector);
 	if (override) {
 		alloc_size = override->size;
@@ -2431,6 +2432,7 @@ static struct edid *_drm_do_get_edid(struct drm_connector *connector,
 		drm_edid_free(override);
 		if (!edid)
 			return NULL;
+		connector->edid_overridden = true;
 		goto ok;
 	}
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 899643586bb3..d242fb922741 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2394,6 +2394,14 @@ struct drm_connector {
 	/** @bad_edid_counter: track sinks that give us an EDID with invalid checksum */
 	unsigned bad_edid_counter;
 
+	/**
+	 * @edid_overridden: Indicates whether the last read EDID was an
+	 * override (e.g. via debugfs edid_override or drm.edid_firmware kernel
+	 * parameter), which can cause the physical connector to differ from
+	 * the advertised capabilities.
+	 */
+	bool edid_overridden;
+
 	/**
 	 * @edid_corrupt: Indicates whether the last read EDID was corrupt. Used
 	 * in Displayport compliance testing - Displayport Link CTS Core 1.2
-- 
2.56.0

