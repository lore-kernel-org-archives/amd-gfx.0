From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/radeon: add header comment for clarification to
 vce_v2_0_enable_mgcg()
Date: Thu, 29 Jun 2017 12:38:37 -0500
Message-ID: <20170629173837.GA3397@embeddedgus>
References: <CADnq5_NhSDyBRSTpYEnBnSNG1AC=W_bHew-VcU1MxzaBcAURnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_NhSDyBRSTpYEnBnSNG1AC=W_bHew-VcU1MxzaBcAURnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Add function header comment to make it clear that local variable sw_cg
is used for debugging and it should not be removed.

Addresses-Coverity-ID: 1198635
Cc: Alex Deucher <alexdeucher@gmail.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/radeon/vce_v2_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/vce_v2_0.c b/drivers/gpu/drm/radeon/vce_v2_0.c
index fce2144..b0a43b6 100644
--- a/drivers/gpu/drm/radeon/vce_v2_0.c
+++ b/drivers/gpu/drm/radeon/vce_v2_0.c
@@ -104,6 +104,10 @@ static void vce_v2_0_disable_cg(struct radeon_device *rdev)
 	WREG32(VCE_CGTT_CLK_OVERRIDE, 7);
 }
 
+/*
+ * Local variable sw_cg is used for debugging purposes, in case we
+ * ran into problems with dynamic clock gating. Don't remove it.
+ */
 void vce_v2_0_enable_mgcg(struct radeon_device *rdev, bool enable)
 {
 	bool sw_cg = false;
-- 
2.5.0
