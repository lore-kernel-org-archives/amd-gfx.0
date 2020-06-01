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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23855C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8E02073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at8PAttz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8E02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02ED6E326;
	Mon,  1 Jun 2020 18:21:49 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418666E31E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:47 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id w1so10015714qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=31ZsmjOnXhXQuLa5Xm9oxdAhIsQqkKj3XG+qmO1GClA=;
 b=at8PAttz2scM1I9EixgFaxCccLx8pE/NtuSUMxhJVGQCUqV63X20ZHG4UP1pktqVp6
 OlfeB4Lrmf9UaiESOfUKkxDir/Vmb+voqEp+vK4Plwj8meC5xr+dINfdf1zA+/cjCcuW
 0yu2ctdDu8enliPOKRMLiGkufSXJ7KKeGBh4QCjzOffEBf8EmtPs1mI6invq8xIk0yJN
 afMWqKzV8e9JMsP3fsnrmbGmLW8wZ+YO3zFGC59FZn3jCyVAHjPKmyI4iogfpSwnKlj0
 n8iB7H6gbCUu1J1+T63NqytoQn/D7ljnaIC1Pl3M4F5jPCCYaym8rE3ABklMLxVxdnr3
 XcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=31ZsmjOnXhXQuLa5Xm9oxdAhIsQqkKj3XG+qmO1GClA=;
 b=Vr8g4JY1vGYLudrLB47iMhA2wlKv4HHFojO6bnnPJAxpyu+me6xV67E+RGk66otPZU
 3xmFxuuC0QiIcUVp+amK0QUx9j2xEQScFkm1SvM4RrxhX1XiNR2vOu60olm/bjhZifFd
 gRtPz8RVgmPIReInDASVACcys4SmGd+eHpd8E7HGOzDsSzFUzPcZFdANJAAwU+diLMU4
 eBhMQtMfZsFoXNPilUl3CkOig3fI4krdcgS9jVaAzytL9FlXdxWRIsFKIXQeeY+DvqhD
 yImgEARt5Q0BF8Uu9qhYHHkV0bscJZ4tFq6ZzqUfHyNnq4QqHqOanrgRAU4U39+hR2F7
 y87Q==
X-Gm-Message-State: AOAM533niqe+b5JjfMajFin0iAPmx3vpf3eBkhStJ62sA1s/8k0ZMHc8
 0R/zJ1sELmOzyfgKKvw11mzEsNaR
X-Google-Smtp-Source: ABdhPJz6GnsMbA4ojwqL6yv5GBufP4To70ef5E7HdO4hcWnemWsu1nU3q6z5ImIsCqvgeE3+3DUjoQ==
X-Received: by 2002:a37:9a87:: with SMTP id
 c129mr20878233qke.374.1591035706268; 
 Mon, 01 Jun 2020 11:21:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 121/207] drm/amd/powerplay: enable VR0HOT for sienna_cichlid
Date: Mon,  1 Jun 2020 14:19:28 -0400
Message-Id: <20200601182054.1267858-32-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable the feature of Voltage Regulator (VR) Hot for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 5e2b01a565b3..6824cc804083 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -299,6 +299,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
 				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
 				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
+				| FEATURE_MASK(FEATURE_VR0HOT_BIT)
 				| FEATURE_MASK(FEATURE_PPT_BIT)
 				| FEATURE_MASK(FEATURE_TDC_BIT)
 				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
