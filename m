Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C98FCDB475
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 03:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCB410E989;
	Fri, 14 Nov 2025 03:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fO2DfZ3a";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EE010E20D;
 Fri, 14 Nov 2025 03:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1763089287;
 bh=ZCItdMAKSBYnoQbmuGe/KriN1j9Lnyjo9QM9qRu8/Tg=;
 h=From:To:Cc:Subject:Date:From;
 b=fO2DfZ3anN63JQRdUKZKbXQvW89bTHJGrjDtoZc0l4DnjlGkv0Wel/oKZnNbkOGEK
 JsjyJIThA99jtvIioB6Akn9r16cA9NwP3uql0Zzl5YFepprArIuVgyBrPH57/ZzVEZ
 Xo2KJomytJnq/4crzXj54OJvgRzrFxUIJJifeS5xYi14vZqcQvdYyrYw/roBii9C2Z
 dOxbRjpXHrj0eEKmp4qxpQdqs8mcpsyOFIrO3JBkArcbxMVJhQrmRzX/iozkr/xfmq
 GnXqIDj5NmI4i/9geKHZoBulQrJVlTnHVwoOFfbG9iEJzmzmlyPoRPu6WjGq9FoeRK
 YaAWv52iBCWyA==
Received: from debian (unknown [171.76.81.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4776517E0202;
 Fri, 14 Nov 2025 04:01:21 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm/ci: uprev IGT and enable apq8016, apq8096
Date: Fri, 14 Nov 2025 08:30:49 +0530
Message-ID: <20251114030056.1139570-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.51.0
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

This series includes,
- Adapting to recent changes in Mesa CI, such as:
   - LAVA overlay-based firmware handling
   - Container/job rule separation
   - Removal of the python-artifacts job
   - Use lava-job-submitter for submitting jobs to LAVA
   - Various other CI improvements
- Move bare-metal jobs for apq8016 and apq8096 to LAVA, as these devices
  are migrated to Collabora LAVA farm.

Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1546424
MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/200

There will be a follow up series to update expectation files for the
other jobs.

Vignesh Raman (2):
  drm/ci: uprev mesa
  drm/ci: Move qualcomm baremetal jobs to lava

 drivers/gpu/drm/ci/arm64.config               |   1 +
 drivers/gpu/drm/ci/build.yml                  |  22 ++--
 drivers/gpu/drm/ci/container.yml              |  28 +++--
 drivers/gpu/drm/ci/gitlab-ci.yml              |  95 ++++++++++++----
 drivers/gpu/drm/ci/igt_runner.sh              |   4 +-
 drivers/gpu/drm/ci/image-tags.yml             |  22 ++--
 drivers/gpu/drm/ci/lava-submit.sh             | 101 ++++++++----------
 drivers/gpu/drm/ci/static-checks.yml          |   1 +
 drivers/gpu/drm/ci/test.yml                   |  80 ++++++--------
 .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   4 +
 .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |   2 +
 11 files changed, 213 insertions(+), 147 deletions(-)

-- 
2.51.0

