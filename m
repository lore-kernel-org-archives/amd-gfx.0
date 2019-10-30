From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] drm/amd/display: Add a conversion function for transmitter and phy_id enums
Date: Tue, 29 Oct 2019 23:04:11 -0700
Message-ID: <20191030060411.21168-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Roman Li <Roman.Li@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns:

../drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2520:42:
error: implicit conversion from enumeration type 'enum transmitter' to
different enumeration type 'enum physical_phy_id'
[-Werror,-Wenum-conversion]
        psr_context->smuPhyId = link->link_enc->transmitter;
                              ~ ~~~~~~~~~~~~~~~~^~~~~~~~~~~
1 error generated.

As the comment above this assignment states, this is intentional. To
match previous warnings of this nature, add a conversion function that
explicitly converts between the enums and warns when there is a
mismatch.

See commit 828cfa29093f ("drm/amdgpu: Fix amdgpu ras to ta enums
conversion") and commit d9ec5cfd5a2e ("drm/amd/display: Use switch table
for dc_to_smu_clock_type") for previous examples of this.

Fixes: e0d08a40a63b ("drm/amd/display: Add debugfs entry for reading psr state")
Link: https://github.com/ClangBuiltLinux/linux/issues/758
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7b18087be585..38dfe460e13b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2447,6 +2447,41 @@ bool dc_link_get_psr_state(const struct dc_link *link, uint32_t *psr_state)
 	return true;
 }
 
+static inline enum physical_phy_id
+transmitter_to_phy_id(enum transmitter transmitter_value)
+{
+	switch (transmitter_value) {
+	case TRANSMITTER_UNIPHY_A:
+		return PHYLD_0;
+	case TRANSMITTER_UNIPHY_B:
+		return PHYLD_1;
+	case TRANSMITTER_UNIPHY_C:
+		return PHYLD_2;
+	case TRANSMITTER_UNIPHY_D:
+		return PHYLD_3;
+	case TRANSMITTER_UNIPHY_E:
+		return PHYLD_4;
+	case TRANSMITTER_UNIPHY_F:
+		return PHYLD_5;
+	case TRANSMITTER_NUTMEG_CRT:
+		return PHYLD_6;
+	case TRANSMITTER_TRAVIS_CRT:
+		return PHYLD_7;
+	case TRANSMITTER_TRAVIS_LCD:
+		return PHYLD_8;
+	case TRANSMITTER_UNIPHY_G:
+		return PHYLD_9;
+	case TRANSMITTER_COUNT:
+		return PHYLD_COUNT;
+	case TRANSMITTER_UNKNOWN:
+		return PHYLD_UNKNOWN;
+	default:
+		WARN_ONCE(1, "Unknown transmitter value %d\n",
+			  transmitter_value);
+		return PHYLD_0;
+	}
+}
+
 bool dc_link_setup_psr(struct dc_link *link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context)
@@ -2517,7 +2552,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 	/* Hardcoded for now.  Can be Pcie or Uniphy (or Unknown)*/
 	psr_context->phyType = PHY_TYPE_UNIPHY;
 	/*PhyId is associated with the transmitter id*/
-	psr_context->smuPhyId = link->link_enc->transmitter;
+	psr_context->smuPhyId =
+		transmitter_to_phy_id(link->link_enc->transmitter);
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
 	psr_context->vsyncRateHz = div64_u64(div64_u64((stream->
-- 
2.24.0.rc1
