Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D725CC624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 18:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5510E59E;
	Fri,  4 Sep 2026 18:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bfUTb38/";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD6E10E59E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 18:34:38 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso18244375e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788546877; x=1789151677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dveN59ljLJvedW3SIhQ9oc/6TM3bjPJGnsY4KeqZhA0=;
 b=bfUTb38/deZXu/dbYIj82IRANhduofKluGEQcEu8/liof0DNXJWGwFEfmKUWjU7Z2L
 iLbqsirj1fufMTaAIi47JbHhgOUNUvuiKx41chmC7NETQ33PPjiNN/iGzeQ5gIdgooWa
 rG7TosV03gZKH/GD9hrzrGzOzYSJIQuU8GXU7uUxyHbcaet0s1OcNAucPoIJFZkomWLW
 tFj7Y3Tg5yKp3CxWpaXcFARyRywJ3foIS9vobdePQAOSlrE8jofcgS2P8TjWEW4xTFCC
 mQ7vcsRdgek6lT0ykLNTg9G42G37QjE0rEXOb2LQnLaMV1u+bERJuSKB13qyChOamYKR
 UUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788546877; x=1789151677;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dveN59ljLJvedW3SIhQ9oc/6TM3bjPJGnsY4KeqZhA0=;
 b=EAH//YcQQo2zW+sj3Xz94XEOMPVEfoTh2b07BLB1LlKneX7n9IIyqrn6wiehvVJ/rB
 p7EG3x89Qx3DZ2DwHAWo5VkpezLxN+3n3qzDUh7xpv0Iz0r5eESnqrJNkzaowG5Ia6gu
 JLGSdZ4lG5DKO54soF1AZzT6SsFY5moSIWvRqfs7G5vp10FX8Mctmxy84NqG27bp4c0h
 vdiMivHXfoy2OhUZOG4nr7E/ebnV7vi95D/Q1PWp9n75J0IzdjwmI56Ei9ESiaVWwCRk
 guYIu4SV52GvKzi9QzRfSMpLzMwjr9s/OoKi9MFSCjWMxjfZEeuY3YQTCUVgndNAjqUM
 W8Vw==
X-Gm-Message-State: AFuF++klMHeMHUvq4oZawTm8Jt79OenB54LqGBJHH2czLfnqDH7Y7eYF
 1/VFxC0j4t6DPj++BsOICyiOD1T7xwaXTotbgWBe583MKhF76DBu2kuw/5hCAjEu
X-Gm-Gg: AYBFou1MHrMEVuxCoxAj6QqNgawZP5rxdP1+F2faTYOvthyZ7tgyZXgkoHjo4NRJzR9
 KwW5gf4mj3VIBWUFydPHZrvjXXZiE6TsNAVGRvwBCLjJhzNmi1ZMznvFEojAjGlvfF7TZWJMJ1p
 RnYZzq/BrPOg7oE7GNI9mJI+wxjhJUrNQGva8MuUj10Ou/c3dNTev6WWv4ufQcE5a1HslY2wstf
 CseBk0nC4ngbUYbUurODdr45FefVM74v/K6Y5ZqqR2vl7aqKySLlsh0reVQVahhFbPVtoE2flIX
 yHmqa/BViK3SGFtwYAXrzUMk/voTqlV72fSOS7/i3nwdm+JiZdhAPWPx/Xa2fGnCD/P47no70WV
 +/d/18INRA2sfNfVwZakwRnmf8vn0OJJgAZHF0guGdm6Usaiz0gS4IlxJTvLDNYXzgS8ySj7d4g
 IdPcQfMwyg2ibHhWDsWfuPflme7tUq22vK/H27l1D/c4EJUO7tBktAi0HsE1xYR1aVr9Zduj9AY
 8Yjwxd4aCZUuGwt9qld
X-Received: by 2002:a05:600c:5397:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49cf82cba17mr68129865e9.4.1788546877100; 
 Fri, 04 Sep 2026 11:34:37 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm118373095e9.5.2026.09.04.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 11:34:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amdgpu: Delete unimplemented DM soft_reset() code
Date: Fri,  4 Sep 2026 20:34:09 +0200
Message-ID: <20260904183409.571117-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904183409.571117-1-timur.kristof@gmail.com>
References: <20260904183409.571117-1-timur.kristof@gmail.com>
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

The soft_reset() function for the DCE / DCN blocks
has never been implemented, and there are no
plans to implement it.

Let's delete this function, it doesn't do anything and
also isn't called from anywhere.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  8 --------
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f49cc198fb0d..4cf81b8dc030 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -231,13 +231,6 @@ STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_wait_for_idle);
 
-STATIC_IFN_KUNIT int dm_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	/* XXX todo */
-	return 0;
-}
-EXPORT_IF_KUNIT(dm_soft_reset);
-
 /*
  * DC will program planes with their z-order determined by their ordering
  * in the dc_surface_updates array. This comparator is used to sort them
@@ -2109,7 +2102,6 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.suspend = dm_suspend,
 	.resume = dm_resume,
 	.wait_for_idle = dm_wait_for_idle,
-	.soft_reset = dm_soft_reset,
 	.set_clockgating_state = dm_set_clockgating_state,
 	.set_powergating_state = dm_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index a67774e6db36..a3ccb2522a6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -49,15 +49,6 @@ static void dm_test_wait_for_idle(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_wait_for_idle(NULL), 0);
 }
 
-/**
- * dm_test_soft_reset - Test placeholder soft-reset callback returns success
- * @test: The KUnit test context
- */
-static void dm_test_soft_reset(struct kunit *test)
-{
-	KUNIT_EXPECT_EQ(test, dm_soft_reset(NULL), 0);
-}
-
 /**
  * dm_test_set_clockgating_state - Test placeholder clockgating callback returns success
  * @test: The KUnit test context
@@ -4541,7 +4532,6 @@ static void dm_test_initialize_plane_overlay(struct kunit *test)
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
-	KUNIT_CASE(dm_test_soft_reset),
 	KUNIT_CASE(dm_test_set_clockgating_state),
 	KUNIT_CASE(dm_test_set_powergating_state),
 	KUNIT_CASE(dm_test_bandwidth_update),
-- 
2.55.0

