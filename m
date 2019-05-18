From: Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] gpu: fix typos in code comments
Date: Sat, 18 May 2019 21:41:41 +0800
Message-ID: <20190518134141.23214-1-houweitaoo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, michel.daenzer@amd.com, Dmytro.Laktyushkin@amd.com, Anthony.Koo@amd.com, ken.chalmers@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Weitao Hou <houweitaoo@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

fix eror to error

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index f70437aae8e0..df422440845b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -183,8 +183,8 @@ static bool calculate_fb_and_fractional_fb_divider(
 *RETURNS:
 * It fills the PLLSettings structure with PLL Dividers values
 * if calculated values are within required tolerance
-* It returns	- true if eror is within tolerance
-*		- false if eror is not within tolerance
+* It returns	- true if error is within tolerance
+*		- false if error is not within tolerance
 */
 static bool calc_fb_divider_checking_tolerance(
 		struct calc_pll_clock_source *calc_pll_cs,
-- 
2.18.0
