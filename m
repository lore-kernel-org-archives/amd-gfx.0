Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA811C04FDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 16:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADA910E591;
	Thu, 10 Aug 2023 16:04:12 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B0F10E591;
 Thu, 10 Aug 2023 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BaAosmlx3GeI869DyRNLKn5JFf6XZu3AYAYzLrNR2sw=; b=qqW34HLABdbmcyBct/STpAT3UH
 LVr8qObPs6uxz29O0OGuTC4Hpg4D2nSLic6GKxTMXJAFPO9sx4jx+rMfAyk5PwJDolxZqqQqMmUAQ
 Y4ZtIoeZ290Q+b0BkC9NGX1AF4ZxC5RWURNdXhZ5GvqUIg0eC2LNcRyyw/fj+7GJOkrjvLAz0fNPI
 ZJ9nzgRngrWzTbsrOY9uaq3TEr7E5IBxhEhdrc3FbS41jT5ottMkanlM2MRI5BL5XCQBk7PeMP8a5
 hTpxf1umXd5b+crrvTuX8ANbY/kc/WOcB/JGAU3ZndHRQafUe8xdGQVynbuBPojKR3iAhV94fkH+Y
 +kJf80mQ==;
Received: from [38.44.68.151] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qU88r-00GjYD-Pl; Thu, 10 Aug 2023 18:04:05 +0200
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, sunpeng.li@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch
Subject: [PATCH v2 22/34] drm/amd/display: add dc_fixpt_from_s3132 helper
Date: Thu, 10 Aug 2023 15:03:02 -0100
Message-Id: <20230810160314.48225-23-mwen@igalia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810160314.48225-1-mwen@igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Shashank Sharma <Shashank.Sharma@amd.com>, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Xaver Hugl <xaver.hugl@gmail.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Ashton <joshua@froggi.es>

Detach value translation from CTM to reuse it for programming HDR
multiplier property.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Joshua Ashton <joshua@froggi.es>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c  |  8 +-------
 drivers/gpu/drm/amd/display/include/fixed31_32.h     | 12 ++++++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 5659f88d1f2c..db771c895720 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -383,7 +383,6 @@ static void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 				   struct fixed31_32 *matrix)
 {
-	int64_t val;
 	int i;
 
 	/*
@@ -402,12 +401,7 @@ static void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 		}
 
 		/* gamut_remap_matrix[i] = ctm[i - floor(i/4)] */
-		val = ctm->matrix[i - (i / 4)];
-		/* If negative, convert to 2's complement. */
-		if (val & (1ULL << 63))
-			val = -(val & ~(1ULL << 63));
-
-		matrix[i].value = val;
+		matrix[i] = dc_fixpt_from_s3132(ctm->matrix[i - (i / 4)]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index d4cf7ead1d87..84da1dd34efd 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -69,6 +69,18 @@ static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
 
+static inline struct fixed31_32 dc_fixpt_from_s3132(__u64 x)
+{
+	struct fixed31_32 val;
+
+	/* If negative, convert to 2's complement. */
+	if (x & (1ULL << 63))
+		x = -(x & ~(1ULL << 63));
+
+	val.value = x;
+	return val;
+}
+
 /*
  * @brief
  * Initialization routines
-- 
2.40.1

