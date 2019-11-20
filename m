From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH 1/2] drm/amd/display: remove set but not used variable 'dc_fixpt_e' and 'dc_fixpt_pi'
Date: Wed, 20 Nov 2019 21:15:32 +0800
Message-ID: <20191120131533.12720-2-yukuai3@huawei.com>
References: <20191120131533.12720-1-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120131533.12720-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Jammy.Zhou@amd.com, tianci.yin@amd.com, sam@ravnborg.org, luben.tuikov@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

'dc_fixpt_e' and 'dc_fixpt_pi' are set in 'fixed31_32.h'. However, they
are never used and so can be removed.

Fixes: eb0e515464e4 ("drm/amd/display: get rid of 32.32 unsigned fixed point")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/display/include/fixed31_32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 89ef9f6860e5..291215362e3f 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -69,9 +69,7 @@ static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
 
-static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
 static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
-static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
 static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
 static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
 
-- 
2.17.2
