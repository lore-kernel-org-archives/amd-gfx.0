From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] GPU-DRM-Radeon: Fine-tuning for three function
 implementations
Date: Tue, 2 May 2017 22:04:31 +0200
Message-ID: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 May 2017 22:00:02 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use seq_putc() in radeon_sa_bo_dump_debug_info()
  Use seq_puts() in radeon_debugfs_pm_info()
  Use seq_puts() in r100_debugfs_cp_csq_fifo()

 drivers/gpu/drm/radeon/r100.c      | 6 +++---
 drivers/gpu/drm/radeon/radeon_pm.c | 5 +++--
 drivers/gpu/drm/radeon/radeon_sa.c | 9 +++------
 3 files changed, 9 insertions(+), 11 deletions(-)

-- 
2.12.2

