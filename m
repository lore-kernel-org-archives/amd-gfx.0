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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B2C2D0BF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E312082E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB9bu7Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E312082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5E96E157;
	Tue, 17 Dec 2019 21:45:58 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064A56E145
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:45:56 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id x14so1062425ybr.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qUjXfT/KO0e7SbCjvEgF0ppvtSuMdrt/2b8LZAiMUwI=;
 b=rB9bu7VapcIfkDOOdrEXZ5lwnoJMhNQgroPaOAgcNtusoSdWB5pNN2cpN1tDdMGS8m
 hS8D97Z5r+Cyx75ZSJYB0BWznACWJe/uE6OKggSqAtQOTIFYZb0zA4SXb13pdZDBjMUb
 D6o359aPqV8feSyxkIOV8j38a2TpnLDqyyxKkbi7lskhZkL7vWOeIMp97C9fTZf5IsAO
 Og5wTiGzwyVM5K9uvPSVRKb8B0ZCqOXMuNsHnCBelfYpPPeplW0phyNZDtxpFtIN6CGh
 Gb6CiUQ5lyR3WAr6jB7k9dDzJpSEEup+3MwMaNWLvHyw1bwdp+pfjAybTLLJ9Bcc60PD
 B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qUjXfT/KO0e7SbCjvEgF0ppvtSuMdrt/2b8LZAiMUwI=;
 b=gGX9waH+PAFX5eKLpbeXc0VhX4VlIefyzb0AMjUrnXEykIp8qcUCQD7qp8n+I0D8VK
 Uk62pcDgLAMNqwE0njOJpnSLP0r46WgL7QTzp0ny2oey00Cye7i9stHgcpEhR1OKNIRa
 chU1ZrWOBZWz3tH4jGHeZICg5Ikbvm4Eg9/xheTBc6UkClcWXBMFATj/KiN8wTVeyWQ5
 YXuR+lCzNIiVPHjLVaW76w6hGwAoVmuhlejWXToL3JB9srqJZgaV1cvp/Pm5n7Jv8ip5
 XEVGypryRY9TyqnXRZtIUFoVihb4XqUbAHbUSBiHUgdDwqE9TBplytPDw/vCI31mNHIp
 tEgg==
X-Gm-Message-State: APjAAAUbtEp2gK66/d0qAn0/oSYQquN/860IBAFo2DS4goRZUpnaf5AK
 W2gHAppG84BCfqI9IK27iiV1Av+K
X-Google-Smtp-Source: APXvYqzXTEM1u3FooZghrageMUNWmQFayZNNCZupYrUsrxYs/4aUPb5WxaaOcQ3HIMpA+tZfwcJLaA==
X-Received: by 2002:a5b:70d:: with SMTP id g13mr187918ybq.270.1576619154982;
 Tue, 17 Dec 2019 13:45:54 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c1sm32728ywe.67.2019.12.17.13.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:45:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/amdgpu/smu: add metrics table lock for navi (v2)
Date: Tue, 17 Dec 2019 16:45:41 -0500
Message-Id: <20191217214543.2285700-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217214543.2285700-1-alexander.deucher@amd.com>
References: <20191217214543.2285700-1-alexander.deucher@amd.com>
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

To protect access to the metrics table.

v2: unlock on error

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 7b42e72dc939..bf87e93b26fc 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -564,17 +564,20 @@ static int navi10_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(100))) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
+			mutex_unlock(&smu->metrics_lock);
 			return ret;
 		}
 		smu_table->metrics_time = jiffies;
 	}
 
 	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
 }
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
