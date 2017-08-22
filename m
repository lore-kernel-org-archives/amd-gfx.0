From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] drm/radeon/ci: tidy up some limit checks
Date: Tue, 22 Aug 2017 23:30:34 +0300
Message-ID: <20170822203033.u7ltp2xjaqmoqrl4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This is partly to silence a static checker warning:

    drivers/gpu/drm/amd/amdgpu/ci_dpm.c:4553 ci_set_mc_special_registers()
    error: buffer overflow 'table->mc_reg_address' 16 <= 16

The story is that it's valid to exit the loop with "j" less than or equal
to SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE".  That value for "j" gets saved
as table->last.  We're not allow to access "table->mc_reg_address[j]"
when j == SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE because that's one past
the end of the array.

The tests for "if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)" in
ci_set_mc_special_registers() are always false because we start with
j less than the array size and we increment it once so at most it can be
equal.

Then there is a bogus check in ci_register_patching_mc_seq() where
it complains if "table->last >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE".
The "table->last" value can't possibly be greater than the array size
and it is allowed to be equal to it.  So let's just remove that test
entirely.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.  Please review this one carefully.

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index c97fbb2ab48b..d3136e020d5a 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4342,10 +4342,10 @@ static int ci_set_mc_special_registers(struct radeon_device *rdev,
 					table->mc_reg_table_entry[k].mc_data[j] |= 0x100;
 			}
 			j++;
-			if (j > SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 
 			if (!pi->mem_gddr5) {
+				if (j >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
+					return -EINVAL;
 				table->mc_reg_address[j].s1 = MC_PMG_AUTO_CMD >> 2;
 				table->mc_reg_address[j].s0 = MC_PMG_AUTO_CMD >> 2;
 				for (k = 0; k < table->num_entries; k++) {
@@ -4521,8 +4521,6 @@ static int ci_register_patching_mc_seq(struct radeon_device *rdev,
 	    ((rdev->pdev->device == 0x67B0) ||
 	     (rdev->pdev->device == 0x67B1))) {
 		for (i = 0; i < table->last; i++) {
-			if (table->last >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
-				return -EINVAL;
 			switch(table->mc_reg_address[i].s1 >> 2) {
 			case MC_SEQ_MISC1:
 				for (k = 0; k < table->num_entries; k++) {
