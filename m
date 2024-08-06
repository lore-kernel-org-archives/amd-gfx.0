Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9965DC52D6D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 08:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4866B10E31B;
	Tue,  6 Aug 2024 08:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Lnhluq5L";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5478A10E2E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722912203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Aq8ZYlDMSbmaa6KQhOh4EPglh61tK+x7a0+GyG0d/dw=;
 b=Lnhluq5LaB37xWfYPHJ0Z/HJfrJ1yuXyDjPqBZ2P2gnnfwB0t3BEc5la/iqRJKybPWO+Vk
 NH0QOAzZ0VoWRfEmTgQb7xv91ADpWr9NzvNY7v171Frl/KQ6pQ3mSsxAwluogOcaNahfQC
 +yOX16Gx/hK1CkfNhNvVftiN3Y3rWVw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-gmbvvrK6OICN4ZxuPbaZ1Q-1; Mon,
 05 Aug 2024 22:43:18 -0400
X-MC-Unique: gmbvvrK6OICN4ZxuPbaZ1Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA1161955D4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 02:43:17 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.68])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93B8A19560AE; Tue,  6 Aug 2024 02:43:16 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: amd-gfx@lists.freedesktop.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH] drm/amdgpu: fix the ioctl direction for
 DRM_IOCTL_AMDGPU_GEM_VA
Date: Tue,  6 Aug 2024 11:43:10 +0900
Message-ID: <20240806024310.3650332-1-yamato@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 06 Aug 2024 08:21:03 +0000
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

Though drmCommandWriteRead() is used in libdrm [1],
DRM_IOCTL_AMDGPU_GEM_VA uses DRM_IOW for encoding.

[1] https://gitlab.freedesktop.org/mesa/drm/-/blob/main/amdgpu/amdgpu_bo.c?ref_type=heads

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index efe5de6ce208..7325390798bc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -63,7 +63,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_INFO		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_INFO, struct drm_amdgpu_info)
 #define DRM_IOCTL_AMDGPU_GEM_METADATA	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_METADATA, struct drm_amdgpu_gem_metadata)
 #define DRM_IOCTL_AMDGPU_GEM_WAIT_IDLE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_WAIT_IDLE, union drm_amdgpu_gem_wait_idle)
-#define DRM_IOCTL_AMDGPU_GEM_VA		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_VA, struct drm_amdgpu_gem_va)
+#define DRM_IOCTL_AMDGPU_GEM_VA		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_VA, struct drm_amdgpu_gem_va)
 #define DRM_IOCTL_AMDGPU_WAIT_CS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_CS, union drm_amdgpu_wait_cs)
 #define DRM_IOCTL_AMDGPU_GEM_OP		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_OP, struct drm_amdgpu_gem_op)
 #define DRM_IOCTL_AMDGPU_GEM_USERPTR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, struct drm_amdgpu_gem_userptr)
-- 
2.45.2

