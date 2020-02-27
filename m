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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FDC3F2C2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470D324690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aocTQcQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470D324690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087B66ED59;
	Thu, 27 Feb 2020 21:37:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058C16ED5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:37:15 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id q9so1045302wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PyatC3fxYrj+gpd6e/Ac8d8Mz1L80FKL6a5A9NPGodk=;
 b=aocTQcQw0nWj4h0/OBCt0cNcx0YNcTQX2ho4kuuV74xLTVnLoQWKWctXjfJEtOnaS1
 vN6brvxN5LNk8UjmeFWkvkHq8FyPw6DBFtIV/czvmzkADXZdYrgxXlw5XC+UfaJ9RT6A
 YFK5lS9l+8sbUbw+1kibKnhYqySyke6braWhy6DGxfeFs6VkEbi9F2v+Ud44W4z9Ml2H
 bpfLVaPifRxYTSFydHXiwVM4eefWBRIOobs45RsCyzXndWTuLrsgZ92KNuQq5b8CHAc6
 ZyZdxt9PSS7ORJGdaHpMhjqhjLOs+JFQ/UBTJcjMmsV6VyaV9dlkuHt+yqKgNaU963//
 3Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PyatC3fxYrj+gpd6e/Ac8d8Mz1L80FKL6a5A9NPGodk=;
 b=Jcwj9N57INlwzDZkcI5hPSKyzplQ9zSVLObJhI0d5q1ve5o97z87EW7iUEVV6HvaDE
 ZkpRsp9F7L7uLeZirYWYRKqglMBTtl+E7jsOixwkEtFaD+FJtZQcNqFeEkZZV7GNII5v
 i2Qy4JE5m/67XEdoYbG4R9pkhg9szwu1L3d5eeS1rT8ahFzRpSV5m0RL5r8rMg+TpkWM
 G1YUiFa3fO4FU28fQVNYF98zGiZY1rrdR5EI/6urQrfov9/mr/Su8R59TByULS1PIxt9
 yPdxSeL4l3HoXz7gkMshNJcwR0O+OaeIdnhdBq/Q+03Av8YuZCUJbi90YrtCzLl/nrvQ
 vZcQ==
X-Gm-Message-State: APjAAAVE62BLPSDuBs8btplMjBHYhypnIZ0GD7WO/TKibJ7MKSBo85e6
 zmwWLEhCVugrGzgR10rbPuLcAeIl54zNYg==
X-Google-Smtp-Source: APXvYqxyHqAy3gtvt3j0FJ7c6+HHFQocSdLGhmyk3eZ1XX01evJ7x5yCODuvTRb+vq+fmjMdDkxAUA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr737542wmf.75.1582839434280;
 Thu, 27 Feb 2020 13:37:14 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2AB800008CB0F3CB6E896B.dip0.t-ipconnect.de.
 [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b])
 by smtp.gmail.com with ESMTPSA id a22sm9281341wmd.20.2020.02.27.13.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 13:37:11 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Thu, 27 Feb 2020 22:40:11 +0100
Message-Id: <20200227214012.3383-3-nirmoy.das@amd.com>
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

Switch to appropriate sched list for an entity on priority override.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 54 ++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index a1742b1d4f9c..69a791430b25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -508,11 +508,53 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }
 
+static int amdgpu_ctx_change_sched(struct amdgpu_ctx *ctx,
+				   struct amdgpu_ctx_entity *aentity,
+				   int hw_ip, enum drm_sched_priority priority)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	struct drm_gpu_scheduler **scheds = NULL;
+	unsigned num_scheds = 0;
+
+	switch (hw_ip) {
+		case AMDGPU_HW_IP_COMPUTE:
+			if (priority > DRM_SCHED_PRIORITY_NORMAL &&
+			    adev->gfx.num_compute_sched_high) {
+				scheds = adev->gfx.compute_sched_high;
+				num_scheds = adev->gfx.num_compute_sched_high;
+			} else {
+				scheds = adev->gfx.compute_sched;
+				num_scheds = adev->gfx.num_compute_sched;
+			}
+			break;
+		default:
+			return 0;
+	}
+
+	return drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
+}
+
+static int amdgpu_ctx_hw_priority_override(struct amdgpu_ctx *ctx,
+					    const u32 hw_ip,
+					    enum drm_sched_priority priority)
+{
+	int r = 0, i;
+
+	for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
+		if (!ctx->entities[hw_ip][i])
+			continue;
+		r = amdgpu_ctx_change_sched(ctx, ctx->entities[hw_ip][i],
+					    hw_ip, priority);
+	}
+
+	return r;
+}
+
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
 	enum drm_sched_priority ctx_prio;
-	unsigned i, j;
+	unsigned r, i, j;
 
 	ctx->override_priority = priority;
 
@@ -521,11 +563,21 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 			struct drm_sched_entity *entity;
+			struct amdgpu_ring *ring;
 
 			if (!ctx->entities[i][j])
 				continue;
 
 			entity = &ctx->entities[i][j]->entity;
+			ring = to_amdgpu_ring(entity->rq->sched);
+
+			if (ring->high_priority) {
+				r = amdgpu_ctx_hw_priority_override(ctx, i,
+								    ctx_prio);
+				if (r)
+					DRM_ERROR("Failed to override HW priority for %s",
+						  ring->name);
+			}
 			drm_sched_entity_set_priority(entity, ctx_prio);
 		}
 	}
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
