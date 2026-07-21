Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F024C4451C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 11:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991BF10E93A;
	Tue, 21 Jul 2026 11:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="owzav45A";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB4810E93A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 11:43:31 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so13123915a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784634210; x=1785239010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cm0tukAZDG4w5KkW10UxKADzsaaYtS3HQAtzaYzz2zo=;
 b=owzav45APqv6/bFlj/cMBifF+9eVTInrMV64c9D2z1T9oc0XxIV2X19gVpx59CavW0
 907q/06HEQu0H3JN0b8FxkOk95P5z4HD944ZnchQX30h1VoqgY5KuW8zdFr8kvcZXXp8
 vqwlv8j9mf6bfjLjB4m9YFZir5H3NxOnGvBWw9qy4accShLlvJI/SeWM2owf/Iw7jUjG
 BBnhUtAOdQnGC83oWQtEKdGZePwMNg7T++FnZ0aBzIAtnIs7sPuIvb5n9s3y2moB+UYN
 vgMbLCU7zstQ0sG3fbvFzR6A3Y7RwGhGrTRBD9/DlOrb5KHvtGz03R4ndY5GAZj8ZquF
 TuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784634210; x=1785239010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cm0tukAZDG4w5KkW10UxKADzsaaYtS3HQAtzaYzz2zo=;
 b=LJEZCNpcjR30ZlMBYnWA9PjBKIwXjCIyzrv0575ESbCg80Hp6vF8+NlOyE5Izi5uej
 GC3hJWHZsBnm7teFYmUgbYmqfmL+aLbUl4RmIWPlf8qQDIufteC1JWsxoYa4p7Q/KODl
 Qn0b1/SrjzyXZMCjpHhEPYEEsQBkQAxjjAHZIV1dvwVpIcbGxw6pKpANDpSQOVa2AcVd
 zZs7UxfJrGzhKBlCD9R+DoUpix0Bnw4YwEZtXktSx4fB5ixepFW/1bO4JgJBxlKK/cN2
 HYpLfrEsnNV7CJ8zMyN+a5bFjB/vli7/YCbyrjvIoe48U9f+gWWK4HQMEYO9+QRb1FqY
 VhjQ==
X-Gm-Message-State: AOJu0YxVkLJZo4Gh0pWMyWQmp5DR7uZFxL5qneVy0jMQBikLwRaRwyeN
 axxwbEGibbMW1oRwk6DQw9SoVIViQO81X/koPham3RIiqoNEnwrJfEHfpBoevD9B
X-Gm-Gg: AR+sD10HaOs4kiAUzChIXNSxWQRfq3bG7Cn89C83XJcsDZsQyzNwg5K7GXK2yuTbznS
 T1t6aWmz22wdYphQ7PZkcHn9PRIX2HAUuGmZZlsUueluu6dAk9MGcPguXGAZROZfEk30d6PCHZE
 4HXsU0XIwOZrt1K9B5oQNA8eeF3amace6Ou4Q8IG9mDeH2DVoX+TWlEJYssobWXBmVYc7SZibEy
 tR4hbtu3WcD8idwe+kwS/DLl53fX+LELkWBa3r33KSVdRzQVzNlHBvw53/p2rbmzS1u8QhMNKh5
 ZqIdkE8uN26TUyqEwnBVawrA1Drt5OQJC8EEjXKoQxgU6HzklEGjr1pZjwIYOoTe6y3ZH9ifIlT
 Pe9lr3moT4SKpln1xW+UVb9tf88/5ZBVtibDR4E7AsJ0GOhEWgkYgYXKJVu7GNkTVIkuSkr5Vis
 /ARAqeg1EEO/HCoKPBeFTNLTrSbnJqLhRPzdyjBYREAuP0IDO3+qvsCA==
X-Received: by 2002:a17:907:6d11:b0:c15:b4f3:6d25 with SMTP id
 a640c23a62f3a-c16b46b8b5emr842069066b.19.1784634210038; 
 Tue, 21 Jul 2026 04:43:30 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17009ae00asm571635366b.7.2026.07.21.04.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:43:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
Date: Tue, 21 Jul 2026 13:43:16 +0200
Message-ID: <20260721114322.17535-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721114322.17535-1-timur.kristof@gmail.com>
References: <20260721114322.17535-1-timur.kristof@gmail.com>
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

The gfx_v7_0_cp_compute_resume() function should only return
success when all compute rings are actually functional.
This will be especially important for soft reset which needs
this to know whether the reset was successful.

Note that the gfx_v8_0_cp_test_all_rings() function already
does this on GFX8, here we just follow the same idea.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 1fac8ccfd381..12ad29e1a75a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3019,12 +3019,14 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 
 	gfx_v7_0_cp_compute_enable(adev, true);
 
+	r = 0;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r |= amdgpu_ring_test_helper(ring);
 	}
 
-	return 0;
+	return r;
 }
 
 static void gfx_v7_0_cp_enable(struct amdgpu_device *adev, bool enable)
-- 
2.55.0

