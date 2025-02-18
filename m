Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A19C021B1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10AB10E72C;
	Tue, 18 Feb 2025 16:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i9d5qGed";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A9010E71A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:08 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso527764266b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895247; x=1740500047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nBAG5oUEFX166qTyB90hWPLYYfHebcCnYQtV4T8ALB4=;
 b=i9d5qGedC1F1wSLfOy/4UhvmhMm2QyfeDLJ6RhqnNvmJVG0pRwM3fAwjfML1ouLPjN
 Uu9trHxL6YIR5B9cGETETwUdrxZV1+rS4oCRdldO5XuKR9D3XZ2vL9QPc2lHq8ws33Vy
 UrP7gmvNhJDp2s38W6odMI8wlOKCUFh1qYB1Kol9B9e0r8Mb5T0/HSMS8LUMx334TFFi
 P1H8SonhxnmkdR+y//p20+1Qks4c7R2GRcsPbXg8omH/FqSGqvXUQ+6eOJNTyps/nskU
 eT9RZAu6If7QtE22aDOBBcZVlebSKU7UEehzYSTAI80MGer7miUbbzjFhCh3AgVCR8n6
 h3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895247; x=1740500047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBAG5oUEFX166qTyB90hWPLYYfHebcCnYQtV4T8ALB4=;
 b=NfhU+6PCGWu3NoQW4as9AM0VkJBDpFPeqk3X9Qafa6EURGcwa1acRzb777xztShVzx
 tHsZw4wh6PEhdl3yCo/3bPdlNf7SvZR6/p6b4E7GkKwXcI1Cg/q6EA6Fw8wvI7AoSuti
 ptlKtmk2RJp2Bs9OiUABWOsy4IqDar+2V+jx1QrSmaSmf7MwV1mqeJxn+EfTHguiuBKM
 toH4mOtsCtdphgqJbkGrgvM68fvD3pRyEwwz2BjJF945XVBWQFyjrAN1DJQ6GQX2HLUZ
 GasM2sfjU7K8mHSuVhzyJKr5Y6Sji0R1Y7uDAod9WJLpwB5vffrE2Bl7k7tP//JROac5
 sFeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM+dIS+Tz+pV/xqkrip6rnlbhduzHuNnaYc7qDv2p4ter9fi5FWkttvM2sHEIvxsFu0bEFHSEP@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyat13K5wOPlHLg2FSegAG+k+qduqBHFnMih6VWT3ybtHO+Vaw9
 oFmapgd/VxEfNBSmJGq/hM77dmGc2nGURsmyiil44nYzfzMLUvB8
X-Gm-Gg: ASbGnctX+LrXGruTQBRMtcg8ROiBrZGc5Ks1tOn1x0XEH5jpTIBOwqwCA6NaTkRtOv+
 kXdNOW/s6qzhBSYNU/ZvpXk48htkIINqcYpG40RgVxIAO/3kAEJBQqQRwzUZJLDv2vB55IWdPBE
 PdnZ/26bN9oogg1yT/xrNMqrAzXQasa0shDtj62JkVBcS+AE4JD0Fjxs8ty1h3luEq/njXxysSS
 iiFVe+gubu5BOhC/c9nlmw6lEST+SpX8aIdl/p7KY/K2ZnJ/mXOigl8D9BIyAqDaldm8WV3Koc3
 ACQzA+7nz25JoAZWF63OnEizl7S/
X-Google-Smtp-Source: AGHT+IFnse/jh/97XT1xIU7lWU1MmnFNfSO85G+vYTuO4ZNRyD2y/WhGcGOuGNx9b2d40sjyhuXJug==
X-Received: by 2002:a17:906:3281:b0:aaf:ada2:181e with SMTP id
 a640c23a62f3a-abbccf09153mr21466966b.26.1739895247001; 
 Tue, 18 Feb 2025 08:14:07 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:06 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: add isolation trace point
Date: Tue, 18 Feb 2025 17:14:00 +0100
Message-Id: <20250218161401.2155-7-christian.koenig@amd.com>
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

Note when we switch from one isolation owner to another.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f1369c60565c..a3abe36a59b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6846,6 +6846,7 @@ struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
 		dma_fence_put(isolation->spearhead);
 		isolation->spearhead = dma_fence_get(&f->scheduled);
 		amdgpu_sync_move(&isolation->active, &isolation->prev);
+		trace_amdgpu_isolation(isolation->owner, owner);
 		isolation->owner = owner;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 383fce40d4dd..e8147d9a54fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -457,6 +457,23 @@ DEFINE_EVENT(amdgpu_pasid, amdgpu_pasid_freed,
 	    TP_ARGS(pasid)
 );
 
+TRACE_EVENT(amdgpu_isolation,
+	    TP_PROTO(void *prev, void *next),
+	    TP_ARGS(prev, next),
+	    TP_STRUCT__entry(
+			     __field(void *, prev)
+			     __field(void *, next)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->prev = prev;
+			   __entry->next = next;
+			   ),
+	    TP_printk("prev=%p, next=%p",
+		      __entry->prev,
+		      __entry->next)
+);
+
 TRACE_EVENT(amdgpu_bo_list_set,
 	    TP_PROTO(struct amdgpu_bo_list *list, struct amdgpu_bo *bo),
 	    TP_ARGS(list, bo),
-- 
2.34.1

