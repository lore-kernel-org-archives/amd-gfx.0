Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26800ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC6610F1CF;
	Mon, 29 Aug 2022 13:18:37 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A720610F1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:26 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id bj12so15592832ejb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=N877zg9zpa2nfLS22LUB264/20ksP86JTx4JU3jvOBO52IUVqOwfUvDX6yZpL4WtKS
 pSyaf6ufJIIjoFIYHCKCLy8MbkHipYXCnXFpbpEdKkiY2ACs1DEMAJLjlQyNMdC8Mi42
 8Xh95yzj6HxIvWmejKpT6xQ0p6S7fMadIGQQOAqxepKZZ4RK+7eKTasMmcevGhKuRThA
 i37eujI33o1hO7ijH2/WbgWJDbnkvIPc2qqkNtuGEmLmPPi8enelRJFa+O2G3yXKkYMd
 j2ea9qZNr5V3dKG611AmT/cETkrgAB5QG9tUklrT/5Mvzo+0PSofueRi+hTUUmF6KVcV
 Nsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=0mN8LMlRjlYVcU6EpS6pbmT+qaxlUkFft4/9iRVnMSVAbrfRA1XqmHVZ6wyVEM/yxD
 gmuZpicFYTN85o5AxPhH7hx88xd5RdVmHxm7Jrw5Ctm5i6hpslnQ7RY2qTeR5HhXIaxB
 Xq9ZjK/1dfJsW447qEtxOsefoCCQgkAUJOZWVrEO12Vs1XZTeA3diwUEPL1hKzGdS1Xq
 5ZmU9om0jwboR735zbzSbNV6oOlAd/hy9nLsXBTIiAYfz7E/MmtEnn0bLY6dvGFJBtpL
 Cx1/n1LXx7a2UZHrQZ5tDVkYizK3f2me1W0vW5Vub0116RIELLZCrsMNxP5znrPwQsZE
 DV3g==
X-Gm-Message-State: ACgBeo23VSUnw9fMzCaBfYSCGc62dhUWilFqxu4s3c1deMd3ihDTol7Y
 gpyG5oOLtyfPQg9sRCnaZGiOm8zzoE0=
X-Google-Smtp-Source: AA6agR7p9G/URD7O4H1lugfBkPpMk5d37bQvvtpf3QWddv+P7P3HSy9+0OQmRrXagWuFh9JDd3yEEg==
X-Received: by 2002:a17:907:7ea3:b0:741:a1a3:b33a with SMTP id
 qb35-20020a1709077ea300b00741a1a3b33amr1401101ejc.356.1661779105213; 
 Mon, 29 Aug 2022 06:18:25 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/sched: move calling drm_sched_entity_select_rq
Date: Mon, 29 Aug 2022 15:18:11 +0200
Message-Id: <20220829131821.2049-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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

