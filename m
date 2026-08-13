Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B04BC5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 12:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D6910E286;
	Thu, 13 Aug 2026 12:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSUOzEXG";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A878D10F2CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 11:27:03 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so2143352b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786620423; x=1787225223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
 b=GSUOzEXGHDGDfqUpCxTuhdKXfDDk6MkZ/vdPpeymS5eSH5IoD7P7SdTE75aaDqawzl
 qlW+rU9UUmKSNS0Uj+/mcL2uxaeJV/MiEHt0Y4ZGaVj43pIM0MmkOzwxykcdXRnIUv0z
 HHXTukLxlx6gTNGRk/rxqTpEHAtouDfUiUW/IvcivK6eC88USirKXAJU1anaaQQNEFYt
 dMrJuP2mhYlVpPJZjd/waidX6+osQMVDNDHmYJ56MaEtrQm04ZvEMCvQVFqW3Pb9+KKz
 BLFc6re6qHsWf+BxUQcEG/v8y3wTVwvYgqo/0rV+eD2VUH/yy2S4Z7D9DrIzS5JWELvY
 bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786620423; x=1787225223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NRGBrMNvLSobAjKhMm1lIf6g/DD55p77HOff+VMHwOw=;
 b=jRKZk+plw2ADgyd1yUfJS5lYSmzBgND0Ez/hS61TunhpVc/i4dXABjIZqieSIquW41
 nYu+qa0pT76zTnN3fjG1iq9FXvAIZmk2fb54yT9+M2tdbIavebXbPU3mTNo2dvtURmcl
 7XNrNcQ+z74czvjs2ItG9wuDAFI8mU7ACiB6QuXLxoJhLBmivkX/B/uETdnMWATilYxQ
 KwcT7/dbsCn3oYy4W4Eh55qP4As7iG1SaUea4Ma4v66zmsrs8QsT1x+OgaolBjG7yM0V
 v9/SGXD9RTeFa20/+3S9bSrD6qlfSOk/sHUzRzQz3jjJ0X29kQYARkkj+9OSjcQyE5I9
 Q/qQ==
X-Gm-Message-State: AOJu0Yyv34FxjWFsmC7vuihCTk1YIIFZA2JruWBTg64BGVHgQ0q0MMb8
 U9UTidZIs0pmS7Cz5BdTrTSKTJRVNyFbVxRc7Ev/WwX+pRAN6MZk2KIjNDMd11a4P1HUHw==
X-Gm-Gg: AR+sD10KsEmbZ3wl9Znk6FNLXO5bkMv9r7lR3+epdHXusrphP2Hk9+1z9BIgXNdYnaN
 xHXg4i2YVfF1UuyJH3eWNefxn2TFsDpr5SQujH5G0AcsRQMMmBojYLm484JKokqdAvh+a9wF13s
 XXKrMbQCdFOo+he+Nn1AAJAc4Ayprqo95Dpui6JlCGjSqcqyP1hn9j5PSLadgdudVrdBT4B/ETM
 cST+zvmbL7LbA6xx/KPhTQ5kfs1G6YCxctSXl1RS+no9RF6OSVfQDe/zkpUwwJhltfyRoOVqH/h
 gV3unBS9DSTiMi/n9QyfwNMwNNV1ijh9tvggM9VZlRWymziUHBE9teGzNxzCQp86CC02I8MgHFM
 jGwdVV6n9Hk/m/i9YymZIsAbSnmq4kpvSvsveKIxCzgwTl0bdQY1XKHBA+qG1UHpo0BRAGCRFe4
 ghkBFNHBWX3Ffb5Q95zHzsijgTAR2U9ZAf2LX4KsPn6Zm+DutVWxcabUPZM3hetDheKTSfg8GMF
 3qolffMEKmbng22Mc3LTS2p
X-Received: by 2002:a05:6a00:2999:b0:848:788a:e7f9 with SMTP id
 d2e1a72fcca58-84fc6dc62cbmr5033736b3a.18.1786620422989; 
 Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:27:02 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David Weber <weber.aulendorf@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: Skip connector updates without a stream
Date: Thu, 13 Aug 2026 13:26:33 +0200
Message-ID: <20260813112634.11455-2-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813112634.11455-1-weber.aulendorf@gmail.com>
References: <20260813112634.11455-1-weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 12:59:36 +0000
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

Atomic DPMS can leave a connector assigned to an enabled but inactive
CRTC after the driver has removed its DC stream. A later atomic commit
can then change HDR_OUTPUT_METADATA or Broadcast RGB while leaving the
CRTC mode, routing and active state unchanged.

That property-only commit does not require a modeset, so it reaches the
connector stream-update path with a NULL stream. An HDR metadata change
passes the update bailout and reaches dc_stream_get_status(NULL), while
a Broadcast RGB change dereferences the stream earlier when comparing
its output color space.

Skip stream updates until a stream exists. The connector state remains
stored, and an enabling modeset applies it to the newly created stream.

The crash was reproduced on a Phoenix1 system with DCN 3.1.4 and Linux
7.2-rc5 using a one-shot AI-generated DRM atomic reproducer:

https://pastebin.com/KxT1BcSs

The reproducer first sets HDR_OUTPUT_METADATA on an active CRTC, then
sets CRTC ACTIVE=0 to remove the DC stream while keeping the connector
routed to the CRTC, and finally changes HDR_OUTPUT_METADATA from one
non-NULL blob to another. The last commit does not require a modeset and
reached dc_stream_get_status(NULL) from amdgpu_dm_atomic_commit_tail().
The same sequence completed without crashing with this fix applied.

Fixes: b232d4ed92ea ("drm/amd/display: Only force modesets when toggling HDR")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1820547b1dde..13101a6be437 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11519,6 +11519,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		/* DPMS-off leaves the connector routed to a streamless CRTC. */
+		if (!dm_new_crtc_state->stream)
+			continue;
 
 		scaling_changed = is_scaling_state_different(dm_new_con_state,
 							     dm_old_con_state);
-- 
2.54.0

