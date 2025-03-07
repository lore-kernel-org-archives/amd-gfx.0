Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B62C28B23
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224EA10EB69;
	Fri,  7 Mar 2025 13:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQmR0WGw";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3667510EB66
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43bdc607c16so14599355e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355302; x=1741960102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zg7lu3sDkoafamX16TS4I5A95+RcajYB0S2JekUNWNo=;
 b=PQmR0WGwQnaZNmkWW7xwwqzL+syxy9aGfCGosnjIfG7I18PSt3JyvNNXlD4s7cklXZ
 F6DUegeEmF+R+5mka5vYpGmINt/9sslY3cizBECT5e75b27wZL8fkd3YhoCORHVcu0xH
 VATVQuvgtMbbMAKwxiSdFQAk/coX/QwZyFoHAyOBD6tvYIppVvlQ2/5l1VtylwMAem+U
 XGnmyQXunZ+lDohCX3fU/3dnpS4JyLyOsuEGyBleBTXCSM5E7nkilyAuaSzzm881ed8x
 6ok/8nniSOA09aucQa8pbfOteWgyIrD9Gg+Gd/NvQWbAg/R3nrLcPxcOZH8xfG/7Wdba
 ucnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355302; x=1741960102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zg7lu3sDkoafamX16TS4I5A95+RcajYB0S2JekUNWNo=;
 b=Hrm56oyTyQUxR2OSDtkCW3a1+/jWdRWOuOTQsJ9aAV3UPHv/REy9FeqQmul7i3SB4o
 pELDQ4NDuWozXXm5uHDG+mAmjAMLdVPoTK+2QldGUd1c7mVd9qnawe6UbByqtUWj+vmb
 3of1awdq8ffKWwG5J54n8ZU15I83xSSPS00pSONasUvvZ8kkcpHwXKAqVWSdy3MmN3Cr
 LQEZM9XKJDriiJi3xSZpvppNs/fR/kM1A6l89xEWY6zyHJ63jX0v8TB8tyesfspxwy+T
 oyzQ6AaLAtudSnxFJUUsCX+NEav8AT678AI+1/L7BYFjHz+BkPd4weo/Y2rk6Z4J0fuv
 X6zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBoPEVXy7o5Uls6bkmLYnTAKNNE0/dtvOtvs/MEtKpDpFub6zka3uUF2TEJGIMu4jwA215YJr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxY6KvFM2UuH+ZideQwc42RFzzaYe+rwhMWSmqwhS4IOVKdiFhK
 fuiiR3f3Bnft/QceOnV7aICispky/HZSdCVwUoNpWMePv8nkwswp
X-Gm-Gg: ASbGncs2zWS/3yKhIKook7hoHiiFxW2jR3yeFAc7W0yGOu0qPZ/osaEV2QyzNFN7VqU
 0XZSdy8z9BRKVVTqjn5MnWIPQulqUuierF2j2nJWO0cTKpurEzY+kZSZVMWAy70istRn7b22CbN
 lOY+F543q47dlt7B1NxceZMT+iZlTsHE7ibKEvDfRBexkBpFzT3/+q6jHBmc5U7/iDffCFgTjfD
 Lm8QHmG1UL/7LShVs2PugJIM+/gCFLRsl/VLFdpzvCZiWV5sSufXRvVMe9HizNv242G3KyR6GMW
 2ixS/D8n4tUwrJuafmgFiycHBifWhYsb6x2g0unnlmvLIChDSITuE5XyGw==
X-Google-Smtp-Source: AGHT+IGm4qgTk9PE/katCHJjFK/MZA7g0JRPykH2gXwP0NATWvZ+l6MJx+Q2hIE+tCg4djmDKl78NA==
X-Received: by 2002:a05:600c:154e:b0:43b:d1ac:13 with SMTP id
 5b1f17b1804b1-43c5ce45da2mr28064405e9.30.1741355301591; 
 Fri, 07 Mar 2025 05:48:21 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:21 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 8/8] drm/amdgpu: add cleaner shader trace point
Date: Fri,  7 Mar 2025 14:48:16 +0100
Message-Id: <20250307134816.1422-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
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
index dc10bea836db..73c1c97c9b28 100644
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

