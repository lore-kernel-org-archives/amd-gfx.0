From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 13/13] drm/amd/powerplay: remove unused headers
Date: Wed, 14 Feb 2018 14:46:17 +0000
Message-ID: <1518619577-19771-14-git-send-email-clabbe@baylibre.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: amd-gfx.lists.freedesktop.org

All thoses headers are not used by any source files.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    | 412 ---------------------
 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |  67 ----
 2 files changed, 479 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h

diff --git a/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
deleted file mode 100644
index b8f4b73c322e..000000000000
diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h b/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
deleted file mode 100644
index 0faf6a25c18b..000000000000
-- 
2.13.6
