From: Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH] drm/amd/display: remove gcc warning Wunused-but-set-variable
Date: Sat, 19 Oct 2019 11:23:51 +0800
Message-ID: <1571455431-104881-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, Bhawanpreet.Lakha@amd.com, David.Francis@amd.com, Tony.Cheng@amd.com, abdoulaye.berthe@amd.com, Thomas.Lim@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

From: Chenwandun <chenwandun@huawei.com>

drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: In function dce_aux_configure_timeout:
drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: warning: variable timeout set but not used [-Wunused-but-set-variable]

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 976bd49..739f8e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -432,7 +432,6 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
 {
 	uint32_t multiplier = 0;
 	uint32_t length = 0;
-	uint32_t timeout = 0;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
 	struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
@@ -446,25 +445,21 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_8;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_8 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_8;
 	} else if (timeout_in_us <= 2 * TIME_OUT_INCREMENT) {
 		multiplier = 1;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_16;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_16 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_16;
 	} else if (timeout_in_us <= 4 * TIME_OUT_INCREMENT) {
 		multiplier = 2;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_32;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_32 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_32;
 	} else if (timeout_in_us > 4 * TIME_OUT_INCREMENT) {
 		multiplier = 3;
 		length = timeout_in_us/TIME_OUT_MULTIPLIER_64;
 		if (timeout_in_us % TIME_OUT_MULTIPLIER_64 != 0)
 			length++;
-		timeout = length * TIME_OUT_MULTIPLIER_64;
 	}
 
 	length = (length < MAX_TIMEOUT_LENGTH) ? length : MAX_TIMEOUT_LENGTH;
-- 
2.7.4
