Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4ACD8C80
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5086A10E853;
	Thu, 13 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2lpBLAA";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1429F10E83E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:45 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so1502731a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045623; x=1763650423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NKmnEQ/nUI33x0xsdd1mSPqaJsxAwU8yNUcMzUe1VSA=;
 b=j2lpBLAAAPJkzvBYkJnjkgLpmE0UU6R8SmPEQukPBRLnRVE3rSWcZlDs2ELHQSgz72
 q2XPwjES9WiVhfNoe0XBzAXPH6bVLQIPP+N6PAqL4xP4YB4h/sfC6nlbioVMLnav4RRA
 LH1qaPK1FG8yi4rxWdNFzhVVkDWiI0fa+CFgAOn0OL4AYWnzd67vNtWvKieY/uPkKnq0
 OgPfJZV04wy5e5Zp3tDJvqbgTnexpi0Vy7pc7K3CIx7sLP7PxelT2G3H4Xa0b/tlchhd
 OBN3S9YoXWlIp9xuiGniwyn+oNfmqt8U03wMfnItiA8uKJLc67SW6gkPPf75qlFXD+Uy
 vSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045623; x=1763650423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NKmnEQ/nUI33x0xsdd1mSPqaJsxAwU8yNUcMzUe1VSA=;
 b=mYuwzRIpX8YpbIeAIH0+kwQ99bjEfRfTsTupzhABq4lo2Y7PKyWQ5uBR45V3b/55uW
 MlgMGPVYdPrjrxTn7ebh1E/fv1lVQRa/XjCbgn+u7Yf8s4TlPqRG8gWtdRZ0FWnpBpkH
 IH6VgOxlPpX0PI1JyxYFhA8CleBawUEiLXDswpMu7yrykDHecIOYqHyWSXI+C/CkoQbR
 TnCvd7D6AvTOk9TsDVscH1l6P37FOWmZ//s6jkAxPUciAy4CgJCXL48DOideEqebql87
 aZv4OBWqSoADM7mVApjcHFIxVFHvh8FJM2QOCV8Il4OS1oBui6Tul6Zq9JxG4HOiQSI/
 /SVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxj7qzo55a/i79FpG2wxrZlS4nI9zezEuiq4DZxKqZR7SKSUwqW7hp5CLO1VBDtmG/FImrEHNO@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyc5XN5SsoVQS7Ta6+PEYNQMzR62DIoVxGs4rBbxEaXg7O1MHby
 gLjUsibvv1VDrf4OAnbTuZntUsT+VnFvgPBLMLJXAjYKSLWFGoiIZdPv
X-Gm-Gg: ASbGncv2wd6610a11cGd96lw93GcqCHji8HWGVWX2F7QHwo7xQv1w7TnVo6fFZz/din
 3nWvNmVKCEq4WCxJk5LxNy4cUY06nWnA7deLs1zabQs0vNi0uBNZZC/eRm9pux0KBZEDDQXBIgT
 7T4ieZ6JKyltL+8gQEsmK2THNqJw2NF2HIPRWAtUvRKVRMe6jLtDkgAbgpd9V9s0fHRbvoB41dy
 pAFlLPLB2ajf7NdtHr2tk2w7G1hOX1Ja7XR/Lm0Gap7/15AGyYr9kWhVTxO4vBSZjyLrgsEyRJe
 Rv4FZCrzuSdBg+bY1REU7j27LgEYzMs8o2rZUMJPj6Qjp3q4k/t+AS4K+/scDmcpqKZaaKP37B2
 kYQdiQBfCKKBwHO8Au585gpRgknaqRZrILqV3brmToZTo+yYYmIxGOWz0v/xskEzS4UR2D1Llga
 NNFNlwgDt+now=
X-Google-Smtp-Source: AGHT+IGg++u+GaHI/MTXIjLOGncykPNSekn7i6/RimPgdNfxQMkJ6YRb52ePk8VS7b1+3/78EaXHzQ==
X-Received: by 2002:a17:907:7f8c:b0:b30:c9d5:3adc with SMTP id
 a640c23a62f3a-b7331aaad1cmr676555866b.49.1763045623545; 
 Thu, 13 Nov 2025 06:53:43 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:43 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 11/18] drm/amdgpu: independence for the amdgpu_eviction_fence!
Date: Thu, 13 Nov 2025 15:51:48 +0100
Message-ID: <20251113145332.16805-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

This should allow amdgpu_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..95ee22c43ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -167,9 +167,8 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
-	spin_lock_init(&ev_fence->lock);
 	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
-			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
+			 NULL, evf_mgr->ev_fence_ctx,
 			 atomic_inc_return(&evf_mgr->ev_fence_seq));
 	return ev_fence;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..fb70efb54338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -27,7 +27,6 @@
 
 struct amdgpu_eviction_fence {
 	struct dma_fence base;
-	spinlock_t	 lock;
 	char		 timeline_name[TASK_COMM_LEN];
 	struct amdgpu_eviction_fence_mgr *evf_mgr;
 };
-- 
2.43.0

