Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECE8E98E09
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F71210E286;
	Mon, 23 Feb 2026 08:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/YNVvpl";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5405E10E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 02:52:19 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cb4097794dso402981085a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Feb 2026 18:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771815138; x=1772419938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uW2bmrIf7wU/GXSosfCOnygemq0h5S29C3M+QhYhtC0=;
 b=i/YNVvplLtMBW0Qy7zftJJV6eDn77CPoiEonZuH/tGPFaLcRutME26c644ourf0bQf
 SCHvTbBTgXqgR+8zc+ZtmMiJxq9wRikiLw1Sz41tyD0K2jGqovFiGtPe+Ou8IUrA34Mi
 AdTv/L506nDgqOtqSQ4sxHQ4erg/vFav7SdKhYkHhNWsUsTTysIvlhQmfNg/BMX8WeP/
 a5v4sSwsreKfVyvF0kztyLouRaob8rMPNsLzAXuJAwiyOxEO1fYcqiCjvqUhwdAmYD4q
 kXIom8lmKh4JwkPbHga8b/PiBDNBkL7T/iA7N4e5m7dNAaOOC/t1yCAelvVxj5njbtCg
 dplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771815138; x=1772419938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uW2bmrIf7wU/GXSosfCOnygemq0h5S29C3M+QhYhtC0=;
 b=dUiS+WBCrXRmQ1KLBYeeGHRr+0uZZatiUVUWbtX38YI9zxSaOz0PhflwLV/mKOCgbz
 Jg/dxVv8mo40UYs46c46mt8nbt1jRUk2UhrEPV3atS6ddfV2KvobLsngoYiIonCqtW2Y
 Y3dKDdBjfjIh0ZokjZx4TgmB19oXvTwtJjf25njpSS0hyBCBU0TwmOHN+3c2p87TaPgS
 w2PEogk1WFrwQZe6PFB7wRl6Dm6ZYU2kXVT2klLLNR/h1NAkyLEymejpdeW4N+/RUkQp
 f6CRJYYaFT8j8/3UmpPAukflnRoRDMu07I/MPXM6Hm+rc/1kyScBDei15tensBSHoV3k
 8d7w==
X-Gm-Message-State: AOJu0YzIbhFvLo5/I5sstFFiFAgoXapMlFuegecWmxDPILzl446kk0Lh
 pAUfmfZWJ/IIhsSKq7xgKw0DMHvZ5wwcOV7uLPmV/YBvvC0BzgKR9uZv
X-Gm-Gg: AZuq6aKEXQ2Gyj/2PH3M1MI+Ls0Qybgt2CSvLe0J4OcoAo0/eq6pxXDx3WRkdZH+XjK
 jALtFS78JI8njO4Ev++CAdD3VbgmBdDVc6z1RPtvsXdfCl8AVPvaAnbr9C4CMk9u58mEbyTttAp
 33CtCA3F/381CtG6zAXBal3KWR1EgtDMXZOf7B32K1mr+TxqkEqMWcfRven8EoED9SuQyHzhBMI
 /a+2xlc21ggZsK7ODcrm+wLzmSBF4IYsIp3sTjbO+ps5jr+9lYbsDq+9936VsCuJHF9HFCgwoKt
 GH0bEZ6RDliS7PscHjsh10eVeoYjQjFBeVPLOTXJzHKZ7wfh9IrdYFvS7O5DY/xBJE7CKZHXiKQ
 PvVXrahNxH2upSJIQtV6wV9I0Cs47dLHpambUcX9pIomq4f0ScUok1m6zIJXUJUuiF7Jw4+3n3X
 H+d2AUdDT3EVQyhtCzurdSKgqXJNU1ip7dwEM92iMCjw+yuCfyNKxqOAIxraYTYFxtdnyVRI27Y
 tY+IsiKjU/IXMNGxukJrC4Sept3
X-Received: by 2002:a05:620a:bd6:b0:8ca:3e78:ef79 with SMTP id
 af79cd13be357-8cb8ca93037mr774653085a.77.1771815138182; 
 Sun, 22 Feb 2026 18:52:18 -0800 (PST)
Received: from fedora.phub.net.cable.rogers.com ([2607:fea8:2bde:a00::3345])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d06f422sm610608285a.20.2026.02.22.18.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 18:52:16 -0800 (PST)
From: Hayden Heins <hayden.heins@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Hayden Heins <hayden.heins@gmail.com>
Subject: [PATCH] drm/amd/display: Fix incorrect log message in LTTPR mode
 selection
Date: Sun, 22 Feb 2026 21:51:56 -0500
Message-ID: <20260223025156.27490-1-hayden.heins@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:06 +0000
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

The driver was logging that it chose NON_TRANSPARENT mode while actually
returning TRANSPARENT mode in the case where vbios_lttpr_aware is set
but vbios_lttpr_force_non_transparent is not.This upgades the log message
to match what the code is actually doing.

Signed-off-by: Hayden Heins <hayden.heins@gmail.com>
---
 .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 66d0fb1b9..889c81aba 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -166,7 +166,8 @@ enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
 			DC_LOG_DC("chose LTTPR_MODE_NON_TRANSPARENT due to VBIOS DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE set to 1.\n");
 			return LTTPR_MODE_NON_TRANSPARENT;
 		} else {
-			DC_LOG_DC("chose LTTPR_MODE_NON_TRANSPARENT by default due to VBIOS not set DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE set to 1.\n");
+			DC_LOG_DC("chose LTTPR_MODE_TRANSPARENT by default due to VBIOS not set "
+				"DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE set to 1.\n");
 			return LTTPR_MODE_TRANSPARENT;
 		}
 	}
-- 
2.53.0

