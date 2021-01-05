Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD6EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A4B20449
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 17:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A4B20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E2188130;
	Tue,  5 Jan 2021 17:52:58 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4719B88130
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 17:52:56 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id 19so60081qkm.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Jan 2021 09:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KdBK+gac7RiZ1BPColKtSI5XBFmEiri3RCHe0eQPboE=;
 b=lm43+dr3llnTeguzWgoL69HUvNXPEuJkTlp6xbCTxrD8WxWjakiGoJIdRtAySi+5Yj
 tVSkX8XaHXXKvFobFIUq3IaRlU3U4P+ROxfJ8UJIkTyJ3TPDY7db9E/VI2W4PK5Nt28c
 EL8ZZUpZVjR0Hws2PB1bNOUoEDY397+Q9fsVoEUhHW0gwnv6STrqIDfTX2SPMf6X4MmB
 UzCuTer/YrNWE9UjUAP7orZCyjf+e1EjL7+X+Vk84/T7QYhghBD+DyNMNhWjuRMMhF/L
 TkDR0+UInmsHcCE8Ei1dCsKZ1al0jaLvUM9qZZa2ZaUg/IvW9ZpuoHtcImeCgM3g+uz3
 Nj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KdBK+gac7RiZ1BPColKtSI5XBFmEiri3RCHe0eQPboE=;
 b=spLhAlqSWcEKUTw2QC8fQE4vkfdPLvZ1+Buo0MwjmJ9SO2zpz0c5AuckpHgvAu13Sx
 2bWA2GJ8qNXzQd+auxnytbwsokey2Po1CTZIIvw7X7pQd75pkK0AL4R7MNbLo03rKrVc
 RiurNeUb87FFuZUYjMi+lv9DNlyU1UM1EJtswOo+P0C+KaUORRT70bpPIW4tEMH6bzS4
 1bicEmF7dT6At4AWj9VuXndzHmS8mZygKvVpnm/bTkzzuj9hofLJ2C6rqFrCcXaAvqyk
 6XmAgkJO6aSEyG6YVOI2bO0KgVtfsAXONRCxX1vrKKLAZTZbPnjVgfPUYIOKpivseeCw
 XRmw==
X-Gm-Message-State: AOAM533WqF1C2DuR5023DFK2izzurL70fzaOzII+KjDWaZPny5C2mwd1
 HhAKlEzJbaEGKWGWW3liZVQ3NjIVVOM=
X-Google-Smtp-Source: ABdhPJwiHIhEGk6/RqvN+/MgYKsYOvdk815Ez1fzQVikEu4jvOibZ1XN+ehwZT0zodum4hBi2HPm2g==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr588809qkg.479.1609869175218; 
 Tue, 05 Jan 2021 09:52:55 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id c7sm422729qkm.99.2021.01.05.09.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 09:52:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/hdmi - enable runtime pm for CI AMD display audio
Date: Tue,  5 Jan 2021 12:52:45 -0500
Message-Id: <20210105175245.963451-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are able to power down the GPU and audio via the GPU driver
so flag these asics as supporting runtime pm.

Reviewed-by: Evan Quan <evan.quan@amd.com>
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
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
