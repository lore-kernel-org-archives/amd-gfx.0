From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] gpu: drm: amd: powerplay: Remove logically dead code
Date: Mon, 5 Aug 2019 22:51:38 +0530
Message-ID: <20190805172138.GA4534@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Result of pointer airthmentic is never null

fix coverity defect:1451876

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index ee739c0..a3acd77 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -736,8 +736,6 @@ static int smu_v11_0_write_watermarks_table(struct smu_context *smu)
 	struct smu_table *table = NULL;
 
 	table = &smu_table->tables[SMU_TABLE_WATERMARKS];
-	if (!table)
-		return -EINVAL;
 
 	if (!table->cpu_addr)
 		return -EINVAL;
-- 
2.7.4
