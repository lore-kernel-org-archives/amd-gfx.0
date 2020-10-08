Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 19:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1574221FE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 19:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIVW4TVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1574221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAE86EADA;
	Thu,  8 Oct 2020 19:39:21 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FBE6EADA
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 19:39:20 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id m9so6093796qth.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2020 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q4Lzdd0fkf8zrIPvN881kM4ATThqPFNrXG+V1nHr3aA=;
 b=SIVW4TVCHn0fOqb+3aWQ0byaMXWp2fFnbYni/ZE88M5D5Z6GbglhD3Dc53BQjHEh8i
 XKwE5jKGYoQXZJXlOyT9mUrtY5+gMCqqGOkz/HP2f0U9gzQ56y5EUfxH5Fgr7PrWF7Qa
 WiIobocFV+j61nTcfjzTCPckA5IoQkrKTYG5UtxXbVCXa8x06lix2tBE1aUwY3nwuGOD
 WZh9dMwuXuHA6g8QS7l68SmhLWIaPrh6+a5lnbzb5HKs9qEP4WQrVztqW1xH2bUMDOBT
 /5C+6uEIE0uBxQQ1W6xIzt8ae2MFB2YLH3sLfQV6NCwbhODCXuG14PTP1H+G/MtHP9vq
 /wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q4Lzdd0fkf8zrIPvN881kM4ATThqPFNrXG+V1nHr3aA=;
 b=avSqzo7TsuS3yrKtrxco2AlaLOf5Dm46VenHiAB8LWeZP3S71kmMdWpdk1KksxmSNG
 tfxvSTTefJ7KhBjA4zrQWfgGw+azknzauCsdAO9FLzHMC6ytpAQ0jymmJYZd8DCcwhV8
 6QzDAqimQcwgKQT3TSgiCTXTjKL+IpHFvNVjukRqslAjDpe5YmMiO4cpHw1haix9LAwv
 ToP1G6+K9sS79qjHG16CAU58K1y0qR6YKFJFXkwiBNBTYKHtc+K2rah2TB7RkrNwbUer
 9iDfh+JU9N0ukUDFBJ07EiHTXfQruczkdyqWVSrFQ4c36haPSfsNxobp3mhhV8M0mas9
 W1ag==
X-Gm-Message-State: AOAM530AwnYRCE6MoIhdS3mgJncm8d2tJH/GTAM8chFz0htckgnTM5g7
 WzSFljHU2rEPZpmFK5kg0YYQVbelGfM=
X-Google-Smtp-Source: ABdhPJygl600GoeRxJrYIWPbLJo2/Uo3uEnlN9z9KvhNf3ZjD2/pzgdq1tAORvyTTf/uI9ozhzhQBw==
X-Received: by 2002:ac8:4d48:: with SMTP id x8mr9847899qtv.174.1602185959027; 
 Thu, 08 Oct 2020 12:39:19 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k5sm4518267qkc.45.2020.10.08.12.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 12:39:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: mark Sienna Cichlid as experimental in 5.9
Date: Thu,  8 Oct 2020 15:39:08 -0400
Message-Id: <20201008193908.3124447-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Certain boards have problems in DMCU handling in 5.9, mark
as experimental for now.  Will re-enable in 5.9 stable once
the appropriate fixes are backported.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Still working on the appropriate fixes so I decided to tee this up
for now so we don't miss 5.9.  drm-next is working properly.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 321032d3a51a..ed60d136fff7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1048,12 +1048,12 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 
 	/* Sienna_Cichlid */
-	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
-	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID},
+	{0x1002, 0x73A0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x73A2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x73A3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x73AB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x73AE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x73BF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_SIENNA_CICHLID|AMD_EXP_HW_SUPPORT},
 
 	{0, 0, 0}
 };
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
