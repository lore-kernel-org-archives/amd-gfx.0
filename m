Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE869C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA8520679
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbbZvpjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F60F6E988;
	Tue, 23 Jun 2020 09:42:03 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C026E988
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 09:42:02 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w1so18177593qkw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jvDh9QmlXNUwPFbwXeH2d1pf4kchJ2UpvdjqGXPR1lA=;
 b=lbbZvpjb8eOzFYdHDn0Zc0O5FjvVovYYE3r+/LrZoRSdh3YZz7EMcohUS/LbOIpgv5
 XQHAgcZ2kUJeKefbJaGt7/RRBhVgJM7BjDAgQyZQ80CjUcuAKoSF107KvCDQSNUj28ij
 HoMCzkvi7BJSSAh+6zSbzhD3OIyjMiADF4Jap75GVBCb2tLGaAowBVbmHumB0dWSv2tg
 ffPtSpliVaB/a8Wf6QDfmX2zXKdxvXCnE7dV5KQpy2xslk+r39n9vzwxjO5OgmfV69RY
 t8/a1VRG7kdwkIkN4HM5IFUTEjkm2WNQ2s4919f5qvYgmUXp/82KWOBCfjlP+9pypYxr
 g0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jvDh9QmlXNUwPFbwXeH2d1pf4kchJ2UpvdjqGXPR1lA=;
 b=nmgrWVh0V7JSBZQ6fmiygLMc2FFi41dzlovlRKbi7DE34BxlCWKttK0A5mPgs9oMOH
 qzKyzorzc1zeg/cSGDVp45gQ9XQYaH1x85XytQ1/qHWL0b+Tn4/wgg0tQwTxSP3tIrpu
 gqfVYjbdxgfVgc0IsA2tJJf+ltvAb8fvnfUDfRBmpHshpcrkCthzntKNrCna1F677dIb
 Ndu57Akmi0jjV/OtCADOUDlu8G0otWZfa0d3jjGwNrS8eSAkdvmfKzc8o9Xb2/HZwSBt
 rsPVYIM5T6EuUpHf1etu+ex9D485cS5etdUd6xlBUXoBAUqhd24msOFqNB61LLN5ogI6
 bdug==
X-Gm-Message-State: AOAM530kmnlP85tYT5qQfLBaNbUfHsC2d6oNDzwa1PEVTTVDH4iXacj/
 zQTH1VT70OncYcnXMz+7hzEGCWaGODRZ0g==
X-Google-Smtp-Source: ABdhPJwMEu/a1Lj1N4mYCnvu+SxZ5/8m3F41y+UqVsYPpYJUSRCffxW8F9CCBcTluMTJ7nEberDo8g==
X-Received: by 2002:ae9:f444:: with SMTP id z4mr6382641qkl.80.1592905321048;
 Tue, 23 Jun 2020 02:42:01 -0700 (PDT)
Received: from brihaspati.fritz.box (pd956781a.dip0.t-ipconnect.de.
 [217.86.120.26])
 by smtp.gmail.com with ESMTPSA id j25sm84519qki.65.2020.06.23.02.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 02:42:00 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd/powerplay: return current DCEFCLK on sysfs read
Date: Tue, 23 Jun 2020 11:43:27 +0200
Message-Id: <20200623094327.10824-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes incorrect output when reading pp_dpm_dcefclk sysfs.

Output before this patch:
cat /sys/devices/pci0000:<snip>/pp_dpm_dcefclk
0: 506Mhz
1: 42949671Mhz *
2: 1266Mhz

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 3 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 3 +++
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d93f8a43a96f..daeae14fd380 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -962,6 +962,9 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_FCLK:
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
+	case METRICS_CURR_DCEFCLK:
+		*value = metrics->CurrClock[PPCLK_DCEFCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		*value = metrics->AverageGfxclkFrequency;
 		break;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 6c2f582bad5d..42ade9df0d6a 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -613,6 +613,9 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_DCLK:
 		*value = metrics->CurrClock[PPCLK_DCLK];
 		break;
+	case METRICS_CURR_DCEFCLK:
+		*value = metrics->CurrClock[PPCLK_DCEFCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		*value = metrics->AverageGfxclkFrequency;
 		break;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 0957957a2cf5..1378dabb6463 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -605,6 +605,9 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_DCLK1:
 		*value = metrics->CurrClock[PPCLK_DCLK_1];
 		break;
+	case METRICS_CURR_DCEFCLK:
+		*value = metrics->CurrClock[PPCLK_DCEFCLK];
+		break;
 	case METRICS_AVERAGE_GFXCLK:
 		*value = metrics->AverageGfxclkFrequency;
 		break;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
