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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB816C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956DD20825
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL3bIJ/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956DD20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555DE6E27C;
	Mon,  1 Jun 2020 18:03:40 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC2E6E283
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:38 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id j32so8406142qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ziAD5tZesxFOCj9QlfoQFnd0wXayz+YOlA8FFI+D4X8=;
 b=AL3bIJ/4lcUv5CoxhYsaar9IKa7Dpg9+yTIFeOwzUzXAMdBhIUu+bJlUq+y+oE2jBb
 0Rnlyhwm/clX/cjb1Ve6h/wCkjKEwrb1KjQ6D1TJfhRc/aMNSh6zkNWpAuL4YL79vaul
 CJtl71Nitlz+1rybY5Nur0RJEEUpF/SQaeFPplZ/jynuHEtpDOvvoXYAq+XJQmT24ztw
 77bE4qQAe/mGdpG0gtuvbSnsqaIRhqCbeOdmSCoXTYyi7Ju75p6jPY6jgQyPcrvioVga
 Nq1uGRCinnafwlEzcPMMn5WCz26e0H2Geb+eAguRat0TlT+Yif4WMS6i04HG6pkV8Kw4
 JRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ziAD5tZesxFOCj9QlfoQFnd0wXayz+YOlA8FFI+D4X8=;
 b=n0YUA8APf3xO9qcJ/qxRy3UjChZTJky27IGOp6+H2re1vL4+nwKHwXxb6mfTVGEkCY
 hlmfsfIfsU10iX9rMckOGg1eBYmeHFF0KMCy8CWWv6G7OQ3DxQ6ULFU/oEAoCbF9DuJD
 JLVPPuwrvC9Xy2Sr2+q2f2eagygYNpA6AoMp+L9fgvK+llSs0MBu4JBVRKVwbeSEdMa4
 qceycw+lGs/oz0OkLL1hzl0P/4RfyTdbGxQpCbU3Hpw7+D9O77Q8J4cjeJ/BKB0whn6g
 2KIEbVWPi3S8sdF8WQF/jUfyJTNJoTBKJgVPDCaBsvpb+l4Hgt3Aykj7UsJs7VoqpBpo
 7FUQ==
X-Gm-Message-State: AOAM532Eevd6Mx9a+YYXYRGZQn7pRbnhpJhbsIRLJ7iWwW6hUKei51wX
 PRcVYGiwOnN/JUsLyH2wpZWusoZ6
X-Google-Smtp-Source: ABdhPJxTfJR6zPI4374pM2e3itjRnPdM45+7pTYJKtMDN1SdZMoT4+H57oohBDubnYn9ZdpTjSGdAg==
X-Received: by 2002:ac8:4e50:: with SMTP id e16mr23637427qtw.149.1591034617790; 
 Mon, 01 Jun 2020 11:03:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 035/207] drm/amd/powerplay: Enable SOCCLK ULV for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:47 -0400
Message-Id: <20200601180239.1267430-32-alexander.deucher@amd.com>
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

Enable FW DSTATE for sienna_cichlid.
Enable DF CSTATE for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 49e157f2b39f..a91e6f753bea 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -272,6 +272,8 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
+				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
+				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
