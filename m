Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2022DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 08:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC14010E913;
	Thu, 24 Mar 2022 08:13:43 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9754B10E913
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 08:13:42 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 l9-20020a05600c4f0900b0038ccd1b8642so787897wmq.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=woWMP2T5z3W7iyZ+/iWG24emdk7ZHuB6nCOoWEYWiSg=;
 b=kSFZ1Zj5i3M/e9nhlTBbS8OdD1JNJ9z0Um7Af8yphlGEmEgrDvNxBzDxqAwsAQRk2C
 1zgySD7CEbAN19emdTtrGbeifHniooKirBaeNLTsSePsayBONRNTCkK2gqxTtqKRLZjj
 u5QoBgUcCgePE7JBDVQ+omnTLYRyuni7Ev0rblT3fy+Y+zTxKgacasOCO43SrSvWcVBq
 dgXT4jT+9sbV2i2zRJoz+QGU1Oe5gwPNUz3fC+QullKkAw2qVtvD4Z+ZQ3IaH82CqQJZ
 lmRRlErU7GXccRU44zxDrxQQM+fbu7dqxfgMyUsUoZ2heZMz1O1H3RGq+kLcE2X+W2eh
 c/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=woWMP2T5z3W7iyZ+/iWG24emdk7ZHuB6nCOoWEYWiSg=;
 b=r6OgAl5WTwGeHxsdR9FBwhQJwkONhQX6W8KIhIp4i4G8/Mq45PTdiqIR8jQL1MWdM4
 +5ryi+PqNW91nML3MVtf6KXtuCbeW3LSwtfoJUceaXPH7MtLAFx25mYDiErYGyNl7Mn2
 zsrK79VHJDt4E62eyYZbvNBepU2vDNu0IxVgzobkn+v5IerzrWWPMlU4pH9QkFDTAtjl
 kytfriI1U9DHHV+WqmXelvprDcaeTLfjfODTUBbRBRv+yxP3AUlAmbjZSkmSqSzHSqbm
 Lflgsb4/USU8xKVOErJk12zhled37Pimw8Co96Q/yZ6P76bcc1wHjvBgdPgObRaUVqf9
 hA+w==
X-Gm-Message-State: AOAM533zuFmikhtWXciMBSC/QxM5i2flQL9X4dqsV4m8VfF0MGHlFNLV
 7iMQoa3sSNzjk16AnxSwG8Y=
X-Google-Smtp-Source: ABdhPJyEmJa06jyTFcPrqjbXGbRmuVxMrkCh4UXf+gxW1cC4XedxqBB58vVkdVepD+DHCKoLc6Sqvw==
X-Received: by 2002:a05:600c:3b86:b0:38c:afdf:66cd with SMTP id
 n6-20020a05600c3b8600b0038cafdf66cdmr12841155wms.198.1648109619999; 
 Thu, 24 Mar 2022 01:13:39 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a5d6da7000000b00203d9d1875bsm2187881wrs.73.2022.03.24.01.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 01:13:39 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: yangp@amd.com,
	Felix.Kuehling@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add missing NULL check in amdgpu_vm_update_mapping
Date: Thu, 24 Mar 2022 09:13:37 +0100
Message-Id: <20220324081337.2064-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

The fence parameter is only optional.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 86fd5edfbdae ("drm/amdgpu: rework TLB flushing")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c29b12fec863..48f326609976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -929,9 +929,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
 		tlb_cb->vm = vm;
-		if (!*fence || dma_fence_add_callback(*fence, &tlb_cb->cb,
-						      amdgpu_vm_tlb_seq_cb))
-			amdgpu_vm_tlb_seq_cb(*fence, &tlb_cb->cb);
+		if (!fence || !*fence ||
+		    dma_fence_add_callback(*fence, &tlb_cb->cb,
+					   amdgpu_vm_tlb_seq_cb))
+			amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 		tlb_cb = NULL;
 	}
 
-- 
2.25.1

