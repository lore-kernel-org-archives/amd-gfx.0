Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284FEC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 13:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10AB6196C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 13:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10AB6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D130A6EA99;
	Wed, 31 Mar 2021 13:36:03 +0000 (UTC)
Received: from mail-m121143.qiye.163.com (mail-m121143.qiye.163.com
 [115.236.121.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E2A6EA97
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 13:21:11 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [36.152.145.181])
 by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 251AD5402E5;
 Wed, 31 Mar 2021 21:11:52 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Luben Tuikov <luben.tuikov@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Deepak R Varma <mh12gx2825@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amd/amdgpu: code refactoring to clean code style a bit
Date: Wed, 31 Mar 2021 06:11:36 -0700
Message-Id: <20210331131143.60652-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZT05MHxgaGEgYTE8ZVkpNSkxKQk1ISklOTU1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Nxw6SD8IPDUyTigMNBcK
 M1ZPCR1VSlVKTUpMSkJNSEpJQ05NVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
 TklVSk9OVUpDSllXWQgBWUFNSUxONwY+
X-HM-Tid: 0a78886967bfb038kuuu251ad5402e5
X-Mailman-Approved-At: Wed, 31 Mar 2021 13:36:02 +0000
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
Cc: opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix checkpatch.pl warning:
Too many leading tabs - consider code refactoring
WARNING: Too many leading tabs - consider code refactoring
+                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {

WARNING: Too many leading tabs - consider code refactoring
+                                                       if (vbios_voltage_id <= leakage_bin[j]) {

WARNING: Too many leading tabs - consider code refactoring
+                                               for (j = 0; j < profile->ucLeakageBinNum; j++) {

WARNING: Too many leading tabs - consider code refactoring
+                                                       if (vbios_voltage_id <= leakage_bin[j]) {

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 84 ++++++++------------
 1 file changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 86add0f4ea4d..9968ff8ddc9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1283,65 +1283,51 @@ int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_devic
 	profile = (ATOM_ASIC_PROFILING_INFO_V2_1 *)
 		(adev->mode_info.atom_context->bios + data_offset);
 
-	switch (frev) {
-	case 1:
+	if ((frev != 2) || (crev != 1)) {
+		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
 		return -EINVAL;
-	case 2:
-		switch (crev) {
-		case 1:
-			if (size < sizeof(ATOM_ASIC_PROFILING_INFO_V2_1))
-				return -EINVAL;
-			leakage_bin = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usLeakageBinArrayOffset));
-			vddc_id_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDC_IdArrayOffset));
-			vddc_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDC_LevelArrayOffset));
-			vddci_id_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDCI_IdArrayOffset));
-			vddci_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDCI_LevelArrayOffset));
-
-			if (profile->ucElbVDDC_Num > 0) {
-				for (i = 0; i < profile->ucElbVDDC_Num; i++) {
-					if (vddc_id_buf[i] == virtual_voltage_id) {
-						for (j = 0; j < profile->ucLeakageBinNum; j++) {
-							if (vbios_voltage_id <= leakage_bin[j]) {
-								*vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
-								break;
-							}
-						}
+	}
+
+	if (size < sizeof(ATOM_ASIC_PROFILING_INFO_V2_1))
+		return -EINVAL;
+
+	leakage_bin = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
+		 le16_to_cpu(profile->usLeakageBinArrayOffset));
+	vddc_id_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
+		 le16_to_cpu(profile->usElbVDDC_IdArrayOffset));
+	vddc_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
+		 le16_to_cpu(profile->usElbVDDC_LevelArrayOffset));
+	vddci_id_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
+		 le16_to_cpu(profile->usElbVDDCI_IdArrayOffset));
+	vddci_buf = (u16 *)(adev->mode_info.atom_context->bios + data_offset +
+		 le16_to_cpu(profile->usElbVDDCI_LevelArrayOffset));
+
+	if (profile->ucElbVDDC_Num > 0) {
+		for (i = 0; i < profile->ucElbVDDC_Num; i++) {
+			if (vddc_id_buf[i] == virtual_voltage_id) {
+				for (j = 0; j < profile->ucLeakageBinNum; j++) {
+					if (vbios_voltage_id <= leakage_bin[j]) {
+						*vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
 						break;
 					}
 				}
+				break;
 			}
-			if (profile->ucElbVDDCI_Num > 0) {
-				for (i = 0; i < profile->ucElbVDDCI_Num; i++) {
-					if (vddci_id_buf[i] == virtual_voltage_id) {
-						for (j = 0; j < profile->ucLeakageBinNum; j++) {
-							if (vbios_voltage_id <= leakage_bin[j]) {
-								*vddci = vddci_buf[j * profile->ucElbVDDCI_Num + i];
-								break;
-							}
-						}
+		}
+	}
+
+	if (profile->ucElbVDDCI_Num > 0) {
+		for (i = 0; i < profile->ucElbVDDCI_Num; i++) {
+			if (vddci_id_buf[i] == virtual_voltage_id) {
+				for (j = 0; j < profile->ucLeakageBinNum; j++) {
+					if (vbios_voltage_id <= leakage_bin[j]) {
+						*vddci = vddci_buf[j * profile->ucElbVDDCI_Num + i];
 						break;
 					}
 				}
+				break;
 			}
-			break;
-		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-			return -EINVAL;
 		}
-		break;
-	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-		return -EINVAL;
 	}
 
 	return 0;
-- 
2.31.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
