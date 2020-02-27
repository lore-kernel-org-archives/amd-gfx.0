Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D9C3F2C2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED3624690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opR3tOSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED3624690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3896ED58;
	Thu, 27 Feb 2020 21:37:15 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349526ED4C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:37:13 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z15so650143wrl.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aRcqUZ+qCodUJmvmCB2Uu0He8SpxVngQwVogyBu4P24=;
 b=opR3tOSooaA/YS/z06GPw6xa19Ah6nQdias4WiuZalvLY+k8xRhQIuZidQsrwbsYHx
 WxlfL9CLJjEOGatQvjNzimQqL9LaWYUBAy42N9t4xHpPCYZZtD1waEpN5AaMRh6J07eG
 zsHMRJkRJ1snXAF07pIQA4Yx9fFJgYCkoA7iwJiW0oTEyU5u8yRUNiSu+SdiDsdFkpug
 Jc7C+OxpAvZwX62HgVEduLqTG0AFLiFr9tH/mZSPswrIaCKDPJHXhPHTWedaI0QjH8m1
 dVPrfaV3nBghOpiV9XaXSKrbH1Rb6tEjloJS9Hi2ZTuP8fyaJIsiPkkwo2HpSqdmQ3Ok
 kDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aRcqUZ+qCodUJmvmCB2Uu0He8SpxVngQwVogyBu4P24=;
 b=Um9iD0FiyI1MYBL05xJm5fhfw/F/GCdvDp+n48MuZhOCWw949fAFSbCKXfMYKUgIzN
 saQXEgx6WeFEYwNUJYHto7CfuqUxLJgYnBAWobZ3l964/qXhw/FZIVAD1/6ng/FeZWCh
 QuwroaJUzJ6yaIV0PlkDh6d5glsLOZfiiWlWEYvCvCXonRzSTTZLv3gVpBPxfYokOViq
 IjLTpgUjjijIKRMKdmVfaRAHQrvFLi0y6cxme4+DrrJvILZ6r6COV9857C+nONWA6s0w
 KIvcbRf9M+bwlNa9rw3gu3wOQLWskZFvHHrIziwID0F+YoJbXG/TO5g9ls6C8etI5s9Y
 eg9A==
X-Gm-Message-State: APjAAAVPWEDbwfM0v9OH8MK8+k/a/5/nENFcwu2KihS5kQxYP7wigQTq
 UoKG7PrtQ9D2wdYW5/UELhQKFCDikZlDgg==
X-Google-Smtp-Source: APXvYqxTQkA9kH1ns4axbi+s3KfRwchig0q28k/4kbTWMImwGFB4GcSaZEYWmny4zjljz2lWp/lOPA==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr913855wrv.105.1582839431518; 
 Thu, 27 Feb 2020 13:37:11 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2AB800008CB0F3CB6E896B.dip0.t-ipconnect.de.
 [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b])
 by smtp.gmail.com with ESMTPSA id a22sm9281341wmd.20.2020.02.27.13.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 13:37:10 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/4] drm/scheduler: implement a function to modify sched
 list
Date: Thu, 27 Feb 2020 22:40:10 +0100
Message-Id: <20200227214012.3383-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227214012.3383-1-nirmoy.das@amd.com>
References: <20200227214012.3383-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/scheduler/sched_entity.c | 24 ++++++++++++++++++++++++
 include/drm/gpu_scheduler.h              |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 63bccd201b97..711e9d504bcb 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -83,6 +83,30 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 }
 EXPORT_SYMBOL(drm_sched_entity_init);
 
+/**
+ * drm_sched_entity_modify_sched - Modify sched of an entity
+ *
+ * @entity: scheduler entity to init
+ * @sched_list: the list of new drm scheds which will replace
+ *		existing entity->sched_list
+ * @num_sched_list: number of drm sched in sched_list
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
+				  struct drm_gpu_scheduler **sched_list,
+				  unsigned int num_sched_list)
+{
+	if (!(entity && sched_list && (num_sched_list == 0 || sched_list[0])))
+		return -EINVAL;
+
+	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;
+	entity->num_sched_list = num_sched_list;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_sched_entity_modify_sched);
+
 /**
  * drm_sched_entity_is_idle - Check if entity is idle
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 589be851f8a1..0c164a96d51b 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -297,6 +297,10 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched);
 int drm_sched_job_init(struct drm_sched_job *job,
 		       struct drm_sched_entity *entity,
 		       void *owner);
+int drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
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
