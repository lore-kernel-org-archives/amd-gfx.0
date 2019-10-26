From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 26/59] drm/amdgpu/powerplay: fix typo in mvdd table setup
Date: Sat, 26 Oct 2019 09:18:37 -0400
Message-ID: <20191026131910.3435-26-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Robert Strube <rstrube@gmail.com>, Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 598c30dbcc9434706f29a085a8eba4730573bcc2 ]

Polaris and vegam use count for the value rather than
level.  This looks like a copy paste typo from when
the code was adapted from previous asics.

I'm not sure that the SMU actually uses this value, so
I don't know that it actually is a bug per se.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=108609
Reported-by: Robert Strube <rstrube@gmail.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 0dbca38658514..576db0c6b52b7 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -654,7 +654,7 @@ static int polaris10_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
 			count = SMU_MAX_SMIO_LEVELS;
 		for (level = 0; level < count; level++) {
 			table->SmioTable2.Pattern[level].Voltage =
-				PP_HOST_TO_SMC_US(data->mvdd_voltage_table.entries[count].value * VOLTAGE_SCALE);
+				PP_HOST_TO_SMC_US(data->mvdd_voltage_table.entries[level].value * VOLTAGE_SCALE);
 			/* Index into DpmTable.Smio. Drive bits from Smio entry to get this voltage level.*/
 			table->SmioTable2.Pattern[level].Smio =
 				(uint8_t) level;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 59113fdd1c1c1..bc05e97b1bf19 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -457,7 +457,7 @@ static int vegam_populate_smc_mvdd_table(struct pp_hwmgr *hwmgr,
 			count = SMU_MAX_SMIO_LEVELS;
 		for (level = 0; level < count; level++) {
 			table->SmioTable2.Pattern[level].Voltage = PP_HOST_TO_SMC_US(
-					data->mvdd_voltage_table.entries[count].value * VOLTAGE_SCALE);
+					data->mvdd_voltage_table.entries[level].value * VOLTAGE_SCALE);
 			/* Index into DpmTable.Smio. Drive bits from Smio entry to get this voltage level.*/
 			table->SmioTable2.Pattern[level].Smio =
 				(uint8_t) level;
-- 
2.20.1
