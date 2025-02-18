Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686E5C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183C910E3F1;
	Tue, 18 Feb 2025 16:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fij00q3J";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C63A10E71A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:09 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so5866464a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895248; x=1740500048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eROlXzVaNbmB7tdQFQMdzP6QtGskM157qfeMp31iCXc=;
 b=Fij00q3Jcyv1BK84NoktetXhAGPPQF8Qwm+O+QICu/FTnW9M2HusrYznbVpbqXLdIM
 NeXjMIjdFZh2uJfXJSQg/Mf/7Bhu70iCP55eX891gJwoV3+O+/S/ZotcgfZa2Q/R0qYG
 cTacyJDOD7ZfcUYyzeE7zh/t1gXaKKNbIQ1AqbA8/7+fOQZPoJatSLPGZsgYSSIGhKzK
 olb59d45VioLie7nSVKh+M30UfDvQyi+NOlTAhRBaUxLV+yGdZ8aRV6nXf3NBY6eEEyP
 RVbC9CEW7jAW9mzHdR6F90nOrAtQwLWSc7snrEAEscJbA3xdtbj/KC5TPELKfYGS9NG/
 1A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895248; x=1740500048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eROlXzVaNbmB7tdQFQMdzP6QtGskM157qfeMp31iCXc=;
 b=LqUK6hm2Pw/gnqRiWaWqUzu5zxVzrwuEu7lo02W1T7B9AsWIhrZkUrOYSrSg0CTmV3
 K/f9cJOmw0aVhdCkP6AXD/o2DKYJhudt7JiSv+XjRu/4J2rZAeMxoKrpx2YnlcDwGHKM
 xmLv1vG5XRbAVUCIg/WqP1r6TyFfR65GeOFNSWveazZC752AiobH0B7Ulw8uiVH5xRGS
 FFfcvN0GRpjZbxE/bg9YhcD35TpF4cBRHzzh6dw4OF48VvUjUiXi2nHy0GChbmGaSKBR
 0grTTsq2MfQmc7Ac0UVHhTnz+NJ0IPts1PAHJwo2jTlsZfI9VfcheaK5yY90ETkDO6Ol
 PHRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqdFY5TYZFKB9rj588tC7kt57YUygWEZsXzEuy9BHxM+2E69WXQsoDUGYq2YMM6s/jS2MPVi5C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwoyNnLKhsyxQktizzDJ8JdDCPcQRBGFRryGblT/09a0+cjhu4
 +uxwWDrWZKXyKFylPKNXNjYFKDdcZs7ZtEYApmFgHJFgzhq5wMSpLzqWwxuczac=
X-Gm-Gg: ASbGncvQkmTJYZRGpTbzxYmCT2ZFcvUBGGMJ1cPYS9cmkl16ucNygf6kTg9CYn6gokB
 7Gh7PRkjzZEpg+BMpSFAz5DPD8GSoLvg0Lle8v2yfmW0tLXBkl4r+YrcAGthnFi7P8y8E5SMzTL
 zduYZQjoUbUAqAsa2xO6TgZd3QusZHtxOhGpvCG3tix/OqnyVJuz9LgB/hcOyhotTDmB65m/4dn
 q6DCJoNXYtMzb9YOu7409wHEfZgcIlSD6sfuPt2G7m9iq2+UKrpybvEnV3e16QLOu2IIUS6msiY
 HVAyfL2S/4rUf/92mBoUlEWhYPD4
X-Google-Smtp-Source: AGHT+IF8SrpQMv6sIloRUge1hbgukVVhyZOaQmtZ3U8sdKsQD0zHKF9bPM93ukjEbz6q/oKc0MVyTQ==
X-Received: by 2002:a17:907:360a:b0:ab7:e8d6:3b21 with SMTP id
 a640c23a62f3a-abb70da4172mr1395735766b.28.1739895247557; 
 Tue, 18 Feb 2025 08:14:07 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:07 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amdgpu: add cleaner shader trace point
Date: Tue, 18 Feb 2025 17:14:01 +0100
Message-Id: <20250218161401.2155-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218161401.2155-1-christian.koenig@amd.com>
References: <20250218161401.2155-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Note when the cleaner shader is executed.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index e8147d9a54fc..11dd2e0f7979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -474,6 +474,21 @@ TRACE_EVENT(amdgpu_isolation,
 		      __entry->next)
 );
 
+TRACE_EVENT(amdgpu_cleaner_shader,
+	    TP_PROTO(struct amdgpu_ring *ring, struct dma_fence *fence),
+	    TP_ARGS(ring, fence),
+	    TP_STRUCT__entry(
+			     __string(ring, ring->name)
+			     __field(u64, seqno)
+			     ),
+
+	    TP_fast_assign(
+			   __assign_str(ring);
+			   __entry->seqno = fence->seqno;
+			   ),
+	    TP_printk("ring=%s, seqno=%Lu", __get_str(ring), __entry->seqno)
+);
+
 TRACE_EVENT(amdgpu_bo_list_set,
 	    TP_PROTO(struct amdgpu_bo_list *list, struct amdgpu_bo *bo),
 	    TP_ARGS(list, bo),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5323dba2d688..0a75d8d1a0f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -742,6 +742,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	 * finish before we push them to the HW.
 	 */
 	if (cleaner_shader_needed) {
+		trace_amdgpu_cleaner_shader(ring, fence);
 		mutex_lock(&adev->enforce_isolation_mutex);
 		dma_fence_put(isolation->spearhead);
 		isolation->spearhead = dma_fence_get(fence);
-- 
2.34.1

