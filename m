Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0ADC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 17:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F63E2076A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 17:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBAyIqnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F63E2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82E6EC11;
	Fri, 10 Jul 2020 17:49:11 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF586EC11
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 17:49:09 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e13so6103078qkg.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pRcvt1baZnQgHZk0DARKFv0agOqWz3oU1m80M0+Stjw=;
 b=KBAyIqnAAWCZUjml/4eWPixjuZpVJwDSlzZdjz84Qq9n0zd4O8LY+x41fGBI3TQ5oZ
 DB4UVkA8XlEtv9LbHiXLqTy3xY/QAkvsCJoD1Al4/hmoDCHx9fsGsQzvGSJ088J2SCt8
 ccynlPTdwd6A1N/JBxGjI2DNAUdqC8l5RnsR7HKJYz8sYPOAulqawAr2OOZmtetTOoh+
 Zr/gjdlgMwe1IM6m9Gd8j2dHLfYn0cOVW7RSN8b3HGQsznwxFxRlalAK0QkqAP93maUU
 W96rAt6pBF84K3s6G5z+MgUvYVGgW2kg1gdXi57DXXEpcpwfW5gwsHPdjdBRmDZk/mal
 mScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pRcvt1baZnQgHZk0DARKFv0agOqWz3oU1m80M0+Stjw=;
 b=nqMat0alPHKDGPc4mGVC5wqRw9AF/XvyWmiWhg94JvZKNCV6gZwU/NqiVy2zih12xu
 3wM0xpW3zS6iC5xcg5DWeiCkSmD7CLASOcY6263fuv/8bJ+V3bT9ryf3gJ7T50kMmokQ
 IApNTvKSeGNwd3Etf4CtBK5Bq12xjCGt29xRs3tgAz6d1ltqVTgzgg5FExushBtCw/HK
 HCp0SPOjYpWDKfj04BJl6MOIusYdqzcleEZrJ0It2mtts/dDOJ6aeBeKkrPyLNVTVWE7
 vi3ppnIXLbVXxz0MVZzZpO2Gm077FOGHEGC0GW07qOWtU+phX9k3qV8n2jZmPJZqfL2r
 b2EA==
X-Gm-Message-State: AOAM530iV/OlIeBNUcAqtjczwaDRvbGiZQ1ve9zaHRH9LfqMuMlS3v2A
 +JAZ6qSmUEcvSCjX9SrKqR6fA0aLkZrmQg==
X-Google-Smtp-Source: ABdhPJzEeTc8UhG6HlXF8OTSadzrRh4ghS4iBsYdy2Njr/57nqLlsLbJ+QZJC1ql5wiYLhGtpPqdpg==
X-Received: by 2002:a05:620a:a46:: with SMTP id
 j6mr70126584qka.30.1594403348734; 
 Fri, 10 Jul 2020 10:49:08 -0700 (PDT)
Received: from brihaspati.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t5sm8396972qkh.46.2020.07.10.10.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 10:49:08 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove leftover comment
Date: Fri, 10 Jul 2020 19:51:03 +0200
Message-Id: <20200710175103.10238-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 394e9a14c63d58e0f (drm/amdgpu: Need to set the baco cap before baco reset)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..59c974630991 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -986,9 +986,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
 
-	/* Just return false for soc15 GPUs.  Reset does not seem to
-	 * be necessary.
-	 */
 	if (!amdgpu_passthrough(adev))
 		return false;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
