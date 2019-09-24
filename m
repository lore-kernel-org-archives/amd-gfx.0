From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 22/28] drm/amdgpu/si: fix ASIC tests
Date: Tue, 24 Sep 2019 12:50:25 -0400
Message-ID: <20190924165031.28292-22-sashal@kernel.org>
References: <20190924165031.28292-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190924165031.28292-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Ken Wang <Qingqing.Wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit 77efe48a729588527afb4d5811b9e0acb29f5e51 ]

Comparing adev->family with CHIP constants is not correct.
adev->family can only be compared with AMDGPU_FAMILY constants and
adev->asic_type is the struct member to compare with CHIP constants.
They are separate identification spaces.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 62a37553414a ("drm/amdgpu: add si implementation v10")
Cc: Ken Wang <Qingqing.Wang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 40520a968eaca..28eea8317e87d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1783,7 +1783,7 @@ static void si_program_aspm(struct amdgpu_device *adev)
 			if (orig != data)
 				si_pif_phy1_wreg(adev,PB1_PIF_PWRDOWN_1, data);
 
-			if ((adev->family != CHIP_OLAND) && (adev->family != CHIP_HAINAN)) {
+			if ((adev->asic_type != CHIP_OLAND) && (adev->asic_type != CHIP_HAINAN)) {
 				orig = data = si_pif_phy0_rreg(adev,PB0_PIF_PWRDOWN_0);
 				data &= ~PLL_RAMP_UP_TIME_0_MASK;
 				if (orig != data)
@@ -1832,14 +1832,14 @@ static void si_program_aspm(struct amdgpu_device *adev)
 
 			orig = data = si_pif_phy0_rreg(adev,PB0_PIF_CNTL);
 			data &= ~LS2_EXIT_TIME_MASK;
-			if ((adev->family == CHIP_OLAND) || (adev->family == CHIP_HAINAN))
+			if ((adev->asic_type == CHIP_OLAND) || (adev->asic_type == CHIP_HAINAN))
 				data |= LS2_EXIT_TIME(5);
 			if (orig != data)
 				si_pif_phy0_wreg(adev,PB0_PIF_CNTL, data);
 
 			orig = data = si_pif_phy1_rreg(adev,PB1_PIF_CNTL);
 			data &= ~LS2_EXIT_TIME_MASK;
-			if ((adev->family == CHIP_OLAND) || (adev->family == CHIP_HAINAN))
+			if ((adev->asic_type == CHIP_OLAND) || (adev->asic_type == CHIP_HAINAN))
 				data |= LS2_EXIT_TIME(5);
 			if (orig != data)
 				si_pif_phy1_wreg(adev,PB1_PIF_CNTL, data);
-- 
2.20.1
