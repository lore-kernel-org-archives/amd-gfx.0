Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F2BEA3F14
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 07:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C67510E4C6;
	Tue, 10 Feb 2026 07:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ollmS416";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AE610E4C6;
 Tue, 10 Feb 2026 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1770707525;
 bh=rCvwRJK0W1o4tQMv1YUlAV0iLAot+fdH9pyn8DDPkzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ollmS416MnF1p+bIkLxzga0hVUTR1dkZ1ZAjfTeIspGzfAhGX9bLJJbEE75CbGmhO
 HTi0sJC3eartiybLxVcJ1AQvEOlVqCtuJugMoHkVJ0rqNm8o14YgfrwXOjYOBD+zPe
 hg/5D55WQqb1POGXXPo9NByhmLYU3bU96XBvw9zeGbiSC3gZN2tgVhz3nvEYlJ3z5/
 ysH4z71Ldlv/Rv8hIJjFbG6S7MH3ZLwStUlFci0/WY877POaUW0AiEg8GcFbwfGHz6
 D+A7dDTOD0IhiGe6sFv2VFGH2sxpBqZYvwvPtG44AvJjj7kiuuQkxt23leB1l9ux0h
 dji2hcLrrxiiA==
Received: from vignesh-thinkpad.. (unknown [171.76.81.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0929D17E13A6;
 Tue, 10 Feb 2026 08:12:00 +0100 (CET)
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
Subject: [PATCH v2 1/5] drm/ci: reduce sm8350-hdk parallel jobs from 4 to 2
Date: Tue, 10 Feb 2026 12:41:30 +0530
Message-ID: <20260210071138.2256773-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210071138.2256773-1-vignesh.raman@collabora.com>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
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

The sm8350-hdk jobs are short and each test takes around 2–3 minutes and
the full job completes in about 10 minutes. Running 4 parallel jobs uses
4 devices at once, which is not needed. Set parallel to 2 to reduce
device usage.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
---

v2:
  - No changes.

---
 drivers/gpu/drm/ci/test.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 81147e86bfd0..762598c7db25 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -183,7 +183,7 @@ msm:sm8350-hdk:
   extends:
     - .lava-igt:arm64
   stage: msm
-  parallel: 4
+  parallel: 2
   variables:
     BOOT_METHOD: fastboot
     DEVICE_TYPE: sm8350-hdk
-- 
2.47.3

