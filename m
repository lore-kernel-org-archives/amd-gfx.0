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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E8C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F0E2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haeY/7i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F0E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0994C6E30E;
	Mon,  1 Jun 2020 18:21:33 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A886E30E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:31 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id n11so9998746qkn.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cidM2C22Yd2cDDgLmAraKk3OH6qJTtTRfGyePhPi924=;
 b=haeY/7i0ArUphfDGTGNzBRgGiCzC0mUgt2hCV3PjmcOoKeSKmwgEi4Ac6CxmXa5Tkj
 vd3/Z8c0M/vNhcxoMdnqPHX1puOvq5BLnqsgGixgtKxwDT2SjAOvN58+q1M2oyBqm1dT
 Ad8t2DnBo4LTr6zeg5BrJa5M/QZQtBYGD9hfcX82WtOXS5tDQ0tgrYEkKws9hZ31ERJ1
 UNzL2ROXqX9smvwBnhjWfSJZLe83lLKUzM2+2w+ugy1MSVIb7PiXsSdCaxwh+3MSwaBx
 OQ6eEJ/UFgBeUngimCuCVwG0Vwfo0hiHGkHy8pZM9fmVVPC9zvD7uZiXJAFwvKTJ8I32
 c4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cidM2C22Yd2cDDgLmAraKk3OH6qJTtTRfGyePhPi924=;
 b=HoD7DPpT2s1yYUCnhV32j0i0rrZBhKEdmJ4GQS3EGtMu/te61kldS+IAkbUaJbdkmj
 4PwA8gYUAeGfCMr4Mace40T7TNwHm7odyEZMJlhxcY11MzeHgDU0NVf/BAkpU+YseGdV
 HN9GnBDcTWAlvIkH67Nb9V7AP32GLETGM8Il2U7r332AUV4O3Xjiwzx86tUduhAzFitq
 D4tEsn39EEfaAPmWk1cTMg+sAOC1YiqWBcJ3y2huNkk6672aue3i/mLp/J8VudXpdm9C
 W9NDOzBGiTfAVxbQStWSVzYzwHfg11uxiGGCCBmhN0K0LFclV1CRjYADbQGfAKGxHBJj
 9guw==
X-Gm-Message-State: AOAM532bdtLW9GsRXZL9+lA5dNA+6McK+324kuhpyXm1MQDn0AuFapne
 1HvixULEU+Uhvu5vL60Z4kl7KM9t
X-Google-Smtp-Source: ABdhPJxPx82syqWslRqs0Dk6Xj8wRwOKhDrxg3c1ADn5+lI2Af0mpxeWd2icQp0NU1KfcmucUITWUw==
X-Received: by 2002:a05:620a:20d6:: with SMTP id
 f22mr20492960qka.294.1591035690977; 
 Mon, 01 Jun 2020 11:21:30 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:30 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 110/207] drm/amd/amdgpu: add athub ls support
Date: Mon,  1 Jun 2020 14:19:17 -0400
Message-Id: <20200601182054.1267858-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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

From: Kenneth Feng <kenneth.feng@amd.com>

athub ls is bounded with hdp ls,verified.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9559eaf25591..451557544b85 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -721,7 +721,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_HDP_MGCG |
 			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_IH_CG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x28;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
