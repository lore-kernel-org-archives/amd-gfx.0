From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 010/101] drm/amd/display: Fill prescale_params->scale for RGB565
Date: Fri, 19 Jul 2019 00:06:01 -0400
Message-ID: <20190719040732.17285-10-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Roman Li <Roman.Li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit 1352c779cb74d427f4150cbe779a2f7886f70cae ]

[Why]
An assertion is thrown when using SURFACE_PIXEL_FORMAT_GRPH_RGB565
formats on DCE since the prescale_params->scale wasn't being filled.

Found by a dmesg-fail when running the
igt@kms_plane@pixel-format-pipe-a-planes test on Baffin.

[How]
Fill in the scale parameter.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 53ccacf99eca..c3ad2bbec1a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -242,6 +242,9 @@ static void build_prescale_params(struct ipp_prescale_params *prescale_params,
 	prescale_params->mode = IPP_PRESCALE_MODE_FIXED_UNSIGNED;
 
 	switch (plane_state->format) {
+	case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
+		prescale_params->scale = 0x2082;
+		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
 		prescale_params->scale = 0x2020;
-- 
2.20.1
