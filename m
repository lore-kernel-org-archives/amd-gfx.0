Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 16:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42242206C3
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IliFZyHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42242206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040416E948;
	Wed,  1 Jul 2020 16:02:20 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61EF6E948
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 16:02:18 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id e12so18787385qtr.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2020 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+TWoEUljKwY6MeuGW6/5RMej9FpTkeGt9v4GEFm9Jw4=;
 b=IliFZyHQ7WHVE6doRIqL98btV5/Gs6x4X2pBw/0McQceIkfG9dQ42L47WdidoYDMN9
 7AbSWU0zhqQCokbFbEIYDXx6NgbPIqBUgnKWQBBe2uyg/P+fOkrQ+QLvVLU+XfFzDeYX
 9jPaAfK7y7LKzS2mLUyO2L7mpNm9tgzOAvlP4lpXJljNU/SHWczz+qebPzWzwzRW2YNY
 qQDj4+t7kaAMMyIOadzS57oowKBWr2ZKw0eVAxfgHQQ8xPB50iS4u81j97Iog2nTMfXT
 3qE50N/3F0GLHtGE/+nxVSMZfa+Lnaz0rA+R38XpX4vLEtAWWwhznJAjPMXnVaEOZaUC
 6ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+TWoEUljKwY6MeuGW6/5RMej9FpTkeGt9v4GEFm9Jw4=;
 b=Ptm5iYTwsML46rmciY1ftv62BYgbFawx7vTI0y+yBZ8LDZrOA2o5t2IOyATod4nGFI
 m7TzcTFybMOUj5+GFWZUrkW7U/Vn0O5Z1swbbTW51I8a8gWOSCsWq9WfUdLZf99OhXiz
 P8ZiaNktJTe/gmDZnhKo6aggheoDBWOrsMLRIC26I7iZG5UltlaV3Bd5T7BHjdb+W825
 YR75U22RPNnclNW0sewN3gw75UrZf/pxuCP4KVSNswGFXM6rGseYy1ViVU/zKTPkWv28
 2tFPjI44oVpZpHAHGGmNimS7xTACrCxOe/+KAkEbCz3YSczvqii9lhEBtAHojOdwElwE
 VO0A==
X-Gm-Message-State: AOAM533FlLPZzwV0ee3w14B5epbkgg7v/xlTT+dQNREM6ZrGVsPa8vUG
 /vIuaq5I74ZKcVWRKwD0Z8Qs6g2C
X-Google-Smtp-Source: ABdhPJxfIiu3TL8n5Fjx/IPMhOiJgtx475GWXWWflu3/4uNjlGH0g7u7/XeDWvARn+LbD2AxY+mG9w==
X-Received: by 2002:aed:35d8:: with SMTP id d24mr27689098qte.246.1593619337589; 
 Wed, 01 Jul 2020 09:02:17 -0700 (PDT)
Received: from localhost.localdomain ([71.51.183.177])
 by smtp.gmail.com with ESMTPSA id w204sm6208171qka.41.2020.07.01.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 09:02:17 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use %u rather than %d for sclk/mclk
Date: Wed,  1 Jul 2020 12:02:10 -0400
Message-Id: <20200701160210.1127202-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Large clock values may overflow and show up as negative.

Reported by prOMiNd on IRC.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 26c8e39a78bd..838d6d51904c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -2960,7 +2960,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", sclk * 10 * 1000);
+	return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
 }
 
 static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
@@ -2997,7 +2997,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", mclk * 10 * 1000);
+	return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
 }
 
 static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
