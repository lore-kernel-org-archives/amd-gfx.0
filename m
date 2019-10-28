From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 3/3] drm/amd/powerplay: Make two functions static
Date: Mon, 28 Oct 2019 21:36:21 +0800
Message-ID: <20191028133621.21400-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rex.zhu@amd.com, evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix sparse warnings:

drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2050:5:
 warning: symbol 'arcturus_i2c_eeprom_control_init' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2068:6:
 warning: symbol 'arcturus_i2c_eeprom_control_fini' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d48a49d..3099ac2 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2047,7 +2047,7 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
 	.functionality = arcturus_i2c_eeprom_i2c_func,
 };
 
-int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
+static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	int res;
@@ -2065,7 +2065,7 @@ int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 	return res;
 }
 
-void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
+static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
 	i2c_del_adapter(control);
 }
-- 
2.7.4
