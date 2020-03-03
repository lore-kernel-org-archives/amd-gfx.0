Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA4FC3F2CD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 12:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE06E2073B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 12:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBUTqKJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE06E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE656E86A;
	Tue,  3 Mar 2020 12:47:27 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B071A6E86A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 12:47:26 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r17so4171282wrj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2020 04:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4nmJJCE99t6es50j+fmSEPecEnsldOOshCaiigefW3w=;
 b=OBUTqKJvJOj4eWqQSX46ulscZIw71q9IZWKkGd8k5R2/FPGWP9cJHJAjl+FinLFjC2
 aAdKTMmbtgTt7agjqYUU01Jf/ywBr5/P02wQTxXL3JRzZS1cUM34cXoMdTClzcsQrYbY
 VXs1JN2CFsZ/QrkoIbAar4sT8ehOgwMVDC2oGqZVRbbKkIQKzYfwknx15fJo/eK/nJm4
 8k/h80Y7p5xO4fHRaWnlvSiiubO3FuH0nVzdMKhunz7ynQfO+ddSrHh1UZMOkRverAXV
 YDXLXsldutt+r5eucJci7rpuZZ/PCxVU9PzJ9i3Ujsy0/QkOlODATC3HORXa4V7PFxoi
 HUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4nmJJCE99t6es50j+fmSEPecEnsldOOshCaiigefW3w=;
 b=aRm5DihFrZBym9RoQCbsqn0nc/blS5U4YAMXWq8/+6uK6AvP0nj1CCZR6xJMl0ksxC
 gbtxuI3p3QHydUAYKHtcbwVwpsgEFnUp9xrWTPE7sExQOB8W5StCv9MHHSTqYj/sRdWd
 eSGJQFQ+rLC968+MOyAL3fVtIcseUKOSbJABGNB4xVAjIm+C8aBx5Cl8HpCtQx4MdYVm
 /JeMEDLgHM8VvVQbHVUBtLU0HQ7KpLFSFh1M6Eeo3+V3Pw0CgPyPJYqg6hKAG/G0aHoH
 WqVjVaK1QIKA1bBWdtPY8RtaVZqpp3cduZi4mZW5bcqMXqDkcAznfI13WdYqCoE2PcHL
 KI+A==
X-Gm-Message-State: ANhLgQ3KhmaDemnZ7nqIAnSUmbmtI+Pl4BAQVpmvt2wke0W+Exh/rulQ
 oeA0sYAM/xI/vki8Vy1e3lDipvLr
X-Google-Smtp-Source: ADFU+vuDe9xDox+3vHmkfW2Zm0H9OvSGsv7CxKyFykQrsZRUvIECE0Xdq6hR6K63RIB4Pj0FhofYXg==
X-Received: by 2002:a05:6000:1246:: with SMTP id
 j6mr5069956wrx.233.1583239644998; 
 Tue, 03 Mar 2020 04:47:24 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F27F600CCD821CDE339F0DA.dip0.t-ipconnect.de.
 [2003:c5:8f27:f600:ccd8:21cd:e339:f0da])
 by smtp.gmail.com with ESMTPSA id x8sm21760468wro.55.2020.03.03.04.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 04:47:24 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 3/4] drm/amdgpu: change hw sched list on ctx priority
 override
Date: Tue,  3 Mar 2020 13:50:38 +0100
Message-Id: <20200303125039.53141-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200303125039.53141-1-nirmoy.das@amd.com>
References: <20200303125039.53141-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 32 +++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8c52152e3a6e..a0bf14ab9d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -522,6 +522,32 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 	return fence;
 }

+static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
+				   struct amdgpu_ctx_entity *aentity,
+				   int hw_ip, enum drm_sched_priority priority)
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
+	switch (hw_ip) {
+	case AMDGPU_HW_IP_COMPUTE:
+		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
+		scheds = adev->gfx.compute_prio_sched[hw_prio];
+		num_scheds = adev->gfx.num_compute_sched[hw_prio];
+		break;
+	default:
+		return;
+	}
+
+	drm_sched_entity_modify_sched(&aentity->entity, scheds, num_scheds);
+}
+
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
@@ -534,13 +560,11 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
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
