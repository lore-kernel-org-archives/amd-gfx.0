Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31206C04FDF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5BF10E4E1;
	Wed,  2 Aug 2023 07:20:11 +0000 (UTC)
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com
 [115.124.28.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3522210E4A3;
 Wed,  2 Aug 2023 06:51:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2889314|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00195208-5.61741e-05-0.997992;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047190; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6Zjv98_1690959088; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6Zjv98_1690959088) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:51:30 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu/atomfirmware: Clean up errors in
 amdgpu_atomfirmware.c
Date: Wed,  2 Aug 2023 06:51:27 +0000
Message-Id: <20230802065127.12183-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that '>=' (ctx:WxV)
ERROR: spaces required around that '!=' (ctx:WxV)
ERROR: code indent should use tabs where possible

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 0b7f4c4d58e5..835980e94b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -58,7 +58,7 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
 	if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
 				index, &size, &frev, &crev, &data_offset)) {
 		/* support firmware_info 3.1 + */
-		if ((frev == 3 && crev >=1) || (frev > 3)) {
+		if ((frev == 3 && crev >= 1) || (frev > 3)) {
 			firmware_info = (union firmware_info *)
 				(mode_info->atom_context->bios + data_offset);
 			fw_cap = le32_to_cpu(firmware_info->v31.firmware_capability);
@@ -597,7 +597,7 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev,
 					  index, &size, &frev, &crev,
 					  &data_offset)) {
 		/* support firmware_info 3.4 + */
-		if ((frev == 3 && crev >=4) || (frev > 3)) {
+		if ((frev == 3 && crev >= 4) || (frev > 3)) {
 			firmware_info = (union firmware_info *)
 				(mode_info->atom_context->bios + data_offset);
 			/* The ras_rom_i2c_slave_addr should ideally
@@ -850,7 +850,7 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev)
 
 	firmware_info = (union firmware_info *)(ctx->bios + data_offset);
 
-	if (frev !=3)
+	if (frev != 3)
 		return -EINVAL;
 
 	switch (crev) {
@@ -909,7 +909,7 @@ int amdgpu_atomfirmware_asic_init(struct amdgpu_device *adev, bool fb_reset)
 	}
 
 	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-                                            asic_init);
+					asic_init);
 	if (amdgpu_atom_parse_cmd_header(mode_info->atom_context, index, &frev, &crev)) {
 		if (frev == 2 && crev >= 1) {
 			memset(&asic_init_ps_v2_1, 0, sizeof(asic_init_ps_v2_1));
-- 
2.17.1

