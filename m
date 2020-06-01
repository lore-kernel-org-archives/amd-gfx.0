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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BEC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB4320B80
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvmLL9nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB4320B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F806E27A;
	Mon,  1 Jun 2020 18:03:36 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01E5D6E284
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:35 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w1so9953493qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2CVK8dxmX2BZikYN6juVRr5Ls4D35SI8beIUrhBXWCg=;
 b=XvmLL9nqRgaIUSWjXVzmYhOB+BhyTno3h6k6mhaOmeOrXShCCmnCtG0CkQcsSdXI2x
 rXUgCBnDdo9s60IKXrJ4VTdSYUNjjMlYQBgcqODnQFxlrE00zULTIuh5HT8Y9FCOrZMg
 sDlFpSxCOUbJ5PthAQe4LmOO92g9WIdNPD396l8d/nEKB31FjZcRe+4svhXkvwMLh5ND
 sY6mRi3FkmYOnlUSwMLoaatKb8fTTanqci5CiFLPRYieKXo4IbzcN6QpmrNFWm58gPm+
 vYktv4rI+bk6C2ig2MmURAbi0RIQvLddeS/VElSQXtEw8PJ0dhMPaBdsYQ7x4jR+3wlS
 Fl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2CVK8dxmX2BZikYN6juVRr5Ls4D35SI8beIUrhBXWCg=;
 b=UMQZ7TzTjBisfoSocaNfYM28RE4ZWNjE7bCedMYjPUEyoSNfbtZS0Wx8s12oM//BkE
 wHrhKdOrKWyC0QNoxkuS4DMVpaB5DQTRxvWCrCDxp/mKSo6TKbpO5GEDBUHKC9iDd70V
 0RarlJ3u/BYht+X4KSKKZeYkYwVM1BVQow/ylCBMEAO4wkdA1zT94nCvg1BAClUKx8dA
 0f55cL8z8FqmZw4iLcu8oPnbT9K0aH4bUWJN+IzIkoAwB+oRC1jPskMBn2oewnksjngY
 Mnmyw5/7CEij0rBG92m3ficIUlFgovPDbnI3vW6oaZT1lHxlnYo1IQiPtL2aFcjFi1rD
 Nh7g==
X-Gm-Message-State: AOAM532F7SF8d+QMSvp+Xd1dKSX6/A69OhwRMtKU4aUrS02PHT4JYWP7
 L8au824ibaifkhL/92YeeCbBy023
X-Google-Smtp-Source: ABdhPJw2Z7gB8eduhoj/2vgC8T81A2DTNUvFZUbXLpNMNgEcJfsz7vLzkRNJMCn4OAbDiTu/59i+dA==
X-Received: by 2002:a37:be43:: with SMTP id o64mr20447980qkf.322.1591034614004; 
 Mon, 01 Jun 2020 11:03:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:33 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 032/207] drm/amdgpu/powerplay: set Thermal control for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:44 -0400
Message-Id: <20200601180239.1267430-29-alexander.deucher@amd.com>
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

Enable Auto Thermal Throttling for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index a046fb4db610..a96de546c19b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -271,7 +271,8 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_GFXCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
+				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
+				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
