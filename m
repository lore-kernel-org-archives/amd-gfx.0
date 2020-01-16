Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68083C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361AD20684
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLpUaOTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361AD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38656ED56;
	Thu, 16 Jan 2020 14:41:55 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229786ED56
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 14:41:55 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id q9so4002098wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 06:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XpDmZaoXJIXJ1qGF5I9+ea6vsqU+3/bpm2WuNXXY9Ss=;
 b=LLpUaOTpujYWWn+2BcMZgXAT5edhFOciSS10ZxRw5S6UwtdkASGR08Puvhzaabear+
 /wnesxoYKPB8lKgnek9zUY93uwu5F/8bIpP2/fZCWVb/sGVHmhQOObB5jgd+IRcY9HBj
 02dNEMoGKUNkOVs2OeHkqtYSHdFtr7hJrlQtb1PJ7dFyAswAhFaqKmlmnLHkDQUYOEa4
 aANrA82mmMpgfzZgcQDLAW5Vm2Wzqk4PyelBohbTc2JBuFCK4zy/9gH1XUkXR+5EpxBf
 ThQvdwCU70JSWx9XlRi/pf2KLCC2+gSRs1EykcZ85qImIGq51RdC+XQiWaZpfAJrj7mM
 kUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XpDmZaoXJIXJ1qGF5I9+ea6vsqU+3/bpm2WuNXXY9Ss=;
 b=kSdPqUq8yNuWB5K1ejd2gpzLK/Nq5MzqSFsL2OFFuaoR4nBBQplvjI4VMFOnifXvj9
 cHpdyeVcVxxFclXF8g/fnS3HXhpgi5n3i0BtikF0ma/7sQACrI1TMB97CWXJ9I+n0JyA
 st+xb76BQhtmTGXV6QQ8+xZBpkgAD3O7GbdF1xHPkCGPrvPbEzBDkg8QbW+BA5yx6G9L
 GBI6KYZOptE08nvkUoxaRgWpNcfF+I7DqOPH5mt7eqYEUBJYd4KCDt7yxKSdM4v20Z74
 fZMswvDvzwdabvASZJCFHdtxHyFw0F3uVATGLrrhC4aiq5oeCdS+FGxlWxwtmctCl6LQ
 0plA==
X-Gm-Message-State: APjAAAWLWtLvwZ6lHxT1AadkRuYfFNtB7VMvA5/ELbS4F2TUV0MfLnvU
 91HuGFB2crru+nCItlPw1ZylBsL/992Ngk9+
X-Google-Smtp-Source: APXvYqyyBV395oZAAxqtaaRMurwPaGdp/R+vaZrtSsO/hebs58G0aCnjEvoDBKQJgXJ7XJMUNBzbHw==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr6528917wmg.16.1579185713274; 
 Thu, 16 Jan 2020 06:41:53 -0800 (PST)
Received: from brihaspati.amd.com
 (p200300C58F2F9500BD0C32DA1D260485.dip0.t-ipconnect.de.
 [2003:c5:8f2f:9500:bd0c:32da:1d26:485])
 by smtp.gmail.com with ESMTPSA id x132sm4099848wmg.0.2020.01.16.06.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 06:41:52 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/scheduler: fix documentation by replacing rq_list with
 sched_list
Date: Thu, 16 Jan 2020 15:43:20 +0100
Message-Id: <20200116144320.109044-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This also replaces old artifacts with a correct one in drm_sched_entity_init()
declaration

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  2 +-
 include/drm/gpu_scheduler.h              | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 33e2cd1089a2..ec79e8e5ad3c 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the rq_list should have atleast one element to schedule
+ * Note: the sched_list should have atleast one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 537f7a4655a5..9e71be129c30 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -52,9 +52,9 @@ enum drm_sched_priority {
  * @list: used to append this struct to the list of entities in the
  *        runqueue.
  * @rq: runqueue on which this entity is currently scheduled.
- * @rq_list: a list of run queues on which jobs from this entity can
- *           be scheduled
- * @num_rq_list: number of run queues in the rq_list
+ * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
+ *              be scheduled
+ * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
  * @rq_lock: lock to modify the runqueue to which this entity belongs.
  * @job_queue: the list of jobs of this entity.
  * @fence_seq: a linearly increasing seqno incremented with each
@@ -81,8 +81,8 @@ enum drm_sched_priority {
 struct drm_sched_entity {
 	struct list_head		list;
 	struct drm_sched_rq		*rq;
-	unsigned int                    num_sched_list;
 	struct drm_gpu_scheduler        **sched_list;
+	unsigned int                    num_sched_list;
 	enum drm_sched_priority         priority;
 	spinlock_t			rq_lock;
 
@@ -315,7 +315,7 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 int drm_sched_entity_init(struct drm_sched_entity *entity,
 			  enum drm_sched_priority priority,
 			  struct drm_gpu_scheduler **sched_list,
-			  unsigned int num_rq_list,
+			  unsigned int num_sched_list,
 			  atomic_t *guilty);
 long drm_sched_entity_flush(struct drm_sched_entity *entity, long timeout);
 void drm_sched_entity_fini(struct drm_sched_entity *entity);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
