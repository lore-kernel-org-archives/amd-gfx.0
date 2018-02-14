From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 09/13] drm/amd/include: remove unused asic_reg/vce headers
Date: Wed, 14 Feb 2018 14:46:13 +0000
Message-ID: <1518619577-19771-10-git-send-email-clabbe@baylibre.com>
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
 .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   | 64 --------------
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h | 99 ----------------------
 2 files changed, 163 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
deleted file mode 100644
index 2176548e9203..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
deleted file mode 100644
index ea5b26b11cb1..000000000000
-- 
2.13.6
