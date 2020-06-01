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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29728C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0399A20897
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxrREMNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0399A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B384B6E28B;
	Mon,  1 Jun 2020 18:03:46 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1B6E28A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:45 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id j32so8406510qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KgAwsNDJ30f0SjNgq0x8GNpsE8aVAzo4ce5yy5E8d2I=;
 b=CxrREMNNYE3LjeSoPJKJX96mDydwq/Y5AUv0tC/O97PgXhmUDcMmN+9wgUvOllfm7l
 KnRS3vNjZagGz7pPMwfkGLEPDKyk1rQ2RjWp8ct9+09RisLGt36Jv33Jlh6zwlZrGFgb
 Kcxl7MFL0pIolLzhFj+m0hwbUKdBKp3nlnOgWolgKd9QvQledQNv7fw7QMTIuOqfjHxX
 yW1QjKDWeAPEhS2O2NjZXnSO+Zvjlcf55sxAzN7/fm4aR8ufRObZOwnS1sX1NwXacdon
 23mO6TrppnpdPvc2lBMR2fJvdDXmtVNIbRnqlgVliJTPY3ubfF1JMLWG7s0d7fNp0Xze
 Ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KgAwsNDJ30f0SjNgq0x8GNpsE8aVAzo4ce5yy5E8d2I=;
 b=EidSzm9YPpW6I/vJUZMh2N+/E7iRk+tmArqq98u8fMhNduULGm/L4AoDebPNBF3GWb
 gMG4TxtlLiAjZ0d97YdPQXKnkCjgb2Aem1iicz99tyICO8m/aEw59qfsqwYzUfy+3U21
 l74Ek/s+HKmVho0+n0H3ZSjtCgIwcmHHl9ZgFHol8ynAuhGaRVRrm+0bcs4ZAD0lBBdr
 N7Sc/WvF7gMHw+vNY98JWIHQwrAsHKl8DZXjGsaoRbuxDfwxX4jQAHS3/eKCpwq2Sp/v
 Z5wSi/ulyKCotVsnF3vPgnCaiFcto4qEwakZaffwzBP8IhzxKWZiX4Ph5WhixLSJKw5i
 mfuQ==
X-Gm-Message-State: AOAM532niz/OB51SyTRY8ebWuwFpfcSZAJvGanz2+fDP8TdmeIf5w9nD
 DFTLfL/BIsHJdgDaoA3EHeI8BYYE
X-Google-Smtp-Source: ABdhPJwNVVx7CO2Z2oqoqDCCYMzIJ9cY/cUebVgFQ7niWD7sovMlzZayf9OANKdqsZlVMkStrAfySg==
X-Received: by 2002:ac8:a45:: with SMTP id f5mr20794962qti.116.1591034624824; 
 Mon, 01 Jun 2020 11:03:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 041/207] drm/amd/powerplay: enable Fan control for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:53 -0400
Message-Id: <20200601180239.1267430-38-alexander.deucher@amd.com>
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

Support for Advanced Fan Control (AFC+) for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 1c0dbc5b5d94..5e98f471297b 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -279,6 +279,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
+				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
 				| FEATURE_MASK(FEATURE_THERMAL_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
