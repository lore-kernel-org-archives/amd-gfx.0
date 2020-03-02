Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B021C3F2D4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01829246B4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRqLaa+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01829246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC6E6E22A;
	Mon,  2 Mar 2020 09:49:25 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3595F6E228
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:49:24 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j7so11586875wrp.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zkoxhagDWKFP5efnQ+l6swtnTjbAJlh9ApGG35DMub8=;
 b=uRqLaa+3PvXMfrQMVkT1bI1a35xjQoADEeo0k7BCOeby+6LwKAYKoQk1mPiauzSteB
 ryT/VxQ+OMGnC12QH+5KdRy6UO1vFuiHrgFNrdjV9Oqrug7wgx4aK1jVBsl6vPcZlT+p
 P16k39iRCzuHgwFrZ6ep44afrc43RBSWlH32T77mRZAjST9LJy/nN6RLhar/Xz6O3K8e
 Q+GE9XIe+dk8n/C0j68WrTnX9J/iJh/3G7uRrxUH4kYaua4RApcQOm7iB7Sh0pka6KAH
 SOmkNdT6FG5Ms68ZiKkLcOzhoOVchQIU/C3JWYiXmFt7OiJowL68uT75u/IHBUHZZhuF
 29Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zkoxhagDWKFP5efnQ+l6swtnTjbAJlh9ApGG35DMub8=;
 b=qYDVUZ2ZM1yNbaNqrxy1BAFpWpsMcxypHYP8Hd+41CBZa+6QDxnEe3aaBKrjPjiqVd
 kIimIa/ErPs4jfPOC2pAc+od2K+Dk+tl7M5EalWTTsRFHbvOETXk1wkLp7IILi1YfXct
 uj/DWyJQQyduuoN4tW703qxE9VIDpn8/bE8H36EEeY8yjphZmBbUuwtMwLNaxrO4qLf6
 TsY/5urdHG+baVBXZJNxEuw1LtsneMQXFAcZ1fFzJ6o20rIF5n8iClcBKakbceJJNQg3
 kZd3SiOwsr06n0oKAkdpEI55WupBdNldKVWlg9m2xulQQu46NGOVehqgD4yEwdaPsmw1
 v2Rw==
X-Gm-Message-State: APjAAAWVohvJ5BkEnm6MF6C8u7dMlECZUycYcBvK5GiYKV0tZ1091TdV
 wyKbEAjRpHh37JeklMhkrX//iXOK7EM=
X-Google-Smtp-Source: APXvYqwydTCESUwDSO5MVNa9bk36u7bdDHVQK6yd4eW0WSDXy8993QK9somDEelXwRj231Pv3ZucUg==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr22572479wrs.360.1583142562631; 
 Mon, 02 Mar 2020 01:49:22 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F21FC009E54A4A7C1B66128.dip0.t-ipconnect.de.
 [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128])
 by smtp.gmail.com with ESMTPSA id b13sm511230wme.2.2020.03.02.01.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 01:49:22 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Mon,  2 Mar 2020 10:52:33 +0100
Message-Id: <20200302095234.3638-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302095234.3638-1-nirmoy.das@amd.com>
References: <20200302095234.3638-1-nirmoy.das@amd.com>
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

Switch to appropriate sched list for an entity on priority override.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 4266da1f3977..57445a61a4cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -522,6 +522,30 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }

+static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
+				   struct amdgpu_ctx_entity *aentity,
+				   int hw_ip, enum drm_sched_priority priority)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	enum gfx_pipe_priority compute_priority;
+	struct drm_gpu_scheduler **scheds = NULL;
+	unsigned num_scheds = 0;
+
+	switch (hw_ip) {
+	case AMDGPU_HW_IP_COMPUTE:
+		compute_priority =
+                                amdgpu_ctx_sched_prio_to_compute_prio(priority);
+		scheds = adev->gfx.compute_prio_sched[compute_priority];
+		num_scheds = adev->gfx.num_compute_sched[compute_priority];
+		break;
+	default:
+		return;
+	}
+
+	drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
+	drm_sched_entity_set_priority(&aentity->entity, priority);
+}
+
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
@@ -534,13 +558,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 			ctx->init_priority : ctx->override_priority;
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-			struct drm_sched_entity *entity;
-
 			if (!ctx->entities[i][j])
 				continue;

-			entity = &ctx->entities[i][j]->entity;
-			drm_sched_entity_set_priority(entity, ctx_prio);
+			amdgpu_ctx_set_entity_priority(ctx, ctx->entities[i][j],
+						       i, ctx_prio);
 		}
 	}
 }
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
