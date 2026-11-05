Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA64606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB2lar1L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540B510EC53;
	Thu,  5 Nov 2026 14:08:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B27F10E1EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 14:08:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FA334192A;
 Thu,  5 Nov 2026 14:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D06E1F00A17;
 Thu,  5 Nov 2026 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793887692;
 bh=f8wkGOeqdr9pn/y4Aqu039JA6nWq3yudpkpDEr1rZFE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KB2lar1L23aDd0HbDRzC5AxZKzytlvE7JRiiTjHh1NoauUgZm4o/dL95Gmrclksqz
 gAEio7+VCObeBczxfgEy+rlKp3BGNJr8GbB+iSPuPxtgDVb5p6J5nUZyrd2XKmt78o
 sOkEXAbub0QGmk2ldFTcgT3+iorp2mJ91M+sh6keuY5xMXOPdLWIotQ7u7MqtcsUKK
 9v3+rlJ8Zd2VEAI2JpYVawpJ0zzFC6aY6ODoBHXt5F/i0bL3Ekms9Ve0YxX5QtdVKL
 KCLuSHDct/x3NX+EnIPlzv/UFFGFf9otVz9+LsOYDBcxIpENrRrBuVcLz/+KoFqSz/
 sbajJxe3cKhRw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:07:19 +0100
Subject: [PATCH 02/83] drm/amdgpu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-no-more-config-reset-v1-2-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1MTSHO9pBKc60kjKwiLlQWG73uMkotyRJA4xLAgEmNM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlveuekXOP7K767SlMxgjslJ47hOLeayAmFVz9bLzBk6
 c3bWLOgYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwkIJ6xvlw4x/hTrdbj4xE3
 pss91VU5tZQl5nnkREUH7XQTr74HObzraq8e3yOx+1yM1InJkssDGWv4ZglIRztUR9znk32Q02P
 3W3BJ9s3Pdw8Hba4IWOhpK8r+qe/o2VbzRm+rKc0a57qs5wAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                              | 4 +++-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c    | 3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5c7e2172a372..1f8b531eb946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -362,5 +362,7 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_attach;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 009a017194e3..7966690dca96 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9966,5 +9966,6 @@ dm_test_force_ctx_alloc(struct kunit *test, const struct drm_connector_funcs *fu
 	ctx->aconnector->base.encoder = encoder;
 
-	drm_mode_config_reset(ctx->drm);
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	drm_modeset_acquire_init(&ctx->acquire_ctx, 0);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 8c3e32f40a96..c9fa8308d254 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3794,5 +3794,7 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 					    &dm_mst_test_dsc_link_conn_funcs,
 					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
-	drm_mode_config_reset(ctx->drm);
+
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	KUNIT_ASSERT_EQ(test,

-- 
2.55.0

