Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CEC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B96206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heWPlKYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B96206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CCA6F3C0;
	Tue, 28 Jan 2020 19:47:16 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FB66F3C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 19:47:15 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id t13so10866239qto.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/AX5SIWmveyNDwwxZFTOBj/Pe9QepHmy+0fUCBeNEWM=;
 b=heWPlKYRb9KXjZEWMyix4WTX2A8FXYZ6qSmUCFaYvZgpx4pvpjtQ5HBgDUTq9K8v3g
 ZBoP7pjWZoWJ/sscTUh9AL1JQecqD9f8yUKKRyCTl+jpgL7Y/Kxy0PRcihzCJ2kdk2k7
 J6/g0VSf6k4Id6slAuQPWXRiAUVQ1Bcl6dLUp1v6N8Gh9pwvjVsbXAjJ19IFp/HTxug5
 LnW4iqwTq+W1oA7GSIR9Mg0vITU/aUM447wZ3wnAuvoyoFflNSiFvHTwr5G4rA75OJRn
 YiA4gUodeGhMi+dtwo9UaQufndbfNViFJ85UIR+uM48uLD7nb9jmmH9iiLgjg8UkIeSN
 MGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/AX5SIWmveyNDwwxZFTOBj/Pe9QepHmy+0fUCBeNEWM=;
 b=p5GiBeGBkAQo8qi19PcB7NKntT7ouVLdNyJL1J3Yz6OpElf0iqjAS3rj4c1gfmbybH
 otqDIuU94OG+23Dhh2VS9C6l/pRnH3rx4j611+sjSiDG9yPz+OLdunBXvNRZKIkdj7nu
 H5hfPUhAUBH2c8/YeqqLBmHuI0Mwnh8fkJXVtsfmusuIaLGf2yXBaN8ZUkLpHMe5m/yK
 sykrpN7mOuDJh+0uGGwv15UsK0xcnbxyhXYOQBQlgA5/dquFHZavehKdMapO6WJc4j80
 eyVLQcxdEWjateHcRZ0zspx9Lf0Va0/kA+A6Dp5Ct2pnLX7dOxbmfFBqifxygqRizSVR
 r7TQ==
X-Gm-Message-State: APjAAAXoOaKpzzy6MOx3n0MNmfSV892RqYUIkcjkQurptFR0Qcscpwr4
 UBCDKxS35Tg3ybKYQ6G7d9mkGnW2
X-Google-Smtp-Source: APXvYqw+ooTHCbZdyvy/oN/vaR7p/s20NMpJ+AZTwgcfwXmhrKadWicMcFEXq2E/TnqM8hUKEEfrEw==
X-Received: by 2002:ac8:769a:: with SMTP id g26mr23101446qtr.259.1580240834910; 
 Tue, 28 Jan 2020 11:47:14 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id b22sm12590452qka.121.2020.01.28.11.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 11:47:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_latency
Date: Tue, 28 Jan 2020 14:47:07 -0500
Message-Id: <20200128194707.87898-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128194707.87898-1-alexander.deucher@amd.com>
References: <20200128194707.87898-1-alexander.deucher@amd.com>
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

Only send non-0 clocks to DC for validation.  This mirrors
what the windows driver does.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 4e8ab139bb3b..273126cfc37d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1026,12 +1026,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
-		clocks->data[i].latency_in_us = latency_required ?
-						smu10_get_mem_latency(hwmgr,
-						pclk_vol_table->entries[i].clk) :
-						0;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz =
+				pclk_vol_table->entries[i].clk * 10;
+			clocks->data[clocks->num_levels].latency_in_us = latency_required ?
+				smu10_get_mem_latency(hwmgr,
+						      pclk_vol_table->entries[i].clk) :
+				0;
+			clocks->num_levels++;
+		}
 	}
 
 	return 0;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
