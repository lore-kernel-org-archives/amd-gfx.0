Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA007C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A86520770
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 15:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKvun6K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A86520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B788E6F89D;
	Fri, 23 Oct 2020 15:20:48 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4FA6F89D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 15:20:47 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id cv1so857892qvb.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uRg28vcVm2sMPMlEyPOdu5teJ0LB2XGEdkmzbkfePWw=;
 b=uKvun6K5AcvwlpjbGE4XmQIy5M+51+2878Vs90I8eiPzc94z2phr+EZqYsEdY4xKG2
 mVpRwNcXMbv2vj/SSnSW+8wR9+bdggKIXg3mhVHRJe7KWuI7y5nom5QsznCTTn+CIX/e
 anUTeLfgBgUud4Fp9ybZPNJvCoBNT1QoUX/teUokWE371FGdAX2m5kb6w4p9H+UO+05w
 4DRhMjw/bQ3XYVkNykGCzempbwkcorKV/3TgSAnRmAPZAiCuDCSiyfcXsgBCO7W8yUBV
 +Qq05zB8j2KE60bMH34vJvjkTR7SELNP03NrvZXdP+FBy1ZbNWZnJlCqm60jmJWXYKie
 Mb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uRg28vcVm2sMPMlEyPOdu5teJ0LB2XGEdkmzbkfePWw=;
 b=oG23/elieASI++U7uv/EbypYZttxT10gfecN8Iu58TZTAQmTn/DuUJ2talB80GDSSf
 0K98SIgsc4TP8BSmG8NTAkIK3EasbMvbFTpRlZRFutCe3CvxJRPS6pzh7WJ6X8zas+8e
 NK/ubJYedXZep1E5M0MH9x/nqV8bAyIERawq8iPEVbLdqtIPYqf1i9Wl/mT5F2mRYf2I
 Zw3PQbR0Js1QP/iZbcwBXF+xjTbUiFkv/J+AMoSvut1NDXJLJO1JaSi3doShTGgo8Etz
 2ACShYmxygEaE8f6bpL8Nf8st5qh234NQEUlv5GZS9CB5AdgmORtRJ1i9Zy2F10kVL7r
 1yVg==
X-Gm-Message-State: AOAM532qcWfdMiiqX2TdKY7J7HMg5TLwUGhEXEUpxOjePSul79OO1xr8
 C6BGHpyF/2ncVUv/nRmHa8JgHfxuc/U=
X-Google-Smtp-Source: ABdhPJxyCUEH3wSn1Nv0pvSb7eZ/6rW5AVK/OQZJ5EWyIDMDUuGZ9pL+bkP62T784WV5mHpDjTlVLw==
X-Received: by 2002:a05:6214:154c:: with SMTP id
 t12mr2684280qvw.53.1603466446466; 
 Fri, 23 Oct 2020 08:20:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id i20sm905824qkl.65.2020.10.23.08.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:20:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add mode2 reset support for vangogh
Date: Fri, 23 Oct 2020 11:20:31 -0400
Message-Id: <20201023152033.373128-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU reset is handled via SMU similar to previous APUs.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 145712a24b80..ec40117aa1c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -322,6 +322,11 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 
 }
 
+static int vangogh_mode2_reset(struct smu_context *smu)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 	.dpm_set_vcn_enable = vangogh_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = vangogh_dpm_set_jpeg_enable,
@@ -342,6 +347,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.mode2_reset = vangogh_mode2_reset,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
