Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F2DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 15:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067F010E59F;
	Tue, 12 Apr 2022 15:39:25 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D160A10E13C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 15:35:35 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id w4so28220833wrg.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VwOMhba2UBHTBdEcSB8ubF3LHDfdwxShkl2jYJGZwac=;
 b=eOj/bw3wwAIvAAhbgxLLgJ4/I/SsQUTJzUpBZOu+lHI3PxiIDDh2QD0J+zLXJCjmkl
 ZYVz8u1gr1RshZumc1gkjPhBfi8L8H44zTnz91eV+IKEmbeYoYd1J5Runw81S3Xkp1LT
 fVb3+gqTsYC0g8fISFaLA6JkzfMfHKgAjVzhslR45IHvlQqFJ1tNe0MfLrAz1WXCmKeL
 kRPWw7XItDToIH5q/ALTcgDZBB3OcBTOBsWzW8UH/OPkZDCFOHwzRXFCVdhKTF3gtAdD
 xPRrAhzsmvFg1njgPt0rHrXJhi5qgcpFWiE1YO4I+yEev17rMyhp9DQS+ezm1CdsCGKi
 BEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VwOMhba2UBHTBdEcSB8ubF3LHDfdwxShkl2jYJGZwac=;
 b=uPsq/w5P9dn1fSQAZaBtHFKNz3BwL4gQbgNMAqd0BS6PuA8ZFVg19bKfJVcB53iGC5
 kwlbYAkgP06oWbep3pnRkoKP+wLwVhm5A1Z00iFg2QMe3mjEQxxRzkdFbN7OyuyQkg8v
 n/Ia+/Bllcep9E5BwNtKBP1/SQfZM3BHzb5rKdHvbDrgoyOlcxJHU8u3dE2GgedpldIN
 a9J9OPxZMGpwUx/n2nXIhezZUBzmLLNWY9pR34iQpMoFrAWOTvDzb2nKyPTUe5sEumsR
 fCsiMtVrTa2cF3rcKBhqq6kcb6X6w9i6E5GiVRDo5QSDQ2Fpq2NgiFdcoVtYhaWGwP8m
 ptjA==
X-Gm-Message-State: AOAM532iCJZ4ueqGNspcjp0kLf8MLeoOCba1+X43KAMcho7nlNFTksv/
 mtjBhufHp23dSo1GadPI/G8inA==
X-Google-Smtp-Source: ABdhPJzN2nIUAo8GyjwEfVrI6mSlaVgYt6CfZqC6FHc0/mqgZ//dokwgr/pWS9EpJGKuhyNrsXy7rg==
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id
 d17-20020a5d6dd1000000b0020792c4eaefmr18208780wrz.498.1649777734319; 
 Tue, 12 Apr 2022 08:35:34 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net
 (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
 by smtp.gmail.com with ESMTPSA id
 p3-20020adfaa03000000b00207a1db96cfsm8463621wrd.71.2022.04.12.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 08:35:33 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 4.19 2/2] drm/amdgpu: Ensure the AMDGPU file descriptor is
 legitimate
Date: Tue, 12 Apr 2022 16:35:29 +0100
Message-Id: <20220412153529.1173412-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220412153529.1173412-1-lee.jones@linaro.org>
References: <20220412153529.1173412-1-lee.jones@linaro.org>
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
index f92597c292fe5..4488aad64643b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1044,11 +1044,15 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
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

