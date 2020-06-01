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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685592073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKPDDlb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685592073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BA86E364;
	Mon,  1 Jun 2020 18:22:40 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6526E364
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:39 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id w90so8476866qtd.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jNDTGw76hxbOzapoE442SbShLf8INDTzIjcyT3KGpXY=;
 b=MKPDDlb5db9M13c+ywIKnDh0QXeLGxLbgvQeEMpCluKSXboYISKtBYknV8KQi7MceM
 Om4TZqJQq/xILnwiYsX9ehbtncd/FXS2d+Kcu4oout6Yea/qfcRxAJrOV3e4s0eN7Nfg
 CD99DVIkQfQPaAasF45bphyqDCzmgjqRT+EOdWpIrM0grbCu5RDX1nJ0yluG1tdmgFBD
 68XnCECByA5x8n3lWdxA6SMdbt1ZPq2OX/jo3zWZ5at0nml5psMvo/xufd/bBccJOAkD
 RtsjRgEEQygP8gsi00wYMG3cVrnex77BrIYZpXmRafLNNO6IhGdUefoZQRBpawcEG7SW
 Sc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jNDTGw76hxbOzapoE442SbShLf8INDTzIjcyT3KGpXY=;
 b=iksbqHEWzmREqHnjdmqHHtXb1Mf9g314YBEUfaTkrIUyEtiuCtBDyIFh0CwCAiNTY/
 z11sghSJck41Uu0X52eOHA+66nceboFvM2zDpjW+XMXodHzMhfeBWSPVusmMw+Dh+V/U
 Wj6+Wz0PRWzXRBpWOTN+8gx/dOUOzS0vo/N2D7xv0UIeKCzoafrcpTrR1hzhwZem0Vdc
 YzkH3ng76J33ESRq+J6PR4LTA21XM2JdAwGXIxoIvTBejfLmLl9r6hOmCCQSUK6UFBmP
 seCwoeKoJmHYFxe+biOcPsg9ucdVHAPeG2I0M/kwI7IHmFzlV7GfcqMiKg/8DuZ7pxu3
 SwwA==
X-Gm-Message-State: AOAM5318TyFq4J6VsB4G4XoFtIzkWbktS9zFSEvGi/7T0hUkrXvV0//3
 PxGrH+BDFSdurdve2S9OGf38l8eK
X-Google-Smtp-Source: ABdhPJwEkxFoQWq+YCTDszIhGaVPNSSWStBiQhLndDitcZKAjt0xN4LC6EbptWGdBQV89AfAUsRnCw==
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr15948902qtb.158.1591035758279; 
 Mon, 01 Jun 2020 11:22:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 162/207] drm/amdgpu: only use one gfx pipe for Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:20:09 -0400
Message-Id: <20200601182054.1267858-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Only enable one gfx pipe for sienna_cichlid currently.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f0955b325798..cc1835cd0c91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -55,7 +55,7 @@
  * 2. Async ring
  */
 #define GFX10_NUM_GFX_RINGS_NV1X	1
-#define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	2
+#define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
 #define GFX10_MEC_HPD_SIZE	2048
 
 #define F32_CE_PROGRAM_RAM_SIZE		65536
@@ -4232,7 +4232,7 @@ static int gfx_v10_0_sw_init(void *handle)
 		break;
 	case CHIP_SIENNA_CICHLID:
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
