Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8310C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 15:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BAB2073E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 15:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq6U0KMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BAB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2676E9D1;
	Tue, 23 Jun 2020 15:58:05 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE926E9D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 15:58:03 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so9859002qvb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8bEVbpzKtH/qPjo3GoVzahqbLZmlkhKihOXj+GKaCnU=;
 b=cq6U0KMOyv9Jvzb5fCaUojpEk/6RfOHrtgdNsd0GMqznaL9s2KcyOy5VBZ5QgQrbGK
 G8JOnag2wvS7A67GQ6v1EncLWzyL9992rkRAr3Sa/lImPITuKehZbuSF0EDCSrHEYg8W
 r5s8Q27vKDLyxbMsO7J26p+HJXq51oFpGJjOEqXrsYs1hi30rKmiPH/375wA3VTiA1zK
 skPGvDxpZ9F/SeZEj1fnMkBFv9Y8zMvbBDr738yZW0lcdznLyZxt7EESmGtiocOuQW8T
 0dB8xSs1r91U9WcfJCVizRlaKtdKUlL7YANfTnlYVr/fm0Hv7jSNvzKjJ0SYmjRXvLwW
 DHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8bEVbpzKtH/qPjo3GoVzahqbLZmlkhKihOXj+GKaCnU=;
 b=A4fvPZFBoYUfD5FaVXDJQXkOSTh+R6dIZUSb7PbnhnN0NG6ZwNhpJko0xxGNwa1COU
 lv0vpozG4JClfbVNY/xvQWHkj//EPlLsIs7psEiON4Eycp9Ck11K5SiwuuaG43/bZBwI
 02AP6zf7Z6PS8Sk5KEzjlH9jjd1C8R91Tpus/VF9FsgNbvvKbRsFfvYvJyjrhmK8lrgf
 EG3YtiLpNf5Xh29YG9+YMLd1Bx09ntyTqBcicTWKHNVpKKhgeQdETdOS/QV55T4lzcr9
 SnyxunclUzuSGyPXdlUHp7wT8ZVKy5DlK+XYPwg2cg0lIsVZovpYuK8RVqyXnh+KiUyv
 K7Eg==
X-Gm-Message-State: AOAM533z+gfcRsjrKk2ytvddEEzDl4/xM9FwiEINKF60uVPOBfDldF4S
 P5Yzzq5aoo6eAhX6cVyyiMnYqibLR+tCxA==
X-Google-Smtp-Source: ABdhPJzIBeKoKJvKrbGmbNZ5gCgeAjI8t5cLFEWaFLIdHEV7AjsstSfG4lYv4uACKH6gYGAkj9y6mQ==
X-Received: by 2002:ad4:4429:: with SMTP id e9mr26915744qvt.143.1592927882788; 
 Tue, 23 Jun 2020 08:58:02 -0700 (PDT)
Received: from brihaspati.fritz.box (pd956781a.dip0.t-ipconnect.de.
 [217.86.120.26])
 by smtp.gmail.com with ESMTPSA id n36sm1076739qtc.35.2020.06.23.08.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 08:58:02 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related compilation error
 for arcturus
Date: Tue, 23 Jun 2020 17:59:29 +0200
Message-Id: <20200623155929.2547-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: Alexander.Deucher@amd.com, nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

arcturus doesn't support DCEFCLK

Fixes: c67c791cd87d (drm/amd/powerplay: return current DCEFCLK on sysfs read)

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index daeae14fd380..d93f8a43a96f 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -962,9 +962,6 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_CURR_FCLK:
 		*value = metrics->CurrClock[PPCLK_FCLK];
 		break;
-	case METRICS_CURR_DCEFCLK:
-		*value = metrics->CurrClock[PPCLK_DCEFCLK];
-		break;
 	case METRICS_AVERAGE_GFXCLK:
 		*value = metrics->AverageGfxclkFrequency;
 		break;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
