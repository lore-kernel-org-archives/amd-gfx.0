Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55EC282DE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2033B10EB65;
	Fri,  7 Mar 2025 13:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c3aO9W+y";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4D710EB62
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:22 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3910e101d0fso1037497f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355301; x=1741960101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QdwwAAdMd2Ol4HlOmPtjB8wS2mXSUPeXNMrnQBh8Pzg=;
 b=c3aO9W+yxn5j7xfkW1wsF6rNRsEdLqZUk1eF3eF1ZGrdG+iXqqm+wGdGnzDYC7+9CS
 1DoDo8VD7LJx5remYNac5SCbQv/2X1mucEop/cygC/+MaPsAm3DMFjKbWCBU1NokWx5F
 Hx2v+gZvorWXV+jIqPM4MNafGerbseeqlTYUSCVLalmFNfEAEWzWHk5Eg+NcUmL+FBHq
 gWsDgnGvQ7z1Ukaj/p8NQ+m0zQXTToqMGrC1u/hzRAZdLUNGlrXPWZcZq7G/j5l79Ocy
 HqsPDZP9SiOoLRE5Wa0yVKGFxjP7U6+oxDkAOSc76VpnJoPdr8yR+UASGEOrvrMIi3DC
 tR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355301; x=1741960101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdwwAAdMd2Ol4HlOmPtjB8wS2mXSUPeXNMrnQBh8Pzg=;
 b=mvxx25688dNWWKc3pv5DEaalrdPwRah27+NxmmWJZSU++t26s9jXCsw+aBB6+WZgKC
 lAfUuaCuGsfYDkcTxb09ULTFGPRsOjR8YTy8PGdu2C48NnXVYgSt6wlbEOXAcwqR9ejg
 I6/4xufqMM2IUmqUphkoXib+qWKIUci1JBrdk7GayKTHiGzvfO0cxURazVb791tF1sFk
 7i+gAso04coT5KoB+6AGlUfLhh8k3kitAEuRH5gmFwRPLZn91cUaHufGX+fgR2t4NvRm
 mPL37i1NQqacFdHhWGP0cduglNAyvRZ7vz2iqBiM9abFQo6XTgafyNyw01Jnt14+3gX8
 2bCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2IhvopSR05xhjtcigMOk/ootdN9omRWLVAPSQZwfD41L2hzTFOhA2rXoakMGCTeRUq6nJb6W8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLUfa3Zxq9ECGMxQwb5iQH7ewZjWMVl3Hk74jes2uBR6tAnLz0
 sRtSf60iNV3AmXAkghdaHIOxdtONyzZZ42nnEvc6oyKMN9kQkWi1e2MxSqXorQc=
X-Gm-Gg: ASbGncuKwUzlz2PfGO0WZKnrAJkB1MW4+AoClfesH2agwRUnbs6QlcVE5GVfdN3vM+9
 Gf6OiQoOW5rQT7ogynQMxeJj3rfco7OUig3JSFwx7K4iKtm76R5xGnaXWeOsarI4U15B2iBJh9L
 M9s5DkbXnLao1RyP+f55gNRpsBoZw4xWzcjf2eYLuNUKsgV7gMdXupMzVhgjXfj5Vl8Ruw8xwSA
 VbH+g7ZPycu74VLmDmLtpZmZHMTTofO5Eq9/Ry/maJTAv4H6j5AVvMgmZJjzcPE3LFPaArFzfBI
 g2wOsxX+1fZtvSpmQ1hDoz6UBjkMkt/ujFV8KzK0jjkvZvN1aUAXMKRKcA==
X-Google-Smtp-Source: AGHT+IHbgSKqGDs5bsMN32xo9MPw2hc5c/VAlMDrsOXkOx3zvli6D3v79J0veFQZnX1cM910/1RE8g==
X-Received: by 2002:a05:6000:402b:b0:38d:e401:fd61 with SMTP id
 ffacd0b85a97d-39132db746amr2021131f8f.49.1741355301032; 
 Fri, 07 Mar 2025 05:48:21 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:20 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 7/8] drm/amdgpu: add isolation trace point
Date: Fri,  7 Mar 2025 14:48:15 +0100
Message-Id: <20250307134816.1422-7-christian.koenig@amd.com>
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

Note when we switch from one isolation owner to another.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3fa7788b4e12..c1e2ba96509f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6988,6 +6988,7 @@ struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
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

