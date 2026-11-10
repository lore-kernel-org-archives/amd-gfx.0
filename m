Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AF606E47B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOTFS3pU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8C210F6CF;
	Tue, 10 Nov 2026 13:15:44 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D7510F6D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:36 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso288303466b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316535; x=1794921335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PFzJ9u6YQvTMb93owgIg27Pbi0f8hK4InZkJZISUcYQ=;
 b=cOTFS3pUbEhQOUeTyVxJ3WIA+KeAcxB2JexFv37o99Eh5s1sgZ3QEWf5o1WMQhmDAj
 Ikuma2um0NH79oAPLWhsQaV9kTIElYJX4Ukwh/WvyvYmoXGKoPRZwO08sBLc+RrRFg6B
 +s+prOZTP+tz09wdN5aqZOhGS4mIIk8X2QryVDBkiqj5WzzmioUT+KH+Tg0OfQ3XqukL
 4LIihse/ZJ7GyKUWhCre9tPUN6DE3wt3hxOgve0M9dpM0VMCGv1YJ4/YUgJiSrSt/K8y
 Smd01Jr315VF11hm+i8t4lB30o9KTCuDH9Azd9PDi+/J8ik7FvKXaVnvSodJb9LkpLgb
 bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316535; x=1794921335;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFzJ9u6YQvTMb93owgIg27Pbi0f8hK4InZkJZISUcYQ=;
 b=1EKzyd+kL3IMaPSNZU4fxCD7MNki32wsz58XLVRpGqqGJoz4r1IyhGp2Ce18WgCS7W
 olLPiPOwkDeKVphFD5AlviogCnLdoP6WQJKs28VOdioW8dn/xgRxeybW7F+IcmtvAmMZ
 MLeAk+NIajaE5hzzvb1Op/re7iPAf7hIsJ+i3mM+hmeF2O0qUCg85JLyHCkPdVnQrL1K
 /pm4ZpMgQ+sKC6glrsA9oU/mh4MVzGgm2PbpgFu3nb6MvwGp0rzv10Tc1gJHy94+toPg
 701WMjHXLpwpMDjk9Vfz/9WqYjSoWJr2GyAA66/hm8GgE77X94tzcQkuA0Wk6qc2/8wa
 UsEQ==
X-Gm-Message-State: APuU4Z+SkpeKupJbQrV4NBMdAXDKk6+jjZ7xv50VIc/Ha5EnbkxESDdo
 dhiSbwH67/tmsN6+33U2g2l/g7+LZrnVwxB9XApXkEFUIOzJBQcvLr31o6YvRynj8Z0=
X-Gm-Gg: AYBFou2+CIn7s3kHddAk2VINtPVOwXVVnC44VF9wOLumKqeLrgJ1/FfEXtxYH21dMO7
 g29Jt8yaKGW0grd5MEEYeRack0FFSRHFBCDxRYq+I31Q5Y18Im0jJh0vFX4uYLbT2CLJ03hRUMp
 rl5HsDruEwQe3CkLLudenaWgZghcQ9fszFIw30dKjsAFTPEC9NQLSGWFK2MOlQdNitcSkp94Pfl
 Dg7EpkVgToxO8Cy7rzQ5+BANLOmXfDcTMbIjmNcOvsAypm6tVNTikhDb84VYK52dDyb6BP5dBrF
 vsW5qG8qQt3jA79CoZglKsXi8Tuf11psvnqJ3M5GqConYMIVOko1HHlUTrta8JzCS2yXw8rifxX
 F9OkDkTxld8brRVry42OPzZ3SsAnqZ3wU602hKksIkSla915+SGbctMfhDrtqeR+fSS6DgS9rxi
 D7TyY/OxOaj6gtStizuOOuol2w/1Kvtz+PhwI0tpkBvWJuJEwhpsd47ISxADCbaiO7aU+/+G4Xj
 /vGNKZiYX3klECHCojFW3d/a8cKLeLoYCAZY31VSNKSREVKAonVH0zNLuUz8JAMO5a+Pk2t+phi
 E15NqazlCBMY4+8LRejYWmYtO34BxrIbGWvV8oYa7EuHpWKRj9TVnQArSH8jZaxYg5VfHN4ktr4
 =
X-Received: by 2002:a17:907:3ea4:b0:c41:61b9:6ef6 with SMTP id
 a640c23a62f3a-c50495c8f3emr210672966b.27.1794316534613; 
 Tue, 10 Nov 2026 05:15:34 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:34 -0800 (PST)
From: =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Retry the same FRL rate after a sink
 timeout
Date: Tue, 10 Nov 2026 14:09:56 +0100
Message-ID: <20261110130956.160024-4-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hdmi_frl_perform_link_training_with_fallback() lowers the rate after any
failed attempt, even when the sink never answered. The enable path,
hdmi_frl_perform_link_training_with_retries(), tries the same rate again
instead.

After waking up, a Samsung QE65Q80T (2020) can stay silent at
10 Gbps x 4 for a few seconds and then train in about 33 ms. Link
verification moves to a lower rate before that happens.

After a timeout, try the same rate again, up to max_retries times per
verification, as the enable path does. A sink that never answers costs
up to three extra attempts.

Fixes: cbb8e2044b9e ("drm/amd/display: Add DC link support for FRL")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Andrzej Piątyszek <andrzej.piatyszek@gmail.com>
---
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 97b2b9b74..129834d6d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -818,9 +818,14 @@ enum link_result hdmi_frl_perform_link_training_with_fallback(
 	enum clock_source_id frl_phy_clock_source_id)
 {
 	enum link_result status = LINK_RESULT_UNKNOWN;
+	unsigned int retries = 0;
+	unsigned int max_retries = 3;
 
 	DC_LOGGER_INIT(link->ctx->logger);
 
+	if (link->preferred_hdmi_frl_settings.valid)
+		max_retries = link->preferred_hdmi_frl_settings.max_retries;
+
 	/* FRL Link Training */
 	while (status != LINK_RESULT_FALLBACK) {
 		if (link->frl_link_settings.frl_link_rate ==
@@ -846,6 +851,15 @@ enum link_result hdmi_frl_perform_link_training_with_fallback(
 		if (status == LINK_RESULT_SUCCESS)
 			break;
 
+		/*
+		 * A sink that is still waking up may not answer at all. Retry the
+		 * same rate before going lower, as many times as link enable does.
+		 */
+		if (status == LINK_RESULT_TIMEOUT && retries < max_retries) {
+			retries++;
+			continue;
+		}
+
 		link->frl_link_settings.frl_link_rate--;
 		if (link->frl_link_settings.frl_link_rate <
 				HDMI_FRL_LINK_RATE_6GBPS_4LANE)
-- 
2.56.0

