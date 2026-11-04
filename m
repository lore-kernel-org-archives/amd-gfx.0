Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982A606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=BLBJ+dS3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3C511245C;
	Thu,  5 Nov 2026 13:45:38 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C4B10E86F;
 Wed,  4 Nov 2026 17:08:48 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKX316sshz8v5f;
 Wed, 04 Nov 2026 18:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793812126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h3c/WSm6Brx9RGmPW3KlcJgpIiaebOde6dRyE2+QOgw=;
 b=BLBJ+dS3KXX3SjcnRv5UYL7ZJABdVZbuwd8exlcfAyUuPeo5yd0qDrcjuliQevP2aKT8KY
 8phVtXPUB5QG8Ljo+xg1c66QjibINbTylShaRHjSAK/Wm2OENMfrSD+n/HagXBl0YtX/LO
 hmwxsgfI5uvAqSxHxl8Ja9qRIt48nKNrR6q0GzETaI0k0pbsLyFkjqhqE4EhfLL7InoTjU
 nNPIqiO5mk3Alv+Vk98ggx5tj6sEqr/odpJ9U0PB9ROhSgpBQPO3cNswHCdghNNQEZG3gN
 knQMWvFs6MWbEl5UkURoBmeE3QTnWtg4VeIdVIbwTOHEJIXJFi5P4LNhVBjVSA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: igt-dev@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, chiahsuan.chung@amd.com, sunpeng.li@amd.com,
 kamil.konieczny@linux.intel.com
Subject: [PATCH i-g-t] tests/amdgpu/amd_abm: Do a modeset in test_init()
Date: Wed,  4 Nov 2026 17:08:43 +0000
Message-ID: <20261104170843.3719734-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jKX316sshz8v5f
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since set_abm_level() commits without ALLOW_MODESET, the first commit
of every subtest fails with -EINVAL when the eDP runs in a mode other
than the one test_init() picks, for example when video= sets the
console mode. All five subtests then fail

Commit the test's mode and framebuffer with ALLOW_MODESET at the end of
test_init(), so the subtests start from the state they commit

Fixes: e63b2671fcdb ("tests/amdgpu/amd_abm: Remove the modeset for ABM level setting")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Tested on an ASUS ROG Flow X13 (DCN 2.1, eDP) booted with video= set to
a non-native mode, on IGT 2.3 with this change and a local fix for the
card index and backlight name that master now has as:

  4e939e73adfd ("tests/amdgpu: Resolve DRM card index dynamically instead of hardcoding card0")
  055ffbee8325 ("tests/amdgpu: Discover amdgpu backlight device dynamically instead of hardcoding amdgpu_bl0")

All five subtests failed with -EINVAL before and pass with this change
---
 tests/amdgpu/amd_abm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/amdgpu/amd_abm.c b/tests/amdgpu/amd_abm.c
index 7992dfd87..833d950eb 100644
--- a/tests/amdgpu/amd_abm.c
+++ b/tests/amdgpu/amd_abm.c
@@ -192,6 +192,9 @@ static void test_init(data_t *data)
 	fbmem_draw_smpte_pattern(data->fb_mem, data->w, data->h);
 	igt_create_color_fb(data->drm_fd, data->mode->hdisplay,
 		data->mode->vdisplay, DRM_FORMAT_XRGB8888, 0, 0.05, 0.05, 0.05, &data->ref_fb2);
+
+	igt_plane_set_fb(data->primary, &data->ref_fb);
+	igt_display_commit_atomic(display, DRM_MODE_ATOMIC_ALLOW_MODESET, 0);
 }
 
 /* Common test cleanup. */
-- 
2.56.0

