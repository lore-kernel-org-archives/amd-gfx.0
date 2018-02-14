From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 02/13] drm/amd/include: remove unused asic_reg/bif headers
Date: Wed, 14 Feb 2018 14:46:06 +0000
Message-ID: <1518619577-19771-3-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/bif/bif_5_0_enum.h    | 1198 --------------------
 .../drm/amd/include/asic_reg/bif/bif_5_1_enum.h    | 1068 -----------------
 2 files changed, 2266 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
deleted file mode 100644
index 46b75f4bbc36..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h
deleted file mode 100644
index d8d5ae0b341f..000000000000
-- 
2.13.6
