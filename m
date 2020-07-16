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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB31C4345B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E096A20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFUHTfjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096A20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD12A6ED02;
	Thu, 16 Jul 2020 21:23:40 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3772B6ECFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id b6so8601699wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qdr8ouZMcbrLXpNsTNBc/AvAIsAR8D6kw7YzhRbkS4Q=;
 b=TFUHTfjpeUIwDN/IXtxvLeyViUSaBNFPbjieV3vtOgsXwtw8SSl5xXUaHj3faKm1Kt
 +SrrfgDK8vf+9hn1NmTwbHrpRRjGgDFOytQfJmsB12TVPitnaCauJzvULO0V1MfhamgJ
 nmOWH9Cat3nkBnH/lWdcmfCMizpLCmPoHCdtEhUu3eZF3bMf2WiTtpRVt48ed4JZ94Qz
 HK21HtmZS8uU1CfbYVvXTO82rJQG2dVYVdn2EfDvelAmX5V+eQbcqF1OVXSB39djIvIt
 VL1nkvbNEGfjT4Zzs3pMJnNzgMu26JsbsfFy6Qn1XrrUAP+hijIUlK6pKacsq08dZmkm
 asJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qdr8ouZMcbrLXpNsTNBc/AvAIsAR8D6kw7YzhRbkS4Q=;
 b=tIceJu7qOhWbjKHvcc5iafpgBjqlWtFmDOHBjideDqC0x3ZYuj96//wAeIHQgPdMfp
 uhoLigG7x0jlDB5eR1WAwYWeo4UXOucRLksrJT2znuBLJse78WEJBfcXfZ8jtEmeXDby
 8xZRXSgnTfJeruTDrFYsDhFVHfw5B4VH11Pn+Hm833f80ksW1nT2dwJoZtAyCPxI7I2Q
 LAfz7HOVhCgZy/WIqAM5oOcMVWveepfy/j1zXXdlWGHQVoMkIdVvTpsYGdaamFyQRGWz
 xxx5Ye4L4QIVXi9i7guZS/HFxLBrdiM2m98SKGoMGIEmlndX4O8edyiimz0p5OxkbAgz
 U9Ow==
X-Gm-Message-State: AOAM533xWGCgyK9uwE61KY2SOKQ6BfVrw0t+MBJrlN4qw4CKsmPqwPaY
 tpRD9xRmmq6yZoYrkw6pjQaM8LDaRZ8=
X-Google-Smtp-Source: ABdhPJyV+nuH/Mis+k0Ow74X96u5n/RRVNZQTk8YG5lPbdbJZ/4Ybld5BYYIL47CwzGyivd8fz5JAg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr6690272wro.406.1594934615539; 
 Thu, 16 Jul 2020 14:23:35 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:35 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 27/27] drm/amd/display: enable SI support in the Kconfig
 (v2)
Date: Thu, 16 Jul 2020 23:22:51 +0200
Message-Id: <20200716212251.1539094-28-issor.oruam@gmail.com>
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
All DCE6 specific code changes are guarded by CONFIG_DRM_AMD_DC_SI Kconfig option

[How]
(v1) CONFIG_DRM_AMD_DC_SI configuration option is added, default setting is disabled

(v2) Hainan is not supported, description updated accordingly

Tested with HD7750 (Cape Verde) and HD7950 (Tahiti)

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 34ae4f3a32f4..77569097a480 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -31,6 +31,14 @@ config DRM_AMD_DC_HDCP
 	help
 	  Choose this option if you want to support HDCP authentication.
 
+config DRM_AMD_DC_SI
+	bool "AMD DC support for Southern Islands ASICs"
+	default n
+	help
+	  Choose this option to enable new AMD DC support for SI asics
+	  by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
+	  Hainan is not supported by AMD DC and it has no physical DCE6.
+
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
 	depends on DRM_AMD_DC
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
