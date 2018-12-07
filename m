From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/2] drm/amdkfd: add new vega10 pci ids
Date: Fri,  7 Dec 2018 16:26:09 -0500
Message-ID: <20181207212610.3680-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

New vega10 ids.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9ed14a11afa2..b78b3c2fa9d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -378,7 +378,13 @@ static const struct kfd_deviceid supported_devices[] = {
 	{ 0x6864, &vega10_device_info },	/* Vega10 */
 	{ 0x6867, &vega10_device_info },	/* Vega10 */
 	{ 0x6868, &vega10_device_info },	/* Vega10 */
+	{ 0x6869, &vega10_device_info },	/* Vega10 */
+	{ 0x686A, &vega10_device_info },	/* Vega10 */
+	{ 0x686B, &vega10_device_info },	/* Vega10 */
 	{ 0x686C, &vega10_vf_device_info },	/* Vega10  vf*/
+	{ 0x686D, &vega10_device_info },	/* Vega10 */
+	{ 0x686E, &vega10_device_info },	/* Vega10 */
+	{ 0x686F, &vega10_device_info },	/* Vega10 */
 	{ 0x687F, &vega10_device_info },	/* Vega10 */
 	{ 0x69A0, &vega12_device_info },	/* Vega12 */
 	{ 0x69A1, &vega12_device_info },	/* Vega12 */
-- 
2.13.6
