Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B283C25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 09:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F251E10EE4D;
	Fri, 17 May 2024 09:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OthiUZqH";
	dkim-atps=neutral
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 152EF10EE4D;
 Fri, 17 May 2024 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715937932;
 bh=aDp9iI96OBJTQES4yUVp+EROqovPxhZTdAIdqtcnWnw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OthiUZqH7ibnt5nhrHOtzuP8ngSpfTMFtyvDVW3iK6gJO9pHKAp4fVrme+Q9IviDH
 4R1zmqNkkAedMzUpGQDl/I0DNm8A6XqQXaYpjX5e4oWu+0Ctmecpk6+akgOUe7zeb+
 ZeB7aFm7RNaMw5hJ7g7TX61zYfrdp5RzMT91PjBnmTzhJg1SMpwK1sKBzN/7hsybCr
 AqJtQIObFIqC7MLSEiQ6PqmsL8fit6chxx48d/90OS48qca2TDbnyJ7Qr3SLxc6pGv
 aOXKeYUcS3EnRFkQI0RwGZTonyZetvI0T+1EdA7ASTDbfUA09nPdzIUO9IpLoR36eJ
 o0CFdxMvDWdUA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33F7E37821BF;
 Fri, 17 May 2024 09:25:28 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 dmitry.baryshkov@linaro.org, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drm/ci: uprev IGT
Date: Fri, 17 May 2024 14:55:00 +0530
Message-Id: <20240517092502.647420-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517092502.647420-1-vignesh.raman@collabora.com>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
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

test-list.txt and test-list-full.txt are not generated for
cross-builds and they are required by drm-ci for testing
arm32 targets.

This is fixed in igt-gpu-tools. So uprev IGT to include the
commit which fixes this issue. Disable building xe driver
tests for non-intel platforms.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Split IGT uprev to seperate patch.

---
 drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
index e62244728613..7aa3ce274c64 100644
--- a/drivers/gpu/drm/ci/build-igt.sh
+++ b/drivers/gpu/drm/ci/build-igt.sh
@@ -45,6 +45,10 @@ MESON_OPTIONS="-Doverlay=disabled                    \
                -Dlibunwind=enabled                   \
                -Dprefix=/igt"
 
+if [[ "$KERNEL_ARCH" = "arm64" ]] || [[ "$KERNEL_ARCH" = "arm" ]]; then
+    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
+fi
+
 mkdir -p /igt
 meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
 ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 8f32de63d92e..1b29c3b6406b 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
 
-  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
+  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56
 
   DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
   DEQP_RUNNER_GIT_TAG: v0.15.0
-- 
2.40.1

