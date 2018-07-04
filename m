From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
Date: Wed, 4 Jul 2018 08:22:11 -0500
Message-ID: <20180704132211.GA6764@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Add suffix ULL to constant 5 and cast variables target_pix_clk_khz and
feedback_divider to uint64_t in order to avoid multiple potential integer
overflows and give the compiler complete information about the proper
arithmetic to use.

Notice that such constant and variables are used in contexts that
expect expressions of type uint64_t (64 bits, unsigned). The current
casts to uint64_t effectively apply to each expression as a whole,
but they do not prevent them from being evaluated using 32-bit
arithmetic instead of 64-bit arithmetic.

Also, once the expressions are properly evaluated using 64-bit
arithmentic, there is no need for the parentheses that enclose
them.

Addresses-Coverity-ID: 1460245 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460286 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1460401 ("Unintentional integer overflow")
Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Add suffix ULL to constant 5 instead of UL. Thanks to Michel Dänzer
   for pointing this out.

 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 88b09dd..ca13775 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -133,7 +133,7 @@ static bool calculate_fb_and_fractional_fb_divider(
 	uint64_t feedback_divider;
 
 	feedback_divider =
-		(uint64_t)(target_pix_clk_khz * ref_divider * post_divider);
+		(uint64_t)target_pix_clk_khz * ref_divider * post_divider;
 	feedback_divider *= 10;
 	/* additional factor, since we divide by 10 afterwards */
 	feedback_divider *= (uint64_t)(calc_pll_cs->fract_fb_divider_factor);
@@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
  * of fractional feedback decimal point and the fractional FB Divider precision
  * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
 
-	feedback_divider += (uint64_t)
-			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
+	feedback_divider += 5ULL *
+			    calc_pll_cs->fract_fb_divider_precision_factor;
 	feedback_divider =
 		div_u64(feedback_divider,
 			calc_pll_cs->fract_fb_divider_precision_factor * 10);
@@ -203,8 +203,8 @@ static bool calc_fb_divider_checking_tolerance(
 			&fract_feedback_divider);
 
 	/*Actual calculated value*/
-	actual_calc_clk_khz = (uint64_t)(feedback_divider *
-					calc_pll_cs->fract_fb_divider_factor) +
+	actual_calc_clk_khz = (uint64_t)feedback_divider *
+					calc_pll_cs->fract_fb_divider_factor +
 							fract_feedback_divider;
 	actual_calc_clk_khz *= calc_pll_cs->ref_freq_khz;
 	actual_calc_clk_khz =
-- 
2.7.4
