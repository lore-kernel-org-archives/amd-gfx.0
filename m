Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FDDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 10:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971491131E5;
	Tue, 17 May 2022 10:36:55 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D941131D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:36:51 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id c10so662503edr.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N5B/h84+cqwYTAzKPfPGQz3MaVoisoY+YSHHxu5ia2c=;
 b=SQQEIOtVwSTm8+xx7fs0XTnDj5apK0Fdr84ojC1NwJ//XvxpPlS17GY1JKpazRzxpu
 yqKIoUSKX/3G83bzD7h0F3JjpG4H+jmsN3Q4oGXuzUXhvd5/9XvSFDJwywnvPmV4H+wG
 8iz4fFLT0sJv71rHr1gM58PcxG5Ms54p9v7zP3HO1IW5CSp+jLX4Pu0P0y6HxtxgnGQ/
 0AIbhl48DSvc+A8PW1TxzPh6TWoR16e/gTlTXJob8/Rp6qDEdfouXp+r94fRv3yZB0X0
 5t3+CF61S9K+LzodQbaw6L+emOhy7hU+mi6avC0+CZCjPkL+zrm9B+hufgL+bnFSElqG
 NY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N5B/h84+cqwYTAzKPfPGQz3MaVoisoY+YSHHxu5ia2c=;
 b=lgZj6s+4+yBnWaSxJo7Nwu/aPt2Exh4HIRP+q2tlDOIKgZkviJ3hSznhvsnqrTUeS8
 7OY7vMOgi4q/81eABFNHGl9hNvWltn00b8xPtDA7otu84EUE4NX71KwYjQ0HTuPjIetO
 iSQH29U4iA4IYQgrk+abHN2chIXtxxkX9r3JBfvfNXX6HFYiGI6WyEX+K++SOffb4NIk
 5lfUslnq3kThWXM64nem/+JjybNSheA89us/Gmb3Dz6JL6Sy6gDG4T7B1lC7mDKhDAYB
 cp8o5D9JiZ7A/0xJ7y+P4ivzPktOiqZrr9DKxI8g+LYi4uxJVSYcKF+cgp2a8JygD5MY
 3A7w==
X-Gm-Message-State: AOAM531x4C9AVPJnvysfqeg5MFO7dXg/YN5rCJFLCOaSRJQ4wQN7fOYI
 HEWcEyGegGymSzdlBE9Nkfk=
X-Google-Smtp-Source: ABdhPJy6k29zAGU/j3f83epO0rDH3v9wr/t74owGhtypiLRokOchiZRrKzkAKt3jgW5DPKZ3Q1df9Q==
X-Received: by 2002:a05:6402:2d6:b0:42a:bb5f:a7d2 with SMTP id
 b22-20020a05640202d600b0042abb5fa7d2mr6667236edx.96.1652783809966; 
 Tue, 17 May 2022 03:36:49 -0700 (PDT)
Received: from baker.fritz.box (p57b0bdaa.dip0.t-ipconnect.de.
 [87.176.189.170]) by smtp.gmail.com with ESMTPSA id
 ht7-20020a170907608700b006f3ef214e66sm870343ejc.204.2022.05.17.03.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 03:36:49 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	shashank.sharma@amd.com
Subject: [PATCH 2/2] drm/amdgpu: add drm-client-id to fdinfo v2
Date: Tue, 17 May 2022 12:36:46 +0200
Message-Id: <20220517103646.1553-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517103646.1553-1-christian.koenig@amd.com>
References: <20220517103646.1553-1-christian.koenig@amd.com>
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
Cc: tvrtko.ursulin@linux.intel.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is enough to get gputop working :)

v2: rebase and some addition cleanup

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 4d453845235c..99a7855ab1bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -58,11 +58,11 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
 
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	uint32_t bus, dev, fn, domain;
-	struct amdgpu_bo *root;
 	unsigned int hw_ip;
 	int ret;
 
@@ -71,14 +71,12 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	dev = PCI_SLOT(adev->pdev->devfn);
 	fn = PCI_FUNC(adev->pdev->devfn);
 
-	root = fpriv->vm.root.bo;
-	ret = amdgpu_bo_reserve(root, false);
-	if (ret) {
-		DRM_ERROR("Fail to reserve bo\n");
+	ret = amdgpu_bo_reserve(vm->root.bo, false);
+	if (ret)
 		return;
-	}
-	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
-	amdgpu_bo_unreserve(root);
+
+	amdgpu_vm_get_memory(vm, &vram_mem, &gtt_mem, &cpu_mem);
+	amdgpu_bo_unreserve(vm->root.bo);
 
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
@@ -91,6 +89,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
 	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
 	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
+	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
 	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
 	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
 	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
-- 
2.25.1

