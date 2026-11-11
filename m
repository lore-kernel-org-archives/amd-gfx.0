Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37F606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=To8g6BJ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFA710E9FB;
	Wed, 11 Nov 2026 16:14:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B6E10E9FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F2C063620;
 Wed, 11 Nov 2026 16:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D25B1F00A07;
 Wed, 11 Nov 2026 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794413670;
 bh=waVa0swUhVILDQ3Fdt9NwC388Zn+UttTKWbxLoq2k0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=To8g6BJ6/R18EgHt+BPeAHAVBQbuXk+t6aIFx2fn332bSqauYGxIX/MhTCqN4+MGd
 ONerEaPLhIWKa6BYiQzy9Dt9em18MCRu5Z+LROMLZse3SPa18WvY1YByGKq/Q80ZVA
 IybU0qgALTugrvS/EnJa/0gmU4kIQqopiAZHZJnggWryksTuMTqRkL+IZXxgi6S/+C
 hDWhJWIRxfSbtd6BScuCTFZMH4NIBoOB0hE/y26arVXZ6a1H5DlUP82BcxDL1ayokQ
 BrNA5M+ZSvTYC+LbA2xAFIBtmSz4zlZoGkfaxvlkVO5KhPcaqZhiiLy9/vmka5XMvo
 g8MGR+fGcvhIQ==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Maxime Ripard <mripard@kernel.org>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: [PATCH linux-next] drm/amd/display: give the dprx CRC test its
 connector state back
Date: Wed, 11 Nov 2026 11:14:27 -0500
Message-ID: <20261111161427.3274232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avNxxfHK_Zh2GN2o@sirena.org.uk>
References: <avNxxfHK_Zh2GN2o@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The merge fixup in commit c62c2736d82f ("amdgpu: Merge merge merge
cherry-pick cherry-pick cherry-pick") dropped the call to
drm_atomic_helper_connector_reset(), which drm-misc removed. But that
call is what gave the test's connector a state, so the assert right
after it always fails now.

Create the state with drm_atomic_helper_connector_create_state()
instead, and check it before storing it: cleanup would choke on an
error pointer in connector->state.

Fixes: af8e519642bd ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
Link: https://lore.kernel.org/all/avNxxfHK_Zh2GN2o@sirena.org.uk/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
The amdgpu_dm_crc KUnit suite goes from 34/35 to 35/35 with this.

 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index 2b94d1bcaf62c..32b33d72dd0f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -694,6 +694,7 @@ static void dm_test_crtc_set_crc_source_dprx_connector(struct kunit *test)
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 	struct amdgpu_crtc *acrtc = dm_test_alloc_crc_crtc(test, adev);
 	struct amdgpu_dm_connector *aconn;
+	struct drm_connector_state *state;
 	int ret;
 
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
@@ -704,7 +705,9 @@ static void dm_test_crtc_set_crc_source_dprx_connector(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	ret = kunit_add_action_or_reset(test, dm_test_crc_connector_cleanup, &aconn->base);
 	KUNIT_ASSERT_EQ(test, ret, 0);
-	KUNIT_ASSERT_NOT_NULL(test, aconn->base.state);
+	state = drm_atomic_helper_connector_create_state(&aconn->base);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
+	aconn->base.state = state;
 	aconn->base.state->crtc = &acrtc->base;
 	/* Balance the reference the state destroy drops for a set CRTC. */
 	drm_connector_get(&aconn->base);

base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
-- 
2.53.0

