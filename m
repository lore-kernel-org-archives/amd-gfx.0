Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC8C5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A0C10E6A6;
	Mon, 10 Aug 2026 06:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwWtPsYh";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142A510E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:00 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so6906275ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252379; x=1786857179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7uC67/V7nwNWq+dWDB8FGNBrrM/47Cbt+1oF506R3e8=;
 b=VwWtPsYhFAnzKWIsFEAN2NzuewdhImtqvE1yIwuvyUdmGqU0vRjzpUwnqSHBr96Y8L
 EYvL56YsOVqip6lDnb+OBf26D3+tvVRQ5lD1qsCfZQ+cDJahhPh9baw99vtyNT4qqKro
 Bo8PiU/si8rd4P+e8CsTIU0kE03LdfrCcVWpt0XYX3xuFqAkjEXGcfQe1woQEWc2YetB
 FW920oeyH1eSBJmLqRSGA3SOJ1kakqrv7PfvPr9hA5IpG1Ps3SHqQm429XNKAGmXWMnc
 gKYjprfvHuwpFBZFuRWzSrEdhb9SpeV+GtqmTMu8oAa7gBWt7X8QsLNefCJc1/brhqW/
 NzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252379; x=1786857179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7uC67/V7nwNWq+dWDB8FGNBrrM/47Cbt+1oF506R3e8=;
 b=gHqCmIlP+nrnnGPzSVC8knzYP65n70OlduIVGhaXK+3kaTcR0wVRtmlL0U1mgWJnzR
 ZYjpgzk6NCDwqn0LagBEXTlkvvO3VR4muyTKVSM+KBxs+uLG8cU7Z2jgxpjuQaUb3rn7
 BHWOCA2MJcQ0U9reBMP5WXWbrueMIgWyenSqy/JA80fII87wZYcUkPUSVFkJ7fLOEywv
 MPi8ppMWbhSYA196nBezwAweO+Sd/rsZ/lyNs3iGdwN/Q+eV5RaNS4sNAWm57jLURpAu
 r8A6P+2Zus0SMF36zCPxQNLhM5D+Pp40wvGchACha22WPl1ZsSuWo01XiepfFJKiuYB+
 eYNQ==
X-Gm-Message-State: AOJu0YyfZjunGrqXje3pNJLjz6o0WXX6nIxI/gt6+16LUYtSrNbPt0mc
 v3cp1/ZUJBOsTTseqmddPUARpg0hGrIPaVpYqce8FlL99dajA1m3wGBd
X-Gm-Gg: AR+sD12yflqBfqobomvK4HF9H1Pcyz+4pVjrK+G6qg0ZigBQ6U0uL9MlAhrX7KzZO2a
 pRKXvAlqU6SRIolrIx+2rc53w+cSNilmqFcK/E3Y5gqILM4yxzLE9TDHMpRvT25CvOv8N93ABjw
 ov9llPfgLVGWKsClVgrsjA0fjDV4y8Dj6RYVJuMNA1hlb6d+7nhbP9b32rVRLX3xJgKXVG9Z9Fu
 7YkRwSry9NEAdtHayZ2yp4PQDG/PLYUkCu5zzizLK6k9n+zP5rD7N5zMQdQ5b3dRGIh8kgy64NS
 1Aef7E+iG/Ips3wyWA+QOF36cDSmZdQZ6qQHFCdqVbeMnfnrYnXsKE2gZhjGp2fL6U4fpYAqcs2
 URk3RkahhCubvDI+5HCbv6//WRkNH6/TG8EhIdPLMy2AxTAyFyZ9LPkhsMGw1nh5tS8gydL1+0a
 dYoq/zy6DComXxvQ7c8wPXNIT/P0iv2SViRTlnZDFw7LgUhlKRqGW2VVDvUrTkQi+/V/Wvu32+m
 jA+1k96+8PPWn5/LqyjyMqx
X-Received: by 2002:a17:903:3848:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d0ca70da11mr418477765ad.8.1786252379391; 
 Sat, 08 Aug 2026 22:12:59 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:12:58 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 0/6] drm/amdgpu: Robustness and safety fixes for ACA and
 RAS drivers
Date: Sun,  9 Aug 2026 05:11:54 +0000
Message-ID: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

This patch series addresses several race conditions, boundary check bugs,
logic inversions, NULL pointer checks, and buffer size parameters across
the AMDGPU ACA (Accelerated Compute Architecture) and RAS driver
subsystems.

v2 -> v3:
  - Patch 3: Updated amdgpu_aca_get_error_data() to return 0 instead of
    -EOPNOTSUPP for invalid handles, ensuring global RAS error queries
    safely pass through non-ACA blocks without breaking telemetry.
  - Patch 6: Moved cancel_delayed_work_sync() in amdgpu_ras_fini() prior to
    ACA subsystem and lock cleanup to avoid teardown races and UAF.

v1 -> v2:
  - Patch 3: Updated remove_aca_handle() to use list_del_init() instead
    of list_del(), ensuring list_empty() properly evaluates removed
    handles and avoiding potential UAF during device teardown.

Sreeraj S Kurup (6):
  drm/amdgpu/aca: Fix race condition and UAF in error cache logging
  drm/amdgpu/aca: Add upper bounds check in aca_bank_hwip_is_matched
  drm/amdgpu/aca: Fix inverted validation logic and list cleanup
  drm/amdgpu/aca: Add missing NULL check for banks parameter in
    aca_banks_add_bank
  drm/amdgpu/aca: Fix off-by-one buffer size parameter in add_aca_sysfs
  drm/amdgpu/ras: Cancel delayed work before ACA teardown in
    amdgpu_ras_fini

 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 35 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  3 +--
 2 files changed, 15 insertions(+), 23 deletions(-)

-- 
2.54.0

