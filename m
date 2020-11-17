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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDECC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 21:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058D624181
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 21:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEKpnBF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058D624181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0911889ABA;
	Tue, 17 Nov 2020 21:19:10 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E215B89E3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 21:19:08 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id r7so22285502qkf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GNuKgyg4Dk23qfNOS2EiAo0nr7wGFQDp2y7cy6T3PPg=;
 b=KEKpnBF392/uqN+m/MAPd/chEGFYxJxBKvKdF8GFq2jJ7ai2k6gF6mL/KJb6ztnCxg
 VHCy1J+hUYHjlRjMcJ4eXd9yGHowjGLsbMiHoXBwfFEXiqGagiGijjcfeaO+qgjsNbxs
 N/kbKBRz82ON4tjXQxf8ykwMROkEG95AyxpP5VLV3u5BlmJ3ivD4dAEO2MX6bsTe15gq
 PVfeYx9ASpasmSy0K/YkSh029BllLq1Kc2DcdnuXwVJBIjOs9Xj+OlkVa9niFnqaAy6A
 hgG1lZvB0UH1XtuhiVnFIckBNBoPmzJFszhm37JXry9TxxLkF5oooci+lRmEV7kxRiGS
 9Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GNuKgyg4Dk23qfNOS2EiAo0nr7wGFQDp2y7cy6T3PPg=;
 b=AEf1WLohbipEWzMJuOHz+Z+3C8bQGlTfIz47c07fizQM4xdbhKMpJNgVVZ2ljuU0FC
 e3W4M714JcH9L7yZfzyQ6emlc1n2iinNWRknNOAxLB4vW3N410Zgplkgt74wD8r/DUN4
 rTIiLZ/Tn8wYQB6Ge80Pm+ZN5A88cO39PyjCnaE4PqybUJNCU346lW1ut55za1tn96y4
 eepqcS2gqZBe9BjMzRUp/CnOl5wCHvlH0NjpcomZcVNTSzdajFqG7NH656RzuGIvXAwo
 yWscbPif1Ar8hatFXPlieetkLAFDEF9mpS/jwfnnP/+0dobXYubyy+AjRia1lso0jazO
 4xRA==
X-Gm-Message-State: AOAM531mZqkQzWASTD7aB9W1jc4mk7iK7QIPw2bh8YjBT7MxKiHj9o0C
 QtM0OFGkT0/k1yTGFIhHdzrWChjmyu8=
X-Google-Smtp-Source: ABdhPJzwkpMtg2cv3eqQDSeA3GC1uhuHX3OD5XPekyxPgkGvSxYxeHmFVCQRuDdTIDlA7o0ujLs8nw==
X-Received: by 2002:a37:991:: with SMTP id 139mr1665093qkj.185.1605647947908; 
 Tue, 17 Nov 2020 13:19:07 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y24sm13942153qtv.76.2020.11.17.13.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 13:19:07 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add DID for dimgrey_cavefish
Date: Tue, 17 Nov 2020 16:18:59 -0500
Message-Id: <20201117211859.3334315-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201117211859.3334315-1-alexander.deucher@amd.com>
References: <20201117211859.3334315-1-alexander.deucher@amd.com>
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
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Add device id for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a2990fa7617d..6a44c2e0d6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1106,6 +1106,12 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x73C3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 	{0x1002, 0x73DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 
+	/* DIMGREY_CAVEFISH */
+	{0x1002, 0x73E0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73E2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
+
 	{0, 0, 0}
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
