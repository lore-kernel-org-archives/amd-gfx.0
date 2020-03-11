Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA072C0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D202072F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa4nDPxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D202072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5566E9C4;
	Wed, 11 Mar 2020 17:14:42 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2906E9C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 17:14:40 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id v9so3637671wrf.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dU4mrj5ZW54gP7yXPhsZ7tM1fNEkDU1z5J73TYsa/k=;
 b=oa4nDPxloy5H8+rAM8Igrsnw3I/f9JZs34PqxjgbfjrlNM3Dw5MIWI+0RZXQcUaq98
 ryQjIZqK54APiePGsDia2UurOwCtZOg19WHtqKtGy893KqWTyMTQDVTwmLQQEWCUTmDO
 y/Vxzpv9zJcEeKEn4axIUDK5vMxu1EQcaR+FAn5a/BdBdHRKGa/UP7QvgD0lnrfInerG
 i+txtvZbEeD5DJ9H+FQlD326RNI9/45/Kq61zHabuSdZdIvs3VQh3Gx0/qrGTniUOtsK
 fFJSDMjXfxNynQMX2qLb2KPrzok+QrDrgPAaKkbJwgDYn3i86NFfjAyjI498qWxstvGO
 qURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8dU4mrj5ZW54gP7yXPhsZ7tM1fNEkDU1z5J73TYsa/k=;
 b=JyEzoxtRaJo3YT7w6sSo/HZNHydA1a1IY/A4vzXu5jMluAB1iu99wmbtU424rE5tDw
 uTJ7rogGVVb6HqjQPNJySaaLUcPRUipPPDPH9MJcvR/zhV3MJQ7tHvhiQCr0V3NxR3HN
 rWuEU3u9g3bVZnq7+lOPjZEU1n2Iq9LEJQ5EyLQ5SPjPTBbr0xYUhlzcDgZzYqJVJr+X
 0n4usSOPDamllP/U00puEUdkjk8ege5uG0NVMbDkDjeAjoD2XoqkCl99PIekRPOxjLIT
 zKFaJSBcH+bCKLFU6OMzmK6r7rJctDgLzZriSnKlvx3ndVaKO+uL8ZhErRXoyqBOSno+
 C4ZA==
X-Gm-Message-State: ANhLgQ1V6MtsPMgLOAUXW67kGAF59BH0JpjrqlDw/5PZy03YZ2tEyM74
 x5Y6dwobVmtwYrsou1mrOAgLgu5wQe0VvPKr
X-Google-Smtp-Source: ADFU+vvLH9G3uYlxTDNALmZ5u7+MYKfXZI0Qj5YDa6CY4+Hh2Yc1nVtDsTOtjeecqAQwvzYHTodE2g==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr5240820wrt.332.1583946878543; 
 Wed, 11 Mar 2020 10:14:38 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F28AE00BD65D97DC346E601.dip0.t-ipconnect.de.
 [2003:c5:8f28:ae00:bd65:d97d:c346:e601])
 by smtp.gmail.com with ESMTPSA id y12sm8630814wmi.48.2020.03.11.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 10:14:37 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/2] drm/sched: implement drm_sched_entity_num_jobs
Date: Wed, 11 Mar 2020 18:18:08 +0100
Message-Id: <20200311171809.7115-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement drm_sched_entity_num_jobs() so that drm drivers can
query number of jobs in an entity.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 15 +++++++++++++++
 include/drm/gpu_scheduler.h              |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 90fd9c30ae5a..dfe8216f2d52 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -119,6 +119,21 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
 	return false;
 }
 
+/**
+ * drm_sched_entity_num_job - Get number of jobs in the entity
+ *
+ * @entity: scheduler entity
+ *
+ * Returns number of jobs in the entity
+ */
+int drm_sched_entity_num_jobs(struct drm_sched_entity *entity)
+{
+	if (drm_sched_entity_is_idle(entity))
+		return 0;
+
+	return spsc_queue_count(&entity->job_queue);
+}
+EXPORT_SYMBOL(drm_sched_entity_num_jobs);
 /**
  * drm_sched_entity_is_ready - Check if entity is ready
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d8972836d248..b5ceff75cbbe 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -341,5 +341,6 @@ void drm_sched_fence_finished(struct drm_sched_fence *fence);
 unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
 void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
 		                unsigned long remaining);
+int drm_sched_entity_num_jobs(struct drm_sched_entity *entity);
 
 #endif
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
