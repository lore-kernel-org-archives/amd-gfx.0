From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 042/141] drm/amd/display: fix compilation error
Date: Fri, 19 Jul 2019 00:01:07 -0400
Message-ID: <20190719040246.15945-42-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>

[ Upstream commit 88099f53cc3717437f5fc9cf84205c5b65118377 ]

this patch fixes below compilation error

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In
function ‘dcn10_apply_ctx_for_surface’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3:
error: implicit declaration of function ‘udelay’
[-Werror=implicit-function-declaration]
   udelay(underflow_check_delay_us);

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1fac86d3032d..289283ddaee4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -23,6 +23,7 @@
  *
  */
 
+#include <linux/delay.h>
 #include "dm_services.h"
 #include "core_types.h"
 #include "resource.h"
-- 
2.20.1
