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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE5C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632E220897
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQtxFWba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F6C26E288;
	Mon,  1 Jun 2020 18:03:45 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB7C56E27F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:43 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c14so8916005qka.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VTIyVdfd+cqp4dRjIB/e/oiBOB7+U5yzJ7kfohNs3II=;
 b=hQtxFWbaJ6+X5cv7s/iWhIL7og0VBg7yewVFniaZLwVVWokD71rvvoN2YL9nUX/AEn
 4BEmXL6GKFzxaVx2b7X7rKyuPn2pFxHDFbLJWrB75PunyBYJPgVC+HWLL8n8RMmLQjzA
 GDqhsXXIfPj5IKlYlxc5Yqt1rx1LCTFcITIBh5nUsQkyF5FGg7m/H/zBdAdinJFAkXd9
 +mcx8sqF6VKBOpfBNtO4XujsAwNMUi3pPzSBB60gmWAzbksTUol3gAtJ9zOMhRBCVrzz
 BUST0n3ydvvSIux9X+tkVIUGT9HqOy3P48JK/BLRQcx9Q/nZUWz7aV/oc1qS2atN/L63
 /tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VTIyVdfd+cqp4dRjIB/e/oiBOB7+U5yzJ7kfohNs3II=;
 b=sADBoJddy3pfhPMoFWwaaIt6RiOZCKZ3CrhFBrDVn4NeT38SjhKyIk1on2mlqmxBmw
 BSpm9lNKbf/UFFLwb/Ux2x3nzUG4vqqInItiSbdrMx01ujSl172BNSVIDHS8Q2b1esEx
 9LLIvVJOgEPFyq8OyvP4bFhtHt8M/Se0r94ap5gt1f/nH5VbKt+ltMjTnqA80+q8R1gX
 SH1rlXrCMNmfBJH7LxWNRwZBaGCiaYnAv7A9jAn6MqIwVbmqIfbmXj5wHAkMSnDDYG1v
 jdHf9PvnXXNiJ2XFKxwgsWjTFOTSU20zn+F520ziHFt8sSjkFtDAJL5p0e38bfbHCADt
 Jj8Q==
X-Gm-Message-State: AOAM531zdBTIF/ef7L7cmHz+q17GMT9yXDmAC7bn+uVxgT2dTOS8P8pa
 V940dy5vasCP2q8v9eO+ODdEcF/h
X-Google-Smtp-Source: ABdhPJw7rKuqKkxH/BTfqjebGMzkjCtZfdIsUfG2lTlIJj+iZTK21L5JDXbE7oGnVTr20Vd10IcFMA==
X-Received: by 2002:a37:be43:: with SMTP id o64mr20448623qkf.322.1591034622700; 
 Mon, 01 Jun 2020 11:03:42 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 039/207] drm/amd/powerplay: enable LCLK DPM for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:51 -0400
Message-Id: <20200601180239.1267430-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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

Enable LCLK DPM for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 662a95585c27..e4bbd282eede 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -45,6 +45,7 @@
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
 	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
 	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
+	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
 	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
 	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
@@ -285,6 +286,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
 
+	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
