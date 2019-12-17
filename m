Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3FC2D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D012146E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0bHkerk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D012146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9A46E12E;
	Tue, 17 Dec 2019 20:47:20 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20884898EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 20:47:19 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id x138so2479924ywd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JQ64xwakpk3OOwIcOfpxR+QW0/ppcttKX3ZuPWtUfCQ=;
 b=G0bHkerkwr7kuYVPrmOAP2W6feE6N+IswvesnoEteCvUvC5es+ikeffBulzXL5l84a
 wwdO6jZhstYRu6DRtAWaA2TLCZ5Ma5wZYLyjZN5Kw960LebzpJoeukQmsupuLS/HaWWQ
 +W42MLX9OamQH0oBccgDT6HULtBK1q6X23l9nM8JI0+LtnFY+e9SzQ0icK0BUjDMAXew
 xNlKeXeP+V7Medv/UoHAXFA2+d4ZgGVtWGEhYzRKglcQNAxgVN5Q5MiHIjptqnWTCB6m
 iUJULgPHG8EjJOVTgNmXgQ6G+m8sLoXbrkQFVwbD2iUXiVEbAI90AFutNHDU26GPGWk/
 9Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JQ64xwakpk3OOwIcOfpxR+QW0/ppcttKX3ZuPWtUfCQ=;
 b=lcIlHUxXGm32brKrlreUNyf0bjZ80ghORFqUslMQ4ubSbXHmGDahOm68teh+V/PZBL
 k0I6xVGHqpE2OIXD9DHnrKQPJ2sNdQ1vpsbSrPoHANDnUFo8UlbkktoJs0yJYlAC64CV
 7w+AP+ownGjI2imZ4iphaKpSlRqYfp0WwlWe8gkzEPqozPoZHQMs2rEAhXHv3dfeghx6
 ec9nYZ44vmbQo9sw+9pGmRMGNhkbGnEg0W1W/oeuKtCeMQvHtT3n4H75aR+oZE49lynH
 MxTjwGfZMiJqRdPxvXx3f9YQ9MONkdJmk9heSKGD/wpnM1MqopxQZxRRxUhKWl0BKPnf
 +A6w==
X-Gm-Message-State: APjAAAUsFMEBP0AhDikb47RoBz0B0VEZ8U20OsyfXjiXAT5gr6WTyNTo
 obS8/JlQN3Q0cPbopZrJYzWtulZ6
X-Google-Smtp-Source: APXvYqz1cUNLlCzPNnCW9LsJEbzM/RD+DwHw1Mf/t5g3d3H+YFQ0q0RDd2hsY2wZc7sVrj3L+HZEiw==
X-Received: by 2002:a81:3b92:: with SMTP id i140mr498278ywa.481.1576615638121; 
 Tue, 17 Dec 2019 12:47:18 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 189sm10711260ywc.16.2019.12.17.12.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 12:47:17 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for HDCP
Date: Tue, 17 Dec 2019 15:47:07 -0500
Message-Id: <20191217204707.2258744-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217204707.2258744-1-alexander.deucher@amd.com>
References: <20191217204707.2258744-1-alexander.deucher@amd.com>
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

ARM has a 2000us limit for udelay.  Switch to msleep.  This code
executes in a worker thread so shouldn't be an atomic context.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index bcbc0b8a9aa0..f730b94ac3c0 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -153,7 +153,7 @@ static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
 	uint8_t size;
-	uint16_t max_wait = 20000; // units of us
+	uint16_t max_wait = 20; // units of ms
 	uint16_t num_polls = 5;
 	uint16_t wait_time = max_wait / num_polls;
 
@@ -161,7 +161,7 @@ static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 		status = MOD_HDCP_STATUS_INVALID_OPERATION;
 	else
 		for (; num_polls; num_polls--) {
-			udelay(wait_time);
+			msleep(wait_time);
 
 			status = mod_hdcp_read_rxstatus(hdcp);
 			if (status != MOD_HDCP_STATUS_SUCCESS)
@@ -474,7 +474,7 @@ static enum mod_hdcp_status locality_check(struct mod_hdcp *hdcp,
 			 hdcp, "lc_init_write"))
 		goto out;
 	if (is_dp_hdcp(hdcp))
-		udelay(16000);
+		msleep(16);
 	else
 		if (!mod_hdcp_execute_and_set(poll_l_prime_available,
 				&input->l_prime_available_poll, &status,
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
