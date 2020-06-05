Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A551BC433E1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87482206DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87482206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D40B6E956;
	Fri,  5 Jun 2020 17:38:27 +0000 (UTC)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2976E508
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 17:38:10 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id a9so9187418ljn.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2020 10:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=arv2xjh9BIH+SPIN4Yj/Lki3GqizeEVvxEcRGCN4wkw=;
 b=JwQgsEd/MabtDuqdmHf/ztuJ3c+MyyGdQSpLzac2tVoJvfqiWi56saFe4cENxfguo0
 SdRuFjVWhZ6H89driKRp/XxCGbwDmFVdJ7WRJsO/7zxnn668fnFadca4pWb7wI/NFNPR
 ZWp6jdzD6xqtYypguC+2JlmansL8ZLukByQAJmNt9uHZdGKBcuBzFNIYs752luFYBOeN
 1H2vpjFp1v/exRbUGWPzqHU9mPPJckjOUAW8nuTv3rYFa5LyvK0R8YOyQ5w9PvBTBPfb
 GYD7VQ1kdbE9AGftqQKE9amIt21ay6v7JhlGQDTbLEob0PqQfSH2F4HpfQ2Vx4rEkXWz
 rqGQ==
X-Gm-Message-State: AOAM531nzlxUmZusxAumjtER89UcYjEmrpNZ5dS2DZ3TNLbiseenRo0V
 Pl5YN5WkjEGk/Ne4HJEP9lE=
X-Google-Smtp-Source: ABdhPJyKUQu6CenJtrzDcfzmjM64mHti4oGYXRkw64f4WchZmMA6w4xfxmQOf3/jZuyMazvLMzH6cA==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr5404553lji.75.1591378689131; 
 Fri, 05 Jun 2020 10:38:09 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id w1sm1049514ljo.80.2020.06.05.10.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:38:08 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Use kfree() to free rgb_user in
 calculate_user_regamma_ramp()
Date: Fri,  5 Jun 2020 20:37:44 +0300
Message-Id: <20200605173744.68500-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605173744.68500-1-efremov@linux.com>
References: <20200605173744.68500-1-efremov@linux.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 05 Jun 2020 17:38:26 +0000
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Denis Efremov <efremov@linux.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use kfree() instead of kvfree() to free rgb_user in
calculate_user_regamma_ramp() because the memory is allocated with
kcalloc().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Looks like this kvfree is from merge conflict between 
1fafef9dfe12 ("Merge drm-fixes-for-v4.17-rc6-urgent into drm-next")
and 6396bb221514 ("treewide: kzalloc() -> kcalloc()").
I'm not adding cc to stable because the bug looks harmless. You can
squash the commits if you want.
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 56bb1f9f77ce..bcfe34ef8c28 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1777,7 +1777,7 @@ bool calculate_user_regamma_ramp(struct dc_transfer_func *output_tf,
 
 	kfree(rgb_regamma);
 rgb_regamma_alloc_fail:
-	kvfree(rgb_user);
+	kfree(rgb_user);
 rgb_user_alloc_fail:
 	return ret;
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
