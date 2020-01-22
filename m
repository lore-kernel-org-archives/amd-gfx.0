Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DEFC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA6F2467B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeUCvLwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA6F2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900236F454;
	Wed, 22 Jan 2020 09:37:02 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C2E6F454
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:37:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so6511637wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FZ8pGSLf89eY3ySF8DqDNq3F30hZSHLMOEuhvCijbqg=;
 b=eeUCvLwyA/f2GpGSk3Lo5VjdrlT9nNM3gA5xY395ise+iZeZAQ7fbA5Iu2nwcPL4GY
 2mA1iiC6TqRh8CinU4DPwaFs7lmQMw8bl8muHVFll8EnOyNDSJhnvAGG+IDYZujVPrlv
 NrG80yyVeBkfp2ONkiDGVndvMM102hM4Wv6qd+47IGInPuYETxeqZrRKAH7ZprRG6htO
 VTF7uwf0umEv6+FFy2v2ohzzIsNa3X3UEi11XZtrO8vp3G1U9r68hoMZR1aA5nczeOxz
 5pE/TOVo4DuxNzPWayygSZGY3693PY1gutY3pVq0ZKWxzoBarrptg/pnSlMQ66ur72Cu
 xs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FZ8pGSLf89eY3ySF8DqDNq3F30hZSHLMOEuhvCijbqg=;
 b=nR9BtnxmhYSEhrOOJbSfKnsvGMcMBMBQtj1s9rss1YfEau2N0gtDLR7orUDVEsHfTg
 CfIeAh8ErXlfNuxh1Apf/DscpHh4HZ8eyQDMGjtQrYBfrWiTsGBTS+YJfvfljrMf1pBJ
 K8DW802FkdzQJOmuSOkWvP1hWlaIBemk/zPCVlYipA6/gOpizk1kkz7oCEJAWCffUFAc
 SzZSSPU/l8C2jWMkPdcl++1Qg3Yz1QrmA8pT2+U+kGQS4oAY8OB5BBwx5+0WsU87KDnS
 UuvV/oKaMnc5fAbWrRx5PUv3k4DEzkTwurC0afkTh4NF4Vtg96SU07e/nzJdFST7r7Lp
 6poA==
X-Gm-Message-State: APjAAAUa1sJyyyvD6sGFTTZYIKHRQcVG5T3ec0Y9ywHJDmqP86r2tKdL
 61gEPgt22QEwGrDjkq+2T3TxOwI9OB9pZQ==
X-Google-Smtp-Source: APXvYqycmr6+G7sneWglXPUoTdDT1es/b5kn5Cvw4I3z4T9eJvSHbHJEu2WLQOipLdtZ8kGfTsRh0g==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr9688710wru.94.1579685819859;
 Wed, 22 Jan 2020 01:36:59 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2957000A0F1FDBBC5B14D8.dip0.t-ipconnect.de.
 [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8])
 by smtp.gmail.com with ESMTPSA id l15sm53989533wrv.39.2020.01.22.01.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 01:36:59 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
Date: Wed, 22 Jan 2020 10:38:38 +0100
Message-Id: <20200122093838.17136-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, luben.tuikov@amd.com,
 nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

expand sched_list definition for better understanding.
Also fix a typo atleast -> at least

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 2 +-
 include/drm/gpu_scheduler.h              | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ec79e8e5ad3c..63bccd201b97 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -45,7 +45,7 @@
  * @guilty: atomic_t set to 1 when a job on this queue
  *          is found to be guilty causing a timeout
  *
- * Note: the sched_list should have atleast one element to schedule
+ * Note: the sched_list should have at least one element to schedule
  *       the entity
  *
  * Returns 0 on success or a negative error code on failure.
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9e71be129c30..589be851f8a1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -52,8 +52,9 @@ enum drm_sched_priority {
  * @list: used to append this struct to the list of entities in the
  *        runqueue.
  * @rq: runqueue on which this entity is currently scheduled.
- * @sched_list: a list of drm_gpu_schedulers on which jobs from this entity can
- *              be scheduled
+ * @sched_list: A list of schedulers (drm_gpu_schedulers).
+ *              Jobs from this entity can be scheduled on any scheduler
+ *              on this list.
  * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
  * @rq_lock: lock to modify the runqueue to which this entity belongs.
  * @job_queue: the list of jobs of this entity.
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
