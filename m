Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6292BC33CB7
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FFE20716
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/Q8khXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FFE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616AA6F60C;
	Wed, 29 Jan 2020 18:01:43 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE5C6F60C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 18:01:42 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id d5so215464qto.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 10:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kExQ1th5SXrZfStDNmYv12qBoyZXcy+Wxom3Z/zi2Y4=;
 b=Z/Q8khXNuPqcYxMZGefiAIVMJ3NVZgiDSjE+dCrXG0QhljDwEvySPBilMjZXCZP9Cb
 oHr6w6f0V4n0rXH8Xr4OmRww0nKip+X256HP2I4iIryo1hR741HSibBXFt4MO5SsOA+m
 DBs7Im7Smur5JWYAYJxH8kGJDoCmtvQZCfxivqxs6lI9bfVeo67gt2Ka9It3Xhs6wyEH
 rp27GZauq+qzCjtfvQEbtTN8Ov8SC2bxc0U8HbBbNst0vHPBAHlvyNbvjNofTisGwd4+
 uFt46CVsAvfhZc97t3qoq9/cEnL7ynhT1lE1yExl1mijanzqMV/RskJg7YCFVam4RkZw
 wo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kExQ1th5SXrZfStDNmYv12qBoyZXcy+Wxom3Z/zi2Y4=;
 b=IKGIt/ZLurHcnPCFWy7c+AvQxwTZpZ5lv6TKfPRRpEeyXx6kT7Kv50qaWYHq6sgWl+
 mmY95L0NxStyVKznlq8eSWe2rpsKKmTIQqBLYxdbzPk9YREHaMyPkh+EfNP4Y2z28lVh
 6O5FxUQnPbx2uFeSlqtMRgTxaJUBt1BczpzJCye/hYyH/7ydjwzzcK1SLXUXzz/XSVNn
 7BmQSU8bSFGwQA/2xGFS4xmEcQ91TvORpX1SmzdRv3Tb4pwVke2yxrg/w7kAXk4WLl07
 CGXitw9TjqHEY5ch2OCk02fbaaakh4twFrgDRBiWMOy0e+zYHYH5/+VPjJ8/sLQqq3Fl
 a4ew==
X-Gm-Message-State: APjAAAUxdHeNjmPu8OTQtQcn9/qTPGN6oCkb1qe+RK9q5I20p2hGqUT1
 cFqIQh/L0nbyc27h4PWh+VpvuBL9
X-Google-Smtp-Source: APXvYqwFI7johSajBrDmT6XrTG8RuSaZqCeRBuDPF1LhtcHe23JC51e07cyepYS6JtyfAWsk38deWA==
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr401075qtw.9.1580320900859;
 Wed, 29 Jan 2020 10:01:40 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id f5sm1322648qke.109.2020.01.29.10.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 10:01:40 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage
Date: Wed, 29 Jan 2020 13:01:30 -0500
Message-Id: <20200129180130.585870-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129180130.585870-1-alexander.deucher@amd.com>
References: <20200129180130.585870-1-alexander.deucher@amd.com>
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

Cull out 0 clocks to avoid a warning in DC.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 273126cfc37d..689072a312a7 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -1080,9 +1080,11 @@ static int smu10_get_clock_by_type_with_voltage(struct pp_hwmgr *hwmgr,
 
 	clocks->num_levels = 0;
 	for (i = 0; i < pclk_vol_table->count; i++) {
-		clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
-		clocks->data[i].voltage_in_mv = pclk_vol_table->entries[i].vol;
-		clocks->num_levels++;
+		if (pclk_vol_table->entries[i].clk) {
+			clocks->data[clocks->num_levels].clocks_in_khz = pclk_vol_table->entries[i].clk  * 10;
+			clocks->data[clocks->num_levels].voltage_in_mv = pclk_vol_table->entries[i].vol;
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
