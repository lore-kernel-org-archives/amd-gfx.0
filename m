Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D92CC33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D732324658
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx30CwAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D732324658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84026E03E;
	Tue, 14 Jan 2020 20:55:38 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B98895B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 20:55:37 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id k15so1924843ybd.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=weBtekj458P/fqac5LHRcran27/PThoOX/Om762JNZI=;
 b=sx30CwAIbFhljiLbe8MA3aUlpLeJG8nh1ZpZKkKn/Y0PlE9Q9QbNZfgNbenrzVYNls
 PEI+hny3OBHW0r99iM01a1wdlIkAH5JDNQrJFnIWROStTZwgh1wZaP2K+gPsoKjqwg9p
 hpMLSfScbMpVun0a5jTWounGrM8c9ZYD4ZKpKuJFqAw8ofZNU1mqBG3FJkBPkhf/j6TC
 b7JKSawj26J3GBulWW7ejUg+wVq9fsHY8IP3dVtX3LX5z0rTZtiQwL9PBhzfGvZRj1ct
 8GzIq6WToDK62eNaq7//XGpY/u08WqAWtp5mvnNk925bOdG7GFXemLoEqfk3E8alt6U6
 UDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=weBtekj458P/fqac5LHRcran27/PThoOX/Om762JNZI=;
 b=htO75ZQwJCB1XQcW98J1W5jmSecZ9JpUI4MBbPls4YGrFzUeC/m+zVsJbzbFiPblzV
 FHnyPf3YBQezZ0X7jaczeVjG0+VUIBnB8aj0Fqx0RkM1KD4R7+6caqOva7vZpJ8Xl10K
 Vi+p6brs81NKbbXw2AkOMe96sEeUbMKAst5/6denfFtJplRzgg/EoD+RTgi6dp6/mqHa
 srEYnl/xo7pQ3NLWdnIt3H5I5MSAXbm0EsD/ej5MwwUw+XYgCXRZgotKD9ZLj57eBhyE
 EVghSF/xeplHaUxpTlMLMbE/JI2WK/6VJI6zV0QGGgbc9HSAPEpMeNZlAvvKpbBDCCUq
 8xQQ==
X-Gm-Message-State: APjAAAVRAGerc2hP2a/VfdX3GjLU/rtPPVxgeV5YFypfIlPGeVFdrPP4
 hxiURI6e8LGK/RwhRaYM9QsxeYBL
X-Google-Smtp-Source: APXvYqwVML13FHQQismSDXdkFq/reCdAXkxm+Syqknt5Z32mK0w0uTynDyu59oQ6i63ZTJpurMksIA==
X-Received: by 2002:a25:1f82:: with SMTP id
 f124mr15618363ybf.471.1579035336278; 
 Tue, 14 Jan 2020 12:55:36 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id a189sm7440521ywh.92.2020.01.14.12.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 12:55:35 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com
Subject: [PATCH 1/2] pci: Clarify ATS quirk
Date: Tue, 14 Jan 2020 15:55:22 -0500
Message-Id: <20200114205523.1054271-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114205523.1054271-1-alexander.deucher@amd.com>
References: <20200114205523.1054271-1-alexander.deucher@amd.com>
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

We finally root caused this to a GPU configuration issue.  On
some harvest configurations, a driver needs to properly initialize
some of the caches on the GPU for instances that are harvested
(parts of the chip that are disabled due to silicon flaws).

The necessary code to fix this up is too complex to add
as a quirk.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4937a088d7d8..6569dacbb48b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5074,18 +5074,28 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 
 #ifdef CONFIG_PCI_ATS
 /*
- * Some devices have a broken ATS implementation causing IOMMU stalls.
- * Don't use ATS for those devices.
+ * Some devices require additional driver setup to enable ATS.
+ * Don't use ATS for those devices as ATS will be enabled before
+ * the driver has had a chance to load and properly configure
+ * the device.
  */
-static void quirk_no_ats(struct pci_dev *pdev)
+static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	pci_info(pdev, "disabling ATS (broken on this device)\n");
-	pdev->ats_cap = 0;
+	switch (pdev->device) {
+	case 0x98e4:
+	case 0x6900:
+		pci_info(pdev, "disabling ATS\n");
+		pdev->ats_cap = 0;
+		break;
+	default:
+		break;
+	}
 }
 
 /* AMD Stoney platform GPU */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
+/* AMD Iceland dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
