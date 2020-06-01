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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4219BC433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF1E2085B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZgJFIJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF1E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B066E270;
	Mon,  1 Jun 2020 18:03:33 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D256E26C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:32 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g28so9216074qkl.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A1k4R4+Kqp9nx2m8HKTU+L4i5bqkLPGRW5j4LX6S7Hw=;
 b=TZgJFIJFzYCYT1k476+ky7sVq1YaD7RUOCpKsRO+/C7KmbFD6pcHhtcfZss8tc+Bzs
 nFmvd716STEMupW8Wpq1KacgFMQKSaUu91xCTxD+CsdeAE9KooW6RKGMttDn7BIRd5NT
 FQf8TOufpH0hb4t6tJbAxaUCT+xK5KdBfiFYLhI85/F3YdGraBAxiuxPovidDqWyM/Dd
 raG+hItLwhdwjFkOb/hD3EVDKdCnkL3oUXnJj6WtGLcrFL2tujcJrqj27Js0gtr1POG+
 Qi9rJtmh+1fUByioRKf7eS5JXANmQcZYfP/4GQ/OScWsk+NwWXHGDSZBIaipxAz2FFR3
 W2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1k4R4+Kqp9nx2m8HKTU+L4i5bqkLPGRW5j4LX6S7Hw=;
 b=gqyigJXKa9PoyFVDJTyPNDxcfC4Z6g8Nxox1PCIZIpEcaEuoEBCqFQrmloMRLZUjQD
 /J1LSxwYC06xzqecm4ofACIOdBm+8xMi4n68MghpIT6BoVe+s6klkrPsRGlxB/8o/Rrl
 X3DQAO8yuTeb+oAilJmiqvk22BDXOElWsdtvOVvJRfo5sU24oXIgIlvRVFZ+VmHsOwqm
 oJJxV35c7pjAsYzwluhTznnakmEqLdzjS9G4Ppz0tjJlmAUfB3cZ5kvBIN7sR1aWRT+x
 pJqfvX/2bEZ6ylewB1Oz2I8+mB9koWXVb2UgjG9pr5fUmTln8W7ynM0bHZiGl4rquSbF
 Klow==
X-Gm-Message-State: AOAM5315pof1JVcucZa60xS0SC+BrXrm2G0m9u4EtUJSfH9X2tX9kiWx
 /Vm3UnJWrWT1i0+++yhIvTvGUNbS
X-Google-Smtp-Source: ABdhPJwtf2wUTfo7OJ33ZnmCIT3MM84QTcdw+al0CXAZDRDcxph7+lt9l/+hma+AOEdk7pgKpWREXQ==
X-Received: by 2002:a37:a995:: with SMTP id
 s143mr20810036qke.147.1591034611781; 
 Mon, 01 Jun 2020 11:03:31 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 030/207] drm/amd/powerplay: enable Graphics Clock Deep Sleep
 for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:42 -0400
Message-Id: <20200601180239.1267430-27-alexander.deucher@amd.com>
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

Enable Graphics Clock Deep Sleep for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 75310858dc0c..82d38eb7ba58 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -269,7 +269,8 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	memset(feature_mask, 0, sizeof(uint32_t) * num);
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
-				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
+				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
+				| FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
