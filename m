Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803DC4361B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A4822CB1
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 20:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4822CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5F86E22B;
	Fri,  4 Dec 2020 20:44:48 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D876E226
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 20:44:48 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id u21so4926524qtw.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Dec 2020 12:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HVm6J6IHayqWT/k1+GlG0hQkAiyikGofkmbNPGFLFqY=;
 b=qc5pdf+ZD15TIBhY7BXWFjBJsjG93hraCShpUF7FdUkwlapF+erYJuwmSRMawKq3Qm
 J6PNlyBckfYQ5iut3Ast44QKtcJ+csZiz0svavGj9RTgmKRl6iZdDcu9gcYFNFdxrFyW
 Z/LYFU0V/nRRe3VGwx1SDum00DhmHOgU22fSo99FNFH8RUM+P++ejHVp0iOwBKtzz2bg
 QwR1p40mapPFQU/5wId6S1cfrZYvZGHzjzjcBAh7drfrKSd3c2GFlVDmyqBngC/TxH6b
 a1w+oiHSvy07zJT2hElYq9NgcZZd3Z3jv7s5xt5RXVqzi91FBD6yI5ICPGSkSSW5QzT1
 0hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HVm6J6IHayqWT/k1+GlG0hQkAiyikGofkmbNPGFLFqY=;
 b=Pnb/GlxbJu12G+wmHyGei9oOopBD90bhnE6gjPUXCDPVbf6oXx8/orWluodILGofjh
 e5Vo7xXlLzLzLyjgPItrwl7baVlffJnFHtRGQBnCfvt7P6dqDtrFnPBSeW0cULwdP14q
 UKe5t1RUtHbRUOy5kxOnbLARSw+7iDzJZB8sGKTE+7UOIvGy1C5s1elqiwJvFm37Shik
 1D2Z0K3i44pNJHTtI84tsbl9jh3yNZqsTqtMav2KzqGD8WD3qj1YLoyuNyQ6eKIaAQ7i
 hfVeyAXcZs8uviO89GGRRf+eSLJxrJZqLYXejCkqdYuLO1ZbXWVkYiY52Vwz5Wg70To0
 c3eQ==
X-Gm-Message-State: AOAM5309ocvYgQF+UDL13+xHHVPy9ymtBGGFc21G5indW4OUW5OjcOxD
 88Pg2KFrWglPZ5PDGhB39hNLodA71Lw=
X-Google-Smtp-Source: ABdhPJwuSxzAoJTwNpTk3/OYA7VCiu4SZPjdnPNMTL6xWxXxVbk0eksrtRgB8FZ+NlW6t4C6ffYm+w==
X-Received: by 2002:ac8:5806:: with SMTP id g6mr11177621qtg.292.1607114687493; 
 Fri, 04 Dec 2020 12:44:47 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id o13sm5646581qkm.78.2020.12.04.12.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 12:44:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] ALSA: hda/hdmi - enable runtime pm for CI AMD display
 audio
Date: Fri,  4 Dec 2020 15:44:37 -0500
Message-Id: <20201204204437.3845-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201204204437.3845-1-alexander.deucher@amd.com>
References: <20201204204437.3845-1-alexander.deucher@amd.com>
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

We are able to power down the GPU and audio via the GPU driver
so flag these asics as supporting runtime pm.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/hda_intel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d539f52009a1..2ea46b5a9a23 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2597,7 +2597,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_AMD_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x0002),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	{ PCI_DEVICE(0x1002, 0x1308),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0x157a),
@@ -2659,9 +2660,11 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xaab0),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaac0),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	{ PCI_DEVICE(0x1002, 0xaac8),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	{ PCI_DEVICE(0x1002, 0xaad8),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
