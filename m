Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63574C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 16:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A79010FBFB;
	Tue, 10 May 2022 16:55:56 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAD410FBF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 16:55:55 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id bg25so10558764wmb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N5Z5NdxUCheK2XxyRKAeDds/RFkAcm4U6hcL6+dCixM=;
 b=Eljof8JWlrg5cmwVvdBlHTvDgnk2aW+PxLAs1duNOXWBuWK/jsQSUVY3Yo9FWDuFpm
 T3rfVebd+oygvW8aPSEUnICEwoutqy9QHPf2l7MWi54Jk9M1xNyfeJPuQy/TCnFq5shs
 +jAwyImlJp7sFHnVioYWj+S6f0/lRmig0JZdUIqCh/Rnx4c+cA6YtLuTArSRA9a592nt
 UgqFMDH77iapkeeVXC9m4cj97YANivo0JUibNETsTHFxISNPUSsmiC45dwbohjsn7tDb
 tz5JyvgCCEAp0Ucd+sv1u9FXq9MCS6mwjJuee0WixykhHmhTNrlzKkq/bP+KY/oXK4+v
 kSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N5Z5NdxUCheK2XxyRKAeDds/RFkAcm4U6hcL6+dCixM=;
 b=CDBNG9YatrFGKX3J1m9wngULzOtKKXzSFZ89Ug83ljhN3bRIECOZ9iU3VjHej3+bIY
 eulNzlXWDo32uC8kPoMlrKwt16wnZsOtK0TyDQDn8spiUaNYnHn8Gw23JN7gGMXLUjwI
 DfUx1+58vdUqudgEezd2WDcK1ec2m3LMyrEL2NUSsvpz+nGT7UNO27LW+VlmR/nUfUqy
 04xaLYGnDaKsL873QKL3wOSuHRLir9zOEcxtcjbWwwSLk0qCPrMuZDLS8nsKLatwCFzy
 jPrN7avFmcMySVnEXJJ63ZUj4uyFVhUX3XzK0A2khXbBDEycPIh4znONJlRpQBMSeBYd
 iObw==
X-Gm-Message-State: AOAM530vCLGCdBTCJf95mWbX36WpHbxeQUAaa3JrEfWt0hntJMQwYigT
 HYFn0nCXpUTaEEFqsD20/G/yDcy1ejY=
X-Google-Smtp-Source: ABdhPJygJb6Y1J7UF9Ye+YiY/9cHGw0RaT0p9kQrH9s4KXuLE5/w3oUE46+FGZU+n3IYE5I3IJVv4Q==
X-Received: by 2002:a05:600c:1e0f:b0:394:7759:64f3 with SMTP id
 ay15-20020a05600c1e0f00b00394775964f3mr901885wmb.19.1652201753817; 
 Tue, 10 May 2022 09:55:53 -0700 (PDT)
Received: from able.fritz.box (p57b0b3fd.dip0.t-ipconnect.de. [87.176.179.253])
 by smtp.gmail.com with ESMTPSA id
 c1-20020adfef41000000b0020cd54239c8sm2448250wrp.61.2022.05.10.09.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 09:55:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add drm-client-id to fdinfo
Date: Tue, 10 May 2022 18:55:50 +0200
Message-Id: <20220510165550.2048-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510165550.2048-1-christian.koenig@amd.com>
References: <20220510165550.2048-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is enough to get gputop working :)

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 38cb5eb105ad..4ef23224b617 100644
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

