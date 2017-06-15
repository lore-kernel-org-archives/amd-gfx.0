From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/radeon: remove unnecessary variable in si_enable_smc_cac
Date: Thu, 15 Jun 2017 17:37:53 -0500
Message-ID: <20170615223753.GA15833@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Remove unnecessary variable smc_result and simplify the logic related.

Variable smc_result is only being used to store the return value of function
si_send_msg_to_smc() and then compare this value against constant
PPSMC_Result_OK. In other cases this variable is not even used after
storing a value in it (lines of code 2833 and 2838). Besides,
by removing this variable the logic can be simplified and the number
of nested IF statements reduced.

Addresses-Coverity-ID: 1226969
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 49 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index ee3e742..09ef41f 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -2800,42 +2800,37 @@ static int si_enable_smc_cac(struct radeon_device *rdev,
 {
 	struct ni_power_info *ni_pi = ni_get_pi(rdev);
 	struct si_power_info *si_pi = si_get_pi(rdev);
-	PPSMC_Result smc_result;
 	int ret = 0;
 
 	if (ni_pi->enable_cac) {
-		if (enable) {
-			if (!si_should_disable_uvd_powertune(rdev, radeon_new_state)) {
-				if (ni_pi->support_cac_long_term_average) {
-					smc_result = si_send_msg_to_smc(rdev, PPSMC_CACLongTermAvgEnable);
-					if (smc_result != PPSMC_Result_OK)
-						ni_pi->support_cac_long_term_average = false;
-				}
-
-				smc_result = si_send_msg_to_smc(rdev, PPSMC_MSG_EnableCac);
-				if (smc_result != PPSMC_Result_OK) {
-					ret = -EINVAL;
-					ni_pi->cac_enabled = false;
-				} else {
-					ni_pi->cac_enabled = true;
-				}
-
-				if (si_pi->enable_dte) {
-					smc_result = si_send_msg_to_smc(rdev, PPSMC_MSG_EnableDTE);
-					if (smc_result != PPSMC_Result_OK)
-						ret = -EINVAL;
-				}
+		if (enable &&
+		    !si_should_disable_uvd_powertune(rdev, radeon_new_state)) {
+			if (ni_pi->support_cac_long_term_average &&
+			    PPSMC_Result_OK !=
+			    si_send_msg_to_smc(rdev, PPSMC_CACLongTermAvgEnable))
+				ni_pi->support_cac_long_term_average = false;
+
+			if (si_send_msg_to_smc(rdev, PPSMC_MSG_EnableCac) !=
+			    PPSMC_Result_OK) {
+				ret = -EINVAL;
+				ni_pi->cac_enabled = false;
+			} else {
+				ni_pi->cac_enabled = true;
 			}
-		} else if (ni_pi->cac_enabled) {
-			if (si_pi->enable_dte)
-				smc_result = si_send_msg_to_smc(rdev, PPSMC_MSG_DisableDTE);
 
-			smc_result = si_send_msg_to_smc(rdev, PPSMC_MSG_DisableCac);
+			if (si_pi->enable_dte &&
+			    si_send_msg_to_smc(rdev, PPSMC_MSG_EnableDTE) !=
+			    PPSMC_Result_OK)
+				ret = -EINVAL;
+		} else if (!enable && ni_pi->cac_enabled) {
+			if (si_pi->enable_dte)
+				si_send_msg_to_smc(rdev, PPSMC_MSG_DisableDTE);
 
+			si_send_msg_to_smc(rdev, PPSMC_MSG_DisableCac);
 			ni_pi->cac_enabled = false;
 
 			if (ni_pi->support_cac_long_term_average)
-				smc_result = si_send_msg_to_smc(rdev, PPSMC_CACLongTermAvgDisable);
+				si_send_msg_to_smc(rdev, PPSMC_CACLongTermAvgDisable);
 		}
 	}
 	return ret;
-- 
2.5.0
