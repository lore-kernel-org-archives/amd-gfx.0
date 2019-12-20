Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B4C2D0C8
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7286220866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 20:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2p/AuXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7286220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE326ECA4;
	Fri, 20 Dec 2019 20:13:46 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250256ECA4
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 20:13:46 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id f136so887425ybg.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/1vsNT9pI2jyTOkY0oy3E+WjGKQ5NBf071fPWDhXiBo=;
 b=I2p/AuXcdMAiYuzCZJ7HxW5peTFbi10x2PmNgzfublM2oaETY5gnC/EO33ftM8csPX
 qI2LTFOKA/AurFEwZLKjnsdECkPwU5OvKp8CkMQHyG7hXbgcnQPg5GHW2mJLCrjaUOtM
 au77wxZziW2OZsmodHeihj1pMT1rty9jFRBlSYxja5Xo6+FIb+VdCZovH1aMGA703jLq
 th00CqMPvBsceJbkiPxsGoYDfqSvAf90FHX6BNvnf0EtFxQ0RejJgdNSqyRO3a/MSV+6
 yZ1YbiqDNJC9QgPPNUixszF2LLQOKfDf0+GZwOf4YN+R0dmyzW5E4Q/Ux+K6DyMAj1b8
 eurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/1vsNT9pI2jyTOkY0oy3E+WjGKQ5NBf071fPWDhXiBo=;
 b=PU37pqeWfCEjdNQzKaeLCed7twez7aS8TS1BJaB+MSsDJUbR6ZyQViuaT9wUoChlwK
 XBr4OadcIRq9FTeFnrvMx9okeUtWbTTikHWUOfxWc+/X3N8WFw/uvwUQa2apgO1cPAt7
 MhsZWZhY9kA4JvpebsMUaHYjh91bDC95Gepzk0ImMCHbTpphgBFxfJZjGewMku7fr0NB
 0Rxsb5TRsqVMWFd7sH3/XOCAIUVtWnAQzGQKfuFZJRFH3AaV9IA22WIvV5Ng2WEcF2yI
 6QnjsCeaKQWp7pijc7bTf8PC6FJNIOP5x7K0SJr6P9fGBatNVgTbPG7j4wchwPBvHrgh
 W9BA==
X-Gm-Message-State: APjAAAX0uLs2Kd+B1AiZNAYFHq8KRt2B4FpJLtKyjeAesNWBS0KWP5bV
 ZJV4nnDJNv159VOlQEEYAwQ5CfDZ
X-Google-Smtp-Source: APXvYqxsZ4fcdyxHOSxBc9bW1eeVW0xhC/3v85rXDqpTQPu0qHs5DRxau5GCG471Fw9A8BP1AcTxtQ==
X-Received: by 2002:a25:7649:: with SMTP id r70mr12198874ybc.125.1576872825129; 
 Fri, 20 Dec 2019 12:13:45 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e186sm4208564ywb.73.2019.12.20.12.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 12:13:44 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/smu: add peak profile support for navi12
Date: Fri, 20 Dec 2019 15:13:36 -0500
Message-Id: <20191220201336.1083364-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220201336.1083364-1-alexander.deucher@amd.com>
References: <20191220201336.1083364-1-alexander.deucher@amd.com>
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

Add defined peak sclk for navi12 peak profile mode.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index c33744a0d46b..106434689ec5 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1628,6 +1628,9 @@ static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 			break;
 		}
 		break;
+	case CHIP_NAVI12:
+		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
+		break;
 	default:
 		ret = smu_get_dpm_level_count(smu, SMU_SCLK, &sclk_level);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
index ec03c7992f6d..f109401c2ee8 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
@@ -33,6 +33,8 @@
 #define NAVI14_UMD_PSTATE_PEAK_XTX_GFXCLK     (1717)
 #define NAVI14_UMD_PSTATE_PEAK_XL_GFXCLK      (1448)
 
+#define NAVI12_UMD_PSTATE_PEAK_GFXCLK     (1100)
+
 #define NAVI10_VOLTAGE_SCALE (4)
 
 #define smnPCIE_LC_SPEED_CNTL			0x11140290
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
