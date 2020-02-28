Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7FCC3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111B62469F
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkDTQRZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111B62469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07846E02C;
	Fri, 28 Feb 2020 14:36:43 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECF66E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 14:36:43 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r17so3188502wrj.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 06:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l6TVBawHJgOYJ4qWLYR5BxnF65qUEdirsfdOJKMig60=;
 b=tkDTQRZkzIVY+Xdl1YDI44DrReXwnKpknrhyCSz4aDt0dLyaTgAS7YSJ8Wbi9kcrW1
 nhZtQohTmloW5wFFV+NIgL2j2bJ7YhPho6rx0gVy+llJYw1genX0976C/U2mJCLSgtxC
 VsL0/VZoGcNiaWmZk9wVlnd9eVLxImwC78pul2KCgqGVgfhvYB2GGA+tjGB2IsRSh5/4
 6gjVjROzDvOrsowpxrRYdcmqe991ADKMyNab9QPzim5oYMEth+RuNRt9kleZraloACXQ
 vmrJEMX7QD8CB6SHFVjVpitfUN6hXDwrgaJ84WAnlgiPDB8wt457KLStxET1+wu0KbDN
 sQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l6TVBawHJgOYJ4qWLYR5BxnF65qUEdirsfdOJKMig60=;
 b=mjqzKtE/LZqqBDGIaqtNTSeaYvzxZ3X49xNXo8S7u8tr/ZG2QEXkeMY1NsR5vZ3qoq
 TKz83fhTxOaVvCPFK1jLJo9pG2N0CdLsvDN7c1VeDNTPvFSfzwoidf/BbQsZvHZHzUzC
 7ZqR4x1zTtd0fX8b0OhSFYaI2DNBDhv7kZB8yO9ZviOVGW8zp3K5umQgM8nKd7uPZJYW
 TGyagm845SIXmGm9jD4WBHN3k+wWoGvJZC+5iFdjQevCbqfuj/ZGUhogV/lBZisphGh5
 hEDlLTQ8rSp06dTUxYz8BYogVkpTh2j6h5pQLGGHkj6iq5fcjbcUVX3FLkKoiahpsA7i
 o9Cw==
X-Gm-Message-State: APjAAAXi12vXUmF3HUCtBj2J0z5zGK2cTX3lAngj91FCZKrA1vl+KwCO
 DYJT78RSzfKd4SUkLcBCOYDJIIWzMGljmg==
X-Google-Smtp-Source: APXvYqx1+7GC0f84uNLa47ZO+Kuwb7RP0jSR439mvAq11u4L9kCN+UR3Okbgh/STy4qleANsJGN53w==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr4972912wro.282.1582900601320; 
 Fri, 28 Feb 2020 06:36:41 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F28EF00805E149DBFE09C45.dip0.t-ipconnect.de.
 [2003:c5:8f28:ef00:805e:149d:bfe0:9c45])
 by smtp.gmail.com with ESMTPSA id m125sm2445471wmf.8.2020.02.28.06.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:36:40 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/4] drm/scheduler: implement a function to modify sched
 list
Date: Fri, 28 Feb 2020 15:39:39 +0100
Message-Id: <20200228143941.4919-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228143941.4919-1-nirmoy.das@amd.com>
References: <20200228143941.4919-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

implement drm_sched_entity_modify_sched() which can modify existing
sched_list with a different one. This is going to be helpful when
userspace changes priority of a ctx/entity then driver can switch to
corresponding hw shced list for that priority

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 19 +++++++++++++++++++
 include/drm/gpu_scheduler.h              |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 63bccd201b97..b94312154e56 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -83,6 +83,25 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 }
 EXPORT_SYMBOL(drm_sched_entity_init);

+/**
+ * drm_sched_entity_modify_sched - Modify sched of an entity
+ *
+ * @entity: scheduler entity to init
+ * @sched_list: the list of new drm scheds which will replace
+ *		existing entity->sched_list
+ * @num_sched_list: number of drm sched in sched_list
+ */
+void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
+				  struct drm_gpu_scheduler **sched_list,
+				  unsigned int num_sched_list)
+{
+	WARN_ON(!num_sched_list || !sched_list);
+
+	entity->sched_list = sched_list;
+	entity->num_sched_list = num_sched_list;
+}
+EXPORT_SYMBOL(drm_sched_entity_modify_sched);
+
 /**
  * drm_sched_entity_is_idle - Check if entity is idle
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 589be851f8a1..f70a84aaaf7a 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -297,6 +297,10 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched);
 int drm_sched_job_init(struct drm_sched_job *job,
 		       struct drm_sched_entity *entity,
 		       void *owner);
+void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
+				  struct drm_gpu_scheduler **sched_list,
+                                  unsigned int num_sched_list);
+
 void drm_sched_job_cleanup(struct drm_sched_job *job);
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
