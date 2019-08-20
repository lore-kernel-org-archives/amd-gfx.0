From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Fix 32-bit divide error in wait_for_alt_mode
Date: Tue, 20 Aug 2019 16:57:13 -0700
Message-ID: <20190820235713.3429-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

When building arm32 allyesconfig:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by dc_link.c
>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a
>>> referenced by dc_link.c
>>> gpu/drm/amd/display/dc/core/dc_link.o:(wait_for_alt_mode) in archive drivers/built-in.a

time_taken_in_ns is of type unsigned long long so we need to use div_u64
to avoid this error.

Fixes: b5b1f4554904 ("drm/amd/display: Enable type C hotplug")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f2d78d7b089e..8634923b4444 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -721,7 +721,7 @@ bool wait_for_alt_mode(struct dc_link *link)
 			time_taken_in_ns = dm_get_elapse_time_in_ns(
 				link->ctx, finish_timestamp, enter_timestamp);
 			DC_LOG_WARNING("Alt mode entered finished after %llu ms\n",
-				       time_taken_in_ns / 1000000);
+				       div_u64(time_taken_in_ns, 1000000));
 			return true;
 		}
 
@@ -730,7 +730,7 @@ bool wait_for_alt_mode(struct dc_link *link)
 	time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp,
 						    enter_timestamp);
 	DC_LOG_WARNING("Alt mode has timed out after %llu ms\n",
-			time_taken_in_ns / 1000000);
+			div_u64(time_taken_in_ns, 1000000));
 	return false;
 }
 
-- 
2.23.0
