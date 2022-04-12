Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20816C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 15:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7852C10E548;
	Tue, 12 Apr 2022 15:39:24 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B51310EA16
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 15:21:09 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id p189so12148803wmp.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Vs73aHyAmGEvpCioRI3iBUOW914um+My5SdypFp/cZw=;
 b=i6sVsTx7slmXjbeB3WRYDPa+2iJH7EsSfuofElc2rklvTjGwIjryej9zCt4Ep5Pw6F
 9hv9Di8ot5cFzFXu9c4vfRdsfZ9sVh5FhhIugfA/X3fpcHnzXKZGJVh1pTltOqpIFDqW
 WqR1stJnxSWOmJqzhYFtV4ZzNz0eEBFkdbt8E9EiQbbSpthsV7UhNKi0lA+A4dVpR6vU
 ziPxK1+LyLJI1yvge2kwpLYIkrKhhW0het9vHl4WSY+xDOZrKWqpYBFJXdWIBxiMrR1Y
 orl32gT62bkrnpKaw+Vv5rdEAUMJedEg639sO1TbGk0YLPRENCpjvyyuX0X0WxKe25st
 6wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Vs73aHyAmGEvpCioRI3iBUOW914um+My5SdypFp/cZw=;
 b=CersRzc3KKxSZbRtNwGqBYlSQiqKuPsKzoKIoKO2pQyHSg0JrqgUO2CAf4xLxJvqOX
 CTPoWTAH5XDs1bRQSrxj2QDPQCOpGMVpgNX2zj+fsOnWGXagIQ7+N4hHbyEedlX6HiYe
 AHB7HTTVJWLhrDIz9zD8IwcaRoYpN7UiK5wd6K7Nvealf1qqkD0gIZm/rSLYTBxpfyEr
 oh+M4FCBihElIRJLZC3wxXrXrq76Wom9orVHg8HXT9ph+tCBjPUgOLmInvQnstS+tNlP
 d2y6A4oiPOsj6b3zt5DYog+aiGe7Hfc1OmdOzVUd1vLysWj1g/nsscEOhX0+7JcbtBtJ
 VLvg==
X-Gm-Message-State: AOAM5335IBHpc+3HBkvXlbpv4IGEO5A55JHnmgNcbh2nAV10udWzc2IV
 XYemZMaVLwe0bQz1Uwb9EQnQBF62iPkn1A==
X-Google-Smtp-Source: ABdhPJxxahNWQ1No7pe0Pv0bxjkJb7c+vjvr0Tl71uomMjhpW9Xzi8N8CeTr8vY5QVn1ApIUpPEgzg==
X-Received: by 2002:a05:600c:1d26:b0:38e:ae44:9ec with SMTP id
 l38-20020a05600c1d2600b0038eae4409ecmr4468981wms.87.1649776868084; 
 Tue, 12 Apr 2022 08:21:08 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net
 (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c024700b0038ec0c4a2e7sm2549832wmj.11.2022.04.12.08.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 08:21:07 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 5.10 1/1] drm/amdgpu: Ensure the AMDGPU file descriptor is
 legitimate
Date: Tue, 12 Apr 2022 16:20:57 +0100
Message-Id: <20220412152057.1170235-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Apr 2022 15:39:23 +0000
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
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[ Upstream commit b40a6ab2cf9213923bf8e821ce7fa7f6a0a26990 ]

This is a partial cherry-pick of the above upstream commit.

It ensures the file descriptor passed in by userspace is a valid one.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 26f8a21383774..1b4c7ced8b92c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1024,11 +1024,15 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 					   struct dma_fence **ef)
 {
 	struct amdgpu_device *adev = get_amdgpu_device(kgd);
-	struct drm_file *drm_priv = filp->private_data;
-	struct amdgpu_fpriv *drv_priv = drm_priv->driver_priv;
-	struct amdgpu_vm *avm = &drv_priv->vm;
+	struct amdgpu_fpriv *drv_priv;
+	struct amdgpu_vm *avm;
 	int ret;
 
+	ret = amdgpu_file_to_fpriv(filp, &drv_priv);
+	if (ret)
+		return ret;
+	avm = &drv_priv->vm;
+
 	/* Already a compute VM? */
 	if (avm->process_info)
 		return -EINVAL;
-- 
2.35.1.1178.g4f1659d476-goog

