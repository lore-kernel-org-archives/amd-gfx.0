Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098DEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 06:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EA610E05C;
	Fri, 16 Jun 2023 06:51:55 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F145810E05C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 06:51:53 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9a8so2240545e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 23:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686898312; x=1689490312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lF8j2yuMAm7EbfaCMU0ysPlzaZKdK03OP3QqXiTw+vQ=;
 b=GK7uRYOvyFWouRnsQD+Vex/lFl+l+Wf6/pV26pCGCoLsBj2MRKtEwl3qiSCaze4Ers
 Gcl7VxyMx8idEcRZuquhsEKv+nMYu64XpUESq0i4rsbN+UDS8PcXja5U1uTjkml6Zban
 tcpCIAmeVez8IvCGUaD2Bt3XsJ0t+U3n4qPY6qWfyf314HtnSQQHtFBiWkG5u+hvsccb
 P8L9krMNQeHdP71iJKRS5CYoqa3FC66d2KGhSA3sBAmbKj5bkWjUXYB8t8DaGOUUOIuI
 HrWHfx0M49zEhWkrTn9Fb1r3MiVwYVQzf7351HG5LgpPYSGAgt454/FxOFR3X8GBDuNn
 y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686898312; x=1689490312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lF8j2yuMAm7EbfaCMU0ysPlzaZKdK03OP3QqXiTw+vQ=;
 b=APsH5nR45hQjgzidjY/8aUlmLEIc3cuhX7ixdvnK3OID5AvvY7rwvB/Qo2ZuKGx64F
 XGHpFSc/1SkTLfKWcUL6PoDw1sF5WtPjFKOLjsy8ONsYlDq9vi3tNQuv4x3zj9lIxywx
 l3cUUQQwhNR4aw4UUPxrtO4rgJs1OMJu45KqWKeA4PZu/PlA+8jlBoUOXkVaWIoDLJGs
 p9HSOOwX/fA/xoyefOUuqx0TQNOXtoL4Ir+sLugrkQHkYsAuiKyIqCKv3CpQXhTPBr4A
 FRwuytGugMpA5b+J0icGu0yfk/oKzvnseto1zhcCgJFo1rpJVpt6By0RgGpRUVGfgpun
 kevg==
X-Gm-Message-State: AC+VfDwrGm0W5xV6UrPoWqoTDJ94pkn9ZEaJz+bxzb5e5CneczXNN86d
 uukWob+M1pvT33lw4mqYyvUpAKwEBYc=
X-Google-Smtp-Source: ACHHUZ5sKJPSWCHaSWRNkJuOi1jmoCEhXeb6ECkkP9dTpyJDQ68N9qF/b+9dbjaMWPRPN8gJi6qNKg==
X-Received: by 2002:a5d:568a:0:b0:311:1497:a002 with SMTP id
 f10-20020a5d568a000000b003111497a002mr541143wrv.3.1686898311670; 
 Thu, 15 Jun 2023 23:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1d:6120:b96b:62f7:161e:e519])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfebd2000000b0030789698eebsm22745674wrn.89.2023.06.15.23.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jun 2023 23:51:51 -0700 (PDT)
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix clearing mappings for BOs that are always
 valid in VM
Date: Fri, 16 Jun 2023 08:27:08 +0200
Message-ID: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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
Cc: stable@vger.kernel.org, Samuel Pitoiset <samuel.pitoiset@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the BO has been moved the PT should be updated, otherwise the VAs
might point to invalid PT.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 143d11afe0e5..eff73c428b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
-- 
2.41.0

