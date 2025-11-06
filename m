Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D587CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 13:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD5310E141;
	Thu,  6 Nov 2025 13:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXEQp2zn";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0AF10E141
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 13:06:40 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47112a73785so6120255e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 05:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762434399; x=1763039199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KuP1tX9bFfy2LxhPyrTfgTHZJBEVJRKPahcwkS5YzNg=;
 b=CXEQp2znmV/hkJQ9kgOKW3OTNdbjtGcCusBrMuR/eSfWPycv5YDTHy5M7HF2mJ3Utz
 J2NiUBYga2D3OxLY4iZyUtuNc/Z9BPE4HaY3MI00KloPhxT/r1mQOhoUAWdD1KA9YfLm
 F7yau5TboU+J1tDHMAVlk8xIgD/XbzvyXmrzCitEiAFsZFxcWKjlPOESr1EJE9pX29ZP
 tUexeOFPy9/YytSeC4KI2U10bVr+rlhJdC+Ym5b/+OSJgSB/bGLzYMkEnjSIhm3Gmgi3
 F09JR44HpBlItbaDoDgqxKUdB8tPACYA8q0hc5WbQbYi8gkYtADkvl5X7YAGWx85Y6+O
 GHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762434399; x=1763039199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuP1tX9bFfy2LxhPyrTfgTHZJBEVJRKPahcwkS5YzNg=;
 b=AZ2C8x5a1x5hdc/e28ecOlCNXOfUGZUHY11mXTOLo1Zk24MRdVnS8G4bebbT3iIdfB
 nocSVzdI8a58HtWZ33hfwS/UGreXacl62dHNo/W/OGZRic017lINtSg8MOMWgmKIh5YZ
 /EAJwIZjgGGwW6C6Q2LVRLcz95p/x2dN4NX7svsB2ErLn5NkHU4iEyjNNy6hARswNf+l
 Wjy3IFdTvAkOka6/5rkw41fnZJLWvKGzzFS7YCB3QuIi8+/nAfe/Jeg06aDwivYA8IPr
 YxtI3b0BWM3msbc891TGOwcMWiHo0dzNkFOI0L3K1lo5KxbMIpL6vnukvjQr939arhe8
 DIuw==
X-Gm-Message-State: AOJu0YyYNLkAj7k8gVnf2dUz5UWDMv9UA5Vd0fNCui6b4Pl7KmpW4CK3
 Lz3Dc9L6L+nOj+XFq/GkOW+rOMzhj2bPb9nhmIq4WBVKmniOFPeEbJEG6sTdiQ==
X-Gm-Gg: ASbGncvh5kWEtcOBbnJS2PSZ+vlbQWE7QnOhAbD34sosuMYS7w9zKRC40MTbKnTPDYk
 J1yx3H7nHofNN1uDJuZ0Se1yMus8cKUX5NwjpQ5I4bv8dvpXYy/tRZRkuJ2BYPuQwmYWM7dlp+w
 0pH7FuFdmZSw8XuCLW0hh5FUtVQslrc6WrOvwhK2LSPoerHhJJfLiwX+PAYmKCPlwSflQK3vQWI
 1FbBVt65woAI3C4XUsi/SjcQMqROblAkjHy+RSYnNhTmRIyFAoa7ZycPI18z9K2MsT0PQ9wInr4
 8sYb7sC4UzPJ3BasodQ//QeGyuHpgz3vkW/6UM9Yy8nvegcM7io3hYgbGn6ZN7qBNcxqImla6RA
 TeKWG4LpPYVDiAvoGqsjg0z8ldZvLrrWdISh/zePLCWodnIC0GhuxMLxSQXsXefvWt6uY3/7E0t
 /mOK3jJjN03Bgw
X-Google-Smtp-Source: AGHT+IEcycMgl85+o5JD2nwV5a0asbOzFzdbje+x2FQoixbsjUsnbwDbSnmraFmJ10QnrsT+sYNu3g==
X-Received: by 2002:a05:600c:474e:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-4776a911bcfmr7476555e9.10.1762434398770; 
 Thu, 06 Nov 2025 05:06:38 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:151c:500:cbed:dc34:903c:1eab])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e4f13dsm15710095e9.5.2025.11.06.05.06.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 05:06:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: avoid memory allocation in the critical code
 path
Date: Thu,  6 Nov 2025 14:06:36 +0100
Message-ID: <20251106130637.2187-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

When we run out of VMIDs we need to wait for some to become available.
Previously we were using a dma_fence_array for that, but this means that
we have to allocate memory.

Instead just wait for the first not signaled fence from the least recently
used VMID to signal. That is not as efficient since we end up in this
function multiple times again, but allocating memory can easily fail or
deadlock if we have to wait for memory to become available.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 51 ++++++-------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 3ef5bc95642c..5f94a66511af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -201,58 +201,31 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-	struct dma_fence **fences;
-	unsigned i;
 
+	/* If anybody is waiting for a VMID let everybody wait for fairness */
 	if (!dma_fence_is_signaled(ring->vmid_wait)) {
 		*fence = dma_fence_get(ring->vmid_wait);
 		return 0;
 	}
 
-	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_NOWAIT);
-	if (!fences)
-		return -ENOMEM;
-
 	/* Check if we have an idle VMID */
-	i = 0;
-	list_for_each_entry((*idle), &id_mgr->ids_lru, list) {
+	list_for_each_entry_reverse((*idle), &id_mgr->ids_lru, list) {
 		/* Don't use per engine and per process VMID at the same time */
 		struct amdgpu_ring *r = adev->vm_manager.concurrent_flush ?
 			NULL : ring;
 
-		fences[i] = amdgpu_sync_peek_fence(&(*idle)->active, r);
-		if (!fences[i])
-			break;
-		++i;
-	}
-
-	/* If we can't find a idle VMID to use, wait till one becomes available */
-	if (&(*idle)->list == &id_mgr->ids_lru) {
-		u64 fence_context = adev->vm_manager.fence_context + ring->idx;
-		unsigned seqno = ++adev->vm_manager.seqno[ring->idx];
-		struct dma_fence_array *array;
-		unsigned j;
-
-		*idle = NULL;
-		for (j = 0; j < i; ++j)
-			dma_fence_get(fences[j]);
-
-		array = dma_fence_array_create(i, fences, fence_context,
-					       seqno, true);
-		if (!array) {
-			for (j = 0; j < i; ++j)
-				dma_fence_put(fences[j]);
-			kfree(fences);
-			return -ENOMEM;
-		}
-
-		*fence = dma_fence_get(&array->base);
-		dma_fence_put(ring->vmid_wait);
-		ring->vmid_wait = &array->base;
-		return 0;
+		*fence = amdgpu_sync_peek_fence(&(*idle)->active, r);
+		if (!(*fence))
+			return 0;
 	}
-	kfree(fences);
 
+	/*
+	 * If we can't find a idle VMID to use, wait on a fence from the least
+	 * recently used in the hope that it will be available soon.
+	 */
+	*idle = NULL;
+	dma_fence_put(ring->vmid_wait);
+	ring->vmid_wait = dma_fence_get(*fence);
 	return 0;
 }
 
-- 
2.43.0

