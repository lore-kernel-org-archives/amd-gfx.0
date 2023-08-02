Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16635C04E69
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9BE10E5AC;
	Thu,  3 Aug 2023 07:25:05 +0000 (UTC)
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com
 [115.124.28.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B072B10E4EE;
 Wed,  2 Aug 2023 07:21:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1354293|-1;
 BR=01201311R561S88ruler371_34042_170602; CH=green; DM=|CONTINUE|false|;
 DS=SPAM|spam_lottery|0.83807-0.00132883-0.160601; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047202; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6bfrYW_1690960888; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6bfrYW_1690960888) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:21:29 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in soc21.c
Date: Wed,  2 Aug 2023 07:21:27 +0000
Message-Id: <20230802072127.12896-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e5e5d68a4d70..4f3ecd66eb6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -48,33 +48,28 @@
 static const struct amd_ip_funcs soc21_common_ip_funcs;
 
 /* SOC21 */
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn0[] =
-{
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn1[] =
-{
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn0 =
-{
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn0 = {
 	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array_vcn0),
 	.codec_array = vcn_4_0_0_video_codecs_encode_array_vcn0,
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn1 =
-{
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn1 = {
 	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_encode_array_vcn1),
 	.codec_array = vcn_4_0_0_video_codecs_encode_array_vcn1,
 };
 
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn0[] =
-{
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
@@ -82,22 +77,19 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn1[] =
-{
+static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn0 =
-{
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn0 = {
 	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array_vcn0),
 	.codec_array = vcn_4_0_0_video_codecs_decode_array_vcn0,
 };
 
-static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn1 =
-{
+static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn1 = {
 	.codec_count = ARRAY_SIZE(vcn_4_0_0_video_codecs_decode_array_vcn1),
 	.codec_array = vcn_4_0_0_video_codecs_decode_array_vcn1,
 };
@@ -445,8 +437,7 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
 		adev->nbio.funcs->program_aspm(adev);
 }
 
-const struct amdgpu_ip_block_version soc21_common_ip_block =
-{
+const struct amdgpu_ip_block_version soc21_common_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_COMMON,
 	.major = 1,
 	.minor = 0,
@@ -547,8 +538,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_asic_funcs soc21_asic_funcs =
-{
+static const struct amdgpu_asic_funcs soc21_asic_funcs = {
 	.read_disabled_bios = &soc21_read_disabled_bios,
 	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &soc21_read_register,
-- 
2.17.1

