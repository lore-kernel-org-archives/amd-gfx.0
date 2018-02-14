From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 01/13] drm/amd/include: remove unused asic_reg/oss headers
Date: Wed, 14 Feb 2018 14:46:05 +0000
Message-ID: <1518619577-19771-2-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/oss/oss_2_4_enum.h    | 1340 ------------------
 .../drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h  | 1464 -------------------
 .../drm/amd/include/asic_reg/oss/oss_3_0_enum.h    | 1497 --------------------
 3 files changed, 4301 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h
deleted file mode 100644
index 37adf0df0fd3..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h
deleted file mode 100644
index 627cff10fcce..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h
deleted file mode 100644
index 09338d82afba..000000000000
-- 
2.13.6
