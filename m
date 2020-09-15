Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686DC43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19A1205F4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlsDIrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19A1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459D56E8DE;
	Tue, 15 Sep 2020 18:24:23 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FA56E8DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:24:20 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id d20so5287579qka.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8yk2K3vVXNxAOrLo8aW8E6lEDFZLxkyDP0gzSoFIByg=;
 b=hYlsDIrUu7459Y/71zCjKxn0vovIOjgN8cvxwgnhwjGeGFXdv4BgdZxqwvgxFn0PNo
 fXd/ebXvF7b4SFaLrlTTUc60V7zD9G289bagjAacXcdzEpyJ04YkNadEg5mNyALCDkie
 U5nhrvqb+OlZZwAj3bgSPPschm/e7Pcq4Je2Eab0zgkw61Cb7CYDjie2mai0rHWx8Rmu
 kyUnQu6P0RmQzA6cGBUucEKrkB/Hv2uT/fc6K9DY8FV6zkZbFCCVjO75WLMUAlAw4nfq
 yLLYrRDcyulyvvuOctiJjbTkL0up4yNJ7o9rn8smsMUHw/4QQjt/PRR9CbNd67oPmFt+
 QJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8yk2K3vVXNxAOrLo8aW8E6lEDFZLxkyDP0gzSoFIByg=;
 b=i94v0tgn6boPmyYzcHRih2Z3EhHNnSrLWtwnKipWNqlGh7IN/J158Mabxy7zU41NWF
 D0LvvxeeAWygMiqadpbnFK8AxDAimo1HL/n2i+XeWa/9VgpwF3iDJtkjoz7C3JgnGYIr
 ku2RR2xpUmjYpYhwACNvJygkbNxdfU49YvdKkLc5OV2BKH/dtvjBW1AaZaN6hg5zU7M9
 O4R5FsmpfkRR0dMa+b0xuQ2csZq7GXPXLAMzW1wApmTBOJcnvziiwMLWUqj9J5IncZZi
 ybRNRLQnWPlKStf5Z9VcWCSL5LESTiDneGFVCpJgUk1a6G0eXLucGxonaduX4Z6lpLbT
 9VoA==
X-Gm-Message-State: AOAM530ZIiUnni2RIs4P/HJ+mTgMBCqrMY3Hfw2xMArhSN6xwBU9Wa8b
 LvZz65IJ+O+sNBbVsr+7PvN1/DxOmZw=
X-Google-Smtp-Source: ABdhPJwaZZD/NWDmKOfAAnFmLZBVjTnysUBeKtBg7SInb1fSJLSkkruZ3eeHTi/uxeKRXIPF6Fakkw==
X-Received: by 2002:a05:620a:4c3:: with SMTP id
 3mr19726440qks.105.1600194260025; 
 Tue, 15 Sep 2020 11:24:20 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id x126sm17318009qkb.101.2020.09.15.11.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 11:24:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: add device ID for sienna_cichlid (v2)
Date: Tue, 15 Sep 2020 14:24:09 -0400
Message-Id: <20200915182409.68727-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915182409.68727-1-alexander.deucher@amd.com>
References: <20200915182409.68727-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add device ID for sienna_cichlid.

v2: squash in additional device ids.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6e4c860e8ae0..0bf22134f17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1076,6 +1076,14 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 
+	/* Sienna_Cichlid */
+	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+
 	{0, 0, 0}
 };
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
