Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B7C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78EA207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckE1rd4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78EA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250586E42C;
	Tue, 28 Jul 2020 22:46:35 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27616E42B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:33 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id ed14so9982856qvb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q2XNkz8h7/p9cNIBToLvbLro+lvvXF8Agub1DO5bfv8=;
 b=ckE1rd4dDWmHS/hZg3oc2Xx/Aj03Ke5xVlosv9dPknVWlIVBdqYmlZ9aYSCqBppEpE
 6GQ3sjw5z5gzfBHJholGO31eVAZ1i0DAfcGB7mM60KDcx0JyL4HSOKMPOtX/xkyWjVh8
 VSkwCQUCc3eDCEyS7zinF7e/0m5duL2gNl2PJDbVU9wSfw5mrGkaWrvP84ycFfnt9XAD
 bAqgrIlmlk/lYB65vx64DrG/ZOIjupFDjw7UAn5bXy+73ru/iXOGSkuiA0A/BvTWBK0A
 TmAwnvYJwh/yTixSEDApiomxSg4bjIf0xmz0GFwJviYdFytBma18KHUNEYWyNvs2gfwa
 0ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q2XNkz8h7/p9cNIBToLvbLro+lvvXF8Agub1DO5bfv8=;
 b=Qm7+OgX5gWEYVkoI4wfYe4ZaKKYXAnPXK10Eqwv3Bt/w2BcU7rgZiDspgf/M06j3rr
 hWPzCXVkXtiLEZjYgGK+2wBxm4a81ikepGJ2cPMfDgEM00oI9AHLH/opZ3K1RLhQeuHp
 ORRlH9mNDMwHXJDItVQQiEew/0BNenK0XdDPZD/f62JbCfQqVd6GfO/wMUChBa9u4jqi
 rW1wqbZP4N0zkE8TnXXmy7seB/i94zxWhN7eSOm4Oxi61XSOt7IN7PzlbZ/Nb1ClPvfj
 3tCKkoz/q0gND/8329zXc7jK8Jp5aenIgi5Nzo3xoMQgfhN/IE8BL1CFO5hsEIcyq7Wq
 LtLQ==
X-Gm-Message-State: AOAM532XfySGF2q8DgusQu9aG1TXn+4L0Ji3DkA9Ghfln8pkCJH7Jb9I
 9kIIQHyY4w/iCe8KQR7eLUAVGklm
X-Google-Smtp-Source: ABdhPJzK845tx4vjrkjNqamqSC6jSm3wHKlOHLj7Re+/t5xnY3sqnK743a77iKuHHDZNeLRMtxDx/g==
X-Received: by 2002:a0c:b891:: with SMTP id y17mr3702231qvf.2.1595976392865;
 Tue, 28 Jul 2020 15:46:32 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amdgpu: handle bo size 0 in
 amdgpu_bo_create_kernel_at
Date: Tue, 28 Jul 2020 18:45:52 -0400
Message-Id: <20200728224605.3919-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728224605.3919-1-alexander.deucher@amd.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just return early to match other bo_create functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5ac7b5561475..16a37caa654a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -366,6 +366,11 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	unsigned int i;
 	int r;
 
+	if (!size) {
+		amdgpu_bo_unref(bo_ptr);
+		return 0;
+	}
+
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
