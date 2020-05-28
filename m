Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF1C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B2C206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivHSwjH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B2C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC666E7F1;
	Thu, 28 May 2020 21:35:41 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656426E7EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:40 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id k22so295978qtm.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uR1FwK2EE/Bvqc1MRxlQutKkvSGAzOOgMpAellSRaLc=;
 b=ivHSwjH/3ddPO4pc1k16Snqgq75y+l0Ex+dxGyamzjMA1gyZBP8V3//dRmd5oz5xz6
 x6I+fDFV4bYLRrDOLo0FKwWufXrqf9mboU1A/3vxswwWohUfeyDNC6Tv10+PiGWF5uB3
 n7BL0WdLr7gY9eq6gjn2zh9ApdeMTHO3+tsKQmoSGTUD+KGUPCzAiPNY6bddlMKGAeuU
 Y/G/TmXvwtUNBX0n7xoaI2hzbNNLbHz8pKgP2DHWkh2eaHwEuHwWNDh87NEDWprnbfWM
 PbLAby8n9RFgv9T/Df0FZ+s8/kPn4Gvhb+ro8b+YmSmdRuPVJ9ieDUIM9LhCZu8+ek7Q
 OQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uR1FwK2EE/Bvqc1MRxlQutKkvSGAzOOgMpAellSRaLc=;
 b=O9HpMcu8c0uZOO8PLlyq4e6xJor5wXWyMK/RSjECcx25vw2fcw1Y0nB/fEwCD2GaK0
 e3qMKpjKRaBmfHnCOdiemEQrC3FYZ6d3m/kDS5++b2pNxF0L5YzbAChD779TlU3uL5J4
 2lFSbO0uz3+HyCrTNIaXsoiQZugLMiBFKGtwpQuxeWvaTtP++2Fe0O4vNEfN9+ZFPKNv
 Vbr3P4tas5OwPRgkm4GE7Op9OoDdee+MnBKadzLbDBqR84usgTKZWImmWJm9JlpDziQD
 kGCFz6Bd77Do67xQWaMFQfPBodiS+n4vJkPASF4sAATR9ToX8oDNr4kYCZHWW+dmCut6
 J7Jg==
X-Gm-Message-State: AOAM533KFLgucFdW5XpB6i6jHVpJDEcrR6n/LxtA0K6yyv3HzQLalthD
 qPt5SkLhWNzoEKr0wmE/KoElPYIk
X-Google-Smtp-Source: ABdhPJyTZXY9V47mNFYeFpvuFapz5jwSauHAkIP7+nW+/nNz+3oFTI0oeiqobtZU0xnsrmNbnf8KWw==
X-Received: by 2002:ac8:3483:: with SMTP id w3mr5011271qtb.330.1590701739300; 
 Thu, 28 May 2020 14:35:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: use IP discovery table for renoir
Date: Thu, 28 May 2020 17:35:26 -0400
Message-Id: <20200528213529.673145-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528213529.673145-1-alexander.deucher@amd.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
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

Rather than relying on gpu info firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

Can someone test this on renoir?

 drivers/gpu/drm/amd/amdgpu/soc15.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c7c9e07962b9..623745b2d8b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -670,14 +670,25 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 
 int soc15_set_ip_blocks(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* Set IP register base before any HW register access */
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_RAVEN:
-	case CHIP_RENOIR:
 		vega10_reg_base_init(adev);
 		break;
+	case CHIP_RENOIR:
+		if (amdgpu_discovery) {
+			r = amdgpu_discovery_reg_base_init(adev);
+			if (r) {
+				DRM_WARN("failed to init reg base from ip discovery table, "
+					 "fallback to legacy init method\n");
+				vega10_reg_base_init(adev);
+			}
+		}
+		break;
 	case CHIP_VEGA20:
 		vega20_reg_base_init(adev);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
