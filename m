Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D03606A33C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mB9F91Kn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77E310F358;
	Tue, 24 Nov 2026 08:40:20 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE30F10ECB0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 22:11:37 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6baa6f27904so2258705a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795471896; x=1796076696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ltGQ2hfOSBDEtHoPNY3xRyJkIaO/5t79RZZAqp6M1aM=;
 b=mB9F91Kn6m8UxdGGrJWzLsbp3IO4HbN2tQgrhVhzMmuHeNzAxM7KyFMNeocF26GuX0
 qvvlq+sWvtowJSkjDPDQgAn8KrL2Ex+syHFNROoYnqc2XWd3NahGwTXi9/kCXyLhvahw
 HKx7LfYAz2caC/UhnpaxwvmKu7VGZA/4SYbt9Py6gHJGPxzDAeLrFB1IPUPqhIU43fQV
 n2Nm2pzk91cmXqW3tBonkp2+WwqmIAqzLjUeERCllLQGIGHf1p07R7/coEcI9BVFwXel
 JgFJHvfBEz8nY7++gTX4Msp3KAKp4Dtz7wx1QTfk0LdKs89nJNaJOzhbI++WhlZYYHnT
 YnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795471896; x=1796076696;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ltGQ2hfOSBDEtHoPNY3xRyJkIaO/5t79RZZAqp6M1aM=;
 b=efFnu4D36F/IVKQQ7Iz20FpckgGI9tKZ0n+WifC9RuaoHAZrDN9cb9u8ccpUBWpiNG
 xszll8Ws2pnJ0NR4uPSlixiNSq/XBCev3UO1W+dH15BsFWlz08vb3KB+hKWQnp5uZKWh
 1CQ4GFBKhFWfm3o96judUrq3kN1RSdDeNAjfwwOJx40Z+CXHSJFYtp81O1rJhqRYea+f
 Ni3s7weB6Y9NZMVmmTG8cd/AuAIchd4nZfg6NXvCoQ9X2ji28dhg8gtbHcG9RHeIp/+s
 KgcSiVWYJMHNOOGYDK7JdksnEbdCsIkFvAt8spgOn6YqjdUkykHtI6p5RlMlyGNq3ikc
 KSKQ==
X-Gm-Message-State: APuU4Z/tReAQGCfThNm+7bntkiMqnbbD1gzEuERUme3/DzPuZF+BD6gR
 OSC/LC3Xon6Pu5wwLU7PNTv8k5bJuHv3NpOvWv8mOKOVeW69L+oRCUCUuGtL3Si3bE1w7cDFh3R
 Vv1oF8F3ahA==
X-Gm-Gg: AZFdTZf33R+4uMKJj4+V+C8uMtw4nFpredqv8f8+MgyYK0leIExcadGq6rB9lJPuPnf
 VaiHin5ALdgykAvbSilhcRCOy4THUDmX7dV1snO4H1GBkOqQLZc0GsQc/io2YRNDGXC/f00lK9g
 zGueXe9d+Dn4UpJVNYG4PYs1FK6z05FPXUdiJcbCxkfV8JmAcqKiOLKSsUD4Tb+2J9/xKKC7TX1
 +1ieXBDmO2MUnjRCH6AXe+HAC6/qNyjpSQ3ZZb/r3gKYtjywfRLdlh42vtwDXl6MCsKJSIr4ri7
 dAmBCwv2BgwZOUZwmtf6Hz3yaNlTLsQJqcByQrkD9Uze5AhVNMaFms8VEsoNBPjAE6AsEosKxEz
 QTbfxg2FVPhAz9R+u9E4GQO6Csxcx8f0Ak7dBUP9TcUAblAsvwE/GeyqUd4T9MoOTUmlS6ILA8p
 g6o39pztuvDih49eHSA93hoVZmJqH0pmaZophXtKCcaQ5yR58+JeKI5hqfosm7jVUZ+tka3X4dk
 pYIdkfkPInOS/leVW8duQQS5creMC+QtoXIlJtxGhJ3LcLSLDwlO58VT0uQZccI7hZLj8DACokY
 H6G+C5HTf2MNllQyHTsypaCp6wZQvm6/fwGwGc+AzaPrtnFnNXCL00LbjXS6wz13fzWjBPm/aGP
 fgy9dskDhugTkfTc1cm9zCMXIFjEhV6i3kqBQpH5t0rxynkUddlxxcWbrtOotGKeleCA=
X-Received: by 2002:a05:6402:51cd:b0:6ba:447c:5b72 with SMTP id
 4fb4d7f45d1cf-6ba447c66f8mr9483235a12.38.1795471895811; 
 Mon, 23 Nov 2026 14:11:35 -0800 (PST)
Received: from vautera ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109b55sm5678828a12.32.2026.11.23.14.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:11:34 -0800 (PST)
From: =?UTF-8?q?Jakub=20Oko=C5=84ski?= <jakub@okonski.org>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: [RFC PATCH 1/2] drm/atomic: record TEST_ONLY ioctl intent in
 drm_atomic_commit
Date: Mon, 23 Nov 2026 23:09:12 +0100
Message-ID: <20261123220913.937402-2-jakub@okonski.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123220913.937402-1-jakub@okonski.org>
References: <20261123220913.937402-1-jakub@okonski.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:40:19 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Real commits also run drm_atomic_check_only(), and NONBLOCK is not a
dry-run flag, so atomic_check cannot tell a TEST_ONLY ioctl from a real
commit.

Set a test_only bit from DRM_MODE_ATOMIC_TEST_ONLY in
drm_mode_atomic_ioctl(). Core behaviour is unchanged.

Signed-off-by: Jakub Okoński <jakub@okonski.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 1 +
 include/drm/drm_atomic.h          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..17881994f737 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1667,6 +1667,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
+	state->test_only = !!(arg->flags & DRM_MODE_ATOMIC_TEST_ONLY);
 	state->plane_color_pipeline = file_priv->plane_color_pipeline;
 
 retry:
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 88087910ab1a..456b194d220a 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -521,6 +521,13 @@ struct drm_atomic_commit {
 	 *   for the normal composition loop at reasonable cost.
 	 */
 	bool allow_modeset : 1;
+	/**
+	 * @test_only:
+	 *
+	 * This transaction is built for a DRM_MODE_ATOMIC_TEST_ONLY ioctl
+	 * and will not be passed to the driver's atomic commit hook.
+	 */
+	bool test_only : 1;
 	/**
 	 * @legacy_cursor_update:
 	 *
-- 
2.56.0

