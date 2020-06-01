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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC019C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FB12073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFyn/nKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FB12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4836E339;
	Mon,  1 Jun 2020 18:22:09 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ABF6E339
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:08 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id c12so8438230qtq.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xaogy5qpnU8hL/13vdeWv0LGi93JoYli3IC999AtRA=;
 b=kFyn/nKzFn37hyZkrTNsIjz/l/8FnqkUE20+4/nyp6AlkGXcXl+vURGpm4kfKYfFNf
 JWHe0y711YgoGehBjpvyW6Q0m5cGTD/jQZ+PHfTdiiK8CbtDfZQIYXBTrRYKB/C16q7w
 fHZCO/75g6+MA4od7He1Oe/6150VZIz7YcotEZl83JRgizLfiEzXlHjB0QGrrkujdEqE
 5sFk1Oqx5C0eaKf2lFhpCK87zpkU32tolmqL2hXdqIAA0CT2GUatPPhTuC2jfMv1DOVf
 1sDTpbt3+KO45xXbLQDstFBMxXyYtdGXdgABf84Z8tK878YTjpiofc98TiNcZRKCgkrc
 lCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1xaogy5qpnU8hL/13vdeWv0LGi93JoYli3IC999AtRA=;
 b=UBKPD3rcsysp+pOMS4FOmrd/rpX4b2pqtZSpQEZMFisxv1ZbgVs0j04Qjm9woFYIkm
 rEca6kniVRxEp6Kah8yjApf33IEEiPP7L6HYZHAa9vDDaUpV7VrlyR7t3o/lpHlmhBkj
 PbD2QyPltodjhiXHg4BhGXkIbymns3yC8iUWposb3U5XPTfwZUYk2xd/8eqKhI5b+QYk
 3/2/J2sTAY8O9mU3xUz1eBncoa65GJhYgWDVhosvFFbL2uCpP1NOG1jbrHWkCkoIMrHq
 s+HOadGwlo5K50yXPL4Kgmtxwym7eIDeWmb/Eplhdtx0kcbkIrr+EjXHFnYFjMAd0l4f
 9Akg==
X-Gm-Message-State: AOAM532YlJR9+028NjXUMpj7h3P3eCxBdjB4d9a4slyzWWSMegp2UdnS
 St1aEIWDlyidJnfi98SJWvmM1UGe
X-Google-Smtp-Source: ABdhPJzJi8PX+U4Q0QqApHyJlglQwi/2LqMIWne3N8RLnaxhknFV9DhzutZhuAJWKenHbOLSVxLcCQ==
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr15946736qtb.158.1591035727012; 
 Mon, 01 Jun 2020 11:22:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 138/207] drm/amd/powerplay: enable RSMU SMN PG for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:45 -0400
Message-Id: <20200601182054.1267858-49-alexander.deucher@amd.com>
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

Enable RSMU SMN PG for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 45707772e755..9ac562b7c5cf 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -303,6 +303,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
+				| FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
 				| FEATURE_MASK(FEATURE_VR0HOT_BIT)
 				| FEATURE_MASK(FEATURE_PPT_BIT)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
