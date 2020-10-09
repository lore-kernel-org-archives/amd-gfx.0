Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40395C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 12:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0C222284
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 12:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0C222284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2E76ECD2;
	Fri,  9 Oct 2020 12:51:10 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C996EC4F
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 07:31:44 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AD11B2E4A2AE8A446E2F;
 Fri,  9 Oct 2020 15:31:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 15:31:32 +0800
From: Ye Bin <yebin10@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix invalid number of character '{' in
 amdgpu_acpi_init
Date: Fri, 9 Oct 2020 15:42:18 +0800
Message-ID: <20201009074218.144038-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 09 Oct 2020 12:51:09 +0000
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
Cc: Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix follow warning:
Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c...
[drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
of character '{' when these macros are defined: ''.
Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: CONFIG_ACPI...
[drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
of character '{' when these macros are defined: 'CONFIG_ACPI'.
......
Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: CONFIG_X86...
[drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
of character '{' when these macros are defined: 'CONFIG_X86'.
Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: _X86_...
[drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
of character '{' when these macros are defined: '_X86_'.
Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: __linux__...
[drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
of character '{' when these macros are defined: '__linux__'.

Fixes: 97d798b276e9 ("drm/amdgpu: simplify ATIF backlight handling")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4a93b880c6bf..165b02e267b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -806,8 +806,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	}
 	adev->atif = atif;
 
-	if (atif->notifications.brightness_change) {
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+	if (atif->notifications.brightness_change) {
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
-- 
2.16.2.dirty

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
