Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A0DC369A5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 07:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D42810E5EC;
	Tue,  8 Apr 2025 07:22:34 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D3B10E1EF;
 Tue,  8 Apr 2025 02:20:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [124.16.141.245])
 by APP-05 (Coremail) with SMTP id zQCowAA3dQ30h_RnricPBw--.24673S2;
 Tue, 08 Apr 2025 10:20:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: hamza.mahfooz@amd.com, chiahsuan.chung@amd.com, sunil.khatri@amd.com,
 alex.hung@amd.com, aurabindo.pillai@amd.com, hersenxs.wu@amd.com,
 mario.limonciello@amd.com, mwen@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] drm/amd/display: Add error check for avi and vendor
 infoframe setup function
Date: Tue,  8 Apr 2025 10:20:18 +0800
Message-ID: <20250408022018.2786-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3dQ30h_RnricPBw--.24673S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4UAr47KFyUJw47ZF4rAFb_yoW8uF1Dpw
 48ta4DtrWvqFZxCryUAFn5ua90k3s7JFy7Kr45Aw15W3s5KrZ3Ja1fJF1kJ39rZFZ5A3Wa
 y3WUX3y7XF1vk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
 628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
 WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgGA2f0eChG3AAAsY
X-Mailman-Approved-At: Tue, 08 Apr 2025 07:22:33 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function fill_stream_properties_from_drm_display_mode() calls the
function drm_hdmi_avi_infoframe_from_display_mode() and the
function drm_hdmi_vendor_infoframe_from_display_mode(), but does
not check its return value. Log the error messages to prevent silent
failure if either function fails.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Fix code diff error

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5f216d626cbb..8fc6ba12c82d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6104,6 +6104,7 @@ static void fill_stream_properties_from_drm_display_mode(
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct hdmi_vendor_infoframe hv_frame;
 	struct hdmi_avi_infoframe avi_frame;
+	ssize_t err;
 
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
 		aconnector = to_amdgpu_dm_connector(connector);
@@ -6150,9 +6151,17 @@ static void fill_stream_properties_from_drm_display_mode(
 	}
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A) {
-		drm_hdmi_avi_infoframe_from_display_mode(&avi_frame, (struct drm_connector *)connector, mode_in);
+		err = drm_hdmi_avi_infoframe_from_display_mode(&avi_frame,
+							       (struct drm_connector *)connector,
+							       mode_in);
+		if (err < 0)
+			dev_err(connector->dev, "Failed to setup avi infoframe: %zd\n", err);
 		timing_out->vic = avi_frame.video_code;
-		drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame, (struct drm_connector *)connector, mode_in);
+		err = drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
+								  (struct drm_connector *)connector,
+								  mode_in);
+		if (err < 0)
+			dev_err(connector->dev, "Failed to setup vendor infoframe: %zd\n", err);
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-- 
2.42.0.windows.2

