Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBF9CCFA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 13:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D2110E5C6;
	Tue, 11 Nov 2025 13:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jh6LIRvy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AAA10E50D;
 Tue, 11 Nov 2025 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1762851144;
 bh=AOtxztYb3EUCtWNh0dzQl6PgAK/9e+Oi10O5JPoqGo4=;
 h=From:Date:Subject:To:Cc:From;
 b=jh6LIRvyb5680qh6eoFuSxCsS8+ArGe3FK9/qzJEoSmtRz2ntM7Mb4bTVmmQzN3e6
 j4pKsxb3onlQK3Uh1SN5DjmczMcg0ROBoBLlXR8usMf/yduegz0jAujmQPiBsfUFwC
 mIIBXqAgtQfzUh/8TQMniH6DP80D5Z8p1s4jRmgEzdWvwY4bT+Lyy8LIxK4pTzQVhk
 EiOO0GtUB3OLMy3n7KdAbw2my55p84M63pYVjCSarhqaQSUO9HPxmBbLWERTb9FZ2v
 RvK03gfr4TA/MreDaCafqE0IbouGKxAn/tbtIV0f34+xSo9OZzocEoyIBqQYssg1NO
 abMMlPbqw9aFg==
Received: from localhost (unknown [82.79.138.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9A7C017E1318;
 Tue, 11 Nov 2025 09:52:24 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Nov 2025 10:52:11 +0200
Subject: [PATCH v2] drm/amdgpu: Fix kernel-doc comments for some LUT properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-amdgpu-fix-kdoc-lut-v2-1-bcfcc82e962d@collabora.com>
X-B4-Tracking: v=1; b=H4sIADr5EmkC/32NTQ6CMBSEr0Le2mdoa4G48h6GRX8e0AiUtEA0p
 He3cgCX30zmmwMiBUcR7sUBgXYXnZ8z8EsBZlBzT+hsZuAll2XDBarJ9suGnXvjy3qD47aikLX
 VjZZ1RwR5uQTK/Wl9tpkHF1cfPufJzn7pf9/OkKEoK22UvTFe1Q/jx1FpH9TV+AnalNIXkYsEN
 roAAAA=
X-Change-ID: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 11 Nov 2025 13:39:06 +0000
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

The following members of struct amdgpu_mode_info do not have valid
references in the related kernel-doc sections:

 - plane_shaper_lut_property
 - plane_shaper_lut_size_property,
 - plane_lut3d_size_property

Correct all affected comment blocks.

Fixes: f545d82479b4 ("drm/amd/display: add plane shaper LUT and TF driver-specific properties")
Fixes: 671994e3bf33 ("drm/amd/display: add plane 3D LUT driver-specific properties")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Collected R-b tag from Melissa
- Rebased onto latest drm-misc-next
- Link to v1: https://lore.kernel.org/r/20250823-amdgpu-fix-kdoc-lut-v1-1-306bcad41267@collabora.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index dc8d2f52c7d6..e244c12ceb23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -368,15 +368,15 @@ struct amdgpu_mode_info {
 
 	struct drm_property *plane_ctm_property;
 	/**
-	 * @shaper_lut_property: Plane property to set pre-blending shaper LUT
-	 * that converts color content before 3D LUT. If
-	 * plane_shaper_tf_property != Identity TF, AMD color module will
+	 * @plane_shaper_lut_property: Plane property to set pre-blending
+	 * shaper LUT that converts color content before 3D LUT.
+	 * If plane_shaper_tf_property != Identity TF, AMD color module will
 	 * combine the user LUT values with pre-defined TF into the LUT
 	 * parameters to be programmed.
 	 */
 	struct drm_property *plane_shaper_lut_property;
 	/**
-	 * @shaper_lut_size_property: Plane property for the size of
+	 * @plane_shaper_lut_size_property: Plane property for the size of
 	 * pre-blending shaper LUT as supported by the driver (read-only).
 	 */
 	struct drm_property *plane_shaper_lut_size_property;
@@ -400,10 +400,10 @@ struct amdgpu_mode_info {
 	 */
 	struct drm_property *plane_lut3d_property;
 	/**
-	 * @plane_degamma_lut_size_property: Plane property to define the max
-	 * size of 3D LUT as supported by the driver (read-only). The max size
-	 * is the max size of one dimension and, therefore, the max number of
-	 * entries for 3D LUT array is the 3D LUT size cubed;
+	 * @plane_lut3d_size_property: Plane property to define the max size
+	 * of 3D LUT as supported by the driver (read-only). The max size is
+	 * the max size of one dimension and, therefore, the max number of
+	 * entries for 3D LUT array is the 3D LUT size cubed.
 	 */
 	struct drm_property *plane_lut3d_size_property;
 	/**

---
base-commit: be4cd2a13a31496c7fb9e46a244c4391b8b7cf31
change-id: 20250823-amdgpu-fix-kdoc-lut-357db8b57fee

