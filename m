From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Change status's type in aux_reply_transaction_data
Date: Fri, 21 Sep 2018 14:55:05 -0700
Message-ID: <20180921215505.14634-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
implicit conversion from enumeration type 'enum
aux_channel_operation_result' to different enumeration type 'enum
aux_transaction_reply' [-Wenum-conversion]
                reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
                              ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
warning: implicit conversion from enumeration type 'enum
aux_channel_operation_result' to different enumeration type 'enum
aux_transaction_reply' [-Wenum-conversion]
                reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
                              ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead of implicitly or explicitly converting between types, just
change status to type uint8_t (since its max size is 255) which avoids
this construct altogether.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
index 05c8c31d8b31..97e1d4d19263 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
@@ -79,7 +79,7 @@ enum aux_transaction_reply {
 };
 
 struct aux_reply_transaction_data {
-	enum aux_transaction_reply status;
+	uint8_t status;
 	uint32_t length;
 	uint8_t *data;
 };
-- 
2.19.0
