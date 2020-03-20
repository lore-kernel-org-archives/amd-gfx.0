Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12876C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD32720767
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B14X64iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD32720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F76E6E1F9;
	Fri, 20 Mar 2020 18:27:55 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AAE6EB62
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:27:53 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id c19so3701877pfo.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kI+Q6FfWWu87tcsu4oGbduYzIzLf+nyR/LbQw11ZgHM=;
 b=B14X64izSDUPeiLy6UkRWlg8+o3q4b2F3UbBSzBJnIyoCxK8iJacizVaT9sMlOA5hE
 U9tARtQcYtWzeag/K9eTVVb0bJAnbay8c0cKJ+xQetGokrUGV+1rFb/SgJeoDiCZAYmI
 1mPhAUorTJqnAQ7r6OO08NdjUu1c5hEn8NjSBjCohijMGLAUgnlvHusaX8vYc+vmKzAo
 fgAaPROg6PMRZUsZAVmUcUsgXRmRjRBCG4Rf30tafymku1li3TOTvgEKXrC5mqssHCan
 ciInfx8sfYQfzbQcvMhyWZzXu+wKnYkfSsQ3qJBk1B33kLuKtLGP7xoI8GjQzQQjE2Iw
 JEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kI+Q6FfWWu87tcsu4oGbduYzIzLf+nyR/LbQw11ZgHM=;
 b=nwZclkDxZHItILhzT7v2XjTQOIv0U3VwfY2o0P0XF6xEOFJ0SWHsq+o1/ilow7boa1
 DQBK0Br8JSsq5A7UpC/1bF/61uczWo47kwhHvU4SNOCRhzSTnxyF2q3hxF5GLdZ5cG8T
 udKiqPpDwGMeoqyUCAV0I1WyZTwyF0MZtuvOPFfOhmfxzgaPip8P+zLkf5qjhqhy8H4v
 35bzPLyfsmjq/ptzTYt5kA4spwUlnLSiS+LMwOdVIItKQ0613Ao551zYqr29vfl/04eW
 fz2bJaQouZiHh94vD77Ij66vB2S7F5p4eLl82qvU9sCsyF0dawwtB2FdzyJQMTgIrNdp
 WuRQ==
X-Gm-Message-State: ANhLgQ2RpXao0sH4OjbcKIijAtdb2VRQjDO/6YeGooMs/x35XUA1ZoOr
 ILSpm0XtE+yLbNDVjMwfS2khXnQa
X-Google-Smtp-Source: ADFU+vuEShCUle12dhKcVt0p9PhIwv2PEJfNjtez0eAdbseud4X6LI2h6pTGV/qKrx8H/8G1eGI4TA==
X-Received: by 2002:aa7:8610:: with SMTP id p16mr5136047pfn.11.1584728873277; 
 Fri, 20 Mar 2020 11:27:53 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id v185sm6233850pfv.32.2020.03.20.11.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 11:27:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu/swSMU: use the smu11 power source helper for
 navi1x
Date: Fri, 20 Mar 2020 14:27:22 -0400
Message-Id: <20200320182727.3805-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320182727.3805-1-alexander.deucher@amd.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mcoffin13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The smu_v11_0 version works for navi1x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d66dfa7410b6..a23eaac28095 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2369,6 +2369,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_pptable_power_limit = navi10_get_pptable_power_limit,
 	.run_btc = navi10_run_btc,
 	.disable_umc_cdr_12gbps_workaround = navi10_disable_umc_cdr_12gbps_workaround,
+	.set_power_source = smu_v11_0_set_power_source,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
