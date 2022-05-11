Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A6CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 18:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC9A112849;
	Wed, 11 May 2022 18:20:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C7F112849
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652293198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjmqosTJ6Gizg8804eI7hEvoeZHHnweNRCj5+1JAafk=;
 b=cFzlg0r0zjjcWRWC/zmg/4bJYQ048GD4g+pL6XPhshfyoM01hmVbxf6JCdZIpPt3iVE8ZZ
 CKygWHHpeaUgFB+MJvE17950NhX39n/aPaBcEdBLXMGkbzCjDrb16bmuTU0RKpndJ9qtT1
 aZrC0VuztlajdhsBdlJNAio6FBzupGI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-EUlxPZ5CMFK0edoaKGsZPQ-1; Wed, 11 May 2022 14:19:52 -0400
X-MC-Unique: EUlxPZ5CMFK0edoaKGsZPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B16AA85A5A8;
 Wed, 11 May 2022 18:19:51 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.33.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1084F400E43D;
 Wed, 11 May 2022 18:19:51 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add 'modeset' module parameter
Date: Wed, 11 May 2022 14:19:33 -0400
Message-Id: <20220511181935.810735-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Many DRM drivers feature a 'modeset' argument, which can be used to
enable/disable the entire driver (as opposed to passing nomodeset to the
kernel, which would disable modesetting globally and make it difficult to
load amdgpu afterwards). Apparently amdgpu is actually missing this
however, so let's add it!

Keep in mind that this currently just lets one enable or disable amdgpu, I
haven't bothered adding a headless mode like nouveau has - however I'm sure
someone else can add this if needed.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ebd37fb19cdb..24e6fb4517cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -872,6 +872,15 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: modeset (int)
+ * Used to enable/disable modesetting for amdgpu exclusively.
+ */
+bool amdgpu_enable_modeset = true;
+MODULE_PARM_DESC(modeset,
+		 "Enable or disable display driver (1 = on (default), 0 = off");
+module_param_named(modeset, amdgpu_enable_modeset, bool, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
@@ -2003,6 +2012,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	bool is_fw_fb;
 	resource_size_t base, size;
 
+	if (!amdgpu_enable_modeset) {
+		DRM_INFO("modeset=0 passed to amdgpu, driver will not be enabled\n");
+		return -ENODEV;
+	}
+
 	/* skip devices which are owned by radeon */
 	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
 		if (amdgpu_unsupported_pciidlist[i] == pdev->device)
-- 
2.35.1

