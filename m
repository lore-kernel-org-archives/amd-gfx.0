Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9246C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D67A206D9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reUqQGSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D67A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D216E499;
	Tue, 24 Nov 2020 16:53:08 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC746E499
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 16:53:06 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id 7so16580207qtp.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8ROJrOlhtT6thGSz0nvlRC0nfYZ8inHmeYwSH9eN/cE=;
 b=reUqQGSkp6Zo2iN8b98PltgQJVZ67YS+Mk+MI/8ersSAAYf9aFTN5r5Hx7hoeRN3P4
 ultQpWxY/zZr2EZhcGFCZ7lM1MO0O42PXAzI1/isP5RtMzE4pX4Q4UFFz4pwDEQ/gHF+
 JuOLqOdLuyE6I6+Tc8iek3y8O8nTIJMSFhwOzDldtOM2xTGbjxJqVPN/bIUOA9B6hODa
 ZPBWxAQIPA9c/goy35cG9bPWSRev2cdzlbHGgKvTQBavCpITA0LzZ1IjsrthputrHpYN
 4Imbva0CZoa3iggOzRFTMwUI6tNosxu+91Q4siNsLtYmj2Nc2Oiqx80aqkrH7TX7rVo+
 V+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8ROJrOlhtT6thGSz0nvlRC0nfYZ8inHmeYwSH9eN/cE=;
 b=aZ/EJzSrygPPG8Mf2fHO1B8TZ+Nrb8Fk3udq12aYTBBcmZNbYkyggATzZhayv9v5cy
 IR+rC8CaOgAEI2qwSQ7f7/UZruEgtunLKULJBJZS3fbaFhuJJEIc7WQYa77w2epotsls
 mzyvIPgRlnGAvItQLKv5lY9FlqURFKfRGa169IcNrnMIM4cGFGyvhFA7cugdZUI38Wz/
 XyT/fxfZFwcuyaThBMLLrt2IYUllV5KZTnR60ESD8F3jj6zqF7YRSeejI57pWjfuxujs
 YVI41AWuYModtRffmTnPOWXmokYz8zDWgDHfy+LdbNJU+OuRSSethtOcsWyOFrtOVfuN
 xTTA==
X-Gm-Message-State: AOAM531FWCJ9bGPOwQ5aJig1xsRaX2DhfVvM1+IwJXQesGfhkWuz24nH
 Yy5zVa36pDOPNzennsCdzjqfkKymaoc=
X-Google-Smtp-Source: ABdhPJxSkhh+YyNB7hy858mX7o3d/R5XBD0TzwDjsUpQgI8mRNKYs1kuy/KeWau6Eb95pf+JX7ij8g==
X-Received: by 2002:ac8:5411:: with SMTP id b17mr5168937qtq.281.1606236785615; 
 Tue, 24 Nov 2020 08:53:05 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id s68sm13332872qkc.43.2020.11.24.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 08:53:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: drop leftover function definition
Date: Tue, 24 Nov 2020 11:52:56 -0500
Message-Id: <20201124165256.1760556-1-alexander.deucher@amd.com>
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

No longer exists.

Fixes: fa7580010fde1b ("drm/amd/display: init soc bounding box for dcn3.01.")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 124ae5253d4b..7e95bd1e9e53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1223,8 +1223,6 @@ static const struct resource_create_funcs res_create_maximus_funcs = {
 	.create_hwseq = dcn301_hwseq_create,
 };
 
-static void dcn301_pp_smu_destroy(struct pp_smu_funcs **pp_smu);
-
 static void dcn301_destruct(struct dcn301_resource_pool *pool)
 {
 	unsigned int i;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
