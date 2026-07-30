Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9589AC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 07:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE18B10EDFD;
	Thu, 30 Jul 2026 07:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8hZD1P9";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE91610E07B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 03:32:35 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1294977a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 20:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785382355; x=1785987155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nPKPYDT6oqqCx028gjifMvkmNxES9gN8H4nUwaQApZo=;
 b=B8hZD1P94tYfIbiDwZmvqFLhxOp8LApeod5mxiaDITJbffV/oOpbUntvpk0+xoqjyY
 UbtACP2e5Q0rC17/Qw2OwDzVbD2/PMtuWAqETSWPCDIdWwxjRMUcz31kTIVaWwR1Toi/
 52Iyjez8cCbLKzM008K7j4KIow4NwU4t8ydl0oSlmAitBbu0xzfATfGUgTUpTXGhGJLi
 G7NzMbbY+yIXizX8866wuObjjTVJ0VRcALd2biwpaOQDTuJXPdKbYnUzFx9VumB0DsDr
 B/3mNiLvh1+Q9voibQglXRHkyVBoMJgsjPlBbRGD58zzm+iySKdLvN75q0i7YO8RnWax
 6Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785382355; x=1785987155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nPKPYDT6oqqCx028gjifMvkmNxES9gN8H4nUwaQApZo=;
 b=PGWmu/TNOiaERlr11GpxI4X3BSroRI0ZNa97+hiT9j09KuU1sV+M1ayw40vGjajpKS
 pIUS7xY/CBRrMTiWMonSImybFf5E4rFhr9HgW8i0CS3tWnBxNMLgJxouD5sds+TG7NYB
 IFPC+jh/p76OXKE4fD0eFTtJT4cK35n6onyCUc9TgQlv1npl0q3Duw4ZfRM7tsmgFtdI
 K7rhi5HHgmfrBy1Pvr7kgKbr2OKVudSdQgUxQcSINwGXZIKgxd4BnJhvxxp+4xYBdgAb
 vzGrRO/LHwD8qQOKWpS1yJVP3897qT9qXuQ738i2sIFyGdUfFKMnAhUrBz0mkXhaK1r+
 nXLQ==
X-Gm-Message-State: AOJu0YwzczzQ8mnLJ/ltW1RC9Xkb9JaaicSRFcVgHOWVbKKxgdPIcR/V
 xhNaef3ksIWtC7zI9w2uTf9HzuwzRKhmXcmBu6WDwRRdn9fY1DuC12+Cs07+7VGnPwU=
X-Gm-Gg: AR+sD13nH2wAfm5ZM2ynPbtz33L4nXS2VWqUBELOAn1YS6u/e9m1dTsH2VBD1+a2LSI
 CqYYquPG31FWiI9ZsyL9VsN1PwM04R17wp4GtPGQZcdBZh7KdWSKhgGypwpFBSPKHpusdw9COPd
 H9k/K6YQAcNq/s4keim6Rp1jc2WVpb9n4GoxO7lq3uQhTBxjtCCFkubX8gbZNkUwEC5Ggl94qKx
 z8pv54pBfoWpNJj2+TosyY2o9l8wq+dWeFgwa1LcwHecDpFX0AobIjxdAMWCJpXwEWlcUjEeCNO
 zCFG817Fb2kisy0o8mI+Ne+Lm7M8bvFt+Jj4JpUJkqaNyxiW1gF/ohFctY2f9w7H/HmhPoHo9kF
 grlYcK6JuPdIAjnfEdfUIa605xwhGDR6hQ7/qIs360fBaJBgvRGYqRnJ62MCF0rMEm13zoRPn8c
 C/ijanwh0TXum7pld6rrOpLQNW/tvsPiwVWVR6akJMTK3Vj8k2bvrUoMBErE8NSJuspWcv1n+Nc
 JLqgIeUZqfnQRgtBe/ArulQzCKOu8DD9VI=
X-Received: by 2002:a17:90b:2548:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-38f9bddb903mr856020a91.17.1785382355302; 
 Wed, 29 Jul 2026 20:32:35 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f9b42d6c8sm273249a91.3.2026.07.29.20.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 20:32:34 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, ray.wu@amd.com, dri-devel@lists.freedesktop.org,
 David Weber <weber.aulendorf@gmail.com>
Subject: [PATCH 1/1] drm/amd/display: allow self-refresh exit while entry is
 blocked
Date: Thu, 30 Jul 2026 05:32:00 +0200
Message-ID: <20260730033200.441730-2-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730033200.441730-1-weber.aulendorf@gmail.com>
References: <20260730033200.441730-1-weber.aulendorf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 07:26:00 +0000
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

amdgpu_dm_crtc_set_static_screen_optimze() maps sso_enable to the
Replay and PSR1 vsync events. allow_sr_entry is an entry gate, but the
helper currently applies it to both directions.

A non-fast update clears allow_sr_entry. During a modeset, a separate
hardware-programming event keeps self-refresh blocked while the stream
is reprogrammed. If vblank is enabled before the entry delay expires,
the ISM calls the helper with sso_enable false. The early return drops
the disable request, so the vsync events are not set.

After enough fast commits, allow_sr_entry becomes true and the
hardware-programming event can be cleared. Since the vblank reference
remains held, there is no further zero-to-one vblank transition to
restore the missing vsync events. Replay or PSR1 can then become active
while vblank is still enabled.

Gate only requests that enable static-screen optimization. Always
process disable requests so a vblank requestor keeps Replay and PSR1
blocked.

On a Phoenix system, repeated SDDM-to-VT handoffs produced stuck flips
followed by flip_done and commit-wait timeouts. The timeout was not
observed with this change applied.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Claude:opus-5
Signed-off-by: David Weber <weber.aulendorf@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 95d3da3c4..06598273d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -119,7 +119,11 @@ void amdgpu_dm_crtc_set_static_screen_optimze(
 	struct dc_link *link = stream->link;
 	bool set_vsync_event = !sso_enable;
 
-	if (!allow_sr_entry)
+	/*
+	 * allow_sr_entry gates only entry. A disable request must still set
+	 * the vsync events to force Replay and PSR1 out and keep them blocked.
+	 */
+	if (sso_enable && !allow_sr_entry)
 		return;
 
 	amdgpu_dm_replay_set_event(dm, stream,
-- 
2.54.0

