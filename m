From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] drm/amdgpu/display: provide ASSERT macros unconditionally
Date: Thu,  2 Nov 2017 15:24:40 +0100
Message-ID: <20171102142501.684516-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

It seems impossible to build this driver without setting either
CONFIG_DEBUG_KERNEL or CONFIG_DEBUG_DRIVER:

drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h: In function 'set_reg_field_value_ex':
drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:132:2: error: implicit declaration of function 'ASSERT'; did you mean 'IS_ERR'? [-Werror=implicit-function-declaration]

This moves the ASSERT() macro and related helpers outside of
the #ifdef to get it to build again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 4 ----
 1 file changed, 4 deletions(-)

v2: remove accidtental comment change.

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 86170b40b5c5..a87c0329541f 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -61,8 +61,6 @@
  * general debug capabilities
  *
  */
-#if defined(CONFIG_DEBUG_KERNEL) || defined(CONFIG_DEBUG_DRIVER)
-
 #if defined(CONFIG_HAVE_KGDB) || defined(CONFIG_KGDB)
 #define ASSERT_CRITICAL(expr) do {	\
 	if (WARN_ON(!(expr))) { \
@@ -86,8 +84,6 @@
 
 #define BREAK_TO_DEBUGGER() ASSERT(0)
 
-#endif /* CONFIG_DEBUG_KERNEL || CONFIG_DEBUG_DRIVER */
-
 #define DC_ERR(...)  do { \
 	dm_error(__VA_ARGS__); \
 	BREAK_TO_DEBUGGER(); \
-- 
2.9.0
