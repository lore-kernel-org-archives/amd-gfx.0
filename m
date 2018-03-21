From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drm/amd/pp: use mlck_table.count for array loop index
 limit
Date: Wed, 21 Mar 2018 12:02:10 -0700
Message-ID: <1521658930.7999.25.camel@perches.com>
References: <20180321182653.3150-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321182653.3150-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 2018-03-21 at 18:26 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The for-loops process data in the mclk_table but use slck_table.count
> as the loop index limit.  I believe these are cut-n-paste errors from
> the previous almost identical loops as indicated by static analysis.
> Fix these.

Nice tool.

> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
[]
> @@ -855,7 +855,7 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
>  
>  	odn_table->odn_memory_clock_dpm_levels.num_of_pl =
>  						data->golden_dpm_table.mclk_table.count;
> -	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
> +	for (i=0; i<data->golden_dpm_table.mclk_table.count; i++) {
>  		odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
>  					data->golden_dpm_table.mclk_table.dpm_levels[i].value;
>  		odn_table->odn_memory_clock_dpm_levels.entries[i].enabled = true;

Probably more sensible to use temporaries too.
Maybe something like the below (also trivially reduces object size)
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index df2a312ca6c9..339b897146af 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -834,6 +834,7 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_sclk_table;
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_mclk_table;
+	struct phm_odn_performance_level *entries;
 
 	if (table_info == NULL)
 		return -EINVAL;
@@ -843,11 +844,11 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	odn_table->odn_core_clock_dpm_levels.num_of_pl =
 						data->golden_dpm_table.sclk_table.count;
+	entries = odn_table->odn_core_clock_dpm_levels.entries;
 	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
-		odn_table->odn_core_clock_dpm_levels.entries[i].clock =
-					data->golden_dpm_table.sclk_table.dpm_levels[i].value;
-		odn_table->odn_core_clock_dpm_levels.entries[i].enabled = true;
-		odn_table->odn_core_clock_dpm_levels.entries[i].vddc = dep_sclk_table->entries[i].vddc;
+		entries[i].clock = data->golden_dpm_table.sclk_table.dpm_levels[i].value;
+		entries[i].enabled = true;
+		entries[i].vddc = dep_sclk_table->entries[i].vddc;
 	}
 
 	smu7_get_voltage_dependency_table(dep_sclk_table,
@@ -855,11 +856,11 @@ static int smu7_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 
 	odn_table->odn_memory_clock_dpm_levels.num_of_pl =
 						data->golden_dpm_table.mclk_table.count;
-	for (i=0; i<data->golden_dpm_table.sclk_table.count; i++) {
-		odn_table->odn_memory_clock_dpm_levels.entries[i].clock =
-					data->golden_dpm_table.mclk_table.dpm_levels[i].value;
-		odn_table->odn_memory_clock_dpm_levels.entries[i].enabled = true;
-		odn_table->odn_memory_clock_dpm_levels.entries[i].vddc = dep_mclk_table->entries[i].vddc;
+	entries = odn_table->odn_memory_clock_dpm_levels.entries;
+	for (i=0; i<data->golden_dpm_table.mclk_table.count; i++) {
+		entries[i].clock = data->golden_dpm_table.mclk_table.dpm_levels[i].value;
+		entries[i].enabled = true;
+		entries[i].vddc = dep_mclk_table->entries[i].vddc;
 	}
 
 	smu7_get_voltage_dependency_table(dep_mclk_table,
