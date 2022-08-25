Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C38C676B3
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3E410E0C9;
	Thu, 25 Aug 2022 13:32:27 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33BD10E023
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:47 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id w10so13983053edc.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=Koffs4GCwTtX/oA7XxTkNLDQh/yjy+qEiLZXb5pct9dJjgwnt9q8coNrwtFscdPOOp
 IHSmydUtb+s7vEqRzZ+9ZIki4Ay17xb4DIrF7+eB4bSDC+X1Jls3wOLFJwiHldnK+Eyl
 /c6QDNjVRy6xq7spvQkGEkZpk1bnysd1kx3TLFebE93/9OPLbtAYKJqwmVGdhvId0oU9
 j6+dqnuX+6VvJMzj0D0AuHOaDMHJXte84SOQn7cdKdcBCY6QFXzeLYJGk8X80sqgpmvL
 BG5AhVnJEf2+86VCo6HR2zguYqnjfUWPGOE+fdJapEY7rq/fPH5G+gGhvX2te9y0PnvY
 frMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=kBJ8MKPMTc/ljm1Je/dqVW7iOpGuBGK18C7LP1VWBRU=;
 b=cxQjZDnzIe2WWgmqXIKZb19e8IYiJ84g9dSqEngWugxvztbaqVHPAHYY8kA2QsIBz5
 2uOfxwNVilQcr5JhNQuFMMCaUP6w8m2crGSeFXWaDdl48H8GlDd8UVgrZ+gN5XM06G77
 2ysBnxHAjYluc8qyQakKW3q7QOEQ44fEydm79iqK+onD8Tal3YGMJ9Po9ATzqGQj173C
 gBi0DXga4HvK0MP8eYzM8yvjCpD1bsw5SzqTSqrTChzauSd92a9Spb1cLGhbaeEEyO1Y
 bWdJPb9ENC5SkgJONFr43nxyce7HHDA2Id+T4b3skngrzQOscWUTmokXVYk5udsZaSLD
 ih9g==
X-Gm-Message-State: ACgBeo1GAeMwBh7boKSu5wATNTRebkYc7Cs1JXetlS7EjFl7lbKjBFMS
 8B92AeTx6T1imb31ViEvweZqfediYpEMSw==
X-Google-Smtp-Source: AA6agR5Q6E9V08VoErkE8LmF7INrUcJVnK5PHGbqMysuuhwP8D78WDVLR9QQg4sKIpJiml+cqEmtzA==
X-Received: by 2002:aa7:d508:0:b0:445:dd73:4f6f with SMTP id
 y8-20020aa7d508000000b00445dd734f6fmr3223281edq.231.1661434306554; 
 Thu, 25 Aug 2022 06:31:46 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:46 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/sched: move calling drm_sched_entity_select_rq
Date: Thu, 25 Aug 2022 15:31:32 +0200
Message-Id: <20220825133142.8272-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, timur.kristof@gmail.com,
 bas@basnieuwenhuizen.nl, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
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

