Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 22:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B1B64D9A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 22:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B1B64D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436E26E18F;
	Fri, 12 Feb 2021 22:30:58 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C966D6E18F;
 Fri, 12 Feb 2021 22:30:57 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id r21so1025339wrr.9;
 Fri, 12 Feb 2021 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9QKKgUIftIeYqbiriObdSxl5cutFeWXHD6E91Aammm0=;
 b=Ov37xpKpS/dqvPUj0UdW7mQGBeT7eJedSgdlgUros03H/eAfSvrRFwIHC33q+QUTED
 Lo6dADg+IF4IRdbAUILp0OLPFQjUtKv8G9mhSiSJRNrTNuTFjbmrRSnBAdTfbyW9Cx7p
 s4YYy+B9hFETofeLXHUKUVhEgsidINYgeRjOZlODW5j0kZwfKA9tKWlg+ctBG8ina0p5
 c3ruMeh0t0FMN7XaBwojMjxfI86MeDPZI/dcOKoD+8rMxze/5Igu6iRQbVWpPQ63Ud9A
 qBf5f/4c1ZAb7be0QRVKnyvfMaKzWY8DIDiQU4bHeu8SHemwysxUsiz9KAjIi2wZfaQk
 yKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9QKKgUIftIeYqbiriObdSxl5cutFeWXHD6E91Aammm0=;
 b=CcUXHreQXihtcQ2m+VhOTuioBdvwnBPsv5Od4kIYHFSK2YbvwCLW/836+T2mBHJmTX
 hmykkE9qKrK2w/3A4N7P5iggHXL9rtS0ahumchrUecc6c8GY41/R59LhXZNbTp3/Q13N
 h9vyLCCpVA0newS1M8ig2+Dc8lr8qT5DN+N9ZZo8zaUwQcOtClWAWwNiKCVO7tqBS7W/
 oL3myyp+Q7mu0yEL3nUZdlJg0Kg7YMd6v5Esm0uSg32n556lW1g4G5ZaFLvSXbF/IdSX
 hvAhUmU++U7VWPCWl2LSZqysBzaflS8jTkZ5sqylsVdDS0a3OakND1wQkOowoBLCKovB
 G2vg==
X-Gm-Message-State: AOAM533Bt4ybaLpzNk+3PJHf9RTTweC3Y2SCb8ChN5334HIMWvNTUmwF
 cwUCuVa79GiKsfcy3qg+qJmpsBb7ajg=
X-Google-Smtp-Source: ABdhPJwlMyeNaWRAAoA7IgRC9Ml2zRuZPJzNlBh++PPePsibG3IbC0bCL0r57TXLAsozQeJwLFH96Q==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr5898025wrq.25.1613169056244; 
 Fri, 12 Feb 2021 14:30:56 -0800 (PST)
Received: from twisty.localdomain
 (dynamic-2a01-0c23-7c92-db00-6cbb-50d4-b91e-5b37.c23.pool.telefonica.de.
 [2a01:c23:7c92:db00:6cbb:50d4:b91e:5b37])
 by smtp.gmail.com with ESMTPSA id v15sm13785312wra.61.2021.02.12.14.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Feb 2021 14:30:55 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Allow spatial dither to 10 bpc on all !=
 DCE-11.0.
Date: Fri, 12 Feb 2021 23:29:54 +0100
Message-Id: <20210212222954.6510-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
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
Cc: alexander.deucher@amd.com, Alex Deucher <alexdeucher@gmail.com>,
 mario.kleiner.de@gmail.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Spatial dithering to 10 bpc depth was disabled for all DCE's.
Restrict this to DCE-11.0, but allow it on other DCE's.

Testing on DCE-8.3 and DCE-11.2 did not show any obvious ill
effects, but a measureable precision improvement (via colorimeter)
when displaying a fp16 framebuffer to a 10 bpc DP or HDMI connected
HDR-10 monitor.

Alex suggests this may have been a workaround for some DCE-11.0
Carrizo and Stoney Asics, so lets try to restrict this to DCE 11.0.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 4600231da6cb..4ed886cdb8d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -216,9 +216,12 @@ static void set_spatial_dither(
 	REG_UPDATE(FMT_BIT_DEPTH_CONTROL,
 		FMT_TEMPORAL_DITHER_EN, 0);
 
-	/* no 10bpc on DCE11*/
-	if (params->flags.SPATIAL_DITHER_ENABLED == 0 ||
-		params->flags.SPATIAL_DITHER_DEPTH == 2)
+	if (params->flags.SPATIAL_DITHER_ENABLED == 0)
+		return;
+
+	/* No dithering to 10 bpc on DCE-11.0 */
+	if (params->flags.SPATIAL_DITHER_DEPTH == 2 &&
+		opp110->base.ctx->dce_version == DCE_VERSION_11_0)
 		return;
 
 	/* only use FRAME_COUNTER_MAX if frameRandom == 1*/
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
