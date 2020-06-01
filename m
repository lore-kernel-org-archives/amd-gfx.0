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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17113C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FBD2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTM/ojdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FBD2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77176E369;
	Mon,  1 Jun 2020 18:22:43 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0A46E369
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:42 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id q14so8224837qtr.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rcC8WtF5IMhT9GaWkJNIr4U0DSA2tM3h8fl7q2wniUo=;
 b=MTM/ojdh30d5FrwatyV8H/FY41F+ADcIHX29+sD5dTUCPu70dJJDGHYIMjlFpJGdR7
 5U1v0HJQPxe7JXrfPBaOa1Lbj5SM/8UXKeapHtdoCdhYxTNs3jpj4UvAqWrzvFYRIjaK
 +TgT8Brwr+LzBwoSHoQeb4X5O2vwsRq26mBuwWEhU6hKbUdOtMrKXtZPVW7Rq524MllU
 kzm4MrWExOLxxGY7vEwyKUAr7QWn4lbSNNCGaFarGqPGiScWpYRCeQukcbt8cbmH9TAY
 YVc53OL0Ve9DnGIhQuOJG/ABILc0+uY4JxDqDEDaeZnnzjCKC6hEAcH7sswZDA6wGWr7
 W6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcC8WtF5IMhT9GaWkJNIr4U0DSA2tM3h8fl7q2wniUo=;
 b=e9moSi3qguDT/Fvs0LSIeZU1DN7mtmfj7dgkA9clYFQ4zytKu2MCXN6nKxtTE0Y3jA
 DIF8ML+ydbC22/vEYFuxMo5pec8BiO2mMjbJvCX4JVCO4dEp5SCnWsOckFeKwvEC1NUr
 SP04Kk1BYmx/D3GGmnHCz42BnD2fsmxXnkwhLU0eZfSLOMdkU0ZQqAlLkksUtUjOAruE
 LzVXKFTQrarUWZGFAz/VsLWPzLvzCSBjoQFEwr6usFllMHodrXM4erUXVOVbKQzZVPa1
 FydzibyGvDymSsIOh57LIQ8oychPX3JcqPv98HfXTli7+Dsj2KaHCRbFNZW5ZKbVjj+n
 LVHg==
X-Gm-Message-State: AOAM5336Qi0oFLvEI/Ajz1lq4bRSg4B2dIVLdzM9eu/jEKToF0wftHLs
 /aw4ReOunPa/ecS/n9vQgBvGr6gg
X-Google-Smtp-Source: ABdhPJyXlFWNJAMhkxpLBXDIFvT+6lT/k+RBECoHT9dx1By4jkKisu7U7ux0DW9BNmBOrbiACwhNfg==
X-Received: by 2002:ac8:31f3:: with SMTP id i48mr23200827qte.128.1591035761479; 
 Mon, 01 Jun 2020 11:22:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 164/207] drm/amd/powerplay: support mclk socclk limit value
 set for sienna_cichlid.
Date: Mon,  1 Jun 2020 14:20:11 -0400
Message-Id: <20200601182054.1267858-75-alexander.deucher@amd.com>
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

Add support to force and unforce MCLK or SOCCLK to dpm limit value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 667c912e47fd..ef8532ff8e30 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -945,6 +945,8 @@ static int sienna_cichlid_force_dpm_limit_value(struct smu_context *smu, bool hi
 
 	enum smu_clk_type clks[] = {
 		SMU_GFXCLK,
+		SMU_MCLK,
+		SMU_SOCCLK,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
@@ -970,6 +972,8 @@ static int sienna_cichlid_unforce_dpm_levels(struct smu_context *smu)
 
 	enum smu_clk_type clks[] = {
 		SMU_GFXCLK,
+		SMU_MCLK,
+		SMU_SOCCLK,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
