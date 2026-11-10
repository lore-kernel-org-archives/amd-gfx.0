Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2F606B6FB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeGhYaL4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF7A10F6C5;
	Tue, 10 Nov 2026 13:15:39 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A27110F6C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:33 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b704171bc9so2115347a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316532; x=1794921332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JWzAuUod3dRgtMpvML4dHGtO+fvxYrtKFqQrNT4osTU=;
 b=EeGhYaL4y5sOwhHG9OwZKW84FxKDCqXB11jRUmyhnKpKzilYQ5xWGKW1cQ7+Os1rCz
 qgFuH1mSIwi5WmS/JN70+oXTHiK0ZRLvhLofzJa47VKARTD2ppKnaSVNQFZHJVrIT+7+
 nyCrIMYbqp2GaSWlnqaKiw+z5UuLfuZoMgw22mM2l1ZaPCMcS9lgTWMUAIaaIZk0I1wv
 xI2CJulP5Z4ccUmk4adNhRcWDl7SCwJrjKsi7mCYqdfpUkZWkoUsRnwlMDa92vahx0jc
 jTMIys2OybT2kzLRYPAR7H1iwNexoQJyMCKkSzJCM7V/FZ330n3WLa4ymtvCViGuHJvC
 dcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316532; x=1794921332;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JWzAuUod3dRgtMpvML4dHGtO+fvxYrtKFqQrNT4osTU=;
 b=Z39U0BKfsB487neEogXPtHlkMaaXWtluDu2J7gR95KpZOn1cNI4QCvfTvSRtnbQu4i
 v/MclrNZduTE1Da/nQjBvwLvXJYBDiRESC4RLGmVIhiwGMduPe83IxM0BzlwzIGShsAF
 QPxS2tORwEZbxAuP6ghI1z4R4893myYxfluAHEvW7sVC5cMOIcMCosrtsARW4McbubYA
 LWIMDPBP90U7w6meTJAn+RlslUxLg+zUxOuZM5uzfPlTGUDIO1JafXbbrbVGZGbqDp02
 4m9KhAoJYpi6aMu1L3WLvjFwlHnSkqqkATTcJu1g3OWq2Z3HSHGmKAzKdhUX1G6J8oDJ
 AjeQ==
X-Gm-Message-State: APuU4Z+YKLVxllk/EgWzUsiL9+aC2wSZEYFufw9o39IWSnho8RKQmLzW
 Neb5xX9sn5dGDyfWuCaOt5lwj+Dp1dmTZtToopBk6NMTgVr4WQjYvY2Nb/CRy92X48M=
X-Gm-Gg: AYBFou1Ys+hOcXa5EaFXnIcNV9bZpBbqbSWDi/eUz0Wr93Sx8HsACwLA6BrQkjxhBTl
 vIjsVjvMf5irRa/jUvGmv4IcxoGcsJhsuGMgLZD92zDyLBXGoH2BvIYfrshR7NGDGheFNfUJc/g
 0ZM5E+ukVlxb73iVZPBijoerViEUvO+/v8H4B0E3jcWCmMwpWg+S7nbIDNPWkOtopfFRWYz3osE
 1CcA6KjF4Jv2tcB9/PX3XcPB0ecTOS0927BGrQc/hpTjxV1MVj2nPx9idMMWXLd+MBqvvuq8JuT
 VVNfhZIpHlTllDnourTTiVAMp5G5SGpq45lvSp/DOfbJtzm3zjf2nfTd5yEEcelYU+XljNm32BM
 bN0gLgHo/fxz6F7Apc7086DGHsBLDD4Fym/PniGUSrEDiwpRxAgsgxHsFexC6zw/Z3yCH7kPCrh
 lgAAOgj3tfan1YxCPxbhpH/cbpwe9dCyNk8uh2OsczzRBg5tpWPneZRPaCyhRYIxJ2VLdphorvR
 s/77BFGg5tmMbP3R1/wWNNCRTykqXbjTNCQldt8qXoyJJJwBI2HtSKj0YG5wJblyg8oFfT/sBZ4
 qnzl0PKa3pYVGvLV5LKlTZbbjva28sXfrogMDTNqJc4QzKS72X52xAxsRJaKZXRgwi4wsfmyR44
 =
X-Received: by 2002:a05:6402:90d:b0:6b6:e8cb:642a with SMTP id
 4fb4d7f45d1cf-6b7564dd74fmr1981433a12.17.1794316531608; 
 Tue, 10 Nov 2026 05:15:31 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:30 -0800 (PST)
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
Subject: [PATCH 0/3] drm/amd/display: HDMI FRL training fixes for slow sinks
Date: Tue, 10 Nov 2026 14:09:53 +0100
Message-ID: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With FRL on by default since commit 5fd3b60d9b80 ("drm/amd/display:
Enable HDMI FRL by default"), an RX 9070 XT mostly trains a Samsung
QE65Q80T (2020) at 6 Gbps x 3, where 4K 120 Hz needs DSC. Windows on
the same machine trains it at 10 Gbps x 4.

The TV needs one TxFFE step at 10 Gbps x 4, but requested levels never
reach the PHY; with patch 1, the driver programs them right away. The
TV sometimes answers an LTP request only after up to 967 ms, while the
driver waits only 220 ms in LTS:3; patch 2 raises the limit to 1 s.
After waking up, the TV can stay silent at 10 Gbps x 4 for up to about
four seconds, but link verification gives up on that rate after one
attempt; with patch 3, verification tries the same rate again first, as
the enable path does.

Tested on 7.3 with an equivalent backport. Without the series, 4 of 6
boots and TV wake-ups ended at 6 Gbps x 3. With patches 1 and 2, 16 of
20 reached 10 Gbps x 4, and the other 4 are the case patch 3 handles.
With all three, all 63 boots and TV wake-ups over 12 days reached
10 Gbps x 4. In 13 of them the sink stayed silent at first during link
verification and answered after one to three more attempts at the same
rate. On amd-staging-drm-next the series is build-tested only.

Andrzej Piątyszek (3):
  drm/amd/display: Apply requested TxFFE level right away in FRL
    training
  drm/amd/display: Wait up to 1 s for slow sinks in FRL link training
  drm/amd/display: Retry the same FRL rate after a sink timeout

 .../display/dc/link/protocols/link_hdmi_frl.c | 56 +++++++++++--------
 1 file changed, 33 insertions(+), 23 deletions(-)


base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
-- 
2.56.0

