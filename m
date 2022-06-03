Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9016AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 13:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1681E1134A0;
	Fri,  3 Jun 2022 13:05:30 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370091134A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 13:05:29 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id m20so15775138ejj.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OM4UkC68c61HiPbQiKbgtyI119SLGp5pkzfA9eJcOUk=;
 b=EzjaU6aPm3PKgROCcYVK+x/Gvfe6sh1sKRHX/nPtQqVkxOD0pPD/HAPSR8DsOrfDQQ
 fRY7Xh3hthxgq6TqggmKPxbpJpzQoiTYO4I/fJbVwv6G2R56rJ+MYcw1j4xe9RygwHvt
 ZWXvW+HERIbJRWG2Yz3cCd32QE40JWkKqa5N3s27KzRdKP4jK8I0WxRWSPRCbnYc2Bbz
 WgOwhn63TTr2JQ1+ugC71g0W7do5sXZLm8EEz5apbhuwZFzWyLz6Ge5sF3PhlQzi35hf
 WWDShd4FkK1of4GXUi2Qypzsro5JgHYM5Zb4J8nj6ESs5cKdOh1VIr8QRnx89404yREq
 vnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OM4UkC68c61HiPbQiKbgtyI119SLGp5pkzfA9eJcOUk=;
 b=Yg6d3ENkE44rk/HF82P/L6ho4LPDFs4outnB+ieSSBurM8YP1tFP7fCMJW7s+OpeeU
 X2bedfKl69Rll06pzWra0rB0Hv1KS4rJ8ZzkkmaLU1MmVkU4c3LWgdsOXv703QeVeP54
 ZuR0ygT/ZAD+pJgIRN9eU5zckcyy+KKoDANZGL9T3yQlgcF8YhRHjUL6y+RzP4koMn0x
 hI3p6EaxS2ld3LbjuiLBF9JP/YfYbD1R6Z8xg0zAHLCjQsjj7A6oMGv+5IYmutu6M8GY
 NnEA51GcnYW/tMvOjeaF52nYdoBRsQ0PiajzpLoDGex3mrXRu0ufhklo9dDbqQgrzNpZ
 Esyw==
X-Gm-Message-State: AOAM5310mK3cuXAJWLouwb3vFuR8UnRhDm2lr2KOddIR7ptcvPq1CQgj
 GIsaTuWGBzDh/h0m3nXzEQo=
X-Google-Smtp-Source: ABdhPJyKNY/5u5BhV7Kr+UlQ/37Hh8X9kNzkzDCBgOBzEvkSETNSy3SKJg/y+BFfh9TD8XoXc3q7LA==
X-Received: by 2002:a17:906:656:b0:6f4:ebc2:da81 with SMTP id
 t22-20020a170906065600b006f4ebc2da81mr8609045ejb.757.1654261527666; 
 Fri, 03 Jun 2022 06:05:27 -0700 (PDT)
Received: from baker.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
 by smtp.gmail.com with ESMTPSA id
 aj12-20020a1709069a4c00b006fec56c57f3sm2814906ejc.178.2022.06.03.06.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jun 2022 06:05:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: always flush the TLB on gfx8
Date: Fri,  3 Jun 2022 15:05:25 +0200
Message-Id: <20220603130525.81198-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TLB on GFX8 stores each block of 8 PTEs where any of the valid bits
are set.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9596c22fded6..b747488c28ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
 		     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0);
 
+	/*
+	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
+	 */
+	flush_tlb |= adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0);
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-- 
2.25.1

