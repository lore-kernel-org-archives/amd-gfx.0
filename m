Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D214C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 21:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCFF24181
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 21:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1o4wJ0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCFF24181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815A589E3B;
	Tue, 17 Nov 2020 21:19:09 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C011689E3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 21:19:07 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id d9so22263927qke.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+HsO3EGNKUS6b/M18T2/tIwva8RZp64UPH7mzeON3mM=;
 b=F1o4wJ0FD/3cRN9eejHe1uUVxb6P3XVitnVW70Ta2sLn8vxFxeEgScn0P8A3vuFCZZ
 vvLRlxPoufpndZ9JFgIdab0JCVVQW5hNT7DsMrgjIUj/+8VCQUJpRiQezgo+uVwx/pTv
 lZm4ODlQ6bf5pSVqR4Sucmd+0hKSb4ijP2WxFGGuie84uwpeIh8V+fErDE0rkjXgviZJ
 E+bie49AYlL/mf4e6VSu3oN4etD/pjgDQ48hyauGlviuvofWn0+qXieKBKHjolz5cmES
 07jEVoG6ajPlTHgCcgL02AIj0yA1rx9Nj5YCFHocZpkXToO7NQdNnzAQd4YVp48r8v6c
 f38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+HsO3EGNKUS6b/M18T2/tIwva8RZp64UPH7mzeON3mM=;
 b=M7faOb1WLuzIwNI+xF3zLsWAdVxImKBTWgiZ52SilIEGTy7R5kSVgI+DsyRtxy5pNe
 T2nImOBOSKF73nEh7luAMuBXV8667UJBa+YXJR1HD1mvftE3ncwAvRIIwNYXcDL7+FMp
 US8OfH5ndlF3QjfD7buq3sy3dMk6ARzI1oMThzcSAmdci+N6HuclBakzdRZWlkJ4D6Dq
 x2+tLmL4249cklGDMwJ2RfrIQbMhrBmXO4qSbOo8hC9eWmG+xuV+AjfB4FoLVhLNLTPf
 G4OZ4FEcj6WHl9yUfacoDoSXgpvBlihORNkwG8xQmUa3d+l59JTuLx4m19gJXlu268MD
 EeXg==
X-Gm-Message-State: AOAM5313ytVhfsweTgkKoyIrniLWADDIhpVgvvD0aV2vRAakVYijjBIe
 q5owQdhfFhP2daSqwSLVud31BGeibN4=
X-Google-Smtp-Source: ABdhPJzFobr9qtiquxrPcUpf8jkBPXw/+qrRtE6O0sNI18+ZWOquy483Boy0aVS6TX5TvHN3203Xgg==
X-Received: by 2002:a37:660e:: with SMTP id a14mr1740677qkc.330.1605647946779; 
 Tue, 17 Nov 2020 13:19:06 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y24sm13942153qtv.76.2020.11.17.13.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 13:19:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add device ID for navy_flounder (v2)
Date: Tue, 17 Nov 2020 16:18:58 -0500
Message-Id: <20201117211859.3334315-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

add device ID for navy_flounder

v2: squash in updates

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4825b33f83ed..a2990fa7617d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1100,6 +1100,12 @@ static const struct pci_device_id pciidlist[] = {
 	/* Van Gogh */
 	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
 
+	/* Navy_Flounder */
+	{0x1002, 0x73C0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73C3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+	{0x1002, 0x73DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
+
 	{0, 0, 0}
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
