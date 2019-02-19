From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amd/powerplay/smu10_hwmgr: use struct_size() in kzalloc()
Date: Tue, 19 Feb 2019 12:55:09 -0600
Message-ID: <20190219185509.GA23853@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

Notice that, in this case, variable table_size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 5273de3c5b98..0ad8fe4a6277 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -139,12 +139,10 @@ static int smu10_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
 static int smu10_init_dynamic_state_adjustment_rule_settings(
 							struct pp_hwmgr *hwmgr)
 {
-	uint32_t table_size =
-		sizeof(struct phm_clock_voltage_dependency_table) +
-		(7 * sizeof(struct phm_clock_voltage_dependency_record));
+	struct phm_clock_voltage_dependency_table *table_clk_vlt;
 
-	struct phm_clock_voltage_dependency_table *table_clk_vlt =
-					kzalloc(table_size, GFP_KERNEL);
+	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 7),
+				GFP_KERNEL);
 
 	if (NULL == table_clk_vlt) {
 		pr_err("Can not allocate memory!\n");
-- 
2.20.1
