From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu/mes10.1: fix duplicated assignment to adev->mes.ucode_fw_version
Date: Fri, 28 Jun 2019 16:05:39 +0100
Message-ID: <20190628150539.12195-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

Currently adev->mes.ucode_fw_version is being assigned twice with
different values. This looks like a cut-n-paste error and instead
the second assignment should be adev->mes.data_fw_version. Fix
this.

Addresses-Coverity: ("Unused value")
Fixes: 298d05460cc4 ("drm/amdgpu/mes10.1: load mes firmware file to CPU buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 29fab7984855..2a27f0b30bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -91,7 +91,7 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev)
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)adev->mes.fw->data;
 	adev->mes.ucode_fw_version = le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version =
+	adev->mes.data_fw_version =
 		le32_to_cpu(mes_hdr->mes_ucode_data_version);
 	adev->mes.uc_start_addr =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
-- 
2.20.1
