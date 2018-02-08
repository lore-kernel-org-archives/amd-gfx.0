From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 4/4] amdgpu/dc/calcs: Support clang option for stack alignment
Date: Thu,  8 Feb 2018 12:53:16 -0800
Message-ID: <20180208205316.93330-4-mka@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180208205316.93330-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Justin TerAvest <teravest@chromium.org>, Craig Bergstrom <craigb@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: amd-gfx.lists.freedesktop.org

calcs uses the compiler option -mpreferred-stack-boundary=4 to configure
a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
instead, which expects as parameter the alignment in bytes, and not a
power of two like -mpreferred-stack-boundary.

Probe for both compiler options and use the correct one, similar to
what is done in arch/x86/Makefile.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added

Note to self: if this patterns proliferates further we probably want to
put the evaluation of the correct compiler flag in some common place.

 drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
index af0f452f3c9f..95f332ee3e7e 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
@@ -24,7 +24,13 @@
 # It calculates Bandwidth and Watermarks values for HW programming
 #
 
-calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+calcs_ccflags := -mhard-float -msse $(cc_stack_align)
 
 CFLAGS_dcn_calcs.o := $(calcs_ccflags)
 CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
-- 
2.16.0.rc1.238.g530d649a79-goog
