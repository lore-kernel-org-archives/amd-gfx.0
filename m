Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F6ECCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D6310E2EF;
	Thu,  6 Nov 2025 13:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ah9VuHuc";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563DE10E2EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 13:06:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47754547a38so7515045e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762434400; x=1763039200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vjqFuZ5h5ovUDGmFRUqsYuVQzjkagbR0oSSbYUbU4Ys=;
 b=Ah9VuHuc981MnZC7F34jrS8e1M4805xXOwjQ1R9N9PgsAhM8HzyR3cfG0cOxFIGOzw
 HFo9hRhMVKTejgEhwW1BMrdj3zYrT2GkQ8G+QguFQUZrH8M1ZPiAQ3alCbHxZHlHIMXf
 /iAEsRR+CpTUJe2ECd8G3keF4FAj0zBNYRKlmcV98vSZtdNNKKtqj9SOCs47dgAwE69m
 nnA3/YS5Aw5uBxw9O/9sD3tYOxDWCGPXsNq0Au3WasTD841Ky6Q4Ys+Zs39Gme8DjXFv
 9m0dPpisverOs1w3J29WXf2mq181v1ItGS01qK/WGvj8D1eKlDJyGx6fPmbdJr1i/mW2
 0DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762434400; x=1763039200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjqFuZ5h5ovUDGmFRUqsYuVQzjkagbR0oSSbYUbU4Ys=;
 b=USB+QVdsM6cLjvCXOagjJfCskWMqGf4YX6fmWgrpgry1JbcSoyxDY6oZ6B4+Kb7CLn
 toFPlGpehHeOaM1L98zMSp/8TFogjZZNM8bZw8xYME6vSh1W1GJO5sPD+1jQ1dvSW0pz
 CqKQx55rYlGiicN/uozaeEFE3cjbRDdgiuoBAYiVN1ounQfIF7gk7c5toULmbVQeDkzf
 pLikM9qVWQKvxxCbYRnLKkEztzDu849U1mpI3KtTzECDQcr6vn/RYDJrtLAZkTO49tpE
 W7SvIFRXHatDrzz1l+O5z08cOVS9diAhuDiffNbiytKvBeWlH0eVwexkZFUNzvAy4ROy
 CBhg==
X-Gm-Message-State: AOJu0YzgMcd5pwznqN2PMhc7dC4Xx/R6QNzFYoXAzufGbAakn4RPBAAr
 xnzfZzRM/alA8/mkJlNbJ84FLls2lhMF6ahMcsiyR+BSi+h6FFwyd74sVeiHkp+B0xc=
X-Gm-Gg: ASbGncvbtTmQ2Fw83QeJyOEKayWSLn0cGoxLCCStqT4BPLRYOY/k8W59/T6tRWhuBcZ
 ekvD4UYAYYGvFcaT8zmgg5bkTgCDPN+3/nWvh2u+5XtVviGKsb0ml7JW502AI9j3RGBktTlFCef
 jeHHKbiPvlvtRQzFV6bloVhn7Bs+A21MVnkpHyJWC5N86TpLMlWTNY1zYAU1Q8GFxrEM2T1Q+xm
 PTBUv/Y84aGamDrM+Ih+/hFw/ghOt/M4awq5mDLiE7ZEjhTyyh4fNA8qfRxUkeM3thg31B5omOn
 eigpXs9EJvIVsKcasboMee2OGF4lFxkWy4mjYiDWkVjGhU/XT1QExjuZZdVPuOBPIziNopDuLWP
 ZPhyUpsyAbAbo4kJOOlRi1VAlewoW2I7fmPatl6UY6s6cq/lJ8gVa6YULA90SNtfTAhE/fls/KF
 3aN8SNFACkcUiKouwLXAYTJMm/Gsue+pO1zw==
X-Google-Smtp-Source: AGHT+IExS7fZlogKbe1umPY7Y4pkBQ5rxWELgjQClS3ryp3Z19zGGoHfK2InF2KmXq1t5mlIyOQibg==
X-Received: by 2002:a05:600c:4e8e:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-4775cdc5416mr61567395e9.11.1762434400188; 
 Thu, 06 Nov 2025 05:06:40 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:151c:500:cbed:dc34:903c:1eab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e4f13dsm15710095e9.5.2025.11.06.05.06.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 05:06:39 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: use GFP_ATOMIC instead of NOWAIT in the
 critical path
Date: Thu,  6 Nov 2025 14:06:37 +0100
Message-ID: <20251106130637.2187-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106130637.2187-1-christian.koenig@amd.com>
References: <20251106130637.2187-1-christian.koenig@amd.com>
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

Otherwise job submissions can fail with ENOMEM.

We probably need to re-design the per VMID tracking at some point.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/4258#note_3179934
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 5f94a66511af..ecf2b1f13ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -286,7 +286,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	* user of the VMID.
 	*/
 	r = amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finished,
-			      GFP_NOWAIT);
+			      GFP_ATOMIC);
 	if (r)
 		return r;
 
@@ -346,7 +346,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		 */
 		r = amdgpu_sync_fence(&(*id)->active,
 				      &job->base.s_fence->finished,
-				      GFP_NOWAIT);
+				      GFP_ATOMIC);
 		if (r)
 			return r;
 
@@ -399,7 +399,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			/* Remember this submission as user of the VMID */
 			r = amdgpu_sync_fence(&id->active,
 					      &job->base.s_fence->finished,
-					      GFP_NOWAIT);
+					      GFP_ATOMIC);
 			if (r)
 				goto error;
 
-- 
2.43.0

