Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938FCC43446
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6513620787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBogIQLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6513620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5206ECFA;
	Thu, 16 Jul 2020 21:23:34 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE456ECFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k6so8661827wrn.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D8zHBqQShFenOhn5sUdTCaXue2kUqd5or1RvllBciTM=;
 b=FBogIQLSwtT5j4rLRwi2fey8R46JpS5cIv+GKxtuKbxo9gk009uoD5oX+Z0M5OMhGO
 RdnY+O4GshXH0fw1PxpPufR3V4t0rhFRxHIz3J2I8fUZBLTDsDg/jSjzsBXUK4+TYChB
 u3YWMBRFLGFgrP5Jn9/CBgQx6zEVrxKHRVPmDJQ1leN7I31OH+fpZgswRn2q9vRtm2ad
 +LaQpnKjRezjsqnmkoqxPo6qCPVzti2Y4yu6UyGwkFbZbvJRSUR3llVHA8ZFM1j+giwJ
 2vNTaj834wXhs9EyBlNamLwfJ3K92NFNhtO/3hk6i2o173XamPeiIeBbt2uch5Ta1cjd
 PXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D8zHBqQShFenOhn5sUdTCaXue2kUqd5or1RvllBciTM=;
 b=FXL/u1+qprRsPp4pzLFQs1t5oEqU5jDrEpCq1jbB/N9oWlMqB5waWlAX2TkGA3K5Q5
 /WE3uhKtDfkHB/o18upxp2aKwUsFYNt7nFWpepg+me2h9N2bABBsXG0SSSj9f/CPTCll
 0HMu1664dFYTbBvYPImKzuZM2I1HpLWTbIqzlU8tvz/wQNV4ZVeFc9/Lmb6JBVXVUGpi
 570oFXSMfQ95WdleGK5b7MozIS1/I0w/1LX7A2d0TJEmHvcOHcC5IM30gUMcI0ESiRrl
 l7YyoGW+cerZuiJGaRVy5QuV0wUchatbPUbZHJWA2dVQSNGZv5Ei5Wtama5jXn/2HDGJ
 l56g==
X-Gm-Message-State: AOAM533oSyJm5sNHfKsv2C8TAhOUqmSgCDsQvv+eBPa68hgLSRGk9K0j
 KCoTf2XJ4DrkV9Vs6iR1eYWZtz/Bx28=
X-Google-Smtp-Source: ABdhPJxO6ODspyUZW6vptiMhVSDR7x4Vb74Vbw6ZvfhRxXycrHnbLETSjrilXvLPvrZVsumRpkh6RA==
X-Received: by 2002:adf:82b8:: with SMTP id 53mr7394967wrc.172.1594934611094; 
 Thu, 16 Jul 2020 14:23:31 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:30 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE6
 specific .cursor_lock
Date: Thu, 16 Jul 2020 23:22:46 +0200
Message-Id: <20200716212251.1539094-23-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
kernel WARNING due to use of .cursor_lock = dce_pipe_control_lock inherited by dce110

[How]
DCE6 set .cursor_lock = dce60_pipe_control_lock

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index 37bd91883926..66e5a1ba2a58 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -424,6 +424,7 @@ void dce60_hw_sequencer_construct(struct dc *dc)
 
 	dc->hwseq->funcs.enable_display_power_gating = dce100_enable_display_power_gating;
 	dc->hwss.apply_ctx_for_surface = dce60_apply_ctx_for_surface;
+	dc->hwss.cursor_lock = dce60_pipe_control_lock;
 	dc->hwss.pipe_control_lock = dce60_pipe_control_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
