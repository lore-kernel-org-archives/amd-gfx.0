Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32E3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Feb 2022 15:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695F010E690;
	Tue,  1 Feb 2022 15:28:07 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7622110E66B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Feb 2022 15:28:06 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id k18so32785353wrg.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Feb 2022 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ppj0E3hnouq6me/HV1Fip5rJDZc787l0OEIsizRZO5I=;
 b=eAT527rLMGdF/A+ly1GklpAhKegRF6wcILUL7tHwXmIhlKVXT/ABs/fIUNb5d+x5G1
 lahG1dYKAkIuqDm2bn723QhaQmsvte1SfFT6O51yC9EPIYJOA/aPofASskkNWI3oEdwl
 RCNVFRsNJseCCeoO/1Mf07dn5sjxB9D60zJd6LlQbo8DfFJpgFic7npoD2PghfksYNy+
 19DUR6FIQjxI1l14j5hYF/kcK61KDojT+9GuIOcfRDtt5F35qP+WfLWQr27OVSATyC71
 hiz6KY0GoLXmRxp/U1ZQSL/Bk7SuRUzjxJ5wHXHeY/TNXrkLZCOb9jRewIAyoF2ccpzd
 3wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ppj0E3hnouq6me/HV1Fip5rJDZc787l0OEIsizRZO5I=;
 b=dVinuU6ZoorNjIRzjPzWOtTut3UVVyvW6y25UZPRciAvQH4OEWRpnU/S4CvVRyJtTC
 T6Fnwo4nZiSsNiVpGevWLISd/4siLeyq1q/sW05RX0PM5vwv+HN2lsXj0EgyaIXYd/8s
 lp+8JoFSyLujPnTUArkks+nYa2I6EMRXk6GSSozLdvpN8NH7BUP/YfYFwKYBwXCXj2Dx
 XEkGxtUpj2n71ieHQ3MXFVu5halzekdAyExfbrU8Sa/j5mQDeaLumcdgdA4MUet4aPtw
 XEWT2i2uMugEQkxOjnMF+qiPN9TKaLaaC6KomBIYkidpSRFhPnZdr7o1XW2OYwiqzG4E
 /7pw==
X-Gm-Message-State: AOAM5305K3hAxWmwIwuTpqkWBzstmHQQ44pVjl0OafaIQVZrcNfWJCdq
 +J5FVbAMAhrHNSMtVeDdbEg=
X-Google-Smtp-Source: ABdhPJzkzqEMC+jbBju4nc2no5zv/NbkE24yl+/GGvTGOfTH6PBNl/AuHiU1Af+Mtxb0Bx2J7BVwsg==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr22522943wrw.343.1643729284934; 
 Tue, 01 Feb 2022 07:28:04 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id t4sm2303482wmj.10.2022.02.01.07.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 07:28:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch,
	felix.kuehling@amd.com
Subject: [PATCH 1/2] drm/amdgpu: add some lockdep checks to the VM code
Date: Tue,  1 Feb 2022 16:28:01 +0100
Message-Id: <20220201152802.12159-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Whenever a bo_va structure is added or removed the VM and eventually
added BO should be locked.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b23cb463b106..7910046fe11a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2260,6 +2260,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
 	if (bo_va == NULL) {
 		return NULL;
@@ -2273,6 +2275,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	if (!bo)
 		return bo_va;
 
+	dma_resv_assert_held(bo->tbo.base.resv);
 	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
 		bo_va->is_xgmi = true;
 		/* Power up XGMI if it can be potentially used */
@@ -2667,7 +2670,10 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_vm_bo_base **base;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
 	if (bo) {
+		dma_resv_assert_held(bo->tbo.base.resv);
 		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
 			vm->bulk_moveable = false;
 
-- 
2.25.1

