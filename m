Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9E606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qFLfIWz8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06492112103;
	Thu, 26 Nov 2026 08:09:34 +0000 (UTC)
Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F282910E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 05:43:05 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=YPuZ0FF85lb3swyXVbCzcAsTFicF1vKyRQgT1cPqCy8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795671784; v=1; x=1796276584;
 b=qFLfIWz8+BGLgn0ECfu6iKK8yocqnvi94Yaq6+CBaXIjFJSbE2vUzwEsFWvneDl/xD77nFiM
 p0f6TV2/Qmh62ydxKA28s0VkJSgZSmDhIfv9vF3zntNpDKmPvrlsRsLObeu0DRQdU6GOrUuirIu
 OIR3KYQZn00V0bMYqoG0rH38=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c88e8c6be216d38b;
 Thu, 26 Nov 2026 05:36:59 +0000
X-Mizu-Trace-ID: c88e8c6be216d38b
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pei-Hsin Yang <peihsiny@valvesoftware.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 2/2] drm/amd/display: Test VRR vtotal limits across a modeset
Date: Wed, 25 Nov 2026 21:36:06 -0800
Message-ID: <20261126053606.12286-3-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126053606.12286-1-matthew.schwartz@linux.dev>
References: <20261126053606.12286-1-matthew.schwartz@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check that amdgpu_dm_update_stream_irq_parameters() replaces saved
vtotal limits with the new timing's on a modeset, and keeps them on a
commit that is not one.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index a2b13de2e9e9..ab8931a4d0dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -916,6 +916,56 @@ static void dm_test_update_stream_irq_parameters_fixed(struct kunit *test)
 			60000000U);
 }
 
+static void dm_test_update_stream_irq_parameters_stale(struct kunit *test, bool modeset)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state crtc_state = { 0 };
+	struct mod_vrr_params *vrr_params;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	crtc_state.base.crtc = &acrtc->base;
+	crtc_state.base.vrr_enabled = true;
+	crtc_state.base.mode_changed = modeset;
+	crtc_state.stream = dm_kunit_alloc_stream(test, NULL);
+	crtc_state.stream->timing.h_total = 4400;
+	crtc_state.stream->timing.v_total = 2250;
+	crtc_state.vrr_supported = true;
+	crtc_state.freesync_config.min_refresh_in_uhz = 40000000;
+	crtc_state.freesync_config.max_refresh_in_uhz = 60000000;
+	adev->dm.adev = adev;
+
+	/* Limits of a 1080p60 timing with a 40-60 Hz range */
+	vrr_params = &acrtc->dm_irq_params.vrr_params;
+	vrr_params->state = VRR_STATE_ACTIVE_VARIABLE;
+	vrr_params->adjust.v_total_min = 1125;
+	vrr_params->adjust.v_total_max = 1687;
+
+	amdgpu_dm_update_stream_irq_parameters(&adev->dm, &crtc_state);
+
+	KUNIT_EXPECT_EQ(test, vrr_params->adjust.v_total_min, modeset ? 2250U : 1125U);
+	KUNIT_EXPECT_EQ(test, vrr_params->adjust.v_total_max, modeset ? 2250U : 1687U);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_modeset - Test a modeset drops the saved vtotal limits
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_modeset(struct kunit *test)
+{
+	dm_test_update_stream_irq_parameters_stale(test, true);
+}
+
+/**
+ * dm_test_update_stream_irq_parameters_no_modeset - Test saved vtotal limits survive a flip
+ * @test: The KUnit test context
+ */
+static void dm_test_update_stream_irq_parameters_no_modeset(struct kunit *test)
+{
+	dm_test_update_stream_irq_parameters_stale(test, false);
+}
+
 /* Tests for amdgpu_dm_handle_vrr_transition() */
 
 /**
@@ -1118,6 +1168,8 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_variable),
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_inactive),
 	KUNIT_CASE(dm_test_update_stream_irq_parameters_fixed),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_modeset),
+	KUNIT_CASE(dm_test_update_stream_irq_parameters_no_modeset),
 	/* amdgpu_dm_handle_vrr_transition */
 	KUNIT_CASE(dm_test_handle_vrr_transition_inactive),
 	KUNIT_CASE(dm_test_handle_vrr_transition_round_trip),
-- 
2.54.0 (Apple Git-157)

