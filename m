Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369B4E6749C
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFAD10E59B;
	Mon, 22 Dec 2025 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZdBsZz3";
	dkim-atps=neutral
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125AB10E1F5
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 11:46:55 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b79f698aa91so57341566b.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Dec 2025 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766231213; x=1766836013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGC/wXUYiYQsnh5yWNhZ1+GGzCbr65mZk3jPLwzdXjQ=;
 b=ZZdBsZz3yAYWxS0od0NW9TlIJaT65mXFer87O7lcmqQjTffyF7HqurvfXkWQhEGzvs
 jsfpdoxqx7YVVFTViZ27bWCB4vYutsFOlcrs/oJH7eKs5jV/MU2L7HuN6WmxjogwGKIs
 cnsLcRZiZNRGgrMkssu1ZLSvQVT2vDYx7O27AUAlcE/0laCWkdzirVPrXRcsj7jj2hxX
 8RdQhrGZjtcVQCdluO3j0tmM/ew6Ym7sEw9r8BYbG2QOtxySp2IvVz68+hfHBWzhUyti
 U4MsV+Lpfk2zxwTJ9OLSlL4/ngpSB6Dx4pCeQuelr3UuUW2cwlUhaZwODaqz8GxFii9X
 HKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766231213; x=1766836013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGC/wXUYiYQsnh5yWNhZ1+GGzCbr65mZk3jPLwzdXjQ=;
 b=ABJHc5YXNO2pEft5CULr2S9PuJAcNswfuA+g+I6vMZDf3jRx8IE8m5qzhHc3/8OeQv
 LhFRWKWcjESFfpKs7/rj2Wuvr+1Y374fhTw+tz5YqAKLUqfeU7G2/d5eBIPOTtx9UD93
 /2ZMvfbPZ6nDX3dP14CxNFXmJ1HrQ3RNBOlj+up+2wl6bak/xx5Th+WT4PVVPJ1HQfVd
 TYUc2573ZjMv3TNPOqRBvas6Sbc9Ip3YSkKWmLgRWI0PEr7JzDpMJh0Cv6PTCdtC1Qa7
 UpjRL4YpMQaRoRYemzl57m+Bsy6Pn4ejKtuJ1YmrkgDLu20eQszb+/bLjW0ioXhZFB1h
 PrXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9IgHZjJfDn79Fk6oa903xw1Yq721M7ToMgyiWkABhu+HwlkOZMQVQwYjcVDBnftbMCCCKe3/N@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1ROWcOjzvv1Fak5eaOmFl+OGCUtxQRgmgEF9puG4k2nBaNRH7
 HuW1e2mxPrNz7PGvvRB9ka1FugqCEF8z0F89OLRy4KwDr4+IPS62Le6m
X-Gm-Gg: AY/fxX7T5e8Hb6fd70C1rlArmLYuZGNhP7q8gtZG67LIUciGyz7zIwYfrjgScKp/Gmf
 n8lBYrUZ0vInOunKN67Jtkzse0Prw38PjMnVQC0HbPXE//eaJsepse5qT3rOT0Vn8IZipLlJslm
 w0elUztjsJ2ZAjRa9DlpUun8hA/wCHSODMVIybIdUVQfZIEbop9UBpXnZD95zVJQW74oZKLwXxF
 GsIDnXp5RnT64SSJRXqNqLY+vUKLSi6nV4HPHCitmMrfUbMaYrbcCAEJ+g/VQSR8FNsWmXZPQS7
 74wlxwpg5sP8ABs3bsYJV5Q6afPq4jwwkyRT54f0tLJ9SVaScR/IETUwg53zE46i+j2tUgDlJCb
 WECEXkflYrC18YlslRbcl48uf7qpHRaseUv+Qvsw6rZIX3Jqp8/JDmnz8RslBRjljdQfu5um5Ds
 5iRbpXvUDTsdlgtp+nWhCWX23BpaYcyI+xKBXRlNM+TG+rOOt4LpbVp0YxtdYVzfk5
X-Google-Smtp-Source: AGHT+IGQ6x7ZnQVQeDaeNCXSqDdMpW3yy2ZBTCiOeV9sMFDd0x+AREowv3nhxI5iwK9TUZGpZQMLkQ==
X-Received: by 2002:a17:906:dc91:b0:b76:3d45:51d9 with SMTP id
 a640c23a62f3a-b8036954bddmr355980566b.0.1766231213246; 
 Sat, 20 Dec 2025 03:46:53 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5bdb9sm495449066b.7.2025.12.20.03.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 03:46:53 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 bernhard.berger@gmail.com
Subject: [PATCH 0/4] amdgpu: Enable Adaptive Sync over PCON with HDMI VRR
Date: Sat, 20 Dec 2025 12:46:45 +0100
Message-ID: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

Adaptive Sync over PCON is only available as FreeSync over HDMI. TVs which do
not support FreeSync, do not have working VRR with DP -> HDMI 2.1 adapters even
though adapters will take care of HDMI VRR info packets.

First two patches add generic drm edid parsing for HDMI VRR and ALLM.

Since HDMI VRR relies on FRL modes, this will only be enabled for PCONs in the
VRR whitelist. HDMI VRR for native HDMI connector will still not be
possible/attempted.

I myself validated these changes with my Samsung S95B + Bernhard validated on
LG C4 + FreeSync-less Sony Bravia 8. I used Alienware AW3423DWF that only
has HDMI 2.0 to check that FreeSync still triggers properly for "older" hardware

Tomasz Pakuła (4):
  drm/edid: parse HDMI ALLM info
  drm/edid: parse HDMI VRR information
  drm/amd/display: rename PCON adaptive sync types
  drm/amd/display: enable HDMI VRR over PCON

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 .../amd/display/modules/inc/mod_info_packet.h |  4 ++--
 .../display/modules/info_packet/info_packet.c |  4 ++--
 drivers/gpu/drm/drm_edid.c                    | 20 ++++++++++++++++
 include/drm/drm_connector.h                   | 23 ++++++++++++++++++
 6 files changed, 67 insertions(+), 10 deletions(-)

-- 
2.52.0

