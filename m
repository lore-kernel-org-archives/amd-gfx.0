From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/radeon: remove set but not used variable 'vbi_time_out'
Date: Mon, 18 Feb 2019 08:45:14 +0000
Message-ID: <20190218084514.194011-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/si_dpm.c: In function 'si_program_response_times':
drivers/gpu/drm/radeon/si_dpm.c:3640:29: warning:
 variable 'backbias_response_time' set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/si_dpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 0a785ef0ab66..de8bd245497f 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3637,14 +3637,13 @@ static int si_notify_smc_display_change(struct radeon_device *rdev,
 
 static void si_program_response_times(struct radeon_device *rdev)
 {
-	u32 voltage_response_time, backbias_response_time, acpi_delay_time, vbi_time_out;
+	u32 voltage_response_time, acpi_delay_time, vbi_time_out;
 	u32 vddc_dly, acpi_dly, vbi_dly;
 	u32 reference_clock;
 
 	si_write_smc_soft_register(rdev, SI_SMC_SOFT_REGISTER_mvdd_chg_time, 1);
 
 	voltage_response_time = (u32)rdev->pm.dpm.voltage_response_time;
-	backbias_response_time = (u32)rdev->pm.dpm.backbias_response_time;
 
 	if (voltage_response_time == 0)
 		voltage_response_time = 1000;
