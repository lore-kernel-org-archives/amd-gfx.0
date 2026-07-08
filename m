Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FCC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690E310E5DF;
	Wed,  8 Jul 2026 13:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I+50Nq60";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E757010E586
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 07:32:54 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cad225673bso3264375ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783495974; x=1784100774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Keeefd38WvRLYS9r2pdjAYV6V+Tg/ODVFYOu8UceE3I=;
 b=I+50Nq60qzntlBtWH5t/v5IZYeuNJSqu55QbT0HtFnbAhD7HsjioOf85tBnxMUMSOo
 K40zVz5qdlvvhBWnKOmh9lSqdKt04/gLSXGWgzV2fiUJtu9irzfKCfR5NmEb0meq/AMW
 Sa6tn99rR9pW/voljiRhRtHvuEAxggPNtNbRhtR4zjH5WEzj+jbkcLnpybhVggtDSj18
 ExyuCNTFWJWgPznH9/IMhjcuZn/GxntONVUHFj6b0PEKfPe20EV1n26eWcGZK9cPbsOc
 aCoN0uV7BYP16O4flUvT/9bhtTFazR0qEge7kk/5Tn3/+qsb0P9rBP3AL7118NZdp+Zm
 5qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783495974; x=1784100774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Keeefd38WvRLYS9r2pdjAYV6V+Tg/ODVFYOu8UceE3I=;
 b=Y1VsxgvENxqtwh/rQe2xvlud/ZBsxjZLtYXnHTZAfU6Lc55zDKM4q8tdAtForlmbEN
 MrAMjSgXoL94lVJdy36wxKKC70012OtAFmJWdko6bS569l6PMEGsouiYMbD/sky0evUO
 4ONRuUPWCcGwlYXKoLGCnrkiQkdPQu5Vcu79ZSjdMF1EjEUhW80ZT2+V2+pXut0CgqRR
 RlcEZnP9XdPmLebBbZ6Rl3IDBOUgtzeVkiVLRJ5hGCkyo7TZPEyJ4n5WxU4ou7zi/SQi
 3v60kaEIrcZlafzRPASOcdkE/MWj3uzVLc/1I3h/ylvJVSpvYyAlky3N2fBAa5no0tyI
 MeJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTPM/KKsFcuYL2boM/eGsnQh1QY0aVck4SD5fmXu8xKkmnCAq8tEL0Uk70nK0UmIXU06lr1URi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzS2qUntbp7ZbIzrEHU6TqmvNlDghUOG13dPXu0M49Be6TYQsaH
 K/3jtRngkcDFyVGN053bpW4DbNxZTgEaQNlQbYA2t9xbS+P2+Zg5OHV/
X-Gm-Gg: AfdE7cndevjL2d3waqDM076jtAVExxZRoJyx9uGiowf/QAJh/ZHUI9AKHR7Br4msWWD
 k4xlWV4Prb7x1/uFGDM6sCI5x3kmRC6Cos8zmzHFUyHL/0TgY6H4AG5/IQzJhE/p/iw04jbmIMJ
 Hsuc5SWjE/FeKyxKC51LntbeODQ/lchxA+Na7nXavUajL1NU9OkVD39kRyFEw0W+ACpQFW42juw
 Xy6G/tWePP/Z/tDHWBzdWGvWnKSI6FxhTOsM0uWIPVgs2qv4S09tLFKRO8B1i6ADwp2VQxw5BSV
 ysXZ92VVvyonM2MFgFMelUKSmdC23fhcqmdu4zYfwCNl3YLTnTH/yzrOScZt2ZncXXm9hnyo728
 evqCxagS07gKK+SXPQSR7mRNimOdf0gX/ejRKfW1gBH0yTwLAgS3cdlMocBM9ek/MfNb5KkA=
X-Received: by 2002:a17:903:b86:b0:2ca:bb6:e7c6 with SMTP id
 d9443c01a7336-2ccea36e129mr14778595ad.37.1783495974343; 
 Wed, 08 Jul 2026 00:32:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d2efsm23314995ad.64.2026.07.08.00.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 00:32:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ray Wu <ray.wu@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/amd/display: move connector state dereference after NULL
 check
Date: Wed,  8 Jul 2026 15:27:51 +0800
Message-ID: <20260708072751.724400-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:12:03 +0000
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

amdgpu_dm_connector_atomic_check() checks whether the old or new
connector state returned by the atomic helpers is NULL before using
those pointers.

However, new_con_state is already dereferenced while initializing crtc,
before the NULL check is reached. If
drm_atomic_get_new_connector_state() returns NULL, the function can
dereference the NULL pointer before the WARN_ON() check can handle it.

Declare crtc first and initialize it only after the NULL check has
succeeded.

Fixes: 1e5e8d672fec ("drm/amd/display: Avoid a NULL pointer dereference")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3a8d681227a..7b040fd7e3fb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8640,13 +8640,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 		drm_atomic_get_new_connector_state(state, conn);
 	struct drm_connector_state *old_con_state =
 		drm_atomic_get_old_connector_state(state, conn);
-	struct drm_crtc *crtc = new_con_state->crtc;
+	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
 	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
 		return -EINVAL;
+	crtc = new_con_state->crtc;
 
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
-- 
2.43.0

