Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C588C19425
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 16:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8A7229C9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 16:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8A7229C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5D96E1A7;
	Fri,  4 Dec 2020 16:51:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6DF6E19C;
 Fri,  4 Dec 2020 16:51:33 +0000 (UTC)
From: Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 John Clements <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: fw_attestation: fix unused function warning
Date: Fri,  4 Dec 2020 17:51:20 +0100
Message-Id: <20201204165128.3747878-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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
Cc: dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>,
 amd-gfx@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Without debugfs, the compiler notices one function that is not used at
all:

drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c:123:12: error: unused function 'amdgpu_is_fw_attestation_supported' [-Werror,-Wunused-function]

In fact the static const amdgpu_fw_attestation_debugfs_ops structure is
also unused here, but that warning is currently disabled.

Removing the #ifdef check does the right thing and leads to all of this
code to be dropped without warning.

Fixes: 19ae333001b3 ("drm/amdgpu: added support for psp fw attestation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index e47bca1c7635..7c6e02e35573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -130,7 +130,6 @@ static int amdgpu_is_fw_attestation_supported(struct amdgpu_device *adev)
 
 void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
 	if (!amdgpu_is_fw_attestation_supported(adev))
 		return;
 
@@ -139,5 +138,4 @@ void amdgpu_fw_attestation_debugfs_init(struct amdgpu_device *adev)
 			    adev_to_drm(adev)->primary->debugfs_root,
 			    adev,
 			    &amdgpu_fw_attestation_debugfs_ops);
-#endif
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
