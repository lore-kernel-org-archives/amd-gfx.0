Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25769C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F066E245;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
X-Greylist: delayed 388 seconds by postgrey-1.36 at gabe;
 Wed, 08 Dec 2021 01:32:47 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AC46E162
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zz43ykszF4nF;
 Tue,  7 Dec 2021 17:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926800; bh=I4TADIXMS6p8efwfev/Snrdk/8IiCPk1I9e86leAy3k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f78ridXOEXmSWzetoQK1mab7i2AdowIFBwbVkB6S1FB4ouZ5iwgiZ4ht0l93QxjwV
 mlDLamliXX9W3IPIvBs0vaoc8rOH31ocVM+eTIH8CxTnUqAsSccwJlwrn9TSHQSlOJ
 zUUcIe6R1mnQGdcjhiui7Wby2SPXbRsMneX88KTA=
X-Riseup-User-ID: CC45DAB5A54C03B51B64492B35D69AF5B32AF8B7A2E5B9E64AD9DDF59D60974F
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zz21l0zz5vkY;
 Tue,  7 Dec 2021 17:26:38 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 08/10] drm/amdgpu: fix location of prototype for
 amdgpu_kms_compat_ioctl
Date: Tue,  7 Dec 2021 22:25:27 -0300
Message-Id: <20211208012529.372478-9-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-1-isabbasso@riseup.net>
References: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes the warning below by changing the prototype to a location
that's actually included by the .c files that call
amdgpu_kms_compat_ioctl:

 warning: no previous prototype for ‘amdgpu_kms_compat_ioctl’
 [-Wmissing-prototypes]
 37 | long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
    |      ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5cfe2926ca1..54c882a6b433 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1360,8 +1360,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
 int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
-long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd,
-			     unsigned long arg);
 int amdgpu_info_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *filp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
index e3a4f7048042..8178323e4bef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
@@ -45,4 +45,7 @@
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg);
 
+long amdgpu_kms_compat_ioctl(struct file *filp,
+			     unsigned int cmd, unsigned long arg);
+
 #endif
-- 
2.34.1

