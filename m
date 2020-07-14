Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA01C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482C3223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLbCKOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482C3223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAAA6E848;
	Tue, 14 Jul 2020 18:24:36 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC676E842
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:34 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id l6so16509158qkc.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hvHyMhHmm5UaTRapNTLrAbDCBKCp5U4OWrVtzKFDRoY=;
 b=cbLbCKOaLPzjGcoVZaaZ2zgsRU0ykpM17uneVZhk1W6eAaIQcEDu0qEPcBncblxODk
 1XQlr/aqcUSywHUJuXVwb4ToofcxX/2lMnFSmM6nvZIjSdZfnDOWX4Pq5KqXv0YhLogZ
 aCQ2TXam4Z6dvWRryWMT1uJz8W5vNM2tiQlDtP9fXHO9SJNp7RILa01RSU6jMf9T6Hx5
 /fBCQueI7g8g0OunTZFU3vYlost6aNguXCt0fr7JVszUJwROm7z9cXr2rTmG9RTXqoya
 PjrZMjJiIg4lYDwSfWcBHNevwW4l06XO/HwBkRv27n9cT8WG2Pqt1H/ipzZndVuRM/lI
 z82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hvHyMhHmm5UaTRapNTLrAbDCBKCp5U4OWrVtzKFDRoY=;
 b=DPCpyNI72R/DYuAyQctmLTumjSalb2QrIM9w2tvHqjwxzfqJ3GCv9XHDEYxZWXgfxT
 LL4j6RpPWiNLJNekE8ixdR3iZmezazSYYO3KCt3bLZaVJhEIY9ZG8O9tLmgMd+DR+GMh
 ErQ2lxSHbucfbHZ5Me4sEd5pEL3VfTkhDOJaLUECwDVNicwijJUPYNoJ+PxjQAUflysm
 +7ke6eIXVNbwPuE5Jb0Bagif6tSrDWMOKxPheqsvZb4nNCuEZJ2WDCFv95ww+Jrz53z8
 VZ4lHSJxV1wLOXSkgTfgqhOaqxWZGfpYnEDC5aBWl6Mc7xZr6RUztozUJ6xImMbTW4On
 vS1A==
X-Gm-Message-State: AOAM5335y8GHydkLdvXAW7OTA9iPeUTeD3MFdty2OGaGdftsUxn7+gro
 aaIdBmGt+LOvbpf82Q61tKfrkPz2
X-Google-Smtp-Source: ABdhPJyO9mvAHGEGgq+Jiq3xW/dI7e0rn6uDZmzHSoH/EmUuK6CZ8tqhUta4S8YDiL013OhTPwFM8A==
X-Received: by 2002:a05:620a:567:: with SMTP id
 p7mr6004850qkp.232.1594751073413; 
 Tue, 14 Jul 2020 11:24:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/42] drm/amdgpu: force pa_sc_tile_steering_override to 0 for
 navy_flounder
Date: Tue, 14 Jul 2020 14:23:30 -0400
Message-Id: <20200714182353.2164930-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

pa_sc_tile_steering_override is only programmable for
gfx10.0/10.1/10.2, and navy_flounder has the same gfx10.3 IP
with sienna_cichlid.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 02645356f96f..2957bf780d79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4496,7 +4496,8 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 
 	/* for ASICs that integrates GFX v10.3
 	 * pa_sc_tile_steering_override should be set to 0 */
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		return 0;
 
 	/* init num_sc */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
