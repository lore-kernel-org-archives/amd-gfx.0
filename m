Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BB6C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 18:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB148207FF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 18:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfz2ZFUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB148207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934516E913;
	Tue, 10 Dec 2019 18:17:41 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0496E913
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 18:17:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so21239009wrr.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7z6YXwF403Ie8/YOzbm9I9iXdh6pLQBa51cO2rDIcUc=;
 b=pfz2ZFUtVCJeQHjr900roa1BRFMz6Asa09koFlTtQqHK8zs4vrQxhQYIwoBeU7qVw1
 +ftXiqoqiSsUiwwWiNECsRI3XT+AHhkXXWBGsrmnxvjm7eyIF2+UDtoNTiPEnT0bP1fQ
 DsigUBCan59gimFzsQv2IyevNuTChBk7dBUsq+B6CaxBo6GdJnFXi5rB/xaB3yOus6+G
 4JkcKiIFsqROrr3EqxAV9nNSnh6KWOpy+n4qZOzRyBgltSDXoeRTzzOzlKnrYvECu2Wo
 ghwO3gY8LT4UAd6yflheVXJ+fhJvTpWTYs1dExVK3NQGyAAhTpkFMzsLnMivioKnCAof
 yo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7z6YXwF403Ie8/YOzbm9I9iXdh6pLQBa51cO2rDIcUc=;
 b=Xae7ifJapyIWqcG9LtjoKWeYH73K+1nx97MAc+dGGsrh0uwD3LQyDejYd5kJfK180x
 FiGMWNtQVqsetRDpAz6hsP+lqVoBb9IHO/3nHet5UzJ1H5qRlRizC8Lnf/LScXgL4zLF
 8Lntgvc+n5OirrFGU5/E6jf0R+5qZjLSYycxecjckiH82HVcQid4vAglPVY8FfBLLXoV
 D0kmwfjHrulUB9wHlUEWxc24ynVkqaSiE5QPZdCPBxXCdmT0sNZ0PdJLeQuV2C2pJbMJ
 LTFtjSlP56LkUZERAs2+WmT4yMAuCyZgHoREeSzGr0KRp2geL0n6so0a7yP4qbxiMCCw
 Qbkw==
X-Gm-Message-State: APjAAAVN2cyxh4p0qZg5mUJr4FW/eM22QVpgYLwXiZDDt3Qya8lPcyJd
 mogc1v27+nrdEQ0iK5mTF1GfEdbBOa8=
X-Google-Smtp-Source: APXvYqz4CX9+yHE05eBE+5HISw6tgFIh5342k7174xma1W98tkEOQFBfa7I2xB9Ct3KIktrS8wdUwg==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr4678718wra.8.1576001858513;
 Tue, 10 Dec 2019 10:17:38 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2CCF00F7EF6DD58F2D73FD.dip0.t-ipconnect.de.
 [2003:c5:8f2c:cf00:f7ef:6dd5:8f2d:73fd])
 by smtp.gmail.com with ESMTPSA id v3sm4033412wru.32.2019.12.10.10.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 10:17:38 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com,
	kenny.ho@amd.com,
	christian.koenig@amd.com
Subject: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
Date: Tue, 10 Dec 2019 19:17:36 +0100
Message-Id: <20191210181736.3237-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210181736.3237-1-nirmoy.das@amd.com>
References: <20191210181736.3237-1-nirmoy.das@amd.com>
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

entity should not keep copy and maintain sched list for
itself.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index f9b6ce29c58f..2e3a058fc239 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -56,8 +56,6 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  unsigned int num_sched_list,
 			  atomic_t *guilty)
 {
-	int i;
-
 	if (!(entity && sched_list && (num_sched_list == 0 || sched_list[0])))
 		return -EINVAL;
 
@@ -67,22 +65,14 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	entity->guilty = guilty;
 	entity->num_sched_list = num_sched_list;
 	entity->priority = priority;
-	entity->sched_list =  kcalloc(num_sched_list,
-				      sizeof(struct drm_gpu_scheduler *), GFP_KERNEL);
+	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
+	entity->last_scheduled = NULL;
 
-	if(!entity->sched_list)
-		return -ENOMEM;
+	if(num_sched_list)
+		entity->rq = &sched_list[0]->sched_rq[entity->priority];
 
 	init_completion(&entity->entity_idle);
 
-	for (i = 0; i < num_sched_list; i++)
-		entity->sched_list[i] = sched_list[i];
-
-	if (num_sched_list)
-		entity->rq = &entity->sched_list[0]->sched_rq[entity->priority];
-
-	entity->last_scheduled = NULL;
-
 	spin_lock_init(&entity->rq_lock);
 	spsc_queue_init(&entity->job_queue);
 
@@ -312,7 +302,6 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
 
 	dma_fence_put(entity->last_scheduled);
 	entity->last_scheduled = NULL;
-	kfree(entity->sched_list);
 }
 EXPORT_SYMBOL(drm_sched_entity_fini);
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
