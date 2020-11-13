Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0ABC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 07:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AC720797
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 07:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIV3/W0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AC720797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FC56E41B;
	Fri, 13 Nov 2020 07:23:48 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6F46E41B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 07:23:48 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id p10so7669616ile.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 23:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNszTgQlTBdbAOibjRbSp0oPdYvJPz/2t0PLk4StMio=;
 b=JIV3/W0aJVNclKhJG6L3JCGWGRUun2pNvW9qca/kzEHqbtc8VPqqEH0jNT4ZWfpl7M
 8pPp36j68rGU18CGM2mlbgaJy7CB/Tx7qgr7N9S779ohWl7WKzpYz8OR9654/GuwOYU3
 aa92D1MrQ80sl167rPqq+aaoTGLVi2tI0ufiCmSAz3t6VQKCgDjuyfov4AGNldOJ3RiR
 Bq4GJjxJPcJADvJEjwNqHJOrP+V2XJooysp33VAE1DXFOxud3s1NVAjP6gtatvtVQ1u/
 udxZN3TtNvaDY4PQ/Z+fm+y/DWMxUeQDlbfe+5hGOrFgtGu4QJtmiRNkWj/KYAegS8go
 tylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XNszTgQlTBdbAOibjRbSp0oPdYvJPz/2t0PLk4StMio=;
 b=tDazutG8Q2rqfXzsLPxedQHJhcF1RzWi43BaQHKOvbumNy/OHPFGpgiXMkVjz/+OO/
 unflNEe3r6spP4Irz0xyuW+QbVEq7DYcn/pBzMI7h+HXbEPfZrW36zv03NmbbxAGJBuW
 5UMGQRWvf328mcNoPxm68j/ojdaxmtgVDZqtgMSFbTkCKLt/jYsmonrDsgMXjpeilo2H
 2BR9h0aivuhQxhyEch/YtPtkWClKdiIHUX6yGYIZmcvMXG9KSP7aQ+EtkEEqQXm4BnE/
 7lX+0A5JFQZ6Xt7/UsEXexwN66zsJz1st7NbJ6fU9mB/r0avL2p2zUruuJ99+ZUX/paL
 tBAQ==
X-Gm-Message-State: AOAM530+xyYhUC0L0B7fUNAOihTcw8C4r/x/xtbYgU146sbDGRuLv28x
 tSYXDtbXJXfIkie/Hwm1Qg0lfiNG39Q=
X-Google-Smtp-Source: ABdhPJwJ5w+50vzX+X+MGhYO49CaCjhdAi/QRLta6RMnrc3kA8zAPItBLJZVA3dDS4HuwuLVSv4a5A==
X-Received: by 2002:a92:cc52:: with SMTP id t18mr910556ilq.124.1605252227800; 
 Thu, 12 Nov 2020 23:23:47 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id f73sm4751189ilh.7.2020.11.12.23.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 23:23:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add missing pflip irq for dcn2.0
Date: Fri, 13 Nov 2020 02:23:38 -0500
Message-Id: <20201113072338.223290-1-alexander.deucher@amd.com>
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

If we have more than 4 displays we will run
into dummy irq calls or flip timout issues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
index 2a1fea501f8c..3f1e7a196a23 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
@@ -299,8 +299,8 @@ irq_source_info_dcn20[DAL_IRQ_SOURCES_NUMBER] = {
 	pflip_int_entry(1),
 	pflip_int_entry(2),
 	pflip_int_entry(3),
-	[DC_IRQ_SOURCE_PFLIP5] = dummy_irq_entry(),
-	[DC_IRQ_SOURCE_PFLIP6] = dummy_irq_entry(),
+	pflip_int_entry(4),
+	pflip_int_entry(5),
 	[DC_IRQ_SOURCE_PFLIP_UNDERLAY0] = dummy_irq_entry(),
 	gpio_pad_int_entry(0),
 	gpio_pad_int_entry(1),
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
