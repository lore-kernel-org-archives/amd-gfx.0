Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A86C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 08:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D5720B80
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 08:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D5720B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158D86E422;
	Wed, 18 Nov 2020 08:02:46 +0000 (UTC)
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com
 [59.111.176.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436B66E0BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 03:43:16 +0000 (UTC)
Received: from ubuntu.localdomain (unknown [157.0.31.125])
 by m17618.mail.qiye.163.com (Hmail) with ESMTPA id D9ED74E1443;
 Wed, 18 Nov 2020 11:43:11 +0800 (CST)
From: Bernard Zhao <bernard@vivo.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Ye Bin <yebin10@huawei.com>, Evan Quan <evan.quan@amd.com>,
 Andriy Gapon <avg@FreeBSD.org>, Luben Tuikov <luben.tuikov@amd.com>,
 Bernard Zhao <bernard@vivo.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amd/amdgpu: optimise CONFIG_X||CONFIG_X_MODULE to
 IS_ENABLED(X)
Date: Tue, 17 Nov 2020 19:43:04 -0800
Message-Id: <20201118034306.103427-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZTRgZGhpKTkIZQ0NLVkpNS05NTEtCQklKTktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Ixw4AT8eLw9JIgovHksa
 ARhPCwFVSlVKTUtOTUxLQkJJTkJNVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
 S1VISlVKSU5ZV1kIAVlBSEhDTjcG
X-HM-Tid: 0a75d972f8d79376kuwsd9ed74e1443
X-Mailman-Approved-At: Wed, 18 Nov 2020 08:02:45 +0000
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
Cc: opensource.kernel@vivo.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimise CONFIG_<X> || CONFIG_<X>_MODULE to IS_ENABLED(<X>).
This change also fix check_patch.pl warning:
WARNING: Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> ||
CONFIG_<FOO>_MODULE
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined
(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 165b02e267b0..f1980cd1f402 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -64,7 +64,7 @@ struct amdgpu_atif {
 	struct amdgpu_atif_notifications notifications;
 	struct amdgpu_atif_functions functions;
 	struct amdgpu_atif_notification_cfg notification_cfg;
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	struct backlight_device *bd;
 #endif
 	struct amdgpu_dm_backlight_caps backlight_caps;
@@ -447,7 +447,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
 
 		if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 			if (atif->bd) {
 				DRM_DEBUG_DRIVER("Changing brightness to %d\n",
 						 req.backlight_level);
@@ -806,7 +806,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	}
 	adev->atif = atif;
 
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 	if (atif->notifications.brightness_change) {
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
