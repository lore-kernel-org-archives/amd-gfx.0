Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BD9CED27C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 08:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAF010E4A5;
	Tue,  8 Oct 2024 08:37:32 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5E610E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 08:37:31 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4988bIfR622174; Tue, 8 Oct 2024 14:07:18 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4988bH4B622173;
 Tue, 8 Oct 2024 14:07:17 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Sameer Lattannavar <sameer.lattannavar@intel.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>
Subject: [PATCH v1 2/2] drm: fix doc warning for height and width of plane
Date: Tue,  8 Oct 2024 14:07:10 +0530
Message-Id: <20241008083710.622153-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008083710.622153-1-sunil.khatri@amd.com>
References: <20241008083710.622153-1-sunil.khatri@amd.com>
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

Fixes:
include/uapi/drm/drm_mode.h:869:
warning: Function parameter or struct member
'width' not described in 'drm_plane_size_hint'

include/uapi/drm/drm_mode.h:869:
warning: Function parameter or struct member
'height' not described in 'drm_plane_size_hint'

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Sameer Lattannavar <sameer.lattannavar@intel.com>
Cc: Jonas Ådahl <jadahl@redhat.com>
---
 include/uapi/drm/drm_mode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..ea07fbbde425 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -862,6 +862,8 @@ struct drm_color_lut {
  *
  * The plane SIZE_HINTS property blob contains an
  * array of struct drm_plane_size_hint.
+ * @width: Plane width hint
+ * @height: Plane height hint
  */
 struct drm_plane_size_hint {
 	__u16 width;
-- 
2.34.1

