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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED05C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976102073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSJqs/GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976102073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464406E31C;
	Mon,  1 Jun 2020 18:21:49 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0526E326
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:48 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id b27so10008738qka.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+QkeHmhqtYQedXJaT9A58drE7RMz11vsM2Cx6j3+0ck=;
 b=nSJqs/GMEoOwR+bJR7iBLctJWn9MuJrrU24d9Wlh2zDluTzYq0ZkANJ/RVxYHtO3Sd
 Le7p27FW0J5gohc5cngL7PUgczfvgAJpJ//1Aukir8DYLSnleqv1Kbae7vFzBnwOk7Et
 bZyBCiLHY1rIZIBae4JbZJvZ72Ngfn5YZ3p7bJ2pWrw0eIjM5ZgYPaIdOyy1t50dSVSp
 m+K4FePiGV4kZBMVMmP1umc9N5D71bJ3C3Jo3/O23LGJkF2VluAYRd96AIWfDNmAIYAu
 7zxETVmRxKBmF74aWw+hz4dZUMO0Z93nz5G1rPOKJlFZKeQ4cWa67hhKpQHjqLggo8pp
 ZaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+QkeHmhqtYQedXJaT9A58drE7RMz11vsM2Cx6j3+0ck=;
 b=onV/u6I8yUpWObc1RwW5q1XQqioTckm38aweNkqZXtcSiF0ql0PIl5m31MLiJLXfvd
 mbeAcPm2Qv1DeSljQVWXxqsYmYT+Htgx4pPXmIDiH6VuLIp4qNTlrpV+kX9rcqV0maVT
 WwQ9fxktOdwbEXagsY2A1BECDCbcTyoMhYBU1+UoEq0PJ3pG53r9naNMYzkOmIDD5ejn
 W97CvfU9EqZHw2k6Xn2Wynf1XJPn2UKq2AelwUhEJejK5HIjywbpHIX36vrvt1t910k1
 oPiZXpJU1LLoC+naAZ8QLEoalmw9MTMuIZUAhvWP37QCKekYEY1GRXAcJHjwgvBVPT6E
 Ov1w==
X-Gm-Message-State: AOAM530XSFydh8UyR296rl43pdjjcplKF80NTSHnfk3duRrOylN29TOZ
 HXi3OEzgKGd8XcM9lgCnEyFwIxU2
X-Google-Smtp-Source: ABdhPJzGlTwwKdXNoF4Fzm1+fZosnHUXSnnWA8HLQ0HVsv03ywNAGbMUsSUVN7F+n9edRZZQdO2zxA==
X-Received: by 2002:a37:6851:: with SMTP id d78mr20957326qkc.86.1591035707514; 
 Mon, 01 Jun 2020 11:21:47 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 122/207] drm/amd/powerplay: enable FCLK DS for sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:29 -0400
Message-Id: <20200601182054.1267858-33-alexander.deucher@amd.com>
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

From: Likun Gao <Likun.Gao@amd.com>

Enable the feature of FCLK Deep Sleep for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 6824cc804083..2d844569ed8d 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -296,6 +296,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
