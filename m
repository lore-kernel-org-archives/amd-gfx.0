Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BDEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879D410E419;
	Wed, 11 May 2022 12:02:56 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE7A10E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:02:55 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id d6so2268076ede.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6jNa2RbPvp1Yve7ebsL+ja7cHSI6852gGTLCSPghKIY=;
 b=MwcXdCi9jgLmXNpFri76ZmprV7vbbloSNzjJMZR6GYRxHYt8Txn0o0OOnkb728McDC
 JNa/80Z8IrmJNb5/InFTPl1O/J0cX/fE5VXhEt+6GTglYEGdaDQtvJI88KTvpks2uItv
 j/Nqo4FWx870WSychldFm64VgZGF9MiwTcLYgkhnImUBlbRc5bi2nLNCy0rEKTWzCbRz
 DGDbIu3BFCXqj+K5tm64NOa4AMC2rxwdUznHvXHN+PdpBDIqvTezi32+Nf6u3fFP2TE9
 v1bGzyXROFddQmQMGz230UhW3uWPTZ7CekclFslDnt7veOCeuLu5DcUZbUWuG12EIauq
 BXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6jNa2RbPvp1Yve7ebsL+ja7cHSI6852gGTLCSPghKIY=;
 b=3+Oy7JFPZxAyimcVZyymKL8GyVMDLMYyEOp6GZ8SUSZiRC7/edN2hZdkHrHsD6bSdM
 2k50PyvhG2ZWQDybbKBfzz8VgnfBn98qzoHrQp9pmktcDVioBbX3c0+/H7a4NbMVrpwy
 FxH57D0VQ6vllE6ae6XI11YodxxDkvbTSeO3S3kIpm0ZIW1bF0CcnbUtnSzhcppgbyOY
 JbXEhsHXNrWC5xri8miOdbR9S+2wJsy2JMg1ASB4Z/ZZKaMUgF0CKCKnqLkLHF9GONo2
 a7upuoKWPqj7lg0YZrm11AScVugY1UyoIOlcEJI1W0lTVGHyEqodUIMfLq/g2dtQxYQp
 GM6w==
X-Gm-Message-State: AOAM5338ugSCaBxvOpj2d7qQ3BlUvrepwVVzpgB2+yJGGimI9m5mI0kr
 GuDrOdK7NV2z5AGF0/eeg1TRK+SCBsE=
X-Google-Smtp-Source: ABdhPJy7akiwWZbxH+OC8jmK5ZHUNog5oMsnYm60oXkYlfLQ/rtf5xdYtI+UglqSpErfCYD2H9sO/w==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id
 y13-20020a056402440d00b004129e8a5e51mr28662639eda.362.1652270573947; 
 Wed, 11 May 2022 05:02:53 -0700 (PDT)
Received: from able.fritz.box (p57b0be56.dip0.t-ipconnect.de. [87.176.190.86])
 by smtp.gmail.com with ESMTPSA id
 i3-20020aa7c703000000b0042617ba638esm1132424edq.24.2022.05.11.05.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 05:02:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add drm-client-id to fdinfo
Date: Wed, 11 May 2022 14:02:50 +0200
Message-Id: <20220511120250.3066-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511120250.3066-1-christian.koenig@amd.com>
References: <20220511120250.3066-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, daniel@ffwll.ch,
 Shashank.Sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is enough to get gputop working :)

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 52c2b90925a0..780a48259682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -55,17 +55,15 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 
 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct amdgpu_fpriv *fpriv;
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+	struct amdgpu_fpriv *fpriv = file->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	uint32_t bus, dev, fn, domain, hw_ip;
 	struct amdgpu_bo *root;
 	int ret;
 
-	ret = amdgpu_file_to_fpriv(f, &fpriv);
-	if (ret)
-		return;
 	bus = adev->pdev->bus->number;
 	domain = pci_domain_nr(adev->pdev->bus);
 	dev = PCI_SLOT(adev->pdev->devfn);
@@ -93,6 +91,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
 	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
 			dev, fn, fpriv->vm.pasid);
+	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
 	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
 	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
 	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
-- 
2.25.1

