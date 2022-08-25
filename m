Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C458C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9821310E00D;
	Thu, 25 Aug 2022 13:32:22 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E459710E02C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:55 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id gb36so39524303ejc.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=Du2H+1LHqmRk5wDNIXh0eWpxBzenWnaClwVmtpI6nqBd8GxFKeon6ocf5TfngBJp9f
 M2ezg6qumvGiaPBat7O9M61ZiCzzEeTgUaIwQoonNz96CGQl9hqU443xba+bq2S22/yg
 3WrXPvuOccyaiYfZ82D1AglmdYrDDiPY4+P93dSuNfPquG0HxGUVwV+o77mF4CZurO6r
 k49hm77wnWCUXJSgxl/YhWY4KcpZlW+9zmYneXBSHqrHXQpI+Fj/KALI4ZEdceD3NIaW
 RrTiGtykMUN8E2U6IqBRMcSNF6j/tQFk677XovfALg17qs8WeP4MtLYKlhWJCY2Ca7N7
 uIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=icgCteisaexmAIAZXtioqT7K08Y6EwFK3TH+dhBsBcQ=;
 b=u9hs7GBnzEVRNvlKOwTzj/Htz/oHdCFUO7WFCINzoLnQqOyxSuiSjeejX+CnsaHHVk
 P84g2Zm7ycHzPt9BTl7rcGN+TtK0HRErTJHdQ7ljqDK3TmDlT3cCf9wjCaFRpn7MQ6zu
 LKmaX0nDRtKHv+VrVRFyb74DFfMiI81ggv98zgJp0S2RatVGGRgMglvGe4vEJfHvLX4u
 c9tb/p+vSKgh4UcKjMAOL85e4/S3VLp11Byrf10NWwnhULnGbiqJRQzy0QdhOP3T+9o2
 Zi4v9benDpeNnQmG/oPRUo1buZFobvmiHjH9ByDQFJWnxqhoZX8JG3FRfTlDeZkEmGfK
 cSxw==
X-Gm-Message-State: ACgBeo0WHgmW+X29jRt8BN0EDfwLZxeZ0o3rXpiyS+utjI20wVgAslTi
 hMyUiTgVMeTPOmTpLqqz3bqte1wwXB4P1g==
X-Google-Smtp-Source: AA6agR4gLzrCF/zsAGeaZY8OVnwi4AjmuN4z9ZP5kWcN7mO4Bq5JmpwYhQnVWOeuDET5NhM3mWlhzA==
X-Received: by 2002:a17:907:842:b0:731:3310:4187 with SMTP id
 ww2-20020a170907084200b0073133104187mr2408255ejb.578.1661434315554; 
 Thu, 25 Aug 2022 06:31:55 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:55 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] drm/amdgpu: cleanup instance limit on VCN4
Date: Thu, 25 Aug 2022 15:31:39 +0200
Message-Id: <20220825133142.8272-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to what we did for VCN3 use the job instead of the parser
entity. Cleanup the coding style quite a bit as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 46 +++++++++++++++------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index fb2d74f30448..9338172eec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1327,21 +1327,23 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p)
+static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
 
 	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&p->entity->fence_seq))
+	if (atomic_read(&job->base.entity->fence_seq))
 		return -EINVAL;
 
-	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
-		[AMDGPU_RING_PRIO_0].sched;
-	drm_sched_entity_modify_sched(p->entity, scheds, 1);
+	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
+		[AMDGPU_RING_PRIO_DEFAULT].sched;
+	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
 	return 0;
 }
 
-static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			    uint64_t addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va_mapping *map;
@@ -1412,7 +1414,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-		r = vcn_v4_0_limit_sched(p);
+		r = vcn_v4_0_limit_sched(p, job);
 		if (r)
 			goto out;
 	}
@@ -1425,32 +1427,34 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
 #define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x00000003)
 
 static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job,
-				struct amdgpu_ib *ib)
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
+	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.entity->rq->sched);
+	struct amdgpu_vcn_decode_buffer *decode_buffer;
+	uint64_t addr;
 	uint32_t val;
-	int r = 0;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
-		return r;
+		return 0;
 
 	/* unified queue ib header has 8 double words. */
 	if (ib->length_dw < 8)
-		return r;
+		return 0;
 
 	val = amdgpu_ib_get_value(ib, 6); //RADEON_VCN_ENGINE_TYPE
+	if (val != RADEON_VCN_ENGINE_TYPE_DECODE)
+		return 0;
 
-	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
+	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
 
-		if (decode_buffer->valid_buf_flag  & 0x1)
-			r = vcn_v4_0_dec_msg(p, ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-						decode_buffer->msg_buffer_address_lo);
-	}
-	return r;
+	if (!(decode_buffer->valid_buf_flag  & 0x1))
+		return 0;
+
+	addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+		decode_buffer->msg_buffer_address_lo;
+	return vcn_v4_0_dec_msg(p, job, addr);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.25.1

