Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E15C10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148A420727
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 13:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luUdPXYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148A420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C987F6E44E;
	Mon,  9 Mar 2020 13:30:10 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0875A6E452
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 13:30:09 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id x3so21309wmj.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Mar 2020 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p/xGbDNg7GciAGI08f7BxH3kLvO5GdLpdNbnLb2tVnk=;
 b=luUdPXYHtaa3qqTciyvXRqSc8S+b44Fb7/0+YKpJ1+IQom0B0JuVQ26srC1ZrXOytr
 mswV3EZgYUW6b/zTS0mMTRBjVZF6F9yMeYL4toMQgU+7biX73oEdLUgIJXQWlvXzXOiN
 YDVlsgBNcCq+UgFakZ5yW1oB2yR79z6mBdPGd75/XXX1ZmosG/UrxBTIoSoRTF7H+kX8
 gVuSmxaRkylvks+ZPAOj/QUEOSd0yVdckA+Mb9Jj2mP/2YETAyxujQGaLZSZZMfkNhpb
 wW1fsRW+gscIpO0T/a53V7KvseqkDlnWU02M9BkGkLgTAZCSc0GFZhrsXGKPXzd6E9je
 d/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p/xGbDNg7GciAGI08f7BxH3kLvO5GdLpdNbnLb2tVnk=;
 b=C4JlSAao/UjSkfDRE/i0eBi/5WAowMMWryjh8kGai9V1cUclaEUJ4H7XRkE0F9j5D/
 enPESJkIzgnUVBjwa9svVTcm4M2G5TveSEt4QeCohjLz8AtsEMhWdmHk/XPAsmVrXixJ
 USKv4yMDH4AQEOV/eiqyP8V5viTRCWxgZvlKo2Ludi0CgKS+AOtLY5e8aKTnpV4XYYap
 fyMxRGzeLn6m/eJNALkat4wLl5/YpH9tH9VlSrlLPp1+3gzYfYLmAFwgT7PGMmS8x9Py
 qip5+83R/ygFn9NdGZDGGYZoBdw2gIPR9DMecu13vrl6wrChC4pN2D4wmuHCDV6g4ASE
 zO+Q==
X-Gm-Message-State: ANhLgQ2ANcPTz/f2bs4AWKwKqFgPWnkK6iUq0398qgLLkQqq9ZJPssJL
 JP7hlCU6itNULsesYf65kWX9yqwX9m0=
X-Google-Smtp-Source: ADFU+vvP/NsCUC0MWGQ3MYDJECPmux6X29xQyvuw9VZlvpS58c79ceEtvkn1nuFe4fLLjl8whsN6tQ==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr20046778wmj.27.1583760607307; 
 Mon, 09 Mar 2020 06:30:07 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2ACB00753B9E7FA9FFF13D.dip0.t-ipconnect.de.
 [2003:c5:8f2a:cb00:753b:9e7f:a9ff:f13d])
 by smtp.gmail.com with ESMTPSA id i12sm47009640wrw.64.2020.03.09.06.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 06:30:06 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Mon,  9 Mar 2020 14:33:24 +0100
Message-Id: <20200309133325.66024-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309133325.66024-1-nirmoy.das@amd.com>
References: <20200309133325.66024-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 29 +++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 1d05eb64b885..3b2370ad1e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -515,6 +515,29 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }

+static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
+					    struct amdgpu_ctx_entity *aentity,
+					    int hw_ip,
+					    enum drm_sched_priority priority)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	enum gfx_pipe_priority hw_prio;
+	struct drm_gpu_scheduler **scheds = NULL;
+	unsigned num_scheds;
+
+	/* set sw priority */
+	drm_sched_entity_set_priority(&aentity->entity, priority);
+
+	/* set hw priority */
+	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
+		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
+		scheds = adev->gfx.compute_prio_sched[hw_prio];
+		num_scheds = adev->gfx.num_compute_sched[hw_prio];
+		drm_sched_entity_modify_sched(&aentity->entity, scheds,
+					      num_scheds);
+	}
+}
+
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
@@ -527,13 +550,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
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
