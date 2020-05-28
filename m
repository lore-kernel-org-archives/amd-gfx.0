Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20947C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E261A206DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 21:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeFQ4ejY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E261A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981C06E7FE;
	Thu, 28 May 2020 21:35:45 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4A16E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 21:35:41 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 205so418414qkg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=591RdzoHFpNltjB/0pZKualOAJ1rl8Rl2iZsuE+8kO8=;
 b=oeFQ4ejYrk1u5RrmEilnM6OwPVDBGUvzhcBQls4tAfHDiOa6ialZxBhJKkYrPp9OKD
 SzSJB9qCrxNKc8G0pncxyJkEfX2qTixxSU8e/N2yDt8cLfjYzqe4zj8BQ+STn+PARHxD
 7tkep3iM/gqtSxv7r3N8S8p6+Xd3KmalYNvnIcpehaXfN114mh3QAPRMEEZIeaAic0w4
 vxADa1mS4BWSNEPhd7Lg6eHaiNMxcmQmaOgOM41qtnNgjS/UujOcVIW8Ra3L6mDMq8Jk
 CwiK9vh2rGexNEJqnkEe+lwRaxSsPEmXla6004zV8rBM50/9VYy1KU25pgkk1aRRXPSq
 2Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=591RdzoHFpNltjB/0pZKualOAJ1rl8Rl2iZsuE+8kO8=;
 b=aH3dFVkQOc3xrwBQodnpgOZyDyUsi6WqDXBcQ8R31ovtErDBNDQhFVCV8prfnBNfq4
 VnwiED9+BNN0ZeiyMH0I0PDeqPbOacIkXdYMmUB+V5s3sPRoOalMBM2jqom2lIfo8GXH
 gLtsyzdDLWiDBzXZQKoIgkJWhXzuukgckJjhKY4UmlvUgrszJOLDB7owB4Yu9Smg5NSz
 +83tyfM7bR4OyRAlKpqX2mfSK8nG/WC5dpZgj06e+Fh6YaDy4uSD+5O1OZPutbS6zMCU
 BOQcUrVystoNrl/ghkygwgWTU9aqZE+SiVp2/kZs0MDknk7jumuOGxHgLSz0ChVnktYB
 keog==
X-Gm-Message-State: AOAM531lqSzQG3Z+k5g27XOu/7BmEhapyo1EXCs7DUsY8+bZub49dv42
 TbLDSOD+dAZA6IgWD/uKexXWPTec
X-Google-Smtp-Source: ABdhPJyNTeQEdoqq9cuvrWW5pNCEvMs0umadgSGXegqJhar89G8RkEj6VACxavJ6HLU+gHsTLLS4Rw==
X-Received: by 2002:a37:72c7:: with SMTP id n190mr4638240qkc.270.1590701740343; 
 Thu, 28 May 2020 14:35:40 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k43sm7027851qtk.67.2020.05.28.14.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 14:35:39 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu/nv: allow access to SDMA status registers
Date: Thu, 28 May 2020 17:35:27 -0400
Message-Id: <20200528213529.673145-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200528213529.673145-1-alexander.deucher@amd.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
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

For access via ioctl for tools like umr and mesa.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6655dd2009b6..61eea26922ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -188,10 +188,8 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS_SE1)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS_SE2)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS_SE3)},
-#if 0	/* TODO: will set it when SDMA header is available */
 	{ SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_STATUS_REG)},
 	{ SOC15_REG_ENTRY(SDMA1, 0, mmSDMA1_STATUS_REG)},
-#endif
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_STAT)},
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2)},
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
