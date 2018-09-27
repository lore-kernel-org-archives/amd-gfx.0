From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] drm/amd/display: Use proper enums in process_channel_reply
Date: Thu, 27 Sep 2018 11:06:33 -0700
Message-ID: <20180927180632.11520-1-natechancellor@gmail.com>
References: <20180921215505.14634-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921215505.14634-1-natechancellor@gmail.com>
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

The current enum is incorrect, it should be from aux_transaction_reply,
so use AUX_TRANSACTION_REPLY_HPD_DISCON.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Rather than change status to an integer, use the proper enumerated
  type from aux_transaction reply as suggested by Nick and confirmed
  by Henry.

 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                    | 2 +-
 .../gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 3f5b2e6f7553..aaeb7faac0c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -312,7 +312,7 @@ static void process_channel_reply(
 
 	/* in case HPD is LOW, exit AUX transaction */
 	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
-		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
+		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
index 8eee8ace1259..59c3ed43d609 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
@@ -346,7 +346,7 @@ static void process_channel_reply(
 
 	/* in case HPD is LOW, exit AUX transaction */
 	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
-		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
+		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
 		return;
 	}
 
-- 
2.19.0
