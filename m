Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5075C32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 04:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AD3206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 04:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJu3pLUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AD3206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23ED26E394;
	Thu,  9 Jan 2020 04:51:53 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0C56E393
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 04:51:51 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id k128so2478075ybc.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CDQax/XtePbVklOJjGOt/SyWNu1ANQkeUYL8IRcgGtI=;
 b=pJu3pLUjat8koPxiY+ZiL+Nti/cPyAkOZBleaABBJZPgNJ/6ieV2oWN6v06idadztj
 K108KrOxOFiSsNS3XNbak0WeD0qnnWfsrhF84rfO9GKdD1unhE+mXjVUTqpv5pInPN/M
 MENDV17Yt7yeEI5ANfZyhO0MBUJaZ4UdpHBS62USH0nuv/r5CMIUxjxyH3wBzHqwAqxI
 t1hwza2NPR7Rk9oiO8WncqXHhTir4P/XxEY4q6g5xlGz6IPfBUlnmdhRs7PWg1fXIS1d
 nudBx2ndRnpMqU81ZjtHT5jbC+SVda5Vw8y6dnKd84HypyF0YEX6tT+nmdISX8KhpDHX
 zgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CDQax/XtePbVklOJjGOt/SyWNu1ANQkeUYL8IRcgGtI=;
 b=kYem7Slo0NVhckTZfYyaW8TMdKcRNbk/i5F20rawvsD7l9fuHAeeIbJHey9wwNaT0h
 K77XKTw693R7MugNspXLcWi7F+RBHwsZMRTn/qDkK4wfFwdnmf3j5AiRRSc023VWdVkU
 qxn/v6S+KP46uXFljJAxBiCiFHdyPZBea/rxAqD92jPC4uwcPyzJ17lPPIth2XGTnNex
 gsFS1uo0776tO6fNNh2eqJulUJ2uCxSUk5O+pWWRgAsjNeP8RDolb4sBjNL79c/q57L1
 x4NDIWcseP35erWa3W4SDAnZeixxmEwh047Uq+T4iOzD/jGvsU73z3AmXIq2SADV24rk
 P84g==
X-Gm-Message-State: APjAAAVSSLBrHyi2mqw4h33zU0Dn1GyJYuzNxzh3pswfQv6jGXxagtbw
 TCYuMk3XlcjzZYDXP6Fl9c+CYZzU
X-Google-Smtp-Source: APXvYqzUTXdESzbvewCCEV12L6AyFPaMh2I3unmq6O05XwzrQgjKVfgSOmT8KBVSUPDmY+kHacYMNA==
X-Received: by 2002:a25:5984:: with SMTP id n126mr6814748ybb.347.1578545510316; 
 Wed, 08 Jan 2020 20:51:50 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t3sm2605221ywi.18.2020.01.08.20.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 20:51:49 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix a warning in get_sdma_rlc_reg_offset
Date: Wed,  8 Jan 2020 23:51:41 -0500
Message-Id: <20200109045141.635589-1-alexander.deucher@amd.com>
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

If a user specifies a non-existant sdma instance,
warn and return the offset for instance 0.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 2b26925623eb..1f9c6ef7567e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -75,6 +75,11 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 	uint32_t sdma_rlc_reg_offset;
 
 	switch (engine_id) {
+	default:
+		dev_warn(adev->dev,
+			 "Invalid sdma engine id (%d), using engine id 0\n",
+			 engine_id);
+		/* fall through */
 	case 0:
 		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
 				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
@@ -107,8 +112,6 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA7, 0,
 				mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL;
 		break;
-	default:
-		break;
 	}
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
