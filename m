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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F920C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633252053B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBQvoyW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633252053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB4589CD3;
	Tue, 17 Dec 2019 14:55:19 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC02D89CD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 14:55:16 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id b145so4484205yba.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OmYKjJ2reoygVRwJ0fFziVHZvzfHi9bGZM94LdxhKUc=;
 b=SBQvoyW1BQbEdxbvvmvEO8b5GnAAhRl55TBeaGvvXHjQP084SIxiEOKqXzCgp0ez9X
 vabgsMDIW4IbszasDWDgmPlWGOrydWqn7tmO+wobJlZJFqZ4EWk0UWEf6QWc6cbBhNsX
 2ivTuKpLAUEybKQ5iu2D2I9H4KrCH3i6gY2hgJxmLthlrV10+jysA7IxR55px+CtbOan
 LXDVwbS8UKMIMQdjzbVARHGrfXTsQ7w8Mbp7JPIXYfELay49DC8pwzXTe4/7F8LYgBKW
 wl99LCllZ5oX8A+rBlQGSquqtzqW4cLRLE8wY7lzeoZUC0FKPkscM2KdslbTwikLDDhi
 Aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OmYKjJ2reoygVRwJ0fFziVHZvzfHi9bGZM94LdxhKUc=;
 b=AQljMqqofjgYVwgLh67hp3Ejf9gMyW23pBqiruDDY1t/FtdSyXKd6uHsaniIguCiG+
 eBToM0vnzgN8DJZniOvQqxPjpFHUbboIz7Qrluu5fYKqFYBqb4ZQaoAjOgQeLimycc4A
 wSF+sy/ttY4fOufbflCmoEAxQeCw1vnDCfiEJvA9HjSRMDjeX/XFqoA95VGSw5e+6u8G
 O5a2K/3lC05ExGezlhEo0E3TN+KYMmmrG5498NNUcw3zVOV6iKjlw2Uz6Aa5EkjNMgbf
 A9BJHNURIg/dLULdA76FRCDmbJExECMgUy4wUhvHNIhhUPubBPR4POeiHwQtfFEIj3Fx
 ltdQ==
X-Gm-Message-State: APjAAAW/KaALauXVKAzszg3urlvr5u+r1KgpYHndAnRqOg2phy8Ziu1W
 sCMJhDeBYP2t7pW08w3g0Gwzpta0
X-Google-Smtp-Source: APXvYqyBkGuiTlG6Wmn9CgJ9bWGtLRpLq6NKBkcsIaivolgAzOBUCAXuVjUufN5xY7xTic5RHwzWZg==
X-Received: by 2002:a25:2496:: with SMTP id
 k144mr25110382ybk.129.1576594515975; 
 Tue, 17 Dec 2019 06:55:15 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j11sm9978146ywg.37.2019.12.17.06.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 06:55:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu/smu: add metrics table lock for arcturus
Date: Tue, 17 Dec 2019 09:55:02 -0500
Message-Id: <20191217145505.1319348-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217145505.1319348-1-alexander.deucher@amd.com>
References: <20191217145505.1319348-1-alexander.deucher@amd.com>
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

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 17eeb546c550..bd5bb7040638 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -867,6 +867,7 @@ static int arcturus_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
 	     time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
@@ -879,6 +880,7 @@ static int arcturus_get_metrics_table(struct smu_context *smu,
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
