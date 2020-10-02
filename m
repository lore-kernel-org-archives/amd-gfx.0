Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6676C47423
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29274206CA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwOJ/2GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29274206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FC76E9AF;
	Fri,  2 Oct 2020 15:09:53 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E27C6E9AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:09:52 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id g72so1644601qke.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=onB2vq3W63FDjf0J8SvNCMs9S7XrOuGtB3+dIZPJLYg=;
 b=WwOJ/2GCBKoCnbSU2+h4VCAWP6P2e6IMyLj3tbvQ1m/KO6jaQFq1Pc6Zc0zSFVzslO
 D2o1PU4UIUUwIWOLkIjrAmdFUdDA7GCizBPchF98DrQ4UAbGFtPezoOGblmmD9iW17Jw
 HiaB41tY5aI9FpKd/Q1q8Fz7sUnadyUu3fT7Rw0lQGKOUAohYFE8Sv898Yv7xJNVd0q2
 WbX727LCXXnS4mq2X2zrxV5/ISJCuTJ3BjZMcDs6NN6HHVT7r801KTt5g5wLVJRiL6Xi
 oBJdxLWmHrkEePPKELMTMkogUpf9C0V0faetfVDzCZnJC6/lJwb05jPaHvmqVi/OV2Ao
 LSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=onB2vq3W63FDjf0J8SvNCMs9S7XrOuGtB3+dIZPJLYg=;
 b=ceel/ig7b3sr2xYBwPCvws5rmvNHqqYpkHWqpmy5l/5Ggk8vwnoW6aLAxXIS490fZK
 eXyu8voBCY7qluANyqiOuUp9yYd67vn6dudha7nTj2+3Htlr7r3dKt8QXSeXQjiIfdLA
 Nxy2pTvvKRvCTzxxErp3XCrcbhdQVb3C+lu0EHELR70sEuaFZ2RGQKXY4uVyYPMiiqpY
 +ICM90Oo+so0LJuEDd/ivqXDZri/lg7o9cz+u54sv4Hw2FnRZ0014Mso6vg3r+brf7BW
 Ns9tLVOFjuARjuzPBEIoj46WKatkDdg8HE0E9i4b1WYrHpLqslcYU3QbtHKCL/zSNkgx
 ymzg==
X-Gm-Message-State: AOAM531GwhmU/PXUtLt+1LqC+nbi3RXzMG5HuaXmCltU7+RB03UFRupQ
 5WBtxqbLPBwF47qDknn24QQHUKZ8axM=
X-Google-Smtp-Source: ABdhPJx6AwFLDUh319+O4VlZW5DzSYnqeeTy6LbWbJXKglpCDoa3k0E9TCKH9mIexwa7bUs0xrax5g==
X-Received: by 2002:a37:9d8e:: with SMTP id g136mr2575097qke.88.1601651391354; 
 Fri, 02 Oct 2020 08:09:51 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:09:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: add Green_Sardine APU flag
Date: Fri,  2 Oct 2020 11:09:34 -0400
Message-Id: <20201002150940.1103949-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

Will be used for Green_Sardine which is a new APU.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 10dc481ecbc4..06c1aabf10ce 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -45,6 +45,7 @@ enum amd_apu_flags {
 	AMD_APU_IS_RAVEN2 = 0x00000002UL,
 	AMD_APU_IS_PICASSO = 0x00000004UL,
 	AMD_APU_IS_RENOIR = 0x00000008UL,
+	AMD_APU_IS_GREEN_SARDINE = 0x00000010UL,
 };
 
 /**
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
