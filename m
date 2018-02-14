From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 04/13] drm/amd/include: remove unused asic_reg/gca headers
Date: Wed, 14 Feb 2018 14:46:08 +0000
Message-ID: <1518619577-19771-5-git-send-email-clabbe@baylibre.com>
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
 .../gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h   |  2791 ---
 .../drm/amd/include/asic_reg/gca/gfx_8_1_enum.h    |  6808 ------
 .../drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h | 21368 -------------------
 3 files changed, 30967 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
deleted file mode 100644
index 2d672b3d2fed..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
deleted file mode 100644
index f9022097fbe9..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h
deleted file mode 100644
index 397705a6b3a2..000000000000
-- 
2.13.6
