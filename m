Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB88C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D5E2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo8Pg4jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D5E2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F786ED85;
	Fri, 25 Sep 2020 20:12:07 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19A16ED83
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:12:05 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id n133so4072087qkn.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uuOvXj55mM3KGVMCgciV7XpjCaRrVA6q1g3nJpoysYM=;
 b=Qo8Pg4jRHhTg1ssDPOl3Vz7sxcoEqc0kl6Xer/2BfXnW5y3G3veOwWyLkceA6j2xM9
 V7uc/v0BmFEl4D6xXVpYplw3PaRQb+BwWpTBM1OoDAB15WuJJkUs9k7+CjhqEego6Tn7
 Z2L4khr8OrBz+7wuqb0avGnyXZNUoFbqrF755Efc/iO5OLvr8m0cbB1EVYllE1mo4xGZ
 Rvzr17CJ/HRHbBe4cgqRdBmIFd3VYQQ1TsY2BBXTTI1YVzIffRMUVOMIg3HxzQQV5pLv
 LWt8qcjNm78DJN8ZBrVMPT8Qvwl1HB8NmmlDJlr9u2NldIcW/cHPYcZ0pz/dy2JPT/7q
 J1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uuOvXj55mM3KGVMCgciV7XpjCaRrVA6q1g3nJpoysYM=;
 b=EyUaqHN0H/wHspOoujlX98DPA3EJ5jxRUw2/C+uLbIkxQ77B77pU7FYV7Y0chO/SGr
 YBrzqp2rbmc0QDvjARBdnlXkK1ZYSiHs5yOwnMA2zKwHqDyooPlxlZlq0tE6pLJunXE4
 EiVjn7LiLveJG11G3yKmHClNlMk6hrWNc+XvdB53ztn6tquPAG+4uW8gySaAVnwhWMNI
 qUvBXrzu37XRWpf2eL4SABM4tq2uLCgstKHEtTER6bBtHJb5tI7KuHivpcU1xOSWmGXD
 uOGhJxJNQi5s1ZAB40QVoZdj8UXZPjKf6nf/KfhRMLRn4TKCqCGgHBZe4ScmQVjIepgw
 3hPw==
X-Gm-Message-State: AOAM531OzqCRCwup9rQxuT7LTJTksz3giltaHnkH2J2cqkyr2nR/giZh
 kTbNTqrBTQPwfysKApEmBBn7dzE6Cj4=
X-Google-Smtp-Source: ABdhPJy0ZhChhDjCyNZEoXGMXH/vUkbr3YOJAiSlc+5nqDeKruWJZeOLidWnjtN+VjPYySwp0/DTMg==
X-Received: by 2002:a05:620a:9ce:: with SMTP id
 y14mr1823743qky.437.1601064724769; 
 Fri, 25 Sep 2020 13:12:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:12:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 45/45] drm/amdgpu: add van gogh pci id
Date: Fri, 25 Sep 2020 16:10:29 -0400
Message-Id: <20200925201029.1738724-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add Van Gogh PCI id support.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9ad1da52e6da..564336c2ee66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1088,6 +1088,9 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
 
+	/* Van Gogh */
+	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
+
 	{0, 0, 0}
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
