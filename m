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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A71BC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD552082E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIBREYOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD552082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C1C6E145;
	Tue, 17 Dec 2019 21:45:56 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068E56E145
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:45:55 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id b186so623ywc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OQke6DgHxZjTIXoK3XtM2rnh0BpKcmLsrgzdc+5e2bs=;
 b=BIBREYOGRi7Snj0d8+/ZyVkWRiDi3yysvt6pI+TLPnJ4g7K5U2PBi6VBK9agbz9Fa7
 nid/BLbVgf7OQUwpsVOgD/8cBJ83jJy/TgSvbENzXu53L1robPzsLDmMHoAFgE5Ik5t5
 b4r9EE809LPMTnQXE5KY8DpRybI3tB1AuFCQmraP8nc4a1OZFdBI3DjwL0KqiNnzAfUg
 0Xw7r2WxylJIht2sIlttcTQY4oQlN2PBf6vwKlRDMTvpG8qDYPxDeLzddgk242ncpH2X
 idmb+8yB7OQfNjQTMAbJ9JAdUI60d5MDubBF78WWRlRNXVJ1swnGvGFxZ+kH4phC1Srl
 g7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OQke6DgHxZjTIXoK3XtM2rnh0BpKcmLsrgzdc+5e2bs=;
 b=WkXgsM49VQshpoUS/TB6DM5kIbY0pCrd/IzOfL3jXY/t8dnteq6DLKfJllSoISEpAf
 9Knzo5AEU4NGYAH2MdOQy9Ml5Nesdk9MtbAarH05ybunVVGuwMQv4YFfO1oaACWB2sRc
 LD2aUXjZ0+ycHyaz92usn6qBc3Op+wS2glvTtMoN3AXSc8dacv1/8lBG5FY4VN0B0ttC
 sSbUR13O3RbayybinVP1xR520GHDgynLm1mCNhatdw7vwHDHXvz0bbwSCYZMcGaG2C7p
 xvsRIEP1OxUULlRyKe6n8Dfj9UMV1bDaJ26wnh9XE8kJd58RShQCjdOlnVaZzcZIKoUd
 +mWA==
X-Gm-Message-State: APjAAAUKs1THKhxdU09ihcwUQ/I2s69CWYCjICt9Q/oOunPypWMsHUAU
 Nc6JQ5pbQq4hDk+ZpcWfTtiga3zD
X-Google-Smtp-Source: APXvYqzakK+m+6Gi2yqdL90QEAbq0cg5gMgcLeTooVoOh4b1ErEDa/SxC44HriFIzLEQtHy6FkbiKQ==
X-Received: by 2002:a81:6c4c:: with SMTP id h73mr720769ywc.489.1576619154032; 
 Tue, 17 Dec 2019 13:45:54 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c1sm32728ywe.67.2019.12.17.13.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:45:53 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/5] drm/amdgpu/smu: add metrics table lock for arcturus
 (v2)
Date: Tue, 17 Dec 2019 16:45:40 -0500
Message-Id: <20191217214543.2285700-2-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 17eeb546c550..be4ae0aea9a0 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -867,18 +867,21 @@ static int arcturus_get_metrics_table(struct smu_context *smu,
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time ||
 	     time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
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
