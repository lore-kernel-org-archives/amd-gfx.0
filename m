Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9EFC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 17:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782C564E00
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 17:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C564E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2E26E45D;
	Tue, 16 Feb 2021 17:29:07 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEDC6E45D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 17:29:06 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id q85so10125629qke.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7DEeVs62vfWCzirQNh5NnEJ27Jl/u/0zQjRDdBtxAhM=;
 b=SmFz7cJ8VPVbBwStcNL41YEdz8X3Ez1A1eLRxkjjky/I9uA9q4meSYPKDhTonWgNMG
 ulzqELSdxTINaoM3Ob3GHmOgOlERxIZbz7Jk52/NwNxRP9SD/XH0HuV/FODILqpCRO5z
 uZbFZ3ublBbLI8SKCz/UpOtns8vlIwYsih68gUg9x7+nHpNPfhurO/0UGTE+IhRFPThf
 Q8fVTVHNskMJqzHc4ZIsf4IEC9CRY7x50Rqsfh+4WgvoDsRFr7DBRCkbf5ScvOrC8Sp5
 Z6Obmbh8pMNBTIQBw9iQEaCDbCumFFfr0EcU3hF0ByEZj7tYpYY7u7CpVtZPdroLECE2
 bFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7DEeVs62vfWCzirQNh5NnEJ27Jl/u/0zQjRDdBtxAhM=;
 b=eIWQpwS+lIUXdr33vDit3My4t0vTZYOvVvAsrxWIe5DfKUBo9ZholsbihnhIfBNyTJ
 6ZjepKLlNIR6UiamPpxlVS43OfRRteU35UkvYJ77+0hRUSx4WWpfN99aDWvp2ZIEZf3H
 G8HdnkOrYRpBTC+wx9JvASUvPgxtlG7Z0SdzzU1mT0SSsCJ5PZDNSarmM5cQTQev3f3o
 UCohQMhSRyyo+oU3UaPr4X2LBOy1RhPm6YVxmFgSq9h9p2HflYCJlz7G+JcJUF5Mdz6T
 lTXfR9nn8r2XbnJaYyJJw9os/W5xVUdqBzt7+AS+tR65HDGfo8AiX+RzGqoE8zAX7Dxp
 I3LQ==
X-Gm-Message-State: AOAM531qvx8thgPfP8lsLsVGFPVR2+FU5XdeW8/4JM2Eehwhm28sZhrT
 yUGlUSPZzvH7nJuemp/4EvLfN09tbGQ=
X-Google-Smtp-Source: ABdhPJxNbf0W0NuBBeNpIqzGCJnGugYMqUxdW/XC8C8ZqRtH0BtjXHYHUV1gZz99ForaLlqvip6seg==
X-Received: by 2002:a37:8a04:: with SMTP id m4mr20524884qkd.78.1613496545084; 
 Tue, 16 Feb 2021 09:29:05 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id 16sm12806066qtz.17.2021.02.16.09.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 09:29:04 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x
Date: Tue, 16 Feb 2021 12:28:54 -0500
Message-Id: <20210216172854.1738806-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Igor Kravchenko <Igor.Kravchenko@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit 098214999c8f added fetching of the AUX_DPHY register
values from the vbios, but it also changed the default values
in the case when there are no values in the vbios.  This causes
problems with displays with high refresh rates.  To fix this,
switch back to the original default value for AUX_DPHY_TX_CONTROL.

Fixes: 098214999c8f ("drm/amd/display: Read VBIOS Golden Settings Tbl")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1426
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Igor Kravchenko <Igor.Kravchenko@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index fa013496e26b..2f9bfaeaba8d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -341,8 +341,7 @@ void enc2_hw_init(struct link_encoder *enc)
 	} else {
 		AUX_REG_WRITE(AUX_DPHY_RX_CONTROL0, 0x103d1110);
 
-		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c4d);
-
+		AUX_REG_WRITE(AUX_DPHY_TX_CONTROL, 0x21c7a);
 	}
 
 	//AUX_DPHY_TX_REF_CONTROL'AUX_TX_REF_DIV HW default is 0x32;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
