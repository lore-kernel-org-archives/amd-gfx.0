From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
Date: Wed,  2 Oct 2019 14:01:27 +0200
Message-ID: <20191002120136.1777161-7-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Code in the amdgpu driver triggers a bug when using clang to build
an arm64 kernel:

/tmp/sdma_v4_0-f95fd3.s: Assembler messages:
/tmp/sdma_v4_0-f95fd3.s:44: Error: selected processor does not support `bfc w0,#1,#5'

I expect this to be fixed in llvm soon, but we can also work around
it by inserting a barrier() that prevents the optimization.

Link: https://bugs.llvm.org/show_bug.cgi?id=42576
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Apparently this bug is still present in both the released clang-9
and the current development version of clang-10.
I was hoping we would not need a workaround in clang-9+, but
it seems that we do.
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 78452cf0115d..39459cd8ddef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -961,6 +961,7 @@ static uint32_t sdma_v4_0_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
 	/* Set ring buffer size in dwords */
 	uint32_t rb_bufsz = order_base_2(ring->ring_size / 4);
 
+	barrier(); /* work around https://bugs.llvm.org/show_bug.cgi?id=42576 */
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-- 
2.20.0
