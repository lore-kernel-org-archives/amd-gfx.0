Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C849C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7C52469C
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j406/ukp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C52469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077686E0C2;
	Thu, 27 Feb 2020 20:15:03 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986416E0C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:15:01 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id b186so888277ywc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWzcSNGyQ59C/m9OwZestRRM3EupNWtCh+z/JBajDLs=;
 b=j406/ukplKlH73Mv7pTxPt1x4NTF7lhy9epW9H0ESqcnxnkERqh9IEc8eWiQmGYsaQ
 g72Mjq/pYm1XNOkWvEdb32oMu5nF6/AHWdfdyYRPzewM4Iut4SOQxTDmnznGy7yt8/Fb
 178zYijDsGgCzoMP/IvPgORPzpHZ5ytmhV7NcIfFU1A9FxjGVvuo/Ei9T+S/Mf3ykTK3
 7QHPAou+wZEK1umdX2H0M+6rXRWYy6WMEiu+QjHAqkrx50R66FgcLW7Q6Od70PCOubDO
 YrYA2KtQteM4PDNW/rR4OcKcjDl/d/WpIjLwGADRVDp4RHClyX/13E3OteWO9YTzpY6g
 8BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qWzcSNGyQ59C/m9OwZestRRM3EupNWtCh+z/JBajDLs=;
 b=nOjuNC+12U2jvJxgvvC7v8RFLddHvXB2U++TjjwJWdV3rORF2k8LLGO3MT9vistKqO
 ESyWd9ayKEEcpH8a+y97EgMH6la5zhAVj1J60K0MikA37sgwL/OFm7QZpMNFwXyhQnZv
 cnGz/nKU+YDq+Q392nKZeFv6wlivhWHqBwXrBTAdrTzGM4wuzO+7wTn92kE/a6yl4t+9
 frDH9k2gbEqfs9rdmGZSNJawz2RDcDhAuMlWvfl0nqPatt7wVBoUjjiWZfbO6sCdcPSV
 t0/xQJ9r/tqBDUjNO+6w77A+i0j8VyzGocRBYoJc1G5nPmkcM0O44/nzPQGx0tNMbblm
 qfdQ==
X-Gm-Message-State: APjAAAVLw3r88e7g2HwAN0BOcSQH3/ZvbVqTz3Eok88dzmrHVGmb2CGg
 jYNUiNOYY5aaV+OBUOMOuyppoo0+
X-Google-Smtp-Source: APXvYqxj0nEBbA497CY7/T5znp7BON3Xh7Q+TABrJw0dSkJs2sx1Nbi6cMVUu9q9+/62OEtBPZ5D1w==
X-Received: by 2002:a0d:e657:: with SMTP id p84mr1130078ywe.444.1582834500585; 
 Thu, 27 Feb 2020 12:15:00 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j72sm3042228ywj.60.2020.02.27.12.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 12:15:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: remove unused variable
Date: Thu, 27 Feb 2020 15:14:49 -0500
Message-Id: <20200227201450.185953-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Fixes a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bec4337156a7..b3e32969eb7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1131,7 +1131,6 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
-	struct amdgpu_device *adev = dev->dev_private;
 
 #ifdef MODULE
 	if (THIS_MODULE->state != MODULE_STATE_GOING)
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
