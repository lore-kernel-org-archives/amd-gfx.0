From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 12/13] drm/amd/include: remove unused displayobject.h header
Date: Wed, 14 Feb 2018 14:46:16 +0000
Message-ID: <1518619577-19771-13-git-send-email-clabbe@baylibre.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: amd-gfx.lists.freedesktop.org

displayobject.h is not used by any source files.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/amd/include/displayobject.h | 249 ----------------------------
 1 file changed, 249 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/displayobject.h

diff --git a/drivers/gpu/drm/amd/include/displayobject.h b/drivers/gpu/drm/amd/include/displayobject.h
deleted file mode 100644
index 67e23ff9cbd4..000000000000
-- 
2.13.6
