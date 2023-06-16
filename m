Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F06CEB64D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 13:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9930010E61F;
	Fri, 16 Jun 2023 13:38:40 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8BC810E61F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 13:38:38 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f8c9cb3144so5632335e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686922717; x=1689514717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIWau0mr01tGhOtBWnFul5XGT0nsGLJvIp6JVr2giD8=;
 b=AXOy33pWhLcZVbrME/WeWSiKlXCw4bWZAUZ+9xJmiKedgQg4Mb/ba6BHEsO+AqLhqD
 3DktOiLhA/5KJJPPAo/CTj803YB0qPrt7on+J0VgukQlDZ0lXrxRSYiULhwW/7mC2S0h
 UiLS/VYaxEWR4bN7D+UnyavtxY3XKOa534u6aOoamuaU3Sno2Zm3oe7AQmrfT8r0mUI1
 56jalrXovUqOe61TPAW4NCTvGGidZQUJujnXurMeSSBkAFCgyjCjQ7DCeYQvWwDppU+7
 EMGlX372fVzjnaFGbxAOQO2UET10W4n4zjVLJI5itli45WYmpqunEg/WEI400ofckGIH
 MWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686922717; x=1689514717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIWau0mr01tGhOtBWnFul5XGT0nsGLJvIp6JVr2giD8=;
 b=h9ofOCLqWNMlEQ+7bTfRGhdArYNAK6jpKz6W1/K35kYjzQ+//mWcYExObUuVZEfZUR
 Y8DEKWZ+k7Hhvag5jTJEYPeKrtBBeoav+4kOVxY1cnDwKF5Sw/PFGJOl14lRjzlrh2oU
 XGZv0pCjcUfegyITdpK1Fz8EUctApZREsQ46lzeBJx+KjXTTAIUBgxzL/JrUVQv6Rtx1
 OZgh1JH/cIJUNmPY5iokn0ArUWxtIFu/RwGzmvrMBiF48IpEU46CMO8Dt0YdUHmuHeai
 Ps/L+LJnBw1lACO7fDiiYcAKvoQzaFLa6+FSjkSTzEndi0VFnACNhg9H1E5TnpIE40QP
 IDcQ==
X-Gm-Message-State: AC+VfDwzdyGdpfesqb3/TtHViVvMcdWW54/lqD1WRcxv+T2c0ym0UJAE
 rZ7fxXaNfofdKRQMyFRwGsIIt8zy9KM=
X-Google-Smtp-Source: ACHHUZ4urvk3PUHTi1O9x9HYfKDtMqx3CABSzVCjLIvAOfH190ozDhtQ/sR0I9n8h64E7+5Db8iRTQ==
X-Received: by 2002:a7b:cb4e:0:b0:3f7:f884:7be3 with SMTP id
 v14-20020a7bcb4e000000b003f7f8847be3mr1768922wmj.4.1686922716514; 
 Fri, 16 Jun 2023 06:38:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1d:6120:b96b:62f7:161e:e519])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003f60a9ccd34sm2206271wmj.37.2023.06.16.06.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 06:38:36 -0700 (PDT)
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix clearing mappings for BOs that are always
 valid in VM
Date: Fri, 16 Jun 2023 15:14:07 +0200
Message-ID: <20230616131407.170149-1-samuel.pitoiset@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
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
Cc: stable@vger.kernel.org, Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per VM BOs must be marked as moved or otherwise their ranges are not
updated on use which might be necessary when the replace operation
splits mappings.

This fixes random GPU hangs when replacing sparse mappings from the
userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
are correctly handled there.

Cc: stable@vger.kernel.org
Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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

