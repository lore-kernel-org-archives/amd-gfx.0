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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BEAC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD5D2082E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvSxebT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD5D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA236E156;
	Tue, 17 Dec 2019 21:46:00 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB4F6E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:45:57 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id b186so702ywc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=39U5V6v8ltDTcPx71AXPV/OoC9snyxAD99LZWYUVCEY=;
 b=KvSxebT3gzg93X24R44spEue/+A8oGJj5MTiStn1BznlVArq1Hz+ePYCH6QDHDwbrI
 p0q2uX23xeq2y7/ElvrlXZsmUJKHvYpYCg4zqHBAJzj95TDY1CcJlAgYNqaj4wUZJeOI
 2PHWMQsjZ/Tzy+TBUT5n7XqYgF+IKYDHAMbM9uu9G6yZvnF9IZkCR3u5EA5ENcE0iLkg
 Hos2W7zVNVnUOQ/FfmkCKmQqA1DmHkfEllqwIdbkPHcC5B6z8BqAXeng324BTMhh3LWH
 7oJFPmjo+Djpdr2iNBSMGNy3u9x69ojdZ467Z9Zzb8Wc4BaNHPEmkLeT0HgJhkiVu18l
 CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=39U5V6v8ltDTcPx71AXPV/OoC9snyxAD99LZWYUVCEY=;
 b=ZYIddKunpitUoNDxK/cDcnQkpRy8xDbGzCfqZojYzqYZH3VRxvarP21xunarbbFqqF
 e51ErFRGgap+x1UA5QkQDdAJ4Wr+sBaxMMa4UdnpEpm8DvIBg0UonTx77DtGVaQxhH5g
 kwRd1tA3gH1tg5PW99wTHZMFFl8tBocXBDbldco70dUPYXfU5zJOSFtqTnsq/fX/Wnff
 R0QR7THwT7bdkIXeV9wjXMoXEm7+aaSMM2pg0qnAqPG45uEjMn3VbsHrwAimGMmYQakB
 MP5hltw29G7ZLJoUIEjd0D211cZB/WDiVZM1KssYG9ZzM8TEkXZD5WEkAsD9aEo5d9F6
 V5kA==
X-Gm-Message-State: APjAAAX58jmPLzG9JdMptpM8leuVPkr/EOsU4qCyKEMTgpPCA77Y2OlR
 7U7mAz1+g29NM0aKcGak5ntmkx6F
X-Google-Smtp-Source: APXvYqxNJawVRuXmwlRB0zbLKVjy4VjtHe6lT+wnANbohTJv3T8FSyVIZq9UDqiNesjJpTOtrwB1rg==
X-Received: by 2002:a0d:dd47:: with SMTP id g68mr723158ywe.299.1576619156782; 
 Tue, 17 Dec 2019 13:45:56 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c1sm32728ywe.67.2019.12.17.13.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:45:56 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/5] drm/amdgpu/smu: add metrics table lock for vega20 (v2)
Date: Tue, 17 Dec 2019 16:45:43 -0500
Message-Id: <20191217214543.2285700-5-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 2b1c3f8a0415..250ff5aa1305 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1678,17 +1678,20 @@ static int vega20_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
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
