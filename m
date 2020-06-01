Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C505C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653FA2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyzKHH4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653FA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D36389AB9;
	Mon,  1 Jun 2020 18:22:54 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCB389A86
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:53 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id q8so9987810qkm.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3WJkrhKqNBffb6wy30U3hUkopvpW969aMZ1/mOa2n/A=;
 b=qyzKHH4EJRDtna7RuE3iicP8X98NRstrH7I4N02okkWjYB2PVm0DpNIi/i/nhlNdKT
 ISDrx0eDoO46Ukx2MVfqDfsrnoZ5gxMt8MocL/BJlys+nTilfB5f3P3fqrngk4KOXWrS
 G2W/Gxk84fZOlUZVBnbtIbMrBIYVIVxGuBIRH41rc3nARcsGq3YGBfcvS0jQl10vKYlN
 R+iM3CC5HBD7CuKeBy+A2UpvPcrpDBD7wSBugskDs3HoFsJNLC+R7Hjq8TgAhBQAR6xj
 vHAG1t5+YxW5ePLCJBvYKKmDG7WdZ2pj0SmZ+lVbC09bFAMXcmBioXUJnOGCZxqMhli1
 h9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3WJkrhKqNBffb6wy30U3hUkopvpW969aMZ1/mOa2n/A=;
 b=s7t8ORCZiHm6A1BRe90z4GpP/Nn+t5zG+e1XpFNznho+NJB1hBqVk7fQEquP7hj3Jb
 ImgQomigEZ7Vf6wZ91Mi09/C4yp6uGaDSd2cw0HVc0Y3Y73hT3FhHPks6ozO4vujwQxC
 VeGruJpMCu3/CmcmM/BvWBDn0vO0Ax9eeDnjS/zp7iQepukNfN+xo6EjDRlnBccJ6rS2
 ERiN+Yg6E7/M+7k8BUc5yrGxHEkjiHGWkzxOctk5H73spIw0AzEGSwfnGeGx0Shy3Zp9
 Zjk61RTPBzcOtu/EzY33oY7sxRGejrLHv0mLZkbVLufYyxXkn3d7YyvdtJxU8WUq348r
 XdmA==
X-Gm-Message-State: AOAM533G85vqhuNZs8vpf1fdbmNs1ohoeMr26rODai7R/1ccYsc6N+Qj
 ckgBqwo68NfXKgG097BEtuclqw9G
X-Google-Smtp-Source: ABdhPJwKOghLd4IqnlsVR26sCpg7riXG60Q4F1GUekI016jlcwFSdEd54zO6GDDvX7vmk7JznuN4ZA==
X-Received: by 2002:a37:670c:: with SMTP id b12mr13604938qkc.195.1591035772182; 
 Mon, 01 Jun 2020 11:22:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 171/207] drm/amdgpu: update golden setting for sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:18 -0400
Message-Id: <20200601182054.1267858-82-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5ddce490247d..e9045dde5b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3079,8 +3079,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff, 0x00280400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x10f80988),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
