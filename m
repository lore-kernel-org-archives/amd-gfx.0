Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397B3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 08:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DAD10F4E8;
	Fri,  4 Feb 2022 08:52:05 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F5C10F4E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 08:52:04 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id w20so7747688edc.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ln1zERxQeeAt38OCt9g/2b+T4CCXYQXWNdqSXgfAd5c=;
 b=GPSHI8ofLWDv/cXCTTbQZlF8sUhvCFAC0prLxQCIjQWv9+1MKOqZRC5tdT4PTqv/xH
 6C7Iw16W5Ix50XfmksSuY049iiqHAiYFBx11QiNDC5vN1H/A4moaGVcQWU8XgCGfoyTU
 XvYWM0ez5NJBR0MU0yECpb74XKWfVAUBRCinwaeKPQ19a1SfsRc2Nq+ZCTgi1VPAmbq2
 Lh/Ryl6E1Ad2V2Pbh+Es3eH4LrOm3KJLA1phHujUMKoP27F4okcxuILPLKYRrey2l5kl
 Y2sC8wrFJgo18DYbuCHFbiFkE5PmRfq884ho+/D34YIrhckOyayj6MtphJ1LfoA0HuZD
 AU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ln1zERxQeeAt38OCt9g/2b+T4CCXYQXWNdqSXgfAd5c=;
 b=YO6Qv1c7a0srunkFoGgwTzFZZPqNr/e2Zj70hG5omEMS8Rpail1enswfZfRil7EX5E
 WuJV/9Y2IwSlVpOgctS5cfeed1QW/mr1U5CV6Bx06Qpb1ebf0WeUZAgsw8yMcNvYFxsW
 PcrAI5zvZWFbx492A+csFg/v5VcTCbl+p+XSKjuNpi+tNrq4Ko+L9SKDjUy62t33FB1+
 IH2Ts6yXxdlucxwDl3RhaKsiViCydSLym0ULrXgmtJWDoIbbIlIgSUdU6AKKDVBPdbK7
 DNNLpp3a2UetKxXiatwzlLcuAZBy+wvFnGAQPFFfx5umr8VxOd/l0SM/lIcZQOLyhqaN
 nb1g==
X-Gm-Message-State: AOAM532oV9NUiovJHVCOgclKvyUPkvQOH4niGEj284TjNJ+ChXwm3Brg
 uBfoKWsac7C4Wk1nWepvQncasmz1gfU=
X-Google-Smtp-Source: ABdhPJz2SyT4WnCgWALZCxZngfnuaFanDG+FcWw0hsi4ircC08rK4DDoo589XcHATQnmJaWH1yjXtA==
X-Received: by 2002:a50:eb82:: with SMTP id y2mr2008359edr.133.1643964723181; 
 Fri, 04 Feb 2022 00:52:03 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id bo19sm542224edb.56.2022.02.04.00.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Feb 2022 00:52:02 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Rajneesh.Bhardwaj@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Date: Fri,  4 Feb 2022 09:52:01 +0100
Message-Id: <20220204085201.30615-1-christian.koenig@amd.com>
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

Since newly added BOs don't have any mappings it's ok to add them
without holding the VM lock. Only when we add per VM BOs the lock is
mandatory.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fdc6a1fd74af..dcc80d6e099e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
 		return;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	vm->bulk_moveable = false;
 	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
 		amdgpu_vm_bo_relocated(base);
@@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va;
 
-	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
-
 	bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
 	if (bo_va == NULL) {
 		return NULL;
-- 
2.25.1

