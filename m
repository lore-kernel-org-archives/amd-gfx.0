Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C39C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 07:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F54F2053B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 07:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNn9BBjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F54F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D056E5CD;
	Tue,  7 Jul 2020 07:30:40 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8586E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 03:26:06 +0000 (UTC)
Received: by mail-pg1-x544.google.com with SMTP id d4so19340574pgk.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2020 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1ztvsts5VwE1z8YxxL+FeVzRK9PehdQgNMSDXo4dCN8=;
 b=oNn9BBjNnf6LAvFU3e5vDAmyrG1em/k7tt4q/kPz/w52H5eeNTuxKTAMhTGGh49XOr
 +BsFMXoWzFB+HjCfKP8ugJ1oVs1ynFhi8aiS+zHbTemsTU+zi0hBk/629xrbfGS+UpHN
 xEiOhXM8FxB+6+C03AaJzmiBWszJLEXGH7fIaO5AJQVkIHT4DfGLzcDi+8FAuO7HY6+U
 CVYKvDlYhWa3GzRhgpiPSztVfH/KTHBE+Y8JpSSxDiSAsVW8LAlshxwjA9NjRC5DxX0J
 6J5Zwm0V8D1MSw6y1zIo6VjUFiWInobB0PipGA4nqG8qBl7O7MIL77P9CjGQYBWl7ykK
 Gv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1ztvsts5VwE1z8YxxL+FeVzRK9PehdQgNMSDXo4dCN8=;
 b=nyE3tGZf5d6I7QW+/sGciitZ/vj8imJYVYO8nPiVYdHNjjZ5OYY0q6hGugNqX+2Ilb
 brGT8vC5wcdGayZrFboZRcBM7i1CqVdNJC+vZ/Ze7K3o40vdXWDbMNHpSRFUqjhExsMJ
 OZQhKmJ/xV1OoshdJxHHsXHwXBdhnl/jwwCBp39eKOh5qqn/u+XDkyAQIStGmQkMJ2iu
 4EppmIP7NyYmQTTGM8Gl9Eb2jKNXzYUN0D2ECufD2qSdQXZRAoHta5xY56oqWtSwdZvv
 C3NUELD4BfzU5zTZvk1+8MbmPz/tA0wh3OStPp1qKsRqwmRzF4nvEX5wnclt4fcxw+86
 VeOQ==
X-Gm-Message-State: AOAM531hLMzLQ0TIpvsVDeqxdg3Z3rMxujGVHs8E4IraPyjYhTSuLbIF
 7pS2wI8AzcN4eiTI+C3UOMU=
X-Google-Smtp-Source: ABdhPJwFpgr9iqxmJOIDTj2Z5znxyjgLd8Mbbxlnhw46ZKUQiBciMG0ye81ny/4tNXuMmtTegdKnug==
X-Received: by 2002:a65:594b:: with SMTP id g11mr45083402pgu.168.1594092366036; 
 Mon, 06 Jul 2020 20:26:06 -0700 (PDT)
Received: from paxos.mtv.corp.google.com
 ([2620:15c:202:201:4a0f:cfff:fe5d:61cb])
 by smtp.gmail.com with ESMTPSA id 129sm20950471pfv.161.2020.07.06.20.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 20:26:05 -0700 (PDT)
From: Lepton Wu <ytht.net@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix null pointer reference to adev.
Date: Mon,  6 Jul 2020 20:26:03 -0700
Message-Id: <20200707032603.2525411-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 07 Jul 2020 07:30:38 +0000
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Lepton Wu <ytht.net@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I hit this when compiling amdgpu in kernel. amdgpu_driver_load_kms fail
to load firmwares since GPU was initialized before rootfs is ready.
Just gracefully fail in such cases.

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 126e74758a34..f9d277f8ddd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1124,7 +1124,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		goto err_pci;
 
 	adev = dev->dev_private;
-	ret = amdgpu_debugfs_init(adev);
+	if (adev)
+		ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7e17e34fee1..99a6ec49ead5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -978,6 +978,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	struct amdgpu_fpriv *fpriv;
 	int r, pasid;
 
+	if (!adev)
+		return -ENODEV;
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
 
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
