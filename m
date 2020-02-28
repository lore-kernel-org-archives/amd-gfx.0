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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0447C3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970FE2468E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJBuwLiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970FE2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AFD6F467;
	Fri, 28 Feb 2020 14:36:47 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FBA6F465
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 14:36:45 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y17so3201281wrn.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o3iZYv9aTcsoC53P0H04vS89Spx+uIGkCYyAmss2CB0=;
 b=uJBuwLiEXZuN35XT0GIICZGreJx0RdfxfBmdRrEWOL/N5RZ101b8XHx8veb0oJAlp4
 VRDQB+GNpobfktaZv+CPMsgAbjlemEeDGmXWmgxcGudE0K88febKwZZlpERo2x5Mqr7L
 ukQXPQuyh2OdjIhUQRiynoA6b1RVHfknnckFwTvqAFRe0r1Empgaz43wcV7GvYkKDbSS
 4C8bIk121bhgJfVIxumjV7gDYSLpDP6EG+FTEYvBbwk8/eUy9Ku/VUUYJGcTM1g95e9p
 aBD0c50eBbRs6zOsKMTpQ1gZOoUkFdkzlPD7yeiIWbL2/PySmPV/V2M3fTNAJF8yVr9Y
 kVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o3iZYv9aTcsoC53P0H04vS89Spx+uIGkCYyAmss2CB0=;
 b=rOmX+sXPo1H+FRSuN3rWN6JWVqPkYw0/ypw0tPnUGxXeGqi+W59fvXTNWarRJQS5fi
 WoWFEKDgCjFhte2p4kvZ5a40AwE0071PVP6GescaUNOdCklYH4JxYRkdfTHHYlwwsnXW
 6b9/uxf3L7DW7DbUuVV0OazGa4k9ZNQGQnFQcngmpOkYSi1FK96AWNn7wlHd/PiP45fs
 chh72/JWKuKRKvdS+kBd6f22jNzc37Y752GgnheVikxc0BS72rPVCgoaoD5DgYXiRzK9
 U+SyraeNu8kc29ymqlvdnPQHQ5YK5+3ZUFeZvg7ZGUNPnE2Tp9kRKzxMO1lrYABIfYCv
 KIHg==
X-Gm-Message-State: APjAAAWvcZC1GDQO1qaCPbVDLtFtnAyhshR5wc5WXI3aMdR6K4I89iS9
 lqej2+WFOjhJZW3qgLRvOCdgA6sVtke3oQ==
X-Google-Smtp-Source: APXvYqz5oft+2OPJPhUxRDbzYHDPO6b1+1JUYHYpL+C6UDcLhhzyF/d1zTpMOK/P6nFGSWI+CNbQYg==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr5045156wrm.75.1582900604303;
 Fri, 28 Feb 2020 06:36:44 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F28EF00805E149DBFE09C45.dip0.t-ipconnect.de.
 [2003:c5:8f28:ef00:805e:149d:bfe0:9c45])
 by smtp.gmail.com with ESMTPSA id m125sm2445471wmf.8.2020.02.28.06.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:36:41 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Fri, 28 Feb 2020 15:39:40 +0100
Message-Id: <20200228143941.4919-3-nirmoy.das@amd.com>
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

Switch to appropriate sched list for an entity on priority override.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 27 +++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index b21771b37300..3744c689affc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -502,6 +502,27 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }

+static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
+				   struct amdgpu_ctx_entity *aentity,
+				   int hw_ip, enum drm_sched_priority priority)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	struct drm_gpu_scheduler **scheds = NULL;
+	unsigned num_scheds = 0;
+
+	switch (hw_ip) {
+	case AMDGPU_HW_IP_COMPUTE:
+		scheds = adev->gfx.compute_prio_sched[priority];
+		num_scheds = adev->gfx.num_compute_sched[priority];
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
@@ -514,13 +535,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
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
