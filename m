From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 1/4] drm/amd/powerplay: Cocci spatch "alloc_cast"
Date: Thu, 21 Sep 2017 08:33:46 +0200
Message-ID: <1505975570447-1553434828-1-diffsplit-thomas@m3y3r.de>
References: <1505975570447-826702259-0-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505975570447-826702259-0-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Remove casting the values returned by memory allocation functions like
kmalloc, kzalloc, kmem_cache_alloc, kmem_cache_zalloc etc."
Found by coccinelle spatch "api/alloc/alloc_cast.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
@@ -291,7 +291,7 @@ static int get_mm_clock_voltage_table(
 	table_size = sizeof(uint32_t) +
 			sizeof(phm_ppt_v1_mm_clock_voltage_dependency_record) *
 			mm_dependency_table->ucNumEntries;
-	mm_table = (phm_ppt_v1_mm_clock_voltage_dependency_table *)
+	mm_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!mm_table)
@@ -519,7 +519,7 @@ static int get_socclk_voltage_dependency
 			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
 			clk_dep_table->ucNumEntries;
 
-	clk_table = (phm_ppt_v1_clock_voltage_dependency_table *)
+	clk_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!clk_table)
@@ -554,7 +554,7 @@ static int get_mclk_voltage_dependency_t
 			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
 			mclk_dep_table->ucNumEntries;
 
-	mclk_table = (phm_ppt_v1_clock_voltage_dependency_table *)
+	mclk_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!mclk_table)
@@ -596,7 +596,7 @@ static int get_gfxclk_voltage_dependency
 			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
 			clk_dep_table->ucNumEntries;
 
-	clk_table = (struct phm_ppt_v1_clock_voltage_dependency_table *)
+	clk_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!clk_table)
@@ -663,7 +663,7 @@ static int get_pix_clk_voltage_dependenc
 			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
 			clk_dep_table->ucNumEntries;
 
-	clk_table = (struct phm_ppt_v1_clock_voltage_dependency_table *)
+	clk_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!clk_table)
@@ -728,7 +728,7 @@ static int get_dcefclk_voltage_dependenc
 			sizeof(phm_ppt_v1_clock_voltage_dependency_record) *
 			num_entries;
 
-	clk_table = (struct phm_ppt_v1_clock_voltage_dependency_table *)
+	clk_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!clk_table)
@@ -772,7 +772,7 @@ static int get_pcie_table(struct pp_hwmg
 			sizeof(struct phm_ppt_v1_pcie_record) *
 			atom_pcie_table->ucNumEntries;
 
-	pcie_table = (struct phm_ppt_v1_pcie_table *)
+	pcie_table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (!pcie_table)
@@ -1026,7 +1026,7 @@ static int get_vddc_lookup_table(
 	table_size = sizeof(uint32_t) +
 			sizeof(phm_ppt_v1_voltage_lookup_record) * max_levels;
 
-	table = (phm_ppt_v1_voltage_lookup_table *)
+	table =
 			kzalloc(table_size, GFP_KERNEL);
 
 	if (NULL == table)
