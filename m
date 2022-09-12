Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88CFC6FA86
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EE810E438;
	Mon, 12 Sep 2022 12:37:16 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5C010E46D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:45 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id f20so8066700edf.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=N0viDBk+OE4G2fXZMNgHtec8zmk2V4DzNO/0dhhNiM+2GBGDL34Ht6uQCk5JhqPB2K
 jtqeujXwvDaZ6tE82re/4mhnCk7dQykUvtF1TQejNzo8BRpVpexHBI6deiaQwQy5N4B8
 j1b1IgIQTIY8zkSubd6AxtJrhFG+MnRBi100FobsqDxIG11kjXDC5qAb44HNDpKW95WT
 U5jJFMemqyYQbqhH5r1YQ9+9YX0B/NtCpHTivaqEZR+x1F/wFQVCoEgfb7f5WxEl47eV
 wJ6hH7KHJJj2bJTW+VTBbIBa8mpFWvW4OUp9C24ZCpWaDnOpz2Y7aZF8kXFNKrl8W9pK
 g/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=hHa9rZkpefut1O7+lDcM5lqgtqs9MX2Lr9wPpVhN/6ce3SlYo6NngKy847BNO1Mze6
 YixwQhwUUKH/E7PQcSaGoAtD4OIb+32VUwhj1BFsJgeXL/kxkdTAJJW0i4FhyZj+U8Es
 o3rsgdQu24WkoI9S425KiWZuvjGVlhgjX4rImciP2spG4INOKwOkTmFnpkcArPhtaILy
 X5ki8nCN3sjhxDaKxHqjSBEoJMymGH+JaeXH2w4YvLLyEi+nAgrU387y+7C72OKhSJoC
 /Mgp9U+5I8AqYMcdr7xYifsOM7AHYQ86CEPw9NjFKZjWLgbKbDr0qhdTnpVavvtng4zd
 1VZA==
X-Gm-Message-State: ACgBeo1lhi7sX27ZAWywxbOnO+Mt0YKm/EYIZ8pqpWow5AdYo+yVSpuR
 gO3jkyBKPlwUXrHlePQ3rSQ=
X-Google-Smtp-Source: AA6agR7nNpdHiHCt4qorpiyEjQCZS8gZz1lAArd59x2SuNenIHAi7GWuK5vaTPcdNZ7PO/2N9hNGCQ==
X-Received: by 2002:a05:6402:3485:b0:451:f615:321f with SMTP id
 v5-20020a056402348500b00451f615321fmr1978424edc.65.1662986203768; 
 Mon, 12 Sep 2022 05:36:43 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/sched: move calling drm_sched_entity_select_rq
Date: Mon, 12 Sep 2022 14:36:34 +0200
Message-Id: <20220912123640.20058-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
References: <20220912123640.20058-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We already discussed that the call to drm_sched_entity_select_rq() needs
to move to drm_sched_job_arm() to be able to set a new scheduler list
between _init() and _arm(). This was just not applied for some reason.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 68317d3a7a27..e0ab14e0fb6b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -592,7 +592,6 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		       struct drm_sched_entity *entity,
 		       void *owner)
 {
-	drm_sched_entity_select_rq(entity);
 	if (!entity->rq)
 		return -ENOENT;
 
@@ -628,7 +627,7 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	struct drm_sched_entity *entity = job->entity;
 
 	BUG_ON(!entity);
-
+	drm_sched_entity_select_rq(entity);
 	sched = entity->rq->sched;
 
 	job->sched = sched;
-- 
2.25.1

