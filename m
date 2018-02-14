From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 10/13] drm/amd/include: remove unused asic_reg/sdma headers
Date: Wed, 14 Feb 2018 14:46:14 +0000
Message-ID: <1518619577-19771-11-git-send-email-clabbe@baylibre.com>
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
 .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h | 286 ---------------------
 .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h | 282 --------------------
 2 files changed, 568 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
deleted file mode 100644
index 4be3cb5c4556..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
deleted file mode 100644
index 934733762ddf..000000000000
-- 
2.13.6
