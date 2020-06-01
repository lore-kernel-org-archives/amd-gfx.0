Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1305C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB66A2077D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1Z9sc/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB66A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676AE6E28E;
	Mon,  1 Jun 2020 18:03:50 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011626E286
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:48 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id g18so8397990qtu.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/8OlrAN7aSza6Lzh2gzVtYu+SAfosIXb4M50/w1lkAY=;
 b=X1Z9sc/IBgsKnU+orIdwA0fQknbJhFkNjfNiaLnZwDoohBvcjZGSw3rgJK/1Ji2RWR
 FM0pO8LW6A+7M5MtzwhV5PaFZqtTAKG4HJY2EIiYUUCz3neDkiXM8deAVBHviI3Ot3YA
 sFCQhtp+8BTGzEVZ+paXDCSss0qss3Lje+tMNCOsDiozu2cv9DnlpybR8tIKileVLz9H
 UGBxVO5R8N0QRtWtIP88eCRYOoB98W9TJ1TI2sFZ1MVnuMI7oB6eRFkLZq4t65sBnCIo
 qZ8E5p3iEkYTytGoEH7ZPTT1RAw99m2Fodxe3MasKjLMxFe+39Ejg9mRZAuQx2mcIBoD
 RZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/8OlrAN7aSza6Lzh2gzVtYu+SAfosIXb4M50/w1lkAY=;
 b=ExNRkiryjT/Wd+M6NMcPGXf72Qh8HmaRaEVqsrrkr3yYBTpwpNRG19nxJILAkMpEJq
 7O6Fyx0x7t4IxRmwpDaVbL/5ZiDB85hgO6ajRkiKMrhGwkotuOLmcaPA/Gvxc4KoOfv7
 cbpR3MkueFlv50N6N1y+z2FszQTUIvbg5MKTRUlhBCOU4ySmUy1T8hhRcZoE4BmPNa2a
 iSQgLH1zYnUfsE+NOacFqf2/IAGSOCW1ISsYKY605jloBSzMA5pAN2eS2u3ifnErCCEl
 jiOrNDSV2ERWZXu1CJuQpakQMD33VjEZH8GhXeEGwuFlwHUA3PFbxnsr9GQOeyUkq3Fi
 7U6A==
X-Gm-Message-State: AOAM532BScgdR9Mp9vamn/9cK4+dr83lAKf0LGTDyVhx1dNiOJwaxITF
 DeZFX02xGmk0iYOsbc4I7sUqhEbF
X-Google-Smtp-Source: ABdhPJxfbdgEReAA3pnQWFj3Lt29HAg/1aOs9Ft0ASoxsr12V3ONUf03xs6tbDgh+HOc+baZS8iqiQ==
X-Received: by 2002:ac8:4d0e:: with SMTP id w14mr20705349qtv.266.1591034628010; 
 Mon, 01 Jun 2020 11:03:48 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 043/207] drm/amd/powerplay: enable PPT and TDC for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:55 -0400
Message-Id: <20200601180239.1267430-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable PPT and TDC for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8b59b2aba94a..5e2b01a565b3 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -299,6 +299,8 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
+				| FEATURE_MASK(FEATURE_PPT_BIT)
+				| FEATURE_MASK(FEATURE_TDC_BIT)
 				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
